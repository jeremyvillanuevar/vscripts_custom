Msg( "\n\n\n\n==============Loaded SHOWPLAYERS =============== \n\n\n\n");

//============================Clasificación de cálculo=计算排行=======================================//

// En la etapa inicial de maximizar la memoria de video de clasificación, Left 4 Dead 2 solo puede tener hasta 32 slot.
// L4DToolZ establece 33slot y compila y ejecuta el juego y el resultado es malo 33 .. Demuestra que solo pueden sobrevivir 32 personas. Estas 32 personas incluyen todos los personajes operables. El modo de batalla: no es más que más personas y menos SI.
// Inicialice todos y luego use algunos de ellos según sea necesario. De lo contrario, si hay más de 4 personas o el servidor está vacío con 0 jugadores, el índice 'número' se indicará en rojo. El índice 'número' no existe
//排行显存最大化初始，求生之路2最大只能是32playerslot。
//L4DToolZ设置33slot并且编译运行游戏结果是bad 33.。证明求生只能32人，这32人含所有可操作角色，战役模式：无非人多一点特感就少一点，
//全部初始化，后根据需要使用其中的一部分。否则大于4人或者是服务器空置0玩家，会报红字the index '数字' does not exist


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

// Grande-> pequeño//大->小
::CompareFlow <- function(a,b)
{
	if(flowlist[a]>flowlist[b]) return -1
	else if(flowlist[a]<flowlist[b]) return 1
	return 0;
} 

/* en modifydirector
function Notifications::OnModeStart::GameStart(gamemode)
{			
}
*/


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
	hudtip1.AddFlag(HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
	local hudtip2 = HUD.Item("33 B: {killcout}");//\n{rank05}\n{rank06}\n{rank07}\n{rank08}");
	hudtip2.SetValue("killcout", fnkillcout);
	hudtip2.AttachTo(HUD_FAR_RIGHT);
	hudtip2.ChangeHUDNative(1100, 0, 180, 20, 1280, 720);//(x, y, width, height, resx, resy)
	hudtip2.SetTextPosition(TextAlign.Left);
	hudtip2.AddFlag(HUD_FLAG_NOBG|HUD_FLAG_BLINK); 		
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
	return nowPlayersinGame;
}
::fndifficulty <- function ()
{
	return GameDifficulty;
} 

::fninten <- function ()
{
	if (Survivors_Count ==0)
	 return 0
	else 
	return (nowPlayersIntensity/Survivors_Count);
}
::fntai <- function ()
{
	if (Survivors_Count ==0)
	 return 0
	else 
	return (nowPlayersTimeAveragedIntensity/Survivors_Count);
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
 
::playerJoined <- function ()
{
	return "Bienvenido "+nowPlayerJoined+"!!!";
}
::playerLeft <- function ()
{
	return nowPlayerLeft+" tuvo que irse";
}
 
::AttachParticle <- function(ent,particleName = "", duration = 0.0)
{	
	if (nowMatchEnded==0)
	{
		local intRand = RandomInt(0,2)
		if (particleName=="achievedT"&&::tankcup)
			if (intRand==0) particleName="achieved"
			else
				if (intRand==1)
					particleName="mini_fireworks"
				else
					particleName="mini_firework_flare"
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
}

::AttachOther <- function(entity,otherEntity, teleportOther,pos)
{
	teleportOther = (teleportOther.tointeger() > 0) ? true : false;
	if (teleportOther)
		otherEntity.SetOrigin(pos);
	DoEntFire("!self", "SetParent", "!activator", 0, entity, otherEntity);
}


//function Notifications::OnMapFirstStart::MapFirstStart()
//{			
//}


g_ModeScript.PlayersHUD <- {}

g_ModeScript.HoldoutHUD <- {}
//=========================================================
// since we have this mutation specific HUD but individual maps can use it differently
// it is a bit more complicated than a normal HUD Setup
// - use SessionState to tell the system which extra fields you want (Wave #, Timer, etc)
// - check and warn if you try to set conflicting fields
//function VSLib::EasyLogic::SlowPoll::SetupModeHUD()
::ShowHUD <- function()
{
	if (nowMatchEnded==0){
		
		local testHUDTickerText="";
		if (nowFinaleStageNum==0)
		{
			local playersText
			local serverText
			
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
			hudtip1.AddFlag(HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
			local hudtip2 = HUD.Item("33 B: {killcout}");//\n{rank05}\n{rank06}\n{rank07}\n{rank08}");
			hudtip2.SetValue("killcout", fnkillcout);
			hudtip2.AttachTo(HUD_FAR_RIGHT);
			hudtip2.ChangeHUDNative(1100, 0, 180, 20, 1280, 720);//(x, y, width, height, resx, resy)
			hudtip2.SetTextPosition(TextAlign.Left);
			hudtip2.AddFlag(HUD_FLAG_NOBG|HUD_FLAG_BLINK); 		
			local hudtip3 = HUD.Item("I: {inten} | TAI: {tai}");//\n{rank05}\n{rank06}\n{rank07}\n{rank08}");
			hudtip3.SetValue("inten", fninten);
			hudtip3.SetValue("tai", fntai);
			hudtip3.AttachTo(HUD_MID_TOP);
			//hudtip3.ChangeHUDNative(1100, 0, 180, 20, 1280, 720);//(x, y, width, height, resx, resy)
			hudtip3.SetTextPosition(TextAlign.Left);
			hudtip3.AddFlag(HUD_FLAG_NOBG|HUD_FLAG_BLINK); 		
			
			/*
			local hudtip4 = HUD.Item("I: {inten} | TAI: {tai}");//\n{rank05}\n{rank06}\n{rank07}\n{rank08}");
			hudtip4.SetValue("inten", fninten);
			hudtip4.SetValue("tai", fntai);
			hudtip4.AttachTo(HUD_MID_BOT);
			//hudtip4.ChangeHUDNative(1100, 0, 180, 20, 1280, 720);//(x, y, width, height, resx, resy)
			hudtip4.SetTextPosition(TextAlign.Left);
			hudtip4.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 		
			*/
			/*
			g_ModeScript.PlayersHUD =
			{
				
				function PreCallback()
				{
					playersText= ""+rank01()+"\n"+rank02()+"\n"+rank02()+"\nde "+fnclientcount()+" amigos | D:"+fndifficulty()
					serverText= "33 B: "+fnkillcout()
				}
				Fields = 
				{
					players        = { slot = HUD_FAR_LEFT, name = "players", datafunc = @() playersText, flags = HUD_FLAG_NOBG|HUD_FLAG_BLINK|HUD_FLAG_ALIGN_LEFT   },
					server         = { slot = HUD_FAR_RIGHT, name = "server", datafunc = @() serverText, flags = HUD_FLAG_NOBG|HUD_FLAG_BLINK|HUD_FLAG_ALIGN_LEFT   }
				}
			}
			HUDPlace(HUD_FAR_LEFT, 0, 0, 380, 110)
			*/
			//if (TimeTick4ConnectMsg<=0)
			//{
				//local hudtip4 = HUD.Item("{name}");//\n{rank05}\n{rank06}\n{rank07}\n{rank08}");
				//if (TimeTick4BossMsg<=0)
				//{
					//if (TimeTick4WitchMsg<=0)
					//{
						//if (TimeTick4PanicMsg<=0)
						//{
							//if (TimeTick4HealMsg<=0)
							//{
								//if (TimeTick4BossDefeatedMsg<=0)
								//{
								//	local hudtip4 = HUD.Item("Bienvenido {name}!!!");//\n{rank05}\n{rank06}\n{rank07}\n{rank08}");
								//	hudtip4.SetValue("name", "Bienvenido "+playerJoined+"!!!");
								//	hudtip4.AttachTo(HUD_TICKER);
								//	hudtip4.AddFlag(HUD_FLAG_NOTVISIBLE);
								//}
								//else
								//{
								//	hudtip4.SetValue("name", "Bien!! Derrota al Boss y avanza!");
								//	hudtip4.AttachTo(HUD_TICKER);
								//	hudtip4.AddFlag(HUD_FLAG_BLINK);
								//}
							//}
							//else
							//{
							//	hudtip4.SetValue("name", nowPlayerHealer+" curó a "+nowPlayerHealed+"!!");
							//	hudtip4.AttachTo(HUD_TICKER);
							//	hudtip4.AddFlag(g_ModeScript.HUD_FLAG_BLINK);
							//}
						//}
						//else
						//{
						//	hudtip4.SetValue("name", "PANIC: Derroten juntos a la horda!!!");
						//	hudtip4.AttachTo(HUD_TICKER);
						//	hudtip4.AddFlag(g_ModeScript.HUD_FLAG_BLINK);
						//}
					//}
					//else
					//{
						//local hudtip4 = HUD.Item("Aparece una Witch, es ideal un ataque en grupo!!!");//\n{rank05}\n{rank06}\n{rank07}\n{rank08}");
					//	hudtip4.SetValue("name", "Aparece una Witch, ataquen en grupo!!!");
					//	hudtip4.AttachTo(HUD_TICKER);
					//	hudtip4.AddFlag(g_ModeScript.HUD_FLAG_BLINK);				
					//}
				//}
				//else
				//{
				//	if (nowPlayersinGame>1)
				//		hudtip4.SetValue("name", "Aparece un Tank, derrotenlo!!!");
				//		else
				//			hudtip4.SetValue("name", "Aparece un Tank Boss!!!");
						//local hudtip4 = HUD.Item("Aparece un Tank Boss | Derrotenlo para avanzar!!!");//\n{rank05}\n{rank06}\n{rank07}\n{rank08}");
						//else
							//local hudtip4 = HUD.Item("Aparece un Tank Boss!!!");//\n{rank05}\n{rank06}\n{rank07}\n{rank08}");
				//	hudtip4.AttachTo(HUD_TICKER);			
				//	hudtip4.AddFlag(g_ModeScript.HUD_FLAG_BLINK);		
				//}
			//}
			//else
			//{
				//Msg("DateUpDate \n");
			//	local hudtip4 = HUD.Item("{name}");//\n{rank05}\n{rank06}\n{rank07}\n{rank08}");
				
			//	if (nowPlayerEvent=="Join")
			//	{
			//		hudtip4.SetValue("name", playerJoined);
			//	}
			//	else
			//	if (nowPlayerEvent=="Left")
			//	{
			//		hudtip4.SetValue("name", playerLeft);
			//	}
			//	hudtip4.AttachTo(HUD_TICKER);
			//	hudtip4.SetTextPosition(TextAlign.Center);
			//	hudtip4.AddFlag(g_ModeScript.HUD_FLAG_BLINK); 		
				//g_ModeScript.HoldoutHUD.Fields.ticker <- {slot = HUD_TICKER, name = "tickermsg", datafunc = @() testHUDTickerText, flags = HUD_FLAG_BLINK | HUD_FLAG_NOTVISIBLE}
			//}
		}
		else
		{
			g_ModeScript.HoldoutHUD =
			{
				function PreCallback()
				{
					
				}
				Fields = 
				{
					descanso   = { slot = HUD_FAR_LEFT,  name = "descanso", dataval = "Descanso:" },
					//COOLDOWN
					cooldown_time = { slot = HUD_LEFT_TOP, name = "cooldown", special = HUD_SPECIAL_COOLDOWN, flags = HUD_FLAG_COUNTDOWN_WARN | HUD_FLAG_BEEP },
					//SUPPLIES
					supply        = { slot = HUD_FAR_RIGHT, name = "supply", staticstring = "Amigos: ", datafunc = @() nowPlayersinGame }

					// this is kinda a lie! we are really going to move these w/HUDPlace for displaying final scores!
					// we will move the Ticker down to be a "header" - then need 4 slots for top 4
					//score1   = { slot = HUD_FAR_RIGHT, name = "score1", dataval = "Score1", flags = HUD_FLAG_NOTVISIBLE | HUD_FLAG_ALIGN_LEFT },
					//score2   = { slot = HUD_FAR_LEFT,  name = "score2", dataval = "Score2", flags = HUD_FLAG_NOTVISIBLE | HUD_FLAG_ALIGN_LEFT },
					//score3   = { slot = HUD_LEFT_BOT,  name = "score3", dataval = "Score3", flags = HUD_FLAG_NOTVISIBLE | HUD_FLAG_ALIGN_LEFT },
					//score4   = { slot = HUD_RIGHT_BOT, name = "score4", dataval = "Score4", flags = HUD_FLAG_NOTVISIBLE | HUD_FLAG_ALIGN_LEFT },
				}
			}
			//hudtip1.ChangeHUDNative(0, 0, 380, 110, 1280, 720);//(x, y, width, height, resx, resy)
			//hudtip1.SetTextPosition(TextAlign.Left);
			//FASE
			local strIntensity= "I: "+fninten()+" | TAI: "+fntai();
			g_ModeScript.HoldoutHUD.Fields.wave <- {slot = HUD_MID_TOP, name = "fase", staticstring = "Fase: ", datafunc = @() nowFinaleStageNum }
			g_ModeScript.HoldoutHUD.Fields.intensity <- {slot = HUD_MID_BOT, name = "intensidad", staticstring = "I:", datafunc = @() strIntensity }
				
			
			g_ModeScript.HoldoutHUD.Fields.wavetype <- {slot = HUD_RIGHT_TOP, name = "fasetipo", datafunc = @() numTypetoTypeString(nowFinaleStageType)}
			
			//TICKER		
			if (nowFinaleStageNum==1)
			{
				//Msg("DateUpDate \n");
				if ( (developer() > 0) || (DEBUG == 1))
				{
					ClientPrint(null, 3, BLUE+"creating ticker\n");
				}
				testHUDTickerText = "Resiste hasta que llegue el rescate!"
			}
			else
			{
				if (nowFinaleStageNum < DirectorScript.MapScript.DirectorOptions.A_CustomFinale_StageCount )
					testHUDTickerText = "Comenzando el Finale: Fase " + nowFinaleStageNum + " de " + DirectorScript.MapScript.DirectorOptions.A_CustomFinale_StageCount + " fases.";
				else 
					testHUDTickerText = "Llega el rescate!";
			}
			
			g_ModeScript.HoldoutHUD.Fields.ticker <- {slot = HUD_TICKER, name = "tickermsg", datafunc = @() testHUDTickerText, flags = HUD_FLAG_BLINK}
			
			TimeTick4Rescue--;
			if (TimeTick4Rescue<=0)
			{
				//Msg("DateUpDate \n");
				if ( (developer() > 0) || (DEBUG == 1))
				{
					ClientPrint(null, 3, BLUE+"TimeTick4Rescue en 0\n");
				}		
				g_ModeScript.HoldoutHUD.Fields.ticker <- {slot = HUD_TICKER, name = "tickermsg", datafunc = @() testHUDTickerText, flags = HUD_FLAG_BLINK | HUD_FLAG_NOTVISIBLE}		
			}

			
			if ( "HUDRescueTimer" in SessionState && SessionState.HUDRescueTimer )
			{
				g_ModeScript.RescueTimer_Init( g_ModeScript.HoldoutHUD, HUD_MID_BOX, HUD_MID_BOT )
				if (SessionState.HUDWaveInfo)
					printl("Warning: Cannot have both Rescuetimer and Wave HUD elements at once");
			}
			
			g_ModeScript.HUDSetLayout( g_ModeScript.HoldoutHUD );		
		}
	}
}

::ShowHUDTicker <- function(numero,tipo, mensaje1,mensaje2="")
{
	if ( (developer() > 0) || (DEBUG == 1))
	{
		ClientPrint(null, 3, BLUE+"ShowHUDTicker\n");
	}		
	if (numero ==4)
	{
		local hudtip4 = HUD.Item("{name}");//\n{rank05}\n{rank06}\n{rank07}\n{rank08}");
		hudtip4.AttachTo(HUD_TICKER);
		switch(tipo)
		{
			case "Tank":
			{
				hudtip4.SetValue("name", mensaje1);
				break;
			}
			case "PANIC":
			{
				hudtip4.SetValue("name", mensaje1);
				break;
			}
			case "Witch":
			{
				hudtip4.SetValue("name", mensaje1);
				break;
			}
			case "Heal":
			{
				hudtip4.SetValue("name", mensaje1+" curó a "+mensaje2+"!!");
				break;
			}		
			case "Join":
			{
				hudtip4.SetValue("name","Bienvenido "+mensaje1+"!!!");
				break;
			}		
			case "Left":
			{
				hudtip4.SetValue("name",mensaje1+" tuvo que irse");
				break;
			}
		}
		hudtip4.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
		hudtip4.AddFlag(HUD_FLAG_BLINK);
		Timers.AddTimer(6.0, false, CloseHud, hudtip4 ); //添加计时器关闭HUD
	}
}


::CloseHud <- function(hud)
{
	hud.Detach();
}