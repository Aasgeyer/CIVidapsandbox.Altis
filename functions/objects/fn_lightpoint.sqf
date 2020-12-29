If (!isServer) exitWith {};

params ["_object"];

_lightpoint = "#lightpoint" createVehicle [0,0,0]; 
_lightpoint setpos getpos _object; 
[_lightpoint, [1,1,1]] remoteExec ["setLightColor"];
[_lightpoint, [1,1,1]] remoteExec ["setLightAmbient"];
[_lightpoint, 0.25] remoteExec ["setLightBrightness"];