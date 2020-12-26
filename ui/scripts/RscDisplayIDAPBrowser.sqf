params ["_mode", "_params"];
switch _mode do {
	case "onLoad":{
		_params params ["_display"];
	};
	case "onUnload":{
		_params params ["_display", "_exitCode"];
	};
};