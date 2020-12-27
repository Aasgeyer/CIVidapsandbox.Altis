#define M *10^6
#define K *10^3
TER_maxFunds = parsingNamespace getVariable "TER_maxFunds";
if (isServer) then {
	TER_money = 0;
	TER_funds = 0;
	TER_baseFunds = 10K;
	["TER_money", "TER_funds", "TER_baseFunds"] apply {
		publicVariable _x;
	};
};

TER_zeusCost = [];
"true" configClasses (missionConfigFile >> "CfgAssets") apply {
	private _name = configName _x;
	private _cost = getNumber(_x >> "costZeus");
	TER_zeusCost append [_name, _cost];
};
[] spawn {
	waitUntil {time > 1};
	[] call TER_fnc_loadCuratorCosts;
};

/* TER_zeusCost = [
	//--- Vehicles
	"C_IDAP_UAV_01_F",3.3K,
	'C_IDAP_Truck_02_F',6K,
	'C_IDAP_Truck_02_transport_F',6K,
	'C_IDAP_Truck_02_water_F',6.1K,
	'C_IDAP_Van_02_medevac_F',180K,
	'C_IDAP_Van_02_transport_F',60K,
	'C_IDAP_Van_02_vehicle_F',50K,
	'C_IDAP_Offroad_01_F',28K,
	'C_IDAP_Offroad_02_unarmed_F',30K,
	'C_IDAP_Heli_Transport_02_F',8.5M,
	'C_IDAP_UGV_01_F',100K,
	'C_IDAP_UAV_06_antimine_F',7K,
	'C_IDAP_UAV_06_F',6K,
	'C_IDAP_UAV_06_medical_F',6.1K,
	//--- Buildings
	'Land_MedicalTent_01_floor_dark_F',600,
	'Land_MedicalTent_01_floor_light_F',600,
	'Land_MedicalTent_01_white_IDAP_closed_F',1.5K,
	'Land_MedicalTent_01_white_IDAP_med_closed_F',50K,
	'Land_MedicalTent_01_white_IDAP_open_F',1.5K,
	'Land_MedicalTent_01_white_IDAP_outer_F',1K,
	//--- Supplies
	'C_IDAP_CargoNet_01_supplies_F',1K,
	'Land_PlasticCase_01_large_idap_F',1K,
	'Land_PlasticCase_01_medium_idap_F',1K,
	'Land_FoodSacks_01_cargo_brown_idap_F',1K,
	'Land_FoodSacks_01_cargo_white_idap_F',1K,
	'Land_FoodSacks_01_small_brown_idap_F',1K,
	'Land_FoodSacks_01_small_white_idap_F',1K,
	'Land_PaperBox_01_open_boxes_F',1K,
	'Land_PaperBox_01_open_water_F',1K,
	'Land_PaperBox_01_small_stacked_F',1K,
	'Land_WaterBottle_01_stack_F',1K,
	'Land_MetalCase_01_large_F',1K,
	'Land_MetalCase_01_medium_F',1K,
	'Land_PlasticCase_01_large_F',1K,
	'Land_PlasticCase_01_medium_F',1K,
	'Land_CargoBox_V1_F',1K,
	'CargoNet_01_barrels_F',1K,
	'CargoNet_01_box_F',1K
] apply {
	if (_x isEqualType 0) then {
		_x / TER_maxFunds
	} else {
		_x
	};
} */
/*
TER_price_ambulance / MAX_FUNDS = cost
TER_price_ambulance = cost * MAX_FUNDS
*/