//-------------------------------------------------------
// Autogenerated from 'med_cabinet.vmf'
//-------------------------------------------------------
MedCabinet <-
{
	//-------------------------------------------------------
	// Required Interface functions
	//-------------------------------------------------------
	function GetPrecacheList()
	{
		local precacheModels =
		[
			EntityGroup.SpawnTables.meds_bathroom,
			EntityGroup.SpawnTables.toolbox,
		]
		return precacheModels
	}

	//-------------------------------------------------------
	function GetSpawnList()
	{
		local spawnEnts =
		[
			EntityGroup.SpawnTables.relay_restock_meds,
			EntityGroup.SpawnTables.unnamed,
			EntityGroup.SpawnTables.button_med_cabinet,
			EntityGroup.SpawnTables.toolbox,
			EntityGroup.SpawnTables.meds_bathroom,
			EntityGroup.SpawnTables.hint_adrenaline,
			EntityGroup.SpawnTables.hint_branch,
			EntityGroup.SpawnTables.hint,
			EntityGroup.SpawnTables.template_meds,
		]
		return spawnEnts
	}

	//-------------------------------------------------------
	function GetEntityGroup()
	{
		return EntityGroup
	}

	//-------------------------------------------------------
	// Table of entities that make up this group
	//-------------------------------------------------------
	EntityGroup =
	{
		SpawnTables =
		{
			meds_bathroom = 
			{
				SpawnInfo =
				{
					classname = "prop_dynamic"
					angles = Vector( 0, 0, 0 )
					body = "0"
					disablereceiveshadows = "0"
					disableshadows = "0"
					disableX360 = "0"
					ExplodeDamage = "0"
					ExplodeRadius = "0"
					fademaxdist = "0"
					fademindist = "-1"
					fadescale = "1"
					glowbackfacemult = "1.0"
					glowcolor = "0 0 0"
					glowrange = "0"
					glowrangemin = "0"
					glowstate = "0"
					LagCompensate = "0"
					MaxAnimTime = "10"
					maxcpulevel = "0"
					maxgpulevel = "0"
					MinAnimTime = "5"
					mincpulevel = "0"
					mingpulevel = "0"
					model = "models/props_interiors/medicalcabinet02.mdl"
					PerformanceMode = "0"
					pressuredelay = "0"
					RandomAnimation = "0"
					renderamt = "255"
					rendercolor = "255 255 255"
					renderfx = "0"
					rendermode = "0"
					SetBodyGroup = "0"
					skin = "0"
					solid = "0"
					spawnflags = "0"
					StartDisabled = "0"
					targetname = "meds_bathroom"
					updatechildren = "0"
					origin = Vector( 1, 0, 8 )
				}
			}
			meds = 
			{
				SpawnInfo =
				{
					classname = "weapon_pain_pills_spawn"
					angles = Vector( 0, 0, 0 )
					body = "0"
					disableshadows = "0"
					parentname = "meds_bathroom"
					skin = "0"
					solid = "6"
					spawnflags = "0"
					targetname = "meds"
					origin = Vector( 8, 13, 45 )
				}
			}
			meds1 = 
			{
				SpawnInfo =
				{
					classname = "weapon_pain_pills_spawn"
					angles = Vector( 0, 0, 0 )
					body = "0"
					disableshadows = "0"
					parentname = "meds_bathroom"
					skin = "0"
					solid = "6"
					spawnflags = "0"
					targetname = "meds"
					origin = Vector( 6, 5, 59 )
				}
			}
			meds2 = 
			{
				SpawnInfo =
				{
					classname = "weapon_adrenaline_spawn"
					angles = Vector( 0, 345, 0 )
					body = "0"
					disableshadows = "0"
					parentname = "meds_bathroom"
					skin = "0"
					solid = "6"
					spawnflags = "0"
					targetname = "meds"
					origin = Vector( 4, 8, 59 )
				}
			}
			meds3 = 
			{
				SpawnInfo =
				{
					classname = "weapon_adrenaline_spawn"
					angles = Vector( 0, 345, 0 )
					body = "0"
					disableshadows = "0"
					parentname = "meds_bathroom"
					skin = "0"
					solid = "6"
					spawnflags = "0"
					targetname = "meds"
					origin = Vector( 4, -8, 45 )
				}
			}
			template_meds = 
			{
				SpawnInfo =
				{
					classname = "point_script_template"
					spawnflags = "2"
					targetname = "template_meds"
					Template01 = "meds"
					origin = Vector( 15, 0, 8 )
				}
			}
			relay_restock_meds = 
			{
				SpawnInfo =
				{
					classname = "logic_relay"
					spawnflags = "0"
					StartDisabled = "0"
					targetname = "relay_restock_meds"
					origin = Vector( 15, 0, 24 )
					connections =
					{
						OnTrigger =
						{
							cmd1 = "template_medsForceSpawn0.1-1"
							cmd2 = "meds_bathroomSetAnimationopen0.3-1"
							cmd3 = "meds_bathroomSetAnimationidle0-1"
							cmd4 = "medsKill0-1"
							cmd5 = "hintFireUser401"
							cmd6 = "hint_adrenalineShowHint0-1"
						}
					}
				}
			}
			toolbox = 
			{
				SpawnInfo =
				{
					classname = "prop_dynamic"
					angles = Vector( 0, 0, 0 )
					body = "0"
					disablereceiveshadows = "0"
					disableshadows = "0"
					disableX360 = "0"
					ExplodeDamage = "0"
					ExplodeRadius = "0"
					fademaxdist = "0"
					fademindist = "-1"
					fadescale = "1"
					glowbackfacemult = ".1"
					glowcolor = "121 202 0"
					glowrange = "240"
					glowrangemin = "0"
					glowstate = "3"
					LagCompensate = "0"
					MaxAnimTime = "10"
					maxcpulevel = "0"
					maxgpulevel = "0"
					MinAnimTime = "5"
					mincpulevel = "0"
					mingpulevel = "0"
					model = "models/props_buildables/buildable_button.mdl"
					PerformanceMode = "0"
					pressuredelay = "0"
					RandomAnimation = "0"
					renderamt = "255"
					rendercolor = "255 255 255"
					renderfx = "0"
					rendermode = "0"
					SetBodyGroup = "0"
					skin = "0"
					solid = "6"
					spawnflags = "0"
					targetname = "toolbox"
					updatechildren = "0"
					origin = Vector( 7, 0, 31.129 )
					connections =
					{
						OnUser1 =
						{
							cmd1 = "!selfEnable0.5-1"
							cmd2 = "!selfDisable0-1"
						}
					}
				}
			}
			button_med_cabinet = 
			{
				SpawnInfo =
				{
					classname = "point_script_use_target"
					model = "toolbox"
					origin = Vector( 31, 0, 8 )
					targetname = "button_med_cabinet"
					vscripts = "usetargets/med_cabinet"
					connections =
					{
						OnUser1 =
						{
							cmd1 = "relay_restock_medsTrigger0-1"
						}
					}
				}
			}
			hint = 
			{
				SpawnInfo =
				{
					classname = "env_instructor_hint"
					hint_allow_nodraw_target = "1"
					hint_alphaoption = "0"
					hint_auto_start = "1"
					hint_binding = "+use"
					hint_caption = "If you have 4 supplies you can buy this item"
					hint_color = "255 255 255"
					hint_display_limit = "2"
					hint_forcecaption = "0"
					hint_icon_offscreen = "icon_tip"
					hint_icon_offset = "0"
					hint_icon_onscreen = "use_binding"
					hint_instance_type = "2"
					hint_name = "med_cabinet_lesson"
					hint_nooffscreen = "1"
					hint_pulseoption = "0"
					hint_range = "120"
					hint_shakeoption = "0"
					hint_static = "0"
					hint_suppress_rest = "1"
					hint_target = "meds_bathroom"
					hint_timeout = "5"
					targetname = "hint"
					origin = Vector( 32, 0, 82.2918 )
					connections =
					{
						OnUser4 =
						{
							cmd1 = "!selfEndHint0-1"
							cmd2 = "!selfKill0.01-1"
						}
					}
				}
			}
			hint_branch = 
			{
				SpawnInfo =
				{
					classname = "logic_branch"
					InitialValue = "$show_hint"
					targetname = "hint_branch"
					origin = Vector( 17, 0, 82.2918 )
					connections =
					{
						OnFalse =
						{
							cmd1 = "!selfKill0-1"
							cmd2 = "hintFireUser40-1"
							cmd3 = "hint_adrenalineFireUser40-1"
						}
						OnTrue =
						{
							cmd1 = "!selfKill0.1-1"
						}
					}
				}
			}
			unnamed = 
			{
				SpawnInfo =
				{
					classname = "logic_auto"
					spawnflags = "1"
					origin = Vector( 17, 0, 82.2918 )
					connections =
					{
						OnMapSpawn =
						{
							cmd1 = "hint_branchTest0-1"
							cmd2 = "meds_bathroomSkin10-1"
						}
					}
				}
			}
			hint_adrenaline = 
			{
				SpawnInfo =
				{
					classname = "env_instructor_hint"
					hint_allow_nodraw_target = "1"
					hint_alphaoption = "0"
					hint_auto_start = "0"
					hint_binding = "+use"
					hint_caption = "Adrenaline helps you build things faster"
					hint_color = "255 255 255"
					hint_display_limit = "2"
					hint_forcecaption = "0"
					hint_icon_offscreen = "icon_tip"
					hint_icon_offset = "0"
					hint_icon_onscreen = "use_binding"
					hint_instance_type = "2"
					hint_name = "med_cabinet_lesson"
					hint_nooffscreen = "1"
					hint_pulseoption = "0"
					hint_range = "100"
					hint_shakeoption = "0"
					hint_static = "0"
					hint_suppress_rest = "1"
					hint_target = "meds_bathroom"
					hint_timeout = "5"
					targetname = "hint_adrenaline"
					origin = Vector( 23, 0, 59 )
					connections =
					{
						OnUser4 =
						{
							cmd1 = "!selfEndHint0-1"
							cmd2 = "!selfKill0.01-1"
						}
					}
				}
			}
		} // SpawnTables

		ReplaceParmDefaults =
		{
			"$show_hint" : "0"
		}
	} // EntityGroup
} // MedCabinet

RegisterEntityGroup( "MedCabinet", MedCabinet )