"true" configClasses (missionConfigFile >> "CfgFunctions") apply {
	_tag = configName _x;
	"true" configClasses _x apply {
		_path = getText(_x >> "file");
		if (_path == "") then {_path = format ["functions\%1", configName _x]};
		"true" configClasses _x apply {
			_fnc = configName _x;
			_file = format ["fn_%1.sqf", configName _x];
			_name = format ["%1_fnc_%2", _tag, _fnc];
			_fullPath = format ["%1\%2", _path, _file];
			_code = compile preprocessFileLineNumbers _fullPath;
			diag_log parseText format ["Compiling %1 from %2", _name, _fullPath];
			missionNamespace setVariable [_name, _code];
		};
	};
};

/* ["init", "initServer"] apply {
	[] call compile preprocessFileLineNumbers format ["%1.sqf", _x];
}; */