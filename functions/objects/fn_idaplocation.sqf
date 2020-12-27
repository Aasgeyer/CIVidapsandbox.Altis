If (!isServer) exitWith {};

_idapcomposition =
[
	["Land_ClutterCutter_medium_F",[0.480469,0.0566406,8.2016e-005],0,1,0,[-0.76387,0.534541],"","",true,false], 
	["Sign_Arrow_Direction_Pink_F",[0.208984,1.54688,0.000286102],90.0071,1,0,[-0.534446,-0.763937],"","",true,false], 
	["Land_CampingTable_white_F",[1.49023,0.59375,-0.0024395],270.007,1,0,[0.534646,0.764471],"","",true,false], 
	["Land_PaperBox_01_small_open_brown_F",[1.48047,-1.10352,1.33514e-005],0,1,0,[-0.916425,0.534562],"","",true,false], 
	["Land_WaterBottle_01_empty_F",[1.10938,-1.58203,0.000143051],359.894,1,0,[-0.933219,0.580156],"","",true,false], 
	["Land_WaterBottle_01_cap_F",[1.06836,-1.75977,-0.000562668],270.408,1,0,[1.9118,1.69608],"","",true,false], 
	["Land_WaterBottle_01_compressed_F",[1.10156,-1.99023,5.72205e-005],45.0106,1,0,[-1.04057,-0.276103],"","",true,false], 
	["Land_WaterBottle_01_compressed_F",[1.47266,-1.81641,6.86646e-005],359.995,1,0,[-0.930696,0.529238],"","",true,false], 
	["C_IDAP_Van_02_vehicle_F",[-1.68555,0.183594,0.0885525],359.989,1,0,[-1.65414,0.686723],"","",true,false], 
	["Land_WaterBottle_01_cap_F",[1.27148,-2.2793,-0.000574112],359.994,1,0,[0.463406,1.30692],"","",true,false], 
	["MedicalGarbage_01_Gloves_F",[-0.244141,-2.81055,4.19617e-005],90,1,0,[0,-0],"","",true,false], 
	["Land_CampingTable_small_white_F",[1.51367,2.61523,0.00273705],270.007,1,0,[0.534541,0.764374],"","",true,false], 
	["Land_Sunshade_01_F",[2.08594,1.75,0.000196457],0,1,0,[-0.76387,0.534541],"","",true,false], 
	["Land_PaperBox_01_small_closed_brown_F",[-0.115234,-3.48242,9.91821e-005],270.005,1,0,[0.382032,0.763632],"","",true,false], 
	["Land_PaperBox_01_small_closed_brown_F",[-0.125,-4.51953,0.000101089],134.999,1,0,[0.269824,-0.810556],"","",true,false], 
	["Sign_Arrow_Direction_Pink_F",[1.23828,-4.55859,-0.000135422],135.001,1,0,[0.270003,-0.810286],"","",true,false], 
	["Land_PaperBox_01_open_empty_F",[-1.7793,-5.40234,0.00145721],359.991,1,0,[-0.762879,0.746858],"","",true,false]
];

MIS_locationsCar = nearestLocations [markerPos "marker_AO_1",["NameCity","NameVillage"],selectMax markerSize "marker_AO_1"];
MIS_idapoutposts = [];
//_animationPool = ["Acts_AidlPercMstpSnonWnonDnon_warmup_1_loop","Acts_AidlPercMstpSnonWnonDnon_warmup_3_loop","Acts_AidlPercMstpSnonWnonDnon_warmup_8_loop"];
{
    _name = text _x;
    _pos = position _x;
    _size = [selectMax size _x,selectMax size _x];
    _locmark = createMarker [format ["marker_%1",_name],_pos];
    _locmark setMarkerShapeLocal "ELLIPSE";
    _locmark setMarkerSizeLocal _size;
    _locmark setMarkerColorLocal "ColorGreen";
    _locmark setMarkerBrush "Border";
    If !(_debug) then {_locmark setMarkerAlpha 0;};
    _r = 15;
    _safepos = [worldSize/2, worldSize/2, 0];
    _centerpos = [worldSize/2, worldSize/2, 0];
    _defaultPos = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
    _maxDist = 100;
    while {_safepos isEqualTo _centerpos OR _safepos isEqualTo _defaultPos && _maxDist <= _size#0} do {
        _safepos = [_pos,0,_maxDist,_r,0,0.25] call BIS_fnc_findSafePos;
        _maxDist = _maxDist + _r;
    };
    _idaplogic = createGroup sideLogic createUnit ["LocationOutpost_F",_safepos,[],0,"CAN_COLLIDE"];
    _idaplogic setVariable ["AAS_LogicLocationName", _name, true];
    MIS_idapoutposts pushBack _idaplogic;
    _outpostMrkArea = createMarker [format ["marker_%1_idaparea",_name],_safepos];
    _outpostMrkArea setMarkerShapeLocal "ELLIPSE";
    _outpostMrkArea setMarkerSizeLocal [_r,_r];
    _outpostMrkArea setMarkerColorLocal "ColorWhite";
    _outpostMrkArea setMarkerBrush "SolidBorder";
    _outpostMrk = createMarker [format ["marker_%1_idap",_name],_safepos];
    _outpostMrk setMarkerShapeLocal "ICON";
    _outpostMrk setMarkerTypeLocal "flag_IDAP";
    _outpostMrk setMarkerSize [0.5,0.5];
    _azimuth = (_safepos getdir _pos) - 90;
    _objectaray = [_safepos,_azimuth,_idapcomposition] call BIS_fnc_objectsMapper;
    _idapvan = _objectaray select (_objectaray findIf {typeOf _x isEqualTo "C_IDAP_Van_02_vehicle_F"});
    for "_d" from 3 to 4 do {
        _idapvan animateDoor [format ["door_%1_source",_d],1,true];
    };
    _idapvan setVehicleLock "LOCKED";
    _idapvan setFuel 0;
    _pinkarrows = _objectaray select {tolower typeOf _x isEqualTo toLower "Sign_Arrow_Direction_Pink_F"};
    _idapgroup = createGroup civilian;
    {
        _unit = _idapgroup createUnit [selectRandom IDAP_unitsarray,getpos _x,[],0,"CAN_COLLIDE"];
        _unit setdir getdir _x;
        _unit setFormDir getdir _x;
        doStop _unit;
        {_unit disableAI _x;} foreach ["TARGET","AUTOTARGET","RADIOPROTOCOL","AUTOCOMBAT","FSM","MOVE","COVER","PATH"];
        _anim = format ["STAND_U%1",ceil (0.0001+random 2.9999)];
        If (random 1 > 0.2) then {
            [[_unit, _anim, "ASIS", _x, false, false], BIS_fnc_ambientAnim] remoteExec ["call"];
        };
        hideObjectGlobal _x;
        _objectaray deleteAt (_objectaray find _x);
    } foreach _pinkarrows;
    _idaplogic setVariable ["AAS_IDAPOutpostObjectArray",_objectaray + units _idapgroup];
    _idaplogic setVariable ["AAS_IDAPOutpostMarkerArray",[_outpostMrk,_outpostMrkArea]];
    {
        hideObjectGlobal _x;
        _x enableSimulationGlobal false;
        _x allowDamage false;
    } foreach (_objectaray + units _idapgroup);
} forEach MIS_locationsCar;

