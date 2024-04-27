#include <YSI_Coding\y_hooks>


#define NO_PARTY			INVALID_PLAYER_ID

new PlayerParty[MAX_PLAYERS];


new PlayerEdit_Name[MAX_PLAYERS][32];
new PlayerEdit_SQL[MAX_PLAYERS];


enum FACTION_DATA {
	factionID,
	factionExists,
	factionName[32],
	factionColor,
	factionType,
	factionRanks,
	factionTreasury,
	factionRedTreasury,
	Float:factionLockerPosX,
	Float:factionLockerPosY,
	Float:factionLockerPosZ,
	factionLockerInt,
	factionLockerWorld,
	factionSkins[8],
	factionWeapons[10],
	factionAmmo[10],
	Text3D:factionText3D,
	factionPickup,
	Float:SpawnX,
	Float:SpawnY,
	Float:SpawnZ,
	SpawnInterior,
	SpawnVW,
	factionEntrance,
	factionWarZone
};
new factionData[MAX_FACTIONS][FACTION_DATA];
new FactionRanks[MAX_FACTIONS][15][32];



hook OnPlayerConnect(playerid)
{
    format(PlayerEdit_Name[playerid], 24, "(null)");
    PlayerEdit_SQL[playerid] = -1;

}


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new factionid = playerData[playerid][pFaction];
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
		new id = FactionLocker_Nearest(playerid);
		if (id != -1)
		{
			
			if (factionid == -1)
				return 1;

			if (id != factionid)
				return 1;
			PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);

			if (factionData[factionid][factionType] == FACTION_TAXI)
				return Dialog_Show(playerid, DIALOG_LOCKER, DIALOG_STYLE_LIST, "[Locker]", "- เริ่ม/หยุด ปฏิบัติหน้าที่\n- เบิกเสื้อผ้า", "เลือก", "ออก");

			if (factionData[factionid][factionType] == FACTION_GANG)
				return Dialog_Show(playerid, DIALOG_LOCKER, DIALOG_STYLE_LIST, "[Locker]", "- เบิกเสื้อผ้า\n- คลังสิ่งของ\n- สมาชิก\n\
				{00FF00}คลังเงินถูกกฎหมาย: %s\n\
				{FF0000}คลังเงินผิดกฎหมาย: %s", "เลือก", "ออก", FormatMoney(factionData[factionid][factionTreasury]), FormatMoney(factionData[factionid][factionRedTreasury]));

			if (factionData[factionid][factionType] == FACTION_MEC || factionData[factionid][factionType] == FACTION_MEDIC)
				return Dialog_Show(playerid, DIALOG_LOCKER, DIALOG_STYLE_LIST, "[Locker]", "{FFFFFF}\
			- เริ่ม/หยุด ปฏิบัติหน้าที่\n\
			- เบิกเสื้อผ้า\n\
			- เบิกอุปกรณ์\n\
			- สมาชิก\
			{00FF00}คลังเงิน: %s", "เลือก", "ออก", FormatMoney(factionData[factionid][factionTreasury]));

			Dialog_Show(playerid, DIALOG_LOCKER, DIALOG_STYLE_LIST, "[Locker]", "{FFFFFF}\
			- เริ่ม/หยุด ปฏิบัติหน้าที่\n\
			- เบิกเสื้อผ้า\n\
			- เบิกอุปกรณ์\n\
			- คลังสิ่งของ\n\
			- สมาชิก\
			", "เลือก", "ออก");
			return 1;
		}
	}
	return 1;
}
FactionLocker_Nearest(playerid)
{
	for (new i = 0; i < MAX_FACTIONS; i ++) if (factionData[i][factionExists] && IsPlayerInRangeOfPoint(playerid, 2.0, factionData[i][factionLockerPosX], factionData[i][factionLockerPosY], factionData[i][factionLockerPosZ]))
		return i;
	return -1;
}


CMD:fsetting(playerid, params[])
{
	if (playerData[playerid][pFaction] == -1)
	    return 1;

	if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
	    return SendClientMessageEx(playerid, COLOR_LIGHTRED, "- คุณไม่เข้าถึงส่วนนี้ได้ เนื่องจากตำแหน่งของคุณนั้นไม่เพียงพอ (Rank : %d - %d)", factionData[playerData[playerid][pFaction]][factionRanks] - 1, factionData[playerData[playerid][pFaction]][factionRanks]);

	Dialog_Show(playerid, DIALOG_S_FACTION, DIALOG_STYLE_LIST, "Edit Faction", "{FFFFFF}- Members (สมาชิก)\n\
	- Invite (เชิญ)\n\
	- UnInvite (เตะ)\n\
	- Ranks (ตำแหน่ง)", "ตกลง", "ยกเลิก");
	return 1;
}



Dialog:DIALOG_S_FACTION(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
		    case 0: //สมาชิก
		    {
			 	new query[128];
				mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` WHERE `playerFaction` = %d", playerData[playerid][pFactionID]);
			 	mysql_tquery(g_SQL, query, "Leader_EditFaction", "ii", playerid, 1);
		    }
		    case 1: // เชิญ
		    {
				new query[512];
				mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` WHERE `playerFaction` = %d", playerData[playerid][pFactionID]);
			 	mysql_tquery(g_SQL, query, "Leader_EditFaction", "ii", playerid, 2);
		    }
		    case 2: // เตะ
		    {
				new query[512];
				mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` WHERE `playerFaction` = %d", playerData[playerid][pFactionID]);
			 	mysql_tquery(g_SQL, query, "Leader_EditFaction", "ii", playerid, 3);
		    }
		    case 3: // ตำแหน่ง
		    {
				new query[512];
				mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` WHERE `playerFaction` = %d", playerData[playerid][pFactionID]);
			 	mysql_tquery(g_SQL, query, "Leader_EditFaction", "ii", playerid, 3);
		    }
		}
	}
	return 1;
}

forward Leader_EditFaction(playerid, threadid);
public Leader_EditFaction(playerid, threadid)
{
    new string[2048], string5[2048];
    new name[25];
    new rows = cache_num_rows();

	switch(threadid)
    {
		case 1: //สมาชิก
		{
			new str[1024], factionid = playerData[playerid][pFaction];
		    format(str, sizeof(str), "{FFFFFF}%s", factionData[factionid][factionName]);

		    for(new i = 0; i < rows; i ++)
			{
			    cache_get_value_name(i, "playerName", name, 30);

				format(string, sizeof(string), "(%d) %s %s\n", playerData[i][pFactionRank], Faction_GetRank(i) ,name);
				strcat(string5, string);
			}

			format(string, sizeof(string), "ตำแหน่ง - รายชื่อ\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, str, string, "ปิด","");
		}
		case 2:
		{
			new str[1024], factionid = playerData[playerid][pFaction];
		    format(str, sizeof(str), "{ffffff}กลุ่ม : {FE5123}%s", factionData[factionid][factionName]);

		    for(new i = 0; i < rows; i ++)
		    {
			    cache_get_value_name(i, "playerName", name, 25);

				format(string, sizeof(string), "{FA3804}%d.\t{FDD9CF}%s\t{F9B306}%s\n", i+1, name);
				strcat(string5, string);
			}

			format(string, sizeof(string), "{FFFFFF}อันดับ\t{FFFFFF}ชื่อตัวละคร\n%s", string5);
			Dialog_Show(playerid, DIALOG_FACTION_SETTING, DIALOG_STYLE_TABLIST_HEADERS, str, string, "เตะออก","ยกเลิก");
		}
		case 3:
		{
			new str[1024], factionid = playerData[playerid][pFaction];
		    format(str, sizeof(str), "{ffffff}กลุ่ม : {FE5123}%s", factionData[factionid][factionName]);

		    for(new i = 0; i < rows; i ++)
		    {
			    cache_get_value_name(i, "playerName", name, 25);

				format(string, sizeof(string), "{FA3804}%d.\t{FDD9CF}%s\t{F9B306}%s\n", i+1, name);
				strcat(string5, string);
			}

			format(string, sizeof(string), "{FFFFFF}อันดับ\t{FFFFFF}ชื่อตัวละคร\n%s", string5);
			Dialog_Show(playerid, DIALOG_CHANGE_RANKS, DIALOG_STYLE_TABLIST_HEADERS, str, string, "ปรับยศ","ยกเลิก");
		}
	}
	return 1;
}

// ปรับยศสมาชิก
Dialog:DIALOG_CHANGE_RANKS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM players WHERE playerFaction = %d LIMIT %d, 1", playerData[playerid][pFactionID], listitem);
		mysql_tquery(g_SQL, query, "Faction_ChangeRanks", "i", playerid);
	}
	return 1;
}

forward Faction_ChangeRanks(playerid);
public Faction_ChangeRanks(playerid)
{
	static
	    rows;

	cache_get_row_count(rows);

	if(!rows)
	{
	    ErrorMsg(playerid, "ขณะนี้ระบบมีปัญหา กรุณาติดต่อแอดมิน...");
	}
	else
	{
	    new vid, name[25];
	    for(new i = 0; i < rows; i ++)
	    {
			cache_get_value_name_int(0, "playerID", vid);
			cache_get_value_name(0, "playerName", name, 25);
		}

	    format(PlayerEdit_Name[playerid], 24, name);
	    PlayerEdit_SQL[playerid] = vid;

		Dialog_Show(playerid, DIALOG_SET_RANKS, DIALOG_STYLE_INPUT, "{FC480F}การปรับ 'Ranks' สมาชิก", "{ffffff}กรุณาระบุตำแหน่งที่คุณต้องการจะปรับให้กับผู้เล่น {F4420A}%s :\n{F4420A}คำแนะนำ :: {FEE6C3}ยศของกลุ่มคุณต้องไม่ต่ำกว่า 1 และไม่เกิน %d เท่านั้น!", "ปรับยศ","ยกเลิก", name, factionData[playerData[playerid][pFaction]][factionRanks]);

		return 1;
	}
	return 1;
}

Dialog:DIALOG_SET_RANKS(playerid, response, listitem, inputtext[])
{
	new rankid = strval(inputtext), string[256], vid = PlayerEdit_SQL[playerid];
	if (response)
	{
		if (rankid < 1 || rankid > factionData[playerData[playerid][pFaction]][factionRanks])
		    return SendClientMessageEx(playerid, COLOR_LIGHTRED, "- ยศของกลุ่มคุณต้องไม่ต่ำกว่า 1 และไม่เกิน %d เท่านั้น!", factionData[playerData[playerid][pFaction]][factionRanks]);

		mysql_format(g_SQL, string, sizeof(string), "UPDATE `players` SET `playerFactionRank` = '%d' WHERE `playerID` = '%d'", rankid, vid);
		mysql_tquery(g_SQL, string);

		foreach (new i : Player)
		{
		    if (!strcmp(GetPlayerNameEx(i), PlayerEdit_Name[playerid], true))
		    {
    			SendClientMessageEx(i, COLOR_LIGHTBLUE, "%s {FFFFFF}ได้ปรับยศให้คุณเป็นยศ %s ระดับ (%d)", GetPlayerNameEx(playerid), Faction_GetRank(i), rankid);
			    playerData[i][pFactionRank] = rankid;
			    UpdateplayerData(i);
		    }
		}
    	SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ปรับยศให้สมาชิก {33CCFF}%s{FFFFFF} เป็นยศ %s ระดับ (%d)", PlayerEdit_Name[playerid], FactionRanks[playerData[playerid][pFaction]][rankid], rankid);

	    format(PlayerEdit_Name[playerid], 24, "(null)");
	    PlayerEdit_SQL[playerid] = -1;
	}
	return 1;
}

// เตะออกจากสมาชิก
Dialog:DIALOG_FACTION_SETTING(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM players WHERE playerFaction = %d LIMIT %d, 1", playerData[playerid][pFactionID], listitem);
		mysql_tquery(g_SQL, query, "FactionSettings", "i", playerid);
	}
	return 1;
}

forward FactionSettings(playerid);
public FactionSettings(playerid)
{
	static
	    rows, string[256];

	cache_get_row_count(rows);

	if(!rows)
	{
	    ErrorMsg(playerid, "ขณะนี้ระบบมีปัญหา กรุณาติดต่อแอดมิน...");
	}
	else
	{
	    new vid, name[25];
	    for(new i = 0; i < rows; i ++)
	    {
			cache_get_value_name_int(0, "playerID", vid);
			cache_get_value_name(0, "playerName", name, 25);
		}

		mysql_format(g_SQL, string, sizeof(string), "UPDATE `players` SET `playerFaction` = '-1' WHERE `playerID` = '%d'", vid);
		mysql_tquery(g_SQL, string);

		mysql_format(g_SQL, string, sizeof(string), "UPDATE `players` SET `playerFactionRank` = '0' WHERE `playerID` = '%d'", vid);
		mysql_tquery(g_SQL, string);

		foreach (new i : Player)
		{
		    if (!strcmp(GetPlayerNameEx(i), name, true))
		    {
			    SendClientMessageEx(i, COLOR_LIGHTBLUE, "%s {FFFFFF}ได้ถอนคุณออกจากกลุ่ม \"%s\"", GetPlayerNameEx(playerid), Faction_GetName(playerid));
			    ResetFaction(i);
			    UpdateplayerData(i);
		    }
		}
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "[เตะออกกลุ่ม] : คุณได้ทำการเตะ '%s' ออกจากการเป็นสมาชิกกลุ่ม!", name);
		return 1;
	}
	return 1;
}


Faction_Refresh(factionid)
{
	if (factionid != -1 && factionData[factionid][factionExists])
	{
	    if (factionData[factionid][factionLockerPosX] != 0.0 && factionData[factionid][factionLockerPosY] != 0.0 && factionData[factionid][factionLockerPosZ] != 0.0)
	    {
		    static
		        string[128];

			if (IsValidDynamicPickup(factionData[factionid][factionPickup]))
			    DestroyDynamicPickup(factionData[factionid][factionPickup]);

			if (IsValidDynamic3DTextLabel(factionData[factionid][factionText3D]))
			    DestroyDynamic3DTextLabel(factionData[factionid][factionText3D]);

			factionData[factionid][factionPickup] = CreateDynamicPickup(1239, 23, factionData[factionid][factionLockerPosX], factionData[factionid][factionLockerPosY], factionData[factionid][factionLockerPosZ], factionData[factionid][factionLockerWorld], factionData[factionid][factionLockerInt]);

			format(string, sizeof(string), "[%s]\nกด 'Y' เพื่อเปิด Locker", factionData[factionid][factionName]);
	  		factionData[factionid][factionText3D] = CreateDynamic3DTextLabel(string, COLOR_RADIO, factionData[factionid][factionLockerPosX], factionData[factionid][factionLockerPosY], factionData[factionid][factionLockerPosZ], 5.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, factionData[factionid][factionLockerWorld], factionData[factionid][factionLockerInt]);
		}
	}
	return 1;
}




alias:Invite("รับคน")
CMD:Invite(playerid, params[])
{
	new
	    userid;

	if (playerData[playerid][pFaction] == -1)
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ใช่หนึ่งในสมาชิกของกลุ่มใด ๆ");

	if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
	    return SendClientMessageEx(playerid, COLOR_RED, "- คุณต้องมียศอย่างน้อยระดับ %d", factionData[playerData[playerid][pFaction]][factionRanks] - 1);

	if (sscanf(params, "u", userid))
	    return SendClientMessageEx(playerid, COLOR_SERVER, "/รับคน [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (playerData[userid][pFaction] == playerData[playerid][pFaction])
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้เป็นส่วนหนึ่งของกลุ่มคุณอยู่แล้ว");

    if (playerData[userid][pFaction] != -1)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้มีกลุ่มอยู่แล้ว");

	playerData[userid][pSkinFaction] = 0;
	playerData[userid][pFactionOffer] = playerid;
    playerData[userid][pFactionOffered] = playerData[playerid][pFaction];

    SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ส่งคำขอให้ {33CCFF}%s {FFFFFF}ในการเข้าร่วมกลุ่ม \"%s\"", GetPlayerNameEx(userid), Faction_GetName(playerid));
    SendClientMessageEx(userid, COLOR_LIGHTBLUE, "%s {FFFFFF}ได้ส่งคำขอให้คุณในการเข้าร่วมกลุ่ม \"%s\" (พิมพ์ \"/ยอมรับ เข้าแก็ง\" ในการตอบข้อเสนอ)", GetPlayerNameEx(playerid), Faction_GetName(playerid));

	return 1;
}


CMD:uninvite(playerid, params[])
{
    new
	    userid;

	if (playerData[playerid][pFaction] == -1)
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ใช่หนึ่งในสมาชิกของกลุ่มใด ๆ");

	if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
	    return SendClientMessageEx(playerid, COLOR_RED, "- คุณต้องมียศอย่างน้อยระดับ %d", factionData[playerData[playerid][pFaction]][factionRanks] - 1);

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/เตะคน [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (playerData[userid][pFaction] != playerData[playerid][pFaction])
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่สามารถให้ยศสมาชิกกลุ่มอื่นได้");

	playerData[userid][pSkinFaction] = 0;
	SetPlayerSkin(playerid, playerData[playerid][pSkins]);
    SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ถอนสมาชิก {33CCFF}%s{FFFFFF} ออกจากกลุ่ม \"%s\"", GetPlayerNameEx(userid), Faction_GetName(playerid));
    SendClientMessageEx(userid, COLOR_LIGHTBLUE, "%s {FFFFFF}ได้ถอนคุณออกจากกลุ่ม \"%s\" เสียใจด้วย!", GetPlayerNameEx(playerid), Faction_GetName(playerid));

    ResetFaction(userid);

	return 1;
}

alias:editrank("เลื่อนยศ")
CMD:editrank(playerid, params[])
{
    new
	    userid,
		rankid;

	if (playerData[playerid][pFaction] == -1)
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ใช่หนึ่งในสมาชิกของกลุ่มใด ๆ");

	if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
	    return SendClientMessageEx(playerid, COLOR_RED, "- คุณต้องมียศอย่างน้อยระดับ %d", factionData[playerData[playerid][pFaction]][factionRanks] - 1);

	if (sscanf(params, "ud", userid, rankid))
	    return SendClientMessageEx(playerid, COLOR_WHITE, "/เลื่อนยศ [ไอดี/ชื่อ] [ยศ (1-%d)]", factionData[playerData[playerid][pFaction]][factionRanks]);

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถให้ยศตัวเองได้");

	if (playerData[userid][pFaction] != playerData[playerid][pFaction])
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่สามารถให้ยศสมาชิกกลุ่มอื่นได้");

	if (rankid < 0 || rankid > factionData[playerData[playerid][pFaction]][factionRanks])
	    return SendClientMessageEx(playerid, COLOR_RED, "- ยศของกลุ่มคุณต้องไม่ต่ำกว่า 1 และไม่เกิน %d เท่านั้น", factionData[playerData[playerid][pFaction]][factionRanks]);

	playerData[userid][pFactionRank] = rankid;

    SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ปรับยศให้สมาชิก {33CCFF}%s{FFFFFF} เป็นยศ %s ระดับ (%d)", GetPlayerNameEx(userid), Faction_GetRank(userid), rankid);
    SendClientMessageEx(userid, COLOR_LIGHTBLUE, "%s {FFFFFF}ได้ปรับยศให้คุณเป็นยศ %s ระดับ (%d)", GetPlayerNameEx(playerid), Faction_GetRank(userid), rankid);

	return 1;
}































Dialog:DIALOG_LOCKER(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);

	new 
		factionid = playerData[playerid][pFaction];

	if (factionid == -1 || !IsNearFactionLocker(playerid))
		return 0;

	if (response)
	{
	    static
	        string[512];

		string[0] = 0;

	    if (factionData[factionid][factionType] == FACTION_POLICE) //ตำรวจ
	    {
	        switch (listitem)
	        {
	            case 0:
	            {
	                if (!playerData[playerid][pOnDuty])
	                {
	                    playerData[playerid][pOnDuty] = true;
	                    SetFactionColor(playerid);
						SendFactionMessage(factionid, COLOR_RADIO, "(( [HQ] (%d)%s %s: ได้เริ่มปฏิบัติหน้าที่แล้วในขณะนี้ ))", playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid));
						

						foreach(new member : Player) 
						{
							PlayerParty[playerid] = playerData[member][pFaction];
							if (PlayerParty[member] == playerData[playerid][pFaction]) 
							{
								if(playerData[member][pOnDuty])
									ShowMarkers(member, playerid);
								
							}
						}

						if(playerData[playerid][pSkinFaction] > 0)
							return SetPlayerSkin(playerid, playerData[playerid][pSkinFaction]);
	                }
	                else
	                {
	                    playerData[playerid][pOnDuty] = false;
	                    playerData[playerid][pArmorOn] = false;
	                    SetPlayerArmour(playerid, 0.0);
						playerData[playerid][pArmour] = 0.0;

						PlayerParty[playerid]=NO_PARTY;
						RemoveMarkers(playerid);

	                    SetPlayerSkin(playerid, playerData[playerid][pSkins]);

						SendFactionMessage(factionid, COLOR_RADIO, "(( [HQ] (%d)%s %s: ได้หยุดปฏิบัติหน้าที่แล้วในขณะนี้ ))", 
						playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid));
	                    SetPlayerColor(playerid, DEFAULT_COLOR);
	                }
				}
				case 1:
				{
                    Dialog_Show(playerid, DIALOG_LOCKERSKIN, DIALOG_STYLE_LIST, "Skin (ชุด/เสื้อผ้า)", "- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d", "ตกลง", "ออก",
					factionData[factionid][factionSkins][0],
					factionData[factionid][factionSkins][1],
					factionData[factionid][factionSkins][2],
					factionData[factionid][factionSkins][3],
					factionData[factionid][factionSkins][4],
					factionData[factionid][factionSkins][5],
					factionData[factionid][factionSkins][6],
					factionData[factionid][factionSkins][7]);
				}
				case 2:
				{
					if (!playerData[playerid][pOnDuty])
						return SendClientMessage(playerid,COLOR_LIGHTRED,"- คุณจำเป็นต้อง On Duty เพื่อเบิกอุปกรณ์");

					Dialog_Show(playerid, DIALOG_PWONPEN, DIALOG_STYLE_LIST, "เบิกอุปกรณ์", "- Armor (100)\n- Nightstick\n- Spraycan (1,000)\n- Desert Eagle (50)\n- M4 (100)\n- Shorgun (25)", "เบิก", "ออก");
				}
				case 3: //คลัง
				{
					Dialog_Show(playerid, DIALOG_Treasury, DIALOG_STYLE_LIST, "คลังสิ่งของ", "{00FF00}คลังเงินถูกกฎหมาย: %s\n\
					{FF0000}คลังเงินผิดกฎหมาย: %s\n\
					{FFFFFF}คลังดินปืน: ", "เลือก", "ออก", 
					FormatMoney(factionData[factionid][factionTreasury]), FormatMoney(factionData[factionid][factionRedTreasury]));
				}
				case 4: //สมาชิก
				{
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` WHERE `playerFaction` = %d", playerData[playerid][pFactionID]);
					mysql_tquery(g_SQL, query, "Leader_EditFaction", "ii", playerid, 1);
				}
			}
	    }
	    else if (factionData[factionid][factionType] == FACTION_GOV) //สภา
	    {
	        switch (listitem)
	        {
	            case 0:
	            {
	                if (!playerData[playerid][pOnDuty])
	                {
	                    playerData[playerid][pOnDuty] = true;
	                    SetFactionColor(playerid);
						SendFactionMessage(factionid, COLOR_RADIO, "(( [HQ] (%d)%s %s: ได้เริ่มปฏิบัติหน้าที่แล้วในขณะนี้ ))", playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid));
						

						foreach(new member : Player) 
						{
							PlayerParty[playerid] = playerData[member][pFaction];
							if (PlayerParty[member] == playerData[playerid][pFaction]) 
							{
								if(playerData[member][pOnDuty])
									ShowMarkers(member, playerid);
								
							}
						}

						if(playerData[playerid][pSkinFaction] > 0)
							return SetPlayerSkin(playerid, playerData[playerid][pSkinFaction]);
	                }
	                else
	                {
	                    playerData[playerid][pOnDuty] = false;
	                    playerData[playerid][pArmorOn] = false;
	                    SetPlayerArmour(playerid, 0.0);
						playerData[playerid][pArmour] = 0.0;

						PlayerParty[playerid]=NO_PARTY;
						RemoveMarkers(playerid);

	                    SetPlayerSkin(playerid, playerData[playerid][pSkins]);

						SendFactionMessage(factionid, COLOR_RADIO, "(( [HQ] (%d)%s %s: ได้หยุดปฏิบัติหน้าที่แล้วในขณะนี้ ))", 
						playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid));
	                    SetPlayerColor(playerid, DEFAULT_COLOR);
	                }
				}
				case 1:
				{
                    Dialog_Show(playerid, DIALOG_LOCKERSKIN, DIALOG_STYLE_LIST, "Skin (ชุด/เสื้อผ้า)", "- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d", "ตกลง", "ออก",
					factionData[factionid][factionSkins][0],
					factionData[factionid][factionSkins][1],
					factionData[factionid][factionSkins][2],
					factionData[factionid][factionSkins][3],
					factionData[factionid][factionSkins][4],
					factionData[factionid][factionSkins][5],
					factionData[factionid][factionSkins][6],
					factionData[factionid][factionSkins][7]);
				}
				case 2:
				{
					if (!playerData[playerid][pOnDuty])
						return SendClientMessage(playerid,COLOR_LIGHTRED,"- คุณจำเป็นต้อง On Duty เพื่อเบิกอุปกรณ์");

					Dialog_Show(playerid, DIALOG_PWONPEN, DIALOG_STYLE_LIST, "เบิกอุปกรณ์", "- Armor (100)\n- Nightstick\n- Spraycan (1,000)\n- Desert Eagle (50)\n- M4 (100)\n- Shorgun (25)", "เบิก", "ออก");
				}
				case 3: //คลังเงิน
				{
					/*Dialog_Show(playerid, DIALOG_Treasury, DIALOG_STYLE_LIST, "คลังเงิน", "{FFFFFF}\
					- คลังเงิน: %s", "เลือก", "ออก", FormatMoney(factionData[factionid][factionTreasury]));*/
				}
				case 4: //สมาชิก
				{
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` WHERE `playerFaction` = %d", playerData[playerid][pFactionID]);
					mysql_tquery(g_SQL, query, "Leader_EditFaction", "ii", playerid, 1);
				}
			}
	    }
	    else if (factionData[factionid][factionType] == FACTION_MEDIC) //หมอ
	    {
	        switch (listitem)
	        {
	            case 0:
	            {
	                if (!playerData[playerid][pOnDuty])
	                {
	                    playerData[playerid][pOnDuty] = true;
	                    SetFactionColor(playerid);
						SendFactionMessage(factionid, COLOR_RADIO, "(( [HQ] (%d)%s %s: ได้เริ่มปฏิบัติหน้าที่แล้วในขณะนี้ ))", playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid));
						

						foreach(new member : Player) 
						{
							PlayerParty[playerid] = playerData[member][pFaction];
							if (PlayerParty[member] == playerData[playerid][pFaction]) 
							{
								if(playerData[member][pOnDuty])
									ShowMarkers(member, playerid);
								
							}
						}

						if(playerData[playerid][pSkinFaction] > 0)
							return SetPlayerSkin(playerid, playerData[playerid][pSkinFaction]);
	                }
	                else
	                {
	                    playerData[playerid][pOnDuty] = false;
	                    playerData[playerid][pArmorOn] = false;
	                    SetPlayerArmour(playerid, 0.0);
						playerData[playerid][pArmour] = 0.0;

						PlayerParty[playerid]=NO_PARTY;
						RemoveMarkers(playerid);

	                    SetPlayerSkin(playerid, playerData[playerid][pSkins]);

						SendFactionMessage(factionid, COLOR_RADIO, "(( [HQ] (%d)%s %s: ได้หยุดปฏิบัติหน้าที่แล้วในขณะนี้ ))", 
						playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid));
	                    SetPlayerColor(playerid, DEFAULT_COLOR);
	                }
				}
				case 1:
				{
                    Dialog_Show(playerid, DIALOG_LOCKERSKIN, DIALOG_STYLE_LIST, "Skin (ชุด/เสื้อผ้า)", "- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d", "ตกลง", "ออก",
					factionData[factionid][factionSkins][0],
					factionData[factionid][factionSkins][1],
					factionData[factionid][factionSkins][2],
					factionData[factionid][factionSkins][3],
					factionData[factionid][factionSkins][4],
					factionData[factionid][factionSkins][5],
					factionData[factionid][factionSkins][6],
					factionData[factionid][factionSkins][7]);
				}
				case 2:
				{
					new itemname[24];
					itemname = "MedicCase";
					new count = Inventory_Count(playerid, itemname);

					if(10 > playerData[playerid][pItemAmount]-count)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!", itemname);

					if (count >= playerData[playerid][pItemAmount])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!", itemname);

					new id = Inventory_Add(playerid, itemname, 10);

					if (id == -1)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ความจุของกระเป๋าของคุณนั้นเต็มแล้ว (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

					SendNearbyMessage(playerid, 5.0, COLOR_RADIO, "** %s เบิกอุปกรณ์ 'MedicCase'", GetPlayerNameEx(playerid));
				}
				case 3: //คลังเงิน
				{
					return Dialog_Show(playerid, DIALOG_Treasury_Type, DIALOG_STYLE_LIST, "คลังเงินถูกกฎหมาย", "{FFFFFF}\
					- ฝากเงิน\n\
					- เบิกเงิน\n\
					", "เลือก", "ออก");
				}
				case 4: //สมาชิก
				{
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` WHERE `playerFaction` = %d", playerData[playerid][pFactionID]);
					mysql_tquery(g_SQL, query, "Leader_EditFaction", "ii", playerid, 1);
				}
			}
	    }
	    else if (factionData[factionid][factionType] == FACTION_GANG) //แก๊ง
	    {
	        switch (listitem)
	        {
				case 0:
				{
                    Dialog_Show(playerid, DIALOG_LOCKERSKIN, DIALOG_STYLE_LIST, "Skin (ชุด/เสื้อผ้า)", "- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d", "ตกลง", "ออก",
					factionData[factionid][factionSkins][0],
					factionData[factionid][factionSkins][1],
					factionData[factionid][factionSkins][2],
					factionData[factionid][factionSkins][3],
					factionData[factionid][factionSkins][4],
					factionData[factionid][factionSkins][5],
					factionData[factionid][factionSkins][6],
					factionData[factionid][factionSkins][7]);
				}
				case 1: //คลังสิ่งของ
				{

				}
				case 2: //สมาชิก
				{
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` WHERE `playerFaction` = %d", playerData[playerid][pFactionID]);
					mysql_tquery(g_SQL, query, "Leader_EditFaction", "ii", playerid, 1);
				}
				case 3: //คลังเงิน
				{

				}
				case 4: //คลังเงินแดง
				{

				}
			}
	    }
	    else if (factionData[factionid][factionType] == FACTION_MEC) // ช่าง
	    {
	        switch (listitem)
	        {
	            case 0:
	            {
	                if (!playerData[playerid][pOnDuty])
	                {
	                    playerData[playerid][pOnDuty] = true;
	                    SetFactionColor(playerid);


						SendFactionMessage(factionid, COLOR_RADIO, "(( [HQ] (%d)%s %s: ได้เริ่มปฏิบัติหน้าที่แล้วในขณะนี้ ))", 
						playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid));

						if(playerData[playerid][pSkinFaction] > 0)
							return SetPlayerSkin(playerid, playerData[playerid][pSkinFaction]);
	                }
	                else
	                {
	                    playerData[playerid][pOnDuty] = false;
	                    playerData[playerid][pArmorOn] = false;
	                    SetPlayerArmour(playerid, 0.0);
						playerData[playerid][pArmour] = 0.0;
						
	                    SetPlayerColor(playerid, DEFAULT_COLOR);
	                    SetPlayerSkin(playerid, playerData[playerid][pSkins]);

						SendFactionMessage(factionid, COLOR_RADIO, "(( [HQ] (%d)%s %s: ได้หยุดปฏิบัติหน้าที่แล้วในขณะนี้ ))", 
						playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid));

	                }
				}
				case 1:
				{
                    Dialog_Show(playerid, DIALOG_LOCKERSKIN, DIALOG_STYLE_LIST, "Skin (ชุด/เสื้อผ้า)", "- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d", "ตกลง", "ออก",
					factionData[factionid][factionSkins][0],
					factionData[factionid][factionSkins][1],
					factionData[factionid][factionSkins][2],
					factionData[factionid][factionSkins][3],
					factionData[factionid][factionSkins][4],
					factionData[factionid][factionSkins][5],
					factionData[factionid][factionSkins][6],
					factionData[factionid][factionSkins][7]);
				}
				case 2:
				{
				    
				}
				case 3: //คลังเงิน
				{
					return Dialog_Show(playerid, DIALOG_Treasury_Type, DIALOG_STYLE_LIST, "คลังเงินถูกกฎหมาย", "{FFFFFF}\
					- ฝากเงิน\n\
					- เบิกเงิน\n\
					", "เลือก", "ออก");
				}
				case 4: //สมาชิก
				{
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` WHERE `playerFaction` = %d", playerData[playerid][pFactionID]);
					mysql_tquery(g_SQL, query, "Leader_EditFaction", "ii", playerid, 1);
				}
			}
	    }
	}
	return 1;
}



Dialog:DIALOG_Treasury(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if (response)
	{
		switch(listitem)
		{
		    case 0: //คลังเงินถูกกฎหมาย
				return Dialog_Show(playerid, DIALOG_Treasury_Type, DIALOG_STYLE_LIST, "คลังเงินถูกกฎหมาย", "{FFFFFF}\
				- ฝากเงินถูกกฎหมาย\n\
				- เบิกเงินถูกกฎหมาย\n\
				", "เลือก", "ออก");

			case 1: //คลังเงินผิดกฎหมาย
				return Dialog_Show(playerid, DIALOG_Treasury_RType, DIALOG_STYLE_LIST, "คลังเงินถูกกฎหมาย", "{FFFFFF}\
				- ฝากเงินผิดกฎหมาย\n\
				- เบิกเงินผิดกฎหมาย\n\
				", "เลือก", "ออก");

			case 2: //คลังดินปืน
			{
				if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "- คุณไม่เข้าถึงส่วนนี้ได้ เนื่องจากตำแหน่งของคุณนั้นไม่เพียงพอ (Rank : %d - %d)", factionData[playerData[playerid][pFaction]][factionRanks] - 1, factionData[playerData[playerid][pFaction]][factionRanks]);


			}
		}
	}
	return 1;
}
Dialog:DIALOG_Treasury_Type(playerid, response, listitem, inputtext[]) 
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if (response)
	{
		switch(listitem)
		{
		    case 0: //ฝาก
				return Dialog_Show(playerid, DIALOG_Treasury_TypeI, DIALOG_STYLE_INPUT, "คลังเงินถูกกฎหมาย", "โปรดระบุจำนวนเงินที่คุณต้องการจะฝากเข้าคลัง:", "ตกลง", "ออก");

			case 1: //เบิก
			{
				if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "- คุณไม่เข้าถึงส่วนนี้ได้ เนื่องจากตำแหน่งของคุณนั้นไม่เพียงพอ (Rank : %d - %d)", factionData[playerData[playerid][pFaction]][factionRanks] - 1, factionData[playerData[playerid][pFaction]][factionRanks]);


				return Dialog_Show(playerid, DIALOG_Treasury_TypeO, DIALOG_STYLE_INPUT, "คลังเงินถูกกฎหมาย", "โปรดระบุจำนวนเงินที่คุณต้องการจะเบิกเงินออกจากคลัง:", "ตกลง", "ออก");
			}

		}
	}
	return 1;
}
Dialog:DIALOG_Treasury_RType(playerid, response, listitem, inputtext[]) 
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if (response)
	{
		switch(listitem)
		{
		    case 0: //ฝาก
				return Dialog_Show(playerid, DIALOG_Treasury_RTypeI, DIALOG_STYLE_INPUT, "คลังเงินผิดกฎหมาย", "โปรดระบุจำนวนเงินที่คุณต้องการจะฝากเข้าคลัง:", "ตกลง", "ออก");

			case 1: //เบิก
			{
				if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "- คุณไม่เข้าถึงส่วนนี้ได้ เนื่องจากตำแหน่งของคุณนั้นไม่เพียงพอ (Rank : %d - %d)", factionData[playerData[playerid][pFaction]][factionRanks] - 1, factionData[playerData[playerid][pFaction]][factionRanks]);


				return Dialog_Show(playerid, DIALOG_Treasury_RTypeO, DIALOG_STYLE_INPUT, "คลังเงินผิดกฎหมาย", "โปรดระบุจำนวนเงินที่คุณต้องการจะเบิกเงินออกจากคลัง:", "ตกลง", "ออก");
			}

		}
	}
	return 1;
}
Dialog:DIALOG_Treasury_TypeI(playerid, response, listitem, inputtext[]) //ฝากเงินแดง
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new amount = strval(inputtext), factionid = playerData[playerid][pFaction];
	if (response)
	{

		if (sscanf(inputtext, "d", amount))
			return Dialog_Show(playerid, DIALOG_Treasury_TypeI, DIALOG_STYLE_INPUT, "คลังเงินถูกกฎหมาย", "โปรดระบุจำนวนเงินที่คุณต้องการจะฝากเข้าคลัง:", "ตกลง", "ออก");

		if (amount < 1 || amount > GetPlayerMoneyEx(playerid))
			return Dialog_Show(playerid, DIALOG_Treasury_TypeI, DIALOG_STYLE_INPUT, "คลังเงินถูกกฎหมาย", "โปรดระบุจำนวนเงินที่คุณต้องการจะฝากเข้าคลัง:\n{FF6347}*เกิดข้อผิดพลาดเกี่ยวกับจำนวนเงินที่คุณระบุ โปรดตรวจสอบใหม่อีกครั้ง", "ตกลง", "ออก");

		factionData[factionid][factionTreasury] += amount;
		GivePlayerMoneyEx(playerid, -amount);
		Faction_SaveTreasury(factionid);

		SendFactionMessage(factionid, factionData[factionid][factionColor], "(( (%d)%s %s: ได้ฝากเงินเข้าคลังเป็นจำนวน: %s ))", 
		playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid), FormatMoney(amount));
	}
	return 1;
}
Dialog:DIALOG_Treasury_TypeO(playerid, response, listitem, inputtext[]) //เบิกเงินเขียว
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new amount = strval(inputtext), factionid = playerData[playerid][pFaction];
	if (response)
	{
		if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
			return SendClientMessageEx(playerid, COLOR_RED, "- คุณไม่มีความสามารถในการเบิกเงินกองคลัง ระดับที่ต้องการคือ: %d", factionData[playerData[playerid][pFaction]][factionRanks] - 1);
		
		if (sscanf(inputtext, "d", amount))
			return Dialog_Show(playerid, DIALOG_Treasury_TypeO, DIALOG_STYLE_INPUT, "คลังเงินถูกกฎหมาย", "โปรดระบุจำนวนเงินที่คุณต้องการจะเบิกออกจากคลัง:", "ตกลง", "ออก");

		if (amount < 1 || amount > factionData[factionid][factionTreasury])
			return Dialog_Show(playerid, DIALOG_Treasury_TypeO, DIALOG_STYLE_INPUT, "คลังเงินถูกกฎหมาย", "โปรดระบุจำนวนเงินที่คุณต้องการจะเบิกออกจากคลัง:\n{FF6347}*เกิดข้อผิดพลาดเกี่ยวกับจำนวนเงินที่คุณระบุ โปรดตรวจสอบใหม่อีกครั้ง", "ตกลง", "ออก");

		factionData[factionid][factionTreasury]  -= amount;
		GivePlayerMoneyEx(playerid, amount);
		Faction_SaveTreasury(factionid);

		SendFactionMessage(factionid, factionData[factionid][factionColor], "(( (%d)%s %s: ได้เบิกเงินออกจากคลังเป็นจำนวน: %s ))", 
		playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid), FormatMoney(amount));
	}
	return 1;
}
Dialog:DIALOG_Treasury_RTypeI(playerid, response, listitem, inputtext[]) //ฝากเงินแดง
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new amount = strval(inputtext), factionid = playerData[playerid][pFaction];
	if (response)
	{

		if (sscanf(inputtext, "d", amount))
			return Dialog_Show(playerid, DIALOG_Treasury_RTypeI, DIALOG_STYLE_INPUT, "คลังเงินผิดกฎหมาย", "โปรดระบุจำนวนเงินที่คุณต้องการจะฝากเข้าคลัง:", "ตกลง", "ออก");

		if (amount < 1 || amount > GetPlayerRedMoney(playerid))
			return Dialog_Show(playerid, DIALOG_Treasury_RTypeI, DIALOG_STYLE_INPUT, "คลังเงินผิดกฎหมาย", "โปรดระบุจำนวนเงินที่คุณต้องการจะฝากเข้าคลัง:\n{FF6347}*เกิดข้อผิดพลาดเกี่ยวกับจำนวนเงินที่คุณระบุ โปรดตรวจสอบใหม่อีกครั้ง", "ตกลง", "ออก");

		factionData[factionid][factionRedTreasury] += amount;
		GivePlayerRedMoney(playerid, -amount);
		Faction_SaveTreasury(factionid);

		SendFactionMessage(factionid, factionData[factionid][factionColor], "(( (%d)%s %s: ได้ฝากเงินผิดกฎหมายเข้าคลังเป็นจำนวน: %s ))", 
		playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid), FormatMoney(amount));
	}
	return 1;
}
Dialog:DIALOG_Treasury_RTypeO(playerid, response, listitem, inputtext[]) //เบิกเงิน
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new amount = strval(inputtext), factionid = playerData[playerid][pFaction];
	if (response)
	{
		if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
			return SendClientMessageEx(playerid, COLOR_RED, "- คุณไม่มีความสามารถในการเบิกเงินกองคลัง ระดับที่ต้องการคือ: %d", factionData[playerData[playerid][pFaction]][factionRanks] - 1);
		
		if (sscanf(inputtext, "d", amount))
			return Dialog_Show(playerid, DIALOG_Treasury_RTypeO, DIALOG_STYLE_INPUT, "คลังเงินผิดกฎหมาย", "โปรดระบุจำนวนเงินที่คุณต้องการจะเบิกออกจากคลัง:", "ตกลง", "ออก");

		if (amount < 1 || amount > factionData[factionid][factionTreasury])
			return Dialog_Show(playerid, DIALOG_Treasury_RTypeO, DIALOG_STYLE_INPUT, "คลังเงินผิดกฎหมาย", "โปรดระบุจำนวนเงินที่คุณต้องการจะเบิกออกจากคลัง:\n{FF6347}*เกิดข้อผิดพลาดเกี่ยวกับจำนวนเงินที่คุณระบุ โปรดตรวจสอบใหม่อีกครั้ง", "ตกลง", "ออก");

		factionData[factionid][factionRedTreasury]  -= amount;
		GivePlayerRedMoney(playerid, amount);
		Faction_SaveTreasury(factionid);

		SendFactionMessage(factionid, factionData[factionid][factionColor], "(( (%d)%s %s: ได้เบิกเงินผิดกฎหมายออกจากคลังเป็นจำนวน: %s ))", 
		playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid), FormatMoney(amount));
	}
	return 1;
}


Dialog:DIALOG_PWONPEN(playerid, response, listitem, inputtext[]) //เบิกอุปกรณ์
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
				SendNearbyMessage(playerid, 15.0, COLOR_RADIO, "** %s เบิกอุปกรณ์ 'Armour'", GetPlayerNameEx(playerid));
				SetPlayerArmour(playerid, 100);
		    }
		    case 1:
		    {
				SendNearbyMessage(playerid, 15.0, COLOR_RADIO, "** %s เบิกอุปกรณ์ 'Nick Stick'", GetPlayerNameEx(playerid));
				GivePlayerWeaponEx(playerid, 3, 1);
		    }
		    case 2:
		    {
				SendNearbyMessage(playerid, 15.0, COLOR_RADIO, "** %s เบิกอุปกรณ์ 'Spray can'", GetPlayerNameEx(playerid));
				GivePlayerWeaponEx(playerid, 41, 1000);
		    }
		    case 3:
		    {
				SendNearbyMessage(playerid, 15.0, COLOR_RADIO, "** %s เบิกอุปกรณ์ 'Desert Eagle'", GetPlayerNameEx(playerid));
				GivePlayerWeaponEx(playerid, 24, 50);
		    }
		    case 4:
		    {
				SendNearbyMessage(playerid, 15.0, COLOR_RADIO, "** %s เบิกอุปกรณ์ 'M4'", GetPlayerNameEx(playerid));
				GivePlayerWeaponEx(playerid, 31, 100);
		    }
		    case 5:
		    {
				SendNearbyMessage(playerid, 15.0, COLOR_RADIO, "** %s เบิกอุปกรณ์ 'Shotgun'", GetPlayerNameEx(playerid));
				GivePlayerWeaponEx(playerid, 25, 25);
		    }
		}
	}
	return 1;
}
Dialog:DIALOG_LOCKERSKIN(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new factionid = playerData[playerid][pFaction];

	if (factionid == -1 || !IsNearFactionLocker(playerid))
		return 0;

	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		        if(factionData[factionid][factionSkins][0] == 0)
		            return 1;

		        playerData[playerid][pSkinFaction] = factionData[factionid][factionSkins][0];
				SetPlayerSkin(playerid, factionData[factionid][factionSkins][0]);
		    }
		    case 1:
		    {
		        if(factionData[factionid][factionSkins][1] == 0)
		            return 1;

		        playerData[playerid][pSkinFaction] = factionData[factionid][factionSkins][1];
				SetPlayerSkin(playerid, factionData[factionid][factionSkins][1]);
		    }
		    case 2:
		    {
		        if(factionData[factionid][factionSkins][2] == 0)
		            return 1;

		        playerData[playerid][pSkinFaction] = factionData[factionid][factionSkins][2];
				SetPlayerSkin(playerid, factionData[factionid][factionSkins][2]);
		    }
		    case 3:
		    {
		        if(factionData[factionid][factionSkins][3] == 0)
		            return 1;

		        playerData[playerid][pSkinFaction] = factionData[factionid][factionSkins][3];
				SetPlayerSkin(playerid, factionData[factionid][factionSkins][3]);
		    }
		    case 4:
		    {
		        if(factionData[factionid][factionSkins][4] == 0)
		            return 1;

		        playerData[playerid][pSkinFaction] = factionData[factionid][factionSkins][4];
				SetPlayerSkin(playerid, factionData[factionid][factionSkins][4]);
		    }
		    case 5:
		    {
		        if(factionData[factionid][factionSkins][5] == 0)
		            return 1;

		        playerData[playerid][pSkinFaction] = factionData[factionid][factionSkins][5];
				SetPlayerSkin(playerid, factionData[factionid][factionSkins][5]);
		    }
		    case 6:
		    {
		        if(factionData[factionid][factionSkins][6] == 0)
		            return 1;

		        playerData[playerid][pSkinFaction] = factionData[factionid][factionSkins][6];
				SetPlayerSkin(playerid, factionData[factionid][factionSkins][6]);
		    }
		    case 7:
		    {
		        if(factionData[factionid][factionSkins][7] == 0)
		            return 1;

		        playerData[playerid][pSkinFaction] = factionData[factionid][factionSkins][7];
				SetPlayerSkin(playerid, factionData[factionid][factionSkins][7]);
		    }
		}
	}
	return 1;
}

Dialog:DIALOG_FACTIONSKIN(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new factionid = playerData[playerid][pFactionEdit];

	if (factionid == -1)
	    return 0;

	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
				Dialog_Show(playerid, DIALOG_EDITSKIN, DIALOG_STYLE_LIST, "Skin (ชุด/เสื้อผ้า)", "- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d", "ตกลง", "ออก",
				factionData[factionid][factionSkins][0],
				factionData[factionid][factionSkins][1],
				factionData[factionid][factionSkins][2],
				factionData[factionid][factionSkins][3],
				factionData[factionid][factionSkins][4],
				factionData[factionid][factionSkins][5],
				factionData[factionid][factionSkins][6],
				factionData[factionid][factionSkins][7]);
			}
		}
	}
	return 1;
}

Dialog:DIALOG_EDITSKIN(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new factionid = playerData[playerid][pFactionEdit];

	if (factionid == -1)
	    return 0;

	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
                Dialog_Show(playerid, DIALOG_EDITSKIN1, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "กรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
			}
	        case 1:
	        {
                Dialog_Show(playerid, DIALOG_EDITSKIN2, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "กรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
			}
	        case 2:
	        {
                Dialog_Show(playerid, DIALOG_EDITSKIN3, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "กรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
			}
	        case 3:
	        {
                Dialog_Show(playerid, DIALOG_EDITSKIN4, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "กรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
			}
	        case 4:
	        {
                Dialog_Show(playerid, DIALOG_EDITSKIN5, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "กรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
			}
	        case 5:
	        {
                Dialog_Show(playerid, DIALOG_EDITSKIN6, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "กรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
			}
	        case 6:
	        {
                Dialog_Show(playerid, DIALOG_EDITSKIN7, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "กรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
			}
	        case 7:
	        {
                Dialog_Show(playerid, DIALOG_EDITSKIN8, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "กรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
			}
		}
	}
	return 1;
}

Dialog:DIALOG_EDITSKIN1(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new factionid = playerData[playerid][pFactionEdit];
	new number;

	if (factionid == -1)
	    return 0;

	if (response)
	{
		if(sscanf(inputtext, "i", number)) return Dialog_Show(playerid, DIALOG_EDITSKIN1, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "** เฉพาะตัวเลขเท่านั้น!\nกรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
		if(number < 1 || number > 312) return Dialog_Show(playerid, DIALOG_EDITSKIN1, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "** สกินมีแค่ 1-312 เท่านั้น!\nกรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
		factionData[factionid][factionSkins][0] = number;
		Faction_Save(factionid);
		Dialog_Show(playerid, DIALOG_EDITSKIN, DIALOG_STYLE_LIST, "Skin (ชุด/เสื้อผ้า)", "- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d", "ตกลง", "ออก",
		factionData[factionid][factionSkins][0],
		factionData[factionid][factionSkins][1],
		factionData[factionid][factionSkins][2],
		factionData[factionid][factionSkins][3],
		factionData[factionid][factionSkins][4],
		factionData[factionid][factionSkins][5],
		factionData[factionid][factionSkins][6],
		factionData[factionid][factionSkins][7]);
	}
	return 1;
}

Dialog:DIALOG_EDITSKIN2(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new factionid = playerData[playerid][pFactionEdit];
	new number;

	if (factionid == -1)
	    return 0;

	if (response)
	{
		if(sscanf(inputtext, "i", number)) return Dialog_Show(playerid, DIALOG_EDITSKIN2, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "** เฉพาะตัวเลขเท่านั้น!\nกรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
		if(number < 1 || number > 312) return Dialog_Show(playerid, DIALOG_EDITSKIN2, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "** สกินมีแค่ 1-312 เท่านั้น!\nกรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
		factionData[factionid][factionSkins][1] = number;
		Faction_Save(factionid);
		Dialog_Show(playerid, DIALOG_EDITSKIN, DIALOG_STYLE_LIST, "Skin (ชุด/เสื้อผ้า)", "- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d", "ตกลง", "ออก",
		factionData[factionid][factionSkins][0],
		factionData[factionid][factionSkins][1],
		factionData[factionid][factionSkins][2],
		factionData[factionid][factionSkins][3],
		factionData[factionid][factionSkins][4],
		factionData[factionid][factionSkins][5],
		factionData[factionid][factionSkins][6],
		factionData[factionid][factionSkins][7]);
	}
	return 1;
}

Dialog:DIALOG_EDITSKIN3(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new factionid = playerData[playerid][pFactionEdit];
	new number;

	if (factionid == -1)
	    return 0;

	if (response)
	{
		if(sscanf(inputtext, "i", number)) return Dialog_Show(playerid, DIALOG_EDITSKIN3, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "** เฉพาะตัวเลขเท่านั้น!\nกรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
		if(number < 1 || number > 312) return Dialog_Show(playerid, DIALOG_EDITSKIN3, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "** สกินมีแค่ 1-312 เท่านั้น!\nกรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
		factionData[factionid][factionSkins][2] = number;
		Faction_Save(factionid);
		Dialog_Show(playerid, DIALOG_EDITSKIN, DIALOG_STYLE_LIST, "Skin (ชุด/เสื้อผ้า)", "- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d", "ตกลง", "ออก",
		factionData[factionid][factionSkins][0],
		factionData[factionid][factionSkins][1],
		factionData[factionid][factionSkins][2],
		factionData[factionid][factionSkins][3],
		factionData[factionid][factionSkins][4],
		factionData[factionid][factionSkins][5],
		factionData[factionid][factionSkins][6],
		factionData[factionid][factionSkins][7]);
	}
	return 1;
}

Dialog:DIALOG_EDITSKIN4(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new factionid = playerData[playerid][pFactionEdit];
	new number;

	if (factionid == -1)
	    return 0;

	if (response)
	{
		if(sscanf(inputtext, "i", number)) return Dialog_Show(playerid, DIALOG_EDITSKIN4, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "** เฉพาะตัวเลขเท่านั้น!\nกรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
		if(number < 1 || number > 312) return Dialog_Show(playerid, DIALOG_EDITSKIN4, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "** สกินมีแค่ 1-312 เท่านั้น!\nกรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
		factionData[factionid][factionSkins][3] = number;
		Faction_Save(factionid);
		Dialog_Show(playerid, DIALOG_EDITSKIN, DIALOG_STYLE_LIST, "Skin (ชุด/เสื้อผ้า)", "- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d", "ตกลง", "ออก",
		factionData[factionid][factionSkins][0],
		factionData[factionid][factionSkins][1],
		factionData[factionid][factionSkins][2],
		factionData[factionid][factionSkins][3],
		factionData[factionid][factionSkins][4],
		factionData[factionid][factionSkins][5],
		factionData[factionid][factionSkins][6],
		factionData[factionid][factionSkins][7]);
	}
	return 1;
}

Dialog:DIALOG_EDITSKIN5(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new factionid = playerData[playerid][pFactionEdit];
	new number;

	if (factionid == -1)
	    return 0;

	if (response)
	{
		if(sscanf(inputtext, "i", number)) return Dialog_Show(playerid, DIALOG_EDITSKIN5, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "** เฉพาะตัวเลขเท่านั้น!\nกรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
		if(number < 1 || number > 312) return Dialog_Show(playerid, DIALOG_EDITSKIN5, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "** สกินมีแค่ 1-312 เท่านั้น!\nกรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
		factionData[factionid][factionSkins][4] = number;
		Faction_Save(factionid);
		Dialog_Show(playerid, DIALOG_EDITSKIN, DIALOG_STYLE_LIST, "Skin (ชุด/เสื้อผ้า)", "- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d", "ตกลง", "ออก",
		factionData[factionid][factionSkins][0],
		factionData[factionid][factionSkins][1],
		factionData[factionid][factionSkins][2],
		factionData[factionid][factionSkins][3],
		factionData[factionid][factionSkins][4],
		factionData[factionid][factionSkins][5],
		factionData[factionid][factionSkins][6],
		factionData[factionid][factionSkins][7]);
	}
	return 1;
}

Dialog:DIALOG_EDITSKIN6(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new factionid = playerData[playerid][pFactionEdit];
	new number;

	if (factionid == -1)
	    return 0;

	if (response)
	{
		if(sscanf(inputtext, "i", number)) return Dialog_Show(playerid, DIALOG_EDITSKIN6, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "** เฉพาะตัวเลขเท่านั้น!\nกรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
		if(number < 1 || number > 312) return Dialog_Show(playerid, DIALOG_EDITSKIN6, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "** สกินมีแค่ 1-312 เท่านั้น!\nกรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
		factionData[factionid][factionSkins][5] = number;
		Faction_Save(factionid);
		Dialog_Show(playerid, DIALOG_EDITSKIN, DIALOG_STYLE_LIST, "Skin (ชุด/เสื้อผ้า)", "- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d", "ตกลง", "ออก",
		factionData[factionid][factionSkins][0],
		factionData[factionid][factionSkins][1],
		factionData[factionid][factionSkins][2],
		factionData[factionid][factionSkins][3],
		factionData[factionid][factionSkins][4],
		factionData[factionid][factionSkins][5],
		factionData[factionid][factionSkins][6],
		factionData[factionid][factionSkins][7]);
	}
	return 1;
}

Dialog:DIALOG_EDITSKIN7(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new factionid = playerData[playerid][pFactionEdit];
	new number;

	if (factionid == -1)
	    return 0;

	if (response)
	{
		if(sscanf(inputtext, "i", number)) return Dialog_Show(playerid, DIALOG_EDITSKIN7, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "** เฉพาะตัวเลขเท่านั้น!\nกรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
		if(number < 1 || number > 312) return Dialog_Show(playerid, DIALOG_EDITSKIN7, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "** สกินมีแค่ 1-312 เท่านั้น!\nกรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
		factionData[factionid][factionSkins][6] = number;
		Faction_Save(factionid);
		Dialog_Show(playerid, DIALOG_EDITSKIN, DIALOG_STYLE_LIST, "Skin (ชุด/เสื้อผ้า)", "- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d", "ตกลง", "ออก",
		factionData[factionid][factionSkins][0],
		factionData[factionid][factionSkins][1],
		factionData[factionid][factionSkins][2],
		factionData[factionid][factionSkins][3],
		factionData[factionid][factionSkins][4],
		factionData[factionid][factionSkins][5],
		factionData[factionid][factionSkins][6],
		factionData[factionid][factionSkins][7]);
	}
	return 1;
}

Dialog:DIALOG_EDITSKIN8(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new factionid = playerData[playerid][pFactionEdit];
	new number;

	if (factionid == -1)
	    return 0;

	if (response)
	{
		if(sscanf(inputtext, "i", number)) return Dialog_Show(playerid, DIALOG_EDITSKIN8, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "** เฉพาะตัวเลขเท่านั้น!\nกรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
		if(number < 1 || number > 312) return Dialog_Show(playerid, DIALOG_EDITSKIN8, DIALOG_STYLE_INPUT, "Skin (ชุด/เสื้อผ้า)", "** สกินมีแค่ 1-312 เท่านั้น!\nกรุณาใส่เลขสกินที่ต้องการลงไป", "ตกลง", "ออก");
		factionData[factionid][factionSkins][7] = number;
		Faction_Save(factionid);
		Dialog_Show(playerid, DIALOG_EDITSKIN, DIALOG_STYLE_LIST, "Skin (ชุด/เสื้อผ้า)", "- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d\n- %d", "ตกลง", "ออก",
		factionData[factionid][factionSkins][0],
		factionData[factionid][factionSkins][1],
		factionData[factionid][factionSkins][2],
		factionData[factionid][factionSkins][3],
		factionData[factionid][factionSkins][4],
		factionData[factionid][factionSkins][5],
		factionData[factionid][factionSkins][6],
		factionData[factionid][factionSkins][7]);
	}
	return 1;
}















forward Faction_Load();
forward Faction_Load();
public Faction_Load()
{
	static
	    rows,
		str[32];

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_FACTIONS)
	{
	    factionData[i][factionExists] = true;
	    cache_get_value_name_int(i, "factionID", factionData[i][factionID]);

	    cache_get_value_name(i, "factionName", factionData[i][factionName], 32);

	    cache_get_value_name_int(i, "factionColor", factionData[i][factionColor]);
	    cache_get_value_name_int(i, "factionType", factionData[i][factionType]);
	    cache_get_value_name_int(i, "factionRanks", factionData[i][factionRanks]);
	    cache_get_value_name_int(i, "factionTreasury", factionData[i][factionTreasury]);
	    cache_get_value_name_int(i, "factionRedTreasury", factionData[i][factionRedTreasury]);
	    cache_get_value_name_float(i, "factionLockerX", factionData[i][factionLockerPosX]);
	    cache_get_value_name_float(i, "factionLockerY", factionData[i][factionLockerPosY]);
	    cache_get_value_name_float(i, "factionLockerZ", factionData[i][factionLockerPosZ]);
	    cache_get_value_name_int(i, "factionLockerInt", factionData[i][factionLockerInt]);
	    cache_get_value_name_int(i, "factionLockerWorld", factionData[i][factionLockerWorld]);

		//Spawning
		cache_get_value_name_float(i, "SpawnX", factionData[i][SpawnX]);
	 	cache_get_value_name_float(i, "SpawnY", factionData[i][SpawnY]);
   		cache_get_value_name_float(i, "SpawnZ", factionData[i][SpawnZ]);
		cache_get_value_name_int(i, "SpawnInterior", factionData[i][SpawnInterior]);
  		cache_get_value_name_int(i, "SpawnVW", factionData[i][SpawnVW]);

  		cache_get_value_name_int(i, "factionEntrance", factionData[i][factionEntrance]);

	    for (new j = 0; j < 8; j ++)
		{
	        format(str, sizeof(str), "factionSkin%d", j + 1);

	        cache_get_value_name_int(i, str, factionData[i][factionSkins][j]);
		}
        for (new j = 0; j < 10; j ++)
		{
	        format(str, sizeof(str), "factionWeapon%d", j + 1);

	        cache_get_value_name_int(i, str, factionData[i][factionWeapons][j]);

	        format(str, sizeof(str), "factionAmmo%d", j + 1);

			cache_get_value_name_int(i, str, factionData[i][factionAmmo][j]);
		}
		for (new j = 0; j < 15; j ++)
		{
		    format(str, sizeof(str), "factionRank%d", j + 1);

		    cache_get_value_name(i, str, FactionRanks[i][j]);
		}
		Faction_Refresh(i);
	}
	printf("[PondJirasak]: Faction load %d ", rows);
	return 1;
}


Faction_SaveTreasury(factionid)
{
	static
	    query[768];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE `factions` SET `factionTreasury` = %d, `factionRedTreasury` = %d WHERE `factionID` = '%d'",
	    factionData[factionid][factionTreasury],
		factionData[factionid][factionRedTreasury],
	    factionData[factionid][factionID]
	);
	return mysql_tquery(g_SQL, query);
}



/*
Faction_SaveEquipment(factionid)
{
	static
	    query[768];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE `factions` SET `factionGunpowder` = '%d' = '%d'",
	    factionData[factionid][factionGunpowder],
	    factionData[factionid][factionID]
	);
	return mysql_tquery(g_SQL, query);
}*/



ptask PartyUpdateTimer[1000](playerid) 
{
    if(PlayerParty[playerid] != NO_PARTY && playerData[playerid][IsLoggedIn]) 
    {
        foreach(new i : Player)
        {
            if (i != playerid && PlayerParty[playerid] == PlayerParty[i] && playerData[playerid][IsLoggedIn] && playerData[playerid][pWorld] == playerData[i][pWorld] && playerData[playerid][pInterior] == playerData[i][pInterior] 
            || i != playerid && PlayerParty[playerid] == PlayerParty[i] && playerData[playerid][IsLoggedIn] && playerData[playerid][pWorld] == playerData[i][pWorld] && playerData[playerid][pInterior] == playerData[i][pInterior] && playerData[playerid][pOnDuty]) {
                ShowMarkers(playerid, i);
            }
        }
    }
}

ShowMarkers(playerid, memberid)
{
    new r, g, b, a;
	if(PlayerParty[playerid] != NO_PARTY) {
        HexToRGBA(GetPlayerColor(memberid), r, g, b, a);
        SetPlayerMarkerForPlayer(playerid, memberid, RGBAToHex(r, g, b, 0xFF));
    }
    /*else {
        HexToRGBA(GetPlayerColor(memberid), r, g, b, a);
        SetPlayerMarkerForPlayer(playerid, memberid, RGBAToHex(r, g, b, 0x00));
    }*/
}

stock RGBAToHex(r, g, b, a) //By Betamaster
{
    return (r<<24 | g<<16 | b<<8 | a);
}

stock HexToRGBA(colour, &r, &g, &b, &a) //By Betamaster
{
    r = (colour >> 24) & 0xFF;
    g = (colour >> 16) & 0xFF;
    b = (colour >> 8) & 0xFF;
    a = colour & 0xFF;
}

RemoveMarkers(playerid)
{
    new r, g, b, a;
    foreach(new i : Player)
    {
        if (playerid != i && playerData[playerid][IsLoggedIn]) {
            HexToRGBA(GetPlayerColor(i), r, g, b, a);
            SetPlayerMarkerForPlayer(playerid, i, RGBAToHex(r, g, b, 0x00));
        }
    }   
}

RemoveOtherMarkers(playerid)
{
    new r, g, b, a;
    foreach(new i : Player)
    {
        if (playerid != i && playerData[playerid][IsLoggedIn]) {
            HexToRGBA(GetPlayerColor(playerid), r, g, b, a);
            SetPlayerMarkerForPlayer(i, playerid, RGBAToHex(r, g, b, 0x00));
        }
    }   
}


ClearCrime(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		RemoveOtherMarkers(playerid);
	}
	return 1;
}
