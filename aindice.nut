//Title: The Alternate Difficulties Mod (TADM)
//Author Steam Alias: jetSetWilly II
//Author URL: https://steamcommunity.com/id/jetsetwillyuncensored/
//Version: 2.5
//Programming Language: VScript
//File Description: This is a data file that initialises variables used for indexing arrays and tables
//Special Note: Most indicies functions that are constantly looked up with a timer will be found in the atfunc.nut file


::initializeDifficulty <- function()
{
	//difficultyAsAWord
	dAAW = Convars.GetStr("z_difficulty").tolower();
	//difficultyAsANumber
	dAAN = iTODT[dAAW][0]
	dAANMA = dAAN*2-1;
	dAANMI = dAAN*2-2;
	dAANNR = dAAN-1;
	Msg("Executed: initializeTierOfDifficulty function\n");
}

::initializeGameMode <- function()
{	
	gMV = Convars.GetStr("mp_gamemode").tolower();
	Msg("Executed: initializeGameMode function\n");
}

::initializeTierOfDifficulty <- function()
{
	//difficultyAsAWord
	dAAW = Convars.GetStr("z_difficulty").tolower();
	local tierPosition = RandomInt(1, iTODT[dAAW][0])
	//tierOfDifficulty
	tOD = iTODT[dAAW][tierPosition]
	//difficultyAsANumber
	dAAN = iTODT[dAAW][0]
	//tierOfDifficultyMAx
	tODMA = tOD*2-1;
	//tierOfDifficultyMIn
	tODMI = tOD*2-2;
	//tierOfDifficultyNonRandom
	tODNR = tOD-1;
	dAANMA = dAAN*2-1;
	dAANMI = dAAN*2-2;
	dAANNR = dAAN-1;
	Msg("Executed: initializeTierOfDifficulty function\n");
}

//a basic breakpoint system that compares the current average distance (gASFD) through a map to defined distances in an array (fDCA). The index is used as the breakpoint for average player flow
::flowDistanceCalculator <- function(params)
{
	local gASFD = GetAverageSurvivorFlowDistance();
	foreach(index, item in fDCA)
	{	
		if(gASFD > fDCA[index] && gASFD < gFDA[index])
		{
			gFD = index;
			break;
		}
	}
	Msg("Flow Distance Averaged Breakpoint = " + gFD + "\n");
	Msg("Executed: flowDistanceCalculator function\n");
}

//Separates maps into 2 types (gauntlet and open area), night and day, then breaks each type into difficulties
::establishMapType <- function()
{
	local thisMapNameIs = SessionState.MapName;	
	if(thisMapNameIs in eMTVT)
	{
		mAAN = eMTVT[thisMapNameIs][0]
		mINOD = eMTVT[thisMapNameIs][1]
		physicsMapTarget_001 = eMTVT[thisMapNameIs][2]
		miniFinalDirectorNoSet = eMTVT[thisMapNameIs][3]
		whichMapHasCanGames = eMTVT[thisMapNameIs][4]
		isAFinale = eMTVT[thisMapNameIs][5]
		noCSWeps = eMTVT[thisMapNameIs][6]
	}
	Msg("Executed: establishMapType function\n");
}

::multiTankRandomizerIndice <- function(params)
{
	xtroTanks = 19 - dAAN
	Msg("xtroTanks = " + xtroTanks + "\n");
}

//Variables used as indexes when specials and tanks spawn
::alterMonsterIndices <- function(params)
{
	alterMonster = RandomInt(1,3);
	aMI = alterMonster*2-2;
	aMA = alterMonster*2-1;
	aMR = alterMonster*3-3;
	aMG = alterMonster*3-2;
	aMB = alterMonster*3-1;
	aMN = alterMonster-1;
}

Msg("Loaded: aIndice.nut\n");