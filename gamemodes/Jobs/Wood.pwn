#include	<YSI_Coding\y_hooks>

new TreeObj[15],
    bool:StartWoodJob[MAX_PLAYERS],
    bool:StartWoodProcess[MAX_PLAYERS],
    StartCutTree[MAX_PLAYERS];


RespawnWoods()
{
    for(new i = 0; i < sizeof TreeObj; i++) 
    {
        DestroyObject(TreeObj[i]);
        SetTimerEx("CreateWoods", 1000, false, "d",i);
    }
    return 1;
}

hook OnGameModeInit()
{
    TreeObj[0] = CreateObject(617, -558.37439, -66.67550, 62.96450,   0.00000, 0.00000, 138.60001);
    TreeObj[1] = CreateObject(617, -559.67322, -77.61970, 62.94450,   0.00000, 0.00000, 54.47990);
    TreeObj[2] = CreateObject(617, -552.29071, -57.32710, 62.76450,   0.00000, 0.00000, 69.95990);
    TreeObj[3] = CreateObject(617, -571.53046, -75.78589, 63.26449,   0.00000, 0.00000, -141.90004);
    TreeObj[4] = CreateObject(617, -569.98340, -63.21177, 63.26449,   0.00000, 0.00000, 41.27998);
    TreeObj[5] = CreateObject(617, -568.49780, -52.89998, 63.26449,   0.00000, 0.00000, 27.29993);
    TreeObj[6] = CreateObject(617, -582.48053, -75.24770, 63.22450,   0.00000, 0.00000, -197.75999);
    TreeObj[7] = CreateObject(617, -583.81311, -62.60500, 63.26449,   0.00000, 0.00000, -22.98001);
    TreeObj[8] = CreateObject(617, -593.51294, -49.39977, 63.26449,   0.00000, 0.00000, -154.26003);
    TreeObj[9] = CreateObject(617, -594.41626, -73.42647, 63.26449,   0.00000, 0.00000, -253.07996);
    TreeObj[10] = CreateObject(617, -594.30267, -61.53167, 63.26449,   0.00000, 0.00000, -69.78001);
    TreeObj[11] = CreateObject(617, -581.42578, -50.66977, 63.26449,   0.00000, 0.00000, 0.95993);
    TreeObj[12] = CreateObject(617, -538.07239, -45.87300, 62.04450,   0.00000, 0.00000, -6.60010);
    TreeObj[13] = CreateObject(617, -548.80157, -43.82380, 62.64450,   0.00000, 0.00000, -56.88010);
    TreeObj[14] = CreateObject(617, -561.73401, -42.27172, 63.26449,   0.00000, 0.00000, 12.77994);


    CreateActor(159,-532.9896,-64.8983,62.9868,267.8889); 
    CreateDynamic3DTextLabel("Lumber_Jack\n{AAAAAA}กด 'Y' เพื่อเริ่มงาน", COLOR_WHITE, -532.9896,-64.8983,62.9868+1.1, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

    CreateDynamicPickup(1239, 23, -537.2752,-78.3128,62.8672);
    CreateDynamic3DTextLabel("[Woods Pack]\n{AAAAAA}กด 'Y' เพื่อแพ็คไม้", COLOR_YELLOW,  -537.2752,-78.3128,62.8672, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

    return 1;
}
hook OnPlayerConnect(playerid)
{
    StartWoodJob[playerid] = true;
    StartCutTree[playerid] = 0;
    StartWoodProcess[playerid] = false;

    RemoveBuildingForPlayer(playerid, 835, -573.7422, -74.6953, 65.7031, 0.25);
    RemoveBuildingForPlayer(playerid, 12808, -563.3125, -57.1875, 65.4375, 0.25);
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    new tmp2[127];
    if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid,2.0, -532.9896,-64.8983,62.9868)) //เริ่มงาน
        {
            if(StartWoodJob[playerid] == false)
                return Dialog_Show(playerid, Start_Wood, DIALOG_STYLE_MSGBOX, "Lumber_Jack", "{FFFFFF}Job: Lumberjack\n\
                คุณต้องการเริ่มงานในตอนนี้เลยหรือไม่?", "เริ่มงาน", "ยกเลิก");

            if(StartWoodJob[playerid] == true)
                return Dialog_Show(playerid, Stop_Wood, DIALOG_STYLE_MSGBOX, "Lumber_Jack", "{FFFFFF}Job: Lumberjack\n{FF6347}คุณต้องการหยุดงานที่คุณกำลังทำอยู่เลยหรือไม์?", "หยุดงาน", "ยกเลิก");
        }
        if(IsPlayerInRangeOfPoint(playerid,2.0, -537.2752,-78.3128,62.8672)) //แพ็คไม้
        {
            new itemname[24];
            itemname = "Log";
            new count = Inventory_Count(playerid, itemname);

            if(count < 5)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "[Lumberjack]: คุณต้องมี 'Log' มากกว่า 5 ขึ้นไปจึงจะแพ็คออกมาได้");

            StartWoodProcess[playerid] = true;
            ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);
            StartProgress(playerid, 100, 0, 0);
            PlayerPlaySound(playerid, 31200, 0.0, 0.0, 0.0);
        }
    }
    if (newkeys & KEY_FIRE && !IsPlayerInAnyVehicle(playerid))
    {
        if(U_CheckPlayerNearObject(playerid, TreeObj[0], 2.0)
        || U_CheckPlayerNearObject(playerid, TreeObj[1], 2.0)
        || U_CheckPlayerNearObject(playerid, TreeObj[2], 2.0)
        || U_CheckPlayerNearObject(playerid, TreeObj[3], 2.0)
        || U_CheckPlayerNearObject(playerid, TreeObj[4], 2.0)
        || U_CheckPlayerNearObject(playerid, TreeObj[5], 2.0)
        || U_CheckPlayerNearObject(playerid, TreeObj[6], 2.0)
        || U_CheckPlayerNearObject(playerid, TreeObj[7], 2.0)
        || U_CheckPlayerNearObject(playerid, TreeObj[8], 2.0)
        || U_CheckPlayerNearObject(playerid, TreeObj[9], 2.0)
        || U_CheckPlayerNearObject(playerid, TreeObj[10], 2.0)
        || U_CheckPlayerNearObject(playerid, TreeObj[11], 2.0)
        || U_CheckPlayerNearObject(playerid, TreeObj[12], 2.0)
        || U_CheckPlayerNearObject(playerid, TreeObj[13], 2.0)
        || U_CheckPlayerNearObject(playerid, TreeObj[14], 2.0))
        {
            if(StartWoodJob[playerid] == true && playerData[playerid][pEquipmentJob] == 2)
            {
                if(StartCutTree[playerid] == 50)
                    return 1;

                StartCutTree[playerid] ++;
                format(tmp2, sizeof(tmp2), "~w~%d ~g~/ ~w~50", StartCutTree[playerid]);
                GameTextForPlayer(playerid, tmp2, 1500, 3);

                if(StartCutTree[playerid] == 50)
                {
                    CheckPlayerNearWood(playerid);
                    for(new i = 0; i < sizeof TreeObj; i++) {U_DestroyObjectNearPlayer(playerid,TreeObj[i], 5.0);}
                    PlayerPlaySound(playerid, 4604, 0.0, 0.0, 0.0);
                    ApplyAnimation(playerid,"BASEBALL", "BAT_4",4.1, 1, 0, 1, 0, 0);
                    StartProgress(playerid, 100, 0, 0);
                }
                return 1;
            }
        }
    }
    return 1;
}
Dialog:Start_Wood(playerid, response, listitem, inputtext[])
{
	if (response)
	{   
        StartWoodJob[playerid] = true;
        StartCutTree[playerid] = 0;
        StartWoodProcess[playerid] = false;
        SendClientMessage(playerid, COLOR_YELLOW, "[Lumberjack]: คุณได้เริ่มงาน Lumberjack, หยิบเลื่อยของคุณออกมาจากกระเป๋าและกด 'ต่อย' ที่ต้นไม้เพื่อตัด");
        SendClientMessage(playerid, COLOR_LIGHTRED, "(( หากคุณ 'ออกเกม' หรือ 'หลุดเกม' งานที่คุณทำอยู่จะถูกยกเลิก, และคุณต้องกลับไปเริ่มใหม่ ))");
        PlayerPlaySound(playerid, 31200, 0.0, 0.0, 0.0);
	}
	return 1;
}
Dialog:Stop_Wood(playerid, response, listitem, inputtext[])
{
	if (response)
	{
        StartWoodJob[playerid] = false;
        StartCutTree[playerid] = 0;
        StartWoodProcess[playerid] = false;
        SendClientMessage(playerid, COLOR_YELLOW, "[Lumberjack]: คุณได้หยุดทำงาน Lumberjack เรียบร้อย");
        PlayerPlaySound(playerid, 31200, 0.0, 0.0, 0.0);
	}
	return 1;
}


hook OnProgressUpdate(playerid, progress, objectid)
{
    if(StartCutTree[playerid] >= 50){
        ApplyAnimation(playerid,"bomber", "bom_plant_loop",4.1, 1, 0, 1, 0, 0);
        return Y_HOOKS_BREAK_RETURN_1;
    }

    if(StartWoodProcess[playerid] == true){
        ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);
        return Y_HOOKS_BREAK_RETURN_1;
    }

	return Y_HOOKS_CONTINUE_RETURN_0;
}
hook OnProgressFinish(playerid)
{
	if(StartCutTree[playerid] >= 50)
		WoodCutGet(playerid);

	if(StartWoodProcess[playerid] == true)
		WoodPackCutGet(playerid);

	return Y_HOOKS_CONTINUE_RETURN_0;
}
WoodCutGet(playerid)
{
    ClearAnimations(playerid);
	ApplyAnimation(playerid, "CARRY","liftup05", 4.1, 0, 0, 0, 0, 0, 1);
    
    new Hammer = random(100);

    switch(Hammer)
    {
        case 0..97:
        {

        }
        case 98..100:
        {

			playerData[playerid][pEquipmentJob] = 0;
            Inventory_Remove(playerid, "Chainsaw");
			RemovePlayerAttachedObject(playerid, 8);
			RemovePlayerAttachedObject(playerid, 9);
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Lumberjack]: ค้อนของคุณพัง เนื่องจากเกิดความเสียหายมากเกินไป");
        }
    }
    new itemname[24], WoodsRandom = randomEx(3, 5);
    itemname = "Log";
    new count = Inventory_Count(playerid, itemname);

    StartCutTree[playerid] = 0;

    PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);

    if (count >= playerData[playerid][pItemAmount])
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!", itemname);

    new id = Inventory_Add(playerid, itemname, WoodsRandom);

    if (id == -1)
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ความจุของกระเป๋าของคุณนั้นเต็มแล้ว (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

    SendClientMessageEx(playerid, COLOR_GREEN, "[Lumberjack]: คุณได้รับ 'Log' จำนวน %d ท่อนจากการตัด", WoodsRandom);
    return 1;
}
WoodPackCutGet(playerid)
{
    ClearAnimations(playerid);
    
    new itemname[24], PackWoods = randomEx(1, 2);
    Inventory_Remove(playerid, "Log", 5);
    itemname = "WoodPacks";
    new count = Inventory_Count(playerid, itemname);

    StartWoodProcess[playerid] = false;
    PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);

    if (count >= playerData[playerid][pItemAmount])
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!", itemname);

    new id = Inventory_Add(playerid, itemname, PackWoods);

    if (id == -1)
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ความจุของกระเป๋าของคุณนั้นเต็มแล้ว (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

    SendClientMessageEx(playerid, COLOR_GREEN, "[Lumberjack]: คุณได้รับ 'WoodPacks' จำนวน %d จากการแพ็คไม้", PackWoods);
    return 1;
}





stock CheckPlayerNearWood(playerid)
{
    if(U_CheckPlayerNearObject(playerid, TreeObj[0], 2.5)) SetTimerEx("CreateWoods", 60000, false, "d",0);
    if(U_CheckPlayerNearObject(playerid, TreeObj[1], 2.5)) SetTimerEx("CreateWoods", 60000, false, "d",1);
    if(U_CheckPlayerNearObject(playerid, TreeObj[2], 2.5)) SetTimerEx("CreateWoods", 60000, false, "d",2);
    if(U_CheckPlayerNearObject(playerid, TreeObj[3], 2.5)) SetTimerEx("CreateWoods", 60000, false, "d",3);
    if(U_CheckPlayerNearObject(playerid, TreeObj[4], 2.5)) SetTimerEx("CreateWoods", 60000, false, "d",4);
    if(U_CheckPlayerNearObject(playerid, TreeObj[5], 2.5)) SetTimerEx("CreateWoods", 60000, false, "d",5);
    if(U_CheckPlayerNearObject(playerid, TreeObj[6], 2.5)) SetTimerEx("CreateWoods", 60000, false, "d",6);
    if(U_CheckPlayerNearObject(playerid, TreeObj[7], 2.5)) SetTimerEx("CreateWoods", 60000, false, "d",7);
    if(U_CheckPlayerNearObject(playerid, TreeObj[8], 2.5)) SetTimerEx("CreateWoods", 60000, false, "d",8);
    if(U_CheckPlayerNearObject(playerid, TreeObj[9], 2.5)) SetTimerEx("CreateWoods", 60000, false, "d",9);
    if(U_CheckPlayerNearObject(playerid, TreeObj[10], 2.5)) SetTimerEx("CreateWoods", 60000, false, "d",10);
    if(U_CheckPlayerNearObject(playerid, TreeObj[11], 2.5)) SetTimerEx("CreateWoods", 60000, false, "d",11);
    if(U_CheckPlayerNearObject(playerid, TreeObj[12], 2.5)) SetTimerEx("CreateWoods", 60000, false, "d",12);
    if(U_CheckPlayerNearObject(playerid, TreeObj[13], 2.5)) SetTimerEx("CreateWoods", 60000, false, "d",13);
    if(U_CheckPlayerNearObject(playerid, TreeObj[14], 2.5)) SetTimerEx("CreateWoods", 60000, false, "d",14);
    return 1;
}

forward CreateWoods(i);
public  CreateWoods(i)
{
    switch(i)
    {

    case 0: TreeObj[0] = CreateObject(617, -558.37439, -66.67550, 62.96450,   0.00000, 0.00000, 138.60001);
    case 1: TreeObj[1] = CreateObject(617, -559.67322, -77.61970, 62.94450,   0.00000, 0.00000, 54.47990);
    case 2: TreeObj[2] = CreateObject(617, -552.29071, -57.32710, 62.76450,   0.00000, 0.00000, 69.95990);
    case 3: TreeObj[3] = CreateObject(617, -571.53046, -75.78589, 63.26449,   0.00000, 0.00000, -141.90004);
    case 4: TreeObj[4] = CreateObject(617, -569.98340, -63.21177, 63.26449,   0.00000, 0.00000, 41.27998);
    case 5: TreeObj[5] = CreateObject(617, -568.49780, -52.89998, 63.26449,   0.00000, 0.00000, 27.29993);
    case 6: TreeObj[6] = CreateObject(617, -582.48053, -75.24770, 63.22450,   0.00000, 0.00000, -197.75999);
    case 7: TreeObj[7] = CreateObject(617, -583.81311, -62.60500, 63.26449,   0.00000, 0.00000, -22.98001);
    case 8: TreeObj[8] = CreateObject(617, -593.51294, -49.39977, 63.26449,   0.00000, 0.00000, -154.26003);
    case 9: TreeObj[9] = CreateObject(617, -594.41626, -73.42647, 63.26449,   0.00000, 0.00000, -253.07996);
    case 10: TreeObj[10] = CreateObject(617, -594.30267, -61.53167, 63.26449,   0.00000, 0.00000, -69.78001);
    case 11: TreeObj[11] = CreateObject(617, -581.42578, -50.66977, 63.26449,   0.00000, 0.00000, 0.95993);
    case 12: TreeObj[12] = CreateObject(617, -538.07239, -45.87300, 62.04450,   0.00000, 0.00000, -6.60010);
    case 13: TreeObj[13] = CreateObject(617, -548.80157, -43.82380, 62.64450,   0.00000, 0.00000, -56.88010);
    case 14: TreeObj[14] = CreateObject(617, -561.73401, -42.27172, 63.26449,   0.00000, 0.00000, 12.77994);
    }
    return 1;
}

