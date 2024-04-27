
new isFixPlayer[MAX_PLAYERS];

hook OnPlayerConnect(playerid) 
{
    isFixPlayer[playerid] = 0;
}

alias:rpt("��Ѥ")
CMD:rpt(playerid, params[])
{
	if (playerData[playerid][pPrisoned] > 0)
 		return ErrorMsg(playerid, "�س�Դ�ء�����������ö��ҹ�������");

	if (playerData[playerid][pJailTime] > 0)
 		return ErrorMsg(playerid, "�س�Դ�ء�����������ö��ҹ�������");

	if (GetPlayerWantedLevelEx(playerid) > 0)
		return ErrorMsg(playerid, "�������ö���������ҡ�س�դ�յԴ���!");

	if (isFixPlayer[playerid] == 1)
		return ErrorMsg(playerid, "�س���������ҧ�����Ѥ����Ф�!");

	isFixPlayer[playerid] = 1;
	StartProgress(playerid, 400, 0, INVALID_OBJECT_ID);
	TogglePlayerControllable(playerid, false);
    SendClientMessage(playerid, COLOR_WHITE, "{E30E03}[!] {FAEB09}��س����ѡ���� �к����ѧ�ӡ����Ѥ���Ѻ����Фâͧ��ҹ!");
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

    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{FD7009}PlayerFixCharacter | {FDEB09}��Ѥ����Ф�", "{F30703}[!] {ffffff}����Фâͧ�س�١��Ѥ����觡�Ѻ�ش�Դ����������!", "��ŧ", "");
}

alias:pay("����Թ")
CMD:pay(playerid, params[])
{
	static
	    userid,
	    amount;

	if (sscanf(params, "ud", userid, amount))
	    return SendClientMessage(playerid, COLOR_WHITE, "/pay [�ʹ�/����] [�ӹǹ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ʹչ��������������");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ʹչ����������������");

	if (userid == playerid)
		return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ö����Թ����ͧ��");

	if (amount < 1 || amount > 10000)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�ӹǹ�Թ��ͧ����ӡ��� $1 �������Թ $10,000 ��ҹ��");

	if (playerData[playerid][pHours] < 1)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س���繵�ͧ�ժ�������������ҡ���� 1 ����");

	if (amount > GetPlayerMoneyEx(playerid))
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�Թ�ͧ�س�����§��㹡�����");

	static
	    string[72];

	GivePlayerMoneyEx(playerid, -amount);
	GivePlayerMoneyEx(userid, amount);

	format(string, sizeof(string), "You have received ~g~%s~w~ from %s.", FormatMoney(amount), GetPlayerNameEx(playerid));
	GameTextForPlayer(userid, string, 5000, 1);

	format(string, sizeof(string), "You have given ~r~%s~w~ to %s.", FormatMoney(amount), GetPlayerNameEx(userid));
	GameTextForPlayer(playerid, string, 5000, 1);

	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ����Ժ�Թ�ӹǹ %s �ҡ��������������� %s", GetPlayerNameEx(playerid), FormatMoney(amount), GetPlayerNameEx(userid));
	return 1;
}

alias:vip("����Թ")
CMD:vip(playerid, params[])
{
	new count;
	if (sscanf(params, "d", count))
	    return SendClientMessage(playerid, COLOR_WHITE, "/����Թ [�дѺ 1-3]");

	if (count < 1 || count > 3)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�дѺ VIP ���� 1-3 ��ҹ��");

	switch(count)
	{
	    case 1:
	    {
		    SendClientMessage(playerid, COLOR_PINK, "|======[�س���ѵԢͧ VIP ]======|");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}����ö��ö��ǹ����� 2 �ѹ");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}������ /ooc ���� #VIP ��˹��");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}���Ѻ��һ��ʺ��ó�������� +1 �ء�������");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}���Ѻ�Թ��ͪ������ +$350");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}���������آͧ�������� 12 ��ͧ");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}�Ҥ� 100 : ����");
		}
	    case 2:
	    {
		    SendClientMessage(playerid, COLOR_PINK, "|======[�س���ѵԢͧ #{00FFFF}PR{FFFFFF}EMI{00FFFF}UM ]======|");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}����ö��ö��ǹ����� 3 �ѹ");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}������ /ooc ���� #VIP ��˹��");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}������ /vipr ����ö");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}���Ѻ��һ��ʺ��ó�������� +1 �ء�������");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}���Ѻ�Թ��ͪ������ +$500");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}���������آͧ�������� 14 ��ͧ");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}�Ҥ� 150 : ����");
		}
	    case 3:
	    {
		    SendClientMessage(playerid, COLOR_PINK, "|======[�س���ѵԢͧ #{FF0000}SU{FFFFFF}PER{FF0000}ME ]======|");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}����ö��ö��ǹ����� 4 �ѹ");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}������ /ooc ���� #VIP ��˹��");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}������ /vipr �������ѹ + ����ö");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}���Ѻ��һ��ʺ��ó�������� +1 �ء�������");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}���Ѻ�Թ��ͪ������ +$750");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}���������آͧ�������� 16 ��ͧ");
		    SendClientMessage(playerid, COLOR_YELLOW, "+ {FFFFFF}�Ҥ� 200 : ����");
		}
    }
	return 1;
}

    	//��ҿ���ظ
        if (IsPlayerInRangeOfPoint(playerid, 2.0, 1157.8938,-1770.2036,16.5938))
        {
			new string100[4096];
			new string2[4096];

			format(string100, sizeof(string100), "{FFFFFF}[���ظ]\t{35C005}[{6BF939}�͡�������{35C005}]\n");
			strcat(string2,string100);

			format(string100, sizeof(string100), "{FFFFFF}ʹѺ���\t{16D603}[10 {FFFFFF}�����繵�{16D603}]\n");
			strcat(string2,string100);

			format(string100, sizeof(string100), "{FFFFFF}�մ���\t{16D603}[10 {FFFFFF}�����繵�{16D603}]\n");
			strcat(string2,string100);

			format(string100, sizeof(string100), "{FFFFFF}���ʹ��\t{16D603}[10 {FFFFFF}�����繵�{16D603}]\n");
			strcat(string2,string100);

			format(string100, sizeof(string100), "{FFFFFF}������\t{16D603}[10 {FFFFFF}�����繵�{16D603}]\n");
			strcat(string2,string100);

			format(string100, sizeof(string100), "{FFFFFF}����ʺ��\t{16D603}[10 {FFFFFF}�����繵�{16D603}]\n");
			strcat(string2,string100);

			format(string100, sizeof(string100), "{FFFFFF}�����\t{16D603}[10 {FFFFFF}�����繵�{16D603}]\n");
			strcat(string2,string100);

			Dialog_Show(playerid,DIALOG_CRAFT,DIALOG_STYLE_TABLIST_HEADERS,"{FFFFFF}[{16D603}���ҧ���ظ{FFFFFF}]",string2,"��ŧ","¡��ԡ");
			return 1;
        }

    	// ��ҿ�Ҫһͧ
        if (IsPlayerInRangeOfPoint(playerid, 2.0, 1153.0934,-1770.6306,16.5992))
        {
			return Dialog_Show(playerid,DIALOG_CRAFT_GACHA,DIALOG_STYLE_MSGBOX,"{FFFFFF}[{16D603}�Ҫһͧ��¿��{FFFFFF}]", "{3CD606}��觢ͧ > �Ҫһͧ��¿��\n\n{FFFFFF}-�������䷵� 50 �ѹ\n- �Թᴧ $1,000\n- �Թ���� $1,000\n\n{6BF939}�͡������� : 50%", "��ŧ", "¡��ԡ");
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
				Dialog_Show(playerid, DIALOG_BUY_CLOTHING, DIALOG_STYLE_TABLIST, "{FFFFFF}[{03BB0C}��ҹ��¢ͧ�觵��{FFFFFF}]", str, "��ŧ", "¡��ԡ");

				return 1;
			}
			case 1:
			{
				cl_buying[playerid]=BUYSPORTS;

				new str[4096];

				for(new i=0;i!=sizeof(cl_SportsData);++i) format(str, 4096, "%s %d.%s\t{FDEC1C}%d {FFFFFF}Coin"EMBED_WHITE"\n", str, i, cl_SportsData[i][e_name], cl_SportsData[i][e_price]);
				Dialog_Show(playerid, DIALOG_BUY_CLOTHING, DIALOG_STYLE_TABLIST, "{FFFFFF}[{03BB0C}��ҹ��¢ͧ�觵��{FFFFFF}]", str, "Ok", "Cancel");
				return 1;
			}
		}
	}
	return 1;
}

// �к��觵��
Dialog:DIALOG_BUY_CLOTHING(playerid, response, listitem, inputtext[])
{
	if (response) {

		switch(cl_buying[playerid])
		{
		    case BUYSPORTS:
		    {
				if (playerData[playerid][pCoin] < cl_SportsData[listitem][e_price])
				    return SendClientMessage(playerid, COLOR_LIGHTRED, "* �س�� Coin �����§��");

		        //GivePlayerMoneyEx(playerid, -cl_SportsData[listitem][e_price]);
		        playerData[playerid][pCoin] -= cl_SportsData[listitem][e_price];

		        Inventory_Add(playerid, cl_SportsData[listitem][e_name], 1);
				SendClientMessageEx(playerid, COLOR_YELLOW, "�س���Ѻ %s ���º��������", cl_SportsData[listitem][e_name]);
		    }

		    case BUYZIP:
		    {
				if (GetPlayerMoneyEx(playerid) < cl_ZipData[listitem][e_price])
				    return SendClientMessage(playerid, COLOR_LIGHTRED, "* �س���Թ�����§��");

		        GivePlayerMoneyEx(playerid, -cl_ZipData[listitem][e_price]);

		        Inventory_Add(playerid, cl_ZipData[listitem][e_name], 1);
				SendClientMessageEx(playerid, COLOR_YELLOW, "�س���Ѻ %s ���º��������", cl_ZipData[listitem][e_name]);
		    }
		}
		cl_buying[playerid]=0;
	}
	return 1;
}

alias:todsuit("�ʹ�ش")
CMD:todsuit(playerid)
{
	RemovePlayerAttachedObject(playerid, 3);
	SendClientMessage(playerid, COLOR_LIGHTRED, "* �س��ʹ����ͧ�觡�¢ͧ�س����!");

	return 1;
}

alias:carhelp("�����ö")
CMD:carhelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_GREEN, "|======[ö��ǹ���]======|");
    SendClientMessage(playerid, COLOR_WHITE, "/���¡á ,/��ö,/�ش�ʹö");
    SendClientMessage(playerid, COLOR_WHITE, "/ʵ���ö,/��ͤö, /�ʹö,/����ö,/���ö");
	return 1;
}

alias:findcar("�ش�ʹö")
CMD:findcar(playerid, params[])
{
    new string[MAX_SPAWNED_VEHICLES * 64], count;

 	string = "#\t�������";

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
	    SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س�����ö�ʹ�����������������");
	}
	else
	{
	    Dialog_Show(playerid, DIALOG_FINDCAR, DIALOG_STYLE_TABLIST_HEADERS, "[���͡ö����ͧ��è���]", string, "��", "�Դ");
	}

	return 1;
}

alias:upgradevehicle("�Ѿö")
CMD:upgradevehicle(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid), option[8], param[32];

	if(!vehicleid || !IsVehicleOwner(playerid, vehicleid))
	{
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س��ͧ�����ö��ǹ��Ǣͧ�س");
	}
	if(!IsPlayerInRangeOfPoint(playerid, 8.0, 542.0433, -1293.5909, 17.2422))
	{
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س�������������ҹ���ö");
	}
	if(sscanf(params, "s[8]S()[32]", option, param))
	{
	    return SendClientMessage(playerid, COLOR_WHITE, "/�Ѿö [��ͧ���Թ | ���·���¹]");
	}

	if(!strcmp(option, "1", true))
	{
	    if(isnull(param) || strcmp(param, "�׹�ѹ", true) != 0)
	    {
	        SendClientMessage(playerid, COLOR_WHITE, "/�Ѿö [1] [�׹�ѹ]");
	        SendClientMessageEx(playerid, COLOR_GREY3, "��ͧ�红ͧ����ŻѨ�غѹ %d/3 ����Ѿ�ô�Ҥ� $10,000", carData[vehicleid][carTrunk]);
	        return 1;
		}
		if(carData[vehicleid][carTrunk] >= 3)
		{
		    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}����Ū�ͧ�红ͧ������� 3/3");
		}
		if(GetPlayerMoneyEx(playerid) < 10000)
		{
		    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س���Թ�����§�� $10,000");
		}

		carData[vehicleid][carTrunk]++;

		GivePlayerMoneyEx(playerid, -10000);
		GameTextForPlayer(playerid, "~r~-$10000", 5000, 1);
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carTrunk = %d WHERE carID = %d", carData[vehicleid][carTrunk], carData[vehicleid][carID]);
		mysql_tquery(g_SQL, query);

		SendClientMessageEx(playerid, COLOR_GREEN, "�س���Ѿ�ô��ͧ�红ͧ������� %d/3 ��Ҥ� $10,000 '/�红ͧ�ö ��' 㹡�ô٪�ͧ�红ͧ", carData[vehicleid][carTrunk]);
	}
	else if(!strcmp(option, "2", true))
	{
	    if(isnull(param))
	    {
	        return SendClientMessage(playerid, COLOR_WHITE, "/�Ѿö [2] [�Ţ����] (�Ҥ� $20,000)");
	    }
	    if(!IsEngineVehicle(vehicleid))
	    {
	        return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}ö�ѹ�������ͧ�Ѻ��������·���¹");
	    }

	    strcpy(carData[vehicleid][carPlate], param, 32);

		SetVehicleNumberPlate(vehicleid, param);
	    ResyncVehicle(vehicleid);

	    GivePlayerMoneyEx(playerid, -20000);
		GameTextForPlayer(playerid, "~r~-$20000", 5000, 1);
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carPlate = '%e' WHERE carID = %d", param, carData[vehicleid][carID]);
		mysql_tquery(g_SQL, query);

		SendClientMessageEx(playerid, COLOR_GREEN, "�س������Թ $20,000 㹡������¹���·���¹�� '%s'", param);
	}

	return 1;
}

alias:vstash("�红ͧ�ö")
CMD:vstash(playerid, params[])
{
	new vehicleid = GetNearbyVehicle(playerid);
	new query[300];

	if(vehicleid != INVALID_VEHICLE_ID && IsVehicleOwner(playerid, vehicleid))
	{
	    new option[14], param[32];

		if(!carData[vehicleid][carTrunk])
		{
		    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}ö�ѹ�������ժ�ͧ�红ͧ /�Ѿö 㹡���Ѿ�ô");
	    }
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س��ͧ������ѧö");
		}
		if(sscanf(params, "s[14]S()[32]", option, param))
		{
		    return SendClientMessage(playerid, COLOR_WHITE, "/�红ͧ�ö [1 | 2 | ����͡]");
	    }
	    if(!strcmp(option, "1", true))
	    {
	        SendClientMessage(playerid, COLOR_GREEN, "|_____ ��ͧ�红ͧ _____|");
	        SendClientMessageEx(playerid, COLOR_GREY2, "�Թ: %s/%s", FormatMoney(carData[vehicleid][carCash]), FormatMoney(GetVehicleStashCapacity(vehicleid, STASH_CAPACITY_CASH)));
		}
		else if(!strcmp(option, "2", true))
	    {
	        new value;

	        if(sscanf(param, "s[14]S()[32]", option, param))
	        {
	            SendClientMessage(playerid, COLOR_WHITE, "/�红ͧ�ö [���] [������¡��]");
	            SendClientMessage(playerid, COLOR_YELLOW, "[������¡��]:{FFFFFF} �Թ");
	            return 1;
	        }
	        if(!strcmp(option, "�Թ", true))
			{
			    if(sscanf(param, "i", value))
			    {
			        return SendClientMessage(playerid, COLOR_WHITE, "/�红ͧ�ö [2] [�Թ] [�ӹǹ]");
				}
				if(value < 1 || value > GetPlayerMoneyEx(playerid))
				{
				    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س���Թ�����§��");
			    }
			    if(carData[vehicleid][carCash] + value > GetVehicleStashCapacity(vehicleid, STASH_CAPACITY_CASH))
			    {
			        return SendClientMessageEx(playerid, COLOR_RED, "[�к�] {FFFFFF}��ͧ�红ͧ�ö����ö����Թ���ҡ�ش�� %s", FormatMoney(GetVehicleStashCapacity(vehicleid, STASH_CAPACITY_CASH)));
			    }

			    GivePlayerMoneyEx(playerid, -value);
			    carData[vehicleid][carCash] += value;
			    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carCash = %d WHERE carID = %d", carData[vehicleid][carCash], carData[vehicleid][carID]);
			    mysql_tquery(g_SQL, query);

			    SendClientMessageEx(playerid, COLOR_SERVER, "** �س������Թ�ӹǹ %s ŧ㹪�ͧ�红ͧö", FormatMoney(value));
			}
		}
		else if(!strcmp(option, "����͡", true))
	    {
	        new value;

	        if(sscanf(param, "s[14]S()[32]", option, param))
	        {
	            SendClientMessage(playerid, COLOR_WHITE, "/�红ͧ�ö [����͡] [������¡��]");
	            SendClientMessage(playerid, COLOR_YELLOW, "[������¡��]:{FFFFFF} �Թ");
	            return 1;
	        }
	        if(!strcmp(option, "�Թ", true))
			{
			    if(sscanf(param, "i", value))
			    {
			        return SendClientMessage(playerid, COLOR_WHITE, "/�红ͧ�ö [����͡] [�Թ] [�ӹǹ]");
				}
				if(value < 1 || value > carData[vehicleid][carCash])
				{
				    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س���Թ�����§��");
			    }

			    GivePlayerMoneyEx(playerid, value);
			    carData[vehicleid][carCash] -= value;

			    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carCash = %d WHERE carID = %d", carData[vehicleid][carCash], carData[vehicleid][carID]);
			    mysql_tquery(g_SQL, query);

			    SendClientMessageEx(playerid, COLOR_SERVER, "** �س������Թ�ӹǹ %s �͡�ҡ��ͧ�红ͧ�ö", FormatMoney(value));
			}
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س��ͧ�������ö�ͧ�س");
	}

	return 1;
}

CMD:neon(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);

	if(!vehicleid || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س��ͧ�����ö�µ�ͧ��ʶҹФ��Ѻ��ҹ��");
	}
	if(!IsVehicleOwner(playerid, vehicleid) && playerData[playerid][pVehicleKeys] != vehicleid)
	{
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س��ͧ�����ö��ǹ��Ǣͧ�س");
	}
	if(!carData[vehicleid][carNeon])
	{
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}ö�ѹ�������� Neon");
	}

	if(!carData[vehicleid][carNeonEnabled])
	{
	    carData[vehicleid][carNeonEnabled] = 1;
	    GameTextForPlayer(playerid, "~g~Neon activated", 3000, 3);

	    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s �顴���������Դ Neon", GetPlayerNameEx(playerid));
	}
	else
	{
	    carData[vehicleid][carNeonEnabled] = 0;
	    GameTextForPlayer(playerid, "~r~Neon deactivated", 3000, 3);

	    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s �顴�������ͻԴ Neon", GetPlayerNameEx(playerid));
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
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س��ͧ�����ö�µ�ͧ��ʶҹФ��Ѻ��ҹ��");
	}
	if(!IsVehicleOwner(playerid, vehicleid) && playerData[playerid][pVehicleKeys] != vehicleid)
	{
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س��ͧ�����ö��ǹ��Ǣͧ�س");
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
	    SendClientMessage(playerid, COLOR_WHITE, "** ��ö�ͧ�س���Ѻ�����ջ���");
	}
	else if(!strcmp(params, "paintjob", true))
	{
	    carData[vehicleid][carPaintjob] = -1;

	    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carPaintjob = -1 WHERE carID = %d", carData[vehicleid][carID]);
	    mysql_tquery(g_SQL, query);

	    ChangeVehiclePaintjob(vehicleid, -1);
	    SendClientMessage(playerid, COLOR_WHITE, "** ���ö�ͧ�س���Ѻ���繻���");
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

	    SendClientMessage(playerid, COLOR_WHITE, "** �ͧ��ö�١�ʹ�͡������");
	}
	else if(!strcmp(params, "neon", true))
	{
	    if(!carData[vehicleid][carNeon])
	    {
	        return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}ö�ѹ�������� Neon");
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

	    SendClientMessage(playerid, COLOR_WHITE, "** Neon �١�ʹ�͡�ҡö");
	}

	return 1;
}
CMD:carinfo(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);

	if(!vehicleid || !IsVehicleOwner(playerid, vehicleid))
	{
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س��ͧ�����ö��ǹ��Ǣͧ�س");
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
	SendClientMessageEx(playerid, COLOR_GREY2, "(��Ңͧ: %s) - (�Ҥ�: %s) - (����: %s) - (���·���¹: %s)", carData[vehicleid][carOwner], FormatMoney(carData[vehicleid][carPrice]), FormatMoney(carData[vehicleid][carTickets]), carData[vehicleid][carPlate]);
	SendClientMessageEx(playerid, COLOR_GREY2, "(Neon: %s) - (����Ū�ͧ�红ͧ: %d/3) - (�����������: %.1f) - (����ѹ: %.2f)", neon, carData[vehicleid][carTrunk], health, vehicleFuel[vehicleid]);
	return 1;
}
CMD:atm(playerid, params[])
{
	if (ATM_Nearest(playerid) == -1)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س������������ ��� ATM");

    CreatePlayerATM(playerid);
	//Dialog_Show(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, "[�ѭ�ո�Ҥ��]", "�ʹ�Թ�Ѩ�غѹ: %s", "���͡", "�Դ", FormatMoney(playerData[playerid][pBankMoney]));
	return 1;
}





alias:lock("��ͤ")
CMD:lock(playerid, params[])
{
	new
	    id = GetNearbyVehicle(playerid);

/*	if (!IsPlayerInAnyVehicle(playerid) && (id = (Entrance_Inside(playerid) == -1) ? (Entrance_Nearest(playerid)) : (Entrance_Inside(playerid))) != -1)
	{
		if (strlen(entranceData[id][entrancePass]))
		{
			Dialog_Show(playerid, DIALOG_ENTRANCEPASS, DIALOG_STYLE_INPUT, "[���ʼ�ҹ��е�]", "������ʼ�ҹ����е����ͤ�����ʹ���:", "�׹�ѹ", "�͡");
		}
	}*/
//	SendClientMessageEx(playerid, -1, "IsVehicleOwner: %d", IsVehicleOwner(playerid, id));
    if(IsVehicleOwner(playerid, id) || playerData[playerid][pVehicleKeys] == id || (carData[id][carFaction] >= 0 && carData[id][carFaction] == playerData[playerid][pFaction]))
	{
	    if(!carData[id][carLocked])
	    {
			carData[id][carLocked] = 1;

			GameTextForPlayer(playerid, "~r~Vehicle locked", 3000, 6);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s ����ͤö %s", GetPlayerNameEx(playerid), ReturnVehicleName(id));
		}
		else
		{
			carData[id][carLocked] = 0;

			GameTextForPlayer(playerid, "~g~Vehicle unlocked", 3000, 6);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s ��Ŵ��ͤö %s", GetPlayerNameEx(playerid), ReturnVehicleName(id));
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
	Dialog_Show(playerid, DIALOG_TYPE_MAIN, DIALOG_STYLE_LIST, "Car Tuning Menu", "Paint Jobs\nColors\nHoods\nVents\nLights\nExhausts\nFront Bumpers\nRear Bumpers\nRoofs\nSpoilers\nSide Skirts\nBullbars\nWheels\nCar Stereo\nHydraulics\nNitrous Oxide", "���͡", "¡��ԡ");
	return 1;
}

alias:mechanic("����")
CMD:mechanic(playerid, params[])
{
	static
	    userid, price;

    if (GetFactionType(playerid) != FACTION_MEC)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س������ҧ!");

    if (sscanf(params, "ud", userid, price))
	    return SendClientMessage(playerid, COLOR_WHITE, "/mechanic [�ʹ�/����] [�ӹǹ�Թ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ʹչ��������������");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ö����������ͧ��");

	if (price < 500 || price > 1000)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�Ҥҵ�ͧ����ӡ��� $500 �������Թ $1,000");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ʹչ��������������س");

	if (GetPlayerMoneyEx(userid) < price)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�����蹹�����Թ�����§��");

	if (GetPlayerState(userid) != PLAYER_STATE_DRIVER)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�����蹵�ͧ�����ʶҹФ��Ѻ");

	playerData[playerid][pMecOfferID] = userid;
	playerData[playerid][pMecOfferPrice] = price;
	playerData[userid][pMecOfferID] = playerid;
	playerData[userid][pMecOfferPrice] = price;
	Dialog_Show(playerid, DIALOG_MECHANIC, DIALOG_STYLE_LIST, "[��¡�ë���]", "����¹��\n����ö", "��ŧ", "�Դ");
	return 1;
}

alias:heal("�ѡ��")
CMD:heal(playerid, params[])
{
	static
	    userid, price;

	new string[256];

    if (GetFactionType(playerid) != FACTION_MEDIC)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}��ͧ�ҧ�������Ѻ���˹�ҷ����ҹ��!");

    if (sscanf(params, "ud", userid, price))
	    return SendClientMessage(playerid, COLOR_WHITE, "/�ѡ�� [�ʹ�/����] [�ӹǹ�Թ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ʹչ��������������");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ö�ѡ�ҵ���ͧ��");

	if (price < 50 || price > 500)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�Ҥҵ�ͧ����ӡ��� $50 �������Թ $500");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ʹչ��������������س");

	if (GetPlayerMoneyEx(userid) < price)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�����蹹�����Թ�����§��");

	if (IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س��ͧ��������ö");

	if (IsPlayerInAnyVehicle(userid))
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ʹչ���ͧ��������ö");


	new Float:hp;
	GetPlayerHealth(userid, hp);

	if (hp > 70)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ʹչ������������ʶҹТҴ���ʹ");

	playerData[playerid][pMedicOfferID] = userid;
	playerData[playerid][pMedicOfferPrice] = price;
	playerData[userid][pMedicOfferID] = playerid;
	playerData[userid][pMedicOfferPrice] = price;

	format(string, sizeof string, "{FFFFFF}�ͺ�Ѻ����ѡ�Ҩҡ��� (������ʹ) %s �Ҥ� %s", GetPlayerNameEx(playerid), FormatMoney(price));
    Dialog_Show(userid, DIALOG_ACCEPT44, DIALOG_STYLE_INPUT, "[�׹�ѹ]", string, "�׹�ѹ", "�Դ");
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

	    SendClientMessageEx(userid, COLOR_WHITE, "�س���ѡ�� {33CCFF}%s{FFFFFF} �繨ӹǹ�Թ $%d", GetPlayerNameEx(playerid), price);
	    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "%s {FFFFFF}���ѡ�Ҥس �繨ӹǹ�Թ $%d", GetPlayerNameEx(userid), price);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ���ѡ�� %s", GetPlayerNameEx(userid), GetPlayerNameEx(playerid));
		
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

	    SendClientMessageEx(userid, COLOR_WHITE, "�س���ѡ���ҡ�úҴ����� {33CCFF}%s{FFFFFF} �繨ӹǹ�Թ $%d", GetPlayerNameEx(playerid), price);
	    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "%s {FFFFFF}���ѡ���ҡ�úҴ�����س �繨ӹǹ�Թ $%d", GetPlayerNameEx(userid), price);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ���ѡ���ҡ�úҴ����� %s", GetPlayerNameEx(userid), GetPlayerNameEx(playerid));
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

alias:cpr("�غ���Ե")
CMD:cpr(playerid, params[])
{
	static
	    userid, price;

    new string[256];

    if (GetFactionType(playerid) != FACTION_MEDIC)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}��ͧ�ҧ�������Ѻ���˹�ҷ����ҹ��!");

    if (sscanf(params, "ud", userid, price))
	    return SendClientMessage(playerid, COLOR_WHITE, "/�غ���Ե [�ʹ�/����] [�ӹǹ�Թ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ʹչ��������������");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ö�ѡ�ҵ���ͧ��");

	if (price < 300 || price > 1000)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�Ҥҵ�ͧ����ӡ��� $500 �������Թ $1,000");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ʹչ��������������س");

	if (GetPlayerMoneyEx(userid) < price)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�����蹹�����Թ�����§��");

	if (!playerData[userid][pInjured])
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ʹչ������������ʶҹкҴ��");

	if (IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س��ͧ��������ö");

	if (IsPlayerInAnyVehicle(userid))
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ʹչ���ͧ��������ö");

	playerData[playerid][pMedicOfferID] = userid;
	playerData[playerid][pMedicOfferPrice] = price;
	playerData[userid][pMedicOfferID] = playerid;
	playerData[userid][pMedicOfferPrice] = price;

	format(string, sizeof string, "{FFFFFF}�ͺ�Ѻ����ѡ�Ҩҡ��� (�ؾ CPR) %s �Ҥ� %s", GetPlayerNameEx(playerid), FormatMoney(price));
    Dialog_Show(userid, DIALOG_ACCEPT55, DIALOG_STYLE_INPUT, "[�׹�ѹ]", string, "�׹�ѹ", "�Դ");
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
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س�����˹�����Ҫԡ�ͧ������ �");

	SendClientMessage(playerid, COLOR_SERVER, "��Ҫԡ����͹�Ź�:");

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
	    SendClientMessage(playerid, COLOR_WHITE, "/faction [�ʹա����]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[�ʹա����]:{FFFFFF} 1. ���Ǩ 2. �ѡ���� 3. ᾷ�� 4. ��¡");
		return 1;
	}
	if (type < 1 || type > 4)
	{
	    SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�ʹյ�ͧ����ӡ��� 1 �������Թ 4 ��ҹ��");
	    return 1;
	}
	switch(type)
	{
	    case 1: name = "���Ǩ";
	    case 2: name = "�ѡ����";
	    case 3: name = "ᾷ��";
	    case 4: name = "��¡";
	}
	foreach (new i : Player) if (GetFactionType(i) == type)
	{
	    count++;
		SendClientMessageEx(playerid, COLOR_WHITE, "(%s) �͹�Ź� %d", name, count);
	}
	if (!count)
	{
		SendClientMessageEx(playerid, COLOR_RED, "[�к�] {FFFFFF}����� %s ����դ��͹�Ź����", name);
		return 1;
	}
	return 1;
}

CMD:gov(playerid, params[])
{
    new factionid = playerData[playerid][pFaction];

	if (GovCD[playerid] != 0)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "* �س��ͧ�� %d �Թҷն֧����ҹ����觹����", GovCD[playerid]);

    if (playerData[playerid][pOOCSpam] > 0)
    	return SendClientMessageEx(playerid, COLOR_RED, "[�к�] {FFFFFF}��ͧ�ѹ��� Spam ��ͤ��� �س����������ա %d �Թҷ� 㹡�������������ա����", playerData[playerid][pOOCSpam]);

 	if (factionid == -1)
	    return SendClientMessage(playerid, COLOR_GREY, "   �س��ͧ����Ҫԡ�ͧ�������͡����");

	if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
	    return SendClientMessageEx(playerid, COLOR_RED, "[�к�] {FFFFFF}�س�������ö�����觹���� (Rank ��鹵�� : %d)", factionData[playerData[playerid][pFaction]][factionRanks] - 1);

	if (isnull(params))
		return SendClientMessage(playerid, COLOR_GREY, "�����ҹ : {FFFFFF}/(gov)ernment (��ͤ���)");

	if (GetFactionType(playerid) == FACTION_GANG)
	{
		new string[128];

		format(string, sizeof(string), "{%s}[_____.:: ��С�Ȩҡ�� %s ::._____]", (factionid), Faction_GetName(playerid));
		SendClientMessageToAll(COLOR_WHITE, string);

		format(string, sizeof(string), "(%s) %s : %s", Faction_GetRank(playerid), GetPlayerNameEx(playerid), params);
		SendClientMessageToAll(COLOR_WHITE, string);

		playerData[playerid][pOOCSpam] = 25;

		return 1;
	}
	else
	{
		new string[128];

		format(string, sizeof(string), "{%s}[_____.:: ��С�Ȩҡ˹��§ҹ %s ::._____]", (factionid), Faction_GetName(playerid));
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
			return SendClientMessage(playerid, COLOR_WHITE, "/setmoney [�ʹ�/����] [�ӹǹ]");

        if(userid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[�к�] {FFFFFF}�������ʹչ��������������");

        SetPlayerMoneyEx(userid, amount);

        SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ���Ѻ�Թ���Ѻ %s(%d) ����ͨӹǹ %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid), userid, FormatMoney(amount));
	}
    return 1;
}

CMD:hp(playerid, params[])
{
    if(playerData[playerid][pAdmin] > 0)
    {
    	new userid, Float:hp;
        if(sscanf(params, "uf", userid, hp))
			return SendClientMessage(playerid, COLOR_WHITE, "/hp [�ʹ�/����] [�ӹǹ]");

        if(userid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[�к�] {FFFFFF}�������ʹչ��������������");

        SetPlayerHealth(userid, hp);

        SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ���Ѻ���ʹ���Ѻ %s(%d) �ӹǹ %.0f", GetPlayerNameEx(playerid), GetPlayerNameEx(userid), userid, hp);
	}
    return 1;
}
CMD:setskin(playerid, params[])
{
	new
	    userid,
		skinid;

    if (playerData[playerid][pAdmin] < 1)
	    return SendClientMessage(playerid, COLOR_GREY, "�س������Ѻ͹حҵ��������觹��");

	if (sscanf(params, "ud", userid, skinid))
	    return SendClientMessage(playerid, COLOR_GREY, "�����ҹ : {FFFFFF}/setskin [playerid/name] [skin id]");

    if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_GREY, "�����蹷���к����١��ͧ");

	if (skinid < 0 || skinid > 311)
	    return SendClientMessage(playerid, COLOR_GREY, "�ʹ�ʡԹ���١��ͧ ʡԹ��ͧ����㹪�ǧ 0 �֧ 311");

	SetPlayerSkin(userid, skinid);
	playerData[userid][pSkin] = skinid;

	SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* �س���駤��ʡԹ�ͧ %s ��ʡԹ�ʹ�: %d", GetPlayerNameEx(userid), skinid);

	return 1;
}
CMD:acpr(playerid, params[])
{
	static
	    userid;

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

    if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/acpr [�ʹ�/����]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "[�к�] {FFFFFF}�������ʹչ��������������");

	if (!playerData[userid][pInjured])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "[�к�] {FFFFFF}�������ʹչ������������ʶҹкҴ��");



	return 1;
}
CMD:setadmin(playerid, params[])
{
    if(playerData[playerid][pAdmin] > 5)
    {
    	new userid, level;
        if(sscanf(params, "ud", userid, level))
			return SendClientMessage(playerid, COLOR_WHITE, "/setadmin [�ʹ�/����] [�����]");

        if(userid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[�к�] {FFFFFF}�������ʹչ��������������");

        playerData[userid][pAdmin] = level;

        SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ���Ѻ������ʹ�Թ���Ѻ %s(%d) ���ʹ�Թ����� %d", GetPlayerNameEx(playerid), GetPlayerNameEx(userid), userid, level);
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
		    SendClientMessageEx(playerid, COLOR_RED, "[�к�] {FFFFFF}�س�� Coin �����§��㹡�ë��� (%d/%d Coin)", playerData[playerid][pCoin], carshopData[carshopid][carshopPrice]);
		    return 1;
		}

		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[playerid][pID], GetPlayerNameEx(playerid), carshopData[carshopid][carshopModel], carshopData[carshopid][carshopPrice], vehicleData[carshopData[carshopid][carshopModel] - 400][vFuel]);
		mysql_tquery(g_SQL, query);

		playerData[playerid][pCoin] -= carshopData[carshopid][carshopPrice];

		format(string, sizeof(string), "{FFFFFF}�س�����ö��� {F9C205}%s {FFFFFF}��Ҥ� {F9C205}%d Coin {FFFFFF}���º��������", ReturnVehicleModelName(carshopData[carshopid][carshopModel]), carshopData[carshopid][carshopPrice]);
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


alias:sellmycar("���ö�����ҹ")
CMD:sellmycar(playerid, params[])
{
 	new vehicleid = GetPlayerVehicleID(playerid), query[128];

	if(!vehicleid || !IsVehicleOwner(playerid, vehicleid))
	{
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س��ͧ�����ö��ǹ��Ǣͧ�س");
	}
	if(!IsPlayerInRangeOfPoint(playerid, 8.0, 542.0433, -1293.5909, 17.2422))
	{
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س�������������ҹ���ö");
	}
	if(strcmp(params, "�׹�ѹ", true) != 0)
	{
	    SendClientMessage(playerid, COLOR_WHITE, "/sellmycar [�׹�ѹ]");
	    SendClientMessageEx(playerid, COLOR_RED, "ö�ѹ���ж١ź�͡������Фس�����Ѻ�Թ��Ѻ�ӹǹ %s", FormatMoney(percent(carData[vehicleid][carPrice], 75)));
	    return 1;
	}

	GivePlayerMoneyEx(playerid, percent(carData[vehicleid][carPrice], 75));

	SendClientMessageEx(playerid, COLOR_GREEN, "�س����ö��� %s �׹��ҹ��Ҥ� %s �����", ReturnVehicleName(vehicleid), FormatMoney(percent(carData[vehicleid][carPrice], 75)));

	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicles WHERE carID = %d", carData[vehicleid][carID]);
	mysql_tquery(g_SQL, query);

	DespawnVehicle(vehicleid, false);

	return 1;
}
alias:vape("�ٺ������俿��")
CMD:vape(playerid, params[])
{
    if (!Inventory_HasItem(playerid, "������俿��"))
		return SendClientMessage(playerid, COLOR_RED, "[!]{ffffff}�س����� '������俿��'");

    new Float:hp;
    GetPlayerHealth(playerid, hp);

    if (hp > 50.0)
        return SendClientMessage(playerid, COLOR_LIGHTRED, "���ʹ�ͧ�س��ͧ���¡��� 50.0 �֧���ٺ��");

	ApplyAnimation(playerid,"SMOKING","M_smk_in",4.1, 0, 1, 1, 1, 1, 1);
	SetTimerEx("SmokeWeed214", 2000, false, "d", playerid);
	SendClientMessageEx(playerid, COLOR_YELLOW, "�س���ѧ�ٺ������俿�� HP + 50");

	return 1;
}

// --> �к������प��
alias:lot("����")
CMD:lot(playerid, params[])
{
	static
	    userid;

	if (sscanf(params, "u", userid))
     	return SendClientMessage(playerid, COLOR_GREY, "�����ҹ : {FFFFFF}/�����प�� [�ʹ�/����]");

    if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ʹչ��������������");

	if (!IsPlayerSpawnedEx(userid))
		return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�������ʹչ���ѧ����������ʶҹл���");

	new Float:X, Float:Y, Float:Z;

	GetPlayerPos(playerid, X,Y,Z);

	SetPlayerCheckpoint(userid, X,Y,Z, 2.0);

	SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "> �س���觾ԡѴ����ش�ͧ�س���Ѻ������ '%s' ����", GetPlayerNameEx(userid));
	SendClientMessageEx(userid, COLOR_YELLOW, "> �س���Ѻ�ԡѴ���˹�����ش�ͧ '%s' ����", GetPlayerNameEx(playerid));

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

    CreateDynamic3DTextLabel("{66FF00}[�ش�����]\n{CCFFFF}������ 'N'", COLOR_GREEN, -1424.9540,-960.4663,200.8258, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

    CreateDynamic3DTextLabel("{66FF00}[�ش������]\n{CCFFFF}������ 'N'", COLOR_GREEN,  1832.6227,-1848.5657,13.5781, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    CreateDynamicPickup(1239, 23, 1832.6227,-1848.5657,13.5781);

    CreateDynamic3DTextLabel("{66FF00}[�ش�����]\n{CCFFFF}������ 'N' �����紾�����", COLOR_GREEN, -1431.3784,-950.9202,200.9606, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

    CreateDynamic3DTextLabel("{66FF00}[Mushroom]\n{CCFFFF}������ 'N' ������Ѥçҹ", COLOR_GREEN, -1435.9050,-964.0720,201.0246, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
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
                SendClientMessage(playerid, 0xCC3300, "[!]  {FFFFFF}�س���͡�ҡ�Ҫվ��������� !");

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
            if(Mushroom[playerid] == false) return SendClientMessage(playerid, 0xCC3300, "[!] �س�����ӧҹ��Ҫվ��� �ô���Ѥçҹ��͹");

            if(GetHedOn[playerid] > 0) return 1;

            if(GetHedOn[playerid] == 0)
            {
                SendClientMessage(playerid, COLOR_GREEN, "[?] {FFFFFF} �س���ѧ����紡�س����ѡ���� .....");
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
            itemname = "���";
            new count = Inventory_Count(playerid, itemname);

            if(count<2) return SendClientMessage(playerid, 0xCC3300, "[!]  {FFFFFF}�س��ͧ������ҡ���� 2 ��� !");
            
			if(PackHedOn[playerid] == 0)
			{
				Dialog_Show(playerid, DIALOG_PACKHAD, DIALOG_STYLE_TABLIST_HEADERS, "[�ش�����]", "{66FF00}����\t{66FF00}��\t{228B22}�ѵ����ǹ\n{CCFFCC}1.���\t%d\t2/1", "��ŧ", "¡��ԡ",Inventory_Count(playerid, "���"));
				return 1;
			}
            return 1;
        }

        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1832.6227,-1848.5657,13.5781))
        {
            new itemname[24];
            itemname = "�����";
            new count = Inventory_Count(playerid, itemname);

            if(count<1) return SendClientMessage(playerid, 0xCC3300, "[!]  {FFFFFF}�س��ͧ��������ҡ���� 1 ��� !");
            new string9[256];
            format(string9,sizeof(string9),"{CCFF66}�س��������� %d\n{FFFFFF}�Ҥ� ����� {CCFF66}150 {FFFFFF}\n{FFFFFF}�ô��͡�ӹǹ���Т��",Inventory_Count(playerid, "�����"));
            Dialog_Show(playerid, D_Seal_HAD_1, DIALOG_STYLE_INPUT,"������",string9,"���","¡��ԡ");
            return 1;
        }
        return 1;
    }
    return 1;
}

Dialog:D_Seal_HAD_1(playerid, response, listitem, inputtext[])//
{
    new itemname[24];
    itemname = "�����";
    new count = Inventory_Count(playerid, itemname);
    if(response){
        if (strval(inputtext) > count || strval(inputtext) < 1)
        {
            new string9[256];
            format(string9,sizeof(string9),"{CCFF66}�س��������� %d\n{FFFFFF}�Ҥ� ����� {CCFF66}150 {FFFFFF}\n{FFFFFF}�ô��͡�ӹǹ���Т��",Inventory_Count(playerid, "�����"));
            Dialog_Show(playerid, D_Seal_HAD_1, DIALOG_STYLE_INPUT,"������",string9,"���","¡��ԡ");
            SendClientMessage(playerid, 0xCC3300, "[!]  {FFFFFF} �ô���ӹǹ���١��ͧ !");
            return 1;
        }
        if(count >= 1)
        {
            GivePlayerMoneyEx(playerid,150*strval(inputtext));//150 ����Ҥ�
            SendClientMessageEx(playerid, COLOR_GREEN, "[!]  {FFFFFF}�����紨ӹǹ %d �������� ",strval(inputtext));
            SendClientMessageEx(playerid, COLOR_GREEN, "[!]  {FFFFFF}���Ѻ�Թ %d",150*strval(inputtext));

            Inventory_Remove(playerid, "�����", strval(inputtext));
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
	if(Inventory_Count(playerid, "���") >= 2)
	{
		TogglePlayerControllable(playerid, 1);
		ClearAnimations(playerid);
	    PackHedOn[playerid] = 0;

		Inventory_Remove(playerid, "���", 2);
		Inventory_Add(playerid, "�����", 1);
		SendClientMessageEx(playerid, COLOR_GREEN, "{00FF00}[ {66FFFF}+ {00FF00}]  {FFFFFF}�����{00FF00}����� {FFFFFF}�س���Ѻ ����� +1 (%d)",Inventory_Count(playerid, "�����"));
        SendClientMessageEx(playerid, COLOR_GREEN, "{00FF00}[ {66FFFF}+ {00FF00}]  {FFFFFF}��� {FF3333}-2 {FFFFFF}(%d)",Inventory_Count(playerid, "���"));
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
	itemname = "���";


    new count = Inventory_Count(playerid, itemname);

    if (count > 52)
        return SendClientMessageEx(playerid, COLOR_RED, "[!] {FFFFFF}��ͧ�� {00FF00}%s{FFFFFF} �ͧ�س�����§��", itemname);

    new id = Inventory_Add(playerid, itemname, 1);

    if (id == -1)
        return SendClientMessageEx(playerid, COLOR_RED, "[!] {FFFFFF}�����آͧ�����������§�� (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

    SendClientMessage(playerid, COLOR_GREEN, "[!] {FFFFFF}�س���Ѻ��� 1 ���");

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
    SendClientMessage(playerid, COLOR_GREEN, "[!]  {FFFFFF}�س����Ѥçҹ�Ҫվ���������");
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
	    SendClientMessage(playerid, COLOR_YELLOW, "[type]:{FFFFFF} 1: �ش��Ѥçҹ | 2: �ش����� | 3: �ش�� | 4: �ش���");
	    return 1;
	}
    if (type < 1 || type > 4)
		return SendClientMessage(playerid, COLOR_YELLOW, "[type]:{FFFFFF} 1: �ش��Ѥçҹ | 2: �ش����� | 3: �ش�� | 4: �ش���");

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
		return SendClientMessage(playerid, COLOR_RED, "- ��ͧ�ҧ�������Ѻ���˹�ҷ����ҹ��!");

	if (sscanf(params, "us[32]", userid, crime))
	    return SendClientMessage(playerid, COLOR_WHITE, "(/su)spect [�ʹ�/����] [�����]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ��������������");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ö�Ѵ���������ͧ��");

	if (GetFactionType(userid) == FACTION_POLICE || GetFactionType(userid) == FACTION_MEDIC || GetFactionType(userid) == FACTION_GOV)
        return SendClientMessage(playerid, COLOR_RED, "- �������ö�Ѵ������Ѻ˹��§ҹ�Ѱ��");

    GivePlayerWanted(userid, 1);

	SendClientMessageEx(playerid, COLOR_WHITE, "�س���Ѵ��դ������Ѻ {33CCFF}%s {FFFFFF}�����: %s", GetPlayerNameEx(userid), crime);
	SendClientMessageEx(userid, COLOR_WHITE, "���˹�ҷ�� {33CCFF}%s {FFFFFF}���Ѵ������س �����: %s", GetPlayerNameEx(playerid), crime);
    return 1;
}
alias:suspect("1")

CMD:clearwd(playerid, params[])
{
    new
	    userid;

	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "- ��ͧ�ҧ�������Ѻ���˹�ҷ����ҹ��!");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/clearwd [�ʹ�/����]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ��������������");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ö���´��������ͧ��");

	if (GetPlayerWantedLevelEx(userid) == 0)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ������դ�յԴ������");

    ResetPlayerWantedLevelEx(userid);

	SendClientMessageEx(playerid, COLOR_WHITE, "�س��ź��ҧ������Ѻ {33CCFF}%s", GetPlayerNameEx(userid));
	SendClientMessageEx(userid, COLOR_WHITE, "���˹�ҷ�� {33CCFF}%s {FFFFFF}��ź��ҧ��շ��������س", GetPlayerNameEx(playerid));
    return 1;
}
alias:clearwd("0")

CMD:wdlist(playerid, params[])
{
    new
	    count;

	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "- ��ͧ�ҧ�������Ѻ���˹�ҷ����ҹ��!");

	foreach(new i : Player)
	{
	    if (GetPlayerWantedLevelEx(i) > 0)
	    {
	        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "ID: %d: %s {FFFFFF}%d ���", i, GetPlayerNameEx(i), GetPlayerWantedLevelEx(i));
	        count++;
	    }
	}
	if (!count)
	{
	    SendClientMessage(playerid, COLOR_RED, "- ��й����������դ�յԴ������");
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
		return SendClientMessage(playerid, COLOR_RED, "- ��ͧ�ҧ�������Ѻ���˹�ҷ����ҹ��!");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/cuff [�ʹ�/����]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ��������������");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ��������������س ���� 5 �����");

   /* if (!playerData[userid][pCuffed])
        return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ�������١���ح��������");*/

	if (vehicleid == INVALID_VEHICLE_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- �س������������ö�ѹ�˹���");

	if (GetVehicleMaxSeats(vehicleid) < 1)
  	    return SendClientMessage(playerid, COLOR_RED, "- �س�������ö�ӵ�Ǣ��ö�ѹ�����");

	if (IsPlayerInVehicle(userid, vehicleid))
	{
		TogglePlayerControllable(userid, 1);

		RemoveFromVehicle(userid);
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ���Դ��е���д֧ %s ŧ�Ҩҡ�ҹ��˹�", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	}
	else
	{
		new seatid = GetAvailableSeat(vehicleid, 2);

		if (seatid == -1)
		    return SendClientMessage(playerid, COLOR_RED, "- ������������");

		TogglePlayerControllable(userid, 0);

		StopDragging(userid);
		PutPlayerInVehicle(userid, vehicleid, seatid);

		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ���Դ��е���д֧ %s ����ҹ��˹�", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	}
	return 1;
}
alias:detain("5")

CMD:cuff(playerid, params[])
{
    new
	    userid;

	if (GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "- ��ͧ�ҧ�������Ѻ���˹�ҷ����ҹ��!");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/cuff [�ʹ�/����]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ��������������");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ö���ح����������ͧ��");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ���ͧ���������ҹ��˹�");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ��������������س");

    if (playerData[userid][pCuffed])
        return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ��١���ح��������");

	static
	    string[64];

    playerData[userid][pCuffed] = 1;

    TogglePlayerControllable(userid, false);
    SetPlayerSpecialAction(userid, SPECIAL_ACTION_CUFFED);

	format(string, sizeof(string), "You've been ~r~cuffed~w~ by %s", GetPlayerNameEx(playerid));
    GameTextForPlayer(userid, string, 5000, 1);

    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s �����ح���ͼ���ͧʧ��� %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
    return 1;
}
alias:cuff("2")


CMD:uncuff(playerid, params[])
{
    new
	    userid;

	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "- ��ͧ�ҧ�������Ѻ���˹�ҷ����ҹ��!");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/uncuff [�ʹ�/����]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ��������������");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ö�Ŵ�ح����������ͧ��");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ��������������س");

    if (!playerData[userid][pCuffed])
        return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ�������١���ح����");

	static
	    string[64];

    playerData[userid][pCuffed] = 0;

    TogglePlayerControllable(userid, true);
    SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);

	format(string, sizeof(string), "You've been ~g~uncuffed~w~ by %s", GetPlayerNameEx(playerid));
    GameTextForPlayer(userid, string, 5000, 1);

    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ��ʹ�ح����������ͧʧ��� %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
    return 1;
}
alias:uncuff("3")

CMD:drag(playerid, params[])
{
	new
	    userid;

	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_GOV)
		return SendClientMessage(playerid, COLOR_RED, "- ��ͧ�ҧ�������Ѻ���˹�ҷ����ҹ��!");

    if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/drag [�ʹ�/����]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ��������������");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ö�ҡ����ͧ��");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ���ͧ���������ҹ��˹�");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ��������������س");

	if (playerData[userid][pDragged])
	{
	    playerData[userid][pDragged] = 0;
	    playerData[userid][pDraggedBy] = INVALID_PLAYER_ID;

	    KillTimer(playerData[userid][pDragTimer]);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s �����µ�Ǽ���ͧ�� %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	}
	else
	{
	    playerData[userid][pDragged] = 1;
	    playerData[userid][pDraggedBy] = playerid;

	    playerData[userid][pDragTimer] = SetTimerEx("DragUpdate", 200, true, "dd", playerid, userid);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ��ҵ�Ǽ���ͧ�� %s 仡Ѻ��", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
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
		return SendClientMessage(playerid, COLOR_RED, "- ��ͧ�ҧ�������Ѻ���˹�ҷ����ҹ��!");

	if (sscanf(params, "udd", userid, time, money))
	    return SendClientMessage(playerid, COLOR_WHITE, "(/ar)rest [�ʹ�/����] [�ҷ�] [��һ�Ѻ 1-1000]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ��������������");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ö�觵���ͧ��Ҥء��");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ��������������س");

	if (time < 5 || time > 30)
	    return SendClientMessage(playerid, COLOR_RED, "- ���ҵ�ͧ����ӡ��� 1 �������Թ 30 �ҷ�");

	if (money < 1 || money > 1000)
	    return SendClientMessage(playerid, COLOR_RED, "- �кبӹǹ�Թ�����٧���� 1000 �ҷ");

	if (id == -1)
	    return SendClientMessage(playerid, COLOR_RED, "- �س���������ش�觼���ͧ����Ҥء");

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

    SendClientMessageToAllEx(COLOR_LIGHTRED, ">>> ����ͧ�� %s �١�ӵ����Ҥء������ %s �ҷ� <<<", GetPlayerNameEx(userid), FormatNumber(time));

    return 1;
}
alias:arrest("ar")

CMD:jail(playerid, params[])
{
	static
	    userid,
		time;

	if (playerData[playerid][pAdmin] == 0)
		return SendClientMessage(playerid, COLOR_RED, "- ��ͧ�ҧ�������Ѻ�ʹ�Թ��ҹ��!");

	if (sscanf(params, "ud", userid, time))
	    return SendClientMessage(playerid, COLOR_WHITE, "/jail [�ʹ�/����] [�ҷ�]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ��������������");

	if (time < 1 || time > 1000)
	    return SendClientMessage(playerid, COLOR_RED, "- ���ҵ�ͧ����ӡ��� 1 �������Թ 1000 �ҷ�");

	playerData[userid][pPrisoned] = 1;
	playerData[userid][pJailTime] = time * 60; // time * 60

	playerData[userid][pPrisonOut] = 0;

	StopDragging(userid);
	SetPlayerInPrison(userid);

	ResetPlayerWeaponsEx(userid);
	ResetPlayer(userid);

	playerData[userid][pCuffed] = 0;

    SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);

    SendClientMessageToAllEx(COLOR_LIGHTRED, "*** �ʹ�Թ %s ���觼����� %s ��Ҥء %s �ҷ�", GetPlayerNameEx(playerid), GetPlayerNameEx(userid), FormatNumber(time));
    return 1;
}


// ������
CMD:draggedz(playerid, params[])
{
	new
	    userid, string[256];

    if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/������ [�ʹ�/����]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ��������������");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ö�ҡ����ͧ��");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ���ͧ���������ҹ��˹�");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "- �������ʹչ��������������س");

	playerData[playerid][pMecOfferID] = userid;
	playerData[playerid][pMecOfferPrice] = 0;

	playerData[userid][pMecOfferID] = playerid;
	playerData[userid][pMecOfferPrice] = 0;

	format(string, sizeof string, "{FFFFFF}�ͺ�Ѻ��������ҡ %s", GetPlayerNameEx(playerid));
	Dialog_Show(userid, DIALOG_DRAGGED, DIALOG_STYLE_MSGBOX, "[�׹�ѹ]", string, "�׹�ѹ", "�Դ");

	SendClientMessageEx(playerid, COLOR_YELLOW, "�س���觤Ӣ͡�������֧ %s ���� �͡�õͺ��Ѻ!", GetPlayerNameEx(userid));

	return 1;
}
alias:draggedz("������")

// �������
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
		    SendNearbyMessage(userid, 30.0, COLOR_PURPLE, "** %s �����µ�Ǽ���ͧ�� %s", GetPlayerNameEx(userid), GetPlayerNameEx(playerid));
		}
		else
		{
		    playerData[playerid][pDragged] = 1;
		    playerData[playerid][pDraggedBy] = userid;

		    playerData[playerid][pDragTimer] = SetTimerEx("DragUpdate", 200, true, "dd", userid, playerid);
		    SendNearbyMessage(userid, 30.0, COLOR_PURPLE, "** %s ��ҵ�Ǽ���ͧ�� %s 仡Ѻ��", GetPlayerNameEx(userid), GetPlayerNameEx(playerid));
		}

		SendClientMessageEx(playerid, COLOR_GREEN, "[�������] {FFFFFF}�س������Ѻ��������ҡ %s ���º��������", GetPlayerNameEx(userid));
		SendClientMessageEx(userid, COLOR_GREEN, "[�������] {FFFFFF}�س������ %s ����", GetPlayerNameEx(playerid));

		playerData[userid][pMecOfferID] = INVALID_PLAYER_ID;
		playerData[userid][pMecOfferPrice] = 0;

		playerData[playerid][pMecOfferID] = INVALID_PLAYER_ID;
		playerData[playerid][pMecOfferPrice] = 0;
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "[�������] {FFFFFF}�س�黯��ʸ��������ҡ %s ���º��������", GetPlayerNameEx(userid));
		SendClientMessageEx(userid, COLOR_LIGHTRED, "[�������] {FFFFFF}������ %s �黯��ʸ�����������", GetPlayerNameEx(playerid));

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