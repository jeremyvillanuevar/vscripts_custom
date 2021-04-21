//Title: The Alternate Difficulties Mod (TADM)
//Author Steam Alias: jetSetWilly II
//Author URL: https://steamcommunity.com/id/jetsetwillyuncensored/
//Version: 2.5
//Programming Language: VScript
//File Description: This is a control and data file that contains functions that are called from timers
//Note: atfunc means alternate timed functions


::gascansCalculate <- function(arg)	
{

	if ( nowPlayersinGame>12 )
	{
		nowNumCansNeeded=23
		NumCansNeeded <- nowNumCansNeeded
	}
	else	
	if ( nowPlayersinGame>7 )
	{
		nowNumCansNeeded=20
		NumCansNeeded <- nowNumCansNeeded
	}
	else
	if ( nowPlayersinGame>5 )
	{
		nowNumCansNeeded=18
		NumCansNeeded <- nowNumCansNeeded
	}
	else
	if ( nowPlayersinGame>3 )
	{
		nowNumCansNeeded=13
		NumCansNeeded <- nowNumCansNeeded
	}	
	else
	if ( nowPlayersinGame>1 )
	{
		nowNumCansNeeded=8
		NumCansNeeded <- nowNumCansNeeded
	}
	else
	{
		nowNumCansNeeded=5
		NumCansNeeded <- nowNumCansNeeded
	}
	EntFire( "progress_display", "SetTotalItems", NumCansNeeded )
}

//Ejecutado a cada rato
//function VSLib::EasyLogic::Update::NamesUpdate()
::NamesUpdate <- function(arg)	
{
	//DEBUG
	//nowActivateBalance=0

	//Msg("DateUpDate \n");
	if ( (developer() > 0) || (DEBUG == 1))
	{
		ClientPrint(null, 3, BLUE+"nowFinaleStageEvent "+nowFinaleStageEvent+"\n");
	}
	if (Show_Player_Hud==true)
		
		ShowHUD();
	
	
	if (nowFinaleStarted==1 || nowCrescendoStarted==1)
	{
		Time4TimerRusher=99999;
	}
	
	if (nowActivateBalance==1)
		if (nowFinaleStarted==1)
		{
			BalanceFinaleDirectorOptions();
			nowFinaleStarted==2;
		}
		else
		if (nowFinaleStarted==0)
		{
			if (nowFinaleStageEvent==1 || nowFinaleScavengeStarted==1)
				nowFinaleStarted=1;
		}
		
	Time4Connections--
	if (nowFinaleStageEvent==1)
	{
		nowFinaleStageEvent = 0
		OnCustomFinaleStageChangeHook()
	}
	local flow=-1
	local countflow=0
	local survivorlist =[]
	local flowlist =[]
	
	//if (nowPlayersinGame>8)
	//{
		Time4TimerWitch--;
	//}
	TimeTick4ConnectMsg--;		
	TimeTick4WitchMsg--;
	TimeTick4PanicMsg--;
	TimeTick4BossMsg--;
	TimeTick4HealMsg--;
	TimeTick4BossDefeatedMsg--;
	/*
	if (Time4TimerWitch<=0)
	{
		SpawnWitch();
		Time4TimerWitch=60-5*nowPlayersinGame;
		TimeTick4WitchMsg=10;
		nowSpawnedWitch++;
	}
	*/
	//if (nowPlayersinGame>8)
	//{
		Time4TimerRusher--;
	//}
	if (Time4TimerRusher<=0 && nowFinaleStarted==0 && nowCrescendoStarted==0 && nowPlayersinGame > 2)
	{
		if ( (developer() > 0) || (DEBUG == 1))
		{
			ClientPrint(null, 3, BLUE+"Time4TimerRusher");
		}
		foreach ( survivor in ::VSLib.EasyLogic.Players.Survivors() )
		{
			flow = survivor.GetFlowDistance();
			
			if ( (developer() > 0) || (DEBUG == 1))
			{
				ClientPrint(null, 3, BLUE+"survivor.GetFlowDistance() "+flow);	
			}
			if( flow && flow != -9999.0 ) // Invalid flows
			{
				survivorlist.insert(countflow,survivor.GetIndex());
				flowlist.insert(countflow,flow);
				countflow++
				//index = aList.Push(flow);
				//aList.Set(index, client, 1);
			}
		}
		countflow=flowlist.len();//deja de ser indice
		if( countflow >= 2 )
		{
			//flowlist.sort(CompareFlow);
			for (local i = 0; i < flowlist.len()-1; i++ )
			{	
				local temp1,temp2;
					
				if (flowlist[i]>flowlist[i+1])
				{
					/*
					temp1=flowlist[i+1]
					temp2=survivorlist[i+1]
					flowlist[i+1]=flowlist[i]
					survivorlist[i+1]=survivorlist[i]
					flowlist[i]=temp1
					survivorlist[i]=temp2				
					*/
				}
				else 
				if(flowlist[i]<flowlist[i+1])
				{
					temp1=flowlist[i]
					temp2=survivorlist[i]
					flowlist[i]=flowlist[i+1]
					survivorlist[i]=survivorlist[i+1]
					flowlist[i+1]=temp1
					survivorlist[i+1]=temp2				
				}
			}
			local clientflowAvg;
			local clientflowFirst;
			local clientflowNear;
			local lastFlow;
			local distance;		
			local teleportedahead =false;
			local client=-1;
			if ( (developer() > 0) || (DEBUG == 1))
			{
				ClientPrint(null, 3, BLUE+"countflow "+countflow);	
			}				
			// Loop through survivors from highest flow
			for( local i = 0; i < flowlist.len(); i++ )//len es tamaño completo no es -1
			{
				
				client = survivorlist[i];
				local player = ::VSLib.Player(client);	
				if ( (developer() > 0) || (DEBUG == 1))
				{
					ClientPrint(null, 3, BLUE+"player.GetName() "+player.GetName());
				}				
				local flowBack = true;
				// Only check nearest half of survivor pack.
				if (( i < countflow / 2 ))
				{					
					flow = flowlist[i];
					if ( (developer() > 0) || (DEBUG == 1))
					{
						ClientPrint(null, 3, BLUE+"GetFlowDistance() "+flow);
					}
					// Loop through from next survivor to mid-way through the pack.
					for( local x = i + 1; x <= countflow / 2; x++ )
					{
						local player2 = ::VSLib.Player(survivorlist[x]);	
						if ( (developer() > 0) || (DEBUG == 1))
						{
							ClientPrint(null, 3, BLUE+"player2.GetName() "+player2.GetName());
						}
						lastFlow = flowlist[x]//aList.Get(x, 0);
						if ( (developer() > 0) || (DEBUG == 1))
						{
							ClientPrint(null, 3, BLUE+"GetFlowDistance() "+lastFlow);
						}
						distance = flow - lastFlow;
						if ( (developer() > 0) || (DEBUG == 1))
						{
							ClientPrint(null, 3, BLUE+"flow - lastFlow "+distance);
						}
						// Compare higher flow with next survivor, they're rushing
						if ((distance > 1810))//1750 is antirush
						{
							// PrintToServer("RUSH: %N %f", client, distance);
							flowBack = false;							
							
							//float vPos[3];
							//GetClientAbsOrigin(clientflowNear, vPos);
							//CPrintToChatAll("%s",rawmsg);
							//TeleportEntity(client, vPos, NULL_VECTOR, NULL_VECTOR);
							
							local mensaje;
							GetInfectedStats( nowinfStats )
							if (nowinfStats.Tanks==0 && nowSpawnedTankRusher==0)
							{
								SpawnTank(null,player);
								if (nowPlayersinGame>1)
									mensaje="Aparece un Tank, derrotenlo!!!";
								else
									mensaje="Aparece un Tank Boss!!!";
								nowSpawnedTankRusher++
							}
							else
							if (nowinfStats.Tanks==1 || nowSpawnedTankRusher==1)
								mensaje="Para avanzar derrota al Tank!";
							else 
								mensaje="Para avanzar derrota a los Tanks!";
							Time4TimerRusher=1600
							ShowHUDTicker(4,"Tank",mensaje);
							//TimeTick4BossMsg=10;
							break;
						}
					}
				}
			}
		}		
	}
	else
	nowSpawnedTankRusher=0;
	
	if(ClearEdicts)
	{
		Time4Tick--
		if(Time4Tick<=0)
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
	//Client_Count=clientcount;
	nowPlayersinGame=clientcount;
	Survivors_Count=survivorcount;
	nowSurvivorsinGame=Survivors_Count;
}

::spawnForMapSpecificData <- function(params)
{
	local thisMap = SessionState.MapName;	
	//if(thisMap in cMSF)
	if(thisMap in eMTVT)
	{
		Timers.AddTimer(5, false, mapEntitiesSpawner,params);
	}
	Msg("Executed: spawnForMapSpecificData function\n");
}

::randomAlterCvars <- function(params)
{
	Convars.SetValue("pain_pills_health_value" ,				RandomInt	(pPHVA[dAANMI],pPHVA[dAANMA]));
	Convars.SetValue("pain_pills_decay_rate" ,					RandomFloat	(pPDRA[dAANMI],pPDRA[dAANMA]));
	Convars.SetValue("defibrillator_return_to_life_time" ,		RandomFloat	(dRTLTA[dAANMI],dRTLTA[dAANMA]));
	Convars.SetValue("defibrillator_use_duration" ,				RandomFloat	(dUDA[dAANMI],dUDA[dAANMA]));
	Convars.SetValue("adrenaline_health_buffer" ,				RandomInt	(aHBA[dAANMI],aHBA[dAANMA]));
	Convars.SetValue("adrenaline_run_speed" ,					RandomInt	(aRSA[dAANMI],aRSA[dAANMA]));
	Convars.SetValue("survivor_it_duration" ,					RandomInt	(sIDA[dAANMI],sIDA[dAANMA]));
	Convars.SetValue("grenadelauncher_velocity" , 				RandomInt	(gLV[dAANMI],gLV[dAANMA]));
	Convars.SetValue("grenadelauncher_ff_scale_self" ,			RandomFloat	(gLFFSS[dAANMI],gLFFSS[dAANMA]));
	Convars.SetValue("grenadelauncher_ff_scale" ,				RandomFloat	(gLFFS[dAANMI],gLFFS[dAANMA]));	
	Convars.SetValue("pipe_bomb_timer_duration" ,				RandomFloat	(pBTD[dAANMI],pBTD[dAANMA]));
	Convars.SetValue("pipe_bomb_initial_beep_interval" ,		RandomFloat	(pBIBI[dAANMI],pBIBI[dAANMA]));
	Convars.SetValue("pipe_bomb_beep_interval_delta" ,			RandomFloat	(pBBID[dAANMI],pBBID[dAANMA]));
	Convars.SetValue("pipe_bomb_beep_min_interval" ,			RandomFloat	(pBBMI[dAANMI],pBBMI[dAANMA]));
	Convars.SetValue("pipe_bomb_shake_amplitude" ,				RandomInt	(30,40));		//was 50
	Convars.SetValue("pipe_bomb_shake_radius" ,					RandomInt	(600,700));		//was 750
	Convars.SetValue("vomitjar_radius_survivors" ,				RandomInt	(110,130));		//was 0 you can use vomitjars to clean puke off you or your friends because it has a shorter duration
	Convars.SetValue("inferno_flame_spacing" ,					RandomInt	(40,50));		//was 50
	Convars.SetValue("inferno_max_flames" ,						RandomInt	(22,28));		//was 32
	Convars.SetValue("inferno_max_range" ,						RandomInt	(500,700));		//was 500
	Convars.SetValue("inferno_spawn_angle" ,					RandomInt	(15,20));		//was 45
	Convars.SetValue("inferno_flame_lifetime" ,					RandomInt	(iFLA[dAANMI],iFLA[dAANMA]));
	Convars.SetValue("inferno_damage" ,							RandomInt	(iDA[dAANMI],iDA[dAANMA]));	
	Msg("Executed: randomAlterCvars function\n");
}

::checkForChampionTime <- function(params)
{
	local newChampionSister = RandomInt(7,12) - dAANNR
	championTime = RandomInt(1,newChampionSister)
	if(championTime == 1)
	{
		Convars.SetValue("z_female_boomer_spawn_chance" ,		"0");
		Convars.SetValue("z_exploding_health" ,					RandomInt	(zEUSHA[dAANMI],zEUSHA[dAANMA]));
		Convars.SetValue("z_exploding_speed" ,					RandomInt	(zEUSSA[dAANMI],zEUSSA[dAANMA]));
		lastSister = 1
	}
	else
	{
		Convars.SetValue("z_exploding_health" ,					RandomInt	(zEHA[dAANMI],zEHA[dAANMA]));
		Convars.SetValue("z_exploding_speed" ,					RandomInt	(zESA[dAANMI],zESA[dAANMA]));
		Convars.SetValue("z_female_boomer_spawn_chance" ,		"100");
		lastSister = 0
	}
	Msg("executed checkForChampionTime\n");
}

::spawnNewSister <- function(player)
{
	Timers.AddTimer(2, false, uglySisterSoundPlayer, player);
	local difficultyAmplifier = dAAN + 1
	local newNextChampionSister = RandomInt(6,7) - difficultyAmplifier
	championTime = RandomInt(1,newNextChampionSister)
	Utils.SpawnZombie(Z_BOOMER, pBSL);
}

::uglySisterSoundPlayer <- function(player)
{
	if(RandomInt(0,1) == 0)
	{
		local playerEnt = null
		while(playerEnt = Entities.FindByClassname(playerEnt, "player"))
		{
			EmitSoundOnClient("Event.StartAtmosphere_Mall", playerEnt)
		}
	}
	else
	{
		local playerEnt = null
		while(playerEnt = Entities.FindByClassname(playerEnt, "player"))
		{ 
			EmitSoundOnClient("Event.StartAtmosphere_Mall", playerEnt)
		}
	}
}

::supplementTankRandomizer <- function(player)
{	
	local chanceOfXtroTank = 22 - dAAN * 2
	local sTR = RandomInt(1,chanceOfXtroTank)
	if(sTR == 1)
	{
		sTG = 1
		multiTankManager(player);
	}
	Msg("Executed: supplementTankRandomizer function \n");
}

::multiTankManager <- function(player)
{
	if(multiTankCreation == 1)
	{
		multiTankCreation = RandomInt(1,xtroTanks)
		xtroTanks = xtroTanks * 2
	}
	else
	{
		multiTankCreation = RandomInt(1,mTMC[dAANNR])
		Msg("multiTankCreation = " + multiTankCreation + "\n");
	}
	if (multiTankCreation == 1)
	{
		if (aPPPTM > 30 || isAFinale == 1)
		{
			player.Stagger();
			local posT = player.GetLocation();
			pTSL = posT
			Timers.AddTimer(4, false, spawnNewTank, player);
		}
	}
	Msg("Executed: multiTankManager function \n");
}

//separates the tanks spawned in multitank
::spawnNewTank <- function(player)
{
	Utils.SpawnZombie(Z_TANK, pTSL);
	Timers.AddTimer(3, false, multiTankShock, player);
	Msg("Executed: spawnNewTank function \n");
}

::multiTankShock <- function(player)
{
	if(sTG == 0)
	{
		Utils.SlowTime(0.5, 2.0, 1.0, 2.0, true);
	}
	else
	{
		sTG = 0
	}
	Msg("Executed: multiTankShock function \n");
}

::tankCheck <- function(player)
{
	if(player.IsAlive())
	{
		if(player.IsOnFire())
		{
			if(tankCounter[player.GetIndex()] == 0)
			{
				tankCounter[player.GetIndex()] = 1
				Timers.AddTimer(RandomInt(tETA[dAANMI],tETA[dAANMA]), false, tankRandomExtinguish, player);
			}
		}
		else
		{
			Timers.AddTimer(5, false, tankCheck,player);
		}
	}
	Msg("Executed: tankCheck function \n");
}

::tankRandomExtinguish <- function(player)
{
	if(RandomInt(0,1) == 1)
	{
		player.Extinguish();
	}
	tankCounter[player.GetIndex()] = 0
	Msg("Executed: tankRandomExtinguish function \n");
}

::timedProgressUpdate <- function(params)
{
	flowDistanceCalculator(params);

	Convars.SetValue("survivor_crouch_speed" ,				sCROSA[gFD]);
	Convars.SetValue("survivor_crawl_speed" ,				sCRASA[gFD]);
	Convars.SetValue("survivor_ledge_grab_health" ,			sLGHT[dAAW][gFD]);
	Convars.SetValue("survivor_limp_health" ,				sLHMT[gMV][dAAW][gFD]);
	Convars.SetValue("survivor_limp_walk_speed" ,			sLWST[gMV][dAAW][gFD]);

	Convars.SetValue("survivor_revive_duration" ,			sRDT[gMV][dAAW][gFD]);
	Convars.SetValue("z_gun_swing_duration" ,				zGSWDT[dAAW][gFD]);
	Convars.SetValue("z_gun_swing_interval" ,				zGSIT[dAAW][gFD]);
	Convars.SetValue("z_spawn_mobs_behind_chance" ,			zSMBCDA[gFD]);
	Convars.SetValue("first_aid_kit_use_duration" ,			fAKUDGMT[gMV][dAAW][gFD]);

	timedProgressUpdateCounter++;
	Msg("Executed: timedProgressUpdate function iteration: " + timedProgressUpdateCounter + "\n");
}

::timedRandomiserDifficulty <- function(params)
{
	Convars.SetValue("intensity_factor" ,					RandomFloat	(iFA[dAANMI],iFA[dAANMA]));
	Convars.SetValue("intensity_decay_time" ,				RandomInt	(iDTA[dAANMI],iDTA[dAANMA]));
	Convars.SetValue("inferno_flame_lifetime" ,				RandomInt	(iFLA[dAANMI],iFLA[dAANMA]));
	Convars.SetValue("inferno_damage" ,						RandomInt	(iDA[dAANMI],iDA[dAANMA]));
	Convars.SetValue("survivor_it_duration" ,				RandomInt	(sIDA[dAANMI],sIDA[dAANMA]));

	Convars.SetValue("z_spawn_speed" ,						RandomInt	(zSST[mAAN][dAANMI],zSST[mAAN][dAANMA]));
	Convars.SetValue("z_spawn_flow_limit" ,					RandomInt	(zSFLT[mAAN][dAANMI],zSFLT[mAAN][dAANMA]));
	Convars.SetValue("z_notice_near_range" ,				RandomInt	(zNNRT[mAAN][dAANMI],zNNRT[mAAN][dAANMA]));
	Convars.SetValue("z_hear_gunfire_range" ,				RandomInt	(zHGRT[mAAN][dAANMI],zHGRT[mAAN][dAANMA]));
	if (miniFinalDirectorNoSet == 0)
	{
		DirectorOptions <-
		{
			FarAcquireTime		=	RandomFloat	(fATT[mAAN][dAANMI],fATT[mAAN][dAANMA])
			FarAcquireRange		=	RandomInt	(fART[mAAN][dAANMI],fART[mAAN][dAANMA])
			NearAcquireTime		=	RandomFloat	(nATT[mAAN][dAANMI],nATT[mAAN][dAANMA])

			NearAcquireRange	=	RandomInt	(nART[mAAN][dAANMI],nART[mAAN][dAANMA])
			ZombieSpawnRange	=	RandomInt	(zSRT[mAAN][dAANMI],zSRT[mAAN][dAANMA])
			RelaxMaxFlowTravel	=	RandomInt	(rMFTT[mAAN][dAANMI],rMFTT[mAAN][dAANMA])

			MaxSpecials			=	RandomInt	(mSDA[dAANMI],mSDA[dAANMA])
			DominatorLimit		=	RandomInt	(dLDA[dAANMI],dLDA[dAANMA])
		}
	}
	timedDifficultyFunctionExecutions++;
	Msg("Executed: timedRandomizerDifficulty function iteration: " + timedDifficultyFunctionExecutions + "\n");
}

::timedRandomizerTiered <- function(params)
{
	initializeTierOfDifficulty();
	Convars.SetValue("z_wandering_density" ,				RandomFloat	(zWDT[mAAN][tODMI],zWDT[mAAN][tODMA]));
	Convars.SetValue("versus_wandering_zombie_density" ,	RandomFloat	(zWDT[mAAN][tODMI],zWDT[mAAN][tODMA]));
	Convars.SetValue("z_mob_recharge_rate" ,				RandomFloat	(mRRTA[tODMI],mRRTA[tODMA]));
	Convars.SetValue("z_mob_spawn_min_interval_easy" ,		RandomInt	(zMSMIIDTA[tODMI],zMSMIIDTA[tODMA]));
	Convars.SetValue("z_mob_spawn_max_interval_easy" ,		RandomInt	(zMSMAIDTA[tODMI],zMSMAIDTA[tODMA]));

	Convars.SetValue("z_mob_spawn_min_interval_normal" ,	RandomInt	(zMSMIIDTA[tODMI],zMSMIIDTA[tODMA]));
	Convars.SetValue("z_mob_spawn_max_interval_normal" ,	RandomInt	(zMSMAIDTA[tODMI],zMSMAIDTA[tODMA]));
	Convars.SetValue("z_mob_spawn_min_interval_hard" ,		RandomInt	(zMSMIIDTA[tODMI],zMSMIIDTA[tODMA]));
	Convars.SetValue("z_mob_spawn_max_interval_hard" ,		RandomInt	(zMSMAIDTA[tODMI],zMSMAIDTA[tODMA]));
	Convars.SetValue("z_mob_spawn_min_interval_expert" ,	RandomInt	(zMSMIIDTA[tODMI],zMSMIIDTA[tODMA]));

	Convars.SetValue("z_mob_spawn_max_interval_expert" ,	RandomInt	(zMSMAIDTA[tODMI],zMSMAIDTA[tODMA]));
	Convars.SetValue("z_mob_min_notify_count" ,				RandomInt	(zMmNCTA[tODMI],zMmNCTA[tODMA]));
	Convars.SetValue("director_sustain_peak_max_time" ,		RandomInt	(dSPMATT[mAAN][tODMI],dSPMATT[mAAN][tODMA]));
	Convars.SetValue("director_sustain_peak_min_time" ,		RandomInt	(dSPMITT[mAAN][tODMI],dSPMITT[mAAN][tODMA]));
	Convars.SetValue("director_relax_min_interval" ,		RandomInt	(dRMIITA[tODMI],dRMIITA[tODMA]));
	Convars.SetValue("director_relax_max_interval" ,		RandomInt	(dRMAITA[tODMI],dRMAITA[tODMA]));

	if (miniFinalDirectorNoSet == 0)
	{
		DirectorOptions <-
		{
			TankRunSpawnDelay		=	RandomInt	(tRSDDA[tODMI],tRSDDA[tODMA])
			SpecialRespawnInterval	=	RandomInt	(sRITA[tODMI],sRITA[tODMA])
			//TotalBoomers			=	RandomInt	(tBTA[tODMI],tBTA[tODMA])

			TotalChargers			=	RandomInt	(tCTA[tODMI],tCTA[tODMA])
			TotalSpitters			=	RandomInt	(tSpTA[tODMI],tSpTA[tODMA])
			TotalSmokers			=	RandomInt	(tSmTA[tODMI],tSmTA[tODMA])
			TotalJockeys			=	RandomInt	(tJTA[tODMI],tJTA[tODMA])
			TotalHunters			=	RandomInt	(tHTA[tODMI],tHTA[tODMA])

			//BoomerLimit				=	RandomInt	(tBTA[tODMI],tBTA[tODMA])
			ChargerLimit			=	RandomInt	(tCTA[tODMI],tCTA[tODMA])
			SpitterLimit			=	RandomInt	(tSpTA[tODMI],tSpTA[tODMA])
			SmokerLimit				=	RandomInt	(tSmTA[tODMI],tSmTA[tODMA])
			JockeyLimit				=	RandomInt	(tJTA[tODMI],tJTA[tODMA])

			HunterLimit				=	RandomInt	(tHTA[tODMI],tHTA[tODMA])
			NumReservedWanderers	=	RandomInt	(nORWT[mAAN][tODMI],nORWT[mAAN][tODMA])
			CommonLimit				=	RandomInt	(cLDA[tODMI],cLDA[tODMA])
			MobMaxSize				=	RandomInt	(mMASA[tODMI],mMASA[tODMA])
			MobMinSize				=	RandomInt	(mMISA[tODMI],mMISA[tODMA])

			MegaMobSize				=	RandomInt	(mMSDA[tODMI],mMSDA[tODMA])
			MobSpawnSize			=	RandomInt	(mSSDA[tODMI],mSSDA[tODMA])
			MobRechargeRate			=	RandomFloat	(mRRTA[tODMI],mRRTA[tODMA])
			MobMaxPending			=	mMPDA[tODNR]
			TankLimit				=	5
		}
	}
	timedFunctionExecutions++;
	Msg("Executed: timedRandomizerTiered function iteration: " + timedFunctionExecutions + "\n");
}

::playerMovementCalculator <- function(arg)
{
	foreach(surv in Players.Survivors())
	{
		local pPPTM = surv.GetFlowPercent()
		if (pPPTM > aPPPTM)
		{
			aPPPTM = pPPTM
		}
	}
	Msg("Executed: playerMovementCalculator Function\n");
}

//If the zombie has the default scale of 1 then it gets a new scale applied to it
::timedZombieScaleModifier <- function(arg)
{
	local ent = null;
	while (ent = Entities.FindByClassname(ent, "infected"))
	{
		local zSM = 14;
		local currentModelScale = NetProps.GetPropFloat(ent, "m_flModelScale")
		//all models scale default to 1 so if they are found to be at their default scale then change them, in other words change them all as soon as they are found
		if(ent.IsValid() && currentModelScale == 1)
		{
			//the higher the tier the greater the chance for a model to be scaled with one of the outlier arrays
			local maleModelScale = RandomFloat(mISBDA[dAANMI],mISBDA[dAANMA])
			local maleModelOutlierScale = RandomFloat(mIOSBDA[dAANMI],mIOSBDA[dAANMA])
			local femaleModelScale = RandomFloat(fISBDA[dAANMI],fISBDA[dAANMA])
			local femaleModelOutlierScale = RandomFloat(fIOSBDA[dAANMI],fIOSBDA[dAANMA])
			local defaultRandomScale = RandomFloat(dISBDA[dAANMI],dISBDA[dAANMA])
			local defaultOutlierRandomScale = RandomFloat(dIOSBDA[dAANMI],dIOSBDA[dAANMA])
			local maleShortModelOutlierScale = RandomFloat(mISOSBDA[dAANMI],mISOSBDA[dAANMA])
			local femaleTallModelOutlierScale = RandomFloat(fITOSBDA[dAANMI],fITOSBDA[dAANMA])
			local model = NetProps.GetPropString( ent, "m_ModelName" );
			switch(model)
			{
				case "models/infected/common_male_polo_jeans.mdl":
				case "models/infected/common_male_tshirt_cargos.mdl":
				case "models/infected/common_male_tankTop_jeans.mdl":
				case "models/infected/common_male_dressShirt_jeans.mdl":
				case "models/infected/common_male_roadcrew.mdl":
				case "models/infected/common_male_ceda.mdl":
				case "models/infected/common_male_fallen_survivor.mdl":
				case "models/infected/common_male_suit.mdl":
				case "models/infected/common_male_biker.mdl":
				case "models/infected/common_male_tankTop_overalls.mdl":
				case "models/infected/common_male_tankTop_jeans_rain.mdl":
				case "models/infected/common_male_roadcrew_rain.mdl":
				case "models/infected/common_male_mud.mdl":
				case "models/infected/common_male_tshirt_cargos_swamp.mdl":
				case "models/infected/common_male_tankTop_overalls_swamp.mdl":
				case "models/infected/common_male_riot.mdl":
				case "models/infected/common_patient_male01_l4d2.mdl":
				case "models/infected/common_male_formal.mdl":
					//check for outliers (unusually tall or short infected)
					if(RandomInt(tOD,zSM) == zSM)
					{
						if(RandomInt(1,5) == 1)
						{
							//unusually short male infected
							NetProps.SetPropFloat(ent, "m_flModelScale", maleShortModelOutlierScale);
						}
						else
						{
							//unusually tall male infected
							NetProps.SetPropFloat(ent, "m_flModelScale", maleModelOutlierScale);
						}
					}					
					else
					{
						//if there are not outliers then use the standard size varations
						NetProps.SetPropFloat(ent, "m_flModelScale", maleModelScale);
					}
					break;
				case "models/infected/common_female_tankTop_jeans.mdl":
				case "models/infected/common_female_tshirt_skirt.mdl":
				case "models/infected/common_female_tankTop_jeans_rain.mdl":
				case "models/infected/common_female_tshirt_skirt_swamp.mdl":
				case "models/infected/common_female_formal.mdl":
					//check for outliers (unusually tall or short infected)
					if(RandomInt(tOD,zSM) == zSM)
					{
						if(RandomInt(1,5) == 1)
						{
							//unusually short female infected
							NetProps.SetPropFloat(ent, "m_flModelScale", femaleTallModelOutlierScale);
						}
						else
						{
							//unusually tall female infected
							NetProps.SetPropFloat(ent, "m_flModelScale", femaleModelOutlierScale);
						}
					}
					else
					{
						//if there are not outliers then use the standard size varations
						NetProps.SetPropFloat(ent, "m_flModelScale", femaleModelScale);
					}
					break;
				default:
					//in the case a model is not list above use the default model scales
					if(RandomInt(tOD,zSM) == zSM)
					{
						NetProps.SetPropFloat(ent, "m_flModelScale", defaultOutlierRandomScale);
					}
					else
					{
						NetProps.SetPropFloat(ent, "m_flModelScale", defaultRandomScale);
					}
					Msg("Defaulted: timedZombieScaleModifier selection\n");
					Msg("Detected Infected Model: " + model + " and adjusted its scale to " + defaultRandomScale +"\n");
					break;
			}
		}
	}	
}

//regular timed checks to calculate player movement based on what weapons they have and are firing
::playerAttackMovementManager <- function(arg)
{		
	foreach(ent in Players.Survivors())
	{		
		//part of the adrenaline system(see aFunc.nut adrenalineSpeedController function)
		if (pFC[ent.GetSurvivorCharacter()] > 0)
		{
			pFC[ent.GetSurvivorCharacter()]--
		}
		//if no adren in use then execute weapon checks for calculating player speed
		else
		{
			local currentPlayer = ent.GetSurvivorCharacter();
			local playersWeapon = ent.GetActiveWeapon().GetClassname()
			pWC[currentPlayer] = playersWeapon;
			if (playersWeapon in fWIT) 
			{
				if (ent.IsPressingAttack() && !ent.IsPressingBackward() && playerIsFiring == 0)
				{
					pWFA[currentPlayer] = fWIT[playersWeapon][dAANMA];
					playerIsFiring = 1
					playerIsNotFiring = 0
				}
				if (!ent.IsPressingAttack() && playerIsNotFiring == 0 || ent.IsPressingBackward() && playerIsNotFiring == 0 )
				{
					pWFA[currentPlayer] = fWIT[playersWeapon][dAANMI];
					playerIsFiring = 0
					playerIsNotFiring = 1
				}
				if (ppWC != pWC)
				{
					ppWC[currentPlayer] = playersWeapon;
					playerIsNotFiring = 0
				}
			}
			else
			{
				pWFA[currentPlayer] = 1;
			}
			aPWSA[currentPlayer] = ent.GetHeldItems();
			foreach (wep in aPWSA[currentPlayer])
			{
				local inventoryWeapon = wep.GetClassname();
				if (inventoryWeapon != playersWeapon && inventoryWeapon in fWIT)
				{
					local currentFriction = ent.SetFriction(pWFA[currentPlayer] + fWIT[inventoryWeapon][dAANMI] - 1)
					if (oldFriction != currentFriction)
					{
						oldFriction = ent.SetFriction(pWFA[currentPlayer] + fWIT[inventoryWeapon][dAANMI] - 1);
						ent.SetFriction(pWFA[currentPlayer] + fWIT[inventoryWeapon][dAANMI] - 1);
					}
				}
				else
				{
					ent.SetFriction(pWFA[currentPlayer]);
				}
			}
		}
	}
}

//grab the most recent oxygen tank without a health of 20 and send the infected to that location, excluding the roadcrew
::oxyTankChase <- function (args)
{
	oxyTank <- null;	
	local setInfectedChase = 0;
	local oxyTankLocation = Vector(0,0,0);
	local ent = null;
	while (ent = Entities.FindByClassname(ent, "prop_physics"))
	{
		if (ent.IsValid())
		{
			local model = NetProps.GetPropString( ent, "m_ModelName" );
			if (model == "models/props_equipment/oxygentank01.mdl")
			{
				if (ent.GetHealth() != 20)
				{
					oxyTank = ent
					setInfectedChase = ent.GetHealth()
					oxyTankLocation = ent.GetOrigin()
				}
			}
		}
	}	
	local ent = null;
	if (setInfectedChase == 99)
	{
		while(ent = Entities.FindByClassnameWithin(ent, "infected",oxyTankLocation,750))
		{
			local model = NetProps.GetPropString( ent, "m_ModelName" );
			//roadcrew have earplugs according to Valve so they should not react to the sound of the oxytanks rapid degassing
			switch(model)
			{
				case "models/infected/common_male_roadcrew.mdl":			
				case "models/infected/common_male_roadcrew_rain.mdl":
					break;				
				default:
					CommandABot({cmd = 0, bot = ent, target = oxyTank})
					break;
			}			
		}	
	}	
}



::endGameSpeedUp <- function (params)
{
	Utils.SlowTime(eGGSA[dAANNR], 2.0, 1.0, 1.5, false);
}

Msg("Loaded: aTFuncs.nut\n");