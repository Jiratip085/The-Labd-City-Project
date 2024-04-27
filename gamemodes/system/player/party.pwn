#include <YSI_Coding\y_hooks>



hook OnPlayerConnect(playerid) 
{
	PlayerParty[playerid]=NO_PARTY;
	return 1;
}

hook OnPlayerDisconnect(playerid, reason) 
{
	new 
		factionid = playerData[playerid][pFaction];

    if(factionData[factionid][factionType] == FACTION_POLICE && playerData[playerid][pOnDuty]
    || factionData[factionid][factionType] == FACTION_MEDIC && playerData[playerid][pOnDuty])
        return 1;

    Party_Leave(playerid, PlayerParty[playerid], reason);
	return 1;
}

hook OnPlayerSpawn(playerid) {
    //RemoveMarkers(playerid);
}

ShowPartyMenu(playerid) 
{
    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);

    if(playerData[playerid][pOnDuty])
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Party]: คุณไม่สามารถใช้งาน Party ได้ในขณะที่คุณ On Duty");

    if (PlayerParty[playerid]==NO_PARTY) 
        return Dialog_Show(playerid, DialogPartyCreate, DIALOG_STYLE_MSGBOX, "ระบบปาร์ตี้", "คุณต้องการสร้างปาร์ตี้ใช่ไหม?", "ใช่", "ไม่");

    else return Dialog_Show(playerid, DialogParty, DIALOG_STYLE_LIST, "ระบบปาร์ตี้", "สมาชิก\nออกจากปาร์ตี้", "เลือก", "ปิด");
}

ShowPartyList(playerid) {
    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
    new string[1024], string2[1024], var[32], count;

    if (PlayerParty[playerid] == playerid) {
        strcat(string, "เพิ่มสมาชิก");
        count ++;
    }

    if (PlayerParty[playerid] != NO_PARTY) {
        foreach(new i : Player) {
            if (PlayerParty[i] == PlayerParty[playerid] && playerid != i) 
            {
	   			format(string, sizeof(string), "\n%d %s", i, GetPlayerNameEx(i));
	   			strcat(string2, string);
	   			format(var, sizeof(var), "PartyEdit_%d", count);
	   			SetPVarInt(playerid, var, i);
	   			count++;


            }
        }
    }

    return Dialog_Show(playerid, DialogPartyList, DIALOG_STYLE_LIST, "สมาชิกในปาร์ตี้", string, "เลือก", "ปิด");
}


Dialog:DialogPartyList(playerid, response, listitem, inputtext[])
{
    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
    if (response && PlayerParty[playerid] == playerid) {
        if (listitem == 0) {
            return Dialog_Show(playerid, DialogPartyAdd, DIALOG_STYLE_INPUT, "เพิ่มสมาชิก", "กรอกไอดีผู้เล่นที่ต้องการเชิญ", "เชิญ", "ปิด");
        }
        new var[15];
		format(var, sizeof(var), "PartyEdit_%d", listitem);
		new editid = GetPVarInt(playerid, var);

        if (IsPlayerConnected(editid)) {
            Party_Leave(editid, PlayerParty[editid], 4);
            /*SetPVarInt(playerid, "PartyEditID", editid);
            return Dialog_Show(playerid, DialogPartyEdit, DIALOG_STYLE_LIST, sprintf("สมาชิกในปาร์ตี้ %s", ReturnRealName(editid)), "เตะออกจากปาร์ตี้", "เลือก", "กลับ");*/
        }
        return ShowPartyList(playerid);
    }
    return ShowPartyMenu(playerid);
}


Dialog:DialogPartyEdit(playerid, response, listitem, inputtext[])
{
    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
    if (response && PlayerParty[playerid] == playerid) {
       new targetid = GetPVarInt(playerid, "PartyEditID");
       if (PlayerParty[playerid] == PlayerParty[targetid]) {
           switch(listitem) {
               case 0: {
                   if (playerid != targetid) {
                    Party_Leave(targetid, PlayerParty[targetid], 4);
                   }
                   else {
                       SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่สามารถเตะตัวเองออกจากปาร์ตี้ได้");
                   }
               }
           }
       }
    }
    return ShowPartyList(playerid);
}

Dialog:DialogPartyAdd(playerid, response, listitem, inputtext[])
{
    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
    if (response) 
    {
        new targetid = strval(inputtext);

        if (!Inventory_HasItem(targetid, "iFruit"))
            return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นที่คุณต้องการจะเชิญเข้าร่วมปาตี้นั้นไม่มีมือถือก");

        if (IsPlayerConnected(targetid) && playerData[playerid][IsLoggedIn]) {
            if (PlayerParty[targetid] == NO_PARTY) {
                SetPVarInt(targetid, "PartyInvite", playerid);
                SendClientMessageEx(playerid, COLOR_YELLOW, "[Party]: คุณได้เชิญ %s ให้เข้าร่วมปาร์ตี้ของคุณ", GetPlayerNameEx(targetid));
                Dialog_Show(targetid, DialogPartyJoin, DIALOG_STYLE_MSGBOX, "เข้าร่วมปาร์ตี้", "%s ได้เชิญคุณให้เข้าร่วมปาร์ตี้ของเขา", "เข้าร่วม", "ปฏิเสธ", GetPlayerNameEx(playerid));
            }
            else SendClientMessage(playerid, COLOR_GRAD1, "   ผู้เล่นนั้นมีปาร์ตี้อยู่แล้ว!");
        }
        else {
            SendClientMessage(playerid, COLOR_GRAD1, "   ผู้เล่นนั้นยังไม่ได้เชื่อมต่อกับเซิร์ฟเวอร์!");
        }
    }
    return ShowPartyList(playerid);
}

Dialog:DialogPartyJoin(playerid, response, listitem, inputtext[])
{
    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
    if (response) {
        new targetid = GetPVarInt(playerid, "PartyInvite");
        if (IsPlayerConnected(targetid) && playerData[playerid][IsLoggedIn] && PlayerParty[targetid] == targetid) {
            PlayerParty[playerid] = PlayerParty[targetid];
            foreach(new member : Player) {
                if (PlayerParty[member] == PlayerParty[playerid]) {
                    SendClientMessageEx(member, COLOR_YELLOW, "[Party]: %s เข้าร่วมปาร์ตี้", GetPlayerNameEx(playerid));

                    ShowMarkers(member, playerid);
                }
            }
            // ResyncSkin(playerid);
        }
        else {
            SendClientMessage(playerid, COLOR_GRAD1, "   ผู้เล่นนั้นไม่ได้อยู่ในปาร์ตี้แล้ว!");
        }
    }
    DeletePVar(playerid, "PartyInvite");
    return 1;
}

Dialog:DialogPartyCreate(playerid, response, listitem, inputtext[])
{
    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if(response) 
    {
        PlayerParty[playerid]=playerid;
        SendClientMessageEx(playerid, COLOR_YELLOW, "[Party]: ปาร์ตี้ของคุณถูกสร้างเรียบร้อยแล้ว");
        ShowPartyMenu(playerid);
    }
    return 1;
}
Dialog:DialogParty(playerid, response, listitem, inputtext[])
{
    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if(response) {
        switch(listitem) {
            case 0: {
                ShowPartyList(playerid);
            }
            case 1: {
                Party_Leave(playerid, PlayerParty[playerid]);
                SendClientMessageEx(playerid, COLOR_YELLOW, "[Party]: คุณได้ออกจากปาร์ตี้แล้ว");
                // ShowPartyMenu(playerid);
            }
            default: {
                PlayerParty[playerid]=playerid;
                SendClientMessageEx(playerid, COLOR_YELLOW, "[Party]: ปาร์ตี้ของคุณถูกสร้างเรียบร้อยแล้ว");
                ShowPartyMenu(playerid);
            }
        }
    }
    return 1;
}

CMD:leaveparty(playerid, params[])
{
    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	Party_Leave(playerid, PlayerParty[playerid]);
	return 1;
}

Party_Count(party) {
    new count = 0;
    foreach(new member : Player) {
        if (PlayerParty[member] == party) {
            count++;
        }
    }
    return count;
}

Party_Leave(playerid, party, reason = 3) {
    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
    if (party != NO_PARTY) {
        PlayerParty[playerid]=NO_PARTY;
        RemoveMarkers(playerid);
        // ResyncSkin(playerid);

        static const szDisconnectReason[5][] = {"หลุดออกจากเกมส์","ออกจากเกมส์","ถูกเตะออกจากเกมส์","ออกจากปาร์ตี้","ถูกเตะออกจากปาร์ตี้"};

        new count = Party_Count(party);
        
        if (count > 1) {
            if (playerid == party) { // เป็นผู้นำ
                // หาผู้นำคนใหม่
                new leader = INVALID_PLAYER_ID;

                foreach(new member : Player) {
                    if (PlayerParty[member] == party) {
                        leader = member;
                        break;
                    }
                }

                if (leader != INVALID_PLAYER_ID) {
                    // แก้ไขปาร์ตี้สมาชิกคนอื่น ๆ 
                    foreach(new member : Player) {
                        if (PlayerParty[member] == party) {
                            PlayerParty[member] = leader;
                            SendClientMessageEx(member, COLOR_YELLOW, "[Party]: %s คือผู้นำคนใหม่ (%s %s)", GetPlayerNameEx(leader), GetPlayerNameEx(playerid), szDisconnectReason[reason]);

                            new r, g, b, a;
                            HexToRGBA(GetPlayerColor(playerid), r, g, b, a);
                            SetPlayerMarkerForPlayer(member, playerid, RGBAToHex(r, g, b, 0x00));
                        }
                    }
                    //UpdatePartyMarker(leader);
                }
            }
            else {
                foreach(new member : Player) {
                    if (PlayerParty[member] == party) {
                        SendClientMessageEx(member, COLOR_YELLOW, "[Party]: %s ออกจากปาร์ตี้ (%s)", GetPlayerNameEx(playerid), szDisconnectReason[reason]);
                        
                        new r, g, b, a;
                        HexToRGBA(GetPlayerColor(playerid), r, g, b, a);
                        SetPlayerMarkerForPlayer(member, playerid, RGBAToHex(r, g, b, 0x00));
                    }
                }
                //UpdatePartyMarker(party);
            }
        }
        else {
            foreach(new member : Player) {
                if (PlayerParty[member] == party) {
                    SendClientMessageEx(member, COLOR_YELLOW, "[Party]: %s ออกจากปาร์ตี้ (%s)", GetPlayerNameEx(playerid), szDisconnectReason[reason]);
                    SendClientMessage(member, COLOR_YELLOW, "[Party]: ปาร์ตี้ในปัจจุบันของคุณถูกยุบ");
                    PlayerParty[member] = NO_PARTY;
                }
            } 
        }
    }
    return 1;
}
/*
UpdatePartyMarker(party)
{
    foreach(new i : Player) {
        if (PlayerParty[i] == party) {
            foreach(new member : Player) {
                if (PlayerParty[member] == party) {
                    SetPlayerMarkerForPlayer(i, member, GetPlayerColor(member));
                } else SetPlayerMarkerForPlayer(i, member, 0xFFFFFF00);
            }
        }
    }
}*/
