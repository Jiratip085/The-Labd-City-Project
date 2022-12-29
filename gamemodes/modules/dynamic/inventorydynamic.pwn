#include <YSI\y_hooks>

enum invfurnitureData {
	invExists,
	invID,
	invItem[32 char],
	invModel,
	invQuantity
};
new InvFurnitureData[MAX_PLAYERS][MAX_INVENTORYFURNITURE][invfurnitureData];

enum droppedItems {
	droppedID,
	droppedItem[32],
	droppedPlayer[24],
	droppedModel,
	droppedQuantity,
	Float:droppedPos[3],
	droppedInt,
	droppedWorld,
	droppedObject,
	Text3D:droppedText3D
};

new DroppedItems[MAX_DROPPED_ITEMS][droppedItems];

new const g_arrInteriorData[][e_InteriorData] = {
	{"24/7 1", 17, -25.884498, -185.868988, 1003.546875},
    {"24/7 2", 10, 6.091179, -29.271898, 1003.549438},
    {"24/7 3", 18, -30.946699, -89.609596, 1003.546875},
    {"24/7 4", 16, -25.132598, -139.066986, 1003.546875},
    {"24/7 5", 4, -27.312299, -29.277599, 1003.557250},
    {"24/7 6", 6, -26.691598, -55.714897, 1003.546875},
    {"Airport Ticket", 14, -1827.147338, 7.207417, 1061.143554},
    {"Airport Baggage", 14, -1861.936889, 54.908092, 1061.143554},
    {"Shamal", 1, 1.808619, 32.384357, 1199.593750},
    {"Andromada", 9, 315.745086, 984.969299, 1958.919067},
    {"Ammunation 1", 1, 286.148986, -40.644397, 1001.515625},
    {"Ammunation 2", 4, 286.800994, -82.547599, 1001.515625},
    {"Ammunation 3", 6, 296.919982, -108.071998, 1001.515625},
    {"Ammunation 4", 7, 314.820983, -141.431991, 999.601562},
    {"Ammunation 5", 6, 316.524993, -167.706985, 999.593750},
    {"Ammunation Booths", 7, 302.292877, -143.139099, 1004.062500},
    {"Ammunation Range", 7, 298.507934, -141.647048, 1004.054748},
    {"Blastin Fools Hallway", 3, 1038.531372, 0.111030, 1001.284484},
    {"Budget Inn Motel Room", 12, 444.646911, 508.239044, 1001.419494},
    {"Jefferson Motel", 15, 2215.454833, -1147.475585, 1025.796875},
    {"Off Track Betting Shop", 3, 833.269775, 10.588416, 1004.179687},
    {"Sex Shop", 3, -103.559165, -24.225606, 1000.718750},
    {"Meat Factory", 1, 963.418762, 2108.292480, 1011.030273},
    {"Zero's RC shop", 6, -2240.468505, 137.060440, 1035.414062},
    {"Dillimore Gas", 0, 663.836242, -575.605407, 16.343263},
    {"Catigula's Basement", 1, 2169.461181, 1618.798339, 999.976562},
    {"FC Janitor Room", 10, 1889.953369, 1017.438293, 31.882812},
    {"Woozie's Office", 1, -2159.122802, 641.517517, 1052.381713},
    {"Binco", 15, 207.737991, -109.019996, 1005.132812},
    {"Didier Sachs", 14, 204.332992, -166.694992, 1000.523437},
    {"Prolaps", 3, 207.054992, -138.804992, 1003.507812},
    {"Suburban", 1, 203.777999, -48.492397, 1001.804687},
    {"Victim", 5, 226.293991, -7.431529, 1002.210937},
    {"Zip", 18, 161.391006, -93.159156, 1001.804687},
    {"Club", 17, 493.390991, -22.722799, 1000.679687},
    {"Bar", 11, 501.980987, -69.150199, 998.757812},
    {"Lil' Probe Inn", 18, -227.027999, 1401.229980, 27.765625},
    {"Jay's Diner", 4, 457.304748, -88.428497, 999.554687},
    {"Gant Bridge Diner", 5, 454.973937, -110.104995, 1000.077209},
    {"Secret Valley Diner", 6, 435.271331, -80.958938, 999.554687},
    {"World of Coq", 1, 452.489990, -18.179698, 1001.132812},
    {"Welcome Pump", 1, 681.557861, -455.680053, -25.609874},
    {"Burger Shot", 10, 375.962463, -65.816848, 1001.507812},
    {"Cluckin' Bell", 9, 369.579528, -4.487294, 1001.858886},
    {"Well Stacked Pizza", 5, 373.825653, -117.270904, 1001.499511},
    {"Rusty Browns Donuts", 17, 381.169189, -188.803024, 1000.632812},
    {"Denise's Room", 1, 244.411987, 305.032989, 999.148437},
    {"Katie's Room", 2, 271.884979, 306.631988, 999.148437},
    {"Helena's Room", 3, 291.282989, 310.031982, 999.148437},
    {"Michelle's Room", 4, 302.180999, 300.722991, 999.148437},
    {"Barbara's Room", 5, 322.197998, 302.497985, 999.148437},
    {"Millie's Room", 6, 346.870025, 309.259033, 999.155700},
    {"Sherman Dam", 17, -959.564392, 1848.576782, 9.000000},
    {"Planning Dept", 3, 384.808624, 173.804992, 1008.382812},
    {"Area 51", 0, 223.431976, 1872.400268, 13.734375},
    {"LS Gym", 5, 772.111999, -3.898649, 1000.728820},
    {"SF Gym", 6, 774.213989, -48.924297, 1000.585937},
    {"LV Gym", 7, 773.579956, -77.096694, 1000.655029},
    {"B-Dup's House", 3, 1527.229980, -11.574499, 1002.097106},
    {"B-Dup's Crack Pad", 2, 1523.509887, -47.821197, 1002.130981},
    {"CJ's House", 3, 2496.049804, -1695.238159, 1014.742187},
    {"Madd Doggs Mansion", 5, 1267.663208, -781.323242, 1091.906250},
    {"OG Loc's House", 3, 513.882507, -11.269994, 1001.565307},
    {"Ryders House", 2, 2454.717041, -1700.871582, 1013.515197},
    {"Sweet's House", 1, 2527.654052, -1679.388305, 1015.498596},
    {"Crack Factory", 2, 2543.462646, -1308.379882, 1026.728393},
    {"Big Spread Ranch", 3, 1212.019897, -28.663099, 1000.953125},
    {"Fanny batters", 6, 761.412963, 1440.191650, 1102.703125},
    {"Strip Club", 2, 1204.809936, -11.586799, 1000.921875},
    {"Strip Club (Private Room)", 2, 1204.809936, 13.897239, 1000.921875},
    {"Unnamed Brothel", 3, 942.171997, -16.542755, 1000.929687},
    {"Tiger Skin Brothel", 3, 964.106994, -53.205497, 1001.124572},
    {"Pleasure Domes", 3, -2640.762939, 1406.682006, 906.460937},
    {"Liberty City Outside", 1, -729.276000, 503.086944, 1371.971801},
    {"Liberty City Inside", 1, -794.806396, 497.738037, 1376.195312},
    {"Gang House", 5, 2350.339843, -1181.649902, 1027.976562},
    {"Colonel Furhberger's", 8, 2807.619873, -1171.899902, 1025.570312},
    {"Crack Den", 5, 318.564971, 1118.209960, 1083.882812},
    {"Warehouse 1", 1, 1412.639892, -1.787510, 1000.924377},
    {"Warehouse 2", 18, 1302.519897, -1.787510, 1001.028259},
    {"Sweet's Garage", 0, 2522.000000, -1673.383911, 14.866223},
    {"Lil' Probe Inn Toilet", 18, -221.059051, 1408.984008, 27.773437},
    {"Unused Safe House", 12, 2324.419921, -1145.568359, 1050.710083},
    {"RC Battlefield", 10, -975.975708, 1060.983032, 1345.671875},
    {"Barber 1", 2, 411.625976, -21.433298, 1001.804687},
    {"Barber 2", 3, 418.652984, -82.639793, 1001.804687},
    {"Barber 3", 12, 412.021972, -52.649898, 1001.898437},
    {"Tatoo Parlor 1", 16, -204.439987, -26.453998, 1002.273437},
    {"Tatoo Parlor 2", 17, -204.439987, -8.469599, 1002.273437},
    {"Tatoo Parlor 3", 3, -204.439987, -43.652496, 1002.273437},
    {"LS Police HQ", 6, 246.783996, 63.900199, 1003.640625},
    {"SF Police HQ", 10, 246.375991, 109.245994, 1003.218750},
    {"LV Police HQ", 3, 288.745971, 169.350997, 1007.171875},
    {"Driving School", 3, -2029.798339, -106.675910, 1035.171875},
    {"8-Track", 7, -1398.065307, -217.028900, 1051.115844},
    {"Bloodbowl", 15, -1398.103515, 937.631164, 1036.479125},
    {"Dirt Track", 4, -1444.645507, -664.526000, 1053.572998},
    {"Kickstart", 14, -1465.268676, 1557.868286, 1052.531250},
    {"Vice Stadium", 1, -1401.829956, 107.051300, 1032.273437},
    {"SF Garage", 0, -1790.378295, 1436.949829, 7.187500},
    {"LS Garage", 0, 1643.839843, -1514.819580, 13.566620},
    {"SF Bomb Shop", 0, -1685.636474, 1035.476196, 45.210937},
    {"Blueberry Warehouse", 0, 76.632553, -301.156829, 1.578125},
    {"LV Warehouse 1", 0, 1059.895996, 2081.685791, 10.820312},
    {"LV Warehouse 2 (hidden part)", 0, 1059.180175, 2148.938720, 10.820312},
    {"Caligula's Hidden Room", 1, 2131.507812, 1600.818481, 1008.359375},
    {"Bank", 0, 2315.952880, -1.618174, 26.742187},
    {"Bank (Behind Desk)", 0, 2319.714843, -14.838361, 26.749565},
    {"LS Atrium", 18, 1710.433715, -1669.379272, 20.225049}
};


enum e_AccessoryData {
	e_AccessoryName[32],
	e_AccessoryModel
};

new const g_aAccessoryData[][e_AccessoryData] = {
	{"GlassesType1", 19006},
	{"GlassesType2", 19007},
	{"GlassesType3", 19008},
	{"GlassesType4", 19009},
	{"GlassesType5", 19010},
	{"GlassesType6", 19011},
	{"GlassesType7", 19012},
	{"GlassesType8", 19013},
	{"GlassesType9", 19014},
	{"GlassesType10", 19015},
	{"GlassesType11", 19016},
	{"GlassesType12", 19017},
	{"GlassesType13", 19018},
	{"GlassesType14", 19019},
	{"GlassesType15", 19020},
	{"GlassesType16", 19021},
	{"GlassesType17", 19022},
	{"GlassesType18", 19023},
	{"GlassesType19", 19024},
	{"GlassesType20", 19025},
	{"GlassesType21", 19026},
	{"GlassesType22", 19027},
	{"GlassesType23", 19028},
	{"GlassesType24", 19029},
	{"GlassesType25", 19030},
	{"GlassesType26", 19031},
	{"GlassesType27", 19032},
	{"GlassesType28", 19033},
	{"GlassesType29", 19034},
	{"GlassesType30", 19035},
	{"PoliceGlasses1", 19138},
	{"PoliceGlasses2", 19139},
	{"PoliceGlasses3", 19140},
	{"Bandana1", 18891},
	{"Bandana2", 18892},
	{"Bandana3", 18893},
	{"Bandana4", 18894},
	{"Bandana5", 18895},
	{"Bandana6", 18896},
	{"Bandana7", 18897},
	{"Bandana8", 18898},
	{"Bandana9", 18899},
	{"Bandana10", 18900},
	{"Bandana11", 18901},
	{"Bandana12", 18902},
	{"Bandana13", 18903},
	{"Bandana14", 18904},
	{"Bandana15", 18905},
	{"Bandana16", 18906},
	{"Bandana17", 18907},
	{"Bandana18", 18908},
	{"Bandana19", 18909},
	{"Bandana20", 18910},
	{"Mask1", 18911},
	{"Mask2", 18912},
	{"Mask3", 18913},
	{"Mask4", 18914},
	{"Mask5", 18915},
	{"Mask6", 18916},
	{"Mask7", 18917},
	{"Mask8", 18918},
	{"Mask9", 18919},
	{"Mask10", 18920},
	{"HockeyMask1", 19036},
	{"HockeyMask2", 19037},
	{"HockeyMask3", 19038},
	{"MaskZorro1", 18974},
	{"HatBowler1", 18944},
	{"HatBowler2", 18945},
	{"HatBowler3", 18946},
	{"HatBowler4", 18947},
	{"HatBowler5", 18948},
	{"HatBowler6", 18949},
	{"HatBowler7", 18950},
	{"HatBowler8", 18951},
	{"CapBack1", 18939},
	{"CapBack3", 18940},
	{"CapBack4", 18942},
	{"CapBack5", 18943},
	{"CapOverEye1", 18955},
	{"CapOverEye2", 18956},
	{"CapOverEye3", 18957},
	{"CapOverEye4", 18958},
	{"CapOverEye5", 18959},
	{"CowboyHat1", 19095},
	{"CowboyHat2", 18962},
	{"CowboyHat3", 19096},
	{"CowboyHat4", 19097},
	{"CowboyHat5", 19098},
	{"Hat1", 18926},
	{"Hat2", 18927},
	{"Hat3", 18928},
	{"Hat4", 18929},
	{"Hat5", 18930},
	{"Hat6", 18931},
	{"Hat7", 18932},
	{"Hat8", 18933},
	{"Hat9", 18934},
	{"Hat10", 18935},
	{"HardHat2", 19093},
	{"HardHat3", 19160},
	{"BurgerShotHat1", 19094},
	{"CluckinBellHat1", 19137},
	{"PoliceHat1", 19161},
	{"PoliceHat2", 19162},
	{"HatCool1", 18971},
	{"HatCool2", 18972},
	{"HatCool3", 18973},
	{"HatTiger1", 18970},
	{"HatMan1", 18969},
	{"HatMan2", 18968},
	{"PoliceCap1", 18636},
	{"PoliceCap2", 19099},
	{"PoliceCap3", 19100},

	{"ArmyHelmet1", 19101},
	{"ArmyHelmet2", 19102},
	{"ArmyHelmet3", 19103},
	{"ArmyHelmet4", 19104},
	{"ArmyHelmet5", 19105},
	{"ArmyHelmet6", 19106},
	{"ArmyHelmet7", 19107},
	{"ArmyHelmet8", 19108},
	{"ArmyHelmet9", 19109},
	{"ArmyHelmet10", 19110},
	{"ArmyHelmet11", 19111},
	{"ArmyHelmet12", 19112},

	{"SillyHelmet1", 19113},
	{"SillyHelmet2", 19114},
	{"SillyHelmet3", 19115},
	{"PlainHelmet1", 19116},
	{"PlainHelmet2", 19117},
	{"PlainHelmet3", 19118},
	{"SillyHelmet4", 19119},
	{"SillyHelmet5", 19120},
	{"SkullyCap1", 18964},
	{"SkullyCap2", 18965},
	{"SkullyCap3", 18966},
	{"SantaHat1", 19064},
	{"SantaHat2", 19065},
	{"SantaHat3", 19066},

	{"StrawHat 1", 19553},
	{"Beanie 1", 19554},
	{"Boxing Glove L", 19555},
	{"Boxing Glove R", 19556},
	{"Sexy Mask 1", 19557},
	{"Pizza Hat 1", 19558},
	{"Hiker Backpack 1", 19559},


	{"Balaclava1", 19801},

	{"SWAT Helmet 1", 19141},
	{"SWAT Armour 1", 19142},

	{"Fire Hat 1", 19330},
	{"Fire Hat 2", 19331},

	{"Construction Vest 1", 19904},
	{"Gun Holster 1", 19773},
	{"Medkit Model", 11738},
	{"Pilot Hat 1", 19520},
	{"Police Hat 1", 19521},

	{"Badge", 19347},
	{"Cane", 19348},
	{"Moustache 1", 19350},
	{"Moustache 2", 19351},
	{"Tophat 1", 19352},
	{"Gas Mask 1", 19472},

	{"Pumpkin Head", 19320},

	{"Witches Hat", 19528},

	{"Parrot 1", 19078},
	{"Parrot 2", 19079},
	{"Motorcycle Helmet 1", 18645},
	{"hairpiece 1", 19077},
	{"hairpiece 2", 18975},
	{"Hat Pizza", 19558}
};

forward OnLoadStorage(houseid);
public OnLoadStorage(houseid)
{
	new
	    rows,
		str[32];

	cache_get_row_count(rows);

	for (new i = 0; i != rows; i ++) {
		HouseStorage[houseid][i][hItemExists] = true;
		cache_get_value_name_int(i, "itemID", HouseStorage[houseid][i][hItemID]);
		cache_get_value_name_int(i, "itemModel", HouseStorage[houseid][i][hItemModel]);
		cache_get_value_name_int(i, "itemQuantity", HouseStorage[houseid][i][hItemQuantity]);
		cache_get_value_name_int(i, "itemExtended", HouseStorage[houseid][i][hItemExtended]);


        strpack(HouseStorage[houseid][i][hItemName], str, 32 char);
        cache_get_value_name(i, "itemName", str, 32);
	}
	return 1;
}

Dialog:PickupItems(playerid, response, listitem, inputtext[])
{
	static
	    string[64];

	if (response)
	{
	    new id = NearestItems[playerid][listitem];

		if (id != -1 && DroppedItems[id][droppedModel])
		{
			if (PickupItem(playerid, id))
			{
				format(string, sizeof(string), "~g~%s~w~ added to inventory!", DroppedItems[id][droppedItem]);
 				ShowPlayerFooter(playerid, string);
				SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้เก็บ \"%s\".", ReturnName(playerid, 0), DroppedItems[id][droppedItem]);
			}
			else
				SendClientMessage(playerid, -1, "ช่องเก็บของ Furniture ของคุณเต็ม");
		}
		else SendClientMessage(playerid, -1, "Furniture อันนี้ถูกหยิบไปแล้ว!");
	}
	return 1;
}

Item_Delete(itemid)
{
    static
	    query[64];

    if (itemid != -1 && DroppedItems[itemid][droppedModel])
	{
        DroppedItems[itemid][droppedModel] = 0;
		DroppedItems[itemid][droppedQuantity] = 0;
	    DroppedItems[itemid][droppedPos][0] = 0.0;
	    DroppedItems[itemid][droppedPos][1] = 0.0;
	    DroppedItems[itemid][droppedPos][2] = 0.0;
	    DroppedItems[itemid][droppedInt] = 0;
	    DroppedItems[itemid][droppedWorld] = 0;

	    DestroyDynamicObject(DroppedItems[itemid][droppedObject]);
	    DestroyDynamic3DTextLabel(DroppedItems[itemid][droppedText3D]);

	    format(query, sizeof(query), "DELETE FROM `dropped` WHERE `ID` = '%d'", DroppedItems[itemid][droppedID]);
	    mysql_tquery(dbCon, query);
	}
	return 1;
}

PickupItem(playerid, itemid)
{
	if (itemid != -1 && DroppedItems[itemid][droppedModel])
	{
	    new id = Inventory_Add(playerid, DroppedItems[itemid][droppedItem], DroppedItems[itemid][droppedModel], DroppedItems[itemid][droppedQuantity]);

	    if (id == -1)
	        SendClientMessage(playerid, -1, "You don't have any inventory slots left.");

	    Item_Delete(itemid);
	}
	return 1;
}

Item_Nearest(playerid)
{
    for (new i = 0; i != MAX_DROPPED_ITEMS; i ++) if (DroppedItems[i][droppedModel] && IsPlayerInRangeOfPoint(playerid, 1.5, DroppedItems[i][droppedPos][0], DroppedItems[i][droppedPos][1], DroppedItems[i][droppedPos][2]))
	{
	    if (GetPlayerInterior(playerid) == DroppedItems[i][droppedInt] && GetPlayerVirtualWorld(playerid) == DroppedItems[i][droppedWorld])
	        return i;
	}
	return -1;
}

//OpenInventory
forward OpenInventory(playerid);
public OpenInventory(playerid)
{
    if (!IsPlayerConnected(playerid))
	    return 0;

	static
	    items[MAX_INVENTORYFURNITURE],
		amounts[MAX_INVENTORYFURNITURE];

    for (new i = 0; i < Character[playerid][Capacity]; i ++)
	{
 		if (InvFurnitureData[playerid][i][invExists]) {
   			items[i] = InvFurnitureData[playerid][i][invModel];
   			amounts[i] = InvFurnitureData[playerid][i][invQuantity];
		}
		else {
		    items[i] = -1;
		    amounts[i] = -1;
		}
	}
	Character[playerid][StorageSelect] = 0;
	return ShowModelSelectionMenu(playerid, "Furnitures", MODEL_SELECTION_INVENTORY, items, sizeof(items), 0.0, 0.0, 0.0, 1.0, -1, true, amounts);
}

forward OnPlayerUseItem(playerid, itemid, name[]);
public OnPlayerUseItem(playerid, itemid, name[])
{
    if (IsFurnitureItem(name))
	{
        new id = House_Area(playerid);

        if (id == -1)
            return SendClientMessage(playerid, -1, "คุณจะต้องอยู่ในอาณาเขตของบ้านเพื่อที่จะวางเฟอร์นิเจอร์");

		if (!House_IsOwner(playerid, id))
		    return SendClientMessage(playerid, -1, "คุณสามารถวางเฟอร์นิเจอร์ในบ้านของคุณเท่านั้น");

		new
		    Float:x,
		    Float:y,
		    Float:z,
		    Float:angle;

        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, angle);

        x += 5.0 * floatsin(-angle, degrees);
        y += 5.0 * floatcos(-angle, degrees);

		if (Furniture_GetCount(id) >= HouseData[id][houseMaxFurniture])
		    return SendClientMessageEx(playerid, -1, "คุณมีเฟอร์นิเจอร์ภายในบ้านได้เพียง %d ชิ้นเท่านั้น", HouseData[id][houseMaxFurniture]);

		new furniture = Furniture_Add(id, name, InvFurnitureData[playerid][itemid][invModel], x, y, z, 0.0, 0.0, angle, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));

		if (furniture == -1)
		    return SendClientMessage(playerid, -1, "เซิฟเวอร์ถึงขีดจำกัดในการสร้างเฟอร์นิเจอร์แล้ว");

		Inventory_Remove(playerid, name);
		Character[playerid][EditFurniture] = furniture;

		SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้ติดตั้ง \"%s\"", ReturnName(playerid, 0), name);
		SendClientMessageEx(playerid, -1, "Furniture ที่: %d", Furniture_GetCount(id));
		EditDynamicObject(playerid, FurnitureData[furniture][furnitureObject]);
	}
	return 1;
}

DropPlayerItem(playerid, itemid, quantity = 1)
{
	if (itemid == -1 || !InvFurnitureData[playerid][itemid][invExists])
	    return 0;

    new
		Float:x,
  		Float:y,
    	Float:z,
		Float:angle,
		string[32];

	strunpack(string, InvFurnitureData[playerid][itemid][invItem]);

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	DropItem(string, ReturnName(playerid, 0), InvFurnitureData[playerid][itemid][invModel], quantity, x, y, z - 0.9, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
 	Inventory_Remove(playerid, string, quantity);

	ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.1, 0, 0, 0, 0, 0, 1);
 	SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้ทิ้ง \"%s\".", ReturnName(playerid, 0), string);
	return 1;
}

stock Inventory_GetFreeID(playerid)
{
	if (Inventory_Items(playerid) >= Character[playerid][Capacity])
		return -1;

	for (new i = 0; i < MAX_INVENTORYFURNITURE; i ++)
	{
	    if (!InvFurnitureData[playerid][i][invExists])
	        return i;
	}
	return -1;
}

stock Inventory_Items(playerid)
{
    new count;

    for (new i = 0; i != MAX_INVENTORYFURNITURE; i ++) if (InvFurnitureData[playerid][i][invExists]) {
        count++;
	}
	return count;
}

//furnitureinv
stock Inventory_Add(playerid, item[], model, quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128];

	if (itemid == -1)
	{
	    itemid = Inventory_GetFreeID(playerid);

	    if (itemid != -1)
	    {
	        InvFurnitureData[playerid][itemid][invExists] = true;
	        InvFurnitureData[playerid][itemid][invModel] = model;
	        InvFurnitureData[playerid][itemid][invQuantity] = quantity;

	        strpack(InvFurnitureData[playerid][itemid][invItem], item, 32 char);

			if (strcmp(item, "Demo Soda") != 0)
			{
				format(string, sizeof(string), "INSERT INTO `invfurniture` (`ID`, `invItem`, `invModel`, `invQuantity`) VALUES('%d', '%s', '%d', '%d')", Character[playerid][ID], item, model, quantity);
				mysql_tquery(dbCon, string, "OnInventoryAdd", "dd", playerid, itemid);
			}
	        return itemid;
		}
		return -1;
	}
 	else
	{
	    format(string, sizeof(string), "UPDATE `invfurniture` SET `invQuantity` = `invQuantity` + %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, Character[playerid][ID], InvFurnitureData[playerid][itemid][invID]);
	    mysql_tquery(dbCon, string);

	    InvFurnitureData[playerid][itemid][invQuantity] += quantity;
	}
	return itemid;
}

stock Inventory_GetItemID(playerid, item[])
{
	for (new i = 0; i < MAX_INVENTORYFURNITURE; i ++)
	{
	    if (!InvFurnitureData[playerid][i][invExists])
	        continue;

		if (!strcmp(InvFurnitureData[playerid][i][invItem], item)) return i;
	}
	return -1;
}

stock Inventory_Remove(playerid, item[], quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128];

	if (itemid != -1)
	{
	    if (InvFurnitureData[playerid][itemid][invQuantity] > 0)
	    {
	        InvFurnitureData[playerid][itemid][invQuantity] -= quantity;
		}
		if (quantity == -1 || InvFurnitureData[playerid][itemid][invQuantity] < 1)
		{
		    InvFurnitureData[playerid][itemid][invExists] = false;
		    InvFurnitureData[playerid][itemid][invModel] = 0;
		    InvFurnitureData[playerid][itemid][invQuantity] = 0;

		    format(string, sizeof(string), "DELETE FROM `invfurniture` WHERE `ID` = '%d' AND `invID` = '%d'", Character[playerid][ID], InvFurnitureData[playerid][itemid][invID]);
	        mysql_tquery(dbCon, string);
		}
		else if (quantity != -1 && InvFurnitureData[playerid][itemid][invQuantity] > 0)
		{
			format(string, sizeof(string), "UPDATE `invfurniture` SET `invQuantity` = `invQuantity` - %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, Character[playerid][ID], InvFurnitureData[playerid][itemid][invID]);
            mysql_tquery(dbCon, string);
		}
		return 1;
	}
	return 0;
}

Dialog:Inventory(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new
			itemid = Character[playerid][InventoryItem],
			string[64];

	    strunpack(string, InvFurnitureData[playerid][itemid][invItem]);

	    switch (listitem)
	    {
	        case 0:
	        {
         		CallLocalFunction("OnPlayerUseItem", "dds", playerid, itemid, string);
	        }
	        case 1:
	        {
	            if (IsPlayerInAnyVehicle(playerid))
	                return SendClientMessage(playerid, -1, "คุณต้องลงจากรถก่อน!");

				else if (InvFurnitureData[playerid][itemid][invQuantity] == 1)
					DropPlayerItem(playerid, itemid);

				else
					Dialog_Show(playerid, DropItem, DIALOG_STYLE_INPUT, "Drop Item", "Item: %s - Quantity: %d\n\nPlease specify how much of this item you wish to drop:", "Drop", "Cancel", string, InvFurnitureData[playerid][itemid][invQuantity]);
	        }
	    }
	}
	return 1;
}

DropItem(item[], player[], model, quantity, Float:x, Float:y, Float:z, interior, world)
{
	new
	    query[300];

	for (new i = 0; i != MAX_DROPPED_ITEMS; i ++) if (!DroppedItems[i][droppedModel])
	{
	    format(DroppedItems[i][droppedItem], 32, item);
	    format(DroppedItems[i][droppedPlayer], 24, player);

		DroppedItems[i][droppedModel] = model;
		DroppedItems[i][droppedQuantity] = quantity;
		DroppedItems[i][droppedPos][0] = x;
		DroppedItems[i][droppedPos][1] = y;
		DroppedItems[i][droppedPos][2] = z;

		DroppedItems[i][droppedInt] = interior;
		DroppedItems[i][droppedWorld] = world;

		DroppedItems[i][droppedObject] = CreateDynamicObject(model, x, y, z, 0.0, 0.0, 0.0, world, interior);
 		DroppedItems[i][droppedText3D] = CreateDynamic3DTextLabel(item, COLOR_WHITE, x, y, z, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, world, interior);

		if (strcmp(item, "Demo Soda") != 0)
		{
	 		format(query, sizeof(query), "INSERT INTO `dropped` (`itemName`, `itemPlayer`, `itemModel`, `itemQuantity`, `itemX`, `itemY`, `itemZ`, `itemInt`, `itemWorld`) VALUES('%s', '%s', '%d', '%d', '%.4f', '%.4f', '%.4f', '%d', '%d')", item, player, model, quantity, x, y, z, interior, world);
			mysql_tquery(dbCon, query, "OnDroppedItem", "d", i);
		}
		return i;
	}
	return -1;
}


forward OnInventoryAdd(playerid, itemid);
public OnInventoryAdd(playerid, itemid)
{
	InvFurnitureData[playerid][itemid][invID] = cache_insert_id();
	return 1;
}

forward OnDroppedItem(itemid);
public OnDroppedItem(itemid)
{
	if (itemid == -1 || !DroppedItems[itemid][droppedModel])
	    return 0;

	DroppedItems[itemid][droppedID] = cache_insert_id();
	return 1;
}
