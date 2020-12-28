/* Textures:
"\a3\ui_f_orange\data\cfghints\codeofconduct1_ca.paa" // 1-5
allmissionObjects

["InternationalHumanitarianLaw", "Definitions"] call BIS_fnc_openFieldManual;

["InternationalHumanitarianLaw", "Definitions",findDisplay 46] call BIS_fnc_openFieldManual;

A3\Missions_F_Orange\Data\Img\Showcase_LawsOfWar\showcase_low_presentation1_CO
\a3\missions_f_orange\data\img\faction_idap_overview_ca.paa
A3\Missions_F_Orange\Data\Img\Faction_IDAP\whiteboard_idap2_CO

["init", [this, "A3\missions_f_orange\data\img\Faction_IDAP\leaflet_unnecessary_suffering_CA", localize "STR_A3_orange_faction_idap_cfgleaflets_ihl_suffering"]] call bis_fnc_initLeaflet;
["init", [this, "A3\missions_f_orange\data\img\Faction_IDAP\leaflet_military_necessity_CA", localize "STR_A3_orange_faction_idap_cfgleaflets_ihl_militarynecessity"]] call bis_fnc_initLeaflet;
["init", [this, "A3\missions_f_orange\data\img\Faction_IDAP\leaflet_distinction_CA", localize "STR_A3_orange_faction_idap_cfgleaflets_ihl_distinction"]] call bis_fnc_initLeaflet;
["init", [this, "A3\missions_f_orange\data\img\Faction_IDAP\leaflet_precaution_CA", localize "STR_A3_orange_faction_idap_cfgleaflets_ihl_precaution"]] call bis_fnc_initLeaflet;
["init", [this, "A3\missions_f_orange\data\img\Faction_IDAP\leaflet_proportionality_CA", localize "STR_A3_orange_faction_idap_cfgleaflets_ihl_proportionality"]] call bis_fnc_initLeaflet;

["init", [this, "A3\missions_f_orange\data\img\Faction_IDAP\leaflet_good_faith_CA", localize "STR_A3_orange_faction_idap_cfgleaflets_ihl_goodfaith"]] call bis_fnc_initLeaflet;
["init", [this, "A3\missions_f_orange\data\img\Faction_IDAP\leaflet_ihl_CA", localize "STR_A3_Orange_Faction_IDAP_CfgLeaflets_IHL"]] call bis_fnc_initLeaflet;
[this, ["A3\Missions_F_Orange\Data\Img\Faction_IDAP\info_ihl2_CO", nil, 0.71]] call BIS_fnc_initInspectable;
[this, ["A3\Missions_F_Orange\Data\Img\Faction_IDAP\info_ihl3_CO", nil, 0.71]] call BIS_fnc_initInspectable;
[this, ["A3\missions_f_orange\data\img\Faction_IDAP\info_aid2_CO", nil, 0.71]] call BIS_fnc_initInspectable;

this switchMove "Acts_B_hub01_briefing"; // leaning on table while holding briefing
//Useful instructor anims
/*
Acts_AidlPercMstpSnonWnonDnon_warmup_1_loop - standing
Acts_AidlPercMstpSnonWnonDnon_warmup_2_loop - crouched, looking down - small geom offset
Acts_AidlPercMstpSnonWnonDnon_warmup_3_loop - standing
Acts_AidlPercMstpSnonWnonDnon_warmup_4_loop - crouched, looking down
Acts_AidlPercMstpSnonWnonDnon_warmup_5_loop - kneeled
Acts_AidlPercMstpSnonWnonDnon_warmup_6_loop - kneeled, looking down - big geom offset
Acts_AidlPercMstpSnonWnonDnon_warmup_8_loop - standing
Acts_CivilIdle_1 - standing
Acts_CivilIdle_2 - standing
Acts_CivilListening_1 - standing, talking
Acts_CivilListening_2 - standing, talking
Acts_CivilTalking_1 - standing, talking
Acts_CivilTalking_2 - standing, talking
HubBriefing_lookAround1 - standing
HubBriefing_lookAround2 - standing
HubBriefing_loop - standing
HubBriefing_pointAtTable
HubBriefing_pointLeft
HubBriefing_pointRight
HubBriefing_scratch
HubBriefing_stretch
HubBriefing_talkAround
HubBriefing_think
HubSittingChairUB_idle1 - sitting
HubSittingChairUB_idle2 - sitting
HubSittingChairUB_idle3 - sitting
HubStandingUA_idle1 - standing
HubStandingUA_idle2 - standing
HubStandingUA_idle3 - standing
HubStandingUC_idle1 - standing
HubStandingUC_idle2 - standing
HubStandingUC_idle3 - standing
InBaseMoves_HandsBehindBack1 - standing
InBaseMoves_HandsBehindBack2 - standing
passenger_inside_7_Idle_Unarmed_Idling - sitting
*/
