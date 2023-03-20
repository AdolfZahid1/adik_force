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
	class Force_oglushenie: Force_tir_3
	{
		author = "Adik";
		displayName = "Force stun";
	};
	class Force_conviction: Force_oglushenie
	{
		displayName  = "Force conviction";
	};
	// class Force_ionize: Force_oglushenie
	// {
	// 	displayName = "Force ionization";
	// };
	class Force_speed: Force_oglushenie
	{
		displayName = "Force speed";
	};
};