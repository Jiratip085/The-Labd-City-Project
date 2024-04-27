#include	<YSI_Coding\y_hooks>
#include 	<YSI_Coding\y_timers>


new AppleTree[18];
new PlayerText:AppleTD[MAX_PLAYERS][8];


RespawnApple()
{
    for(new i = 0; i < sizeof AppleTree; i++) 
    {
        DestroyObject(AppleTree[i]);
        SetTimerEx("CreateApple", 1000, false, "d",i);
    }
    return 1;
}

new bool:StartApple[MAX_PLAYERS];
new bool:StartCrate[MAX_PLAYERS];
new GetApple[MAX_PLAYERS];


hook OnPlayerConnect(playerid)
{
	AppleTD[playerid][0] = CreatePlayerTextDraw(playerid, 270.000000, 173.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, AppleTD[playerid][0], 5);
	PlayerTextDrawLetterSize(playerid, AppleTD[playerid][0], 0.1200000, 2.000000);
	PlayerTextDrawTextSize(playerid, AppleTD[playerid][0], 30.500000, 37.000000);
	PlayerTextDrawSetOutline(playerid, AppleTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, AppleTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, AppleTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, AppleTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, AppleTD[playerid][0], 0);
	PlayerTextDrawBoxColor(playerid, AppleTD[playerid][0], 255);
	PlayerTextDrawUseBox(playerid, AppleTD[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, AppleTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, AppleTD[playerid][0], 1);
	PlayerTextDrawSetPreviewModel(playerid, AppleTD[playerid][0], 19575);
	PlayerTextDrawSetPreviewRot(playerid, AppleTD[playerid][0], -13.000000, -12.000000, -17.000000, 0.569999);
	PlayerTextDrawSetPreviewVehCol(playerid, AppleTD[playerid][0], 1, 1);
    
	AppleTD[playerid][1] = CreatePlayerTextDraw(playerid, 336.000000, 256.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, AppleTD[playerid][1], 5);
	PlayerTextDrawLetterSize(playerid, AppleTD[playerid][1], 0.1200000, 2.000000);
	PlayerTextDrawTextSize(playerid, AppleTD[playerid][1], 30.500000, 37.000000);
	PlayerTextDrawSetOutline(playerid, AppleTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, AppleTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, AppleTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, AppleTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, AppleTD[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, AppleTD[playerid][1], 255);
	PlayerTextDrawUseBox(playerid, AppleTD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, AppleTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, AppleTD[playerid][1], 1);
	PlayerTextDrawSetPreviewModel(playerid, AppleTD[playerid][1], 19575);
	PlayerTextDrawSetPreviewRot(playerid, AppleTD[playerid][1], -3.000000, 12.000000, -44.000000, 0.569999);
	PlayerTextDrawSetPreviewVehCol(playerid, AppleTD[playerid][1], 1, 1);

	AppleTD[playerid][2] = CreatePlayerTextDraw(playerid, 327.000000, 148.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, AppleTD[playerid][2], 5);
	PlayerTextDrawLetterSize(playerid, AppleTD[playerid][2], 0.1200000, 2.000000);
	PlayerTextDrawTextSize(playerid, AppleTD[playerid][2], 30.500000, 37.000000);
	PlayerTextDrawSetOutline(playerid, AppleTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, AppleTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, AppleTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, AppleTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, AppleTD[playerid][2], 0);
	PlayerTextDrawBoxColor(playerid, AppleTD[playerid][2], 255);
	PlayerTextDrawUseBox(playerid, AppleTD[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, AppleTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, AppleTD[playerid][2], 1);
	PlayerTextDrawSetPreviewModel(playerid, AppleTD[playerid][2], 19575);
	PlayerTextDrawSetPreviewRot(playerid, AppleTD[playerid][2], -3.000000, -8.000000, -44.000000, 0.569999);
	PlayerTextDrawSetPreviewVehCol(playerid, AppleTD[playerid][2], 1, 1);

	AppleTD[playerid][3] = CreatePlayerTextDraw(playerid, 302.000000, 213.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, AppleTD[playerid][3], 5);
	PlayerTextDrawLetterSize(playerid, AppleTD[playerid][3], 0.1200000, 2.000000);
	PlayerTextDrawTextSize(playerid, AppleTD[playerid][3], 30.500000, 37.000000);
	PlayerTextDrawSetOutline(playerid, AppleTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, AppleTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, AppleTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, AppleTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, AppleTD[playerid][3], 0);
	PlayerTextDrawBoxColor(playerid, AppleTD[playerid][3], 255);
	PlayerTextDrawUseBox(playerid, AppleTD[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, AppleTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, AppleTD[playerid][3], 1);
	PlayerTextDrawSetPreviewModel(playerid, AppleTD[playerid][3], 19575);
	PlayerTextDrawSetPreviewRot(playerid, AppleTD[playerid][3], -3.000000, 16.000000, -44.000000, 0.569999);
	PlayerTextDrawSetPreviewVehCol(playerid, AppleTD[playerid][3], 1, 1);

	AppleTD[playerid][4] = CreatePlayerTextDraw(playerid, 255.000000, 219.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, AppleTD[playerid][4], 5);
	PlayerTextDrawLetterSize(playerid, AppleTD[playerid][4], 0.1200000, 2.000000);
	PlayerTextDrawTextSize(playerid, AppleTD[playerid][4], 30.500000, 37.000000);
	PlayerTextDrawSetOutline(playerid, AppleTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, AppleTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, AppleTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, AppleTD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, AppleTD[playerid][4], 0);
	PlayerTextDrawBoxColor(playerid, AppleTD[playerid][4], 255);
	PlayerTextDrawUseBox(playerid, AppleTD[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, AppleTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, AppleTD[playerid][4], 1);
	PlayerTextDrawSetPreviewModel(playerid, AppleTD[playerid][4], 19575);
	PlayerTextDrawSetPreviewRot(playerid, AppleTD[playerid][4], -3.000000, -13.000000, -19.000000, 0.569999);
	PlayerTextDrawSetPreviewVehCol(playerid, AppleTD[playerid][4], 1, 1);

	AppleTD[playerid][5] = CreatePlayerTextDraw(playerid, 364.000000, 223.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, AppleTD[playerid][5], 5);
	PlayerTextDrawLetterSize(playerid, AppleTD[playerid][5], 0.1200000, 2.000000);
	PlayerTextDrawTextSize(playerid, AppleTD[playerid][5], 30.500000, 37.000000);
	PlayerTextDrawSetOutline(playerid, AppleTD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, AppleTD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, AppleTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, AppleTD[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, AppleTD[playerid][5], 0);
	PlayerTextDrawBoxColor(playerid, AppleTD[playerid][5], 255);
	PlayerTextDrawUseBox(playerid, AppleTD[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, AppleTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, AppleTD[playerid][5], 1);
	PlayerTextDrawSetPreviewModel(playerid, AppleTD[playerid][5], 19575);
	PlayerTextDrawSetPreviewRot(playerid, AppleTD[playerid][5], 8.000000, -310.000000, -17.000000, 0.569999);
	PlayerTextDrawSetPreviewVehCol(playerid, AppleTD[playerid][5], 1, 1);

	AppleTD[playerid][6] = CreatePlayerTextDraw(playerid, 286.000000, 261.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, AppleTD[playerid][6], 5);
	PlayerTextDrawLetterSize(playerid, AppleTD[playerid][6], 0.1200000, 2.000000);
	PlayerTextDrawTextSize(playerid, AppleTD[playerid][6], 30.500000, 37.000000);
	PlayerTextDrawSetOutline(playerid, AppleTD[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, AppleTD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, AppleTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, AppleTD[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, AppleTD[playerid][6], 0);
	PlayerTextDrawBoxColor(playerid, AppleTD[playerid][6], 255);
	PlayerTextDrawUseBox(playerid, AppleTD[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, AppleTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, AppleTD[playerid][6], 1);
	PlayerTextDrawSetPreviewModel(playerid, AppleTD[playerid][6], 19575);
	PlayerTextDrawSetPreviewRot(playerid, AppleTD[playerid][6], -3.000000, -8.000000, -44.000000, 0.569999);
	PlayerTextDrawSetPreviewVehCol(playerid, AppleTD[playerid][6], 1, 1);

	AppleTD[playerid][7] = CreatePlayerTextDraw(playerid, 335.000000, 185.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, AppleTD[playerid][7], 5);
	PlayerTextDrawLetterSize(playerid, AppleTD[playerid][7], 0.1200000, 2.000000);
	PlayerTextDrawTextSize(playerid, AppleTD[playerid][7], 30.500000, 37.000000);
	PlayerTextDrawSetOutline(playerid, AppleTD[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, AppleTD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, AppleTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, AppleTD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, AppleTD[playerid][7], 0);
	PlayerTextDrawBoxColor(playerid, AppleTD[playerid][7], 255);
	PlayerTextDrawUseBox(playerid, AppleTD[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, AppleTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, AppleTD[playerid][7], 1);
	PlayerTextDrawSetPreviewModel(playerid, AppleTD[playerid][7], 19575);
	PlayerTextDrawSetPreviewRot(playerid, AppleTD[playerid][7], -3.000000, 12.000000, -44.000000, 0.569999);
	PlayerTextDrawSetPreviewVehCol(playerid, AppleTD[playerid][7], 1, 1);

	return 1;
}


hook OnGameModeInit()
{


	AppleTree[0] = CreateObject(738, 1924.09399, 191.48891, 33.57288,   0.00000, 0.00000, 0.00000);
	AppleTree[1] = CreateObject(738, 1922.74976, 213.74419, 29.25802,   0.00000, 0.00000, 0.00000);
	AppleTree[2] = CreateObject(738, 1926.17065, 233.71918, 27.48827,   0.00000, 0.00000, 0.00000);
	AppleTree[3] = CreateObject(738, 1952.55615, 188.13092, 32.49285,   0.00000, 0.00000, 0.00000);
	AppleTree[4] = CreateObject(738, 1951.27002, 205.54216, 29.63443,   0.00000, 0.00000, 0.00000);
	AppleTree[5] = CreateObject(738, 1996.26990, 196.75771, 27.60935,   0.00000, 0.00000, 0.00000);
	AppleTree[6] = CreateObject(738, 1981.70752, 204.76456, 27.15454,   0.00000, 0.00000, 0.00000);
	AppleTree[7] = CreateObject(738, 1979.83899, 179.56618, 30.95563,   0.00000, 0.00000, 0.00000);
	AppleTree[8] = CreateObject(738, 1956.73987, 229.93518, 26.77423,   0.00000, 0.00000, 0.00000);
	AppleTree[9] = CreateObject(738, 1984.16614, 226.51051, 26.26033,   0.00000, 0.00000, 0.00000);
	AppleTree[10] = CreateObject(738, 1937.73413, 190.33707, 32.79413,   0.00000, 0.00000, 0.00000);
	AppleTree[11] = CreateObject(738, 1936.22498, 213.01848, 28.89385,   0.00000, 0.00000, 0.00000);
	AppleTree[12] = CreateObject(738, 1942.07288, 231.18518, 27.44800,   0.00000, 0.00000, 0.00000);
	AppleTree[13] = CreateObject(738, 1963.96643, 185.76439, 31.65624,   0.00000, 0.00000, 0.00000);
	AppleTree[14] = CreateObject(738, 1968.64014, 200.22205, 29.26549,   0.00000, 0.00000, 0.00000);
	AppleTree[15] = CreateObject(738, 1969.43213, 223.68236, 26.64323,   0.00000, 0.00000, 0.00000);
	AppleTree[16] = CreateObject(738, 1997.39087, 221.68739, 25.72759,   0.00000, 0.00000, 0.00000);
	AppleTree[17] = CreateObject(738, 1995.72021, 179.68372, 29.07294,   0.00000, 0.00000, 0.00000);

    CreateActor(158,1945.6511,162.9492,37.2219,341.2965); 
    CreateDynamic3DTextLabel("John_Well\n{AAAAAA}กด 'Y' เพื่อเริ่มงาน", COLOR_WHITE, 1945.6511,162.9492,37.2219+1.1, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

    CreateDynamicPickup(1239, 23, 1938.4344,165.4737,37.2813); //แพ็ค
	CreateDynamic3DTextLabel("[Apple Process]{AAAAAA}\nกด 'Y' เพื่อแปรรูปแอปเปิ้ล", COLOR_ORANGE, 1938.4344,165.4737,37.2813, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

    return 1;
}
Dialog:Start_AppleJob(playerid, response, listitem, inputtext[])
{
	if (response)
	{   
		playerData[playerid][pJobs] = 1;
		StartApple[playerid] = false;
		StartCrate[playerid] = false;
		GetApple[playerid] = 0;

        SendClientMessage(playerid, COLOR_YELLOW, "[Apple]: คุณได้เริ่มงาน Apple เรียบร้อย");
        SendClientMessage(playerid, COLOR_YELLOW, "[Apple]: หยิบ 'Crate' ออกมาจากกระเป๋า, กด 'ต่อย' ที่ต้นแอปเปิดเพื่อเริ่มเก็บ");
        SendClientMessage(playerid, COLOR_LIGHTRED, "(( หากคุณ 'ออกเกม' หรือ 'หลุดเกม' งานที่คุณทำอยู่จะถูกยกเลิก, และคุณต้องกลับไปเริ่มใหม่ ))");
        PlayerPlaySound(playerid, 31200, 0.0, 0.0, 0.0);
        DisablePlayerCheckpoint(playerid);
	}
	return 1;
}
Dialog:Stop_AppleJob(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		playerData[playerid][pJobs] = 0;
		StartApple[playerid] = false;
		StartCrate[playerid] = false;
		GetApple[playerid] = 0;
        PlayerPlaySound(playerid, 31200, 0.0, 0.0, 0.0);
        DisablePlayerCheckpoint(playerid);
        SendClientMessage(playerid, COLOR_YELLOW, "- คุณได้หยุดทำงานปัจจุบันที่คุณกำลังทำอยู่เรียบร้อย");
	}
	return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
        if (IsPlayerInRangeOfPoint(playerid, 2.0, 1945.6511,162.9492,37.2219)) //สมัครงาน
        {
            if(playerData[playerid][pJobs] == 0)
                return Dialog_Show(playerid, Start_AppleJob, DIALOG_STYLE_MSGBOX, "John_Well", "{FFFFFF}Job: Apple\n\
                คุณต้องการเริ่มงานในตอนนี้เลยหรือไม่?", "เริ่มงาน", "ยกเลิก");

            if(playerData[playerid][pJobs] != 0)
                return Dialog_Show(playerid, Stop_AppleJob, DIALOG_STYLE_MSGBOX, "John_Well", "{FFFFFF}Job: Apple\n\
				{FF6347}คุณต้องการหยุดงานที่คุณกำลังทำอยู่เลยหรือไม์?", "หยุดงาน", "ยกเลิก");
        }
        if (IsPlayerInRangeOfPoint(playerid, 2.0, 1938.4344,165.4737,37.2813)) //แพ็ค
        {
            if(StartCrate[playerid] == true)
			{
				SendClientMessage(playerid, COLOR_YELLOW, "[Apple]: คุณกำลังแพ็คแอปเปิ้ล โปรดอย่าขยับออกจากจุดแพ็ค");
				PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
				StartProgress(playerid, 100, 0, 0);
				RemovePlayerAttachedObject(playerid, 9);
				ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);
				return 1;
			}
        }
	}
	if (newkeys & KEY_FIRE && !IsPlayerInAnyVehicle(playerid)) //เก็บแอปเปิ้ล
    {
        if(U_CheckPlayerNearObject(playerid, AppleTree[0], 5.0) 
		|| U_CheckPlayerNearObject(playerid, AppleTree[1], 5.0)
		|| U_CheckPlayerNearObject(playerid, AppleTree[2], 5.0)
		|| U_CheckPlayerNearObject(playerid, AppleTree[3], 5.0)
		|| U_CheckPlayerNearObject(playerid, AppleTree[4], 5.0)
		|| U_CheckPlayerNearObject(playerid, AppleTree[5], 5.0)
		|| U_CheckPlayerNearObject(playerid, AppleTree[6], 5.0)
		|| U_CheckPlayerNearObject(playerid, AppleTree[7], 5.0)
		|| U_CheckPlayerNearObject(playerid, AppleTree[8], 5.0)
		|| U_CheckPlayerNearObject(playerid, AppleTree[9], 5.0)
		|| U_CheckPlayerNearObject(playerid, AppleTree[10], 5.0)
		|| U_CheckPlayerNearObject(playerid, AppleTree[11], 5.0)
		|| U_CheckPlayerNearObject(playerid, AppleTree[12], 5.0)
		|| U_CheckPlayerNearObject(playerid, AppleTree[13], 5.0)
		|| U_CheckPlayerNearObject(playerid, AppleTree[14], 5.0)
		|| U_CheckPlayerNearObject(playerid, AppleTree[15], 5.0)
		|| U_CheckPlayerNearObject(playerid, AppleTree[16], 5.0)
		|| U_CheckPlayerNearObject(playerid, AppleTree[17], 5.0))
        { 
			if(playerData[playerid][pJobs] == 1 && playerData[playerid][pEquipmentJob] == 4)
			{
				if(StartApple[playerid] == true)
					return 1;

				new id = randomEx(0, 7);
				PlayerTextDrawShow(playerid, AppleTD[playerid][id]);
				SelectTextDraw(playerid, 0xFFFFFFFF);
				PlayerPlaySound(playerid, 6801, 0.0, 0.0, 0.0);
				ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
				return 1;
			}
        }
    }
    return 1;
}
hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	for (new i; i < 8; i++)
	{
		if(playertextid == AppleTD[playerid][i])
		{
			if(GetApple[playerid] >= 12)
			{
				StartApple[playerid] = true;
				CheckPlayerNearAppleTree(playerid);
				PlayerPlaySound(playerid, 4604, 0.0, 0.0, 0.0);
				StartProgress(playerid, 100, 0, 0);

				GetApple[playerid] = 0;
				PlayerTextDrawHide(playerid, AppleTD[playerid][i]);
				for(new ix = 0; ix < sizeof AppleTree; ix++) {U_DestroyObjectNearPlayer(playerid,AppleTree[ix], 5.0);}

				CancelSelectTextDraw(playerid);
				RemovePlayerAttachedObject(playerid, 9);
				ClearAnimations(playerid);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
				return 1;
			}
			PlayerPlaySound(playerid, 6801, 0.0, 0.0, 0.0);
			PlayerTextDrawHide(playerid, AppleTD[playerid][i]);
			new id = randomEx(0, 7);
			PlayerTextDrawShow(playerid, AppleTD[playerid][id]);
			GetApple[playerid] ++;
			ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
			return 1;
		}
	}
	return 1;
}
stock CheckPlayerNearAppleTree(playerid)
{
    if(U_CheckPlayerNearObject(playerid, AppleTree[0], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",0);
    if(U_CheckPlayerNearObject(playerid, AppleTree[1], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",1);
    if(U_CheckPlayerNearObject(playerid, AppleTree[2], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",2);
    if(U_CheckPlayerNearObject(playerid, AppleTree[3], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",3);
    if(U_CheckPlayerNearObject(playerid, AppleTree[4], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",4);
    if(U_CheckPlayerNearObject(playerid, AppleTree[5], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",5);
    if(U_CheckPlayerNearObject(playerid, AppleTree[6], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",6);
    if(U_CheckPlayerNearObject(playerid, AppleTree[7], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",7);
    if(U_CheckPlayerNearObject(playerid, AppleTree[8], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",8);
    if(U_CheckPlayerNearObject(playerid, AppleTree[9], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",9);
    if(U_CheckPlayerNearObject(playerid, AppleTree[10], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",10);
    if(U_CheckPlayerNearObject(playerid, AppleTree[11], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",11);
    if(U_CheckPlayerNearObject(playerid, AppleTree[12], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",12);
    if(U_CheckPlayerNearObject(playerid, AppleTree[13], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",13);
    if(U_CheckPlayerNearObject(playerid, AppleTree[14], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",14);
    if(U_CheckPlayerNearObject(playerid, AppleTree[15], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",15);
    if(U_CheckPlayerNearObject(playerid, AppleTree[16], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",16);
    if(U_CheckPlayerNearObject(playerid, AppleTree[17], 2.0)) SetTimerEx("CreateApple", 60000, false, "d",17);
    return 1;
}
forward CreateApple(i);
public  CreateApple(i)
{
    switch(i)
    {
		case 0: AppleTree[0] = CreateObject(738, 1924.09399, 191.48891, 33.57288,   0.00000, 0.00000, 0.00000);		
		case 1: AppleTree[1] = CreateObject(738, 1922.74976, 213.74419, 29.25802,   0.00000, 0.00000, 0.00000);
		case 2: AppleTree[2] = CreateObject(738, 1926.17065, 233.71918, 27.48827,   0.00000, 0.00000, 0.00000);
		case 3: AppleTree[3] = CreateObject(738, 1952.55615, 188.13092, 32.49285,   0.00000, 0.00000, 0.00000);
		case 4: AppleTree[4] = CreateObject(738, 1951.27002, 205.54216, 29.63443,   0.00000, 0.00000, 0.00000);
		case 5: AppleTree[5] = CreateObject(738, 1996.26990, 196.75771, 27.60935,   0.00000, 0.00000, 0.00000);
		case 6: AppleTree[6] = CreateObject(738, 1981.70752, 204.76456, 27.15454,   0.00000, 0.00000, 0.00000);
		case 7: AppleTree[7] = CreateObject(738, 1979.83899, 179.56618, 30.95563,   0.00000, 0.00000, 0.00000);
		case 8: AppleTree[8] = CreateObject(738, 1956.73987, 229.93518, 26.77423,   0.00000, 0.00000, 0.00000);
		case 9: AppleTree[9] = CreateObject(738, 1984.16614, 226.51051, 26.26033,   0.00000, 0.00000, 0.00000);
		case 10: AppleTree[10] = CreateObject(738, 1937.73413, 190.33707, 32.79413,   0.00000, 0.00000, 0.00000);
		case 11: AppleTree[11] = CreateObject(738, 1936.22498, 213.01848, 28.89385,   0.00000, 0.00000, 0.00000);
		case 12: AppleTree[12] = CreateObject(738, 1942.07288, 231.18518, 27.44800,   0.00000, 0.00000, 0.00000);
		case 13: AppleTree[13] = CreateObject(738, 1963.96643, 185.76439, 31.65624,   0.00000, 0.00000, 0.00000);
		case 14: AppleTree[14] = CreateObject(738, 1968.64014, 200.22205, 29.26549,   0.00000, 0.00000, 0.00000);
		case 15: AppleTree[15] = CreateObject(738, 1969.43213, 223.68236, 26.64323,   0.00000, 0.00000, 0.00000);
		case 16: AppleTree[16] = CreateObject(738, 1997.39087, 221.68739, 25.72759,   0.00000, 0.00000, 0.00000);
		case 17: AppleTree[17] = CreateObject(738, 1995.72021, 179.68372, 29.07294,   0.00000, 0.00000, 0.00000);

    }
    return 1;
}


hook OnProgressUpdate(playerid, progress, objectid)
{
    if(StartApple[playerid] == true){
        ApplyAnimation(playerid,"bomber", "bom_plant_loop",4.1, 1, 0, 1, 0, 0);
        return Y_HOOKS_BREAK_RETURN_1;
    }
    if(StartCrate[playerid] == true){
        ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);
        return Y_HOOKS_BREAK_RETURN_1;
    }
	return Y_HOOKS_CONTINUE_RETURN_0;
}
hook OnProgressFinish(playerid)
{
	if(StartApple[playerid] == true)
		return AppleCrateGet(playerid);

	if(StartCrate[playerid] == true)
		return GetApplePack(playerid);

	return Y_HOOKS_CONTINUE_RETURN_0;
}
hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if (StartApple[playerid] == true || StartCrate[playerid] == true || playerData[playerid][pEquipmentJob] == 4)
	{
	    ClearAnimations(playerid);
		SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณไม่สามารถขึ้นยานพาหนะในขณะถือลังเก็บแอปเปิ้ลได้");
		return 1;
	}
	return 1;
}
AppleCrateGet(playerid)
{
	StartApple[playerid] = false;
	StartCrate[playerid] = true;
	ApplyAnimation(playerid, "CARRY","liftup", 4.1, 0, 0, 0, 0, 0, 1);
	SetPlayerAttachedObject(playerid,9,19636,6,0.065999,0.009999,-0.130999,-106.599990,-5.100001,-13.599996,1.000000,1.000000,1.000000);
	Inventory_Remove(playerid, "Crate", 1);
	playerData[playerid][pEquipmentJob] = 0;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	return 1;
}
GetApplePack(playerid)
{
    new itemname[24];
    itemname = "ApplePack";
    new count = Inventory_Count(playerid, itemname);
    PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);

	StartCrate[playerid] = false;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

    if (count >= playerData[playerid][pItemAmount])
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ไม่สามารถเก็บ '%s' ได้อีกเนื่องจาก จำนวนในกระเป๋าของคุณนั้นเต็มแล้ว!", itemname);

    new id = Inventory_Add(playerid, itemname, 1);

    if (id == -1)
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] ความจุของกระเป๋าของคุณนั้นเต็มแล้ว (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

    SendClientMessageEx(playerid, COLOR_GREEN, "[Lumberjack]: คุณได้รับ '%s' จำนวน 1 จากการแพ็คแอปเปิ้ล", itemname);
	return 1;
}
/*
hook OnPlayerConnect(playerid)
{
    CreateAppleJob(playerid);
    return 1;
}
hook OnPlayerDisconnect(playerid)
{
    DestroyAppleJob(playerid);
    return 1;
}
task JobAppleTimer[120000*60]()
{
	for(new i=0; i<sizeof(FruitApple); i++)
	{
		FruitApple[i] = 25;
		UpdateAppleText(i);
    }
    return 1;
}

PlayerAppleGet(playerid)
{
	HideMenuAppleTD(playerid);
   	ApplyAnimation(playerid, "CARRY","liftup", 4.1, 0, 0, 0, 0, 0, 1);
   	ApplyAnimation(playerid, "CARRY","null", 4.1, 0, 0, 0, 0, 0, 1);
	ApplyAnimation(playerid, "CARRY","liftup", 4.1, 0, 0, 0, 0, 0, 1);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	SetPlayerAttachedObject(playerid,0,19636,6,0.025000,-0.052999,-0.175000,-107.100006,-10.999997,-10.099999,0.584999,0.664000,1.000000);
    
	
	appleKA[playerid] = 1;
	applePull[playerid] = 0;
    TogglePlayerControllable(playerid, 1);
}
PlayerApplefreeze(playerid)
{
	applePut[playerid] = 0;
	ClearAnimations(playerid);
	GivePlayerExp(playerid, 25);
    Inventory_Add(playerid, "PackApple", 1);
    TogglePlayerControllable(playerid, 1);
	Apple[playerid] = 0;
	return 1;
}
hook OnProgressFinish(playerid)
{

	if(applePull[playerid] == 1)
		PlayerAppleGet(playerid);

	if(applePut[playerid] == 1)
		PlayerApplefreeze(playerid);
	return Y_HOOKS_CONTINUE_RETURN_0;
}
hook OnProgressUpdate(playerid, progress)
{
	if(applePull[playerid] == 1)
	{
		ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_LOOP", 4.0, 1, 0, 0, 0, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}
	if(applePut[playerid] == 1)
	{
		ApplyAnimation(playerid, "INT_SHOP", "shop_cashier", 4.0, 1, 0, 0, 0, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_0;
}

ptask JobAppleTimerSecond[1000](playerid)
{
	for(new i=0; i<sizeof(FruitApple); i++)
	{
		//FruitApple[i] += 6;

		if(FruitApple[i] > 25)
		{
		    FruitApple[i] = 25;
		}

		if(FruitApple[i] < 0)
		{
		    FruitApple[i] = 0;
		}
		UpdateAppleText(i);
    }
    return 1;
}
stock UpdateAppleText(id)
{
	switch(id)
	{
	    case 0:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Apple]{FFA84D}\nเหลือ: [%d]\n{FFFFFF}กด {FFFF00}Y{FFFFFF} เพื่อเก็บแอปเปิ้ล", FruitApple[0]);
		  	UpdateDynamic3DTextLabelText(AppleText[0], COLOR_GREEN, szQueryOutput);
	  	}
	    case 1:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Apple]{FFA84D}\nเหลือ: [%d]\n{FFFFFF}กด {FFFF00}Y{FFFFFF} เพื่อเก็บแอปเปิ้ล", FruitApple[1]);
		  	UpdateDynamic3DTextLabelText(AppleText[1], COLOR_GREEN, szQueryOutput);
	  	}
	    case 2:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Apple]{FFA84D}\nเหลือ: [%d]\n{FFFFFF}กด {FFFF00}Y{FFFFFF} เพื่อเก็บแอปเปิ้ล", FruitApple[2]);
		  	UpdateDynamic3DTextLabelText(AppleText[2], COLOR_GREEN, szQueryOutput);
	  	}
	    case 3:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Apple]{FFA84D}\nเหลือ: [%d]\n{FFFFFF}กด {FFFF00}Y{FFFFFF} เพื่อเก็บแอปเปิ้ล", FruitApple[3]);
		  	UpdateDynamic3DTextLabelText(AppleText[3], COLOR_GREEN, szQueryOutput);
	  	}
	    case 4:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Apple]{FFA84D}\nเหลือ: [%d]\n{FFFFFF}กด {FFFF00}Y{FFFFFF} เพื่อเก็บแอปเปิ้ล", FruitApple[4]);
		  	UpdateDynamic3DTextLabelText(AppleText[4], COLOR_GREEN, szQueryOutput);
	  	}
	    case 5:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Apple]{FFA84D}\nเหลือ: [%d]\n{FFFFFF}กด {FFFF00}Y{FFFFFF} เพื่อเก็บแอปเปิ้ล", FruitApple[5]);
		  	UpdateDynamic3DTextLabelText(AppleText[5], COLOR_GREEN, szQueryOutput);
	  	}
	    case 6:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Apple]{FFA84D}\nเหลือ: [%d]\n{FFFFFF}กด {FFFF00}Y{FFFFFF} เพื่อเก็บแอปเปิ้ล", FruitApple[6]);
		  	UpdateDynamic3DTextLabelText(AppleText[6], COLOR_GREEN, szQueryOutput);
	  	}
	    case 7:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Apple]{FFA84D}\nเหลือ: [%d]\n{FFFFFF}กด {FFFF00}Y{FFFFFF} เพื่อเก็บแอปเปิ้ล", FruitApple[7]);
		  	UpdateDynamic3DTextLabelText(AppleText[7], COLOR_GREEN, szQueryOutput);
	  	}
	    case 8:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Apple]{FFA84D}\nเหลือ: [%d]\n{FFFFFF}กด {FFFF00}Y{FFFFFF} เพื่อเก็บแอปเปิ้ล", FruitApple[8]);
		  	UpdateDynamic3DTextLabelText(AppleText[8], COLOR_GREEN, szQueryOutput);
	  	}
	    case 9:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Apple]{FFA84D}\nเหลือ: [%d]\n{FFFFFF}กด {FFFF00}Y{FFFFFF} เพื่อเก็บแอปเปิ้ล", FruitApple[9]);
		  	UpdateDynamic3DTextLabelText(AppleText[9], COLOR_GREEN, szQueryOutput);
	  	}
	    case 10:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Apple]{FFA84D}\nเหลือ: [%d]\n{FFFFFF}กด {FFFF00}Y{FFFFFF} เพื่อเก็บแอปเปิ้ล", FruitApple[10]);
		  	UpdateDynamic3DTextLabelText(AppleText[10], COLOR_GREEN, szQueryOutput);
	  	}
	    case 11:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Apple]{FFA84D}\nเหลือ: [%d]\n{FFFFFF}กด {FFFF00}Y{FFFFFF} เพื่อเก็บแอปเปิ้ล", FruitApple[11]);
		  	UpdateDynamic3DTextLabelText(AppleText[11], COLOR_GREEN, szQueryOutput);
	  	}
	    case 12:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Apple]{FFA84D}\nเหลือ: [%d]\n{FFFFFF}กด {FFFF00}Y{FFFFFF} เพื่อเก็บแอปเปิ้ล", FruitApple[12]);
		  	UpdateDynamic3DTextLabelText(AppleText[12], COLOR_GREEN, szQueryOutput);
	  	}
	    case 13:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Apple]{FFA84D}\nเหลือ: [%d]\n{FFFFFF}กด {FFFF00}Y{FFFFFF} เพื่อเก็บแอปเปิ้ล", FruitApple[13]);
		  	UpdateDynamic3DTextLabelText(AppleText[13], COLOR_GREEN, szQueryOutput);
	  	}
	    case 14:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Apple]{FFA84D}\nเหลือ: [%d]\n{FFFFFF}กด {FFFF00}Y{FFFFFF} เพื่อเก็บแอปเปิ้ล", FruitApple[14]);
		  	UpdateDynamic3DTextLabelText(AppleText[14], COLOR_GREEN, szQueryOutput);
	  	}
  	}
	return 1;
} 

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if (playertextid == AppleTD[playerid][0])
    {
		PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
		PlayerTextDrawHide(playerid, AppleTD[playerid][0]);
        Apple[playerid] += 1;
        if(Apple[playerid] == 8)
        {
			appleTake[playerid] = 0;
			applePull[playerid] = 1;
			HideMenuAppleTD(playerid);
            ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_LOOP", 4.0, 1, 0, 0, 0, 0, 1);
            StartProgress(playerid, 150, 0, 0);
            TogglePlayerControllable( playerid, 0);
        }
    }
	if (playertextid == AppleTD[playerid][1])
    {
		PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
		PlayerTextDrawHide(playerid, AppleTD[playerid][1]);
        Apple[playerid] += 1;
        if(Apple[playerid] == 8)
        {
			appleTake[playerid] = 0;
			applePull[playerid] = 1;
			HideMenuAppleTD(playerid);			
            ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_LOOP", 4.0, 1, 0, 0, 0, 0, 1);
            StartProgress(playerid, 150, 0, 0);
            TogglePlayerControllable( playerid, 0);
        }
    }
	if (playertextid == AppleTD[playerid][2])
    {
		PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
		PlayerTextDrawHide(playerid, AppleTD[playerid][2]);
        Apple[playerid] += 1;
        if(Apple[playerid] == 8)
        {
			appleTake[playerid] = 0;
			applePull[playerid] = 1;
			HideMenuAppleTD(playerid);
            ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_LOOP", 4.0, 1, 0, 0, 0, 0, 1);
            StartProgress(playerid, 150, 0, 0);
            TogglePlayerControllable( playerid, 0);
        }
    }
	if (playertextid == AppleTD[playerid][3])
    {
		PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
		PlayerTextDrawHide(playerid, AppleTD[playerid][3]);
        Apple[playerid] += 1;
        if(Apple[playerid] == 8)
        {
			appleTake[playerid] = 0;
			applePull[playerid] = 1;
			HideMenuAppleTD(playerid);
            ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_LOOP", 4.0, 1, 0, 0, 0, 0, 1);
            StartProgress(playerid, 150, 0, 0);
            TogglePlayerControllable( playerid, 0);
        }
    }
	if (playertextid == AppleTD[playerid][4])
    {
		PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
		PlayerTextDrawHide(playerid, AppleTD[playerid][4]);
        Apple[playerid] += 1;
        if(Apple[playerid] == 8)
        {
			appleTake[playerid] = 0;
			applePull[playerid] = 1;
			HideMenuAppleTD(playerid);
            ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_LOOP", 4.0, 1, 0, 0, 0, 0, 1);
            StartProgress(playerid, 150, 0, 0);
            TogglePlayerControllable( playerid, 0);
        }
    }
	if (playertextid == AppleTD[playerid][5])
    {
		PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
		PlayerTextDrawHide(playerid, AppleTD[playerid][5]);
        Apple[playerid] += 1;
        if(Apple[playerid] == 8)
        {
			appleTake[playerid] = 0;
			applePull[playerid] = 1;
			HideMenuAppleTD(playerid);
            ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_LOOP", 4.0, 1, 0, 0, 0, 0, 1);
            StartProgress(playerid, 150, 0, 0);
            TogglePlayerControllable( playerid, 0);
        }
    }
	if (playertextid == AppleTD[playerid][6])
    {
		PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
		PlayerTextDrawHide(playerid, AppleTD[playerid][6]);
        Apple[playerid] += 1;
        if(Apple[playerid] == 8)
        {
			appleTake[playerid] = 0;
			applePull[playerid] = 1;
			HideMenuAppleTD(playerid);
            ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_LOOP", 4.0, 1, 0, 0, 0, 0, 1);
            StartProgress(playerid, 150, 0, 0);
            TogglePlayerControllable( playerid, 0);
        }
    }
	if (playertextid == AppleTD[playerid][7])
    {
		PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
		PlayerTextDrawHide(playerid, AppleTD[playerid][7]);
        Apple[playerid] += 1;
        if(Apple[playerid] == 8)
        {
			appleTake[playerid] = 0;
			applePull[playerid] = 1;
			HideMenuAppleTD(playerid);
            ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_LOOP", 4.0, 1, 0, 0, 0, 0, 1);
            StartProgress(playerid, 150, 0, 0);
            TogglePlayerControllable( playerid, 0);
        }
    }
    return 1;
}



DestroyAppleJob(playerid)
{
	PlayerTextDrawDestroy(playerid, AppleTD[playerid][0]);
	PlayerTextDrawDestroy(playerid, AppleTD[playerid][0]);
	PlayerTextDrawDestroy(playerid, AppleTD[playerid][1]);
	PlayerTextDrawDestroy(playerid, AppleTD[playerid][2]);
	PlayerTextDrawDestroy(playerid, AppleTD[playerid][3]);
	PlayerTextDrawDestroy(playerid, AppleTD[playerid][4]);
	PlayerTextDrawDestroy(playerid, AppleTD[playerid][5]);
	PlayerTextDrawDestroy(playerid, AppleTD[playerid][6]);
	PlayerTextDrawDestroy(playerid, AppleTD[playerid][7]);

    return 1;
}
stock ShowMenuAppleTD(playerid)
{
	PlayerTextDrawShow(playerid, AppleTD[playerid][0]);
	PlayerTextDrawShow(playerid, AppleTD[playerid][0]);
	PlayerTextDrawShow(playerid, AppleTD[playerid][1]);
	PlayerTextDrawShow(playerid, AppleTD[playerid][2]);
	PlayerTextDrawShow(playerid, AppleTD[playerid][3]);
	PlayerTextDrawShow(playerid, AppleTD[playerid][4]);
	PlayerTextDrawShow(playerid, AppleTD[playerid][5]);
	PlayerTextDrawShow(playerid, AppleTD[playerid][6]);
	PlayerTextDrawShow(playerid, AppleTD[playerid][7]);

    SelectTextDraw(playerid, 0xFF0000FF);
    return 1;
}
stock HideMenuAppleTD(playerid)
{
	PlayerTextDrawHide(playerid, AppleTD[playerid][0]);
	PlayerTextDrawHide(playerid, AppleTD[playerid][0]);
	PlayerTextDrawHide(playerid, AppleTD[playerid][1]);
	PlayerTextDrawHide(playerid, AppleTD[playerid][2]);
	PlayerTextDrawHide(playerid, AppleTD[playerid][3]);
	PlayerTextDrawHide(playerid, AppleTD[playerid][4]);
	PlayerTextDrawHide(playerid, AppleTD[playerid][5]);
	PlayerTextDrawHide(playerid, AppleTD[playerid][6]);
	PlayerTextDrawHide(playerid, AppleTD[playerid][7]);

    CancelSelectTextDraw(playerid);
    return 1;
}*/