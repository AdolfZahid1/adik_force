params ["_unit", objNull];
_arr = parseSimpleArray getText (configFile >> "CfgWeapons" >> handgunWeapon _unit >> "IMS_Melee_Param_SoundsOnHit");  
_rndSnd = selectRandom _arr;
[_unit, _rndSnd, 50, 3] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";