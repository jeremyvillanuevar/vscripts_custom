//Title: The Alternate Difficulties Mod (TADM)
//Author Steam Alias: jetSetWilly II
//Author URL: https://steamcommunity.com/id/jetsetwillyuncensored/
//Version: 2.5
//Programming Language: VScript
//File Description: This is a data file that initialises most of the global variables used by TADM

::initializeAllFrameworkGlobalVariables <- function()
{
	::__COOP_VERSION__ <- 9.3;
	::nowActivateBalance <- 1
	/// Mostrar muertes de jugadores ///// Por razones de exhibición, solo se muestran los cuatro primeros
	///////////////////////////////////显示玩家击杀/////因为显示原因所以只显示前四名///////////////////////////
	// Interruptor de visualización de clasificación
	::Show_Player_Rank<-true;                            //排行显示开关
	::Show_Player_Hud<-true;                            //排行显示开关
	// Si se permite la visualización de estadísticas de muerte de la computadora. Dado que el reproductor puede sobrescribir el índice de la computadora, las estadísticas de la computadora se borrarán después de que el jugador real muera y se vaya, o es posible que no se muestren directamente.
	::AllowShowBotSurvivor <- false;                 //是否允许显示电脑的击杀统计。由于电脑的index可能会被玩家覆盖，所以会出现真实玩家死亡离开后电脑统计被清空，或者直接不显示的情况
	// Efecto de trofeo de disparo a la cabeza//爆頭獎杯效果
	// 1: On 0: Off El efecto que se muestra en la cabeza del jugador después de matar el tiro a la cabeza
	::headshotcup<- 0;          //1：開啓 0：關閉  擊殺爆頭特感后顯示在玩家頭上的效果
	::tankcup<- 1;          //1：開啓 0：關閉  擊殺爆頭特感后顯示在玩家頭上的效果
	//SessionState now
	::nowNumCansNeeded <- 0
	::nowPlayersIntensity <- 0
	::nowPlayersTimeAveragedIntensity <- 0
	::nowPlayersinGame <- 0
	::nowFinaleStarted <- 0
	::nowCrescendoStarted <- 0
	::nowFinaleScavengeStarted <- 0
	::nowFinaleGauntletStarted <- 0
	::nowFinaleStageNum <- 0
	::nowFinaleStageType <- 0
	::nowFinaleStageEvent <- 0
	::nowFirstPlayerinGame <- 0
	::nowSpawnedTankRusher <- 0
	::nowSpawnedWitch <- 0
	::nowStartConnectionsnum <- 0
	::nowStartConnections <-  []
	::nowPlayerEvent <- ""
	::nowPlayerJoined <- ""
	::nowPlayerLeft <- ""
	::nowMatchEnded <- 0
	//ShowPlayerState now
	::PlayerKillCout <- {}; 
	::PlayerRandCout <- {}; 
	::PlayerRankLine <- {}; 
	
	for(local i=0;i < 32;i++)
	{
		PlayerRankLine[i] <- "";
		
	}
	::KillsCout <- 0;
	::removed_common_spawns <- false;
	::ClearEdicts<- false;
	::Time4Connections <- 54;
	::Time4TimerWitch <- 60;
	::Time4TimerRusher <- 0;
	::Time4Tick <- 0;
	::TimeTick4Rescue <- 0;
	::TimeTick4ConnectMsg <- 0;
	::TimeTick4BossMsg <- 0;
	::TimeTick4WitchMsg <- 0;
	::TimeTick4PanicMsg <- 0;
	::TimeTick4HealMsg<- 0;
	::TimeTick4BossDefeatedMsg<- 0;
	::nowPlayerHealer <- ""
	::nowPlayerHealed <- ""
	::Survivors_Count <- 0;
	::GameDifficulty <- 0;
	
	
	
	
	
	
	::author <- "jetSetWilly II"
	::versionOfMod <- "2.5"
	::titleOfMod <- "The Alternate Difficulties Mod"

	//no Counterstrike weapons by map
	::noCSWeps <- 0

	
	//mapHadOxygenTanks
	::mHOT <- 0

	//modelForSpawning
	::mFS <- 0
	
	//spawningEntityAngle
	::sEA <- 0
	
	//particleSpawnOriginVector
	::pSOV <- 0
	
	//gameModeVariable
	::gMV <- 0

	//common radial search used mostly for finding entities within 200 distance
	::cRSA <- 200.0

	//plantation on shutdown mounted gun deletion variable
	::plantationMountedNoDeleteGun <- 0

	//uses to keep track of a map reset
	::shutdownCheck <- 0

	//Used to check if a map has the gascan game, is give the value equal to the amount of can in the game so it can also be used in the gascan randomizer
	::whichMapHasCanGames <- 0

	//Used to stop the end game message from repeating
	::alreadyPlayed <- 0

	//some minifinales bug out if you have too many director options set so on maps where this occurs this variable flags down those settings
	::miniFinalDirectorNoSet <- 0

	//used to determine is the current map is a finale with waves. This is needed because the multitank randomizer is set not to spawn tanks if a specific distance of the map isn't covered first, this gets around that specific situation where the multitank shock does not activate in finales
	::isAFinale <- 0
	
	//map related table
	::mapRelatedTable <- 0

	//used to stop constant friction settings from being set when they have already been set. constant setting of friction can cause a bit of jittering when shooting and moving
	::playerIsFiring <- 0
	::playerIsNotFiring <- 0

	//counted function executions, used for console message outputs only. Keeps track of timed function iterations.
	::timedFunctionExecutions <- 0
	::timedDifficultyFunctionExecutions <- 0
	::timedProgressUpdateCounter <- 0

	//used for ugly sister champion packs, playerBoomerSpawnLocation
	::numberOfBoomers <- 0
	::pBSL <- 0
	::championTime <- 0
	::lastSister <- 0

	//determines which physics entities can be changed on which maps. since each map can set the same physics models differently there needs to be flags for exceptions and special cases
	::physicsMapTarget_001 <- 0
	::selectVector <- 0

	//mapStructureTypeToDifficulty, mSTTD Max & Min (for randomizers), mAAN = maptype as a name, map is night or dark
	::mSTTD <- 0
	::mSTTDMA <- 0
	::mSTTDMI <- 0
	::mAAN <- "open"
	::mINOD <- 0
	//Area on the Map is for Small Fights
	::mASMOL <- "small"

	//tOD means tier of difficulty, tOD MAx & MIn (for randomizers), tOD Non-Randomized
	::tOD <- 0
	::tODMA <- 0
	::tODMI <- 0
	::tODNR <- 0

	//difficulty as a number (1 to 4), dAAN Max & Min (for randomizers), dAANNR is dAAN Non Randomized, difficulty as a word
	::dAAN <- 0
	::dAAW <- 0
	::dAANMA <- 0
	::dAANMI <- 0
	::dAANNR <- 0

	//previous tank stagger location
	::pTSL <- 0

	//type of alter specials or bosses, AMM & AMI for alter monster randomisers ranges max & mins, aMR,G,B for the 3 colors, aMN for non randomisers
	::alterMonster <- 0
	::aMA <- 0
	::aMI <- 0
	::aMR <- 0
	::aMG <- 0
	::aMB <- 0
	::aMN <- 0

	//assigned variable for gamemodes and average flow distance
	::gFD <- 0
	::aPPPTM <- 0

	//player friction controller (timer lookup per player(8 players 8 items)), player
	::pFC			<-	[0,0,0,0,0,0,0,0]
	::pWC			<-	[0,0,0,0,0,0,0,0]
	::ppWC			<-	[0,0,0,0,0,0,0,0]
	::aPWSA			<-	[0,0,0,0,0,0,0,0]

	//player position to tank rock
	::pPTTR			<-	[0,0,0,0,0,0,0,0]

	//players weapon friction value (used for defaulting weapon types)
	::pWFA			<-	[1,1,1,1,1,1,1,1]
	::oldFriction	<-	[0,0,0,0,0,0,0,0]

	//uglySister spawn flags, randomiser controllers and presets
	::numSisters	<-	0
	::sisterSpawn	<-	0
	::maxCount		<-	0
	::championTime	<-	0

	//multi-tank flags used to control number of tank spawns and identify which tank is which
	::multiTankCreation		<- 0
	::xtroTanks <- 0
	::tankCounter <- [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	::sTG <- 0
	::tankWasSpawnedFromSpecial <- 0
	::tankConcurrencyCheck <- [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

	//search vectors
	::mapSearchLocation <- Vector(0,0,0)

	//Broken mounted guns
	::brokenGunCounter <- "noGun"	
	
	
	
	
	Msg("Executed: initializeAllTADMGlobalVariables function\n");
}


//FromTables
//theAlternateDifficultiesModInstallationTable
::tADMIT <-
{
	scavengegascanspawner	=	[""]
	gascan					=	["models/props_junk/gascan001a.mdl"]
	pot_clay				=	["models/props_foliage/urban_pot_clay01.mdl"]
	bin						=	["models/props_street/trashbin01.mdl"]
	bin_a					=	["models/props_junk/trashbin01a.mdl"]
	barstool				=	["models/props_furniture/cafe_barstool1.mdl"]
	peanut					=	["models/props_fairgrounds/Lil'Peanut_cutout001.mdl"]
	pallet					=	["models/props_junk/wood_pallet001a.mdl"]
	cart					=	["models/props_urban/shopping_cart001.mdl"]
	oxy						=	["models/props_equipment/oxygentank01.mdl"]
	basin					=	["models/props_urban/plastic_basin001.mdl"]
	oil						=	["models/props_c17/oildrum001.mdl"]
	ice						=	["models/props_urban/plastic_icechest_lid001.mdl"]
	pot						=	["models/props_foliage/urban_pot_large01.mdl"]
	can						=	["models/props_street/garbage_can.mdl"]
	pchair					=	["models/props_urban/plastic_chair001.mdl"]
	pbottle					=	["models/props_junk/garbage_plasticbottle001a_fullsheet.mdl"]
	pjug					=	["models/props_urban/plastic_water_jug001.mdl"]
	haybale					=	["models/props_normandy/haybale.mdl"]
	haybails				=	["models/props/de_inferno/hay_bails.mdl"]
	largeSmoke				=	["smoke_large_02"]
	riverSmoke				=	["fire_riverboat_smoke"]
	leaves					=	["leaves_green"]
	lowSmoke				=	["fire_chopper_lowsmoke"]
	roach					=	["roaches_lot"]
	chainsawSmoke			=	["weapon_chainsaw_smoke_tp"]
	exhaust01				=	["smoke_exhaust_01"]
	skySmoke01				=	["skybox_smoke_01"]
	fogVol_1024_512			=	["fog_volume_1024_512"]
	steamDoorway			=	["steam_doorway"]
	bloodstain003			=	["decals/bloodstain_003"]
	trash04					=	["decals/trashdecal04a"]
	leavesDecal				=	["decals/leaves02"]
	leavesGroundDecal		=	["decals/leaves_ground02"]
	cementStain				=	["de_train/train_cement_stain_01"]
	garbagePile01			=	["models/props_fairgrounds/garbage_pile01.mdl"]
	garbagePile02			=	["models/props_fairgrounds/garbage_pile02.mdl"]
	food03					=	["models/props_junk/food_pile03.mdl"]
	bushAngled128			=	["models/props_foliage/urban_bush_angled_128.mdl"]
	garb256_001b			=	["models/props_junk/garbage256_composite001b.mdl"]
}

//easyFinalesRandomizerForGenericFinalesTable
::eFRFGFT	<-
{
	A_CustomFinaleValue1 	= [1,2,1,1,4,5]
	A_CustomFinaleValue2 	= [1,1,1,1,5,6]
	A_CustomFinaleValue3 	= [1,1,1,1,5,5]
	A_CustomFinaleValue4 	= [1,1,1,1,5,7]
	A_CustomFinaleValue5 	= [1,1,1,1,4,5]
	A_CustomFinaleValue6 	= [1,1,1,1,4,5]
	A_CustomFinaleValue7 	= [1,1,1,1,4,5]
}

//easyFinalesStagesRandomizerTable
::eFSRT	<-
{
	A_CustomFinale1 		= [0,0,0,0,0]
	A_CustomFinale2 		= [0,2,2,2,2]
	A_CustomFinale3 		= [1,1,1,1,1]
	A_CustomFinale4 		= [0,0,0,0,2]
	A_CustomFinale5 		= [0,0,0,0,0]
	A_CustomFinale6 		= [2,2,2,2,2]
	A_CustomFinale7 		= [1,1,1,1,1]
}

//normalFinalesRandomizerForGenericFinalesTable	
::nFRFGFT	<-
{	 
	A_CustomFinaleValue1 	= [1,1,1,2,4,5]
	A_CustomFinaleValue2 	= [1,2,1,1,3,4]
	A_CustomFinaleValue3 	= [1,2,1,1,4,5]
	A_CustomFinaleValue4 	= [1,1,1,1,3,6]
	A_CustomFinaleValue5 	= [1,1,1,1,4,5]
	A_CustomFinaleValue6 	= [1,3,1,1,2,3]
	A_CustomFinaleValue7 	= [1,3,1,1,4,5]
}

//normalFinalesStagesRandomizerTable
::nFSRT	<-
{
	A_CustomFinale1 		= [0,0,0,0,1]
	A_CustomFinale2 		= [2,2,2,2,2]
	A_CustomFinale3 		= [0,0,1,1,1]
	A_CustomFinale4 		= [0,0,0,0,2]
	A_CustomFinale5 		= [0,0,0,1,1]
	A_CustomFinale6 		= [0,0,2,2,2]
	A_CustomFinale7 		= [0,1,1,1,1]
}

//advancedFinalesRandomizerForGenericFinalesTable	
::aFRFGFT	<-
{
	A_CustomFinaleValue1 	= [1,1,1,2,3,7]
	A_CustomFinaleValue2 	= [1,1,1,1,3,7]
	A_CustomFinaleValue3 	= [1,1,1,1,3,7]
	A_CustomFinaleValue4 	= [1,1,1,1,3,5]
	A_CustomFinaleValue5 	= [1,2,1,1,3,7]
	A_CustomFinaleValue6 	= [1,3,1,2,3,4]
	A_CustomFinaleValue7 	= [1,3,1,1,3,7]
}

//advancedFinalesStagesRandomizerTable
::aFSRT	<-
{
	A_CustomFinale1 		= [0,0,0,0,1]
	A_CustomFinale2 		= [0,0,0,1,2]
	A_CustomFinale3 		= [0,0,0,1,1]
	A_CustomFinale4 		= [0,0,0,2,2]
	A_CustomFinale5 		= [0,0,1,1,1]
	A_CustomFinale6 		= [0,1,2,2,2]
	A_CustomFinale7 		= [0,1,1,1,1]
}	

//impossibleFinalesRandomizerForGenericFinalesTable	
::iFRFGFT	<-
{
	A_CustomFinaleValue1 	= [1,1,1,2,3,7]
	A_CustomFinaleValue2 	= [1,2,1,1,3,7]
	A_CustomFinaleValue3 	= [1,3,1,1,3,7]
	A_CustomFinaleValue4 	= [1,1,1,1,2,6]
	A_CustomFinaleValue5 	= [1,1,1,2,2,7]
	A_CustomFinaleValue6 	= [1,2,1,2,3,7]
	A_CustomFinaleValue7 	= [1,3,1,1,3,7]
}

//impossibleFinalesStagesRandomizerTable
::iFSRT	<-
{
	A_CustomFinale1 		= [0,0,0,0,1]
	A_CustomFinale2 		= [0,0,0,1,2]
	A_CustomFinale3 		= [0,1,1,1,1]
	A_CustomFinale4 		= [0,0,1,1,2]
	A_CustomFinale5 		= [0,0,0,0,1]
	A_CustomFinale6 		= [0,0,0,1,2]
	A_CustomFinale7 		= [0,1,1,1,1]
}

//genericFinalesKeyRandomizerDirectorOptionsOrderManagerTable
::gFKRDOOMT	<-
{
	A_CustomFinale1 		= 0
	A_CustomFinale2 		= 0
	A_CustomFinale3 		= 0
	A_CustomFinale4 		= 0
	A_CustomFinale5 		= 0
	A_CustomFinale6 		= 0
	A_CustomFinale7 		= 0
}

//genericFinalesKeyRandomizerDirectorOptionsCoordinatorManagerTable
::gFKRDOCMT	<-
{
	A_CustomFinaleValue1 	= "A_CustomFinale1"
	A_CustomFinaleValue2	= "A_CustomFinale2"
	A_CustomFinaleValue3	= "A_CustomFinale3"
	A_CustomFinaleValue4	= "A_CustomFinale4"
	A_CustomFinaleValue5	= "A_CustomFinale5"
	A_CustomFinaleValue6	= "A_CustomFinale6"
	A_CustomFinaleValue7	= "A_CustomFinale7"
}

//genericFinalesRandomizerControlTable
::gFRCT <-
{
	easy		=	[eFSRT,eFRFGFT]
	normal		=	[nFSRT,nFRFGFT]
	hard		=	[aFSRT,aFRFGFT]
	impossible	=	[iFSRT,iFRFGFT]
}

//minigunCleanUpByMapnameFinaleTable
::mCUBMFT <-
{
	c8m5_rooftop			=	[6222,8020,6102]
	c9m2_lots				=	[8269,6736,214]
	c10m5_houseboat			=	[4114,-4065,-130]
	c11m5_runway			=	[-4583,9837,-106]
}

//initializeTierOfDifficultyTable
::iTODT <-
{
	easy		=	[1,1]
	normal		=	[2,2,3]
	hard		=	[3,4,5,6]
	impossible	=	[4,7,8,9,10]
}

//establishedMapTypeVariablesTable
//mAAN, mINOD, physicsMapTarget, miniFinalDirectorNoSet, whichMapHasCanGames, isAFinale, noCSWeps,mSMOL
::eMTVT <-
{
	c1m1_hotel				=	["clsd",0,0,0,00,0,0.25,"small"]
	c1m2_streets			=	["clsd",0,0,0,00,0,0,"small"]
	c1m3_mall				=	["clsd",0,0,0,00,0,0.25,"large"]
	c1m4_atrium				=	["clsd",0,0,0,14,1,0.25,"large"]
	c2m1_highway			=	["open",1,0,0,00,0,0.25,"large"]
	c2m2_fairgrounds		=	["open",1,1,0,00,0,0.25,"large"]
	c2m3_coaster			=	["clsd",1,0,0,00,0,0.25,"large"]
	c2m4_barns				=	["clsd",1,0,1,00,0,0.25,"large"]
	c2m5_concert			=	["clsd",1,0,0,00,1,0.25,"large"]
	c3m1_plankcountry		=	["open",1,2,1,00,0,0.25,"large"]
	c3m2_swamp				=	["open",1,2,0,00,0,0.25,"large"]
	c3m3_shantytown			=	["open",1,2,0,00,0,0.25,"large"]
	c3m4_plantation			=	["clsd",0,2,5,00,1,0,"large"]
	c4m1_milltown_a			=	["open",0,0,0,00,0,0.25,"large"]
	c4m2_sugarmill_a		=	["open",1,0,0,00,0,0.25,"large"]
	c4m3_sugarmill_b		=	["open",1,0,0,00,0,0.25,"large"]
	c4m4_milltown_b			=	["open",1,0,0,00,0,0.25,"large"]
	c4m5_milltown_escape	=	["clsd",1,0,0,00,1,0.25,"large"]
	c5m1_waterfront			=	["clsd",0,0,0,00,0,0.25,"small"]
	c5m2_park				=	["open",0,0,0,00,0,0.25,"large"]
	c5m3_cemetery			=	["open",0,3,0,00,0,0.25,"large"]
	c5m4_quarter			=	["clsd",0,3,0,00,0,0.25,"small"]
	c5m5_bridge				=	["clsd",0,0,0,00,0,0.25,"large"]
	c6m1_riverbank			=	["clsd",1,2,0,00,0,0.25,"small"]
	c6m2_bedlam				=	["clsd",1,0,0,00,0,0.25,"small"]
	c6m3_port				=	["clsd",1,0,1,17,1,0.25,"small"]
	c7m1_docks				=	["clsd",0,0,0,00,0,0.25,"small"]
	c7m2_barge				=	["open",0,0,0,00,0,0.25,"large"]
	c7m3_port				=	["clsd",0,0,0,00,1,0.25,"large"]
	c8m1_apartment			=	["clsd",1,0,0,00,0,0.25,"medium"]
	c8m2_subway				=	["clsd",1,0,0,00,0,0.25,"medium"]
	c8m3_sewers				=	["clsd",1,0,0,00,0,0.25,"medium"]
	c8m4_interior			=	["clsd",1,0,0,00,0,0.25,"medium"]
	c8m5_rooftop			=	["clsd",1,0,0,00,1,0.25,"large"]
	c9m1_alleys				=	["open",1,0,1,00,0,0.25,"large"]
	c9m2_lots				=	["clsd",1,0,0,00,0,0.25,"large"]
	c10m1_caves				=	["clsd",1,0,0,00,0,0.25,"small"]
	c10m2_drainage			=	["clsd",1,0,0,00,0,0.25,"small"]
	c10m3_ranchhouse		=	["open",1,0,1,00,0,0.25,"large"]
	c10m4_mainstreet		=	["open",1,0,0,00,0,0.25,"large"]
	c10m5_houseboat			=	["clsd",1,0,0,00,1,0.25,"large"]
	c11m1_greenhouse		=	["clsd",1,0,0,00,0,0.25,"large"]
	c11m2_offices			=	["clsd",1,0,0,00,0,0.25,"large"]
	c11m3_garage			=	["clsd",1,0,0,00,0,0.25,"large"]
	c11m4_terminal			=	["clsd",1,0,0,00,0,0.25,"large"]
	c11m5_runway			=	["clsd",1,0,0,00,1,0.25,"large"]
	c12m1_hilltop			=	["clsd",1,0,0,00,0,0.25,"large"]
	c12m2_traintunnel		=	["clsd",1,0,0,00,0,0.25,"large"]
	c12m3_bridge			=	["clsd",1,0,0,00,0,0.25,"large"]
	c12m4_barn				=	["clsd",1,0,0,00,0,0.25,"large"]
	c12m5_cornfield			=	["open",1,0,0,00,1,0.25,"large"]
	c13m1_alpinecreek		=	["open",1,0,0,00,1,0.25,"large"]
	c13m2_southpinestream	=	["open",1,0,0,00,0,0.25,"large"]
	c13m3_memorialbridge	=	["open",1,0,0,00,0,0.25,"large"]
	c13m4_cutthroatcreek	=	["open",1,0,0,00,0,0.25,"large"]
	c14m1_junkyard			=	["open",0,0,0,00,0,0.25,"large"]
	c14m2_lighthouse		=	["open",0,0,0,00,1,0.25,"large"]	
}

//--------------------------------------------------------------tank tables
//zTankHealthTable											1)4200	2)4100	3)4050	was 4000
::zTHT <-
{
	easy		=	[4350,4450,4150,4450,4150,4300]
	normal		=	[4250,4350,4050,4350,4050,4200]
	hard		=	[4150,4250,3950,4250,3950,4100]
	impossible	=	[4050,4150,3850,4150,3850,4000]
}


//					1)hulk	2)alter	3)formidable
//zTankSpeedTable, was 210
::zTST <-
{
	easy		=	[210,220,210,230,215,230]
	normal		=	[215,225,215,235,220,235]
	hard		=	[220,230,220,240,225,240]
	impossible	=	[225,235,225,245,230,245]
}

//zTankMaxStaggerDIstanceTable, Max distance a Tank staggers when hurt by a grenade, was 400
::zTMSDIT <-
{
	easy		=	[340,390,290,390,290,340]
	normal		=	[335,385,285,385,285,335]
	hard		=	[330,380,280,380,280,330]
	impossible	=	[325,375,275,375,275,325]
}

//zTankMaxStaggerDUrationTable, Max time a Tank staggers when hit by a grenade, was 6
::zTMSDUT <-
{
	easy		=	[4,4,4,6,5,6]
	normal		=	[3,4,3,5,5,5]
	hard		=	[3,3,3,5,5,5]
	impossible	=	[2,3,2,5,4,5]
}

//--------------------------------------------------------------jockey tables

//zJockeyHealthTable, was 325
::zJHT <-
{
	easy		=	[395,405,335,345,310,340]
	normal		=	[405,415,345,355,320,350]
	hard		=	[415,425,355,365,330,360]
	impossible	=	[425,435,365,375,340,370]
}

//zJockeyLeapMaxDistanceTable, was 200
::zJLMDT <-
{
	easy		=	[180,190,270,370,150,270]
	normal		=	[185,195,280,380,155,280]
	hard		=	[190,200,290,390,160,290]
	impossible	=	[195,205,300,400,165,300]
}

//zJockeySpeedTable, was 250
::zJST <-
{
	easy		=	[235,245,250,270,240,260]
	normal		=	[240,250,255,275,245,265]
	hard		=	[245,255,260,280,250,270]
	impossible	=	[250,260,265,285,255,275]
}

//zJockeyLeapAgainTimerTable, was 5, after successful leap
::zJLATT <-
{
	easy		=	[4,4,8,11,4,11]
	normal		=	[3,4,8,10,3,10]
	hard		=	[3,3,7,10,3,10]
	impossible	=	[2,3,7,9,2,9]
}

//zLeapForceAttachDistanceTable, was 40
::zLFADT <-
{
	easy		=	[30,34,24,34,24,26]
	normal		=	[32,36,26,36,26,30]
	hard		=	[34,38,28,38,28,32]
	impossible	=	[36,40,36,40,30,34]
}

//zJockeyLeapTimeTable, was 1, after unsuccessful leap
::zJLTT <-
{
	easy		=	[1,2,3,4,1,6]
	normal		=	[1,2,3,3,1,5]
	hard		=	[1,1,2,3,1,4]
	impossible	=	[1,1,2,2,1,3]
}

//jockeyPounceAirSpeedTable, was 700
::jPAST <-
{
	easy		=	[625,675,600,650,580,620]
	normal		=	[630,680,605,655,585,625]
	hard		=	[635,685,610,660,590,630]
	impossible	=	[640,690,615,665,595,635]
}

//zLeapAttachDistanceTable, was 60
::zLADT <-
{
	easy		=	[30,35,15,25,15,35]
	normal		=	[35,40,20,30,20,40]
	hard		=	[40,45,25,35,25,45]
	impossible	=	[45,50,30,40,30,50]
}

//zJockeyControlVarianceTable, was 0.7
::zJCVT <-
{
	easy		=	[0.74,0.77,0.17,0.27,0.17,0.77]
	normal		=	[0.77,0.80,0.18,0.28,0.18,0.81]
	hard		=	[0.80,0.83,0.19,0.29,0.19,0.84]
	impossible	=	[0.83,0.87,0.2,0.3,0.2,0.87]
}

//zJockeyControlMInTable, was 0.8
::zJCMIT <-
{
	easy		=	[0.81,0.19,0.19]
	normal		=	[0.82,0.20,0.20]
	hard		=	[0.83,0.21,0.21]
	impossible	=	[0.84,0.22,0.22]
}

//zJockeyControlMAxTable, was 0.8
::zJCMAT <-
{
	easy		=	[0.96,0.30,0.91]
	normal		=	[0.97,0.31,0.92]
	hard		=	[0.98,0.32,0.93]
	impossible	=	[0.99,0.33,0.94]
}

//zJockeyRideDamageTable, was 4
::zJRDT <-
{
	easy		=	[1,1,2,2,1,2]
	normal		=	[1,1,2,3,1,3]
	hard		=	[1,1,2,3,1,3]
	impossible	=	[1,1,2,3,1,3]
}

//zJockeyRideDamageIntervalTable, was 1
::zJRDIT <-
{
	easy		=	[0.9,0.9,0.6,0.6,0.5,0.9]
	normal		=	[0.8,0.9,0.5,0.6,0.4,0.9]
	hard		=	[0.7,0.9,0.4,0.6,0.3,0.9]
	impossible	=	[0.6,0.8,0.3,0.6,0.3,0.8]
}

//--------------------------------------------------------------spitter tables

//zSPItterSpeedTable, was 210
::zSPIST <-
{
	easy		=	[208,212,218,222,208,220]
	normal		=	[210,212,220,222,210,220]
	hard		=	[210,214,220,224,212,220]
	impossible	=	[212,214,222,224,214,220]
}

//zSPItterRangeTable, was 900
::zSPIRT <-
{
	easy		=	[1000,1100,875,925,600,750]
	normal		=	[1010,1110,885,935,610,760]
	hard		=	[1020,1120,895,945,620,770]
	impossible	=	[1030,1130,905,955,630,780]
}

//zSpitterMaxWaitTimeTable, was 30
::zSMWTT <-
{
	easy		=	[8,12,25,30,5,7]
	normal		=	[8,11,23,28,5,6]
	hard		=	[7,10,21,26,4,6]
	impossible	=	[7,9,19,24,4,5]
}

//zSpitVelocityTable, was 900
::zSVT <-
{
	easy		=	[950,1000,890,900,780,800]
	normal		=	[960,1010,900,910,790,810]
	hard		=	[970,1020,910,920,800,820]
	impossible	=	[980,1030,920,930,810,830]
}

//zSpitSpreadDelayTable, was 0.2
::zSSDT <-
{
	easy		=	[0.6,0.8,0.8,1.6,0.4,1.5]
	normal		=	[0.6,0.7,0.9,1.6,0.3,1.6]
	hard		=	[0.5,0.7,0.9,1.7,0.2,1.7]
	impossible	=	[0.5,0.6,1.0,1.7,0.1,1.8]
}

//zSpitDetonateDelayTable, was 0.1
::zSDDT <-
{
	easy		=	[0.25,0.75,0.9,1.5,0.4,1.5]
	normal		=	[0.23,0.71,1.0,1.6,0.3,1.6]
	hard		=	[0.21,0.67,1.1,1.7,0.2,1.7]
	impossible	=	[0.19,0.63,1.2,1.8,0.1,1.8]
}

//zSpitterHealthTable, was 100
::zSHT <-
{
	easy		=	[110,130,150,185,100,200]
	normal		=	[120,140,160,195,110,210]
	hard		=	[130,140,170,205,120,220]
	impossible	=	[140,150,180,215,130,230]
}

//zSpitLatencyTable, was 0.3
::zSLT <-
{
	easy		=	[0.2,0.5,0.7,0.9,0.4,0.9]
	normal		=	[0.2,0.4,0.6,0.8,0.3,0.8]
	hard		=	[0.1,0.4,0.5,0.8,0.2,0.7]
	impossible	=	[0.1,0.3,0.4,0.7,0.1,0.6]
}

//--------------------------------------------------------------weapon and throwables tables

//zGunSwingIntervalTable
::zGSIT <-
{
	easy		=	[0.66,0.67,0.68,0.69,0.7]
	normal		=	[0.67,0.68,0.69,0.7,0.71]
	hard		=	[0.68,0.69,0.7,0.71,0.72]
	impossible	=	[0.69,0.7,0.71,0.72,0.73]
}

//zGunSwingDurationTable
::zGSWDT <-
{
	easy		=	[0.19,0.19,0.19,0.19,0.2]
	normal		=	[0.18,0.18,0.18,0.19,0.2]
	hard		=	[0.17,0.17,0.18,0.19,0.2]
	impossible	=	[0.16,0.17,0.18,0.19,0.2]
}

//findWeaponIndexTable
::fWIT <-
{
	weapon_pistol_magnum	=	[1.000,1.251,1.006,1.565,1.011,1.957,1.017,2.449]
	weapon_pistol			=	[1.000,1.005,1.003,1.010,1.005,1.015,1.007,1.020]
	weapon_smg_silenced		=	[1.000,1.091,1.025,1.190,1.050,1.298,1.076,1.416]
	weapon_smg				=	[1.000,1.093,1.024,1.194,1.048,1.305,1.073,1.427]
	weapon_smg_mp5			=	[1.000,1.095,1.027,1.199,1.054,1.312,1.083,1.437]
	weapon_pumpshotgun		=	[1.000,1.111,1.016,1.234,1.032,1.371,1.048,1.523]
	weapon_shotgun_chrome	=	[1.000,1.221,1.016,1.490,1.032,1.820,1.048,2.222]
	weapon_shotgun_spas		=	[1.000,1.221,1.041,1.490,1.083,1.820,1.128,2.222]
	weapon_autoshotgun		=	[1.000,1.219,1.023,1.485,1.046,1.811,1.070,2.208]
	weapon_rifle			=	[1.000,1.159,1.041,1.343,1.083,1.556,1.128,1.804]
	weapon_rifle_desert		=	[1.000,1.141,1.041,1.301,1.083,1.485,1.128,1.694]
	weapon_rifle_sg552		=	[1.000,1.146,1.041,1.313,1.083,1.505,1.128,1.724]
	weapon_rifle_ak47		=	[1.000,1.174,1.041,1.378,1.083,1.618,1.128,1.899]
	weapon_sniper_military	=	[1.000,1.129,1.032,1.274,1.065,1.439,1.099,1.624]
	weapon_sniper_awp		=	[1.000,1.262,1.019,1.592,1.038,2.009,1.058,2.536]
	weapon_hunting_rifle	=	[1.000,1.111,1.012,1.234,1.024,1.371,1.036,1.523]
	weapon_sniper_scout		=	[1.000,1.109,1.009,1.229,1.018,1.363,1.027,1.512]
	weapon_rifle_m60		=	[1.000,1.242,1.061,1.542,1.125,1.915,1.194,2.379]
	weapon_grenade_launcher	=	[1.000,1.285,1.049,1.651,1.100,2.121,1.154,2.726]
	weapon_chainsaw			=	[1.000,1.219,1.056,1.485,1.115,1.811,1.177,2.208]
	weapon_pipe_bomb		=	[1.000,1.000,1.002,1.002,1.004,1.004,1.006,1.006]
	weapon_molotov			=	[1.000,1.000,1.002,1.002,1.004,1.004,1.006,1.006]
	weapon_vomitjar			=	[1.000,1.000,1.002,1.002,1.004,1.004,1.006,1.006]
}

//--------------------------------------------------------------survivor tables

local sRDCoopTable =
{
	easy		=	[3.7,3.8,3.9,4.0,4.0]
	normal		=	[3.6,3.7,3.8,3.9,4.0]
	hard		=	[3.5,3.6,3.7,3.8,3.9]
	impossible	=	[3.4,3.5,3.6,3.7,3.8]
}

local sRDNonCoopTable =
{
	easy		=	[5,5,5,5,5]
	normal		=	[5,5,5,5,5]
	hard		=	[5,5,5,5,5]
	impossible	=	[5,5,5,5,5]
}

//survivorReviveDurationTable
::sRDT <-
{
	coop		=	sRDCoopTable
	survival	=	sRDNonCoopTable
	versus		=	sRDNonCoopTable
	realism		=	sRDCoopTable
	scavenge	=	sRDNonCoopTable
	holdout		=	sRDNonCoopTable
}

local sLWSCoopTable =
{
	easy		=	[100,100,100,100,100]
	normal		=	[100,99,98,97,96]
	hard		=	[97,96,95,94,93]
	impossible	=	[94,93,92,91,90]
}

local sLWSNonCoopTable =
{
	easy		=	[95,94,93,92,91]
	normal		=	[95,94,93,92,91]
	hard		=	[95,94,93,92,91]
	impossible	=	[95,94,93,92,91]
}

//survivorLimpWalkSpeedTable
::sLWST <-
{
	coop		=	sLWSCoopTable
	survival	=	sLWSNonCoopTable
	versus		=	sLWSNonCoopTable
	realism		=	sLWSCoopTable
	scavenge	=	sLWSNonCoopTable
	holdout		=	sLWSNonCoopTable
}

local sLHCoopTable =
{
	easy		=	[20,21,22,23,24]
	normal		=	[22,23,24,25,26]
	hard		=	[24,25,26,27,28]
	impossible	=	[26,27,28,29,30]
}

local sLHNonCoopTable =
{
	easy		=	[40,40,40,40,40]
	normal		=	[40,40,40,40,40]
	hard		=	[40,40,40,40,40]
	impossible	=	[40,40,40,40,40]
}

//survivorLimpHealthModeTable
::sLHMT <-
{
	coop		=	sLHCoopTable
	survival	=	sLHNonCoopTable
	versus		=	sLHNonCoopTable
	realism		=	sLHCoopTable
	scavenge	=	sLHNonCoopTable
	holdout		=	sLHNonCoopTable
}

//survivorLedgeGrabHealthTable
::sLGHT <-
{
	easy		=	[310,300,290,280,270]
	normal		=	[300,290,280,270,260]
	hard		=	[290,280,270,260,250]
	impossible	=	[280,270,260,250,240]
}

local fAKUDCoopTable =
{
	easy		=	[4.6,4.7,4.8,4.9,5.0]
	normal		=	[4.4,4.5,4.6,4.7,4.8]
	hard		=	[4.2,4.3,4.4,4.5,4.6]
	impossible	=	[4.0,4.1,4.2,4.3,4.4]
}

local fAKUDNonCoopTable =
{
	easy		=	[5,5,5,5,5,5,5,5]
	normal		=	[5,5,5,5,5,5,5,5]
	hard		=	[5,5,5,5,5,5,5,5]
	impossible	=	[5,5,5,5,5,5,5,5]
}

//firstAidKitUseDurationGameModesTable
::fAKUDGMT <-
{
	coop		=	fAKUDCoopTable
	survival	=	fAKUDNonCoopTable
	versus		=	fAKUDNonCoopTable
	realism		=	fAKUDCoopTable
	scavenge	=	fAKUDNonCoopTable
	holdout		=	fAKUDNonCoopTable
}

//--------------------------------------------------------------common infected tables

//zWanderingDensityTable
::zWDT <-
{
	clsd	=	[0.045,0.055,0.055,0.065,0.054,0.064,0.065,0.075,0.064,0.074,0.063,0.073,0.075,0.085,0.074,0.084,0.073,0.083,0.072,0.082]	//1)0.05	3)0.06	3)0.07	4)0.08	t)-0.001
	open	=	[0.04,0.05,0.05,0.06,0.049,0.059,0.059,0.069,0.058,0.068,0.057,0.067,0.07,0.08,0.069,0.079,0.068,0.078,0.067,0.077]			//1)0.045	3)0.055	3)0.065	4)0.075	t)-0.001
}

//zSpawnSpeedTable
::zSST <-
{
	clsd	=	[800,850,825,925,875,925,925,975]			//1)825		2)875	3)925	4)950
	open	=	[450,550,550,650,600,700,650,750]			//1)500		2)600	3)650	4)700
}

//zSpawnFlowLimitTable
::zSFLT <-
{
	clsd	=	[1700,1800,1750,1850,1800,1900,1850,1950]	//1)1750	2)1800	3)1850	4)1900
	open	=	[1450,1550,1500,1600,1550,1650,1600,1700]	//1)1500	2)1550	3)1600	4)1650
}

//zNoticeNearRangeTable
::zNNRT <-
{
	clsd	=	[250,300,275,325,300,350,325,375]			//1)275		2)300	3)325	4)350
	open	=	[225,275,250,300,275,325,300,350]			//1)250		2)275	3)300	4)325
}

//zHearGunfireRangeTable
::zHGRT <-
{
	clsd	=	[400,600,425,625,450,650,475,675]			//1)500		2)525	3)550	4)600
	open	=	[425,475,450,500,475,525,500,550]			//1)450		2)475	3)500	4)525
}

//relaxMaxFlowTravelTable
::rMFTT <-
{
	clsd	=	[2000,2200,1900,2100,1800,2000,1700,1900]	//1)2100	2)2000	3)1900	4)1800
	open	=	[2100,2300,2000,2200,1900,2100,1800,2000]	//1)2200	2)2100	3)2000	4)1900
}

//farAcquireTimeTable
::fATT <-
{
	clsd	=	[4.0,5.0,3.5,4.5,3.0,4.0,2.5,3.5]			//1)4.5		2)4.0	3)3.5	4)3.0
	open	=	[3.0,4.0,2.5,3.5,2.0,3.0,1.5,2.5]			//1)3.5		2)3.0	3)2.5	4)2.0
}

//farAcquireRangeTable
::fART <-
{
	clsd	=	[1650,1750,1700,1800,1750,1850,1800,1900]	//1)1700	2)1750	3)1800	4)1850
	open	=	[1600,1700,1650,1750,1850,1800,1755,1850]	//1)1650	2)1700	3)1750	4)1800
}

//nearAcquireTimeTable
::nATT <-
{
	clsd	=	[0.6,0.7,0.5,0.6,0.4,0.6,0.4,0.5]			//1)0.65	2)0.55	3)0.5	4)0.45
	open	=	[0.4,0.5,0.35,0.45,0.3,0.4,0.25,0.35]		//1)0.45	2)0.4	3)0.35	4)0.3
}

//nearAcquireRangeTable
::nART <-
{
	clsd	=	[250,300,275,325,300,350,325,375]			//1)275		2)300	3)325	4)350
	open	=	[200,250,225,275,250,300,275,325]			//1)225		2)250	3)275	4)300
}

//zombieSpawnRangeTable
::zSRT <-
{
	clsd	=	[1825,2025,1800,2000,1850,1900,1825,1875]	//1)1925	2)1900	3)1875	4)1850
	open	=	[1825,1875,1800,1850,1775,1825,1750,1800]	//1)1850	2)1825	3)1800	4)1775
}

//numberOfReservedWanderersTable
::nORWT <-
{
	clsd	=	[14,14,14,16,15,16,15,17,16,17,16,18,16,18,16,19,17,19,17,20]	//1)14	2)15	3)16	4)17	t)+0.5
	open	=	[15,15,17,17,17,18,19,19,19,20,19,21,20,22,21,22,21,23,22,23]	//1)15	2)17	3)19	4)21	t)+0.5
}

//zMobPopulationDensityTable
::zMPDT <-
{
	clsd	=	[0.00028,0.00028,0.000275,0.00027]
	open	=	[0.00026,0.00026,0.000255,0.00025]
}

//--------------------------------------------------------------director tables

//directorSustainPeakMaxTimeTable
::dSPMATT <-
{
	clsd	=	[6,6,6,7,7,7,8,8,8,9,9,9,9,9,9,10,10,10,10,11]	//1)6	2)7		3)8		4)9		t)+0.5
	open	=	[5,6,6,6,6,7,7,8,8,8,8,9,8,9,9,9,9,10,10,10]	//1)5.5	2)6.5	3)7.5	4)8.5	t)+0.5
}

//directorSustainPeakMinTimeTable
::dSPMITT <-
{
	clsd	=	[3,3,4,4,4,5,5,5,5,6,6,6,6,6,6,7,7,7,7,8]		//1)3	2)4		3)5		4)6		t)+0.5
	open	=	[3,3,3,4,4,4,4,5,5,5,5,6,5,6,6,6,6,7,7,7]		//1)3	2)3.5	3)4.5	4)5.5	t)+0.5
}

Msg("Tables init \n");


Msg("Loaded: aVar.nut\n");