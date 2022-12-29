#include <YSI\y_hooks>

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
	houseRank,
	houseMaxFurniture,
	houseMoney,
	Text3D:houseText3D,
	housePickup,
	houseLights,
	houseWeapons[10],
	houseAmmo[10]
};
new HouseData[MAX_HOUSES][houseData],Total_Houses_Created;

enum houseStorage {
	hItemID,
	hItemExists,
	hItemName[32 char],
	hItemModel,
	hItemQuantity,
	hItemExtended
};

new HouseStorage[MAX_HOUSES][MAX_HOUSE_STORAGE][houseStorage];

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

enum e_FurnitureData
{
    e_FurnitureType,
	e_FurnitureName[32],
	e_FurnitureModel,
	e_FurniturePrice
};

new const g_aFurnitureTypes[][] = {
	{"Frames"},
	{"Tables"},
	{"Chairs"},
	{"Beds"},
	{"Cabinets"},
	{"Television Sets"},
	{"Kitchen Appliances"},
	{"Bathroom Appliances"},
	{"Misc Furniture 1"},
	{"Misc Furniture 2"},
	{"Misc Furniture 3"},
	{"Misc Furniture S"},
	{"Misc Furniture M"},
	{"Misc Furniture L"}
};

new const g_aFurnitureData[][e_FurnitureData] = {
	{1, "Frame 1", 2289},
	{1, "Frame 2", 2288},
	{1, "Frame 3", 2287},
	{1, "Frame 4", 2286},
	{1, "Frame 5", 2285},
	{1, "Frame 6", 2284},
    {1, "Frame 7", 2283},
    {1, "Frame 8", 2282},
    {1, "Frame 9", 2281},
    {1, "Frame 10", 2280},
    {1, "Frame 11", 2279},
	{1, "Frame 12", 2278},
	{1, "Frame 13", 2277},
	{1, "Frame 14", 2276},
	{1, "Frame 15", 2275},
	{1, "Frame 16", 2274},
    {1, "Frame 17", 2273},
    {1, "Frame 18", 2272},
    {1, "Frame 19", 2271},
    {1, "Frame 20", 2270},
    {2, "Table 1", 1433},
	{2, "Table 2", 1998},
	{2, "Table 3", 2008},
	{2, "Table 4", 2180},
	{2, "Table 5", 2185},
    {2, "Table 6", 2205},
    {2, "Table 7", 2314},
    {2, "Table 8", 2635},
    {2, "Table 9", 2637},
    {2, "Table 10", 2644},
	{2, "Table 11", 2747},
	{2, "Table 12", 2764},
	{2, "Table 13", 2763},
	{2, "Table 14", 2762},
	{2, "Table 15", 936},
	{2, "Table 16", 937},
	{2, "Table 17", 941},
	{2, "Table 18", 2115},
	{2, "Table 19", 2116},
	{2, "Table 20", 2112},
	{2, "Table 21", 2111},
	{2, "Table 22", 2110},
	{2, "Table 23", 2109},
	{2, "Table 24", 2085},
	{2, "Table 25", 2032},
	{2, "Table 26", 2031},
	{2, "Table 27", 2030},
	{2, "Table 28", 2029},
	{2, "CTable1", 11690},
	{2, "CTable2", 11691},

	{2, "MKTable1", 19922},
	{2, "MKIslandCooker1", 19923},
	{2, "MKExtractionHood1", 19924},
	{2, "MKWorkTop1", 19925},
	{2, "MKWorkTop2", 19926},
	{2, "MKWorkTop3", 19927},
	{2, "MKWorkTop4", 19928},
	{2, "MKWorkTop5", 19929},
	{2, "MKWorkTop6", 19930},
	{2, "MKWorkTop7", 19931},
	{2, "MKWallOvenCabinet1", 19932},
	{2, "MKWallOven1", 19933},
	{2, "MKCupboard1", 19934},
	{2, "MKCupboard2", 19935},
	{2, "MKCupboard3", 19936},
	{2, "MKCupboard4", 19937},
	{2, "MKShelf1", 19938},
	{2, "MKShelf2", 19939},
	{2, "MKShelf3", 19940},



    {3, "Chair 1", 1671},
    {3, "Chair 2", 1704},
    {3, "Chair 3", 1705},
    {3, "Chair 4", 1708},
    {3, "Chair 5", 1711},
    {3, "Chair 6", 1715},
    {3, "Chair 7", 1721},
    {3, "Chair 8", 1724},
    {3, "Chair 9", 1727},
    {3, "Chair 10", 1729},
    {3, "Chair 11", 1735},
    {3, "Chair 12", 1739},
    {3, "Chair 13", 1805},
    {3, "Chair 14", 1806},
    {3, "Chair 15", 1810},
    {3, "Chair 16", 1811},
    {3, "Chair 17", 2079},
    {3, "Chair 18", 2120},
    {3, "Chair 19", 2124},
    {3, "Chair 20", 2356},
    {3, "Chair 21", 1768},
    {3, "Chair 22", 1766},
    {3, "Chair 23", 1764},
    {3, "Chair 24", 1763},
    {3, "Chair 25", 1761},
    {3, "Chair 26", 1760},
    {3, "Chair 27", 1757},
    {3, "Chair 28", 1756},
    {3, "Chair 29", 1753},
    {3, "Chair 30", 1713},
    {3, "Chair 31", 1712},
    {3, "Chair 32", 1706},
    {3, "Chair 33", 1703},
    {3, "Chair 34", 1702},
    {3, "Chair 35", 1754},
    {3, "Chair 36", 1755},
    {3, "Chair 37", 1758},
    {3, "Chair 38", 1759},
    {3, "Chair 39", 1762},
    {3, "Chair 40", 1765},
    {3, "Chair 41", 1767},
    {3, "Chair 42", 1769},
    {3, "CBarStool1", 11687},
    {3, "CutsceneChair1", 19994},
    {3, "CutsceneChair2", 19999},
	{4, "Bed 1", 1700},
	{4, "Bed 2", 1701},
	{4, "Bed 3", 1725},
	{4, "Bed 4", 1745},
	{4, "Bed 5", 1793},
	{4, "Bed 6", 1794},
	{4, "Bed 7", 1795},
	{4, "Bed 8", 1796},
	{4, "Bed 9", 1797},
	{4, "Bed 10", 1771},
	{4, "Bed 11", 1798},
	{4, "Bed 12", 1799},
    {4, "Bed 13", 1800},
    {4, "Bed 14", 1801},
    {4, "Bed 15", 1802},
    {4, "Bed 16", 1812},
    {4, "Bed 17", 2090},
    {4, "Bed 18", 2299},
    {4, "SweetsBed1", 11720},
    {5, "Cabinet 1", 1416},
	{5, "Cabinet 2", 1417},
	{5, "Cabinet 3", 1741},
	{5, "Cabinet 4", 1742},
	{5, "Cabinet 5", 1743},
	{5, "Cabinet 6", 2025},
	{5, "Cabinet 7", 2065},
	{5, "Cabinet 8", 2066},
	{5, "Cabinet 9", 2067},
	{5, "Cabinet 10", 2087},
    {5, "Cabinet 11", 2088},
    {5, "Cabinet 12", 2094},
    {5, "Cabinet 13", 2095},
    {5, "Cabinet 14", 2306},
    {5, "Cabinet 15", 2307},
	{5, "Cabinet 16", 2323},
	{5, "Cabinet 17", 2328},
	{5, "Cabinet 18", 2329},
	{5, "Cabinet 19", 2330},
	{5, "Cabinet 20", 2708},
	{6, "Television 1", 1518},
	{6, "Television 2", 1717},
	{6, "Television 3", 1747},
	{6, "Television 4", 1748},
	{6, "Television 5", 1749},
	{6, "Television 6", 1750},
	{6, "Television 7", 1752},
	{6, "Television 8", 1781},
	{6, "Television 9", 1791},
	{6, "Television 10", 1792},
    {6, "Television 11", 2312},
	{6, "Television 12", 2316},
	{6, "Television 13", 2317},
	{6, "Television 14", 2318},
	{6, "Television 15", 2320},
	{6, "Television 16", 2595},
	{6, "Television 17", 16377},
	{6, "Television 18", 19893},
	{6, "Television 19", 19894},
	{6, "Television 20", 19920},
	{7, "Kitchen 1", 2013},
	{7, "Kitchen 2", 2017},
	{7, "Kitchen 3", 2127},
	{7, "Kitchen 4", 2130},
	{7, "Kitchen 5", 2131},
	{7, "Kitchen 6", 2132},
	{7, "Kitchen 7", 2135},
	{7, "Kitchen 8", 2136},
	{7, "Kitchen 9", 2144},
	{7, "Kitchen 10", 2147},
    {7, "Kitchen 11", 2149},
    {7, "Kitchen 12", 2150},
    {7, "Kitchen 13", 2415},
    {7, "Kitchen 14", 2417},
    {7, "Kitchen 15", 2421},
    {7, "Kitchen 16", 2426},
    {7, "Kitchen 17", 2014},
    {7, "Kitchen 18", 2015},
    {7, "Kitchen 19", 2016},
    {7, "Kitchen 20", 2018},
    {7, "Kitchen 21", 2019},
    {7, "Kitchen 22", 2022},
    {7, "Kitchen 23", 2133},
    {7, "Kitchen 24", 2134},
	{7, "Kitchen 25", 2137},
	{7, "Kitchen 26", 2138},
	{7, "Kitchen 27", 2139},
	{7, "Kitchen 28", 2140},
	{7, "Kitchen 29", 2141},
	{7, "Kitchen 30", 2142},
	{7, "Kitchen 31", 2143},
	{7, "Kitchen 32", 2145},
	{7, "Kitchen 33", 2148},
	{7, "Kitchen 34", 2151},
	{7, "Kitchen 35", 2152},
	{7, "Kitchen 36", 2153},
	{7, "Kitchen 37", 2154},
	{7, "Kitchen 38", 2155},
	{7, "Kitchen 39", 2156},
	{7, "Kitchen 40", 2157},
	{7, "Kitchen 41", 2158},
	{7, "Kitchen 42", 2159},
	{7, "Kitchen 43", 2160},
	{7, "Kitchen 44", 2134},
	{7, "Kitchen 45", 2135},
	{7, "Kitchen 46", 2338},
	{7, "Kitchen 47", 2341},
	{8, "Bathroom 1", 2514},
	{8, "Bathroom 2", 2516},
	{8, "Bathroom 3", 2517},
	{8, "Bathroom 4", 2518},
	{8, "Bathroom 5", 2520},
	{8, "Bathroom 6", 2521},
	{8, "Bathroom 7", 2522},
	{8, "Bathroom 8", 2523},
	{8, "Bathroom 9", 2524},
	{8, "Bathroom 10", 2525},
    {8, "Bathroom 11", 2526},
    {8, "Bathroom 12", 2527},
    {8, "Bathroom 13", 2528},
    {8, "Bathroom 14", 2738},
    {8, "Bathroom 15", 2739},
    {8, "Bathroom 16", 19873},
    {8, "Bathroom 17", 19874},
	{9, "Washer", 1208},
	{9, "Ceiling Fan", 1661},
	{9, "Moose Head", 1736},
	{9, "Radiator", 1738},
	{9, "Mop and Pail", 1778},
	{9, "Water Cooler", 1808},
	{9, "Water Cooler 2", 2002},
	{9, "Money Safe", 1829},
	{9, "Printer", 2186},
	{9, "Computer", 2190},
	{9, "Treadmill", 2627},
	{9, "Bench Press", 2629},
	{9, "Exercise Bike", 2630},
	{9, "Mat 1", 2631},
	{9, "Mat 2", 2632},
	{9, "Mat 3", 2817},
	{9, "Mat 4", 2818},
	{9, "Mat 5", 2833},
	{9, "Mat 6", 2834},
	{9, "Mat 7", 2835},
	{9, "Mat 8", 2836},
	{9, "Mat 9", 2841},
	{9, "Mat 10", 2842},
	{9, "Mat 11", 2847},
	{9, "Book Pile 1", 2824},
	{9, "Book Pile 2", 2826},
	{9, "Book Pile 3", 2827},
	{9, "Basketball", 2114},
	{9, "Lamp 1", 2108},
	{9, "Lamp 2", 2106},
	{9, "Lamp 3", 2069},
	{9, "Dresser 1", 2569},
	{9, "Dresser 2", 2570},
	{9, "Dresser 3", 2573},
	{9, "Dresser 4", 2574},
	{9, "Dresser 5", 2576},
	{9, "Book", 2894},

	{10, "DanceFloor1", 19128}, // Misc Furniture 2
	{10, "DanceFloor2", 19129},
	{10, "MirrorBall1", 19159},
								 //Misc Furniture 3
	{11, "SkellTorch", 3524},
	{11, "Torch1", 3525},
	{11, "Torch2", 3461},
	{11, "Tree1", 615},
	{11, "Tree2", 616},
	{11, "Tree3", 737},
	{11, "Tree4", 838},

	{12, "Telephone1", 19807}, // Misc Furniture S
	{12, "Keyboard1", 19808},
	{12, "ElectricalOutlet1", 19813},
	{12, "ElectricalOutlet2", 19814},
	{12, "OxygenCylinder1", 19816},
	{12, "SprunkClock1", 19825},
	{12, "LightSwitch1", 19826},
	{12, "LightSwitch2", 19827},
	{12, "LightSwitch3Off", 19828},
	{12, "LightSwitch3On", 19829},
	{12, "pumpkin01", 19320},
	{12, "Cross1", 11712},

	{12, "MarcosFryingPan1", 19581},
	{12, "MarcosKnife1", 19583},
	{12, "MarcosSaucepan1", 19584},
	{12, "MarcosPan1", 19585},
	{12, "MarcosSpatula1", 19586},

	{13, "Whiteboard1", 19805}, // Misc Furniture M
	{13, "Cauldron1", 19527},
	{13, "WitchesHat1", 19528},
	{13, "bassguitar01", 19317},
	{13, "flyingv01", 19318},
	{13, "warlock01", 19319},

	{13, "ToolCabinet1", 19899},
	{13, "ToolCabinet2", 19900},
	{13, "MechanicComputer1", 19903},

	{13, "Blender1", 19830},
	{13, "Barbeque1", 19831},



	{14, "XmasTree1", 19076}, //Misc Furniture L
	{14, "WoodenStage1", 19608},
	{14, "DrumKit1", 19609},
	{14, "Microphone1", 19610},
	{14, "MicrophoneStand1", 19611},
	{14, "GuitarAmp1", 19612},
	{14, "GuitarAmp2", 19613},
	{14, "GuitarAmp3", 19614},
	{14, "GuitarAmp4", 19615},
	{14, "GuitarAmp5", 19616},
	{14, "GoldRecord1", 19617}


};

new NearestItems[MAX_PLAYERS][MAX_LISTED_ITEMS];
new ListedFurniture[MAX_PLAYERS][MAX_HOUSE_FURNITURE];


enum furnitureData {
	furnitureID,
	furnitureHouse,
	furnitureExists,
	furnitureModel,
	furnitureName[32],
	Float:furniturePos[3],
	Float:furnitureRot[3],
	furnitureInt,
	furnitureVW,
	furnitureObject
};

new FurnitureData[MAX_FURNITURE][furnitureData];

Dialog:HouseStorage(playerid, response, listitem, inputtext[])
{
	new
	    houseid = -1;

	if ((houseid = House_Inside(playerid)) != -1 && (House_IsOwner(playerid, houseid) || GetFactionType(playerid) == FACTION_POLICE))
	{
		if (response)
		{
		    if (listitem == 0) {
		        Dialog_Show(playerid, HouseMoney, DIALOG_STYLE_LIST, "Money Safe", "ฝากเงินใส่ตู้เซฟ\nถอนเงินจากตู้เซฟ", "Select", "Back");
			}
		}
	}
	return 1;
}


Dialog:HouseWithdrawCash(playerid, response, listitem, inputtext[])
{
    new
	    houseid = -1;

	if ((houseid = House_Inside(playerid)) != -1 && House_IsOwner(playerid, houseid))
	{
		if (response)
		{
		    new amount = strval(inputtext);

		    if (isnull(inputtext))
		        return Dialog_Show(playerid, HouseWithdrawCash, DIALOG_STYLE_INPUT, "Withdraw from safe", "ยอดเงินคงเหลือในตู้เซฟ: %s\n\nโปรดป้อนจำนวนเงินที่คุณต้องการถอนจากตู้เซฟ:", "Withdraw", "Back", FormatNumber(HouseData[houseid][houseMoney]));

			if (amount < 1 || amount > HouseData[houseid][houseMoney])
			    return Dialog_Show(playerid, HouseWithdrawCash, DIALOG_STYLE_INPUT, "Withdraw from safe", "ข้อผิดพลาด: คุณมีเงินไม่พอ\n\nยอดเงินคงเหลือในตู้เซฟ: %s\n\nโปรดป้อนจำนวนเงินที่คุณต้องการถอนจากตู้เซฟ:", "Withdraw", "Back", FormatNumber(HouseData[houseid][houseMoney]));

			HouseData[houseid][houseMoney] -= amount;
			GiveMoney(playerid, amount, "withdraw house id %d", houseid);

			House_Save(houseid);
			House_OpenStorage(playerid, houseid);

			SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้ถอนเงิน %s จากตู้เซฟในบ้าน", ReturnName(playerid, 0), FormatNumber(amount));
		}
		else Dialog_Show(playerid, HouseMoney, DIALOG_STYLE_LIST, "Money Safe", "ถอนเงินจากตู้เซฟ\nฝากเงินใส่ตู้เซฟ", "Select", "Back");
	}
	return 1;
}

Dialog:HouseDepositCash(playerid, response, listitem, inputtext[])
{
    new
	    houseid = -1;

	if ((houseid = House_Inside(playerid)) != -1 && House_IsOwner(playerid, houseid))
	{
		if (response)
		{
		    new amount = strval(inputtext);

		    if (isnull(inputtext))
		        return Dialog_Show(playerid, HouseDepositCash, DIALOG_STYLE_INPUT, "Deposit into safe", "ยอดเงินคงเหลือในตู้: %s\n\nโปรดป้อนจำนวนเงินที่คุณต้องการฝากใส่ตู้เซฟ:", "Withdraw", "Back", FormatNumber(HouseData[houseid][houseMoney]));

			if (amount < 1 || amount > GetMoney(playerid))
			    return Dialog_Show(playerid, HouseDepositCash, DIALOG_STYLE_INPUT, "Deposit into safe", "ข้อผิดพลาด: คุณมีเงินไม่พอ\n\nยอดเงินคงเหลือในตู้เซฟ: %s\n\nโปรดป้อนจำนวนเงินที่คุณต้องการฝากเข้าตู้เซฟ:", "Withdraw", "Back", FormatNumber(HouseData[houseid][houseMoney]));

			HouseData[houseid][houseMoney] += amount;
			GiveMoney(playerid, -amount, "deposit house id %d", houseid);

			House_Save(houseid);
			House_OpenStorage(playerid, houseid);

			SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้ฝาก %s ใส่ตู้เก็บของในบ้าน", ReturnName(playerid, 0), FormatNumber(amount));
		}
		else Dialog_Show(playerid, HouseMoney, DIALOG_STYLE_LIST, "Money Safe", "ถอนเงินจากตู้เซฟ\nฝากเงินใส่ตู้เซฟ", "Select", "Back");
	}
	return 1;
}

Dialog:HouseMoney(playerid, response, listitem, inputtext[])
{
    new
	    houseid = -1;

	if ((houseid = House_Inside(playerid)) != -1 && House_IsOwner(playerid, houseid))
	{
		if (response)
		{
			switch (listitem)
			{
			    case 0: {
			        Dialog_Show(playerid, HouseDepositCash, DIALOG_STYLE_INPUT, "Deposit into safe", "ยอดเงินคงเหลือในตู้: %s\n\nโปรดป้อนจำนวนเงินที่คุณต้องการฝากเข้าตู้เซฟ:", "Deposit", "Back", FormatNumber(HouseData[houseid][houseMoney]));
				}
				case 1: {
				    Dialog_Show(playerid, HouseWithdrawCash, DIALOG_STYLE_INPUT, "Withdraw from safe", "ยอดเงินคงเหลือในตู้: %s\n\nโปรดป้อนจำนวนเงินที่คุณต้องการถอนจากตู้เซฟ:", "Withdraw", "Back", FormatNumber(HouseData[houseid][houseMoney]));
				}
			}
		}
		else House_OpenStorage(playerid, houseid);
	}
	return 1;
}

stock House_OpenStorage(playerid, houseid)
{
	if (houseid == -1 || !HouseData[houseid][houseExists])
	    return 0;

	new
		items[2],
		string[MAX_HOUSE_STORAGE * 32];

	for (new i = 0; i < MAX_HOUSE_STORAGE; i ++) if (HouseStorage[houseid][i][hItemExists]) {
	    items[0]++;
	}
	for (new i = 0; i < 10; i ++) if (HouseData[houseid][houseWeapons][i]) {
	    items[1]++;
	}
	format(string, sizeof(string), "Money Safe (%s)", FormatNumber(HouseData[houseid][houseMoney]));

	Dialog_Show(playerid, HouseStorage, DIALOG_STYLE_LIST, "House Storage", string, "Select", "Cancel");
	return 1;
}

stock House_GetItemID(houseid, item[])
{
	if (houseid == -1 || !HouseData[houseid][houseExists])
	    return 0;

	for (new i = 0; i < MAX_HOUSE_STORAGE; i ++)
	{
	    if (!HouseStorage[houseid][i][hItemExists])
	        continue;

		if (!strcmp(HouseStorage[houseid][i][hItemName], item)) return i;
	}
	return -1;
}

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

//dynamic house
House_Create(playerid, address[], price)
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
				HouseData[i][houseRank] = 1;
				HouseData[i][houseMaxFurniture] = 10;

				House_Refresh(i);
				mysql_tquery(dbCon, "INSERT INTO `houses` (`houseOwner`) VALUES(0)", "OnHouseCreated", "i", i);
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

        Total_Houses_Created--;

		format(string, sizeof(string), "DELETE FROM `houses` WHERE `houseID` = '%d'", HouseData[houseid][houseID]);
		mysql_tquery(dbCon, string);

        if (IsValidDynamic3DTextLabel(HouseData[houseid][houseText3D]))
		    DestroyDynamic3DTextLabel(HouseData[houseid][houseText3D]);

		if (IsValidDynamicPickup(HouseData[houseid][housePickup]))
		    DestroyDynamicPickup(HouseData[houseid][housePickup]);

		House_RemoveFurniture(houseid);

	    HouseData[houseid][houseExists] = false;
	    HouseData[houseid][houseOwner] = 0;
	    HouseData[houseid][houseID] = 0;
	}
	return 1;
}

House_Inside(playerid)
{
	if (Character[playerid][House] != -1)
	{
	    for (new i = 0; i != MAX_HOUSES; i ++) if (HouseData[i][houseExists] && HouseData[i][houseID] == Character[playerid][House] && GetPlayerInterior(playerid) == HouseData[i][houseInterior] && GetPlayerVirtualWorld(playerid) > 0) {
	        return i;
		}
	}
	return -1;
}

House_Save(houseid)
{
	new
	    query[1536];

	format(query, sizeof(query), "UPDATE `houses` SET `houseOwner` = '%d', `housePrice` = '%d', `houseAddress` = '%s', `housePosX` = '%.4f', `housePosY` = '%.4f', `housePosZ` = '%.4f', `housePosA` = '%.4f', `houseIntX` = '%.4f', `houseIntY` = '%.4f', `houseIntZ` = '%.4f', `houseIntA` = '%.4f', `houseInterior` = '%d', `houseExterior` = '%d', `houseExteriorVW` = '%d'",
	    HouseData[houseid][houseOwner],
	    HouseData[houseid][housePrice],
	    SQL_ReturnEscaped(HouseData[houseid][houseAddress]),
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
	format(query, sizeof(query), "%s, `houseLocked` = '%d', `houseMoney` = '%d', `houseRank` = '%d', `houseMaxFurniture` = '%d' WHERE `houseID` = '%d'",
	    query,
	    HouseData[houseid][houseLocked],
	    HouseData[houseid][houseMoney],
	    HouseData[houseid][houseRank],
	    HouseData[houseid][houseMaxFurniture],
        HouseData[houseid][houseID]
	);
	return mysql_tquery(dbCon, query);
}

House_RemoveFurniture(houseid)
{
	if (HouseData[houseid][houseExists])
	{
	    new
	        string[64];

	    for (new i = 0; i != MAX_FURNITURE; i ++) if (FurnitureData[i][furnitureExists] && FurnitureData[i][furnitureHouse] == houseid) {
	        FurnitureData[i][furnitureExists] = false;
	        FurnitureData[i][furnitureModel] = 0;
            FurnitureData[i][furnitureHouse] = -1;

	        DestroyDynamicObject(FurnitureData[i][furnitureObject]);
		}
		format(string, sizeof(string), "DELETE FROM `furniture` WHERE `ID` = '%d'", HouseData[houseid][houseID]);
		mysql_tquery(dbCon, string);
	}
	return 1;
}

House_Area(playerid)
{
	new
        Float:fDistance[2] = {99999.0, 0.0},
		h = -1;

	for (new i = 0; i != MAX_HOUSES; i ++) {
		if (HouseData[i][houseExists])
		{
	        if(GetPlayerInterior(playerid) == HouseData[i][houseInterior] && GetPlayerVirtualWorld(playerid) > 0 && HouseData[i][houseID] == Character[playerid][House])
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
}

House_Nearest(playerid, Float:radius = 3.0)
{
    for (new i = 0; i != MAX_HOUSES; i ++) if (HouseData[i][houseExists] && IsPlayerInRangeOfPoint(playerid, radius, HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2]))
	{
		if (GetPlayerInterior(playerid) == HouseData[i][houseExterior] && GetPlayerVirtualWorld(playerid) == HouseData[i][houseExteriorVW])
			return i;
	}
	return -1;
}

CheckHouse_Nearest(playerid, Float:radius = 7.0)
{
    for (new i = 0; i != MAX_HOUSES; i ++) if (HouseData[i][houseExists] && IsPlayerInRangeOfPoint(playerid, radius, HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2]))
	{
		if (GetPlayerInterior(playerid) == HouseData[i][houseExterior] && GetPlayerVirtualWorld(playerid) == HouseData[i][houseExteriorVW])
			return i;
	}
	return -1;
}

House_Refresh(houseid)
{
	if (houseid != -1 && HouseData[houseid][houseExists])
	{
		if (IsValidDynamic3DTextLabel(HouseData[houseid][houseText3D]))
		    DestroyDynamic3DTextLabel(HouseData[houseid][houseText3D]);

		if (IsValidDynamicPickup(HouseData[houseid][housePickup]))
		    DestroyDynamicPickup(HouseData[houseid][housePickup]);

		/*new
		    string[128];*/

		if (!HouseData[houseid][houseOwner]) {
		    HouseData[houseid][housePickup] = CreateDynamicPickup(1273, 23, HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2], HouseData[houseid][houseExteriorVW], HouseData[houseid][houseExterior]);
			/*format(string, sizeof(string), "[%s]\n%s", FormatNumber(HouseData[houseid][housePrice]), HouseData[houseid][houseAddress]);
            HouseData[houseid][houseText3D] = CreateDynamic3DTextLabel(string, 0x33AA33FF, HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, HouseData[houseid][houseExteriorVW], HouseData[houseid][houseExterior]);*/
		}
		else {
		    HouseData[houseid][housePickup] = CreateDynamicPickup(1272, 23, HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2], HouseData[houseid][houseExteriorVW], HouseData[houseid][houseExterior]);
		/*	format(string, sizeof(string), "%s", HouseData[houseid][houseAddress]);
			HouseData[houseid][houseText3D] = CreateDynamic3DTextLabel(string, COLOR_WHITE, HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, HouseData[houseid][houseExteriorVW], HouseData[houseid][houseExterior]);*/
		}
	}
	return 1;
}

House_IsOwner(playerid, houseid)
{
	if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_IS_LOGGED_IN) || Character[playerid][ID] == -1)
	    return 0;

    if ((HouseData[houseid][houseExists] && HouseData[houseid][houseOwner] != 0) && HouseData[houseid][houseOwner] == Character[playerid][ID])
		return 1;

	return 0;
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

forward OnHouseCreated(houseid);
public OnHouseCreated(houseid)
{
	if (houseid == -1 || !HouseData[houseid][houseExists])
	    return 0;

	HouseData[houseid][houseID] = cache_insert_id();
	House_Save(houseid);

	return 1;
}

forward House_Load();
public House_Load()
{
	new
	    rows,
		str[128];

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_HOUSES)
	{
		HouseData[i][houseExists] = true;
		HouseData[i][houseLights] = false;

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
     	cache_get_value_name_int(i, "houseRank", HouseData[i][houseRank]);
     	cache_get_value_name_int(i, "houseMaxFurniture", HouseData[i][houseMaxFurniture]);

        for (new j = 0; j < 10; j ++)
		{
            format(str, 24, "houseWeapon%d", j + 1);
            cache_get_value_name_int(i, str, HouseData[i][houseWeapons][j]);

            format(str, 24, "houseAmmo%d", j + 1);
            cache_get_value_name_int(i, str, HouseData[i][houseAmmo][j]);
		}
		House_Refresh(i);
		Total_Houses_Created++;
	}
	for (new i = 0; i < MAX_HOUSES; i ++) if (HouseData[i][houseExists]) {

		format(str, sizeof(str), "SELECT * FROM `housestorage` WHERE `ID` = '%d'", HouseData[i][houseID]);

		mysql_tquery(dbCon, str, "OnLoadStorage", "d", i);

		format(str, sizeof(str), "SELECT * FROM `furniture` WHERE `ID` = '%d'", HouseData[i][houseID]);

		mysql_tquery(dbCon, str, "OnLoadFurniture", "d", i);
	}
	printf("[MYSQL]: %d Houses have been successfully loaded from the database.", Total_Houses_Created);
	return 1;
}

//housecmds
CMD:createhouse(playerid, params[])
{
	new
	    price,
	    id,
	    address[32];

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "ds[32]", price, address))
	    return SendClientMessage(playerid, -1, "/createhouse [price] [address]");

	for (new i = 0; i != MAX_HOUSES; i ++) if (HouseData[i][houseExists] && !strcmp(HouseData[i][houseAddress], address, true)) {
	    return SendClientMessageEx(playerid, -1, "ที่อยู่ \"%s\" ได้ถูกใช้งานแล้ว (ID: %d)", address, i);
	}

	id = House_Create(playerid, address, price);

	if (id == -1)
	    return SendClientMessage(playerid, -1, "เซิฟเวอร์นี้ได้สร้างบ้านเกินขีดจำกัดแล้ว");

	SendClientMessageEx(playerid, -1, "คุณสร้างบ้านสำเร็จแล้วไอดี: %d", id);
	return 1;
}

CMD:destroyhouse(playerid, params[])
{
	new
	    id = 0;

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, -1, "/destroyhouse [house id]");

	if ((id < 0 || id >= MAX_HOUSES) || !HouseData[id][houseExists])
	    return SendClientMessage(playerid, -1, "คุณระบุไอดีบ้านไม่ถูกต้อง");

	House_Delete(id);
	SendClientMessageEx(playerid, -1, "คุณทำลายบ้านสำเร็จแล้วไอดี: %d", id);
	return 1;
}

CMD:edithouse(playerid, params[])
{
	new
	    id,
	    type[24],
	    string[128];

	if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendClientMessage(playerid, -1, "/edithouse [id] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, interior, price, address, type, owner,rank");
		return 1;
	}
	if ((id < 0 || id >= MAX_HOUSES) || !HouseData[id][houseExists])
	    return SendClientMessage(playerid, -1, "คุณระบุไอดีบ้านไม่ถูกต้อง");

	if (!strcmp(type, "location", true))
	{
		GetPlayerPos(playerid, HouseData[id][housePos][0], HouseData[id][housePos][1], HouseData[id][housePos][2]);
		GetPlayerFacingAngle(playerid, HouseData[id][housePos][3]);

		HouseData[id][houseExterior] = GetPlayerInterior(playerid);
		HouseData[id][houseExteriorVW] = GetPlayerVirtualWorld(playerid);

		House_Refresh(id);
		House_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับตำแหน่งของบ้านไอดี: %d", ReturnRealName(playerid, 0), id);
	}
	else if (!strcmp(type, "interior", true))
	{
	    GetPlayerPos(playerid, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2]);
		GetPlayerFacingAngle(playerid, HouseData[id][houseInt][3]);

		HouseData[id][houseInterior] = GetPlayerInterior(playerid);

        foreach (new i : Player)
		{
			if (Character[i][House] == HouseData[id][houseID])
			{
				SetPlayerPosEx(i, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2], HouseData[id][houseInterior], -1);
				SetPlayerFacingAngle(i, HouseData[id][houseInt][3]);

				SetPlayerInterior(i, HouseData[id][houseInterior]);
				SetCameraBehindPlayer(i);
			}
		}
		House_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับตำแหน่งจุดเกิดภายในของบ้านไอดี: %d", ReturnRealName(playerid, 0), id);
	}
    else if (!strcmp(type, "rank", true))
	{
	    new rank;

	    if (sscanf(string, "d", rank))
	        return SendClientMessage(playerid, -1, "/edithouse [id] [rank] [1:เล็ก, 2:กลาง, 3:ใหญ่]");

	    HouseData[id][houseRank] = rank;

	    if(HouseData[id][houseRank] == 1) //เล็ก
			HouseData[id][houseMaxFurniture] = 10;//10

		else if(HouseData[id][houseRank] == 2) //กลาง
			HouseData[id][houseMaxFurniture] = 20; //20

		else if(HouseData[id][houseRank] == 3) //ใหญ่
		    HouseData[id][houseMaxFurniture] = 30; //30

	    House_Refresh(id);
	    House_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับระดับของบ้านไอดี: %d เป็น %s", ReturnRealName(playerid, 0), id, rank);
	}
	else if (!strcmp(type, "price", true))
	{
	    new price;

	    if (sscanf(string, "d", price))
	        return SendClientMessage(playerid, -1, "/edithouse [id] [price] [new price]");

	    HouseData[id][housePrice] = price;

	    House_Refresh(id);
	    House_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับราคาของบ้านไอดี: %d เป็น %s", ReturnRealName(playerid, 0), id, FormatNumber(price));
	}
	else if (!strcmp(type, "owner", true))
	{
	    new sid;

	    if (sscanf(string, "d", sid))
	        return SendClientMessage(playerid, -1, "/edithouse [id] [owner] [owner ID]");

	    HouseData[id][houseOwner] = sid;

	    House_Refresh(id);
	    House_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับเจ้าของของบ้านไอดี: %d เป็น %d", ReturnRealName(playerid, 0), id, sid);
	}
	else if (!strcmp(type, "address", true))
	{
	    new address[32];

	    if (sscanf(string, "s[32]", address))
	        return SendClientMessage(playerid, -1, "/edithouse [id] [address] [new address]");

	    format(HouseData[id][houseAddress], 32, address);

	    House_Refresh(id);
	    House_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับที่อยู่ของบ้านไอดี: %d เป็น \"%s\"", ReturnRealName(playerid, 0), id, address);
	}
	else if (!strcmp(type, "type", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
	        return SendClientMessage(playerid, -1, "/edithouse [id] [type] [interior type]");

		if (typeint < 1 || typeint > sizeof(arrHouseInteriors))
			return SendClientMessageEx(playerid, -1, "ประเภทที่ระบุต้องไม่ต่ำกว่า 1 ถึง %d", sizeof(arrHouseInteriors));

        typeint--;

	    HouseData[id][houseInt][0] = arrHouseInteriors[typeint][eHouseX];
	    HouseData[id][houseInt][1] = arrHouseInteriors[typeint][eHouseY];
	    HouseData[id][houseInt][2] = arrHouseInteriors[typeint][eHouseZ];
	    HouseData[id][houseInt][3] = arrHouseInteriors[typeint][eHouseAngle];
        HouseData[id][houseInterior] = arrHouseInteriors[typeint][eHouseInterior];

		foreach (new i : Player)
		{
			if (Character[i][House] == HouseData[id][houseID])
			{
				SetPlayerPosEx(i, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2], HouseData[id][houseInterior], -1);
				SetPlayerFacingAngle(i, HouseData[id][houseInt][3]);
				SetCameraBehindPlayer(i);
			}
		}
	    House_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับประเภทของบ้านไอดี: %d เป็น %d", ReturnRealName(playerid, 0), id, typeint+1);
	}
	return 1;
}

//House
forward OnLoadFurniture(houseid);
public OnLoadFurniture(houseid)
{
	new
	    rows,
		id = -1;

	cache_get_row_count(rows);

	for (new i = 0; i != rows; i ++) if ((id = Furniture_GetFreeID()) != -1) {
	    FurnitureData[id][furnitureExists] = true;
	    FurnitureData[id][furnitureHouse] = houseid;

        cache_get_value_name(i, "furnitureName", FurnitureData[id][furnitureName], 32);

	    cache_get_value_name_int(i, "furnitureID", FurnitureData[id][furnitureID]);
     	cache_get_value_name_int(i, "furnitureModel", FurnitureData[id][furnitureModel]);
     	cache_get_value_name_float(i, "furnitureX", FurnitureData[id][furniturePos][0]);
     	cache_get_value_name_float(i, "furnitureY", FurnitureData[id][furniturePos][1]);
     	cache_get_value_name_float(i, "furnitureZ", FurnitureData[id][furniturePos][2]);
     	cache_get_value_name_float(i, "furnitureRX", FurnitureData[id][furnitureRot][0]);
     	cache_get_value_name_float(i, "furnitureRY", FurnitureData[id][furnitureRot][1]);
     	cache_get_value_name_float(i, "furnitureRZ", FurnitureData[id][furnitureRot][2]);
	    cache_get_value_name_int(i, "furnitureInt", FurnitureData[id][furnitureInt] );
     	cache_get_value_name_int(i, "furnitureVW", FurnitureData[id][furnitureVW]);

		if(FurnitureData[id][furniturePos][2] > 800 && FurnitureData[id][furnitureInt] == 0 && FurnitureData[id][furnitureVW] == 0)
		{
			FurnitureData[id][furnitureInt] = HouseData[houseid][houseInterior];
			FurnitureData[id][furnitureVW] = HouseData[houseid][houseID]+5000;
		}

	    Furniture_Refresh(id);
	}
	//printf("[MYSQL]: %d Furnitures have been successfully loaded from the database.", Total_Furnitures_Created);
	return 1;
}

Furniture_GetCount(houseid)
{
	new count;

	for (new i = 0; i < MAX_FURNITURE; i ++) if (FurnitureData[i][furnitureExists] && FurnitureData[i][furnitureHouse] == houseid) {
	    count++;
	}
	return count;
}

Furniture_GetFreeID()
{
	for (new i = 0; i != MAX_FURNITURE; i ++) if (!FurnitureData[i][furnitureExists]) {
	    return i;
	}
	return -1;
}

Furniture_Refresh(furnitureid)
{
	if (furnitureid != -1 && FurnitureData[furnitureid][furnitureExists])
	{
	    if (IsValidDynamicObject(FurnitureData[furnitureid][furnitureObject]))
	        DestroyDynamicObject(FurnitureData[furnitureid][furnitureObject]);

	    FurnitureData[furnitureid][furnitureObject] = CreateDynamicObject(
			FurnitureData[furnitureid][furnitureModel],
			FurnitureData[furnitureid][furniturePos][0],
			FurnitureData[furnitureid][furniturePos][1],
			FurnitureData[furnitureid][furniturePos][2],
			FurnitureData[furnitureid][furnitureRot][0],
			FurnitureData[furnitureid][furnitureRot][1],
			FurnitureData[furnitureid][furnitureRot][2],
			FurnitureData[furnitureid][furnitureVW],
			FurnitureData[furnitureid][furnitureInt]
		);
	}
	return 1;
}

Furniture_Save(furnitureid)
{
	new
	    string[360];

	format(string, sizeof(string), "UPDATE `furniture` SET `furnitureModel` = '%d', `furnitureName` = '%s', `furnitureX` = '%.4f', `furnitureY` = '%.4f', `furnitureZ` = '%.4f', `furnitureRX` = '%.4f', `furnitureRY` = '%.4f', `furnitureRZ` = '%.4f', `furnitureInt` = '%d' , `furnitureVW` = '%d' WHERE `ID` = '%d' AND `furnitureID` = '%d'",
	    FurnitureData[furnitureid][furnitureModel],
	    FurnitureData[furnitureid][furnitureName],
	    FurnitureData[furnitureid][furniturePos][0],
	    FurnitureData[furnitureid][furniturePos][1],
	    FurnitureData[furnitureid][furniturePos][2],
	    FurnitureData[furnitureid][furnitureRot][0],
	    FurnitureData[furnitureid][furnitureRot][1],
	    FurnitureData[furnitureid][furnitureRot][2],
	    FurnitureData[furnitureid][furnitureInt],
	    FurnitureData[furnitureid][furnitureVW],
	    HouseData[FurnitureData[furnitureid][furnitureHouse]][houseID],
	    FurnitureData[furnitureid][furnitureID]
	);
	return mysql_tquery(dbCon, string);
}

Furniture_Add(houseid, name[], modelid, Float:x, Float:y, Float:z, Float:rx = 0.0, Float:ry = 0.0, Float:rz = 0.0, interior, virtualworld)
{
	new
	    string[64],
		id = -1;

 	if (houseid == -1 || !HouseData[houseid][houseExists])
	    return 0;

	if ((id = Furniture_GetFreeID()) != -1)
	{
	    FurnitureData[id][furnitureExists] = true;
	    format(FurnitureData[id][furnitureName], 32, name);

        FurnitureData[id][furnitureHouse] = houseid;
	    FurnitureData[id][furnitureModel] = modelid;
	    FurnitureData[id][furniturePos][0] = x;
	    FurnitureData[id][furniturePos][1] = y;
	    FurnitureData[id][furniturePos][2] = z;
	    FurnitureData[id][furnitureRot][0] = rx;
	    FurnitureData[id][furnitureRot][1] = ry;
	    FurnitureData[id][furnitureRot][2] = rz;

	    FurnitureData[id][furnitureInt] = interior;
	    FurnitureData[id][furnitureVW] = virtualworld;

	    Furniture_Refresh(id);

		format(string, sizeof(string), "INSERT INTO `furniture` (`ID`) VALUES(%d)", HouseData[houseid][houseID]);
		mysql_tquery(dbCon, string, "OnFurnitureCreated", "d", id);

		return id;
	}
	return -1;
}

Dialog:ListedFurniture(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = House_Area(playerid);
	    if (id != -1 && House_IsOwner(playerid, id))
	    {
	        Character[playerid][EditFurniture] = ListedFurniture[playerid][listitem];
			Dialog_Show(playerid, FurnitureList, DIALOG_STYLE_LIST, FurnitureData[Character[playerid][EditFurniture]][furnitureName], "แก้ไขตำแหน่ง\nหยิบเฟอร์นิเจอร์\nทำลายเฟอร์นิเจอร์", "Select", "Cancel");
		}
	}
	for (new i = 0; i != MAX_HOUSE_FURNITURE; i ++) {
	    ListedFurniture[playerid][i] = -1;
	}
	return 1;
}

Dialog:FurnitureList(playerid, response, listitem, inputtext[])
{
	if (response)
	{
        new id = House_Area(playerid);

	    if (id != -1 && House_IsOwner(playerid, id))
	    {
	   		switch (listitem)
		    {
		        case 0:
				{
					EditDynamicObject(playerid, FurnitureData[Character[playerid][EditFurniture]][furnitureObject]);
					SendClientMessageEx(playerid, -1, "คุณกำลังแก้ไขตำแหน่งของ \"%s\"", FurnitureData[Character[playerid][EditFurniture]][furnitureName]);
				}
				case 1:
				{
				    new item = Inventory_Add(playerid, FurnitureData[Character[playerid][EditFurniture]][furnitureName], FurnitureData[Character[playerid][EditFurniture]][furnitureModel]);

				    if (item == -1)
        				return SendClientMessage(playerid, -1, "คุณไม่เหลือช่องว่างในช่องเก็บของแล้ว");

				    SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้หยิบ \"%s\"", ReturnName(playerid, 0), FurnitureData[Character[playerid][EditFurniture]][furnitureName]);
				    SendClientMessageEx(playerid, -1, "คุณพยายามหยิบ \"%s\" และมันถูกเพิ่มอยู่ในช่องเก็บของ", FurnitureData[Character[playerid][EditFurniture]][furnitureName]);

				    Furniture_Delete(Character[playerid][EditFurniture]);
					CancelEdit(playerid);

				    Character[playerid][EditFurniture] = -1;
				}
				case 2:
				{
				    Furniture_Delete(Character[playerid][EditFurniture]);
				    SendClientMessageEx(playerid, -1, "คุณทำลายเฟอร์นิเจอร์ \"%s\"", FurnitureData[Character[playerid][EditFurniture]][furnitureName]);

				    CancelEdit(playerid);
				    Character[playerid][EditFurniture] = -1;
				}
			}
		}
		else {
			Character[playerid][EditFurniture] = -1;
		}
	}
	else {
	    Character[playerid][EditFurniture] = -1;
	}
	return 1;
}

Furniture_Delete(furnitureid)
{
	new
	    string[72];

	if (furnitureid != -1 && FurnitureData[furnitureid][furnitureExists])
	{

	    format(string, sizeof(string), "DELETE FROM `furniture` WHERE `ID` = '%d' AND `furnitureID` = '%d'", HouseData[FurnitureData[furnitureid][furnitureHouse]][houseID], FurnitureData[furnitureid][furnitureID]);
		mysql_tquery(dbCon, string);

		FurnitureData[furnitureid][furnitureExists] = false;
		FurnitureData[furnitureid][furnitureModel] = 0;

		DestroyDynamicObject(FurnitureData[furnitureid][furnitureObject]);
	}
	return 1;
}

forward OnFurnitureCreated(furnitureid);
public OnFurnitureCreated(furnitureid)
{
	FurnitureData[furnitureid][furnitureID] = cache_insert_id();
	Furniture_Save(furnitureid);
	return 1;
}

stock IsFurnitureItem(item[])
{
    for (new i = 0; i < sizeof(g_aFurnitureData); i ++) if (!strcmp(g_aFurnitureData[i][e_FurnitureName], item)) {
        return 1;
	}
	return 0;
}

stock GetFurnitureNameByModel(model)
{
	new
	    name[32];

	for (new i = 0; i < sizeof(g_aFurnitureData); i ++) if (g_aFurnitureData[i][e_FurnitureModel] == model) {
		strcat(name, g_aFurnitureData[i][e_FurnitureName]);

		break;
	}
	return name;
}
