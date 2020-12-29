/*
	Author: Terra

	Description:
		Initializes the iniDBI2 database for the mission. Only available on server.

	Parameter(s):
		None

	Returns:
		INIDBI - The iniDBI2 database "object"

	Example(s):
		[] call TER_fnc_initDB; //-> DATABASE
*/
if !(isServer) exitWith {};
["Loading database %1...", missionName] call BIS_fnc_logFormat;
TER_db = ["new", missionName] call OO_INIDBI;
TER_db