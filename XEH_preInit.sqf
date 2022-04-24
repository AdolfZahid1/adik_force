["WebKnight's Force Use addition", "adik_ForceUse_Crush", [localize "STR_SW_FORCECRUSH", "Crush your enemy with a force!"], { 
[player, 1] execVM "\adik_force\ForceUse.sqf";
}, {}, [4, [false, true, false]]] call cba_fnc_addKeybind; 
["WebKnight's Force Use", "WBK_ForceUse_Freeze", [localize "STR_SW_FORCEFREEZE", "Freeze enemy's in selected direction"], { 
[player, 2] execVM "\WebKnight_StarWars_Mechanic\ForceUse.sqf";
}, {}, [20, [true, false, false]]] call cba_fnc_addKeybind; 
["WebKnight's Force Use addition", "adik_ForceUse_HealOther", [localize "STR_SW_FORCEHEALOTHER", "Heal other person using force"], { 
[player, 3] execVM "\adik_force\ForceUse.sqf";
}, {}, [2, [false, true, false]]] call cba_fnc_addKeybind;
["WebKnight's Force Use addition", "adik_ForceUse_FireOrb", [localize "STR_SW_FORCEFIREORB", "Create fireball that will illuminate your surroundings"], { 
[player, 4] execVM "\adik_force\ForceUse.sqf";
}, {}, [3, [false, true, false]]] call cba_fnc_addKeybind; 
["WebKnight's Force Use addition", "adik_ForceUse_Choke", [localize "STR_SW_FORCECHOKE", "Make youre enemy choke!"], { 
[player, 5] execVM "\adik_force\ForceUse.sqf";
}, {}, [4, [false, true, false]]] call cba_fnc_addKeybind;
["WebKnight's Force Use addition", "adik_ForceUse_Destroy", [localize "STR_SW_DSTR", "Destroy vehicle infront of you!"], { 
[player, 7] execVM "\adik_force\ForceUse.sqf";
}, {}, [8, [false, true, false]]] call cba_fnc_addKeybind; 


