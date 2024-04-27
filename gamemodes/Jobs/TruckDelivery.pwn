#include	<YSI_Coding\y_hooks>
#include 	<YSI_Coding\y_timers>



new Text3D:DrivingLicenseText[1];
new Text3D:MotelGasViveWoodText[1];
new Text3D:STAGEText[1];


TruckRank_GetName(playerid)
{
    new
		TruckRankid = playerData[playerid][pTruck],
		name[48] = "None";

 	if (TruckRankid == 0)
	    return name;

 	if (TruckRankid > 0)
	{
		format(playerData[playerid][pTruckName], 48, "Beginner (%d/100 รอบ)", TruckRankid);
	}
 	if (TruckRankid >= 100)
	{
		format(playerData[playerid][pTruckName], 48, "Elementary (%d/275 รอบ)", TruckRankid);
	}
 	if (TruckRankid >= 275)
	{
	    format(playerData[playerid][pTruckName], 48, "Intermediate (%d/500 รอบ)", TruckRankid);
	}
 	if (TruckRankid >= 500)
	{
	    format(playerData[playerid][pTruckName], 48, "Pre-Intermediate (%d/1,250 รอบ)", TruckRankid);
	}
 	if (TruckRankid >= 1250)
	{
	    format(playerData[playerid][pTruckName], 48, "Upper-Intermediate (Level Max รอบ)", TruckRankid);
	}
	format(name, 48, playerData[playerid][pTruckName]);
	return name;
}

CMD:findtrucking(playerid, params[])
{
	if(StartTrucking[playerid])
	{
		if (!IsPlayerInAnyVehicle(IsATruckingVehicle(VehicleTrunking[playerid])))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Trucking] คุณต้องอยู่บนยานพาหนะ สำหรับงานขนส่งเท่านั้น");

		DeliveryTeucking(playerid);
	}
	return 1;
}

DeliveryTeucking(playerid)
{

	if(Ls_DrivingLicense[0] == 50 && Ls_MotelGasViveWood[0] == 50 && Ls_STAGE25[0] == 50)
	{
		DestroyvehicleTrucking(playerid);
		SendClientMessage(playerid, COLOR_LIGHTRED, "[Trucking] การจัดส่งของคุณถูกยกเลิกเนื่องจาก ไม่มีความต้องการสินค้าแล้ว");
        return 1;
	}

	new LS_TruckDeliver = random(100);
	switch (LS_TruckDeliver)
	{
		case 0..33: // Driving License (Los Santos)
		{

			if(Ls_DrivingLicense[0] == 50)
				return DeliveryTeucking(playerid);

			SetPlayerCheckpoint(playerid, 589.8322,-1238.0035,17.8553, 5.0); //จอดรถ
			PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
			//SetPlayerCheckpoint(playerid, 589.8322,-1238.0035,17.8553, 2.0); // ส่ง

			EnterCheckpointTrucking[playerid] = 1;
		}
		case 34..67: // Motel Gas ViveWood (Los Santos)
		{
			if(Ls_MotelGasViveWood[0] == 50)
				return DeliveryTeucking(playerid);

			SetPlayerCheckpoint(playerid, 961.8150,-936.8290,41.3615, 5.0); // จอดรถ
			PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
			//SetPlayerCheckpoint(playerid, 948.8189,-916.3116,45.2138, 2.0); // ส่ง

			EnterCheckpointTrucking[playerid] = 2;
		}
		case 68..100: // STAGE 25 (Los Santos)
		{
			if(Ls_STAGE25[0] == 50)
				return DeliveryTeucking(playerid);

			SetPlayerCheckpoint(playerid, 743.3882,-1355.5240,13.5000, 5.0); //จอดรถ
			PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
			//SetPlayerCheckpoint(playerid, 948.9383,-916.4484,45.2030, 2.0); // ส่ง

			EnterCheckpointTrucking[playerid] = 3;
		}
	}
	return 1;
}
hook OnPlayerEnterCheckpoint(playerid)
{

	if(EnterCheckpointTrucking[playerid] == 1)
	{
		DisablePlayerCheckpoint(playerid);
		EnterCheckpointTrucking[playerid] = 0;
		//return SetPlayerCheckpoint(playerid, 589.8322,-1238.0035,17.8553, 2.0);
		PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
		return 1; 
	}
	if(EnterCheckpointTrucking[playerid] == 2)
	{
		DisablePlayerCheckpoint(playerid);
		EnterCheckpointTrucking[playerid] = 0;
		//return SetPlayerCheckpoint(playerid, 948.8189,-916.3116,45.2138, 2.0);
		PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
		return 1; 
	}
	if(EnterCheckpointTrucking[playerid] == 3)
	{
		DisablePlayerCheckpoint(playerid);
		EnterCheckpointTrucking[playerid] = 0;
		return 1; 
	}
	return 1; 

}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{

	}
	return 1;
}
hook OnGameModeInit()
{
    // Driving License (Los Santos)
	CreateDynamicPickup(19198, 1, 595.3037,-1250.0840,18.2700+0.2);
    DrivingLicenseText[0] = CreateDynamic3DTextLabel("[Good Driving License]{FFFFFF}\n%d / 50", COLOR_YELLOW, 595.3037,-1250.0840,18.2700, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    // Motel Gas ViveWood (Los Santos)
	CreateDynamicPickup(19198, 1, 948.8189,-916.3116,45.2138+0.3);
    MotelGasViveWoodText[0] = CreateDynamic3DTextLabel("[Good Motel Gas ViveWood]{FFFFFF}\n%d / 50", COLOR_YELLOW, 948.8189,-916.3116,45.2138, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    // STAGE 25 (Los Santos)
	CreateDynamicPickup(19198, 1, 752.3962,-1358.6097,17.2969+0.2);
    STAGEText[0] = CreateDynamic3DTextLabel("[Good STAGE 25]{FFFFFF}\n%d / 50", COLOR_YELLOW, 752.3962,-1358.6097,17.2969, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    
	for(new i=0; i<sizeof(Ls_DrivingLicense); i++) // Driving License (Los Santos)
	{
		Ls_DrivingLicense[i] = 0;
		UpdateTruckSupplierTextGDL(i);
    }
	for(new i=0; i<sizeof(Ls_MotelGasViveWood); i++) // Motel Gas ViveWood (Los Santos)
	{
		UpdateTruckSupplierTextGMG(i);
		Ls_MotelGasViveWood[i] = 0;
    }
	for(new i=0; i<sizeof(Ls_STAGE25); i++) // STAGE 25 (Los Santos)
	{
		Ls_STAGE25[i] = 0;
		UpdateTruckSupplierTextGS(i);
		
    }
}

LosSantosCargo_DrivingLicense(id, amount) 
{
	Ls_DrivingLicense[id] += amount;

	for(new i=0; i<sizeof(Ls_DrivingLicense); i++) // Motel Gas ViveWood (Los Santos)
		return UpdateTruckSupplierTextGDL(i);
	return 1;
}
LosSantosCargo_MotelGasViveWood(id, amount) 
{
	Ls_MotelGasViveWood[id] += amount;

	for(new i=0; i<sizeof(Ls_MotelGasViveWood); i++) // Driving License (Los Santos)
		return UpdateTruckSupplierTextGDL(i);
	return 1;
}
LosSantosCargo_STAGE25(id, amount) 
{
	Ls_STAGE25[id] += amount;

	for(new i=0; i<sizeof(Ls_STAGE25); i++) // STAGE 25 (Los Santos)
		return UpdateTruckSupplierTextGDL(i);
	return 1;
}
/*------------------------- stock -------------------------*/
stock UpdateTruckSupplierTextGDL(id)
{
	switch(id)
	{
	    case 0:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Good Driving License]{FFFFFF}\n%d / 50", Ls_DrivingLicense[0]);
		  	UpdateDynamic3DTextLabelText(DrivingLicenseText[0], COLOR_YELLOW, szQueryOutput);
	  	}
    }
    return 1;
}
stock UpdateTruckSupplierTextGMG(id)
{
	switch(id)
	{
	    case 0:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Good Motel GasViveWood]{FFFFFF}\n%d / 50", Ls_MotelGasViveWood[0]);
		  	UpdateDynamic3DTextLabelText(MotelGasViveWoodText[0], COLOR_YELLOW, szQueryOutput);
	  	}
    }
    return 1;
}
stock UpdateTruckSupplierTextGS(id)
{
	switch(id)
	{
	    case 0:
	    {
			format(szQueryOutput, sizeof(szQueryOutput), "[Good STAGE 25]{FFFFFF}\n%d / 50", Ls_STAGE25[0]);
		  	UpdateDynamic3DTextLabelText(STAGEText[0], COLOR_YELLOW, szQueryOutput);
	  	}
    }
    return 1;
}
/*------------------------- stock -------------------------*/
/*------------------------- Time -------------------------*/
task LS_SupplierTimer[60000*60]()
{
	for(new i=0; i<sizeof(Ls_DrivingLicense); i++) // Driving License (Los Santos)
	{
		Ls_DrivingLicense[i] = 50;
		UpdateTruckSupplierTextGDL(i);
    }
	for(new i=0; i<sizeof(Ls_MotelGasViveWood); i++) // Motel Gas ViveWood (Los Santos)
	{
		Ls_MotelGasViveWood[i] = 50;
		UpdateTruckSupplierTextGMG(i);
    }
	for(new i=0; i<sizeof(Ls_STAGE25); i++) // Motel Gas ViveWood (Los Santos)
	{
		Ls_STAGE25[i] = 50;
		UpdateTruckSupplierTextGS(i);
    }
	
    return 1;
}
/* */
ptask LS_SupplierTimerSecond[1000](playerid)
{
	for(new i=0; i<sizeof(Ls_DrivingLicense); i++) // Driving License (Los Santos)
	{
		if(Ls_DrivingLicense[i] > 50)
		{
		    Ls_DrivingLicense[i] = 50;
		}

		if(Ls_DrivingLicense[i] < 0)
		{
		    Ls_DrivingLicense[i] = 0;
		}
		UpdateTruckSupplierTextGDL(i);
    }
	for(new i=0; i<sizeof(Ls_MotelGasViveWood); i++) // Motel Gas ViveWood (Los Santos)
	{
		if(Ls_MotelGasViveWood[i] > 50)
		{
		    Ls_MotelGasViveWood[i] = 50;
		}

		if(Ls_MotelGasViveWood[i] < 0)
		{
		    Ls_MotelGasViveWood[i] = 0;
		}
		UpdateTruckSupplierTextGMG(i);
    }
	for(new i=0; i<sizeof(Ls_STAGE25); i++) // Motel Gas ViveWood (Los Santos)
	{
		if(Ls_STAGE25[i] > 50)
		{
		    Ls_STAGE25[i] = 50;
		}

		if(Ls_STAGE25[i] < 0)
		{
		    Ls_STAGE25[i] = 0;
		}
		UpdateTruckSupplierTextGS(i);
    }

    return 1;
}
/*------------------------- Time -------------------------*/

