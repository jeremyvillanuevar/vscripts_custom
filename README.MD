BIBLIA DEL VScript
El Lenguaje VScript se maneja por scopes (alcances).

Los Scopes para el scripting son:
1 DirectorBase (director_base.nut está en este framework)
2 Mapa ([nombredemapa].nut y [nombredemapa_nombredemodo].nut)
3 Local / Script del Momento ([cualquiernombredescript].nut)
4 Modo / Challenge ([nombredemodo].nut)


Cada Scope tiene sus propias variables como las opciones del director
llamadas DirectorOptions.

DirectorOptions es una tabla y ahí dentro 
de ella se guardan los parámetros como CommonLimit,
MaxSpecials, algunos de estos están detallados 
en el script de este framework: modifydirector.nut

Cada parámetro de DirectorOptions se ejecuta por descendencia en los VScripts
En este orden de Script
4 Modo
3 Local
2 Mapa

Las opciones del director se toman en orden del más bajo sobreescribe a los demás.
Ejemplo: Parámetro CommonLimit es DirectorScript.DirectorOptions.CommonLimit
En local // DirectorScript.MapScript.LocalScript.DirectorOptions.CommonLimit = 0
En map // DirectorScript.MapScript.DirectorOptions.CommonLimit = 9999
CommonLimit en el Juego sería 0 porque local es más descendente

Cuando un vscript de un scope se ejecuta 
y llama realizando un include a otro, 
crea todo en el mismo scope.
Ejemplo: VScript director_base.nut del scope 1 DirectorBase
incluye a: includes tieh.nut, entonces tieh.nut 
esta en el scope 1 DirectorBase

Al generar un VScript de Scope 4, automáticamente se crea
inclusdes de programación avanzada.
Para esto se debe generar el vscript de modo
que lleva el nombre del gamemode, como coop.nut
Así, se habilita el vscript de modo "scripted mode" y se pueden usar
vscript de mapa con el como [nombremapa_nombremodo], como c1m1_hotel_coop.nut

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


Es facil buscar en la biblioteca de vscript usando el comando en windows
findstr /N /S /I palabraabuscar *


Uso de este Framework
Instalación
[REQUIRED] Install Silver's Plugin: [L4D2 & CS:GO] VScript File Replacer
Primero subir el archivo vscripts_override.cfg a left4dead2\addons\sourcemod\data
Copiar todos los archivos del github a left4dead2\scripts\vscripts\vscripts_custom

Explicación de Cada Archivo
coop.nut: Enables Scripted Mode: Scope and VScript Hooks and Callbacks
y Crea Variables Globales (se usan en todos los scopes)
debug.nut: Habilita el debug como una variable DEBUG
amap.nut: Implementa cada script llamado en vscripts_override
trabaja en el Local Scope (lógica de JetSetWilly II).
a*.nut: (lógica de JetSetWilly II).
modifydirector.nut: Realiza el balance de las variables del juego basado en jugadores y dificultad
modifica al Map Scope.
hooks.nut: Procedimientos adjuntos (hookeados) a Eventos de Juego.
showplayers.nut: Métodos de Hud.
announcedirector.nut: Métodos de apoyo a Anuncios.
debug_directoroptions.nut: Muestra las opciones de DirectorOptions de todos los Scopes.
VSLib: La librería de Rayman1103









-------------------------




VScript BIBLE
VScripting is handled by scopes.

Scopes for scripting are:
1 DirectorBase (director_base.nut en este framework)
2 Map ([mapname].nut and [mapname_modename].nut)
3 Local / Script of the Moment ([anyscriptname].nut)
4 Mode / Challenge ([modename].nut)

Each scope has its own variables like the director's options
called DirectorOptions.

DirectorOptions is a table and in there
from it the parameters are saved as CommonLimit,
MaxSpecials, some of these are detailed
in the script of this framework: modifydirector.nut

Each parameter of DirectorOptions is executed by descent in VScripts
In this script order
4 Mode
3 Local
2 Map

The director's choices are made in order of the lowest, overwriting the others.
Example: CommonLimit parameter is DirectorScript.DirectorOptions.CommonLimit
In local // DirectorScript.MapScript.LocalScript.DirectorOptions.CommonLimit = 0
In map // DirectorScript.MapScript.DirectorOptions.CommonLimit = 9999
CommonLimit in-game would be 0 because local is more descending

When a vscript of a scope is executed
and calls making an include to another,
create everything in the same scope.
Example: VScript director_base.nut of scope 1 DirectorBase
includes a: includes tieh.nut, then tieh.nut
is in scope 1 DirectorBase

When generating a Scope 4 VScript, it automatically creates
includes from scripts of advanced programming.
For this, the vscript must be generated 
named after the gamemode, such as coop.nut
Thus, the vscript mode "scripted mode" is enabled and you may use
map vscript with it like [mapname_modename], such as c1m1_hotel_coop.nut


Using this Framework

Installation:
[REQUIRED] Install Silver's Plugin: [L4D2 & CS: GO] VScript File Replacer
First upload the vscripts_override.cfg file to left4dead2\addons\sourcemod\data
Copy all files from github to left4dead2\scripts\vscripts\vscripts_custom

Explanation of Files:
coop.nut: Enables Scripted Mode: Scope and VScript Hooks and Callbacks
and Create Global Variables (used in all scopes)
debug.nut: Enable debugging as a DEBUG variable
amap.nut: Implement every script called in vscripts_override
working on the Local Scope (logic from JetSetWilly II).
a*.nut: (logic from JetSetWilly II).
modifydirector.nut: Balances the game variables based on players and difficulty
changing the Map Scope.
hooks.nut: Procedures attached (hooked) to Game Events.
showplayers.nut: Hud methods.
announcedirector.nut: Ads support methods.
debug_directoroptions.nut: Displays the DirectorOptions options for all Scopes.
VSLib: Rayman's Library1103


Each Map Executes the VScripts in this order
mapspawn // anniversary
--- VSCRIPT: Exec: <anv_functions>
--- VSCRIPT: Exec: <response_testbed>
--- VSCRIPT: Exec: <rulescript_base>
--- VSCRIPT: Exec: <response_rules>
internal preparation for scripted mode: // create callbacks hooks and a default director for the mode
--- VSCRIPT: Exec: <scriptedmode>
--- VSCRIPT: Exec: <sm_utilities>
--- VSCRIPT: Exec: <sm_spawn>
mode // coop
map_coop
--- VSCRIPT: Exec: <sm_stages>
base_director //
anv_mapfixes.nut // anv
--- VSCRIPT: Exec: <scriptedmode>
--- VSCRIPT: Exec: <sm_utilities>
--- VSCRIPT: Exec: <sm_spawn>
mode // coop
map_coop
--- VSCRIPT: Exec: <sm_stages>
base_director //
local script //


It's easy to search the vscript library using the command in windows
findstr /N /S /I searchword *




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