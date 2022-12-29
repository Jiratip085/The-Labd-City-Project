#include <YSI\y_hooks>

//Mechanic
CMD:buycomp(playerid, params[], productid)
{
	new
	    id = Product_Nearest(playerid),
	    string[128],
	    yesstring[16];

	if (id == -1)
	    	return SendClientMessage(playerid, COLOR_GREY, "คุณไม่ได้อยู่จุด buycomp!");

    if(ProductData[id][productType] == 3)
	{
		new amount;

		if (Character[playerid][Job] != 2)
		    return SendClientMessage(playerid, -1, "งานของคุณไม่ได้ใช้คำสั่งนี้");

		new vehicleid = GetPlayerVehicleID(playerid);

		if (GetVehicleModel(vehicleid) != 525)
			return SendClientMessage(playerid, -1, "คุณไม่ได้อยู่บน Towtruck");

		if (sscanf(params, "dS()[16]", amount, string))
		{
			SendClientMessage(playerid, -1, "/buycomp [amount]");
			SendClientMessage(playerid, -1, "คุณถูกจำกัดไว้ที่ 1-2,000");
			SendClientMessage(playerid, -1, "!! ในชิ้นส่วนแต่ละลังจะมีผลิตภัณฑ์ 25 ชิ้น !!");
			return 1;
		}

		if(amount < 1 || amount > 2000)
		    return SendClientMessage(playerid, -1, "จำนวนไม่ถูกต้อง");

        if(ProductData[id][productAmount] <= 0)
	        return SendClientMessage(playerid, -1, "สินค้าชนิดนี้หมดแล้วไม่สามารถซื้อได้");

        if (sscanf(string, "s[16]", yesstring))
	    {
	        format(string, sizeof(string), "ราคา : %s", FormatNumber(amount*ProductData[id][productPrice]));
  			SendClientMessage(playerid, COLOR_WHITE, string);

			format(string, sizeof(string), "/buycomp %d yes", amount);
  			SendClientMessage(playerid, COLOR_WHITE, string);
  			return 1;
		}


		if(Character[playerid][Cash] <  amount*ProductData[id][productPrice])
  			return SendClientMessage(playerid, -1, "คุณมีเงินไม่พอที่จะซื้อ");

        ProductData[id][productAmount] -= amount;
        Product_Refresh(id);

		GiveMoney(playerid, -amount*ProductData[id][productPrice], "buy comp");
		CoreVehicles[vehicleid][vehComponent] += amount*25;


        format(string, sizeof(string), "คุณซื้อชิ้นส่วน %d ชิ้นในราคา %s", amount, FormatNumber(amount*ProductData[id][productPrice]));
  		SendClientMessage(playerid, COLOR_WHITE, string);
	}
	else SendClientMessage(playerid, -1, "คุณต้องใช้คำสั่งนี้กับจุด buycomp เท่านั้น!");
	return 1;
}

CMD:checkcomponents(playerid, params[])
{
	new
		vehicleid = GetPlayerVehicleID(playerid),
		string[128];

	if (GetVehicleModel(vehicleid) != 525)
		return SendClientMessage(playerid, -1, "คุณไม่ได้อยู่บน Towtruck");

	if (CoreVehicles[vehicleid][vehComponent] < 1)
	    return SendClientMessage(playerid, -1, "ไม่มีผลิตภัณฑ์อยู่ในยานพาหนะนี้");


    format(string, sizeof(string), "ยานพาหนะนี้มีผลิตภัณฑ์อยู่ %d", CoreVehicles[vehicleid][vehComponent]);
	SendClientMessage(playerid, COLOR_WHITE, string);
	return 1;
}

CMD:service(playerid, params[])
{
	new
		userid, type, yesstring[16], string[128], carid, pcarid, price;

    if (Character[playerid][Job] != 2)
	    return SendClientMessage(playerid, -1, "งานของคุณไม่ได้ใช้คำสั่งนี้");

    new vehicleid = GetPlayerVehicleID(playerid);

	if (GetVehicleModel(vehicleid) != 525)
		return SendClientMessage(playerid, -1, "คุณไม่ได้อยู่บน Towtruck");

	if (CoreVehicles[vehicleid][vehComponent] < 1)
	    return SendClientMessage(playerid, -1, "ไม่มีผลิตภัณฑ์อยู่ในยานพาหนะนี้");

	if (sscanf(params, "uddS()[16]", userid, price, type, string))
	{
		SendClientMessage(playerid, -1, "/service [playerid/name] [price] [Type]");
		SendClientMessage(playerid, COLOR_GRAD1, "Type 1:{FFFFFF} บริการเพิ่มเลือดรถ");
		SendClientMessage(playerid, COLOR_GRAD1, "Type 2:{FFFFFF} ซ่อมตัวถัง (( ความเสียหายที่มองเห็น ))");
		SendClientMessage(playerid, COLOR_GRAD1, "Type 3:{FFFFFF} จั๊มแบตเตอรี่");
		SendClientMessage(playerid, COLOR_GRAD1, "Type 4:{FFFFFF} ฟื้นฟูเครื่องยนต์");
		return 1;
	}

	if(price < 0)
	    return SendClientMessage(playerid, -1, "ราคาที่ระบุไม่ถูกต้อง !");

	if(userid == playerid)
		return SendClientMessage(playerid, -1, "คุณไม่สามารถเสนอบริการให้กับตัวเองได้!");

	if(!IsPlayerConnectedEx(userid))
	    return SendClientMessage(playerid, -1, "ผู้เล่นนั้นไม่ได้เชื่อมต่อกับเซิฟเวอร์");

	if (!IsPlayerNearPlayer(playerid, userid, 10.0))
	   return SendClientMessage(playerid, -1, "ผู้เล่นนั้นตัดการเชื่อมต่อหรือไม่ได้อยู่ใกล้คุณ");

	if (!IsPlayerInAnyVehicle(userid))
        return SendClientMessage(playerid, -1, "ผู้เล่นนั้นไม่ได้อยู่บนรถ");

	pcarid = Car_GetID(GetPlayerVehicleID(userid));

	carid = Car_GetID(GetPlayerVehicleID(playerid));

	if(pcarid == -1)
	    return SendClientMessage(playerid, -1, " ผู้เล่นนั้นไม่ได้อยู่บนรถ");

	if(type >= 1 && type <= 4)
	{
		new fixname[64];
		switch(type)
		{
		    case 1: format(fixname, sizeof(fixname), "ซ่อมเครื่องยนต์");
		    case 2: format(fixname, sizeof(fixname), "ซ่อมตัวถัง");
		    case 3: format(fixname, sizeof(fixname), "จั๊มแบตเตอรี่");
		    case 4: format(fixname, sizeof(fixname), "ฟื้นฟูเครื่องยนต์");
		}

	    if (sscanf(string, "s[16]", yesstring))
	        return SendClientMessage(playerid, -1, "กรุณายืนยันบริการของคุณใช้ 'yes' ต่อท้าย");

		Character[userid][MecOffer] = playerid;
		Character[playerid][MecType]= type;
		Character[playerid][MecCar] = CarData[pcarid][carVehicle];
		Character[playerid][MecTow] = CarData[carid][carVehicle];
		Character[playerid][MecStep] = 0;
		Character[playerid][MecPrice] = price;


		SendNearbyMessage(playerid, 20.0, COLOR_RP, "* %s ได้เสนอที่จะ%s %s ของ %s", ReturnName(playerid, 0), fixname, ReturnVehicleName(CarData[pcarid][carVehicle]), ReturnName(userid, 0));
		format(string, sizeof(string), "* %s ต้องการ%s %s ของคุณในราคา %s (ใช้ \"/approve mechanic\" เพื่อยอมรับ)" , ReturnName(playerid, 0), fixname, ReturnVehicleName(CarData[pcarid][carVehicle]), FormatNumber(price));
		SendClientMessage(userid, COLOR_WHITE, string);

	}
	else return SendClientMessage(playerid, -1, "บริการที่ใช้ได้ 1-4 เท่านั้น");
	return 1;
}
