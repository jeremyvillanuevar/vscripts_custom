printl( "\n\n\n\n==============Loaded HOOKS ===============\n\n\n\n");
//-----------------------------------------------------
// Creating DirectorOptions on MapScript Scope 



function OnGameEvent_witch_spawn(params)
{	
	Msg("OnGameEvent_witch_spawn"+"\n");
	//TimeTick4WitchMsg=10;
	local mensaje="Aparece una Witch, ataquen en grupo!!!"
	ShowHUDTicker(4,"Witch",mensaje)
}

::OnCustomFinaleStageChangeHook <- function ( )
{
	Msg("OnCustomFinaleStageChangeHook"+"\n");
	TimeTick4Rescue=15
	if (nowFinaleStageNum < DirectorScript.MapScript.DirectorOptions.A_CustomFinale_StageCount )
		ClientPrint(null, 3, BLUE+"Comenzando el Finale: Fase " + nowFinaleStageNum + " de " + DirectorScript.MapScript.DirectorOptions.A_CustomFinale_StageCount + " fases. Tipo " + numTypetoTypeString(nowFinaleStageType));
	else 
		ClientPrint(null, 3, BLUE+"Enhorabuena, el vehículo ha llegado, procura que todos entren!");
}

function VSLib::EasyLogic::OnActivate::RoundStart(modename, mapname)
{			
	Msg("OnActivate"+"\n");	
	//ShowRank();
	//GameDifficulty = Utils.GetDifficulty();
	// @todo: put scoring back into holdout!
	g_ModeScript.Scoring_LoadTable( SessionState.MapName, SessionState.ModeName )	

	// this is so we can do some non-wave-based thinking
	// With this function it will update every 2.5 seconds
	//g_ModeScript.ScriptedMode_AddSlowPoll( DirectorScript.MapScript.LocalScript.HoldoutSlowPollUpdate )
	
}

function VSLib::EasyLogic::OnShutdown::GameShutdown(reason, nextmap)
{		
	Msg("OnShutdown"+"\n");	
	nowMatchEnded=1;
	//g_ModeScript.ScriptedMode_RemoveSlowPoll( HoldoutSlowPollUpdate )
}

//Speeds the game up just fractionally when the map transition starts
function Notifications::OnMapEnd::speedLoader()
{	
	Msg("speedLoader"+"\n");
	survivorsParticleHead();
	survivorsYellCelebration();
	survivorsYellCelebration();
	Utils.SlowTime(0.2);
	//Utils.SlowTime(2, 2.0, 1.0, 2.0, false);
	local mensaje="Felicidades! Están a salvo y limpiaron la zona!";
	ShowHUDTicker(4,"Ad",mensaje);
	Utils.SayToAll(mensaje);
	local nombres = "Bien Hecho a cada uno de ustedes "+nowSurvivorsinGame+": ";
	foreach( survivor in ::VSLib.EasyLogic.Players.Survivors() )//gives a Player
	{		
		nombres=nombres+survivor.GetName()+" ";
		if (survivor.IsHuman())
		{
			survivor.Print("Zombis Eliminados: "+fnkillcout());
			survivor.ShowHint("Bien Hecho "+survivor.GetName());
		}
	}
	Utils.ShowHintSurvivors(nombres,3,"icon_arrow_up");
}

::survivorsPrint <- function (mensaje)
{	
	foreach( survivor in ::VSLib.EasyLogic.Players.Survivors() )//gives a Player
	{		
		if (survivor.IsHuman())
		{
			survivor.Print(mensaje);
		}
	}
}	
::survivorsHint <- function (mensaje)
{	
	foreach( survivor in ::VSLib.EasyLogic.Players.Survivors() )//gives a Player
	{		
		if (survivor.IsHuman())
		{
			survivor.ShowHint(mensaje);
		}
	}
}	

::survivorsParticleHead <- function ( )
{	
	foreach( survivor in ::VSLib.EasyLogic.Players.Survivors() )//gives a Player
	{		
		//if(survivor.IsBot())
		//	continue;
		local achTemp="achieved"
		AttachParticleCongrats(survivor,achTemp, 3.0);
	}
}	
	
::survivorsYellCelebration <- function ( )
{
	foreach( survivor in ::VSLib.EasyLogic.Players.Survivors() )//gives a Player
	{		
		if (survivor.GetCharacterName() =="Zoey")
			survivor.Speak( "hurrah54", 0 )
		else
		if (survivor.GetCharacterName() =="Bill")
			survivor.Speak( "hurrah02", 0 )
		else
			survivor.Speak( "hurrah01", 0 )
	}
	/*
player <- null;
while(player = Entities.FindByClassname(player, "player"))   // Iterate through the script handles of the players.
{
    DoEntFire("!self", "speakresponseconcept", "PlayerLaugh", 0, null, player); // Make each player laugh.
}
*/
}


//Any door shuts
// function Notifications::OnRescueDoorOpened::cerrarSafeDoor(entity, door, params)
// {
		// ShowHUDTicker(4,"Ad","OnRescueDoorOpened");
// }

//AnyDoor
// function Notifications::OnDoorClosed::cerrarSafeDoor(entity, checkpoint, params)
// {
	// if (entity)//Door Closed
	// {
		// ShowHUDTicker(4,"Ad","Si entran 75%, cerrar se tpearán!");
	// }
	// else//Map Starts Door Spawns
	// {
	// }
//}
// function OnGameEvent_player_entered_checkpoint(event)
// {
	// if ("userid" in event && GetFlowPercentForPosition(EntIndexToHScript(event.door).GetOrigin(), false) > 50)
	// {
		// OnSafe(GetPlayerFromUserID(event.userid));
	// }
// }

//function OnGameEvent_player_entered_checkpoint(params)
function Notifications::OnEnterSaferoom::pasarSafeRoom ( client, params )
{
	Msg("pasarSafeRoom"+"\n");
	local player = ::VSLib.Player(client);
	if (GetFlowPercentForPosition(EntIndexToHScript(params["door"]).GetOrigin(), false) > 50)
	{
		player.ShowHint("Cuando entran el 75%, cierra y se tpearán!",0.8);
		setBalanceDirectorOptions(params);
	}
}


function Notifications::OnSurvivorsLeftStartArea::Inicio()
{			
	Msg("OnSurvivorsLeftStartArea"+"\n");
	if (nowPlayersinGame>4)
	{	
		SpawnWitch();		
	}
	Timers.AddTimer(60-5*nowPlayersinGame, true, SpawnWitch);
	Timers.AddTimer(18.0, true, setBalanceDirectorOptions);
}


//Controls sequence of function execution (re-organise at your own risk)
function OnGameEvent_round_start_post_nav(params)
{
	Msg("OnGameEvent_round_start_post_nav"+"\n");
	Utils.ResumeTime();
	initializeAllFrameworkGlobalVariables();
	initializeGameMode();
	initializeDifficulty();
	establishMapType();
	Timers.AddTimer(1.0, true, NamesUpdate, params);
	mountedBarrierRandomizer(params);
	hurtKills();
	spawnForMapSpecificData(params);
	if ((developer() > 0) || (DEBUG == 1))
	{
		skipIntro();
	}
	
	//Utils.SlowTime(0.5, 2.0, 1.0, 2.0, true);
	//initializeAllTADMGlobalVariables();
	// randomisedArrays();
	// alternateCvars();
	// randomAlterCvars(params);
	// checkForChampionTime(params);
	// multiTankRandomizerIndice(params);

	//Timers.AddTimer(3, false, itemSpawningManager,params);
	// checkForMapSpecificData(params);
	Timers.AddTimer(4, false, instaKillEntities, params);
	Timers.AddTimer(7, false, entityShifter, params);
	// Timers.AddTimer(0.1, true, playerAttackMovementManager);
	// Timers.AddTimer(1, true, oxyTankChase);
	// Timers.AddTimer(30, true, playerMovementCalculator);
	// Timers.AddTimer(RandomInt(tRFTR[tODMI],tRFTR[tODMA]), true, timedRandomizerTiered, params);
	// Timers.AddTimer(RandomInt(tRFTR[tODMI],tRFTR[tODMA]), true, timedRandomiserDifficulty, params);
	// Timers.AddTimer(45, true, timedProgressUpdate, params);
	// Timers.AddTimer(120, true, randomAlterCvars, params);
	// Timers.AddTimer(3, true, timedZombieScaleModifier);
	
	//Timers.AddTimer(60,true,ShowHUDTicker,
	//	{
	//	numero = 5
	//	tipo="Mention"
	//	})
		
	//local mensaje = "Bienvenidos a 33"
	//ShowHUDTicker(4,"Ad",mensaje);
}

function Notifications::OnDifficultyChanged::DifficultyChanged(diff, olddiff)
{			
	GameDifficulty = diff
}


::ClearScores <- function()
{
	//local player = ::VSLib.Player(client);
	

	foreach ( survivor in ::VSLib.EasyLogic.Players.Survivors() )
	{	
		if(survivor.IsHuman())
		{
			survivor.SetNetProp( "m_checkpointZombieKills", 1699 );
			survivor.SetNetProp( "m_missionZombieKills", 1699 );
			survivor.SetNetProp( "m_checkpointMeleeKills", 99999 );
			survivor.SetNetProp( "m_missionMeleeKills", 99999 );
			survivor.SetNetProp( "m_checkpointIncaps", 99999 );
			survivor.SetNetProp( "m_missionIncaps", 99999 );
			survivor.SetNetProp( "m_checkpointDamageToTank", 99999 );
			survivor.SetNetProp( "m_checkpointDamageToWitch", 99999 );
			//data
			survivor.SetNetProp( "m_iFrags", 99999 );
			//(_classname, _targetname = "", pos = Vector(0,0,0), ang = QAngle(0,0,0), kvs = {})
			local game_score_index = null;
			game_score_index = ::VSLib.Utils.SpawnEntity("game_score","gamescoreEnt");
			//bool AcceptEntityInput(int dest, const char[] input, int activator, int caller, int outputid)
			//AcceptEntityInput(game_score_index, "ApplyScore", attacker, 0); 
			//Input(input, value = "", delay = 0, activator = null)
			//DoEntFire("!self", input.tostring(), value.tostring(), delay.tofloat(), activator, _ent);
			
			if(PlayerKillCout.rawin(survivor.GetIndex()))
			{
				local newScore = 9999;//PlayerKillCout[survivor.GetIndex()]*-1;
				//AN ERROR HAS OCCURED [the index 'instance' does not exist] }
				game_score_index.Input("ApplyScore",newScore.tostring(),0.0,client)
				//
				// Arguments: <entity name>, <input>, <parameter override>, <delay>, <caller>, <activator>
				//DoEntFire( "gamescoreEnt", "ApplyScore",newScore.tostring(), 0.0, null, client);
				game_score_index.KillEntity()
			}
		}
		
	}

}
function Notifications::OnSurvivorsDead::MissionLost()
{
	Msg("OnSurvivorsDead"+"\n");	
	Utils.DirectorBeginScript("director_quiet");	
	ClearEdicts = true;
	// Después de un retraso de 6 segundos, el código de limpieza se ejecutará 1-2 veces.
	//No establezca más de 7 segundos.
	//延迟6秒后大概清理代码会执行1-2次。不要设置大于7秒。
	Time4Tick = 6;
	// Debido a la ejecución directa de una limpieza de sentido especial, será más abrupta.
	//Así que retrasa el procesamiento
	// ¿La función addtimer no es válida después de este evento?
	//由于直接执行特感清理，会显得比较突兀。所以延迟处理
	//该事件之后addtimer函数无效？
}

	
function Notifications::OnChargerCarryVictim::pruebaCharger( entity, victim, params)
{
	Utils.SlowTime(0.5)
}
	
function Notifications::OnDeath::PlayerDeath( victim, attacker, params)
{
	if (!victim || !attacker || victim.GetIndex() == attacker.GetIndex())
		return;
	switch(victim.GetClassname())
	{
		case "infected":
		{
			if(!::AllowShowBotSurvivor)
				{
					if(attacker.GetTeam() == SURVIVORS)
					{
						if(!attacker.IsBot())										
						{
							KillsCout++;							
						}
					}
				}
			break;
		}
		case "player":
		{
			if(victim.GetType() == Z_TANK) 
			{
				foreach( survivor in ::VSLib.EasyLogic.Players.AliveSurvivors() )
				{
					local achTemp ="achievedT"
					AttachParticle(survivor,achTemp, 3.0);
					
					local mensaje="Bien!! Derrotaste al Boss, avanza!";					
					//TimeTick4BossDefeatedMsg=10;
					
					local tankName=survivor.GetName();
					local nameCloneTank=tankName.find("Clone Tank");
					local nameSecond=tankName.find("(");					
					if (!((nameCloneTank!=null) && (nameSecond!=null)))
					{
						ShowHUDTicker(2,"Tank",mensaje);	
						Utils.SlowTime(0.5);
					}
					// No configures, la sangre se llena//不设置 虚血变成实血
					//survivor.SwitchHealth("perm");
					//HealthReg(survivor,tankgiveheal);	
					//local pos = victim.GetPosition();
					//pos.z += 72.0;					
					//::ItemLoot(pos);
					if(!::AllowShowBotSurvivor)
					{
						if(!attacker.IsBot()) 
						{						
							KillsCout++;
						}
					}
				}	
				break;
			}
		
			if( INFECTED == victim.GetTeam() && SURVIVORS == attacker.GetTeam())
			{
				if(!::AllowShowBotSurvivor)
				{
					if(!attacker.IsBot())
					{
						if(!PlayerKillCout.rawin(attacker.GetIndex()))
						{
							PlayerKillCout[attacker.GetIndex()] <- 1;		
						}else
							PlayerKillCout[attacker.GetIndex()]++;
						KillsCout++;
					}
				}
				else
					if(!PlayerKillCout.rawin(attacker.GetIndex()))
					{
						PlayerKillCout[attacker.GetIndex()] <- 1;		
					}else
						PlayerKillCout[attacker.GetIndex()]++;	
				//local _randHeal =RandomInt(healreg[0],healreg[1]);	
				//attacker.Speak("nicejob01");	
				if(!attacker.IsIncapacitated() && params["headshot"])
				{
					//HealthReg(attacker,_randHeal+headshot_add);
					//local pos = victim.GetPosition();
					//pos.z += 72.0;
					// El jugador dirá buen trabajo//玩家会说nicejob
	
					local achTemp ="achieved"
					// Muestra un trofeo en la cabeza del jugador. Si el jugador tiene un tiro en la cabeza//在玩家头上显示一个奖杯。如果玩家爆头特感
					AttachParticle(attacker,achTemp, 3.0);
				
					//if(RandomFloat(0.0,100.0) > ::loot_chance)
					//{
						//::ItemLoot(pos);
					//}
				}
				else
				{
					//HealthReg(attacker,_randHeal);
				}
				break;
			}
			break;
		}
		case "witch":
		{
			if(SURVIVORS == attacker.GetTeam())
			{
				//local pos = victim.GetPosition();
				//pos.z += 72.0;		
				//::ItemLoot(pos);
				//attacker.SwitchHealth("perm");
				//HealthReg(attacker,witchgiveheal);
				
				local mensaje="Bien!! Derrotaron a la Witch!"
				ShowHUDTicker(2,"Witch",mensaje);
				Utils.SlowTime(0.5);
					
				if(!::AllowShowBotSurvivor)
				{
					if(!attacker.IsBot())
					{
						if(!PlayerKillCout.rawin(attacker.GetIndex()))
						{
							PlayerKillCout[attacker.GetIndex()] <- 1;		
						}else
							PlayerKillCout[attacker.GetIndex()]++;
						KillsCout++;
					}
				}
				else
					if(!PlayerKillCout.rawin(attacker.GetIndex()))
					{
						PlayerKillCout[attacker.GetIndex()] <- 1;		
					}else
						PlayerKillCout[attacker.GetIndex()]++;
				
				if(!attacker.IsIncapacitated())
				{
					local achTemp ="achieved"
					AttachParticle(attacker,achTemp, 3.0);					
				}
			}
			break;		
		}	
	}
}
 

function Notifications::OnModeStart::GameStart(gamemode)
{			
	Msg("OnModeStart"+"\n");	
}

function Notifications::OnPlayerLeft::ModifyDirectorLeft (client, name, steamID, params)
{
	if (Time4Connections<=0)
	{
		
	}
	else
	{
		if ((developer() > 0) || (DEBUG == 1))
		{
			ClientPrint(null, 3, BLUE+"Time4Connections "+Time4Connections);
			ClientPrint(null, 3, BLUE+"nowStartConnections "+nowStartConnectionsnum);
		}
		local player = ::VSLib.Player(client);	
		if	(
		(player.IsHuman())
		|| 
		( player.GetPlayerType()==Z_SURVIVOR && ((developer() > 0) || (DEBUG == 1)) )
		)
			nowStartConnections.insert(nowStartConnectionsnum++,client);
		if ((developer() > 0) || (DEBUG == 1))
		{
			ClientPrint(null, 3, BLUE+"nowStartConnections "+nowStartConnectionsnum);
		}
	}
	
	
	if ( (developer() > 0) || (DEBUG == 1))
	{
		ClientPrint(null, 3, BLUE+"OnPlayerLeft "+name);
	}
	local player = ::VSLib.Player(client);	
	local esta = false
	if (Time4Connections>0)
	{
		if ((developer() > 0) || (DEBUG == 1))
		{
			ClientPrint(null, 3, BLUE+"Time4Connections "+Time4Connections);		
		}
		for(local i=0;i < nowStartConnections.len();i++)
		{
			if ((developer() > 0) || (DEBUG == 1))
			{
			ClientPrint(null, 3, BLUE+"nowStartConnections[i] "+nowStartConnections[i]);
			ClientPrint(null, 3, BLUE+"client "+client);
			}
			if (nowStartConnections[i]==client)
				esta = true
		}
	}
	
	if (
		(player.IsHuman())
		|| 
		( player.GetPlayerType()==Z_SURVIVOR && ((developer() > 0) || (DEBUG == 1)) )
		)
	{
		CalculateNumberofPlayers()
		nowPlayerEvent="Left"
		nowPlayerLeft=player.GetName();
		if (!esta)
			//TimeTick4ConnectMsg=9
			ShowHUDTicker(3,nowPlayerEvent,nowPlayerLeft)
		//Timers.RemoveTimerByName(nowPlayerLeft+modifySpeedAR);
		setBalanceDirectorOptions(params);
	}
}
function Notifications::OnPlayerConnected::onStartingConnections (client, params)
{
	/*
	if (Time4Connections<=0)
	{
		
	}
	else
	{
		if ((developer() > 0) || (DEBUG == 1))
		{
		ClientPrint(null, 3, BLUE+"Time4Connections "+Time4Connections);
		ClientPrint(null, 3, BLUE+"nowStartConnections "+nowStartConnectionsnum);
		}
		local player = ::VSLib.Player(client);	
		if	(player.IsHuman())
			nowStartConnections.insert(nowStartConnectionsnum++,client);
		if ((developer() > 0) || (DEBUG == 1))
		{
		ClientPrint(null, 3, BLUE+"nowStartConnections[i] "+nowStartConnections[i]);
		ClientPrint(null, 3, BLUE+"client "+client);
		}
	}
	*/
}

function Notifications::OnPlayerJoined::ModifyDirectorJoin (client, name, ipAddress, steamID, params)
{
	if (Time4Connections<=0)
	{
		
	}
	else
	{
		if ((developer() > 0) || (DEBUG == 1))
		{
			ClientPrint(null, 3, BLUE+"Time4Connections "+Time4Connections);
			ClientPrint(null, 3, BLUE+"nowStartConnections "+nowStartConnectionsnum);
		}
		local player = ::VSLib.Player(client);	
		if	(
		(player.IsHuman())
		|| 
		( player.GetPlayerType()==Z_SURVIVOR && ((developer() > 0) || (DEBUG == 1)) )
		)
			nowStartConnections.insert(nowStartConnectionsnum++,client);
		if ((developer() > 0) || (DEBUG == 1))
		{
			ClientPrint(null, 3, BLUE+"nowStartConnections "+nowStartConnectionsnum);
		}
	}
	
	if ( (developer() > 0) || (DEBUG == 1))
	{
		ClientPrint(null, 3, BLUE+"OnPlayerJoined "+name);
	}	
	local player = ::VSLib.Player(client);	
	local esta = false
	
	if (Time4Connections>0)
	{
		if ((developer() > 0) || (DEBUG == 1))
		{
			ClientPrint(null, 3, BLUE+"Time4Connections "+Time4Connections);
		}
		for(local i=0;i < nowStartConnections.len();i++)
		{
			if ((developer() > 0) || (DEBUG == 1))
			{	
				ClientPrint(null, 3, BLUE+"nowStartConnections[i] "+nowStartConnections[i]);
				ClientPrint(null, 3, BLUE+"client "+client);
			}
			if (nowStartConnections[i]==client)
				esta = true
		}
	}
	if (
		(player.IsHuman())
		|| 
		( player.GetPlayerType()==Z_SURVIVOR && ((developer() > 0) || (DEBUG == 1)) )
		)
	{
		
		CalculateNumberofPlayers()
		nowPlayerEvent="Join"
		nowPlayerJoined=player.GetName();
		if (!esta)
			ShowHUDTicker(6,nowPlayerEvent,nowPlayerJoined)
			//TimeTick4ConnectMsg=9
		//Timers.AddTimerByName(nowPlayerJoined+modifySpeedAR,3, true, modifySpeedAR,client);
		setBalanceDirectorOptions(params);
	}
}

function Notifications::OnNextMap::NextMap(nextmap)
{			
	Msg("OnNextMap"+"\n");	
	//Timers.RemoveTimerByName ( "SpawnWitchTimer" );
}
function Notifications::OnPanicEvent::Iniciado(entity, params)
{
//	TimeTick4PanicMsg=10;
	local mensaje = "PANIC: Derroten juntos a la horda!!!";
	ShowHUDTicker(4,"PANIC",mensaje)
	
}

function Notifications::OnHealSuccess::completaCuracion ( healee, healer, health, params )
{
	nowPlayerHealer=healer.GetName();
	nowPlayerHealed=healee.GetName();
	if ( (developer() > 0) || (DEBUG == 1))
	{
		if (healer.GetIndex()!=healee.GetIndex())
			//TimeTick4HealMsg=10;
			ShowHUDTicker(5,"Heal",healer.GetName(),healee.GetName())
	}
	else
		if (!(healer.IsBot()) &&!(healee.IsBot()) && (healer.GetIndex()!=healee.GetIndex()))
			ShowHUDTicker(5,"Heal",healer.GetName(),healee.GetName())
			//TimeTick4HealMsg=10;
}


function Notifications::OnPanicEventFinished::Finalizado()
{
	ClientPrint(null, 3, BLUE+"YEAH! Ustedes derrotaron la horda!!");
		survivorsParticleHead();		
		survivorsYellCelebration();
		survivorsYellCelebration();
}


function Notifications::OnFinaleStart::Final(campaign, params)
{
	ClientPrint(null, 3, BLUE+"Comenzando el Finale de la Campaña: " + campaign);	
	if ( "A_CustomFinale_StageCount" in DirectorScript.MapScript.DirectorOptions )
	{
		ClientPrint(null, 3, BLUE+"Esta vez tienen " + DirectorScript.MapScript.DirectorOptions.A_CustomFinale_StageCount+" etapas para ser rescatados.");	
	}
}


function Notifications::OnFinaleWin::Final(map_name, diff, params)
{
	//ClientPrint(null, 3, BLUE+"FELICIDADES lograron: " + map_name);	
	//if ( "A_CustomFinale_StageCount" in DirectorScript.MapScript.DirectorOptions )
	//{
	//	Timers.RemoveTimerByName ( "OnBeginCustomFinaleStageTimer" );
	//}
}


//Displays the name of the mod at the end of the game
function Notifications::OnRescueVehicleLeaving::outTheDoor(count, params)
{
	if (alreadyPlayed == 0)
	{
		Timers.RemoveTimer(NamesUpdate);
		Timers.RemoveTimer(setBalanceDirectorOptions);
		Timers.RemoveTimer(SpawnWitch);
		Timers.RemoveTimer(ShowHUDTicker)
		//Utils.SayToAllDel("You have been playing... ");
		//Timers.AddTimer(1, false, messageCompleteGame, params);		
		Utils.SlowTime(1.75, 2.0, 1.0, 1.5, false);
	}
	//alreadyPlayed makes sure that the end game message only appears once
	alreadyPlayed = 1;
	Msg("Executed: OnRescueVehicleLeaving outTheDoor function\n");
}

function Notifications::OnVersusMatchFinished::thatGameWas(winners, params)
{
	if (alreadyPlayed == 0)
	{
		Timers.RemoveTimer(NamesUpdate);
		Timers.RemoveTimer(setBalanceDirectorOptions);
		Timers.RemoveTimer(SpawnWitch);
		Timers.RemoveTimer(ShowHUDTicker)
		//Utils.SayToAllDel("You have been playing... ");
		//Timers.AddTimer(1, false, messageCompleteGame, params);
	}
	alreadyPlayed = 1;
	Msg("Executed: OnVersusMatchFinished thatGameWas function\n");
}



//Uses a convar to record a map restart
// function OnShutdown()
// {
	// if ( SessionState.ShutdownReason == 1 || SessionState.ShutdownReason == 2 )
	// {
		// Convars.SetValue("director_short_finale" , "1");
		// Msg("Executed: OnShutdown function\n");
	// }
// }


//Returns friction for the adrenaline duration, see playerAttackMovementManager function (atfunc.nut)
// function Notifications::OnAdrenalineUsed::adrenalineSpeedController(entity, params)
// {
	// pFC[entity.GetSurvivorCharacter()] = 100;
	// entity.SetFriction(1);
	// Msg("Executed: adrenalineSpeedController function\n");
// }

// function Notifications::OnHunterPouncedVictim::crawlController(entity, victim, params)
// {
	// pFC[victim.GetSurvivorCharacter()] = 100;
	// victim.SetFriction(50);
	// Msg("Executed: crawlController function\n");
// }

// function Notifications::OnHunterPounceStopped::movementReturnController(entity, victim, params)
// {
	// pFC[victim.GetSurvivorCharacter()] = 0;
	// victim.SetFriction(1);
	// Msg("Executed: movementReturnController function\n");
// }

// function Notifications::OnHunterPounceFailed::removeFrictionController(player, params)
// {
	// pFC[player.GetSurvivorCharacter()] = 0;
	// player.SetFriction(1);
	// Msg("Executed: removeFrictionController function\n");
// }

// function Notifications::OnHunterReleasedVictim::anotherFrictionRemovalController(entity, victim, params)
// {
	// pFC[victim.GetSurvivorCharacter()] = 0;
	// victim.SetFriction(1);
	// Msg("Executed: anotherFrictionRemovalController function\n");
// }

//Build custom Special Infected, and Tanks.
function Notifications::OnSpawn::spawnManager(player, params)
{
	// alterMonsterIndices(params);
	switch (player.GetType())
	{
		// case Z_JOCKEY:
			// if (dAAN > 2 || gMV == "versus")
			// {
				// supplementTankRandomizer(player);
			// }
			// if (mINOD == 1 && RandomInt(1,4) == 1)
			// {
				// crepuscularJockeyBuilder(player, params)
			// }
			// else
			// {
				// masterJockeyBuilder(player, params);
			// }
			// break;
		// case Z_SPITTER:
			// if (dAAN > 2 || gMV == "versus")
			// {
				// supplementTankRandomizer(player);
			// }
			// if (mINOD == 1 && RandomInt(1,4) == 1)
			// {
				// crepuscularSpitterBuilder(player, params)
			// }
			// else
			// {
				// masterSpitterBuilder(player, params);
			// }
			// break;
		// case Z_HUNTER:
			// if (dAAN > 2 || gMV == "versus")
			// {
				// supplementTankRandomizer(player);
			// }
			// alterHunter(player, params);
			// break;
		// case Z_CHARGER:
			// if (dAAN > 2 || gMV == "versus")
			// {
				// supplementTankRandomizer(player);
			// }
			// alterCharger(player, params);
			// break;
		// case Z_SMOKER:
			// if (dAAN > 2 || gMV == "versus")
			// {
				// supplementTankRandomizer(player);
			// }
			// alterSmoker(player, params);
			// break;
		// case Z_BOOMER:
			// if (dAAN > 2 || gMV == "versus")
			// {
				// supplementTankRandomizer(player);
			// }
			// if (championTime == 1 && gMV != "versus")
			// {
				// uglySisters(player,params);
				// pBSL = player.GetLocation();
				// Timers.AddTimer(1, false, spawnNewSister, player);
			// }
			// if (championTime > 1 && lastSister == 0 && gMV != "versus")
			// {
				// alterBoomer(player,params);
			// }
			// if (championTime > 1 && lastSister == 1 && gMV != "versus")
			// {
				// uglySisters(player,params);
			// }
			// if (gMV != "versus")
			// {
				// Timers.AddTimer(6, false, checkForChampionTime, params);
			// }
			// break;
		case Z_TANK:
			Timers.AddTimer(0.1,false,spawnedTankTF,player)
			// Timers.AddTimer(15, false, tankCheck,player);
			// multiTankManager(player);
			// masterTankBuilder(player, params);
			break;
		default:
			Msg("Defaulted: spawnManager\n");
			Msg("Detected player type: " + player.GetType() + "\n");
			break;
	}
}
