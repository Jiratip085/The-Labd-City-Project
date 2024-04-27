#include	<YSI_Coding\y_hooks>

Brian_GachapongGiveItem(playerid,ItemID)
{
    switch(ItemID)
	{
        case 3930:
		{
			Inventory_Add(playerid, "แร่เฮมาไทต์", 10);
			SendClientMessage(playerid, COLOR_YELLOW, "Gachapong | คุณได้รับ 'แร่เฮมาไทต์' + 10 จากการเปิดกาชาปอง!");
		}
        case 2060:
		{
			Inventory_Add(playerid, "ปูน", 10);
			SendClientMessage(playerid, COLOR_YELLOW, "Gachapong | คุณได้รับ 'ปูน' + 10 จากการเปิดกาชาปอง!");
		}
        case 1212:
		{
			GivePlayerMoneyEx(playerid, 5000);
			SendClientMessage(playerid, COLOR_YELLOW, "Gachapong | คุณได้รับ 'เงินสด' + $5,000 จากการเปิดกาชาปอง!");
		}
        case 541:
		{
		    new query[256];
			mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[playerid][pID], GetPlayerNameEx(playerid), 541, 0, 100.0);
			mysql_tquery(g_SQL, query);
			
			SendClientMessage(playerid, COLOR_YELLOW, "Gachapong | คุณได้รับ 'Bullet' ถาวร ซึ่งเป็นรางวัลใหญ่เรียบร้อยแล้ว! ดีใจด้วย");
		}
    }
	Brian_UseInterface_Gc(playerid,false);
	CancelSelectTextDraw(playerid);
    return 1;
}

