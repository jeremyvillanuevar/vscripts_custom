BIBLIA DEL VScript
Los scopes son:
1 DirectorBase
2 Mapa
3 Local / Script del Momento
4 Modo / Challenge
Las opciones del director se toman en orden del más bajo sobreescribe a los demás
Mapas no tienen un script que corresponde con un nombre
Cuando un vscript se ejecuta y llama realizando un include a otro, crea todo en ese scope

Para realizar programación avanzada se debe generar el vscript de modo
que lleva el nombre del gamemode, como coop.nut

Cuando se habilita el vscript de modo (scripted mode) se pueden crear vscript de mapa
con el nombre del mapa_gamemode, como c1m1_hotel_coop.nut

Cada Mapa Ejecuta los VScripts en este orden
mapspawn //anniversary
--- VSCRIPT: Exec: <anv_functions>
--- VSCRIPT: Exec: <response_testbed>
--- VSCRIPT: Exec: <rulescript_base>
--- VSCRIPT: Exec: <response_rules>
internal preparation for scripted mode: //crea los callbacks hooks y un director default para el mode
--- VSCRIPT: Exec: <scriptedmode>
--- VSCRIPT: Exec: <sm_utilities>
--- VSCRIPT: Exec: <sm_spawn>
mode //coop
map_coop
--- VSCRIPT: Exec: <sm_stages>
director_base //
anv_mapfixes.nut //anv
--- VSCRIPT: Exec: <scriptedmode>
--- VSCRIPT: Exec: <sm_utilities>
--- VSCRIPT: Exec: <sm_spawn>
mode //coop 
map_coop
--- VSCRIPT: Exec: <sm_stages>
director_base // 
local script //



En holdout
mapspawn //anniversary
--- VSCRIPT: Exec: <anv_functions>
--- VSCRIPT: Exec: <response_testbed>
--- VSCRIPT: Exec: <rulescript_base>
--- VSCRIPT: Exec: <response_rules>
--- VSCRIPT: Exec: <scriptedmode>
--- VSCRIPT: Exec: <sm_utilities>
--- VSCRIPT: Exec: <sm_spawn>
--- VSCRIPT: Exec: <holdout>
--- VSCRIPT: Exec: <c10m5_houseboat_holdout>
--- VSCRIPT: Exec: <sm_resources>
--- VSCRIPT: Exec: <entitygroups/ammo_crate_group>
--- VSCRIPT: Exec: <entitygroups/wall_barricade_group>
--- VSCRIPT: Exec: <entitygroups/window_barricade_group>
--- VSCRIPT: Exec: <entitygroups/buildable_minigun_group>
--- VSCRIPT: Exec: <entitygroups/defib_cabinet_group>
--- VSCRIPT: Exec: <entitygroups/footlocker_throwables_group>
--- VSCRIPT: Exec: <entitygroups/health_cabinet_group>
--- VSCRIPT: Exec: <entitygroups/resupply_helicopter_group>
--- VSCRIPT: Exec: <entitygroups/placeable_resource_group>
--- VSCRIPT: Exec: <entitygroups/med_cabinet_group>
--- VSCRIPT: Exec: <entitygroups/tier1_weapon_cabinet_group>
--- VSCRIPT: Exec: <entitygroups/tier2_weapon_cabinet_group>
--- VSCRIPT: Exec: <entitygroups/tank_manhole_group>
--- VSCRIPT: Exec: <entitygroups/cooldown_extension_button_group>
--- VSCRIPT: Exec: <entitygroups/wrongway_barrier_group>
--- VSCRIPT: Exec: <entitygroups/rescue_helicopter_group>
--- VSCRIPT: Exec: <entitygroups/hintboard_group>
--- VSCRIPT: Exec: <entitygroups/combiner_group>
--- VSCRIPT: Exec: <sm_stages>
--- VSCRIPT: Overriding script: <director_base> <vscripts_override/director_base>
--- VSCRIPT: Exec: <anv_mapfixes>
--- VSCRIPT: Exec: <scriptedmode>
--- VSCRIPT: Exec: <sm_utilities>
--- VSCRIPT: Exec: <sm_spawn>
--- VSCRIPT: Exec: <holdout>
--- VSCRIPT: Exec: <c10m5_houseboat_holdout>
--- VSCRIPT: Exec: <sm_resources>
--- VSCRIPT: Exec: <entitygroups/ammo_crate_group>
--- VSCRIPT: Exec: <entitygroups/wall_barricade_group>
--- VSCRIPT: Exec: <entitygroups/window_barricade_group>
--- VSCRIPT: Exec: <entitygroups/buildable_minigun_group>
--- VSCRIPT: Exec: <entitygroups/defib_cabinet_group>
--- VSCRIPT: Exec: <entitygroups/footlocker_throwables_group>
--- VSCRIPT: Exec: <entitygroups/health_cabinet_group>
--- VSCRIPT: Exec: <entitygroups/resupply_helicopter_group>
--- VSCRIPT: Exec: <entitygroups/placeable_resource_group>
--- VSCRIPT: Exec: <entitygroups/med_cabinet_group>
--- VSCRIPT: Exec: <entitygroups/tier1_weapon_cabinet_group>
--- VSCRIPT: Exec: <entitygroups/tier2_weapon_cabinet_group>
--- VSCRIPT: Exec: <entitygroups/tank_manhole_group>
--- VSCRIPT: Exec: <entitygroups/cooldown_extension_button_group>
--- VSCRIPT: Exec: <entitygroups/wrongway_barrier_group>
--- VSCRIPT: Exec: <entitygroups/rescue_helicopter_group>
--- VSCRIPT: Exec: <entitygroups/hintboard_group>
--- VSCRIPT: Exec: <entitygroups/combiner_group>
--- VSCRIPT: Exec: <sm_stages>
--- VSCRIPT: Overriding script: <director_base> <vscripts_override/director_base>
--- VSCRIPT: Overriding script: <anv_maptrigs> <vscripts_override/anv_maptrigs>
_1_ammo_crate_usetarget executing script: usetargets/ammo_crate_use_target
--- VSCRIPT: Exec: <usetargets/ammo_crate_use_target>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
_2_useTarget executing script: usetargets/wall
--- VSCRIPT: Exec: <usetargets/wall>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
--- VSCRIPT: Exec: <usetargets/base_barricade>
--- VSCRIPT: Exec: <entity_script_utilities>
SCRIPT PERF WARNING --- "main" ran long at 2.182940ms
_3_useTarget executing script: usetargets/wall
--- VSCRIPT: Exec: <usetargets/wall>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
--- VSCRIPT: Exec: <usetargets/base_barricade>
--- VSCRIPT: Exec: <entity_script_utilities>
SCRIPT PERF WARNING --- "main" ran long at 2.241705ms
_4_useTarget executing script: usetargets/wall
--- VSCRIPT: Exec: <usetargets/wall>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
--- VSCRIPT: Exec: <usetargets/base_barricade>
--- VSCRIPT: Exec: <entity_script_utilities>
SCRIPT PERF WARNING --- "main" ran long at 2.125126ms
_5_useTarget executing script: usetargets/wall
--- VSCRIPT: Exec: <usetargets/wall>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
--- VSCRIPT: Exec: <usetargets/base_barricade>
--- VSCRIPT: Exec: <entity_script_utilities>
SCRIPT PERF WARNING --- "main" ran long at 2.267938ms
_6_use_target executing script: usetargets/window
--- VSCRIPT: Exec: <usetargets/window>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
--- VSCRIPT: Exec: <usetargets/base_barricade>
--- VSCRIPT: Exec: <entity_script_utilities>
SCRIPT PERF WARNING --- "main" ran long at 2.117758ms
_7_use_target executing script: usetargets/window
--- VSCRIPT: Exec: <usetargets/window>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
--- VSCRIPT: Exec: <usetargets/base_barricade>
--- VSCRIPT: Exec: <entity_script_utilities>
SCRIPT PERF WARNING --- "main" ran long at 2.226644ms
_8_use_target executing script: usetargets/window
--- VSCRIPT: Exec: <usetargets/window>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
--- VSCRIPT: Exec: <usetargets/base_barricade>
--- VSCRIPT: Exec: <entity_script_utilities>
SCRIPT PERF WARNING --- "main" ran long at 2.174638ms
_9_use_target executing script: usetargets/window
--- VSCRIPT: Exec: <usetargets/window>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
--- VSCRIPT: Exec: <usetargets/base_barricade>
--- VSCRIPT: Exec: <entity_script_utilities>
SCRIPT PERF WARNING --- "main" ran long at 2.051841ms
_10_use_target executing script: usetargets/window
--- VSCRIPT: Exec: <usetargets/window>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
--- VSCRIPT: Exec: <usetargets/base_barricade>
--- VSCRIPT: Exec: <entity_script_utilities>
SCRIPT PERF WARNING --- "main" ran long at 2.069225ms
_11_use_target executing script: usetargets/window
--- VSCRIPT: Exec: <usetargets/window>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
--- VSCRIPT: Exec: <usetargets/base_barricade>
--- VSCRIPT: Exec: <entity_script_utilities>
SCRIPT PERF WARNING --- "main" ran long at 1.959563ms
_12_use_target executing script: usetargets/window
--- VSCRIPT: Exec: <usetargets/window>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
--- VSCRIPT: Exec: <usetargets/base_barricade>
--- VSCRIPT: Exec: <entity_script_utilities>
SCRIPT PERF WARNING --- "main" ran long at 2.075562ms
_13_use_target executing script: usetargets/window
--- VSCRIPT: Exec: <usetargets/window>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
--- VSCRIPT: Exec: <usetargets/base_barricade>
--- VSCRIPT: Exec: <entity_script_utilities>
SCRIPT PERF WARNING --- "main" ran long at 2.297441ms
_14_use_target executing script: usetargets/minigun
--- VSCRIPT: Exec: <usetargets/minigun>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
_15_use_target executing script: usetargets/minigun
--- VSCRIPT: Exec: <usetargets/minigun>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
_16_use_target executing script: usetargets/minigun
--- VSCRIPT: Exec: <usetargets/minigun>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
_17_useTarget executing script: usetargets/defib_cabinet
--- VSCRIPT: Exec: <usetargets/defib_cabinet>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
_18_button_footlocker executing script: usetargets/throwable_locker
--- VSCRIPT: Exec: <usetargets/throwable_locker>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
_19_use_target_cabinet executing script: usetargets/health_cabinet
--- VSCRIPT: Exec: <usetargets/health_cabinet>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
_20_resupply_drop_chopper_script executing script: resupply_helicopter
--- VSCRIPT: Exec: <resupply_helicopter>
--- VSCRIPT: Exec: <base_helicopter>
_21_resupply_drop_chopper_script executing script: resupply_helicopter
--- VSCRIPT: Exec: <resupply_helicopter>
_22_button_med_cabinet executing script: usetargets/med_cabinet
--- VSCRIPT: Exec: <usetargets/med_cabinet>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
_23_use_target_cabinet executing script: usetargets/ammo_cabinet_tier_1
--- VSCRIPT: Exec: <usetargets/ammo_cabinet_tier_1>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
Level design error: Two entities with the name '_23_gun_cabinet_door' found. point_script_use_target named '_23_use_target_cabinet' may not be finding the correct use entity._24_use_target_cabinet executing script: usetargets/ammo_cabinet_tier_2
--- VSCRIPT: Exec: <usetargets/ammo_cabinet_tier_2>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
Level design error: Two entities with the name '_24_gun_cabinet_doors' found. point_script_use_target named '_24_use_target_cabinet' may not be finding the correct use entity.Late precache of player/tank/voice/idle/Tank_Voice_01.wav
Late precache of player/tank/voice/idle/Tank_Voice_02.wav
Late precache of player/tank/voice/idle/Tank_Voice_03.wav
Late precache of player/tank/voice/idle/Tank_Voice_04.wav
Late precache of player/tank/voice/idle/Tank_Voice_05.wav
Late precache of player/tank/voice/idle/Tank_Voice_06.wav
Late precache of player/tank/voice/idle/Tank_Voice_07.wav
Late precache of player/tank/voice/idle/Tank_Voice_08.wav
Late precache of player/tank/voice/idle/Tank_Voice_09.wav
_25_usetarget_tank_manhole executing script: usetargets/tank_barricade
--- VSCRIPT: Exec: <usetargets/tank_barricade>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
_25_manhole_tank_script executing script: tank_spawn_manager
--- VSCRIPT: Exec: <tank_spawn_manager>
_26_usetarget_tank_manhole executing script: usetargets/tank_barricade
--- VSCRIPT: Exec: <usetargets/tank_barricade>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
_26_manhole_tank_script executing script: tank_spawn_manager
--- VSCRIPT: Exec: <tank_spawn_manager>
_34_rescue_chopper_script executing script: rescue_helicopter
--- VSCRIPT: Exec: <rescue_helicopter>
_35_hintboard_usetarget executing script: usetargets/hintboard_usetarget
--- VSCRIPT: Exec: <usetargets/hintboard_usetarget>
--- VSCRIPT: Exec: <usetargets/base_buildable_target>
_36_combiner_script executing script: usetargets/combiner
--- VSCRIPT: Exec: <usetargets/combiner>
SCRIPT PERF WARNING --- "ScriptMode_OnGameplayStart" ran long at 144.166664ms
_48_singlesimple executing script: startbox
--- VSCRIPT: Exec: <startbox>


Cada parámetro de DirectorOptions se ejecuta por descendencia en los VScripts
Primero 
mode
local
map
Ejemplo CommonLimit 
local script // CommonLimit = 0
map // CommonLimit = 9999
CommonLimit sería 0 porque local es más descendente

Es facil buscar en la biblioteca usando el comando en windows
findstr /N /S /I palabraabuscar *
