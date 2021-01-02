/*
	Author: Terra

	Description:
		Mission is restarted. Apply database.

	Parameter(s):
		None

	Returns:
		BOOL - true

	Example(s):
		[] call TER_fnc_resumeMission; //-> true
*/
if !(isServer) exitWith {};
//--- Load money from database
TER_money = ["general", "Economy", "money", 0] call TER_fnc_readDB;
TER_funds = ["general", "Economy", "funds", 0] call TER_fnc_readDB;
[
	"TER_money",
	"TER_funds"
] apply {publicVariable _x};

//--- Set date
private _date = ["general", "Time", "date", date] call TER_fnc_readDB;
setDate _date;
//--- Keep database up to date with the date
[] spawn {
	while {true} do {
		private _curDate = date;
		waitUntil {sleep 1; !(_curDate isEqualTo date)};
		["general", "Time", "date", date] call TER_fnc_writeDB;
	};
};

//--- Mark vehicles in database as stored
"getSections" call TER_db_assets apply {
	["write", [_x, "stored", true]] call TER_db_assets;
};

//--- Timestamp the database
TER_missionStart = "getTimeStamp" call TER_db_general;
TER_missionStart params ["_year", "_month", "_day", "_hour", "_minute", "_second"];
TER_missionStartStr = format ["%1%2%3%4%5%6",
	_year,
	[_month, 2] call CBA_fnc_formatNumber,
	[_day, 2] call CBA_fnc_formatNumber,
	[_hour, 2] call CBA_fnc_formatNumber,
	[_minute, 2] call CBA_fnc_formatNumber,
	[_second, 2] call CBA_fnc_formatNumber
];


