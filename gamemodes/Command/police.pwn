#include	<YSI_Coding\y_hooks>

#define TASER_WEAPON 		(23)
#define STATE_PENDING_HIT       1
#define STATE_WAIT_HIT          0
#define ISSUE_HIT_DELAY         300

new
	bool:TazerActive[MAX_PLAYERS char],
	bool:BeanbagActive[MAX_PLAYERS char];

new IssueTimer[MAX_PLAYERS];
new DamageStatus[MAX_PLAYERS];








hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{

	new targetplayer = GetPlayerTargetPlayer(playerid);


	if (newkeys & KEY_HANDBRAKE && targetplayer != INVALID_PLAYER_ID && newkeys & KEY_NO && IsPlayerNearPlayer(playerid, targetplayer, 3.0))
	{
		if (GetFactionType(playerid) == FACTION_POLICE)
		{
            if (!playerData[playerid][pOnDuty])
                return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถใช้เมนูเจ้าหน้าที่ได้ เนื่องจากคุณยังไม่ได้ On Duty");

			Dialog_Show(playerid, POLICE_MENU, DIALOG_STYLE_LIST, "เมนูเจ้าหน้าที่ 'ตำรวจ'", "{FFFFFF}ชื่อ: %s\n\
			- Cuff (ล็อค)\n\
			- Uncuff (ปลดล็อค)\n\
			- Drag (ลาก/ปล่อยลาก)\n\
			- Frisk (ค้นตัว)\n\
			- Ticket (ใบสั่ง)", "เลือก", "ยกเลิก", GetPlayerNameEx(targetplayer));
		}
		playerData[playerid][pFactionMenuID] = targetplayer;
		return 1;
	}
	return 1;
}


CMD:m(playerid, params[])
{
	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_WHITE, "/m [ข้อความ]");

	if (strlen(params) > 100) {
	    SendNearbyMessage(playerid, 20.0, COLOR_YELLOW, "%s โทรโข่ง : %.100s", GetPlayerNameEx(playerid), params);
	    SendNearbyMessage(playerid, 20.0, COLOR_YELLOW, "...%s", params[100]);
	}
	else {
	    SendNearbyMessage(playerid, 20.0, COLOR_YELLOW, "%s โทรโข่ง : %s", GetPlayerNameEx(playerid), params);
	}
	return 1;
}

Dialog:POLICE_MENU(playerid, response, listitem, inputtext[])
{
	new targetplayer = playerData[playerid][pFactionMenuID];
	if (response)
	{
		switch(listitem)
		{
			case 1: // cuff
			{
				if (targetplayer == INVALID_PLAYER_ID)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาไม่ได้อยู่ในสถานะปกติ");

				if (targetplayer == playerid)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถดำเนินการใดๆ ต่อตนเองได้");

				if (GetPlayerState(targetplayer) != PLAYER_STATE_ONFOOT)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาต้องไม่อยู่บนยานพาหนะ");

				if (!IsPlayerNearPlayer(playerid, targetplayer, 5.0))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาไม่ได้อยู่ใกล้คุณ");

				if (playerData[targetplayer][pCuffed])
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาถูกใส่กุญแจมืออยู่แล้ว");

				playerData[targetplayer][pCuffed] = 1;

				TogglePlayerControllable(targetplayer, false);
				SetPlayerSpecialAction(targetplayer, SPECIAL_ACTION_CUFFED);
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ใส่กุญแจมือของ %s สำเร็จ", GetPlayerNameEx(playerid), GetPlayerNameEx(targetplayer));
				SetPlayerAttachedObject(targetplayer,7,19418,6,0.012999,0.044999,-0.015999,-3.699999,-2.000000,93.399963,1.000000,1.000000,1.000000);
			}
			case 2: // uncuff
			{
				if (targetplayer == INVALID_PLAYER_ID)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาไม่ได้อยู่ในสถานะปกติ");

				if (targetplayer == playerid)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถดำเนินการใดๆ ต่อตนเองได้");

				if (GetPlayerState(targetplayer) != PLAYER_STATE_ONFOOT)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาต้องไม่อยู่บนยานพาหนะ");

				if (!IsPlayerNearPlayer(playerid, targetplayer, 5.0))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาไม่ได้อยู่ใกล้คุณ");

				if (!playerData[targetplayer][pCuffed])
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาไม่ได้ถูกถูกใส่กุญแจมืออยู่แล้ว");

				playerData[targetplayer][pCuffed] = 0;

				TogglePlayerControllable(targetplayer, true);
				SetPlayerSpecialAction(targetplayer, SPECIAL_ACTION_NONE);
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ปลดกุญแจมือของ %s ", GetPlayerNameEx(playerid), GetPlayerNameEx(targetplayer));
				RemovePlayerAttachedObject(targetplayer, 7);
			}
			case 3: // drag
			{
				if (targetplayer == INVALID_PLAYER_ID)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาไม่ได้อยู่ในสถานะปกติ");

				if (targetplayer == playerid)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถดำเนินการใดๆ ต่อตนเองได้");

				if (GetPlayerState(targetplayer) != PLAYER_STATE_ONFOOT)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาต้องไม่อยู่บนยานพาหนะ");

				if (!IsPlayerNearPlayer(playerid, targetplayer, 5.0))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาไม่ได้อยู่ใกล้คุณ");

				if (playerData[targetplayer][pDragged])
				{
					playerData[targetplayer][pDragged] = 0;
					playerData[targetplayer][pDraggedBy] = INVALID_PLAYER_ID;

					KillTimer(playerData[targetplayer][pDragTimer]);
					SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ปล่อยตัว %s", GetPlayerNameEx(playerid), GetPlayerNameEx(targetplayer));
				}
				else
				{
					playerData[targetplayer][pDragged] = 1;
					playerData[targetplayer][pDraggedBy] = playerid;

					playerData[targetplayer][pDragTimer] = SetTimerEx("DragUpdate", 200, true, "dd", playerid, targetplayer);
					SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้คว้าตัว %s", GetPlayerNameEx(playerid), GetPlayerNameEx(targetplayer));
				}
			}
			case 4: // Frisk
			{
				if (targetplayer == INVALID_PLAYER_ID)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาไม่ได้อยู่ในสถานะปกติ");

				if (targetplayer == playerid)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถดำเนินการใดๆ ต่อตนเองได้");

				if (GetPlayerState(targetplayer) != PLAYER_STATE_ONFOOT)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาต้องไม่อยู่บนยานพาหนะ");

				if (!IsPlayerNearPlayer(playerid, targetplayer, 5.0))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาไม่ได้อยู่ใกล้คุณ");

				if (!playerData[targetplayer][pCuffed])
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาไม่ได้ถูกถูกใส่กุญแจมือ");

				FriskInventory3(playerid, targetplayer);
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ค้นตัว %s", GetPlayerNameEx(playerid), GetPlayerNameEx(targetplayer));
				return 1;
			} 
			case 5: // Ticket
			{
				if (targetplayer == INVALID_PLAYER_ID)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาไม่ได้อยู่ในสถานะปกติ");

				if (targetplayer == playerid)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถดำเนินการใดๆ ต่อตนเองได้");

				if (GetPlayerState(targetplayer) != PLAYER_STATE_ONFOOT)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาต้องไม่อยู่บนยานพาหนะ");

				if (!IsPlayerNearPlayer(playerid, targetplayer, 5.0))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้ต้องหาไม่ได้อยู่ใกล้คุณ");

				Dialog_Show(playerid, DIALOG_FINECASH, DIALOG_STYLE_INPUT, "Ticket", "โปรดระบุจำนวนเงินที่คุณต้องการจะปรับ :", "ตกลง", "ยกเลิก");
				return 1;
			} 
		}
	}
	return 1;
}
Dialog:DIALOG_FINECASH(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new userid = strval(inputtext);

		if (userid <= 0)
		    return SendClientMessage(playerid, COLOR_GREY, "* คุณต้องระบุจำนวนมากกว่า 0");

		Dialog_Show(playerid, DIALOG_FINETEXT, DIALOG_STYLE_INPUT, "Ticket", "{FFFFFF}ชื่อ: {FFA84D}%s\n{FFFFFF}โปรดระบุสาเหตุที่ผู้ต้องสงใสกระทำผิด :", "ตกลง", "ยกเลิก", GetPlayerNameEx(userid));
		finePrice[playerid] = userid;
	}
	return 1;
}
Dialog:DIALOG_FINETEXT(playerid, response, listitem, inputtext[])
{
	new string[128];
	if (response)
	{
        format(fineText[playerid], 64, inputtext);

		format(string, 128, "%d %d %s", fineID[playerid], finePrice[playerid], inputtext);
		callcmd::ticket(playerid, string);
	}
	return 1;
}

alias:ticket("ปรับเงิน")
CMD:ticket(playerid, params[])
{
	new
		userid,
	    amount;
	new factionid = playerData[playerid][pFaction];

	if (GetFactionType(playerid) != FACTION_POLICE)
	    return 1;

	if (sscanf(params, "uds[128]", userid, amount))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "การใช้งาน : {FFFFFF}/ticket [ไอดีผู้เล่น/ชื่อตัวละคร] [จำนวนเงิน]");

	if (amount > 100000)
	    return ErrorMsg(playerid, "กรุณาใส่ค่าปรับที่น้อยกว่า $100,000 ");

    if (GetPlayerMoneyEx(userid) < amount)
    	return ErrorMsg(playerid, "ผู้เล่นมีเงินไม่เพียงพอสำหรับการจ่ายค่าปรับ");

	if (userid == INVALID_PLAYER_ID)
	    return ErrorMsg(playerid, "ผู้เล่นที่ระบุไม่ถูกต้อง");

	factionData[factionid][factionTreasury] += amount;
	GivePlayerMoneyEx(userid, -amount);
	Faction_SaveTreasury(factionid);
	SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้เขียน Ticket ให้กับ %s เป็นจำนวนเงิน", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	return 1;
}



/* ----------------------------------------------------------------------------------------------------------------- */


/*
CMD:police(playerid, params[])
{
	if (GetFactionType(playerid) == FACTION_POLICE)
	return Dialog_Show(playerid, DIALOG_POLICE, DIALOG_STYLE_LIST, "{01C9FA}[ {B1EEFC}เมนูสำหรับตำรวจ {01C9FA}]", "{FFFFFF}+ ใส่กุญแจมือ\n+ ค้นตัว\n+ ยึดของผิดกฎหมาย\n+ ค้นรถส่วนตัว\n+ ปลดกุญแจมือ\n+ ลาก\n+ ลากขึ้น/ลงรถ\n+ ปรับเงิน\n+ ปืนช็อตไฟฟ้า\n+ ค้นหา", "ตกลง", "ยกเลิก");
}*/
CMD:Acuff(playerid, params[]) {

	if(GetFactionType(playerid) != FACTION_POLICE)
	    return 1;

	if (!playerData[playerid][pOnDuty])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถใช้ได้ เนื่องจากคุณยังไม่ได้ On Duty");

	if(GetPVarType(playerid, "TacklingMode")) {
		SendClientMessage(playerid, COLOR_YELLOW, "- คุณได้ปิดโหมดการเข้าปะทะ");
		DeletePVar(playerid, "TacklingMode");
	}
	else {
		SendClientMessage(playerid, COLOR_YELLOW, "- คุณได้เปิดโหมดการเข้าปะทะ (ต่อยที่ผู้เล่นเพื่อชาร์จ)");
		SetPVarInt(playerid, "TacklingMode", 1);
	}
	return 1;
}
forward AC_SetPlayerArmour(playerid,Float:armour);
public AC_SetPlayerArmour(playerid,Float:armour)
{
	playerData[playerid][pArmour]=armour;
	SetPlayerArmour(playerid,armour);
    return 1;
}
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    new Float:health;


    GetPlayerHealth(playerid,health);
	if(weaponid == TASER_WEAPON)
	{
		/*if(taser[issuerid])
		{

		}*/
		GetPlayerHealth(playerid, health);
		SetPlayerHealth(playerid, health-2);
	}
	if(!IsPlayerNPC(playerid))
    {
        if(!playerData[playerid][pInjured] && !IsAFK{playerid} && 1 <= weaponid <= 46)
        {

            new Float:hp, Float:armour;
            GetPlayerHealth(playerid, hp);
            GetPlayerArmour(playerid, armour);


			/*if(playerData[playerid][HealthCheck] && weaponid != 41 && weaponid != 42)
			{
                playerData[playerid][HealthCheck] = 0;
                if(playerData[playerid][HealthLock] == hp)
                {
                    //playerData[playerid][pWarningCheat] += 3;
                    SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ต้องสงสัย health lock (%.2f==%.2f) ", ReturnRealName(playerid, 0), playerData[playerid][HealthLock], hp);

					if(playerData[playerid][pWarningCheat] >= 9)
					{
					    SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ถูกแบนเนื่องจาก health lock (%.2f==%.2f)", ReturnRealName(playerid, 0), playerData[playerid][HealthLock], hp);
						Log_Write("logs/cheat_log.txt", "[%s] %s was banned for health lock (%.2f==%.2f).", ReturnDate(), ReturnRealName(playerid), playerData[playerid][HealthLock], hp);

						Blacklist_Add(playerData[playerid][pIP], playerData[playerid][pUsername], "Anticheat", "Health lock");
						Kick(playerid);
						return 0;
					}
				}
			}
			if(playerData[playerid][ArmorCheck] && weaponid != 41 && weaponid != 42)
			{
                playerData[playerid][ArmorCheck] = 0;
                if(playerData[playerid][ArmorLock] == armour)
                {
                    //playerData[playerid][pWarningCheat] += 3;
                    SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ต้องสงสัย armor lock (%.2f==%.2f)", ReturnRealName(playerid, 0), playerData[playerid][ArmorLock], armour);
                    if(playerData[playerid][pWarningCheat] >= 9)
					{
					    SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ถูกแบนเนื่องจาก armor lock (%.2f==%.2f)", ReturnRealName(playerid, 0), playerData[playerid][ArmorLock], armour);
						Log_Write("logs/cheat_log.txt", "[%s] %s was banned for health lock (%.2f==%.2f).", ReturnDate(), ReturnRealName(playerid), playerData[playerid][ArmorLock], armour);

						Blacklist_Add(playerData[playerid][pIP], playerData[playerid][pUsername], "Anticheat", "Armor lock");
						Kick(playerid);
						return 0;
					}
				}
			}*/

            GetPlayerHealth(playerid, playerData[playerid][pHealth]);
            GetPlayerArmour(playerid, playerData[playerid][pArmour]);


		    if(issuerid != INVALID_PLAYER_ID) // If not self-inflicted
		    {
		        if (GetFactionType(issuerid) == FACTION_POLICE && weaponid == 23) {

		            SetPlayerHealth(playerid, (hp));
                    amount = 0;
		           	return 1;
		        }
		    }

            if(hp > 0.0)
            {
                if(DamageStatus[playerid] == STATE_PENDING_HIT)
                {
                    DamageStatus[playerid] = STATE_WAIT_HIT;
                    KillTimer(IssueTimer[playerid]);
                }
			}
		}
	}

	if(issuerid != INVALID_PLAYER_ID)
	{
		if(GetPVarType(issuerid, "TacklingMode") && weaponid == 0) {
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s วิ่งไปล็อค %s และกดลงกับพื้น", GetPlayerNameEx(issuerid), GetPlayerNameEx(playerid));
			ApplyAnimation(issuerid, "PED", "EV_dive",4.1,0,1,1,0,0);
			ApplyAnimation(playerid, "PED", "FLOOR_hit_f",4.1,0,1,1,0,0);

			DeletePVar(issuerid, "TacklingMode");
			SetPlayerAttachedObject(playerid,7,19418,6,0.012999,0.044999,-0.015999,-3.699999,-2.000000,93.399963,1.000000,1.000000,1.000000);

			playerData[playerid][pCuffed] = 1;
			TogglePlayerControllable(playerid, false);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CUFFED);
			return 0;
		}
		return false;
	}
    return true;
}




CMD:taser(playerid, params[])
{

	if (GetFactionType(playerid) != FACTION_POLICE)
		return 1;

	if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT || !IsPlayerSpawnedEx(playerid))
	    return 1;

	if (!playerData[playerid][pOnDuty])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถใช้ได้ เนื่องจากคุณยังไม่ได้ On Duty");

	if (playerData[playerid][pTazer] == 1)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถใช้งานได้ใน");

	if(TazerActive{playerid})
	{
		TazerActive{playerid} = false;
		playerUseTazer[playerid] = 0;
		GivePlayerWeaponEx(playerid, 24, 50);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s เก็บปืนไฟฟ้าเทเซอร์ของเขาเข้าไปในซองหนัง", GetPlayerNameEx(playerid));
		ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.0, 0, 0, 0, 0, 0, 1);

	}
	else
	{
		TazerActive{playerid} = true;
		GivePlayerWeaponEx(playerid, TASER_WEAPON, 1);
		playerUseTazer[playerid] = 1;
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s คว้าปืนไฟฟ้าเทเซอร์ออกมาจากซองหนัง", ReturnPlayerName(playerid));
		ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.0, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}
CMD:Beanbag(playerid, params[])
{
	if (GetFactionType(playerid) != FACTION_POLICE)
		return 1;

	if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT || !IsPlayerSpawnedEx(playerid))
	    return 1;

	if (!playerData[playerid][pOnDuty])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถใช้ได้ เนื่องจากคุณยังไม่ได้ On Duty");

	if(BeanbagActive{playerid})
	{
		BeanbagActive{playerid} = false;
		//SetPlayerArmedWeapon(playerid, 0);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s บรรจุกระสุนกระจาย ในปืนเรมิงตัน 870", ReturnPlayerName(playerid));
	}
	else if(GetPlayerWeapon(playerid) == 25)
	{
		BeanbagActive{playerid} = true;
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s บรรจุกระสุนยาง ในปืนเรมิงตัน 870", ReturnPlayerName(playerid));
	}
	else return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณจำเป็นต้องมี Remington 870 ในมือเพื่อให้ได้ใช้กระสุนยาง");

	if( GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK ) 
		ApplyAnimation(playerid, "BUDDY", "buddy_reload", 4.0, 0, 0, 0, 0, 0, 1);
	else ApplyAnimation(playerid, "BUDDY", "buddy_crouchreload", 4.0, 0, 1, 1, 0, 0, 1);
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if((BeanbagActive{playerid} == true && weaponid == 25) || (TazerActive{playerid} == true && weaponid == 23))
	{
		if(weaponid == 23) 
		{
			SetTimerEx("SetUnTazed", 10000, 0, "i", playerid);
			playerData[playerid][pTazer] = 0;
			if( GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK ) 
				ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.0, 0, 0, 0, 0, 0, 1);
			else ApplyAnimation(playerid, "COLT45", "colt45_crouchreload", 4.0, 0, 1, 1, 0, 0, 1);
		}
		else if(weaponid == 25) 
		{
			if( GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK ) 
				ApplyAnimation(playerid, "BUDDY", "buddy_reload", 4.0, 0, 0, 0, 0, 0, 1);
			else ApplyAnimation(playerid, "BUDDY", "buddy_crouchreload", 4.0, 0, 1, 1, 0, 0, 1);
		}
	}

    if(weaponid != 0 && weaponid != 46)
    {
        if(GetPlayerAmmo(playerid) <= 1) gPlayerWeaponData[playerid][weaponid] = false;
    }
    return 1;
}
forward SetUnTazed(playerid);
public SetUnTazed(playerid)
{
	ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.0, 0, 0, 0, 0, 0, 1);
    playerData[playerid][pTazer] = 0;
	GivePlayerWeaponEx(playerid, 23, 1);
	return 1;
}


Dialog:DIALOG_TrunkPolice(playerid, response, listitem, inputtext[])
{
	new Msg[128];
	if(response)
	{
		switch(listitem)
  		{
			case 0: //Desert
			{
				ResetPlayerWeaponsEx(playerid);
				GivePlayerWeaponEx(playerid, 24, 50);
				format(Msg, sizeof(Msg), "** %s หยิบอาวุธจาก Trunk", GetPlayerNameEx(playerid));
				SetPlayerChatBubble(playerid, Msg, COLOR_PURPLE, 10.0, 5000);
				ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.0, 0, 0, 0, 0, 0, 1);
				return 1;
			}
			case 1: //M4
			{
				ResetPlayerWeaponsEx(playerid);
				GivePlayerWeaponEx(playerid, 31, 100);
				format(Msg, sizeof(Msg), "** %s หยิบอาวุธจาก Trunk", GetPlayerNameEx(playerid));
				SetPlayerChatBubble(playerid, Msg, COLOR_PURPLE, 10.0, 5000);
				ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.0, 0, 0, 0, 0, 0, 1);
				return 1;
			}
		}
	}
	return 1;
}

// เมนูตำรวจ
Dialog:DIALOG_POLICE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
  		{
			case 0:
			{
				new string[1000], var[15], count;
				foreach(new i : Player)
				{
				    if (i == playerid) continue;
					if (IsPlayerNearPlayer(playerid, i, 5.0))
					{
						format(string, sizeof(string), "[ID: %d]\t%s\n", i, GetPlayerNameEx(i));
						format(var, sizeof(var), "PID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่มีใครอยู่รอบ ๆ คุณเลย");
					return 1;
				}
				Dialog_Show(playerid, DIALOG_CUFFID, DIALOG_STYLE_TABLIST, "[ใส่กุญแจมือ]", string, "เลือก", "ปิด");
			}
			case 1:
			{
				new string[1000], var[15], count;
				foreach(new i : Player)
				{
				    if (i == playerid) continue;
					if (IsPlayerNearPlayer(playerid, i, 5.0))
					{
						format(string, sizeof(string), "[ID: %d]\t%s\n", i, GetPlayerNameEx(i));
						format(var, sizeof(var), "PID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่มีใครอยู่รอบ ๆ คุณเลย");
					return 1;
				}
				Dialog_Show(playerid, DIALOG_FRISKID, DIALOG_STYLE_TABLIST, "[ค้นตัว]", string, "เลือก", "ปิด");
			}
			case 2:
			{
				new string[1000], var[15], count;
				foreach(new i : Player)
				{
				    if (i == playerid) continue;
					if (IsPlayerNearPlayer(playerid, i, 5.0))
					{
						format(string, sizeof(string), "[ID: %d]\t%s\n", i, GetPlayerNameEx(i));
						format(var, sizeof(var), "PID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่มีใครอยู่รอบ ๆ คุณเลย");
					return 1;
				}
				Dialog_Show(playerid, DIALOG_TAKEID, DIALOG_STYLE_TABLIST, "[ยึดของผิดกฎหมาย]", string, "เลือก", "ปิด");
			}
			case 3:
			{
			    //callcmd::vfrisk(playerid, "\1");
			}
			case 4:
			{
				new string[1000], var[15], count;
				foreach(new i : Player)
				{
				    if (i == playerid) continue;
					if (IsPlayerNearPlayer(playerid, i, 5.0))
					{
						format(string, sizeof(string), "[ID: %d]\t%s\n", i, GetPlayerNameEx(i));
						format(var, sizeof(var), "PID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่มีใครอยู่รอบ ๆ คุณเลย");
					return 1;
				}
				Dialog_Show(playerid, DIALOG_UNCUFFID, DIALOG_STYLE_TABLIST, "[ปลดกุญแจมือ]", string, "เลือก", "ปิด");
			}
			case 5:
			{
				new string[1000], var[15], count;
				foreach(new i : Player)
				{
				    if (i == playerid) continue;
					if (IsPlayerNearPlayer(playerid, i, 5.0))
					{
						format(string, sizeof(string), "[ID: %d]\t%s\n", i, GetPlayerNameEx(i));
						format(var, sizeof(var), "PID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่มีใครอยู่รอบ ๆ คุณเลย");
					return 1;
				}
				Dialog_Show(playerid, DIALOG_DRAGID, DIALOG_STYLE_TABLIST, "[ลาก]", string, "เลือก", "ปิด");
			}
			case 6:
			{
				new string[1000], var[15], count;
				foreach(new i : Player)
				{
				    if (i == playerid) continue;
					if (IsPlayerNearPlayer(playerid, i, 5.0))
					{
						format(string, sizeof(string), "[ID: %d]\t%s\n", i, GetPlayerNameEx(i));
						format(var, sizeof(var), "PID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่มีใครอยู่รอบ ๆ คุณเลย");
					return 1;
				}
				Dialog_Show(playerid, DIALOG_DETAINID, DIALOG_STYLE_TABLIST, "[ลากขึ้น/ลงรถ]", string, "เลือก", "ปิด");
			}
			case 7: // ปรับเงิน
			{
                Dialog_Show(playerid, DIALOG_FINEID, DIALOG_STYLE_INPUT, "[ปรับเงิน]", "กรุณาระบุไอดีผู้เล่นที่คุณต้องการจะปรับเงิน :", "เลือก", "ปิด");
			}
			case 8:
			{
			    callcmd::taser(playerid, "\1");
			}
			case 9:
			{
			    Dialog_Show(playerid, DIALOG_CHMID, DIALOG_STYLE_INPUT, "[ค้นหา]", "กรุณาระบุไอดีผู้เล่นที่คุณต้องการจะค้นหา :", "เลือก", "ปิด");
			}
		}
	}
	return 1;
}


Dialog:DIALOG_UNCUFFID(playerid, response, listitem, inputtext[]) // ปลดล็อคกุญแจมือ
{
	if (response)
	{
		new string[256], var[15];
		format(var, sizeof(var), "PID%d", listitem);
		new userid = GetPVarInt(playerid, var);

		format(string, 16, "%d", userid);
		callcmd::uncuff(playerid, string);
	}
	return 1;
}

Dialog:DIALOG_CUFFID(playerid, response, listitem, inputtext[]) // ใส่กุญแจมือ
{
	if (response)
	{
		new string[256], var[15];
		format(var, sizeof(var), "PID%d", listitem);
		new userid = GetPVarInt(playerid, var);

		format(string, 16, "%d", userid);
		callcmd::cuff(playerid, string);
	}
	return 1;
}

Dialog:DIALOG_FRISKID(playerid, response, listitem, inputtext[]) // ค้นหาของผิดกฎหมาย
{
	if (response)
	{
		new string[256], var[15];
		format(var, sizeof(var), "PID%d", listitem);
		new userid = GetPVarInt(playerid, var);

		format(string, 16, "%d", userid);
		callcmd::frisk(playerid, string);
	}
	return 1;
}

Dialog:DIALOG_TAKEID(playerid, response, listitem, inputtext[]) // ยึดของผิดกฎหมาย
{
	if (response)
	{
		new string[256], var[15];
		format(var, sizeof(var), "PID%d", listitem);
		new userid = GetPVarInt(playerid, var);

		format(string, 16, "%d", userid);
		callcmd::frisk(playerid, string);
	}
	return 1;
}

Dialog:DIALOG_DRAGID(playerid, response, listitem, inputtext[]) // ลาก
{
	if (response)
	{
		new string[256], var[15];
		format(var, sizeof(var), "PID%d", listitem);
		new userid = GetPVarInt(playerid, var);

		format(string, 16, "%d", userid);
		callcmd::drag(playerid, string);
	}
	return 1;
}
/*
Dialog:DIALOG_DETAINID(playerid, response, listitem, inputtext[]) // ลากขึ้นรถ
{
	if (response)
	{
		new string[256], var[15];
		format(var, sizeof(var), "PID%d", listitem);
		new userid = GetPVarInt(playerid, var);

		format(string, 16, "%d", userid);
		callcmd::detain(playerid, string);
	}
	return 1;
}

Dialog:DIALOG_CHMID(playerid, response, listitem, inputtext[]) // ค้นหา
{
	if (response)
	{
		new userid = strval(inputtext), string[16];

  		format(string, 16, "%d", userid);
		callcmd::chm(playerid, string);
	}
	return 1;
}
*/
/*
CMD:suspect(playerid, params[])
{
    new
	    userid,
		crime[32];

	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

	if (sscanf(params, "us[32]", userid, crime))
	    return SendClientMessage(playerid, COLOR_WHITE, "(/su)spect [ไอดี/ชื่อ] [ข้อหา]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถยัดดาวให้ตัวเองได้");

	if (GetFactionType(userid) == FACTION_POLICE || GetFactionType(userid) == FACTION_MEDIC || GetFactionType(userid) == FACTION_GOV)
        return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถยัดดาวให้กับหน่วยงานรัฐได้");

    GivePlayerWanted(userid, 1);

	SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ยัดคดีความให้กับ {33CCFF}%s {FFFFFF}ข้อหา: %s", GetPlayerNameEx(userid), crime);
	SendClientMessageEx(userid, COLOR_WHITE, "เจ้าหน้าที่ {33CCFF}%s {FFFFFF}ได้ยัดคดีให้คุณ ข้อหา: %s", GetPlayerNameEx(playerid), crime);
    return 1;
}
alias:suspect("1")
*/




CMD:cuff(playerid, params[])
{
    new
	    userid;

	if (GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/cuff [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถใส่กุญแจมือให้ตัวเองได้");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ต้องไม่อยู่ในยานพาหนะ");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");

    if (playerData[userid][pCuffed])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ถูกใส่กุญแจมืออยู่");

    playerData[userid][pCuffed] = 1;

	TogglePlayerControllable(userid, false);
	SetPlayerSpecialAction(userid, SPECIAL_ACTION_CUFFED);
	SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ใส่กุญแจมือของ %s สำเร็จ", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	SetPlayerAttachedObject(userid,7,19418,6,0.012999,0.044999,-0.015999,-3.699999,-2.000000,93.399963,1.000000,1.000000,1.000000);
    return 1;
}



CMD:uncuff(playerid, params[])
{
    new
	    userid;

	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/uncuff [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถปลดกุญแจมือให้ตัวเองได้");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");

    if (!playerData[userid][pCuffed])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ไม่ได้ถูกใส่กุญแจมือ");

    playerData[userid][pCuffed] = 0;

	TogglePlayerControllable(userid, true);
	SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);
	SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ปลดกุญแจมือของ %s ", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	RemovePlayerAttachedObject(userid, 7);
    return 1;
}
stock IsAPoliceVehicle(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 528, 596, 597, 598, 599, 490, 427: return 1;
	}
	return 0;
}
/*
alias:vfrisk("ตรวจค้นรถ")
CMD:vfrisk(playerid, params[])
{
    new vehicleid;

    if(GetFactionType(playerid) != FACTION_POLICE)
    {
        return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ใช่เจ้าหน้าที่ตำรวจ");
	}
	if((vehicleid = GetNearbyVehicle(playerid)) == INVALID_VEHICLE_ID)
	{
	    return SendClientMessage(playerid, COLOR_RED, "- คุณต้องอยู่ภายในระยะของรถ");
	}
	if(!carData[vehicleid][carOwnerID])
	{
	    return SendClientMessage(playerid, COLOR_RED, "- รถคันนี้ไม่มีเจ้าของ");
	}

    SendClientMessage(playerid, COLOR_GREEN, "|_____ ช่องเก็บของในรถ _____|");
    SendClientMessageEx(playerid, COLOR_GREY2, "เงินสด: %s/%s", FormatMoney(carData[vehicleid][carCash]), FormatMoney(GetVehicleStashCapacity(vehicleid, STASH_CAPACITY_CASH)));

	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** เจ้าหน้าที่ %s ได้เปิดกระโปรงรถรุ่น %s เพื่อดูสิ่งของข้างใน", GetPlayerNameEx(playerid), ReturnVehicleName(vehicleid));
	return 1;
}
*/