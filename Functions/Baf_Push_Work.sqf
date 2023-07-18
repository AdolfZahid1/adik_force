params[["_unit",objNull],["_actualTarget",objNull]];
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