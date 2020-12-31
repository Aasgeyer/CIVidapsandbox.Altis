/*
	Author: Terra

	Description:
		Decreases the given numerical database value by the given amount.

	Parameter(s):
		0:	STRING - Database name, eg "players", "assets", etc.
		1:	STRING - Section in the database.
		2:	STRING - Key.
		Optional:
		3:	NUMBER - Decrement.
			Default: 1

	Returns:
		NUMBER - New value in the DB

	Example(s):
		[] call TER_fnc_decreaseDBValue; //-> 99
		[10] call TER_fnc_decreaseDBValue; //-> 90
*/
if (!isServer) exitWith {};
params ["_dbName", "_section", "_key", ["_decrement", 1]];
[_dbName, _section, _key, -_decrement] call TER_fnc_increaseDBValue
