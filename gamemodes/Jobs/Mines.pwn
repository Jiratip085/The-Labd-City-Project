#include	<YSI_Coding\y_hooks>

new OreObj[21],
    bool:StartMineOre[MAX_PLAYERS],
    bool:StartMineJob[MAX_PLAYERS],
    bool:StartMineProcess[MAX_PLAYERS];





RespawnMines()
{
    for(new i = 0; i < sizeof OreObj; i++) 
    {
        DestroyObject(OreObj[i]);
        SetTimerEx("CreateOre", 1000, false, "d",i);
    }
    return 1;
}
hook OnGameModeInit()
{

    OreObj[0] = CreateObject(3929, 576.05518, 893.46466, -44.30049,   0.00000, 0.00000, -0.06000);
    OreObj[1] = CreateObject(3929, 606.10095, 895.61407, -45.01393,   0.00000, 0.00000, -0.06000);
    OreObj[2] = CreateObject(3929, 588.51251, 884.23175, -45.24485,   0.00000, 0.00000, -0.06000);
    OreObj[3] = CreateObject(3929, 605.79364, 883.12128, -43.94808,   0.00000, 0.00000, -0.06000);
    OreObj[4] = CreateObject(3929, 610.90796, 889.66595, -44.23385,   0.00000, 0.00000, -0.06000);
    OreObj[5] = CreateObject(3929, 591.08270, 891.25208, -44.88032,   0.00000, 0.00000, -0.06000);
    OreObj[6] = CreateObject(3929, 567.08813, 889.29718, -44.00430,   0.00000, 0.00000, -0.06000);
    OreObj[7] = CreateObject(3929, 630.87390, 889.51190, -43.67072,   0.00000, 0.00000, -0.06000);
    OreObj[8] = CreateObject(3929, 600.84753, 875.38458, -43.76241,   0.00000, 0.00000, -0.06000);
    OreObj[9] = CreateObject(3929, 575.14111, 884.54089, -44.04488,   0.00000, 0.00000, -0.06000);
    OreObj[10] = CreateObject(3929, 564.42181, 882.17700, -44.04979,   0.00000, 0.00000, -0.06000);
    OreObj[11] = CreateObject(3929, 571.21741, 873.30042, -44.41837,   0.00000, 0.00000, -0.06000);
    OreObj[12] = CreateObject(3929, 597.50201, 866.55823, -43.71114,   0.00000, 0.00000, -0.06000);
    OreObj[13] = CreateObject(3929, 602.32422, 888.66925, -44.43517,   0.00000, 0.00000, -0.06000);
    OreObj[14] = CreateObject(3929, 615.98975, 882.06946, -43.71114,   0.00000, 0.00000, -0.06000);
    OreObj[15] = CreateObject(3929, 609.14752, 876.45441, -43.61908,   0.00000, 0.00000, -0.06000);
    OreObj[16] = CreateObject(3929, 615.33350, 865.19122, -43.71114,   0.00000, 0.00000, -0.06000);
    OreObj[17] = CreateObject(3929, 631.95685, 876.04535, -43.71114,   0.00000, 0.00000, -0.06000);
    OreObj[18] = CreateObject(3929, 623.95032, 878.88904, -43.71114,   0.00000, 0.00000, -0.06000);
    OreObj[19] = CreateObject(3929, 638.35272, 881.89880, -43.71114,   0.00000, 0.00000, -0.06000);
    OreObj[20] = CreateObject(3929, 616.58698, 874.65967, -43.71114,   0.00000, 0.00000, -0.06000);


    CreateActor(16, 627.0108,895.2153,-41.1028,242.9069); 
    CreateDynamic3DTextLabel("Levi_Strauss\n{AAAAAA}กด 'Y' เพื่อเริ่มงาน", COLOR_WHITE, 627.0108,895.2153,-41.1028+1.1, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    
    CreateDynamicPickup(1239, 23, 619.9394,893.4549,-37.1285);
    CreateDynamic3DTextLabel("[Mine Process]\n{AAAAAA}กด 'Y' เพื่อสกัดแร่", COLOR_YELLOW,  619.9394,893.4549,-37.1285, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

}

hook OnPlayerConnect(playerid)
{
    StartMineOre[playerid] = false;
    StartMineJob[playerid] = false;
    StartMineProcess[playerid] = false;
    return 1;
}
Dialog:Start_Mines(playerid, response, listitem, inputtext[])
{
	if (response)
	{   
        StartMineJob[playerid] = true;
        StartMineOre[playerid] = false;
        StartMineProcess[playerid] = false;
        PlayerPlaySound(playerid, 31200, 0.0, 0.0, 0.0);
        SendClientMessage(playerid, COLOR_YELLOW, "[Mines]:: คุณได้เริ่มงาน Mines, หยิบค้อนของคุณออกมาจากกระเป๋าและ กด 'ต่อย' เพื่อขุดแร่");
        SendClientMessage(playerid, COLOR_LIGHTRED, "(( หากคุณ 'ออกเกม' หรือ 'หลุดเกม' งานที่คุณทำอยู่จะถูกยกเลิก, และคุณต้องกลับไปเริ่มใหม่ ))");
	}
	return 1;
}
Dialog:Stop_Mines(playerid, response, listitem, inputtext[])
{
	if (response)
	{
        StartMineOre[playerid] = false;
        StartMineJob[playerid] = false;
        StartMineProcess[playerid] = false;
        PlayerPlaySound(playerid, 31200, 0.0, 0.0, 0.0);
        SendClientMessage(playerid, COLOR_YELLOW, "[Mines]:: คุณได้หยุดทำงาน Mines เรียบร้อย");
	}
	return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid,2.0, 627.0108,895.2153,-41.1028)) //เริ่มงาน
        {
            if(StartMineJob[playerid] == false)
                return Dialog_Show(playerid, Start_Mines, DIALOG_STYLE_MSGBOX, "Levi_Strauss", "{FFFFFF}Job: Mines\n\
                คุณต้องการเริ่มงานในตอนนี้เลยหรือไม์?", "เริ่มงาน", "ยกเลิก");

            if(StartMineJob[playerid] == true)
                return Dialog_Show(playerid, Stop_Mines, DIALOG_STYLE_MSGBOX, "Levi_Strauss", "{FFFFFF}Job: Mines\n{FF6347}คุณต้องการหยุดงานที่คุณกำลังทำอยู่เลยหรือไม์?", "หยุดงาน", "ยกเลิก");
        }
        if(IsPlayerInRangeOfPoint(playerid,2.5, 619.9394,893.4549,-37.1285)) //สกัดแร่
        {
            new itemname[24];
            itemname = "Ore";
            new count = Inventory_Count(playerid, itemname);

            if(count < 5)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "[Mines]:: คุณต้องมี 'Ore' มากกว่า 5 ขึ้นไปจึงจะสกัดแร่ออกมาได้");

            StartMineProcess[playerid] = true;
            ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);
            StartProgress(playerid, 100, 0, 0);
            PlayerPlaySound(playerid, 31200, 0.0, 0.0, 0.0);
            return 1;
        }
    }
    if (newkeys & KEY_FIRE && !IsPlayerInAnyVehicle(playerid)) //ขุดแร่
    {
        if(U_CheckPlayerNearObject(playerid, OreObj[0], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[1], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[2], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[3], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[4], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[5], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[6], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[7], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[8], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[9], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[10], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[11], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[12], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[13], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[14], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[15], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[16], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[17], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[18], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[19], 2.0)
        || U_CheckPlayerNearObject(playerid, OreObj[20], 2.0))
        {
            if(StartMineJob[playerid] == true && StartMineOre[playerid] == false && playerData[playerid][pEquipmentJob] == 1) 
            {
                StartMineOre[playerid] = true;
                CheckPlayerNearOre(playerid);
                ApplyAnimation(playerid,"BASEBALL", "BAT_4",4.1, 1, 0, 1, 0, 0);
                StartProgress(playerid, 100, 0, 0);
                return 1;
            }
        }
    }
    return 1;
}












hook OnProgressUpdate(playerid, progress, objectid)
{
    if(StartMineOre[playerid] == true){
        ApplyAnimation(playerid,"BASEBALL", "BAT_4",4.1, 1, 0, 1, 0, 0);
        return Y_HOOKS_BREAK_RETURN_1;
    }
    if(StartMineProcess[playerid] == true){
        ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);
        return Y_HOOKS_BREAK_RETURN_1;
    }
	return Y_HOOKS_CONTINUE_RETURN_0;
}
hook OnProgressFinish(playerid)
{
	if(StartMineOre[playerid] == true)
		MineOreGet(playerid);

	if(StartMineProcess[playerid] == true)
		ProcessOreGet(playerid);

	return Y_HOOKS_CONTINUE_RETURN_0;
}
MineOreGet(playerid)
{
    ClearAnimations(playerid);
	ApplyAnimation(playerid, "CARRY","liftup", 4.1, 0, 0, 0, 0, 0, 1);
    new itemname[24];
    itemname = "Ore";
    new count = Inventory_Count(playerid, itemname);

    new Hammer = random(100);

    switch(Hammer)
    {
        case 0..97:
        {

        }
        case 98..100:
        {

			playerData[playerid][pEquipmentJob] = 0;
            Inventory_Remove(playerid, "Hammer");
			RemovePlayerAttachedObject(playerid, 8);
			RemovePlayerAttachedObject(playerid, 9);
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Mines]: ค้อนของคุณพัง เนื่องจากเกิดความเสียหายมากเกินไป");
        }
    }

    StartMineOre[playerid] = false;
    for(new i = 0; i < sizeof OreObj; i++) {U_DestroyObjectNearPlayer(playerid,OreObj[i], 5.0);}
    TogglePlayerControllable(playerid, 1);
    PlayerPlaySound(playerid, 17807, 0.0, 0.0, 0.0);
    if (count >= playerData[playerid][pItemAmount])
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!", itemname);

    new id = Inventory_Add(playerid, itemname, 1);

    if (id == -1)
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ความจุของกระเป๋าของคุณนั้นเต็มแล้ว (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

    SendClientMessage(playerid, COLOR_GREEN, "[Mines]: คุณได้รับ 'Ore' จำนวน 1 ก้อนจากการขุด");
    return 1;
}
ProcessOreGet(playerid)
{
    ClearAnimations(playerid);
    Inventory_Remove(playerid, "Ore", 5);
    StartMineProcess[playerid] = false;
    PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);

    new TypeOre = random(100),
        amountOre = randomEx(1, 3);

    switch(TypeOre)
    {
        case 0..10:
        {
            ClearAnimations(playerid);
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Mines]: คุณสกัด Ore ออกมาแต่ไม่พบเจอแร่");
        }
        case 11..59: //IRON
        {

            ClearAnimations(playerid);
            new itemname[24];
            itemname = "Iron";
            new count = Inventory_Count(playerid, itemname);

            if (count >= playerData[playerid][pItemAmount])
                return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!", itemname);

            new id = Inventory_Add(playerid, itemname, amountOre);

            if (id == -1)
                return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ความจุของกระเป๋าของคุณนั้นเต็มแล้ว (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

            SendClientMessageEx(playerid, COLOR_GREEN, "[Mines]: คุณสกัด Ore ออกมาเป็นแร่ 'Iron' จำนวน %d ก้อน", amountOre);
        }
        case 60..95: //GOLD
        {

            ClearAnimations(playerid);
            new itemname[24];
            itemname = "Gold";
            new count = Inventory_Count(playerid, itemname);

            if (count >= playerData[playerid][pItemAmount])
                return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!", itemname);

            new id = Inventory_Add(playerid, itemname, amountOre);

            if (id == -1)
                return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ความจุของกระเป๋าของคุณนั้นเต็มแล้ว (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

            SendClientMessageEx(playerid, COLOR_GREEN, "[Mines]: คุณสกัด Ore ออกมาเป็นแร่ 'Gold' จำนวน %d ก้อน", amountOre);
        }
        case 96..100: //DIAMON
        {

            ClearAnimations(playerid);
            new itemname[24];
            itemname = "Diamon";
            new count = Inventory_Count(playerid, itemname);

            if (count >= playerData[playerid][pItemAmount])
                return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!", itemname);

            new id = Inventory_Add(playerid, itemname, amountOre);

            if (id == -1)
                return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ความจุของกระเป๋าของคุณนั้นเต็มแล้ว (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

            SendClientMessageEx(playerid, COLOR_GREEN, "[Mines]: คุณสกัด Ore ออกมาเป็นแร่ 'Diamon' จำนวน %d ก้อน", amountOre);
        }
    }
    return 1;
}





stock CheckPlayerNearOre(playerid)
{
    if(U_CheckPlayerNearObject(playerid, OreObj[0], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",0);
    if(U_CheckPlayerNearObject(playerid, OreObj[1], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",1);
    if(U_CheckPlayerNearObject(playerid, OreObj[2], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",2);
    if(U_CheckPlayerNearObject(playerid, OreObj[3], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",3);
    if(U_CheckPlayerNearObject(playerid, OreObj[4], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",4);
    if(U_CheckPlayerNearObject(playerid, OreObj[5], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",5);
    if(U_CheckPlayerNearObject(playerid, OreObj[6], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",6);
    if(U_CheckPlayerNearObject(playerid, OreObj[7], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",7);
    if(U_CheckPlayerNearObject(playerid, OreObj[8], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",8);
    if(U_CheckPlayerNearObject(playerid, OreObj[9], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",9);
    if(U_CheckPlayerNearObject(playerid, OreObj[10], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",10);
    if(U_CheckPlayerNearObject(playerid, OreObj[11], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",11);
    if(U_CheckPlayerNearObject(playerid, OreObj[12], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",12);
    if(U_CheckPlayerNearObject(playerid, OreObj[13], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",13);
    if(U_CheckPlayerNearObject(playerid, OreObj[14], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",14);
    if(U_CheckPlayerNearObject(playerid, OreObj[15], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",15);
    if(U_CheckPlayerNearObject(playerid, OreObj[16], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",16);
    if(U_CheckPlayerNearObject(playerid, OreObj[17], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",17);
    if(U_CheckPlayerNearObject(playerid, OreObj[18], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",18);
    if(U_CheckPlayerNearObject(playerid, OreObj[19], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",19);
    if(U_CheckPlayerNearObject(playerid, OreObj[20], 2.0)) SetTimerEx("CreateOre", 60000, false, "d",20);
    return 1;
}
forward CreateOre(i);
public  CreateOre(i)
{
    switch(i)
    {
        case 0: OreObj[0] = CreateObject(3929, 576.05518, 893.46466, -44.30049,   0.00000, 0.00000, -0.06000);
        case 1: OreObj[1] = CreateObject(3929, 606.10095, 895.61407, -45.01393,   0.00000, 0.00000, -0.06000);
        case 2: OreObj[2] = CreateObject(3929, 588.51251, 884.23175, -45.24485,   0.00000, 0.00000, -0.06000);
        case 3: OreObj[3] = CreateObject(3929, 605.79364, 883.12128, -43.94808,   0.00000, 0.00000, -0.06000);
        case 4: OreObj[4] = CreateObject(3929, 610.90796, 889.66595, -44.23385,   0.00000, 0.00000, -0.06000);
        case 5: OreObj[5] = CreateObject(3929, 591.08270, 891.25208, -44.88032,   0.00000, 0.00000, -0.06000);
        case 6: OreObj[6] = CreateObject(3929, 567.08813, 889.29718, -44.00430,   0.00000, 0.00000, -0.06000);
        case 7: OreObj[7] = CreateObject(3929, 630.87390, 889.51190, -43.67072,   0.00000, 0.00000, -0.06000);
        case 8: OreObj[8] = CreateObject(3929, 600.84753, 875.38458, -43.76241,   0.00000, 0.00000, -0.06000);
        case 9: OreObj[9] = CreateObject(3929, 575.14111, 884.54089, -44.04488,   0.00000, 0.00000, -0.06000);
        case 10: OreObj[10] = CreateObject(3929, 564.42181, 882.17700, -44.04979,   0.00000, 0.00000, -0.06000);
        case 11: OreObj[11] = CreateObject(3929, 571.21741, 873.30042, -44.41837,   0.00000, 0.00000, -0.06000);
        case 12: OreObj[12] = CreateObject(3929, 597.50201, 866.55823, -43.71114,   0.00000, 0.00000, -0.06000);
        case 13: OreObj[13] = CreateObject(3929, 602.32422, 888.66925, -44.43517,   0.00000, 0.00000, -0.06000);
        case 14: OreObj[14] = CreateObject(3929, 615.98975, 882.06946, -43.71114,   0.00000, 0.00000, -0.06000);
        case 15: OreObj[15] = CreateObject(3929, 609.14752, 876.45441, -43.61908,   0.00000, 0.00000, -0.06000);
        case 16: OreObj[16] = CreateObject(3929, 615.33350, 865.19122, -43.71114,   0.00000, 0.00000, -0.06000);
        case 17: OreObj[17] = CreateObject(3929, 631.95685, 876.04535, -43.71114,   0.00000, 0.00000, -0.06000);
        case 18: OreObj[18] = CreateObject(3929, 623.95032, 878.88904, -43.71114,   0.00000, 0.00000, -0.06000);
        case 19: OreObj[19] = CreateObject(3929, 638.35272, 881.89880, -43.71114,   0.00000, 0.00000, -0.06000);
        case 20: OreObj[20] = CreateObject(3929, 616.58698, 874.65967, -43.71114,   0.00000, 0.00000, -0.06000);
    }
    return 1;
}