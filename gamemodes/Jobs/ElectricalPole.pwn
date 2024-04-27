#include	<YSI_Coding\y_hooks>

new const Float:Electrical_Pole[][] = {
    {-418.8727,-1848.0592,39.6908},
    {-343.0896,-1653.7964,61.2969},
    {-290.7881,-1567.8713,43.6406},
    {-197.1943,-1462.3702,45.1094},
    {-166.2571,-1359.2533,39.5859},
    {-117.0495,-1234.7622,39.5859},
    {-55.0442,-1162.9368,38.2500},
    {-177.4423,-969.9406,59.8976},
    {-263.2207,-906.0157,79.5992},
    {-317.6717,-842.1583,83.5668}
};

new 
    bool:StartElectricalPoleJob[MAX_PLAYERS],
    bool:RepairElectricalPoleJob[MAX_PLAYERS],
    ManyElectricalPole[MAX_PLAYERS];

hook OnGameModeInit()
{
    CreateActor(27,-76.9880,-1136.6445,1.0781,66.2284); 
    CreateDynamic3DTextLabel("Nikola_Tesla\n{AAAAAA}�� 'Y' ����������ҹ", COLOR_WHITE, -76.9880,-1136.6445,1.0781+1.1, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
}

hook OnPlayerConnect(playerid)
{
    StartElectricalPoleJob[playerid] = false;


    return 1;
}


Dialog:Start_ElectricalPoleJob(playerid, response, listitem, inputtext[])
{
	if (response)
	{   
        StartElectricalPoleJob[playerid] = true;
        RepairElectricalPoleJob[playerid] = false;
        ManyElectricalPole[playerid] = 0;
        SetPlayerAttachedObject(playerid, 9, 19120,2,0.179000,0.001000,0.000000,0.000000,0.000000,0.000000,1.000000,1.090997,1.000000);
        SendClientMessage(playerid, COLOR_YELLOW, "[ElectricalPole]: �س��������ҹ Electrical Pole ���º����");
        SendClientMessage(playerid, COLOR_YELLOW, "[ElectricalPole]: ���仺�ö 'Utility Van' �ҡ��� /findep ���ͤ������俿��");
        SendClientMessage(playerid, COLOR_LIGHTRED, "(( �ҡ�س '�͡��' ���� '��ش��' �ҹ���س������ж١¡��ԡ, ��Фس��ͧ��Ѻ���������� ))");
        PlayerPlaySound(playerid, 31200, 0.0, 0.0, 0.0);
        DisablePlayerCheckpoint(playerid);
	}
	return 1;
}
Dialog:Stop_ElectricalPoleJob(playerid, response, listitem, inputtext[])
{
	if (response)
	{
        StartElectricalPoleJob[playerid] = false;
        RepairElectricalPoleJob[playerid] = false;
        ManyElectricalPole[playerid] = 0;
        RemovePlayerAttachedObject(playerid, 9);
        SendClientMessage(playerid, COLOR_YELLOW, "[ElectricalPole]: �س����ش�ӧҹ Electrical Pole ���º����");
        PlayerPlaySound(playerid, 31200, 0.0, 0.0, 0.0);
        DisablePlayerCheckpoint(playerid);
	}
	return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid,2.0, -76.9880,-1136.6445,1.0781)) //������ҹ
        {
            if(StartElectricalPoleJob[playerid] == false)
                return Dialog_Show(playerid, Start_ElectricalPoleJob, DIALOG_STYLE_MSGBOX, "Nikola_Tesla", "{FFFFFF}Job: ElectricalPole\n\
                �س��ͧ���������ҹ㹵͹�������������?", "������ҹ", "¡��ԡ");

            if(StartElectricalPoleJob[playerid] == true)
                return Dialog_Show(playerid, Stop_ElectricalPoleJob, DIALOG_STYLE_MSGBOX, "Nikola_Tesla", "{FFFFFF}Job: ElectricalPole\n{FF6347}�س��ͧ�����ش�ҹ���س���ѧ����������������?", "��ش�ҹ", "¡��ԡ");
        }
    }
    return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
    if(StartElectricalPoleJob[playerid] == true && IsPlayerInAnyVehicle(playerid)) //��ö�����Ѻ Paycheck
    {
        new string[128], ElectricalPolePaycheck = randomEx(1500, 2000),
            vehicleid = GetPlayerVehicleID(playerid);

        if(ManyElectricalPole[playerid] >= 10) //�ú����ӹǹ
        {
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 552)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö�Ѻ Paycheck �����ͧ�ҡ�س��������躹ö 'Utility Van'");

            ShowPlayerPaycheck(playerid);	
            SetTimerEx("PaycheckTimer", 10000, 0, "id", playerid);

            format(string, sizeof(string), "Name: %s", GetPlayerNameEx(playerid)); // Name
            PlayerTextDrawSetString(playerid, PaycheckTD[playerid][3], string);

            format(string, sizeof(string), "Job: Electrical Pole"); 
            PlayerTextDrawSetString(playerid, PaycheckTD[playerid][4], string);

            format(string, sizeof(string), "Paycheck: %s", FormatMoney(ElectricalPolePaycheck)); // Paycheck
            PlayerTextDrawSetString(playerid, PaycheckTD[playerid][5], string);

            StartElectricalPoleJob[playerid] = false;
            RepairElectricalPoleJob[playerid] = false;
            ManyElectricalPole[playerid] = 0;

            RemoveFromVehicle(playerid);
            SetVehicleToRespawn(vehicleid);

            playerData[playerid][pBankMoney] += ElectricalPolePaycheck;
            RemovePlayerAttachedObject(playerid, 9);
            SendClientMessageEx(playerid, COLOR_GREEN, "[Electrical Pole]: �س����ʺ���������㹡�ë������俿��, ������Ѻ Paycheck �ӹǹ '%s'", FormatMoney(ElectricalPolePaycheck));
            PlayerPlaySound(playerid, 21002, 0.0, 0.0, 0.0);
            DisablePlayerCheckpoint(playerid);
            return 1;
        }
    }
    if(StartElectricalPoleJob[playerid] == true && !IsPlayerInAnyVehicle(playerid))
    {
        RepairElectricalPoleJob[playerid] = true;
        DisablePlayerCheckpoint(playerid);
        playerData[playerid][pCheckpoint] = 0;
        PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0);
        ApplyAnimation(playerid,"bomber", "bom_plant",4.1, 1, 0, 1, 0, 0);
        StartProgress(playerid, 100, 0, 0);
        
    }
    return 1;
}
hook OnProgressUpdate(playerid, progress, objectid)
{
    if(RepairElectricalPoleJob[playerid] == true){
        ApplyAnimation(playerid,"bomber", "bom_plant_loop",4.1, 1, 0, 1, 0, 0);
        return Y_HOOKS_BREAK_RETURN_1;
    }
	return Y_HOOKS_CONTINUE_RETURN_0;
}
hook OnProgressFinish(playerid)
{
	if(RepairElectricalPoleJob[playerid] == true)
		GetRepairElectricalPole(playerid);

	return Y_HOOKS_CONTINUE_RETURN_0;
}
GetRepairElectricalPole(playerid)
{
    new tmp2[127];
    

    RepairElectricalPoleJob[playerid] = false;
    ManyElectricalPole[playerid] ++;

    ApplyAnimation(playerid, "bomber","bom_plant_2idle", 4.1, 0, 0, 0, 0, 0, 1);
    format(tmp2, sizeof(tmp2), "~w~%d ~g~/ ~w~10", ManyElectricalPole[playerid]);
    GameTextForPlayer(playerid, tmp2, 1500, 3);
    playerData[playerid][pCheckpoint] = 0;

    if(ManyElectricalPole[playerid] >= 10) //�ú����ӹǹ
    {
        PlayerPlaySound(playerid, 21002, 0.0, 0.0, 0.0);
        SetPlayerCheckpoint(playerid, -70.5872,-1112.6737,1.0781, 5.0);
        return SendClientMessage(playerid, COLOR_YELLOW, "[Electrical Pole]: �س��������俿�Ҥú����ӹǹ���� ��Ѻ价�� Flint Gas �����Ѻ Paycheck");
    }
    PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
    SendClientMessage(playerid, COLOR_YELLOW, "[Electrical Pole]: �س�������俿�ҵ鹹�������, ��Ѻ��ѧö�ͧ�س���ͤ������俿�ҵ鹵���");
    return 1;
}

CMD:findep(playerid, params[])
{
    new idx = random(sizeof(Electrical_Pole));

    if(ManyElectricalPole[playerid] >= 10) //�ú����ӹǹ
    {
        playerData[playerid][pCheckpoint] = 1;
        PlayerPlaySound(playerid, 21002, 0.0, 0.0, 0.0);    
        SetPlayerCheckpoint(playerid, -70.5872,-1112.6737,1.0781, 5.0);
        SendClientMessage(playerid, COLOR_YELLOW, "[Electrical Pole]: �س��������俿�Ҥú����ӹǹ���� ��Ѻ价�� Flint Gas �����Ѻ Paycheck");
    }
    if(playerData[playerid][pCheckpoint] == 1)
        return SendClientMessage(playerid, COLOR_LIGHTRED, "- �س�������ö�������俿����㹢�й�� ��س�仫������俿���ѧ�������ش��͹");

    if(StartElectricalPoleJob[playerid] != true)
        return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö�����俿���� ���ͧ�ҡ�س�����ӧҹ�������俿��");

    if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 552)
        return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö�����俿���� ���ͧ�ҡ�س��������躹ö 'Utility Van'");

    PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
    SetPlayerCheckpoint(playerid, Electrical_Pole[idx][0], Electrical_Pole[idx][1], Electrical_Pole[idx][2], 0.5);
    playerData[playerid][pCheckpoint] = 1;
    SendClientMessage(playerid, COLOR_YELLOW, "[Electrical Pole]: ���俿�Ҷ١����, 仵�� Mini Map ���ͫ������俿��");
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{   
    new idx = random(sizeof(Electrical_Pole));
    if(StartElectricalPoleJob[playerid] == true)
    {
        if(ManyElectricalPole[playerid] >= 10)
            return 1;

        if(playerData[playerid][pCheckpoint] == 1)
            return 1;

        if(ManyElectricalPole[playerid] >= 1)
        {
            if(!IsElectricalPoleVehicle(vehicleid))
                return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö�����俿���� ���ͧ�ҡ�س��������躹ö 'Utility Van'");

            playerData[playerid][pCheckpoint] = 1;
            PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
            SetPlayerCheckpoint(playerid, Electrical_Pole[idx][0], Electrical_Pole[idx][1], Electrical_Pole[idx][2], 0.5);
        }
    }
    return 1;
}
stock IsElectricalPoleVehicle(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 552: return 1;
	}
	return 0;
}