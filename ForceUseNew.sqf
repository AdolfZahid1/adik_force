_unit = _this select 0;
_stance = _this select 1;

if (_stance == 1) exitWith{
  //рубануть технику
  if ((("Force_tir_1" in magazines _unit) or ("Force_tir_2" in magazines _unit) or ("Force_tir_3" in magazines _unit) or ("Force_tir_Sith"  in magazines _unit)) && (currentWeapon _unit in IMS_Melee_Weapons)) then {
    if ((cursorObject isKindOf "Tank") || (cursorObject isKindOf "Plane") || (cursorObject isKindOf "Car") || (cursorObject isKindOf "Air"))then{
      _actualTarget = cursorObject;
      if ((_unit getVariable "concentrationParam" < 0.3) ||!(alive _actualTarget)) exitWith{};
      _stamina = _unit getVariable "concentrationParam";
      if (_unit distance _actualTarget <= distanceForVehicleKill)then{
        _unit setVariable ["concentrationParam",_stamina - 0.5,true];
        _unit allowDamage false;
        _arr = parseSimpleArray getText (configFile >> "CfgWeapons" >> handgunWeapon _unit >> "IMS_Melee_Param_SoundsOnHit");  
        _rndSnd = selectRandom _arr;
        [_unit, _rndSnd, 50, 3] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
        [_unit,"starWars_lightsaber_lightattack1"] remoteExec ["switchMove",0];
        [_actualTarget, ["hithull", 0.5, true, _unit]] remoteExec ["setHitPointDamage", 0];
        [_actualTarget, ["hitturret", 1, true, _unit]] remoteExec ["setHitPointDamage", 0];
        [_actualTarget, ["hitgun", 1, true, _unit]] remoteExec ["setHitPointDamage", 0];
        [_actualTarget, ["hitengine", 1, true, _unit]] remoteExec ["setHitPointDamage", 0];
        _Targetcrew = crew _actualTarget;
        {
          [_x] remoteExec ["doGetOut ", 0];
        } forEach _Targetcrew;
        sleep 1.5;
        _unit allowDamage true;
        [_unit, "melee_armed_idle"] remoteExec ["switchMove", 0];
      };
      };
  };
};

if (_stance == 2)exitWith{
  //оглушение эйс типа
   if (("Force_oglushenie" in magazines _unit) && (("Force_tir_1" in magazines _unit) or ("Force_tir_2" in magazines _unit) or ("Force_tir_3" in magazines _unit) or ("Force_tir_Sith"  in magazines _unit)))then{
     if (cursorObject isKindOf "Man")then {
      _actualTarget= cursorObject;
      if (!(alive _unit) || !(alive _actualTarget) || (_unit getVariable "IMS_LaF_ForceMana" < 0.15))exitWith{};
      _mana= _unit getVariable "IMS_LaF_ForceMana";
      _unit setVariable ["IMS_LaF_ForceMana",_mana- 0.15,true];
      [_unit,  "STAR_WARS_FIGHT_POWERS_PULL"] remoteExec ["switchMove", 0];
      _unit allowDamage false;
      [_unit, "FP_Pull", 10, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
        if (_unit != _actualTarget) then {
          if (("WBK_Baf_Push" in magazines _actualTarget)) exitWith {
          [_actualTarget, "STAR_WARS_baf_work"] remoteExec ["playActionNow"];
          [_actualTarget] spawn {
          _unit = _this select 0;
          if (isStaminaEnabled _unit) then {
              _unit allowSprint false;
              [_unit, false] remoteExec ["allowSprint"];
              sleep 0.8;
              [_unit, true] remoteExec ["allowSprint"];
            };
          };
          };
        };
        if ((alive _actualTarget) && (_actualTarget != _unit))then {
          [_actualTarget,true,15,true]remoteExecCall ["ace_medical_fnc_setUnconscious",0]; 
          [_actualTarget, "dobi_fall", 70, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
        };
      sleep 1;
      _unit allowDamage true;
      if (currentWeapon _unit in IMS_Melee_Weapons) then {
        [_unit, "melee_armed_idle"] remoteExec ["switchMove", 0];
      }else{
        [_unit, ""] remoteExec ["switchMove", 0];
      };
   };
  };
};

if (_stance == 3) exitWith {
  // Make the unit surrender
  if (("Force_conviction" in magazines _unit) && (("Force_tir_1" in magazines _unit) or ("Force_tir_2" in magazines _unit) or ("Force_tir_3" in magazines _unit) or ("Force_tir_Sith"  in magazines _unit))) then {
    if (cursorObject isKindOf "Man") then {
      _actualTarget = cursorObject;
      if (!(alive _unit) || !(alive _actualTarget) || (_unit getVariable "IMS_LaF_ForceMana" < 0.3)) exitWith {};
      
      _mana = _unit getVariable "IMS_LaF_ForceMana";
      _unit setVariable ["IMS_LaF_ForceMana", _mana - 0.3, true];
      [_unit, "STAR_WARS_FIGHT_POWERS_CRYOORPYRO"] remoteExec ["switchMove", 0];
      [_unit, "FP_Pull", 10, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
      
      if (_unit != _actualTarget) then {
        if (("WBK_Baf_Push" in magazines _actualTarget)) exitWith {
          [_actualTarget, "STAR_WARS_baf_work"] remoteExec ["playActionNow"];
          [_actualTarget] spawn {
            _unit = _this select 0;
            if (isStaminaEnabled _unit) then {
              _unit allowSprint false;
              [_unit, false] remoteExec ["allowSprint"];
              sleep 0.8;
              [_unit, true] remoteExec ["allowSprint"];
            };
          };
        };
        [_actualTarget, "Surrender"] remoteExec ["playActionNow", 0];
        ["ace_captives_setSurrendered", [_actualTarget, true]] call CBA_fnc_globalEvent;
      };
      
      sleep 2;
      if (currentWeapon _unit in IMS_Melee_Weapons) then {
        [_unit, "melee_armed_idle"] remoteExec ["switchMove", 0];
      } else {
        [_unit, ""] remoteExec ["switchMove", 0];
      };
    };
  };
};

if (_stance == 4)exitWith{
  // заставить игрока отжиматся
  if (("Force_tir_2" in magazines _unit) or ("Force_tir_3" in magazines _unit) or ("Force_tir_Sith"  in magazines _unit)) then {
    if (cursorObject isKindOf "Man")then {
      _actualTarget= cursorObject;
      if (!(alive _unit) || !(alive _actualTarget) || (_unit getVariable "IMS_LaF_ForceMana" < 0.3)) exitWith {};
      _mana = _unit getVariable "IMS_LaF_ForceMana";
      _unit setVariable["IMS_LaF_ForceMana",_mana-0.3,true];
      _unit playActionNow "starWars_force_push";
      [_unit, "FP_Pull", 10, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
      if ((alive _actualTarget) and (_unit != _actualTarget) and (isPlayer _actualTarget)) then {
        if (("WBK_Baf_Push" in magazines _actualTarget)) exitWith {
          [_actualTarget, "STAR_WARS_baf_work"] remoteExec ["playActionNow"];
          [_actualTarget] spawn {
          _unit = _this select 0;
          if (isStaminaEnabled _unit) then {
              _unit allowSprint false;
              [_unit, false] remoteExec ["allowSprint"];
              sleep 0.8;
              [_unit, true] remoteExec ["allowSprint"];
            };
          };
        };
        [_actualTarget, "AmovPercMstpSnonWnonDnon_exercisePushup"] remoteExec ["playMoveNow", 0];
      };
      sleep 2;
      if (currentWeapon _unit in IMS_Melee_Weapons) then {
        [_unit, "melee_armed_idle"] remoteExec ["switchMove", 0];
      }else{
        [_unit, ""] remoteExec ["switchMove", 0];
      };
    };
  };
};

if (_stance == 5) then {
  // Force Speed
  if (("Force_speed" in magazines _unit) && (("Force_tir_1" in magazines _unit) or ("Force_tir_2" in magazines _unit) or ("Force_tir_3" in magazines _unit) or ("Force_tir_Sith"  in magazines _unit))) then {
    if (!(alive _unit)) exitWith {};
    
    if (_unit getVariable "SpeedForce" == true) exitWith {
      _unit setAnimSpeedCoef 1;
      _unit enableFatigue true;
      _unit setVariable ["SpeedForce", false, true];
      [_unit, "FP_Pull", 10, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf"; // Activation sound
    };
    
    if (_unit getVariable "IMS_LaF_ForceMana" > 0.1) then {
      _mana = _unit getVariable "IMS_LaF_ForceMana";
      _unit setVariable ["SpeedForce", true, true];
      [_unit, "FP_Pull", 10, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf"; // Activation sound
      
      // Attach particle effect to the player
      [_unit, {
        params ["_object"];
        _gravi1 = "#particlesource" createVehicle getpos _object;  
        _gravi1 setParticleCircle [0, [0.1, 0.1, 0.1]]; 
        _gravi1 setParticleRandom [0, [0, 0.1, 1], [0.1, 0, 0.1], 0, 0.1, [0, 0, 0, 0.1], 0, 0]; 
        _gravi1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract", 1, 0, 1], "", "Billboard", 1, 4, [0, 0, 0], [0, 0, 0.5], 9, 10, 7.9, 0.1, [0.6, 1, 0.9, 0.8], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0, 0.1, 0.2, 0.5, 0.1, 0.1], 0, 0, "", "", _object]; 
        _gravi1 setDropInterval 0.1;  
        _gravi1 attachTo [_unit];
      }] remoteExec ["spawn", [0, -2] select isDedicated, false];
      
      while {_unit getVariable "IMS_LaF_ForceMana" > 0 && _unit getVariable "SpeedForce" == true} do {
        _unit setAnimSpeedCoef 5; // Increase speed
        _unit setFatigue 0; // Set fatigue to maximum
        _unit enableFatigue false; // Disable fatigue
        _mana = _unit getVariable "IMS_LaF_ForceMana";
        _mana = _mana - (speedForceManaConsumption/100);
        _unit setVariable ["IMS_LaF_ForceMana", _mana, true];-
        sleep 1;
      };
      
      deleteVehicle _gravi1;
      _unit setAnimSpeedCoef 1;
      _unit enableFatigue true;
      _unit setVariable ["SpeedForce", false, true];
    };
  };
};

if (_stance == 6) then {
  // Force Stealth
  if (("Force_Stealth" in magazines _unit) && (("Force_tir_1" in magazines _unit) or ("Force_tir_2" in magazines _unit) or ("Force_tir_3" in magazines _unit) or ("Force_tir_Sith"  in magazines _unit))) then {
    if (!(alive _unit)) exitWith {};
    if (_unit getVariable "Stealth" == true) exitWith {
      [_unit, false] remoteExec ["hideObjectGlobal", 0];
      _unit setUnitTrait ["audibleCoef", 1];
      _unit setUnitTrait ["camouflageCoef", 1];
      _unit setVariable ["Stealth", false, true];
    };
    
    if (_unit getVariable "IMS_LaF_ForceMana" > (manaToUseStealth/100)) then {
      [_unit, true] remoteExec ["hideObjectGlobal", 0];
      _unit allowDamage true;
      _unit setVariable ["Stealth", true, true];
      _unit setUnitTrait ["audibleCoef", 0.001];
      _unit setUnitTrait ["camouflageCoef", 0.001];
      
      while {_unit getVariable "IMS_LaF_ForceMana" > 0 && _unit getVariable "Stealth" == true} do {
        if (currentWeapon _unit != "") exitWith {};
        _mana = _unit getVariable "IMS_LaF_ForceMana";
        _mana = _mana - (stealthManaConsumption/100);
        _unit setVariable ["IMS_LaF_ForceMana", _mana, true];
        sleep 1;
      };
      
      _unit setVariable ["Stealth", false, true];
      _unit setUnitTrait ["audibleCoef", 1];
      _unit setUnitTrait ["camouflageCoef", 1];
    };
  };
};