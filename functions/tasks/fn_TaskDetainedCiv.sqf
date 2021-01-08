/*
    Author: Aasgeyer

    Description:
        Task Detained Civilian.

    Parameter(s): None

    Returns: Nothing

    Example(s):
        [] call AAS_fnc_TaskDetainedCiv; //-> nothing
*/


If (!isServer) exitWith {};

_debug = missionNamespace getVariable ["MIS_debugMode",false];
_todeletearray = [];

/*
Acts_Executioner_StandingLoop, Acts_Executioner_Kill, Acts_Executioner_Kill_End
Acts_ExecutionVictim_Loop, Acts_ExecutionVictim_Unbow, Acts_ExecutionVictim_Kill_End, Acts_ExecutionVictim_KillTerminal
*/

//find position in AO
_randomPos = [
    nil,
    ["water"] + MIS_restrictedAreas,
    {
        true
        //MIS_idapoutposts findIf {
        //    _x distance2D _this < 300
        //    && (_x getVariable ["AAS_IDAPOutPostActive",false])
        //} == -1
        //&& AllPlayers findIf {_x distance2D _this < 300} == -1
        //&& count (_this nearRoads 50) > 0
        //&& MIS_restrictedAreas findIf {_this inArea _x} == -1
    }
] call BIS_fnc_randomPos;

If (_randomPos isEqualTo [0,0]) exitWith {
    If _debug then {
        systemChat "No position on road found. Exiting Detained Civ Script";
    };
};

//_randomPos = selectRandom (_randomPos nearRoads 50);

_OutpostsClose = MIS_idapoutposts select {_x distance2D _randomPos < 300};
{
    _x setVariable ["AAS_IDAPoutpostActive",true,true];
} forEach _OutpostsClose;

_marker = createMarker [format ["marker_civdetained_%1",_randomPos],_randomPos];
_marker setMarkerTypeLocal "mil_Objective";
_marker setMarkerText "Detained Civilian";
_todeletearray pushBack _marker;
/*
_roadinfo = getroadinfo _randomPos;
_roadinfo params ["", "_width", "", "", "", "", "_begPos", "_endPos", "_isBridge"];
_sidepos = _randomPos modelToWorld [_width,0,0];
*/
_regularteam = [_randomPos getpos [4,random 360],independent,(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
_todeletearray pushBack _regularteam;
_civ = (createGroup [civilian,true]) createUnit [selectRandom CivUnitPool, _randomPos, [], 0, "CAN_COLLIDE"];
_todeletearray pushBack _civ;
_executioner = selectRandom (units _regularteam - [leader _regularteam]);
_executioner disableAI "ALL";
_executioner enableAI "ANIM";
_executioner setpos _randomPos;
_executioner setdir random 360;
_civ disableAI "ALL";
_civ enableAI "ANIM";
_civ setpos _randomPos;
_civ setdir getdir _executioner;
[_executioner,"Acts_Executioner_StandingLoop"] remoteExec ["switchmove"];
[_civ,"Acts_ExecutionVictim_Loop"] remoteExec ["switchmove"];

[
    leader _regularteam,											// Object the action is attached to
    "Talk",										// Title of the action
    "\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa",	// Idle icon shown on screen
    "\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa",	// Progress icon shown on screen
    "_this distance _target < 7 && alive _target && !(_target getvariable ['AAS_DetainedLeaderTalkedTo',false])",						// Condition for the action to be shown
    "_caller distance _target < 15 && alive _target",						// Condition for the action to progress
    {// Code executed when action starts
        params ["_target", "_caller", "_actionId", "_arguments"];
        _saymessage = "IDAP_DetainedTalk_1";
        [_caller, _saymessage] remoteExec ["directSay",_caller];
    },													
    {},													// Code executed on every progress tick
    {// Code executed on completion
        _saymessage = "I_DetainedRespond_1";
        [_target, _saymessage] remoteExec ["directSay",_caller];
        _target setVariable ["AAS_DetainedLeaderTalkedTo",true,true];
    },				
    {},													// Code executed on interrupted
    [],													// Arguments passed to the scripts as _this select 3
    5,													// Action duration [s]
    0,													// Priority
    true,												// Remove on completion
    false												// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0, leader _regularteam];	// MP compatible implementation

[
    _civ,											// Object the action is attached to
    "Free",										// Title of the action
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",	// Idle icon shown on screen
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",	// Progress icon shown on screen
    "_this distance _target < 7 && alive _target && _target getvariable ['AAS_DetainedCivReadyToFree',false]",						// Condition for the action to be shown
    "_caller distance _target < 15 && alive _target",						// Condition for the action to progress
    {// Code executed when action starts
        params ["_target", "_caller", "_actionId", "_arguments"];
        _saymessage = "IDAP_DetainedFree_1";
        [_caller, _saymessage] remoteExec ["directSay",_caller];
    },													
    {},													// Code executed on every progress tick
    {// Code executed on completion
        params ["_target", "_caller", "_actionId", "_arguments"];
        _target setVariable ["AAS_CivFreed",true,true];
        _saymessage = "C_DetainedFreed_1";
        [_target, _saymessage] remoteExec ["directSay",_caller];
        [_target, "Acts_ExecutionVictim_Unbow"] remoteExec ["switchMove"];
        0 = _target spawn {sleep 6; _this enableAI "ALL";};
        _target setSpeedMode "NORMAL";
        _target move (_target getpos [random 500,random 360]);
    },				
    {},													// Code executed on interrupted
    [],													// Arguments passed to the scripts as _this select 3
    5,													// Action duration [s]
    0,													// Priority
    true,												// Remove on completion
    false												// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0, _civ];	// MP compatible implementation

//determine time
_dist2d = _randomPos distance2D markerpos "marker_idapbase";
//assuming 50 km/h and some leeway
_speed = 50/3.6; //transform to m/s
_leeway = sqrt(_dist2d)+37;
_etaDelta = _dist2d/_speed + _leeway;
_loseTime = time + _etaDelta;
_timestr = [_etaDelta, "MM:SS"] call BIS_fnc_secondsToString;
_daytimestr = [daytime+_etaDelta/(60^2), "HH:MM:SS"] call BIS_fnc_timeToString;

//calculate reward
_worldSizeR = sqrt 2 * (worldSize/2);
_funding = linearConversion [0,_worldSizeR,_dist2d,1200,12000];
_funding = round _funding;
_fundingStr = _funding call BIS_fnc_numberText;

//create task
_parentTask = "TaskDetainedCiv";
_curNrTasks = count (_parentTask call BIS_fnc_taskChildren) + 1;
_TaskID = format ["%1_%2",_parentTask,_curNrTasks];
_mapgrid = mapGridPosition _randomPos;
_titleParent = ((_parentTask call BIS_fnc_taskDescription) select 1) select 0;
_TaskTitle = format ["%1 (%2)",_titleParent,_curNrTasks];
_taskCancel = format [ "<br/><br/><execute expression='[ %1 ] call AAS_fnc_cancelTask;'>(CANCEL)</execute>", str _taskID ];
_TaskDescription = format ["
We got a report of a detained civilian being held captive near grid %1! Go there
 and talk to the team leader. Be quick as they may harm him without our eyes
 present! You have time until %2 (%3).<br/>
 Reward: + %4$ to daily funding.
 %5
",
    _mapgrid, _daytimestr, _timestr, _fundingStr, _taskCancel
];
_TaskMarker = _marker;
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
[_TaskID,_todeletearray,_loseTime,_executioner,_civ,_regularteam,_OutpostsClose,_funding] execFSM _fsmPath;