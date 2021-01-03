params ["_player", "_didJIP"];
["marker_zoom_"] spawn AAS_fnc_mapZoomMarker;
[_player] execFSM "fsm\PlayerViolation.fsm";
//--- Let the server load the client's data from the database
[_player] remoteExecCall ["TER_fnc_loadClient", 2];
[
	TER_laptopBase,
	"Open IDAP Organizer",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",
	"_this distance _target < 4",
	"_caller distance _target < 6",
	{},
	{},
	{createDialog "RscDisplayIDAPBrowser";},
	{},
	[],
	0.5,
	1000,
	false,
	false,
	true
] call BIS_fnc_holdActionAdd;

[] call AAS_fnc_briefing;