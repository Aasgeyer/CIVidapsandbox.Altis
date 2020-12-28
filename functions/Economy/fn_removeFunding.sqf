/*
	Author: Terra

	Description:
		Remove the given amount of money from the funds that are added to the
		spendable money at the end of the day.

	Parameter(s):
		0:	NUMBER - Amount of money to remove from the funds.

	Returns:
		NUMBER - New funds

	Example(s):
		// TER_funds = 1000;
		100 call TER_fnc_removeFunding; //-> 900
*/
params ["_amount"];
[-_amount] call TER_fnc_addFunding