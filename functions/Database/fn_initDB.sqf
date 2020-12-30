/*
	Author: Terra

	Description:
		Initializes the iniDBI2 databases for the mission.
		! SERVER ONLY !

	Parameter(s):
		None

	Returns:
		ARRAY - The iniDBI2 databases [general, players, assets]

	Example(s):
		[] call TER_fnc_initDB; //-> [DATABASE, DATABASE, DATABASE]
*/
if !(isServer) exitWith {};
["Loading database %1...", missionName] call BIS_fnc_logFormat;
TER_db_general = ["new", format["%1_general", missionName]] call OO_INIDBI;
TER_db_players = ["new", format["%1_players", missionName]] call OO_INIDBI;
TER_db_assets = ["new", format["%1_assets", missionName]] call OO_INIDBI;
[TER_db_general, TER_db_players, TER_db_assets]