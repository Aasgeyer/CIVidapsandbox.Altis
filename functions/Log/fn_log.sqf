/*
	Author: Terra

	Description:
		__DESCRIPTION___

		Tags:
			- General / ""
			- Economy
			- Event
			- Zeus

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
params ["_title", "_message", ["_from", player], ["_tags", [""]], ["_data", []]];
TER_log pushBack [
	_title,
	_message,
	_from,
	_tags,
	date,
	_data
];
publicVariable "TER_log";