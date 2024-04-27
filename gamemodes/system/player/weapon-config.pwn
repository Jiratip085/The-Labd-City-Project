#include	<YSI_Coding\y_hooks>


new LegDelay[MAX_PLAYERS];

// ������ Key
#define PRESSED(%0)	\
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define MAX_DAMAGES 30

enum E_DAMAGE_DATA {
	bool:dExists,
    bool:dArmour,
	dSec,
	dShotType,
	dWeaponid,
	dDamage,
    dIssueName[MAX_PLAYER_NAME]
};
new DamageData[MAX_PLAYERS][MAX_DAMAGES][E_DAMAGE_DATA];



stock countPlayerDamage(playerid)
{
	new count = 0;
	for(new i = 0; i != MAX_DAMAGES; ++i)
	{
	    if(DamageData[playerid][i][dExists])
			count++;
	}
	return count;
}
CMD:damages(playerid, params[])
{
	new targetid;

	if (sscanf(params, "u", targetid))
		return SendClientMessage(playerid, COLOR_WHITE, "�����: /damages [�ʹռ�����/��ǹ˹�觢ͧ����]");

	if(targetid == INVALID_PLAYER_ID)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "[Damages]: �����蹹��������������͡Ѻ���������");

	if (playerid != targetid && !IsPlayerNearPlayer(playerid, targetid, 3.0))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "[Damages]: �����蹹��������������س");
	
	new temp_current_time = gettime(), str[2500];
	for(new i=MAX_DAMAGES-1;i!=0;--i) {
		if(DamageData[targetid][i][dExists])
		{
			if(playerData[playerid][pAdmin] > 0) 
          		format(str, sizeof(str), "%s%s �Ӵ���� %d �ҡ %s ⴹ%s (%s) %d �Թҷշ���ҹ��\n", str, DamageData[targetid][i][dIssueName], DamageData[targetid][i][dDamage], ReturnWeaponNameEx(DamageData[targetid][i][dWeaponid]), GetBodyPartName(DamageData[targetid][i][dShotType]), DamageData[targetid][i][dArmour] ? ("ⴹ����") : ("���ⴹ����"), temp_current_time - DamageData[targetid][i][dSec]);
			else 
				format(str, sizeof(str), "%s����� %d �ҡ %s ⴹ%s (%s) %d �Թҷշ���ҹ��\n", str, DamageData[targetid][i][dDamage], ReturnWeaponNameEx(DamageData[targetid][i][dWeaponid]), GetBodyPartName(DamageData[targetid][i][dShotType]), DamageData[targetid][i][dArmour] ? ("ⴹ����") : ("���ⴹ����"), temp_current_time - DamageData[targetid][i][dSec]);
		}
	}
	return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_LIST, GetPlayerNameEx(targetid), (isnull(str)) ? ("�ѧ����դ��������������ʴ� ...") : str, "�Դ", "");
}
ReturnWeaponNameEx(weaponid)
{
	new
		name[24];
		
	switch(weaponid) {
		case 0: name = "��Ѵ";
		case 30: name = "AK-47";
		default: {
			GetWeaponName(weaponid, name, sizeof(name));	
		}
	}
	return name;
}


/*
Damage_Reset(playerid)
{
	for(new i = 0; i != MAX_DAMAGES; ++i)
	{
	    DamageData[playerid][i][dExists]=
		DamageData[playerid][i][dArmour]=false;
		DamageData[playerid][i][dSec]=
		DamageData[playerid][i][dDamage]=
		DamageData[playerid][i][dShotType]=
		DamageData[playerid][i][dWeaponid]=0;
	}
}
*/
/*
hook OnPlayerPrepareDeath(playerid, animlib[32], animname[32], &anim_lock, &respawn_time) {
	printf("OnPlayerPrepareDeath  %d", playerid);
    return 1;
}

hook OnInvalidWeaponDamage(playerid, damagedid, Float:amount, weaponid, bodypart, error, bool:given) // ���Ѻ����ⴹ����������軡��
{
    printf("OnInvalidWeaponDamage(%d, %d, %f, %d, %d, %d, %d)", playerid, damagedid, amount, weaponid, bodypart, error, given);
	return 1;
}*/

GetBodyPartName(bodypart)
{
	new name[16];
	switch(bodypart)
	{
		case 3: name = "�ӵ��";
		case 4: name = "˹�Ң�";
		case 5: name = "ᢹ����";
		case 6: name = "ᢹ���";
		case 7: name = "�ҫ���";
		case 8: name = "�Ң��";
		case 9: name = "���";
	}
	return name;
}
public OnPlayerDeath(playerid, killerid, reason)
{
	SetPlayerDrunkLevel(playerid, 0);
    ResetPlayer(playerid);
	SetPlayerHealth(playerid, 100);
	playerData[playerid][pHealth] = 100.0;
	playerData[playerid][pTazer] = 0;
    //ResetPlayerWeaponsEx(playerid);

	if(reason == 54) //suicide
	{
		playerData[playerid][pInterior] = GetPlayerInterior(playerid);
		playerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
		GetPlayerPos(playerid, playerData[playerid][pPos_X], playerData[playerid][pPos_Y], playerData[playerid][pPos_Z]);
		GetPlayerFacingAngle(playerid, playerData[playerid][pPos_A]);
	}
	if (playerData[playerid][pStunned] > 0)
	{
        playerData[playerid][pStunned] = 0;
        TogglePlayerControllable(playerid, true);
	}

	if (playerData[playerid][pArmorOn])
	{
	    RemovePlayerAttachedObject(playerid, 9);
	    playerData[playerid][pArmorOn] = false;
	}
	if (playerData[playerid][pTazer])
	{
	    playerData[playerid][pTazer] = 0;
	}


	if (playerData[playerid][pInjured] == 0)
	{
		playerData[playerid][pInjured] = 1;

		if (GetFactionOnline(FACTION_MEDIC) > 0)
		{
			playerData[playerid][pInjuredTime] = 600;
		}
		else
		{
			playerData[playerid][pInjuredTime] = 300;
		}
		playerData[playerid][pInterior] = GetPlayerInterior(playerid);
		playerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);

		GetPlayerPos(playerid, playerData[playerid][pPos_X], playerData[playerid][pPos_Y], playerData[playerid][pPos_Z]);
		GetPlayerFacingAngle(playerid, playerData[playerid][pPos_A]);
	}
	else
	{
		playerData[playerid][pInjured] = 0;
		playerData[playerid][pInjuredTime] = 0;
		playerData[playerid][pHospital] = 1;
	}
	ResetPlayerDeath(playerid);
    //UpdatePlayerDeaths(playerid);
    
	//UpdatePlayerKills(killerid, playerid);
	SendAdminMessage(COLOR_LIGHTRED, "[Admin-Death]: (ID:%d)%s �١����� (ID:%d)%s �繡�õ�´��� : %s", playerid, ReturnPlayerName(playerid), killerid, ReturnPlayerName(killerid), GetDeathReason(killerid, reason));
	SetPlayerDrunkLevel(playerid, 0);
	return 1;
}

forward OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart);
hook OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
    new Float:hp, Float:armor;
    GetPlayerHealth(damagedid, hp);
    GetPlayerArmour(damagedid, armor);

	if (damagedid != INVALID_PLAYER_ID)
	{
		if(weaponid == 22 || weaponid == 23 || weaponid == 24 || weaponid == 25 || weaponid == 26 || weaponid == 27
		|| weaponid == 28 || weaponid == 29 || weaponid == 30 || weaponid == 31 || weaponid == 32 || weaponid == 33 || weaponid == 34)
		{
			switch(bodypart)
			{
				case 3: ApplyAnimation(damagedid,"PED","DAM_stomach_frmBK",4.1,0,1,1,0,0,1); // Torso.
				case 6: ApplyAnimation(damagedid,"PED","DAM_armL_frmBK",4.1,0,1,1,0,0,1); // Left Arm.
				case 5: ApplyAnimation(damagedid,"PED","DAM_armR_frmBK",4.1,0,1,1,0,0,1); // Right Arm.
				case 8: {
					if(!playerData[damagedid][pInjured])
					{
						switch(bodypart)
						{
							case 7,8:
							{
								SendClientMessage(damagedid, COLOR_LIGHTRED, "[Bodypart]: ��س��١�ԧ���� �س���Ӻҡ㹡�������С��ⴴ���Ǥ���");
								LegDelay[damagedid] = 10;
							}
						}
					}
					ApplyAnimation(damagedid,"PED","DAM_LegL_frmBK",4.1,0,1,1,0,0,1); // Left Leg.
				}
				case 7: 
				{
					if(!playerData[damagedid][pInjured])
					{
						switch(bodypart)
						{
							case 7,8:
							{
								SendClientMessage(damagedid, COLOR_LIGHTRED, "[Bodypart]: ��س��١�ԧ���� �س���Ӻҡ㹡�������С��ⴴ���Ǥ���");
								LegDelay[damagedid] = 10;
							}
						}
					}
					ApplyAnimation(damagedid,"PED","DAM_LegR_frmBK",4.1,0,1,1,0,0,1); // Right Leg.
				}
				case 9:// Head.
				{
					PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
					GameTextForPlayer(playerid, "~r~HEAD SHOTED", 2000, 3);

					PlayerPlaySound(damagedid, 17802, 0.0, 0.0, 0.0);
					GameTextForPlayer(damagedid, "~r~HEAD SHOTED", 2000, 3);
					if(random(5) <= 2)
					{
						ApplyAnimation(damagedid,"PED","BIKE_fall_off",4.1,0,1,1,0,0,1);

					}
				}

			}
			//return 1;
		}
		if(weaponid == 0)
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-1);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-1);
			}
		}
		if(weaponid == 1)//ʹѺ
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-2.0);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-2.0);
			}
		}
		if(weaponid == 2)//golf
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-10.0);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-10.0);
			}
		}
		if(weaponid == 5)//bat
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-6.0);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-6.0);
			}
		}
		if(weaponid == 7)//pool
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-8.0);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-8.0);
			}
		}
		if(weaponid == 8)//Katana
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-15.0);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-15.0);
			}
		}
		if(weaponid == 9)//Chain saw
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-0.0);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-0.0);
			}
		}
		if(weaponid == 15)//������
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-5.0);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-5.0);
			}
		}
		if(weaponid == 16)//GRENADE
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-50.0);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-50.0);
			}
		}
		if(weaponid == 22)//colt
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-25);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-25);
			}
		}
		if(weaponid == 24)//DesertEagle
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-30);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-30);
			}

		}
		if(weaponid == 25)//SHOTGUN
		{
			if(BeanbagActive{playerid} == true)
				return 0;

		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-40);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-40);
			}
		}
		if(weaponid == 27)//SHOTGSPA
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-30);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-30);
			}
		}
		if(weaponid == 27)//MP 5
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-100);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-40);
			}
		}
		if(weaponid == 30)//�׹ Ak
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-20);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-20);
			}
		}
		if(weaponid == 31)//�׹ M4  
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-20);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-20);
			}
		}
		if(weaponid == 32)//�׹ TEC9
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-20);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-20);
			}
		}
		if(weaponid == 33)//�׹ RIFLE
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-60);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-60);
			}
		}
		if(weaponid == 34)//�׹ Sniper
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-80);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-80);
			}
		}
		if(weaponid == 36)//�׹ HEATSEEKER
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-100);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-100);
			}
		}
		if(weaponid == 39)//�׹ C4
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-1000);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-1000);
			}
		}
		if(weaponid == 	41)// spray
		{
		    if(armor > 0)
		    {
		        SetPlayerArmour(damagedid, armor-0.1);
		    }
		    else
		    {
				SetPlayerHealth(damagedid, hp-0.1);
			}
		}

	    /*if(!playerData[damagedid][pInjured])
	    {
	      	if(DamageStatus[playerid] == STATE_PENDING_HIT)
	       	{
	         	KillTimer(IssueTimer[damagedid]);
	          	IssueTimer[damagedid] = SetTimerEx("IssueHit", ISSUE_HIT_DELAY, false, "iifi", playerid, damagedid, Float:amount, weaponid, bodypart);
	      	}
	     	else
	       	{
	         	IssueTimer[damagedid] = SetTimerEx("IssueHit", ISSUE_HIT_DELAY, false, "iifi", playerid, damagedid, Float:amount, weaponid, bodypart);
	         	DamageStatus[damagedid] = STATE_PENDING_HIT;
	      	}
	    }*/
	    if (playerData[playerid][pTazer] == 1 && playerData[damagedid][pStunned] < 1 && weaponid == 23)
        {
            playerData[damagedid][pStunned] = 10;
            SetPlayerHealth(damagedid, hp-0);
            TogglePlayerControllable(damagedid, 0);

		    // �׹��͵俿��
		    //TazerCooldown[playerid] = 10;

			SendNearbyMessage(damagedid, 15.0, COLOR_PURPLE, "** %s �١�ԧ�»׹俿��������ŧ�Ѻ���", GetPlayerNameEx(damagedid));

        }
        if (playerUseTazer[playerid] == 1 && playerData[damagedid][pStunned] < 1 && weaponid == 23)
        {
			TogglePlayerControllable(damagedid, 0);

			playerData[damagedid][pStunned] = 10;
			playerData[playerid][pTazer] = 0;
			GivePlayerWeaponEx(playerid, 23, 0);

			
			ApplyAnimation(damagedid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);
			SendNearbyMessage(damagedid, 15.0, COLOR_PURPLE, "** %s �١�ԧ�»׹俿��������ŧ�Ѻ���", GetPlayerNameEx(damagedid));

		}
		if(BeanbagActive{playerid} == true && weaponid == 25)
		{
			ApplyAnimation(damagedid,"PED","BIKE_fall_off",4.1,0,1,1,0,0,1);
			SendNearbyMessage(damagedid, 15.0, COLOR_PURPLE, "** %s �١�ԧ�����ԧ�ѹ������ŧ�Ѻ���", GetPlayerNameEx(playerid));

			TogglePlayerControllable(damagedid, 0);
			SetPlayerDrunkLevel(damagedid, 4000);
			return 1;
		}
	 	/*if (playerData[playerid][pJailTime] > 0)
        {
            playerData[playerid][pJailTime] += 60;
            SendClientMessage(playerid, COLOR_LIGHTRED, "> ���ͧ�ҡ�س '�Դ�ء' ��Фس����¤���蹷�����ɢͧ�س + 60 �Թҷ�");
        }*/
		switch(weaponid)
		{
			case 22..34:
			{
				switch(bodypart)
				{
					//case 3: amount+=25; // Torso.
					//case 4: amount+=15; // Groin.
					//case 5: amount+=12.5; // Left Arm.
					//case 6: amount+=14; // Right Arm.
					//case 7: amount+=12.5; // Left Leg.
					//case 8: amount+=14; // Right Leg.
					case 9: amount+=10; // Head.
				}
			}
		}
	    /*for(new Sz; Sz < MAX_SZ; Sz++)
	    {
	  		if(IsPlayerInRangeOfPoint(playerid, SafeZoneInfo[Sz][szSize], SafeZoneInfo[Sz][szPosX], SafeZoneInfo[Sz][szPosY], SafeZoneInfo[Sz][szPosZ]))
	  		{
				TogglePlayerControllable(playerid, false);
				SendClientMessageEx(playerid, COLOR_LIGHTRED, "- �����Ӵ����㹾�鹷�� Safe Zone");
				playerData[playerid][pPVPFreeze] = 6;
			}
		}*/

	}
	return 1;
}
forward IssueHit(playerid, damagedid, Float:amount, weaponid, bodypart);
public IssueHit(playerid, damagedid, Float:amount, weaponid, bodypart)
{
    if(DamageStatus[damagedid] == STATE_PENDING_HIT && !playerData[damagedid][pInjured])
	{
		OnPlayerTakeDamage(damagedid, playerid, Float: amount, weaponid, bodypart);

	}
    return 1;
}

stock GetDeathReason(killerid, reason)
{
	new Message[32];
	if(killerid != INVALID_PLAYER_ID)
	{
		switch(reason)
		{
			case 0: Message = "��Ѵ";

			case 1:
   			{
				/*if(playerData[killerid][pAdmin] < 5 && playerData[killerid][pPlayingHours] < 10) 
				{
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "ʹѺ���";
			}
			case 2:
			{
				/*if(playerData[killerid][pAdmin] < 5 && playerData[killerid][pPlayingHours] < 10) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "������";
			}
			case 3:
			{
				/*if(playerData[killerid][pAdmin] < 5 && playerData[killerid][pPlayingHours] < 10) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "��кͧ";
			}
			case 4:
			{
				/*if(playerData[killerid][pAdmin] < 5 && playerData[killerid][pPlayingHours] < 10) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "�մ";
			}
			case 5:
			{
				/*if(playerData[killerid][pAdmin] < 5 && playerData[killerid][pPlayingHours] < 10) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "����ʺ��";
			}

			case 6:
			{
				/*if(playerData[killerid][pAdmin] < 5 && playerData[killerid][pPlayingHours] < 10) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "�����";
			}

			case 8:
			{
				/*if(playerData[killerid][pAdmin] < 5 && playerData[killerid][pPlayingHours] < 10) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "�Һ�ҵй�";
			}

			case 9:
			{
				/*if(playerData[killerid][pAdmin] < 5 && playerData[killerid][pPlayingHours] < 10) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "������¹��";
			}

			case 10: Message = "�����";
			case 11: Message = "�����";
			case 12: Message = "Vibrator";
			case 13: Message = "Vibrator";
			case 14: Message = "�͡���";

			case 15:
			{
				/*if(playerData[killerid][pAdmin] < 5 && playerData[killerid][pPlayingHours] < 10) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "�Т�����";
			}

			case 22:
			{
				/*if(playerData[killerid][pAdmin] < 5 && playerData[killerid][pPlayingHours] < 10) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "Pistol";
			}

			case 23:
			{
				/*if(playerData[killerid][pAdmin] < 5 && playerData[killerid][pPlayingHours] < 10) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "�׹��������§";
			}

			case 24:
			{
				/*if(playerData[killerid][pAdmin] < 5 && playerData[killerid][pPlayingHours] < 10) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "DesetEagle";
			}

			case 25:
			{
				/*if(playerData[killerid][pAdmin] < 5 && playerData[killerid][pPlayingHours] < 10) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "Shotgun";
			}

			/*case 26:
			{
				if(playerData[killerid][pAdmin] < 5) {
    				scriptBan(killerid, "Weapon Hacking (Sawnoff Shotgun)");
				}
				Message = "�׹�١�ͧ���";
			}
			case 27:
			{
				if(playerData[killerid][pAdmin] < 5) {
					if(groupVariables[playerData[killerid][pGroup]][gGroupType] != 1) {
						scriptBan(killerid, "Weapon Hacking (Combat Shotgun)");
    				}
				}
				Message = "�׹�١�ͧ���ặ";
			}*/

			case 28:
			{
				/*if(playerData[killerid][pAdmin] < 5) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "UZI";
			}
			case 29:
			{
				/*if(playerData[killerid][pAdmin] < 5) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "MP5";
			}
			case 30:
			{
				/*if(playerData[killerid][pAdmin] < 5 && playerData[killerid][pPlayingHours] < 10) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "AK-47";
			}
			case 31:
			{
				if(GetPlayerState(killerid) == PLAYER_STATE_DRIVER)
				{
					switch(GetVehicleModel(GetPlayerVehicleID(killerid)))
					{
						case 447: Message = "�׹�Ũҡ���Ԥͻ����";
						default:
						{
							/*if(playerData[killerid][pAdmin] < 5) {
								foreach(new i : Player) {
									PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
								}

								SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
								Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

								new insertLog[256];
								
								mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
									playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
								
								mysql_tquery(dbCon, insertLog); 
								
								mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
									playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
									
								mysql_tquery(dbCon, insertLog); 
								KickEx(killerid);
							}*/
		    				Message = "M4";
						}
					}
				}
				else
				{
				    /*if(playerData[killerid][pAdmin] < 5) {
						foreach(new i : Player) {
							PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
						}

						SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
						Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

						new insertLog[256];
						
						mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
							playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
						
						mysql_tquery(dbCon, insertLog); 
						
						mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
							playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
							
						mysql_tquery(dbCon, insertLog); 
						KickEx(killerid);
					}*/
					Message = "M4";
				}
			}
			case 32:
			{
				/*if(playerData[killerid][pAdmin] < 5 && playerData[killerid][pPlayingHours] < 10) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "TEC-9";
			}

			case 33:
			{
			    /*if(playerData[killerid][pAdmin] < 5 && playerData[killerid][pPlayingHours] < 10) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}	*/			
				Message = "�׹�����";
			}
			case 34:
			{
			    /*if(playerData[killerid][pAdmin] < 5) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "�׹�乷����������";
			}

			case 37:
			{
				Message = "����ͧ���";
			}

			case 38:
			{
				/*if(playerData[killerid][pAdmin] < 5) {
					foreach(new i : Player) {
						PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
					}

					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� System ���˵�: Weapon Hacking", ReturnPlayerName(killerid));
					Log(adminactionlog, INFO, "%s �١ẹ�� System ���˵� Weapon Hacking", ReturnPlayerName(killerid));

					new insertLog[256];
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, '%e', 'Weapon Hacking', '%e', '%e', 'System')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate(), ReturnIP(killerid));
					
					mysql_tquery(dbCon, insertLog); 
					
					mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', 'Weapon Hacking, 'System', '%e')",
						playerData[killerid][pSID], ReturnPlayerName(killerid), ReturnDate());
						
					mysql_tquery(dbCon, insertLog); 
					KickEx(killerid);
				}*/
				Message = "Minigun";		
			}

			case 41: Message = "��л�ͧ�����";
			case 42: Message = "�ѧ�Ѻ��ԧ";
			case 49: Message = "�ҹ�ҹЪ�";

			case 50:
			{
				if(GetPlayerState(killerid) == PLAYER_STATE_DRIVER)
				{
					switch(GetVehicleModel(GetPlayerVehicleID(killerid)))
					{
						case 417, 425, 447, 465, 469, 487, 488, 497, 501, 548, 563: Message = "㺾Ѵ���Ԥͻ����Ѵ";
						default: Message = "�ҹ�ҹЪ�";
					}
				}
				else Message = "�ҹ�ҹЪ�";
			}
			case 255: Message = "ö���Դ";
			default: Message = "����Һ���˵ط����Ѵ";
		}
	}
	if(killerid == INVALID_PLAYER_ID)
	{
		switch (reason)
		{
			case 53: Message = "����Һ���˵���Ѵ";
			case 54: Message = "���ª��Ե�ͧ";
			default: Message = "���ª��Ե�ͧ";
		}
	}
	return Message;
}


/*
hook OnPlayerDeathFinished(playerid) // Animation ����м������Դ
{
    playerData[playerid][pHealth] = 100.0;

    ResetPlayerWeaponsEx(playerid);
    ResetPlayer(playerid);


    if(GetPVarInt(playerid, "DisableFPS") == 0) {
		SetPVarInt(playerid, "DisableFPS", 1);
     	DestroyObject(CameraFirstPerson[playerid]);
		SetCameraBehindPlayer(playerid);
      	IsFPS[playerid] = 0;
 	}

	if (playerData[playerid][pStunned] > 0)
	{
        playerData[playerid][pStunned] = 0;
        TogglePlayerControllable(playerid, true);
	}

	if (playerData[playerid][pArmorOn])
	{
	    RemovePlayerAttachedObject(playerid, 9);
	    playerData[playerid][pArmorOn] = false;
	}
	if (playerData[playerid][pTazer])
	{
	    playerData[playerid][pTazer] = 0;
	}

	if (GetPlayerWantedLevelEx(playerid) > 0)
	{
	    playerData[playerid][pPrisoned] = 1;
	    playerData[playerid][pJailTime] = GetPlayerWantedLevelEx(playerid)*240;
	}
	else
	{
	    if (!IsPlayerInRangeOfPoint(playerid, 60.0, 1912.2245,-1388.4724,14.0504))
	    {
		    if (playerData[playerid][pInjured] == 0)
			{
		        playerData[playerid][pInjured] = 1;

		        if (GetFactionOnline(FACTION_MEDIC) > 0)
		        {
					playerData[playerid][pInjuredTime] = 300;
				}
				else
				{
				    playerData[playerid][pInjuredTime] = 300;
				}

		        playerData[playerid][pInterior] = GetPlayerInterior(playerid);
		    	playerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);

		    	GetPlayerPos(playerid, playerData[playerid][pPos_X], playerData[playerid][pPos_Y], playerData[playerid][pPos_Z]);
		    	GetPlayerFacingAngle(playerid, playerData[playerid][pPos_A]);
			}
			else
			{
			    playerData[playerid][pInjured] = 0;
			    playerData[playerid][pInjuredTime] = 0;
			    playerData[playerid][pHospital] = 1;
			}
		}
		else
		{
			if (playerData[playerid][pInjured] == 0)
			{
		        playerData[playerid][pInjured] = 1;

				inLabel[playerid] = 1;

				playerData[playerid][pInterior] = GetPlayerInterior(playerid);
				playerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);

				GetPlayerPos(playerid, playerData[playerid][pPos_X], playerData[playerid][pPos_Y], playerData[playerid][pPos_Z]);
				GetPlayerFacingAngle(playerid, playerData[playerid][pPos_A]);

			}
			else
			{
			    playerData[playerid][pInjured] = 0;
			    playerData[playerid][pInjuredTime] = 0;
			    playerData[playerid][pHospital] = 1;
			}
		}
	}
	ResetPlayerDeath(playerid);
	return 1;
}
hook OnPlayerDamageDone(playerid, Float:amount, issuerid, weapon, bodypart) // damages ���ⴹ�����
{
	if(playerid < MAX_PLAYERS)
	{	
		if (playerData[issuerid][pTazer] == 1 && playerData[playerid][pStunned] < 1 && weapon == 23)
        {
            playerData[playerid][pStunned] = 10;
            amount = 10.0;
            TogglePlayerControllable(playerid, 0);

			SendNearbyMessage(issuerid, 15.0, COLOR_PURPLE, "** %s �ԧ�׹��͵俿����� %s", GetPlayerNameEx(issuerid), GetPlayerNameEx(playerid));
        }

        if (playerUseTazer[issuerid] == 1 && playerData[playerid][pStunned] < 1 && weapon == 23)
        {
            playerData[playerid][pStunned] = 10;
            amount = 10.0;
            TogglePlayerControllable(playerid, 0);

			SendNearbyMessage(issuerid, 15.0, COLOR_PURPLE, "** %s �ԧ�׹��͵俿����� %s", GetPlayerNameEx(issuerid), GetPlayerNameEx(playerid));
        }
	}
    printf("OnPlayerDamageDone(%d, %f, %d, %d, %d)", playerid, amount, issuerid, weapon, bodypart);
    return 1;
}
*/

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {

	if(PRESSED(KEY_SPRINT))
	{
	    if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && !playerData[playerid][pInjured])
	    {
			if(LegDelay[playerid] > 0)
			{
				if(random(10) <= 1 && PRESSED(KEY_SPRINT)) return 1;
				
				ClearAnimations(playerid);
				ApplyAnimationEx(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, 0, 1, 1, 0, 0, 1);
				LegDelay[playerid] = 10;
			}
		}
	}
	if(PRESSED(KEY_JUMP))
	{
	    if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && !playerData[playerid][pInjured])
	    {
			if(LegDelay[playerid] > 0)
			{
				if(random(10) <= 1 && PRESSED(KEY_SPRINT)) return 1;
				
				ClearAnimations(playerid);
				ApplyAnimationEx(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, 0, 1, 1, 0, 0, 1);
				LegDelay[playerid] = 10;
			}
		}
	}
	return 1;
}




