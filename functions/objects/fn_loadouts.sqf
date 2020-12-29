params ["_unit","_loadout"];

// in init line:
//this addAction ["EOD Loadout", {[(_this select 1),"eod"] call AAS_fnc_loadouts;}, [], 0, false, true, "", "true", 8];

hint format ["%1 Loadout taken, %2", toupper _loadout, name _unit];
switch (_loadout) do {
    case "eod": {
        comment "Exported from Arsenal by Aasgeyer";

        comment "[!] UNIT MUST BE LOCAL [!]";
        if (!local _unit) exitWith {};

        comment "Remove existing items";
        removeAllWeapons _unit;
        removeAllItems _unit;
        removeAllAssignedItems _unit;
        removeVest _unit;
        removeBackpack _unit;
        removeHeadgear _unit;
        removeGoggles _unit;

        comment "Add containers";
        _unit addVest "V_EOD_IDAP_blue_F";
        _unit addBackpack "B_LegStrapBag_black_F";

        comment "Add items to containers";
        for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
        _unit addItemToVest "MineDetector";
        _unit addItemToBackpack "ToolKit";
        _unit addHeadgear "H_PASGT_basic_blue_F";
        _unit addGoggles "G_EyeProtectors_F";

        comment "Add items";
        _unit linkItem "ItemMap";
        _unit linkItem "ItemCompass";
        _unit linkItem "ItemWatch";
        _unit linkItem "ItemGPS";

    };
};