/*
	Author: Terra

	Description:
		Add an amount of money to the funding that is added at the end of the day.

	Parameter(s):
		0:	NUMBER - Amount of money to add.

	Returns:
		NUMBER - The new fund amount.

	Example(s):
		100 call TER_fnc_addFunds; //-> 1100
*/
params ["_amount"];
TER_funds = TER_funds + _amount;
publicVariable "TER_funds";
["Economy","funds",TER_funds] remoteExecCall ["TER_fnc_writeDB", 2];
TER_funds