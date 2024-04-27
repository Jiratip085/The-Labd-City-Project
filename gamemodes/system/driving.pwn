#include	<YSI_Coding\y_hooks>	
    
new const Float:g_arrDrivingCheckpoints[][] = {
    {2163.8894,-1120.7288,25.3993},
    {2146.7163,-1133.8607,25.5676},
    {2164.5554,-1163.1902,23.8196},
    {2145.1082,-1166.2469,23.8203},
    {2164.0735,-1197.2006,23.9391},
    {2145.4490,-1194.3348,23.8319},
    {2165.2935,-1203.0610,23.9170},
    {2178.0752,-1131.1035,24.9496},
    {2218.5344,-1142.7847,25.8032},
    {2230.8728,-1159.5648,25.8265},
    {2203.2644,-1156.9229,25.7490},
    {2230.9683,-1177.4177,25.7266},
    {2220.1287,-1141.3551,25.7969},
    {2259.2085,-1146.6592,26.7617},
    {2268.3486,-1206.2917,24.0562},
    {2187.4399,-1218.2482,23.8121},
    {2083.1443,-1218.5269,23.8047},
    {2073.6936,-1148.2855,23.7296},
    {2073.3330,-1103.8450,24.7427},
    {2125.3171,-1121.5498,25.3551}
};




hook OnGameModeInit()
{
    CreateObject(1238, 2152.37305, -1132.13049, 24.81960,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2149.80688, -1131.74231, 24.89760,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2146.89551, -1132.10486, 24.89758,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2158.12842, -1160.72339, 23.11654,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2161.05469, -1160.73413, 23.11140,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2164.33618, -1160.69434, 23.11140,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2151.62036, -1168.65393, 23.11527,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2148.33740, -1168.66064, 23.11527,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2145.13330, -1168.62305, 23.11527,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2158.11328, -1199.63330, 23.17940,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2161.66333, -1199.68372, 23.23950,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2164.98340, -1199.61487, 23.35491,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2151.41919, -1196.68884, 23.11498,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2148.25537, -1196.67761, 23.11498,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2145.24951, -1196.70349, 23.11498,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2225.72583, -1161.17493, 25.05882,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2228.53394, -1161.20374, 25.05882,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2231.09839, -1161.23389, 25.05882,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2208.15283, -1155.08350, 24.99495,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2205.49023, -1155.09351, 24.99495,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2203.18604, -1155.06848, 24.99495,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2225.45605, -1178.95215, 25.00195,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2228.42065, -1179.01050, 25.00195,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2231.11230, -1178.98535, 25.00195,   0.00000, 0.00000, 0.00000);
    CreateObject(1237, 2118.80859, -1112.15625, 24.03145,   0.00000, 0.00000, 0.00000);
    CreateObject(1237, 2118.31299, -1113.52966, 24.03145,   0.00000, 0.00000, 0.00000);
    CreateObject(1237, 2111.87402, -1110.22437, 24.07026,   0.00000, 0.00000, 0.00000);
    CreateObject(1237, 2111.39722, -1111.41187, 24.07026,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2152.37305, -1136.17053, 24.87960,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2149.71289, -1136.17053, 24.87960,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2146.95288, -1136.17053, 24.87960,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2158.08789, -1165.66589, 23.11654,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2160.85498, -1165.71960, 23.11140,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2164.26294, -1165.72083, 23.11140,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2151.64355, -1163.99316, 23.11527,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2148.30078, -1164.02075, 23.11527,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2145.17017, -1163.92053, 23.11527,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2157.94824, -1194.85303, 23.17940,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2161.64526, -1194.78845, 23.23950,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2164.82617, -1194.67578, 23.35491,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2151.28613, -1192.06946, 23.11498,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2148.29932, -1191.99524, 23.11498,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2145.29370, -1192.04114, 23.11498,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2226.02417, -1157.70496, 25.05882,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2228.51001, -1157.75977, 25.05882,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2231.02686, -1157.79077, 25.05882,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2203.16138, -1158.88904, 24.99495,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2205.38647, -1158.85596, 24.99495,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2208.16528, -1158.90588, 24.99495,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2225.67725, -1175.57581, 25.00195,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2228.60645, -1175.54895, 25.00195,   0.00000, 0.00000, 0.00000);
    CreateObject(1238, 2231.12134, -1175.60474, 25.00195,   0.00000, 0.00000, 0.00000);

    CreateActor(187,2131.8008,-1151.2697,24.0658,357.4387); 
    CreateDynamic3DTextLabel("Tommy_Driving\n{AAAAAA}กด 'Y' เพื่อเริ่มสอบ", COLOR_WHITE, 2131.8008,-1151.2697,24.0658+1.1, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
}

hook OnPlayerEnterCheckpoint(playerid)
{
    new vehicleid = GetPlayerVehicleID(playerid);

	if (playerData[playerid][pDrivingTest])
	{
	    playerData[playerid][pTestStage]++;
        PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
	    if (playerData[playerid][pTestStage] < sizeof(g_arrDrivingCheckpoints))
		{
            SendClientMessage(playerid, COLOR_YELLOW, "[Driving School]: คุณจำเป็นต้องหยุด-ชะลอ ทุกครั้งที่ก่อนถึงทางแยกหรือเส้นข้ามเส้น 'stop sign'");
			SetPlayerCheckpoint(playerid, g_arrDrivingCheckpoints[playerData[playerid][pTestStage]][0], g_arrDrivingCheckpoints[playerData[playerid][pTestStage]][1], g_arrDrivingCheckpoints[playerData[playerid][pTestStage]][2], 3.0);
            SetVehicleSpeedAC(vehicleid, 0);
            return 1;
        }
        else
        {
            Inventory_Add(playerid, "DrivingLicense", 1);
            SendClientMessage(playerid, COLOR_GREEN, "[Driving School]: คุณได้สอบใบขับขี่สำหรับ 'ยานพาหนะทั่วไป' สำเร็จเรียบร้อย");
            SendClientMessage(playerid, COLOR_GREEN, "[Driving School]: คุณได้รับ 'Driving License' จำนวน 1 ใบ");
            PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
        }
        CancelDrivingTest(playerid);
	}

	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid) && IsPlayerInRangeOfPoint(playerid, 2.0, 2131.8008,-1151.2697,24.0658))
	{
        if (playerData[playerid][pDrivingTest])
            return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณกำลังอยู่ในขั้นตอนการสอบใบขับขี่อยู่!");

        if (Inventory_HasItem(playerid, "DrivingLicense"))
            return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณมีใบขับขี่สำหรับ 'ยานพาหนะทั่วไป' อยู่แล้ว");

        if (GetPlayerMoneyEx(playerid) < 500)
            return SendClientMessageEx(playerid, COLOR_LIGHTRED, "- ไม่สามารถเริ่มสอบใบขับขี่ได้ เนื่องจากคุณมีเงินไม้เพียงพอ (%s/%s)", FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(500));

        playerData[playerid][pInterior] = GetPlayerInterior(playerid);
        playerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);

        GetPlayerHealth(playerid, playerData[playerid][pHealth]);
        GetPlayerPos(playerid, playerData[playerid][pPos_X], playerData[playerid][pPos_Y], playerData[playerid][pPos_Z]);
        GetPlayerFacingAngle(playerid, playerData[playerid][pPos_A]);

        playerData[playerid][pTestCar] = CreateVehicle(547, 2114.8875,-1112.0079,24.8473,252.7223, 1, 1, -1);
        vehicleFuel[playerData[playerid][pTestCar]] = 100;

        playerData[playerid][pTestWarns] = 0;
        GivePlayerMoneyEx(playerid, -500);

        GameTextForPlayer(playerid, "~r~-500",1000, 1);

        if (playerData[playerid][pTestCar] != INVALID_VEHICLE_ID)
        {
            playerData[playerid][pDrivingTest] = true;
            playerData[playerid][pTestStage] = 0;

            SetPlayerVirtualWorld(playerid, 0);
            SetVehicleVirtualWorld(playerData[playerid][pTestCar], 0);

            PutPlayerInVehicle(playerid, playerData[playerid][pTestCar], 0);

            SetPlayerCheckpoint(playerid, g_arrDrivingCheckpoints[0][0], g_arrDrivingCheckpoints[0][1], g_arrDrivingCheckpoints[0][2], 1.0);
            SendClientMessage(playerid, COLOR_YELLOW, "[Driving School]: คุณได้เริ่มการสอบใบขับขี่, โปรดยานพาหนพขับยานพาฟนะไปตามจุดสีแดง");
            
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);SendClientMessage(playerid, COLOR_YELLOW, "[Driving School]: หากคุณขับเร็วเกินกว่า 80 Km/h และ ยานพาหนะได้รับความเสียหายมากจนเกินไป การสอบจะถูกยกเลิก");
            SetPlayerInterior(playerid, 0);
        }
        return 1;
    }
    return 1;
}

CancelDrivingTest(playerid)
{
	if (playerData[playerid][pDrivingTest])
	{
 		SetPlayerPos(playerid, 2131.5608,-1150.2672,24.1732);
 		SetPlayerFacingAngle(playerid, 179.2208);

  		SetPlayerInterior(playerid, playerData[playerid][pInterior]);
  		SetPlayerVirtualWorld(playerid, playerData[playerid][pWorld]);

		DisablePlayerCheckpoint(playerid);
  		SetCameraBehindPlayer(playerid);

		DestroyVehicle(playerData[playerid][pTestCar]);
  		playerData[playerid][pDrivingTest] = false;
	}
	return 1;
}