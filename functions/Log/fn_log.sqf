/*
	Author: Terra

	Description:
		Adds an event to the mission log.

		Tags:
			- Economy
			- Event
			- Zeus

	Parameter(s):
		0:	STRING - Title of the event.
		1:	STRING - Message that describes the event.
		Optional:
		2:	OBJECT - Player that activated the action.
			Default: player
		3:	ARRAY - Tags that categorize the event.
			Default: []
		4:	ARRAY - Custom data to save to the log
			Default: []

	Returns:
		ARRAY - The global log array

	Example(s):
		["Money spent", "Money was spent on useless stuff again"] call TER_fnc_log;
		[
			"Money spent",
			"Money was spent on useless stuff again",
			allPlayers select 0,
			["Economy"],
			[getPos player, damage player]
		] call TER_fnc_log;
*/
params ["_title", "_message", ["_from", player], ["_tags", []], ["_data", []]];
TER_log pushBack [
	_title,
	_message,
	_from,
	_tags,
	date,
	_data
];
publicVariable "TER_log";
TER_log