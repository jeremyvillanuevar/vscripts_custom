printl( "COOP" );
//Enables Scripted Mode: Scope and VScript Hooks and Callbacks
//CONSIDER STRIPPER RUNS AFTER VSCRIPT
//IncludeScript ("blendermode.nut");
//IncludeScript ("config.nut");
IncludeScript("VSLib");
getroottable()["WHITE"]		<- "\x01"
getroottable()["BLUE"]		<- "\x03"
getroottable()["ORANGE"]	<- "\x04"
getroottable()["GREEN"]		<- "\x05"
IncludeScript ("debug.nut");
//sm_vs_exec debug_directoroptions

::__COOP_VERSION__ <- 9.3;
::nowActivateBalance <- 1
/// Mostrar muertes de jugadores ///// Por razones de exhibición, solo se muestran los cuatro primeros
///////////////////////////////////显示玩家击杀/////因为显示原因所以只显示前四名///////////////////////////
// Interruptor de visualización de clasificación
::Show_Player_Rank<-true;                            //排行显示开关
// Si se permite la visualización de estadísticas de muerte de la computadora. Dado que el reproductor puede sobrescribir el índice de la computadora, las estadísticas de la computadora se borrarán después de que el jugador real muera y se vaya, o es posible que no se muestren directamente.
::AllowShowBotSurvivor <- false;                 //是否允许显示电脑的击杀统计。由于电脑的index可能会被玩家覆盖，所以会出现真实玩家死亡离开后电脑统计被清空，或者直接不显示的情况
// Efecto de trofeo de disparo a la cabeza//爆頭獎杯效果
// 1: On 0: Off El efecto que se muestra en la cabeza del jugador después de matar el tiro a la cabeza
::headshotcup<- 0;          //1：開啓 0：關閉  擊殺爆頭特感后顯示在玩家頭上的效果
::tankcup<- 1;          //1：開啓 0：關閉  擊殺爆頭特感后顯示在玩家頭上的效果
//SessionState now
::nowNumCansNeeded <- 0
::nowPlayersIntensity <- 0
::nowPlayersTimeAveragedIntensity <- 0
::nowPlayersinGame <- 0
::nowFinaleStarted <- 0
::nowCrescendoStarted <- 0
::nowFinaleScavengeStarted <- 0
::nowFinaleStageNum <- 0
::nowFinaleStageType <- 0
::nowFinaleStageEvent <- 0
::nowLocalScriptExec <- 0
::nowFirstPlayerinGame <- 0
::nowSpawnedTankRusher <- 0
::nowSpawnedWitch <- 0
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
::TimeTick4BossDefeatedMsg<- 0;
::nowPlayerHealer <- ""
::nowPlayerHealed <- ""
::Survivors_Count <- 0;
::GameDifficulty <- 0;

if ( (developer() > 0) || (DEBUG == 1))
{
	ClientPrint(null, 3, BLUE+"Scripted Mode");
}
