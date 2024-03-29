_unit = _this select 0;
_stance = _this select 1;

if (_stance == 1) then {
  // Full stun
  if ("Force_freeze" in magazines _unit) then {
    if (_unit getVariable "IMS_LaF_ForceMana" > 0.3) then {
      _unit setVariable ["canMakeAttack", 1];
      _mana = _unit getVariable "IMS_LaF_ForceMana";
      _mana = _mana - 0.3;
      _unit setVariable ["IMS_LaF_ForceMana", _mana, true];
      [_unit, "STAR_WARS_FIGHT_POWERS_CRYOORPYRO"] remoteExec ["switchMove", 0];
      _unit allowDamage false;

      {
        if ((alive _x) and !(isPlayer _x) and (handgunWeapon _x in IMS_LightSabers)) then {
          if (((_x worldToModel (_unit modelToWorld [0, 0, 0])) select 1) < 0) then {
            [_x, [9, 9, 1.5], "starWars_landRoll"] spawn strafeFwrd_SW;
          } else {
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
      }] remoteExec ["spawn", [0, -2] select isDedicated, false];

      sleep 0.8;

      if (!(alive _unit) or !(animationState _unit == "STAR_WARS_FIGHT_POWERS_CRYOORPYRO")) exitWith {};

      [_unit, [7 * (sin (getdir _unit)), 7 * (cos (getdir _unit)), 1]] remoteExec ["setvelocity", _unit];

      [_unit, {
        _ripple = "#particlesource" createVehicleLocal getposatl _this;
        _ripple setParticleCircle [0, [0, 0, 0]];
        _ripple setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
        _ripple setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 1, 0.5, [0, 0, 0], [0, 0, 0], 0, 10, 7.9, 0, [10, 10], [[1, 1, 1, 1], [1, 1, 1, 1]], [0.08], 1, 0, "", "", _this];
        _ripple setDropInterval 0.01;
        _ripple attachto [_this, [0, 0, 0]];
        sleep 1.1;
        deleteVehicle _ripple;
      }] remoteExec ["spawn", [0, -2] select isDedicated, false];

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
              _x setVariable ["AI_CanTurn", 1, true];
              _sas = getDirVisual _unit;
              [_x, [9 * (sin (_sas)), 9 * (cos (_sas)), 2]] remoteExec ["setvelocity", _x];
              [_x, 228, _unit] spawn concentrationToZero;
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
              }] remoteExec ["spawn", [0, -2] select isDedicated, false];
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
      } forEach nearestObjects [_unit, ["MAN", "CAR", "StaticWeapon"], 8];

      sleep 0.6;

      if (!(alive _unit) or !(animationState _unit == "STAR_WARS_FIGHT_POWERS_CRYOORPYRO")) exitWith {};

      _unit setVariable ["canMakeAttack", 0];

      sleep 0.5;

      if (!(alive _unit) or !(animationState _unit == "STAR_WARS_FIGHT_POWERS_CRYOORPYRO")) exitWith {};

      if (currentWeapon _unit in IMS_Melee_Weapons) then {
        [_unit, "melee_armed_idle"] remoteExec ["switchMove", 0];
      } else {
        [_unit, ""] remoteExec ["switchMove", 0];
      };
    };
  };
};



if (_stance == 2) then {
  // Heal another character
  if ("Force_healother" in magazines _unit) then {
    if ((_unit getVariable "IMS_LaF_ForceMana" >= 0.5) and (PlayerForceMana == 0)) then {
      PlayerForceMana = 1;
      systemChat "Heal reloading: 2 minutes 20 seconds";
      [] spawn {
        sleep 140;
        PlayerForceMana = 0;
      };
      _unit setVariable ["canMakeAttack", 1];
      _mana = _unit getVariable "IMS_LaF_ForceMana";
      _mana = _mana - 0.5;
      _unit setVariable ["IMS_LaF_ForceMana", _mana, true];
      [_unit, "random_shhh", 20, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
      _unit setVariable ["canMakeAttack", 1, true];
      [_unit, "STAR_WARS_FIGHT_POWERS_OTHER_HEAL"] remoteExec ["switchMove", 0];
      sleep 2;
      if (!(alive _unit) or !(animationState _unit == "STAR_WARS_FIGHT_POWERS_OTHER_HEAL")) exitWith {};
      if (alive _unit) then {
        [_unit, "Jedi_Freeze_Over", 70, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
        {
          if (!(_x == _unit)) then {
            if (((_unit worldToModel (_x modelToWorld [0, 0, 0])) select 1) < 0) then {} else {
              [_x] remoteExecCall ["ace_medical_treatment_fnc_fullHealLocal"];
              [_x, 0] remoteExec ["setDamage", 0];
              _x setVariable ["IMS_LaF_ShotsToTakeOutOneGuy", 50, true];
            };
          };
        } forEach nearestObjects [_unit, ["Man"], 8];
      };
      sleep 1.2;
      if (!(alive _unit) or !(animationState _unit == "STAR_WARS_FIGHT_POWERS_OTHER_HEAL")) exitWith {};
      _unit setVariable ["canMakeAttack", 0, true];
      if (currentWeapon _unit in IMS_Melee_Weapons) then {
        [_unit, "melee_armed_idle"] remoteExec ["switchMove", 0];
      } else {
        [_unit, ""] remoteExec ["switchMove", 0];
      };
    };
  };
};


if (_stance == 3) then {
  // Flying Fireball
  if ("Force_fireball" in magazines _unit) then {
    if (!(isNil {_unit getVariable "WBK_LightOrb"})) exitWith {};
    if (_unit getVariable "IMS_LaF_ForceMana" > 0.05) then {
      _unit setVariable ["canMakeAttack", 1];
      _mana = _unit getVariable "IMS_LaF_ForceMana";
      _mana = _mana - 0.05;
      _unit setVariable ["IMS_LaF_ForceMana", _mana, true];

      _unit setVariable ["canMakeAttack", 1];
      _unit playActionNow "starWars_force_fireball";
      sleep 0.2;
      if (!(alive _unit)) exitWith {};
      _Flame = "#particlesource" createVehicle position _unit;
      _Flame setParticleClass "IEDFlameF";
      _Flame attachto [_unit, [0, 0, 0.15], "LeftHandMiddle1"];
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
        _LightForObj1 attachto [_unit, [0, 0, 0.15], "LeftHandMiddle1"];
        sleep 0.8;
        deleteVehicle _LightForObj1;
      }] remoteExec ["spawn", [0, -2] select isDedicated, false];
      sleep 0.8;
      if (!(alive _unit)) exitWith { deleteVehicle _Flame; };
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
            [(getPosASL _unit select 0) - 2.5, getPosASL _unit select 1, (getPosASL _unit select 2) + 2.5],
            [(getPosASL _unit select 0) + 2.5, (getPosASL _unit select 1) + _nextNumber, (getPosASL _unit select 2) + 2.5],
            [0, 0, 0],
            [0, 0, 0],
            vectorDir _unit,
            vectorDir _unit,
            vectorUp _unit,
            vectorUp _unit,
            0.1
          ];
          _LightForObj1 setVelocityTransformation [
            [(getPosASL _unit select 0) - 2.5, getPosASL _unit select 1, (getPosASL _unit select 2) + 2.5],
            [(getPosASL _unit select 0) + 2.5, (getPosASL _unit select 1) + _nextNumber, (getPosASL _unit select 2) + 2.5],
            [0, 0, 0],
            [0, 0, 0],
            vectorDir _unit,
            vectorDir _unit,
            vectorUp _unit,
            vectorUp _unit,
            0.1
          ];
          sleep 0.001;
        };
      }] remoteExec ["spawn", [0, -2] select isDedicated, false];
      _unit setVariable ["canMakeAttack", 0];
    };
  };
};