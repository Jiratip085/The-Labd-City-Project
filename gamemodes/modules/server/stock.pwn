#include <YSI\y_hooks>

stock LoadPlayerTextdraw(playerid)
{
    Footer[playerid] = CreatePlayerTextDraw(playerid, 117.600044, 306.631042, "~r~Footer text.");
	PlayerTextDrawLetterSize(playerid, Footer[playerid], 0.226797, 1.206755);
	PlayerTextDrawAlignment(playerid, Footer[playerid], 1);
	PlayerTextDrawColor(playerid, Footer[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Footer[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Footer[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Footer[playerid], 255);
	PlayerTextDrawFont(playerid, Footer[playerid], 2);
	PlayerTextDrawSetProportional(playerid, Footer[playerid], 1);

	Speedo[playerid] = CreatePlayerTextDraw(playerid, 503.199584, 109.510925, " ");
	PlayerTextDrawLetterSize(playerid, Speedo[playerid], 0.425999, 1.380147);
	PlayerTextDrawAlignment(playerid, Speedo[playerid], 1);
	PlayerTextDrawColor(playerid, Speedo[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Speedo[playerid], 2);
	PlayerTextDrawSetOutline(playerid, Speedo[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Speedo[playerid], 255);
	PlayerTextDrawFont(playerid, Speedo[playerid], 3);
	PlayerTextDrawSetProportional(playerid, Speedo[playerid], 1);

	//Characters
	Characters[playerid][0] = CreatePlayerTextDraw(playerid, 74.666702, 133.999969, "box");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][0], 0.000000, 19.300006);
	PlayerTextDrawTextSize(playerid, Characters[playerid][0], 180.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][0], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][0], -125);
	PlayerTextDrawUseBox(playerid, Characters[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, Characters[playerid][0], 71);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][0], 205);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][0], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][0], 0);

	Characters[playerid][1] = CreatePlayerTextDraw(playerid, 84.333328, 142.555526, "");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Characters[playerid][1], 90.000000, 90.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][1], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][1], 0);
	PlayerTextDrawFont(playerid, Characters[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, Characters[playerid][1], 1);
	PlayerTextDrawSetPreviewRot(playerid, Characters[playerid][1], 0.000000, 0.000000, 0.000000, 1.000000);

	Characters[playerid][2] = CreatePlayerTextDraw(playerid, 75.000015, 232.311111, "box");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][2], 0.000000, 1.233332);
	PlayerTextDrawTextSize(playerid, Characters[playerid][2], 180.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][2], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][2], -1);
	PlayerTextDrawUseBox(playerid, Characters[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid, Characters[playerid][2], 255);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][2], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][2], 0);

	Characters[playerid][3] = CreatePlayerTextDraw(playerid, 106.333374, 232.725952, "James_Lucas");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][3], 0.229000, 0.940443);
	PlayerTextDrawAlignment(playerid, Characters[playerid][3], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][3], -5111553);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][3], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][3], 0);

	Characters[playerid][4] = CreatePlayerTextDraw(playerid, 75.000022, 248.903732, "box");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][4], 0.000000, 1.233332);
	PlayerTextDrawTextSize(playerid, Characters[playerid][4], 180.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][4], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][4], -1);
	PlayerTextDrawUseBox(playerid, Characters[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid, Characters[playerid][4], 255);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][4], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][4], 0);

	Characters[playerid][5] = CreatePlayerTextDraw(playerid, 76.666694, 249.318588, "LEVEL_-_");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][5], 0.229000, 0.940443);
	PlayerTextDrawAlignment(playerid, Characters[playerid][5], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][5], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][5], 0);

	Characters[playerid][6] = CreatePlayerTextDraw(playerid, 76.666702, 233.140808, "NAME_-");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][6], 0.229000, 0.940443);
	PlayerTextDrawAlignment(playerid, Characters[playerid][6], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][6], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][6], 0);

	Characters[playerid][7] = CreatePlayerTextDraw(playerid, 107.000045, 249.733352, "50");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][7], 0.229000, 0.940443);
	PlayerTextDrawAlignment(playerid, Characters[playerid][7], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][7], -5111553);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][7], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][7], 0);

	Characters[playerid][8] = CreatePlayerTextDraw(playerid, 84.333374, 277.940917, "SELECT_CHARACTER");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][8], 0.290666, 1.338667);
	PlayerTextDrawTextSize(playerid, Characters[playerid][8], 170.000000, 20.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][8], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][8], -5111553);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][8], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, Characters[playerid][8], true);

	Characters[playerid][9] = CreatePlayerTextDraw(playerid, 270.333312, 134.414779, "box");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][9], 0.000000, 19.300006);
	PlayerTextDrawTextSize(playerid, Characters[playerid][9], 376.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][9], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][9], -125);
	PlayerTextDrawUseBox(playerid, Characters[playerid][9], 1);
	PlayerTextDrawBoxColor(playerid, Characters[playerid][9], 71);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][9], 205);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][9], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][9], 0);

	Characters[playerid][10] = CreatePlayerTextDraw(playerid, 277.666748, 142.555465, "");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][10], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Characters[playerid][10], 90.000000, 90.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][10], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][10], 0);
	PlayerTextDrawFont(playerid, Characters[playerid][10], 5);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][10], 0);
	PlayerTextDrawSetPreviewModel(playerid, Characters[playerid][10], 1);
	PlayerTextDrawSetPreviewRot(playerid, Characters[playerid][10], 0.000000, 0.000000, 0.000000, 1.000000);

	Characters[playerid][11] = CreatePlayerTextDraw(playerid, 270.666717, 232.311111, "box");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][11], 0.000000, 1.199998);
	PlayerTextDrawTextSize(playerid, Characters[playerid][11], 376.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][11], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][11], -1);
	PlayerTextDrawUseBox(playerid, Characters[playerid][11], 1);
	PlayerTextDrawBoxColor(playerid, Characters[playerid][11], 255);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][11], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][11], 0);

	Characters[playerid][12] = CreatePlayerTextDraw(playerid, 301.666748, 232.725906, "James_Lucas");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][12], 0.229000, 0.940443);
	PlayerTextDrawAlignment(playerid, Characters[playerid][12], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][12], -5111553);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][12], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][12], 0);

	Characters[playerid][13] = CreatePlayerTextDraw(playerid, 270.666687, 248.074111, "box");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][13], 0.000000, 1.199998);
	PlayerTextDrawTextSize(playerid, Characters[playerid][13], 376.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][13], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][13], -1);
	PlayerTextDrawUseBox(playerid, Characters[playerid][13], 1);
	PlayerTextDrawBoxColor(playerid, Characters[playerid][13], 255);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][13], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][13], 0);

	Characters[playerid][14] = CreatePlayerTextDraw(playerid, 272.333374, 248.903762, "LEVEL_-_");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][14], 0.229000, 0.940443);
	PlayerTextDrawAlignment(playerid, Characters[playerid][14], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][14], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][14], 0);

	Characters[playerid][15] = CreatePlayerTextDraw(playerid, 272.000122, 233.140823, "NAME_-");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][15], 0.229000, 0.940443);
	PlayerTextDrawAlignment(playerid, Characters[playerid][15], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][15], -1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][15], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][15], 0);

	Characters[playerid][16] = CreatePlayerTextDraw(playerid, 303.666656, 249.318557, "50");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][16], 0.229000, 0.940443);
	PlayerTextDrawAlignment(playerid, Characters[playerid][16], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][16], -5111553);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][16], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][16], 0);

	Characters[playerid][17] = CreatePlayerTextDraw(playerid, 280.666931, 277.526062, "SELECT_CHARACTER");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][17], 0.290666, 1.338667);
	PlayerTextDrawTextSize(playerid, Characters[playerid][17], 366.000000, 20.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][17], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][17], -5111553);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][17], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][17], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][17], 0);
	PlayerTextDrawSetSelectable(playerid, Characters[playerid][17], true);

	Characters[playerid][18] = CreatePlayerTextDraw(playerid, 463.666687, 133.170379, "box");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][18], 0.000000, 19.300006);
	PlayerTextDrawTextSize(playerid, Characters[playerid][18], 570.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][18], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][18], -125);
	PlayerTextDrawUseBox(playerid, Characters[playerid][18], 1);
	PlayerTextDrawBoxColor(playerid, Characters[playerid][18], 71);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][18], 205);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][18], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][18], 0);

	Characters[playerid][19] = CreatePlayerTextDraw(playerid, 472.666717, 142.140655, "");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][19], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Characters[playerid][19], 90.000000, 90.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][19], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][19], -1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][19], 0);
	PlayerTextDrawFont(playerid, Characters[playerid][19], 5);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][19], 0);
	PlayerTextDrawSetPreviewModel(playerid, Characters[playerid][19], 1);
	PlayerTextDrawSetPreviewRot(playerid, Characters[playerid][19], 0.000000, 0.000000, 0.000000, 1.000000);

	Characters[playerid][20] = CreatePlayerTextDraw(playerid, 463.333435, 232.725921, "box");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][20], 0.000000, 1.233332);
	PlayerTextDrawTextSize(playerid, Characters[playerid][20], 570.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][20], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][20], -1);
	PlayerTextDrawUseBox(playerid, Characters[playerid][20], 1);
	PlayerTextDrawBoxColor(playerid, Characters[playerid][20], 255);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][20], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][20], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][20], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][20], 0);

	Characters[playerid][21] = CreatePlayerTextDraw(playerid, 496.000152, 233.140762, "James_Lucas");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][21], 0.229000, 0.940443);
	PlayerTextDrawAlignment(playerid, Characters[playerid][21], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][21], -5111553);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][21], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][21], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][21], 0);

	Characters[playerid][22] = CreatePlayerTextDraw(playerid, 463.666748, 248.488922, "box");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][22], 0.000000, 1.233332);
	PlayerTextDrawTextSize(playerid, Characters[playerid][22], 570.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][22], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][22], -1);
	PlayerTextDrawUseBox(playerid, Characters[playerid][22], 1);
	PlayerTextDrawBoxColor(playerid, Characters[playerid][22], 255);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][22], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][22], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][22], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][22], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][22], 0);

	Characters[playerid][23] = CreatePlayerTextDraw(playerid, 465.666625, 249.318664, "LEVEL_-_");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][23], 0.229000, 0.940443);
	PlayerTextDrawAlignment(playerid, Characters[playerid][23], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][23], -1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][23], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][23], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][23], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][23], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][23], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][23], 0);

	Characters[playerid][24] = CreatePlayerTextDraw(playerid, 465.333404, 233.555618, "NAME_-");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][24], 0.229000, 0.940443);
	PlayerTextDrawAlignment(playerid, Characters[playerid][24], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][24], -1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][24], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][24], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][24], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][24], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][24], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][24], 0);

	Characters[playerid][25] = CreatePlayerTextDraw(playerid, 497.000030, 249.318588, "50");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][25], 0.229000, 0.940443);
	PlayerTextDrawAlignment(playerid, Characters[playerid][25], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][25], -5111553);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][25], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][25], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][25], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][25], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][25], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][25], 0);

	Characters[playerid][26] = CreatePlayerTextDraw(playerid, 475.333618, 278.355926, "SELECT_CHARACTER");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][26], 0.290666, 1.338667);
	PlayerTextDrawTextSize(playerid, Characters[playerid][26], 561.000000, 20.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][26], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][26], -5111553);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][26], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][26], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][26], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][26], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][26], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][26], 0);
	PlayerTextDrawSetSelectable(playerid, Characters[playerid][26], true);

	Characters[playerid][27] = CreatePlayerTextDraw(playerid, 76.333374, 136.488922, "82");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][27], 0.229000, 0.940443);
	PlayerTextDrawAlignment(playerid, Characters[playerid][27], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][27], -1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][27], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][27], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][27], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][27], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][27], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][27], 0);

	Characters[playerid][28] = CreatePlayerTextDraw(playerid, 272.666717, 135.659271, "82");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][28], 0.229000, 0.940443);
	PlayerTextDrawAlignment(playerid, Characters[playerid][28], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][28], -1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][28], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][28], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][28], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][28], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][28], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][28], 0);

	Characters[playerid][29] = CreatePlayerTextDraw(playerid, 466.000091, 134.414810, "82");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][29], 0.229000, 0.940443);
	PlayerTextDrawAlignment(playerid, Characters[playerid][29], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][29], -1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][29], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][29], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][29], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][29], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][29], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][29], 0);

	Characters[playerid][30] = CreatePlayerTextDraw(playerid, 94.333374, 214.059265, "Create_character");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][30], 0.239998, 1.218371);
	PlayerTextDrawTextSize(playerid, Characters[playerid][30], 161.000000, 20.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][30], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][30], -5111553);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][30], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][30], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][30], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][30], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][30], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][30], 0);
	PlayerTextDrawSetSelectable(playerid, Characters[playerid][30], true);

	Characters[playerid][31] = CreatePlayerTextDraw(playerid, 291.333038, 215.303756, "Create_character");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][31], 0.239998, 1.218371);
	PlayerTextDrawTextSize(playerid, Characters[playerid][31], 356.000000, 20.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][31], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][31], -5111553);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][31], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][31], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][31], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][31], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][31], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][31], 0);
	PlayerTextDrawSetSelectable(playerid, Characters[playerid][31], true);

	Characters[playerid][32] = CreatePlayerTextDraw(playerid, 485.333251, 215.303695, "Create_character");
	PlayerTextDrawLetterSize(playerid, Characters[playerid][32], 0.239998, 1.218371);
	PlayerTextDrawTextSize(playerid, Characters[playerid][32], 551.000000, 20.000000);
	PlayerTextDrawAlignment(playerid, Characters[playerid][32], 1);
	PlayerTextDrawColor(playerid, Characters[playerid][32], -5111553);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][32], 0);
	PlayerTextDrawSetOutline(playerid, Characters[playerid][32], 0);
	PlayerTextDrawBackgroundColor(playerid, Characters[playerid][32], 255);
	PlayerTextDrawFont(playerid, Characters[playerid][32], 1);
	PlayerTextDrawSetProportional(playerid, Characters[playerid][32], 1);
	PlayerTextDrawSetShadow(playerid, Characters[playerid][32], 0);
	PlayerTextDrawSetSelectable(playerid, Characters[playerid][32], true);
}

stock GetPosBehindVehicle(vehicleid, &Float:x, &Float:y, &Float:z, Float:offset=0.5)
{
    new Float:vehicleSize[3], Float:vehiclePos[3];
    GetVehiclePos(vehicleid, vehiclePos[0], vehiclePos[1], vehiclePos[2]);
    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, vehicleSize[0], vehicleSize[1], vehicleSize[2]);
    GetXYBehindVehicle(vehicleid, vehiclePos[0], vehiclePos[1], (vehicleSize[1]/2)+offset);
    x = vehiclePos[0];
    y = vehiclePos[1];
    z = vehiclePos[2];
    return 1;
}

stock IsPlayerInRangeOfVehicle(playerid, vehicleid, Float: radius) {

	new
		Float:Floats[3];

	GetVehiclePos(vehicleid, Floats[0], Floats[1], Floats[2]);
	return IsPlayerInRangeOfPoint(playerid, radius, Floats[0], Floats[1], Floats[2]);
}

//Lumberjack
stock SetWoodDown(woodid)
{
	new rxr = random(1),rxpos;
	new ryr = random((90 - (-90))) + -90;

	if(rxr == 1)
	{
		rxpos = 90;
	}
	else
	{
		rxpos = -90;
	}

	MoveDynamicObject(WoodInfo[woodid][woodObject],WoodInfo[woodid][wX],WoodInfo[woodid][wY],WoodInfo[woodid][wZ]+1, 0.5 ,rxpos,ryr,18.0000000);

	return 1;
}

stock PlayerUpdateListener(playerid)
{
    new str[128], keys[3];

    GetPlayerKeys(playerid, keys[0], keys[1], keys[2]);
	
    if ((keys[0] & KEY_FIRE) && !IsAFK{playerid})
	{
	    if(GetPlayerWeapon(playerid) == 41)
	    {
		    static spraying[MAX_PLAYERS];

		    if(Character[playerid][MecStep] == 2)
			{
		 		new vid = Character[playerid][MecCar];

				new mechveh = Character[playerid][MecTow];

				new carindex = Car_GetID(vid);

				new useprod = Character[playerid][MecProd];

				new type = Character[playerid][MecType];

				if(IsPlayerFacingVehicle(playerid,vid))
				{
		  			if(CoreVehicles[mechveh][vehComponent] > 0)
		     		{
		       			CoreVehicles[mechveh][vehComponent]--;
		          		spraying[playerid]++;
					}
					else
					{
						Character[playerid][MecType] = 0;
						Character[playerid][MecStep] = 0;
						Character[playerid][MecCar] = INVALID_VEHICLE_ID;
						Character[playerid][MecTow] = INVALID_VEHICLE_ID;

						ResetWeapon(playerid, 41);
		    			ShowPlayerFooter(playerid, "~p~towtrucks out of products.");
						return 1;
					}

					switch(type)
					{
						case 1:
						{
							format(str, sizeof(str), "~p~Repairing Engine~n~~w~Towtrucks has %d amount of product left.~n~~y~TIME LEFT: %d", CoreVehicles[mechveh][vehComponent], useprod - spraying[playerid]);
			    			ShowPlayerFooter(playerid, str);
						}
						case 2:
						{
							format(str, sizeof(str), "~p~Repairing the bodywork~n~~w~Towtrucks has %d amount of product left.~n~~y~TIME LEFT: %d", CoreVehicles[mechveh][vehComponent], useprod - spraying[playerid]);
			    			ShowPlayerFooter(playerid, str);
						}
						case 3:
						{
							format(str, sizeof(str), "~p~Jumping battery~n~~w~Towtrucks has %d amount of product left.~n~~y~TIME LEFT: %d", CoreVehicles[mechveh][vehComponent], useprod - spraying[playerid]);
			    			ShowPlayerFooter(playerid, str);
						}
						case 4:
						{
							format(str, sizeof(str), "~p~Restoring Engine~n~~w~Towtrucks has %d amount of product left.~n~~y~TIME LEFT: %d", CoreVehicles[mechveh][vehComponent], useprod - spraying[playerid]);
			    			ShowPlayerFooter(playerid, str);
						}
						case 5:
						{
							format(str, sizeof(str), "~p~Painting~n~~w~Towtrucks has %d amount of product left.~n~~y~TIME LEFT: %d", CoreVehicles[mechveh][vehComponent], useprod - spraying[playerid]);
			    			ShowPlayerFooter(playerid, str);
						}
					}


					if(spraying[playerid] >= useprod)
					{
						switch(type)
						{
		    				case 1:
							{
			    				if(GetVehicleDriver(vid) != INVALID_PLAYER_ID)
							    {
						    		SetPVarInt(GetVehicleDriver(vid), "VehicleRepair", 1);
							    }
								SetVehicleHealth(vid, 1000.0);
				    			ShowPlayerFooter(playerid, "~p~Repaired Engine");
							}
			    			case 2:
							{
		     					ResetVehicleDamage(vid);
		       					SetVehicleDamage(vid);

								ShowPlayerFooter(playerid, "~p~Succesfully Repaired the bodywork.");
							}
			    			case 3:
							{
			    				CarData[carindex][carBatteryL] = 500;
							    ShowPlayerFooter(playerid, "~p~Jumped battery.");
							}
			    			case 4:
							{
			    				CarData[carindex][carEngineL] = 500;
							    ShowPlayerFooter(playerid, "~p~Succesfully Restored Engine.");
							}
		 					case 5:
							{
			    				SetVehicleColor(vid, Character[playerid][MecCol1], Character[playerid][MecCol2]);
							    ShowPlayerFooter(playerid, "~p~Succesfully Painted.");
							}
						}

						foreach(new i: Player)
						{
							if (Character[i][MecOffer] == playerid)
							{
		     					if(Character[i][Cash] < Character[playerid][MecPrice])
								{
				    				SendClientMessage(playerid, -1,"ผู้เล่นนั้นมีเงินไม่เพียงพอ");
								    SendClientMessage(i, -1,"คุณมีเงินไม่เพียงพอ");
								    CoreVehicles[mechveh][vehComponent] += useprod;
								    break;
								}

								GiveMoney(playerid, Character[playerid][MecPrice], "Job Machanic from %s", ReturnRealName(i, 0));
			    				GiveMoney(i, -Character[playerid][MecPrice], "Job Machanic to %s", ReturnRealName(playerid, 0));
						    	break;
							}
						}


						spraying[playerid] = 0;
						Character[playerid][MecType] = 0;
						Character[playerid][MecStep] = 0;
						Character[playerid][MecPrice] = 0;
						Character[playerid][MecCol1] = 0;
						Character[playerid][MecCol2] = 0;
						Character[playerid][MecCar] = INVALID_VEHICLE_ID;
						Character[playerid][MecTow] = INVALID_VEHICLE_ID;
			   			ResetWeapon(playerid, 41);
					}
				}
			}
		}
	}
	return 1;
}

//boombox
stock Boombox_Place(playerid)
{
	new
	    Float:angle;

	GetPlayerFacingAngle(playerid, angle);

	strpack(BoomboxData[playerid][boomboxURL], "", 128 char);
	GetPlayerPos(playerid, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2]);

	BoomboxData[playerid][boomboxPlaced] = true;
	BoomboxData[playerid][boomboxInterior] = GetPlayerInterior(playerid);
	BoomboxData[playerid][boomboxWorld] = GetPlayerVirtualWorld(playerid);

    BoomboxData[playerid][boomboxObject] = CreateDynamicObject(2226, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2] - 0.9, 0.0, 0.0, angle, BoomboxData[playerid][boomboxWorld], BoomboxData[playerid][boomboxInterior]);
    BoomboxData[playerid][boomboxText3D] = CreateDynamic3DTextLabel("[Boombox]\n{FFFFFF}/boombox เพื่อใช้ boombox นี้", COLOR_DARKBLUE, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2] - 0.7, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BoomboxData[playerid][boomboxWorld], BoomboxData[playerid][boomboxInterior]);

	return 1;
}

stock Boombox_Nearest(playerid)
{
	foreach (new i : Player) if (BoomboxData[i][boomboxPlaced] && GetPlayerInterior(playerid) == BoomboxData[i][boomboxInterior] && GetPlayerVirtualWorld(playerid) == BoomboxData[i][boomboxWorld] && IsPlayerInRangeOfPoint(playerid, 30.0, BoomboxData[i][boomboxPos][0], BoomboxData[i][boomboxPos][1], BoomboxData[i][boomboxPos][2])) {
     	return i;
	}
	return INVALID_PLAYER_ID;
}

stock Boombox_SetURL(playerid, url[])
{
	if (BoomboxData[playerid][boomboxPlaced])
	{
	    strpack(BoomboxData[playerid][boomboxURL], url, 128 char);

	    foreach (new i : Player) if (Character[i][Boombox] == playerid) {
	        StopAudioStreamForPlayer(i);
	        PlayAudioStreamForPlayer(i, url, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2], 30.0, 1);
		}
	}
	return 1;
}

stock Boombox_Destroy(playerid)
{
	if (BoomboxData[playerid][boomboxPlaced])
	{
		if (IsValidDynamicObject(BoomboxData[playerid][boomboxObject]))
		    DestroyDynamicObject(BoomboxData[playerid][boomboxObject]);

		if (IsValidDynamic3DTextLabel(BoomboxData[playerid][boomboxText3D]))
		    DestroyDynamic3DTextLabel(BoomboxData[playerid][boomboxText3D]);

		foreach (new i : Player) if (Character[i][Boombox] == playerid) {
		    StopAudioStreamForPlayer(i);
		}
        BoomboxData[playerid][boomboxPlaced] = false;
        BoomboxData[playerid][boomboxInterior] = 0;
        BoomboxData[playerid][boomboxWorld] = 0;
	}
	return 1;
}


stock TerminateConnection(playerid)
{
    if (BoomboxData[playerid][boomboxPlaced])
		Boombox_Destroy(playerid);

    if (Character[playerid][ShowFooter])
	    KillTimer(Character[playerid][FooterTimer]);

    if (Character[playerid][FirstAid])
	    KillTimer(Character[playerid][AidTimer]);

	foreach (new i : Player)
	{
		if (Character[i][MecOffer] == playerid)
		{
  			Character[i][MecOffer] = INVALID_PLAYER_ID;
		}
		if (Character[i][FactionOffer] == playerid) {
		    Character[i][FactionOffer] = INVALID_PLAYER_ID;
		    Character[i][FactionOffered] = -1;
		}
		/*if (Character[i][MDCPlayer] == playerid) {
		    Character[i][MDCPlayer] = INVALID_PLAYER_ID;
		    Character[i][TrackTime] = 0;
		}*/
	}

    Character_Reset(playerid);
	return 1;
}

stock Log(playerid, string[])
{
	new File:logfile, logentry[255], time[3], date[3], datestr[11], filepath[48];
	gettime(time[0], time[1], time[2]);
    getdate(date[0], date[1], date[2]);
	format(logentry, sizeof logentry, "[%02d:%02d:%02d] %s(%d): %s\r\n", time[0], time[1], time[2], GetName(playerid), playerid, string);
    format(datestr, sizeof datestr, "%02d-%02d-%d", date[2], date[1], date[0]);
    format(filepath, sizeof filepath, LOG_PATH, datestr);
    logfile = fopen(filepath, io_append);

    if(logfile)
    {
        fwrite(logfile, logentry);
        fclose(logfile);
    }
	return 1;
}

stock IsPlayerIdle(playerid) {
	new
	    index = GetPlayerAnimationIndex(playerid);

	return ((index == 1275) || (1181 <= index <= 1192));
}

stock ShowContacts(playerid)
{
	new
	    string[32 * MAX_CONTACTS],
		count = 0;

	string = "Add Contact\n";

	for (new i = 0; i != MAX_CONTACTS; i ++) if (ContactData[playerid][i][contactExists]) {
	    format(string, sizeof(string), "%s%s - #%d\n", string, ContactData[playerid][i][contactName], ContactData[playerid][i][contactNumber]);

		ListedContacts[playerid][count++] = i;
	}
	Dialog_Show(playerid, Contacts, DIALOG_STYLE_LIST, "My Contacts", string, "Select", "Back");
	return 1;
}

stock CancelCall(playerid)
{
    if (Character[playerid][CallLine] != INVALID_PLAYER_ID)
	{
 		Character[Character[playerid][CallLine]][CallLine] = INVALID_PLAYER_ID;
   		Character[Character[playerid][CallLine]][IncomingCall] = 0;

		Character[playerid][CallLine] = INVALID_PLAYER_ID;
		Character[playerid][IncomingCall] = 0;
	}
	return 1;
}

stock ApplyAnimationEx(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync = 0)
{
	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);

	LoopAnim[playerid] = true;
	ShowPlayerFooter(playerid, "~w~Press~w~ Right Click  ~w~to stop the animation.");

	return 1;
}



stock FetchChannelSlot(slot, channel)
{

	for(new i = 0; i < MAX_RADIO; i ++)
	{

	    if(RadioInfo[i][rChannel] == channel && RadioInfo[i][rSlot] == slot) return i;

	}
	return -1;

}

stock GetInitials(const string[])
{
	new
	    ret[32],
		index = 0;

	for (new i = 0, l = strlen(string); i != l; i ++)
	{
	    if (('A' <= string[i] <= 'Z') && (i == 0 || string[i - 1] == ' '))
			ret[index++] = string[i];
	}
	return ret;
}

stock IsACruiser(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
	    case 523, 427, 490, 528, 596..599, 601: return 1;
	}
	return 0;
}

stock GetEntranceByID(sqlid)
{
	for (new i = 0; i != MAX_ENTRANCES; i ++) if (EntranceData[i][entranceExists] && EntranceData[i][entranceID] == sqlid)
	    return i;

	return -1;
}

stock GetLocation(Float:fX, Float:fY, Float:fZ)
{
	new
	    name[32] = "San Andreas";

	for (new i = 0; i != sizeof(g_arrZoneData); i ++) if ((fX >= g_arrZoneData[i][e_ZoneArea][0] && fX <= g_arrZoneData[i][e_ZoneArea][3]) && (fY >= g_arrZoneData[i][e_ZoneArea][1] && fY <= g_arrZoneData[i][e_ZoneArea][4]) && (fZ >= g_arrZoneData[i][e_ZoneArea][2] && fZ <= g_arrZoneData[i][e_ZoneArea][5])) {
		strunpack(name, g_arrZoneData[i][e_ZoneName]);

		break;
	}
	return name;
}

stock PlayerPlaySoundEx(playerid, sound)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(playerid, x, y, z);

	foreach (new i : Player) if (IsPlayerInRangeOfPoint(i, 20.0, x, y, z)) {
	    PlayerPlaySound(i, sound, x, y, z);
	}
	return 1;
}

stock GetIDFromName(sqlid)
{
	new pname[MAX_PLAYER_NAME], query[64], string[32];
	mysql_format(dbCon, query, sizeof(query), "SELECT * FROM `characters` WHERE `ID` = %d", sqlid);
	mysql_query(dbCon, query);

    new
		rows;

    cache_get_row_count(rows);
    if(rows)
    {
		cache_get_value_name(0, "Name", string);
		format(pname, sizeof(pname), string);
    }
	return pname;
}


GetPlayerSQLID(playerid)
{
	return (Character[playerid][ID]);
}

stock ReturnWeaponName(weaponid)
{
	new name[32];
	GetWeaponName(weaponid, name, sizeof(name));
	if(weaponid == 0) format(name, sizeof(name), "None");
	return name;
}

stock AngleInRangeOfAngle(Float:a1, Float:a2, Float:range)
{
	a1 -= a2;
	if((a1 < range) && (a1 > -range)) return true;

	return false;
}

stock IsPlayerFacingPlayer(playerid, targetid, Float:dOffset)
{
	new
		Float:pX,
		Float:pY,
		Float:pZ,
		Float:pA,
		Float:X,
		Float:Y,
		Float:Z,
		Float:ang;

	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return 0;

	GetPlayerPos(targetid, pX, pY, pZ);
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, pA);

	if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	return AngleInRangeOfAngle(-ang, pA, dOffset);
}

stock Float:GetPlayerDistanceFromPlayer(playerid, targetid)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(targetid, x, y, z);
	return GetPlayerDistanceFromPoint(playerid, x, y, z);
}

stock SetHoodStatus(vehicleid, bool:status)
{
	new
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, status, boot, objective);
}

stock IsPlayerNearHood(playerid, vehicleid)
{
	new
		Float:fX,
		Float:fY,
		Float:fZ;

	GetVehicleHood(vehicleid, fX, fY, fZ);

	return (GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vehicleid)) && IsPlayerInRangeOfPoint(playerid, 3.0, fX, fY, fZ);
}

stock IsLoadableVehicle(vehicleid)
{
	new modelid = GetVehicleModel(vehicleid);

	if (GetVehicleTrailer(vehicleid))
	    modelid = GetVehicleModel(GetVehicleTrailer(vehicleid));

	switch (modelid) {
	    case 609, 403, 414, 456, 498, 499, 514, 515, 435, 591: return 1;
	}
	return 0;
}

stock GetVehicleHood(vehicleid, &Float:x, &Float:y, &Float:z)
{
    if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID)
	    return (x = 0.0, y = 0.0, z = 0.0), 0;

	new
	    Float:pos[7]
	;
	GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]);
	GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]);
	GetVehicleZAngle(vehicleid, pos[6]);

	x = pos[3] + (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees));
	y = pos[4] + (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees));
 	z = pos[5];

	return 1;
}

stock SetVehiclePosEx(vehicleid,Float:X, Float:Y, Float:Z)
{

	vpos[vehicleid][0] = X;
	vpos[vehicleid][1] = Y;
	vpos[vehicleid][2] = Z;
	SetVehiclePos(vehicleid,X,Y,Z);

}

stock SetPlayerPosExten(playerid, Float:x, Float:y, Float:z, time = 2000)
{
	if (Character[playerid][Freeze])
	{
	    KillTimer(Character[playerid][FreezeTimer]);

	    Character[playerid][Freeze] = 0;
	    TogglePlayerControllable(playerid, 1);
	}
	SetPlayerPosEx(playerid, x, y, z + 0.5, Character[playerid][Interior], Character[playerid][VWorld]);
	TogglePlayerControllable(playerid, 0);

	Character[playerid][Freeze] = 1;
	Character[playerid][FreezeTimer] = SetTimerEx("SetPlayerToUnfreeze", time, false, "dfff", playerid, x, y, z);
	return 1;
}

stock RepairVehicleEx(vehicleid)
{
	RepairVehicle(vehicleid);
	ResetVehicleDamage(vehicleid);
}

stock IsPlayerNearBoot(playerid, vehicleid)
{
	new
		Float:fX,
		Float:fY,
		Float:fZ;

	GetVehicleBoot(vehicleid, fX, fY, fZ);

	return (GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vehicleid)) && IsPlayerInRangeOfPoint(playerid, 1.0, fX, fY, fZ);
}

stock GetVehicleBoot(vehicleid, &Float:x, &Float:y, &Float:z)
{
	if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID)
	    return (x = 0.0, y = 0.0, z = 0.0), 0;

	new
	    Float:pos[7]
	;
	GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]);
	GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]);
	GetVehicleZAngle(vehicleid, pos[6]);

	x = pos[3] - (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees));
	y = pos[4] - (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees));
 	z = pos[5];

	return 1;
}

stock IsDoorVehicle(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 400..424, 426..429, 431..440, 442..445, 451, 455, 456, 458, 459, 466, 467, 470, 474, 475:
		    return 1;

		case 477..480, 482, 483, 486, 489, 490..492, 494..496, 498..500, 502..508, 514..518, 524..529, 533..536:
		    return 1;

		case 540..547, 549..552, 554..562, 565..568, 573, 575, 576, 578..580, 582, 585, 587..589, 596..605, 609:
			return 1;
	}
	return 0;
}

stock GetVehiclePanelsDamageStatus(vehicleid, &FrontLeft, &FrontRight, &RearLeft, &RearRight, &WindShield, &FrontBumper, &RearBumper)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	FrontLeft = Panels & 15;
	FrontRight = Panels >> 4 & 15;
	RearLeft = Panels >> 8 & 15;
	RearRight = Panels >> 12 & 15;
	WindShield = Panels >> 16 & 15;
	FrontBumper = Panels >> 20 & 15;
	RearBumper = Panels >> 24 & 15;
	return true;
}

stock GetVehicleDoorsDamageStatus(vehicleid, &Bonnet, &Boot, &FrontLeft, &FrontRight, &RearLeft, &RearRight)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	Bonnet = Doors & 7;
	Boot = Doors >> 8 & 7;
	FrontLeft = Doors >> 16 & 7;
	FrontRight = Doors >> 24 & 7;
	RearLeft = Doors >> 32 & 7;
	RearRight = Doors >> 40 & 7;
	return true;
}

stock GetVehicleLightsDamageStatus(vehicleid, &First, &Second, &Third, &Fourth)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	First = Lights & 1;
	Second = Lights >> 1 & 1;
	Third = Lights >> 2 & 1;
	Fourth = Lights >> 3 & 1;
	return true;
}

stock GetVehicleTiresDamageStatus(vehicleid, &FrontLeft, &FrontRight, &RearLeft, &RearRight)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	if(GetVehicleType(vehicleid) == MOTORBIKE || GetVehicleType(vehicleid) == BIKE) FrontLeft = Tires >> 1 & 1, FrontRight = Tires & 1;
	else
	{
		RearRight = Tires & 1;
		FrontRight = Tires >> 1 & 1;
		RearLeft = Tires >> 2 & 1;
		FrontLeft = Tires >> 3 & 1;
	}
	return true;
}

stock UpdateVehiclePanelsDamageStatus(vehicleid, FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	return UpdateVehicleDamageStatus(vehicleid, FrontLeft | (FrontRight << 4) | (RearLeft << 8) | (RearRight << 12) | (WindShield << 16) | (FrontBumper << 20) | (RearBumper << 24), Doors, Lights, Tires);
}

stock UpdateVehicleDoorsDamageStatus(vehicleid, Bonnet, Boot, FrontLeft, FrontRight, RearLeft, RearRight)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	return UpdateVehicleDamageStatus(vehicleid, Panels, Bonnet | (Boot << 8) | (FrontLeft << 16) | (FrontRight << 24) | (RearLeft << 32) | (RearRight << 40), Lights, Tires);
}

stock UpdateVehicleLightsDamageStatus(vehicleid, First, Second, Third, Fourth)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	return UpdateVehicleDamageStatus(vehicleid, Panels, Doors, First | (Second << 1) | (Third << 2) | (Fourth << 3), Tires);
}


stock UpdateVehicleTiresDamageStatus(vehicleid, FrontLeft, FrontRight, RearLeft, RearRight)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	if(GetVehicleType(vehicleid) == MOTORBIKE || GetVehicleType(vehicleid) == BIKE) return UpdateVehicleDamageStatus(vehicleid, Panels, Doors, Lights, FrontRight | (FrontLeft << 1));
	else return UpdateVehicleDamageStatus(vehicleid, Panels, Doors, Lights, RearRight | (FrontRight << 1) | (RearLeft << 2) | (FrontLeft << 3));
}

stock GetHoodStatus(vehicleid)
{
	new
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (bonnet != 1)
		return 0;

	return 1;
}

stock GetTrunkStatus(vehicleid)
{
	new
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (boot != 1)
		return 0;

	return 1;
}

stock SaveVehicleDamage(vehicleid)
{

	new slot = Car_GetID(vehicleid);
	if(slot > -1 && CarData[slot][carOwner] > 0)
	{
	    new panels,doors,lights,tires;
		GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
		CarData[slot][carDamage][0] = panels;
		CarData[slot][carDamage][1] = doors;
		CarData[slot][carDamage][2] = lights;
		CarData[slot][carDamage][3] = tires;
		GetVehicleHealth(vehicleid,CarData[slot][carHealth]);
	}

}

stock FuelVehicle(vehicleid)
{
	new id = Car_GetID(vehicleid);

	if (id != -1)
		return CarData[id][carFuel];

	return 0;
}

stock IsSpeedoVehicle(vehicleid)
{
	if (GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510 || GetVehicleModel(vehicleid) == 481 || !IsEngineVehicle(vehicleid)) {
	    return 0;
	}
	return 1;
}

GetVehicleDriver(vehicleid) {
	foreach (new i : Player) {
		if (GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == vehicleid) return i;
	}
	return INVALID_PLAYER_ID;
}

stock Car_GetID(vehicleid)
{
	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (CarData[i][carExists] && CarData[i][carVehicle] == vehicleid) {
	    return i;
	}
	return -1;
}

stock SendClientMessageToAllEx(color, const text[], {Float, _}:...)
{
	static
	    args,
	    str[144];

	/*
     *  Custom function that uses #emit to format variables into a string.
     *  This code is very fragile; touching any code here will cause crashing!
	*/
	if ((args = numargs()) == 2)
	{
	    SendClientMessageToAll(color, text);
	}
	else
	{
		while (--args >= 2)
		{
			#emit LCTRL 5
			#emit LOAD.alt args
			#emit SHL.C.alt 2
			#emit ADD.C 12
			#emit ADD
			#emit LOAD.I
			#emit PUSH.pri
		}
		#emit PUSH.S text
		#emit PUSH.C 144
		#emit PUSH.C str
		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri
		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		SendClientMessageToAll(color, str);

		#emit RETN
	}
	return 1;
}

stock SetTrunkStatus(vehicleid, bool:status)
{
	new
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, status, objective);
}

stock ShowPlayerFooter(playerid, string[], time = 5000)
{
	if (Character[playerid][ShowFooter])
	{
	    PlayerTextDrawHide(playerid, Footer[playerid]);
	    KillTimer(Character[playerid][FooterTimer]);
	}
	PlayerTextDrawSetString(playerid, Footer[playerid], string);
	PlayerTextDrawShow(playerid, Footer[playerid]);

	Character[playerid][ShowFooter] = true;
	Character[playerid][FooterTimer] = SetTimerEx("HidePlayerFooter", time, false, "d", playerid);
}

stock Log_Write(const path[], const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    File:file,
	    string[256]
	;
	if ((start = strfind(path, "/")) != -1) {
	    strmid(string, path, 0, start + 1);

	    if (!fexist(string))
	        return printf("** Warning: Directory \"%s\" doesn't exist.", string);
	}
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	file = fopen(path, io_append);

	if (!file)
	    return 0;

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 1024
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		fwrite(file, string);
		fwrite(file, "\r\n");
		fclose(file);

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}
	fwrite(file, str);
	fwrite(file, "\r\n");
	fclose(file);

	return 1;
}

stock SendRadioMessage(playerid, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) {

			if (Character[i][Channel] == Character[playerid][Channel])
				SendClientMessage(i, 0xEED77BFF, string);

		}
		return 1;
	}
	foreach (new i : Player) {

	    if (Character[i][Channel] == Character[playerid][Channel])
 			SendClientMessage(i, 0xEED77BFF, str);
	}
	return 1;
}
stock doesVehicleExist(const vehicleid) {
    if(GetVehicleModel(vehicleid) >= 400) {
		return 1;
	}
	return 0;
}
