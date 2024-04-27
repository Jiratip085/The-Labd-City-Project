#include <YSI_Coding\y_hooks>
/*
new CheckChmMec[MAX_PLAYERS] = 0;
new IdCheckChmMec[MAX_PLAYERS] = 0;
new playerNearSelectRepair[MAX_PLAYERS][20];
new CallMechanic[MAX_PLAYERS];
new PlayerGetCarID[MAX_PLAYERS];
new On_Repair[MAX_PLAYERS] = 0;
new On_Refill[MAX_PLAYERS] = 0;


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_YES && IsPlayerInAnyVehicle(playerid))
	{
        new id = Garage_Nearest(playerid);

        if (id == -1)
            return 1;

        if(GetFactionType(playerid) == FACTION_MEC)
            return Dialog_Show(playerid, DAILOG_MENU_MECHANIC, DIALOG_STYLE_LIST, "{979797}[ ��ҧ����ö | ���٪�������� ]", "\
            - ��ª��ͼ�����¡��ҹ\n\
            - ����ö\n\
            - �������ѹ\n\
			- ��ö\n\
			- ������ͧö", "��ŧ", "¡��ԡ");
    }
    return 1;
}

CMD:repairx(playerid)
{
    new id = -1;

    if(GetFactionType(playerid) != FACTION_MEC)
        return ErrorMsg(playerid, "�س������ҧ¹��");

    if(Inventory_Count(playerid, "Repair Kit") == 0)
        return ErrorMsg(playerid, "�س����ա��ͧ����ö");

    if ((id = GetNearestVehicle(playerid)) == INVALID_VEHICLE_ID)
        return ErrorMsg(playerid, "�س������������ö�ѹ�˹���");

    if(IsPlayerInAnyVehicle(playerid))
        return ErrorMsg(playerid, "�س��ͧ������躹�ҹ��˹�");

    if ((id = GetNearestVehicle(playerid)) != -1){

        if(!Owner_Vehicle(id))
            return ErrorMsg(playerid, "�ѹ���س�Ы�����ͧ��ö�������Ңͧ");

        new EngineStatus = GetEngineStatus(id);

        if (EngineStatus == 1)
            return ErrorMsg(playerid, "���繵�ͧ�Ѻ����ͧ¹���͹");

        if (!GetHoodStatus(id))
            return ErrorMsg(playerid, "���繵�ͧ�Դ�ҡ���ç˹��ö");

        id = Car_XGetID(id);
        PlayerGetCarID[playerid] = id;
    }

    if (On_Repair[playerid] == 1)
        return ErrorMsg(playerid, "�س���ѧ�����ա�ѹ���� !");

	if (!GetHoodStatus(id))
		return ErrorMsg(playerid, "���繵�ͧ�Դ�ҡ���ç˹��ö");

    TogglePlayerControllable(playerid, 0);
    On_Repair[playerid] = 1;
    StartProgress(playerid, 200, 0, INVALID_OBJECT_ID);
    SetPlayerAttachedObject(playerid,7,18718,6,0.187999,0.084999,-0.882000,0.000000,0.000000,0.000000,0.811999,0.762000,0.824999);
    SetPlayerAttachedObject(playerid,8,18634,6,0.075000,0.038999,0.044000,96.899993,-102.100021,11.300000,1.000000,1.000000,1.000000);
    ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
    SendClientMessage(playerid, COLOR_YELLOW, "- �س������������ҹ��˹����� !");
    return 1;
}

CMD:svmc(playerid)
{
	if(GetFactionType(playerid) == FACTION_MEC)
	{
		return Dialog_Show(playerid, DAILOG_MENU_MECHANIC, DIALOG_STYLE_LIST, "{979797}[ ��ҧ����ö | ���٪�������� ]", "\
			- ��ª��ͼ�����¡��ҹ\n\
			- ����ö\n\
			- �������ѹ\n\
			- ��ö\n\
			- ������ͧö\n\
			- ¡��ԡ��", "��ŧ", "�Դ");
	}
	else return ErrorMsg(playerid, "����Ѻ��ҧ����ö��ҹ��!");
}

Dialog:DAILOG_MENU_MECHANIC(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(listitem == 0)
        {
            new
                str[1024],
                count
            ;
            foreach (new i : Player)
            {
                //if(i == playerid) continue;
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x,y,z);
                if (CallMechanic[i] == 1)
                {
                    format(str, sizeof(str), "%s (�ʹ�:%d) %s\t%.1fm\n", str, i, GetPlayerNameEx(i), GetPlayerDistanceFromPoint(playerid, x, y, z));
                    playerNearSelectRepair[playerid][count] = i;
                    count++;

                    if(count == 20) break;
                }
            }
            if(!count) SendClientMessage(playerid, COLOR_RED, "��辺������¡��ҹ !");
            else Dialog_Show(playerid, Dialog_NearRepair, DIALOG_STYLE_TABLIST, "[ NearPlayer ]", str, "��ŧ", "�Դ");
        }
        if(listitem == 1)
        {
            callcmd::repairx(playerid);
        }
        if(listitem == 2)
        {
            callcmd::refillx(playerid);
        }
        if(listitem == 3)
        {
			if (playerData[playerid][pFactionRank] < 4)
			    return ErrorMsg(playerid, "����Ѻ�� 4 ������ҹ��!");

            //callcmd::tune(playerid, "\1");
        }
        if(listitem == 4)
        {
			if (playerData[playerid][pFactionRank] < 4)
			    return ErrorMsg(playerid, "����Ѻ�� 4 ������ҹ��!");

			Dialog_Show(playerid, DIALOG_NEON, DIALOG_STYLE_LIST, "{0FEB69}[ ������ͧö ]", "{02B40A}+ {FFFFFF}��ᴧ\n{02B40A}+ {FFFFFF}�չ���Թ\n{02B40A}+ {FFFFFF}������\n{02B40A}+ {FFFFFF}������ͧ\n{02B40A}+ {FFFFFF}�ժ���\n{02B40A}+ {FFFFFF}�բ��\n{02B40A}+ {FFFFFF}�ʹ", "�׹�ѹ", "�Դ");
        }
        if(listitem == 5)
        {
            new
                str[1024],
                count
            ;
            foreach (new i : Player)
            {
                //if(i == playerid) continue;
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x,y,z);
                if (CallMechanic[i] == 1)
                {
                    format(str, sizeof(str), "%s (�ʹ�:%d) %s\t%.1fm\n", str, i, GetPlayerNameEx(i), GetPlayerDistanceFromPoint(playerid, x, y, z));
                    playerNearSelectRepair[playerid][count] = i;
                    count++;

                    if(count == 20) break;
                }
            }
            if(!count) SendClientMessage(playerid, COLOR_RED, "��辺������¡��ҹ !");
            else Dialog_Show(playerid, Dialog_CANCEL, DIALOG_STYLE_TABLIST, "[ ¡��ԡ�� ]", str, "��ŧ", "�Դ");
        }
    }
    return 1;
}

Dialog:Dialog_NearRepair(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    if(listitem != -1 && listitem != 21)
    {
        if (playerNearSelectRepair[playerid][listitem] == playerid)
            return ErrorMsg(playerid, "�س�������ö���ҵ���ͧ��!");

        new Float:x,Float:y,Float:z;
        GetPlayerPos(playerNearSelectRepair[playerid][listitem], x,y,z);
        SetPlayerCheckpoint(playerid, x,y,z, 1.5);

        IdCheckChmMec[playerid] = playerNearSelectRepair[playerid][listitem];
        CheckChmMec[playerid] = 1;

        CallMechanic[playerNearSelectRepair[playerid][listitem]] = 0;

        SendClientMessageEx(playerNearSelectRepair[playerid][listitem], COLOR_YELLOW, "[!] ��ҧ¹�� %s ��ͺ�Ѻ�Ӫ�������ͨҡ�س���� !", GetPlayerNameEx(playerid));
        SendFactionMessageEx(FACTION_MEC, COLOR_YELLOW, "[!] {ffffff}%s ��ͺ�Ѻ�Ӫ�������ͨҡ %s", GetPlayerNameEx(playerid), GetPlayerNameEx(playerNearSelectRepair[playerid][listitem]));
        return true;
    }
    return 1;
}

Dialog:Dialog_CANCEL(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    if(listitem != -1 && listitem != 21)
    {
        if (playerNearSelectRepair[playerid][listitem] == playerid)
            return ErrorMsg(playerid, "�س�������ö¡��ԡ����ͧ��!");

        CallMechanic[playerNearSelectRepair[playerid][listitem]] = 0;

        SendClientMessageEx(playerNearSelectRepair[playerid][listitem], COLOR_LIGHTRED, "[!] ��ҧ¹�� %s ��¡��ԡ�Ӣͪ�������ͨҡ�س !", GetPlayerNameEx(playerid));
        SendFactionMessageEx(FACTION_MEC, COLOR_LIGHTRED, "[!] {ffffff}%s ��¡��ԡ�Ӫ�������ͨҡ %s", GetPlayerNameEx(playerid), GetPlayerNameEx(playerNearSelectRepair[playerid][listitem]));
        return true;
    }
    return 1;
}

CMD:refillx(playerid)
{
    new id = -1;

    if(GetFactionType(playerid) != FACTION_MEC)
        return ErrorMsg(playerid, "�س������ҧ¹��");

    if ((id = GetNearestVehicle(playerid)) == INVALID_VEHICLE_ID)
        return ErrorMsg(playerid, "�س������������ö�ѹ�˹���");

    if(IsPlayerInAnyVehicle(playerid))
        return ErrorMsg(playerid, "�س��ͧ������躹�ҹ��˹�");

    if ((id = GetNearestVehicle(playerid)) != -1){

        if(!Owner_Vehicle(id))
            return ErrorMsg(playerid, "�ѹ���س���������ѹ��ͧ����Ңͧ");

        new EngineStatus = GetEngineStatus(id);

        if(EngineStatus == 1)
            return ErrorMsg(playerid, "���繵�ͧ�Ѻ����ͧ¹���͹");

        if(vehicleFuel[id] > 80.0)
            return ErrorMsg(playerid, "ö�ѹ����չ���ѹ�ҡ������ �������ö������ա !");

        id = Car_XGetID(id);
        PlayerGetCarID[playerid] = id;
    }

    if(On_Refill[playerid] == 1)
        return ErrorMsg(playerid, "�س���ѧ�������ѹ���� !");

    TogglePlayerControllable(playerid, 0);
    On_Refill[playerid] = 1;
    StartProgress(playerid, 200, 0, INVALID_OBJECT_ID);
    ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
    SendClientMessage(playerid, COLOR_YELLOW, "- �س��������������ѹ���� !");
    return 1;
}

Player_Refill(playerid)
{
	new vehicleid = GetNearestVehicle(playerid);

    On_Refill[playerid] = 0;
    TogglePlayerControllable(playerid, 1);
    ClearAnimations(playerid);
    SendClientMessage(playerid, COLOR_YELLOW, ">> �س���������ѹ����ѧ���� !!");
    new
        query[128];

    vehicleFuel[vehicleid] = 100.0;

    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carFuel = 100.0 WHERE carID = %d", carData[vehicleid][carID]);
    mysql_tquery(g_SQL, query);
}


Player_Repair(playerid)
{
    new vehicleid = GetNearestVehicle(playerid);

    On_Repair[playerid] = 0;
    TogglePlayerControllable(playerid, 1);
    ClearAnimations(playerid);
    Inventory_Remove(playerid,"Repair Kit", 1);
    RemovePlayerAttachedObject(playerid, 8);
    RemovePlayerAttachedObject(playerid, 7);
    SendClientMessage(playerid, -1, "- �س������ 'Repair Kit' -1, �ҡ��ë����ҹ��˹� ");
    SendClientMessage(playerid, COLOR_YELLOW, ">> �س�����ö�ѹ������º��������");
	//SetHoodStatus(vehicleid, true);

    new
        query[128];

    RepairVehicle(vehicleid);
    RepairVehicle(vehicleid);

    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carHealth = 1000.0 WHERE carID = %d", carData[vehicleid][carID]);
    mysql_tquery(g_SQL, query);
}

PlayerGov_Repair(playerid)
{
    new vehicleid = GetNearestVehicle(playerid);

    On_Repair[playerid] = 0;
    TogglePlayerControllable(playerid, 1);
    ClearAnimations(playerid);
    Inventory_Remove(playerid,"Repair KitGov", 1);
    RemovePlayerAttachedObject(playerid, 8);
    RemovePlayerAttachedObject(playerid, 7);
    SendClientMessage(playerid, -1, "- �س������ '���ͧ����ö�Ѱ���' -1, �ҡ��ë����ҹ��˹� ");
    SendClientMessage(playerid, COLOR_YELLOW, ">> �س�����ö�ѹ������º��������");
 //   SetHoodStatus(vehicleid, false);

    new
        query[128];

    RepairVehicle(vehicleid);
    RepairVehicle(vehicleid);

    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carHealth = 1000.0 WHERE carID = %d", carData[vehicleid][carID]);
    mysql_tquery(g_SQL, query);
}

Player_RefuelCan(playerid)
{
    new vehicleid = GetNearestVehicle(playerid);

    On_Repair[playerid] = 0;
    TogglePlayerControllable(playerid, 1);
    ClearAnimations(playerid);
    Inventory_Remove(playerid,"Fuel Can", 1);

    SendClientMessage(playerid, -1, "- �س������ '�ѧ����ѹ' -1, �ҡ����������ѹ");
    SendClientMessage(playerid, COLOR_YELLOW, ">> �س���������ѹö�ѹ������º��������");

	vehicleFuel[vehicleid] = 100.0;
}

hook OnProgressFinish(playerid, objectid)
{
	if(On_Repair[playerid] == 1)
		Player_Repair(playerid);

	if(On_Repair[playerid] == 2)
		PlayerGov_Repair(playerid);

	if(On_Repair[playerid] == 3)
		Player_RefuelCan(playerid);

	if(On_Refill[playerid] == 1)
		Player_Refill(playerid);

	return Y_HOOKS_CONTINUE_RETURN_0;
}

hook OnProgressUpdate(playerid, progress, objectid)
{
	if(On_Repair[playerid] == 1)
	{
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}

	if(On_Repair[playerid] == 2)
	{
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}

	if(On_Repair[playerid] == 3)
	{
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}

	if(On_Refill[playerid] == 1)
	{
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}

	return Y_HOOKS_CONTINUE_RETURN_0;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if(CheckChmMec[playerid])
	{
		CheckChmMec[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
	}
	return 1;
}

Owner_Vehicle(vehicleid)
{
    foreach (new i : Player)
    {
        if(playerData[i][IsLoggedIn])
        {
            if(IsVehicleOwner(i, vehicleid))
            {
				return 1;
			}
		}
	}
	return 1;
}

Car_XGetID(vehicleid)
{
	if(IsValidVehicle(vehicleid) && Owner_Vehicle(vehicleid)) {
	    return vehicleid;
	}
	return -1;
}*/
