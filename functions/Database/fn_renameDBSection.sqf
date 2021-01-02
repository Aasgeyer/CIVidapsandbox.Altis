/*
	Author: Terra

	Description:
		Renames a section of the database.

	Parameter(s):
		0:	__TYPE__ - __EXPLANATION__
		Optional:
		N:	__TYPE___ - __EXPLANATION__
			Default: __DEFAULT___

	Returns:
		__TYPE__ - __EXPLANATION___

	Example(s):
		__PARAMETER__ __EXECUTIONMETHOD__ __FUNCTION___; //-> __RETURN__
*/
params ["_dbName", "_oldName", "_newName"];
_db = [_dbName] call TER_fnc_getDB;
["getKeys",_oldName] call _db apply {
	private _key = _x;
	private _value = ["read", [_oldName, _key]] call _db;
	["write", [_newName, _key, _value]] call _db;
};
["deleteSection", _oldName] call _db;
_db
