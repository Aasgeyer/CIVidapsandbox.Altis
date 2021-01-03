/*
    Author: Aasgeyer

    Description:
        Sets the marker alpha for markers locally to 1 or 0, depending on whether
        it is visible.

    Parameter(s):
        0:	String, Array - Marker name or prefix of markers or array of markers
        Optional:
        1:	Bool - whether to evaluate visibility for each marker individually
            Default: false

    Returns:
        nothing - /

    Example(s):
        [markerName] call AAS_fnc_setMarkerAlpha; //-> nothing
*/


params ["_marker",["_applyAll",false]];

//for strings, marker name or marker prefix
If (_marker isEqualType "") then {
    //marker does not exist; assume prefix
    If (markerColor _marker isEqualTo "") then {
        //find markers with prefix
        _markerArray = [_marker] call BIS_fnc_getmarkers;
        If (count _markerArray > 0) then {
            //if markers with prefix found
            [_markerArray, _applyAll] call AAS_fnc_setMarkerAlpha;
        } else {
            ["Neither marker of that name found, nor markers with that prefix."] call BIS_fnc_error;
        };
    } else {
        //string is marker name. If marker visible, hide it, or vice versa
        _isShown = markerAlpha _marker > 0;
        _newAlpha = [1,0] select _isShown;
        _marker setMarkerAlphaLocal _newAlpha;
    };
};

//for array of markers
If (_marker isEqualType []) then {
    If (_applyAll) then {
        //if to apply alpha for every marker individually
        _marker apply {[_x] call AAS_fnc_setMarkerAlpha;};
    } else {
        //if to apply for all markers of the array the same alpha.
        //Take first marker of array as reference
        _isShown = markerAlpha (_marker#0) > 0;
        _newAlpha = [1,0] select _isShown;
        _marker apply {
            _x setMarkerAlphaLocal _newAlpha;
        };
    };
};