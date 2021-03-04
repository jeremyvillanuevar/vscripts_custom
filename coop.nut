printl( "COOP" );
//Enables Scripted Mode: Scope and VScript Hooks and Callbacks
IncludeScript ("config.nut");
IncludeScript("VSLib");
IncludeScript ("showplayers.nut");
//CONSIDER STRIPPER RUNS AFTER VSCRIPT
//IncludeScript ("blendermode.nut");
getroottable()["WHITE"]		<- "\x01"
getroottable()["BLUE"]		<- "\x03"
getroottable()["ORANGE"]	<- "\x04"
getroottable()["GREEN"]		<- "\x05"
getroottable()["DEBUG"] <- 0

::nowFinaleStageNum <- 0
::nowFinaleStageType <- 0
::nowFinaleStageEvent <- 0

if ( (developer() > 0) || (DEBUG == 1))
{
	ClientPrint(null, 3, BLUE+"Scripted Mode");
}
