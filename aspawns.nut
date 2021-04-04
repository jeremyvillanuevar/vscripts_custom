//Title: The Alternate Difficulties Mod (TADM)
//Author Steam Alias: jetSetWilly II
//Author URL: https://steamcommunity.com/id/jetsetwillyuncensored/
//Version: 2.5
//Programming Language: VScript
//File Description: This is a data file that holds all of the spawn tables used by TADM


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
			tableToUse =
			{
				scavengegascanspawner_001				=	[-5826.397949,-3766.900146,121.191513,-89.756203,35.311050,-18.307281,256,"scavengegascanspawner"]
				scavengegascanspawner_002				=	[-3921.168213,-2796.525146,273.444275,-89.437828,-15.096178,71.676933,256,"scavengegascanspawner"]
				scavengegascanspawner_003				=	[-4460.450684,-2393.967773,-6.543771,-89.622887,151.324280,-81.998047,256,"scavengegascanspawner"]
				scavengegascanspawner_004				=	[-3746.075439,-3469.342773,-6.533242,-89.725517,151.001450,-81.569489,256,"scavengegascanspawner"]
				scavengegascanspawner_005				=	[-4509.846680,-3996.965820,129.438034,-89.684006,64.923325,3.458946,256,"scavengegascanspawner"]
				scavengegascanspawner_006				=	[-4924.200684,-2777.282471,277.407135,-0.243933,16.434361,-90.146545,256,"scavengegascanspawner"]
				scavengegascanspawner_007				=	[-3864.321289,-3422.527588,273.473846,-89.650421,139.663223,-70.185608,256,"scavengegascanspawner"]
				scavengegascanspawner_008				=	[-2923.110107,-3148.653809,273.448975,-89.491905,-15.097923,71.676849,256,"scavengegascanspawner"]
				scavengegascanspawner_009				=	[-3054.118652,-4660.107910,273.453247,-89.540642,-15.099179,71.677055,256,"scavengegascanspawner"]
				scavengegascanspawner_010				=	[-4451.859375,-3206.565186,106.361153,0.889960,1.695853,0.070326,256,"scavengegascanspawner"]
			}
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
		local categoryName = tableToUse[index][7];
		local entityBuild = tADMIT[categoryName][0];
		genericSpawner(propPhysicsName, propPhysicsVector, propAngleVector, propSpawnFlag, categoryName, entityBuild);
	}
	Msg("Executed: mapgasScanSpawnerSpawner function\n");
}

//read map entities generator table and send data to the spawner function
::mapEntitiesSpawner <- function(params)
{
	local currentMap = SessionState.MapName;
	local tableToUse = {};

	switch (currentMap)
	{
		case "c1m1_hotel":
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
			tableToUse =
			{
				urban_clay_pot_001		=	[-2022,-4457,35,0,0,0,4356,"pot_clay"]
				urban_clay_pot_002		=	[-1802,-4456,35,0,0,0,4356,"pot_clay"]
				trash_bin_001			=	[-2106,494,-40,0,222.5,0,0,"bin"]
				trash_bin_002			=	[-2061,464,-29,0,264,0,0,"bin"]
				trash_bin_003			=	[3089,-631,0,0,222,0,0,"bin"]
				trash_bin_004			=	[-925,-465,-103,0,200,0,0,"bin"]
				trash_bin_005			=	[-933,-432,-124,0,193,0,0,"bin"]
				barstool_001			=	[-2867.07,-5441.19,-126.493,0,195,0,4,"barstool"]
				barstool_002			=	[3903.18,440.124,1.50742,0,195,0,4,"barstool"]
				barstool_003			=	[-2380,-618,-96,0,195,0,4,"barstool"]
				barstool_004			=	[2712.25,366.556,7.50741,0,195,0,4,"barstool"]
				barstool_005			=	[2952.27,-451,1.50742,0,195,0,4,"barstool"]
				barstool_006			=	[3940.12,-219.67,1.50741,0,195,0,4,"barstool"]
				barstool_007			=	[3899.71,336.163,1.5074,0,195,0,4,"barstool"]
				smoke_large_001			=	[-3904,-141,153,-89,90,90,0,"largeSmoke"]
				smoke_large_002			=	[2792,-818,342,-89 90 90,0,"largeSmoke"]
				smoke_large_003			=	[4607,-310,156.475,-89,90,90,0,"largeSmoke"]
				smoke_large_004			=	[4620,-2294,270,-89,90,90,0,"largeSmoke"]
				smoke_large_005			=	[2779,-2274,175,-89,90,90,0,"largeSmoke"]
				smoke_large_006			=	[577,-2019,138,-89,90,90,0,"largeSmoke"]
				smoke_large_007			=	[-649,5086,149,-89,90,90,0,"largeSmoke"]
				smoke_large_008			=	[-4322,-4304,9,-89,90,90,0,"largeSmoke"]
				smoke_large_009			=	[-3658,-6280,92,-89,90,90,0,"largeSmoke"]
				riverboat_smoke_001		=	[-4408,-3306,308,-90,105,-105,0,"riverSmoke"]
				riverboat_smoke_002		=	[-678,-4807,3,-90,105,-105,0,"riverSmoke"]
				riverboat_smoke_003		=	[3840,-341,456,-90,105,-105,0,"riverSmoke"]
				riverboat_smoke_004		=	[1710,-485,258,-90,105,-105,0,"riverSmoke"]
				riverboat_smoke_005		=	[4681,165,9,-90,105,-105,0,"riverSmoke"]
				riverboat_smoke_006		=	[4847,-1206,9,-90,105,-105,0,"riverSmoke"]
				riverboat_smoke_007		=	[3436,-2431,9,-90,105,-105,0,"riverSmoke"]
				riverboat_smoke_008		=	[680,-1926,138,-90,105,-105,0,"riverSmoke"]
				riverboat_smoke_009		=	[160,-997,273,-90,105,-105,0,"riverSmoke"]
				riverboat_smoke_010		=	[-229,-496,370,-90,105,-105,0,"riverSmoke"]
				riverboat_smoke_011		=	[-866,-5189,4,-90,105,-105,0,"riverSmoke"]
				riverboat_smoke_012		=	[566,-629,485,-90,105,-105,0,"riverSmoke"]
				leaves_green_001		=	[-1237,-526,100,-90,25,-115,0,"leaves"]
				leaves_green_002		=	[-482,-296,211,-90,25,-115,0,"leaves"]
				leaves_green_003		=	[-159,-77,211,-90,25,-115,0,"leaves"]
				leaves_green_004		=	[3491,-1293,215,-90,25,-115,0,"leaves"]
				leaves_green_005		=	[3550,-1033,215,-90,25,-115,0,"leaves"]
				leaves_green_006		=	[2968,-2,219,-90,25,-115,0,"leaves"]
				leaves_green_007		=	[3508,116,219,-90,25,-115,0,"leaves"]
				leaves_green_008		=	[3424,307,219,-90,25,-115,0,"leaves"]
				leaves_green_009		=	[2565,876,214,-90,25,-115,0,"leaves"]
				leaves_green_010		=	[2579,1341,214,-90,25,-115,0,"leaves"]
				leaves_green_011		=	[1749,1172,220,-90,25,-115,0,"leaves"]
				leaves_green_012		=	[1268,1314,220,-90,25,-115,0,"leaves"]
				leaves_green_013		=	[-3100,-4721,86,-90,25,-115,0,"leaves"]
				leaves_green_014		=	[-2560,-4603,86,-90,25,-115,0,"leaves"]
				leaves_green_015		=	[-2644,-4412,86,-90,25,-115,0,"leaves"]
				leaves_green_016		=	[-3186,-5885,150,-90,25,-115,0,"leaves"]
				chopper_lowsmoke_001	=	[2866,-1807,340,-81,0,0,0,"lowSmoke"]
				chopper_lowsmoke_002	=	[-3696,-5831,198,-81,0,0,0,"lowSmoke"]
				chopper_lowsmoke_003	=	[-3842,-1798,465,-81,0,0,0,"lowSmoke"]
				chopper_lowsmoke_004	=	[921,-30,266,-81,0,0,0,"lowSmoke"]
				roaches_lot_001			=	[-3962,-1391,-122,1.3774,6.00096,-179.672,0,"roach"]
				roaches_lot_002			=	[-3817,-1850,-118.972,1.3774,31.501,-179.672,0,"roach"]
				roaches_lot_003			=	[-3235,-2013,-118,1.3774,125.001,-179.672,0,"roach"]
				roaches_lot_004			=	[733,-1302,5,1.3774,143.501,-179.672,0,"roach"]
				roaches_lot_005			=	[3052,-1573,9.08126,1.3774,301.501,-179.672,0,"roach"]
				chainsaw_smoke_001		=	[2930,-5263,-61,-68,118,-164,0,"chainsawSmoke"]
				chainsaw_smoke_002		=	[848,-121,78,-68,118,-164,0,"chainsawSmoke"]
				chainsaw_smoke_003		=	[2832,-1740,69,-68,118,-164,0,"chainsawSmoke"]
				chainsaw_smoke_004		=	[-1261,-6264,-63,-68,118,-164,0,"chainsawSmoke"]
				chainsaw_smoke_005		=	[-3523,-5850,5,-68,118,-164,0,"chainsawSmoke"]
				chainsaw_smoke_006		=	[-2377,-3324,-57,-68,118,-164,0,"chainsawSmoke"]
				chainsaw_smoke_007		=	[-3816,-2004,-65,-68,118,-164,0,"chainsawSmoke"]
				smoke_exhaust_001		=	[1761,-1377,172,2,32,111,0,"exhaust01"]
				smoke_exhaust_002		=	[-2539,-6147,-82,-25,291,-72,0,"exhaust01"]
				smoke_exhaust_003		=	[-2585,-6119,-115,-25,233,-72,0,"exhaust01"]
				smoke_exhaust_004		=	[3446,-1957,18,67,291,-48,0,"exhaust01"]
				smoke_exhaust_005		=	[-2876,-2036,-57,-25,135,-72,0,"exhaust01"]
				smoke_exhaust_006		=	[2680,-861,26,-81,352,-151,0,"exhaust01"]
				smoke_exhaust_007		=	[2797,-671,37,81,355,-154,0,"exhaust01"]
				smoke_exhaust_008		=	[2294,2573,62,-25,164,-72,0,"exhaust01"]
				smoke_exhaust_009		=	[-914,-1254,-81,-25,195,-72,0,"exhaust01"]
				smoke_exhaust_010		=	[-3544,-6127,-20,-25,343,-72,0,"exhaust01"]
				smoke_exhaust_011		=	[-3508,-2512,297,-25,185,-72,0,"exhaust01"]
				smoke_exhaust_012		=	[-3335,-2497,306,-25,7,-72,0,"exhaust01"]
				smoke_exhaust_013		=	[-3604,-1513,-76,-25,182,-72,0,"exhaust01"]
				peanut_cutout_001		=	[-3886,-1741,-120,88,225,-108,260,"peanut"]
				peanut_cutout_002		=	[1148,1602,30,-38,240,97,260,"peanut"]
				peanut_cutout_003		=	[-2275,-2570,-125,66,192,-76,260,"peanut"]
				peanut_cutout_004		=	[3111,-1763,15,0,247,0,260,"peanut"]
				peanut_cutout_005		=	[2170,2254,25,79,261,-8,260,"peanut"]
				peanut_cutout_006		=	[-2680,-4950,-127,0,139,0,260,"peanut"]
				peanut_cutout_007		=	[-1868,-2591,-127,0,250,0,260,"peanut"]
				peanut_cutout_008		=	[2257,-450,39,-38,240,97,260,"peanut"]
				peanut_cutout_009		=	[4551,-1061,30,-38,240,97,260,"peanut"]	
				wood_pallet_001			=	[1102,-1132.82,31,70.4829,269.885,-177.842,4,"pallet"]
				wood_pallet_002			=	[1238,1992,33.2963,61.9836,271.629,-178.12,4,"pallet"]
				wood_pallet_003			=	[3848,876,33.2963,61.9836,187.629,-178.12,4,"pallet"]
				wood_pallet_004			=	[-4146.07,-4231.56,-121.82,0,140,0,4,"pallet"]
				wood_pallet_005			=	[664.188,-1719.68,6.17955,0,140,0,4,"pallet"]
				wood_pallet_006			=	[4212.11,-541.791,3.92978,0,140,0,4,"pallet"]
				wood_pallet_007			=	[3754.55,790.792,6.17956,0,140,0,4,"pallet"]
				trash04_001				=	[-2761.88,-1092,-128,0,326,0,0,"trash04"]
				trash04_002				=	[-1666,-5331,-127,0,0,0,0,"trash04"]
				trash04_003				=	[-1911,-3060.37,-128,0,0,0,0,"trash04"]
				leaves02_001			=	[-1155,-5548,-128,0,0,0,0,"leavesDecal"]
				leaves02_002			=	[-3791,-5201,-64,0,0,0,0,"leavesDecal"]
				leaves02_003			=	[2982,977,0,0,0,0,0,"leavesDecal"]
				leaves02_004			=	[4443,-1829,1,0,0,0,0,"leavesDecal"]
				leaves02_005			=	[3822,-622,0,0,0,0,0,"leavesDecal"]
				leaves02_006			=	[-3632,-5052,-64,0,0,0,0,"leavesDecal"]
				leavesGround02_001		=	[-3144,-6316,-63,0,0,0,0,"leavesGroundDecal"]
				leavesGround02_002		=	[-1562,-4814,-127,0,0,0,0,"leavesGroundDecal"]
				leavesGround02_003		=	[-2765,-4667,-127,0,0,0,0,"leavesGroundDecal"]
				leavesGround02_004		=	[-2002,-944,-127,0,0,0,0,"leavesGroundDecal"]
				leavesGround02_005		=	[-1298,-220,-127,0,0,0,0,"leavesGroundDecal"]
				leavesGround02_006		=	[3274,92,1,0,0,0,0,"leavesGroundDecal"]
				leavesGround02_007		=	[3829,-1148,5,0,0,0,0,"leavesGroundDecal"]
				leavesGround02_008		=	[3329,-54,1,0,0,0,0,"leavesGroundDecal"]
				leavesGround02_009		=	[2680,1077,1,0,0,0,0,"leavesGroundDecal"]
				leavesGround02_010		=	[-1510,-333,-127,0,0,0,0,"leavesGroundDecal"]
				leavesGround02_011		=	[-1683,-2959,-127,0,0,0,0,"leavesGroundDecal"]
				cementStain01_001		=	[1401,-1087,0,0,0,0,0,"cementStain"]
				cementStain01_002		=	[827,-179,0,0,0,0,0,"cementStain"]
				cementStain01_003		=	[-2345,-3326,-127,0,0,0,0,"cementStain"]
				cementStain01_004		=	[2059,-1484,0,0,0,0,0,"cementStain"]
				garbagePile02_001		=	[3086,228.493,1,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_002		=	[2115,1121.29,2,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_003		=	[3050,-1608.87,1,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_004		=	[284,-221.23,-28,-8.87415,13.7125,-1.99093,256,"garbagePile02"]
				garbagePile02_005		=	[-1914,-3020.37,-127,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_006		=	[-2403,-3160,-127,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_007		=	[-1985,-6752.54,-119,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_008		=	[-1669,-5291,-126,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_009		=	[-1521,-5854.77,-124,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				bushAngled128_001		=	[-779,329,-133,0,179.5,0,0,"bushAngled128"]
				bushAngled128_002		=	[-2435,-3528,-134,0,0,0,0,"bushAngled128"]
				bushAngled128_003		=	[-2446,-6755,-130,0,90,0,0,"bushAngled128"]
				bushAngled128_004		=	[-2182,-6753,-130,0,90,0,0,"bushAngled128"]
				bushAngled128_005		=	[-3110,-5200,-68,2.5,90,0,0,"bushAngled128"]
			}
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
			tableToUse =
			{
				plasticChair_001		=	[-165,1424,-165,-11,320,-46,4,"pchair"]
				plasticChair_002		=	[455,1407,-113,30.2181,197.423,-172.578,4,"pchair"]
				plasticChair_003		=	[1578.67,1573.98,-131.971,-11.0007,320.239,-46.5093,4,"pchair"]
				plasticChair_004		=	[2195.53,716.096,-175.971,-11.0007,320.239,-46.5093,4,"pchair"]
				plasticChair_005		=	[-82,1106,-71,30.2181,313.923,-172.578,4,"pchair"]
				plasticChair_006		=	[3181.59,768.848,-190.262,0,253.5,0,4,"pchair"]
				bin_a_001				=	[2657.01,2199.43,-170.11,0,285,0,4,"bin_a"]
				bin_a_002				=	[3734.97,1168.79,-170.11,0,285,0,4,"bin_a"]
				bin_a_003				=	[3551.42,2001.74,-170.11,0,285,0,4,"bin_a"]
				bin_a_004				=	[2836.63,3230.65,-170.11,0,285,0,4,"bin_a"]
				bin_a_005				=	[2990.79,2558.18,-167.047,0,285,0,4,"bin_a"]
				bin_a_006				=	[2834.12,673.723,-170.11,0,285,0,4,"bin_a"]
				bin_a_007				=	[-646.407,1834.51,-234.491,0,285,0,4,"bin_a"]
				bin_a_008				=	[-209.311,2338.33,-234.11,0,285,0,4,"bin_a"]
				pbottle_001				=	[2487.06,1436.5,0.3932,0,285,0,4,"pbottle"]
				pbottle_002				=	[-445.332,2190.28,-245.673,14.9013,239.763,-96.7272,4,"pbottle"]
				pbottle_003				=	[-1598.38,18.4336,-14.3807,14.9013,239.763,-96.7272,4,"pbottle"]
				pbottle_004				=	[-1744.11,-212.113,-7.15062,14.9013,239.763,-96.7272,4,"pbottle"]
				pbottle_005				=	[-919.583,-161.198,-26.9846,14.9013,239.763,-96.7272,4,"pbottle"]
				can_001					=	[-82.791,-260.786,-175.294,-85.9689,345.613,82.8691,4,"can"]
				can_002					=	[3171.73,696.469,-175.294,-85.9689,345.613,82.8691,4,"can"]
				garbagePile02_001		=	[-42,-238.237,-190,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_002		=	[-1268,1629.92,-255,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_003		=	[-2020,1365.27,-255,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_004		=	[-2428,1174.64,-255,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_005		=	[117,1880.64,-255,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_006		=	[3038.97,2565.12,-191,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_007		=	[-1395,836,-191,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_008		=	[513,2212,-191,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_009		=	[755,2204,-190,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_010		=	[2251,1395.19,-191,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_011		=	[2214,1508,-191,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_012		=	[-121,1618,-255,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile02_013		=	[3078,1339.42,-191,-0.612655,13.546,0.0171361,256,"garbagePile02"]
				garbagePile01_001		=	[-2021,1408.27,-255,-0.612655,13.546,0.0171361,256,"garbagePile01"]
				garbagePile01_002		=	[-2429,1217.64,-255,-0.612655,13.546,0.0171361,256,"garbagePile01"]
				garbagePile01_003		=	[116,1923.64,-255,-0.612655,13.546,0.0171361,256,"garbagePile01"]
				garbagePile01_004		=	[2999,2581,-191,-0.612655,13.546,0.0171361,256,"garbagePile01"]
				garbagePile01_005		=	[-1396,879,-191,-0.612655,13.546,0.0171361,256,"garbagePile01"]
				garbagePile01_006		=	[512,2255,-191,-0.612655,13.546,0.0171361,256,"garbagePile01"]
				garbagePile01_007		=	[754,2247,-190,-0.612655,13.546,0.0171361,256,"garbagePile01"]
				garbagePile01_008		=	[2250,1438.19,-191,-0.612655,13.546,0.0171361,256,"garbagePile01"]
				garbagePile01_009		=	[2213,1551,-191,-0.612655,13.546,0.0171361,256,"garbagePile01"]
				plasticJug_001			=	[-2624.67,108.326,-191,0,120,0,4,"pjug"]
				plasticJug_002			=	[-1833.45,1380.83,-255,0,120,0,4,"pjug"]
				plasticJug_003			=	[3326.92,1217.96,-156.15,0,120,0,4,"pjug"]
				plasticJug_004			=	[2433.48,2662.23,-191,0,120,0,4,"pjug"]
				plasticJug_005			=	[3485.81,2848.75,-191,0,120,0,4,"pjug"]
				plasticJug_006			=	[-341.153,2236.92,-255,0,120,0,4,"pjug"]
				food03_001				=	[981,1759,-191.824,0,310.5,0,256,"food03"]
				food03_002				=	[347,1603,-191.824,0,310.5,0,256,"food03"]
				food03_003				=	[-844,1114,-191.824,0,310.5,0,256,"food03"]
				food03_004				=	[-2293,691,-191.824,0,310.5,0,256,"food03"]
				food03_005				=	[36,415,-191.824,0,275.5,0,256,"food03"]
				haybale_001				=	[189,156,-173.226,-0.612655,13.546,0.0171361,256,"haybale"]
				haybale_002				=	[146,153,-173.226,86.6123,179.222,179.241,256,"haybale"]
				haybale_003				=	[204,-520,-173.226,86.6123,197.722,179.241,256,"haybale"]
				haybale_004				=	[102,-651,-173.226,-0.612655,32.046,0.0171361,256,"haybale"]
//				haybails_001			=	[-2215.5 110.299 -190.559 0 169 0,256,"haybails"]
//				haybails_002			=	[-1686 -105 -167 -2.3614 270.938 56.9698,261,"haybails"]
//				haybails_003			=	[-1006.84 -468.572 -186.348 0 169 0,256,"haybails"]
//				haybails_004			=	[-2162 157 -128 0 169 0,256,"haybails"]
//				haybails_005			=	[-1903.48 209.871 -190.559 0 169 0,256,"haybails"]
//				haybails_006			=	[-1109.95 -228.567 -62.5586 0 169 0,256,"haybails"]
//				haybails_007			=	[-919.256 -479.963 -148.559 0 219 0,256,"haybails"]
//				haybails_008			=	[-1032 -7.38014 -148.559 -78.9552 84.8695 95.2268,256,"haybails"]
//				haybails_009			=	[-2077 -438 -118.598 0 169 0,256,"haybails"]
//				haybails_010			=	[-1376.37 301.411 -190.559 0 218 0,256,"haybails"]
			}
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
		local categoryName = tableToUse[index][7];
		local entityBuild = tADMIT[categoryName][0];
		genericSpawner(propPhysicsName, propPhysicsVector, propAngleVector, propSpawnFlag, categoryName, entityBuild);
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

Msg("Loaded: aSpawns.nut\n");