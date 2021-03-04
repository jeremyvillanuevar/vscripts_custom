printl( "\n\n\n\n==============Loaded MODIFYDIRECTORS ===============\n\n\n\n");
//-----------------------------------------------------
// Creating DirectorOptions on MapScript Scope 

//Default Paceful Mode Stop
if ( (developer() > 0) || (DEBUG == 1))
	Director.ResetMobTimer()

//Director Mode Empty for using Local Scripts
if ( DirectorScript.MapScript.ChallengeScript.rawin( "DirectorOptions") )
{
	if ( (developer() > 0) || (DEBUG == 1))
	{
		ClientPrint(null, 3, BLUE+"DirectorOptions on MapScript.ChallengeScript Scope Exists");
		delete	DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnSetRule;
		delete	DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnDirectionCount;
		delete	DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnDirectionMask;
		delete	DirectorScript.MapScript.ChallengeScript.DirectorOptions.ScriptedStageValue;
		delete	DirectorScript.MapScript.ChallengeScript.DirectorOptions.ScriptedStageType;
	
	}
}
else
{	

	if ( (developer() > 0) || (DEBUG == 1))
	{
		ClientPrint(null, 3, BLUE+"Creating DirectorOptions on MapScript.ChallengeScript Scope");
	}
	::DirectorScript.MapScript.DirectorOptions <-
	{
	}
}

//We will use Map Options for Base
if ( DirectorScript.MapScript.rawin( "DirectorOptions") )
{

	if ( (developer() > 0) || (DEBUG == 1))
	{
		ClientPrint(null, 3, BLUE+"DirectorOptions on MapScript Scope Exists");
	}
}
else
{	

	if ( (developer() > 0) || (DEBUG == 1))
	{
		ClientPrint(null, 3, BLUE+"Creating DirectorOptions on MapScript Scope");
	}
	::DirectorScript.MapScript.DirectorOptions <-
	{
		//DONT USE IN HERE;
		//Defaults
		//30 en facil para 4 personas, entonces si hay 5 30/4*5, si hay 1 30/4*1,si hay 2 30/4*2
		//Se usa cm_ en el Script Mode DirectorOptions
		MaxSpecials = 2
		DominatorLimit = 2
		SpecialRespawnInterval = 30
		SpecialInitialSpawnDelayMin = 5
		SpecialInitialSpawnDelayMax =10
		SmokerLimit=1
		BoomerLimit=1
		HunterLimit=1
		SpitterLimit=1
		JockeyLimit=1
		ChargerLimit=1
		WitchLimit=1
		SurvivorMaxIncapacitatedCount =6
		CommonLimit=18
		//The horde spawning pacing consists of: 
		//BUILD_UP -> spawn horde -> SUSTAIN_PEAK -> RELAX -> BUILD_UP again.
		//	Setting LockTempo = true removes the 
		//"SUSTAIN_PEAK -> RELAX -> BUILD_UP" bit making your hordes spawn constantly without a delay.
		LockTempo = false
		//All survivors must be below this intensity before a Peak is allowed to switch to Relax (in addition to the normal peak timer)
		IntensityRelaxThreshold = 0.99
		// Modifies the length of the SUSTAIN_PEAK and RELAX states to shorten the time between mob spawns.
		//Continuous peak//持续高峰
		SustainPeakMinTime = 25
		SustainPeakMaxTime  = 30
		//Relaxation stage//放松阶段
		RelaxMinInterval = 2
		RelaxMaxInterval = 4
		RelaxMaxFlowTravel = 50
		
		//BuildUpMinInterval
		// Sets the time between mob spawns. Mobs can only spawn when the pacing is in the BUILD_UP state.
		//The mob refresh time-parameters are modified in real time//尸潮刷新时间 -参数被实时修改
		MobSpawnMinTime = 1
		MobSpawnMaxTime = 3
		// How many zombies are in each mob.
		//The size of the mob-parameters are modified in real time//尸潮大小		-参数被实时修改
		MobMinSize = 30
		MobMaxSize = 45	
		//Reserved number of zombies-parameters are modified in real time//预留僵尸数量 -参数被实时修改
		MobMaxPending  = 10
		
		//Wanderer count (N) is zeroed:
		//When an area becomes visible to any Survivor
		//When the Director is in Relax mode
		//Wanderers	
		WanderingZombieDensityModifier  = 1 //float
		AlwaysAllowWanderers = true//bool
		ClearedWandererRespawnChance = 0//percent int
		NumReservedWanderers=5//infected additional from mobs
		//All survivors must be below this intensity before a Wanderer Peak is allowed to switch to Relax (in addition to the normal peak timer)
		IntensityRelaxAllowWanderersThreshold =  1//float
			
		DisallowThreatType = 8
		ProhibitBosses = false
	}	
}


function Notifications::OnMapFirstStart::MapFirstStart()
{			
	local witchSpawnTime = 60.0;
	// By adding a timer by name, any timer that previously existed with the specified name will be overwritten.
	// The benefit is that you won't need to mess with timer indexes.
	Timers.AddTimerByName("SpawnWitchTimer", witchSpawnTime, true, SpawnWitch );
}

function Notifications::OnSurvivorsLeftStartArea::Inicio()
{			
	SpawnWitch()
}
//function Notifications::OnSurvivorsLeftStartArea::Inicio()
function Notifications::OnPlayerJoined::BalanceDirectorOptions (client, name, ipAddress, steamID, params)
{
		
	if ( (developer() > 0) || (DEBUG == 1))
	{
		ClientPrint(null, 3, BLUE+"OnPlayerJoined "+name);
	}
	if ( (player.IsHuman()) )
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
		
		
		//Default Paceful Mode Stop
		if (Client_Count>1)
			Director.ResetMobTimer()
		
		//You can only assign DirectorOptions with <-
		if (Client_Count>2)
		{
			if ( DirectorScript.MapScript.DirectorOptions.rawin( "DisallowThreatType")  )
				delete DirectorScript.MapScript.DirectorOptions.DisallowThreatType 
		}
		else //2 o 1 jugador
		{
			if (DirectorScript.MapScript.DirectorOptions.rawin( "DisallowThreatType") )
				DirectorScript.DirectorOptions.DisallowThreatType <- 8
			else
				DirectorScript.DirectorOptions.DisallowThreatType <- 8
		}	
		
		//30 en facil para 4 personas, entonces si hay 5 30/4*5, si hay 1 30/4*1,si hay 2 30/4*2
		if ( "MaxSpecials" in DirectorScript.MapScript.DirectorOptions )		
			DirectorScript.MapScript.DirectorOptions.MaxSpecials <-  1+1*Client_Count;
		else
			DirectorScript.MapScript.DirectorOptions.MaxSpecials <- 1+1*Client_Count;
		if ( "DominatorLimit" in DirectorScript.MapScript.DirectorOptions )		
			DirectorScript.MapScript.DirectorOptions.DominatorLimit <-  1+1*Client_Count;
		else
			DirectorScript.MapScript.DirectorOptions.DominatorLimit <- 1+1*Client_Count;
		
		if ( "SmokerLimit" in DirectorScript.MapScript.DirectorOptions )
			DirectorScript.MapScript.DirectorOptions.SmokerLimit <- 2+1*Client_Count/4;
		else
			DirectorScript.MapScript.DirectorOptions.SmokerLimit <- 2+1*Client_Count/4;

		if ( "ChargerLimit" in DirectorScript.MapScript.DirectorOptions )
			DirectorScript.MapScript.DirectorOptions.ChargerLimit <- 2+1*Client_Count/4;
		else
			DirectorScript.MapScript.DirectorOptions.ChargerLimit <- 2+1*Client_Count/4;
		
		if ( "BoomerLimit" in DirectorScript.MapScript.DirectorOptions )
			DirectorScript.MapScript.DirectorOptions.BoomerLimit <- 1+1*Client_Count/4;
		else
			DirectorScript.MapScript.DirectorOptions.BoomerLimit <- 1+1*Client_Count/4;
		
		if ( "HunterLimit" in DirectorScript.MapScript.DirectorOptions )
			DirectorScript.MapScript.DirectorOptions.HunterLimit <- 1+1*Client_Count/4;
		else
			DirectorScript.MapScript.DirectorOptions.HunterLimit <- 1+1*Client_Count/4;

		if ( "SpitterLimit" in DirectorScript.MapScript.DirectorOptions )
			DirectorScript.MapScript.DirectorOptions.SpitterLimit <- 1+1*Client_Count/4;
		else
			DirectorScript.MapScript.DirectorOptions.SpitterLimit <- 1+1*Client_Count/4;

		if ( "JockeyLimit" in DirectorScript.MapScript.DirectorOptions )
			DirectorScript.MapScript.DirectorOptions.JockeyLimit <- 1+1*Client_Count/4;
		else
			DirectorScript.MapScript.DirectorOptions.JockeyLimit <- 1+1*Client_Count/4;

		if ( "WitchLimit" in DirectorScript.MapScript.DirectorOptions )
			DirectorScript.MapScript.DirectorOptions.JockeyLimit <- 1+1*Client_Count/4;
		else
			DirectorScript.MapScript.DirectorOptions.JockeyLimit <- 1+1*Client_Count/4;

		local ranTD = RandomInt(0,1);
		if (ranTD==1)
			worldspawn_timeofday <- ["3"]
		else 
			worldspawn_timeofday <- ["0"]
	}
	
	/*
	if ( "cm_SpecialRespawnInterval" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().cm_SpecialRespawnInterval <- 30;
	if ( "SpecialInitialSpawnDelayMin" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().SpecialInitialSpawnDelayMin <- 5;
	if ( "SpecialInitialSpawnDelayMax" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().SpecialInitialSpawnDelayMax <- 10;
	
	local maxIncap = 6;	
	if ( "SurvivorMaxIncapacitatedCount" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().SurvivorMaxIncapacitatedCount <- maxIncap;
	
	//30 en facil para 4 personas, entonces si hay 5 30/4*5, si hay 1 30/4*1,si hay 2 30/4*2
	if ( "cm_CommonLimit" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().cm_CommonLimit <- DirectorScript.MapScript.GetDirectorOptions().cm_CommonLimit*Client_Count/4;
	//The horde spawning pacing consists of: 
	//BUILD_UP -> spawn horde -> SUSTAIN_PEAK -> RELAX -> BUILD_UP again.
	//	Setting LockTempo = true removes the 
	//"SUSTAIN_PEAK -> RELAX -> BUILD_UP" bit making your hordes spawn constantly without a delay.
	if ( "LockTempo" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().LockTempo <-  0
	//All survivors must be below this intensity before a Peak is allowed to switch to Relax (in addition to the normal peak timer)
	if ( "IntensityRelaxThreshold" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().IntensityRelaxThreshold <-  0.99
	// Modifies the length of the SUSTAIN_PEAK and RELAX states to shorten the time between mob spawns.
	//Continuous peak//持续高峰
	if ( "SustainPeakMinTime" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().SustainPeakMinTime <- 25
	if ( "SustainPeakMaxTime" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().SustainPeakMaxTime  <- 30
	//Relaxation stage//放松阶段
	if ( "RelaxMinInterval" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().RelaxMinInterval <- 2
	if ( "RelaxMaxInterval" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().RelaxMaxInterval <- 4
	if ( "RelaxMaxFlowTravel" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().RelaxMaxFlowTravel <- 50
	
	//BuildUpMinInterval
	// Sets the time between mob spawns. Mobs can only spawn when the pacing is in the BUILD_UP state.
	//The mob refresh time-parameters are modified in real time//尸潮刷新时间 -参数被实时修改
	if ( "MobSpawnMinTime" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().MobSpawnMinTime <- 1
	if ( "MobSpawnMaxTime" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().MobSpawnMaxTime <- 3
	// How many zombies are in each mob.
	//The size of the mob-parameters are modified in real time//尸潮大小		-参数被实时修改
	if ( "MobMinSize" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().MobMinSize <- 30
	if ( "MobMaxSize" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().MobMaxSize <- 45	
	//Reserved number of zombies-parameters are modified in real time//预留僵尸数量 -参数被实时修改
	if ( "MobMaxPending" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().MobMaxPending  <- 10
	
	//Wanderer count (N) is zeroed:
	//When an area becomes visible to any Survivor
	//When the Director is in Relax mode
	//Wanderers	
	if ( "WanderingZombieDensityModifier" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().WanderingZombieDensityModifier  <- DirectorScript.MapScript.GetDirectorOptions().WanderingZombieDensityModifier*Client_Count/4 //float
	else 
		DirectorScript.MapScript.GetDirectorOptions().WanderingZombieDensityModifier<-  1*Client_Count/4
	if ( "AlwaysAllowWanderers" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().AlwaysAllowWanderers <- true//bool
	if ( "ClearedWandererRespawnChance" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().ClearedWandererRespawnChance <- 33//percent int
	if ( "NumReservedWanderers" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().NumReservedWanderers<-  DirectorScript.MapScript.GetDirectorOptions().NumReservedWanderers*Client_Count/4//infected additional from mobs
	else 
		DirectorScript.MapScript.GetDirectorOptions().NumReservedWanderers<-  1*Client_Count/4
	//All survivors must be below this intensity before a Wanderer is allowed to switch to Relax (in addition to the normal peak timer)
	if ( "IntensityRelaxAllowWanderersThreshold" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().IntensityRelaxAllowWanderersThreshold <-  1
	
	
	local Difficulty = Convars.GetStr( "z_difficulty" ).tolower();
		
		*/
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

function Notifications::OnNextMap::NextMap(nextmap)
{			
	Timers.RemoveTimerByName ( "SpawnWitchTimer" );
}

	
	
::SpawnWitch <- function ( args )
{
	local player = Players.SurvivorWithHighestFlow();
	local MaxDist = RandomInt( 800, 1200 );
	local MinDist = RandomInt( 400, 800 );
	
	local ranTD = RandomInt(0,1);
	if ( ranTD ==0 )
		Utils.SpawnZombieNearPlayer( player, Z_WITCH_BRIDE, MaxDist, MinDist, false );
	else
		Utils.SpawnZombieNearPlayer( player, Z_WITCH, MaxDist, MinDist, false );
}