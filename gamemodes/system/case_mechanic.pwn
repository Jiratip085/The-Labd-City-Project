#include <YSI_Coding\y_hooks>
/*
new CheckMechanic[MAX_PLAYERS] = 0;
new IdCheckMechanic[MAX_PLAYERS] = 0;
new playerNearSelectMechanic[MAX_PLAYERS][20];
new MechanicType[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    CheckMechanic[playerid] = 0;
    IdCheckMechanic[playerid] = 0;
    CallMechanic[playerid] = 0;
    MechanicType[playerid] = 0;
}

Dialog:Dialog_MEC_TYPE(playerid, response, listitem, inputtext[])
{
	new
		str[1024],
		count;Call

    if(response)
    {
        if(listitem == 0)
        {
			foreach (new i : Player)
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(i, x,y,z);

				if (CallMechanic[i] == 1)
				{
					format(str, sizeof(str), "%s {C2BDBE}(�ʹ�:%d) %s\t{ffffff}���˵� : %s\t{ffffff}%.1fm\n", str, i, GetPlayerNameEx(i), Mechanic_Name(i), GetPlayerDistanceFromPoint(playerid, x, y, z));
					playerNearSelectMechanic[playerid][count] = i;
					count++;

					if(count == 20) break;
				}
			}
		 	if(!count) ErrorMsg(playerid, "��辺�����蹷���ͧ��ê�ҧ����ö!");
		  	else Dialog_Show(playerid, Dialog_NearMechanic, DIALOG_STYLE_TABLIST, "{5A5657}[ ��ª��ͼ���ͧ��ê�ҧ����ö ]", str, "��ŧ", "�Դ");
		}
        if(listitem == 1)
        {
			foreach (new i : Player)
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(i, x,y,z);

				if (CallMechanic[i] == 1)
				{
					format(str, sizeof(str), "%s {C2BDBE}(�ʹ�:%d) %s\t{ffffff}���˵� : %s\t{ffffff}%.1fm\n", str, i, GetPlayerNameEx(i), Mechanic_Name(i), GetPlayerDistanceFromPoint(playerid, x, y, z));
					playerNearSelectMechanic[playerid][count] = i;
					count++;

					if(count == 20) break;
				}
			}
		 	if(!count) ErrorMsg(playerid, "��辺�����蹷���ͧ��ê�ҧ����ö!");
		  	else Dialog_Show(playerid, Dialog_CANCEL_Mechanic, DIALOG_STYLE_TABLIST, "{5A5657}[ ¡��ԡ��ª��ͼ���ͧ��ê�ҧ����ö ]", str, "��ŧ", "�Դ");
		}
	}
	return 1;
}

Dialog:Dialog_CANCEL_Mechanic(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    if(listitem != -1 && listitem != 21)
    {
        if (playerNearSelectMechanic[playerid][listitem] == playerid)
            return ErrorMsg(playerid, "�س�������ö¡��ԡ����ͧ��!");

        CallMechanic[playerNearSelectMechanic[playerid][listitem]] = 0;

        SendClientMessageEx(playerNearSelectMechanic[playerid][listitem], COLOR_LIGHTRED, "[!] ��ҧ����ö %s ��¡��ԡ��õ�ͧ��ê�ҧ����ö�ͧ�س���� !", GetPlayerNameEx(playerid));
        SendFactionMessageEx(FACTION_MEC, COLOR_LIGHTRED, "[!] {ffffff}%s ��¡��ԡ��õ�ͧ��ê�ҧ����ö�ͧ %s ����", GetPlayerNameEx(playerid), GetPlayerNameEx(playerNearSelectMechanic[playerid][listitem]));
        return true;
    }
    return 1;
}

Dialog:Dialog_NearMechanic(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    if(listitem != -1 && listitem != 21)
    {
        if (playerNearSelectMechanic[playerid][listitem] == playerid)
            return ErrorMsg(playerid, "�س�������ö���ҵ���ͧ��!");

        new Float:x,Float:y,Float:z;
        GetPlayerPos(playerNearSelectMechanic[playerid][listitem], x,y,z);
        SetPlayerCheckpoint(playerid, x,y,z, 1.5);

        IdCheckMechanic[playerid] = playerNearSelectMechanic[playerid][listitem];
        CheckMechanic[playerid] = 1;

        CallMechanic[playerNearSelectMechanic[playerid][listitem]] = 0;
        MechanicType[playerNearSelectMechanic[playerid][listitem]] = 0;

        SendClientMessageEx(playerNearSelectMechanic[playerid][listitem], COLOR_ORANGE, "[!] ��ҧ����ö %s ���ѧ�͡����Ҥس !", GetPlayerNameEx(playerid));
        SendFactionMessageEx(FACTION_MEC, COLOR_ORANGE, "[!] {ffffff}%s ��ͺ�Ѻ��õ�ͧ��ê�ҧ����ö�ҡ %s ����", GetPlayerNameEx(playerid), GetPlayerNameEx(playerNearSelectMechanic[playerid][listitem]));
        return true;
    }
    return 1;
}

Mechanic_Name(playerid)
{
	new MechanicName[64];
	switch(MechanicType[playerid])
	{
	    case 1: MechanicName = "{FE9313}��ͧ��ê�ҧ����ö";
	}
	return MechanicName;
}
*/