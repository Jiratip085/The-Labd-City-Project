#include <YSI_Coding\y_hooks>

new CheckCase[MAX_PLAYERS] = 0;
new IdCheckCase[MAX_PLAYERS] = 0;
new playerNearSelectCase[MAX_PLAYERS][20];
new CallCase[MAX_PLAYERS];
new CaseType[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    CheckCase[playerid] = 0;
    IdCheckCase[playerid] = 0;
    CallCase[playerid] = 0;
    CaseType[playerid] = 0;
}

alias:checkcase("6")
CMD:checkcase(playerid, params[])
{
	if (GetFactionType(playerid) == FACTION_POLICE)
	{
		Dialog_Show(playerid, Dialog_CASE_TYPE, DIALOG_STYLE_LIST, "{037DE4}[ MDC ]", "{037DE4}+ {ffffff}ดูรายชื่อผู้ทำงานผิดกฎหมาย\n{037DE4}+ {ffffff}ยกเลิกรายชื่อผู้ทำงานผิดกฎหมาย", "ตกลง", "ปิด");
	}

	else if (GetFactionType(playerid) == FACTION_MEC)
	{
  		Dialog_Show(playerid, Dialog_MEC_TYPE, DIALOG_STYLE_LIST, "{5A5657}[ MDC ]", "{5A5657}+ {ffffff}ดูรายชื่อผู้ที่ต้องการช่างซ่อมรถ\n{5A5657}+ {ffffff}ยกเลิกรายชื่อผู้ที่ต้องการช่างซ่อมรถ", "ตกลง", "ปิด");
	}
	else ErrorMsg(playerid, "สำหรับตำรวจหรือแพทย์หรือช่างซ่อมรถเท่านั้น!");
	return 1;
}

Dialog:Dialog_CASE_TYPE(playerid, response, listitem, inputtext[])
{
	new
		str[1024],
		count;

    if(response)
    {
        if(listitem == 0)
        {
			foreach (new i : Player)
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(i, x,y,z);

				if (CallCase[i] == 1)
				{
					format(str, sizeof(str), "%s {50DCFB}(ไอดี:%d) %s\t{ffffff}ความผิด:%s\t{ffffff}%.1fm\n", str, i, GetPlayerNameEx(i), CASE_Name(i), GetPlayerDistanceFromPoint(playerid, x, y, z));
					playerNearSelectCase[playerid][count] = i;
					count++;

					if(count == 20) break;
				}
			}
		 	if(!count) ErrorMsg(playerid, "ไม่พบผู้ทำงานผิดกฎหมาย!");
		  	else Dialog_Show(playerid, Dialog_NearCase, DIALOG_STYLE_TABLIST, "{037DE4}[ รายชื่อผู้ทำงานผิดกฎหมาย ]", str, "ตกลง", "ปิด");
		}
        if(listitem == 1)
        {
			foreach (new i : Player)
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(i, x,y,z);

				if (CallCase[i] == 1)
				{
					format(str, sizeof(str), "%s {FB9E6C}(ไอดี:%d) %s\t{ffffff}ความผิด:%s\t{ffffff}%.1fm\n", str, i, GetPlayerNameEx(i), CASE_Name(i), GetPlayerDistanceFromPoint(playerid, x, y, z));
					playerNearSelectCase[playerid][count] = i;
					count++;

					if(count == 20) break;
				}
			}
		 	if(!count) ErrorMsg(playerid, "ไม่พบผู้ทำงานผิดกฎหมาย!");
		  	else Dialog_Show(playerid, Dialog_CANCEL_CASE, DIALOG_STYLE_TABLIST, "{ED381F}[ ยกเลิกรายชื่อผู้ทำงานผิดกฎหมาย ]", str, "ตกลง", "ปิด");
		}
	}
	return 1;
}

Dialog:Dialog_CANCEL_CASE(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    if(listitem != -1 && listitem != 21)
    {
        if (playerNearSelectCase[playerid][listitem] == playerid)
            return ErrorMsg(playerid, "คุณไม่สามารถยกเลิกตัวเองได้!");

        CallCase[playerNearSelectCase[playerid][listitem]] = 0;

        SendClientMessageEx(playerNearSelectCase[playerid][listitem], COLOR_LIGHTRED, "[!] เจ้าหน้าที่ตำรวจ %s ได้ยกเลิกหมายจับของคุณ !", GetPlayerNameEx(playerid));
        SendFactionMessageEx(FACTION_POLICE, COLOR_LIGHTRED, "[!] {ffffff}%s ได้ยกเลิกหมายจับ %s", GetPlayerNameEx(playerid), GetPlayerNameEx(playerNearSelectCase[playerid][listitem]));
        return true;
    }
    return 1;
}

Dialog:Dialog_NearCase(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    if(listitem != -1 && listitem != 21)
    {
        if (playerNearSelectCase[playerid][listitem] == playerid)
            return ErrorMsg(playerid, "คุณไม่สามารถค้นหาตัวเองได้!");

        new Float:x,Float:y,Float:z;
        GetPlayerPos(playerNearSelectCase[playerid][listitem], x,y,z);
        SetPlayerCheckpoint(playerid, x,y,z, 1.5);

        IdCheckCase[playerid] = playerNearSelectCase[playerid][listitem];
        CheckCase[playerid] = 1;

        CallCase[playerNearSelectCase[playerid][listitem]] = 0;
        CaseType[playerNearSelectCase[playerid][listitem]] = 0;

        SendClientMessageEx(playerNearSelectCase[playerid][listitem], COLOR_LIGHTBLUE, "[!] เจ้าหน้าที่ตำรวจ %s กำลังออกตามจับคุณแล้ว !", GetPlayerNameEx(playerid));
        SendFactionMessageEx(FACTION_POLICE, COLOR_LIGHTBLUE, "[!] {ffffff}%s ได้กำลังออกหมายจับผู้ต้องหา %s", GetPlayerNameEx(playerid), GetPlayerNameEx(playerNearSelectCase[playerid][listitem]));
        return true;
    }
    return 1;
}

CASE_Name(playerid)
{
	new casename[64];
	switch(CaseType[playerid])
	{
	    case 1: casename = "{F5543E}ทำการขน กัญชา";
	    case 2: casename = "{F5543E}ทำการขน NZT";
	    case 3: casename = "{F5543E}ทำการขน ปูน";
	    case 4: casename = "{F5543E}ทำการอุ้มเอ๋อ";
	    case 5: casename = "{F5543E}ทำการจกสายไฟ";
	}
	return casename;
}
