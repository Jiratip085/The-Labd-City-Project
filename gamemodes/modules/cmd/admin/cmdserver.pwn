#include <YSI\y_hooks>


CMD:editserver(playerid, params[])
{
    if(Account[playerid][Admin] < 1339)
        return SendClientMessage(playerid, COLOR_RED, "[!] {FFFFFF}�س������Ѻ͹حҵ�");

    ShowDialogEditServer(playerid);
    return 1;
}

Server_Save2()
{
	new
	    query[2048];

	format(query, sizeof(query), "UPDATE `settings` SET `Name` = '%s', `Version` = '%s', `Password` = '%s', `Locked` = '%d' WHERE `ID` = '0'",
		SQL_ReturnEscaped(Server[Name]),
        SQL_ReturnEscaped(Server[Version]),
        SQL_ReturnEscaped(Server[Password]),
        Server[Locked],
        Server[ID]
	);
	return mysql_tquery(dbCon, query);
}

stock ShowDialogEditServer(playerid)
{
    new string[1024];

    format(string, sizeof(string), "�����Կ�����: %s\n", Server[Name]);
    format(string, sizeof(string), "%s�������: %s\n", string, Server[Version]);
    format(string, sizeof(string), "%sʶҹ�: %s\n",string, Server[Locked] ? ("��ͤ") : ("�Ŵ��ͤ"));
    format(string, sizeof(string), "%s��������: %s", string, Server[Password]);
    Dialog_Show(playerid, ChangeServer, DIALOG_STYLE_LIST, "����Կ�����", string, "���͡","¡��ԡ");
    return 1;
}

Dialog:ChangeServer(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new string[1024];

    if(response)
    {
        if(listitem == 0)
        {
            format(string, sizeof(string), "�����Կ�����: %s", Server[Name]);
            Dialog_Show(playerid, ChangeServerName, DIALOG_STYLE_INPUT, "��駤�Ҫ����Կ�����", string, "����¹", "��Ѻ");
        }
        if(listitem == 1)
        {
            format(string, sizeof(string), "������蹻Ѩ�غѹ: %s", Server[Version]);
            Dialog_Show(playerid, ChangeServerVersion, DIALOG_STYLE_INPUT, "��駤���������", string, "����¹", "��Ѻ");
        }
        if(listitem == 2)
        {
            format(string, sizeof(string), "�Ŵ��ͤ\n��ͤ");
            Dialog_Show(playerid, ChangeServerLocked, DIALOG_STYLE_LIST, "��õ�駤����ͤ�Կ�����", string, "����¹", "��Ѻ");
        }
        if(listitem == 3)
        {
            format(string, sizeof(string), "��������: %s", Server[Password]);
            Dialog_Show(playerid, ChangeServerPassword, DIALOG_STYLE_INPUT, "��駤�����ʼ�ҹ", string, "����¹", "��Ѻ");
        }
    }
    return 1;
}

Dialog:ChangeServerName(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[64];

		if(isnull(inputtext) || strlen(inputtext) >= 64) {
			format(string, sizeof(string), "������Ǣͧ���͵�ͧ�ҡ���� 0 �������Թ 64/n/n�����Կ�����: %s", Server[Name]);
			Dialog_Show(playerid, ChangeServerName, DIALOG_STYLE_INPUT, "��䢪����Կ�����", string, "����¹", "��Ѻ");
			return true;
		}
		format(Server[Name], 64, inputtext);
        new name[64];
        format(name, sizeof(name), "hostname %s", Server[Name]);
		SendRconCommand(name);
		Server_Save2();
        SendClientMessage(playerid, -1, "�س������¹�����Կ������� '%s' ���º��������!",Server[Name]);
    }
    return ShowDialogEditServer(playerid);
}

Dialog:ChangeServerVersion(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[16];

		if(isnull(inputtext) || strlen(inputtext) >= 16) {
			format(string, sizeof(string), "������Ǣͧ���͵�ͧ�ҡ���� 0 �������Թ 16/n/n�������: %s", Server[Version]);
			Dialog_Show(playerid, ChangeServerVersion, DIALOG_STYLE_INPUT, "����������", string, "����¹", "��Ѻ");
			return true;
		}
		format(Server[Version], 16, inputtext);
        new name[16];
        format(name, sizeof(name), "%s", Server[Version]);
        SetGameModeText(name);
		Server_Save2();
        SendClientMessage(playerid, -1, "�س������¹ Version �� '%s' ���º��������!",Server[Version]);
    }
    return ShowDialogEditServer(playerid);
}

Dialog:ChangeServerPassword(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[32];

		if(isnull(inputtext) || strlen(inputtext) >= 32) {
			format(string, sizeof(string), "������Ǣͧ���͵�ͧ�ҡ���� 0 �������Թ 32/n/n�������: %s", Server[Password]);
			Dialog_Show(playerid, ChangeServerPassword, DIALOG_STYLE_INPUT, "����������", string, "����¹", "��Ѻ");
			return true;
		}
		format(Server[Password], 32, inputtext);
        new name[32];
        format(name, sizeof(name), "password %s", Server[Password]);
        SendRconCommand(name);
		Server_Save2();
        SendClientMessage(playerid, -1, "�س������¹ �������� �� '%s' ���º��������!",Server[Password]);
    }
    return ShowDialogEditServer(playerid);
}

Dialog:ChangeServerLocked(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(listitem == 0)
        {
            Server[Locked] = 0;
            SendRconCommand("password 0");
            Server_Save2();
        }
        if(listitem == 1)
        {
            Server[Locked] = 1;
            SendRconCommand("password 0");
            new str[64];
            format(str, sizeof(str), "password %s", Server[Password]);
			SendRconCommand(str);
            Server_Save2();
        }
    }
    return ShowDialogEditServer(playerid);
}
/*
ResetPlayer(playerid)
{
	foreach (new i : Player) if (Character[i][pDraggedBy] == playerid)
	{
	    StopDragging(i);
	}
	if (Character[playerid][pDragged])
	{
	    StopDragging(playerid);
	}
	//Character[playerid][pCuffed] = 0;
    Character[playerid][pDragged] = 0;
    Character[playerid][pDraggedBy] = INVALID_PLAYER_ID;
}
new const vehicleArray[][vmInfo] =
{
	{"Car",       	405, 15000},
	{"Car",       	413, 15000},
    {"Car",       	422, 15000}

};
GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid))
	{
		GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}


GetXYBehindVehicle(vehicleid, &Float:q, &Float:w, Float:distance)
{
    new Float:a;
    GetVehiclePos(vehicleid, q, w, a);
    GetVehicleZAngle(vehicleid, a);
    q += (distance * -floatsin(-a, degrees));
    w += (distance * -floatcos(-a, degrees));
}
*/

//Addwhitelist
CMD:addpc(playerid, params[]){ //  /addpc [nameplayer]

    if (Account[playerid][Admin] < 1337)
	    return 1;

	//params �Ѻ���ͼ����������
	if(isnull(params))
	    return SendClientMessage(playerid, -1, "�س���繵�ͧ��͡���ͼ����蹷�����������");

	new str[128], string[128];

	format(string, sizeof(string), "UPDATE `characters` SET `Whitelist` = %d WHERE `Name` = '%s'", 1, SQL_ReturnEscaped(params));
	mysql_tquery(dbCon, string);

	format(str, sizeof(str), "%s:{FFFFFF} Set Whitelist to %s", GetRoleplayName(playerid), params);
	SendAdminsMessage(1, COLOR_YELLOW, str);
	return 1;
}

hook OnGameModeInit()
{
    CreateDynamic3DTextLabel("[Fixbug Mobile]{FFFFFF}\n{FFFFFF}�� 'Y' ������Ѥ Death", COLOR_GREEN, -207.1014,1119.2313,20.4297, 1.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
        if(IsPlayerInRangeOfPoint(playerid, 1, -207.1014,1119.2313,20.4297)) 
		{
            if(Character[playerid][Injured] == 1)
            {
                AC_SetPlayerHealth(playerid, 100);

                ClearAnimations(playerid);
                ResetDamages(playerid);
                Character[playerid][Injured] = 0;
                Character[playerid][InjuredTime] = 0;
                Character[playerid][InjuredEx]= 0;
                Character[playerid][InjuredSpawn] = 0;
                Character[playerid][InjuredShoot] = 0;
            }
        }
        return 1;
    }
    return 1;
}