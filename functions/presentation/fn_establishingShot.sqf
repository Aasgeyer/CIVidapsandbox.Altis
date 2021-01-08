/*
    Author: Aasgeyer

    Description:
        Establishing shot taking all zoom markers on the base as icons.
        Call from initPlayerLocal.sqf

    Parameter(s): none

    Returns:
        nothing

    Example(s):
        [] call AAS_fnc_establishingShot; //-> nothing
*/

_zoomMarkers = ["marker_zoom_"] call BIS_fnc_getMarkers;
_iconArray = _zoomMarkers apply {
    _cfgMarkerPicture = gettext (configFile >> "CfgMarkers" >> markerType _x >> "icon");
    _CivColor = [(profilenamespace getvariable ['Map_Civilian_R',0]),(profilenamespace getvariable ['Map_Civilian_G',1]),(profilenamespace getvariable ['Map_Civilian_B',1]),(profilenamespace getvariable ['Map_Civilian_A',0.8])];
    _pos = markerPos _x;
    _sizeX = 1;
    _sizeY = 1;
    _angle = markerDir _x;
    _text = markerText _x;
    [_cfgMarkerPicture, _CivColor, _pos, _sizeX, _sizeY, _angle, _text]
};
[markerpos "marker_idapBase", "IDAP Base near Kavala Pier", 150, 150, 75, 0, _iconArray] spawn BIS_fnc_establishingShot