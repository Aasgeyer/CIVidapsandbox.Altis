/*
	Author: Terra

	Description:
		__DESCRIPTION___

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
params ["_file", "_curator"];
[_curator, TER_zeusCost] call BIS_fnc_curatorObjectRegisteredTable;
