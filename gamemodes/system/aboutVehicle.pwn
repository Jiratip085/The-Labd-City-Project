#include	<YSI_Coding\y_hooks>

#define 	MAX_PAWNVEH 			(50)

enum PAWNVEH_DATA {
	PawnVehID,
	PawnVehExists,
	Float:PawnVehPosX,
	Float:PawnVehPosY,
	Float:PawnVehPosZ,
	Text3D:PawnvehText3D,
	PawnvehPickup
};
new pawnvehData[MAX_PAWNVEH][PAWNVEH_DATA];

forward Pawnveh_Load();
public Pawnveh_Load()
{
	static
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_PAWNVEH)
	{
	    pawnvehData[i][PawnVehExists] = true;

	    cache_get_value_name_int(i, "PawnVehID", pawnvehData[i][PawnVehID]);
	    cache_get_value_name_float(i, "PawnVehPosX", pawnvehData[i][PawnVehPosX]);
	    cache_get_value_name_float(i, "PawnVehPosY", pawnvehData[i][PawnVehPosY]);
	    cache_get_value_name_float(i, "PawnVehPosZ", pawnvehData[i][PawnVehPosZ]);

	    Pawnveh_Refresh(i);
	}
	printf("[SERVER]: %i PawnVeh were loaded from \"%s\" database...", rows, MYSQL_DATABASE);
	return 1;
}

forward OnPawnVehCreated(pawnvehid);
public OnPawnVehCreated(pawnvehid)
{
	if (pawnvehid == -1 || !pawnvehData[pawnvehid][PawnVehExists])
	    return 0;

	pawnvehData[pawnvehid][PawnVehID] = cache_insert_id();
	Pawnveh_Save(pawnvehid);

	return 1;
}

Pawnveh_Nearest(playerid)
{
    for (new i = 0; i != MAX_PAWNVEH; i ++) if (pawnvehData[i][PawnVehExists] && IsPlayerInRangeOfPoint(playerid, 4.0, pawnvehData[i][PawnVehPosX], pawnvehData[i][PawnVehPosY], pawnvehData[i][PawnVehPosZ]))
	{
		return i;
	}
	return -1;
}

Pawnveh_Delete(pawnvehid)
{
	if (pawnvehid != -1 && pawnvehData[pawnvehid][PawnVehExists])
	{
	    static
	        string[64];

        if (IsValidDynamicPickup(pawnvehData[pawnvehid][PawnvehPickup]))
		    DestroyDynamicPickup(pawnvehData[pawnvehid][PawnvehPickup]);

		if (IsValidDynamic3DTextLabel(pawnvehData[pawnvehid][PawnvehText3D]))
		    DestroyDynamic3DTextLabel(pawnvehData[pawnvehid][PawnvehText3D]);

		mysql_format(g_SQL, string, sizeof(string), "DELETE FROM `pawnveh` WHERE `PawnVehID` = '%d'", pawnvehData[pawnvehid][PawnVehID]);
		mysql_tquery(g_SQL, string);

		pawnvehData[pawnvehid][PawnVehExists] = false;
		pawnvehData[pawnvehid][PawnVehID] = 0;
	}
	return 1;
}

Pawnveh_Create(Float:x, Float:y, Float:z)
{
	for (new i = 0; i < MAX_PAWNVEH; i ++) if (!pawnvehData[i][PawnVehExists])
	{
	    pawnvehData[i][PawnVehExists] = true;
	    pawnvehData[i][PawnVehPosX] = x;
	    pawnvehData[i][PawnVehPosY] = y;
	    pawnvehData[i][PawnVehPosZ] = z;

	    mysql_tquery(g_SQL, "INSERT INTO `pawnveh` (`pawnvehID`) VALUES(0)", "OnPawnVehCreated", "d", i);
		Pawnveh_Refresh(i);
		return i;
	}
	return -1;
}

Pawnveh_Save(pawnvehid)
{
	static
	    query[220];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE `pawnveh` SET `PawnVehPosX` = '%.4f', `PawnVehPosY` = '%.4f', `PawnVehPosZ` = '%.4f' WHERE `PawnvehID` = '%d'",
	    pawnvehData[pawnvehid][PawnVehPosX],
	    pawnvehData[pawnvehid][PawnVehPosY],
	    pawnvehData[pawnvehid][PawnVehPosZ],
	    pawnvehData[pawnvehid][PawnVehID]
	);
	return mysql_tquery(g_SQL, query);
}

Pawnveh_Refresh(pawnvehid)
{
	if (pawnvehid != -1 && pawnvehData[pawnvehid][PawnVehExists])
	{
		if (IsValidDynamicPickup(pawnvehData[pawnvehid][PawnvehPickup]))
		    DestroyDynamicPickup(pawnvehData[pawnvehid][PawnvehPickup]);

		if (IsValidDynamic3DTextLabel(pawnvehData[pawnvehid][PawnvehText3D]))
		    DestroyDynamic3DTextLabel(pawnvehData[pawnvehid][PawnvehText3D]);

		pawnvehData[pawnvehid][PawnvehPickup] = CreateDynamicPickup(19130, 23, pawnvehData[pawnvehid][PawnVehPosX], pawnvehData[pawnvehid][PawnVehPosY], pawnvehData[pawnvehid][PawnVehPosZ]);
  		pawnvehData[pawnvehid][PawnvehText3D] = CreateDynamic3DTextLabel("[กู้ซากยานพาหนะ]\n{FF6347}(ราคา: $5,000)\n{AAAAAA}กด 'Y' เพื่อใช้งาน", COLOR_ORANGE, pawnvehData[pawnvehid][PawnVehPosX], pawnvehData[pawnvehid][PawnVehPosY], pawnvehData[pawnvehid][PawnVehPosZ], 7.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0);
	}
	return 1;
}

// --> กู้รถ
CMD:createpawnveh(playerid, params[])
{
	static
	    id = -1,
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

    if (playerData[playerid][pAdmin] < 5)
	    return 1;

	if (GetPlayerInterior(playerid) != 0)
	    return 1;

	id = Pawnveh_Create(x, y, z);

	if (id == -1)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ความจุของที่กู้ยานพาหนะในฐานข้อมูลเต็มแล้ว ไม่สามารถสร้างได้อีก (ติดต่อผู้พัฒนา)");

	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้สร้างที่กู้รถขึ้นมาใหม่ ไอดี: %d", id);
	return 1;
}

CMD:removepawncar(playerid, params[])
{
	static
	    id = 0;

    if (playerData[playerid][pAdmin] < 5)
	    return 1;

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, COLOR_WHITE, "การใช้งาน : /removepawncar [ไอดี]");

	if ((id < 0 || id >= MAX_PAWNVEH) || !pawnvehData[id][PawnVehExists])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่พบไอดีพาวว์รถนี้ในฐานข้อมูล");

	Pawnveh_Delete(id);
	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้ที่พาวว์รถไอดี %d ออกสำเร็จ", id);
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, listitem, oldkeys)
{
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
		if (Pawnveh_Nearest(playerid) != -1)
		{
			new query[128];
			mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `vehicles` WHERE `carOwnerID` = %d AND `carDestroy` = 1", playerData[playerid][pID]);
			mysql_tquery(g_SQL, query, "OnQueryFinished", "dd", playerid, THREAD_LIST_CAR_DESTROY);
			return 1;
		}
	}
	return 1;
}









hook OnGameModeInit()
{
	SetTimerEx("RespawnAllVehicles", 60000*60, false, "d", 1);
}



new g_RespawnVehicle;
new g_RespawnVehicleTime;

task RespawnVenicleTimer[1000]()
{
    RespawnVenicleCheck();
}
stock RespawnVenicleCheck()
{
	new
	    time[3],
		string[32];
	
	if (g_RespawnVehicle == 1 && !g_RespawnVehicleTime)
	{
		new count;
		for (new i = 1; i != MAX_VEHICLES; i ++)
		{
			if (IsValidVehicle(i) && GetVehicleDriver(i) == INVALID_PLAYER_ID && GetVehicleDriverGarageDx(i))
			{
				SetVehicleToRespawn(i);
				count++;
			}
			if(carData[i][carOwnerID] > 0 && IsVehicleOccupied(i))
			{
				DespawnVehicle(i);
			}
			g_RespawnVehicle = 0;
			g_RespawnVehicleTime = 0;
		}
		for (new i = 0; i < 2; i ++) {
			TextDrawHideForAll(RevehTD[i]);
		}
		SendClientMessageToAll(COLOR_YELLOW, "[Respawn Vehicle] รียานพาหนะภายในเซิร์ฟเวอร์สำเร็จเรียบร้อย");
		SetTimerEx("RespawnAllVehicles", 60000*60, false, "d", 1);
	}
	else if (g_RespawnVehicle == 1) 
	{
		GetElapsedTime(g_RespawnVehicleTime--, time[0], time[1], time[2]);

		format(string, sizeof(string), "Respawn Vehicle: ~r~%02d:%02d", time[1], time[2]); // รีรถ
	    TextDrawSetString(RevehTD[0], string);
	    /*foreach (new i : Player)
	    {
	    	PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
		}*/
	}
	return 1;
}



CMD:reveh(playerid, params[])
{
    if (playerData[playerid][pAdmin] < 1)
	    return 1;

	new count;
	for (new i = 1; i != MAX_VEHICLES; i ++)
	{
		if (IsValidVehicle(i) && GetVehicleDriver(i) == INVALID_PLAYER_ID && GetVehicleDriverGarageDx(i))
		{
			SetVehicleToRespawn(i);
			count++;
		}
		if(carData[i][carOwnerID] > 0 && IsVehicleOccupied(i))
		{
			DespawnVehicle(i);
		}
		g_RespawnVehicle = 0;
		g_RespawnVehicleTime = 0;
		//TextDrawHideForAll(RevehTD[i]);
	}
	SendClientMessageToAll(COLOR_YELLOW, "[Respawn Vehicle] รียานพาหนะภายในเซิร์ฟเวอร์สำเร็จเรียบร้อย");
	SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s Has Respawn Vehicles", GetPlayerNameEx(playerid));
    //RespawnAllVehicles(1);
	return 1;
}
forward RespawnAllVehicles(number);
public RespawnAllVehicles(number)
{
	switch(number)
	{
	    case 1:
	    {
			g_RespawnVehicle = 1;
			g_RespawnVehicleTime = 30;

			for (new i = 0; i < 2; i ++) {
				TextDrawShowForAll(RevehTD[i]);
			}

	    }
	}
    return 1;
}


stock GetVehiclePanelsDamageStatus(vehicleid, &FrontLeft, &FrontRight, &RearLeft, &RearRight, &WindShield, &FrontBumper, &RearBumper)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	FrontLeft = Panels & 15;
	FrontRight = Panels >> 4 & 15;
	RearLeft = Panels >> 8 & 15;
	RearRight = Panels >> 12 & 15;
	WindShield = Panels >> 16 & 15;
	FrontBumper = Panels >> 20 & 15;
	RearBumper = Panels >> 24 & 15;
	return true;
}

stock IsDoorVehicle(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 400..424, 426..429, 431..440, 442..445, 451, 455, 456, 458, 459, 466, 467, 470, 474, 475:
		    return 1;

		case 477..480, 482, 483, 486, 489, 490..492, 494..496, 498..500, 502..508, 514..518, 524..529, 533..536:
		    return 1;

		case 540..547, 549..552, 554..562, 565..568, 573, 575, 576, 578..580, 582, 585, 587..589, 596..605, 609:
			return 1;
	}
	return 0;
}

stock SetHoodStatus(vehicleid, bool:status)
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
	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, status, boot, objective);
}

stock SetLightStatus(vehicleid, bool:status)
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
	return SetVehicleParamsEx(vehicleid, engine, status, alarm, doors, bonnet, boot, objective);
}

stock SetTrunkStatus(vehicleid, bool:status)
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
	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, status, objective);
}

stock GetLightStatus(vehicleid)
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

	if (lights != 1)
		return 0;

	return 1;
}

stock GetTrunkStatus(vehicleid)
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

	if (boot != 1)
		return 0;

	return 1;
}

stock IsWindowedVehicle(vehicleid)
{
	static const g_aWindowStatus[] = {
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1,
	    1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1,
		1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1,
		1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
	};
	new modelid = GetVehicleModel(vehicleid);

    if (modelid < 400 || modelid > 611)
        return 0;

    return (g_aWindowStatus[modelid - 400]);
}


alias:lock("ล็อค")
CMD:lock(playerid, params[])
{
	new
		id = GetNearbyVehicle(playerid);

	if(IsVehicleOwner(playerid, id) || playerData[playerid][pVehicleKeys] == id || (carData[id][carFaction] >= 0 && carData[id][carFaction] == playerData[playerid][pFaction]))
	{
		if(!carData[id][carLocked])
		{
			carData[id][carLocked] = 1;
			GameTextForPlayer(playerid, "~r~locked", 3000, 4);
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ล็อคยานพาหนะ %s", GetPlayerNameEx(playerid), ReturnVehicleName(id));
		}
		else
		{
			carData[id][carLocked] = 0;
			GameTextForPlayer(playerid, "~g~Unlocked", 3000, 4);
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ปลอดล็อคยานพาหนะ %s", GetPlayerNameEx(playerid), ReturnVehicleName(id));
		}

		SetVehicleParams(id, VEHICLE_DOORS, carData[id][carLocked]);
		PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carLocked = %d WHERE carID = %d", carData[id][carLocked], carData[id][carID]);
		mysql_tquery(g_SQL, query);
		return 1;
	}
	return 1;
}
