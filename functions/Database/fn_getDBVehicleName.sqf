/*
	Author: Terra

	Description:
		Returns the section name that the given vehicle is stored under. The
		section name consists of the netID and the timestamp of the mission:
		"NETID:MISSIONSTART" where NETID is the usual OWNER:UNIQUEID, so:
		"OWNER:UNIQUEID:MISSIONSTART"

	Parameter(s):
		0:	OBJECT - Vehicle.

	Returns:
		STRING - Section name for use with the database.

	Example(s):
		[vehicle player] call TER_fnc_getDBVehicleName; //-> [0:3:202101011130]
*/
params ["_vehicle"];
(_vehicle call BIS_fnc_netID) + ":" + TER_missionStartStr