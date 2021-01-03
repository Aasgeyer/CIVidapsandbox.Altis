/*
    Author: Aasgeyer

    Description:
        Creates a roadblock on a random road segment across the map

    Parameter(s):
        0:	nothing - /

    Returns:
        Bool - true if sucessful to create roadblock, false if no position found

    Example(s):
        [] call AAS_fnc_roadBlocks; //-> true, if successful
*/


If (!isServer) exitWith {};

_debug = missionNamespace getVariable ["MIS_debugMode",false];

if (isNil "AAS_roadBlockLogics") then {
    AAS_roadBlockLogics = [];
};

//array of arrays for road block compositions
#include "roadBlockCompositions.inc"

//define the logic class that is created on the roadblock
_logicClass = "LocationCamp_F";
//define arrow type on which units will spawn
_arrowClass = "Sign_Arrow_Direction_Green_F";

//get how many roadblocks already exist
_markerArray = ["marker_RoadBlock_"] call BIS_fnc_getMarkers;
_nrMarker = count _markerArray + 1;

// find random postion with roads nearby and no houses nearby
_randomPos = [
    nil,
    ["water"]+AO_markerCombatZones,
    {
        (_this nearRoads 150) findIf {
            count (roadsConnectedTo _x) != 2
        } == -1
        && count (_this nearRoads 150) > 5
        && count (_this nearObjects ["House",25]) == 0
        && MIS_restrictedAreas findIf {_this inArea _x} == -1
        && AAS_roadBlockLogics findIf {_this distance2D _x < 2500} == -1
    }
] call BIS_fnc_randomPos;

If (_randomPos isEqualTo [0,0]) exitWith {
    If (_debug) then {
        systemChat "No position for roadblock found. Exiting function...";
    };
    //return failed to create roadblock
    false
};

//get a road segment
_nearRoads = (_randomPos nearRoads 150) select {count (roadsConnectedTo _x) == 2};
_road = selectRandom _nearroads;
_roadInfo  = getRoadInfo _road;
_roadInfo params ["_mapType", "_width", "", "", "", "", "_begPos", "_endPos"];
_roadDir = _begpos getdir _endpos;
_roadPos = getpos _road;

_logic = createGroup sideLogic createUnit [_logicClass,_roadPos,[],0,"CAN_COLLIDE"];
AAS_roadBlockLogics pushBack _logic;


//create marker on roadblock and name it with NATO alphabet
_phoneticalNumber = If (_nrMarker > 26) then {
    _nrMarker - 26
} else {
    [_nrMarker] call BIS_fnc_phoneticalWord
};
_marker = createMarker [format ["marker_RoadBlock_%1",_nrMarker],_roadPos];
_marker setMarkerTypeLocal "mil_marker";
_marker setMarkerColorLocal "colorIndependent";
_marker setMarkerText format ["CP %1",_phoneticalNumber];

//hide near objects. Doesn't work?
//_nearObjects = _roadPos nearObjects 50;
_nearObjects = nearestTerrainObjects [_roadPos, [], 25, false, true];
_nearObjects apply {
    _x hideObjectGlobal true;
};

//create composition with direction of the road
_randomComposition = selectRandom _roadBlockCompositions;
_compositionDir = _roadDir + selectRandom [0,180];
//align created objects to surface
_objectArray = [_roadPos, _compositionDir, _randomComposition] call BIS_fnc_objectsMapper;
_objectArray apply {
    _x setVectorUp surfaceNormal position _x;
};
//create soldiers for checkpoint on arrows and hide arrows
_arrows = _objectArray select {_x isKindOf _arrowClass};
_group = createGroup [independent,true];
_group setBehaviour "SAFE";
_group enableDynamicSimulation true;
{
    _unit = _group createUnit [selectRandom AAS_RegularSoldierPool,_x,[],0,"NONE"];
    _unit setdir getdir _x;
    _unit setFormDir getdir _x;
    doStop _unit;
    _x hideObjectGlobal true;
} foreach _arrows;
//find strider and lock it
_striderIndex = _objectArray findIf {_x isKindOf "Car"};
_strider = _objectArray select _striderIndex;
_strider lock 3;
_strider enableDynamicSimulation true;
_logic action ["lighton", _strider];

//create trigger that detects if player is going too fast
_trg = createTrigger ["EmptyDetector", _roadPos];
_trg setTriggerArea [_width, 15, _roadDir, true, 15];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trg setVariable ["TriggerGroupCP",_group];
_trgCond = "this && thisList findIf {speed _x > 35} != -1";
//remove money as punishment
_trgAct = "
['CheckpointViolation'] call BIS_fnc_showNotification;
1000 call TER_fnc_removeMoney;
_trgGrp = thisTrigger getVariable ['TriggerGroupCP',GrpNull];
If (local leader _trgGrp) then {
    leader _trgGrp playAction 'gestureCeaseFire';
};
";
_trg setTriggerStatements [_trgCond, _trgAct, ""];

If (_debug) then {
    _markerTrg = [format ["markerTrg_CP_%1",_nrMarker],_trg] call BIS_fnc_markerToTrigger;
    _markerTrg setMarkerColorLocal "ColorBlue";
};

//return successful creation
true