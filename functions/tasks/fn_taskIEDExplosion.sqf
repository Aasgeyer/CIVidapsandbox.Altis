If (!isServer) exitWith {};

_debug = missionNamespace getVariable ["MIS_debugMode",false];
_todeletearray = [];

//select a random location
_randomLocation = selectRandom MIS_locationsCar;
If _debug then {
    diag_log format ["_randomLocation: %1",text _randomLocation];
};

//find a road in that location
_radiusLocation = (selectMax size _randomLocation) * 0.75;
_roadInLocation = position _randomLocation nearRoads _radiusLocation;
_roadInLocation = _roadInLocation select {
    _y = _x;
    _activeOutposts = MIS_idapoutposts select {_x getVariable ["AAS_IDAPOutPostActive",false]};
    _activeOutposts findIf {_x distance2D _y < 150} == -1
};
_roadInLocation = selectrandom _roadInLocation;
If _debug then {
    diag_log format ["_roadInLocation: %1",_roadInLocation];
};
_roadPos = getpos _roadInLocation;

//set up IED and detonate it
_roadinfo = getroadinfo _roadInLocation;
If _debug then {
    diag_log format ["_roadinfo: %1",_roadinfo];
};
_roadinfo params ["", "_width", "", "", "", "", "_begPos", "_endPos", "_isBridge"];
_roadDir = _begPos getdir _endPos;
_roadSidePos = _roadInLocation getpos [_width*random [0.2,0.35,0.6],_roadDir + selectRandom [90,-90]];
If _debug then {
    diag_log format ["_roadSidePos: %1",_roadSidePos];
};

_actionPool = ["GestureAgonyCargo"];
_civArray = [];
_woundedCivArray = [];
//create Civilian casualties
for "_c" from 1 to ceil random [2,4,10] do {
    _civGroup = createGroup [civilian,true];
    _civ = _civGroup createUnit [selectRandom CivUnitPool, _roadSidePos, [],50,"NONE"];
    _civ setdir random 360;
    _civ switchAction "CivilLying";
    _civArray pushBack _civ;
    _todeletearray pushBack _civ;
    _damage = linearConversion [25,50,_civ distance _roadSidePos,1,0,true];
    _civ setDamage _damage;
    _civ playAction "Panic";

    /*0 = _civ spawn {
        _this allowDamage false;
        sleep 4;
        _this allowDamage true;
    };*/

    switch (true) do {
        case (_damage <= 0.25): {
        };
        case (_damage > 0.25 && _damage < 1): {
            /*0 = _civ spawn {
                _initDamage = damage _this;
                waitUntil {damage _this < _initDamage OR !alive _this};
                _this playAction "agonyStop";
                _this enableAI "ALL";
                _this move (_this getpos [random [199,200,250],random 360]);
            };*/
        };
        case (_damage >= 1): {
            systemChat "Dead Civ";
            _woundedCivArray pushBack _civ;
        };
    };
};

_IED = createMine ["IEDUrbanBig_F",_roadSidePos,[],0];
_IED setDamage 1;

//create marker on IED position
_marker = createMarker [format ["marker_IED_%1",_roadSidePos],_roadSidePos];
_marker setMarkerTypeLocal "mil_objective";
_marker setMarkerText "IED Explosion";
_todeletearray pushBack _marker;
If (_debug) then {
    _marker = createMarker [format ["marker_IED_%1",_roadPos],_roadPos];
    _marker setMarkerType "mil_dot";
    _todeletearray pushBack _marker;
};

//create task
_parentTask = "TaskIEDExplosion";
_curNrTasks = count (_parentTask call BIS_fnc_taskChildren) + 1;
_TaskID = format ["%1_%2",_parentTask,_curNrTasks];
_mapgrid = mapGridPosition _roadPos;
_locationName = text _randomLocation;
_titleParent = ((_parentTask call BIS_fnc_taskDescription) select 1) select 0;
_TaskTitle = format ["%1 (%2)",_titleParent,_curNrTasks];
_TaskDescription = format ["
We got calls of an explosion near %1. Go there and treat whoever is wounded and
 put those in a body bag that didn't survive and bring them back to base for identification.
 You may want to use a drone with thermal iamging to find all victims of the explosion.
",
    _locationName
];
_TaskMarker = _marker;
[
    true,
    [_TaskID,_parentTask],
    [_TaskDescription,_TaskTitle,_TaskMarker],
    _roadPos,
    "AUTOASSIGNED",
    0,
    true,
    "default"
] call BIS_fnc_taskCreate;

//execute FSM
_fsmPath = format ["taskFSM\%1.fsm",_parentTask];
[_TaskID,_todeletearray,_civArray,_woundedCivArray,_roadPos] execFSM _fsmPath;