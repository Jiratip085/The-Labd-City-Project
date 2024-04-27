
#include    <YSI_Coding\y_hooks>




new PlayerText:RegisterTD[MAX_PLAYERS][13];


UpdatePlayerRegister(playerid)
{
	if (playerData[playerid][IsLoggedIn] == false) return 0;

	new query[256];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `playerGender` = %d, `playerAge` = '%d', `playerTutorial` = %d WHERE `playerID` = %d LIMIT 1",
	playerData[playerid][pGender], playerData[playerid][pAge], playerData[playerid][pTutorial], playerData[playerid][pID]);
	mysql_tquery(g_SQL, query);
	return 1;
}



hook OnGameModeInit()
{

}

hook OnPlayerConnect(playerid)
{
	new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    if (!IsRPName(name))
    {
    	SendClientMessage(playerid, COLOR_LIGHTRED, "[ผิดพลาด] {FFFFFF}กรุณามใช้ชื่อที่สมบทบาทชีวิตจริง เช่น {FFFF00}*Firstname_Lastname");
       	DelayedKick(playerid);
    }
	RegisterTD[playerid][0] = CreatePlayerTextDraw(playerid, 120.750000, 150.000000, "_");
	PlayerTextDrawFont(playerid, RegisterTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, RegisterTD[playerid][0], 0.600000, 23.400033);
	PlayerTextDrawTextSize(playerid, RegisterTD[playerid][0], 298.000000, 220.000000);
	PlayerTextDrawSetOutline(playerid, RegisterTD[playerid][0], 2);
	PlayerTextDrawSetShadow(playerid, RegisterTD[playerid][0], 2);
	PlayerTextDrawAlignment(playerid, RegisterTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, RegisterTD[playerid][0], -256);
	PlayerTextDrawBackgroundColor(playerid, RegisterTD[playerid][0], 0);
	PlayerTextDrawBoxColor(playerid, RegisterTD[playerid][0], 100);
	PlayerTextDrawUseBox(playerid, RegisterTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, RegisterTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterTD[playerid][0], 0);

	RegisterTD[playerid][1] = CreatePlayerTextDraw(playerid, 173.000000, 177.000000, "Gender:");
	PlayerTextDrawFont(playerid, RegisterTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, RegisterTD[playerid][1], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, RegisterTD[playerid][1], 16.500000, 105.000000);
	PlayerTextDrawSetOutline(playerid, RegisterTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, RegisterTD[playerid][1], 1);
	PlayerTextDrawAlignment(playerid, RegisterTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, RegisterTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, RegisterTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, RegisterTD[playerid][1], 1296911816);
	PlayerTextDrawUseBox(playerid, RegisterTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, RegisterTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterTD[playerid][1], 1);

	RegisterTD[playerid][2] = CreatePlayerTextDraw(playerid, 120.750000, 150.000000, "Register Character");
	PlayerTextDrawFont(playerid, RegisterTD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, RegisterTD[playerid][2], 0.333332, 1.750000);
	PlayerTextDrawTextSize(playerid, RegisterTD[playerid][2], 16.500000, 220.000000);
	PlayerTextDrawSetOutline(playerid, RegisterTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, RegisterTD[playerid][2], 1);
	PlayerTextDrawAlignment(playerid, RegisterTD[playerid][2], 2);
	PlayerTextDrawColor(playerid, RegisterTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, RegisterTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, RegisterTD[playerid][2], 1296911816);
	PlayerTextDrawUseBox(playerid, RegisterTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, RegisterTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterTD[playerid][2], 0);

	RegisterTD[playerid][3] = CreatePlayerTextDraw(playerid, 173.000000, 315.000000, "Password: xxxxxxxx");
	PlayerTextDrawFont(playerid, RegisterTD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, RegisterTD[playerid][3], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, RegisterTD[playerid][3], 16.500000, 105.000000);
	PlayerTextDrawSetOutline(playerid, RegisterTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, RegisterTD[playerid][3], 1);
	PlayerTextDrawAlignment(playerid, RegisterTD[playerid][3], 2);
	PlayerTextDrawColor(playerid, RegisterTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, RegisterTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, RegisterTD[playerid][3], 1296911816);
	PlayerTextDrawUseBox(playerid, RegisterTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, RegisterTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterTD[playerid][3], 0);

	RegisterTD[playerid][4] = CreatePlayerTextDraw(playerid, 120.000000, 341.000000, "SAMP : Black Woods");
	PlayerTextDrawFont(playerid, RegisterTD[playerid][4], 0);
	PlayerTextDrawLetterSize(playerid, RegisterTD[playerid][4], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, RegisterTD[playerid][4], 16.500000, 96.000000);
	PlayerTextDrawSetOutline(playerid, RegisterTD[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, RegisterTD[playerid][4], 2);
	PlayerTextDrawAlignment(playerid, RegisterTD[playerid][4], 2);
	PlayerTextDrawColor(playerid, RegisterTD[playerid][4], -764862721);
	PlayerTextDrawBackgroundColor(playerid, RegisterTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, RegisterTD[playerid][4], 1296911816);
	PlayerTextDrawUseBox(playerid, RegisterTD[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, RegisterTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterTD[playerid][4], 0);

	RegisterTD[playerid][5] = CreatePlayerTextDraw(playerid, 64.000000, 315.000000, "Name: Hugo_Wingin");
	PlayerTextDrawFont(playerid, RegisterTD[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, RegisterTD[playerid][5], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, RegisterTD[playerid][5], 16.500000, 96.000000);
	PlayerTextDrawSetOutline(playerid, RegisterTD[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, RegisterTD[playerid][5], 2);
	PlayerTextDrawAlignment(playerid, RegisterTD[playerid][5], 2);
	PlayerTextDrawColor(playerid, RegisterTD[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, RegisterTD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, RegisterTD[playerid][5], 1296911816);
	PlayerTextDrawUseBox(playerid, RegisterTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, RegisterTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterTD[playerid][5], 0);

	RegisterTD[playerid][6] = CreatePlayerTextDraw(playerid, 14.250000, 175.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, RegisterTD[playerid][6], 5);
	PlayerTextDrawLetterSize(playerid, RegisterTD[playerid][6], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, RegisterTD[playerid][6], 100.000000, 130.000000);
	PlayerTextDrawSetOutline(playerid, RegisterTD[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, RegisterTD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, RegisterTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, RegisterTD[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, RegisterTD[playerid][6], 1296911741);
	PlayerTextDrawBoxColor(playerid, RegisterTD[playerid][6], 1296911871);
	PlayerTextDrawUseBox(playerid, RegisterTD[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, RegisterTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterTD[playerid][6], 0);
	PlayerTextDrawSetPreviewModel(playerid, RegisterTD[playerid][6], 217);
	PlayerTextDrawSetPreviewRot(playerid, RegisterTD[playerid][6], -10.000000, 0.000000, 3.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, RegisterTD[playerid][6], 1, 1);

	RegisterTD[playerid][7] = CreatePlayerTextDraw(playerid, 173.000000, 204.000000, "Skin:");
	PlayerTextDrawFont(playerid, RegisterTD[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, RegisterTD[playerid][7], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, RegisterTD[playerid][7], 16.500000, 105.000000);
	PlayerTextDrawSetOutline(playerid, RegisterTD[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, RegisterTD[playerid][7], 1);
	PlayerTextDrawAlignment(playerid, RegisterTD[playerid][7], 2);
	PlayerTextDrawColor(playerid, RegisterTD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, RegisterTD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, RegisterTD[playerid][7], 1296911816);
	PlayerTextDrawUseBox(playerid, RegisterTD[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, RegisterTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterTD[playerid][7], 0);

	RegisterTD[playerid][8] = CreatePlayerTextDraw(playerid, 173.000000, 231.000000, "Age:");
	PlayerTextDrawFont(playerid, RegisterTD[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, RegisterTD[playerid][8], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, RegisterTD[playerid][8], 16.500000, 105.000000);
	PlayerTextDrawSetOutline(playerid, RegisterTD[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, RegisterTD[playerid][8], 1);
	PlayerTextDrawAlignment(playerid, RegisterTD[playerid][8], 2);
	PlayerTextDrawColor(playerid, RegisterTD[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, RegisterTD[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, RegisterTD[playerid][8], 1296911816);
	PlayerTextDrawUseBox(playerid, RegisterTD[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, RegisterTD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterTD[playerid][8], 1);

	RegisterTD[playerid][9] = CreatePlayerTextDraw(playerid, 173.000000, 258.000000, "Discord:");
	PlayerTextDrawFont(playerid, RegisterTD[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, RegisterTD[playerid][9], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, RegisterTD[playerid][9], 16.500000, 105.000000);
	PlayerTextDrawSetOutline(playerid, RegisterTD[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, RegisterTD[playerid][9], 1);
	PlayerTextDrawAlignment(playerid, RegisterTD[playerid][9], 2);
	PlayerTextDrawColor(playerid, RegisterTD[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, RegisterTD[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, RegisterTD[playerid][9], 1296911816);
	PlayerTextDrawUseBox(playerid, RegisterTD[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, RegisterTD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterTD[playerid][9], 1);

	RegisterTD[playerid][10] = CreatePlayerTextDraw(playerid, 173.000000, 286.000000, "Email:");
	PlayerTextDrawFont(playerid, RegisterTD[playerid][10], 1);
	PlayerTextDrawLetterSize(playerid, RegisterTD[playerid][10], 0.179165, 1.750000);
	PlayerTextDrawTextSize(playerid, RegisterTD[playerid][10], 16.500000, 105.000000);
	PlayerTextDrawSetOutline(playerid, RegisterTD[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, RegisterTD[playerid][10], 1);
	PlayerTextDrawAlignment(playerid, RegisterTD[playerid][10], 2);
	PlayerTextDrawColor(playerid, RegisterTD[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, RegisterTD[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, RegisterTD[playerid][10], 1296911816);
	PlayerTextDrawUseBox(playerid, RegisterTD[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, RegisterTD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterTD[playerid][10], 1);

	RegisterTD[playerid][11] = CreatePlayerTextDraw(playerid, 40.000000, 341.000000, "CANCEL");
	PlayerTextDrawFont(playerid, RegisterTD[playerid][11], 2);
	PlayerTextDrawLetterSize(playerid, RegisterTD[playerid][11], 0.279164, 1.700000);
	PlayerTextDrawTextSize(playerid, RegisterTD[playerid][11], 16.500000, 48.000000);
	PlayerTextDrawSetOutline(playerid, RegisterTD[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, RegisterTD[playerid][11], 1);
	PlayerTextDrawAlignment(playerid, RegisterTD[playerid][11], 2);
	PlayerTextDrawColor(playerid, RegisterTD[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, RegisterTD[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, RegisterTD[playerid][11], -1962934017);
	PlayerTextDrawUseBox(playerid, RegisterTD[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, RegisterTD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterTD[playerid][11], 1);

	RegisterTD[playerid][12] = CreatePlayerTextDraw(playerid, 201.500000, 341.000000, "SIGN UP");
	PlayerTextDrawFont(playerid, RegisterTD[playerid][12], 2);
	PlayerTextDrawLetterSize(playerid, RegisterTD[playerid][12], 0.279164, 1.700000);
	PlayerTextDrawTextSize(playerid, RegisterTD[playerid][12], 16.500000, 48.000000);
	PlayerTextDrawSetOutline(playerid, RegisterTD[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, RegisterTD[playerid][12], 1);
	PlayerTextDrawAlignment(playerid, RegisterTD[playerid][12], 2);
	PlayerTextDrawColor(playerid, RegisterTD[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, RegisterTD[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, RegisterTD[playerid][12], 8388863);
	PlayerTextDrawUseBox(playerid, RegisterTD[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, RegisterTD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterTD[playerid][12], 1);
}

new RegisterDiscord[MAX_PLAYERS];
new RegisterEmail[MAX_PLAYERS];


ShowplayerRegisterTD(playerid) 
{
	new str[128];
    for (new i = 0; i < 13; i ++) {
        PlayerTextDrawShow(playerid, RegisterTD[playerid][i]);
    }
	format(str, sizeof(str), "Name: %s", GetPlayerNameEx(playerid));
	PlayerTextDrawSetString(playerid, RegisterTD[playerid][5], str);

	SendClientMessage(playerid, COLOR_YELLOW, "[Tutorial]: หากสกอเมาส์ของคุณหายหรือไม่สามารถกดแก้ไขได้, ให้ออกเข้าใหม่อีกครั้ง");

	SelectTextDraw(playerid, COLOR_WHITE);
	playerData[playerid][pGender] = 0;
	playerData[playerid][pAge] = 0;
	RegisterDiscord[playerid] = 0;
	RegisterEmail[playerid] = 0;
	return 1;
}
HideplayerRegisterTD(playerid) 
{

    for (new i = 0; i < 13; i ++) {
        PlayerTextDrawHide(playerid, RegisterTD[playerid][i]);
    }
	SendClientMessage(playerid, COLOR_LIGHTRED, "- การสมัครสมาชิกหรือสร้างตัวละครถูกยกเลิกเรียบร้อย");
	DelayedKick(playerid);
	return 1;
}
HideplayerRegisterTDD(playerid) 
{

    for (new i = 0; i < 13; i ++) {
        PlayerTextDrawHide(playerid, RegisterTD[playerid][i]);
    }
	CancelSelectTextDraw(playerid);
	return 1;
}

// 232.1779, 81.0000, 1005.0311 เริ่ม
// 232.1779, 71.0000, 1005.0311 ไปที่

//232.1766, 68.0000, 1005.0311 //เลือกตัวละคร

SetPlayerLoginScreen(playerid) 
{

	TogglePlayerSpectating(playerid, true);
	KillTimer(playerData[playerid][LoginTimer]);
	playerData[playerid][LoginTimer] = 0;

	SetPlayerInterior(playerid,6);
	SetPlayerVirtualWorld(playerid, 1);
	TogglePlayerControllable(playerid, 0);
	InterpolateCameraPos(playerid, 232.1779, 81.0000, 1005.9000, 232.1779, 71.0000, 1005.9000, 10000);
	InterpolateCameraLookAt(playerid, 232.1766, 68.0000, 1005.9000, 232.1779, 71.0000, 1005.9000, 10000);
	Streamer_Update(playerid);
	ClearPlayerChat(playerid, 20);
	SetTimerEx("SelectSkin", 8500, 0, "i", playerid);

	
	GameTextForPlayer(playerid, "~y~SAMP ~w~: ~g~~h~Black Woods~n~Semi-Roleplay", 5000, 1);
}
// --> เริ่มต้นการเลือกตัวละคร
forward SelectSkin(playerid);
public SelectSkin(playerid)
{
	{
		InterpolateCameraPos(playerid, 232.1766, 68.0000, 1005.5000, 232.1766, 68.0000, 1005.5000, 1000);
		InterpolateCameraLookAt(playerid, 232.1766, 66.0000, 1005.5000, 232.1766, 66.0000, 1005.5000, 1000);

		GameTextForPlayer(playerid, "~y~DEV.~w~Hugo Wingin~n~~g~~h~SUP.~w~Natan April", 5000, 1);
		ShowplayerRegisterTD(playerid);
	}
	return 1;
}
Dialog:Register_Gender(playerid, response, listitem, inputtext[])
{	
	new string[128];
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				format(string, sizeof(string), "Gender: Male");
				PlayerTextDrawSetString(playerid, RegisterTD[playerid][1], string);

				format(string, sizeof(string), "Skin: 289");
				PlayerTextDrawSetString(playerid, RegisterTD[playerid][7], string);

				PlayerTextDrawSetPreviewModel(playerid, RegisterTD[playerid][6], 289);
				PlayerTextDrawShow(playerid, RegisterTD[playerid][6]);
				playerData[playerid][pGender] = 1;

				playerData[playerid][pSkin] = 289;
				return 1;
			}
			case 1:
			{
				format(string, sizeof(string), "Gender: Female");
				PlayerTextDrawSetString(playerid, RegisterTD[playerid][1], string);

				format(string, sizeof(string), "Skin: 191");
				PlayerTextDrawSetString(playerid, RegisterTD[playerid][7], string);

				PlayerTextDrawSetPreviewModel(playerid, RegisterTD[playerid][6], 191);
				PlayerTextDrawShow(playerid, RegisterTD[playerid][6]);
				playerData[playerid][pGender] = 2;

				playerData[playerid][pSkin] = 191;
				return 1;
			}
		}
	}
	return 1;
}
Dialog:Register_Age(playerid, response, listitem, inputtext[])
{
	new string[127], amount = strval(inputtext);
	if (response)
	{
		if (amount < 18 || amount > 80)
			return Dialog_Show(playerid, Register_Age, DIALOG_STYLE_INPUT, "อายุตัวละคร", "{FFFFFF}โปรดระบุจำนวน 'อายุ' ของตัวละคร\n\
		*อายุต้องมากกว่า 18 และไม่เกิน 80 ปี", "ตกลง", "ยกเลิก");

		format(string, sizeof(string), "Age: %d", amount);
		PlayerTextDrawSetString(playerid, RegisterTD[playerid][8], string);
		playerData[playerid][pAge] = amount;
	}
	return 1;
}
Dialog:Register_Discord(playerid, response, listitem, inputtext[])
{
	new string[127];
	if (response)
	{
		if (isnull(inputtext))
			return Dialog_Show(playerid, Register_Discord, DIALOG_STYLE_INPUT, "{8D8DFF}Discord", "{FFFFFF}โปรดระบุชื่อ {8D8DFF}Discord {FFFFFF}ของคุณ อย่างเช่น {FFFF00}'h.wingin'\n\
		{FF6347}*โปรดตรวจสอบอย่างละเอียด เนื่องจากมีผลต่อตัวละครของคุณ", "ตกลง", "ยกเลิก");

		format(string, sizeof(string), "Diacord: %s", inputtext);
		PlayerTextDrawSetString(playerid, RegisterTD[playerid][9], string);
		RegisterDiscord[playerid] = 1;
	}
	return 1;
}
Dialog:Register_Email(playerid, response, listitem, inputtext[])
{
	new string[127];
	if (response)
	{
		if (isnull(inputtext))
			return Dialog_Show(playerid, Register_Email, DIALOG_STYLE_INPUT, "Email", "{FFFFFF}โปรดระบุชื่อ {FFA84D}Email {FFFFFF}ของคุณ อย่างเช่น {FFFF00}'HugoWingin26@gmail.com'\n\
			{FF6347}*โปรดตรวจสอบอย่างละเอียด เนื่องจากมีผลต่อตัวละครของคุณ", "ตกลง", "ยกเลิก");

		format(string, sizeof(string), "Email: %s", inputtext);
		PlayerTextDrawSetString(playerid, RegisterTD[playerid][10], string);
		RegisterEmail[playerid] = 1;
	}
	return 1;
}
hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if (playertextid == RegisterTD[playerid][1]) // เพศ
		return Dialog_Show(playerid, Register_Gender, DIALOG_STYLE_LIST, "เลือกเพศตัวละคร", "{FFFFFF}- Male (เพศชาย)\n- Female (เพศหญิง)", "ยืนยัน", "ยกเลิก");
	
	if (playertextid == RegisterTD[playerid][8]) // อายุ
		return Dialog_Show(playerid, Register_Age, DIALOG_STYLE_INPUT, "อายุตัวละคร", "{FFFFFF}โปรดระบุจำนวน {FFA84D}'อายุ' {FFFFFF}ของตัวละคร\n\
		*อายุต้องมากกว่า 18 และไม่เกิน 80 ปี", "ยืนยัน", "ยกเลิก");
	
	if (playertextid == RegisterTD[playerid][9]) // discord
		return Dialog_Show(playerid, Register_Discord, DIALOG_STYLE_INPUT, "Discord", "{FFFFFF}โปรดระบุชื่อ {8D8DFF}Discord {FFFFFF}ของคุณ อย่างเช่น {FFFF00}'h.wingin'\n\
		{FF6347}*โปรดตรวจสอบอย่างละเอียด เนื่องจากมีผลต่อตัวละครของคุณ", "ยืนยัน", "ยกเลิก");

	if (playertextid == RegisterTD[playerid][10]) // Email
		return Dialog_Show(playerid, Register_Email, DIALOG_STYLE_INPUT, "Email", "{FFFFFF}โปรดระบุชื่อ {FFA84D}Email {FFFFFF}ของคุณ อย่างเช่น {FFFF00}'HugoWingin26$gmail.com'\n\
		{FF6347}*โปรดตรวจสอบอย่างละเอียด เนื่องจากมีผลต่อตัวละครของคุณ\n\n{FFFFFF}*ไม่ประสงค์จะกรอกข้อมูลส่วนนี้ระบุเป็น: ขีด หรือ '-' เท่านั้น!", "ยืนยัน", "ยกเลิก");

	if (playertextid == RegisterTD[playerid][11]) // Cancel
		return HideplayerRegisterTD(playerid);

	if (playertextid == RegisterTD[playerid][12]) // sign up
	{
		if(playerData[playerid][pGender] == 0)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณยังไม่ได้เลือกเพศของตัวละคร โปรดเลือกก่อน");

		if(playerData[playerid][pAge] == 0)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณยังไม่ได้เลือกอายุของตัวละคร โปรดเลือกก่อน");

		if(RegisterDiscord[playerid] == 0)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณยังไม่ได้กรอกชื่อ 'Discord' ของคุณ");

		if(RegisterEmail[playerid] == 0)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณยังไม่ได้กรอก 'Email' ของคุณ");

		Dialog_Show(playerid, DIALOG_TUTORIALCONFIRM, DIALOG_STYLE_MSGBOX, "Confirm Character", "ลำดับที่: %d\nชื่อตัวละคร: %s\n\
		อายุตัวละคร: %d\n{FFA84D}*กรุณาตรวจสอบอย่างถี่ถ้วนก่อนที่จะกดยืนยัน\
		", "ยืนยัน", "ยกเลิก", playerData[playerid][pID], GetPlayerNameEx(playerid), playerData[playerid][pAge]);
		return 1;
	}

	return 1;
}
Dialog:DIALOG_TUTORIALCONFIRM(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    TUTORIALCONFIRM(playerid);
		return 1;
	}
	return 1;
}


stock ReturnVIP(playerid)
{
	new name[32];
	if(playerData[playerid][pVip] == 0) format(name, sizeof(name), "None");
	else if(playerData[playerid][pVip] == 1) format(name, sizeof(name), "Bronze Member");
	else if(playerData[playerid][pVip] == 2) format(name, sizeof(name), "Silver Member");
	else if(playerData[playerid][pVip] == 3) format(name, sizeof(name), "Gold Member");
	else if(playerData[playerid][pVip] == 4) format(name, sizeof(name), "Platinum Member");
	return name;
}

Spawnplayer(playerid)
{
	SetSpawnInfo(playerid, NO_TEAM, playerData[playerid][pSkin], playerData[playerid][pPos_X], playerData[playerid][pPos_Y], playerData[playerid][pPos_Z], playerData[playerid][pPos_A], 0, 0, 0, 0, 0, 0);
	ClearPlayerChat(playerid, 20);

	TogglePlayerSpectating(playerid, 0);
	KillTimer(playerData[playerid][LoginTimer]);
	playerData[playerid][LoginTimer] = 0;
	playerData[playerid][IsLoggedIn] = true;

	SetPlayerSkin(playerid, playerData[playerid][pSkin]);
	playerData[playerid][IsLoggedIn] = true;	
}



forward OnPlayerLoaded(playerid);
public OnPlayerLoaded(playerid)
{
	if(cache_num_rows())
	{
		ShowDialog_Login(playerid);

		playerData[playerid][LoginTimer] = SetTimerEx("OnLoginTimeout", SECONDS_TO_LOGIN * 1000, false, "d", playerid);
	}
	else
	{
		ShowDialog_Register(playerid);
	}
	return 1;
}
//=============================================================================================================================================================================================

ShowDialog_Register(playerid)
{
	new head[512], str[512];
	format(head, sizeof(head), "{ffffff}Password Register");
    format(str, sizeof(str), "\n{FFFFFF}ชื่อ: {FF6347}%s\n{FFFFFF}คุณยังไม่ได้ลงทะเบียน ระบุรหัสผ่านที่คุณต้องการใช้ในการสมัคร\n{FFA84D}**รหัสผ่านจำเป็นต้องมากกว่า 6 ตัว", GetPlayerNameEx(playerid));
    Dialog_Show(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, head, str, "สมัครสมาชิก", "" );
	return 1;
}
Dialog:DIALOG_REGISTER(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		if (strlen(inputtext) <= 5)
		{
			ShowDialog_Register(playerid);
			return 1;
		}
		new buffer[129];
		WP_Hash(buffer, sizeof(buffer), inputtext);

		new query[321];
		mysql_format(g_SQL, query, sizeof query, "INSERT INTO `players` (`playerName`, `playerPassword`, `playerRegDate`) VALUES ('%e', '%s', '%e')", GetPlayerNameEx(playerid), buffer, ReturnDate());
		mysql_tquery(g_SQL, query, "OnPlayerRegister", "d", playerid);
	}
	return 1;
}

//=============================================================================================================================================================================================

Dialog:DIALOG_LOGIN(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณออกเกมสำเร็จ...");
		SendClientMessage(playerid, COLOR_LIGHTRED, "- ใช้คำสั่ง (/q) เพื่อออกจากหน้าต่างเกม");
		DelayedKick(playerid);
	}
	else
	{
	    SQL_AttemptLogin(playerid, inputtext);
	}
	return 1;
}
ShowDialog_Login(playerid)
{
	new head[512], str[512];
	format(head, sizeof(head), "{ffffff}Password Login");
    format(str, sizeof(str), "\n{FFFFFF}ชื่อ: {FFA84D}%s {FFFFFF}| {00FF00}Registered{FFFFFF}\nคุณได้ลงทะเบียนไว้แล้ว ระบุรหัสผ่านเพื่อเข้าสู่ระบบ", GetPlayerNameEx(playerid));
    Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, head, str, "เข้าสู่ระบบ", "" );
	return 1;
}

//=============================================================================================================================================================================================



stock IsRPName(const name[], max_underscores = 2)//ชื่อRp
{
    new underscores = 0;
    if (name[0] < 'A' || name[0] > 'Z') return false; // First letter is not capital
    for(new i = 1; i < strlen(name); i++)
    {
        if(name[i] != '_' && (name[i] < 'A' || name[i] > 'Z') && (name[i] < 'a' || name[i] > 'z')) return false; // a-zA-Z_
        if(name[i] == '_')
        {
            underscores++;
            if(underscores > max_underscores || i == strlen(name)) return false; // More underlines than limit, or underline at the last pos
            if(name[i + 1] < 'A' || name[i + 1] > 'Z') return false; // Not a capital letter after underline
        }
    }
    if (underscores == 0) return false; // No underline detected
    return true;
}
forward TUTORIALCONFIRM(playerid); //ของผู้เล่นใหม่
public TUTORIALCONFIRM(playerid)
{
	HideplayerRegisterTDD(playerid);

	playerData[playerid][IsLoggedIn] = true;
	playerData[playerid][pSpawnPoint] = 0;

	playerData[playerid][pInterior] = 0;
	playerData[playerid][pWorld] = 0;

	playerData[playerid][pTutorial] = 1;

	playerData[playerid][pThirsty] = 100;
	playerData[playerid][pHungry] = 100;

	playerData[playerid][pHealth] = 100.0;
	
	playerData[playerid][pMaxItem] = 20;
	playerData[playerid][pItemAmount] = 30;

	if(playerData[playerid][pGender] == 1)
		playerData[playerid][pSkins] = 289;

	if(playerData[playerid][pGender] == 2)
		playerData[playerid][pSkins] = 191;
	

	new tmp2[256];
	format(tmp2, sizeof(tmp2), "~w~Welcome~n~~y~   %s", GetPlayerNameEx(playerid));
	GameTextForPlayer(playerid, tmp2, 5000, 1);
	
	SetCameraBehindPlayer(playerid);

	GivePlayerMoneyEx(playerid, 5000); // 5000
	playerData[playerid][pBankMoney] = 5000;

	Inventory_Add(playerid, "Burger", 5);
	Inventory_Add(playerid, "Water", 5);

	UpdatePlayerRegister(playerid);
	ClearPlayerChat(playerid, 20);

	SetSpawnInfo(playerid, NO_TEAM, playerData[playerid][pSkin], playerData[playerid][pPos_X], playerData[playerid][pPos_Y], playerData[playerid][pPos_Z], playerData[playerid][pPos_A], 0, 0, 0, 0, 0, 0);
	SetPlayerColor(playerid, DEFAULT_COLOR);
	TogglePlayerSpectating(playerid, 0);

	return 1;
}
