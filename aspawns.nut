//Title: The Alternate Difficulties Mod (TADM)
//Author Steam Alias: jetSetWilly II
//Author URL: https://steamcommunity.com/id/jetsetwillyuncensored/
//Version: 2.5
//Programming Language: VScript
//File Description: This is a data file that holds all of the spawn tables used by TADM


//function entities spawner function
::funcEntsSpawner <- function(targetName, position, angle, spawnflag, category,cmdinput1,cmdinput2=null)
{
	switch (category)
	{
		case "ambient_generic":			
			local spawnerTable =
			{
				targetname=targetName,
				origin= position,
				angles= angle,
				message=cmdinput1,
				volstart =0,
				spinup=0,
				spindown=0,
				spawnflags=spawnflag,
				radius=125000,
				preset=0,
				pitchstart=100,
				pitch=100,
				lfotype=0,
				lforate=0,
				lfomodvol=0,
				lfomodpitch=0,
				health=10,
				fadeoutsecs=0,
				fadeinsecs=0,
				cspinup=0
			}
			return SpawnEntityFromTable(category, spawnerTable);
			break;
		case "prop_dynamic":			
			local spawnerTable =
			{
				targetname=targetName,
				glowcolor="0 0 0",
				glowstate="0",
				glowrange="800",
				solid= "6",
				origin= position,
				angles= angle,
				model=	cmdinput1,
				disableshadows= "1"
			}
			return SpawnEntityFromTable(category, spawnerTable);
			break;
		case "info_zombie_spawn":			
			local spawnerTable =
			{
						targetname	= targetName,
						origin = position,
						angles= angle,
						population	= cmdinput1
			}
			return SpawnEntityFromTable(category, spawnerTable);
			break;		
		case "logic_timer":			
			local spawnerTable =
			{
				targetname	= targetName,
				//RefireTime	= user_intKillTimer,
				origin = position,
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
						cmd1 = cmdinput1
					}
				}
			}
			return SpawnEntityFromTable(category, spawnerTable);
			break;	
		default:
			Msg("found: " + category + " that does not fit spawn function\n");
			break;
	}
	Msg("Executed: genericSpawner function\n");
}

//spawner function
::genericSpawner <- function(targetName, position, angle, spawnflag, category, installation)
{
	switch (category)
	{		
		case "gascan":			
			local spawnerTable =
			{
				targetname = targetName,
				origin = position,
				spawnflags = spawnflag,
				angles = angle,
				model = installation
			}
			return SpawnEntityFromTable("prop_physics", spawnerTable);
			break;
		case "exhaust01":
		case "chainsawSmoke":
		case "lowSmoke":
		case "riverSmoke":
		case "roach":
		case "leaves":
		case "largeSmoke":
		case "fogVol_1024_512":
		case "skySmoke01":
		case "steamDoorway":
			local spawnerTable =
			{
				targetname = targetName,
				origin = position,
				angles = angle,
				effect_name = installation,
				start_active = "1"
			}
			return SpawnEntityFromTable("info_particle_system", spawnerTable);
			break;
		case "bin":
		case "bin_a":
		case "pallet":
		case "peanut":
		case "barstool":
		case "cart":
		case "oxy":
		case "basin":
		case "oil":
		case "ice":
		case "can":
		case "pchair":
		case "pbottle":
		case "pjug":
		case "haybale":		
			local spawnerTable =
			{
				targetname = targetName,
				origin = position,
				spawnflags = spawnflag,
				angles = angle,
				model = installation
			}
			return SpawnEntityFromTable("prop_physics", spawnerTable);
			break;
		case "pot_clay":		
		case "pot":
		case "haybails":
			Msg("spawning: " + category + "\n");
			local spawnerTable =
			{
				targetname = targetName,
				origin = position,
				spawnflags = spawnflag,
				angles = angle,
				model = installation
			}
			return SpawnEntityFromTable("prop_physics_override", spawnerTable);
			break;
		case "garbagePile01":
		case "garbagePile02":
		case "garb256_001b":
		case "bushAngled128":
		case "food03":
			local spawnerTable =
			{
				targetname = targetName,
				origin = position,
				spawnflags = spawnflag,
				angles = angle,
				model = installation
			}
			return SpawnEntityFromTable("prop_dynamic", spawnerTable);
			break;
		case "bloodstain003":
		case "leavesDecal":
		case "scavengegascan":
		case "leavesGroundDecal":
		case "cementStain":
		case "trash04":
		{
			local spawnerTable =
			{
				classname = "infodecal",
				origin = position,
				angles = angle,
				texture = installation
			}
			local spawnerEnt = g_MapScript.CreateSingleSimpleEntityFromTable(spawnerTable);
			DoEntFire("!self", "activate", "", 0.0, spawnerEnt, spawnerEnt);
			return spawnerEnt;
			break;
		}
		case "scavengegascanspawner":
		{
			//return deadCenterMallGascanSpawn(targetName,position,angle)
			
			local spawnerTable =
			{
				origin = position,
				angles = angle,
				targetname = targetName					
			}
			local can_spawner = SpawnEntityFromTable( "weapon_scavenge_item_spawn", spawnerTable );
			if ( can_spawner )
				DoEntFire( "!self", "SpawnItem", "", 0, null, can_spawner );
			return can_spawner;
			break;
		}
		default:
			Msg("found: " + category + " that does not fit spawn function\n");
			break;
	}
	Msg("Executed: genericSpawner function\n");
}




//read map entities generator table and send data to the spawner function
::mapEntitiesSpawner <- function(params)
{
	local currentMap = SessionState.MapName;
	local tableToUse = {};
	local tableFuncEntToUse = {};

	switch (currentMap)
	{
		case "c1m1_hotel":
		{						
			tableToUse = mSTc1m1;
			tableFuncEntToUse = mSFETc1m1;
			Msg("from amap found: " + currentMap + "\n");
			break;
		}
		case "c1m2_streets":
		{						
			tableToUse =
			{	
				icechest_lid_001		=	[-5422,933,420,0,180,0,260,"ice"]
				icechest_lid_002		=	[-5374,-2639,480,0,180,0,260,"ice"]
				icechest_lid_003		=	[-1064,3384,120,0,180,0,260,"ice"]
				icechest_lid_004		=	[359,3130,530,0,180,0,260,"ice"]
				icechest_lid_005		=	[-2559,2604,40,0,180,0,260,"ice"]
				shopping_cart_001		=	[-4880,-992,480,0,180,0,256,"cart"]
				shopping_cart_002		=	[-7779,-1679,420,0,180,0,256,"cart"]
				shopping_cart_003		=	[-5116,947,690,0,180,0,256,"cart"]
				garbage_can_001			=	[-2567,2081,30,0,0,0,4,"can"]
				garbage_can_002			=	[-7934,-3744,420,0,0,0,4,"can"]
				garbage_can_003			=	[80,2414,500,0,0,0,4,"can"]
				urban_pot_large_001		=	[1425,3577,640,0,90,0,0,"pot"]
				urban_pot_large_002		=	[371,2868,590,0,90,0,0,"pot"]
				urban_pot_large_003		=	[-377,3111,480,0,90,0,0,"pot"]
			}
			Msg("from amap found: " + currentMap + "\n");
			break;
		}
		case "c1m3_mall":
		case "c1m4_atrium":
		case "c2m1_highway":
{				
			tableToUse =
			{
				garbagePile02_001		=	[-435,-1701.65,-1087,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_002		=	[-1322,-2136,-1086,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_003		=	[884,3528,-967,-0.612655,57.546,0.0171361,256,"garbagePile02"]
				garbagePile02_004		=	[1133,5574,-967,-0.612655,343.546,0.0171361,256,"garbagePile02"]
				garbagePile02_005		=	[870,5593,-807,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_006		=	[1452,5538,-967,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_007		=	[2608,3635,-807,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garb256_001b_001		=	[2654,6216,-970.67,-0.612655,269.046,0.0171361,256,"garb256_001b"]
				garb256_001b_002		=	[2543,1382,-1790,-0.612655,195.046,0.0171361,256,"garb256_001b"]
				garb256_001b_003		=	[-2130,1282,-1786.67,-0.612655,197.546,0.0171361,256,"garb256_001b"]
				garb256_001b_004		=	[3141,5937,-1034,-0.612655,4.04583,0.0171361,256,"garb256_001b"]
				shopping_cart_001		=	[-402,1558,-1511,1.20081,335.577,-92.2396,4,"cart"]
				shopping_cart_002		=	[-674,-235,-1088,1.20081,335.577,-92.2396,4,"cart"]
				shopping_cart_003		=	[-562,-577,-936,1.20081,335.577,-92.2396,4,"cart"]
				shopping_cart_004		=	[-372,2266,-1436,1.20081,335.577,-92.2396,4,"cart"]
				shopping_cart_005		=	[1603,2774,-937,9.39369,1.17451,-0.930408,4,"cart"]
				shopping_cart_006		=	[-1998,1634,-1762.94,1.20081,335.577,-92.2396,4,"cart"]
				shopping_cart_007		=	[-2021,1198,-1762.94,1.20081,33.077,-92.2396,4,"cart"]
				leaves_green_001		=	[-45,1416.05,-1457.41,84.6013,68.2465,158.551,0,"leaves"]
				leaves_green_002		=	[1786,1603.92,-1572.4,84.6013,68.2465,158.551,0,"leaves"]
				leaves_green_003		=	[222,1435.87,-1467,84.6013,68.2465,158.551,0,"leaves"]
				leaves_green_004		=	[3788,3555.05,-996.613,84.6013,68.2465,158.551,0,"leaves"]
				leaves_green_005		=	[4111,4329,-724.711,84.6013,68.2465,158.551,0,"leaves"]
				leaves_green_006		=	[3832,4498,-789.172,84.6013,68.2465,158.551,0,"leaves"]
				leaves_green_007		=	[5420,0,-3296,84.6013,68.2465,158.551,0,"leaves"]
				leaves_green_008		=	[4030,4827,-769,84.6013,68.2465,158.551,0,"leaves"]
				leaves_green_009		=	[3829,4882,-791,84.6013,68.2465,158.551,0,"leaves"]
				leaves_green_010		=	[3816,5119,-790.865,84.6013,68.2465,158.551,0,"leaves"]
				leaves_green_011		=	[3969,4760,-779,84.6013,68.2465,158.551,0,"leaves"]
				leaves_green_012		=	[3712,4973,-794,84.6013,68.2465,158.551,0,"leaves"]
				leaves_green_013		=	[3766,4045,-846,84.6013,68.2465,158.551,0,"leaves"]
				leaves_green_014		=	[5258,8700,-805,84.6013,68.2465,158.551,0,"leaves"]
				leaves_green_015		=	[161,1354,-1565,84.6013,68.2465,158.551,0,"leaves"]
				trash04_001				=	[2889,3343,-967,0,0,0,0,"trash04"]
				trash04_002				=	[-432,-1741,-1088,0,0,0,0,"trash04"]
				trash04_003				=	[-1319,-2176,-1087,0,0,0,0,"trash04"]
				trash04_004				=	[914,3501,-968,0,0,0,0,"trash04"]
				trash04_005				=	[1115,5537,-968,0,0,0,0,"trash04"]
				trash04_006				=	[873,5553,-808,0,0,0,0,"trash04"]
				trash04_007				=	[1455,5498,-968,0,0,0,0,"trash04"]
				trash04_008				=	[2598,3639,-808,0,0,0,0,"trash04"]
				bin_a_001				=	[2759,4626,-940,39,92,93,0,"bin_a"]
				bin_a_002				=	[-1370,-2080,-1064,0,156,0,0,"bin_a"]
				bin_a_003				=	[2625,6245,-952,0,94,0,0,"bin_a"]
				bin_a_004				=	[2589,6248,-952,0,73,0,0,"bin_a"]
				bin_a_005				=	[-931,-1230,-1066,0,28,0,0,"bin_a"]
				bin_a_006				=	[-753,-2392,-1066,0,28,0,0,"bin_a"]
				bin_001					=	[2789,4584,-973,0,160,0,0,"bin"]
				bin_002					=	[2670,6241,-974,0,246,0,0,"bin"]
				bin_003					=	[2714 6241,-974,0,11,0,0,"bin"]
				skySmoke01_001			=	[-2175,-1166,-7138,0,91,0,0,"skySmoke01"]
				skySmoke01_002			=	[-656,-952,-7068,0,91,0,0,"skySmoke01"]
				skySmoke01_003			=	[81,-30,-6978,0,91,0,0,"skySmoke01"]
				fogVol_1024_512_001		=	[-469,1447,-1615,-7,180,-180,0,"fogVol_1024_512"]
				fogVol_1024_512_002		=	[784,1332,-1607,-7,180,-180,0,"fogVol_1024_512"]
				fogVol_1024_512_003		=	[1641,1364,-1593,-7,180,-180,0,"fogVol_1024_512"]
				fogVol_1024_512_004		=	[2317,1445,-1607,-7,180,-180,0,"fogVol_1024_512"]
				smoke_exhaust_001		=	[1870,5442,-927,-25.0147,126.061,-101.956,0,"exhaust01"]
				smoke_exhaust_002		=	[2054.59,5781.42,-790.972,-25.0147,206.061,-101.956,0,"exhaust01"]
				smoke_exhaust_003		=	[3664,7023,-670,-25.0147,340.561,-101.956,0,"exhaust01"]
				smoke_exhaust_004		=	[3557,8815,-950,-25.0147,339.061,-101.956,0,"exhaust01"]
				smoke_exhaust_005		=	[3441,8522.36,-968,-25.0147,89.561,-101.956,0,"exhaust01"]
				smoke_exhaust_006		=	[3491,8519,-968,-25.0147,89.561,-101.956,0,"exhaust01"]
				smoke_exhaust_007		=	[10400,7883,-518.644,-25.0147,174.561,-101.956,0,"exhaust01"]
				smoke_exhaust_008		=	[10397,7883,-501,-25.0147,174.561,-101.956,0,"exhaust01"]
				smoke_exhaust_009		=	[10438,7841,-483,-25.0147,249.561,-101.956,0,"exhaust01"]
				smoke_exhaust_010		=	[10402.9,7856.61,-518.644,-25.0147,197.561,-101.956,0,"exhaust01"]
			}
			Msg("from amap found: " + currentMap + "\n");
			break;
		}
		case "c2m2_fairgrounds":
		{				
			tableToUse =mSTc2m2;			
			Msg("from amap found: " + currentMap + "\n");
			break;
		}
		case "c2m3_coaster":
		{				
			tableToUse =
			{
				garbagePile02_001		=	[2736,2614,-39,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_001		=	[1389,3498.67,-39,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_001		=	[343,2758.95,-39,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_001		=	[602,3145,-39,-0.612655,333.046,0.0171361,256,"garbagePile02"]
				garbagePile02_001		=	[-3699,1725,162,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_001		=	[2504,1974.15,-7,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				steamDoorway_001		=	[2802,2781,-27,-42.9979,342.816,0.466189,0,"steamDoorway"]
				steamDoorway_002		=	[2767,3217,-26,-42.9979,230.816,0.466189,0,"steamDoorway"]
				steamDoorway_003		=	[2553,2419,-27,-42.9979,100.316,0.466189,0,"steamDoorway"]
				steamDoorway_004		=	[2441,2421,-27,-42.9979,87.316,0.466189,0,"steamDoorway"]
				steamDoorway_005		=	[327,4646,167,25,336.5,0,0,"steamDoorway"]
				steamDoorway_006		=	[1023,4524,-25,-42.9979,267.816,0.466189,0,"steamDoorway"]
				steamDoorway_007		=	[1024,4436,-25,-42.9979,87.316,0.466189,0,"steamDoorway"]
				steamDoorway_008		=	[832,4436,-25,-42.9979,87.316,0.466189,0,"steamDoorway"]
				steamDoorway_009		=	[832,4523,-26,-42.9979,267.816,0.466189,0,"steamDoorway"]
				steamDoorway_010		=	[657,4359,-32,-42.9979,181.816,0.466189,0,"steamDoorway"]
				steamDoorway_011		=	[657,4624,-32,-42.9979,181.816,0.466189,0,"steamDoorway"]
				steamDoorway_012		=	[-42,2706,-31,-43.9826,298.664,2.86583,0,"steamDoorway"]
				steamDoorway_013		=	[468,3478,-31,-42.9979,27.316,0.466189,0,"steamDoorway"]
				steamDoorway_014		=	[559,3181,-32,-42.9979,358.816,0.466189,0,"steamDoorway"]
				steamDoorway_015		=	[657,3181,-32,-42.9979,179.316,0.466189,0,"steamDoorway"]
				steamDoorway_016		=	[-209,2539,-30,-48.4975,341.245,0.565128,0,"steamDoorway"]
				steamDoorway_017		=	[9,2622,-31,-48.4975,117.245,0.565128,0,"steamDoorway"]
				steamDoorway_018		=	[508,2950,-32,-48.4975,330.745,0.565128,0,"steamDoorway"]
				steamDoorway_019		=	[430,2736,-32,-48.4975,115.745,0.565128,0,"steamDoorway"]
			}
			Msg("from amap found: " + currentMap + "\n");
			break;
		}
		case "c2m4_barns":
		{				
			tableToUse = mSTc2m4;
			Msg("from amap found: " + currentMap + "\n");
			break;
		}
		case "c2m5_concert":
			//IncludeScript("adarkcarnival");
		case "c3m1_plankcountry":
		case "c3m2_swamp":
		case "c3m3_shantytown":
		case "c3m4_plantation":
			//IncludeScript("aswampfever");
		case "c4m1_milltown_a":
		case "c4m2_sugarmill_a":
		case "c4m3_sugarmill_b":
		case "c4m4_milltown_b":
		case "c4m5_milltown_escape":
			//IncludeScript("ahardrain");
		case "c5m1_waterfront":
		case "c5m2_park":
		case "c5m3_cemetery":
		case "c5m4_quarter":
		{				
			tableToUse =
			{
				oxygen_tank_001			=	[-1570,1823,99,0,0,0,256,"oxy"]
				oxygen_tank_002			=	[-1399,1857,97,0,0,0,256,"oxy"]
				oxygen_tank_003			=	[-1102,171,124,0,0,0,256,"oxy"]
				oxygen_tank_004			=	[-907,476,124,0,0,0,256,"oxy"]
			}
			Msg("from amap found: " + currentMap + "\n");
			break;
		}
		case "c5m5_bridge":
			//IncludeScript("aparish");
		case "c6m1_riverbank":
		case "c6m2_bedlam":
		case "c6m3_port":
			//IncludeScript("apassing");
		case "c7m1_docks":
		case "c7m2_barge":
		case "c7m3_port":
			//IncludeScript("asacrifice");
		case "c8m1_apartment":
		{				
			tableToUse =
			{
				shopping_cart_001		=	[2311,788,75,0,180,0,256,"cart"]
				shopping_cart_002		=	[2673,2559,75,0,180,0,256,"cart"]
				shopping_cart_003		=	[787,2225,75,0,180,0,256,"cart"]
				shopping_cart_004		=	[2497,3224,75,0,180,0,256,"cart"]
				shopping_cart_005		=	[678,3413,75,0,180,0,256,"cart"]
				shopping_cart_006		=	[2746,4536,75,0,180,0,256,"cart"]
				shopping_cart_007		=	[2771,4461,75,0,180,0,256,"cart"]
				shopping_cart_008		=	[2585,4704,75,0,180,0,256,"cart"]
				shopping_cart_009		=	[2544,3245,75,0,180,0,256,"cart"]
				garbage_can_001			=	[2318,3647,50,0,0,0,4,"can"]
				garbage_can_002			=	[907,3204,50,0,0,0,4,"can"]
				garbage_can_003			=	[2225,2358,50,0,0,0,4,"can"]
				garbage_can_004			=	[2441,1753,50,0,0,0,4,"can"]
				garbage_can_005			=	[2573,2371,50,0,0,0,4,"can"]
//				paper_streets_001		=	[1585,1113,531,-82.5,269.5,-0.5,0,"paper_streets"]
			}
			Msg("from amap found: " + currentMap + "\n");
			break;
		}
		case "c8m2_subway":
		{				
			tableToUse =
			{
				garbage_can_001			=	[4707,4338,-260,0,0,0,4,"can"]
				garbage_can_002			=	[8522,3415,-120,0,0,0,4,"can"]
				garbage_can_003			=	[8209,4750,40,0,0,0,4,"can"]
				garbage_can_004			=	[9386,5413,40,0,0,0,4,"can"]
				garbage_can_005			=	[10519,5266,40,0,0,0,4,"can"]
				oil_drum_001			=	[7571,3636,-60,0,0,0,0,"oil"]
				oil_drum_002			=	[7958,3834,-40,0,0,0,0,"oil"]
				oil_drum_003			=	[10475,5330,70,0,0,0,0,"oil"]
				oxygen_tank_001			=	[7989,4618,270,0,0,0,256,"oxy"]
				oxygen_tank_002			=	[9984,5121,70,0,0,0,256,"oxy"]
				oxygen_tank_003			=	[7341,2958,70,0,0,0,256,"oxy"]
				oxygen_tank_004			=	[5694,4032,-300,0,0,0,256,"oxy"]
				trash_bin_001			=	[9745,5393,60,0,0,0,0,"bin"]
				trash_bin_002			=	[9668,5379,60,0,0,0,0,"bin"]
				trash_bin_003			=	[9148,5406,60,0,0,0,0,"bin"]
				trash_bin_004			=	[9298,5381,40,0,0,0,0,"bin"]
				trash_bin_005			=	[8379,4867,60,0,0,0,0,"bin"]
				trash_bin_006			=	[7536,5390,60,0,0,0,0,"bin"]
				trash_bin_007			=	[7710,5398,60,0,0,0,0,"bin"]
				trash_bin_008			=	[10407,5360,60,0,0,0,0,"bin"]
			}
			Msg("from amap found: " + currentMap + "\n");
			break;
		}
		case "c8m3_sewers":
		case "c8m4_interior":
		{				
			tableToUse =
			{
				plastic_basin_001		=	[13322,14164,5549,0,0,0,256,"basin"]
				plastic_basin_002		=	[12243,14263,5549,0,0,0,256,"basin"]
				plastic_basin_003		=	[11751,14161,5549,0,0,0,256,"basin"]
				plastic_basin_004		=	[13823,13929,5543,0,0,0,256,"basin"]
				trash_bin_001			=	[12907,13975,5537,0,0,0,0,"bin"]
				trash_bin_002			=	[13268,14971,5537,0,0,0,0,"bin"]
				trash_bin_003			=	[12569,14149,5557,0,0,0,0,"bin"]
				oxygen_tank_001			=	[13322,14164,5549,0,0,0,256,"oxy"]
				oxygen_tank_002			=	[12243,14263,5549,0,0,0,256,"oxy"]
				oxygen_tank_003			=	[11751,14161,5549,0,0,0,256,"oxy"]
			}
			Msg("from amap found: " + currentMap + "\n");
			break;
		}
		case "c8m5_rooftop":
		//IncludeScript("anomercy");
		{				
			tableToUse =
			{
				oxygen_tank_001			=	[6580,8231,6053,0,0,0,256,"oxy"]
				oxygen_tank_002			=	[6065,7735,6133,0,0,0,256,"oxy"]
				oxygen_tank_003			=	[6084,9050,6133,0,0,0,256,"oxy"]
				oxygen_tank_004			=	[7397,9212,6237,0,0,0,256,"oxy"]
				oxygen_tank_005			=	[6124,8515,5768,0,0,0,256,"oxy"]
			}
			Msg("from amap found: " + currentMap + "\n");
			break;
		}
		case "c9m1_alleys":
		case "c9m2_lots":
		{
//			IncludeScript("acrashcourse");
//			Msg("from amap found: " + currentMap + "\n");
			break;
		}
		case "c10m1_caves":
		case "c10m2_drainage":
		case "c10m3_ranchhouse":
		case "c10m4_mainstreet":
		case "c10m5_boathouse":
		{
//			IncludeScript("adeathtoll");
//			Msg("from amap found: " + currentMap + "\n");
			break;
		}
		case "c11m1_greenhouse":
		case "c11m2_offices":
		case "c11m3_garage":
		case "c11m4_terminal":
		case "c11m5_runway":
		{
//			IncludeScript("adeadair");
//			Msg("from amap found: " + currentMap + "\n");
			break;
		}
		case "c12m1_hilltop":
		case "c12m2_traintunnel":
		case "c12m3_bridge":
		case "c12m4_barn":
		case "c12m5_cornfield":
		{
//			IncludeScript("a");
//			Msg("running table: " + tableToUse + " from map: " + currentMap + "\n");
			break;
		}
		case "c13m1_alpinecreek":
		case "c13m2_southpinestream":
		case "c13m3_memorialbridge":
		case "c13m4_cutthroatcreek":
		case "c14m1_junkyard":
		case "c14m2_lighthouse":	
//			IncludeScript("alaststand");
		default:
			Msg("defaulted mapEntitesSpawner switch\n");
			break;
	}
	foreach(index, item in tableToUse)
	{
		local propPhysicsName = index;
		local propPhysicsVector = Vector(tableToUse[index][0], tableToUse[index][1], tableToUse[index][2]);
		local propAngleVector = Vector(tableToUse[index][3], tableToUse[index][4], tableToUse[index][5]);
		local propSpawnFlag = tableToUse[index][6];
		local categoryName = tableToUse[index][7];//for spawn table logic
		local entityBuild = tADMIT[categoryName][0];
		genericSpawner(propPhysicsName, propPhysicsVector, propAngleVector, propSpawnFlag, categoryName, entityBuild);
	}
	foreach(index, item in tableFuncEntToUse)
	{
		local propPhysicsName = index;
		local propPhysicsVector = Vector(tableFuncEntToUse[index][0], tableFuncEntToUse[index][1], tableFuncEntToUse[index][2]);
		local propAngleVector = Vector(tableFuncEntToUse[index][3], tableFuncEntToUse[index][4], tableFuncEntToUse[index][5]);
		local propSpawnFlag = tableFuncEntToUse[index][6];
		local categoryName = tableFuncEntToUse[index][7];
		local cmdinput1 = tableFuncEntToUse[index][8];
		funcEntsSpawner(propPhysicsName, propPhysicsVector, propAngleVector, propSpawnFlag, categoryName, cmdinput1);
	}
	Msg("Executed: mapEntitiesSpawner function\n");
}



::deadCenterMallGascanSpawn <- function(targetName, position, angle)
{
	Msg("running deadCenterMallGascanSpawn function\n");
	local spawnerTable =
	{
		targetname = targetName,
		origin = position,
		angles = angle,
		spawnflags = 33024,
		glowstate = 3,
		glowcolor = Vector(255,255,0),
		model = "models/props_junk/gascan001a.mdl"
	}
	return SpawnEntityFromTable("prop_physics", spawnerTable);
}

//read map gasScanSpawner table and send data to the spawner function
::mapgasScanSpawnerSpawner <- function()
{
	local currentMap = SessionState.MapName;
	local tableToUse = null;

	switch (currentMap)
	{
		case "c1m1_hotel":
		case "c1m2_streets":
		case "c1m3_mall":
		case "c1m4_atrium":
		{				
			tableToUse = mSSGCTc1m4;
			Msg("from amap found: " + currentMap + "\n");
			break;
		}
		case "c2m1_highway":			
		case "c2m2_fairgrounds":			
		case "c2m3_coaster":			
		case "c2m4_barns":			
		case "c2m5_concert":
			//IncludeScript("adarkcarnival");
		case "c3m1_plankcountry":
		case "c3m2_swamp":
		case "c3m3_shantytown":
		case "c3m4_plantation":
			//IncludeScript("aswampfever");
		case "c4m1_milltown_a":
		case "c4m2_sugarmill_a":
		case "c4m3_sugarmill_b":
		case "c4m4_milltown_b":
		case "c4m5_milltown_escape":
			//IncludeScript("ahardrain");
		case "c5m1_waterfront":
		case "c5m2_park":
		case "c5m3_cemetery":
		case "c5m4_quarter":
		case "c5m5_bridge":
			//IncludeScript("aparish");
		case "c6m1_riverbank":
		case "c6m2_bedlam":
		case "c6m3_port":
			//IncludeScript("apassing");
		case "c7m1_docks":
		case "c7m2_barge":
		case "c7m3_port":
			//IncludeScript("asacrifice");
		case "c8m1_apartment":
		case "c8m2_subway":
		case "c8m3_sewers":
		case "c8m4_interior":
		case "c8m5_rooftop":
		case "c9m1_alleys":
		case "c9m2_lots":
//			IncludeScript("acrashcourse");
		case "c10m1_caves":
		case "c10m2_drainage":
		case "c10m3_ranchhouse":
		case "c10m4_mainstreet":
		case "c10m5_boathouse":
//			IncludeScript("adeathtoll");
		case "c11m1_greenhouse":
		case "c11m2_offices":
		case "c11m3_garage":
		case "c11m4_terminal":
		case "c11m5_runway":
//			IncludeScript("adeadair");
		case "c12m1_hilltop":
		case "c12m2_traintunnel":
		case "c12m3_bridge":
		case "c12m4_barn":
		case "c12m5_cornfield":
		case "c13m1_alpinecreek":
		case "c13m2_southpinestream":
		case "c13m3_memorialbridge":
		case "c13m4_cutthroatcreek":
		case "c14m1_junkyard":
		case "c14m2_lighthouse":	
		default:
			Msg("defaulted mapEntitesSpawner switch\n");
			break;
	}
	foreach(index, item in tableToUse)
	{
		local propPhysicsName = index;
		local propPhysicsVector = Vector(tableToUse[index][0], tableToUse[index][1], tableToUse[index][2]);
		local propAngleVector = Vector(tableToUse[index][3], tableToUse[index][4], tableToUse[index][5]);
		local propSpawnFlag = tableToUse[index][6];
		local categoryName = tableToUse[index][7];//for spawn table logic
		local entityBuild = tADMIT[categoryName][0];
		genericSpawner(propPhysicsName, propPhysicsVector, propAngleVector, propSpawnFlag, categoryName, entityBuild);
	}
	Msg("Executed: mapgasScanSpawnerSpawner function\n");
}
Msg("Loaded: aSpawns.nut\n");