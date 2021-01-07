/*
    Author: Aasgeyer

    Description:
        Task Cargo Delivery.

    Parameter(s): None

    Returns: Nothing

    Example(s):
        [] call AAS_fnc_TaskCargo; //-> nothing
*/


If (!isServer) exitWith {};

_debug = missionNamespace getVariable ["MIS_debugMode",false];
_todeletearray = [];

//random destination
_nonActiveOutposts = MIS_idapoutposts select {
    !(_x getVariable ["AAS_IDAPOutPostActive",false])
};
If (count _nonActiveOutposts == 0) exitWith {
    If (_debug) then {
        systemChat "Cargo script exited, since no available outposts found...";
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

//random supply
_supplyneeded = selectRandom MIS_VanCargoObjectClasses;

//determine time
_dist2d = _destination distance2D markerpos "marker_idapbase";
//assuming 50 km/h and some leeway
_speed = 50/3.6; //transform to m/s
_leeway = sqrt(_dist2d)*2+37;
_etaDelta = _dist2d/_speed + _leeway;
_loseTime = time + _etaDelta;
_timestr = [_etaDelta, "MM:SS"] call BIS_fnc_secondsToString;
_daytimestr = [daytime+_etaDelta/(60^2), "HH:MM:SS"] call BIS_fnc_timeToString;

//calculate reward
_worldSizeR = sqrt 2 * (worldSize/2);
_funding = linearConversion [0,_worldSizeR,_dist2d,1000,10000];
_funding = round _funding;
_fundingStr = _funding call BIS_fnc_numberText;

//create task
_parentTask = "TaskCargo";
_curNrTasks = count (_parentTask call BIS_fnc_taskChildren) + 1;
_TaskID = format ["%1_%2",_parentTask,_curNrTasks];
_mapgrid = mapGridPosition _destination;
_destinationname = _destination getVariable "AAS_LogicLocationName";
_displayname = [configFile >> "CfgVehicles" >> _supplyneeded] call BIS_fnc_displayName;
_displayPicture = gettext (configfile >> "CfgVehicles" >> _supplyneeded >> "editorPreview");
_titleParent = ((_parentTask call BIS_fnc_taskDescription) select 1) select 0;
_TaskTitle = format ["%1 (%2)",_titleParent,_curNrTasks];
_TaskDescription = format ["
Deliver %1 to the IDAP workers at %2. You have time until %3 (%4)!<br/>
Reward: + %5$ to daily funding.<br/>
<img image='%6' width='114' height='59'/>
",
    _displayname, _destinationname, _daytimestr, _timestr,_fundingStr, _displayPicture
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
_fsmPath = format ["taskFSM\%1.fsm",_parentTask];
[_TaskID,_todeletearray,_loseTime,_destination,_supplyneeded,_funding] execFSM _fsmPath;