Msg("Initiating c5m5_bridge_coop Script\n");

local hndc5m5timer1 = Entities.FindByName( null, "jeremytimer1" ) 
local hndc5m5timer2 = Entities.FindByName( null, "jeremytimer2" ) 

local hndc5m5zombie1 = Entities.FindByName( null, "c5m5jeremy1" ) 


if ( hndc5m5zombie1==null)
{	
	Msg("SpawnEntityFromTable hndc5m5zombie1\n");		
	hndc5m5zombie1 =SpawnEntityFromTable( "info_zombie_spawn",
	{
		targetname	= "c5m5jeremy1",
		origin = "-11911.031250 6489.907226 501.521728",
		angles= "0 0 0",
		population	= "busstation"
	} );
}

if ( hndc5m5timer1!=null )
{
	Msg("kill hndc5m5timer1\n");
	kill_entity(hndc5m5timer1);
	//EntFire( "jeremytimer1", "Kill")
	hndc5m5timer1=null;
}

if ( hndc5m5timer1==null)
{	
	Msg("SpawnEntityFromTable hndc5m5timer1\n");	
	
	hndc5m5timer1 =SpawnEntityFromTable( "logic_timer",
	{
		targetname	= "jeremytimer1",
		//RefireTime	= user_intKillTimer,
		origin = "-11762 6341 457"
		StartDisabled	= 1,
		UseRandomTime	= 1,
		UpperRandomBound	= 1,
		spawnflags	= 0,
		LowerRandomBound	= 2,
		//origin = Vector(-11762,6341,459),
		connections =
		{
			OnTimer =
			{
				cmd1 = "c5m5jeremy1SpawnZombie0-1"
			}
		}
	} );
		
}
if ( hndc5m5timer2!=null )
{
	Msg("kill hndc5m5timer2\n");	
	//kill_entity(hndc5m5timer2);
	EntFire( "jeremytimer2", "Kill")
	hndc5m5timer2=null;

}

if ( hndc5m5timer2==null)
{		
	Msg("SpawnEntityFromTable hndc5m5timer2\n");	
	hndc5m5timer2=SpawnEntityFromTable( "logic_timer",
	{
		targetname	= "jeremytimer2",
		//RefireTime	= user_intKillTimer,
		origin = "-11762 6341 459"
		StartDisabled	= 1,
		UseRandomTime	= 1,
		UpperRandomBound	= 1,
		spawnflags	= 0,
		LowerRandomBound	= 2,
		//origin = Vector(-11762,6341,459),
		connections =
		{
			OnTimer =
			{
				cmd1 = "c5m5jeremy1SpawnZombie0-1"
			}
		}
	} );
}



if ( hndc5m5timer1!=null )
{
	Msg("start the timer c5m5timer1\n");		
	// start the timer c5m5timer1
	//EntFireByHandle(handle target, string action, string value, float delay, handle activator, handle caller)
	EntFire( "jeremytimer1", "Enable")
	//c5m5timer1.Destroy()
}
	
if ( hndc5m5timer2!=null )
{
		
	Msg("start the timer c5m5timer2\n");		
	// start the timer c5m5timer2
	//DoEntFire(string target, string action, string value, float delay, handle activator, handle caller)
	DoEntFire( "jeremytimer2", "Enable", "", 0, null, null )
	//c5m5timer1.Destroy()
}
	
	/*
	
function make_atomizer( user_strTargetname,
			user_strOrigin,
			user_strModel,
			user_intKillTimer )
{
	SpawnEntityFromTable( "filter_activator_model",
	{
		targetname	= g_UpdateName + user_strTargetname + "_filter",
		Negated		= "Allow entities that match criteria",
		model		= user_strModel
	} );

	SpawnEntityFromTable( "logic_timer",
	{
		targetname	= g_UpdateName + user_strTargetname + "_timer",
		StartDisabled	= 1,
		RefireTime	= user_intKillTimer,
		connections =
		{
			OnTimer =
			{
				cmd1 = "anv_mapfixes_atomizer_monitoredStartGlowing0-1"
				cmd2 = "anv_mapfixes_atomizer_monitoredKill5-1"
				cmd3 = "!selfDisable0-1"
				cmd4 = "!selfResetTimer0-1"
			}
		}
	} );

	SpawnEntityFromTable( "trigger_multiple",
	{
		targetname	= g_UpdateName + user_strTargetname + "_trigmult",
		origin		= StringToVector_Valve( user_strOrigin, " " ),
		spawnflags	= 8,
		filtername	= g_UpdateName + user_strTargetname + "_filter",
		connections =
		{
			OnStartTouch =
			{
				cmd1 = g_UpdateName + user_strTargetname + "_timer" + "Enable0-1"
				cmd2 = "!activatorAddOutputtargetname anv_mapfixes_atomizer_monitored0-1"
				cmd3 = "!selfAddOutputspawnflags 00-1"
			}
			OnEndTouch =
			{
				cmd1 = g_UpdateName + user_strTargetname + "_timer" + "Disable0-1"
				cmd2 = g_UpdateName + user_strTargetname + "_timer" + "ResetTimer0-1"
				cmd3 = "!selfAddOutputspawnflags 80-1"
			}
		}
	} );

	EntFire( g_UpdateName + user_strTargetname + "_trigmult", "AddOutput", "mins -50 -50 0" );
	EntFire( g_UpdateName + user_strTargetname + "_trigmult", "AddOutput", "maxs 50 50 100" );
	EntFire( g_UpdateName + user_strTargetname + "_trigmult", "AddOutput", "solid 2" );

	if ( developer() > 0 )
	{
		printl( "trigger_multiple Tank/Charger chokepoint atomizer created @ setpos_exact " + user_strOrigin + "\n" );
	}
}

*/