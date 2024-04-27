#include	<YSI_Coding\y_hooks>



enum TRUNK_DATA {
	trunkExists,
	trunkID,
	trunkItem[32],
	trunkModel,
	trunkQuantity
};
new trunkData[MAX_VEHICLES][MAX_TRUNK][TRUNK_DATA];
new ListedTrunks[MAX_VEHICLES][MAX_TRUNK];




forward OpenInventoryTrunk(playerid);
public OpenInventoryTrunk(playerid)
{
    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new vehicleid = GetNearestVehicle(playerid);
	new
		string[512],
		string2[512],
		string3[32],
		count,
		var[512];

	string = "{FFA84D}[+] จัดเก็บ\n";
    for (new i = 0; i < carData[vehicleid][carTrunk]; i ++)
	{
        if (trunkData[vehicleid][i][trunkExists]) 
	    {
            format(string, sizeof(string), "%s\n%s\t%d\n", string, trunkData[vehicleid][i][trunkItem], trunkData[vehicleid][i][trunkQuantity]);
            strcat(string2, string);
            format(var, sizeof(var), "trunklist%d", count);
            SetPVarInt(vehicleid, var, i);
            ListedTrunks[vehicleid][count++] = i;
        }
	}
	if (!count)
	{
        format(string, sizeof(string), "รายการสิ่งของ (%d/%d)\tเก็บสูงสุด (%d ชิ้น)\n{FFFFFF}%s", Trunk_Items(vehicleid), carData[vehicleid][carTrunk], carData[vehicleid][carTrunkQuantity], string);
        format(string3, sizeof(string3), "%s Trunk", ReturnVehicleName(vehicleid));
        Dialog_Show(playerid, DIALOG_TRUNK_NONE, DIALOG_STYLE_TABLIST_HEADERS, string3, string, "เลือก", "ปิด");
		return 1;
	}
	playerData[playerid][pItemSelect] = 0;
    format(string, sizeof(string), "รายการสิ่งของ (%d/%d)\tเก็บสูงสุด (%d ชิ้น)\n{FFFFFF}%s", Trunk_Items(vehicleid), carData[vehicleid][carTrunk], carData[vehicleid][carTrunkQuantity], string);
    format(string3, sizeof(string3), "%s Trunk", ReturnVehicleName(vehicleid));
	return Dialog_Show(playerid, DIALOG_TRUNK, DIALOG_STYLE_TABLIST_HEADERS, string3, string, "เลือก", "ปิด");
}

Dialog:DIALOG_TRUNK_NONE(playerid, response, listitem, inputtext[])
{
    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if (response)
	{
        playerData[playerid][INV] = 1;
        ShowPlayerInventory(playerid, true);
        playerData[playerid][pStorageSelect] = 2;
	}
	return 1;
}
Dialog:DIALOG_TRUNK(playerid, response, listitem, inputtext[])
{
    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new vehicleid = GetNearestVehicle(playerid);
	if (response)
	{
	    if (!listitem)
        {		
            playerData[playerid][INV] = 1;
            ShowPlayerInventory(playerid, true);
            playerData[playerid][pStorageSelect] = 2;
        }
	    else {

			new itemid  = ListedTrunks[vehicleid][listitem - 1];
			new count = Inventory_Count(playerid, trunkData[vehicleid][itemid][trunkItem]);


			if (trunkData[vehicleid][itemid][trunkQuantity] == 1)
			{
				if (count >= playerData[playerid][pItemAmount])
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!",  trunkData[vehicleid][itemid][trunkItem]);

				new id = Inventory_Add(playerid, trunkData[vehicleid][itemid][trunkItem], 1);
				Trunk_RemoveEx(vehicleid, trunkData[vehicleid][itemid][trunkItem], 1);

				if (id == -1)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ความจุของกระเป๋าของคุณนั้นเต็มแล้ว (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s หยิบ '%s' ออกมาจากยานพาหนะ %s (( จำนวน: 1 ))", GetPlayerNameEx(playerid), trunkData[vehicleid][itemid][trunkItem], ReturnVehicleName(vehicleid));
				return 1;
			}
			else
			{
				/*new var[32];
				format(var, sizeof(var), "trunklist%d", listitem);
				new item = GetPVarInt(vehicleid, var);*/

				OnTrunkClickItem(playerid, vehicleid, itemid);
			}

			/*format(string, sizeof(string), "%s", ReturnVehicleName(vehicleid));
			Dialog_Show(playerid, CarWithdraw, DIALOG_STYLE_INPUT, string, "{FFA84D}%s {FFFFFF}| {FFA84D}จำนวน: %d{FFFFFF}\nโปรดระบุจำนวนที่ต้องการจะหยิบออกจากยานพาหนะ", "ตกลง", "ย้อนกลับ", trunkData[vehicleid][itemid][trunkItem], trunkData[vehicleid][itemid][trunkQuantity]);*/
			return 1;
        }
	}
	for (new i = 0; i != MAX_TRUNK; i ++)
	{
	    ListedTrunks[vehicleid][i] = -1;
	}
	return 1;
}
forward OnTrunkClickItem(playerid, vehicleid, itemid);
public OnTrunkClickItem(playerid, vehicleid, itemid)
{
	new string[128];
	format(string, sizeof(string), "%s", ReturnVehicleName(vehicleid));
	Dialog_Show(playerid, CarWithdraw, DIALOG_STYLE_INPUT, string, "{FFA84D}%s {FFFFFF}| {FFA84D}จำนวน: %d{FFFFFF}\nโปรดระบุจำนวนที่ต้องการจะหยิบออกจากยานพาหนะ", "ตกลง", "ย้อนกลับ", trunkData[vehicleid][itemid][trunkItem], trunkData[vehicleid][itemid][trunkQuantity]);
	playerData[playerid][pItemSelect] = itemid;
 	return 1;
}
Dialog:CarWithdraw(playerid, response, listitem, inputtext[])
{
	new vehicleid = GetNearestVehicle(playerid),
		itemid = playerData[playerid][pItemSelect];

	new amount = strval(inputtext),
		count = Inventory_Count(playerid, trunkData[vehicleid][itemid][trunkItem]),
		string[128];

	format(string, sizeof(string), "%s", ReturnVehicleName(vehicleid));
	if (!response)
	{
		OpenInventoryTrunk(playerid);
		return 1;
	}
	if (response)
	{
		if(sscanf(inputtext, "d", amount))
		    return Dialog_Show(playerid, CarWithdraw, DIALOG_STYLE_INPUT, string, "{FFA84D}%s {FFFFFF}| {FFA84D}จำนวน: %d{FFFFFF}\nโปรดระบุจำนวนที่ต้องการจะหยิบออกจากยานพาหนะ", "ตกลง", "ย้อนกลับ", trunkData[vehicleid][itemid][trunkItem], trunkData[vehicleid][itemid][trunkQuantity]);

		if(amount < 1)
			return Dialog_Show(playerid, CarWithdraw, DIALOG_STYLE_INPUT, string, "{FFA84D}%s {FFFFFF}| {FFA84D}จำนวน: %d{FFFFFF}\nโปรดระบุจำนวนที่ต้องการจะหยิบออกจากยานพาหนะ", "ตกลง", "ย้อนกลับ", trunkData[vehicleid][itemid][trunkItem], trunkData[vehicleid][itemid][trunkQuantity]);

		if(amount > trunkData[vehicleid][itemid][trunkQuantity])
			return Dialog_Show(playerid, CarWithdraw, DIALOG_STYLE_INPUT, string, "{FFA84D}%s {FFFFFF}| {FFA84D}จำนวน: %d{FFFFFF}\nโปรดระบุจำนวนที่ต้องการจะหยิบออกจากยานพาหนะ\n{FF6347}*ไม่สามารถจัดหยิบ '%s' ออกมาได้ เนื่องจากมีจำนวนไม่เพียงพอ", "ตกลง", "ย้อนกลับ", trunkData[vehicleid][itemid][trunkItem], trunkData[vehicleid][itemid][trunkQuantity], trunkData[vehicleid][itemid][trunkItem]);
		
		if(amount > playerData[playerid][pItemAmount]-count)
			return Dialog_Show(playerid, CarWithdraw, DIALOG_STYLE_INPUT, string, "{FFA84D}%s {FFFFFF}| {FFA84D}จำนวน: %d{FFFFFF}\nโปรดระบุจำนวนที่ต้องการจะหยิบออกจากยานพาหนะ\n{FF6347}*ไม่สามารถจัดหยิบ '%s' ออกมาได้ เนื่องกระเป๋าของคุณไม่เพียงพอ", "ตกลง", "ย้อนกลับ", trunkData[vehicleid][itemid][trunkItem], trunkData[vehicleid][itemid][trunkQuantity], trunkData[vehicleid][itemid][trunkItem]);
		
		if (count >= playerData[playerid][pItemAmount])
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!", trunkData[vehicleid][itemid][trunkItem]);

		new id = Inventory_Add(playerid, trunkData[vehicleid][itemid][trunkItem], amount);
		Trunk_RemoveEx(vehicleid, trunkData[vehicleid][itemid][trunkItem], amount);

		if (id == -1)
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ความจุของกระเป๋าของคุณนั้นเต็มแล้ว (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s หยิบ '%s' ออกมาจากยานพาหนะ %s (( จำนวน: %d ))", GetPlayerNameEx(playerid), trunkData[vehicleid][itemid][trunkItem], ReturnVehicleName(vehicleid), amount);
		OpenInventoryTrunk(playerid);
		return 1;
	}
	return 1;
}
/*
Dialog:CarWithdraw(playerid, response, listitem, inputtext[])
{
	new vehicleid = GetNearestVehicle(playerid),
		amount = strval(inputtext);
		
	new itemid  = ListedTrunks[vehicleid][listitem - 1];
	new count = Inventory_Count(playerid, trunkData[vehicleid][itemid][trunkItem]);

	if (response)
	{
		if (count >= playerData[playerid][pItemAmount])
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!",  trunkData[vehicleid][itemid][trunkItem]);

		new id = Inventory_Add(playerid, trunkData[vehicleid][itemid][trunkItem], 1);
		Trunk_RemoveEx(vehicleid, trunkData[vehicleid][itemid][trunkItem], 1);

		if (id == -1)
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ความจุของกระเป๋าของคุณนั้นเต็มแล้ว (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s หยิบ '%s' ออกมาจากยานพาหนะ %s (( จำนวน: 1 ))", GetPlayerNameEx(playerid), trunkData[vehicleid][itemid][trunkItem], ReturnVehicleName(vehicleid));
		return 1;
	}
	return 1;
}*/

















/*
			if(Inventory_Count(vehicleid, item) >= carData[vehicleid][carTrunkQuantity])
				return SendClientMessage(playerid, COLOR_LIGHTRED, "[Trunk]: ช่องเก็บของยานพาหนะ ของคุณนั้นเต็มแล้ว");
*/





Trunk_Add(vehicleid, const item[], quantity = 1)
{
	new
		itemid = Trunk_GetItemID(vehicleid, item),
		string[128];

	if (itemid == -1)
	{
	    itemid = Trunk_GetFreeID(vehicleid);

	    if (itemid != -1)
	    {
	        trunkData[vehicleid][itemid][trunkExists] = true;
	        trunkData[vehicleid][itemid][trunkQuantity] = quantity;

	        format(trunkData[vehicleid][itemid][trunkItem], 32, item);

			mysql_format(g_SQL, string, sizeof(string), "INSERT INTO `trunk` (`trunkOwner`, `trunkItem`, `trunkQuantity`) VALUES ('%d', '%e', '%d')", carData[vehicleid][carOwnerID], item, quantity);
			mysql_tquery(g_SQL, string, "OnTrunkAdd", "dd", vehicleid, itemid);

	        return itemid;
		}
		return -1;
	}
	else
	{
	    mysql_format(g_SQL, string, sizeof(string), "UPDATE `trunk` SET `trunkQuantity` = `trunkQuantity` + %d WHERE `trunkOwner` = '%d' AND `trunkID` = '%d'", quantity, carData[vehicleid][carOwnerID], trunkData[vehicleid][itemid][trunkID]);
	    mysql_tquery(g_SQL, string);

	    trunkData[vehicleid][itemid][trunkQuantity] += quantity;

		//ShowInventoryAdd(playerid, item, quantity); 
	}
	return itemid;
}
Trunk_RemoveEx(vehicleid, const item[], quantity = 1)
{
	new
		itemid = Trunk_GetItemID(vehicleid, item),
		string[128];

	if (itemid != -1)
	{
	    if (trunkData[vehicleid][itemid][trunkQuantity] > 0)
	    {
	        trunkData[vehicleid][itemid][trunkQuantity] -= quantity;
		}
		if (quantity == -1 || trunkData[vehicleid][itemid][trunkQuantity] < 1)
		{
		    trunkData[vehicleid][itemid][trunkExists] = false;
		    trunkData[vehicleid][itemid][trunkQuantity] = 0;
			
		    mysql_format(g_SQL, string, sizeof(string), "DELETE FROM `trunk` WHERE `trunkOwner` = '%d' AND `trunkID` = '%d'", carData[vehicleid][carOwnerID], trunkData[vehicleid][itemid][trunkID]);
	        mysql_tquery(g_SQL, string);
		}
		else if (quantity != -1 && trunkData[vehicleid][itemid][trunkQuantity] > 0)
		{
			mysql_format(g_SQL, string, sizeof(string), "UPDATE `trunk` SET `trunkQuantity` = `trunkQuantity` - %d WHERE `trunkOwner` = '%d' AND `trunkID` = '%d'", quantity, carData[vehicleid][carOwnerID], trunkData[vehicleid][itemid][trunkID]);
            mysql_tquery(g_SQL, string);
		}
		return 1;
	}
	return 0;
}
forward OnTrunkAdd(vehicleid, itemid);
public OnTrunkAdd(vehicleid, itemid)
{
	trunkData[vehicleid][itemid][trunkID] = cache_insert_id();
	return 1;
}

Trunk_GetItemID(vehicleid, const item[])
{
	for (new i = 0; i < MAX_TRUNK; i ++)
	{
	    if (!trunkData[vehicleid][i][trunkExists])
	        continue;

		if (!strcmp(trunkData[vehicleid][i][trunkItem], item)) return i;
	}
	return -1;
}

Trunk_GetFreeID(vehicleid)
{
	if (Trunk_Items(vehicleid) >= carData[vehicleid][carTrunk])
		return -1;

	for (new i = 0; i < MAX_TRUNK; i ++)
	{
	    if (!trunkData[vehicleid][i][trunkExists])
	        return i;
	}
	return -1;
}

Trunk_Items(vehicleid)
{
    new count;

    for (new i = 0; i != MAX_TRUNK; i ++) if (trunkData[vehicleid][i][trunkExists]) {
        count++;
	}
	return count;
}

Trunk_Count(vehicleid, const item[])
{
	new itemid = Trunk_GetItemID(vehicleid, item);

	if (itemid != -1)
	    return trunkData[vehicleid][itemid][trunkQuantity];

	return 0;
}
stock Trunk_HasItem(vehicleid, const item[])
{
	return (Trunk_GetItemID(vehicleid, item) != -1);
}











































CMD:aaa(playerid, params[])
{
    OpenInventoryTrunk(playerid);
    return 1;
}


forward Trunk_Load(vehicleid);
public Trunk_Load(vehicleid)
{
	static
	    rows;
	//PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	cache_get_row_count(rows);
	for (new i = 0; i < rows && i < MAX_TRUNK; i ++) 
	{
	    trunkData[vehicleid][i][trunkExists] = true;
	    cache_get_value_name_int(i, "trunkID", trunkData[vehicleid][i][trunkID]);
        cache_get_value_name_int(i, "trunkQuantity", trunkData[vehicleid][i][trunkQuantity]);

		cache_get_value_name(i, "trunkItem", trunkData[vehicleid][i][trunkItem], 32);
	}

	return 1;
}


hook OnPlayerKeyStateChange(playerid, newkeys, listitem, oldkeys)
{

	new
		id = GetNearestVehicle(playerid);

    new FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper;
    GetVehiclePanelsDamageStatus(id, FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper);

    if (newkeys & KEY_CTRL_BACK && !IsPlayerInAnyVehicle(playerid) && IsPlayerNearBoot(playerid, id))
    {
		if(IsValidVehicle(id) && IsVehicleOwner(playerid, id) || playerData[playerid][pVehicleKeys] == id)
		{
			if (GetTrunkStatus(id))
			{
				OpenInventoryTrunk(playerid);

				// format(Msg, sizeof(Msg), "** %s พยายามค้นหาสิ่งของ", GetPlayerNameEx(playerid));
				// SetPlayerChatBubble(playerid, Msg, COLOR_PURPLE, 10.0, 5000);
				//ApplyAnimation(playerid, "RYDER","RYD_Beckon_02", 4.1, 0, 0, 0, 0, 0, 1);
				//SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้เปิดฝากระโปรงหลังรถ (Trunk)", GetPlayerNameEx(playerid));
			}
			return 1;
		}
	}
    return 1;
}



/*
GetVehicleStashCapacity(vehicleid, item)
{
	static const stashCapacities[][] = {
		// Cash   Mats    W     C    M    P   HP   PT   FMJ  W
	    {25000,   5000,   25,   25,  10,  5,  80,  60,  50,  3}, // level 1
	    {50000,   10000,  50,   50,  25,  10, 100, 80,  60,  4}, // level 2
	    {100000,  25000,  100,  75,  50,  20, 125, 100, 70,  5} // level 3
	};

	if(carData[vehicleid][carTrunk] > 0)
	{
		return stashCapacities[carData[vehicleid][carTrunk] - 1][item];
	}

	return 0;
}
*/