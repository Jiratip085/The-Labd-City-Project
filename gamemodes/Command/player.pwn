#include	<YSI_Coding\y_hooks>

new bool:IsAFK[ MAX_PLAYERS char ];
new AFKTimer[MAX_PLAYERS];


hook OnGameModeInit()
{
    SetTimer("SendMSG", 60000*10, true);
    SetTimer("UpDateGovernMent", 60000*7, true);
}

forward UpDateGovernMent();
public UpDateGovernMent()
{
	SendClientMessageToAllEx(COLOR_RED, "[Government-OnDuty]:{FFFFFF} ���Ǩ: %d | ���: %d | ��ҧ: %d", 
	CopOnline(), MedicOnline(), MechanicOnline());
}

forward SendMSG(type);
public SendMSG()
{
	new RandomMSG[][] =
	{
	    "[����������?]: ���Ҩ�ԧ���ʴ���˹�Ҩͧ͢�س �ҡ�س�չ��ԡ����㹵��",
	    "[����������?]: ������ 'N' ����ǳ�����ҹ��˹Тͧ�س �����Դ�ҡ���ç����ö",
	    "[����������?]: ������ 'N' ����ǳ��ҹ˹���ҹ��˹Тͧ�س �����Դ�ҡ���ç˹��ö",
	    "[����������?]: ������ 'H' ��С��ͤ͹�ٻ '$' ����ǳ��ҹ��ҧ �����繡������Թ�Ѻ�������ͺ� ��Ǣͧ�س",
	    "[����������?]: ����ö /b ���;�����ͤ��� OOC ���س��ͧ��è�������áѺ�������ͺ� ��Ǣͧ�س",
	    "[����������?]: ��� /Tw ������ Twitter ��鹨еԴ��ٴ�� �����ʼ�ҹ��Ͷ�͹�����",
	    "[����������?]: �ҡ�Ѥ�����ҧ�š ����ö�����ǡ�� /fixbug",
	    "[����������?]: �س����ö /report �����駻ѭ�����Ѻ�ҧ��������",
	    "[����������?]: �س����ö /toghub ���ͻԴ Textdraw ����˹�Ҩ���",
	    "[����������?]: �ҡ���ͺѤ���͵�ͧ��ä������������ ����ö '/report' ���������� {8D8DFF}Discord"
	};
	new randMSG = random(sizeof(RandomMSG));

	SendClientMessageToAll(COLOR_YELLOW, RandomMSG[randMSG]);
}

CMD:ba(playerid, params[])
{
	UpDateGovernMent();
	return 1;
}
CMD:b(playerid, params[])
{
	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_GREY, "/b [��ͤ���]");
	if (strlen(params) > 64)
	{
	    SendNearbyMessage(playerid, 10.0, COLOR_GREY, "(( [OOC Chat] (%d)%s: %.64s", playerid, GetPlayerNameEx(playerid), params);
	    SendNearbyMessage(playerid, 10.0, COLOR_GREY, "...%s ))", params[64]);
	}
	else
	{
	    SendNearbyMessage(playerid, 10.0, COLOR_GREY, "(( [OOC Chat] (%d)%s: %.64s ))", playerid, GetPlayerNameEx(playerid), params);
	}
	return 1;
}

CMD:me(playerid, params[])
{

	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_GREY, "/me [��ͤ���]");

	if (strlen(params) > 64) {
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s %.64s", GetPlayerNameEx(playerid), params);
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "...%s", params[64]);
	}
	else {
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s %s", GetPlayerNameEx(playerid), params);
	}
	return 1;
}
CMD:ame(playerid, params[])
{

	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_GREY, "/me [��ͤ���]");

	if (strlen(params) > 64) {
	    //SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s %.64s", GetPlayerNameEx(playerid), params);
	    //SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "...%s", params[64]);
		SetPlayerChatBubble(playerid, params, COLOR_PURPLE, 10.0, 10000);
	}
	else {
	    //SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s %s", GetPlayerNameEx(playerid), params);
		SetPlayerChatBubble(playerid, params, COLOR_PURPLE, 10.0, 10000);
	}
	return 1;
}

CMD:do(playerid, params[])
{
	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_GREY, "/do [��ͤ���]");

	if (strlen(params) > 64) {
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %.64s", params);
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "...%s (( %s ))", params[64], GetPlayerNameEx(playerid));
	}
	else {
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s (( %s ))", params, GetPlayerNameEx(playerid));
	}
	return 1;
}

CMD:s(playerid, params[])
{
	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_WHITE, "/s [��ͤ���]");

	if (strlen(params) > 64) {
	    SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s ��⡹ : %.64s", GetPlayerNameEx(playerid), params);
	    SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "...%s", params[64]);
	}
	else {
	    SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s ��⡹ : %s", GetPlayerNameEx(playerid), params);
	}
	return 1;
}
CMD:l(playerid, params[])
{
	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_WHITE, "/(l)ow [��ͤ���]");

	if (strlen(params) > 64) {
	    SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "%s �ٴ���: %.64s", GetPlayerNameEx(playerid), params);
	    SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "...%s", params[64]);
	}
	else {
	    SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "%s �ٴ���: %s", GetPlayerNameEx(playerid), params);
	}
	return 1;
}
CMD:fixbug(playerid, params[])
{
	if (playerData[playerid][pPrisoned] > 0)
 		return ErrorMsg(playerid, "- �س�Դ�ء�����������ö��ҹ�������");

	if (playerData[playerid][pJailTime] > 0)
 		return ErrorMsg(playerid, "- �س�Դ�ء�����������ö��ҹ�������");

	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SendClientMessage(playerid, COLOR_YELLOW, "[Fixbug]: �س����Ѥ��ҧ�š����Фâͧ�س�����");
	return 1;
}

alias:fac("f")
CMD:fac(playerid, params[])
{
    new factionid = playerData[playerid][pFaction];

 	if (factionid == -1)
	    return 1;

	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_WHITE, "(/f)ac [��ͤ��� OOC] {FF6347}*�ô�����ҧ���ѧ");

	if (strlen(params) > 64)
	{
		SendFactionMessageEx(GetFactionType(playerid), factionData[factionid][factionColor], "(( (%d) %s %s: %.64s", playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid), params);
		SendFactionMessageEx(GetFactionType(playerid), factionData[factionid][factionColor], "...%s ))",params[64]);
	}
	else {
		SendFactionMessage(factionid, factionData[factionid][factionColor], "(( (%d) %s %s: %s ))", playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid), params);
	}
	return 1;
}

alias:radio("r")
CMD:radio(playerid, params[])
{
	new factionid = playerData[playerid][pFaction];

 	if (factionid == -1)
	    return 1;

	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_WHITE, "(/r)adio [��ͤ���]");

	if (strlen(params) > 64)
	{
		SendFactionMessageEx(GetFactionType(playerid), COLOR_RADIO, "(( (%d) %s %s: %.64s", playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid), params);
		SendFactionMessageEx(GetFactionType(playerid), COLOR_RADIO, "...%s ))",params[64]);
	}
	else {
		SendFactionMessage(factionid, COLOR_RADIO, "(( (%d) %s %s: %s ))", playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid), params);
	}
	return 1;
}

alias:dept("d")
CMD:dept(playerid, params[])
{
	new factionid = playerData[playerid][pFaction];

 	if (factionid == -1)
	    return 1;

	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV)
	    return 1;

	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_WHITE, "(/d)ept [��ͤ���]");

	for (new i = 0; i != MAX_FACTIONS; i ++) if (factionData[i][factionType] == FACTION_POLICE || factionData[i][factionType] == FACTION_MEDIC || factionData[i][factionType] == FACTION_GOV)
		return SendFactionMessage(factionid, COLOR_YELLOW, "(( [%s] (%d)%s %s: %s ))", Faction_GetName(playerid), playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid), params);

	return 1;
}


alias:tw("tw")
CMD:tw(playerid, params[])
{
	if(!Inventory_HasItem(playerid, "iFruit"))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "[Twitter]: �س���繵�ͧ����Ͷ��㹡���� 'Twitter'");

	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_WHITE, "/tw [��ͤ���]");

	if (playerData[playerid][pOOCSpam] > 0)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "- �س����������ա '%d' �Թҷ� �����ʵ� Twitter �����ա����", playerData[playerid][pOOCSpam]);
	
	{
		SendClientMessageToAllEx(COLOR_DARKBLUE, "[Twitter] %s: %s", GetPlayerNameEx(playerid), params);
	}
	playerData[playerid][pOOCSpam] = 60;
	return 1;
}



alias:undrag("�����")
CMD:unndrag(playerid, params[])
{
	new
	    userid;

    if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/unndrag [�ʹ�/����]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ��������������");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö�ҡ����ͧ��");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ���ͧ���������ҹ��˹�");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ��������������س");

	if (!playerData[userid][pDragged])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ���������١�ҡ����");

	if (playerData[userid][pDragged])
	{
	    playerData[userid][pDragged] = 0;
	    playerData[userid][pDraggedBy] = INVALID_PLAYER_ID;

	    KillTimer(playerData[userid][pDragTimer]);
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s �����µ�� %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	}
	return 1;
}







/*
alias:text("�觢�ͤ���")
CMD:text(playerid, params[])
{

    if (playerData[playerid][pPhoneOff])
		return SendClientMessage(playerid, COLOR_RED, "- �س���繵�ͧ�Դ����ͧ��͹");

	static
	    targetid,
		number,
		text[128];

	if (sscanf(params, "ds[128]", number, text))
	    return SendClientMessage(playerid, COLOR_WHITE, "/text [����] [��ͤ���]");

	if (!number)
	    return SendClientMessage(playerid, COLOR_RED, "- ����������Ţ����ҹ���¡");

	if ((targetid = GetNumberOwner(number)) != INVALID_PLAYER_ID)
	{
	    if (targetid == playerid)
	        return SendClientMessage(playerid, COLOR_RED, "- �������ö��������ͧ��");

		if (playerData[targetid][pPhoneOff])
		    return SendClientMessage(playerid, COLOR_RED, "- �����Ţ����ҹ���¡�������ö�Դ�����㹢�й��");

        GivePlayerMoneyEx(playerid, -1);
		GameTextForPlayer(playerid, "You've been ~r~charged~w~ $1 to send a text.", 5000, 1);

		SendClientMessageEx(targetid, COLOR_YELLOW, "[��ͤ���]: %s - %s (%d)", text, GetPlayerNameEx(playerid), playerData[playerid][pPhone]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "[��ͤ���]: %s - %s (%d)", text, GetPlayerNameEx(playerid), playerData[playerid][pPhone]);

        PlayerPlaySoundEx(targetid, 21001);
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ����Ժ��Ͷ�͢������С��觢�ͤ���", GetPlayerNameEx(playerid));
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "- ����������Ţ����ҹ���¡");
	}
	return 1;
}*/

CMD:drag(playerid, params[])
{
	new
	    userid;

    if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/drag [�ʹ�/����]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ��������������");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö�ҡ����ͧ��");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ���ͧ���������ҹ��˹�");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ʹչ��������������س");

	if (playerData[userid][pDragged])
	{
	    playerData[userid][pDragged] = 0;
	    playerData[userid][pDraggedBy] = INVALID_PLAYER_ID;

	    KillTimer(playerData[userid][pDragTimer]);
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s �����µ�� %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	}
	else
	{
	    playerData[userid][pDragged] = 1;
	    playerData[userid][pDraggedBy] = playerid;

	    playerData[userid][pDragTimer] = SetTimerEx("DragUpdate", 200, true, "dd", playerid, userid);
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��ҵ�� %s 仡Ѻ��", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	}
	return 1;
}

CMD:gov(playerid, params[])
{
    new factionid = playerData[playerid][pFaction];

	if (GovCD[playerid] != 0)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "* �س��ͧ�� %d �Թҷն֧����ҹ����觹����", GovCD[playerid]);

    if (playerData[playerid][pOOCSpam] > 0)
    	return SendClientMessageEx(playerid, COLOR_RED, "- ��ͧ�ѹ��� Spam ��ͤ��� �س����������ա %d �Թҷ� 㹡�������������ա����", playerData[playerid][pOOCSpam]);

 	if (factionid == -1)
	    return SendClientMessage(playerid, COLOR_GREY, "   �س��ͧ����Ҫԡ�ͧ�������͡����");

	if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
	    return 1;

	if (isnull(params))
		return SendClientMessage(playerid, COLOR_GREY, "�����ҹ : {FFFFFF}/(gov)ernment (��ͤ���)");

	new string[128];
	format(string, sizeof(string), "[ %s ]", Faction_GetName(playerid));
	format(string, sizeof(string), "��С��: %s", params);
	SendClientMessageToAll(factionData[factionid][factionColor], string);
	playerData[playerid][pOOCSpam] = 25;

	return 1;
}
/*
CMD:damages(playerid, params[])
{
	new targetid, string[2014], count, stringarmor[32];

	if (sscanf(params, "u", targetid))
		return SendClientMessage(playerid,-1, "/damages [playerid/name]");

	if (targetid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, targetid, 3.0))
	{
		SendClientMessage(playerid,-1, "�����蹹�鹵Ѵ���������������������������س");
		return 1;
	}

	for(new i = 0; i < MAX_DAMAGES; i++)
	{
	    if(DamageData[targetid][i][dExists])
		{
		    if(DamageData[targetid][i][dArmour] == 1)
			{
			    stringarmor = "ⴹ";
			}
			if(DamageData[targetid][i][dArmour] == 0)
			{
			    stringarmor = "���ⴹ";
			}

			format(string, sizeof(string), "%s ����� %d �ҡ %s ⴹ%s (����: %s) %d �Թҷ�����ҹ��\n", string, DamageData[targetid][i][dDamage], ReturnWeaponName(DamageData[targetid][i][dWeaponid]), GetBodyPartName(DamageData[targetid][i][dShotType]), stringarmor, gettime()-DamageData[targetid][i][dSec]);
			count++;
		}
	}
	return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_LIST, ReturnName(targetid), (count) ? (string) : (" "), "Close", "");
}*/
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_HANDBRAKE && newkeys & KEY_SECONDARY_ATTACK)
	{
		ClearAnimations(playerid);
		SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: �ҧ������������͹حҵ��������Ѵ F 㹷ء�ó�!!");
	}
	return 1;
}