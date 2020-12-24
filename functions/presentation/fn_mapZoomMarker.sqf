//initPlayerLocal.sqf
{_x setMarkerAlphaLocal 0;} forEach (["marker_zoom_"] call BIS_fnc_getMarkers);

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
	}forEach (["marker_zoom_"] call BIS_fnc_getMarkers);
	
}];