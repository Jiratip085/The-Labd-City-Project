#include	<YSI_Coding\y_hooks>

ShowSealerShop(playerid)
{
    new str[128];

    format(str, sizeof(str), "Convenience Store"); // ชื่อร้าน
    PlayerTextDrawSetString(playerid, ShopTD[playerid][2], str);

    if(ShopItemPage[playerid] == 0) //หน้าที่ 1
    {
        PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 19942); // Model item 1 
        format(str, sizeof(str), "Radio"); // ชื่อ item 1 
        PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

        PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 367); // Model item 2 
        format(str, sizeof(str), "Camera"); // ชื่อ item 2
        PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

        PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 365); // Model item 3
        format(str, sizeof(str), "Pepper Spray"); // ชื่อ item 2
        PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

        format(str, sizeof(str), "1 / 2"); // หน้า page
        PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);

    }
    if(ShopItemPage[playerid] == 1) //หน้าที่ 2
    {
        PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][10], 968); // Model item 1
        format(str, sizeof(str), "Rope"); // ชื่อ item 1
        PlayerTextDrawSetString(playerid, ShopTD[playerid][19], str);

        PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][9], 18868); // Model item 2
        format(str, sizeof(str), "iFruit"); // ชื่อ item 2
        PlayerTextDrawSetString(playerid, ShopTD[playerid][20], str);

        PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][11], 19039); // Model item 3
        format(str, sizeof(str), "Watch"); // ชื่อ item 2
        PlayerTextDrawSetString(playerid, ShopTD[playerid][21], str);

        format(str, sizeof(str), "2 / 2"); // หน้า page
        PlayerTextDrawSetString(playerid, ShopTD[playerid][7], str);

    }
    return 1;
}
