/*
	Author: Terra

	Description:
		Deletes the given section from the database.

	Parameter(s):
		0:	STRING - Database name
		1:	STRING - Section's name

	Returns:
		BOOL - true if the section was deleted successfully, false otherwise

	Example(s):
		["assets", _obj] call TER_fnc_deleteDBSection; //-> true
*/
if (!isServer) exitWith {};
params ["_dbName", "_section"];
private _db = _dbName call TER_fnc_getDB;
["deleteSection", _section] call _db