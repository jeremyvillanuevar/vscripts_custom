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
	ClientPrint(null, 3, BLUE+"HORDA: Se apróxima una, derroten juntos a la horda!");
}
function Notifications::OnPanicEventFinished::Finalizado()
{
	ClientPrint(null, 3, BLUE+"GENIAL! Ustedes lo hicieron!!");
	foreach( survivor in ::VSLib.EasyLogic.Players.Survivors() )//gives a Player
	{		
		if(survivor.IsBot())
			continue;	
		if (survivor.GetCharacterName() =="Zoey")
			survivor.Speak( "hurrah54", 0 )
		else
			survivor.Speak( "hurrah01", 0 )
	}	
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
	
	