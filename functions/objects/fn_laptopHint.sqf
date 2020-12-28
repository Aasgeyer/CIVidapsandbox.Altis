params ["_laptop"];
[
    _laptop,											// Object the action is attached to
    "Read Field Manual IHL",										// Title of the action
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",	// Idle icon shown on screen
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",	// Progress icon shown on screen
    "_this distance _target < 4",						// Condition for the action to be shown
    "_caller distance _target < 6",						// Condition for the action to progress
    {// Code executed when action starts
        params ["_target", "_caller", "_actionId", "_arguments"];
    },													
    {},													// Code executed on every progress tick
    {// Code executed on completion
        params ["_target", "_caller", "_actionId", "_arguments"];
        ["InternationalHumanitarianLaw", "Overview",findDisplay 46] call BIS_fnc_openFieldManual;
    },				
    {},													// Code executed on interrupted
    [],													// Arguments passed to the scripts as _this select 3
    0.5,													// Action duration [s]
    0,													// Priority
    false,												// Remove on completion
    false												// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0, _laptop];	// MP compatible implementation