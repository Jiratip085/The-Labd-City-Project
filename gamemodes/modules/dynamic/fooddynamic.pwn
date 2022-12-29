#include <YSI\y_hooks>

enum foodData {
	foodID,
	foodExists,
	Float:foodPos[3],
	foodInterior,
	foodWorld,
	foodPickups[3],
	Text3D:foodText3D[3]
};
new FoodData[MAX_DYNAMIC_FOODS][foodData];

//Food Dynamic
Food_Create(playerid)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	if (GetPlayerPos(playerid, x, y, z))
	{
		for (new i = 0; i != MAX_DYNAMIC_FOODS; i ++)
		{
	    	if (!FoodData[i][foodExists])
	    	{
	        	FoodData[i][foodExists] = true;

				FoodData[i][foodPos][0] = x;
	        	FoodData[i][foodPos][1] = y;
	        	FoodData[i][foodPos][2] = z;

	        	FoodData[i][foodInterior] = GetPlayerInterior(playerid);
	        	FoodData[i][foodWorld] = GetPlayerVirtualWorld(playerid);

	        	Food_Refresh(i);
	        	mysql_tquery(dbCon, "INSERT INTO `foods` (`foodInterior`) VALUES(0)", "OnFoodCreated", "d", i);

	        	return i;
	        }
	    }
	}
	return -1;
}

forward OnFoodCreated(foodid);
public OnFoodCreated(foodid)
{
	if (foodid == -1 || !FoodData[foodid][foodExists])
	    return 0;

	FoodData[foodid][foodID] = cache_insert_id();
	Food_Save(foodid);

	return 1;
}

Food_Save(foodid)
{
	new
	    query[512];

	format(query, sizeof(query), "UPDATE `foods` SET `foodPosX` = '%.4f', `foodPosY` = '%.4f', `foodPosZ` = '%.4f', `foodInterior` = '%d', `foodWorld` = '%d' WHERE `foodID` = '%d'",
		FoodData[foodid][foodPos][0],
	    FoodData[foodid][foodPos][1],
	    FoodData[foodid][foodPos][2],
	    FoodData[foodid][foodInterior],
	    FoodData[foodid][foodWorld],
	    FoodData[foodid][foodID]
	);
	return mysql_tquery(dbCon, query);
}

Food_Refresh(foodid)
{
	if (foodid != -1 && FoodData[foodid][foodExists])
	{
	    for (new i = 0; i < 3; i ++) {
			if (IsValidDynamic3DTextLabel(FoodData[foodid][foodText3D][i]))
		    	DestroyDynamic3DTextLabel(FoodData[foodid][foodText3D][i]);

			if (IsValidDynamicPickup(FoodData[foodid][foodPickups][i]))
		    	DestroyDynamicPickup(FoodData[foodid][foodPickups][i]);
		}
		new
		    string[90];

		format(string, sizeof(string), "พิมพ์ '/buy' เพื่อซื้ออาหาร!");
		FoodData[foodid][foodText3D][0] = CreateDynamic3DTextLabel(string, COLOR_WHITE, FoodData[foodid][foodPos][0], FoodData[foodid][foodPos][1], FoodData[foodid][foodPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, FoodData[foodid][foodWorld], FoodData[foodid][foodInterior]);
  		FoodData[foodid][foodPickups][0] = CreateDynamicPickup(1239, 23, FoodData[foodid][foodPos][0], FoodData[foodid][foodPos][1], FoodData[foodid][foodPos][2], FoodData[foodid][foodWorld], FoodData[foodid][foodInterior]);
	}
	return 1;
}

Food_Delete(foodid)
{
	if (foodid != -1 && FoodData[foodid][foodExists])
	{
	    new
	        string[64];

		format(string, sizeof(string), "DELETE FROM `foods` WHERE `foodID` = '%d'", FoodData[foodid][foodID]);
		mysql_tquery(dbCon, string);

        for (new i = 0; i < 3; i ++) {
			if (IsValidDynamic3DTextLabel(FoodData[foodid][foodText3D][i]))
		    	DestroyDynamic3DTextLabel(FoodData[foodid][foodText3D][i]);

			if (IsValidDynamicPickup(FoodData[foodid][foodPickups][i]))
		    	DestroyDynamicPickup(FoodData[foodid][foodPickups][i]);
		}
		FoodData[foodid][foodExists] = false;
	    FoodData[foodid][foodID] = 0;
	}
	return 1;
}

//dynamic product
forward Food_Load();
public Food_Load()
{
	new
	    rows;

	cache_get_row_count(rows);

    for (new i = 0; i < rows; i ++) if (i < MAX_DYNAMIC_FOODS)
	{
	    FoodData[i][foodExists] = true;

	    cache_get_value_name_int(i, "foodID", FoodData[i][foodID]);
	    cache_get_value_name_float(i, "foodPosX", FoodData[i][foodPos][0]);
	    cache_get_value_name_float(i, "foodPosY", FoodData[i][foodPos][1]);
	    cache_get_value_name_float(i, "foodPosZ", FoodData[i][foodPos][2]);
	    cache_get_value_name_int(i, "foodInterior", FoodData[i][foodInterior]);
	    cache_get_value_name_int(i, "foodWorld", FoodData[i][foodWorld]);


 	    Food_Refresh(i);
	}
	return 1;
}

Food_Nearest(playerid)
{
    for (new i = 0; i != MAX_DYNAMIC_FOODS; i ++) if (FoodData[i][foodExists] && IsPlayerInRangeOfPoint(playerid, 2.5, FoodData[i][foodPos][0], FoodData[i][foodPos][1], FoodData[i][foodPos][2]))
	{
		if (GetPlayerInterior(playerid) == FoodData[i][foodInterior] && GetPlayerVirtualWorld(playerid) == FoodData[i][foodWorld])
			return i;
	}
	return -1;
}

//Food CMD
CMD:createfood(playerid, params[])
{
	new
		id = -1,
		string[128];

	if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	id = Food_Create(playerid);

	if (id == -1)
	    return SendClientMessage(playerid, -1, "เซิฟเวอร์นี้ได้สร้างร้านอาหารเกินขีดจำกัดแล้ว");

    format(string, sizeof(string), "คุณประสบความสำเร็จสร้างคลังสินค้าไอดี: %d", id);
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:editfood(playerid, params[])
{
	new
	    id,
	    type[24],
	    string[128];

	if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendClientMessage(playerid, -1, "/editfood [id] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location");
		return 1;
	}
	if ((id < 0 || id >= MAX_DYNAMIC_FOODS) || !FoodData[id][foodExists])
	    return SendClientMessage(playerid, -1, "คุณระบุไอดีคลังสินค้าไม่ถูกต้อง");

	if (!strcmp(type, "location", true))
	{
	    new
	        Float:x,
	        Float:y,
	        Float:z;

	    GetPlayerPos(playerid, x, y, z);

		FoodData[id][foodPos][0] = x;
		FoodData[id][foodPos][1] = y;
		FoodData[id][foodPos][2] = z;

		FoodData[id][foodInterior] = GetPlayerInterior(playerid);
		FoodData[id][foodWorld] = GetPlayerVirtualWorld(playerid);

		Food_Refresh(id);
		Food_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับตำแหน่งของร้านอาหารไอดี: %d", ReturnRealName(playerid, 0), id);
	}
	return 1;
}

CMD:destroyfood(playerid, params[])
{
	new
	    id = 0,
	    string[128];

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, -1, "/destroyfood [food id]");

	if ((id < 0 || id >= MAX_DYNAMIC_FOODS) || !FoodData[id][foodExists])
	    return SendClientMessage(playerid, -1, "คุณระบุไอดีคลังสินค้าผิดพลาด");

	Food_Delete(id);
	format(string, sizeof(string), "คุณประสบความสำเร็จในการทำลายร้านอาหารไอดี: %d", id);
	SendClientMessage(playerid, -1, string);
	return 1;
}
