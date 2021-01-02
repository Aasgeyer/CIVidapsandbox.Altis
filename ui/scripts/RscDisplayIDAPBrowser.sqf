#define COLOR_IDAP [0.784314,0.286275,0,1]
#define SELF RscDisplayIDAPBrowser_script
#define STRSELF #SELF
#define BREAK if true exitWith {}

params ["_mode", "_params"];

//--- Controls
private _display = uiNamespace getVariable "RscDisplayIDAPBrowser";
private _ctrlGroupGarage = _display getVariable "GroupGarage";
	private _ctrlGroupGarageList = _ctrlGroupGarage getVariable "List";
	private _ctrlGroupGarageStatus = _ctrlGroupGarage getVariable "Status";

private _cfgDisplay = missionConfigFile >> "RscDisplayIDAPBrowser";

switch _mode do {
	case "onLoad":{
		_params params ["_display"];

		//--- Navigation bar
		_ctrlNavbar = _display getVariable "NavbarLeft";
		_ctrlActivity = _ctrlNavbar getVariable "Activity";
		_ctrlFinances = _ctrlNavbar getVariable "Finances";
		_ctrlGarage = _ctrlNavbar getVariable "Garage";
		_ctrlPrices = _ctrlNavbar getVariable "Prices";
		_ctrlCredits = _ctrlNavbar getVariable "Credits";
		[_ctrlActivity, _ctrlFinances, _ctrlGarage, _ctrlPrices, _ctrlCredits] apply {
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

		//--- Garage
		_ctrlGrpGarage = _display getVariable "GroupGarage";
		_ctrlList = _ctrlGrpGarage getVariable "List";
		["requestVehicles"] remoteExecCall [STRSELF, 2];
		_ctrlGroupGarageStatus ctrlSetText "Requesting vehicles from server...";
	};
	case "requestVehicles":{
		private _vehicleList = "getSections" call TER_db_assets select {
			["read", [_x, "stored", false]] call TER_db_assets
		};
		_vehicleList = _vehicleList apply {
			[_x, ["read", [_x, "class"]] call TER_db_assets]
		};
		["receiveVehicles", [_vehicleList]] remoteExecCall [STRSELF, remoteExecutedOwner];
	};
	case "receiveVehicles":{
		_params params ["_vehicleList"];
		diag_log _vehicleList;
		_display = uiNamespace getVariable "RscDisplayIDAPBrowser";
		_ctrlGrpGarage = _display getVariable "GroupGarage";
		_ctrlList = _ctrlGrpGarage getVariable "List";
		_vehicleList apply {
			_x params ["_id", "_class"];
			private _cfg = configFile >> "CfgVehicles" >> _class;
			private _img = getText(_cfg >> "editorPreview");
			private _name = _cfg call BIS_fnc_displayName;
			ctAddRow _ctrlList params ["_ind", "_row"];
			_row params ["_ctrlImage", "_ctrlName", "_ctrlRetrieve"];
			_ctrlImage ctrlSetText _img;
			_ctrlName ctrlSetText _name;
			_ctrlRetrieve ctrlSetText "Retrieve";
			_ctrlList ctSetData [_ind, _id];
			_ctrlRetrieve setVariable ["id", _id];
			_ctrlRetrieve setVariable ["class", _class];
			_ctrlRetrieve ctrlAddEventHandler ["ButtonClick",{
				["retrieveVehicle", _this] call SELF;
			}];
		};
		_ctrlGroupGarageStatus ctrlSetText "Vehicles loaded from server.";
	};
	case "retrieveVehicle":{
		_params params ["_ctrlRetrieve"];
		private _class = _ctrlRetrieve getVariable "class";
		private _id = _ctrlRetrieve getVariable "id";
		_ctrlGroupGarageStatus ctrlSetText "Request for retrieving the vehicle sent...";
		["requestRetrival", _id] remoteExecCall [STRSELF, 2];
	};
	case "requestRetrival":{
		_params params ["_id"];
		_veh = [_id] call TER_fnc_garageRetrieve;
		["receiveRetrival", [_veh, _id]] remoteExecCall [STRSELF, remoteExecutedOwner];
	};
	case "receiveRetrival":{
		_params params ["_veh", "_oldID"];
		_display = uiNamespace getVariable "RscDisplayIDAPBrowser";
		_ctrlGrpGarage = _display getVariable "GroupGarage";
		_ctrlList = _ctrlGrpGarage getVariable "List";
		if (isNull _veh) exitWith {
			//--- Vehicle could not be spawned.
			_ctrlGroupGarageStatus ctrlSetStructuredText parseText "<t color='#990000'>Failed.</t> Vehicle could not retrieved.";
		};
		for "_ind" from 0 to ctRowCount _ctrlList do {
			if (_ctrlList ctData _ind == _oldID) exitWith {
				diag_log _ind;
				[_ctrllist, _ind] spawn {
					params ["_ctrllist", "_ind"];
					_ctrlList ctRemoveRows [_ind];
				};
			};
		};
		_ctrlGroupGarageStatus ctrlSetStructuredText parseText "<t color='#009900'>SUCCESS.</t> Vehicle retrieved.";
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