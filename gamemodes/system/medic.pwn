#include <YSI_Coding\y_hooks>

#define     MAX_INJURED             (10)
enum INJURED_DATA {
	injuredID,
	injuredExists,
	injuredTarget
}
new injuredData[MAX_INJURED][INJURED_DATA];

new CPRPrice[MAX_PLAYERS] = 0;
new HEALPrice[MAX_PLAYERS] = 0;

new Siren[MAX_VEHICLES],
	SirenObject[MAX_VEHICLES];


CMD:medic(playerid, params[])
{
    if (GetFactionType(playerid) != FACTION_MEDIC)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}��ͧ�ҧ�������Ѻ���˹�ҷ����ҹ��!");

    Dialog_Show(playerid, DIALOG_MEDIC, DIALOG_STYLE_TABLIST_HEADERS, "��������Ѻ˹��§ҹᾷ��", "��¡��\t�ӹǹ\n{F6CE07}��ª��ͼ��ͤ������������\n{F61D07}[+]{FFFFFF} �����Һ�� (CPR)\t$%d\n{F61D07}[+]{FFFFFF} �������� (Heal)\t$%d", "���͡", "�͡", CPRPrice[playerid], HEALPrice[playerid]);
	return 1;
}

/*Injured_Add(playerid)
{
	for(new i = 0; i != MAX_INJURED; ++ i)
	{
	    if (!injuredData[i][injuredExists])
	    {
		    injuredData[i][injuredID] = i;
		    injuredData[i][injuredExists] = true;
	        injuredData[i][injuredTarget] = playerid;

			foreach (new x : Player)
			{
				if (GetFactionType(x) == FACTION_MEDIC) {
					SendClientMessage(x, -1, "{F92747}(�����ͧ�ͤ������������) | {FFFFFF}�ռ����蹵�ͧ��ä������������ /medic ���͵�Ǩ�ͺ {F92747}))");
				}
			}
			return i;
		}
	}
	return -1;
}*/

Injured_Remove(hitmanid)
{
	if (hitmanid != -1 && injuredData[hitmanid][injuredExists])
	{
	    injuredData[hitmanid][injuredExists] = false;

		injuredData[hitmanid][injuredID] = -1;
		injuredData[hitmanid][injuredTarget] = -1;
	}
	return 1;
}

/*Injured_Clear(playerid)
{
    for (new i = 0; i != MAX_INJURED; i ++)
	{
	    if (injuredData[i][injuredExists] && injuredData[i][injuredTarget] == playerid)
	    {
	        Injured_Remove(i);
		}
	}
	return 1;
}

Injured_GetCount(playerid)
{
	new count;

    for (new i = 0; i != MAX_INJURED; i ++)
	{
	    if (injuredData[i][injuredExists] && injuredData[i][injuredTarget] == playerid)
	    {
	        count++;
		}
	}
	return count;
}*/


Dialog:DIALOG_MEDIC_LIST(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new var[32];
	    format(var, sizeof(var), "GPSID%d", listitem);
	    new gpsid = GetPVarInt(playerid, var);

		new hitmanname = injuredData[gpsid][injuredTarget], Float:x, Float:y, Float:z;
		GetPlayerPos(injuredData[gpsid][injuredTarget], x, y, z);

		SetPlayerCheckpoint(playerid, x, y, z, 3.0);

		SendClientMessageEx(playerid, COLOR_LIGHTRED, "* ���˹觢ͧ %s �١�ʴ���鹺�Ἱ�������", GetPlayerNameEx(hitmanname));
		SendClientMessageEx(playerid, -1, "���зҧ㹡���Թ�ҧ > %.0f km", GetPlayerDistanceFromPoint(playerid, x, y, z));

		SendClientMessageEx(injuredData[gpsid][injuredTarget], COLOR_RED, "��� %s �Ѻ��Һ�֧��úҴ�红ͧ�س���� ��С��ѧ�Թ�ҧ���Ҥس!", GetPlayerNameEx(playerid));
        Injured_Remove(gpsid);
	}
	return 1;
}

Dialog:DIALOG_MEDIC(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
  		{
			case 0:
			{
				new
					string[1024],
					string2[1024],
	    			var[32], count;

				for (new i = 0; i != MAX_INJURED; i ++)
				{
				    if (!injuredData[i][injuredExists])
						continue;

					new hitmanname = injuredData[i][injuredTarget], Float:x, Float:y, Float:z;
					GetPlayerPos(injuredData[i][injuredTarget], x, y, z);

					format(string, sizeof(string), "{FFFFFF}%s\t{FFFFFF}%.0f km\n", GetPlayerNameEx(hitmanname), GetPlayerDistanceFromPoint(playerid, x, y, z));
			        strcat(string2, string);

					format(var, sizeof(var), "GPSID%d", count);
					SetPVarInt(playerid, var, i);
					count++;
				}

				format(string, sizeof(string), "����\t���зҧ\n%s", string2);
				Dialog_Show(playerid, DIALOG_MEDIC_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Medic", string, "���͡", "��Ѻ");
			}
			case 1:
			{
				Dialog_Show(playerid, DIALOG_MEDIC_CPR, DIALOG_STYLE_INPUT, "Medic", "��س��к��Ҥҷ��س��ͧ�������Ѻ��û����Һ�� (CPR)\n�Ѩ�غѹ�Ҥҡ�û����Һ�Ţͧ�س��� : $%d", "���͡", "��Ѻ", CPRPrice[playerid]);
			}
			case 2:
			{
				Dialog_Show(playerid, DIALOG_MEDIC_HEAL, DIALOG_STYLE_INPUT, "Medic", "��س��к��Ҥҷ��س��ͧ�������Ѻ��û������� (Hea;)\n�Ѩ�غѹ�Ҥҡ�û������㨢ͧ�س��� : $%d", "���͡", "��Ѻ", HEALPrice[playerid]);
			}
		}
	}
	return 1;
}

Dialog:DIALOG_MEDIC_CPR(playerid, response, listitem, inputtext[])
{
	new cash= strval(inputtext);
	if(response)
	{
	    if (cash <= 0)
	        return SendClientMessage(playerid, COLOR_GREY, "* �س��ͧ�кبӹǹ�ҡ���� 0");

        CPRPrice[playerid] = cash;
        SendClientMessageEx(playerid, COLOR_YELLOW, "+ �س���駤�ҡ�û����Һ�� (CPR) �繨ӹǹ�Թ '$%d'", cash);
        return 1;
	}
	return 1;
}

Dialog:DIALOG_MEDIC_HEAL(playerid, response, listitem, inputtext[])
{
	new cash= strval(inputtext);
	if(response)
	{
	    if (cash <= 0)
	        return SendClientMessage(playerid, COLOR_GREY, "* �س��ͧ�кبӹǹ�ҡ���� 0");

        HEALPrice[playerid] = cash;
        SendClientMessageEx(playerid, COLOR_YELLOW, "+ �س���駤�ҡ�û������� (Heal) �繨ӹǹ�Թ '$%d'", cash);
        return 1;
	}
	return 1;
}

///////////////// police /////////////////////
CMD:siren(playerid, params[])
{
	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC)
	    return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}��ͧ�ҧ�������Ѻ���˹�ҷ����ҹ��!");

    new string[128], type;
    new VID = GetPlayerVehicleID(playerid);

    if(sscanf(params, "d", type))
    {
        SendClientMessage(playerid, COLOR_WHITE, "����� : /siren [��Դ]");
        SendClientMessage(playerid, COLOR_GREY, "��Դ : 1 = ����, 2 = ��ѧ��, 3 = �Դ");
        return 1;
    }
    switch(type)
    {
        case 1:
        {
            if(Siren[VID] == 1)
            {
                SendClientMessage(playerid, COLOR_GREY, "ö�ѹ�����������ù����!");
                return 1;
            }
			Siren[VID] = 1;
			SirenObject[VID] = CreateDynamicObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
			AttachDynamicObjectToVehicle(SirenObject[VID], VID, 0.0, 0.75, 0.275, 0.0, 0.1, 0.0);
			format(string, sizeof(string), "** %s �Դ��ù��������㹴�ҹ˹��ö", GetPlayerNameEx(playerid));
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, string);
			return 1;
        }
        case 2:
        {
            if(Siren[VID] == 1)
            {
                SendClientMessage(playerid, COLOR_GREY, "ö�ѹ�����������ù����!");
                return 1;
            }
            Siren[VID] = 1;
            SirenObject[VID] = CreateDynamicObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
            AttachDynamicObjectToVehicle(SirenObject[VID], VID, -0.43, 0.0, 0.785, 0.0, 0.1, 0.0);
            format(string, sizeof(string), "** %s �Դ��ù��麹��ѧ��ö", GetPlayerNameEx(playerid));
            SendNearbyMessage(playerid, 30.0,  COLOR_PURPLE, string);
            return 1;
        }
        case 3:
        {
            if(Siren[VID] == 0)
            {
                SendClientMessage(playerid, COLOR_GREY, "ö�ѹ����������ù!");
                return 1;
            }
            Siren[VID] = 0;
            DestroyDynamicObject(SirenObject[VID]);
            format(string, sizeof(string), "** %s �ʹ��ù�͡�ҡö", GetPlayerNameEx(playerid));
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, string);
            return 1;
        }
        default:
        {
            SendClientMessage(playerid, COLOR_WHITE, "�������Է�ԡ����ҹ���١��ͧ! /siren [��Դ]");
            SendClientMessage(playerid, COLOR_GREY, "��Դ : 1 = ��ѧ�� , 2 = �ö , 3 = �Դ");
        }
    }
    return 1;
}
