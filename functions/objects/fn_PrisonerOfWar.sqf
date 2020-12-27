params [
    ["_unit",ObjNull],
    ["_caller",objNull],
    ["_actionID",-1],
    ["_args",[0]]
];
_args params ["_mode"];

switch (_mode) do {
    case 0: {
        _unit setCaptive true;
        _unit disableAI "ALL";
        _unit enableAI "ANIM";
    };
};