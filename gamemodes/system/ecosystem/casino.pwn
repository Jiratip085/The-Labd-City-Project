#include 	<YSI_Coding\y_hooks>

new BacaraTime;
new BacaraNumber;
new BacaraActive;
new PlayerBA[3], BankerBA[3];
new PlayerPoint, BankerPoint;

new BacaraType[MAX_PLAYERS];
new BacaraMoney[MAX_PLAYERS];
new JoinBacara[MAX_PLAYERS];

enum BACARA_DATA
{
	Name[32],
	Point
};

new const BacaraInfo[][BACARA_DATA] =
{
	{ "ld_card:cd10c", 0 },
	{ "ld_card:cd10d", 0 },
	{ "ld_card:cd10h", 0 },
	{ "ld_card:cd10s", 0 },

	{ "ld_card:cd13c", 0 },
	{ "ld_card:cd13d", 0 },
	{ "ld_card:cd13h", 0 },
	{ "ld_card:cd13s", 0 },

	{ "ld_card:cd1c", 1 },
	{ "ld_card:cd1d", 1 },
	{ "ld_card:cd1h", 1 },
	{ "ld_card:cd1s", 1 },

	{ "ld_card:cd2c", 2 },
	{ "ld_card:cd2d", 2 },
	{ "ld_card:cd2h", 2 },
	{ "ld_card:cd2s", 2 },

	{ "ld_card:cd3c", 3 },
	{ "ld_card:cd3d", 3 },
	{ "ld_card:cd3h", 3 },
	{ "ld_card:cd3s", 3 },

	{ "ld_card:cd4c", 4 },
	{ "ld_card:cd4d", 4 },
	{ "ld_card:cd4h", 4 },
	{ "ld_card:cd4s", 4 },

	{ "ld_card:cd5c", 5 },
	{ "ld_card:cd5d", 5 },
	{ "ld_card:cd5h", 5 },
	{ "ld_card:cd5s", 5 },

	{ "ld_card:cd6c", 6 },
	{ "ld_card:cd6d", 6 },
	{ "ld_card:cd6h", 6 },
	{ "ld_card:cd6s", 6 },

	{ "ld_card:cd7c", 7 },
	{ "ld_card:cd7d", 7 },
	{ "ld_card:cd7h", 7 },
	{ "ld_card:cd7s", 7 },

	{ "ld_card:cd8c", 8 },
	{ "ld_card:cd8d", 8 },
	{ "ld_card:cd8h", 8 },
	{ "ld_card:cd8s", 8 },

	{ "ld_card:cd9c", 9 },
	{ "ld_card:cd9d", 9 },
	{ "ld_card:cd9h", 9 },
	{ "ld_card:cd9s", 9 }
};

new Text:BACARATextDraws[26];

hook OnGameModeInit(playerid)
{
    CreateObject(2188, 833.86792, 1.17350, 1004.12402,   0.00000, 0.00000, 270.00000);

    BacaraTime = 30;
    BacaraNumber = 0;
    BacaraActive = 0;

    PlayerBA[0] = -1;
    PlayerBA[1] = -1;
    PlayerBA[2] = -1;

    BankerBA[0] = -1;
    BankerBA[1] = -1;
    BankerBA[2] = -1;

    PlayerPoint = -1;
    BankerPoint = -1;

	BACARATextDraws[0] = TextDrawCreate(329.000000, 129.000000, "_");
	TextDrawFont(BACARATextDraws[0], 1);
	TextDrawLetterSize(BACARATextDraws[0], 0.600000, 22.800003);
	TextDrawTextSize(BACARATextDraws[0], 298.500000, 420.000000);
	TextDrawSetOutline(BACARATextDraws[0], 1);
	TextDrawSetShadow(BACARATextDraws[0], 0);
	TextDrawAlignment(BACARATextDraws[0], 2);
	TextDrawColor(BACARATextDraws[0], -1);
	TextDrawBackgroundColor(BACARATextDraws[0], 255);
	TextDrawBoxColor(BACARATextDraws[0], 9109759);
	TextDrawUseBox(BACARATextDraws[0], 1);
	TextDrawSetProportional(BACARATextDraws[0], 1);
	TextDrawSetSelectable(BACARATextDraws[0], 0);

	BACARATextDraws[1] = TextDrawCreate(329.000000, 131.000000, "_");
	TextDrawFont(BACARATextDraws[1], 1);
	TextDrawLetterSize(BACARATextDraws[1], 0.600000, 22.250011);
	TextDrawTextSize(BACARATextDraws[1], 298.500000, 413.000000);
	TextDrawSetOutline(BACARATextDraws[1], 1);
	TextDrawSetShadow(BACARATextDraws[1], 0);
	TextDrawAlignment(BACARATextDraws[1], 2);
	TextDrawColor(BACARATextDraws[1], -1);
	TextDrawBackgroundColor(BACARATextDraws[1], 255);
	TextDrawBoxColor(BACARATextDraws[1], 255);
	TextDrawUseBox(BACARATextDraws[1], 1);
	TextDrawSetProportional(BACARATextDraws[1], 1);
	TextDrawSetSelectable(BACARATextDraws[1], 0);

	BACARATextDraws[2] = TextDrawCreate(530.000000, 119.000000, "X");
	TextDrawFont(BACARATextDraws[2], 1);
	TextDrawLetterSize(BACARATextDraws[2], 0.616666, 2.049998);
	TextDrawTextSize(BACARATextDraws[2], 545.000000, 17.000000);
	TextDrawSetOutline(BACARATextDraws[2], 1);
	TextDrawSetShadow(BACARATextDraws[2], 0);
	TextDrawAlignment(BACARATextDraws[2], 1);
	TextDrawColor(BACARATextDraws[2], 9109759);
	TextDrawBackgroundColor(BACARATextDraws[2], 255);
	TextDrawBoxColor(BACARATextDraws[2], 50);
	TextDrawUseBox(BACARATextDraws[2], 0);
	TextDrawSetProportional(BACARATextDraws[2], 1);
	TextDrawSetSelectable(BACARATextDraws[2], 1);

	BACARATextDraws[3] = TextDrawCreate(183.000000, 141.000000, "PLAYER");
	TextDrawFont(BACARATextDraws[3], 1);
	TextDrawLetterSize(BACARATextDraws[3], 0.600000, 2.000000);
	TextDrawTextSize(BACARATextDraws[3], 400.000000, 17.000000);
	TextDrawSetOutline(BACARATextDraws[3], 1);
	TextDrawSetShadow(BACARATextDraws[3], 0);
	TextDrawAlignment(BACARATextDraws[3], 1);
	TextDrawColor(BACARATextDraws[3], 16777215);
	TextDrawBackgroundColor(BACARATextDraws[3], 255);
	TextDrawBoxColor(BACARATextDraws[3], 50);
	TextDrawUseBox(BACARATextDraws[3], 0);
	TextDrawSetProportional(BACARATextDraws[3], 1);
	TextDrawSetSelectable(BACARATextDraws[3], 0);

	BACARATextDraws[4] = TextDrawCreate(403.000000, 141.000000, "BANKER");
	TextDrawFont(BACARATextDraws[4], 1);
	TextDrawLetterSize(BACARATextDraws[4], 0.600000, 2.000000);
	TextDrawTextSize(BACARATextDraws[4], 400.000000, 17.000000);
	TextDrawSetOutline(BACARATextDraws[4], 1);
	TextDrawSetShadow(BACARATextDraws[4], 0);
	TextDrawAlignment(BACARATextDraws[4], 1);
	TextDrawColor(BACARATextDraws[4], -16776961);
	TextDrawBackgroundColor(BACARATextDraws[4], 255);
	TextDrawBoxColor(BACARATextDraws[4], 50);
	TextDrawUseBox(BACARATextDraws[4], 0);
	TextDrawSetProportional(BACARATextDraws[4], 1);
	TextDrawSetSelectable(BACARATextDraws[4], 0);

	BACARATextDraws[5] = TextDrawCreate(328.000000, 148.000000, "_");
	TextDrawFont(BACARATextDraws[5], 1);
	TextDrawLetterSize(BACARATextDraws[5], 0.600000, 0.800002);
	TextDrawTextSize(BACARATextDraws[5], 298.500000, 0.000000);
	TextDrawSetOutline(BACARATextDraws[5], 1);
	TextDrawSetShadow(BACARATextDraws[5], 0);
	TextDrawAlignment(BACARATextDraws[5], 2);
	TextDrawColor(BACARATextDraws[5], -1);
	TextDrawBackgroundColor(BACARATextDraws[5], 255);
	TextDrawBoxColor(BACARATextDraws[5], -1);
	TextDrawUseBox(BACARATextDraws[5], 1);
	TextDrawSetProportional(BACARATextDraws[5], 1);
	TextDrawSetSelectable(BACARATextDraws[5], 0);

	BACARATextDraws[6] = TextDrawCreate(131.000000, 171.000000, "ld_card:cdback");
	TextDrawFont(BACARATextDraws[6], 4);
	TextDrawLetterSize(BACARATextDraws[6], 0.600000, 2.000000);
	TextDrawTextSize(BACARATextDraws[6], 51.500000, 57.500000);
	TextDrawSetOutline(BACARATextDraws[6], 1);
	TextDrawSetShadow(BACARATextDraws[6], 0);
	TextDrawAlignment(BACARATextDraws[6], 1);
	TextDrawColor(BACARATextDraws[6], -1);
	TextDrawBackgroundColor(BACARATextDraws[6], 255);
	TextDrawBoxColor(BACARATextDraws[6], 50);
	TextDrawUseBox(BACARATextDraws[6], 1);
	TextDrawSetProportional(BACARATextDraws[6], 1);
	TextDrawSetSelectable(BACARATextDraws[6], 0);

	BACARATextDraws[7] = TextDrawCreate(190.000000, 171.000000, "ld_card:cdback");
	TextDrawFont(BACARATextDraws[7], 4);
	TextDrawLetterSize(BACARATextDraws[7], 0.600000, 2.000000);
	TextDrawTextSize(BACARATextDraws[7], 51.500000, 57.500000);
	TextDrawSetOutline(BACARATextDraws[7], 1);
	TextDrawSetShadow(BACARATextDraws[7], 0);
	TextDrawAlignment(BACARATextDraws[7], 1);
	TextDrawColor(BACARATextDraws[7], -1);
	TextDrawBackgroundColor(BACARATextDraws[7], 255);
	TextDrawBoxColor(BACARATextDraws[7], 50);
	TextDrawUseBox(BACARATextDraws[7], 1);
	TextDrawSetProportional(BACARATextDraws[7], 1);
	TextDrawSetSelectable(BACARATextDraws[7], 0);

	BACARATextDraws[8] = TextDrawCreate(249.000000, 171.000000, "ld_card:cdback");
	TextDrawFont(BACARATextDraws[8], 4);
	TextDrawLetterSize(BACARATextDraws[8], 0.600000, 2.000000);
	TextDrawTextSize(BACARATextDraws[8], 51.500000, 57.500000);
	TextDrawSetOutline(BACARATextDraws[8], 1);
	TextDrawSetShadow(BACARATextDraws[8], 0);
	TextDrawAlignment(BACARATextDraws[8], 1);
	TextDrawColor(BACARATextDraws[8], -1);
	TextDrawBackgroundColor(BACARATextDraws[8], 255);
	TextDrawBoxColor(BACARATextDraws[8], 50);
	TextDrawUseBox(BACARATextDraws[8], 1);
	TextDrawSetProportional(BACARATextDraws[8], 1);
	TextDrawSetSelectable(BACARATextDraws[8], 0);

	BACARATextDraws[9] = TextDrawCreate(360.000000, 171.000000, "ld_card:cdback");
	TextDrawFont(BACARATextDraws[9], 4);
	TextDrawLetterSize(BACARATextDraws[9], 0.600000, 2.000000);
	TextDrawTextSize(BACARATextDraws[9], 51.500000, 57.500000);
	TextDrawSetOutline(BACARATextDraws[9], 1);
	TextDrawSetShadow(BACARATextDraws[9], 0);
	TextDrawAlignment(BACARATextDraws[9], 1);
	TextDrawColor(BACARATextDraws[9], -1);
	TextDrawBackgroundColor(BACARATextDraws[9], 255);
	TextDrawBoxColor(BACARATextDraws[9], 50);
	TextDrawUseBox(BACARATextDraws[9], 1);
	TextDrawSetProportional(BACARATextDraws[9], 1);
	TextDrawSetSelectable(BACARATextDraws[9], 0);

	BACARATextDraws[10] = TextDrawCreate(419.000000, 171.000000, "ld_card:cdback");
	TextDrawFont(BACARATextDraws[10], 4);
	TextDrawLetterSize(BACARATextDraws[10], 0.600000, 2.000000);
	TextDrawTextSize(BACARATextDraws[10], 51.500000, 57.500000);
	TextDrawSetOutline(BACARATextDraws[10], 1);
	TextDrawSetShadow(BACARATextDraws[10], 0);
	TextDrawAlignment(BACARATextDraws[10], 1);
	TextDrawColor(BACARATextDraws[10], -1);
	TextDrawBackgroundColor(BACARATextDraws[10], 255);
	TextDrawBoxColor(BACARATextDraws[10], 50);
	TextDrawUseBox(BACARATextDraws[10], 1);
	TextDrawSetProportional(BACARATextDraws[10], 1);
	TextDrawSetSelectable(BACARATextDraws[10], 0);

	BACARATextDraws[11] = TextDrawCreate(477.000000, 171.000000, "ld_card:cdback");
	TextDrawFont(BACARATextDraws[11], 4);
	TextDrawLetterSize(BACARATextDraws[11], 0.600000, 2.000000);
	TextDrawTextSize(BACARATextDraws[11], 51.500000, 57.500000);
	TextDrawSetOutline(BACARATextDraws[11], 1);
	TextDrawSetShadow(BACARATextDraws[11], 0);
	TextDrawAlignment(BACARATextDraws[11], 1);
	TextDrawColor(BACARATextDraws[11], -1);
	TextDrawBackgroundColor(BACARATextDraws[11], 255);
	TextDrawBoxColor(BACARATextDraws[11], 50);
	TextDrawUseBox(BACARATextDraws[11], 1);
	TextDrawSetProportional(BACARATextDraws[11], 1);
	TextDrawSetSelectable(BACARATextDraws[11], 0);

	BACARATextDraws[12] = TextDrawCreate(214.000000, 247.000000, "_");
	TextDrawFont(BACARATextDraws[12], 1);
	TextDrawLetterSize(BACARATextDraws[12], 0.600000, 3.300003);
	TextDrawTextSize(BACARATextDraws[12], 298.500000, 85.000000);
	TextDrawSetOutline(BACARATextDraws[12], 1);
	TextDrawSetShadow(BACARATextDraws[12], 0);
	TextDrawAlignment(BACARATextDraws[12], 2);
	TextDrawColor(BACARATextDraws[12], -1);
	TextDrawBackgroundColor(BACARATextDraws[12], 255);
	TextDrawBoxColor(BACARATextDraws[12], 16777215);
	TextDrawUseBox(BACARATextDraws[12], 1);
	TextDrawSetProportional(BACARATextDraws[12], 1);
	TextDrawSetSelectable(BACARATextDraws[12], 0);

	BACARATextDraws[13] = TextDrawCreate(332.000000, 247.000000, "_");
	TextDrawFont(BACARATextDraws[13], 1);
	TextDrawLetterSize(BACARATextDraws[13], 0.600000, 3.300003);
	TextDrawTextSize(BACARATextDraws[13], 298.500000, 85.000000);
	TextDrawSetOutline(BACARATextDraws[13], 1);
	TextDrawSetShadow(BACARATextDraws[13], 0);
	TextDrawAlignment(BACARATextDraws[13], 2);
	TextDrawColor(BACARATextDraws[13], -1);
	TextDrawBackgroundColor(BACARATextDraws[13], 255);
	TextDrawBoxColor(BACARATextDraws[13], 9109759);
	TextDrawUseBox(BACARATextDraws[13], 1);
	TextDrawSetProportional(BACARATextDraws[13], 1);
	TextDrawSetSelectable(BACARATextDraws[13], 0);

	BACARATextDraws[14] = TextDrawCreate(451.000000, 247.000000, "_");
	TextDrawFont(BACARATextDraws[14], 1);
	TextDrawLetterSize(BACARATextDraws[14], 0.600000, 3.300003);
	TextDrawTextSize(BACARATextDraws[14], 298.500000, 85.000000);
	TextDrawSetOutline(BACARATextDraws[14], 1);
	TextDrawSetShadow(BACARATextDraws[14], 0);
	TextDrawAlignment(BACARATextDraws[14], 2);
	TextDrawColor(BACARATextDraws[14], -1);
	TextDrawBackgroundColor(BACARATextDraws[14], 255);
	TextDrawBoxColor(BACARATextDraws[14], -16776961);
	TextDrawUseBox(BACARATextDraws[14], 1);
	TextDrawSetProportional(BACARATextDraws[14], 1);
	TextDrawSetSelectable(BACARATextDraws[14], 0);

	BACARATextDraws[15] = TextDrawCreate(214.000000, 248.000000, "_");
	TextDrawFont(BACARATextDraws[15], 1);
	TextDrawLetterSize(BACARATextDraws[15], 0.600000, 3.100003);
	TextDrawTextSize(BACARATextDraws[15], 298.500000, 82.000000);
	TextDrawSetOutline(BACARATextDraws[15], 1);
	TextDrawSetShadow(BACARATextDraws[15], 0);
	TextDrawAlignment(BACARATextDraws[15], 2);
	TextDrawColor(BACARATextDraws[15], -1);
	TextDrawBackgroundColor(BACARATextDraws[15], 255);
	TextDrawBoxColor(BACARATextDraws[15], 255);
	TextDrawUseBox(BACARATextDraws[15], 1);
	TextDrawSetProportional(BACARATextDraws[15], 1);
	TextDrawSetSelectable(BACARATextDraws[15], 0);

	BACARATextDraws[16] = TextDrawCreate(332.000000, 248.000000, "_");
	TextDrawFont(BACARATextDraws[16], 1);
	TextDrawLetterSize(BACARATextDraws[16], 0.600000, 3.100003);
	TextDrawTextSize(BACARATextDraws[16], 298.500000, 82.000000);
	TextDrawSetOutline(BACARATextDraws[16], 1);
	TextDrawSetShadow(BACARATextDraws[16], 0);
	TextDrawAlignment(BACARATextDraws[16], 2);
	TextDrawColor(BACARATextDraws[16], -1);
	TextDrawBackgroundColor(BACARATextDraws[16], 255);
	TextDrawBoxColor(BACARATextDraws[16], 255);
	TextDrawUseBox(BACARATextDraws[16], 1);
	TextDrawSetProportional(BACARATextDraws[16], 1);
	TextDrawSetSelectable(BACARATextDraws[16], 0);

	BACARATextDraws[17] = TextDrawCreate(451.000000, 248.000000, "_");
	TextDrawFont(BACARATextDraws[17], 1);
	TextDrawLetterSize(BACARATextDraws[17], 0.600000, 3.100003);
	TextDrawTextSize(BACARATextDraws[17], 298.500000, 82.000000);
	TextDrawSetOutline(BACARATextDraws[17], 1);
	TextDrawSetShadow(BACARATextDraws[17], 0);
	TextDrawAlignment(BACARATextDraws[17], 2);
	TextDrawColor(BACARATextDraws[17], -1);
	TextDrawBackgroundColor(BACARATextDraws[17], 255);
	TextDrawBoxColor(BACARATextDraws[17], 255);
	TextDrawUseBox(BACARATextDraws[17], 1);
	TextDrawSetProportional(BACARATextDraws[17], 1);
	TextDrawSetSelectable(BACARATextDraws[17], 0);

	BACARATextDraws[18] = TextDrawCreate(183.000000, 247.000000, "PLAYER");
	TextDrawFont(BACARATextDraws[18], 1);
	TextDrawLetterSize(BACARATextDraws[18], 0.524999, 1.799999);
	TextDrawTextSize(BACARATextDraws[18], 245.500000, 17.000000);
	TextDrawSetOutline(BACARATextDraws[18], 1);
	TextDrawSetShadow(BACARATextDraws[18], 0);
	TextDrawAlignment(BACARATextDraws[18], 1);
	TextDrawColor(BACARATextDraws[18], 16777215);
	TextDrawBackgroundColor(BACARATextDraws[18], 255);
	TextDrawBoxColor(BACARATextDraws[18], -206);
	TextDrawUseBox(BACARATextDraws[18], 0);
	TextDrawSetProportional(BACARATextDraws[18], 1);
	TextDrawSetSelectable(BACARATextDraws[18], 1);

	BACARATextDraws[19] = TextDrawCreate(317.000000, 247.000000, "TIE");
	TextDrawFont(BACARATextDraws[19], 1);
	TextDrawLetterSize(BACARATextDraws[19], 0.524999, 1.799999);
	TextDrawTextSize(BACARATextDraws[19], 343.000000, 17.000000);
	TextDrawSetOutline(BACARATextDraws[19], 1);
	TextDrawSetShadow(BACARATextDraws[19], 0);
	TextDrawAlignment(BACARATextDraws[19], 1);
	TextDrawColor(BACARATextDraws[19], 9109759);
	TextDrawBackgroundColor(BACARATextDraws[19], 255);
	TextDrawBoxColor(BACARATextDraws[19], -206);
	TextDrawUseBox(BACARATextDraws[19], 0);
	TextDrawSetProportional(BACARATextDraws[19], 1);
	TextDrawSetSelectable(BACARATextDraws[19], 1);

	BACARATextDraws[20] = TextDrawCreate(419.000000, 247.000000, "BANKER");
	TextDrawFont(BACARATextDraws[20], 1);
	TextDrawLetterSize(BACARATextDraws[20], 0.524999, 1.799999);
	TextDrawTextSize(BACARATextDraws[20], 485.000000, 17.000000);
	TextDrawSetOutline(BACARATextDraws[20], 1);
	TextDrawSetShadow(BACARATextDraws[20], 0);
	TextDrawAlignment(BACARATextDraws[20], 1);
	TextDrawColor(BACARATextDraws[20], -16776961);
	TextDrawBackgroundColor(BACARATextDraws[20], 255);
	TextDrawBoxColor(BACARATextDraws[20], -206);
	TextDrawUseBox(BACARATextDraws[20], 0);
	TextDrawSetProportional(BACARATextDraws[20], 1);
	TextDrawSetSelectable(BACARATextDraws[20], 1);

	BACARATextDraws[21] = TextDrawCreate(203.000000, 263.000000, "1:1");
	TextDrawFont(BACARATextDraws[21], 1);
	TextDrawLetterSize(BACARATextDraws[21], 0.383332, 1.250000);
	TextDrawTextSize(BACARATextDraws[21], 400.000000, 17.000000);
	TextDrawSetOutline(BACARATextDraws[21], 1);
	TextDrawSetShadow(BACARATextDraws[21], 0);
	TextDrawAlignment(BACARATextDraws[21], 1);
	TextDrawColor(BACARATextDraws[21], -1);
	TextDrawBackgroundColor(BACARATextDraws[21], 255);
	TextDrawBoxColor(BACARATextDraws[21], 50);
	TextDrawUseBox(BACARATextDraws[21], 0);
	TextDrawSetProportional(BACARATextDraws[21], 1);
	TextDrawSetSelectable(BACARATextDraws[21], 0);

	BACARATextDraws[22] = TextDrawCreate(320.000000, 263.000000, "1:5");
	TextDrawFont(BACARATextDraws[22], 1);
	TextDrawLetterSize(BACARATextDraws[22], 0.383332, 1.250000);
	TextDrawTextSize(BACARATextDraws[22], 400.000000, 17.000000);
	TextDrawSetOutline(BACARATextDraws[22], 1);
	TextDrawSetShadow(BACARATextDraws[22], 0);
	TextDrawAlignment(BACARATextDraws[22], 1);
	TextDrawColor(BACARATextDraws[22], -1);
	TextDrawBackgroundColor(BACARATextDraws[22], 255);
	TextDrawBoxColor(BACARATextDraws[22], 50);
	TextDrawUseBox(BACARATextDraws[22], 0);
	TextDrawSetProportional(BACARATextDraws[22], 1);
	TextDrawSetSelectable(BACARATextDraws[22], 0);

	BACARATextDraws[23] = TextDrawCreate(442.000000, 263.000000, "1:1");
	TextDrawFont(BACARATextDraws[23], 1);
	TextDrawLetterSize(BACARATextDraws[23], 0.383332, 1.250000);
	TextDrawTextSize(BACARATextDraws[23], 400.000000, 17.000000);
	TextDrawSetOutline(BACARATextDraws[23], 1);
	TextDrawSetShadow(BACARATextDraws[23], 0);
	TextDrawAlignment(BACARATextDraws[23], 1);
	TextDrawColor(BACARATextDraws[23], -1);
	TextDrawBackgroundColor(BACARATextDraws[23], 255);
	TextDrawBoxColor(BACARATextDraws[23], 50);
	TextDrawUseBox(BACARATextDraws[23], 0);
	TextDrawSetProportional(BACARATextDraws[23], 1);
	TextDrawSetSelectable(BACARATextDraws[23], 0);

	BACARATextDraws[24] = TextDrawCreate(277.000000, 306.000000, "ld_grav:timer");
	TextDrawFont(BACARATextDraws[24], 4);
	TextDrawLetterSize(BACARATextDraws[24], 0.600000, 2.000000);
	TextDrawTextSize(BACARATextDraws[24], 20.000000, 19.500000);
	TextDrawSetOutline(BACARATextDraws[24], 1);
	TextDrawSetShadow(BACARATextDraws[24], 0);
	TextDrawAlignment(BACARATextDraws[24], 1);
	TextDrawColor(BACARATextDraws[24], -1);
	TextDrawBackgroundColor(BACARATextDraws[24], 255);
	TextDrawBoxColor(BACARATextDraws[24], 50);
	TextDrawUseBox(BACARATextDraws[24], 1);
	TextDrawSetProportional(BACARATextDraws[24], 1);
	TextDrawSetSelectable(BACARATextDraws[24], 0);

	BACARATextDraws[25] = TextDrawCreate(305.000000, 307.000000, "00:20");
	TextDrawFont(BACARATextDraws[25], 3);
	TextDrawLetterSize(BACARATextDraws[25], 0.600000, 2.000000);
	TextDrawTextSize(BACARATextDraws[25], 400.000000, 17.000000);
	TextDrawSetOutline(BACARATextDraws[25], 1);
	TextDrawSetShadow(BACARATextDraws[25], 0);
	TextDrawAlignment(BACARATextDraws[25], 1);
	TextDrawColor(BACARATextDraws[25], -1);
	TextDrawBackgroundColor(BACARATextDraws[25], 255);
	TextDrawBoxColor(BACARATextDraws[25], 50);
	TextDrawUseBox(BACARATextDraws[25], 0);
	TextDrawSetProportional(BACARATextDraws[25], 1);
	TextDrawSetSelectable(BACARATextDraws[25], 0);

	CreateDynamicObject(2188, 2224.98364, 1677.01990, 1008.31378,   0.00000, 0.00000, 90.06001);

}

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 2754, 830.6563, -1.0781, 1004.0703, 0.25);
    RemoveBuildingForPlayer(playerid, 2754, 834.3984, 3.2266, 1004.0703, 0.25);

	BacaraType[playerid] = 0;
 	BacaraMoney[playerid] = 0;
 	JoinBacara[playerid] = 0;
}

alias:bacara("บาคาร่า")
CMD:bacara(playerid, params[])
{
	if (!IsPlayerInRangeOfPoint(playerid, 3.0, 2224.98364, 1677.01990, 1008.31378))
	    return SendClientMessage(playerid, COLOR_RED, "* คุณไม่ได้อยู่ที่โต๊ะบาคาร่า");

    if (JoinBacara[playerid] == 0)
	{
	    JoinBacara[playerid] = 1;
		ShowBACARA(playerid);
	}
	else
	{
	    JoinBacara[playerid] = 0;
	    HideBACARA(playerid);
	}
	return 1;
}

stock ShowBACARA(playerid)
{
	TextDrawShowForPlayer(playerid, BACARATextDraws[0]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[1]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[2]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[3]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[4]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[5]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[6]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[7]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[8]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[9]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[10]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[11]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[12]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[13]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[14]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[15]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[16]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[17]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[18]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[19]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[20]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[21]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[22]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[23]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[24]);
	TextDrawShowForPlayer(playerid, BACARATextDraws[25]);

	SelectTextDraw(playerid, COLOR_YELLOW);

	return 1;
}

stock HideBACARA(playerid)
{
	TextDrawHideForPlayer(playerid, BACARATextDraws[0]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[1]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[2]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[3]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[4]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[5]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[6]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[7]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[8]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[9]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[10]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[11]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[12]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[13]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[14]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[15]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[16]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[17]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[18]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[19]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[20]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[21]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[22]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[23]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[24]);
	TextDrawHideForPlayer(playerid, BACARATextDraws[25]);

	CancelSelectTextDraw(playerid);

	return 1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == BACARATextDraws[18]) // PLAYER
	{
        Dialog_Show(playerid, DIALOG_PLAYER, DIALOG_STYLE_INPUT, "[การวางเดิมพัน]", "{FFFFFF}คุณต้องการวางเดิมพัน {05AAFD}PLAYER {FFFFFF}เป็นจำนวนเงินเท่าใด", "ตกลง", "ออก");
	}

	if(clickedid == BACARATextDraws[19]) // TIE
	{
        Dialog_Show(playerid, DIALOG_TIE, DIALOG_STYLE_INPUT, "[การวางเดิมพัน]", "{FFFFFF}คุณต้องการวางเดิมพัน {10FD05}TIE {FFFFFF}เป็นจำนวนเงินเท่าใด", "ตกลง", "ออก");
	}

	if(clickedid == BACARATextDraws[20]) // BANKER
	{
        Dialog_Show(playerid, DIALOG_BANKER, DIALOG_STYLE_INPUT, "[การวางเดิมพัน]", "{FFFFFF}คุณต้องการวางเดิมพัน {FD2305}BANKER {FFFFFF}เป็นจำนวนเงินเท่าใด", "ตกลง", "ออก");
	}

	if(clickedid == BACARATextDraws[2]) // BANKER
	{
		HideBACARA(playerid);
		JoinBacara[playerid] = 0;
	}
}

Dialog:DIALOG_PLAYER(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext);

	if(!response)
	{
		return 1;
	}

	if(response)
	{
        if (BacaraTime <= 0)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "* หมดเวลาในการลงเดิมพันแล้ว");

	    if (GetPlayerMoneyEx(playerid) < amount)
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณมีเงินไม่เพียงพอ");

		if (BacaraMoney[playerid] != 0)
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณอยู่ระหว่างการเดิมพัน!");

	    if (amount > 50000)
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณต้องระบุจำนวนไม่เกิน $50,000 ต่อตา");

	    if (amount <= 0)
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณต้องระบุจำนวนมากกว่า 0");

		BacaraType[playerid] = 1;
		BacaraMoney[playerid] = amount;
		GivePlayerMoneyEx(playerid, -amount);

		SendClientMessageEx(playerid, COLOR_YELLOW, "[คาสิโน] : {FFFFFF}คุณได้ทำการวางเดิมพันเป็นจำนวนเงิน {05FD0D}$%s {FFFFFF}แล้ว", FormatNumber(amount));
	}
	return 1;
}

Dialog:DIALOG_TIE(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext);

	if(!response)
	{
		return 1;
	}

	if(response)
	{
        if (BacaraTime <= 0)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "* หมดเวลาในการลงเดิมพันแล้ว");

	    if (GetPlayerMoneyEx(playerid) < amount)
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณมีเงินไม่เพียงพอ");

		if (BacaraMoney[playerid] != 0)
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณอยู่ระหว่างการเดิมพัน!");

	    if (amount > 50000)
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณต้องระบุจำนวนไม่เกิน $50,000 ต่อตา");

	    if (amount <= 0)
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณต้องระบุจำนวนมากกว่า 0");

		BacaraType[playerid] = 2;
		BacaraMoney[playerid] = amount;
		GivePlayerMoneyEx(playerid, -amount);

		SendClientMessageEx(playerid, COLOR_YELLOW, "[คาสิโน] : {FFFFFF}คุณได้ทำการวางเดิมพันเป็นจำนวนเงิน {05FD0D}$%s {FFFFFF}แล้ว", FormatNumber(amount));
	}
	return 1;
}

Dialog:DIALOG_BANKER(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext);

	if(!response)
	{
		return 1;
	}

	if(response)
	{
        if (BacaraTime <= 0)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "* หมดเวลาในการลงเดิมพันแล้ว");

	    if (GetPlayerMoneyEx(playerid) < amount)
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณมีเงินไม่เพียงพอ");

		if (BacaraMoney[playerid] != 0)
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณอยู่ระหว่างการเดิมพัน!");

	    if (amount > 50000)
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณต้องระบุจำนวนไม่เกิน $50,000 ต่อตา");

	    if (amount <= 0)
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณต้องระบุจำนวนมากกว่า 0");

		BacaraType[playerid] = 3;
		BacaraMoney[playerid] = amount;
		GivePlayerMoneyEx(playerid, -amount);

		SendClientMessageEx(playerid, COLOR_YELLOW, "[คาสิโน] : {FFFFFF}คุณได้ทำการวางเดิมพันเป็นจำนวนเงิน {05FD0D}$%s {FFFFFF}แล้ว", FormatNumber(amount));
	}
	return 1;
}

task BacaraTimer[1000]()
{
	new str_bacara[256], string[256];

	if (BacaraActive == 0)
	{
		if (BacaraTime > 0)
		{
  			BacaraTime --;

			if (BacaraTime == 0)
			{
				BacaraActive = 1;
			}

			static
				hours,
				minutes,
				seconds;

			GetElapsedTime(BacaraTime, hours, minutes, seconds);

			format(str_bacara, sizeof(str_bacara), "00:%02d", seconds);
			TextDrawSetString(BACARATextDraws[25], str_bacara);
		}
	}

    /*foreach (new i : Player)
    {*/

	if (BacaraActive == 1)
	{
		new bacara1 = random(44), bacara2 = random(44), bacara3 = random(44);
		new bacara4 = random(44), bacara5 = random(44), bacara6 = random(44);

		BacaraNumber ++;

		switch(BacaraNumber)
		{
			case 0:
			{

			}
			case 1:
			{
				format(string, sizeof(string), "%s", BacaraInfo[bacara1][Name]);
				TextDrawSetString(BACARATextDraws[6], string);

				PlayerBA[0] = BacaraInfo[bacara1][Point];
			}
			case 2:
			{
				format(string, sizeof(string), "%s", BacaraInfo[bacara2][Name]);
				TextDrawSetString(BACARATextDraws[7], string);

				PlayerBA[1] = BacaraInfo[bacara2][Point];
			}
			case 3:
			{
				format(string, sizeof(string), "%s", BacaraInfo[bacara3][Name]);
				TextDrawSetString(BACARATextDraws[8], string);

				PlayerBA[2] = BacaraInfo[bacara3][Point];

				PlayerPoint = PlayerBA[0] + PlayerBA[1] + PlayerBA[2];

				switch (PlayerPoint)
				{
					case 0..9:
					{

					}
					case 10: PlayerPoint = 0;
					case 11: PlayerPoint = 1;
					case 12: PlayerPoint = 2;
					case 13: PlayerPoint = 3;
					case 14: PlayerPoint = 4;
					case 15: PlayerPoint = 5;
					case 16: PlayerPoint = 6;
					case 17: PlayerPoint = 7;
					case 18: PlayerPoint = 8;
					case 19: PlayerPoint = 9;
					case 20: PlayerPoint = 0;
					case 21: PlayerPoint = 1;
					case 22: PlayerPoint = 2;
					case 23: PlayerPoint = 3;
					case 24: PlayerPoint = 4;
					case 25: PlayerPoint = 5;
					case 26: PlayerPoint = 6;
					case 27: PlayerPoint = 7;
					case 28: PlayerPoint = 8;
					case 29: PlayerPoint = 9;
					case 30: PlayerPoint = 0;
					case 31: PlayerPoint = 1;
					case 32: PlayerPoint = 2;
					case 33: PlayerPoint = 3;
					case 34: PlayerPoint = 4;
					case 35: PlayerPoint = 5;
					case 36: PlayerPoint = 6;
					case 37: PlayerPoint = 7;
					case 38: PlayerPoint = 8;
					case 39: PlayerPoint = 9;
	    		}

				// แสดงค่า [PLAYER]
				/*if (PlayerPoint >= 10)
				{
					switch (PlayerPoint)
					{
						case 0..9:
						{

						}
						case 10: PlayerPoint = 0;
						case 11: PlayerPoint = 1;
						case 12: PlayerPoint = 2;
						case 13: PlayerPoint = 3;
						case 14: PlayerPoint = 4;
						case 15: PlayerPoint = 5;
						case 16: PlayerPoint = 6;
						case 17: PlayerPoint = 7;
						case 18: PlayerPoint = 8;
						case 19: PlayerPoint = 9;
						case 20: PlayerPoint = 0;
						case 21: PlayerPoint = 1;
						case 22: PlayerPoint = 2;
						case 23: PlayerPoint = 3;
						case 24: PlayerPoint = 4;
						case 25: PlayerPoint = 5;
						case 26: PlayerPoint = 6;
						case 27: PlayerPoint = 7;
						case 28: PlayerPoint = 8;
						case 29: PlayerPoint = 9;
						case 30: PlayerPoint = 0;
						case 31: PlayerPoint = 1;
						case 32: PlayerPoint = 2;
						case 33: PlayerPoint = 3;
						case 34: PlayerPoint = 4;
						case 35: PlayerPoint = 5;
						case 36: PlayerPoint = 6;
						case 37: PlayerPoint = 7;
						case 38: PlayerPoint = 8;
						case 39: PlayerPoint = 9;
				    }
				}*/

				SendBacaraMessage(COLOR_YELLOW, "[CASINO] {FFFFFF}PLAYER | %d", PlayerPoint);
			}
			case 4:
			{
				format(string, sizeof(string), "%s", BacaraInfo[bacara4][Name]);
				TextDrawSetString(BACARATextDraws[9], string);

				BankerBA[0] = BacaraInfo[bacara4][Point];
			}
			case 5:
			{
				format(string, sizeof(string), "%s", BacaraInfo[bacara5][Name]);
				TextDrawSetString(BACARATextDraws[10], string);

				BankerBA[1] = BacaraInfo[bacara5][Point];
			}
			case 6:
			{
				format(string, sizeof(string), "%s", BacaraInfo[bacara6][Name]);
				TextDrawSetString(BACARATextDraws[11], string);

				BankerBA[2] = BacaraInfo[bacara6][Point];

				BankerPoint = BankerBA[0] + BankerBA[1] + BankerBA[2];

				switch (BankerPoint)
				{
					case 0..9:
					{

					}
					case 10: BankerPoint = 0;
					case 11: BankerPoint = 1;
					case 12: BankerPoint = 2;
					case 13: BankerPoint = 3;
					case 14: BankerPoint = 4;
					case 15: BankerPoint = 5;
					case 16: BankerPoint = 6;
					case 17: BankerPoint = 7;
					case 18: BankerPoint = 8;
					case 19: BankerPoint = 9;
					case 20: BankerPoint = 0;
					case 21: BankerPoint = 1;
					case 22: BankerPoint = 2;
					case 23: BankerPoint = 3;
					case 24: BankerPoint = 4;
					case 25: BankerPoint = 5;
					case 26: BankerPoint = 6;
					case 27: BankerPoint = 7;
					case 28: BankerPoint = 8;
					case 29: BankerPoint = 9;
					case 30: BankerPoint = 0;
					case 31: BankerPoint = 1;
					case 32: BankerPoint = 2;
					case 33: BankerPoint = 3;
					case 34: BankerPoint = 4;
					case 35: BankerPoint = 5;
					case 36: BankerPoint = 6;
					case 37: BankerPoint = 7;
					case 38: BankerPoint = 8;
					case 39: BankerPoint = 9;
	    		}

				SendBacaraMessage(COLOR_YELLOW, "[CASINO] {FFFFFF}BANKER | %d", BankerPoint);
			}
			case 7:
			{
				if (PlayerPoint != -1 && BankerPoint != -1)
				{
	   				if (PlayerPoint > BankerPoint)
				    {
				        SendBacaraMessage(COLOR_YELLOW, "[PLAYER] {FFFFFF}เป็นฝ่ายชนะ !");

				        foreach (new i : Player)
				        {

							if (BacaraType[i] == 1) // PLAYER
							{
								GivePlayerMoneyEx(i, BacaraMoney[i]*2);
								SendClientMessage(i, COLOR_GREEN, "[คาสิโน] : {FFFF00}คุณชนะในการเดิมพันครั้งนี้! (1:1)");
							}

							else if (BacaraType[i] == 2) // TIE
							{
								SendClientMessage(i, COLOR_RED, "[คาสิโน] : {FF6347}คุณแพ้การเดิมพันในครั้งนี้!");
							}

							else if (BacaraType[i] == 3) // BANKER
							{
								SendClientMessage(i, COLOR_RED, "[คาสิโน] : {FF6347}คุณแพ้การเดิมพันในครั้งนี้!");
							}
						}
					}

					if (BankerPoint > PlayerPoint)
					{
					    SendBacaraMessage(COLOR_YELLOW, "[BANKER] {FFFFFF}เป็นฝ่ายชนะ !");

					    foreach (new i : Player)
					    {

							if (BacaraType[i] == 1) // PLAYER
							{
								SendClientMessage(i, i, "[คาสิโน] : {FF6347}คุณแพ้การเดิมพันในครั้งนี้!");
							}

							else if (BacaraType[i] == 2) // TIE
							{
								SendClientMessage(i, i, "[คาสิโน] : {FF6347}คุณแพ้การเดิมพันในครั้งนี้!");
							}

							else if (BacaraType[i] == 3) // BANKER
							{
								GivePlayerMoneyEx(i, BacaraMoney[i]*2);
								SendClientMessage(i, COLOR_GREEN, "[คาสิโน] : {FFFF00}คุณชนะในการเดิมพันครั้งนี้! (1:1)");
							}
						}
					}

					if (BankerPoint == PlayerPoint)
					{
					    SendBacaraMessage(COLOR_YELLOW, "[เสมอ] {FFFFFF}ไม่มีใครชนะ!");

					    foreach (new i : Player)
					    {

							if (BacaraType[i] == 1) // PLAYER
							{
								SendClientMessage(i, COLOR_YELLOW, "[คาสิโน] : {FF6347}คุณแพ้การเดิมพันในครั้งนี้!");
							}

							else if (BacaraType[i] == 2)  // TIE
							{
								GivePlayerMoneyEx(i, BacaraMoney[i]*6);
								SendClientMessage(i, COLOR_YELLOW, "[คาสิโน] : {FFFF00}คุณชนะในการเดิมพันครั้งนี้! (1:5)");
							}

							else if (BacaraType[i] == 3)  // BANKER
							{
								SendClientMessage(i, COLOR_YELLOW, "[คาสิโน] : {FF6347}คุณแพ้การเดิมพันในครั้งนี้!");
							}
						}
					}

	                foreach (new i : Player)
	                {
						BacaraType[i] = 0;
						BacaraMoney[i] = 0;
					}

					BacaraNumber = 0;
					BacaraActive = 0;
					BacaraTime = 30;

				    PlayerPoint = -1;
				    BankerPoint = -1;

					TextDrawSetString(BACARATextDraws[6], "ld_card:cdback");
					TextDrawSetString(BACARATextDraws[7], "ld_card:cdback");
					TextDrawSetString(BACARATextDraws[8], "ld_card:cdback");

					TextDrawSetString(BACARATextDraws[9], "ld_card:cdback");
					TextDrawSetString(BACARATextDraws[10], "ld_card:cdback");
					TextDrawSetString(BACARATextDraws[11], "ld_card:cdback");
				}
			}
		}
	}

	return 1;
}

SendBacaraMessage(color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

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
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (JoinBacara[i] == 1)
			{
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (JoinBacara[i] == 1)
		{
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}
