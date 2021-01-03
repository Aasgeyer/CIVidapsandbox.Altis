/*
    Author: Aasgeyer

    Description:
        Used in the task Information Campaign

    Parameter(s):
        0:	OBJECT - Mayor (NPC)
        1:	OBJECT - Player
        2:  NUMBER - Action ID
        3:  ARRAY - Arguments

    Returns:
        nothing

    Example(s):
        _this spawn AAS_fnc_TalkToMayor; //-> nothing
*/


params ["_target", "_caller", "_actionId", "_arguments"];

_target setVariable ["MayorisBeingInformed",true,true];

_caller setdir (_caller getdir _target);
_target setdir (_target getdir _caller);

[0, 2, false, true] call BIS_fnc_cinemaBorder;

_SwitchMove = format ["HubStandingU%1_idle%2",selectRandom ["A","B","C"],selectRandom [1,2,3]];
[_target, _SwitchMove] remoteExec ["switchMove"];
[_caller, "Acts_StandingSpeakingUnarmed"] remoteExec ["switchMove"];

_saymessage = "IDAP_mayor_1";
[_caller, _saymessage] remoteExec ["directSay",_caller];

sleep 5;

_saymessage = "C_mayor_1";
[_target, _saymessage] remoteExec ["directSay",_caller];

sleep 5;

_saymessage = "IDAP_mayor_2";
[_caller, _saymessage] remoteExec ["directSay",_caller];

sleep 5;

_saymessage = "C_mayor_2";
[_target, _saymessage] remoteExec ["directSay",_caller];

sleep 5;

[_target, ""] remoteExec ["switchMove"];
[_caller, ""] remoteExec ["switchMove"];
_target setVariable ["MayorIsInformed",true,true];

[1, 2] call BIS_fnc_cinemaBorder;