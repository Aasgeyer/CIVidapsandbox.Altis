#define M *10^6
#define K *10^3
TER_maxFunds = parsingNamespace getVariable "TER_maxFunds";
if (isServer) then {
	TER_baseFunds = 10K;
	publicVariable "TER_baseFunds";
};

TER_zeusCost = [];
"true" configClasses (missionConfigFile >> "CfgAssets") apply {
	private _name = configName _x;
	private _cost = getNumber(_x >> "costZeus");
	TER_zeusCost append [_name, _cost];
};
[] spawn {
	waitUntil {time > 1};
	[] call TER_fnc_loadCuratorCosts;
};
