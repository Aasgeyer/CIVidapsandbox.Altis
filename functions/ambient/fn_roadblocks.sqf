If (!isServer) exitWith {};

_debug = missionNamespace getVariable ["MIS_debugMode",false];

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
    ["water"],
    {
        {count (roadsConnectedTo _x) > 1} count (_this nearRoads 150) > 5
        && count (_this nearObjects ["House",25]) == 0
        && MIS_restrictedAreas findIf {_this inArea _x} == -1
    }
] call BIS_fnc_randomPos;

//get a road segment
_nearRoads = (_randomPos nearRoads 150) select {count (roadsConnectedTo _x) > 1};
_road = selectRandom _nearroads;
_roadInfo  = getRoadInfo _road;
_roadInfo params ["_mapType", "_width", "", "", "", "", "_begPos", "_endPos"];
_roadDir = _begpos getdir _endpos;
_roadPos = getpos _road;

_logic = createGroup sideLogic createUnit [_logicClass,_roadPos,[],0,"CAN_COLLIDE"];

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
_nearObjects = _roadPos nearObjects 50;
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

_trg = createTrigger ["EmptyDetector", _roadPos];
_trg setTriggerArea [_width, (_begpos distance2D _endpos)*0.75, _roadDir, true, 15];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trg setTriggerStatements ["this && thisList findIf {speed _x > 30} != -1", "hint 'Too fast!';", ""];

If (_debug) then {
    _markerTrg = [format ["markerTrg_CP_%1",_nrMarker],_trg] call BIS_fnc_markerToTrigger;
    _markerTrg setMarkerColorLocal "ColorBlue";
};