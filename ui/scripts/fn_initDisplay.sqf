/*
	Author: Terra

	Description:
		Sets up the UI framework, calls onLoad and onUnload events.

	Parameter(s):
		0:	STRING - Mode in which to execute. One of: preInit, onLoad, onUnload
		1:	ARRAY - Arguments from the UIEH
		2:	STRING - Classname of the display

	Returns:
		Nothing

	Example(s):
		["preInit"] call TER_fnc_initDisplay;
		["onLoad", _this, "RscDisplayFinancialReport"] call TER_fnc_initDisplay;
*/
params ["_mode", "_params", "_class"];
private _fnc = format ["%1_script", _class];

if (_mode == "preInit") exitWith {
	//--- Compile UI scripts
	"isText(_x >> 'scriptName')" configClasses missionConfigFile apply {
		missionNamespace setVariable [
			_fnc,
			compile preprocessFileLineNumbers format["ui\scripts\%1.sqf", configName _x]
		];
	};
};

if (_mode == "onLoad") then {
	_params params ["_display"];
	//--- Register Display
	//--- Call display function
	private _fncCode = [
		missionNamespace getVariable _fnc,
		compile preprocessFileLineNumbers format["ui\scripts\%1.sqf", _class]
	] select (getNumber (missionConfigFile >> "allowFunctionsRecompile") > 0);
	if !(isNil "_fncCode") then {
		["onLoad", _params, _class] call _fncCode;
	};

	//--- Save controls with their classname to the display
	allControls _display apply {
		_display setVariable [ctrlClassName _x, _x];
	};
} else {
	//--- Unload
	_params params ["_display", "_exitCode"];
};
nil