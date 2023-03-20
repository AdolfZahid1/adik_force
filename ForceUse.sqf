_unit = _this select 0;
_stance = _this select 1;

if (_stance == 1) exitWith{
  //рубануть технику
  if (("Force_tir_1" in magazines _unit) or ("Force_tir_2" in magazines _unit) or ("Force_tir_3" in magazines _unit) or ("Force_tir_Sith" in magazines _unit)) then {
      if ((cursorObject isKindOf "Tank") || (cursorObject isKindOf "Plane") || (cursorObject isKindOf "Car") || (cursorObject isKindOf "Air"))then{
        _actualTarget= cursorObject;
        if (_unit getVariable "concentrationParam" > 0.3) then {
        _stamina = _unit getVariable "concentrationParam";
        if (!(alive _actualTarget)) exitWith {};
          if (_unit distance _actualTarget <=7)then{
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


if (_stance == 2)exitWith{
  //оглушение эйс типа
   if (("Force_oglushenie" in magazines _unit) && (("Force_tir_1" in magazines _unit) or ("Force_tir_2" in magazines _unit) or ("Force_tir_3" in magazines _unit) or ("Force_tir_Sith" in magazines _unit)))then{
     if (!(alive _unit))exitWith{};
     if (cursorObject isKindOf "Man")then {
      _actualTarget= cursorObject;
      if (_unit getVariable "IMS_LaF_ForceMana" > 0.15)then{
        _mana= _unit getVariable "IMS_LaF_ForceMana";
        _mana=_mana - 0.15;
        _unit setVariable ["IMS_LaF_ForceMana",_mana,true];
        [_unit,  "STAR_WARS_FIGHT_POWERS_PULL"] remoteExec ["switchMove", 0];
        _unit allowDamage false;
        [_unit, "FP_Pull", 10, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
        
          if ((alive _actualTarget) and (_unit != _actualTarget))then {
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
  };




if (_stance == 3) exitWith {
  // заставить юнита сдатся
  if (("Force_conviction" in magazines _unit) && (("Force_tir_1" in magazines _unit) or ("Force_tir_2" in magazines _unit) or ("Force_tir_3" in magazines _unit) or ("Force_tir_Sith" in magazines _unit)))then{
    if(!(alive _unit))exitWith{};
    if (cursorObject isKindOf "Man")then {
      _actualTarget= cursorObject;
      if (_unit getVariable "IMS_LaF_ForceMana" > 0.3)then{
        _mana = _unit getVariable "IMS_LaF_ForceMana";
        _mana=_mana-0.3;
        _unit setVariable["IMS_LaF_ForceMana",_mana,true];
        [_unit,  "STAR_WARS_FIGHT_POWERS_CRYOORPYRO"] remoteExec ["switchMove", 0];
        [_unit, "FP_Pull", 10, 7] execVM "\WebKnight_StarWars_Mechanic\createSoundGlobal.sqf";
        if ((alive _actualTarget) and (_unit != _actualTarget)) then {
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
          ["ace_captives_setSurrendered",[_actualTarget,true]] call CBA_fnc_globalEvent;
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
};
if (_stance == 4)exitWith{
  // заставить игрока отжиматся
  if (("Force_tir_2" in magazines _unit) or ("Force_tir_3" in magazines _unit) or ("Force_tir_Sith" in magazines _unit)) then {
    if(!(alive _unit))exitWith{};
    if (cursorObject isKindOf "Man")then {
      _actualTarget= cursorObject;
    if (_unit getVariable "IMS_LaF_ForceMana" > 0.3)then{
      _mana = _unit getVariable "IMS_LaF_ForceMana";
      _mana=_mana-0.3;
      _unit setVariable["IMS_LaF_ForceMana",_mana,true];
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
};

if (_stance == 5)exitWith{
  if (("Force_speed" in magazines _unit ) && (("Force_tir_1" in magazines _unit) or ("Force_tir_2" in magazines _unit) or ("Force_tir_3" in magazines _unit) or ("Force_tir_Sith" in magazines _unit)))then{
    if(!(alive _unit))exitWith{};
    if (_unit getVariable "IMS_LaF_ForceMana" > 0.1)then{
      _mana = _unit getVariable "IMS_LaF_ForceMana";
      player setAnimSpeedCoef 5;
      player setFatigue 0;
      player enableFatigue false;
      while {_unit getVariable "IMS_LaF_ForceMana" > 0} do {
        _mana = _mana - 0.1;
        sleep 1;
      };
      player setAnimSpeedCoef 1;
      player enableFatigue true;
  };
  };
};




