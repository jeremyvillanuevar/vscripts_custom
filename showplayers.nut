printf( "\n\n\n\n==============Loaded SHOWPLAYERS =============== %f\n\n\n\n", __COOP_VERSION__);

//============================Clasificación de cálculo=计算排行=======================================//
::PlayerKillCout <- {}; 
::PlayerRandCout <- {}; 
::PlayerRankLine <- {}; 
::KillsCout <- 0;
// En la etapa inicial de maximizar la memoria de video de clasificación, Left 4 Dead 2 solo puede tener hasta 32 slot.
// L4DToolZ establece 33slot y compila y ejecuta el juego y el resultado es malo 33 .. Demuestra que solo pueden sobrevivir 32 personas. Estas 32 personas incluyen todos los personajes operables. El modo de batalla: no es más que más personas y menos SI.
// Inicialice todos y luego use algunos de ellos según sea necesario. De lo contrario, si hay más de 4 personas o el servidor está vacío con 0 jugadores, el índice 'número' se indicará en rojo. El índice 'número' no existe
//排行显存最大化初始，求生之路2最大只能是32playerslot。
//L4DToolZ设置33slot并且编译运行游戏结果是bad 33.。证明求生只能32人，这32人含所有可操作角色，战役模式：无非人多一点特感就少一点，
//全部初始化，后根据需要使用其中的一部分。否则大于4人或者是服务器空置0玩家，会报红字the index '数字' does not exist
for(local i=0;i < 32;i++)
{
	PlayerRankLine[i] <- "";
	
}

::removed_common_spawns <- false;
::ClearEdicts<- false;
::TimeTick <- 0;
::Client_Count <- 0;
::GameDifficulty <- 0;
//Ejecutado a cada rato
function VSLib::EasyLogic::Update::NamesUpdate()
{
	//Msg("DateUpDate \n");

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
	foreach( survivor in ::VSLib.EasyLogic.Players.Survivors() )
	{
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
	
}

// Grande-> pequeño//大->小
::CompareFunc <- function(a,b)
{
	if(PlayerKillCout[a]>PlayerKillCout[b]) return -1
	else if(PlayerKillCout[a]<PlayerKillCout[b]) return 1
	return 0;
} 
::RandomFunc <- function(a,b)
{
	if(PlayerRandCout[a]>PlayerRandCout[b]) return -1
	else if(PlayerRandCout[a]<PlayerRandCout[b]) return 1
	return 0;
} 



function Notifications::OnModeStart::GameStart(gamemode)
{			
	Msg("ShowRank"+"\n");
	ShowRank();
	GameDifficulty = ::VSLib.Utils.GetDifficulty();
}

function Notifications::OnDifficultyChanged::DifficultyChanged(diff, olddiff)
{			
	GameDifficulty = diff
}


//==================================RankingTop3=======排行显示前4名玩家==============================================//
::ShowRank <- function()
{	
	local hudtip1 = HUD.Item("{rank01}\n{rank02}\n{rank03}\nde {clientcount} amigos | D:{difficulty}");//\n{rank04}\n{rank05}\n{rank06}\n{rank07}\n{rank08}");
	hudtip1.SetValue("rank01", rank01);
	hudtip1.SetValue("rank02", rank02);
	hudtip1.SetValue("rank03", rank03);
	hudtip1.SetValue("clientcount", fnclientcount);
	hudtip1.SetValue("difficulty", fndifficulty);
	/*
	hudtip1.SetValue("rank04", rank04);
	hudtip1.SetValue("rank05", rank05);
	hudtip1.SetValue("rank06", rank06);
	hudtip1.SetValue("rank07", rank07);
	hudtip1.SetValue("rank08", rank08);
	*/
	hudtip1.AttachTo(HUD_FAR_LEFT);
	hudtip1.ChangeHUDNative(0, 0, 380, 110, 1280, 720);//(x, y, width, height, resx, resy)
	hudtip1.SetTextPosition(TextAlign.Left);
	hudtip1.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
	local hudtip2 = HUD.Item("33 B: {killcout}");//\n{rank05}\n{rank06}\n{rank07}\n{rank08}");
	hudtip2.SetValue("killcout", fnkillcout);
	hudtip2.AttachTo(HUD_FAR_RIGHT);
	hudtip2.ChangeHUDNative(1100, 0, 180, 20, 1280, 720);//(x, y, width, height, resx, resy)
	hudtip2.SetTextPosition(TextAlign.Left);
	hudtip2.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 		
	/*
::HUD_RIGHT_TOP <- g_ModeScript.HUD_RIGHT_TOP;
::HUD_RIGHT_BOT igual arriba
::HUD_MID_TOP <- g_ModeScript.HUD_MID_TOP;
::HUD_MID_BOT igual arriba
::HUD_LEFT_TOP <- g_ModeScript.HUD_LEFT_TOP;
::HUD_LEFT_BOT igual arriba
::HUD_TICKER EN EL CENTRO DE LA PANTALLA ARRIBA DEBAJO DE MIDBOX
::HUD_MID_BOX EN EL CENTRO DE LA PANTALLA ARRIBOTA
::HUD_FAR_LEFT <- g_ModeScript.HUD_FAR_LEFT;
::HUD_FAR_RIGHT <- g_ModeScript.HUD_FAR_RIGHT;
::HUD_SCORE_TITLE EN EL CENTRO DE LA PANTALLA MEDIO
::HUD_SCORE_1 <- g_ModeScript.HUD_SCORE_1;
::HUD_SCORE_2 <- g_ModeScript.HUD_SCORE_2;
::HUD_SCORE_3 <- g_ModeScript.HUD_SCORE_3;
::HUD_SCORE_4 <- g_ModeScript.HUD_SCORE_4;
*/
	
}

::rank01 <- function ()
{
	return PlayerRankLine[0];
}

::rank02 <- function ()
{
	return PlayerRankLine[1];
}

::rank03 <- function ()
{
	return PlayerRankLine[2];
}

::rank03 <- function ()
{
	return PlayerRankLine[2];
}

::fnkillcout <- function ()
{
	return KillsCout;
}

::fnclientcount <- function ()
{
	return Client_Count;
}
::fndifficulty <- function ()
{
	return GameDifficulty;
} 
::rank05 <- function ()
{
	return PlayerRankLine[4];
}
::rank06 <- function ()
{
	return PlayerRankLine[5];
}
::rank07 <- function ()
{
	return PlayerRankLine[6];
}
::rank08 <- function ()
{
	return PlayerRankLine[7];
}
 
::AttachParticle <- function(ent,particleName = "", duration = 0.0)
{	
	if (particleName=="achievedT"&&::tankcup)
		particleName="achieved"
	else
		if(!::headshotcup) return;
	local particle = g_ModeScript.CreateSingleSimpleEntityFromTable({ classname = "info_particle_system", targetname = "info_particle_system" + UniqueString(), origin = ent.GetEyePosition(), angles = QAngle(0,0,0), start_active = true, effect_name = particleName });
	if (!particle)
	{
		printl("Advertencia: No se pudo crear la entidad de partículas.");
		//printl("警告:创建粒子实体失败.");
		return;
	}
	DoEntFire("!self", "Start", "", 0, null, particle);
	DoEntFire("!self", "Kill", "", duration, null, particle);
	AttachOther(PlayerInstanceFromIndex(ent.GetIndex()),particle, true,ent.GetEyePosition());
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
 

::AttachOther <- function(entity,otherEntity, teleportOther,pos)
{
	teleportOther = (teleportOther.tointeger() > 0) ? true : false;
	if (teleportOther)
		otherEntity.SetOrigin(pos);
	DoEntFire("!self", "SetParent", "!activator", 0, entity, otherEntity);
}
