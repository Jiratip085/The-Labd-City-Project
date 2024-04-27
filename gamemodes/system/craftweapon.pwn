#include	<YSI_Coding\y_hooks>


/*
PlayerLoadStats(playerid)
{
    new exp[64];
    format(exp, sizeof(exp), "LEVEL %d (%.0f%c)", playerData[playerid][pLevel], ExpToPecentage(playerid), '%');
    PlayerTextDrawSetString(playerid, tdexp[playerid], exp);
	SetPlayerProgressBarValue(playerid, barexp[playerid], ExpToPecentage(playerid));
    return 1;
}
*/
GivePlayerLevelCraft(playerid, amount)
{
	playerData[playerid][pLevel] += amount;
	//PlayerLoadStats(playerid);
    return 1;
}

GetPlayerLevelCraft(playerid)
{
	return playerData[playerid][pLevel];
}

SetPlayerLevelCraft(playerid, amount)
{
	playerData[playerid][pLevel] = amount;
	//PlayerLoadStats(playerid);
	return 1;
}

////////////////////////////////////////////////////////////////
GetPlayerRequiredExpcraft(playerid)
{
    new requiredexpcraft = playerData[playerid][pLevel] * 100;
	return requiredexpcraft;
}
GivePlayerExpcraft(playerid, amount)
{
	if (GetPlayerExpcraft(playerid) > GetPlayerRequiredExpcraft(playerid))
		return 0;

	playerData[playerid][pExp] += amount;

    return 1;
}

GetPlayerExpcraft(playerid)
{
	return playerData[playerid][pExp];
}

SetPlayerExpCraft(playerid, amount)
{
	playerData[playerid][pExp] = amount;
	//PlayerLoadStats(playerid);
	return 1;
}




hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	new str[1056],
		shopid = Shop_Nearest(playerid);


	if (playertextid == ShopTD[playerid][8]) // Buy
	{
		if(shopData[shopid][shopType] == 4) 
		{
			if(ShopItemPage[playerid] == 0)
			{
				if(playerData[playerid][pLevel] <= 1)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Craft Weapons]: คุณไม่สามารถคราฟอาวุธได้ เนื่องจากประสบการณ์ของคุณไม่เพียงพอ");
			
			}
		}
	}
	if (playertextid == ShopTD[playerid][3]) // Select item 1
	{ 
		if(shopData[shopid][shopType] == 4) //คราฟอาวุธ
		{
			if(ShopItemPage[playerid] == 0)
			{
				format(str, sizeof(str), "Pistol Ammo (Level: 1)"); //Ammo Pistol
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~$: 2,500 ~r~$: 100");
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 2061);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Iron: 25~n~WoodPacks: 25~n~GunPowder: 1"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 1)
			{
				format(str, sizeof(str), "Cane (Level: 2)"); //Cane
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~$: 10,000 ~r~$: 2,000");
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 326);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Iron: 100~n~WoodPacks: 100~n~GunPowder: 50"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 2)
			{
				format(str, sizeof(str), "Pool (Level: 5)"); //Pool
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~$: 75,000 ~r~$: 15,000");
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 338);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Iron: 500~n~WoodPacks: 500~n~GunPowder: 200"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}
	}
	if (playertextid == ShopTD[playerid][4]) // Select item 2
	{
		if(shopData[shopid][shopType] == 4) //คราฟอาวุธ
		{
			if(ShopItemPage[playerid] == 0) 
			{
				format(str, sizeof(str), "Rifle Ammo (Level: 1)"); //Rifle Ammo
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~$: 5,000 ~r~$: 200");
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 19832);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Iron: 50~n~WoodPacks: 50~n~GunPowder: 2"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 1)
			{
				format(str, sizeof(str), "Baseball (Level: 3)"); //Baseball
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~$: 25,000 ~r~$: 5,000");
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 336);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Iron: 250~n~WoodPacks: 250~n~GunPowder: 100"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 2)
			{
				format(str, sizeof(str), "Knife (Level: 6)"); //Knife
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~$: 100,000 ~r~$: 20,000");
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 335);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Iron: 750~n~WoodPacks: 750~n~GunPowder: 300"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}
	}
	if (playertextid == ShopTD[playerid][5]) // Select item 3
	{
		if(shopData[shopid][shopType] == 4) //คราฟอาวุธ
		{
			if(ShopItemPage[playerid] == 0) //Desert Eagle
			{
				format(str, sizeof(str), "Desert Eagle (Level: 8)"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~$: 100,000 ~r~$: 10,000");
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 348);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Metal: 100~n~GunPowder: 100~n~Component: 100"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 1)
			{
				format(str, sizeof(str), "Golf (Level: 4)"); //Golf
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~$: 50,000 ~r~$: 10,000");
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 333);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Iron: 400~n~WoodPacks: 400~n~GunPowder: 150"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
			if(ShopItemPage[playerid] == 2)
			{
				format(str, sizeof(str), "Katana (Level: 7)"); //Katana
				PlayerTextDrawSetString(playerid, ShopTD[playerid][15], str);

				format(str, sizeof(str), "~g~$: 150,000 ~r~$: 30,000");
				PlayerTextDrawSetString(playerid, ShopTD[playerid][6], str);

				PlayerTextDrawSetPreviewModel(playerid, ShopTD[playerid][12], 339);
				PlayerTextDrawShow(playerid, ShopTD[playerid][12]);
				format(str, sizeof(str), "Iron: 1,000~n~WoodPacks: 1,000~n~GunPowder: 400"); 
				PlayerTextDrawSetString(playerid, ShopTD[playerid][16], str);
			}
		}
	}
    return 1;
}





LevelCraftRank_GetName(playerid)
{
    new
		name[48] = "None";

 	if (playerData[playerid][pExp] == 0)
	    return name;

 	if (playerData[playerid][pExp] > 0)
	{
		format(playerData[playerid][pLevelName], 48, "'Beginner' (%d/%d รอบ)", playerData[playerid][pExp], GetPlayerRequiredExpcraft(playerid));
	}
 	if (playerData[playerid][pExp] >= GetPlayerRequiredExpcraft(playerid))
	{
		format(playerData[playerid][pLevelName], 48, "'Elementary' (%d/%d รอบ)", playerData[playerid][pExp], GetPlayerRequiredExpcraft(playerid));
	}
 	if (playerData[playerid][pExp] >= GetPlayerRequiredExpcraft(playerid))
	{
	    format(playerData[playerid][pLevelName], 48, "'Intermediate' (%d/%d รอบ)", playerData[playerid][pExp], GetPlayerRequiredExpcraft(playerid));
	}
 	if (playerData[playerid][pExp] >= GetPlayerRequiredExpcraft(playerid))
	{
	    format(playerData[playerid][pLevelName], 48, "'Pre-Intermediate' (%d/%d รอบ)", playerData[playerid][pExp], GetPlayerRequiredExpcraft(playerid));
	}
 	if (playerData[playerid][pExp] >= GetPlayerRequiredExpcraft(playerid))
	{
	    format(playerData[playerid][pLevelName], 48, "'Upper-Intermediate' (%d/Level Max)", playerData[playerid][pExp]);
	}
	format(name, 48, playerData[playerid][pLevelName]);
	return name;
}
