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
private _puid = [_player] call TER_fnc_getPUID;
["%1 (%2) requesting loading of stats from db.", name _player, _puid] call BIS_fnc_logFormat;
//--- Apply loadout from database
private _loadout = [_puid, "loadout", getUnitLoadout _player] call TER_fnc_readDB;
_player setUnitLoadout _loadout;

