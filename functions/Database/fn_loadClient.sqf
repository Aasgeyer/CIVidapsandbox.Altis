/*
	Author: Terra

	Description:
		Loads the player's information from the database. Executed from 
		initPlayerLocal.sqf.
		! SERVER ONLY !

	Parameter(s):
		0:	OBJECT - Player.

	Returns:
		Nothing. Function is executed remotely.

	Example(s):
		[player] call TER_fnc_loadClient;
*/
params [["_player", player]];
private _puid = getPlayerUID _player;
["%1 (%2) requesting loading of stats from db.", name _player, _puid] call BIS_fnc_logFormat;
//--- Apply loadout from database
private _loadout = ["players", _puid, "loadout", getUnitLoadout _player] call TER_fnc_readDB;
_player setUnitLoadout _loadout;

//--- Keep track of player's loadout
_player spawn {
	while {true} do {
		private _loadout = getUnitLoadout _this;
		waitUntil {sleep 10; !(getUnitLoadout _this isEqualTo _loadout)};
		//--- Loadout changed, save to DB
		["players", getPlayerUID _player, "loadout", getUnitLoadout _this] remoteExecCall ["TER_fnc_writeDB", 2];
	};
};
