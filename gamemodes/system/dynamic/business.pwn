#include	<YSI_Coding\y_hooks>

enum BUSINESS_DATA {
	businessID,
	businessExists,
	businessName[32],
	businessOwner,
	businessOwnerName[MAX_PLAYER_NAME],
	businessPartner,
	businessPartnerName[MAX_PLAYER_NAME],
	businessType,
	businessTreasury,	//��ѧ�Թ
	businessStorage,	//��ѧ�红ͧ
	businessCapacity,	//�����ؤ�ѧ�红ͧ
	businessPrice,		//�Ҥ��Թ���
	Float:businessOil,
	Float:businessMaxOil,
	Float:businessPosX,
	Float:businessPosY,
	Float:businessPosZ,
	Float:businessIntX,
	Float:businessIntY,
	Float:businessIntZ,
	businessInterior,
	businessWorld,
	businessPickup,
	Text3D:businessText3D,
	businessPickupEx,
	Text3D:businessText3DEx
};
new businessData[MAX_BUSINESS][BUSINESS_DATA];

forward Business_Load();
public Business_Load()
{
    static
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_BUSINESS)
	{
	    businessData[i][businessExists] = true;
    	cache_get_value_name_int(i, "businessID", businessData[i][businessID]);
		cache_get_value_name(i, "businessName", businessData[i][businessName], 32);
	    cache_get_value_name_int(i, "businessOwner", businessData[i][businessOwner]);
		cache_get_value_name(0, "businessOwnerName", businessData[i][businessOwnerName], MAX_PLAYER_NAME);
	    cache_get_value_name_int(i, "businessPartner", businessData[i][businessPartner]);
		cache_get_value_name(0, "businessPartName", businessData[i][businessPartnerName], MAX_PLAYER_NAME);
	    cache_get_value_name_int(i, "businessType", businessData[i][businessType]);
	    cache_get_value_name_int(i, "businessTreasury", businessData[i][businessTreasury]);
	    cache_get_value_name_int(i, "businessStorage", businessData[i][businessStorage]);
	    cache_get_value_name_int(i, "businessCapacity", businessData[i][businessCapacity]);
	    cache_get_value_name_int(i, "businessPrice", businessData[i][businessPrice]);
	    cache_get_value_name_float(i, "businessOil", businessData[i][businessOil]);
	    cache_get_value_name_float(i, "businessMaxOil", businessData[i][businessMaxOil]);
	    cache_get_value_name_float(i, "businessPosX", businessData[i][businessPosX]);
	    cache_get_value_name_float(i, "businessPosY", businessData[i][businessPosY]);
	    cache_get_value_name_float(i, "businessPosZ", businessData[i][businessPosZ]);
	    cache_get_value_name_float(i, "businessIntX", businessData[i][businessIntX]);
	    cache_get_value_name_float(i, "businessIntY", businessData[i][businessIntY]);
	    cache_get_value_name_float(i, "businessIntZ", businessData[i][businessIntZ]);
	    cache_get_value_name_int(i, "businessInterior", businessData[i][businessInterior]);
	    cache_get_value_name_int(i, "businessWorld", businessData[i][businessWorld]);
	    Business_Refresh(i);
	}
	printf("[SERVER]: %d Business were loaded from \"%s\" database...", rows, MYSQL_DATABASE);
	return 1;
}
	
	
	
Business_Save(businessid)
{
	static
	    query[1024];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE `business` SET `businessName` = '%e', `businessOwner` = '%d', `businessOwnerName` = '%e', `businessPartner` = '%d', `businessPartnerName` = '%e' , \
	`businessType` = '%d', `businessTreasury` = '%d', `businessStorage` = '%d', `businessCapacity` = '%d', `businessPrice` = '%d', `businessOil` = '%.2f', `businessMaxOil` = '%.2f', \
	`businessPosX` = '%.4f', `businessPosY` = '%.4f', `businessPosZ` = '%.4f', `businessIntX` = '%.4f', `businessIntY` = '%.4f', `businessIntZ` = '%.4f', \
	`businessInterior` = '%d', `businessWorld` = '%d' WHERE `businessID` = '%d'",
	businessData[businessid][businessName],
	businessData[businessid][businessOwner],
	businessData[businessid][businessOwnerName],
	businessData[businessid][businessPartner],
	businessData[businessid][businessPartnerName],
	businessData[businessid][businessType],
	businessData[businessid][businessTreasury],
	businessData[businessid][businessStorage],
	businessData[businessid][businessCapacity],
	businessData[businessid][businessPrice],
	businessData[businessid][businessOil],
	businessData[businessid][businessMaxOil],
	businessData[businessid][businessPosX],
	businessData[businessid][businessPosY],
	businessData[businessid][businessPosZ],
	businessData[businessid][businessIntX],
	businessData[businessid][businessIntY],
	businessData[businessid][businessIntZ],
	businessData[businessid][businessInterior],
	businessData[businessid][businessWorld],
	businessData[businessid][businessID]
	);
	return mysql_tquery(g_SQL, query);
}















Business_Refresh(businessid)
{
	new string[128];
	if (businessid != -1 && businessData[businessid][businessExists])
	{
		if (IsValidDynamic3DTextLabel(businessData[businessid][businessText3D]))
		    DestroyDynamic3DTextLabel(businessData[businessid][businessText3D]);

		if (IsValidDynamicPickup(businessData[businessid][businessPickup]))
		    DestroyDynamicPickup(businessData[businessid][businessPickup]);

		if (IsValidDynamic3DTextLabel(businessData[businessid][businessText3DEx]))
		    DestroyDynamic3DTextLabel(businessData[businessid][businessText3DEx]);

		if (IsValidDynamicPickup(businessData[businessid][businessPickupEx]))
		    DestroyDynamicPickup(businessData[businessid][businessPickupEx]);

		format(string, sizeof(string), "(id:%d) {FFFFFF}:{FFFF00} [Business]\n{FFFFFF}%s\n{AFAFAF}��Ңͧ: %s\n��������: %s", 
		businessid, businessData[businessid][businessName], businessData[businessid][businessOwnerName], businessData[businessid][businessPartnerName]);
		businessData[businessid][businessText3D] = CreateDynamic3DTextLabel(string, COLOR_ORANGE, businessData[businessid][businessPosX], businessData[businessid][businessPosY], businessData[businessid][businessPosZ], 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, businessData[businessid][businessWorld], businessData[businessid][businessInterior]);
		businessData[businessid][businessPickup] = CreateDynamicPickup(1210, 23, businessData[businessid][businessPosX], businessData[businessid][businessPosY], businessData[businessid][businessPosZ], businessData[businessid][businessWorld], businessData[businessid][businessInterior]);

		if(businessData[businessid][businessType] == 2 || businessData[businessid][businessType] == 3 || //��ҹ���
		businessData[businessid][businessType] == 6 || businessData[businessid][businessType] == 7 || businessData[businessid][businessType] == 8)
		{
			format(string, sizeof(string), "[Business]\n{FFFFFF}%s\n{00FF00}(�Ҥ�: %s)\n{AAAAAA}'�� Y ������ҹ'", 
			businessData[businessid][businessName], FormatMoney(businessData[businessid][businessPrice]));
			businessData[businessid][businessText3DEx] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, businessData[businessid][businessIntX], businessData[businessid][businessIntY], businessData[businessid][businessIntZ], 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, businessData[businessid][businessWorld], businessData[businessid][businessInterior]);
			businessData[businessid][businessPickupEx] = CreateDynamicPickup(1239, 23, businessData[businessid][businessIntX], businessData[businessid][businessIntY], businessData[businessid][businessIntZ], businessData[businessid][businessWorld], businessData[businessid][businessInterior]);
			return 1;
		}
		if(businessData[businessid][businessType] == 9) //��������ѹ
		{
			format(string, sizeof(string), "[Business]{FFFFFF} : {FFFF00}%s\n{00FF00}(�Ҥ�: %s ����Ե�)\n{AFAFAF}�ըӹǹ: %.2f �Ե�\n{AAAAAA}'�� Y ������ҹ'", 
			businessData[businessid][businessName], FormatMoney(businessData[businessid][businessPrice]), businessData[businessid][businessOil]);
			businessData[businessid][businessText3DEx] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, businessData[businessid][businessIntX], businessData[businessid][businessIntY], businessData[businessid][businessIntZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, businessData[businessid][businessWorld], businessData[businessid][businessInterior]);
			businessData[businessid][businessPickupEx] = CreateDynamicPickup(1650, 23, businessData[businessid][businessIntX], businessData[businessid][businessIntY], businessData[businessid][businessIntZ], businessData[businessid][businessWorld], businessData[businessid][businessInterior]);
			return 1;
		}
		if(businessData[businessid][businessType] == 11) //Gunpowder
		{
			format(string, sizeof(string), "(id:%d) {FFFFFF}:{FFA84D} [�ش�Ѻ�Թ�׹]\n{AAAAAA}�� 'Y' �����Ѻ�Թ�׹", businessid);
			businessData[businessid][businessText3D] = CreateDynamic3DTextLabel(string, COLOR_ORANGE, businessData[businessid][businessPosX], businessData[businessid][businessPosY], businessData[businessid][businessPosZ], 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, businessData[businessid][businessWorld], businessData[businessid][businessInterior]);
			businessData[businessid][businessPickup] = CreateDynamicPickup(2057, 23, businessData[businessid][businessPosX], businessData[businessid][businessPosY], businessData[businessid][businessPosZ], businessData[businessid][businessWorld], businessData[businessid][businessInterior]);

			format(string, sizeof(string), "(id:%d) {FFFFFF}:{FFA84D} [�ش�觴Թ�׹]\n{FFFFFF}%s\n{AAAAAA}'�� 'Y' �����觴Թ�׹", businessid);
			businessData[businessid][businessText3DEx] = CreateDynamic3DTextLabel(string, COLOR_ORANGE, businessData[businessid][businessIntX], businessData[businessid][businessIntY], businessData[businessid][businessIntZ], 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, businessData[businessid][businessWorld], businessData[businessid][businessInterior]);
			businessData[businessid][businessPickupEx] = CreateDynamicPickup(2057, 23, businessData[businessid][businessIntX], businessData[businessid][businessIntY], businessData[businessid][businessIntZ], businessData[businessid][businessWorld], businessData[businessid][businessInterior]);
			return 1;
		}
		format(string, sizeof(string), "[Business]\n{FFFFFF}%s\n{AAAAAA}'�� Y ������ҹ", 
		businessData[businessid][businessName]);
		businessData[businessid][businessText3DEx] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, businessData[businessid][businessIntX], businessData[businessid][businessIntY], businessData[businessid][businessIntZ], 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, businessData[businessid][businessWorld], businessData[businessid][businessInterior]);
		businessData[businessid][businessPickupEx] = CreateDynamicPickup(1239, 23, businessData[businessid][businessIntX], businessData[businessid][businessIntY], businessData[businessid][businessIntZ], businessData[businessid][businessWorld], businessData[businessid][businessInterior]);
		
		return 1;
	}
	return 1;
}
Business_Create(playerid, const name[])
{
	static
	    Float:x,
	    Float:y,
	    Float:z,
		None;

    if (GetPlayerPos(playerid, x, y, z))
	{
		for (new i = 0; i != MAX_BUSINESS; i ++)
		{
	    	if (!businessData[i][businessExists])
		    {
    	        businessData[i][businessExists] = true;
				format(businessData[i][businessName], 32, name);
				businessData[i][businessOwner] = -1;
				businessData[i][businessOwnerName] = None;
				businessData[i][businessPartner] = -1;
				businessData[i][businessPartnerName] = None;
				businessData[i][businessType] = 0;
				businessData[i][businessTreasury] = 0;
				businessData[i][businessStorage] = 0;
				businessData[i][businessCapacity] = 25; 
				businessData[i][businessPrice] = 200; 
				businessData[i][businessOil] = 0; 
				businessData[i][businessMaxOil] = 0; 

    	        businessData[i][businessPosX] = x;
    	        businessData[i][businessPosY] = y;
    	        businessData[i][businessPosZ] = z;

                businessData[i][businessIntX] = x;
                businessData[i][businessIntY] = y;
                businessData[i][businessIntZ] = z + 10000;

				businessData[i][businessInterior] = GetPlayerInterior(playerid);
				businessData[i][businessWorld] = GetPlayerVirtualWorld(playerid);
				Business_Refresh(i);
				mysql_tquery(g_SQL, "INSERT INTO `business` (`businessType`) VALUES(0)", "OnBusinessCreated", "d", i);
				return i;
			}
		}
	}
	return -1;
}
Business_Delete(businessid)
{
	if (businessid != -1 && businessData[businessid][businessExists])
	{
	    new
	        string[64];

		format(string, sizeof(string), "DELETE FROM `business` WHERE `businessid` = '%d'", businessData[businessid][businessID]);
		mysql_tquery(g_SQL, string);

        if (IsValidDynamic3DTextLabel(businessData[businessid][businessText3D]))
		    DestroyDynamic3DTextLabel(businessData[businessid][businessText3D]);

		if (IsValidDynamicPickup(businessData[businessid][businessPickup]))
		    DestroyDynamicPickup(businessData[businessid][businessPickup]);

        if (IsValidDynamic3DTextLabel(businessData[businessid][businessText3DEx]))
		    DestroyDynamic3DTextLabel(businessData[businessid][businessText3DEx]);

		if (IsValidDynamicPickup(businessData[businessid][businessPickupEx]))
		    DestroyDynamicPickup(businessData[businessid][businessPickupEx]);

	    businessData[businessid][businessExists] = false;
		businessData[businessid][businessType] = 0;
	    businessData[businessid][businessID] = 0;
	}
	return 1;
}

forward OnBusinessCreated(businessid);
public OnBusinessCreated(businessid)
{
	if (businessid == -1 || !businessData[businessid][businessExists])
	    return 0;

	businessData[businessid][businessID] = cache_insert_id();
	//businessData[businessid][businessWorld] = businessData[businessid][businessID] + 7000;
	Business_Save(businessid);

	return 1;
}
Business_Nearest(playerid)
{
    for (new i = 0; i != MAX_BUSINESS; i ++) if (businessData[i][businessExists] && IsPlayerInRangeOfPoint(playerid, 2.5, businessData[i][businessIntX], businessData[i][businessIntY], businessData[i][businessIntZ]))
	{
		if (GetPlayerInterior(playerid) == businessData[i][businessInterior] && GetPlayerVirtualWorld(playerid) == businessData[i][businessWorld])
			return i;
	}
	return -1;
}
Business_Nearest_Owner(playerid)
{
    for (new i = 0; i != MAX_BUSINESS; i ++) if (businessData[i][businessExists] && IsPlayerInRangeOfPoint(playerid, 2.5, businessData[i][businessPosX], businessData[i][businessPosY], businessData[i][businessPosZ]))
	{
		if (GetPlayerInterior(playerid) == businessData[i][businessInterior] && GetPlayerVirtualWorld(playerid) == businessData[i][businessWorld])
			return i;
	}
	return -1;
}
IsBusinessOwner(playerid, businessid)
{
	return (businessData[businessid][businessOwner] == playerData[playerid][pID]) || (businessData[businessid][businessPartner] == playerData[playerid][pID]) && (businessData[businessid][businessID] != -1);
}
IsBusinessOwnerOnly(playerid, businessid)
{
	return (businessData[businessid][businessOwner] == playerData[playerid][pID]) && (businessData[businessid][businessID] != -1);
}





/* -------------------------------------------------- System -------------------------------------------------- */







CMD:Createbusiness(playerid, params[])
{
    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (isnull(params) || strlen(params) > 32)
	    return SendClientMessage(playerid, COLOR_WHITE, "/Createbusiness [���͸�áԨ]");

	new id = Business_Create(playerid, params);

	if (id == -1)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �����آͧ��ïԨ����������");

	SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}Create Business{FFFFFF}(%d): %s ", GetPlayerNameEx(playerid), id, params);
	return 1;
}
CMD:Removebusiness(playerid, params[])
{
	static
	    id = 0;

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, COLOR_WHITE, "/Removebusiness [�ʹ�]");

	if ((id < 0 || id >= MAX_BUSINESS) || !businessData[id][businessExists])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����վ���áԨ㹰ҹ������");

	Business_Delete(id);
	SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}Remove Business{FFFFFF}(%d): %s ", GetPlayerNameEx(playerid), id, params);
	return 1;
}
CMD:editbusiness(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendClientMessage(playerid, COLOR_WHITE, "/editbusiness [�ʹո�áԨ] [������¡��]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[������¡��]:{FFFFFF} Name, Type, Location, Service, Owner, Partner, Capacity, Virtual, Price, Storage, Oil, MaxOil");
		return 1;
	}
	if ((id < 0 || id >= MAX_BUSINESS) || !businessData[id][businessExists])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ��辺�ʹ� Business �������㹰ҹ������");

	if (!strcmp(type, "name", true))
	{
	    new name[32];

	    if (sscanf(string, "s[32]", name))
	        return SendClientMessage(playerid, COLOR_WHITE, "/editbusiness [�ʹո�áԨ] [������¡��] [���͸�áԨ]");

	    format(businessData[id][businessName], 32, name);
	    Business_Refresh(id);
	    Business_Save(id);

		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}ChangeName Business{FFFFFF}(%d): %s ", GetPlayerNameEx(playerid), id, name);
	}
	else if (!strcmp(type, "Owner", true))
	{
		static
			userid;

	    if (sscanf(string, "u", userid))
	        return SendClientMessage(playerid, COLOR_WHITE, "/editbusiness [�ʹո�áԨ] [������¡��] [�ʹռ�����]");

		if (userid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ��������������");

		if ((id < -1 || id >= MAX_BUSINESS) || (id != -1 && !businessData[id][businessExists]))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ��辺�ʹ� Business �������㹰ҹ������");

		new query[128];

		GetPlayerName(userid,  businessData[id][businessOwnerName], MAX_PLAYER_NAME);
		businessData[id][businessOwner] = playerData[userid][pID];
	    mysql_format(g_SQL, query, sizeof(query), "UPDATE business SET businessOwner = %d, businessOwnerName = '%e' WHERE businessID = %d", businessData[id][businessOwner], businessData[id][businessOwnerName], businessData[id][businessID]);
	    mysql_tquery(g_SQL, query);

		Business_Refresh(id);
	    Business_Save(id);
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}ChangeOwner Business{FFFFFF}(%d): %s", GetPlayerNameEx(playerid), id, GetPlayerNameEx(userid));
	}
	else if (!strcmp(type, "Partner", true))
	{
		static
			userid;

	    if (sscanf(string, "u", userid))
	        return SendClientMessage(playerid, COLOR_WHITE, "/editbusiness [�ʹո�áԨ] [������¡��] [�ʹռ�����]");

		if (userid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ��������������");

		if ((id < -1 || id >= MAX_BUSINESS) || (id != -1 && !businessData[id][businessExists]))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ��辺�ʹ� Business �������㹰ҹ������");

		new query[128];

		GetPlayerName(userid,  businessData[id][businessPartnerName], MAX_PLAYER_NAME);
		businessData[id][businessPartner] = playerData[userid][pID];
	    mysql_format(g_SQL, query, sizeof(query), "UPDATE business SET businessPartner = %d, businessPartnerName = '%e' WHERE businessID = %d", businessData[id][businessPartner], businessData[id][businessPartnerName], businessData[id][businessID]);
	    mysql_tquery(g_SQL, query);

		Business_Refresh(id);
	    Business_Save(id);
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}ChangePartner Business{FFFFFF}(%d): %s", GetPlayerNameEx(playerid), id, GetPlayerNameEx(userid));
	}
	else if (!strcmp(type, "location", true))
	{
	    GetPlayerPos(playerid, businessData[id][businessPosX], businessData[id][businessPosY], businessData[id][businessPosZ]);
	    Business_Refresh(id);
	    Business_Save(id);

		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}ChangeLocation Business{FFFFFF}(%d)", GetPlayerNameEx(playerid), id);
	}
	else if (!strcmp(type, "service", true))
	{
	    GetPlayerPos(playerid, businessData[id][businessIntX], businessData[id][businessIntY], businessData[id][businessIntZ]);
	    Business_Refresh(id);
	    Business_Save(id);

		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}ChangeService Business{FFFFFF}(%d)", GetPlayerNameEx(playerid), id);
	}
	else if (!strcmp(type, "type", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
	    {
	        SendClientMessage(playerid, COLOR_WHITE, "/editbusiness [�ʹո�áԨ] [������¡��] [�ٻẺ����ͧ���]");
			SendClientMessage(playerid, COLOR_YELLOW, "[�ٻẺ����ͧ���]:{FFFFFF} 1: Skin | 2: Burger | 3: Pizza | 4: Soda | 5: 24/7 | 6: Taco");
			SendClientMessage(playerid, COLOR_YELLOW, "[�ٻẺ����ͧ���]:{FFFFFF} 7: Soda | 8: Beer | 9: Gas | 10: Bank | 11: Gunpowder");
			return 1;
		}
		if (typeint < 1 || typeint > 11)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- �ٻẺ�ͧ Business ��鹵�ͧ����ӡ��� 1 �������Թ 6");

		if ((id < -1 || id >= MAX_BUSINESS) || (id != -1 && !businessData[id][businessExists]))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ��辺�ʹ� Business �������㹰ҹ������");

		businessData[id][businessType] = typeint;
	    Business_Refresh(id);
	    Business_Save(id);
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}ChangeType Business{FFFFFF}(%d): Type(%d)", GetPlayerNameEx(playerid), id, typeint);
	}
	else if (!strcmp(type, "Capacity", true))
	{
	    new Capacity;

	    if (sscanf(string, "d", Capacity))
	    	return SendClientMessage(playerid, COLOR_WHITE, "/editbusiness [�ʹո�áԨ] [������¡��] [�����ؤ�ѧ]");

		if (Capacity < 25 || Capacity > 10000)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- �����آͧ Capacity ��鹵�ͧ����ӡ��� 25 �������Թ 10,000");

		if ((id < -1 || id >= MAX_BUSINESS) || (id != -1 && !businessData[id][businessExists]))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ��辺�ʹ� Business �������㹰ҹ������");

	    businessData[id][businessCapacity] = Capacity;
		Business_Refresh(id);
		Business_Save(id);
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}ChangeCapacity Business{FFFFFF}(%d): %d", GetPlayerNameEx(playerid), Capacity);
	}
	else if (!strcmp(type, "Storage", true))
	{
	    new Storage;

	    if (sscanf(string, "d", Storage))
	    	return SendClientMessage(playerid, COLOR_WHITE, "/editbusiness [�ʹո�áԨ] [������¡��] [�ӹǹ�Թ���]");

		if (Storage < 0 || Storage > 10000)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- �����آͧ Storage ��鹵�ͧ����ӡ��� 0 �������Թ 10,000");

		if ((id < -1 || id >= MAX_BUSINESS) || (id != -1 && !businessData[id][businessExists]))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ��辺�ʹ� Business �������㹰ҹ������");

	    businessData[id][businessStorage] = Storage;
		Business_Refresh(id);
		Business_Save(id);
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}ChangeStorage Business{FFFFFF}: %d", GetPlayerNameEx(playerid), Storage);
	}
	else if (!strcmp(type, "Price", true))
	{
	    new Price;

	    if (sscanf(string, "d", Price))
	    	return SendClientMessage(playerid, COLOR_WHITE, "/editbusiness [�ʹո�áԨ] [������¡��] [�Ҥ��Թ���]");

		if (Price < 0)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- �Ҥ��Թ��ҹ�鹵�ͧ����ӡ��� 0");

		if ((id < -1 || id >= MAX_BUSINESS) || (id != -1 && !businessData[id][businessExists]))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ��辺�ʹ� Business �������㹰ҹ������");

	    businessData[id][businessPrice] = Price;
		Business_Refresh(id);
		Business_Save(id);
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}ChangePrice Business{FFFFFF}: %d", GetPlayerNameEx(playerid), FormatMoney(Price));
	}
	else if (!strcmp(type, "Oil", true))
	{
		new Oil;

	    if (sscanf(string, "d", Oil))
	    	return SendClientMessage(playerid, COLOR_WHITE, "/editbusiness [�ʹո�áԨ] [������¡��] [�ӹǹ����ѹ]");

		if (Oil < 0)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- �ӹǹ��鹵�ͧ����ӡ��� 0");

		if ((id < -1 || id >= MAX_BUSINESS) || (id != -1 && !businessData[id][businessExists]))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ��辺�ʹ� Business �������㹰ҹ������");

	    businessData[id][businessOil] = Oil;
		Business_Refresh(id);
		Business_Save(id);
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}ChangeOil Business{FFFFFF}: %d", GetPlayerNameEx(playerid), Oil);
		return 1;
	}
	else if (!strcmp(type, "MaxOil", true))
	{
		new MaxOil;

	    if (sscanf(string, "d", MaxOil))
	    	return SendClientMessage(playerid, COLOR_WHITE, "/editbusiness [�ʹո�áԨ] [������¡��] [�ӹǹ�����ع���ѹ]");

		if (MaxOil < 0)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- �ӹǹ��鹵�ͧ����ӡ��� 0");

		if ((id < -1 || id >= MAX_BUSINESS) || (id != -1 && !businessData[id][businessExists]))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ��辺�ʹ� Business �������㹰ҹ������");

	    businessData[id][businessMaxOil] = MaxOil;
		Business_Refresh(id);
		Business_Save(id);
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}ChangeMaxOil Business{FFFFFF}: %d", GetPlayerNameEx(playerid), MaxOil);
		return 1;
	}
	return 1;
}

Dialog:Business_Owner(playerid, response, listitem, inputtext[])
{
	new id = playerData[playerid][pBusinessID];
	if (response)
	{
		switch(listitem)
		{
			case 0: //Owner
			{
				if(!IsBusinessOwnerOnly(playerid, id))
					return 1;

				SendClientMessage(playerid, COLOR_LIGHTRED, "- ��سҵԴ��ͼ��Ѳ�Ңͧ������������ͷӡ������¹");
			}
			case 1: //Partner
			{
				if(!IsBusinessOwnerOnly(playerid, id))
					return 1;

				Dialog_Show(playerid, Edit_Partner, DIALOG_STYLE_INPUT, "[Edit] Partner", "{FFFFFF}�ô�к��ʹռ����蹷��س��ͧ��è�����繾�������", "��ŧ", "¡��ԡ");
			}
			case 2: // �Ҥ��Թ���
			{
				Dialog_Show(playerid, Edit_Price, DIALOG_STYLE_INPUT, "[Edit] Price", "{FFFFFF}�ô�к��ҤҢͧ�Թ��ҷ��س��ͧ��èл�Ѻ����¹", "��ŧ", "¡��ԡ");
			}
			case 4: //��ѧ
			{

				Dialog_Show(playerid, Edit_Treasury, DIALOG_STYLE_LIST, "[Edit] Treasury", "{FFFFFF}�ҡ�Թ��Ҥ�ѧ\n�͹�Թ�͡�ҡ��ѧ", "���͡", "¡��ԡ");
			}
		}
	}
	return 1;
}
Dialog:Business_Owner_Gas(playerid, response, listitem, inputtext[])
{
	new id = playerData[playerid][pBusinessID];
	if (response)
	{
		switch(listitem)
		{
			case 0: //Owner
			{
				if(!IsBusinessOwnerOnly(playerid, id))
					return 1;

				SendClientMessage(playerid, COLOR_LIGHTRED, "- ��سҵԴ��ͼ��Ѳ�Ңͧ������������ͷӡ������¹");
			}
			case 1: //Partner
			{
				if(!IsBusinessOwnerOnly(playerid, id))
					return 1;

				Dialog_Show(playerid, Edit_Partner, DIALOG_STYLE_INPUT, "[Edit] Partner", "{FFFFFF}�ô�к��ʹռ����蹷��س��ͧ��è�����繾�������", "��ŧ", "¡��ԡ");
			}
			case 2: // �Ҥҹ���ѹ
			{
				Dialog_Show(playerid, Edit_Price_Gas, DIALOG_STYLE_INPUT, "[Edit] Price", "{FFFFFF}�ô�к��Ҥҹ���ѹ���س��ͧ��èл�Ѻ����¹", "��ŧ", "¡��ԡ");
			}
			case 4: //��ѧ
			{

				Dialog_Show(playerid, Edit_Treasury, DIALOG_STYLE_LIST, "[Edit] Treasury", "{FFFFFF}�ҡ�Թ��Ҥ�ѧ\n�͹�Թ�͡�ҡ��ѧ", "���͡", "¡��ԡ");
			}
		}
	}
	return 1;
}






























new bool:StartGunpowder[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
	StartGunpowder[playerid] = false;
	return 1;
}


/* ---------------------------------------- Business Starting ---------------------------------------- */
new bool:GetplayerFood[MAX_PLAYERS];
new bool:GetplayerFuel[MAX_PLAYERS];

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_YES && IsPlayerInAnyVehicle(playerid))
	{
		static
			id = -1;
		if ((id = Business_Nearest(playerid)) != -1)
	    {
			//new price = businessData[id][businessPrice];
			if (businessData[id][businessType] == 9) //Gas
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				new modelid = GetVehicleModel(vehicleid);
				new Float:maxfuel = vehicleData[modelid - 400][vFuel];

				new Float:fuel = vehicleData[modelid - 400][vFuel] - vehicleFuel[vehicleid];
				new Float:valuefloat = fuel*businessData[id][businessPrice];
				new value = floatround(valuefloat);

				if(GetplayerFuel[playerid] == true)
					return 1;

				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
					return 1;

				if(GetEngineStatus(vehicleid))
					return Dialog_Show(playerid, Fuel_ErorrEngine, DIALOG_STYLE_MSGBOX, "Fuel Erorr", "{FF6347}���������ö�������ѹ��\n\
					*���ͧ�ҡ�س���繵�ͧ�Ѻ����ͧ¹�� �ҹ��˹Тͧ�س��͹", "�Դ", "");

				if (GetPlayerMoneyEx(playerid) < value)
					return Dialog_Show(playerid, Fuel_ErorrMoney, DIALOG_STYLE_MSGBOX, "Fuel Erorr", "{FF6347}���������ö�������ѹ��\n\
					*���ͧ�ҡ�س �ըӹǹ�Թ�����§�� (( %s/%s ))", "�Դ", "", FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(value));

				if (vehicleFuel[vehicleid] >= maxfuel)
					return Dialog_Show(playerid, Fuel_ErorrMax, DIALOG_STYLE_MSGBOX, "Fuel Erorr", "{FF6347}���������ö�������ѹ��\n\
					*���ͧ�ҡ�ҹ��˹Тͧ�س �չ���ѹ��§������ (( %.2f/%.2f ))", "�Դ", "", vehicleFuel[vehicleid], maxfuel);
					
				if(businessData[id][businessOil] < fuel)
					return Dialog_Show(playerid, Fuel_ErorrMax, DIALOG_STYLE_MSGBOX, "Fuel Erorr", "{FF6347}���������ö�������ѹ��\n\
					*���ͧ�ҡ��ѧ����ѹ���㹸�áԨ��� ����������§��", "�Դ", "");

				GetplayerFuel[playerid] = true;
				TogglePlayerControllable(playerid, false);
				GameTextForPlayer(playerid, "~w~Wait ~y~Fueling...", 1000, 1) ;
				SetTimerEx("Wait_Fueling", 6500, 0, "i", playerid);
				PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);

				vehicleFuel[vehicleid] += fuel;
				businessData[id][businessOil] -= fuel;

				GivePlayerMoneyEx(playerid, -value);
				businessData[id][businessTreasury] += value;

				TogglePlayerControllable(playerid, true);
				Business_Refresh(id);

				Dialog_Show(playerid, Fuel_Success, DIALOG_STYLE_MSGBOX, "����稹���ѹ", "{FFFFFF}���͸�áԨ: %s\n\
				���ͼ�����ԡ��: %s\n\
				���ҹ��˹�: %s\n\
				�ӹǹ����ѹ������: %.1f\n\
				������Դ���Ҥ�: {00FF00}%s\n\
				{FFFFFF}����(Tex): -", "�Դ", "", businessData[id][businessName], GetPlayerNameEx(playerid), ReturnVehicleName(vehicleid), 
				fuel, FormatMoney(value));
				return 1;
			}
		}
		return 1;
	}
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
		static
			id = -1;
		new 
			tmp2[127];
		
		if ((id = Business_Nearest_Owner(playerid)) != -1)
		{
			if(IsBusinessOwner(playerid, id))
			{
				if(businessData[id][businessType] == 9) // ����ѹ
				{
					Dialog_Show(playerid, Business_Owner_Gas, DIALOG_STYLE_TABLIST, "�Ѵ��ø�áԨ", "Owner: %s\t[���]\n\
					Partner: %s\t[���]\n\
					�Ҥҹ���ѹ: %s ����Ե�\t[���]\n\
					�����ع���ѹ: %.2f/%.2f\n\
					{00FF00}��ѧ�Թ: %s\t[���]\
					", "���͡", "�Դ", businessData[id][businessOwnerName], businessData[id][businessPartnerName], 
					FormatMoney(businessData[id][businessPrice]),  businessData[id][businessOil], businessData[id][businessMaxOil], 
					FormatMoney(businessData[id][businessTreasury]));
					playerData[playerid][pBusinessID] = id;
					return 1;
				}
				if(businessData[id][businessType] == 10) // ��Ҥ��
				{
					Dialog_Show(playerid, Business_Owner_Bank, DIALOG_STYLE_TABLIST, "�Ѵ��ø�áԨ", "Owner: %s\t[���]\n\
					Partner: %s\t[���]\n\
					����: %s \t[���]\n\
					{00FF00}��ѧ�Թ: %s\t[���]\
					", "���͡", "�Դ", businessData[id][businessOwnerName], businessData[id][businessPartnerName], FormatMoney(businessData[id][businessPrice]), FormatMoney(businessData[id][businessTreasury]));
					playerData[playerid][pBusinessID] = id;
					return 1;
				}
				Dialog_Show(playerid, Business_Owner, DIALOG_STYLE_TABLIST, "�Ѵ��ø�áԨ", "Owner: %s\t[���]\n\
				Partner: %s\t[���]\n\
				�Ҥ��Թ���: %s\t[���]\n\
				��ѧ�Թ���: %d/%d\n\
				{00FF00}��ѧ�Թ: %s\t[���]\
				", "���͡", "�Դ", businessData[id][businessOwnerName], businessData[id][businessPartnerName], FormatMoney(businessData[id][businessPrice]),  businessData[id][businessStorage], businessData[id][businessCapacity], FormatMoney(businessData[id][businessTreasury]));
				
				playerData[playerid][pBusinessID] = id;
				return 1;
			}
			if (businessData[id][businessType] == 11) //Gunpowder
			{
				if (playerData[playerid][pHours] < 10)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö������  ���ͧ�ҡ�س��ͧ�ժ�������͹�Ź��ҡ���� 10 �������");

				if(GetPlayerMoney(playerid) < 500)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "- �������ö������ ���ͧ�ҡ�س���Թ�����§��㹡��������ҹ���Թ�׹ (( %d/500 ))", GetPlayerMoneyEx(playerid));
				
				GivePlayerMoneyEx(playerid, -500);
				StartGunpowder[playerid] = true;
				SetPlayerCheckpoint(playerid, businessData[id][businessIntX], businessData[id][businessIntY], businessData[id][businessIntZ], 2.5);
				SendClientMessageEx(playerid, COLOR_YELLOW, "[��Ҵ�״] �س���Ѻ�Թ�����Ǩӹǹ '1' �ا, ���ѹ��������š�繴Թ�׹");
				SendClientMessage(playerid, COLOR_LIGHTRED, "(( �ҡ�س '�͡��' ���� '��ش��' �ҹ���س������ж١¡��ԡ, ��Фس��ͧ��Ѻ���������� ))");
				SetPlayerAttachedObject(playerid,9,1575,1,0.035000,-0.204999,-0.019000,-88.399887,0.000000,-2.000000,1.000000,1.000000,1.000000);
				return 1;
			}
		}
		if ((id = Business_Nearest(playerid)) != -1)
	    {
			new price = businessData[id][businessPrice];

			if (businessData[id][businessType] == 1) //Skin Shop
				return SkinShopForPlayer(playerid);
				
			if (businessData[id][businessType] == 10) //Bank
				return CreatePlayerATM(playerid);
	
			if (businessData[id][businessType] == 11) //Gunpowder
			{
				if(StartGunpowder[playerid] == true)
				{
					new itemname[24];
					itemname = "GunPowder";
					new 
						amount = randomEx(1 ,3),
						count = Inventory_Count(playerid, itemname);

					if (count >= playerData[playerid][pItemAmount])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", itemname);

					new gid = Inventory_Add(playerid, itemname, amount);

					if (gid == -1)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

					GivePlayerExpcraft(playerid, 1);
					SendClientMessageEx(playerid, COLOR_GREEN, "[��Ҵ�״] �س���Ѻ�Թ�׹�ҡ����� �ӹǹ '%d' ����", amount);
					SendClientMessageEx(playerid, COLOR_YELLOW, "(( �����ӹҭ㹡�ä�ҿ���ظ: %d | %s ))", GetPlayerLevelCraft(playerid), LevelCraftRank_GetName(playerid));
					RemovePlayerAttachedObject(playerid, 9);
					DisablePlayerCheckpoint(playerid);
				}
				return 1;
			}

	
/* ------------------------------------------------------------ ��ѧ ���Թ��� ------------------------------------------------------------ */

	        if (businessData[id][businessStorage] <= 0)
	            return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö���Թ����� ���ͧ�ҡ��ѧ�Թ������㹸�áԨ������");
			
			if (businessData[id][businessType] == 2) //Burger Shop
			{
				if(businessData[id][businessStorage] <= 0)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö������ ���ͧ�ҡ�Թ������");
				

				if(price > GetPlayerMoney(playerid))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö������ ���ͧ�ҡ�ӹǹ�Թ�ͧ�س��������§��");

				if(GetplayerFood[playerid] == true)
					return 1;

				GetplayerFood[playerid] = true;
				businessData[id][businessStorage] -= 1;
				businessData[id][businessTreasury] += price;
				GivePlayerMoneyEx(playerid, -price);
				Business_Save(id);

				format(tmp2, sizeof(tmp2), "~r~-%d", price);
				GameTextForPlayer(playerid, tmp2, 3000, 1);

				SetTimerEx("RemoveObjectBurger", 5000, 0, "id", playerid);

				ClearAnimations(playerid);
				ApplyAnimation(playerid, "Food","Eat_pizza", 4.1, 1, 0, 0, 0, 0, 1);
				ApplyAnimation(playerid, "Food","Eat_pizza", 4.1, 1, 0, 0, 0, 0, 1);
				SetPlayerAttachedObject(playerid,7,2880,6,-0.001000,-0.006000,-0.030999,14.199995,0.300005,5.000000,1.000000,1.000000,1.000000);
				

				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s �����Թ���� 'Burger' ��Ҥ� %s �����Ժ������Ѻ��зҹ", GetPlayerNameEx(playerid), FormatMoney(price));
				return 1;
			}
			if (businessData[id][businessType] == 8) //Beer Shop
			{
				if(businessData[id][businessStorage] <= 0)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö������ ���ͧ�ҡ�Թ������");
				
				if(price > GetPlayerMoney(playerid))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö������ ���ͧ�ҡ�ӹǹ�Թ�ͧ�س��������§��");

				if(GetplayerFood[playerid] == true)
					return 1;

				GetplayerFood[playerid] = true;
				businessData[id][businessStorage] -= 1;
				businessData[id][businessTreasury] += price;
				GivePlayerMoneyEx(playerid, -price);
				Business_Save(id);

				format(tmp2, sizeof(tmp2), "~r~-%d", price);
				GameTextForPlayer(playerid, tmp2, 3000, 1);

				SetTimerEx("RemoveObjectBeer", 5000, 0, "id", playerid);

				ClearAnimations(playerid);
				ApplyAnimation(playerid, "VENDING","VEND_Drink2_P", 4.1, 1, 0, 0, 0, 0, 1);
				ApplyAnimation(playerid, "VENDING","null", 4.1, 0, 1, 0, 0, 0, 1);
				ApplyAnimation(playerid, "VENDING","VEND_Drink2_P", 4.1, 1, 0, 0, 0, 0, 0);
				PlayerPlaySoundEx(playerid, 32200);
				SetPlayerAttachedObject(playerid,7,2647,5,0.093999,0.044999,-0.035999,-14.799992,-173.599975,0.000000,0.623000,0.625999,0.514000);
				
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s �����Թ���� 'Beer' ��Ҥ� %s �����Ժ����Ҵ���", GetPlayerNameEx(playerid), FormatMoney(price));
			}

		}

	}
	return 1;
}

forward Wait_Fueling(playerid, value, id, fuel);
public Wait_Fueling(playerid, value, id, fuel)
{
	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	GetplayerFuel[playerid] = false;
	return 1;
}
forward RemoveObjectBurger(playerid, type);
public RemoveObjectBurger(playerid, type)
{
	playerData[playerid][pHungry] += 50;
	ClearAnimations(playerid);
	GetplayerFood[playerid] = false;
	TogglePlayerControllable(playerid, true);
	RemovePlayerAttachedObject(playerid, 7);
}
forward RemoveObjectBeer(playerid, type);
public RemoveObjectBeer(playerid, type)
{
	playerData[playerid][pThirsty] += 50;
	playerData[playerid][pHungry] += 5;
	GivePlayerStamina(playerid, 200);
	ClearAnimations(playerid);
	GetplayerFood[playerid] = false;
	TogglePlayerControllable(playerid, true);
	RemovePlayerAttachedObject(playerid, 7);
}
Dialog:Edit_Partner(playerid, response, listitem, inputtext[])
{
	new userid, id = playerData[playerid][pBusinessID];
	if (response)
	{
		if(sscanf(inputtext, "u", userid))
			return Dialog_Show(playerid, Edit_Partner, DIALOG_STYLE_TABLIST, "[Edit] Partner", "{FFFFFF}�ô�к��ʹռ����蹷��س��ͧ��è�����繾�������", "��ŧ", "¡��ԡ");

		if (!IsPlayerNearPlayer(playerid, userid, 5.0))
			return Dialog_Show(playerid, Edit_Partner, DIALOG_STYLE_TABLIST, "[Edit] Partner", "{FFFFFF}�ô�к��ʹռ����蹷��س��ͧ��è�����繾�������\n\
			{FF6347}*��辺�������ʹմѧ������������س", "��ŧ", "¡��ԡ");

		if(userid == playerid)
			return Dialog_Show(playerid, Edit_Partner, DIALOG_STYLE_TABLIST, "[Edit] Partner", "{FFFFFF}�ô�к��ʹռ����蹷��س��ͧ��è�����繾�������\n\
			{FF6347}*�س�������ö���������ͧ�� Partner ��", "��ŧ", "¡��ԡ");
		
		new query[128];

		//SendClientMessageEx(playerid, COLOR_GREEN, "- �س������� %s �� Partner �ͧ��áԨ '%s' ���º����", GetPlayerNameEx(userid), businessData[id][businessName]);
		SendClientMessageEx(playerid,COLOR_YELLOW,"[Business] �س������� %s �� Partner ��áԨ %s ���º��������", GetPlayerNameEx(userid), businessData[id][businessName]);
		SendClientMessageEx(userid,COLOR_YELLOW,"[Business] %s �������س�� Partner ��áԨ %s ���º��������", GetPlayerNameEx(playerid), businessData[id][businessName]);

		GetPlayerName(userid,  businessData[id][businessPartnerName], MAX_PLAYER_NAME);
		businessData[id][businessPartner] = playerData[userid][pID];
	    mysql_format(g_SQL, query, sizeof(query), "UPDATE business SET businessPartner = %d, businessPartnerName = '%e' WHERE businessID = %d", businessData[id][businessPartner], businessData[id][businessPartnerName], businessData[id][businessID]);
	    mysql_tquery(g_SQL, query);

		Business_Refresh(id);
	    Business_Save(id);

		/*Dialog_Show(playerid, Business_Owner, DIALOG_STYLE_TABLIST, "�Ѵ��ø�áԨ", "Owner: %s\t[���]\n\
		Partner: %s\t[���]\n\
		�Ҥ��Թ���: %s\t[���]\n\
		��ѧ�Թ���: %d/%d\n\
		{00FF00}��ѧ�Թ: %s\t[���]\
		", "���͡", "�Դ", businessData[id][businessOwnerName], businessData[id][businessPartnerName], FormatMoney(businessData[id][businessPrice]),  businessData[id][businessStorage], businessData[id][businessCapacity], FormatMoney(businessData[id][businessTreasury]));
		*/
	}
	return 1;
}
Dialog:Edit_Price(playerid, response, listitem, inputtext[])
{
	new Price, id = playerData[playerid][pBusinessID];
	if (response)
	{
		if(sscanf(inputtext, "d", Price))
			return Dialog_Show(playerid, Edit_Price, DIALOG_STYLE_INPUT, "[Edit] Price", "{FFFFFF}�ô�к��ҤҢͧ�Թ��ҷ��س��ͧ��èл�Ѻ����¹", "��ŧ", "¡��ԡ");

		if (Price < 200 || Price > 1000000)
			return Dialog_Show(playerid, Edit_Price, DIALOG_STYLE_INPUT, "[Edit] Price", "{FFFFFF}�ô�к��ҤҢͧ�Թ��ҷ��س��ͧ��èл�Ѻ����¹\n\
			{FF6347}*�ҤҢͧ�Թ��ҹ�鹵�ͧ����ӡ��� $200", "��ŧ", "¡��ԡ");


		//SendClientMessageEx(playerid, COLOR_GREEN, "- �س���Ѻ�Ҥ��Թ��Ңͧ��áԨ�繨ӹǹ '%s' ���º����", FormatMoney(Price));
		Dialog_Show(playerid, Business_Owner, DIALOG_STYLE_TABLIST, "�Ѵ��ø�áԨ", "Owner: %s\t[���]\n\
		Partner: %s\t[���]\n\
		�Ҥ��Թ���: %s\t[���]\n\
		��ѧ�Թ���: %d/%d\n\
		{00FF00}��ѧ�Թ: %s\t[���]\
		", "���͡", "�Դ", businessData[id][businessOwnerName], businessData[id][businessPartnerName], FormatMoney(businessData[id][businessPrice]),  businessData[id][businessStorage], businessData[id][businessCapacity], FormatMoney(businessData[id][businessTreasury]));
		
	    businessData[id][businessPrice] = Price;
		Business_Refresh(id);
	    Business_Save(id);
	}
	return 1;
}
Dialog:Edit_Price_Gas(playerid, response, listitem, inputtext[])
{
	new Price, id = playerData[playerid][pBusinessID];
	if (response)
	{
		if(sscanf(inputtext, "d", Price))
			return Dialog_Show(playerid, Edit_Price_Gas, DIALOG_STYLE_INPUT, "[Edit] Price", "{FFFFFF}�ô�к��Ҥҹ���ѹ���س��ͧ��èл�Ѻ����¹", "��ŧ", "¡��ԡ");

		if (Price < 1 || Price > 1000000)
			return Dialog_Show(playerid, Edit_Price_Gas, DIALOG_STYLE_INPUT, "[Edit] Price", "{FFFFFF}�ô�к��ҤҢͧ�Թ��ҷ��س��ͧ��èл�Ѻ����¹\n\
			{FF6347}*�ҤҢͧ�Թ��ҹ�鹵�ͧ����ӡ��� $1", "��ŧ", "¡��ԡ");

	    businessData[id][businessPrice] = Price;

		//SendClientMessageEx(playerid, COLOR_GREEN, "- �س���Ѻ�Ҥ��Թ��Ңͧ��áԨ�繨ӹǹ '%s' ���º����", FormatMoney(Price));

		Business_Refresh(id);
	    Business_Save(id);

		Dialog_Show(playerid, Business_Owner_Gas, DIALOG_STYLE_TABLIST, "�Ѵ��ø�áԨ", "Owner: %s\t[���]\n\
		Partner: %s\t[���]\n\
		�Ҥҹ���ѹ: %s ����Ե�\t[���]\n\
		�����ع���ѹ: %d/%d\n\
		{00FF00}��ѧ�Թ: %s\t[���]\
		", "���͡", "�Դ", businessData[id][businessOwnerName], businessData[id][businessPartnerName], 
		FormatMoney(businessData[id][businessPrice]),  businessData[id][businessOil], businessData[id][businessMaxOil], 
		FormatMoney(businessData[id][businessTreasury]));
		playerData[playerid][pBusinessID] = id;
	}
	return 1;
}
Dialog:Edit_Treasury(playerid, response, listitem, inputtext[])
{

	if (response)
	{
		switch(listitem)
		{
			case 0: //�ҡ�Թ
				return Dialog_Show(playerid, Edit_Treasury_Withdraw, DIALOG_STYLE_INPUT, "�ҡ�Թ", "�ô�кبӹǹ����ͧ��èнҡ��Ҥ�ѧ�ͧ��áԨ", "��ŧ", "¡��ԡ");
		
			case 1: //�͹�Թ
				return Dialog_Show(playerid, Edit_Treasury_Deposit, DIALOG_STYLE_INPUT, "�͹�Թ", "�ô�кبӹǹ����ͧ��èнҡ��Ҥ�ѧ�ͧ��áԨ", "��ŧ", "¡��ԡ");
		}
	}
	return 1;
}
Dialog:Edit_Treasury_Withdraw(playerid, response, listitem, inputtext[])
{
	new tmp2[127];
	new amount = strval(inputtext), id = playerData[playerid][pBusinessID];
	if (response)
	{
		if(GetPlayerMoney(playerid) < amount)
			return Dialog_Show(playerid, Edit_Treasury_Withdraw, DIALOG_STYLE_INPUT, "�ҡ�Թ", "�ô�кبӹǹ����ͧ��èнҡ��Ҥ�ѧ�ͧ��áԨ\n\
			{FF6347}*�ӹǹ�Թ���㹵�Ǣͧ�س����������§��", "��ŧ", "¡��ԡ");
			
		GivePlayerMoneyEx(playerid, -amount);
		businessData[id][businessTreasury] += amount;
		Business_Save(id);

		format(tmp2, sizeof(tmp2), "~r~-%s", FormatMoney(amount));
		GameTextForPlayer(playerid, tmp2, 3000, 1);

		Dialog_Show(playerid, Business_Owner, DIALOG_STYLE_TABLIST, "�Ѵ��ø�áԨ", "Owner: %s\t[���]\n\
		Partner: %s\t[���]\n\
		�Ҥ��Թ���: %s\t[���]\n\
		��ѧ�Թ���: %d/%d\n\
		{00FF00}��ѧ�Թ: %s\t[���]\
		", "���͡", "�Դ", businessData[id][businessOwnerName], businessData[id][businessPartnerName], FormatMoney(businessData[id][businessPrice]),  businessData[id][businessStorage], businessData[id][businessCapacity], FormatMoney(businessData[id][businessTreasury]));
		
		return 1; 
	}	
	return 1;
}

Dialog:Edit_Treasury_Deposit(playerid, response, listitem, inputtext[])
{
	new tmp2[127];
	new amount = strval(inputtext), id = playerData[playerid][pBusinessID];
	if (response)
	{
		if(businessData[id][businessTreasury] < amount)
			return Dialog_Show(playerid, Edit_Treasury_Withdraw, DIALOG_STYLE_INPUT, "�ҡ�Թ", "�ô�кبӹǹ����ͧ��èнҡ��Ҥ�ѧ�ͧ��áԨ\n\
			{FF6347}*�ӹǹ�Թ��¤�ѧ�ͧ�س��������§��", "��ŧ", "¡��ԡ");
			
		GivePlayerMoneyEx(playerid, amount);
		businessData[id][businessTreasury] -= amount;
		Business_Save(id);

		format(tmp2, sizeof(tmp2), "~g~+%s", FormatMoney(amount));
		GameTextForPlayer(playerid, tmp2, 3000, 1);

		Dialog_Show(playerid, Business_Owner, DIALOG_STYLE_TABLIST, "�Ѵ��ø�áԨ", "Owner: %s\t[���]\n\
		Partner: %s\t[���]\n\
		�Ҥ��Թ���: %s\t[���]\n\
		��ѧ�Թ���: %d/%d\n\
		{00FF00}��ѧ�Թ: %s\t[���]\
		", "���͡", "�Դ", businessData[id][businessOwnerName], businessData[id][businessPartnerName], FormatMoney(businessData[id][businessPrice]),  businessData[id][businessStorage], businessData[id][businessCapacity], FormatMoney(businessData[id][businessTreasury]));
		
		return 1;
	}	
	return 1;
}
