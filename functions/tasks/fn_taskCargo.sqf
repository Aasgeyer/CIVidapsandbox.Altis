If (!isServer) exitWith {};

_debug = missionNamespace getVariable ["MIS_debugMode",false];
_todeletearray = [];

//random destination
_destination = selectRandom MIS_idapoutposts;
//random supply
_supplyneeded = selectRandom MIS_VanCargoObjectClasses;

//create Trigger
_trg = createTrigger ["EmptyDetector",getpos _destination];
_trg setTriggerActivation ["ANY","PRESENT",false];
_trg setTriggerArea [15,15,0,false];
_condtrg = format [
    "{
        alive _x
        && IsNull isVehicleCargo _x
    } count (
        position ThisTrigger nearObjects [
            %1, (TriggerArea ThisTrigger) select 0
        ]
    ) > 0",
str _supplyneeded];
_acttrg = format ["
    _nearCargo = position ThisTrigger nearObjects [%1, (TriggerArea ThisTrigger) select 0];
    _nearCargo#0 setvariable ['CargoLoadingEnabled',false,true];
",str _supplyneeded];
_deacttrg = "";
_trg setTriggerStatements [_condtrg,_acttrg,_deacttrg];
_todeletearray pushBack _trg;

//determine time
_dist2d = _destination distance2D markerpos "marker_AO_1";
//assuming 50 km/h and some leeway
_speed = 50/3.6; //transform to m/s
_leeway = sqrt(_dist2d)*2+37;
_etaDelta = _dist2d/_speed + _leeway;
_loseTime = time + _etaDelta;
_timestr = [_etaDelta, "MM:SS"] call BIS_fnc_secondsToString;
_daytimestr = [daytime+_etaDelta/(60^2), "HH:MM:SS"] call BIS_fnc_timeToString;

//create task
_parentTask = "TaskCargo";
_curNrTasks = count (_parentTask call BIS_fnc_taskChildren) + 1;
_TaskID = format ["%1_%2",_parentTask,_curNrTasks];
_mapgrid = mapGridPosition _destination;
_displayname = [configFile >> "CfgVehicles" >> _supplyneeded] call BIS_fnc_displayName;
_displayPicture = gettext (configfile >> "CfgVehicles" >> _supplyneeded >> "editorPreview");
_TaskTitle = format ["Deliver Cargo (%1)",_curNrTasks];
_TaskDescription = format ["
Deliver %1 to the IDAP workers at mapgrid %2. You have time until %3 (%4)!<br/>
<img image='%5' width='114' height='59'/>
",
    _displayname, _mapgrid, _daytimestr, _timestr, _displayPicture
];
_TaskMarker = "";
[
    true,
    [_TaskID,_parentTask],
    [_TaskDescription,_TaskTitle,_TaskMarker],
    getpos _destination,
    "AUTOASSIGNED",
    0,
    true,
    "default"
] call BIS_fnc_taskCreate;

//execute FSM
[_TaskID,_todeletearray,_trg,_loseTime] execFSM "taskFSM\taskCargo.fsm";