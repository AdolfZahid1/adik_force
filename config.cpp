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
class CfgMagazines
{
	class Force_tir_3;
	class Force_freeze: Force_tir_3
	{
		author = "Adik";
		displayName="Force freeze";
	};
	class Force_healother: Force_freeze
	{
		displayName="Force heal other";
	};
	class Force_fireball: Force_freeze
	{
		displayName="Force fireball";
	};
	class Force_oglushenie: Force_freeze
	{
		displayName = "Force stun";
	};
	class Force_conviction: Force_freeze
	{
		displayName  = "Force conviction";
	};
	class Force_speed: Force_freeze
	{
		displayName = "Force speed";
	};
	class Force_Stealth: Force_freeze
	{
		displayName = "Force stealth";
	};
	class Force_Storm: Force_freeze
	{
		displayName = "Force storm";
	};
};