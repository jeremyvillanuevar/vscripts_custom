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
	::nowinScriptfromaMap <- false;
	::nowWanderingPermit <- true;
	::nowflTeleportRusher <- true;
	::nowflTeleportSlacker <- true;
	::nowflSpeedAhead <- true;
	::nowflSpeedBehind <- true;
	::nowflTankAhead <- true;
	::survivorlist <-[];
	::speedlist <-[];
	::flowlist <-[];
	::countflow<- 0;
	
	::timerIndex1<- 0;
	::timerIndex2<- 0;
	::timerIndex3<- 0;
}

if ( (developer() > 0) || (DEBUG == 1))
{
	ClientPrint(null, 3, BLUE+"Scripted Mode");
}
initializeBeforeAllFrameworkGlobalVariables();