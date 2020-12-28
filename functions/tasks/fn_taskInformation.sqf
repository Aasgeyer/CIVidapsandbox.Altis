If (!isServer) exitWith {};

_debug = missionNamespace getVariable ["MIS_debugMode",false];
_todeletearray = [];

//select random location
_randomlocation = selectRandom MIS_locationsCar;
_randomHouse = nearestObjects [position _randomLocation,["House"],selectmin size _randomlocation];
_randomHouse = _randomHouse select {count (_x buildingPos -1) > 3};
_randomHouse = _randomHouse#0;

_marker = createMarker [format ["marker_information_%1",_randomHouse],_randomHouse];
_marker setMarkerTypeLocal "mil_objective";
_marker setMarkerText "Mayor";
_todeleteArray pushBack _marker;

//create Civ
_civGroup = createGroup [civilian,true];
_buildingPos = selectRandom (_randomhouse buildingPos -1);

_civ = _civGroup createUnit [selectRandom CivUnitPool,_buildingPos,[],0,"CAN_COLLIDE"];
_todeletearray pushBack _civ;
_civ setdir random 360;
_civ disableAI "ALL";
_civ enableAI "ANIM";
removeUniform _civ;
removeHeadgear _civ;
_civ forceAddUniform "U_Marshal";
_civ addHeadgear "H_Beret_blk";

[
    _civ,											// Object the action is attached to
    "Talk To Headmen",										// Title of the action
    "\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa",	// Idle icon shown on screen
    "\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa",	// Progress icon shown on screen
    "_this distance _target < 5 && alive _target",						// Condition for the action to be shown
    "_caller distance _target < 10 && alive _target",						// Condition for the action to progress
    {// Code executed when action starts
        params ["_target", "_caller", "_actionId", "_arguments"];
    },													
    {},													// Code executed on every progress tick
    {// Code executed on completion
        params ["_target", "_caller", "_actionId", "_arguments"];
        _this call AAS_fnc_talkToMayor;
        
    },				
    {// Code executed on interrupted
        params ["_target", "_caller", "_actionId", "_arguments"];
    },													
    [],													// Arguments passed to the scripts as _this select 3
    1,													// Action duration [s]
    0,													// Priority
    true,												// Remove on completion
    false												// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0, _civ];	// MP compatible implementation

//determine time
_dist2d = _randomhouse distance2D markerpos "marker_idapbase";
//assuming 100 km/h and some leeway
_speed = 100/3.6; //transform to m/s
_leeway = sqrt(_dist2d);
_etaDelta = _dist2d/_speed + _leeway;
_loseTime = time + _etaDelta;
_timestr = [_etaDelta, "MM:SS"] call BIS_fnc_secondsToString;
_daytimestr = [daytime+_etaDelta/(60^2), "HH:MM:SS"] call BIS_fnc_timeToString;

//create task
_parentTask = "TaskInformation";
_curNrTasks = count (_parentTask call BIS_fnc_taskChildren) + 1;
_TaskID = format ["%1_%2",_parentTask,_curNrTasks];
_mapgrid = mapGridPosition _roadPos;
_locationName = text _randomLocation;
_titleParent = ((_parentTask call BIS_fnc_taskDescription) select 1) select 0;
_TaskTitle = format ["%1 (%2)",_titleParent,_curNrTasks];
_TaskDescription = format ["
The mayor of %1 has shown interest in our program here. We arranged a meeting for
 you at %2 (%3 from now). Go there and inform him of what we do here and how we can help.
 Don't take too long as the mayor has only very limited time.
",
    _locationName, _daytimeStr, _timeStr
];
_TaskMarker = _marker;
[
    true,
    [_TaskID,_parentTask],
    [_TaskDescription,_TaskTitle,_TaskMarker],
    [_civ,true],
    "AUTOASSIGNED",
    0,
    true,
    "default"
] call BIS_fnc_taskCreate;

//execute FSM
_fsmPath = format ["taskFSM\%1.fsm",_parentTask];
[_TaskID,_todeletearray,_civ,_randomHouse,_losetime] execFSM _fsmPath;