//------------ SYS Tune vehicle modify porirz to intSecret -----------------------//

#include <YSI_Coding\y_hooks>

// เงินที่จะเสียเมื่อจูน (SERVICE_CHARGE * speed / 1000)
#define SERVICE_CHARGE 30

// ค่าสูงสุดที่ปรับจูนได้
#define TUNE_MAX 3000

static tuneVehID[MAX_PLAYERS], tuneTimerBoost[MAX_PLAYERS];

new Float:pTuneEngine[MAX_PLAYERS];

static Float:g_SpeedThreshold;
static const
	KEY_VEHICLE_FORWARD  = 0b001000,
	KEY_VEHICLE_BACKWARD = 0b100000;

hook OnPlayerSpawn(playerid){
    pTuneEngine[playerid] = 0.0;
    tuneVehID[playerid] = 0;
    return 1;
}

hook OnPlayerDisconnect(playerid, reason){
    pTuneEngine[playerid] = 0.0;
    tuneVehID[playerid] = 0;
    KillTimer(tuneTimerBoost[playerid]);
    return 1;
}
//------------- Command ---------------//
//alias:vehtune("จูนรถ")
CMD:motetune(playerid, const params[]){

    new speed;
    if(playerData[playerid][pMaster]){
	    if(sscanf(params, "d", speed)) return SendClientMessage(playerid, 0xFF5733FF, "[จูนรถ] /vehtune [0 - "#TUNE_MAX"]");
	    if(speed > TUNE_MAX || speed < 0) return SendClientMessage(playerid, 0xFF5733FF, "[จูนรถ] ค่าจูนรถควรอยู่ที่ 0 - "#TUNE_MAX"");

	    new checkMoney = (SERVICE_CHARGE * speed)/100;
	    /*if(playerData[playerid][pPoint] < checkMoney) return SendClientMessageEx(playerid, 0xFF5733FF, "[จูนรถ] pointของคุณไม่พอ, คุณต้องใช้เงิน %s สำหรับจูนรถ %d เปอร์เซ็น", FormatMoney(checkMoney), speed);
*/
		pTuneEngine[playerid] = (speed / 4.0) / 1000.0;
	    SendClientMessageEx(playerid, 0x8AFF33FF, "[จูนรถ] คุณได้ปรับจูนยานพาหนะคันนี้เรียบร้อย (ประสิทธิภาพ +%d) {FF5733}-%s", speed, FormatMoney(checkMoney));
	    //playerData[playerid][pPoint] -= checkMoney;
	}
	return 1;
}


hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
	{
	    tuneVehID[playerid] = GetPlayerVehicleID(playerid);
		tuneTimerBoost[playerid] = SetTimerEx("VehicleEngine", 200, true, "dd", playerid, tuneVehID[playerid]);
        new speed = carData[tuneVehID[playerid]][carTune];
		pTuneEngine[playerid] = (speed / 4.0) /1000.0;
	}
	else
	{
	    tuneVehID[playerid] = 0;
	    pTuneEngine[playerid] = 0.00;
	    KillTimer(tuneTimerBoost[playerid]);
	}
    return 1;
}

forward VehicleEngine(playerid, vehicleid);
public VehicleEngine(playerid, vehicleid)
{
	if(!IsPlayerInAnyVehicle(playerid))
	    return KillTimer(tuneTimerBoost[playerid]);
	    
	new
		keys,
		Float:vx,
		Float:vy,
		Float:vz
	;

	new Float:SPEED_MULTIPLIER = 1.0 + pTuneEngine[playerid];

	GetPlayerKeys(playerid, keys, _:vx, _:vx);

	if ((keys & (KEY_VEHICLE_FORWARD | KEY_VEHICLE_BACKWARD | KEY_HANDBRAKE)) == KEY_VEHICLE_FORWARD)
	{

		GetVehicleVelocity(vehicleid, vx, vy, vz);

		if (vx * vx + vy * vy < g_SpeedThreshold)
			return 0;

		vx *= SPEED_MULTIPLIER;
		vy *= SPEED_MULTIPLIER;

		if (vz > 0.04 || vz < -0.04)
			vz -= 0.020;

		SetVehicleVelocity(vehicleid, vx, vy, vz);
	}
	return 1;
}

CMD:trunk(playerid, params[])
{
	new
		Msg[128],
	    id = GetNearbyVehicle(playerid);

	new FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper;
	GetVehiclePanelsDamageStatus(id, FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper);

	if(carData[id][carLocked])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถเปิดท้ายยานพาหนะได้ เนื่องจากยานพาหนะถูกล็อค!");

	if (!GetTrunkStatus(id))
	{
		SetTrunkStatus(id, true);

		format(Msg, sizeof(Msg), "** %s ได้เปิดฝากระโปรงหลังรถ ของยานพาหนะ %s", GetPlayerNameEx(playerid), ReturnVehicleName(id));
		SetPlayerChatBubble(playerid, Msg, COLOR_PURPLE, 10.0, 5000);
		//SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้เปิดฝากระโปรงหลังรถ (Trunk)", GetPlayerNameEx(playerid));

	}
	else
	{
		SetTrunkStatus(id, false);

		format(Msg, sizeof(Msg), "** %s ได้ปิดฝากระโปรงหลังรถ ของยานพาหนะ %s", GetPlayerNameEx(playerid), ReturnVehicleName(id));
		SetPlayerChatBubble(playerid, Msg, COLOR_PURPLE, 10.0, 5000);
		//SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ปิดฝากระโปรงหลังรถ (Trunk)", GetPlayerNameEx(playerid));
	}
	PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
	return 1;
}


IsPlayerNearBoot(playerid, vehicleid, Float:dist = 1.5)
{
	new
		Float:fX,
		Float:fY,
		Float:fZ;

	GetVehicleBoot(vehicleid, fX, fY, fZ);

	return (GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vehicleid)) && IsPlayerInRangeOfPoint(playerid, dist, fX, fY, fZ);
}
GetVehicleBoot(vehicleid, &Float:x, &Float:y, &Float:z)
{
	if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID)
	    return (x = 0.0, y = 0.0, z = 0.0), 0;

	new
	    Float:pos[7]
	;
	GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]);
	GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]);
	GetVehicleZAngle(vehicleid, pos[6]);

	x = pos[3] - (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees));
	y = pos[4] - (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees));
 	z = pos[5];

	return 1;
}




IsPlayerNearHood(playerid, vehicleid, Float:dist = 1.5)
{
	new
		Float:fX,
		Float:fY,
		Float:fZ;

	GetVehicleHood(vehicleid, fX, fY, fZ);

	return (GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vehicleid)) && IsPlayerInRangeOfPoint(playerid, dist, fX, fY, fZ);
}
GetVehicleHood(vehicleid, &Float:x, &Float:y, &Float:z)
{
	if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID)
	    return (x = 0.0, y = 0.0, z = 0.0), 0;

	new
	    Float:pos[7]
	;
	GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]);
	GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]);
	GetVehicleZAngle(vehicleid, pos[6]);

	x = pos[3] + (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees));
	y = pos[4] + (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees));
 	z = pos[5];

	return 1;
}

stock GetHoodStatus(vehicleid)
{
	new
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (bonnet != 1)
		return 0;

	return 1;
}
