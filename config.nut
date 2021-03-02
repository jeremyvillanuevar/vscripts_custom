/*
 所有true 和 false 都可以用 1或者0来代替。
 
 所有配置参数都在该文件中
 功能说明在coop文件中
 
 防止：如果出现一些参数污染
 脚本本体中有些地方直接使用未::变量。如果出现与配置文件对于名字的配置参数寻找不到的红字。需要在本体文件中添加::

All true and false can be replaced by 1 or 0.
 
  All configuration parameters are in this file
  The function description is in the coop file
 
  Prevention: If some parameter pollution occurs
  Some places in the script body directly use un::variables. If there are red letters that cannot be found for the configuration parameters of the name in the configuration file. Need to add in the ontology file::
*/



::__COOP_VERSION__ <- 9.3;
::COOP <- {GlobalCache={}};

/******************* Parámetro de modo realista ** ejemplo de configuración de convar ******* ¿Agregado de acuerdo con el formato, porque algunas de las actualizaciones del juego no son válidas? *************/
/*******************写实模式参数**convar设置例子*******按照格式添加，因为游戏更新某些产生无效？*************/
//Cuando el jugador está separado por una pared y no puede ver el contorno del oponente
// sv_disable_glow_survivors 1   当 玩家隔墙而视 看不到对方轮廓
//No puedo ver el contorno de objetos distantes
// sv_disable_glow_faritems 1    看不到远处物品轮廓
//Cerrar El inodoro resucita. Los jugadores en campañas normales resucitarán en el baño.
// sv_rescue_disabled 1               关闭 厕所复活。普通战役玩家时候会在厕所复活。
// z_non_head_damage_factor_multiplier 0.5  
// z_head_damage_causes_wounds 1
// z_use_next_difficulty_damage_factor 1
// Ignora la dificultad del juego, la bruja matará con un golpe, pero la puerta nunca se romperá [sin modificación del script].
// z_witch_always_kills 1           //忽略游戏难度，witch一击必杀，但是门永远打不破【在没有用脚本修改的条件下】。
// La prueba encontró que ahora solo se puede modificar el modo de campaña normal. El modo de realismo no es válido después de la modificación.
//Convars.SetValue( "sv_rescue_disabled", "1" ); //测试发现现在只能修改普通战役模式。写实模式修改之后无效。
//Convars.SetValue( "sv_disable_glow_survivors", "1" );
/*  ==================================Parámetro de configuración===配置参数=================================== */

// Allow special sense when the tank is in
// Permitir especiales cuando el tanque está en
::AllowSpecialsWithTank <- false;     //坦克在的时候允许刷特感

//When the tank is in, the corpse tide is allowed to be swept.
//Cuando el tanque está adentro, se permite la marea de cadáveres.
::AllowMobsWithTank <- false;        	//坦克在的时候允许刷尸潮。

//Solo mode, only you have no computer if you need self-help function
// Modo para un jugador, solo uno mismo sin una computadora, si se necesita la función de autoayuda
::SoloMode <- 0 ;                               //單人模式，只有自己沒有電腦 如果需要自救功能

//Whether to allow the control to save itself immediately after falling to the ground. false means not to start true means to start
// Si está permitido controlarse después de caer al suelo. falso significa no comenzar verdadero significa comenzar
::AutoRevive<- false;                               //是否允许控制倒地后立即自救。false为不启动 true为启动

//By default, it is allowed to fall to the ground 2 times, 0 is 1 life, and it is dead if it falls to the ground
// Por defecto, está permitido caer al suelo 2 veces, 0 es 1 vida, y mueres cuando caes al suelo
::MaxIncapacitatedCount <- 2;         //默认允许倒地2次  0為1命 ，倒地即死

//Whether to enable infinite mob. false Turn off infinite mob [The mob refresh time has been set internally]
// Si activar la marea de cadáveres infinita. falso Desactiva la marea de cadáveres infinita [El tiempo de actualización de la mafia se ha establecido internamente]
::InfHordes <- false;						   //是否開啓無限尸潮。false 關閉無限尸潮 [已经内部设置mob刷新时间]

//Infinite bullets, only the main and secondary weapons are infinite. false is off, true is on
::InfAmmo <- false;                          //无限子弹，仅仅主副武器无限. false关闭 true开启

////Tank damage ratio 0.0-1.0, 1.0 is 100% default damage. For example: 0.5 is half of the original damage, and the damage of an expert mode player under 100 full blood is 50
// La relación de daño del tanque 0.0-1.0, 1.0 es 100% de daño predeterminado. Por ejemplo: 0.5 es la mitad del daño original, y el daño de un jugador en modo experto con menos de 100 sangre completa es 50
::TankHitDamage <- 1.0;                  //坦克傷害比例 0.0-1.0，1.0是100%默認傷害。例如：0.5是原來傷害的一半，專家模式玩家100滿血下挨一下傷害為50

//Whether the witch can destroy the ordinary door, has nothing to do with the mode true, any mode can be destroyed with one blow, false cannot be destroyed
//Si la bruja puede destruir la puerta ordinaria no tiene nada que ver con el modo. Verdadero, cualquier modo puede ser destruido de un solo golpe, falso no puede ser destruido.
::DoorCanBreakByWitch <- true;    //witch 是否能破壞普通門，與模式無關  true 任何模式可以一擊破壞，false  無法破壞

//Whether it is allowed to swipe small zombies 1 means no zombies 0 means there are zombies, special express code, will not brush small zombies after opening. The number of zombies and the time of the corpse tide have been modified internally.
//Si está permitido deslizar pequeños zombis 1 significa que no hay zombis 0 significa que hay zombies, código expreso especial, no cepillará pequeños zombis después de abrir. El número de zombis y el tiempo de marea de cadáveres se han modificado internamente.
::NoZombie <- 0;                             //是否允許擁刷小僵尸 1是無僵尸 0 是有僵尸，特感速遞代碼，開啓後不會刷小僵尸。内部已修改僵尸數量和尸潮時間。

//Whether it is allowed to generate tanks and witches, tank parameters are not allowed in the first chapter of the map 0: no block, 1: block
::BlockTankWitch <- 0;                   //是否允許產生坦克和witch,地图第一章节不允许出现坦克参数 0：不屏蔽，1：屏蔽

//0 is not enabled. Original c1m4 13 barrels c6m3 16 barrels If it is larger than the default value, it will be filled with oil according to the requirements of the official original script.
::NumCansNeeded<- 4;                //0 为不启用  原始 c1m4  13桶 c6m3 16桶  如果大于默认值，会按照官方原来脚本的设定需求灌油。
/*
0.不做任何修改 
1.藥役                      藥包替換為藥瓶
2.藥役+t1武器              在1的基礎上替換所有t2類武器為t1武器。難度增加
3.t1武器                   替換所有t2武器為t1 【t2武器為連噴 ak47等，t1武器為單噴和smg機槍等。cs武器為隱藏武器只有4把，該脚本已經解鎖并且增加了傷害倍率】
*/
/*
0. Do not make any changes
1. Pharmacy: Replace the medicine pack with medicine bottle
2. Drug service + t1 weapon Replace all t2 weapons with t1 weapons on the basis of 1. Increased difficulty
3. T1 weapons Replace all t2 weapons with t1 [t2 weapons are continuous spray ak47, etc., t1 weapons are single spray and smg machine guns, etc. There are only 4 cs weapons as hidden weapons, the script has been unlocked and the damage rate has been increased]
*/
::ConvertType<- 0;       

//Directly start the game to give the player random melee and t1 main weapon-melee is limited by UnlockMelee diversity
::AllowGiveItem <- 1;  //直接开局给予玩家 随机近战 和 t1主武器 -近战受到 UnlockMelee 限制多样性

//Unlimited oil for chainsaw
::InfiniteFuel <- 0;      //电锯无限油

//Are rescues allowed?//Campaign mode players can be rescued in the toilet after 1 minute by default after death
//::AllowRescue <- 1; //是否允许营救//战役模式玩家死亡后默认1分钟后可以在厕所被营救

//Bleeding mode//Automatically set ConvertType=1 after opening
::BleedOut <- 0; //流血不止模式//开启后自动设置ConvertType=1

//====================Configuración de parámetros de marea de cadáveres y zombis==僵尸与尸潮参数设定===================================//
// El número de zombis básicos: se puede considerar como el número de zombis zombies + el número de zombis que deambulan frente al mapa
::Base_Zombie  <- 30;                  			  //基础小僵尸数量    -可视为尸潮僵尸数量+地图前路徘徊僵尸数量
// Tiempo de mob. Este valor solo está limitado al modo de mob infinito
// y ha sido asignado en el código. La modificación de la configuración no es válida
::Mob_Time  <- [2,5];                    //尸潮时间  该值只限于无限尸潮模式使用 并且已经代码内赋值。配置修改无效
// El número de cadáveres
::Mob_Size  <- [15,30];                    //尸潮数量
// Cuando el número de cadáveres es mayor que el número básico de zombis,
// este valor determina cuántos zombis se pueden reservar para la producción.
//How many infected can be left pending to spawn when the mob size is larger than CommonLimit./
::Mob_MaxPend <- 80; 	   //当尸潮数量大于基础小僵尸数量，该值决定多少小僵尸可以预留待产。

//===================Configuración de parámetros de cantidad de sentido especial===特感数量参数设定===================================//
////////////////////////////Descripción////说明//////////////////////////////////
/*
AutoMode自动模式附带自动增量参数。
Max_SI 最大特感数量，不分自动还是固定模式

设置每增加几个玩家增加多少个特感。
例如：每1个玩家增加1个特感为[1,1]. 
注意：服务器第一个玩家不做计算。如 4人实际上只增加了3个玩家，因为第一个玩家相当于只承受默认的特感数量设置。
Add_SI<-[2,1];                   

SISpilt 特感类型对照表 [Boomer,Spitter,Smoker,Hunter,Charger,Jockey]


El AutoMode (modo automático) viene con parámetros de incremento automático.
Max_SI Número máximo de sentidos especiales, independientemente del modo automático o fijo

Establezca cuántos SI se agregan para cada jugador adicional.
Por ejemplo: cada jugador agrega 1 sentimiento especial a [1,1].
Nota: El primer jugador en el servidor no hace cálculos. Por ejemplo, 4 jugadores en realidad solo agregan 3 jugadores, porque el primer jugador equivale a aceptar solo el número predeterminado de efectos especiales.
Add_SI <- [2,1];

Tabla de comparación de tipos de SI: SISpilt [Boomer, Spitter, Smoker, Hunter, Charger, Jockey]

*/
//////////////////////////////////////////////////////////////////
// El valor predeterminado original del modo de campaña es 3 especiales.
::Max_SI <- 3;       			//战役模式原始默认值 3 特。

// Cuando AutoMode es verdadero, el modo fijo no es válido automáticamente. Max_SI no es válido automáticamente.
// Si se activa el modo de ajuste automático de cantidad [Al mismo tiempo, el número de tipos de detección especiales es aleatorio]
//当AutoMode为true 固定模式自动无效 Max_SI自动无效
::AutoMode <-false;          //是否开启自动调整数量模式 【同时特感种类数量随机】

// Establece el número de cada SI. Si se establece en 0, este tipo de SI no aparecerá.
// Bajo la condición de que AutoMode sea verdadero, el número de sentidos especiales es el valor máximo. El valor mínimo es 0 por defecto.
//设置每种特感的数量 。设置为0 则不出现该类型特感。
//在AutoMode为true的条件下 特感数量数值为最大值。最小值默认为0.
Boomer  <- 1;
Spitter  <- 1;
Smoker  <- 1;
Hunter  <- 1;
Charger  <- 1;
Jockey  <- 1;
// Controla cuántos jugadores aumentan y cuántos sentimientos especiales - nota: cuando el número de jugadores es 1, el jugador único no aumentará ningún punto.
// Tenga en cuenta que el cálculo del número real de jugadores se ve afectado por AllowShowBotSurvivor. Cuando está encendido, el bot superviviente se calcula como el incremento del número de jugadores.
// [Número de jugadores, número de sentidos especiales] Actualmente, se agrega 1 sensación especial por cada dos jugadores, el modo de 4 jugadores son 4 especiales
//控制多少个玩家增加多少只特感--注意：当玩家数量为1的时候，该唯一玩家不会增加任何只。
//注意实际玩家数量计算 受AllowShowBotSurvivor的影响。开启即计算生还者bot作为玩家数量增量。
::Add_SI<-[2,1];         //[玩家数量,特感数量]    当前为每两个玩家增加1个特感  4人模式则为4特

::SISpilt<-[Boomer,Spitter,Smoker,Hunter,Charger,Jockey];  				 //設置每次刷特時，同類  特感  的數量 


//== Tiempo de actualización ==== Predeterminado 45 Interbloqueo 15 ====== Calculado en segundos ==================
//======================刷新时间====默认45 绝境求生15======以秒算===================//
/*
SpecialSpawnDelay区间配置特感速递参数。用于特感速递快速刷特指标。影响特感准备复活到出现在地图的时间
Base_SI_Time 控制特感死亡到准备复活时间
首先脚本用director是游戏自己的系统刷特感，而不是强制产生。脚本可以与插件一样实现强制刷特，但是该脚本并没有这么做。
由于脚本控制整个地图刷特设计流程，在一些情况下会有其他一些脚本介入。强制停止director刷特感刷僵尸，来控制游戏节奏。
所以本脚本会很原则的按照原来的设计来控制特感数量。例如一些开机关的时候，游戏作者设计其他脚本呼叫director进入静止状态。
换言之，原版游戏是怎么样刷特，本脚本也会怎么样刷特，控制的只是数量的多少。
/////////////////////////////////////////
La sección SpecialSpawnDelay está configurada con parámetros especiales de entrega urgente. Se utiliza para cepillar rápidamente indicadores especiales para envíos urgentes especiales. El sentimiento especial de influencia está listo para resucitar al momento en que aparece en el mapa.
Base_SI_Time controla el tiempo desde la muerte hasta la preparación para la resurrección
En primer lugar, el director del guión es el sentido refrescante del propio sistema del juego, en lugar de la generación forzada. La secuencia de comandos puede implementar el desove forzado al igual que el complemento, pero la secuencia de comandos no lo hace.
Dado que la secuencia de comandos controla todo el proceso de diseño de cepillado del mapa, en algunos casos habrá otras secuencias de comandos involucradas. Evita por la fuerza que el director cepille a los zombies para controlar el ritmo del juego.
Entonces, este script controlará el número de sentimientos especiales en principio de acuerdo con el diseño original. Por ejemplo, cuando se abren algunos órganos, el autor del juego diseña otros guiones para llamar al director para que entre en estado estático.
En otras palabras, cómo se actualiza el juego original, el script también se actualizará, solo se controla la cantidad.
*/
// Tiempo base de SI
::Base_SI_Time  <- 45;                            //基础特感时间   
// El modo SI FAST se caracteriza por la capacidad de limpiar especiales cuando se abre la puerta.
// SI no se eliminará con cuidado, sino que se eliminará constantemente.
::FastMode <- true;                                //特感速递模式  特点是 开门即刷特。特感不会整齐的刷出来，而是不断的刷出
// La configuración del tiempo de inicialización del SI debe estar habilitada con FastMode para que sea efectiva
//[Control de los parámetros Fast del SI]
::SpecialSpawnDelay<-[0,2];                  //特感初始化時間設置 必须 FastMode 开启才有效 [控制特感速递参数]




/// Mostrar muertes de jugadores ///// Por razones de exhibición, solo se muestran los cuatro primeros
///////////////////////////////////显示玩家击杀/////因为显示原因所以只显示前四名///////////////////////////
// Interruptor de visualización de clasificación
::Show_Player_Rank<-true;                            //排行显示开关
// Si se permite la visualización de estadísticas de muerte de la computadora. Dado que el reproductor puede sobrescribir el índice de la computadora, las estadísticas de la computadora se borrarán después de que el jugador real muera y se vaya, o es posible que no se muestren directamente.
::AllowShowBotSurvivor <- false;                 //是否允许显示电脑的击杀统计。由于电脑的index可能会被玩家覆盖，所以会出现真实玩家死亡离开后电脑统计被清空，或者直接不显示的情况


///////////////////////////////////// Controla la cantidad de artículos recogidos
///////////////////////////////////控制物品拾取次数 ///////////////////////////
///////////////////////////////////Control the number of items picked up/////////// ////////////////
// El número de recolecciones de todas las armas
::Gun_Count <- 4;                                           //所有枪类拾取次数 
// El número de veces que se recogen todas las clases de lanzamiento
::Throw_Count <- 1;										    //所有投掷类拾取次数 
// Número de recogidas de todos los medicamentos
::Pill_Count <- 1;                                          //所有药品类拾取次数
// El número de recolecciones para todos los tipos de cuerpo a cuerpo
::Melee_Count <-1;										    //所有近战类拾取次数


//////////// La pantalla de barra de sangre especial es adecuada principalmente
/////////////////////////特感血条显示 主要适用于坦克 ///////////////////////////
// Muestra la barra de estado de sugerencia false true
::SIBar_Show <- true;                                //显示hint血条 false  true
// El tipo de barra de sangre se divide en dos tipos: 9999 y emoji display. True es un símbolo y falso es un número.
::SIBar_type <-  true;								//血条类型 分为数字显示9999和表情符号显示两种   true为符号 false为数字


//////////////////Recuperación de HP, recuperación de bala, caída de artículos
/////////////血量回復 子弹回复 物品掉落///////////
/*
 计算公式  （healreg +  headshot_add）*DifRate 
 headshot_add 非必须 比如坦克和witch没添加
 Fórmula de cálculo (healreg + headshot_add) * DifRate
  headshot_add no es necesario, como el tanque y la bruja no se agregaron
*/

// Efecto de trofeo de disparo a la cabeza//爆頭獎杯效果
// 1: On 0: Off El efecto que se muestra en la cabeza del jugador después de matar el tiro a la cabeza
::headshotcup<- 0;          //1：開啓 0：關閉  擊殺爆頭特感后顯示在玩家頭上的效果
::tankcup<- 1;          //1：開啓 0：關閉  擊殺爆頭特感后顯示在玩家頭上的效果
// Caída del artículo//物品掉落
// true on false off si está permitido abrir el código de caída del artículo
::AllowLoot<-false ;                          //true 开 false 关  是否允许开启 物品掉落代码
// Matar sentido especial, tanque de probabilidad de caída y caída de bruja al 100%
//::loot_chance <- 60.0;                         //击杀特感 掉落幾率  tank和witch 100% 掉落
// Serie de respuestas//回复系列
// true on false off si se habilita toda la función de suministro de eliminación. 
//Incluyendo muertes, devolución de sangre, muertes para ahorrar balas.
::AllowRegained <- false;          //true 开 false 关  是否开启整个击杀补给函数。包含击杀回血击杀给备用子弹。
// Recupera el rango de HP después de matar
//::healreg <- [3,5];                           //擊殺后回復血量区间
// Headshot HP restaura el valor de aumento de HP
//::headshot_add <- 2;                        //爆頭血量回復血量增加值
// Establece el multiplicador del volumen de sangre de recuperación según la dificultad. Por ejemplo, el daño del jugador del ataque del toro de diferente dificultad es 5 10 15 20 , entonces el jugador se puede recuperar 3 6 9 12 puntos de sangre según la dificultad Cobra vida
//::DifRate <-[1,2,3,4];                       //根据难度设置回复血量的倍率 例如不同难度牛普攻玩家伤害为 5 10 15 20  那么可以根据难度回复玩家3 6 9 12 点血来续航 
// Dona sangre después de matar el tanque
//::tankgiveheal <- 50;								//擊殺坦克后給與血量
// Da HP después de matar a la bruja
//::witchgiveheal <- 50;								//擊殺witch后給與血量

///////////////// Mata la bala de recuperación del sentido especial
////////////////擊殺特感回復子彈/////
/*
每擊殺一隻特感，补充一部分子彈。以保持在高難度的情況下不修改備用彈藥數量來續航。
[最小數量,最大數量]
如果不想恢复子弹，那么设置为[0,0]
Cada vez que se mata un SI, se agrega una parte de la bala. 
Para mantener la cantidad de munición de repuesto en una situación difícil sin modificar la duración de la batería.
[Cantidad mínima, cantidad máxima]
Si no desea recuperar la viñeta, configúrela en [0,0]
*/
/*
// La cantidad de balas devueltas por la clase de spray
::shotgunammo<-[2,5];			//喷子类回复子弹量						
// Las balas de recuperación tipo ametralladora son principalmente ametralladoras T1 dos smg
::smgammo<-[15,30];			//机枪类回复子弹量		主要是T1 两把smg机枪	
// Rifle de ametralladora Este tipo es más complicado, la primera generación de rifle de francotirador también se incluye en el rifle, m60
::rifleammo<-[15,30];			//机枪类 rifle	这类比较杂，一代狙击来复枪 也包含在rifle，m60
// Tipo de francotirador matar y restaurar balas de repuesto
::sniperammo<-[5,10];			//狙击类 	 击杀 回复备用子弹量		
// Granada mata y restaura balas de repuesto
::grenadeammo<-[1,3];			//榴弹 击杀 回复备用子弹量		
*/
// Este parámetro debe coincidir con la extensión dll de la plataforma de complementos
// Descarga del autor original [EXTENSION] [L4D2] Melee Spawn Control (1.0.0.4)
//该参数必须配合插件平台的扩展dll
//原作者下载 https://forums.alliedmods.net/showthread.php?t=222535
//度盘转载 https://pan.baidu.com/s/1sl2VABb
// Si se debe permitir que se inicien los elementos de aterrizaje cuerpo a cuerpo
::AllowSpawnMelee<- false;   //是否允许开局给近战 落地物品
// ¿Está desbloqueada la extensión dll del complemento MeleeSpawnControl? Hay una imagen completa de cuerpo a cuerpo completo disponible [Siempre que el parche de desbloqueo de cuerpo a cuerpo esté instalado, puede usarlo. No es necesario que use el dll ]
::UnlockMelee<- false;             //是否安装了MeleeSpawnControl插件dll扩展解锁 全近战全图可用 【只要安装了近战解锁补丁，就可以使用 并非一定要用该dll】






