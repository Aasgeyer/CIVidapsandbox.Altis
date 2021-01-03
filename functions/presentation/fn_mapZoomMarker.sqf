/*
    Author: Aasgeyer

    Description:
        Makes Markers smoothly appear on zooming in on them.

    Parameter(s):
        0:	STRING - Marker Prefix

    Returns:
        nothing

    Example(s):
        ["marker_zoom_"] spawn AAS_fnc_mapZoomMarker; //-> nothing
*/


//initPlayerLocal.sqf
params ["_markerPreFix"];
{_x setMarkerAlphaLocal 0;} forEach ([_markerPreFix] call BIS_fnc_getMarkers);

waitUntil { !isNull ( uiNamespace getVariable [ "RscDiary", displayNull ] ) };

uiNamespace getVariable "RscDiary" displayCtrl 51 ctrlAddEventHandler [ "MouseZChanged", {
	params[ "_ctrl" ];
	
	_zoom = ctrlMapScale _ctrl;
    If (missionNamespace getVariable ["MIS_debugMode",false]) then {
        //hintSilent str _zoom;
    };
	
	{
        _appearZoom = 0.012;
        _maxAlphaZoom = _appearZoom/2;
        _alpha = linearConversion [_appearZoom,_maxAlphaZoom,_zoom,0,1,true];
        _x setMarkerAlphaLocal _alpha;
	} forEach ([_markerPreFix] call BIS_fnc_getMarkers);
	
}];