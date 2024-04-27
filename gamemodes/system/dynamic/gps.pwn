#include <YSI_Coding\y_hooks>


enum GPS_DATA {
	gpsID,
	gpsExists,
	gpsName[32],
	Float:gpsPosX,
	Float:gpsPosY,
	Float:gpsPosZ,
	gpsType
};
new gpsData[MAX_GPS][GPS_DATA];



CMD:creategps(playerid, params[])
{
	static
	    id = -1,
		Float:x,
		Float:y,
		Float:z,
		gpsname[32],
		type;

	GetPlayerPos(playerid, x, y, z);

    if (playerData[playerid][pAdmin] < 4)
	    return 1;

	if (sscanf(params, "ds[32]", type, gpsname))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "/creategps [รูปแบบ GPS] [ชื่อสถานที่]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[รูปแบบ GPS]:{FFFFFF} 1. Los Santos 2. San Fierro 3. Las Venturas  4.ร้านขายรถ-พาวว์รถ 5. สถานที่ทำงาน");
	    SendClientMessage(playerid, COLOR_YELLOW, "[รูปแบบ GPS]:{FFFFFF} 6. ธนาคาร 7. จุดเบิกรถ");
	    return 1;
	}
	if (type < 1 || type > 7)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- รูปแบบของ GPS ต้องไม่ต่ำกว่า 1 และไม่เกิน 7 เท่านั้น");

	id = GPS_Create(type, gpsname, x, y, z);

	if (id == -1)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ความจุของ GPS ในฐานข้อมูลเต็มแล้ว ไม่สามารถสร้างได้อีก (ติดต่อผู้พัฒนา)");

	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้สร้าง GPS ขึ้นมาใหม่ รูปแบบ GPS: %d, ชื่อสถานที่: %s, ไอดี: %d", type, gpsname, id);
	return 1;
}

CMD:removegps(playerid, params[])
{
	static
	    id = 0;

    if (playerData[playerid][pAdmin] < 4)
	    return 1;

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, COLOR_WHITE, "/deletegps [ไอดี]");

	if ((id < 0 || id >= MAX_GPS) || !gpsData[id][gpsExists])
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่มีไอดี GPS นี้อยู่ในฐานข้อมูล");

	GPS_Delete(id);
	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้ลบ GPS ไอดี %d ออกสำเร็จ", id);
	return 1;
}

CMD:editgps(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (playerData[playerid][pAdmin] < 4)
	    return 1;

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendClientMessage(playerid, COLOR_WHITE, "/editgps [ไอดี] [ชื่อรายการ]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[ชื่อรายการ]:{FFFFFF} name, type, location");
		return 1;
	}
	if ((id < 0 || id >= MAX_GPS) || !gpsData[id][gpsExists])
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่มีไอดี GPS นี้อยู่ในฐานข้อมูล");

	if (!strcmp(type, "location", true))
	{
	    GetPlayerPos(playerid, gpsData[id][gpsPosX], gpsData[id][gpsPosY], gpsData[id][gpsPosZ]);

		GPS_Save(id);

		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ย้ายตำแหน่ง GPS ไอดี %d (%s)", GetPlayerNameEx(playerid), id, gpsData[id][gpsName]);
	}
	else if (!strcmp(type, "name", true))
	{
	    new name[32];

	    if (sscanf(string, "s[32]", name))
	        return SendClientMessage(playerid, COLOR_WHITE, "/editgps [ไอดี] [ชื่อรายการ] [ชื่อที่ต้องการเปลี่ยน]");

	    format(gpsData[id][gpsName], 32, name);

	    GPS_Save(id);

		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้เปลี่ยนชื่อ GPS ไอดี %d เป็นชื่อ \"%s\"", GetPlayerNameEx(playerid), id, name);
	}
	else if (!strcmp(type, "type", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
	    {
	        SendClientMessage(playerid, COLOR_WHITE, "/editgps [ไอดี] [ชื่อรายการ] [รูปแบบที่ต้องการ]");
			SendClientMessage(playerid, COLOR_YELLOW, "[รูปแบบ GPS]:{FFFFFF} 1. Los Santos 2. San Fierro 3. Las Venturas  4.ร้านขายรถ-พาวว์รถ 5. สถานที่ทำงาน");
			SendClientMessage(playerid, COLOR_YELLOW, "[รูปแบบ GPS]:{FFFFFF} 6. ธนาคาร 7. จุดเบิกร");
			return 1;
		}
		if (typeint < 1 || typeint > 7)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- รูปแบบของ GPS ต้องไม่ต่ำกว่า 1 และไม่เกิน 7 เท่านั้น");

        gpsData[id][gpsType] = typeint;

	    GPS_Save(id);
		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับรูปแบบ GPS ไอดี %d (%s) เป็นรูปแบบ %d", GetPlayerNameEx(playerid), id, gpsData[id][gpsName], typeint);
	}
	return 1;
}


forward OnGPSCreated(gpsid);
public OnGPSCreated(gpsid)
{
	if (gpsid == -1 || !gpsData[gpsid][gpsExists])
	    return 0;

	gpsData[gpsid][gpsID] = cache_insert_id();
	GPS_Save(gpsid);

	return 1;
}


GPS_Save(gpsid)
{
	static
	    query[220];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE `gps` SET `gpsName` = '%e', `gpsX` = '%.4f', `gpsY` = '%.4f', `gpsZ` = '%.4f', `gpsType` = '%d' WHERE `gpsID` = '%d'",
		gpsData[gpsid][gpsName],
		gpsData[gpsid][gpsPosX],
	    gpsData[gpsid][gpsPosY],
	    gpsData[gpsid][gpsPosZ],
	    gpsData[gpsid][gpsType],
	    gpsData[gpsid][gpsID]
	);
	return mysql_tquery(g_SQL, query);
}
GPS_Delete(gpsid)
{
	if (gpsid != -1 && gpsData[gpsid][gpsExists])
	{
	    static
	        string[64];

		format(string, sizeof(string), "DELETE FROM `gps` WHERE `gpsID` = '%d'", gpsData[gpsid][gpsID]);
		mysql_tquery(g_SQL, string);

		gpsData[gpsid][gpsExists] = false;
		gpsData[gpsid][gpsID] = 0;
	}
	return 1;
}

GPS_Create(type, const gpsname[], Float:x, Float:y, Float:z)
{
	for (new i = 0; i < MAX_GPS; i ++) if (!gpsData[i][gpsExists])
	{
	    gpsData[i][gpsExists] = true;
	    format(gpsData[i][gpsName], 32, gpsname);
	    gpsData[i][gpsPosX] = x;
	    gpsData[i][gpsPosY] = y;
	    gpsData[i][gpsPosZ] = z;
	    gpsData[i][gpsType] = type;

	    mysql_tquery(g_SQL, "INSERT INTO `gps` (`gpsID`) VALUES(0)", "OnGPSCreated", "d", i);
		return i;
	}
	return -1;
}


forward GPS_Load();
public GPS_Load()
{
	static
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_GPS)
	{
	    gpsData[i][gpsExists] = true;

	    cache_get_value_name_int(i, "gpsID", gpsData[i][gpsID]);
	    cache_get_value_name(i, "gpsName", gpsData[i][gpsName], 32);
	    cache_get_value_name_float(i, "gpsX", gpsData[i][gpsPosX]);
	    cache_get_value_name_float(i, "gpsY", gpsData[i][gpsPosY]);
	    cache_get_value_name_float(i, "gpsZ", gpsData[i][gpsPosZ]);
	    cache_get_value_name_int(i, "gpsType", gpsData[i][gpsType]);
	}
	printf("[SERVER]: %d GPS were loaded from \"%s\" database...", rows, MYSQL_DATABASE);
	return 1;
}
CMD:gps(playerid, parms[])
	return Dialog_Show(playerid, GPS_MANU, DIALOG_STYLE_LIST, "รายการสถานที่", "{FFFFFF}\
		- Los Santos (ลอสซานโตส)\n\
		- San Fierro (ซานเฟียร์โร)\n\
		- Las Venturas (ลาสเวนทูรัส)\n\
		- Vehicle Shop (ร้านขายรถ-พาวว์รถ)\n\
        - Bank (ธนาคาร)\n\
        - Spawn Vehicle (การาจ)\
        ", "เลือก", "ปิด");

Dialog:GPS_MANU(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: //Los Santos
			{
				new
					count,
					var[32],
					string[4096],
					string2[4096];

				for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
				{
					if(gpsData[i][gpsType] == 1)
					{
						format(string, sizeof(string), "%s\t{FFA84D}(%.0f เมตร)\n", gpsData[i][gpsName], GetPlayerDistanceFromPoint(playerid, gpsData[i][gpsPosX], gpsData[i][gpsPosY], gpsData[i][gpsPosZ]));
						strcat(string2, string);
						format(var, sizeof(var), "GPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- เซิร์ฟเวอร์ยังไม่ได้เพิ่ม GPS");
					return 1;
				}
				format(string, sizeof(string), "รายชื่อสถานที่\tระยะทาง\n%s", string2);
				Dialog_Show(playerid, DIALOG_GPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "Los Santos (ลอสซานโตส)", string, "เลือก", "ปิด");
				PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
				return 1;
			}
			case 1: //San Fierro
			{
				new
					count,
					var[32],
					string[4096],
					string2[4096];

				for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
				{
					if(gpsData[i][gpsType] == 2)
					{
						format(string, sizeof(string), "%s\t{FFA84D}(%.0f เมตร)\n", gpsData[i][gpsName], GetPlayerDistanceFromPoint(playerid, gpsData[i][gpsPosX], gpsData[i][gpsPosY], gpsData[i][gpsPosZ]));
						strcat(string2, string);
						format(var, sizeof(var), "GPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- เซิร์ฟเวอร์ยังไม่ได้เพิ่ม GPS");
					return 1;
				}
				format(string, sizeof(string), "รายชื่อสถานที่\tระยะทาง\n%s", string2);
				Dialog_Show(playerid, DIALOG_GPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "San Fierro (ซานเฟียร์โร)", string, "เลือก", "ปิด");
				PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
				return 1;
			}
			case 2: //Las Venturas
			{
				new
					count,
					var[32],
					string[4096],
					string2[4096];

				for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
				{
					if(gpsData[i][gpsType] == 3)
					{
						format(string, sizeof(string), "%s\t{FFA84D}(%.0f เมตร)\n", gpsData[i][gpsName], GetPlayerDistanceFromPoint(playerid, gpsData[i][gpsPosX], gpsData[i][gpsPosY], gpsData[i][gpsPosZ]));
						strcat(string2, string);
						format(var, sizeof(var), "GPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- เซิร์ฟเวอร์ยังไม่ได้เพิ่ม GPS");
					return 1;
				}
				format(string, sizeof(string), "รายชื่อสถานที่\tระยะทาง\n%s", string2);
				Dialog_Show(playerid, DIALOG_GPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "Las Venturas (ลาสเวนทูรัส)", string, "เลือก", "ปิด");
				PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
				return 1;
			}
			case 3: //ร้านขายรถ-พาวว์รถ
			{
				new
					count,
					var[32],
					string[4096],
					string2[4096];

				for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
				{
					if(gpsData[i][gpsType] == 4)
					{
						format(string, sizeof(string), "%s\t{FFA84D}(%.0f เมตร)\n", gpsData[i][gpsName], GetPlayerDistanceFromPoint(playerid, gpsData[i][gpsPosX], gpsData[i][gpsPosY], gpsData[i][gpsPosZ]));
						strcat(string2, string);
						format(var, sizeof(var), "GPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- เซิร์ฟเวอร์ยังไม่ได้เพิ่ม GPS");
					return 1;
				}
				format(string, sizeof(string), "รายชื่อสถานที่\tระยะทาง\n%s", string2);
				Dialog_Show(playerid, DIALOG_GPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Shop (ร้านขายรถ-พาวว์รถ)", string, "เลือก", "ปิด");
				PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
				return 1;
			}
			case 4: //ธนาคาร
			{
				new
					count,
					var[32],
					string[4096],
					string2[4096];

				for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
				{
					if(gpsData[i][gpsType] == 6)
					{
						format(string, sizeof(string), "%s\t{FFA84D}(%.0f เมตร)\n", gpsData[i][gpsName], GetPlayerDistanceFromPoint(playerid, gpsData[i][gpsPosX], gpsData[i][gpsPosY], gpsData[i][gpsPosZ]));
						strcat(string2, string);
						format(var, sizeof(var), "GPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- เซิร์ฟเวอร์ยังไม่ได้เพิ่ม GPS");
					return 1;
				}
				format(string, sizeof(string), "รายชื่อสถานที่\tระยะทาง\n%s", string2);
				Dialog_Show(playerid, DIALOG_GPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "Bank (ธนาคาร)", string, "เลือก", "ปิด");
				PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
				return 1;
			}
			case 5: //Spawn Vehicle (การาจ)
			{
				new
					count,
					var[32],
					string[4096],
					string2[4096];

				for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
				{
					if(gpsData[i][gpsType] == 7)
					{
						format(string, sizeof(string), "%s\t{FFA84D}(%.0f เมตร)\n", gpsData[i][gpsName], GetPlayerDistanceFromPoint(playerid, gpsData[i][gpsPosX], gpsData[i][gpsPosY], gpsData[i][gpsPosZ]));
						strcat(string2, string);
						format(var, sizeof(var), "GPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- เซิร์ฟเวอร์ยังไม่ได้เพิ่ม GPS");
					return 1;
				}
				format(string, sizeof(string), "รายชื่อสถานที่\tระยะทาง\n%s", string2);
				Dialog_Show(playerid, DIALOG_GPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "Spawn Vehicle (การาจ)", string, "เลือก", "ปิด");
				PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
				return 1;
			}
		}
		return 1;
	}
	return 1;
}