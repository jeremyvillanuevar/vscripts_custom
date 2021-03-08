printl( "\n\n\n\n==============ANNOUNCE DIRECTOR STATUS ===============\n\n\n\n");
//-----------------------------------------------------
//

	
::numTypetoTypeString <- function (type)
{
	if (type==0)
		return "PANIC"
	if (type==1)
		return "TANK"
	if (type==2)
		return "DESCANSO"	
	if (type==-1)
		return "RESCATE"	
	return type
}
	
	
::AttachParticleCongrats <- function(ent,particleName = "", duration = 0.0)
{	
	if (particleName==null)
		particleName="achieved"
	local particle = g_ModeScript.CreateSingleSimpleEntityFromTable({ classname = "info_particle_system", targetname = "info_particle_system" + UniqueString(), origin = ent.GetEyePosition(), angles = QAngle(0,0,0), start_active = true, effect_name = particleName });
	if (!particle)
	{
		printl("Advertencia: No se pudo crear la entidad de partículas.");
		//printl("警告:创建粒子实体失败.");
		return;
	}
	DoEntFire("!self", "Start", "", 0, null, particle);
	DoEntFire("!self", "Kill", "", duration, null, particle);
	AttachOther(PlayerInstanceFromIndex(ent.GetIndex()),particle, true,ent.GetEyePosition());
}