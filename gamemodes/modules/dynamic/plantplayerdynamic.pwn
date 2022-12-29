#include <YSI\y_hooks>

enum plantdata {
	plantID,
	plantExists,
	Float:plantPos[4],
	plantInterior,
    plantType,
    plantValue,
    plantWater,
	plantWorld,
	plantUse,
    plantObject[3],
	Text3D:plantText3D
};
new PlantData[MAX_PLANTS][plantdata];

new Total_Plants_Created;
new maxvalue = 100;
new maxwater = 100;

Plant_GetName(type)
{
	new
	    str[24];

	switch (type)
	{
	    case 1: str = "ฟักทอง";
		case 2: str = "ส้ม";
	}
	return str;
}
/*
Plant_Create(playerid, type)
{
	new
	    Float:x,
	    Float:y,
	    Float:z,
        Float:angle;

	if (GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
	{
		for (new i = 0; i != MAX_PLANTS; i ++)
		{
	    	if (!PlantData[i][plantExists])
	    	{
	        	PlantData[i][plantExists] = true;
                PlantData[i][plantValue] = 0;
                PlantData[i][plantType] = type;
                PlantData[i][plantWater] = 100;
				PlantData[i][plantPos][0] = x;
	        	PlantData[i][plantPos][1] = y;
	        	PlantData[i][plantPos][2] = z;
                PlantData[i][plantPos][3] = angle;

	        	PlantData[i][plantInterior] = GetPlayerInterior(playerid);
	        	PlantData[i][plantWorld] = GetPlayerVirtualWorld(playerid);

	        	Plant_Refresh(i);
	        	mysql_tquery(dbCon, "INSERT INTO `plants` (`plantInterior`) VALUES(0)", "OnPlantCreated", "d", i);
	        	return i;
	        }
	    }
	}
	return -1;
}
*/
forward OnPlantCreated(plantid);
public OnPlantCreated(plantid)
{
	if (plantid == -1 || !PlantData[plantid][plantExists])
	    return 0;

	PlantData[plantid][plantID] = cache_insert_id();
	Plant_Save(plantid);

	return 1;
}

Plant_Save(plantid)
{
	new
	    query[512];

	format(query, sizeof(query), "UPDATE `plants` SET `plantType` = '%d', `plantValue` = '%d', `plantWater` = '%d', `plantPosX` = '%.4f', `plantPosY` = '%.4f', `plantPosZ` = '%.4f', `plantPosA` = '%.4f', `plantInterior` = '%d', `plantWorld` = '%d' WHERE `plantID` = '%d'",
        PlantData[plantid][plantType],
        PlantData[plantid][plantValue],
        PlantData[plantid][plantWater],
        PlantData[plantid][plantPos][0],
	    PlantData[plantid][plantPos][1],
	    PlantData[plantid][plantPos][2],
        PlantData[plantid][plantPos][3],
	    PlantData[plantid][plantInterior],
	    PlantData[plantid][plantWorld],
	    PlantData[plantid][plantID]
	);
	return mysql_tquery(dbCon, query);
}

Plant_Delete(plantid)
{
	if (plantid != -1 && PlantData[plantid][plantExists])
	{
	    new
	        string[64];

		format(string, sizeof(string), "DELETE FROM `plants` WHERE `plantID` = '%d'", PlantData[plantid][plantID]);
		mysql_tquery(dbCon, string);

        if (IsValidDynamic3DTextLabel(PlantData[plantid][plantText3D]))
            DestroyDynamic3DTextLabel(PlantData[plantid][plantText3D]);

        for(new i=0;i<3;i++)
        {
            if (IsValidDynamicObject(PlantData[plantid][plantObject][i]))
                DestroyDynamicObject(PlantData[plantid][plantObject][i]);
        }

		PlantData[plantid][plantExists] = false;
	    PlantData[plantid][plantID] = 0;
	}
	return 1;
}

//dynamic product
forward Plant_Load();
public Plant_Load()
{
	new
	    rows;

	cache_get_row_count(rows);

    for (new i = 0; i < rows; i ++) if (i < MAX_PLANTS)
	{
	    PlantData[i][plantExists] = true;

	    cache_get_value_name_int(i, "plantID", PlantData[i][plantID]);
        cache_get_value_name_int(i, "plantType", PlantData[i][plantType]);
        cache_get_value_name_int(i, "plantValue", PlantData[i][plantValue]);
        cache_get_value_name_int(i, "plantWater", PlantData[i][plantWater]);
	    cache_get_value_name_float(i, "plantPosX", PlantData[i][plantPos][0]);
	    cache_get_value_name_float(i, "plantPosY", PlantData[i][plantPos][1]);
	    cache_get_value_name_float(i, "plantPosZ", PlantData[i][plantPos][2]);
        cache_get_value_name_float(i, "plantPosA", PlantData[i][plantPos][3]);
	    cache_get_value_name_int(i, "plantInterior", PlantData[i][plantInterior]);
	    cache_get_value_name_int(i, "plantWorld", PlantData[i][plantWorld]);

        Total_Plants_Created++;
 	    Plant_Refresh(i);
	}
    printf("[MYSQL]: %d Plants have been successfully loaded from the database.", Total_Plants_Created);
	return 1;
}

Plant_Refresh(plantid)
{
	if (plantid != -1 && PlantData[plantid][plantExists])
	{
        if (IsValidDynamic3DTextLabel(PlantData[plantid][plantText3D]))
            DestroyDynamic3DTextLabel(PlantData[plantid][plantText3D]);

        for(new i=0;i<3;i++){
            if (IsValidDynamicObject(PlantData[plantid][plantObject][i]))
                DestroyDynamicObject(PlantData[plantid][plantObject][i]);
        }
        
		new
		    string[1024];

        new Float:z;

        if(PlantData[plantid][plantType] == 1) //ฟักทอง
        {
            if(PlantData[plantid][plantValue] <= 50){
                format(string, sizeof(string), "{F49903}[ต้นฟักทอง]\n[การเจริญเติมโต: %d/%d]\n[ระดับน้ำ: %d/%d]\nใช้ปุ่ม 'Y' เพื่อจัดการพืช",PlantData[plantid][plantValue], maxvalue, PlantData[plantid][plantWater], maxwater);
                PlantData[plantid][plantText3D] = CreateDynamic3DTextLabel(string, COLOR_WHITE, PlantData[plantid][plantPos][0], PlantData[plantid][plantPos][1], PlantData[plantid][plantPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, PlantData[plantid][plantWorld], PlantData[plantid][plantInterior]);
                MapAndreas_FindZ_For2DCoord(PlantData[plantid][plantPos][0],PlantData[plantid][plantPos][1],z);
                PlantData[plantid][plantObject][0] = CreateDynamicObject(802, PlantData[plantid][plantPos][0], PlantData[plantid][plantPos][1],z+0.3, 0.0, 0.0, PlantData[plantid][plantPos][3]-90.0, 0, 0);
            }
            if(PlantData[plantid][plantValue] > 50 && PlantData[plantid][plantValue] < 100){
                format(string, sizeof(string), "{F49903}[ต้นฟักทอง]\n[การเจริญเติมโต: %d/%d]\n[ระดับน้ำ: %d/%d]\nใช้ปุ่ม 'Y' เพื่อจัดการพืช",PlantData[plantid][plantValue], maxvalue, PlantData[plantid][plantWater], maxwater);
                PlantData[plantid][plantText3D] = CreateDynamic3DTextLabel(string, COLOR_WHITE, PlantData[plantid][plantPos][0], PlantData[plantid][plantPos][1], PlantData[plantid][plantPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, PlantData[plantid][plantWorld], PlantData[plantid][plantInterior]);
                MapAndreas_FindZ_For2DCoord(PlantData[plantid][plantPos][0],PlantData[plantid][plantPos][1],z);
                PlantData[plantid][plantObject][0] = CreateDynamicObject(14400, PlantData[plantid][plantPos][0], PlantData[plantid][plantPos][1],z, 0.0, 0.0, PlantData[plantid][plantPos][3]-90.0, 0, 0);
            }
            if(PlantData[plantid][plantValue] == 100){
                format(string, sizeof(string), "{F49903}[ต้นฟักทอง]\n[โตเต็มที่แล้ว]\nใช้ปุ่ม 'Y' เพื่อจัดการพืช");
                PlantData[plantid][plantText3D] = CreateDynamic3DTextLabel(string, COLOR_WHITE, PlantData[plantid][plantPos][0], PlantData[plantid][plantPos][1], PlantData[plantid][plantPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, PlantData[plantid][plantWorld], PlantData[plantid][plantInterior]);
                MapAndreas_FindZ_For2DCoord(PlantData[plantid][plantPos][0],PlantData[plantid][plantPos][1],z);
                PlantData[plantid][plantObject][0] = CreateDynamicObject(14400, PlantData[plantid][plantPos][0], PlantData[plantid][plantPos][1],z, 0.0, 0.0, PlantData[plantid][plantPos][3]-90.0, 0, 0);
                PlantData[plantid][plantObject][1] = CreateDynamicObject(19320, PlantData[plantid][plantPos][0], PlantData[plantid][plantPos][1],z+0.2, 0.0, 0.0, PlantData[plantid][plantPos][3]-90.0, 0, 0);
            }
        }
		if(PlantData[plantid][plantType] == 2){
			if(PlantData[plantid][plantValue] <= 50){
                format(string, sizeof(string), "{F49903}[ต้นส้ม]\n[การเจริญเติมโต: %d/%d]\n[ระดับน้ำ: %d/%d]\nใช้ปุ่ม 'Y' เพื่อจัดการพืช",PlantData[plantid][plantValue], maxvalue, PlantData[plantid][plantWater], maxwater);
                PlantData[plantid][plantText3D] = CreateDynamic3DTextLabel(string, COLOR_WHITE, PlantData[plantid][plantPos][0], PlantData[plantid][plantPos][1], PlantData[plantid][plantPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, PlantData[plantid][plantWorld], PlantData[plantid][plantInterior]);
                MapAndreas_FindZ_For2DCoord(PlantData[plantid][plantPos][0],PlantData[plantid][plantPos][1],z);
                PlantData[plantid][plantObject][0] = CreateDynamicObject(949, PlantData[plantid][plantPos][0], PlantData[plantid][plantPos][1],z+0.6, 0.0, 0.0, PlantData[plantid][plantPos][3]-90.0, 0, 0);
            }
            if(PlantData[plantid][plantValue] > 50 && PlantData[plantid][plantValue] < 100){
                format(string, sizeof(string), "{F49903}[ต้นส้ม]\n[การเจริญเติมโต: %d/%d]\n[ระดับน้ำ: %d/%d]\nใช้ปุ่ม 'Y' เพื่อจัดการพืช",PlantData[plantid][plantValue], maxvalue, PlantData[plantid][plantWater], maxwater);
                PlantData[plantid][plantText3D] = CreateDynamic3DTextLabel(string, COLOR_WHITE, PlantData[plantid][plantPos][0], PlantData[plantid][plantPos][1], PlantData[plantid][plantPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, PlantData[plantid][plantWorld], PlantData[plantid][plantInterior]);
                MapAndreas_FindZ_For2DCoord(PlantData[plantid][plantPos][0],PlantData[plantid][plantPos][1],z);
                PlantData[plantid][plantObject][0] = CreateDynamicObject(949, PlantData[plantid][plantPos][0], PlantData[plantid][plantPos][1],z+0.6, 0.0, 0.0, PlantData[plantid][plantPos][3]-90.0, 0, 0);
            }
            if(PlantData[plantid][plantValue] == 100){
                format(string, sizeof(string), "{F49903}[ต้นส้ม]\n[โตเต็มที่แล้ว]\nใช้ปุ่ม 'Y' เพื่อจัดการพืช");
                PlantData[plantid][plantText3D] = CreateDynamic3DTextLabel(string, COLOR_WHITE, PlantData[plantid][plantPos][0], PlantData[plantid][plantPos][1], PlantData[plantid][plantPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, PlantData[plantid][plantWorld], PlantData[plantid][plantInterior]);
                MapAndreas_FindZ_For2DCoord(PlantData[plantid][plantPos][0],PlantData[plantid][plantPos][1],z);
                PlantData[plantid][plantObject][0] = CreateDynamicObject(949, PlantData[plantid][plantPos][0], PlantData[plantid][plantPos][1],z+0.6, 0.0, 0.0, PlantData[plantid][plantPos][3]-90.0, 0, 0);
                //PlantData[plantid][plantObject][1] = CreateDynamicObject(19578, PlantData[plantid][plantPos][0], PlantData[plantid][plantPos][1],z+0.2, 0.0, 0.0, PlantData[plantid][plantPos][3]-90.0, 0, 0);
            }
		}
    }
	return 1;
}

Plant_Nearest(playerid)
{
    for (new i = 0; i != MAX_PLANTS; i ++) if (PlantData[i][plantExists] && IsPlayerInRangeOfPoint(playerid, 3.0, PlantData[i][plantPos][0], PlantData[i][plantPos][1], PlantData[i][plantPos][2]))
	{
		if (GetPlayerInterior(playerid) == PlantData[i][plantInterior] && GetPlayerVirtualWorld(playerid) == PlantData[i][plantWorld])
			return i;
	}
	return -1;
}

CMD:plant(playerid, params[])
{
	/*new
	    type,
	    id;

	if (sscanf(params, "d", type))
    {
	    SystemMsg(playerid, "/plant [ตัวเลือก]");
        SystemMsg(playerid, "[ตัวเลือก]: 1: ฟักทอง | 2: ส้ม");
        return 1;
    }

    if (id == -1)
	    return SendClientMessage(playerid, -1, "พืชเต็มเซิฟเวอร์แล้ว");

    if(Plant_Nearest(playerid) != -1)
        return ErrorMsg(playerid, "คุณต้องปลูกพืชห่างกัน");

    new idplant = -1;

    if(type < 1 || type > 2)
        return ErrorMsg(playerid, "ตัวเลือกไม่ถูกต้อง");

    if ((idplant = Field_Nearest(playerid)) != -1)
    {
        if (idplant != -1 && Field_IsOwner(playerid, idplant))
        {
			if(type == 1){
				if(Character[playerid][Pumpkin] == 0)
                	return ErrorMsg(playerid, "คุณไม่มีเมล็ดฟักทอง");

				ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
				id = Plant_Create(playerid, type);
				Character[playerid][Pumpkin]--;
				SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s กำลังปลูกอะไรบางอย่าง", ReturnName(playerid, 0));
			}
			if(type == 2){
				if(Character[playerid][Orange] == 0)
                	return ErrorMsg(playerid, "คุณไม่มีเมล็ดส้ม");

				ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
				id = Plant_Create(playerid, type);
				Character[playerid][Orange]--;
				SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s กำลังปลูกอะไรบางอย่าง", ReturnName(playerid, 0));
			}
        }
        else
            return ErrorMsg(playerid, "ที่ดินนี้ไม่ใช่ที่ดินของคุณ");
    }
    else
        return ErrorMsg(playerid, "คุณไม่ได้อยู่ในเขตที่ดินใดๆ");
	return 1;*/
}

CMD:destroyplant(playerid, params[])
{
	new
	    id;

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, -1, "/destroyplant [id] ");

	if ((id < 0 || id >= MAX_PLANTS) || !PlantData[id][plantExists])
	    return SendClientMessage(playerid, -1, "คุณระบุไอดีพืชไม่ถูกต้อง");

	Plant_Delete(id);
	SendClientMessageEx(playerid, -1, "คุณทำลายพืชสำเร็จแล้วไอดี: %d", id);
	return 1;
}

CMD:setplant(playerid, params[])
{
	new
	    value,
	    id;

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "dd", id,value))
	    return SendClientMessage(playerid, -1, "/plant [id] [value]");

	if (id == -1)
	    return SendClientMessage(playerid, -1, "id ไม่ถูกต้อง");

	PlantData[id][plantValue] = value;
    Plant_Refresh(id);
	return 1;
}

CMD:settimeplant(playerid, params[]){
    if(Account[playerid][Admin] < 1338)
        return ErrorMsg(playerid, "คุณไม่ได้รับอนุญาติให้ใช้คำสั่งนี้");

    SetWaterPlant();
    return 1;
}