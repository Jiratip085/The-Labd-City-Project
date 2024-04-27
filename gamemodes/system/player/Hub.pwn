
#include	<YSI_Coding\y_hooks>

new PlayerText:LogoTD[MAX_PLAYERS][2];
new PlayerText:BlackWoodsHubTD[MAX_PLAYERS][8];
new PlayerBar:PlayerStamina[MAX_PLAYERS][1];
new PlayerText:PaycheckTD[MAX_PLAYERS][6];
new PlayerText:DrivingLicenseTD[MAX_PLAYERS][4];


new Text:RevehTD[2];


hook OnPlayerConnect(playerid)
{
	BlackWoodsHubTD[playerid][0] = CreatePlayerTextDraw(playerid, 616.000000, 419.000000, "ld_pool:ball");
	PlayerTextDrawFont(playerid, BlackWoodsHubTD[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, BlackWoodsHubTD[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BlackWoodsHubTD[playerid][0], 20.000000, 22.000000);
	PlayerTextDrawSetOutline(playerid, BlackWoodsHubTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, BlackWoodsHubTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, BlackWoodsHubTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, BlackWoodsHubTD[playerid][0], 255);
	PlayerTextDrawBackgroundColor(playerid, BlackWoodsHubTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, BlackWoodsHubTD[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, BlackWoodsHubTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, BlackWoodsHubTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, BlackWoodsHubTD[playerid][0], 0);

	BlackWoodsHubTD[playerid][1] = CreatePlayerTextDraw(playerid, 616.000000, 418.000000, "ld_pool:ball");
	PlayerTextDrawFont(playerid, BlackWoodsHubTD[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, BlackWoodsHubTD[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BlackWoodsHubTD[playerid][1], 20.000000, 22.000000);
	PlayerTextDrawSetOutline(playerid, BlackWoodsHubTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, BlackWoodsHubTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, BlackWoodsHubTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, BlackWoodsHubTD[playerid][1], 1687547391);
	PlayerTextDrawBackgroundColor(playerid, BlackWoodsHubTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, BlackWoodsHubTD[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, BlackWoodsHubTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, BlackWoodsHubTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, BlackWoodsHubTD[playerid][1], 0);

	BlackWoodsHubTD[playerid][2] = CreatePlayerTextDraw(playerid, 593.000000, 419.000000, "ld_pool:ball");
	PlayerTextDrawFont(playerid, BlackWoodsHubTD[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, BlackWoodsHubTD[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BlackWoodsHubTD[playerid][2], 20.000000, 22.000000);
	PlayerTextDrawSetOutline(playerid, BlackWoodsHubTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, BlackWoodsHubTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, BlackWoodsHubTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, BlackWoodsHubTD[playerid][2], 255);
	PlayerTextDrawBackgroundColor(playerid, BlackWoodsHubTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, BlackWoodsHubTD[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, BlackWoodsHubTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, BlackWoodsHubTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, BlackWoodsHubTD[playerid][2], 0);

	BlackWoodsHubTD[playerid][3] = CreatePlayerTextDraw(playerid, 593.000000, 418.000000, "ld_pool:ball");
	PlayerTextDrawFont(playerid, BlackWoodsHubTD[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid, BlackWoodsHubTD[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BlackWoodsHubTD[playerid][3], 20.000000, 22.000000);
	PlayerTextDrawSetOutline(playerid, BlackWoodsHubTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, BlackWoodsHubTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, BlackWoodsHubTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, BlackWoodsHubTD[playerid][3], -764862721);
	PlayerTextDrawBackgroundColor(playerid, BlackWoodsHubTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, BlackWoodsHubTD[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, BlackWoodsHubTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, BlackWoodsHubTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, BlackWoodsHubTD[playerid][3], 0);

	BlackWoodsHubTD[playerid][4] = CreatePlayerTextDraw(playerid, 620.000000, 422.000000, "HUD:radar_datedrink");
	PlayerTextDrawFont(playerid, BlackWoodsHubTD[playerid][4], 4);
	PlayerTextDrawLetterSize(playerid, BlackWoodsHubTD[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BlackWoodsHubTD[playerid][4], 12.000000, 15.000000);
	PlayerTextDrawSetOutline(playerid, BlackWoodsHubTD[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, BlackWoodsHubTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, BlackWoodsHubTD[playerid][4], 2);
	PlayerTextDrawColor(playerid, BlackWoodsHubTD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, BlackWoodsHubTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, BlackWoodsHubTD[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, BlackWoodsHubTD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, BlackWoodsHubTD[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, BlackWoodsHubTD[playerid][4], 0);

	BlackWoodsHubTD[playerid][5] = CreatePlayerTextDraw(playerid, 596.500000, 420.500000, "HUD:radar_datefood");
	PlayerTextDrawFont(playerid, BlackWoodsHubTD[playerid][5], 4);
	PlayerTextDrawLetterSize(playerid, BlackWoodsHubTD[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BlackWoodsHubTD[playerid][5], 13.000000, 17.500000);
	PlayerTextDrawSetOutline(playerid, BlackWoodsHubTD[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, BlackWoodsHubTD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, BlackWoodsHubTD[playerid][5], 2);
	PlayerTextDrawColor(playerid, BlackWoodsHubTD[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, BlackWoodsHubTD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, BlackWoodsHubTD[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, BlackWoodsHubTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, BlackWoodsHubTD[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, BlackWoodsHubTD[playerid][5], 0);

	BlackWoodsHubTD[playerid][6] = CreatePlayerTextDraw(playerid, 602.750000, 407.000000, "100%");
	PlayerTextDrawFont(playerid, BlackWoodsHubTD[playerid][6], 2);
	PlayerTextDrawLetterSize(playerid, BlackWoodsHubTD[playerid][6], 0.150000, 1.100000);
	PlayerTextDrawTextSize(playerid, BlackWoodsHubTD[playerid][6], 16.500000, 15.500000);
	PlayerTextDrawSetOutline(playerid, BlackWoodsHubTD[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, BlackWoodsHubTD[playerid][6], 1);
	PlayerTextDrawAlignment(playerid, BlackWoodsHubTD[playerid][6], 2);
	PlayerTextDrawColor(playerid, BlackWoodsHubTD[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, BlackWoodsHubTD[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, BlackWoodsHubTD[playerid][6], 200);
	PlayerTextDrawUseBox(playerid, BlackWoodsHubTD[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, BlackWoodsHubTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, BlackWoodsHubTD[playerid][6], 1);

	BlackWoodsHubTD[playerid][7] = CreatePlayerTextDraw(playerid, 625.750000, 407.000000, "100%");
	PlayerTextDrawFont(playerid, BlackWoodsHubTD[playerid][7], 2);
	PlayerTextDrawLetterSize(playerid, BlackWoodsHubTD[playerid][7], 0.150000, 1.100000);
	PlayerTextDrawTextSize(playerid, BlackWoodsHubTD[playerid][7], 16.500000, 15.500000);
	PlayerTextDrawSetOutline(playerid, BlackWoodsHubTD[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, BlackWoodsHubTD[playerid][7], 1);
	PlayerTextDrawAlignment(playerid, BlackWoodsHubTD[playerid][7], 2);
	PlayerTextDrawColor(playerid, BlackWoodsHubTD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, BlackWoodsHubTD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, BlackWoodsHubTD[playerid][7], 200);
	PlayerTextDrawUseBox(playerid, BlackWoodsHubTD[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, BlackWoodsHubTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, BlackWoodsHubTD[playerid][7], 1);

	LogoTD[playerid][0] = CreatePlayerTextDraw(playerid, 600.000000, 3.000000, "Black");
	PlayerTextDrawFont(playerid, LogoTD[playerid][0], 0);
	PlayerTextDrawLetterSize(playerid, LogoTD[playerid][0], 0.449999, 2.000000);
	PlayerTextDrawTextSize(playerid, LogoTD[playerid][0], 16.500000, 50.000000);
	PlayerTextDrawSetOutline(playerid, LogoTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, LogoTD[playerid][0], 1);
	PlayerTextDrawAlignment(playerid, LogoTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, LogoTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, LogoTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, LogoTD[playerid][0], 200);
	PlayerTextDrawUseBox(playerid, LogoTD[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, LogoTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, LogoTD[playerid][0], 0);

	LogoTD[playerid][1] = CreatePlayerTextDraw(playerid, 617.000000, 19.000000, "Woods");
	PlayerTextDrawFont(playerid, LogoTD[playerid][1], 0);
	PlayerTextDrawLetterSize(playerid, LogoTD[playerid][1], 0.449999, 2.000000);
	PlayerTextDrawTextSize(playerid, LogoTD[playerid][1], 16.500000, 50.000000);
	PlayerTextDrawSetOutline(playerid, LogoTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, LogoTD[playerid][1], 1);
	PlayerTextDrawAlignment(playerid, LogoTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, LogoTD[playerid][1], 9109759);
	PlayerTextDrawBackgroundColor(playerid, LogoTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, LogoTD[playerid][1], 200);
	PlayerTextDrawUseBox(playerid, LogoTD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, LogoTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, LogoTD[playerid][1], 0);

	PaycheckTD[playerid][0] = CreatePlayerTextDraw(playerid, 595.000000, 165.000000, "_");
	PlayerTextDrawFont(playerid, PaycheckTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, PaycheckTD[playerid][0], 0.612500, 6.000000);
	PlayerTextDrawTextSize(playerid, PaycheckTD[playerid][0], 298.500000, 80.500000);
	PlayerTextDrawSetOutline(playerid, PaycheckTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, PaycheckTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, PaycheckTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, PaycheckTD[playerid][0], -120);
	PlayerTextDrawBackgroundColor(playerid, PaycheckTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, PaycheckTD[playerid][0], 75);
	PlayerTextDrawUseBox(playerid, PaycheckTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, PaycheckTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, PaycheckTD[playerid][0], 0);

	PaycheckTD[playerid][1] = CreatePlayerTextDraw(playerid, 595.000000, 165.000000, "Paycheck");
	PlayerTextDrawFont(playerid, PaycheckTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, PaycheckTD[playerid][1], 0.250000, 1.500000);
	PlayerTextDrawTextSize(playerid, PaycheckTD[playerid][1], 16.500000, 80.000000);
	PlayerTextDrawSetOutline(playerid, PaycheckTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, PaycheckTD[playerid][1], 2);
	PlayerTextDrawAlignment(playerid, PaycheckTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, PaycheckTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, PaycheckTD[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, PaycheckTD[playerid][1], 75);
	PlayerTextDrawUseBox(playerid, PaycheckTD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, PaycheckTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, PaycheckTD[playerid][1], 0);

	PaycheckTD[playerid][2] = CreatePlayerTextDraw(playerid, 595.000000, 184.000000, "_");
	PlayerTextDrawFont(playerid, PaycheckTD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, PaycheckTD[playerid][2], 0.200000, -0.250001);
	PlayerTextDrawTextSize(playerid, PaycheckTD[playerid][2], 298.500000, 80.500000);
	PlayerTextDrawSetOutline(playerid, PaycheckTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, PaycheckTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, PaycheckTD[playerid][2], 2);
	PlayerTextDrawColor(playerid, PaycheckTD[playerid][2], 9109640);
	PlayerTextDrawBackgroundColor(playerid, PaycheckTD[playerid][2], 9109759);
	PlayerTextDrawBoxColor(playerid, PaycheckTD[playerid][2], 9109619);
	PlayerTextDrawUseBox(playerid, PaycheckTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, PaycheckTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, PaycheckTD[playerid][2], 0);

	PaycheckTD[playerid][3] = CreatePlayerTextDraw(playerid, 555.000000, 187.000000, "Name: Ethylene Muhammad");
	PlayerTextDrawFont(playerid, PaycheckTD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, PaycheckTD[playerid][3], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid, PaycheckTD[playerid][3], 635.000000, 138.000000);
	PlayerTextDrawSetOutline(playerid, PaycheckTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, PaycheckTD[playerid][3], 1);
	PlayerTextDrawAlignment(playerid, PaycheckTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, PaycheckTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, PaycheckTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, PaycheckTD[playerid][3], -16777166);
	PlayerTextDrawUseBox(playerid, PaycheckTD[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, PaycheckTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, PaycheckTD[playerid][3], 0);

	PaycheckTD[playerid][4] = CreatePlayerTextDraw(playerid, 555.000000, 197.000000, "Hours: 165");
	PlayerTextDrawFont(playerid, PaycheckTD[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, PaycheckTD[playerid][4], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid, PaycheckTD[playerid][4], 635.000000, 138.000000);
	PlayerTextDrawSetOutline(playerid, PaycheckTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, PaycheckTD[playerid][4], 1);
	PlayerTextDrawAlignment(playerid, PaycheckTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, PaycheckTD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, PaycheckTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, PaycheckTD[playerid][4], -16777166);
	PlayerTextDrawUseBox(playerid, PaycheckTD[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, PaycheckTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, PaycheckTD[playerid][4], 0);

	PaycheckTD[playerid][5] = CreatePlayerTextDraw(playerid, 555.000000, 207.000000, "Paycheck: $2,780");
	PlayerTextDrawFont(playerid, PaycheckTD[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, PaycheckTD[playerid][5], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid, PaycheckTD[playerid][5], 635.000000, 138.000000);
	PlayerTextDrawSetOutline(playerid, PaycheckTD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, PaycheckTD[playerid][5], 1);
	PlayerTextDrawAlignment(playerid, PaycheckTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, PaycheckTD[playerid][5], 9109759);
	PlayerTextDrawBackgroundColor(playerid, PaycheckTD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, PaycheckTD[playerid][5], -16777166);
	PlayerTextDrawUseBox(playerid, PaycheckTD[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, PaycheckTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, PaycheckTD[playerid][5], 0);

	DrivingLicenseTD[playerid][0] = CreatePlayerTextDraw(playerid, 593.000000, 230.000000, "_");
	PlayerTextDrawFont(playerid, DrivingLicenseTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, DrivingLicenseTD[playerid][0], 0.600000, 6.300001);
	PlayerTextDrawTextSize(playerid, DrivingLicenseTD[playerid][0], 298.500000, 85.000000);
	PlayerTextDrawSetOutline(playerid, DrivingLicenseTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, DrivingLicenseTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, DrivingLicenseTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, DrivingLicenseTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, DrivingLicenseTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, DrivingLicenseTD[playerid][0], 120);
	PlayerTextDrawUseBox(playerid, DrivingLicenseTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, DrivingLicenseTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, DrivingLicenseTD[playerid][0], 0);

	DrivingLicenseTD[playerid][1] = CreatePlayerTextDraw(playerid, 593.000000, 226.000000, "Driving License");
	PlayerTextDrawFont(playerid, DrivingLicenseTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, DrivingLicenseTD[playerid][1], 0.300000, 1.750000);
	PlayerTextDrawTextSize(playerid, DrivingLicenseTD[playerid][1], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, DrivingLicenseTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, DrivingLicenseTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, DrivingLicenseTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, DrivingLicenseTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, DrivingLicenseTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, DrivingLicenseTD[playerid][1], 200);
	PlayerTextDrawUseBox(playerid, DrivingLicenseTD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, DrivingLicenseTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, DrivingLicenseTD[playerid][1], 0);

	DrivingLicenseTD[playerid][2] = CreatePlayerTextDraw(playerid, 593.000000, 244.000000, "_");
	PlayerTextDrawFont(playerid, DrivingLicenseTD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, DrivingLicenseTD[playerid][2], 0.600000, -0.200000);
	PlayerTextDrawTextSize(playerid, DrivingLicenseTD[playerid][2], 298.500000, 85.000000);
	PlayerTextDrawSetOutline(playerid, DrivingLicenseTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, DrivingLicenseTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, DrivingLicenseTD[playerid][2], 2);
	PlayerTextDrawColor(playerid, DrivingLicenseTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, DrivingLicenseTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, DrivingLicenseTD[playerid][2], 9109679);
	PlayerTextDrawUseBox(playerid, DrivingLicenseTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, DrivingLicenseTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, DrivingLicenseTD[playerid][2], 0);

	DrivingLicenseTD[playerid][3] = CreatePlayerTextDraw(playerid, 551.000000, 246.000000, "Name: Hugo_Wingin~n~Age: 31~n~Driving License: ~g~Yes");
	PlayerTextDrawFont(playerid, DrivingLicenseTD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, DrivingLicenseTD[playerid][3], 0.208333, 1.100000);
	PlayerTextDrawTextSize(playerid, DrivingLicenseTD[playerid][3], 635.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, DrivingLicenseTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, DrivingLicenseTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, DrivingLicenseTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, DrivingLicenseTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, DrivingLicenseTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, DrivingLicenseTD[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, DrivingLicenseTD[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, DrivingLicenseTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, DrivingLicenseTD[playerid][3], 0);

	RevehTD[0] = TextDrawCreate(589.000000, 128.000000, "Respawn Vehicle: 00:00");
	TextDrawFont(RevehTD[0], 2);
	TextDrawLetterSize(RevehTD[0], 0.21000, 1.750000);
	TextDrawTextSize(RevehTD[0], 16.500000, 90.500000);
	TextDrawSetOutline(RevehTD[0], 1);
	TextDrawSetShadow(RevehTD[0], 0);
	TextDrawAlignment(RevehTD[0], 2);
	TextDrawColor(RevehTD[0], -1);
	TextDrawBackgroundColor(RevehTD[0], 255);
	TextDrawBoxColor(RevehTD[0], 200);
	TextDrawUseBox(RevehTD[0], 1);
	TextDrawSetProportional(RevehTD[0], 1);
	TextDrawSetSelectable(RevehTD[0], 0);

	RevehTD[1] = TextDrawCreate(542.000000, 128.000000, "_");
	TextDrawFont(RevehTD[1], 1);
	TextDrawLetterSize(RevehTD[1], 0.600000, 1.749999);
	TextDrawTextSize(RevehTD[1], 298.500000, 0.250000);
	TextDrawSetOutline(RevehTD[1], 1);
	TextDrawSetShadow(RevehTD[1], 0);
	TextDrawAlignment(RevehTD[1], 2);
	TextDrawColor(RevehTD[1], 9109759);
	TextDrawBackgroundColor(RevehTD[1], 255);
	TextDrawBoxColor(RevehTD[1], 9109759);
	TextDrawUseBox(RevehTD[1], 1);
	TextDrawSetProportional(RevehTD[1], 1);
	TextDrawSetSelectable(RevehTD[1], 0);

    for (new i = 0; i < 2; i ++) {
        PlayerTextDrawShow(playerid, LogoTD[playerid][i]);
    }

	PlayerStamina[playerid][0] = CreatePlayerProgressBar(playerid, 259.000000, 441.000000, 120.000000, 2.000000, -1, 200.000000, 0);
	SetPlayerProgressBarValue(playerid, PlayerStamina[playerid][0], 50.000000);
    return 1;
}

ShowPlayerPaycheck(playerid) //Paycheck
{
	if (!playerData[playerid][IsLoggedIn])
		return 0;

    for (new i = 0; i < 6; i ++) {
        PlayerTextDrawShow(playerid, PaycheckTD[playerid][i]);
    }
	return 1;
}
HidePlayerPaycheck(playerid) //Paycheck
{
	if (!playerData[playerid][IsLoggedIn])
		return 0;

    for (new i = 0; i < 6; i ++) {
        PlayerTextDrawHide(playerid, PaycheckTD[playerid][i]);
    }
	return 1;
}
ShowPlayerDrivingLincese(playerid) //Driving Lincese
{
	if (!playerData[playerid][IsLoggedIn])
		return 0;

    for (new i = 0; i < 4; i ++) {
        PlayerTextDrawShow(playerid, DrivingLicenseTD[playerid][i]);
    }
	return 1;
}
HidePlayerDrivingLincese(playerid) //Driving Lincese
{
	if (!playerData[playerid][IsLoggedIn])
		return 0;

    for (new i = 0; i < 4; i ++) {
        PlayerTextDrawHide(playerid, DrivingLicenseTD[playerid][i]);
    }
	return 1;
}
BlacoWoods_ShowPlayerStats(playerid) //Show Logo
{
	if (!playerData[playerid][IsLoggedIn])
		return 0;

    for (new i = 0; i < 8; i ++) {
        PlayerTextDrawShow(playerid, BlackWoodsHubTD[playerid][i]);
    }
	return 1;
}
BlacoWoods_HidePlayerStats(playerid) // Hide Logo
{
	if (!playerData[playerid][IsLoggedIn])
		return 0;

    for (new i = 0; i < 8; i ++) {
        PlayerTextDrawHide(playerid, BlackWoodsHubTD[playerid][i]);
    }
	DestroyPlayerProgressBar(playerid, PlayerStamina[playerid][0]);
	return 1;
}
ptask StaminaTimr[5000](playerid)
{
	if(GetPlayerStamina(playerid) == GetPlayerMaxStamina(playerid))
	{
		HidePlayerProgressBar(playerid, PlayerStamina[playerid][0]);
	}
	return 1;
}
ptask Ironpie_StatsTimer[200](playerid)
{
    new string[108];

	if (!playerData[playerid][IsLoggedIn])
		return 0;

	
	if(GetPlayerStamina(playerid) >= 175) //
	{
    	SetPlayerProgressBarColour(playerid, PlayerStamina[playerid][0], -1);
	}
	if(GetPlayerStamina(playerid) <= 174) //เขียว
	{
    	SetPlayerProgressBarColour(playerid, PlayerStamina[playerid][0], 16711935);
	}
	if(GetPlayerStamina(playerid) <= 150) //เขียวอ่อน
	{
    	SetPlayerProgressBarColour(playerid, PlayerStamina[playerid][0], 9109759);
	}
	if(GetPlayerStamina(playerid) <= 125) //เหลืองสว่าง
	{
    	SetPlayerProgressBarColour(playerid, PlayerStamina[playerid][0], -65281);
	}
	if(GetPlayerStamina(playerid) <= 100) //ส้มสว่าง
	{
    	SetPlayerProgressBarColour(playerid, PlayerStamina[playerid][0], -328858625);
	}
	if(GetPlayerStamina(playerid) <= 75) //ส้ม
	{
    	SetPlayerProgressBarColour(playerid, PlayerStamina[playerid][0], -764862721);
	}
	if(GetPlayerStamina(playerid) <= 20) //แดง
	{
    	SetPlayerProgressBarColour(playerid, PlayerStamina[playerid][0], -16776961);
	}
	if(GetPlayerStamina(playerid) <= 25) //แดงดำ
	{
    	SetPlayerProgressBarColour(playerid, PlayerStamina[playerid][0], -1962934017);
	}

	SetPlayerProgressBarValue(playerid, PlayerStamina[playerid][0], GetPlayerStamina(playerid));
	
 	format(string, sizeof(string), "%0.0f%", playerData[playerid][pHungry]); // Thirsty
	PlayerTextDrawSetString(playerid, BlackWoodsHubTD[playerid][6], string);

 	format(string, sizeof(string), "%0.0f%", playerData[playerid][pThirsty]); // Hungry
	PlayerTextDrawSetString(playerid, BlackWoodsHubTD[playerid][7], string);
 	/*format(string, sizeof(string), "%0.0f/100", playerData[playerid][pHungry]); // Hungry
	PlayerTextDrawSetString(playerid, BlackWoodsHud[playerid][3], string);

 	format(string, sizeof(string), "%0.0f/100", playerData[playerid][pThirsty]); // Thirsty*/
	return 1;
}

ptask PlayerTimerPayday[60*1000](playerid)
{
	new string[128];

	if (!playerData[playerid][IsLoggedIn]) return 0;

	playerData[playerid][pMinutes]++;

	if (playerData[playerid][pMinutes] >= 60)
	{
		new NewbiePaycheck = randomEx(1500, 2500), 
			AgencyPaycheck = randomEx(1000, 1500), 
			Paycheck = randomEx(500, 999);

		ShowPlayerPaycheck(playerid);	
		SetTimerEx("PaycheckTimer", 10000, 0, "id", playerid);
		
		if(playerData[playerid][pHours] <= 10) //Paycheck เด็กใหม่
		{
			playerData[playerid][pHours]++;
			playerData[playerid][pMinutes] = 0;

			playerData[playerid][pBankMoney] += NewbiePaycheck;

			format(string, sizeof(string), "Name: %s", GetPlayerNameEx(playerid)); // Name
			PlayerTextDrawSetString(playerid, PaycheckTD[playerid][3], string);

			format(string, sizeof(string), "Hours: %d", playerData[playerid][pHours]); // Hours
			PlayerTextDrawSetString(playerid, PaycheckTD[playerid][4], string);

			format(string, sizeof(string), "Paycheck: %s", FormatMoney(NewbiePaycheck)); // Paycheck
			PlayerTextDrawSetString(playerid, PaycheckTD[playerid][5], string);
			SendClientMessageEx(playerid, COLOR_GREEN, "[Paycheck] คุณออนไลน์ครบชั่วโมง, และได้รับ Paycheck 'สำหรับเด็กใหม่' จำนวน %s", FormatMoney(NewbiePaycheck));
			return 1;
		}
		if(GetFactionType(playerid) == FACTION_POLICE || GetFactionType(playerid) == FACTION_MEDIC || GetFactionType(playerid) == FACTION_GOV) //Paycheck หน่วยงาน
		{
			playerData[playerid][pHours]++;
			playerData[playerid][pMinutes] = 0;

			playerData[playerid][pBankMoney] += AgencyPaycheck;
			format(string, sizeof(string), "Name: %s", GetPlayerNameEx(playerid)); // Name
			PlayerTextDrawSetString(playerid, PaycheckTD[playerid][3], string);

			format(string, sizeof(string), "Hours: %d", playerData[playerid][pHours]); // Hours
			PlayerTextDrawSetString(playerid, PaycheckTD[playerid][4], string);

			format(string, sizeof(string), "Paycheck: %s", FormatMoney(AgencyPaycheck)); // Paycheck
			PlayerTextDrawSetString(playerid, PaycheckTD[playerid][5], string);
			SendClientMessageEx(playerid, COLOR_GREEN, "[Paycheck] คุณออนไลน์ครบชั่วโมง, และได้รับ Paycheck 'สำหรับหน่วยงาน' จำนวน %s", FormatMoney(AgencyPaycheck));
			return 1;
		}
	    playerData[playerid][pHours]++;
	    playerData[playerid][pMinutes] = 0;

		playerData[playerid][pBankMoney] += Paycheck;
		format(string, sizeof(string), "Name: %s", GetPlayerNameEx(playerid)); // Name
		PlayerTextDrawSetString(playerid, PaycheckTD[playerid][3], string);

		format(string, sizeof(string), "Hours: %d", playerData[playerid][pHours]); // Hours
		PlayerTextDrawSetString(playerid, PaycheckTD[playerid][4], string);

		format(string, sizeof(string), "Paycheck: %s", FormatMoney(Paycheck)); // Paycheck
		PlayerTextDrawSetString(playerid, PaycheckTD[playerid][5], string);
		SendClientMessageEx(playerid, COLOR_GREEN, "[Paycheck] คุณออนไลน์ครบชั่วโมง, และได้รับ Paycheck 'สำหรับประชาชน' จำนวน %s", FormatMoney(Paycheck));
	}
    return 1;
}

forward PaycheckTimer(playerid, type);
public PaycheckTimer(playerid, type)
{
	HidePlayerPaycheck(playerid);
}

hook OnPlayerDisconnect(playerid, reason)
{
    for (new i = 0; i < 2; i ++) {
        PlayerTextDrawShow(playerid, LogoTD[playerid][i]);
    }
	return 1;
}
