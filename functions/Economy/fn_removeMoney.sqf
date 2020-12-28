/*
	Author: Terra

	Description:
		Adds the given amount to the spendable money.

	Parameter(s):
		0:	NUMBER - Amount of money to add.

	Returns:
		NUMBER - New money amount.

	Example(s):
		100 call TER_fnc_addMoney; //-> 1100
*/
params ["_amount"];
[-_amount] call TER_fnc_addMoney;