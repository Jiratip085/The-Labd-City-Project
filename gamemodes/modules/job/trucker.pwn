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

	        format(string, sizeof(string), "�س������ѧ����è����ʹ����Ҥ� $%d", ProductData[productid][productPrice]);
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

	        format(string, sizeof(string), "�س������ѧ����è�����ͧ���������Ҥ� $%d", ProductData[productid][productPrice]);
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
       			return SendClientMessage(playerid, -1, "�������ö����Թ��������ͧ�ҡ��Դ�Թ������ç�ѹ!");

			if(ProductData[productid][productAmount] == Product_MaxGrams(ProductData[productid][productType]))
  				return SendClientMessage(playerid, -1, "�Թ����ѹ����������!");

			ProductData[productid][productAmount] += 1;

			ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0);

			Character[playerid][LoadingPD] = 0;
			Character[playerid][CarryPD] = 0;
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			RemoveAttachedObject(playerid, 4);

			Character[playerid][Cash] += ProductData[productid][productPrice];
			GivePlayerMoney(playerid, ProductData[productid][productPrice]);

			format(string, sizeof(string), "�س�����ѧ����è����ʹ����Ҥ� $%d", ProductData[productid][productPrice]);
   			SendClientMessage(playerid, COLOR_WHITE, string);
		}
		case 2:
	    {
     		if(Character[playerid][CarryPD] != 2)
       			return SendClientMessage(playerid, -1, "�������ö����Թ��������ͧ�ҡ��Դ�Թ������ç�ѹ!");

			if(ProductData[productid][productAmount] == Product_MaxGrams(ProductData[productid][productType]))
  				return SendClientMessage(playerid, -1, "�Թ����ѹ����������!");

			ProductData[productid][productAmount] += 1;

			ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0);

			Character[playerid][LoadingPD] = 0;
			Character[playerid][CarryPD] = 0;
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			RemoveAttachedObject(playerid, 4);

			Character[playerid][Cash] += ProductData[productid][productPrice];
			GivePlayerMoney(playerid, ProductData[productid][productPrice]);

			format(string, sizeof(string), "�س�����ѧ����è�����ͧ���������Ҥ� $%d", ProductData[productid][productPrice]);
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
 			return SendClientMessage(playerid, COLOR_WHITE, "�س����ѧ�����������ö��Ժ�����!");

	if (response)
	{
		switch (listitem)
		{
		    case 0:
		    {
		        for (new i = 1; i != MAX_VEHICLES; i ++) if (IsPlayerNearBoot(playerid, i))
				{
					if(CoreVehicles[i][vehPDLoads1] < 1)
					    return SendClientMessage(playerid, COLOR_WHITE, "�ö�ѹ�������ա��ͧ '�����ѵ��'!");

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
					    return SendClientMessage(playerid, COLOR_WHITE, "�ö�ѹ�������ա��ͧ '����ͧ����'!");

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
   	Dialog_Show(playerid, Cargotrunk, DIALOG_STYLE_LIST, "Cargo Trunk", "[���ͧ�Թ��� '�����ѵ��' : %d]\n[���ͧ�Թ��� '����ͧ����' : %d]", "���͡", "¡��ԡ", CoreVehicles[carid][vehPDLoads1], CoreVehicles[carid][vehPDLoads2]);
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
	    return SendClientMessage(playerid, COLOR_GREY, "�س����� Trucker!");

	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
	    SendClientMessage(playerid, COLOR_GREY, "Available commands:");
	    SendClientMessage(playerid, COLOR_YELLOW, "/cargo list {FFFFFF}- �ʴ���¡���Թ��ҷ���è�������ҹ��˹з��Ŵ��͡��������");
	    SendClientMessage(playerid, COLOR_YELLOW, "/cargo place {FFFFFF}- �ҧ�ѧ�Թ��ҷ��������价���ҹ��˹�����");
	    SendClientMessage(playerid, COLOR_YELLOW, "/cargo putdown {FFFFFF}- �ҧ�ѧ�Թ��ҷ������ŧ���");
	    SendClientMessage(playerid, COLOR_YELLOW, "/cargo pickup {FFFFFF}- ��Ժ�ѧ�Թ��Ң���Ҩҡ���");
	    SendClientMessage(playerid, COLOR_YELLOW, "/cargo buy {FFFFFF}- �������س����ö�����Թ��Ҩҡ�ص��ˡ�����");
	    SendClientMessage(playerid, COLOR_YELLOW, "/cargo sell {FFFFFF}- ����Թ��ҡ�Ѻ�׹��ѧ�Թ���(�ش '/cargo buy')");
	    SendClientMessage(playerid, COLOR_YELLOW, "/cargo deliver {FFFFFF}- ����Թ������Ѻ�ص��ˡ��� / ���СԨ");
		return 1;
	}

	if (!strcmp(type, "buy", true))
	{
	    if (id == -1)
	    	return SendClientMessage(playerid, COLOR_GREY, "�س���������㹢ͺࢵ��ѧ�Թ�����");

        if (Character[playerid][LoadingPD] == 1)
 			return SendClientMessage(playerid, COLOR_WHITE, "�س����ѧ�����������ö�����ա��!");

	    if(ProductData[id][productAmount] <= 0)
	        return SendClientMessage(playerid, -1, "�Թ��Ҫ�Դ�����������������ö������");

		if(Character[playerid][Cash] < ProductData[id][productPrice])
			return SendClientMessage(playerid, -1, "�س���Թ���ͷ��Ы����Թ��ҹ��!");

		SetTimerEx("BuyProduct", 100, false, "dd", playerid, id);
		return 1;

	}
	if (!strcmp(type, "sell", true))
	{
	    if (id == -1)
	    	return SendClientMessage(playerid, COLOR_GREY, "�س���������㹢ͺࢵ��ѧ�Թ�����");

        if (Character[playerid][LoadingPD] == 0)
 			return SendClientMessage(playerid, COLOR_WHITE, "�س��������ѧ�����������!");

		SetTimerEx("SellProduct", 100, false, "dd", playerid, id);
		return 1;

	}
	if (!strcmp(type, "deliver", true))
	{
        new
	    	idpoint = ProductPoint_Nearest(playerid);

	    if (idpoint == -1)
	    	return SendClientMessage(playerid, COLOR_GREY, "�س����������ࢵ�����");

	    if (Character[playerid][LoadingPD] == 0)
			return SendClientMessage(playerid, COLOR_WHITE, "�س��������ѧ�����������!");

     	if(Character[playerid][CarryPD] == 1) //�����ѵ��
	    {
			if(Character[playerid][CarryPD] != 1)
				return SendClientMessage(playerid, -1, "�������ö����Թ��������ͧ�ҡ��Դ�Թ������ç�ѹ!");

			if(ProductData[idpoint][productAmount] == Product_MaxGrams(ProductData[idpoint][productType]))
				return SendClientMessage(playerid, -1, "�Թ����ѹ����������!");

			ProductData[idpoint][productPointAmount] += 1;

			ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0);

			Character[playerid][LoadingPD] = 0;
			Character[playerid][CarryPD] = 0;
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			RemoveAttachedObject(playerid, 4);

			Character[playerid][Cash] += ProductData[idpoint][productPointPrice];
			GivePlayerMoney(playerid, ProductData[idpoint][productPointPrice]);

			format(string, sizeof(string), "�س�����ѧ����è����ʹ����Ҥ� $%d", ProductData[idpoint][productPointPrice]);
			SendClientMessage(playerid, COLOR_WHITE, string);

			Product_Refresh(idpoint);
			Product_Save(idpoint);
		}

	    if(Character[playerid][CarryPD] == 2) //����ͧ����
	    {
			if(Character[playerid][CarryPD] != 2)
				return SendClientMessage(playerid, -1, "�������ö����Թ��������ͧ�ҡ��Դ�Թ������ç�ѹ!");

			if(ProductData[idpoint][productAmount] == Product_MaxGrams(ProductData[idpoint][productType]))
				return SendClientMessage(playerid, -1, "�Թ����ѹ����������!");

			ProductData[idpoint][productPointAmount] += 1;

			ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0);

			Character[playerid][LoadingPD] = 0;
			Character[playerid][CarryPD] = 0;
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			RemoveAttachedObject(playerid, 4);

			Character[playerid][Cash] += ProductData[idpoint][productPointPrice];
			GivePlayerMoney(playerid, ProductData[idpoint][productPointPrice]);

			format(string, sizeof(string), "�س�����ѧ����è�����ͧ���������Ҥ� $%d", ProductData[idpoint][productPointPrice]);
			SendClientMessage(playerid, COLOR_WHITE, string);

			Product_Refresh(idpoint);
			Product_Save(idpoint);
	    }
		return 1;
	}
	else if (!strcmp(type, "putdown", true))
	{
 		if (Character[playerid][LoadingPD] < 1)
 			return SendClientMessage(playerid, COLOR_WHITE, "�س������ѧ�Թ�����������!");

        if (idcrate == -1)
	    	return SendClientMessage(playerid, COLOR_WHITE, "�Կ������������ҧ�ѧ�Թ�մ�ӡѴ����");

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
 			return SendClientMessage(playerid, COLOR_WHITE, "�س����ѧ�����������ö�纫����!");

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
 			return SendClientMessage(playerid, COLOR_WHITE, "�س����ѧ�����������ö��Ժ�����!");

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
      			return SendClientMessage(playerid, COLOR_WHITE, "�س�������ö��è��ѧŧ���ҹ��˹Фѹ�����");

            if (CoreVehicles[i][vehLoadType] != 0 && CoreVehicles[i][vehLoadType] != Character[playerid][LoadType])
				return SendClientMessage(playerid, COLOR_WHITE, "�ҹ��˹Фѹ���١��è����úҧ���ҧ�����������");

			if (CoreVehicles[i][vehLoads] >= 6)
   				return SendClientMessage(playerid, COLOR_WHITE, "�ҹ��˹Фѹ�������ö��è�����§ 6 �ѧ");

            if (Character[playerid][LoadingPD] < 1)
	    		return SendClientMessage(playerid, COLOR_WHITE, "�س������ѧ�Թ�����������!");

			if(Character[playerid][CarryPD] == 1)
			{
	   			CoreVehicles[i][vehLoads]++;
	   			CoreVehicles[i][vehPDLoads1]++;
	   			CoreVehicles[i][vehLoadType] = Character[playerid][LoadType];

				ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0);
	   			//SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ��ʹ�ѧŧ���ѧö %s", ReturnName(playerid, 0), ReturnVehicleName(i));

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
	   			//SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ��ʹ�ѧŧ���ѧö %s", ReturnName(playerid, 0), ReturnVehicleName(i));

	            Character[playerid][LoadingPD] = 0;
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	 			RemoveAttachedObject(playerid, 4);
			}
		}
	}
	return 1;
}
