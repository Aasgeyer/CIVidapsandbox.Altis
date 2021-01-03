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
	// Cache the result
	missionNamespace setVariable [_globalVar,
		nearestLocations [
			markerPos "marker_AO_1",
			_this,
			selectMax markerSize "marker_AO_1"
		]
	];
};
missionNamespace getVariable _globalVar