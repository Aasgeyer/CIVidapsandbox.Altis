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
<execute expression='[AO_markerIDAPZonesExtended] call AAS_fnc_setMarkerAlpha;'>Hide IDAP AO markers</execute><br/>
<execute expression='[AO_markerCombatZonesExtended] call AAS_fnc_setMarkerAlpha;'>Hide combat area markers</execute><br/>
<execute expression='[MIS_restrictedAreasExtended] call AAS_fnc_setMarkerAlpha;'>Hide restricted area markers</execute><br/>
<execute expression='[""marker_disposal_""] call AAS_fnc_setMarkerAlpha;'>Hide explosive disposal markers</execute><br/>
<execute expression='[""marker_RoadBlock_""] call AAS_fnc_setMarkerAlpha;'>Hide checkpoint markers</execute><br/>
"
],taskNull,"",true];