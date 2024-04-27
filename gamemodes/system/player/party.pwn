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
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Party]: �س�������ö��ҹ Party ��㹢�з��س On Duty");

    if (PlayerParty[playerid]==NO_PARTY) 
        return Dialog_Show(playerid, DialogPartyCreate, DIALOG_STYLE_MSGBOX, "�к�������", "�س��ͧ������ҧ�����������?", "��", "���");

    else return Dialog_Show(playerid, DialogParty, DIALOG_STYLE_LIST, "�к�������", "��Ҫԡ\n�͡�ҡ������", "���͡", "�Դ");
}

ShowPartyList(playerid) {
    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
    new string[1024], string2[1024], var[32], count;

    if (PlayerParty[playerid] == playerid) {
        strcat(string, "������Ҫԡ");
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

    return Dialog_Show(playerid, DialogPartyList, DIALOG_STYLE_LIST, "��Ҫԡ㹻�����", string, "���͡", "�Դ");
}


Dialog:DialogPartyList(playerid, response, listitem, inputtext[])
{
    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
    if (response && PlayerParty[playerid] == playerid) {
        if (listitem == 0) {
            return Dialog_Show(playerid, DialogPartyAdd, DIALOG_STYLE_INPUT, "������Ҫԡ", "��͡�ʹռ����蹷���ͧ����ԭ", "�ԭ", "�Դ");
        }
        new var[15];
		format(var, sizeof(var), "PartyEdit_%d", listitem);
		new editid = GetPVarInt(playerid, var);

        if (IsPlayerConnected(editid)) {
            Party_Leave(editid, PlayerParty[editid], 4);
            /*SetPVarInt(playerid, "PartyEditID", editid);
            return Dialog_Show(playerid, DialogPartyEdit, DIALOG_STYLE_LIST, sprintf("��Ҫԡ㹻����� %s", ReturnRealName(editid)), "���͡�ҡ������", "���͡", "��Ѻ");*/
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
                       SendClientMessage(playerid, COLOR_LIGHTRED, "�س�������ö�е���ͧ�͡�ҡ��������");
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
            return SendClientMessage(playerid, COLOR_LIGHTRED, "- �����蹷��س��ͧ��è��ԭ��������ҵ�����������Ͷ�͡");

        if (IsPlayerConnected(targetid) && playerData[playerid][IsLoggedIn]) {
            if (PlayerParty[targetid] == NO_PARTY) {
                SetPVarInt(targetid, "PartyInvite", playerid);
                SendClientMessageEx(playerid, COLOR_YELLOW, "[Party]: �س���ԭ %s ����������������ͧ�س", GetPlayerNameEx(targetid));
                Dialog_Show(targetid, DialogPartyJoin, DIALOG_STYLE_MSGBOX, "�������������", "%s ���ԭ�س����������������ͧ��", "�������", "����ʸ", GetPlayerNameEx(playerid));
            }
            else SendClientMessage(playerid, COLOR_GRAD1, "   �����蹹���ջ�������������!");
        }
        else {
            SendClientMessage(playerid, COLOR_GRAD1, "   �����蹹���ѧ������������͡Ѻ���������!");
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
                    SendClientMessageEx(member, COLOR_YELLOW, "[Party]: %s �������������", GetPlayerNameEx(playerid));

                    ShowMarkers(member, playerid);
                }
            }
            // ResyncSkin(playerid);
        }
        else {
            SendClientMessage(playerid, COLOR_GRAD1, "   �����蹹�����������㹻���������!");
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
        SendClientMessageEx(playerid, COLOR_YELLOW, "[Party]: ������ͧ�س�١���ҧ���º��������");
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
                SendClientMessageEx(playerid, COLOR_YELLOW, "[Party]: �س���͡�ҡ����������");
                // ShowPartyMenu(playerid);
            }
            default: {
                PlayerParty[playerid]=playerid;
                SendClientMessageEx(playerid, COLOR_YELLOW, "[Party]: ������ͧ�س�١���ҧ���º��������");
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

        static const szDisconnectReason[5][] = {"��ش�͡�ҡ����","�͡�ҡ����","�١���͡�ҡ����","�͡�ҡ������","�١���͡�ҡ������"};

        new count = Party_Count(party);
        
        if (count > 1) {
            if (playerid == party) { // �繼���
                // �Ҽ��Ӥ�����
                new leader = INVALID_PLAYER_ID;

                foreach(new member : Player) {
                    if (PlayerParty[member] == party) {
                        leader = member;
                        break;
                    }
                }

                if (leader != INVALID_PLAYER_ID) {
                    // ��䢻�������Ҫԡ����� � 
                    foreach(new member : Player) {
                        if (PlayerParty[member] == party) {
                            PlayerParty[member] = leader;
                            SendClientMessageEx(member, COLOR_YELLOW, "[Party]: %s ��ͼ��Ӥ����� (%s %s)", GetPlayerNameEx(leader), GetPlayerNameEx(playerid), szDisconnectReason[reason]);

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
                        SendClientMessageEx(member, COLOR_YELLOW, "[Party]: %s �͡�ҡ������ (%s)", GetPlayerNameEx(playerid), szDisconnectReason[reason]);
                        
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
                    SendClientMessageEx(member, COLOR_YELLOW, "[Party]: %s �͡�ҡ������ (%s)", GetPlayerNameEx(playerid), szDisconnectReason[reason]);
                    SendClientMessage(member, COLOR_YELLOW, "[Party]: ������㹻Ѩ�غѹ�ͧ�س�١�غ");
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
