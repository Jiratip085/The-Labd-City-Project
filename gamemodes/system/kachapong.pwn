#include	<YSI_Coding\y_hooks>

// --> ระบบกาชาปอง TextDraws
new Lucky_TimeLast[MAX_PLAYERS]; //
new Lucky_ActiveLast[MAX_PLAYERS]; //
new Lucky_StatsLast[MAX_PLAYERS];

enum GachapongEnumX
{
	gachaID,
	ModelID,
	Name[32],
}

new GachapongLast[][GachapongEnumX] ={ //
	{0, 402, "Car Random"}, //0
	{1, 411, "Car Random"}, //1
	{2, 429, "Car Random"}, //2
	{3, 451, "Car Random"}, //3
	{4, 461, "Car Random"}, //4
	{5, 477, "Car Random"}, //5
	{6, 494, "Car Random"}, //6
	{7, 502, "Car Random"}, //7
	{8, 503, "Car Random"}, //8
	{9, 506, "Car Random"}, //9
	{10, 521, "Car Random"}, //10
	{11, 522, "Car Random"}, //11
	{12, 541, "Car Random"}, //12
	{13, 558, "Car Random"}, //13
	{14, 559, "Car Random"}, //14
	{15, 560, "Car Random"}, //15
	{16, 562, "Car Random"}, //16
	{17, 587, "Car Random"}, //17
	{18, 603, "Car Random"}, //18
	{19, 415, "Car Random"} //19
};

// ----------------------->

new PlayerText:GachaTextDraws[MAX_PLAYERS][24];

hook OnGameModeInit()
{
	SetTimer("LuckyTimerLast", 600, 1);
	return 1;
}

hook OnPlayerConnect(playerid)
{
	Lucky_TimeLast[playerid] = 0;
	Lucky_StatsLast[playerid] = -1;
	Lucky_ActiveLast[playerid] = 0;

	// --> ระบบกาชาปอง
	GachaTextDraws[playerid][0] = CreatePlayerTextDraw(playerid, 327.000000, 172.000000, "_");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][0], 0.600000, 12.200005);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][0], 298.500000, 550.000000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][0], 2);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][0], -1523963137);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][0], 0);

	GachaTextDraws[playerid][1] = CreatePlayerTextDraw(playerid, 171.000000, 175.000000, "_");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][1], 0.591666, 5.600002);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][1], 298.500000, 71.500000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][1], 2);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][1], -421070201);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][1], 0);

	GachaTextDraws[playerid][2] = CreatePlayerTextDraw(playerid, 93.000000, 175.000000, "_");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][2], 0.591666, 5.600002);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][2], 298.500000, 71.500000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][2], 2);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][2], -421070201);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][2], 0);

	GachaTextDraws[playerid][3] = CreatePlayerTextDraw(playerid, 249.000000, 175.000000, "_");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][3], 0.591666, 5.600002);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][3], 298.500000, 71.500000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][3], 2);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][3], -421070201);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][3], 0);

	GachaTextDraws[playerid][4] = CreatePlayerTextDraw(playerid, 327.000000, 175.000000, "_");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][4], 0.591666, 5.600002);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][4], 298.500000, 71.500000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][4], 2);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][4], -421070201);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][4], 0);

	GachaTextDraws[playerid][5] = CreatePlayerTextDraw(playerid, 405.000000, 175.000000, "_");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][5], 0.591666, 5.600002);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][5], 298.500000, 71.500000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][5], 2);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][5], -421070201);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][5], 0);

	GachaTextDraws[playerid][6] = CreatePlayerTextDraw(playerid, 483.000000, 175.000000, "_");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][6], 0.591666, 5.600002);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][6], 298.500000, 71.500000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][6], 2);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][6], -421070201);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][6], 0);

	GachaTextDraws[playerid][7] = CreatePlayerTextDraw(playerid, 561.000000, 175.000000, "_");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][7], 0.591666, 5.600002);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][7], 298.500000, 71.500000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][7], 2);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][7], -421070201);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][7], 0);

	GachaTextDraws[playerid][8] = CreatePlayerTextDraw(playerid, 327.000000, 265.000000, "_");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][8], 0.591666, 1.200002);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][8], 298.500000, 71.500000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][8], 2);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][8], 9109759);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][8], 0);

	GachaTextDraws[playerid][9] = CreatePlayerTextDraw(playerid, 306.000000, 263.000000, "OPEN");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][9], 2);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][9], 0.329166, 1.249999);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][9], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][9], 1);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][9], 1);

	GachaTextDraws[playerid][10] = CreatePlayerTextDraw(playerid, 27.000000, 226.000000, "TextDraw");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][10], 5);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][10], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][10], 75.000000, 77.000000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][10], 1);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][10], 0);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][10], 0);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][10], 0);
	PlayerTextDrawSetPreviewModel(playerid, GachaTextDraws[playerid][10], 11746);
	PlayerTextDrawSetPreviewRot(playerid, GachaTextDraws[playerid][10], -10.000000, 94.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, GachaTextDraws[playerid][10], 1, 1);

	GachaTextDraws[playerid][11] = CreatePlayerTextDraw(playerid, 75.000000, 265.000000, "KEY: 1");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][11], 2);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][11], 0.258333, 1.400000);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][11], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][11], 1);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][11], 50);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][11], 0);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][11], 0);

	GachaTextDraws[playerid][12] = CreatePlayerTextDraw(playerid, 327.000000, 149.000000, "_");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][12], 1);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][12], 0.600000, 1.800004);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][12], 298.500000, 195.000000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][12], 2);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][12], 145);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][12], 0);

	GachaTextDraws[playerid][13] = CreatePlayerTextDraw(playerid, 273.000000, 146.000000, "Lucky Box");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][13], 2);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][13], 0.474999, 2.000000);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][13], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][13], 1);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][13], 50);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][13], 0);

	GachaTextDraws[playerid][14] = CreatePlayerTextDraw(playerid, 56.000000, 172.000000, "TextDraw");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][14], 5);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][14], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][14], 75.000000, 57.000000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][14], 1);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][14], 0);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][14], 50);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][14], 0);
	PlayerTextDrawSetPreviewModel(playerid, GachaTextDraws[playerid][14], 18631);
	PlayerTextDrawSetPreviewRot(playerid, GachaTextDraws[playerid][14], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, GachaTextDraws[playerid][14], 1, 1);

	GachaTextDraws[playerid][15] = CreatePlayerTextDraw(playerid, 134.000000, 172.000000, "TextDraw");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][15], 5);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][15], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][15], 75.000000, 57.000000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][15], 1);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][15], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][15], 0);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][15], 50);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][15], 0);
	PlayerTextDrawSetPreviewModel(playerid, GachaTextDraws[playerid][15], 18631);
	PlayerTextDrawSetPreviewRot(playerid, GachaTextDraws[playerid][15], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, GachaTextDraws[playerid][15], 1, 1);

	GachaTextDraws[playerid][16] = CreatePlayerTextDraw(playerid, 209.000000, 172.000000, "TextDraw");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][16], 5);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][16], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][16], 75.000000, 57.000000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][16], 1);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][16], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][16], 0);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][16], 50);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][16], 0);
	PlayerTextDrawSetPreviewModel(playerid, GachaTextDraws[playerid][16], 18631);
	PlayerTextDrawSetPreviewRot(playerid, GachaTextDraws[playerid][16], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, GachaTextDraws[playerid][16], 1, 1);

	GachaTextDraws[playerid][17] = CreatePlayerTextDraw(playerid, 287.000000, 172.000000, "TextDraw");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][17], 5);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][17], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][17], 75.000000, 57.000000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][17], 1);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][17], 0);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][17], 50);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][17], 0);
	PlayerTextDrawSetPreviewModel(playerid, GachaTextDraws[playerid][17], 18631);
	PlayerTextDrawSetPreviewRot(playerid, GachaTextDraws[playerid][17], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, GachaTextDraws[playerid][17], 1, 1);

	GachaTextDraws[playerid][18] = CreatePlayerTextDraw(playerid, 366.000000, 172.000000, "TextDraw");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][18], 5);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][18], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][18], 75.000000, 57.000000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][18], 1);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][18], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][18], 0);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][18], 50);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][18], 0);
	PlayerTextDrawSetPreviewModel(playerid, GachaTextDraws[playerid][18], 18631);
	PlayerTextDrawSetPreviewRot(playerid, GachaTextDraws[playerid][18], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, GachaTextDraws[playerid][18], 1, 1);

	GachaTextDraws[playerid][19] = CreatePlayerTextDraw(playerid, 443.000000, 172.000000, "TextDraw");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][19], 5);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][19], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][19], 75.000000, 57.000000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][19], 1);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][19], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][19], 0);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][19], 50);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][19], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][19], 0);
	PlayerTextDrawSetPreviewModel(playerid, GachaTextDraws[playerid][19], 18631);
	PlayerTextDrawSetPreviewRot(playerid, GachaTextDraws[playerid][19], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, GachaTextDraws[playerid][19], 1, 1);

	GachaTextDraws[playerid][20] = CreatePlayerTextDraw(playerid, 522.000000, 172.000000, "TextDraw");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][20], 5);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][20], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][20], 75.000000, 57.000000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][20], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][20], 1);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][20], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][20], 0);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][20], 50);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][20], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][20], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][20], 0);
	PlayerTextDrawSetPreviewModel(playerid, GachaTextDraws[playerid][20], 18631);
	PlayerTextDrawSetPreviewRot(playerid, GachaTextDraws[playerid][20], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, GachaTextDraws[playerid][20], 1, 1);

	GachaTextDraws[playerid][21] = CreatePlayerTextDraw(playerid, 327.000000, 175.000000, "_");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][21], 1);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][21], 0.591666, 5.600002);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][21], 298.500000, -5.500000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][21], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][21], 2);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][21], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][21], 255);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][21], -421070081);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][21], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][21], 0);

	GachaTextDraws[playerid][22] = CreatePlayerTextDraw(playerid, 575.000000, 154.000000, "_");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][22], 1);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][22], 0.591666, 0.950002);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][22], 298.500000, 41.500000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][22], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][22], 2);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][22], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][22], 255);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][22], -16776961);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][22], 1);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][22], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][22], 0);

	GachaTextDraws[playerid][23] = CreatePlayerTextDraw(playerid, 563.000000, 152.000000, "Close");
	PlayerTextDrawFont(playerid, GachaTextDraws[playerid][23], 2);
	PlayerTextDrawLetterSize(playerid, GachaTextDraws[playerid][23], 0.200000, 1.149999);
	PlayerTextDrawTextSize(playerid, GachaTextDraws[playerid][23], 690.000000, 127.000000);
	PlayerTextDrawSetOutline(playerid, GachaTextDraws[playerid][23], 1);
	PlayerTextDrawSetShadow(playerid, GachaTextDraws[playerid][23], 0);
	PlayerTextDrawAlignment(playerid, GachaTextDraws[playerid][23], 1);
	PlayerTextDrawColor(playerid, GachaTextDraws[playerid][23], -1);
	PlayerTextDrawBackgroundColor(playerid, GachaTextDraws[playerid][23], 255);
	PlayerTextDrawBoxColor(playerid, GachaTextDraws[playerid][23], 50);
	PlayerTextDrawUseBox(playerid, GachaTextDraws[playerid][23], 0);
	PlayerTextDrawSetProportional(playerid, GachaTextDraws[playerid][23], 1);
	PlayerTextDrawSetSelectable(playerid, GachaTextDraws[playerid][23], 1);

	return 1;
}

forward LuckyTimerLast();
public LuckyTimerLast()
{
	new query[512];
	foreach (new i : Player)
 	{
  		if (Lucky_ActiveLast[i] == 1) // ผู้เล่นเปิดกล่อง
    	{
     		Lucky_TimeLast[i] ++;

			new gift1 = random(20), gift2 = random(20), gift3 = random(20), gift4 = random(20),
			gift5 = random(20), gift6 = random(20), gift7 = random(20);

			PlayerTextDrawShow(i, GachaTextDraws[i][14]);
			PlayerTextDrawSetPreviewModel(i, GachaTextDraws[i][14], GachapongLast[gift1][ModelID]);

			PlayerTextDrawShow(i, GachaTextDraws[i][15]);
			PlayerTextDrawSetPreviewModel(i, GachaTextDraws[i][15], GachapongLast[gift2][ModelID]);

			PlayerTextDrawShow(i, GachaTextDraws[i][16]);
			PlayerTextDrawSetPreviewModel(i, GachaTextDraws[i][16], GachapongLast[gift3][ModelID]);

			PlayerTextDrawShow(i, GachaTextDraws[i][17]);
			PlayerTextDrawSetPreviewModel(i, GachaTextDraws[i][17], GachapongLast[gift4][ModelID]);

			PlayerTextDrawShow(i, GachaTextDraws[i][18]);
			PlayerTextDrawSetPreviewModel(i, GachaTextDraws[i][18], GachapongLast[gift5][ModelID]);

			PlayerTextDrawShow(i, GachaTextDraws[i][19]);
			PlayerTextDrawSetPreviewModel(i, GachaTextDraws[i][19], GachapongLast[gift6][ModelID]);

			PlayerTextDrawShow(i, GachaTextDraws[i][20]);
			PlayerTextDrawSetPreviewModel(i, GachaTextDraws[i][20], GachapongLast[gift7][ModelID]);

			//new Float:x, Float:y, Float:z, Float:angle;

			if (Lucky_TimeLast[i] == 20)
			{
				PlayerTextDrawShow(i, GachaTextDraws[i][17]);
				PlayerTextDrawSetPreviewModel(i, GachaTextDraws[i][17], GachapongLast[gift4][ModelID]);

				PlayerTextDrawShow(i, GachaTextDraws[i][17]);
				PlayerTextDrawSetPreviewModel(i, GachaTextDraws[i][17], GachapongLast[gift4][ModelID]);

   				switch(GachapongLast[gift4][gachaID])
			    {
					case 0:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 402, 0, 100.0);
						mysql_tquery(g_SQL, query);
						
						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'Buffalo' จากการเปิดกล่องกาชาปอง ))");
					}

					case 1:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 411, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'Infernus' จากการเปิดกล่องกาชาปอง ))");
					}

					case 2:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 429, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'Banshee' จากการเปิดกล่องกาชาปอง ))");
					}

					case 3:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 451, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'Turismo' จากการเปิดกล่องกาชาปอง ))");
					}

					case 4:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 461, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'PCJ-600' จากการเปิดกล่องกาชาปอง ))");
					}

					case 5:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 477, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'ZR-350' จากการเปิดกล่องกาชาปอง ))");
					}

					case 6:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 494, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'Hotring' จากการเปิดกล่องกาชาปอง ))");
					}

					case 7:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 502, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'Hotring A' จากการเปิดกล่องกาชาปอง ))");
					}

					case 8:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 503, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'Hotring B' จากการเปิดกล่องกาชาปอง ))");
					}

					case 9:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 506, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'SuperGT' จากการเปิดกล่องกาชาปอง ))");
					}

					case 10:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 521, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'FCR-900' จากการเปิดกล่องกาชาปอง ))");
					}

					case 11:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 522, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'NRG-500' จากการเปิดกล่องกาชาปอง ))");
					}

					case 12:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 541, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'Bullet' จากการเปิดกล่องกาชาปอง ))");
					}

					case 13:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 558, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'Uranus' จากการเปิดกล่องกาชาปอง ))");
					}

					case 14:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 559, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'Jester' จากการเปิดกล่องกาชาปอง ))");
					}

					case 15:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 560, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'Sultan' จากการเปิดกล่องกาชาปอง ))");
					}

					case 16:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 562, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'Elegy' จากการเปิดกล่องกาชาปอง ))");
					}

					case 17:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 587, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'Euros' จากการเปิดกล่องกาชาปอง ))");
					}

					case 18:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 603, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'Phoenix' จากการเปิดกล่องกาชาปอง ))");
					}

					case 19:
					{
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[i][pID], GetPlayerNameEx(i), 415, 0, 100.0);
						mysql_tquery(g_SQL, query);

						SendClientMessage(i, COLOR_YELLOW, "* คุณได้รับ 'Cheetah' จากการเปิดกล่องกาชาปอง ))");
					}
				}

				Lucky_TimeLast[i] = 0;
				Lucky_StatsLast[i] = -1;
				Lucky_ActiveLast[i] = 0;

				SetTimerEx("HideLuckyLast", 1500, 0, "d", i);
	        }
	    }
	}
	return 1;
}

forward HideLuckyLast(playerid);
public HideLuckyLast(playerid)
{
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][0]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][1]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][2]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][3]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][4]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][5]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][6]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][7]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][8]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][9]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][10]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][11]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][12]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][13]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][14]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][15]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][16]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][17]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][18]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][19]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][20]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][21]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][22]);
	PlayerTextDrawHide(playerid, GachaTextDraws[playerid][23]);

	CancelSelectTextDraw(playerid);

	Lucky_TimeLast[playerid] = 0;
	Lucky_StatsLast[playerid] = -1;
	Lucky_ActiveLast[playerid] = 0;

	return 1;
}
