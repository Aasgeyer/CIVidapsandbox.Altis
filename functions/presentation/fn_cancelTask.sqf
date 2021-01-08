/*
    Author: Aasgeyer

    Description:
        Cancels a Task and adds a canceled note to its description.
        Only possible if debug mode is enabled.

    Parameter(s):
        0:	STRING - Task ID

    Returns:
        Nothing

    Example(s):
        ["Task_1"] call AAS_fnc_cancelTask; //-> nothing
*/

params[ "_taskID" ];

//Thanks to Larrow on BI Forums:
//https://forums.bohemia.net/forums/topic/215759-execute-script-form-task-description-link/?do=findComment&comment=3348233
//modified by Aasgeyer

_debug = missionNamespace getVariable ["MIS_debugMode",false];
If !(_debug) exitWith {
    systemChat "Debug Mode is not enabled!";
};

if ( _taskID call BIS_fnc_taskExists &&  !([ _taskID ] call BIS_fnc_taskCompleted) ) then {
    _taskDescription = [ _taskID ] call BIS_fnc_taskDescription;
    _taskOldDescription = _taskDescription#0;
    _taskCancelDescrition = "THIS TASK WAS CANCELED.";
    _taskNewDescription = format ["%1<br/><br/>%2",_taskCancelDescrition,_taskOldDescription#0];
    _taskDescription set [0,_taskNewDescription];
    [ _taskID, _taskDescription ] call BIS_fnc_taskSetDescription;
    [ _taskID, "CANCELED" ] call BIS_fnc_taskSetState;
};