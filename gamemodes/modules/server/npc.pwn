#include <YSI\y_hooks>

new buyfoodspm[MAX_PLAYERS];

new NPCSellFood[1];
new NPCSellWater[1];

new NpcT1 = 0;
new NpcW1 = 0;



hook OnGameModeInit()
{
    NPCSellFood[0] = CreateActor(209,-149.6913,1121.4927,19.7422,271.1411); //NPC ขาย berger จุดเกิด

	NPCSellWater[0] = CreateActor(194,-149.5962,1116.9136,19.7422,272.6034); //NPC ขาย Water จุดเกิด

	CreateDynamic3DTextLabel("{FFFFFF}กด {FFFF00}Y {FFFFFF}เพื่อซื้อ {FFA84D}Berger\n {FFFFFF}$200", COLOR_GREEN, -147.6295,1121.5613,19.7422, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
	CreateDynamic3DTextLabel("{FFFFFF}กด {FFFF00}Y {FFFFFF}เพื่อซื้อ {FFA84D}Water\n {FFFFFF}$150", COLOR_GREEN, -147.9550,1117.0073,19.7500, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{   
        if(IsPlayerInRangeOfPoint(playerid, 1.0, -147.6295,1121.5613,19.7422)) //NPC ขาย berger จุดเกิด
        {
			if(NpcT1 == 1)
				return 1;

			if(GetPlayerMoney(playerid) < 200)
				return SendClientMessage(playerid, COLOR_RED,"- คุณมีเงินไม่เพียงพอ !");

			if(buyfoodspm[playerid] == 1)
				return 1;

			ApplyAnimation(playerid, "DEALER","shop_pay", 4.1, 0, 1, 1, 1, 1, 0);
			ApplyAnimation(playerid, "DEALER","null", 4.1, 0, 1, 1, 1, 1, 0);
			ApplyAnimation(playerid, "DEALER","shop_pay", 4.1, 0, 1, 1, 1, 1, 0);

			ApplyActorAnimation(NPCSellFood[0], "BAR","Barserve_bottle", 4.1, 0, 0, 0, 0, 0);
			ApplyActorAnimation(NPCSellFood[0], "BAR","null", 4.1, 0, 0, 0, 0, 0);
			ApplyActorAnimation(NPCSellFood[0], "BAR","Barserve_bottle", 4.1, 0, 0, 0, 0, 0);

			GivePlayerMoneyEx(playerid, -200);
			buyfoodspm[playerid] = 1;
			NpcT1 = 1;
			
            SetTimerEx("NPCPlayerSellBerger", 4000, 0, "id", playerid, 0);
            return 1;
		}
        if(IsPlayerInRangeOfPoint(playerid, 1.0, -147.9550,1117.0073,19.7500)) //NPC ขาย Water จุดเกิด
        {
			if(NpcW1 == 1)
				return 1;
			if(GetPlayerMoney(playerid) < 150)
				return SendClientMessage(playerid, COLOR_RED,"- คุณมีเงินไม่เพียงพอ !");

			if(buyfoodspm[playerid] == 1)
				return 1;

			ApplyAnimation(playerid, "DEALER","shop_pay", 4.1, 0, 1, 1, 1, 1, 0);
			ApplyAnimation(playerid, "DEALER","null", 4.1, 0, 1, 1, 1, 1, 0);
			ApplyAnimation(playerid, "DEALER","shop_pay", 4.1, 0, 1, 1, 1, 1, 0);

			ApplyActorAnimation(NPCSellWater[0], "BAR","Barserve_bottle", 4.1, 0, 0, 0, 0, 0);
			ApplyActorAnimation(NPCSellWater[0], "BAR","null", 4.1, 0, 0, 0, 0, 0);
			ApplyActorAnimation(NPCSellWater[0], "BAR","Barserve_bottle", 4.1, 0, 0, 0, 0, 0);

			GivePlayerMoneyEx(playerid, -150);
			buyfoodspm[playerid] = 1;
			NpcW1 = 1;
			
            SetTimerEx("NPCPlayerSellOrangejuicer", 4000, 0, "id", playerid, 0);
            return 1;
		}
    }
    return 1;
}
forward NPCPlayerSellOrangejuicer(playerid, type);
public NPCPlayerSellOrangejuicer(playerid, type)
{
    switch(type)
    {
        case 0:
        {
			ApplyActorAnimation(NPCSellWater[0], "BAR","BARSERVE_GIVE", 4.1, 0, 0, 0, 0, 0);

			SetPlayerAttachedObject(playerid,0,19563,5,0.091999,0.040000,0.053999,3.099996,-168.499984,169.800064,0.596000,0.655000,0.626000);
			ApplyAnimation(playerid, "VENDING","VEND_Drink_P", 4.1, 0, 1, 1, 0, 0, 0);
			ApplyAnimation(playerid, "VENDING","null", 4.1, 0, 1, 1, 0, 0, 0);
			ApplyAnimation(playerid, "VENDING","VEND_Drink_P", 4.1, 0, 1, 1, 0, 0, 0);
			Character[playerid][Thirsty] += 50;
			NpcW1 = 0;
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ซื้อ Orange juicer และหยิบมันขึ้นมาดื่ม", ReturnName(playerid, 0));
			
			SetTimerEx("RemoveObject", 1000, 0, "id", playerid, 0);
			return 1;
		}
	}
	return 1;
}
forward NPCPlayerSellBerger(playerid, type);
public NPCPlayerSellBerger(playerid, type)
{
    switch(type)
    {
        case 0:
        {
			ApplyActorAnimation(NPCSellFood[0], "BAR","BARSERVE_GIVE", 4.1, 0, 0, 0, 0, 0);

			SetPlayerAttachedObject(playerid,0,2769,6,0.088000,0.043999,0.055000,-103.799789,-17.899642,73.400009,1.000000,1.000000,1.000000);
			ApplyAnimation(playerid, "FOOD","EAT_Burger", 4.1, 0, 1, 1, 0, 0, 0);
			ApplyAnimation(playerid, "FOOD","null", 4.1, 0, 1, 1, 0, 0, 0);
			ApplyAnimation(playerid, "FOOD","EAT_Burger", 4.1, 0, 1, 1, 0, 0, 0);
			Character[playerid][Hungry] += 50;
			NpcT1 = 0;
			
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ซื้อ Taco และหยิบมันขึ้นมากิน", ReturnName(playerid, 0));
			SetTimerEx("RemoveObject", 3000, 0, "id", playerid, 0);
			return 1;
		}
	}
	return 1;
}

forward RemoveObject(playerid, type);
public RemoveObject(playerid, type)
{
    switch(type)
    {
        case 0:
        {
			RemovePlayerAttachedObject(playerid, 0);
			buyfoodspm[playerid] = 0;
			
		}
	}
	return 1;
}