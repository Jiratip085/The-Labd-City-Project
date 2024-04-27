
new isFixPlayer[MAX_PLAYERS];

hook OnPlayerConnect(playerid) 
{
    isFixPlayer[playerid] = 0;
}

alias:rpt("แก้บัค")
CMD:rpt(playerid, params[])
{
	if (playerData[playerid][pPrisoned] > 0)
 		return ErrorMsg(playerid, "คุณติดคุกอยู่ไม่สามารถใช้งานคำสั่งได้");

	if (playerData[playerid][pJailTime] > 0)
 		return ErrorMsg(playerid, "คุณติดคุกอยู่ไม่สามารถใช้งานคำสั่งได้");

	if (GetPlayerWantedLevelEx(playerid) > 0)
		return ErrorMsg(playerid, "ไม่สามารถใช้คำสั่งได้หากคุณมีคดีติดตัว!");

	if (isFixPlayer[playerid] == 1)
		return ErrorMsg(playerid, "คุณอยู่ระหว่างการแก้บัคตัวละคร!");

	isFixPlayer[playerid] = 1;
	StartProgress(playerid, 400, 0, INVALID_OBJECT_ID);
	TogglePlayerControllable(playerid, false);
    SendClientMessage(playerid, COLOR_WHITE, "{E30E03}[!] {FAEB09}กรุณารอสักครู่ ระบบกำลังทำการแก้บัคให้กับตัวละครของท่าน!");
	return 1;
}

hook OnProgressFinish(playerid, objectid)
{
	if (isFixPlayer[playerid] == 1)
		PlayerFixCharacter(playerid);

	return Y_HOOKS_CONTINUE_RETURN_0;
}

PlayerFixCharacter(playerid)
{
    isFixPlayer[playerid] = 0;
    ClearAnimations(playerid);
    TogglePlayerControllable(playerid, true);

	SetPlayerPos(playerid, 1753.0231,-1898.4874,13.5573);
	SetPlayerFacingAngle(playerid, 356.6041);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
    SetCameraBehindPlayer(playerid);

    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{FD7009}PlayerFixCharacter | {FDEB09}แก้บัคตัวละคร", "{F30703}[!] {ffffff}ตัวละครของคุณถูกแก้บัคและส่งกลับจุดเกิดเด็กใหม่แล้ว!", "ตกลง", "");
}

alias:pay("ให้เงิน")
CMD:pay(playerid, params[])
{
	static
	    userid,
	    amount;

	if (sscanf(params, "ud", userid, amount))
	    return SendClientMessage(playerid, COLOR_WHITE, "/pay [ไอดี/ชื่อ] [จำนวน]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในระยะ");

	if (userid == playerid)
		return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไม่สามารถให้เงินตัวเองได้");

	if (amount < 1 || amount > 10000)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}จำนวนเงินต้องไม่ต่ำกว่า $1 และไม่เกิน $10,000 เท่านั้น");

	if (playerData[playerid][pHours] < 1)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณจำเป็นต้องมีชั่วโมงการเล่นมากกว่า 1 ขึ้นไป");

	if (amount > GetPlayerMoneyEx(playerid))
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}เงินของคุณไม่เพียงพอในการให้");

	static
	    string[72];

	GivePlayerMoneyEx(playerid, -amount);
	GivePlayerMoneyEx(userid, amount);

	format(string, sizeof(string), "You have received ~g~%s~w~ from %s.", FormatMoney(amount), GetPlayerNameEx(playerid));
	GameTextForPlayer(userid, string, 5000, 1);

	format(string, sizeof(string), "You have given ~r~%s~w~ to %s.", FormatMoney(amount), GetPlayerNameEx(userid));
	GameTextForPlayer(playerid, string, 5000, 1);

	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้หยิบเงินจำนวน %s จากกระเป๋าและยื่นให้ %s", GetPlayerNameEx(playerid), FormatMoney(amount), GetPlayerNameEx(userid));
	return 1;
}

alias:vip("เติมเงิน")
CMD:vip(playerid, params[])
{
	new count;
	if (sscanf(params, "d", count))
	    return SendClientMessage(playerid, COLOR_WHITE, "/เติมเงิน [ระดับ 1-3]");

	if (count < 1 || count > 3)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ระดับ VIP มีแค่ 1-3 เท่านั้น");

	switch(count)
	{
	    case 1:
	    {
		    SendClientMessage(playerid, COLOR_PINK, "|======[คุณสมบัติของ VIP ]======|");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}สามารถเก็บรถส่วนตัวได้ 2 คัน");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}ใช้คำสั่ง /ooc จะมี #VIP นำหน้า");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}ได้รับค่าประสบการณ์เพิ่มขึ้น +1 ทุกชั่วโมง");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}ได้รับเงินต่อชั่วโมง +$350");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}เพิ่มความจุของกระเป๋าเป็น 12 ช่อง");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}ราคา 100 : ถาวร");
		}
	    case 2:
	    {
		    SendClientMessage(playerid, COLOR_PINK, "|======[คุณสมบัติของ #{00FFFF}PR{FFFFFF}EMI{00FFFF}UM ]======|");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}สามารถเก็บรถส่วนตัวได้ 3 คัน");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}ใช้คำสั่ง /ooc จะมี #VIP นำหน้า");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}ใช้คำสั่ง /vipr ซ่อมรถ");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}ได้รับค่าประสบการณ์เพิ่มขึ้น +1 ทุกชั่วโมง");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}ได้รับเงินต่อชั่วโมง +$500");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}เพิ่มความจุของกระเป๋าเป็น 14 ช่อง");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}ราคา 150 : ถาวร");
		}
	    case 3:
	    {
		    SendClientMessage(playerid, COLOR_PINK, "|======[คุณสมบัติของ #{FF0000}SU{FFFFFF}PER{FF0000}ME ]======|");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}สามารถเก็บรถส่วนตัวได้ 4 คัน");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}ใช้คำสั่ง /ooc จะมี #VIP นำหน้า");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}ใช้คำสั่ง /vipr เติมน้ำมัน + ซ่อมรถ");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}ได้รับค่าประสบการณ์เพิ่มขึ้น +1 ทุกชั่วโมง");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}ได้รับเงินต่อชั่วโมง +$750");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}เพิ่มความจุของกระเป๋าเป็น 16 ช่อง");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}ราคา 200 : ถาวร");
		}
    }
	return 1;
}

    	//คราฟอาวุธ
        if (IsPlayerInRangeOfPoint(playerid, 2.0, 1157.8938,-1770.2036,16.5938))
        {
			new string100[4096];
			new string2[4096];

			format(string100, sizeof(string100), "{FFFFFF}[อาวุธ]\t{35C005}[{6BF939}โอกาสสำเร็จ{35C005}]\n");
			strcat(string2,string100);

			format(string100, sizeof(string100), "{FFFFFF}สนับมือ\t{16D603}[10 {FFFFFF}เปอร์เซ็นต์{16D603}]\n");
			strcat(string2,string100);

			format(string100, sizeof(string100), "{FFFFFF}มีดสั้น\t{16D603}[10 {FFFFFF}เปอร์เซ็นต์{16D603}]\n");
			strcat(string2,string100);

			format(string100, sizeof(string100), "{FFFFFF}ไม้สนุ๊ก\t{16D603}[10 {FFFFFF}เปอร์เซ็นต์{16D603}]\n");
			strcat(string2,string100);

			format(string100, sizeof(string100), "{FFFFFF}ไม้กอล์ฟ\t{16D603}[10 {FFFFFF}เปอร์เซ็นต์{16D603}]\n");
			strcat(string2,string100);

			format(string100, sizeof(string100), "{FFFFFF}ไม้เบสบอล\t{16D603}[10 {FFFFFF}เปอร์เซ็นต์{16D603}]\n");
			strcat(string2,string100);

			format(string100, sizeof(string100), "{FFFFFF}พลั่ว\t{16D603}[10 {FFFFFF}เปอร์เซ็นต์{16D603}]\n");
			strcat(string2,string100);

			Dialog_Show(playerid,DIALOG_CRAFT,DIALOG_STYLE_TABLIST_HEADERS,"{FFFFFF}[{16D603}สร้างอาวุธ{FFFFFF}]",string2,"ตกลง","ยกเลิก");
			return 1;
        }

    	// คราฟกาชาปอง
        if (IsPlayerInRangeOfPoint(playerid, 2.0, 1153.0934,-1770.6306,16.5992))
        {
			return Dialog_Show(playerid,DIALOG_CRAFT_GACHA,DIALOG_STYLE_MSGBOX,"{FFFFFF}[{16D603}กาชาปองสายฟรี{FFFFFF}]", "{3CD606}สิ่งของ > กาชาปองสายฟรี\n\n{FFFFFF}-แร่เฮมาไทต์ 50 อัน\n- เงินแดง $1,000\n- เงินเขียว $1,000\n\n{6BF939}โอกาสสำเร็จ : 50%", "ตกลง", "ยกเลิก");
        }

Dialog:DIALOG_SUIT(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
  		{
			case 0:
			{
				cl_buying[playerid]= BUYZIP;

				new str[4096];

				for(new i=0;i!=sizeof(cl_ZipData);++i) format(str, 4096, "%s %d.%s\t{3FFA3C}$%d"EMBED_WHITE"\n", str, i, cl_ZipData[i][e_name], cl_ZipData[i][e_price]);
				Dialog_Show(playerid, DIALOG_BUY_CLOTHING, DIALOG_STYLE_TABLIST, "{FFFFFF}[{03BB0C}ร้านขายของแต่งตัว{FFFFFF}]", str, "ตกลง", "ยกเลิก");

				return 1;
			}
			case 1:
			{
				cl_buying[playerid]=BUYSPORTS;

				new str[4096];

				for(new i=0;i!=sizeof(cl_SportsData);++i) format(str, 4096, "%s %d.%s\t{FDEC1C}%d {FFFFFF}Coin"EMBED_WHITE"\n", str, i, cl_SportsData[i][e_name], cl_SportsData[i][e_price]);
				Dialog_Show(playerid, DIALOG_BUY_CLOTHING, DIALOG_STYLE_TABLIST, "{FFFFFF}[{03BB0C}ร้านขายของแต่งตัว{FFFFFF}]", str, "Ok", "Cancel");
				return 1;
			}
		}
	}
	return 1;
}

// ระบบแต่งตัว
Dialog:DIALOG_BUY_CLOTHING(playerid, response, listitem, inputtext[])
{
	if (response) {

		switch(cl_buying[playerid])
		{
		    case BUYSPORTS:
		    {
				if (playerData[playerid][pCoin] < cl_SportsData[listitem][e_price])
				    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณมี Coin ไม่เพียงพอ");

		        //GivePlayerMoneyEx(playerid, -cl_SportsData[listitem][e_price]);
		        playerData[playerid][pCoin] -= cl_SportsData[listitem][e_price];

		        Inventory_Add(playerid, cl_SportsData[listitem][e_name], 1);
				SendClientMessageEx(playerid, COLOR_YELLOW, "คุณได้รับ %s เรียบร้อยแล้ว", cl_SportsData[listitem][e_name]);
		    }

		    case BUYZIP:
		    {
				if (GetPlayerMoneyEx(playerid) < cl_ZipData[listitem][e_price])
				    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณมีเงินไม่เพียงพอ");

		        GivePlayerMoneyEx(playerid, -cl_ZipData[listitem][e_price]);

		        Inventory_Add(playerid, cl_ZipData[listitem][e_name], 1);
				SendClientMessageEx(playerid, COLOR_YELLOW, "คุณได้รับ %s เรียบร้อยแล้ว", cl_ZipData[listitem][e_name]);
		    }
		}
		cl_buying[playerid]=0;
	}
	return 1;
}

alias:todsuit("ถอดชุด")
CMD:todsuit(playerid)
{
	RemovePlayerAttachedObject(playerid, 3);
	SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณได้ถอดเครื่องแต่งกายของคุณแล้ว!");

	return 1;
}

alias:carhelp("คำสั่งรถ")
CMD:carhelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_GREEN, "|======[รถส่วนตัว]======|");
    SendClientMessage(playerid, COLOR_WHITE, "/เรียกรก ,/เก็บรถ,/จุดจอดรถ");
    SendClientMessage(playerid, COLOR_WHITE, "/สตาร์ทรถ,/ล็อครถ, /จอดรถ,/ซื้อรถ,/ขายรถ");
	return 1;
}

alias:findcar("จุดจอดรถ")
CMD:findcar(playerid, params[])
{
    new string[MAX_SPAWNED_VEHICLES * 64], count;

 	string = "#\tชื่อรุ่น";

 	for(new i = 1; i < MAX_VEHICLES; i ++)
 	{
 	    if(IsValidVehicle(i) && carData[i][carID] > 0 && IsVehicleOwner(playerid, i))
 	    {
 	        format(string, sizeof(string), "%s\n%d\t%s", string, count + 1, ReturnVehicleName(i));
 	        count++;
		}
	}

	if(!count)
	{
	    SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณไม่มีรถจอดอยู่ในเซิร์ฟเวอร์เลย");
	}
	else
	{
	    Dialog_Show(playerid, DIALOG_FINDCAR, DIALOG_STYLE_TABLIST_HEADERS, "[เลือกรถที่ต้องการจะหา]", string, "หา", "ปิด");
	}

	return 1;
}

alias:upgradevehicle("อัพรถ")
CMD:upgradevehicle(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid), option[8], param[32];

	if(!vehicleid || !IsVehicleOwner(playerid, vehicleid))
	{
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณต้องอยู่ในรถส่วนตัวของคุณ");
	}
	if(!IsPlayerInRangeOfPoint(playerid, 8.0, 542.0433, -1293.5909, 17.2422))
	{
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณไม่ได้อยู่ที่ร้านขายรถ");
	}
	if(sscanf(params, "s[8]S()[32]", option, param))
	{
	    return SendClientMessage(playerid, COLOR_WHITE, "/อัพรถ [ช่องเก็บเงิน | ป้ายทะเบียน]");
	}

	if(!strcmp(option, "1", true))
	{
	    if(isnull(param) || strcmp(param, "ยืนยัน", true) != 0)
	    {
	        SendClientMessage(playerid, COLOR_WHITE, "/อัพรถ [1] [ยืนยัน]");
	        SendClientMessageEx(playerid, COLOR_GREY3, "ช่องเก็บของเลเวลปัจจุบัน %d/3 ค่าอัพเกรดราคา $10,000", carData[vehicleid][carTrunk]);
	        return 1;
		}
		if(carData[vehicleid][carTrunk] >= 3)
		{
		    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}เลเวลช่องเก็บของเต็มแล้ว 3/3");
		}
		if(GetPlayerMoneyEx(playerid) < 10000)
		{
		    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณมีเงินไม่เพียงพอ $10,000");
		}

		carData[vehicleid][carTrunk]++;

		GivePlayerMoneyEx(playerid, -10000);
		GameTextForPlayer(playerid, "~r~-$10000", 5000, 1);
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carTrunk = %d WHERE carID = %d", carData[vehicleid][carTrunk], carData[vehicleid][carID]);
		mysql_tquery(g_SQL, query);

		SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้อัพเกรดช่องเก็บของเป็นเลเวล %d/3 ในราคา $10,000 '/เก็บของในรถ เช็ค' ในการดูช่องเก็บของ", carData[vehicleid][carTrunk]);
	}
	else if(!strcmp(option, "2", true))
	{
	    if(isnull(param))
	    {
	        return SendClientMessage(playerid, COLOR_WHITE, "/อัพรถ [2] [เลขป้าย] (ราคา $20,000)");
	    }
	    if(!IsEngineVehicle(vehicleid))
	    {
	        return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}รถคันนี้ไม่รองรับการใส่ป้ายทะเบียน");
	    }

	    strcpy(carData[vehicleid][carPlate], param, 32);

		SetVehicleNumberPlate(vehicleid, param);
	    ResyncVehicle(vehicleid);

	    GivePlayerMoneyEx(playerid, -20000);
		GameTextForPlayer(playerid, "~r~-$20000", 5000, 1);
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carPlate = '%e' WHERE carID = %d", param, carData[vehicleid][carID]);
		mysql_tquery(g_SQL, query);

		SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้จ่ายเงิน $20,000 ในการเปลี่ยนป้ายทะเบียนเป็น '%s'", param);
	}

	return 1;
}

alias:vstash("เก็บของในรถ")
CMD:vstash(playerid, params[])
{
	new vehicleid = GetNearbyVehicle(playerid);
	new query[300];

	if(vehicleid != INVALID_VEHICLE_ID && IsVehicleOwner(playerid, vehicleid))
	{
	    new option[14], param[32];

		if(!carData[vehicleid][carTrunk])
		{
		    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}รถคันนี้ไม่มีช่องเก็บของ /อัพรถ ในการอัพเกรด");
	    }
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณต้องอยู่หลังรถ");
		}
		if(sscanf(params, "s[14]S()[32]", option, param))
		{
		    return SendClientMessage(playerid, COLOR_WHITE, "/เก็บของในรถ [1 | 2 | เอาออก]");
	    }
	    if(!strcmp(option, "1", true))
	    {
	        SendClientMessage(playerid, COLOR_GREEN, "|_____ ช่องเก็บของ _____|");
	        SendClientMessageEx(playerid, COLOR_GREY2, "เงิน: %s/%s", FormatMoney(carData[vehicleid][carCash]), FormatMoney(GetVehicleStashCapacity(vehicleid, STASH_CAPACITY_CASH)));
		}
		else if(!strcmp(option, "2", true))
	    {
	        new value;

	        if(sscanf(param, "s[14]S()[32]", option, param))
	        {
	            SendClientMessage(playerid, COLOR_WHITE, "/เก็บของในรถ [ใส่] [ชื่อรายการ]");
	            SendClientMessage(playerid, COLOR_YELLOW, "[ชื่อรายการ]:{FFFFFF} เงิน");
	            return 1;
	        }
	        if(!strcmp(option, "เงิน", true))
			{
			    if(sscanf(param, "i", value))
			    {
			        return SendClientMessage(playerid, COLOR_WHITE, "/เก็บของในรถ [2] [เงิน] [จำนวน]");
				}
				if(value < 1 || value > GetPlayerMoneyEx(playerid))
				{
				    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณมีเงินไม่เพียงพอ");
			    }
			    if(carData[vehicleid][carCash] + value > GetVehicleStashCapacity(vehicleid, STASH_CAPACITY_CASH))
			    {
			        return SendClientMessageEx(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ช่องเก็บของในรถสามารถใส่เงินได้มากสุดแค่ %s", FormatMoney(GetVehicleStashCapacity(vehicleid, STASH_CAPACITY_CASH)));
			    }

			    GivePlayerMoneyEx(playerid, -value);
			    carData[vehicleid][carCash] += value;
			    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carCash = %d WHERE carID = %d", carData[vehicleid][carCash], carData[vehicleid][carID]);
			    mysql_tquery(g_SQL, query);

			    SendClientMessageEx(playerid, COLOR_SERVER, "** คุณได้ใส่เงินจำนวน %s ลงในช่องเก็บของรถ", FormatMoney(value));
			}
		}
		else if(!strcmp(option, "เอาออก", true))
	    {
	        new value;

	        if(sscanf(param, "s[14]S()[32]", option, param))
	        {
	            SendClientMessage(playerid, COLOR_WHITE, "/เก็บของในรถ [เอาออก] [ชื่อรายการ]");
	            SendClientMessage(playerid, COLOR_YELLOW, "[ชื่อรายการ]:{FFFFFF} เงิน");
	            return 1;
	        }
	        if(!strcmp(option, "เงิน", true))
			{
			    if(sscanf(param, "i", value))
			    {
			        return SendClientMessage(playerid, COLOR_WHITE, "/เก็บของในรถ [เอาออก] [เงิน] [จำนวน]");
				}
				if(value < 1 || value > carData[vehicleid][carCash])
				{
				    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณมีเงินไม่เพียงพอ");
			    }

			    GivePlayerMoneyEx(playerid, value);
			    carData[vehicleid][carCash] -= value;

			    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carCash = %d WHERE carID = %d", carData[vehicleid][carCash], carData[vehicleid][carID]);
			    mysql_tquery(g_SQL, query);

			    SendClientMessageEx(playerid, COLOR_SERVER, "** คุณได้เอาเงินจำนวน %s ออกจากช่องเก็บของในรถ", FormatMoney(value));
			}
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณต้องอยู่ใกล้รถของคุณ");
	}

	return 1;
}

CMD:neon(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);

	if(!vehicleid || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณต้องอยู่ในรถโดยต้องเป็นสถานะคนขับเท่านั้น");
	}
	if(!IsVehicleOwner(playerid, vehicleid) && playerData[playerid][pVehicleKeys] != vehicleid)
	{
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณต้องอยู่ในรถส่วนตัวของคุณ");
	}
	if(!carData[vehicleid][carNeon])
	{
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}รถคันนี้ไม่มี Neon");
	}

	if(!carData[vehicleid][carNeonEnabled])
	{
	    carData[vehicleid][carNeonEnabled] = 1;
	    GameTextForPlayer(playerid, "~g~Neon activated", 3000, 3);

	    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s ได้กดปุ่มเพื่อเปิด Neon", GetPlayerNameEx(playerid));
	}
	else
	{
	    carData[vehicleid][carNeonEnabled] = 0;
	    GameTextForPlayer(playerid, "~r~Neon deactivated", 3000, 3);

	    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s ได้กดปุ่มเพื่อปิด Neon", GetPlayerNameEx(playerid));
	}
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carNeonEnabled = %d WHERE carID = %d", carData[vehicleid][carNeonEnabled], carData[vehicleid][carID]);
	mysql_tquery(g_SQL, query);

	ReloadVehicleNeon(vehicleid);
	return 1;
}

CMD:unmod(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid), query[200];

	if(!vehicleid || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณต้องอยู่ในรถโดยต้องเป็นสถานะคนขับเท่านั้น");
	}
	if(!IsVehicleOwner(playerid, vehicleid) && playerData[playerid][pVehicleKeys] != vehicleid)
	{
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณต้องอยู่ในรถส่วนตัวของคุณ");
	}
	if(isnull(params))
	{
	    return SendClientMessage(playerid, COLOR_WHITE, "/unmod [color | paintjob | mods | neon]");
	}

	if(!strcmp(params, "color", true))
	{
	    carData[vehicleid][carColor1] = 0;
	    carData[vehicleid][carColor2] = 0;

	    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carColor1 = 0, carColor2 = 0 WHERE carID = %d", carData[vehicleid][carID]);
	    mysql_tquery(g_SQL, query);

	    ChangeVehicleColor(vehicleid, 0, 0);
	    SendClientMessage(playerid, COLOR_WHITE, "** สีรถของคุณได้กลับมาเป็นสีปกติ");
	}
	else if(!strcmp(params, "paintjob", true))
	{
	    carData[vehicleid][carPaintjob] = -1;

	    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carPaintjob = -1 WHERE carID = %d", carData[vehicleid][carID]);
	    mysql_tquery(g_SQL, query);

	    ChangeVehiclePaintjob(vehicleid, -1);
	    SendClientMessage(playerid, COLOR_WHITE, "** ลายรถของคุณได้กลับมาเป็นปกติ");
	}
	else if(!strcmp(params, "mods", true))
	{
	    for(new i = 0; i < 14; i ++)
	    {
	        if(carData[vehicleid][carMods][i] >= 1000)
	        {
	            RemoveVehicleComponent(vehicleid, carData[vehicleid][carMods][i]);
	        }
	    }

	    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carMod1 = 0, carMod2 = 0, carMod3 = 0, carMod4 = 0, carMod5 = 0, carMod6 = 0, carMod7 = 0, carMod8 = 0, carMod9 = 0, carMod10 = 0, carMod11 = 0, carMod12 = 0, carMod13 = 0, carMod14 = 0 WHERE carID = %d", carData[vehicleid][carID]);
	    mysql_tquery(g_SQL, query);

	    SendClientMessage(playerid, COLOR_WHITE, "** ของแต่งรถถูกถอดออกทั้งหมด");
	}
	else if(!strcmp(params, "neon", true))
	{
	    if(!carData[vehicleid][carNeon])
	    {
	        return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}รถคันนี้ไม่มี Neon");
		}

		if(carData[vehicleid][carNeonEnabled])
		{
		    DestroyDynamicObject(carData[vehicleid][carObjects][0]);
		    DestroyDynamicObject(carData[vehicleid][carObjects][1]);
		}

		carData[vehicleid][carNeon] = 0;
		carData[vehicleid][carNeonEnabled] = 0;
		carData[vehicleid][carObjects][0] = INVALID_OBJECT_ID;
		carData[vehicleid][carObjects][1] = INVALID_OBJECT_ID;

		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carNeon = 0, carNeonEnabled = 0 WHERE id = %d", carData[vehicleid][carID]);
	    mysql_tquery(g_SQL, query);

	    SendClientMessage(playerid, COLOR_WHITE, "** Neon ถูกถอดออกจากรถ");
	}

	return 1;
}
CMD:carinfo(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);

	if(!vehicleid || !IsVehicleOwner(playerid, vehicleid))
	{
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณต้องอยู่ในรถส่วนตัวของคุณ");
	}

	new neon[12], Float:health;

	GetVehicleHealth(vehicleid, health);

	switch(carData[vehicleid][carNeon])
	{
	    case 18647: neon = "Red";
		case 18648: neon = "Blue";
		case 18649: neon = "Green";
		case 18650: neon = "Yellow";
		case 18651: neon = "Pink";
		case 18652: neon = "White";
		default: neon = "None";
	}

	SendClientMessageEx(playerid, COLOR_GREEN, "|______ %s Stats ______|", ReturnVehicleName(vehicleid));
	SendClientMessageEx(playerid, COLOR_GREY2, "(เจ้าของ: %s) - (ราคา: %s) - (ใบสั่ง: %s) - (ป้ายทะเบียน: %s)", carData[vehicleid][carOwner], FormatMoney(carData[vehicleid][carPrice]), FormatMoney(carData[vehicleid][carTickets]), carData[vehicleid][carPlate]);
	SendClientMessageEx(playerid, COLOR_GREY2, "(Neon: %s) - (เลเวลช่องเก็บของ: %d/3) - (ความเสียหาย: %.1f) - (น้ำมัน: %.2f)", neon, carData[vehicleid][carTrunk], health, vehicleFuel[vehicleid]);
	return 1;
}
CMD:atm(playerid, params[])
{
	if (ATM_Nearest(playerid) == -1)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณไม่ได้อยู่ใกล้ ตู้ ATM");

    CreatePlayerATM(playerid);
	//Dialog_Show(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, "[บัญชีธนาคาร]", "ยอดเงินปัจจุบัน: %s", "เลือก", "ปิด", FormatMoney(playerData[playerid][pBankMoney]));
	return 1;
}





alias:lock("ล็อค")
CMD:lock(playerid, params[])
{
	new
	    id = GetNearbyVehicle(playerid);

/*	if (!IsPlayerInAnyVehicle(playerid) && (id = (Entrance_Inside(playerid) == -1) ? (Entrance_Nearest(playerid)) : (Entrance_Inside(playerid))) != -1)
	{
		if (strlen(entranceData[id][entrancePass]))
		{
			Dialog_Show(playerid, DIALOG_ENTRANCEPASS, DIALOG_STYLE_INPUT, "[รหัสผ่านประตู]", "ใส่รหัสผ่านให้ประตูเพื่อความปลอดภัย:", "ยืนยัน", "ออก");
		}
	}*/
//	SendClientMessageEx(playerid, -1, "IsVehicleOwner: %d", IsVehicleOwner(playerid, id));
    if(IsVehicleOwner(playerid, id) || playerData[playerid][pVehicleKeys] == id || (carData[id][carFaction] >= 0 && carData[id][carFaction] == playerData[playerid][pFaction]))
	{
	    if(!carData[id][carLocked])
	    {
			carData[id][carLocked] = 1;

			GameTextForPlayer(playerid, "~r~Vehicle locked", 3000, 6);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s ได้ล็อครถ %s", GetPlayerNameEx(playerid), ReturnVehicleName(id));
		}
		else
		{
			carData[id][carLocked] = 0;

			GameTextForPlayer(playerid, "~g~Vehicle unlocked", 3000, 6);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s ได้ปลดล็อครถ %s", GetPlayerNameEx(playerid), ReturnVehicleName(id));
		}

		SetVehicleParams(id, VEHICLE_DOORS, carData[id][carLocked]);
        PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carLocked = %d WHERE carID = %d", carData[id][carLocked], carData[id][carID]);
		mysql_tquery(g_SQL, query);
		return 1;
	}
	return 1;
}

CMD:tune(playerid, params[]){
	Dialog_Show(playerid, DIALOG_TYPE_MAIN, DIALOG_STYLE_LIST, "Car Tuning Menu", "Paint Jobs\nColors\nHoods\nVents\nLights\nExhausts\nFront Bumpers\nRear Bumpers\nRoofs\nSpoilers\nSide Skirts\nBullbars\nWheels\nCar Stereo\nHydraulics\nNitrous Oxide", "เลือก", "ยกเลิก");
	return 1;
}

alias:mechanic("ซ่อม")
CMD:mechanic(playerid, params[])
{
	static
	    userid, price;

    if (GetFactionType(playerid) != FACTION_MEC)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณไม่ใช่ช่าง!");

    if (sscanf(params, "ud", userid, price))
	    return SendClientMessage(playerid, COLOR_WHITE, "/mechanic [ไอดี/ชื่อ] [จำนวนเงิน]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไม่สามารถซ่อมให้ตัวเองได้");

	if (price < 500 || price > 1000)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ราคาต้องไม่ต่ำกว่า $500 และไม่เกิน $1,000");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");

	if (GetPlayerMoneyEx(userid) < price)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นนั้นมีเงินไม่เพียงพอ");

	if (GetPlayerState(userid) != PLAYER_STATE_DRIVER)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นต้องอยู่ในสถานะคนขับ");

	playerData[playerid][pMecOfferID] = userid;
	playerData[playerid][pMecOfferPrice] = price;
	playerData[userid][pMecOfferID] = playerid;
	playerData[userid][pMecOfferPrice] = price;
	Dialog_Show(playerid, DIALOG_MECHANIC, DIALOG_STYLE_LIST, "[รายการซ่อม]", "เปลี่ยนสี\nซ่อมรถ", "ตกลง", "ปิด");
	return 1;
}

alias:heal("รักษา")
CMD:heal(playerid, params[])
{
	static
	    userid, price;

	new string[256];

    if (GetFactionType(playerid) != FACTION_MEDIC)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

    if (sscanf(params, "ud", userid, price))
	    return SendClientMessage(playerid, COLOR_WHITE, "/รักษา [ไอดี/ชื่อ] [จำนวนเงิน]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไม่สามารถรักษาตัวเองได้");

	if (price < 50 || price > 500)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ราคาต้องไม่ต่ำกว่า $50 และไม่เกิน $500");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");

	if (GetPlayerMoneyEx(userid) < price)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นนั้นมีเงินไม่เพียงพอ");

	if (IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณต้องไม่อยู่ในรถ");

	if (IsPlayerInAnyVehicle(userid))
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ต้องไม่อยู่ในรถ");


	new Float:hp;
	GetPlayerHealth(userid, hp);

	if (hp > 70)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในสถานะขาดเลือด");

	playerData[playerid][pMedicOfferID] = userid;
	playerData[playerid][pMedicOfferPrice] = price;
	playerData[userid][pMedicOfferID] = playerid;
	playerData[userid][pMedicOfferPrice] = price;

	format(string, sizeof string, "{FFFFFF}ตอบรับการรักษาจากหมอ (เติมเลือด) %s ราคา %s", GetPlayerNameEx(playerid), FormatMoney(price));
    Dialog_Show(userid, DIALOG_ACCEPT44, DIALOG_STYLE_INPUT, "[ยืนยัน]", string, "ยืนยัน", "ปิด");
	return 1;
}

Dialog:DIALOG_ACCEPT44(playerid, response, listitem, inputtext[])
{
	new userid = playerData[playerid][pMedicOfferID];
	new price = playerData[playerid][pMedicOfferPrice];
	if (response)
	{
		SetPlayerHealth(playerid, 100);

		GivePlayerMoneyEx(playerid, -price);
		GivePlayerMoneyEx(userid, price);

	    SendClientMessageEx(userid, COLOR_WHITE, "คุณได้รักษา {33CCFF}%s{FFFFFF} เป็นจำนวนเงิน $%d", GetPlayerNameEx(playerid), price);
	    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "%s {FFFFFF}ได้รักษาคุณ เป็นจำนวนเงิน $%d", GetPlayerNameEx(userid), price);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้รักษา %s", GetPlayerNameEx(userid), GetPlayerNameEx(playerid));
		
		playerData[userid][pMedicOfferID] = INVALID_PLAYER_ID;
		playerData[userid][pMedicOfferPrice] = 0;
		playerData[playerid][pMedicOfferID] = INVALID_PLAYER_ID;
		playerData[playerid][pMedicOfferPrice] = 0;
	}
	else
	{
		playerData[userid][pMedicOfferID] = INVALID_PLAYER_ID;
		playerData[userid][pMedicOfferPrice] = 0;
		playerData[playerid][pMedicOfferID] = INVALID_PLAYER_ID;
		playerData[playerid][pMedicOfferPrice] = 0;
	}
	return 1;
}

Dialog:DIALOG_ACCEPT55(playerid, response, listitem, inputtext[])
{
	new userid = playerData[playerid][pMedicOfferID];
	new price = playerData[playerid][pMedicOfferPrice];
	if (response)
	{
		SetPlayerHealth(playerid, 100);
		SetPlayerWeather(playerid, globalWeather);
	    playerData[playerid][pInjured] = 0;
	    playerData[playerid][pInjuredTime] = 0;
	    ClearAnimations(playerid);
	    PlayerTextDrawHide(playerid, PlayerDeathTD[playerid]);
	    ShowPlayerStats(playerid, true);

	    GivePlayerMoneyEx(playerid, -price);
	    GivePlayerMoneyEx(userid, price);

	    SendClientMessageEx(userid, COLOR_WHITE, "คุณได้รักษาอาการบาดเจ็บให้ {33CCFF}%s{FFFFFF} เป็นจำนวนเงิน $%d", GetPlayerNameEx(playerid), price);
	    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "%s {FFFFFF}ได้รักษาอาการบาดเจ็บให้คุณ เป็นจำนวนเงิน $%d", GetPlayerNameEx(userid), price);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้รักษาอาการบาดเจ็บให้ %s", GetPlayerNameEx(userid), GetPlayerNameEx(playerid));
		playerData[userid][pMedicOfferID] = INVALID_PLAYER_ID;
		playerData[userid][pMedicOfferPrice] = 0;
		playerData[playerid][pMedicOfferID] = INVALID_PLAYER_ID;
		playerData[playerid][pMedicOfferPrice] = 0;
	}
	else
	{
		playerData[userid][pMedicOfferID] = INVALID_PLAYER_ID;
		playerData[userid][pMedicOfferPrice] = 0;
		playerData[playerid][pMedicOfferID] = INVALID_PLAYER_ID;
		playerData[playerid][pMedicOfferPrice] = 0;
	}
	return 1;
}

alias:cpr("ชุบชีวิต")
CMD:cpr(playerid, params[])
{
	static
	    userid, price;

    new string[256];

    if (GetFactionType(playerid) != FACTION_MEDIC)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

    if (sscanf(params, "ud", userid, price))
	    return SendClientMessage(playerid, COLOR_WHITE, "/ชุบชีวิต [ไอดี/ชื่อ] [จำนวนเงิน]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไม่สามารถรักษาตัวเองได้");

	if (price < 300 || price > 1000)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ราคาต้องไม่ต่ำกว่า $500 และไม่เกิน $1,000");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");

	if (GetPlayerMoneyEx(userid) < price)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นนั้นมีเงินไม่เพียงพอ");

	if (!playerData[userid][pInjured])
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในสถานะบาดเจ็บ");

	if (IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณต้องไม่อยู่ในรถ");

	if (IsPlayerInAnyVehicle(userid))
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ต้องไม่อยู่ในรถ");

	playerData[playerid][pMedicOfferID] = userid;
	playerData[playerid][pMedicOfferPrice] = price;
	playerData[userid][pMedicOfferID] = playerid;
	playerData[userid][pMedicOfferPrice] = price;

	format(string, sizeof string, "{FFFFFF}ตอบรับการรักษาจากหมอ (ชุพ CPR) %s ราคา %s", GetPlayerNameEx(playerid), FormatMoney(price));
    Dialog_Show(userid, DIALOG_ACCEPT55, DIALOG_STYLE_INPUT, "[ยืนยัน]", string, "ยืนยัน", "ปิด");
	return 1;
}
UpdatePlayerDeaths(playerid)
{
	if (playerData[playerid][IsLoggedIn] == false) return 0;
	if (playerData[playerid][pInjured] == 1) return 0;

	playerData[playerid][pDeaths]++;

	new query[90];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `playerDeaths` = %d WHERE `playerID` = %d LIMIT 1", playerData[playerid][pDeaths], playerData[playerid][pID]);
	mysql_tquery(g_SQL, query);
	return 1;
}

CMD:online(playerid, params[])
{
	new factionid = playerData[playerid][pFaction];

 	if (factionid == -1)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณไม่ใช่หนึ่งในสมาชิกของกลุ่มใด ๆ");

	SendClientMessage(playerid, COLOR_SERVER, "สมาชิกที่ออนไลน์:");

	foreach (new i : Player) if (playerData[i][pFaction] == factionid)
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "[ID: %d] {33CCFF}%s {FFFFFF}- %s (%d)", i, GetPlayerNameEx(i), Faction_GetRank(i), playerData[i][pFactionRank]);
	}
	return 1;
}

CMD:faction(playerid, params[])
{
	new type,
		count,
		name[24];
	if (sscanf(params, "d", type))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "/faction [ไอดีกลุ่ม]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[ไอดีกลุ่ม]:{FFFFFF} 1. ตำรวจ 2. นักข่าว 3. แพทย์ 4. นายก");
		return 1;
	}
	if (type < 1 || type > 4)
	{
	    SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไอดีต้องไม่ต่ำกว่า 1 และไม่เกิน 4 เท่านั้น");
	    return 1;
	}
	switch(type)
	{
	    case 1: name = "ตำรวจ";
	    case 2: name = "นักข่าว";
	    case 3: name = "แพทย์";
	    case 4: name = "นายก";
	}
	foreach (new i : Player) if (GetFactionType(i) == type)
	{
	    count++;
		SendClientMessageEx(playerid, COLOR_WHITE, "(%s) ออนไลน์ %d", name, count);
	}
	if (!count)
	{
		SendClientMessageEx(playerid, COLOR_RED, "[ระบบ] {FFFFFF}กลุ่ม %s ไม่มีคนออนไลน์เลย", name);
		return 1;
	}
	return 1;
}

CMD:gov(playerid, params[])
{
    new factionid = playerData[playerid][pFaction];

	if (GovCD[playerid] != 0)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "* คุณต้องรอ %d วินาทีถึงจะใช้งานคำสั่งนี้ได้", GovCD[playerid]);

    if (playerData[playerid][pOOCSpam] > 0)
    	return SendClientMessageEx(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ป้องกันการ Spam ข้อความ คุณเหลือเวลาอีก %d วินาที ในการใช้คำสั่งใหม่อีกครั้ง", playerData[playerid][pOOCSpam]);

 	if (factionid == -1)
	    return SendClientMessage(playerid, COLOR_GREY, "   คุณต้องเป็นสมาชิกของฝ่ายหรือกลุ่ม");

	if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
	    return SendClientMessageEx(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณไม่สามารถใช้คำสั่งนี้ได้ (Rank ขั้นต่ำ : %d)", factionData[playerData[playerid][pFaction]][factionRanks] - 1);

	if (isnull(params))
		return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : {FFFFFF}/(gov)ernment (ข้อความ)");

	if (GetFactionType(playerid) == FACTION_GANG)
	{
		new string[128];

		format(string, sizeof(string), "{%s}[_____.:: ประกาศจากแก๊ง %s ::._____]", (factionid), Faction_GetName(playerid));
		SendClientMessageToAll(COLOR_WHITE, string);

		format(string, sizeof(string), "(%s) %s : %s", Faction_GetRank(playerid), GetPlayerNameEx(playerid), params);
		SendClientMessageToAll(COLOR_WHITE, string);

		playerData[playerid][pOOCSpam] = 25;

		return 1;
	}
	else
	{
		new string[128];

		format(string, sizeof(string), "{%s}[_____.:: ประกาศจากหน่วยงาน %s ::._____]", (factionid), Faction_GetName(playerid));
		SendClientMessageToAll(COLOR_WHITE, string);

		format(string, sizeof(string), "(%s) %s : %s", Faction_GetRank(playerid), GetPlayerNameEx(playerid), params);
		SendClientMessageToAll(COLOR_WHITE, string);

		playerData[playerid][pOOCSpam] = 25;

		return 1;
	}
}
CMD:setmoney(playerid, params[])
{
    if(playerData[playerid][pAdmin] >= 6)
    {
    	new userid, amount;
        if(sscanf(params, "ud", userid, amount))
			return SendClientMessage(playerid, COLOR_WHITE, "/setmoney [ไอดี/ชื่อ] [จำนวน]");

        if(userid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

        SetPlayerMoneyEx(userid, amount);

        SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับเงินให้กับ %s(%d) เหลือจำนวน %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid), userid, FormatMoney(amount));
	}
    return 1;
}

CMD:hp(playerid, params[])
{
    if(playerData[playerid][pAdmin] > 0)
    {
    	new userid, Float:hp;
        if(sscanf(params, "uf", userid, hp))
			return SendClientMessage(playerid, COLOR_WHITE, "/hp [ไอดี/ชื่อ] [จำนวน]");

        if(userid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

        SetPlayerHealth(userid, hp);

        SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับเลือดให้กับ %s(%d) จำนวน %.0f", GetPlayerNameEx(playerid), GetPlayerNameEx(userid), userid, hp);
	}
    return 1;
}
CMD:setskin(playerid, params[])
{
	new
	    userid,
		skinid;

    if (playerData[playerid][pAdmin] < 1)
	    return SendClientMessage(playerid, COLOR_GREY, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "ud", userid, skinid))
	    return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : {FFFFFF}/setskin [playerid/name] [skin id]");

    if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_GREY, "ผู้เล่นที่ระบุไม่ถูกต้อง");

	if (skinid < 0 || skinid > 311)
	    return SendClientMessage(playerid, COLOR_GREY, "ไอดีสกินไม่ถูกต้อง สกินต้องอยู่ในช่วง 0 ถึง 311");

	SetPlayerSkin(userid, skinid);
	playerData[userid][pSkin] = skinid;

	SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* คุณได้ตั้งค่าสกินของ %s เป็นสกินไอดี: %d", GetPlayerNameEx(userid), skinid);

	return 1;
}
CMD:acpr(playerid, params[])
{
	static
	    userid;

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

    if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/acpr [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (!playerData[userid][pInjured])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในสถานะบาดเจ็บ");



	return 1;
}
CMD:setadmin(playerid, params[])
{
    if(playerData[playerid][pAdmin] > 5)
    {
    	new userid, level;
        if(sscanf(params, "ud", userid, level))
			return SendClientMessage(playerid, COLOR_WHITE, "/setadmin [ไอดี/ชื่อ] [เลเวล]");

        if(userid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

        playerData[userid][pAdmin] = level;

        SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับเลเวลแอดมินให้กับ %s(%d) เป็นแอดมินเลเวล %d", GetPlayerNameEx(playerid), GetPlayerNameEx(userid), userid, level);
	}
    return 1;
}

Dialog:DIALOG_BUYCAR_DONATE(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new var[32], string[512], query[256];
	    format(var, sizeof(var), "CARSHOP%d", listitem);
	    new carshopid = GetPVarInt(playerid, var);

		if (playerData[playerid][pCoin] < carshopData[carshopid][carshopPrice])
		{
		    SendClientMessageEx(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณมี Coin ไม่เพียงพอในการซื้อ (%d/%d Coin)", playerData[playerid][pCoin], carshopData[carshopid][carshopPrice]);
		    return 1;
		}

		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[playerid][pID], GetPlayerNameEx(playerid), carshopData[carshopid][carshopModel], carshopData[carshopid][carshopPrice], vehicleData[carshopData[carshopid][carshopModel] - 400][vFuel]);
		mysql_tquery(g_SQL, query);

		playerData[playerid][pCoin] -= carshopData[carshopid][carshopPrice];

		format(string, sizeof(string), "{FFFFFF}คุณได้ซื้อรถรุ่น {F9C205}%s {FFFFFF}ในราคา {F9C205}%d Coin {FFFFFF}เรียบร้อยแล้ว", ReturnVehicleModelName(carshopData[carshopid][carshopModel]), carshopData[carshopid][carshopPrice]);
		SendClientMessage(playerid, COLOR_WHITE, string);
	}
	return 1;
}


CMD:te2(playerid, params[])
{
    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	new id, Float: ammo;
    sscanf(params, "df", id, ammo);
	switch(id)
	{
		case 1: playerData[playerid][pThirsty] = ammo;
		case 2: playerData[playerid][pHungry] = ammo;
	}
	return 1;
}

CMD:te3(playerid, params[])
{
	new
		animLib[32],
		animName[32];

	GetAnimationName(GetPlayerAnimationIndex(playerid), animLib, sizeof animLib, animName, sizeof animName);
	SendClientMessageEx(playerid, 0xFFFFFFFF, "Running anim: %s %s %d", animLib, animName, GetPlayerAnimationIndex(playerid));
	SendClientMessageEx(playerid, 0xFFFFFFFF, "Faction Get %d Faction pVar %d", GetFactionType(playerid), playerData[playerid][pFaction]);
	return 1;
}


alias:sellmycar("ขายรถให้ร้าน")
CMD:sellmycar(playerid, params[])
{
 	new vehicleid = GetPlayerVehicleID(playerid), query[128];

	if(!vehicleid || !IsVehicleOwner(playerid, vehicleid))
	{
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณต้องอยู่ในรถส่วนตัวของคุณ");
	}
	if(!IsPlayerInRangeOfPoint(playerid, 8.0, 542.0433, -1293.5909, 17.2422))
	{
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณไม่ได้อยู่ที่ร้านขายรถ");
	}
	if(strcmp(params, "ยืนยัน", true) != 0)
	{
	    SendClientMessage(playerid, COLOR_WHITE, "/sellmycar [ยืนยัน]");
	    SendClientMessageEx(playerid, COLOR_RED, "รถคันนี้จะถูกลบออกถาวรและคุณจะได้รับเงินกลับจำนวน %s", FormatMoney(percent(carData[vehicleid][carPrice], 75)));
	    return 1;
	}

	GivePlayerMoneyEx(playerid, percent(carData[vehicleid][carPrice], 75));

	SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้ขายรถรุ่น %s คืนร้านในราคา %s สำเร็จ", ReturnVehicleName(vehicleid), FormatMoney(percent(carData[vehicleid][carPrice], 75)));

	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicles WHERE carID = %d", carData[vehicleid][carID]);
	mysql_tquery(g_SQL, query);

	DespawnVehicle(vehicleid, false);

	return 1;
}
alias:vape("สูบบุหรี่ไฟฟ้า")
CMD:vape(playerid, params[])
{
    if (!Inventory_HasItem(playerid, "บุหรี่ไฟฟ้า"))
		return SendClientMessage(playerid, COLOR_RED, "[!]{ffffff}คุณไม่มี 'บุหรี่ไฟฟ้า'");

    new Float:hp;
    GetPlayerHealth(playerid, hp);

    if (hp > 50.0)
        return SendClientMessage(playerid, COLOR_LIGHTRED, "เลือดของคุณต้องน้อยกว่า 50.0 ถึงจะสูบได้");

	ApplyAnimation(playerid,"SMOKING","M_smk_in",4.1, 0, 1, 1, 1, 1, 1);
	SetTimerEx("SmokeWeed214", 2000, false, "d", playerid);
	SendClientMessageEx(playerid, COLOR_YELLOW, "คุณกำลังสูบบุหรี่ไฟฟ้า HP + 50");

	return 1;
}

// --> ระบบแชร์โลเคชั่น
alias:lot("ส่งโล")
CMD:lot(playerid, params[])
{
	static
	    userid;

	if (sscanf(params, "u", userid))
     	return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : {FFFFFF}/แชร์โลเคชั่น [ไอดี/ชื่อ]");

    if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (!IsPlayerSpawnedEx(userid))
		return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ยังไม่ได้อยู่ในสถานะปกติ");

	new Float:X, Float:Y, Float:Z;

	GetPlayerPos(playerid, X,Y,Z);

	SetPlayerCheckpoint(userid, X,Y,Z, 2.0);

	SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "> คุณได้ส่งพิกัดล่าสุดของคุณให้กับผู้เล่น '%s' แล้ว", GetPlayerNameEx(userid));
	SendClientMessageEx(userid, COLOR_YELLOW, "> คุณได้รับพิกัดตำแหน่งล่าสุดของ '%s' แล้ว", GetPlayerNameEx(playerid));

	return 1;
}























































































#include	<YSI_Coding\y_hooks>

new mushroomobj[13],GetHedOn[MAX_PLAYERS] = 0,PackHedOn[MAX_PLAYERS] = 0,bool:Mushroom[MAX_PLAYERS] = false;
forward GetConHe(playerid);


hook OnGameModeInit()
{

    mushroomobj[0] = CreateObject(1603, -1437.39856, -954.63300, 200.79901,   0.00000, -8.00000, 0.00000);
    mushroomobj[1] = CreateObject(1603, -1435.55725, -956.41748, 200.79901,   0.00000, -8.00000, 0.00000);
    mushroomobj[2] = CreateObject(1603, -1433.11731, -953.75140, 200.79901,   0.00000, -8.00000, 0.00000);
    mushroomobj[3] = CreateObject(1603, -1431.35852, -956.24072, 200.79901,   0.00000, -8.00000, 0.00000);
    mushroomobj[4] = CreateObject(1603, -1428.90710, -953.58893, 200.79901,   0.00000, -8.00000, 0.00000);
    mushroomobj[5] = CreateObject(1603, -1427.66455, -955.87360, 200.79901,   0.00000, -8.00000, 0.00000);
    mushroomobj[6] = CreateObject(1603, -1425.33533, -953.55103, 200.79901,   0.00000, -8.00000, 0.00000);
    mushroomobj[7] = CreateObject(1603, -1425.47205, -945.73895, 200.79901,   0.00000, -8.00000, 0.00000);
    mushroomobj[8] = CreateObject(1603, -1428.03760, -947.52576, 200.79901,   0.00000, -8.00000, 0.00000);
    mushroomobj[9] = CreateObject(1603, -1431.40271, -945.54834, 200.79901,   0.00000, -8.00000, 0.00000);
    mushroomobj[10] = CreateObject(1603, -1434.17053, -948.07526, 200.79901,   0.00000, -8.00000, 0.00000);
    mushroomobj[11] = CreateObject(1603, -1438.02368, -945.25189, 200.79901,   0.00000, -8.00000, 0.00000);
    mushroomobj[12] = CreateObject(1603, -1437.52002, -947.82489, 200.79901,   0.00000, -8.00000, 0.00000);

    CreateDynamic3DTextLabel("{66FF00}[จุดแพ็คเห็ด]\n{CCFFFF}กดปุ่ม 'N'", COLOR_GREEN, -1424.9540,-960.4663,200.8258, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

    CreateDynamic3DTextLabel("{66FF00}[จุดขายเห็ด]\n{CCFFFF}กดปุ่ม 'N'", COLOR_GREEN,  1832.6227,-1848.5657,13.5781, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    CreateDynamicPickup(1239, 23, 1832.6227,-1848.5657,13.5781);

    CreateDynamic3DTextLabel("{66FF00}[จุดเก็บเห็ด]\n{CCFFFF}กดปุ่ม 'N' ที่เห็ดพื่อเก็บ", COLOR_GREEN, -1431.3784,-950.9202,200.9606, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

    CreateDynamic3DTextLabel("{66FF00}[Mushroom]\n{CCFFFF}กดปุ่ม 'N' เพื่อสมัครงาน", COLOR_GREEN, -1435.9050,-964.0720,201.0246, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    CreateDynamicPickup(1239, 23, -1435.9050,-964.0720,201.0246);

    return 1;
}
hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 3260, -1423.0000, -962.2500, 200.8125, 0.25);
    RemoveBuildingForPlayer(playerid, 3260, -1423.2969, -965.4609, 200.8125, 0.25);

    GetHedOn[playerid] = 0;
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    
    if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid,2.0, -1435.9050,-964.0720,201.0246 )){

            if(Mushroom[playerid] == false)
            {
                PackHedOn[playerid] = 1;
                ApplyAnimation(playerid,"DANCING","DAN_Up_A",4.1, 1, 0, 1, 0, 0);
                StartProgress(playerid, 30, 0, 0);
                SetTimerEx("GetConHe", 3000, false, "d",playerid);
            }
            else if (Mushroom[playerid] == true){
                Mushroom[playerid] = false;
                SendClientMessage(playerid, 0xCC3300, "[!]  {FFFFFF}คุณได้ออกจากอาชีพเก็บเห็ดแล้ว !");

            }
        }

        if(U_CheckPlayerNearObject(playerid, mushroomobj[0], 1.0)
        || U_CheckPlayerNearObject(playerid, mushroomobj[1], 1.0)
        || U_CheckPlayerNearObject(playerid, mushroomobj[2], 1.0)
        || U_CheckPlayerNearObject(playerid, mushroomobj[3], 1.0)
        || U_CheckPlayerNearObject(playerid, mushroomobj[4], 1.0)
        || U_CheckPlayerNearObject(playerid, mushroomobj[5], 1.0)
        || U_CheckPlayerNearObject(playerid, mushroomobj[6], 1.0)
        || U_CheckPlayerNearObject(playerid, mushroomobj[7], 1.0)
        || U_CheckPlayerNearObject(playerid, mushroomobj[8], 1.0)
        || U_CheckPlayerNearObject(playerid, mushroomobj[9], 1.0)
        || U_CheckPlayerNearObject(playerid, mushroomobj[10], 1.0)
        || U_CheckPlayerNearObject(playerid, mushroomobj[11], 1.0)
        || U_CheckPlayerNearObject(playerid, mushroomobj[12], 1.0))
        {
            if(Mushroom[playerid] == false) return SendClientMessage(playerid, 0xCC3300, "[!] คุณไม่ได้ทำงานในอาชีพนี้ โปรดไปสมัครงานก่อน");

            if(GetHedOn[playerid] > 0) return 1;

            if(GetHedOn[playerid] == 0)
            {
                SendClientMessage(playerid, COLOR_GREEN, "[?] {FFFFFF} คุณกำลังเก็บเห็ดกรุณารอสักครู่ .....");
                GetHedOn[playerid] = 1;

                CheckPlayerNearMushroom(playerid);
            
                for(new i = 0; i < sizeof mushroomobj; i++) {U_DestroyObjectNearPlayer(playerid,mushroomobj[i],1);}


                ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.1, 1, 0, 1, 0, 0);
                StartProgress(playerid, 70, 0, 0);
                SetTimerEx("GetMushroom", 7000, false, "d",playerid);
                return 1;
            }
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, -1424.9540,-960.4663,200.8258))
        {
            new itemname[24];
            itemname = "เห็ด";
            new count = Inventory_Count(playerid, itemname);

            if(count<2) return SendClientMessage(playerid, 0xCC3300, "[!]  {FFFFFF}คุณ๖้องมีเห็ดมากกว่า 2 ชิ้น !");
            
			if(PackHedOn[playerid] == 0)
			{
				Dialog_Show(playerid, DIALOG_PACKHAD, DIALOG_STYLE_TABLIST_HEADERS, "[จุดแพ็กเห็ด]", "{66FF00}ชื่อ\t{66FF00}มี\t{228B22}อัตราส่วน\n{CCFFCC}1.เห็ด\t%d\t2/1", "ตกลง", "ยกเลิก",Inventory_Count(playerid, "เห็ด"));
				return 1;
			}
            return 1;
        }

        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1832.6227,-1848.5657,13.5781))
        {
            new itemname[24];
            itemname = "เห็ดแพ็ก";
            new count = Inventory_Count(playerid, itemname);

            if(count<1) return SendClientMessage(playerid, 0xCC3300, "[!]  {FFFFFF}คุณ๖้องมีเห็ดแพ็กมากกว่า 1 ชิ้น !");
            new string9[256];
            format(string9,sizeof(string9),"{CCFF66}คุณมีเห็ดอยู่ %d\n{FFFFFF}ราคา ชิ้นละ {CCFF66}150 {FFFFFF}\n{FFFFFF}โปรดกรอกจำนวนที่จะขาย",Inventory_Count(playerid, "เห็ดแพ็ก"));
            Dialog_Show(playerid, D_Seal_HAD_1, DIALOG_STYLE_INPUT,"ขายเห็ด",string9,"ขาย","ยกเลิก");
            return 1;
        }
        return 1;
    }
    return 1;
}

Dialog:D_Seal_HAD_1(playerid, response, listitem, inputtext[])//
{
    new itemname[24];
    itemname = "เห็ดแพ็ก";
    new count = Inventory_Count(playerid, itemname);
    if(response){
        if (strval(inputtext) > count || strval(inputtext) < 1)
        {
            new string9[256];
            format(string9,sizeof(string9),"{CCFF66}คุณมีเห็ดอยู่ %d\n{FFFFFF}ราคา ชิ้นละ {CCFF66}150 {FFFFFF}\n{FFFFFF}โปรดกรอกจำนวนที่จะขาย",Inventory_Count(playerid, "เห็ดแพ็ก"));
            Dialog_Show(playerid, D_Seal_HAD_1, DIALOG_STYLE_INPUT,"ขายเห็ด",string9,"ขาย","ยกเลิก");
            SendClientMessage(playerid, 0xCC3300, "[!]  {FFFFFF} โปรดใส่จำนวนให้ถูกต้อง !");
            return 1;
        }
        if(count >= 1)
        {
            GivePlayerMoneyEx(playerid,150*strval(inputtext));//150 คือราคา
            SendClientMessageEx(playerid, COLOR_GREEN, "[!]  {FFFFFF}ขายเห็ดจำนวน %d ชิ้นสำเร็จ ",strval(inputtext));
            SendClientMessageEx(playerid, COLOR_GREEN, "[!]  {FFFFFF}ได้รับเงิน %d",150*strval(inputtext));

            Inventory_Remove(playerid, "เห็ดแพ็ก", strval(inputtext));
            return 1;
        }
    }
	
	return 1;
}


Dialog:DIALOG_PACKHAD(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		return 1;
	}
	if(response)
	{
		switch(listitem)
		{
			case 0://
			{   
                ApplyAnimation(playerid,"DANCING","DAN_Up_A",4.1, 1, 0, 1, 0, 0);
                StartProgress(playerid, 100, 0, 0);
                SetTimerEx("connectpackhad", 10000, false, "i", playerid);
                TogglePlayerControllable(playerid, 0);

                PackHedOn[playerid] = 1;
				return 1;
			}
		}
	}
	return 1;
}


forward connectpackhad(playerid);
public connectpackhad(playerid)
{
	if(Inventory_Count(playerid, "เห็ด") >= 2)
	{
		TogglePlayerControllable(playerid, 1);
		ClearAnimations(playerid);
	    PackHedOn[playerid] = 0;

		Inventory_Remove(playerid, "เห็ด", 2);
		Inventory_Add(playerid, "เห็ดแพ็ก", 1);
		SendClientMessageEx(playerid, COLOR_GREEN, "{00FF00}[ {66FFFF}+ {00FF00}]  {FFFFFF}แพ็กเห็ด{00FF00}สำเร็จ {FFFFFF}คุณได้รับ เห็ดแพ็ก +1 (%d)",Inventory_Count(playerid, "เห็ดแพ็ก"));
        SendClientMessageEx(playerid, COLOR_GREEN, "{00FF00}[ {66FFFF}+ {00FF00}]  {FFFFFF}เห็ด {FF3333}-2 {FFFFFF}(%d)",Inventory_Count(playerid, "เห็ด"));
		return 1;
	}
	PackHedOn[playerid] = 0;
	TogglePlayerControllable(playerid, 1);
	ClearAnimations(playerid);
	return 1;
}

forward CreateMushroom(i);
public  CreateMushroom(i)
{
    switch(i)
    {
        case 0: mushroomobj[0] = CreateObject(1603, -1437.39856, -954.63300, 200.79901,   0.00000, -8.00000, 0.00000);
        case 1:	mushroomobj[1] = CreateObject(1603, -1435.55725, -956.41748, 200.79901,   0.00000, -8.00000, 0.00000);
        case 2:	mushroomobj[2] = CreateObject(1603, -1433.11731, -953.75140, 200.79901,   0.00000, -8.00000, 0.00000);
        case 3: mushroomobj[3] = CreateObject(1603, -1431.35852, -956.24072, 200.79901,   0.00000, -8.00000, 0.00000);
        case 4:	mushroomobj[4] = CreateObject(1603, -1428.90710, -953.58893, 200.79901,   0.00000, -8.00000, 0.00000);
        case 5:	mushroomobj[5] = CreateObject(1603, -1427.66455, -955.87360, 200.79901,   0.00000, -8.00000, 0.00000);
        case 6:	mushroomobj[6] = CreateObject(1603, -1425.33533, -953.55103, 200.79901,   0.00000, -8.00000, 0.00000);
        case 7:	mushroomobj[7] = CreateObject(1603, -1425.47205, -945.73895, 200.79901,   0.00000, -8.00000, 0.00000);
        case 8:	mushroomobj[8] = CreateObject(1603, -1428.03760, -947.52576, 200.79901,   0.00000, -8.00000, 0.00000);
        case 9: mushroomobj[9] = CreateObject(1603, -1431.40271, -945.54834, 200.79901,   0.00000, -8.00000, 0.00000);
        case 10:mushroomobj[10] = CreateObject(1603, -1434.17053, -948.07526, 200.79901,   0.00000, -8.00000, 0.00000);
        case 11:mushroomobj[11] = CreateObject(1603, -1438.02368, -945.25189, 200.79901,   0.00000, -8.00000, 0.00000);
        case 12:mushroomobj[12] = CreateObject(1603, -1437.52002, -947.82489, 200.79901,   0.00000, -8.00000, 0.00000);   
    }
    return 1;
}

stock CheckPlayerNearMushroom(playerid)
{
    if(U_CheckPlayerNearObject(playerid, mushroomobj[0], 2.5)) SetTimerEx("CreateMushroom", 15950, false, "d",0);
    if(U_CheckPlayerNearObject(playerid, mushroomobj[1], 2.5)) SetTimerEx("CreateMushroom", 15950, false, "d",1);
    if(U_CheckPlayerNearObject(playerid, mushroomobj[2], 2.5)) SetTimerEx("CreateMushroom", 15950, false, "d",2);
    if(U_CheckPlayerNearObject(playerid, mushroomobj[3], 2.5)) SetTimerEx("CreateMushroom", 15950, false, "d",3);
    if(U_CheckPlayerNearObject(playerid, mushroomobj[4], 2.5)) SetTimerEx("CreateMushroom", 15950, false, "d",4);
    if(U_CheckPlayerNearObject(playerid, mushroomobj[5], 2.5)) SetTimerEx("CreateMushroom", 15950, false, "d",5);
    if(U_CheckPlayerNearObject(playerid, mushroomobj[6], 2.5)) SetTimerEx("CreateMushroom", 15950, false, "d",6);
    if(U_CheckPlayerNearObject(playerid, mushroomobj[7], 2.5)) SetTimerEx("CreateMushroom", 15950, false, "d",7);
    if(U_CheckPlayerNearObject(playerid, mushroomobj[8], 2.5)) SetTimerEx("CreateMushroom", 15950, false, "d",8);
    if(U_CheckPlayerNearObject(playerid, mushroomobj[9], 2.5)) SetTimerEx("CreateMushroom", 15950, false, "d",9);
    if(U_CheckPlayerNearObject(playerid, mushroomobj[10], 2.5)) SetTimerEx("CreateMushroom", 15950, false, "d",10);
    if(U_CheckPlayerNearObject(playerid, mushroomobj[11], 2.5)) SetTimerEx("CreateMushroom", 15950, false, "d",11);
    if(U_CheckPlayerNearObject(playerid, mushroomobj[12], 2.5)) SetTimerEx("CreateMushroom", 15950, false, "d",12);
    return 1;
}

forward GetMushroom(playerid);
public  GetMushroom(playerid)
{

    new itemname[24];
	itemname = "เห็ด";


    new count = Inventory_Count(playerid, itemname);

    if (count > 52)
        return SendClientMessageEx(playerid, COLOR_RED, "[!] {FFFFFF}ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

    new id = Inventory_Add(playerid, itemname, 1);

    if (id == -1)
        return SendClientMessageEx(playerid, COLOR_RED, "[!] {FFFFFF}ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

    SendClientMessage(playerid, COLOR_GREEN, "[!] {FFFFFF}คุณได้รับเห็ด 1 ชิ้น");

    GetHedOn[playerid] = 0;
    TogglePlayerControllable(playerid, 1);
    ClearAnimations(playerid);
    return 0;
}

stock U_CheckPlayerNearObject(playerid, objectid, Float:range) 
{
    new Float:X, Float:Y, Float:Z; 
    GetObjectPos(objectid, X, Y, Z);
    return (IsPlayerInRangeOfPoint(playerid, range, X, Y, Z));
}

stock U_DestroyObjectNearPlayer(playerid,obj,Float:a) //By PP6PAWN0xDEV.
{
    if(U_CheckPlayerNearObject(playerid, obj, a))
      DestroyObject(obj);
}

public GetConHe(playerid){

    Mushroom[playerid] = true;
    PackHedOn[playerid] = 0;
    SendClientMessage(playerid, COLOR_GREEN, "[!]  {FFFFFF}คุณได้สมัครงานอาชีพเก็บเห็ดแล้ว");
    return 1;
}

hook OnProgressUpdate(playerid, progress, objectid)
{
	
    if(GetHedOn[playerid] == 1){
        ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.1, 1, 0, 1, 0, 0);
        return Y_HOOKS_BREAK_RETURN_1;
    }
    if(PackHedOn[playerid] == 1){
        ApplyAnimation(playerid,"DANCING","DAN_Up_A",4.1, 1, 0, 1, 0, 0);
        return Y_HOOKS_BREAK_RETURN_1;
    }
	return Y_HOOKS_CONTINUE_RETURN_0;
}

CMD:gohed(playerid,params[]){

    if(playerData[playerid][pAdmin] < 0) return 1;

    new type;
    if (sscanf(params, "d", type))
    {
	    SendClientMessage(playerid, COLOR_WHITE, "/gohed [type]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[type]:{FFFFFF} 1: จุดสมัครงาน | 2: จุดเก็บเห็ด | 3: จุดแพ็ก | 4: จุดขาย");
	    return 1;
	}
    if (type < 1 || type > 4)
		return SendClientMessage(playerid, COLOR_YELLOW, "[type]:{FFFFFF} 1: จุดสมัครงาน | 2: จุดเก็บเห็ด | 3: จุดแพ็ก | 4: จุดขาย");

    switch(type){
        case 1: SetPlayerPos(playerid,-1435.9050,-964.0720,201.0246);
        case 2: SetPlayerPos(playerid,-1431.3784,-950.9202,200.9606);
        case 3: SetPlayerPos(playerid,-1424.9540,-960.4663,200.8258);
        case 4: SetPlayerPos(playerid,1832.6227,-1848.5657,13.5781);
    }
    return 1;
}

task CopOnlineTimer[1000]()
{
	new string[32];

	format(string, sizeof(string), "%d", CopOnline());
	TextDrawSetString(MorganGovernment[20], string);

	format(string, sizeof(string), "%d", MedicOnline());
	TextDrawSetString(MorganGovernment[21], string);

	format(string, sizeof(string), "%d", MechanicOnline());
	TextDrawSetString(MorganGovernment[22], string);

	TextDrawSetString(MorganGovernment[23], "0");		
}


CMD:suspect(playerid, params[])
{
    new
	    userid,
		crime[32];

	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

	if (sscanf(params, "us[32]", userid, crime))
	    return SendClientMessage(playerid, COLOR_WHITE, "(/su)spect [ไอดี/ชื่อ] [ข้อหา]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถยัดดาวให้ตัวเองได้");

	if (GetFactionType(userid) == FACTION_POLICE || GetFactionType(userid) == FACTION_MEDIC || GetFactionType(userid) == FACTION_GOV)
        return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถยัดดาวให้กับหน่วยงานรัฐได้");

    GivePlayerWanted(userid, 1);

	SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ยัดคดีความให้กับ {33CCFF}%s {FFFFFF}ข้อหา: %s", GetPlayerNameEx(userid), crime);
	SendClientMessageEx(userid, COLOR_WHITE, "เจ้าหน้าที่ {33CCFF}%s {FFFFFF}ได้ยัดคดีให้คุณ ข้อหา: %s", GetPlayerNameEx(playerid), crime);
    return 1;
}
alias:suspect("1")

CMD:clearwd(playerid, params[])
{
    new
	    userid;

	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/clearwd [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถเคลียดาวให้ตัวเองได้");

	if (GetPlayerWantedLevelEx(userid) == 0)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่มีคดีติดตัวเลย");

    ResetPlayerWantedLevelEx(userid);

	SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ลบล้างคดีให้กับ {33CCFF}%s", GetPlayerNameEx(userid));
	SendClientMessageEx(userid, COLOR_WHITE, "เจ้าหน้าที่ {33CCFF}%s {FFFFFF}ได้ลบล้างคดีทั้งหมดให้คุณ", GetPlayerNameEx(playerid));
    return 1;
}
alias:clearwd("0")

CMD:wdlist(playerid, params[])
{
    new
	    count;

	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

	foreach(new i : Player)
	{
	    if (GetPlayerWantedLevelEx(i) > 0)
	    {
	        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "ID: %d: %s {FFFFFF}%d ดาว", i, GetPlayerNameEx(i), GetPlayerWantedLevelEx(i));
	        count++;
	    }
	}
	if (!count)
	{
	    SendClientMessage(playerid, COLOR_RED, "- ขณะนี้ไม่มีใครมีคดีติดตัวเลย");
	    return 1;
	}
    return 1;
}
alias:wdlist("6")

CMD:detain(playerid, params[])
{
	new
		userid,
		vehicleid = GetNearestVehicle(playerid);

	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV)
		return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/cuff [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ ยะระ 5 เมตร์");

   /* if (!playerData[userid][pCuffed])
        return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้ถูกใส่กุญแจมืออยู่");*/

	if (vehicleid == INVALID_VEHICLE_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ได้อยู่ใกล้รถคันไหนเลย");

	if (GetVehicleMaxSeats(vehicleid) < 1)
  	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่สามารถนำตัวขึ้นรถคันนี้ได้");

	if (IsPlayerInVehicle(userid, vehicleid))
	{
		TogglePlayerControllable(userid, 1);

		RemoveFromVehicle(userid);
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้เปิดประตูและดึง %s ลงมาจากยานพาหนะ", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	}
	else
	{
		new seatid = GetAvailableSeat(vehicleid, 2);

		if (seatid == -1)
		    return SendClientMessage(playerid, COLOR_RED, "- ที่นั่งเต็มแล้ว");

		TogglePlayerControllable(userid, 0);

		StopDragging(userid);
		PutPlayerInVehicle(userid, vehicleid, seatid);

		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้เปิดประตูและดึง %s ขึ้นยานพาหนะ", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	}
	return 1;
}
alias:detain("5")

CMD:cuff(playerid, params[])
{
    new
	    userid;

	if (GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/cuff [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถใส่กุญแจมือให้ตัวเองได้");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ต้องไม่อยู่ในยานพาหนะ");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");

    if (playerData[userid][pCuffed])
        return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ถูกใส่กุญแจมืออยู่");

	static
	    string[64];

    playerData[userid][pCuffed] = 1;

    TogglePlayerControllable(userid, false);
    SetPlayerSpecialAction(userid, SPECIAL_ACTION_CUFFED);

	format(string, sizeof(string), "You've been ~r~cuffed~w~ by %s", GetPlayerNameEx(playerid));
    GameTextForPlayer(userid, string, 5000, 1);

    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้ใส่กุญแจมือผู้ต้องสงสัย %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
    return 1;
}
alias:cuff("2")


CMD:uncuff(playerid, params[])
{
    new
	    userid;

	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/uncuff [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถปลดกุญแจมือให้ตัวเองได้");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");

    if (!playerData[userid][pCuffed])
        return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้ถูกใส่กุญแจมือ");

	static
	    string[64];

    playerData[userid][pCuffed] = 0;

    TogglePlayerControllable(userid, true);
    SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);

	format(string, sizeof(string), "You've been ~g~uncuffed~w~ by %s", GetPlayerNameEx(playerid));
    GameTextForPlayer(userid, string, 5000, 1);

    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้ถอดกุญแจมือให้ผู้ต้องสงสัย %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
    return 1;
}
alias:uncuff("3")

CMD:drag(playerid, params[])
{
	new
	    userid;

	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_GOV)
		return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

    if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/drag [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถลากตัวเองได้");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ต้องไม่อยู่ในยานพาหนะ");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");

	if (playerData[userid][pDragged])
	{
	    playerData[userid][pDragged] = 0;
	    playerData[userid][pDraggedBy] = INVALID_PLAYER_ID;

	    KillTimer(playerData[userid][pDragTimer]);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้ปล่อยตัวผู้ต้องหา %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	}
	else
	{
	    playerData[userid][pDragged] = 1;
	    playerData[userid][pDraggedBy] = playerid;

	    playerData[userid][pDragTimer] = SetTimerEx("DragUpdate", 200, true, "dd", playerid, userid);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้พาตัวผู้ต้องหา %s ไปกับเขา", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	}
	return 1;
}
alias:drag("4")

CMD:arrest(playerid, params[])
{
	static
	    userid,
		time,
		money;

	new id = Arrest_Nearest(playerid);

	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

	if (sscanf(params, "udd", userid, time, money))
	    return SendClientMessage(playerid, COLOR_WHITE, "(/ar)rest [ไอดี/ชื่อ] [นาที] [ค่าปรับ 1-1000]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถส่งตัวเองเข้าคุกได้");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");

	if (time < 5 || time > 30)
	    return SendClientMessage(playerid, COLOR_RED, "- เวลาต้องไม่ต่ำกว่า 1 และไม่เกิน 30 นาที");

	if (money < 1 || money > 1000)
	    return SendClientMessage(playerid, COLOR_RED, "- ระบุจำนวนเงินห้ามสูงกว่า 1000 บาท");

	if (id == -1)
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ได้อยู่จุดส่งผู้ต้องหาเข้าคุก");

	playerData[userid][pPrisoned] = 1;
	playerData[userid][pJailTime] = time * 60; // time * 60

	playerData[userid][pPrisonOut] = id;

	StopDragging(userid);
	SetPlayerInPrison(userid);

	ResetPlayerWeaponsEx(userid);
	ResetPlayer(userid);

	playerData[userid][pCuffed] = 0;

	GivePlayerMoneyEx(userid, -money);
	// GivePlayerMoneyEx(playerid, money);

	ResetPlayerWantedLevelEx(userid);

    SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);

    SendClientMessageToAllEx(COLOR_LIGHTRED, ">>> ผู้ต้องหา %s ถูกนำตัวเข้าคุกเป็นเวลา %s นาที <<<", GetPlayerNameEx(userid), FormatNumber(time));

    return 1;
}
alias:arrest("ar")

CMD:jail(playerid, params[])
{
	static
	    userid,
		time;

	if (playerData[playerid][pAdmin] == 0)
		return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับแอดมินเท่านั้น!");

	if (sscanf(params, "ud", userid, time))
	    return SendClientMessage(playerid, COLOR_WHITE, "/jail [ไอดี/ชื่อ] [นาที]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (time < 1 || time > 1000)
	    return SendClientMessage(playerid, COLOR_RED, "- เวลาต้องไม่ต่ำกว่า 1 และไม่เกิน 1000 นาที");

	playerData[userid][pPrisoned] = 1;
	playerData[userid][pJailTime] = time * 60; // time * 60

	playerData[userid][pPrisonOut] = 0;

	StopDragging(userid);
	SetPlayerInPrison(userid);

	ResetPlayerWeaponsEx(userid);
	ResetPlayer(userid);

	playerData[userid][pCuffed] = 0;

    SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);

    SendClientMessageToAllEx(COLOR_LIGHTRED, "*** แอดมิน %s ได้ส่งผู้เล่น %s เข้าคุก %s นาที", GetPlayerNameEx(playerid), GetPlayerNameEx(userid), FormatNumber(time));
    return 1;
}


// อุ้มคน
CMD:draggedz(playerid, params[])
{
	new
	    userid, string[256];

    if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/อุ้มคน [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถลากตัวเองได้");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ต้องไม่อยู่ในยานพาหนะ");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");

	playerData[playerid][pMecOfferID] = userid;
	playerData[playerid][pMecOfferPrice] = 0;

	playerData[userid][pMecOfferID] = playerid;
	playerData[userid][pMecOfferPrice] = 0;

	format(string, sizeof string, "{FFFFFF}ตอบรับการอุ้มจาก %s", GetPlayerNameEx(playerid));
	Dialog_Show(userid, DIALOG_DRAGGED, DIALOG_STYLE_MSGBOX, "[ยืนยัน]", string, "ยืนยัน", "ปิด");

	SendClientMessageEx(playerid, COLOR_YELLOW, "คุณได้ส่งคำขอการอุ้มถึง %s แล้ว รอการตอบกลับ!", GetPlayerNameEx(userid));

	return 1;
}
alias:draggedz("อุ้มคน")

// การอุ้ม
Dialog:DIALOG_DRAGGED(playerid, response, listitem, inputtext[])
{
	new userid = playerData[playerid][pMecOfferID];
	//new price = playerData[playerid][pMecOfferPrice];

	if (response)
	{
	 	if (playerData[playerid][pDragged])
		{
		    playerData[playerid][pDragged] = 0;
		    playerData[playerid][pDraggedBy] = INVALID_PLAYER_ID;

		    KillTimer(playerData[playerid][pDragTimer]);
		    SendNearbyMessage(userid, 30.0, COLOR_PURPLE, "** %s ได้ปล่อยตัวผู้ต้องหา %s", GetPlayerNameEx(userid), GetPlayerNameEx(playerid));
		}
		else
		{
		    playerData[playerid][pDragged] = 1;
		    playerData[playerid][pDraggedBy] = userid;

		    playerData[playerid][pDragTimer] = SetTimerEx("DragUpdate", 200, true, "dd", userid, playerid);
		    SendNearbyMessage(userid, 30.0, COLOR_PURPLE, "** %s ได้พาตัวผู้ต้องหา %s ไปกับเขา", GetPlayerNameEx(userid), GetPlayerNameEx(playerid));
		}

		SendClientMessageEx(playerid, COLOR_GREEN, "[การอุ้ม] {FFFFFF}คุณได้ยอมรับการอุ้มจาก %s เรียบร้อยแล้ว", GetPlayerNameEx(userid));
		SendClientMessageEx(userid, COLOR_GREEN, "[การอุ้ม] {FFFFFF}คุณได้อุ้ม %s แล้ว", GetPlayerNameEx(playerid));

		playerData[userid][pMecOfferID] = INVALID_PLAYER_ID;
		playerData[userid][pMecOfferPrice] = 0;

		playerData[playerid][pMecOfferID] = INVALID_PLAYER_ID;
		playerData[playerid][pMecOfferPrice] = 0;
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "[การอุ้ม] {FFFFFF}คุณได้ปฏิเสธการอุ้มจาก %s เรียบร้อยแล้ว", GetPlayerNameEx(userid));
		SendClientMessageEx(userid, COLOR_LIGHTRED, "[การอุ้ม] {FFFFFF}ผู้เล่น %s ได้ปฏิเสธการอุ้มแล้ว", GetPlayerNameEx(playerid));

		playerData[userid][pMecOfferID] = INVALID_PLAYER_ID;
		playerData[userid][pMecOfferPrice] = 0;

		playerData[playerid][pMecOfferID] = INVALID_PLAYER_ID;
		playerData[playerid][pMecOfferPrice] = 0;
	}
	return 1;
}

/*stock IsPlayerNearGaragePoint(playerid) {
	for(new x = 0; x < sizeof(garagePoints); x ++) {
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, garagePoints[x][0], garagePoints[x][1], garagePoints[x][2])) {
	        return 1;
		}
	}
	return 0;
}*/