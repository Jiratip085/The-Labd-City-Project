#include	<YSI_Coding\y_hooks>

new bool:StartGarbageJobs[MAX_PLAYERS];
new ZoneGarbageJobs[MAX_PLAYERS];
new bool:BagGarbageJobs[MAX_PLAYERS];
new ManyBagGarbage[MAX_PLAYERS];

new const Float:GarbageZone1[][] = {
    {2036.6326,-1059.7532,25.6508},
    {2186.4910,-997.8670,66.4688},
    {2109.3018,-1000.1881,60.5078},
    {2044.0205,-965.8195,43.8240},
    {1905.9004,-1113.4958,26.6641},
    {2185.9377,-1260.8351,23.9501},
    {2177.5801,-1344.4392,23.9844},
    {2129.5105,-1362.8569,25.5463},
    {2148.1287,-1484.9794,26.6239},
    {1883.8857,-1271.6322,13.5469},
    {2041.3971,-1409.6465,17.1641},
    {2224.6504,-1409.8109,24.0000},
    {2232.0378,-1159.8728,25.8906},
    {2208.1226,-1101.0172,31.5547},
    {2133.3450,-1232.5168,24.4219}
};
new const Float:GarbageZone2[][] = {
    {2379.8352,-1039.0015,53.7793},
    {2458.7178,-1051.5826,59.7387},
    {2567.9495,-1036.0137,69.5781},
    {2626.6729,-1112.6168,67.8671},
    {2756.2407,-1181.8188,69.3980},
    {2783.6667,-1306.3192,38.7223},
    {2851.4307,-1323.2948,11.2691},
    {2770.5901,-1628.2434,12.1775},
    {2754.4524,-1400.5197,39.3724},
    {2469.7942,-1295.4725,29.9714},
    {2473.2026,-1399.7008,28.8340},
    {2481.6079,-1536.6785,24.1006},
    {2324.5366,-1219.2434,27.9766},
    {2334.6965,-1266.1223,27.9693},
    {2421.7422,-1220.2346,25.4968}
};
new const Float:GarbageZone3[][] = {
    {2157.9392,-1612.5229,14.3019},
    {1973.6978,-1560.4585,13.6387},
    {2017.9136,-1597.1788,13.5696},
    {2014.7924,-1732.8018,14.2344},
    {2065.9661,-1703.4509,14.1484},
    {1877.9933,-1737.6140,13.3524},
    {2139.7498,-1733.1007,17.2891},
    {2046.3762,-1918.4353,13.5469},
    {1934.3862,-1896.8220,15.0347},
    {1867.2451,-1898.7789,15.0307},
    {1846.9591,-1871.6616,13.5781},
    {1775.1666,-1806.4487,13.5293},
    {1754.3033,-1593.5564,13.5370},
    {1720.2228,-1740.0598,13.5469}
};


hook OnPlayerConnect(playerid)
{
    StartGarbageJobs[playerid] = false;
    ZoneGarbageJobs[playerid] = false;
    BagGarbageJobs[playerid] = false;
    ManyBagGarbage[playerid] = 0;

    RemovePlayerAttachedObject(playerid, 9);
    RemovePlayerAttachedObject(playerid, 8);

    RemoveBuildingForPlayer(playerid, 1226, 778.8594, -1391.1563, 16.3125, 0.25);
    return 1;
}

new GateGarbage[2];

hook OnGameModeInit()
{
    CreateActor(260,732.8952,-1343.3030,13.5211,273.8068); 
    CreateDynamic3DTextLabel("William_Aaron\n{AAAAAA}กด 'Y' เพื่อเริ่มงาน", COLOR_WHITE, 732.8952,-1343.3030,13.5211+1.2, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

    GateGarbage[0] = CreateObject(975, 778.4282, -1329.9499, 14.1902,   0.00000, 0.00000, 0.00000);
    GateGarbage[1] = CreateObject(975, 777.4775, -1385.1030, 14.3844,   0.00000, 0.00000, 180.00000);
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    new tmp2[128];
 

	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
/* --------------------------------------------- NPC --------------------------------------------- */
        if (IsPlayerInRangeOfPoint(playerid, 1.5, 732.8952,-1343.3030,13.5211)) //เริ่มงาน
        {
            if(StartGarbageJobs[playerid] == false)
                return Dialog_Show(playerid, Start_Garbage, DIALOG_STYLE_MSGBOX, "William_Aaron", "{FFFFFF}Job: Garbage\n\
                คุณต้องการเริ่มงานในตอนนี้เลยหรือไม์?", "เริ่มงาน", "ยกเลิก");

            if(StartGarbageJobs[playerid] == true)
                return Dialog_Show(playerid, Stop_Garbage, DIALOG_STYLE_MSGBOX, "William_Aaron", "{FFFFFF}Job: Garbage\n{FF6347}คุณต้องการหยุดงานที่คุณกำลังทำอยู่เลยหรือไม์?", "หยุดงาน", "ยกเลิก");
       
        }

        new vehicleid = GetNearestVehicle(playerid);

        if(IsPlayerNearBoot(playerid, vehicleid))
        {
            new idx = random(sizeof(GarbageZone1));

            if(BagGarbageJobs[playerid] == false)
                return 1;

            if(!IsAGarbageVehicle(vehicleid))
                return 1;

            BagGarbageJobs[playerid] = false;
            new engine, lights, alarm, doors, bonnet, boot, objective;
            GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

            ApplyAnimation(playerid, "GRENADE","WEAPON_throwu", 4.1, 0, 0, 0, 0, 0, 1);
            RemovePlayerAttachedObject(playerid, 8);

            ManyBagGarbage[playerid] ++;
            format(tmp2, sizeof(tmp2), "~w~%d ~g~/ ~w~12", ManyBagGarbage[playerid]);
            GameTextForPlayer(playerid, tmp2, 1500, 3);
            PlayerPlaySound(playerid, 5602, 0.0, 0.0, 0.0);


            if(ZoneGarbageJobs[playerid] == 1)
            {
                if(StartGarbageJobs[playerid] != true)
                    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถหาขยะได้ เนื่องจากคุณไม่ได้ทำงานเก็บขยะ");

                PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
                SetPlayerCheckpoint(playerid, GarbageZone1[idx][0], GarbageZone1[idx][1], GarbageZone1[idx][2], 2.0);
            }
            if(ZoneGarbageJobs[playerid] == 2)
            {
                if(StartGarbageJobs[playerid] != true)
                    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถหาขยะได้ เนื่องจากคุณไม่ได้ทำงานเก็บขยะ");

                PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
                SetPlayerCheckpoint(playerid, GarbageZone2[idx][0], GarbageZone2[idx][1], GarbageZone2[idx][2], 2.0);
            }
            if(ZoneGarbageJobs[playerid] == 3)
            {
                if(StartGarbageJobs[playerid] != true)
                    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถหาขยะได้ เนื่องจากคุณไม่ได้ทำงานเก็บขยะ");

                PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
                SetPlayerCheckpoint(playerid, GarbageZone3[idx][0], GarbageZone3[idx][1], GarbageZone3[idx][2], 2.0);
            }
            if(ManyBagGarbage[playerid] >= 12) //ครบตามจำนวน
            {
                SendClientMessage(playerid, COLOR_YELLOW, "[Garbage]: คุณได้เก็บขยะครบตามจำนวนแล้ว กลับไปที่ STATE25 เพื่อรับ Paycheck");
                SetPlayerCheckpoint(playerid, 748.5265,-1349.0470,13.5084, 5.0);
            }
            return 1;
        }
    }
	if (newkeys & KEY_CROUCH && IsPlayerInAnyVehicle(playerid))
	{
        if (IsPlayerInRangeOfPoint(playerid, 15, 778.4282, -1329.9499, 14.1902)) //Gate หลัง
        {
            MoveObject(GateGarbage[0], 786.1, -1329.9499, 14.1902, 2);  
            SetTimerEx("GateGarbage1", 6000, 0, "id", playerid);
            return 1;
        }
        if (IsPlayerInRangeOfPoint(playerid, 15, 777.4775, -1385.1030, 14.3844)) //Gate หน้า
        {
            MoveObject(GateGarbage[1], 769.8, -1385.1030, 14.3844, 2);  
            SetTimerEx("GateGarbage2", 6000, 0, "id", playerid);
            return 1;
        }

    }
    return 1;
}
forward GateGarbage1(playerid, type);
public GateGarbage1(playerid)
{
    MoveObject(GateGarbage[0], 778.4282, -1329.9499, 14.1902, 2);
}
forward GateGarbage2(playerid, type);
public GateGarbage2(playerid)
{
    MoveObject(GateGarbage[1], 777.4775, -1385.1030, 14.3844, 2);
}


Dialog:Start_Garbage(playerid, response, listitem, inputtext[])
{
	if (response)
	{   
        new zone = randomEx(1, 3);
        StartGarbageJobs[playerid] = true;
        ZoneGarbageJobs[playerid] = zone;
        BagGarbageJobs[playerid] = false;
        ManyBagGarbage[playerid] = 0;
        SetPlayerAttachedObject(playerid,9,19904,1,0.079999,0.059000,0.007999,-0.500001,86.399963,175.999969,1.000000,1.033000,1.000000);
        PlayerPlaySound(playerid, 31200, 0.0, 0.0, 0.0);
        SendClientMessage(playerid, COLOR_YELLOW, "[Garbage]: คุณได้เริ่มงานเก็บขยะ ขึ้นไปบนยานพาหนะจากนนั้น /findtrash เพื่อค้นหาขยะ");
        SendClientMessage(playerid, COLOR_LIGHTRED, "(( หากคุณ 'ออกเกม' หรือ 'หลุดเกม' งานที่คุณทำอยู่จะถูกยกเลิก, และคุณต้องกลับไปเริ่มใหม่ ))");
	}
	return 1;
}
Dialog:Stop_Garbage(playerid, response, listitem, inputtext[])
{
	if (response)
	{
        StartGarbageJobs[playerid] = false;
        ZoneGarbageJobs[playerid] = false;
        BagGarbageJobs[playerid] = false;
        ManyBagGarbage[playerid] = 0;
        PlayerPlaySound(playerid, 31200, 0.0, 0.0, 0.0);
        RemovePlayerAttachedObject(playerid, 9);
        RemovePlayerAttachedObject(playerid, 8);
        SendClientMessage(playerid, COLOR_YELLOW, "[Garbage]: คุณได้หยุดทำงาน Garbage เรียบร้อย");
	}
	return 1;
}
hook OnPlayerEnterCheckpoint(playerid)
{
    if(StartGarbageJobs[playerid] == true && ZoneGarbageJobs[playerid] != 0 && IsPlayerInAnyVehicle(playerid))
    {
        new string[128], GarbagePaycheck = randomEx(1500, 2500),
            vehicleid = GetPlayerVehicleID(playerid);
        if(ManyBagGarbage[playerid] >= 12) //ครบตามจำนวน
        {
            ShowPlayerPaycheck(playerid);	
            SetTimerEx("PaycheckTimer", 10000, 0, "id", playerid);

            format(string, sizeof(string), "Name: %s", GetPlayerNameEx(playerid)); // Name
            PlayerTextDrawSetString(playerid, PaycheckTD[playerid][3], string);

            format(string, sizeof(string), "Job: Garbage"); 
            PlayerTextDrawSetString(playerid, PaycheckTD[playerid][4], string);

            format(string, sizeof(string), "Paycheck: %s", FormatMoney(GarbagePaycheck)); // Paycheck
            PlayerTextDrawSetString(playerid, PaycheckTD[playerid][5], string);

            StartGarbageJobs[playerid] = false;
            ZoneGarbageJobs[playerid] = false;
            BagGarbageJobs[playerid] = false;
            ManyBagGarbage[playerid] = 0;

            RemoveFromVehicle(playerid);
            SetVehicleToRespawn(vehicleid);
            playerData[playerid][pBankMoney] += GarbagePaycheck;
            RemovePlayerAttachedObject(playerid, 9);
            RemovePlayerAttachedObject(playerid, 8);
            SendClientMessageEx(playerid, COLOR_GREEN, "[Garbage]: คุณได้ประสบความสำเร็จในการเก็บขยะ, และได้รับ Paycheck จำนวน '%s'", FormatMoney(GarbagePaycheck));
            PlayerPlaySound(playerid, 1158, 0.0, 0.0, 0.0);
            DisablePlayerCheckpoint(playerid);
            return 1;
        }
    }
    if(StartGarbageJobs[playerid] == true && ZoneGarbageJobs[playerid] != 0 && !IsPlayerInAnyVehicle(playerid)) //เก็บขยะ
    {
        BagGarbageJobs[playerid] = true;
        SetPlayerAttachedObject(playerid,8,1265,6,0.290000,-0.014000,-0.078000,1.500000,-105.799980,2.400000,0.710001,0.655001,0.984999);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        DisablePlayerCheckpoint(playerid);
        playerData[playerid][pCheckpoint] = 0;
        PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
        //SendClientMessage(playerid, COLOR_YELLOW, "[Garbage] สามารถ /Trunk บริเวณหลังรถและ, กด 'Y' เพื่อโยนขยะ");
        SendClientMessage(playerid, COLOR_YELLOW, "[Garbage]: กด 'Y' ที่บริเวณหลังรถเพื่อโยนขยะ, หากจุดมาร์คหายสามารถ /findtrash เพื่อค้นหา");
    }
    return 1;
}

CMD:findtrash(playerid, params[])
{
    new idx = random(sizeof(GarbageZone1));

    if(ManyBagGarbage[playerid] >= 12) //ครบตามจำนวน
    {
        SendClientMessage(playerid, COLOR_YELLOW, "[Garbage]: คุณได้เก็บขยะครบตามจำนวนแล้ว กลับไปที่ STATE25 เพื่อรับ Paycheck");
        SetPlayerCheckpoint(playerid, 748.5265,-1349.0470,13.5084, 5.0);
    }

    if(playerData[playerid][pCheckpoint] == 1)
        return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณไม่สามารถค้นหาขยะได้ในขณะนี้ กรุณาไปเก็บขยะยังที่ล่าสุดก่อน");

    if(ZoneGarbageJobs[playerid] == 1)
    {
        if(StartGarbageJobs[playerid] != true)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถหาขยะได้ เนื่องจากคุณไม่ได้ทำงานเก็บขยะ");

        if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 408)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถหาขยะได้ เนื่องจากคุณไม่ได้อยู่บนรถเก็บขยะ");

        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
        SetPlayerCheckpoint(playerid, GarbageZone1[idx][0], GarbageZone1[idx][1], GarbageZone1[idx][2], 2.0);
        playerData[playerid][pCheckpoint] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "[Garbage]: จุดเก็บขยะถูกมาร์ค, ไปตาม Mini Map เพื่อเก็บขยะ");
    }
    if(ZoneGarbageJobs[playerid] == 2)
    {
        if(StartGarbageJobs[playerid] != true)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถหาขยะได้ เนื่องจากคุณไม่ได้ทำงานเก็บขยะ");

        if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 408)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถหาขยะได้ เนื่องจากคุณไม่ได้อยู่บนรถเก็บขยะ");

        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
        SetPlayerCheckpoint(playerid, GarbageZone2[idx][0], GarbageZone2[idx][1], GarbageZone2[idx][2], 2.0);
        playerData[playerid][pCheckpoint] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "[Garbage]: จุดเก็บขยะถูกมาร์ค, ไปตาม Mini Map เพื่อเก็บขยะ");
    }
    if(ZoneGarbageJobs[playerid] == 3)
    {
        if(StartGarbageJobs[playerid] != true)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถหาขยะได้ เนื่องจากคุณไม่ได้ทำงานเก็บขยะ");

        if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 408)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถหาขยะได้ เนื่องจากคุณไม่ได้อยู่บนรถเก็บขยะ");

        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
        SetPlayerCheckpoint(playerid, GarbageZone3[idx][0], GarbageZone3[idx][1], GarbageZone3[idx][2], 2.0);
        playerData[playerid][pCheckpoint] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "[Garbage]: จุดเก็บขยะถูกมาร์ค, ไปตาม Mini Map เพื่อเก็บขยะ");
    }
	return 1;
}
stock IsAGarbageVehicle(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 408: return 1;
	}
	return 0;
}