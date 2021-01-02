params [
    ["_curator",objNull],
    ["_entity",objNull],
    ["_mode",-1]
];

switch (_mode) do {
    case -1: {
        
    };

    case 0: {
        //init [zeuslogic,ObjNull,0] call AAS_fnc_zeusEH;
        _curator addEventHandler ["CuratorObjectPlaced", {
            _this = _this + [1];
            _this call AAS_fnc_zeusEH;
        }];
        _curator addEventHandler ["CuratorObjectDeleted", {
            _this = _this + [2];
            _this call AAS_fnc_zeusEH;
        }];
    };

    case 1: {
        //object created
        //cargo loadable objects get the hold action
        If (typeOf _entity in MIS_VanCargoObjectClasses) then {
            [_entity,nil,nil,[0]] call AAS_fnc_cargoload;
        };
        //If vehcile is the leaflet drone class, defined in initServer.sqf, add leaflet weapon
        If (tolower typeOf _entity isEqualTo toLower MIS_leafletdroneclass) then {
            _entity addMagazine "1Rnd_Leaflets_Civ_F";
            _entity addWeapon "Bomb_Leaflets";
            //detect leaflet: count (nearestObjects [position player,["Leaflet_05_F"], 5, true] apply {typeOf _x}) > 0;
            [
                _entity, [
                    "Refill Leaflets", {
                        params ["_target", "_caller", "_actionId", "_arguments"];
                        _target setVehicleAmmo 1;
                    }, nil, 99, true, true, "", "
                        !someAmmo _target
                        && count (_target nearObjects ['Leaflet_05_Stack_F', 10]) > 0
                        && alive _target
                    ", 7
                ]
            ] remoteExec ["addAction"];
        };
        //If vehicle has doors, make them openable via addaction (only vans seem to have these door names)
        _doornames = ["door_1_source","door_2_source","door_3_source","door_4_source"];
        _doornames = animationNames _entity select {_x in _doornames};
        If (count _doornames > 0) then {
            //code for addaction to execute
            _fn_addactioncode = {
                params ["_target", "_caller", "_actionId", "_arguments"];
                _arguments params ["_doorNr"];
                _doorname = format ["Door_%1_source",_doorNr];
                //open or close door, depending on current state of door
                _openclose = [0,1] select (_target doorPhase _doorname == 0);
                _target animateDoor [_doorname, _openclose];
            };

            {
                _doorNr = _foreachindex+1;
                //add two addactions, one for opening and one for closing
                for "_d" from 0 to 1 do {
                    _title = format ["%1 Door %2",
                    ["Open","Close"] select (_d == 1), _doorNr];
                    _cond = format ["alive _target
                    && _target doorPhase 'door_%1_source' == %2",
                    _doorNr,_d];
                    [
                        _entity,
                        [
                            _title,
                            _fn_addactioncode,
                            [_doorNr],
                            1.5, //priority
                            false, //showWindow
                            false, //hideOnUse
                            "", //shortcut
                            _cond, //condition
                            5, //radius
                            false, //unconcious
                            "",//format ["door%1",_doorNr], //selection // door 1 and 2 show as intended, rest not at all
                            ""//format ["door_%1",_doorNr] //memory point
                        ]
                    ] remoteExec ["addAction"];
                };
            } forEach _doornames;
        };
        
        If (typeOf _entity in AAS_TentObjects) then {
            AAS_TentsPlaced = AAS_TentsPlaced + 1;
            publicVariable "AAS_TentsPlaced";
        };

        //--- Economy
        TER_weeklyExpenses = TER_weeklyExpenses + ([typeOf _entity] call TER_fnc_getCost);
        [
            "Money spent",
            format ["%1 placed at %2.", [configFile >> "CfgVehicles" >> typeOf _entity] call BIS_fnc_displayName, mapGridPosition _entity],
            name player,
            ["Economy", "Zeus"],
            [_entity, typeOf _entity]
        ] call TER_fnc_log;

        //--- DB related
        [_entity] remoteExecCall ["TER_fnc_initDBAsset", 2];
    };

    case 2: {
        // on Entity deleted
        If (typeOf _entity in AAS_TentObjects) then {
            AAS_TentsPlaced = AAS_TentsPlaced - 1;
            publicVariable "AAS_TentsPlaced";
        };

        // DB
        ["deleteSection", [_entity] call TER_fnc_getDBVehicleName] remoteExecCall ["TER_db_assets", 2];
    };

    case 3: {
        //finding selection posis (for debugging)
        {
            _modelPos = _curator selectionPosition _x;
            _worldpos = _curator modelToWorld _modelPos;
            _sphere = createVehicle ["Sign_Sphere25cm_F",_worldpos,[],0,"CAN_COLLIDE"];
        } foreach (selectionnames _curator);
    };
};


