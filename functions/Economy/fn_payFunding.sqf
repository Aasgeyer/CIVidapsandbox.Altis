/*
	Author: Terra

	Description:
		Adds the daily collected fundings to the available money.

	Parameter(s):
		None

	Returns:
		Nothing

	Example(s):
		[] call TER_fnc_payFunding;
*/
[TER_funds] call TER_fnc_addMoney;
[TER_funds] call TER_fnc_removeFunding;
publicVariable "TER_funds";