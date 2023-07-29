class CfgFunctions
{
	class TAG
	{
		class Force
		{
			requiredAddons[] = { "adik_force" };
			file = "adik_force\Functions\";
			class baf_Push_Work {
				file = "Baf_Push_Work.sqf";
			}; // file path will be <ROOT>\My\Category\Path\fn_myFunction.sqf";
			class play_Random_Melee_Sound{
				file = "PlayRandomMeleeSound.sqf";
			};
		};
	};
};