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
		//delete	DirectorScript.MapScript.ChallengeScript.DirectorOptions.PreferredMobDirection;
		//delete	DirectorScript.MapScript.ChallengeScript.DirectorOptions.cm_AggressiveSpecials;
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
		AggressiveSpecials = 0
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
		//Panic Waves... and how much Panic they cause, and when the Director decides they are done
		//MegaMobSize (and CommonLimit) A Panic lasts until MegaMobSize commons spawn, and no more 
		//than CommonLimit will ever be out at once. So MegaMobSize 50 CommonLimit 2 is a long slow 
		//gentle PANIC, and MegaMobSize 80 CommonLimit 80 is over instantly, with a lot of zombies around. 
		//MegaMobSize/CommonLimit 1000 is a good way to crash the game.
		//PreferredMobDirection = SPAWN_NO_PREFERENCE
		//Valid flags are: SPAWN_ABOVE_SURVIVORS, SPAWN_ANYWHERE, SPAWN_BEHIND_SURVIVORS( for SpawnBehindSurvivorsDistance int)
		//SPAWN_FAR_AWAY_FROM_SURVIVORS, SPAWN_IN_FRONT_OF_SURVIVORS, SPAWN_LARGE_VOLUME,
		//SPAWN_NEAR_IT_VICTIM, SPAWN_NO_PREFERENCE
		//Note.png Note: 	SPAWN_NEAR_IT_VICTIM does not exist before a 
		//finale and will cause an error, so I'm assuming the director picks 
		//someone as IT when the finale starts. SPAWN_LARGE_VOLUME is what makes you be a mile away on DC finale.
		//0=Anywhere, 1=Behind, 2=IT, 3=Specials in front, 4=Specials anywhere, 5=Far Away, 6=Above
		//PreferredSpecialDirection and SPAWN_SPECIALS_ANYWHERE, SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS
		//SPAWN SET RULE
		// What general rule does the director use for spawning. Choices are
		// SPAWN_FINALE spawn in finale nav areas only
		// SPAWN_BATTLEFIELD spawn in battlefield nav areas only
		// SPAWN_SURVIVORS use the areas near/explored by the survivors (@TODO: is this actually right?)
		// SPAWN_POSITIONAL use the SpawnSetPosition/Radius to pick the spawn area
		// SpawnSetRadius/SpawnSetPosition: A radius in units, a Vector(x,y,z) center point for POSITIONAL spawning
		//The horde spawning pacing consists of: 
		//BUILD_UP -> spawn horde -> SUSTAIN_PEAK -> RELAX -> BUILD_UP again.
		// How many zombies are in each mob.		
		//The size of the mob-parameters are modified in real time//尸潮大小		-参数被实时修改
		MobMinSize = 25
		MobMaxSize = 35	
		//Reserved number of zombies-parameters are modified in real time//预留僵尸数量 -参数被实时修改
		MobMaxPending  = 10
		//BuildUpMinInterval
		// Sets the time between mob spawns. Mobs can only spawn when the pacing is in the BUILD_UP state.
		//The mob refresh time-parameters are modified in real time//尸潮刷新时间 -参数被实时修改
		MobSpawnMinTime = 20
		MobSpawnMaxTime = 36		
		//	Setting LockTempo = true removes the 
		//"SUSTAIN_PEAK -> RELAX -> BUILD_UP" bit making your hordes spawn constantly without a delay.
		LockTempo = false
		// Modifies the length of the SUSTAIN_PEAK and RELAX states to shorten the time between mob spawns.
		//Continuous peak//持续高峰
		SustainPeakMinTime = 35
		SustainPeakMaxTime  = 75
		//All survivors must be below this intensity before a Peak is allowed to switch to Relax (in addition to the normal peak timer)
		IntensityRelaxThreshold = 0.81
		//Relaxation stage//放松阶段
		RelaxMinInterval = 30
		RelaxMaxInterval = 60
		RelaxMaxFlowTravel = 700	
		
		//Specials and Panic Events
		//Number of commons that spawn when a bile bomb is thrown or a survivor is hit by vomit
		BileMobSize= 20
		//The amount of total infected spawned during a panic event
		MegaMobSize=50
		//Wanderer count (N) is zeroed:
		//When an area becomes visible to any Survivor
		//When the Director is in Relax mode
		//Wanderers	
		WanderingZombieDensityModifier  = 1 //Set to 0 to have no wandering zombies float
		AlwaysAllowWanderers = true//bool
		ClearedWandererRespawnChance = 15//percent int
		NumReservedWanderers=15//infected additional from mobs
		//All survivors must be below this intensity before a Wanderer Peak is allowed to switch to Relax (in addition to the normal peak timer)
		IntensityRelaxAllowWanderersThreshold =  1//float
			
		DisallowThreatType = 8
		ProhibitBosses = false
	}	
}


::SpawnTank <- function ( vPos=null )
{
	//local vPos = player.GetLocation();
	if (vPos==null)
	{	
		Msg("Spawning Tank!\n");
		local MaxDist = RandomInt( 800, 1200 );
		local MinDist = RandomInt( 400, 800 );	
		//local player = ::VSLib.Player(client);
		local player = Players.SurvivorWithHighestFlow();
		Utils.SpawnZombieNearPlayer( player, Z_TANK, MaxDist, MinDist, false );
	}	
	else
	{
		Msg("Spawning Tank in Position "+vPos+"!\n");
		//SpawnZombie(zombieType, pos = null, ang = QAngle(0,0,0), offerTank = false, victim = null)
		Utils.SpawnZombie(Z_TANK, vPos);
	}
}

::SpawnWitch <- function ()
{
	::VSLib.Utils.HowAngry();	
	local player = Players.SurvivorWithHighestFlow();
	local MaxDist = RandomInt( 800, 1200 );
	local MinDist = RandomInt( 400, 800 );
	
	local ranTD = RandomInt(0,1);
	if ( ranTD ==0 )
		Utils.SpawnZombieNearPlayer( player, Z_WITCH_BRIDE, MaxDist, MinDist, false );
	else
		Utils.SpawnZombieNearPlayer( player, Z_WITCH, MaxDist, MinDist, false );
}

::BalanceDirectorOptions <- function ()
{
	
	CalculateNumberofPlayers()
	
	if (nowFirstPlayerinGame==0)
		Director.ResetMobTimer()	
	
	//You can only assign DirectorOptions with <-
	if (nowPlayersinGame>2)
	{
		DirectorScript.DirectorOptions.AggressiveSpecials <- 1
		if ( DirectorScript.MapScript.DirectorOptions.rawin( "DisallowThreatType")  )
			delete DirectorScript.MapScript.DirectorOptions.DisallowThreatType 
	}
	else //2 o 1 jugador
	{
		DirectorScript.DirectorOptions.AggressiveSpecials <- 0
		//if (DirectorScript.MapScript.DirectorOptions.rawin( "DisallowThreatType") )
			DirectorScript.DirectorOptions.DisallowThreatType <- 8
		//else
		//	DirectorScript.DirectorOptions.DisallowThreatType <- 8
		//Default Paceful Mode Stop
		if (nowFirstPlayerinGame==0)
			nowFirstPlayerinGame++;			
	}	
	
	//30 en facil para 4 personas, entonces si hay 5 30/4*5, si hay 1 30/4*1,si hay 2 30/4*2
	//if ( "MaxSpecials" in DirectorScript.MapScript.DirectorOptions )		
	if (nowPlayersinGame>12)
	{
		DirectorScript.MapScript.DirectorOptions.SpecialRespawnInterval <- RandomInt(60,80)
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMin <- 60-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMax <- 80-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 30+4*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.MaxSpecials <-  2+1*nowPlayersinGame*3/2
		DirectorScript.MapScript.DirectorOptions.DominatorLimit <-  2+1*nowPlayersinGame*3/2
		DirectorScript.MapScript.DirectorOptions.ChargerLimit <- 2
		DirectorScript.MapScript.DirectorOptions.BoomerLimit <- 3
		DirectorScript.MapScript.DirectorOptions.HunterLimit <- 2
		DirectorScript.MapScript.DirectorOptions.JockeyLimit <- 3
		DirectorScript.MapScript.DirectorOptions.SmokerLimit <- 2
		DirectorScript.MapScript.DirectorOptions.SpitterLimit <- 2
		DirectorScript.MapScript.DirectorOptions.WitchLimit <- 1
	}
	else
	if (nowPlayersinGame>8)
	{
		DirectorScript.MapScript.DirectorOptions.SpecialRespawnInterval <- RandomInt(70,90)
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMin <- 70-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMax <- 90-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 10+3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.MaxSpecials <-  2+1*nowPlayersinGame*3/2
		DirectorScript.MapScript.DirectorOptions.DominatorLimit <-  2+1*nowPlayersinGame*3/2
		DirectorScript.MapScript.DirectorOptions.ChargerLimit <- 3
		DirectorScript.MapScript.DirectorOptions.BoomerLimit <- 2
		DirectorScript.MapScript.DirectorOptions.HunterLimit <- 2
		DirectorScript.MapScript.DirectorOptions.JockeyLimit <- 3
		DirectorScript.MapScript.DirectorOptions.SmokerLimit <- 3
		DirectorScript.MapScript.DirectorOptions.SpitterLimit <- 1
		DirectorScript.MapScript.DirectorOptions.WitchLimit <- 1
	}
	else
	if (nowPlayersinGame>4)
	{
		DirectorScript.MapScript.DirectorOptions.SpecialRespawnInterval <- RandomInt(50,70)
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMin <- 50-2*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMax <- 70-2*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 10+3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.MaxSpecials <-  2+1*nowPlayersinGame*4/8
		DirectorScript.MapScript.DirectorOptions.DominatorLimit <-  2+1*nowPlayersinGame*4/8
		DirectorScript.MapScript.DirectorOptions.ChargerLimit <- 2
		DirectorScript.MapScript.DirectorOptions.BoomerLimit <- 2
		DirectorScript.MapScript.DirectorOptions.HunterLimit <- 2
		DirectorScript.MapScript.DirectorOptions.JockeyLimit <- 2
		DirectorScript.MapScript.DirectorOptions.SmokerLimit <- 3
		DirectorScript.MapScript.DirectorOptions.SpitterLimit <- 1
		DirectorScript.MapScript.DirectorOptions.WitchLimit <- 1
	}
		else
	{
		DirectorScript.MapScript.DirectorOptions.SpecialRespawnInterval <- RandomInt(25,35)
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMin <- 25
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMax <- 35
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 17+1*nowPlayersinGame*10/2
		DirectorScript.MapScript.DirectorOptions.MaxSpecials <-  1+1*nowPlayersinGame/2
		DirectorScript.MapScript.DirectorOptions.DominatorLimit <-  1+1*nowPlayersinGame/2
		DirectorScript.MapScript.DirectorOptions.ChargerLimit <- 2
		DirectorScript.MapScript.DirectorOptions.BoomerLimit <- 2
		DirectorScript.MapScript.DirectorOptions.HunterLimit <- 1
		DirectorScript.MapScript.DirectorOptions.JockeyLimit <- 1
		DirectorScript.MapScript.DirectorOptions.SmokerLimit <- 2
		DirectorScript.MapScript.DirectorOptions.SpitterLimit <- 1	
		DirectorScript.MapScript.DirectorOptions.WitchLimit <- 1
	}
			
	//else
	//	DirectorScript.MapScript.DirectorOptions.MaxSpecials <- 1+1*nowPlayersinGame;
	//if ( "DominatorLimit" in DirectorScript.MapScript.DirectorOptions )		
			
	//else
	//	DirectorScript.MapScript.DirectorOptions.DominatorLimit <- 1+1*nowPlayersinGame;
	
	//if ( "ChargerLimit" in DirectorScript.MapScript.DirectorOptions )
	//else
	//	DirectorScript.MapScript.DirectorOptions.ChargerLimit <- 2+1*nowPlayersinGame/4;
	//if ( "BoomerLimit" in DirectorScript.MapScript.DirectorOptions )
	//else
	//	DirectorScript.MapScript.DirectorOptions.BoomerLimit <- 1+1*nowPlayersinGame/4;
	
	//if ( "HunterLimit" in DirectorScript.MapScript.DirectorOptions )
	//else
	//	DirectorScript.MapScript.DirectorOptions.HunterLimit <- 1+1*nowPlayersinGame/4;

	//if ( "JockeyLimit" in DirectorScript.MapScript.DirectorOptions )
	//else
	//	DirectorScript.MapScript.DirectorOptions.JockeyLimit <- 1+1*nowPlayersinGame/4

	//if ( "SmokerLimit" in DirectorScript.MapScript.DirectorOptions )
	//else
	//	DirectorScript.MapScript.DirectorOptions.SmokerLimit <- 2+1*nowPlayersinGame/4;

	
	//if ( "SpitterLimit" in DirectorScript.MapScript.DirectorOptions )
	//else
	//	DirectorScript.MapScript.DirectorOptions.SpitterLimit <- 1+1*nowPlayersinGame/4


	//if ( "WitchLimit" in DirectorScript.MapScript.DirectorOptions )
	//else
	//	DirectorScript.MapScript.DirectorOptions.WitchLimit <- 1+1*nowPlayersinGame/4

	//if ( "CommonLimit" in DirectorScript.MapScript.DirectorOptions )
				
	//else
	//	DirectorScript.MapScript.DirectorOptions.CommonLimit <- 18+3*nowPlayersinGame
	
	local ranTD = RandomInt(0,1);
	if (ranTD==1)
		worldspawn_timeofday <- ["3"]
	else 
		worldspawn_timeofday <- ["0"]
	
	
	//if ( "SpecialRespawnInterval" in DirectorScript.MapScript.DirectorOptions )
	//else
	//	DirectorScript.MapScript.DirectorOptions.SpecialRespawnInterval <- 30-1*nowPlayersinGame
	
	
	//if ( "SpecialInitialSpawnDelayMin" in DirectorScript.MapScript.DirectorOptions )
	//else
	//	DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMin <- 5-1*nowPlayersinGame/4
	
	
	//if ( "SpecialInitialSpawnDelayMax" in DirectorScript.MapScript.DirectorOptions )
	//else
	//	DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMax <- 10-1*nowPlayersinGame/4
	
	
	//if ( "IntensityRelaxThreshold" in DirectorScript.MapScript.DirectorOptions )
	//{
	if (nowPlayersinGame>4)
	{				
		DirectorScript.MapScript.DirectorOptions.IntensityRelaxThreshold <- 0.90-0.015*nowPlayersinGame
	}				
	else
	{
		DirectorScript.MapScript.DirectorOptions.IntensityRelaxThreshold <- 0.81+0.03*nowPlayersinGame
	}				
	//}		
	
	//if ( "NumReservedWanderers" in DirectorScript.MapScript.DirectorOptions )
		DirectorScript.MapScript.DirectorOptions.NumReservedWanderers <- 15+3*nowPlayersinGame;
	
	//if ( "IntensityRelaxAllowWanderersThreshold" in DirectorScript.MapScript.DirectorOptions )
	//{
	if (nowPlayersinGame>4)
	{				
		DirectorScript.MapScript.DirectorOptions.IntensityRelaxAllowWanderersThreshold <- 0.90-0.015*nowPlayersinGame
	}				
	else
	{
		DirectorScript.MapScript.DirectorOptions.IntensityRelaxAllowWanderersThreshold <- 0.81+0.03*nowPlayersinGame
	}				
	//}	
	//else
	//{
		// if (nowPlayersinGame>4)
		// {				
			// DirectorScript.MapScript.DirectorOptions.IntensityRelaxAllowWanderersThreshold <- 0.90-0.015*nowPlayersinGame;
		// }				
		// else
		// {
			// DirectorScript.MapScript.DirectorOptions.IntensityRelaxAllowWanderersThreshold <- 0.81+0.03*nowPlayersinGame;
		// }				
	// }	
	//if ( "NumReservedWanderers" in DirectorScript.MapScript.DirectorOptions )
	DirectorScript.MapScript.DirectorOptions.NumReservedWanderers <- 15+3*nowPlayersinGame
	
	//DONT USE IN HERE;
	//Defaults
	//30 en facil para 4 personas, entonces si hay 5 30/4*5, si hay 1 30/4*1,si hay 2 30/4*2
	//Se usa cm_ en el Script Mode DirectorOptions	
	
	//ScriptedStageType = STAGE_NONE The type of stage to run next 
	//STAGE_SETUP
	//VALUE: # of seconds to spend in SETUP, or 0 for infinite.
	//EXIT: When the seconds run out, or when you ForceNextStage.
	//STAGE_PANIC
	//VALUE: How many Panic waves to spawn.
	//STAGE_DELAY
	// VALUE: # of seconds to wait, or -1 for infinite.
	// EXIT: When the timeout occurs, or ForceNextStage of course (esp. to get out of infinite delay)
	// NOTE: the Options table is still live during this (@TODO: CHECK THIS! is it all options, or only some). I.e. if you do a Delay but leave BoomerLimit and MaxSpecials high - boomers might spawn.
	// STAGE_CLEAROUT
	// This is a special mode that is basically "wait for Panic to Clear out".
	//If you have a mode where you do a panic wave, but you dont want to move on until that wave is killed off by the players, you can do a Clearout. Clearout waits until all mobs or gone (well, or if the mob count is low and stable for a # of seconds... so if some common is stuck out behind a fence somewhere things dont grind to a halt)
	// VALUE: How long the count has to remain stable before CLEAROUT gives up and allows things to continue.
	// EXIT: When the mob count hits zero, or it plateau's for VALUE seconds.
	// NOTE: in practice, there are some other rules - no Witches or Tanks can be up, and even if the count is stable if it is above 10 it still wont go on, and so on. NOTE: There is also a "Script_Clearout" which is a fancier version of this implemented totally in script. You can look at scripted_holdout to see it get called, and the actual code is in sm_utilities.nut. It works by putting the director into a STAGE_DELAY that is infinite, then using a SlowPoll function to monitor the counts of various types, and decide when to ForceNextStage out of the delay.
	// STAGE_ESCAPE
	// Run an escape - endless waves, tank, etc, etc
	// VALUE: ignored, i believe
	// EXIT: When you escape?
	// STAGE_TANK
	// Run a stage with a tank in it.
	// VALUE: ignored, i believe
	if ( "ScriptedStageType" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
		DirectorScript.MapScript.ChallengeScript.DirectorOptions.ScriptedStageType <- STAGE_NONE
	//ScriptedStageValue = 1000 Dependant on the stage type.
	if ( "ScriptedStageValue" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
		DirectorScript.MapScript.ChallengeScript.DirectorOptions.ScriptedStageValue <- 	1000	
	//MODE OPTIONS
	// What general rule does the director use for spawning. Choices are
	// SPAWN_FINALE spawn in finale nav areas only
	// SPAWN_BATTLEFIELD spawn in battlefield nav areas only
	// SPAWN_SURVIVORS use the areas near/explored by the survivors (@TODO: is this actually right?)
	// SPAWN_POSITIONAL use the SpawnSetPosition/Radius to pick the spawn area
	//SpawnSetRule = SPAWN_SURVIVORS
	//if ( "SpawnSetRule" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
	//Valid flags are: SPAWN_ABOVE_SURVIVORS, SPAWN_ANYWHERE, SPAWN_BEHIND_SURVIVORS( for SpawnBehindSurvivorsDistance int)
	//SPAWN_FAR_AWAY_FROM_SURVIVORS, SPAWN_IN_FRONT_OF_SURVIVORS, SPAWN_LARGE_VOLUME,
	//SPAWN_NEAR_IT_VICTIM, SPAWN_NO_PREFERENCE
	
		//PreferredMobDirection = SPAWN_NO_PREFERENCE
		//Valid flags are: SPAWN_ABOVE_SURVIVORS, SPAWN_ANYWHERE, SPAWN_BEHIND_SURVIVORS( for SpawnBehindSurvivorsDistance int)
		//SPAWN_FAR_AWAY_FROM_SURVIVORS, SPAWN_IN_FRONT_OF_SURVIVORS, SPAWN_LARGE_VOLUME,
		//SPAWN_NEAR_IT_VICTIM, SPAWN_NO_PREFERENCE
		//Note.png Note: 	SPAWN_NEAR_IT_VICTIM does not exist before a 
		//finale and will cause an error, so I'm assuming the director picks 
		//someone as IT when the finale starts. SPAWN_LARGE_VOLUME is what makes you be a mile away on DC finale.
		//0=Anywhere, 1=Behind, 2=IT, 3=Specials in front, 4=Specials anywhere, 5=Far Away, 6=Above
		//PreferredSpecialDirection and SPAWN_SPECIALS_ANYWHERE, SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS
	local randDirection
	if (nowPlayersinGame>5)
	{
		DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnSetRule <- SPAWN_SURVIVORS
		randDirection=RandomInt(0,2)
		if (randDirection==0)
			DirectorScript.MapScript.DirectorOptions.PreferredMobDirection <- 	SPAWN_BEHIND_SURVIVORS	
		else 
			if (randDirection==1)
				DirectorScript.MapScript.DirectorOptions.PreferredMobDirection <- 	SPAWN_IN_FRONT_OF_SURVIVORS	
			else
				DirectorScript.MapScript.DirectorOptions.PreferredMobDirection <- 	SPAWN_LARGE_VOLUME	
		randDirection=RandomInt(0,1)
		if (randDirection==0)
			DirectorScript.MapScript.DirectorOptions.PreferredSpecialDirection <- 	SPAWN_SPECIALS_ANYWHERE	
		else 
			if (randDirection==1)
				DirectorScript.MapScript.DirectorOptions.PreferredSpecialDirection <- 	SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS	
	}
	else
	if (nowPlayersinGame>2)
	{
		DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnSetRule <- SPAWN_SURVIVORS
		//if ( "PreferredMobDirection" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
		DirectorScript.MapScript.DirectorOptions.PreferredMobDirection <- 	SPAWN_IN_FRONT_OF_SURVIVORS	
		DirectorScript.MapScript.DirectorOptions.PreferredSpecialDirection	<- 	SPAWN_IN_FRONT_OF_SURVIVORS
	}
	else
	{
		DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnSetRule <- SPAWN_BATTLEFIELD
		//if ( "PreferredMobDirection" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
			DirectorScript.MapScript.DirectorOptions.PreferredMobDirection <- 	SPAWN_NO_PREFERENCE	
			DirectorScript.MapScript.DirectorOptions.PreferredSpecialDirection <- 	SPAWN_NO_PREFERENCE		
	}
		
	//SpawnDirectionCount = 0
	if ( "SpawnDirectionCount" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
		DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnDirectionCount <- 0
	//a bitfield (using SPAWNDIR_N, _NE, _E, etc) of directors to spawn from _relative to_ a map
	//SpawnDirectionMask = 0
	if ( "SpawnDirectionMask" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
		DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnDirectionMask <- 0
	if (nowPlayersinGame>2)
	{
		//if ( "cm_AggressiveSpecials" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
			DirectorScript.MapScript.ChallengeScript.DirectorOptions.cm_AggressiveSpecials <- 	1	
	}
	else
	{
		//if ( "cm_AggressiveSpecials" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
			DirectorScript.MapScript.ChallengeScript.DirectorOptions.cm_AggressiveSpecials <-  0	
	}
	IncludeScript ("debug_directoroptions.nut");	
	
	/*
	
	
	//Increase common limit based on progress  
	    local progressPct = ( Director.GetFurthestSurvivorFlow() / BridgeSpan )
	    
	    if ( progressPct < 0.0 ) progressPct = 0.0;
	    if ( progressPct > 1.0 ) progressPct = 1.0;
	    
	    MobSpawnSize = MobSpawnSizeMin + progressPct * ( MobSpawnSizeMax - MobSpawnSizeMin )


	//Increase common limit based on speed   
	    local speedPct = ( Director.GetAveragedSurvivorSpeed() - minSpeed ) / ( maxSpeed - minSpeed );

	    if ( speedPct < 0.0 ) speedPct = 0.0;
	    if ( speedPct > 1.0 ) speedPct = 1.0;

	    MobSpawnSize = MobSpawnSize + speedPct * ( speedPenaltyZAdds );
	    
	    CommonLimit = MobSpawnSize * 1.5
	    
	    if ( CommonLimit > CommonLimitMax ) CommonLimit = CommonLimitMax;
	    

	
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
		DirectorScript.MapScript.GetDirectorOptions().cm_CommonLimit <- DirectorScript.MapScript.GetDirectorOptions().cm_CommonLimit*nowPlayersinGame/4;
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
		DirectorScript.MapScript.GetDirectorOptions().WanderingZombieDensityModifier  <- DirectorScript.MapScript.GetDirectorOptions().WanderingZombieDensityModifier*nowPlayersinGame/4 //float
	else 
		DirectorScript.MapScript.GetDirectorOptions().WanderingZombieDensityModifier<-  1*nowPlayersinGame/4
	if ( "AlwaysAllowWanderers" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().AlwaysAllowWanderers <- true//bool
	if ( "ClearedWandererRespawnChance" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().ClearedWandererRespawnChance <- 33//percent int
	if ( "NumReservedWanderers" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().NumReservedWanderers<-  DirectorScript.MapScript.GetDirectorOptions().NumReservedWanderers*nowPlayersinGame/4//infected additional from mobs
	else 
		DirectorScript.MapScript.GetDirectorOptions().NumReservedWanderers<-  1*nowPlayersinGame/4
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

::CalculateNumberofPlayers <- function ()
{
	//if ( (developer() > 0) || (DEBUG == 1))
	nowPlayersinGame = 0;
	foreach( survivor in ::VSLib.EasyLogic.Players.Survivors() )
	{
		if ((developer() > 0) || (DEBUG == 1))
		{
			if(survivor.IsBot())
				ClientPrint(null, 3, BLUE+"Contando Bot");
			else				
				ClientPrint(null, 3, BLUE+"Contando Humano");
			nowPlayersinGame++;	
			continue;	
		}
		else
		{
			if(survivor.IsBot())
				continue;	
			nowPlayersinGame++;	
		}
	}	
	if (nowPlayerEvent=="Left")
		nowPlayersinGame=nowPlayersinGame-1
}
::BalanceFinaleDirectorOptions <- function ()
{
	CalculateNumberofPlayers()
	
	if (nowFirstPlayerinGame==0)
		Director.ResetMobTimer()	
	
	if (nowPlayersinGame>12)
	{
		local finalelimit=3
		local finalelimitscale=2
		DirectorScript.MapScript.DirectorOptions.SpecialRespawnInterval <- RandomInt(60,80)
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMin <- 60-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMax <- 80-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 30+4*nowPlayersinGame*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.MaxSpecials <-  2+1*nowPlayersinGame*3/2*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.DominatorLimit <-  2+1*nowPlayersinGame*3/2*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.ChargerLimit <- 2
		DirectorScript.MapScript.DirectorOptions.BoomerLimit <- 3
		DirectorScript.MapScript.DirectorOptions.HunterLimit <- 2
		DirectorScript.MapScript.DirectorOptions.JockeyLimit <- 3
		DirectorScript.MapScript.DirectorOptions.SmokerLimit <- 2
		DirectorScript.MapScript.DirectorOptions.SpitterLimit <- 2
		DirectorScript.MapScript.DirectorOptions.WitchLimit <- 1
	}
	else
	if (nowPlayersinGame>8)
	{
		local finalelimit=4
		local finalelimitscale=4
		DirectorScript.MapScript.DirectorOptions.SpecialRespawnInterval <- RandomInt(70,90)
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMin <- 70-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMax <- 90-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 10+3*nowPlayersinGame*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.MaxSpecials <-  2+1*nowPlayersinGame*3/2*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.DominatorLimit <-  2+1*nowPlayersinGame*3/2*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.ChargerLimit <- 3
		DirectorScript.MapScript.DirectorOptions.BoomerLimit <- 2
		DirectorScript.MapScript.DirectorOptions.HunterLimit <- 2
		DirectorScript.MapScript.DirectorOptions.JockeyLimit <- 3
		DirectorScript.MapScript.DirectorOptions.SmokerLimit <- 3
		DirectorScript.MapScript.DirectorOptions.SpitterLimit <- 1
		DirectorScript.MapScript.DirectorOptions.WitchLimit <- 1
	}
	else
	if (nowPlayersinGame>4)
	{
		local finalelimit=7
		local finalelimitscale=8
		DirectorScript.MapScript.DirectorOptions.SpecialRespawnInterval <- RandomInt(50,70)
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMin <- 50-2*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMax <- 70-2*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 10+3*nowPlayersinGame*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.MaxSpecials <-  2+1*nowPlayersinGame*4/8*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.DominatorLimit <-  2+1*nowPlayersinGame*4/8*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.ChargerLimit <- 2
		DirectorScript.MapScript.DirectorOptions.BoomerLimit <- 2
		DirectorScript.MapScript.DirectorOptions.HunterLimit <- 2
		DirectorScript.MapScript.DirectorOptions.JockeyLimit <- 2
		DirectorScript.MapScript.DirectorOptions.SmokerLimit <- 3
		DirectorScript.MapScript.DirectorOptions.SpitterLimit <- 1
		DirectorScript.MapScript.DirectorOptions.WitchLimit <- 1
	}
		else
	{
		local finalelimit=4
		local finalelimitscale=2
		DirectorScript.MapScript.DirectorOptions.SpecialRespawnInterval <- RandomInt(25,35)
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMin <- 25
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMax <- 35
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 17+1*nowPlayersinGame*10/2*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.MaxSpecials <-  1+1*nowPlayersinGame*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.DominatorLimit <-  1+1*nowPlayersinGame*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.ChargerLimit <- 2
		DirectorScript.MapScript.DirectorOptions.BoomerLimit <- 2
		DirectorScript.MapScript.DirectorOptions.HunterLimit <- 1
		DirectorScript.MapScript.DirectorOptions.JockeyLimit <- 1
		DirectorScript.MapScript.DirectorOptions.SmokerLimit <- 2
		DirectorScript.MapScript.DirectorOptions.SpitterLimit <- 1	
		DirectorScript.MapScript.DirectorOptions.WitchLimit <- 1
	}
	
	local ranTD = RandomInt(0,1);
	if (ranTD==1)
		worldspawn_timeofday <- ["3"]
	else 
		worldspawn_timeofday <- ["0"]
		
	//Finales Options
	if (nowPlayersinGame>4)
	{				
		DirectorScript.MapScript.DirectorOptions.IntensityRelaxThreshold <- 0.97-0.015*nowPlayersinGame;
	}				
	else
	{
		DirectorScript.MapScript.DirectorOptions.IntensityRelaxThreshold <- 0.81+0.03*nowPlayersinGame;
	}			
	if (nowPlayersinGame>2)
	{				
		DirectorScript.MapScript.DirectorOptions.PausePanicWhenRelaxing <- false;
	}				
	else
	{
		DirectorScript.MapScript.DirectorOptions.PausePanicWhenRelaxing <- true;
	}			
	//The amount of total infected spawned during a panic event
	DirectorScript.MapScript.DirectorOptions.MegaMobSize<- 25+3*nowPlayersinGame
	//The Panic should end when we finish with Specials, not wait for the MegaMob.
	if (nowPlayersinGame>2)
	{				
		DirectorScript.MapScript.DirectorOptions.PanicSpecialsOnly <- false;
	}				
	else
	{
		DirectorScript.MapScript.DirectorOptions.PanicSpecialsOnly <- true;
	}	
	DirectorScript.MapScript.DirectorOptions.PanicWavePauseMax<- 60-1*nowPlayersinGame
	DirectorScript.MapScript.DirectorOptions.PanicWavePauseMin<- 60-1*nowPlayersinGame
	//The minimum amount of time a SCRIPTED stage is allowed to run before ending.
	DirectorScript.MapScript.DirectorOptions.MinimumStageTime <- 30+1*nowPlayersinGame
	DirectorScript.MapScript.DirectorOptions.EscapeSpawnTanks <- true
	//if ( "HordeEscapeCommonLimit" in DirectorScript.MapScript.DirectorOptions )
		DirectorScript.MapScript.DirectorOptions.HordeEscapeCommonLimit <- 15+3*nowPlayersinGame
	//else
	//	DirectorScript.MapScript.DirectorOptions.HordeEscapeCommonLimit <- 15+3*nowPlayersinGame
	
	//Other Finale
	if (nowPlayersinGame>2)
	{				
		DirectorScript.MapScript.DirectorOptions.ShouldConstrainLargeVolumeSpawn	<- 	false
		DirectorScript.MapScript.DirectorOptions.ShouldAllowSpecialsWithTank <- true
		DirectorScript.MapScript.DirectorOptions.AggressiveSpecials <- 1
	}				
	else
	{
		
		DirectorScript.MapScript.DirectorOptions.ShouldConstrainLargeVolumeSpawn	<- 	true
		DirectorScript.MapScript.DirectorOptions.ShouldAllowSpecialsWithTank <- false
		DirectorScript.MapScript.DirectorOptions.AggressiveSpecials <- 0
	}	
	DirectorScript.MapScript.DirectorOptions.MobMinSize					 <-	15+2*nowPlayersinGame
	DirectorScript.MapScript.DirectorOptions.MobMaxSize					 <-	35+2*nowPlayersinGame
	DirectorScript.MapScript.DirectorOptions.MobRechargeRate				 <-	25-1*nowPlayersinGame
	//ZombieSpawnRange			 <-	3000
	DirectorScript.MapScript.DirectorOptions.SpecialRespawnInterval		 <-	30-1*nowPlayersinGame
	DirectorScript.MapScript.DirectorOptions.BileMobSize					 <-	15+3*nowPlayersinGame
	DirectorScript.MapScript.DirectorOptions.ProhibitBosses				 <-	false
	DirectorScript.MapScript.DirectorOptions.MusicDynamicMobSpawnSize	 <-	8
	DirectorScript.MapScript.DirectorOptions.MusicDynamicMobStopSize		 <-	2
	DirectorScript.MapScript.DirectorOptions.MusicDynamicMobScanStopSize	 <-	1
	DirectorScript.MapScript.DirectorOptions.TankLimit					 <-	1+1*nowPlayersinGame/4
	DirectorScript.MapScript.DirectorOptions.WitchLimit					 <-	1	
	DirectorScript.MapScript.DirectorOptions.MaxSpecials  <- 1+1*nowPlayersinGame
				
				
	//DONT USE IN HERE;
	//Defaults
	//30 en facil para 4 personas, entonces si hay 5 30/4*5, si hay 1 30/4*1,si hay 2 30/4*2
	//Se usa cm_ en el Script Mode DirectorOptions	
	
	//DONT USE IN HERE;
	//Defaults
	//30 en facil para 4 personas, entonces si hay 5 30/4*5, si hay 1 30/4*1,si hay 2 30/4*2
	//Se usa cm_ en el Script Mode DirectorOptions	
	
	//ScriptedStageType = STAGE_NONE The type of stage to run next 
	//STAGE_SETUP
	//VALUE: # of seconds to spend in SETUP, or 0 for infinite.
	//EXIT: When the seconds run out, or when you ForceNextStage.
	//STAGE_PANIC
	//VALUE: How many Panic waves to spawn.
	//STAGE_DELAY
	// VALUE: # of seconds to wait, or -1 for infinite.
	// EXIT: When the timeout occurs, or ForceNextStage of course (esp. to get out of infinite delay)
	// NOTE: the Options table is still live during this (@TODO: CHECK THIS! is it all options, or only some). I.e. if you do a Delay but leave BoomerLimit and MaxSpecials high - boomers might spawn.
	// STAGE_CLEAROUT
	// This is a special mode that is basically "wait for Panic to Clear out".
	//If you have a mode where you do a panic wave, but you dont want to move on until that wave is killed off by the players, you can do a Clearout. Clearout waits until all mobs or gone (well, or if the mob count is low and stable for a # of seconds... so if some common is stuck out behind a fence somewhere things dont grind to a halt)
	// VALUE: How long the count has to remain stable before CLEAROUT gives up and allows things to continue.
	// EXIT: When the mob count hits zero, or it plateau's for VALUE seconds.
	// NOTE: in practice, there are some other rules - no Witches or Tanks can be up, and even if the count is stable if it is above 10 it still wont go on, and so on. NOTE: There is also a "Script_Clearout" which is a fancier version of this implemented totally in script. You can look at scripted_holdout to see it get called, and the actual code is in sm_utilities.nut. It works by putting the director into a STAGE_DELAY that is infinite, then using a SlowPoll function to monitor the counts of various types, and decide when to ForceNextStage out of the delay.
	// STAGE_ESCAPE
	// Run an escape - endless waves, tank, etc, etc
	// VALUE: ignored, i believe
	// EXIT: When you escape?
	// STAGE_TANK
	// Run a stage with a tank in it.
	// VALUE: ignored, i believe
	if ( "ScriptedStageType" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
		DirectorScript.MapScript.ChallengeScript.DirectorOptions.ScriptedStageType <- STAGE_NONE
	//ScriptedStageValue = 1000 Dependant on the stage type.
	if ( "ScriptedStageValue" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
		DirectorScript.MapScript.ChallengeScript.DirectorOptions.ScriptedStageValue <- 	1000	
	//MODE OPTIONS
	// What general rule does the director use for spawning. Choices are
	// SPAWN_FINALE spawn in finale nav areas only
	// SPAWN_BATTLEFIELD spawn in battlefield nav areas only
	// SPAWN_SURVIVORS use the areas near/explored by the survivors (@TODO: is this actually right?)
	// SPAWN_POSITIONAL use the SpawnSetPosition/Radius to pick the spawn area
	//SpawnSetRule = SPAWN_SURVIVORS
	//if ( "SpawnSetRule" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
	//Valid flags are: SPAWN_ABOVE_SURVIVORS, SPAWN_ANYWHERE, SPAWN_BEHIND_SURVIVORS( for SpawnBehindSurvivorsDistance int)
	//SPAWN_FAR_AWAY_FROM_SURVIVORS, SPAWN_IN_FRONT_OF_SURVIVORS, SPAWN_LARGE_VOLUME,
	//SPAWN_NEAR_IT_VICTIM, SPAWN_NO_PREFERENCE
	if (nowPlayersinGame>5)
	{
		DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnSetRule <- SPAWN_FINALE
		//if ( "PreferredMobDirection" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
			DirectorScript.MapScript.DirectorOptions.PreferredMobDirection <- 	SPAWN_LARGE_VOLUME	
		//if ( "PreferredSpecialDirection" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
			DirectorScript.MapScript.DirectorOptions.PreferredSpecialDirection <- 	SPAWN_SPECIALS_ANYWHERE	
	}
	else
	if (nowPlayersinGame>2)
	{
		DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnSetRule <- SPAWN_FINALE
		//if ( "PreferredMobDirection" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
		DirectorScript.MapScript.DirectorOptions.PreferredMobDirection <- 	SPAWN_LARGE_VOLUME	
		DirectorScript.MapScript.DirectorOptions.PreferredSpecialDirection	<- 	SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS
	}
	else
	{
		DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnSetRule <- SPAWN_FINALE
		//if ( "PreferredMobDirection" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
			DirectorScript.MapScript.DirectorOptions.PreferredMobDirection <- 	SPAWN_NO_PREFERENCE	
			DirectorScript.MapScript.DirectorOptions.PreferredSpecialDirection <- 	SPAWN_SPECIALS_ANYWHERE		
	}
		
	//SpawnDirectionCount = 0
	if ( "SpawnDirectionCount" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
		DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnDirectionCount <- 0
	//a bitfield (using SPAWNDIR_N, _NE, _E, etc) of directors to spawn from _relative to_ a map
	//SpawnDirectionMask = 0
	if ( "SpawnDirectionMask" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
		DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnDirectionMask <- 0
	
	if (nowPlayersinGame>2)
	{
		//if ( "cm_AggressiveSpecials" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
			DirectorScript.MapScript.ChallengeScript.DirectorOptions.cm_AggressiveSpecials <- 	1	
	}
	else
	{
		//if ( "cm_AggressiveSpecials" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
			DirectorScript.MapScript.ChallengeScript.DirectorOptions.cm_AggressiveSpecials <-  0	
	}
	
	IncludeScript ("debug_directoroptions.nut");	
		
}