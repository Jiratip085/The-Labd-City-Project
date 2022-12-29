#include <YSI\y_hooks>

CMD:Acuff(playerid, params[]) {

	if (GetFactionType(playerid) != FACTION_POLICE)
		return 1;

	if(GetPVarType(playerid, "TacklingMode")) {
		SendClientMessage(playerid, COLOR_YELLOW, "- �س��Դ���������һз� ");
		DeletePVar(playerid, "TacklingMode");
	}
	else {
		SendClientMessage(playerid, COLOR_YELLOW, "- �س���Դ���������һз� (���·����������ͨѺ���)");
		SetPVarInt(playerid, "TacklingMode", 1);
	}
	return 1;
}
hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if(issuerid != INVALID_PLAYER_ID)
	{
		if(GetPVarType(issuerid, "TacklingMode") && weaponid == 0) {
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s ������ͤ %s ��С�ŧ�Ѻ���", GetRoleplayName(issuerid), GetRoleplayName(playerid));
			ApplyAnimation(issuerid, "PED", "EV_dive",4.1,0,1,1,0,0);
			ApplyAnimation(playerid, "PED", "FLOOR_hit_f",4.1,0,1,1,1,0);
			DeletePVar(issuerid, "TacklingMode");
            BitFlag_On(g_PlayerFlags[playerid],PLAYER_CUFFED);
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CUFFED);

			TogglePlayerControllable(playerid, false);
			return 0;
		}
    }
	return 1;
}
CMD:cuff(playerid, params[])
{
    new
	    userid;

	if (GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, -1, "�س��ͧ�����˹�ҷ����Ǩ");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, -1, "/cuff [playerid/name]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, -1, "�����蹹����Ѵ���������������");

    if (userid == playerid)
	    return SendClientMessage(playerid, -1, "�س�������ö���ح���͵���ͧ��");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, -1, "�س��ͧ�����������蹹��");

    if (Character[userid][Stunned] < 0 && GetPlayerSpecialAction(userid) != SPECIAL_ACTION_HANDSUP && !IsPlayerIdle(userid))
	    return SendClientMessage(playerid, -1, "�����蹹�鹵�ͧ�����ʶҹ�����ҵ�����ֹ��");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, -1, "�����蹹�鹵�ͧ���躹��鹡�͹���س�����ح���;ǡ��");

    if (BitFlag_Get(g_PlayerFlags[userid],PLAYER_CUFFED))
        return SendClientMessage(playerid, -1, "�����蹹�鹶١���ح��������");

	new
	    string[64];

    BitFlag_On(g_PlayerFlags[userid],PLAYER_CUFFED);
    SetPlayerSpecialAction(userid, SPECIAL_ACTION_CUFFED);
    SetPlayerAttachedObject(userid, 4, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);

	format(string, sizeof(string), "You've been ~r~cuffed~w~ by %s.", ReturnName(playerid, 0));
    ShowPlayerFooter(userid, string);

    SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ��Ѻ�����ͤ���鹢ͧ %s ���ҧ�Ѵ�����������ح����", ReturnName(playerid, 0), ReturnName(userid, 0));
    return 1;
}