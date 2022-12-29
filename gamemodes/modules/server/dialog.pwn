#include <YSI\y_hooks>

Dialog:ManagePlant(playerid, response, listitem, inputtext[]){
    
    new idplant = -1;
    new idplantex = GetPVarInt(playerid, "Plantid");

    if(!response)
    {
        PlantData[idplantex][plantUse] = 0;
        return 1;
    }

    //

    if(response){
        if(listitem == 0){
            if ((idplant = Plant_Nearest(playerid)) != -1)
		    {
                if(PlantData[idplant][plantType] == 1){ //ฟักทอง
                    SendClientMessage(playerid, COLOR_GREEN, "-------------------------------------------------------------");
                    SendClientMessageEx(playerid, -1, "> พืชชนิด: %s <", Plant_GetName(PlantData[idplant][plantType]));
                    SendClientMessage(playerid, -1, "> ฟักทองจะเป็นพืชที่ต้องการน้ำพอสมควร [แนะนำ: แต่ละ 5 นาที น้ำจะลดทีละ 5] <");
                    SendClientMessage(playerid, -1, "> เมื่อระดับน้ำของพืชต่ำกว่า 50 พืชจะหยุดการเจริญเติบโต คุณจำเป็นต้องคอยดูแลเอาใจใส่อยู่ตลอด <");
                    SendClientMessage(playerid, -1, "> หากพืชมีความเจริญเติบโตเต็ม 100 คุณสามารถเก็บเกี่ยวได้ <");
                    SendClientMessage(playerid, COLOR_GREEN, "-------------------------------------------------------------");
                }
                if(PlantData[idplant][plantType] == 2){ //ส้ม
                    SendClientMessage(playerid, COLOR_GREEN, "-------------------------------------------------------------");
                    SendClientMessageEx(playerid, -1, "> พืชชนิด: %s <", Plant_GetName(PlantData[idplant][plantType]));
                    SendClientMessage(playerid, -1, "> ส้มจะเป็นพืชที่ต้องการน้ำพอสมควร [แนะนำ: แต่ละ 5 นาที น้ำจะลดทีละ 10] <");
                    SendClientMessage(playerid, -1, "> เมื่อระดับน้ำของพืชต่ำกว่า 50 พืชจะหยุดการเจริญเติบโต คุณจำเป็นต้องคอยดูแลเอาใจใส่อยู่ตลอด <");
                    SendClientMessage(playerid, -1, "> หากพืชมีความเจริญเติบโตเต็ม 100 คุณสามารถเก็บเกี่ยวได้ <");
                    SendClientMessage(playerid, COLOR_GREEN, "-------------------------------------------------------------");
                }
                PlantData[idplant][plantUse] = 0;
            }
        }
        if(listitem == 1){
            if ((idplant = Plant_Nearest(playerid)) != -1)
		    {
                if(PlantData[idplant][plantWater] <= 80)
                {
                    TogglePlayerControllable(playerid, 0);
                    ClearAnimations(playerid);
                    LoopingAnim(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0);
                    SetPlayerAttachedObject(playerid,4,19621,6,0.055000,0.018000,0.000000,99.100013,63.999984,83.799995,1.429999,1.633000,1.596000);
                    SendClientMessageEx(playerid, COLOR_GREEN, "กำลังรดน้ำต้นไม้ ID:[%d]",idplant);
                    SendClientMessage(playerid, COLOR_GREEN, "คุณกำลังรดน้ำต้นไม้ของคุณ....");
                    SetTimerEx("WaterPlant", 10000, false, "d", playerid);
                }
                else
                {
                    ErrorMsg(playerid, "พืชต้นนี้ยังไม่ต้องการน้ำ");
                    PlantData[idplant][plantUse] = 0;
                }
            }
        }
        if(listitem == 2){
            if ((idplant = Plant_Nearest(playerid)) != -1)
		    {
                if(PlantData[idplant][plantValue] != 100)
                {
                    PlantData[idplant][plantUse] = 0;
                    ErrorMsg(playerid, "พืชต้นนี้ยังไม่โตเต็มที่");
                    return 1;
                }

                TogglePlayerControllable(playerid, 0);
                ClearAnimations(playerid);
                LoopingAnim(playerid, "BOMBER", "BOM_Plant", 4.0, 1, 0, 0, 0, 0);
                SendClientMessageEx(playerid, COLOR_GREEN, "คุณกำลังเก็บเกี่ยวพืช ID:[%d]",idplant);
                SendClientMessage(playerid, COLOR_GREEN, "กำลังเก็บเกี่ยวพืช....");
                SetTimerEx("HarvestPlant", 10000, false, "d", playerid);
            }
        }
        if(listitem == 3){
            if ((idplant = Plant_Nearest(playerid)) != -1)
		    {
                ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
                SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้ถอนรากพืชของคุณเรียบร้อยแล้ว!");
                Plant_Delete(idplant);
            }
        }
    }
    return 1;
}
				/*if(playerData[playerid][pWhitelist] == 0)
				{
					Dialog_Show(playerid, Only, DIALOG_STYLE_MSGBOX, "{00FF00}[ตรวจสอบไวริส]","{FFFFFF}คุณไม่มีไวริส\nสามาารถติดต่อซื้อไวริสได้ที่เพจหรือเว็ป{00FF00} Black Woods {FFFFFF}ของเซิร์ฟเวอร์", "ตกลง", "");
					SetTimerEx("KickTimePlayer", 1000, 0, "d", playerid);
				}*/
Dialog:HelpFunction(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    if(response)
    {
        if(listitem == 0)
        {
            ShowStatsForPlayer(playerid, playerid);
        }
        if(listitem == 1)
        {
            OpenInventory(playerid);
        }
    }
    return 1;
}

Dialog:HelpMenu(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    if(response)
    {
        if(listitem == 0){
            Line(playerid);
            SendClientMessage(playerid, COLOR_YELLOW, "เกี่ยวกับการพูดคุย:");
            SendClientMessage(playerid, COLOR_WHITE, "/me, /do, /b, /(s)hout, /(l)ow, /(w)hisper, /pm");
            Line(playerid);
        }
        if(listitem == 1){
            Line(playerid);
            SendClientMessage(playerid, COLOR_YELLOW, "เกี่ยวกับยานพาหนะ:");
	        SendClientMessage(playerid, COLOR_WHITE, "/engine, /lights");
            Line(playerid);
        }
        if(listitem == 2){
            Line(playerid);
            SendClientMessage(playerid, COLOR_YELLOW, "เกี่ยวกับอลังทรัพย์:");
	        SendClientMessage(playerid, COLOR_WHITE, "/pay, /bizhelp, /househelp, /bankhelp");
            Line(playerid);
        }
        if(listitem == 3){
            Line(playerid);
            SendClientMessage(playerid, COLOR_GREY, "- เกี่ยวกับอาชีพ -");
            if (Character[playerid][Job] == 1)
            {
                SendClientMessage(playerid, COLOR_LIGHTRED, "[คนส่งของ]:{FFFFFF} /cargo");
            }
            if(Character[playerid][Job] == 2)
            {
                SendClientMessage(playerid, COLOR_LIGHTRED, "[ช่างยนต์]:{FFFFFF} /buycomp, /checkcomponents, /service, /colorlist, /paintcar");
            }
            if(Character[playerid][Job] == 3)
            {
                SendClientMessage(playerid, COLOR_LIGHTRED, "[คนตัดไม้]:{FFFFFF} /startlumberjack, /stoplumberjack, /loadwood, /unloadwood, /sellwood");
            }
            if(Character[playerid][Job] == 4)
            {
                SendClientMessage(playerid, COLOR_LIGHTRED, "[ขนส่งผลไม้]:{FFFFFF} /startharvest, /stopharvest, /loadfruit, /unloadfruit, /sellfruit");
            }
            Line(playerid);
        }
        if(listitem == 4){
            Line(playerid);
            SendClientMessage(playerid, COLOR_YELLOW, "อื่นๆ:");
	        SendClientMessage(playerid, COLOR_WHITE, "/stats, /(clearanim)ation, /changespawn, /properties");
            SendClientMessage(playerid, COLOR_WHITE, "/fhelp, /animlist");
            Line(playerid);
        }
    }
    return 1;
}
Dialog:DIALOG_LOCKER(playerid, response, listitem, inputtext[])
{
	new factionid = Character[playerid][Faction];

	
	if (response)
	{
	    static
	        string[512];

		string[0] = 0;

	    if (FactionData[factionid][factionType] == FACTION_POLICE)
	    {
	        switch (listitem)
	        {
	            case 0:
	            {
	                
					if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_ONDUTY))
					{
						BitFlag_On(g_PlayerFlags[playerid], PLAYER_ONDUTY);
						SetPlayerArmour(playerid, 100.0);
						SetPlayerHealth(playerid, 100.0);

						SetFactionColor(playerid);

						//GivePlayerWeapon(playerid, 24, 150);
						//GivePlayerWeapon(playerid, 3, 1);
						//GivePlayerWeapon(playerid, 41, 5000);

						if (GetFactionType(playerid) == FACTION_POLICE)
						{
							SendFactionMessage(Character[playerid][Faction], COLOR_RADIO, "** HQ: %s %s ได้เริ่มปฏิบัติหน้าที่ในขณะนี้! **", Faction_GetRank(playerid), ReturnName(playerid, 0));
						}
						
					}
					else
					{
						BitFlag_Off(g_PlayerFlags[playerid], PLAYER_ONDUTY);
						SetPlayerArmour(playerid, 0.0);
						ResetPlayerWeapons(playerid);

						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerSkin(playerid, Character[playerid][Skin]);

						// Resetweaponplayer(playerid);

						if (GetFactionType(playerid) == FACTION_POLICE)
						{
							SendFactionMessage(Character[playerid][Faction], COLOR_RADIO, "** HQ: %s %s ได้ออกจากการปฏิบัติหน้าที่ในขณะนี้! **", Faction_GetRank(playerid), ReturnName(playerid, 0));
						}
					}
				}
				case 1:
				{
					new
						skins[8];

					if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_ONDUTY))
					return SendClientMessage(playerid, -1, "คุณต้อง ON-DUTY ก่อน");

					{
						for (new i = 0; i < sizeof(skins); i ++)
						skins[i] = (FactionData[factionid][factionSkins][i]) ? (FactionData[factionid][factionSkins][i]) : (19300);

						ShowModelSelectionMenu(playerid, "Choose Skin", MODEL_SELECTION_FACTION_SKIN, skins, sizeof(skins), -16.0, 0.0, -55.0);
					}
					
				}


				case 2:
				{
					if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_ONDUTY))
					return SendClientMessage(playerid, -1, "คุณต้อง ON-DUTY ก่อน");

					Dialog_Show(playerid, DIALOG_LAPDWE, DIALOG_STYLE_LIST, "[คลังอาวุธ]", "Spraycan\nNightstick\nDesert Eagle\nShotgun\nMP5\nM4", "เบิก", "ออก");
					/*ResetPlayerWeaponsEx(playerid);
					GivePlayerWeaponEx(playerid, 3, 1);
					GivePlayerWeaponEx(playerid, 41, 1500);
					GivePlayerWeaponEx(playerid, 23, 150);
					GivePlayerWeaponEx(playerid, WEAPON_SHOTGUN, 50);*/
				}
				/*case 3:
				{
					if(playerData[playerid][pFactionRank] >= 14)
					Dialog_Show(playerid, DIALOG_LSPD_RELEASE, DIALOG_STYLE_INPUT, "ปล่อยผู้ต้องสงสัย", "กรุณาใส่ชื่อผู้ต้องสงสัย", "ถัดไป", "ยกเลิก");
					else SendClientMessage(playerid, COLOR_GREY, "คุณไม่ได้รับอนุณาติให้ใช้คำสั่งนี้");
				}*/
			}
	    }
		
	}
	return 1;
}

Dialog:DIALOG_LAPDWE(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		return 1;
	}
	else
	{
		switch(listitem) //
		{
			case 0: //
			{
			    GivePlayerWeapon(playerid, 41, 500);
			}
			case 1: //
			{
			    GivePlayerWeapon(playerid, 3, 1);
			}
			case 2: //
			{
			    GivePlayerWeapon(playerid, 24, 70);
			}
			case 3: //
			{
			    GivePlayerWeapon(playerid, 25, 100);
			}
			case 4: //
			{
			    GivePlayerWeapon(playerid, 29, 70);
			}
			case 5: //
			{
			    GivePlayerWeapon(playerid, 31, 70);
			}

        }
    }
	return 1;
}


Dialog:DIALOG_LSPD_MDC(playerid, response, listitem, inputtext[])
{
   			if(response)
			    switch(listitem)
				{
		            case 0:
					{
                        Dialog_Show(playerid, DIALOG_LSPD_INPUTNAME, DIALOG_STYLE_INPUT, "Mobile Data Computer", "ใส่ไอดีผู้เล่นที่ต้องการค้นหา", "ค้นหา","");
		            }
                    case 1:
					{
                    	Dialog_Show(playerid, DIALOG_LSPD_INPUTPLAT, DIALOG_STYLE_INPUT, "Mobile Data Computer", "ใส่เลขป้ายทะเบียนพาหนะ", "ค้นหา","");
					}
			}
    	}
    	
Dialog:DIALOG_LSPD_INPUTPLAT(playerid, response, listitem, inputtext[])
{
      if(response)
   			{
   				new
			    	szEscapedPlate[32], query[798];

   				//mysql_real_escape_string(inputtext, szEscapedPlate);

				mysql_format(dbCon, query, sizeof(query), "SELECT * FROM vehicles WHERE vehiclePlate = '%s'", szEscapedPlate);
				mysql_tquery(dbCon, query,  "CheckPlateDB", "i", playerid);


   			}
		}
		
Dialog:DIALOG_BUYVEHICLE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		
		new
			string[256], id = -1;

		Character[playerid][pSelectedSlot] = listitem;

		format(string, sizeof(string), "{FFFFFF}ยืนยันการชำระเงิน:\nคุณแน่ใจไหมที่จะซื้อยานพาหนะไอดี %d", CarData[id][carVehicle]);
		Dialog_Show(playerid, DIALOG_BUYVEHICLE2, DIALOG_STYLE_MSGBOX, "[ยืนยันการชำระเงิน]", string, "ยืนยัน", "ยกเลิก");
	}
	return 1;
}
/*
Dialog:DIALOG_BUYVEHICLE2(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
	    Float:x,
		Float:y,
		Float:z,
		Float:angle,
		id = -1,
		userid,
	    model[32];

    //GetPlayerPos(userid, x, y, z);
	GetPlayerFacingAngle(userid, angle);

	//id = Car_Create(Character[userid][ID], model[0], x, y + 2, z + 1, angle, random(127), random(127), 0);

	}
	return 1;
}*/
