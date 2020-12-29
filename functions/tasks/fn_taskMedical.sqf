If (!isServer) exitWith {};

_debug = missionNamespace getVariable ["MIS_debugMode",false];
_todeletearray = [];

//random position near houses
_randomPos = [
    ["marker_AO_1"],
    ["water",[markerpos "marker_idapbase",500]],
    {_this getEnvSoundController "houses" > 0}
] call BIS_fnc_randomPos;
If (_randomPos isEqualTo [0,0]) exitWith {
    If _debug then {
        systemChat "No Position found, exiting medicalemergency script...";
    };
};

_randomhouse = _randompos nearObjects ["house",100] select {count (_x buildingPos -1) > 2};
_randomhouse = selectRandom _randomhouse;
If (isNil "_randomHouse") exitWith {
    If _debug then {
        systemChat "No Building found, exiting medicalemergency script...";
    };
};
_buildingPos = selectRandom (_randomhouse buildingPos -1);

//create civilian
_civGroup = createGroup [civilian,true];
_civ = _civGroup createUnit [selectRandom CivUnitPool,_buildingPos,[],0,"CAN_COLLIDE"];
_civ setdir random 360;
{
    _civ disableAI _x;
} forEach ["MOVE","TARGET","AUTOTARGET","AUTOCOMBAT"];
_civ switchAction "agonyStart";
//_civ setDamage 0.3;
[
	_civ,											// Object the action is attached to
	"Stabilize",										// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",	// Progress icon shown on screen
	"_this distance _target < 3 && alive _target",						// Condition for the action to be shown
	"_caller distance _target < 3 && alive _target",						// Condition for the action to progress
	{ // Code executed when action starts
        params ["_target", "_caller", "_actionId", "_arguments"];
        _caller playAction "medicStartUp";
    },													
	{},													// Code executed on every progress tick
	{ // Code executed on completion
        params ["_target", "_caller", "_actionId", "_arguments"];
        _target setVariable ["AAS_stabilized",true,true];
        //_target playActionNow "agonyStop";
        //[_target] joinSilent group _caller;
        //{
        //    _target enableAI _x;
        //} forEach ["MOVE","TARGET","AUTOTARGET","AUTOCOMBAT"];
    },				
	{ // Code executed on interrupted
        params ["_target", "_caller", "_actionId", "_arguments"];
        _caller playActionNow "medicStop";
    },													
	[],													// Arguments passed to the scripts as _this select 3
	12,													// Action duration [s]
	0,													// Priority
	true,												// Remove on completion
	false												// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0, _civ];	// MP compatible implementation

[
	_civ,											// Object the action is attached to
	"Load in Ambulance",										// Title of the action
	"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",	// Idle icon shown on screen
	"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",	// Progress icon shown on screen
    // Condition for the action to be shown
	"_this distance _target < 7
    && alive _target
    && _target getVariable ['AAS_stabilized',false]
    && count (_this nearObjects ['C_IDAP_Van_02_medevac_F', 35]) > 0",
    // Condition for the action to progress						
	"_caller distance _target < 7 && alive _target",						
	{ // Code executed when action starts
        params ["_target", "_caller", "_actionId", "_arguments"];
        _caller playAction "medicStartUp";
    },
	{},													// Code executed on every progress tick
	{ // Code executed on completion
        params ["_target", "_caller", "_actionId", "_arguments"];
        _ambulance = (_caller nearObjects ['C_IDAP_Van_02_medevac_F', 35]) select 0;
        _target moveInCargo [_ambulance, 4];
    },
	{ // Code executed on interrupted
        params ["_target", "_caller", "_actionId", "_arguments"];
        _caller playActionNow "medicStop";
    },
	[],													// Arguments passed to the scripts as _this select 3
	4,													// Action duration [s]
	0,													// Priority
	true,												// Remove on completion
	false												// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0, _civ];	// MP compatible implementation

//determine time, to and from, so twice
_dist2d = (_randomhouse distance2D markerpos "marker_idapbase") * 1.5;
//assuming 50 km/h and some leeway
_speed = 50/3.6; //transform to m/s
_leeway = sqrt(_dist2d)*2+37;
_etaDelta = _dist2d/_speed + _leeway;
_loseTime = time + _etaDelta;
_timestr = [_etaDelta, "MM:SS"] call BIS_fnc_secondsToString;
_daytimestr = [daytime+_etaDelta/(60^2), "HH:MM:SS"] call BIS_fnc_timeToString;

//create task
_parentTask = "TaskMedical";
_curNrTasks = count (_parentTask call BIS_fnc_taskChildren) + 1;
_TaskID = format ["%1_%2",_parentTask,_curNrTasks];
_titleParent = ((_parentTask call BIS_fnc_taskDescription) select 1) select 0;
_mapgrid = mapGridPosition _randomhouse;
_TaskTitle = format ["%1 (%2)",_titleParent,_curNrTasks];
_TaskDescription = format ["
A civilian, called %1, needs medical treatment at %2! Go there, stabilize him 
and bring him to the medical tent at base for further treatment. You have time until
%3 (%4).
",
    name _civ, _mapgrid, _daytimestr, _timestr
];
_TaskMarker = "";
[
    true,
    [_TaskID,_parentTask],
    [_TaskDescription,_TaskTitle,_TaskMarker],
    getpos _randomhouse,
    "AUTOASSIGNED",
    0,
    true,
    "default"
] call BIS_fnc_taskCreate;

//execute FSM
_fsmPath = format ["taskFSM\%1.fsm",_parentTask];
[_TaskID,_todeletearray,_civ,_loseTime] execFSM _fsmPath;