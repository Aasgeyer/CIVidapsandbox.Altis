params ["_mode", "_params"];
diag_log _this;
switch _mode do {
	case "onLoad":{
		_params params ["_display"];
		_ctrlEntries = _display displayCtrl 101;
		diag_log [_display, _ctrlEntries];
		for "_i" from 0 to 2 do {
			ctAddRow _ctrlEntries params ["_ind", "_row"];
			_row params ["_ctrlBackground", "_ctrlTitle", "_ctrlContent", "_ctrlMore"];
			_ctrlBackground ctrlSetBackgroundColor [0,0,0,0.8];
			_ctrlTitle ctrlSetText "Money Spent";
			_ctrlContent ctrlSetText "Very long text with formatting possible";
			_ctrlMore ctrlSetText "READ MORE...";
		};
	};
	case "onUnload":{
		_params params ["_display", "_exitCode"];
	};
};