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
mode //coop
internal preparation for scripted mode //crea los callbacks hooks y un director default para el mode
director_base //
anv_mapfixes.nut //anv
mode //coop twice
director_base // twice
local script //

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
