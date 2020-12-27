#define M *10^6
#define K *10^3
__EXEC(TER_maxFunds = 10M)
#define COST(PRICE) \
	cost = __EVAL(PRICE);\
	costZeus = __EVAL(PRICE/TER_maxFunds)

class CfgAssets
{
	//--- Vehicles
	class C_IDAP_UAV_01_F
	{
		COST(3.3K);
	};
	class C_IDAP_Truck_02_F
	{
		COST(6K);
	};
	class C_IDAP_Truck_02_transport_F
	{
		COST(6K);
	};
	class C_IDAP_Truck_02_water_F
	{
		COST(6.1K);
	};
	class C_IDAP_Van_02_medevac_F
	{
		COST(180K);
	};
	class C_IDAP_Van_02_transport_F
	{
		COST(60K);
	};
	class C_IDAP_Van_02_vehicle_F
	{
		COST(50K);
	};
	class C_IDAP_Offroad_01_F
	{
		COST(28K);
	};
	class C_IDAP_Offroad_02_unarmed_F
	{
		COST(30K);
	};
	class C_IDAP_Heli_Transport_02_F
	{
		COST(8.5M);
	};
	class C_IDAP_UGV_01_F
	{
		COST(100K);
	};
	class C_IDAP_UAV_06_antimine_F
	{
		COST(7K);
	};
	class C_IDAP_UAV_06_F
	{
		COST(6K);
	};
	class C_IDAP_UAV_06_medical_F
	{
		COST(6.1K);
	};
	//--- Buildings
	class Land_MedicalTent_01_floor_dark_F
	{
		COST(600);
	};
	class Land_MedicalTent_01_floor_light_F
	{
		COST(600);
	};
	class Land_MedicalTent_01_white_IDAP_closed_F
	{
		COST(1.5K);
	};
	class Land_MedicalTent_01_white_IDAP_med_closed_F
	{
		COST(50K);
	};
	class Land_MedicalTent_01_white_IDAP_open_F
	{
		COST(1.5K);
	};
	class Land_MedicalTent_01_white_IDAP_outer_F
	{
		COST(1K);
	};
	//--- Supplies
	class C_IDAP_CargoNet_01_supplies_F
	{
		COST(1K);
	};
	class Land_PlasticCase_01_large_idap_F
	{
		COST(1K);
	};
	class Land_PlasticCase_01_medium_idap_F
	{
		COST(1K);
	};
	class Land_FoodSacks_01_cargo_brown_idap_F
	{
		COST(1K);
	};
	class Land_FoodSacks_01_cargo_white_idap_F
	{
		COST(1K);
	};
	class Land_FoodSacks_01_small_brown_idap_F
	{
		COST(1K);
	};
	class Land_FoodSacks_01_small_white_idap_F
	{
		COST(1K);
	};
	class Land_PaperBox_01_open_boxes_F
	{
		COST(1K);
	};
	class Land_PaperBox_01_open_water_F
	{
		COST(1K);
	};
	class Land_PaperBox_01_small_stacked_F
	{
		COST(1K);
	};
	class Land_WaterBottle_01_stack_F
	{
		COST(1K);
	};
	class Land_MetalCase_01_large_F
	{
		COST(1K);
	};
	class Land_MetalCase_01_medium_F
	{
		COST(1K);
	};
	class Land_PlasticCase_01_large_F
	{
		COST(1K);
	};
	class Land_PlasticCase_01_medium_F
	{
		COST(1K);
	};
	class Land_CargoBox_V1_F
	{
		COST(1K);
	};
	class CargoNet_01_barrels_F
	{
		COST(1K);
	};
	class CargoNet_01_box_F
	{
		COST(1K);
	};
};