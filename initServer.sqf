_debug = missionNamespace getVariable ["MIS_debugMode",false];

AAS_TentsPlaced = 0;
publicVariable "AAS_TentsPlaced";

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

TER_reportLog = [];
TER_hints = [];