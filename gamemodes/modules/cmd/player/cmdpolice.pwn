#include <YSI\y_hooks>

CMD:Acuff(playerid, params[]) {

	if (GetFactionType(playerid) != FACTION_POLICE)
		return 1;

	if(GetPVarType(playerid, "TacklingMode")) {
		SendClientMessage(playerid, COLOR_YELLOW, "- คุณได้ปิดโหมดการเข้าปะทะ ");
		DeletePVar(playerid, "TacklingMode");
	}
	else {
		SendClientMessage(playerid, COLOR_YELLOW, "- คุณได้เปิดโหมดการเข้าปะทะ (ต่อยที่ผู้เล่นเพื่อจับกุม)");
		SetPVarInt(playerid, "TacklingMode", 1);
	}
	return 1;
}
hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if(issuerid != INVALID_PLAYER_ID)
	{
		if(GetPVarType(issuerid, "TacklingMode") && weaponid == 0) {
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s วิ่งไปล็อค %s และกดลงกับพื้น", GetRoleplayName(issuerid), GetRoleplayName(playerid));
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
		return SendClientMessage(playerid, -1, "คุณต้องเป็นเจ้าหน้าที่ตำรวจ");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, -1, "/cuff [playerid/name]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, -1, "ผู้เล่นนั้นได้ตัดการเชื่อมต่อแล้ว");

    if (userid == playerid)
	    return SendClientMessage(playerid, -1, "คุณไม่สามารถใส่กุญแจมือตัวเองได้");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, -1, "คุณต้องอยู่ใกล้ผู้เล่นนั้น");

    if (Character[userid][Stunned] < 0 && GetPlayerSpecialAction(userid) != SPECIAL_ACTION_HANDSUP && !IsPlayerIdle(userid))
	    return SendClientMessage(playerid, -1, "ผู้เล่นนั้นต้องอยู่ในสถานะอัมพาตหรือมึนงง");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, -1, "ผู้เล่นนั้นต้องอยู่บนพื้นก่อนที่คุณจะใส่กุญแจมือพวกเขา");

    if (BitFlag_Get(g_PlayerFlags[userid],PLAYER_CUFFED))
        return SendClientMessage(playerid, -1, "ผู้เล่นนั้นถูกใส่กุญแจมือแล้ว");

	new
	    string[64];

    BitFlag_On(g_PlayerFlags[userid],PLAYER_CUFFED);
    SetPlayerSpecialAction(userid, SPECIAL_ACTION_CUFFED);
    SetPlayerAttachedObject(userid, 4, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);

	format(string, sizeof(string), "You've been ~r~cuffed~w~ by %s.", ReturnName(playerid, 0));
    ShowPlayerFooter(userid, string);

    SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จับข้อมือคู่นั้นของ %s อย่างรัดกุมพร้อมใส่กุญแจมือ", ReturnName(playerid, 0), ReturnName(userid, 0));
    return 1;
}