_unit = _this select 0;
_stance = _this select 1;

if (_stance == 1) exitWith {
if ("Force_choke" in magazines _unit) then {
////удушение новое
if (_unit getVariable "IMS_LaF_ForceMana" > 0.4) then {
_unit setVariable ["canMakeAttack",1];
_mana = _unit getVariable "IMS_LaF_ForceMana";
_mana = _mana - 0.4;
_unit setVariable ["IMS_LaF_ForceMana",_mana,true];

_unit allowDamage false;
{
if ((alive _x) and !(isPlayer _x) and (handgunWeapon _x in IMS_LightSabers)) then {
if (((_x worldToModel (_unit modelToWorld [0, 0, 0])) select 1) < 0) then 
{
[_x, [9, 9, 1.5], "starWars_landRoll"] spawn strafeFwrd_SW;
}else{
[_x, [-9, -9, 1.5], "starWars_landRoll_b"] spawn strafeFwrd_SW;
};
};
} forEach nearestObjects [_unit, ["Man"], 10];
sleep 0.1;
_unit spawn {
_main = _this;
_main setVariable ["canMakeAttack",1];
[_main, "STAR_WARS_FORCE_CHOKE_main"] remoteExec ["playActionNow", _main];
[_main, "Jedi_Choke_Start", 30, 15] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
sleep 0.8;
[_main, "Jedi_Choke_over", 30, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
sleep 0.9;
[_main, "FP_Push", 30, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
sleep 1;
_main setVariable ["canMakeAttack",0];
};
{
if (!(_x == _unit) and (((_unit worldToModel (_x modelToWorld [0, 0, 0])) select 1) > 0) and (alive _x)) then {
if (!(WBK_ParamForceKillFriendlies) and (side _x == side _unit)) exitWith {};
if (_x isKindOf "MAN") exitWith {
if ((animationState _x == "starWars_landRoll") or (animationState _x == "starWars_landRoll_b")) exitWith {};
if (("WBK_Baf_Push" in magazines _x)) exitWith {
[_x, "STAR_WARS_baf_work"] remoteExec ["playActionNow"];
[_x] spawn {
_unit = _this select 0;
if (isStaminaEnabled _unit) then {
    _unit allowSprint false;
    [_unit, false] remoteExec ["allowSprint"];
    sleep 0.8;
    [_unit, true] remoteExec ["allowSprint"];
  };
};
};
[_unit, _x] spawn {
_main = _this select 0;
_victim = _this select 1;
_victim setDamage 1;
[_victim, "STAR_WARS_FORCE_CHOKE_victim"] remoteExec ["switchMove", 0];
[_victim, (_victim getDir _main)] remoteExec ["setDir", 0];
[_victim, 0.95] remoteExec ["setAnimSpeedCoef", 0];
_loopDirToPlr = [{
    _array = _this select 0;
    _unit = _array select 0;
	_nearEnemy = _array select 1;
        _dir = [[0,1,0], -([_unit, _nearEnemy] call BIS_fnc_dirTo)] call BIS_fnc_rotateVector2D;
        _unit setVelocityTransformation [ 
          getPosASL _unit,  
          getPosASL _unit,  
          [0,0,(velocity _unit select 2) - 1],  
          [(velocity _unit select 0),(velocity _unit select 1),(velocity _unit select 2) - 1], 
          vectorDir _unit,  
          _dir,  
          vectorUp _unit,  
          vectorUp _unit, 
          0.1
        ]; 
}, 0.01, [_victim,_main]] call CBA_fnc_addPerFrameHandler;
sleep 1;
[_victim, "dobi_CriticalHit", 30, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
sleep 0.6;
[_loopDirToPlr] call CBA_fnc_removePerFrameHandler;
sleep 0.1;
[_victim,  [12,0, 3]] remoteExec ["setVelocityModelSpace", 0];
sleep 1;
};
};
};
} forEach nearestObjects [_unit, ["MAN"], 14];
};
};
};

if (_stance == 2) exitWith {
////Полный стан 
if ("Force_freeze" in magazines _unit) then {
if (_unit getVariable "IMS_LaF_ForceMana" > 0.3) then {
_unit setVariable ["canMakeAttack",1];
_mana = _unit getVariable "IMS_LaF_ForceMana";
_mana = _mana - 0.3;
_unit setVariable ["IMS_LaF_ForceMana",_mana,true];
[_unit,  "STAR_WARS_FIGHT_POWERS_CRYOORPYRO"] remoteExec ["switchMove", 0];
_unit allowDamage false;
{
if ((alive _x) and !(isPlayer _x) and (handgunWeapon _x in IMS_LightSabers)) then {
if (((_x worldToModel (_unit modelToWorld [0, 0, 0])) select 1) < 0) then 
{
[_x, [9, 9, 1.5], "starWars_landRoll"] spawn strafeFwrd_SW;
}else{
[_x, [-9, -9, 1.5], "starWars_landRoll_b"] spawn strafeFwrd_SW;
};
};
} forEach nearestObjects [_unit, ["Man"], 10];
sleep 0.1;
if (!(alive _unit) or !(animationState _unit == "STAR_WARS_FIGHT_POWERS_CRYOORPYRO")) exitWith {};
[_unit, "FP_Pull", 10, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
[_unit, {
_object = _this;
_gravi3 = "#particlesource" createVehicleLocal getPosWorld _object;
_gravi3 setParticleCircle [1.5, [0, 0, 1]];
_gravi3 setParticleRandom [0, [0.25, 0.25, 0], [0, 0, 0], 0.7, 0.25, [0, 0.5, 0, 0.1], 0, 0];
_gravi3 setParticleParams [["\A3\data_f\cl_rock1", 1, 0, 1], "", "SpaceObject", 1, 12.5, [0, 0, 0], [0, 0, 0.75], 0, 11, 7.9, 0.075, [1.8, 6, 4], [[0, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.3], 1, 0, "", "", _object];
_gravi3 setDropInterval 0.05;
sleep 0.8;
deleteVehicle _gravi3;
}] remoteExec ["spawn", [0,-2] select isDedicated,false];
sleep 0.8;
if (!(alive _unit) or !(animationState _unit == "STAR_WARS_FIGHT_POWERS_CRYOORPYRO")) exitWith {};
[_unit,  [7 * (sin (getdir _unit )), 7 * (cos (getdir _unit)), 1]] remoteExec ["setvelocity", _unit];
[_unit, {
_ripple = "#particlesource" createVehicleLocal getposatl _this;
_ripple setParticleCircle [0,[0,0,0]];
_ripple setParticleRandom [0,[0.25,0.25,0],[0.175,0.175,0],0,0.25,[0,0,0,0.1],0,0];
_ripple setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d",1,0,1], "", "Billboard", 1, 0.5, [0, 0, 0], [0, 0, 0],0,10,7.9,0, [10,10], [[1, 1, 1, 1], [1, 1, 1, 1]], [0.08], 1, 0, "", "", _this];
_ripple setDropInterval 0.01;
_ripple attachto [_this,[0,0,0]];
sleep 1.1;
deleteVehicle _ripple;
}] remoteExec ["spawn", [0,-2] select isDedicated,false];
[_unit, "Jedi_Freeze_Over", 90, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
{
if (!(_x == _unit) and (((_unit worldToModel (_x modelToWorld [0, 0, 0])) select 1) > 0)) then {
if (!(WBK_ParamForceKillFriendlies) and (side _x == side _unit)) exitWith {};
if (_x isKindOf "MAN") exitWith {
if ((animationState _x == "starWars_landRoll") or (animationState _x == "starWars_landRoll_b")) exitWith {};
if (("WBK_Baf_Frozen" in magazines _x)) exitWith {
[_x, "STAR_WARS_baf_work"] remoteExec ["playActionNow"];
[_x] spawn {
_unit = _this select 0;
if (isStaminaEnabled _unit) then {
    _unit allowSprint false;
    [_unit, false] remoteExec ["allowSprint"];
    sleep 0.8;
    [_unit, true] remoteExec ["allowSprint"];
  };
};
};
if ((_x getVariable "actualSwordBlock" == 1)) exitWith {
_x setVariable ["AI_CanTurn",1, true];
_sas = getDirVisual _unit;
[_x,  [9 * (sin (_sas)), 9 * (cos (_sas)), 2]] remoteExec ["setvelocity", _x];
[_x,228,_unit] spawn concentrationToZero;
};
_x spawn {
[_this, {
_object = _this;
_gravi1 = "#particlesource" createVehicle getpos _object;  
_gravi1 setParticleCircle [0, [0.1, 0.1, 0.1]]; 
_gravi1 setParticleRandom [0, [0, 0.1, 1], [0.1, 0, 0.1], 0, 0.1, [0, 0, 0, 0.1], 0, 0]; 
_gravi1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract", 1, 0, 1], "", "Billboard", 1, 4, [0, 0, 0], [0, 0, 0.5], 9, 10, 7.9, 0.1, [0.6, 1, 0.9, 0.8], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0, 0.1, 0.2, 0.5, 0.1, 0.1], 0, 0, "", "", _object]; 
_gravi1 setDropInterval 0.1;  
sleep 4;
deleteVehicle _gravi1;
}] remoteExec ["spawn", [0,-2] select isDedicated,false];
[_this, false] remoteExec ["enableSimulation", 0];
sleep (6 + random 4);
[_this, true] remoteExec ["enableSimulation", 0];
[_this, "Jedi_Freeze_Start", 70, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
};
};
_x spawn {
[_this, false] remoteExec ["enableSimulation", 0];
sleep (6 + random 4);
[_this, true] remoteExec ["enableSimulation", 0];
[_this, "Jedi_Freeze_Start", 70, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
};

};
} forEach nearestObjects [_unit, ["MAN","CAR","StaticWeapon"], 8];
sleep 0.6;
if (!(alive _unit) or !(animationState _unit == "STAR_WARS_FIGHT_POWERS_CRYOORPYRO")) exitWith {};
_unit setVariable ["canMakeAttack",0];
sleep 0.5;
if (!(alive _unit) or !(animationState _unit == "STAR_WARS_FIGHT_POWERS_CRYOORPYRO")) exitWith {};
if (currentWeapon _unit in IMS_Melee_Weapons) then {
[_unit, "melee_armed_idle"] remoteExec ["switchMove", 0];
}else{
[_unit, ""] remoteExec ["switchMove", 0];
};
};
};
};


if (_stance == 3) exitWith {
////Хил Другого персонажа
if ("Force_healother" in magazines _unit) then {
if ((_unit getVariable "IMS_LaF_ForceMana" >= 0.5) and (PlayerForceMana == 0)) then {
PlayerForceMana = 1;
systemChat "Heal realoading: 2:20 minutes";
[] spawn {
sleep 140;
PlayerForceMana = 0;
};
_unit setVariable ["canMakeAttack",1];
_mana = _unit getVariable "IMS_LaF_ForceMana";
_mana = _mana - 0.5;
_unit setVariable ["IMS_LaF_ForceMana",_mana,true];
[_unit, "random_shhh", 20, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
_unit setVariable ["canMakeAttack",1, true];
[_unit,  "STAR_WARS_FIGHT_POWERS_OTHER_HEAL"] remoteExec ["switchMove", 0];
sleep 2;
if (!(alive _unit) or !(animationState _unit == "STAR_WARS_FIGHT_POWERS_OTHER_HEAL")) exitWith {};
if (alive _unit) then {
[_unit, "Jedi_Freeze_Over", 70, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
{
if (!(_x == _unit)) then {
if (((_unit worldToModel (_x modelToWorld [0, 0, 0])) select 1) < 0) then 
{}else{
[_x] remoteExecCall ["ace_medical_treatment_fnc_fullHealLocal"]; 
[_x,  0] remoteExec ["setDamage", 0];
_x setVariable ["IMS_LaF_ShotsToTakeOutOneGuy",50,true];
};
};
} forEach nearestObjects [_unit, ["Man"], 8];
};
sleep 1.2;
if (!(alive _unit) or !(animationState _unit == "STAR_WARS_FIGHT_POWERS_OTHER_HEAL")) exitWith {};
_unit setVariable ["canMakeAttack",0, true];
if (currentWeapon _unit in IMS_Melee_Weapons) then {
[_unit, "melee_armed_idle"] remoteExec ["switchMove", 0];
}else{
[_unit, ""] remoteExec ["switchMove", 0];
};
};
};
};

if (_stance == 4) exitWith {
////Удушение
if (("Force_tir_chokeold" in magazines _unit)) then {
if ((PlayerForceMana == 0) and (cursorObject isKindOf "MAN")) then {
_actualEnemy = cursorObject;
if ((_actualEnemy distance _unit) > 5) exitWith {};
if (("WBK_Baf_Choking" in magazines _actualEnemy)) then {
[_actualEnemy, "STAR_WARS_baf_work"] remoteExec ["playActionNow"];
[_actualEnemy] spawn {
_unit = _this select 0;
if (isStaminaEnabled _unit) then {
    _unit allowSprint false;
    [_unit, false] remoteExec ["allowSprint"];
    sleep 0.8;
    [_unit, true] remoteExec ["allowSprint"];
  };
};
}else{
inUsingChoke = true;
PlayerForceMana = 1;
_unit setVariable ["canMakeAttack",1, true];
PowerChokeKillOrNot = 0;
[_unit, "random_shhh", 20, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
_soundCache = "Land_HelipadEmpty_F" createVehicle position _unit;
_soundCache attachTo [_unit, [0, 0, 0.2], "Spine3"]; 
[_soundCache, "Jedi_Choke_Start", 70] call CBA_fnc_globalSay3d;
_unit playActionNow "starWars_force_podniatie";
_actualEnemy attachto [_unit,[0,1,-0.8], "LeftHandMiddle1"];
[_actualEnemy,  "starWars_force_podniati_victim_anim"] remoteExec ["switchMove", 0];
[_actualEnemy,  180] remoteExec ["setDir", 0];
_actualEnemy setVariable ["canMakeAttack",1, true];

sleep 2;
if (alive _unit) then {
_unit playActionNow "starWars_force_podniati_loop";
waitUntil {!(isNull objectParent player) or !(alive _unit) or !(alive _actualEnemy) or !(PowerChokeKillOrNot == 0)};
inUsingChoke = false;
PlayerForceMana = 0;
_unit setVariable ["canMakeAttack",0, true];
if (!(isNull objectParent player) or !(alive _unit) or !(alive _actualEnemy) or (PowerChokeKillOrNot == 2)) then {
deleteVehicle _soundCache;
[_unit, "Jedi_Choke_over", 70, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
_unit playActionNow "starWars_force_podniati_out";
detach _actualEnemy;
[_actualEnemy,  true] remoteExec ["setUnconscious", 0];
sleep 1;
[_actualEnemy,  false] remoteExec ["setUnconscious", 0];
_actualEnemy setVariable ["canMakeAttack",0, true];
};
if (PowerChokeKillOrNot == 1) then {
[_unit, "random_shhh", 20, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
_unit playActionNow "starWars_force_podniati_out_choke";
sleep 1;
[_unit, "Jedi_Choke_over", 70, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
detach _actualEnemy;
[_actualEnemy,  true] remoteExec ["setUnconscious", 0];
sleep 0.1;
[_actualEnemy, "Jedi_Choke_end", 70, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
deleteVehicle _soundCache;
_actualEnemy setDamage 1;
};
};
};
};
};
};



if (_stance == 5) exitWith {
////Летающий шарик
if ("Force_fireball" in magazines _unit) then {
if (!(isNil {_unit getVariable "WBK_LightOrb"})) exitWith {};
if (_unit getVariable "IMS_LaF_ForceMana" > 0.05) then {
_unit setVariable ["canMakeAttack",1];
_mana = _unit getVariable "IMS_LaF_ForceMana";
_mana = _mana - 0.05;
_unit setVariable ["IMS_LaF_ForceMana",_mana,true];

_unit setVariable ["canMakeAttack",1];
_unit playActionNow "starWars_force_fireball";
sleep 0.2;
if (!(alive _unit)) exitWith {};
_Flame = "#particlesource" createVehicle position _unit;    
_Flame setParticleClass "IEDFlameF";   
_Flame attachto [_unit,[0,0,0.15], "LeftHandMiddle1"];
[_unit, "Jedi_Agni_Start", 60, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
[_unit, {
_unit = _this;
_LightForObj1 = "#lightpoint" createVehicleLocal (getpos _unit);  
_LightForObj1 setLightAmbient [1, 0.45, 0.15];  
_LightForObj1 setLightColor [1, 0.45, 0.15];  
_LightForObj1 setLightBrightness 0.7;
_LightForObj1 setLightUseFlare true;
_LightForObj1 setLightDayLight true;
_LightForObj1 setLightFlareSize 5;
_LightForObj1 setLightFlareMaxDistance 500;
_LightForObj1 attachto [_unit,[0,0,0.15], "LeftHandMiddle1"];
sleep 0.8;
deleteVehicle _LightForObj1;
}] remoteExec ["spawn", [0,-2] select isDedicated,false];
sleep 0.8;
if (!(alive _unit)) exitWith {deleteVehicle _Flame;};
[_unit, "random_shhh", 20, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
deleteVehicle _Flame;
sleep 0.6;
if (!(alive _unit)) exitWith {};
_unit playActionNow "starWars_force_push";
sleep 0.85;
if (!(alive _unit)) exitWith {};
[_unit, "Jedi_Agni_Sound", 90, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
[_unit, {
_unit = _this;
_wbk_fireball = "#particlesource" createVehicleLocal position _unit;    
_wbk_fireball setParticleClass "IEDFlameF";   
_wbk_fireball setDropInterval 0.001;
_LightForObj1 = "#lightpoint" createVehicleLocal (getpos _unit);  
_LightForObj1 setLightAmbient [1, 0.45, 0.15];  
_LightForObj1 setLightColor [1, 0.45, 0.15];  
_LightForObj1 setLightBrightness 0.7;
_LightForObj1 setLightUseFlare true;
_LightForObj1 setLightDayLight true;
_LightForObj1 setLightFlareSize 5;
_LightForObj1 setLightFlareMaxDistance 500;
_unit setVariable ["WBK_LightOrb", _wbk_fireball];
[_wbk_fireball, _LightForObj1, _unit] spawn {
sleep 120;
deleteVehicle (_this select 0);
deleteVehicle (_this select 1);
(_this select 2) setVariable ["WBK_LightOrb", nil];
};
while {alive _wbk_fireball} do {
_nextNumber = random 3;
_wbk_fireball setVelocityTransformation [ 
[(getPosASL _unit select 0) - 2.5,getPosASL _unit select 1,(getPosASL _unit select 2) + 2.5],  
[(getPosASL _unit select 0) + 2.5,(getPosASL _unit select 1) + _nextNumber,(getPosASL _unit select 2) + 2.5], 
[0,0,0],  
[0,0,0], 
vectorDir _unit,  
vectorDir _unit,  
vectorUp _unit,  
vectorUp _unit, 
0.1
];
_LightForObj1 setVelocityTransformation [ 
[(getPosASL _unit select 0) - 2.5,getPosASL _unit select 1,(getPosASL _unit select 2) + 2.5],  
[(getPosASL _unit select 0) + 2.5,(getPosASL _unit select 1) + _nextNumber,(getPosASL _unit select 2) + 2.5], 
[0,0,0],  
[0,0,0], 
vectorDir _unit,  
vectorDir _unit,  
vectorUp _unit,  
vectorUp _unit, 
0.1
];
sleep 0.001;
};
}] remoteExec ["spawn", [0,-2] select isDedicated,false];
_unit setVariable ["canMakeAttack",0];
};
};
};






if (_stance == 6) exitWith{
  if (("Force_tir_1" in magazines _unit) or ("Force_tir_2" in magazines _unit) or ("Force_tir_3" in magazines _unit) or ("Force_tir_Sith" in magazines _unit)) then {
      if ((cursorObject isKindOf "Tank") || (cursorObject isKindOf "Plane") || (cursorObject isKindOf "Car") || (cursorObject isKindOf "Air"))then{
        _actualTarget= cursorObject;
        if (_unit getVariable "concentrationParam" > 0.3) then {
        _stamina = _unit getVariable "concentrationParam";
        if (!(alive _actualTarget)) exitWith {};
          if (_unit distance _actualTarget <=7)then{
            hint "Found target";
            _stamina = _stamina - 0.5;
            _unit setVariable ["concentrationParam",_stamina,true];
            _unit allowDamage false;
            _arr = parseSimpleArray getText (configFile >> "CfgWeapons" >> handgunWeapon _unit >> "IMS_Melee_Param_SoundsOnHit");  
            _rndSnd = selectRandom _arr;
            [_unit, _rndSnd, 50, 3] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
            [_unit,"starWars_lightsaber_lightattack1"] remoteExec ["switchMove",0];
            [_actualTarget, ["hithull", 0.5, true, _unit]] remoteExec ["setHitPointDamage", 0];
            [_actualTarget, ["hitturret", 1, true, _unit]] remoteExec ["setHitPointDamage", 0];
            [_actualTarget, ["hitgun", 1, true, _unit]] remoteExec ["setHitPointDamage", 0];
            [_actualTarget, ["hitengine", 1, true, _unit]] remoteExec ["setHitPointDamage", 0];
            _crew = crew _actualTarget;
            {
            [_x,1] remoteExec ["setDamage", 0];
            } forEach _crew;
            sleep 1.5;
            _unit allowDamage true;
            if (currentWeapon _unit in IMS_Melee_Weapons) then {
            [_unit, "melee_armed_idle"] remoteExec ["switchMove", 0];
            }else{
            [_unit, ""] remoteExec ["switchMove", 0];
            };
          };
        };
      };
  };
};


if (_stance == 7)exitWith{
  //оглушение эйс типа
   if ("Force_oglushenie" in magazines _unit)then{
     if (!(alive _unit))exitWith{};
      if (_unit getVariable "IMS_LaF_ForceMana" > 0.15)then{
        _mana= _unit getVariable "IMS_LaF_ForceMana";
        _mana=_mana - 0.15;
        _unit setVariable ["IMS_LaF_ForceMana",_mana,true];
        [_unit,  "STAR_WARS_FIGHT_POWERS_PULL"] remoteExec ["switchMove", 0];
        _unit allowDamage false;
        {_x spawn{
         [_this,true,15,true]remoteExecCall ["ace_medical_fnc_setUnconscious",0]; 
          [_x, "dobi_fall", 70, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
        };} forEach nearestObjects [_unit, ["Man"], 10];
        sleep 0.4;
        if (currentWeapon _unit in IMS_Melee_Weapons) then {
          [_unit, "melee_armed_idle"] remoteExec ["switchMove", 0];
        }else{
          [_unit, ""] remoteExec ["switchMove", 0];
        };
      };
   };
};
if (_stance == 8) exitWith {
  // заставить юнита сдатся
  if ("Force_conviction")then{
    if(!(alive _unit))exitWIth{};
    if (_unit getVariable "IMS_LaF_ForceMana" > 0.3)then{
      _mana = _unit getVariable "IMS_LaF_ForceMana";
      _mana=_mana-0.3;
      _unit setVariable["IMS_LaF_ForceMana",_mana,true];
      [_unit,  "STAR_WARS_FIGHT_POWERS_CRYOORPYRO"] remoteExec ["switchMove", 0];
      {_x spawn{
        private _weaponHolder = "GroundWeaponHolder_Scripted" createVehicle getPosATL player;
        [_x,"DropWeapon", _weaponHolder, currentWeapon _x]remoteExec["action",0];
        sleep 2;
        [_x,"Surrender",_x]remoteExec["action",0];
      };} forEach nearestObjects [_unit, ["Man"], 10];
    };
  };
};





