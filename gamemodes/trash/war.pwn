/*
CODEING �觵��
��¹�ͧ ������ͻ�鴨ҡʤ�Ի�����
*/

#include	<YSI_Coding\y_hooks>

new UseWPZ[MAX_PLAYERS][7];
new bool: EnterZone[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    UseWPZ[playerid][0] = 0;
    UseWPZ[playerid][1] = 0;
    UseWPZ[playerid][2] = 0;
    UseWPZ[playerid][3] = 0;
    UseWPZ[playerid][4] = 0;
    UseWPZ[playerid][5] = 0;
    UseWPZ[playerid][6] = 0;
    EnterZone[playerid] = false;
    return 1;
}
hook OnGameModeInit()
{
    CreateDynamic3DTextLabel("[�ҧ�͡] {ffffff}WARZONE\n �� N", COLOR_GREEN,-1423.7690,935.0450,1036.4449, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    CreateDynamic3DTextLabel("[�ҧ���] {ffffff}WARZONE\n �� N", COLOR_GREEN, 1902.9337,-2638.6758,13.5469, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    CreateDynamic3DTextLabel("[������ظ] {ffffff}WARZONE\n �� N", COLOR_GREEN, -1416.1053,936.1344,1036.4740, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    return 1;
}

Dialog:DIALOGWEAPON(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch(listitem)
	    {
            case 0:
            {
               GivePlayerWeaponEx(playerid, 1, 1);
               UseWPZ[playerid][0] = 1;
            }
            case 1:
            {
               GivePlayerWeaponEx(playerid, 2, 1);
               UseWPZ[playerid][1] = 1;
            }
            case 2:
            {
               GivePlayerWeaponEx(playerid, 4, 1);
               UseWPZ[playerid][2] = 1;
            }
            case 3:
            {
               GivePlayerWeaponEx(playerid, 5, 1);
               UseWPZ[playerid][3] = 1;
            }
            case 4:
            {
               GivePlayerWeaponEx(playerid, 6, 1);
               UseWPZ[playerid][4] = 1;
            }
            case 5:
            {
               GivePlayerWeaponEx(playerid, 7, 1);
               UseWPZ[playerid][5] = 1;
            }
            case 6:
            {
               GivePlayerWeaponEx(playerid, 8, 1);
               UseWPZ[playerid][6] = 1;
            }
        }
    }
    return 1;
}


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_NO && !IsPlayerInAnyVehicle(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1902.9337,-2638.6758,13.5469)) //�ҧ���
        {
            SetPlayerInterior(playerid, 15);
            SetPlayerPos(playerid, -1423.7690,935.0450,1036.4449); // �ҧ�͡
            EnterZone[playerid] = true; // ����� player ���������ظ
        }
        if(IsPlayerInRangeOfPoint(playerid, 3.0, -1423.7690,935.0450,1036.4449)) //�ҧ�͡
        {
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerPos(playerid, 1902.9337,-2638.6758,13.5469);
            EnterZone[playerid] = false; // ����� player ���������ظ
            foreach(new i: Player)
            {
                if(EnterZone[i] == true &&
                UseWPZ[i][0] <= UseWPZ[i][6])
                {
                    ResetPlayerWeaponsEx(i);
                }
                else{
                    ResetPlayerWeaponsEx(i);
                }
            }
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 3.0, -1416.1053,936.1344,1036.4740))
        {
            if(EnterZone[playerid] == true)
            {
                Dialog_Show(playerid, DIALOGWEAPON, DIALOG_STYLE_TABLIST_HEADERS, "������ظ�ФѪ",
                "���ظ\t�Ҥ�\n\
                Brass\t���\n\
                Golf\t���\n\
                Knife\t���\n\
                Baseball\t���\n\
                Shoval\t���\n\
                Pool\t���\n\
                Kantana\t���", "���", "��������");
                return 1;
            }
            else{
                SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ������͹�ش���ͨзӺѤ�� ��������ʹ�꺺���", GetPlayerNameEx(playerid));
                return 1;
            }
        }
        if(EnterZone[playerid] == true)
        {
            if(playerData[playerid][pInjured])
            {
                playerData[playerid][pInjured] = 0;
                playerData[playerid][pInjuredTime] = 0;
                ClearAnimations(playerid);
                PlayerTextDrawHide(playerid, PlayerDeathTD[playerid]);
                ShowPlayerStats(playerid, true);
            }
        }
    }
    return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    if(EnterZone[playerid] == true)
    {
        SendClientMessage(playerid, COLOR_GREEN, "�س�������ŷӡ�á� N ���Ϳ�鹨ҡ������");
    }
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(EnterZone[playerid] == true)
    {
        SetPlayerPos(playerid, -1423.7690,935.0450,1036.4449);
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerInterior(playerid, 0);
    }
    return 1;
}
