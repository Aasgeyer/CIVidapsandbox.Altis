If (!isServer) exitWith {};

_debug = missionNamespace getVariable ["MIS_debugMode",false];
_todeletearray = [];

//random destination
_nonActiveOutposts = MIS_idapoutposts select {
    !(_x getVariable ["AAS_IDAPOutPostActive",false])
};
If (count _nonActiveOutposts == 0) exitWith {
    If (_debug) then {
        systemChat "Water script exited, since no available outposts found...";
    };
};
_destination = selectRandom _nonActiveOutposts;
_destination setVariable ["AAS_IDAPOutPostActive",true];
_ObjArray = _destination getVariable "AAS_IDAPOutpostObjectArray";
{
    _x hideObjectGlobal false;
    _x enableSimulationGlobal true;
} foreach _ObjArray;
_markerArray = _destination getVariable "AAS_IDAPOutpostMarkerArray";
{
    _x setMarkerAlpha 1;
} foreach _markerArray;

//determine time
_dist2d = _destination distance2D markerpos "marker_idapbase";
//assuming 50 km/h and some leeway
_speed = 50/3.6; //transform to m/s
_leeway = sqrt(_dist2d)*2+37;
_etaDelta = _dist2d/_speed + _leeway;
_loseTime = time + _etaDelta;
_timestr = [_etaDelta, "MM:SS"] call BIS_fnc_secondsToString;
_daytimestr = [daytime+_etaDelta/(60^2), "HH:MM:SS"] call BIS_fnc_timeToString;

//create task
_parentTask = "TaskWater";
_curNrTasks = count (_parentTask call BIS_fnc_taskChildren) + 1;
_TaskID = format ["%1_%2",_parentTask,_curNrTasks];
_locationName = _destination getVariable ["AAS_LogicLocationName","the designated location"];
_TaskTitle = format ["Water Shortage (%1)",_curNrTasks];
_TaskDescription = format ["
The people in %1 are in need of additional water supplies. Bring a water truck to their location.
Be fast as they are awaiting it eagerly. You have time until %2 (%3).
", _locationName, _daytimestr, _timestr
];
_TaskMarker = "";
[
    true,
    [_TaskID,_parentTask],
    [_TaskDescription,_TaskTitle,_TaskMarker],
    getpos _destination,
    "AUTOASSIGNED",
    0,
    true,
    "default"
] call BIS_fnc_taskCreate;

//execute FSM
[_TaskID,_todeletearray,_destination,_loseTime] execFSM "taskFSM\taskWater.fsm";