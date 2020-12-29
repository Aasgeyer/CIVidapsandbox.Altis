If (!isServer) exitWith {};

_debug = missionNamespace getVariable ["MIS_debugMode",false];
_todeletearray = [];

//random position near houses
_radiusHouses = 150;
_randomPos = [0,0];
_try = 0;
while { _randompos isequalto [0,0] && _try <= 25} do {
    _randomPos = [
        ["marker_AO_1"],
        ["water",[markerpos "marker_idapbase",500]],
        {
            _counthouses = {count (_x buildingPos -1) > 2} count (_this nearObjects ["house",_radiusHouses]);
            _counthouses >= 5
            && MIS_idapoutposts findIf {_x distance2D _this < _radiusHouses*4} == -1
        }
    ] call BIS_fnc_randomPos;
};

If (_randomPos isEqualTo [0,0]) exitWith {
    If _debug then {
        systemChat "No Position found, exiting medicalemergency script...";
    };
};

_areamrk = createMarker [format ["marker_evacuateArea_%1",_randomPos],_randomPos];
_areamrk setMarkerShapeLocal "ELLIPSE";
_areamrk setMarkerColorLocal "ColorOrange";
_areamrk setMarkerBrushLocal "SolidBorder";
_areamrk setMarkerAlphaLocal 1;
_areamrk setMarkerSize [_radiusHouses,_radiusHouses];
_todeletearray pushBack _areamrk;

_evacuationPoint = [[_areamrk]] call BIS_fnc_randomPos;
_evacmrk = createMarker [format ["marker_evacPoint_%1",_evacuationPoint],_evacuationPoint];
_evacmrk setMarkerTypeLocal "mil_pickup";
_evacmrk setMarkerText "Evacuation Point";
_todeletearray pushBack _evacmrk;

_houses = (_randomPos nearObjects ["house",_radiusHouses]) select {count (_x buildingPos -1) > 2};
_civEvacuteesArray = [];
{
    If ((random 1 < 0.75 && count _civEvacuteesArray <= 14) OR _foreachindex < 2) then {
        _y = _x;
        _bposarray = (_y buildingPos -1);
        {
            _expDistr = 3*exp(-(_foreachindex-0.64)*3);
            If (_expDistr > random 1 && count _civEvacuteesArray <= 14) then {
                _civGrp = createGroup [civilian,true];
                _bpos = _x;
                _civ = _civGrp createUnit [selectRandom CivUnitPool,_bpos,[],0,"CAN_COLLIDE"];
                _civ setdir random 360;
                _civEvacuteesArray pushBack _civ;
                _todeletearray pushBack _civ;
                [
                    _civ,											// Object the action is attached to
                    "Follow Me",										// Title of the action
                    "\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa",	// Idle icon shown on screen
                    "\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa",	// Progress icon shown on screen
                    "_this distance _target < 7 && alive _target && !(group _target isEqualto group _this)",						// Condition for the action to be shown
                    "_caller distance _target < 15 && alive _target && !(group _target isEqualto group _this)",						// Condition for the action to progress
                    {// Code executed when action starts
                        params ["_target", "_caller", "_actionId", "_arguments"];
                        _saymessage = format ["IDAP_FollowOrder_%1",ceil (0.0001 + random 5.999)];
                        [_caller, _saymessage] remoteExec ["directSay",_caller];
                    },													
                    {},													// Code executed on every progress tick
                    {// Code executed on completion
                        _saymessage = format ["C_FollowConfirm_%1",ceil (0.0001 + random 5.999)];
                        [_target, _saymessage] remoteExec ["directSay",_caller];
                        [_target] join group _caller;
                    },				
                    {},													// Code executed on interrupted
                    [],													// Arguments passed to the scripts as _this select 3
                    2,													// Action duration [s]
                    0,													// Priority
                    false,												// Remove on completion
                    false												// Show in unconscious state
                ] remoteExec ["BIS_fnc_holdActionAdd", 0, _civ];	// MP compatible implementation
            };
        } foreach _bposarray;
    };
} foreach _houses;
_nrOfCivs = count _civEvacuteesArray;

//determine time
_dist2d = _randomPos distance2D markerpos "marker_idapbase";
//assuming 40 km/h and some leeway
_speed = 40/3.6; //transform to m/s
_leeway = sqrt(_dist2d)+37;
_etaDelta = _dist2d/_speed + _leeway + 10*_nrOfCivs;
_loseTime = time + _etaDelta;
_timestr = [_etaDelta, "MM:SS"] call BIS_fnc_secondsToString;
_daytimestr = [daytime+_etaDelta/(60^2), "HH:MM:SS"] call BIS_fnc_timeToString;

//create task
_parentTask = "TaskEvacuate";
_curNrTasks = count (_parentTask call BIS_fnc_taskChildren) + 1;
_TaskID = format ["%1_%2",_parentTask,_curNrTasks];
_TaskTitle = format ["Evacuation (%1)",_curNrTasks];
_TaskDescription = format ["
AAF and FIA are closing on on the designated area near mapgrid %1. Evacuate the local populace there!
 Expect %2 people to take with you.
 You have time until %3 (%4) before they set out on their own.
 (optional) Drop leaflets so that they gather at the evacuation point.
", mapGridPosition _randomPos, _nrOfCivs, _daytimestr, _timestr
];
_TaskMarker = _evacmrk;
[
    true,
    [_TaskID,_parentTask],
    [_TaskDescription,_TaskTitle,_TaskMarker],
    _randomPos,
    "AUTOASSIGNED",
    0,
    true,
    "default"
] call BIS_fnc_taskCreate;

//execute FSM
_fsmPath = format ["taskFSM\%1.fsm",_parentTask];
[_TaskID,_todeletearray,_civEvacuteesArray,_evacuationPoint,_loseTime,_randomPos] execFSM _fsmPath;