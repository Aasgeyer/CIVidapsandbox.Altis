/*
	Author: Terra

	Description:
		Updates the database values for a vehicle in the database.

	Parameter(s):
		0:	OBJECT - The vehicle to update in the database.

	Returns:
		BOOL - Saving of asset was successful

	Example(s):
		[vehicle player] call TER_fnc_updateDBAsset; //-> true
*/
params ["_vehicle"];
private _success = true;
private _vehicleDBSection = [_vehicle] call TER_fnc_getDBVehicleName;
//--- Damage to HitPoints
getAllHitPointsDamage _vehicle params ["_hitpointNames", "", "_damages"];
private _i = 0;
private _pairedHitpoints = _hitpointNames apply {
	_damage = _damages select _i;
	_i = _i + 1;
	[_x, _damage]
};
_success = ["write", [_vehicleDBSection, "damage", _pairedHitpoints]] call TER_db_assets;
if (!_success) exitWith {false};

//--- Fuel status
_success = ["write", [_vehicleDBSection, "fuel", fuel _vehicle]] call TER_db_assets;
_success
