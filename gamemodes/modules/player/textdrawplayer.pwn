#include <YSI\y_hooks>

new PlayerText:HUDSHOW[MAX_PLAYERS][40];

new PlayerBar:EXPBAR[MAX_PLAYERS] = {INVALID_PLAYER_BAR_ID, ...};
new PlayerBar:ThirstyBAR[MAX_PLAYERS] = {INVALID_PLAYER_BAR_ID, ...};
new PlayerBar:HungryBAR[MAX_PLAYERS] = {INVALID_PLAYER_BAR_ID, ...};

new PlayerBar:TASERBAR[MAX_PLAYERS] = {INVALID_PLAYER_BAR_ID, ...};

new PlayerBar:TASERBARAG[MAX_PLAYERS] = {INVALID_PLAYER_BAR_ID, ...};

new PlayerText:Ping[MAX_PLAYERS][7];

Inventory(playerid)
{

    return 1;
}
LoadHudShowPlayerTextDraw(playerid)
{
    Ping[playerid][0] = CreatePlayerTextDraw(playerid, 617.333129, 106.222206, "box");
    PlayerTextDrawLetterSize(playerid, Ping[playerid][0], 0.000000, 1.200003);
    PlayerTextDrawTextSize(playerid, Ping[playerid][0], 0.000000, 3.000000);
    PlayerTextDrawAlignment(playerid, Ping[playerid][0], 2);
    PlayerTextDrawColor(playerid, Ping[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, Ping[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, Ping[playerid][0], 255);
    PlayerTextDrawSetShadow(playerid, Ping[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, Ping[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, Ping[playerid][0], 255);
    PlayerTextDrawFont(playerid, Ping[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, Ping[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, Ping[playerid][0], 0);

    Ping[playerid][1] = CreatePlayerTextDraw(playerid, 617.333190, 106.622253, "Green1");
    PlayerTextDrawLetterSize(playerid, Ping[playerid][1], 0.000000, 1.100003);
    PlayerTextDrawTextSize(playerid, Ping[playerid][1], 0.000000, 2.000000);
    PlayerTextDrawAlignment(playerid, Ping[playerid][1], 2);
    PlayerTextDrawColor(playerid, Ping[playerid][1], -1);
    PlayerTextDrawUseBox(playerid, Ping[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid, Ping[playerid][1], 7864575);
    PlayerTextDrawSetShadow(playerid, Ping[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, Ping[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, Ping[playerid][1], 255);
    PlayerTextDrawFont(playerid, Ping[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, Ping[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, Ping[playerid][1], 0);

    Ping[playerid][2] = CreatePlayerTextDraw(playerid, 623.666381, 99.999969, "box");
    PlayerTextDrawLetterSize(playerid, Ping[playerid][2], 0.000000, 1.900002);
    PlayerTextDrawTextSize(playerid, Ping[playerid][2], 0.000000, 3.000000);
    PlayerTextDrawAlignment(playerid, Ping[playerid][2], 2);
    PlayerTextDrawColor(playerid, Ping[playerid][2], -1);
    PlayerTextDrawUseBox(playerid, Ping[playerid][2], 1);
    PlayerTextDrawBoxColor(playerid, Ping[playerid][2], 255);
    PlayerTextDrawSetShadow(playerid, Ping[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, Ping[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, Ping[playerid][2], 255);
    PlayerTextDrawFont(playerid, Ping[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, Ping[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, Ping[playerid][2], 0);

    Ping[playerid][3] = CreatePlayerTextDraw(playerid, 623.666198, 100.400024, "Green2");
    PlayerTextDrawLetterSize(playerid, Ping[playerid][3], 0.000000, 1.800003);
    PlayerTextDrawTextSize(playerid, Ping[playerid][3], 0.000000, 2.000000);
    PlayerTextDrawAlignment(playerid, Ping[playerid][3], 2);
    PlayerTextDrawColor(playerid, Ping[playerid][3], -1);
    PlayerTextDrawUseBox(playerid, Ping[playerid][3], 1);
    PlayerTextDrawBoxColor(playerid, Ping[playerid][3], 7864575);
    PlayerTextDrawSetShadow(playerid, Ping[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, Ping[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, Ping[playerid][3], 255);
    PlayerTextDrawFont(playerid, Ping[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, Ping[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, Ping[playerid][3], 0);

    Ping[playerid][4] = CreatePlayerTextDraw(playerid, 629.999450, 94.192550, "box");
    PlayerTextDrawLetterSize(playerid, Ping[playerid][4], 0.000000, 2.533335);
    PlayerTextDrawTextSize(playerid, Ping[playerid][4], 0.000000, 3.000000);
    PlayerTextDrawAlignment(playerid, Ping[playerid][4], 2);
    PlayerTextDrawColor(playerid, Ping[playerid][4], -1);
    PlayerTextDrawUseBox(playerid, Ping[playerid][4], 1);
    PlayerTextDrawBoxColor(playerid, Ping[playerid][4], 255);
    PlayerTextDrawSetShadow(playerid, Ping[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, Ping[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, Ping[playerid][4], 255);
    PlayerTextDrawFont(playerid, Ping[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, Ping[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, Ping[playerid][4], 0);

    Ping[playerid][5] = CreatePlayerTextDraw(playerid, 629.999694, 94.592597, "Green3");
    PlayerTextDrawLetterSize(playerid, Ping[playerid][5], 0.000000, 2.433336);
    PlayerTextDrawTextSize(playerid, Ping[playerid][5], 0.000000, 2.000000);
    PlayerTextDrawAlignment(playerid, Ping[playerid][5], 2);
    PlayerTextDrawColor(playerid, Ping[playerid][5], -1);
    PlayerTextDrawUseBox(playerid, Ping[playerid][5], 1);
    PlayerTextDrawBoxColor(playerid, Ping[playerid][5], 7864575);
    PlayerTextDrawSetShadow(playerid, Ping[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, Ping[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, Ping[playerid][5], 255);
    PlayerTextDrawFont(playerid, Ping[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, Ping[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, Ping[playerid][5], 0);

    Ping[playerid][6] = CreatePlayerTextDraw(playerid, 623.666625, 111.599960, "100");
    PlayerTextDrawLetterSize(playerid, Ping[playerid][6], 0.159333, 0.824296);
    PlayerTextDrawAlignment(playerid, Ping[playerid][6], 2);
    PlayerTextDrawColor(playerid, Ping[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, Ping[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, Ping[playerid][6], 1);
    PlayerTextDrawBackgroundColor(playerid, Ping[playerid][6], 255);
    PlayerTextDrawFont(playerid, Ping[playerid][6], 1);
    PlayerTextDrawSetProportional(playerid, Ping[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, Ping[playerid][6], 0);

    HUDSHOW[playerid][0] = CreatePlayerTextDraw(playerid, 319.666748, 104.962966, "box");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][0], 0.000000, 33.333332);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][0], 0.000000, 514.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][0], 2);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][0], -1785293057);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][0], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][0], 0);

    HUDSHOW[playerid][1] = CreatePlayerTextDraw(playerid, 319.666809, 104.548141, "box");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][1], 0.000000, 1.400006);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][1], 0.000000, 515.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][1], 2);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][1], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][1], 255);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][1], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][1], 0);

    HUDSHOW[playerid][2] = CreatePlayerTextDraw(playerid, 65.000022, 105.377769, "Alexander_Morteres");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][2], 0.170331, 0.948740);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][2], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][2], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][2], 2);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][2], 0);

    HUDSHOW[playerid][3] = CreatePlayerTextDraw(playerid, 570.333129, 104.962936, "box");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][3], 0.000000, 1.300006);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][3], 0.000000, 13.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][3], 2);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][3], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][3], 1);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][3], -889192193);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][3], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][3], 0);

    HUDSHOW[playerid][4] = CreatePlayerTextDraw(playerid, 567.333068, 105.377792, "X");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][4], 0.284999, 1.102221);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][4], 574.000000, 10.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][4], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][4], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][4], 0);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][4], 255);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][4], 1);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][4], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][4], 0);
    PlayerTextDrawSetSelectable(playerid, HUDSHOW[playerid][4], true);

    HUDSHOW[playerid][5] = CreatePlayerTextDraw(playerid, 96.333343, 123.214805, "box1");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][5], 0.000000, 1.533331);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][5], 0.000000, 62.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][5], 2);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][5], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][5], 1);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][5], 842150655);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][5], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][5], 0);

    HUDSHOW[playerid][6] = CreatePlayerTextDraw(playerid, 80.999977, 124.459228, "Statsus");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][6], 0.165996, 1.118816);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][6], 112.000000, 20.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][6], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][6], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][6], 0);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][6], 255);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][6], 1);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][6], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][6], 2);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][6], 1);
    PlayerTextDrawSetSelectable(playerid, HUDSHOW[playerid][6], true);

    HUDSHOW[playerid][7] = CreatePlayerTextDraw(playerid, 95.999984, 146.444458, "box2");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][7], 0.000000, 1.533331);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][7], 0.000000, 62.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][7], 2);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][7], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][7], 1);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][7], 842150655);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][7], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][7], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][7], 0);

    HUDSHOW[playerid][8] = CreatePlayerTextDraw(playerid, 77.666656, 148.103622, "Inventory");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][8], 0.165996, 1.118816);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][8], 115.000000, 20.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][8], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][8], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][8], 0);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][8], 255);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][8], 1);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][8], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][8], 2);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][8], 1);
    PlayerTextDrawSetSelectable(playerid, HUDSHOW[playerid][8], true);

    HUDSHOW[playerid][9] = CreatePlayerTextDraw(playerid, 95.999984, 169.674026, "box3");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][9], 0.000000, 1.533331);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][9], 0.000000, 62.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][9], 2);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][9], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][9], 1);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][9], 842150655);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][9], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][9], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][9], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][9], 0);

    HUDSHOW[playerid][10] = CreatePlayerTextDraw(playerid, 77.666618, 171.333267, "Help_Menu");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][10], 0.165996, 1.118816);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][10], 117.000000, 20.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][10], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][10], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][10], 0);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][10], 255);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][10], 1);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][10], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][10], 2);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][10], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][10], 1);
    PlayerTextDrawSetSelectable(playerid, HUDSHOW[playerid][10], true);

    HUDSHOW[playerid][11] = CreatePlayerTextDraw(playerid, 95.999977, 192.903656, "box4");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][11], 0.000000, 1.533331);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][11], 0.000000, 62.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][11], 2);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][11], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][11], 1);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][11], 842150655);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][11], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][11], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][11], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][11], 0);

    HUDSHOW[playerid][12] = CreatePlayerTextDraw(playerid, 86.333335, 193.733276, "Rules");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][12], 0.165996, 1.118816);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][12], 107.000000, 20.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][12], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][12], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][12], 0);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][12], 255);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][12], 1);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][12], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][12], 2);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][12], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][12], 1);
    PlayerTextDrawSetSelectable(playerid, HUDSHOW[playerid][12], true);

    HUDSHOW[playerid][13] = CreatePlayerTextDraw(playerid, 95.999954, 216.548095, "box5");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][13], 0.000000, 1.533331);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][13], 0.000000, 62.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][13], 2);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][13], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][13], 1);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][13], 842150655);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][13], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][13], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][13], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][13], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][13], 0);

    HUDSHOW[playerid][14] = CreatePlayerTextDraw(playerid, 79.000030, 217.377746, "Contract");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][14], 0.165996, 1.118816);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][14], 114.000000, 20.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][14], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][14], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][14], 0);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][14], 255);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][14], 1);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][14], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][14], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][14], 2);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][14], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][14], 1);
    PlayerTextDrawSetSelectable(playerid, HUDSHOW[playerid][14], true);

    HUDSHOW[playerid][15] = CreatePlayerTextDraw(playerid, 95.999931, 387.037139, "box6");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][15], 0.000000, 1.533331);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][15], 0.000000, 62.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][15], 2);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][15], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][15], 1);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][15], 842150655);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][15], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][15], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][15], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][15], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][15], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][15], 0);

    HUDSHOW[playerid][16] = CreatePlayerTextDraw(playerid, 83.666595, 388.696289, "Logout");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][16], 0.165996, 1.118816);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][16], 112.000000, 20.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][16], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][16], -16776961);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][16], 0);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][16], 255);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][16], 1);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][16], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][16], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][16], 2);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][16], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][16], 1);
    PlayerTextDrawSetSelectable(playerid, HUDSHOW[playerid][16], true);

    HUDSHOW[playerid][17] = CreatePlayerTextDraw(playerid, 132.333190, 123.214920, "Line");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][17], 0.000000, 30.866661);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][17], 0.000000, -2.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][17], 2);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][17], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][17], 1);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][17], 842150655);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][17], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][17], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][17], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][17], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][17], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][17], 0);

    HUDSHOW[playerid][18] = CreatePlayerTextDraw(playerid, 192.666564, 123.629722, "BGCHAR");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][18], 0.000000, 12.633332);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][18], 0.000000, 112.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][18], 2);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][18], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][18], 1);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][18], 842150655);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][18], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][18], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][18], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][18], 2);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][18], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][18], 0);

    HUDSHOW[playerid][19] = CreatePlayerTextDraw(playerid, 62.666679, 123.888847, "");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][19], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][19], 262.000000, 255.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][19], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][19], -1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][19], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][19], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][19], 0);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][19], 5);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][19], 0);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][19], 0);
    PlayerTextDrawSetPreviewModel(playerid, HUDSHOW[playerid][19], 165);
    PlayerTextDrawSetPreviewRot(playerid, HUDSHOW[playerid][19], 0.000000, 0.000000, 20.000000, 0.899999);

    HUDSHOW[playerid][20] = CreatePlayerTextDraw(playerid, 317.666625, 239.362930, "BGHIDECHAR");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][20], 0.000000, 18.199996);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][20], 0.000000, 362.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][20], 2);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][20], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][20], 1);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][20], -1785293057);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][20], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][20], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][20], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][20], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][20], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][20], 0);

    HUDSHOW[playerid][21] = CreatePlayerTextDraw(playerid, 255.000015, 121.970375, "Name_-");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][21], 0.263332, 1.425778);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][21], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][21], 1515870975);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][21], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][21], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][21], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][21], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][21], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][21], 0);

    HUDSHOW[playerid][22] = CreatePlayerTextDraw(playerid, 290.000000, 122.385185, "Alexander_Morteres");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][22], 0.263332, 1.425778);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][22], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][22], -436207617);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][22], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][22], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][22], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][22], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][22], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][22], 0);

    HUDSHOW[playerid][23] = CreatePlayerTextDraw(playerid, 255.000015, 136.903686, "Age_-");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][23], 0.263332, 1.425778);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][23], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][23], 1515870975);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][23], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][23], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][23], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][23], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][23], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][23], 0);

    HUDSHOW[playerid][24] = CreatePlayerTextDraw(playerid, 281.666595, 137.318511, "30");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][24], 0.263332, 1.425778);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][24], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][24], -436207617);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][24], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][24], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][24], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][24], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][24], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][24], 0);

    HUDSHOW[playerid][25] = CreatePlayerTextDraw(playerid, 255.000015, 152.251831, "Phone_number_-_");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][25], 0.263332, 1.425778);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][25], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][25], 1515870975);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][25], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][25], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][25], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][25], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][25], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][25], 0);

    HUDSHOW[playerid][26] = CreatePlayerTextDraw(playerid, 327.666656, 152.666641, "304512");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][26], 0.263332, 1.425778);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][26], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][26], -436207617);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][26], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][26], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][26], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][26], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][26], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][26], 0);

    HUDSHOW[playerid][27] = CreatePlayerTextDraw(playerid, 254.999984, 168.844375, "Job_-");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][27], 0.263332, 1.425778);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][27], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][27], 1515870975);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][27], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][27], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][27], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][27], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][27], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][27], 0);

    HUDSHOW[playerid][28] = CreatePlayerTextDraw(playerid, 280.333374, 169.674041, "Farmer");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][28], 0.263332, 1.425778);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][28], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][28], -436207617);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][28], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][28], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][28], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][28], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][28], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][28], 0);

    HUDSHOW[playerid][29] = CreatePlayerTextDraw(playerid, 254.666656, 185.436950, "Side_Job_-");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][29], 0.263332, 1.425778);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][29], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][29], 1515870975);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][29], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][29], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][29], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][29], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][29], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][29], 0);

    HUDSHOW[playerid][30] = CreatePlayerTextDraw(playerid, 302.333496, 185.851760, "Mechanic");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][30], 0.263332, 1.425778);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][30], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][30], -436207617);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][30], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][30], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][30], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][30], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][30], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][30], 0);

    HUDSHOW[playerid][31] = CreatePlayerTextDraw(playerid, 254.666656, 201.614730, "Group_-");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][31], 0.263332, 1.425778);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][31], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][31], 1515870975);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][31], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][31], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][31], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][31], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][31], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][31], 0);

    HUDSHOW[playerid][32] = CreatePlayerTextDraw(playerid, 291.333465, 202.029541, "Los_Santos_Police_Department");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][32], 0.263332, 1.425778);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][32], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][32], -436207617);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][32], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][32], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][32], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][32], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][32], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][32], 0);

    HUDSHOW[playerid][33] = CreatePlayerTextDraw(playerid, 255.666656, 218.622161, "Rank_-");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][33], 0.263332, 1.425778);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][33], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][33], 1515870975);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][33], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][33], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][33], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][33], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][33], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][33], 0);

    HUDSHOW[playerid][34] = CreatePlayerTextDraw(playerid, 286.000000, 219.036941, "Cheif_of_Police");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][34], 0.263332, 1.425778);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][34], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][34], -436207617);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][34], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][34], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][34], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][34], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][34], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][34], 0);

    HUDSHOW[playerid][35] = CreatePlayerTextDraw(playerid, 354.333038, 245.585296, "BGCHAR");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][35], 0.000000, 17.199996);
    PlayerTextDrawTextSize(playerid, HUDSHOW[playerid][35], 0.000000, 435.000000);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][35], 2);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][35], -1);
    PlayerTextDrawUseBox(playerid, HUDSHOW[playerid][35], 1);
    PlayerTextDrawBoxColor(playerid, HUDSHOW[playerid][35], 842150563);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][35], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][35], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][35], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][35], 2);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][35], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][35], 0);

    HUDSHOW[playerid][36] = CreatePlayerTextDraw(playerid, 193.999954, 123.629562, "ID_-_152");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][36], 0.135000, 0.832593);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][36], 2);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][36], -436207617);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][36], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][36], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][36], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][36], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][36], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][36], 0);

    HUDSHOW[playerid][37] = CreatePlayerTextDraw(playerid, 140.666595, 249.318374, "Exp_-_300/300");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][37], 0.207000, 1.218369);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][37], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][37], -436207617);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][37], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][37], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][37], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][37], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][37], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][37], 0);

    HUDSHOW[playerid][38] = CreatePlayerTextDraw(playerid, 140.666595, 273.318374, "Hungry_-_100");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][38], 0.207000, 1.218369);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][38], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][38], -436207617);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][38], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][38], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][38], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][38], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][38], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][38], 0);

    HUDSHOW[playerid][39] = CreatePlayerTextDraw(playerid, 140.666595, 297.318374, "Thirsty_-_100");
    PlayerTextDrawLetterSize(playerid, HUDSHOW[playerid][39], 0.207000, 1.218369);
    PlayerTextDrawAlignment(playerid, HUDSHOW[playerid][39], 1);
    PlayerTextDrawColor(playerid, HUDSHOW[playerid][39], -436207617);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][39], 0);
    PlayerTextDrawSetOutline(playerid, HUDSHOW[playerid][39], 0);
    PlayerTextDrawBackgroundColor(playerid, HUDSHOW[playerid][39], 255);
    PlayerTextDrawFont(playerid, HUDSHOW[playerid][39], 1);
    PlayerTextDrawSetProportional(playerid, HUDSHOW[playerid][39], 1);
    PlayerTextDrawSetShadow(playerid, HUDSHOW[playerid][39], 0);

    EXPBAR[playerid] = CreatePlayerProgressBar(playerid, 142.0, 265.00, 100.0, 5.0, 0xFFFF00FF, 100.0, BAR_DIRECTION_RIGHT);
    ThirstyBAR[playerid] = CreatePlayerProgressBar(playerid, 142.0, 290.00, 100.0, 5.0, 0x76C3FFFF, 100.0, BAR_DIRECTION_RIGHT);
    HungryBAR[playerid] = CreatePlayerProgressBar(playerid, 142.0, 316.00, 100.0, 5.0, 0xD78E10FF, 100.0, BAR_DIRECTION_RIGHT);

    TASERBAR[playerid] = CreatePlayerProgressBar(playerid, 240.0, 300.00, 150.0, 5.0, 0xFFFFFFAA, 10.0, BAR_DIRECTION_RIGHT);
    TASERBARAG[playerid] = CreatePlayerProgressBar(playerid, 240.0, 300.00, 150.0, 5.0, 0xFFFFFFAA, 5.0, BAR_DIRECTION_RIGHT);
    return 1;
}

ShowUserPing(playerid)
{
    for(new i=0;i<7;i++)
        PlayerTextDrawShow(playerid, Ping[playerid][i]);
    return 1;
}

HideUserPing(playerid)
{
    for(new i=0;i<7;i++)
        PlayerTextDrawHide(playerid, Ping[playerid][i]);
    return 1;
}


ShowUserControl(playerid)
{
    for(new i=0;i<40;i++)
        PlayerTextDrawShow(playerid, HUDSHOW[playerid][i]);

    ShowPlayerProgressBar(playerid, EXPBAR[playerid]);
    ShowPlayerProgressBar(playerid, ThirstyBAR[playerid]);
    ShowPlayerProgressBar(playerid, HungryBAR[playerid]);
    return 1;
}

HideUserControl(playerid)
{
    for(new i=0;i<40;i++)
        PlayerTextDrawHide(playerid, HUDSHOW[playerid][i]);

    HidePlayerProgressBar(playerid, EXPBAR[playerid]);
    HidePlayerProgressBar(playerid, ThirstyBAR[playerid]);
    HidePlayerProgressBar(playerid, HungryBAR[playerid]);
    return 1;
}

CMD:edittaser(playerid, params[])
{
    new Float:bx,
		Float:by,
		Float:bw,
		Float:bh;
		
	if(Account[playerid][Admin] < 1338)
		return SendClientMessage(playerid, -1, "ไม่เสือก");


	if (sscanf(params, "ffff", bx, by, bw, bh))
 	   return SendClientMessage(playerid, -1,"/edittaser [X] [Y] [W] [H]");

    SetPlayerProgressBarPos(playerid, TASERBAR[playerid], bx, by);
    SetPlayerProgressBarWidth(playerid, TASERBAR[playerid], bw);
    SetPlayerProgressBarHeight(playerid, TASERBAR[playerid], bh);
    SetPlayerProgressBarDirection(playerid, TASERBAR[playerid], BAR_DIRECTION_RIGHT);

	return 1;
}