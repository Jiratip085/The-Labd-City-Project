#include	<YSI_Coding\y_hooks>
#include 	<YSI_Coding\y_timers>

new PlayerText:FishingJobTD[MAX_PLAYERS][3];

new bool:StartFishJobs[MAX_PLAYERS];
new bool:StartFishing[MAX_PLAYERS];
new GetFishing[MAX_PLAYERS];


hook OnGameModeInit()
{
    CreateObject(3753, 838.26801, -2075.50195, 2.64900,   0.00000, 0.00000, 180.00000);
    CreateObject(12990, 796.39502, -2073.87280, 1.39500,   0.02000, 0.00000, 90.00000);
    CreateObject(984, 826.40430, -2067.91675, 12.58950,   0.00000, 0.00000, 90.00000);
    CreateObject(983, 835.98981, -2067.88794, 12.64510,   0.00000, 0.00000, 90.00000);

    CreateActor(35,852.6661,-2071.8965,12.4630,90.3153); 
    CreateDynamic3DTextLabel("Fly_Fisher\n{AAAAAA}กด 'Y' เพื่อเริ่มงาน", COLOR_WHITE, 852.6661,-2071.8965,12.4630+1.7, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);    
}
hook OnPlayerConnect(playerid)
{
	FishingJobTD[playerid][0] = CreatePlayerTextDraw(playerid, 420.000000, 157.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, FishingJobTD[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, FishingJobTD[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FishingJobTD[playerid][0], 50.000000, 60.000000);
	PlayerTextDrawSetOutline(playerid, FishingJobTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, FishingJobTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, FishingJobTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, FishingJobTD[playerid][0], 120);
	PlayerTextDrawBackgroundColor(playerid, FishingJobTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, FishingJobTD[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, FishingJobTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, FishingJobTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, FishingJobTD[playerid][0], 1);

	FishingJobTD[playerid][1] = CreatePlayerTextDraw(playerid, 401.000000, 172.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, FishingJobTD[playerid][1], 5);
	PlayerTextDrawLetterSize(playerid, FishingJobTD[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FishingJobTD[playerid][1], 95.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, FishingJobTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, FishingJobTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, FishingJobTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, FishingJobTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, FishingJobTD[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, FishingJobTD[playerid][1], 255);
	PlayerTextDrawUseBox(playerid, FishingJobTD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, FishingJobTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, FishingJobTD[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, FishingJobTD[playerid][1], 2590);
	PlayerTextDrawSetPreviewRot(playerid, FishingJobTD[playerid][1], -10.000000, 0.000000, -80.000000, 0.709999);
	PlayerTextDrawSetPreviewVehCol(playerid, FishingJobTD[playerid][1], 1, 1);

	FishingJobTD[playerid][2] = CreatePlayerTextDraw(playerid, 433.500000, 178.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, FishingJobTD[playerid][2], 5);
	PlayerTextDrawLetterSize(playerid, FishingJobTD[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FishingJobTD[playerid][2], 24.000000, 19.500000);
	PlayerTextDrawSetOutline(playerid, FishingJobTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, FishingJobTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, FishingJobTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, FishingJobTD[playerid][2], -1061109505);
	PlayerTextDrawBackgroundColor(playerid, FishingJobTD[playerid][2], 0);
	PlayerTextDrawBoxColor(playerid, FishingJobTD[playerid][2], 255);
	PlayerTextDrawUseBox(playerid, FishingJobTD[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, FishingJobTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, FishingJobTD[playerid][2], 0);
	PlayerTextDrawSetPreviewModel(playerid, FishingJobTD[playerid][2], 1241);
	PlayerTextDrawSetPreviewRot(playerid, FishingJobTD[playerid][2], -10.000000, 0.000000, -90.000000, 0.709999);
	PlayerTextDrawSetPreviewVehCol(playerid, FishingJobTD[playerid][2], 1, 1);

    RemoveBuildingForPlayer(playerid, 792, 820.9297, -2066.1797, 12.1719, 0.25);
    RemoveBuildingForPlayer(playerid, 792, 851.7969, -2066.3594, 12.1719, 0.25);
    return 1;
}
ShowFishingTD(playerid)
{
	if (!playerData[playerid][IsLoggedIn])
		return 0;

    for (new i = 0; i < 3; i ++) {
        PlayerTextDrawShow(playerid, FishingJobTD[playerid][i]);
    }
	return 1;
}
HideFishingTD(playerid)
{
	if (!playerData[playerid][IsLoggedIn])
		return 0;

    for (new i = 0; i < 3; i ++) {
        PlayerTextDrawHide(playerid, FishingJobTD[playerid][i]);
    }
	return 1;
}

CMD:hu(playerid, params[])
{
    if (playerData[playerid][pAdmin] < 4)
	    return 1;

    if(StartFishJobs[playerid] == false)
        return Dialog_Show(playerid, Start_Fish, DIALOG_STYLE_MSGBOX, "Fly_Fisher", "{FFFFFF}Job: Fishing\n\
        คุณต้องการเริ่มงานในตอนนี้เลยหรือไม์?", "เริ่มงาน", "ยกเลิก");

    if(StartFishJobs[playerid] == true)
        return Dialog_Show(playerid, Stop_Fish, DIALOG_STYLE_MSGBOX, "Fly_Fisher", "{FFFFFF}Job: Fishing\n{FF6347}คุณต้องการหยุดงานที่คุณกำลังทำอยู่เลยหรือไม์?", "หยุดงาน", "ยกเลิก");
    return 1;
}

Dialog:Start_Fish(playerid, response, listitem, inputtext[])
{
	if (response)
	{   
        StartFishJobs[playerid] = true;

        PlayerPlaySound(playerid, 31200, 0.0, 0.0, 0.0);
        SetPlayerAttachedObject(playerid,9,19904,1,0.079999,0.059000,0.007999,-0.500001,86.399963,175.999969,1.000000,1.033000,1.000000);
        SendClientMessage(playerid, COLOR_YELLOW, "[Fishing]: คุณได้เริ่มงานตกปลา, หยิบเบ็ดตกปลาและเหยื่อออกมา");
        SendClientMessage(playerid, COLOR_YELLOW, "[Fishing]: ขึ้นไปบนเรือที่จอดอยู่และขับไปยัง zone สำหรับตกปลา");
        SendClientMessage(playerid, COLOR_LIGHTRED, "(( หากคุณ 'ออกเกม' หรือ 'หลุดเกม' งานที่คุณทำอยู่จะถูกยกเลิก, และคุณต้องกลับไปเริ่มใหม่ ))");
	}
	return 1;
}
Dialog:Stop_Fish(playerid, response, listitem, inputtext[])
{
	if (response)
	{
        StartFishJobs[playerid] = false;
        PlayerPlaySound(playerid, 31200, 0.0, 0.0, 0.0);
        RemovePlayerAttachedObject(playerid, 9);
        SendClientMessage(playerid, COLOR_YELLOW, "[Fishing]: คุณได้หยุดทำงาน Fishing เรียบร้อย");
	}
	return 1;
}



hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
        if (IsPlayerInRangeOfPoint(playerid, 1.5, 852.6661,-2071.8965,12.4630)) //เริ่มงาน
        {
            if(StartFishJobs[playerid] == false)
                return Dialog_Show(playerid, Start_Fish, DIALOG_STYLE_MSGBOX, "Fly_Fisher", "{FFFFFF}Job: Fishing\n\
                คุณต้องการเริ่มงานในตอนนี้เลยหรือไม์?", "เริ่มงาน", "ยกเลิก");

            if(StartFishJobs[playerid] == true)
                return Dialog_Show(playerid, Stop_Fish, DIALOG_STYLE_MSGBOX, "Fly_Fisher", "{FFFFFF}Job: Fishing\n{FF6347}คุณต้องการหยุดงานที่คุณกำลังทำอยู่เลยหรือไม์?", "หยุดงาน", "ยกเลิก");
        }
        if(StartFishing[playerid] == true && GetFishing[playerid] == 0)
        {

            PlayerTextDrawColor(playerid, FishingJobTD[playerid][0], 255);
            HideFishingTD(playerid);
            ApplyAnimation(playerid,"SWORD","sword_block",4.1, 0, 0, 0, 0, 0, 1);
            StartFishing[playerid] = false;
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Fishing]: เหยื่อของคุณหลุดออกจาเบ็ด");
            PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
            return 1;
        }
        if(StartFishing[playerid] == true && GetFishing[playerid] == 1)
        {
            PlayerTextDrawColor(playerid, FishingJobTD[playerid][0], 255);
            HideFishingTD(playerid);
            ApplyAnimation(playerid,"SWORD","sword_block",4.1, 0, 1, 1, 1, 1, 1);
            StartFishing[playerid] = false;
            StartProgress(playerid, 100, 0, 0);
            PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
            return 1;
        }
        if(StartFishing[playerid] == true && GetFishing[playerid] == 2)
        {
            PlayerTextDrawColor(playerid, FishingJobTD[playerid][0], 255);
            HideFishingTD(playerid);
            ApplyAnimation(playerid,"SWORD","sword_block",4.1, 0, 0, 0, 0, 0, 1);

            StartFishing[playerid] = false;
			playerData[playerid][pEquipmentJob] = 0;
            Inventory_Remove(playerid, "FishingRod");
			RemovePlayerAttachedObject(playerid, 8);
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Fishing]: เบ็ดตกปลาของคุณหัก เนื่องจากคุณใช้แรงมากเกินไป");
            PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
            return 1;
        }
    }
    return 1;
}



StartFishingJob(playerid)
{
    if(StartFishing[playerid] == false)
        return 1;
        
    new FishingTime = randomEx(3000,5000);
    SetTimerEx("Fishing", FishingTime, false, "d", playerid);
    GetFishing[playerid] = 0;
    return 1;
}

forward Fishing(playerid);
public Fishing(playerid)
{
    if(StartFishing[playerid] == false)
        return HideFishingTD(playerid);
        
    new Type = random(100);
    switch(Type)
    {
        case 0..60:
        {
            GetFishing[playerid] = 1;
            PlayerTextDrawColor(playerid, FishingJobTD[playerid][0], 6553855);
            PlayerTextDrawShow(playerid, FishingJobTD[playerid][0]);
            SetTimerEx("EndFishing", 1000, false, "d", playerid);
            return 1;
        }
        case 61..100:
        {
            GetFishing[playerid] = 2;
            PlayerTextDrawColor(playerid, FishingJobTD[playerid][0], -1962934017);
            PlayerTextDrawShow(playerid, FishingJobTD[playerid][0]);
            SetTimerEx("EndFishing", 1000, false, "d", playerid);
            return 1;
        }
    }
	return 1;
}
forward EndFishing(playerid);
public EndFishing(playerid)
{
    if(StartFishing[playerid] == false)
        return HideFishingTD(playerid);

    PlayerTextDrawColor(playerid, FishingJobTD[playerid][0], 255);
    PlayerTextDrawShow(playerid, FishingJobTD[playerid][0]);
    StartFishingJob(playerid);
    return 1;
}

hook OnProgressUpdate(playerid, progress, objectid)
{
    if(GetFishing[playerid] == 1){
        ApplyAnimation(playerid, "SAMP", "FishingIdle", 4.1, 0, 0, 0, 1, 0, 1);
        return Y_HOOKS_BREAK_RETURN_1;
    }
	return Y_HOOKS_CONTINUE_RETURN_0;
}
hook OnProgressFinish(playerid)
{
	if(GetFishing[playerid] == 1)
		GetFish(playerid);

	return Y_HOOKS_CONTINUE_RETURN_0;
}
GetFish(playerid)
{
    ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
    GetFishing[playerid] = 0;
    PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
    new TypeFish = random(100);

    switch(TypeFish)
    {
        case 0..20: //fish
        {
            new itemname[24];
            itemname = "Fish";
            new count = Inventory_Count(playerid, itemname);

            if (count >= playerData[playerid][pItemAmount])
                return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!", itemname);

            new id = Inventory_Add(playerid, itemname, 1);

            if (id == -1)
                return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ความจุของกระเป๋าของคุณนั้นเต็มแล้ว (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

            SendClientMessageEx(playerid, COLOR_GREEN, "[Fishing]: คุณได้ตก '%s' จำนวน 1 ตัวขึ้นมาจากทะเล", itemname);
        }
        case 21..42: //Shell
        {
            new itemname[24];
            itemname = "Shell";
            new count = Inventory_Count(playerid, itemname);

            if (count >= playerData[playerid][pItemAmount])
                return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!", itemname);

            new id = Inventory_Add(playerid, itemname, 1);

            if (id == -1)
                return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ความจุของกระเป๋าของคุณนั้นเต็มแล้ว (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

            SendClientMessageEx(playerid, COLOR_GREEN, "[Fishing]: คุณได้ตก '%s' จำนวน 1 ตัวขึ้นมาจากทะเล", itemname);
        }
        case 43..65: //Starfish
        {
            new itemname[24];
            itemname = "Starfish";
            new count = Inventory_Count(playerid, itemname);

            if (count >= playerData[playerid][pItemAmount])
                return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!", itemname);

            new id = Inventory_Add(playerid, itemname, 1);

            if (id == -1)
                return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ความจุของกระเป๋าของคุณนั้นเต็มแล้ว (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

            SendClientMessageEx(playerid, COLOR_GREEN, "[Fishing]: คุณได้ตก '%s' จำนวน 1 ตัวขึ้นมาจากทะเล", itemname);
        }
        case 66..89: //Jellyfish
        {
            new itemname[24];
            itemname = "Jellyfish";
            new count = Inventory_Count(playerid, itemname);

            if (count >= playerData[playerid][pItemAmount])
                return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!", itemname);

            new id = Inventory_Add(playerid, itemname, 1);

            if (id == -1)
                return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ความจุของกระเป๋าของคุณนั้นเต็มแล้ว (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

            SendClientMessageEx(playerid, COLOR_GREEN, "[Fishing]: คุณได้ตก '%s' จำนวน 1 ตัวขึ้นมาจากทะเล", itemname);
        }
        case 90..100: //Turtle
        {
            new itemname[24];
            itemname = "Turtle";
            new count = Inventory_Count(playerid, itemname);

            if (count >= playerData[playerid][pItemAmount])
                return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!", itemname);

            new id = Inventory_Add(playerid, itemname, 1);

            if (id == -1)
                return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ความจุของกระเป๋าของคุณนั้นเต็มแล้ว (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

            SendClientMessageEx(playerid, COLOR_GREEN, "[Fishing]: คุณได้ตก '%s' จำนวน 1 ตัวขึ้นมาจากทะเล", itemname);
        }
    }
   
    return 1;
}