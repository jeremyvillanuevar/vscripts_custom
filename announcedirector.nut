printl( "\n\n\n\n==============ANNOUNCE DIRECTOR STATUS ===============\n\n\n\n");
//-----------------------------------------------------
//

//Ejecutado a cada rato
function VSLib::EasyLogic::Update::AnnounceUpdate()
{
	if (nowFinaleStageEvent)
	{
		nowFinaleStageEvent = 0
		OnCustomFinaleStageChangeHook()
	}
}
function Notifications::OnPanicEvent::Iniciado(entity, params)
{
	ClientPrint(null, 3, BLUE+"HORDA INMINENTE: Derroten juntos a la horda!");
}
function Notifications::OnPanicEventFinished::Finalizado()
{
	ClientPrint(null, 3, BLUE+"GENIAL! Ustedes derrotaron la horda!!");
	foreach( survivor in ::VSLib.EasyLogic.Players.Survivors() )//gives a Player
	{		
		//if(survivor.IsBot())
		//	continue;
		local achTemp="achieved"
		AttachParticleCongrats(survivor,achTemp, 3.0);
		if (survivor.GetCharacterName() =="Zoey")
			survivor.Speak( "hurrah54", 0 )
		else
			survivor.Speak( "hurrah01", 0 )
	}	
	/*
player <- null;
while(player = Entities.FindByClassname(player, "player"))   // Iterate through the script handles of the players.
{
    DoEntFire("!self", "speakresponseconcept", "PlayerLaugh", 0, null, player); // Make each player laugh.
}
*/
}


function Notifications::OnFinaleStart::Final(campaign, params)
{
	ClientPrint(null, 3, BLUE+"Comenzando el Finale de la Campaña: " + campaign);	
	if ( "A_CustomFinale_StageCount" in DirectorScript.MapScript.DirectorOptions )
	{
		ClientPrint(null, 3, BLUE+"Esta vez tienen " + DirectorScript.MapScript.DirectorOptions.A_CustomFinale_StageCount+" etapas para ser rescatados.");	
	}
}


function Notifications::OnFinaleWin::Final(map_name, diff, params)
{
	ClientPrint(null, 3, BLUE+"FELICIDADES lograron: " + map_name);	
	if ( "A_CustomFinale_StageCount" in DirectorScript.MapScript.DirectorOptions )
	{
		Timers.RemoveTimerByName ( "OnBeginCustomFinaleStageTimer" );
	}
}

::OnCustomFinaleStageChangeHook <- function ( )
{
	if ( "A_CustomFinale_StageCount" in DirectorScript.MapScript.DirectorOptions )		
		DirectorScript.MapScript.DirectorOptions.MaxSpecials <-  1+1*Client_Count;
	else
		DirectorScript.MapScript.DirectorOptions.MaxSpecials <- 1+1*Client_Count;	
	if (nowFinaleStageNum < DirectorScript.MapScript.DirectorOptions.A_CustomFinale_StageCount )
		ClientPrint(null, 3, BLUE+"Comenzando el Finale: Fase " + nowFinaleStageNum + " de " + DirectorScript.MapScript.DirectorOptions.A_CustomFinale_StageCount + " fases. Tipo " + nowFinaleStageType);
	else 
		ClientPrint(null, 3, BLUE+"Enhorabuena, el vehículo ha llegado, procura que todos entren!");
}
	
	
::AttachParticleCongrats <- function(ent,particleName = "", duration = 0.0)
{	
	if (particleName==null)
		particleName="achieved"
	local particle = g_ModeScript.CreateSingleSimpleEntityFromTable({ classname = "info_particle_system", targetname = "info_particle_system" + UniqueString(), origin = ent.GetEyePosition(), angles = QAngle(0,0,0), start_active = true, effect_name = particleName });
	if (!particle)
	{
		printl("Advertencia: No se pudo crear la entidad de partículas.");
		//printl("警告:创建粒子实体失败.");
		return;
	}
	DoEntFire("!self", "Start", "", 0, null, particle);
	DoEntFire("!self", "Kill", "", duration, null, particle);
	AttachOther(PlayerInstanceFromIndex(ent.GetIndex()),particle, true,ent.GetEyePosition());
}