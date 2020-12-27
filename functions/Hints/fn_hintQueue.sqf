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
if (count TER_fnc_hint_queue == 0) exitWith {};
private _hint = TER_fnc_hint_queue deleteAt 0;
hint parseText _hint;
sleep 10;
[] call TER_fnc_hintQueue;
