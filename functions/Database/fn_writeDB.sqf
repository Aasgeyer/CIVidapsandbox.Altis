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
["write", _this] call TER_db
