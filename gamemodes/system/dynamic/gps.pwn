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
	    SendClientMessage(playerid, COLOR_WHITE, "/creategps [�ٻẺ GPS] [����ʶҹ���]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[�ٻẺ GPS]:{FFFFFF} 1. Los Santos 2. San Fierro 3. Las Venturas  4.��ҹ���ö-�����ö 5. ʶҹ���ӧҹ");
	    SendClientMessage(playerid, COLOR_YELLOW, "[�ٻẺ GPS]:{FFFFFF} 6. ��Ҥ�� 7. �ش�ԡö");
	    return 1;
	}
	if (type < 1 || type > 7)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- �ٻẺ�ͧ GPS ��ͧ����ӡ��� 1 �������Թ 7 ��ҹ��");

	id = GPS_Create(type, gpsname, x, y, z);

	if (id == -1)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �����آͧ GPS 㹰ҹ������������� �������ö���ҧ���ա (�Դ��ͼ��Ѳ��)");

	SendClientMessageEx(playerid, COLOR_SERVER, "�س�����ҧ GPS ��������� �ٻẺ GPS: %d, ����ʶҹ���: %s, �ʹ�: %d", type, gpsname, id);
	return 1;
}

CMD:removegps(playerid, params[])
{
	static
	    id = 0;

    if (playerData[playerid][pAdmin] < 4)
	    return 1;

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, COLOR_WHITE, "/deletegps [�ʹ�]");

	if ((id < 0 || id >= MAX_GPS) || !gpsData[id][gpsExists])
	    return SendClientMessage(playerid, COLOR_RED, "- ������ʹ� GPS �������㹰ҹ������");

	GPS_Delete(id);
	SendClientMessageEx(playerid, COLOR_SERVER, "�س��ź GPS �ʹ� %d �͡�����", id);
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
	 	SendClientMessage(playerid, COLOR_WHITE, "/editgps [�ʹ�] [������¡��]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[������¡��]:{FFFFFF} name, type, location");
		return 1;
	}
	if ((id < 0 || id >= MAX_GPS) || !gpsData[id][gpsExists])
	    return SendClientMessage(playerid, COLOR_RED, "- ������ʹ� GPS �������㹰ҹ������");

	if (!strcmp(type, "location", true))
	{
	    GetPlayerPos(playerid, gpsData[id][gpsPosX], gpsData[id][gpsPosY], gpsData[id][gpsPosZ]);

		GPS_Save(id);

		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s �����µ��˹� GPS �ʹ� %d (%s)", GetPlayerNameEx(playerid), id, gpsData[id][gpsName]);
	}
	else if (!strcmp(type, "name", true))
	{
	    new name[32];

	    if (sscanf(string, "s[32]", name))
	        return SendClientMessage(playerid, COLOR_WHITE, "/editgps [�ʹ�] [������¡��] [���ͷ���ͧ�������¹]");

	    format(gpsData[id][gpsName], 32, name);

	    GPS_Save(id);

		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ������¹���� GPS �ʹ� %d �繪��� \"%s\"", GetPlayerNameEx(playerid), id, name);
	}
	else if (!strcmp(type, "type", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
	    {
	        SendClientMessage(playerid, COLOR_WHITE, "/editgps [�ʹ�] [������¡��] [�ٻẺ����ͧ���]");
			SendClientMessage(playerid, COLOR_YELLOW, "[�ٻẺ GPS]:{FFFFFF} 1. Los Santos 2. San Fierro 3. Las Venturas  4.��ҹ���ö-�����ö 5. ʶҹ���ӧҹ");
			SendClientMessage(playerid, COLOR_YELLOW, "[�ٻẺ GPS]:{FFFFFF} 6. ��Ҥ�� 7. �ش�ԡ�");
			return 1;
		}
		if (typeint < 1 || typeint > 7)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- �ٻẺ�ͧ GPS ��ͧ����ӡ��� 1 �������Թ 7 ��ҹ��");

        gpsData[id][gpsType] = typeint;

	    GPS_Save(id);
		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ���Ѻ�ٻẺ GPS �ʹ� %d (%s) ���ٻẺ %d", GetPlayerNameEx(playerid), id, gpsData[id][gpsName], typeint);
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
	return Dialog_Show(playerid, GPS_MANU, DIALOG_STYLE_LIST, "��¡��ʶҹ���", "{FFFFFF}\
		- Los Santos (��ʫҹ��)\n\
		- San Fierro (�ҹ�������)\n\
		- Las Venturas (����ǹ�����)\n\
		- Vehicle Shop (��ҹ���ö-�����ö)\n\
        - Bank (��Ҥ��)\n\
        - Spawn Vehicle (���Ҩ)\
        ", "���͡", "�Դ");

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
						format(string, sizeof(string), "%s\t{FFA84D}(%.0f ����)\n", gpsData[i][gpsName], GetPlayerDistanceFromPoint(playerid, gpsData[i][gpsPosX], gpsData[i][gpsPosY], gpsData[i][gpsPosZ]));
						strcat(string2, string);
						format(var, sizeof(var), "GPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ����������ѧ��������� GPS");
					return 1;
				}
				format(string, sizeof(string), "��ª���ʶҹ���\t���зҧ\n%s", string2);
				Dialog_Show(playerid, DIALOG_GPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "Los Santos (��ʫҹ��)", string, "���͡", "�Դ");
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
						format(string, sizeof(string), "%s\t{FFA84D}(%.0f ����)\n", gpsData[i][gpsName], GetPlayerDistanceFromPoint(playerid, gpsData[i][gpsPosX], gpsData[i][gpsPosY], gpsData[i][gpsPosZ]));
						strcat(string2, string);
						format(var, sizeof(var), "GPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ����������ѧ��������� GPS");
					return 1;
				}
				format(string, sizeof(string), "��ª���ʶҹ���\t���зҧ\n%s", string2);
				Dialog_Show(playerid, DIALOG_GPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "San Fierro (�ҹ�������)", string, "���͡", "�Դ");
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
						format(string, sizeof(string), "%s\t{FFA84D}(%.0f ����)\n", gpsData[i][gpsName], GetPlayerDistanceFromPoint(playerid, gpsData[i][gpsPosX], gpsData[i][gpsPosY], gpsData[i][gpsPosZ]));
						strcat(string2, string);
						format(var, sizeof(var), "GPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ����������ѧ��������� GPS");
					return 1;
				}
				format(string, sizeof(string), "��ª���ʶҹ���\t���зҧ\n%s", string2);
				Dialog_Show(playerid, DIALOG_GPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "Las Venturas (����ǹ�����)", string, "���͡", "�Դ");
				PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
				return 1;
			}
			case 3: //��ҹ���ö-�����ö
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
						format(string, sizeof(string), "%s\t{FFA84D}(%.0f ����)\n", gpsData[i][gpsName], GetPlayerDistanceFromPoint(playerid, gpsData[i][gpsPosX], gpsData[i][gpsPosY], gpsData[i][gpsPosZ]));
						strcat(string2, string);
						format(var, sizeof(var), "GPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ����������ѧ��������� GPS");
					return 1;
				}
				format(string, sizeof(string), "��ª���ʶҹ���\t���зҧ\n%s", string2);
				Dialog_Show(playerid, DIALOG_GPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Shop (��ҹ���ö-�����ö)", string, "���͡", "�Դ");
				PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
				return 1;
			}
			case 4: //��Ҥ��
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
						format(string, sizeof(string), "%s\t{FFA84D}(%.0f ����)\n", gpsData[i][gpsName], GetPlayerDistanceFromPoint(playerid, gpsData[i][gpsPosX], gpsData[i][gpsPosY], gpsData[i][gpsPosZ]));
						strcat(string2, string);
						format(var, sizeof(var), "GPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ����������ѧ��������� GPS");
					return 1;
				}
				format(string, sizeof(string), "��ª���ʶҹ���\t���зҧ\n%s", string2);
				Dialog_Show(playerid, DIALOG_GPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "Bank (��Ҥ��)", string, "���͡", "�Դ");
				PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
				return 1;
			}
			case 5: //Spawn Vehicle (���Ҩ)
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
						format(string, sizeof(string), "%s\t{FFA84D}(%.0f ����)\n", gpsData[i][gpsName], GetPlayerDistanceFromPoint(playerid, gpsData[i][gpsPosX], gpsData[i][gpsPosY], gpsData[i][gpsPosZ]));
						strcat(string2, string);
						format(var, sizeof(var), "GPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ����������ѧ��������� GPS");
					return 1;
				}
				format(string, sizeof(string), "��ª���ʶҹ���\t���зҧ\n%s", string2);
				Dialog_Show(playerid, DIALOG_GPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "Spawn Vehicle (���Ҩ)", string, "���͡", "�Դ");
				PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
				return 1;
			}
		}
		return 1;
	}
	return 1;
}