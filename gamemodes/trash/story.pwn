#include <YSI_Coding\y_hooks>

/// CODEING เก่งตี้ หมีขั้วโลก 

// ตัวแปรปฏิเสธ + เข้าร่วม
new ResponeStory[MAX_PLAYERS]; 

hook OnPlayerConnect(playerid)
{
    ResponeStory[playerid] = -1;
    return 1;
}
hook OnGameModeInit()
{
    CreateDynamic3DTextLabel("[!] {ffffff}คุณสามารถกด N เพื่อเปิดสตอรี่ฝ่ายตรงข้าม\nเมื่อเขาตอบรับจะสามารถมีสตอรี่กับฝ่ายตรงข้ามได้....", COLOR_RED,1156.0928,-2015.3251,69.0078, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (newkeys & KEY_NO && !IsPlayerInAnyVehicle(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1156.0928,-2015.3251,69.0078))
        {
           Dialog_Show(playerid, STORYPASS, DIALOG_STYLE_INPUT, "การเปิดสตอรี่ ?!", "โปรดใส่(ไอดี)หรือชื่อของหัวหน้าแก๊งค์นั้นๆเพื่อทำการเปิดสตอรี่", "ตกลง", "ยกเลิก");
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
	    return SendClientMessage(playerid, COLOR_RED, "[ ! ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

        /*if (playerData[userid][pFactionRank] < 4)
	    	return SendClientMessage(playerid, COLOR_RED, "ผู้เล่นนั้นต้องมีตำแหน่งมากกว่า 4 (Ranks 4)");*/

        if (playerData[playerid][pFactionRank] < 4)
	    	return SendClientMessage(playerid, COLOR_RED, "คุณนั้นต้องมีตำแหน่งมากกว่า 4 (Ranks 4)");
           
        if (GetFactionType(userid) == FACTION_POLICE || GetFactionType(userid) == FACTION_MEDIC || GetFactionType(userid) == FACTION_GOV)
        return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณไม่สามารถเปิดสตอรี่กับเจ้าหน้าที่ได้");

        if (GetFactionType(playerid) == FACTION_POLICE || GetFactionType(playerid) == FACTION_MEDIC || GetFactionType(playerid) == FACTION_GOV)
        return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณเป็นเจ้าหน้าที่ไม่สามารถเปิดสตอรี่ได้");

        if (sscanf(inputtext, "u", userid))
        return Dialog_Show(playerid, STORYPASS, DIALOG_STYLE_INPUT, "การเปิดสตอรี่ ?!", "โปรดใส่(ไอดี)หรือชื่อของหัวหน้าแก๊งค์นั้นๆเพื่อทำการเปิดสตอรี่", "ตกลง", "ยกเลิก");
        
        if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "[ ! ] {FFFFFF}ไม่สามารถท้าตัวเองได้");

        ResponeStory[userid] = playerid;
        new factionid = playerData[playerid][pFaction];
        format(str, sizeof(str), "%s จากแก๊งค์ %s ได้ทำการเปิดสตอรี่กับคุณตกลงที่จะร่วมด้วยไหม ?!" , GetPlayerNameEx(playerid), factionData[factionid][factionName]);
		Dialog_Show(userid, responsestroy, DIALOG_STYLE_MSGBOX, "{FFFFFF}[{CC2800}STORY{FFFFFF}]", str, "ตกลง", "ยกเลิก");
        return 1;
    }
    return 1;
}

Dialog:responsestroy(playerid, response, listitem, inputtext[])
{ 
    new userid = ResponeStory[playerid];
    if(response)
    {  
       SendClientMessageToAllEx(COLOR_RED, "%s จากแก๊งค์ %s ได้ท้าสตอรี่กับ %s",GetPlayerNameEx(playerid), Faction_GetName(playerid), Faction_GetName(userid));
       SendClientMessageEx(playerid, COLOR_RED, "%s จากแก๊งค์ %s ได้ยินยอมเข้าร่วมสตอรี่ในครั้งนี้ !!",GetPlayerNameEx(userid), Faction_GetName(userid));
       ResponeStory[playerid] = -1;
       ResponeStory[userid] = -1;
    }
    else
    {
       SendClientMessageEx(playerid, COLOR_RED, "%s จากแก๊งค์ %s ได้ปฏิเสธการเข้าร่วมสตอรี่กับคุณ", Faction_GetName(userid),Faction_GetName(userid));
       ResponeStory[playerid] = -1;
       ResponeStory[userid] = -1;
    }
    return 1;
}
