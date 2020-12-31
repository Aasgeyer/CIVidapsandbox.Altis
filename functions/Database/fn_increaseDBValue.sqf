/*
	Author: Terra

	Description:
		Increases the numerical value of a database entry.
		! SERVER ONLY !

	Parameter(s):
		0:	STRING - Database name, eg "players", "assets", etc.
		1:	STRING - Section in the database.
		2:	STRING - Key.
		Optional:
		3:	NUMBER - Increment.
			Default: 1

	Returns:
		NUMBER - New value in the DB

	Example(s):
		[] call TER_fnc_increaseDBValue; //-> 101
		[10] call TER_fnc_increaseDBValue; //-> 110
*/
if (!isServer) exitWith {};
params ["_dbName", "_section", "_key", ["_increment", 1]];
private _db = missionNamespace getVariable format ["TER_db_%1", _dbName];
private _current = [_dbName, _section, _key, 0] call TER_fnc_readDB;
private _new = _current + _increment;
[_dbName, _section, _key, _new] call TER_fnc_writeDB;
_new
