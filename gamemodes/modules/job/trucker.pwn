#include <YSI\y_hooks>

//Crate

forward PutdownProduct(playerid);
public PutdownProduct(playerid)
{
	new
	    idcrate;

	BitFlag_Off(g_PlayerFlags[playerid], PLAYER_PICKUPING);

    if(Character[playerid][CarryPD] == 1)
    {
	    idcrate = Crate_Create(playerid, 1);

		Crate_Refresh(idcrate);

		ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0);

		Character[playerid][LoadingPD] = 0;
		Character[playerid][CarryPD] = 0;
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		RemoveAttachedObject(playerid, 4);
	}
	if(Character[playerid][CarryPD] == 2)
    {
	    idcrate = Crate_Create(playerid, 2);

		Crate_Refresh(idcrate);

		ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0);

		Character[playerid][LoadingPD] = 0;
		Character[playerid][CarryPD] = 0;
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		RemoveAttachedObject(playerid, 4);
	}
	return 1;
}

forward PickupProduct(playerid, productid);
public PickupProduct(playerid, productid)
{
	SetPlayerAttachedObject(playerid,4,2912,4,0.345999,-0.554000,0.116999,0.000000,-95.599983,0.000000,0.850999,0.861000,1.000000);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	BitFlag_On(g_PlayerFlags[playerid], PLAYER_PICKUPING);
	return 1;
}

forward BuyProduct(playerid, productid);
public BuyProduct(playerid, productid)
{
	new
	    string[128];

    BitFlag_On(g_PlayerFlags[playerid], PLAYER_PICKUPING);

	if (Product_Nearest(playerid) != productid || !ProductData[productid][productExists])
	    return 0;

	switch (ProductData[productid][productType])
	{
	    case 1:
	    {
	        ProductData[productid][productAmount] -= 1;

         	SetPlayerAttachedObject(playerid,4,2912,4,0.345999,-0.554000,0.116999,0.000000,-95.599983,0.000000,0.850999,0.861000,1.000000);

      		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);

			ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);

   			Character[playerid][CarryPD] = 1;
   			Character[playerid][LoadingPD] = 1;

			Character[playerid][Cash] -= ProductData[productid][productPrice];
			GivePlayerMoney(playerid, -ProductData[productid][productPrice]);

	        format(string, sizeof(string), "คุณได้ซื้อลังที่บรรจุเนื้อด้วยราคา $%d", ProductData[productid][productPrice]);
	        SendClientMessage(playerid, COLOR_WHITE, string);
		}
		case 2:
	    {
	        ProductData[productid][productAmount] -= 1;

         	SetPlayerAttachedObject(playerid,4,2912,4,0.345999,-0.554000,0.116999,0.000000,-95.599983,0.000000,0.850999,0.861000,1.000000);

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);

			ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);

			Character[playerid][CarryPD] = 2;
			Character[playerid][LoadingPD] = 1;

			Character[playerid][Cash] -= ProductData[productid][productPrice];
			GivePlayerMoney(playerid, -ProductData[productid][productPrice]);

	        format(string, sizeof(string), "คุณได้ซื้อลังที่บรรจุเครื่องดื่มด้วยราคา $%d", ProductData[productid][productPrice]);
	        SendClientMessage(playerid, COLOR_WHITE, string);
		}
	}
	Product_Refresh(productid);
	Product_Save(productid);
	return 1;
}

forward SellProduct(playerid, productid);
public SellProduct(playerid, productid)
{
	new
	    string[128];

    BitFlag_Off(g_PlayerFlags[playerid], PLAYER_PICKUPING);

    if (Product_Nearest(playerid) != productid || !ProductData[productid][productExists])
	    return 0;

	switch (ProductData[productid][productType])
	{
	    case 1:
	    {
     		if(Character[playerid][CarryPD] != 1)
       			return SendClientMessage(playerid, -1, "ไม่สามารถขายสินค้าได้เนื่องจากชนิดสินค้าไม่ตรงกัน!");

			if(ProductData[productid][productAmount] == Product_MaxGrams(ProductData[productid][productType]))
  				return SendClientMessage(playerid, -1, "สินค้าอันนี้เต็มแล้ว!");

			ProductData[productid][productAmount] += 1;

			ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0);

			Character[playerid][LoadingPD] = 0;
			Character[playerid][CarryPD] = 0;
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			RemoveAttachedObject(playerid, 4);

			Character[playerid][Cash] += ProductData[productid][productPrice];
			GivePlayerMoney(playerid, ProductData[productid][productPrice]);

			format(string, sizeof(string), "คุณได้ขายลังที่บรรจุเนื้อด้วยราคา $%d", ProductData[productid][productPrice]);
   			SendClientMessage(playerid, COLOR_WHITE, string);
		}
		case 2:
	    {
     		if(Character[playerid][CarryPD] != 2)
       			return SendClientMessage(playerid, -1, "ไม่สามารถขายสินค้าได้เนื่องจากชนิดสินค้าไม่ตรงกัน!");

			if(ProductData[productid][productAmount] == Product_MaxGrams(ProductData[productid][productType]))
  				return SendClientMessage(playerid, -1, "สินค้าอันนี้เต็มแล้ว!");

			ProductData[productid][productAmount] += 1;

			ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0);

			Character[playerid][LoadingPD] = 0;
			Character[playerid][CarryPD] = 0;
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			RemoveAttachedObject(playerid, 4);

			Character[playerid][Cash] += ProductData[productid][productPrice];
			GivePlayerMoney(playerid, ProductData[productid][productPrice]);

			format(string, sizeof(string), "คุณได้ขายลังที่บรรจุเครื่องดื่มด้วยราคา $%d", ProductData[productid][productPrice]);
   			SendClientMessage(playerid, COLOR_WHITE, string);
		}
	}
	Product_Refresh(productid);
	Product_Save(productid);
 	return 1;
}

Dialog:Cargotrunk(playerid, response, listitem, inputtext[], carid)
{
    if (Character[playerid][LoadingPD] == 1)
 			return SendClientMessage(playerid, COLOR_WHITE, "คุณถือลังอยู่ไม่สามารถหยิบซ้ำได้!");

	if (response)
	{
		switch (listitem)
		{
		    case 0:
		    {
		        for (new i = 1; i != MAX_VEHICLES; i ++) if (IsPlayerNearBoot(playerid, i))
				{
					if(CoreVehicles[i][vehPDLoads1] < 1)
					    return SendClientMessage(playerid, COLOR_WHITE, "ในรถคันนี้ไม่มีกล่อง 'เนื้อสัตว์'!");

			        ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
			        SetPlayerAttachedObject(playerid,4,2912,4,0.345999,-0.554000,0.116999,0.000000,-95.599983,0.000000,0.850999,0.861000,1.000000);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	                Character[playerid][CarryPD] = 1;
					Character[playerid][LoadingPD] = 1;

					CoreVehicles[i][vehPDLoads1]--;
					CoreVehicles[i][vehLoads]--;
					return 1;
				}
		    }
		    case 1:
		    {
		        for (new i = 1; i != MAX_VEHICLES; i ++) if (IsPlayerNearBoot(playerid, i))
				{
                    if(CoreVehicles[i][vehPDLoads2] < 1)
					    return SendClientMessage(playerid, COLOR_WHITE, "ในรถคันนี้ไม่มีกล่อง 'เครื่องดื่ม'!");

			        ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
			        SetPlayerAttachedObject(playerid,4,2912,4,0.345999,-0.554000,0.116999,0.000000,-95.599983,0.000000,0.850999,0.861000,1.000000);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	                Character[playerid][CarryPD] = 2;
					Character[playerid][LoadingPD] = 1;

					CoreVehicles[i][vehPDLoads2]--;
					CoreVehicles[i][vehLoads]--;
					return 1;
				}
		    }
		}
	}
	return 1;
}

VehProduct(playerid, carid)
{
   	Dialog_Show(playerid, Cargotrunk, DIALOG_STYLE_LIST, "Cargo Trunk", "[กล่องสินค้า 'เนื้อสัตว์' : %d]\n[กล่องสินค้า 'เครื่องดื่ม' : %d]", "เลือก", "ยกเลิก", CoreVehicles[carid][vehPDLoads1], CoreVehicles[carid][vehPDLoads2]);
}

//Products

CMD:cargo(playerid, params[], productid)
{
    new
	    type[24],
	    idcrate,
	    id = Product_Nearest(playerid),
		string[128];

	if(Character[playerid][Job] != 1)
	    return SendClientMessage(playerid, COLOR_GREY, "คุณไม่ใช่ Trucker!");

	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
	    SendClientMessage(playerid, COLOR_GREY, "Available commands:");
	    SendClientMessage(playerid, COLOR_YELLOW, "/cargo list {FFFFFF}- แสดงรายการสินค้าที่บรรจุอยู่ในยานพาหนะที่ปลดล็อกอยู่ใกล้ๆ");
	    SendClientMessage(playerid, COLOR_YELLOW, "/cargo place {FFFFFF}- วางลังสินค้าที่ถืออยู่ไปที่ยานพาหนะใกล้ๆ");
	    SendClientMessage(playerid, COLOR_YELLOW, "/cargo putdown {FFFFFF}- วางลังสินค้าที่อยู่ลงพื้น");
	    SendClientMessage(playerid, COLOR_YELLOW, "/cargo pickup {FFFFFF}- หยิบลังสินค้าขึ้นมาจากพื้น");
	    SendClientMessage(playerid, COLOR_YELLOW, "/cargo buy {FFFFFF}- ช่วยให้คุณสามารถซื้อสินค้าจากอุตสาหกรรมได้");
	    SendClientMessage(playerid, COLOR_YELLOW, "/cargo sell {FFFFFF}- ขายสินค้ากลับคืนคลังสินค้า(จุด '/cargo buy')");
	    SendClientMessage(playerid, COLOR_YELLOW, "/cargo deliver {FFFFFF}- ขายสินค้าให้กับอุตสาหกรรม / ธุระกิจ");
		return 1;
	}

	if (!strcmp(type, "buy", true))
	{
	    if (id == -1)
	    	return SendClientMessage(playerid, COLOR_GREY, "คุณไม่ได้อยู่ในขอบเขตคลังสินค้าใดๆ");

        if (Character[playerid][LoadingPD] == 1)
 			return SendClientMessage(playerid, COLOR_WHITE, "คุณถือลังอยู่ไม่สามารถซื้ออีกได้!");

	    if(ProductData[id][productAmount] <= 0)
	        return SendClientMessage(playerid, -1, "สินค้าชนิดนี้หมดแล้วไม่สามารถซื้อได้");

		if(Character[playerid][Cash] < ProductData[id][productPrice])
			return SendClientMessage(playerid, -1, "คุณมีเงินไม่พอที่จะซื้อสินค้านี้!");

		SetTimerEx("BuyProduct", 100, false, "dd", playerid, id);
		return 1;

	}
	if (!strcmp(type, "sell", true))
	{
	    if (id == -1)
	    	return SendClientMessage(playerid, COLOR_GREY, "คุณไม่ได้อยู่ในขอบเขตคลังสินค้าใดๆ");

        if (Character[playerid][LoadingPD] == 0)
 			return SendClientMessage(playerid, COLOR_WHITE, "คุณไม่ได้ถือลังอะไรอยู่เลย!");

		SetTimerEx("SellProduct", 100, false, "dd", playerid, id);
		return 1;

	}
	if (!strcmp(type, "deliver", true))
	{
        new
	    	idpoint = ProductPoint_Nearest(playerid);

	    if (idpoint == -1)
	    	return SendClientMessage(playerid, COLOR_GREY, "คุณไม่ได้อยู่ในเขตขายใดๆ");

	    if (Character[playerid][LoadingPD] == 0)
			return SendClientMessage(playerid, COLOR_WHITE, "คุณไม่ได้ถือลังอะไรอยู่เลย!");

     	if(Character[playerid][CarryPD] == 1) //เนื้อสัตว์
	    {
			if(Character[playerid][CarryPD] != 1)
				return SendClientMessage(playerid, -1, "ไม่สามารถขายสินค้าได้เนื่องจากชนิดสินค้าไม่ตรงกัน!");

			if(ProductData[idpoint][productAmount] == Product_MaxGrams(ProductData[idpoint][productType]))
				return SendClientMessage(playerid, -1, "สินค้าอันนี้เต็มแล้ว!");

			ProductData[idpoint][productPointAmount] += 1;

			ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0);

			Character[playerid][LoadingPD] = 0;
			Character[playerid][CarryPD] = 0;
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			RemoveAttachedObject(playerid, 4);

			Character[playerid][Cash] += ProductData[idpoint][productPointPrice];
			GivePlayerMoney(playerid, ProductData[idpoint][productPointPrice]);

			format(string, sizeof(string), "คุณได้ขายลังที่บรรจุเนื้อด้วยราคา $%d", ProductData[idpoint][productPointPrice]);
			SendClientMessage(playerid, COLOR_WHITE, string);

			Product_Refresh(idpoint);
			Product_Save(idpoint);
		}

	    if(Character[playerid][CarryPD] == 2) //เครื่องดื่ม
	    {
			if(Character[playerid][CarryPD] != 2)
				return SendClientMessage(playerid, -1, "ไม่สามารถขายสินค้าได้เนื่องจากชนิดสินค้าไม่ตรงกัน!");

			if(ProductData[idpoint][productAmount] == Product_MaxGrams(ProductData[idpoint][productType]))
				return SendClientMessage(playerid, -1, "สินค้าอันนี้เต็มแล้ว!");

			ProductData[idpoint][productPointAmount] += 1;

			ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0);

			Character[playerid][LoadingPD] = 0;
			Character[playerid][CarryPD] = 0;
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			RemoveAttachedObject(playerid, 4);

			Character[playerid][Cash] += ProductData[idpoint][productPointPrice];
			GivePlayerMoney(playerid, ProductData[idpoint][productPointPrice]);

			format(string, sizeof(string), "คุณได้ขายลังที่บรรจุเครื่องดื่มด้วยราคา $%d", ProductData[idpoint][productPointPrice]);
			SendClientMessage(playerid, COLOR_WHITE, string);

			Product_Refresh(idpoint);
			Product_Save(idpoint);
	    }
		return 1;
	}
	else if (!strcmp(type, "putdown", true))
	{
 		if (Character[playerid][LoadingPD] < 1)
 			return SendClientMessage(playerid, COLOR_WHITE, "คุณไม่มีลังสินค้าอยู่ในมือ!");

        if (idcrate == -1)
	    	return SendClientMessage(playerid, COLOR_WHITE, "เซิฟเวอร์นี้ได้สร้างลังเกินขีดจำกัดแล้ว");

        if(Character[playerid][CarryPD] == 1)
        {
            SetTimerEx("PutdownProduct", 100, false, "d", playerid);
			return 1;
		}
		if(Character[playerid][CarryPD] == 2)
        {
            SetTimerEx("PutdownProduct", 100, false, "d", playerid);
			return 1;
		}
	}
	else if (!strcmp(type, "pickup", true))
	{
	    if (Character[playerid][LoadingPD] == 1)
 			return SendClientMessage(playerid, COLOR_WHITE, "คุณถือลังอยู่ไม่สามารถเก็บซ้ำได้!");

	    if((idcrate = Crate_Nearest(playerid)) != -1)
	    {
	        Character[playerid][CarryPD] = CrateData[idcrate][crateType];
			Character[playerid][LoadingPD] = 1;

			SetTimerEx("PickupProduct", 100, false, "dd", playerid, id);

			ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);

			Crate_Delete(idcrate);
			return 1;
		}
	}
	else if (!strcmp(type, "list", true))
	{
	    if (Character[playerid][LoadingPD] == 1)
 			return SendClientMessage(playerid, COLOR_WHITE, "คุณถือลังอยู่ไม่สามารถหยิบซ้ำได้!");

	    for (new i = 1; i != MAX_VEHICLES; i ++) if (IsPlayerNearBoot(playerid, i))
		{
		    VehProduct(playerid, i);
		}
	}
	else if (!strcmp(type, "place", true))
	{
        for (new i = 1; i != MAX_VEHICLES; i ++) if (IsPlayerNearBoot(playerid, i))
		{
		    if (!IsLoadableVehicle(i))
      			return SendClientMessage(playerid, COLOR_WHITE, "คุณไม่สามารถบรรจุลังลงไปในยานพาหนะคันนี้ได้");

            if (CoreVehicles[i][vehLoadType] != 0 && CoreVehicles[i][vehLoadType] != Character[playerid][LoadType])
				return SendClientMessage(playerid, COLOR_WHITE, "ยานพาหนะคันนี้ถูกบรรจุอะไรบางอย่างไว้อยู่แล้ว");

			if (CoreVehicles[i][vehLoads] >= 6)
   				return SendClientMessage(playerid, COLOR_WHITE, "ยานพาหนะคันนี้สามารถบรรจุได้เพียง 6 ลัง");

            if (Character[playerid][LoadingPD] < 1)
	    		return SendClientMessage(playerid, COLOR_WHITE, "คุณไม่มีลังสินค้าอยู่ในมือ!");

			if(Character[playerid][CarryPD] == 1)
			{
	   			CoreVehicles[i][vehLoads]++;
	   			CoreVehicles[i][vehPDLoads1]++;
	   			CoreVehicles[i][vehLoadType] = Character[playerid][LoadType];

				ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0);
	   			//SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s หยอดลังลงไปหลังรถ %s", ReturnName(playerid, 0), ReturnVehicleName(i));

	            Character[playerid][LoadingPD] = 0;
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	 			RemoveAttachedObject(playerid, 4);
			}
			if(Character[playerid][CarryPD] == 2)
			{
	   			CoreVehicles[i][vehLoads]++;
	   			CoreVehicles[i][vehPDLoads2]++;
	   			CoreVehicles[i][vehLoadType] = Character[playerid][LoadType];

				ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0);
	   			//SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s หยอดลังลงไปหลังรถ %s", ReturnName(playerid, 0), ReturnVehicleName(i));

	            Character[playerid][LoadingPD] = 0;
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	 			RemoveAttachedObject(playerid, 4);
			}
		}
	}
	return 1;
}
