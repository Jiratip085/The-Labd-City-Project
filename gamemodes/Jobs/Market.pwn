#include	<YSI_Coding\y_hooks>


// --> �Ѵ�ѹ�Ѻ������
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

// --> �Ѵ�ѹ�Ѻ
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
			format(string, sizeof(string), "{FFFFFF}�ѹ�Ѻ\t{FFFFFF}���͵���Ф�\t{FFFFFF}�����\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "[�ѹ�Ѻ�����]", string, "�Դ","");
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
			format(string, sizeof(string), "{FFFFFF}�ѹ�Ѻ\t{FFFFFF}���͵���Ф�\t{FFFFFF}�Թᴧ\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "[�ѹ�Ѻ�Թᴧ]", string, "�Դ","");
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
			format(string, sizeof(string), "{FFFFFF}�ѹ�Ѻ\t{FFFFFF}���͵���Ф�\t{FFFFFF}�ӹǹ�Թ\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "[�ѹ�Ѻ�ӹǹ�Թ]", string, "�Դ","");
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
			format(string, sizeof(string), "{FFFFFF}�ѹ�Ѻ\t{FFFFFF}���͵���Ф�\t{FFFFFF}�ӹǹ�Թ\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "[�ѹ�Ѻ�ӹǹ�Թ㹸�Ҥ��]", string, "�Դ","");
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
			format(string, sizeof(string), "{FFFFFF}�ѹ�Ѻ\t{FFFFFF}���͵���Ф�\t{FFFFFF}�ӹǹ\n%s", string5);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "[�ѹ�Ѻ��������͹�Ź�]", string, "�Դ","");
		}

	}
	return 1;
}


				if(aGender[playerData[playerid][pGender]] == 2)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����Фâͧ�س���� '˭ԧ' ");


				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for (new i = 0; i != MAX_SKINSHOP; i ++) if (skinshopData[i][SkinshopExists])
				{
				    if(skinshopData[i][SkinshopType] == 1)
				    {
						format(string, sizeof(string), "%d\t�ʹ�: %d(�ըӹǹ: %d)\t%s\n", i, skinshopData[i][SkinshopModel], skinshopData[i][SkinshopTotal], FormatMoney(skinshopData[i][SkinshopPrice]));
						strcat(string2, string);
						format(var, sizeof(var), "SKINSHOPID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}



				if(playerData[playerid][pGender] == 2)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����Фâͧ�س���� '˭ԧ' ����ö�Դ����Ѻ�ش���س��ͧ������� ���Ѳ��...");
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for (new i = 0; i != MAX_SKINSHOP; i ++) if (skinshopData[i][SkinshopExists])
				{
				    if(skinshopData[i][SkinshopType] == 1)
				    {
						format(string, sizeof(string), "%d\t�ʹ�: %d(�ըӹǹ: %d)\t%s\n", i, skinshopData[i][SkinshopModel], skinshopData[i][SkinshopTotal], FormatMoney(skinshopData[i][SkinshopPrice]));
						strcat(string2, string);
						format(var, sizeof(var), "SKINSHOPID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö���Թ����� ���ͧ�ҡ��ѧ�Թ������㹸�áԨ������");
					return 1;
				}
				format(string, sizeof(string), "�ӴѺ\t��¡���Թ���\t�Ҥ�\n%s", string2);
				Dialog_Show(playerid, DIALOG_AGPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "SKIN SHOP", string, "����", "�Դ");
				return 1;
			}