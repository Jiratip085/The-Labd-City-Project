#include	<YSI_Coding\y_hooks>


new PlayerText:ShopTD[MAX_PLAYERS][22];


new bool:StartCraftGunPowder[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
	StartCraftGunPowder[playerid] = false;

	ShopTD[playerid][0] = CreatePlayerTextDraw(playerid, 396.000000, 140.000000, "_");
	PlayerTextDrawFont(playerid, ShopTD[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][0], 0.600000, 7.750021);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][0], 298.500000, 146.500000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, ShopTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][0], 100);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][0], 0);

	ShopTD[playerid][1] = CreatePlayerTextDraw(playerid, 243.000000, 140.000000, "_");
	PlayerTextDrawFont(playerid, ShopTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][1], 0.600000, 25.000022);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][1], 298.500000, 146.500000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, ShopTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][1], 100);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][1], 0);

	ShopTD[playerid][2] = CreatePlayerTextDraw(playerid, 243.000000, 140.000000, "Equipment Store");
	PlayerTextDrawFont(playerid, ShopTD[playerid][2], 2);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][2], 0.320832, 1.500000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][2], 16.500000, 146.000000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][2], 2);
	PlayerTextDrawColor(playerid, ShopTD[playerid][2], -1094795521);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][2], 1296911816);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][2], 0);

	ShopTD[playerid][3] = CreatePlayerTextDraw(playerid, 243.000000, 165.000000, "_");
	PlayerTextDrawFont(playerid, ShopTD[playerid][3], 2);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][3], 0.600000, 5.000030);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][3], 298.500000, 130.000000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][3], 2);
	PlayerTextDrawColor(playerid, ShopTD[playerid][3], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][3], 1296911776);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][3], 1);

	ShopTD[playerid][4] = CreatePlayerTextDraw(playerid, 243.000000, 220.000000, "_");
	PlayerTextDrawFont(playerid, ShopTD[playerid][4], 2);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][4], 0.600000, 5.000030);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][4], 298.500000, 130.000000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][4], 2);
	PlayerTextDrawColor(playerid, ShopTD[playerid][4], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][4], 1296911776);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][4], 1);

	ShopTD[playerid][5] = CreatePlayerTextDraw(playerid, 243.000000, 275.500000, "_");
	PlayerTextDrawFont(playerid, ShopTD[playerid][5], 2);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][5], 0.600000, 5.000030);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][5], 298.500000, 130.000000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][5], 2);
	PlayerTextDrawColor(playerid, ShopTD[playerid][5], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][5], 1296911776);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][5], 1);

	ShopTD[playerid][6] = CreatePlayerTextDraw(playerid, 243.000000, 330.000000, "$: -");
	PlayerTextDrawFont(playerid, ShopTD[playerid][6], 2);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][6], 0.304165, 1.500000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][6], 16.500000, 131.500000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][6], 2);
	PlayerTextDrawColor(playerid, ShopTD[playerid][6], -1094795521);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][6], 1296911776);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][6], 0);

	ShopTD[playerid][7] = CreatePlayerTextDraw(playerid, 243.000000, 352.000000, "1 / 1");
	PlayerTextDrawFont(playerid, ShopTD[playerid][7], 2);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][7], 0.304165, 1.500000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][7], 16.500000, 131.500000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][7], 2);
	PlayerTextDrawColor(playerid, ShopTD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][7], 1296911776);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][7], 0);

	ShopTD[playerid][8] = CreatePlayerTextDraw(playerid, 449.000000, 194.500000, "Buy");
	PlayerTextDrawFont(playerid, ShopTD[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][8], 0.304165, 1.500000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][8], 16.500000, 36.500000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][8], 2);
	PlayerTextDrawColor(playerid, ShopTD[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][8], 9109604);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][8], 1);

	ShopTD[playerid][9] = CreatePlayerTextDraw(playerid, 178.000000, 220.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, ShopTD[playerid][9], 5);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][9], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][9], 39.000000, 45.000000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, ShopTD[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][9], -741092533);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][9], 1296911871);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][9], 0);
	PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 18631);
	PlayerTextDrawSetPreviewRot(playerid, ShopTD[playerid][9], -15.000000, 0.000000, -30.000000, 0.899999);
	PlayerTextDrawSetPreviewVehCol(playerid, ShopTD[playerid][9], 1, 1);

	ShopTD[playerid][10] = CreatePlayerTextDraw(playerid, 178.000000, 164.500000, "Preview_Model");
	PlayerTextDrawFont(playerid, ShopTD[playerid][10], 5);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][10], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][10], 39.000000, 45.000000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, ShopTD[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][10], -741092533);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][10], 1296911871);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][10], 0);
	PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 18631);
	PlayerTextDrawSetPreviewRot(playerid, ShopTD[playerid][10], -15.000000, 0.000000, -30.000000, 0.899999);
	PlayerTextDrawSetPreviewVehCol(playerid, ShopTD[playerid][10], 1, 1);

	ShopTD[playerid][11] = CreatePlayerTextDraw(playerid, 178.000000, 275.500000, "Preview_Model");
	PlayerTextDrawFont(playerid, ShopTD[playerid][11], 5);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][11], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][11], 39.000000, 45.000000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, ShopTD[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][11], -741092533);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][11], 1296911871);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][11], 0);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][11], 0);
	PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 18631);
	PlayerTextDrawSetPreviewRot(playerid, ShopTD[playerid][11], -15.000000, 0.000000, -30.000000, 0.899999);
	PlayerTextDrawSetPreviewVehCol(playerid, ShopTD[playerid][11], 1, 1);

	ShopTD[playerid][12] = CreatePlayerTextDraw(playerid, 323.000000, 163.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, ShopTD[playerid][12], 5);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][12], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][12], 39.000000, 45.000000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][12], 1);
	PlayerTextDrawColor(playerid, ShopTD[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][12], -741092533);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][12], 1296911871);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][12], 0);
	PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 18631);
	PlayerTextDrawSetPreviewRot(playerid, ShopTD[playerid][12], -15.000000, 0.000000, -30.000000, 0.899999);
	PlayerTextDrawSetPreviewVehCol(playerid, ShopTD[playerid][12], 1, 1);

	ShopTD[playerid][13] = CreatePlayerTextDraw(playerid, 396.000000, 140.000000, "select");
	PlayerTextDrawFont(playerid, ShopTD[playerid][13], 2);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][13], 0.320832, 1.500000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][13], 16.500000, 146.500000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][13], 2);
	PlayerTextDrawColor(playerid, ShopTD[playerid][13], -1094795521);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][13], 1296911816);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][13], 0);

	ShopTD[playerid][14] = CreatePlayerTextDraw(playerid, 463.000000, 139.500000, "X");
	PlayerTextDrawFont(playerid, ShopTD[playerid][14], 1);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][14], 0.399998, 1.500000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][14], 16.500000, 13.000000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][14], 1);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][14], 2);
	PlayerTextDrawColor(playerid, ShopTD[playerid][14], -1962934017);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][14], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][14], -1962934122);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][14], 1);

	ShopTD[playerid][15] = CreatePlayerTextDraw(playerid, 364.000000, 162.000000, "Select");
	PlayerTextDrawFont(playerid, ShopTD[playerid][15], 1);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][15], 0.304165, 1.500000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][15], 470.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, ShopTD[playerid][15], -741092353);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][15], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][15], 1296911776);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][15], 0);

	ShopTD[playerid][16] = CreatePlayerTextDraw(playerid, 364.000000, 176.000000, "Select the item on the left-hand side..");
	PlayerTextDrawFont(playerid, ShopTD[playerid][16], 1);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][16], 0.183331, 1.000000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][16], 426.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, ShopTD[playerid][16], -741092353);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][16], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][16], 1296911776);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][16], 0);

	ShopTD[playerid][17] = CreatePlayerTextDraw(playerid, 258.000000, 352.000000, "ld_beat:right");
	PlayerTextDrawFont(playerid, ShopTD[playerid][17], 4);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][17], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][17], 13.000000, 12.000000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, ShopTD[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][17], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][17], 50);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][17], 1);

	ShopTD[playerid][18] = CreatePlayerTextDraw(playerid, 218.000000, 352.000000, "ld_beat:left");
	PlayerTextDrawFont(playerid, ShopTD[playerid][18], 4);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][18], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][18], 13.000000, 12.000000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][18], 1);
	PlayerTextDrawColor(playerid, ShopTD[playerid][18], -1);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][18], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][18], 50);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][18], 1);

	ShopTD[playerid][19] = CreatePlayerTextDraw(playerid, 220.000000, 165.000000, "item 1");
	PlayerTextDrawFont(playerid, ShopTD[playerid][19], 1);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][19], 0.304165, 1.500000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][19], 426.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][19], 1);
	PlayerTextDrawColor(playerid, ShopTD[playerid][19], -741092353);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][19], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][19], 1296911776);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][19], 0);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][19], 0);

	ShopTD[playerid][20] = CreatePlayerTextDraw(playerid, 220.000000, 220.000000, "item 2");
	PlayerTextDrawFont(playerid, ShopTD[playerid][20], 1);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][20], 0.304165, 1.500000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][20], 426.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][20], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][20], 1);
	PlayerTextDrawColor(playerid, ShopTD[playerid][20], -741092353);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][20], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][20], 1296911776);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][20], 0);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][20], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][20], 0);

	ShopTD[playerid][21] = CreatePlayerTextDraw(playerid, 220.000000, 276.000000, "item 3");
	PlayerTextDrawFont(playerid, ShopTD[playerid][21], 1);
	PlayerTextDrawLetterSize(playerid, ShopTD[playerid][21], 0.304165, 1.500000);
	PlayerTextDrawTextSize(playerid, ShopTD[playerid][21], 426.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ShopTD[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, ShopTD[playerid][21], 0);
	PlayerTextDrawAlignment(playerid, ShopTD[playerid][21], 1);
	PlayerTextDrawColor(playerid, ShopTD[playerid][21], -741092353);
	PlayerTextDrawBackgroundColor(playerid, ShopTD[playerid][21], 255);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][21], 1296911776);
	PlayerTextDrawUseBox(playerid, ShopTD[playerid][21], 0);
	PlayerTextDrawSetProportional(playerid, ShopTD[playerid][21], 1);
	PlayerTextDrawSetSelectable(playerid, ShopTD[playerid][21], 0);

	return 1;
}

new ShopItemPage[MAX_PLAYERS];
new ShopItemSelect[MAX_PLAYERS];

new bool:StartCraftFishingBait[MAX_PLAYERS];
new bool:StartCraftToolBox[MAX_PLAYERS];
new bool:StartCraftCrowbar[MAX_PLAYERS];
new bool:StartCraftMetal[MAX_PLAYERS];



hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) //�� 'Y' ���͡����
{
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
		if (Shop_Nearest(playerid) != -1)
		{
			new shopid = Shop_Nearest(playerid);
			PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
			if(shopData[shopid][shopType] == 1 || shopData[shopid][shopType] == 3 || shopData[shopid][shopType] == 4 || shopData[shopid][shopType] == 5 ||
			shopData[shopid][shopType] == 7 || shopData[shopid][shopType] == 8 || shopData[shopid][shopType] == 9)
			{
				ShopItemPage[playerid] = 0;
				SelectTextDraw(playerid, COLOR_WHITE);
			    ShowShopEquipmentTD(playerid);
			}
			if(shopData[shopid][shopType] == 2) // ��ѧ�Թ�׹
			{
				PlayerPlaySound(playerid, 1135, 0.0, 0.0, 0.0);
				if(playerData[playerid][pPowderMax] <= 0)

					return Dialog_Show(playerid, Craft_GunPowder, DIALOG_STYLE_TABLIST_HEADERS, "��ѧ�纴Թ�׹", "�ػ�ó�����\t�ӹǹ{FFFFFF}\n\
					- WoodPacks\t%d / 50 {FFA84D}(���㹵��)\n\
					{FFFFFF}- Iron\t%d / 50 {FFA84D}(���㹵��)\n\
					[+] ���ҧ��ѧ�Թ�׹ (50 �����繵�)", "���ҧ", "¡��ԡ", Inventory_Count(playerid, "WoodPacks"), Inventory_Count(playerid, "Iron"));

				
				
				Dialog_Show(playerid, GunPowder, DIALOG_STYLE_LIST, "��ѧ�纴Թ�׹", "{FFFFFF}�Թ�׹㹤�ѧ: %s / %s ����{FFA84D}\t[Upgrade]\n\
				- �ҡ��Ҥ�ѧ\n\
				- �ԡ�͡�ҡ��ѧ\
				", "���͡", "¡��ԡ", FormatNumber(playerData[playerid][pPowder]), FormatNumber(playerData[playerid][pPowderMax]));
				PlayerPlaySound(playerid, 1135, 0.0, 0.0, 0.0);
				return 1; 
			}
		}
    }
    return 1;
}

ShowShopEquipmentTD(playerid) 
{
	new str[1028], shopid = Shop_Nearest(playerid);

	if (!playerData[playerid][IsLoggedIn])
		return 0;
        
    if (shopData[shopid][shopType] == 1) //Format Equipment Store
    {
		format(str, sizeof(str), "Equipment Store"); // ������ҹ
		PlayerTextDrawSetString(playerid, ShopTD[playerid][2], str);

		if(ShopItemPage[playerid] == 0) //˹�ҷ�� 1
		{
			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 18635); // Model item 1 ��͹
			format(str, sizeof(str), "Hammer"); // ���� item 1 
			PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 341); // Model item 2 ������
			format(str, sizeof(str), "Chainsaw"); // ���� item 2
			PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 18632); // Model item 3 Fishing Rod
			format(str, sizeof(str), "Fishing Rod"); // ���� item 2
			PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

			format(str, sizeof(str), "1 / 3"); // ˹�� page
			PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);

		}
		if(ShopItemPage[playerid] == 1) //˹�ҷ�� 2
		{
			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 19639); // Model item ������
			format(str, sizeof(str), "Crate"); // ���� item 1
			PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 335); // Model item 2
			format(str, sizeof(str), "Knife"); // ���� item 2
			PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 18631); // Model item 3
			format(str, sizeof(str), "item 6"); // ���� item 2
			PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

			format(str, sizeof(str), "2 / 3"); // ˹�� page
			PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);

		}
		if(ShopItemPage[playerid] == 2) //˹�ҷ�� 3
		{
			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 18631); // Model item 1
			format(str, sizeof(str), "item 7"); // ���� item 1
			PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 18631); // Model item 2
			format(str, sizeof(str), "item 8"); // ���� item 2
			PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 18631); // Model item 3
			format(str, sizeof(str), "item 9"); // ���� item 2
			PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

			format(str, sizeof(str), "3 / 3"); // ˹�� page
			PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
		}
    }
	if (shopData[shopid][shopType] == 3) //��ҹ�������ͼ��
	{
		format(str, sizeof(str), "Skin Shop"); // ������ҹ
		PlayerTextDrawSetString(playerid, ShopTD[playerid][2], str);

		if(playerData[playerid][pGender] == 1) //����ͼ�Ҽ����
		{
			if(ShopItemPage[playerid] == 0) //˹�ҷ�� 0
			{
				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 7);
				format(str, sizeof(str), "Skin: 7"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 14);
				format(str, sizeof(str), "Skin: 14"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 20);
				format(str, sizeof(str), "Skin: 20"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

				format(str, sizeof(str), "1 / 9"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
			}
			if(ShopItemPage[playerid] == 1) //˹�ҷ�� 1
			{
				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 22); 
				format(str, sizeof(str), "Skin: 22"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 23); 
				format(str, sizeof(str), "Skin: 23"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 24);
				format(str, sizeof(str), "Skin: 24"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

				format(str, sizeof(str), "2 / 9"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
			}
			if(ShopItemPage[playerid] == 2) //˹�ҷ�� 2
			{
				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 25); 
				format(str, sizeof(str), "Skin: 25"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 30); 
				format(str, sizeof(str), "Skin: 30"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 297);
				format(str, sizeof(str), "Skin: 297"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

				format(str, sizeof(str), "3 / 9"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
			}
			if(ShopItemPage[playerid] == 3) //˹�ҷ�� 3
			{
				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 34); 
				format(str, sizeof(str), "Skin: 34"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 44); 
				format(str, sizeof(str), "Skin: 44"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 46);
				format(str, sizeof(str), "Skin: 46"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

				format(str, sizeof(str), "4 / 9"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
			}
			if(ShopItemPage[playerid] == 4) //˹�ҷ�� 4
			{
				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 47); 
				format(str, sizeof(str), "Skin: 47"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 48); 
				format(str, sizeof(str), "Skin: 48"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 60);
				format(str, sizeof(str), "Skin: 60"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

				format(str, sizeof(str), "5 / 9"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
			}
			if(ShopItemPage[playerid] == 5) //˹�ҷ�� 5
			{
				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 67); 
				format(str, sizeof(str), "Skin: 67"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 72); 
				format(str, sizeof(str), "Skin: 72"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 235);
				format(str, sizeof(str), "Skin: 235"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

				format(str, sizeof(str), "6 / 9"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
			}
			if(ShopItemPage[playerid] == 6) //˹�ҷ�� 6
			{
				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 236); 
				format(str, sizeof(str), "Skin: 236"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 250); 
				format(str, sizeof(str), "Skin: 250"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 258);
				format(str, sizeof(str), "Skin: 258"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

				format(str, sizeof(str), "7 / 9"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
			}
			if(ShopItemPage[playerid] == 7) //˹�ҷ�� 7
			{
				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 259); 
				format(str, sizeof(str), "Skin: 259"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 290); 
				format(str, sizeof(str), "Skin: 290"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 206);
				format(str, sizeof(str), "Skin: 206"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

				format(str, sizeof(str), "8 / 9"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
			}
			if(ShopItemPage[playerid] == 8) //˹�ҷ�� 8
			{
				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 202); 
				format(str, sizeof(str), "Skin: 202"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 188); 
				format(str, sizeof(str), "Skin: 188"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 185);
				format(str, sizeof(str), "Skin: 185"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

				format(str, sizeof(str), "9 / 9"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
			}
		}
		if(playerData[playerid][pGender] == 2) //����ͼ�Ҽ��˭ԧ
		{
			if(ShopItemPage[playerid] == 0) //˹�ҷ�� 0
			{
				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 9); 
				format(str, sizeof(str), "Skin: 9"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 13); 
				format(str, sizeof(str), "Skin: 13"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 38);
				format(str, sizeof(str), "Skin: 38"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

				format(str, sizeof(str), "1 / 5"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
			}
			if(ShopItemPage[playerid] == 1) //˹�ҷ�� 1
			{
				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 93); 
				format(str, sizeof(str), "Skin: 93"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 129); 
				format(str, sizeof(str), "Skin: 129"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 130);
				format(str, sizeof(str), "Skin: 130"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

				format(str, sizeof(str), "2 / 5"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
			}
			if(ShopItemPage[playerid] == 2) //˹�ҷ�� 2
			{
				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 131); 
				format(str, sizeof(str), "Skin: 131"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 148); 
				format(str, sizeof(str), "Skin: 148"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 226);
				format(str, sizeof(str), "Skin: 226"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

				format(str, sizeof(str), "3 / 5"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
			}
			if(ShopItemPage[playerid] == 3) //˹�ҷ�� 3
			{
				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 233); 
				format(str, sizeof(str), "Skin: 233"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 298); 
				format(str, sizeof(str), "Skin: 298"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 192);
				format(str, sizeof(str), "Skin: 192"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

				format(str, sizeof(str), "4 / 5"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
			}
			if(ShopItemPage[playerid] == 4) //˹�ҷ�� 4
			{
				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 151); 
				format(str, sizeof(str), "Skin: 151"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 157); 
				format(str, sizeof(str), "Skin: 157"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 193);
				format(str, sizeof(str), "Skin: 193"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

				format(str, sizeof(str), "5 / 5"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
			}
		}
	}
	if (shopData[shopid][shopType] == 4) //��Ф�ҿ���ظ
	{
		format(str, sizeof(str), "Craft Weapons"); // ������ҹ
		PlayerTextDrawSetString(playerid, ShopTD[playerid][2], str);

		if(ShopItemPage[playerid] == 0) //˹�ҷ�� 0
		{
			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 2061); // Model item 1
			format(str, sizeof(str), "Pistol Ammo"); // ���� item 1 
			PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 19832); // Model item 2
			format(str, sizeof(str), "Rifle Ammo"); // ���� item 2
			PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 348); // Model item 3
			format(str, sizeof(str), "Desert Eagle"); // ���� item 2
			PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

			format(str, sizeof(str), "1 / 3"); // ˹�� page
			PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);

		}
		if(ShopItemPage[playerid] == 1) //˹�ҷ�� 1
		{
			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 326); // Model item 1
			format(str, sizeof(str), "Cane"); // ���� item 1 
			PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 336); // Model item 2
			format(str, sizeof(str), "Baseball"); // ���� item 2
			PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 333); // Model item 3
			format(str, sizeof(str), "Golf"); // ���� item 2
			PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

			format(str, sizeof(str), "2 / 3"); // ˹�� page
			PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);

		}
		if(ShopItemPage[playerid] == 2) //˹�ҷ�� 2
		{
			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 338); // Model item 1
			format(str, sizeof(str), "Pool"); // ���� item 1 
			PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 335); // Model item 2
			format(str, sizeof(str), "Knife"); // ���� item 2
			PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 339); // Model item 3
			format(str, sizeof(str), "Katana"); // ���� item 2
			PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

			format(str, sizeof(str), "3 / 3"); // ˹�� page
			PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);
		}
	}
    if (shopData[shopid][shopType] == 5) //24/7
		ShowSealerShop(playerid);
		
	if (shopData[shopid][shopType] == 7) //��Ф�ҿ
	{
		format(str, sizeof(str), "Craft Equipment"); // ������ҹ
		PlayerTextDrawSetString(playerid, ShopTD[playerid][2], str);

		if(ShopItemPage[playerid] == 0) //˹�ҷ�� 0
		{
			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 19921); // Model item 1
			format(str, sizeof(str), "ToolBox"); // ���� item 1 
			PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 18634); // Model item 2
			format(str, sizeof(str), "Crowbar"); // ���� item 2
			PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 19845); // Model item 3
			format(str, sizeof(str), "Metal"); // ���� item 2
			PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

			format(str, sizeof(str), "1 / 2"); // ˹�� page
			PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);

		}
		if(ShopItemPage[playerid] == 1) //˹�ҷ�� 1
		{
			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 2589); // Model item 1
			format(str, sizeof(str), "FishingBait"); // ���� item 1 
			PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 18631); // Model item 2
			format(str, sizeof(str), "item 5"); // ���� item 2
			PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

			PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 18631); // Model item 3
			format(str, sizeof(str), "item 6"); // ���� item 2
			PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

			format(str, sizeof(str), "2 / 2"); // ˹�� page
			PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);

		}
	}
	if (shopData[shopid][shopType] == 8) //��ҹö classic
		ShowDealerVehicleClassic(playerid);

	if (shopData[shopid][shopType] == 9) //��ҹö pick up
		ShowDealerVehiclePickUp(playerid);

	ShopItemSelect[playerid] = 0;
	PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 18631);
	format(str, sizeof(str), "Select the item on the left-hand side.."); 
	PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
	
	format(str, sizeof(str), "Select"); 
	PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);
	format(str, sizeof(str), "$: -"); // ˹�� page
	PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][3], 1296911776);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][4], 1296911776);
	PlayerTextDrawBoxColor(playerid, ShopTD[playerid][5], 1296911776);
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
    for (new i = 0; i < 22; i ++) {
        PlayerTextDrawShow(playerid, ShopTD[playerid][i]);
    }
	return 1;
}


HideShopEquipmentTD(playerid) 
{
	if (!playerData[playerid][IsLoggedIn])
		return 0;

    for (new i = 0; i < 22; i ++) {
        PlayerTextDrawHide(playerid, ShopTD[playerid][i]);
    }
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
    CancelSelectTextDraw(playerid);
	return 1;
}


hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	new str[1056],
		shopid = Shop_Nearest(playerid);
	if (playertextid == ShopTD[playerid][14]) //�Դ˹�ҵ�ҧ
        return HideShopEquipmentTD(playerid);

	if (playertextid == ShopTD[playerid][17]) // -->
	{
		if(shopData[shopid][shopType] == 1 && ShopItemPage[playerid] == 2) return 1;
		if(shopData[shopid][shopType] == 3 && playerData[playerid][pGender] == 1 && ShopItemPage[playerid] == 8) return 1;
		if(shopData[shopid][shopType] == 3 && playerData[playerid][pGender] == 2 && ShopItemPage[playerid] == 4) return 1;
		if(shopData[shopid][shopType] == 4 && ShopItemPage[playerid] == 2) return 1;
		if(shopData[shopid][shopType] == 5 && ShopItemPage[playerid] == 1) return 1;
		if(shopData[shopid][shopType] == 7 && ShopItemPage[playerid] == 1) return 1;
		if(shopData[shopid][shopType] == 8 && ShopItemPage[playerid] == 4) return 1;
		if(shopData[shopid][shopType] == 9 && ShopItemPage[playerid] == 1) return 1;

		ShopItemPage[playerid] ++;
		ShowShopEquipmentTD(playerid);
	}
	if (playertextid == ShopTD[playerid][18]) // <--
	{
		if(ShopItemPage[playerid] == 0)
			return 1;

		ShopItemPage[playerid] --;
		ShowShopEquipmentTD(playerid);                   
	}
	if (playertextid == ShopTD[playerid][8]) // Buy
	{
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		if(shopData[shopid][shopType] == 1) 
		{
			if(ShopItemPage[playerid] == 0)
			{
				if(ShopItemSelect[playerid] == 1) // ���ͤ�͹
				{
					if(GetPlayerMoney(playerid) < 3000)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Equipment Store]: �������ö�����ػ�ó��� ���ͧ�ӹǹ�Թ�ͧ�س��������§��");

					new itemname[24];
					itemname = "Hammer";
					new count = Inventory_Count(playerid, itemname);
					
					if (count >= playerData[playerid][pItemAmount])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", itemname);

					new gid = Inventory_Add(playerid, itemname, 1);

					if (gid == -1)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

					HideShopEquipmentTD(playerid);
					GivePlayerMoneyEx(playerid, -3000);
					SendClientMessageEx(playerid, COLOR_GREEN, "[Equipment Store]: �س����� 'Hammer' �ӹǹ 1 ��� �ҡ��ҹ����ػ�ó���Ҥ� '$3,000'");
					return 1;
				}
				if(ShopItemSelect[playerid] == 2) // ����������
				{
					if(GetPlayerMoney(playerid) < 3500)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Equipment Store]: �������ö�����ػ�ó��� ���ͧ�ӹǹ�Թ�ͧ�س��������§��");

					new itemname[24];
					itemname = "Chainsaw";
					new count = Inventory_Count(playerid, itemname);

					if (count >= playerData[playerid][pItemAmount])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", itemname);

					new gid = Inventory_Add(playerid, itemname, 1);

					if (gid == -1)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

					HideShopEquipmentTD(playerid);
					GivePlayerMoneyEx(playerid, -3500);
					SendClientMessageEx(playerid, COLOR_GREEN, "[Equipment Store]: �س����� 'Chainsaw' �ӹǹ 1 ��� �ҡ��ҹ����ػ�ó���Ҥ� '$3,500'");
					return 1;
				}	
				if(ShopItemSelect[playerid] == 3) // �紵����
				{
					if(GetPlayerMoney(playerid) < 1000)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Equipment Store]: �������ö�����ػ�ó��� ���ͧ�ӹǹ�Թ�ͧ�س��������§��");

					new itemname[24];
					itemname = "FishingRod";
					new count = Inventory_Count(playerid, itemname);

					if (count >= playerData[playerid][pItemAmount])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", itemname);

					new gid = Inventory_Add(playerid, itemname, 1);

					if (gid == -1)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

					HideShopEquipmentTD(playerid);
					GivePlayerMoneyEx(playerid, -1000);
					SendClientMessageEx(playerid, COLOR_GREEN, "[Equipment Store]: �س����� 'FishingRod' �ӹǹ 1 ��� �ҡ��ҹ����ػ�ó���Ҥ� '$1,000'");
					return 1;
				}	
			}
			if(ShopItemPage[playerid] == 1)
			{
				if(ShopItemSelect[playerid] == 1) // �����ѧ
				{
					HideShopEquipmentTD(playerid);
					Dialog_Show(playerid, DIALOG_BUYCRATE, DIALOG_STYLE_INPUT, "[Equipment Store]", "�ô�кبӹǹ�ͧ 'Create' ���س��ͧ��èЫ���", "��ŧ", "¡��ԡ");
					return 1;
				}
				if(ShopItemSelect[playerid] == 2) // �����մ������
				{
					new itemname[24], price = 2500;
					itemname = "Knife";
					new count = Inventory_Count(playerid, itemname);
					
					if(GetPlayerMoney(playerid) < price)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Equipment Store]: �������ö�����ػ�ó��� ���ͧ�ӹǹ�Թ�ͧ�س��������§��");

					if (count >= playerData[playerid][pItemAmount])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", itemname);

					new gid = Inventory_Add(playerid, itemname, 1);

					if (gid == -1)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

					HideShopEquipmentTD(playerid);
					GivePlayerMoneyEx(playerid, -price);
					SendClientMessageEx(playerid, COLOR_GREEN, "[Equipment Store]: �س����� '%s' �ӹǹ 1 ��� �ҡ��ҹ����ػ�ó���Ҥ� '%s'", itemname, FormatMoney(price));
					return 1;
				}
			}
		}	
		if(shopData[shopid][shopType] == 3) //��ҹ����ͼ��
		{
			if(playerData[playerid][pGender] == 1) //���
			{
				if(ShopItemPage[playerid] == 0)  //˹�ҷ�� 0
				{
					if(ShopItemSelect[playerid] == 1)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:7", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 7' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 2)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:14", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 14' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 3)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:20", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 20' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");

					}
				}
				if(ShopItemPage[playerid] == 1) //˹�ҷ�� 1
				{
					if(ShopItemSelect[playerid] == 1)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:22", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 22' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 2)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:23", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 23' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 3)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:24", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 24' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
				}
				if(ShopItemPage[playerid] == 2) //˹�ҷ�� 2
				{
					if(ShopItemSelect[playerid] == 1)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:25", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 25' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 2)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:30", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 30' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 3)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:297", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 297' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
				}
				if(ShopItemPage[playerid] == 3) //˹�ҷ�� 3
				{
					if(ShopItemSelect[playerid] == 1)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:34", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 34' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 2)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:44", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 44' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 3)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:46", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 46' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
				}
				if(ShopItemPage[playerid] == 4) //˹�ҷ�� 4
				{
					if(ShopItemSelect[playerid] == 1)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:47", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 47' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 2)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:48", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 48' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 3)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:60", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 60' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
				}
				if(ShopItemPage[playerid] == 5) //˹�ҷ�� 5
				{
					if(ShopItemSelect[playerid] == 1)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:67", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 67' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 2)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:72", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 72' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 3)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:235", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 235' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
				}
				if(ShopItemPage[playerid] == 6) //˹�ҷ�� 6
				{
					if(ShopItemSelect[playerid] == 1)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:236", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 236' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 2)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:250", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 250' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 3)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:258", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 258' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
				}
				if(ShopItemPage[playerid] == 7) //˹�ҷ�� 7
				{
					if(ShopItemSelect[playerid] == 1)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:259", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 259' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 2)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:290", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 290' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 3)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:206", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 206' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
				}
				if(ShopItemPage[playerid] == 8) //˹�ҷ�� 8
				{
					if(ShopItemSelect[playerid] == 1)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:202", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 202' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
						return 1;
					}
					if(ShopItemSelect[playerid] == 2)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:188", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 188' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 3)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:185", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 185' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
				}
				return ApplyAnimationWearClothes(playerid);
			}
			if(playerData[playerid][pGender] == 2) //˭ԧ
			{
				if(ShopItemPage[playerid] == 0)  //˹�ҷ�� 0
				{
					if(ShopItemSelect[playerid] == 1)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:9", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 9' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 2)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:13", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 13' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 3)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:38", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 38' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
				}
				if(ShopItemPage[playerid] == 1)  //˹�ҷ�� 1
				{
					if(ShopItemSelect[playerid] == 1)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:93", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 93' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 2)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:129", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 129' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 3)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:130", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 130' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
				}
				if(ShopItemPage[playerid] == 2)  //˹�ҷ�� 2
				{
					if(ShopItemSelect[playerid] == 1)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:131", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 131' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 2)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:148", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 148' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 3)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:226", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 226' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
				}
				if(ShopItemPage[playerid] == 3)  //˹�ҷ�� 3
				{
					if(ShopItemSelect[playerid] == 1)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:223", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 233' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 2)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:298", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 298' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 3)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:192", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 192' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
				}
				if(ShopItemPage[playerid] == 4)  //˹�ҷ�� 4
				{
					if(ShopItemSelect[playerid] == 1)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:151", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 151' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 2)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:157", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 157' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
					if(ShopItemSelect[playerid] == 3)
					{
						if(GetPlayerMoney(playerid) < 5000)
							return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Skin Shop]: �������ö���� �ش/����ͼ�� �����ͧ�ӹǹ�Թ�ͧ�س��������§��");

						HideShopEquipmentTD(playerid);
						GivePlayerMoneyEx(playerid, -5000);
						Inventory_Add(playerid, "Skin:193", 1);
						SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop]: �س����� 'Skin: 193' �ӹǹ 1 ��Ǩҡ��ҹ����ػ�ó���Ҥ� '$5,000'");
						SendClientMessageEx(playerid, COLOR_YELLOW, "(( �� 'H' ��С������ͧ�ͧ���������Ҷ֧������ �ش/����ͼ�� �ͧ����Ф� ))");
					}
				}
				return ApplyAnimationWearClothes(playerid);
			}
		}
		if(shopData[shopid][shopType] == 5 ) //24/7
		{
			if(ShopItemPage[playerid] == 0) //˹�ҷ�� 0
			{
				if(ShopItemSelect[playerid] == 1)// Radio
				{
					if(GetPlayerMoney(playerid) < 7500)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Convenience Store]: �������ö�����ػ�ó��� ���ͧ�ӹǹ�Թ�ͧ�س��������§��");

					new itemname[24];
					itemname = "Radio";
					new count = Inventory_Count(playerid, itemname);
					
					if (count >= playerData[playerid][pItemAmount])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", itemname);

					new gid = Inventory_Add(playerid, itemname, 1);

					if (gid == -1)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

					HideShopEquipmentTD(playerid);
					GivePlayerMoneyEx(playerid, -7500);
					SendClientMessageEx(playerid, COLOR_GREEN, "[Convenience Store]: �س����� 'Radio' �ӹǹ 1 ��� �ҡ��ҹ����ػ�ó���Ҥ� '$7,500'");
					return 1;
				}
				if(ShopItemSelect[playerid] == 2) // Camera
				{
					if(GetPlayerMoney(playerid) < 5500)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Convenience Store]: �������ö�����ػ�ó��� ���ͧ�ӹǹ�Թ�ͧ�س��������§��");

					new itemname[24];
					itemname = "Camera";
					new count = Inventory_Count(playerid, itemname);

					if (count >= playerData[playerid][pItemAmount])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", itemname);

					new gid = Inventory_Add(playerid, itemname, 1);

					if (gid == -1)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

					HideShopEquipmentTD(playerid);
					GivePlayerMoneyEx(playerid, -5500);
					SendClientMessageEx(playerid, COLOR_GREEN, "[Convenience Store]: �س����� 'Camera' �ӹǹ 1 ��� �ҡ��ҹ����ػ�ó���Ҥ� '$5,500'");
					return 1;
				}	
				if(ShopItemSelect[playerid] == 3) // PepperSpray
				{
					if(GetPlayerMoney(playerid) < 3000)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Convenience Store]: �������ö�����ػ�ó��� ���ͧ�ӹǹ�Թ�ͧ�س��������§��");

					new itemname[24];
					itemname = "PepperSpray";
					new count = Inventory_Count(playerid, itemname);

					if (count >= playerData[playerid][pItemAmount])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", itemname);

					new gid = Inventory_Add(playerid, itemname, 1);

					if (gid == -1)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

					HideShopEquipmentTD(playerid);
					GivePlayerMoneyEx(playerid, -3000);
					SendClientMessageEx(playerid, COLOR_GREEN, "[Convenience Store]: �س����� 'Pepper Spray' �ӹǹ 1 ��� �ҡ��ҹ����ػ�ó���Ҥ� '$3,000'");
					return 1;
				}	
			}
			if(ShopItemPage[playerid] == 1) //˹�ҷ�� 1
			{
				if(ShopItemSelect[playerid] == 1)// Rope
				{
					if(GetPlayerMoney(playerid) < 2500)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Convenience Store]: �������ö�����ػ�ó��� ���ͧ�ӹǹ�Թ�ͧ�س��������§��");

					new itemname[24];
					itemname = "Rope";
					new count = Inventory_Count(playerid, itemname);
					
					if (count >= playerData[playerid][pItemAmount])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", itemname);

					new gid = Inventory_Add(playerid, itemname, 1);

					if (gid == -1)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

					HideShopEquipmentTD(playerid);
					GivePlayerMoneyEx(playerid, -2500);
					SendClientMessageEx(playerid, COLOR_GREEN, "[Convenience Store]: �س����� 'Rope' �ӹǹ 1 ��� �ҡ��ҹ����ػ�ó���Ҥ� '$2,500'");
					return 1;
				}
				if(ShopItemSelect[playerid] == 2) // iFruit
				{
					if(GetPlayerMoney(playerid) < 7500)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Convenience Store]: �������ö�����ػ�ó��� ���ͧ�ӹǹ�Թ�ͧ�س��������§��");

					new itemname[24];
					itemname = "iFruit";
					new count = Inventory_Count(playerid, itemname);

					if (count >= playerData[playerid][pItemAmount])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", itemname);

					new gid = Inventory_Add(playerid, itemname, 1);

					if (gid == -1)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

					HideShopEquipmentTD(playerid);
					GivePlayerMoneyEx(playerid, -7500);
					playerData[playerid][pPhone] = random(900000) + 100000;
					SendClientMessageEx(playerid, COLOR_GREEN, "[Convenience Store]: �س����� 'iFruit' �ӹǹ 1 ��� �ҡ��ҹ����ػ�ó���Ҥ� '$7,500'");
					return 1;
				}	
				if(ShopItemSelect[playerid] == 3) // Watch
				{
					if(GetPlayerMoney(playerid) < 1500)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Convenience Store]: �������ö�����ػ�ó��� ���ͧ�ӹǹ�Թ�ͧ�س��������§��");

					new itemname[24];
					itemname = "Watch";
					new count = Inventory_Count(playerid, itemname);

					if (count >= playerData[playerid][pItemAmount])
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", itemname);

					new gid = Inventory_Add(playerid, itemname, 1);

					if (gid == -1)
						return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

					HideShopEquipmentTD(playerid);
					GivePlayerMoneyEx(playerid, -1500);
					ApplyAnimation(playerid, "CLOTHES","CLO_Pose_Torso", 4.1, 0, 0, 0, 1, 0, 1);
					SendClientMessageEx(playerid, COLOR_GREEN, "[Convenience Store]: �س����� 'Watch' �ӹǹ 1 ��� �ҡ��ҹ����ػ�ó���Ҥ� '$1,500'");
					return 1;
				}	
			}
		}
		if(shopData[shopid][shopType] == 7 ) //��ҿ
		{
			if(ShopItemPage[playerid] == 0)
			{
				if(ShopItemSelect[playerid] == 1) // ToolBox
				{
					if(Inventory_Count(playerid, "Iron") < 25)
						return SendClientMessage(playerid, COLOR_LIGHTRED, "[Craft Equipment]: �س�ըӹǹ 'Iron' �����§��");
					
					if(Inventory_Count(playerid, "Gold") < 20)
						return SendClientMessage(playerid, COLOR_LIGHTRED, "[Craft Equipment]: �س�ըӹǹ 'Iron' �����§��");

					if(StartCraftToolBox[playerid] == true)
						return 1;

					StartCraftToolBox[playerid] = true;
					StartProgress(playerid, 100, 0, 0);
					ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);

					Inventory_Remove(playerid, "Iron", 25);
					Inventory_Remove(playerid, "Gold", 20);
					HideShopEquipmentTD(playerid);
					return 1;
				}
				if(ShopItemSelect[playerid] == 2) // Crowbar
				{
					if(Inventory_Count(playerid, "GunPowder") < 10)
						return SendClientMessage(playerid, COLOR_LIGHTRED, "[Craft Equipment]: �س�ըӹǹ 'GunPowder' �����§��");
					
					if(Inventory_Count(playerid, "Gold") < 25)
						return SendClientMessage(playerid, COLOR_LIGHTRED, "[Craft Equipment]: �س�ըӹǹ 'Gold' �����§��");
					
					if(Inventory_Count(playerid, "Metal") < 1)
						return SendClientMessage(playerid, COLOR_LIGHTRED, "[Craft Equipment]: �س�ըӹǹ 'Metal' �����§��");

					if(StartCraftCrowbar[playerid] == true)
						return 1;
						
					StartCraftCrowbar[playerid] = true;
					StartProgress(playerid, 100, 0, 0);
					ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);

					Inventory_Remove(playerid, "GunPowder", 10);
					Inventory_Remove(playerid, "Gold", 25);
					Inventory_Remove(playerid, "Metal", 1);
					HideShopEquipmentTD(playerid);
					return 1;
				}	
				if(ShopItemSelect[playerid] == 3) // Metal
				{
					if(Inventory_Count(playerid, "Iron") < 50)
						return SendClientMessage(playerid, COLOR_LIGHTRED, "[Craft Equipment]: �س�ըӹǹ 'Iron' �����§��");
					
					if(Inventory_Count(playerid, "Diamon") < 1)
						return SendClientMessage(playerid, COLOR_LIGHTRED, "[Craft Equipment]: �س�ըӹǹ 'Diamon' �����§��");
					
					if(StartCraftMetal[playerid] == true)
						return 1;
						
					StartCraftMetal[playerid] = true;
					StartProgress(playerid, 100, 0, 0);
					ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);

					Inventory_Remove(playerid, "Iron", 50);
					Inventory_Remove(playerid, "Diamon", 1);
					HideShopEquipmentTD(playerid);
					return 1;
				}	
			}
			if(ShopItemPage[playerid] == 1)
			{
				if(ShopItemSelect[playerid] == 1) // FishingBait
				{
					if(Inventory_Count(playerid, "WoodPacks") < 2)
						return SendClientMessage(playerid, COLOR_LIGHTRED, "[Craft Equipment]: �س�ըӹǹ 'WoodPacks' �����§��");
					
					if(StartCraftFishingBait[playerid] == true)
						return 1;

					StartCraftFishingBait[playerid] = true;
					StartProgress(playerid, 100, 0, 0);
					ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);

					Inventory_Remove(playerid, "WoodPacks", 2);
					HideShopEquipmentTD(playerid);
					return 1;
				}
				if(ShopItemSelect[playerid] == 2) // 
				{

				}	
				if(ShopItemSelect[playerid] == 3) // 
				{

				}	
			}
		}
	}
	if (playertextid == ShopTD[playerid][3]) // Select item 1
	{ 
		PlayerTextDrawBoxColor(playerid, ShopTD[playerid][3], 1650812927);
		PlayerTextDrawBoxColor(playerid, ShopTD[playerid][4], 1296911776);
		PlayerTextDrawBoxColor(playerid, ShopTD[playerid][5], 1296911776);

		PlayerTextDrawShow(playerid, ShopTD[playerid][3]);
		PlayerTextDrawShow(playerid, ShopTD[playerid][4]);
		PlayerTextDrawShow(playerid, ShopTD[playerid][5]);
		ShopItemSelect[playerid] = 1;
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		
		if(shopData[shopid][shopType] == 1) //���͡, �Ҥ� (Hammer)
		{
			if(ShopItemPage[playerid] == 0)
			{
				format(str, sizeof(str), "Hammer"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "$: 3,000"); //Hammer
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 18635); // Model item 1 ��͹
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Used to mine ore within the mine."); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 1)
			{
				format(str, sizeof(str), "Crate"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "$: 500"); //Crate
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 19639); // Model item 1 �ѧ
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Used to mine ore within the Apple."); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}
		if(shopData[shopid][shopType] == 3 ) //��ҹ�������ͼ��
		{
			if(playerData[playerid][pGender] == 1)
			{
				if(ShopItemPage[playerid] == 0)
				{
					format(str, sizeof(str), "Skin: 7"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 7); 
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 1)
				{
					format(str, sizeof(str), "Skin: 22"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 22); 
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 2)
				{
					format(str, sizeof(str), "Skin: 25"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 25);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 3)
				{
					format(str, sizeof(str), "Skin: 34"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 34);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 4)
				{
					format(str, sizeof(str), "Skin: 47"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 47);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 5)
				{
					format(str, sizeof(str), "Skin: 67"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 67);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 6)
				{
					format(str, sizeof(str), "Skin: 236"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 236); 
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 7)
				{
					format(str, sizeof(str), "Skin: 259"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 259);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 8)
				{
					format(str, sizeof(str), "Skin: 202"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 202);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
			}
			if(playerData[playerid][pGender] == 2)
			{
				if(ShopItemPage[playerid] == 0)
				{
					format(str, sizeof(str), "Skin: 9"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 9); 
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 1)
				{
					format(str, sizeof(str), "Skin: 93"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 93); 
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 2)
				{
					format(str, sizeof(str), "Skin: 131"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 131);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 3)
				{
					format(str, sizeof(str), "Skin: 233"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 233);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 4)
				{
					format(str, sizeof(str), "Skin: 151"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 151);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
			}
		}
		if(shopData[shopid][shopType] == 5 ) //24/7
		{
			if(ShopItemPage[playerid] == 0)
			{
				format(str, sizeof(str), "Radio"); //Radio
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "$: 7,500");
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 19942);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Used to communicate between players."); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 1) 
			{
				format(str, sizeof(str), "Rope");  //Rope
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "$: 2,500"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 968);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Used to bind injured players."); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}
		if(shopData[shopid][shopType] == 7 ) //��Ф�ҿ
		{
			if(ShopItemPage[playerid] == 0)
			{
				format(str, sizeof(str), "ToolBox"); //ToolBox
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "$: -");
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 19921);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Iron: 25~n~Gold: 20"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 1) 
			{
				format(str, sizeof(str), "FishingBait");  //FishingBait
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "$: -"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 2589);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "WoodPacks: 2"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}
	}
	if (playertextid == ShopTD[playerid][4]) // Select item 2
	{
		PlayerTextDrawBoxColor(playerid, ShopTD[playerid][3], 1296911776);
		PlayerTextDrawBoxColor(playerid, ShopTD[playerid][4], 1650812927);
		PlayerTextDrawBoxColor(playerid, ShopTD[playerid][5], 1296911776);
	
		PlayerTextDrawShow(playerid, ShopTD[playerid][3]);
		PlayerTextDrawShow(playerid, ShopTD[playerid][4]);
		PlayerTextDrawShow(playerid, ShopTD[playerid][5]);
		ShopItemSelect[playerid] = 2;
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);

		if(shopData[shopid][shopType] == 1) //���͡, �Ҥ� (Chainsaw)
		{
			if(ShopItemPage[playerid] == 0)
			{
				format(str, sizeof(str), "Chainsaw");
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "$: 3,500"); //Chainsaw
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 341); // Model item 2 ������
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Used to cut wood in the forest."); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 1)
			{
				format(str, sizeof(str), "Knife");
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "$: 2,500");
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 341); 
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Used for cutting meat."); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}
		if(shopData[shopid][shopType] == 3 ) //��ҹ�������ͼ��
		{
			if(playerData[playerid][pGender] == 1)
			{
				if(ShopItemPage[playerid] == 0)
				{
					format(str, sizeof(str), "Skin: 14"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 14); 
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 1)
				{
					format(str, sizeof(str), "Skin: 23"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 23); 
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 2)
				{
					format(str, sizeof(str), "Skin: 30"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 30);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 3)
				{
					format(str, sizeof(str), "Skin: 44"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 44);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 4)
				{
					format(str, sizeof(str), "Skin: 48"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 48);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 5)
				{
					format(str, sizeof(str), "Skin: 72"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 72);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 6)
				{
					format(str, sizeof(str), "Skin: 250"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 250); 
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 7)
				{
					format(str, sizeof(str), "Skin: 290"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 290);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 8)
				{
					format(str, sizeof(str), "Skin: 188"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 188);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
			}
			if(playerData[playerid][pGender] == 2)
			{
				if(ShopItemPage[playerid] == 0)
				{
					format(str, sizeof(str), "Skin: 13"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 13); 
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 1)
				{
					format(str, sizeof(str), "Skin: 129"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 129); 
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 2)
				{
					format(str, sizeof(str), "Skin: 148"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 148);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 3)
				{
					format(str, sizeof(str), "Skin: 298"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 298);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 4)
				{
					format(str, sizeof(str), "Skin: 157"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 157);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
			}
		}
		if(shopData[shopid][shopType] == 5 ) //24/7
		{
			if(ShopItemPage[playerid] == 0)
			{
				format(str, sizeof(str), "Camera"); //Camera
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "$: 5,500");
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 367);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Used for taking photos."); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 1) 
			{
				format(str, sizeof(str), "iFruit");  //iFruit
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "$: 7,500"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 18868);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Used in communication and social media."); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}
		if(shopData[shopid][shopType] == 7 ) //��Ф�ҿ
		{
			if(ShopItemPage[playerid] == 0)
			{
				format(str, sizeof(str), "Crowbar");  //Crowbar
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~r~$: 500"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 18634);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "GunPowder: 10~n~Gold: 25~n~Metal: 1"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}

	}
	if (playertextid == ShopTD[playerid][5]) // Select item 3
	{
		PlayerTextDrawBoxColor(playerid, ShopTD[playerid][3], 1296911776);
		PlayerTextDrawBoxColor(playerid, ShopTD[playerid][4], 1296911776);
		PlayerTextDrawBoxColor(playerid, ShopTD[playerid][5], 1650812927);
	
		PlayerTextDrawShow(playerid, ShopTD[playerid][3]);
		PlayerTextDrawShow(playerid, ShopTD[playerid][4]);
		PlayerTextDrawShow(playerid, ShopTD[playerid][5]);
		ShopItemSelect[playerid] = 3;
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);

		if(shopData[shopid][shopType] == 1) //���͡, �Ҥ�
		{
			if( ShopItemPage[playerid] == 0)
			{
				format(str, sizeof(str), "Fishing Rod"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "$: 1,000"); //Chainsaw
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);
				
				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 18632); // Model item 3 Fishing Rod
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Used for fishing in fishing areas."); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}
		if(shopData[shopid][shopType] == 3 ) //��ҹ�������ͼ��
		{
			if(playerData[playerid][pGender] == 1)
			{
				if(ShopItemPage[playerid] == 0)
				{
					format(str, sizeof(str), "Skin: 20"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 20); 
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 1)
				{
					format(str, sizeof(str), "Skin: 24"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 24); 
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 2)
				{
					format(str, sizeof(str), "Skin: 297"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 297);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 3)
				{
					format(str, sizeof(str), "Skin: 46"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 46);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 4)
				{
					format(str, sizeof(str), "Skin: 60"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 60);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 5)
				{
					format(str, sizeof(str), "Skin: 235"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 235);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 6)
				{
					format(str, sizeof(str), "Skin: 258"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 258); 
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 7)
				{
					format(str, sizeof(str), "Skin: 206"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 206);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 8)
				{
					format(str, sizeof(str), "Skin: 185"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 185);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
			}
			if(playerData[playerid][pGender] == 2)
			{
				if(ShopItemPage[playerid] == 0)
				{
					format(str, sizeof(str), "Skin: 38"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 38); 
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 1)
				{
					format(str, sizeof(str), "Skin: 130"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 130); 
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 2)
				{
					format(str, sizeof(str), "Skin: 226"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 226);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 3)
				{
					format(str, sizeof(str), "Skin: 192"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 192);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
				if(ShopItemPage[playerid] == 4)
				{
					format(str, sizeof(str), "Skin: 193"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

					format(str, sizeof(str), "$: 5,000"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

					PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 193);
					PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
					format(str, sizeof(str), "Dress/Clothing, used for wearing"); 
					PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
				}
			}
		}	
		if(shopData[shopid][shopType] == 5 ) //24/7
		{
			if(ShopItemPage[playerid] == 0)
			{
				format(str, sizeof(str), "Pepper Spray"); //Pepper Spray
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "$: 3,000");
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 365);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Used to spray other players for self-defense.."); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 1) 
			{
				format(str, sizeof(str), "Watch");  //iFruit
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "$: 1,500"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 19039);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Used to see the time."); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}	
		if(shopData[shopid][shopType] == 7 ) //��Ф�ҿ
		{
			if(ShopItemPage[playerid] == 0) 
			{
				format(str, sizeof(str), "Metal");  //Metal
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "$: -"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 19845);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Iron: 50~n~Diamon: 1"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}
	}
    return 1;
}


Dialog:Craft_GunPowder(playerid, response, listitem, inputtext[])
{

	if(response) 
	{
		PlayerPlaySound(playerid, 1135, 0.0, 0.0, 0.0);
		switch(listitem)
		{
			case 2:
			{
				if(Inventory_Count(playerid, "WoodPacks") < 50)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[��ѧ�Թ�׹] �������ö���ҧ�纤�ѧ�Թ�׹�� ���ͧ�ҡ 'WoodPacks' �ͧ�س����������§��");

				if(Inventory_Count(playerid, "Iron") < 50)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[��ѧ�Թ�׹] �������ö���ҧ�纤�ѧ�Թ�׹�� ���ͧ�ҡ 'Iron' �ͧ�س����������§��");

				StartCraftGunPowder[playerid] = true;
				StartProgress(playerid, 100, 0, 0);
				ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);

				Inventory_Remove(playerid, "WoodPacks", 50);
				Inventory_Remove(playerid, "Iron", 50);
				SendClientMessageEx(playerid, COLOR_YELLOW, "[��ѧ�Թ�׹] �س����������ҧ��ѧ�纴Թ�׹, �ô�����͡�ҡ������������͢�Ѻ�͡�ҡ��鹷��");
				SendClientMessageEx(playerid, COLOR_LIGHTRED, "(( �ҡ�س '�͡��' ���� '��ش��' 㹢�з��س���ѧ�ӡ�����ҧ, ������ҧ�ж١¡��ԡ ))");
				return 1;
			}
		}
	}
	else return PlayerPlaySound(playerid, 1135, 0.0, 0.0, 0.0);
	return 1;
}

Dialog:GunPowder(playerid, response, listitem, inputtext[])
{
	new count = Inventory_Count(playerid, "GunPowder");
	if(response) 
	{
		switch(listitem)
		{
			case 0:
			{
				SendClientMessage(playerid, COLOR_GREY, "���Ѿഷ�Ф�Ѻ...");

				if(playerData[playerid][pPowderMax] <= 0)

					return Dialog_Show(playerid, Craft_GunPowder, DIALOG_STYLE_TABLIST_HEADERS, "��ѧ�纴Թ�׹", "�ػ�ó�����\t�ӹǹ{FFFFFF}\n\
					- WoodPacks\t%d / 50\n\
					- Iron\t%d / 50\n\
					{FFA84D}[+] ���ҧ��ѧ�Թ�׹ (50 �����繵�)", "���ҧ", "¡��ԡ", Inventory_Count(playerid, "WoodPacks"), Inventory_Count(playerid, "Iron"));

				Dialog_Show(playerid, GunPowder, DIALOG_STYLE_LIST, "��ѧ�纴Թ�׹", "{FFFFFF}�Թ�׹㹤�ѧ: %s / %s ����{FFA84D}\t[Upgrade]\n\
				- �ҡ��Ҥ�ѧ\n\
				- �ԡ�͡�ҡ��ѧ\
				", "���͡", "¡��ԡ", FormatNumber(playerData[playerid][pPowder]), FormatNumber(playerData[playerid][pPowderMax]));
				PlayerPlaySound(playerid, 1135, 0.0, 0.0, 0.0);
			}
			case 1:
			{
				PlayerPlaySound(playerid, 1135, 0.0, 0.0, 0.0);
				Dialog_Show(playerid, GunPowder_Deposit, DIALOG_STYLE_INPUT, "��ѧ�纴Թ�׹", "�ô�кبӹǹ�Թ�׹���س��ͧ��èнҡ��Ҥ�ѧ ��觤س������ '%d' ����", "�ҡ", "��͹��Ѻ", count);
			}
			case 2:
			{
				PlayerPlaySound(playerid, 1135, 0.0, 0.0, 0.0);
				Dialog_Show(playerid, GunPowder_Withdraw, DIALOG_STYLE_INPUT, "��ѧ�纴Թ�׹", "�ô�кبӹǹ�Թ�׹���س��ͧ��è��ԡ�͡�ҡ��ѧ ������㹤�ѧ�س������ '%s' ����", "�ԡ", "��͹��Ѻ", FormatNumber(playerData[playerid][pPowder]));
			}
		}
	}
	else return PlayerPlaySound(playerid, 1135, 0.0, 0.0, 0.0);
	return 1;
}
Dialog:GunPowder_Deposit(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 1135, 0.0, 0.0, 0.0);
	new amount = strval(inputtext), count = Inventory_Count(playerid, "GunPowder");
	if(response) 
	{
		if (isnull(inputtext))
			return Dialog_Show(playerid, GunPowder_Deposit, DIALOG_STYLE_INPUT, "��ѧ�纴Թ�׹", "�ô�кبӹǹ�Թ�׹���س��ͧ��èнҡ��Ҥ�ѧ ��觤س������ '%d' ����", "�ҡ", "��͹��Ѻ", count);

		if(amount < 1)
			return Dialog_Show(playerid, GunPowder_Deposit, DIALOG_STYLE_INPUT, "��ѧ�纴Թ�׹", "�ô�кبӹǹ�Թ�׹���س��ͧ��èнҡ��Ҥ�ѧ ��觤س������ '%d' ����\n\
			{FF6347}*���繵�ͧ�кبӹǹ����ҡ���� 0", "�ҡ", "��͹��Ѻ", count);

		//
		if(amount > count)
			return Dialog_Show(playerid, GunPowder_Deposit, DIALOG_STYLE_INPUT, "��ѧ�纴Թ�׹", "�ô�кبӹǹ�Թ�׹���س��ͧ��èнҡ��Ҥ�ѧ ��觤س������ '%d' ����\n\
			{FF6347}*�������ö�ҡ�� ���ͧ�ҡ�س�ըӹǹ�Թ�׹�����§��", "�ҡ", "��͹��Ѻ", count);

		if(amount > playerData[playerid][pPowderMax]-playerData[playerid][pPowder])
			return Dialog_Show(playerid, GunPowder_Deposit, DIALOG_STYLE_INPUT, "��ѧ�纴Թ�׹", "�ô�кبӹǹ�Թ�׹���س��ͧ��èнҡ��Ҥ�ѧ ��觤س������ '%d' ����\n\
			{FF6347}*�������ö�ҡ�� ���ͧ�ҡ��鹷���������§��", "�ҡ", "��͹��Ѻ", count);

		/*if(count > playerData[playerid][pPowderMax])
			return Dialog_Show(playerid, GunPowder_Deposit, DIALOG_STYLE_INPUT, "��ѧ�纴Թ�׹", "�ô�кبӹǹ�Թ�׹���س��ͧ��èнҡ��Ҥ�ѧ ��觤س������ '%d' ����\n\
			{FF6347}*�������ö�ҡ�� ���ͧ�ҡ��鹷���������§��", "�ҡ", "��͹��Ѻ", count);*/

		Inventory_Remove(playerid, "GunPowder", amount);
		playerData[playerid][pPowder] += amount;

		SendClientMessageEx(playerid, COLOR_GREEN, "[��ѧ�纴Թ�׹]: �س��ҡ�Թ�׹������㹤�ѧ�ӹǹ '%s' ����", FormatNumber(amount));
		Dialog_Show(playerid, GunPowder, DIALOG_STYLE_LIST, "��ѧ�纴Թ�׹", "{FFFFFF}�Թ�׹㹤�ѧ: %s / %s ����{FFA84D}\t[Upgrade]\n\
		- �ҡ��Ҥ�ѧ\n\
		- �ԡ�͡�ҡ��ѧ\
		", "���͡", "¡��ԡ", FormatNumber(playerData[playerid][pPowder]), FormatNumber(playerData[playerid][pPowderMax]));
		
	}
	else 
	{
		PlayerPlaySound(playerid, 1135, 0.0, 0.0, 0.0);
		Dialog_Show(playerid, GunPowder, DIALOG_STYLE_LIST, "��ѧ�纴Թ�׹", "{FFFFFF}�Թ�׹㹤�ѧ: %s / %s ����{FFA84D}\t[Upgrade]\n\
		- �ҡ��Ҥ�ѧ\n\
		- �ԡ�͡�ҡ��ѧ\
		", "���͡", "¡��ԡ", FormatNumber(playerData[playerid][pPowder]), FormatNumber(playerData[playerid][pPowderMax]));
		
	}
	return 1;
}
Dialog:GunPowder_Withdraw(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 1135, 0.0, 0.0, 0.0);
	new amount = strval(inputtext), count = Inventory_Count(playerid, "GunPowder");
	if(response) 
	{
		if (isnull(inputtext))
			return Dialog_Show(playerid, GunPowder_Withdraw, DIALOG_STYLE_INPUT, "��ѧ�纴Թ�׹", "�ô�кبӹǹ�Թ�׹���س��ͧ��è��ԡ�͡�ҡ��ѧ ������㹤�ѧ�س������ '%s' ����", "�ԡ", "��͹��Ѻ", FormatNumber(playerData[playerid][pPowder]));

		if(amount < 1)
			return Dialog_Show(playerid, GunPowder_Withdraw, DIALOG_STYLE_INPUT, "��ѧ�纴Թ�׹", "�ô�кبӹǹ�Թ�׹���س��ͧ��èнҡ��Ҥ�ѧ ��觤س������ '%d' ����\n\
			{FF6347}*���繵�ͧ�кبӹǹ����ҡ���� 0", "�ҡ", "��͹��Ѻ", count);
		
		//
		if(amount > playerData[playerid][pPowder]) //�ӹǹ㹤�ѧ
			return Dialog_Show(playerid, GunPowder_Withdraw, DIALOG_STYLE_INPUT, "��ѧ�纴Թ�׹", "�ô�кبӹǹ�Թ�׹���س��ͧ��è��ԡ�͡�ҡ��ѧ ������㹤�ѧ�س������ '%s' ����\n\
			{FF6347}*�������ö�ԡ�� ���ͧ�ҡ��ѧ�纴Թ�׹�ըӹǹ�Թ�׹�����§��", "�ԡ", "��͹��Ѻ", count);

		if(count >= playerData[playerid][pItemAmount])
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�ԡ 'GunPowder' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!");

		if(amount > playerData[playerid][pItemAmount]-count)
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�ԡ 'GunPowder' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!");

		new id = Inventory_Add(playerid, "GunPowder", amount);

		if (id == -1)
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

		playerData[playerid][pPowder] -= amount;
		SendClientMessageEx(playerid, COLOR_GREEN, "[��ѧ�纴Թ�׹]: �س���ԡ�Թ�׹�ҡ��ѧ�͡�Ҩӹǹ '%s' ����", FormatNumber(amount));
	}
	else
	{
		PlayerPlaySound(playerid, 1135, 0.0, 0.0, 0.0);
		Dialog_Show(playerid, GunPowder, DIALOG_STYLE_LIST, "��ѧ�纴Թ�׹", "{FFFFFF}�Թ�׹㹤�ѧ: %s / %s ����{FFA84D}\t[Upgrade]\n\
		- �ҡ��Ҥ�ѧ\n\
		- �ԡ�͡�ҡ��ѧ\
		", "���͡", "¡��ԡ", FormatNumber(playerData[playerid][pPowder]), FormatNumber(playerData[playerid][pPowderMax]));
		
	}
	return 1;
}
Dialog:DIALOG_BUYCRATE(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 1135, 0.0, 0.0, 0.0);
	new amount = strval(inputtext);
	if(response) 
	{
		new itemname[24];
		itemname = "Crate";
		new count = Inventory_Count(playerid, itemname);

		if (isnull(inputtext))
			return Dialog_Show(playerid, DIALOG_BUYCRATE, DIALOG_STYLE_INPUT, "[Equipment Store]", "�ô�кبӹǹ�ͧ 'Create' ���س��ͧ��èЫ���", "��ŧ", "¡��ԡ");

		if (amount > playerData[playerid][pItemAmount]-count)
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", itemname);

		if(GetPlayerMoney(playerid) < amount*500)
			return Dialog_Show(playerid, DIALOG_BUYCRATE, DIALOG_STYLE_INPUT, "[Equipment Store]", "�ô�кبӹǹ�ͧ 'Create' ���س��ͧ��èЫ���\n{FF6347}*�������ö���������ͨҡ�ӹǹ�Թ�ͧ�س��������§�� (( %s/%s ))", "��ŧ", "¡��ԡ", FormatMoney(GetPlayerMoney(playerid)), FormatMoney(amount*500));

		if(amount < 1)
			return Dialog_Show(playerid, GunPowder_Withdraw, DIALOG_STYLE_INPUT, "[Equipment Store]", "�ô�кبӹǹ�ͧ 'Create' ���س��ͧ��èЫ���\n\
			{FF6347}*�ô�кبӹǹ�ҡ���� 0", "��ŧ", "¡��ԡ");
		
		new gid = Inventory_Add(playerid, itemname, amount);

		if (gid == -1)
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

		GivePlayerMoneyEx(playerid, -amount*500);
		SendClientMessageEx(playerid, COLOR_GREEN, "[Equipment Store]: �س����� 'Crate' �ӹǹ %d ��� �ҡ��ҹ����ػ�ó���Ҥ� '$500'", amount);
		return 1;



	}
	return 1;
}


hook OnProgressUpdate(playerid, progress, objectid)
{
    if(StartCraftGunPowder[playerid] == true){
        ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);
        return Y_HOOKS_BREAK_RETURN_1;
    }
    if(StartCraftToolBox[playerid] == true){
        ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);
        return Y_HOOKS_BREAK_RETURN_1;
    }
    if(StartCraftCrowbar[playerid] == true){
        ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);
        return Y_HOOKS_BREAK_RETURN_1;
    }
    if(StartCraftMetal[playerid] == true){
        ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);
        return Y_HOOKS_BREAK_RETURN_1;
    }
    if(StartCraftFishingBait[playerid] == true){
        ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);
        return Y_HOOKS_BREAK_RETURN_1;
    }
	return Y_HOOKS_CONTINUE_RETURN_0;
}
hook OnProgressFinish(playerid)
{
	if(StartCraftGunPowder[playerid] == true)
		return CraftGunPowder(playerid);

	if(StartCraftToolBox[playerid] == true)
		CraftToolBox(playerid);

	if(StartCraftCrowbar[playerid] == true)
		CraftCrowbar(playerid);

	if(StartCraftMetal[playerid] == true)
		CraftMetal(playerid);

	if(StartCraftFishingBait[playerid] == true)
		CraftFishingBait(playerid);

	return Y_HOOKS_CONTINUE_RETURN_0;
	
}
CraftGunPowder(playerid)
{
	new craft = random(100);
    switch(craft)
    {
        case 0..50:
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[��ѧ�Թ�׹] �س�����ʺ���������㹡�����ҧ��ѧ�纴Թ�׹, �ô�ͧ����������ѧ");
        case 51..100:
        {
			playerData[playerid][pPowderMax] = 50;
			SendClientMessageEx(playerid, COLOR_GREEN, "[��ѧ�Թ�׹] �س���ʺ���������㹡�����ҧ��ѧ�纴Թ�׹");
		}
	}
	return 1;
}

CraftToolBox(playerid)
{
    new itemname[24];
    itemname = "ToolBox";
    new count = Inventory_Count(playerid, itemname);

    StartCraftToolBox[playerid] = false;
    PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);

    if (count >= playerData[playerid][pItemAmount])
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", itemname);

    new id = Inventory_Add(playerid, itemname, 1);

    if (id == -1)
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

    SendClientMessageEx(playerid, COLOR_GREEN, "[Craft Equipment]: �س���Ѻ '%s' �ӹǹ 1 �ҡ��ä�ҿ", itemname);
	return 1;
}
CraftFishingBait(playerid)
{
    new itemname[24];
    itemname = "FishingBait";
    new amount = randomEx(5, 10),
		count = Inventory_Count(playerid, itemname);

    StartCraftFishingBait[playerid] = false;
    PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);

    if (count >= playerData[playerid][pItemAmount])
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", itemname);

    new id = Inventory_Add(playerid, itemname, amount);

    if (id == -1)
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

    SendClientMessageEx(playerid, COLOR_GREEN, "[Craft Equipment]: �س���Ѻ '%s' �ӹǹ %d �ҡ��ä�ҿ", itemname, amount);
	return 1;
}
CraftCrowbar(playerid)
{
    new itemname[24];
    itemname = "Crowbar";
    new count = Inventory_Count(playerid, itemname);

    StartCraftCrowbar[playerid] = false;
    PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);

    if (count >= playerData[playerid][pItemAmount])
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", itemname);

    new id = Inventory_Add(playerid, itemname, 1);

    if (id == -1)
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

    SendClientMessageEx(playerid, COLOR_GREEN, "[Craft Equipment]: �س���Ѻ '%s' �ӹǹ 1 �ҡ��ä�ҿ", itemname);
	return 1;
}
CraftMetal(playerid)
{
    new itemname[24];
    itemname = "Metal";
    new count = Inventory_Count(playerid, itemname);

    StartCraftMetal[playerid] = false;
    PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);

    if (count >= playerData[playerid][pItemAmount])
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", itemname);

    new id = Inventory_Add(playerid, itemname, 1);

    if (id == -1)
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

    SendClientMessageEx(playerid, COLOR_GREEN, "[Craft Equipment]: �س���Ѻ '%s' �ӹǹ 1 �ҡ��ä�ҿ", itemname);
	return 1;
}



















































CMD:createshop(playerid, params[])
{
	static
		type;

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (sscanf(params, "d", type))
	{
		SendClientMessage(playerid, COLOR_WHITE, "/createshop [�ٻẺ]  | ");
        SendClientMessage(playerid, COLOR_YELLOW, "[�ٻẺ�����]:{FFFFFF} 1: Equipment Store | 2: ��ѧ�Թ�׹ | 3: ��ҹ�������ͼ�� | 4: ��Ф�ҿ���ظ | 5: 24/7");
        SendClientMessage(playerid, COLOR_YELLOW, "[�ٻẺ�����]:{FFFFFF} 6: ��ҹ��¢ͧ | 7: ��Ф�ҿ");
        SendClientMessage(playerid, COLOR_YELLOW, "[�ػẺ��ҹ���ö]:{FFFFFF} 8: Classic | 9: Pick up");
		return 1;
	}

	static
	    id = -1,
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

    if (type < 1 || type > 10)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �ٻẺ��ͧ����ӡ��� 1 �������ҡ���� 10 ��ҹ��");

	id = Shop_Create(x, y, z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), type);

	if (id == -1)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �����آͧ��ҹ���㹰ҹ������������� �������ö���ҧ���ա (�Դ��ͼ��Ѳ��)");

	SendClientMessageEx(playerid, COLOR_SERVER, "�س�����ҧ��ҹ��Ң�������� �ʹ�: %d", id);
	return 1;
}

CMD:removeshop(playerid, params[])
{
	static
	    id = 0;

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, COLOR_WHITE, "/removeshop [�ʹ�]");

	if ((id < 0 || id >= MAX_SHOPS) || !shopData[id][shopExists])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ������ʹ���ҹ��ҹ������㹰ҹ������");

	Shop_Delete(id);
	SendClientMessageEx(playerid, COLOR_SERVER, "�س��ź��ҹ����ʹ� %d �͡�����", id);
	return 1;
}
CMD:shop(playerid, params[])
{
	static
		id = -1;

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if ((id = Shop_Nearest(playerid)) != -1)
		return SendClientMessageEx(playerid, COLOR_YELLOW, "- �س������� Shop id: %d", id);

	return 1;
}
Shop_Delete(shopid)
{
	if (shopid != -1 && shopData[shopid][shopExists])
	{
	    static
	        string[64];

        if (IsValidDynamicPickup(shopData[shopid][shopPickup]))
		    DestroyDynamicPickup(shopData[shopid][shopPickup]);

		if (IsValidDynamic3DTextLabel(shopData[shopid][shopText3D]))
		    DestroyDynamic3DTextLabel(shopData[shopid][shopText3D]);

		mysql_format(g_SQL, string, sizeof(string), "DELETE FROM `shops` WHERE `shopID` = '%d'", shopData[shopid][shopID]);
		mysql_tquery(g_SQL, string);

		shopData[shopid][shopExists] = false;
		shopData[shopid][shopID] = 0;
	}
	return 1;
}
Shop_Create(Float:x, Float:y, Float:z, interior, world, type)
{
	for (new i = 0; i < MAX_SHOPS; i ++) if (!shopData[i][shopExists])
	{
	    shopData[i][shopExists] = true;
	    shopData[i][shopPosX] = x;
	    shopData[i][shopPosY] = y;
	    shopData[i][shopPosZ] = z;
	    shopData[i][shopInterior] = interior;
	    shopData[i][shopWorld] = world;
		shopData[i][shopType] = type;

	    mysql_tquery(g_SQL, "INSERT INTO `shops` (`shopInterior`) VALUES(0)", "OnShopCreated", "d", i);
		Shop_Refresh(i);
		return i;
	}
	return -1;
}
Shop_Save(shopid)
{
	static
	    query[280];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE `shops` SET `shopX` = '%.4f', `shopY` = '%.4f', `shopZ` = '%.4f', `shopInterior` = '%d', `shopWorld` = '%d' , `shopType` = '%d' WHERE `shopID` = '%d'",
	    shopData[shopid][shopPosX],
	    shopData[shopid][shopPosY],
	    shopData[shopid][shopPosZ],
	    shopData[shopid][shopInterior],
	    shopData[shopid][shopWorld],
		shopData[shopid][shopType],
	    shopData[shopid][shopID]
	);
	return mysql_tquery(g_SQL, query);
}
Shop_Nearest(playerid)
{
    for (new i = 0; i != MAX_SHOPS; i ++) if (shopData[i][shopExists] && IsPlayerInRangeOfPoint(playerid, 2.0, shopData[i][shopPosX], shopData[i][shopPosY], shopData[i][shopPosZ]))
	{
		if (GetPlayerInterior(playerid) == shopData[i][shopInterior] && GetPlayerVirtualWorld(playerid) == shopData[i][shopWorld])
			return i;
	}
	return -1;
}
Shop_Refresh(shopid)
{
	if (shopid != -1 && shopData[shopid][shopExists])
	{
		if (IsValidDynamicPickup(shopData[shopid][shopPickup]))
		    DestroyDynamicPickup(shopData[shopid][shopPickup]);

		if (IsValidDynamic3DTextLabel(shopData[shopid][shopText3D]))
		    DestroyDynamic3DTextLabel(shopData[shopid][shopText3D]);

		if (shopData[shopid][shopType] == 1) //��ҹ����ػ�ó�ӧҹ
		{
			shopData[shopid][shopPickup] = CreateDynamicPickup(1239, 23, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
	  		shopData[shopid][shopText3D] = CreateDynamic3DTextLabel("[Business] : Equipment Store\n{AAAAAA}�� 'Y' ������ҹ", COLOR_YELLOW, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], 5.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
		}
		if (shopData[shopid][shopType] == 2) //��ѧ�Թ�׹
		{
			shopData[shopid][shopPickup] = CreateDynamicPickup(2057, 23, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
	  		shopData[shopid][shopText3D] = CreateDynamic3DTextLabel("[��ѧ�Թ�׹]\n�� 'Y' ������ҹ", COLOR_ORANGE, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], 5.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
		}
		if (shopData[shopid][shopType] == 3) //��ҹ�������ͼ��
		{
			shopData[shopid][shopPickup] = CreateDynamicPickup(1275, 23, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
	  		shopData[shopid][shopText3D] = CreateDynamic3DTextLabel("[Business] : Skin Shop\n{AAAAAA}�� 'Y' �������͡����", COLOR_ORANGE, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], 5.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
		}
		if (shopData[shopid][shopType] == 4) //��Ф�ҿ���ظ
		{
			shopData[shopid][shopPickup] = CreateDynamicPickup(1254, 23, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
	  		shopData[shopid][shopText3D] = CreateDynamic3DTextLabel("[��ҿ���ظ]\n�� 'Y' ������ҹ", COLOR_ORANGE, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], 5.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
		}
        if (shopData[shopid][shopType] == 5) //24/7
        {
	  		shopData[shopid][shopText3D] = CreateDynamic3DTextLabel("[Business] : 24/7\n{AAAAAA}�� 'Y' �������͡����", COLOR_YELLOW, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], 5.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
			shopData[shopid][shopPickup] = CreateDynamicPickup(1239, 23, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
		}
        if (shopData[shopid][shopType] == 6) //��ҹ���
        {
	  		shopData[shopid][shopText3D] = CreateDynamic3DTextLabel("[Market] : �Ѻ���ͧ͢\n{AAAAAA}�� 'Y' ������ҹ", COLOR_YELLOW, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], 5.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
			shopData[shopid][shopPickup] = CreateDynamicPickup(1239, 23, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
		}
        if (shopData[shopid][shopType] == 7) //��Ф�ҿ
        {
	  		shopData[shopid][shopText3D] = CreateDynamic3DTextLabel("[��ҿ�ػ�ó�]\n{AAAAAA}�� 'Y' ������ҹ", COLOR_YELLOW, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], 5.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
			shopData[shopid][shopPickup] = CreateDynamicPickup(1239, 23, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
		}
        if (shopData[shopid][shopType] == 8) //VehiclesShop (Classic)
        {
	  		shopData[shopid][shopText3D] = CreateDynamic3DTextLabel("VehiclesShop : Classic\n{AAAAAA}�� 'Y' ������ҹ", COLOR_ORANGE, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], 5.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
			shopData[shopid][shopPickup] = CreateDynamicPickup(1239, 23, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
		}
        if (shopData[shopid][shopType] == 9) //VehiclesShop (Pick up)
        {
	  		shopData[shopid][shopText3D] = CreateDynamic3DTextLabel("VehiclesShop : Pick up\n{AAAAAA}�� 'Y' ������ҹ", COLOR_ORANGE, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], 5.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
			shopData[shopid][shopPickup] = CreateDynamicPickup(1239, 23, shopData[shopid][shopPosX], shopData[shopid][shopPosY], shopData[shopid][shopPosZ], shopData[shopid][shopWorld], shopData[shopid][shopInterior]);
		}
	}
	return 1;
}
ApplyAnimationWearClothes(playerid)
{
	switch(random(3))
	{
		case 0:
			return ApplyAnimation(playerid, "CLOTHES","CLO_Pose_Legs", 4.1, 0, 0, 0, 0, 0, 1);

		case 1:
			return ApplyAnimation(playerid, "CLOTHES","CLO_Pose_Shoes", 4.1, 0, 0, 0, 0, 0, 1);

		case 2:
			return ApplyAnimation(playerid, "CLOTHES","CLO_Pose_Torso", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}