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
                return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö���������˹�ҷ���� ���ͧ�ҡ�س�ѧ����� On Duty");

			Dialog_Show(playerid, POLICE_MENU, DIALOG_STYLE_LIST, "�������˹�ҷ�� '���Ǩ'", "{FFFFFF}����: %s\n\
			- Cuff (��ͤ)\n\
			- Uncuff (�Ŵ��ͤ)\n\
			- Drag (�ҡ/������ҡ)\n\
			- Frisk (�鹵��)\n\
			- Ticket (����)", "���͡", "¡��ԡ", GetPlayerNameEx(targetplayer));
		}
		playerData[playerid][pFactionMenuID] = targetplayer;
		return 1;
	}
	return 1;
}


CMD:m(playerid, params[])
{
	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_WHITE, "/m [��ͤ���]");

	if (strlen(params) > 100) {
	    SendNearbyMessage(playerid, 20.0, COLOR_YELLOW, "%s ���� : %.100s", GetPlayerNameEx(playerid), params);
	    SendNearbyMessage(playerid, 20.0, COLOR_YELLOW, "...%s", params[100]);
	}
	else {
	    SendNearbyMessage(playerid, 20.0, COLOR_YELLOW, "%s ���� : %s", GetPlayerNameEx(playerid), params);
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
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ������������ʶҹл���");

				if (targetplayer == playerid)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö���Թ����� ��͵��ͧ��");

				if (GetPlayerState(targetplayer) != PLAYER_STATE_ONFOOT)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ�ҵ�ͧ������躹�ҹ��˹�");

				if (!IsPlayerNearPlayer(playerid, targetplayer, 5.0))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ��������������س");

				if (playerData[targetplayer][pCuffed])
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ�Ҷ١���ح������������");

				playerData[targetplayer][pCuffed] = 1;

				TogglePlayerControllable(targetplayer, false);
				SetPlayerSpecialAction(targetplayer, SPECIAL_ACTION_CUFFED);
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s �����ح���ͧ͢ %s �����", GetPlayerNameEx(playerid), GetPlayerNameEx(targetplayer));
				SetPlayerAttachedObject(targetplayer,7,19418,6,0.012999,0.044999,-0.015999,-3.699999,-2.000000,93.399963,1.000000,1.000000,1.000000);
			}
			case 2: // uncuff
			{
				if (targetplayer == INVALID_PLAYER_ID)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ������������ʶҹл���");

				if (targetplayer == playerid)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö���Թ����� ��͵��ͧ��");

				if (GetPlayerState(targetplayer) != PLAYER_STATE_ONFOOT)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ�ҵ�ͧ������躹�ҹ��˹�");

				if (!IsPlayerNearPlayer(playerid, targetplayer, 5.0))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ��������������س");

				if (!playerData[targetplayer][pCuffed])
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ�������١�١���ح������������");

				playerData[targetplayer][pCuffed] = 0;

				TogglePlayerControllable(targetplayer, true);
				SetPlayerSpecialAction(targetplayer, SPECIAL_ACTION_NONE);
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ŵ�ح���ͧ͢ %s ", GetPlayerNameEx(playerid), GetPlayerNameEx(targetplayer));
				RemovePlayerAttachedObject(targetplayer, 7);
			}
			case 3: // drag
			{
				if (targetplayer == INVALID_PLAYER_ID)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ������������ʶҹл���");

				if (targetplayer == playerid)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö���Թ����� ��͵��ͧ��");

				if (GetPlayerState(targetplayer) != PLAYER_STATE_ONFOOT)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ�ҵ�ͧ������躹�ҹ��˹�");

				if (!IsPlayerNearPlayer(playerid, targetplayer, 5.0))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ��������������س");

				if (playerData[targetplayer][pDragged])
				{
					playerData[targetplayer][pDragged] = 0;
					playerData[targetplayer][pDraggedBy] = INVALID_PLAYER_ID;

					KillTimer(playerData[targetplayer][pDragTimer]);
					SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s �����µ�� %s", GetPlayerNameEx(playerid), GetPlayerNameEx(targetplayer));
				}
				else
				{
					playerData[targetplayer][pDragged] = 1;
					playerData[targetplayer][pDraggedBy] = playerid;

					playerData[targetplayer][pDragTimer] = SetTimerEx("DragUpdate", 200, true, "dd", playerid, targetplayer);
					SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ����ҵ�� %s", GetPlayerNameEx(playerid), GetPlayerNameEx(targetplayer));
				}
			}
			case 4: // Frisk
			{
				if (targetplayer == INVALID_PLAYER_ID)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ������������ʶҹл���");

				if (targetplayer == playerid)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö���Թ����� ��͵��ͧ��");

				if (GetPlayerState(targetplayer) != PLAYER_STATE_ONFOOT)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ�ҵ�ͧ������躹�ҹ��˹�");

				if (!IsPlayerNearPlayer(playerid, targetplayer, 5.0))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ��������������س");

				if (!playerData[targetplayer][pCuffed])
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ�������١�١���ح����");

				FriskInventory3(playerid, targetplayer);
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��鹵�� %s", GetPlayerNameEx(playerid), GetPlayerNameEx(targetplayer));
				return 1;
			} 
			case 5: // Ticket
			{
				if (targetplayer == INVALID_PLAYER_ID)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ������������ʶҹл���");

				if (targetplayer == playerid)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö���Թ����� ��͵��ͧ��");

				if (GetPlayerState(targetplayer) != PLAYER_STATE_ONFOOT)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ�ҵ�ͧ������躹�ҹ��˹�");

				if (!IsPlayerNearPlayer(playerid, targetplayer, 5.0))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����ͧ��������������س");

				Dialog_Show(playerid, DIALOG_FINECASH, DIALOG_STYLE_INPUT, "Ticket", "�ô�кبӹǹ�Թ���س��ͧ��èл�Ѻ :", "��ŧ", "¡��ԡ");
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
		    return SendClientMessage(playerid, COLOR_GREY, "* �س��ͧ�кبӹǹ�ҡ���� 0");

		Dialog_Show(playerid, DIALOG_FINETEXT, DIALOG_STYLE_INPUT, "Ticket", "{FFFFFF}����: {FFA84D}%s\n{FFFFFF}�ô�к����˵ط�����ͧʧ�ʡ�зӼԴ :", "��ŧ", "¡��ԡ", GetPlayerNameEx(userid));
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

alias:ticket("��Ѻ�Թ")
CMD:ticket(playerid, params[])
{
	new
		userid,
	    amount;
	new factionid = playerData[playerid][pFaction];

	if (GetFactionType(playerid) != FACTION_POLICE)
	    return 1;

	if (sscanf(params, "uds[128]", userid, amount))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "�����ҹ : {FFFFFF}/ticket [�ʹռ�����/���͵���Ф�] [�ӹǹ�Թ]");

	if (amount > 100000)
	    return ErrorMsg(playerid, "��س�����һ�Ѻ�����¡��� $100,000 ");

    if (GetPlayerMoneyEx(userid) < amount)
    	return ErrorMsg(playerid, "���������Թ�����§������Ѻ��è��¤�һ�Ѻ");

	if (userid == INVALID_PLAYER_ID)
	    return ErrorMsg(playerid, "�����蹷���к����١��ͧ");

	factionData[factionid][factionTreasury] += amount;
	GivePlayerMoneyEx(userid, -amount);
	Faction_SaveTreasury(factionid);
	SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ����¹ Ticket ���Ѻ %s �繨ӹǹ�Թ", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	return 1;
}



/* ----------------------------------------------------------------------------------------------------------------- */


/*
CMD:police(playerid, params[])
{
	if (GetFactionType(playerid) == FACTION_POLICE)
	return Dialog_Show(playerid, DIALOG_POLICE, DIALOG_STYLE_LIST, "{01C9FA}[ {B1EEFC}��������Ѻ���Ǩ {01C9FA}]", "{FFFFFF}+ ���ح����\n+ �鹵��\n+ �ִ�ͧ�Դ������\n+ ��ö��ǹ���\n+ �Ŵ�ح����\n+ �ҡ\n+ �ҡ���/ŧö\n+ ��Ѻ�Թ\n+ �׹��͵俿��\n+ ����", "��ŧ", "¡��ԡ");
}*/
CMD:Acuff(playerid, params[]) {

	if(GetFactionType(playerid) != FACTION_POLICE)
	    return 1;

	if (!playerData[playerid][pOnDuty])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö���� ���ͧ�ҡ�س�ѧ����� On Duty");

	if(GetPVarType(playerid, "TacklingMode")) {
		SendClientMessage(playerid, COLOR_YELLOW, "- �س��Դ���������һз�");
		DeletePVar(playerid, "TacklingMode");
	}
	else {
		SendClientMessage(playerid, COLOR_YELLOW, "- �س���Դ���������һз� (���·����������ͪ���)");
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
                    SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ��ͧʧ��� health lock (%.2f==%.2f) ", ReturnRealName(playerid, 0), playerData[playerid][HealthLock], hp);

					if(playerData[playerid][pWarningCheat] >= 9)
					{
					    SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s �١ẹ���ͧ�ҡ health lock (%.2f==%.2f)", ReturnRealName(playerid, 0), playerData[playerid][HealthLock], hp);
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
                    SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ��ͧʧ��� armor lock (%.2f==%.2f)", ReturnRealName(playerid, 0), playerData[playerid][ArmorLock], armour);
                    if(playerData[playerid][pWarningCheat] >= 9)
					{
					    SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s �١ẹ���ͧ�ҡ armor lock (%.2f==%.2f)", ReturnRealName(playerid, 0), playerData[playerid][ArmorLock], armour);
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
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s ������ͤ %s ��С�ŧ�Ѻ���", GetPlayerNameEx(issuerid), GetPlayerNameEx(playerid));
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
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö���� ���ͧ�ҡ�س�ѧ����� On Duty");

	if (playerData[playerid][pTazer] == 1)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö��ҹ���");

	if(TazerActive{playerid})
	{
		TazerActive{playerid} = false;
		playerUseTazer[playerid] = 0;
		GivePlayerWeaponEx(playerid, 24, 50);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s �纻׹俿�������ͧ������㹫ͧ˹ѧ", GetPlayerNameEx(playerid));
		ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.0, 0, 0, 0, 0, 0, 1);

	}
	else
	{
		TazerActive{playerid} = true;
		GivePlayerWeaponEx(playerid, TASER_WEAPON, 1);
		playerUseTazer[playerid] = 1;
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ���һ׹俿��������͡�Ҩҡ�ͧ˹ѧ", ReturnPlayerName(playerid));
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
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö���� ���ͧ�ҡ�س�ѧ����� On Duty");

	if(BeanbagActive{playerid})
	{
		BeanbagActive{playerid} = false;
		//SetPlayerArmedWeapon(playerid, 0);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��èء���ع��Ш�� 㹻׹���ԧ�ѹ 870", ReturnPlayerName(playerid));
	}
	else if(GetPlayerWeapon(playerid) == 25)
	{
		BeanbagActive{playerid} = true;
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��èء���ع�ҧ 㹻׹���ԧ�ѹ 870", ReturnPlayerName(playerid));
	}
	else return SendClientMessage(playerid, COLOR_LIGHTRED, "�س���繵�ͧ�� Remington 870 ������������������ع�ҧ");

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
				format(Msg, sizeof(Msg), "** %s ��Ժ���ظ�ҡ Trunk", GetPlayerNameEx(playerid));
				SetPlayerChatBubble(playerid, Msg, COLOR_PURPLE, 10.0, 5000);
				ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.0, 0, 0, 0, 0, 0, 1);
				return 1;
			}
			case 1: //M4
			{
				ResetPlayerWeaponsEx(playerid);
				GivePlayerWeaponEx(playerid, 31, 100);
				format(Msg, sizeof(Msg), "** %s ��Ժ���ظ�ҡ Trunk", GetPlayerNameEx(playerid));
				SetPlayerChatBubble(playerid, Msg, COLOR_PURPLE, 10.0, 5000);
				ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.0, 0, 0, 0, 0, 0, 1);
				return 1;
			}
		}
	}
	return 1;
}

// ���ٵ��Ǩ
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
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ������������ͺ � �س���");
					return 1;
				}
				Dialog_Show(playerid, DIALOG_CUFFID, DIALOG_STYLE_TABLIST, "[���ح����]", string, "���͡", "�Դ");
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
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ������������ͺ � �س���");
					return 1;
				}
				Dialog_Show(playerid, DIALOG_FRISKID, DIALOG_STYLE_TABLIST, "[�鹵��]", string, "���͡", "�Դ");
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
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ������������ͺ � �س���");
					return 1;
				}
				Dialog_Show(playerid, DIALOG_TAKEID, DIALOG_STYLE_TABLIST, "[�ִ�ͧ�Դ������]", string, "���͡", "�Դ");
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
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ������������ͺ � �س���");
					return 1;
				}
				Dialog_Show(playerid, DIALOG_UNCUFFID, DIALOG_STYLE_TABLIST, "[�Ŵ�ح����]", string, "���͡", "�Դ");
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
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ������������ͺ � �س���");
					return 1;
				}
				Dialog_Show(playerid, DIALOG_DRAGID, DIALOG_STYLE_TABLIST, "[�ҡ]", string, "���͡", "�Դ");
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
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ������������ͺ � �س���");
					return 1;
				}
				Dialog_Show(playerid, DIALOG_DETAINID, DIALOG_STYLE_TABLIST, "[�ҡ���/ŧö]", string, "���͡", "�Դ");
			}
			case 7: // ��Ѻ�Թ
			{
                Dialog_Show(playerid, DIALOG_FINEID, DIALOG_STYLE_INPUT, "[��Ѻ�Թ]", "��س��к��ʹռ����蹷��س��ͧ��èл�Ѻ�Թ :", "���͡", "�Դ");
			}
			case 8:
			{
			    callcmd::taser(playerid, "\1");
			}
			case 9:
			{
			    Dialog_Show(playerid, DIALOG_CHMID, DIALOG_STYLE_INPUT, "[����]", "��س��к��ʹռ����蹷��س��ͧ��èФ��� :", "���͡", "�Դ");
			}
		}
	}
	return 1;
}


Dialog:DIALOG_UNCUFFID(playerid, response, listitem, inputtext[]) // �Ŵ��ͤ�ح����
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

Dialog:DIALOG_CUFFID(playerid, response, listitem, inputtext[]) // ���ح����
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

Dialog:DIALOG_FRISKID(playerid, response, listitem, inputtext[]) // ���Ңͧ�Դ������
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

Dialog:DIALOG_TAKEID(playerid, response, listitem, inputtext[]) // �ִ�ͧ�Դ������
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

Dialog:DIALOG_DRAGID(playerid, response, listitem, inputtext[]) // �ҡ
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
Dialog:DIALOG_DETAINID(playerid, response, listitem, inputtext[]) // �ҡ���ö
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

Dialog:DIALOG_CHMID(playerid, response, listitem, inputtext[]) // ����
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
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- ��ͧ�ҧ�������Ѻ���˹�ҷ����ҹ��!");

	if (sscanf(params, "us[32]", userid, crime))
	    return SendClientMessage(playerid, COLOR_WHITE, "(/su)spect [�ʹ�/����] [�����]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ��������������");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö�Ѵ���������ͧ��");

	if (GetFactionType(userid) == FACTION_POLICE || GetFactionType(userid) == FACTION_MEDIC || GetFactionType(userid) == FACTION_GOV)
        return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö�Ѵ������Ѻ˹��§ҹ�Ѱ��");

    GivePlayerWanted(userid, 1);

	SendClientMessageEx(playerid, COLOR_WHITE, "�س���Ѵ��դ������Ѻ {33CCFF}%s {FFFFFF}�����: %s", GetPlayerNameEx(userid), crime);
	SendClientMessageEx(userid, COLOR_WHITE, "���˹�ҷ�� {33CCFF}%s {FFFFFF}���Ѵ������س �����: %s", GetPlayerNameEx(playerid), crime);
    return 1;
}
alias:suspect("1")
*/




CMD:cuff(playerid, params[])
{
    new
	    userid;

	if (GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- ��ͧ�ҧ�������Ѻ���˹�ҷ����ҹ��!");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/cuff [�ʹ�/����]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ��������������");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö���ح����������ͧ��");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ���ͧ���������ҹ��˹�");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ��������������س");

    if (playerData[userid][pCuffed])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ��١���ح��������");

    playerData[userid][pCuffed] = 1;

	TogglePlayerControllable(userid, false);
	SetPlayerSpecialAction(userid, SPECIAL_ACTION_CUFFED);
	SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s �����ح���ͧ͢ %s �����", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	SetPlayerAttachedObject(userid,7,19418,6,0.012999,0.044999,-0.015999,-3.699999,-2.000000,93.399963,1.000000,1.000000,1.000000);
    return 1;
}



CMD:uncuff(playerid, params[])
{
    new
	    userid;

	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- ��ͧ�ҧ�������Ѻ���˹�ҷ����ҹ��!");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/uncuff [�ʹ�/����]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ��������������");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö�Ŵ�ح����������ͧ��");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ��������������س");

    if (!playerData[userid][pCuffed])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ�������١���ح����");

    playerData[userid][pCuffed] = 0;

	TogglePlayerControllable(userid, true);
	SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);
	SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ŵ�ح���ͧ͢ %s ", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
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
alias:vfrisk("��Ǩ��ö")
CMD:vfrisk(playerid, params[])
{
    new vehicleid;

    if(GetFactionType(playerid) != FACTION_POLICE)
    {
        return SendClientMessage(playerid, COLOR_RED, "- �س��������˹�ҷ����Ǩ");
	}
	if((vehicleid = GetNearbyVehicle(playerid)) == INVALID_VEHICLE_ID)
	{
	    return SendClientMessage(playerid, COLOR_RED, "- �س��ͧ�����������Тͧö");
	}
	if(!carData[vehicleid][carOwnerID])
	{
	    return SendClientMessage(playerid, COLOR_RED, "- ö�ѹ����������Ңͧ");
	}

    SendClientMessage(playerid, COLOR_GREEN, "|_____ ��ͧ�红ͧ�ö _____|");
    SendClientMessageEx(playerid, COLOR_GREY2, "�Թʴ: %s/%s", FormatMoney(carData[vehicleid][carCash]), FormatMoney(GetVehicleStashCapacity(vehicleid, STASH_CAPACITY_CASH)));

	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** ���˹�ҷ�� %s ���Դ����çö��� %s ���ʹ���觢ͧ��ҧ�", GetPlayerNameEx(playerid), ReturnVehicleName(vehicleid));
	return 1;
}
*/