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
AAS_RegularSoldierPool =
"_y = _x;
_classblacklist = ['story','pilot','heli','officer'];
toupper getText (_y >> 'faction') isequalto 'IND_F'
&& getNumber (_y >> 'scope') >= 2
&& getText (_y >> 'vehicleClass') in ['Men']
&& count getArray (_y >> 'weapons') > 2
&& _classBlacklist findIf {tolower getText (_y >> '_generalMacro') find _x > -1} == -1"
configClasses (configFile >> "CfgVehicles");
AAS_RegularSoldierPool = AAS_RegularSoldierPool apply {configName _x};

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

//AAF air pool
AAS_AirVehiclePool =
"_y = _x;
toupper getText (_y >> 'faction') isequalto 'IND_F'
&& getNumber (_y >> 'scope') >= 2
&& getText (_y >> 'vehicleClass') in ['Air']"
configClasses (configFile >> "CfgVehicles");
AAS_AirVehiclePool = AAS_AirVehiclePool apply {configName _x};
If (count AAS_AirVehiclePool > 0) then {
    [] spawn AAS_fnc_flyBy;
};


//Drone that carries leaflets
MIS_leafletdroneclass = "C_IDAP_UAV_06_F";
publicVariable "MIS_leafletdroneclass";
[] call AAS_fnc_TaskParents;

TER_reportLog = [];
TER_hints = [];
AAS_TentsPlaced = 0;
publicVariable "AAS_tentsPlaced";
TER_weeklyExpenses = 0;
publicVariable "TER_weeklyExpenses";
TER_log = [];
publicVariable "TER_log";

if (!isDedicated && isMultiplayer && !isNull player) then {
    //--- player exists as server, mark him as host in database
    ["players", "_SP_PLAYER_", "puid", getPlayerUID player] call TER_fnc_writeDB;
};
[objNull] execFSM "fsm\DisposalBox.fsm";

//function to return the distance to the edge of an ellipse or circle.
//Thanks Nick!
_fn_distanceEllipse = {
    params ["_sizeA","_sizeB",["_phi",135]];
    _x_a = _sizeA * cos(_phi);
    _y_b = _sizeB * sin(_phi);
    [_y_b, _x_a, 0]
    //_distance = sqrt(_x_a^2 + _y_b^2); // not needed
    //_distance
};

//markers over area where IDAP is active
AO_markerIDAPZones = ["marker_AO_"] call BIS_fnc_getMarkers;
{
    //for "_phi" from 0 to 360 do { // for testing
        _markerSize = markerSize _x;
        _phi = 135;
        _vectorEdge = [_markerSize#1, _markerSize#0, _phi] call _fn_distanceEllipse;
        _color = markerColor _x;
        _pos = markerpos _x vectorAdd _vectorEdge;
        _marker = createMarker [format ["marker_%1Text_%2",_x,_phi],_pos];
        _marker setMarkerTypeLocal "mil_dot_noShadow";
        _marker setMarkerColorLocal _color;
        _marker setMarkerSizeLocal [0.025,0.025];
        _marker setMarkerText format ["IDAP AO %1",_foreachindex+1];
        //_marker setMarkerText format ["Phi = %1",_phi]; // for testing
    //};
} foreach AO_markerIDAPZones;

//markers over area where combat happens
AO_markerCombatZones = ["marker_AOcombat_"] call BIS_fnc_getMarkers;
{
    _markersize = markerSize _x;
    _phi = 135;
    _vectorEdge = [_markerSize#1, _markerSize#0, _phi] call _fn_distanceEllipse;
    _pos = markerpos _x vectorAdd _vectorEdge;
    _marker = createMarker [format ["marker_%1Text",_x],_pos];
    _marker setMarkerTypeLocal "mil_dot_noShadow";
    _color = markerColor _x;
    _marker setMarkerColorLocal _color;
    _marker setMarkerSizeLocal [0.025,0.025];
    _marker setMarkerText "Active Combat Zone";
} foreach AO_markerCombatZones;

waitUntil {time > 1 or serverTime > 1};
[] call TER_fnc_ambientCivs;