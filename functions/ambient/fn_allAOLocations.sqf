/*
	Author: Terra

	Description:
		Returns a list of villages and cities in the area of operation. Result 
		for the same types is cached.

	Parameter(s):
		Optional:
		_this:	ARRAY - List of location types.
			Default: ["NameCity","NameVillage"]

	Returns:
		ARRAY - List of locations.

	Example(s):
		["NameCity"] call TER_fnc_allAOLocations; //-> [Location NameCity at 7062, ...
*/
_this = if (isNil "_this" or count _this == 0) then {["NameCity","NameVillage"]} else {_this};
_this sort true;
_globalVar = "TER_fnc_allLocations_" + (_this joinString "_");
if (isNil _globalVar) then {
	private _locs = nearestLocations [
		[worldSize/2, worldSize/2, 0],
		_this,
		2 * worldSize
	];
	_locs deleteAt (_locs apply {text _x} find "Oreokastro");
	// Cache the result
	missionNamespace setVariable [_globalVar,_locs];
};
missionNamespace getVariable _globalVar