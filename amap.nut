//Title: The Alternate Difficulties Mod (TADM)
//Author Steam Alias: jetSetWilly II
//Author URL: https://steamcommunity.com/id/jetsetwillyuncensored/
//Version: 2.5
//Programming Language: VScript
//File Description: This is a control file that selects map specific files used by TADM


Msg("................................................ " + g_MapName + "\n");
Msg("..............................nowexecScriptName: " + nowexecScriptName + "\n");
Msg(".............................nowLocalScriptExec: " + nowLocalScriptExec + "\n");

local execscriptName=g_MapName
if (nowexecScriptName!="")
	execscriptName=nowexecScriptName
Msg(".................................execScriptName: " + execscriptName + "\n");
//implemented
/*
c1m1_hotel
c1m2_streets
c2m5_concert
c5m5_bridge
c8m5_rooftop
c11m5_runway
*/
switch (execscriptName)
{	
//Scripts Names or Map Names Controlled by nowLocalScriptExec Times
	case "c1m1_hotel":
	{	
		if (nowLocalScriptExec==0)
		{
			nowLocalScriptExec++;
			Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
			Msg("Replacing c1m1_reserved_wanderers\n");
			Msg("Initiating Reserved Wanderers\n");

			/*DirectorOptions <-
			{
				// Turn always wanderer on
				AlwaysAllowWanderers = true

				// Set the number of infected that cannot be absorbed
				NumReservedWanderers = 5

				// This turns off tanks and witches.
				//ProhibitBosses = true

			}*/

			Msg("Initiating relay buttons timers\n");

			local buttonelevRelaytop = Entities.FindByName( null, "relay_top_button" ) 

			local buttonelevRelaybot = Entities.FindByName( null, "relay_elevator_reached_bottom" ) 


			local hndc5m5timer1 = Entities.FindByName( null, "jeremytimer1" ) 
			local hndc5m5timer2 = Entities.FindByName( null, "jeremytimer2" ) 

			local hndzombie1 = Entities.FindByName( null, "c1m1jeremy1" ) 

			if ( hndzombie1==null)
			{	
				Msg("SpawnEntityFromTable hndzombie1\n");		
				hndzombie1 =SpawnEntityFromTable( "info_zombie_spawn",
				{
					targetname	= "c1m1jeremy1",
					origin = "2151.114257 5562.124023 1184",
					angles= "0 0 0",
					population	= "default"
				} );
			}

			if ( hndc5m5timer1!=null )
			{
				Msg("kill hndc5m5timer1\n");
				kill_entity(hndc5m5timer1);
				//EntFire( "jeremytimer1", "Kill")
				hndc5m5timer1=null;
			}

			if ( hndc5m5timer1==null)
			{	
				Msg("SpawnEntityFromTable hndc5m5timer1\n");	
				
				hndc5m5timer1 =SpawnEntityFromTable( "logic_timer",
				{
					targetname	= "jeremytimer1",
					//RefireTime	= user_intKillTimer,
					origin = "1824.022460 5728.031250 1336.031250"
					StartDisabled	= 1,
					UseRandomTime	= 1,
					UpperRandomBound	= 1,
					spawnflags	= 0,
					LowerRandomBound	= 2,
					//origin = Vector(-11762,6341,459),
					connections =
					{
						OnTimer =
						{
							cmd1 = "c1m1jeremy1SpawnZombie0-1"
						}
					}
				} );
					
			}
			if ( hndc5m5timer2!=null )
			{
				Msg("kill hndc5m5timer2\n");	
				//kill_entity(hndc5m5timer2);
				EntFire( "jeremytimer2", "Kill")
				hndc5m5timer2=null;

			}

			if ( hndc5m5timer2==null)
			{		
				Msg("SpawnEntityFromTable hndc5m5timer2\n");	
				hndc5m5timer2=SpawnEntityFromTable( "logic_timer",
				{
					targetname	= "jeremytimer2",
					//RefireTime	= user_intKillTimer,
					origin = "-1824.022460 5728.031250 1336.031250"
					StartDisabled	= 1,
					UseRandomTime	= 1,
					UpperRandomBound	= 1,
					spawnflags	= 0,
					LowerRandomBound	= 2,
					//origin = Vector(-11762,6341,459),
					connections =
					{
						OnTimer =
						{
							cmd1 = "c1m1jeremy1SpawnZombie0-1"
						}
					}
				} );
			}



			if ( hndc5m5timer1!=null )
			{
				Msg("start the timer c5m5timer1\n");		
				// start the timer c5m5timer1
				//EntFireByHandle(handle target, string action, string value, float delay, handle activator, handle caller)
				//EntFire( "jeremytimer1", "Enable")
				//c5m5timer1.Destroy()
			}
				
			if ( hndc5m5timer2!=null )
			{
					
				Msg("start the timer c5m5timer2\n");		
				// start the timer c5m5timer2
				//DoEntFire(string target, string action, string value, float delay, handle activator, handle caller)
				//DoEntFire( "jeremytimer2", "Enable", "", 0, null, null )
				//c5m5timer1.Destroy()
			}
				
			if ( buttonelevRelaytop!=null )
			{
				Msg("mod the buttonelevRelaytop\n");		
				local entbuttonelevRelaytop = ::VSLib.Entity(buttonelevRelaytop);
				//AddOutput( output, target, input, parameter = "", delay = 0, timesToFire = -1 )
				//<output name> <targetname>:<inputname>:<parameter>:<delay>:<max times to fire, 1 means once and -1 means infinite>
				//"OnHealthChange" "!self,AddOutput,targetname prop9001"
				//OutputName TargetName:Color:255 255 255:0:-1
				//"OnMapSpawn" "team_round_timer_red,AddOutput,OnFinished game_round_win:RoundWin::0:-1,0,-1"
				//DELAY SIEMPRE ES FLOAT
				entbuttonelevRelaytop.AddOutput("OnTrigger", "jeremytimer1", "Enable", "", 0.0, -1 )			
				entbuttonelevRelaytop.AddOutput("OnTrigger", "jeremytimer2", "Enable", "", 0.0, -1 )			
				//DoEntFire("!self", "AddOutput", "OnTrigger jeremytimer1:Enable::0:-1", 0.0, null, entbuttonelevRelaytop);
				//DoEntFire("!self", "AddOutput", "OnTrigger jeremytimer2:Enable::0:-1", 0.0, null, entbuttonelevRelaytop);
				//ALTERNATIVA
				//DoEntFire( "entbuttonelevRelaytop", "AddOutput", "OnTrigger jeremytimer1:Enable::0:-1", 0.0, null, null);
				//DoEntFire( "entbuttonelevRelaytop", "AddOutput", "OnTrigger jeremytimer2:Enable::0:-1", 0.0, null, null);

			}
			if ( buttonelevRelaybot!=null )
			{
				Msg("mod the buttonelevRelaybot\n");		
				local entbuttonelevRelaybot = ::VSLib.Entity(buttonelevRelaybot);
				entbuttonelevRelaybot.AddOutput("OnTrigger", "jeremytimer1", "Disable", "", 10.0, -1 )			
				entbuttonelevRelaybot.AddOutput("OnTrigger", "jeremytimer2", "Disable", "", 10.0, -1 )	
				//DoEntFire("!self", "AddOutput", "OnTrigger jeremytimer1:Disable::0:-1", 0.0, null, entbuttonelevRelaybot);
				//DoEntFire("!self", "AddOutput", "OnTrigger jeremytimer2:Disable::0:-1", 0.0, null, entbuttonelevRelaybot);

			}
		}		
		break;		
	}
	case "c1m2_streets":
	//c1_3_trafficmessage_frequency
	//c1m2_reserved_wanderers
	//c1_streets_ambush 1
	//c1_gunshop_quiet 2
	{	
		
		if (nowLocalScriptExec==1)
		{
			nowLocalScriptExec++;
			Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
			Msg("c1_gunshop_quiet\n");
			DirectorOptions <-
			{
				// This turns off tanks and witches.
				ProhibitBosses = false
				PreferredMobDirection = SPAWN_BEHIND_SURVIVORS
				PreferredSpecialDirection = SPAWN_SPECIALS_ANYWHERE
			}
			Director.ResetMobTimer()
			Director.PlayMegaMobWarningSounds()
		}
		if (nowLocalScriptExec==0)
		{
			nowLocalScriptExec++;
			Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
			Msg("c1_streets_ambush\n");
			Msg("Initiating Ambush\n");
			local tempChargerLimit=2+1*nowPlayersinGame/2
			DirectorOptions <-
			{
				// This turns off tanks and witches.
				//ProhibitBosses = false
				MaxSpecials = DirectorScript.MapScript.DirectorOptions.MaxSpecials+tempChargerLimit
				DominatorLimit = DirectorScript.MapScript.DirectorOptions.MaxSpecials+tempChargerLimit
				BoomerLimit = 0
				SmokerLimit = 0
				HunterLimit = 0
				ChargerLimit = tempChargerLimit
				SpitterLimit = 1
				JockeyLimit = 0
				LockTempo = true
				SpecialRespawnInterval = 15
				SpecialInitialSpawnDelayMin = 2
				SpecialInitialSpawnDelayMax = 6
				ZombieSpawnRange=500
				CommonLimit = 25+5*nowPlayersinGame
				PreferredMobDirection = SPAWN_IN_FRONT_OF_SURVIVORS
				PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS
			}
			Director.ResetMobTimer()
			Director.PlayMegaMobWarningSounds()
		}
		break;
	}
	case "c1m3_mall":
	case "c1m4_atrium":
	case "c2m1_highway":
	case "c2m2_fairgrounds":
	case "c2m3_coaster":
	case "c2m4_barns":
	case "c2m5_concert":
	{	
		if (nowLocalScriptExec==0)
		{
			nowLocalScriptExec++;
			Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
			//A stage can be one of 4 types (other values will break the finale and go right to ESCAPE):
			//-----------------------------------------------------------------------------
			PANIC <- 0//FINALE_CUSTOM_PANIC <- 7
			TANK <- 1//FINALE_CUSTOM_TANK <- 8
			DELAY <- 2//FINALE_CUSTOM_DELAY <- 10
			ONSLAUGHT <- 3
			//-----------------------------------------------------------------------------
			//ChangeFinaleStage: 18 ANTES Y DESPUES DE INICIAR//A PUNTO DE INICIAR ChangeFinaleStage: 1
			SharedOptions <-
			{
				A_CustomFinale_StageCount = 9
				
				A_CustomFinale1 = PANIC
				A_CustomFinaleValue1 = 1
				
				A_CustomFinale2 = PANIC
				A_CustomFinaleValue2 = 1

				A_CustomFinale3 = DELAY
				A_CustomFinaleValue3 = 30-1*nowPlayersinGame

				A_CustomFinale4 = TANK
				A_CustomFinaleValue4 = 1
				A_CustomFinaleMusic4 = ""

				A_CustomFinale5 = DELAY
				A_CustomFinaleValue5 = 30-1*nowPlayersinGame

				A_CustomFinale6 = PANIC
				A_CustomFinaleValue6 = 2

				A_CustomFinale7 = DELAY
				A_CustomFinaleValue7 = 10

				A_CustomFinale8 = TANK
				A_CustomFinaleValue8 = 1
				A_CustomFinaleMusic8 = ""

				A_CustomFinale9 = DELAY
				A_CustomFinaleValue9 = 30-1*nowPlayersinGame
				
				PreferredMobDirection = SPAWN_LARGE_VOLUME
				PreferredSpecialDirection = SPAWN_LARGE_VOLUME
				ShouldConstrainLargeVolumeSpawn = false

				ZombieSpawnRange = 3000
				
				SpecialRespawnInterval = 20
		
		
			}

			InitialPanicOptions <-
			{
				ShouldConstrainLargeVolumeSpawn = true
			}


			PanicOptions <-
			{
				CommonLimit = 40
			}

			TankOptions <-
			{
				ShouldAllowSpecialsWithTank = true
				SpecialRespawnInterval = 30-1*nowPlayersinGame
			}


			DirectorOptions <- clone SharedOptions
			{
			}

			//-----------------------------------------------------------------------------

			function AddTableToTable( dest, src )
			{
				foreach( key, val in src )
				{
					dest[key] <- val
				}
			}

			//-----------------------------------------------------------------------------

			function OnBeginCustomFinaleStage( num, type )
			{
				if ( developer() > 0 )
				{
					printl("========================================================");
					printl( "Beginning custom finale stage " + num + " of type " + type );
				}
				nowFinaleStageNum = num
				nowFinaleStageType=type
				nowFinaleStageEvent=1
				local waveOptions = null
				if ( num == 1 )
				{
					waveOptions = InitialPanicOptions
				}
				else if ( type == PANIC )
				{
					waveOptions = PanicOptions
					if ( "MegaMobMinSize" in PanicOptions )
					{
						waveOptions.MegaMobSize <- RandomInt( PanicOptions.MegaMobMinSize, MegaMobMaxSize )
					}
				}
				else if ( type == TANK )
				{
					waveOptions = TankOptions
				}
				
				//---------------------------------

				MapScript.DirectorOptions.clear()

				AddTableToTable( MapScript.DirectorOptions, SharedOptions );

				if ( waveOptions != null )
				{
					AddTableToTable( MapScript.DirectorOptions, waveOptions );
				}

			}				
		}
		break;
	}
	case "c3m1_plankcountry":
	case "c3m2_swamp":
	case "c3m3_shantytown":
	case "c3m4_plantation":
	{
		if (nowLocalScriptExec==0)
		{
			nowLocalScriptExec++;						
			Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
			//-----------------------------------------------------
			local PANIC = 0
			local TANK = 1
			local DELAY = 2
			//-----------------------------------------------------
			DirectorOptions <-
			{
				//-----------------------------------------------------

				 A_CustomFinale_StageCount = 8
				 
				 A_CustomFinale1 = PANIC
				 A_CustomFinaleValue1 = 2
				 
				 A_CustomFinale2 = DELAY
				 A_CustomFinaleValue2 = 12
				 
				 A_CustomFinale3 = TANK
				 A_CustomFinaleValue3 = 1
				 
				 A_CustomFinale4 = DELAY
				 A_CustomFinaleValue4 = 12
				 
				 A_CustomFinale5 = PANIC
				 A_CustomFinaleValue5 = 2
				 
				 A_CustomFinale6 = DELAY
				 A_CustomFinaleValue6 = 15
				 
				 A_CustomFinale7 = TANK
				 A_CustomFinaleValue7 = 2

				 A_CustomFinale8 = DELAY
				 A_CustomFinaleValue8 = 10
				 
				SpecialRespawnInterval = 55

				//-----------------------------------------------------
			}
			function OnBeginCustomFinaleStage( num, type )
			{
				nowFinaleStageNum = num
				nowFinaleStageType=type
				nowFinaleStageEvent=1
			}
		}
		break;
	}
	case "c4m1_milltown_a":
	case "c4m2_sugarmill_a":
	case "c4m3_sugarmill_b":
	case "c4m4_milltown_b":
	case "c4m5_milltown_escape":
	{
		if (nowLocalScriptExec==0)
		{
			nowLocalScriptExec++;						
			Msg("Local Script exec n° "+nowLocalScriptExec+"\n");						
			//-----------------------------------------------------
			local PANIC = 0
			local TANK = 1
			local DELAY = 2
			//-----------------------------------------------------

			// default finale patten - for reference only

			/*
			CustomFinale1 <- PANIC
			CustomFinaleValue1 <- 2

			CustomFinale2 <- DELAY
			CustomFinaleValue2 <- 10

			CustomFinale3 <- TANK
			CustomFinaleValue3 <- 1

			CustomFinale4 <- DELAY
			CustomFinaleValue4 <- 10

			CustomFinale5 <- PANIC
			CustomFinaleValue5 <- 2

			CustomFinale6 <- DELAY
			CustomFinaleValue6 <- 10

			CustomFinale7 <- TANK
			CustomFinaleValue7 <- 1

			CustomFinale8 <- DELAY
			CustomFinaleValue8 <- 2
			*/

			DirectorOptions <-
			{
				//-----------------------------------------------------

				// 3 waves of mobs in between tanks

				 A_CustomFinale_StageCount = 8
				 
				 A_CustomFinale1 = PANIC
				 A_CustomFinaleValue1 = 1
				 
				 A_CustomFinale2 = DELAY
				 A_CustomFinaleValue2 = 10
				 
				 A_CustomFinale3 = TANK
				 A_CustomFinaleValue3 = 1
				 
				 A_CustomFinale4 = DELAY
				 A_CustomFinaleValue4 = 10
				 
				 A_CustomFinale5 = PANIC
				 A_CustomFinaleValue5 = 1
				 
				 A_CustomFinale6 = DELAY
				 A_CustomFinaleValue6 = 10
				 
				 A_CustomFinale7 = TANK
				 A_CustomFinaleValue7 = 1
				 
				 A_CustomFinale8 = DELAY
				 A_CustomFinaleValue8 = 15
				 
				 
				HordeEscapeCommonLimit = 15
				CommonLimit = 20
				SpecialRespawnInterval = 80


			}


			if ( "DirectorOptions" in LocalScript && "ProhibitBosses" in LocalScript.DirectorOptions )
			{
				delete LocalScript.DirectorOptions.ProhibitBosses
			}
			function OnBeginCustomFinaleStage( num, type )
			{
				nowFinaleStageNum = num
				nowFinaleStageType=type
				nowFinaleStageEvent=1
			}
			/*
			*/
		}		
		break;
	}
	case "c5m1_waterfront":
	case "c5m2_park":
	case "c5m3_cemetery":
	case "c5m4_quarter":
	case "c5m5_bridge":
	{	
		if (nowLocalScriptExec==0)
		{
			nowLocalScriptExec++;
			Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
			Msg("Initiating c5m5_bridge_coop Script\n");
			local hndc5m5timer1 = Entities.FindByName( null, "jeremytimer1" ) 
			local hndc5m5timer2 = Entities.FindByName( null, "jeremytimer2" ) 

			local hndc5m5zombie1 = Entities.FindByName( null, "c5m5jeremy1" ) 


			if ( hndc5m5zombie1==null)
			{	
				Msg("SpawnEntityFromTable hndc5m5zombie1\n");		
				hndc5m5zombie1 =SpawnEntityFromTable( "info_zombie_spawn",
				{
					targetname	= "c5m5jeremy1",
					origin = "-11911.031250 6489.907226 501.521728",
					angles= "0 0 0",
					population	= "busstation"
				} );
			}

			if ( hndc5m5timer1!=null )
			{
				Msg("kill hndc5m5timer1\n");
				kill_entity(hndc5m5timer1);
				//EntFire( "jeremytimer1", "Kill")
				hndc5m5timer1=null;
			}

			if ( hndc5m5timer1==null)
			{	
				Msg("SpawnEntityFromTable hndc5m5timer1\n");	
				
				hndc5m5timer1 =SpawnEntityFromTable( "logic_timer",
				{
					targetname	= "jeremytimer1",
					//RefireTime	= user_intKillTimer,
					origin = "-11762 6341 457"
					StartDisabled	= 1,
					UseRandomTime	= 1,
					UpperRandomBound	= 1,
					spawnflags	= 0,
					LowerRandomBound	= 2,
					//origin = Vector(-11762,6341,459),
					connections =
					{
						OnTimer =
						{
							cmd1 = "c5m5jeremy1SpawnZombie0-1"
						}
					}
				} );
					
			}
			if ( hndc5m5timer2!=null )
			{
				Msg("kill hndc5m5timer2\n");	
				//kill_entity(hndc5m5timer2);
				EntFire( "jeremytimer2", "Kill")
				hndc5m5timer2=null;

			}

			if ( hndc5m5timer2==null)
			{		
				Msg("SpawnEntityFromTable hndc5m5timer2\n");	
				hndc5m5timer2=SpawnEntityFromTable( "logic_timer",
				{
					targetname	= "jeremytimer2",
					//RefireTime	= user_intKillTimer,
					origin = "-11762 6341 459"
					StartDisabled	= 1,
					UseRandomTime	= 1,
					UpperRandomBound	= 1,
					spawnflags	= 0,
					LowerRandomBound	= 2,
					//origin = Vector(-11762,6341,459),
					connections =
					{
						OnTimer =
						{
							cmd1 = "c5m5jeremy1SpawnZombie0-1"
						}
					}
				} );
			}



			if ( hndc5m5timer1!=null )
			{
				Msg("start the timer c5m5timer1\n");		
				// start the timer c5m5timer1
				//EntFireByHandle(handle target, string action, string value, float delay, handle activator, handle caller)
				EntFire( "jeremytimer1", "Enable")
				//c5m5timer1.Destroy()
			}
				
			if ( hndc5m5timer2!=null )
			{
					
				Msg("start the timer c5m5timer2\n");		
				// start the timer c5m5timer2
				//DoEntFire(string target, string action, string value, float delay, handle activator, handle caller)
				DoEntFire( "jeremytimer2", "Enable", "", 0, null, null )
				//c5m5timer1.Destroy()
			}
				
		}
		break;
	}
	case "c6m1_riverbank":
	case "c6m2_bedlam":
	case "c6m3_port":
	case "c7m1_docks":
	case "c7m2_barge":
	case "c7m3_port":
	case "c8m1_apartment":
	case "c8m2_subway":
	case "c8m3_sewers":
	case "c8m4_interior":
	case "c8m5_rooftop":
	{	
		if (nowLocalScriptExec==0)
		{
			nowLocalScriptExec++;
			Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
			//-----------------------------------------------------
			//
			//
			//-----------------------------------------------------
			Msg("Initiating c8m5_rooftop_finale script\n");

			//-----------------------------------------------------
			ERROR		<- -1
			PANIC 		<- 0
			TANK 		<- 1
			DELAY 		<- 2
			SCRIPTED 	<- 3
			//-----------------------------------------------------

			StageDelay <- 0
			PreEscapeDelay <- 0
			if ( Director.GetGameModeBase() == "coop" || Director.GetGameModeBase() == "realism" )
			{
				StageDelay <- 5
				PreEscapeDelay <- 5
			}
			else if ( Director.GetGameModeBase() == "versus" )
			{
				StageDelay <- 10
				PreEscapeDelay <- 15
			}

			DirectorOptions <-
			{	
				A_CustomFinale_StageCount = 8
				
				A_CustomFinale1 		= PANIC
				A_CustomFinaleValue1 	= 2
				A_CustomFinale2 		= DELAY
				A_CustomFinaleValue2 	= StageDelay
				A_CustomFinale3 		= TANK
				A_CustomFinaleValue3 	= 1
				A_CustomFinale4 		= DELAY
				A_CustomFinaleValue4 	= StageDelay
				A_CustomFinale5 		= PANIC
				A_CustomFinaleValue5 	= 2
				A_CustomFinaleMusic5 	= "Event.FinaleWave4"
				A_CustomFinale6 		= DELAY
				A_CustomFinaleValue6 	= StageDelay
				A_CustomFinale7 		= TANK
				A_CustomFinaleValue7 	= 1
				A_CustomFinale8 		= DELAY
				A_CustomFinaleValue8 	= PreEscapeDelay
				
					
				//Finales Options
				IntensityRelaxThreshold = 0.97		
				PausePanicWhenRelaxing	= true
				//The amount of total infected spawned during a panic event
				MegaMobSize=50
				//The Panic should end when we finish with Specials, not wait for the MegaMob.
				PanicSpecialsOnly=true
				PanicWavePauseMax=60
				PanicWavePauseMin=60
				//The minimum amount of time a SCRIPTED stage is allowed to run before ending.
				MinimumStageTime =30
				EscapeSpawnTanks =true
				HordeEscapeCommonLimit		=	25		//was 25
				PreferredMobDirection		=	SPAWN_LARGE_VOLUME
				PreferredSpecialDirection	=	SPAWN_LARGE_VOLUME
				ShouldConstrainLargeVolumeSpawn	=	false
				//Other Finale
				ShouldAllowSpecialsWithTank = true
				MobMinSize					=	15
				MobMaxSize					=	35
				MobRechargeRate				=	15
				CommonLimit		=	45	
				ZombieSpawnRange			=	3000
				SpecialRespawnInterval		=	15
				BileMobSize					=	15
				ProhibitBosses				=	false
				MusicDynamicMobSpawnSize	=	8
				MusicDynamicMobStopSize		=	2
				MusicDynamicMobScanStopSize	=	1
				TankLimit					=	5
				WitchLimit					=	1	
		
			}

			function EnableEscapeTanks()
			{
				printl( "Chase Tanks Enabled!" );
				
				MapScript.DirectorOptions.EscapeSpawnTanks <- true
			}

			function OnBeginCustomFinaleStage( num, type )
			{
				//printl( "Beginning custom finale stage " + num + " of type " + type );				
				nowFinaleStageNum=num
				nowFinaleStageType=type
				nowFinaleStageEvent=1
				if ( type == 2 )
					EntFire( "pilot", "SpeakResponseConcept", "hospital_radio_intransit" );
			}
		}
		break;
	}
	case "c9m1_alleys":
	{	
		if (nowLocalScriptExec==0)
		{
			nowLocalScriptExec++;
			Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
		}
		break;
	}
	case "c9m2_lots":
	{	
		if (nowLocalScriptExec==0)
		{
			nowLocalScriptExec++;
			Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
			//-----------------------------------------------------
			//
			//
			//-----------------------------------------------------
			Msg("Initiating c9m2_lots_finale script\n");

			//-----------------------------------------------------
			ERROR		<- -1
			PANIC 		<- 0
			TANK 		<- 1
			DELAY 		<- 2
			SCRIPTED 	<- 3
			//-----------------------------------------------------

			StageDelay <- 0
			PreEscapeDelay <- 0
			if ( Director.GetGameModeBase() == "coop" || Director.GetGameModeBase() == "realism" )
			{
				StageDelay <- 5
				PreEscapeDelay <- 5
			}
			else if ( Director.GetGameModeBase() == "versus" )
			{
				StageDelay <- 10
				PreEscapeDelay <- 15
			}

			DirectorOptions <-
			{	
				A_CustomFinale_StageCount = 8
				
				A_CustomFinale1 		= PANIC
				A_CustomFinaleValue1 	= 2
				A_CustomFinale2 		= DELAY
				A_CustomFinaleValue2 	= StageDelay
				A_CustomFinale3 		= TANK
				A_CustomFinaleValue3 	= 1
				A_CustomFinale4 		= DELAY
				A_CustomFinaleValue4 	= StageDelay
				A_CustomFinale5 		= PANIC
				A_CustomFinaleValue5 	= 2
				A_CustomFinaleMusic5 	= "Event.FinaleWave4"
				A_CustomFinale6 		= DELAY
				A_CustomFinaleValue6 	= StageDelay
				A_CustomFinale7 		= TANK
				A_CustomFinaleValue7 	= 1
				A_CustomFinale8 		= DELAY
				A_CustomFinaleValue8 	= PreEscapeDelay
				
				TankLimit = 1
				WitchLimit = 0
				CommonLimit = 20
				HordeEscapeCommonLimit = 15
				EscapeSpawnTanks = false
				//SpecialRespawnInterval = 80
				
				MusicDynamicMobSpawnSize = 8
				MusicDynamicMobStopSize = 2
				MusicDynamicMobScanStopSize = 1
			}

			function EnableEscapeTanks()
			{
				printl( "Chase Tanks Enabled!" );
				
				MapScript.DirectorOptions.EscapeSpawnTanks <- true
			}
			function OnBeginCustomFinaleStage( num, type )
			{
				nowFinaleStageNum = num
				nowFinaleStageType=type
				nowFinaleStageEvent=1
			}
		}
		break;
	}
	case "c10m1_caves":
	case "c10m2_drainage":
	case "c10m3_ranchhouse":
	case "c10m4_mainstreet":
	case "c10m5_houseboat":
	{	
		if (nowLocalScriptExec==0)
		{
			nowLocalScriptExec++;
			Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
			//-----------------------------------------------------
			//
			//
			//-----------------------------------------------------
			Msg("Initiating c10m5_houseboat_finale script\n");

			MutationState <-
			{
				HUDWaveInfo = true           // do you want the Wave # in middle of UI
				HUDRescueTimer = false       // or would you rather have the rescue timer (cant have both)
				HUDTickerText = "Holdout as long as you can"
				RescueStarted = false
				RawStageNum = -1
				ForcedEscapeStage = -1
				ScriptedStageWave = 0
				CooldownEndWarningTime = 8.5 // seconds before end of cooldown to play warning
				CooldownEndWarningChance = 15 // percent chance to play warning
				CooldownEndWarningFrequency = 0 // how many waves to wait before playing another warning
				LastWaveCooldownWarningPlayed = -1 // the last wave that the cooldown warning played on
			}

			MapState <-
			{
				InitialResources = 0
				HUDWaveInfo = true
				HUDRescueTimer = false
				HUDTickerText = "Objective: Hold out for 10 waves and then get to the chopper!  Use the radio to start."
				StartActive = true
				
				ForcedEscapeStage = 28

				CooldownEndWarningChance = 100 // crank up the chance of playing the end of wave warning
			}
			
			//-----------------------------------------------------
			ERROR		<- -1
			PANIC 		<- 0
			TANK 		<- 1
			DELAY 		<- 2
			SCRIPTED 	<- 3
			//-----------------------------------------------------

			StageDelay <- 0
			PreEscapeDelay <- 0
			if ( Director.GetGameModeBase() == "coop" || Director.GetGameModeBase() == "realism" )
			{
				StageDelay <- 5
				PreEscapeDelay <- 5
			}
			else if ( Director.GetGameModeBase() == "versus" )
			{
				StageDelay <- 10
				PreEscapeDelay <- 15
			}

			DirectorOptions <-
			{	
				A_CustomFinale_StageCount = 8
				
				A_CustomFinale1 		= PANIC
				A_CustomFinaleValue1 	= 2
				A_CustomFinale2 		= DELAY
				A_CustomFinaleValue2 	= StageDelay
				A_CustomFinale3 		= TANK
				A_CustomFinaleValue3 	= 1
				A_CustomFinale4 		= DELAY
				A_CustomFinaleValue4 	= StageDelay
				A_CustomFinale5 		= PANIC
				A_CustomFinaleValue5 	= 2
				A_CustomFinaleMusic5 	= "Event.FinaleWave4"
				A_CustomFinale6 		= DELAY
				A_CustomFinaleValue6 	= StageDelay
				A_CustomFinale7 		= TANK
				A_CustomFinaleValue7 	= 1
				A_CustomFinale8 		= DELAY
				A_CustomFinaleValue8 	= PreEscapeDelay
				
				TankLimit = 1
				WitchLimit = 0
				CommonLimit = 20
				HordeEscapeCommonLimit = 15
				EscapeSpawnTanks = false
				//SpecialRespawnInterval = 80
				
				MusicDynamicMobSpawnSize = 8
				MusicDynamicMobStopSize = 2
				MusicDynamicMobScanStopSize = 1
			}

			function EnableEscapeTanks()
			{
				printl( "Chase Tanks Enabled!" );
				
				MapScript.DirectorOptions.EscapeSpawnTanks <- true
			}

			function OnBeginCustomFinaleStage( num, type )
			{
				//printl( "Beginning custom finale stage " + num + " of type " + type );
				
				nowFinaleStageNum = num
				nowFinaleStageType=type
				nowFinaleStageEvent=1
				if ( type == 2 )
					EntFire( "orator_boat_radio", "SpeakResponseConcept", "boat_radio_intransit" );
			}
			
			
		}
		break;
	}
	case "c11m1_greenhouse":
	case "c11m2_offices":
	case "c11m3_garage":
	case "c11m4_terminal":
	case "c11m5_runway":
	{	
		if (nowLocalScriptExec==0)
		{
			nowLocalScriptExec++;
			Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
			//-----------------------------------------------------
			//
			//
			//-----------------------------------------------------
			Msg("Initiating c11m5_runway_finale script\n");

			//-----------------------------------------------------
			ERROR		<- -1
			PANIC 		<- 0
			TANK 		<- 1
			DELAY 		<- 2
			SCRIPTED 	<- 3
			//-----------------------------------------------------

			StageDelay <- 0
			PreEscapeDelay <- 0
			if ( Director.GetGameModeBase() == "coop" || Director.GetGameModeBase() == "realism" )
			{
				StageDelay <- 5
				PreEscapeDelay <- 5
			}
			else if ( Director.GetGameModeBase() == "versus" )
			{
				StageDelay <- 10
				PreEscapeDelay <- 15
			}

			DirectorOptions <-
			{	
				A_CustomFinale_StageCount = 8
				
				A_CustomFinale1 		= PANIC
				A_CustomFinaleValue1 	= 2
				A_CustomFinale2 		= DELAY
				A_CustomFinaleValue2 	= StageDelay
				A_CustomFinale3 		= TANK
				A_CustomFinaleValue3 	= 1
				A_CustomFinale4 		= DELAY
				A_CustomFinaleValue4 	= StageDelay
				A_CustomFinale5 		= PANIC
				A_CustomFinaleValue5 	= 2
				A_CustomFinaleMusic5 	= "Event.FinaleWave4"
				A_CustomFinale6 		= DELAY
				A_CustomFinaleValue6 	= StageDelay
				A_CustomFinale7 		= TANK
				A_CustomFinaleValue7 	= 1
				A_CustomFinale8 		= DELAY
				A_CustomFinaleValue8 	= PreEscapeDelay
				
					
				//Finales Options
				IntensityRelaxThreshold = 0.97		
				PausePanicWhenRelaxing	= true
				//The amount of total infected spawned during a panic event
				MegaMobSize=50
				//The Panic should end when we finish with Specials, not wait for the MegaMob.
				PanicSpecialsOnly=true
				PanicWavePauseMax=60
				PanicWavePauseMin=60
				//The minimum amount of time a SCRIPTED stage is allowed to run before ending.
				MinimumStageTime =30
				EscapeSpawnTanks =true
				HordeEscapeCommonLimit		=	25		//was 25
				PreferredMobDirection		=	SPAWN_LARGE_VOLUME
				PreferredSpecialDirection	=	SPAWN_LARGE_VOLUME
				ShouldConstrainLargeVolumeSpawn	=	false
				//Other Finale
				ShouldAllowSpecialsWithTank = true
				MobMinSize					=	15
				MobMaxSize					=	35
				MobRechargeRate				=	15
				CommonLimit		=	45	
				ZombieSpawnRange			=	3000
				SpecialRespawnInterval		=	15
				BileMobSize					=	15
				ProhibitBosses				=	false
				MusicDynamicMobSpawnSize	=	8
				MusicDynamicMobStopSize		=	2
				MusicDynamicMobScanStopSize	=	1
				TankLimit					=	5
				WitchLimit					=	1	
		
				
			}

			function EnableEscapeTanks()
			{
				printl( "Chase Tanks Enabled!" );
				
				MapScript.DirectorOptions.EscapeSpawnTanks <- true
			}

			function OnBeginCustomFinaleStage( num, type )
			{
				//printl( "Beginning custom finale stage " + num + " of type " + type );			
				nowFinaleStageNum=num
				nowFinaleStageType=type
				nowFinaleStageEvent=1
				
				if ( type == 2 )
					EntFire( "orator_plane_radio", "SpeakResponseConcept", "plane_radio_intransit" );
			}
		}
		break;
	}
	case "c12m1_hilltop":
	case "c12m2_traintunnel":
	case "c12m3_bridge":
	case "c12m4_barn":
	case "c12m5_cornfield":
	case "C12m1_hilltop":
	case "C12m2_traintunnel":
	case "C12m3_bridge":
	case "C12m4_barn":
	case "C12m5_cornfield":
	{	
		if (nowLocalScriptExec==0)
		{
			nowLocalScriptExec++;
			Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
			//-----------------------------------------------------
			//
			//
			//-----------------------------------------------------
			Msg("Initiating c12m5_cornfield_finale script\n");

			//-----------------------------------------------------
			ERROR		<- -1
			PANIC 		<- 0
			TANK 		<- 1
			DELAY 		<- 2
			SCRIPTED 	<- 3
			//-----------------------------------------------------

			StageDelay <- 0
			PreEscapeDelay <- 0
			if ( Director.GetGameModeBase() == "coop" || Director.GetGameModeBase() == "realism" )
			{
				StageDelay <- 5
				PreEscapeDelay <- 5
			}
			else if ( Director.GetGameModeBase() == "versus" )
			{
				StageDelay <- 10
				PreEscapeDelay <- 15
			}

			DirectorOptions <-
			{	
				A_CustomFinale_StageCount = 8
				
				A_CustomFinale1 		= PANIC
				A_CustomFinaleValue1 	= 2
				A_CustomFinale2 		= DELAY
				A_CustomFinaleValue2 	= StageDelay
				A_CustomFinale3 		= TANK
				A_CustomFinaleValue3 	= 1
				A_CustomFinale4 		= DELAY
				A_CustomFinaleValue4 	= StageDelay
				A_CustomFinale5 		= PANIC
				A_CustomFinaleValue5 	= 2
				A_CustomFinaleMusic5 	= "Event.FinaleWave4"
				A_CustomFinale6 		= DELAY
				A_CustomFinaleValue6 	= StageDelay
				A_CustomFinale7 		= TANK
				A_CustomFinaleValue7 	= 1
				A_CustomFinale8 		= DELAY
				A_CustomFinaleValue8 	= PreEscapeDelay
				
				TankLimit = 1
				WitchLimit = 0
				CommonLimit = 20
				HordeEscapeCommonLimit = 15
				EscapeSpawnTanks = false
				//SpecialRespawnInterval = 80
				
				MusicDynamicMobSpawnSize = 8
				MusicDynamicMobStopSize = 2
				MusicDynamicMobScanStopSize = 1
			}

			function EnableEscapeTanks()
			{
				printl( "Chase Tanks Enabled!" );
				
				MapScript.DirectorOptions.EscapeSpawnTanks <- true
			}

			function OnBeginCustomFinaleStage( num, type )
			{
				//printl( "Beginning custom finale stage " + num + " of type " + type );				
				nowFinaleStageNum = num
				nowFinaleStageType=type
				nowFinaleStageEvent=1
				if ( type == 2 )
					EntFire( "orator_farm_radio", "SpeakResponseConcept", "farm_radio_intransit" );
			}
		}
		break;
	}
	default:
		break;
}

Msg("Loaded: amap.nut\n");