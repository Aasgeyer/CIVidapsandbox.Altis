/*
	Author: Terra

	Description:
		SE AG EG
		Initializes a vehicle to be used in the database.

	Parameter(s):
		0:	OBJECT/STRING - Object to handle in DB or string to create the type
							from classname.
		Optional:
		1:	ARRAY - Position of the newly created vehicle. Not used when object 
					is passed
			Default: nil

	Returns:
		OBJECT - The handled/created vehicle.

	Example(s):
		[vehicle player] call TER_fnc_initDBAsset; //-> OBJECT
		["C_IDAP_Offroad_02_unarmed_F", getPos player] call TER_fnc_initDBAsset; //-> OBJECT
*/
if (!isServer) exitWith {};
params ["_vehicle", "_pos", "_oldDBID"];
if (_vehicle isEqualType "") then {
	_vehicle = _vehicle createVehicle _pos;
};

//--- Add vehicle to Zeus
[L_idapzeus_1, [[_vehicle], true]] remoteExec ["addCuratorEditableObjects", 2];

if (typeOf _vehicle call BIS_fnc_crewCount > 0) then {
	//--- Save to database
	private _vehicleDBSection = [_vehicle] call TER_fnc_getDBVehicleName;
	if (isNil "_oldDBID") then {
		//--- New vehicle, not in database yet
		["write", [_vehicleDBSection, "class", typeOf _vehicle]] call TER_db_assets;
	} else {
		//--- Vehicle came from database, apply stored values
		//--- Damage
		private _damages = ["read", [_oldDBID, "damage", []]] call TER_db_assets;
		_damages apply {
			_x params ["_hitPoint", "_value"];
			_vehicle setHitPointDamage [_hitPoint, _value, false];
		};
		//--- Fuel
		private _fuel = ["read", [_oldDBID, "fuel", 1]] call TER_db_assets;
		_vehicle setFuel _fuel;

		//--- Rename old section
		["assets", _oldDBID, _vehicleDBSection] call TER_fnc_renameDBSection;
		["deleteKey", [_vehicleDBSection, "stored"]] call TER_db_assets;
	};

	//--- Track alive status of vehicle
	_vehicle addMPEventHandler ["MPKilled",{
		params ["_vehicle", "_killer", "_instigator", "_useEffects"];
		if !(isServer) exitWith {nil};
		["deleteSection", [_vehicle] call TER_fnc_getDBVehicleName] call TER_db_assets;
		nil
	}];

	//--- Store damage in database
	_vehicle addEventHandler ["HandleDamage",{
		params ["_unit", "_selection", "_damage"];
		if (_selection != "" && _damage > 0 && alive _unit) then {
			[_unit] call TER_fnc_updateDBAsset;
		};
		nil
	}];
};

_vehicle
