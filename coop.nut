printl( "COOP" );
//Enables Scripted Mode: Scope and VScript Hooks and Callbacks
//CONSIDER STRIPPER RUNS AFTER VSCRIPT
//IncludeScript ("blendermode.nut");
//IncludeScript ("config.nut");
IncludeScript("vslib");
getroottable()["WHITE"]		<- "\x01"
getroottable()["BLUE"]		<- "\x03"
getroottable()["ORANGE"]	<- "\x04"
getroottable()["GREEN"]		<- "\x05"
IncludeScript ("debug.nut");
//sm_vs_exec debug_directoroptions

::initializeBeforeAllFrameworkGlobalVariables <- function()
{
	::nowexecScriptName <- ""
	::nowLocalScriptExec <- 0
	::nowWanderingPermit <- true;
	::nowflTeleportRusher <- true;
	::nowflTeleportSlacker <- true;
	::nowflSpeedAhead <- true;
	::nowflSpeedBehind <- true;
	::nowflTankAhead <- true;
}

if ( (developer() > 0) || (DEBUG == 1))
{
	ClientPrint(null, 3, BLUE+"Scripted Mode");
}
initializeBeforeAllFrameworkGlobalVariables();