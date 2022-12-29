#include <YSI\y_hooks>

enum entranceData {
	entranceID,
	entranceExists,
	entranceName[32],
	entranceIcon,
	entranceLocked,
	Float:entrancePos[4],
	Float:entranceInt[4],
	entranceInterior,
	entranceExterior,
	entranceExteriorVW,
	entranceType,
	entranceCustom,
	entranceWorld,
	entranceForklift[7],
	entrancePickup,
	entranceMapIcon,
	Text3D:entranceText3D
};

new EntranceData[MAX_ENTRANCES][entranceData],Total_Entrances_Created;

forward Entrance_Load();
public Entrance_Load()
{
    new
	    rows;

    cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_ENTRANCES)
	{
	    EntranceData[i][entranceExists] = true;
    	cache_get_value_name_int(i, "entranceID", EntranceData[i][entranceID]);

		cache_get_value_name(i, "entranceName", EntranceData[i][entranceName], 32);

		cache_get_value_name_int(i, "entranceIcon", EntranceData[i][entranceIcon]);
  		cache_get_value_name_int(i, "entranceLocked", EntranceData[i][entranceLocked]);
    	cache_get_value_name_float(i, "entrancePosX", EntranceData[i][entrancePos][0]);
     	cache_get_value_name_float(i, "entrancePosY", EntranceData[i][entrancePos][1]);
     	cache_get_value_name_float(i, "entrancePosZ", EntranceData[i][entrancePos][2]);
     	cache_get_value_name_float(i, "entrancePosA", EntranceData[i][entrancePos][3]);
     	cache_get_value_name_float(i, "entranceIntX", EntranceData[i][entranceInt][0]);
     	cache_get_value_name_float(i, "entranceIntY", EntranceData[i][entranceInt][1]);
     	cache_get_value_name_float(i, "entranceIntZ", EntranceData[i][entranceInt][2]);
     	cache_get_value_name_float(i, "entranceIntA", EntranceData[i][entranceInt][3]);
     	cache_get_value_name_int(i, "entranceInterior", EntranceData[i][entranceInterior]);
     	cache_get_value_name_int(i, "entranceExterior", EntranceData[i][entranceExterior]);
	    cache_get_value_name_int(i, "entranceExteriorVW", EntranceData[i][entranceExteriorVW]);
     	cache_get_value_name_int(i, "entranceType", EntranceData[i][entranceType]);
     	cache_get_value_name_int(i, "entranceCustom", EntranceData[i][entranceCustom]);
     	cache_get_value_name_int(i, "entranceWorld", EntranceData[i][entranceWorld]);

	    Entrance_Refresh(i);

	    Total_Entrances_Created++;
	}
	printf("[MYSQL]: %d Entrances have been successfully loaded from the database.", Total_Entrances_Created);
	return 1;
}

Entrance_Delete(entranceid)
{
	if (entranceid != -1 && EntranceData[entranceid][entranceExists])
	{
	    new
	        string[64];

        Total_Entrances_Created--;

		format(string, sizeof(string), "DELETE FROM `entrances` WHERE `entranceID` = '%d'", EntranceData[entranceid][entranceID]);
		mysql_tquery(dbCon, string);

        if (IsValidDynamic3DTextLabel(EntranceData[entranceid][entranceText3D]))
		    DestroyDynamic3DTextLabel(EntranceData[entranceid][entranceText3D]);

		if (IsValidDynamicPickup(EntranceData[entranceid][entrancePickup]))
		    DestroyDynamicPickup(EntranceData[entranceid][entrancePickup]);

		if (IsValidDynamicMapIcon(EntranceData[entranceid][entranceMapIcon]))
		    DestroyDynamicMapIcon(EntranceData[entranceid][entranceMapIcon]);

	    EntranceData[entranceid][entranceExists] = false;
	    EntranceData[entranceid][entranceID] = 0;
	}
	return 1;
}

Entrance_Save(entranceid)
{
	new
	    query[1024];

	format(query, sizeof(query), "UPDATE `entrances` SET `entranceName` = '%s', `entranceIcon` = '%d', `entranceLocked` = '%d', `entrancePosX` = '%.4f', `entrancePosY` = '%.4f', `entrancePosZ` = '%.4f', `entrancePosA` = '%.4f', `entranceIntX` = '%.4f', `entranceIntY` = '%.4f', `entranceIntZ` = '%.4f', `entranceIntA` = '%.4f', `entranceInterior` = '%d', `entranceExterior` = '%d', `entranceExteriorVW` = '%d', `entranceType` = '%d'",
	    SQL_ReturnEscaped(EntranceData[entranceid][entranceName]),
	    EntranceData[entranceid][entranceIcon],
	    EntranceData[entranceid][entranceLocked],
	    EntranceData[entranceid][entrancePos][0],
	    EntranceData[entranceid][entrancePos][1],
	    EntranceData[entranceid][entrancePos][2],
	    EntranceData[entranceid][entrancePos][3],
	    EntranceData[entranceid][entranceInt][0],
	    EntranceData[entranceid][entranceInt][1],
	    EntranceData[entranceid][entranceInt][2],
	    EntranceData[entranceid][entranceInt][3],
	    EntranceData[entranceid][entranceInterior],
	    EntranceData[entranceid][entranceExterior],
	    EntranceData[entranceid][entranceExteriorVW],
	    EntranceData[entranceid][entranceType]
	);
	format(query, sizeof(query), "%s, `entranceCustom` = '%d', `entranceWorld` = '%d' WHERE `entranceID` = '%d'",
	    query,
	    EntranceData[entranceid][entranceCustom],
	    EntranceData[entranceid][entranceWorld],
	    EntranceData[entranceid][entranceID]
	);
	return mysql_tquery(dbCon, query);
}

Entrance_Inside(playerid)
{
	if (Character[playerid][Entrance] != -1)
	{
	    for (new i = 0; i != MAX_ENTRANCES; i ++) if (EntranceData[i][entranceExists] && EntranceData[i][entranceID] == Character[playerid][Entrance] && GetPlayerInterior(playerid) == EntranceData[i][entranceInterior] && GetPlayerVirtualWorld(playerid) == EntranceData[i][entranceWorld])
	        return i;
	}
	return -1;
}

Entrance_GetLink(playerid)
{
	if (GetPlayerVirtualWorld(playerid) > 0)
	{
	    for (new i = 0; i != MAX_ENTRANCES; i ++) if (EntranceData[i][entranceExists] && EntranceData[i][entranceID] == GetPlayerVirtualWorld(playerid) - 7000)
			return EntranceData[i][entranceID];
	}
	return -1;
}

Entrance_Nearest(playerid, Float:radius = 3.0)
{
    for (new i = 0; i != MAX_ENTRANCES; i ++) if (EntranceData[i][entranceExists] && IsPlayerInRangeOfPoint(playerid, radius, EntranceData[i][entrancePos][0], EntranceData[i][entrancePos][1], EntranceData[i][entrancePos][2]))
	{
		if (GetPlayerInterior(playerid) == EntranceData[i][entranceExterior] && GetPlayerVirtualWorld(playerid) == EntranceData[i][entranceExteriorVW])
			return i;
	}
	return -1;
}

CheckEntrance_Nearest(playerid, Float:radius = 7.0)
{
    for (new i = 0; i != MAX_ENTRANCES; i ++) if (EntranceData[i][entranceExists] && IsPlayerInRangeOfPoint(playerid, radius, EntranceData[i][entrancePos][0], EntranceData[i][entrancePos][1], EntranceData[i][entrancePos][2]))
	{
		if (GetPlayerInterior(playerid) == EntranceData[i][entranceExterior] && GetPlayerVirtualWorld(playerid) == EntranceData[i][entranceExteriorVW])
			return i;
	}
	return -1;
}

Entrance_NearestInside(playerid)
{
    for (new i = 0; i != MAX_ENTRANCES; i ++) if (EntranceData[i][entranceExists] && IsPlayerInRangeOfPoint(playerid, 2.5, EntranceData[i][entranceInt][0], EntranceData[i][entranceInt][1], EntranceData[i][entranceInt][2]))
	{
		if (GetPlayerInterior(playerid) == EntranceData[i][entranceInterior] && GetPlayerVirtualWorld(playerid) == EntranceData[i][entranceWorld])
			return i;
	}
	return -1;
}

Entrance_Refresh(entranceid)
{
	if (entranceid != -1 && EntranceData[entranceid][entranceExists])
	{
		if (IsValidDynamic3DTextLabel(EntranceData[entranceid][entranceText3D]))
		    DestroyDynamic3DTextLabel(EntranceData[entranceid][entranceText3D]);

		if (IsValidDynamicPickup(EntranceData[entranceid][entrancePickup]))
		    DestroyDynamicPickup(EntranceData[entranceid][entrancePickup]);

		if (IsValidDynamicMapIcon(EntranceData[entranceid][entranceMapIcon]))
		    DestroyDynamicMapIcon(EntranceData[entranceid][entranceMapIcon]);

		//EntranceData[entranceid][entranceText3D] = CreateDynamic3DTextLabel(EntranceData[entranceid][entranceName], COLOR_WHITE, EntranceData[entranceid][entrancePos][0], EntranceData[entranceid][entrancePos][1], EntranceData[entranceid][entrancePos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, EntranceData[entranceid][entranceExteriorVW], EntranceData[entranceid][entranceExterior]);
        EntranceData[entranceid][entrancePickup] = CreateDynamicPickup(1239, 23, EntranceData[entranceid][entrancePos][0], EntranceData[entranceid][entrancePos][1], EntranceData[entranceid][entrancePos][2], EntranceData[entranceid][entranceExteriorVW], EntranceData[entranceid][entranceExterior]);

		if (EntranceData[entranceid][entranceIcon] != 0)
			EntranceData[entranceid][entranceMapIcon] = CreateDynamicMapIcon(EntranceData[entranceid][entrancePos][0], EntranceData[entranceid][entrancePos][1], EntranceData[entranceid][entrancePos][2], EntranceData[entranceid][entranceIcon], 0, EntranceData[entranceid][entranceExteriorVW], EntranceData[entranceid][entranceExterior]);
	}
	return 1;
}

Entrance_Create(playerid, name[])
{
	new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;

    if (GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
	{
		for (new i = 0; i != MAX_HOUSES; i ++)
		{
	    	if (!EntranceData[i][entranceExists])
		    {
    	        EntranceData[i][entranceExists] = true;
        	    EntranceData[i][entranceIcon] = 0;
        	    EntranceData[i][entranceType] = 0;
        	    EntranceData[i][entranceCustom] = 0;
        	    EntranceData[i][entranceLocked] = 0;

				format(EntranceData[i][entranceName], 32, name);

    	        EntranceData[i][entrancePos][0] = x;
    	        EntranceData[i][entrancePos][1] = y;
    	        EntranceData[i][entrancePos][2] = z;
    	        EntranceData[i][entrancePos][3] = angle;

                EntranceData[i][entranceInt][0] = x;
                EntranceData[i][entranceInt][1] = y;
                EntranceData[i][entranceInt][2] = z + 10000;
                EntranceData[i][entranceInt][3] = 0.0000;

				EntranceData[i][entranceInterior] = 0;
				EntranceData[i][entranceExterior] = GetPlayerInterior(playerid);
				EntranceData[i][entranceExteriorVW] = GetPlayerVirtualWorld(playerid);

				Entrance_Refresh(i);
				mysql_tquery(dbCon, "INSERT INTO `entrances` (`entranceType`) VALUES(0)", "OnEntranceCreated", "d", i);
				return i;
			}
		}
	}
	return -1;
}

forward OnEntranceCreated(entranceid);
public OnEntranceCreated(entranceid)
{
	if (entranceid == -1 || !EntranceData[entranceid][entranceExists])
	    return 0;

	EntranceData[entranceid][entranceID] = cache_insert_id();
	EntranceData[entranceid][entranceWorld] = EntranceData[entranceid][entranceID] + 7000;

	Entrance_Save(entranceid);

	return 1;
}

ViewEntrances(playerid)
{
	new string[2048], menu[20], count;

	format(string, sizeof(string), "%s{B4B5B7}˹�� 1\n", string);

	SetPVarInt(playerid, "page", 1);

	for(new i=0; i<MAX_ENTRANCES; i++)
	{
	    if(EntranceData[i][entranceExists])
	    {
			if(count == 20)
			{
				format(string, sizeof(string), "%s{B4B5B7}˹�� 2\n", string);
				break;
			}
			format(menu, 20, "menu%d", ++count);
			SetPVarInt(playerid, menu, i);
			format(string, sizeof(string), "%s({FFBF00}%i"EMBED_WHITE") | "EMBED_LIGHTGREEN"%s\n", string, i + 1, EntranceData[i][entranceName]);
		}
	}
	if(!count) Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "��ª��ͷҧ���", "��辺�����Ţͧ�ҧ���..", "�Դ", "");
	else Dialog_Show(playerid, EntrancesList, DIALOG_STYLE_LIST, "��ª��ͷҧ���", string, "���", "��Ѻ");
	return 1;
}

Dialog:EntrancesList(playerid, response, listitem, inputtext[])
{
	if(response) {

		new menu[20];
		//Navigate
		if(listitem != 0 && listitem != 21) {
			new str_biz[20];
			format(str_biz, 20, "menu%d", listitem);

			SetPVarInt(playerid, "EntranceEditID", GetPVarInt(playerid, str_biz));
			ShowPlayerEditEntrance(playerid);
			return 1;
		}

		new currentPage = GetPVarInt(playerid, "page");
		if(listitem==0) {
			if(currentPage>1) currentPage--;
		}
		else if(listitem == 21) currentPage++;

		new string[2048], count;
		format(string, sizeof(string), "%s{B4B5B7}˹�� %d\n", string, (currentPage==1) ? 1 : currentPage-1);

		SetPVarInt(playerid, "page", currentPage);

		new skipitem = (currentPage-1) * 20;

		for(new i=0; i<MAX_ENTRANCES; i++)
		{
		    if(EntranceData[i][entranceExists])
	    	{

				if(skipitem)
				{
					skipitem--;
					continue;
				}
				if(count == 20)
				{
					format(string, sizeof(string), "%s{B4B5B7}˹�� 2\n", string);
					break;
				}
				format(menu, 20, "menu%d", ++count);
				SetPVarInt(playerid, menu, i);
				format(string, sizeof(string), "%s({FFBF00}%i"EMBED_WHITE") | "EMBED_LIGHTGREEN"%s\n", string, i + 1, EntranceData[i][entranceName]);

			}
		}

		Dialog_Show(playerid, EntrancesList, DIALOG_STYLE_LIST, "��ª��ͷҧ���", string, "���", "��Ѻ");
	}
	return 1;
}

ShowPlayerEditEntrance(playerid)
{
    new id = GetPVarInt(playerid, "EntranceEditID");
	new caption[128], dialog_str[1024];
	format(caption, sizeof(caption), "��䢷ҧ���: %s (SQLID:%d)", EntranceData[id][entranceName], EntranceData[id][entranceID]);
    format(dialog_str, sizeof dialog_str, "���ͷҧ���\t%s\n", EntranceData[id][entranceName]);
    format(dialog_str, sizeof dialog_str, "%s �������ͤ͹\t%d\n", dialog_str, EntranceData[id][entranceIcon]);
    format(dialog_str, sizeof dialog_str, "%s��駤�ҷҧ������ѧ���˹觢ͧ�س\t\n", dialog_str);
    format(dialog_str, sizeof dialog_str, "%s��駤�ҷҧ�͡���ѧ���˹觢ͧ�س\t\n", dialog_str);
	format(dialog_str, sizeof dialog_str, "%s��ͤ/�Ŵ��ͤ\t\n", dialog_str);
    format(dialog_str, sizeof dialog_str, "%s������ѧ�ҧ��ҹ��\t", dialog_str);
	Dialog_Show(playerid, EntranceEdit, DIALOG_STYLE_TABLIST, caption, dialog_str, "���", "��Ѻ");
	return 1;
}

Dialog:EntranceEdit(playerid, response, listitem, inputtext[])
{
	if(response) {

		new caption[128];
        new id = GetPVarInt(playerid, "EntranceEditID");
		switch(listitem)
		{
			case 0: // ��䢪���
			{
				format(caption, sizeof(caption), "��� -> ����: %s", EntranceData[id][entranceName]);
				Dialog_Show(playerid, EntranceEdit_Name, DIALOG_STYLE_INPUT, caption, "������Ǣͧ���͵�ͧ�ҡ���� 0 �������Թ 60 ����ѡ��\n\n��͡����ῤ��蹷���ͧ���㹪�ͧ��ҧ��ҹ��ҧ���:", "����¹", "��Ѻ");
			}
			case 1: // mapicon
			{
				format(caption, sizeof(caption), "��� -> ����ͤ͹: %d", EntranceData[id][entranceIcon]);
				Dialog_Show(playerid, EntranceEdit_Icon, DIALOG_STYLE_INPUT, caption, ""EMBED_WHITE"�������ͤ͹\n����Ţ icon ��ҹ��ҧ:", "����¹", "��Ѻ");
			}
			case 2:
			{
				format(caption, sizeof(caption), "��� -> ��䢷ҧ���");
				Dialog_Show(playerid, EntranceEdit_Enter, DIALOG_STYLE_MSGBOX, caption, ""EMBED_WHITE"�س������ͷ��л�Ѻ �ҧ��� ������ѧ���˹觻Ѩ�غѹ�ͧ�س", "�׹�ѹ", "��Ѻ");
			}
			case 3:
			{
				format(caption, sizeof(caption), "��� -> ��䢷ҧ�͡");
				Dialog_Show(playerid, EntranceEdit_Exit, DIALOG_STYLE_MSGBOX, caption, ""EMBED_WHITE"�س������ͷ��л�Ѻ �ҧ�͡ ���ѧ���˹觻Ѩ�غѹ�ͧ�س", "�׹�ѹ", "��Ѻ");
			}
			case 4:
			{
				if(EntranceData[id][entranceLocked] == 0)
				{
					EntranceData[id][entranceLocked] = 1;
					Entrance_Save(id);
					SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ����ͤ�ҧ����ʹ�: %d", ReturnRealName(playerid, 0), id);
				}
				else if(EntranceData[id][entranceLocked] == 1)
				{
					EntranceData[id][entranceLocked] = 0;
					Entrance_Save(id);
					SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ��Ŵ��ͤ�ҧ����ʹ�: %d", ReturnRealName(playerid, 0), id);
				}
			}
   			case 5:
			{
				SetPlayerPos(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2]);
				SetPlayerInterior(playerid, EntranceData[id][entranceExterior]);
				SetPlayerVirtualWorld(playerid, EntranceData[id][entranceExteriorVW]);
				SetPlayerFacingAngle(playerid, EntranceData[id][entrancePos][3]);

				SendClientMessage(playerid, COLOR_GRAD1, "   �س��������ѧ�ҧ��� %s(%d) ", EntranceData[id][entranceName], id+1);
			}
		}
	}
	else
	{
	    DeletePVar(playerid, "EntranceEditID");
        ViewEntrances(playerid);
	}
    return 1;
}

Dialog:EntranceEdit_Name(playerid, response, listitem, inputtext[])
{
	if(response) {
		new caption[128];
		new id = GetPVarInt(playerid, "EntranceEditID");

		if(isnull(inputtext) || strlen(inputtext) >= 60) {
			format(caption, sizeof(caption), "��� -> ����: %s", EntranceData[id][entranceName]);
			Dialog_Show(playerid, EntranceEdit_Name, DIALOG_STYLE_INPUT, caption, ""EMBED_LIGHTRED"����ͼԴ��Ҵ:\n"EMBED_WHITE"������Ǣͧ���͵�ͧ�ҡ���� "EMBED_YELLOW"0 "EMBED_WHITE"�������Թ "EMBED_YELLOW"60 "EMBED_WHITE"����ѡ��", "����¹", "��Ѻ");
			return 1;
		}
		SendClientMessage(playerid, COLOR_GRAD1, " �ҧ��Ҫ��� "EMBED_WHITE"%s"EMBED_GRAD1" �� "EMBED_WHITE"%s"EMBED_GRAD1"", EntranceData[id][entranceName], inputtext);

		format(EntranceData[id][entranceName], 32, inputtext);
		Entrance_Refresh(id);
		Entrance_Save(id);
	}
	return ShowPlayerEditEntrance(playerid);
}

Dialog:EntranceEdit_Icon(playerid, response, listitem, inputtext[])
{
	if(response) {
		new caption[128];
		new id = GetPVarInt(playerid, "EntranceEditID");

        new icon = strval(inputtext);

		if(isnull(inputtext)) {
			format(caption, sizeof(caption), "��� -> ����ͤ͹: %d", EntranceData[id][entranceIcon]);
			Dialog_Show(playerid, EntranceEdit_Icon, DIALOG_STYLE_INPUT, caption, ""EMBED_WHITE"�������ͤ͹\n����Ţ icon ��ҹ��ҧ:", "����¹", "��Ѻ");
			return 1;
		}

		if(icon < 1 || icon > 63) {
			format(caption, sizeof(caption), "��� -> ����ͤ͹: %d", EntranceData[id][entranceIcon]);
			Dialog_Show(playerid, EntranceEdit_Icon, DIALOG_STYLE_INPUT, caption, ""EMBED_WHITE"Mapicon ��ͧ�����¡��� 1 �������ҡ���� 63!!\n�������ͤ͹\n����Ţ icon ��ҹ��ҧ:", "����¹", "��Ѻ");
			return 1;
		}

		SendClientMessage(playerid, COLOR_GRAD1, " �ҧ��Ҫ��� "EMBED_WHITE"%s"EMBED_GRAD1" �١����¹ mapicon �� %d", EntranceData[id][entranceName], icon);

		EntranceData[id][entranceIcon] = icon;
		//format(EntranceData[id][entranceName], 32, inputtext);
		Entrance_Refresh(id);
		Entrance_Save(id);
	}
	return ShowPlayerEditEntrance(playerid);
}

Dialog:EntranceEdit_Enter(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new id = GetPVarInt(playerid, "EntranceEditID");
		new Float:px, Float:py, Float:pz, Float:pa, pint = GetPlayerInterior(playerid), pworld = GetPlayerVirtualWorld(playerid);
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerFacingAngle(playerid, pa);

		SendClientMessage(playerid, COLOR_GRAD1, " �ҧ��Ңͧ "EMBED_WHITE"%s"EMBED_GRAD1" �١����¹���ѧ�������Ѩ�غѹ�ͧ�س����", EntranceData[id][entranceName]);

        EntranceData[id][entrancePos][0]=px;
        EntranceData[id][entrancePos][1]=py;
        EntranceData[id][entrancePos][2]=pz;
		EntranceData[id][entrancePos][3]=pa;
        EntranceData[id][entranceExterior]=pint;
        EntranceData[id][entranceExteriorVW]=pworld;

		Entrance_Refresh(id);
	   	Entrance_Save(id);
	}
	return ShowPlayerEditEntrance(playerid);
}

Dialog:EntranceEdit_Exit(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new id = GetPVarInt(playerid, "EntranceEditID");
		new Float:px, Float:py, Float:pz, Float:pa, pint = GetPlayerInterior(playerid);
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerFacingAngle(playerid, pa);

		SendClientMessage(playerid, COLOR_GRAD1, " �ҧ�͡�ͧ "EMBED_WHITE"%s"EMBED_GRAD1" �١����¹���ѧ�������Ѩ�غѹ�ͧ�س����", EntranceData[id][entranceName]);

        EntranceData[id][entranceInt][0]=px;
        EntranceData[id][entranceInt][1]=py;
        EntranceData[id][entranceInt][2]=pz;
		EntranceData[id][entranceInt][3]=pa;
        EntranceData[id][entranceInterior]=pint;
        EntranceData[id][entranceWorld]= EntranceData[id][entranceID] + 7000;

		Entrance_Refresh(id);
	   	Entrance_Save(id);

        SetPlayerVirtualWorld(playerid, EntranceData[id][entranceWorld]);
	}
	return ShowPlayerEditEntrance(playerid);
}

//entrance cmd

CMD:createentrance(playerid, params[])
{
	new
	    string[128];

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "�س������Ѻ͹حҵ��������觹��");

	if (isnull(params) || strlen(params) > 32)
	    return SystemMsg(playerid, "/createentrance [name]");

	new id = Entrance_Create(playerid, params);

	if (id == -1)
	    return SendClientMessage(playerid, -1, "�Կ���������ҧ����Թ�մ�ӡѴ����");

	format(string, sizeof(string), "�س����ʺ���������㹡�����ҧ�ҧ����ʹ�: %d", id);
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:editentrance(playerid, params[])
{
	new
	    id,
	    type[24],
	    string[128];

	if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "�س������Ѻ͹حҵ��������觹��");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SystemMsg(playerid, "/editentrance [id] [name]");
	    SystemMsg(playerid, "[NAMES]:{FFFFFF} location, interior, name, locked, mapicon, type, custom, virtual");
		return 1;
	}
	if ((id < 0 || id >= MAX_ENTRANCES) || !EntranceData[id][entranceExists])
	    return SendClientMessage(playerid, -1, "�س�к��ʹշҧ������١��ͧ");

	if (!strcmp(type, "location", true))
	{
	    GetPlayerPos(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2]);
		GetPlayerFacingAngle(playerid, EntranceData[id][entrancePos][3]);

		EntranceData[id][entranceExterior] = GetPlayerInterior(playerid);
		EntranceData[id][entranceExteriorVW] = GetPlayerVirtualWorld(playerid);

		Entrance_Refresh(id);
		Entrance_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ���Ѻ���˹觢ͧ�ҧ����ʹ�: %d", ReturnName(playerid, 0), id);
	}
	else if (!strcmp(type, "interior", true))
	{
	    GetPlayerPos(playerid, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2]);
		GetPlayerFacingAngle(playerid, EntranceData[id][entranceInt][3]);

		EntranceData[id][entranceInterior] = GetPlayerInterior(playerid);

        foreach (new i : Player)
		{
			if (Character[i][Entrance] == EntranceData[id][entranceID])
			{
				SetPlayerPosEx(i, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2], EntranceData[id][entranceInterior], EntranceData[id][entranceWorld]);
				SetPlayerFacingAngle(i, EntranceData[id][entranceInt][3]);
				SetCameraBehindPlayer(i);
			}
		}
		Entrance_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ���Ѻ���˹觨ش�Դ���㹢ͧ�ҧ����ʹ�: %d", ReturnName(playerid, 0), id);
	}
	else if (!strcmp(type, "custom", true))
	{
	    new status;

	    if (sscanf(string, "d", status))
	        return SendClientMessage(playerid, -1, "/editentrance [id] [custom] [0/1]");

		if (status < 0 || status > 1)
		    return SendClientMessage(playerid, -1, "�س��ͧ�к�����ӡ��� 0 �����ҡ���� 1");

	    EntranceData[id][entranceCustom] = status;
	    Entrance_Save(id);

	    if (status) {
			SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ���Դ�����ҹ��������Ẻ��˹��ͧ����Ѻ�ҧ����ʹ�: %d.", ReturnRealName(playerid, 0), id);
		}
		else {
		    SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ��Դ�����ҹ��������Ẻ��˹��ͧ����Ѻ�ҧ����ʹ�: %d", ReturnRealName(playerid, 0), id);
		}
	}
	else if (!strcmp(type, "virtual", true))
	{
	    new worldid;

	    if (sscanf(string, "d", worldid))
	        return SendClientMessage(playerid, -1, "/editentrance [id] [virtual] [interior world]");

	    EntranceData[id][entranceWorld] = worldid;

		foreach (new i : Player) if (Entrance_Inside(i) == id) {
			SetPlayerVirtualWorld(i, worldid);
		}
		Entrance_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ���Ѻ�š���ͧ�ͧ�ҧ����ʹ�: %d �� %d", ReturnRealName(playerid, 0), id, worldid);
	}
	else if (!strcmp(type, "mapicon", true))
	{
	    new icon;

	    if (sscanf(string, "d", icon))
	        return SendClientMessage(playerid, -1, "/editentrance [id] [mapicon] [map icon]");

		if (icon < 0 || icon > 63)
		    return SendClientMessage(playerid, -1, "�ͤ͹Ἱ������١��ͧ! �ͤ͹Ἱ�������ö�������������\"wiki.sa-mp.com/wiki/MapIcons\"");

	    EntranceData[id][entranceIcon] = icon;

	    Entrance_Refresh(id);
	    Entrance_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ���Ѻ�ҤҢͧ�ҧ����ʹ�: %d �� %d", ReturnRealName(playerid, 0), id, icon);
	}
	else if (!strcmp(type, "locked", true))
	{
	    new locked;

	    if (sscanf(string, "d", locked))
	        return SendClientMessage(playerid, -1, "/editentrance [id] [locked] [locked 0/1]");

		if (locked < 0 || locked > 1)
		    return SendClientMessage(playerid, -1, "���૿���١��ͧ �� 0 ���ͻŴ��ͤ��� 1 ������ͤ");

	    EntranceData[id][entranceLocked] = locked;
	    Entrance_Save(id);

	    if (locked) {
			SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ����ͤ�ҧ����ʹ�: %d", ReturnRealName(playerid, 0), id);
		} else {
		    SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ��Ŵ��ͤ�ҧ����ʹ�: %d", ReturnRealName(playerid, 0), id);
		}
	}
	else if (!strcmp(type, "name", true))
	{
	    new name[32];

	    if (sscanf(string, "s[32]", name))
	        return SendClientMessage(playerid, -1, "/editentrance [id] [name] [new name]");

	    format(EntranceData[id][entranceName], 32, name);

	    Entrance_Refresh(id);
	    Entrance_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ���Ѻ���ͧ͢�ҧ����ʹ�: %d �� \"%s\"", ReturnRealName(playerid, 0), id, name);
	}
	else if (!strcmp(type, "type", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
	    {
	        SendClientMessage(playerid, -1, "/editentrance [id] [type] [entrance type]");
			SendClientMessage(playerid, COLOR_YELLOW, "[TYPES]:{FFFFFF} 0: None | 1: DMV | 2: Bank | 3: City Hall | 4: Shooting Range");
			return 1;
		}
		if (typeint < 0 || typeint > 4)
			return SendClientMessage(playerid, -1, "����������кص�ͧ����������ҧ 0 �֧ 4");

        EntranceData[id][entranceType] = typeint;

        switch (typeint) {
            case 1: {
            	EntranceData[id][entranceInt][0] = -2029.5531;
           		EntranceData[id][entranceInt][1] = -118.8003;
            	EntranceData[id][entranceInt][2] = 1035.1719;
            	EntranceData[id][entranceInt][3] = 0.0000;
				EntranceData[id][entranceInterior] = 3;
            }
			case 2: {
            	EntranceData[id][entranceInt][0] = 389.1693;
           		EntranceData[id][entranceInt][1] = 173.7330;
            	EntranceData[id][entranceInt][2] = 1008.3828;
            	EntranceData[id][entranceInt][3] = 90.2212;
				EntranceData[id][entranceInterior] = 3;
            }
			case 3: {
			    EntranceData[id][entranceInt][0] = 390.1687;
           		EntranceData[id][entranceInt][1] = 173.8072;
            	EntranceData[id][entranceInt][2] = 1008.3828;
            	EntranceData[id][entranceInt][3] = 90.0000;
				EntranceData[id][entranceInterior] = 3;
			}
			case 4: {
			    EntranceData[id][entranceInt][0] = 304.0165;
           		EntranceData[id][entranceInt][1] = -141.9894;
            	EntranceData[id][entranceInt][2] = 1004.0625;
            	EntranceData[id][entranceInt][3] = 90.0000;
				EntranceData[id][entranceInterior] = 7;
			}
		}
		foreach (new i : Player)
		{
			if (Character[i][Entrance] == EntranceData[id][entranceID])
			{
				SetPlayerPosEx(i, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2], EntranceData[id][entranceInterior], EntranceData[id][entranceWorld]);
				SetPlayerFacingAngle(i, EntranceData[id][entranceInt][3]);

				SetCameraBehindPlayer(i);
			}
		}
	    Entrance_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ���Ѻ�������ͧ�ҧ����ʹ�: %d �� %d", ReturnRealName(playerid, 0), id, typeint);
	}
	return 1;
}


CMD:viewentrances(playerid, params[])
{
    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "�س������Ѻ͹حҵ��������觹��");

    ViewEntrances(playerid);
	return 1;
}

CMD:destroyentrance(playerid, params[])
{
	new
	    id = 0,
		string[128];

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "�س������Ѻ͹حҵ��������觹��");

	if (sscanf(params, "d", id))
	    return SystemMsg(playerid, "/destroyentrance [entrance id]");

	if ((id < 0 || id >= MAX_ENTRANCES) || !EntranceData[id][entranceExists])
	    return SendClientMessage(playerid, -1, "�س�к��ʹշҧ������١��ͧ");

	Entrance_Delete(id);
	format(string, sizeof(string), "�س����ʺ���������㹡�÷���·ҧ����ʹ�: %d", id);
	SendClientMessage(playerid, -1, string);
	return 1;
}
