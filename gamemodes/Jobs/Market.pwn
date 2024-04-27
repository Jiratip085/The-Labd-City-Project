#include	<YSI_Coding\y_hooks>


// --> จัดอันดับผู้เล่น
Dialog:Market_Grade(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		        new query[128];
		     	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` ORDER BY `playerLevel` DESC LIMIT 10");
			    mysql_tquery(g_SQL, query, "TopRank", "ii", playerid, 1);
		    }
		    case 1:
		    {
		        new query[128];
		     	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` ORDER BY `playerRedMoney` DESC LIMIT 10");
			    mysql_tquery(g_SQL, query, "TopRank", "ii", playerid, 2);
		    }
		    case 2:
		    {
		        new query[128];
		     	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` ORDER BY `playerMoney` DESC LIMIT 10");
			    mysql_tquery(g_SQL, query, "TopRank", "ii", playerid, 3);
		    }
		    case 3:
		    {
		        new query[128];
		     	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` ORDER BY `playerBank` DESC LIMIT 10");
			    mysql_tquery(g_SQL, query, "TopRank", "ii", playerid, 4);
		    }
		    case 4:
		    {
		        new query[128];
		     	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` ORDER BY `playerHours` DESC LIMIT 10");
			    mysql_tquery(g_SQL, query, "TopRank", "ii", playerid, 5);
		    }

		}
	}
	return 1;
}

// --> จัดอันดับ
forward TopRank(playerid, threadid);
public TopRank(playerid, threadid)
{
    new string[1000], string5[1000];
    new name[25], rmoney;
    new rows = cache_num_rows();
    switch(threadid)
    {
		case 1:
		{
		    for(new i = 0; i < rows; i ++)
		    {
			    cache_get_value_name(i, "playerName", name, 25);
			    cache_get_value_name_int(i, "playerLevel", rmoney);

				format(string, sizeof(string), "{04A90D}(%d)\t{FFFFFF}%s\t{F6E008}%s\n", i+1, name, FormatNumber(rmoney));
				strcat(string5, string);
			}
			format(string, sizeof(string), "{FFFFFF}อันดับ\t{FFFFFF}ชื่อตัวละคร\t{FFFFFF}เลเวล\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "[อันดับเลเวล]", string, "ปิด","");
		}
		case 2:
		{
		    for(new i = 0; i < rows; i ++)
		    {
			    cache_get_value_name(i, "playerName", name, 25);
			    cache_get_value_name_int(i, "playerRedMoney", rmoney);

				format(string, sizeof(string), "{04A90D}(%d)\t{FFFFFF}%s\t{F6E008}%s\n", i+1, name, FormatNumber(rmoney));
				strcat(string5, string);
			}
			format(string, sizeof(string), "{FFFFFF}อันดับ\t{FFFFFF}ชื่อตัวละคร\t{FFFFFF}เงินแดง\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "[อันดับเงินแดง]", string, "ปิด","");
		}
		case 3:
		{
		    for(new i = 0; i < rows; i ++)
		    {
			    cache_get_value_name(i, "playerName", name, 25);
			    cache_get_value_name_int(i, "playerMoney", rmoney);

				format(string, sizeof(string), "{04A90D}(%d)\t{FFFFFF}%s\t{F6E008}%s\n", i+1, name, FormatNumber(rmoney));
				strcat(string5, string);
			}
			format(string, sizeof(string), "{FFFFFF}อันดับ\t{FFFFFF}ชื่อตัวละคร\t{FFFFFF}จำนวนเงิน\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "[อันดับจำนวนเงิน]", string, "ปิด","");
		}
		case 4:
		{
		    for(new i = 0; i < rows; i ++)
		    {
			    cache_get_value_name(i, "playerName", name, 25);
			    cache_get_value_name_int(i, "playerBank", rmoney);

				format(string, sizeof(string), "{04A90D}(%d)\t{FFFFFF}%s\t{F6E008}%s\n", i+1, name, FormatNumber(rmoney));
				strcat(string5, string);
			}
			format(string, sizeof(string), "{FFFFFF}อันดับ\t{FFFFFF}ชื่อตัวละคร\t{FFFFFF}จำนวนเงิน\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "[อันดับจำนวนเงินในธนาคาร]", string, "ปิด","");
		}
		case 5:
		{
		    for(new i = 0; i < rows; i ++)
		    {
			    cache_get_value_name(i, "playerName", name, 25);
			    cache_get_value_name_int(i, "playerHours", rmoney);

				format(string, sizeof(string), "{04A90D}(%d)\t{FFFFFF}%s\t{F6E008}%s\n", i+1, name, FormatNumber(rmoney));
				strcat(string5, string);
			}
			format(string, sizeof(string), "{FFFFFF}อันดับ\t{FFFFFF}ชื่อตัวละคร\t{FFFFFF}จำนวน\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "[อันดับชั่วโมงออนไลน์]", string, "ปิด","");
		}

	}
	return 1;
}


				if(aGender[playerData[playerid][pGender]] == 2)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ตัวละครของคุณเป็นเพศ 'หญิง' ");


				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for (new i = 0; i != MAX_SKINSHOP; i ++) if (skinshopData[i][SkinshopExists])
				{
				    if(skinshopData[i][SkinshopType] == 1)
				    {
						format(string, sizeof(string), "%d\tไอดี: %d(มีจำนวน: %d)\t%s\n", i, skinshopData[i][SkinshopModel], skinshopData[i][SkinshopTotal], FormatMoney(skinshopData[i][SkinshopPrice]));
						strcat(string2, string);
						format(var, sizeof(var), "SKINSHOPID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}



				if(playerData[playerid][pGender] == 2)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ตัวละครของคุณเป็นเพศ 'หญิง' สามารถติดต่อรับชุดที่คุณต้องการได้ที่ ผู้พัฒนา...");
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for (new i = 0; i != MAX_SKINSHOP; i ++) if (skinshopData[i][SkinshopExists])
				{
				    if(skinshopData[i][SkinshopType] == 1)
				    {
						format(string, sizeof(string), "%d\tไอดี: %d(มีจำนวน: %d)\t%s\n", i, skinshopData[i][SkinshopModel], skinshopData[i][SkinshopTotal], FormatMoney(skinshopData[i][SkinshopPrice]));
						strcat(string2, string);
						format(var, sizeof(var), "SKINSHOPID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถดำเนินการได้ เนื่องจากคลังสินค้าภายในธุรกิจนี้หมด");
					return 1;
				}
				format(string, sizeof(string), "ลำดับ\tรายการสินค้า\tราคา\n%s", string2);
				Dialog_Show(playerid, DIALOG_AGPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "SKIN SHOP", string, "ซื้อ", "ปิด");
				return 1;
			}