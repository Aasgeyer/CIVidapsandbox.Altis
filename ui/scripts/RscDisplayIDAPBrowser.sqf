#define COLOR_IDAP [0.784314,0.286275,0,1]
#define SELF RscDisplayIDAPBrowser_script
#define BREAK if true exitWith {}

private _cfgDisplay = missionConfigFile >> "RscDisplayIDAPBrowser";
params ["_mode", "_params"];
switch _mode do {
	case "onLoad":{
		_params params ["_display"];

		//--- Navigation bar
		_ctrlNavbar = _display getVariable "NavbarLeft";
		_ctrlActivity = _ctrlNavbar getVariable "Activity";
		_ctrlFinances = _ctrlNavbar getVariable "Finances";
		_ctrlReports = _ctrlNavbar getVariable "Reports";
		_ctrlPrices = _ctrlNavbar getVariable "Prices";
		_ctrlCredits = _ctrlNavbar getVariable "Credits";
		[_ctrlActivity, _ctrlFinances, _ctrlReports, _ctrlPrices, _ctrlCredits] apply {
			_x ctrlAddEventHandler ["ButtonClick",{
				["changeTopic", _this] call SELF;
			}];
		};

		//--- Activity
		_ctrlGrpActivity = _display getVariable "GroupActivity";
		_ctrlActivityList = _ctrlGrpActivity getVariable "List";
		TER_hints apply {
			_x params ["_title", "_body"];
			ctAddRow _ctrlActivityList params ["_ind", "_row"];
			_row params ["_ctrlBackground", "_ctrlTitle", "_ctrlContent", "_ctrlMore"];
			_ctrlBackground ctrlSetBackgroundColor [0,0,0,0.8];
			_ctrlTitle ctrlSetStructuredText parseText _title;
			_ctrlContent ctrlSetStructuredText parseText _body;
			_ctrlMore ctrlSetText "More...";
		};

		//--- Prices
		_ctrlGrpPrices = _display getVariable "GroupPrices";
		_ctrlList = _ctrlGrpPrices getVariable "List";
		["fillPriceList", [_ctrlList]] call SELF;
		_ctrlSort = _ctrlGrpPrices getVariable "Sort";
		_ctrlOrder = _ctrlGrpPrices getVariable "Order";
		[_ctrlSort, _ctrlOrder] apply {
			_x ctrlAddEventHandler ["LBSelChanged",{
				["pricesSortChanged", [ctrlParent(_this#0)]] call SELF;
			}];
		};
		["pricesSortChanged", [_display]] call SELF;
	};
	case "changeTopic":{
		_params params ["_ctrl"];
		private _display = ctrlParent _ctrl;
		_cfgCtrl = _cfgDisplay >> "controls" >> "NavbarLeft" >> "controls" >> ctrlClassName _ctrl;
		private _ctrlGroup = getText(_cfgCtrl >> "group");
		_ctrlGroup = _display getVariable _ctrlGroup;
		private _allGroups = "isText(_x >> 'textTitle')" configClasses (_cfgDisplay >> "controls");
		_allGroups = _allGroups apply {
			private _xG = _display getVariable configName _x;
			_xG ctrlShow (_xG == _ctrlGroup);
			_xG
		};
		_cfgGroup = _cfgDisplay >> "controls" >> ctrlClassname _ctrlGroup;
		_ctrlContentTitle = _display getVariable "ContentTitle";
		_ctrlContentTitle ctrlSetText getText(_cfgGroup >> "textTitle");
		_ctrlContentDescription = _display getVariable "ContentDescription";
		_ctrlContentDescription ctrlSetText getText(_cfgGroup >> "textDescription");
	};
	case "pricesSortChanged":{
		_params params ["_display"];
		_ctrlGrpPrices = _display getVariable "GroupPrices";
		_ctrlSort = _ctrlGrpPrices getVariable "Sort";
		_ctrlOrder = _ctrlGrpPrices getVariable "Order";
		private _ind = lbCurSel _ctrlSort;
		private _list = "true" configClasses (missionConfigFile >> "CfgAssets");
		_list = _list apply {
			if (_ind == 2) then {
				//--- Sort by price
				[getNumber(_x >> "cost"), _x]
			} else {
				//--- Sort by name
				[[configFile >> "CfgVehicles" >> configName _x] call BIS_fnc_displayName, _x]
			};
		};
		_list sort !(lbCurSel _ctrlOrder == 2);
		_list = _list apply {configName (_x#1)};
		_ctrlList = _ctrlGrpPrices getVariable "List";
		["fillPriceList", [_ctrlList, _list]] call SELF;
	};
	case "fillPriceList":{
		_params params ["_ctrlList", ["_list", TER_zeusCost select {_x isEqualType ""}]];
		private _fncText = {
			params ["_ctrl", "_text"];
			_ctrl ctrlSetTextColor [0,0,0,1];
			_ctrl ctrlSetStructuredText parseText format [
				"<t shadow='0'>%1</t>",
				_text
			];
		};
		ctClear _ctrlList;
		_list apply {
			private _cost = [_x] call TER_fnc_getCost;
			private _cfg = configFile >> "CfgVehicles" >> _x;
			private _image = getText(_cfg >> "editorPreview");
			ctAddRow _ctrlList params ["_ind", "_row"];
			_ctrlList ctSetValue [_ind, _cost];
			_row params ["_ctrlFrame", "_ctrlImage", "_ctrlName", "_ctrlDescription", "_ctrlPrice"];
			_ctrlFrame ctrlSetTextColor [0,0,0,1];
			_ctrlImage ctrlSetText _image;
			_ctrlName ctrlSetBackgroundColor [0,0,0,1];
			[_ctrlName, _cfg call BIS_fnc_displayName] call _fncText;
			_ctrlName ctrlSetTextColor [1,1,1,1];
			private _desc = getText(_cfg >> "Library" >> "libTextDesc");
			if (_desc == "") then {_desc = "&lt;No description provided by the seller&gt;"};
			[_ctrlDescription, _desc] call _fncText;
			//_ctrlPrice ctrlSetBackgroundColor [0.52,0.73,0.40,0.8];
			[_ctrlPrice, format ["<t size='1.5' align='center'>%1 $</t>", [_cost] call BIS_fnc_numberText]] call _fncText;
		};
	};
	case "onUnload":{
		_params params ["_display", "_exitCode"];
	};
};