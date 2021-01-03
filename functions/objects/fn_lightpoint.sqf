/*
    Author: Aasgeyer

    Description:
        creates a light on given object for all players on server

    Parameter(s):
        0:	OBJECT - object where light is present

    Returns:
        OBJECT - created Lightpoint

    Example(s):
        [this] call AAS_fnc_lightPoint; //-> Lightpoint
*/


If (!isServer) exitWith {};

params ["_object"];

_lightpoint = "#lightpoint" createVehicle [0,0,0]; 
_lightpoint setpos getpos _object; 
[_lightpoint, [1,1,1]] remoteExec ["setLightColor"];
[_lightpoint, [1,1,1]] remoteExec ["setLightAmbient"];
[_lightpoint, 0.25] remoteExec ["setLightBrightness"];
_lightpoint