/*
	Author: Terra

	Description:
		Returns the player UID if it is a non hosting client, otherwise it will
		return "_SP_PLAYER_" to sync progress from single player.
		! LOCAL ONLY !

		Not implemented atm.

	Parameter(s):
		None

	Returns:
		STRING - player UID

	Example(s):
		[player] call TER_fnc_getPUID; //-> "123456789"
*/
params ["_player"];
if (getPlayerUID _player == "_SP_PLAYER_") then {
	//--- Try to get the PUID from database
	["players", "_SP_PLAYER_", "puid", getPlayerUID _player] call TER_fnc_readDB;
} else {
	remoteExecutedOwner
	getPlayerUID _player;
};