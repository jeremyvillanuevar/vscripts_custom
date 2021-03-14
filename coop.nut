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

//SessionState now
::nowPlayersIntensity <- 0
::nowPlayersTimeAveragedIntensity <- 0
::nowPlayersinGame <- 0
::nowFinaleScavengeStarted <- 0
::nowFinaleStageNum <- 0
::nowFinaleStageType <- 0
::nowFinaleStageEvent <- 0
::nowLocalScriptExec <- 0
::nowFirstPlayerinGame <- 0
::nowexecScriptName <- ""
::nowStartConnectionsnum <- 0
::nowStartConnections <-  []
::nowPlayerEvent <- ""
::nowPlayerJoined <- ""
::nowPlayerLeft <- ""
//ShowPlayerState now
::PlayerKillCout <- {}; 
::PlayerRandCout <- {}; 
::PlayerRankLine <- {}; 
::KillsCout <- 0;
::removed_common_spawns <- false;
::ClearEdicts<- false;
::Time4Connections <- 54;
::Time4TimerWitch <- 60;
::Time4TimerRusher <- 0;
::Time4Tick <- 0;
::TimeTick4Rescue <- 0;
::TimeTick4ConnectMsg <- 0;
::TimeTick4BossMsg <- 0;
::TimeTick4WitchMsg <- 0;
::TimeTick4PanicMsg <- 0;
::TimeTick4HealMsg<- 0;
::nowPlayerHealer <- ""
::nowPlayerHealed <- ""
//::Client_Count <- 0;
::Survivors_Count <- 0;
::GameDifficulty <- 0;

if ( (developer() > 0) || (DEBUG == 1))
{
	ClientPrint(null, 3, BLUE+"Scripted Mode");
}
