/*
	Author: Terra

	Description:
		Mission is restarted. What happens:
		- Set money (funds, money)
		- Set date
		- ...

	Parameter(s):
		None

	Returns:
		BOOL - true

	Example(s):
		[] call TER_fnc_resumeMission; //-> true
*/
if !(isServer) exitWith {};
//--- Load money from database
TER_money = ["read", ["Economy", "money", 0]] call TER_db;
TER_funds = ["read", ["Economy", "funds", 0]] call TER_db;
[
	"TER_money",
	"TER_funds"
] apply {publicVariable _x};

//--- Set date
private _date = ["read", ["Time", "date", date]] call TER_db;
setDate _date;
//--- Keep database up to date with the date
[] spawn {
	while {true} do {
		private _curDate = date;
		waitUntil {sleep 1; !(_curDate isEqualTo date)};
		["write", ["Time", "date", date]] call TER_db;
	};
};

true
