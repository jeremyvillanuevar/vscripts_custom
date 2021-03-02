//-----------------------------------------------------

// Include the VScript Library
IncludeScript("VSLib");
Skyboxes <- [
   "0",
   "2"
]

worldspawn <- Entities.FindByClassname( null, "worldspawn" );
local i = RandomInt( 0, Skyboxes.len()-1 );
printl("Skyboxe is "+Skyboxes[i]);
printl( worldspawn.__KeyValueFromString( "timeofday", Skyboxes[i] ) );

::SpawnTank <- function ( args )
{
	Msg("Spawning Tank!\n");
	Utils.SpawnZombie( Z_TANK );
}

function Notifications::OnSurvivorsLeftStartArea::CreateTankTimer()
{
	if ( enable_tanks == 1 )
	{
		SpawnTank(null);
		Timers.AddTimer( 60.0, true, SpawnTank );
	}
}

function Notifications::OnTankSpawned::SetTankHealth( tank, params )
{
	if ( enable_tanks == 1 )
	{
		local Difficulty = Convars.GetStr( "z_difficulty" ).tolower();
		
		if ( Difficulty == "easy" )
		{
			Msg("Setting Tank Health to 1500\n");
			tank.SetHealth(1500);
		}
		else if ( Difficulty == "normal" || Difficulty == "hard" )
		{
			Msg("Setting Tank Health to 2000\n");
			tank.SetHealth(2000);
		}
		else if ( Difficulty == "impossible" )
		{
			Msg("Setting Tank Health to 4000\n");
			tank.SetHealth(4000);
		}
	}
}

allow_random_trigger <- 1;
enable_tanks <- 0;
finale_check <- 0;
MaxValue <- 16;
function Update()
{
	local random_chance = RandomInt( 0, MaxValue )
	DirectorOptions.cm_CommonLimit <- 15;
	DirectorOptions.cm_DominatorLimit <- 4;
	DirectorOptions.cm_MaxSpecials <- 4;
	DirectorOptions.cm_SpecialRespawnInterval <- 30;
	DirectorOptions.SpecialInitialSpawnDelayMin <- 5;
	DirectorOptions.SpecialInitialSpawnDelayMax <- 10;
	DirectorOptions.SmokerLimit <- 1;
	DirectorOptions.BoomerLimit <- 1;
	DirectorOptions.HunterLimit <- 1;
	DirectorOptions.SpitterLimit <- 1;
	DirectorOptions.JockeyLimit <- 1;
	DirectorOptions.ChargerLimit <- 1;
	DirectorOptions.WitchLimit <- 0;
	DirectorOptions.cm_WitchLimit <- 0;
	enable_tanks = 1;
	finale_check = 1;
	allow_random_trigger = 0;
}
