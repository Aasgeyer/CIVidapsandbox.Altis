/*
	Author: Terra

	Description:
		Return the actual damage of an object. the "damage" command is not very
		reliable.

	Parameter(s):
		0:	OBJECT - Object whose damage should be calculated.

	Returns:
		NUMBER - Damage in range 0 to 1

	Example(s):
		[vehicle player] call TER_fnc_realDamage; //-> 0.0123
*/
params ["_object"];
private _damageHitpoints = getAllHitPointsDamage _object select 2;
private _sum = 0;
_damageHitpoints apply {_sum = _sum + _x};
_sum/(count _damageHitpoints)