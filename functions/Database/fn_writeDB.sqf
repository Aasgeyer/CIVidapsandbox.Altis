/*
	Author: Terra

	Description:
		Saves the changes to the database in the database on the drive. Server
		only.

	Parameter(s):
		0:	STRING - Section in the database
		1:	STRING - Key name in the database
		2:	ANYTHING - Value

	Returns:
		BOOL - Success flag

	Example(s):
		["Economy", "money", 100] call TER_fnc_writeDB; //-> true
*/
if (!isServer) exitWith {};
params ["_dbName", "_section", "_key", "_value"];
private _db = missionNamespace getVariable format ["TER_db_%1", _dbName];
["write", [_section, _key, _value]] call _db
