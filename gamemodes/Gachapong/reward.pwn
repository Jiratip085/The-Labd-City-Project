#include	<YSI_Coding\y_hooks>

Brian_GachapongGiveItem(playerid,ItemID)
{
    switch(ItemID)
	{
        case 3930:
		{
			Inventory_Add(playerid, "�������䷵�", 10);
			SendClientMessage(playerid, COLOR_YELLOW, "Gachapong | �س���Ѻ '�������䷵�' + 10 �ҡ����Դ�Ҫһͧ!");
		}
        case 2060:
		{
			Inventory_Add(playerid, "�ٹ", 10);
			SendClientMessage(playerid, COLOR_YELLOW, "Gachapong | �س���Ѻ '�ٹ' + 10 �ҡ����Դ�Ҫһͧ!");
		}
        case 1212:
		{
			GivePlayerMoneyEx(playerid, 5000);
			SendClientMessage(playerid, COLOR_YELLOW, "Gachapong | �س���Ѻ '�Թʴ' + $5,000 �ҡ����Դ�Ҫһͧ!");
		}
        case 541:
		{
		    new query[256];
			mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[playerid][pID], GetPlayerNameEx(playerid), 541, 0, 100.0);
			mysql_tquery(g_SQL, query);
			
			SendClientMessage(playerid, COLOR_YELLOW, "Gachapong | �س���Ѻ 'Bullet' ���� ������ҧ����˭����º��������! ��㨴���");
		}
    }
	Brian_UseInterface_Gc(playerid,false);
	CancelSelectTextDraw(playerid);
    return 1;
}

