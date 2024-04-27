#include 	<YSI_Coding\y_hooks>

/*
  CODING เก่งตี้
  สามารถแก้ไขผ่าน Database ได้ไม่จำเป็น insert 
  ให้แก้ไขข้อความ Hello และรีเซิฟเวอร์ได้เลย 
  หรือในเกมแล้วแต่สะดวก 
*/

#define MAX_TEXT_LINE 100 // กำหนด TEXT ความยาวของตัวหนังสือ
#define MAX_BORAD_INDEX 10 // เพิ่ม index ของตัวแปรอยากทำใหม่ให้เพิ่มเอา
#define MAX_BOARD 10

enum Board_Data{
    BillBoard[MAX_BORAD_INDEX],
    TextBoard0[MAX_TEXT_LINE],
    TextBoard1[MAX_TEXT_LINE],
    TextBoard2[MAX_TEXT_LINE],
    TextBoard3[MAX_TEXT_LINE],
    TextBoard4[MAX_TEXT_LINE],
    TextBoard5[MAX_TEXT_LINE],
    TextBoard6[MAX_TEXT_LINE],
    TextBoard7[MAX_TEXT_LINE],
    TextBoard8[MAX_TEXT_LINE],
    TextBoard9[MAX_TEXT_LINE]
};
new BoardData[MAX_BOARD][Board_Data];

forward BOARD_Load();
public BOARD_Load()
{
    static
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_BOARD)
	{
        cache_get_value_name(i, "TextBoard0", BoardData[i][TextBoard0], MAX_TEXT_LINE);
        cache_get_value_name(i, "TextBoard1", BoardData[i][TextBoard1], MAX_TEXT_LINE);
        cache_get_value_name(i, "TextBoard2", BoardData[i][TextBoard2], MAX_TEXT_LINE);
        cache_get_value_name(i, "TextBoard3", BoardData[i][TextBoard3], MAX_TEXT_LINE);
        cache_get_value_name(i, "TextBoard4", BoardData[i][TextBoard4], MAX_TEXT_LINE);
        cache_get_value_name(i, "TextBoard5", BoardData[i][TextBoard5], MAX_TEXT_LINE);
        cache_get_value_name(i, "TextBoard6", BoardData[i][TextBoard6], MAX_TEXT_LINE);
        cache_get_value_name(i, "TextBoard7", BoardData[i][TextBoard7], MAX_TEXT_LINE);
        cache_get_value_name(i, "TextBoard8", BoardData[i][TextBoard8], MAX_TEXT_LINE);
        cache_get_value_name(i, "TextBoard9", BoardData[i][TextBoard9], MAX_TEXT_LINE);
        Board_Refresh(i);
    }
    printf("//========================================================//");
    printf("//                CODEING BY KENGTY Rakey!               //");
    printf("//==========       BillBoard Lodeing          ============//");
    printf("//========================================================//");
}

Board_Refresh(id)
{
    //=======================================================================================================================================================//
    new text1[MAX_TEXT_LINE],text2[MAX_TEXT_LINE],text3[MAX_TEXT_LINE],text4[MAX_TEXT_LINE],text5[MAX_TEXT_LINE],text6[MAX_TEXT_LINE],text7[MAX_TEXT_LINE],text8[MAX_TEXT_LINE],text9[MAX_TEXT_LINE],text10[MAX_TEXT_LINE];
    BoardData[id][BillBoard][0] = CreateDynamicObjectEx(4238,1538.5000000,-1609.8000488,26.0000000,0.0000000,0.0000000,300.0000000,500.000,500.000); //
	BoardData[id][BillBoard][1] = CreateDynamicObjectEx(7910,1415.3000488,-1719.9000244,33.7999992,0.0000000,0.0000000,137.5000000,500.000,500.000); //object(s bank 1)  37 ???????? ?? ??????
	BoardData[id][BillBoard][2] = CreateDynamicObjectEx(7910,1716.4000244,-782.2000122,73.5999985,0.0000000,0.0000000,346.2470703,500.000,500.000); //object(s daroga 4)
	BoardData[id][BillBoard][3] = CreateDynamicObjectEx(7910,1623.0999756,820.7000122,27.5000000,0.0000000,0.0000000,238.0000000,500.000,500.000); //object(s baza lcn)
	BoardData[id][BillBoard][4] = CreateDynamicObjectEx(4238,1786.5000000,1476.0000000,26.1000004,0.0000000,0.0000000,32.0000000,500.000,500.000); //object(b daroga)
	BoardData[id][BillBoard][5] = CreateDynamicObjectEx(4238,356.3999939,-1718.0999756,26.6000004,0.0000000,0.0000000,300.0000000,500.000,500.000); //object(b daroga)
	BoardData[id][BillBoard][6] = CreateDynamicObjectEx(7910,1497.0999756,-945.0000000,54.0999985,0.0000000,0.0000000,112.9980774,500.000,500.000); //object(s daroga)
	BoardData[id][BillBoard][7] = CreateDynamicObjectEx(7910,1716.6999512,-778.2999878,73.5999985,0.0000000,0.0000000,180.7500000,500.000,500.000); //object(s daroga 2)
	BoardData[id][BillBoard][8] = CreateDynamicObjectEx(7910,1777.5000000,888.0000000,29.8999996,0.0000000,0.0000000,127.7478027,500.000,500.000); //object(s chorraxa 2)
	BoardData[id][BillBoard][9] = CreateDynamicObjectEx(7910,1854.5999756,-1487.6999512,25.7999992,0.0000000,0.0000000,180.0000000,500.000,500.000); //object(s daroga 6*/
    //=========================================================//
    format(text1, sizeof(text1), BoardData[id][TextBoard0]);
    format(text1, sizeof(text1),"{FFFFFF}\n%s", text1);
   //=========================================================//
    format(text2, sizeof(text2), BoardData[id][TextBoard1]);
    format(text2, sizeof(text2),"{FFFFFF}\n%s", text2);
   //=========================================================//
    format(text3, sizeof(text3), BoardData[id][TextBoard2]);
    format(text3, sizeof(text3),"{FFFFFF}\n%s", text3);
   //=========================================================//
    format(text4, sizeof(text4), BoardData[id][TextBoard3]);
    format(text4, sizeof(text4),"{FFFFFF}\n%s", text4);
   //=========================================================//
    format(text5, sizeof(text5), BoardData[id][TextBoard4]);
    format(text5, sizeof(text5),"{FFFFFF}\n%s", text5);
   //=========================================================//
    format(text6, sizeof(text6), BoardData[id][TextBoard5]);
    format(text6, sizeof(text6),"{FFFFFF}\n%s", text6);
   //=========================================================//
    format(text7, sizeof(text7), BoardData[id][TextBoard6]);
    format(text7, sizeof(text7),"{FFFFFF}\n%s", text7);
   //=========================================================//
    format(text8, sizeof(text8), BoardData[id][TextBoard7]);
    format(text8, sizeof(text8),"{FFFFFF}\n%s", text8);
   //=========================================================//
    format(text9, sizeof(text9), BoardData[id][TextBoard8]);
    format(text9, sizeof(text9),"{FFFFFF}\n%s", text9);
   //=========================================================//  
    format(text10, sizeof(text10),BoardData[id][TextBoard9]);
    format(text10, sizeof(text10),"{FFFFFF}\n%s", text10);
    //==================================================================================================================//
	SetDynamicObjectMaterialText(BoardData[id][BillBoard][0],0, text1, 90, "Arial", 24, 0, -32256, -16777216, 1);
    SetDynamicObjectMaterialText(BoardData[id][BillBoard][1],0, text2, 90, "Arial", 24, 0, -32256, -16777216, 1);
    SetDynamicObjectMaterialText(BoardData[id][BillBoard][2],0, text3, 90, "Arial", 24, 0, -32256, -16777216, 1);
    SetDynamicObjectMaterialText(BoardData[id][BillBoard][3],0, text4, 90, "Arial", 24, 0, -32256, -16777216, 1);
    SetDynamicObjectMaterialText(BoardData[id][BillBoard][4],0, text5, 90, "Arial", 24, 0, -32256, -16777216, 1);
    SetDynamicObjectMaterialText(BoardData[id][BillBoard][5],0, text6, 90, "Arial", 24, 0, -32256, -16777216, 1);
    SetDynamicObjectMaterialText(BoardData[id][BillBoard][6],0, text7, 90, "Arial", 24, 0, -32256, -16777216, 1);
    SetDynamicObjectMaterialText(BoardData[id][BillBoard][7],0, text8, 90, "Arial", 24, 0, -32256, -16777216, 1);
    SetDynamicObjectMaterialText(BoardData[id][BillBoard][8],0, text9, 90, "Arial", 24, 0, -32256, -16777216, 1);
    SetDynamicObjectMaterialText(BoardData[id][BillBoard][9],0, text10, 90, "Arial", 24, 0, -32256, -16777216, 1);
    //==================================================================================================================//
}

CMD:boardcmds(playerid)
{
    if(playerData[playerid][pAdmin] < 3)
    return 1;

    SendClientMessage(playerid, COLOR_RED, "//=========[BillBoard]=============//");
    SendClientMessage(playerid, COLOR_RED, "/bb1 /bb2 /bb3 /bb4 /bb5");
    SendClientMessage(playerid, COLOR_RED, "//==================================//");
    return 1;
}

CMD:bb1(playerid,params[])
{
    new boardid, texting[MAX_TEXT_LINE], query[555];
    if(playerData[playerid][pAdmin] < 3)
    return 1;

    if(sscanf(params, "s[100]", texting)) 
    return SendClientMessageEx(playerid, COLOR_GRAD1, "/bb1  [ข้อความ]");
    
    format(BoardData[boardid][TextBoard0],MAX_TEXT_LINE ,"{FFFFFF}\n%s", texting);	
	SetDynamicObjectMaterialText(BoardData[boardid][BillBoard][0],0, BoardData[boardid][TextBoard0], 90, "Arial", 24, 0, -32256, -16777216, 1);
    mysql_format(g_SQL, query, sizeof query, "UPDATE `board` SET `TextBoard0` = '%e'", BoardData[boardid][TextBoard0]);
    mysql_tquery(g_SQL, query);
    return 1;
}


CMD:bb2(playerid,params[])
{
    new boardid, texting[MAX_TEXT_LINE], query[555];
    if(playerData[playerid][pAdmin] < 3)
    return 1;

    if(sscanf(params, "s[100]", texting)) 
    return SendClientMessageEx(playerid, COLOR_GRAD1, "/bb2  [ข้อความ]");
    
    format(BoardData[boardid][TextBoard1],MAX_TEXT_LINE ,"{FFFFFF}\n%s", texting);	
	SetDynamicObjectMaterialText(BoardData[boardid][BillBoard][1],0, BoardData[boardid][TextBoard1], 90, "Arial", 24, 0, -32256, -16777216, 1);
    mysql_format(g_SQL, query, sizeof query, "UPDATE `board` SET `TextBoard1` = '%e'", BoardData[boardid][TextBoard1]);
    mysql_tquery(g_SQL, query);
    return 1;
}

CMD:bb3(playerid,params[])
{
    new boardid, texting[MAX_TEXT_LINE], query[555];
    if(playerData[playerid][pAdmin] < 3)
    return 1;

    if(sscanf(params, "s[100]", texting)) 
    return SendClientMessageEx(playerid, COLOR_GRAD1, "/bb3  [ข้อความ]");
    
    format(BoardData[boardid][TextBoard2],MAX_TEXT_LINE ,"{FFFFFF}\n%s", texting);	
	SetDynamicObjectMaterialText(BoardData[boardid][BillBoard][2],0, BoardData[boardid][TextBoard2], 90, "Arial", 24, 0, -32256, -16777216, 1);
    mysql_format(g_SQL, query, sizeof query, "UPDATE `board` SET `TextBoard2` = '%e'", BoardData[boardid][TextBoard2]);
    mysql_tquery(g_SQL, query);
    return 1;
}

CMD:bb4(playerid,params[])
{
    new boardid, texting[MAX_TEXT_LINE], query[555];
    if(playerData[playerid][pAdmin] < 3)
    return 1;

    if(sscanf(params, "s[100]", texting)) 
    return SendClientMessageEx(playerid, COLOR_GRAD1, "/bb4  [ข้อความ]");
    
    format(BoardData[boardid][TextBoard3],MAX_TEXT_LINE ,"{FFFFFF}\n%s", texting);	
	SetDynamicObjectMaterialText(BoardData[boardid][BillBoard][3],0, BoardData[boardid][TextBoard3], 90, "Arial", 24, 0, -32256, -16777216, 1);
    mysql_format(g_SQL, query, sizeof query, "UPDATE `board` SET `TextBoard3` = '%e'", BoardData[boardid][TextBoard3]);
    mysql_tquery(g_SQL, query);
    return 1;
}

CMD:bb5(playerid,params[])
{
    new boardid, texting[MAX_TEXT_LINE], query[555];
    if(playerData[playerid][pAdmin] < 3)
    return 1;

    if(sscanf(params, "s[100]", texting)) 
    return SendClientMessageEx(playerid, COLOR_GRAD1, "/bb5  [ข้อความ]");
    
    format(BoardData[boardid][TextBoard4],MAX_TEXT_LINE ,"{FFFFFF}\n%s", texting);	
	SetDynamicObjectMaterialText(BoardData[boardid][BillBoard][4],0, BoardData[boardid][TextBoard4], 90, "Arial", 24, 0, -32256, -16777216, 1);
    mysql_format(g_SQL, query, sizeof query, "UPDATE `board` SET `TextBoard4` = '%e'", BoardData[boardid][TextBoard4]);
    mysql_tquery(g_SQL, query);
    return 1;
}

CMD:bb6(playerid,params[])
{
    new boardid, texting[MAX_TEXT_LINE], query[555];
    if(playerData[playerid][pAdmin] < 3)
    return 1;

    if(sscanf(params, "s[100]", texting))
    return SendClientMessageEx(playerid, COLOR_GRAD1, "/bb5  [ข้อความ]");

    format(BoardData[boardid][TextBoard4],MAX_TEXT_LINE ,"{FFFFFF}\n%s", texting);
	SetDynamicObjectMaterialText(BoardData[boardid][BillBoard][4],0, BoardData[boardid][TextBoard5], 90, "Arial", 24, 0, -32256, -16777216, 1);
    mysql_format(g_SQL, query, sizeof query, "UPDATE `board` SET `TextBoard4` = '%e'", BoardData[boardid][TextBoard4]);
    mysql_tquery(g_SQL, query);
    return 1;
}

CMD:bb7(playerid,params[])
{
    new boardid, texting[MAX_TEXT_LINE], query[555];
    if(playerData[playerid][pAdmin] < 3)
    return 1;

    if(sscanf(params, "s[100]", texting))
    return SendClientMessageEx(playerid, COLOR_GRAD1, "/bb5  [ข้อความ]");

    format(BoardData[boardid][TextBoard4],MAX_TEXT_LINE ,"{FFFFFF}\n%s", texting);
	SetDynamicObjectMaterialText(BoardData[boardid][BillBoard][4],0, BoardData[boardid][TextBoard6], 90, "Arial", 24, 0, -32256, -16777216, 1);
    mysql_format(g_SQL, query, sizeof query, "UPDATE `board` SET `TextBoard4` = '%e'", BoardData[boardid][TextBoard4]);
    mysql_tquery(g_SQL, query);
    return 1;
}

CMD:bb8(playerid,params[])
{
    new boardid, texting[MAX_TEXT_LINE], query[555];
    if(playerData[playerid][pAdmin] < 3)
    return 1;

    if(sscanf(params, "s[100]", texting))
    return SendClientMessageEx(playerid, COLOR_GRAD1, "/bb5  [ข้อความ]");

    format(BoardData[boardid][TextBoard4],MAX_TEXT_LINE ,"{FFFFFF}\n%s", texting);
	SetDynamicObjectMaterialText(BoardData[boardid][BillBoard][4],0, BoardData[boardid][TextBoard7], 90, "Arial", 24, 0, -32256, -16777216, 1);
    mysql_format(g_SQL, query, sizeof query, "UPDATE `board` SET `TextBoard4` = '%e'", BoardData[boardid][TextBoard4]);
    mysql_tquery(g_SQL, query);
    return 1;
}

CMD:bb9(playerid,params[])
{
    new boardid, texting[MAX_TEXT_LINE], query[555];
    if(playerData[playerid][pAdmin] < 3)
    return 1;

    if(sscanf(params, "s[100]", texting))
    return SendClientMessageEx(playerid, COLOR_GRAD1, "/bb5  [ข้อความ]");

    format(BoardData[boardid][TextBoard4],MAX_TEXT_LINE ,"{FFFFFF}\n%s", texting);
	SetDynamicObjectMaterialText(BoardData[boardid][BillBoard][4],0, BoardData[boardid][TextBoard8], 90, "Arial", 24, 0, -32256, -16777216, 1);
    mysql_format(g_SQL, query, sizeof query, "UPDATE `board` SET `TextBoard4` = '%e'", BoardData[boardid][TextBoard4]);
    mysql_tquery(g_SQL, query);
    return 1;
}

CMD:bb10(playerid,params[])
{
    new boardid, texting[MAX_TEXT_LINE], query[555];
    if(playerData[playerid][pAdmin] < 3)
    return 1;

    if(sscanf(params, "s[100]", texting))
    return SendClientMessageEx(playerid, COLOR_GRAD1, "/bb5  [ข้อความ]");

    format(BoardData[boardid][TextBoard4],MAX_TEXT_LINE ,"{FFFFFF}\n%s", texting);
	SetDynamicObjectMaterialText(BoardData[boardid][BillBoard][4],0, BoardData[boardid][TextBoard9], 90, "Arial", 24, 0, -32256, -16777216, 1);
    mysql_format(g_SQL, query, sizeof query, "UPDATE `board` SET `TextBoard4` = '%e'", BoardData[boardid][TextBoard4]);
    mysql_tquery(g_SQL, query);
    return 1;
}

