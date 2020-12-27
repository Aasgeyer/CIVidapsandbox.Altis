If (!isServer) exitWith {};

_debug = missionNamespace getVariable ["MIS_debugMode",false];
_todeletearray = [];

//select a random location
_randomLocation = selectRandom MIS_locationsCar;

//find a road in that location
_roadInLocation = position _randomLocation nearRoads selectMin size _randomLocation;
_roadInLocation = _roadInLocation select {
    _y = _x;
    MIS_idapoutposts findIf {_x distance2D _y < 150} == -1
};
_roadInLocation = selectrandom _roadInLocation;
_roadPos = getpos _roadInLocation;

//set up IED and detonate it
_roadinfo = getroadinfo _roadInLocation;
_roadinfo params ["", "_width", "", "", "", "", "_begPos", "_endPos", "_isBridge"];
_roadDir = _begPos getdir _endPos;
_roadSidePos = _roadInLocation getpos [_width*random [0.2,0.35,0.6],_roadDir + selectRandom [90,-90]];
_IED = createMine ["IEDUrbanBig_F",_roadSidePos,[],0];
_IED setDamage 1;

_actionPool = ["GestureAgonyCargo"];
_civArray = [];
//create Civilian casualties
for "_c" from 1 to ceil random [2,4,10] do {
    _civGroup = createGroup [civilian,true];
    _civ = _civGroup createUnit [selectRandom CivUnitPool, _roadSidePos, [],50,"NONE"];
    _civ setdir random 360;
    _civArray pushBack _civ;
    _todeletearray pushBack _civ;
    _damage = linearConversion [25,50,_civ distance _roadSidePos,1,0,true];
    _civ setDamage _damage;
    0 = _civ spawn {
        _this allowDamage false;
        sleep 4;
        _this allowDamage true;
    };
    If (_damage > 0.25 && _damage < 1) then {
        systemChat "Wounded Civ";
        _civ switchAction "agonyStart";
        _civ disableAI "ALL";
        _civ enableAI "ANIM";
        0 = _civ spawn {
            _initDamage = damage _this;
            waitUntil {damage _this < _initDamage OR !alive _this};
            _this playAction "agonyStop";
            _this enableAI "ALL";
        };
    };
    If (_damage >= 1) then {
        systemChat "Dead Civ";
        removeFromRemainsCollector _civ;
        [
            _civ,											// Object the action is attached to
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
                [_bodyBag,nil,nil,[0]] call AAS_fnc_cargoload;
                deleteVehicle _target;
            },
            { // Code executed on interrupted
                params ["_target", "_caller", "_actionId", "_arguments"];
                deleteVehicle (_target getVariable ["AAS_bodyBagTemp",objNull]);
            },
            [],													// Arguments passed to the scripts as _this select 3
            4,													// Action duration [s]
            0,													// Priority
            true,												// Remove on completion
            false												// Show in unconscious state
        ] remoteExec ["BIS_fnc_holdActionAdd", 0, _civ];	// MP compatible implementation
    };
};

//create marker on IED position
_marker = createMarker [format ["marker_IED_%1",_roadSidePos],_roadSidePos];
_marker setMarkerTypeLocal "mil_objective";
_marker setMarkerText "IED Explosion";
_todeletearray pushBack _marker;
If (_debug) then {
    _marker = createMarker [format ["marker_IED_%1",_roadPos],_roadPos];
    _marker setMarkerType "mil_dot";
    _todeletearray pushBack _marker;
};
