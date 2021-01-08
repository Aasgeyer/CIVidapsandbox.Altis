/*
    Author: Aasgeyer

    Description:
        Creates a sound source, a module that fires (tracers) in an area of a marker and
        removes them and sets up a new spot when a player gets too close

    Parameter(s):
        0:	STRING - marker of the zone

    Returns:
        ARRAY of OBJECTS - [sound source, logic]

    Example(s):
        [_combatZoneMarker] call AAS_fnc_battlefieldSounds; //-> NOID <no shape>
*/


If (!isServer) exitWith {};

params ["_combatZone"];
_debug = missionNamespace getVariable ["MIS_debugMode",false];

_deleteArray = [];

//get sizes of the marker
_ab = markerSize _combatZone;
_min_ab_div = (selectmin _ab)/10;
_max_ab_div = (selectmax _ab)/10;
//_markerAreaSize = sqrt(_ab#0*_ab#1*pi);

//find random position in marker where no player near
_randomPosZone = [
    [_combatZone],
    nil,
    {
        allPlayers findIf {_this distance2D _x < _max_ab_div} == -1
    }
] call BIS_fnc_randomPos;

//create sound source
_soundSourcePool = ["Sound_BattlefieldExplosions","Sound_BattlefieldFirefight"];
_soundSource = createSoundSource [selectRandom _soundSourcePool, _randomPosZone, [], 0];
_deleteArray pushBack _soundSource;

//create tracer firing modules. They create agents with weapons.
private "_logic";
_usedWeapons = [];
for "_i" from 1 to 2 do {
    //create logic
    _logic = createGroup [sideLogic,true] createUnit ["Logic",_randomPosZone,[],_min_ab_div,"NONE"];
    _sideStr = str (selectRandom [1,2]);
    _logic setVariable ["Side",_sideStr];
    //get weapon of fighting factions
    _unitPoolPool =[AAS_RegularSoldierPool,AAS_GuerillaSoldierPool];
    _unitPool = _unitPoolPool#(_i%2);
    _unitClass = selectRandom _unitPool;
    _weaponsArray = getArray (configFile >> "CfgVehicles" >> _unitClass >> "weapons");
    _weaponsArray = _weaponsArray select {!(_x in ["Throw","Put"])};
    _randomWeapon = _weaponsArray#0;
    _usedWeapons pushBack _randomWeapon;
    //get (if possible) tracer magazines
    _tracerRounds = [_randomWeapon] call BIS_fnc_compatibleMagazines;
    _tracerRounds = _tracerRounds call BIS_fnc_arrayShuffle;
    _tracerRoundsIndex = _tracerRounds findIf {"tracer" in _x};
    If (_tracerRoundsIndex != -1) then {
        _tracerRounds = _tracerRounds select _tracerRoundsIndex;
        _logic setVariable ["Magazine",_tracerRounds];
    };
    _logic setVariable ["Weapon",_randomWeapon];
    // set min and max delay for shooting
    _logic setVariable ["min", 5];
    _logic setVariable ["max", 60];
    
    [_logic] spawn BIS_fnc_moduleTracers;

    _deleteArray pushBack _logic;
};

//create trigger that deletes everything and creates new one at new position
_trg = createTrigger ["EmptyDetector", _randomPosZone];
_trg setTriggerArea [_ab#0/10, _ab#1/10, markerDir _combatZone, false, 150];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trgAct = format ["
[%1] call AAS_fnc_battleFieldSounds;
_deleteArray = ThisTrigger getVariable 'AAS_trgDeleteArray';
_deleteArray call CBA_fnc_deleteEntity;
", str _combatZone];
_trg setTriggerStatements ["this", _trgAct, ""];
_deleteArray pushBack _trg;

//for debugging create marker on top of sound source and deletion trigger area marked
If (_debug) then {
    _marker = createMarker [format ["markerSoundSource_%1",_randomPosZone],_randomPosZone];
    _marker setMarkerTypeLocal "mil_triangle";
    _marker setMarkerTextLocal format ["%1",_usedWeapons];
    _marker setMarkerColor "ColorBrown";
    _deleteArray pushBack _marker;

    _markerArea = [format ["markerSoundSourceArea_%1",_randomPosZone], _trg] call BIS_fnc_markerToTrigger;
    _markerArea setMarkerColorLocal "ColorBrown";
    _markerArea setMarkerBrush "Border";
    _deleteArray pushBack _markerArea;
};

_trg setVariable ["AAS_trgDeleteArray", _deleteArray];

//return
[_soundSource,_logic]