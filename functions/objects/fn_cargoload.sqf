params [
    ["_target",objNull],
    ["_caller",objNull],
    ["_actionId",-1],
    ["_arguments",[]]
];
_arguments params [
    ["_mode",-1]
];
_debug = missionNamespace getVariable ["MIS_debugmode",false];

switch (_mode) do {
    case -1: {
        
    };
    case 0: {
        //init
        //[this,nil,nil,[0]] call AAS_fnc_cargoload;
        _cond = "_this distance _target < 5
        && isnull isVehicleCargo _target
        && alive _target
        && ({(_x canvehiclecargo _target)#0} count (_target nearEntities [['Car','Air'], 20])) > 0
        && isNull objectParent _this
        && _target getVariable ['CargoLoadingEnabled',true]";

        [
            _target,											// Object the action is attached to
            "Load Cargo",										// Title of the action
            "\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",	// Idle icon shown on screen
            "\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",	// Progress icon shown on screen
            _cond,						                        // Condition for the action to be shown
            _cond,						// Condition for the action to progress
            {},													// Code executed when action starts
            {},													// Code executed on every progress tick
            { // Code executed on completion
                _this call AAS_fnc_cargoload;
            },				
            {},													// Code executed on interrupted
            [1],													// Arguments passed to the scripts as _this select 3
            3,													// Action duration [s]
            0,													// Priority
            false,												// Remove on completion
            false												// Show in unconscious state
        ] remoteExec ["BIS_fnc_holdActionAdd", 0, _target];	// MP compatible implementation
    };
    case 1: {
        //load cargo
        If _debug then {
            diag_log [_target,_caller,_arguments];
        };
        _nearvehicles = (_target nearEntities [['Car','Air'], 20]) select {(_x canvehiclecargo _target)#0};
        If _debug then {
            diag_log _nearvehicles;
        };
        _nearCargoVehicle = _nearvehicles#0;
        If !(isnull _nearCargoVehicle) then {
            _nearCargoVehicle setVehicleCargo _target;
        };
    };
};

