#include	<YSI_Coding\y_hooks>
#include 	<YSI_Coding\y_timers>

new William_Oliver;

new bool:StartForklift[MAX_PLAYERS];
new bool:WorkForklift[MAX_PLAYERS];
new bool:CarryForklift[MAX_PLAYERS];

static TypeForklify[MAX_PLAYERS];
static AmountForklify[MAX_PLAYERS];
new bool:EndForklift[MAX_PLAYERS];

new VehicleForklift[MAX_PLAYERS];

new Float:RandomForkliftPoint[][] = {
	{2779.0376,-2502.6042,13.6532},
	{2778.9412,-2425.8748,13.6358},
	{2787.7056,-2447.2991,13.6337},
	{2779.3801,-2409.8528,13.6357},
	{2787.8801,-2409.5779,13.6336},
	{2778.8169,-2464.0271,13.6359},
	{2794.6672,-2485.5557,13.6419},
	{2794.8008,-2409.3474,13.6320},
	{2787.9695,-2465.0452,13.6336},
	{2779.1760,-2447.0432,13.6358},
	{2794.7703,-2447.1262,13.6320},
	{2778.5811,-2485.9854,13.6586},
	{2788.2927,-2503.3821,13.6497},
	{2787.8479,-2485.9712,13.6502},
	{2787.9119,-2426.2981,13.6336}
};

hook OnPlayerConnect(playerid)
{

    return 1;
}
hook OnPlayerDisconnect(playerid, reason)
{
    if(StartForklift[playerid] == true)
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[Forklift] รายการจัดส่งของคุณนั้้นถูกยกเลิก เนื่องจากคุณลงจากยานพาหนะ");
        DisablePlayerCheckpoint(playerid);
        DestroyVehicle(VehicleForklift[playerid]);

        StartForklift[playerid] = false;
        WorkForklift[playerid] = false;
        CarryForklift[playerid] = false;
        EndForklift[playerid] = false;
        TypeForklify[playerid] = 0;
        AmountForklify[playerid] = 0;

    }

    return 1;
}

hook OnGameModeInit()
{
    CreateObject(19376, 2815.95508, -2437.68091, 11.72730,   10.00000, 90.00000, 90.00000);
    CreateObject(19376, 2815.95508, -2388.51245, 11.72730,   10.00000, 90.00000, 90.00000);
    CreateObject(983, 2814.32837, -2383.37256, 12.65965,   10.00000, 0.00000, 90.00000);
    CreateObject(983, 2817.48877, -2383.37695, 12.09960,   10.00000, 0.00000, 90.00000);
    CreateObject(983, 2814.32837, -2393.71265, 12.65960,   10.00000, 0.00000, 90.00000);
    CreateObject(983, 2817.48877, -2393.71704, 12.09960,   10.00000, 0.00000, 90.00000);
    CreateObject(983, 2814.32837, -2432.37256, 12.65960,   10.00000, 0.00000, 90.00000);
    CreateObject(983, 2817.48877, -243.71700, 12.09960,   10.00000, 0.00000, 90.00000);
    CreateObject(983, 2817.46899, -2432.37500, 12.09960,   10.00000, 0.00000, 90.00000);
    CreateObject(983, 2814.32837, -2442.91260, 12.65960,   10.00000, 0.00000, 90.00000);
    CreateObject(983, 2817.46899, -2442.91504, 12.09960,   10.00000, 0.00000, 90.00000);
    CreateObject(19360, 2809.48486, -2392.14380, 12.52700,   0.00000, 90.00000, 0.00000);
    CreateObject(19360, 2809.48486, -2388.94385, 12.52700,   0.00000, 90.00000, 0.00000);
    CreateObject(19360, 2809.48486, -2385.74390, 12.52700,   0.00000, 90.00000, 0.00000);
    CreateObject(19360, 2809.48486, -2384.86377, 12.50700,   0.00000, 90.00000, 0.00000);
    CreateObject(19360, 2809.48486, -2441.33960, 12.52700,   0.00000, 89.98000, 0.00000);
    CreateObject(19360, 2809.48486, -2438.13965, 12.52700,   0.00000, 89.98000, 0.00000);
    CreateObject(19360, 2809.48486, -2434.93970, 12.52700,   0.00000, 89.98000, 0.00000);
    CreateObject(19360, 2809.48486, -2433.99976, 12.50700,   0.00000, 89.98000, 0.00000);



    William_Oliver = CreateActor(16,2721.2056,-2380.1274,17.3403,181.3862); 
    CreateDynamic3DTextLabel("William Oliver", COLOR_WHITE, 2721.2056,-2380.1274,17.3403+1.0, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);    
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 2721.2056,-2380.1274,17.3403))
        {
            if(!StartForklift[playerid])
                Dialog_Show(playerid, StartForkfilt, DIALOG_STYLE_INPUT, "{FFFFFF}William Oliver", "{FFFFFF}งาน: Forklift\n\
                รายได้: $75 ต่อลัง\n\
                ยานพาหนะ: Forklift\n\
                {FF6347}*หากคุณหยุดงานกลางคัน คุณจะสูญเสียรายได้ทั้งหมด\n\
                \n\
                {FFFFFF}โปรดระบุจำนวนลังสินค้าที่คุณต้องการจะขน (*จำเป็นต้องมากกว่า 3)", "เริ่มงาน", "ยกเลิก");

        }
        return 1;
    }
    return 1;
}

Dialog:StartForkfilt(playerid, response, listitem, inputtext[])
{
    new amount = strval(inputtext), TruckColor = randomEx(0, 127);


    
	if (response)
	{
		if (amount <= 3)
			return Dialog_Show(playerid, StartForkfilt, DIALOG_STYLE_INPUT, "{FFFFFF}William Oliver", "{FFFFFF}งาน: Forklift\n\
                รายได้: $75 ต่อลัง\n\
                ยานพาหนะ: Forklift\n\
                {FF6347}*หากคุณหยุดงานกลางคัน คุณจะสูญเสียรายได้ทั้งหมด\n\
                \n\
                {FFFFFF}โปรดระบุจำนวนลังสินค้าที่คุณต้องการจะขน (*จำเป็นต้องมากกว่า 3)", "เริ่มงาน", "ยกเลิก");
        
        VehicleForklift[playerid] = CreateVehicle(	530, 2740.3406,-2388.0842,13.3950,267.6793, TruckColor, TruckColor, 600);
        SetPlayerCheckpoint(playerid, 2740.3406,-2388.0842,13.3950, 4.0);
        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
        //PutPlayerInVehicle(playerid, VehicleForklift[playerid], 0);
        vehicleFuel[VehicleForklift[playerid]] = 110;

        SetVehicleNumberPlate(VehicleForklift[playerid], "Trucking");
        SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** William Oliver ได้ยื่นกุญแจรถ 'Forklift' ให้กับ %s", GetPlayerNameEx(playerid));
        ApplyActorAnimation(William_Oliver, "DEALER","shop_pay", 4.1, 0, 0, 0, 0, 0);
        PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);

        StartForklift[playerid] = true;
        TypeForklify[playerid] = amount;
    }
	return 1;
}

forward ForkliftEND(playerid);
public ForkliftEND(playerid)
{


    if(IsForkliftVehicle(playerid))
        return 1;

	TogglePlayerControllable(playerid, false);
	GameTextForPlayer(playerid, "~w~Product Carry...", 3000, 4) ;
	SetTimerEx("ForkliftCarry_Product", 3000, 0, "i", playerid);
    DisablePlayerCheckpoint(playerid);

    PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
	return 1;
}
forward ForkliftCarry_Product(playerid);
public ForkliftCarry_Product(playerid)
{
    new success = random(100), tmp2[127];

    TogglePlayerControllable(playerid, true);
    PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
    WorkForklift[playerid] = true;    
    CarryForklift[playerid] = false;
    AmountForklify[playerid] ++;
    format(tmp2, sizeof(tmp2), "~w~%d ~g~/ ~w~%d", AmountForklify[playerid], TypeForklify[playerid]);
    GameTextForPlayer(playerid, tmp2, 1500, 3);

    SetPlayerCheckpoint(playerid, 2823.9138,-2412.4924,12.0832, 4.0);
    PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
    switch (success)
    {
        case 0..50:
        {
            CargoSupplier[0] += 1;
        }
        case 51..100:
        {
            CargoSupplier[1] += 1;
        }
    }
    if(AmountForklify[playerid] == TypeForklify[playerid])
    {
        SendClientMessage(playerid, COLOR_YELLOW, "[Forklift] คุณได้ส่งลังสินค้าครบจำนวนแล้ว ไปยังจุดมาร์คเพื่อรับค่าจ้าง");
        WorkForklift[playerid] = true;    
        CarryForklift[playerid] = true;
        SetPlayerCheckpoint(playerid, 2740.3406,-2388.0842,13.3950, 4.0);
        PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
    }
    return 1;
}
forward ForkliftCarry(playerid);
public ForkliftCarry(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 530)
        return 1;

	TogglePlayerControllable(playerid, false);
	GameTextForPlayer(playerid, "~w~Forklift Carry...", 3000, 4) ;
	SetTimerEx("ForkliftCarry_Off", 3000, 0, "i", playerid);
    DisablePlayerCheckpoint(playerid);

    PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
	return 1;
}
forward ForkliftCarry_Off(playerid);
public ForkliftCarry_Off(playerid)
{
    new idx = random(sizeof(SpawnTruckingVehicle));

    WorkForklift[playerid] = false;
    CarryForklift[playerid] = true;
    
	TogglePlayerControllable(playerid, true);
    SetPlayerCheckpoint(playerid, RandomForkliftPoint[idx][0], RandomForkliftPoint[idx][1], RandomForkliftPoint[idx][2], 2.5);
    PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
}

stock IsForkliftVehicle(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 530: return 1;
	}
	return 0;
}

hook OnPlayerEnterCheckpoint(playerid)
{
    new amount = TypeForklify[playerid], tmp2[127];

    if(IsForkliftVehicle(playerid))
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[Forklift] รายการจัดส่งของคุณนั้้นถูกยกเลิก เนื่องจากคุณใช้ยานพาหนะผิดประเภท");
        DisablePlayerCheckpoint(playerid);
        DestroyVehicle(VehicleForklift[playerid]);

        StartForklift[playerid] = false;
        WorkForklift[playerid] = false;
        CarryForklift[playerid] = false;
        EndForklift[playerid] = false;
        TypeForklify[playerid] = 0;
        AmountForklify[playerid] = 0;
        return 1;
    }

    if(CarryForklift[playerid] == true && WorkForklift[playerid] == true)
    {
        //DestroyVehicle(playerid);
        format(tmp2, sizeof(tmp2), "~w~~n~Paycheck~g~+%s", FormatMoney(amount*75));
        GameTextForPlayer(playerid, tmp2, 2000, 3);
        playerData[playerid][pBankMoney] += amount*75;

        SendClientMessageEx(playerid, COLOR_GREEN, "[Forklift] การจัดส่งลังสินค้าของคุณนั้นเสร็จเรียบร้อย และคุณได้รับเงินจำนวน %s", FormatMoney(amount*75));
        StartForklift[playerid] = false;
        WorkForklift[playerid] = false;
        CarryForklift[playerid] = false;
        EndForklift[playerid] = false;
        TypeForklify[playerid] = 0;
        AmountForklify[playerid] = 0;
        DestroyVehicle(VehicleForklift[playerid]);

        DisablePlayerCheckpoint(playerid);
        EndForklift[playerid] = true;
        return 1;
    }

    if(WorkForklift[playerid] == true)
        ForkliftCarry(playerid);
        
    if(CarryForklift[playerid] == true)
        ForkliftEND(playerid);
    return 1;
}
hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(StartForklift[playerid] == true && TypeForklify[playerid] != 0)
    {
        if(IsForkliftVehicle(playerid))
            return 1;

        if(WorkForklift[playerid] == true)
            return 1;
        
        WorkForklift[playerid] = true;
        SendClientMessage(playerid, COLOR_YELLOW, "[Forklift] ขับรถ 'Forklift' ของคุณไปยังจุดมาร์ค เพื่อดำเนินการ..");
        SetPlayerCheckpoint(playerid, 2823.9138,-2412.4924,12.0832, 4.0);
        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
        return 1;
    }
    return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
    if(StartForklift[playerid] == true)
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[Forklift] รายการจัดส่งของคุณนั้้นถูกยกเลิก เนื่องจากคุณลงจากยานพาหนะ");
        DisablePlayerCheckpoint(playerid);
        DestroyVehicle(VehicleForklift[playerid]);

        StartForklift[playerid] = false;
        WorkForklift[playerid] = false;
        CarryForklift[playerid] = false;
        EndForklift[playerid] = false;
        TypeForklify[playerid] = 0;
        AmountForklify[playerid] = 0;
    }
    return 1;
}

hook OnVehicleDeath(vehicleid, killerid)
{
    /*for(new i = GetPlayerVehicleID(WorkForklift[killerid]); i > 1; i--)
    {
        DestroyVehicle(i);
    }*/
    DisablePlayerCheckpoint(killerid);
    DestroyVehicle(VehicleForklift[killerid]);

    StartForklift[killerid] = false;
    WorkForklift[killerid] = false;
    CarryForklift[killerid] = false;
    EndForklift[killerid] = false;
    TypeForklify[killerid] = 0;
    AmountForklify[killerid] = 0;
    return 1;
}