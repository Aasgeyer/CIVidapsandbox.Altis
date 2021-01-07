params [
    ["_unit",player],
    ["_destination",markerpos "marker_idapBase"],
    ["_origin",player]
];

//calculate distance to drive
_dist2d = _origin distance2D _destination;
_leeway =  sqrt(_dist2d)*2;
_dist2d = _dist2d+_leeway;
_dist2dKm = ceil (_dist2d/1000);
//define fare for taxi
//https://www.numbeo.com/taxi-fare/country_result.jsp?country=Greece
_basePrice = 5;
_kmPrice = 2;
_finalPrice = _basePrice + _kmPrice*_dist2dKm;
//caluclate time to drive (only SP)
_v = 70; //km/h assumed
_timeToSkip = _dist2dKm/_v; // t = s/v 
_timeToSkipStr = [60^2*_timeToSkip,"MM:SS"] call BIS_fnc_secondsToString;
_textSP = format ["The drive will take %1",_timeToSkipStr];
_message = format ["The Taxi will cost %1$.<br/>%2",_finalPrice,[_textSP,""] select isMultiplayer];
//confirmation Box
_return = [_message , "Taxi Service To Base", true, true] call BIS_fnc_guiMessage;
//wait for confirmation
waitUntil {!isNil "_return"};
If (_return) then {
    //if "OK"
    //check if enough money
    If (TER_money < _finalPrice) exitWith {
        hint "You can't afford the Taxi!";
    };
    //subtract money and move unit to destination with fade out
    _finalPrice call TER_fnc_removeMoney;
    _fadeOut = [0, "BLACK", 2] spawn BIS_fnc_fadeEffect;
    waitUntil {scriptDone _fadeOut};
    If (!isMultiplayer) then {
        skipTime _timeToSkip;
    };
    player setpos _destination;
    _fadeIn = [1, "BLACK", 2] spawn BIS_fnc_fadeEffect;
};