#include <YSI_Coding\y_hooks>

/// CODEING �觵�� ��բ����š 

// ����û���ʸ + �������
new ResponeStory[MAX_PLAYERS]; 

hook OnPlayerConnect(playerid)
{
    ResponeStory[playerid] = -1;
    return 1;
}
hook OnGameModeInit()
{
    CreateDynamic3DTextLabel("[!] {ffffff}�س����ö�� N �����Դʵ������µç����\n������ҵͺ�Ѻ������ö��ʵ����Ѻ���µç������....", COLOR_RED,1156.0928,-2015.3251,69.0078, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (newkeys & KEY_NO && !IsPlayerInAnyVehicle(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1156.0928,-2015.3251,69.0078))
        {
           Dialog_Show(playerid, STORYPASS, DIALOG_STYLE_INPUT, "����Դʵ���� ?!", "�ô���(�ʹ�)���ͪ��ͧ͢���˹���ꧤ�������ͷӡ���Դʵ����", "��ŧ", "¡��ԡ");
           return 1;
        }
    }
    return 1;
}

Dialog:STORYPASS(playerid, response, listitem, inputtext[])
{
    static
	    userid,
        str[150];
    
	if (response)
	{
        if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "[ ! ] {FFFFFF}�������ʹչ��������������");

        /*if (playerData[userid][pFactionRank] < 4)
	    	return SendClientMessage(playerid, COLOR_RED, "�����蹹�鹵�ͧ�յ��˹��ҡ���� 4 (Ranks 4)");*/

        if (playerData[playerid][pFactionRank] < 4)
	    	return SendClientMessage(playerid, COLOR_RED, "�س��鹵�ͧ�յ��˹��ҡ���� 4 (Ranks 4)");
           
        if (GetFactionType(userid) == FACTION_POLICE || GetFactionType(userid) == FACTION_MEDIC || GetFactionType(userid) == FACTION_GOV)
        return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س�������ö�Դʵ����Ѻ���˹�ҷ����");

        if (GetFactionType(playerid) == FACTION_POLICE || GetFactionType(playerid) == FACTION_MEDIC || GetFactionType(playerid) == FACTION_GOV)
        return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س�����˹�ҷ���������ö�Դʵ������");

        if (sscanf(inputtext, "u", userid))
        return Dialog_Show(playerid, STORYPASS, DIALOG_STYLE_INPUT, "����Դʵ���� ?!", "�ô���(�ʹ�)���ͪ��ͧ͢���˹���ꧤ�������ͷӡ���Դʵ����", "��ŧ", "¡��ԡ");
        
        if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "[ ! ] {FFFFFF}�������ö��ҵ���ͧ��");

        ResponeStory[userid] = playerid;
        new factionid = playerData[playerid][pFaction];
        format(str, sizeof(str), "%s �ҡ�ꧤ� %s ��ӡ���Դʵ����Ѻ�س��ŧ��������������� ?!" , GetPlayerNameEx(playerid), factionData[factionid][factionName]);
		Dialog_Show(userid, responsestroy, DIALOG_STYLE_MSGBOX, "{FFFFFF}[{CC2800}STORY{FFFFFF}]", str, "��ŧ", "¡��ԡ");
        return 1;
    }
    return 1;
}

Dialog:responsestroy(playerid, response, listitem, inputtext[])
{ 
    new userid = ResponeStory[playerid];
    if(response)
    {  
       SendClientMessageToAllEx(COLOR_RED, "%s �ҡ�ꧤ� %s ����ʵ����Ѻ %s",GetPlayerNameEx(playerid), Faction_GetName(playerid), Faction_GetName(userid));
       SendClientMessageEx(playerid, COLOR_RED, "%s �ҡ�ꧤ� %s ���Թ����������ʵ����㹤��駹�� !!",GetPlayerNameEx(userid), Faction_GetName(userid));
       ResponeStory[playerid] = -1;
       ResponeStory[userid] = -1;
    }
    else
    {
       SendClientMessageEx(playerid, COLOR_RED, "%s �ҡ�ꧤ� %s �黯��ʸ����������ʵ����Ѻ�س", Faction_GetName(userid),Faction_GetName(userid));
       ResponeStory[playerid] = -1;
       ResponeStory[userid] = -1;
    }
    return 1;
}
