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
                if(PlantData[idplant][plantType] == 1){ //�ѡ�ͧ
                    SendClientMessage(playerid, COLOR_GREEN, "-------------------------------------------------------------");
                    SendClientMessageEx(playerid, -1, "> �ת��Դ: %s <", Plant_GetName(PlantData[idplant][plantType]));
                    SendClientMessage(playerid, -1, "> �ѡ�ͧ���繾ת����ͧ��ù�Ӿ������ [�й�: ���� 5 �ҷ� ��Ө�Ŵ���� 5] <");
                    SendClientMessage(playerid, -1, "> ������дѺ��Ӣͧ�ת��ӡ��� 50 �ת����ش�����ԭ�Ժ� �س���繵�ͧ��´���������������ʹ <");
                    SendClientMessage(playerid, -1, "> �ҡ�ת�դ�����ԭ�Ժ���� 100 �س����ö��������� <");
                    SendClientMessage(playerid, COLOR_GREEN, "-------------------------------------------------------------");
                }
                if(PlantData[idplant][plantType] == 2){ //���
                    SendClientMessage(playerid, COLOR_GREEN, "-------------------------------------------------------------");
                    SendClientMessageEx(playerid, -1, "> �ת��Դ: %s <", Plant_GetName(PlantData[idplant][plantType]));
                    SendClientMessage(playerid, -1, "> ������繾ת����ͧ��ù�Ӿ������ [�й�: ���� 5 �ҷ� ��Ө�Ŵ���� 10] <");
                    SendClientMessage(playerid, -1, "> ������дѺ��Ӣͧ�ת��ӡ��� 50 �ת����ش�����ԭ�Ժ� �س���繵�ͧ��´���������������ʹ <");
                    SendClientMessage(playerid, -1, "> �ҡ�ת�դ�����ԭ�Ժ���� 100 �س����ö��������� <");
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
                    SendClientMessageEx(playerid, COLOR_GREEN, "���ѧô��ӵ���� ID:[%d]",idplant);
                    SendClientMessage(playerid, COLOR_GREEN, "�س���ѧô��ӵ����ͧ�س....");
                    SetTimerEx("WaterPlant", 10000, false, "d", playerid);
                }
                else
                {
                    ErrorMsg(playerid, "�ת�鹹���ѧ����ͧ��ù��");
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
                    ErrorMsg(playerid, "�ת�鹹���ѧ����������");
                    return 1;
                }

                TogglePlayerControllable(playerid, 0);
                ClearAnimations(playerid);
                LoopingAnim(playerid, "BOMBER", "BOM_Plant", 4.0, 1, 0, 0, 0, 0);
                SendClientMessageEx(playerid, COLOR_GREEN, "�س���ѧ������Ǿת ID:[%d]",idplant);
                SendClientMessage(playerid, COLOR_GREEN, "���ѧ������Ǿת....");
                SetTimerEx("HarvestPlant", 10000, false, "d", playerid);
            }
        }
        if(listitem == 3){
            if ((idplant = Plant_Nearest(playerid)) != -1)
		    {
                ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
                SendClientMessageEx(playerid, COLOR_GREEN, "�س��͹�ҡ�ת�ͧ�س���º��������!");
                Plant_Delete(idplant);
            }
        }
    }
    return 1;
}
				/*if(playerData[playerid][pWhitelist] == 0)
				{
					Dialog_Show(playerid, Only, DIALOG_STYLE_MSGBOX, "{00FF00}[��Ǩ�ͺ�����]","{FFFFFF}�س����������\n�����ö�Դ��ͫ������������ྨ�������{00FF00} Black Woods {FFFFFF}�ͧ���������", "��ŧ", "");
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
            SendClientMessage(playerid, COLOR_YELLOW, "����ǡѺ��þٴ���:");
            SendClientMessage(playerid, COLOR_WHITE, "/me, /do, /b, /(s)hout, /(l)ow, /(w)hisper, /pm");
            Line(playerid);
        }
        if(listitem == 1){
            Line(playerid);
            SendClientMessage(playerid, COLOR_YELLOW, "����ǡѺ�ҹ��˹�:");
	        SendClientMessage(playerid, COLOR_WHITE, "/engine, /lights");
            Line(playerid);
        }
        if(listitem == 2){
            Line(playerid);
            SendClientMessage(playerid, COLOR_YELLOW, "����ǡѺ��ѧ��Ѿ��:");
	        SendClientMessage(playerid, COLOR_WHITE, "/pay, /bizhelp, /househelp, /bankhelp");
            Line(playerid);
        }
        if(listitem == 3){
            Line(playerid);
            SendClientMessage(playerid, COLOR_GREY, "- ����ǡѺ�Ҫվ -");
            if (Character[playerid][Job] == 1)
            {
                SendClientMessage(playerid, COLOR_LIGHTRED, "[���觢ͧ]:{FFFFFF} /cargo");
            }
            if(Character[playerid][Job] == 2)
            {
                SendClientMessage(playerid, COLOR_LIGHTRED, "[��ҧ¹��]:{FFFFFF} /buycomp, /checkcomponents, /service, /colorlist, /paintcar");
            }
            if(Character[playerid][Job] == 3)
            {
                SendClientMessage(playerid, COLOR_LIGHTRED, "[���Ѵ���]:{FFFFFF} /startlumberjack, /stoplumberjack, /loadwood, /unloadwood, /sellwood");
            }
            if(Character[playerid][Job] == 4)
            {
                SendClientMessage(playerid, COLOR_LIGHTRED, "[���觼����]:{FFFFFF} /startharvest, /stopharvest, /loadfruit, /unloadfruit, /sellfruit");
            }
            Line(playerid);
        }
        if(listitem == 4){
            Line(playerid);
            SendClientMessage(playerid, COLOR_YELLOW, "����:");
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
							SendFactionMessage(Character[playerid][Faction], COLOR_RADIO, "** HQ: %s %s ���������Ժѵ�˹�ҷ��㹢�й��! **", Faction_GetRank(playerid), ReturnName(playerid, 0));
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
							SendFactionMessage(Character[playerid][Faction], COLOR_RADIO, "** HQ: %s %s ���͡�ҡ��û�Ժѵ�˹�ҷ��㹢�й��! **", Faction_GetRank(playerid), ReturnName(playerid, 0));
						}
					}
				}
				case 1:
				{
					new
						skins[8];

					if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_ONDUTY))
					return SendClientMessage(playerid, -1, "�س��ͧ ON-DUTY ��͹");

					{
						for (new i = 0; i < sizeof(skins); i ++)
						skins[i] = (FactionData[factionid][factionSkins][i]) ? (FactionData[factionid][factionSkins][i]) : (19300);

						ShowModelSelectionMenu(playerid, "Choose Skin", MODEL_SELECTION_FACTION_SKIN, skins, sizeof(skins), -16.0, 0.0, -55.0);
					}
					
				}


				case 2:
				{
					if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_ONDUTY))
					return SendClientMessage(playerid, -1, "�س��ͧ ON-DUTY ��͹");

					Dialog_Show(playerid, DIALOG_LAPDWE, DIALOG_STYLE_LIST, "[��ѧ���ظ]", "Spraycan\nNightstick\nDesert Eagle\nShotgun\nMP5\nM4", "�ԡ", "�͡");
					/*ResetPlayerWeaponsEx(playerid);
					GivePlayerWeaponEx(playerid, 3, 1);
					GivePlayerWeaponEx(playerid, 41, 1500);
					GivePlayerWeaponEx(playerid, 23, 150);
					GivePlayerWeaponEx(playerid, WEAPON_SHOTGUN, 50);*/
				}
				/*case 3:
				{
					if(playerData[playerid][pFactionRank] >= 14)
					Dialog_Show(playerid, DIALOG_LSPD_RELEASE, DIALOG_STYLE_INPUT, "����¼���ͧʧ���", "��س������ͼ���ͧʧ���", "�Ѵ�", "¡��ԡ");
					else SendClientMessage(playerid, COLOR_GREY, "�س������Ѻ͹سҵ���������觹��");
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
                        Dialog_Show(playerid, DIALOG_LSPD_INPUTNAME, DIALOG_STYLE_INPUT, "Mobile Data Computer", "����ʹռ����蹷���ͧ��ä���", "����","");
		            }
                    case 1:
					{
                    	Dialog_Show(playerid, DIALOG_LSPD_INPUTPLAT, DIALOG_STYLE_INPUT, "Mobile Data Computer", "����Ţ���·���¹��˹�", "����","");
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

		format(string, sizeof(string), "{FFFFFF}�׹�ѹ��ê����Թ:\n�س���������Ы����ҹ��˹��ʹ� %d", CarData[id][carVehicle]);
		Dialog_Show(playerid, DIALOG_BUYVEHICLE2, DIALOG_STYLE_MSGBOX, "[�׹�ѹ��ê����Թ]", string, "�׹�ѹ", "¡��ԡ");
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
