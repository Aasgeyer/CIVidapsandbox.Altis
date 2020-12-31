If (!isServer) exitWith {};

_debug = missionNamespace getVariable ["MIS_debugMode",false];
_todeletearray = [];

//random position near houses
_radiusHouses = 150;
_randomPos = [0,0];
_try = 0;
while { _randompos isequalto [0,0] && _try <= 25} do {
    _randomPos = [
        ["marker_AO_1"],
        ["water",[markerpos "marker_idapbase",500]],
        {
            _counthouses = {count (_x buildingPos -1) > 2} count (_this nearObjects ["house",_radiusHouses]);
            _counthouses >= 5
            && MIS_idapoutposts findIf {
                _x distance2D _this < _radiusHouses*4
                && (_x getVariable ["AAS_IDAPOutPostActive",false])
            } == -1
            && MIS_restrictedAreas findIf {_this inArea _x} == -1
        }
    ] call BIS_fnc_randomPos;
};

If (_randomPos isEqualTo [0,0]) exitWith {
    If _debug then {
        systemChat "No Position found, exiting medicalemergency script...";
    };
};

_OutpostsClose = MIS_idapoutposts select {_x distance2D _randomPos < 1000};
{
    _x setVariable ["AAS_IDAPoutpostActive",true,true];
} forEach _OutpostsClose;

_areamrk = createMarker [format ["marker_evacuateArea_%1",_randomPos],_randomPos];
_areamrk setMarkerShapeLocal "ELLIPSE";
_areamrk setMarkerColorLocal "ColorOrange";
_areamrk setMarkerBrushLocal "SolidBorder";
_areamrk setMarkerAlphaLocal 1;
_areamrk setMarkerSize [_radiusHouses,_radiusHouses];
_todeletearray pushBack _areamrk;

_attackerPos = [
    [[_randomPos,_radiusHouses*5]],
    ["water",[_randomPos,_radiusHouses*2]],
    {
        [objNull,"VIEW"] checkVisibility [_this,_randomPos] == 0
    }
] call BIS_fnc_randomPos;

If (_debug) then {
    _attackerMarker = createMarker [format ["marker_attacker_%1",_attackerPos],_attackerPos];
    _attackerMarker setMarkerTypeLocal "n_inf";
    _attackerMarker setMarkerColorLocal "ColorUNKNOWN";
    _attackerMarker setMarkerText "Attackers";
    _todeletearray pushBack _attackerMarker;
};

_fleePos = _randomPos getPos [500,_attackerPos getdir _randomPos];
If (_debug) then {
    _fleeMarker = createMarker [format ["marker_flee_%1",_fleePos],_fleePos];
    _fleeMarker setMarkerTypeLocal "hd_end";
    _fleeMarker setMarkerColorLocal "ColorCIV";
    _fleeMarker setMarkerText "Flee Point";
    _todeletearray pushBack _fleeMarker;
};

//spawn Civilians
_houses = (_randomPos nearObjects ["house",_radiusHouses]) select {
    count (_x buildingPos -1) > 2
};
_civEvacuteesArray = [];
_maxCivCount = 12;
{
    _y = _x;
    If ((random 1 < 0.5 && count _civEvacuteesArray <= _maxCivCount) OR _foreachindex < 2) then {
        _houseMarker = createmarker [format ["marker_house_%1",_y],_y];
        _houseMarker setMarkerTypeLocal "hd_unknown";
        _houseMarker setMarkerSizeLocal [0.5,0.5];
        _houseMarker setMarkerColor "ColorCIV";
        _bposarray = (_y buildingPos -1);
        {
            _expDistr = 1*exp(-(_foreachindex-0.0)*1);
            If (random 1 < _expDistr && count _civEvacuteesArray <= _maxCivCount) then {
                _civGrp = createGroup [civilian,true];
                _bpos = _x;
                _civ = _civGrp createUnit [selectRandom CivUnitPool,_bpos,[],0,"CAN_COLLIDE"];
                _civ setdir random 360;
                _civEvacuteesArray pushBack _civ;
                _todeletearray pushBack _civ;
                [
                    _civ,											// Object the action is attached to
                    "Send Away",										// Title of the action
                    "\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa",	// Idle icon shown on screen
                    "\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa",	// Progress icon shown on screen
                    "_this distance _target < 7 && alive _target",						// Condition for the action to be shown
                    "_caller distance _target < 25 && alive _target",						// Condition for the action to progress
                    {// Code executed when action starts
                        params ["_target", "_caller", "_actionId", "_arguments"];
                        _saymessage = format ["IDAP_fleeOrder_%1",ceil random 3];
                        [_caller, _saymessage] remoteExec ["directSay",_caller];
                    },													
                    {},													// Code executed on every progress tick
                    {// Code executed on completion
                        params ["_target", "_caller", "_actionId", "_arguments"];
                        _arguments params ["_attackerpos","_defenderPos"];
                        _saymessage = format ["C_FleeComply_%1",ceil random 3];
                        [_target, _saymessage] remoteExec ["directSay",_caller];

                        _dirToAttackerPos = _defenderPos getdir _attackerpos;
                        _safePosArray = [];
                        for "_s" from 90 to 270 step 180 do {
                            _safepos = _defenderpos getpos [500,_dirToAttackerPos + _s];
                            _safePosArray pushBack _safePos;
                        };
                        _distanceArray = _safePosArray apply {_x distance2D _target};
                        _indexMin = (_distanceArray call CBA_fnc_findMin)#1;
                        _safePos = _safePosArray select _indexMin;
                        _debug = missionNamespace getVariable ["MIS_debugMode",false];
                        If _debug then {
                            _marker = createMarker [format ["marker_safepos_%1",_target],_safepos];
                            _marker setMarkerType "mil_end";
                            _marker setMarkerText groupID group _target;
                            0 = _marker spawn {
                                sleep 5;
                                deleteMarker _this;
                            };
                        };
                        _target move _safePos;
                        _target playAction "Panic";
                        _target setVariable ["AAS_civEvacuated",true,true];
                        _target setBehaviour "CARELESS";
                        _target setUnitPos "UP";
                    },				
                    {},													// Code executed on interrupted
                    [_attackerpos,_randomPos],													// Arguments passed to the scripts as _this select 3
                    2,													// Action duration [s]
                    0,													// Priority
                    true,												// Remove on completion
                    false												// Show in unconscious state
                ] remoteExec ["BIS_fnc_holdActionAdd", 0, _civ];	// MP compatible implementation
            };
        } foreach _bposarray;
    } else {
        If (random 1 < 0.5) then {
            _houseMarker = createmarker [format ["marker_house_%1",_y],_y];
            _houseMarker setMarkerTypeLocal "hd_unknown";
            _houseMarker setMarkerSizeLocal [0.5,0.5];
            _houseMarker setMarkerColor (["ColorCIV","ColorBlack"] select _debug);
        };
    };
} foreach _houses;
_nrOfCivs = count _civEvacuteesArray;

//determine time
_dist2d = _randomPos distance2D markerpos "marker_idapbase";
//assuming 40 km/h and some leeway
_speed = 40/3.6; //transform to m/s
_leeway = sqrt(_dist2d)+37;
_etaDelta = _dist2d/_speed + _leeway + 10*_nrOfCivs;
_loseTime = time + _etaDelta;
_timestr = [_etaDelta, "MM:SS"] call BIS_fnc_secondsToString;
_daytimestr = [daytime+_etaDelta/(60^2), "HH:MM:SS"] call BIS_fnc_timeToString;

//spawn conflict parties
_defenderPool = selectRandom [AAS_RegularSoldierPool,AAS_GuerillaSoldierPool];
_attackerPool = [AAS_RegularSoldierPool,AAS_GuerillaSoldierPool] select (AAS_RegularSoldierPool#0 isEqualTo _defenderPool#0);
_defenderSide = [west,independent] select (AAS_RegularSoldierPool#0 isEqualTo _defenderPool#0);
_attackerSide = [independent,west] select (AAS_RegularSoldierPool#0 isEqualTo _defenderPool#0);
_attackstarttime = random [_loseTime*0.8,_loseTime,_loseTime*1.2];

_defenderSize = ceil random [5,12,20];
_defenderUnits = [];
for "_d" from 1 to _defenderSize do {
    _SoldierClass = selectRandom _defenderPool;
    _defenderUnits pushBack _SoldierClass;
};
_defenderGroup = [
    _randomPos, _defenderSide, _defenderUnits
] call BIS_fnc_spawnGroup;
_todeletearray pushBack _defenderGroup;
_defenderWP_1 = _defenderGroup addWaypoint [_randomPos,0];
_defenderWP_1 setWaypointStatements [format ["time > %1",_attackstarttime],""];
_defenderWP_1 setWaypointBehaviour "COMBAT";
_defenderWP_1 setWaypointCombatMode "GREEN";
_defenderWP_2 = _defenderGroup addWaypoint [_randomPos,0];
_defenderWP_1 setWaypointCombatMode "YELLOW";

_attackerSize = _defenderSize * ([1.5,3] select (west isEqualTo _defenderSide));
_attackerUnits = [];
for "_d" from 1 to _defenderSize do {
    _SoldierClass = selectRandom _attackerPool;
    _attackerUnits pushBack _SoldierClass;
};
_attackerGroup = [
    _attackerPos, _attackerSide, _attackerUnits
] call BIS_fnc_spawnGroup;
_todeletearray pushBack _attackerGroup;
_attackerWP_1 = _attackerGroup addWaypoint [_attackerPos,0];
_attackerWP_1 setWaypointStatements [format ["time > %1",_attackstarttime],""];
_attackerWP_1 setWaypointBehaviour "COMBAT";
_attackerWP_1 setWaypointCombatMode "GREEN";
_attackerWP_2 = _attackerGroup addWaypoint [_randomPos,0];
_attackerWP_2 setWaypointCombatMode "YELLOW";
_attackerWP_2 setWaypointType "SAD";

//create task
_parentTask = "TaskEvacuate";
_curNrTasks = count (_parentTask call BIS_fnc_taskChildren) + 1;
_TaskID = format ["%1_%2",_parentTask,_curNrTasks];
_TaskTitle = format ["Evacuation (%1)",_curNrTasks];
_TaskDescription = format ["
AAF and FIA are closing on on the designated area near mapgrid %1. Evacuate the local populace there!
 Expect %2 people there.
 You have time until ca. %3 (%4) before the fighting starts. If more than 50%5 
 of the civilians die, your task fails.
 (optional) Drop leaflets so that they flee without you searching for every single civilian there.
", mapGridPosition _randomPos, _nrOfCivs, _daytimestr, _timestr, "%"
];
_TaskMarker = _evacmrk;
[
    true,
    [_TaskID,_parentTask],
    [_TaskDescription,_TaskTitle,_TaskMarker],
    _randomPos,
    "AUTOASSIGNED",
    0,
    true,
    "default"
] call BIS_fnc_taskCreate;

//execute FSM
_fsmPath = format ["taskFSM\%1.fsm",_parentTask];
[_TaskID,_todeletearray,_civEvacuteesArray,_loseTime,_randomPos,_fleePos,_OutpostsClose] execFSM _fsmPath;