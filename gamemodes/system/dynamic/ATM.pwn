#include	<YSI_Coding\y_hooks>

new ATMTransfer[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
	ATMTransfer[playerid] = 0;
}

CreatePlayerATM(playerid)
{
	new str[128];
    format(str, sizeof(str), "{FFFFFF}ยอดเงินในบัญชี: %s\n\
	{FFFFFF}- ฝากเงิน (Deposit)\n\
	- ถอนเงิน (Withdraw)\n\
	- โอนเงิน (Transfer)",
	FormatMoney(playerData[playerid][pBankMoney]));
    Dialog_Show(playerid, DIALOG_ATM, DIALOG_STYLE_TABLIST, "ธนาคาร (Bank)", str, "เลือก", "ยกเลิก" );
	return 1;
}
Dialog:DIALOG_ATM(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch(listitem)
		{
			case 1: return Dialog_Show(playerid, ATM_Deposit, DIALOG_STYLE_INPUT, "ฝากเงิน (Deposit)", "{FFFFFF}เงินภายในตัว(Cash):{00FF00} %s {FFFFFF}| เงินในธนาคาร(Bank): {00FF00}%s{FFA84D}\n\
			โปรดระบุจำนวนที่คุณต้องการจะฝาก", "ตกลง", "กลับ",
			FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));

			case 2: return Dialog_Show(playerid, ATM_Withdraw, DIALOG_STYLE_INPUT, "ถอนเงิน (Withdraw)", "{FFFFFF}เงินภายในตัว(Cash):{00FF00} %s {FFFFFF}| เงินในธนาคาร(Bank): {00FF00}%s{FFA84D}\n\
			โปรดระบุจำนวนที่คุณต้องการจะถอน", "ตกลง", "กลับ",
			FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));

			case 3: return Dialog_Show(playerid, ATM_Transfer, DIALOG_STYLE_INPUT, "โอนเงิน (Transfer)", "{FFFFFF}เงินภายในตัว(Cash):{00FF00} %s {FFFFFF}| เงินในธนาคาร(Bank): {00FF00}%s{FFA84D}\n\
			โปรดระบุไอดีของผู้เล่น ที่คุณต้องการจะโอนเงินให้", "ตกลง", "กลับ",
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
			return Dialog_Show(playerid, ATM_Deposit, DIALOG_STYLE_INPUT, "ฝากเงิน (Deposit)", "{FFFFFF}เงินภายในตัว(Cash):{00FF00} %s {FFFFFF}| เงินในธนาคาร(Bank): {00FF00}%s{FFA84D}\n\
					โปรดระบุจำนวนที่คุณต้องการจะฝาก", "ตกลง", "กลับ",
					FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));

		if(amount < 1)
			return Dialog_Show(playerid, ATM_Deposit, DIALOG_STYLE_INPUT, "ฝากเงิน (Deposit)", "{FFFFFF}เงินภายในตัว(Cash):{00FF00} %s {FFFFFF}| เงินในธนาคาร(Bank): {00FF00}%s{FFA84D}\n\
					โปรดระบุจำนวนที่คุณต้องการจะฝาก {FF6347}*จำนวนที่คุณต้องการจะฝากต้องมากกว่า 0", "ตกลง", "กลับ",
					FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));
	
		if(amount > GetPlayerMoneyEx(playerid))
			return Dialog_Show(playerid, ATM_Deposit, DIALOG_STYLE_INPUT, "ฝากเงิน (Deposit)", "{FFFFFF}เงินภายในตัว(Cash):{00FF00} %s {FFFFFF}| เงินในธนาคาร(Bank): {00FF00}%s{FFA84D}\n\
					โปรดระบุจำนวนที่คุณต้องการจะฝาก {FF6347}*จำนนนวนเงินของคุณมีไม่เพียงพอ", "ตกลง", "กลับ",
					FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));
	
		playerData[playerid][pBankMoney] += amount;
		GivePlayerMoneyEx(playerid, -amount);	

		format(string, sizeof(string), "~r~-%s Cash~n~~g~+ %s Bank", FormatMoney(amount), FormatMoney(amount));
   		GameTextForPlayer(playerid, string, 5000, 1);

		Dialog_Show(playerid, Bill, DIALOG_STYLE_MSGBOX, "ใบเสร็จธนาคาร", "{FFFFFF}ชื่อ: %s\nรายการ: ฝากเงิน (Deposit)\nจำนวน: {00FF00} %s{FFFFFF}\nภาษี (Tax): -\n\n{FF6347}*โปรดตรวจสอบรายละเอียดก่อน 'ปิด'", "ปิด", "",
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
			return Dialog_Show(playerid, ATM_Deposit, DIALOG_STYLE_INPUT, "ถอนเงิน (Withdraw)", "{FFFFFF}เงินภายในตัว(Cash):{00FF00} %s {FFFFFF}| เงินในธนาคาร(Bank): {00FF00}%s{FFA84D}\n\
					โปรดระบุจำนวนที่คุณต้องการจะถอน", "ตกลง", "กลับ",
					FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));

		if(amount < 1)
			return Dialog_Show(playerid, ATM_Deposit, DIALOG_STYLE_INPUT, "ถอนเงิน (Withdraw)", "{FFFFFF}เงินภายในตัว(Cash):{00FF00} %s {FFFFFF}| เงินในธนาคาร(Bank): {00FF00}%s{FFA84D}\n\
					โปรดระบุจำนวนที่คุณต้องการจะถอน {FF6347}*จำนวนที่คุณต้องการจะถอนต้องมากกว่า 0", "ตกลง", "กลับ",
					FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));
	
		if(amount > playerData[playerid][pBankMoney])
			return Dialog_Show(playerid, ATM_Deposit, DIALOG_STYLE_INPUT, "ถอนเงิน (Withdraw)", "{FFFFFF}เงินภายในตัว(Cash):{00FF00} %s {FFFFFF}| เงินในธนาคาร(Bank): {00FF00}%s{FFA84D}\n\
					โปรดระบุจำนวนที่คุณต้องการจะถอน {FF6347}*จำนนนวนเงินของคุณมีไม่เพียงพอ", "ตกลง", "กลับ",
					FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));
	
		playerData[playerid][pBankMoney] -= amount;
		GivePlayerMoneyEx(playerid, amount);	

		format(string, sizeof(string), "~r~-%s Bank~n~~g~+ %s Cash", FormatMoney(amount), FormatMoney(amount));
   		GameTextForPlayer(playerid, string, 5000, 1);

		Dialog_Show(playerid, Bill, DIALOG_STYLE_MSGBOX, "ใบเสร็จธนาคาร", "{FFFFFF}ชื่อ: %s\nรายการ: ถอนเงิน (Withdraw)\nจำนวน: {00FF00} %s{FFFFFF}\nภาษี (Tax): -\n\n{FF6347}*โปรดตรวจสอบรายละเอียดก่อน 'ปิด'", "ปิด", "",
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
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณจำเป็นต้องเล่นมากกว่า 5 ชั่วโมงออนไลน์");

		if (playerData[userid][pHours] < 5)
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นที่คุณต้องการจะโอนให้จำเป็นต้องมีชั่วโมงออนไลน์มากกว่า 5 ชั่วโมง");

		if (userid == INVALID_PLAYER_ID)
		{
			return Dialog_Show(playerid, ATM_Transfer, DIALOG_STYLE_INPUT, "โอนเงิน (Transfer)", "{FFFFFF}เงินภายในตัว(Cash):{00FF00} %s {FFFFFF}| เงินในธนาคาร(Bank): {00FF00}%s{FFA84D}\n\
			โปรดระบุไอดีของผู้เล่น ที่คุณต้องการจะโอนเงินให้ {FF6347}*ไม่พบผู้เล่นที่คุณระบุออนไลน์อยู่", "ตกลง", "กลับ",
			FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));
		}

		if (userid == playerid)
		{
			return Dialog_Show(playerid, ATM_Transfer, DIALOG_STYLE_INPUT, "โอนเงิน (Transfer)", "{FFFFFF}เงินภายในตัว(Cash):{00FF00} %s {FFFFFF}| เงินในธนาคาร(Bank): {00FF00}%s{FFA84D}\n\
			โปรดระบุไอดีของผู้เล่น ที่คุณต้องการจะโอนเงินให้ {FF6347}*ไม่สามารถโอนเงินให้ตัวเองได้", "ตกลง", "กลับ",
			FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));
		}

		ATMTransfer[playerid] = userid;
		return Dialog_Show(playerid, ATM_Transfer_User, DIALOG_STYLE_INPUT, "โอนเงิน (Transfer)", "{FFFFFF}เงินภายในตัว(Cash):{00FF00} %s {FFFFFF}| เงินในธนาคาร(Bank): {00FF00}%s{FFA84D}\n\
		โปรดระบุจำนวนเงินที่คุณต้องการจะโอนให้ '(%d)%s", "ตกลง", "กลับ",
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
			return Dialog_Show(playerid, ATM_Transfer_User, DIALOG_STYLE_INPUT, "โอนเงิน (Transfer)", "{FFFFFF}เงินภายในตัว(Cash):{00FF00} %s {FFFFFF}| เงินในธนาคาร(Bank): {00FF00}%s{FFA84D}\n\
			โปรดระบุจำนวนเงินที่คุณต้องการจะโอนให้ '(%d)%s\n{FF6347}จำนวนเงินของคุณมีไม่เพียงพอ", "ตกลง", "กลับ",
			FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]), userid, GetPlayerNameEx(userid));

		playerData[playerid][pBankMoney] -= amount;
		playerData[userid][pBankMoney] += amount;

		format(string, sizeof(string), "~r~-%s Bank", FormatMoney(amount));
   		GameTextForPlayer(playerid, string, 5000, 1);

		SendClientMessageEx(userid, COLOR_YELLOW, "[Bank]: เงินได้เข้าบัญชีของคุณเป็นจำนวน '%s' จาก '%s'", FormatMoney(amount), GetPlayerNameEx(playerid));
		Dialog_Show(playerid, Bill, DIALOG_STYLE_MSGBOX, "ใบเสร็จธนาคาร", "{FFFFFF}ชื่อผู้โอน: %s\nชื่อผู้รับ:%s\nรายการ: โอนเงิน (Transfer)\nจำนวน: {00FF00} %s{FFFFFF}\nภาษี (Tax): -\n\n{FF6347}*โปรดตรวจสอบรายละเอียดก่อน 'ปิด'", "ปิด", "",
		GetPlayerNameEx(playerid), GetPlayerNameEx(userid), FormatMoney(amount));
	}
	return 1;
}




































/*
hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
		if (playertextid == ATM_WhatCity[playerid][22]) // ระบุจำนวนเงิน
		{
			Dialog_Show(playerid, DIALOG_BANK_MONEY, DIALOG_STYLE_INPUT, "{646463}[ {C6C6C1}กรุณาระบุจำนวนเงิน {646463}]", "{F97742}คำแนะนำ : {FAC3AC}กรุณาระบุจำนวนเงินที่คุณต้องการทำรายการ\n{0786CA}หมายเหตุ : {A6F4FC}คุณต้องระบุจำนวนให้ไม่เกินจำนวนเงินภายในตัวของคุณ", "ตกลง", "ออก");
		}
		if (playertextid == ATM_WhatCity[playerid][18]) // ยืนยันการทำรายการ
		{
			if (ATMType[playerid] == 0)
			    return ErrorMsg(playerid, "คุณยังไม่ได้เลือกสิ่งที่ต้องการทำรายการ");

			if (ATMMoney[playerid] == 0)
			    return ErrorMsg(playerid, "คุณยังไม่ได้ระบุจำนวนเงินที่ต้องการทำรายการ");

			switch (ATMType[playerid])
			{
			    case 1:
			    {
				    if (ATMMoney[playerid] > GetPlayerMoneyEx(playerid))
				        return ErrorMsg(playerid, "คุณมีจำนวนเงินไม่เพียงพอ");

					Dialog_Show(playerid, DIALOG_BANK_CONFIRM, DIALOG_STYLE_MSGBOX, "{11C502}[ {A0F609}ยืนยันการทำรายการ {11C502}]", "\
						{FA6239}ประเภทการทำรายการ : {FDB7A5}ฝากเงิน\n\
						{1FB8FA}จำนวนเงิน : {99DFFD}%s\n\
						{F6F209}กด 'ตกลง' เพื่อยืนยันการทำรายการด้านการเงิน", "ตกลง", "ออก", FormatMoney(ATMMoney[playerid]));
			    }
			    case 2:
			    {
				    if (ATMMoney[playerid] > playerData[playerid][pBankMoney])
				        return ErrorMsg(playerid, "ธนาคารของคุณมีจำนวนเงินไม่เพียงพอ");

					Dialog_Show(playerid, DIALOG_BANK_CONFIRM, DIALOG_STYLE_MSGBOX, "{11C502}[ {A0F609}ยืนยันการทำรายการ {11C502}]", "\
						{FA6239}ประเภทการทำรายการ : {FDB7A5}ถอนเงิน\n\
						{1FB8FA}จำนวนเงิน : {99DFFD}%s\n\
						{F6F209}กด 'ตกลง' เพื่อยืนยันการทำรายการด้านการเงิน", "ตกลง", "ออก", FormatMoney(ATMMoney[playerid]));
			    }
			    case 3:
			    {
				    if (ATMMoney[playerid] > playerData[playerid][pBankMoney])
				        return ErrorMsg(playerid, "ธนาคารของคุณมีจำนวนเงินไม่เพียงพอ");

					Dialog_Show(playerid, DIALOG_BANK_TRANSFERID, DIALOG_STYLE_INPUT, "{FC582C}[ {FEBCAB}ระบุไอดีผู้เล่นที่คุณต้องการโอนเงิน {FC582C}}]", "\
						{0591CD}คำแนะนำ : {B7E8FD}ระบุไอดีผู้เล่นที่คุณต้องการจะโอนเงินให้\n\
						{15E704}จำนวนเงิน : {D1FE79}%s\n\
						{696A66}ถัดไป > {C2C3C0}กด 'ตกลง' เพื่อยืนยันการทำรายการด้านการเงิน", "ตกลง", "ออก", FormatMoney(ATMMoney[playerid]));
			    }
			}
		}
		if (playertextid == ATM_WhatCity[playerid][23]) // ปิดหน้าเมนู 'ATM'
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
			        return ErrorMsg(playerid, "เงินสดของคุณมีจำนวนเงินไม่เพียงพอ");

				playerData[playerid][pBankMoney] += amount;
			    GivePlayerMoneyEx(playerid, -amount);

			    SendClientMessageEx(playerid, -1, "{1F8DFC}ธนาคาร :: {A2CEFA}คุณได้ทำการฝากเงินจำนวน {ffffff}%s {A2CEFA}เข้าธนาคาร", FormatMoney(amount));
                DestroyPlayerATM(playerid);
			}
		    case 2:
		    {
			    new amount = ATMMoney[playerid];

			    if (ATMMoney[playerid] > playerData[playerid][pBankMoney])
			        return ErrorMsg(playerid, "ธนาคารของคุณมีจำนวนเงินไม่เพียงพอ");

				playerData[playerid][pBankMoney] -= amount;
			    GivePlayerMoneyEx(playerid, amount);

			    SendClientMessageEx(playerid, -1, "{1F8DFC}ธนาคาร :: {A2CEFA}คุณได้ทำการถอนเงินจำนวน {ffffff}%s {A2CEFA}จากธนาคาร", FormatMoney(amount));
                DestroyPlayerATM(playerid);
			}
		    case 3:
		    {
			    new amount = ATMMoney[playerid], userid = ATMTransfer[playerid];

			    if (ATMMoney[playerid] > playerData[playerid][pBankMoney])
			        return ErrorMsg(playerid, "ธนาคารของคุณมีจำนวนเงินไม่เพียงพอ");

				playerData[playerid][pBankMoney] -= amount;
				playerData[userid][pBankMoney] += amount;

			    SendClientMessageEx(playerid, -1, "{1F8DFC}ธนาคาร :: {A2CEFA}คุณได้ทำการโอนเงินจำนวน {ffffff}%s {A2CEFA}ให้กับ {ffffff}%s", FormatMoney(amount), GetPlayerMoneyEx(userid));
			    SendClientMessageEx(userid, -1, "{F15024}ธนาคาร :: {FAB7A5}คุณได้รับเงินโอนจำนวน {ffffff}%s {FAB7A5}จาก {ffffff}%s", FormatMoney(amount), GetPlayerMoneyEx(playerid));
                DestroyPlayerATM(playerid);
			}
		}
	}
	return 1;
}
*/