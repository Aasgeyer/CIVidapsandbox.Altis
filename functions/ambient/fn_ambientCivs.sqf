/*
	Author: Terra

	Description:
		Initializes civillian presences over the island.

	Parameter(s):
		None

	Returns:
		ARRAY - List of Civilian Presence main modules that were created.

	Example(s):
		[] call TER_fnc_ambientCivs; //-> [L Hotel 4-1:1,L India 1-3:1, ...]
*/

private _classModuleMain = "ModuleCivilianPresence_F";
private _classModulePosition = "ModuleCivilianPresenceSafeSpot_F";
private _classModuleSpawn = "ModuleCivilianPresenceUnit_F";

private _locations = ["NameCity", "NameVillage", "NameCityCapital"] call TER_fnc_allAOLocations;
_locations apply {
	private _pos = getPos _x;
	size _x params ["_a", "_b"];
	_a = _a max _b;
	[text _x splitString " " joinString "_", _pos, "ELLIPSE", [_a, _a]] call CBA_fnc_createMarker;
	for "_i" from 0 to 3 do {
		private _rPos = [[_x]] call BIS_fnc_randomPos;
		_rPos set [2, 0];
		_rpos = getPos (nearestBuilding _rPos);
		private _modulePosition = createGroup sideLogic createUnit [_classModulePosition, _rPos, [], 0, "CAN_COLLIDE"];
		_modulePosition setVariable ["BIS_fnc_initModules_disableAutoActivation", false, true];
	};
	private _unitCount = [] call {
		private _type = type _x;
		if (_type == "NameVillage") exitWith {3};
		if (_type == "NameCity") exitWith {6};
		if (_type == "NameCityCapital") exitWith {10};
	};
	for "_i" from 1 to _unitCount do {
		private _rPos = [
			[_x],
			[],
			{count(nearestBuilding _this buildingPos -1) > 0}
		] call BIS_fnc_randomPos;
		_rPos set [2, 0];
		_rpos = selectRandom ((nearestBuilding _rPos) buildingPos -1);
		if (!isNil "_rpos") then {
			private _moduleSpawn = createGroup sideLogic createUnit [_classModuleSpawn, _rPos, [], 0, "NONE"];
			_moduleSpawn setVariable ["BIS_fnc_initModules_disableAutoActivation", false, true];
		};
	};
	private _moduleMain = createGroup sideLogic createUnit [_classModuleMain, _pos, [], 0, "CAN_COLLIDE"];
	_moduleMain setVariable ["#debug", false];
	_moduleMain setVariable ["#useAgents", true];
	_moduleMain setVariable ["#unitCount", _unitCount];
	//--- Set area, format: [a, b, angle, isRectangle, c]
	private _area = [_a, _a, direction _x, rectangular _x, -1];
	_moduleMain setVariable ["objectarea", _area];
	//--- Code on unit created
	_moduleMain setVariable ["#onCreated", {_this enableDynamicSimulation true}];
	_moduleMain setVariable ["BIS_fnc_initModules_disableAutoActivation", false, true];
	diag_log [text _x, _a, _b];
	_moduleMain
};


