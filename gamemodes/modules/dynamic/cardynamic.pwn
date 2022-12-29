#include <YSI\y_hooks>

enum carData {
	carID,
	carExists,
	carModel,
	carOwner,
	Float:carPos[4],
	carColor1,
	carColor2,
	carPaintjob,
	carLocked,
	carMods[14],
	carImpounded,
	carImpoundPrice,
	carFaction,
	carJob,
	carWeapons[5],
	carAmmo[5],
	carVehicle,
	carFuel,

	carLock,
	carInsurance,
	carDamage[4],
	Float:carHealth,
	carDeathTime,
	carDestroyed,
	carMileage,
	carGPS,
	carImmob,
	carBatteryL,
	carEngineL,
	carPlate[32],
	carDonator,
	carRent,
	carRented,
	carRentOwner,

};

new CarData[MAX_DYNAMIC_CARS][carData],Total_Cars_Created;

Car_IsOwner(playerid, carid)
{
	if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_IS_LOGGED_IN) || Character[playerid][ID] == -1)
	    return 0;

    if ((CarData[carid][carExists] && CarData[carid][carOwner] != 0) && CarData[carid][carOwner] == Character[playerid][ID])
		return 1;

	return 0;
}

CarRent_IsOwner(playerid, carid)
{
	if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_IS_LOGGED_IN) || Character[playerid][ID] == -1)
	    return 0;

    if ((CarData[carid][carExists]) && CarData[carid][carRentOwner] == Character[playerid][ID])
		return 1;

	return 0;
}

Car_Nearest(playerid)
{
	new
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (CarData[i][carExists]) {
		GetVehiclePos(CarData[i][carVehicle], fX, fY, fZ);
		if (IsPlayerInRangeOfPoint(playerid, 6.0, fX, fY, fZ)) {
		    return i;
		}
	}
	return -1;
}

Car_GetCount(playerid)
{
	new
		count = 0;

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++)
	{
		if (CarData[i][carExists] && CarData[i][carOwner] == Character[playerid][ID])
   		{
   		    count++;
		}
	}
	return count;
}

Car_Create(ownerid, modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, type = 0, job = 0)
{
    for (new i = 0; i != MAX_DYNAMIC_CARS; i ++)
	{
		if (!CarData[i][carExists])
   		{
   		    if (color1 == -1)
   		        color1 = random(127);

			if (color2 == -1)
			    color2 = random(127);

   		    CarData[i][carExists] = true;
            CarData[i][carModel] = modelid;
            CarData[i][carOwner] = ownerid;

            CarData[i][carPos][0] = x;
            CarData[i][carPos][1] = y;
            CarData[i][carPos][2] = z;
            CarData[i][carPos][3] = angle;

            CarData[i][carColor1] = color1;
            CarData[i][carColor2] = color2;
            CarData[i][carPaintjob] = -1;
            CarData[i][carLocked] = false;
            CarData[i][carImpounded] = -1;
            CarData[i][carImpoundPrice] = 0;
            CarData[i][carFaction] = type;
            CarData[i][carJob] = job;
            CarData[i][carFuel] = 100;
            CarData[i][carLock] = 0;
            CarData[i][carInsurance] = 2;
            CarData[i][carDeathTime] = 0;
            CarData[i][carDestroyed] = 0;
            CarData[i][carMileage] = 0;
			CarData[i][carGPS] = 0;
			CarData[i][carImmob] = 0;
			CarData[i][carBatteryL] = 500;
			CarData[i][carEngineL] = 500;
			CarData[i][carDonator] = 0;
			CarData[i][carRent] = 0;

            for (new j = 0; j < 14; j ++)
			{
                if (j < 5)
				{
                    CarData[i][carWeapons][j] = 0;
                    CarData[i][carAmmo][j] = 0;
                }
                CarData[i][carMods][j] = 0;
            }
            CarData[i][carVehicle] = CreateVehicle(modelid, x, y, z, angle, color1, color2, -1);

            if (CarData[i][carVehicle] != INVALID_VEHICLE_ID) {
                ResetVehicle(CarData[i][carVehicle]);
            }
            mysql_tquery(dbCon, "INSERT INTO `cars` (`carModel`) VALUES(0)", "OnCarCreated", "d", i);
            return i;
		}
	}
	return -1;
}

Car_Delete(carid)
{
    if (carid != -1 && CarData[carid][carExists])
	{
	    new
	        string[64];

		format(string, sizeof(string), "DELETE FROM `cars` WHERE `carID` = '%d'", CarData[carid][carID]);
		mysql_tquery(dbCon, string);

        Total_Cars_Created--;

		if (IsValidVehicle(CarData[carid][carVehicle]))
			TRP_DestroyVehicle(CarData[carid][carVehicle], true);

        CarData[carid][carExists] = false;
	    CarData[carid][carID] = 0;
	    CarData[carid][carOwner] = 0;
	    CarData[carid][carVehicle] = 0;
	    CarData[carid][carDonator] = 0;
	}
	return 1;
}

Car_Save(carid)
{
	new
	    query[1536];

	if (CarData[carid][carExists] && CarData[carid][carOwner] != 0)
	{
		if (CarData[carid][carVehicle] != INVALID_VEHICLE_ID)
		{
		    for (new i = 0; i < 14; i ++) {
				CarData[carid][carMods][i] = GetVehicleComponentInSlot(CarData[carid][carVehicle], i);
		    }
		}

		if(CarData[carid][carImpounded] == -1) { SaveVehicleDamage(CarData[carid][carVehicle]); }
	}
	format(query, sizeof(query), "UPDATE `cars` SET `carModel` = '%d', `carOwner` = '%d', `carPosX` = '%.4f', `carPosY` = '%.4f', `carPosZ` = '%.4f', `carPosR` = '%.4f', `carColor1` = '%d', `carColor2` = '%d', `carPaintjob` = '%d', `carLocked` = '%d'",
        CarData[carid][carModel],
        CarData[carid][carOwner],
        CarData[carid][carPos][0],
        CarData[carid][carPos][1],
        CarData[carid][carPos][2],
        CarData[carid][carPos][3],
        CarData[carid][carColor1],
        CarData[carid][carColor2],
        CarData[carid][carPaintjob],
        CarData[carid][carLocked]
	);
	format(query, sizeof(query), "%s, `carMod1` = '%d', `carMod2` = '%d', `carMod3` = '%d', `carMod4` = '%d', `carMod5` = '%d', `carMod6` = '%d', `carMod7` = '%d', `carMod8` = '%d', `carMod9` = '%d', `carMod10` = '%d', `carMod11` = '%d', `carMod12` = '%d', `carMod13` = '%d', `carMod14` = '%d'",
		query,
		CarData[carid][carMods][0],
		CarData[carid][carMods][1],
		CarData[carid][carMods][2],
		CarData[carid][carMods][3],
		CarData[carid][carMods][4],
		CarData[carid][carMods][5],
		CarData[carid][carMods][6],
		CarData[carid][carMods][7],
		CarData[carid][carMods][8],
		CarData[carid][carMods][9],
		CarData[carid][carMods][10],
		CarData[carid][carMods][11],
		CarData[carid][carMods][12],
		CarData[carid][carMods][13]
	);
	format(query, sizeof(query), "%s, `carFuel` = '%d', `carImpounded` = '%d', `carImpoundPrice` = '%d', `carFaction` = '%d', `carJob` = '%d', `carWeapon1` = '%d', `carWeapon2` = '%d', `carWeapon3` = '%d', `carWeapon4` = '%d', `carWeapon5` = '%d', `carAmmo1` = '%d', `carAmmo2` = '%d', `carAmmo3` = '%d', `carAmmo4` = '%d', `carAmmo5` = '%d'",
		query,
		CarData[carid][carFuel],
		CarData[carid][carImpounded],
		CarData[carid][carImpoundPrice],
		CarData[carid][carFaction],
		CarData[carid][carJob],
		CarData[carid][carWeapons][0],
		CarData[carid][carWeapons][1],
		CarData[carid][carWeapons][2],
		CarData[carid][carWeapons][3],
		CarData[carid][carWeapons][4],
		CarData[carid][carAmmo][0],
		CarData[carid][carAmmo][1],
		CarData[carid][carAmmo][2],
		CarData[carid][carAmmo][3],
		CarData[carid][carAmmo][4]
	);
	format(query, sizeof(query), "%s, `carInsurance` = '%d', `carDamage1` = '%d', `carDamage2` = '%d', `carDamage3` = '%d', `carDamage4` = '%d', `carHealth` = '%f', `carDeathTime` = '%d', `carDestroyed` = '%d', `carLock` = '%d', `carMileage` = '%d', `carGPS` = '%d', `carImmob` = '%d', `carBatteryL` = '%d', `carEngineL` = '%d', `carPlate` = '%s', `carDonator` = '%d', `carRent` = '%d'  WHERE `carID` = '%d'",
		query,
		CarData[carid][carInsurance],
		CarData[carid][carDamage][0],
		CarData[carid][carDamage][1],
		CarData[carid][carDamage][2],
		CarData[carid][carDamage][3],
		CarData[carid][carHealth],
		CarData[carid][carDeathTime],
		CarData[carid][carDestroyed],
		CarData[carid][carLock],
		CarData[carid][carMileage],
		CarData[carid][carGPS],
		CarData[carid][carImmob],
		CarData[carid][carBatteryL],
		CarData[carid][carEngineL],
		CarData[carid][carPlate],
		CarData[carid][carDonator],
		CarData[carid][carRent],
		CarData[carid][carID]
	);
	return mysql_tquery(dbCon, query);
}

forward OnCarCreated(carid);
public OnCarCreated(carid)
{
	if (carid == -1 || !CarData[carid][carExists])
	    return 0;

	CarData[carid][carID] = cache_insert_id();
	FetchVehiclePlate(carid);
	Car_Save(carid);

	return 1;
}

stock Car_Spawn(carid)
{
	if (carid != -1 && CarData[carid][carExists] && CarData[carid][carModel] != 0)
	{
		if (IsValidVehicle(CarData[carid][carVehicle]))
		    TRP_DestroyVehicle(CarData[carid][carVehicle], true);

        if (CarData[carid][carDeathTime] != 0)
			return 1;

		if (CarData[carid][carColor1] == -1)
		    CarData[carid][carColor1] = random(127);

		if (CarData[carid][carColor2] == -1)
		    CarData[carid][carColor2] = random(127);

        CarData[carid][carVehicle] = CreateVehicle(CarData[carid][carModel], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2], CarData[carid][carPos][3], CarData[carid][carColor1], CarData[carid][carColor2], (CarData[carid][carOwner] != 0) ? (-1) : (1200000));

        if (CarData[carid][carVehicle] != INVALID_VEHICLE_ID)
        {
            if (CarData[carid][carPaintjob] != -1)
            {
                ChangeVehiclePaintjob(CarData[carid][carVehicle], CarData[carid][carPaintjob]);
			}
			if (CarData[carid][carLocked])
			{
			    new
					engine, lights, alarm, doors, bonnet, boot, objective;

				GetVehicleParamsEx(CarData[carid][carVehicle], engine, lights, alarm, doors, bonnet, boot, objective);
			    SetVehicleParamsEx(CarData[carid][carVehicle], engine, lights, alarm, 1, bonnet, boot, objective);
			}
			for (new i = 0; i < 14; i ++)
			{
			    AddVehicleComponent(CarData[carid][carVehicle], CarData[carid][carMods][i]);
			    /*if (CarData[carid][carMods][i] && IsLegalComponent(CarData[carid][carVehicle], CarData[carid][carMods][i]))
				{
					AddVehicleComponent(CarData[carid][carVehicle], CarData[carid][carMods][i]);
				}*/
			}

   			if (!IsVehicleImpounded(CarData[carid][carVehicle]) && CarData[carid][carOwner] > 0)
			{
			    SetVehicleDamage(CarData[carid][carVehicle]);
			}

			if (!IsVehicleImpounded(CarData[carid][carVehicle]))
			{
				if(strlen(CarData[carid][carPlate]))
				{
			 		SetVehicleNumberPlate(CarData[carid][carVehicle],CarData[carid][carPlate]);
			 	}
			 	else
			 	{
			 	    FetchVehiclePlate(carid);
			 	}
			}
   			ResetVehicle(CarData[carid][carVehicle]);
			return 1;
		}

	}
	return 0;
}

forward Car_Load();
public Car_Load()
{
	new
	    rows,
		str[128];

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_DYNAMIC_CARS)
	{
	    CarData[i][carExists] = true;
     	cache_get_value_name_int(i, "carID", CarData[i][carID]);
     	cache_get_value_name_int(i, "carModel", CarData[i][carModel]);
     	cache_get_value_name_int(i, "carOwner", CarData[i][carOwner]);
     	cache_get_value_name_float(i, "carPosX", CarData[i][carPos][0]);
     	cache_get_value_name_float(i, "carPosY", CarData[i][carPos][1]);
     	cache_get_value_name_float(i, "carPosZ", CarData[i][carPos][2]);
     	cache_get_value_name_float(i, "carPosR", CarData[i][carPos][3]);
     	cache_get_value_name_int(i, "carColor1", CarData[i][carColor1]);
     	cache_get_value_name_int(i, "carColor2", CarData[i][carColor2]);
     	cache_get_value_name_int(i, "carPaintjob", CarData[i][carPaintjob]);
     	cache_get_value_name_int(i, "carLocked", CarData[i][carLocked]);
     	cache_get_value_name_int(i, "carImpounded", CarData[i][carImpounded]);
     	cache_get_value_name_int(i, "carImpoundPrice", CarData[i][carImpoundPrice]);
      	cache_get_value_name_int(i, "carFaction", CarData[i][carFaction]);
       	cache_get_value_name_int(i, "carJob", CarData[i][carJob]);
        cache_get_value_name_int(i, "carFuel", CarData[i][carFuel]);
        cache_get_value_name_int(i, "carInsurance", CarData[i][carInsurance]);
        cache_get_value_name_int(i, "carDamage1", CarData[i][carDamage][0]);
        cache_get_value_name_int(i, "carDamage2", CarData[i][carDamage][1]);
        cache_get_value_name_int(i, "carDamage3", CarData[i][carDamage][2]);
        cache_get_value_name_int(i, "carDamage4", CarData[i][carDamage][3]);
        cache_get_value_name_float(i, "carHealth", CarData[i][carHealth]);
        cache_get_value_name_int(i, "carDeathTime", CarData[i][carDeathTime]);
        cache_get_value_name_int(i, "carDestroyed", CarData[i][carDestroyed]);
        cache_get_value_name_int(i, "carLock", CarData[i][carLock]);
        cache_get_value_name_int(i, "carMileage", CarData[i][carMileage]);
 		cache_get_value_name_int(i, "carGPS", CarData[i][carGPS]);
 		cache_get_value_name_int(i, "carImmob", CarData[i][carImmob]);
 		cache_get_value_name_int(i, "carBatteryL", CarData[i][carBatteryL]);
 		cache_get_value_name_int(i, "carEngineL", CarData[i][carEngineL]);
		cache_get_value_name(i, "carPlate", CarData[i][carPlate], 32);
  		cache_get_value_name_int(i, "carDonator", CarData[i][carDonator]);
	 	cache_get_value_name_int(i, "carRent", CarData[i][carRent]);

	 	Total_Cars_Created++;

		for (new j = 0; j < 14; j ++)
		{
		    if (j < 5)
		    {
		        format(str, sizeof(str), "carWeapon%d", j + 1);
	         	cache_get_value_name_int(i, str, CarData[i][carWeapons][j]);

		        format(str, sizeof(str), "carAmmo%d", j + 1);
	         	cache_get_value_name_int(i, str, CarData[i][carAmmo][j]);
	        }
	        format(str, sizeof(str), "carMod%d", j + 1);
         	cache_get_value_name_int(i, str, CarData[i][carMods][j]);
	    }
	    Car_Spawn(i);
	}
	/*for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) if (CarData[i][carExists]) {
		format(str, sizeof(str), "SELECT * FROM `carstorage` WHERE `ID` = '%d'", CarData[i][carID]);

		mysql_tquery(dbCon, str, "OnLoadCarStorage", "d", i);
	}*/
	printf("[MYSQL]: %d Cars have been successfully loaded from the database.", Total_Cars_Created);
	return 1;
}

CMD:createcar(playerid, params[])
{
	new
		model[32],
		color1,
		color2,
		id = -1,
		type = 0,
		string[128];

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "s[32]I(-1)I(-1)I(0)", model, color1, color2, type))
 	{
	 	SendClientMessage(playerid, -1, "/createcar [model id/name] [color 1] [color 2] <faction>");
	 	SendClientMessage(playerid, -1, "[TYPES]:{FFFFFF} 1: Police | 2: News | 3: Medical | 4: Government");
	 	return 1;
	}
	if ((model[0] = GetVehicleModelByName(model)) == 0)
	    return SendClientMessage(playerid, -1, "ไอดีโมเดลไม่ถูกต้อง");

	new
	    Float:x,
		Float:y,
		Float:z,
		Float:angle;

    GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	id = Car_Create(0, model[0], x, y, z, angle, color1, color2, type);

	if (id == -1)
	    return SendClientMessage(playerid, -1, "เซิฟเวอร์นี้ได้สร้างยานพาหนะไดนามิคเกินขีดจำกัดแล้ว");

    SetEngineStatus(id, true);
	SetLightStatus(id, true);
    PutPlayerInVehicleEx(playerid, id, 0);
	SetPlayerPosExten(playerid, x, y, z + 2, 1000);
	format(string, sizeof(string), "คุณประสบความสำเร็จในการสร้างยานพาหนะไอดี: %d", CarData[id][carVehicle]);
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:destroycar(playerid, params[])
{
	new
	    id = 0,
	    string[128];

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "d", id))
 	{
	 	if (IsPlayerInAnyVehicle(playerid))
		 	id = GetPlayerVehicleID(playerid);

		else return SendClientMessage(playerid, -1, "/destroycar [vehicle id]");
	}
	if (!IsValidVehicle(id) || Car_GetID(id) == -1)
	    return SendClientMessage(playerid, -1, "คุณระบุไอดียานพาหนะไม่ถูกต้อง");

	Car_Delete(Car_GetID(id));
	format(string, sizeof(string), "คุณประสบความสำเร็จในการทำลายยานพาหนะไอดี: %d", id);
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:editcar(playerid, params[])
{
	new
     	id,
	    type[24],
	    string[128];

	if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendClientMessage(playerid, -1, "/editcar [id] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, faction, job, color1, color2, rent");
	    SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} mileage, lock, destroyed, fuel, insurance, repair, battery, engine");
		return 1;
	}
	if (!IsValidVehicle(id) || Car_GetID(id) == -1)
	    return SendClientMessage(playerid, -1, "คุณระบุไอดียานพาหนะไม่ถูกต้อง");

	id = Car_GetID(id);

	if (!strcmp(type, "location", true))
	{
	    if (GetPlayerVehicleID(playerid) == CarData[id][carVehicle])
	    {
			GetVehiclePos(CarData[id][carVehicle], CarData[id][carPos][0], CarData[id][carPos][1], CarData[id][carPos][2]);
			GetVehicleZAngle(CarData[id][carVehicle], CarData[id][carPos][3]);
		}
		else
		{
	 		GetPlayerPos(playerid, CarData[id][carPos][0], CarData[id][carPos][1], CarData[id][carPos][2]);
			GetPlayerFacingAngle(playerid, CarData[id][carPos][3]);
		}

		Car_Save(id);
		Car_Spawn(id);

		SetPlayerPosExten(playerid, CarData[id][carPos][0], CarData[id][carPos][1], CarData[id][carPos][2] + 2.0, 1000);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับตำแหน่งของพาหนะไอดี: %d", ReturnRealName(playerid, 0), CarData[id][carVehicle]);

	}
	else if (!strcmp(type, "faction", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
     	    SendClientMessage(playerid, -1, "/editcar [id] [faction] [type]");
		 	SendClientMessage(playerid, COLOR_YELLOW, "[TYPES]:{FFFFFF} 1: Police | 2: News | 3: Medical | 4: Government");
		 	return 1;
		}
		if (typeint < 0 || typeint > 4)
		    return SendClientMessage(playerid, -1, "ประเภทที่ระบุต้องไม่ต่ำกว่า 0 หรือมากกว่า 4");

        CarData[id][carJob] = 0;
		CarData[id][carFaction] = typeint;

		Car_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับกลุ่มของยานพาหนะไอดี: %d เป็น %d", ReturnRealName(playerid, 0), CarData[id][carVehicle], typeint);
	}
    else if (!strcmp(type, "color1", true))
	{
	    new color1;

	    if (sscanf(string, "d", color1))
			return SendClientMessage(playerid, -1, "/editcar [id] [color1] [color 1]");

		if (color1 < 0 || color1 > 255)
		    return SendClientMessage(playerid, -1, "สีที่ระบุต้องไม่ต่ำกว่า 0 หรือมากกว่า 255");

		CarData[id][carColor1] = color1;
		ChangeVehicleColor(CarData[id][carVehicle], CarData[id][carColor1], CarData[id][carColor2]);

		Car_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับสีที่ 1 ของยานพาหนะไอดี: %d เป็น %d", ReturnRealName(playerid, 0), CarData[id][carVehicle], color1);
	}
    else if (!strcmp(type, "color2", true))
	{
	    new color2;

	    if (sscanf(string, "d", color2))
			return SendClientMessage(playerid, -1, "/editcar [id] [color2] [color 2]");

		if (color2 < 0 || color2 > 255)
		    return SendClientMessage(playerid, -1, "สีที่ระบุต้องไม่ต่ำกว่า 0 หรือมากกว่า 255");

		CarData[id][carColor2] = color2;
		ChangeVehicleColor(CarData[id][carVehicle], CarData[id][carColor1], CarData[id][carColor2]);

		Car_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับสีที่ 2 ของยานพาหนะไอดี: %d เป็น %d", ReturnRealName(playerid, 0), CarData[id][carVehicle], color2);
	}
	else if (!strcmp(type, "mileage", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
     	    SendClientMessage(playerid, -1, "/editcar [id] [mileage] [number]");
		 	return 1;
		}

        CarData[id][carMileage] = typeint;

		Car_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับจำนวนระยะทางของยานพาหนะไอดี: %d เป็น %d", ReturnRealName(playerid, 0), CarData[id][carVehicle], typeint);
	}
	else if (!strcmp(type, "lock", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
     	    SendClientMessage(playerid, -1, "/editcar [id] [lock] [type]");
		 	SendClientMessage(playerid, COLOR_YELLOW, "[TYPES]:{FFFFFF} 0-4");
		 	return 1;
		}
		if (typeint < 0 || typeint > 4)
		    return SendClientMessage(playerid, -1, "ประเภทที่ระบุต้องไม่ต่ำกว่า 0 หรือมากกว่า 4");

        CarData[id][carLock] = typeint;

		Car_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับระบบล็อคของยานพาหนะไอดี: %d เป็น %d", ReturnRealName(playerid, 0), CarData[id][carVehicle], typeint);
	}
	else if (!strcmp(type, "destroyed", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
     	    SendClientMessage(playerid, -1, "/editcar [id] [destroyed] [number]");
		 	return 1;
		}

        CarData[id][carDestroyed] = typeint;

		Car_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับจำนวนครั้งที่เสียหายของยานพาหนะไอดี: %d เป็น %d", ReturnRealName(playerid, 0), CarData[id][carVehicle], typeint);
	}
	else if (!strcmp(type, "fuel", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
     	    SendClientMessage(playerid, -1, "/editcar [id] [fuel] [number]");
		 	return 1;
		}

        CarData[id][carFuel] = typeint;

		Car_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับน้ำมันของยานพาหนะไอดี: %d เป็น %d", ReturnRealName(playerid, 0), CarData[id][carVehicle], typeint);
	}
	else if (!strcmp(type, "battery", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
     	    SendClientMessage(playerid, -1, "/editcar [id] [battery] [number]");
		 	return 1;
		}

        CarData[id][carBatteryL] = typeint;

		Car_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับแบตเตอรี่ของยานพาหนะไอดี: %d เป็น %d", ReturnRealName(playerid, 0), CarData[id][carVehicle], typeint);
	}
	else if (!strcmp(type, "engine", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
     	    SendClientMessage(playerid, -1, "/editcar [id] [engine] [number]");
		 	return 1;
		}

        CarData[id][carEngineL] = typeint;

		Car_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับเครื่องยนต์ของยานพาหนะไอดี: %d เป็น %d", ReturnRealName(playerid, 0), CarData[id][carVehicle], typeint);
	}
	else if (!strcmp(type, "rent", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
     	    SendClientMessage(playerid, -1, "/editcar [id] [rent] [0 = ไม่เปิดให้เช่า | 1 = เปิดให้เช่า]");
		 	return 1;
		}

		if (typeint < 0 || typeint > 1)
		    return SendClientMessage(playerid, -1, "ประเภทที่ระบุต้องไม่ต่ำกว่า 0 หรือ 1");

        CarData[id][carRent] = typeint;

		Car_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับ Rent ยานพาหนะไอดี: %d เป็น %d", ReturnRealName(playerid, 0), CarData[id][carVehicle], typeint);
	}
	else if (!strcmp(type, "immob", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
     	    SendClientMessage(playerid, -1, "/editcar [id] [immob] [number]");
		 	return 1;
		}

        CarData[id][carImmob] = typeint;

		Car_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับการป้องกันการต่อสายตรงของยานพาหนะไอดี: %d เป็น %d", ReturnRealName(playerid, 0), CarData[id][carVehicle], typeint);
	}
	else if (!strcmp(type, "repair", true))
	{
		if(GetVehicleDriver(CarData[id][carVehicle]) != INVALID_PLAYER_ID)
			SetPVarInt(GetVehicleDriver(CarData[id][carVehicle]), "VehicleRepair", 1);

	    RepairVehicleEx(CarData[id][carVehicle]);
		Car_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ซ่อมยานพาหนะไอดี: %d", ReturnRealName(playerid, 0), CarData[id][carVehicle]);
	}
	else if (!strcmp(type, "insurance", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
     	    SendClientMessage(playerid, -1, "/editcar [id] [insurance] [number]");
		 	return 1;
		}

        CarData[id][carInsurance] = typeint;

		Car_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับประกันภัยของยานพาหนะไอดี: %d เป็น %d", ReturnRealName(playerid, 0), CarData[id][carVehicle], typeint);
	}
	return 1;
}
