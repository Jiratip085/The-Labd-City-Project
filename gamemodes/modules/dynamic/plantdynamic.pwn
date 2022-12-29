#include <YSI\y_hooks>

enum fielddata {
	fieldID,
	fieldExists,
    fieldPrice,
	Float:fieldPos[4],
	fieldInterior,
    fieldOwner,
	fieldWorld,
	fieldPickups,
    fieldObject,
	Text3D:fieldText3D
};
new FieldData[MAX_FIELDS][fielddata];

new CheckRadiusField[MAX_PLAYERS];

new Total_Fields_Created;

Field_Create(playerid, price)
{
	new
	    Float:x,
	    Float:y,
	    Float:z,
        Float:angle;

	if (GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
	{
		for (new i = 0; i != MAX_FIELDS; i ++)
		{
	    	if (!FieldData[i][fieldExists])
	    	{
	        	FieldData[i][fieldExists] = true;
                FieldData[i][fieldOwner] = 0;
                FieldData[i][fieldPrice] = price;
				FieldData[i][fieldPos][0] = x;
	        	FieldData[i][fieldPos][1] = y;
	        	FieldData[i][fieldPos][2] = z;
                FieldData[i][fieldPos][3] = angle;

	        	FieldData[i][fieldInterior] = GetPlayerInterior(playerid);
	        	FieldData[i][fieldWorld] = GetPlayerVirtualWorld(playerid);

	        	Field_Refresh(i);
	        	mysql_tquery(dbCon, "INSERT INTO `fields` (`fieldOwner`) VALUES(0)", "OnFieldCreated", "d", i);
	        	return i;
	        }
	    }
	}
	return -1;
}

forward OnFieldCreated(fieldid);
public OnFieldCreated(fieldid)
{
	if (fieldid == -1 || !FieldData[fieldid][fieldExists])
	    return 0;

	FieldData[fieldid][fieldID] = cache_insert_id();
	Field_Save(fieldID);

	return 1;
}

Field_Save(fieldid)
{
	new
	    query[512];

	format(query, sizeof(query), "UPDATE `fields` SET `fieldOwner` = '%d', `fieldPrice` = '%d', `fieldPosX` = '%.4f', `fieldPosY` = '%.4f', `fieldPosZ` = '%.4f', `fieldPosA` = '%.4f', `fieldInterior` = '%d', `fieldWorld` = '%d' WHERE `fieldID` = '%d'",
        FieldData[fieldid][fieldOwner],
        FieldData[fieldid][fieldPrice],
        FieldData[fieldid][fieldPos][0],
	    FieldData[fieldid][fieldPos][1],
	    FieldData[fieldid][fieldPos][2],
        FieldData[fieldid][fieldPos][3],
	    FieldData[fieldid][fieldInterior],
	    FieldData[fieldid][fieldWorld],
	    FieldData[fieldid][fieldID]
	);
	return mysql_tquery(dbCon, query);
}

Field_Delete(fieldid)
{
	if (fieldid != -1 && FieldData[fieldid][fieldExists])
	{
	    new
	        string[64];

		format(string, sizeof(string), "DELETE FROM `fields` WHERE `fieldID` = '%d'", FieldData[fieldid][fieldID]);
		mysql_tquery(dbCon, string);

        if (IsValidDynamic3DTextLabel(FieldData[fieldid][fieldText3D]))
            DestroyDynamic3DTextLabel(FieldData[fieldid][fieldText3D]);

        if (IsValidDynamicPickup(FieldData[fieldid][fieldPickups]))
            DestroyDynamicPickup(FieldData[fieldid][fieldPickups]);

        if (IsValidDynamicObject(FieldData[fieldid][fieldObject]))
            DestroyDynamicObject(FieldData[fieldid][fieldObject]);

		FieldData[fieldid][fieldExists] = false;
	    FieldData[fieldid][fieldID] = 0;
        FieldData[fieldid][fieldOwner] = 0;
	}
	return 1;
}

//dynamic product
forward Field_Load();
public Field_Load()
{
	new
	    rows;

	cache_get_row_count(rows);

    for (new i = 0; i < rows; i ++) if (i < MAX_FIELDS)
	{
	    FieldData[i][fieldExists] = true;

	    cache_get_value_name_int(i, "fieldID", FieldData[i][fieldID]);
        cache_get_value_name_int(i, "fieldOwner", FieldData[i][fieldOwner]);
        cache_get_value_name_int(i, "fieldPrice", FieldData[i][fieldPrice]);
	    cache_get_value_name_float(i, "fieldPosX", FieldData[i][fieldPos][0]);
	    cache_get_value_name_float(i, "fieldPosY", FieldData[i][fieldPos][1]);
	    cache_get_value_name_float(i, "fieldPosZ", FieldData[i][fieldPos][2]);
        cache_get_value_name_float(i, "fieldPosA", FieldData[i][fieldPos][3]);
	    cache_get_value_name_int(i, "fieldInterior", FieldData[i][fieldInterior]);
	    cache_get_value_name_int(i, "fieldWorld", FieldData[i][fieldWorld]);

        Total_Fields_Created++;
 	    Field_Refresh(i);
	}
    printf("[MYSQL]: %d Fields have been successfully loaded from the database.", Total_Fields_Created);
	return 1;
}

Field_Refresh(fieldid)
{
	if (fieldid != -1 && FieldData[fieldid][fieldExists])
	{
        if (IsValidDynamic3DTextLabel(FieldData[fieldid][fieldText3D]))
            DestroyDynamic3DTextLabel(FieldData[fieldid][fieldText3D]);

        if (IsValidDynamicPickup(FieldData[fieldid][fieldPickups]))
            DestroyDynamicPickup(FieldData[fieldid][fieldPickups]);

        if (IsValidDynamicObject(FieldData[fieldid][fieldObject]))
            DestroyDynamicObject(FieldData[fieldid][fieldObject]);
        
		new
		    string[1024];

        new Float:z;

        if (!FieldData[fieldid][fieldOwner]) {
            format(string, sizeof(string), "{FFD502}[���Թ�ҧ�Դ���]\n�� 'N' ������ҹ");
            FieldData[fieldid][fieldText3D] = CreateDynamic3DTextLabel(string, COLOR_WHITE, FieldData[fieldid][fieldPos][0], FieldData[fieldid][fieldPos][1], FieldData[fieldid][fieldPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, FieldData[fieldid][fieldWorld], FieldData[fieldid][fieldInterior]);
            MapAndreas_FindZ_For2DCoord(FieldData[fieldid][fieldPos][0],FieldData[fieldid][fieldPos][1],z);
            FieldData[fieldid][fieldObject] = CreateDynamicObject(19470, FieldData[fieldid][fieldPos][0], FieldData[fieldid][fieldPos][1],z, 0.0, 0.0, FieldData[fieldid][fieldPos][3]-90.0, 0, 0);
            //FieldData[fieldid][foodPickups] = CreateDynamicPickup(1239, 23, FieldData[fieldid][fieldPos][0], FieldData[fieldid][fieldPos][1], FieldData[fieldid][fieldPos][2], FieldData[fieldid][fieldWorld], FieldData[fieldid][fieldInterior]);
        }
        else
        {
            format(string, sizeof(string), "{FFD502}[���Թ�������Ңͧ����]\n������ 'N' ������ҹ");
            FieldData[fieldid][fieldText3D] = CreateDynamic3DTextLabel(string, COLOR_WHITE, FieldData[fieldid][fieldPos][0], FieldData[fieldid][fieldPos][1], FieldData[fieldid][fieldPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, FieldData[fieldid][fieldWorld], FieldData[fieldid][fieldInterior]);
            FieldData[fieldid][fieldPickups] = CreateDynamicPickup(1239, 23, FieldData[fieldid][fieldPos][0], FieldData[fieldid][fieldPos][1], FieldData[fieldid][fieldPos][2], FieldData[fieldid][fieldWorld], FieldData[fieldid][fieldInterior]);
        }
    }
	return 1;
}

Field_Nearest(playerid)
{
    for (new i = 0; i != MAX_FIELDS; i ++) if (FieldData[i][fieldExists] && IsPlayerInRangeOfPoint(playerid, 15.0, FieldData[i][fieldPos][0], FieldData[i][fieldPos][1], FieldData[i][fieldPos][2]))
	{
		if (GetPlayerInterior(playerid) == FieldData[i][fieldInterior] && GetPlayerVirtualWorld(playerid) == FieldData[i][fieldWorld])
			return i;
	}
	return -1;
}

Field_IsOwner(playerid, fieldid)
{
	if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_IS_LOGGED_IN) || Character[playerid][ID] == -1)
	    return 0;

    if ((FieldData[fieldid][fieldExists] && FieldData[fieldid][fieldOwner] != 0) && FieldData[fieldid][fieldOwner] == Character[playerid][ID])
		return 1;

	return 0;
}

CMD:createfield(playerid, params[])
{
	new
	    price,
	    id;

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "�س������Ѻ͹حҵ��������觹��");

	if (sscanf(params, "d", price))
	    return SendClientMessage(playerid, -1, "/createfield [price]");

	id = Field_Create(playerid, price);

	if (id == -1)
	    return SendClientMessage(playerid, -1, "�Կ������������ҧ���Թ�Թ�մ�ӡѴ����");

	SendClientMessageEx(playerid, -1, "�س���ҧ���Թ����������ʹ�: %d", id);
	return 1;
}

CMD:destroyfield(playerid, params[])
{
	new
	    id = 0;

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "�س������Ѻ͹حҵ��������觹��");

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, -1, "/destroyfield [field id]");

	if ((id < 0 || id >= MAX_FIELDS) || !FieldData[id][fieldExists])
	    return SendClientMessage(playerid, -1, "�س�к��ʹշ��Թ���١��ͧ");

	Field_Delete(id);
	SendClientMessageEx(playerid, -1, "�س����·��Թ����������ʹ�: %d", id);
	return 1;
}

CMD:editfield(playerid, params[])
{
	new
	    id = 0;

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "�س������Ѻ͹حҵ��������觹��");

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, -1, "/editfield [field id]");

	if ((id < 0 || id >= MAX_FIELDS) || !FieldData[id][fieldExists])
	    return SendClientMessage(playerid, -1, "�س�к��ʹշ��Թ���١��ͧ");

    EditFeild(playerid, id);
	SendClientMessageEx(playerid, -1, "�س��ӡ����䢷���Թ�ʹ�: %d", id);
	return 1;
}

EditFeild(playerid, id)
{
    new string[128];
    new head[128];
    SetPVarInt(playerid, "Fieldid", id);
    format(head, sizeof(head), "���ѧ��䢷��Թ�ʹ�: %s",id);
    format(string, sizeof(string), "��䢵��˹�\n����Ҥ�");
    Dialog_Show(playerid, EditFeildAdmin, DIALOG_STYLE_LIST, head, string, "��ŧ", "¡��ԡ");
    return 1;
}

Dialog:EditFeildAdmin(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new id = GetPVarInt(playerid, "Fieldid");
    if(response)
    {
        if(listitem == 0)
        {
            new
	        Float:x,
	        Float:y,
	        Float:z,
            Float:angle;

            GetPlayerPos(playerid, x, y, z);
            GetPlayerFacingAngle(playerid, angle);
            FieldData[id][fieldPos][0] = x;
            FieldData[id][fieldPos][1] = y;
            FieldData[id][fieldPos][2] = z;
            FieldData[id][fieldPos][3] = angle;

            FieldData[id][fieldInterior] = GetPlayerInterior(playerid);
            FieldData[id][fieldWorld] = GetPlayerVirtualWorld(playerid);

            Field_Refresh(id);
            Field_Save(id);

            SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ��ӡ�����µ��˹觷��Թ�ʹ�: %d", ReturnRealName(playerid, 0), id);
        }
        if(listitem == 1)
        {
            new head[128];
            new string[128];
            format(head, sizeof(head), "���ѧ����Ҥҷ��Թ�ʹ�: %s", id);
            format(string, sizeof(string), "�Ҥҷ��Թ�Ѩ�غѹ: %s\n��͡�ҤҢͧ���Թ:",FormatNumber(FieldData[id][fieldPrice]));
            Dialog_Show(playerid, EditPriceField, DIALOG_STYLE_INPUT, head, string, "��ŧ","��Ѻ");
        }
    }
    return 1;
}

Dialog:ManageField(playerid, response, listitem, inputtext[]){
    if(!response)
        return 1;

    if(response){
        if(listitem == 0){
            Dialog_Show(playerid, CheckField, DIALOG_STYLE_LIST, "�社�鹷��ͧ���Թ", "�Դ����礷��Թ\n�Դ����礷��Թ", "��ŧ","��Ѻ");
        }
        if(listitem == 1){

            new string[128];
            new id = GetPVarInt(playerid, "Fieldid");
            format(string,sizeof(string), "�س���������Т�·��Թ���\n�س�����Ѻ�Թ %s �ҡ�Ҥ����", FormatNumber(FieldData[id][fieldPrice]/2));
            Dialog_Show(playerid, ConfirmSellField, DIALOG_STYLE_MSGBOX, "��·��Թ", string, "���", "¡��ԡ");
        }
    }
    return 1;
}

Dialog:ConfirmSellField(playerid, response, listitem, inputtext[]){
    if(!response)
        return 1;

    new id = GetPVarInt(playerid, "Fieldid");

    if(response){
        if (id != -1 && Field_IsOwner(playerid, id))
        {
            GiveMoney(playerid, FieldData[id][fieldPrice]/2, "Sell Field");
            SendClientMessageEx(playerid, COLOR_GREEN, "[!] {FFFFFF}�س���·��Թ������Ѻ�Թ %s", FormatNumber(FieldData[id][fieldPrice]/2));
            FieldData[id][fieldOwner] = 0;
            Field_Refresh(id);
            Field_Save(id);
        }
    }
    return 1;
}

Dialog:EditPriceField(playerid, response, listitem, inputtext[])
{
    new head[128];
    new string[128];
    new id = GetPVarInt(playerid, "Fieldid");

    if(!response)
    {
        format(head, sizeof(head), "���ѧ��䢷��Թ�ʹ�: %s",id);
        format(string, sizeof(string), "��䢵��˹�\n����Ҥ�");
        Dialog_Show(playerid, EditFeildAdmin, DIALOG_STYLE_LIST, head, string, "��ŧ", "¡��ԡ");
        return 1;
    }
    if(response)
    {
        new amount = strval(inputtext);

        if (isnull(inputtext))
        {
            format(head, sizeof(head), "���ѧ����Ҥҷ��Թ�ʹ�: %s", id);
            format(string, sizeof(string), "!�س���繵�ͧ��͡�ӹǹ�Ҥ�\n�Ҥҷ��Թ�Ѩ�غѹ: %s\n��͡�ҤҢͧ���Թ:",FormatNumber(FieldData[id][fieldPrice]));
            Dialog_Show(playerid, EditPriceField, DIALOG_STYLE_INPUT, head, string, "��ŧ","��Ѻ");
            return 1;
        }
        if (amount < 1)
        {
            format(head, sizeof(head), "���ѧ����Ҥҷ��Թ�ʹ�: %s", id);
            format(string, sizeof(string), "!�س���繵�ͧ��͡�ҡ���� 1\n�Ҥҷ��Թ�Ѩ�غѹ: %s\n��͡�ҤҢͧ���Թ:",FormatNumber(FieldData[id][fieldPrice]));
            Dialog_Show(playerid, EditPriceField, DIALOG_STYLE_INPUT, head, string, "��ŧ","��Ѻ");
            return 1;
        }

        FieldData[id][fieldPrice] = amount;
        Field_Refresh(id);
        Field_Save(id);
        //GiveMoney(playerid, amount, "withdraw house id %d", houseid);

    }
    return 1;
}

Dialog:BuyField(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new id = GetPVarInt(playerid, "Fieldid");

    if(response){
        if(listitem == 0){
            Dialog_Show(playerid, CheckField, DIALOG_STYLE_LIST, "�社�鹷��ͧ���Թ", "�Դ����礷��Թ\n�Դ����礷��Թ", "��ŧ","��Ѻ");
        }
        if(listitem == 1){
            new caption[128];
            new caption2[128];
            format(caption, sizeof(caption), "�س���ѧ���ͺ�ҹ�ʹ�: %d", id);
            format(caption2, sizeof(caption2), "�س������������Ы��ͷ��Թ�����Ҥ� %s\n�ҡ��ͧ��ë�����顴 '����' �ҡ����ͧ��á� '¡��ԡ", FormatNumber(FieldData[id][fieldPrice]));
            Dialog_Show(playerid, BuyField2, DIALOG_STYLE_MSGBOX, caption, caption2, "����","¡��ԡ");
        }
    }
    return 1;
}

Dialog:CheckField(playerid, response, listitem, inputtext[]){
    
    new head[128];
    new id = GetPVarInt(playerid, "Fieldid");
    if(!response)
    {
        format(head, sizeof(head), "���ͷ��Թ�ʹ�: %d", id);
        Dialog_Show(playerid, BuyField, DIALOG_STYLE_LIST, head, "�����Тͧ����Թ\n���ͷ���Թ���", "���͡", "¡��ԡ");
        return 1;
    }
    
    if(response){
        if(listitem == 0){

            if(CheckRadiusField[playerid] != 0)
                return SendClientMessage(playerid, COLOR_RED, "[!] {FFFFFF}�س�Դ�������з��Թ����");

            CheckRadiusField[playerid] = 1;
            SetPlayerCheckpoint(playerid, FieldData[id][fieldPos][0], FieldData[id][fieldPos][1], FieldData[id][fieldPos][2], 30.0);
            SendClientMessage(playerid, COLOR_YELLOW, "[!] �س���Դ��������Тͧ���Թ����");
        }
        if(listitem == 1){
            DisablePlayerCheckpoint(playerid);
            CheckRadiusField[playerid] = 0;
            SendClientMessage(playerid, COLOR_YELLOW, "[!] �س��Դ��������Тͧ���Թ����");
        }
    }
    return 1;
}

Dialog:BuyField2(playerid, response, listitem, inputtext[]){
    if(!response)
        return 1;

    new id = GetPVarInt(playerid, "Fieldid");

    if(response){
        if(GetPlayerMoney(playerid) < FieldData[id][fieldPrice])
            return SendClientMessage(playerid, COLOR_RED, "[!]{FFFFFF} �س���Թ���ͷ��Ы��ͷ��Թ���");

        FieldData[id][fieldOwner] = GetPlayerSQLID(playerid);

        Field_Refresh(id);
		Field_Save(id);
        GiveMoney(playerid, -FieldData[id][fieldPrice], "buy field id %d", id);
	    SendClientMessageEx(playerid, -1, "�س����� ���Թ �Ҥ� %s!", FormatNumber(FieldData[id][fieldPrice]));

		ShowPlayerFooter(playerid, "You have ~g~purchased~w~ a Field!");
	    Log_Write("logs/field_log.txt", "[%s] %s has purchased Field ID: %d for %s.", ReturnDate(), ReturnRealName(playerid), id, FormatNumber(FieldData[id][fieldPrice]));
	}
    return 1;
}