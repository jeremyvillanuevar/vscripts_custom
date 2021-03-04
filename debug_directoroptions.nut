//======== Copyright (c) 2009, Valve Corporation, All rights reserved. ========
//
//=============================================================================
printl( "Debugging Director Options" );
		
printl( "\nKeys Find on ChallengeScript ifnot in LocalScript,MapScript,DirectorScript" );
if ( "DirectorOptions" in DirectorScript )
{
	Msg( "\n*****\nDS 1 DirectorScript.DirectorOptions:\n" );
	foreach( key, value in DirectorScript.DirectorOptions )
	{
		Msg( "    " + key + " = " + value + "\n" );
	}		
}else	
	Msg( "\n*****\nNO HAY 1 DirectorScript.DirectorOptions:\n" );
	
	
if ( DirectorScript.MapScript.rawin( "DirectorOptions") )
{
	Msg( "\n*****\nMAP 2 DirectorScript.MapScript.DirectorOptions:\n" );
	foreach( key, value in DirectorScript.MapScript.DirectorOptions )
	{
		Msg( "    " + key + " = " + value + "\n" );
	}
}
else
	Msg( "\n*****\nNO HAY 2 DirectorScript.MapScript.DirectorOptions:\n" );
	

if ( DirectorScript.MapScript.LocalScript.rawin( "DirectorOptions") )
{
	Msg( "\n*****\nLOCAL 31 DirectorScript.MapScript.LocalScript.DirectorOptions:\n" );
	foreach( key, value in DirectorScript.MapScript.LocalScript.DirectorOptions )
	{
		Msg( "    " + key + " = " + value + "\n" );
	}
}
else
	Msg( "\n*****\nNO HAY 31 DirectorScript.MapScript.LocalScript.DirectorOptions:\n" );


if ( DirectorScript.MapScript.ChallengeScript.rawin( "DirectorOptions" ) )
{
	Msg( "\n*****\nMODE 32 Y GLOBAL SCRIPTED MODE ACTIVADO DirectorScript.MapScript.ChallengeScript.DirectorOptions:\n" );
	foreach( key, value in DirectorScript.MapScript.ChallengeScript.DirectorOptions )
	{
		Msg( "    " + key + " = " + value + "\n" );
	}
}
else
	Msg( "\n*****\nNO HAY 32 DirectorScript.MapScript.ChallengeScript.DirectorOptions:\n" );


if ( DirectorScript.MapScript.ChallengeScript.rawin( "MutationOptions" ) )
{
	Msg( "\n*****\nMODE Y SCRIPTED MODE ACTIVADO DirectorScript.MapScript.ChallengeScript.MutationOptions:\n" );
	foreach( key, value in DirectorScript.MapScript.ChallengeScript.MutationOptions )
	{
		Msg( "    " + key + " = " + value + "\n" );
	}
}
else
	Msg( "\n*****\nNO HAY DirectorScript.MapScript.ChallengeScript.MutationOptions :\n" );


/*
if ( SessionOptions !=null )
{
	Msg( "\n*****\nGLOBAL SCRIPTED MODE SessionOptions:\n" );
	foreach( key, value in SessionOptions )
	{
		Msg( "    " + key + " = " + value + "\n" );
	}		
}else	
	Msg( "\n*****\nNO HAY SessionOptions:\n" );
*/