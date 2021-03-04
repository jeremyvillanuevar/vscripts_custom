printf( "\n\n\n\n==============Loaded MODIFYDIRECTOR =============== %f\n\n\n\n", __COOP_VERSION__);

//-----------------------------------------------------

// Include the VScript Library

/*
Skyboxes <- [
   "0",
   "2"
]

worldspawn <- Entities.FindByClassname( null, "worldspawn" );
local i = RandomInt( 0, Skyboxes.len()-1 );
printl("Skyboxe is "+Skyboxes[i]);
printl( worldspawn.__KeyValueFromString( "timeofday", Skyboxes[i] ) );
*/
//g_MapScript <- getroottable().DirectorScript.MapScript
//g_ModeScript <- getroottable().DirectorScript.MapScript.ChallengeScript
//SessionOptions <- g_ModeScript.DirectorOptions

::SpawnTank <- function ( args )
{
	Msg("Spawning Tank!\n");
	Utils.SpawnZombie( Z_TANK );
}

//function Notifications::OnSurvivorsLeftStartArea::CreateTankTimer()
function Notifications::FirstSurvLeftStartArea::YourFunctionName ( player, params )
{
	local Client_Count = 0;
	foreach( survivor in ::VSLib.EasyLogic.Players.Survivors() )
	{
		if(!::AllowShowBotSurvivor)
		{
			if(survivor.IsBot())
				continue;	
		}
		Client_Count++;	
	}	
	//30 en facil para 4 personas, entonces si hay 5 30/4*5, si hay 1 30/4*1,si hay 2 30/4*2
	if ( "cm_MaxSpecials" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().cm_MaxSpecials <-  DirectorScript.GetDirectorOptions().cm_MaxSpecials*Client_Count/4;
	if ( "cm_DominatorLimit" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().cm_DominatorLimit <- DirectorScript.GetDirectorOptions().cm_DominatorLimit*Client_Count/4;
	if ( "cm_SpecialRespawnInterval" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().cm_SpecialRespawnInterval <- 30;
	if ( "SpecialInitialSpawnDelayMin" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().SpecialInitialSpawnDelayMin <- 5;
	if ( "SpecialInitialSpawnDelayMax" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().SpecialInitialSpawnDelayMax <- 10;
	if ( "SmokerLimit" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().SmokerLimit <- DirectorScript.GetDirectorOptions().SmokerLimit*Client_Count/4;
	if ( "BoomerLimit" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().BoomerLimit <- DirectorScript.GetDirectorOptions().BoomerLimit*Client_Count/4;
	if ( "HunterLimit" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().HunterLimit <- DirectorScript.GetDirectorOptions().HunterLimit*Client_Count/4;
	if ( "SpitterLimit" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().SpitterLimit <- DirectorScript.GetDirectorOptions().SpitterLimit*Client_Count/4;
	if ( "JockeyLimit" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().JockeyLimit <- DirectorScript.GetDirectorOptions().JockeyLimit*Client_Count/4;
	if ( "ChargerLimit" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().ChargerLimit <- DirectorScript.GetDirectorOptions().ChargerLimit*Client_Count/4;
	if ( "WitchLimit" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().WitchLimit <- DirectorScript.GetDirectorOptions().WitchLimit*Client_Count/4;
	if ( "cm_WitchLimit" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().cm_WitchLimit <- DirectorScript.GetDirectorOptions().cm_WitchLimit*Client_Count/4;
	
	local maxIncap = 6;	
	if ( "SurvivorMaxIncapacitatedCount" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().SurvivorMaxIncapacitatedCount <- maxIncap;
	
	//30 en facil para 4 personas, entonces si hay 5 30/4*5, si hay 1 30/4*1,si hay 2 30/4*2
	if ( "cm_CommonLimit" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().cm_CommonLimit <- DirectorScript.GetDirectorOptions().cm_CommonLimit*Client_Count/4;
	//The horde spawning pacing consists of: 
	//BUILD_UP -> spawn horde -> SUSTAIN_PEAK -> RELAX -> BUILD_UP again.
	//	Setting LockTempo = true removes the 
	//"SUSTAIN_PEAK -> RELAX -> BUILD_UP" bit making your hordes spawn constantly without a delay.
	if ( "LockTempo" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().LockTempo <-  0
	//All survivors must be below this intensity before a Peak is allowed to switch to Relax (in addition to the normal peak timer)
	if ( "IntensityRelaxThreshold" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().IntensityRelaxThreshold <-  0.99
	// Modifies the length of the SUSTAIN_PEAK and RELAX states to shorten the time between mob spawns.
	//Continuous peak//持续高峰
	if ( "SustainPeakMinTime" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().SustainPeakMinTime <- 25
	if ( "SustainPeakMaxTime" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().SustainPeakMaxTime  <- 30
	//Relaxation stage//放松阶段
	if ( "RelaxMinInterval" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().RelaxMinInterval <- 2
	if ( "RelaxMaxInterval" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().RelaxMaxInterval <- 4
	if ( "RelaxMaxFlowTravel" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().RelaxMaxFlowTravel <- 50
	
	//BuildUpMinInterval
	// Sets the time between mob spawns. Mobs can only spawn when the pacing is in the BUILD_UP state.
	//The mob refresh time-parameters are modified in real time//尸潮刷新时间 -参数被实时修改
	if ( "MobSpawnMinTime" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().MobSpawnMinTime <- 1
	if ( "MobSpawnMaxTime" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().MobSpawnMaxTime <- 3
	// How many zombies are in each mob.
	//The size of the mob-parameters are modified in real time//尸潮大小		-参数被实时修改
	if ( "MobMinSize" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().MobMinSize <- 30
	if ( "MobMaxSize" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().MobMaxSize <- 45	
	//Reserved number of zombies-parameters are modified in real time//预留僵尸数量 -参数被实时修改
	if ( "MobMaxPending" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().MobMaxPending  <- 10
	
	//Wanderer count (N) is zeroed:
	//When an area becomes visible to any Survivor
	//When the Director is in Relax mode
	//Wanderers	
	//AN ERROR HAS OCCURED [the index 'WanderingZombieDensityModifier' does not exist]
	if ( "WanderingZombieDensityModifier" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().WanderingZombieDensityModifier  <- DirectorScript.GetDirectorOptions().cm_DominatorLimit*Client_Count/4 //float
	else 
		DirectorScript.GetDirectorOptions().WanderingZombieDensityModifier<-  1*Client_Count/4
	if ( "AlwaysAllowWanderers" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().AlwaysAllowWanderers <- true//bool
	if ( "ClearedWandererRespawnChance" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().ClearedWandererRespawnChance <- 33//percent int
	if ( "NumReservedWanderers" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().NumReservedWanderers<-  DirectorScript.GetDirectorOptions().NumReservedWanderers*Client_Count/4//infected additional from mobs
	else 
		DirectorScript.GetDirectorOptions().NumReservedWanderers<-  1*Client_Count/4
	//All survivors must be below this intensity before a Wanderer is allowed to switch to Relax (in addition to the normal peak timer)
	if ( "IntensityRelaxAllowWanderersThreshold" in DirectorScript.GetDirectorOptions() )
		DirectorScript.GetDirectorOptions().IntensityRelaxAllowWanderersThreshold <-  1
	
	
	local Difficulty = Convars.GetStr( "z_difficulty" ).tolower();
	if (Client_Count>2)
	{
		if ( "ProhibitBosses" in DirectorScript.GetDirectorOptions() )
			DirectorScript.GetDirectorOptions().ProhibitBosses <- false
	}
	else
		if ( "ProhibitBosses" in DirectorScript.GetDirectorOptions() )
			DirectorScript.GetDirectorOptions().ProhibitBosses <- true
	/*
	local enable_tanks = 1;
	local finale_check = 1;
	local allow_random_trigger = 0;
	if ( Difficulty == "easy" )
	{
		enable_tanks = 1;
		finale_check = 1;
		allow_random_trigger = 0;
		//Msg("Setting Tank Health to 1500\n");
		//tank.SetHealth(1500);
		//if ( enable_tanks == 1 )
		//{
		//	SpawnTank(null);
		//	Timers.AddTimer( 60.0, true, SpawnTank );
		//}
	}
	else if ( Difficulty == "normal" || Difficulty == "hard" )
	{
		//Msg("Setting Tank Health to 2000\n");
		//tank.SetHealth(2000);
	}
	else if ( Difficulty == "impossible" )
	{
		//Msg("Setting Tank Health to 4000\n");
		//tank.SetHealth(4000);
	}
	*/	
}
