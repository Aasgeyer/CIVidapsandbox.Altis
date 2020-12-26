[] execVM "costs.sqf";

//objects that can be slingloaded
MIS_SlingloadCargo = [
    "Land_PaperBox_01_small_stacked_F",
    "Land_FoodSacks_01_cargo_brown_idap_F","Land_FoodSacks_01_cargo_white_idap_F",
    "Land_WaterBottle_01_stack_F"
];

//objects that can be loaded into the back of the truck
MIS_VanCargoObjectClasses = [
    "Land_PaperBox_01_small_stacked_F","Land_WaterBottle_01_stack_F",
    "Land_PaperBox_01_open_boxes_F","Land_PaperBox_01_open_water_F",
    "Land_CargoBox_V1_F","Land_FoodSacks_01_small_white_idap_F",
    "Land_FoodSacks_01_small_brown_idap_F","Land_MetalCase_01_large_F",
    "CargoNet_01_box_F","CargoNet_01_barrels_F"
];

//objects that serve as Tents
AAS_TentObjects = [
    "Land_MedicalTent_01_white_IDAP_closed_F",
    "Land_MedicalTent_01_white_IDAP_open_F"
];

//Drone that carries leaflets
MIS_leafletdroneclass = "C_IDAP_UAV_06_F";