IncludeScript ("config.nut");
IncludeScript("VSLib");
printf( "\n\n\n\n==============Loaded COOP =============== %f\n\n\n\n", __COOP_VERSION__);


DirectorOptions <-
{
	SpecialRespawnInterval  =  0
	MaxSpecials = 0
	DominatorLimit = 0
	CommonLimit = 0
	//cm_AllowSurvivorRescue = 1
	BoomerLimit = 0
	SpitterLimit = 0
	SmokerLimit = 0
	HunterLimit = 0
	ChargerLimit = 0
	JockeyLimit = 0
	cm_InfiniteFuel = 1
	cm_NoSurvivorBots = 0
	//Any player enters the vehicle to escape successfully. The vehicle drives away, the end screen begins//任何一个玩家进入载具逃生便成功。载具开走，结束画面开始
	//cm_FirstManOut = 1
	cm_BaseSpecialLimit = 0
	
	SpecialInitialSpawnDelayMin = 0
	SpecialInitialSpawnDelayMax = 2
	//Allows special sense when the tank is in//坦克在的时候允许刷特感
	ShouldAllowSpecialsWithTank = true

	//While the tank is in, the mobs are allowed//坦克在的时候允许刷尸潮
	ShouldAllowMobsWithTank = true	
	ProhibitBosses = false

	SurvivorMaxIncapacitatedCount = 2
	TankHitDamageModifierCoop = 1.0
	cm_AutoReviveFromSpecialIncap = true 


	//The dynamic range of the number of zombies//尸潮僵尸数量动态浮动范围 
    
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
	SustainPeakMaxTime = 30
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
	MobMaxPending = 10
	
	//Guessing it's the speed at which a mob regenerates (i.e. next mob).
	//MobRechargeRate =  //int
	
	//Wanderers
	//WanderingZombieDensityModifier =1 //float
	//AlwaysAllowWanderers =true//bool
	//ClearedWandererRespawnChance //percent int
	//NumReservedWanderers //infected additional from mobs
	//All survivors must be below this intensity before a Wanderer is allowed to switch to Relax (in addition to the normal peak timer)
	//IntensityRelaxAllowWanderersThreshold
	
	//When fewer than this many of a mob are in play, the mob music stops.
	//MusicDynamicMobScanStopSize =6
	//MusicDynamicMobSpawnSize = 30
	//When a mob gets to this size we think about stopping the mob music
	//MusicDynamicMobStopSize = 12
	
	//Set the following values, feel during the test, in the official picture will make the special feeling have a better birth point//设置以下值，测试中感觉,在官图中会让特感有更好的出生点
	//SPAWN_ABOVE_SURVIVORS, SPAWN_ANYWHERE, SPAWN_BEHIND_SURVIVORS, SPAWN_FAR_AWAY_FROM_SURVIVORS, SPAWN_IN_FRONT_OF_SURVIVORS, SPAWN_LARGE_VOLUME, SPAWN_NEAR_IT_VICTIM, SPAWN_NO_PREFERENCE   
	PreferredMobDirection = SPAWN_IN_FRONT_OF_SURVIVORS
	ZombieSpawnRange = 1000
	//SPAWN_SPECIALS_ANYWHERE, SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS
	PreferredSpecialDirection = SPAWN_SPECIALS_ANYWHERE
	//ShouldConstrainLargeVolumeSpawn = false
	//ShouldIgnoreClearStateForSpawn  = true

	cm_TempHealthOnly = 1
	TempHealthDecayRate = 0.001
	LeftSafeAreaTrigger  = false
	function RecalculateHealthDecay()
	{
		if ( Director.HasAnySurvivorLeftSafeArea() )
		{
			TempHealthDecayRate = 0.27 // pain_pills_decay_rate default
			if(!LeftSafeAreaTrigger  && InfHordes)
			{
				Mob_Time[0] = 1;
				Mob_Time[1] = 3;
				Director.ResetMobTimer()		// Sets the mob spawn timer to 0.
				Director.PlayMegaMobWarningSounds()	// Plays the incoming mob sound effect.	
				LeftSafeAreaTrigger = true;			
			}	
		}
	}

//物品替换。药役 药抗 药生存 t1武器战役。替换掉针
//Item replacement. Drug Battle Drug Resistance Drug Survival T1 Weapon Campaign. Replace the needle
	function ConvertWeaponSpawn( classname )
	{			
		if ( classname in weaponsToConvert )
		{
			return weaponsToConvert[classname];	
		}	
		return 0;
	}	
	//Give t1 a big gun at the start, not melee//开局给t1大枪 不给近战
	FirstWeapon =
	[
		"shotgun_chrome",
		"pumpshotgun",
		"smg_silenced",
		"smg",
	]
	SecondWeapon =
	[
		"katana",
		"fireaxe",
		"frying_pan",
		"machete",
		"baseball_bat",
		"crowbar",
		"cricket_bat",
		"tonfa",
		"electric_guitar",
		"knife",
		"golfclub",
	]	
	function GetDefaultItem( idx )
	{
		if(idx == 0)
		{
			return FirstWeapon[RandomInt(0,FirstWeapon.len()-1)];	
		}
		if(idx == 1)
		{
			return SecondWeapon[RandomInt(0,SecondWeapon.len()-1)];	
		}
		return 0;
	}	
	//Do not let computer players pick up the small pistol. Especially ellis. I took a sniper like a mentally retarded, and brought two small pistols to be beaten out by a special feeling.//不让电脑玩家拾取小手枪。特别是ellis。智障一样拿个狙击，带两个小手枪被特感捶出翔。
	weaponsToRemove =
	{
		weapon_pistol = 0
	}	
	function ShouldAvoidItem( classname )
	{
		if ( classname in weaponsToRemove )
		{
			return true;
		}
		return false;
	}		
}



//=============DirectorOptions Variable control 变量控制=========================//




//Normal map. Official map, follow this logic//正常地图。官图 走这条逻辑

if(Utils.IsFinale() && NumCansNeeded>0)
{
	local index = null; 
	// ::VSLibScriptStart <- function (){}
	while ((index = Entities.FindByClassname(index, "trigger_finale")) != null)
	{
		Msg("===============trigger_finale========="+index.GetName()+"========================\n");
		index.ConnectOutput( "FinaleStart", "StartModifyGasCanPoured");
	}		
	//控制油桶数量。只能少于官方。由于油桶基本上是开局就产生。这里暂时不考虑奇葩三方图的设定。
	//需要注意的是 油桶在每次地图载入后修改便成为定数。之后即使灭团重启，删除的油桶也不会再复原产生。
	//Control the number of oil drums. It can only be less than the official. Because the oil barrels are basically produced at the beginning. The setting of the wonderful tripartite graph is not considered here for the time being.
	//It should be noted that the oil barrel will become a fixed number after each map is loaded. Afterwards, even if the group is destroyed and restarted, the deleted oil drums will not be restored.
	local AllGascans = [];
	local GascanCount = 0;
	while ((index = Entities.FindByClassname(index, "weapon_scavenge_item_spawn")) != null)
	{
		if (index.IsValid())
		{
			AllGascans.insert(GascanCount++,index);//gascan.GetIndex()		
		}
	}		
	while(AllGascans.len()>NumCansNeeded)
	{
		local Num = RandomInt(0,AllGascans.len()-1);
		if (AllGascans[Num].IsValid())
		{
			Entity(AllGascans[Num]).KillEntity();
			AllGascans.remove(Num);	
		}
	}
	Msg("Numero de Gasolinas Modificado: "+AllGascans.len()+"\n");
	//Msg("Gascans数量修改为: "+AllGascans.len()+"\n");
}
::StartModifyGasCanPoured<-function()
{
	Msg(" StartModifyGasCanPoured \n");
	local index = null;
	//Set the hud display. For example, c6m3 0/16. Under normal circumstances, the hud will be displayed immediately after trigger_finale is turned on. Part will only advance, not lag.
	//设置 hud显示 例如 c6m3 0/16  正常情况下当trigger_finale开启后立即显示hud。部分只会提前，不会滞后。
	while ((index = Entities.FindByClassname(index, "game_scavenge_progress_display")) != null)
	{
		EntFire( index.GetName(), "SetTotalItems", ::NumCansNeeded);
	}	
	//部分三方图会延迟创建灌油口。也不知道作者怎么想的。添加timer延迟
	//并且官方图很少有直接可以灌油。一般玩家到油口都会有几秒时间 yama 延迟3秒产生usetarget
	//Part of the tripartite graph will delay the creation of the filling port. I don't know what the author thinks. Add timer delay
	//And few official maps can be directly filled with oil. Generally, players will have a few seconds to reach the oil port. Yama will delay 3 seconds to generate usetarget.
	VSLib.Timers.AddTimer ( 3.1, false, RelayModifyUseTarget);		
}
::RelayModifyUseTarget<-function(o)
{
	local index = null;
	//Oil filling port Add output event, which mainly actually controls the number of oil filling. Basically, the tripartite graph will not be invalid if the official script content is used
	//灌油口 添加output事件，主要实际控制灌油次数。基本上三方图如果沿用官方脚本内容，那么将不会失效
	while ((index = Entities.FindByClassname(index, "point_prop_use_target")) != null)
	{
		Msg("===============use_target========="+index.GetName()+"========================\n");
		index.ValidateScriptScope();
		index.ConnectOutput( "OnUseFinished", "OnGasCanPoured");
	}		
}
::GasCansPoured <- 0;
::OnGasCanPoured <- function()
{	
   GasCansPoured++;
    if ( GasCansPoured == NumCansNeeded )
    {
		//The official map script executes the escape code. Part of the regular tripartite extension//官图脚本执行逃生代码。部分正规三方延用
		Msg(" Modify needed: " + NumCansNeeded + "\n") 
        EntFire( "relay_car_ready", "trigger" );
        EntFire( "relay_car_ready", "kill" );	
		//Algunos gráficos tripartitos se utilizan básicamente de forma lógica
		//部分三方图逻辑上基本会使用	
		local index = null;
		//Puerto de llenado de aceite Agregue el evento de salida, que en realidad controla principalmente el número de llenado de aceite. Básicamente, el gráfico tripartito no será inválido si se utiliza el contenido oficial del script.
		//灌油口 添加output事件，主要实际控制灌油次数。基本上三方图如果沿用官方脚本内容，那么将不会失效
		while ((index = Entities.FindByClassname(index, "math_counter")) != null)
		{
			Msg("===============math_counter========="+index.GetName()+"========================\n");
			EntFire( index.GetName(), "setvalue",999,1.0 );	
		}			
    }
}

if(!BleedOut)
{
	delete DirectorOptions.cm_TempHealthOnly;
}
else
{
	ConvertType = 1;
}

switch(ConvertType)
{
	case 0:
	{
		::weaponsToConvert <-{}	
		break;
	}
	case 1:
	{
		//1. Pharmacy: Replace the medicine pack with medicine bottle
		::weaponsToConvert <-
		{
			weapon_first_aid_kit =	"weapon_pain_pills_spawn"
			weapon_adrenaline = "weapon_pain_pills_spawn"
		}	
		break;
	}
	case 2:
	{
		// El frasco de pastillas reemplaza todos los paquetes + todas las armas en el mapa t2 se reemplazan con armas t1 on the basis of 1. Increased difficulty
		//藥瓶替換所有包+地圖所有武器替換為t1武器
		::weaponsToConvert <-
		{
			weapon_first_aid_kit =	"weapon_pain_pills_spawn"
			weapon_adrenaline = "weapon_pain_pills_spawn"
		
			weapon_autoshotgun = "weapon_pumpshotgun_spawn"
			weapon_shotgun_spas = "weapon_shotgun_chrome_spawn"
			weapon_rifle_ak47 = "weapon_smg_silenced_spawn"
			weapon_rifle_desert = "weapon_smg_spawn"
			weapon_rifle_sg552 = "weapon_smg_silenced_spawn"
			weapon_rifle = "weapon_smg_silenced_spawn"
			weapon_smg_mp5 = "weapon_smg_spawn"
			weapon_sniper_awp = "weapon_hunting_rifle_spawn"
			weapon_sniper_military = "weapon_hunting_rifle_spawn"
			weapon_sniper_scout	 = "weapon_hunting_rifle_spawn"
		}
		break;
	}
	case 3:
	{
		//3. T1 weapons Replace all t2 weapons with t1 [t2 weapons are continuous spray ak47, etc., t1 weapons are single spray and smg machine guns, etc. There are only 4 cs weapons as hidden weapons, the script has been unlocked and the damage rate has been increased]
		//藥瓶替換所有包+地圖所有武器替換為t1武器
		::weaponsToConvert <-
		{
			weapon_autoshotgun = "weapon_pumpshotgun_spawn"
			weapon_shotgun_spas = "weapon_shotgun_chrome_spawn"
			weapon_rifle_ak47 = "weapon_smg_silenced_spawn"
			weapon_rifle_desert = "weapon_smg_spawn"
			weapon_rifle_sg552 = "weapon_smg_silenced_spawn"
			weapon_rifle = "weapon_smg_silenced_spawn"
			weapon_smg_mp5 = "weapon_smg_spawn"
			weapon_sniper_awp = "weapon_hunting_rifle_spawn"
			weapon_sniper_military = "weapon_hunting_rifle_spawn"
			weapon_sniper_scout	 = "weapon_hunting_rifle_spawn"
		}
		break;
	}	
}

if(!InfHordes)
{
	delete	DirectorOptions.LockTempo;
	delete	DirectorOptions.IntensityRelaxThreshold;
	// Etapa de relajación//放松阶段
	delete DirectorOptions.RelaxMinInterval;
	delete DirectorOptions.RelaxMaxInterval;
	delete	DirectorOptions.RelaxMaxFlowTravel;
	// Pico continuo//持续高峰
	delete DirectorOptions.SustainPeakMinTime;
	delete DirectorOptions.SustainPeakMaxTime;
	delete DirectorOptions.ZombieSpawnRange;
	//delete DirectorOptions.MobMaxPending;
	delete DirectorOptions.MobSpawnMinTime;
	delete DirectorOptions.MobSpawnMaxTime;
}


// Si la campaña completa cuerpo a cuerpo no ha terminado, solo estará disponible para armas afiladas. Se originó en el modo de mutación 4 Swordsman
//如果没有结束全近战全图可用只给利器 源于4剑客突变模式
::SecondLockWeapon <-
[
	"katana",
	"fireaxe",
]	
if(!UnlockMelee)
{
	DirectorOptions.SecondWeapon = ::SecondLockWeapon;
}

if(!AllowGiveItem)
{
	delete DirectorOptions.FirstWeapon;
	delete DirectorOptions.SecondWeapon;
	delete DirectorOptions.GetDefaultItem;	
}
if(!FastMode)
{
	delete DirectorOptions.SpecialInitialSpawnDelayMin;
	delete DirectorOptions.SpecialInitialSpawnDelayMax;
}
if(!AutoMode)
{
	delete DirectorOptions.cm_BaseSpecialLimit;	
}
else
{
	delete DirectorOptions.BoomerLimit;	
	delete DirectorOptions.SpitterLimit;	
	delete DirectorOptions.SmokerLimit;	
	delete DirectorOptions.HunterLimit;	
	delete DirectorOptions.ChargerLimit;	
	delete DirectorOptions.JockeyLimit;	
}

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
//Ejecutado a cada rato
function VSLib::EasyLogic::Update::DateUpDate()
{
//	Msg("DateUpDate \n");

	Msg("DirectorOptions.cm_CommonLimit "+DirectorOptions.GetDirectorOptions().cm_CommonLimit);
	Msg("DirectorOptions.CommonLimit "+DirectorOptions.GetDirectorOptions().CommonLimit);
	if(NoZombie)
	{
		// Los zombis errantes normales son 0//普通徘徊僵尸为0
		Base_Zombie = 0;
		// Apaga el mob//关闭尸潮	
		Mob_Time[0] = 99999;
		Mob_Time[1] = 99999; 
		if( !removed_common_spawns )
		{
			EntFire( "intro_zombie_spawn", "kill" );
			EntFire( "zspawn_lobby_fall_1", "kill" );
			EntFire( "zspawn_lobby_fall_2", "kill" );
			EntFire( "zspawn_lobby_fall_3", "kill" );
			EntFire( "zspawn_lobby_fall_4", "kill" );
			EntFire( "zspawn_lobby_fall_5", "kill" );
			EntFire( "zspawn_fall_1", "kill" );
			EntFire( "zspawn_fall_2", "kill" );
			EntFire( "zombie_outro", "kill" );
			EntFire( "escape_zombie", "kill" );
			EntFire( "zspawn_zombie_safe", "kill" );
			EntFire( "zspawn_zombie_safe2", "kill" );
			EntFire( "spawn_zombie_van", "kill" );
			EntFire( "spawn_zombie_alarm", "kill" );
			EntFire( "spawn_zombie_alarm2", "kill" );
			EntFire( "zombie_spawn1", "kill" );
			EntFire( "spawn_zombie_run", "kill" );
			EntFire( "spawn_zombie_end", "kill" );
			EntFire( "infected_spawner", "kill" );
			EntFire( "infected_spawner2", "kill" );
			EntFire( "spawn_zombie_location1", "kill" );
			EntFire( "spawn_zombie_location2", "kill" );
			EntFire( "spawn_zombie_location3", "kill" );
			EntFire( "spawn_zombie_location4", "kill" );
			EntFire( "spawn_zombie_location5", "kill" );
			EntFire( "spawn_zombie_location6", "kill" );
			removed_common_spawns = true;
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
	// Obtenga el número real de personas//获取实际人数
	local Client_Count = 0;
	foreach( survivor in ::VSLib.EasyLogic.Players.Survivors() )
	{
		if(!::AllowShowBotSurvivor)
		{
			if(survivor.IsBot())
				continue;	
		}


		KillNum.insert(Client_Count++,survivor.GetIndex());
		if(!PlayerKillCout.rawin(survivor.GetIndex()))
		{
			PlayerKillCout[survivor.GetIndex()] <- 0;	
			PlayerRandCout[survivor.GetIndex()] <- RandomInt(0,9);	
		}
	}	
	//printl ("Número real de personas:" + Client_Count + "\n");
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
	killcout = 0;
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
		killcout = killcout + PlayerKillCout[KillNum[i]];
	
	}
	//KillsCout = killcout;

	//Calcular//计算
	DirectorOptions.SurvivorMaxIncapacitatedCount = MaxIncapacitatedCount;
	// Permite SI cuando el tanque está en//坦克在的时候允许刷特感
	DirectorOptions.ShouldAllowSpecialsWithTank = AllowSpecialsWithTank
	// Mientras el tanque está dentro, se le permite deslizar mobs.//坦克在的时候允许刷尸潮。。
	DirectorOptions.ShouldAllowMobsWithTank = AllowMobsWithTank	
	DirectorOptions.cm_NoSurvivorBots = SoloMode
	DirectorOptions.ProhibitBosses = BlockTankWitch
	DirectorOptions.cm_AutoReviveFromSpecialIncap = AutoRevive;
	DirectorOptions.TankHitDamageModifierCoop = TankHitDamage 	
	if(AutoMode)
	{
		local curMaxSI = 0;
		// Cuando el modo automático está activado. Verifique si el denominador es 0 y use directamente el valor máximo básico
		// Cuando un jugador o ningún jugador usa el valor base.
		//当开启自动模式。检测分母是否为0 直接使用基础最大值
		//当一个玩家或者没有玩家使用基础值。
		if( Add_SI[0] == 0 || Client_Count <=1)
		{
			curMaxSI = Max_SI;			
		}
		else
		{
			// Cuando el número de personas sea mayor que 1. Empiece a contar.//当人数大于1.开始计算。
			if(Client_Count>1)
			{
				curMaxSI = Max_SI+((Client_Count-1)/Add_SI[0]*Add_SI[1]);
			}	
		}
		// Seleccione aleatoriamente el valor máximo de cada característica según el número máximo.
		//El valor máximo es 5.5x6 = 30. Puede haber 30. 
		//Puede satisfacer completamente todas las posibilidades aleatorias.
		//按最大数量随机取每种特感的最大值 最大取值5.5x6=30.可能出现30。完全可以满足所有随机可能性。
		local SpecialLimit=0;
		if(curMaxSI > 6 && curMaxSI <= 12)
			SpecialLimit =RandomInt(2,3);		
		else if(curMaxSI > 12)
			SpecialLimit =RandomInt(3,5);
		else // El bit máximo real de SI es 14, 
			//por lo que cada tipo de 3 puede producir completamente todos los SI.//特感实际最大位14，所以每种3只可以完全产生所有特感。
			SpecialLimit =RandomInt(1,2);
		// Configuración del modo dinámico//动态模式设置
		//Msg("Random "+SpecialLimit+"/"+curMaxSI+"\n")
		DirectorOptions.MaxSpecials = curMaxSI;
		DirectorOptions.DominatorLimit = curMaxSI;	
		DirectorOptions.cm_BaseSpecialLimit = SpecialLimit;
	}
	else
	{
		// Configuración de modo fijo//固定模式设置
		DirectorOptions.MaxSpecials = Max_SI;
		DirectorOptions.DominatorLimit = Max_SI;		
		DirectorOptions.BoomerLimit = SISpilt[0];
		DirectorOptions.SpitterLimit = SISpilt[1];
		DirectorOptions.SmokerLimit = SISpilt[2];
		DirectorOptions.HunterLimit = SISpilt[3];
		DirectorOptions.ChargerLimit = SISpilt[4];
		DirectorOptions.JockeyLimit = SISpilt[5];		
	}
	DirectorOptions.SpecialRespawnInterval  = Base_SI_Time;
	//DirectorOptions.CommonLimit = Base_Zombie;
	DirectorOptions.cm_InfiniteFuel = InfiniteFuel;
	//DirectorOptions.cm_AllowSurvivorRescue = AllowRescue;
	DirectorOptions.RecalculateHealthDecay();

	// La mob relacionada//尸潮相关
	if(InfHordes)
	{
		DirectorOptions.MobSpawnMinTime =Mob_Time[0];
		DirectorOptions.MobSpawnMaxTime =Mob_Time[1];
	}	
	DirectorOptions.MobMinSize =Mob_Size[0];
	DirectorOptions.MobMaxSize =Mob_Size[1];
	DirectorOptions.MobMaxPending =Mob_MaxPend;	

	if(FastMode)
	{
		DirectorOptions.SpecialInitialSpawnDelayMin = SpecialSpawnDelay[0];
		DirectorOptions.SpecialInitialSpawnDelayMax = SpecialSpawnDelay[1];
	}
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

if(InfAmmo)
{
function Notifications::OnWeaponFire::WeaponFire(entity,  weapon, params )
{
	// Lanzamiento infinito//无限投掷
//	if(weapon.find("molotov") || weapon.find("pipe_bomb") || weapon.find("vomitjar"))
//{
//		Timers.AddTimer ( 1.4, false, ReGive, { entity = entity, weapon = weapon});		
//	}	
	//Arma principal//主武器
	if(weapon.find("rifle") || weapon.find("smg") || weapon.find("sniper") || weapon.find("shotgun")  || weapon.find("grenade_launcher") )
	{
		entity.SetPrimaryClip(entity.GetPrimaryClip()+1);
		entity.SetPrimaryUpgrades(entity.GetPrimaryUpgrades());	
	}
	// La motosierra de arma secundaria tiene una opción de motosierra ilimitada de director independiente//副武器  电锯有单独的director无限电锯选项
	if(weapon.find("pistol") )
	{
		local t = entity.GetHeldItems();
		
		if (t && "slot1" in t)
		{
			t["slot1"].SetNetProp( "m_iClip1",t["slot1"].GetClip()+1 );
		}		
	}
}
}	

::ReGive <- function(args)
{
	Player(args.entity).Give(args.weapon);
}	
 
 
function Notifications::OnPlayerLeft::PlayerLeft(entity, name, steamID, params)
{
	if( null == entity|| SURVIVORS != entity.GetTeam())
		return;
	if(!::AllowShowBotSurvivor)
	{
		if(entity.IsBot())
			return;
	}
	if(PlayerKillCout.rawin(entity.GetIndex()))
	{
		delete PlayerKillCout[entity.GetIndex()];	
		delete PlayerRandCout[entity.GetIndex()];	
	}
}



::UpdateEntCount <- function(ClassName,Count,delay)
{	
	// Los elementos producidos directamente por el juego se procesan de forma predeterminada//默认处理游戏直接产出的物品

	// El manejo de la caja de suministros Dado que la caja de suministros 
	//no ha sido reemplazada por el director, significa que no es nativa del juego. 
	//Necesita retrasar el procesamiento
	//补给箱的处理.由于补给箱并未被director替换 ，说明其不是游戏原生。需要延迟处理
	if(1 == delay)
	{
		Timers.AddTimer ( 1.0, false, @(params) UpdateEntCount(params.classname, params.count,params.time),{classname = ClassName,count = Count,time = 0});			
	} 	
	else
	{
		// Para c6 y algunos gráficos tripartitos, se usarán plantillas para generar elementos. Aquí para hacer una detección y control
		//对于c6和一些三方图会使用模板进行物品的产生。这里做一个检测和控制
		if("point_template" == ClassName)
		{
			weaponindex <- null;
			while ((weaponindex = Entities.FindByClassname(weaponindex, ClassName)) != null)
			{
				weaponindex.ValidateScriptScope();
				weaponindex.ConnectOutput( "OnEntitySpawned", "ForceSpawn");	
			}
		}
		else
		{
			weaponindex <- null;
			while ((weaponindex = Entities.FindByClassname(weaponindex, ClassName)) != null)
			{
				weaponindex.__KeyValueFromInt("spawnflags", 1);	
				weaponindex.__KeyValueFromInt("spawn_without_director", 0);	
				weaponindex.__KeyValueFromInt("count", Count);	
			}		
		}
	}	
}

function Notifications::OnFootLockerOpened::WhenFootLocker(player, params)
{
	UpdateEntCount("weapon_molotov_spawn",1,1);
	UpdateEntCount("weapon_pipe_bomb_spawn",1,1);
	UpdateEntCount("weapon_vomitjar_spawn",1,1);
	UpdateEntCount("weapon_pain_pills_spawn",1,1);
	UpdateEntCount("weapon_adrenaline_spawn",1,1);
	//UpdateEntCount("weapon_defibrillator_spawn",1,0);	
}




function Notifications::OnModeStart::GameStart(gamemode)
{			
	ShowRank();
	Msg("ShowRank"+"\n");
	//KillsCout = 0;	
		// c1m4 necesita retrasar la ejecución de SetTotalItems, para agilizar el código, fusionar,
	// Dos entidades utilizadas por unas tres partes en el capítulo no final para simular 
	//el sistema de rescate de llenado de aceite
	//c1m4 需要延迟执行SetTotalItems，为了精简代码，进行合并，
	//某些三方在非最终章节使用的两个实体进行模拟灌油营救系统
	if(NumCansNeeded>0 && ("coop" == ::VSLib.EasyLogic.BaseModeName ||"realism" == ::VSLib.EasyLogic.BaseModeName ) )
	{
		local index = null;
		while ((index = Entities.FindByClassname(index, "game_scavenge_progress_display")) != null)
		{
			Msg("==================progress_display======"+index.GetName()+"========================\n");
			EntFire( index.GetName(), "SetTotalItems", ::NumCansNeeded,3.0 );
			//EntFire(string target, string action, string value = null, float delay = 0, handle activator = null)
			//DoEntFire(index.GetName(), "SetTotalItems", ::NumCansNeeded, 3.0, null, null);
			//DoEntFire(string target, string action, string value, float delay, handle activator, handle caller)
		}	
		// Utilice solo el sistema de abastecimiento de combustible de los capítulos no finales
		// para parte del diagrama tripartito//只针对部分三方图在非最终章节使用加油系统
		while ((index = Entities.FindByClassname(index, "point_prop_use_target")) != null)
		{
			Msg("==================use_target======"+index.GetName()+"========================\n");
			index.ValidateScriptScope();
			index.ConnectOutput( "OnUseFinished", "OnGasCanPoured");
		}	
		// También para modificar el gráfico tripartito. Pero algunos mapas oficiales están en modo de búsqueda.//同样为了修改三方图。但是官方有些地图在scavenge模式
		local AllGascans = [];
		local GascanCount = 0;
		while ((index = Entities.FindByClassname(index, "weapon_scavenge_item_spawn")) != null)
		{
			if (index.IsValid())
			{
				AllGascans.insert(GascanCount++,index);//gascan.GetIndex()		
			}
		}		
		while(AllGascans.len()>NumCansNeeded)
		{
			local Num = RandomInt(0,AllGascans.len()-1);
			if (AllGascans[Num].IsValid())
			{
				Entity(AllGascans[Num]).KillEntity();
				AllGascans.remove(Num);	
			}
		}
		Msg("Modificar el número de Gascans a: "+AllGascans.len()+"\n");	
		//Msg("Gascans数量修改为: "+AllGascans.len()+"\n");		
	}

	// Un arma generada estáticamente. Como el del armario de armas//静态产生的武器。比如武器柜子上面的
	UpdateEntCount("weapon_pistol_spawn",Gun_Count,0);
	UpdateEntCount("weapon_pistol_magnum_spawn",Gun_Count,0);
	UpdateEntCount("weapon_smg_spawn",Gun_Count,0);
	UpdateEntCount("weapon_pumpshotgun_spawn",Gun_Count,0);
	UpdateEntCount("weapon_autoshotgun_spawn",Gun_Count,0);
	UpdateEntCount("weapon_rifle_spawn",Gun_Count,0); 
	UpdateEntCount("weapon_hunting_rifle_spawn",Gun_Count,0);
	UpdateEntCount("weapon_smg_silenced_spawn",Gun_Count,0);
	UpdateEntCount("weapon_shotgun_chrome_spawn",Gun_Count,0);
	UpdateEntCount("weapon_rifle_desert_spawn",Gun_Count,0);
	UpdateEntCount("weapon_sniper_military_spawn",Gun_Count,0);
	UpdateEntCount("weapon_shotgun_spas_spawn",Gun_Count,0);
	UpdateEntCount("weapon_rifle_ak47_spawn",Gun_Count,0);
	UpdateEntCount("weapon_smg_mp5_spawn",Gun_Count,0);
	UpdateEntCount("weapon_rifle_sg552_spawn",Gun_Count,0);
	UpdateEntCount("weapon_sniper_awp_spawn",Gun_Count,0);
	UpdateEntCount("weapon_sniper_scout_spawn",Gun_Count,0);
	// Armas dinámicas//动态产生的武器	
	UpdateEntCount("weapon_spawn",Gun_Count,0);
	// El tercer parámetro debe ser 0//第三个参数必须是0
	UpdateEntCount("point_template",2,0);

	UpdateEntCount("weapon_molotov_spawn",Throw_Count,0);
	UpdateEntCount("weapon_pipe_bomb_spawn",Throw_Count,0);
	UpdateEntCount("weapon_vomitjar_spawn",Throw_Count,0);
	
	UpdateEntCount("weapon_pain_pills_spawn",Pill_Count,0);
	UpdateEntCount("weapon_adrenaline_spawn",Pill_Count,0);
	UpdateEntCount("weapon_defibrillator_spawn",Pill_Count,0);
	UpdateEntCount("weapon_first_aid_kit_spawn",Pill_Count,0);
	UpdateEntCount("weapon_melee_spawn",Melee_Count,0);	

}


//==================================RankingTop3=======排行显示前4名玩家==============================================//
::ShowRank <- function()
{	
	local hudtip1 = HUD.Item("{rank01}\n{rank02}\n{rank03}");//\n{rank04}\n{rank05}\n{rank06}\n{rank07}\n{rank08}");
	hudtip1.SetValue("rank01", rank01);
	hudtip1.SetValue("rank02", rank02);
	hudtip1.SetValue("rank03", rank03);/*
	hudtip1.SetValue("rank04", rank04);
	hudtip1.SetValue("rank05", rank05);
	hudtip1.SetValue("rank06", rank06);
	hudtip1.SetValue("rank07", rank07);
	hudtip1.SetValue("rank08", rank08);*/
	hudtip1.AttachTo(HUD_FAR_LEFT);
	hudtip1.ChangeHUDNative(0, 0, 380, 110, 1280, 720);//(x, y, width, height, resx, resy)
	hudtip1.SetTextPosition(TextAlign.Left);
	hudtip1.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
	local hudtip2 = HUD.Item("33 B: {killcout}");//\n{rank05}\n{rank06}\n{rank07}\n{rank08}");
	hudtip2.SetValue("killcout", killcout);
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

::killcout <- function ()
{
	return KillsCout;
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
 
//===================================Tank HP========坦克血量显示===================================//
::HintCurrent <- {};
::MaxHealth <- {}; 

SkillRelease <- 2
farAway <- 3

if(SIBar_Show)
{

function Notifications::OnSpawn::OnPlayerSpawn(entity, params)
{
	if(entity.GetTeam() == SURVIVORS)
	{
		if(::AllowSpawnMelee)
		{
			local pos = entity.GetPosition();
			pos.z += 72.0;
			VSLib.Entity.SpawnRandomMelee( pos, UnlockMelee);	
		}
	}
	if(entity.GetTeam() == INFECTED)
	{
		if ( entity.GetType() == Z_TANK)
		{					
			// Cuando nace el tanque, el HP está al máximo// 当坦克出生时血量为最大值
			MaxHealth[entity.GetIndex()] <- entity.GetRawHealth();
			//Msg("tank" + entity.GetHealth());
			//Msg("tank" + entity.GetRawHealth());
			local HintUniqueName = CreateFollowHint(entity,healbar(entity));
			HintCurrent[entity.GetIndex()] <- Entities.FindByName(null,HintUniqueName);
			HintCurrent[entity.GetIndex()].__KeyValueFromString("hint_caption",healbar(entity));
			EntFire(HintCurrent[entity.GetIndex()].GetName(), "ShowHint");	
	
		}	
	}
}

/* 

armor:0
attackerentid:1
health:3966
dmg_armor:0
dmg_health:34
Priority:5
attacker:6
userid:18
weapon:pistol
type:2
hitgroup:2
splitscreenplayer:0

 */

function Notifications::OnHurt::Hurt ( victim, attacker, params )
{	
	if(victim.GetType() == Z_TANK)
	{
		if(victim.IsIncapacitated()) 
			return;
		
		if(!HintCurrent.rawin(victim.GetIndex()))
			return;
		//Msg("tank:" + victim.GetNetPropInt( "m_iMaxHealth"));

		HintCurrent[victim.GetIndex()].__KeyValueFromString("hint_caption", healbar(victim));
		EntFire(HintCurrent[victim.GetIndex()].GetName(), "ShowHint");		

	}
}


function Notifications::OnIncapacitated::OnTankDying(entity,attacker ,params)
{
	if(entity.GetTeam() == INFECTED)
	{
		if(HintCurrent[entity.GetIndex()] == null)
			return;
		HintCurrent[entity.GetIndex()].__KeyValueFromString("hint_caption", "(●︶╯﹏╰︶●)");
		EntFire(HintCurrent[entity.GetIndex()].GetName(), "ShowHint");	
		DoEntFire("!self", "Kill", "", 6.0, null, HintCurrent[entity.GetIndex()]);
		delete HintCurrent[entity.GetIndex()];
		delete MaxHealth[entity.GetIndex()];
	} 
}


}

//==================================Cambio automático de campaña===自动换图============================================================//
/*
对于添加三方图的处理方式 直接添加关键字c14m  c15m 等等

"c14m": ["三方图首章节名","末章节名"]

由于服务器直接用vpk文件，那么在联机的时候，自动换图，会出现切图失败，玩家方会断开。

玩家客户端需要做下面的事情
1.解包三方图vpk，由于三方图直接覆盖原游戏对应的文件会造成一些删除麻烦和游戏意外事故的问题。一般需要自己新建一个文件夹 
 例如命名为left4dead2_dlc4  并把三方地图文件解包到该文件夹下

2.在left4dead2文件夹中gameinfo.txt文件中添加文件名路径 

		SearchPaths
		{
			Game				update
			Game				left4dead2_dlc3
			Game				left4dead2_dlc2
			Game				left4dead2_dlc1
			Game				|gameinfo_path|.
			Game				hl2
添加		Game				left4dead2_dlc4
		}

方法绝对没问题 ，因为很久没这样玩过三方服务器，所以如果失败需要多实验一下。

Para el método de agregar gráficos tripartitos, agregue directamente las palabras clave c14m, c15m, etc.

"c14m": ["El nombre del primer capítulo del mapa tripartito", "El nombre del último capítulo"]

Dado que el servidor usa directamente el archivo vpk, cuando está en línea, la campaña se cambiará automáticamente, la campaña no se cortará y el reproductor se desconectará.

El cliente del reproductor debe hacer lo siguiente
1. Desempaquete el vpk tripartito, debido a que el tripartito sobrescribe directamente los archivos correspondientes al juego original, causará algunos problemas en la eliminación y accidentes del juego. Por lo general, debe crear una nueva carpeta usted mismo.
  Por ejemplo, asígnele el nombre left4dead2_dlc4 y descomprima el archivo de mapa tripartito en esta carpeta.

2. Agregue la ruta del nombre del archivo al archivo gameinfo.txt en la carpeta left4dead2

SearchPaths
		{
			Game				update
			Game				left4dead2_dlc3
			Game				left4dead2_dlc2
			Game				left4dead2_dlc1
			Game				|gameinfo_path|.
			Game				hl2
Agregar juego		Game				left4dead2_dlc4
		}


El método no es ningún problema, porque no he jugado con un servidor de terceros como este durante mucho tiempo, por lo que si falla, debe experimentar más.

*/
/*
::ChangeMap<-
{
	"c1m": ["c1m1_hotel","c1m4_atrium","死亡中心"]
	"c2m": ["c2m1_highway","c2m5_concert","黑色狂欢节"]
	"c3m": ["c3m1_plankcountry","c3m4_plantation","沼泽激战"]
	"c4m": ["c4m1_milltown_a","c4m5_milltown_escape","暴风骤雨"]
	"c5m": ["c5m1_waterfront","c5m5_bridge","教区"]
	"c6m": ["c6m1_riverbank","c6m3_port","短暂时刻"]
	"c7m": ["c7m1_docks","c7m3_port","牺牲"]
	"c8m": ["c8m1_apartment","c8m5_rooftop","毫不留情"]
	"c9m": ["c9m1_alleys","c9m2_lots","坠机险途"]
	"c10m": ["c10m1_caves","c10m5_houseboat","死亡丧钟"]
	"c11m": ["c11m1_greenhouse","c11m5_runway","静寂时分"]
	"c12m": ["c12m1_hilltop","c12m5_cornfield","血腥收获"]
	"c13m": ["c13m1_alpinecreek","c13m4_cutthroatcreek","刺骨寒溪"]
}

// Será efectivo solo después de que se active el rescate.
// Se usa para mostrar alguna información de solicitud
//必须开启救援之后才有效。
//用于显示一些提示信息
::MapChangeMsg <- ""

function Notifications::OnFinaleWin::FinaleWin(map_name, diff, params)
{
	local tmptag; 
	foreach(tag,arrmap in ChangeMap)
	{
		for(local i = 0 ; i <= 1 ; i++)
		{
			if(arrmap[i].find(map_name) != null)
			{
				tmptag = tag;
			}
		}
	}

	local ex = regexp("[0-9]+");
	local res = ex.search(tmptag);
	local num = tmptag.slice(res.begin,res.end).tointeger();
	// Si el valor es 1 ~ 13, puede cambiar la campaña en orden.
	// [Este valor es solo personalizado, puede agregar c14m, c15m a infinito. c? m agregue el nombre y apellido del mapa de otros mapas tripartitos en la parte posterior]
	// Entonces 1 ~ 13 es el mapa oficial y 14 ~~ es el rango del mapa tripartito.
	//如果這個值是1~13那麽可以順序換圖。
	//【該值衹是自定義，可以添加c14m，c15m 到无穷大。 c?m在後面添加其他三方地圖首尾地圖名字】
	//那麽1~13是官方地圖，14~~ 是三方地圖範圍。
	if(1 <= num && num < 13)
	{
		num++;
	}
	else num = 1;

	Timers.AddTimer ( 12.0, true, StratChangeMap,num);	
	
	// Mostrar información de cambio de campaña//显示 换图信息
	::MapChangeMsg = "Al final de este capítulo, el mapa cambiará automáticamente a::"+ChangeMap["c"+ num + "m"][2];
	//::MapChangeMsg = "本章节结束,地图即将自动切换到:"+ChangeMap["c"+ num + "m"][2];
	
	local hudinfo = HUD.Item("{MapChange}");
	hudinfo.SetValue("MapChange", myMsgFunc);
	hudinfo.AttachTo(HUD_MID_BOX);
	hudinfo.ChangeHUDNative(400, 0, 600, 110, 1366, 720);
	hudinfo.SetTextPosition(TextAlign.Left);
	hudinfo.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 	
	
}

::myMsgFunc <- function ()
{
	return ::MapChangeMsg;
}

::StratChangeMap <- function(mapnum)
{
	SendToConsole("changelevel "+ChangeMap["c"+ mapnum + "m"][0]); 	
}

*/

/* **********************特感*special*hint************************************/
/*
entidad: cualquier entidad. Por ejemplo: tanque. bruja. sobreviviente. etc
strbar-callbac muestra el volumen de sangre. Se usa para establecer hint_caption
entity - 任意实体。例如：tank。witch。survivor。 etc
strbar - callbac 显示血量。用于设置 hint_caption
*/
function Precache()
{
	Utils.PrecacheModel("models/editor/axis_helper_thick.mdl");
	Utils.PrecacheModel("models/infected/witch.mdl");
	Utils.PrecacheModel("models/infected/witch_bride.mdl");	
	Utils.PrecacheCSSWeapons( );
}


//_4_prop_dynamic_(1)Tank
::CreateFollowHint <- function(entity,StrBar)
{
	HintSpawnInfo <-
	{
		hint_auto_start = "1"
		hint_range = "0"
		hint_suppress_rest = "1"
		hint_nooffscreen = "1"
		hint_forcecaption = "0"
		hint_icon_onscreen = "" //icon_skull
		hint_color = "155 255 10"
		hint_allow_nodraw_target = "0"
		//targetname = "c_d_hint_" + entity.GetName()
	}	
	local hintname = "c_d_hint_" + entity.GetName();
	HintSpawnInfo["targetname"] <- hintname;
	
	local spawn =
	{
		classname = "prop_dynamic",
		solid = "0",
		model = "models/editor/axis_helper_thick.mdl",
		disableshadows = "1",
		targetname = "prop_dynamic_" + entity.GetName() ,
		rendermode = "10",
		angles = QAngle(0, 0, 0)
	};
	spawn["spawnflags"] <- 256;
	local pos = entity.GetEyePosition();
	pos.z += 20.0;
	local prop_dynamic = g_ModeScript.CreateSingleSimpleEntityFromTable(spawn);
	prop_dynamic.ValidateScriptScope();
	local TankUniqueName = prop_dynamic.GetName();;
	
	AttachOther(PlayerInstanceFromIndex(entity.GetIndex()),prop_dynamic, true,pos);
	g_MapScript.CreateHintTarget( TankUniqueName, prop_dynamic.GetOrigin(), null, g_MapScript.TrainingHintTargetCB )
	g_MapScript.CreateHintOn(TankUniqueName, null,StrBar, HintSpawnInfo, g_MapScript.TrainingHintCB )
	local ex = regexp("[0-9]+");
		
	local res = ex.search(SessionState.TrainingHintTargetNextName);
	
	local num = SessionState.TrainingHintTargetNextName.slice(res.begin,res.end).tointeger();
	SessionState.rawdelete( "TrainingHintTargetNextName" );

	return "_"+(++num)+"_"+hintname;
}



::AttachOther <- function(entity,otherEntity, teleportOther,pos)
{
	teleportOther = (teleportOther.tointeger() > 0) ? true : false;
	if (teleportOther)
		otherEntity.SetOrigin(pos);
	DoEntFire("!self", "SetParent", "!activator", 0, entity, otherEntity);
}

::healbar<-function(victim)
{
	// Obtén la máxima salud//获取最大血量
	local fullheal = victim.GetNetPropInt( "m_iMaxHealth");
	// Obtenga el volumen de sangre real//获取实际血量
	local remainheal  = victim.GetRawHealth();
	local BAR = "";
	if(SIBar_type)
	{
		// Visualización de iconos//图标显示
		local x = "✿";//✿ ☻
		local _x = "❀";//❀ ☺
		local count = remainheal/(fullheal/10.0);	
		for(local i=-1 ; i<ceil(count); i++)
		{
			if(-1 == i)
			{
				BAR += "༺";
			}
			else BAR += x;
		}
		for(local i = ceil(count); i<=10 ; i++)
		{
			if(10 == i)
			{
				BAR += "༻";
			}
			else BAR += _x;
		}		
		
	}
	else
	{
		//Pantalla digital//数字显示

		BAR = "[" + victim.GetName()+ "]HP:" + remainheal;
		
	}		
	return BAR;
}


::AttachParticle <- function(ent,particleName = "", duration = 0.0)
{	
	if (particleName=="achievedT"&&::tankcup)
		particleName=="achieved"
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

//RawHealth:35 GetHealth:99.685 GetMaxHealth:100  
/*

blast:0
gender:2
minigun:0
headshot:0
weapon_id:2
attacker:3
splitscreenplayer:0
infected_id:0
victim:277
submerged:0
*/
/* 
loot掉落
suelta loot
 */
::LootTable <-
[	
	"weapon_first_aid_kit",
	"weapon_pain_pills",
	"weapon_adrenaline",
	"weapon_autoshotgun",
	"weapon_chainsaw",
	"weapon_defibrillator",
	"weapon_gascan",
	"weapon_fireworkcrate",
	"weapon_grenade_launcher",
	"weapon_pipe_bomb",
	"weapon_pistol_magnum",
	"weapon_oxygentank",
	"weapon_propanetank",
	"weapon_molotov",
	"weapon_vomitjar",
	"weapon_pumpshotgun",
	"weapon_rifle_ak47",
	"weapon_rifle_desert",
	"weapon_rifle_m60",
	"weapon_rifle_sg552",
	"weapon_rifle",
	"weapon_shotgun_chrome",
	"weapon_shotgun_spas",
	"weapon_smg_mp5",
	"weapon_smg_silenced",
	"weapon_smg",
	"weapon_sniper_awp",
	"weapon_sniper_military",
	"weapon_sniper_scout",
	"weapon_upgradepack_explosive",
	"weapon_upgradepack_incendiary",
	"weapon_melee"
]

function Notifications::OnSurvivorsDead::MissionLost()
{
	VSLib.Utils.DirectorBeginScript("director_quiet");	
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
					if(!attacker.IsBot()&& attacker.GetTeam() == SURVIVORS)
					{						
						KillsCout++;
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
					AttachParticle(survivor,"achievedT", 3.0);
					// No configures, la sangre se llena//不设置 虚血变成实血
					//survivor.SwitchHealth("perm");
					//HealthReg(survivor,tankgiveheal);	
					local pos = victim.GetPosition();
					pos.z += 72.0;					
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
				local _randHeal =RandomInt(healreg[0],healreg[1]);	
				//attacker.Speak("nicejob01");	
				if(!attacker.IsIncapacitated() && params["headshot"])
				{
					//HealthReg(attacker,_randHeal+headshot_add);
					local pos = victim.GetPosition();
					pos.z += 72.0;
					// El jugador dirá buen trabajo//玩家会说nicejob
	
					// Muestra un trofeo en la cabeza del jugador. Si el jugador tiene un tiro en la cabeza//在玩家头上显示一个奖杯。如果玩家爆头特感
					AttachParticle(attacker,"achieved", 3.0);
				
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
				local pos = victim.GetPosition();
				pos.z += 72.0;		
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
					AttachParticle(attacker,"achieved", 3.0);					
				}		
			}
			break;		
		}	
	}
}
 
/*
::ItemLoot<-function (pos)
{
	if(!::AllowLoot) return;
	// Se corrigió el tipo de entidad anormal después de que se produjeran algunas entidades físicas.
	//Por ejemplo, la caja de fuegos artificiales no se puede encender directamente después de caer.
	//修正部分物理實體產出后實體類型不正常。比如烟花盒掉落后不能直接點燃
	local targetname = LootTable[RandomInt(0,LootTable.len()-1)];
	if(targetname.find("oxygentank") || targetname.find("propanetank") || targetname.find("firework") ||  targetname.find("melee"))
	{
		if(targetname.find("oxygentank"))
			VSLib.Utils.SpawnEntity("prop_physics", "", pos, QAngle(0,0,0),{model = "models/props_equipment/oxygentank01.mdl"});	
		if(targetname.find("propanetank"))
			VSLib.Utils.SpawnEntity("prop_physics", "", pos, QAngle(0,0,0),{model = "models/props_junk/propanecanister001a.mdl"});	
		if(targetname.find("firework"))
			VSLib.Utils.SpawnEntity("prop_physics", "", pos, QAngle(0,0,0),{model = "models/props_junk/explosive_box001.mdl"});		
		if(targetname.find("melee"))
			VSLib.Entity.SpawnRandomMelee( pos, UnlockMelee);	
	}
	else
	{
		local ent =  VSLib.Utils.SpawnEntity(targetname, "", pos, QAngle(0,0,0),{});		
		if(ent.GetDefaultAmmoType() != null)
		{
			//printf(ent.GetExtraAmmo() + ":" + ent.GetMaxAmmo());	
			// Sin juicio de tipo, no se informa de errores para los atributos adicionales,
			//común a todas las clases de entidad
			//不做類型判斷，Extra屬性不報錯，所有實體類通用
			ent. SetExtraAmmo( ent.GetMaxAmmo() );
		}			
	}					
}


::HealthReg<-function (attacker,_randheal)
{
	if(!AllowRegained) return;
	if(attacker.IsIncapacitated() || !attacker.IsAlive() || attacker.IsHangingFromLedge()) return;
	
	local Difficulty = VSLib.Utils.GetDifficulty();
	// Establece la recuperación de HP y la recuperación de bala según la dificultad.//按照难度设置血量回复和子弹回复。
	switch(Difficulty)
	{
		case "easy": _randheal *= DifRate[0];
		case "normal": _randheal *= DifRate[0];
		case "hard": _randheal *= DifRate[0];
		case "impossible": _randheal *= DifRate[0];
	}

	
	local MaxHealth = attacker.GetMaxHealth();
	local GetHealth = attacker.GetHealth();
	local RawHealth = attacker.GetRawHealth();
	local HealthBuffer =  attacker.GetHealthBuffer();
	
	local child = attacker.FirstMoveChild()
	while (child)
	{			
		if ( child.GetClassname().find("shotgun") )
		{
			local _randAmmo = RandomInt(shotgunammo[0],shotgunammo[1]);
			attacker.GiveAmmo( _randAmmo );	
			break;
		}
		if(child.GetClassname().find("smg") )
		{
			local _randAmmo =RandomInt(smgammo[0],smgammo[1]);		
			attacker.GiveAmmo( _randAmmo );
			break;
		}			
		if(	child.GetClassname().find("rifle") )
		{
			local _randAmmo =RandomInt(rifleammo[0],rifleammo[1]);		
			attacker.GiveAmmo( _randAmmo );
			break;
		}			
		if(	child.GetClassname().find("sniper") )
		{
			local _randAmmo =RandomInt(sniperammo[0],sniperammo[1]);		
			attacker.GiveAmmo( _randAmmo );
			break;
		}
		if(child.GetClassname().find("grenade"))
		{
			local _randAmmo =RandomInt(grenadeammo[0],grenadeammo[1]);		
			attacker.GiveAmmo(_randAmmo);
			break;
		}		
			
	
		child = child.NextMovePeer();
	}		


	if(GetHealth <= MaxHealth)
	{
		// Si hay deficiencia de sangre, entonces se comprobará la deficiencia de sangre.//如果有虛血，那麽對虛血實體化。
		if(HealthBuffer > _randheal)
		{	
			attacker.SetHealthBuffer(HealthBuffer - _randheal);
			attacker.SetRawHealth(RawHealth + _randheal);
		}
		// Si no hay deficiencia de sangre. O la falta de sangre es insignificante//如果沒有虛血。或者虛血微不足道
		else
		{
			attacker.SetHealthBuffer(0);
			// Determinar si el HP final es mayor que el límite máximo//判斷是否最終血量大於最大上限
			if((RawHealth + _randheal)> MaxHealth)
			{	
				attacker.SetRawHealth(MaxHealth);
			}
			else
			{
			 // No mayor que el límite superior, lo que indica que hay una pequeña cantidad de sangre deficiente, que debe convertirse y aumentar el volumen de sangre real
			 //不大於上限 説明 有少量虛血 需要轉換和真實血量增加			
				attacker.SetRawHealth(RawHealth + _randheal);
			}
		}
	}
}

*/
// Modificación de daños//伤害修改 
/*
ScriptedDamageInfo <-
{
	Attacker = null              // handle of the entity that attacked
	Victim = null                // handle of the entity that was hit
	DamageDone = 0               // how much damage done
	DamageType = -1              // of what type
	Location = Vector(0,0,0)     // where
	Weapon = null                // by what - often Null (say if attacker was a common)
}
Se mejoró el daño de las armas ocultas de CSS.
提高調整 cs隱藏武器的傷害



function AllowTakeDamage( damageTable )
{
	if ( damageTable.Victim.GetClassname() == "prop_door_rotating" )
	{
		if( damageTable.Attacker.GetClassname() == "witch" )
		{
			if(DoorCanBreakByWitch)
			{
				::VSLib.Entity(damageTable.Victim).Break();		
				return true				
			}
			else
			{
				ScriptedDamageInfo.DamageDone = 0;
				return true
			}			
		}
		
	}

	if ( damageTable.Weapon != null )
	{

		if ( damageTable.Weapon.GetClassname() == "weapon_rifle_sg552" )
		{
			if(2 == ::VSLib.Entity(damageTable.Victim).GetTeam())
				ScriptedDamageInfo.DamageDone /= 2
			else
				ScriptedDamageInfo.DamageDone *= 2
			return true
		}
		if ( damageTable.Weapon.GetClassname() == "weapon_smg_mp5" )
		{
			if(2 == ::VSLib.Entity(damageTable.Victim).GetTeam())
				ScriptedDamageInfo.DamageDone /= 2
			else
				ScriptedDamageInfo.DamageDone *= 3
			return true
		}			
		if ( damageTable.Weapon.GetClassname() == "weapon_sniper_awp" )
		{
			if(2 == ::VSLib.Entity(damageTable.Victim).GetTeam())
				ScriptedDamageInfo.DamageDone /= 2
			else	
				ScriptedDamageInfo.DamageDone *= 3
			return true
		}
		if ( damageTable.Weapon.GetClassname() == "weapon_sniper_scout" )
		{
			if(2 == ::VSLib.Entity(damageTable.Victim).GetTeam())
				ScriptedDamageInfo.DamageDone /= 2
			else		
				ScriptedDamageInfo.DamageDone *= 2
			return true
		}			
	}	
	return true
}
*/
/*
最后更新2020-7-14
编辑者：C_D.og

注意：必须用整合包里面的vslib ，因为其中添加了一些功能用于该脚本。
该nut文件，名字默认为 coop 用于战役模式
更名为realism或者versus 用于写实或者对抗等。游戏模式名字自行百度修改。但是常用就是coop realism 
该脚本可以控制特感和普通僵尸刷新和数量，对于清道夫等防守模式可以调控难度。

所有控制参数请到配置文件config中设置。



文件内容列表：
1.控制游戏僵尸特感数量 刷新時間
2.显示前幾名排行  
3.坦克头顶血条显示 两种显示效果切换数字或者表情
4.控制游戏补给拾取次数
5.击杀回复血量和备用子弹。
6.开局产生近战武器 并不是直接拿在手上
7.爆头几率掉落道具。
8.解锁cs武器 修改cs隐藏武器伤害 
9.最终章节救援开始 自动换图并提示信息
10.药品替换 药役  武器替换 只有t1武器
11.控制witch是否能抓破普通门 【源于写实witch的特性】
12.添加一些细小的director控制参数和功能 例如倒地次数用于一命模式。是否有普通僵尸，源于特感速递。是否剔除bot用于单人模式。无限尸潮等


刷特重点：
在director控制下的刷特，游戏默认3特 预存3特
如果特感数量低于3  那么 这3只特感会连续刷出，直到刷完。
例子：如果设置为1特。虽然地图只能容纳1只特感，但这只特感死后马上会补齐另外一只，直到3只特感刷完。之后，进入刷新时间延迟，像45秒复活时间。

如果特感数量大于等于3 ，那么所有特感会一次性分前后直接刷完。例如绝境求生8特，一次性前后8只。

update

disable:
function Notifications::OnZombieDeath::ZombieDeath(victim, attacker, params)

update
修复 C6M1 ED_Alloc:no free edicts   当特感大于8出现的问题
update
修正 移除bot后排行hud中重名滞留的问题。新版本的问题。
添加单人模式 倒地次数自救的设置 允许玩家在单人模式下可以设置自救
添加回血回复备用子弹 开关 AllowRegained
添加物品掉落 开关 AllowLoot
添加是否开局直接给主武器和近战。近战同样受UnlockMelee控制多样性。
添加流血不止模式控制开关 BleedOut  并未控制堕落僵尸，原始模式也没做这个工作。所以再c6.堕落僵尸可能掉落药包
添加流血不止模式不出门不流血代码,并非需要开启流血模式才有效。如果有虚血的玩家开局，如果没有人离开安全区域则不开始减少虚血
添加ShouldAvoidItem director原生代码。阻止电脑玩家拾取小手枪。特别是ellis狙击加小手枪被僵尸锤成脑瘫
重做 无限尸潮模式 更好的无限尸潮
添加 尸潮时间和数量控制参数 Mob_Time 和 Mob_Size 以及尸潮预留僵尸数量Mob_MaxPend
修正 VSLib::Entity::SetUpgrades( upgrades ) 条件之外再次设置m_nUpgradedPrimaryAmmoLoaded导致主武器子弹设置不正常问题
添加 无限主副武器子弹。
添加 某些加油终章，需要加油的数量。NumCansNeeded 设置数量大于官方默认值，实际开启机关的需求仍然是官方设定。只有小于官方才能绕开官方的脚本逻辑。
修正 坦克血量数字过大显示科学记数法 4e+006 

 6特依旧出现一次ED_Alloc:no free edicts 
空载 重启增加   36 logic_auto

update 9.1
完善 坦克血条代码，修复一些插件中途修改坦克最大血量造成显示不正常的问题
完善 MissionLost事件之后进行延迟执行清理代码。免得特感清理的太突然，而感觉突兀。
完善 加油章节减少次数。同时随机调整油箱数量.对一些三方图做了最大的配合
update 9.2
添加自动调整特感模式。
update 9.3
修复 witch击杀统计重复。电脑击杀出现红字 AN ERROR HAS OCCURED [the index '4' does not exist]
取消 尸潮时间控制。保留给无限尸潮。只保留尸潮数

Última actualización 2020-7-14
Editor: C_D.og

Nota: Se debe usar vslib en el paquete integrado, porque se agregan algunas funciones para el script.
El archivo nut, cuyo nombre es coop por defecto, se utiliza en el modo campaña.
Renombrado a realismo o versus por realismo o confrontación. Baidu modifica el nombre del modo de juego. Pero de uso común es el realismo cooperativo.
Este script puede controlar la actualización y el número de sentidos especiales y zombis ordinarios, y puede ajustar la dificultad de los modos de defensa como los carroñeros.

Establezca todos los parámetros de control en el archivo de configuración config.

a para dejar caer accesorios.
8. Desbloquear armas cs, modificar el daño oculto de armas cs
9. Comienza el rescate del capítulo final, cambia automáticamente de campaña y aparece el mensaje
10. Reemplazo de medicamentos, servicio de medicamentos, reemplazo de armas, solo armas t1
11. Controle si la bruja puede atrapar puertas ordinarias [a partir de las características de una bruja realista]
12. Agregue algunos parámetros y funciones de control del director fino, como el número de veces que se cae al suelo para un modo de vida. Si hay zombis ordinarios proviene del sentimiento especial expreso. Ya sea para excluir bots para el modo de un jugador. Marea de cadáveres infinita, etc.

Highlights:
The brush feature under the control of the director, the game defaults to 3 features, and 3 features are pre-stored
If the number of special sensations is less than 3, then these 3 special sensations will be brushed out continuously until the brushing is completed.
Example: If set to 1 special. Although the map can only accommodate one special sense, this one will fill up the other one immediately after death, until the three special senses are finished. After that, enter the refresh time delay, like 45 seconds of resurrection time.

If the number of special sensations is greater than or equal to 3, then all special sensations will be divided into front and back at once. For example, there are 8 specials in desperate survival, 8 before and after.

update

disable:
function Notifications::OnZombieDeath::ZombieDeath(victim, attacker, params)

update
Fix C6M1 ED_Alloc: no free edicts when the special feeling is greater than 8
update
Fixed the problem that the same name stays in the ranking hud after removing the bot. Problems with the new version.
Added single-player mode, the number of times of falling to the ground, self-rescue settings, allowing players to set self-rescue in single-player mode
Add blood back to restore spare bullets switch AllowRegained
Add item drop switch AllowLoot
Add whether to start the game directly to the main weapon and melee. Close combat is also controlled by UnlockMelee and its diversity.
Adding the Bleed Out mode control switch BleedOut did not control the fallen zombies, nor did the original mode do this work. So c6. Fallen zombies may drop medicine packs
Adding the Bleeding mode does not go out and does not bleed code, it is not necessary to turn on the Bleeding mode to be effective. If there is a player with blood deficiency, start the game, if no one leaves the safe area, it will not start to reduce blood deficiency
Add the native code of ShouldAvoidItem director. Prevent computer players from picking up small pistols. Especially the ellis sniper plus small pistol was hammered into cerebral palsy by the zombie
Reworked infinite corpse tide mode, better infinite corpse tide
Added the corpse tide time and quantity control parameters Mob_Time and Mob_Size and the corpse tide reserved zombies Mob_MaxPend
Fixed the problem that setting m_nUpgradedPrimaryAmmoLoaded again outside of the conditions of VSLib::Entity::SetUpgrades( upgrades) caused the main weapon bullet to be set incorrectly
Added unlimited primary and secondary weapon bullets.
Add some refueling final chapters, the amount of refueling required. The number of NumCansNeeded settings is greater than the official default value, and the actual need to turn on the organ is still the official setting. Only less than the official can bypass the official script logic.
Corrected the tank HP number is too large to display scientific notation 4e+006

 6 special features still appear once ED_Alloc: no free edicts
No-load restart increase 36 logic_auto

update 9.1
Improve the tank health bar code, fix the problem that some plug-ins modify the tank’s maximum health in the middle and cause the display to be abnormal
After perfecting the MissionLost event, delay execution of the cleanup code. Lest the cleaning is too sudden, and it feels abrupt.
Improve the refueling chapter to reduce the number of times. At the same time, adjust the number of fuel tanks randomly, and make the greatest cooperation with some tripartite graphs.
update 9.2
Add automatic adjustment mode.
update 9.3
Fix duplicate witch kill statistics. Red letters appear when the computer is killed AN ERROR HAS OCCURED [the index '4' does not exist]
Cancel the corpse tide time control. Reserved for infinite tide of corpses. Only keep the number of corpses

*/

