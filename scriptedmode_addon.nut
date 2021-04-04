

	
function AddWeapons()
{
	local weapons =
	{
		// flamethrower = 	{script = "custom_flamethrower", model = "models/weapons/melee/v_flamethrower.mdl"},
		// barnacle = 		{script = "custom_barnacle", model = "models/weapons/melee/v_barnacle.mdl"},
		// m72law = 		{script = "custom_m72law", model = "models/weapons/melee/v_m72law.mdl"},
		// syringe_gun = 	{script = "custom_syringe_gun", model = "models/weapons/melee/v_syringe_gun.mdl"},
		// custom_ammo_pack = 	{script = "custom_ammo_pack", model = "models/weapons/melee/v_ammo_pack.mdl"},
		// bow = 			{script = "custom_bow", model = "models/weapons/melee/v_bow.mdl"}
		// custom_shotgun = 	{script = "custom_shotgun", model = "models/weapons/melee/v_custom_shotgun.mdl"}
		// sentry = 	{script = "custom_sentry", model = "models/weapons/melee/v_sentry.mdl"}
		// laser_pistol = 	{script = "custom_laser_pistol", model = "models/weapons/melee/v_laser_pistol.mdl"}
		riotshield = 	{script = "custom_riotshield", model = "models/weapons/melee/v_riotshield.mdl"}
	}
		
	foreach(weaponName, props in weapons)
	{
		if(g_WeaponController.AddCustomWeapon(props.model, props.script))
		{
			g_WeaponController.SetReplacePercentage(weaponName, 10)
		}
	}
}

printl("Custom Weapon Base loading...")
if(!("g_WeaponController" in getroottable()))
{
	::g_WeaponController <- {}
	DoIncludeScript("custom_weapon_controller", g_WeaponController)
}
else
{
	g_WeaponController.Initialize()
}

AddWeapons()


// Run CS:S gun unlocker if available.
/*::g_CSSUnlocker <- {}
DoIncludeScript("custom_css_unlocker", ::g_CSSUnlocker)
if("PrecacheWeapons" in ::g_CSSUnlocker)
{
	g_CSSUnlocker.PrecacheWeapons()	
	DoEntFire("!self", "RunScriptCode", "g_CSSUnlocker.Replace()", 1, null, Entities.FindByClassname(null, "worldspawn"))
}*/