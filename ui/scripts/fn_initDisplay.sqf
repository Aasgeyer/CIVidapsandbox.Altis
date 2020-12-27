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

if (_mode == "preInit") exitWith {
	//--- Compile UI scripts
	"isText(_x >> 'scriptName')" configClasses missionConfigFile apply {
		_fnc = format ["%1_script", configName _x];
		diag_log parseText format ["Compiling %1 for display %2", _fnc, configName _x];
		missionNamespace setVariable [
			_fnc,
			compile preprocessFileLineNumbers format["ui\scripts\%1.sqf", configName _x]
		];
	};
};

private _fnc = format ["%1_script", _class];

if (_mode == "onLoad") then {
	_params params ["_display"];
	//--- Save controls with their classname to the display
	allControls _display apply {
		private _varHolder = [
			ctrlParentControlsGroup _x, 
			_display
		] select (isNull ctrlParentControlsGroup _x);
		_varHolder setVariable [ctrlClassName _x, _x];
	};
	//--- Register Display
	//--- Call display function
	private _fncCode = [
		missionNamespace getVariable _fnc,
		compile preprocessFileLineNumbers format["ui\scripts\%1.sqf", _class]
	] select (getNumber (missionConfigFile >> "allowFunctionsRecompile") > 0);
	if !(isNil "_fncCode") then {
		["onLoad", _params, _class] call _fncCode;
	};

} else {
	//--- Unload
	_params params ["_display", "_exitCode"];
};
nil