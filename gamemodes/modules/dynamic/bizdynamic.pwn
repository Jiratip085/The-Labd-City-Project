#include <YSI\y_hooks>

enum businessData {
	bizID,
	bizExists,
 	bizName[32],
	bizMessage[128],
	bizOwner,
	bizType,
	bizPrice,
	Float:bizPos[4],
	Float:bizInt[4],
	Float:bizSpawn[4],
	Float:bizDeliver[3],
	bizInterior,
	bizExterior,
	bizExteriorVW,
	bizLocked,
	bizVault,
	bizProducts,
	bizPickup,
	bizShipment,
	bizPrices[20],
	Text3D:bizText3D,
	Text3D:bizDeliverText3D,
	bizDeliverPickup,
	bizIcon,
	bizMapIcon
};

new BusinessData[MAX_BUSINESSES][businessData],Total_Bizs_Created;


forward OnBusinessCreated(bizid);
public OnBusinessCreated(bizid)
{
	if (bizid == -1 || !BusinessData[bizid][bizExists])
	    return 0;

	BusinessData[bizid][bizID] = cache_insert_id();
	Business_Save(bizid);

	return 1;
}

forward Business_Load();
public Business_Load()
{
    new
	    rows,
		str[64];

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_BUSINESSES)
	{
	    BusinessData[i][bizExists] = true;
	    cache_get_value_name_int(i, "bizID", BusinessData[i][bizID]);

		cache_get_value_name(i, "bizName", BusinessData[i][bizName], 32);
        cache_get_value_name(i, "bizMessage", BusinessData[i][bizMessage], 128);

		cache_get_value_name_int(i, "bizOwner", BusinessData[i][bizOwner]);
	 	cache_get_value_name_int(i, "bizType", BusinessData[i][bizType]);
	 	cache_get_value_name_int(i, "bizPrice", BusinessData[i][bizPrice]);
	 	cache_get_value_name_float(i, "bizPosX", BusinessData[i][bizPos][0]);
	 	cache_get_value_name_float(i, "bizPosY", BusinessData[i][bizPos][1]);
	 	cache_get_value_name_float(i, "bizPosZ", BusinessData[i][bizPos][2]);
	 	cache_get_value_name_float(i, "bizPosA", BusinessData[i][bizPos][3]);
	 	cache_get_value_name_float(i, "bizIntX", BusinessData[i][bizInt][0]);
	 	cache_get_value_name_float(i, "bizIntY", BusinessData[i][bizInt][1]);
	 	cache_get_value_name_float(i, "bizIntZ", BusinessData[i][bizInt][2]);
	 	cache_get_value_name_float(i, "bizIntA", BusinessData[i][bizInt][3]);
	 	cache_get_value_name_float(i, "bizSpawnX", BusinessData[i][bizSpawn][0]);
	 	cache_get_value_name_float(i, "bizSpawnY", BusinessData[i][bizSpawn][1]);
	 	cache_get_value_name_float(i, "bizSpawnZ", BusinessData[i][bizSpawn][2]);
	 	cache_get_value_name_float(i, "bizSpawnA", BusinessData[i][bizSpawn][3]);
	 	cache_get_value_name_float(i, "bizDeliverX", BusinessData[i][bizDeliver][0]);
	 	cache_get_value_name_float(i, "bizDeliverY", BusinessData[i][bizDeliver][1]);
	 	cache_get_value_name_float(i, "bizDeliverZ", BusinessData[i][bizDeliver][2]);
	 	cache_get_value_name_int(i, "bizShipment", BusinessData[i][bizShipment]);
	 	cache_get_value_name_int(i, "bizInterior", BusinessData[i][bizInterior]);
	 	cache_get_value_name_int(i, "bizExterior", BusinessData[i][bizExterior]);
	 	cache_get_value_name_int(i, "bizExteriorVW", BusinessData[i][bizExteriorVW]);
	 	cache_get_value_name_int(i, "bizLocked", BusinessData[i][bizLocked]);
	 	cache_get_value_name_int(i, "bizVault", BusinessData[i][bizVault]);
	 	cache_get_value_name_int(i, "bizProducts", BusinessData[i][bizProducts]);
	 	cache_get_value_name_int(i, "bizIcon", BusinessData[i][bizIcon]);

		for (new j = 0; j < 20; j ++)
		{
			format(str, 32, "bizPrice%d", j + 1);
			cache_get_value_name_int(i, str, BusinessData[i][bizPrices][j]);
		}
		Business_Refresh(i);

		Total_Bizs_Created++;
	}
	for (new i = 0; i < MAX_BUSINESSES; i ++) if (BusinessData[i][bizExists])
	{
		/*if (BusinessData[i][bizType] == 5) {
			format(str, sizeof(str), "SELECT * FROM `dealervehicles` WHERE `ID` = '%d'", BusinessData[i][bizID]);

			mysql_tquery(dbCon, str, "Business_LoadCars", "d", i);
		}*/
		if (BusinessData[i][bizType] == 6) {
			format(str, sizeof(str), "SELECT * FROM `pumps` WHERE `ID` = '%d'", BusinessData[i][bizID]);

			mysql_tquery(dbCon, str, "Pump_Load", "d", i);
		}
	}
	printf("[MYSQL]: %d Bizs have been successfully loaded from the database.", Total_Bizs_Created);
	return 1;
}

Business_Create(playerid, type, price)
{
	new
	    Float:x,
	    Float:y,
	    Float:z,
		Float:angle;

	if (GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
	{
		for (new i = 0; i != MAX_BUSINESSES; i ++)
		{
	    	if (!BusinessData[i][bizExists])
		    {
    	        BusinessData[i][bizExists] = true;
        	    BusinessData[i][bizOwner] = 0;
            	BusinessData[i][bizPrice] = price;
            	BusinessData[i][bizType] = type;

				format(BusinessData[i][bizName], 32, "Business New");

    	        BusinessData[i][bizPos][0] = x;
    	        BusinessData[i][bizPos][1] = y;
    	        BusinessData[i][bizPos][2] = z;
    	        BusinessData[i][bizPos][3] = angle;

    	        BusinessData[i][bizSpawn][0] = x;
    	        BusinessData[i][bizSpawn][1] = y;
    	        BusinessData[i][bizSpawn][2] = z;
    	        BusinessData[i][bizSpawn][3] = angle;

    	        BusinessData[i][bizDeliver][0] = 0.0;
    	        BusinessData[i][bizDeliver][1] = 0.0;
    	        BusinessData[i][bizDeliver][2] = 0.0;

				if (type == 1) {
                	BusinessData[i][bizInt][0] = -27.3074;
                	BusinessData[i][bizInt][1] = -30.8741;
                	BusinessData[i][bizInt][2] = 1003.5573;
                	BusinessData[i][bizInt][3] = 0.0000;
					BusinessData[i][bizInterior] = 4;

					BusinessData[i][bizPrices][0] = 75;
		            BusinessData[i][bizPrices][1] = 125;
		            BusinessData[i][bizPrices][2] = 15;
		            BusinessData[i][bizPrices][3] = 100;
		            BusinessData[i][bizPrices][4] = 3;
		            BusinessData[i][bizPrices][5] = 2;
				}
				else if (type == 2) {
                	BusinessData[i][bizInt][0] = 316.3963;
                	BusinessData[i][bizInt][1] = -169.8375;
                	BusinessData[i][bizInt][2] = 999.6010;
                	BusinessData[i][bizInt][3] = 0.0000;
					BusinessData[i][bizInterior] = 6;

                    BusinessData[i][bizPrices][0] = 600;
                    BusinessData[i][bizPrices][1] = 600;
                    BusinessData[i][bizPrices][2] = 600;
                    BusinessData[i][bizPrices][3] = 1200;
                    BusinessData[i][bizPrices][4] = 1200;
                    BusinessData[i][bizPrices][5] = 1500;
                    BusinessData[i][bizPrices][6] = 2000;
                    BusinessData[i][bizPrices][7] = 3500;
					BusinessData[i][bizPrices][8] = 3800;
		            BusinessData[i][bizPrices][9] = 2500;
		            BusinessData[i][bizPrices][10] = 3500;
		            BusinessData[i][bizPrices][11] = 3000;
				}
				else if (type == 3) {
                	BusinessData[i][bizInt][0] = 161.4801;
                	BusinessData[i][bizInt][1] = -96.5368;
                	BusinessData[i][bizInt][2] = 1001.8047;
                	BusinessData[i][bizInt][3] = 0.0000;
					BusinessData[i][bizInterior] = 18;

					BusinessData[i][bizPrices][0] = 25;
		            BusinessData[i][bizPrices][1] = 15;
		            BusinessData[i][bizPrices][2] = 10;
		            BusinessData[i][bizPrices][3] = 10;
				}
				else if (type == 4) {
                	BusinessData[i][bizInt][0] = 363.3402;
                	BusinessData[i][bizInt][1] = -74.6679;
                	BusinessData[i][bizInt][2] = 1001.5078;
                	BusinessData[i][bizInt][3] = 315.0000;
					BusinessData[i][bizInterior] = 10;

					BusinessData[i][bizPrices][0] = 2;
		            BusinessData[i][bizPrices][1] = 5;
		            BusinessData[i][bizPrices][2] = 5;
		            BusinessData[i][bizPrices][3] = 10;
		            BusinessData[i][bizPrices][4] = 10;
		            BusinessData[i][bizPrices][5] = 15;
		            BusinessData[i][bizPrices][6] = 10;
				}
				/*else if (type == 5) {
				    BusinessData[i][bizInt][0] = 1494.5612;
	            	BusinessData[i][bizInt][1] = 1304.2061;
	            	BusinessData[i][bizInt][2] = 1093.2891;
	            	BusinessData[i][bizInt][3] = 0.0000;
					BusinessData[i][bizInterior] = 3;
				}*/
				else if (type == 6) {
                	BusinessData[i][bizInt][0] = -27.3383;
                	BusinessData[i][bizInt][1] = -57.6909;
                	BusinessData[i][bizInt][2] = 1003.5469;
                	BusinessData[i][bizInt][3] = 0.0000;
					BusinessData[i][bizInterior] = 6;

					BusinessData[i][bizPrices][0] = 75;
					BusinessData[i][bizPrices][0] = 75;
		            BusinessData[i][bizPrices][1] = 115;
		            BusinessData[i][bizPrices][2] = 15;
		            BusinessData[i][bizPrices][3] = 90;
		            BusinessData[i][bizPrices][4] = 3;
		            BusinessData[i][bizPrices][5] = 2;
		            BusinessData[i][bizPrices][6] = 10;
		            BusinessData[i][bizPrices][7] = 90;
		            BusinessData[i][bizPrices][8] = 20;
		            BusinessData[i][bizPrices][9] = 10;
		            BusinessData[i][bizPrices][10] = 140;
		            BusinessData[i][bizPrices][11] = 150;
                    BusinessData[i][bizPrices][12] = 50;
		            BusinessData[i][bizPrices][13] = 5;
		            BusinessData[i][bizPrices][14] = 10;
		            BusinessData[i][bizPrices][15] = 5;
		            BusinessData[i][bizPrices][16] = 5;
		            BusinessData[i][bizPrices][17] = 150;
		            BusinessData[i][bizPrices][18] = 10;
				}
				else if (type == 7) {
					BusinessData[i][bizInt][0] = -2240.4954;
   					BusinessData[i][bizInt][1] = 128.3774;
			   		BusinessData[i][bizInt][2] = 1035.4210;
      				BusinessData[i][bizInt][3] = 270.0000;
					BusinessData[i][bizInterior] = 6;

					BusinessData[i][bizPrices][0] = 75;
		            BusinessData[i][bizPrices][1] = 115;
		            BusinessData[i][bizPrices][2] = 15;
		            BusinessData[i][bizPrices][3] = 95;
		            BusinessData[i][bizPrices][4] = 3;
		            BusinessData[i][bizPrices][5] = 2;
		            BusinessData[i][bizPrices][6] = 10;
		            BusinessData[i][bizPrices][7] = 100;
		            BusinessData[i][bizPrices][8] = 20;
		            BusinessData[i][bizPrices][9] = 10;
		            BusinessData[i][bizPrices][10] = 140;
		            BusinessData[i][bizPrices][11] = 190;
		            BusinessData[i][bizPrices][12] = 150;
                    BusinessData[i][bizPrices][13] = 60;
                    BusinessData[i][bizPrices][14] = 50;
		            BusinessData[i][bizPrices][15] = 5;
		            BusinessData[i][bizPrices][16] = 10;
		            BusinessData[i][bizPrices][17] = 5;
				}
				else if (type == 8) {
					BusinessData[i][bizInt][0] = 0.0;
   					BusinessData[i][bizInt][1] = 0.0;
			   		BusinessData[i][bizInt][2] = 0.0;
      				BusinessData[i][bizInt][3] = 0.0;
					BusinessData[i][bizInterior] = 0;
				}
				else if (type == 11) {
					BusinessData[i][bizInt][0] = 772.4466;
	   				BusinessData[i][bizInt][1] = -4.9951;
				   	BusinessData[i][bizInt][2] = 1000.7291;
	      			BusinessData[i][bizInt][3] = 356.3190;
					BusinessData[i][bizInterior] = 5;

					BusinessData[i][bizPrices][0] = 2500;
		            BusinessData[i][bizPrices][1] = 2500;
		            BusinessData[i][bizPrices][2] = 2500;
				}
				else if (type == 11) {

					BusinessData[i][bizPrices][0] = 5000;
		            BusinessData[i][bizPrices][1] = 5000;
		            BusinessData[i][bizPrices][2] = 5000;
		            BusinessData[i][bizPrices][3] = 5000;
		            BusinessData[i][bizPrices][4] = 5000;
				}
				BusinessData[i][bizExterior] = GetPlayerInterior(playerid);
				BusinessData[i][bizExteriorVW] = GetPlayerVirtualWorld(playerid);

				BusinessData[i][bizLocked] = true;
				BusinessData[i][bizVault] = 0;
				BusinessData[i][bizProducts] = 100;
				BusinessData[i][bizShipment] = 0;
				BusinessData[i][bizIcon] = 0;

				Business_Refresh(i);
				mysql_tquery(dbCon, "INSERT INTO `businesses` (`bizOwner`) VALUES(0)", "OnBusinessCreated", "d", i);
				return i;
			}
		}
	}
	return -1;
}

Business_Delete(bizid)
{
	if (bizid != -1 && BusinessData[bizid][bizExists])
	{
	    new
	        string[82];

		format(string, sizeof(string), "DELETE FROM `businesses` WHERE `bizID` = '%d'", BusinessData[bizid][bizID]);
		mysql_tquery(dbCon, string);

        Total_Bizs_Created --;

		foreach (new i : Player) if (Character[i][Shipment] == bizid) {
			Character[i][Shipment] = -1;
			Character[i][DeliverShipment] = 0;

			DisablePlayerCheckpoint(i);
		}
        if (IsValidDynamic3DTextLabel(BusinessData[bizid][bizText3D]))
		    DestroyDynamic3DTextLabel(BusinessData[bizid][bizText3D]);

		if (IsValidDynamicPickup(BusinessData[bizid][bizPickup]))
		    DestroyDynamicPickup(BusinessData[bizid][bizPickup]);

        if (IsValidDynamicPickup(BusinessData[bizid][bizMapIcon]))
		    DestroyDynamicPickup(BusinessData[bizid][bizMapIcon]);

		Business_RemovePumps(bizid);
		//Business_RemoveCars(bizid);

	    BusinessData[bizid][bizExists] = false;
	    BusinessData[bizid][bizOwner] = 0;
	    BusinessData[bizid][bizID] = 0;
	}
	return 1;
}

Business_ProductMenu(playerid, bizid)
{
	if (bizid == -1 || !BusinessData[bizid][bizExists])
	    return 0;

	new
	    string[512];

	switch (BusinessData[bizid][bizType])
	{
	    case 1, 6:
	    {
			format(string, sizeof(string), "Mobile Phone - %s\nSpray Paint - %s\nPortable Radio - %s\nBoombox - %s\nBaseball Bat - %s",
				FormatNumber(BusinessData[bizid][bizPrices][0]),
				FormatNumber(BusinessData[bizid][bizPrices][1]),
				FormatNumber(BusinessData[bizid][bizPrices][2]),
				FormatNumber(BusinessData[bizid][bizPrices][3]),
				FormatNumber(BusinessData[bizid][bizPrices][4]),
				FormatNumber(BusinessData[bizid][bizPrices][5])
			);
			Dialog_Show(playerid, EditProduct, DIALOG_STYLE_LIST, "Business: Modify Item", string, "Modify", "Cancel");
		}
		case 2:
	    {
			format(string, sizeof(string), "Desert Eagle - %s\n9mm - %s\n.50 - %s\n12 Gauge - %s\n7.62x39mm - %s\n5.56x45mm NATO - %s\n80mm - %s\n7.62x54mmR - %s\nArmored Vest - %s\nDesert Eagle - %s\nRemington 870 - %s\nColt 45 - %s",
				FormatNumber(BusinessData[bizid][bizPrices][0]),
				FormatNumber(BusinessData[bizid][bizPrices][1]),
				FormatNumber(BusinessData[bizid][bizPrices][2]),
				FormatNumber(BusinessData[bizid][bizPrices][3]),
				FormatNumber(BusinessData[bizid][bizPrices][4]),
				FormatNumber(BusinessData[bizid][bizPrices][5]),
				FormatNumber(BusinessData[bizid][bizPrices][6]),
				FormatNumber(BusinessData[bizid][bizPrices][7]),
				FormatNumber(BusinessData[bizid][bizPrices][8]),
				FormatNumber(BusinessData[bizid][bizPrices][9]),
				FormatNumber(BusinessData[bizid][bizPrices][10]),
				FormatNumber(BusinessData[bizid][bizPrices][11])
			);
			Dialog_Show(playerid, EditProduct, DIALOG_STYLE_LIST, "Business: Modify Item", string, "Modify", "Cancel");
		}
		case 3:
	    {
			format(string, sizeof(string), "Clothes - %s\nGlasses - %s\nHats - %s\nBandana - %s",
				FormatNumber(BusinessData[bizid][bizPrices][0]),
				FormatNumber(BusinessData[bizid][bizPrices][1]),
				FormatNumber(BusinessData[bizid][bizPrices][2]),
				FormatNumber(BusinessData[bizid][bizPrices][3])
			);
			Dialog_Show(playerid, EditProduct, DIALOG_STYLE_LIST, "Business: Modify Item", string, "Modify", "Cancel");
		}
		case 4:
	    {
			format(string, sizeof(string), "Water - %s\nSoda - %s\nFrench Fries - %s\nCheeseburger - %s\nChicken Burger - %s\nChicken Nuggets - %s\nSalad - %s",
    			FormatNumber(BusinessData[bizid][bizPrices][0]),
				FormatNumber(BusinessData[bizid][bizPrices][1]),
				FormatNumber(BusinessData[bizid][bizPrices][2]),
				FormatNumber(BusinessData[bizid][bizPrices][3]),
				FormatNumber(BusinessData[bizid][bizPrices][4]),
				FormatNumber(BusinessData[bizid][bizPrices][5]),
				FormatNumber(BusinessData[bizid][bizPrices][6])
			);
			Dialog_Show(playerid, EditProduct, DIALOG_STYLE_LIST, "Business: Modify Item", string, "Modify", "Cancel");
		}
		case 7:
	    {
	        string[0] = 0;

	        for (new i = 0; i < sizeof(g_aFurnitureTypes); i ++) {
	            format(string, sizeof(string), "%s%s - %s\n", string, g_aFurnitureTypes[i], FormatNumber(BusinessData[bizid][bizPrices][i]));
			}
			Dialog_Show(playerid, EditProduct, DIALOG_STYLE_LIST, "Business: Modify Item", string, "Modify", "Cancel");
		}
		case 11:
	    {
			format(string, sizeof(string), "Boxing - %s\nKungfu - %s\nDirty - %s",
    			FormatNumber(BusinessData[bizid][bizPrices][0]),
				FormatNumber(BusinessData[bizid][bizPrices][1]),
				FormatNumber(BusinessData[bizid][bizPrices][2])
			);
			Dialog_Show(playerid, EditProduct, DIALOG_STYLE_LIST, "Business: Modify Item", string, "Modify", "Cancel");
		}
		case 12:
	    {
			format(string, sizeof(string), "Spanish - %s\nItalian - %s\nChinese - %s\nGerman - %s\nFrench - %s",
    			FormatNumber(BusinessData[bizid][bizPrices][0]),
				FormatNumber(BusinessData[bizid][bizPrices][1]),
				FormatNumber(BusinessData[bizid][bizPrices][2]),
				FormatNumber(BusinessData[bizid][bizPrices][3]),
				FormatNumber(BusinessData[bizid][bizPrices][4])
			);
			Dialog_Show(playerid, EditProduct, DIALOG_STYLE_LIST, "Business: Modify Item", string, "Modify", "Cancel");
		}
	}
	return 1;
}

Business_PurchaseMenu(playerid, bizid)
{
	if (bizid == -1 || !BusinessData[bizid][bizExists])
	    return 0;

	new
	    string[512];

	switch (BusinessData[bizid][bizType])
	{
	    case 1, 6:
	    {
			format(string, sizeof(string), "Mobile Phone - %s\nSpray Paint - %s\nPortable Radio - %s\nBoombox(ออกเกมส์แล้วหาย) - %s\nBaseball Bat - %s",
				FormatNumber(BusinessData[bizid][bizPrices][0]),
				FormatNumber(BusinessData[bizid][bizPrices][1]),
				FormatNumber(BusinessData[bizid][bizPrices][2]),
				FormatNumber(BusinessData[bizid][bizPrices][3]),
				FormatNumber(BusinessData[bizid][bizPrices][4]),
				FormatNumber(BusinessData[bizid][bizPrices][5])
			);
			Dialog_Show(playerid, BusinessBuy, DIALOG_STYLE_LIST, BusinessData[bizid][bizName], string, "ชำระเงิน", "ยกเลิก");
		}
		case 2:
	    {
			format(string, sizeof(string), ".45 Colt - %s\n9mm - %s\n.50 - %s\n12 Gauge - %s\n7.62x39mm - %s\n5.56x45mm NATO - %s\n80mm - %s\n7.62x54mmR - %s\nArmored Vest - %s\nDesert Eagle - %s\nRemington 870 - %s\nColt 45 - %s",
				FormatNumber(BusinessData[bizid][bizPrices][0]),
				FormatNumber(BusinessData[bizid][bizPrices][1]),
				FormatNumber(BusinessData[bizid][bizPrices][2]),
				FormatNumber(BusinessData[bizid][bizPrices][3]),
				FormatNumber(BusinessData[bizid][bizPrices][4]),
				FormatNumber(BusinessData[bizid][bizPrices][5]),
				FormatNumber(BusinessData[bizid][bizPrices][6]),
				FormatNumber(BusinessData[bizid][bizPrices][7]),
				FormatNumber(BusinessData[bizid][bizPrices][8]),
				FormatNumber(BusinessData[bizid][bizPrices][9]),
				FormatNumber(BusinessData[bizid][bizPrices][10]),
				FormatNumber(BusinessData[bizid][bizPrices][11])
			);
			Dialog_Show(playerid, BusinessBuy, DIALOG_STYLE_LIST, BusinessData[bizid][bizName], string, "ชำระเงิน", "ยกเลิก");
		}
		case 3:
	    {
			format(string, sizeof(string), "Glasses - %s\nHats - %s\nBandana - %s",
				FormatNumber(BusinessData[bizid][bizPrices][0]),
				FormatNumber(BusinessData[bizid][bizPrices][1]),
				FormatNumber(BusinessData[bizid][bizPrices][2]),
				FormatNumber(BusinessData[bizid][bizPrices][3])
			);
			Dialog_Show(playerid, BusinessBuy, DIALOG_STYLE_LIST, BusinessData[bizid][bizName], string, "ชำระเงิน", "ยกเลิก");
		}
		case 4:
		{
            new id = Food_Nearest(playerid);

            if (id == -1)
	    		return SendClientMessage(playerid, COLOR_GREY, "คุณไม่ได้อยู่ในขอบเขตที่ซื้ออาหารใดๆ");

	    	SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "[พนักงานขาย] พูดว่า: สวัสดีค่ะ, รับอะไรดีคะ?");

            format(string, sizeof(string), "Water - %s\nSoda - %s\nFrench Fries - %s\nCheeseburger - %s\nChicken Burger - %s\nPizza - %s\nSalad - %s",
    			FormatNumber(BusinessData[bizid][bizPrices][0]),
				FormatNumber(BusinessData[bizid][bizPrices][1]),
				FormatNumber(BusinessData[bizid][bizPrices][2]),
				FormatNumber(BusinessData[bizid][bizPrices][3]),
				FormatNumber(BusinessData[bizid][bizPrices][4]),
				FormatNumber(BusinessData[bizid][bizPrices][5]),
				FormatNumber(BusinessData[bizid][bizPrices][6])
			);
			Dialog_Show(playerid, BusinessBuy, DIALOG_STYLE_LIST, BusinessData[bizid][bizName], string, "ชำระเงิน", "ยกเลิก");
		}
		case 7:
	    {
	        string[0] = 0;

	        for (new i = 0; i < sizeof(g_aFurnitureTypes); i ++) {
	            format(string, sizeof(string), "%s%s - %s\n", string, g_aFurnitureTypes[i], FormatNumber(BusinessData[bizid][bizPrices][i]));
			}
			Dialog_Show(playerid, BusinessBuy, DIALOG_STYLE_LIST, BusinessData[bizid][bizName], string, "ชำระเงิน", "Cancel");
		}
		case 8:
	    {
			SendClientMessage(playerid, -1, "BUSINESSES:{FFFFFF} /buyinsurance, /buylock, /buygps ($5,000), /buyimmob ($5,000/level).");
		}
		case 11:
	    {
			format(string, sizeof(string), "Boxing - %s\nKungfu - %s\nDirty - %s",
				FormatNumber(BusinessData[bizid][bizPrices][0]),
				FormatNumber(BusinessData[bizid][bizPrices][1]),
				FormatNumber(BusinessData[bizid][bizPrices][2])
			);
			Dialog_Show(playerid, BusinessBuy, DIALOG_STYLE_LIST, BusinessData[bizid][bizName], string, "ชำระเงิน", "ยกเลิก");

		}
		case 12:
	    {
			format(string, sizeof(string), "Spanish - %s\nItalian - %s\nChinese - %s\nGerman - %s\nFrench - %s",
    			FormatNumber(BusinessData[bizid][bizPrices][0]),
				FormatNumber(BusinessData[bizid][bizPrices][1]),
				FormatNumber(BusinessData[bizid][bizPrices][2]),
				FormatNumber(BusinessData[bizid][bizPrices][3]),
				FormatNumber(BusinessData[bizid][bizPrices][4])
			);
			Dialog_Show(playerid, BusinessBuy, DIALOG_STYLE_LIST, BusinessData[bizid][bizName], string, "ชำระเงิน", "ยกเลิก");
		}
	}
	return 1;
}

Dialog:BusinessBuy(playerid, response, listitem, inputtext[])
{
	new
	    bizid = -1,
		price,
		string[128],
		Float:hp;

    GetPlayerHealth(playerid, hp);

    if ((bizid = Business_Inside(playerid)) != -1 && response)
    {
        price = BusinessData[bizid][bizPrices][listitem];

        if (GetMoney(playerid) < price)
            return SendClientMessage(playerid, -1, "คุณมีเงินไม่พอที่จะซื้อ");

		if (BusinessData[bizid][bizProducts] < 1)
		    return SendClientMessage(playerid, -1, "ธุรกิจนี้สินค้าหมด");

		if (BusinessData[bizid][bizType] == 1 || BusinessData[bizid][bizType] == 6)
		{
		    switch (listitem)
		    {
		        case 0:
		        {
					if(Character[playerid][Phone] != 0)
					    return SendClientMessage(playerid, -1, "คุณมีโทรศัพท์อยู่แล้ว");

					Character[playerid][Phone] = random(90000) + 10000;

					ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);

					GiveMoney(playerid, -price, "buy phone from biz %d", bizid);
					SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จ่าย %s และได้รับโทรศัพท์มือถือ", ReturnName(playerid, 0), FormatNumber(price));

					BusinessData[bizid][bizProducts]--;
					BusinessData[bizid][bizVault] += Tax_Percent(price);

					Business_Save(bizid);
					Tax_AddPercent(price);

					format(string, sizeof(string), "หมายเลขใหม่ของคุณคือ %d", Character[playerid][Phone]);
					SendClientMessage(playerid, -1, string);
				}
				case 1:
		        {
		            GivePlayerWeapon(playerid, 41, 3000);

		            ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);

		            GiveMoney(playerid, -price, "buy spray from biz %d", bizid);
					SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จ่าย %s และได้รับกระป๋องสเปรย์", ReturnName(playerid, 0), FormatNumber(price));

					BusinessData[bizid][bizProducts]--;
					BusinessData[bizid][bizVault] += Tax_Percent(price);

					Business_Save(bizid);
					Tax_AddPercent(price);
			    }
				case 2:
		        {
		            if(Character[playerid][PortableRadio] == 1)
						return SendClientMessage(playerid, -1, "คุณมีวิทยุอยู่แล้ว");

					ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);

                    GiveMoney(playerid, -price, "buy portableradio from biz %d", bizid);
					SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จ่าย %s และได้รับวิทยุ", ReturnName(playerid, 0), FormatNumber(price));

					Character[playerid][PortableRadio] = 1;

                    BusinessData[bizid][bizProducts]--;
					BusinessData[bizid][bizVault] += Tax_Percent(price);

					Business_Save(bizid);
					Tax_AddPercent(price);

					SendClientMessage(playerid, -1, "คุณได้รับวิทยุแล้วใช้ '/setchannel' เพื่อตั้งค่า");
				}
			    case 3:
			    {
					Character[playerid][BoomboxEx] = 1;

                    ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);

					GiveMoney(playerid, -price, "buy boombox from biz %d", bizid);
					SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จ่าย %s และได้รับ Boombox", ReturnName(playerid, 0), FormatNumber(price));

					BusinessData[bizid][bizProducts]--;
					BusinessData[bizid][bizVault] += Tax_Percent(price);

					Business_Save(bizid);
					Tax_AddPercent(price);
			    }
				case 4:
		        {
		           	GivePlayerWeapon(playerid, 5, 1);

                    ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);

		            GiveMoney(playerid, -price, "buy Basball from biz %d", bizid);
					SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จ่าย %s และได้รับไม้เบสบอล", ReturnName(playerid, 0), FormatNumber(price));

					BusinessData[bizid][bizProducts]--;
					BusinessData[bizid][bizVault] += Tax_Percent(price);

					Business_Save(bizid);
					Tax_AddPercent(price);
			    }
			}
		}
		
		else if (BusinessData[bizid][bizType] == 2)
		{
		    switch (listitem)
		    {
		        case 9:
				{
				    GivePlayerWeapon(playerid, 24, 50);

                    ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);

		            GiveMoney(playerid, -price, "buy Weapon from biz %d", bizid);
					SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จ่าย %s และได้รับDesert Eagle", ReturnName(playerid, 0), FormatNumber(price));

					BusinessData[bizid][bizProducts]--;
					BusinessData[bizid][bizVault] += Tax_Percent(price);

					Business_Save(bizid);
					Tax_AddPercent(price);
			    }
			    
		    }
		}

		/*else if (BusinessData[bizid][bizType] == 3)
		{
		    switch (listitem)
		    {
		        case 0:
				{
				    Character[playerid][ClothesType] = 2;
					ShowModelSelectionMenu(playerid, "Glasses", MODEL_SELECTION_CLOTHES, {19006, 19007, 19008, 19009, 19010, 19011, 19012, 19013, 19014, 19015, 19016, 19017, 19018, 19019, 19020, 19021, 19022, 19023, 19024, 19025, 19026, 19027, 19028, 19029, 19030, 19031, 19032, 19033, 19034, 19035}, 30, 0.0, 0.0, 90.0);
				}
			    case 1:
				{
				    Character[playerid][ClothesType] = 3;
					ShowModelSelectionMenu(playerid, "Hats", MODEL_SELECTION_CLOTHES, {18926, 18927, 18928, 18929, 18930, 18931, 18932, 18933, 18934, 18935, 18944, 18945, 18946, 18947, 18948, 18949, 18950, 18951}, 18, -20.0, -90.0, 0.0);
				}
				case 2:
				{
				    Character[playerid][ClothesType] = 4;
					ShowModelSelectionMenu(playerid, "Bandanas", MODEL_SELECTION_CLOTHES, {18911, 18912, 18913, 18914, 18915, 18916, 18917, 18918, 18919, 18920}, 10, 80.0, -173.0, 0.0);
				}
		    }
		}*/

		else if (BusinessData[bizid][bizType] == 4)
		{
			switch (listitem)
			{
			    case 0:
			    {

			        /*if (Character[playerid][pThirst] > 90)
			            return SystemMsg(playerid, "ตอนนี้คุณยังไม่กระหายน้ำ");*/

					//Character[playerid][pThirst] = (Character[playerid][pThirst] + 10 > 100) ? (100) : (Character[playerid][pThirst] + 10);

					GiveMoney(playerid, -price, "buy water from biz %d", bizid);
					SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จ่าย %s และได้รับน้ำ", ReturnName(playerid, 0), FormatNumber(price));

                    ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);

					BusinessData[bizid][bizProducts]--;
					BusinessData[bizid][bizVault] += Tax_Percent(price);

					Business_Save(bizid);
					Tax_AddPercent(price);
			    }
			    case 1:
			    {
			        /*if (Character[playerid][pThirst] > 90)
			            return SystemMsg(playerid, "ตอนนี้คุณยังไม่กระหายน้ำ");*/

					//Character[playerid][pThirst] = (Character[playerid][pThirst] + 20 > 100) ? (100) : (Character[playerid][pThirst] + 20);

					GiveMoney(playerid, -price, "buy water from biz %d", bizid);
					SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จ่าย %s และได้รับโซดา", ReturnName(playerid, 0), FormatNumber(price));

                    ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);

					BusinessData[bizid][bizProducts]--;
					BusinessData[bizid][bizVault] += Tax_Percent(price);

					Business_Save(bizid);
					Tax_AddPercent(price);
			    }
			    case 2:
			    {

			        if(hp >= 100.00)
			            return SendClientMessage(playerid, -1, "คุณมีเลือดเต็ม 100 แล้วไม่จำเป็นต้องกินอาหารเพิ่ม!");

                    ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);

					GiveMoney(playerid, -price, "buy food from biz %d", bizid);
					SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จ่าย %s และได้รับมันฝรั่งทอด", ReturnName(playerid, 0), FormatNumber(price));

                    GetPlayerHealth(playerid, hp);
					AC_SetPlayerHealth(playerid, hp + 20.0);

					if(hp > 100){
                        AC_SetPlayerHealth(playerid, 100.00);
					}

					BusinessData[bizid][bizProducts]--;
					BusinessData[bizid][bizVault] += Tax_Percent(price);

					Business_Save(bizid);
					Tax_AddPercent(price);
			    }
			    case 3:
			    {
			        if(hp >= 100.00)
			            return SendClientMessage(playerid, -1, "คุณมีเลือดเต็ม 100 แล้วไม่จำเป็นต้องกินอาหารเพิ่ม!");

                    ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);

					GiveMoney(playerid, -price, "buy food from biz %d", bizid);
					SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จ่าย %s และได้รับชีสเบอร์เกอร์", ReturnName(playerid, 0), FormatNumber(price));

                    GetPlayerHealth(playerid, hp);
					AC_SetPlayerHealth(playerid, hp + 30.0);

					if(hp > 100){
                        AC_SetPlayerHealth(playerid, 100.00);
					}

					BusinessData[bizid][bizProducts]--;
					BusinessData[bizid][bizVault] += Tax_Percent(price);

					Business_Save(bizid);
					Tax_AddPercent(price);
			    }
			    case 4:
			    {
			        if(hp >= 100.00)
			            return SendClientMessage(playerid, -1, "คุณมีเลือดเต็ม 100 แล้วไม่จำเป็นต้องกินอาหารเพิ่ม!");

                    ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);

					GiveMoney(playerid, -price, "buy food from biz %d", bizid);
					SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จ่าย %s และได้รับเบอร์เกอร์ไก่", ReturnName(playerid, 0), FormatNumber(price));

                    GetPlayerHealth(playerid, hp);
					AC_SetPlayerHealth(playerid, hp + 35.0);

					if(hp > 100){
                        AC_SetPlayerHealth(playerid, 100.00);
					}

					BusinessData[bizid][bizProducts]--;
					BusinessData[bizid][bizVault] += Tax_Percent(price);

					Business_Save(bizid);
					Tax_AddPercent(price);
			    }
			    case 5:
			    {
			        if(hp >= 100.00)
			            return SendClientMessage(playerid, -1, "คุณมีเลือดเต็ม 100 แล้วไม่จำเป็นต้องกินอาหารเพิ่ม!");

                    ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);

					GiveMoney(playerid, -price, "buy food from biz %d", bizid);
					SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จ่าย %s และได้รับพิซซ่า", ReturnName(playerid, 0), FormatNumber(price));

                    GetPlayerHealth(playerid, hp);
					AC_SetPlayerHealth(playerid, hp + 50.0);

					if(hp > 100){
                        AC_SetPlayerHealth(playerid, 100.00);
					}

					BusinessData[bizid][bizProducts]--;
					BusinessData[bizid][bizVault] += Tax_Percent(price);

					Business_Save(bizid);
					Tax_AddPercent(price);
			    }
			    case 6:
			    {
			        if(hp >= 100.00)
			            return SendClientMessage(playerid, -1, "คุณมีเลือดเต็ม 100 แล้วไม่จำเป็นต้องกินอาหารเพิ่ม!");

                    ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);

					GiveMoney(playerid, -price, "buy food from biz %d", bizid);
					SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จ่าย %s และได้รับการสลัด", ReturnName(playerid, 0), FormatNumber(price));

                    GetPlayerHealth(playerid, hp);
					AC_SetPlayerHealth(playerid, hp + 15.0);

					if(hp > 100){
                        AC_SetPlayerHealth(playerid, 100.00);
					}

					BusinessData[bizid][bizProducts]--;
					BusinessData[bizid][bizVault] += Tax_Percent(price);

					Business_Save(bizid);
					Tax_AddPercent(price);
			    }
			}
		}

		else if (BusinessData[bizid][bizType] == 7)
		{
		    new
				items[50] = {-1, ...},
				count;

		    for (new i = 0; i < sizeof(g_aFurnitureData); i ++) if (g_aFurnitureData[i][e_FurnitureType] == listitem + 1) {
				items[count++] = g_aFurnitureData[i][e_FurnitureModel];
		    }
		    Character[playerid][FurnitureType] = listitem;

			if (listitem == 3) {
				ShowModelSelectionMenu(playerid, "Furniture", MODEL_SELECTION_FURNITURE, items, count, -12.0, 0.0, 0.0);
			}
			else {
			    ShowModelSelectionMenu(playerid, "Furniture", MODEL_SELECTION_FURNITURE, items, count);
			}
		}
	}
	return 1;
}

Dialog:EditProduct(playerid, response, listitem, inputtext[])
{
	new
	    bizid = -1;

	if ((bizid = Business_Inside(playerid)) != -1 && Business_IsOwner(playerid, bizid))
	{
		if (response)
		{
		    new
		        item[24];

		    strmid(item, inputtext, 0, strfind(inputtext, "-") - 1);
		    strpack(Character[playerid][EditingItem], item, 32 char);

            Character[playerid][ProductModify] = listitem;
      		Dialog_Show(playerid, PriceSet, DIALOG_STYLE_INPUT, "Business: Set Price", "กรุณาป้อนราคาของ \"%s\":", "Modify", "Back", item);
		}
	}
	return 1;
}

Dialog:PriceSet(playerid, response, listitem, inputtext[])
{
    new
	    bizid = -1,
		item[32],
		string[128];

	if ((bizid = Business_Inside(playerid)) != -1 && Business_IsOwner(playerid, bizid))
	{
		if (response)
		{
		    strunpack(item, Character[playerid][EditingItem]);

			if (isnull(inputtext))
			    return Dialog_Show(playerid, PriceSet, DIALOG_STYLE_INPUT, "Business: Set Price", "กรุณาป้อนราคาของ \"%s\":", "Modify", "Back", item);

			if(Account[playerid][Admin])
			{
				if (strval(inputtext) < 1)
				    return Dialog_Show(playerid, PriceSet, DIALOG_STYLE_INPUT, "Business: Set Price", "กรุณาป้อนราคาของ \"%s\":", "Modify", "Back", item);
			}
			else
			{
				if (strval(inputtext) < 1 || strval(inputtext) > 10000)
				    return Dialog_Show(playerid, PriceSet, DIALOG_STYLE_INPUT, "Business: Set Price", "กรุณาป้อนราคาของ \"%s\" ($1 ถึง $5,000):", "Modify", "Back", item);
			}
			BusinessData[bizid][bizPrices][Character[playerid][ProductModify]] = strval(inputtext);
			Business_Save(bizid);

            format(string, sizeof(string), "คุณปรับราคาของ \"%s\" เป็นจำนวน: %s!", item, FormatNumber(strval(inputtext)));
			SendClientMessage(playerid, -1, string);
			Business_ProductMenu(playerid, bizid);
		}
		else
		{
		    Business_ProductMenu(playerid, bizid);
		}
	}
	return 1;
}

Business_Nearest(playerid, Float:radius = 3.0)
{
    for (new i = 0; i != MAX_BUSINESSES; i ++) if (BusinessData[i][bizExists] && IsPlayerInRangeOfPoint(playerid, radius, BusinessData[i][bizPos][0], BusinessData[i][bizPos][1], BusinessData[i][bizPos][2]))
	{
		if (GetPlayerInterior(playerid) == BusinessData[i][bizExterior] && GetPlayerVirtualWorld(playerid) == BusinessData[i][bizExteriorVW])
			return i;
	}
	return -1;
}

CheckBusiness_Nearest(playerid, Float:radius = 7.0)
{
    for (new i = 0; i != MAX_BUSINESSES; i ++) if (BusinessData[i][bizExists] && IsPlayerInRangeOfPoint(playerid, radius, BusinessData[i][bizPos][0], BusinessData[i][bizPos][1], BusinessData[i][bizPos][2]))
	{
		if (GetPlayerInterior(playerid) == BusinessData[i][bizExterior] && GetPlayerVirtualWorld(playerid) == BusinessData[i][bizExteriorVW])
			return i;
	}
	return -1;
}

Business_Inside(playerid)
{
	if (Character[playerid][Business] != -1)
	{
	    for (new i = 0; i != MAX_BUSINESSES; i ++) if (BusinessData[i][bizExists] && BusinessData[i][bizID] == Character[playerid][Business] && GetPlayerInterior(playerid) == BusinessData[i][bizInterior] && GetPlayerVirtualWorld(playerid) > 0) {
	        return i;
		}
	}
	return -1;
}

Business_GetCount(playerid)
{
	new
		count = 0;

	for (new i = 0; i != MAX_BUSINESSES; i ++)
	{
		if (BusinessData[i][bizExists] && Business_IsOwner(playerid, i))
   		{
   		    count++;
		}
	}
	return count;
}

Business_IsOwner(playerid, bizid)
{
	if (Character[playerid][ID] == -1)
	    return 0;

	if (BusinessData[bizid][bizExists] && BusinessData[bizid][bizOwner] == 99999999 && Account[playerid][Admin] > 0)
		return 1;

    if ((BusinessData[bizid][bizExists] && BusinessData[bizid][bizOwner] != 0) && BusinessData[bizid][bizOwner] == Character[playerid][ID])
		return 1;

	return 0;
}

Business_Save(bizid)
{
	new
	    query[2048];

	format(query, sizeof(query), "UPDATE `businesses` SET `bizName` = '%s', `bizMessage` = '%s', `bizOwner` = '%d', `bizType` = '%d', `bizPrice` = '%d', `bizPosX` = '%.4f', `bizPosY` = '%.4f', `bizPosZ` = '%.4f', `bizPosA` = '%.4f', `bizIntX` = '%.4f', `bizIntY` = '%.4f', `bizIntZ` = '%.4f', `bizIntA` = '%.4f', `bizInterior` = '%d', `bizExterior` = '%d', `bizExteriorVW` = '%d', `bizLocked` = '%d', `bizVault` = '%d', `bizProducts` = '%d'",
		SQL_ReturnEscaped(BusinessData[bizid][bizName]),
		SQL_ReturnEscaped(BusinessData[bizid][bizMessage]),
		BusinessData[bizid][bizOwner],
		BusinessData[bizid][bizType],
		BusinessData[bizid][bizPrice],
		BusinessData[bizid][bizPos][0],
		BusinessData[bizid][bizPos][1],
		BusinessData[bizid][bizPos][2],
		BusinessData[bizid][bizPos][3],
		BusinessData[bizid][bizInt][0],
		BusinessData[bizid][bizInt][1],
		BusinessData[bizid][bizInt][2],
		BusinessData[bizid][bizInt][3],
		BusinessData[bizid][bizInterior],
		BusinessData[bizid][bizExterior],
		BusinessData[bizid][bizExteriorVW],
		BusinessData[bizid][bizLocked],
		BusinessData[bizid][bizVault],
		BusinessData[bizid][bizProducts]
	);
	for (new i = 0; i < 20; i ++) {
		format(query, sizeof(query), "%s, `bizPrice%d` = '%d'", query, i + 1, BusinessData[bizid][bizPrices][i]);
	}
	format(query, sizeof(query), "%s, `bizSpawnX` = '%.4f', `bizSpawnY` = '%.4f', `bizSpawnZ` = '%.4f', `bizSpawnA` = '%.4f', `bizDeliverX` = '%.4f', `bizDeliverY` = '%.4f', `bizDeliverZ` = '%.4f', `bizShipment` = '%d', `bizIcon` = '%d' WHERE `bizID` = '%d'",
		query,
		BusinessData[bizid][bizSpawn][0],
		BusinessData[bizid][bizSpawn][1],
		BusinessData[bizid][bizSpawn][2],
		BusinessData[bizid][bizSpawn][3],
		BusinessData[bizid][bizDeliver][0],
		BusinessData[bizid][bizDeliver][1],
		BusinessData[bizid][bizDeliver][2],
		BusinessData[bizid][bizShipment],
		BusinessData[bizid][bizIcon],
		BusinessData[bizid][bizID]
	);
	return mysql_tquery(dbCon, query);
}

Business_Refresh(bizid)
{
	if (bizid != -1 && BusinessData[bizid][bizExists])
	{
		if (IsValidDynamic3DTextLabel(BusinessData[bizid][bizText3D]))
		    DestroyDynamic3DTextLabel(BusinessData[bizid][bizText3D]);

		if (IsValidDynamic3DTextLabel(BusinessData[bizid][bizDeliverText3D]))
		    DestroyDynamic3DTextLabel(BusinessData[bizid][bizDeliverText3D]);

		if (IsValidDynamicPickup(BusinessData[bizid][bizPickup]))
		    DestroyDynamicPickup(BusinessData[bizid][bizPickup]);

        if (IsValidDynamicPickup(BusinessData[bizid][bizDeliverPickup]))
		    DestroyDynamicPickup(BusinessData[bizid][bizDeliverPickup]);

	    if (IsValidDynamicPickup(BusinessData[bizid][bizMapIcon]))
	    	DestroyDynamicPickup(BusinessData[bizid][bizMapIcon]);

		new
		    string[128],
			pickup;


		switch (BusinessData[bizid][bizType]) {
		    case 1: pickup = 1276;
		    case 2: pickup = 348;
		    case 3: pickup = 1275;
		    case 4: pickup = 19094;
		    case 5,9,10: pickup = 1274;
		    case 6: pickup = 1650;
		    case 7: pickup = 2096;
		    case 8: pickup = 1239;
		    case 11: pickup = 1239;
		    case 12: pickup = 1239;
		    case 13: pickup = 1239;
		    case 14: pickup = 1239;
		    case 15: pickup = 1239;
		}
		if (BusinessData[bizid][bizType] == 6) {
        	BusinessData[bizid][bizPickup] = CreateDynamicPickup(pickup, 23, BusinessData[bizid][bizPos][0], BusinessData[bizid][bizPos][1], BusinessData[bizid][bizPos][2] + 0.3, BusinessData[bizid][bizExteriorVW], BusinessData[bizid][bizExterior]);
		}
		else if (BusinessData[bizid][bizType] == 7) {
		    BusinessData[bizid][bizPickup] = CreateDynamicPickup(pickup, 23, BusinessData[bizid][bizPos][0], BusinessData[bizid][bizPos][1], BusinessData[bizid][bizPos][2] - 0.6, BusinessData[bizid][bizExteriorVW], BusinessData[bizid][bizExterior]);
		}
		else {
            BusinessData[bizid][bizPickup] = CreateDynamicPickup(pickup, 23, BusinessData[bizid][bizPos][0], BusinessData[bizid][bizPos][1], BusinessData[bizid][bizPos][2], BusinessData[bizid][bizExteriorVW], BusinessData[bizid][bizExterior]);
		}
		if (BusinessData[bizid][bizDeliver][0] != 0.0 && BusinessData[bizid][bizDeliver][0] != 0.0 && BusinessData[bizid][bizDeliver][0] != 0.0)
		{
		    format(string, sizeof(string), "%s\n\nจุดจัดส่งสินค้า", BusinessData[bizid][bizName]);

		    BusinessData[bizid][bizPickup] = CreateDynamicPickup(1239, 23, BusinessData[bizid][bizDeliver][0], BusinessData[bizid][bizDeliver][1], BusinessData[bizid][bizDeliver][2]);
		    BusinessData[bizid][bizDeliverText3D] = CreateDynamic3DTextLabel(string, COLOR_CLIENT, BusinessData[bizid][bizDeliver][0], BusinessData[bizid][bizDeliver][1], BusinessData[bizid][bizDeliver][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0);
		}
		if (BusinessData[bizid][bizIcon] != 0)
			BusinessData[bizid][bizMapIcon] = CreateDynamicMapIcon(BusinessData[bizid][bizPos][0], BusinessData[bizid][bizPos][1], BusinessData[bizid][bizPos][2], BusinessData[bizid][bizIcon], 0, BusinessData[bizid][bizExteriorVW], BusinessData[bizid][bizExterior]);
	}
	return 1;
}

CMD:createbiz(playerid, params[])
{
    new
		type,
	    price,
	    id,
	    string[128];

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "dd", type, price))
 	{
	 	SendClientMessage(playerid, -1, "/createbiz [type] [price]");
    	SendClientMessage(playerid, COLOR_YELLOW, "[TYPES]:{FFFFFF} 1: Retail | 2: Weapons | 3: Clothes | 4: Fast Food | 5: Vehicle Dealership | 6: Gas Station | 7: Furniture | 8: Vehicle Upgrade");
    	SendClientMessage(playerid, COLOR_YELLOW, "[TYPES]:{FFFFFF} 9: Boat Dealership | 10: Airplan Dealership | 11: GYM | 12: Library");
    	return 1;
	}
	if (type < 1 || type > 12)
	    return SendClientMessage(playerid, -1, "ประเภทที่ระบุไม่ถูกต้อง ประเภทต้องอยู่ในระหว่าง 1 ถึง 12");

	id = Business_Create(playerid, type, price);

	if (id == -1)
	    return SendClientMessage(playerid, -1, "เซิฟเวอร์นี้ได้สร้างธุรกิจเกินขีดจำกัดแล้ว");

    format(string, sizeof(string), "คุณได้สร้างธรุกิจสำเร็จแล้ว: %d", id);
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:editbiz(playerid, params[])
{
	new
	    id,
	    type[24],
	    string[128];

	if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendClientMessage(playerid, -1, "/editbiz [id] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, interior, mapicon, deliver, name, price, stock, type, spawn, vault, owner");
		return 1;
	}
	if ((id < 0 || id >= MAX_BUSINESSES) || !BusinessData[id][bizExists])
	    return SendClientMessage(playerid, -1, "คุณระบุไอดีธุรกิจไม่ถูกต้อง");

	if (!strcmp(type, "location", true))
	{
 		GetPlayerPos(playerid, BusinessData[id][bizPos][0], BusinessData[id][bizPos][1], BusinessData[id][bizPos][2]);
		GetPlayerFacingAngle(playerid, BusinessData[id][bizPos][3]);

		BusinessData[id][bizExterior] = GetPlayerInterior(playerid);
		BusinessData[id][bizExteriorVW] = GetPlayerVirtualWorld(playerid);

		Business_Refresh(id);
		Business_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับตำแหน่งของธุรกิจไอดี: %d", ReturnRealName(playerid, 0), id);
	}
	else if (!strcmp(type, "interior", true))
	{
	    if(BusinessData[id][bizType] == 8)
	        return SendClientMessage(playerid, -1, "ธุรกิจนี้ไม่มีภายใน");

	    GetPlayerPos(playerid, BusinessData[id][bizInt][0], BusinessData[id][bizInt][1], BusinessData[id][bizInt][2]);
		GetPlayerFacingAngle(playerid, BusinessData[id][bizInt][3]);

		BusinessData[id][bizInterior] = GetPlayerInterior(playerid);

        foreach (new i : Player)
		{
			if (Character[i][Business] == BusinessData[id][bizID])
			{
				SetPlayerPosEx(i, BusinessData[id][bizInt][0], BusinessData[id][bizInt][1], BusinessData[id][bizInt][2],BusinessData[id][bizInterior], -1);
				SetPlayerFacingAngle(i, BusinessData[id][bizInt][3]);

				SetPlayerInterior(i, BusinessData[id][bizInterior]);
				SetCameraBehindPlayer(i);
			}
		}
		Business_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับตำแหน่งจุดเกิดภายในของธุรกิจไอดี: %d", ReturnRealName(playerid, 0), id);
	}
	else if (!strcmp(type, "deliver", true))
	{
	    if (BusinessData[id][bizType] == 5)
	        return SendClientMessage(playerid, -1, "ธุรกิจนี้ไม่จำเป็นต้องมีการรับจัดส่งสินค้า");

	    if (GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
	        return SendClientMessage(playerid, -1, "คุณสามารถวางจุดจัดส่งสินค้าได้ข้างนอกอาคารเท่านั้น");

	    GetPlayerPos(playerid, BusinessData[id][bizDeliver][0], BusinessData[id][bizDeliver][1], BusinessData[id][bizDeliver][2]);
		Business_Refresh(id);

		Business_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับจุดจัดส่งสินค้าของธุรกิจไอดี: %d", ReturnRealName(playerid, 0), id);
	}
	else if (!strcmp(type, "mapicon", true))
	{
	    new icon;

	    if (sscanf(string, "d", icon))
	        return SendClientMessage(playerid, -1, "/editbiz [id] [mapicon] [map icon]");

		if (icon < 0 || icon > 63)
		    return SendClientMessage(playerid, -1, "ไอคอนแผนที่ไม่ถูกต้อง! ไอคอนแผนที่สามารถดูเพิ่มเติมได้ที่\"wiki.sa-mp.com/wiki/MapIcons\"");

	    BusinessData[id][bizIcon] = icon;

	    Business_Refresh(id);
	    Business_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับไอคอนเมพธุรกิจไอดี: %d เป็น %d", ReturnRealName(playerid, 0), id, icon);
	}
	else if (!strcmp(type, "price", true))
	{
	    new price;

	    if (sscanf(string, "d", price))
	        return SendClientMessage(playerid, -1, "/editbiz [id] [price] [new price]");

	    BusinessData[id][bizPrice] = price;

	    Business_Refresh(id);
	    Business_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับราคาของธุรกิจไอดี: %d เป็น %s", ReturnRealName(playerid, 0), id, FormatNumber(price));
	}
	else if (!strcmp(type, "stock", true))
	{
	    new amount;

	    if (sscanf(string, "d", amount))
	        return SendClientMessage(playerid, -1, "/editbiz [id] [stock] [product amount]");

	    BusinessData[id][bizProducts] = amount;

	    Business_Refresh(id);
	    Business_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับสินค้าของธุรกิจไอดี: %d เป็นจำนวน %s", ReturnRealName(playerid, 0), id, FormatNumber(amount));
	}
	else if (!strcmp(type, "vault", true))
	{
	    new amount;

	    if (sscanf(string, "d", amount))
	        return SendClientMessage(playerid, -1, "/editbiz [id] [vault] [vault amount]");

	    BusinessData[id][bizVault] = amount;

	    Business_Refresh(id);
	    Business_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับคลังของธุรกิจไอดี: %d เป็นจำนวน %s", ReturnRealName(playerid, 0), id, FormatNumber(amount));
	}
	else if (!strcmp(type, "owner", true))
	{
	    new amount;

	    if (sscanf(string, "d", amount))
	        return SendClientMessage(playerid, -1, "/editbiz [id] [owner] [owner id]");

	    BusinessData[id][bizOwner] = amount;

	    Business_Refresh(id);
	    Business_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับเจ้าของของธุรกิจไอดี: %d เป็นจำนวน %d", ReturnRealName(playerid, 0), id, amount);
	}
	else if (!strcmp(type, "name", true))
	{
	    new name[32];

	    if (sscanf(string, "s[32]", name))
	        return SendClientMessage(playerid, -1, "/editbiz [id] [name] [new name]");

	    format(BusinessData[id][bizName], 32, name);

	    Business_Refresh(id);
	    Business_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับชื่อของธุรกิจไอดี: %d เป็น \"%s\"", ReturnRealName(playerid, 0), id, name);
	}

	else if (!strcmp(type, "type", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
	    {
	        SendClientMessage(playerid, -1, "/editbiz [id] [type] [business type]");
			SendClientMessage(playerid, COLOR_YELLOW, "[TYPES]:{FFFFFF} 1: Retail | 2: Weapons | 3: Clothes | 4: Fast Food | 5: Car Dealership | 6: Gas Station | 7: Furniture | 8: Vehicle Upgrade");
			SendClientMessage(playerid, COLOR_YELLOW, "[TYPES]:{FFFFFF} 11: GYM | 12: Library");
			return 1;
		}
		if (typeint < 1 || typeint > 12)
			return SendClientMessage(playerid, -1, "ประเภทที่ระบุต้องไม่ต่ำกว่า 1 และมากกว่า 12");

        BusinessData[id][bizType] = typeint;

        switch (typeint) {
            case 1: {
            	BusinessData[id][bizInt][0] = -27.3074;
           		BusinessData[id][bizInt][1] = -30.8741;
            	BusinessData[id][bizInt][2] = 1003.5573;
            	BusinessData[id][bizInt][3] = 0.0000;
				BusinessData[id][bizInterior] = 4;
            }
            case 2: {
            	BusinessData[id][bizInt][0] = 316.3963;
            	BusinessData[id][bizInt][1] = -169.8375;
            	BusinessData[id][bizInt][2] = 999.6010;
            	BusinessData[id][bizInt][3] = 0.0000;
				BusinessData[id][bizInterior] = 6;
			}
			case 3: {
            	BusinessData[id][bizInt][0] = 161.4801;
            	BusinessData[id][bizInt][1] = -96.5368;
            	BusinessData[id][bizInt][2] = 1001.8047;
            	BusinessData[id][bizInt][3] = 0.0000;
				BusinessData[id][bizInterior] = 18;
			}
			case 4: {
            	BusinessData[id][bizInt][0] = 363.3402;
            	BusinessData[id][bizInt][1] = -74.6679;
            	BusinessData[id][bizInt][2] = 1001.5078;
            	BusinessData[id][bizInt][3] = 315.0000;
				BusinessData[id][bizInterior] = 10;
			}
			/*case 5: {
            	BusinessData[id][bizInt][0] = 1494.5612;
            	BusinessData[id][bizInt][1] = 1304.2061;
            	BusinessData[id][bizInt][2] = 1093.2891;
            	BusinessData[id][bizInt][3] = 0.0000;
				BusinessData[id][bizInterior] = 3;
			}*/
			case 6: {
				BusinessData[id][bizInt][0] = -27.3383;
   				BusinessData[id][bizInt][1] = -57.6909;
			   	BusinessData[id][bizInt][2] = 1003.5469;
      			BusinessData[id][bizInt][3] = 0.0000;
				BusinessData[id][bizInterior] = 6;
			}
			case 7: {
				BusinessData[id][bizInt][0] = -2240.4954;
   				BusinessData[id][bizInt][1] = 128.3774;
			   	BusinessData[id][bizInt][2] = 1035.4210;
      			BusinessData[id][bizInt][3] = 270.0000;
				BusinessData[id][bizInterior] = 6;
			}
			case 8: {
				BusinessData[id][bizInt][0] = 0.0;
   				BusinessData[id][bizInt][1] = 0.0;
			   	BusinessData[id][bizInt][2] = 0.0;
      			BusinessData[id][bizInt][3] = 0.0;
				BusinessData[id][bizInterior] = 0;
			}
			case 11: {
				BusinessData[id][bizInt][0] = 772.4466;
   				BusinessData[id][bizInt][1] = -4.9951;
			   	BusinessData[id][bizInt][2] = 1000.7291;
      			BusinessData[id][bizInt][3] = 356.3190;
				BusinessData[id][bizInterior] = 5;
			}
		}
		foreach (new i : Player)
		{
			if (Character[i][Business] == BusinessData[id][bizID])
			{
				SetPlayerPosEx(i, BusinessData[id][bizInt][0], BusinessData[id][bizInt][1], BusinessData[id][bizInt][2],BusinessData[id][bizInterior], 0);
				SetPlayerFacingAngle(i, BusinessData[id][bizInt][3]);

				//SetPlayerInterior(i, BusinessData[id][bizInterior]);
				SetCameraBehindPlayer(i);
			}
		}
		Business_Refresh(id);

	    Business_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับประเภทของธุรกิจไอดี: %d เป็น %d", ReturnRealName(playerid, 0), id, typeint);
	}
	/*else if (!strcmp(type, "cars", true))
	{
	    if (BusinessData[id][bizType] != 5)
	        return SendClientMessage(playerid, -1, "ธุรกิจนี้ไม่ใช่ตัวแทนจำหน่าย!");

		Character[playerid][pDealership] = id;
		Business_EditCars(playerid, id);
	}*/
	else if (!strcmp(type, "spawn", true))
	{
	    if (BusinessData[id][bizType] != 5 && BusinessData[id][bizType] != 8 && BusinessData[id][bizType] != 9 && BusinessData[id][bizType] != 10)
	        return SendClientMessage(playerid, -1, "ธุรกิจนี้ไม่ใช่ตัวแทนจำหน่าย!");

	    if (GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
	        return SendClientMessage(playerid, -1, "คุณสามารถวางจุดเกิดยานพาหนะได้ข้างนอกอาคารเท่านั้น");

	    GetPlayerPos(playerid, BusinessData[id][bizSpawn][0], BusinessData[id][bizSpawn][1], BusinessData[id][bizSpawn][2]);
		GetPlayerFacingAngle(playerid, BusinessData[id][bizSpawn][3]);

		BusinessData[id][bizExterior] = GetPlayerInterior(playerid);

		Business_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับจุดเกิดยานพาหนะของธุรกิจไอดี: %d", ReturnRealName(playerid, 0), id);
	}
	return 1;
}

CMD:destroybiz(playerid, params[])
{
	new
	    id = 0,
	    string[128];

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, -1, "/destroybiz [biz id]");

	if ((id < 0 || id >= MAX_BUSINESSES) || !BusinessData[id][bizExists])
	    return SendClientMessage(playerid, -1, "คุณระบุไอดีธุรกิจไม่ถูกต้อง");

	Business_Delete(id);
	format(string, sizeof(string), "คุณได้ประสบความสำเร็จในการทำลายธุรกิจไอดี: %d", id);
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:products(playerid, params[])
{
	new
	    bizid = -1;

	if ((bizid = Business_Inside(playerid)) != -1 && Business_IsOwner(playerid, bizid)) {
	    Business_ProductMenu(playerid, bizid);
	}
	else SendClientMessage(playerid, -1, "คุณไม่ได้อยู่ในขอบเขตภายในธุรกิจของคุณ");
	return 1;
}
