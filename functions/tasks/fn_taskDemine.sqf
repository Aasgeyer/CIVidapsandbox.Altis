If (!isServer) exitWith {};

_debug = missionNamespace getVariable ["MIS_debugMode",false];
_todeletearray = [];

//define inputs
_minefieldRadius = 50;
_mineCount = ceil random [_minefieldRadius/10,_minefieldRadius/6,_minefieldRadius/2];
_APmineTypePool = ["APERSMine","APERSBoundingMine"];
_ATmineTypePool = ["ATMine","SLAMDirectionalMine"];

//find position in AO
_randomPos = [
    ["marker_AO_1"],
    ["water"],
    {
        MIS_idapoutposts findIf {
            _x distance2D _this < _minefieldRadius*2
            && (_x getVariable ["AAS_IDAPOutPostActive",false])
        } == -1
        && MIS_restrictedAreas findIf {_this inArea _x} == -1 // not in restricted area
    }
] call BIS_fnc_randomPos;

_OutpostsClose = MIS_idapoutposts select {_x distance2D _randomPos < 300};
{
    _x setVariable ["AAS_IDAPoutpostActive",true,true];
} forEach _OutpostsClose;

//create marker over minefield
_minefieldMarker = createMarker [format ["mrkMinefield_%1",_randomPos],_randomPos];
_minefieldMarker setMarkerShapeLocal "ELLIPSE";
_minefieldMarker setMarkerBrushLocal "Grid";
_minefieldMarker setMarkerColorLocal "ColorRed";
_minefieldMarker setMarkerSize [_minefieldRadius,_minefieldRadius];
_todeletearray pushBack _minefieldMarker;

_mineCountMarker = createMarker [format ["mrkMineCount_%1",_randomPos],_randomPos];
_mineCountMarker setMarkerColorLocal "ColorRed";
_mineCountMarker setMarkerSizeLocal [0.5,0.5];
_mineCountMarker setMarkerTextLocal str _mineCount;
_mineCountMarker setMarkerType "mil_warning";
_todeletearray pushBack _mineCountMarker;

//create mines
_mineArray = [];
_APmineType = selectRandom _APmineTypePool;
for "_m" from 1 to _mineCount do {
    _mine = createMine [_APmineType,_randomPos,[],_minefieldRadius];
    _mineBlocked = lineIntersects [getposASL _mine, getPosASL _mine vectorAdd [0,0,5], _mine];
    If !(_mineBlocked) then {
        _mine setDir random 360;
        _todeletearray pushBack _mine;
        _mineArray pushBack _mine;
        If (_debug) then {
            _mineMarker = createMarker [format ["mrkMine_%1_%2",_randomPos,_mine],_mine];
            _mineMarker setMarkerColorLocal "ColorRed";
            _mineMarker setMarkerSizeLocal [0.35,0.35];
            _mineMarker setMarkerType "mil_warning";
            _todeletearray pushBack _mineMarker;
        };
    } else {
        deleteVehicle _mine;
        _m = _m - 1;
    }
};

//create task
_parentTask = "TaskDemine";
_curNrTasks = count (_parentTask call BIS_fnc_taskChildren) + 1;
_TaskID = format ["%1_%2",_parentTask,_curNrTasks];
_mapgrid = mapGridPosition _randomPos;
_titleParent = ((_parentTask call BIS_fnc_taskDescription) select 1) select 0;
_TaskTitle = format ["%1 (%2)",_titleParent,_curNrTasks];
_TaskDescription = format ["
There are reports of a minefield near map grid %1. Expect %2 to %3 mines there. Go clear it!
",
    _mapgrid, round (_mineCount*(random [0,0.9,1])), round (_mineCount*(1 + random [0,0.1,1]))
];
_TaskMarker = _minefieldMarker;
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
[_TaskID,_todeletearray,_mineArray,_mineCountMarker,_OutpostsClose] execFSM _fsmPath;