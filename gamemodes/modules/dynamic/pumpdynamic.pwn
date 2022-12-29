#include <YSI\y_hooks>

enum pumpData {
	pumpID,
	pumpExists,
	pumpBusiness,
	Float:pumpPos[4],
	pumpFuel,
	pumpObject,
	Text3D:pumpText3D
};

new PumpData[MAX_GAS_PUMPS][pumpData],Total_Pumps_Created;

//dynamic pump
Pump_Create(playerid, bizid)
{
    new
	    Float:x,
	    Float:y,
	    Float:z,
		Float:angle,
		string[64],
		id = -1;

	if (GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
	{
		if ((id = Pump_GetFreeID()) != -1)
  		{
	        x += 5.0 * floatsin(-angle, degrees);
	        y += 5.0 * floatcos(-angle, degrees);

			PumpData[id][pumpExists] = true;
			PumpData[id][pumpBusiness] = bizid;
			PumpData[id][pumpPos][0] = x;
			PumpData[id][pumpPos][1] = y;
			PumpData[id][pumpPos][2] = z;
			PumpData[id][pumpPos][3] = angle;
            PumpData[id][pumpFuel] = 2000;
			PumpData[id][pumpObject] = CreateDynamicObject(1676, x, y, z, 0.0, 0.0, angle);

			format(string, sizeof(string), "INSERT INTO `pumps` (`ID`) VALUES(%d)", BusinessData[bizid][bizID]);
			mysql_tquery(dbCon, string, "OnPumpCreated", "d", id);
			return id;
		}
		Pump_Refresh(id);
	}
	return -1;
}

forward Pump_Load(bizid);
public Pump_Load(bizid)
{
	new
	    rows,
		id = -1;

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if ((id = Pump_GetFreeID()) != -1)
	{
	    PumpData[id][pumpExists] = true;
	    PumpData[id][pumpBusiness] = bizid;

	    cache_get_value_name_int(i, "pumpID", PumpData[id][pumpID]);
	    cache_get_value_name_float(i, "pumpPosX", PumpData[id][pumpPos][0]);
	    cache_get_value_name_float(i, "pumpPosY", PumpData[id][pumpPos][1]);
	    cache_get_value_name_float(i, "pumpPosZ", PumpData[id][pumpPos][2]);
	    cache_get_value_name_float(i, "pumpPosA", PumpData[id][pumpPos][3]);
	    cache_get_value_name_int(i, "pumpFuel", PumpData[id][pumpFuel]);

	    PumpData[id][pumpObject] = CreateDynamicObject(1676, PumpData[id][pumpPos][0], PumpData[id][pumpPos][1], PumpData[id][pumpPos][2], 0.0, 0.0, PumpData[id][pumpPos][3]);
	    Pump_Refresh(id);

	    Total_Pumps_Created++;
	}
	printf("[MYSQL]: %d Pumps have been successfully loaded from the database.", Total_Pumps_Created);
	return 1;
}

stock Business_RemovePumps(bizid)
{
	if (BusinessData[bizid][bizExists] && BusinessData[bizid][bizType] == 6)
	{
	    new
	        string[32];

	    foreach (new i : Player) if (Character[i][Refill] != INVALID_VEHICLE_ID && Character[i][GasStation] == bizid)
	    {
	        StopRefilling(i);
	    }
		for (new i = 0; i != MAX_GAS_PUMPS; i ++) if (PumpData[i][pumpExists] && PumpData[i][pumpBusiness] == bizid)
		{
  			DestroyDynamicObject(PumpData[i][pumpObject]);
			DestroyDynamic3DTextLabel(PumpData[i][pumpText3D]);

		    PumpData[i][pumpExists] = 0;
		    PumpData[i][pumpFuel] = 0;
		}
		format(string, sizeof(string), "DELETE FROM `pumps` WHERE `ID` = '%d'", BusinessData[bizid][bizID]);
		mysql_tquery(dbCon, string);
	}
	return 1;
}

Pump_GetFreeID()
{
	for (new i = 0; i < MAX_GAS_PUMPS; i ++) if (!PumpData[i][pumpExists]) {
	    return i;
	}
	return -1;
}

Pump_Delete(pumpid)
{
	if (pumpid != -1 && PumpData[pumpid][pumpExists])
	{
	    new
	        string[90];

		format(string, sizeof(string), "DELETE FROM `pumps` WHERE `ID` = '%d' AND `pumpID` = '%d'", BusinessData[PumpData[pumpid][pumpBusiness]][bizID], PumpData[pumpid][pumpID]);
		mysql_tquery(dbCon, string);

		Total_Pumps_Created--;

        if (IsValidDynamic3DTextLabel(PumpData[pumpid][pumpText3D]))
		    DestroyDynamic3DTextLabel(PumpData[pumpid][pumpText3D]);

		if (IsValidDynamicObject(PumpData[pumpid][pumpObject]))
		    DestroyDynamicObject(PumpData[pumpid][pumpObject]);

		foreach (new i : Player) if (Character[i][GasPump] == pumpid) {
		    StopRefilling(i);
		}
	    PumpData[pumpid][pumpExists] = false;
	    PumpData[pumpid][pumpFuel] = 0;
	}
	return 1;
}

Pump_Refresh(pumpid)
{
	if (pumpid != -1 && PumpData[pumpid][pumpExists])
	{
	    new
	        string[128];

		format(string, sizeof(string), "[Gas Pump: %d]\n{FFFFFF}เชื้อเพลิงเหลือ: %d ลิตร", pumpid, PumpData[pumpid][pumpFuel]);

        if (IsValidDynamic3DTextLabel(PumpData[pumpid][pumpText3D]))
            DestroyDynamic3DTextLabel(PumpData[pumpid][pumpText3D]);

		if (IsValidDynamicObject(PumpData[pumpid][pumpObject]))
		    DestroyDynamicObject(PumpData[pumpid][pumpObject]);

		PumpData[pumpid][pumpText3D] = CreateDynamic3DTextLabel(string, COLOR_BLUE, PumpData[pumpid][pumpPos][0], PumpData[pumpid][pumpPos][1], PumpData[pumpid][pumpPos][2], 15.0);
        PumpData[pumpid][pumpObject] = CreateDynamicObject(1676, PumpData[pumpid][pumpPos][0], PumpData[pumpid][pumpPos][1], PumpData[pumpid][pumpPos][2], 0.0, 0.0, PumpData[pumpid][pumpPos][3]);
	}
	return 1;
}

Pump_Save(pumpid)
{
	new
	    query[256];

	format(query, sizeof(query), "UPDATE `pumps` SET `pumpPosX` = '%.4f', `pumpPosY` = '%.4f', `pumpPosZ` = '%.4f', `pumpPosA` = '%.4f', `pumpFuel` = '%d' WHERE `ID` = '%d' AND `pumpID` = '%d'",
	    PumpData[pumpid][pumpPos][0],
	    PumpData[pumpid][pumpPos][1],
	    PumpData[pumpid][pumpPos][2],
		PumpData[pumpid][pumpPos][3],
	    PumpData[pumpid][pumpFuel],
	    BusinessData[PumpData[pumpid][pumpBusiness]][bizID],
	    PumpData[pumpid][pumpID]
	);
	return mysql_tquery(dbCon, query);
}

Pump_Nearest(playerid)
{
    for (new i = 0; i != MAX_GAS_PUMPS; i ++) if (PumpData[i][pumpExists] && IsPlayerInRangeOfPoint(playerid, 4.0, PumpData[i][pumpPos][0], PumpData[i][pumpPos][1], PumpData[i][pumpPos][2]) && PumpData[i][pumpExists]) {
	    return i;
	}
	return -1;
}

stock IsPumpOccupied(pumpid)
{
	foreach (new i : Player) if (Character[i][Refill] != INVALID_VEHICLE_ID) {
	    if (Character[i][GasPump] == pumpid) return 1;
	}
	return 0;
}

forward OnPumpCreated(pumpid);
public OnPumpCreated(pumpid)
{
    PumpData[pumpid][pumpID] = cache_insert_id();
	Pump_Save(pumpid);

	return 1;
}

CMD:createpump(playerid, params[])
{
	new
	    id,
		bizid = -1,
		string[128];

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "d", bizid))
	    return SendClientMessage(playerid, -1, "/createpump [business id]");

	if ((bizid < 0 || bizid >= MAX_BUSINESSES) || !BusinessData[bizid][bizExists])
	    return SendClientMessage(playerid, -1, "คุณระบุไอดีธุรกิจไม่ถูกต้อง");

	if (BusinessData[bizid][bizType] != 6)
	    return SendClientMessage(playerid, -1, "ธุรกิจนี้ไม่ใช่ Gas station!");

    if (GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
		return SendClientMessage(playerid, -1, "คุณสามารถสร้างปั้มก๊าซได้นอกอาคารเท่านั้น");

	id = Pump_Create(playerid, bizid);

	if (id == -1)
	    return SendClientMessage(playerid, -1, "ธุรกิจนี้ได้สร้างปั้มก๊าซเกินขีดจำกัดแล้ว");

	format(string, sizeof(string), "คุณได้ประสบความสำเร็จในการสร้างปั้มก๊าซไอดี: %d", id);
	SendClientMessage(playerid, -1, string);
	EditDynamicObject(playerid, PumpData[id][pumpObject]);

	Character[playerid][EditPump] = id;
	return 1;
}

CMD:destroypump(playerid, params[])
{
	new
	    id = 0,
	    string[128];

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, -1, "/destroypump [pump id]");

	if ((id < 0 || id >= MAX_GAS_PUMPS) || !PumpData[id][pumpExists])
	    return SendClientMessage(playerid, -1, "ไอดีปั้มไม่ถูกต้อง");

	Pump_Delete(id);
    format(string, sizeof(string), "คุณได้ประสบความสำเร็จในการทำลายปั้มไอดี: %d", id);
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:setpump(playerid, params[])
{
	new
	    id = 0,
		amount,
		string[128];

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "dd", id, amount))
	    return SendClientMessage(playerid, -1, "/setpump [pump id] [fuel amount]");

	if ((id < 0 || id >= MAX_GAS_PUMPS) || !PumpData[id][pumpExists])
	    return SendClientMessage(playerid, -1, "ไอดีปั้มไม่ถูกต้อง");

	PumpData[id][pumpFuel] = amount;

	Pump_Refresh(id);
	Pump_Save(id);

    format(string, sizeof(string), "คุณตั้งค่าน้ำมันเชื้อเพลิง %d ให้ปั้มไอดี: %d.", amount, id);
	SendClientMessage(playerid, -1, string);
	return 1;
}
