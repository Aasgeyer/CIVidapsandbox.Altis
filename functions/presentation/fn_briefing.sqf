/*
    Author: Aasgeyer

    Description:
        Creates the briefing for the player with all diary subjects.
        Execute from initPlayerLocal.sqf

    Parameter(s): None

    Returns:
        Nothing

    Example(s):
        [] call AAS_fnc_briefing; //-> nothing
*/


0 = player createDiarySubject ["technical","Technical"];
0 = player createDiaryRecord ["technical",["Marker Visibility",
"
<execute expression='[AO_markerIDAPZonesExtended] call AAS_fnc_setMarkerAlpha;'>Toggle IDAP AO markers</execute><br/>
<execute expression='[AO_markerCombatZonesExtended] call AAS_fnc_setMarkerAlpha;'>Toggle combat area markers</execute><br/>
<execute expression='[MIS_restrictedAreasExtended] call AAS_fnc_setMarkerAlpha;'>Toggle restricted area markers</execute><br/>
<execute expression='[""marker_disposal_""] call AAS_fnc_setMarkerAlpha;'>Toggle explosive disposal markers</execute><br/>
<execute expression='[""marker_RoadBlock_""] call AAS_fnc_setMarkerAlpha;'>Toggle checkpoint markers</execute><br/>
"
],taskNull,"",true];

0 = player createDiaryRecord ["technical",["Taxi Service",
"
<executeClose expression='[] spawn AAS_fnc_teleportBase;'>Call Taxi</executeClose> to <marker name='marker_idapbase'>Base</marker>.
"],taskNull,"",true];