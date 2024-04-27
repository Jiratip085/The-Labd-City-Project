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
	CreateDynamicPickup(1239, 23, 1124.5737,-1471.6287,15.7728); //�Ѵ�ѹ�Ѻ
   	CreateDynamic3DTextLabel("[��¡�èѴ�ѹ�Ѻ]{FFFFFF}\n�� 'Y' ������ҹ", COLOR_YELLOW,1124.5737,-1471.6287,15.7728, 3.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    
	CreateDynamicPickup(1239, 23, 1133.2725,-1471.5579,15.7805); //�Ҥҵ�Ҵ
   	CreateDynamic3DTextLabel("[��Ҵ����Թ���]{FFFFFF}\n�� 'Y' ������ҹ", COLOR_YELLOW, 1133.2725,-1471.5579,15.7805, 3.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    
	/*CreateDynamicPickup(1239, 23, 1154.7311,-1440.1427,15.7969); //��ҹ��¢ͧ
   	CreateDynamic3DTextLabel("[�ش��¢ͧ]{FFFFFF}\n�� 'Y' ������ҹ", COLOR_YELLOW, 1154.7311,-1440.1427,15.7969, 3.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
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
	//��Ҵ��ҧ
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
	SendClientMessageToAll(COLOR_YELLOW, "[Market]: ��й���Ҥҵ�Ҵ��鹶١ 'Update' ���º����");
	return 1;
}
Marketpricegraph(playerid)
{
	new string100[1024];
	new string2[1024];
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);

	format(string100, sizeof(string100), "��¡����觢ͧ\t�Ҥ�\n");
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Iron (����)\t{00FF00}%s\n", FormatMoney(IronCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Gold (�ͧ)\t{00FF00}%s\n", FormatMoney(GoldCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Diamon (ྪ�)\t{00FF00}%s\n", FormatMoney(DiamonCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- WoodPacks (�����)\t{00FF00}%s\n", FormatMoney(WoodPacksCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Fish (��ҷ����)\t{00FF00}%s\n", FormatMoney(FishCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Shell (����ç)\t{00FF00}%s\n", FormatMoney(ShellCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Starfish (��Ҵ��)\t{00FF00}%s\n", FormatMoney(StarfishCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Jellyfish (����о�ع)\t{00FF00}%s\n", FormatMoney(JellyfishCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Turtle (���)\t{00FF00}%s\n", FormatMoney(TurtleCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Apple Packs (���ͻ����)\t{00FF00}%s\n", FormatMoney(AppleCash));
	strcat(string2,string100);

	Dialog_Show(playerid, Market_Sell1, DIALOG_STYLE_TABLIST_HEADERS,"�Ҥҵ�Ҵ", string2, "�Դ", "");
	return 1;
}
Marketprice(playerid)
{
	new string100[1024];
	new string2[1024];
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);

	format(string100, sizeof(string100), "��¡����觢ͧ\t�Ҥ�\n");
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Iron (����)\t{00FF00}%s\n", FormatMoney(IronCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Gold (�ͧ)\t{00FF00}%s\n", FormatMoney(GoldCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Diamon (ྪ�)\t{00FF00}%s\n", FormatMoney(DiamonCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- WoodPacks (�����)\t{00FF00}%s\n", FormatMoney(WoodPacksCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Fish (��ҷ����)\t{00FF00}%s\n", FormatMoney(FishCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Shell (����ç)\t{00FF00}%s\n", FormatMoney(ShellCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Starfish (��Ҵ��)\t{00FF00}%s\n", FormatMoney(StarfishCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Jellyfish (����о�ع)\t{00FF00}%s\n", FormatMoney(JellyfishCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Turtle (���)\t{00FF00}%s\n", FormatMoney(TurtleCash));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFA84D}- Apple Packs (���ͻ����)\t{00FF00}%s\n", FormatMoney(AppleCash));
	strcat(string2,string100);

	Dialog_Show(playerid, Market_Sell, DIALOG_STYLE_TABLIST_HEADERS,"�Ҥҵ�Ҵ", string2, "�Դ", "");
	return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
        if (IsPlayerInRangeOfPoint(playerid, 1.5,1124.5737,-1471.6287,15.7728)) //�Ѵ�ѹ�Ѻ
		{

			PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
            return 	Dialog_Show(playerid, Market_Grade,  DIALOG_STYLE_LIST, "[��¡�èѴ�ѹ�Ѻ]", "- ��������͹�Ź�\n\
					- �Թʴ(Cash)\n\
					- �Թ㹸�Ҥ��(Bank)\n\
					- ��ѧ�Թ(Gang)\n\
					- ��ѧ�Թ(Business)\n\
					- ���ʺ��ó좹���Թ���(Trucking)", "���͡", "�Դ");
		}
        if (IsPlayerInRangeOfPoint(playerid, 1.5, 1133.2725,-1471.5579,15.7805)) //�Ҥҵ�Ҵ
			return Marketprice(playerid);

    }
	/*if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid)) //��¢ͧ
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
			case 0: Dialog_Show(playerid, Sell_Iron, DIALOG_STYLE_INPUT, "Iron (����)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", Inventory_Count(playerid, "Iron"));
			case 1: Dialog_Show(playerid, Sell_Gold, DIALOG_STYLE_INPUT, "Gold (�ͧ)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", Inventory_Count(playerid, "Gold"));
			case 2: Dialog_Show(playerid, Sell_Diamon, DIALOG_STYLE_INPUT, "Diamon (ྪ�)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", Inventory_Count(playerid, "Diamon"));
			case 3: Dialog_Show(playerid, Sell_WoodPacks, DIALOG_STYLE_INPUT, "WoodPacks (�����)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", Inventory_Count(playerid, "WoodPacks"));
			case 4: Dialog_Show(playerid, Sell_Fish, DIALOG_STYLE_INPUT, "Fish (��ҷ����)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", Inventory_Count(playerid, "Fish"));
			case 5: Dialog_Show(playerid, Sell_Shell, DIALOG_STYLE_INPUT, "Shell (����ç)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", Inventory_Count(playerid, "Shell"));
			case 6: Dialog_Show(playerid, Sell_Starfish, DIALOG_STYLE_INPUT, "Starfish (��Ҵ��)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", Inventory_Count(playerid, "Starfish"));
			case 7: Dialog_Show(playerid, Sell_Jellyfish, DIALOG_STYLE_INPUT, "Jellyfish (����о�ع)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", Inventory_Count(playerid, "Jellyfish"));
			case 8: Dialog_Show(playerid, Sell_Turtle, DIALOG_STYLE_INPUT, "Turtle (���)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", Inventory_Count(playerid, "Turtle"));
			case 9: Dialog_Show(playerid, Sell_Apple, DIALOG_STYLE_INPUT, "Apple Pack (���ͻ����)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", Inventory_Count(playerid, "ApplePack"));

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
			return Dialog_Show(playerid, Sell_Apple, DIALOG_STYLE_INPUT, "Apple Pack (���ͻ����)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Apple, DIALOG_STYLE_INPUT, "Apple Pack (���ͻ����)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�ô�кبӹǹ '%s' �ҡ���� 0", "��ŧ", "¡��ԡ", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Apple, DIALOG_STYLE_INPUT, "Apple Pack (���ͻ����)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�������ö����� ���ͧ�ҡ�س�ըӹǹ '%s' �����§��", "��ŧ", "¡��ԡ", count, itemname);

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
			return Dialog_Show(playerid, Sell_Turtle, DIALOG_STYLE_INPUT, "Turtle (���)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Turtle, DIALOG_STYLE_INPUT, "Turtle (���)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�ô�кبӹǹ '%s' �ҡ���� 0", "��ŧ", "¡��ԡ", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Turtle, DIALOG_STYLE_INPUT, "Turtle (���)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�������ö����� ���ͧ�ҡ�س�ըӹǹ '%s' �����§��", "��ŧ", "¡��ԡ", count, itemname);

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
			return Dialog_Show(playerid, Sell_Jellyfish, DIALOG_STYLE_INPUT, "Jellyfish (����о�ع)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Jellyfish, DIALOG_STYLE_INPUT, "Jellyfish (����о�ع)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�ô�кبӹǹ '%s' �ҡ���� 0", "��ŧ", "¡��ԡ", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Jellyfish, DIALOG_STYLE_INPUT, "Jellyfish (����о�ع)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�������ö����� ���ͧ�ҡ�س�ըӹǹ '%s' �����§��", "��ŧ", "¡��ԡ", count, itemname);

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
			return Dialog_Show(playerid, Sell_Starfish, DIALOG_STYLE_INPUT, "Starfish (��Ҵ��)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Starfish, DIALOG_STYLE_INPUT, "Starfish (��Ҵ��)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�ô�кبӹǹ '%s' �ҡ���� 0", "��ŧ", "¡��ԡ", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Starfish, DIALOG_STYLE_INPUT, "Starfish (��Ҵ��)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�������ö����� ���ͧ�ҡ�س�ըӹǹ '%s' �����§��", "��ŧ", "¡��ԡ", count, itemname);

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
			return Dialog_Show(playerid, Sell_Shell, DIALOG_STYLE_INPUT, "Shell (����ç)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Shell, DIALOG_STYLE_INPUT, "Shell (����ç)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�ô�кبӹǹ '%s' �ҡ���� 0", "��ŧ", "¡��ԡ", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Shell, DIALOG_STYLE_INPUT, "Shell (����ç)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�������ö����� ���ͧ�ҡ�س�ըӹǹ '%s' �����§��", "��ŧ", "¡��ԡ", count, itemname);

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
			return Dialog_Show(playerid, Sell_Fish, DIALOG_STYLE_INPUT, "Fish (��ҷ����)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Fish, DIALOG_STYLE_INPUT, "Fish (��ҷ����)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�ô�кبӹǹ '%s' �ҡ���� 0", "��ŧ", "¡��ԡ", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Fish, DIALOG_STYLE_INPUT, "Fish (��ҷ����)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�������ö����� ���ͧ�ҡ�س�ըӹǹ '%s' �����§��", "��ŧ", "¡��ԡ", count, itemname);

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
			return Dialog_Show(playerid, Sell_Iron, DIALOG_STYLE_INPUT, "Iron (����)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Iron, DIALOG_STYLE_INPUT, "Iron (����)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�ô�кبӹǹ '%s' �ҡ���� 0", "��ŧ", "¡��ԡ", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Iron, DIALOG_STYLE_INPUT, "Iron (����)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�������ö����� ���ͧ�ҡ�س�ըӹǹ '%s' �����§��", "��ŧ", "¡��ԡ", count, itemname);

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
			return Dialog_Show(playerid, Sell_Gold, DIALOG_STYLE_INPUT, "Gold (�ͧ)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Gold, DIALOG_STYLE_INPUT, "Gold (�ͧ)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�ô�кبӹǹ '%s' �ҡ���� 0", "��ŧ", "¡��ԡ", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Gold, DIALOG_STYLE_INPUT, "Gold (�ͧ)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�������ö����� ���ͧ�ҡ�س�ըӹǹ '%s' �����§��", "��ŧ", "¡��ԡ", count, itemname);

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
			return Dialog_Show(playerid, Sell_Diamon, DIALOG_STYLE_INPUT, "Diamon (ྪ�)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_Diamon, DIALOG_STYLE_INPUT, "Diamon (ྪ�)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�ô�кبӹǹ '%s' �ҡ���� 0", "��ŧ", "¡��ԡ", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_Diamon, DIALOG_STYLE_INPUT, "Diamon (ྪ�)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�������ö����� ���ͧ�ҡ�س�ըӹǹ '%s' �����§��", "��ŧ", "¡��ԡ", count, itemname);

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
			return Dialog_Show(playerid, Sell_WoodPacks, DIALOG_STYLE_INPUT, "WoodPacks (�����)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'", "��ŧ", "¡��ԡ", count);

        if (amount < 1)
			return Dialog_Show(playerid, Sell_WoodPacks, DIALOG_STYLE_INPUT, "WoodPacks (�����)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�ô�кبӹǹ '%s' �ҡ���� 0", "��ŧ", "¡��ԡ", count, itemname);

        if (amount > count)
			return Dialog_Show(playerid, Sell_WoodPacks, DIALOG_STYLE_INPUT, "WoodPacks (�����)", "�ô�кبӹǹ���س��ͧ��èТ��, �س������ӹǹ: '%d'\
			{FF6347}\n*�������ö����� ���ͧ�ҡ�س�ըӹǹ '%s' �����§��", "��ŧ", "¡��ԡ", count, itemname);

		new givemoney = amount * WoodPacksCash;
		format(string, sizeof(string), "~g~+%s Cash~n~~r~-%d %s", FormatMoney(givemoney), amount, itemname);
   		GameTextForPlayer(playerid, string, 5000, 1);
		GivePlayerMoneyEx(playerid, givemoney);

		Inventory_Remove(playerid, itemname, amount);
	}
	return 1;
}
































// --> �Ѵ�ѹ�Ѻ������
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
		    case 3: //��ѧ�Թ(Gang)
		    {

		    }
		    case 4: //��ѧ�Թ(Business)
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

// --> �Ѵ�ѹ�Ѻ
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
			format(string, sizeof(string), "�ѹ�Ѻ\t��ª���\t��������͹�Ź�\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "��������͹�Ź� (Hours)", string, "�Դ","");
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
			format(string, sizeof(string), "�ѹ�Ѻ\t��ª���\t�Թʴ\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "�Թʴ (Cash)", string, "�Դ","");
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
			format(string, sizeof(string), "�ѹ�Ѻ\t��ª���\t�Թ㹸�Ҥ��\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "�Թ㹸�Ҥ�� (Bank)", string, "�Դ","");
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
			format(string, sizeof(string), "�ѹ�Ѻ\t��ª��͸�áԨ\t��ѧ�Թ\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "��ѧ�Թ (Business)", string, "�Դ","");
		}
		case 6:
		{
		    for(new i = 0; i < rows; i ++)
		    {
			    cache_get_value_name(i, "playerName", name, 25);
			    cache_get_value_name_int(i, "playerTruck", amount);

				format(string, sizeof(string), "{04A90D}(%d)\t{FFFFFF}%s\t{F6E008}%s ����\n", i+1, name, FormatNumber(amount));
				strcat(string5, string);
			}
			format(string, sizeof(string), "�ѹ�Ѻ\t��ª���\t��â����Թ���\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "��â����Թ��� (Trucking)", string, "�Դ","");
		}
	}
	return 1;
}
