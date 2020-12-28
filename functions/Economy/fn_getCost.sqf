/*
	Author: Terra

	Description:
		Get the cost of a vehicle placeable by Zeus from config.

	Parameter(s):
		0:	STRING - Classname of the vehicle.
		Optional:
		1:	STRING - Return type: "cost" in $ or "costZeus" in Zeus points
			Default: "cost"

	Returns:
		NUMBER - Cost of the vehicle

	Example(s):
		["C_IDAP_UAV_01_F"] call TER_fnc_getCost; //-> 3300
		["C_IDAP_UAV_01_F", "costZeus"] call TER_fnc_getCost; //-> 0.00033
		
*/
params ["_class", ["_mode", "cost"]];
getNumber(missionConfigFile >> "CfgAssets" >> _class >> _mode)