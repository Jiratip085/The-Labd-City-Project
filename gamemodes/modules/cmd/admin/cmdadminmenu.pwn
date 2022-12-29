#include <YSI\y_hooks>

hook OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	#if defined DEBUG
	    printf("[debug] OnPlayerClickPlayer(%d, %d, %d)", playerid, clickedplayerid, source);
	#endif
	
	
	if(Account[playerid][Admin] >= 1) 
	{
		Dialog_Show(playerid, ADMIN_MENU, DIALOG_STYLE_LIST, "{FFFFFF}", "{FFFFFF}Name: %s\n- Spec\n- Gethere\n- Goto\n- Revive\n- Fix Mapbug\n- Kick\n- Ban\n- Check Stats\n- Check Afk\n- Send Message To", "Select", "Cancel", GetRoleplayName(clickedplayerid));
		Character[playerid][AdminID] = clickedplayerid;	
	}
	return 1;
}
Dialog:ADMIN_MENU(playerid, response, listitem, inputtext[])
{
	new str[128], clickedplayerid = Character[playerid][AdminID];	
	if(response)
	{
		if(clickedplayerid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_GRAY, "- {FFFFFF}ผู้เล่นไม่ได้อยู่ในเกม");

		switch (listitem)
		{
				
			case 1: //Spec
			{
				if(!IsPlayerConnectedEx(clickedplayerid))
					return SendClientMessage(playerid, COLOR_GREY, "- ไอดีผู้เล่นที่คุณระบุ ไม่ได้เชื่อต่อกับเซิฟเวอร์");

				if(Character[playerid][Spectating] == INVALID_PLAYER_ID) {
					GetPlayerPos(playerid, Character[playerid][PosX], Character[playerid][PosY], Character[playerid][PosZ]);
					Character_Save(playerid);
					Character[playerid][Interior] = GetPlayerInterior(playerid);
					Character[playerid][VWorld] = GetPlayerVirtualWorld(playerid);
					Character[playerid][Skin] = GetPlayerSkin(playerid);

					if(Character[playerid][AdminDuty] == 0)
					{
						GetPlayerHealth(playerid, Character[playerid][Health]);
						GetPlayerArmour(playerid, Character[playerid][Armour]);
					}
				}
				Character[playerid][Spectating] = clickedplayerid;
				TogglePlayerSpectating(playerid, true);
				SetPlayerColor(playerid, COLOR_WHITE);

				SetPlayerInterior(playerid, GetPlayerInterior(clickedplayerid));
				SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(clickedplayerid));

				if(IsPlayerInAnyVehicle(clickedplayerid)) {
					PlayerSpectateVehicle(playerid, GetPlayerVehicleID(clickedplayerid));
				}
				else {
					PlayerSpectatePlayer(playerid, clickedplayerid);
				}

				TextDrawShowForPlayer(playerid, textdrawVariables[0]);
			

				format(str, sizeof(str), "%s:{FFFFFF} Spec To %s", GetRoleplayName(playerid), GetRoleplayName(clickedplayerid));
				SendAdminsMessage(1, COLOR_YELLOW, str);
				return 1;
			}
            case 2: //gethere
            {

                SendPlayerToPlayer(clickedplayerid, playerid);
				format(str, sizeof(str), "%s:{FFFFFF} Gethere %s", GetRoleplayName(playerid), GetRoleplayName(clickedplayerid));
				SendAdminsMessage(1, COLOR_YELLOW, str);
                return 1;
            }
            case 3: //gethere
            {

                SendPlayerToPlayer(playerid, clickedplayerid);
				format(str, sizeof(str), "%s:{FFFFFF} Goto %s", GetRoleplayName(playerid), GetRoleplayName(clickedplayerid));
				SendAdminsMessage(1, COLOR_YELLOW, str);
                return 1;
            }
            case 4; //revive
            {
                AC_SetPlayerHealth(clickedplayerid, 100);

                ClearAnimations(clickedplayerid);
                ResetDamages(clickedplayerid);
                Character[clickedplayerid][Injured] = 0;
                Character[clickedplayerid][InjuredTime] = 0;
                Character[clickedplayerid][InjuredEx]= 0;
                Character[clickedplayerid][InjuredSpawn] = 0;
                Character[clickedplayerid][InjuredShoot] = 0;

				format(str, sizeof(str), "%s:{FFFFFF} Revive %s", GetRoleplayName(playerid), GetRoleplayName(clickedplayerid));
				SendAdminsMessage(1, COLOR_YELLOW, str);
                return 1;
            }
            case 5: //Fix Mapbug
            {
                SetPlayerPos(clickedplayerid,-207.1014, 1119.2313, 20.4297);
                SetPlayerFacingAngle(clickedplayerid,272.9626);
                SetPlayerInterior(clickedplayerid, 0);
                SetPlayerVirtualWorld(clickedplayerid, 0);
                format(str, sizeof(str), "%s:{FFFFFF} Fix Mapbug %s", GetRoleplayName(playerid), GetRoleplayName(clickedplayerid));
				SendAdminsMessage(1, COLOR_YELLOW, str);
                return 1;
            }

            case 6: //kick
            {
                Dialog_Show(playerid, ADMIN_MENU_KICK, DIALOG_STYLE_INPUT, "Kick", "Name: %s\nกรุณาระบุสาเหตุการ 'Kick'","เตะ","ยกเลิก", GetRoleplayName(clickedplayerid));
                return 1;
            }
            case 7: //Ban
            {
                Dialog_Show(playerid, ADMIN_MENU_BAN, DIALOG_STYLE_INPUT, "Ban", "Name: %s\nกรุณาระบุสาเหตุการ 'Ban'","แบน","ยกเลิก", GetRoleplayName(clickedplayerid));
                return 1;
            }
            case 8: //Check Stats
            {
                ShowStatsForPlayer(playerid, clickedplayerid);
                format(str, sizeof(str), "%s:{FFFFFF} Check Stats %s", GetRoleplayName(playerid), GetRoleplayName(clickedplayerid));
				SendAdminsMessage(1, COLOR_YELLOW, str);
                return 1;
            }
            case 9: //Check Afk
            {
                foreach (new i : clickedplayerid)
                {

                    if(GetTickCount() > (Character[i][PauseCheck]+2000))
                        SendClientMessageEx(playerid, COLOR_GREY, "ผู้เล่น %s ได้ AFK เป็นเวลา %i วินาที!", ReturnName(i), Character[i][PauseTime]);

                    //else SendClientMessageEx(playerid, COLOR_GREY, "ผู้เล่น %s ไม่ได้ AFK.", ReturnName(i));

                }
                return 1;
            }
            case 10: //Send Message To
            {
                Dialog_Show(playerid, ADMIN_MENU_PM, DIALOG_STYLE_INPUT, "Send Message", "Name: %s\nกรุณาระบุข้อความที่ต้องการส่งถึงผู้เล่น","ส่ง","ยกเลิก", GetRoleplayName(clickedplayerid));
                return 1;
            }
            case 11: //mute
            {
                Character[clickedplayerid][Muted] = 1;

                format(str, sizeof(str), "%s:{FFFFFF} Mute To %s", GetRoleplayName(playerid), GetRoleplayName(clickedplayerid));
				SendAdminsMessage(1, COLOR_YELLOW, str);

                format(str, sizeof(str), "[Administrator] : Mute %s.", GetRoleplayName(clickedplayerid));
                SendClientMessageToAll(COLOR_ORANGE, str);
                return 1;
            }
            case 12: //un mute
            {
                Character[clickedplayerid][Muted] = 0;

                format(str, sizeof(str), "%s:{FFFFFF} UnNute To %s", GetRoleplayName(playerid), GetRoleplayName(clickedplayerid));
				SendAdminsMessage(1, COLOR_YELLOW, str);

                format(str, sizeof(str), "[Administrator] : UnMute %s.", GetRoleplayName(clickedplayerid));
                SendClientMessageToAll(COLOR_ORANGE, str);
                return 1;
            }
            case 13: //Freeze
            {
                TogglePlayerControllable(clickedplayerid, 0);

                format(str, sizeof(str), "%s:{FFFFFF} Freeze %s", GetRoleplayName(playerid), GetRoleplayName(clickedplayerid));
				SendAdminsMessage(1, COLOR_YELLOW, str);

                format(str, sizeof(str), "[Administrator] : Freeze %s.", GetRoleplayName(clickedplayerid));
                SendClientMessageToAll(COLOR_ORANGE, str);
                return 1;
            }
            case 14: //UnFreeze
            {
                TogglePlayerControllable(clickedplayerid, 1);

                format(str, sizeof(str), "%s:{FFFFFF} UnFreeze %s", GetRoleplayName(playerid), GetRoleplayName(clickedplayerid));
				SendAdminsMessage(1, COLOR_YELLOW, str);

                format(str, sizeof(str), "[Administrator] : UnFreeze %s.", GetRoleplayName(clickedplayerid));
                SendClientMessageToAll(COLOR_ORANGE, str);
                return 1;
            }
        }
	}
	return 1;
}
Dialog:ADMIN_MENU_PM(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new clickedplayerid = Character[playerid][AdminID];	

		if (clickedplayerid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_GREY, "- {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

		if (isnull(inputtext))
			return Dialog_Show(playerid, ADMIN_MENU_PM, DIALOG_STYLE_INPUT, "Send Message", "Name: %s\nกรุณาระบุข้อความที่ต้องการส่งถึงผู้เล่น","ส่ง","ยกเลิก", GetRoleplayName(clickedplayerid));

        format(str, sizeof(str), "%s:{FFFFFF} Send Message To %s (%.80s)", GetRoleplayName(playerid), GetRoleplayName(clickedplayerid), inputtext);
        SendAdminsMessage(1, COLOR_YELLOW, str);

		SendClientMessageEx(clickedplayerid, COLOR_YELLOW, "(( Administrator: %.80s ))", inputtext);
	}
	else
	{
        Dialog_Show(playerid, ADMIN_MENU, DIALOG_STYLE_LIST, "{FFFFFF}", "{FFFFFF}Name: %s\n- Spec\n- Gethere\n- Goto\n- Revive\n- Fix Mapbug\n- Set Player\n- Kick\n- Ban\n- Check Stats\n- Check Afk\n- Send Message To\n- Mute\n- UnMute\n- Freeze\n -UnFreeze", "Select", "Cancel", GetRoleplayName(clickedplayerid));
	}
	return 1;
}

Dialog:ADMIN_MENU_KICK(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new clickedplayerid = Character[playerid][AdminID];		

		if (clickedplayerid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_GREY, "- {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

		if (isnull(inputtext))
			return Dialog_Show(playerid, ADMIN_MENU_BAN, DIALOG_STYLE_INPUT, "Kick", "Name: %s\nกรุณาระบุสาเหตุการ 'Kick'","เตะ","ยกเลิก", GetRoleplayName(clickedplayerid));

        format(str, sizeof(str), "[Administrator] : ได้เตะ %s ออกจากเซิฟเวอร์ | เนื่องจาก: %s", GetRoleplayName(clickedplayerid), inputtext);
        SendPunishmentMessage(str);
        Character[clickedplayerid][Kicks] ++;
        KickPlayer(clickedplayerid);
		return 1;
	}
	else
	{
        Dialog_Show(playerid, ADMIN_MENU, DIALOG_STYLE_LIST, "{FFFFFF}", "{FFFFFF}Name: %s\n- Spec\n- Gethere\n- Goto\n- Revive\n- Fix Mapbug\n- Set Player\n- Kick\n- Ban\n- Check Stats\n- Check Afk\n- Send Message To\n- Mute\n- UnMute\n- Freeze\n -UnFreeze", "Select", "Cancel", GetRoleplayName(clickedplayerid));
	}
}
Dialog:ADMIN_MENU_BAN(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new clickedplayerid = Character[playerid][AdminID];		

		if (clickedplayerid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_GREY, "- {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

		if (isnull(inputtext))
			return Dialog_Show(playerid, ADMIN_MENU_BAN, DIALOG_STYLE_INPUT, "Kick", "Name: %s\nกรุณาระบุสาเหตุการ 'Kick'","เตะ","ยกเลิก", GetRoleplayName(clickedplayerid));

        format(str, sizeof(str), "[Administrator] : ได้เตะ %s ออกจากเซิฟเวอร์ | เนื่องจาก: %s", GetRoleplayName(clickedplayerid), listitem);
		
        format(str, sizeof(str), "[Administrator] : ได้แบนผู้เล่น %s ออกจากเซิฟเวอร์ | เนื่องจาก: %s", Account[clickedplayerid][Name], GetRoleplayName(clickedplayerid), listitem);
        SendPunishmentMessage(str);
        IssueBan(clickedplayerid, Account[clickedplayerid][Name], listitem);
		
		return 1;
	}
	else
	{
        Dialog_Show(playerid, ADMIN_MENU, DIALOG_STYLE_LIST, "{FFFFFF}", "{FFFFFF}Name: %s\n- Spec\n- Gethere\n- Goto\n- Revive\n- Fix Mapbug\n- Set Player\n- Kick\n- Ban\n- Check Stats\n- Check Afk\n- Send Message To\n- Mute\n- UnMute\n- Freeze\n -UnFreeze", "Select", "Cancel", GetRoleplayName(clickedplayerid));
	}
}








