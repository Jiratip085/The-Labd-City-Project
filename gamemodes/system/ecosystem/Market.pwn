#include 	<YSI_Coding\y_hooks>
new 
	FishCash,
	ShellCash,
	TurtleCash,
	StarfishCash,
	JellyfishCash,
	IronCash,
	GoldCash,
	DiamonCash,
	AppleCash,
	WoodPacksCash;

hook OnGameModeInit()
{
	CreateDynamicPickup(1239, 23, 1124.5737,-1471.6287,15.7728); //จัดอันดับ
   	CreateDynamic3DTextLabel("[รายการจัดอันดับ]{FFFFFF}\nกด 'Y' เพื่อใช้งาน", COLOR_YELLOW,1124.5737,-1471.6287,15.7728, 3.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    
	CreateDynamicPickup(1239, 23, 1133.2725,-1471.5579,15.7805); //ราคาตลาด
   	CreateDynamic3DTextLabel("[ตลาดขายสินค้า]{FFFFFF}\nกด 'Y' เพื่อใช้งาน", COLOR_YELLOW, 1133.2725,-1471.5579,15.7805, 3.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    
	/*CreateDynamicPickup(1239, 23, 1154.7311,-1440.1427,15.7969); //ร้านขายของ
   	CreateDynamic3DTextLabel("[จุดขายของ]{FFFFFF}\nกด 'Y' เพื่อใช้งาน", COLOR_YELLOW, 1154.7311,-1440.1427,15.7969, 3.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    */
/* ------------------------------------------------------------------------------------------ */
	UpDateWorldMarket();


	FishCash = randomEx(40 ,60);
	ShellCash = randomEx(50 ,70);
	StarfishCash = randomEx(60 ,80);
	JellyfishCash = randomEx(70 ,150);
	TurtleCash = randomEx(100 ,300);

	AppleCash = randomEx(500,650);
	IronCash = randomEx(40,60);
	GoldCash = randomEx(50,100);
	DiamonCash = randomEx(500,1000);
	WoodPacksCash = randomEx(50,80);
	return 1;
}

forward UpDateWorldMarket();
public UpDateWorldMarket()
{
    new
        hours,
        minutes,
        seconds;
    gettime(hours, minutes, seconds);

	if(minutes == 00 && seconds == 00)
	{
		UpdateMarket();
	}
	SetTimer("UpDateWorldMarket", 1000, false);
}
UpdateMarket()
{
	//ตลาดกลาง
	FishCash = randomEx(40 ,60);
	ShellCash = randomEx(50 ,70);
	StarfishCash = randomEx(60 ,80);
	JellyfishCash = randomEx(70 ,150);
	TurtleCash = randomEx(100 ,300);

	AppleCash = randomEx(500,650);
	IronCash = randomEx(40,60);
	GoldCash = randomEx(50,100);
	DiamonCash = randomEx(500,1000);
	WoodPacksCash = randomEx(50,80);
	SendClientMessageToAll(COLOR_YELLOW, "[Market]: ขณะนี้ราคาตลาดนั้นถูก 'Update' เรียบร้อย");
	return 1;
}
Marketpricegraph(playerid)
{
	new string100[1024];
	new string2[1024];
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);

	format(string100, sizeof(string100), "รายการสิ่งของ\tราคา\n");
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Iron (เหล็ก)\t{00FF00}%s\n", FormatMoney(IronCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Gold (ทอง)\t{00FF00}%s\n", FormatMoney(GoldCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Diamon (เพชร)\t{00FF00}%s\n", FormatMoney(DiamonCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- WoodPacks (แพ็คไม้)\t{00FF00}%s\n", FormatMoney(WoodPacksCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Fish (ปลาทั่วไป)\t{00FF00}%s\n", FormatMoney(FishCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Shell (หอยแครง)\t{00FF00}%s\n", FormatMoney(ShellCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Starfish (ปลาดาว)\t{00FF00}%s\n", FormatMoney(StarfishCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Jellyfish (แมงกะพรุน)\t{00FF00}%s\n", FormatMoney(JellyfishCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Turtle (เต่า)\t{00FF00}%s\n", FormatMoney(TurtleCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Apple Packs (แพ็คแอปเปิ้ล)\t{00FF00}%s\n", FormatMoney(AppleCash));
	strcat(string2,string100);

	Dialog_Show(playerid, Market_Sell1, DIALOG_STYLE_TABLIST_HEADERS,"ราคาตลาด", string2, "ปิด", "");
	return 1;
}
Marketprice(playerid)
{
	new string100[1024];
	new string2[1024];
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);

	format(string100, sizeof(string100), "รายการสิ่งของ\tราคา\n");
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Iron (เหล็ก)\t{00FF00}%s\n", FormatMoney(IronCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Gold (ทอง)\t{00FF00}%s\n", FormatMoney(GoldCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Diamon (เพชร)\t{00FF00}%s\n", FormatMoney(DiamonCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- WoodPacks (แพ็คไม้)\t{00FF00}%s\n", FormatMoney(WoodPacksCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Fish (ปลาทั่วไป)\t{00FF00}%s\n", FormatMoney(FishCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Shell (หอยแครง)\t{00FF00}%s\n", FormatMoney(ShellCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Starfish (ปลาดาว)\t{00FF00}%s\n", FormatMoney(StarfishCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Jellyfish (แมงกะพรุน)\t{00FF00}%s\n", FormatMoney(JellyfishCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Turtle (เต่า)\t{00FF00}%s\n", FormatMoney(TurtleCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Apple Packs (แพ็คแอปเปิ้ล)\t{00FF00}%s\n", FormatMoney(AppleCash));
	strcat(string2,string100);

	Dialog_Show(playerid, Market_Sell, DIALOG_STYLE_TABLIST_HEADERS,"ราคาตลาด", string2, "ปิด", "");
	return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
        if (IsPlayerInRangeOfPoint(playerid, 1.5,1124.5737,-1471.6287,15.7728)) //จัดอันดับ
		{

			PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
            return 	Dialog_Show(playerid, Market_Grade,  DIALOG_STYLE_LIST, "[รายการจัดอันดับ]", "- ชั่วโมงออนไลน์\n\
					- เงินสด(Cash)\n\
					- เงินในธนาคาร(Bank)\n\
					- คลังเงิน(Gang)\n\
					- คลังเงิน(Business)\n\
					- ประสบการณ์ขนส่งสินค้า(Trucking)", "เลือก", "ปิด");
		}
        if (IsPlayerInRangeOfPoint(playerid, 1.5, 1133.2725,-1471.5579,15.7805)) //ราคาตลาด
			return Marketprice(playerid);

    }
	/*if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid)) //ขายของ
	{
		if (Shop_Nearest(playerid) != -1)
		{
			new shopid = Shop_Nearest(playerid);
			
			if(shopData[shopid][shopType] == 6)
				return Marketprice(playerid);
		}
    }*/
    return 1;
}

Dialog:Market_Sell(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		switch (listitem)
		{
			case 0: Dialog_Show(playerid, Sell_Iron, DIALOG_STYLE_INPUT, "Iron (เหล็ก)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", Inventory_Count(playerid, "Iron"));
			case 1: Dialog_Show(playerid, Sell_Gold, DIALOG_STYLE_INPUT, "Gold (ทอง)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", Inventory_Count(playerid, "Gold"));
			case 2: Dialog_Show(playerid, Sell_Diamon, DIALOG_STYLE_INPUT, "Diamon (เพชร)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", Inventory_Count(playerid, "Diamon"));
			case 3: Dialog_Show(playerid, Sell_WoodPacks, DIALOG_STYLE_INPUT, "WoodPacks (แพ็คไม้)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", Inventory_Count(playerid, "WoodPacks"));
			case 4: Dialog_Show(playerid, Sell_Fish, DIALOG_STYLE_INPUT, "Fish (ปลาทั่วไป)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", Inventory_Count(playerid, "Fish"));
			case 5: Dialog_Show(playerid, Sell_Shell, DIALOG_STYLE_INPUT, "Shell (หอยแครง)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", Inventory_Count(playerid, "Shell"));
			case 6: Dialog_Show(playerid, Sell_Starfish, DIALOG_STYLE_INPUT, "Starfish (ปลาดาว)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", Inventory_Count(playerid, "Starfish"));
			case 7: Dialog_Show(playerid, Sell_Jellyfish, DIALOG_STYLE_INPUT, "Jellyfish (แมงกะพรุน)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", Inventory_Count(playerid, "Jellyfish"));
			case 8: Dialog_Show(playerid, Sell_Turtle, DIALOG_STYLE_INPUT, "Turtle (เต่า)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", Inventory_Count(playerid, "Turtle"));
			case 9: Dialog_Show(playerid, Sell_Apple, DIALOG_STYLE_INPUT, "Apple Pack (แพ็คแอปเปิ้ล)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", Inventory_Count(playerid, "ApplePack"));

		}
	}
	return 1;
}
Dialog:Sell_Apple(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if(response)
    {
		new itemname[24], string[128],
			amount = strval(inputtext);

    	itemname = "ApplePack";
		new count = Inventory_Count(playerid, itemname);

		if(sscanf(inputtext, "d", amount))
			return Dialog_Show(playerid, Sell_Apple, DIALOG_STYLE_INPUT, "Apple Pack (แพ็คแอปเปิ้ล)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Apple, DIALOG_STYLE_INPUT, "Apple Pack (แพ็คแอปเปิ้ล)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*โปรดระบุจำนวน '%s' มากกว่า 0", "ตกลง", "ยกเลิก", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Apple, DIALOG_STYLE_INPUT, "Apple Pack (แพ็คแอปเปิ้ล)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*ไม่สามารถขายได้ เนื่องจากคุณมีจำนวน '%s' ไม่เพียงพอ", "ตกลง", "ยกเลิก", count, itemname);

		new givemoney = amount * AppleCash;
		format(string, sizeof(string), "~g~+%s Cash~n~~r~-%d %s", FormatMoney(givemoney), amount, itemname);
   		GameTextForPlayer(playerid, string, 5000, 1);
		GivePlayerMoneyEx(playerid, givemoney);

		Inventory_Remove(playerid, itemname, amount);
	}
	return 1;
}
Dialog:Sell_Turtle(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if(response)
    {
		new itemname[24], string[128],
			amount = strval(inputtext);

    	itemname = "Turtle";
		new count = Inventory_Count(playerid, itemname);

		if(sscanf(inputtext, "d", amount))
			return Dialog_Show(playerid, Sell_Turtle, DIALOG_STYLE_INPUT, "Turtle (เต่า)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Turtle, DIALOG_STYLE_INPUT, "Turtle (เต่า)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*โปรดระบุจำนวน '%s' มากกว่า 0", "ตกลง", "ยกเลิก", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Turtle, DIALOG_STYLE_INPUT, "Turtle (เต่า)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*ไม่สามารถขายได้ เนื่องจากคุณมีจำนวน '%s' ไม่เพียงพอ", "ตกลง", "ยกเลิก", count, itemname);

		new givemoney = amount * TurtleCash;
		format(string, sizeof(string), "~g~+%s Cash~n~~r~-%d %s", FormatMoney(givemoney), amount, itemname);
   		GameTextForPlayer(playerid, string, 5000, 1);
		GivePlayerMoneyEx(playerid, givemoney);

		Inventory_Remove(playerid, itemname, amount);
	}
	return 1;
}
Dialog:Sell_Jellyfish(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if(response)
    {
		new itemname[24], string[128],
			amount = strval(inputtext);

    	itemname = "Jellyfish";
		new count = Inventory_Count(playerid, itemname);

		if(sscanf(inputtext, "d", amount))
			return Dialog_Show(playerid, Sell_Jellyfish, DIALOG_STYLE_INPUT, "Jellyfish (แมงกะพรุน)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Jellyfish, DIALOG_STYLE_INPUT, "Jellyfish (แมงกะพรุน)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*โปรดระบุจำนวน '%s' มากกว่า 0", "ตกลง", "ยกเลิก", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Jellyfish, DIALOG_STYLE_INPUT, "Jellyfish (แมงกะพรุน)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*ไม่สามารถขายได้ เนื่องจากคุณมีจำนวน '%s' ไม่เพียงพอ", "ตกลง", "ยกเลิก", count, itemname);

		new givemoney = amount * JellyfishCash;
		format(string, sizeof(string), "~g~+%s Cash~n~~r~-%d %s", FormatMoney(givemoney), amount, itemname);
   		GameTextForPlayer(playerid, string, 5000, 1);
		GivePlayerMoneyEx(playerid, givemoney);

		Inventory_Remove(playerid, itemname, amount);
	}
	return 1;
}
Dialog:Sell_Starfish(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if(response)
    {
		new itemname[24], string[128],
			amount = strval(inputtext);

    	itemname = "Starfish";
		new count = Inventory_Count(playerid, itemname);

		if(sscanf(inputtext, "d", amount))
			return Dialog_Show(playerid, Sell_Starfish, DIALOG_STYLE_INPUT, "Starfish (ปลาดาว)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Starfish, DIALOG_STYLE_INPUT, "Starfish (ปลาดาว)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*โปรดระบุจำนวน '%s' มากกว่า 0", "ตกลง", "ยกเลิก", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Starfish, DIALOG_STYLE_INPUT, "Starfish (ปลาดาว)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*ไม่สามารถขายได้ เนื่องจากคุณมีจำนวน '%s' ไม่เพียงพอ", "ตกลง", "ยกเลิก", count, itemname);

		new givemoney = amount * StarfishCash;
		format(string, sizeof(string), "~g~+%s Cash~n~~r~-%d %s", FormatMoney(givemoney), amount, itemname);
   		GameTextForPlayer(playerid, string, 5000, 1);
		GivePlayerMoneyEx(playerid, givemoney);

		Inventory_Remove(playerid, itemname, amount);
	}
	return 1;
}

Dialog:Sell_Shell(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if(response)
    {
		new itemname[24], string[128],
			amount = strval(inputtext);

    	itemname = "Shell";
		new count = Inventory_Count(playerid, itemname);

		if(sscanf(inputtext, "d", amount))
			return Dialog_Show(playerid, Sell_Shell, DIALOG_STYLE_INPUT, "Shell (หอยแครง)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Shell, DIALOG_STYLE_INPUT, "Shell (หอยแครง)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*โปรดระบุจำนวน '%s' มากกว่า 0", "ตกลง", "ยกเลิก", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Shell, DIALOG_STYLE_INPUT, "Shell (หอยแครง)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*ไม่สามารถขายได้ เนื่องจากคุณมีจำนวน '%s' ไม่เพียงพอ", "ตกลง", "ยกเลิก", count, itemname);

		new givemoney = amount * ShellCash;
		format(string, sizeof(string), "~g~+%s Cash~n~~r~-%d %s", FormatMoney(givemoney), amount, itemname);
   		GameTextForPlayer(playerid, string, 5000, 1);
		GivePlayerMoneyEx(playerid, givemoney);

		Inventory_Remove(playerid, itemname, amount);
	}
	return 1;
}
Dialog:Sell_Fish(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if(response)
    {
		new itemname[24], string[128],
			amount = strval(inputtext);

    	itemname = "Fish";
		new count = Inventory_Count(playerid, itemname);

		if(sscanf(inputtext, "d", amount))
			return Dialog_Show(playerid, Sell_Fish, DIALOG_STYLE_INPUT, "Fish (ปลาทั่วไป)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Fish, DIALOG_STYLE_INPUT, "Fish (ปลาทั่วไป)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*โปรดระบุจำนวน '%s' มากกว่า 0", "ตกลง", "ยกเลิก", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Fish, DIALOG_STYLE_INPUT, "Fish (ปลาทั่วไป)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*ไม่สามารถขายได้ เนื่องจากคุณมีจำนวน '%s' ไม่เพียงพอ", "ตกลง", "ยกเลิก", count, itemname);

		new givemoney = amount * FishCash;
		format(string, sizeof(string), "~g~+%s Cash~n~~r~-%d %s", FormatMoney(givemoney), amount, itemname);
   		GameTextForPlayer(playerid, string, 5000, 1);
		GivePlayerMoneyEx(playerid, givemoney);

		Inventory_Remove(playerid, itemname, amount);
	}
	return 1;
}
Dialog:Sell_Iron(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if(response)
    {
		new itemname[24], string[128],
			amount = strval(inputtext);

    	itemname = "Iron";
		new count = Inventory_Count(playerid, itemname);

		if(sscanf(inputtext, "d", amount))
			return Dialog_Show(playerid, Sell_Iron, DIALOG_STYLE_INPUT, "Iron (เหล็ก)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Iron, DIALOG_STYLE_INPUT, "Iron (เหล็ก)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*โปรดระบุจำนวน '%s' มากกว่า 0", "ตกลง", "ยกเลิก", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Iron, DIALOG_STYLE_INPUT, "Iron (เหล็ก)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*ไม่สามารถขายได้ เนื่องจากคุณมีจำนวน '%s' ไม่เพียงพอ", "ตกลง", "ยกเลิก", count, itemname);

		new givemoney = amount * IronCash;
		format(string, sizeof(string), "~g~+%s Cash~n~~r~-%d %s", FormatMoney(givemoney), amount, itemname);
   		GameTextForPlayer(playerid, string, 5000, 1);
		GivePlayerMoneyEx(playerid, givemoney);

		Inventory_Remove(playerid, itemname, amount);
	}
	return 1;
}
Dialog:Sell_Gold(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if(response)
    {
		new itemname[24], string[128],
			amount = strval(inputtext);

    	itemname = "Gold";
		new count = Inventory_Count(playerid, itemname);

		if(sscanf(inputtext, "d", amount))
			return Dialog_Show(playerid, Sell_Gold, DIALOG_STYLE_INPUT, "Gold (ทอง)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Gold, DIALOG_STYLE_INPUT, "Gold (ทอง)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*โปรดระบุจำนวน '%s' มากกว่า 0", "ตกลง", "ยกเลิก", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Gold, DIALOG_STYLE_INPUT, "Gold (ทอง)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*ไม่สามารถขายได้ เนื่องจากคุณมีจำนวน '%s' ไม่เพียงพอ", "ตกลง", "ยกเลิก", count, itemname);

		new givemoney = amount * GoldCash;
		format(string, sizeof(string), "~g~+%s Cash~n~~r~-%d %s", FormatMoney(givemoney), amount, itemname);
   		GameTextForPlayer(playerid, string, 5000, 1);
		GivePlayerMoneyEx(playerid, givemoney);

		Inventory_Remove(playerid, itemname, amount);
	}
	return 1;
}
Dialog:Sell_Diamon(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if(response)
    {
		new itemname[24], string[128],
			amount = strval(inputtext);

    	itemname = "Diamon";
		new count = Inventory_Count(playerid, itemname);

		if(sscanf(inputtext, "d", amount))
			return Dialog_Show(playerid, Sell_Diamon, DIALOG_STYLE_INPUT, "Diamon (เพชร)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Diamon, DIALOG_STYLE_INPUT, "Diamon (เพชร)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*โปรดระบุจำนวน '%s' มากกว่า 0", "ตกลง", "ยกเลิก", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Diamon, DIALOG_STYLE_INPUT, "Diamon (เพชร)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*ไม่สามารถขายได้ เนื่องจากคุณมีจำนวน '%s' ไม่เพียงพอ", "ตกลง", "ยกเลิก", count, itemname);

		new givemoney = amount * DiamonCash;
		format(string, sizeof(string), "~g~+%s Cash~n~~r~-%d %s", FormatMoney(givemoney), amount, itemname);
   		GameTextForPlayer(playerid, string, 5000, 1);
		GivePlayerMoneyEx(playerid, givemoney);

		Inventory_Remove(playerid, itemname, amount);
	}
	return 1;
}
Dialog:Sell_WoodPacks(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if(response)
    {
		new itemname[24], string[128],
			amount = strval(inputtext);

    	itemname = "WoodPacks";
		new count = Inventory_Count(playerid, itemname);

		if(sscanf(inputtext, "d", amount))
			return Dialog_Show(playerid, Sell_WoodPacks, DIALOG_STYLE_INPUT, "WoodPacks (แพ็คไม้)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'", "ตกลง", "ยกเลิก", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_WoodPacks, DIALOG_STYLE_INPUT, "WoodPacks (แพ็คไม้)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*โปรดระบุจำนวน '%s' มากกว่า 0", "ตกลง", "ยกเลิก", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_WoodPacks, DIALOG_STYLE_INPUT, "WoodPacks (แพ็คไม้)", "โปรดระบุจำนวนที่คุณต้องการจะขาย, คุณมีอยู่จำนวน: '%d'\
			{FF6347}\n*ไม่สามารถขายได้ เนื่องจากคุณมีจำนวน '%s' ไม่เพียงพอ", "ตกลง", "ยกเลิก", count, itemname);

		new givemoney = amount * WoodPacksCash;
		format(string, sizeof(string), "~g~+%s Cash~n~~r~-%d %s", FormatMoney(givemoney), amount, itemname);
   		GameTextForPlayer(playerid, string, 5000, 1);
		GivePlayerMoneyEx(playerid, givemoney);

		Inventory_Remove(playerid, itemname, amount);
	}
	return 1;
}
































// --> จัดอันดับผู้เล่น
Dialog:Market_Grade(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
		    case 0: //Hours
		    {
		        new query[128];
		     	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` ORDER BY `playerHours` DESC LIMIT 10");
			    mysql_tquery(g_SQL, query, "TopRank", "ii", playerid, 1);
		    }
		    case 1: //Cash
		    {
		        new query[128];
		     	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` ORDER BY `playerMoney` DESC LIMIT 10");
			    mysql_tquery(g_SQL, query, "TopRank", "ii", playerid, 2);
		    }
		    case 2: //Bank
		    {
		        new query[128];
		     	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` ORDER BY `playerBank` DESC LIMIT 10");
			    mysql_tquery(g_SQL, query, "TopRank", "ii", playerid, 3);
		    }
		    case 3: //คลังเงิน(Gang)
		    {

		    }
		    case 4: //คลังเงิน(Business)
		    {
		        new query[128];
		     	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `business` ORDER BY `businessTreasury` DESC LIMIT 10");
			    mysql_tquery(g_SQL, query, "TopRank", "ii", playerid, 5);
		    }
		    case 5: //Truck
		    {
		        new query[128];
		     	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` ORDER BY `playerTruck` DESC LIMIT 10");
			    mysql_tquery(g_SQL, query, "TopRank", "ii", playerid, 6);
		    }

		}
	}
	return 1;
}

// --> จัดอันดับ
forward TopRank(playerid, threadid);
public TopRank(playerid, threadid)
{
    new string[1000], string5[1000];
    new name[25], amount;
    new rows = cache_num_rows();
    switch(threadid)
    {
		case 1:
		{
		    for(new i = 0; i < rows; i ++)
		    {
			    cache_get_value_name(i, "playerName", name, 25);
			    cache_get_value_name_int(i, "playerHours", amount);

				format(string, sizeof(string), "{04A90D}(%d)\t{FFFFFF}%s\t{F6E008}%s\n", i+1, name, FormatNumber(amount));
				strcat(string5, string);
			}
			format(string, sizeof(string), "อันดับ\tรายชื่อ\tชั่วโมงออนไลน์\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "ชั่วโมงออนไลน์ (Hours)", string, "ปิด","");
		}
		case 2:
		{
		    for(new i = 0; i < rows; i ++)
		    {
			    cache_get_value_name(i, "playerName", name, 25);
			    cache_get_value_name_int(i, "playerMoney", amount);

				format(string, sizeof(string), "{04A90D}(%d)\t{FFFFFF}%s\t{F6E008}%s $\n", i+1, name, FormatMoney(amount));
				strcat(string5, string);
			}
			format(string, sizeof(string), "อันดับ\tรายชื่อ\tเงินสด\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "เงินสด (Cash)", string, "ปิด","");
		}
		case 3:
		{
		    for(new i = 0; i < rows; i ++)
		    {
			    cache_get_value_name(i, "playerName", name, 25);
			    cache_get_value_name_int(i, "playerBank", amount);

				format(string, sizeof(string), "{04A90D}(%d)\t{FFFFFF}%s\t{F6E008}%s $\n", i+1, name, FormatMoney(amount));
				strcat(string5, string);
			}
			format(string, sizeof(string), "อันดับ\tรายชื่อ\tเงินในธนาคาร\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "เงินในธนาคาร (Bank)", string, "ปิด","");
		}
		case 4:
		{

		}
		case 5:
		{
		    for(new i = 0; i < rows; i ++)
		    {
			    cache_get_value_name(i, "businessName", name, 25);
			    cache_get_value_name_int(i, "businessTreasury", amount);

				format(string, sizeof(string), "{04A90D}(%d)\t{FFFFFF}%s\t{F6E008}%s $\n", i+1, name, FormatMoney(amount));
				strcat(string5, string);
			}
			format(string, sizeof(string), "อันดับ\tรายชื่อธุรกิจ\tคลังเงิน\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "คลังเงิน (Business)", string, "ปิด","");
		}
		case 6:
		{
		    for(new i = 0; i < rows; i ++)
		    {
			    cache_get_value_name(i, "playerName", name, 25);
			    cache_get_value_name_int(i, "playerTruck", amount);

				format(string, sizeof(string), "{04A90D}(%d)\t{FFFFFF}%s\t{F6E008}%s ครั้ง\n", i+1, name, FormatNumber(amount));
				strcat(string5, string);
			}
			format(string, sizeof(string), "อันดับ\tรายชื่อ\tการขนส่งสินค้า\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "การขนส่งสินค้า (Trucking)", string, "ปิด","");
		}
	}
	return 1;
}
