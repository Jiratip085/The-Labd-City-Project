#include	<YSI_Coding\y_hooks>
new PlayerText:PhoneTD[MAX_PLAYERS][16];
new PlayerText:Phone_MenuTD[MAX_PLAYERS][3];

hook OnPlayerConnect(playerid)
{
	PhoneTD[playerid][0] = CreatePlayerTextDraw(playerid, 516.000000, 317.000000, "_");
	PlayerTextDrawFont(playerid, PhoneTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][0], 0.600000, 18.550010);
	PlayerTextDrawTextSize(playerid, PhoneTD[playerid][0], 298.500000, 105.000000);
	PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, PhoneTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, PhoneTD[playerid][0], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][0], 269619711);
	PlayerTextDrawUseBox(playerid, PhoneTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][0], 0);

	PhoneTD[playerid][1] = CreatePlayerTextDraw(playerid, 461.199707, 314.288909, "ld_spac:tvcorn");
	PlayerTextDrawFont(playerid, PhoneTD[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PhoneTD[playerid][1], 55.000000, 135.000000);
	PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, PhoneTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, PhoneTD[playerid][1], -858993409);
	PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, PhoneTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][1], 0);

	PhoneTD[playerid][2] = CreatePlayerTextDraw(playerid, 571.199707, 314.288909, "ld_spac:tvcorn");
	PlayerTextDrawFont(playerid, PhoneTD[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PhoneTD[playerid][2], -55.000000, 135.000000);
	PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, PhoneTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, PhoneTD[playerid][2], -858993409);
	PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, PhoneTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][2], 0);

	PhoneTD[playerid][3] = CreatePlayerTextDraw(playerid, 471.667358, 407.762969, "ld_dual:white");
	PlayerTextDrawFont(playerid, PhoneTD[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PhoneTD[playerid][3], 22.333290, 7.881502);
	PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, PhoneTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, PhoneTD[playerid][3], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][3], -572662273);
	PlayerTextDrawUseBox(playerid, PhoneTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][3], 1);

	PhoneTD[playerid][4] = CreatePlayerTextDraw(playerid, 516.075012, 333.377868, "LS Telefonica");
	PlayerTextDrawFont(playerid, PhoneTD[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][4], 0.250000, 1.000000);
	PlayerTextDrawTextSize(playerid, PhoneTD[playerid][4], 0.000000, 2016.000000);
	PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, PhoneTD[playerid][4], 2);
	PlayerTextDrawColor(playerid, PhoneTD[playerid][4], -522133249);
	PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][4], 200);
	PlayerTextDrawUseBox(playerid, PhoneTD[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][4], 1);

	PhoneTD[playerid][5] = CreatePlayerTextDraw(playerid, 516.000000, 350.944366, "_");
	PlayerTextDrawFont(playerid, PhoneTD[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][5], 0.600000, 5.982919);
	PlayerTextDrawTextSize(playerid, PhoneTD[playerid][5], 0.000000, 83.500000);
	PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, PhoneTD[playerid][5], 2);
	PlayerTextDrawColor(playerid, PhoneTD[playerid][5], -16776961);
	PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][5], -572662273);
	PlayerTextDrawUseBox(playerid, PhoneTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][5], 0);

	PhoneTD[playerid][6] = CreatePlayerTextDraw(playerid, 538.250000, 407.762969, "ld_dual:white");
	PlayerTextDrawFont(playerid, PhoneTD[playerid][6], 4);
	PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][6], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PhoneTD[playerid][6], 22.333290, 7.881502);
	PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, PhoneTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, PhoneTD[playerid][6], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][6], -572662273);
	PlayerTextDrawUseBox(playerid, PhoneTD[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][6], 1);

	PhoneTD[playerid][7] = CreatePlayerTextDraw(playerid, 545.667358, 320.822174, "ld_beat:circle");
	PlayerTextDrawFont(playerid, PhoneTD[playerid][7], 4);
	PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][7], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PhoneTD[playerid][7], 15.999990, 15.762948);
	PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, PhoneTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, PhoneTD[playerid][7], -1061109505);
	PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, PhoneTD[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][7], 1);

	PhoneTD[playerid][8] = CreatePlayerTextDraw(playerid, 510.250000, 412.000000, "ld_beat:up");
	PlayerTextDrawFont(playerid, PhoneTD[playerid][8], 4);
	PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][8], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PhoneTD[playerid][8], 12.333327, 12.029634);
	PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, PhoneTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, PhoneTD[playerid][8], -1061109505);
	PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, PhoneTD[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][8], 1);

	PhoneTD[playerid][9] = CreatePlayerTextDraw(playerid, 521.799987, 422.822174, "ld_beat:right");
	PlayerTextDrawFont(playerid, PhoneTD[playerid][9], 4);
	PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][9], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PhoneTD[playerid][9], 12.333327, 12.029634);
	PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, PhoneTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, PhoneTD[playerid][9], -1061109505);
	PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, PhoneTD[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][9], 1);

	PhoneTD[playerid][10] = CreatePlayerTextDraw(playerid, 499.000000, 422.822174, "ld_beat:left");
	PlayerTextDrawFont(playerid, PhoneTD[playerid][10], 4);
	PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][10], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PhoneTD[playerid][10], 12.333327, 12.029634);
	PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, PhoneTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, PhoneTD[playerid][10], -1061109505);
	PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][10], 50);
	PlayerTextDrawUseBox(playerid, PhoneTD[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][10], 1);

	PhoneTD[playerid][11] = CreatePlayerTextDraw(playerid, 510.250000, 435.000000, "ld_beat:down");
	PlayerTextDrawFont(playerid, PhoneTD[playerid][11], 4);
	PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][11], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PhoneTD[playerid][11], 12.333327, 12.029634);
	PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, PhoneTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, PhoneTD[playerid][11], -1061109505);
	PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][11], 50);
	PlayerTextDrawUseBox(playerid, PhoneTD[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][11], 1);

	PhoneTD[playerid][12] = CreatePlayerTextDraw(playerid, 515.075012, 369.000000, "11/04/2026");
	PlayerTextDrawFont(playerid, PhoneTD[playerid][12], 2);
	PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][12], 0.250000, 1.000000);
	PlayerTextDrawTextSize(playerid, PhoneTD[playerid][12], 1.000000, 85.000000);
	PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, PhoneTD[playerid][12], 2);
	PlayerTextDrawColor(playerid, PhoneTD[playerid][12], 488447487);
	PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][12], 200);
	PlayerTextDrawUseBox(playerid, PhoneTD[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][12], 0);

	PhoneTD[playerid][13] = CreatePlayerTextDraw(playerid, 515.075012, 353.000000, "21:05");
	PlayerTextDrawFont(playerid, PhoneTD[playerid][13], 2);
	PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][13], 0.354999, 2.000000);
	PlayerTextDrawTextSize(playerid, PhoneTD[playerid][13], 0.000000, 82.000000);
	PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, PhoneTD[playerid][13], 2);
	PlayerTextDrawColor(playerid, PhoneTD[playerid][13], 488447487);
	PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][13], 200);
	PlayerTextDrawUseBox(playerid, PhoneTD[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][13], 1);

	PhoneTD[playerid][14] = CreatePlayerTextDraw(playerid, 472.075012, 399.000000, "Menu");
	PlayerTextDrawFont(playerid, PhoneTD[playerid][14], 2);
	PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][14], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid, PhoneTD[playerid][14], 531.000000, -204.500000);
	PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, PhoneTD[playerid][14], 1);
	PlayerTextDrawColor(playerid, PhoneTD[playerid][14], 488447487);
	PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][14], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][14], 200);
	PlayerTextDrawUseBox(playerid, PhoneTD[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][14], 0);

	PhoneTD[playerid][15] = CreatePlayerTextDraw(playerid, 558.075012, 399.000000, "Option");
	PlayerTextDrawFont(playerid, PhoneTD[playerid][15], 2);
	PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][15], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid, PhoneTD[playerid][15], 531.000000, -204.500000);
	PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, PhoneTD[playerid][15], 3);
	PlayerTextDrawColor(playerid, PhoneTD[playerid][15], 488447487);
	PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][15], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][15], 200);
	PlayerTextDrawUseBox(playerid, PhoneTD[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][15], 0);
	
	Phone_MenuTD[playerid][0] = CreatePlayerTextDraw(playerid, 476.075012, 370.000000, "Call");
	PlayerTextDrawFont(playerid, Phone_MenuTD[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, Phone_MenuTD[playerid][0], 0.220833, 1.000000);
	PlayerTextDrawTextSize(playerid, Phone_MenuTD[playerid][0], 556.000000, -204.500000);
	PlayerTextDrawSetOutline(playerid, Phone_MenuTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, Phone_MenuTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, Phone_MenuTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, Phone_MenuTD[playerid][0], -1061109505);
	PlayerTextDrawBackgroundColor(playerid, Phone_MenuTD[playerid][0], 200);
	PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
	PlayerTextDrawUseBox(playerid, Phone_MenuTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, Phone_MenuTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, Phone_MenuTD[playerid][0], 1);

	Phone_MenuTD[playerid][1] = CreatePlayerTextDraw(playerid, 476.075012, 385.750000, "Contact");
	PlayerTextDrawFont(playerid, Phone_MenuTD[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, Phone_MenuTD[playerid][1], 0.220833, 1.000000);
	PlayerTextDrawTextSize(playerid, Phone_MenuTD[playerid][1], 556.000000, -204.500000);
	PlayerTextDrawSetOutline(playerid, Phone_MenuTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, Phone_MenuTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, Phone_MenuTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, Phone_MenuTD[playerid][1], -1061109505);
	PlayerTextDrawBackgroundColor(playerid, Phone_MenuTD[playerid][1], 200);
	PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
	PlayerTextDrawUseBox(playerid, Phone_MenuTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, Phone_MenuTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, Phone_MenuTD[playerid][1], 1);

	Phone_MenuTD[playerid][2] = CreatePlayerTextDraw(playerid, 476.075012, 354.000000, "Twitter");
	PlayerTextDrawFont(playerid, Phone_MenuTD[playerid][2], 2);
	PlayerTextDrawLetterSize(playerid, Phone_MenuTD[playerid][2], 0.220833, 1.000000);
	PlayerTextDrawTextSize(playerid, Phone_MenuTD[playerid][2], 556.000000, -204.500000);
	PlayerTextDrawSetOutline(playerid, Phone_MenuTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, Phone_MenuTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, Phone_MenuTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, Phone_MenuTD[playerid][2], -1061109505);
	PlayerTextDrawBackgroundColor(playerid, Phone_MenuTD[playerid][2], 200);
	PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
	PlayerTextDrawUseBox(playerid, Phone_MenuTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, Phone_MenuTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, Phone_MenuTD[playerid][2], 1);
    return 1;
}
/*
alias:phone("โทรศัพ")
CMD:phone(playerid, const params[])
{
	if (!Inventory_HasItem(playerid, "Ifruit"))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณไม่มีมือถือ");

    if (playerData[playerid][pHospital] != -1 || playerData[playerid][pCuffed] || playerData[playerid][pInjured] || !IsPlayerSpawnedEx(playerid))
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่สามารถใช้มือถือได้ในขณะนี้");

	static
	    str[32];

	format(str, sizeof(str), "เบอร์ของคุณ: #%d", playerData[playerid][pPhone]);

	if (playerData[playerid][pPhoneOff])
	{
		Dialog_Show(playerid, DIALOG_MYPHONE, DIALOG_STYLE_LIST, str, "หมายเลขที่ต้องการโทร\nรายชื่อผู้ติดต่อ\nส่งข้อความ\nเปิดเครื่อง", "ตกลง", "ออก");
	}
	else {
	    Dialog_Show(playerid, DIALOG_MYPHONE, DIALOG_STYLE_LIST, str, "หมายเลขที่ต้องการโทร\nรายชื่อผู้ติดต่อ\nส่งข้อความ\nปิดเครื่อง", "ตกลง", "ออก");
	}
	return 1;
}

CMD:phone1(playerid, params[])
{
    ShowPlayerPhone(playerid);
    return 1;
}*/
new ph_page[MAX_PLAYERS];
new ph_select[MAX_PLAYERS];

ShowPlayerPhone(playerid)
{
    new string[128], MapZone:zone = GetPlayerMapZone(playerid), name[MAX_MAP_ZONE_NAME],
		hours, minutes, seconds, year, month, day;
    GetMapZoneName(zone, name);
	getdate(year, month, day);
	gettime(hours, minutes, seconds);

 	format(string, sizeof(string), "%02d:%02d", hours, minutes); //time
	PlayerTextDrawSetString(playerid, PhoneTD[playerid][13], string);

 	format(string, sizeof(string), "%02d/%s/%d", day, MonthDay[month - 1], year); //date
	PlayerTextDrawSetString(playerid, PhoneTD[playerid][12], string);

 	format(string, sizeof(string), "%s", name); //zone
	PlayerTextDrawSetString(playerid, PhoneTD[playerid][4], string);



	PlayerTextDrawSetString(playerid, PhoneTD[playerid][14], "Menu");
	PlayerTextDrawShow(playerid, PhoneTD[playerid][14]);
	PlayerTextDrawSetString(playerid, PhoneTD[playerid][15], "Option");
	PlayerTextDrawShow(playerid, PhoneTD[playerid][15]);
    for(new i = 0; i != 16; ++i)
	{
		PlayerTextDrawShow(playerid, PhoneTD[playerid][i]);
	}
	ph_page[playerid] = 0;
	ph_select[playerid] = 0;
    SelectTextDraw(playerid, 0x58ACFAFF);
	PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
	PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
	PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
	ApplyAnimation(playerid, "COLT45","sawnoff_reload", 4.1, 0, 0, 0, 1, 0, 1);
	SetPlayerAttachedObject(playerid,6,18868,6,0.101899,0.090998,-0.002901,85.799896,-86.499809,-3.799900,1.000000,1.000000,1.000000);
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
    return 1;
}
HidePlayerPhone(playerid)
{
    for(new i = 0; i != 16; ++i)
	{
		PlayerTextDrawHide(playerid, PhoneTD[playerid][i]);
	}
    for(new i = 0; i != 3; ++i)
	{
		PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][i]);
	}
    CancelSelectTextDraw(playerid);
	RemovePlayerAttachedObject(playerid, 6);
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
    return 1;
}


hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{

	if(playertextid == PhoneTD[playerid][7]) // x
	{
		if(playerData[playerid][pIncomingCalling] == 1)
			return 1;

		ClearAnimations(playerid);
		HidePlayerPhone(playerid);
		return 1;
	}

	if(playertextid == PhoneTD[playerid][8]) // Up
	{
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		if(playerData[playerid][pIncomingCalling] == 1)
			return 1;

		if(ph_page[playerid] == 1 && playerData[playerid][pEmergency] == 2)
		{
			if(ph_select[playerid] == 1)
				return 1;

			ph_select[playerid] --;
			if(ph_select[playerid] == 1)
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> List Contact");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Add Contact");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);
				return 1;
			}
		}
		if(ph_page[playerid] == 1 && playerData[playerid][pEmergency] == 1)
		{
			if(ph_select[playerid] == 1)
				return 1;

			ph_select[playerid] --;
			if(ph_select[playerid] == 1)
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> Police");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Medic");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Mechanic");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
				return 1;
			}
			if(ph_select[playerid] == 2)
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "Police");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "> Medic");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Mechanic");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
				return 1;
			}
		}
		if(ph_page[playerid] == 2)
		{
			if(ph_select[playerid] == 1)
				return 1;
			ph_select[playerid] --;

			if(ph_select[playerid] == 1) //Turn On/Off
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> Turn On/Off");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "-");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "-");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			}
			if(ph_select[playerid] == 2) //Sms
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "Turn On/Off");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "-");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "-");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			}

		}
		if(ph_page[playerid] == 1)
		{
			if(ph_select[playerid] == 1)
				return 1;
			ph_select[playerid] --;

			if(ph_select[playerid] == 1) //Call
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> Call");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Sms");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Contact");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			}
			if(ph_select[playerid] == 2) //Sms
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "Call");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "> Sms");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Contact");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			}
			if(ph_select[playerid] == 3) //Contact
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "Call");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Sms");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "> Contact");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			}
			if(ph_select[playerid] == 4) //Give Contact
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> Give Contact");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Twitter");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Market graph");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			}
			if(ph_select[playerid] == 5) //Twitter
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "Give Contact");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "> Twitter");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Market graph");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			}
			if(ph_select[playerid] == 6) //Market graph
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "Give Contact");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Twitter");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "> Market graph");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			}
			if(ph_select[playerid] == 7) //Market graph
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> Party");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Transfer");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
				PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][1]);
			}
		}
		return 1;
	}
	if(playertextid == PhoneTD[playerid][10]) // Left
	{
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		return 1;
	}
	if(playertextid == PhoneTD[playerid][9]) // Right
	{
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		return 1;
	}
	if(playertextid == PhoneTD[playerid][11]) // Down
	{
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		if(playerData[playerid][pIncomingCalling] == 1)
			return 1;
		
		if(ph_page[playerid] == 1 && playerData[playerid][pEmergency] == 2)
		{
			if(ph_select[playerid] == 2)
				return 1;

			ph_select[playerid] ++;
			if(ph_select[playerid] == 2)
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "List Contact");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "> Add Contact");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);
				return 1;
			}
			return 1;
		}
		if(ph_page[playerid] == 1 && playerData[playerid][pEmergency] == 1)
		{
			if(ph_select[playerid] == 3)
				return 1;

			ph_select[playerid] ++;
			if(ph_select[playerid] == 2)
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "Police");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "> Medic");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Mechanic");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
				return 1;
			}
			if(ph_select[playerid] == 3)
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "Police");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Medic");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "> Mechanic");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
				return 1;
			}
			return 1;
		}
		if(ph_page[playerid] == 2)
		{
			if(ph_select[playerid] == 3)
				return 1;

			ph_select[playerid] ++;
			if(ph_select[playerid] == 2) //-
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "Turn On/Off");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "-");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "-");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			}
			if(ph_select[playerid] == 3) //-
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "Turn On/Off");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "-");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "-");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			}
		}
		if(ph_page[playerid] == 1)
		{
			if(ph_select[playerid] == 8)
				return 1;

			ph_select[playerid] ++;
			if(ph_select[playerid] == 2) //Sms
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "Call");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "> Sms");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Contact");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			}
			if(ph_select[playerid] == 3) //Contact
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "Call");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Sms");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "> Contact");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			}
			if(ph_select[playerid] == 4) //Give Contact
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> Give Contact");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Twitter");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Market graph");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			}
			if(ph_select[playerid] == 5) //Twitter
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "Give Contact");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "> Twitter");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Market graph");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			}
			if(ph_select[playerid] == 6) //Market graph
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "Give Contact");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Twitter");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "> Market graph");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			}
			if(ph_select[playerid] == 7) //Party
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> Party");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Transfer");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
				PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][1]);
			}
			if(ph_select[playerid] == 8) //Bank
			{
				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "Party");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "> Transfer");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911871);
				PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

				PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "");
				PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
				PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][1]);
			}
		}
		return 1;
	}
	if(playertextid == PhoneTD[playerid][3]) // ปุ่มซ้าย
	{
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		if(ph_page[playerid] == 2 && ph_select[playerid] == 1) //Turn On/Off
		{
			if (!playerData[playerid][pPhoneOff])
			{
				if (playerData[playerid][pCallLine] != INVALID_PLAYER_ID)
					{
					CancelCall(playerid);
				}
				playerData[playerid][pPhoneOff] = 1;
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ปิดเครื่องโทรศัพท์มือถือ", GetPlayerNameEx(playerid));
			}
			else
			{
				playerData[playerid][pPhoneOff] = 0;
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้เปิดเครื่องโทรศัพท์มือถือ", GetPlayerNameEx(playerid));
			}
			return 1;
		}
		if (playerData[playerid][pPhoneOff])
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณจำเป็นต้องเปิดเครื่องก่อน");

		if(playerData[playerid][pIncomingCalling] == 1) //รับสาย
		{
			if(playerData[playerid][pIncomingCall] == 0)
				return 1;

			new string[64], targetid = playerData[playerid][pCallLine];

			playerData[playerid][pIncomingCall] = 0;
			playerData[targetid][pIncomingCall] = 0;

			playerData[playerid][pIncomingCalling] = 1;
			playerData[targetid][pIncomingCalling] = 1;

			SetPlayerChatBubble(playerid, "** รับสายเรียกเข้า", COLOR_PURPLE, 5.0, 5000);
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้รับสายเรียกเข้า", GetPlayerNameEx(playerid));
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);

			format(string, sizeof(string), "%s~n~(%s)", GetPlayerNameEx(playerid), FormatNumberPhone(playerData[playerid][pPhone]));
			PlayerTextDrawSetString(targetid, PhoneTD[playerid][12], string);
			PlayerTextDrawShow(targetid, PhoneTD[playerid][12]);

			format(string, sizeof(string), "%s~n~(%s)", GetPlayerNameEx(targetid), FormatNumberPhone(playerData[targetid][pPhone]));
			PlayerTextDrawSetString(playerid, PhoneTD[playerid][12], string);
			PlayerTextDrawShow(playerid, PhoneTD[playerid][12]);

			return 1;
		}

		
		if(ph_page[playerid] == 1 && ph_select[playerid] == 1 && playerData[playerid][pEmergency] == 1)
			return Dialog_Show(playerid, PH_Call_Police, DIALOG_STYLE_INPUT, "โทร (Call)", "{FFFFFF}โปรดระบุข้อความที่คุณต้องการจะขอความช่วยเหลือถึง {1394BF}'Police'\n{FFA84D}*ควรแจ้งสถานที่ที่ชัดเจน", "โทร", "ปิด");
	
		if(ph_page[playerid] == 1 && ph_select[playerid] == 2 && playerData[playerid][pEmergency] == 1)
			return Dialog_Show(playerid, PH_Call_Medic, DIALOG_STYLE_INPUT, "โทร (Call)", "{FFFFFF}โปรดระบุข้อความที่คุณต้องการจะขอความช่วยเหลือถึง {FF8282}'Medic'\n{FFA84D}*ควรแจ้งสถานที่ที่ชัดเจน", "โทร", "ปิด");
	
		if(ph_page[playerid] == 1 && ph_select[playerid] == 3 && playerData[playerid][pEmergency] == 1)
			return Dialog_Show(playerid, PH_Call_Mechanic, DIALOG_STYLE_INPUT, "โทร (Call)", "{FFFFFF}โปรดระบุข้อความที่คุณต้องการจะขอความช่วยเหลือถึง {FFA84D}'Mechanic'\n{FFA84D}*ควรแจ้งสถานที่ที่ชัดเจน", "โทร", "ปิด");
	
	
		if(ph_page[playerid] == 1 && ph_select[playerid] == 1 && playerData[playerid][pEmergency] == 2)
			return ShowContacts(playerid);
	
		if(ph_page[playerid] == 1 && ph_select[playerid] == 2 && playerData[playerid][pEmergency] == 2)
			return Dialog_Show(playerid, DIALOG_NEWCONTACTS, DIALOG_STYLE_INPUT, "[Add Contact]", "{FFFFFF}โปรดระบุ {FFA84D}'ชื่อ' {FFFFFF}ที่คุณต้องการจะบันทึกลงเบอร์ติดต่อ", "ตกลง", "กลับ");
	
		if(ph_page[playerid] == 1 && ph_select[playerid] == 1) //Call
			return Dialog_Show(playerid, PH_Call, DIALOG_STYLE_INPUT, "โทร (Call)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะติดต่อ\n{FFA84D}(911 สำหรับกรณีฉุกเฉิน)", "โทร", "ปิด");
			
		if(ph_page[playerid] == 1 && ph_select[playerid] == 2) //Sms
			return Dialog_Show(playerid, PH_Sms, DIALOG_STYLE_INPUT, "ส่งข้อความ (SMS)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะส่งข้อความ", "ส่ง", "ปิด");
			
		if(ph_page[playerid] == 1 && ph_select[playerid] == 3) //Contact
		{
			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> List Contact");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Add Contact");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);


			ph_page[playerid] = 1;
			ph_select[playerid] = 1;
			playerData[playerid][pEmergency] = 2;
			PlayerTextDrawHide(playerid, PhoneTD[playerid][12]);
			PlayerTextDrawHide(playerid, PhoneTD[playerid][13]);
			PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][1]);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);
			return 1;
		}
			
		if(ph_page[playerid] == 1 && ph_select[playerid] == 4) //Give Contact
		{
			new
				string[128],
				string2[4096],
				var[15],
				count;
			foreach (new  i : Player)
			{
				if (i == playerid) continue;
				if (IsPlayerNearPlayer(playerid, i, 5.0))
				{
					format(string, sizeof(string), "(id: %d)\t%s\n", i, GetPlayerNameEx(i));
					strcat(string2, string);
					format(var, sizeof(var), "GiveContact%d", count);
					SetPVarInt(playerid, var, i);
					count++;
				}
			}
			if (!count)
			{
				Dialog_Show(playerid,Paymoneyerorr,DIALOG_STYLE_LIST,"[Phone]","ไม่พบผู้เล่นอยู่รอบๆ บริเวณใกล้คุณ","ปิด","");
				return 1;
			}
			format(string, sizeof(string), " ไอดี\t    รายชื่อ\n%s", string2);
			Dialog_Show(playerid, DIALOG_ContactGIVEID, DIALOG_STYLE_TABLIST_HEADERS, "[Phone]", string, "เลือก", "ปิด");
			return 1;
		}
		if(ph_page[playerid] == 1 && ph_select[playerid] == 5) //Twitter
			return Dialog_Show(playerid, PH_Twitter, DIALOG_STYLE_INPUT, "Twitter", "{FFFFFF}โปรดระบุข้อความที่คุณต้องการจะโพสลง {33CCFF}'Twitter'", "โพส", "ปิด");
		
		if(ph_page[playerid] == 1 && ph_select[playerid] == 6) //Market graph
			return Marketpricegraph(playerid);

		if(ph_page[playerid] == 1 && ph_select[playerid] == 7) //Party
			return ShowPartyMenu(playerid);

		if(ph_page[playerid] == 1 && ph_select[playerid] == 8) //Bank
			return Dialog_Show(playerid, ATM_Transfer, DIALOG_STYLE_INPUT, "โอนเงิน (Transfer)", "{FFFFFF}เงินภายในตัว(Cash):{00FF00} %s {FFFFFF}| เงินในธนาคาร(Bank): {00FF00}%s{FFA84D}\n\
			โปรดระบุไอดีของผู้เล่น ที่คุณต้องการจะโอนเงินให้", "ตกลง", "กลับ",
			FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(playerData[playerid][pBankMoney]));


		if(ph_page[playerid] == 0)
		{

			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> Call");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Sms");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Contact");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);

			ph_page[playerid] = 1;
			ph_select[playerid] = 1;
			PlayerTextDrawHide(playerid, PhoneTD[playerid][12]);
			PlayerTextDrawHide(playerid, PhoneTD[playerid][13]);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);
			
			PlayerTextDrawSetString(playerid, PhoneTD[playerid][14], "Select");
			PlayerTextDrawShow(playerid, PhoneTD[playerid][14]);
			PlayerTextDrawSetString(playerid, PhoneTD[playerid][15], "Back");
			PlayerTextDrawShow(playerid, PhoneTD[playerid][15]);
		}
		
		return 1;
	}
	if(playertextid == PhoneTD[playerid][6]) // ปุ่มขวา
	{
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);

		if(ph_page[playerid] == 0)
		{
			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> Turn On/Off");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "-");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "-");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);

			ph_page[playerid] = 2;
			ph_select[playerid] = 1;
			PlayerTextDrawHide(playerid, PhoneTD[playerid][12]);
			PlayerTextDrawHide(playerid, PhoneTD[playerid][13]);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);
			
			PlayerTextDrawSetString(playerid, PhoneTD[playerid][14], "Select");
			PlayerTextDrawShow(playerid, PhoneTD[playerid][14]);
			PlayerTextDrawSetString(playerid, PhoneTD[playerid][15], "Back");
			PlayerTextDrawShow(playerid, PhoneTD[playerid][15]);
			return 1;
		}
		if(playerData[playerid][pIncomingCalling] == 1) //วางสาย
		{
			new targetid = playerData[playerid][pCallLine];

			if (playerData[playerid][pIncomingCall])
			{
				SendClientMessage(playerid, COLOR_YELLOW, "[มือถือ]:{FFFFFF} คุณได้ตัดสายเรียกเข้า");
				SendClientMessage(targetid, COLOR_YELLOW, "[มือถือ]:{FFFFFF} คุณถูกตัดสายการโทร");
				SetPlayerChatBubble(playerid, "** ตัดสายเรียกเข้า", COLOR_PURPLE, 5.0, 5000);
			}
			else
			{
				SendClientMessage(playerid, COLOR_YELLOW, "[มือถือ]:{FFFFFF} คุณวางสายแล้ว");
				SendClientMessage(targetid, COLOR_YELLOW, "[มือถือ]:{FFFFFF} คุณถูกวางสายแล้ว");
				SetPlayerChatBubble(playerid, "** วางสายมือถือ", COLOR_PURPLE, 5.0, 5000);
				SetPlayerChatBubble(targetid, "** วางสายมือถือ", COLOR_PURPLE, 5.0, 5000);

			}
			ClearAnimations(playerid);

			HidePlayerPhone(playerid);
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);

			HidePlayerPhone(targetid);
			SetPlayerSpecialAction(targetid,SPECIAL_ACTION_STOPUSECELLPHONE);
			
			playerData[playerid][pIncomingCall] = 0;
			playerData[targetid][pIncomingCall] = 0;

			playerData[playerid][pIncomingCalling] = 0;
			playerData[targetid][pIncomingCalling] = 0;

			playerData[playerid][pCallLine] = INVALID_PLAYER_ID;
			playerData[targetid][pCallLine] = INVALID_PLAYER_ID;

			return 1;
		}
		if(ph_page[playerid] == 1 && playerData[playerid][pEmergency] == 1)
		{
			playerData[playerid][pEmergency] = 0;
			ph_select[playerid] = 1;
			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> Call");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Sms");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Contact");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			return 1;
		}
		if(ph_page[playerid] == 1 && playerData[playerid][pEmergency] == 2)
		{
			playerData[playerid][pEmergency] = 0;
			ph_select[playerid] = 3;
			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "Call");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911816);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Sms");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "> Contact");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911871);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			return 1;
		}
		if(ph_page[playerid] == 1)
		{
			PlayerTextDrawSetString(playerid, PhoneTD[playerid][14], "Menu");
			PlayerTextDrawShow(playerid, PhoneTD[playerid][14]);
			PlayerTextDrawSetString(playerid, PhoneTD[playerid][15], "Option");
			PlayerTextDrawShow(playerid, PhoneTD[playerid][15]);

			ph_page[playerid] = 0;
			ph_select[playerid] = 0;
			playerData[playerid][pEmergency] = 0;
			PlayerTextDrawShow(playerid, PhoneTD[playerid][12]);
			PlayerTextDrawShow(playerid, PhoneTD[playerid][13]);
			PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][0]);
			PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][1]);
			PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][2]);
			return 1;
		}
		if(ph_page[playerid] == 2)
		{
			PlayerTextDrawSetString(playerid, PhoneTD[playerid][14], "Menu");
			PlayerTextDrawShow(playerid, PhoneTD[playerid][14]);
			PlayerTextDrawSetString(playerid, PhoneTD[playerid][15], "Option");
			PlayerTextDrawShow(playerid, PhoneTD[playerid][15]);

			ph_page[playerid] = 0;
			ph_select[playerid] = 0;
			PlayerTextDrawShow(playerid, PhoneTD[playerid][12]);
			PlayerTextDrawShow(playerid, PhoneTD[playerid][13]);
			PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][0]);
			PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][1]);
			PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][2]);
			return 1;
		}
		return 1;
	}
	return 1;
}

Dialog:PH_Call_Mechanic(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if (response)
	{
		new MapZone:zone = GetPlayerMapZone(playerid);
		new name[MAX_MAP_ZONE_NAME];
		GetMapZoneName(zone, name);

		if (isnull(inputtext))
			return Dialog_Show(playerid, PH_Call_Mechanic, DIALOG_STYLE_INPUT, "โทร (Call)", "{FFFFFF}โปรดระบุข้อความที่คุณต้องการจะขอความช่วยเหลือถึง {FFA84D}'Mechanic'\n{FFA84D}*ควรแจ้งสถานที่ที่ชัดเจน", "โทร", "ปิด");


		CallMec[playerid] = 1;
		SendFactionMessageEx(FACTION_MEC, COLOR_YELLOW, "[แจ้งเหตุ 911]: (%d)%s (%s): %s", playerid, GetPlayerNameEx(playerid), FormatNumberPhone(playerData[playerid][pPhone]), inputtext);
		SendFactionMessageEx(FACTION_MEC, COLOR_YELLOW, "[แจ้งเหตุ 911]: เขตพื้นที่: %s, สามารถ '/mdc' เพื่อตอบกลับ", name);



		SendClientMessageEx(playerid, COLOR_YELLOW, "[Emergency]: คุณได้โทรแจ้งเหตุ 911 ไปที่หน่วยงาน 'Mechanic' เรียบร้อย กรุณารอการตอบกลับ", GetPlayerNameEx(playerid));
		SetPlayerChatBubble(playerid, "** โทรแจ้งเหตุไปที่ 911", COLOR_PURPLE, 5.0, 5000);
		PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);

		playerData[playerid][pEmergency] = 0;
		ph_select[playerid] = 1;
		PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> Call");
		PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
		PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

		PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Sms");
		PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
		PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

		PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Contact");
		PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
		PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
		return 1;
	}
	return 1;
}

Dialog:PH_Call_Medic(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if (response)
	{
		new MapZone:zone = GetPlayerMapZone(playerid);
		new name[MAX_MAP_ZONE_NAME];
		GetMapZoneName(zone, name);

		if (isnull(inputtext))
			return Dialog_Show(playerid, PH_Call_Medic, DIALOG_STYLE_INPUT, "โทร (Call)", "{FFFFFF}โปรดระบุข้อความที่คุณต้องการจะขอความช่วยเหลือถึง {FF8282}'Medic'\n{FFA84D}*ควรแจ้งสถานที่ที่ชัดเจน", "โทร", "ปิด");


		CallMedic[playerid] = 1;
		SendFactionMessageEx(FACTION_MEDIC, COLOR_YELLOW, "[แจ้งเหตุ 911]: (%d)%s (%s): %s", playerid, GetPlayerNameEx(playerid), FormatNumberPhone(playerData[playerid][pPhone]), inputtext);
		SendFactionMessageEx(FACTION_MEDIC, COLOR_YELLOW, "[แจ้งเหตุ 911]: เขตพื้นที่: %s, สามารถ '/mdc' เพื่อตอบกลับ", name);



		SendClientMessageEx(playerid, COLOR_YELLOW, "[Emergency]: คุณได้โทรแจ้งเหตุ 911 ไปที่หน่วยงาน 'Medic' เรียบร้อย กรุณารอการตอบกลับ", GetPlayerNameEx(playerid));
		SetPlayerChatBubble(playerid, "** โทรแจ้งเหตุไปที่ 911", COLOR_PURPLE, 5.0, 5000);
		PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);

		playerData[playerid][pEmergency] = 0;
		ph_select[playerid] = 1;
		PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> Call");
		PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
		PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

		PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Sms");
		PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
		PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

		PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Contact");
		PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
		PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
		return 1;
	}
	return 1;
}

Dialog:PH_Call_Police(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if (response)
	{
		new MapZone:zone = GetPlayerMapZone(playerid);
		new name[MAX_MAP_ZONE_NAME];
		GetMapZoneName(zone, name);

		if (isnull(inputtext))
			return Dialog_Show(playerid, PH_Call_Police, DIALOG_STYLE_INPUT, "โทร (Call)", "{FFFFFF}โปรดระบุข้อความที่คุณต้องการจะขอความช่วยเหลือถึง {1394BF}'Police'\n{FFA84D}*ควรแจ้งสถานที่ที่ชัดเจน", "โทร", "ปิด");

		SendFactionMessageEx(FACTION_POLICE, COLOR_YELLOW, "[แจ้งเหตุ 911]: (%d)%s (%s): %s", playerid, GetPlayerNameEx(playerid), FormatNumberPhone(playerData[playerid][pPhone]), inputtext);
		SendFactionMessageEx(FACTION_POLICE, COLOR_YELLOW, "[แจ้งเหตุ 911]: เขตพื้นที่: %s", name);

		SendClientMessageEx(playerid, COLOR_YELLOW, "[Emergency]: คุณได้โทรแจ้งเหตุ 911 ไปที่หน่วยงาน 'Police' เรียบร้อย", GetPlayerNameEx(playerid));
		SetPlayerChatBubble(playerid, "** โทรแจ้งเหตุไปที่ 911", COLOR_PURPLE, 5.0, 5000);
		PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);

		playerData[playerid][pEmergency] = 0;
		ph_select[playerid] = 1;
		PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> Call");
		PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
		PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

		PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Sms");
		PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
		PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

		PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Contact");
		PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
		PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
		return 1;
	}
	return 1;
}

Dialog:DIALOG_ContactGIVEID(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if (response)
	{
		new var[15];
		format(var, sizeof(var), "GiveContact%d", listitem);
		new userid = GetPVarInt(playerid, var);

		SetPlayerChatBubble(playerid, "** กดอะไรบางอย่างในมือถือ", COLOR_PURPLE, 5.0, 5000);
        SendClientMessageEx(userid, COLOR_YELLOW, "[Give Contact]: %s ได้แสดงเบอร์มือถือของเขาให้คุณ '%s'", GetPlayerNameEx(playerid), FormatNumberPhone(playerData[playerid][pPhone]));
        SendClientMessageEx(playerid, COLOR_YELLOW, "[Give Contact]: คุณได้แสดงเบอร์มือถือของคุณให้กับ %s", GetPlayerNameEx(userid));
	}
	return 1;
}
Dialog:PH_Twitter(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if (response)
	{
		if (isnull(inputtext))
			return Dialog_Show(playerid, PH_Twitter, DIALOG_STYLE_INPUT, "Twitter", "{FFFFFF}โปรดระบุข้อความที่คุณต้องการจะโพสลง {33CCFF}'Twitter'", "โพส", "ปิด");

		SetPlayerChatBubble(playerid, "** กดอะไรบางอย่างในมือถือ", COLOR_PURPLE, 5.0, 5000);
		SendClientMessageToAllEx(COLOR_DARKBLUE, "[Twitter] %s: %s", GetPlayerNameEx(playerid), inputtext);
	}
	return 1;
}

Dialog:PH_Sms(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if (response)
	{
		static
			targetid,
			numberid;

		if (isnull(inputtext))
			return Dialog_Show(playerid, PH_Sms, DIALOG_STYLE_INPUT, "ส่งข้อความ (SMS)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะส่งข้อความ", "ส่ง", "ปิด");
	
		if (sscanf(inputtext, "d", numberid))
 	   		return Dialog_Show(playerid, PH_Sms, DIALOG_STYLE_INPUT, "ส่งข้อความ (SMS)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะส่งข้อความ", "ส่ง", "ปิด");

		if (!numberid){
			return Dialog_Show(playerid, PH_Sms, DIALOG_STYLE_INPUT, "ส่งข้อความ (SMS)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะส่งข้อความ\n{FF6347}*ไม่พบหมายเลขที่คุณต้องการจะส่งถึง", "ส่ง", "ปิด");
		}
		else if ((targetid = GetNumberOwner(numberid)) != INVALID_PLAYER_ID)
		{
			if (targetid == playerid)
				return Dialog_Show(playerid, PH_Sms, DIALOG_STYLE_INPUT, "ส่งข้อความ (SMS)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะส่งข้อความ\n{FF6347}*ไม่สามารถส่งข้อความหาตัวเองได้", "ส่ง", "ปิด");

			if (!Inventory_HasItem(targetid, "iFruit"))
				return Dialog_Show(playerid, PH_Sms, DIALOG_STYLE_INPUT, "ส่งข้อความ (SMS)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะส่งข้อความ\n{FF6347}*หมายเลขที่คุณต้องการส่งข้อความถึง ไม่สามารถใช้ได้ในขณะนี้", "ส่ง", "ปิด");
			
			if (playerData[targetid][pCuffed])
				return Dialog_Show(playerid, PH_Sms, DIALOG_STYLE_INPUT, "ส่งข้อความ (SMS)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะส่งข้อความ\n{FF6347}*หมายเลขที่คุณต้องการส่งข้อความถึง ไม่สามารถใช้ได้ในขณะนี้", "ส่ง", "ปิด");
			
			Dialog_Show(playerid, PH_Sms_Type, DIALOG_STYLE_INPUT, "ส่งข้อความ (SMS)", "{FFFFFF}โปรดระบุข้อความที่คุณต้องการจะส่งถึงหมายเลข '%s'", "ส่ง", "ปิด", FormatNumberPhone(numberid));
		}
		else
		{
			Dialog_Show(playerid, PH_Sms, DIALOG_STYLE_INPUT, "ส่งข้อความ (SMS)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะส่งข้อความ\n{FF6347}*ไม่พบหมายเลขที่คุณต้องการส่งข้อความถึง", "ส่ง", "ปิด");
		}
		playerData[playerid][pCallLine] = targetid;
		playerData[playerid][pIncomingCall] = numberid;
	}
	return 1;
}
Dialog:PH_Sms_Type(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new numberid = playerData[playerid][pIncomingCall], targetid = playerData[playerid][pCallLine];
	if (response)
	{
		if (isnull(inputtext))
			return Dialog_Show(playerid, PH_Sms, DIALOG_STYLE_INPUT, "ส่งข้อความ (SMS)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะส่งข้อความ", "ส่ง", "ปิด");
	
		SetPlayerChatBubble(playerid, "** กดอะไรบางอย่างในมือถือ", COLOR_PURPLE, 5.0, 5000);
		PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
		SendClientMessageEx(playerid, COLOR_YELLOW, "[SMS]: คุณได้ส่งข้อความถึงเบอร์ '%s' เรียบร้อย", FormatNumberPhone(numberid));
		SendClientMessageEx(targetid, COLOR_YELLOW, "[SMS]: เบอร์โทรศัพท์หมายเลข '%s' ส่งข้อความถึงคุณ", FormatNumberPhone(playerData[playerid][pPhone]));
		SendClientMessageEx(targetid, COLOR_YELLOW, "[SMS]: ข้อความ: %s", inputtext);
	}
	return 1;
}
Dialog:PH_Call(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if (response)
	{
		static
			targetid,
			numberid,
			string[64];

		if (isnull(inputtext))
			return Dialog_Show(playerid, PH_Call, DIALOG_STYLE_INPUT, "โทร (Call)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะติดต่อ\n{FFA84D}(911 สำหรับกรณีฉุกเฉิน)", "โทร", "ปิด");
	
		if (sscanf(inputtext, "d", numberid))
 	   		return Dialog_Show(playerid, PH_Call, DIALOG_STYLE_INPUT, "โทร (Call)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะติดต่อ\n{FFA84D}(911 สำหรับกรณีฉุกเฉิน)", "โทร", "ปิด");

		if (!numberid){
			return Dialog_Show(playerid, PH_Call, DIALOG_STYLE_INPUT, "โทร (Call)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะติดต่อ\n{FFA84D}(911 สำหรับกรณีฉุกเฉิน) {FF6347}*ไม่พบหมายเลขที่ท่านเรียก", "โทร", "ปิด");
		}
		if (numberid == 911)
		{
			playerData[playerid][pEmergency] = 1;

			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> Police");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Medic");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Mechanic");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);

			/*Dialog_Show(playerid, PH_Call, DIALOG_STYLE_INPUT, "โทร (Call)", "{FFFFFF}- Police (ตำรวจ)\n- Medic (หมอ)", "เลือก", "ปิด");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "[พนักงาน]:{FFFFFF} คุณต้องการติดต่อใคร: \"ตำรวจ\" หรือ \"หมอ\"?");*/
		}
		else if ((targetid = GetNumberOwner(numberid)) != INVALID_PLAYER_ID)
		{
			
			if (targetid == playerid)
				return Dialog_Show(playerid, PH_Call, DIALOG_STYLE_INPUT, "โทร (Call)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะติดต่อ\n{FFA84D}(911 สำหรับกรณีฉุกเฉิน) {FF6347}*ไม่สามารถโทรหาตัวเองได้", "โทร", "ปิด");

			if (playerData[targetid][pPhoneOff])
				return Dialog_Show(playerid, PH_Call, DIALOG_STYLE_INPUT, "โทร (Call)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะติดต่อ\n{FFA84D}(911 สำหรับกรณีฉุกเฉิน) {FF6347}*หมายเลขที่ท่านเรียกไม่สามารถติดต่อได้ในขณะนี้", "โทร", "ปิด");

			if (!Inventory_HasItem(targetid, "iFruit"))
				return Dialog_Show(playerid, PH_Call, DIALOG_STYLE_INPUT, "โทร (Call)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะติดต่อ\n{FFA84D}(911 สำหรับกรณีฉุกเฉิน) {FF6347}*หมายเลขที่ท่านเรียกไม่สามารถติดต่อได้ในขณะนี้", "โทร", "ปิด");
			
			if (playerData[targetid][pCuffed])
				return Dialog_Show(playerid, PH_Call, DIALOG_STYLE_INPUT, "โทร (Call)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะติดต่อ\n{FFA84D}(911 สำหรับกรณีฉุกเฉิน) {FF6347}*หมายเลขที่ท่านเรียกไม่สามารถติดต่อได้ในขณะนี้", "โทร", "ปิด");

			playerData[targetid][pIncomingCall] = 1;
			playerData[playerid][pIncomingCall] = 1;

			playerData[targetid][pIncomingCalling] = 1;
			playerData[playerid][pIncomingCalling] = 1;

			playerData[targetid][pCallLine] = playerid;
			playerData[playerid][pCallLine] = targetid;

			PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
			PlayerPlaySoundEx(targetid, 23000);
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);

			SendClientMessage(playerid, COLOR_YELLOW, "[Phone]: กด 'N' เพื่อจัดการมือถือ");
			format(string, sizeof(string), "Calling...~n~(%s)", FormatNumberPhone(playerData[targetid][pPhone]));
			PlayerTextDrawSetString(playerid, PhoneTD[playerid][12], string);
			PlayerTextDrawShow(playerid, PhoneTD[playerid][12]);
			PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][0]);
			PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][1]);
			PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][2]);	

			PlayerTextDrawSetString(playerid, PhoneTD[playerid][14], "Answer");
			PlayerTextDrawShow(playerid, PhoneTD[playerid][14]);
			PlayerTextDrawSetString(playerid, PhoneTD[playerid][15], "Hangup");
			PlayerTextDrawShow(playerid, PhoneTD[playerid][15]);
			CancelSelectTextDraw(playerid);



			ShowPlayerPhone(targetid);
			PlayerTextDrawSetString(targetid, PhoneTD[playerid][14], "Answer");
			PlayerTextDrawShow(targetid, PhoneTD[playerid][14]);
			PlayerTextDrawSetString(targetid, PhoneTD[playerid][15], "Hangup");
			PlayerTextDrawShow(targetid, PhoneTD[playerid][15]);

			SendClientMessage(targetid, COLOR_YELLOW, "[Phone]: กด 'N' เพื่อจัดการมือถือ");
			format(string, sizeof(string), "Calling...~n~(%s)", FormatNumberPhone(playerData[playerid][pPhone]));
			PlayerTextDrawSetString(targetid, PhoneTD[playerid][12], string);
			PlayerTextDrawShow(targetid, PhoneTD[playerid][12]);
			PlayerTextDrawHide(targetid, Phone_MenuTD[playerid][0]);
			PlayerTextDrawHide(targetid, Phone_MenuTD[playerid][1]);
			PlayerTextDrawHide(targetid, Phone_MenuTD[playerid][2]);
			PlayerTextDrawHide(targetid, PhoneTD[playerid][13]);
			CancelSelectTextDraw(targetid);
			ClearAnimations(targetid);
			//SelectTextDraw(targetid, 0x58ACFAFF);
		}
		else
		{
			Dialog_Show(playerid, PH_Call, DIALOG_STYLE_INPUT, "โทร (Call)", "{FFFFFF}โปรดระบุหมายเลขโทรศัพท์มือถือ ที่คุณต้องการจะติดต่อ\n{FFA84D}(911 สำหรับกรณีฉุกเฉิน) {FF6347}*ไม่พบหมายเลขที่ท่านเรียก", "โทร", "ปิด");
		}
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, listitem, oldkeys)
{
	if (newkeys & KEY_NO)
	{
		if(playerData[playerid][pIncomingCalling] == 1 || playerData[playerid][pIncomingCall] == 1)
			return SelectTextDraw(playerid, 0x58ACFAFF);
	}
	return 1;
}