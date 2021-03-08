printl( "\n\n\n\n==============Loaded HOOKS ===============\n\n\n\n");
//-----------------------------------------------------
// Creating DirectorOptions on MapScript Scope 

//Ejecutado a cada rato
function VSLib::EasyLogic::Update::NamesUpdate()
{
	//Msg("DateUpDate \n");
	if ( (developer() > 0) || (DEBUG == 1))
	{
		ClientPrint(null, 3, BLUE+"nowFinaleStageEvent "+nowFinaleStageEvent+"\n");
	}
	ShowHUD()
	if (nowFinaleStageEvent==1)
	{
		nowFinaleStageEvent = 0
		OnCustomFinaleStageChangeHook()
	}
	if(ClearEdicts)
	{
		TimeTick--
		if(TimeTick<=0)
		{
			printl("MissionLost Clear Edicts prevent  ED_Alloc:no free edicts for some map");
			foreach( Infected in ::VSLib.EasyLogic.Players.Infected())
			{
				Entity(Infected).KillEntity();
			}
			if( Director.GetCommonInfectedCount() >= 1 )
			{
				z <- null;
				while( ( z = Entities.FindByClassname( z, "infected" ) ) != null )
				{
					DoEntFire( "!self", "kill", "", 0, null, z );
				}
			}		
		}	
	}

	// Usado para clasificar//用于排序
	local KillNum = [];
	// Obtenga el número real de personas con Client_Count//获取实际人数
	local clientcount =0; 
	local survivorcount=0;
	nowPlayersIntensity=0;
	nowPlayersTimeAveragedIntensity=0;
	foreach( survivor in ::VSLib.EasyLogic.Players.Survivors() )
	{
		survivorcount++
		nowPlayersIntensity=nowPlayersIntensity+survivor.GetIntensity()
		nowPlayersTimeAveragedIntensity=nowPlayersTimeAveragedIntensity+survivor.GetTimeAveragedIntensity()
		if(survivor.IsBot())
			continue;	
		KillNum.insert(clientcount++,survivor.GetIndex());
		if(!PlayerKillCout.rawin(survivor.GetIndex()))
		{
			PlayerKillCout[survivor.GetIndex()] <- 0;	
			PlayerRandCout[survivor.GetIndex()] <- RandomInt(0,9);	
		}
	}	
	//printl ("Número real de personas:" + clientcount + "\n");
	// Actualiza los caracteres de visualización realmente necesarios. Evite quedarse
	// Si la condición es i <KillNum.len () cuando el bot es expulsado. O si el jugador se va, es posible que el elemento de la pantalla no se borre.
	// Por ejemplo, cuando hay 4 personas, cuando se elimina un bot, KillNum se convierte en 3 y el elemento de visualización en el cuarto salto no se borrará. Se borrará la entrada del jugador con el mismo nombre.
	// Configure 32 para limpiar todas las entradas al mismo tiempo. Evite el problema de los bots inexistentes o la retención de información del jugador
	//printl("实际人数:" + Client_Count+"\n");
	//刷新实际需要的显示字符。避免滞留
	//如果条件是 i < KillNum.len() 当bot被踢出。或者玩家离开，其显示条目可能不会被清除。
	//例如4人时，当去掉一个bot，那么KillNum就变成3，第4跳显示条目不会被清空。会出现同名玩家条目的清空。
	//设置32同时清理所有条目。避免出现不存在bot或者玩家信息滞留的问题
	for(local i=0;i < 32;i++)
	{
		PlayerRankLine[i] = "";
	}

	// Tamaño de fila//排大小
	KillNum.sort(RandomFunc);
	//KillNum.sort(CompareFunc);
	// Mostrar configuración. El nombre más largo debe expandirse a 20 "caracteres" por línea y 7 caracteres chinos.
	// Preparar cada cadena de visualización
	// De acuerdo con el resultado del número real. Aquí, si en realidad hay 4 personas, 
	//se puede limitar directamente a i <4, pero para que sea automáticamente compatible con 
	//varias personas, vaya a la parte más grande.
	//Porque no hay entidad de visualización, la parte extra no se mostrará incluso si hay números.
	//显示设定。 最长名字应该可以扩展到每行20个"字符" 汉字 7个字。
	//预备每条显示字符串
	//按实际数量输出 这里如果实际4人可以直接限制为i < 4，但是为了自动兼容多人，所以去最大，多出来的部分因为没有做显示实体，所以即使有数字也不会显示出来
	//killcout = 0;
	for(local i = 0; i < KillNum.len(); i++) // i < 4
	{
		if((Show_Player_Rank) == false) break;
	//	if(null == KillNum.find(i) ) break;	

		
		local NO = i+1;
		// Escala para nombres de más de 20 caracteres
		// 1. XX: 2 solamente
		//对于名字长度大于20字符的进行缩放 	
		//1.某某某：2 只
		if(PlayerInstanceFromIndex(KillNum[i]).GetPlayerName().len()>20)
			PlayerRankLine[i] = PlayerInstanceFromIndex(KillNum[i]).GetPlayerName().slice(0, 20);//NO+"."+PlayerInstanceFromIndex(KillNum[i]).GetPlayerName().slice(0, 20)+":"+PlayerKillCout[KillNum[i]]+"只";
		else
			PlayerRankLine[i] = PlayerInstanceFromIndex(KillNum[i]).GetPlayerName();//NO+"."+PlayerInstanceFromIndex(KillNum[i]).GetPlayerName()+":"+PlayerKillCout[KillNum[i]]+"只";
		//killcout = killcout + PlayerKillCout[KillNum[i]];
	
	}
	//KillsCout = killcout;

	//Msg("killcout "+killcout+"\n");
	Client_Count=clientcount;
	Survivors_Count=survivorcount;
	
}

::OnCustomFinaleStageChangeHook <- function ( )
{
	TimeTick4Timer=15
	if (nowFinaleStageNum < DirectorScript.MapScript.DirectorOptions.A_CustomFinale_StageCount )
		ClientPrint(null, 3, BLUE+"Comenzando el Finale: Fase " + nowFinaleStageNum + " de " + DirectorScript.MapScript.DirectorOptions.A_CustomFinale_StageCount + " fases. Tipo " + numTypetoTypeString(nowFinaleStageType));
	else 
		ClientPrint(null, 3, BLUE+"Enhorabuena, el vehículo ha llegado, procura que todos entren!");
}

function VSLib::EasyLogic::OnActivate::RoundStart(modename, mapname)
{			
	Msg("OnActivate"+"\n");	
	//ShowRank();
	//GameDifficulty = ::VSLib.Utils.GetDifficulty();
	// @todo: put scoring back into holdout!
	g_ModeScript.Scoring_LoadTable( SessionState.MapName, SessionState.ModeName )	

	// this is so we can do some non-wave-based thinking
	// With this function it will update every 2.5 seconds
	//g_ModeScript.ScriptedMode_AddSlowPoll( DirectorScript.MapScript.LocalScript.HoldoutSlowPollUpdate )
	
}

function VSLib::EasyLogic::OnShutdown::GameShutdown(reason, nextmap)
{		
	Msg("OnShutdown"+"\n");	
	//g_ModeScript.ScriptedMode_RemoveSlowPoll( HoldoutSlowPollUpdate )
}

function Notifications::OnDifficultyChanged::DifficultyChanged(diff, olddiff)
{			
	GameDifficulty = diff
}

function Notifications::OnEnterSaferoom::ClearScores ( client, params )
{
	local player = ::VSLib.Player(client);
	if(player.IsHuman())
	{
		player.SetNetProp( "m_checkpointZombieKills", 0 );
		player.SetNetProp( "m_missionZombieKills", 0 );
		player.SetNetProp( "m_checkpointMeleeKills", 0 );
		player.SetNetProp( "m_missionMeleeKills", 0 );
		player.SetNetProp( "m_checkpointIncaps", 0 );
		player.SetNetProp( "m_missionIncaps", 0 );
		player.SetNetProp( "m_checkpointDamageToTank", 0 );
		player.SetNetProp( "m_checkpointDamageToWitch", 0 );
		//data
		player.SetNetProp( "m_iFrags", 0 );
		//(_classname, _targetname = "", pos = Vector(0,0,0), ang = QAngle(0,0,0), kvs = {})
		local game_score_index = null;
		game_score_index = ::VSLib.Utils.SpawnEntity("game_score","gamescoreEnt");
		//bool AcceptEntityInput(int dest, const char[] input, int activator, int caller, int outputid)
		//AcceptEntityInput(game_score_index, "ApplyScore", attacker, 0); 
		//Input(input, value = "", delay = 0, activator = null)
		//DoEntFire("!self", input.tostring(), value.tostring(), delay.tofloat(), activator, _ent);
		
		if(PlayerKillCout.rawin(player.GetIndex()))
		{
			local newScore = PlayerKillCout[player.GetIndex()]*-1;
			//AN ERROR HAS OCCURED [the index 'instance' does not exist] }
			game_score_index.Input("ApplyScore",newScore.tostring(),0.0,client)
			//
			// Arguments: <entity name>, <input>, <parameter override>, <delay>, <caller>, <activator>
			//DoEntFire( "gamescoreEnt", "ApplyScore",newScore.tostring(), 0.0, null, client);
			game_score_index.KillEntity()
		}
	}
}
function Notifications::OnSurvivorsDead::MissionLost()
{
	Msg("OnSurvivorsDead"+"\n");	
	::VSLib.Utils.DirectorBeginScript("director_quiet");	
	ClearEdicts = true;
	// Después de un retraso de 6 segundos, el código de limpieza se ejecutará 1-2 veces.
	//No establezca más de 7 segundos.
	//延迟6秒后大概清理代码会执行1-2次。不要设置大于7秒。
	TimeTick = 6;
	// Debido a la ejecución directa de una limpieza de sentido especial, será más abrupta.
	//Así que retrasa el procesamiento
	// ¿La función addtimer no es válida después de este evento?
	//由于直接执行特感清理，会显得比较突兀。所以延迟处理
	//该事件之后addtimer函数无效？
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
						PlayerKillCout[attacker.GetIndex()]++;
						KillsCout++;
					}
				}
				else
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

				if(!::AllowShowBotSurvivor)
				{
					if(!attacker.IsBot())
					{
						PlayerKillCout[attacker.GetIndex()]++;
						KillsCout++;
					}
				}
				else
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
	//Timers.AddTimerByName("ShowHUDTimer", 2.5, true, ShowHUD(),null,0, {});
	local witchSpawnTime = 60.0;
	// By adding a timer by name, any timer that previously existed with the specified name will be overwritten.
	// The benefit is that you won't need to mess with timer indexes.
	Timers.AddTimerByName("SpawnWitchTimer", witchSpawnTime, true, SpawnWitch );
}

//function Notifications::OnMapFirstStart::MapFirstStart()
//{			
//}

function Notifications::OnSurvivorsLeftStartArea::Inicio()
{			
	Msg("OnSurvivorsLeftStartArea"+"\n");	
	SpawnWitch();
	IncludeScript ("debug_directoroptions.nut");	
}

function Notifications::OnPlayerLeft::ModifyDirectorLeft (client, name, steamID, params)
{
	if ( (developer() > 0) || (DEBUG == 1))
	{
		ClientPrint(null, 3, BLUE+"OnPlayerLeft "+name);
	}
	local player = ::VSLib.Player(client);	
	if (
		(player.IsHuman())
		|| 
		( player.GetPlayerType()==Z_SURVIVOR && ((developer() > 0) || (DEBUG == 1)) )
		)
	{
		if (nowFinaleStageEvent==0)
			BalanceDirectorOptions(0)
		else
			BalanceFinaleDirectorOptions(1)
	}
}

function Notifications::OnPlayerJoined::ModifyDirectorJoin (client, name, ipAddress, steamID, params)
{

	if ( (developer() > 0) || (DEBUG == 1))
	{
		ClientPrint(null, 3, BLUE+"OnPlayerJoined "+name);
	}
	local player = ::VSLib.Player(client);	
	if (
		(player.IsHuman())
		|| 
		( player.GetPlayerType()==Z_SURVIVOR && ((developer() > 0) || (DEBUG == 1)) )
		)
	{
		if (nowFinaleStageEvent==0)
			BalanceDirectorOptions(1)
		else
			BalanceFinaleDirectorOptions(1)
	}
}

function Notifications::OnNextMap::NextMap(nextmap)
{			
	Msg("OnNextMap"+"\n");	
	Timers.RemoveTimerByName ( "SpawnWitchTimer" );
}
function Notifications::OnPanicEvent::Iniciado(entity, params)
{
	ClientPrint(null, 3, BLUE+"PANIC: Derroten juntos a la horda!");
}
function Notifications::OnPanicEventFinished::Finalizado()
{
	ClientPrint(null, 3, BLUE+"YEAH! Ustedes derrotaron la horda!!");
	foreach( survivor in ::VSLib.EasyLogic.Players.Survivors() )//gives a Player
	{		
		//if(survivor.IsBot())
		//	continue;
		local achTemp="achieved"
		AttachParticleCongrats(survivor,achTemp, 3.0);
		if (survivor.GetCharacterName() =="Zoey")
			survivor.Speak( "hurrah54", 0 )
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
	ClientPrint(null, 3, BLUE+"FELICIDADES lograron: " + map_name);	
	if ( "A_CustomFinale_StageCount" in DirectorScript.MapScript.DirectorOptions )
	{
		Timers.RemoveTimerByName ( "OnBeginCustomFinaleStageTimer" );
	}
}


	