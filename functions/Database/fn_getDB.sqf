/*
	Author: Terra

	Description:
		Gets the database from the given name.

	Parameter(s):
		0:	STRING - Name of the database

	Returns:
		DATABASE - The iniDBI2 database with the given var name.

	Example(s):
		["general"] call TER_fnc_getDB; //-> DATABASE
*/
params ["_name"];
missionNamespace getVariable format ["TER_db_%1", _name]
