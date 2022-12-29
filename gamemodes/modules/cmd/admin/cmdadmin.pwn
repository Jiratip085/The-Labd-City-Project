CMD:hospital(playerid, params[])
{
    if (Account[playerid][Admin] < 1334)
	    return 1;


 	SetPlayerPos(playerid,-204.5060,-1736.0486,675.7687);
    SetPlayerInterior(playerid, 3);
    return 1;
}

CMD:debugdead(playerid, params[])
{
    new
	    userid;

    if (Account[playerid][Admin] < 1334)
	    return 1;

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid,-1, "/debugdead [playerid/name]");

    if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid,-1, "ผู้เล่นที่ระบุไม่ถูกต้อง");

	AC_SetPlayerHealth(userid, 100);

	ClearAnimations(userid);
	ResetDamages(userid);
	Character[userid][Injured] = 0;
	Character[userid][InjuredTime] = 0;
	Character[userid][InjuredEx]= 0;
	Character[userid][InjuredSpawn] = 0;
	Character[userid][InjuredShoot] = 0;
	return 1;
}


CMD:payday(playerid, params[])
{
    if (Account[playerid][Admin] < 1339)
	    return 1;

    SetTimer("Payday", 1000, false);
    return 1;
}

CMD:checkid(playerid, params[])
{
    if (Character[playerid][Admin] < 1337)
	    return 1;

    SendClientMessageEx(playerid, -1, "%d", Character[playerid][ID]);
    return 1;
}

CMD:checkrankhouse(playerid, params[])
{
    if (Account[playerid][Admin] < 1337)
	    return 1;

    new
	    houseid = -1;

    if ((houseid = House_Inside(playerid)) != -1 && (House_IsOwner(playerid, houseid) || GetFactionType(playerid) == FACTION_POLICE)) {
	    SendClientMessageEx(playerid, -1, "Rank: %d", HouseData[houseid][houseRank]);
	}
	return 1;
}

CMD:checkplayer(playerid, params[])
{
    new
	    userid,
	    string[128];

    if (Account[playerid][Admin] < 1335)
	    return 1;

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, -1, "/checkplayer [playerid/name]");

    if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, -1, "ผู้เล่นที่ระบุไม่ถูกต้อง");

    if(!IsPlayerConnected(userid))
		return SendClientMessage(playerid, -1, "ผู้เล่นนั้นยังไม่ได้ล็อคอิน!");

	ShowStatsForPlayer(playerid, userid);
	format(string, sizeof(string), "คุณกำลังดูสถิติของ %s", ReturnRealName(userid, 0));
 	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:checkafk(playerid, params[])
{

	if(Account[playerid][Admin] < 1334)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาติให้ใช้คำสั่งนี้!");

	foreach (new i : Player)
	{

		if(GetTickCount() > (Character[i][PauseCheck]+2000))
			SendClientMessageEx(playerid, COLOR_GREY, "ผู้เล่น %s ได้ AFK เป็นเวลา %i วินาที!", ReturnName(i), Character[i][PauseTime]);

		//else SendClientMessageEx(playerid, COLOR_GREY, "ผู้เล่น %s ไม่ได้ AFK.", ReturnName(i));

	}
	return 1;
}

CMD:checkminutes(playerid, params[])
{
	new
	    string[128];

    if(Account[playerid][Admin] < 1336)
		return 1;

    format(string, sizeof(string), "Minutes : %d", Character[playerid][Minutes]);
	SendClientMessage(playerid, -1, string);

	return 1;
}

CMD:setminutes(playerid, params[])
{
    if(Account[playerid][Admin] < 1338)
		return 1;

	Character[playerid][Minutes] = 60;
	return 1;
}

CMD:jetpack(playerid, params[])
{
	new userid;

	if (Account[playerid][Admin] < 1339)
	    return SystemMsg(playerid, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "u", userid))
 	{
 	    Character[playerid][Jetpack] = 1;
	 	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	}
	else
	{
		Character[userid][Jetpack] = 1;

		SetPlayerSpecialAction(userid, SPECIAL_ACTION_USEJETPACK);
		SendClientMessageEx(playerid, -1,"คุณได้สร้าง Jetpack ให้ %s", ReturnName(userid, 0));
	}
	return 1;
}

CMD:jesus(playerid, params[])
{
	if (Account[playerid][Admin] < 1337)
	    return SystemMsg(playerid, "คุณไม่ได้รับอนุญาติให้ใช้คำสั่งนี้");

	if(flying[playerid] == 0)
	{
		flying[playerid] = 1;
 		new Float:x, Float:y, Float:z;
   		GetPlayerPos(playerid, x, y, z);
    	SetPlayerHealth(playerid, 1000000000.0);
	    SetTimerEx("IronMan", 100, 0, "d", playerid);
	    SetTimerEx("DestroyMe", 500, 0, "d",     CreateDynamicObject(2780, x, y, z - 3.0, 0.0, 0.0, 0.0));
        SendClientMessage(playerid, -1, "I want to fly!");
	}
	else if(flying[playerid] == 1)
	{
		flying[playerid] = 0;
		new Float:x, Float:y, Float:z;
   		GetPlayerPos(playerid, x, y, z);
    	SetPlayerHealth(playerid, 100.0);
	    SetTimerEx("IronMan", 100, 0, "d", playerid);
	    SetTimerEx("DestroyMe", 500, 0, "d",     CreateDynamicObject(2780, x, y, z - 3.0, 0.0, 0.0, 0.0));
        //SendClientMessage(playerid, -1, "I want to fly!");
	}
	return 1;
}

CMD:hackcomp(playerid, params[])
{
	new
		vehicleid = GetPlayerVehicleID(playerid);

	if(Account[playerid][Admin] < 1338)
		return SendClientMessage(playerid, -1, "ไม่อนุญาติให้ใช้คำสั่งนี้");

	if (GetVehicleModel(vehicleid) != 525)
		return SendClientMessage(playerid, COLOR_WHITE, "คุณไม่ได้อยู่บน Towtruck");

	CoreVehicles[vehicleid][vehComponent] = 300;
	return 1;
}

CMD:givegun(playerid, params[])
{
	new
	    userid,
	    weaponid,
	    ammo;

    if (Account[playerid][Admin] < 1336)
	    return 1;

	if (sscanf(params, "udI(1)", userid, weaponid, ammo))
	    return SystemMsg(playerid, "/givegun [playerid/name] [weaponid] [ammo]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid,-1, "คุณไม่สามารถให้อาวุธกับผู้เล่นที่ตัดการเชื่อมต่อได้");

	if (weaponid <= 0 || weaponid > 46 || (weaponid >= 19 && weaponid <= 21))
		return SendClientMessage(playerid,-1, "คุณระบุอาวุธไม่ถูกต้อง");



	return 1;
}

CMD:asellbiz(playerid, params[])
{
	new bizid = -1;

	if (Account[playerid][Admin] < 1337)
	    return SendClientMessage(playerid, -1,"คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "d", bizid))
	    return SystemMsg(playerid, "/asellbiz [business ID]");

	if ((bizid < 0 || bizid >= MAX_BUSINESSES) || !BusinessData[bizid][bizExists])
	    return SendClientMessage(playerid, -1, "คุณระบุไอดีธุรกิจไม่ถูกต้อง");

	BusinessData[bizid][bizOwner] = 0;

	Business_Refresh(bizid);
	Business_Save(bizid);

	SendClientMessageEx(playerid, -1, "คุณขายธุรกิจไอดี: %d", bizid);
	return 1;
}

CMD:near(playerid, params[])
{
	new
	    id = -1,
	    string[128];

    if (Account[playerid][Admin] < 1337)
	    return 1;

	if ((id = Field_Nearest(playerid)) != -1)
	{
    	format(string, sizeof(string), "คุณกำลังยืนอยู่ใกล้ที่ดินไอดี: %d", id);
		SendClientMessage(playerid, -1, string);
	}

    if ((id = Entrance_Nearest(playerid)) != -1)
	{
    	format(string, sizeof(string), "คุณกำลังยืนอยู่ใกล้ทางเข้าไอดี: %d", id);
		SendClientMessage(playerid, -1, string);
	}
	if ((id = Job_Nearest(playerid)) != -1)
	{
	    format(string, sizeof(string), "คุณกำลังยืนอยู่ใกล้งานไอดี : %d", id);
		SendClientMessage(playerid, -1, string);
	}
	if ((id = Product_Nearest(playerid)) != -1)
	{
	    format(string, sizeof(string), "คุณกำลังยืนอยู่ใกล้คลังสินค้าไอดี : %d", id);
		SendClientMessage(playerid, -1, string);
	}

	if ((id = Pump_Nearest(playerid)) != -1)
	{
	    format(string, sizeof(string), "คุณกำลังยืนอยู่ใกล้ปั้มไอดี: %d", id);
		SendClientMessage(playerid, -1, string);
	}

	if ((id = Business_Nearest(playerid)) != -1)
	{
	    format(string, sizeof(string), "คุณกำลังยืนอยู่ใกล้ธุรกิจไอดี: %d (DBID: %d)", id, BusinessData[id][bizID]);
		SendClientMessage(playerid, -1, string);
	}

	if ((id = House_Nearest(playerid)) != -1)
	    SendClientMessageEx(playerid, -1, "คุณกำลังยืนอยู่ใกล้บ้านไอดี: %d (DBID: %d)", id, HouseData[id][houseID]);

    if ((id = Food_Nearest(playerid)) != -1)
	    SendClientMessageEx(playerid, -1, "คุณกำลังยืนอยู่ใกล้ร้านอาหารไอดี: %d (DBID: %d)", id, FoodData[id][foodID]);

	return 1;
}

CMD:gotoint(playerid, params[])
{
	if(Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาติให้ใช้คำสั่งนี้!");

 	new
  		str[1536];

	str[0] = '\0';
	for (new i = 0; i < sizeof(g_arrInteriorData); i ++) {
		strcat(str, g_arrInteriorData[i][e_InteriorName]);
		strcat(str, "\n");
  	}
   	Dialog_Show(playerid, TeleportInterior, DIALOG_STYLE_LIST, "Teleport: Interior List", str, "Select", "Cancel");
	return 1;
}

CMD:gotocar(playerid, params[])
{
	new vehicleid;

    if (Account[playerid][Admin] < 1335)
	    return 1;

	if (sscanf(params, "d", vehicleid))
	    return SystemMsg(playerid, "/gotocar [veh]");

	if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
		return SendClientMessage(playerid, -1, "คุณระบุไอดียานพาหนะไม่ถูกต้อง");

	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetVehiclePos(vehicleid, x, y, z);
	SetPlayerPosEx(playerid, x, y - 2, z + 2, GetPlayerInterior(playerid),GetPlayerVirtualWorld(playerid));

	return 1;
}

CMD:gotobusiness(playerid, params[])
{
    new
	    id;

    if (Account[playerid][Admin] < 1335)
	    return 1;

    if (sscanf(params, "d", id))
    	return SystemMsg(playerid, "/goto [business ID]");

	if ((id < 0 || id >= MAX_BUSINESSES) || !BusinessData[id][bizExists])
 		return SendClientMessage(playerid, -1, "คุณระบุ Business ID ไม่ถูกต้อง");

	SetPlayerPosEx(playerid, BusinessData[id][bizPos][0], BusinessData[id][bizPos][1], BusinessData[id][bizPos][2],BusinessData[id][bizExterior],BusinessData[id][bizExteriorVW]);
 	SendClientMessageEx(playerid, -1, "คุณได้เคลื่อนย้ายไปที่ Business ID: %d (DBID: %d)", id, BusinessData[id][bizID]);
	return 1;
}

CMD:gotofood(playerid, params[])
{
    new
	    id;

    if (Account[playerid][Admin] < 1335)
	    return 1;

    if (sscanf(params, "d", id))
    	return SendClientMessage(playerid, -1, "/goto [food ID]");

	if ((id < 0 || id >= MAX_DYNAMIC_FOODS) || !FoodData[id][foodExists])
 		return SendClientMessage(playerid, -1, "คุณระบุ House ID ไม่ถูกต้อง");

	SetPlayerPosEx(playerid, FoodData[id][foodPos][0], FoodData[id][foodPos][1], FoodData[id][foodPos][2], FoodData[id][foodInterior], FoodData[id][foodWorld]);
 	SendClientMessageEx(playerid, -1, "คุณได้เคลื่อนย้ายไปที่ Food ID: %d (DBID: %d)", id, FoodData[id][foodID]);
	return 1;
}

CMD:gotofield(playerid, params[])
{
    new
	    id;

    if (Account[playerid][Admin] < 1335)
	    return 1;

    if (sscanf(params, "d", id))
    	return SendClientMessage(playerid, -1, "/gotofield [field ID]");

	if ((id < 0 || id >= MAX_FIELDS) || !FieldData[id][fieldExists])
 		return SendClientMessage(playerid, -1, "คุณระบุ Field ID ไม่ถูกต้อง");

	SetPlayerPosEx(playerid, FieldData[id][fieldPos][0], FieldData[id][fieldPos][1], FieldData[id][fieldPos][2], FieldData[id][fieldInterior], FieldData[id][fieldWorld]);
 	SendClientMessageEx(playerid, -1, "คุณได้เคลื่อนย้ายไปที่ Field ID: %d (DBID: %d)", id, FieldData[id][fieldID]);
	return 1;
}

CMD:gotohouse(playerid, params[])
{
    new
	    id;

    if (Account[playerid][Admin] < 1335)
	    return 1;

    if (sscanf(params, "d", id))
    	return SendClientMessage(playerid, -1, "/goto [house ID]");

	if ((id < 0 || id >= MAX_HOUSES) || !HouseData[id][houseExists])
 		return SendClientMessage(playerid, -1, "คุณระบุ House ID ไม่ถูกต้อง");

	SetPlayerPosEx(playerid, HouseData[id][housePos][0], HouseData[id][housePos][1], HouseData[id][housePos][2], HouseData[id][houseExterior], HouseData[id][houseExteriorVW]);
 	SendClientMessageEx(playerid, -1, "คุณได้เคลื่อนย้ายไปที่ House ID: %d (DBID: %d)", id, HouseData[id][houseID]);
	return 1;
}

CMD:gotojob(playerid, params[])
{
    new
	    id;

    if (Account[playerid][Admin] < 1335)
	    return 1;

    if (sscanf(params, "d", id))
    	return SendClientMessage(playerid, -1, "/goto [job ID]");

	if ((id < 0 || id >= MAX_DYNAMIC_JOBS) || !JobData[id][jobExists])
 		return SendClientMessage(playerid, -1, "คุณระบุ Job ID ไม่ถูกต้อง");

	SetPlayerPosEx(playerid, JobData[id][jobPos][0], JobData[id][jobPos][1], JobData[id][jobPos][2], JobData[id][jobInterior], JobData[id][jobWorld]);
 	SendClientMessageEx(playerid, -1, "คุณได้เคลื่อนย้ายไปที่ Job ID: %d", id);
	return 1;
}

CMD:gotoentrance(playerid, params[])
{
    new
	    id;

    if (Account[playerid][Admin] < 1335)
	    return 1;

    if (sscanf(params, "d", id))
    	return SendClientMessage(playerid, -1, "/goto [entrance ID]");

	if ((id < 0 || id >= MAX_ENTRANCES) || !EntranceData[id][entranceExists])
 		return SendClientMessage(playerid, -1, "คุณระบุ Entrance ID ไม่ถูกต้อง");

	SetPlayerPosEx(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2], EntranceData[id][entranceExterior], EntranceData[id][entranceExteriorVW]);
 	SendClientMessageEx(playerid, -1, "คุณได้เคลื่อนย้ายไปที่ Entrance ID: %d", id);
	return 1;
}

CMD:getcar(playerid, params[])
{
	new vehicleid;

    if (Account[playerid][Admin] < 1336)
	    return 1;

	if (sscanf(params, "d", vehicleid))
	    return SystemMsg(playerid, "/getcar [veh]");

	if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
		return SendClientMessage(playerid, -1, "คุณระบุไอดียานพาหนะไม่ถูกต้อง");

	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(playerid, x, y, z);
	SetVehiclePosEx(vehicleid, x + 2, y - 2, z);

 	SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
	LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));

	return 1;
}

CMD:entercar(playerid, params[])
{
	new vehicleid, seatid;

    if (Account[playerid][Admin] < 1336)
	    return 1;

	if (sscanf(params, "d", vehicleid))
	    return SystemMsg(playerid, "/entercar [veh]");

	if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
		return SendClientMessage(playerid, -1, "คุณระบุไอดียานพาหนะไม่ถูกต้อง");

	seatid = GetAvailableSeat(vehicleid, 0);

	if (seatid == -1)
	    return SendClientMessage(playerid, -1, "ไม่มีที่นั่งเหลือที่จะเข้าไป");

	PutPlayerInVehicleEx(playerid, vehicleid, seatid);
	return 1;
}

CMD:bizstate(playerid, params[])
{
	new
	    id = 0,
		string[128];

    if (Account[playerid][Admin] < 1338)
	    return 1;

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, -1, "/bizstate [biz id]");

	if ((id < 0 || id >= MAX_BUSINESSES) || !BusinessData[id][bizExists])
	    return SendClientMessage(playerid, -1, "คุณระบุไอดีธุรกิจไม่ถูกต้อง");

	BusinessData[id][bizOwner] = 99999999;

	Business_Refresh(id);
	Business_Save(id);

    format(string, sizeof(string), "ธุรกิจนี้เป็นเจ้าของโดยรัฐ (/bizcmds)", id);
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:housevars(playerid,params[])
{

    if (Account[playerid][Admin] > 1337)
    {
		new houseid, str[128];
		if (sscanf(params, "d", houseid))
			return SendClientMessage(playerid, -1, "/housevars [houseid]");

		if (houseid != -1 && HouseData[houseid][houseExists])
		{
            SendClientMessage(playerid,COLOR_WHITE,"|---------House Info----------|");
	        format(str,sizeof(str),"ID:[%d] HID:[%d] Owner:[%d] Owner Name:[%s] Price:[%d] Address:[%s]",
            houseid,
			HouseData[houseid][houseID],
	        HouseData[houseid][houseOwner],
	        HouseData[houseid][houseOwner] ? GetIDFromName(HouseData[houseid][houseOwner]) : ("State"),
	        HouseData[houseid][housePrice],
	        HouseData[houseid][houseAddress]);
	        SendClientMessage(playerid,COLOR_WHITE,str);
		}
		else
		{

		    SendClientMessage(playerid, -1,"บ้านหลังนี้ไม่สามารถดูข้อมูลได้");
		    return 1;

		}

	}
	else
	{
	    SendClientMessage(playerid, -1,"คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");
	    return 1;

	}
	return 1;
}

CMD:bizvars(playerid,params[])
{

    if (Account[playerid][Admin] > 1337)
    {
		new bizid, str[128];
		if (sscanf(params, "d", bizid))
			return SendClientMessage(playerid, -1, "/bizvars [biz id]");

		if (bizid != -1 && BusinessData[bizid][bizExists])
		{
            SendClientMessage(playerid,COLOR_WHITE,"|---------Business Info----------|");
	        format(str,sizeof(str),"ID:[%d] BID:[%d] Owner:[%d] Owner Name:[%s] Price:[%d] Vault:[%d] Products:[%d]",
            bizid,
			BusinessData[bizid][bizID],
	        BusinessData[bizid][bizOwner],
	        (BusinessData[bizid][bizOwner] > 0 && BusinessData[bizid][bizOwner] != 99999999) ? GetIDFromName(BusinessData[bizid][bizOwner]) : ("State"),
	        BusinessData[bizid][bizPrice],
	        BusinessData[bizid][bizVault],
			BusinessData[bizid][bizProducts]);
	        SendClientMessage(playerid,COLOR_WHITE,str);
		}
		else
		{

		    SendClientMessage(playerid, -1,"ธุรกิจนี้ไม่สามารถดูข้อมูลได้");
		    return 1;

		}

	}
	else
	{
	    SendClientMessage(playerid, -1,"คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");
	    return 1;

	}
	return 1;
}

CMD:carvars(playerid,params[])
{

    if (Account[playerid][Admin] > 1337)
    {

		new vehicleid;
		if (sscanf(params, "d", vehicleid))
			return SystemMsg(playerid, "/carvars [vehicleid]");


        new slot = Car_GetID(vehicleid);

        if(slot > -1)
        {
	        new str[128];
	        new engineon = (GetEngineStatus(vehicleid)) ? 1 :0;

	        SendClientMessage(playerid,COLOR_WHITE,"|---------Vehicle Stats----------|");
	        format(str,sizeof(str),"VID:[%d] Model:[%d] Color1:[%d] Color2:[%d] Owner:[%d] Owner Name:[%s] ID:[%d] Donator:[%d]",
	        CarData[slot][carID],
	        CarData[slot][carModel],
	        CarData[slot][carColor1],
	        CarData[slot][carColor2],
	        CarData[slot][carOwner],
	        CarData[slot][carOwner] ? GetIDFromName(CarData[slot][carOwner]) : ("None"),
	        CarData[slot][carVehicle],
			CarData[slot][carDonator]);
	        SendClientMessage(playerid,COLOR_WHITE,str);
	        format(str,sizeof(str),"Fuel:[%d] Mileage:[%d] Insurance:[%d] Lock:[%d] Locked:[%d] Destroyed:[%d]",
	        CarData[slot][carFuel],
	        CarData[slot][carMileage],
	        CarData[slot][carInsurance],
	        CarData[slot][carLock],
	        CarData[slot][carLocked],
	        CarData[slot][carDestroyed]);
	        SendClientMessage(playerid,COLOR_WHITE,str);
	        format(str,sizeof(str),"Faction:[%d] Job:[%d] Paintjob:[%d] Engine:[%d] Battery Life:[%d] Engine Life:[%d] Plate:[%s]",
	        CarData[slot][carFaction],
	        CarData[slot][carJob],
	        CarData[slot][carPaintjob],
			engineon,
			CarData[slot][carBatteryL],
			CarData[slot][carEngineL],
			CarData[slot][carPlate]);
	        SendClientMessage(playerid,COLOR_WHITE,str);
			return 1;

		}
		else
		{

		    SendClientMessage(playerid, -1, "พาหนะคันนี้ไม่สามารถดูข้อมูลได้");
		    return 1;

		}

	}
	else
	{

	    SendClientMessage(playerid, -1,"คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");
	    return 1;

	}

}

CMD:alock(playerid, params[])
{
	new
	    id = -1;

	if ( Account[playerid][Admin] <= 0)
	    return 1;

	if ( IsPlayerInAnyVehicle(playerid) ? ((id = Car_GetID(GetPlayerVehicleID(playerid))) != -1) : ((id = Car_Nearest(playerid)) != -1) )
	{
		new
		    engine,
		    lights,
		    alarm,
		    doors,
		    bonnet,
		    boot,
		    objective;

		GetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, doors, bonnet, boot, objective);

		if (!CarData[id][carLocked])
		{
				CarData[id][carLocked] = true;
				Car_Save(id);

				ShowPlayerFooter(playerid, "You have ~r~locked~w~ the vehicle!");
				PlayerPlaySoundEx(playerid, 24600);

				SetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, 1, bonnet, boot, objective);
		}
		else
		{
				CarData[id][carLocked] = false;
				Car_Save(id);

				ShowPlayerFooter(playerid, "You have ~g~unlocked~w~ the vehicle!");
				PlayerPlaySoundEx(playerid, 24600);

				SetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, 0, bonnet, boot, objective);
		}

	}

	else if (!IsPlayerInAnyVehicle(playerid) && (id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1)
	{
		if (!BusinessData[id][bizLocked])
		{
			BusinessData[id][bizLocked] = true;

			Business_Refresh(id);
			Business_Save(id);

			ShowPlayerFooter(playerid, "You have ~r~locked~w~ the business!");
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
		}
		else
		{
			BusinessData[id][bizLocked] = false;

			Business_Refresh(id);
			Business_Save(id);

			ShowPlayerFooter(playerid, "You have ~g~unlocked~w~ the business!");
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
		}
	}

	else SendClientMessage(playerid, -1, "คุณไม่ได้อยู่ในขอบเขตของอะไรก็ตามที่ล็อคได้");
	return 1;
}

CMD:givecar(playerid, params[])
{
	new
		userid,
	    model[32],
	    string[128];

    if (Account[playerid][Admin] < 1338)
	    return 1;

	if (sscanf(params, "us[32]", userid, model))
	    return SendClientMessage(playerid, -1, "/givecar [playerid/name] [modelid/name]");

	if (Car_GetCount(userid) >= MAX_OWNABLE_CARS)
	    return SendClientMessage(playerid, -1, "ผู้เล่นนี้เป็นเจ้าของยานพาหนะจนเต็มแล้ว");

    if ((model[0] = GetVehicleModelByName(model)) == 0)
	    return SendClientMessage(playerid, -1, "รุ่นไม่ถูกต้อง");

	new
	    Float:x,
		Float:y,
		Float:z,
		Float:angle,
		id = -1;

    GetPlayerPos(userid, x, y, z);
	GetPlayerFacingAngle(userid, angle);

	id = Car_Create(Character[userid][ID], model[0], x, y + 2, z + 1, angle, random(127), random(127), 0);

	if (id == -1)
	    return SendClientMessage(playerid, -1, "เซิฟเวอร์นี้ได้สร้างยานพาหนะไดนามิคเกินขีดจำกัดแล้ว");

    format(string, sizeof(string), "คุณได้สร้างยานพาหนะไอดี: %d สำหรับ %s", CarData[id][carVehicle], ReturnName(userid, 0));
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:dvehs(playerid, params[])
{
    if (Account[playerid][Admin] < 1334)
	    return 1;

    for (new i = 1; i != MAX_VEH; i ++) if (IsValidVehicle(i) && CoreVehicles[i][vehTemporary])
	{
 		CoreVehicles[i][vehTemporary] = false;

		TRP_DestroyVehicle(i);
  		ResetVehicle(i);
    }
   	SendClientMessage(playerid, -1, "คุณได้ทำลายยานพาหนะผู้ดูแลทั้งหมด");
    return 1;
}

CMD:dveh(playerid, params[])
{
    if (Account[playerid][Admin] < 1334)
	    return 1;

	if (IsPlayerInAnyVehicle(playerid))
	{
	    new vehicleid = GetPlayerVehicleID(playerid);

	    if (CoreVehicles[vehicleid][vehTemporary])
		{
	        CoreVehicles[vehicleid][vehTemporary] = false;
	        TRP_DestroyVehicle(vehicleid);

	        ResetVehicle(vehicleid);
	        SendClientMessage(playerid, -1, "คุณได้ทำลายยานพาหนะผู้ดูแล");
		}
		else
		{
		    SendClientMessage(playerid, -1, "คุณไม่สามารถทำลายยานพาหนะที่ไม่ชั่วคราวได้");
		}
	}
	return 1;
}

CMD:fixveh(playerid, params[])
{
	if (Account[playerid][Admin] < 1334)
		return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาติให้ใช้คำสั่งนี้!");

	new
		vehicleid,
		Float:angle;

	if(sscanf(params, "i", vehicleid))
		return SendClientMessage(playerid, -1, "/arepair [vehicle id]");

	if(!IsValidVehicle(vehicleid))
		return SendClientMessage(playerid, -1, "You specified an invalid vehicle.");

	SendClientMessage(playerid, -1, "Fixed veh");

	RepairVehicle(vehicleid);
	SetVehicleHealth(vehicleid, 900);

	GetVehicleZAngle(vehicleid, angle);
	SetVehicleZAngle(vehicleid, angle);
	return 1;
}

CMD:veh(playerid, params[])
{
	new
	    model[32],
		color1,
		color2;

    if (Account[playerid][Admin] < 1336)
	    return 1;

	if (sscanf(params, "s[32]I(-1)I(-1)", model, color1, color2))
	    return SendClientMessage(playerid, -1, "/veh [model id/name] <color 1> <color 2>");

	if ((model[0] = GetVehicleModelByName(model)) == 0)
	    return SendClientMessage(playerid, -1, "ไอดีรุ่นไม่ถูกต้อง");

	new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:a,
		vehicleid,
		string[128];

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);

	vehicleid = CreateVehicle(model[0], x, y + 2, z, a, color1, color2, 0);

	if (GetPlayerInterior(playerid) != 0)
	    LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));

	if (GetPlayerVirtualWorld(playerid) != 0)
		SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));

	if (IsABoat(vehicleid) || IsAPlane(vehicleid) || IsAHelicopter(vehicleid))
	    PutPlayerInVehicleEx(playerid, vehicleid, 0);

	ResetVehicle(vehicleid);
	SetEngineStatus(vehicleid, true);
	SetLightStatus(vehicleid, true);

    PutPlayerInVehicleEx(playerid, vehicleid, 0);
	CoreVehicles[vehicleid][vehTemporary] = true;
	format(string, sizeof(string), "คุณได้สร้างยานพาหนะชั่วคราว %s (%d, %d)", ReturnVehicleModelName(model[0]), color1, color2);
 	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:gethere(playerid, params[])
{
	new
		userid;

	if (Account[playerid][Admin] < 1334)
	    return 1;

	if (sscanf(params, "u", userid))
 	{
	 	SendClientMessage(playerid,-1, "/gethere [player or name]");
		return 1;
	}

	if (userid == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, -1, "ไอดีผู้เล่นไม่ถูกต้อง");

	SendPlayerToPlayer(userid, playerid);
	return 1;
}

CMD:goto(playerid, params[])
{
	new
	    id;

	if (Account[playerid][Admin] < 1334)
	    return 1;

	if (sscanf(params, "u", id))
 	{
	 	SendClientMessage(playerid,-1, "/goto [player or name]");
		return 1;
	}

    if (id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, -1, "ไอดีผู้เล่นไม่ถูกต้อง");

	SendPlayerToPlayer(playerid, id);
	return 1;
}

CMD:makeleader(playerid, params[])
{
	new
		userid,
		id,
		string[128];

    if (Account[playerid][Admin] < 1337)
	    return 1;

	if (sscanf(params, "ud", userid, id))
	    return SystemMsg(playerid, "/makeleader [playerid/name] [faction id] (Use -1 to unset)");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, -1, "ผู้เล่นที่ระบุไม่ถูกต้อง");

    if ((id < -1 || id >= MAX_FACTIONS) || (id != -1 && !FactionData[id][factionExists]))
	    return SendClientMessage(playerid, -1, "คุณระบุไอดีฝ่ายหรือกลุ่มไม่ถูกต้อง");

	if (id == -1)
	{
     	ResetFaction(userid);
		Character[userid][Spawn] = 1;
        format(string, sizeof(string), "คุณได้ลบ %s ออกจากผู้นำ Faction", ReturnRealName(userid, 0));
 		SendClientMessage(playerid, -1, string);

 		format(string, sizeof(string), "%s ได้ลบคุณออกจากผู้นำ Faction", ReturnRealName(playerid, 0));
 		SendClientMessage(userid, -1, string);
	}
	else
	{
	    Character[userid][Spawn] = 2;
		SetFaction(userid, id);
		Character[userid][FactionRank] = FactionData[id][factionRanks];

        format(string, sizeof(string), "คุณได้ทำให้ %s เป็นผู้นำของ \"%s\"", ReturnRealName(userid, 0), FactionData[id][factionName]);
 		SendClientMessage(playerid, -1, string);

 		format(string, sizeof(string), "%s ได้ทำให้คุณเป็นผู้นำของ \"%s\"", ReturnRealName(playerid, 0), FactionData[id][factionName]);
 		SendClientMessage(userid, -1, string);
	}
    return 1;
}

CMD:achangeapassword(playerid,params[])
{
	new name[32],password[64], query[260], escapepass[129];
	if(Account[playerid][Admin] >= 1338)
	{
		if(sscanf(params, "s[32]s[32]", name, password)) return SendClientMessage(playerid, COLOR_GRAY, "/achangeapassword [Master Account Name] [New Password]");
		{
			if(strlen(password) > 5 && strlen(password) < 24)
			{
				WP_Hash(escapepass, sizeof(escapepass), password);
			    mysql_format(dbCon, query, sizeof(query), "UPDATE Accounts SET Password = '%s' WHERE Username = '%s' LIMIT 1", escapepass, name);
				mysql_tquery(dbCon, query);
				SendClientMessage(playerid, COLOR_LGREEN, "You have successfully changed the account's password, keep it safe.");
			}
		    else
		    {
		    	SendErrorMessage(playerid, "Your password needs longer than 5 characters but less than 24!");
		    }
		}
	}
	else
	{
		SendErrorMessage(playerid, ERROR_ADMIN);
	}
	return 1;
}


CMD:changecname(playerid,params[])
{

	if(Account[playerid][Admin] >= 1338)
	{
		new player, NewName[64];
		if(sscanf(params, "us[32]", player, NewName)) return SendClientMessage(playerid, COLOR_GRAY, "/changecname [playerid] [New Name]");
		{
			MYSQL_Update_String(Character[player][ID], "Characters", "Name", NewName);
			SetPlayerName(player, NewName);
			SendClientMessage(playerid, COLOR_LGREEN, "You have successfully changed the character's name.");

		}
	}
	else
	{
		SendErrorMessage(playerid, ERROR_ADMIN);
	}
	return 1;
}

CMD:flip(playerid,params[])
{
	if(Account[playerid][Admin] >= 1334)
	{
	    new str[128], vID = GetPlayerVehicleID(playerid);
	    if(GetPlayerVehicleID(playerid))
	    {
			new Float:angle;
	        GetVehicleZAngle(vID, angle);
	        SetVehicleZAngle(vID, angle);
			format(str, sizeof(str), "%s has flipped vehicle %d.", GetRoleplayName(playerid), vID);
	    	SendAdminsMessage(6, COLOR_SLATEGRAY, str);
	    }
	}
	else
	{
	    SendErrorMessage(playerid, ERROR_ADMIN);
	}
    return 1;
}


CMD:reloadobjects(playerid, params[])
{
    if(Account[playerid][Admin] >= 1338)
	{
		ReloadObjects();
	}
	return 1;
}

CMD:createobject(playerid, params[])
{
    if(Account[playerid][Admin] >= 1338)
	{
	    new option1, option2[64], query[280], Float:pos[3], oint, oworld;
	    if(sscanf(params, "ds[64]", option1, option2)) return SendClientMessage(playerid, COLOR_GRAY, "/createobject [modelid] [info]");
		{
		    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		    GetInFrontOfPlayer(playerid, pos[0], pos[1], 1);
		    oint = GetPlayerInterior(playerid);
		    oworld = GetPlayerVirtualWorld(playerid);
			new fID = CreateDynamicObject(option1, pos[0], pos[1], pos[2], 0, 0, 0, oworld, oint, -1, 200.0, 0.0);
		    mysql_format(dbCon, query, sizeof(query), "INSERT INTO Objects (Name,Model,PosX,PosY,PosZ,World,Interior) VALUES ('%s', %d, %f, %f, %f, %d, %d)",
									option2,
									option1,
									pos[0],
									pos[1],
									pos[2],
									oworld,
									oint);

			mysql_tquery(dbCon, query, "GetObjectID", "i", fID);

            Objects[fID][ObjectID] = fID;
			Objects[fID][PosX] = pos[0];
			Objects[fID][PosY] = pos[1];
			Objects[fID][PosZ] = pos[2];
			Objects[fID][AngX] = 0;
			Objects[fID][AngY] = 0;
			Objects[fID][AngZ] = 0;
			Objects[fID][Model] = option1;
			Objects[fID][Interior] = oint;
			Objects[fID][World] = oworld;
			format(Objects[fID][Name], 64, "%s", option2);

			Total_Objects_Created++;
			SendClientMessage(playerid, COLOR_GRAY, "Model Created");
		}
	}
	return 1;
}

CMD:deleteobject(playerid, params[])
{
	if(Account[playerid][Admin] >= 1338)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "คำเตือน: หากคุณต้องการจะลบ Object ให้ใช้เมาส์คลิกที่ Object ที่ต้องการลบจากนั้นกดปุ่ม Save หรือกด ESC.");
     	Character[playerid][DeleteingObject] = 1;
     	SelectObject(playerid);
	}
	else
	{
	    SendErrorMessage(playerid, ERROR_ADMIN);
	}
	return 1;
}

CMD:selectobject(playerid, params[])
{
    if(Account[playerid][Admin] >= 1338)
	{
	    new option1[24];
	    if(sscanf(params, "s[24]", option1)) return SendClientMessage(playerid, COLOR_GRAY, "/selectobject [mouse/near]");
		{
	 		if(!strcmp(option1, "mouse", true))
			{
	    		SelectObject(playerid);
	        }

	 		if(!strcmp(option1, "near", true))
			{
			    for(new i = 1; i < MAX_OBJECTZ;i++)
			    {
					if(IsPlayerInRangeOfPoint(playerid, 2.0, Objects[i][PosX], Objects[i][PosY], Objects[i][PosZ]))
					{
					    EditDynamicObject(playerid, Objects[i][ObjectID]);
					    return 1;
					}
			    }
	        }
		}
	}
	else
	{
		SendErrorMessage(playerid, ERROR_ADMIN);
	}
	return 1;
}
ALTCMD:selecto->selectobject;

ALTCMD:an->announcement;
CMD:announcement(playerid, params[])
{
	if (Account[playerid][Admin] < 1334)
	    return SendClientMessage(playerid, -1, "คุณไม่ใช่ผู้ดูแลระบบ");

	if (isnull(params))
	    return SystemMsg(playerid, "/announce [ข้อความ]");

    if (strlen(params) > 64)
	{
        foreach (new i : Player) {
		    SendClientMessageEx(i, 0xBDBDBDFF, "{FF3300}[Administrator] :{FFFFFF}  %.64s",  params);
		    SendClientMessageEx(i, 0xBDBDBDFF, "{FFFFFF}...%s", params[64]);
		}
	}
	else
	{
        foreach (new i : Player) {
		    SendClientMessageEx(i, 0xBDBDBDFF, "{FF3300}[Administrator] :{FFFFFF} %s.",  params);
		}
	}
	return 1;
}
ALTCMD:announce->announcement;

CMD:acmds(playerid, params[])
{
	if(Account[playerid][Admin] == 0) return SendErrorMessage(playerid, ERROR_ADMIN);
	if(Account[playerid][Admin] >= 1334)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "คำสั่งแอดมิน:");
		SendClientMessage(playerid, COLOR_GRAY, "ADMIN LVL 1334: /goto, /get, /adminduty, /kick, /ban, /(un)freeze, /(down)slap, /(un)mute, /(announce)ment, /reports, /flip, /arepair");
	}
	if(Account[playerid][Admin] >= 1335)
	{
		SendClientMessage(playerid, COLOR_GRAY, "ADMIN LVL 1335: /carvars, /gotocar, /getcar, /entercar, /setarmor");
	}
	if(Account[playerid][Admin] >= 1336)
	{
		SendClientMessage(playerid, COLOR_GRAY, "ADMIN LVL 1336: /veh, /givegun");
	}
	if(Account[playerid][Admin] >= 1337)
	{
		SendClientMessage(playerid, COLOR_GRAY, "ADMIN LVL 1337: /makeleader, /settime");
	}
	if(Account[playerid][Admin] >= 1338)
	{
		SendClientMessage(playerid, COLOR_GRAY, "ADMIN LVL 1338: /gotoint");
		SendClientMessage(playerid, COLOR_GRAY, "CMD: /factioncmds, /carcmds, /pumpcmds, /businesscmds, /entrancecmds, /jobcmds, /productcmds");
		SendClientMessage(playerid, COLOR_GRAY, "CMD: /housecmds, /foodcmds, /objectcmds, /fieldcmds,/changecname, /achangeapassword");
	}
	if(Account[playerid][Admin] >= 1339)
	{
		SendClientMessage(playerid, COLOR_GRAY, "ADMIN LVL 1339: /restart");
	}

	return 1;
}
ALTCMD:ah->acmds;

CMD:productcmds(playerid, params[])
{
    if(Account[playerid][Admin] >= 1338)
	{
		SendClientMessage(playerid, COLOR_GREY, "[Productcmds]: /createproduct, /editproduct, /destroyproduct");
	}
	return 1;
}

CMD:jobcmds(playerid, params[])
{
    if(Account[playerid][Admin] >= 1338)
	{
		SendClientMessage(playerid, COLOR_GREY, "[Jobcmds]: /createjob, /editjob, /destroyjob, /gotojob");
	}
	return 1;
}

CMD:entrancecmds(playerid, params[])
{
    if(Account[playerid][Admin] >= 5)
	{
		SendClientMessage(playerid, COLOR_GREY, "[Entrancecmds]: /createentrance, /viewentrances, /editentrance, /destroyentrance, /gotoentrance");
	}
	return 1;
}

CMD:objectcmds(playerid, params[])
{
    if(Account[playerid][Admin] >= 1338)
	{
		SendClientMessage(playerid, COLOR_GREY, "[Objectcmds]: /createobject, /selectobject, /deleteobject, /reloadobjects");
	}
	return 1;
}

CMD:factioncmds(playerid, params[])
{
    if(Account[playerid][Admin] >= 1338)
	{
		SendClientMessage(playerid, COLOR_GREY, "[Factioncmds]: /createfaction, /destroyfaction, /editfaction");
	}
	return 1;
}

CMD:businesscmds(playerid, params[])
{
    if(Account[playerid][Admin] >= 1338)
	{
		SendClientMessage(playerid, COLOR_GREY, "[Bizcmds]: /createbiz, /destroybiz, /editbiz, /asellbiz, /alock, /gotobusiness, /bizvars");
		SendClientMessage(playerid, COLOR_GREY, "[Bizcmds]: /bizstate");
	}
	return 1;
}

CMD:foodcmds(playerid, params[])
{
    if(Account[playerid][Admin] >= 5)
	{
		SendClientMessage(playerid, COLOR_GREY, "[Foodcmds]: /createfood, /editfood, /destroyfood, /gotofood");
	}
	return 1;
}

CMD:housecmds(playerid, params[])
{
    if(Account[playerid][Admin] >= 1338)
	{
		SendClientMessage(playerid, COLOR_GREY, "[Housecmds]: /createhouse, /destroyhouse, /edithouse, /gotohouse, /alock, /housevars");
	}
	return 1;
}

CMD:pumpcmds(playerid, params[])
{
    if(Account[playerid][Admin] >= 1338)
	{
		SendClientMessage(playerid, COLOR_GREY, "[Pumpcmds]: /createpump, /setpump, /destroypump");
	}
	return 1;
}

CMD:fieldcmds(playerid, params[])
{
    if(Account[playerid][Admin] >= 1338)
	{
		SendClientMessage(playerid, COLOR_GREY, "[Fieldcmds]: /createfield, /editfield, /destroyfield, /gotofield");
	}
	return 1;
}

CMD:carcmds(playerid, params[])
{
    if(Account[playerid][Admin] >= 1338)
	{
		SendClientMessage(playerid, COLOR_GREY, "[Carcmds]: /createcar, /destroycar, /editcar, /givecar, /carvars");
	}
	return 1;
}

CMD:restart(playerid, params[])
{
	new time;

	if (Account[playerid][Admin] < 1339)
	    return SendClientMessage(playerid, -1, "คุณไม่สามารถใช้คำสั่งนี้ได้!");

	if (g_ServerRestart)
	{
	    TextDrawHideForAll(RestartTextdraws[0]);

	    g_ServerRestart = 0;
	    g_RestartTime = 0;

	    return SendClientMessageToAllEx(COLOR_WHITE, "{FF0000}[SERVER]:{FFCC00}ยกเลิกการรีเซิฟเวอร์!");
	}
	if (sscanf(params, "d", time))
	    return SendClientMessage(playerid, -1, "/restart [seconds]");

	if (time < 3 || time > 600)
	    return SendClientMessage(playerid, -1, "ไม่ต่ำกว่า 3 หรือมากกว่า 600");

    TextDrawShowForAll(RestartTextdraws[0]);

	g_ServerRestart = 1;
	g_RestartTime = time;

	SendClientMessageToAllEx(COLOR_WHITE, "{FF0000}[SERVER]:{FFCC00}เซิฟเวอร์ได้เริ่มนับถอยหลังเพื่อรีเซิฟเวอร์!", ReturnName(playerid, 0));
	return 1;
}

CMD:settime(playerid,params[])
{
	if(Account[playerid][Admin] >= 1337)
	{
	    new time,str[128];
		if(sscanf(params, "d",time)) return SendClientMessage(playerid, COLOR_GRAY, "/settime [hour]");
		if(time < 0 || time >24)return SendClientMessage(playerid, COLOR_GRAY, "/settime [0-24]");
        	else if(time <= 24 && time >= 0)
	        {
	            ClockHours = time;
	            SetWorldTime(time);
	            format(str, sizeof(str), "%s:{FFFFFF} Set Time %d", GetRoleplayName(playerid),time);
				SendAdminsMessage(1, COLOR_ORANGERED, str);
	        }
  	}
	else
	{
	    SendErrorMessage(playerid, ERROR_ADMIN);
	}
	return 1;
}


CMD:kick(playerid, params[])
{
	if(Account[playerid][Admin] >= 1334)
	{

        new pID, str[128], reason[128];
		if(sscanf(params, "uS(Not specified)[128]", pID,reason)) return SendClientMessage(playerid, COLOR_GRAY, "/kick [ID/Name] [reason]");
	    if(Account[pID][Admin] >= 1334 && Account[playerid][Admin] != 1339)
		{
			SendErrorMessage(playerid, "You can't kick admins.");
			return 1;
		}
		format(str, sizeof(str), "Admin %s ได้เตะ %s ออกจากเซิฟเวอร์ | เนื่องจาก: %s", GetRoleplayName(playerid), GetRoleplayName(pID), reason);
		SendPunishmentMessage(str);
		Character[pID][Kicks] ++;
		KickPlayer(pID);

 	}
	else
	{
	    SendErrorMessage(playerid, ERROR_ADMIN);
	}
	return 1;
}

CMD:ban(playerid, params[])
{
	if(Account[playerid][Admin] >= 1334)
	{
        new pID, str[128], reason[128];
		if(sscanf(params, "uS(Not specified)[128]", pID,reason)) return SendClientMessage(playerid, COLOR_GRAY, "/ban [id] [reason]");
		if(Character[pID][Admin] >= 1334  && Account[playerid][Admin] != 1339)
		{
			SendClientMessage(playerid, COLOR_RED, "You can't ban admins.");
		}
		else
		{
			format(str, sizeof(str), "Admin %s ได้แบนผู้เล่น %s | เนื่องจาก: %s", Account[playerid][Name], GetRoleplayName(pID), reason);
			SendPunishmentMessage(str);
			IssueBan(pID, Account[playerid][Name], reason);
		}

 	}
	else
	{
	    SendErrorMessage(playerid, ERROR_ADMIN);
	}

	return 1;
}

CMD:toggleooc(playerid, params[])
{
	new str[128];
	if(Account[playerid][Admin] >= 1336)
	{
		if(OOCStatus == 0)
	    {
			OOCStatus = 1;
	     	format(str, sizeof(str), "Admin %s ได้เปิดช่องแชท OOC!", GetRoleplayName(playerid));
	     	SendClientMessageToAll(COLOR_YELLOW, str);
	    }
	    else
	    {
			OOCStatus = 0;
   			format(str, sizeof(str), "Admin %s ได้ปิดช่องแชท OOC.", GetRoleplayName(playerid));
	     	SendClientMessageToAll(COLOR_YELLOW, str);
	    }
	}
	else
	{
	    SendErrorMessage(playerid, ERROR_ADMIN);
	}
	return 1;
}

CMD:mute(playerid, params[])
{
	new str[128], pID, astr[128];
	if(Account[playerid][Admin] >= 1334)
	{
	    if(sscanf(params, "u", pID)) return SystemMsg(playerid, "/mute [id]");
	    format(str, sizeof(str), "Admin %s has muted %s.", GetRoleplayName(playerid), GetRoleplayName(pID));
	    SendClientMessageToAll(COLOR_GRAY, str);
	    Character[pID][Muted] = 1;
	    format(astr, sizeof(astr), "%s has muted %s!", GetRoleplayName(playerid), GetRoleplayName(pID));
		SendAdminsMessage(1, COLOR_RED, astr);
	}
	else
	{
		SendErrorMessage(playerid, ERROR_ADMIN);

	}
	return 1;
}

CMD:unmute(playerid, params[])
{
	new str[128], pID, astr[128];
	if(Account[playerid][Admin] >= 1334)
	{
	    if(sscanf(params, "u", pID)) return SystemMsg(playerid, "/unmute [id]");
	    format(str, sizeof(str), "Admin %s has unmuted you.", GetRoleplayName(playerid));
	    SendClientMessage(pID, COLOR_RED, str);
	    Character[pID][Muted] = 0;
 	    format(astr, sizeof(astr), "%s has unmuted %s!", GetRoleplayName(playerid), GetRoleplayName(pID));
		SendAdminsMessage(1, COLOR_RED, astr);
	}
	else
	{
		SendErrorMessage(playerid, ERROR_ADMIN);

	}
	return 1;
}

CMD:freeze(playerid, params[])
{
	new pID, str[128];
	if(Account[playerid][Admin] >= 1334)
	{
	    if(sscanf(params, "u", pID)) return SystemMsg(playerid, "/freeze [id]");
		TogglePlayerControllable(pID, 0);
		format(str, sizeof(str), "%s:{FFFFFF} Freeze %s", GetRoleplayName(playerid), GetRoleplayName(pID));
		SendAdminsMessage(1, COLOR_RED, str);
	}
	else
	{
	    SendErrorMessage(playerid, ERROR_ADMIN);
	}
	return 1;
}

CMD:unfreeze(playerid, params[])
{
	new pID, str[128];
	if(Account[playerid][Admin] >= 1334)
	{
	    if(sscanf(params, "u", pID)) return SystemMsg(playerid, "/unfreeze [id]");
		TogglePlayerControllable(pID, 1);
		format(str, sizeof(str), "%s:{FFFFFF} Unfreeze %s", GetRoleplayName(playerid), GetRoleplayName(pID));
		SendAdminsMessage(1, COLOR_RED, str);
	}
	else
	{
	    SendErrorMessage(playerid, ERROR_ADMIN);
	}
	return 1;
}



CMD:slap(playerid, params[])
{
	new pID, str[128],Float:px, Float:py, Float:pz;
	if(Account[playerid][Admin] >= 1334)
	{
	    if(sscanf(params, "u", pID)) return SystemMsg(playerid, "/slap [id]");
	    PlayerPlaySound(playerid, 1130, 0.0, 0.0, 10.0);
		if(!IsPlayerInAnyVehicle(pID))
		{
			GetPlayerPos(pID, px, py, pz);
			SetPlayerPos(pID, px, py, pz+5);
			format(str, sizeof(str), "Admin %s has slapped you.", GetRoleplayName(playerid));
			SendClientMessage(pID, COLOR_SEAGREEN, str);
		}
		else if(IsPlayerInAnyVehicle(pID))
		{
			new Float:pos[3];
			GetVehicleVelocity(GetPlayerVehicleID(pID), pos[0], pos[1], pos[2]);
			SetVehicleVelocity(GetPlayerVehicleID(pID), pos[0], pos[1], pos[2] + 0.2);
			format(str, sizeof(str), "Admin %s has slapped you.", GetRoleplayName(playerid));
			SendClientMessage(pID, COLOR_SEAGREEN, str);
		}

	}
	else
	{
	    SendErrorMessage(playerid, ERROR_ADMIN);
	}
	return 1;
}

CMD:downslap(playerid, params[])
{
	new pID, str[128],Float:px, Float:py, Float:pz;
	if(Account[playerid][Admin] >= 1334)
	{
	    if(sscanf(params, "u", pID)) return SendClientMessage(playerid, COLOR_GRAY, "/downslap [id]");
		GetPlayerPos(pID, px, py, pz);
		SetPlayerPos(pID, px, py, pz-5);
		format(str, sizeof(str), "Admin %s has just slapped you.", GetRoleplayName(playerid));
		SendClientMessage(pID, COLOR_SEAGREEN, str);
	}
	else
	{
	    SendErrorMessage(playerid, ERROR_ADMIN);
	}
	return 1;
}

CMD:saveall(playerid, params[])
{
    if (Account[playerid][Admin] < 1338)
	    return 1;

	foreach (new i : Player) {
		Character_Save(i);
	}

	for (new i = 0; i < MAX_DYNAMIC_CARS; i ++)
		Car_Save(i);


	for(new i = 0; i < MAX_BUSINESSES; i++)
		Business_Save(i);

	SendClientMessage(playerid,-1,"data save");
	return 1;
}
/*
CMD:offspec(playerid, params[]) 
{
	if(Character[playerid][Spectating] != INVALID_PLAYER_ID && Account[playerid][Admin] >= 1 || GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) 
	{
		Character[playerid][Spectating] = INVALID_PLAYER_ID;
		SetPlayerColor(playerid, COLOR_WHITE);
		TogglePlayerSpectating(playerid, false);
		SetPlayerPosEx(playerid, Character[playerid][PosX], Character[playerid][PosY], Character[playerid][PosZ],Character[playerid][Interior], Character[playerid][VWorld]);
		SetCameraBehindPlayer(playerid);

		TextDrawHideForPlayer(playerid, textdrawVariables[0]);
		return 1;
	}
}*/

CMD:spec(playerid, params[]) {
    if(Account[playerid][Admin] >= 1334) {
        new
            userID;

		if(sscanf(params, "u", userID)) {
		    return SendClientMessage(playerid, COLOR_GREY, "/spec [ไอดีผู้เล่น]");
		}
		else if(!IsPlayerConnectedEx(userID)) {
		    return SendClientMessage(playerid, COLOR_GREY, "ไอดีผู้เล่นที่คุณระบุ ไม่ได้เชื่อต่อกับเซิฟเวอร์");
		}
		else {
			if(Character[playerid][Spectating] == INVALID_PLAYER_ID) { // Will only save pos/etc if they're NOT spectating. This will stop the annoying death/pos/int/VW/crash bugs everyone's experiencing...
				GetPlayerPos(playerid, Character[playerid][PosX], Character[playerid][PosY], Character[playerid][PosZ]);
    			Character_Save(playerid);
				Character[playerid][Interior] = GetPlayerInterior(playerid);
				Character[playerid][VWorld] = GetPlayerVirtualWorld(playerid);
				Character[playerid][Skin] = GetPlayerSkin(playerid);

				if(Character[playerid][AdminDuty] == 0)
				{
					GetPlayerHealth(playerid, Character[playerid][Health]);
					GetPlayerArmour(playerid, Character[playerid][Armour]);
				}
		    }
		    Character[playerid][Spectating] = userID;
		    TogglePlayerSpectating(playerid, true);
            SetPlayerColor(playerid, COLOR_WHITE);
			SetPlayerInterior(playerid, GetPlayerInterior(userID));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(userID));

		    if(IsPlayerInAnyVehicle(userID)) {
		        PlayerSpectateVehicle(playerid, GetPlayerVehicleID(userID));
		    }
		    else {
				PlayerSpectatePlayer(playerid, userID);
  			}

			TextDrawShowForPlayer(playerid, textdrawVariables[0]);
		}
	}
	return 1;
}

CMD:setattach(playerid, params[])
{
    if(Account[playerid][Admin] >= 1339)
	{
		new slot, bone;
		if(sscanf(params, "dd", slot, bone))
			SendClientMessage(playerid, COLOR_GREY, "/setattach [objectid] [bone]");


	    SetPlayerAttachedObject(playerid, 4, slot, bone);
	}
  	return 1;
}

CMD:editattach(playerid, params[])
{
    if(Account[playerid][Admin] >= 1339)
	{
		new slot;
		if(sscanf(params, "d", slot))
			SendClientMessage(playerid, COLOR_GREY, "/editattach [slot]");


		SetPVarInt(playerid, "AttachEdit", 1);
	  	EditAttachedObject(playerid, slot);
	}

  	return 1;
}

CMD:adminduty(playerid, params[]) {
	new
	    string[128];

	if(Account[playerid][Admin] >= 1334)
	{
		{
		    switch(Account[playerid][AdminDuty]) {
				case 0: {
				    Account[playerid][AdminDuty] = 1;
					/*if(!isnull(Account[playerid][pAdminName])) {
					SetPlayerName(playerid, Account[playerid][pAdminName]);*/

					SetPlayerHealth(playerid, 999.0);
					SetPVarInt(playerid, "AdminProtect", 1);
					format(string, sizeof(string), "{FF9500}[ADMIN]{FFFFFF} %s ได้ปฏิบัติหน้าที่เป็นผู้ดูแลระบบในขณะนี้", ReturnName(playerid));
				}
				case 1: {
				    Account[playerid][AdminDuty] = 0;
				    SetPlayerHealth(playerid, 100.0);
					/*if(!isnull(Account[playerid][pUsername])) {
					SetPlayerName(playerid, Account[playerid][pUsername]);*/
					SetPVarInt(playerid, "AdminProtect", 0);
					format(string, sizeof(string), "{FF9500}[ADMIN]{FFFFFF} %s ได้ออกจากการปฏิบัติหน้าที่ผู้ดูแลระบบ", ReturnName(playerid));
				}
			}
			SendAdminAlert(COLOR_LIGHTRED, string);
		}
	}
	return 1;
}
ALTCMD:aduty->adminduty;

CMD:reports(playerid, params[])
{
	if(Account[playerid][Admin] >= 1334)
	{
		new
			tool[16];

		if(sscanf(params, "s[16] ", tool))
		{
		    SendClientMessage(playerid, COLOR_GREY, "/reports [tool]");
		    SendClientMessage(playerid, COLOR_GREY, "Tools: List(l), Accept(a), Disregard(d), Status");
		}
		else
		{
		    if(strcmp(tool, "list", true) == 0)
			{
				SendClientMessage(playerid, COLOR_WHITE, "-------------------------------------------------------------------------------------------------------------------------------");

		        new
					string[128],
					reportCount;

		        foreach(new i: Player)
				{
		            if(Character[i][Report] >= 1)
					{
		                format(string, sizeof(string), "[ACTIVE] %s [%d] รายงานว่า: %s", ReturnName(i, 0), i, Character[i][ReportMessage]);
		                SendClientMessage(playerid, 0xFF0066AA , string);
		                reportCount++;
		            }
		        }

		        format(string, sizeof(string), "ACTIVE REPORTS: %d (ใช้ /reports ยืนยัน)", reportCount);
		        SendClientMessage(playerid, -1 , string);

				SendClientMessage(playerid, COLOR_WHITE, "-------------------------------------------------------------------------------------------------------------------------------");
		    }
		    else if(strcmp(tool, "l", true) == 0)
			{
				SendClientMessage(playerid, COLOR_WHITE, "-------------------------------------------------------------------------------------------------------------------------------");

		        new
					string[128],
					reportCount;

		        foreach(new i: Player)
				{
		            if(Character[i][Report] >= 1)
					{
		                format(string, sizeof(string), "[ACTIVE] %s [%d] รายงานว่า: %s", ReturnName(i, 0), i, Character[i][ReportMessage]);
		                SendClientMessage(playerid, 0xFF0066AA , string);
		                reportCount++;
		            }
		        }

		        format(string, sizeof(string), "ACTIVE REPORTS: %d (ใช้ /reports ยืนยัน)", reportCount);
		        SendClientMessage(playerid, -1 , string);

				SendClientMessage(playerid, COLOR_WHITE, "-------------------------------------------------------------------------------------------------------------------------------");
		    }
		    else if(strcmp(tool, "accept", true) == 0)
		    {
		        new
					userID;

		        if(sscanf(params, "s[16]u", tool, userID))
				{
		            SendClientMessage(playerid, COLOR_GREY, "/reports accept [playerid]");
		        }
		        else
				{
		            if(!IsPlayerConnected(userID))
					{
		                SendClientMessage(playerid, COLOR_GREY, "The specified player ID is either not connected or has not authenticated.");
		            }
		            else
		            {
		                if(Character[userID][Report] >= 1)
						{
		                    new

								string[128];

		                    format(string, sizeof(string), "คุณยืนยันรายงานของ (%d)%s (%s)", userID, ReturnName(userID, 0), Character[userID][ReportMessage]);
		                    SendClientMessage(playerid, COLOR_WHITE, string);

		                    Character[userID][Report] = 0;
		                    format(Character[userID][ReportMessage], 64, "(null)");

							if(Account[playerid][Admin] >= 1334)
							{
		                    	format(string, sizeof(string), "ขอบคุณสำหรับรายงาน! ผู้ดูแล %s ได้ยืนยันรายงานของคุณแล้ว", ReturnName(playerid, 0));
							}
							SendClientMessage(userID, 0xFF0066AA , string);

		                    SetPVarInt(playerid, "aR", 1);
		                    SetPVarInt(playerid, "aRf", userID);

		                    SendAdminAlert(0xFF0066AA, "%s ได้ยืนยันรายงานของ %s ", ReturnName(playerid, 0), ReturnName(userID, 0));

		                    //ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_LIST, "Report System", "วาร์ป\nส่อง\nไม่กระทำใด ๆ", "Select", "Exit");
		                }
		                else {
		                    SendClientMessage(playerid, COLOR_GREY, "That player doesn't have an active report.");
		                }
		            }
		        }
		    }
		    else if(strcmp(tool, "a", true) == 0)
		    {
		        new
					userID;

		        if(sscanf(params, "s[16]u", tool, userID))
				{
		            SendClientMessage(playerid, COLOR_GREY, "/reports accept [playerid]");
		        }
		        else
				{
		            if(!IsPlayerConnected(userID))
					{
		                SendClientMessage(playerid, COLOR_GREY, "The specified player ID is either not connected or has not authenticated.");
		            }
		            else
		            {
		                if(Character[userID][Report] >= 1)
						{
		                    new

								string[128];

		                    format(string, sizeof(string), "คุณยืนยันรายงานของ %s (%s)", ReturnName(userID, 0), Character[userID][ReportMessage]);
		                    SendClientMessage(playerid, COLOR_WHITE, string);

		                    Character[userID][Report] = 0;
		                    format(Character[userID][ReportMessage], 64, "(null)");

							if(Account[playerid][Admin] >= 1334)
							{
		                    	format(string, sizeof(string), "ขอบคุณสำหรับรายงาน! ผู้ดูแล %s ได้ยืนยันรายงานของคุณแล้ว", ReturnName(playerid, 0));
							}
							SendClientMessage(userID, 0xFF0066AA , string);

		                    SetPVarInt(playerid, "aR", 1);
		                    SetPVarInt(playerid, "aRf", userID);

                            SendAdminAlert(0xFF0066AA, "%s ได้ยืนยันรายงานของ %s ", ReturnName(playerid, 0), ReturnName(userID, 0));
		                    //ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_LIST, "Report System", "วาร์ป\nส่อง\nไม่กระทำใด ๆ", "Select", "Exit");
		                }
		                else {
		                    SendClientMessage(playerid, COLOR_GREY, "That player doesn't have an active report.");
		                }
		            }
		        }
		    }
		    else if(strcmp(tool, "disregard", true) == 0)
			{
		        new
					userID,
					string[128];

		        if(sscanf(params, "s[16]u", tool, userID))
				{
		            SendClientMessage(playerid, COLOR_GREY, "/reports disregard [playerid]");
		        }
		        else
				{
		            if(!IsPlayerConnected(userID)) {
		                SendClientMessage(playerid, COLOR_GREY, "The specified player ID is either not connected or has not authenticated.");
		            }
		            else
					{
		                if(Character[userID][Report] != 0)
						{
		                    Character[userID][Report] = 0;
		                    format(Character[userID][ReportMessage], 64, "(null)");

		                    format(string, sizeof(string), "คุณปฏิเสธรายงานของ %s", ReturnName(userID, 0));
		                    SendClientMessage(playerid, 0xFF0066AA , string);

		                    SendAdminAlert(0xFF0066AA, "%s ได้ปฏิเสธรายงานของ %s ", ReturnName(playerid, 0), ReturnName(userID, 0));
		                }
		                else
						{
		                    SendClientMessage(playerid, COLOR_GREY, "That player doesn't have an active report.");
		                }
		            }
		        }
		    }
		    else if(strcmp(tool, "d", true) == 0)
			{
		        new
					userID,
					string[128];

		        if(sscanf(params, "s[16]u", tool, userID))
				{
		            SendClientMessage(playerid, COLOR_GREY, "/reports disregard [playerid]");
		        }
		        else
				{
		            if(!IsPlayerConnected(userID)) {
		                SendClientMessage(playerid, COLOR_GREY, "The specified player ID is either not connected or has not authenticated.");
		            }
		            else
					{
		                if(Character[userID][Report] != 0)
						{
		                    Character[userID][Report] = 0;
		                    format(Character[userID][ReportMessage], 64, "(null)");

		                    format(string, sizeof(string), "คุณปฏิเสธรายงานของ %s", ReturnName(userID, 0));
		                    SendClientMessage(playerid, 0xFF0066AA , string);

		                    SendAdminAlert(0xFF0066AA, "%s ได้ปฏิเสธรายงานของ %s ", ReturnName(playerid, 0), ReturnName(userID, 0));
		                }
		                else
						{
		                    SendClientMessage(playerid, COLOR_GREY, "That player doesn't have an active report.");
		                }
		            }
		        }
		    }
		    else if(strcmp(tool, "status", true) == 0) {
		        if(Account[playerid][Admin] >= 1337) {
			        if(systemVariables[reportSystem] == 0) {
			            systemVariables[reportSystem] = 1;
			            SendClientMessage(playerid, COLOR_WHITE, "คุณได้ยกเลิกระบบ Report");
			            SendClientMessageToAll(COLOR_YELLOW, "ระบบ Report ถูกยกเลิก");
			        }
			        else {
			            systemVariables[reportSystem] = 0;
			            SendClientMessage(playerid, COLOR_WHITE, "คุณเปิดใช้ระบบ Report");
			            SendClientMessageToAll(COLOR_YELLOW, "ระบบ Report ถูกเปิดใช้อีกครั้ง");
			        }
		        }
		        else {
					return SendClientMessage(playerid, COLOR_GREY, "You need to be a Head Administrator or above to use this command.");
				}
 		    }
		    else {
			    SendClientMessage(playerid, COLOR_GREY, "/reports [tool]");
			    SendClientMessage(playerid, COLOR_GREY, "TOOLS: List, Accept, Disregard, Status");
		    }
		}
	}

	return 1;
}

CMD:setplayerspawn(playerid, params[])
{
    new
	    userid;

    if (Account[playerid][Admin] < 1335)
	    return 1;

	if (sscanf(params, "u", userid))
	    return SystemMsg(playerid, "/setplayerspawn [playerid/name]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid,-1, "ผู้เล่นที่ระบุไม่ถูกต้อง");

	SetDefaultSpawn(userid);
	return 1;
}

CMD:setplayer(playerid, params[])
{
	new player, option1[24], option2;
	if(Account[playerid][Admin] > 1337)
	{
        if(sscanf(params, "us[12]d", player, option1, option2))
        {
            SystemMsg(playerid, "/setplayer [id] [option] [value]");
            SystemMsg(playerid, "level, exp, skin, world, interior, age, gender");
            SystemMsg(playerid, "bank, cash, admin, thirsty, hungry, hp, armour");
            return 1;
        }

		if(Account[player][Admin] > Account[playerid][Admin])
			return SendErrorMessage(playerid, ERROR_ADMINLEVEL);

		if(IsPlayerConnected(player))
		{
        	if(player != INVALID_PLAYER_ID)
			{

			    if(!strcmp(option1, "level", true))
				{
					if (Account[playerid][Admin] >= 1339)
					{
		                SetPlayerScore(player, option2);
						Character[player][Level] = option2;
						MYSQL_Update_Character(player, option1, option2);
						SendSetMessages(player, playerid, option1, option2);
						return 1;
				    }
				    else
			    	{
				    	SendErrorMessage(playerid, ERROR_ADMIN);
			    	}
				}

			    else if(!strcmp(option1, "hp", true))
				{
					if (Account[playerid][Admin] >= 1337)
					{
						SetPlayerHealth(player, option2);
						Character[player][Health] = option2;
                        MYSQL_Update_Character(player, option1, option2);
					    SendSetMessages(player, playerid, option1, option2);
					}
				}

			    else if(!strcmp(option1, "armour", true))
				{
					if (Account[playerid][Admin] >= 1337)
					{
						SetPlayerArmour(player, option2);
						Character[player][Armour] = option2;
						MYSQL_Update_Character(player, option1, option2);
					    SendSetMessages(player, playerid, option1, option2);
					}
				}

				else if(!strcmp(option1, "exp", true))
				{
				    if (Account[playerid][Admin] > 1339)
					{
						Character[player][Exp] = option2;
						MYSQL_Update_Character(player, option1, option2);
						SendSetMessages(player, playerid, option1, option2);
						return 1;
			        }
				}

			    else if(!strcmp(option1, "skin", true))
				{
				    if (Account[playerid][Admin] >= 1336)
					{
						if(option2 < 0)
						{
							SendClientMessage(playerid, COLOR_GREY, "ไม่สามารถต่ำกว่า 0");
							return 1;
						}
						else
						{
				        	SetPlayerSkinEx(player, option2);
							MYSQL_Update_Character(player, option1, option2);
			                SendSetMessages(player, playerid, option1, option2);
							return 1;
					    }
			        }
				}

				else if(!strcmp(option1, "thirsty", true))
				{
				    if (Account[playerid][Admin] > 1336)
					{

				        Character[player][Thirsty] = option2;
                        MYSQL_Update_Character(player, option1, option2);
					    SendSetMessages(player, playerid, option1, option2);
						return 1;
			        }
				}

				else if(!strcmp(option1, "hungry", true))
				{
				    if (Account[playerid][Admin] > 1336)
					{
				        Character[player][Hungry] = option2;
                        MYSQL_Update_Character(player, option1, option2);
					    SendSetMessages(player, playerid, option1, option2);
						return 1;
			        }
				}

			    else if(!strcmp(option1, "world", true))
				{
				    if (Account[playerid][Admin] > 1335)
					{
		                SetPlayerVirtualWorld(player, option2);
						Character[player][VWorld] = option2;
						MYSQL_Update_Character(player, option1, option2);
		                SendSetMessages(player, playerid, option1, option2);
						return 1;
			        }
				}

			    else if(!strcmp(option1, "interior", true))
				{
				    if (Account[playerid][Admin] > 1335)
					{
		                SetPlayerInterior(player, option2);
						Character[player][Interior] = option2;
						MYSQL_Update_Character(player, option1, option2);
						SendSetMessages(player, playerid, option1, option2);
						return 1;
					}
				}

			    else if(!strcmp(option1, "age", true))
				{
				    if (Account[playerid][Admin] > 1335)
					{
                        if(option2 > 0 && option2 <= 90)
						{
                            Character[player][Age] = option2;
                            MYSQL_Update_Character(player, option1, option2);
					        SendSetMessages(player, playerid, option1, option2);
                            return 1;
					    }
					    else
					    {
					        SendErrorMessage(playerid, ERROR_OPTION);
					    }
			        }
				}
			    else if(!strcmp(option1, "gender", true))
				{
				    if (Account[playerid][Admin] > 1335)
					{
                        if(option2 > 0 && option2 <= 2)
						{
                            Character[player][Gender] = option2;
                            MYSQL_Update_Character(player, option1, option2);
					        SendSetMessages(player, playerid, option1, option2);
                            return 1;
					    }
					    else
					    {
					        SendErrorMessage(playerid, ERROR_OPTION);

					    }
			        }
				}
			    else if(!strcmp(option1, "bank", true))
				{
				    if (Account[playerid][Admin] >= 1339)
					{
                            Character[player][Bank] = option2;
                            MYSQL_Update_Character(player, option1, option2);
					        SendSetMessages(player, playerid, option1, option2);
                            return 1;
			        }
				}
			    else if(!strcmp(option1, "cash", true))
				{
				    if (Account[playerid][Admin] >= 1339)
					{
                            Character[player][Cash] = option2;
                            GivePlayerMoneyEx(player, 0);
                            MYSQL_Update_Character(player, option1, option2);
					        SendSetMessages(player, playerid, option1, option2);
                            return 1;
			        }
				}
			    else if(!strcmp(option1, "admin", true))
				{
				    if (Account[playerid][Admin] >= 1339)
					{
                        if(option2 >= 0 && option2 <= 1339)
						{
                            Account[player][Admin] = option2;
                            MYSQL_Update_Interger(Account[player][SQLID], "Accounts", "Admin", Account[player][Admin]);
					        SendSetMessages(player, playerid, option1, option2);
                            return 1;
						}
					}
				}
			    else if(!strcmp(option1, "ExemptIP", true))
				{
				    if (Account[playerid][Admin] >= 1337)
					{
                        if(option2 >= 0 && option2 <= 1)
						{
                            Character[player][ExemptIP] = option2;
                            MYSQL_Update_Character(player, option1, option2);
                            SendSetMessages(player, playerid, option1, option2);
                            return 1;
						}
					}
				}
			}
			else
			{
			    SendErrorMessage(playerid, ERROR_INVALIDPLAYER);
			}
		}
	}
	else
	{
		SendErrorMessage(playerid, ERROR_ADMIN);
	}
	return 1;
}

ALTCMD:setp->setplayer;

CMD:gotopos(playerid,params[])
{
	if(Account[playerid][Admin] > 1335)
	{
		new Float:pos[3], int;
	    if(sscanf(params, "fffi", pos[0], pos[1], pos[2], int)) return SendClientMessage(playerid, COLOR_GRAY, "/gotopos [x] [y] [z] [int]");
		{
			SetPlayerPosEx(playerid, pos[0], pos[1], pos[2], int, 0);
			SetPlayerInterior(playerid, int);
		}
	}
	return 1;
}
hook OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 420 ||GetVehicleModel(GetPlayerVehicleID(playerid)) == 438)
	{
		if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			return 1;

		foreach (new  i : Player)
		{
			if (IsPlayerNearPlayer(playerid, i, 2.0))
			{
				SetPlayerCheckpoint(i, fX,fY,fZ, 3.0);
			}
		}
		return 1;
	}
	if(Account[playerid][Admin] > 1335)
	{
		SetPlayerPosFindZ(playerid, fX, fY, fZ+5);
	}
	return 1;
}
hook OnPlayerConnect(playerid)
{
	Character[playerid][AdminID] = INVALID_PLAYER_ID;
	return 1;
}