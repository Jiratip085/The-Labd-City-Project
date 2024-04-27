#include	<YSI_Coding\y_hooks>

#define NTABLE1 378.1715,-122.2264,1001.4922
#define NTABLE2	378.1715,-125.4046,1001.4922
#define NTABLE3	378.1699,-128.4687,1001.4922
#define NTABLE4	378.1716,-131.4947,1001.4922

#define POSTABLE1_1	380.0248,-121.3773,1002.0259
#define ANGTABLE1_1	180.8184
#define POSTABLE1_2	379.0375,-121.3711,1002.0259
#define ANGTABLE1_2	181.1083
#define POSTABLE1_3	380.2073,-123.1895,1001.9310
#define ANGTABLE1_3	354.0699
#define POSTABLE1_4	379.2819,-123.0403,1001.9310
#define ANGTABLE1_4	0.0233

#define POSTABLE2_1	380.0463,-124.5039,1001.9310
#define ANGTABLE2_1	177.3251
#define POSTABLE2_2	379.1240,-124.4780,1001.9310
#define ANGTABLE2_2	177.3251
#define POSTABLE2_3 380.1512,-126.2182,1001.9310
#define ANGTABLE2_3	358.1202
#define POSTABLE2_4	378.8937,-126.0965,1001.9310
#define ANGTABLE2_4	358.1202

#define POSTABLE3_1	379.9493,-127.7161,1001.9310
#define ANGTABLE3_1	178.5785
#define POSTABLE3_2	378.9901,-127.7296,1001.9310
#define ANGTABLE3_2	182.0252
#define POSTABLE3_3	380.1278,-129.3799,1001.9310
#define ANGTABLE3_3	358.5785
#define POSTABLE3_4	378.9283,-129.3798,1001.9310
#define ANGTABLE3_4	358.5785

#define POSTABLE4_1	380.0059,-130.6832,1001.9310
#define ANGTABLE4_1	177.0118
#define POSTABLE4_2	379.0063,-130.7694,1001.9310
#define ANGTABLE4_2	177.0118
#define POSTABLE4_3	380.2360,-132.4676,1002.0422
#define ANGTABLE4_3	356.0718
#define POSTABLE4_4	379.2849,-132.3236,1002.0422
#define ANGTABLE4_4	357.9518

//Carry Slot
#define CARRYSLOT 9
#define CARRY_NONE  0
#define CARRY_PIZZA 2

enum eoinfo
{
	IsOwn1,
	IsOwn2,
	IsOwn3,
	IsOwn4,
};
new EatInfo[5][eoinfo];

new TablePizza[MAX_PLAYERS];

new PSitPos[MAX_PLAYERS];
new PEatAt[MAX_PLAYERS];

new foodList[MAX_PLAYERS],
	CarrySome[MAX_PLAYERS],
	EatingPizza[MAX_PLAYERS],
	SitingPizza[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    foodList[playerid] = -1;

	PSitPos[playerid] = 0;
	PEatAt[playerid] = 0;

    ApplyAnimation(playerid, "(null)", "(null)", 4.0, 1, 0, 0, 0, 0);
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(EatingPizza[playerid] == 1)
	{
		EatingPizza[playerid] = 0;

		if(PEatAt[playerid] == 1) { EatInfo[PSitPos[playerid]][IsOwn1] = 0;  }
		else if(PEatAt[playerid] == 2) { EatInfo[PSitPos[playerid]][IsOwn2] = 0; }
		else if(PEatAt[playerid] == 3) { EatInfo[PSitPos[playerid]][IsOwn3] = 0; }
		else if(PEatAt[playerid] == 4) { EatInfo[PSitPos[playerid]][IsOwn4] = 0; }

		if(IsValidDynamicObject(TablePizza[playerid]))
		{
			DestroyDynamicObject(TablePizza[playerid]);
		}
		PSitPos[playerid] = 0;
		PEatAt[playerid] = 0;
	}
	if(SitingPizza[playerid] == 1)
	{
		SitingPizza[playerid]=0;

		if(PEatAt[playerid] == 1) { EatInfo[PSitPos[playerid]][IsOwn1] = 0; }
		else if(PEatAt[playerid] == 2) { EatInfo[PSitPos[playerid]][IsOwn2] = 0; }
		else if(PEatAt[playerid] == 3) { EatInfo[PSitPos[playerid]][IsOwn3] = 0; }
		else if(PEatAt[playerid] == 4) { EatInfo[PSitPos[playerid]][IsOwn4] = 0; }

		PSitPos[playerid] = 0;
		PEatAt[playerid] = 0;
	}
}

hook OnGameModeInit()
{
	CreateDynamicPickup(19133, 23, 375.8306,-118.8025,1001.4995);
	CreateDynamic3DTextLabel("{FC4A1A}[ ร้านอาหาร ]\n{FFFFFF}กดปุ่ม N", 0xFF6600ff, 375.8306,-118.8025,1001.4995, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 20.0);

	CreateDynamic3DTextLabel("{FE6B4A}[โต๊ะอาหาร]\n{ffffff}กดปุ่ม N เพื่อนั่งทานอาหาร", COLOR_YELLOW, NTABLE1, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 5.0);
	CreateDynamic3DTextLabel("{FE6B4A}[โต๊ะอาหาร]\n{ffffff}กดปุ่ม N เพื่อนั่งทานอาหาร", COLOR_YELLOW, NTABLE2, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 5.0);
	CreateDynamic3DTextLabel("{FE6B4A}[โต๊ะอาหาร]\n{ffffff}กดปุ่ม N เพื่อนั่งทานอาหาร", COLOR_YELLOW, NTABLE3, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 5.0);
	CreateDynamic3DTextLabel("{FE6B4A}[โต๊ะอาหาร]\n{ffffff}กดปุ่ม N เพื่อนั่งทานอาหาร", COLOR_YELLOW, NTABLE4, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 5.0);
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new szLargeString[256];
	if (newkeys & KEY_NO && !IsPlayerInAnyVehicle(playerid))
	{
	    if (IsPlayerInRangeOfPoint(playerid, 2.0, 375.8306,-118.8025,1001.4995))
	    {
	        Dialog_Show(playerid, DIALOG_FOOD_SELECT, DIALOG_STYLE_LIST, "{FE5B2F}[!] {ffffff}ร้านพิซซ่า", "{FAF600}+ {ffffff}พิซซ่าถาดเล็ก ($100)\n{FAF600}+ {ffffff}พิซซ่าถาดกลาง ($200)\n{FAF600}+ {ffffff}พิซซ่าถาดใหญ่ ($300)\n", "เลือก", "ออก");
	    }

		if (EatingPizza[playerid] == 1)
		{
			EatingPizza[playerid] = 0;

			if(PEatAt[playerid] == 1) { EatInfo[PSitPos[playerid]][IsOwn1] = 0; }
			else if(PEatAt[playerid] == 2) { EatInfo[PSitPos[playerid]][IsOwn2] = 0; }
			else if(PEatAt[playerid] == 3) { EatInfo[PSitPos[playerid]][IsOwn3] = 0; }
			else if(PEatAt[playerid] == 4) { EatInfo[PSitPos[playerid]][IsOwn4] = 0; }

	 		if(IsValidDynamicObject(TablePizza[playerid]))
			{
				DestroyDynamicObject(TablePizza[playerid]);
			}
			ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
			ClearAnimations(playerid);
		}

        if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			if(CarrySome[playerid] == CARRY_PIZZA)
			{
				if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE1))
				{
					new Sit1[32],Sit2[32],Sit3[32],Sit4[32];
					if(EatInfo[1][IsOwn1] == 1) {
					    Sit1 = "มีคนนั่งแล้ว";
					} else { Sit1 = "ว่าง"; }

					if(EatInfo[1][IsOwn2] == 1) {
					    Sit2 = "มีคนนั่งแล้ว";
					} else { Sit2 = "ว่าง"; }

					if(EatInfo[1][IsOwn3] == 1) {
					    Sit3 = "มีคนนั่งแล้ว";
					} else { Sit3 = "ว่าง"; }

					if(EatInfo[1][IsOwn4] == 1) {
					    Sit4 = "มีคนนั่งแล้ว";
					} else { Sit4 = "ว่าง"; }

					SetPVarInt(playerid, "SitPos", 1);
					format(szLargeString, sizeof(szLargeString), "ที่นั่งที่1: %s\nที่นั่งที่2: %s\nที่นั่งที่3: %s\nที่นั่งที่4: %s", Sit1, Sit2, Sit3, Sit4);
					Dialog_Show(playerid, DIALOG_CSIT, DIALOG_STYLE_LIST, "โต๊ะที่ 1", szLargeString, "เลือก","ออก");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE2))
				{
					new Sit1[32],Sit2[32],Sit3[32],Sit4[32];
					if(EatInfo[2][IsOwn1] == 1) {
					    Sit1 = "มีคนนั่งแล้ว";
					} else { Sit1 = "ว่าง"; }

					if(EatInfo[2][IsOwn2] == 1) {
					    Sit2 = "มีคนนั่งแล้ว";
					} else { Sit2 = "ว่าง"; }

					if(EatInfo[2][IsOwn3] == 1) {
					    Sit3 = "มีคนนั่งแล้ว";
					} else { Sit3 = "ว่าง"; }

					if(EatInfo[2][IsOwn4] == 1) {
					    Sit4 = "มีคนนั่งแล้ว";
					} else { Sit4 = "ว่าง"; }

					SetPVarInt(playerid, "SitPos", 2);
					format(szLargeString, sizeof(szLargeString), "ที่นั่งที่1: %s\nที่นั่งที่2: %s\nที่นั่งที่3: %s\nที่นั่งที่4: %s", Sit1, Sit2, Sit3, Sit4);
					Dialog_Show(playerid, DIALOG_CSIT, DIALOG_STYLE_LIST, "โต๊ะที่ 2", szLargeString, "เลือก","ออก");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE3))
				{
					new Sit1[32],Sit2[32],Sit3[32],Sit4[32];
					if(EatInfo[3][IsOwn1] == 1) {
					    Sit1 = "มีคนนั่งแล้ว";
					} else { Sit1 = "ว่าง"; }

					if(EatInfo[3][IsOwn2] == 1) {
					    Sit2 = "มีคนนั่งแล้ว";
					} else { Sit2 = "ว่าง"; }

					if(EatInfo[3][IsOwn3] == 1) {
					    Sit3 = "มีคนนั่งแล้ว";
					} else { Sit3 = "ว่าง"; }

					if(EatInfo[3][IsOwn4] == 1) {
					    Sit4 = "มีคนนั่งแล้ว";
					} else { Sit4 = "ว่าง"; }

					SetPVarInt(playerid, "SitPos", 3);
					format(szLargeString, sizeof(szLargeString), "ที่นั่งที่1: %s\nที่นั่งที่2: %s\nที่นั่งที่3: %s\nที่นั่งที่4: %s", Sit1, Sit2, Sit3, Sit4);
					Dialog_Show(playerid, DIALOG_CSIT, DIALOG_STYLE_LIST, "โต๊ะที่ 3", szLargeString, "เลือก","ออก");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE4))
				{
					new Sit1[32],Sit2[32],Sit3[32],Sit4[32];
					if(EatInfo[4][IsOwn1] == 1) {
					    Sit1 = "มีคนนั่งแล้ว";
					} else { Sit1 = "ว่าง"; }

					if(EatInfo[4][IsOwn2] == 1) {
					    Sit2 = "มีคนนั่งแล้ว";
					} else { Sit2 = "ว่าง"; }

					if(EatInfo[4][IsOwn3] == 1) {
					    Sit3 = "มีคนนั่งแล้ว";
					} else { Sit3 = "ว่าง"; }

					if(EatInfo[4][IsOwn4] == 1) {
					    Sit4 = "มีคนนั่งแล้ว";
					} else { Sit4 = "ว่าง"; }

					SetPVarInt(playerid, "SitPos", 4);
					format(szLargeString, sizeof(szLargeString), "ที่นั่งที่1: %s\nที่นั่งที่2: %s\nที่นั่งที่3: %s\nที่นั่งที่4: %s", Sit1, Sit2, Sit3, Sit4);
					Dialog_Show(playerid, DIALOG_CSIT, DIALOG_STYLE_LIST, "โต๊ะที่ 4", szLargeString, "เลือก","ออก");
				}
			}
			else
			{
				if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE1))
				{
					new Sit1[32],Sit2[32],Sit3[32],Sit4[32];
					if(EatInfo[1][IsOwn1] == 1) {
					    Sit1 = "มีคนนั่งแล้ว";
					} else { Sit1 = "ว่าง"; }

					if(EatInfo[1][IsOwn2] == 1) {
					    Sit2 = "มีคนนั่งแล้ว";
					} else { Sit2 = "ว่าง"; }

					if(EatInfo[1][IsOwn3] == 1) {
					    Sit3 = "มีคนนั่งแล้ว";
					} else { Sit3 = "ว่าง"; }

					if(EatInfo[1][IsOwn4] == 1) {
					    Sit4 = "มีคนนั่งแล้ว";
					} else { Sit4 = "ว่าง"; }

					SetPVarInt(playerid, "SitPos", 1);
					format(szLargeString, sizeof(szLargeString), "ที่นั่งที่1: %s\nที่นั่งที่2: %s\nที่นั่งที่3: %s\nที่นั่งที่4: %s", Sit1, Sit2, Sit3, Sit4);
					Dialog_Show(playerid, DIALOG_CSIT2, DIALOG_STYLE_LIST, "โต๊ะที่ 1", szLargeString, "เลือก","ออก");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE2))
				{
					new Sit1[32],Sit2[32],Sit3[32],Sit4[32];
					if(EatInfo[2][IsOwn1] == 1) {
					    Sit1 = "มีคนนั่งแล้ว";
					} else { Sit1 = "ว่าง"; }

					if(EatInfo[2][IsOwn2] == 1) {
					    Sit2 = "มีคนนั่งแล้ว";
					} else { Sit2 = "ว่าง"; }

					if(EatInfo[2][IsOwn3] == 1) {
					    Sit3 = "มีคนนั่งแล้ว";
					} else { Sit3 = "ว่าง"; }

					if(EatInfo[2][IsOwn4] == 1) {
					    Sit4 = "มีคนนั่งแล้ว";
					} else { Sit4 = "ว่าง"; }

					SetPVarInt(playerid, "SitPos", 2);
					format(szLargeString, sizeof(szLargeString), "ที่นั่งที่1: %s\nที่นั่งที่2: %s\nที่นั่งที่3: %s\nที่นั่งที่4: %s", Sit1, Sit2, Sit3, Sit4);
					Dialog_Show(playerid, DIALOG_CSIT2, DIALOG_STYLE_LIST, "โต๊ะที่ 2", szLargeString, "เลือก","ออก");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE3))
				{
					new Sit1[32],Sit2[32],Sit3[32],Sit4[32];
					if(EatInfo[3][IsOwn1] == 1) {
					    Sit1 = "มีคนนั่งแล้ว";
					} else { Sit1 = "ว่าง"; }

					if(EatInfo[3][IsOwn2] == 1) {
					    Sit2 = "มีคนนั่งแล้ว";
					} else { Sit2 = "ว่าง"; }

					if(EatInfo[3][IsOwn3] == 1) {
					    Sit3 = "มีคนนั่งแล้ว";
					} else { Sit3 = "ว่าง"; }

					if(EatInfo[3][IsOwn4] == 1) {
					    Sit4 = "มีคนนั่งแล้ว";
					} else { Sit4 = "ว่าง"; }

					SetPVarInt(playerid, "SitPos", 3);
					format(szLargeString, sizeof(szLargeString), "ที่นั่งที่1: %s\nที่นั่งที่2: %s\nที่นั่งที่3: %s\nที่นั่งที่4: %s", Sit1, Sit2, Sit3, Sit4);
					Dialog_Show(playerid, DIALOG_CSIT2, DIALOG_STYLE_LIST, "โต๊ะที่ 3", szLargeString, "เลือก","ออก");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE4))
				{
					new Sit1[32],Sit2[32],Sit3[32],Sit4[32];
					if(EatInfo[4][IsOwn1] == 1) {
					    Sit1 = "มีคนนั่งแล้ว";
					} else { Sit1 = "ว่าง"; }

					if(EatInfo[4][IsOwn2] == 1) {
					    Sit2 = "มีคนนั่งแล้ว";
					} else { Sit2 = "ว่าง"; }

					if(EatInfo[4][IsOwn3] == 1) {
					    Sit3 = "มีคนนั่งแล้ว";
					} else { Sit3 = "ว่าง"; }

					if(EatInfo[4][IsOwn4] == 1) {
					    Sit4 = "มีคนนั่งแล้ว";
					} else { Sit4 = "ว่าง"; }

					SetPVarInt(playerid, "SitPos", 4);
					format(szLargeString, sizeof(szLargeString), "ที่นั่งที่1: %s\nที่นั่งที่2: %s\nที่นั่งที่3: %s\nที่นั่งที่4: %s", Sit1, Sit2, Sit3, Sit4);
					Dialog_Show(playerid, DIALOG_CSIT2, DIALOG_STYLE_LIST, "โต๊ะที่ 4", szLargeString, "เลือก","ออก");
				}
			}
		}
	}
	return 1;
}

Dialog:DIALOG_FOOD_SELECT(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
				if (GetPlayerMoneyEx(playerid) < 100)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "[!] คุณมีเงินสดไม่เพียงพอ! ($100)");

				if (playerData[playerid][pHungry] + 10.0 > 100.0)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "[!] คุณยังไม่หิว!");

				GivePlayerMoneyEx(playerid, -100);
				playerData[playerid][pHungry] += 10.0;

				SetPlayerAttachedObject(playerid, CARRYSLOT, 2219, 1, 0.077998, 0.407000, -0.300998 ,99.500030 ,125.099975 ,-36.800018 ,1.000000 ,1.000000 ,1.000000);
				SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
				CarrySome[playerid] = CARRY_PIZZA;

				SendClientMessage(playerid, -1, "{272626}|------------------------------------------------------------------------|");
				SendClientMessage(playerid, -1, "{F83406}คำแนะนำ : {FBC1B4}เดินไปที่โต๊ะอาหารแล้วกด 'N' เพื่อเลือกที่นั่งทานอาหาร");
				SendClientMessage(playerid, -1, "{81D4FA}ค่าความหิว + 10 {ffffff}จากการรับประทานอาหาร {F53812}พิซซ่าถาดเล็ก");
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s ได้หยิบถาดอาหารจากพนักงานร้านพิซซ่าแล้ว", GetPlayerNameEx(playerid));
				SendClientMessage(playerid, -1, "{272626}|------------------------------------------------------------------------|");
			}
		    case 1:
		    {
				if (GetPlayerMoneyEx(playerid) < 200)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "[!] คุณมีเงินสดไม่เพียงพอ! ($200)");

				if (playerData[playerid][pHungry] + 20.0 > 100.0)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "[!] คุณยังไม่หิว!");

				GivePlayerMoneyEx(playerid, -200);
				playerData[playerid][pHungry] += 20.0;

				SetPlayerAttachedObject(playerid, CARRYSLOT, 2219, 1, 0.077998, 0.407000, -0.300998 ,99.500030 ,125.099975 ,-36.800018 ,1.000000 ,1.000000 ,1.000000);
				SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
				CarrySome[playerid] = CARRY_PIZZA;

				SendClientMessage(playerid, -1, "{272626}|------------------------------------------------------------------------|");
				SendClientMessage(playerid, -1, "{F83406}คำแนะนำ : {FBC1B4}เดินไปที่โต๊ะอาหารแล้วกด 'N' เพื่อเลือกที่นั่งทานอาหาร");
				SendClientMessage(playerid, -1, "{81D4FA}ค่าความหิว + 20 {ffffff}จากการรับประทานอาหาร {F53812}พิซซ่าถาดกลาง");
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s ได้หยิบถาดอาหารจากพนักงานร้านพิซซ่าแล้ว", GetPlayerNameEx(playerid));
				SendClientMessage(playerid, -1, "{272626}|------------------------------------------------------------------------|");
			}
		    case 2:
		    {
				if (GetPlayerMoneyEx(playerid) < 300)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "[!] คุณมีเงินสดไม่เพียงพอ! ($300)");

				if (playerData[playerid][pHungry] + 30.0 > 100.0)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "[!] คุณยังไม่หิว!");

				GivePlayerMoneyEx(playerid, -300);
				playerData[playerid][pHungry] += 30.0;

				SetPlayerAttachedObject(playerid, CARRYSLOT, 2219, 1, 0.077998, 0.407000, -0.300998 ,99.500030 ,125.099975 ,-36.800018 ,1.000000 ,1.000000 ,1.000000);
				SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
				CarrySome[playerid] = CARRY_PIZZA;

				SendClientMessage(playerid, -1, "{272626}|------------------------------------------------------------------------|");
				SendClientMessage(playerid, -1, "{F83406}คำแนะนำ : {FBC1B4}เดินไปที่โต๊ะอาหารแล้วกด 'N' เพื่อเลือกที่นั่งทานอาหาร");
				SendClientMessage(playerid, -1, "{81D4FA}ค่าความหิว + 30 {ffffff}จากการรับประทานอาหาร {F53812}พิซซ่าถาดใหญ่");
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s ได้หยิบถาดอาหารจากพนักงานร้านพิซซ่าแล้ว", GetPlayerNameEx(playerid));
				SendClientMessage(playerid, -1, "{272626}|------------------------------------------------------------------------|");
			}
		}
	}
	return 1;
}

Dialog:DIALOG_CSIT(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (IsPlayerConnected(playerid))
	    {
			switch(listitem)
			{
		        case 0:
				{
				    new Table = GetPVarInt(playerid, "SitPos");
					if(EatInfo[Table][IsOwn1] == 1) return ErrorMsg(playerid, "ที่นั่งนี้มีคนนั่งแล้ว");
					EatInfo[Table][IsOwn1] = 1;
					/* YOUR CODE*/
					SetPVarInt(playerid, "EatAt", 1);

   					EatingPizza[playerid] = 1;
   					CarrySome[playerid]=CARRY_NONE;
					SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
					if(IsPlayerAttachedObjectSlotUsed(playerid,CARRYSLOT)) RemovePlayerAttachedObject(playerid,CARRYSLOT);

					if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE1))
					{
						SetPlayerPos(playerid, POSTABLE1_1);
						SetPlayerFacingAngle(playerid, ANGTABLE1_1);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat1", 3.0, 1, 0, 0, 0, 0);
						TablePizza[playerid] = CreateDynamicObject(2219,379.7999900,-122.0000000,1001.4000200,334.6030000,26.7600000,258.2030000); //object(pizzamed) (1)
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE2))
					{
						SetPlayerPos(playerid, POSTABLE2_1);
						SetPlayerFacingAngle(playerid, ANGTABLE2_1);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat1", 3.0, 1, 0, 0, 0, 0);
						TablePizza[playerid] = CreateDynamicObject(2219,379.7000100,-125.1000000,1001.4000200,334.6030000,26.7600000,258.2030000); //object(pizzamed) (1)
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE3))
					{
						SetPlayerPos(playerid, POSTABLE3_1);
						SetPlayerFacingAngle(playerid, ANGTABLE3_1);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat1", 3.0, 1, 0, 0, 0, 0);
						TablePizza[playerid] = CreateDynamicObject(2219,379.7000100,-128.1000100,1001.4000200,334.6030000,26.7600000,254.7030000); //object(pizzamed) (1)
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE4))
					{
						SetPlayerPos(playerid, POSTABLE4_1);
						SetPlayerFacingAngle(playerid, ANGTABLE4_1);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat1", 3.0, 1, 0, 0, 0, 0);
						TablePizza[playerid] = CreateDynamicObject(2219,379.7000100,-131.2000000,1001.4000200,334.6030000,26.7600000,254.7030000); //object(pizzamed) (1)
					}
				 	PSitPos[playerid] = GetPVarInt(playerid, "SitPos");
					PEatAt[playerid] = GetPVarInt(playerid, "EatAt");
					
					SendClientMessage(playerid, -1, "{F9603D}คำแนะนำ : {FDD3C9}กด 'N' เพื่อลุกจากที่นั่งและเลิกรับประทานอาหาร");
				}
		        case 1:
				{
				    new Table = GetPVarInt(playerid, "SitPos");
					if(EatInfo[Table][IsOwn2] == 1) return ErrorMsg(playerid, "ที่นั่งนี้มีคนนั่งแล้ว");
					EatInfo[Table][IsOwn2] = 1;
					/* YOUR CODE*/
					SetPVarInt(playerid, "EatAt", 2);

   					EatingPizza[playerid] = 1;
   					CarrySome[playerid]=CARRY_NONE;
					SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
					if(IsPlayerAttachedObjectSlotUsed(playerid,CARRYSLOT)) RemovePlayerAttachedObject(playerid,CARRYSLOT);

					if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE1))
					{
						SetPlayerPos(playerid, POSTABLE1_2);
						SetPlayerFacingAngle(playerid, ANGTABLE1_2);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat1", 3.0, 1, 0, 0, 0, 0);
						TablePizza[playerid] = CreateDynamicObject(2219,378.8999900,-122.0000000,1001.4000200,334.6000000,26.7570000,258.2010000); //object(pizzamed) (2)
					}
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE2))
					{
						SetPlayerPos(playerid, POSTABLE2_2);
						SetPlayerFacingAngle(playerid, ANGTABLE2_2);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat1", 3.0, 1, 0, 0, 0, 0);
						TablePizza[playerid] = CreateDynamicObject(2219,378.8999900,-125.1000000,1001.4000200,334.6000000,26.7570000,254.2010000); //object(pizzamed) (2)
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE3))
					{
						SetPlayerPos(playerid, POSTABLE3_2);
						SetPlayerFacingAngle(playerid, ANGTABLE3_2);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat1", 3.0, 1, 0, 0, 0, 0);
						TablePizza[playerid] = CreateDynamicObject(2219,378.8999900,-128.1000100,1001.4000200,334.6000000,26.7570000,254.2010000); //object(pizzamed) (2)
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE4))
					{
						SetPlayerPos(playerid, POSTABLE4_2);
						SetPlayerFacingAngle(playerid, ANGTABLE4_2);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat1", 3.0, 1, 0, 0, 0, 0);
						TablePizza[playerid] = CreateDynamicObject(2219,378.7999900,-131.2000000,1001.4000200,334.6000000,26.7570000,254.2010000); //object(pizzamed) (2)
					}

				 	PSitPos[playerid] = GetPVarInt(playerid, "SitPos");
					PEatAt[playerid] = GetPVarInt(playerid, "EatAt");

					SendClientMessage(playerid, -1, "{F9603D}คำแนะนำ : {FDD3C9}กด 'N' เพื่อลุกจากที่นั่งและเลิกรับประทานอาหาร");
				}
		        case 2:
				{
				    new Table = GetPVarInt(playerid, "SitPos");
					if(EatInfo[Table][IsOwn3] == 1) return ErrorMsg(playerid, "ที่นั่งนี้มีคนนั่งแล้ว");
					EatInfo[Table][IsOwn3] = 1;
					/* YOUR CODE*/
					SetPVarInt(playerid, "EatAt", 3);

   					EatingPizza[playerid] = 1;
   					CarrySome[playerid]=CARRY_NONE;
					SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
					if(IsPlayerAttachedObjectSlotUsed(playerid,CARRYSLOT)) RemovePlayerAttachedObject(playerid,CARRYSLOT);

					if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE1))
				    {
						SetPlayerPos(playerid, POSTABLE1_3);
						SetPlayerFacingAngle(playerid, ANGTABLE1_3);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat1", 3.0, 1, 0, 0, 0, 0);
						TablePizza[playerid] = CreateDynamicObject(2219,380.2999900,-122.6000000,1001.4000200,334.6000000,26.7570000,74.2010000); //object(pizzamed) (3)
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE2))
					{
						SetPlayerPos(playerid, POSTABLE2_3);
						SetPlayerFacingAngle(playerid, ANGTABLE2_3);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat1", 3.0, 1, 0, 0, 0, 0);
						TablePizza[playerid] = CreateDynamicObject(2219,380.2999900,-125.7000000,1001.4000200,334.6000000,26.7570000,74.2010000); //object(pizzamed) (3)
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE3))
					{
						SetPlayerPos(playerid, POSTABLE3_3);
						SetPlayerFacingAngle(playerid, ANGTABLE3_3);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat1", 3.0, 1, 0, 0, 0, 0);
						TablePizza[playerid] = CreateDynamicObject(2219,380.2000100,-128.8000000,1001.4000200,334.6000000,26.7570000,74.2010000); //object(pizzamed) (3)
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE4))
					{
						SetPlayerPos(playerid, POSTABLE4_3);
						SetPlayerFacingAngle(playerid, ANGTABLE4_3);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat1", 3.0, 1, 0, 0, 0, 0);
						TablePizza[playerid] = CreateDynamicObject(2219,380.1000100,-131.8999900,1001.4000200,334.6000000,26.7570000,74.2010000); //object(pizzamed) (3)
					}
				 	PSitPos[playerid] = GetPVarInt(playerid, "SitPos");
					PEatAt[playerid] = GetPVarInt(playerid, "EatAt");
					SetTimerEx("FixSitPizza",1500,false, "i", playerid);

					SendClientMessage(playerid, -1, "{F9603D}คำแนะนำ : {FDD3C9}กด 'N' เพื่อลุกจากที่นั่งและเลิกรับประทานอาหาร");
				}
		        case 3:
				{
				    new Table = GetPVarInt(playerid, "SitPos");
					if(EatInfo[Table][IsOwn4] == 1) return ErrorMsg(playerid, "ที่นั่งนี้มีคนนั่งแล้ว");
					EatInfo[Table][IsOwn4] = 1;
					/* YOUR CODE*/
					SetPVarInt(playerid, "EatAt", 4);

   					EatingPizza[playerid] = 1;
   					CarrySome[playerid]=CARRY_NONE;
					SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
					if(IsPlayerAttachedObjectSlotUsed(playerid,CARRYSLOT)) RemovePlayerAttachedObject(playerid,CARRYSLOT);

					if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE1))
				    {
						SetPlayerPos(playerid, POSTABLE1_4);
						SetPlayerFacingAngle(playerid, ANGTABLE1_4);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat1", 3.0, 1, 0, 0, 0, 0);
						TablePizza[playerid] = CreateDynamicObject(2219,379.5000000,-122.6000000,1001.4000200,334.6000000,26.7570000,74.1960000); //object(pizzamed) (4)
					}
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE2))
					{
						SetPlayerPos(playerid, POSTABLE2_4);
						SetPlayerFacingAngle(playerid, ANGTABLE2_4);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat1", 3.0, 1, 0, 0, 0, 0);
						TablePizza[playerid] = CreateDynamicObject(2219,379.3999900,-125.7000000,1001.4000200,334.6000000,26.7570000,74.1960000); //object(pizzamed) (4)
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE3))
					{
						SetPlayerPos(playerid, POSTABLE3_4);
						SetPlayerFacingAngle(playerid, ANGTABLE3_4);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat1", 3.0, 1, 0, 0, 0, 0);
						TablePizza[playerid] = CreateDynamicObject(2219,379.3999900,-128.8000000,1001.4000200,334.6000000,26.7570000,72.1960000); //object(pizzamed) (4)
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE4))
					{
						SetPlayerPos(playerid, POSTABLE4_4);
						SetPlayerFacingAngle(playerid, ANGTABLE4_4);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat1", 3.0, 1, 0, 0, 0, 0);
						TablePizza[playerid] = CreateDynamicObject(2219,379.2999900,-131.8999900,1001.4000200,334.6000000,26.7570000,72.1960000); //object(pizzamed) (4)
					}

				 	PSitPos[playerid] = GetPVarInt(playerid, "SitPos");
					PEatAt[playerid] = GetPVarInt(playerid, "EatAt");

					SendClientMessage(playerid, -1, "{F9603D}คำแนะนำ : {FDD3C9}กด 'N' เพื่อลุกจากที่นั่งและเลิกรับประทานอาหาร");
				}
			}
		}
	}
	return 1;
}

Dialog:DIALOG_CSIT2(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (IsPlayerConnected(playerid))
	    {
			switch(listitem)
			{
		        case 0:
				{
				    new Table = GetPVarInt(playerid, "SitPos");
					if(EatInfo[Table][IsOwn1] == 1) return ErrorMsg(playerid, "ที่นั่งนี้มีคนนั่งแล้ว");
					EatInfo[Table][IsOwn1] = 1;
					/* YOUR CODE*/
					SetPVarInt(playerid, "EatAt", 1);
   					SitingPizza[playerid] = 1;
   					CarrySome[playerid]=CARRY_NONE;
					SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
					if(IsPlayerAttachedObjectSlotUsed(playerid,CARRYSLOT)) RemovePlayerAttachedObject(playerid,CARRYSLOT);

					if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE1))
					{
						SetPlayerPos(playerid, POSTABLE1_1);
						SetPlayerFacingAngle(playerid, ANGTABLE1_1);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE2))
					{
						SetPlayerPos(playerid, POSTABLE2_1);
						SetPlayerFacingAngle(playerid, ANGTABLE2_1);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE3))
					{
						SetPlayerPos(playerid, POSTABLE3_1);
						SetPlayerFacingAngle(playerid, ANGTABLE3_1);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE4))
					{
						SetPlayerPos(playerid, POSTABLE4_1);
						SetPlayerFacingAngle(playerid, ANGTABLE4_1);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
				    }

				 	PSitPos[playerid] = GetPVarInt(playerid, "SitPos");
					PEatAt[playerid] = GetPVarInt(playerid, "EatAt");

					SendClientMessage(playerid, -1, "{F9603D}คำแนะนำ : {FDD3C9}กด 'N' เพื่อลุกจากที่นั่งและเลิกรับประทานอาหาร");
				}
		        case 1:
				{
				    new Table = GetPVarInt(playerid, "SitPos");
					if(EatInfo[Table][IsOwn2] == 1) return ErrorMsg(playerid, "ที่นั่งนี้มีคนนั่งแล้ว");
					EatInfo[Table][IsOwn2] = 1;
					/* YOUR CODE*/
					SetPVarInt(playerid, "EatAt", 2);

   					SitingPizza[playerid] = 1;
   					CarrySome[playerid]=CARRY_NONE;
					SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
					if(IsPlayerAttachedObjectSlotUsed(playerid,CARRYSLOT)) RemovePlayerAttachedObject(playerid,CARRYSLOT);

					if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE1))
					{
						SetPlayerPos(playerid, POSTABLE1_2);
						SetPlayerFacingAngle(playerid, ANGTABLE1_2);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE2))
					{
						SetPlayerPos(playerid, POSTABLE2_2);
						SetPlayerFacingAngle(playerid, ANGTABLE2_2);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE3))
					{
						SetPlayerPos(playerid, POSTABLE3_2);
						SetPlayerFacingAngle(playerid, ANGTABLE3_2);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
					}
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE4))
					{
						SetPlayerPos(playerid, POSTABLE4_2);
						SetPlayerFacingAngle(playerid, ANGTABLE4_2);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
				    }

				 	PSitPos[playerid] = GetPVarInt(playerid, "SitPos");
					PEatAt[playerid] = GetPVarInt(playerid, "EatAt");

					SendClientMessage(playerid, -1, "{F9603D}คำแนะนำ : {FDD3C9}กด 'N' เพื่อลุกจากที่นั่งและเลิกรับประทานอาหาร");
				}
		        case 2:
				{
				    new Table = GetPVarInt(playerid, "SitPos");
					if(EatInfo[Table][IsOwn3] == 1) return ErrorMsg(playerid, "ที่นั่งนี้มีคนนั่งแล้ว");
					EatInfo[Table][IsOwn3] = 1;
					/* YOUR CODE*/
					SetPVarInt(playerid, "EatAt", 3);

   					SitingPizza[playerid] = 1;
   					CarrySome[playerid]=CARRY_NONE;
					SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
					if(IsPlayerAttachedObjectSlotUsed(playerid,CARRYSLOT)) RemovePlayerAttachedObject(playerid,CARRYSLOT);

					if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE1))
				    {
						SetPlayerPos(playerid, POSTABLE1_3);
						SetPlayerFacingAngle(playerid, ANGTABLE1_3);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE2))
					{
						SetPlayerPos(playerid, POSTABLE2_3);
						SetPlayerFacingAngle(playerid, ANGTABLE2_3);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE3))
					{
						SetPlayerPos(playerid, POSTABLE3_3);
						SetPlayerFacingAngle(playerid, ANGTABLE3_3);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE4))
					{
						SetPlayerPos(playerid, POSTABLE4_3);
						SetPlayerFacingAngle(playerid, ANGTABLE4_3);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
				    }
				 	PSitPos[playerid] = GetPVarInt(playerid, "SitPos");
					PEatAt[playerid] = GetPVarInt(playerid, "EatAt");

					SendClientMessage(playerid, -1, "{F9603D}คำแนะนำ : {FDD3C9}กด 'N' เพื่อลุกจากที่นั่งและเลิกรับประทานอาหาร");
				}
		        case 3:
				{
				    new Table = GetPVarInt(playerid, "SitPos");
					if(EatInfo[Table][IsOwn4] == 1) return ErrorMsg(playerid, "ที่นั่งนี้มีคนนั่งแล้ว");
					EatInfo[Table][IsOwn4] = 1;
					/* YOUR CODE*/
					SetPVarInt(playerid, "EatAt", 4);

   					SitingPizza[playerid] = 1;
   					CarrySome[playerid]=CARRY_NONE;
					SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
					if(IsPlayerAttachedObjectSlotUsed(playerid,CARRYSLOT)) RemovePlayerAttachedObject(playerid,CARRYSLOT);

					if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE1))
				    {
						SetPlayerPos(playerid, POSTABLE1_4);
						SetPlayerFacingAngle(playerid, ANGTABLE1_4);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE2))
					{
						SetPlayerPos(playerid, POSTABLE2_4);
						SetPlayerFacingAngle(playerid, ANGTABLE2_4);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE3))
					{
						SetPlayerPos(playerid, POSTABLE3_4);
						SetPlayerFacingAngle(playerid, ANGTABLE3_4);
      					ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
				    }
				    else if(IsPlayerInRangeOfPoint(playerid, 1.0, NTABLE4))
					{
						SetPlayerPos(playerid, POSTABLE4_4);
						SetPlayerFacingAngle(playerid, ANGTABLE4_4);
						ApplyAnimation(playerid, "FOOD", "FF_Sit_Look", 3.0, 1, 0, 0, 0, 0);
				    }

				 	PSitPos[playerid] = GetPVarInt(playerid, "SitPos");
					PEatAt[playerid] = GetPVarInt(playerid, "EatAt");

					SendClientMessage(playerid, -1, "{F9603D}คำแนะนำ : {FDD3C9}กด 'N' เพื่อลุกจากที่นั่งและเลิกรับประทานอาหาร");
				}
			}
		}
	}
	return 1;
}
