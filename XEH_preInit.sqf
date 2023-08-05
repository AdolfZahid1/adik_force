
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

[] execVM "\adik_force\Binds.sqf";