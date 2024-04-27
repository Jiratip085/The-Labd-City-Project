#include	<YSI_Coding\y_hooks>
#include 	<YSI_Coding\y_timers>


new const VehicleShopPickup[][] = { //18631
	{422, 141, 55000, 2, 4},
	{543, 152, 75000, 2, 4},
	{600, 152, 88000, 2, 4},
	{554, 145, 110000, 2, 4},
	{535, 160, 150000, 2, 4},
	{470, 158, 180000, 4, 4}
};

new const VehicleShopClassic[][] = {
	{467, 141, 50000, 4, 3},
	{466, 148, 55000, 4, 3},
	{474, 150, 57500, 2, 3},
	{549, 155, 64500, 2, 3},
	{576, 159, 70000, 2, 3},
	{575, 159, 75000, 2, 3},
	{542, 165, 77600, 2, 3},
	{533, 168, 84000, 2, 3},
	{439, 170, 96000, 2, 3},
	{412, 170, 99000, 2, 3},
	{534, 170, 105000, 2, 3},
	{475, 174, 112000, 2, 3},
	{536, 174, 118000, 2, 3},
	{576, 174, 120000, 2, 3},
	{567, 174, 125000, 4, 3}
};


ShowDealerVehiclePickUp(playerid)
{
	new str[1028];

	format(str, sizeof(str), "VehiclesShop (Pick up)"); // ������ҹ
	PlayerTextDrawSetString(playerid, ShopTD[playerid][2], str);

	if(ShopItemPage[playerid] == 0) //˹�ҷ�� 0
	{
		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], VehicleShopPickup[0][0]); // Model item 1
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopPickup[0][0])); // ���� item 1 
		PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], VehicleShopPickup[1][0]); // Model item 2
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopPickup[1][0])); // ���� item 2
		PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], VehicleShopPickup[2][0]); // Model item 3
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopPickup[2][0])); // ���� item 2
		PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

		format(str, sizeof(str), "%d / 2", ShopItemPage[playerid]+1); // ˹�� page
		PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
	}
	if(ShopItemPage[playerid] == 1) //˹�ҷ�� 1
	{
		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], VehicleShopPickup[3][0]); // Model item 1
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopPickup[3][0])); // ���� item 1 
		PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], VehicleShopPickup[4][0]); // Model item 2
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopPickup[4][0])); // ���� item 2
		PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], VehicleShopPickup[5][0]); // Model item 3
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopPickup[5][0])); // ���� item 2
		PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

		format(str, sizeof(str), "%d / 2", ShopItemPage[playerid]+1); // ˹�� page
		PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
	}
	return 1;
}

ShowDealerVehicleClassic(playerid)
{
	new str[1028];

	format(str, sizeof(str), "VehiclesShop (Classic)"); // ������ҹ
	PlayerTextDrawSetString(playerid, ShopTD[playerid][2], str);

	if(ShopItemPage[playerid] == 0) //˹�ҷ�� 0
	{
		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], VehicleShopClassic[0][0]); // Model item 1
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[0][0])); // ���� item 1 
		PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], VehicleShopClassic[1][0]); // Model item 2
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[1][0])); // ���� item 2
		PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], VehicleShopClassic[2][0]); // Model item 3
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[2][0])); // ���� item 2
		PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

		format(str, sizeof(str), "%d / 5", ShopItemPage[playerid]+1); // ˹�� page
		PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
	}
	if(ShopItemPage[playerid] == 1) //˹�ҷ�� 1
	{
		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], VehicleShopClassic[3][0]); // Model item 1
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[3][0])); // ���� item 1 
		PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], VehicleShopClassic[4][0]); // Model item 2
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[4][0])); // ���� item 2
		PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], VehicleShopClassic[5][0]); // Model item 3
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[5][0])); // ���� item 2
		PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

		format(str, sizeof(str), "%d / 5", ShopItemPage[playerid]+1); // ˹�� page
		PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
	}
	if(ShopItemPage[playerid] == 2) //˹�ҷ�� 2
	{
		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], VehicleShopClassic[6][0]); // Model item 1
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[6][0])); // ���� item 1 
		PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], VehicleShopClassic[7][0]); // Model item 2
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[7][0])); // ���� item 2
		PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], VehicleShopClassic[8][0]); // Model item 3
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[8][0])); // ���� item 2
		PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

		format(str, sizeof(str), "%d / 5", ShopItemPage[playerid]+1); // ˹�� page
		PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
	}
	if(ShopItemPage[playerid] == 3) //˹�ҷ�� 3
	{
		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], VehicleShopClassic[9][0]); // Model item 1
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[9][0])); // ���� item 1 
		PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], VehicleShopClassic[10][0]); // Model item 2
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[10][0])); // ���� item 2
		PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], VehicleShopClassic[11][0]); // Model item 3
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[11][0])); // ���� item 2
		PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

		format(str, sizeof(str), "%d / 5", ShopItemPage[playerid]+1); // ˹�� page
		PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
	}
	if(ShopItemPage[playerid] == 4) //˹�ҷ�� 4
	{
		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], VehicleShopClassic[12][0]); // Model item 1
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[12][0])); // ���� item 1 
		PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], VehicleShopClassic[13][0]); // Model item 2
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[13][0])); // ���� item 2
		PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

		PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], VehicleShopClassic[14][0]); // Model item 3
		format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[14][0])); // ���� item 2
		PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

		format(str, sizeof(str), "%d / 5", ShopItemPage[playerid]+1); // ˹�� page
		PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
	}
	return 1;
}


hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	new str[1056],
		shopid = Shop_Nearest(playerid),
		string[256];

	if (playertextid == ShopTD[playerid][8]) // Buy
	{
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		if(shopData[shopid][shopType] == 8) 
		{
			if(ShopItemPage[playerid] == 0)
			{
				if(ShopItemSelect[playerid] == 1)
				{
					new id = 0;
					if(GetPlayerMoney(playerid) < VehicleShopClassic[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopClassic[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopClassic[id][0]), FormatMoney(VehicleShopClassic[id][2]), VehicleShopClassic[id][3], VehicleShopClassic[id][4], VehicleShopClassic[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEClassic, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}
				if(ShopItemSelect[playerid] == 2)
				{
					new id = 1;
					if(GetPlayerMoney(playerid) < VehicleShopClassic[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopClassic[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopClassic[id][0]), FormatMoney(VehicleShopClassic[id][2]), VehicleShopClassic[id][3], VehicleShopClassic[id][4], VehicleShopClassic[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEClassic, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}
				if(ShopItemSelect[playerid] == 3)
				{
					new id = 2;
					if(GetPlayerMoney(playerid) < VehicleShopClassic[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopClassic[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopClassic[id][0]), FormatMoney(VehicleShopClassic[id][2]), VehicleShopClassic[id][3], VehicleShopClassic[id][4], VehicleShopClassic[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEClassic, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}	
			}
			if(ShopItemPage[playerid] == 1)
			{
				if(ShopItemSelect[playerid] == 1)
				{
					new id = 3;
					if(GetPlayerMoney(playerid) < VehicleShopClassic[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopClassic[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopClassic[id][0]), FormatMoney(VehicleShopClassic[id][2]), VehicleShopClassic[id][3], VehicleShopClassic[id][4], VehicleShopClassic[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEClassic, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}
				if(ShopItemSelect[playerid] == 2)
				{
					new id = 4;
					if(GetPlayerMoney(playerid) < VehicleShopClassic[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopClassic[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopClassic[id][0]), FormatMoney(VehicleShopClassic[id][2]), VehicleShopClassic[id][3], VehicleShopClassic[id][4], VehicleShopClassic[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEClassic, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}
				if(ShopItemSelect[playerid] == 3)
				{
					new id = 5;
					if(GetPlayerMoney(playerid) < VehicleShopClassic[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopClassic[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopClassic[id][0]), FormatMoney(VehicleShopClassic[id][2]), VehicleShopClassic[id][3], VehicleShopClassic[id][4], VehicleShopClassic[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEClassic, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}	
			}
			if(ShopItemPage[playerid] == 2)
			{
				if(ShopItemSelect[playerid] == 1)
				{
					new id = 6;
					if(GetPlayerMoney(playerid) < VehicleShopClassic[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopClassic[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopClassic[id][0]), FormatMoney(VehicleShopClassic[id][2]), VehicleShopClassic[id][3], VehicleShopClassic[id][4], VehicleShopClassic[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEClassic, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}
				if(ShopItemSelect[playerid] == 2)
				{
					new id = 7;
					if(GetPlayerMoney(playerid) < VehicleShopClassic[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopClassic[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopClassic[id][0]), FormatMoney(VehicleShopClassic[id][2]), VehicleShopClassic[id][3], VehicleShopClassic[id][4], VehicleShopClassic[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEClassic, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}
				if(ShopItemSelect[playerid] == 3)
				{
					new id = 8;
					if(GetPlayerMoney(playerid) < VehicleShopClassic[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopClassic[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopClassic[id][0]), FormatMoney(VehicleShopClassic[id][2]), VehicleShopClassic[id][3], VehicleShopClassic[id][4], VehicleShopClassic[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEClassic, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}	
			}
			if(ShopItemPage[playerid] == 3)
			{
				if(ShopItemSelect[playerid] == 1)
				{
					new id = 9;
					if(GetPlayerMoney(playerid) < VehicleShopClassic[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopClassic[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopClassic[id][0]), FormatMoney(VehicleShopClassic[id][2]), VehicleShopClassic[id][3], VehicleShopClassic[id][4], VehicleShopClassic[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEClassic, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}
				if(ShopItemSelect[playerid] == 2)
				{
					new id = 10;
					if(GetPlayerMoney(playerid) < VehicleShopClassic[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopClassic[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopClassic[id][0]), FormatMoney(VehicleShopClassic[id][2]), VehicleShopClassic[id][3], VehicleShopClassic[id][4], VehicleShopClassic[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEClassic, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}
				if(ShopItemSelect[playerid] == 3)
				{
					new id = 11;
					if(GetPlayerMoney(playerid) < VehicleShopClassic[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopClassic[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopClassic[id][0]), FormatMoney(VehicleShopClassic[id][2]), VehicleShopClassic[id][3], VehicleShopClassic[id][4], VehicleShopClassic[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEClassic, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}	
			}
			if(ShopItemPage[playerid] == 4)
			{
				if(ShopItemSelect[playerid] == 1)
				{
					new id = 12;
					if(GetPlayerMoney(playerid) < VehicleShopClassic[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopClassic[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopClassic[id][0]), FormatMoney(VehicleShopClassic[id][2]), VehicleShopClassic[id][3], VehicleShopClassic[id][4], VehicleShopClassic[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEClassic, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}
				if(ShopItemSelect[playerid] == 2)
				{
					new id = 13;
					if(GetPlayerMoney(playerid) < VehicleShopClassic[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopClassic[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopClassic[id][0]), FormatMoney(VehicleShopClassic[id][2]), VehicleShopClassic[id][3], VehicleShopClassic[id][4], VehicleShopClassic[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEClassic, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}
				if(ShopItemSelect[playerid] == 3)
				{
					new id = 14;
					if(GetPlayerMoney(playerid) < VehicleShopClassic[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopClassic[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopClassic[id][0]), FormatMoney(VehicleShopClassic[id][2]), VehicleShopClassic[id][3], VehicleShopClassic[id][4], VehicleShopClassic[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEClassic, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}	
			}
		}
		if(shopData[shopid][shopType] == 9) 
		{
			if(ShopItemPage[playerid] == 0)
			{
				if(ShopItemSelect[playerid] == 1)
				{
					new id = 0;
					if(GetPlayerMoney(playerid) < VehicleShopPickup[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopPickup[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopPickup[id][0]), FormatMoney(VehicleShopPickup[id][2]), VehicleShopPickup[id][3], VehicleShopPickup[id][4], VehicleShopPickup[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEPickUp, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}
				if(ShopItemSelect[playerid] == 2)
				{
					new id = 1;
					if(GetPlayerMoney(playerid) < VehicleShopPickup[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopPickup[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopPickup[id][0]), FormatMoney(VehicleShopPickup[id][2]), VehicleShopPickup[id][3], VehicleShopPickup[id][4], VehicleShopPickup[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEPickUp, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}
				if(ShopItemSelect[playerid] == 3)
				{
					new id = 2;
					if(GetPlayerMoney(playerid) < VehicleShopPickup[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopPickup[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopPickup[id][0]), FormatMoney(VehicleShopPickup[id][2]), VehicleShopPickup[id][3], VehicleShopPickup[id][4], VehicleShopPickup[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEPickUp, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}	
			}
			if(ShopItemPage[playerid] == 1)
			{
				if(ShopItemSelect[playerid] == 1)
				{
					new id = 3;
					if(GetPlayerMoney(playerid) < VehicleShopPickup[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopPickup[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopPickup[id][0]), FormatMoney(VehicleShopPickup[id][2]), VehicleShopPickup[id][3], VehicleShopPickup[id][4], VehicleShopPickup[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEPickUp, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}
				if(ShopItemSelect[playerid] == 2)
				{
					new id = 4;
					if(GetPlayerMoney(playerid) < VehicleShopPickup[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopPickup[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopPickup[id][0]), FormatMoney(VehicleShopPickup[id][2]), VehicleShopPickup[id][3], VehicleShopPickup[id][4], VehicleShopPickup[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEPickUp, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}
				if(ShopItemSelect[playerid] == 3)
				{
					new id = 5;
					if(GetPlayerMoney(playerid) < VehicleShopPickup[id][2])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[VehiclesShop]: �������ö���� '%s' �����ͧ�ӹǹ�Թ�ͧ�س��������§��", ReturnVehicleModelName(VehicleShopPickup[id][0])); 

					HideShopEquipmentTD(playerid);
					playerData[playerid][pSelectedSlot] = id;
					format(string, sizeof(string), "�ҹ��˹�: %s\n�Ҥ�: %s\n�����: %d\n��鹷���红ͧ: %d ��ͧ\n���������٧�ش: %d ��������/�������", ReturnVehicleModelName(VehicleShopPickup[id][0]), FormatMoney(VehicleShopPickup[id][2]), VehicleShopPickup[id][3], VehicleShopPickup[id][4], VehicleShopPickup[id][1]); 
					Dialog_Show(playerid, DIALOG_BUYVEHICLEPickUp, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
					return 1;
				}	
			}
		}
	}


	
	if (playertextid == ShopTD[playerid][3]) // Select item 1
	{ 
		if(shopData[shopid][shopType] == 8) 
		{
			if(ShopItemPage[playerid] == 0)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[0][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopClassic[0][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopClassic[0][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopClassic[0][1], VehicleShopClassic[0][3], VehicleShopClassic[0][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 1)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[3][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopClassic[3][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopClassic[3][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopClassic[3][1], VehicleShopClassic[3][3], VehicleShopClassic[3][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 2)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[6][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopClassic[6][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopClassic[6][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopClassic[6][1], VehicleShopClassic[6][3], VehicleShopClassic[6][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 3)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[9][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopClassic[9][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopClassic[9][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopClassic[9][1], VehicleShopClassic[9][3], VehicleShopClassic[9][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 4)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[12][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopClassic[12][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopClassic[12][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopClassic[12][1], VehicleShopClassic[12][3], VehicleShopClassic[12][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}
		if(shopData[shopid][shopType] == 9) 
		{
			if(ShopItemPage[playerid] == 0)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopPickup[0][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopPickup[0][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopPickup[0][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopPickup[0][1], VehicleShopPickup[0][3], VehicleShopPickup[0][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 1)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopPickup[3][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopPickup[3][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopPickup[3][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopPickup[3][1], VehicleShopPickup[3][3], VehicleShopPickup[3][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}
	}
	if (playertextid == ShopTD[playerid][4]) // Select item 2
	{
		if(shopData[shopid][shopType] == 8)
		{
			if(ShopItemPage[playerid] == 0)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[1][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopClassic[1][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopClassic[1][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopClassic[1][1], VehicleShopClassic[1][3], VehicleShopClassic[1][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 1)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[4][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopClassic[4][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopClassic[4][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopClassic[4][1], VehicleShopClassic[4][3], VehicleShopClassic[4][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 2)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[7][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopClassic[7][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopClassic[7][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopClassic[7][1], VehicleShopClassic[7][3], VehicleShopClassic[7][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 3)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[10][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopClassic[10][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopClassic[10][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopClassic[10][1], VehicleShopClassic[10][3], VehicleShopClassic[10][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 4)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[13][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopClassic[13][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopClassic[13][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopClassic[13][1], VehicleShopClassic[13][3], VehicleShopClassic[13][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}
		if(shopData[shopid][shopType] == 9)
		{
			if(ShopItemPage[playerid] == 0)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopPickup[1][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopPickup[1][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopPickup[1][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopPickup[1][1], VehicleShopPickup[1][3], VehicleShopPickup[1][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 1)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopPickup[4][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopPickup[4][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopPickup[4][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopPickup[4][1], VehicleShopPickup[4][3], VehicleShopPickup[4][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}
	}
	if (playertextid == ShopTD[playerid][5]) // Select item 3
	{
		if(shopData[shopid][shopType] == 8)
		{
			if(ShopItemPage[playerid] == 0)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[2][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopClassic[2][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopClassic[2][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopClassic[2][1], VehicleShopClassic[2][3], VehicleShopClassic[2][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 1)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[5][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopClassic[5][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopClassic[5][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopClassic[5][1], VehicleShopClassic[5][3], VehicleShopClassic[0][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 2)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[8][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopClassic[8][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopClassic[8][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopClassic[8][1], VehicleShopClassic[8][3], VehicleShopClassic[8][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 3)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[11][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopClassic[11][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopClassic[11][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopClassic[11][1], VehicleShopClassic[11][3], VehicleShopClassic[11][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 4)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopClassic[14][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopClassic[14][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopClassic[14][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopClassic[14][1], VehicleShopClassic[14][3], VehicleShopClassic[14][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}
		if(shopData[shopid][shopType] == 9)
		{
			if(ShopItemPage[playerid] == 0)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopPickup[2][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopPickup[2][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopPickup[2][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopPickup[2][1], VehicleShopPickup[2][3], VehicleShopPickup[2][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 1)
			{
				format(str, sizeof(str), "%s", ReturnVehicleModelName(VehicleShopPickup[5][0])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~%s", FormatMoney(VehicleShopPickup[5][2])); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], VehicleShopPickup[5][0]);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);

				format(str, sizeof(str), "~g~Max Speed: %d Km/h~n~~y~Occupant: %d~n~~b~~h~Trunk: %d", VehicleShopPickup[5][1], VehicleShopPickup[5][3], VehicleShopPickup[5][4]); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}
	}
	return 1;
}
Dialog:DIALOG_BUYVEHICLEPickUp(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "SELECT COUNT(*) FROM vehicles WHERE carOwnerID = %d", playerData[playerid][pID]);
		mysql_tquery(g_SQL, query, "OnPlayerBuyVehiclePickUp", "ii", playerid, playerData[playerid][pSelectedSlot]);
  
	}
	return 1;
}
Dialog:DIALOG_BUYVEHICLEClassic(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "SELECT COUNT(*) FROM vehicles WHERE carOwnerID = %d", playerData[playerid][pID]);
		mysql_tquery(g_SQL, query, "OnPlayerBuyVehicleClassic", "ii", playerid, playerData[playerid][pSelectedSlot]);
  
	}
	return 1;
}

forward OnPlayerBuyVehicleClassic(playerid, index);
public OnPlayerBuyVehicleClassic(playerid, index)
{
	new count, id = playerData[playerid][pSelectedSlot];

	cache_get_value_index_int(0, 0, count);

	new query[1080];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carFuel, carPosX, carPosY, carPosZ, carPosA, carTrunk, carTrunkQuantity) VALUES(%d, '%s', %d, %.1f, '557.8670', '-1283.9822', '17.0007', '0.0000', %d, 50)", playerData[playerid][pID], GetPlayerNameEx(playerid), VehicleShopClassic[id][0], vehicleData[VehicleShopClassic[id][0] - 400][vFuel], VehicleShopClassic[id][4]);
	mysql_tquery(g_SQL, query);

	GivePlayerMoneyEx(playerid, -VehicleShopClassic[id][2]);
    SendClientMessageEx(playerid, COLOR_GREEN, "[VehiclesShop]: �س�����ö��� '%s' ��Ҥ� '%s' ��������º����", ReturnVehicleModelName(VehicleShopClassic[id][0]), FormatMoney(VehicleShopClassic[id][2]));
    return 1;
}
forward OnPlayerBuyVehiclePickUp(playerid, index);
public OnPlayerBuyVehiclePickUp(playerid, index)
{
	new count, id = playerData[playerid][pSelectedSlot];

	cache_get_value_index_int(0, 0, count);

	new query[1080];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carFuel, carPosX, carPosY, carPosZ, carPosA, carTrunk, carTrunkQuantity) VALUES(%d, '%s', %d, %.1f, '557.8670', '-1283.9822', '17.0007', '0.0000', %d, 50)", playerData[playerid][pID], GetPlayerNameEx(playerid), VehicleShopPickup[id][0], vehicleData[VehicleShopPickup[id][0] - 400][vFuel], VehicleShopPickup[id][4]);
	mysql_tquery(g_SQL, query);

	GivePlayerMoneyEx(playerid, -VehicleShopPickup[id][2]);
    SendClientMessageEx(playerid, COLOR_GREEN, "[VehiclesShop]: �س�����ö��� '%s' ��Ҥ� '%s' ��������º����", ReturnVehicleModelName(VehicleShopPickup[id][0]), FormatMoney(VehicleShopPickup[id][2]));
    return 1;
}





































/*

new carshop[MAX_PLAYERS];


enum carEnum
{
	carModel,
	carPrice
};
new const vehicleArray[][carEnum] = //�ʹբ��ö
{
	{467, 0000},
	{466, 55000},
	{474, 57500},
	{549, 64500},
	{576, 70000},
	{542, 77000},
	{533, 84000},
	{475, 96000},
	{536, 102000}
};
hook OnPlayerConnect(playerid)
{
	playerData[playerid][pSelectVeh] = 0;
	return 1;
}
hook OnGameModeInit()
{

}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_NO && playerData[playerid][pSelectVeh] == 1)
		return SelectTextDraw(playerid, COLOR_WHITE);
		
	if (newkeys & KEY_YES)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2095.8362,-1359.5184,23.9844)) ////buy car
		{
			new count;
			cache_get_value_index_int(0, 0, count);

        	if(count >= GetPlayerAssetLimit(playerid, LIMIT_VEHICLES))
            {
                SendClientMessageEx(playerid, COLOR_LIGHTRED, "- ��ѧ�ҹ��˹Тͧ�س����ӹǹ���� %d/%d �������ö�����������ա", count, GetPlayerAssetLimit(playerid, LIMIT_VEHICLES));
                return 1;
            }
			if(playerData[playerid][pSelectVeh] == 1)
				return 0;

            carshop[playerid] = 0;
			playerData[playerid][pSelectTD] = 1;
			ShowMenuSelectTD(playerid);

            TogglePlayerControllable(playerid, 0);
            SetPlayerVirtualWorld(playerid, playerid);

            if(GetPlayerVirtualWorld(playerid) == 0)
            {
                SetPlayerVirtualWorld(playerid, 1000);
            }

            playerData[playerid][pBuyVeh] = CreateVehicle(vehicleArray[carshop[playerid]][carModel],2101.7739,-1367.4547,23.7262,226.8269, 1, 1, 0);

            SetVehicleVirtualWorld(playerData[playerid][pBuyVeh], GetPlayerVirtualWorld(playerid));
            LinkVehicleToInterior(playerData[playerid][pBuyVeh], GetPlayerInterior(playerid));

            SetPlayerCameraLookAt(playerid, 2101.7739,-1367.4547,23.7262, CAMERA_MOVE);
            SetPlayerCameraPos(playerid, 2101.8154,-1373.1586,25.0844);

            playerData[playerid][pSelectVeh] = 1;

            new skinq[1024];

            format(skinq, sizeof(skinq), "%s", FormatMoney(vehicleArray[carshop[playerid]][carPrice]));
            PlayerTextDrawSetString(playerid, SelectTD[playerid][5], skinq);
			SendClientMessageEx(playerid, COLOR_YELLOW, "[Station Wagon Shop] ����ö�� 'N' �ա���������Դ������͡�ҹ��˹�");
			return 1;
		}
	}
    return 1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if (playerData[playerid][pSelectTD] == 1)
	{
		if (playertextid == SelectTD[playerid][3]) // <<
		{
			if(playerData[playerid][pSelectVeh] == 1)
			{  
				new skinq[1024];

				carshop[playerid] -= 1;
		
				if(carshop[playerid] == -1)
				{
					carshop[playerid] = carcount;
					playerData[playerid][pBuyVeh] = CreateVehicle(vehicleArray[carshop[playerid]][carModel],2101.7739,-1367.4547,23.7262,226.8269, 1, 1, 0);
					SetVehicleVirtualWorld(playerData[playerid][pBuyVeh], GetPlayerVirtualWorld(playerid));
					LinkVehicleToInterior(playerData[playerid][pBuyVeh], GetPlayerInterior(playerid));
				}

				DestroyVehicle(playerData[playerid][pBuyVeh]);

				format(skinq, sizeof(skinq), "%s", FormatMoney(vehicleArray[carshop[playerid]][carPrice]));
				PlayerTextDrawSetString(playerid, SelectTD[playerid][5], skinq);

				playerData[playerid][pBuyVeh] = CreateVehicle(vehicleArray[carshop[playerid]][carModel],2101.7739,-1367.4547,23.7262,226.8269, 1, 1, 0);
				SetVehicleVirtualWorld(playerData[playerid][pBuyVeh], GetPlayerVirtualWorld(playerid));
				LinkVehicleToInterior(playerData[playerid][pBuyVeh], GetPlayerInterior(playerid));
			}
		}
		if (playertextid == SelectTD[playerid][4]) // >>
		{
			if(playerData[playerid][pSelectVeh] == 1)
			{       
				new skinq[1024];

				carshop[playerid] += 1;

				if(carshop[playerid] == carcount)
				{
					DestroyVehicle(playerData[playerid][pBuyVeh]);
					carshop[playerid] = 0;
					playerData[playerid][pBuyVeh] = CreateVehicle(vehicleArray[carshop[playerid]][carModel],2101.7739,-1367.4547,23.7262,226.8269, 1, 1, 0);
					SetVehicleVirtualWorld(playerData[playerid][pBuyVeh], GetPlayerVirtualWorld(playerid));
					LinkVehicleToInterior(playerData[playerid][pBuyVeh], GetPlayerInterior(playerid));
				}

				DestroyVehicle(playerData[playerid][pBuyVeh]);

				format(skinq, sizeof(skinq), "%s", FormatMoney(vehicleArray[carshop[playerid]][carPrice]));
				PlayerTextDrawSetString(playerid, SelectTD[playerid][5], skinq);
				
				playerData[playerid][pBuyVeh] = CreateVehicle(vehicleArray[carshop[playerid]][carModel],2101.7739,-1367.4547,23.7262,226.8269, 1, 1, 0);
				SetVehicleVirtualWorld(playerData[playerid][pBuyVeh], GetPlayerVirtualWorld(playerid));
				LinkVehicleToInterior(playerData[playerid][pBuyVeh], GetPlayerInterior(playerid));
			}
		}
		if (playertextid == SelectTD[playerid][1]) // Buy
		{
			if(playerData[playerid][pSelectVeh] == 1)
			{
				
				if(GetPlayerMoneyEx(playerid) < vehicleArray[carshop[playerid]][carPrice])
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "- �������ö�����ҹ��˹� '%s' �����ͧ�ҡ�Թ�ͧ�س�����§�� (( %s/%s))", 
					g_arrVehicleNames[vehicleArray[carshop[playerid]][carModel] - 400], FormatMoney(GetPlayerMoney(playerid)), 
					FormatMoney(vehicleArray[carshop[playerid]][carPrice]));

				new
					string[256];

				playerData[playerid][pSelectedSlot] = vehicleArray[carshop[playerid]][carModel];

				CancelBuyVeh(playerid);
				format(string, sizeof(string), "{FFFFFF}�׹�ѹ��ë���:\n�س��ͧ��÷��Ы���ö��� {00AA00}%s{FFFFFF} ��Ҥ� {00AA00}%s{FFFFFF}?", g_arrVehicleNames[vehicleArray[carshop[playerid]][carModel] - 400], FormatMoney(vehicleArray[carshop[playerid]][carPrice]));
				Dialog_Show(playerid, DIALOG_BUYVEHICLEClassic, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ë���]", string, "�׹�ѹ", "¡��ԡ");   
			}
		}
		if (playertextid == SelectTD[playerid][2]) // ¡��ԡ
		{
			
			if(playerData[playerid][pSelectVeh] == 1)
			{
				
				CancelBuyVeh(playerid);   
			}
		}
	}
    return 1;
}

*/
/*
alias:buycar("���ͧ͢")
CMD:buycar(playerid, params[])
{
	static string[4096];

	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 542.0433, -1293.5909, 17.2422))
	{
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س�������������ҹ���ö");
	}
	if(GetSpawnedVehicles(playerid) >= MAX_SPAWNED_VEHICLES)
    {
        return SendClientMessageEx(playerid, COLOR_GREY, "[�к�] {FFFFFF}ö�ͧ�س�ʹ�ú %d �ѹ���� ��س��纤ѹ㴤ѹ�֧", MAX_SPAWNED_VEHICLES);
    }


	Dialog_Show(playerid, DIALOG_BUYVEHICLE, DIALOG_STYLE_TABLIST_HEADERS, "[��ҹ���ö]", string, "����", "¡��ԡ");
	return 1;
}


alias:engine("ʵ���ö")
CMD:en(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    new Float:vehiclehealth;
    GetVehicleHealth(vehicleid, vehiclehealth);

	if (!IsEngineVehicle(vehicleid))
		return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�ҹ��˹Фѹ������������ͧ¹��");

	if (vehiclehealth <= 350)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�ҹ��˹Фѹ����դ�����������ҡ�Թ� �������öʵ�����");

	if (vehicleFuel[vehicleid] <= 0)
		return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}ö�ѹ�������չ���ѹ���");

	if (dealerData[vehicleid][carShop] == 1)
		return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�ҹ��˹�����Ѻ�����ҹ��!");

	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
		switch (GetEngineStatus(vehicleid))
		{
		    case false:
		    {
			    SetEngineStatus(vehicleid, true);
		        SendClientMessage(playerid, COLOR_WHITE, "�س��Դ�ح�����{00FF00}ʵ���{FFFFFF}����ͧ¹��");
			}
			case true:
			{
			    SetEngineStatus(vehicleid, false);
		        SendClientMessage(playerid, COLOR_WHITE, "�س��Դ�ح�����{FF0000}�Ѻ{FFFFFF}����ͧ¹��");
			}
		}
	}
	return 1;
}
