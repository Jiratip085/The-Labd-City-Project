#include	<YSI_Coding\y_hooks>

Brian_GachapongCreateUi(playerid)
{
	Interface_Gc_Ui[playerid][0] = CreatePlayerTextDraw(playerid, 308.000000, 154.000000, "_");
	PlayerTextDrawFont(playerid, Interface_Gc_Ui[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, Interface_Gc_Ui[playerid][0], 0.600000, 8.600006);
	PlayerTextDrawTextSize(playerid, Interface_Gc_Ui[playerid][0], 298.500000, 321.500000);
	PlayerTextDrawSetOutline(playerid, Interface_Gc_Ui[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, Interface_Gc_Ui[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, Interface_Gc_Ui[playerid][0], 2);
	PlayerTextDrawColor(playerid, Interface_Gc_Ui[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, Interface_Gc_Ui[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, Interface_Gc_Ui[playerid][0], 255);
	PlayerTextDrawUseBox(playerid, Interface_Gc_Ui[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, Interface_Gc_Ui[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, Interface_Gc_Ui[playerid][0], 0);

	Interface_Gc_Ui[playerid][1] = CreatePlayerTextDraw(playerid, 308.000000, 131.000000, "_");
	PlayerTextDrawFont(playerid, Interface_Gc_Ui[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, Interface_Gc_Ui[playerid][1], 0.600000, 2.300003);
	PlayerTextDrawTextSize(playerid, Interface_Gc_Ui[playerid][1], 298.500000, 321.500000);
	PlayerTextDrawSetOutline(playerid, Interface_Gc_Ui[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, Interface_Gc_Ui[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, Interface_Gc_Ui[playerid][1], 2);
	PlayerTextDrawColor(playerid, Interface_Gc_Ui[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, Interface_Gc_Ui[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, Interface_Gc_Ui[playerid][1], -301779457);
	PlayerTextDrawUseBox(playerid, Interface_Gc_Ui[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, Interface_Gc_Ui[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, Interface_Gc_Ui[playerid][1], 0);

	Interface_Gc_Ui[playerid][2] = CreatePlayerTextDraw(playerid, 307.000000, 132.000000, "GTA IRONPIE CITY");
	PlayerTextDrawFont(playerid, Interface_Gc_Ui[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, Interface_Gc_Ui[playerid][2], 0.279166, 1.900000);
	PlayerTextDrawTextSize(playerid, Interface_Gc_Ui[playerid][2], 400.000000, 117.000000);
	PlayerTextDrawSetOutline(playerid, Interface_Gc_Ui[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, Interface_Gc_Ui[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, Interface_Gc_Ui[playerid][2], 2);
	PlayerTextDrawColor(playerid, Interface_Gc_Ui[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, Interface_Gc_Ui[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, Interface_Gc_Ui[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, Interface_Gc_Ui[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, Interface_Gc_Ui[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, Interface_Gc_Ui[playerid][2], 0);

	Interface_Gc_Ui[playerid][3] = CreatePlayerTextDraw(playerid, 461.000000, 118.000000, "X");
	PlayerTextDrawFont(playerid, Interface_Gc_Ui[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, Interface_Gc_Ui[playerid][3], 0.679166, 2.950000);
	PlayerTextDrawTextSize(playerid, Interface_Gc_Ui[playerid][3], 490.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Interface_Gc_Ui[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, Interface_Gc_Ui[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, Interface_Gc_Ui[playerid][3], 1);
	PlayerTextDrawColor(playerid, Interface_Gc_Ui[playerid][3], -16776961);
	PlayerTextDrawBackgroundColor(playerid, Interface_Gc_Ui[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, Interface_Gc_Ui[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, Interface_Gc_Ui[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, Interface_Gc_Ui[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, Interface_Gc_Ui[playerid][3], 1);

	Interface_Gc_Ui[playerid][4] = CreatePlayerTextDraw(playerid, 152.000000, 157.000000, "TextDraw");
	PlayerTextDrawFont(playerid, Interface_Gc_Ui[playerid][4], 5);
	PlayerTextDrawLetterSize(playerid, Interface_Gc_Ui[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Interface_Gc_Ui[playerid][4], 59.000000, 69.500000);
	PlayerTextDrawSetOutline(playerid, Interface_Gc_Ui[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, Interface_Gc_Ui[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, Interface_Gc_Ui[playerid][4], 1);
	PlayerTextDrawColor(playerid, Interface_Gc_Ui[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, Interface_Gc_Ui[playerid][4], 1296911871);
	PlayerTextDrawBoxColor(playerid, Interface_Gc_Ui[playerid][4], 0);
	PlayerTextDrawUseBox(playerid, Interface_Gc_Ui[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, Interface_Gc_Ui[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, Interface_Gc_Ui[playerid][4], 0);
	PlayerTextDrawSetPreviewModel(playerid, Interface_Gc_Ui[playerid][4], 18631);
	PlayerTextDrawSetPreviewRot(playerid, Interface_Gc_Ui[playerid][4], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, Interface_Gc_Ui[playerid][4], 1, 1);

	Interface_Gc_Ui[playerid][5] = CreatePlayerTextDraw(playerid, 215.000000, 157.000000, "TextDraw");
	PlayerTextDrawFont(playerid, Interface_Gc_Ui[playerid][5], 5);
	PlayerTextDrawLetterSize(playerid, Interface_Gc_Ui[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Interface_Gc_Ui[playerid][5], 59.000000, 69.500000);
	PlayerTextDrawSetOutline(playerid, Interface_Gc_Ui[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, Interface_Gc_Ui[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, Interface_Gc_Ui[playerid][5], 1);
	PlayerTextDrawColor(playerid, Interface_Gc_Ui[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, Interface_Gc_Ui[playerid][5], 1296911871);
	PlayerTextDrawBoxColor(playerid, Interface_Gc_Ui[playerid][5], 0);
	PlayerTextDrawUseBox(playerid, Interface_Gc_Ui[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, Interface_Gc_Ui[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, Interface_Gc_Ui[playerid][5], 0);
	PlayerTextDrawSetPreviewModel(playerid, Interface_Gc_Ui[playerid][5], 18631);
	PlayerTextDrawSetPreviewRot(playerid, Interface_Gc_Ui[playerid][5], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, Interface_Gc_Ui[playerid][5], 1, 1);

	Interface_Gc_Ui[playerid][6] = CreatePlayerTextDraw(playerid, 278.000000, 157.000000, "TextDraw");
	PlayerTextDrawFont(playerid, Interface_Gc_Ui[playerid][6], 5);
	PlayerTextDrawLetterSize(playerid, Interface_Gc_Ui[playerid][6], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Interface_Gc_Ui[playerid][6], 59.000000, 69.500000);
	PlayerTextDrawSetOutline(playerid, Interface_Gc_Ui[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, Interface_Gc_Ui[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, Interface_Gc_Ui[playerid][6], 1);
	PlayerTextDrawColor(playerid, Interface_Gc_Ui[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, Interface_Gc_Ui[playerid][6], 1296911871);
	PlayerTextDrawBoxColor(playerid, Interface_Gc_Ui[playerid][6], 0);
	PlayerTextDrawUseBox(playerid, Interface_Gc_Ui[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, Interface_Gc_Ui[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, Interface_Gc_Ui[playerid][6], 0);
	PlayerTextDrawSetPreviewModel(playerid, Interface_Gc_Ui[playerid][6], 18631);
	PlayerTextDrawSetPreviewRot(playerid, Interface_Gc_Ui[playerid][6], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, Interface_Gc_Ui[playerid][6], 1, 1);

	Interface_Gc_Ui[playerid][7] = CreatePlayerTextDraw(playerid, 341.000000, 157.000000, "TextDraw");
	PlayerTextDrawFont(playerid, Interface_Gc_Ui[playerid][7], 5);
	PlayerTextDrawLetterSize(playerid, Interface_Gc_Ui[playerid][7], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Interface_Gc_Ui[playerid][7], 59.000000, 69.500000);
	PlayerTextDrawSetOutline(playerid, Interface_Gc_Ui[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, Interface_Gc_Ui[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, Interface_Gc_Ui[playerid][7], 1);
	PlayerTextDrawColor(playerid, Interface_Gc_Ui[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, Interface_Gc_Ui[playerid][7], 1296911871);
	PlayerTextDrawBoxColor(playerid, Interface_Gc_Ui[playerid][7], 0);
	PlayerTextDrawUseBox(playerid, Interface_Gc_Ui[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, Interface_Gc_Ui[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, Interface_Gc_Ui[playerid][7], 0);
	PlayerTextDrawSetPreviewModel(playerid, Interface_Gc_Ui[playerid][7], 18631);
	PlayerTextDrawSetPreviewRot(playerid, Interface_Gc_Ui[playerid][7], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, Interface_Gc_Ui[playerid][7], 1, 1);

	Interface_Gc_Ui[playerid][8] = CreatePlayerTextDraw(playerid, 404.000000, 157.000000, "TextDraw");
	PlayerTextDrawFont(playerid, Interface_Gc_Ui[playerid][8], 5);
	PlayerTextDrawLetterSize(playerid, Interface_Gc_Ui[playerid][8], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Interface_Gc_Ui[playerid][8], 59.000000, 69.500000);
	PlayerTextDrawSetOutline(playerid, Interface_Gc_Ui[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, Interface_Gc_Ui[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, Interface_Gc_Ui[playerid][8], 1);
	PlayerTextDrawColor(playerid, Interface_Gc_Ui[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, Interface_Gc_Ui[playerid][8], 1296911871);
	PlayerTextDrawBoxColor(playerid, Interface_Gc_Ui[playerid][8], 0);
	PlayerTextDrawUseBox(playerid, Interface_Gc_Ui[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, Interface_Gc_Ui[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, Interface_Gc_Ui[playerid][8], 0);
	PlayerTextDrawSetPreviewModel(playerid, Interface_Gc_Ui[playerid][8], 18631);
	PlayerTextDrawSetPreviewRot(playerid, Interface_Gc_Ui[playerid][8], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, Interface_Gc_Ui[playerid][8], 1, 1);

	Interface_Gc_Ui[playerid][9] = CreatePlayerTextDraw(playerid, 251.000000, 234.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, Interface_Gc_Ui[playerid][9], 4);
	PlayerTextDrawLetterSize(playerid, Interface_Gc_Ui[playerid][9], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Interface_Gc_Ui[playerid][9], 30.500000, 36.500000);
	PlayerTextDrawSetOutline(playerid, Interface_Gc_Ui[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, Interface_Gc_Ui[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, Interface_Gc_Ui[playerid][9], 1);
	PlayerTextDrawColor(playerid, Interface_Gc_Ui[playerid][9], -54867713);
	PlayerTextDrawBackgroundColor(playerid, Interface_Gc_Ui[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, Interface_Gc_Ui[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, Interface_Gc_Ui[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, Interface_Gc_Ui[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, Interface_Gc_Ui[playerid][9], 0);

	Interface_Gc_Ui[playerid][10] = CreatePlayerTextDraw(playerid, 336.000000, 234.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, Interface_Gc_Ui[playerid][10], 4);
	PlayerTextDrawLetterSize(playerid, Interface_Gc_Ui[playerid][10], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Interface_Gc_Ui[playerid][10], 30.500000, 36.500000);
	PlayerTextDrawSetOutline(playerid, Interface_Gc_Ui[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, Interface_Gc_Ui[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, Interface_Gc_Ui[playerid][10], 1);
	PlayerTextDrawColor(playerid, Interface_Gc_Ui[playerid][10], -54867713);
	PlayerTextDrawBackgroundColor(playerid, Interface_Gc_Ui[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, Interface_Gc_Ui[playerid][10], 50);
	PlayerTextDrawUseBox(playerid, Interface_Gc_Ui[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, Interface_Gc_Ui[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, Interface_Gc_Ui[playerid][10], 0);

	Interface_Gc_Ui[playerid][11] = CreatePlayerTextDraw(playerid, 308.000000, 242.000000, "_");
	PlayerTextDrawFont(playerid, Interface_Gc_Ui[playerid][11], 1);
	PlayerTextDrawLetterSize(playerid, Interface_Gc_Ui[playerid][11], 0.600000, 2.300002);
	PlayerTextDrawTextSize(playerid, Interface_Gc_Ui[playerid][11], 298.500000, 82.000000);
	PlayerTextDrawSetOutline(playerid, Interface_Gc_Ui[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, Interface_Gc_Ui[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, Interface_Gc_Ui[playerid][11], 2);
	PlayerTextDrawColor(playerid, Interface_Gc_Ui[playerid][11], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, Interface_Gc_Ui[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, Interface_Gc_Ui[playerid][11], -54867713);
	PlayerTextDrawUseBox(playerid, Interface_Gc_Ui[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, Interface_Gc_Ui[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, Interface_Gc_Ui[playerid][11], 0);

	Interface_Gc_Ui[playerid][12] = CreatePlayerTextDraw(playerid, 292.000000, 242.000000, "Open");
	PlayerTextDrawFont(playerid, Interface_Gc_Ui[playerid][12], 3);
	PlayerTextDrawLetterSize(playerid, Interface_Gc_Ui[playerid][12], 0.420833, 2.049999);
	PlayerTextDrawTextSize(playerid, Interface_Gc_Ui[playerid][12], 350.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Interface_Gc_Ui[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, Interface_Gc_Ui[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, Interface_Gc_Ui[playerid][12], 1);
	PlayerTextDrawColor(playerid, Interface_Gc_Ui[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, Interface_Gc_Ui[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, Interface_Gc_Ui[playerid][12], 50);
	PlayerTextDrawUseBox(playerid, Interface_Gc_Ui[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, Interface_Gc_Ui[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, Interface_Gc_Ui[playerid][12], 1);
	return 1;
}

Brian_UseInterface_Gc(playerid,bool:Open) {
    if(Open) {
        Brian_GachapongCreateUi(playerid);

        for(new i = 0; i != 13; i ++) {
            PlayerTextDrawShow(playerid, Interface_Gc_Ui[playerid][i]);
        }

        gachapong_opened[playerid] = 1;
        SelectTextDraw(playerid, 0xFF6600FF);
    }
    else {
        for(new i = 0; i != 13; i ++) {
            PlayerTextDrawHide(playerid, Interface_Gc_Ui[playerid][i]);
            PlayerTextDrawDestroy(playerid, Interface_Gc_Ui[playerid][i]);
        }

        gachapong_opened[playerid] = 0;
    }
    return 1;
}
