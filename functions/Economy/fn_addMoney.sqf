/*
	Author: Terra

	Description:
		Add the given amount to the spendable money.

	Parameter(s):
		0:	NUMBER - Amount of money to add.

	Returns:
		NUMBER - New money amount

	Example(s):
		100 call TER_fnc_addMoney; //-> 1100
*/
params ["_amount"];
TER_money = TER_money + _amount;
publicVariable "TER_money";
TER_money