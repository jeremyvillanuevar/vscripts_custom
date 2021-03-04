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
