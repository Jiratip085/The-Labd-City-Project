#include	<YSI_Coding\y_hooks>

ShowSealerShop(playerid)
{
    new str[128];

    format(str, sizeof(str), "Convenience Store"); // ������ҹ
    PlayerTextDrawSetString(playerid, ShopTD[playerid][2], str);

    if(ShopItemPage[playerid] == 0) //˹�ҷ�� 1
    {
        PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 19942); // Model item 1 
        format(str, sizeof(str), "Radio"); // ���� item 1 
        PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

        PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 367); // Model item 2 
        format(str, sizeof(str), "Camera"); // ���� item 2
        PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

        PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 365); // Model item 3
        format(str, sizeof(str), "Pepper Spray"); // ���� item 2
        PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

        format(str, sizeof(str), "1 / 2"); // ˹�� page
        PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);

    }
    if(ShopItemPage[playerid] == 1) //˹�ҷ�� 2
    {
        PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 968); // Model item 1
        format(str, sizeof(str), "Rope"); // ���� item 1
        PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

        PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 18868); // Model item 2
        format(str, sizeof(str), "iFruit"); // ���� item 2
        PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

        PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 19039); // Model item 3
        format(str, sizeof(str), "Watch"); // ���� item 2
        PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

        format(str, sizeof(str), "2 / 2"); // ˹�� page
        PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);

    }
    return 1;
}
