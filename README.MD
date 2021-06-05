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

Left 4 Dead 2 VScript Framework's Processes
Map Scripts Loading
https://docs.google.com/presentation/d/1PBdTVsN-MFRWECDb34QjfbWi52OBjxzUkRflozJiZyI/edit?usp=sharing

Working on Sky Entities Features using Stripper


Dead Center:
-------------
> **Map 1: Hotel**
- You must now call the elevator, which will trigger horde. (Duration: 40 sec / Holdout Bonus: 20 pts)
- An SMG spawn has been placed near the elevator, to help you battle the horde and SI.
- Minor event before the Saferoom, will not trigger horde. ???????
- Map may contain random weather, small rains. ????????

> **Map 2: Streets**
- A few minor "LoS-Blockers" added to the blocked Bridge fences.??????
- The bushes and trees below the bridge have grown closer, forcing Survivors to walk around.
- Added an Event near the bridge; Explosion + Flying Cars, triggering Horde (Duration: 45 sec / Holdout Bonus: 40 pts)

> **Map 4: Atrium**
- Added a hittable for Tank.???????

----------


Dark Carnival:
-------------


> **Map 1: Highway**

- Added a hittable for early Tanks
- Added an Event; A plane crashes at the destroyed bridge, triggers Horde + Flying Car (Duration: 40 sec / Holdout Bonus: 20 pts)
- Added an Event; Survivors need to start the Van so that it will push through the barricade and cause an explosion, triggers Horde (Duration: 40 sec)
- Map may contain random weather, small rains and storm.


> **Map 2: Fairgrounds**

- Opened up the Fencing where you leave the building, Items can spawn in this open area.
- Added a Scavenge Event: You need to collect 6 Cans to set the Wood on fire before the corridor (1 Can = 12 Extra Pts) Horde is triggered (Duration: 70 sec / Holdout Bonus: 40 pts)
- Map may contain random weather, small rains and storm.


> **Map 3: Coaster**

- Added an Event where Survivors need to find a bomb to blow up the wall blocking the end of the Tunnel of Love, triggers small horde-wave. A Tank can disable this event.
- Map may contain random weather, small rains and storm.
 

> **Map 4: Barns**

- Added a Tank Spawning Event; Tank will spawn as you exit the building and enter the open area.
- The military chopper will crash and a Tank escapes out of its cargo bay.
- Two dumpsters have been added near the Tank's drop to help it fend off attackers.
- Tank will be unchippable during the dropdown.
- You can't rush past the open area, the area is closed off until the Tank dies.
- Map may contain random weather, small rains and storm.
 

> **Map 5: Concert**

- Standard Promod Changes.

----------


Swamp Fever:
-------------


> **Map 1: Plank Country**

- The Ferry Event has been changed into a Scavenge Event, collect 6 cans and fill up the generator to power the Ferry (12 Pts per Can)
- Map may contain random weather, small rains.


> **Map 2: Swamp**

- Added an Event 92% Before the Saferoom Area; Fire the Military Tank to clear the barricade, Triggers Horde (Duration: 60 sec / Holdout Bonus: 40 pts)


> **Map 3: Shanty Town**

- Modified Event; Survivors will have to blow up the houses to clear the way, Triggers Event Horde (Duration: 60 sec / Holdout Bonus: 40 pts)
- Map may contain random weather, small rains.


> **Map 4: Plantation**

- Standard Promod Changes.


----------


Hard Rain:
-------------


> **Map 1: Milltown A**

- Blocked access to the roof by using the White Car (Removed when Survivors climb onto the roof through the Burger Tank)
- At the treehouse, the house on the right has a gas leak and will explode, triggers horde (Duration: 50 sec / Holdout Bonus: 40 pts)


> **Map 2: Sugarmill A**

- An "infected ladder" in the form of a branching bush is added for quick access to the roof of the Safehouse
- Modified Elevator Event to require Cans to be poured into the generator to power up the Elevator (6 Cans which give 12 Pts Each)
- Added a few "LoS-Blockers" to the Event Area, allowing Spawns for Infected.


> **Map 3: Sugarmill B**

- Added an Event right as the Survivors leave the Safehouse, Triggers Horde (Duration: 45 sec / Holdout Bonus: 40 pts)


> **Map 4: Milltown B**

- Added an Event after the Survivors leave the saferoom, Tank will jump out of a burning Airplane and will be immune to chip for 4 Seconds. Tank spawn will be static at 21%.


> **Map 5: Milltown Escape**

- Standard Promod Changes.


----------


The Parish:
-------------


> **Map 1: Waterfront**

- Added an Event near the end Saferoom, opening the door to the Kitchen will trigger an Event Horde (Duration: 35 sec / Holdout Bonus: 40 pts)


> **Map 2: Park**

- The Survivors have to find a keycard for the CEDA Trailer or they will be unable to enter it.
- Map may contain random weather, small rains.


> **Map 3: Cemetery**

- An event has been added 16% into the map, Survivors have to shoot toxic waste barrels to clear the way, this Triggers Horde (Duration: 50 sec/ Holdout Bonus: 40 pts)
- At the Car Park, an Airstrike will hit the bridge above, causing Cars to drop down, no Horde is triggered.
- The route through the Cemetery is modified to be longer.


> **Map 4: Quarter**

- The tractor event has turned into a Scavenge Event, Survivors have to fill up the Tractor with 6 Cans (each give 12 Pts) to activate it.


> **Map 5: Bridge**

- Standard Promod Changes.


----------


No Mercy:
-------------


> **Map 1: Apartment**

- When you exit the corridors a car will explode and turn on an alarm, this will trigger a horde unless Tank is up (Duration: 50 sec/ Holdout Bonus: 40 pts)


> **Map 2: Subway**

- The event area is cleared, Survivors are free to pass through.
- An event has been added as you exit the building after the original event area, a truck will ram into the barricade and cause Horde to spawn (Holdout Duration: 60 sec/ Holdout Bonus: 80 pts) (Endless horde)


> **Map 3: Sewers**

- The original Event has been removed.
- Event has been added, Survivors have to shoot the gaspumps to force the power pole to fall and create a path for the Survivors, the pole is under heavy electricity and will set the roof under electric charge, dealing damage to Survivors (Duration: 60 sec/ Holdout Bonus: 40 pts)


> **Map 4: Interior**

- A Scavenge Event has been added before the Elevator event, Survivors will have to collect Cola bottles (12 Pts per 6Pack) in trade for clearing the path, the explosion will trigger mini-hordes (5-10 common waves)
- A ladder has been added in the Elevator shaft (Not recommended to fast-climb here)
- The wall on the left after exiting the elevator up top has been removed.


> **Map 5: Rooftop**

- Standard Promod Changes.

----------

Dead Air:
-------------


> **Map 1: Greenhouse**

- New panic-event at 85% is added, survivors have to douse the fire in one of the rooms with the help of fire extinguishing system. It activates the horde. (Duration: 50 sec/ Holdout Bonus: 40 pts)
- Map may contain random weather, small rains and storm.

> **Map 2: Offices**

- New panic-event at 85% is added, survivors have to activate the motor winch to wrest barricaded doors. It activates the horde. (Duration: 40 sec)
- If Tank spawns at 90% the player has to pass through the alley (backdoor, behind the office building) to get inside the office building.
- Map may contain random weather, small rains and storm.

> **Map 3: Garage**

- New panic-event at 70% is added, infected plane passengers getting through the aircraft door, activating the event. (Duration: 45 sec/ Holdout Bonus: 40 pts)
- Map may contain random weather, storm.


> **Map 4: Terminal**

- Panic-event is modified to be more like scavenge mode, survivors have to gather 6 cans and fill the van. (12 points for a can)
- Map may contain random weather, small rains and storm.

> **Map 5: Runway**

- Standard Promod Changes.


----------


Death Toll:
-------------


> **Map 1: Caves**

- At the start of the map, the Survivors must clear the path by cutting down a tree. After the tree has collapsed, a holdout event will commence (Duration: 55 sec/ Holdout Bonus: 40 pts)


> **Map 2: Drainage**

- The default event has been modified to incorporate Scavenge elements. The Survivors must collect 6 canisters in order to fuel the generator which is powering the bridge. 
- Map may contain random weather, small rains.


> **Map 3: Ranchhouse**

- The default event has been removed. A new holdout event (Duration: 115 sec/ Holdout Bonus: 100 pts) has been added at ~80%. The Survivors must take out the cemetery gates with the use of oxygen tanks. This event is endless and must be rushed once the path is clear. 
- Map may contain random weather, small rains and storm.


> **Map 4: Ranchhouse**

- Panic-event is modified, before rushing survivors have to fill the forklift with the help of gasoline tanker. First part event is of holdout type (Duration: 40 sec/ Holdout Bonus: 40 pts)


> **Map 5: Houseboat**

- Standard Promod Changes.


----------


Blood Harvest:
-------------


> **Map 1: Hilltop**

- Added an Event to the end of the bridge, Survivors have to blow up the car to clear the path. Horde will spawn (Duration: 50 sec/ Holdout Bonus: 20 pts)
- Added a Hittable for Tank at the end of the Map
- Map may contain random weather, small rains and severe storm.


> **Map 2: Train Tunnel**

- Event Added; After passing the Original Door Alarm event, Survivors need the manual brake handle to allow the outside Traincart to move forward and crash into the Car Hangar, which will set off Alarms with endless horde. Survivors need to shutdown the Car Engines by shooting at them. (After shutdown Horde will stop after 20 sec)
- Added a hittable Van for the Tank on the Car Hangar.


> **Map 3: Bridge**

- Event modified; The Survivors will need to fill up the Generator with 6 Cans (12 Pts each) and then alert the Military through the Radio which will take down the bridge in 20 Seconds. Event Horde is Endless until a Survivor makes it to the saferoom.


> **Map 4: Barn**

- Tank spawn will be static at 21%. The Tank spawns in one of the Trucks and has to hit the explosive barrels inside, this will send the Tank flying to the Survivors location, Everyone will see the cut-scene from the Tank's Point of View!


> **Map 5: Cornfield**

- Standard Promod Changes.





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