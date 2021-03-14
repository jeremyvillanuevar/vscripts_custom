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


En holdout example
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


Credits:
[L4D2] vscripts2020-07-16
http://www.xygamers.com/forum.php?mod=viewthread&tid=25602
Author: c_d..0g C_D.og

VSLib Library
https://steamcommunity.com/sharedfiles/filedetails/?id=121070254
Developer Guide - Notifications
https://www.gamemaps.com/guide/24
Author: Rayman1103
https://steamcommunity.com/id/Rayman1103

Amap Logic
Title: The Alternate Difficulties Mod (TADM)
Author Steam Alias: jetSetWilly II
Author URL: https://steamcommunity.com/id/jetsetwillyuncensored/
Version: 2.5
Programming Language: VScript
File Description: This is a control file that selects map specific files used by TADM

Rectus' Custom Weapons Example
https://steamcommunity.com/sharedfiles/filedetails/?id=638790000
Custom Scripted Weapon Guide
https://www.gamemaps.com/guide/178
Author: https://steamcommunity.com/id/rectus

Valve
https://developer.valvesoftware.com/wiki/L4D2_Vscripts