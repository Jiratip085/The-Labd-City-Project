#include	<YSI_Coding\y_hooks>

new ATMTransfer[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
	ATMTransfer[playerid] = 0;
}

CreatePlayerATM(playerid)
{
	new str[128];
    format(str, sizeof(str), "{FFFFFF}�ʹ�Թ㹺ѭ��: %s\n\
	{FFFFFF}- �ҡ�Թ (Deposit)\n\
	- �͹�Թ (Withdraw)\n\
	- �͹�Թ (Transfer)",
	FormatMoney(playerData[playerid][pBankMoney]));
    Dialog_Show(playerid, DIALOG_ATM, DIALOG_STYLE_TABLIST, "��Ҥ�� (Bank)", str, "���͡", "¡��ԡ" );
	return 1;
}
Dialog:DIALOG_ATM(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch(listitem)
		{
			case 1: return Dialog_Show(playerid, ATM_Deposit, DIALOG_STYLE_INPUT, "�ҡ�Թ (Deposit)", "{FFFFFF}�Թ���㹵��(Cash):{00FF00} %s {FFFFFF}| �Թ㹸�Ҥ��(Bank): {00FF00}%s{FFA84D}\n\
			�ô�кبӹǹ���س��ͧ��èнҡ", "��ŧ", "��Ѻ",
			FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));

			case 2: return Dialog_Show(playerid, ATM_Withdraw, DIALOG_STYLE_INPUT, "�͹�Թ (Withdraw)", "{FFFFFF}�Թ���㹵��(Cash):{00FF00} %s {FFFFFF}| �Թ㹸�Ҥ��(Bank): {00FF00}%s{FFA84D}\n\
			�ô�кبӹǹ���س��ͧ��èж͹", "��ŧ", "��Ѻ",
			FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));

			case 3: return Dialog_Show(playerid, ATM_Transfer, DIALOG_STYLE_INPUT, "�͹�Թ (Transfer)", "{FFFFFF}�Թ���㹵��(Cash):{00FF00} %s {FFFFFF}| �Թ㹸�Ҥ��(Bank): {00FF00}%s{FFA84D}\n\
			�ô�к��ʹբͧ������ ���س��ͧ��è��͹�Թ���", "��ŧ", "��Ѻ",
			FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));
		}
	}
	return 1;
}
Dialog:ATM_Deposit(playerid, response, listitem, inputtext[])
{
	new string[128], amount;
	if (response)
	{
		if (sscanf(inputtext, "d", amount))
			return Dialog_Show(playerid, ATM_Deposit, DIALOG_STYLE_INPUT, "�ҡ�Թ (Deposit)", "{FFFFFF}�Թ���㹵��(Cash):{00FF00} %s {FFFFFF}| �Թ㹸�Ҥ��(Bank): {00FF00}%s{FFA84D}\n\
					�ô�кبӹǹ���س��ͧ��èнҡ", "��ŧ", "��Ѻ",
					FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));

		if(amount < 1)
			return Dialog_Show(playerid, ATM_Deposit, DIALOG_STYLE_INPUT, "�ҡ�Թ (Deposit)", "{FFFFFF}�Թ���㹵��(Cash):{00FF00} %s {FFFFFF}| �Թ㹸�Ҥ��(Bank): {00FF00}%s{FFA84D}\n\
					�ô�кبӹǹ���س��ͧ��èнҡ {FF6347}*�ӹǹ���س��ͧ��èнҡ��ͧ�ҡ���� 0", "��ŧ", "��Ѻ",
					FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));
	
		if(amount > GetPlayerMoneyEx(playerid))
			return Dialog_Show(playerid, ATM_Deposit, DIALOG_STYLE_INPUT, "�ҡ�Թ (Deposit)", "{FFFFFF}�Թ���㹵��(Cash):{00FF00} %s {FFFFFF}| �Թ㹸�Ҥ��(Bank): {00FF00}%s{FFA84D}\n\
					�ô�кبӹǹ���س��ͧ��èнҡ {FF6347}*�ӹ��ǹ�Թ�ͧ�س�������§��", "��ŧ", "��Ѻ",
					FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));
	
		playerData[playerid][pBankMoney] += amount;
		GivePlayerMoneyEx(playerid, -amount);	

		format(string, sizeof(string), "~r~-%s Cash~n~~g~+ %s Bank", FormatMoney(amount), FormatMoney(amount));
   		GameTextForPlayer(playerid, string, 5000, 1);

		Dialog_Show(playerid, Bill, DIALOG_STYLE_MSGBOX, "����稸�Ҥ��", "{FFFFFF}����: %s\n��¡��: �ҡ�Թ (Deposit)\n�ӹǹ: {00FF00} %s{FFFFFF}\n���� (Tax): -\n\n{FF6347}*�ô��Ǩ�ͺ��������´��͹ '�Դ'", "�Դ", "",
		GetPlayerNameEx(playerid), FormatMoney(amount));
	}
	return 1;
}
Dialog:ATM_Withdraw(playerid, response, listitem, inputtext[])
{
	new string[128], amount;
	if (response)
	{
		if (sscanf(inputtext, "d", amount))
			return Dialog_Show(playerid, ATM_Deposit, DIALOG_STYLE_INPUT, "�͹�Թ (Withdraw)", "{FFFFFF}�Թ���㹵��(Cash):{00FF00} %s {FFFFFF}| �Թ㹸�Ҥ��(Bank): {00FF00}%s{FFA84D}\n\
					�ô�кبӹǹ���س��ͧ��èж͹", "��ŧ", "��Ѻ",
					FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));

		if(amount < 1)
			return Dialog_Show(playerid, ATM_Deposit, DIALOG_STYLE_INPUT, "�͹�Թ (Withdraw)", "{FFFFFF}�Թ���㹵��(Cash):{00FF00} %s {FFFFFF}| �Թ㹸�Ҥ��(Bank): {00FF00}%s{FFA84D}\n\
					�ô�кبӹǹ���س��ͧ��èж͹ {FF6347}*�ӹǹ���س��ͧ��èж͹��ͧ�ҡ���� 0", "��ŧ", "��Ѻ",
					FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));
	
		if(amount > playerData[playerid][pBankMoney])
			return Dialog_Show(playerid, ATM_Deposit, DIALOG_STYLE_INPUT, "�͹�Թ (Withdraw)", "{FFFFFF}�Թ���㹵��(Cash):{00FF00} %s {FFFFFF}| �Թ㹸�Ҥ��(Bank): {00FF00}%s{FFA84D}\n\
					�ô�кبӹǹ���س��ͧ��èж͹ {FF6347}*�ӹ��ǹ�Թ�ͧ�س�������§��", "��ŧ", "��Ѻ",
					FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));
	
		playerData[playerid][pBankMoney] -= amount;
		GivePlayerMoneyEx(playerid, amount);	

		format(string, sizeof(string), "~r~-%s Bank~n~~g~+ %s Cash", FormatMoney(amount), FormatMoney(amount));
   		GameTextForPlayer(playerid, string, 5000, 1);

		Dialog_Show(playerid, Bill, DIALOG_STYLE_MSGBOX, "����稸�Ҥ��", "{FFFFFF}����: %s\n��¡��: �͹�Թ (Withdraw)\n�ӹǹ: {00FF00} %s{FFFFFF}\n���� (Tax): -\n\n{FF6347}*�ô��Ǩ�ͺ��������´��͹ '�Դ'", "�Դ", "",
		GetPlayerNameEx(playerid), FormatMoney(amount));
	}
	return 1;
}
Dialog:ATM_Transfer(playerid, response, listitem, inputtext[])
{
	new userid = strval(inputtext);
	if (response)
	{
		if (playerData[playerid][pHours] < 5)
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �س���繵�ͧ����ҡ���� 5 ��������͹�Ź�");

		if (playerData[userid][pHours] < 5)
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �����蹷��س��ͧ��è��͹�����繵�ͧ�ժ�������͹�Ź��ҡ���� 5 �������");

		if (userid == INVALID_PLAYER_ID)
		{
			return Dialog_Show(playerid, ATM_Transfer, DIALOG_STYLE_INPUT, "�͹�Թ (Transfer)", "{FFFFFF}�Թ���㹵��(Cash):{00FF00} %s {FFFFFF}| �Թ㹸�Ҥ��(Bank): {00FF00}%s{FFA84D}\n\
			�ô�к��ʹբͧ������ ���س��ͧ��è��͹�Թ��� {FF6347}*��辺�����蹷��س�к��͹�Ź�����", "��ŧ", "��Ѻ",
			FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));
		}

		if (userid == playerid)
		{
			return Dialog_Show(playerid, ATM_Transfer, DIALOG_STYLE_INPUT, "�͹�Թ (Transfer)", "{FFFFFF}�Թ���㹵��(Cash):{00FF00} %s {FFFFFF}| �Թ㹸�Ҥ��(Bank): {00FF00}%s{FFA84D}\n\
			�ô�к��ʹբͧ������ ���س��ͧ��è��͹�Թ��� {FF6347}*�������ö�͹�Թ������ͧ��", "��ŧ", "��Ѻ",
			FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));
		}

		ATMTransfer[playerid] = userid;
		return Dialog_Show(playerid, ATM_Transfer_User, DIALOG_STYLE_INPUT, "�͹�Թ (Transfer)", "{FFFFFF}�Թ���㹵��(Cash):{00FF00} %s {FFFFFF}| �Թ㹸�Ҥ��(Bank): {00FF00}%s{FFA84D}\n\
		�ô�кبӹǹ�Թ���س��ͧ��è��͹��� '(%d)%s", "��ŧ", "��Ѻ",
		FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]), userid, GetPlayerNameEx(userid));
	}
	return 1;
}


Dialog:ATM_Transfer_User(playerid, response, listitem, inputtext[])
{ 
	if (response)
	{
		new 
			string[128],
			amount = strval(inputtext), userid = ATMTransfer[playerid];

		if (amount > playerData[playerid][pBankMoney])
			return Dialog_Show(playerid, ATM_Transfer_User, DIALOG_STYLE_INPUT, "�͹�Թ (Transfer)", "{FFFFFF}�Թ���㹵��(Cash):{00FF00} %s {FFFFFF}| �Թ㹸�Ҥ��(Bank): {00FF00}%s{FFA84D}\n\
			�ô�кبӹǹ�Թ���س��ͧ��è��͹��� '(%d)%s\n{FF6347}�ӹǹ�Թ�ͧ�س�������§��", "��ŧ", "��Ѻ",
			FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]), userid, GetPlayerNameEx(userid));

		playerData[playerid][pBankMoney] -= amount;
		playerData[userid][pBankMoney] += amount;

		format(string, sizeof(string), "~r~-%s Bank", FormatMoney(amount));
   		GameTextForPlayer(playerid, string, 5000, 1);

		SendClientMessageEx(userid, COLOR_YELLOW, "[Bank]: �Թ����Һѭ�բͧ�س�繨ӹǹ '%s' �ҡ '%s'", FormatMoney(amount), GetPlayerNameEx(playerid));
		Dialog_Show(playerid, Bill, DIALOG_STYLE_MSGBOX, "����稸�Ҥ��", "{FFFFFF}���ͼ���͹: %s\n���ͼ���Ѻ:%s\n��¡��: �͹�Թ (Transfer)\n�ӹǹ: {00FF00} %s{FFFFFF}\n���� (Tax): -\n\n{FF6347}*�ô��Ǩ�ͺ��������´��͹ '�Դ'", "�Դ", "",
		GetPlayerNameEx(playerid), GetPlayerNameEx(userid), FormatMoney(amount));
	}
	return 1;
}




































/*
hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
		if (playertextid == ATM_WhatCity[playerid][22]) // �кبӹǹ�Թ
		{
			Dialog_Show(playerid, DIALOG_BANK_MONEY, DIALOG_STYLE_INPUT, "{646463}[ {C6C6C1}��س��кبӹǹ�Թ {646463}]", "{F97742}���й� : {FAC3AC}��س��кبӹǹ�Թ���س��ͧ��÷���¡��\n{0786CA}�����˵� : {A6F4FC}�س��ͧ�кبӹǹ�������Թ�ӹǹ�Թ���㹵�Ǣͧ�س", "��ŧ", "�͡");
		}
		if (playertextid == ATM_WhatCity[playerid][18]) // �׹�ѹ��÷���¡��
		{
			if (ATMType[playerid] == 0)
			    return ErrorMsg(playerid, "�س�ѧ��������͡��觷���ͧ��÷���¡��");

			if (ATMMoney[playerid] == 0)
			    return ErrorMsg(playerid, "�س�ѧ������кبӹǹ�Թ����ͧ��÷���¡��");

			switch (ATMType[playerid])
			{
			    case 1:
			    {
				    if (ATMMoney[playerid] > GetPlayerMoneyEx(playerid))
				        return ErrorMsg(playerid, "�س�ըӹǹ�Թ�����§��");

					Dialog_Show(playerid, DIALOG_BANK_CONFIRM, DIALOG_STYLE_MSGBOX, "{11C502}[ {A0F609}�׹�ѹ��÷���¡�� {11C502}]", "\
						{FA6239}��������÷���¡�� : {FDB7A5}�ҡ�Թ\n\
						{1FB8FA}�ӹǹ�Թ : {99DFFD}%s\n\
						{F6F209}�� '��ŧ' �����׹�ѹ��÷���¡�ô�ҹ����Թ", "��ŧ", "�͡", FormatMoney(ATMMoney[playerid]));
			    }
			    case 2:
			    {
				    if (ATMMoney[playerid] > playerData[playerid][pBankMoney])
				        return ErrorMsg(playerid, "��Ҥ�âͧ�س�ըӹǹ�Թ�����§��");

					Dialog_Show(playerid, DIALOG_BANK_CONFIRM, DIALOG_STYLE_MSGBOX, "{11C502}[ {A0F609}�׹�ѹ��÷���¡�� {11C502}]", "\
						{FA6239}��������÷���¡�� : {FDB7A5}�͹�Թ\n\
						{1FB8FA}�ӹǹ�Թ : {99DFFD}%s\n\
						{F6F209}�� '��ŧ' �����׹�ѹ��÷���¡�ô�ҹ����Թ", "��ŧ", "�͡", FormatMoney(ATMMoney[playerid]));
			    }
			    case 3:
			    {
				    if (ATMMoney[playerid] > playerData[playerid][pBankMoney])
				        return ErrorMsg(playerid, "��Ҥ�âͧ�س�ըӹǹ�Թ�����§��");

					Dialog_Show(playerid, DIALOG_BANK_TRANSFERID, DIALOG_STYLE_INPUT, "{FC582C}[ {FEBCAB}�к��ʹռ����蹷��س��ͧ����͹�Թ {FC582C}}]", "\
						{0591CD}���й� : {B7E8FD}�к��ʹռ����蹷��س��ͧ��è��͹�Թ���\n\
						{15E704}�ӹǹ�Թ : {D1FE79}%s\n\
						{696A66}�Ѵ� > {C2C3C0}�� '��ŧ' �����׹�ѹ��÷���¡�ô�ҹ����Թ", "��ŧ", "�͡", FormatMoney(ATMMoney[playerid]));
			    }
			}
		}
		if (playertextid == ATM_WhatCity[playerid][23]) // �Դ˹������ 'ATM'
		{
		    DestroyPlayerATM(playerid);
		}
	}
	return 1;
}





Dialog:DIALOG_BANK_CONFIRM(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch (ATMType[playerid])
		{
		    case 1:
		    {
			    new amount = ATMMoney[playerid];

			    if (ATMMoney[playerid] > GetPlayerMoneyEx(playerid))
			        return ErrorMsg(playerid, "�Թʴ�ͧ�س�ըӹǹ�Թ�����§��");

				playerData[playerid][pBankMoney] += amount;
			    GivePlayerMoneyEx(playerid, -amount);

			    SendClientMessageEx(playerid, -1, "{1F8DFC}��Ҥ�� :: {A2CEFA}�س��ӡ�ýҡ�Թ�ӹǹ {ffffff}%s {A2CEFA}��Ҹ�Ҥ��", FormatMoney(amount));
                DestroyPlayerATM(playerid);
			}
		    case 2:
		    {
			    new amount = ATMMoney[playerid];

			    if (ATMMoney[playerid] > playerData[playerid][pBankMoney])
			        return ErrorMsg(playerid, "��Ҥ�âͧ�س�ըӹǹ�Թ�����§��");

				playerData[playerid][pBankMoney] -= amount;
			    GivePlayerMoneyEx(playerid, amount);

			    SendClientMessageEx(playerid, -1, "{1F8DFC}��Ҥ�� :: {A2CEFA}�س��ӡ�ö͹�Թ�ӹǹ {ffffff}%s {A2CEFA}�ҡ��Ҥ��", FormatMoney(amount));
                DestroyPlayerATM(playerid);
			}
		    case 3:
		    {
			    new amount = ATMMoney[playerid], userid = ATMTransfer[playerid];

			    if (ATMMoney[playerid] > playerData[playerid][pBankMoney])
			        return ErrorMsg(playerid, "��Ҥ�âͧ�س�ըӹǹ�Թ�����§��");

				playerData[playerid][pBankMoney] -= amount;
				playerData[userid][pBankMoney] += amount;

			    SendClientMessageEx(playerid, -1, "{1F8DFC}��Ҥ�� :: {A2CEFA}�س��ӡ���͹�Թ�ӹǹ {ffffff}%s {A2CEFA}���Ѻ {ffffff}%s", FormatMoney(amount), GetPlayerMoneyEx(userid));
			    SendClientMessageEx(userid, -1, "{F15024}��Ҥ�� :: {FAB7A5}�س���Ѻ�Թ�͹�ӹǹ {ffffff}%s {FAB7A5}�ҡ {ffffff}%s", FormatMoney(amount), GetPlayerMoneyEx(playerid));
                DestroyPlayerATM(playerid);
			}
		}
	}
	return 1;
}
*/