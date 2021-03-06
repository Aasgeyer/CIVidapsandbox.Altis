[] execVM "costs.sqf";
MIS_restrictedAreas = ["marker_restrictedArea_"] call BIS_fnc_getMarkers;
MIS_restrictedAreasExtended = +MIS_restrictedAreas;
If (IsServer) then {
    {
        _CrossMarker = createMarker [format ["marker_restrictedCross_%1",_foreachindex+1],markerpos _x];
        _CrossMarker setMarkerBrushLocal "Cross";
        _CrossMarker setMarkerColorLocal (markerColor _x);
        _CrossMarker setMarkerSizeLocal (markerSize _x);
        _CrossMarker setMarkerDirLocal (markerDir _x);
        _CrossMarker setMarkerShape (markerShape _x);
        MIS_restrictedAreasExtended pushBack _CrossMarker;
    } foreach MIS_restrictedAreas;
};

//objects that can be slingloaded
MIS_SlingloadCargo = [
    "Land_PaperBox_01_small_stacked_F",
    "Land_FoodSacks_01_cargo_brown_idap_F","Land_FoodSacks_01_cargo_white_idap_F",
    "CargoNet_01_box_F","CargoNet_01_barrels_F"
];
//objects that can be loaded into the back of the truck
MIS_VanCargoObjectClasses = [
    "Land_PaperBox_01_small_stacked_F","Land_WaterBottle_01_stack_F",
    "Land_PaperBox_01_open_boxes_F","Land_PaperBox_01_open_water_F",
    "Land_CargoBox_V1_F","Land_FoodSacks_01_small_white_idap_F",
    "Land_FoodSacks_01_small_brown_idap_F","Land_MetalCase_01_large_F",
    "CargoNet_01_box_F","CargoNet_01_barrels_F"
];

//objects that serve as Tents
AAS_TentObjects = [
    "Land_MedicalTent_01_white_IDAP_closed_F",
    "Land_MedicalTent_01_white_IDAP_open_F"
];
