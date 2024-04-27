#include	<YSI_Coding\y_hooks>
#include 	<YSI_Coding\y_timers>
new szQueryOutput[3120];

new Ls_DrivingLicense[1];
new Ls_MotelGasViveWood[1];
new Ls_STAGE25[1];

new Ruth_Truckman;
new bool:StartTrucking [MAX_PLAYERS];

new Text3D:CargoSupplierText[2];
new CargoSupplier[2];

new VehicleTrunking[MAX_PLAYERS];

new TruckGate[2];

new ManyTruck[MAX_VEHICLES];
static ManyTruckType[MAX_PLAYERS];


static EnterTruckingVehicle[MAX_PLAYERS];
new bool:TruckCarry[MAX_PLAYERS];

//TruckDelivery
new bool:CarryTruckDrlivery[MAX_PLAYERS];
new EnterCheckpointTrucking[MAX_PLAYERS];

forward TruckerGate(playerid, type);
forward TruckerGate2(playerid, type);

new const Float:SpawnTruckingVehicle[][] = {
	{2746.7561, -2435.6350, 13.6994, -90.5600},
	{2746.7561, -2443.6350, 13.6994, -90.5600},
	{2746.7354, -2427.6946, 13.6994, -90.5600}
};

hook OnPlayerConnect(playerid)
{
    SetPlayerMapIcon(playerid, 0, 2729.5442,-2451.4233,17.5937, 51, 0, MAPICON_LOCAL);

    RemoveBuildingForPlayer(playerid, 3744, 2789.2109, -2377.6250, 15.2188, 0.25);
    RemoveBuildingForPlayer(playerid, 3744, 2774.7969, -2386.8516, 15.2188, 0.25);
    RemoveBuildingForPlayer(playerid, 3744, 2771.0703, -2520.5469, 15.2188, 0.25);
    RemoveBuildingForPlayer(playerid, 3770, 2795.8281, -2394.2422, 14.1719, 0.25);
    RemoveBuildingForPlayer(playerid, 1226, 2713.0625, -2508.3047, 16.3594, 0.25);
    RemoveBuildingForPlayer(playerid, 3574, 2771.0703, -2520.5469, 15.2188, 0.25);
    RemoveBuildingForPlayer(playerid, 3578, 2747.0078, -2480.2422, 13.1719, 0.25);
    RemoveBuildingForPlayer(playerid, 3577, 2744.5703, -2436.1875, 13.3438, 0.25);
    RemoveBuildingForPlayer(playerid, 3577, 2744.5703, -2427.3203, 13.3516, 0.25);
    RemoveBuildingForPlayer(playerid, 3574, 2774.7969, -2386.8516, 15.2188, 0.25);
    RemoveBuildingForPlayer(playerid, 3574, 2789.2109, -2377.6250, 15.2188, 0.25);
    RemoveBuildingForPlayer(playerid, 3626, 2795.8281, -2394.2422, 14.1719, 0.25);

    StartTrucking[playerid] = false;
    RemovePlayerAttachedObject(playerid, 9);
    return 1;
}
hook OnPlayerDisconnect(playerid, reason)
{
    StartTrucking[playerid] = false;
    DisablePlayerCheckpoint(playerid);
    EnterTruckingVehicle[playerid] = 0;
    RemovePlayerAttachedObject(playerid, 9);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    ManyTruck[VehicleTrunking[playerid]] = 0;
    ManyTruckType[VehicleTrunking[playerid]] = 0;
    TruckCarry[playerid] = false;
    DestroyVehicle(VehicleTrunking[playerid]);
    DestroyvehicleTrucking(VehicleTrunking[playerid]);
    EnterCheckpointTrucking[playerid] = 0;
    CarryTruckDrlivery[playerid] = false;
    return 1;
}
hook OnGameModeInit()
{
    
	for(new i=0; i<sizeof(CargoSupplier); i++)
	{
		CargoSupplier[i] = 100;
		UpdateCargoSupplierText(i);
    }
    TruckGate[0] = CreateObject(975, 2719.80688, -2504.10962, 14.13560,   0.00000, 0.00000, 221850.51563);
    TruckGate[1] = CreateObject(975, 2719.88501, -2405.27441, 14.11620,   0.00000, 0.00000, 89.46000);

    CreateObject(19970, 2741.02319, -2498.21753, 12.52121,   0.00000, 0.00000, -0.18000);
    CreateObject(19989, 2689.95117, -2510.71362, 12.60005,   -0.54000, -1.26000, 90.89998);
    CreateObject(19970, 2692.13379, -2411.43994, 12.51795,   0.00000, 0.00000, -182.51996);
    CreateObject(19959, 2766.34180, -2489.85767, 12.46367,   0.00000, 0.00000, -169.19997);
    CreateObject(19986, 2673.16187, -2399.27856, 12.48965,   0.00000, 0.00000, -92.75997);
    CreateObject(19948, 2670.38818, -2411.68140, 12.43868,   0.00000, 0.00000, -86.40002);
    CreateObject(3379, 2692.76685, -2497.05200, 12.55151,   0.00000, 0.00000, 94.79998);
    CreateObject(4639, 2718.19189, -2497.94727, 14.38030,   0.00000, 0.00000, -179.93979);
    CreateObject(4639, 2718.23315, -2399.31689, 14.47760,   0.00000, 0.00000, -180.78014);
    CreateObject(19313, 2801.88379, -2436.59644, 13.61039,   0.00000, 0.00000, 89.70007);
    CreateObject(19313, 2801.75488, -2474.93530, 13.72359,   0.00000, 0.00000, -89.81999);

    CreateObject(19859, 753.85529, -1359.50769, 17.56280,   0.00000, 0.00000, -178.15977);
    CreateObject(19859, 750.85553, -1359.55713, 17.55730,   0.00000, 0.00000, 0.00000);

    CreateDynamicPickup(3014, 1, 2802.2148,-2521.4253,13.6277); //Cargo supplier 1
    CargoSupplierText[0] = CreateDynamic3DTextLabel("[Cargo supplier]{FFFFFF}\n%d / 100", COLOR_ORANGE, 2802.2148,-2521.4253,13.6277, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    
    CreateDynamicPickup(3014, 1, 2802.2148,-2356.5339,13.6301); //Cargo supplier 2
    CargoSupplierText[1] = CreateDynamic3DTextLabel("[Cargo supplier]{FFFFFF}\n%d / 100", COLOR_ORANGE, 2802.2148,-2356.5339,13.6301, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    
    Ruth_Truckman = CreateActor(133,2729.5442,-2451.4233,17.5937,270.4942); 
    CreateDynamic3DTextLabel("Ruth Truckman\n", COLOR_WHITE, 2729.5442,-2451.4233,17.5937+1.0, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

}
hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(EnterTruckingVehicle[playerid] == 1 && EnterTruckingVehicle[playerid] == 1)
    {
        if(!IsATruckingVehicle(VehicleTrunking[playerid]))
            return 1;
            
        SendClientMessage(playerid, COLOR_YELLOW, "[Trucking] ไปยังเครนส์สีแดงบริเวณที่จอดเรือ เพื่อรับลังสินค้า");
        SendClientMessage(playerid, COLOR_YELLOW, "[Trucking] สามมารถ /Trunk เพื่อเปิดท้าย, กด Y เพื่อยกและวางลังสินค้า");
        SendClientMessage(playerid, COLOR_LIGHTRED, "(( ห้ามจอดยานพาหนะของคุณไว้บนจุดรับสินค้าโดยเด็ดขาด [ซึ่งอาจทำให้คุณโดนเตือน!] ))");
        DisablePlayerCheckpoint(playerid);
        EnterTruckingVehicle[playerid] = 0;
        return 1;
    }
    return 1;
}
DestroyvehicleTrucking(playerid)
{
    DestroyVehicle(VehicleTrunking[playerid]);
    
    StartTrucking[playerid] = false;
    DisablePlayerCheckpoint(playerid);
    EnterTruckingVehicle[playerid] = 0;
    RemovePlayerAttachedObject(playerid, 9);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    ManyTruck[VehicleTrunking[playerid]] = 0;
    ManyTruckType[VehicleTrunking[playerid]] = 0;
    TruckCarry[playerid] = false;

    EnterCheckpointTrucking[playerid] = 0;
    CarryTruckDrlivery[playerid] = false;
    return 1;
}

Dialog:Trucking(playerid, response, listitem, inputtext[])
{
	if (response)
	{
        new idx = random(sizeof(SpawnTruckingVehicle)), TruckColor = randomEx(0, 255), RandomKeyTruck = randomEx(100, 900);
		switch(listitem)
		{
		    case 0: // Pony
		    {
                VehicleTrunking[playerid] = CreateVehicle(413, SpawnTruckingVehicle[idx][0], SpawnTruckingVehicle[idx][1], SpawnTruckingVehicle[idx][2], SpawnTruckingVehicle[idx][3], TruckColor, TruckColor, 600);
                vehicleFuel[VehicleTrunking[playerid]] = 110;

                StartTrucking[playerid] = true;

                vehicleKeyJobs[VehicleTrunking[playerid]] = RandomKeyTruck;

                SetPlayerCheckpoint(playerid, SpawnTruckingVehicle[idx][0], SpawnTruckingVehicle[idx][1], SpawnTruckingVehicle[idx][2], 5.0);
                PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
                SetVehicleNumberPlate(VehicleTrunking[playerid], "Trucking");
                SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** Ruth Truckman ได้ยื่นกุญแจรถ 'Pony' ให้กับ %s", GetPlayerNameEx(playerid));
                PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);

                ApplyActorAnimation(Ruth_Truckman, "DEALER","shop_pay", 4.1, 0, 0, 0, 0, 0);
                ManyTruckType[VehicleTrunking[playerid]] = 5;
                EnterTruckingVehicle[playerid] = 1;

                Dialog_Show(playerid, TruckingLicense, DIALOG_STYLE_MSGBOX, "{FFFFFF}ใบสัญญาเช่ายานพาหนะ", "{FFFFFF}ชื่อยานพาหนะ: Pony\n\
                ระยะเวลาเช่า: -\n\
                ขนาดความจุ: 5 ลัง\n\
                หักค่าใช้จ่าย: 45$ ต่อลัง (30 เปอร์เซ็นต์)\n\
                {FF6347}*คุณจะเสีย $350 ต่อลังสินค้า โปรดเตรียมเงินของคุณให้เพียงพอ", "ปิด", "");
                return 1;
            }
		    case 1: // Boxvillie
		    {
                if(playerData[playerid][pTruck] < 100)
                    return SendClientMessage(playerid, COLOR_LIGHTRED, "[Trucking] ระดับความสามารของคุณนั้นยังไม่เพียงพอต่อการเช่า 'Boxvillie'");

                VehicleTrunking[playerid] = CreateVehicle(498, SpawnTruckingVehicle[idx][0], SpawnTruckingVehicle[idx][1], SpawnTruckingVehicle[idx][2], SpawnTruckingVehicle[idx][3], TruckColor, TruckColor, 600);
                vehicleFuel[VehicleTrunking[playerid]] = 110;

                StartTrucking[playerid] = true;

                vehicleKeyJobs[VehicleTrunking[playerid]] = RandomKeyTruck;

                SetPlayerCheckpoint(playerid, SpawnTruckingVehicle[idx][0], SpawnTruckingVehicle[idx][1], SpawnTruckingVehicle[idx][2], 5.0);
                PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
                SetVehicleNumberPlate(VehicleTrunking[playerid], "Trucking");
                SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** Ruth Truckman ได้ยื่นกุญแจรถ 'Boxvillie' ให้กับ %s", GetPlayerNameEx(playerid));
                PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);

                ApplyActorAnimation(Ruth_Truckman, "DEALER","shop_pay", 4.1, 0, 0, 0, 0, 0);
                ManyTruckType[VehicleTrunking[playerid]] = 8;
                EnterTruckingVehicle[playerid] = 1;

                Dialog_Show(playerid, TruckingLicense, DIALOG_STYLE_MSGBOX, "{FFFFFF}ใบสัญญาเช่ายานพาหนะ", "{FFFFFF}ชื่อยานพาหนะ: Boxvillie\n\
                ระยะเวลาเช่า: -\n\
                ขนาดความจุ: 8 ลัง\n\
                หักค่าใช้จ่าย: 45$ ต่อลัง (30 เปอร์เซ็นต์)\n\
                {FF6347}*คุณจะเสีย $350 ต่อลังสินค้า โปรดเตรียมเงินของคุณให้เพียงพอ", "ปิด", "");
                return 1;
            }
		    case 2: // Mule
		    {
                if(playerData[playerid][pTruck] < 275)
                    return SendClientMessage(playerid, COLOR_LIGHTRED, "[Trucking] ระดับความสามารของคุณนั้นยังไม่เพียงพอต่อการเช่า 'Mule'");

                VehicleTrunking[playerid] = CreateVehicle(414, SpawnTruckingVehicle[idx][0], SpawnTruckingVehicle[idx][1], SpawnTruckingVehicle[idx][2], SpawnTruckingVehicle[idx][3], TruckColor, TruckColor, 600);
                vehicleFuel[VehicleTrunking[playerid]] = 110;

                StartTrucking[playerid] = true;

                vehicleKeyJobs[VehicleTrunking[playerid]] = RandomKeyTruck;

                SetPlayerCheckpoint(playerid, SpawnTruckingVehicle[idx][0], SpawnTruckingVehicle[idx][1], SpawnTruckingVehicle[idx][2], 5.0);
                PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
                SetVehicleNumberPlate(VehicleTrunking[playerid], "Trucking");
                SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** Ruth Truckman ได้ยื่นกุญแจรถ 'Mule' ให้กับ %s", GetPlayerNameEx(playerid));
                PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);

                ApplyActorAnimation(Ruth_Truckman, "DEALER","shop_pay", 4.1, 0, 0, 0, 0, 0);
                ManyTruckType[VehicleTrunking[playerid]] = 12;
                EnterTruckingVehicle[playerid] = 1;

                Dialog_Show(playerid, TruckingLicense, DIALOG_STYLE_MSGBOX, "{FFFFFF}ใบสัญญาเช่ายานพาหนะ", "{FFFFFF}ชื่อยานพาหนะ: Mule\n\
                ระยะเวลาเช่า: -\n\
                ขนาดความจุ: 12 ลัง\n\
                หักค่าใช้จ่าย: 45$ ต่อลัง (10-30 เปอร์เซ็นต์)\n\
                {FF6347}*คุณจะเสีย $350 ต่อลังสินค้า โปรดเตรียมเงินของคุณให้เพียงพอ", "ปิด", "");
                return 1;
            }
		    case 3: // Yankee
		    {
                if(playerData[playerid][pTruck] < 500)
                    return SendClientMessage(playerid, COLOR_LIGHTRED, "[Trucking] ระดับความสามารของคุณนั้นยังไม่เพียงพอต่อการเช่า 'Yankee'");

                VehicleTrunking[playerid] = CreateVehicle(456, SpawnTruckingVehicle[idx][0], SpawnTruckingVehicle[idx][1], SpawnTruckingVehicle[idx][2], SpawnTruckingVehicle[idx][3], TruckColor, TruckColor, 600);
                vehicleFuel[VehicleTrunking[playerid]] = 110;

                StartTrucking[playerid] = true;

                vehicleKeyJobs[VehicleTrunking[playerid]] = RandomKeyTruck;

                SetPlayerCheckpoint(playerid, SpawnTruckingVehicle[idx][0], SpawnTruckingVehicle[idx][1], SpawnTruckingVehicle[idx][2], 5.0);
                PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
                SetVehicleNumberPlate(VehicleTrunking[playerid], "Trucking");
                SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** Ruth Truckman ได้ยื่นกุญแจรถ 'Yankee' ให้กับ %s", GetPlayerNameEx(playerid));
                PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);

                ApplyActorAnimation(Ruth_Truckman, "DEALER","shop_pay", 4.1, 0, 0, 0, 0, 0);
                ManyTruckType[VehicleTrunking[playerid]] = 15;
                EnterTruckingVehicle[playerid] = 1;

                Dialog_Show(playerid, TruckingLicense, DIALOG_STYLE_MSGBOX, "{FFFFFF}ใบสัญญาเช่ายานพาหนะ", "{FFFFFF}ชื่อยานพาหนะ: Yankee\n\
                ระยะเวลาเช่า: -\n\
                ขนาดความจุ: 15 ลัง\n\
                หักค่าใช้จ่าย: 45$ ต่อลัง (30 เปอร์เซ็นต์)\n\
                {FF6347}*คุณจะเสีย $350 ต่อลังสินค้า โปรดเตรียมเงินของคุณให้เพียงพอ", "ปิด", "");
                return 1;
            }
		    case 4: // Flatbed 
		    {
                if(playerData[playerid][pTruck] < 1250)
                    return SendClientMessage(playerid, COLOR_LIGHTRED, "[Trucking] ระดับความสามารของคุณนั้นยังไม่เพียงพอต่อการเช่า 'Flatbed'");

                VehicleTrunking[playerid] = CreateVehicle(455, SpawnTruckingVehicle[idx][0], SpawnTruckingVehicle[idx][1], SpawnTruckingVehicle[idx][2], SpawnTruckingVehicle[idx][3], TruckColor, TruckColor, 600);
                vehicleFuel[VehicleTrunking[playerid]] = 110;

                StartTrucking[playerid] = true;

                vehicleKeyJobs[VehicleTrunking[playerid]] = RandomKeyTruck;

                SetPlayerCheckpoint(playerid, SpawnTruckingVehicle[idx][0], SpawnTruckingVehicle[idx][1], SpawnTruckingVehicle[idx][2], 5.0);
                PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
                SetVehicleNumberPlate(VehicleTrunking[playerid], "Trucking");
                SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** Ruth Truckman ได้ยื่นกุญแจรถ 'Flatbed' ให้กับ %s", GetPlayerNameEx(playerid));
                PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);

                ApplyActorAnimation(Ruth_Truckman, "DEALER","shop_pay", 4.1, 0, 0, 0, 0, 0);
                ManyTruckType[VehicleTrunking[playerid]] = 20;
                EnterTruckingVehicle[playerid] = 1;

                Dialog_Show(playerid, TruckingLicense, DIALOG_STYLE_MSGBOX, "{FFFFFF}ใบสัญญาเช่ายานพาหนะ", "{FFFFFF}ชื่อยานพาหนะ: Flatbed\n\
                ระยะเวลาเช่า: -\n\
                ขนาดความจุ: 20 ลัง\n\
                หักค่าใช้จ่าย: 45$ ต่อลัง (30 เปอร์เซ็นต์)\n\
                {FF6347}*คุณจะเสีย $350 ต่อลังสินค้า โปรดเตรียมเงินของคุณให้เพียงพอ", "ปิด", "");
                return 1;
            }
        }
        return 1;
    }
    return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{

    return 1;
}

/*------------------------- stock -------------------------*/
stock UpdateCargoSupplierText(id)
{
	switch(id)
	{
	    case 0:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Cargo supplier]{FFFFFF}\n%d / 100", CargoSupplier[0]);
		  	UpdateDynamic3DTextLabelText(CargoSupplierText[0], COLOR_ORANGE, szQueryOutput);

			format(szQueryOutput, sizeof(szQueryOutput), "[Cargo supplier]{FFFFFF}\n%d / 100", CargoSupplier[1]);
		  	UpdateDynamic3DTextLabelText(CargoSupplierText[1], COLOR_ORANGE, szQueryOutput);
	  	}
    }
    return 1;
}
/*------------------------- stock -------------------------*/
/*------------------------- Time -------------------------*/
task CargoSupplierTimer[60000*120]()
{
	for(new i=0; i<sizeof(CargoSupplier); i++)
	{
		CargoSupplier[i] = 50;
		UpdateCargoSupplierText(i);
    }
    return 1;
}
ptask CargoSupplierTimerSecond[1000](playerid)
{
	for(new i=0; i<sizeof(CargoSupplier); i++)
	{
		//FruitApple[i] += 6;

		if(CargoSupplier[i] > 100)
		{
		    CargoSupplier[i] = 100;
		}

		if(CargoSupplier[i] < 0)
		{
		    CargoSupplier[i] = 0;
		}
		UpdateCargoSupplierText(i);
        
    }
    return 1;
}
/*------------------------- Time -------------------------*/
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
        new tmp2[287];
/* --------------------------------------------- Start --------------------------------------------- */
        if (IsPlayerInRangeOfPoint(playerid, 1.5, 2729.5442,-2451.4233,17.5937)) //Ruth Truckman
	    {   
            if(StartTrucking[playerid])
            {
                Dialog_Show(playerid, TruckingCancel, DIALOG_STYLE_MSGBOX, "{FFFFFF}Ruth Truckman", "{FF6347}*คุณได้เช่ายานพาหนะไปเรียบร้อยแล้ว ต้องการยกเลิกหรือไม่?", "ตกลง", "ยกเลิก");
                return 1;
            }

            if(Ls_DrivingLicense[0] == 50 && Ls_MotelGasViveWood[0] == 50 && Ls_STAGE25[0] == 50)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "[Trucking] สินค้ายังไม่มีคำสั่งซื้อสินค้าในขณะนี้ โปรดลองใหม่ภายหลัง...");

            Dialog_Show(playerid, Trucking, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Ruth Truckman", "ยานพาหนะ - ความจุ\tระดับ(Rank)\n\
            Pony - (5 ลัง)\tBeginner\n\
            Boxvillie - (8 ลัง)\tElementary\n\
            Mule - (12 ลัง)\tIntermediate\n\
            Yankee - (15 ลัง)\tPre-Intermediate\n\
            Flatbed - (20 ลัง)\tUpper-Intermediate\n\
            ", "เลือก", "ยกเลิก");
			
        }
/* --------------------------------------------- Start --------------------------------------------- */
/* --------------------------------------------- Cargo --------------------------------------------- */

        if (IsPlayerInRangeOfPoint(playerid, 1.0, 2801.8005,-2521.4253,13.6277) && !IsPlayerInAnyVehicle(VehicleTrunking[playerid])) //Cargo 1 supplier
	    {  
            if(StartTrucking[playerid])
            {   
                if(TruckCarry[playerid] == false)
                {
                    if(CargoSupplier[0] == 0)
                        return 1;

                    ApplyAnimation(playerid, "CARRY","LIFTUP", 4.1, 0, 0, 0, 0, 0, 1);
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                    SetPlayerAttachedObject(playerid,9,3014,6,-0.064999,0.182000,-0.271000,64.999916,13.500003,10.200014,1.000000,1.000000,1.000000);
                    GivePlayerMoneyEx(playerid, -350);
                    

                    TruckCarry[playerid] = true;
                    CargoSupplier[0] -= 1;
                    CarryTruckDrlivery[playerid] = true;

                    format(tmp2, sizeof(tmp2), "~r~-350 $");
                    GameTextForPlayer(playerid, tmp2, 1500, 4);
                    return 1;
                }
                if(TruckCarry[playerid] == true)
                {
                    ApplyAnimation(playerid, "CARRY","PUTDWN", 4.1, 0, 0, 0, 0, 0, 1);
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
                    RemovePlayerAttachedObject(playerid, 9);
                    GivePlayerMoneyEx(playerid, 350);
                    TruckCarry[playerid] = false;
                    CargoSupplier[0] += 1;
                    CarryTruckDrlivery[playerid] = false;

                    format(tmp2, sizeof(tmp2), "~g~+350 $");
                    GameTextForPlayer(playerid, tmp2, 1500, 4);
                    return 1;
                }
                return 1;
            }
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 2802.2148,-2356.5339,13.6301) && !IsPlayerInAnyVehicle(VehicleTrunking[playerid])) //Cargo 2 supplier
	    {  
            if(StartTrucking[playerid])
            {   
                if(TruckCarry[playerid] == false)
                {
                    if(CargoSupplier[1] == 0)
                        return 1;

                    ApplyAnimation(playerid, "CARRY","LIFTUP", 4.1, 0, 0, 0, 0, 0, 1);
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                    SetPlayerAttachedObject(playerid,9,3014,6,-0.064999,0.182000,-0.271000,64.999916,13.500003,10.200014,1.000000,1.000000,1.000000);
                    GivePlayerMoneyEx(playerid, -350);
                    TruckCarry[playerid] = true;
                    CargoSupplier[1] -= 1;
                    CarryTruckDrlivery[playerid] = true;

                    format(tmp2, sizeof(tmp2), "~r~-350 $");
                    GameTextForPlayer(playerid, tmp2, 1500, 4);
                    return 1;
                }
                if(TruckCarry[playerid] == true)
                {
                    ApplyAnimation(playerid, "CARRY","PUTDWN", 4.1, 0, 0, 0, 0, 0, 1);
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
                    RemovePlayerAttachedObject(playerid, 9);
                    GivePlayerMoneyEx(playerid, 350);
                    TruckCarry[playerid] = false;
                    CargoSupplier[1] += 1;
                    CarryTruckDrlivery[playerid] = false;

                    format(tmp2, sizeof(tmp2), "~g~+350 $");
                    GameTextForPlayer(playerid, tmp2, 1500, 4);
                    return 1;
                }
                return 1;
            }
        }
/* --------------------------------------------- Cargo --------------------------------------------- */
/* --------------------------------------------- Carry --------------------------------------------- */
        if(VehicleTrunking[playerid] != INVALID_VEHICLE_ID && IsPlayerNearBoot(playerid, VehicleTrunking[playerid]))
        {
            if(!IsATruckingVehicle(VehicleTrunking[playerid]))
                return 1;

            if(!VehicleTrunking[playerid])
                return 1;

            new engine, lights, alarm, doors, bonnet, boot, objective;
            GetVehicleParamsEx(VehicleTrunking[playerid], engine, lights, alarm, doors, bonnet, boot, objective);

            if(boot != VEHICLE_PARAMS_ON)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "[Trucking] Trunk ของยานพาหนะนั้นยังไม่ถูกเปิดออก สามารถ /Trunk เพื่อเปิดและปิด");

			if(CarryTruckDrlivery[playerid] == false)
			{
                if(ManyTruck[VehicleTrunking[playerid]] <= 0)
                //return SendClientMessage(playerid, COLOR_LIGHTRED, "[Trucking] ไม่สามารถยกลังสินค้าออกมาได้ เนื่องจากยานพาหนะคันนี้ไม่มีลังสินค้าอยู่ภายใน");
                    return 1;

                ApplyAnimation(playerid, "CARRY","LIFTUP105", 4.1, 0, 0, 0, 0, 0, 1);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                SetPlayerAttachedObject(playerid,9,3014,6,-0.064999,0.182000,-0.271000,64.999916,13.500003,10.200014,1.000000,1.000000,1.000000);
                
				ManyTruck[VehicleTrunking[playerid]] -= 1;
				CarryTruckDrlivery[playerid] = true;
                TruckCarry[playerid] = true;

                format(tmp2, sizeof(tmp2), "~w~%d ~g~/ ~w~%d", ManyTruck[VehicleTrunking[playerid]], ManyTruckType[VehicleTrunking[playerid]]);
                GameTextForPlayer(playerid, tmp2, 1500, 6);
                PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);
				return 1;
			}
            	    
			if(CarryTruckDrlivery[playerid] == true)
			{
                if(ManyTruck[VehicleTrunking[playerid]] == ManyTruckType[VehicleTrunking[playerid]])
                    return 1;

				ApplyAnimation(playerid, "CARRY","LIFTUP105", 4.1, 0, 0, 0, 0, 0, 1);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
				RemovePlayerAttachedObject(playerid, 9);
                PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);

				ManyTruck[VehicleTrunking[playerid]] += 1;
				CarryTruckDrlivery[playerid] = false;
                TruckCarry[playerid] = false;

                format(tmp2, sizeof(tmp2), "~w~%d ~g~/ ~w~%d", ManyTruck[VehicleTrunking[playerid]], ManyTruckType[VehicleTrunking[playerid]]);
                GameTextForPlayer(playerid, tmp2, 1500, 6);

                if(ManyTruck[VehicleTrunking[playerid]] == ManyTruckType[VehicleTrunking[playerid]])
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[Trucking] คุณได้โหลดสินค้าเต็มจำนวนแล้ว ไปยังจุดมาร์คเพื่อส่งสินค้า");
                    DeliveryTeucking(playerid);
                    return 1;
                }
				return 1;
			}
        }
/* --------------------------------------------- Carry --------------------------------------------- */
/* --------------------------------------------- END --------------------------------------------- */
        new 
            price = randomEx(455, 600);
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 595.3037,-1250.0840,18.2700)) // Driving License (Los Santos)
		{
			if(CarryTruckDrlivery[playerid] == true)
			{
                if(EnterCheckpointTrucking[playerid] == 0)
				{
                    ApplyAnimation(playerid, "CARRY","PUTDWN", 4.1, 0, 0, 0, 0, 0, 1);
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
                    RemovePlayerAttachedObject(playerid, 9);

                    CarryTruckDrlivery[playerid] = false;
                    TruckCarry[playerid] = false;
                    LosSantosCargo_DrivingLicense(0, 1);
                    playerData[playerid][pTruck] += 1;

                    format(tmp2, sizeof(tmp2), "~w~~n~Paycheck~g~+%s", FormatMoney(price));
                    GameTextForPlayer(playerid, tmp2, 2000, 3);
                    PlayerPlaySound(playerid, 1158, 0.0, 0.0, 0.0);
                    playerData[playerid][pBankMoney] += price;
                    SendClientMessageEx(playerid, COLOR_YELLOW, "[Trucking] คุณประสบความสำเร็จในการขนส่งลังสินค้า | %s ", TruckRank_GetName(playerid));

                    
                }
                return 1;

			}
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 948.8189,-916.3116,45.2138)) // Motel Gas ViveWood (Los Santos)
		{
			if(CarryTruckDrlivery[playerid] == true)
			{
                if(EnterCheckpointTrucking[playerid] == 0)
				{
                    ApplyAnimation(playerid, "CARRY","PUTDWN", 4.1, 0, 0, 0, 0, 0, 1);
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
                    RemovePlayerAttachedObject(playerid, 9);

                    CarryTruckDrlivery[playerid] = false;
                    TruckCarry[playerid] = false;
                    LosSantosCargo_MotelGasViveWood(0, 1);
                    playerData[playerid][pTruck] += 1;

                    format(tmp2, sizeof(tmp2), "~w~~n~Paycheck~g~+%s", FormatMoney(price));
                    GameTextForPlayer(playerid, tmp2, 2000, 3);
                    PlayerPlaySound(playerid, 1158, 0.0, 0.0, 0.0);
                    playerData[playerid][pBankMoney] += price;
                    SendClientMessageEx(playerid, COLOR_YELLOW, "[Trucking] คุณประสบความสำเร็จในการขนส่งลังสินค้า | %s ", TruckRank_GetName(playerid));

                    
                }
                return 1;

			}
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 752.3962,-1358.6097,17.2969)) // STAGE 25 (Los Santos)
		{
			if(CarryTruckDrlivery[playerid] == true)
			{
                if(EnterCheckpointTrucking[playerid] == 0)
				{
                    ApplyAnimation(playerid, "CARRY","PUTDWN", 4.1, 0, 0, 0, 0, 0, 1);
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
                    RemovePlayerAttachedObject(playerid, 9);

                    CarryTruckDrlivery[playerid] = false;
                    TruckCarry[playerid] = false;
                    LosSantosCargo_STAGE25(0, 1);
                    playerData[playerid][pTruck] += 1;
                    
                    format(tmp2, sizeof(tmp2), "~w~~n~Paycheck~g~+%s", FormatMoney(price));
                    GameTextForPlayer(playerid, tmp2, 2000, 3);
                    PlayerPlaySound(playerid, 1158, 0.0, 0.0, 0.0);
                    playerData[playerid][pBankMoney] += price;
                    SendClientMessageEx(playerid, COLOR_YELLOW, "[Trucking] คุณประสบความสำเร็จในการขนส่งลังสินค้า | %s ", TruckRank_GetName(playerid));

                    
                }
                return 1;

			}
			return 1;
		}
/* --------------------------------------------- END --------------------------------------------- */
    }
	if (newkeys & KEY_CROUCH && IsPlayerInAnyVehicle(playerid))
	{
        if (IsPlayerInRangeOfPoint(playerid, 20, 2719.80688, -2504.10962, 14.13560)) //Gate 1
        {
            MoveObject(TruckGate[0], 2719.8669, -2496.0296, 14.1356, 2);  
            SetTimerEx("TruckerGate", 7000, 0, "id", playerid);
            return 1;
        }
        if (IsPlayerInRangeOfPoint(playerid, 20, 2719.88501, -2405.27441, 14.11620)) //Gate 2
        {
            MoveObject(TruckGate[1], 2719.8850, -2397.3345, 14.1162, 2);  
            SetTimerEx("TruckerGate2", 7000, 0, "id", playerid);
            return 1;
        }

    }
    return 1;
}
public TruckerGate(playerid)
{
    MoveObject(TruckGate[0], 2719.80688, -2504.10962, 14.13560, 2);
}
public TruckerGate2(playerid)
{
    MoveObject(TruckGate[1], 2719.88501, -2405.27441, 14.11620, 2);
}

hook OnVehicleDeath(vehicleid, killerid)
{
    //SendClientMessage(killerid, COLOR_LIGHTRED, "[Trucking] ยานพาหนะของคุณได้รับความเสียหาย ดังนั้นการส่งสินค้าจึงถูกยกเลิก");
    
   for(new i = GetPlayerVehicleID(VehicleTrunking[killerid]); i > 1; i--)
    {
        DestroyVehicle(i);
    }
    //DestroyvehicleTrucking(killerid);
    //return 1;
}

Dialog:TruckingCancel(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        SendClientMessage(playerid, COLOR_LIGHTRED, "[Trucking] รายการจัดส่งสินค้าของคุณนั้้นถูกยกเลิกเรียบร้อย");
        DestroyvehicleTrucking(playerid);
    }
    return 1;
}
stock IsATruckingVehicle(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 413, 498, 414, 456, 455: return 1;
	}
	return 0;
}