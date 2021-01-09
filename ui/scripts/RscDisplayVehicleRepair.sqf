#define SELF RscDisplayVehicleRepair_script
params ["_mode", "_params"];
diag_log _this;
switch _mode do {
	case "onLoad":{
		_params params ["_display"];
		_vehicle = getPos player nearEntities [TER_zeusCost select {_x isEqualType ""}, 100] param [0, objNull];
		private _class = typeOf _vehicle;
		private _price = [_class] call TER_fnc_getCost;
		private _realDamage = [_vehicle] call TER_fnc_realDamage;
		// The calculation of the cost is exponential, so smaller damages are
		// less expensive while greater damages can exceed the price of the 
		// vehicle. It is viable to repair a vehicle with a damage of up to 
		// ~85%. After that you might as well buy a new one.
		private _repairCost = 0.075*(exp(3*_realDamage)-1) * _price;
		if (isNull _vehicle or {_repairCost == 0}) exitWith {
			hint "No vehicle to repair. Maybe the vehicle is too far away or not damaged?";
			_display closeDisplay 2;
		};
		_display setVariable ["_vehicle", _vehicle];
		_ctrlVehicleName = _display getVariable "VehicleName";
		_name = (configFile >> "CfgVehicles" >> _class) call BIS_fnc_displayName;
		_ctrlVehicleName ctrlSetText _name;
		_ctrlRepairCost = _display getVariable "RepairCost";
		_display setVariable ["_cost", _repairCost];
		_ctrlRepairCost ctrlSetText format ["%1 $", [_repairCost] call BIS_fnc_numberText];
		_ctrlCurrentMoney = _display getVariable "CurrentMoney";
		_ctrlCurrentMoney ctrlSetText format ["%1 $", [TER_money] call BIS_fnc_numberText];
		_ctrlRepair = _display getVariable "Repair";
		if (TER_money < _repairCost) then {
			_ctrlRepair ctrlEnable false;
		} else {
			_ctrlRepair ctrlAddEventHandler ["ButtonClick",{
				["repair", _this] call SELF;
			}];
		};
	};
	case "repair":{
		_params params ["_ctrlRepair"];
		_display = ctrlParent _ctrlRepair;
		private _vehicle = _display getVariable "_vehicle";
		_vehicle setDamage 0;
		_repairCost = _display getVariable "_cost";
		[_repairCost] call TER_fnc_removeMoney;
		hint "The vehicle has been repaired.";
	};
	case "onUnload":{
		_params params ["_display", "_exitCode"];
	};
};