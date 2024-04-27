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
	SendClientMessageToAllEx(COLOR_RED, "[Government-OnDuty]:{FFFFFF} ตำรวจ: %d | หมอ: %d | ช่าง: %d", 
	CopOnline(), MedicOnline(), MechanicOnline());
}

forward SendMSG(type);
public SendMSG()
{
	new RandomMSG[][] =
	{
	    "[รู้หรือไม่?]: เวลาจริงจะแสดงบนหน้าจอของคุณ หากคุณมีนาฬิกาภายในตัว",
	    "[รู้หรือไม่?]: กดปุ่ม 'N' บริเวณท้ายยานพาหนะของคุณ เพื่อเปิดฝากระโปรงท้ายรถ",
	    "[รู้หรือไม่?]: กดปุ่ม 'N' บริเวณด้านหน้ายานพาหนะของคุณ เพื่อเปิดฝากระโปรงหน้ารถ",
	    "[รู้หรือไม่?]: กดปุ่ม 'H' และกดไอคอนรูป '$' บริเวณด้านล่าง เพื่อเป็นการให้เงินกับผู้เล่นรอบๆ ตัวของคุณ",
	    "[รู้หรือไม่?]: สามารถ /b เพื่อพิมพ์ข้อความ OOC ที่คุณต้องการจะสื่อสารกับผู้เล่นรอบๆ ตัวของคุณ",
	    "[รู้หรือไม่?]: การ /Tw เพื่อโพส Twitter นั้นจะติดคลูดาว แต่การโพสผ่านมือถือนั้นไม่",
	    "[รู้หรือไม่?]: หากบัคอยู่ต่างโลก สามารถแก้ด้วยวการ /fixbug",
	    "[รู้หรือไม่?]: คุณสามารถ /report เพื่อแจ้งปัญหาให้กับทางผู้ดูแลได้",
	    "[รู้หรือไม่?]: คุณสามารถ /toghub เพื่อปิด Textdraw ภายในหน้าจอได้",
	    "[รู้หรือไม่?]: หากพบเจอบัคหรือต้องการความช่วยเหลือ สามารถ '/report' หรือแจ้งได้ที่ {8D8DFF}Discord"
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
	    return SendClientMessage(playerid, COLOR_GREY, "/b [ข้อความ]");
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
	    return SendClientMessage(playerid, COLOR_GREY, "/me [ข้อความ]");

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
	    return SendClientMessage(playerid, COLOR_GREY, "/me [ข้อความ]");

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
	    return SendClientMessage(playerid, COLOR_GREY, "/do [ข้อความ]");

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
	    return SendClientMessage(playerid, COLOR_WHITE, "/s [ข้อความ]");

	if (strlen(params) > 64) {
	    SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s ตะโกน : %.64s", GetPlayerNameEx(playerid), params);
	    SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "...%s", params[64]);
	}
	else {
	    SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s ตะโกน : %s", GetPlayerNameEx(playerid), params);
	}
	return 1;
}
CMD:l(playerid, params[])
{
	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_WHITE, "/(l)ow [ข้อความ]");

	if (strlen(params) > 64) {
	    SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "%s พูดเบาๆ: %.64s", GetPlayerNameEx(playerid), params);
	    SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "...%s", params[64]);
	}
	else {
	    SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "%s พูดเบาๆ: %s", GetPlayerNameEx(playerid), params);
	}
	return 1;
}
CMD:fixbug(playerid, params[])
{
	if (playerData[playerid][pPrisoned] > 0)
 		return ErrorMsg(playerid, "- คุณติดคุกอยู่ไม่สามารถใช้งานคำสั่งได้");

	if (playerData[playerid][pJailTime] > 0)
 		return ErrorMsg(playerid, "- คุณติดคุกอยู่ไม่สามารถใช้งานคำสั่งได้");

	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SendClientMessage(playerid, COLOR_YELLOW, "[Fixbug]: คุณได้แก้บัคต่างโลกตัวละครของคุณสำเร็จ");
	return 1;
}

alias:fac("f")
CMD:fac(playerid, params[])
{
    new factionid = playerData[playerid][pFaction];

 	if (factionid == -1)
	    return 1;

	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_WHITE, "(/f)ac [ข้อความ OOC] {FF6347}*โปรดใช้อย่างระวัง");

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
	    return SendClientMessage(playerid, COLOR_WHITE, "(/r)adio [ข้อความ]");

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
	    return SendClientMessage(playerid, COLOR_WHITE, "(/d)ept [ข้อความ]");

	for (new i = 0; i != MAX_FACTIONS; i ++) if (factionData[i][factionType] == FACTION_POLICE || factionData[i][factionType] == FACTION_MEDIC || factionData[i][factionType] == FACTION_GOV)
		return SendFactionMessage(factionid, COLOR_YELLOW, "(( [%s] (%d)%s %s: %s ))", Faction_GetName(playerid), playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid), params);

	return 1;
}


alias:tw("tw")
CMD:tw(playerid, params[])
{
	if(!Inventory_HasItem(playerid, "iFruit"))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "[Twitter]: คุณจะเป็นต้องใช้มือถือในการโพส 'Twitter'");

	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_WHITE, "/tw [ข้อความ]");

	if (playerData[playerid][pOOCSpam] > 0)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "- คุณเหลือเวลาอีก '%d' วินาที เพื่อโพสต์ Twitter ใหม่อีกครั้ง", playerData[playerid][pOOCSpam]);
	
	{
		SendClientMessageToAllEx(COLOR_DARKBLUE, "[Twitter] %s: %s", GetPlayerNameEx(playerid), params);
	}
	playerData[playerid][pOOCSpam] = 60;
	return 1;
}



alias:undrag("ปล่อย")
CMD:unndrag(playerid, params[])
{
	new
	    userid;

    if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/unndrag [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถลากตัวเองได้");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ต้องไม่อยู่ในยานพาหนะ");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");

	if (!playerData[userid][pDragged])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้นั้นไม่ได้ถูกลากอยู่");

	if (playerData[userid][pDragged])
	{
	    playerData[userid][pDragged] = 0;
	    playerData[userid][pDraggedBy] = INVALID_PLAYER_ID;

	    KillTimer(playerData[userid][pDragTimer]);
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ปล่อยตัว %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	}
	return 1;
}







/*
alias:text("ส่งข้อความ")
CMD:text(playerid, params[])
{

    if (playerData[playerid][pPhoneOff])
		return SendClientMessage(playerid, COLOR_RED, "- คุณจำเป็นต้องเปิดเครื่องก่อน");

	static
	    targetid,
		number,
		text[128];

	if (sscanf(params, "ds[128]", number, text))
	    return SendClientMessage(playerid, COLOR_WHITE, "/text [เบอร์] [ข้อความ]");

	if (!number)
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่มีหมายเลขที่ท่านเรียก");

	if ((targetid = GetNumberOwner(number)) != INVALID_PLAYER_ID)
	{
	    if (targetid == playerid)
	        return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถส่งให้ตัวเองได้");

		if (playerData[targetid][pPhoneOff])
		    return SendClientMessage(playerid, COLOR_RED, "- หมายเลขที่ท่านเรียกไม่สามารถติดต่อได้ในขณะนี้");

        GivePlayerMoneyEx(playerid, -1);
		GameTextForPlayer(playerid, "You've been ~r~charged~w~ $1 to send a text.", 5000, 1);

		SendClientMessageEx(targetid, COLOR_YELLOW, "[ข้อความ]: %s - %s (%d)", text, GetPlayerNameEx(playerid), playerData[playerid][pPhone]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "[ข้อความ]: %s - %s (%d)", text, GetPlayerNameEx(playerid), playerData[playerid][pPhone]);

        PlayerPlaySoundEx(targetid, 21001);
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้หยิบมือถือขึ้นมาและกดส่งข้อความ", GetPlayerNameEx(playerid));
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "- ไม่มีหมายเลขที่ท่านเรียก");
	}
	return 1;
}*/

CMD:drag(playerid, params[])
{
	new
	    userid;

    if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/drag [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถลากตัวเองได้");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ต้องไม่อยู่ในยานพาหนะ");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");

	if (playerData[userid][pDragged])
	{
	    playerData[userid][pDragged] = 0;
	    playerData[userid][pDraggedBy] = INVALID_PLAYER_ID;

	    KillTimer(playerData[userid][pDragTimer]);
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ปล่อยตัว %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	}
	else
	{
	    playerData[userid][pDragged] = 1;
	    playerData[userid][pDraggedBy] = playerid;

	    playerData[userid][pDragTimer] = SetTimerEx("DragUpdate", 200, true, "dd", playerid, userid);
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้พาตัว %s ไปกับเขา", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	}
	return 1;
}

CMD:gov(playerid, params[])
{
    new factionid = playerData[playerid][pFaction];

	if (GovCD[playerid] != 0)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "* คุณต้องรอ %d วินาทีถึงจะใช้งานคำสั่งนี้ได้", GovCD[playerid]);

    if (playerData[playerid][pOOCSpam] > 0)
    	return SendClientMessageEx(playerid, COLOR_RED, "- ป้องกันการ Spam ข้อความ คุณเหลือเวลาอีก %d วินาที ในการใช้คำสั่งใหม่อีกครั้ง", playerData[playerid][pOOCSpam]);

 	if (factionid == -1)
	    return SendClientMessage(playerid, COLOR_GREY, "   คุณต้องเป็นสมาชิกของฝ่ายหรือกลุ่ม");

	if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
	    return 1;

	if (isnull(params))
		return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : {FFFFFF}/(gov)ernment (ข้อความ)");

	new string[128];
	format(string, sizeof(string), "[ %s ]", Faction_GetName(playerid));
	format(string, sizeof(string), "ประกาศ: %s", params);
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
		SendClientMessage(playerid,-1, "ผู้เล่นนั้นตัดการเชื่อมต่อหรือไม่ได้อยู่ใกล้คุณ");
		return 1;
	}

	for(new i = 0; i < MAX_DAMAGES; i++)
	{
	    if(DamageData[targetid][i][dExists])
		{
		    if(DamageData[targetid][i][dArmour] == 1)
			{
			    stringarmor = "โดน";
			}
			if(DamageData[targetid][i][dArmour] == 0)
			{
			    stringarmor = "ไม่โดน";
			}

			format(string, sizeof(string), "%s ดาเมจ %d จาก %s โดน%s (เกราะ: %s) %d วินาที่ที่ผ่านมา\n", string, DamageData[targetid][i][dDamage], ReturnWeaponName(DamageData[targetid][i][dWeaponid]), GetBodyPartName(DamageData[targetid][i][dShotType]), stringarmor, gettime()-DamageData[targetid][i][dSec]);
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
		SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: ทางเซิร์ฟเวอร์ไม่อนุญาติให้ใช้หมัด F ในทุกกรณี!!");
	}
	return 1;
}