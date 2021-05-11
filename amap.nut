//Title: The Alternate Difficulties Mod (TADM)
//Author Steam Alias: jetSetWilly II
//Author URL: https://steamcommunity.com/id/jetsetwillyuncensored/
//Version: 2.5
//Programming Language: VScript
//File Description: This is a control file that selects map specific files used by TADM


::DirectorScript.MapScript.LocalScript.DirectorOptions <-
{
}
//implemented
/*
c1m1_hotel
c1m2_streets
c2m5_concert
c5m5_bridge
c8m5_rooftop
c11m5_runway

3 scavenge
c1m4_atrium
c6m3_port
c7m3_port
*/

::AddTableToTable <- function( dest, src )
{
	foreach( key, val in src )
	{
		dest[key] <- val
	}
}

::defineDirectorOptions <- function( DirectorOptions )
{	
	DirectorScript.MapScript.LocalScript.DirectorOptions.clear();
	AddTableToTable( DirectorScript.MapScript.LocalScript.DirectorOptions, DirectorOptions );
}
::c1m1_hotel_sky_event <- function()			
{
	local execscriptName="sky_event";
	aMapLogic(execscriptName);
}
::c1m1_hotel_C1m1_reserved_wanderers <- function()			
{
	local execscriptName="C1m1_reserved_wanderers";
	aMapLogic(execscriptName);
}

::c1m2_streets_C1M2_reserved_wanderers <- function()			
{
	local execscriptName="C1M2_reserved_wanderers";
	aMapLogic(execscriptName);
}

::c1m2_streets_C1_gunshop_onslaught <- function()			
{
	local execscriptName="C1_gunshop_onslaught";
	aMapLogic(execscriptName);
}

::c1m2_streets_C1_gunshop_quiet <- function()			
{
	local execscriptName="C1_gunshop_quiet";
	aMapLogic(execscriptName);
}

::c1m2_streets_C1_streets_ambush <- function()			
{
	local execscriptName="C1_streets_ambush";
	aMapLogic(execscriptName);
}

::c2m1_highway_C2_highway_ambush <- function()			
{
	local execscriptName="C2_highway_ambush";
	aMapLogic(execscriptName);
}
::sky_events_in_any_where<- function()			
{
	local execscriptName="sky_events_in_any_where";
	aScriptLogic(execscriptName);
}
::sky_events_in_front <- function()			
{
	local execscriptName="sky_events_in_front";
	aScriptLogic(execscriptName);
}

::sky_events_silent<- function()			
{
	local execscriptName="sky_events_silent";
	aScriptLogic(execscriptName);
}

::sky_scavenge_cans_cvars<- function()			
{
	local execscriptName="sky_scavenge_cans_cvars";
	aScriptLogic(execscriptName);
}


Msg("................................................ amap invoked\n");
Msg("................................................ " + g_MapName + "\n");
Msg("..............................nowexecScriptName: " + nowexecScriptName + "\n");
Msg(".............................nowLocalScriptExec: " + nowLocalScriptExec + "\n");

if ( (developer() > 0) || (DEBUG == 1))
{
	local mensaje = "amap invoked";
	ClientPrint(null, 3, BLUE+mensaje);
}
::aMapLogic <- function(execscriptName)			
{
Msg("................................................ aMapLogic\n");
Msg(".................................execscriptName: " + execscriptName + "\n");
	switch (g_MapName)
	{
		case "c1m1_hotel":
		{
			switch (execscriptName)
			{
				case "C1m1_reserved_wanderers":
				{
					Msg("Replacing c1m1_reserved_wanderers\n");
					Msg("Initiating Reserved Wanderers\n");

					//nowWanderingPermit=true;
					// nowinScriptfromaMap=true;					
					// g_MapScript.DirectorOptions.clear();
					// DirectorOptions <-
					// {
						// AlwaysAllowWanderers = true
						// NumReservedWanderers = 5
						// ProhibitBosses = true
					// }
					// AddTableToTable( g_MapScript.DirectorOptions, DirectorOptions );

					// DirectorOptions <-
					// {
						// AlwaysAllowWanderers = true
						// NumReservedWanderers = 5
						// ProhibitBosses = true
					// }
					// defineDirectorOptions( DirectorOptions );
					
					Msg("Initiating relay buttons timers\n");

					local buttonelevRelaytop = Entities.FindByName( null, "relay_top_button" ) 

					local buttonelevRelaybot = Entities.FindByName( null, "relay_elevator_reached_bottom" ) 


					local hndc5m5timer1 = Entities.FindByName( null, "customtimer1" ) 
					local hndc5m5timer2 = Entities.FindByName( null, "customtimer2" ) 

					local hndzombie1 = Entities.FindByName( null, "c1m1zombiespawncustom1" ) 

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
						entbuttonelevRelaytop.AddOutput("OnTrigger", "customtimer1", "Enable", "", 0.0, -1 );
						entbuttonelevRelaytop.AddOutput("OnTrigger", "customtimer2", "Enable", "", 0.0, -1 );	
						//DoEntFire("!self", "AddOutput", "OnTrigger customtimer1:Enable::0:-1", 0.0, null, entbuttonelevRelaytop);
						//DoEntFire("!self", "AddOutput", "OnTrigger customtimer2:Enable::0:-1", 0.0, null, entbuttonelevRelaytop);
						//ALTERNATIVA
						//DoEntFire( "entbuttonelevRelaytop", "AddOutput", "OnTrigger customtimer1:Enable::0:-1", 0.0, null, null);
						//DoEntFire( "entbuttonelevRelaytop", "AddOutput", "OnTrigger customtimer2:Enable::0:-1", 0.0, null, null);
					}
					if ( buttonelevRelaybot!=null )
					{
						Msg("mod the buttonelevRelaybot\n");		
						local entbuttonelevRelaybot = ::VSLib.Entity(buttonelevRelaybot);
						entbuttonelevRelaybot.AddOutput("OnTrigger", "customtimer1", "Disable", "", 10.0, -1 )
						entbuttonelevRelaybot.AddOutput("OnTrigger", "customtimer2", "Disable", "", 10.0, -1 )
						//entbuttonelevRelaybot.RemoveOutput("OnTrigger", "customtimer1", "Disable", "");
						//entbuttonelevRelaybot.RemoveOutput("OnTrigger", "customtimer2", "Disable", "");		
						//DoEntFire("!self", "AddOutput", "OnTrigger customtimer1:Disable::0:-1", 0.0, null, entbuttonelevRelaybot);
						//DoEntFire("!self", "AddOutput", "OnTrigger customtimer2:Disable::0:-1", 0.0, null, entbuttonelevRelaybot);
					}
					
									
					// {
						// "classname" "trigger_multiple"
						// "targetname" "sky_trigger_block"
						// "filtername" "sky_filter_survs2"
						// "spawnflags" "1"
						// "StartDisabled" "0"
						// "origin" "2154 5666 2468"
						// "OnEntireTeamStartTouch" "sky_elevator_buttonUnlock0-1"
						// "OnEntireTeamEndTouch" "sky_elevator_buttonLock0-1"
					// }
					break;
				}
				case "sky_event":
				{
					Msg("sky_event_c1m1_hotel.nut\n");
					Msg("Initiating Sky Elevator Event \n");					
					nowWanderingPermit=false;
					Timers.AddTimer(33,false,setTimerFlag,nowWanderingPermit);
					//Director.ResetMobTimer() // Sets the mob spawn timer to 0.
					//Director.PlayMegaMobWarningSounds() // Plays the incoming mob sound effect.
					//L 04/30/2021 - 15:41:57: 57.29: (MOB) SpawnMob requested of size 36.
					//Director.ResetMobTimer()
					Utils.ForcePanicEvent();
					//EntFire( "director", "PanicEvent", 0 )
					//Timers.AddTimer( 5.0, true, SpawnTank);					
					local alarma = Entities.FindByName( null, "sound_alarm" );
					local elevss = Entities.FindByName( null, "elevator_stuck_sound" );
					local puerta = null;
					local puertavslibent= null;
					while ( puerta = Entities.FindByName( puerta, "elevator_1_doors_shadow" ) )
					{
						if ( puerta.IsValid() )
						{
							DoEntFire( "!self", "StartGlowing", "", 0, null, puerta );
							DoEntFire( "!self", "StopGlowing", "", 33, null, puerta );
							puertavslibent= ::VSLib.Entity(puerta);
						}
					}
					Utils.SetEntityHint( puertavslibent, "Espera que llegue el ascensor", "icon_shield", 0, false, 33.0 );
					DoEntFire( "!self", "PlaySound", "", 0, null, alarma );
					DoEntFire( "!self", "FadeOut", "1", 32, null, alarma );
					DoEntFire( "!self", "PlaySound", "", 33, null, elevss );

					//DoEntFire("!self", "AddOutput", "OnTrigger customtimer1:Enable::0:-1", 0.0, null, entbuttonelevRelaytop);

					break;
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
			switch (execscriptName)
			{
				case "C1_gunshop_quiet":
				{
					Msg("C1_gunshop_quiet\n");
					nowCrescendoStarted=1;
					nowAntiRushAddRange=1000;
					mSHMfM=1.5;
					local id_ExplodeTanker = Entities.FindByName( null, "tanker_destroy_relay" );
					local ent_logic_relay_ExplodeTanker = ::VSLib.Entity(id_ExplodeTanker);
					ent_logic_relay_ExplodeTanker.AddOutput("OnTrigger", "worldspawn", "RunScriptCode", "closeARRange()", 0, -1 );
					
					DirectorOptions <-
					{
						// This turns off tanks and witches.
						ProhibitBosses = true

						PreferredMobDirection = SPAWN_BEHIND_SURVIVORS
						MobSpawnMinTime = 1
						MobSpawnMaxTime = 2
						MobMaxPending = 10
						//MobMinSize = 10
						//MobMaxSize = 20
						SustainPeakMinTime = 1
						SustainPeakMaxTime = 3
						IntensityRelaxThreshold = 0.90
						RelaxMinInterval = 5
						RelaxMaxInterval = 10
						RelaxMaxFlowTravel = 200
					}
					Director.ResetMobTimer();
					defineDirectorOptions( DirectorOptions );
					
					Utils.ForcePanicEvent();
					
					local mensaje = "Misión: Tienda de Armas";
					ShowHUDTicker(4,"Ad",mensaje);
					//ent_logic_relay_ExplodeTanker.AddOutput("OnTrigger", "@director", "runscriptcode", "DirectorScript.MapScript.LocalScript.GasCanTouched()", 0, -1 );
					//local tabladeentidad={};
					//ent_logic_relay_ExplodeTanker.GetOutputTable(tabladeentidad);			
					//foreach( key, value in ent_logic_relay_ExplodeTanker )
					//{
					//	Msg( "    " + key + " = " + value + "\n" );
					//}		
					//@directorrunscriptcodeDirectorScript.MapScript.LocalScript.GasCanTouched()0-1
					//DirectorOptions <-
					//{
						// This turns off tanks and witches.
					//	ProhibitBosses = false
					//	PreferredMobDirection = SPAWN_BEHIND_SURVIVORS
					//	PreferredSpecialDirection = SPAWN_SPECIALS_ANYWHERE
					//}
					//function GasCanTouched()
					//{
					//	local mensaje = "GasCanTouched";
					//	ShowHUDTicker(4,"Ad",mensaje)
					//}
					break;
				}			
				case "C1_gunshop_onslaught":
				{
					Msg("C1_gunshop_onslaught\n");
					Msg("Initiating Onslaught\n");

					DirectorOptions <-
					{
						// This turns off tanks and witches.
						ProhibitBosses = true

						PreferredMobDirection = SPAWN_BEHIND_SURVIVORS
						MobSpawnMinTime = 1
						MobSpawnMaxTime = 2
						MobMaxPending = 10
						//MobMinSize = 10
						//MobMaxSize = 20
						SustainPeakMinTime = 1
						SustainPeakMaxTime = 3
						IntensityRelaxThreshold = 0.90
						RelaxMinInterval = 5
						RelaxMaxInterval = 10
						RelaxMaxFlowTravel = 200
					}
					Director.ResetMobTimer();
					defineDirectorOptions( DirectorOptions );
					Utils.ForcePanicEvent();
					//Director.ResetMobTimer()
					//Director.PlayMegaMobWarningSounds()

					break;
				}				
				case "C1_streets_ambush":
				{			
					Msg("C1_streets_ambush\n");
					Msg("Initiating Ambush\n");
					local tempChargerLimit=2+1*nowPlayersinGame/4;
					
					//nowinScriptfromaMap=true;	
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
						SpitterLimit = 0
						JockeyLimit = 0
						LockTempo = false
						SpecialRespawnInterval = 30-1*nowPlayersinGame
						SpecialInitialSpawnDelayMin = 2
						SpecialInitialSpawnDelayMax = 6
						PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS	
						PreferredMobDirection =	SPAWN_IN_FRONT_OF_SURVIVORS
						ZombieSpawnRange=500
						MobSpawnMinTime = 1
						MobSpawnMaxTime = 2
						MobMaxPending = 10
						//MobMinSize = DirectorScript.MapScript.DirectorOptions.MobMinSize
						//MobMaxSize = 20+1*nowPlayersinGame
						SustainPeakMinTime = 1
						SustainPeakMaxTime = 3
						IntensityRelaxThreshold = 0.90
						RelaxMinInterval = 5
						RelaxMaxInterval = 10
						RelaxMaxFlowTravel = 200			
					}
					Director.ResetMobTimer();
					defineDirectorOptions( DirectorOptions );
					Utils.ForcePanicEvent();
					break;
				}
			}
			break;
		}
		case "c1m3_mall":
		case "c1m4_atrium":
		{	
			if (nowLocalScriptExec>0)
			{
				Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
				nowLocalScriptExec++;
				Msg("----------------------FINALE SCRIPT------------------\n")
				nowFinaleScavengeStarted=1
				//-----------------------------------------------------
				PANIC <- 0
				TANK <- 1
				DELAY <- 2
				ONSLAUGHT <- 3
				//-----------------------------------------------------

				SharedOptions <-
				{
					A_CustomFinale1 = ONSLAUGHT
					A_CustomFinaleValue1 = ""

					A_CustomFinale2 = PANIC
					A_CustomFinaleValue2 = 1

					A_CustomFinale3 = ONSLAUGHT
					A_CustomFinaleValue3 = "c1m4_delay"
					
					A_CustomFinale4 = PANIC
					A_CustomFinaleValue4 = 1

					A_CustomFinale5 = ONSLAUGHT
					A_CustomFinaleValue5 = "c1m4_delay"

					A_CustomFinale6 = TANK
					A_CustomFinaleValue6 = 1

					A_CustomFinale7 = ONSLAUGHT
					A_CustomFinaleValue7 = "c1m4_delay"
				 
					A_CustomFinale8 = PANIC
					A_CustomFinaleValue8 = 1

					A_CustomFinale9 = ONSLAUGHT
					A_CustomFinaleValue9 = "c1m4_delay"
				 
					A_CustomFinale10 = PANIC
					A_CustomFinaleValue10 = 1

					A_CustomFinale11 = ONSLAUGHT
					A_CustomFinaleValue11 = "c1m4_delay"

					A_CustomFinale12 = PANIC
					A_CustomFinaleValue12 = 1
					
					A_CustomFinale13 = ONSLAUGHT
					A_CustomFinaleValue13 = "c1m4_delay"
					
					A_CustomFinale14 = TANK
					A_CustomFinaleValue14 = 1   
					
					A_CustomFinale15 = ONSLAUGHT
					A_CustomFinaleValue15 = "c1m4_delay"
					
					A_CustomFinale16 = PANIC
					A_CustomFinaleValue16 = 1  
					
					A_CustomFinale17 = ONSLAUGHT
					A_CustomFinaleValue17 = "c1m4_delay"    
					
					A_CustomFinale18 = PANIC
					A_CustomFinaleValue18 = 1  
					
					A_CustomFinale19 = ONSLAUGHT
					A_CustomFinaleValue19 = "c1m4_delay"
					
					A_CustomFinale20 = PANIC
					A_CustomFinaleValue20 = 1   
					
					A_CustomFinale21 = ONSLAUGHT
					A_CustomFinaleValue21 = "c1m4_delay"
					
					A_CustomFinale22 = TANK
					A_CustomFinaleValue22 = 1  
					
					A_CustomFinale23 = ONSLAUGHT
					A_CustomFinaleValue23 = "c1m4_delay"    
					
					A_CustomFinale24 = PANIC
					A_CustomFinaleValue24 = 1
					
					A_CustomFinale25 = ONSLAUGHT
					A_CustomFinaleValue25 = "c1m4_delay"
					
					A_CustomFinale26 = PANIC
					A_CustomFinaleValue26 = 1   
					
					A_CustomFinale27 = ONSLAUGHT
					A_CustomFinaleValue27 = "c1m4_delay"
					
					A_CustomFinale28 = PANIC
					A_CustomFinaleValue28 = 1  
					
					A_CustomFinale29 = ONSLAUGHT
					A_CustomFinaleValue29 = "c1m4_delay"    
					
					A_CustomFinale30 = PANIC
					A_CustomFinaleValue30 = 1

					A_CustomFinale31 = ONSLAUGHT
					A_CustomFinaleValue31 = "c1m4_delay"   
					
					//-----------------------------------------------------

					PreferredMobDirection = SPAWN_LARGE_VOLUME
					PreferredSpecialDirection = SPAWN_LARGE_VOLUME
					
				//	BoomerLimit = 0
				//	SmokerLimit = 2
				//	HunterLimit = 1
				//	SpitterLimit = 1
				//	JockeyLimit = 0
				//	ChargerLimit = 1

					ProhibitBosses = true
					ZombieSpawnRange = 3000
					MobRechargeRate = 0.5
					HordeEscapeCommonLimit = 15
					BileMobSize = 15
					
					MusicDynamicMobSpawnSize = 8
					MusicDynamicMobStopSize = 2
					MusicDynamicMobScanStopSize = 1
				} 

				InitialOnslaughtOptions <-
				{
					LockTempo = 0
					IntensityRelaxThreshold = 1.1
					RelaxMinInterval = 2
					RelaxMaxInterval = 4
					SustainPeakMinTime = 25
					SustainPeakMaxTime = 30
					
					MobSpawnMinTime = 4
					MobSpawnMaxTime = 8
					MobMinSize = 2
					MobMaxSize = 6
					CommonLimit = 5
					
					SpecialRespawnInterval = 100
				}

				PanicOptions <-
				{
					MegaMobSize = 0 // randomized in OnBeginCustomFinaleStage
					MegaMobMinSize = 20
					MegaMobMaxSize = 40
					
					CommonLimit = 15
					
					SpecialRespawnInterval = 40
				}

				TankOptions <-
				{
					ShouldAllowMobsWithTank = true
					ShouldAllowSpecialsWithTank = true

					MobSpawnMinTime = 10
					MobSpawnMaxTime = 20
					MobMinSize = 3
					MobMaxSize = 5

					CommonLimit = 7
					
					SpecialRespawnInterval = 60
				}


				DirectorOptions <- clone SharedOptions
				{
				}


				//-----------------------------------------------------

				// number of cans needed to escape.
				gascansCalculate(null);
				NumCansNeeded <- nowNumCansNeeded
				//NumCansNeeded <- 13

				// fewer cans in single player since bots don't help much
				//if ( Director.IsSinglePlayerGame() )
				//{
				//	NumCansNeeded <- 8
				//}

				// duration of delay stage.
				DelayMin <- 10
				DelayMax <- 20

				// Number of touches and/or pours allowed before a delay is aborted.
				DelayPourThreshold <- 1
				DelayTouchedOrPouredThreshold <- 2


				// Once the delay is aborted, amount of time before it progresses to next stage.
				AbortDelayMin <- 1
				AbortDelayMax <- 3

				// Number of touches and pours it takes to transition out of c1m4_finale_wave_1
				GimmeThreshold <- 4


				// console overrides
				//if ( Director.IsPlayingOnConsole() )
				//{
				DelayMin <- 20
				DelayMax <- 30
				
				// Number of touches and/or pours allowed before a delay is aborted.
				DelayPourThreshold <- 2
				DelayTouchedOrPouredThreshold <- 4
				
				//TankOptions.ShouldAllowSpecialsWithTank = false
				//}
				//-----------------------------------------------------
				//      INIT
				//-----------------------------------------------------

				GasCansTouched          <- 0
				GasCansPoured           <- 0
				DelayTouchedOrPoured    <- 0
				DelayPoured             <- 0

				EntFire( "timer_delay_end", "LowerRandomBound", DelayMin )
				EntFire( "timer_delay_end", "UpperRandomBound", DelayMax )
				EntFire( "timer_delay_abort", "LowerRandomBound", AbortDelayMin )
				EntFire( "timer_delay_abort", "UpperRandomBound", AbortDelayMax )

				// this is too late. Moved to c1m4_atrium.nut
				//EntFire( "progress_display", "SetTotalItems", NumCansNeeded )

				function AbortDelay(){}  	// only defined during a delay, in c1m4_delay.nut
				function EndDelay(){}		// only defined during a delay, in c1m4_delay.nut

				NavMesh.UnblockRescueVehicleNav()

				//-----------------------------------------------------

				function GasCanTouched()
				{
					GasCansTouched++
					Msg(" Touched: " + GasCansTouched + "\n")   
					 
					EvalGasCansPouredOrTouched()
				}

				function GasCanPoured()
				{
					GasCansPoured++
					DelayPoured++
					Msg(" Poured: " + GasCansPoured + "\n")   

					if ( GasCansPoured == NumCansNeeded )
					{
						Msg("car ready\n") 
						EntFire( "relay_car_ready", "trigger" )
					}

					EvalGasCansPouredOrTouched()
				}

				function EvalGasCansPouredOrTouched()
				{
					TouchedOrPoured <- GasCansPoured + GasCansTouched
					Msg(" Poured or touched: " + TouchedOrPoured + "\n")
					Msg(" needed: " + NumCansNeeded + "\n") 

					DelayTouchedOrPoured++
					Msg(" DelayTouchedOrPoured: " + DelayTouchedOrPoured + "\n")
					Msg(" DelayPoured: " + DelayPoured + "\n")
					
					if (( DelayTouchedOrPoured >= DelayTouchedOrPouredThreshold ) || ( DelayPoured >= DelayPourThreshold ))
					{
						AbortDelay()
					}
					
					switch( TouchedOrPoured )
					{
						case GimmeThreshold:
							Msg(" TouchedOrPoured: GimmeThreshold = " + GimmeThreshold + "\n")
							EntFire( "@director", "EndCustomScriptedStage" )
							break
					}
				}
				//-----------------------------------------------------

				// function AddTableToTable( dest, src )
				// {
					// foreach( key, val in src )
					// {
						// dest[key] <- val
					// }
				// }

				function OnBeginCustomFinaleStage( num, type )
				{
					printl( "Beginning custom finale stage " + num + " of type " + type );
					
					local waveOptions = null
					if ( num == 1 )
					{
						waveOptions = InitialOnslaughtOptions
					}
					else if ( type == PANIC )
					{
						waveOptions = PanicOptions
						waveOptions.MegaMobSize = PanicOptions.MegaMobMinSize + rand()%( PanicOptions.MegaMobMaxSize - PanicOptions.MegaMobMinSize )
						
						Msg("*************************" + waveOptions.MegaMobSize + "\n")
						
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
					
					
					Director.ResetMobTimer()
					
				}

				//-----------------------------------------------------


				if ( Director.GetGameModeBase() == "versus" )
				{
					SharedOptions.ProhibitBosses = false
				}
				if (nowNumCansNeeded>13)
					mapgasScanSpawnerSpawner();
			}
			if (nowLocalScriptExec==0)
			{
				Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
				nowLocalScriptExec++;
				Msg("c1m4_atrium\n");
							
				Msg(" atrium map script "+"\n")

				// number of cans needed to escape.
				Timers.AddTimer(15, false, gascansCalculate, null);

				NavMesh.UnblockRescueVehicleNav()



				function GasCanPoured(){}
			}
			break;
		}
		case "c2m1_highway":
		{
			switch (execscriptName)
			{
				case "C2_highway_ambush":
				{
					Msg( "C2_highway_ambush\n" );					
					DirectorOptions <-
					{
						// This turns off tanks and witches.
						//ProhibitBosses = false

						BoomerLimit = 0
						SmokerLimit = 3
						HunterLimit = 1
						ChargerLimit = 1
						SpitterLimit = 0
						JockeyLimit = 1
					}
					Director.ResetMobTimer();
					defineDirectorOptions( DirectorOptions );
					Utils.ForcePanicEvent();
				
				}
				default:
				break;
			}
			break;
		}
		case "c2m2_fairgrounds":
		case "c2m3_coaster":
		case "c2m4_barns":
		case "c2m5_concert":
		{
			if (nowLocalScriptExec==0)
			{
				Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
				nowLocalScriptExec++;
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

				// function AddTableToTable( dest, src )
				// {
					// foreach( key, val in src )
					// {
						// dest[key] <- val
					// }
				// }

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
				Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
				nowLocalScriptExec++;		
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
					 A_CustomFinaleValue2 = 30-1*nowPlayersinGame
					 
					 A_CustomFinale3 = TANK
					 A_CustomFinaleValue3 = 1
					 
					 A_CustomFinale4 = DELAY
					 A_CustomFinaleValue4 = 30-1*nowPlayersinGame
					 
					 A_CustomFinale5 = PANIC
					 A_CustomFinaleValue5 = 2
					 
					 A_CustomFinale6 = DELAY
					 A_CustomFinaleValue6 = 30-1*nowPlayersinGame
					 
					 A_CustomFinale7 = TANK
					 A_CustomFinaleValue7 = 2

					 A_CustomFinale8 = DELAY
					 A_CustomFinaleValue8 = 30-1*nowPlayersinGame
					 
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
				Msg("Local Script exec n° "+nowLocalScriptExec+"\n");	
				nowLocalScriptExec++;								
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
					 A_CustomFinaleValue2 = 30-1*nowPlayersinGame
					 
					 A_CustomFinale3 = TANK
					 A_CustomFinaleValue3 = 1
					 
					 A_CustomFinale4 = DELAY
					 A_CustomFinaleValue4 = 30-1*nowPlayersinGame
					 
					 A_CustomFinale5 = PANIC
					 A_CustomFinaleValue5 = 1
					 
					 A_CustomFinale6 = DELAY
					 A_CustomFinaleValue6 = 30-1*nowPlayersinGame
					 
					 A_CustomFinale7 = TANK
					 A_CustomFinaleValue7 = 1
					 
					 A_CustomFinale8 = DELAY
					 A_CustomFinaleValue8 = 30-1*nowPlayersinGame
					 
					 
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
				Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
				nowLocalScriptExec++;
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
		{	
			if (nowLocalScriptExec==0)
			{
				Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
				nowLocalScriptExec++;
				nowFinaleScavengeStarted=1

				Msg("----------------------FINALE SCRIPT------------------\n")
				//-----------------------------------------------------
				PANIC <- 0
				TANK <- 1
				DELAY <- 2
				ONSLAUGHT <- 3
				//-----------------------------------------------------

				SharedOptions <-
				{
					A_CustomFinale1 = ONSLAUGHT
					A_CustomFinaleValue1 = ""

					A_CustomFinale2 = PANIC
					A_CustomFinaleValue2 = 1

					A_CustomFinale3 = ONSLAUGHT
					A_CustomFinaleValue3 = "c1m4_delay"
						
					A_CustomFinale4 = PANIC
					A_CustomFinaleValue4 = 1

					A_CustomFinale5 = ONSLAUGHT
					A_CustomFinaleValue5 = "c1m4_delay"

					A_CustomFinale6 = TANK
					A_CustomFinaleValue6 = 1

					A_CustomFinale7 = ONSLAUGHT
					A_CustomFinaleValue7 = "c1m4_delay"
				 
					A_CustomFinale8 = PANIC
					A_CustomFinaleValue8 = 1

					A_CustomFinale9 = ONSLAUGHT
					A_CustomFinaleValue9 = "c1m4_delay"
				 
					A_CustomFinale10 = PANIC
					A_CustomFinaleValue10 = 1

					A_CustomFinale11 = ONSLAUGHT
					A_CustomFinaleValue11 = "c1m4_delay"

					A_CustomFinale12 = PANIC
					A_CustomFinaleValue12 = 1
						
					A_CustomFinale13 = ONSLAUGHT
					A_CustomFinaleValue13 = "c1m4_delay"
						
					A_CustomFinale14 = TANK
					A_CustomFinaleValue14 = 2   
						
					A_CustomFinale15 = ONSLAUGHT
					A_CustomFinaleValue15 = "c1m4_delay"
						
					A_CustomFinale16 = PANIC
					A_CustomFinaleValue16 = 1  
								  
					A_CustomFinale17 = ONSLAUGHT
					A_CustomFinaleValue17 = "c1m4_delay"    
									   
					A_CustomFinale18 = PANIC
					A_CustomFinaleValue18 = 1  
					
					A_CustomFinale19 = ONSLAUGHT
					A_CustomFinaleValue19 = "c1m4_delay"
						
					A_CustomFinale20 = PANIC
					A_CustomFinaleValue20 = 1   
						
					A_CustomFinale21 = ONSLAUGHT
					A_CustomFinaleValue21 = "c1m4_delay"
						
					A_CustomFinale22 = TANK
					A_CustomFinaleValue22 = 1  
								  
					A_CustomFinale23 = ONSLAUGHT
					A_CustomFinaleValue23 = "c1m4_delay"    
									   
					A_CustomFinale24 = PANIC
					A_CustomFinaleValue24 = 1
																			
					A_CustomFinale25 = ONSLAUGHT
					A_CustomFinaleValue25 = "c1m4_delay"
						
					A_CustomFinale26 = PANIC
					A_CustomFinaleValue26 = 1   
						
					A_CustomFinale27 = ONSLAUGHT
					A_CustomFinaleValue27 = "c1m4_delay"
						
					A_CustomFinale28 = PANIC
					A_CustomFinaleValue28 = 1  
								  
					A_CustomFinale29 = ONSLAUGHT
					A_CustomFinaleValue29 = "c1m4_delay"    
									   
					A_CustomFinale30 = PANIC
					A_CustomFinaleValue30 = 1

					A_CustomFinale31 = ONSLAUGHT
					A_CustomFinaleValue31 = "c1m4_delay"   

					A_CustomFinale32 = TANK
					A_CustomFinaleValue32 = 2  
								  
					A_CustomFinale33 = ONSLAUGHT
					A_CustomFinaleValue33 = "c1m4_delay"    
									   
					A_CustomFinale34 = PANIC
					A_CustomFinaleValue34 = 1
																			
					A_CustomFinale35 = ONSLAUGHT
					A_CustomFinaleValue35 = "c1m4_delay"
						
					A_CustomFinale36 = PANIC
					A_CustomFinaleValue36 = 1   
						
					A_CustomFinale37 = ONSLAUGHT
					A_CustomFinaleValue37 = "c1m4_delay"
						
					A_CustomFinale38 = PANIC
					A_CustomFinaleValue38 = 1  
								  
					A_CustomFinale39 = ONSLAUGHT
					A_CustomFinaleValue39 = "c1m4_delay"    
									   
					A_CustomFinale40 = PANIC
					A_CustomFinaleValue40 = 1

					A_CustomFinale41 = ONSLAUGHT
					A_CustomFinaleValue41 = "c1m4_delay"   

					A_CustomFinale42 = TANK
					A_CustomFinaleValue42 = 1  
								  
					A_CustomFinale43 = ONSLAUGHT
					A_CustomFinaleValue43 = "c1m4_delay"    
									   
					A_CustomFinale44 = PANIC
					A_CustomFinaleValue44 = 1
																			
					A_CustomFinale45 = ONSLAUGHT
					A_CustomFinaleValue45 = "c1m4_delay"
						
					A_CustomFinale46 = PANIC
					A_CustomFinaleValue46 = 1   
						
					A_CustomFinale47 = ONSLAUGHT
					A_CustomFinaleValue47 = "c1m4_delay"
						
					A_CustomFinale48 = PANIC
					A_CustomFinaleValue48 = 1  
								  
					A_CustomFinale49 = ONSLAUGHT
					A_CustomFinaleValue49 = "c1m4_delay"    
									   
					A_CustomFinale50 = PANIC
					A_CustomFinaleValue50 = 1

					A_CustomFinale51 = ONSLAUGHT
					A_CustomFinaleValue51 = "c1m4_delay"   
									  
					//-----------------------------------------------------

					PreferredMobDirection = SPAWN_LARGE_VOLUME
					PreferredSpecialDirection = SPAWN_LARGE_VOLUME
						
				//	BoomerLimit = 0
				//	SmokerLimit = 2
				//	HunterLimit = 1
				//	SpitterLimit = 1
				//	JockeyLimit = 0
				//	ChargerLimit = 1

					ProhibitBosses = true
					ZombieSpawnRange = 3000
					MobRechargeRate = 0.5
					HordeEscapeCommonLimit = 15
					BileMobSize = 15
					SpecialRespawnInterval = 20
					
					MusicDynamicMobSpawnSize = 8
					MusicDynamicMobStopSize = 2
					MusicDynamicMobScanStopSize = 1
				} 

				InitialOnslaughtOptions <-
				{
					LockTempo = 0
					IntensityRelaxThreshold = 1.1
					RelaxMinInterval = 2
					RelaxMaxInterval = 4
					SustainPeakMinTime = 25
					SustainPeakMaxTime = 30
					
					MobSpawnMinTime = 4
					MobSpawnMaxTime = 8
					MobMinSize = 2
					MobMaxSize = 6
					CommonLimit = 5
					
					SpecialRespawnInterval = 100
				}

				PanicOptions <-
				{
					MegaMobSize = 0 // randomized in OnBeginCustomFinaleStage
					MegaMobMinSize = 20
					MegaMobMaxSize = 40
					MaxSpecials = 5
					BoomerLimit = 1
					SmokerLimit = 2
					HunterLimit = 2
					SpitterLimit = 1
					JockeyLimit = 1
					ChargerLimit = 1
					CommonLimit = 25
					
					SpecialRespawnInterval = 25
				}

				TankOptions <-
				{
					ShouldAllowMobsWithTank = true
					ShouldAllowSpecialsWithTank = true

					MobSpawnMinTime = 20
					MobSpawnMaxTime = 40
					MobMinSize = 3
					MobMaxSize = 5
					MaxSpecials = 3
					CommonLimit = 5
					
					SpecialRespawnInterval = 50
				}


				DirectorOptions <- clone SharedOptions
				{
				}


				//-----------------------------------------------------

				// number of cans needed to escape.
				NumCansNeeded <- 16

				// fewer cans in single player since bots don't help much
				if ( Director.IsSinglePlayerGame() )
				{
					NumCansNeeded <- 10
				}

				// duration of delay stage.
				DelayMin <- 10
				DelayMax <- 20

				// Number of touches and/or pours allowed before a delay is aborted.
				DelayPourThreshold <- 1
				DelayTouchedOrPouredThreshold <- 2


				// Once the delay is aborted, amount of time before it progresses to next stage.
				AbortDelayMin <- 1
				AbortDelayMax <- 3

				// Number of touches and pours it takes to transition out of c1m4_finale_wave_1
				GimmeThreshold <- 4


				// console overrides
				//if ( Director.IsPlayingOnConsole() )
				//{
				DelayMin <- 20
				DelayMax <- 30
				
				// Number of touches and/or pours allowed before a delay is aborted.
				DelayPourThreshold <- 2
				DelayTouchedOrPouredThreshold <- 4
					
				//	TankOptions.ShouldAllowSpecialsWithTank = false
				//}
				//-----------------------------------------------------
				//      INIT
				//-----------------------------------------------------

				GasCansTouched          <- 0
				GasCansPoured           <- 0
				DelayTouchedOrPoured    <- 0
				DelayPoured             <- 0

				EntFire( "timer_delay_end", "LowerRandomBound", DelayMin )
				EntFire( "timer_delay_end", "UpperRandomBound", DelayMax )
				EntFire( "timer_delay_abort", "LowerRandomBound", AbortDelayMin )
				EntFire( "timer_delay_abort", "UpperRandomBound", AbortDelayMax )

				// this is too late. Moved to c1m4_atrium.nut
				//EntFire( "progress_display", "SetTotalItems", NumCansNeeded )

				function AbortDelay(){}  	// only defined during a delay, in c1m4_delay.nut
				function EndDelay(){}		// only defined during a delay, in c1m4_delay.nut

				NavMesh.UnblockRescueVehicleNav()

				//-----------------------------------------------------

				function GasCanTouched()
				{
					GasCansTouched++
					Msg(" Touched: " + GasCansTouched + "\n")   
					 
					EvalGasCansPouredOrTouched()    
				}
					
				function GasCanPoured()
				{
					GasCansPoured++
					DelayPoured++
					Msg(" Poured: " + GasCansPoured + "\n")   

					if ( GasCansPoured == NumCansNeeded )
					{
						Msg(" needed: " + NumCansNeeded + "\n") 
						EntFire( "relay_car_ready", "trigger" )
					}

					EvalGasCansPouredOrTouched()
				}

				function EvalGasCansPouredOrTouched()
				{
					TouchedOrPoured <- GasCansPoured + GasCansTouched
					Msg(" Poured or touched: " + TouchedOrPoured + "\n")

					DelayTouchedOrPoured++
					Msg(" DelayTouchedOrPoured: " + DelayTouchedOrPoured + "\n")
					Msg(" DelayPoured: " + DelayPoured + "\n")
					
					if (( DelayTouchedOrPoured >= DelayTouchedOrPouredThreshold ) || ( DelayPoured >= DelayPourThreshold ))
					{
						AbortDelay()
					}
					
					switch( TouchedOrPoured )
					{
						case GimmeThreshold:
							EntFire( "@director", "EndCustomScriptedStage" )
							break
					}
				}
				//-----------------------------------------------------

				// function AddTableToTable( dest, src )
				// {
					// foreach( key, val in src )
					// {
						// dest[key] <- val
					// }
				// }

				function OnBeginCustomFinaleStage( num, type )
				{
					printl( "Beginning custom finale stage " + num + " of type " + type );
					
					local waveOptions = null
					if ( num == 1 )
					{
						waveOptions = InitialOnslaughtOptions
					}
					else if ( type == PANIC )
					{
						waveOptions = PanicOptions
						waveOptions.MegaMobSize = PanicOptions.MegaMobMinSize + rand()%( PanicOptions.MegaMobMaxSize - PanicOptions.MegaMobMinSize )
						
						Msg("*************************" + waveOptions.MegaMobSize + "\n")
						
					}
					else if ( type == TANK )
					{
						waveOptions = TankOptions
						EntFire( "bonus_relay", "Trigger", 0 )
					}
					
					// give out items at certain stages
					if ( num == 3 || num == 7 || num == 15 || num == 23 )
					{
						Director.L4D1SurvivorGiveItem()
					}
					
					//---------------------------------


					MapScript.DirectorOptions.clear()
					

					AddTableToTable( MapScript.DirectorOptions, SharedOptions );

					if ( waveOptions != null )
					{
						AddTableToTable( MapScript.DirectorOptions, waveOptions );
					}
					
					
					Director.ResetMobTimer()
					
					if ( developer() > 0 )
					{
						Msg( "\n*****\nMapScript.DirectorOptions:\n" );
						foreach( key, value in MapScript.DirectorOptions )
						{
							Msg( "    " + key + " = " + value + "\n" );
						}

						if ( LocalScript.rawin( "DirectorOptions" ) )
						{
							Msg( "\n*****\nLocalScript.DirectorOptions:\n" );
							foreach( key, value in LocalScript.DirectorOptions )
							{
								Msg( "    " + key + " = " + value + "\n" );
							}
						}
					}
				}

				//-----------------------------------------------------


				if ( Director.GetGameModeBase() == "versus" )
				{
					SharedOptions.ProhibitBosses = false
				}


			}
			break;
		}
		case "c7m1_docks":
		case "c7m2_barge":
		case "c7m3_port":
		{	
			if (nowLocalScriptExec==0)
			{
				Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
				nowLocalScriptExec++;
				//-----------------------------------------------------
				// This script handles the logic for the Port / Bridge
				// finale in the River Campaign. 
				//
				//-----------------------------------------------------
				Msg("Initiating c7m3_port_finale script\n");
				nowFinaleScavengeStarted=1
				//-----------------------------------------------------
				ERROR		<- -1
				PANIC 		<- 0
				TANK 		<- 1
				DELAY 		<- 2

				//-----------------------------------------------------

				// This keeps track of the number of times the generator button has been pressed. 
				// Init to 1, since one button press has been used to start the finale and run 
				// this script. 
				ButtonPressCount <- 1

				// This stores the stage number that we last
				// played the "Press the Button!" VO
				LastVOButtonStageNumber <- 0

				// We use this to keep from running a bunch of queued advances really quickly. 
				// Init to true because we are starting a finale from a button press in the pre-finale script 
				// see GeneratorButtonPressed in c7m3_port.nut
				PendingWaitAdvance <- true	

				// We use three generator button presses to push through
				// 8 stages. We have to queue up state advances
				// depending on the state of the finale when buttons are pressed
				QueuedDelayAdvances <- 0


				// Tracking current finale states
				CurrentFinaleStageNumber <- ERROR
				CurrentFinaleStageType <- ERROR

				// The finale is 3 phases. 
				// We randomize the event types in the first two
				local RandomFinaleStage1 = 0
				local RandomFinaleStage2 = 0
				local RandomFinaleStage4 = 0
				local RandomFinaleStage5 = 0

				// PHASE 1 EVENTS
				if ( RandomInt( 1, 100 ) < 50 )
				{
					RandomFinaleStage1 = PANIC
					RandomFinaleStage2 = TANK
				}
				else
				{
					RandomFinaleStage1 = TANK
					RandomFinaleStage2 = PANIC
				}


				// PHASE 2 EVENTS
				if ( RandomInt( 1, 100 ) < 50 )
				{
					RandomFinaleStage4 = PANIC
					RandomFinaleStage5 = TANK
				}
				else
				{
					RandomFinaleStage4 = TANK
					RandomFinaleStage5 = PANIC
				}



				// We want to give the survivors a little of extra time to 
				// get on their feet before the escape, since you have to fight through 
				// the sacrifice.

				PreEscapeDelay <- 0
				if ( Director.GetGameModeBase() == "coop" || Director.GetGameModeBase() == "realism" )
				{
					PreEscapeDelay <- 5
				}
				else if ( Director.GetGameModeBase() == "versus" )
				{
					PreEscapeDelay <- 15
				}

				DirectorOptions <-
				{	
					A_CustomFinale_StageCount = 8
					
					// PHASE 1
					A_CustomFinale1 = RandomFinaleStage1
					A_CustomFinaleValue1 = 1
					A_CustomFinale2 = RandomFinaleStage2
					A_CustomFinaleValue2 = 1
					A_CustomFinale3 = DELAY
					A_CustomFinaleValue3 = 9999
					
					
					// PHASE 2
					A_CustomFinale4 = RandomFinaleStage4
					A_CustomFinaleValue4 = 1
					A_CustomFinale5 = RandomFinaleStage5
					A_CustomFinaleValue5 = 1	
					A_CustomFinale6 = DELAY
					A_CustomFinaleValue6 = 9999 	 
					
					
					// PHASE 3
					A_CustomFinale7 = TANK
					A_CustomFinaleValue7 = 1	 	 		 
					A_CustomFinale8 = DELAY
					A_CustomFinaleValue8 = PreEscapeDelay
					
					
					
					TankLimit = 4
					WitchLimit = 0
					CommonLimit = 20	
					HordeEscapeCommonLimit = 15	
					EscapeSpawnTanks = false
					//SpecialRespawnInterval = 80
				}


				function OnBeginCustomFinaleStage( num, type )
				{
					printl( "*!* Beginning custom finale stage " + num + " of type " + type );
					printl( "*!* PendingWaitAdvance " + PendingWaitAdvance + ", QueuedDelayAdvances " + QueuedDelayAdvances );
					
					// Store off the state... 
					CurrentFinaleStageNumber = num
					CurrentFinaleStageType = type
					
					// Acknowledge the state advance
					PendingWaitAdvance = false
				}


				function GeneratorButtonPressed()
				{
					printl( "*!* GeneratorButtonPressed finale stage " + CurrentFinaleStageNumber + " of type " +CurrentFinaleStageType );
					printl( "*!* PendingWaitAdvance " + PendingWaitAdvance + ", QueuedDelayAdvances " + QueuedDelayAdvances );
					
					
					ButtonPressCount++
					
					
					local ImmediateAdvances = 0
					
					
					if ( CurrentFinaleStageNumber == 1 || CurrentFinaleStageNumber == 4 )
					{		
						// First stage of a phase, so next stage is an "action" stage too.
						// Advance to next action stage, and then queue an advance to the 
						// next delay.
						QueuedDelayAdvances++
						ImmediateAdvances = 1
					}
					else if ( CurrentFinaleStageNumber == 2 || CurrentFinaleStageNumber == 5 )
					{
						// Second stage of a phase, so next stage is a "delay" stage.
						// We need to immediately advance past the delay and into an action state. 
						
						//QueuedDelayAdvances++	// NOPE!
						ImmediateAdvances = 2
					}
					else if ( CurrentFinaleStageNumber == 3 || CurrentFinaleStageNumber == 6 )
					{
						// Wait states... (very long delay)
						// Advance immediately into an action state
						
						//QueuedDelayAdvances++
						ImmediateAdvances = 1
					}
					else if ( CurrentFinaleStageNumber == -1 || 
							  CurrentFinaleStageNumber == 0 )
					{
						// the finale is *just* about to start... 
						// we can get this if all the buttons are hit at once at the beginning
						// Just queue a wait advance
						QueuedDelayAdvances++
						ImmediateAdvances = 0
					}
					else
					{
						printl( "*!* Unhandled generator button press! " );
					}

					if ( ImmediateAdvances > 0 )
					{	
						EntFire( "generator_start_model", "Enable" )
						
						
						if ( ImmediateAdvances == 1 )
						{
							printl( "*!* GeneratorButtonPressed Advancing State ONCE");
							EntFire( "generator_start_model", "AdvanceFinaleState" )
						}
						else if ( ImmediateAdvances == 2 )
						{
							printl( "*!* GeneratorButtonPressed Advancing State TWICE");
							EntFire( "generator_start_model", "AdvanceFinaleState" )
							EntFire( "generator_start_model", "AdvanceFinaleState" )
						}
						
						EntFire( "generator_start_model", "Disable" )
						
						PendingWaitAdvance = true
					}
					
				}

				function Update()
				{
					// Should we advance the finale state?
					// 1. If we're in a DELAY state
					// 2. And we have queued advances.... 
					// 3. And we haven't just tried to advance the advance the state.... 
					if ( CurrentFinaleStageType == DELAY && QueuedDelayAdvances > 0 && !PendingWaitAdvance )
					{
						// If things are calm (relatively), jump to the next state
						if ( !Director.IsTankInPlay() && !Director.IsAnySurvivorInCombat() )
						{
							if ( Director.GetPendingMobCount() < 1 && Director.GetCommonInfectedCount() < 5 )
							{
								printl( "*!* Update Advancing State finale stage " + CurrentFinaleStageNumber + " of type " +CurrentFinaleStageType );
								printl( "*!* PendingWaitAdvance " + PendingWaitAdvance + ", QueuedDelayAdvances " + QueuedDelayAdvances );
						
								QueuedDelayAdvances--
								EntFire( "generator_start_model", "Enable" )
								EntFire( "generator_start_model", "AdvanceFinaleState" )
								EntFire( "generator_start_model", "Disable" )
								PendingWaitAdvance = true
							}
						}
					}
					
					// Should we fire the director event to play the "Press the button!" Nag VO?	
					// If we're on an infinite delay stage...
					if ( CurrentFinaleStageType == DELAY && CurrentFinaleStageNumber > 1 && CurrentFinaleStageNumber < 7 )	
					{		
						// 1. We haven't nagged for this stage yet
						// 2. There are button presses remaining
						if ( CurrentFinaleStageNumber != LastVOButtonStageNumber && ButtonPressCount < 3 )
						{
							// We're not about to process a wait advance..
							if ( QueuedDelayAdvances == 0 && !PendingWaitAdvance )
							{
								// If things are pretty calm, run the event
								if ( Director.GetPendingMobCount() < 1 && Director.GetCommonInfectedCount() < 1 )
								{
									if ( !Director.IsTankInPlay() && !Director.IsAnySurvivorInCombat() )
									{
										printl( "*!* Update firing event 1 (VO Prompt)" )
										LastVOButtonStageNumber = CurrentFinaleStageNumber
										Director.UserDefinedEvent1()
									}
								}
							}
						}
					}
					
				}


				function EnableEscapeTanks()
				{
					printl( "*!* EnableEscapeTanks finale stage " + CurrentFinaleStageNumber + " of type " +CurrentFinaleStageType );
					
					//Msg( "\n*****\nMapScript.DirectorOptions:\n" );
					//foreach( key, value in MapScript.DirectorOptions )
					//{
					//	Msg( "    " + key + " = " + value + "\n" );
					//}

					MapScript.DirectorOptions.EscapeSpawnTanks <- true
				}
			}
			break;
		}

		case "c8m1_apartment":
		case "c8m2_subway":
		case "c8m3_sewers":
		case "c8m4_interior":
		case "c8m5_rooftop":
		{
			if (nowLocalScriptExec==0)
			{
				Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
				nowLocalScriptExec++;
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
					StageDelay <- 30-1*nowPlayersinGame//5
					PreEscapeDelay <- 30-1*nowPlayersinGame//5
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
					
					
					ZombieSpawnRange			=	500
			
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
				Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
				nowLocalScriptExec++;
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
					StageDelay <- 30-1*nowPlayersinGame//5
					PreEscapeDelay <- 30-1*nowPlayersinGame//5
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
				Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
				nowLocalScriptExec++;
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
					StageDelay <- 30-1*nowPlayersinGame//5
					PreEscapeDelay <- 30-1*nowPlayersinGame//5
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
				Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
				nowLocalScriptExec++;
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
					StageDelay <- 30-1*nowPlayersinGame//5
					PreEscapeDelay <- 30-1*nowPlayersinGame//5
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
					
						
					ZombieSpawnRange		=	1000
			
					
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
		{	
			if (nowLocalScriptExec==0)
			{
				Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
				nowLocalScriptExec++;
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
					StageDelay <- 30-1*nowPlayersinGame//5
					PreEscapeDelay <- 30-1*nowPlayersinGame//5
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
		case "c13m1_alpinecreek":
		case "c13m2_southpinestream":
		case "c13m3_memorialbridge":
		case "c13m4_cutthroatcreek":
		case "c14m1_junkyard":
		case "c14m2_lighthouse":	
		{	
			if (nowLocalScriptExec==0)
			{
				Msg("Local Script exec n° "+nowLocalScriptExec+"\n");
				nowLocalScriptExec++;
				Msg("Initiating c14m2_lighthouse_finale script\n");

				StageDelay <- 15
				PreEscapeDelay <- 10

				//-----------------------------------------------------
				PANIC <- 0
				TANK <- 1
				DELAY <- 2
				ONSLAUGHT <- 3
				//-----------------------------------------------------

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
					A_CustomFinale5			= ONSLAUGHT
					A_CustomFinaleValue5 	= "c14m2_gauntlet"
					A_CustomFinaleMusic5	= "Event.FinaleWave4"	//NEW
					A_CustomFinale6 		= DELAY
					A_CustomFinaleValue6 	= StageDelay
					A_CustomFinale7			= TANK
					A_CustomFinaleValue7	= 2
					A_CustomFinaleMusic7	= "Event.TankMidpoint_Metal"
					A_CustomFinale8 		= DELAY
					A_CustomFinaleValue8 	= PreEscapeDelay
					//-----------------------------------------------------

					ProhibitBosses = true
					HordeEscapeCommonLimit = 20
					EscapeSpawnTanks = false
				}

				local difficulty = Convars.GetStr( "z_difficulty" ).tolower();

				if ( Director.GetGameModeBase() == "versus" )
				{
					DirectorOptions.rawdelete("A_CustomFinaleMusic7");
					DirectorOptions.A_CustomFinale_StageCount = 11;
					DirectorOptions.A_CustomFinale6 = ONSLAUGHT;
					DirectorOptions.A_CustomFinaleValue6 = "c14m2_gauntlet_vs";
					DirectorOptions.A_CustomFinale7 = ONSLAUGHT;
					DirectorOptions.A_CustomFinaleValue7 = "c14m2_gauntlet_vs";
					DirectorOptions.A_CustomFinale8 = ONSLAUGHT;
					DirectorOptions.A_CustomFinaleValue8 = "c14m2_gauntlet_vs";
					DirectorOptions.A_CustomFinale9 <- DELAY;
					DirectorOptions.A_CustomFinaleValue9 <- StageDelay;
					DirectorOptions.A_CustomFinale10 <- TANK;
					DirectorOptions.A_CustomFinaleValue10 <- 1;
					DirectorOptions.A_CustomFinaleMusic10 <- "Event.TankMidpoint_Metal";
					DirectorOptions.A_CustomFinale11 <- DELAY;
					DirectorOptions.A_CustomFinaleValue11 <- PreEscapeDelay;
					difficulty = "normal";
				}
				else
				{
					if ( difficulty == "hard" || difficulty == "impossible" )
					{
						DirectorOptions.rawdelete("A_CustomFinaleMusic5");		//NEW
						DirectorOptions.rawdelete("A_CustomFinaleMusic7");
						DirectorOptions.A_CustomFinale_StageCount = 12;
						DirectorOptions.A_CustomFinaleValue7 = 1;
						DirectorOptions.A_CustomFinaleValue8 = StageDelay;
						DirectorOptions.A_CustomFinale9 <- PANIC;
						DirectorOptions.A_CustomFinaleValue9 <- 2;
						DirectorOptions.A_CustomFinaleMusic9 <- "Event.FinaleWave4"	//NEW
						DirectorOptions.A_CustomFinale10 <- DELAY;
						DirectorOptions.A_CustomFinaleValue10 <- StageDelay;
						DirectorOptions.A_CustomFinale11 <- TANK;
						DirectorOptions.A_CustomFinaleValue11 <- 2;
						DirectorOptions.A_CustomFinaleMusic11 <- "Event.TankMidpoint_Metal"
						DirectorOptions.A_CustomFinale12 <- DELAY;
						DirectorOptions.A_CustomFinaleValue12 <- PreEscapeDelay;
					}
				}

				//-----------------------------------------------------

				function SpawnScavengeCans( difficulty )
				{
					local function SpawnCan( gascan )
					{
						local can_origin = gascan.GetOrigin();
						local can_angles = gascan.GetAngles();
						gascan.Kill();
						
						local kvs =
						{
							angles = can_angles.ToKVString()
							body = 0
							disableshadows = 1
							glowstate = 3
							model = "models/props_junk/gascan001a.mdl"
							skin = 2
							weaponskin = 2
							solid = 0
							spawnflags = 2
							targetname = "scavenge_gascans"
							origin = can_origin.ToKVString()
							connections =
							{
								OnItemPickedUp =
								{
									cmd1 = "directorRunScriptCodeDirectorScript.MapScript.LocalScript.GasCanTouched()0-1"
								}
							}
						}
						local can_spawner = SpawnEntityFromTable( "weapon_scavenge_item_spawn", kvs );
						if ( can_spawner )
							DoEntFire( "!self", "SpawnItem", "", 0, null, can_spawner );
					}
					
					switch( difficulty )
					{
						case "impossible":
						{
							local gascan = null;
							while ( gascan = Entities.FindByName( gascan, "gascans_finale_expert" ) )
							{
								if ( gascan.IsValid() )
									SpawnCan( gascan );
							}
						}
						case "hard":
						{
							local gascan = null;
							while ( gascan = Entities.FindByName( gascan, "gascans_finale_advanced" ) )
							{
								if ( gascan.IsValid() )
									SpawnCan( gascan );
							}
						}
						case "normal":
						{
							local gascan = null;
							while ( gascan = Entities.FindByName( gascan, "gascans_finale_normal" ) )
							{
								if ( gascan.IsValid() )
									SpawnCan( gascan );
							}
						}
						case "easy":
						{
							local gascan = null;
							while ( gascan = Entities.FindByName( gascan, "gascans_finale_easy" ) )
							{
								if ( gascan.IsValid() )
									SpawnCan( gascan );
							}
							break;
						}
						default:
							break;
					}
					
					EntFire( "gascans_finale_*", "Kill" );
				}

				// number of cans needed to escape.
				NumCansNeeded <- 8

				switch( difficulty )
				{
					case "easy":
					{
						NumCansNeeded = 6;
						EntFire( "relay_outro_easy", "Enable" );
						break;
					}
					case "normal":
					{
						NumCansNeeded = 8;
						EntFire( "relay_outro_normal", "Enable" );
						break;
					}
					case "hard":
					{
						NumCansNeeded = 10;
						EntFire( "relay_outro_advanced", "Enable" );
						break;
					}
					case "impossible":
					{
						NumCansNeeded = 12;
						EntFire( "relay_outro_expert", "Enable" );
						break;
					}
					default:
						break;
				}

				EntFire( "progress_display", "SetTotalItems", NumCansNeeded );
				EntFire( "radio", "AddOutput", "FinaleEscapeStarted director:RunScriptCode:DirectorScript.MapScript.LocalScript.DirectorOptions.TankLimit <- 3:0:-1" );

				local c14m2_tankspawntime = 0.0;
				local c14m2_tankspawner = null;
				while ( c14m2_tankspawner = Entities.FindByClassname( c14m2_tankspawner, "commentary_zombie_spawner" ) )
				{
					if ( c14m2_tankspawner.IsValid() )
					{
						c14m2_tankspawner.ValidateScriptScope();
						local spawnerScope = c14m2_tankspawner.GetScriptScope();
						spawnerScope.SpawnedTankTime <- 0.0;
						spawnerScope.InputSpawnZombie <- function()
						{
							if ( (caller) && (caller.GetName() == "escapetanktrigger") )
							{
								if ( !c14m2_tankspawntime )
									c14m2_tankspawntime = Time();
							}
							if ( SpawnedTankTime )
							{
								if ( Time() - c14m2_tankspawntime < 1 )
									return false;
								else
								{
									delete this.SpawnedTankTime;
									delete this.InputSpawnZombie;
									return true;
								}
							}
							
							SpawnedTankTime = Time();
							return true;
						}
					}
				}

				//-----------------------------------------------------
				//      INIT
				//-----------------------------------------------------

				GasCansTouched          <- 0
				GasCansPoured           <- 0
				ScavengeCansPoured		<- 0
				ScavengeCansNeeded		<- 2

				local EscapeStage = DirectorOptions.A_CustomFinale_StageCount;

				//-----------------------------------------------------

				function GasCanTouched()
				{
					GasCansTouched++;
					if ( developer() > 0 )
						Msg(" Touched: " + GasCansTouched + "\n");
				}

				function GasCanPoured()
				{
					GasCansPoured++;
					ScavengeCansPoured++;
					if ( developer() > 0 )
						Msg(" Poured: " + GasCansPoured + "\n");

					if ( GasCansPoured == 1 )
						EntFire( "explain_fuel_generator", "Kill" );
					else if ( GasCansPoured == NumCansNeeded )
					{
						if ( developer() > 0 )
							Msg(" needed: " + NumCansNeeded + "\n");
						EntFire( "relay_generator_ready", "Trigger", "", 0.1 );
						EntFire( "weapon_scavenge_item_spawn", "TurnGlowsOff" );
						EntFire( "weapon_scavenge_item_spawn", "Kill" );
						EntFire( "director", "EndCustomScriptedStage", "", 5 );
					}
					
					if ( Director.GetGameModeBase() == "versus" && ScavengeCansPoured == 2 && GasCansPoured < NumCansNeeded )
					{
						ScavengeCansPoured = 0;
						EntFire( "radio", "AdvanceFinaleState" );
					}
				}
				//-----------------------------------------------------

				function OnBeginCustomFinaleStage( num, type )
				{
					if ( developer() > 0 )
						printl( "Beginning custom finale stage " + num + " of type " + type );
					
					if ( num == 4 )
					{
						EntFire( "relay_boat_coming2", "Trigger" );
						// Delay lasts 10 seconds, next stage turns off lights immediately
						EntFire( "lighthouse_light", "SetPattern", "mmamammmmammamamaaamammma", 7.0 );
						EntFire( "lighthouse_light", "SetPattern", "", 9.5 );
						EntFire( "lighthouse_light", "TurnOff", "", 10 );
						EntFire( "spotlight_beams", "LightOff", "", 7.0 );
						EntFire( "spotlight_glow", "HideSprite", "", 7.0 );
						EntFire( "brush_light", "Enable", "", 7.0 );
						EntFire( "spotlight_beams", "LightOn", "", 7.5 );
						EntFire( "spotlight_glow", "ShowSprite", "", 7.5 );
						EntFire( "brush_light", "Disable", "", 7.5 );
						EntFire( "spotlight_beams", "LightOff", "", 8.0 );
						EntFire( "spotlight_glow", "HideSprite", "", 8.0 );
						EntFire( "brush_light", "Enable", "", 8.0 );
						EntFire( "spotlight_beams", "LightOn", "", 8.5 );
						EntFire( "spotlight_glow", "ShowSprite", "", 8.5 );
						EntFire( "brush_light", "Disable", "", 8.5 );
					}
					else if ( num == 5 )
					{
						EntFire( "relay_lighthouse_off", "Trigger" );
						SpawnScavengeCans( difficulty );
					}
					else if ( num == EscapeStage )
						EntFire( "relay_start_boat", "Trigger" );
				}

				function GetCustomScriptedStageProgress( defvalue )
				{
					local progress = ScavengeCansPoured.tofloat() / ScavengeCansNeeded.tofloat();
					if ( developer() > 0 )
						Msg( "Progress was " + defvalue + ", now: " + ScavengeCansPoured + " poured / " + ScavengeCansNeeded + " needed = " + progress + "\n" );
					return progress;
				}

			}
			break;
		}
		default:
			break;
	}
}

::aScriptLogic <- function(execscriptName)			
{
Msg("................................................ aScriptLogic\n");
Msg(".................................execscriptName: " + execscriptName + "\n");
	switch (execscriptName)
	{
		case "sky_events_in_front":
		{	
			Msg( "sky_events_in_front\n" );
			DirectorOptions <-
			{
				
				// This turns off tanks and witches.
				ProhibitBosses = true

				PreferredMobDirection = SPAWN_IN_FRONT_OF_SURVIVORS
				MobSpawnMinTime = 4
				MobSpawnMaxTime = 4
				//MobMaxPending = 16
				//MobMinSize = 16
				//MobMaxSize = 16
				SustainPeakMinTime = 3
				SustainPeakMaxTime = 3
				IntensityRelaxThreshold = 0.90
				RelaxMinInterval = 4
				RelaxMaxInterval = 4
				RelaxMaxFlowTravel = 200
			}
			Director.ResetMobTimer();
			defineDirectorOptions(DirectorOptions);
			Utils.ForcePanicEvent();
		}
		break;
		case "sky_events_in_any_where":
		{	
			Msg( "sky_events_in_any_where\n" );
			Msg("Initiating Sky Panic Event\n");
			DirectorOptions <-
			{
				// This turns off tanks and witches.
				ProhibitBosses = true

				PreferredMobDirection = SPAWN_ANYWHERE
				MobSpawnMinTime = 4
				MobSpawnMaxTime = 4
				//MobMaxPending = 16
				//MobMinSize = 16
				//MobMaxSize = 16
				SustainPeakMinTime = 3
				SustainPeakMaxTime = 3
				IntensityRelaxThreshold = 0.90
				RelaxMinInterval = 4
				RelaxMaxInterval = 4
				RelaxMaxFlowTravel = 200
			}
			Director.ResetMobTimer();
			defineDirectorOptions(DirectorOptions);
			Utils.ForcePanicEvent();
		}
		break;
		case "sky_events_silent":
		{	
			Msg( "sky_events_silent\n" );
			Msg("Initiating Sky Panic Event\n");

			DirectorOptions <-
			{
				// This turns off tanks and witches.
				ProhibitBosses = true

				PreferredMobDirection = SPAWN_IN_FRONT_OF_SURVIVORS
				MobSpawnMinTime = 1
				MobSpawnMaxTime = 2
				//MobMaxPending = 20
				//MobMinSize = 20
				//MobMaxSize = 20
				SustainPeakMinTime = 1
				SustainPeakMaxTime = 3
				IntensityRelaxThreshold = 0.90
				RelaxMinInterval = 3
				RelaxMaxInterval = 3
				RelaxMaxFlowTravel = 200
			}

			Director.ResetMobTimer()
			defineDirectorOptions(DirectorOptions);
			Utils.ForcePanicEvent();
		}
		break;
		case "sky_scavenge_cans_cvars":
		{	
			Msg( "sky_scavenge_cans_cvars\n" );
			Msg("Initiating Sky Scavenge Item Cvars");

			Convars.SetValue( "inferno_flame_lifetime", 2.5 )
			Convars.SetValue( "inferno_max_range", 250 )
			Convars.SetValue( "inferno_flame_spacing", 25 )
		}
		break;
	}
}
//LOADING FILE
local execscriptName=g_MapName
if (nowexecScriptName!="")
	execscriptName=nowexecScriptName
Msg(".................................execScriptName: " + execscriptName + "\n");
aMapLogic(execscriptName);
Msg("Loaded: amap.nut\n");