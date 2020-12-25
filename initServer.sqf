_debug = missionNamespace getVariable ["MIS_debugMode",false];

//objects that can be slingloaded
MIS_SlingloadCargo = [
    "Land_PaperBox_01_small_stacked_F",
    "Land_FoodSacks_01_cargo_brown_idap_F","Land_FoodSacks_01_cargo_white_idap_F",
    "Land_WaterBottle_01_stack_F"
];
publicVariable "MIS_SlingloadCargo";
//objects that can be loaded into the back of the truck
MIS_VanCargoObjectClasses = [
    "Land_PaperBox_01_small_stacked_F","Land_WaterBottle_01_stack_F",
    "Land_PaperBox_01_open_boxes_F","Land_PaperBox_01_open_water_F",
    "Land_CargoBox_V1_F","Land_FoodSacks_01_small_white_idap_F",
    "Land_FoodSacks_01_small_brown_idap_F","Land_MetalCase_01_large_F",
    "CargoNet_01_box_F","CargoNet_01_barrels_F"
];
publicVariable "MIS_VanCargoObjectClasses";

//objects that serve as Tents
AAS_TentObjects = [
    "Land_MedicalTent_01_white_IDAP_closed_F",
    "Land_MedicalTent_01_white_IDAP_open_F"
];
publicVariable "AAS_TentObjects";
AAS_TentsPlaced = 0;
publicVariable "AAS_TentsPlaced";

//Drone that carries leaflets
MIS_leafletdroneclass = "C_IDAP_UAV_06_F";
publicVariable "MIS_leafletdroneclass";

//IDAP worker array
IDAP_unitsarray = [];
for "_n" from 1 to 9 do {
    IDAP_unitsarray pushBack format ["C_IDAP_Man_AidWorker_0%1_F",_n];
};

//set up IDAP outposts
[] call AAS_fnc_idaplocation;

//civilian type pool of the civilian presence module
CivUnitPool = configFile >> "CfgVehicles" >> "ModuleCivilianPresence_F" >> "UnitTypes" >> worldName;
if (isNull CivUnitPool) then { 
    CivUnitPool = configFile >> "CfgVehicles" >> "ModuleCivilianPresence_F" >> "UnitTypes" >> "Other";
};
CivUnitPool = getArray CivUnitPool;

//AAF soldier pool
AAS_RegularSoliderPool =
"_y = _x;
_classblacklist = ['story','pilot','heli','officer'];
toupper getText (_y >> 'faction') isequalto 'IND_F'
&& getNumber (_y >> 'scope') >= 2
&& getText (_y >> 'vehicleClass') in ['Men']
&& count getArray (_y >> 'weapons') > 2
&& _classBlacklist findIf {tolower getText (_y >> '_generalMacro') find _x > -1} == -1"
configClasses (configFile >> "CfgVehicles");
AAS_RegularSoliderPool = AAS_RegularSoliderPool apply {configName _x};

//FIA soldier pool
AAS_GuerillaSoldierPool =
"_y = _x;
_classblacklist = ['story','pilot','heli','officer'];
toupper getText (_y >> 'faction') isequalto 'BLU_G_F'
&& getNumber (_y >> 'scope') >= 2
&& getText (_y >> 'vehicleClass') in ['Men']
&& count getArray (_y >> 'weapons') > 2
&& _classBlacklist findIf {tolower getText (_y >> '_generalMacro') find _x > -1} == -1"
configClasses (configFile >> "CfgVehicles");
AAS_GuerillaSoldierPool = AAS_GuerillaSoldierPool apply {configName _x};

[] call AAS_fnc_TaskParents;