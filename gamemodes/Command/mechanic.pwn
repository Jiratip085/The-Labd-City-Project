#include	<YSI_Coding\y_hooks>

new CheckMec[MAX_PLAYERS] = 0;
new IdCheckMec[MAX_PLAYERS] = 0;
new playerNearSelectMec[MAX_PLAYERS][20];
new CallMec[MAX_PLAYERS];
new MecType[MAX_PLAYERS];


hook OnGameModeInit()
{
    CreateActor(50, 1068.4163,-890.4774,43.7375,88.5970);
    CreateDynamic3DTextLabel("[Color Code]\nกด 'Y' เพื่อโค๊ดดูสี", COLOR_ORANGE, 1068.4163,-890.4774,43.7375+1.1, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
}


hook OnPlayerConnect(playerid)
{
    CheckMec[playerid] = 0;
    IdCheckMec[playerid] = 0;
    CallMec[playerid] = 0;
    MecType[playerid] = 0;
}

new bool:GPSOnMec[MAX_PLAYERS];
Dialog:Dialog_NearMec(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    if(listitem != -1 && listitem != 21)
    {/*
        if (playerNearSelectMec[playerid][listitem] == playerid)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Medical-Message]: ไม่สามารถดำเนินการได้ เนื่องจากคุณไม่สามารถค้นหาตัวเองได้");
*/
        new Float:x,Float:y,Float:z;
        GetPlayerPos(playerNearSelectMec[playerid][listitem], x,y,z);
        SetPlayerCheckpoint(playerid, x,y,z, 1.5);

        IdCheckMec[playerid] = playerNearSelectMec[playerid][listitem];
        CheckMec[playerid] = 1;

        CallMec[playerNearSelectMec[playerid][listitem]] = 0;
        MecType[playerNearSelectMec[playerid][listitem]] = 0;
		GPSOnMec[playerid] = true;
        SendClientMessageEx(playerNearSelectMec[playerid][listitem], COLOR_YELLOW, "[Mechanic-Message]: (%d)%s ตอบรับเคสของคุณเรียบร้อย (ระยะทาง: %.1f m)", playerid, GetPlayerNameEx(playerid), GetPlayerDistanceFromPoint(playerid, x, y, z));
		SendFactionMessage(FACTION_MEC, COLOR_RADIO, "(( (%d) %s %s: ได้ตอบรับความช่วยเหลือของ %s ))", playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid), GetPlayerNameEx(playerNearSelectMec[playerid][listitem]));
		return true;
    }
    return 1;
}
hook OnPlayerEnterCheckpoint(playerid)
{
	if (GPSOnMec[playerid] == true)
	{
	    GPSOnMec[playerid] = false;
		ClearGPS(playerid);
		DisablePlayerCheckpoint(playerid);
		PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
	}
	return 1;
}




















hook OnPlayerKeyStateChange(playerid, newkeys, listitem, oldkeys)
{
	if (newkeys & KEY_YES && IsPlayerInAnyVehicle(playerid))
	{
        new vehicleid = GetPlayerVehicleID(playerid);

		if (Garage_Nearest(playerid) != -1)
		{
			if (GetFactionType(playerid) == FACTION_MEC)
			{
                if (!playerData[playerid][pOnDuty])
                    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถใช้เมนูเจ้าหน้าที่ได้ เนื่องจากคุณยังไม่ได้ On Duty");

				if(GetEngineStatus(vehicleid))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "[Mechanic]: โปรดดับเครื่องยนต์ของยานพาหนะ");

                PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
				Dialog_Show(playerid, DIALOG_REPAIR, DIALOG_STYLE_TABLIST, "[Edit Vehicle]", "(1) Repair\n(2) Edit Color 1\n(3) Edit Color 2\n(4) Paintjobs\n(5) Nitro\n(6) Neon\n(7) Hydraulics", "ตกลง", "กลับ");
				return 1;
			}
		}
    }
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
		if (IsPlayerInRangeOfPoint(playerid, 1.5, 1068.4163,-890.4774,43.7375)) //Color_List
		{   
            PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
			return Dialog_Show(playerid, colorlist, DIALOG_STYLE_MSGBOX, "Color List", GetVehicleColorList(), "ปิด", "");
		}
	}
    return 1;
}



// --> ระบบแต่งรถ
alias:car_tune("ช่าง")
CMD:car_tune(playerid)
{
    if (GetFactionType(playerid) != FACTION_MEC)
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ใช่ช่าง!");

	if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่มียศในการแต่ง");

	new ModelVehicle = GetVehicleModel(GetPlayerVehicleID(playerid));

	if(GetModel(ModelVehicle))
		return SendClientMessage(playerid, C_AVISO, "รถของคุณไม่สามารถแต่งได้");

	SelectTextDraw(playerid,0x708090FF);
	for(new i = 0; i < sizeof(wTuning1); i++){TextDrawShowForPlayer(playerid, wTuning1[i]);}

	return 1;
}
forward GetModel(Model);
public GetModel(Model)
{
	switch(Model){
 		case 417, 425, 430, 432, 446, 447, 448, 452, 453, 454, 460, 461, 462, 463, 464, 465, 468, 469, 471, 472, 473, 476, 481, 484, 487, 488, 493, 497, 501, 509, 510, 511, 512, 513, 521, 522, 523, 548:
   		return true;
    }
    return false;
}










Dialog:DIALOG_REPAIR(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		switch(listitem)
		{
		    case 0:
		    {
				RepairVehicle(GetPlayerVehicleID(playerid));
				SendClientMessageEx(playerid, COLOR_GREEN, "- {FFFFFF}ยานพาหนะถูกซ่อมเรียบร้อย");
			}
		    case 1:
		    {
				Dialog_Show(playerid, DIALOG_COLOR1, DIALOG_STYLE_INPUT, "[เลือกสี]", "{FFFFFF}เลือกสีที่ต้องการ 0-255 (สีที่ 1)", "ตกลง", "กลับ");
			}
		    case 2:
		    {
				Dialog_Show(playerid, DIALOG_COLOR2, DIALOG_STYLE_INPUT, "[เลือกสี]", "{FFFFFF}เลือกสีที่ต้องการ 0-255 (สีที่ 2)", "ตกลง", "ยกเลิก");
			}
			case 3:
			{
				if(GetVehicleModel(!GetPlayerVehicleID(playerid)) == 562 ||
				GetVehicleModel(!GetPlayerVehicleID(playerid)) == 565 ||
				GetVehicleModel(!GetPlayerVehicleID(playerid)) == 559 ||
				GetVehicleModel(!GetPlayerVehicleID(playerid)) == 561 ||
				GetVehicleModel(!GetPlayerVehicleID(playerid)) == 560 ||
				GetVehicleModel(!GetPlayerVehicleID(playerid)) == 575 ||
				GetVehicleModel(!GetPlayerVehicleID(playerid)) == 534 || // Broadway
				GetVehicleModel(!GetPlayerVehicleID(playerid)) == 567 ||
				GetVehicleModel(!GetPlayerVehicleID(playerid)) == 536 ||
				GetVehicleModel(!GetPlayerVehicleID(playerid)) == 535 ||
				GetVehicleModel(!GetPlayerVehicleID(playerid)) == 576 ||
				GetVehicleModel(!GetPlayerVehicleID(playerid)) == 558)
					return SendClientMessage(playerid, COLOR_RED, "- {FFFFFF}ยานพาหนะชนิดนี้ ไม่รองรับการแต่ง Paint Jobs");

				Dialog_Show(playerid, DIALOG_PAINTJOBS, DIALOG_STYLE_LIST, "[เลือกสี Paint Jobs]", "{FFFFFF}Paint Jobs 1\nPaint Jobs 2\nPaint Jobs 3\nPaint Jobs 4\nPaint Jobs 5\nPaint Jobs 6\nถอดลายออก", "ยืนยัน", "ปิด");
			}
			case 4:
			{
				Dialog_Show(playerid, DIALOG_NITRO, DIALOG_STYLE_LIST, "[เลือกระดับ Nitro]", "{FFFFFF}Nitro 2X\nNitro 5X\nNitro 10X", "ยืนยัน", "ปิด");
			}
			case 5:
			{
				Dialog_Show(playerid, DIALOG_NEON, DIALOG_STYLE_MSGBOX, "", "{FFFFFF}ระบบยังไม่พร้อมใช้งาน", "ปิด", "");
				/*if(!IsWindowsVehicle(vehicleid))
					return SendClientMessage(playerid, COLOR_RED, "- {FFFFFF}ยานพาหนะชนิดนี้ ไม่รองรับการแต่ง Neon");

				Dialog_Show(playerid, DIALOG_NEON, DIALOG_STYLE_LIST, "[เลือกสี Neon]", "{FFFFFF}สีแดง\nสีน้ำเงิน\nสีเขียว\nสีเหลือง\nสีชมพู\nสีขาว\nถอด", "ยืนยัน", "ปิด");
				return 1;*/
			}
			case 6:
			{

				if(!IsWindowsVehicle(vehicleid))
					return SendClientMessage(playerid, COLOR_RED,  "- {FFFFFF}ยานพาหนะชนิดนี้ ไม่รองรับการแต่ง Hydraulics");

				SendClientMessage(playerid, COLOR_GREEN, "- ยานพาหนะได้ติดตั้ง Hydraulics เรียบร้อย");
				AddVehicleComponent(vehicleid,1087);
				return 1;
			}
		}
	}
	return 1;
}



Dialog:DIALOG_COLOR1(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	   	new color, vehicleid = GetPlayerVehicleID(playerid), query[128];
		if (sscanf(inputtext, "d", color))
		    return Dialog_Show(playerid, DIALOG_COLOR1, DIALOG_STYLE_INPUT, "[เลือกสี]", "{FFFFFF}เลือกสีที่ต้องการ 0-255 (สีที่ 1)", "ตกลง", "กลับ");

		if (color < 0 || color > 255)
		    return Dialog_Show(playerid, DIALOG_COLOR1, DIALOG_STYLE_INPUT, "[เลือกสี]", "{FFFFFF}เลือกสีที่ต้องการ {FF0000}0-255 {FFFFFF}(สีที่ 1)", "ตกลง", "กลับ");

		playerData[playerid][pColor1] = color;
		ChangeVehicleColor(vehicleid, playerData[playerid][pColor1], playerData[playerid][pColor2]);

		if(IsVehicleOwner(playerid, vehicleid))
		{
			carData[vehicleid][carColor1] = playerData[playerid][pColor1];

			mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carColor1 = %d WHERE carID = %d", playerData[playerid][pColor1], carData[vehicleid][carID]);
			mysql_tquery(g_SQL, query);
		}
		SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะเปลี่ยนสีเรีบยร้อย");
	}
	return 1;
}
Dialog:DIALOG_COLOR2(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new color, vehicleid = GetPlayerVehicleID(playerid), query[128];
		if (sscanf(inputtext, "d", color))
		    return Dialog_Show(playerid, DIALOG_COLOR2, DIALOG_STYLE_INPUT, "[เลือกสี]", "{FFFFFF}เลือกสีที่ต้องการ 0-255 (สีที่ 2)", "ตกลง", "กลับ");

		if (color < 0 || color > 255)
		    return Dialog_Show(playerid, DIALOG_COLOR2, DIALOG_STYLE_INPUT, "[เลือกสี]", "{FFFFFF}เลือกสีที่ต้องการ {FF0000}0-255 {FFFFFF}(สีที่ 2)", "ตกลง", "กลับ");

		playerData[playerid][pColor2] = color;
		ChangeVehicleColor(vehicleid, playerData[playerid][pColor1], playerData[playerid][pColor2]);

		if(IsVehicleOwner(playerid, vehicleid))
		{
			carData[vehicleid][carColor2] = playerData[playerid][pColor2];

			mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carColor2 = %d WHERE carID = %d", playerData[playerid][pColor2], carData[vehicleid][carID]);
			mysql_tquery(g_SQL, query);
		}
		SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะเปลี่ยนสีเรีบยร้อย");
	}
	return 1;
}
Dialog:DIALOG_NITRO(playerid, response, listitem, inputtext[])
{
	new vehicleid; vehicleid = GetPlayerVehicleID(playerid);
	if(response)
	{
		switch (listitem)
		{
			case 0:
            {
				AddVehicleComponent(vehicleid,1009);
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะติดตั้ง Nitro 2X เรียบร้อย");
			}
			case 1:
            {
				AddVehicleComponent(vehicleid,1008);
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะติดตั้ง Nitro 5X เรียบร้อย");
			}
			case 2:
            {
				AddVehicleComponent(vehicleid,1010);
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะติดตั้ง Nitro 10X เรียบร้อย");
			}
		}
	}
	return 1;
}
Dialog:DIALOG_PAINTJOBS(playerid, response, listitem, inputtext[])
{
	new vehicleid; vehicleid = GetPlayerVehicleID(playerid);
	if(response)
	{
		new query[128];
		switch (listitem)
		{
			case 0:
            {
				mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carPaintjob = 0 WHERE carID = %d", carData[vehicleid][carID]);
				mysql_tquery(g_SQL, query);

				ChangeVehiclePaintjob(vehicleid, 0);
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะได้เปลี่ยนสีเป็น Paint Jobs 1 เรียบร้อย");
			}
			case 1:
            {
				mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carPaintjob = 1 WHERE carID = %d", carData[vehicleid][carID]);
				mysql_tquery(g_SQL, query);

				ChangeVehiclePaintjob(vehicleid, 1);
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะได้เปลี่ยนสีเป็น Paint Jobs 2 เรียบร้อย");
			}
			case 2:
            {
				mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carPaintjob = 2 WHERE carID = %d", carData[vehicleid][carID]);
				mysql_tquery(g_SQL, query);

				ChangeVehiclePaintjob(vehicleid, 2);
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะได้เปลี่ยนสีเป็น Paint Jobs 3 เรียบร้อย");
			}
			case 3:
            {
				mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carPaintjob = 3 WHERE carID = %d", carData[vehicleid][carID]);
				mysql_tquery(g_SQL, query);

				ChangeVehiclePaintjob(vehicleid, 3);
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะได้เปลี่ยนสีเป็น Paint Jobs 4 เรียบร้อย");
			}
			case 4:
            {
				mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carPaintjob = 4 WHERE carID = %d", carData[vehicleid][carID]);
				mysql_tquery(g_SQL, query);

				ChangeVehiclePaintjob(vehicleid, 4);
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะได้เปลี่ยนสีเป็น Paint Jobs 5 เรียบร้อย");
			}
			case 5:
            {
				mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carPaintjob = 5 WHERE carID = %d", carData[vehicleid][carID]);
				mysql_tquery(g_SQL, query);

				ChangeVehiclePaintjob(vehicleid, 5);
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะได้เปลี่ยนสีเป็น Paint Jobs 6 เรียบร้อย");
			}
			case 6:
            {
				carData[vehicleid][carPaintjob] = -1;

				mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carPaintjob = -1 WHERE carID = %d", carData[vehicleid][carID]);
				mysql_tquery(g_SQL, query);
				ChangeVehiclePaintjob(vehicleid, -1);
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะได้ถอดลาย Paint Jobs เรียบร้อย");
			}
		}
	}
	return 1;
}

Dialog:DIALOG_NEON(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		switch(listitem)
		{

			case 0:
			{
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะได้เปลี่ยนสี Neon เป็นสี Red เรียบร้อย");
				SetVehicleNeon(vehicleid, 18647);
				ReloadVehicleNeon(vehicleid);

			}
			case 1:
			{
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะได้เปลี่ยนสี Neon เป็นสี Blue เรียบร้อย");
				SetVehicleNeon(vehicleid, 18648);
				ReloadVehicleNeon(vehicleid);
			}
			case 2:
			{
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะได้เปลี่ยนสี Neon เป็นสี Green เรียบร้อย");
				SetVehicleNeon(vehicleid, 18649);
				ReloadVehicleNeon(vehicleid);
			}
			case 3:
			{	
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะได้เปลี่ยนสี Neon เป็นสี Yellow เรียบร้อย");
				SetVehicleNeon(vehicleid, 18650);
				ReloadVehicleNeon(vehicleid);
			}
			case 4:
			{
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะได้เปลี่ยนสี Neon เป็นสี Pink เรียบร้อย");
				SetVehicleNeon(vehicleid, 18651);
				ReloadVehicleNeon(vehicleid);
			}
			case 5:
			{
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะได้เปลี่ยนสี Neon เป็นสี White เรียบร้อย");
				SetVehicleNeon(vehicleid, 18652);
				ReloadVehicleNeon(vehicleid);
			}
			case 6:
			{
				if(!carData[vehicleid][carNeon])
				{
					return SendClientMessage(playerid, COLOR_RED, "- {FFFFFF}รถคันนี้ไม่มี Neon");
				}

				if(carData[vehicleid][carNeonEnabled])
				{
					DestroyDynamicObject(carData[vehicleid][carObjects][0]);
					DestroyDynamicObject(carData[vehicleid][carObjects][1]);
				}

				carData[vehicleid][carNeon] = 0;
				carData[vehicleid][carNeonEnabled] = 0;
				carData[vehicleid][carObjects][0] = INVALID_OBJECT_ID;
				carData[vehicleid][carObjects][1] = INVALID_OBJECT_ID;
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carNeon = 0, carNeonEnabled = 0 WHERE id = %d", carData[vehicleid][carID]);
				mysql_tquery(g_SQL, query);
				SendClientMessageEx(playerid, COLOR_GREEN, "- ยานพาหนะได้ถอด Neon เรียบร้อย");
				return 1;
			}

		}
	}
	return 1;
}



new const g_arrCarColors[256] = 
{
	0x000000FF, 0xF5F5F5FF, 0x2A77A1FF, 0x840410FF, 0x263739FF, 0x86446EFF, 0xD78E10FF, 0x4C75B7FF, 0xBDBEC6FF, 0x5E7072FF,
	0x46597AFF, 0x656A79FF, 0x5D7E8DFF, 0x58595AFF, 0xD6DAD6FF, 0x9CA1A3FF, 0x335F3FFF, 0x730E1AFF, 0x7B0A2AFF, 0x9F9D94FF,
	0x3B4E78FF, 0x732E3EFF, 0x691E3BFF, 0x96918CFF, 0x515459FF, 0x3F3E45FF, 0xA5A9A7FF, 0x635C5AFF, 0x3D4A68FF, 0x979592FF,
	0x421F21FF, 0x5F272BFF, 0x8494ABFF, 0x767B7CFF, 0x646464FF, 0x5A5752FF, 0x252527FF, 0x2D3A35FF, 0x93A396FF, 0x6D7A88FF,
	0x221918FF, 0x6F675FFF, 0x7C1C2AFF, 0x5F0A15FF, 0x193826FF, 0x5D1B20FF, 0x9D9872FF, 0x7A7560FF, 0x989586FF, 0xADB0B0FF,
	0x848988FF, 0x304F45FF, 0x4D6268FF, 0x162248FF, 0x272F4BFF, 0x7D6256FF, 0x9EA4ABFF, 0x9C8D71FF, 0x6D1822FF, 0x4E6881FF,
	0x9C9C98FF, 0x917347FF, 0x661C26FF, 0x949D9FFF, 0xA4A7A5FF, 0x8E8C46FF, 0x341A1EFF, 0x6A7A8CFF, 0xAAAD8EFF, 0xAB988FFF,
	0x851F2EFF, 0x6F8297FF, 0x585853FF, 0x9AA790FF, 0x601A23FF, 0x20202CFF, 0xA4A096FF, 0xAA9D84FF, 0x78222BFF, 0x0E316DFF,
	0x722A3FFF, 0x7B715EFF, 0x741D28FF, 0x1E2E32FF, 0x4D322FFF, 0x7C1B44FF, 0x2E5B20FF, 0x395A83FF, 0x6D2837FF, 0xA7A28FFF,
	0xAFB1B1FF, 0x364155FF, 0x6D6C6EFF, 0x0F6A89FF, 0x204B6BFF, 0x2B3E57FF, 0x9B9F9DFF, 0x6C8495FF, 0x4D8495FF, 0xAE9B7FFF,
	0x406C8FFF, 0x1F253BFF, 0xAB9276FF, 0x134573FF, 0x96816CFF, 0x64686AFF, 0x105082FF, 0xA19983FF, 0x385694FF, 0x525661FF,
	0x7F6956FF, 0x8C929AFF, 0x596E87FF, 0x473532FF, 0x44624FFF, 0x730A27FF, 0x223457FF, 0x640D1BFF, 0xA3ADC6FF, 0x695853FF,
	0x9B8B80FF, 0x620B1CFF, 0x5B5D5EFF, 0x624428FF, 0x731827FF, 0x1B376DFF, 0xEC6AAEFF, 0x000000FF, 0x177517FF, 0x210606FF,
	0x125478FF, 0x452A0DFF, 0x571E1EFF, 0x010701FF, 0x25225AFF, 0x2C89AAFF, 0x8A4DBDFF, 0x35963AFF, 0xB7B7B7FF, 0x464C8DFF,
	0x84888CFF, 0x817867FF, 0x817A26FF, 0x6A506FFF, 0x583E6FFF, 0x8CB972FF, 0x824F78FF, 0x6D276AFF, 0x1E1D13FF, 0x1E1306FF,
	0x1F2518FF, 0x2C4531FF, 0x1E4C99FF, 0x2E5F43FF, 0x1E9948FF, 0x1E9999FF, 0x999976FF, 0x7C8499FF, 0x992E1EFF, 0x2C1E08FF,
	0x142407FF, 0x993E4DFF, 0x1E4C99FF, 0x198181FF, 0x1A292AFF, 0x16616FFF, 0x1B6687FF, 0x6C3F99FF, 0x481A0EFF, 0x7A7399FF,
	0x746D99FF, 0x53387EFF, 0x222407FF, 0x3E190CFF, 0x46210EFF, 0x991E1EFF, 0x8D4C8DFF, 0x805B80FF, 0x7B3E7EFF, 0x3C1737FF,
	0x733517FF, 0x781818FF, 0x83341AFF, 0x8E2F1CFF, 0x7E3E53FF, 0x7C6D7CFF, 0x020C02FF, 0x072407FF, 0x163012FF, 0x16301BFF,
	0x642B4FFF, 0x368452FF, 0x999590FF, 0x818D96FF, 0x99991EFF, 0x7F994CFF, 0x839292FF, 0x788222FF, 0x2B3C99FF, 0x3A3A0BFF,
	0x8A794EFF, 0x0E1F49FF, 0x15371CFF, 0x15273AFF, 0x375775FF, 0x060820FF, 0x071326FF, 0x20394BFF, 0x2C5089FF, 0x15426CFF,
	0x103250FF, 0x241663FF, 0x692015FF, 0x8C8D94FF, 0x516013FF, 0x090F02FF, 0x8C573AFF, 0x52888EFF, 0x995C52FF, 0x99581EFF,
	0x993A63FF, 0x998F4EFF, 0x99311EFF, 0x0D1842FF, 0x521E1EFF, 0x42420DFF, 0x4C991EFF, 0x082A1DFF, 0x96821DFF, 0x197F19FF,
	0x3B141FFF, 0x745217FF, 0x893F8DFF, 0x7E1A6CFF, 0x0B370BFF, 0x27450DFF, 0x071F24FF, 0x784573FF, 0x8A653AFF, 0x732617FF,
	0x319490FF, 0x56941DFF, 0x59163DFF, 0x1B8A2FFF, 0x38160BFF, 0x041804FF, 0x355D8EFF, 0x2E3F5BFF, 0x561A28FF, 0x4E0E27FF,
	0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF
};
GetVehicleColorList()
{
    static
    	color_code[3344];

    if (color_code[0] == EOS) {
    	for(new i = 0; i < 128; i++)
    	{
    	    if(i > 0 && (i % 16) == 0) format(color_code, sizeof(color_code), "%s\n{%06x}#%03d", color_code, g_arrCarColors[i] >>> 8, i);
    	    else format(color_code, sizeof(color_code), "%s{%06x}#%03d ", color_code, g_arrCarColors[i] >>> 8, i);
    	}
    }
    return color_code;
}