#include	<YSI_Coding\y_hooks>

enum GARAGE_DATA {
	garageID,
	garageExists,
	Float:garagePosX,
	Float:garagePosY,
	Float:garagePosZ,
	Text3D:garageText3D,
	garagePickup
};
new garageData[MAX_GARAGES][GARAGE_DATA];

CMD:creategarage(playerid, params[])
{
	static
	    id = -1,
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (GetPlayerInterior(playerid) != 0)
	    return 1;

	id = Garage_Create(x, y, z);

	if (id == -1)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ความจุของอู่ซ่อมรถในฐานข้อมูลเต็มแล้ว ไม่สามารถสร้างได้อีก (ติดต่อผู้พัฒนา)");

	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้สร้างอู่ซ่อมรถขึ้นมาใหม่ ไอดี: %d", id);
	return 1;
}

CMD:removegarage(playerid, params[])
{
	static
	    id = 0;

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, COLOR_WHITE, "/removegarage [ไอดี]");

	if ((id < 0 || id >= MAX_GARAGES) || !garageData[id][garageExists])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่มีไอดีอู่ซ่อมรถนี้อยู่ในฐานข้อมูล");

	Garage_Delete(id);
	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้ลบอู่ซ่อมรถไอดี %d ออกสำเร็จ", id);
	return 1;
}
Garage_Delete(garageid)
{
	if (garageid != -1 && garageData[garageid][garageExists])
	{
	    static
	        string[64];

        if (IsValidDynamicPickup(garageData[garageid][garagePickup]))
		    DestroyDynamicPickup(garageData[garageid][garagePickup]);

		if (IsValidDynamic3DTextLabel(garageData[garageid][garageText3D]))
		    DestroyDynamic3DTextLabel(garageData[garageid][garageText3D]);

		mysql_format(g_SQL, string, sizeof(string), "DELETE FROM `garages` WHERE `garageID` = '%d'", garageData[garageid][garageID]);
		mysql_tquery(g_SQL, string);

		garageData[garageid][garageExists] = false;
		garageData[garageid][garageID] = 0;
	}
	return 1;
}

Garage_Create(Float:x, Float:y, Float:z)
{
	for (new i = 0; i < MAX_GARAGES; i ++) if (!garageData[i][garageExists])
	{
	    garageData[i][garageExists] = true;
	    garageData[i][garagePosX] = x;
	    garageData[i][garagePosY] = y;
	    garageData[i][garagePosZ] = z;

	    mysql_tquery(g_SQL, "INSERT INTO `garages` (`garageID`) VALUES(0)", "OnGarageCreated", "d", i);
		Garage_Refresh(i);
		return i;
	}
	return -1;
}

Garage_Save(garageid)
{
	static
	    query[220];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE `garages` SET `garageX` = '%.4f', `garageY` = '%.4f', `garageZ` = '%.4f' WHERE `garageID` = '%d'",
	    garageData[garageid][garagePosX],
	    garageData[garageid][garagePosY],
	    garageData[garageid][garagePosZ],
	    garageData[garageid][garageID]
	);
	return mysql_tquery(g_SQL, query);
}

Garage_Refresh(garageid)
{
	if (garageid != -1 && garageData[garageid][garageExists])
	{
		if (IsValidDynamicPickup(garageData[garageid][garagePickup]))
		    DestroyDynamicPickup(garageData[garageid][garagePickup]);

		if (IsValidDynamic3DTextLabel(garageData[garageid][garageText3D]))
		    DestroyDynamic3DTextLabel(garageData[garageid][garageText3D]);

		//garageData[garageid][garagePickup] = CreateDynamicPickup(1083, 23, garageData[garageid][garagePosX], garageData[garageid][garagePosY], garageData[garageid][garagePosZ]);
  		garageData[garageid][garageText3D] = CreateDynamic3DTextLabel("[Mechanic]\n{AAAAAA}'กด Y เพื่อใช้งาน'", COLOR_ORANGE, garageData[garageid][garagePosX], garageData[garageid][garagePosY], garageData[garageid][garagePosZ], 5.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0);
	}
	return 1;
}
Garage_Nearest(playerid)
{
    for (new i = 0; i != MAX_GARAGES; i ++) if (garageData[i][garageExists] && IsPlayerInRangeOfPoint(playerid, 4.0, garageData[i][garagePosX], garageData[i][garagePosY], garageData[i][garagePosZ]))
	{
		return i;
	}
	return -1;
}

forward OnGarageCreated(garageid);
public OnGarageCreated(garageid)
{
	if (garageid == -1 || !garageData[garageid][garageExists])
	    return 0;

	garageData[garageid][garageID] = cache_insert_id();
	Garage_Save(garageid);

	return 1;
}

forward Garage_Load();
public Garage_Load()
{
	static
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_GARAGES)
	{
	    garageData[i][garageExists] = true;

	    cache_get_value_name_int(i, "garageID", garageData[i][garageID]);
	    cache_get_value_name_float(i, "garageX", garageData[i][garagePosX]);
	    cache_get_value_name_float(i, "garageY", garageData[i][garagePosY]);
	    cache_get_value_name_float(i, "garageZ", garageData[i][garagePosZ]);

	    Garage_Refresh(i);
	}
	printf("[SERVER]: %d Garages were loaded from \"%s\" database...", rows, MYSQL_DATABASE);
	return 1;
}