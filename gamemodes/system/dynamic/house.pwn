#include	<YSI_Coding\y_hooks>


// --> ระบบบ้าน Dynamic

#define MAX_HOUSES 100
#define MAX_OWNABLE_HOUSES 1
enum houseData {
	houseID,
	houseExists,
	houseOwner,
	housePrice,
	houseAddress[32],
	Float:housePos[4],
	Float:houseInt[4],
	houseInterior,
	houseExterior,
	houseExteriorVW,
	houseLocked,
	houseMoney,
	houseMapIcon,
	Text3D:houseText3D,
	housePickup,
	houseLights,
	houseWeapons[10],
	houseAmmo[10]
};
new HouseData[MAX_HOUSES][houseData];

enum houseInteriors {
	eHouseInterior,
	Float:eHouseX,
	Float:eHouseY,
	Float:eHouseZ,
	Float:eHouseAngle
};

new const Float:arrHouseInteriors[20][houseInteriors] = {
	{10, 2269.8772, -1210.3240, 1047.5625, 90.0000},
    {2, 2468.2576, -1698.2361, 1013.5078, 90.0000},
	{3, 2495.8711, -1693.0996, 1014.7422, 180.0000},
	{5, 2233.7888, -1114.2689, 1050.8828, 0.0000},
	{9, 2317.8015, -1026.2113, 1050.2178, 0.0000},
	{3, 235.2923, 1187.3684, 1080.2578, 0.0000},
	{2, 226.2912, 1240.0554, 1082.1406, 90.0000},
	{1, 223.1618, 1287.5175, 1082.1406, 0.0000},
	{5, 226.9281, 1114.2813, 1080.9962, 270.0000},
	{15, 295.1485, 1473.1080, 1080.2578, 0.0000},
	{10, 23.9584, 1340.6075, 1084.3750, 0.0000},
	{4, 222.0425, 1140.7565, 1082.6094, 0.0000},
	{12, 2324.4209, -1148.9365, 1050.7101, 0.0000},
	{4, -261.1430, 1456.6396, 1084.3672, 90.0000},
	{5, 22.9676, 1403.8368, 1084.4297, 0.0000},
	{5, 140.3088, 1366.8196, 1083.8594, 0.0000},
	{6, 234.3149, 1064.2772, 1084.2114, 0.0000},
	{7, 225.7000, 1022.0012, 1084.0161, 0.0000},
	{5, 1298.9750, -796.4567, 1084.0078, 0.0000},
	{15, -283.8687, 1471.1174, 1084.3750, 90.0000}
};


CMD:createhouse(playerid, params[])
{
	static
	    price,
	    id,
	    address[32];

    if (playerData[playerid][pAdmin] < 6)
	    return SendClientMessage(playerid, COLOR_GREY, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "ds[32]", price, address))
	    return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /createhouse [ราคา] [ชื่อบ้าน]");

	for (new i = 0; i != MAX_HOUSES; i ++) if (HouseData[i][houseExists] && !strcmp(HouseData[i][houseAddress], address, true)) {
	    return SendClientMessageEx(playerid, COLOR_GREY, "ที่อยู่ \"%s\" ถูกใช้งานแล้ว (ไอดี : %d)", address, i);
	}
	id = House_Create(playerid, address, price);

	if (id == -1)
	    return SendClientMessage(playerid, COLOR_GREY, "เซิร์ฟเวอร์มีจำนวนบ้านถึงขีด จำกัด แล้ว");

	SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "คุณได้ทำการสร้างบ้านไอดี %d เรียบร้อยแล้ว", id);
	return 1;
}

CMD:destroyhouse(playerid, params[])
{
	static
	    id = 0;

    if (playerData[playerid][pAdmin] < 6)
	    return SendClientMessage(playerid, COLOR_GREY, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /destroyhouse [house id]");

	if ((id < 0 || id >= MAX_HOUSES) || !HouseData[id][houseExists])
	    return SendClientMessage(playerid, COLOR_GREY, "คุณระบุบ้านที่ไม่ถูกต้อง ID");

	House_Delete(id);
	SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "คุณได้ทำการลบบ้านไอดี %d ออกจากฐานข้อมูลแล้ว", id);
	return 1;
}

CMD:checkhouse(playerid, params[])
{
	static
	    id = -1;

	if ((id = House_Nearest(playerid)) != -1)
	    SendClientMessageEx(playerid, COLOR_GREY, "คุณกำลังยืนอยู่ ใกล้ ๆ กับบ้านไอดี : %d", id);

	return 1;
}

CMD:buyhouse(playerid, params[])
{
	new
		id = -1;

	if ((id = House_Nearest(playerid)) != -1)
	{
		if (House_GetCount(playerid) >= MAX_OWNABLE_HOUSES)
			return SendClientMessageEx(playerid, COLOR_GREY, "คุณมีบ้าน %d แห่งแล้วตอนนี้", MAX_OWNABLE_HOUSES);

		if (HouseData[id][houseOwner] != 0)
			return SendClientMessage(playerid, COLOR_GREY, "บ้านแห่งนี้มีเจ้าของแล้ว");

		if (HouseData[id][housePrice] > GetPlayerMoneyEx(playerid))
			return SendClientMessage(playerid, COLOR_GREY, "คุณมีเงินไม่เพียงพอที่จะซื้อ");

		HouseData[id][houseOwner] = GetPlayerSQLID(playerid);

		House_Refresh(id);
		House_Save(id);

		GivePlayerMoneyEx(playerid, -HouseData[id][housePrice]);
		SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "คุณได้ซื้อ \"%s\" เป็นจำนวน %s!", HouseData[id][houseAddress], FormatNumber(HouseData[id][housePrice]));
	}

	return 1;
}

CMD:edithouse(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (playerData[playerid][pAdmin] < 6)
	    return SendClientMessage(playerid, COLOR_GREY, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /edithouse [id] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, interior, price, address, type");
		return 1;
	}
	if ((id < 0 || id >= MAX_HOUSES) || !HouseData[id][houseExists])
	    return SendClientMessage(playerid, COLOR_GREY, "เกิดข้อผิดพลาดเกี่ยวกับบ้าน");

	if (!strcmp(type, "location", true))
	{
		GetPlayerPos(playerid, HouseData[id][housePos][0], HouseData[id][housePos][1], HouseData[id][housePos][2]);
		GetPlayerFacingAngle(playerid, HouseData[id][housePos][3]);

		HouseData[id][houseExterior] = GetPlayerInterior(playerid);
		HouseData[id][houseExteriorVW] = GetPlayerVirtualWorld(playerid);

		House_Refresh(id);
		House_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับตำแหน่งบ้านไอดี : %d", GetPlayerNameEx(playerid), id);
	}
	else if (!strcmp(type, "interior", true))
	{
	    GetPlayerPos(playerid, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2]);
		GetPlayerFacingAngle(playerid, HouseData[id][houseInt][3]);

		HouseData[id][houseInterior] = GetPlayerInterior(playerid);

        foreach (new i : Player)
		{
			if (playerData[i][pHouse] == HouseData[id][houseID])
			{
				SetPlayerPos(i, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2]);
				SetPlayerFacingAngle(i, HouseData[id][houseInt][3]);

				SetPlayerInterior(i, HouseData[id][houseInterior]);
				SetCameraBehindPlayer(i);
			}
		}
		House_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับแต่งภายในบ้านไอดี : %d", GetPlayerNameEx(playerid), id);
	}
	else if (!strcmp(type, "price", true))
	{
	    new price;

	    if (sscanf(string, "d", price))
	        return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /edithouse [id] [price] [new price]");

	    HouseData[id][housePrice] = price;

	    House_Refresh(id);
	    House_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับแต่งราคาบ้านไอดี %d เป็น %s", GetPlayerNameEx(playerid), id, FormatNumber(price));
	}
	else if (!strcmp(type, "address", true))
	{
	    new address[32];

	    if (sscanf(string, "s[32]", address))
	        return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /edithouse [id] [address] [new address]");

	    format(HouseData[id][houseAddress], 32, address);

	    House_Refresh(id);
	    House_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับแต่งชื่อบ้านไอดี %d เป็น \"%s\"", GetPlayerNameEx(playerid), id, address);
	}
	else if (!strcmp(type, "type", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
	        return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /edithouse [id] [type] [interior type]");

		if (typeint < 1 || typeint > sizeof(arrHouseInteriors))
			return SendClientMessageEx(playerid, COLOR_GREY, "เกิดข้อผิอพลาด (1-%d)", sizeof(arrHouseInteriors));

	    HouseData[id][houseInt][0] = arrHouseInteriors[typeint][eHouseX];
	    HouseData[id][houseInt][1] = arrHouseInteriors[typeint][eHouseY];
	    HouseData[id][houseInt][2] = arrHouseInteriors[typeint][eHouseZ];
	    HouseData[id][houseInt][3] = arrHouseInteriors[typeint][eHouseAngle];
        HouseData[id][houseInterior] = arrHouseInteriors[typeint][eHouseInterior];

		foreach (new i : Player)
		{
			if (playerData[i][pHouse] == HouseData[id][houseID])
			{
				SetPlayerPos(i, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2]);
				SetPlayerFacingAngle(i, HouseData[id][houseInt][3]);

				SetPlayerInterior(i, HouseData[id][houseInterior]);
				SetCameraBehindPlayer(i);
			}
		}
	    House_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับเปลี่ยนภายในบ้านไอดี : %d เป็นแบบ %d", GetPlayerNameEx(playerid), id, typeint);
	}
	return 1;
}















hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{

	if (newkeys & KEY_SECONDARY_ATTACK && !IsPlayerInAnyVehicle(playerid))
	{
		static
			id = -1;

	    if ((id = House_Nearest(playerid)) != -1)
	    {

	        if (HouseData[id][houseLocked])
	            return 1;

			SetPlayerPos(playerid, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2]);
			SetPlayerFacingAngle(playerid, HouseData[id][houseInt][3]);

			SetPlayerInterior(playerid, HouseData[id][houseInterior]);
			SetPlayerVirtualWorld(playerid, HouseData[id][houseID] + 5000);

			SetCameraBehindPlayer(playerid);
			playerData[playerid][pHouse] = HouseData[id][houseID];
			return 1;
		}

		if ((id = House_Inside(playerid)) != -1 && IsPlayerInRangeOfPoint(playerid, 2.5, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2]))
	    {
	        if (HouseData[id][houseLocked])
	            return 1;

			SetPlayerPos(playerid, HouseData[id][housePos][0], HouseData[id][housePos][1], HouseData[id][housePos][2]);
			SetPlayerFacingAngle(playerid, HouseData[id][housePos][3] - 180.0);

			SetPlayerInterior(playerid, HouseData[id][houseExterior]);
			SetPlayerVirtualWorld(playerid, HouseData[id][houseExteriorVW]);

			SetCameraBehindPlayer(playerid);
			playerData[playerid][pHouse] = -1;

		}
		return 1;
    }
	if (newkeys & KEY_NO && !IsPlayerInAnyVehicle(playerid))
	{
		static
			id = -1;

	    if ((id = House_Nearest(playerid)) != -1)
	    {
            if(House_IsOwner(playerid, id))
            {
                if(HouseData[id][houseLocked] == 0)
                {
                    GameTextForPlayer(playerid, "~r~Locked", 3000, 4);
                    HouseData[id][houseLocked] = 1;
                    PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
                }
                else
                {
                    GameTextForPlayer(playerid, "~g~Unlocked", 3000, 4);
                    HouseData[id][houseLocked] = 0;
                    PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
                }
                House_RefreshLock(id);
                House_Save(id);
            }
			return 1;
		}

		if ((id = House_Inside(playerid)) != -1 && IsPlayerInRangeOfPoint(playerid, 2.5, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2]))
	    {
            if(House_IsOwner(playerid, id))
            {
                if(HouseData[id][houseLocked] == 0)
                {
                    GameTextForPlayer(playerid, "~r~Locked", 3000, 4);
                    HouseData[id][houseLocked] = 1;
                    PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
                }
                else
                {
                    GameTextForPlayer(playerid, "~g~Unlocked", 3000, 4);
                    HouseData[id][houseLocked] = 0;
                    PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
                }
                House_RefreshLock(id);
                House_Save(id);
                
            }
			return 1;
		}
	}
    return 1;
}
CMD:lockdoor(playerid, params[])
{
	new
		id = -1;

	if ((id = House_Nearest(playerid)) != -1)
	{
        if(House_IsOwner(playerid, id))
        {
            if(HouseData[id][houseLocked] == 0)
            {
                GameTextForPlayer(playerid, "~r~Locked", 3000, 4);
                HouseData[id][houseLocked] = 1;
                PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
            }
            else
            {
                GameTextForPlayer(playerid, "~g~Unlocked", 3000, 4);
                HouseData[id][houseLocked] = 0;
                PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
            }
            House_RefreshLock(id);
            House_Save(id);
            
        }
	}
	return 1;
}
			
House_Nearest(playerid)
{
    for (new i = 0; i != MAX_HOUSES; i ++) if (HouseData[i][houseExists] && IsPlayerInRangeOfPoint(playerid, 2.5, HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2]))
	{
		if (GetPlayerInterior(playerid) == HouseData[i][houseExterior] && GetPlayerVirtualWorld(playerid) == HouseData[i][houseExteriorVW])
			return i;
	}
	return -1;
}

House_Create(playerid, const address[], price)
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
	    	if (!HouseData[i][houseExists])
		    {
    	        HouseData[i][houseExists] = true;
        	    HouseData[i][houseOwner] = 0;
            	HouseData[i][housePrice] = price;
            	HouseData[i][houseMoney] = 0;

				format(HouseData[i][houseAddress], 32, address);

    	        HouseData[i][housePos][0] = x;
    	        HouseData[i][housePos][1] = y;
    	        HouseData[i][housePos][2] = z;
    	        HouseData[i][housePos][3] = angle;

                HouseData[i][houseInt][0] = 2269.8772;
                HouseData[i][houseInt][1] = -1210.3240;
                HouseData[i][houseInt][2] = 1047.5625;
                HouseData[i][houseInt][3] = 90.0000;

				HouseData[i][houseInterior] = 10;
				HouseData[i][houseExterior] = GetPlayerInterior(playerid);
				HouseData[i][houseExteriorVW] = GetPlayerVirtualWorld(playerid);

				HouseData[i][houseLights] = true;
				HouseData[i][houseLocked] = false;

				House_Refresh(i);
				mysql_tquery(g_SQL, "INSERT INTO `houses` (`houseOwner`) VALUES(0)", "OnHouseCreated", "d", i);
				return i;
			}
		}
	}
	return -1;
}

House_Delete(houseid)
{
	if (houseid != -1 && HouseData[houseid][houseExists])
	{
	    new
	        string[64];

		format(string, sizeof(string), "DELETE FROM `houses` WHERE `houseID` = '%d'", HouseData[houseid][houseID]);
		mysql_tquery(g_SQL, string);

        if (IsValidDynamic3DTextLabel(HouseData[houseid][houseText3D]))
		    DestroyDynamic3DTextLabel(HouseData[houseid][houseText3D]);

		if (IsValidDynamicPickup(HouseData[houseid][housePickup]))
		    DestroyDynamicPickup(HouseData[houseid][housePickup]);

		if (IsValidDynamicMapIcon(HouseData[houseid][houseMapIcon]))
		    DestroyDynamicMapIcon(HouseData[houseid][houseMapIcon]);

	    HouseData[houseid][houseExists] = false;
	    HouseData[houseid][houseOwner] = 0;
	    HouseData[houseid][houseID] = 0;
	}
	return 1;
}

House_IsOwner(playerid, houseid)
{
	if (playerData[playerid][pID] == -1)
	    return 0;

    if ((HouseData[houseid][houseExists] && HouseData[houseid][houseOwner] != 0) && HouseData[houseid][houseOwner] == playerData[playerid][pID])
		return 1;

	return 0;
}
/*
IsBusinessOwner(playerid, businessid)
{
	return (businessData[businessid][businessOwner] == playerData[playerid][pID]) || (businessData[businessid][businessPartner] == playerData[playerid][pID]) && (businessData[businessid][businessID] != -1);
}
*/
stock House_GetFreeID(houseid)
{
	if (houseid == -1 || !HouseData[houseid][houseExists])
	    return 0;

	for (new i = 0; i < MAX_HOUSE_STORAGE; i ++)
	{
	    if (!HouseStorage[houseid][i][hItemExists])
	        return i;
	}
	return -1;
}

stock House_GetFreeIDEx(houseid, item[], extended)
{
	if (houseid == -1 || !HouseData[houseid][houseExists])
	    return 0;

	for (new i = 0; i < MAX_HOUSE_STORAGE; i ++)
	{
	    if (!HouseStorage[houseid][i][hItemExists])
	        continue;

        if (!strcmp(HouseStorage[houseid][i][hItemName], item) && HouseStorage[houseid][i][hItemExtended] == extended) return i;
	}
	return -1;
}

stock GetHouseByID(sqlid)
{
	for (new i = 0; i != MAX_HOUSES; i ++) if (HouseData[i][houseExists] && HouseData[i][houseID] == sqlid)
	    return i;

	return -1;
}

forward OnHouseCreated(houseid);
public OnHouseCreated(houseid)
{
	if (houseid == -1 || !HouseData[houseid][houseExists])
	    return 0;

	HouseData[houseid][houseID] = cache_insert_id();
	House_Save(houseid);

	return 1;
}

House_GetCount(playerid)
{
	new
		count = 0;

	for (new i = 0; i != MAX_HOUSES; i ++)
	{
		if (HouseData[i][houseExists] && House_IsOwner(playerid, i))
   		{
   		    count++;
		}
	}
	return count;
}

// --> ระบบบ้าน Dynamic

forward House_Load();
public House_Load()
{
	new
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_HOUSES)
	{

		HouseData[i][houseExists] = true;
		HouseData[i][houseLights] = true;

		cache_get_value_name_int(i, "houseID", HouseData[i][houseID]);
		cache_get_value_name_int(i, "houseOwner", HouseData[i][houseOwner]);
		cache_get_value_name_int(i, "housePrice", HouseData[i][housePrice]);

	    cache_get_value_name(i, "houseAddress", HouseData[i][houseAddress], 32);

		cache_get_value_name_float(i, "housePosX", HouseData[i][housePos][0]);
		cache_get_value_name_float(i, "housePosY", HouseData[i][housePos][1]);
		cache_get_value_name_float(i, "housePosZ", HouseData[i][housePos][2]);
		cache_get_value_name_float(i, "housePosA", HouseData[i][housePos][3]);

		cache_get_value_name_float(i, "houseIntX", HouseData[i][houseInt][0]);
		cache_get_value_name_float(i, "houseIntY", HouseData[i][houseInt][1]);
		cache_get_value_name_float(i, "houseIntZ", HouseData[i][houseInt][2]);
		cache_get_value_name_float(i, "houseIntA", HouseData[i][houseInt][3]);

		cache_get_value_name_int(i, "houseInterior", HouseData[i][houseInterior]);
		cache_get_value_name_int(i, "houseExterior", HouseData[i][houseExterior]);
		cache_get_value_name_int(i, "houseExteriorVW", HouseData[i][houseExteriorVW]);
		cache_get_value_name_int(i, "houseLocked", HouseData[i][houseLocked]);
		cache_get_value_name_int(i, "houseMoney", HouseData[i][houseMoney]);

		House_Refresh(i);
	}
	return 1;
}

House_Save(houseid)
{
	new
	    query[1536];

	format(query, sizeof(query), "UPDATE `houses` SET `houseOwner` = '%d', `housePrice` = '%d', `houseAddress` = '%s', `housePosX` = '%.4f', `housePosY` = '%.4f', `housePosZ` = '%.4f', `housePosA` = '%.4f', `houseIntX` = '%.4f', `houseIntY` = '%.4f', `houseIntZ` = '%.4f', `houseIntA` = '%.4f', `houseInterior` = '%d', `houseExterior` = '%d', `houseExteriorVW` = '%d'",
	    HouseData[houseid][houseOwner],
	    HouseData[houseid][housePrice],
	    HouseData[houseid][houseAddress],
	    HouseData[houseid][housePos][0],
	    HouseData[houseid][housePos][1],
	    HouseData[houseid][housePos][2],
	    HouseData[houseid][housePos][3],
	    HouseData[houseid][houseInt][0],
	    HouseData[houseid][houseInt][1],
	    HouseData[houseid][houseInt][2],
	    HouseData[houseid][houseInt][3],
        HouseData[houseid][houseInterior],
        HouseData[houseid][houseExterior],
        HouseData[houseid][houseExteriorVW]
	);
	for (new i = 0; i < 10; i ++) {
		format(query, sizeof(query), "%s, `houseWeapon%d` = '%d', `houseAmmo%d` = '%d'", query, i + 1, HouseData[houseid][houseWeapons][i], i + 1, HouseData[houseid][houseAmmo][i]);
	}
	format(query, sizeof(query), "%s, `houseLocked` = '%d', `houseMoney` = '%d' WHERE `houseID` = '%d'",
	    query,
	    HouseData[houseid][houseLocked],
	    HouseData[houseid][houseMoney],
        HouseData[houseid][houseID]
	);
	return mysql_tquery(g_SQL, query);
}

House_Inside(playerid)
{
	if (playerData[playerid][pHouse] != -1)
	{
	    for (new i = 0; i != MAX_HOUSES; i ++) if (HouseData[i][houseExists] && HouseData[i][houseID] == playerData[playerid][pHouse] && GetPlayerInterior(playerid) == HouseData[i][houseInterior] && GetPlayerVirtualWorld(playerid) > 0) {
	        return i;
		}
	}
	return -1;
}

/*House_Area(playerid)
{
	new
        Float:fDistance[2] = {99999.0, 0.0},
		h = -1;

	for (new i = 0; i != MAX_HOUSES; i ++) {
		if (HouseData[i][houseExists])
		{
	        if(GetPlayerInterior(playerid) == HouseData[i][houseInterior] && GetPlayerVirtualWorld(playerid) > 0 && HouseData[i][houseID] == playerData[playerid][pHouse])
	        {
         		h = i;
         		break;
			}
			if(IsPlayerInRangeOfPoint(playerid, 15, HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2]))
			{
			    fDistance[1] = GetPlayerDistanceFromPoint(playerid, HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2]);

				if (fDistance[1] < fDistance[0])
				{
				    fDistance[0] = fDistance[1];
				    h = i;
				}
			}
		}
	}
	return h;
}*/

House_Refresh(houseid)
{
	if (houseid != -1 && HouseData[houseid][houseExists])
	{
		if (IsValidDynamic3DTextLabel(HouseData[houseid][houseText3D]))
		    DestroyDynamic3DTextLabel(HouseData[houseid][houseText3D]);

		if (IsValidDynamicPickup(HouseData[houseid][housePickup]))
		    DestroyDynamicPickup(HouseData[houseid][housePickup]);

		if (IsValidDynamicMapIcon(HouseData[houseid][houseMapIcon]))
		    DestroyDynamicMapIcon(HouseData[houseid][houseMapIcon]);

		new
			string[512];

		if (!HouseData[houseid][houseOwner]) {
			format(string, sizeof(string), "{FFA84D}[%s]\n{00FF00}ราคา : %s\n", HouseData[houseid][houseAddress], FormatNumber(HouseData[houseid][housePrice]));
            HouseData[houseid][houseText3D] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, HouseData[houseid][houseExteriorVW], HouseData[houseid][houseExterior]);
            HouseData[houseid][houseMapIcon] = CreateDynamicMapIcon(HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2], 31, 0, HouseData[houseid][houseExteriorVW], HouseData[houseid][houseExterior]);
            HouseData[houseid][housePickup] = CreateDynamicPickup(1273, 23, HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2], HouseData[houseid][houseExteriorVW], HouseData[houseid][houseExterior]);
        }
		else 
        {
            format(string, sizeof(string), "{FFA84D}[%s]\n{FFFFFF}สถานะ : %s", HouseData[houseid][houseAddress], (HouseData[houseid][houseLocked] != 0) ? ("{FF0000}ถูกล็อค") : ("{00FF00}ปลดล็อค"));
            HouseData[houseid][houseText3D] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, HouseData[houseid][houseExteriorVW], HouseData[houseid][houseExterior]);
            HouseData[houseid][housePickup] = CreateDynamicPickup(19198, 23, HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2]+0.5, HouseData[houseid][houseExteriorVW], HouseData[houseid][houseExterior]);
        }
        
        //HouseData[houseid][houseMapIcon] = CreateDynamicMapIcon(HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2], (HouseData[houseid][houseOwner] != 0) ? (32) : (31), 0, HouseData[houseid][houseExteriorVW], HouseData[houseid][houseExterior]);
	}
	return 1;
}
House_RefreshLock(houseid)
{
	if (houseid != -1 && HouseData[houseid][houseExists])
	{
		if (IsValidDynamic3DTextLabel(HouseData[houseid][houseText3D]))
		    DestroyDynamic3DTextLabel(HouseData[houseid][houseText3D]);
		new
			string[512];

		if (!HouseData[houseid][houseOwner]) {
			format(string, sizeof(string), "{FFA84D}[%s]\n{00FF00}ราคา : %s\n", HouseData[houseid][houseAddress], FormatNumber(HouseData[houseid][housePrice]));
            HouseData[houseid][houseText3D] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, HouseData[houseid][houseExteriorVW], HouseData[houseid][houseExterior]);

        }
		else 
        {
            format(string, sizeof(string), "{FFA84D}[%s]\n{FFFFFF}สถานะ : %s", HouseData[houseid][houseAddress], (HouseData[houseid][houseLocked] != 0) ? ("{FF0000}ถูกล็อค") : ("{00FF00}ปลดล็อค"));
            HouseData[houseid][houseText3D] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, HouseData[houseid][houseExteriorVW], HouseData[houseid][houseExterior]);
       
        }
    }
	return 1;
}