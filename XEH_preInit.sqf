["WebKnight's Force Use addition", "adik_ForceUse_Destroy", [localize "STR_SW_DSTR", "Destroy vehicle infront of you!"], { 
[player, 1] execVM "\adik_force\ForceUseNew.sqf";
}, {}, [8, [false, true, false]]] call cba_fnc_addKeybind;
["WebKnight's Force Use addition", "adik_ForceUse_Stun", [localize "STR_SW_FORCESTUN", "Set Unconscious enemy in front of you!"], { 
[player, 2] execVM "\adik_force\ForceUseNew.sqf";
}, {}, [8, [false, true, false]]] call cba_fnc_addKeybind;  
["WebKnight's Force Use addition", "adik_ForceUse_Capture", [localize "STR_SW_CPTR", "Force enemy to surrender!"], { 
[player, 3] execVM "\adik_force\ForceUseNew.sqf";
}, {}, [8, [false, true, false]]] call cba_fnc_addKeybind;  
["WebKnight's Force Use addition", "adik_ForceUse_Punishment", [localize "STR_SW_PNMT", "Force player in front of you to pushup!"], { 
[player, 4] execVM "\adik_force\ForceUseNew.sqf";
}, {}, [8, [false, true, false]]] call cba_fnc_addKeybind;  
["WebKnight's Force Use addition", "adik_ForceUse_Speed", [localize "STR_SW_SPD", "Speed up!"], { 
[player, 5] execVM "\adik_force\ForceUseNew.sqf";
}, {}, [8, [false, true, false]]] call cba_fnc_addKeybind;  
["WebKnight's Force Use addition", "adik_ForceUse_Freeze", [localize "STR_SW_FORCEFREEZE", "Freeze enemy's in selected direction"], { 
[player, 1] execVM "\adik_force\ForceUse.sqf";
}, {}, [20, [true, false, false]]] call cba_fnc_addKeybind; 
["WebKnight's Force Use addition", "adik_ForceUse_HealOther", [localize "STR_SW_FORCEHEALOTHER", "Heal other person using force"], { 
[player, 2] execVM "\adik_force\ForceUse.sqf";
}, {}, [2, [false, true, false]]] call cba_fnc_addKeybind;
["WebKnight's Force Use addition", "adik_ForceUse_FireOrb", [localize "STR_SW_FORCEFIREORB", "Create fireball that will illuminate your surroundings"], { 
[player, 3] execVM "\adik_force\ForceUse.sqf";
}, {}, [8, [false, true, false]]] call cba_fnc_addKeybind; 
["WebKnight's Force Use addition", "adik_ForceUse_Stealth", [localize "STR_SW_STH", "Enter invisible mode"], { 
[player, 6] execVM "\adik_force\ForceUseNew.sqf";
}, {}, [25, [false, true, false]]] call cba_fnc_addKeybind; 

[
    "distanceForVehicleKill",
    "SLIDER",
    "$STR_distance_For_Vehicle_Kill",
	"WebKnight's Force Use addition",
    [2,15,6,1],
    true,
    {}
] call CBA_fnc_addSetting;
[
    "manaToUseStealth",
    "SLIDER",
    "$STR_Mana_to_use_Stealth",
	"WebKnight's Force Use addition",
    [1,100,1,20],
    true,
    {}
] call CBA_fnc_addSetting;
[
    "stealthManaConsumption",
    "SLIDER",
    "$STR_stealth_Mana_Consumption",
	"WebKnight's Force Use addition",
    [1,100,1,20],
    true,
    {}
] call CBA_fnc_addSetting;
[
    "speedForceManaConsumption",
    "SLIDER",
    "$STR_speed_Force_Mana_Consumption",
	"WebKnight's Force Use addition",
    [1,100,1,20],
    true,
    {}
] call CBA_fnc_addSetting;