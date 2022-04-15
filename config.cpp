class CfgPatches
{
	class adik_force
	{
		name="adik_force";
		author="Adik";
		units[]={};
		weapons[]={};
		requiredAddons[]=
		{
			"cba_settings"
		};
	};
};
class Extended_PreInit_EventHandlers
{
	AdikForce="call compile preprocessFileLineNumbers ""\adik_force\XEH_preInit.sqf""";
};
class CfgWeapons
{
	class Force_tir_3;
	class Force_choke: Force_tir_3
	{
		displayName="Force crush";

	};
	class Force_stun: Force_choke
	{
		displayName="Force stun";

	};
	class Force_healother: Force_choke
	{
		displayName="Force heal other";

	};
	class Force_chokeold: Force_choke
	{
		displayName="Force choke";

	};
	class Force_fireball: Force_choke
	{
		displayName="Force fireball";

	};

};