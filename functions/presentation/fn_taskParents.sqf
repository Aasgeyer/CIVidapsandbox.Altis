
_cargoVanDisplayName = [configFile >> "CfgVehicles" >> "C_IDAP_Van_02_vehicle_F"] call BIS_fnc_displayName;
_ambulanceDisplayName = [configFile >> "CfgVehicles" >> "C_IDAP_Van_02_medevac_F"] call BIS_fnc_displayName;
_waterTruckDisplayName = [configFile >> "CfgVehicles" >> "C_IDAP_Truck_02_water_F"] call BIS_fnc_displayName;
_leafletDroneDisplayName = [configFile >> "CfgVehicles" >> MIS_leafletdroneclass] call BIS_fnc_displayName;
_heliDisplayName = [configFile >> "CfgVehicles" >> "C_IDAP_Heli_Transport_02_F"] call BIS_fnc_displayName;

_TaskDescription = format ["
IDAPs mobile teams frequently require supplies. Deliver them in time to the deisgnated locations.<br/>
Requirement: %1.
",_cargoVanDisplayName];
[true, "TaskCargo", [_TaskDescription,"Cargo Delivery",""], objNull, "CREATED", -1, false, "box"] call BIS_fnc_taskCreate;

_TaskDescription = format ["
IDAP supports the local authorities in emergencies to ensure medical coverage of the region. Be sure to provide help immediatley as the civlians life is in danger.<br/>
Requirement: %1.
",_ambulanceDisplayName];
[true, "TaskMedical", [_TaskDescription,"Medical Emergency",""], objNull, "CREATED", -1, false, "heal"] call BIS_fnc_taskCreate;

_TaskDescription = format ["
The heatwave lowered the groundwater and thus wells went dry and fields are barren. Locals may request IDAP to bring them additional water.<br/>
Requirement: %1.
",_waterTruckDisplayName];
[true, "TaskWater", [_TaskDescription,"Water Shortage",""], objNull, "CREATED", -1, false, "default"] call BIS_fnc_taskCreate;

_TaskDescription = format ["
FIA and AAF forces clash from time to time and endanger civilian lifes. 
We must do all we can to protect them. Inform them of the evacuation with leaflets 
dropped from drones and evacuate the local populace where fighting is imminent.<br/>
Requirement: %1 and vehicle with enough cargo slots.
",_leafletDroneDisplayName];
[true, "TaskEvacuate", [_TaskDescription,"Evacuate Civilians",""], objNull, "CREATED", -1, false, "run"] call BIS_fnc_taskCreate;

_TaskDescription = format ["
With a helicopter we are able to deliver supplies faster and further away than by car.<br/>
Requirement: %1.
",_heliDisplayName];
[true, "TaskAirsupply", [_TaskDescription,"Cargo Delivery (Air)",""], objNull, "CREATED", -1, false, "container"] call BIS_fnc_taskCreate;

_TaskDescription = format ["
Both sides of the war make use of mines. No one really knows where they are 
but sometimes minefields are discovered and we must make sure that they do no harm to anyone.<br/>
Requirements: %1.
","Mine Detector and Toolkit or Deminig Drone"];
[true, "TaskDemine", [_TaskDescription,"Demine Minefield",""], objNull, "CREATED", -1, false, "mine"] call BIS_fnc_taskCreate;

_TaskDescription = format ["
To inform the local populace of our activity and intention we must communicate with them and go to them. <br/>
Requirement: %1.
","None"];
[true, "TaskInformation", [_TaskDescription,"Information Campaign",""], objNull, "CREATED", -1, false, "talk"] call BIS_fnc_taskCreate;

_TaskDescription = format ["
Occasionally new volunteers arrive to support our efforts. We make sure they get to their destinations safe and fast.<br/>
Requirement: %1.
","Vehicle with enough cargo slots"];
[true, "TaskNewworkers", [_TaskDescription,"New Aid Workers",""], objNull, "CREATED", -1, false, "meet"] call BIS_fnc_taskCreate;

_TaskDescription = format ["
Both sides have agreed to let us retrieve bodies of fallen combatants and non-combatants alike. 
This act is important for the grieving families that await the body for funeral.
Their last locations are often not precise so we must search the area for their bodies. 
Once you have found them put them in a body bag and  bring them back to base so we can identify them.<br/>
Requirement: %1.
",_cargoVanDisplayName];
[true, "TaskBody", [_TaskDescription,"Body Retrieval",""], objNull, "CREATED", -1, false, "search"] call BIS_fnc_taskCreate;

_TaskDescription = format ["
We keep an eye on the actions of the conflict parties. There have been reports
 of unlawful executions, but of course the claim is always that the victim posed
 an immediate threat. Make sure to be there before anything bad can happen!<br/>
Requirement: %1.
","None"];
[true, "TaskDetainedCiv", [_TaskDescription,"Detained Civilian",""], objNull, "CREATED", -1, false, "defend"] call BIS_fnc_taskCreate;

_TaskDescription = format ["
Guerilla emmploy a number of tactics such as Improvise Explosive Devices. 
They are sometimes unreliable and cause casualties among the civilian populace. 
When there is an explosion we'll do our best to get a picture of the situation 
and help where we can.<br/>
Requirement: %1.
","First Aid Kits " + _cargoVanDisplayName];
[true, "TaskIEDExplosion", [_TaskDescription,"IED Explosion",""], objNull, "CREATED", -1, false, "destroy"] call BIS_fnc_taskCreate;