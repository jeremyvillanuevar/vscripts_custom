//Title: The Alternate Difficulties Mod (TADM)
//Author Steam Alias: jetSetWilly II
//Author URL: https://steamcommunity.com/id/jetsetwillyuncensored/
//Version: 2.5
//Programming Language: VScript
//File Description: This is a control file that contains functions for managing map entities used by TADM

::hurtKills <- function()
{
	EntFire("ds_int-PlasterfallA2-HURT", "kill");
	EntFire("ds_int-PlasterfallA4-HURT", "kill");
	EntFire("ds_int-PlasterfallA1-HURT", "kill");
	EntFire("ds_ext-ds00_HURT", "kill");
	EntFire("ds_ext-ds02_HURT", "kill");
	EntFire("ds_ext-ds06_HURT", "kill");
	EntFire("ds_ext-ds11_HURT", "kill");
	EntFire("ds_ext-ds18_HURT", "kill");
	EntFire("ds_ext-ds19_HURT", "kill");
	EntFire("ds_ext-ds20_HURT", "kill");
	Msg("Executed: hurtKills function\n");
}

::instaKillEntities <- function(params)
{
	local ent = null;
	while (ent = Entities.FindByClassname(ent, "prop_physics"))
	{
		if (ent.IsValid())
		{
			local model = NetProps.GetPropString( ent, "m_ModelName" );
			switch (model)
			{
				case "models/props_fortifications/orange_cone001_reference.mdl":
				case "models/props_fortifications/traffic_barrier001.mdl":
				case "models/props_urban/plastic_bucket001.mdl":
					DoEntFire("!self", "Kill", "", 0.0, null, ent);
					Msg("deleted prop_physics: " + model + "\n");								
					break;
				default:
					break;
			}
		}
	}
}

//Moves and deletes various props on map load
::entityShifter <- function(params)
{
	local ent = null;
	while (ent = Entities.FindByClassname(ent, "prop_physics"))
	{
		if (ent.IsValid())
		{
			DoEntFire("!self", "Wake", "", 0.0, null, ent);
			DoEntFire("!self", "Setfriction", "", 0.4, null, ent);
			DoEntFire("!self", "Enableshadow", "", 0.0, null, ent);
			local model = NetProps.GetPropString( ent, "m_ModelName" );
			local hasNewAngle = ent.GetAngles();
			local objectToMove = 0;
			local objectToPosition = ent.GetOrigin();
			switch (model)
			{				
				case "models/props_industrial/barrel_fuel.mdl":
				case "models/props_urban/oil_drum001.mdl":
				case "models/props_c17/oildrum001.mdl":
				case "models/props_unique/haybails_single.mdl":
				case "models/props_foliage/urban_pot_clay03.mdl":
				case "models/props_unique/luggagecart01.mdl":
				case "models/props_unique/mopbucket01.mdl":
				case "models/props_street/trashbin01.mdl":
				case "models/props_urban/outhouse_door001_dm02_01.mdl":
				case "models/props_fairgrounds/Lil'Peanut_cutout001.mdl":
				case "models/props_urban/tire001.mdl":
				case "models/props_street/garbage_can.mdl":				
				case "models/props_fairgrounds/bumpercar.mdl":
				case "models/props_foliage/urban_pot_large01.mdl":
				case "models/props_foliage/urban_pot_clay01.mdl":
					hasNewAngle = RotateOrientation(ent.GetAngles(), QAngle(0,RandomFloat(0,180),0));
					objectToMove = Vector(RandomInt(0,10),RandomInt(0,10),RandomInt(10,80));
					break;
				case "models/props_junk/trashbin01a.mdl":
				case "models/props_fairgrounds/traffic_barrel.mdl":
					hasNewAngle = RotateOrientation(ent.GetAngles(), QAngle(0,RandomFloat(0,180),0));
					if(!physicsMapTarget_001 == 3)
					{
						objectToMove = Vector(RandomInt(0,2),RandomInt(0,2),RandomInt(30,80));
					}
					DoEntFire("!self", "Enablemotion", "", 0.0, null, ent);
					DoEntFire("!self", "enablecollision", "", 0.0, null, ent);
					break;
				case "models/props_urban/shopping_cart001.mdl":
				case "models/props_urban/props_urban/round_table001.mdl":
					hasNewAngle = RotateOrientation(ent.GetAngles(), QAngle(RandomFloat(0,180),RandomFloat(0,180),RandomFloat(0,180)));
					objectToMove = Vector(RandomInt(0,2),RandomInt(0,2),RandomInt(20,40));
					DoEntFire("!self", "enablecollision", "", 0.0, null, ent);
					DoEntFire("!self", "Enablemotion", "", 0.0, null, ent);
					break;
				case "models/props_street/mail_dropbox.mdl":
					hasNewAngle = RotateOrientation(ent.GetAngles(), QAngle(0,RandomFloat(0,3),0));
					objectToMove = Vector(RandomInt(0,2),RandomInt(0,2),RandomInt(10,80));
					break;
				case "models/props_office/vending_machine01.mdl":
					hasNewAngle = RotateOrientation(ent.GetAngles(), QAngle(0,RandomFloat(0,180),0));
					objectToMove = Vector(RandomInt(0,2),RandomInt(0,2),RandomInt(10,20));
					break;				
				case "models/props_fortifications/orange_cone001_reference.mdl":
				case "models/props_fortifications/traffic_barrier001.mdl":
					DoEntFire("!self", "Kill", "", 0.0, null, ent);
					Msg("deleted prop_physics: " + model + "\n");
					//hasNewAngle = RotateOrientation(ent.GetAngles(), QAngle(RandomFloat(0,180),RandomFloat(0,180),RandomFloat(0,180)));
					//objectToMove = Vector(RandomInt(0,2),RandomInt(0,2),RandomInt(10,80));					
					break;
				
				case "models/props_interiors/chair_thonet.mdl":
				case "models/props_interiors/table_motel.mdl":
					hasNewAngle = RotateOrientation(ent.GetAngles(), QAngle(0,RandomFloat(0,180),0));
					objectToMove = Vector(RandomInt(0,10),RandomInt(0,10),RandomInt(40,80));
					DoEntFire("!self", "Enablemotion", "", 0.0, null, ent);
					if(RandomInt(1,4) == 4)
					{
						DoEntFire("!self", "Kill", "", 0.0, null, ent);
						Msg("deleted prop_physics: " + model + "\n");
					}
					break;
				case "models/props_vehicles/cara_82hatchback.mdl":
				case "models/props_vehicles/cara_84sedan.mdl":
				case "models/props_vehicles/cara_69sedan.mdl":
				case "models/props_vehicles/cara_95sedan.mdl":
				case "models/props_vehicles/airport_baggage_cart2.mdl":
				case "models/props_vehicles/airport_baggage_tractor.mdl":
				case "models/props_vehicles/car002a_physics.mdl":
				case "models/props_vehicles/car001a_phy.mdl":
				case "models/props_vehicles/car002b_physics.mdl":
				case "models/props_vehicles/car001b_phy.mdl":
				case "models/props_vehicles/car003a_physics.mdl":
				case "models/props_vehicles/car003b_physics.mdl":
				case "models/props_vehicles/car004a_physics.mdl":
				case "models/props_vehicles/car004b_physics.mdl":
				case "models/props_vehicles/car005a_physics.mdl":
				case "models/props_vehicles/car005b_physics.mdl":
					hasNewAngle = RotateOrientation(ent.GetAngles(), QAngle(0,RandomFloat(0,5),0));
					objectToMove = Vector(RandomInt(-2,2),RandomInt(-2,2),RandomInt(5,10));
					DoEntFire("!self", "setgravity", "", 2.0, null, ent);
					DoEntFire("!self", "setfriction", "", 0.5, null, ent);
					DoEntFire("!self", "massScale", "", 5.0, null, ent);
					break;
				case "models/props_vehicles/cara_82hatchback_wrecked.mdl":
				case "models/props_vehicles/cara_95sedan_wrecked.mdl":
				case "models/props_vehicles/tire001a_tractor.mdl":
				case "models/props_vehicles/tire001b_truck.mdl":
				case "models/props_vehicles/tire001c_car.mdl":
				case "models/props_vehicles/zapastl.mdl":
					ent.SetGravity(2);
					ent.SetFriction(0.5);
					break;
				case "models/props_urban/plastic_chair001.mdl":
					if (physicsMapTarget_001 == 0)
					{
						hasNewAngle = RotateOrientation(ent.GetAngles(), QAngle(RandomFloat(0,180),RandomFloat(0,180),RandomFloat(0,180)));
						objectToMove = Vector(RandomInt(0,2),RandomInt(0,2),RandomInt(40,80));
						DoEntFire("!self", "enablecollision", "", 0.0, null, ent);
						DoEntFire("!self", "Enablemotion", "", 0.0, null, ent);
					}
					break;
				default:
					break;
			}
			if (objectToMove != 0)
			{
				ent.SetForwardVector(hasNewAngle.Forward());
				ent.SetOrigin(objectToPosition + objectToMove);
				Msg("Shifted " + model + "\n");
				if(RandomInt(1,4) == 4)
				{
					DoEntFire("!self", "Kill", "", 0.0, null, ent);
					Msg("deleted prop_physics: " + model + "\n");
				}
			}
		}
	}

	//These 3 models do not look good with their shadows turned on so this makes sure they are always turned off regardless
	local ent = null;
	while (ent = Entities.FindByClassname(ent, "prop_dynamic"))
	{
		if (ent.IsValid())
		{
			local model = NetProps.GetPropString( ent, "m_ModelName" );
			switch (model)
			{
				case "models/props_fairgrounds/garbage_pile_corner01.mdl":
				case "models/props_fairgrounds/garbage_pile_straight02.mdl":
				case "models/props_fairgrounds/garbage_pile02.mdl":
					DoEntFire("!self", "Disableshadow", "", 0.0, null, ent);
					break;
				default:
					break;
			}
		}
	}

	if(physicsMapTarget_001 == 1)
	{
		//delete some green bins that interfer with players route because of the randomizer
		local ent = null;
		local searchOriginLocation = Vector(2922, -1550, 0);
		while(ent = Entities.FindByClassnameWithin(ent, "prop_physics",searchOriginLocation,cRSA))
		{
			if (ent.IsValid())
			{
				DoEntFire("!self", "kill", "", 0.0, null, ent);
			}
		}
		//delete some bins I don't want (next to gnome chompski game)
		local ent = null;
		local specificSearchArea = 150.0;
		local searchOriginLocation = Vector(3090, -631, 0);
		while(ent = Entities.FindByClassnameWithin(ent, "prop_physics",searchOriginLocation,specificSearchArea))
		{
			if (ent.IsValid())
			{
				DoEntFire("!self", "kill", "", 0.0, null, ent);
			}
		}
		//make the forklift go back to sleep to stop it sinking into the ground
		local ent = null;
		while (ent = Entities.FindByModel(ent, "models/props/cs_assault/forklift.mdl"))
		{
			if (ent.IsValid())
			{
				DoEntFire("!self", "Sleep", "", 0.0, null, ent);
			}
		}
		//pick one of the two forklifts to be deleted
		local ent = null;
		if (RandomInt(0,1) == 0)
		{
			selectVector = Vector(2442, -1660, 0);
		}
		else
		{
			selectVector = Vector(2130, -1150, 0);
		}
		local searchOriginLocation = selectVector;
		while(ent = Entities.FindByClassnameWithin(ent, "prop_physics",searchOriginLocation,cRSA))
		{
			if (ent.IsValid())
			{
				DoEntFire("!self", "kill", "", 0.0, null, ent);
			}
		}
	}
	local ent = null;
	while (ent = Entities.FindByModel(ent, "models/props_mill/pipeset08d_corner128d_001a.mdl"))
	{
		if (ent.IsValid())
		{
			DoEntFire("!self", "Disablemotion", "", 0.0, null, ent);
		}
	}
	Msg("Executed: physicsEntityShifter function\n");
}

::mountedBarrierRandomizer <- function(params)
{
	//This uses an script external variable (cvar) to set an internal variable (shutdownCheck) on the case that a map restart has occured
	if(Convars.GetFloat("director_short_finale") == 1)
	{
		//sets the variable to 1 so we know a restart has occured
		shutdownCheck = 1;
		//resets the cvar back so it does not interfer with gameplay
		Convars.SetValue("director_short_finale" , "0");
	}

	//cornfield finale mounted gun randomizer
	if (shutdownCheck == 0)
	{
		local formulaForWorkingGun = 10 - dAAN * 2
		local chanceOfWorkingMountedGun_006 = RandomInt(1,formulaForWorkingGun)
		if(chanceOfWorkingMountedGun_006 == 1)
		{
			EntFire("mountedBroken_006", "kill");
		}
		else
		{
			EntFire("mountedWorking_006", "kill");
		}
		local formulaForWorkingGun = 10 - dAAN * 2
		local chanceOfWorkingMountedGun_007 = RandomInt(1,formulaForWorkingGun)
		if(chanceOfWorkingMountedGun_007 == 1)
		{
			EntFire("mountedBroken_007", "kill");
		}
		else
		{
			EntFire("mountedWorking_007", "kill");
		}
	}

	if (shutdownCheck == 0 && SessionState.MapName == "c5m5_bridge")
	{
		if(RandomInt(0,1) == 1)
		{
			local mountedGunBridgeMapSearchLocation = Vector(9646, 4104, 541);
			local ent = null;	
			while(ent = Entities.FindByClassnameWithin(ent, "prop_minigun",mountedGunBridgeMapSearchLocation,cRSA))
			{
				if (ent.IsValid())
				{
					DoEntFire("!self", "kill", "", 0.0, null, ent);
				}
			}
		}
		else
		{
			EntFire("mountedBroken_008", "kill");
		}
	}

	//this is for the original mounted gun on the bridge (unmodded), it makes sure that if the mounted gun was deleted in the first run through that it doesn't respawn if the survivors die on the bridge (onMapReload or Restart)
	//so it looks to see if the broken mounted gun model exists and if so then we know that the working mounted gun was killed on the first play through and therefore it should be deleted again to stop it from respawning on top of the broken mounted gun model on a map restart
	if (shutdownCheck != 0 && SessionState.MapName == "c5m5_bridge")
	{
		local ent = null;
		local mountedGunBridgeMapSearchLocation = Vector(9646, 4104, 541);
		//lets look for a prop_dynamic exactly where the 50_cal_broken.mdl should be on the bridge (if the working mounted gun existed on the first play through then it will not get past this check as the broken prop was already deleted)
		while(ent = Entities.FindByClassnameWithin(ent, "prop_dynamic",mountedGunBridgeMapSearchLocation,cRSA))
		{
			local model = NetProps.GetPropString( ent, "m_ModelName" );
			//if it finds the broken 50 cal model
			if (model == "models/w_models/weapons/50_cal_broken.mdl")
			{
				local ent = null;
				//then lets find the working 50 cal mounted gun
				while(ent = Entities.FindByClassnameWithin(ent, "prop_minigun",mountedGunBridgeMapSearchLocation,cRSA))
				{
					if (ent.IsValid())
					{
						//and kill it so they don't both exist on top of each other
						DoEntFire("!self", "kill", "", 0.0, null, ent);
					}
				}
			}
		}
	}

	//plantation mounted gun controller, sets up the mounted gun configuration
	if (SessionState.MapName == "c3m4_plantation" && shutdownCheck == 0)
	{
		if (RandomInt(1,2) == 2)
		{
			//select the gun in the house and the broken gun model on the ground
			mapSearchLocation = Vector(1661, 583, 438);
			brokenGunCounter = "plantationGunBroken_001"
		}
		else
		{
			//select the gun in the garden and the broken gun model in the house
			mapSearchLocation = Vector(2670, 709, 149);
			brokenGunCounter = "plantationGunBroken_002"
		}
		local ent = null;
		//using the previously randomly selected gun and broken model its time to delete
		while(ent = Entities.FindByClassnameWithin(ent, "prop_minigun",mapSearchLocation,cRSA))
		{
			if (ent.IsValid())
			{
				DoEntFire("!self", "kill", "", 0.0, null, ent);
				EntFire(brokenGunCounter, "kill");
			}
		}
	}

	//checks to see if the mounted gun in the garden is the non broken variety on restarts only
	if (SessionState.MapName == "c3m4_plantation" && shutdownCheck != 0)
	{
		local plantationMapSearchLocation = Vector(2670, 709, 149);
		local ent = null;
		while(ent = Entities.FindByClassnameWithin(ent, "prop_minigun",plantationMapSearchLocation,cRSA))
		{
			if (ent.IsValid())
			{
				plantationMountedNoDeleteGun = 1
			}
		}
	}

	//if the gun in the garden is working then delete the one in the house on restarts only
	if (plantationMountedNoDeleteGun == 1)
	{
		local gunToKillSearchLocation = Vector(1661, 583, 438);
		local ent = null;
		local specificSearchArea = 100.0;	
		while(ent = Entities.FindByClassnameWithin(ent, "prop_minigun",gunToKillSearchLocation,specificSearchArea))
		{
			if (ent.IsValid())
			{
				DoEntFire("!self", "kill", "", 0.0, null, ent);
			}
		}
	}

	//The Parish park map barrier controller
	if (SessionState.MapName == "c5m2_park" && shutdownCheck == 0)
	{
		local randomBarrierKill = RandomInt(1,3);
		switch (randomBarrierKill)
		{
			case 1:
				EntFire("barricade_001", "kill");
				break;
			case 2:
				EntFire("barricade_002", "kill");
				break;
			case 3:
				EntFire("barricade_001", "kill");
				EntFire("barricade_002", "kill");
				break;
			default:
			Msg("Defaulted: barrier removal\n");
				break;
		}
	}

	//This is to randomly delete the column that has been added to stop players turning off the alarm
	if (SessionState.MapName == "c1m3_mall" && shutdownCheck == 0)
	{
		Convars.SetValue("director_gas_can_density" , "20");
		if (RandomInt(1,dAAN) == 1)
		{
			EntFire("mall_barrier_001", "kill");
			EntFire("bonusMallAmmo", "kill");
		}
	}	

	//mounted gun randomizer four finales, see table mCUBMFT
	if (shutdownCheck == 0)
	{
		local checkFinaleMapname = SessionState.MapName;
		if (checkFinaleMapname in mCUBMFT)
		{
			if(RandomInt(1,2) == 1)
			{
				EntFire("prop_minigun_l4d1", "kill");
				EntFire("mountedBroken_005", "kill");
			}
			else
			{
				EntFire("mountedWorking_005", "kill");
			}
		}
		else
		{
			if (RandomInt(1,2) == 2)
			{
				EntFire("prop_minigun_l4d1", "kill");
				EntFire("mountedBroken_001", "kill");
			}
			else
			{
				EntFire("mountedWorking_001", "kill");
			}
			if (RandomInt(1,2) == 2)
			{
				EntFire("mountedBroken_002", "kill");
			}
			else
			{
				EntFire("mountedWorking_002", "kill");
			}
			if (RandomInt(1,2) == 2)
			{
				EntFire("mountedBroken_003", "kill");
			}
			else
			{
				EntFire("mountedWorking_003", "kill");
			}
		}
	}

	//Since the map will reload with the original minigun placement this checks to see if the l4d2 gun was selected by this mod to appear and if so then always delete the original gun
	if (shutdownCheck != 0)
	{	
		local checkFinaleMapname = SessionState.MapName;
		if (checkFinaleMapname in mCUBMFT)
		{
			local finaleMapSearchLocation = Vector(mCUBMFT[checkFinaleMapname][0], mCUBMFT[checkFinaleMapname][1], mCUBMFT[checkFinaleMapname][2]);
			local ent = null;
			while(ent = Entities.FindByClassnameWithin(ent, "prop_minigun",finaleMapSearchLocation,cRSA))
			{
				if (ent.IsValid())
				{
					EntFire("prop_minigun_l4d1", "kill");
				}
			}
		}
	}
	Msg("Executed: mountedBarrierRandomizer function\n");
}
Msg("Loaded: aEnt.nut\n");