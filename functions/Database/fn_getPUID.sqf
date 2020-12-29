/*
	Author: Terra

	Description:
		Returns the player UID if it is a non hosting client, otherwise it will
		return "_SP_PLAYER_" to sync progress from single player.
		! LOCAL ONLY !

	Parameter(s):
		None

	Returns:
		STRING - player UID

	Example(s):
		[] call TER_fnc_getPUID; //-> "123456789"
*/

if isServer then {
	"_SP_PLAYER_"
} else {
	getPlayerUID player
};