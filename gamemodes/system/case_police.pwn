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
		Dialog_Show(playerid, Dialog_CASE_TYPE, DIALOG_STYLE_LIST, "{037DE4}[ MDC ]", "{037DE4}+ {ffffff}����ª��ͼ��ӧҹ�Դ������\n{037DE4}+ {ffffff}¡��ԡ��ª��ͼ��ӧҹ�Դ������", "��ŧ", "�Դ");
	}

	else if (GetFactionType(playerid) == FACTION_MEC)
	{
  		Dialog_Show(playerid, Dialog_MEC_TYPE, DIALOG_STYLE_LIST, "{5A5657}[ MDC ]", "{5A5657}+ {ffffff}����ª��ͼ�����ͧ��ê�ҧ����ö\n{5A5657}+ {ffffff}¡��ԡ��ª��ͼ�����ͧ��ê�ҧ����ö", "��ŧ", "�Դ");
	}
	else ErrorMsg(playerid, "����Ѻ���Ǩ����ᾷ�����ͪ�ҧ����ö��ҹ��!");
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
					format(str, sizeof(str), "%s {50DCFB}(�ʹ�:%d) %s\t{ffffff}�����Դ:%s\t{ffffff}%.1fm\n", str, i, GetPlayerNameEx(i), CASE_Name(i), GetPlayerDistanceFromPoint(playerid, x, y, z));
					playerNearSelectCase[playerid][count] = i;
					count++;

					if(count == 20) break;
				}
			}
		 	if(!count) ErrorMsg(playerid, "��辺���ӧҹ�Դ������!");
		  	else Dialog_Show(playerid, Dialog_NearCase, DIALOG_STYLE_TABLIST, "{037DE4}[ ��ª��ͼ��ӧҹ�Դ������ ]", str, "��ŧ", "�Դ");
		}
        if(listitem == 1)
        {
			foreach (new i : Player)
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(i, x,y,z);

				if (CallCase[i] == 1)
				{
					format(str, sizeof(str), "%s {FB9E6C}(�ʹ�:%d) %s\t{ffffff}�����Դ:%s\t{ffffff}%.1fm\n", str, i, GetPlayerNameEx(i), CASE_Name(i), GetPlayerDistanceFromPoint(playerid, x, y, z));
					playerNearSelectCase[playerid][count] = i;
					count++;

					if(count == 20) break;
				}
			}
		 	if(!count) ErrorMsg(playerid, "��辺���ӧҹ�Դ������!");
		  	else Dialog_Show(playerid, Dialog_CANCEL_CASE, DIALOG_STYLE_TABLIST, "{ED381F}[ ¡��ԡ��ª��ͼ��ӧҹ�Դ������ ]", str, "��ŧ", "�Դ");
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
            return ErrorMsg(playerid, "�س�������ö¡��ԡ����ͧ��!");

        CallCase[playerNearSelectCase[playerid][listitem]] = 0;

        SendClientMessageEx(playerNearSelectCase[playerid][listitem], COLOR_LIGHTRED, "[!] ���˹�ҷ����Ǩ %s ��¡��ԡ���¨Ѻ�ͧ�س !", GetPlayerNameEx(playerid));
        SendFactionMessageEx(FACTION_POLICE, COLOR_LIGHTRED, "[!] {ffffff}%s ��¡��ԡ���¨Ѻ %s", GetPlayerNameEx(playerid), GetPlayerNameEx(playerNearSelectCase[playerid][listitem]));
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
            return ErrorMsg(playerid, "�س�������ö���ҵ���ͧ��!");

        new Float:x,Float:y,Float:z;
        GetPlayerPos(playerNearSelectCase[playerid][listitem], x,y,z);
        SetPlayerCheckpoint(playerid, x,y,z, 1.5);

        IdCheckCase[playerid] = playerNearSelectCase[playerid][listitem];
        CheckCase[playerid] = 1;

        CallCase[playerNearSelectCase[playerid][listitem]] = 0;
        CaseType[playerNearSelectCase[playerid][listitem]] = 0;

        SendClientMessageEx(playerNearSelectCase[playerid][listitem], COLOR_LIGHTBLUE, "[!] ���˹�ҷ����Ǩ %s ���ѧ�͡����Ѻ�س���� !", GetPlayerNameEx(playerid));
        SendFactionMessageEx(FACTION_POLICE, COLOR_LIGHTBLUE, "[!] {ffffff}%s ����ѧ�͡���¨Ѻ����ͧ�� %s", GetPlayerNameEx(playerid), GetPlayerNameEx(playerNearSelectCase[playerid][listitem]));
        return true;
    }
    return 1;
}

CASE_Name(playerid)
{
	new casename[64];
	switch(CaseType[playerid])
	{
	    case 1: casename = "{F5543E}�ӡ�â� �ѭ��";
	    case 2: casename = "{F5543E}�ӡ�â� NZT";
	    case 3: casename = "{F5543E}�ӡ�â� �ٹ";
	    case 4: casename = "{F5543E}�ӡ����������";
	    case 5: casename = "{F5543E}�ӡ�è�����";
	}
	return casename;
}
