/*
    Author: Aasgeyer

    Description:
        Task Demine Road.

    Parameter(s): None

    Returns: Nothing

    Example(s):
        [] call AAS_fnc_TaskDemineRoad; //-> nothing
*/

If (!isServer) exitWith {};

_debug = missionNamespace getVariable ["MIS_debugMode",false];
_todeletearray = [];

//random position with roads near
_AOcombat = selectRandomWeighted AO_markerCombatZonesWeighted;
_randomPos = [
    [_AOcombat],
    ["water"],
    {
        count (_this nearRoads 150) > 6 // more than n roads in radius
        && MIS_idapoutposts findIf {
            _x distance2D _this < 150
            && (_x getVariable ["AAS_IDAPOutPostActive",false])
        } == -1
        && MIS_restrictedAreas findIf {_this inArea _x} == -1
    } 
] call BIS_fnc_randomPos;

_OutpostsClose = MIS_idapoutposts select {_x distance2D _randomPos < 300};
{
    _x setVariable ["AAS_IDAPoutpostActive",true,true];
} forEach _OutpostsClose;

//define roads and pools of mines
_roadsNear = _randomPos nearRoads 150;
_meanPos = [0,0,0];
_Unconventional = ["ATMine","IEDLandBig_F","IEDLandSmall_F","IEDUrbanSmall_F","IEDUrbanBig_F"];
_Conventional = ["ATmine","SLAMDirectionalMine"];
_APminePool = ["APERSMine","APERSBoundingMine"];
_minePools = [_Unconventional,_Conventional];
_mineATPool = selectRandom _minePools;
_trashPool = ["Land_Garbage_square3_F","Land_Garbage_square5_F","Land_Garbage_line_F"];

_mineArray = [];
_posArray = [];
//create mines for the roads
{
    //create marker on road
    _roadInfo = getroadInfo _x;
    _roadpos = getpos _x;
    _roadInfo params ["", "_width", "", "", "", "", "_begPos", "_endPos", "_isBridge"];
    _markerRoad = createMarker [format ["marker_road_%1_%2",_x,random 1000],_x];
    _roaddir = _begpos getdir _endpos;
    _markerRoad setMarkerSizeLocal [_width*0.5, (_begpos distance2D _endpos) * 0.5];
    _markerRoad setMarkerShapeLocal "RECTANGLE";
    _markerRoad setMarkerColorLocal "ColorRed";
    _markerRoad setMarkerDirLocal _roadDir;
    _markerRoad setMarkerBrush "Grid";
    _toDeleteArray pushBack _markerRoad;
    _posArray pushBack getpos _x;
    //for warning marker at average center posisiton of all roads
    _summedXpos = _meanPos#0 + _roadpos#0;
    _summedYpos = _meanPos#1 + _roadpos#1;
    _meanPos = [_summedXpos,_summedYpos,0];
    // spawn mine with a chance for this road segment
    
    _lambda = 1;
    _chance = _lambda*exp(-(_foreachindex-2)*_lambda);
    if (random 1 < _chance OR _foreachindex == 0) then {
        _minePos = _markerRoad call BIS_fnc_randomPosTrigger;
        _mineClass = selectRandom _mineATPool;
        _mine = createMine [_mineClass,_minePos,[],0];
        _mine setdir random 360;
        _mine setVectorUp surfaceNormal getpos _mine;
        _mineArray pushBack _mine;
        //debug marker on mine
        If (_debug) then {
            _markerMine = createMarker [format ["marker_road_%1",_mine],_mine];
            _markerMine setMarkerTypeLocal "mil_warning";
            _markerMine setMarkerColorLocal "ColorRed";
            _markermine setmarkerSize [0.35,0.35];
            _toDeleteArray pushBack _markermine;
        };
        //if SLAM set up direction towards road center
        If (tolower _mineClass isEqualTo "slamdirectionalmine") then {
            _mine setdir (_mine getDir _x);
        } else {
            _mine setdir random 360;
        };
        //with chance create also an AP mine around AT mine
        _chance = 0.5;
        If (random 1 < _chance) then {
            _APmineClass = selectRandom _APminePool;
            _APmine = createMine [_APmineClass,_minePos,[],1];
            _APmine setVectorUp surfaceNormal getpos _APmine;
            _mineArray pushBack _APmine;
        };
        //with chance create junk around mine to conceal it
        _chance = 0.5;
        If (random 1 < _chance) then {
            _trashClass = selectRandom _trashPool;
            _junk = createVehicle [_trashClass,_minepos,[],3,"CAN_COLLIDE"];
            _junk setdir random 360;
            _junk setVectorUp surfaceNormal getpos _junk;
            _toDeleteArray pushBack _junk;
        };
    };
    //with a chance create random junk on road
    _chance = 0.25;
    If (random 1 < _chance) then {
        _trashClass = selectRandom _trashPool;
        diag_log _trashPool;
        diag_log _trashClass;
        _junkPos = _markerRoad call BIS_fnc_randomPosTrigger;
        _junk = createVehicle [_trashClass,_junkPos,[],0,"CAN_COLLIDE"];
        _junk setdir random 360;
        _junk setVectorUp surfaceNormal getpos _junk;
        _toDeleteArray pushBack _junk;
    };

} foreach (_roadsNear call BIS_fnc_arrayShuffle);
_mineCount = count _mineArray;

//create marker on central pos
_meanpos = _meanPos vectorMultiply (1/(count _roadsNear));
_markerMeanPos = createMarker [format ["marker_road_%1",_meanPos],_meanPos];
_markerMeanPos setMarkerTypeLocal "mil_warning";
_markermeanPos setMarkerColorLocal "ColorRed";
_markerMeanPos setMarkerText "Mined Road";
_toDeleteArray pushBack _markerMeanPos;

//calculate reward
_worldSizeR = sqrt 2 * (worldSize/2);
_dist2d = _meanpos distance2D markerpos "marker_idapBase";
_funding = linearConversion [0,_worldSizeR,_dist2d,800,8000];
_funding = round _funding;
_fundingStr = _funding call BIS_fnc_numberText;

//create task
_parentTask = "TaskDemineRoad";
_curNrTasks = count (_parentTask call BIS_fnc_taskChildren) + 1;
_TaskID = format ["%1_%2",_parentTask,_curNrTasks];
_mapgrid = mapGridPosition _meanPos;
_titleParent = ((_parentTask call BIS_fnc_taskDescription) select 1) select 0;
_TaskTitle = format ["%1 (%2)",_titleParent,_curNrTasks];
_TaskDescription = format ["
We got reports of a road riddled with mines near mapgrid %1. Go clear it!
 Expect %2 to %3 mines there.<br/>
 Reward: + %4$ to daily funding.
",
    _mapgrid, round (_mineCount*(random [0,0.9,1])), round (_mineCount*(1 + random [0,0.1,1])), _fundingStr
];
_TaskMarker = _markerMeanPos;
[
    true,
    [_TaskID,_parentTask],
    [_TaskDescription,_TaskTitle,_TaskMarker],
    _meanPos,
    "AUTOASSIGNED",
    0,
    true,
    "default"
] call BIS_fnc_taskCreate;

//execute FSM
_fsmPath = format ["taskFSM\%1.fsm",_parentTask];
[_TaskID,_todeletearray,_mineArray,_meanPos,_OutpostsClose,_funding] execFSM _fsmPath;