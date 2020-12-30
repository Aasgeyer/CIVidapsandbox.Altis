/*
	Author: Terra

	Description:
		Get a value from the server's database.

	Parameter(s):
		0:	STRING - Database name, eg. "general", "players", ...
		1:	STRING - Section
		2:	STRING - Key
		3:	ANY - Default value to return, if key does not exist.

	Returns:
		ANY - The value that is saved in the database.

	Example(s):
		["Economy", "money", 0] call TER_fnc_readDB; //-> 100
*/
params ["_dbName", "_section", "_key", "_default"];
_db = missionNamespace getVariable format ["TER_db_%1", _dbName];
if (isNil "_db") exitWith {["Could not load database %1!", _dbName] call BIS_fnc_error};
["read", [_section, _key, _default]] call _db