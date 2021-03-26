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