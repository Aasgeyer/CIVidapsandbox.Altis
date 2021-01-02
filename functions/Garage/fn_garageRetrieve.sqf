/*
	Author: Terra

	Description:
		AL EG SE
		Loads a vehicle from the garage into the game.
		! SERVER ONLY !

	Parameter(s):
		0:	STRING - Vehicle's database ID.

	Returns:
		OBJECT - Created vehicle.

	Example(s):
		["0:3:20210101213505"] call TER_fnc_garageRetrieve; //-> OBJECT
*/
if (!isServer) exitWith {};
params ["_id"];
if !(["read", [_id, "stored", false]] call TER_db_assets) exitWith {
	["Vehicle %1 is not stored or not in database!", _id] call BIS_fnc_error;
	objNull
};
private _class = ["read", [_id, "class"]] call TER_db_assets;
private _spawnPositions = [
	[3061.71,12588.2,0.0230105],
	[3052.95,12603,0.0229905]
];
private _spawnDir = 58;
private _spawnRadius = 3;
private _spawnPos = {
	if (count (_x findEmptyPosition [0, _spawnRadius, _class]) > 0) exitWith {_x};
	[]
} forEach _spawnPositions;
diag_log [_spawnPos, _class];
if (count _spawnPos == 0) exitWith {
	//--- No free spawning space available
	parseText "<t size=2>IDAP Garage Service</t><br/><br/>No free space available at the repair station!" remoteExec ["hint", remoteExecutedOwner];
	objNull
};
//--- Spawn vehicle
_veh = [_class, _spawnPos, _id] call TER_fnc_initDBAsset;
_veh setDir _spawnDir;

_veh
