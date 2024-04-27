#include	<YSI_Coding\y_hooks>


new PlayerText:SelectTD[MAX_PLAYERS][6];

//pSelectTD[1] ===> Register
//pSelectTD[2] ===> Buy Cars

hook OnPlayerConnect(playerid)
{
    CreateSelectTD(playerid);
	return 1;
}
hook OnPlayerDisconnect(playerid)
{
    DestroySelectTD(playerid);
	return 1;
}
CreateSelectTD(playerid)
{
	SelectTD[playerid][0] = CreatePlayerTextDraw(playerid, 320.000000, 399.000000, "_");
	PlayerTextDrawFont(playerid, SelectTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, SelectTD[playerid][0], 0.600000, 2.700001);
	PlayerTextDrawTextSize(playerid, SelectTD[playerid][0], 298.500000, 166.500000);
	PlayerTextDrawSetOutline(playerid, SelectTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, SelectTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, SelectTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, SelectTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, SelectTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, SelectTD[playerid][0], 70);
	PlayerTextDrawUseBox(playerid, SelectTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, SelectTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, SelectTD[playerid][0], 0);

	SelectTD[playerid][1] = CreatePlayerTextDraw(playerid, 289.000000, 402.000000, "Select");
	PlayerTextDrawFont(playerid, SelectTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, SelectTD[playerid][1], 0.349999, 2.000000);
	PlayerTextDrawTextSize(playerid, SelectTD[playerid][1], 20.000000, 55.000000);
	PlayerTextDrawSetOutline(playerid, SelectTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, SelectTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, SelectTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, SelectTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, SelectTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, SelectTD[playerid][1], 9109604);
	PlayerTextDrawUseBox(playerid, SelectTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, SelectTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, SelectTD[playerid][1], 1);

	SelectTD[playerid][2] = CreatePlayerTextDraw(playerid, 351.000000, 402.000000, "Cancel");
	PlayerTextDrawFont(playerid, SelectTD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, SelectTD[playerid][2], 0.349999, 2.000000);
	PlayerTextDrawTextSize(playerid, SelectTD[playerid][2], 20.000000, 55.000000);
	PlayerTextDrawSetOutline(playerid, SelectTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, SelectTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, SelectTD[playerid][2], 2);
	PlayerTextDrawColor(playerid, SelectTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, SelectTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, SelectTD[playerid][2], -1962934172);
	PlayerTextDrawUseBox(playerid, SelectTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, SelectTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, SelectTD[playerid][2], 1);

	SelectTD[playerid][3] = CreatePlayerTextDraw(playerid, 247.000000, 402.000000, "<");
	PlayerTextDrawFont(playerid, SelectTD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, SelectTD[playerid][3], 0.349999, 2.000000);
	PlayerTextDrawTextSize(playerid, SelectTD[playerid][3], 20.000000, 16.000000);
	PlayerTextDrawSetOutline(playerid, SelectTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, SelectTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, SelectTD[playerid][3], 2);
	PlayerTextDrawColor(playerid, SelectTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, SelectTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, SelectTD[playerid][3], -1061109705);
	PlayerTextDrawUseBox(playerid, SelectTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, SelectTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, SelectTD[playerid][3], 1);

	SelectTD[playerid][4] = CreatePlayerTextDraw(playerid, 393.000000, 402.000000, ">");
	PlayerTextDrawFont(playerid, SelectTD[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, SelectTD[playerid][4], 0.349999, 2.000000);
	PlayerTextDrawTextSize(playerid, SelectTD[playerid][4], 20.000000, 16.000000);
	PlayerTextDrawSetOutline(playerid, SelectTD[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, SelectTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, SelectTD[playerid][4], 2);
	PlayerTextDrawColor(playerid, SelectTD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, SelectTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, SelectTD[playerid][4], -1061109705);
	PlayerTextDrawUseBox(playerid, SelectTD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, SelectTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, SelectTD[playerid][4], 1);

	SelectTD[playerid][5] = CreatePlayerTextDraw(playerid, 320.000000, 75.000000, "Select");
	PlayerTextDrawFont(playerid, SelectTD[playerid][5], 3);
	PlayerTextDrawLetterSize(playerid, SelectTD[playerid][5], 0.587499, 2.299999);
	PlayerTextDrawTextSize(playerid, SelectTD[playerid][5], 16.500000, 150.000000);
	PlayerTextDrawSetOutline(playerid, SelectTD[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, SelectTD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, SelectTD[playerid][5], 2);
	PlayerTextDrawColor(playerid, SelectTD[playerid][5], -168436481);
	PlayerTextDrawBackgroundColor(playerid, SelectTD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, SelectTD[playerid][5], 200);
	PlayerTextDrawUseBox(playerid, SelectTD[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, SelectTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, SelectTD[playerid][5], 0);

	return 1;
}

DestroySelectTD(playerid)
{
	PlayerTextDrawDestroy(playerid, SelectTD[playerid][0]);
	PlayerTextDrawDestroy(playerid, SelectTD[playerid][1]);
	PlayerTextDrawDestroy(playerid, SelectTD[playerid][2]);
	PlayerTextDrawDestroy(playerid, SelectTD[playerid][3]);
	PlayerTextDrawDestroy(playerid, SelectTD[playerid][4]);
	PlayerTextDrawDestroy(playerid, SelectTD[playerid][5]);
	return 1;
}
stock ShowMenuSelectTD(playerid)
{
    PlayerTextDrawShow(playerid, SelectTD[playerid][0]);
    PlayerTextDrawShow(playerid, SelectTD[playerid][1]);
    PlayerTextDrawShow(playerid, SelectTD[playerid][2]);
    PlayerTextDrawShow(playerid, SelectTD[playerid][3]);
    PlayerTextDrawShow(playerid, SelectTD[playerid][4]);
    PlayerTextDrawShow(playerid, SelectTD[playerid][5]);
    SelectTextDraw(playerid, COLOR_WHITE);
    return 1;
}
stock HideMenuSelectTD(playerid)
{
    PlayerTextDrawHide(playerid, SelectTD[playerid][0]);
    PlayerTextDrawHide(playerid, SelectTD[playerid][1]);
    PlayerTextDrawHide(playerid, SelectTD[playerid][2]);
    PlayerTextDrawHide(playerid, SelectTD[playerid][3]);
    PlayerTextDrawHide(playerid, SelectTD[playerid][4]);
    PlayerTextDrawHide(playerid, SelectTD[playerid][5]);
    CancelSelectTextDraw(playerid);
    return 1;
}
stock HideMenuSelectTDD(playerid)
{
    PlayerTextDrawHide(playerid, SelectTD[playerid][0]);
    PlayerTextDrawHide(playerid, SelectTD[playerid][1]);
    PlayerTextDrawHide(playerid, SelectTD[playerid][2]);
    PlayerTextDrawHide(playerid, SelectTD[playerid][3]);
    PlayerTextDrawHide(playerid, SelectTD[playerid][4]);
    CancelSelectTextDraw(playerid);
    return 1;
}