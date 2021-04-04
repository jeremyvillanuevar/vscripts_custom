//Title: The Alternate Difficulties Mod (TADM)
//Home: https://steamcommunity.com/sharedfiles/filedetails/?id=1578912994
//Author Steam Alias: jetSetWilly II
//Author URL: https://steamcommunity.com/id/jetsetwillyuncensored/
//Version: 2.3
//Programming Language: VScript
//Libraries: VSLibs
//Lease: STEAM® SUBSCRIBER AGREEMENT (published on Steam Workshop)
//File Description: This is the execution file that determines which files will be used by TADM
//Notes: Best viewed in Notepad++. The a at the start of every file is for alternate

//ADM MOD CVAR METHOD
//File Description: This is a data file that initialises most of the global variables used by TADM and Tables
IncludeScript("aVar");
//File Description: This is a control and data file that contains functions that are called from timers
IncludeScript("aTFunc");
//File Description: This is a data file that initialises variables used for indexing arrays and tables
IncludeScript("aIndice");
//File Description: This is a control file that contains functions for managing map entities used by TADM
IncludeScript("aEnt");
//File Description: This is a data file that holds all of the spawn tables used by TADM
IncludeScript("aSpawns");
//FRAMEWORK
IncludeScript ("modifydirector.nut");
IncludeScript ("announcedirector.nut");
IncludeScript ("showplayers.nut");
//File Description: This is a control file that contains all of the functions that respond to game events used by TADM
IncludeScript ("hooks.nut");

/*
IncludeScript("aVar");
IncludeScript("aArray");
IncludeScript("aTables");
IncludeScript("aSpawns");
IncludeScript("aCvar");
IncludeScript("aEnt");
IncludeScript("aInfc");
IncludeScript("aFinale");
IncludeScript("aFunc");
IncludeScript("aOnslaught");
IncludeScript("aMap");
*/


Msg("Loaded: server.nut\n");

if (DEDICATED == 0)
{
	printl ( "Loaded Dynamic-Timelapse V1.0");
	printl ( "By Solved");

	Convars.SetValue("cl_glow_brightness", 1);
	Convars.SetValue("fog_override", 1);
	Convars.SetValue("fog_start", 1);
	Convars.SetValue("fog_end", 1);
	Convars.SetValue("fog_startskybox", 1);
	Convars.SetValue("r_flashlightfov", 40);
	Convars.SetValue("r_flashlightfar", 2000);
	Convars.SetValue("r_farz", 10000);
	Convars.SetValue("fog_color" , 0.0.0);
	Convars.SetValue("fog_colorskybox" , 0.0.0);

	::DRTTimeTable <-
	{
		DRTNumber = 0.000
	}

	::DRTSkybox <- Entities.FindByClassname (null, "worldspawn");
	::DRTTest <- true;
	::DRTTest2 <- false;
	::DRTlast_set <- 0;

	function Notifications::OnServerPreShutdown::DRTSps (reason, params)
	{
		ClearSavedTables()
		printl("Clear Table DRTSps");
	}

	function Notifications::OnFinaleWin::DRTOfw (map_name, diff, params)
	{
		ClearSavedTables()
		printl("Clear Table DRTOfw");
	}


	function VSLib::EasyLogic::Update::DRTOptimized()
	{

	local ent = null

		if(Time() >= DRTlast_set + 2)
		{
			
			if(DRTTest == true)
			{
			printl(DRTTimeTable.DRTNumber);
			
			DRTTimeTable.DRTNumber+= 0.001;
				if( DRTTimeTable.DRTNumber <= 0.996)
				{
					Convars.SetValue("fog_maxdensity" , DRTTimeTable.DRTNumber);
					Convars.SetValue("fog_2dskyboxfogfactor" , DRTTimeTable.DRTNumber);
					Convars.SetValue("fog_2dskyboxfogfactor" , DRTTimeTable.DRTNumber);
				}
				
				if( DRTTimeTable.DRTNumber >= 0.996)
				{
					::DRTTest <- false;
					
					::DRTTimer <- Timers.AddTimer(240.0, false, ChangeDRTValue);
					printl("timer Started");
				}

				if( DRTTimeTable.DRTNumber >= 0.990 )
				{
					while((ent = Entities.FindByClassname(ent,"env_sun")) != null)
					{
						if(ent && ent.IsValid())
						DoEntFire("!self","TurnOff","0",0,null,ent);
					}
				}
				
				if( DRTTimeTable.DRTNumber > 0.997 )
				{
					DRTTimeTable.DRTNumber = 0.995
				}
			}

			// Second Part
			
			if(DRTTest2 == true)
			{
		
			if ( (developer() > 0) || (DEBUG == 1))
			{
				printl(DRTTimeTable.DRTNumber);
			}
			
			
			DRTTimeTable.DRTNumber-= 0.001;
			
				if( DRTTimeTable.DRTNumber <= 0.996)
				{
					Convars.SetValue("fog_maxdensity" , DRTTimeTable.DRTNumber);
					Convars.SetValue("fog_2dskyboxfogfactor" , DRTTimeTable.DRTNumber);
					Convars.SetValue("fog_2dskyboxfogfactor" , DRTTimeTable.DRTNumber);
				}
				
				if( DRTTimeTable.DRTNumber <= 0.1)
				{
					::DRTTest <- true;
					::DRTTest2 <- true;
				}
				
				if( DRTTimeTable.DRTNumber <= 0.990 )
				{
					while((ent = Entities.FindByClassname(ent,"env_sun")) != null)
					{
						if(ent && ent.IsValid())
						DoEntFire("!self","TurnOn","0",0,null,ent);
					}
				}
				
				if( DRTTimeTable.DRTNumber > 0.997 )
				{
					DRTTimeTable.DRTNumber = 0.995	
				}
			}
		DRTlast_set = Time();
		SaveTable("DRTTimeTable" , DRTTimeTable)
		
			if(DRTTimeTable.DRTNumber > 0.980)
			{
			//printl("Flashlight Night");
			Convars.SetValue("r_flashlightbrightness", 7.5);
			}
			else if(DRTTimeTable.DRTNumber < 0.980)
			{
			//printl("Flashlight Day");
			Convars.SetValue("r_flashlightbrightness", 0.5);
			}
		}
		
	}

	::ChangeDRTValue <- function ( args )
	{

		::DRTTest2 <- true;
		Timers.RemoveTimer ( DRTTimer );
	}


	function Notifications::OnRoundStart::RandomTimeOffDayDRT ()
	{

	RestoreTable("DRTTimeTable" , DRTTimeTable)

	if( DRTTimeTable.DRTNumber >= 0.997)
	{
		DRTTimeTable.DRTNumber = 0.995
	}

	if( DRTTimeTable.DRTNumber >= 0.250)
	{
		DRTSkybox.__KeyValueFromString("skyname","sky_l4d_c1_1_hdr");
		//printl("Morning");
	}
		if( DRTTimeTable.DRTNumber >= 0.500)
		{
			DRTSkybox.__KeyValueFromString("skyname","sky_l4d_predawn02_hdr");
			//printl("Afternoon");
		}
			if( DRTTimeTable.DRTNumber >= 0.750 )
			{
				DRTSkybox.__KeyValueFromString("skyname","sky_l4d_c4m1_hdr");
				//printl("Dawn");
			}
				if( DRTTimeTable.DRTNumber >= 0.997 )
				{
					DRTSkybox.__KeyValueFromString("skyname","sky_l4d_c4m4_hdr");
					//printl("Night");
				}
	}
}