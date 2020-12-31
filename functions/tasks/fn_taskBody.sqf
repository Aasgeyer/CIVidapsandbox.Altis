If (!isServer) exitWith {};

_debug = missionNamespace getVariable ["MIS_debugMode",false];
_todeletearray = [];

//random position in woods
_randomPos = [0,0,0]; _try = 0;
while {
     (_randomPos isEqualTo [0,0,0] 
     OR  MIS_restrictedAreas findIf {_randomPos inArea _x} != -1) 
     && _try < 25
} do {
    _randomPos = selectBestPlaces [markerpos "marker_AO_1", markerSize "marker_AO_1" select 0, "forest+trees-meadow", 50, 1];
    _randomPos = (_randomPos select 0) select 0;
    _try = _try + 1;   
};
If (_randomPos isEqualTo [0,0,0]) exitWith {
    If _debug then {
        systemChat "No Position found, exiting medicalemergency script...";
    };
};

//create body
_deadbodyPool = selectRandom [AAS_RegularSoldierPool,AAS_GuerillaSoldierPool,CivUnitPool];
_deadBodyClass = selectRandom _deadbodyPool;
_deadBody = createGroup [civilian,true] createUnit [_deadBodyClass,_randomPos,[],0,"NONE"];
_faction = faction _deadBody;
removeFromRemainsCollector [_deadBody];
_deadBody disableAI "ALL";
_deadBody enableAI "ANIM";
_deadBody spawn {
    sleep 4;
    _this setDamage 1;
    _this setVelocity [random 2, random 2, random 2];
};
_bodyID = round random 1000;

[
	_deadBody,											// Object the action is attached to
	"Put in body bag",										// Title of the action
	"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",	// Idle icon shown on screen
	"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",	// Progress icon shown on screen
	"_this distance _target < 3 && !alive _target",						// Condition for the action to be shown
	"_caller distance _target < 3 && !alive _target",						// Condition for the action to progress
	{ // Code executed when action starts
        params ["_target", "_caller", "_actionId", "_arguments"];
        _caller playAction "medicStartUp";
        _bodybagtemp = createVehicle ["Land_Bodybag_01_empty_white_F",getpos _target,[],0,"CAN_COLLIDE"];
        _bodybagtemp enableSimulationGlobal false;
        _bodybagtemp setdir getdir _target;
        _bodybagtemp setVectorUp surfaceNormal position _bodybagtemp;
        _target setVariable ["AAS_bodyBagTemp",_bodybagtemp];
    },													
	{},													// Code executed on every progress tick
	{ // Code executed on completion
        params ["_target", "_caller", "_actionId", "_arguments"];
        _arguments params ["_bodyID"];
        deleteVehicle (_target getVariable ["AAS_bodyBagTemp",objNull]);
        _bodybag = createVehicle ["Land_Bodybag_01_white_F",getpos _target,[],0,"CAN_COLLIDE"];
        _bodybag enableSimulationGlobal false;
        _bodybag setdir getdir _target;
        _bodybag setVectorUp surfaceNormal position _bodybag;
        _bodyBag setVariable ["AAS_BodyID",_bodyID];
        [_bodyBag,nil,nil,[0]] call AAS_fnc_cargoload;
        deleteVehicle _target;
    },
	{ // Code executed on interrupted
        params ["_target", "_caller", "_actionId", "_arguments"];
        deleteVehicle (_target getVariable ["AAS_bodyBagTemp",objNull]);
    },
	[_bodyID],													// Arguments passed to the scripts as _this select 3
	4,													// Action duration [s]
	0,													// Priority
	true,												// Remove on completion
	false												// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0, _deadBody];	// MP compatible implementation

//area marker for search
If (_debug) then {
    _debugmrk = createMarker [format ["marker_bodyDebug_%1",_randomPos],_randomPos];
    _debugmrk setMarkerTypeLocal "mil_dot";
    _debugmrk setMarkerText str _bodyID;
    _todeletearray pushBack _debugmrk;
};

_radiusSearch = 50;
_areapos = _randomPos getpos [random _radiusSearch,random 360];
_areamrk = createMarker [format ["marker_bodyArea_%1",_randomPos],_areapos];
_areamrk setMarkerShapeLocal "ELLIPSE";
_areamrk setMarkerColorLocal "ColorOrange";
_areamrk setMarkerBrushLocal "FDiagonal";
_areamrk setMarkerAlphaLocal 0.85;
_areamrk setMarkerSize [_radiusSearch,_radiusSearch];
_todeletearray pushBack _areamrk;

//create task
_parentTask = "TaskBody";
_curNrTasks = count (_parentTask call BIS_fnc_taskChildren) + 1;
_TaskID = format ["%1_%2",_parentTask,_curNrTasks];
_mapgrid = mapGridPosition _areapos;
_factionDisplayName = [configfile >> "CfgFactionClasses" >> _faction] call BIS_fnc_displayName;
_titleParent = ((_parentTask call BIS_fnc_taskDescription) select 1) select 0;
_TaskTitle = format ["%1 (%2)",_titleParent,_curNrTasks];
_TaskDescription = format ["
We have an approximate location around grid %1 of a body of a person, which we should retrieve.
He was a member of the %2.
",
    _mapgrid, _factionDisplayName
];
_TaskMarker = _areamrk;
[
    true,
    [_TaskID,_parentTask],
    [_TaskDescription,_TaskTitle,_TaskMarker],
    _areapos,
    "AUTOASSIGNED",
    0,
    true,
    "default"
] call BIS_fnc_taskCreate;

//execute FSM
_fsmPath = format ["taskFSM\%1.fsm",_parentTask];
[_TaskID,_todeletearray,_deadBody,_bodyID] execFSM _fsmPath;