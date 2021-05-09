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
		//delete	DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnSetRule;
		//delete	DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnDirectionCount;
		//delete	DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnDirectionMask;
		//delete	DirectorScript.MapScript.ChallengeScript.DirectorOptions.ScriptedStageValue;
		//delete	DirectorScript.MapScript.ChallengeScript.DirectorOptions.ScriptedStageType;
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
		SpecialRespawnInterval = 5
		SpecialInitialSpawnDelayMin = 0
		SpecialInitialSpawnDelayMax =0
		SmokerLimit=1
		BoomerLimit=1
		HunterLimit=1
		SpitterLimit=1
		JockeyLimit=1
		ChargerLimit=1
		WitchLimit=1
		//SurvivorMaxIncapacitatedCount =6
		
		CommonLimit=18
		MobMinSize = 5
		MobMaxSize = 8
		MobMaxPending=63
		
		MobSpawnMinTime=10
		MobSpawnMaxTime=20
		
		ProhibitBosses = false
	}	
}

::cmd_nb_rush <- function ()
{
	Msg("cmd_nb_rush"+"\n");
	local ent = null;
	while (ent = Entities.FindByClassname(ent, "infected"))
	{
		if (ent.IsValid())
			NetProps.SetPropInt( ent, "m_mobRush", 1 );
	}
}


::cmd_nb_rush_player_try <- function (client,duration=15.0)
{
	Msg("cmd_nb_rush_player"+"\n");
	
	local vsPlayer = ::VSLib.Player(client);
	local info_goal_infected_chase = g_ModeScript.CreateSingleSimpleEntityFromTable({ classname = "info_goal_infected_chase", targetname = "info_goal_infected_chase" + UniqueString(), origin = vsPlayer.GetEyePosition(), angles = QAngle(0,0,0) });
	if (!info_goal_infected_chase)
	{
		printl("Advertencia: No se pudo crear la entidad de info_goal_infected_chase.");
		//printl("警告:创建粒子实体失败.");
		return;
	}
	AttachOther(PlayerInstanceFromIndex(vsPlayer.GetIndex()),info_goal_infected_chase, true,vsPlayer.GetEyePosition());
	DoEntFire("!self", "Start", "", 0, null, info_goal_infected_chase);
	DoEntFire("!self", "Enable", "", 0, null, info_goal_infected_chase);
	//DoEntFire("!self", "AddOutput", "", 0, null, info_goal_infected_chase);
	DoEntFire("!self", "FireUser1", "", 0, null, info_goal_infected_chase);
	DoEntFire("!self", "Kill", "", duration, null, info_goal_infected_chase);
}


::cmd_nb_rush_player_command <- function (client)
{
	Msg("cmd_nb_rush_player_command"+"\n");
	local vsPlayer = ::VSLib.Player(client);
	foreach( ent in ::VSLib.EasyLogic.Zombies.CommonInfected() )
	{
		//NetProps.SetPropInt( ent, "m_mobRush", 1 );
		Entity(ent).BotAttack(vsPlayer);
	}		
	// while (bot = Entities.FindByClassname(bot, "infected"))
	// {
		// if (bot.IsValid())
		// {
			// local vsbot = ::VSLib.Entity(bot);
			// vsbot.BotAttack(vsPlayer);
		// }
	// }
}



::SpawnTank <- function ( vPos=null,player=null )
{
	Msg("SpawnTank"+"\n");
	if (player!=0)
		Utils.SpawnZombieNearPlayer( player, Z_TANK, 0, 0, false );
	//local vPos = player.GetLocation();
	if (vPos==null)
	{	
		Msg("Spawning Tank!\n");
		local MaxDist = RandomInt( 800, 1200 );
		local MinDist = RandomInt( 400, 800 );	
		DirectorScript.MapScript.DirectorOptions.PreferredSpecialDirection <- 	SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS	
		local playerx = Players.SurvivorWithHighestFlow();
		Utils.SpawnZombieNearPlayer( playerx, Z_TANK, MaxDist, MinDist, false );
	}	
	else
	{
		Msg("Spawning Tank in Position "+vPos+"!\n");
		//SpawnZombie(zombieType, pos = null, ang = QAngle(0,0,0), offerTank = false, victim = null)
		Utils.SpawnZombie(Z_TANK, vPos);
	}
}

::SpawnWitch <- function (args)
{
	Msg("SpawnWitch"+"\n");
	
	GetInfectedStats( nowinfStats );
	if (nowinfStats.Witches==0)
	{		
		if ( (developer() > 0) || (DEBUG == 1))
		{
			//nowActivateBalance=0;
			ClientPrint(null, 3, "nowinfStats.Witches==0");
		}
		Utils.HowAngry();	
		local player = Players.SurvivorWithHighestFlow();
		local MaxDist = RandomInt( 800, 1200 );
		local MinDist = RandomInt( 400, 800 );
		local ranTD = RandomInt(0,1);
		if ( ranTD ==0 )
			Utils.SpawnZombieNearPlayer( player, Z_WITCH_BRIDE, MaxDist, MinDist, false );
		else
			Utils.SpawnZombieNearPlayer( player, Z_WITCH, MaxDist, MinDist, false );
	}	
}

::closeARRange<- function()			
{
	if ( (developer() > 0) || (DEBUG == 1))
	{
		//nowActivateBalance=0;
		ClientPrint(null, 3, "closeARRange");
	}
	nowAntiRushAddRange=0;
	local mensaje = "Bien Hecho, sigan juntos!";
	ShowHUDTicker(4,"Ad",mensaje)
}

::launchPanicEventComplement<- function()			
{
	if ( (developer() > 0) || (DEBUG == 1))
	{
		//nowActivateBalance=0;
		ClientPrint(null, 3, "launchPanicEventComplement");
	}
	local player = ::VSLib.EasyLogic.Players.SurvivorWithHighestFlow();
	cmd_nb_rush_player_command(player.GetIndex());
	Director.PlayMegaMobWarningSounds();
}
::setBalanceDirectorOptions <- function (args)
{
	Msg("setBalanceDirectorOptions"+"\n");
	//DEBUG
	if ( (developer() > 0) || (DEBUG == 1))
	{
		//nowActivateBalance=0;
		ClientPrint(null, 3, "setBalanceDirectorOptions");
	}
	if (nowinScriptfromaMap==false)	
		if (nowActivateBalance==1)
			if (nowFinaleStarted==0 && nowFinaleScavengeStarted==0)
				BalanceDirectorOptions();
			else
				BalanceFinaleDirectorOptions();
	if ( (developer() > 0) || (DEBUG == 1))
		IncludeScript ("debug_directoroptions.nut");	
}

::EnforceStartCvars <- function ()
{
	Msg("EnforceStartCvars"+"\n");
	//director
	//sm_cvar director_afk_timeout 15
	// Survivor Health, Accuracy, Friendly Fire Variables/Modifiers
	Convars.SetValue("survivor_revive_health" ,					"40");					//was 30
	//use situation
	//Convars.SetValue("survivor_revive_duration" ,				sRDT[gMV][dAAW][gFD]);

	
	//use situation
	//Convars.SetValue("survivor_limp_health" ,					sLHMT[gMV][dAAW][gFD]);
	//use situation
	//Convars.SetValue("survivor_limp_walk_speed" ,			sLWST[gMV][dAAW][gFD]);
	Convars.SetValue("survivor_burn_factor_easy" ,				"0");		//was 0.2

	Convars.SetValue("survivor_burn_factor_normal" ,			"0");		//was 0.2
	Convars.SetValue("survivor_burn_factor_hard" ,				"0");		//was 0.4
	Convars.SetValue("survivor_burn_factor_expert" ,			"0");		//was 1



	//P. Survivor A.I.
	local sb_friend_immobilized_reaction_time_normal=0;
	local sb_friend_immobilized_reaction_time_hard=0;
	local sb_friend_immobilized_reaction_time_expert=0;
	local sb_friend_immobilized_reaction_time_vs=0;
	local sb_separation_range=100;
	local sb_enforce_proximity_range=75;
	local sb_separation_danger_min_range=75;
	local sb_separation_danger_max_range=100;
	local sb_battlestation_give_up_range_from_human=75;
	local sb_max_battlestation_range_from_human=100;
	local sb_max_team_melee_weapons=3;
	Convars.SetValue("sb_friend_immobilized_reaction_time_normal",sb_friend_immobilized_reaction_time_normal);
	Convars.SetValue("sb_friend_immobilized_reaction_time_hard",sb_friend_immobilized_reaction_time_hard);	
	Convars.SetValue("sb_friend_immobilized_reaction_time_expert",sb_friend_immobilized_reaction_time_expert);	
	Convars.SetValue("sb_friend_immobilized_reaction_time_vs",sb_friend_immobilized_reaction_time_vs);
	Convars.SetValue("sb_separation_range",sb_separation_range);
	Convars.SetValue("sb_enforce_proximity_range",sb_enforce_proximity_range);
	Convars.SetValue("sb_separation_danger_min_range",sb_separation_danger_min_range);		
	Convars.SetValue("sb_separation_danger_max_range",sb_separation_danger_max_range);		
	Convars.SetValue("sb_battlestation_give_up_range_from_human",sb_battlestation_give_up_range_from_human);		
	Convars.SetValue("sb_max_battlestation_range_from_human",sb_max_battlestation_range_from_human);
	Convars.SetValue("sb_max_team_melee_weapons",sb_max_team_melee_weapons);


	//O. ZOMBIES ALERTNESS
	//these all dictate the distance and probability that zombies will have you as an objective.
	//the zombie has a much better chance of seeing you if you are in "near" range,
	//and if you are beyond "far" range it won't notice you at all, even if you get boomed/pipe bombed.	
	// FarAcquireRange	int	2500	The maximum range common infected can spot survivors.
	// FarAcquireTime	float	5.0	The time it takes for an infected to acquire the survivor after spotting them at maximum range.
	// NearAcquireRange	int	200	The range where common infected can spot survivors in the least amount of time.
	// NearAcquireTime	float	0.5	The time it takes for an infected to acquire the survivor after spotting them at minimum range.local z_acquire_far_range = 200;
	local z_acquire_far_range = 200;
	if (nowPlayersinGame<5)
		z_acquire_far_range=z_acquire_far_range+(9*nowPlayersinGame);
	else
		z_acquire_far_range=z_acquire_far_range+(50*nowPlayersinGame);	
	local z_acquire_far_time =3;
	local z_acquire_near_range =90;
	local z_acquire_near_time =0.72;	
	local z_acquire_time_variance_factor ="0";
	
	
	// How far a Zombie can see.
	local z_vision_range =z_acquire_far_range;
	// How far a Zombie can see in daylight
	local z_vision_range_daylight =z_acquire_far_range+(3*nowPlayersinGame);
	// How far a Zombie can see in OBSCURED areas.
	local z_vision_range_obscured =z_acquire_far_range-(3*nowPlayersinGame);
	
	//the alert range seems to deal with the zombies overall awareness and the probability a zombie will notice you
	// these deal with how likely a zombie will notice you if things are happening.
	local z_alert_range =z_acquire_far_range-z_acquire_near_range;
	//local z_alert_dot ="0";	
	// How far a Zombie can see when alert.
	local z_vision_range_alert =z_acquire_far_range-z_acquire_near_range;
	// How far a Zombie can see in OBSCURED areas when alert.
	local z_vision_range_obscured_alert =z_acquire_far_range-z_acquire_near_range-(3*nowPlayersinGame);
	
	//for example, if you get close to a zombie who is running for someone else, 
	//it is likely to turn and smack you (which is why if you're 
	//surrounded by a horde and throw a pipe bomb some will keep attacking you).	
	local z_notice_near_range= z_acquire_near_range/2;
	// How far an attacking zombie
	//will look for a nearby target on their way to their chosen victim.
	local z_close_target_notice_distance =z_acquire_near_range/2;
	//whenever a console command refers to it, they mean someone who has been boomered.
	//note that being boomered will draw zombies beyond the alert range.
	local z_notice_it_range= 1500;
	
	
	// zombies who are close to you will notice gunfire, but at that range they will likely notice you anyway.
	local z_force_attack_from_sound_range= z_acquire_far_range;
	// Loud noises attract far-off zombies
	local z_hear_gunfire_range= z_acquire_far_range;
	// Running attracts zombies a lot more than walking does, but the running 
	//aggro (agressive) range is shorter than the zombie seeing you range.
	local z_hear_runner_far_range =z_acquire_far_range-z_acquire_near_range;
	local z_hear_runner_near_range =z_acquire_near_range;
	// Show noise levels on players?
	local z_noise_level_display= "1";
	// How much noise we make with a footstep.
	local z_noise_level_footstep= "135";
	// How long we hold a given noise level before it starts to fade.
	local z_noise_level_hold_time= "0";
	// after hold_time expires.
	local z_noise_level_fade_rate= "40";
	// The highest the noise level can go.
	local z_noise_level_max= "135";
	// How much noise we make when we say things.
	local z_noise_level_vocalize= "135";


		

	DirectorScript.MapScript.DirectorOptions.FarAcquireRange <- z_acquire_far_range;
	Convars.SetValue("z_acquire_far_range" ,z_acquire_far_range);
	DirectorScript.MapScript.DirectorOptions.FarAcquireTime <- z_acquire_far_time;
	Convars.SetValue("z_acquire_far_time" ,z_acquire_far_time);
	DirectorScript.MapScript.DirectorOptions.NearAcquireRange <- z_acquire_near_range;
	Convars.SetValue("z_acquire_near_range" ,z_acquire_near_range);
	DirectorScript.MapScript.DirectorOptions.NearAcquireTime <- z_acquire_near_time;
	Convars.SetValue("z_acquire_near_time" ,z_acquire_near_time);
	Convars.SetValue("z_acquire_time_variance_factor" ,z_acquire_time_variance_factor);
	Convars.SetValue("z_alert_range" ,z_alert_range);
	//Convars.SetValue("z_alert_dot" ,z_alert_dot);
	Convars.SetValue("z_close_target_notice_distance" ,z_close_target_notice_distance);
	Convars.SetValue("z_hear_gunfire_range" ,z_hear_gunfire_range);
	Convars.SetValue("z_hear_runner_far_range" ,z_hear_runner_far_range);
	Convars.SetValue("z_hear_runner_near_range" ,z_hear_runner_near_range);
	Convars.SetValue("z_vision_range" ,z_vision_range);
	Convars.SetValue("z_vision_range_alert" ,z_vision_range_alert);
	Convars.SetValue("z_vision_range_daylight" ,z_vision_range_daylight);
	Convars.SetValue("z_vision_range_obscured" ,z_vision_range_obscured);
	Convars.SetValue("z_vision_range_obscured_alert" ,z_vision_range_obscured_alert);
	Convars.SetValue("z_force_attack_from_sound_range" ,z_force_attack_from_sound_range);
	Convars.SetValue("z_noise_level_display" ,z_noise_level_display);
	Convars.SetValue("z_noise_level_fade_rate" ,z_noise_level_fade_rate);
	Convars.SetValue("z_noise_level_footstep" ,z_noise_level_footstep);
	Convars.SetValue("z_noise_level_hold_time" ,z_noise_level_hold_time);
	Convars.SetValue("z_noise_level_max" ,z_noise_level_max);
	Convars.SetValue("z_noise_level_vocalize" ,z_noise_level_vocalize);
	Convars.SetValue("z_notice_it_range" ,z_notice_it_range);
	Convars.SetValue("z_notice_near_range" ,z_notice_near_range);

	//use general
	//A friend needs to be this close to say Reloading
	Convars.SetValue("z_reload_chatter_nearby_friend_range" ,	"400");		
	//use general
	//Intensity level at which players start saying 'Reloading' 
	Convars.SetValue("z_reload_chatter_intensity" ,				0);
	
	//use general
	//An enemy needs to have been seen this recently to say 'Reloading'
	Convars.SetValue("z_reload_chatter_recent_enemy","2.5")
	//Players don't say 'Reloading' when reloading a shotgun that has this many shells already 
	Convars.SetValue("z_reload_chatter_shotgun_ammo_threshold","8")
	Convars.SetValue("z_reload_chatter_shotgun_interval","2")
	



	local sv_steamgroup = "39464742,2508707,36547718,964095,938619,554109,2450706,883,1240452,1850,5195189,3402923,1582249,10639590,3483,6112039,707962,1651917,1210106,1789698,4311062,37215448,707962,4189851,1909444";		
	
	local scuffle_duration = "6.0";
	//Tanks
	// If 1, Enable Tank Demolition, server will spawn one tank before door open
	local lockdown_systemtdb = "1";
	//Tanke Luego de Abrir en Horda de 4!!!
	local lockdown_systemtda = "0";
	//Time Interval to spawn a tank when door is opening (0=off)
	local lockdown_systemoti = "1500";
	//Mutant Tanks
	local mt_pluginenabled = "1";
	
	//Witches
	// Amount of damage the Witch causes when she hits a Survivor.
	local l4d_pwm_psychoticchargedamage = "1";
	// Power a Survivor is hit with during Psychotic Charge. (Def 300)
	local l4d_pwm_psychoticchargepower = "1";
	// How close a Survivor has to be to be hit by the Psychotic Charge. (Def 200)
	local l4d_pwm_psychoticchargerange = "5";

	//Speciales
	//Explosion de Boomer
	local l4d_nbm_bileblast = "0";
	// Enable/Disable the Special Infected Slap/Shove Ability Plugin.
	//Convars.ExecuteConCommand("sm_cvar l4d_si_ability_enabled 0")
	local l4d_si_ability_enabled = "0";
	//(5/10/15/20)
	local charger_dmg_punch = "5";
	//(5/10/15/20)
	local charger_dmg_firstpunch = "10";
	//(10/10/15/20)
	local charger_dmg_impact = "10";
	//
	local charger_dmg_stumble = "4";
	//
	local charger_dmg_pound = "5";
 
	//Commons
	// Common uncommon chance
	local l4d2_spawn_uncommons_autochance = "4";
	//default 19, binary flag of allowed autoshuffle zombies. 1 = riot, 2 = ceda, 4 = clown, 8 = mudman, 16 = roadcrew, 32 = jimmy, 64 = fallen); riot + ceda + roadcrew = 19
	local l4d2_spawn_uncommons_autotypes = "64";
	//default -1 or health value (set to health value if you want something nonstandard)
	local l4d2_spawn_uncommons_healthoverride = "21";

	local l4d_shot_warns_common_enable = "0";
	local l4d_shot_warns_common_safe_area = "0";
	local l4d_shot_warns_common_tank_alive = "0";

	// ConVars for plugin "balancer_hp.smx"
	// 0: Check all players survivor in game, 1: Ignore check idle survivors, 2: Ignore check survivors bot, 4: Ignore check dead survivors, 7: Set all ignore check modes
	local balancer_hp_check_mode = "6";
	//  0: Disable boomer increment/decrement balance HP, (Value < 1): Set factor percent of HP base [example:0.1 = 1] to increment/decrement per players), (Value >= 1): Set HP value to increment/decrement per players
	//balancer_hp_factor_boomer "2"
	//balancer_hp_factor_charger "10"
	//balancer_hp_factor_hunter "13"
	//balancer_hp_factor_jockey "8"
	//balancer_hp_factor_smoker "2"
	//balancer_hp_factor_spitter "5"
	local balancer_hp_factor_tank="358";
	local balancer_hp_factor_witch="257";
	local l4d_super_HPmultiple_boomer="22.0";
	local l4d_super_HPmultiple_charger="12.0";
	local l4d_super_HPmultiple_hunter="43.0";
	local l4d_super_HPmultiple_jockey="12.0";
	local l4d_super_HPmultiple_smoker="53.0";
	local l4d_super_HPmultiple_spitter="12.0";
	local l4d_super_HPmultiple_tank="1.2";
	//  0: Disable boomer limit max HP, (Value > 0): Set increment limit HP
	local balancer_hp_max_boomer= "0";
	local balancer_hp_max_charger= "0";
	local balancer_hp_max_hunter= "0";
	local balancer_hp_max_jockey= "0";
	local balancer_hp_max_smoker ="0";
	local balancer_hp_max_spitter= "0";
	local balancer_hp_max_tank ="0";
	local balancer_hp_max_witch ="0";
	// Set survivor players default to set hp base
	local balancer_hp_players_base="0";
	
	
		
	if (nowPlayersinGame>7)
	{
		l4d_si_ability_enabled = "1";
		//Speciales
		//Explosion de Boomer
		l4d_nbm_bileblast = "1";
	}
	else
	if (nowPlayersinGame>5)
	{
		sv_steamgroup="39464742,848708,2450706,36972120,4438486,37582986,2240651,2207220,29834576,16793326,2930925,34515242,33766243,1689987,4789854,31758229,4555105";
		

		scuffle_duration= "8.0";
		
		
		//Tanks
		//Time Interval to spawn a tank when door is opening (0=off)
		lockdown_systemoti = "600";

		//Witches
		// Amount of damage the Witch causes when she hits a Survivor.
		l4d_pwm_psychoticchargedamage = "1";
		// Power a Survivor is hit with during Psychotic Charge. (Def 300)
		l4d_pwm_psychoticchargepower = "1";
		// How close a Survivor has to be to be hit by the Psychotic Charge. (Def 200)
		l4d_pwm_psychoticchargerange = "5";

		//Speciales
		// Enable/Disable the Special Infected Slap/Shove Ability Plugin.
		//Convars.ExecuteConCommand("sm_cvar l4d_si_ability_enabled 0")
		l4d_si_ability_enabled = "0";
		//(5/10/15/20)
		charger_dmg_punch = "5";
		//(5/10/15/20)
		charger_dmg_firstpunch = "10";
		//(10/10/15/20)
		charger_dmg_impact = "10";
		//
		charger_dmg_stumble = "4";
		//
		charger_dmg_pound = "5";
     
		//Commons
		// Common uncommon chance
		l4d2_spawn_uncommons_autochance = "4";
		//default 19, binary flag of allowed autoshuffle zombies. 1 = riot, 2 = ceda, 4 = clown, 8 = mudman, 16 = roadcrew, 32 = jimmy, 64 = fallen); riot + ceda + roadcrew = 19
		l4d2_spawn_uncommons_autotypes = "64";
		//default -1 or health value (set to health value if you want something nonstandard)
		l4d2_spawn_uncommons_healthoverride = "21";

		l4d_shot_warns_common_enable = "0";
		l4d_shot_warns_common_safe_area = "0";
		l4d_shot_warns_common_tank_alive = "0";

		//  0: Disable boomer increment/decrement balance HP, (Value < 1): Set factor percent of HP base [example:0.1 = 1] to increment/decrement per players), (Value >= 1): Set HP value to increment/decrement per players
		// balancer_hp_factor_boomer "2"
		// balancer_hp_factor_charger "6"
		// balancer_hp_factor_hunter "10"
		// balancer_hp_factor_jockey "5"
		// balancer_hp_factor_smoker "2"
		// balancer_hp_factor_spitter "5"
		balancer_hp_factor_tank="440";
		balancer_hp_factor_witch="110";
		l4d_super_HPmultiple_boomer="33.0";
		l4d_super_HPmultiple_charger="16.0";
		l4d_super_HPmultiple_hunter="45.0";
		l4d_super_HPmultiple_jockey="14.0";
		l4d_super_HPmultiple_smoker="22.0";
		l4d_super_HPmultiple_spitter="22.0";
		l4d_super_HPmultiple_tank="1";
		// 0: Disable boomer limit max HP, (Value > 0): Set increment limit HP
		// balancer_hp_max_boomer= "0";
		// balancer_hp_max_charger= "0";
		// balancer_hp_max_hunter= "0";
		// balancer_hp_max_jockey= "0";
		// balancer_hp_max_smoker ="0";
		// balancer_hp_max_spitter= "0";
		// balancer_hp_max_tank ="0";
		// balancer_hp_max_witch ="0";
		//Set survivor players default to set hp base
		// balancer_hp_players_base="0";



		//Mutants
		// l4d_super_probability_boomer "16.0"
		// l4d_super_probability_charger "16.0"
		// l4d_super_probability_hunter "16.0"
		// l4d_super_probability_jockey "16.0"
		// l4d_super_probability_smoker "16.0"
		// l4d_super_probability_spitter "16.0"
		// l4d_super_probability_tank "15.0"
		
	}
	else //2 o 1 jugador
	{	
	
		
	}
	
	Convars.SetValue("sv_steamgroup" ,	sv_steamgroup);
																																						 //aca no llega
	//Reaparicion
	//l4d_survivorrespawn_respawntimeout "30"
	//sm_clear_dead_body_time "45"
	//Convars.ExecuteConCommand("sm_cvar scuffle_duration 6.0")
	Convars.SetValue("scuffle_duration" ,	scuffle_duration);

	//Tanks
	// If 1, Enable Tank Demolition, server will spawn one tank before door open
	Convars.SetValue("lockdown_system-l4d2_tank_demolition_before" ,	lockdown_systemtdb);	
	//Tanke Luego de Abrir en Horda de 4!!!
	Convars.SetValue("lockdown_system-l4d2_tank_demolition_after" ,	lockdown_systemtda);
	//Time Interval to spawn a tank when door is opening (0=off)
	Convars.SetValue("lockdown_system-l4d2_opening_tank_interval" ,	lockdown_systemoti);
	
	//Mutant Tanks
	Convars.SetValue("mt_pluginenabled" ,	mt_pluginenabled);
	

	//Witches
	// Amount of damage the Witch causes when she hits a Survivor. 
	Convars.SetValue("l4d_pwm_psychoticchargedamage" ,	l4d_pwm_psychoticchargedamage);
	// Power a Survivor is hit with during Psychotic Charge. (Def 300)
	Convars.SetValue("l4d_pwm_psychoticchargepower" ,	l4d_pwm_psychoticchargepower);
	// How close a Survivor has to be to be hit by the Psychotic Charge. (Def 200)
	Convars.SetValue("l4d_pwm_psychoticchargerange" ,	l4d_pwm_psychoticchargerange);


	//Speciales
	//Explosion de Boomer
	Convars.SetValue("l4d_nbm_bileblast" ,	l4d_nbm_bileblast);
	// Enable/Disable the Special Infected Slap/Shove Ability Plugin.
	//Convars.ExecuteConCommand("sm_cvar l4d_si_ability_enabled 0")
	Convars.SetValue("l4d_si_ability_enabled" ,	l4d_si_ability_enabled);
	//(5/10/15/20)
	Convars.SetValue("charger_dmg_punch" ,	charger_dmg_punch);
	//(5/10/15/20)
	Convars.SetValue("charger_dmg_firstpunch" ,	charger_dmg_firstpunch);
	//(10/10/15/20)
	Convars.SetValue("charger_dmg_impact" ,	charger_dmg_impact);
	//
	Convars.SetValue("charger_dmg_stumble" ,	charger_dmg_stumble);
	//
	Convars.SetValue("charger_dmg_pound" ,	charger_dmg_pound);
 
	//Commons
	// Common uncommon chance
	Convars.SetValue("l4d2_spawn_uncommons_autochance" ,	l4d2_spawn_uncommons_autochance);
	//default 19, binary flag of allowed autoshuffle zombies. 1 = riot, 2 = ceda, 4 = clown, 8 = mudman, 16 = roadcrew, 32 = jimmy, 64 = fallen); riot + ceda + roadcrew = 19
	Convars.SetValue("l4d2_spawn_uncommons_autotypes" ,	l4d2_spawn_uncommons_autotypes);
	//default -1 or health value (set to health value if you want something nonstandard)
	Convars.SetValue("l4d2_spawn_uncommons_healthoverride" ,	l4d2_spawn_uncommons_healthoverride);

	Convars.SetValue("l4d_shot_warns_common_enable" ,	l4d_shot_warns_common_enable);
	Convars.SetValue("l4d_shot_warns_common_safe_area" ,	l4d_shot_warns_common_safe_area);
	Convars.SetValue("l4d_shot_warns_common_tank_alive" ,	l4d_shot_warns_common_tank_alive);



	// ConVars for plugin "balancer_hp.smx"
	// 0: Check all players survivor in game, 1: Ignore check idle survivors, 2: Ignore check survivors bot, 4: Ignore check dead survivors, 7: Set all ignore check modes
	Convars.SetValue("balancer_hp_check_mode" ,	balancer_hp_check_mode);
	//  0: Disable boomer increment/decrement balance HP, (Value < 1): Set factor percent of HP base [example:0.1 = 1] to increment/decrement per players), (Value >= 1): Set HP value to increment/decrement per players
	//balancer_hp_factor_boomer "2"
	//balancer_hp_factor_charger "10"
	//balancer_hp_factor_hunter "13"
	//balancer_hp_factor_jockey "8"
	//balancer_hp_factor_smoker "2"
	//balancer_hp_factor_spitter "5"
	Convars.SetValue("balancer_hp_factor_tank" ,	balancer_hp_factor_tank);
	Convars.SetValue("balancer_hp_factor_witch" ,	balancer_hp_factor_witch);
	Convars.SetValue("l4d_super_HPmultiple_boomer" ,	l4d_super_HPmultiple_boomer);
	Convars.SetValue("l4d_super_HPmultiple_charger" ,	l4d_super_HPmultiple_charger);
	Convars.SetValue("l4d_super_HPmultiple_hunter" ,	l4d_super_HPmultiple_hunter);
	Convars.SetValue("l4d_super_HPmultiple_jockey" ,	l4d_super_HPmultiple_jockey);
	Convars.SetValue("l4d_super_HPmultiple_smoker" ,	l4d_super_HPmultiple_smoker);
	Convars.SetValue("l4d_super_HPmultiple_spitter" ,	l4d_super_HPmultiple_spitter);
	Convars.SetValue("l4d_super_HPmultiple_tank" ,	l4d_super_HPmultiple_tank);
	//  0: Disable boomer limit max HP, (Value > 0): Set increment limit HP
	//balancer_hp_max_boomer "0"
	//balancer_hp_max_charger "0"
	//balancer_hp_max_hunter "0"
	//balancer_hp_max_jockey "0"
	//balancer_hp_max_smoker "0"
	//balancer_hp_max_spitter "0"
	//balancer_hp_max_tank "0"
	//balancer_hp_max_witch "0"
	// Set survivor players default to set hp base
	Convars.SetValue("balancer_hp_players_base" ,	balancer_hp_players_base);

	//Mutants
	// Convars.SetValue("l4d_super_probability_boomer" ,	l4d_super_probability_boomer);
	// Convars.SetValue("l4d_super_probability_charger" ,	l4d_super_probability_charger);
	// Convars.SetValue("l4d_super_probability_hunter" ,	l4d_super_probability_hunter);
	// Convars.SetValue("l4d_super_probability_jockey" ,	l4d_super_probability_jockey);
	// Convars.SetValue("l4d_super_probability_smoker" ,	l4d_super_probability_smoker);
	// Convars.SetValue("l4d_super_probability_spitter" ,	l4d_super_probability_spitter);
	// Convars.SetValue("l4d_super_probability_tank" ,	l4d_super_probability_tank);
	

}

//WANDERING SETTINGS
::setWanderingDirectorOptions <- function ()
{	
	local sizeHordeModifier = mSHMfM;
	//0: default both.  1: wandering zombies don't sit/lie down.  -1: wandering zombies always sit/lie down.
	local z_must_wander=0;
	//Chance that wandering infected will be lying down in a SPAWN_LYINGDOWN area. default 50
	local nav_lying_down_percent=50;
	
	//Wanderer count (N) is zeroed:
	//When an area becomes visible to any Survivor
	//When the Director is in Relax mode
	//AlwaysAllowWanderers = true//bool
	//WanderingZombieDensityModifier  = 1 //Set to 0 to have no wandering zombies float
	//ClearedWandererRespawnChance percent int
	//NumReservedWanderers= common additional from mobs 
	//IntensityRelaxAllowWanderersThreshold float
	//All survivors must be below this intensity before a Wanderer Peak is allowed to switch to Relax (in addition to the normal peak timer)
	//intensity during relax for wandering zombies to be spawned director
	//Intensity < Threshold so switch Relax AllowWanderers
	//Intensity > Threshold can't switch Relax AllowWanderers
	if (nowWanderingPermit)
	{
		DirectorScript.MapScript.DirectorOptions.AlwaysAllowWanderers <- true;	
		DirectorScript.MapScript.DirectorOptions.WanderingZombieDensityModifier <- 1;
		DirectorScript.MapScript.DirectorOptions.ClearedWandererRespawnChance <- 100;
		DirectorScript.MapScript.DirectorOptions.IntensityRelaxAllowWanderersThreshold <- 1;
		if (nowPlayersinGame>6)
		{
			DirectorScript.MapScript.DirectorOptions.NumReservedWanderers <- (45+5*nowPlayersinGame)*sizeHordeModifier;
			z_must_wander=1;
			nav_lying_down_percent=15;
		}
		if (nowPlayersinGame>4)
		{
			DirectorScript.MapScript.DirectorOptions.NumReservedWanderers <- (40+5*nowPlayersinGame)*sizeHordeModifier;
			z_must_wander=0;
			nav_lying_down_percent=75;	
		}				
		else
		{
			DirectorScript.MapScript.DirectorOptions.NumReservedWanderers <- (35+3*nowPlayersinGame*sizeHordeModifier);
			z_must_wander=-1;
			nav_lying_down_percent=100-5*nowPlayersinGame;
		}
	}
	else
	{
		DirectorScript.MapScript.DirectorOptions.AlwaysAllowWanderers <- false;	
		DirectorScript.MapScript.DirectorOptions.WanderingZombieDensityModifier <- 0;
		DirectorScript.MapScript.DirectorOptions.ClearedWandererRespawnChance <- 0;
		DirectorScript.MapScript.DirectorOptions.IntensityRelaxAllowWanderersThreshold <- 1;
		DirectorScript.MapScript.DirectorOptions.NumReservedWanderers <- 0;
	}
	Convars.SetValue("z_must_wander" ,	z_must_wander);
	Convars.SetValue("nav_lying_down_percent" ,	nav_lying_down_percent);
}

//PANIC, WAVES AND COMMON INFECTED SETTINGS
::setPanicWavesCommonInfectedDirectorOptions <- function ()
{	
	local sizeHordeModifier = mSHMfM;
	local mapArea = mAAN;
	//A Panic lasts until MegaMobSize commons spawn
	//MegaMobSize The amount of total infected spawned during a panic event
	//how much Panic they cause, and when the Director decides they are done
	//no more than CommonLimit will ever be out at once.
	//MegaMobSize Default = 50
	//So MegaMobSize 50 CommonLimit 2 is a long slow gentle PANIC
	//and MegaMobSize 80 CommonLimit 80 is over instantly, with a lot of zombies around. 
	//MegaMobSize/CommonLimit 1000 is a good way to crash the game.
	//L 05/02/2021 - 08:41:49: 91.03: Director::StartPanicEvent( 0 ): Panic event started.
	//L 05/02/2021 - 08:41:49: 91.03: ZombieManager::ClearPendingMobCount: All mobs cleared.
	//L 05/02/2021 - 08:41:49: 91.03: Director: Panic Stage = STAGE_INITIAL_DELAY
	//L 05/02/2021 - 08:41:55: 96.47: (MOB) SpawnMob requested of size 130.
	//L 05/02/2021 - 08:41:55: 96.47: (MOB) SpawnMob pending count is now 130.
	//L 05/02/2021 - 08:41:56: 97.53: (MOB) Mob zombie spawned, 0 remain.
	//L 05/02/2021 - 08:41:56: 97.53: (MOB) Pending mob done.
	
	
	//The horde spawning pacing consists of: 
	//BUILD_UP (spawn horde) -> SUSTAIN_PEAK -> PEAK_FADE -> RELAX -> BUILD_UP again.
	//L 05/02/2021 - 08:48:42: ------------------------------ Director state change BUILD_UP -> SUSTAIN_PEAK
	//L 05/02/2021 - 08:42:43: ------------------------------ Director state change SUSTAIN_PEAK -> PEAK_FADE
	//L 05/02/2021 - 08:42:43: ------------------------------ Director state change PEAK_FADE -> RELAX
	//L 05/02/2021 - 08:43:19: ------------------------------ Director state change RELAX -> BUILD_UP
	//L 05/02/2021 - 08:48:20: 176.00: (MOB) SpawnMob requested of size 18.
	//L 05/02/2021 - 08:48:20: 176.00: (MOB) SpawnMob pending count is now 18.
	//L 05/02/2021 - 08:48:33: (MOB) 0 wanderers grabbed for an IT mob of desired size 18.
	//L 05/02/2021 - 08:48:33: 189.07: (MOB) SpawnITMob requested of size 18.
	//L 05/02/2021 - 08:48:33: 189.07: (MOB) SpawnITMob will make 18.
	//L 05/02/2021 - 08:48:42: ------------------------------ Director state change BUILD_UP -> SUSTAIN_PEAK
	
	//	Setting LockTempo = true removes the 
	//"SUSTAIN_PEAK -> RELAX -> BUILD_UP" bit making your hordes spawn constantly without a delay.
	DirectorScript.MapScript.DirectorOptions.LockTempo  <- false
	//MobMaxPending is a queue for zombies that couldn't spawn because of the limit
	
	
	//BUILD_UP
	//BUILD_UP (spawn horde) -> SUSTAIN_PEAK -> PEAK_FADE -> RELAX -> BUILD_UP again.
	//How many zombies are in each mob.
	//MobMinSize Default 10
	//MobMaxSize Default 30
	//MobSpawnSize: Static amount of infected in a mob. Likely overrides MobMinSize and MobMinSize.
	//BuildUpMinInterval MobSpawnMinTime MobSpawnMaxTime
	// Sets the time between mob spawns. Mobs can only spawn when the pacing is in the BUILD_UP state.
	//BileMobSize: Number of commons that spawn when a bile bomb is thrown or a survivor is hit by vomit.
	//Only works if scripted mode is enabled, a custom finale is active, or a scavenge finale is active.
	if (nowPlayersinGame>12)
	{
		DirectorScript.MapScript.DirectorOptions.MegaMobSize<- (150+30*nowPlayersinGame*sizeHordeModifier)
		DirectorScript.MapScript.DirectorOptions.MobMaxPending  <- (150+30*nowPlayersinGame*sizeHordeModifier)
		DirectorScript.MapScript.DirectorOptions.BileMobSize<- (15+12*nowPlayersinGame*sizeHordeModifier)
		DirectorScript.MapScript.DirectorOptions.MobMinSize <- (10+4*nowPlayersinGame*sizeHordeModifier)
		DirectorScript.MapScript.DirectorOptions.MobMaxSize <- (25+4*nowPlayersinGame*sizeHordeModifier)
		DirectorScript.MapScript.DirectorOptions.MobSpawnMinTime <- (18-1*nowPlayersinGame)
		DirectorScript.MapScript.DirectorOptions.MobSpawnMaxTime <- (36-1*nowPlayersinGame)
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- (45+3*nowPlayersinGame*sizeHordeModifier)
	}
	else
	if (nowPlayersinGame>8)
	{
		DirectorScript.MapScript.DirectorOptions.MegaMobSize<- (150+20*nowPlayersinGame*sizeHordeModifier)
		DirectorScript.MapScript.DirectorOptions.MobMaxPending  <-  (150+20*nowPlayersinGame*sizeHordeModifier)
		DirectorScript.MapScript.DirectorOptions.BileMobSize<- (15+10*nowPlayersinGame*sizeHordeModifier)
		DirectorScript.MapScript.DirectorOptions.MobMinSize <- (10+3*nowPlayersinGame*sizeHordeModifier)
		DirectorScript.MapScript.DirectorOptions.MobMaxSize <- (25+3*nowPlayersinGame*sizeHordeModifier)
		DirectorScript.MapScript.DirectorOptions.MobSpawnMinTime <- (18-1*nowPlayersinGame)
		DirectorScript.MapScript.DirectorOptions.MobSpawnMaxTime <- (36-1*nowPlayersinGame)
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- (45+3*nowPlayersinGame*sizeHordeModifier)
	}
	else
	if (nowPlayersinGame>4)
	{
		DirectorScript.MapScript.DirectorOptions.MegaMobSize<- (120+20*nowPlayersinGame*sizeHordeModifier)
		DirectorScript.MapScript.DirectorOptions.MobMaxPending  <- (120+20*nowPlayersinGame*sizeHordeModifier)
		DirectorScript.MapScript.DirectorOptions.BileMobSize<- (15+6*nowPlayersinGame*sizeHordeModifier)
		DirectorScript.MapScript.DirectorOptions.MobMinSize <- (10+3*nowPlayersinGame*sizeHordeModifier)
		DirectorScript.MapScript.DirectorOptions.MobMaxSize <- (25+3*nowPlayersinGame*sizeHordeModifier)
		DirectorScript.MapScript.DirectorOptions.MobSpawnMinTime <- (18-1*nowPlayersinGame)
		DirectorScript.MapScript.DirectorOptions.MobSpawnMaxTime <- (36-1*nowPlayersinGame)
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- (45+3*nowPlayersinGame*sizeHordeModifier)
	}
		else
	{
		DirectorScript.MapScript.DirectorOptions.MegaMobSize<- (120)*sizeHordeModifier
		DirectorScript.MapScript.DirectorOptions.MobMaxPending  <- (120)*sizeHordeModifier
		DirectorScript.MapScript.DirectorOptions.BileMobSize<- (15)*sizeHordeModifier
		DirectorScript.MapScript.DirectorOptions.MobMinSize <- (10+sizeHordeModifier*1*nowPlayersinGame*10/2)
		DirectorScript.MapScript.DirectorOptions.MobMaxSize <- (30-5+sizeHordeModifier*1*nowPlayersinGame*10/2)
		DirectorScript.MapScript.DirectorOptions.MobSpawnMinTime <- (18)
		DirectorScript.MapScript.DirectorOptions.MobSpawnMaxTime <- (36)
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- (45+sizeHordeModifier*1*nowPlayersinGame*10/2)
	}
	
	
	//SUSTAIN_PEAK	
	//BUILD_UP (spawn horde) -> SUSTAIN_PEAK -> PEAK_FADE -> RELAX -> BUILD_UP again.
	//Modifies the length of the SUSTAIN_PEAK state to shorten the time between mob spawns.
	//SustainPeakMinTime SustainPeakMaxTime//持续高峰		
	if (nowPlayersinGame>12)
	{
		DirectorScript.MapScript.DirectorOptions.SustainPeakMinTime <- 35-2*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.SustainPeakMaxTime <- 75-2*nowPlayersinGame
	}
	else
	if (nowPlayersinGame>8)
	{
		DirectorScript.MapScript.DirectorOptions.SustainPeakMinTime <- 35-2*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.SustainPeakMaxTime <- 75-2*nowPlayersinGame
	}
	else
	if (nowPlayersinGame>4)
	{
		DirectorScript.MapScript.DirectorOptions.SustainPeakMinTime <- 35-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.SustainPeakMaxTime <- 75-3*nowPlayersinGame
	}
	else
	{
		DirectorScript.MapScript.DirectorOptions.SustainPeakMinTime <- 35
		DirectorScript.MapScript.DirectorOptions.SustainPeakMaxTime <- 75
	}	
	
	//IntensityRelaxThreshold
	//All survivors must be below this intensity before a Peak is allowed to switch to Relax (in addition to the normal peak timer)
	//Intensity < Threshold so switch Relax
	//Intensity > Threshold can't switch Relax	
	if (nowPlayersinGame>4)
	{				
		DirectorScript.MapScript.DirectorOptions.IntensityRelaxThreshold <- 0.90-0.015*nowPlayersinGame
	}				
	else
	{
		DirectorScript.MapScript.DirectorOptions.IntensityRelaxThreshold <- 0.81+0.03*nowPlayersinGame
	}	
	
	//RELAX	
	//Modifies the length of the RELAX state to shorten the time between mob spawns.
	//RelaxMinInterval RelaxMaxInterval//放松阶段	
	//RelaxMaxFlowTravel
	//How far the survivors can advance along the flow before transitioning from RELAX to BUILD_UP.
	if (nowPlayersinGame>12)
	{
		DirectorScript.MapScript.DirectorOptions.RelaxMinInterval <- 30-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.RelaxMaxInterval <- 60-3*nowPlayersinGame
	}
	else
	if (nowPlayersinGame>8)
	{
		DirectorScript.MapScript.DirectorOptions.RelaxMinInterval <- 30-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.RelaxMaxInterval <- 60-3*nowPlayersinGame
	}
	else
	if (nowPlayersinGame>4)
	{
		DirectorScript.MapScript.DirectorOptions.RelaxMinInterval <- 30-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.RelaxMaxInterval <- 60-3*nowPlayersinGame
	}
	else
	{
		DirectorScript.MapScript.DirectorOptions.RelaxMinInterval <- 30;
		DirectorScript.MapScript.DirectorOptions.RelaxMaxInterval <- 60;
		DirectorScript.MapScript.DirectorOptions.RelaxMaxFlowTravel <- 1750;
	}	
	if (mapArea="clsd")
		DirectorScript.MapScript.DirectorOptions.RelaxMaxFlowTravel <- 810;
		else
		DirectorScript.MapScript.DirectorOptions.RelaxMaxFlowTravel <- 1350;

	//Progress Based
	
	//Increase common limit based on progress  
	//local progressPct = ( Director.GetFurthestSurvivorFlow() / BridgeSpan )
	
	if( nowPlayersinGame >= 2 )
	{
		local playerx = ::VSLib.EasyLogic.Players.SurvivorWithHighestFlow();
		if (playerx!=null)
		{
			local flow = playerx.GetFlowDistance();
			if(playerx.IsAlive() && (flow && flow != -9999.0 )) // Invalid flows
			{
				local progressPct = playerx.GetFlowPercent();
				
				if ( (developer() > 0) || (DEBUG == 1))
					ClientPrint(null, 3, BLUE+"progressPct: "+progressPct);
				//if ( progressPct < 0.0 ) progressPct = 0.0;
				//if ( progressPct > 1.0 ) progressPct = 1.0;
				//DirectorScript.MapScript.DirectorOptions.MobMaxPending  <- (120)*sizeHordeModifier
				if ( progressPct > 90.0 )
					DirectorScript.MapScript.DirectorOptions.CommonLimit <- (14+sizeHordeModifier*1*nowPlayersinGame*10/2)
				//MobSpawnSize = MobSpawnSizeMin + progressPct * ( MobSpawnSizeMax - MobSpawnSizeMin )
			}
		}
	}	
}



::BalanceDirectorOptions <- function ()
{	
	Msg("BalanceDirectorOptions"+"\n");
	EnforceStartCvars();
	
	if (nowFirstPlayerinGame==0)
		Director.ResetMobTimer()	

	//Changed to Heartbeat Plugin
	//DirectorScript.MapScript.DirectorOptions.SurvivorMaxIncapacitatedCount <-6
	
	local sizeHordeModifier = mSHMfM;
	local mapArea = mAAN;

	//You can only assign DirectorOptions with <-
	 //Warning: NEVER use the = operator when trying to influence the director. 
	 //Use <-. The difference is semantics. If you use =, 
	 //it will throw an error if the table slot isn't defined
	 //(like if a previous script didn't define it). <-, on the other hand, will create the variable if it does not exist.
	
	//NO SPECIALS SETTINGS
	//DisallowThreatType=SI Disallowed
	//ex. ZOMBIE_TANK = 8, ZOMBIE_WITCH = 7
	
	
	if (nowPlayersinGame>6)
	{
		DirectorScript.MapScript.DirectorOptions.AggressiveSpecials <- 1
	}
	else
	if (nowPlayersinGame>4)
	{
		DirectorScript.MapScript.DirectorOptions.AggressiveSpecials <- 0
	}
	else	
	if (nowPlayersinGame>3)
	{
		DirectorScript.MapScript.DirectorOptions.ProhibitBosses				 <-	false
		DirectorScript.MapScript.DirectorOptions.ShouldAllowSpecialsWithTank <- true	
		DirectorScript.MapScript.DirectorOptions.ShouldAllowMobsWithTank <- true
		DirectorScript.MapScript.DirectorOptions.AggressiveSpecials <- 0
	}
	else
	if (nowPlayersinGame>2)
	{
		DirectorScript.MapScript.DirectorOptions.ProhibitBosses				 <-	false
		DirectorScript.MapScript.DirectorOptions.ShouldAllowSpecialsWithTank <- false
		DirectorScript.MapScript.DirectorOptions.ShouldAllowMobsWithTank <- true
		DirectorScript.MapScript.DirectorOptions.AggressiveSpecials <- 0
		if ( DirectorScript.MapScript.DirectorOptions.rawin( "DisallowThreatType")  )
			delete DirectorScript.MapScript.DirectorOptions.DisallowThreatType 
	}
	if (nowPlayersinGame>1)
	{				
		DirectorScript.MapScript.DirectorOptions.AggressiveSpecials <- 0
	}	
	else //2 o 1 jugador
	{	
		DirectorScript.MapScript.DirectorOptions.ProhibitBosses				 <-	false
		DirectorScript.MapScript.DirectorOptions.ShouldAllowSpecialsWithTank <- false
		DirectorScript.MapScript.DirectorOptions.ShouldAllowMobsWithTank <- false
		DirectorScript.MapScript.DirectorOptions.AggressiveSpecials <- 0
		DirectorScript.MapScript.DirectorOptions.DisallowThreatType <- 8
		//Default Paceful Mode Stop
		if (nowFirstPlayerinGame==0)
			nowFirstPlayerinGame++;			
	}
	
	
	
	/*TotalBoomers = RandomInt(tBTA[tODMI],tBTA[tODMA])
	TotalChargers = RandomInt(tCTA[tODMI],tCTA[tODMA])
	TotalSpitters = RandomInt(tSpTA[tODMI],tSpTA[tODMA])
	TotalSmokers = RandomInt(tSmTA[tODMI],tSmTA[tODMA])
	TotalJockeys = RandomInt(tJTA[tODMI],tJTA[tODMA])
	TotalHunters = RandomInt(tHTA[tODMI],tHTA[tODMA])*/
	
	//SI SPECIAL INFECTED SETTINGS
	//30 en facil para 4 personas, entonces si hay 5 30/4*5, si hay 1 30/4*1,si hay 2 30/4*2
	//if ( "MaxSpecials" in DirectorScript.MapScript.DirectorOptions )	
	//SpecialInitialSpawnDelayMax	Specials cannot spawn for this many time maximum after the survivors exited the saferoom. Campaign modes only.
	if (nowPlayersinGame>12)
	{
		DirectorScript.MapScript.DirectorOptions.SpecialRespawnInterval <- RandomInt(60,80)
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMin <- 16-1*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMax <- 80-3*nowPlayersinGame
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
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMin <- 24-2*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMax <- 90-3*nowPlayersinGame
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
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMin <- 14-2*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMax <- 70-2*nowPlayersinGame
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
			
	//TIMEOFDAY SETTING
	local ranTD = RandomInt(0,1);
	if (ranTD==1)
		worldspawn_timeofday <- ["3"]
	else 
		worldspawn_timeofday <- ["0"]
	
	//STAGES SETTINGS
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
	
	//SPAWN RULES SETTINGS
	//SpawnSetRule = SPAWN_SURVIVORS
	//if ( "SpawnSetRule" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
	//SPAWN SET RULE
	//Overrides the mode of spawning used. Seems to be non-functional in finales. 
	// What general rule does the director use for spawning. 
	//Valid flags are: SPAWN_ANYWHERE,
	// SPAWN_FINALE spawn in finale nav areas only
	// SPAWN_BATTLEFIELD spawn in battlefield nav areas only
	// SPAWN_SURVIVORS use the areas near/explored by the survivors (@TODO: is this actually right?)
	// SPAWN_POSITIONAL use the SpawnSetPosition/Radius to pick the spawn area
	
	//PreferredMobDirection = SPAWN_NO_PREFERENCE
	//Valid flags are: SPAWN_ABOVE_SURVIVORS, SPAWN_ANYWHERE, SPAWN_BEHIND_SURVIVORS( for SpawnBehindSurvivorsDistance int)
	//SPAWN_FAR_AWAY_FROM_SURVIVORS, SPAWN_IN_FRONT_OF_SURVIVORS, SPAWN_LARGE_VOLUME,
	//SPAWN_NEAR_IT_VICTIM, SPAWN_NO_PREFERENCE
	//Note.png Note: 	SPAWN_NEAR_IT_VICTIM does not exist before a 
	//finale and will cause an error, so I'm assuming the director picks 
	//someone as IT when the finale starts. SPAWN_LARGE_VOLUME is what makes you be a mile away on DC finale.
	//0=Anywhere, 1=Behind, 2=IT, 3=Specials in front, 4=Specials anywhere, 5=Far Away, 6=Above
	//SPAWN_ABOVE_SURVIVORS = 6
	// SPAWN_ANYWHERE = 0
	// SPAWN_BATTLEFIELD = 2
	// SPAWN_BEHIND_SURVIVORS = 1
	// SPAWN_FAR_AWAY_FROM_SURVIVORS = 5
	// SPAWN_FINALE = 0
	// SPAWN_IN_FRONT_OF_SURVIVORS = 7
	// SPAWN_LARGE_VOLUME = 9
	// SPAWN_NEAR_IT_VICTIM = 2
	// SPAWN_NEAR_POSITION = 10
	// SPAWN_NO_PREFERENCE = -1
	// SPAWN_POSITIONAL = 3
	// SPAWN_SURVIVORS = 1
	// SPAWN_VERSUS_FINALE_DISTANCE = 8
	//PreferredSpecialDirection and SPAWN_SPECIALS_ANYWHERE, SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS
	// SPAWN_SPECIALS_ANYWHERE = 4
	// SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS = 3
	// SpawnSetRadius/SpawnSetPosition: A radius in units, a Vector(x,y,z) center point for POSITIONAL spawning
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
		DirectorScript.MapScript.DirectorOptions.PreferredMobDirection <- 	SPAWN_IN_FRONT_OF_SURVIVORS	
		DirectorScript.MapScript.DirectorOptions.PreferredSpecialDirection	<- 	SPAWN_IN_FRONT_OF_SURVIVORS
	}
	else
	{
		DirectorScript.MapScript.ChallengeScript.DirectorOptions.SpawnSetRule <- SPAWN_BATTLEFIELD
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
	
	setPanicWavesCommonInfectedDirectorOptions();
	
	setWanderingDirectorOptions();

	
	if ( (developer() > 0) || (DEBUG == 1))
		IncludeScript ("debug_directoroptions.nut");	
	
	
	/*

	//Increase common limit based on speed   
	    local speedPct = ( Director.GetAveragedSurvivorSpeed() - minSpeed ) / ( maxSpeed - minSpeed );

	    if ( speedPct < 0.0 ) speedPct = 0.0;
	    if ( speedPct > 1.0 ) speedPct = 1.0;

	    MobSpawnSize = MobSpawnSize + speedPct * ( speedPenaltyZAdds );
	    
	    CommonLimit = MobSpawnSize * 1.5
	    
	    if ( CommonLimit > CommonLimitMax ) CommonLimit = CommonLimitMax;
	    

	
	if ( "cm_SpecialRespawnInterval" in DirectorScript.MapScript.GetDirectorOptions() )
		DirectorScript.MapScript.GetDirectorOptions().cm_SpecialRespawnInterval <- 31;
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
	
	
		
		*/
	/*
	//Difficulty Based
	local Difficulty = Convars.GetStr( "z_difficulty" ).tolower();
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


::BalanceFinaleDirectorOptions <- function ()
{
	Msg("BalanceFinaleDirectorOptions"+"\n");
	
	if (nowFirstPlayerinGame==0)
		Director.ResetMobTimer()	
	
	if (nowPlayersinGame>12)
	{
		local finalelimit=3
		local finalelimitscale=3
		DirectorScript.MapScript.DirectorOptions.SpecialRespawnInterval <- 90-4*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 30+4*nowPlayersinGame*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.MaxSpecials <-  2+1*nowPlayersinGame*1/4*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.DominatorLimit <-  2+1*nowPlayersinGame*1/4*finalelimit/finalelimitscale
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
		DirectorScript.MapScript.DirectorOptions.SpecialRespawnInterval <- 90-4*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 10+3*nowPlayersinGame*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.MaxSpecials <-  2+1*nowPlayersinGame*1/4*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.DominatorLimit <-  2+1*nowPlayersinGame*1/4*finalelimit/finalelimitscale
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
		local finalelimit=8
		local finalelimitscale=8
		DirectorScript.MapScript.DirectorOptions.SpecialRespawnInterval <- 70-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 10+3*nowPlayersinGame*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.MaxSpecials <-  2+1*nowPlayersinGame*1/4*finalelimit/finalelimitscale
		DirectorScript.MapScript.DirectorOptions.DominatorLimit <-  2+1*nowPlayersinGame*1/4*finalelimit/finalelimitscale
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
		local finalelimitscale=4
		DirectorScript.MapScript.DirectorOptions.SpecialRespawnInterval <- 35-1*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMin <- 25
		DirectorScript.MapScript.DirectorOptions.SpecialInitialSpawnDelayMax <- 35
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 17+1*nowPlayersinGame*finalelimit/finalelimitscale
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
		
	if (nowPlayersinGame>2)
	{				
		DirectorScript.MapScript.DirectorOptions.ProhibitBosses				 <-	false
		DirectorScript.MapScript.DirectorOptions.PausePanicWhenRelaxing <- false;
	}				
	else
	{
		DirectorScript.MapScript.DirectorOptions.ProhibitBosses				 <-	false
		DirectorScript.MapScript.DirectorOptions.PausePanicWhenRelaxing <- true;
	}			
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
	if (nowPlayersinGame>6)
	{
		DirectorScript.MapScript.DirectorOptions.AggressiveSpecials <- 1
	}
	else
	if (nowPlayersinGame>4)
	{
		DirectorScript.MapScript.DirectorOptions.AggressiveSpecials <- 0
	}
	else
	if (nowPlayersinGame>2)
	{				
		DirectorScript.MapScript.DirectorOptions.ShouldConstrainLargeVolumeSpawn	<- 	false
		DirectorScript.MapScript.DirectorOptions.ShouldAllowSpecialsWithTank <- true
		DirectorScript.MapScript.DirectorOptions.ShouldAllowMobsWithTank <- true		
		DirectorScript.MapScript.DirectorOptions.AggressiveSpecials <- 0
	}
	if (nowPlayersinGame>1)
	{				
		DirectorScript.MapScript.DirectorOptions.AggressiveSpecials <- 0
	}					
	else
	{
		
		DirectorScript.MapScript.DirectorOptions.ShouldConstrainLargeVolumeSpawn	<- 	true
		DirectorScript.MapScript.DirectorOptions.ShouldAllowSpecialsWithTank <- false
		DirectorScript.MapScript.DirectorOptions.ShouldAllowMobsWithTank <- false		
		DirectorScript.MapScript.DirectorOptions.AggressiveSpecials <- 0
	}	
		
	//PANIC WAVES AND COMMON SETTINGS
	//A Panic lasts until MegaMobSize commons spawn
	//MegaMobSize The amount of total infected spawned during a panic event
	//how much Panic they cause, and when the Director decides they are done
	//no more than CommonLimit will ever be out at once. 
	//So MegaMobSize 50 CommonLimit 2 is a long slow gentle PANIC
	//and MegaMobSize 80 CommonLimit 80 is over instantly, with a lot of zombies around. 
	//MegaMobSize/CommonLimit 1000 is a good way to crash the game.
	//The horde spawning pacing consists of: 
	//BUILD_UP -> spawn horde -> SUSTAIN_PEAK -> RELAX -> BUILD_UP again.
	
	//	Setting LockTempo = true removes the 
	//"SUSTAIN_PEAK -> RELAX -> BUILD_UP" bit making your hordes spawn constantly without a delay.
	DirectorScript.MapScript.DirectorOptions.LockTempo  <- false
	//MobMaxPending is a queue for zombies that couldn't spawn because of the limit
	DirectorScript.MapScript.DirectorOptions.MobMaxPending  <- 999
	
	
	//BUILD_UP
	//MobMinSize MobMaxSize 
	//How many zombies are in each mob.		
	//MobSpawnSize: Static amount of infected in a mob. Likely overrides MobMinSize and MobMinSize.
	//BuildUpMinInterval MobSpawnMinTime MobSpawnMaxTime
	// Sets the time between mob spawns. Mobs can only spawn when the pacing is in the BUILD_UP state.
	//BileMobSize: Number of commons that spawn when a bile bomb is thrown or a survivor is hit by vomit.
	//Only works if scripted mode is enabled, a custom finale is active, or a scavenge finale is active.
	if (nowPlayersinGame>12)
	{
		DirectorScript.MapScript.DirectorOptions.MegaMobSize<- 30+3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.BileMobSize<- 15+3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 40+4*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.MobMinSize <- 10+4*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.MobMaxSize <- 20+4*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.MobSpawnMinTime <- 24-1*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.MobSpawnMaxTime <- 36-1*nowPlayersinGame
	}
	else
	if (nowPlayersinGame>8)
	{
		DirectorScript.MapScript.DirectorOptions.MegaMobSize<- 30+3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.BileMobSize<- 15+2*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 45+3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.MobMinSize <- 10+3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.MobMaxSize <- 20+3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.MobSpawnMinTime <- 19-1*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.MobSpawnMaxTime <- 36-1*nowPlayersinGame
	}
	else
	if (nowPlayersinGame>4)
	{
		DirectorScript.MapScript.DirectorOptions.MegaMobSize<- 30+3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.BileMobSize<- 15+1*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 45+3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.MobMinSize <- 10+3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.MobMaxSize <- 20+3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.MobSpawnMinTime <- 15-1*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.MobSpawnMaxTime <- 36-1*nowPlayersinGame
	}
		else
	{
		DirectorScript.MapScript.DirectorOptions.MegaMobSize<- 30
		DirectorScript.MapScript.DirectorOptions.BileMobSize<- 15
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 55+1*nowPlayersinGame*10/2
		DirectorScript.MapScript.DirectorOptions.MobMinSize <- 10+1*nowPlayersinGame*10/2
		DirectorScript.MapScript.DirectorOptions.MobMaxSize <- 20+1*nowPlayersinGame*10/2
		DirectorScript.MapScript.DirectorOptions.MobSpawnMinTime <- 9
		DirectorScript.MapScript.DirectorOptions.MobSpawnMaxTime <- 36
	}	
	//ShouldConstrainLargeVolumeSpawn	bool
	//IfSPAWN_LARGE_VOLUMEis used, it'll obey the restrictions imposed by the convarsz_large_volume_mob_too_far_xyandz_large_volume_mob_too_far_z.
	//DirectorScript.MapScript.DirectorOptions.ShouldConstrainLargeVolumeSpawn = true
	
	//SUSTAIN_PEAK	
	//Modifies the length of the SUSTAIN_PEAK state to shorten the time between mob spawns.
	//SustainPeakMinTime SustainPeakMaxTime//持续高峰	
	
	//IntensityRelaxThreshold
	//All survivors must be below this intensity before a Peak is allowed to switch to Relax (in addition to the normal peak timer)
	if (nowPlayersinGame>4)
	{				
		DirectorScript.MapScript.DirectorOptions.IntensityRelaxThreshold <- 0.90-0.015*nowPlayersinGame
	}				
	else
	{
		DirectorScript.MapScript.DirectorOptions.IntensityRelaxThreshold <- 0.81+0.03*nowPlayersinGame
	}	
	
	//RELAX	
	//Modifies the length of the RELAX state to shorten the time between mob spawns.
	//RelaxMinInterval RelaxMaxInterval//放松阶段
	//RelaxMaxFlowTravel
	//How far the survivors can advance along the flow before transitioning from RELAX to BUILD_UP.
	if (nowPlayersinGame>12)
	{
		DirectorScript.MapScript.DirectorOptions.SustainPeakMinTime <- 35-2*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.SustainPeakMaxTime <- 75-2*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.RelaxMinInterval <- 30-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.RelaxMaxInterval <- 60-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.RelaxMaxFlowTravel <- 1350
	}
	else
	if (nowPlayersinGame>8)
	{
		DirectorScript.MapScript.DirectorOptions.SustainPeakMinTime <- 35-2*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.SustainPeakMaxTime <- 75-2*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.RelaxMinInterval <- 30-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.RelaxMaxInterval <- 60-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.RelaxMaxFlowTravel <- 1350
	}
	else
	if (nowPlayersinGame>4)
	{
		DirectorScript.MapScript.DirectorOptions.SustainPeakMinTime <- 35-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.SustainPeakMaxTime <- 75-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.RelaxMinInterval <- 30-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.RelaxMaxInterval <- 60-3*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.RelaxMaxFlowTravel <- 1500
	}
	else
	{
		DirectorScript.MapScript.DirectorOptions.SustainPeakMinTime <- 35
		DirectorScript.MapScript.DirectorOptions.SustainPeakMaxTime <- 75
		DirectorScript.MapScript.DirectorOptions.RelaxMinInterval <- 30
		DirectorScript.MapScript.DirectorOptions.RelaxMaxInterval <- 60
		DirectorScript.MapScript.DirectorOptions.RelaxMaxFlowTravel <- 1750
	}	
	
	
	DirectorScript.MapScript.DirectorOptions.MusicDynamicMobSpawnSize	 <-	8
	DirectorScript.MapScript.DirectorOptions.MusicDynamicMobStopSize		 <-	2
	DirectorScript.MapScript.DirectorOptions.MusicDynamicMobScanStopSize	 <-	1

	if (nowFinaleGauntletStarted==1)
	{
		DirectorScript.MapScript.DirectorOptions.PanicForever  <-true
		DirectorScript.MapScript.DirectorOptions.PausePanicWhenRelaxing  <- true
		DirectorScript.MapScript.DirectorOptions.IntensityRelaxThreshold  <- 0.99

		DirectorScript.MapScript.DirectorOptions.RelaxMinInterval  <- 22//was 25
		DirectorScript.MapScript.DirectorOptions.RelaxMaxInterval  <- 32//was 35
		DirectorScript.MapScript.DirectorOptions.RelaxMaxFlowTravel  <- 350//was 400

		DirectorScript.MapScript.DirectorOptions.LockTempo  <-false
		DirectorScript.MapScript.DirectorOptions.SpecialRespawnInterval  <- 21
				
		DirectorScript.MapScript.DirectorOptions.PreTankMobMax <- 20
		DirectorScript.MapScript.DirectorOptions.ZombieSpawnRange <- 1500//was 3000
		DirectorScript.MapScript.DirectorOptions.ZombieSpawnInFog <- true
		
		
		DirectorScript.MapScript.DirectorOptions.MobSpawnSize <- 6+2*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.MobSpawnMinTime <- 5
		DirectorScript.MapScript.DirectorOptions.MobSpawnMaxTime <- 5

		DirectorScript.MapScript.DirectorOptions.MobSpawnSizeMin <- 10+2*nowPlayersinGame	//was 5
		DirectorScript.MapScript.DirectorOptions.MobSpawnSizeMax <- 20+2*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.CommonLimit <- 6+2*nowPlayersinGame
		DirectorScript.MapScript.DirectorOptions.CommonLimitMax <- 30+2*nowPlayersinGame //was 30

		DirectorScript.MapScript.DirectorOptions.GauntletMovementThreshold <- 500.0
		DirectorScript.MapScript.DirectorOptions.GauntletMovementTimerLength <- 5.0
		DirectorScript.MapScript.DirectorOptions.GauntletMovementBonus <- 2.0
		DirectorScript.MapScript.DirectorOptions.GauntletMovementBonusMax <- 30.0

		// length of bridge to test progress against.
		DirectorScript.MapScript.DirectorOptions.BridgeSpan <- 20000


		DirectorScript.MapScript.DirectorOptions.minSpeed <- 50
		DirectorScript.MapScript.DirectorOptions.maxSpeed <- 200

		DirectorScript.MapScript.DirectorOptions.speedPenaltyZAdds <-15

	
	}
				
				
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
	
	//SpawnSetRule = SPAWN_SURVIVORS
	//if ( "SpawnSetRule" in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
	//SPAWN SET RULE
	//Overrides the mode of spawning used. Seems to be non-functional in finales. 
	// What general rule does the director use for spawning. 
	//Valid flags are: SPAWN_ANYWHERE,
	// SPAWN_FINALE spawn in finale nav areas only
	// SPAWN_BATTLEFIELD spawn in battlefield nav areas only
	// SPAWN_SURVIVORS use the areas near/explored by the survivors (@TODO: is this actually right?)
	// SPAWN_POSITIONAL use the SpawnSetPosition/Radius to pick the spawn area
	
	//PreferredMobDirection = SPAWN_NO_PREFERENCE
	//Valid flags are: SPAWN_ABOVE_SURVIVORS, SPAWN_ANYWHERE, SPAWN_BEHIND_SURVIVORS( for SpawnBehindSurvivorsDistance int)
	//SPAWN_FAR_AWAY_FROM_SURVIVORS, SPAWN_IN_FRONT_OF_SURVIVORS, SPAWN_LARGE_VOLUME,
	//SPAWN_NEAR_IT_VICTIM, SPAWN_NO_PREFERENCE
	//Note.png Note: 	SPAWN_NEAR_IT_VICTIM does not exist before a 
	//finale and will cause an error, so I'm assuming the director picks 
	//someone as IT when the finale starts. SPAWN_LARGE_VOLUME is what makes you be a mile away on DC finale.
	//0=Anywhere, 1=Behind, 2=IT, 3=Specials in front, 4=Specials anywhere, 5=Far Away, 6=Above
	//SPAWN_ABOVE_SURVIVORS = 6
	// SPAWN_ANYWHERE = 0
	// SPAWN_BATTLEFIELD = 2
	// SPAWN_BEHIND_SURVIVORS = 1
	// SPAWN_FAR_AWAY_FROM_SURVIVORS = 5
	// SPAWN_FINALE = 0
	// SPAWN_IN_FRONT_OF_SURVIVORS = 7
	// SPAWN_LARGE_VOLUME = 9
	// SPAWN_NEAR_IT_VICTIM = 2
	// SPAWN_NEAR_POSITION = 10
	// SPAWN_NO_PREFERENCE = -1
	// SPAWN_POSITIONAL = 3
	// SPAWN_SURVIVORS = 1
	// SPAWN_VERSUS_FINALE_DISTANCE = 8
	//PreferredSpecialDirection and SPAWN_SPECIALS_ANYWHERE, SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS
	// SPAWN_SPECIALS_ANYWHERE = 4
	// SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS = 3
	// SpawnSetRadius/SpawnSetPosition: A radius in units, a Vector(x,y,z) center point for POSITIONAL spawning
	
	
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
	
	if ( (developer() > 0) || (DEBUG == 1))
		IncludeScript ("debug_directoroptions.nut");	
		
}



::alternateCvars <- function()
{
	Convars.SetValue("director_cs_weapon_spawn_chance",			noCSWeps);
	
	Convars.SetValue("host_syncfps" , 							"1");
	Convars.SetValue("sv_accelerate" , 							"5");
	Convars.SetValue("cl_glow_range_start" , 					"200");
	Convars.SetValue("cl_glow_blur_scale" , 					cGBSA[dAANNR]);

	Convars.SetValue("cl_ragdoll_maxcount_generic" , 			"30");
	Convars.SetValue("cl_ragdoll_maxcount_gib" , 				"20");
	Convars.SetValue("cl_ragdoll_gravity" , 					"1200");

	Convars.SetValue("cl_player_max_decal_count" , 				"256");
	Convars.SetValue("cl_ideal_spec_mode" , 					"6");
	Convars.SetValue("cl_survivor_light_offset_z" , 			"4");

	Convars.SetValue("cl_threaded_bone_setup" , 				"1");
	Convars.SetValue("cl_threaded_init" , 						"1");
	Convars.SetValue("cl_phys_maxticks" , 						"8");

	Convars.SetValue("cl_detailfade" , 							"500");
	Convars.SetValue("cl_detaildist" , 							"900");
	Convars.SetValue("cl_detail_max_sway" , 					"1");

	Convars.SetValue("hud_targetid_player_view_cone" ,			"0");		//was 91 Distance from crosshair a player can be to trigger overhead naming
	Convars.SetValue("cl_burninggibs" ,							"1");		//was 0

	Convars.SetValue("sv_consistency" ,							"0");		//was 1 force consistancy for files, best left off
	Convars.SetValue("hud_targetid_name_height" ,				"1000");	//was 15 I think, this gets rid of the players names over their heads. You still get the outlines when they go behind objects

	Convars.SetValue("sv_waterfriction" ,						"0.6");		//was 1
	Convars.SetValue("sv_pushaway_clientside" ,					"1"); 		//was 0, Clientside physics push away (0=off, 1=only localplayer, 1=all players), makes the ojects move when kicked like milk cartons etc
	Convars.SetValue("sv_pushaway_clientside_size" ,			"15");

	Convars.SetValue("sv_pushaway_max_force" ,					"600");		//was 2000 Maximum amount of force applied to physics objects by players
	Convars.SetValue("sv_pushaway_max_player_force" ,			"2500");	//was 10000 Maximum of how hard the player is pushed away from physics objects
	Convars.SetValue("sv_prop_door_max_close_attempts" ,		"1");		//was 8

	Convars.SetValue("sv_player_max_separation_force" ,			"440");		//was 500
	Convars.SetValue("sv_player_stuck_tolerance" ,				"5");		//was 10
	Convars.SetValue("sv_vote_show_caller" ,					"0");		//was 1

	Convars.SetValue("sv_vote_plr_map_limit" ,					"2");		//was 3
	Convars.SetValue("sv_vote_issue_change_mission_allowed" ,	"1");
	Convars.SetValue("sv_infected_ceda_vomitjar_probability" ,	sICVPA[dAANNR]);	//was 0.1

	Convars.SetValue("sv_vote_issue_restart_game_allowed" ,		"0");		//was 1
	Convars.SetValue("intensity_enemy_death_far_range" ,		"750");		//was 500
	Convars.SetValue("intensity_enemy_death_near_range" ,		"225");		//was 150

	//use general
	Convars.SetValue("z_reload_chatter_nearby_friend_range" ,	"400");		//was 600 A friend needs to be this close to say Reloading
	//use general
	Convars.SetValue("z_reload_chatter_intensity" ,				zRCIA[dAANNR]);
	
	//use general
	
	Convars.SetValue("z_reload_chatter_recent_enemy","2.5")
	Convars.SetValue("z_reload_chatter_shotgun_ammo_threshold","7")
	Convars.SetValue("z_reload_chatter_shotgun_interval","5")
	
	Convars.SetValue("cola_bottles_use_duration" ,				cBUDA[dAANNR]);

	//B. SURVIVOR HEALTHCARE PLAN
	//use situation
	Convars.SetValue("first_aid_kit_use_duration" ,				fAKUDGMT[gMV][dAAW][gFD]);
	Convars.SetValue("first_aid_heal_percent" ,					"0.96");	//was 0.8
	Convars.SetValue("first_aid_kit_max_heal" ,					"96");		//was 100

	Convars.SetValue("pain_pills_health_threshold" ,			"100");		//was 99

	Convars.SetValue("adrenaline_duration" ,					aDA[dAANNR]);
	Convars.SetValue("adrenaline_backpack_speedup" ,			aBSA[dAANNR]);

	//C. SURVIVOR DAMAGE
	Convars.SetValue("survivor_allow_crawling" ,				"1");		//was 0
	Convars.SetValue("survivor_crouch_speed" ,					sCROSA[gFD]);
	Convars.SetValue("survivor_crawl_speed" ,					sCRASA[gFD]);		//was 15

	Convars.SetValue("survivor_incap_max_fall_damage" ,			"325");		//was 200
	Convars.SetValue("survivor_incap_health" ,					"330");		//was 300
	Convars.SetValue("survivor_it_fade_in_interval" ,			"0.5");		//was 0.2

	Convars.SetValue("survivor_it_fade_out_interval" ,			"0.5");		//was 2
	Convars.SetValue("survivor_incapacitated_cycle_time" ,		"0.3");		//was 0.3
	Convars.SetValue("survivor_max_incapacitated_count" ,		"2");
	Convars.SetValue("survivor_limp_walk_speed" ,				sLWST[gMV][dAAW][gFD]);	//was 85

	Convars.SetValue("survivor_ledge_grab_health" ,				sLGHT[dAAW][gFD]);
	Convars.SetValue("survivor_revive_health" ,					"40");					//was 30
	//use situation
	Convars.SetValue("survivor_revive_duration" ,				sRDT[gMV][dAAW][gFD]);

	
	//use situation
	Convars.SetValue("survivor_limp_health" ,					sLHMT[gMV][dAAW][gFD]);
	Convars.SetValue("survivor_burn_factor_easy" ,				"0.2");		//was 0.2

	Convars.SetValue("survivor_burn_factor_normal" ,			"0.3");		//was 0.2
	Convars.SetValue("survivor_burn_factor_hard" ,				"0.4");		//was 0.4
	Convars.SetValue("survivor_burn_factor_expert" ,			"0.5");		//was 1

	//D. PHYSICS
	Convars.SetValue("g_ragdoll_min_fps" ,						"30");		//was 10
	Convars.SetValue("g_ragdoll_max_fps" ,						"60");		//was 30
	Convars.SetValue("props_break_max_pieces" ,					"12");		//was 50

	Convars.SetValue("sv_bounce" ,								"0.14");	//was 0
	Convars.SetValue("r_shadow_shortenfactor" ,					"3");		//was 2
	Convars.SetValue("r_particle_timescale" ,					"0.9");		//was 1

	Convars.SetValue("phys_timescale" ,							"0.9");		//was 1.0 Scale time for physics, there is a cl version of this
	Convars.SetValue("phys_pushscale" ,							"1.17");	//was 1
	Convars.SetValue("phys_explosion_force" ,					"5.5");		//was 7

	Convars.SetValue("phys_impactforcescale" ,					"1.2");		//was 1
	Convars.SetValue("phys2_ragdoll_default_friction" ,			"0.15");	//was 0.2
	Convars.SetValue("phys2_mass_exponent" ,					"9.6");		//was 1

	Convars.SetValue("phys2_air_density" ,						"1.2");		//was 2 seems to affect low mass physics props the most, they kind of parachut when they're fall velocity gets to a certain speed
	Convars.SetValue("phys2_force_apply_magnitude" ,			"2.42");	//was 1
	Convars.SetValue("phys2_water_density_multiplier" ,			"4"); 		//was 1

	Convars.SetValue("z_noise_level_max" ,						"200");		//was 135 The highest the noise level can go
	Convars.SetValue("z_noise_level_hold_time" ,				"0.75");	//was 0.5 How long we hold a given noise level before it starts to fade
	Convars.SetValue("z_max_stagger_duration" ,					zMSDA[dAANNR]);		//was 6, Max time a PZ staggers when bashed by a survivor.
	Convars.SetValue("z_push_mass_max" ,						"330");				//was 200, zombies can push physics objects?

	//E. WEAPONARY, THROWABLES & EXPLOSIVE OBJECTS
	Convars.SetValue("director_oxygen_tank_density" ,			"12.96");	
	Convars.SetValue("grenadelauncher_damage" ,					gDA[dAANNR]);
	Convars.SetValue("ammo_smg_max" ,							aSMMA[dAANNR]);
	Convars.SetValue("ammo_assaultrifle_max" ,					aARMA[dAANNR]);
	
	Convars.SetValue("ammo_autoshotgun_max" ,					aAMA[dAANNR]);	
	Convars.SetValue("ammo_grenadelauncher_max" ,				aGLMA[dAANNR]);	

	Convars.SetValue("ammo_huntingrifle_max" ,					aHMA[dAANNR]);
	Convars.SetValue("ammo_sniperrifle_max" ,					aSNMA[dAANNR]);
	Convars.SetValue("ammo_shotgun_max" ,						aSHMA[dAANNR]);

	Convars.SetValue("grenadelauncher_radius_kill" ,			"280");		//was 180
	Convars.SetValue("grenadelauncher_radius_stumble" ,			"500");		//was 250
	Convars.SetValue("grenadelauncher_damage" ,					gDA[dAANNR]);		//was 400

	Convars.SetValue("fuel_barrel_screen_shake_amplitude" ,		"16");		//was 20
	Convars.SetValue("fuel_barrel_screen_shake_duration" ,		"0.6");		//was 1.5
	Convars.SetValue("z_gun_physics_force" ,					"85");		//was 25

	Convars.SetValue("z_gun_swing_coop_max_penalty" ,			zGSCMAPA[dAANNR]);		//was 8
	Convars.SetValue("z_gun_swing_coop_min_penalty" ,			zGSCMIPA[dAANNR]);		//was 5
	Convars.SetValue("z_gun_swing_duration" ,					zGSWDT[dAAW][gFD]);
	Convars.SetValue("z_gun_swing_interval" ,					zGSIT[dAAW][gFD]);

	Convars.SetValue("gascan_throw_force" ,						"476");					//was 32
	//use situation
	Convars.SetValue("gas_can_use_duration" ,					gCUDA[dAANNR]);

	Convars.SetValue("upgrade_explosive_slug_force" ,			"0.3");		//was 4
	Convars.SetValue("upgrade_explosive_bullet_force" ,			"0.3");		//was 2
	Convars.SetValue("upgrade_laser_sight_spread_factor" ,		uLSSF[dAANNR]);

	Convars.SetValue("chainsaw_attack_force" ,					"42");		//was 400
	Convars.SetValue("chainsaw_attack_cone" ,					"15");		//was 30
	Convars.SetValue("chainsaw_attack_distance" ,				"75"); 		//was 50

	Convars.SetValue("chainsaw_startup_fadeout_time" ,			"0.4");		//was 0.1
	Convars.SetValue("chainsaw_attract_distance" ,				"250");		//was 500
	Convars.SetValue("chainsaw_hit_interval",					cHIA[dAANNR]);

	//F. TRIPOD GUNS
	Convars.SetValue("mounted_gun_overheat_time" ,				"30");		//was 15
	Convars.SetValue("mounted_gun_cooldown_time" ,				"30");		//was 60
	Convars.SetValue("mounted_gun_rate_of_fire" ,				mGROFA[dAANNR]);

	Convars.SetValue("mounted_gun_overheat_penalty_time" ,		"20");		//was 60
	Convars.SetValue("ammo_turret_infected_damage" ,			"210");		//was 15
	Convars.SetValue("ammo_turret_pz_damage" ,					"210");		//was 8

	Convars.SetValue("ammo_turret_tank_damage" ,				"210");		//was 40
	Convars.SetValue("ammo_turret_witch_damage" ,				"210");		//was 16
	Convars.SetValue("z_minigun_overheat_time" ,				"30");		//was 20

	Convars.SetValue("z_minigun_spin_up_speed" ,				"60");		//was 15
	Convars.SetValue("z_minigun_spin_down_speed" ,				"10");		//was 4
	Convars.SetValue("z_minigun_rate_of_fire" ,					"9000");	//was 1500

	Convars.SetValue("z_minigun_spread" , 						"3.9");		//was 7
	Convars.SetValue("z_minigun_fire_anim_speed" ,				"2");		//was 1
	Convars.SetValue("z_minigun_firing_speed" ,					"45");		//was 15
	Convars.SetValue("z_minigun_cooldown_time" ,				"6");		//was 3

	//G. FIRE	
	Convars.SetValue("inferno_scorch_decals" ,					"1");		//was 0
	Convars.SetValue("inferno_velocity_factor" ,				"0.004");	//was 0.003
	Convars.SetValue("inferno_velocity_decay_factor" ,			"0.15");	//was 0.2
	Convars.SetValue("inferno_surface_offset" ,					"0");		//was 20

	//J. RAGDOLLS
	Convars.SetValue("g_ragdoll_fadespeed" ,					"3600");	//was 600
	Convars.SetValue("sv_ragdoll_maxcount_generic" ,			"30");		//was 60
	Convars.SetValue("sv_ragdoll_maxcount" ,					"50");		//was 75
	Convars.SetValue("z_ragdoll_discard_range" ,				"768");		//was 2000

	//L. ZOMBII
	//Convars.SetValue("z_female_boomer_spawn_chance" ,			"100");
	Convars.SetValue("z_spawn_mobs_behind_chance" ,				zSMBCDA[gFD]);
	Convars.SetValue("r_flashlightinfectedshadows" ,			"1");			//was 0

	Convars.SetValue("z_burning_lifetime" ,						"15");			//was 30 Number of seconds a burning zombie takes to crisp
	Convars.SetValue("z_mob_population_density" ,				zMPDT[mAAN][dAANNR]);
	Convars.SetValue("z_infected_burn_strength" ,				"0.6");			//was 0.9
	Convars.SetValue("z_special_burn_dmg_scale" ,				"3");			//was 3

	//Convars.SetValue("z_shotgun_bonus_damage_multiplier" ,		"2.5");		//was 5
	Convars.SetValue("z_shotgun_bonus_damage_range" ,			"175");			//was 100
	Convars.SetValue("z_mob_music_size" ,						zMMSA[dAANNR]);	//was 2 Spotting a mob this large plays music

	Convars.SetValue("z_noise_level_vocalize" ,					zNLVA[dAANNR]);
	Convars.SetValue("z_deafen_radius_one" ,					"300");		//was 100
	Convars.SetValue("z_deafen_radius_two" ,					"450");		//was 150

	Convars.SetValue("z_deafen_radius_three" ,					"600");		//was 200
	Convars.SetValue("z_large_volume_mob_too_far_xy" ,			"2000");	//was 1600
	Convars.SetValue("z_large_volume_mob_too_far_z" ,			"194");		//was 128

	Convars.SetValue("z_zombie_lunge_push" ,					"1");		//was 0 Does the zombie lunge push players?
	Convars.SetValue("z_gib_despawn_time" ,						"5f");		//was 10f
	Convars.SetValue("z_mob_population_density" ,				zMPDT[mAAN][dAANNR]);

	//N. DIRECTOR AND SIMILAR

	Convars.SetValue("director_tank_checkpoint_interval" ,		"33");					//was 15 Min time after leaving a checkpoint that a tank can spawn
	Convars.SetValue("director_gauntlet_movement_bonus_max" ,	RandomInt	(15,30));	//was 30 Maximum amount of bonus time you can accumulate from not moving
	Convars.SetValue("director_intensity_relax_threshold" ,		"0.9");					//was 0.9 All survivors must be below this intensity before a Peak is allowed to switch to Relax (in addition to the normal peak timer)

	Convars.SetValue("director_gauntlet_movement_bonus" ,		"2");					//was 5 If you don't cross the movement threshold in DirectorGauntletMovementTimer seconds, you will get this much bonus time added between mobs
	Convars.SetValue("director_always_allow_wanderers" ,		"1");
	
	Convars.SetValue("director_tank_max_interval" ,				"360");					//was 500
	Convars.SetValue("director_tank_min_interval" ,				"120");					//was 350
	Convars.SetValue("intensity_averaged_following_decay" ,		iAFDA[dAANNR]);

	Convars.SetValue("director_intensity_relax_allow_wanderers_threshold" ,			"0.5");		//was 0.3
	Convars.SetValue("director_intensity_relax_allow_wanderers_threshold_hard" ,	"0.6");		//was 0.5
	Convars.SetValue("director_intensity_relax_allow_wanderers_threshold_expert" ,	"0.7");		//was 0.8
	Convars.SetValue("z_mob_spawn_finale_size" ,				RandomInt	(zMSFSDA[tODMI],zMSFSDA[tODMA]));
	Convars.SetValue("z_mega_mob_spawn_max_interval" ,			RandomInt	(zMMSMIDA[tODMI],zMMSMIDA[tODMA]));
	Convars.SetValue("z_mega_mob_spawn_min_interval" ,			RandomInt	(zMMSmIDA[tODMI],zMMSmIDA[tODMA]));
	Convars.SetValue("z_notice_it_range" ,						RandomInt	(zNIRA[dAANMI],zNIRA[dAANMA]));
	Convars.SetValue("z_close_target_notice_distance" ,			RandomInt	(100,300));		//was 60 How far an attacking zombie will look for a nearby target on their way to their chosen victim
	Convars.SetValue("z_mob_recharge_rate" ,					RandomFloat	(mRRTA[tODMI],mRRTA[tODMA]));
	Convars.SetValue("z_common_limit" ,							RandomInt	(cLDA[tODMI],cLDA[tODMA]));
	Convars.SetValue("z_wandering_density" ,					RandomFloat	(zWDT[mAAN][tODMI],zWDT[mAAN][tODMA]));
	Convars.SetValue("versus_wandering_zombie_density" ,		RandomFloat	(zWDT[mAAN][tODMI],zWDT[mAAN][tODMA]));	
	Convars.SetValue("director_sustain_peak_max_time" ,			RandomInt	(dSPMATT[mAAN][tODMI],dSPMATT[mAAN][tODMA]));
	Convars.SetValue("director_sustain_peak_min_time" ,			RandomInt	(dSPMITT[mAAN][tODMI],dSPMITT[mAAN][tODMA]));
	Convars.SetValue("intensity_factor" ,						RandomFloat	(iFA[dAANMI],iFA[dAANMA]));
	Convars.SetValue("intensity_decay_time" ,					RandomInt	(iDTA[dAANMI],iDTA[dAANMA]));	
	//Credits:"Romero Mod"
	//"Description"	"A more gritty, realistic zombie experience."
	//"Author"	"xaroth8088"
	local z_hit_from_behind_factor=2;
	// Zombies that get behind you are more dangerous
	Convars.SetValue("z_hit_from_behind_factor" ,	z_hit_from_behind_factor);
	//O. ZOMBIES ALERTNESS
	//these all dictate the distance and probability that zombies will notice you.
	//the zombie has a much better chance of seeing you if you are in "near" range,
	//and if you are beyond "far" range it won't notice you at all, even if you get boomed/pipe bombed.
	//the alert range seems to deal with the zombies overall awareness and the probability a zombie will notice you
	local z_acquire_far_range = 2500;
	local z_acquire_far_time =5;
	local z_acquire_near_range =200;
	local z_acquire_near_time =0;
	
	
	local z_acquire_time_variance_factor ="0";
	local z_alert_range =1000;
	local z_alert_dot ="0";

	// these deal with how likely a zombie will notice you if things are happening.
	//for example, if you get close to a zombie who is running for someone else, 
	//it is likely to turn and smack you (which is why if you're 
	//surrounded by a horde and throw a pipe bomb some will keep attacking you).
	
	// How far an attacking zombie
	//will look for a nearby target on their way to their chosen victim.
	local z_close_target_notice_distance =60;
	// zombies who are close to you will notice gunfire, but at that range they will likely notice you anyway.
	// Loud noises attract far-off zombies
	local z_hear_gunfire_range= 200;
	// Running attracts zombies a lot more than walking does, but the running 
	//aggro range is shorter than the zombie seeing you range.
	local z_hear_runner_far_range =750;
	local z_hear_runner_near_range =500;
	

	// How far a Zombie can see.
	local z_vision_range ="500";
	// How far a Zombie can see when alert.
	local z_vision_range_alert ="1500";
	// How far a Zombie can see in daylight
	local z_vision_range_daylight ="2400";
	// How far a Zombie can see in OBSCURED areas.
	local z_vision_range_obscured ="500";
	// How far a Zombie can see in OBSCURED areas when alert.
	local z_vision_range_obscured_alert ="750";

	
	
	local z_force_attack_from_sound_range= 750;
	// Show noise levels on players?
	local z_noise_level_display= "0";
	// after hold_time expires.
	local z_noise_level_fade_rate= "40";
	// How much noise we make with a footstep.
	local z_noise_level_footstep= "135";
	// How long we hold a given noise level before it starts to fade.
	local z_noise_level_hold_time= "0";
	// The highest the noise level can go.
	local z_noise_level_max= "135";
	// How much noise we make when we say things.
	local z_noise_level_vocalize= "135";


	//whenever a console command refers to it, they mean someone who has been boomered.
	//note that being boomered will draw zombies beyond the alert range.
	local z_notice_it_range= 1500;
	local z_notice_near_range= "100";


	Convars.SetValue("z_acquire_far_range" ,z_acquire_far_range);
	Convars.SetValue("z_acquire_far_time" ,z_acquire_far_time);
	Convars.SetValue("z_acquire_near_range" ,z_acquire_near_range);
	Convars.SetValue("z_acquire_near_time" ,z_acquire_near_time);
	Convars.SetValue("z_acquire_time_variance_factor" ,z_acquire_time_variance_factor);
	Convars.SetValue("z_alert_range" ,z_alert_range);
	Convars.SetValue("z_alert_dot" ,z_alert_dot);
	Convars.SetValue("z_close_target_notice_distance" ,z_close_target_notice_distance);
	Convars.SetValue("z_hear_gunfire_range" ,z_hear_gunfire_range);
	Convars.SetValue("z_hear_runner_far_range" ,z_hear_runner_far_range);
	Convars.SetValue("z_hear_runner_near_range" ,z_hear_runner_near_range);
	Convars.SetValue("z_vision_range" ,z_vision_range);
	Convars.SetValue("z_vision_range_alert" ,z_vision_range_alert);
	Convars.SetValue("z_vision_range_daylight" ,z_vision_range_daylight);
	Convars.SetValue("z_vision_range_obscured" ,z_vision_range_obscured);
	Convars.SetValue("z_vision_range_obscured_alert" ,z_vision_range_obscured_alert);
	Convars.SetValue("z_force_attack_from_sound_range" ,z_force_attack_from_sound_range);
	Convars.SetValue("z_noise_level_display" ,z_noise_level_display);
	Convars.SetValue("z_noise_level_fade_rate" ,z_noise_level_fade_rate);
	Convars.SetValue("z_noise_level_footstep" ,z_noise_level_footstep);
	Convars.SetValue("z_noise_level_hold_time" ,z_noise_level_hold_time);
	Convars.SetValue("z_noise_level_max" ,z_noise_level_max);
	Convars.SetValue("z_noise_level_vocalize" ,z_noise_level_vocalize);
	Convars.SetValue("z_notice_it_range" ,z_notice_it_range);
	Convars.SetValue("z_notice_near_range" ,z_notice_near_range);

	//P. Survivor A.I.
	local sb_friend_immobilized_reaction_time_normal=0;
	local sb_friend_immobilized_reaction_time_hard=0;
	local sb_friend_immobilized_reaction_time_expert=0;
	local sb_friend_immobilized_reaction_time_vs=0;
	local sb_separation_range=100;
	local sb_enforce_proximity_range=75;
	local sb_separation_danger_min_range=75;
	local sb_separation_danger_max_range=100;
	local sb_battlestation_give_up_range_from_human=75;
	local sb_max_battlestation_range_from_human=100;
	local sb_max_team_melee_weapons=3;
	Convars.SetValue("sb_friend_immobilized_reaction_time_normal",sb_friend_immobilized_reaction_time_normal);
	Convars.SetValue("sb_friend_immobilized_reaction_time_hard",sb_friend_immobilized_reaction_time_hard);	
	Convars.SetValue("sb_friend_immobilized_reaction_time_expert",sb_friend_immobilized_reaction_time_expert);	
	Convars.SetValue("sb_friend_immobilized_reaction_time_vs",sb_friend_immobilized_reaction_time_vs);
	Convars.SetValue("sb_separation_range",sb_separation_range);
	Convars.SetValue("sb_enforce_proximity_range",sb_enforce_proximity_range);
	Convars.SetValue("sb_separation_danger_min_range",sb_separation_danger_min_range);		
	Convars.SetValue("sb_separation_danger_max_range",sb_separation_danger_max_range);		
	Convars.SetValue("sb_battlestation_give_up_range_from_human",sb_battlestation_give_up_range_from_human);		
	Convars.SetValue("sb_max_battlestation_range_from_human",sb_max_battlestation_range_from_human);
	Convars.SetValue("sb_max_team_melee_weapons",sb_max_team_melee_weapons);
	
	
	
	//zombie alertness
	//z_use_tolerance = "0.00";
	//Default camera distance when in-eye (non-zero is pulled back like staggering, hanging, etc)
	//z_view_distance = "0"; 
	//sm_cvar z_spawn_mobs_behind_chance 50
	// Common Infected[All] Special Infected[lunge_push only]
	//Does the zombie lunge push players?
	//sm_cvar z_zombie_lunge_push 1
	//sm_cvar z_hit_from_behind_factor 1.0
	//Minimum time between damaging a Survivor from a mob 
	//sm_cvar z_throttle_hit_interval_easy 0.5
	//sm_cvar z_throttle_hit_interval_normal 0.5
	//sm_cvar z_throttle_hit_interval_hard 0.5
	//sm_cvar z_throttle_hit_interval_expert 0.5
	
	if (miniFinalDirectorNoSet == 0)
	{
		DirectorOptions <-
		{
			TankRunSpawnDelay		=	RandomInt(tRSDDA[tODMI],tRSDDA[tODMA])
			SpecialRespawnInterval	=	RandomInt(sRITA[tODMI],sRITA[tODMA])
			DominatorLimit			=	RandomInt(dLDA[dAANMI],dLDA[dAANMA])

			MaxSpecials				=	RandomInt(mSDA[dAANMI],mSDA[dAANMA])
			//TotalBoomers			=	RandomInt(tBTA[tODMI],tBTA[tODMA])
			TotalChargers			=	RandomInt(tCTA[tODMI],tCTA[tODMA])

			TotalSpitters			=	RandomInt(tSpTA[tODMI],tSpTA[tODMA])
			TotalSmokers			=	RandomInt(tSmTA[tODMI],tSmTA[tODMA])
			TotalJockeys			=	RandomInt(tJTA[tODMI],tJTA[tODMA])

			TotalHunters			=	RandomInt(tHTA[tODMI],tHTA[tODMA])
			NumReservedWanderers	=	RandomInt(nORWT[mAAN][tODMI],nORWT[mAAN][tODMA])
			FarAcquireTime			=	RandomFloat(fATT[mAAN][dAANMI],fATT[mAAN][dAANMA])

			FarAcquireRange			=	RandomInt(fART[mAAN][dAANMI],fART[mAAN][dAANMA])
			NearAcquireTime			=	RandomFloat(nATT[mAAN][dAANMI],nATT[mAAN][dAANMA])
			NearAcquireRange		=	RandomInt(nART[mAAN][dAANMI],nART[mAAN][dAANMA])

			ZombieSpawnRange		=	RandomInt(zSRT[mAAN][dAANMI],zSRT[mAAN][dAANMA])
			RelaxMaxFlowTravel		=	RandomInt(rMFTT[mAAN][dAANMI],rMFTT[mAAN][dAANMA])
			CommonLimit				=	RandomInt(cLDA[tODMI],cLDA[tODMA])

			MobMaxSize				=	RandomInt(mMASA[tODMI],mMASA[tODMA])
			MobMinSize				=	RandomInt(mMISA[tODMI],mMISA[tODMA])
			MegaMobSize				=	RandomInt(mMSDA[tODMI],mMSDA[tODMA])

			MobSpawnSize			=	RandomInt(mSSDA[tODMI],mSSDA[tODMA])
			MobRechargeRate			=	RandomFloat(mRRTA[tODMI],mRRTA[tODMA])
			MobMaxPending			=	mMPDA[tODNR]
			TankLimit				=	5
			FallenSurvivorPotentialQuantity = 2
		}
	}
	Msg("Executed: alternateConvars function\n");
}



::CalculateNumberofPlayers <- function ()
{
	//if ( (developer() > 0) || (DEBUG == 1))
	nowSurvivorsinGame=0;
	nowPlayersinGame = 0;
	foreach( survivor in ::VSLib.EasyLogic.Players.Survivors() )
	{
		nowSurvivorsinGame++;
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
	if ((developer() > 0) || (DEBUG == 1))
	{
		nowPlayersinGame=nowSurvivorsinGame;
	}
}

::skipIntro <- function ()
{	
	//addontitle "Speedrunner Tools"
	//Author シェイディ♑ Constantin Horoshawin
	//addonversion "5.4"
	//addondescription "Speedrunner Tools makes speedrun recording more convenient."
	if (SessionState.MapName.find("m1_") != null)
	{
		if (SessionState.MapName == "c1m1_hotel")
		{
			EntFire("sound_chopperleave", "Kill");					//Specific intro sounds.
			EntFire("rescue_chopper", "Kill");						//Specific models of rescue vehicles.
			EntFire("lcs_intro", "Kill");								//Remove survivor voices during intro.
			EntFire("fade_intro", "Kill");								//Remove entity of fade control.
			EntFire("director", "FinishIntro", null, 0.1);					//Stop survivor animations during intro.
			EntFire("director", "ReleaseSurvivorPositions", null, 0.1);		//Teleport to start points + unfreezing.
			EntFire("point_viewcontrol_survivor", "Kill"); 				//Remove intro cameras.
		}
		else if (SessionState.MapName == "c2m1_highway")
		{
			EntFire("lcs_intro", "Kill");
			EntFire("fade_intro", "Kill");
			EntFire("director", "FinishIntro", null, 0.1);
			EntFire("director", "ReleaseSurvivorPositions", null, 0.1);
			EntFire("point_viewcontrol_survivor", "Kill");
		}
		else if (SessionState.MapName == "c3m1_plankcountry")
		{
			EntFire("lcs_intro", "Kill");
			EntFire("fade_intro", "Kill");
			EntFire("director", "ReleaseSurvivorPositions", null, 0.1);
			EntFire("point_viewcontrol_survivor", "Kill");
		}
		else if (SessionState.MapName == "c4m1_milltown_a")
		{
			EntFire("PugTug", "Kill");
			EntFire("@skybox_PugTug", "Kill");
			EntFire("lcs_intro", "Kill");
			EntFire("fade_intro", "Kill");
			EntFire("@director", "FinishIntro", null, 0.1);
			EntFire("@director", "ReleaseSurvivorPositions", null, 0.1);
			EntFire("point_viewcontrol_survivor", "Kill");
		}
		else if (SessionState.MapName == "c5m1_waterfront")
		{
			EntFire("orator", "Kill");
			EntFire("tug_boat_intro", "Kill");
			EntFire("@skybox_tug_boat_intro", "Kill");
			EntFire("fade_intro", "Kill");
			EntFire("director", "FinishIntro", null, 0.1);
			EntFire("director", "ReleaseSurvivorPositions", null, 0.1);
			EntFire("point_viewcontrol_survivor", "Kill");
		}
		else if (SessionState.MapName == "c6m1_riverbank")
		{
			/*Prohibit "relay_intro_start" forcing a FireConceptToAny input.
			P.S.: Usually we avoid using such methods, 
			but only this time... Made sure, that DirectorOptions loads properly.*/
			
			EntFire("@director", "FinishIntro");
			EntFire("@director", "AddOutput", "targetname director_temp");
			EntFire("director_temp", "AddOutput", "targetname @director", 0.1);
			EntFire("fade_intro", "Kill");
			EntFire("point_viewcontrol_survivor", "Kill");
		}
		else if (SessionState.MapName == "c7m1_docks")
		{
			EntFire("civilian_gunfire", "Kill");
			EntFire("intro_killer", "Kill");
			EntFire("intro_train_steam1", "Kill");
			EntFire("intro_train_steam2", "Kill");
			EntFire("intro_train_steam3", "Kill");
			EntFire("train", "AddOutput", "origin 13168.001, 2768.000, 50.000");
			EntFire("infected_chase", "Kill");
			EntFire("infected_spawner", "Kill");
			EntFire("fade_outro_1", "Kill");
			EntFire("fade_outro_4", "Kill");
			EntFire("director", "ReleaseSurvivorPositions", null, 0.1);
			EntFire("point_viewcontrol_survivor", "Kill");
		}
		else if (SessionState.MapName == "c8m1_apartment")
		{
			EntFire("lcs_intro_survivors", "Kill");
			EntFire("tarp_sound", "Kill");
			EntFire("tarp_animated", "Kill");
			EntFire("ghostAnim", "Kill");
			EntFire("sound_chopper", "Kill");
			EntFire("helicopter_speaker", "Kill");
			EntFire("helicopter_animated", "Kill");
			EntFire("fade_intro", "Kill");
			EntFire("director", "FinishIntro", null, 0.3);
			EntFire("director", "ReleaseSurvivorPositions", null, 0.3);
			EntFire("camera_intro_airplane", "Kill");
		}
		else if (SessionState.MapName == "c9m1_alleys")
		{
			EntFire("lcs_intro", "Kill");
			EntFire("fade_intro", "Kill");
			EntFire("@director", "FinishIntro", null, 0.1);
			EntFire("@director", "ReleaseSurvivorPositions", null, 0.1);
			EntFire("point_viewcontrol_survivor", "Kill");
		}
		else if (SessionState.MapName == "c10m1_caves")
		{
			EntFire("lcs_intro", "Kill");
			EntFire("fade_intro", "Kill");
			EntFire("director", "FinishIntro", null, 0.3);
			EntFire("director", "ReleaseSurvivorPositions", null, 0.3);
			EntFire("point_viewcontrol_survivor", "Kill");
		}
		else if (SessionState.MapName == "c11m1_greenhouse")
		{
			EntFire("light_hanging03", "AddOutput", "targetname ");
			EntFire("light_hanging02", "AddOutput", "targetname ");
			EntFire("light_hanging01", "AddOutput", "targetname ");
			EntFire("greenhouse_panel02", "Kill");
			EntFire("greenhouse_panel01", "Kill");
			EntFire("greenhouse_particles", "Kill");
			EntFire("sound_airplane_intro", "Kill");
			EntFire("airplane_animated_intro", "Kill");
			EntFire("lcs_intro_airport_01", "Kill");
			EntFire("fade_intro", "Kill");
			EntFire("director", "FinishIntro", null, 0.3);
			EntFire("director", "ReleaseSurvivorPositions", null, 0.3);
			EntFire("point_viewcontrol_survivor", "Kill");
		}
		else if (SessionState.MapName == "c12m1_hilltop")
		{
			EntFire("lcs_intro", "Kill");
			EntFire("fade_intro", "Kill");
			EntFire("director", "FinishIntro", null, 0.3);
			EntFire("director", "ReleaseSurvivorPositions", null, 0.3);
			EntFire("point_viewcontrol_survivor", "Kill");
		}
		else if (SessionState.MapName == "c13m1_alpinecreek")
		{
			EntFire("gamesound", "PlaySound");
			EntFire("lcs_intro", "Kill");
			EntFire("scene_relay", "Kill");
			EntFire("b_Signboard01", "Kill");
			EntFire("fade_intro", "Kill");
			EntFire("director", "FinishIntro", null, 0.1);
			EntFire("director", "ReleaseSurvivorPositions", null, 0.1);
			EntFire("point_viewcontrol_survivor", "Kill");
		}
		else													//omni skipintro
		{
			EntFire("camera_intro_airplane", "Disable", null, 0.1);
			EntFire("airplane_animated_intro", "Kill");
			EntFire("env_fade", "AddOutput", "duration 0");
			EntFire("env_fade", "Fade");
			EntFire("env_fade", "Kill", null, 1.0);
			EntFire("director", "FinishIntro", null, 0.1);
			EntFire("director", "FinishIntro", null, 0.3);
			EntFire("director", "ReleaseSurvivorPositions", null, 0.1);
			EntFire("@director", "FinishIntro", null, 0.1);
			EntFire("@director", "ReleaseSurvivorPositions", null, 0.1);
			EntFire("point_viewcontrol_survivor", "Disable", null, 0.1);
		}
		printl("[ST] Loaded SkipIntro script.");
	}
}