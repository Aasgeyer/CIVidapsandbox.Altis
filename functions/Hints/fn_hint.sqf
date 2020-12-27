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
params ["_title", "_message"];
private _hint = format ["<t size='2'>%1</t><br/>%2", _title, _message];
TER_hints pushBack _this;
publicVariable "TER_hints";
if (isNil "TER_fnc_hint_queue") then {TER_fnc_hint_queue = []};
TER_fnc_hint_queue pushBack _hint;
if (isNil "TER_fnc_hintQueue_handle" or {scriptDone TER_fnc_hintQueue_handle}) then {
	TER_fnc_hintQueue_handle = [] spawn TER_fnc_hintQueue;
};