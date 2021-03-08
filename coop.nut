printl( "COOP" );
//Enables Scripted Mode: Scope and VScript Hooks and Callbacks
//CONSIDER STRIPPER RUNS AFTER VSCRIPT
//IncludeScript ("blendermode.nut");
IncludeScript ("config.nut");
IncludeScript("VSLib");
getroottable()["WHITE"]		<- "\x01"
getroottable()["BLUE"]		<- "\x03"
getroottable()["ORANGE"]	<- "\x04"
getroottable()["GREEN"]		<- "\x05"
IncludeScript ("debug.nut");

::nowPlayersIntensity <- 0
::nowPlayersTimeAveragedIntensity <- 0
::nowPlayersinGame <- 0
::nowFinaleStageNum <- 0
::nowFinaleStageType <- 0
::nowFinaleStageEvent <- 0
::nowLocalScriptExec <- 0
::nowFirstPlayerinGame <- 0
::nowPlayersinGame <- 0
::nowexecScriptName <- ""

if ( (developer() > 0) || (DEBUG == 1))
{
	ClientPrint(null, 3, BLUE+"Scripted Mode");
}
