
while {true} do {
    _startpos = [
        nil,[],
        {
            allPlayers findIf {
                _this distance2D _x < 1500
                && _this distance2D _x > 3500
            } == -1
        }
    ] call BIS_fnc_randomPos;
    _endPos = [
        nil,[],
        {
            _this distance2d _startpos > 2000
            && allPlayers findIf {
                _this distance2D _x < 1500
            } == -1
        }
    ] call BIS_fnc_randomPos;
    _className = selectRandom AAS_AirVehiclePool;
    _isHeli = _className isKindOf "Helicopter";
    _altM = [600,300] select _isHeli;
    _altitude = random [_altM/2,_altM,_altM*2];
    _maxSpeed = getNumber (configFile >> "CfgVehicles" >> _className >> "maxSpeed");
    _distance = _startpos distance2D _endPos;
    _sleepTime = _distance/(_maxSpeed*0.25);
    [_startpos, _endPos, _altitude, "NORMAL", _className, independent] call BIS_fnc_ambientFlyby;
    sleep (_sleepTime + 300);
};