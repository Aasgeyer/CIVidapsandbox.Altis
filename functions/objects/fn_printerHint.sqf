params ["_printer"];
If !(isServer) exitWith {};

[this, [
    "Printer use",
    "hintC ""Here you can refill the leaflets of the leaflet drone. Just park the drone nearby and you'll have the option to rearm it."";",
    nil,10,false,true,"","true",4,false,"",""]
] remoteExec ["addaction"];