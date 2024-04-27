#include	<YSI_Coding\y_hooks>

// ไมล์ความเร็วรถ
new PlayerText:VehicleTD[MAX_PLAYERS][14];

ShowPlayerSpeedo(playerid, bool:enable)
{
	if(enable == true)
	{
	    //new vehicleid = GetPlayerVehicleID(playerid);
		switch(playerData[playerid][pColor]) 
		{
			case 0: // Green
			{
				PlayerTextDrawColor(playerid, VehicleTD[playerid][3], 9109704);
			}
			case 1: // เทา
			{
				PlayerTextDrawColor(playerid, VehicleTD[playerid][3], 1852731135);
			}
			case 2: // สีแดง
			{
				PlayerTextDrawColor(playerid, VehicleTD[playerid][3], -16776961);
			}
			case 3: // สีแดงอ่อน
			{
				PlayerTextDrawColor(playerid, VehicleTD[playerid][3], -10270721);
			}
			case 4: // สีฟ้าอ่อน
			{
				PlayerTextDrawColor(playerid, VehicleTD[playerid][3], 1992556543);
			}
			case 5: // สีฟ้าเข้ม
			{

				PlayerTextDrawColor(playerid, VehicleTD[playerid][3], 328515583);
			}
			case 6: // สีชมพูอ่อน
			{
				PlayerTextDrawColor(playerid, VehicleTD[playerid][3], -8224001);
			}
			case 7: // สีชมพูเข้ม
			{
				PlayerTextDrawColor(playerid, VehicleTD[playerid][3], -16711681);
			}
			case 8: // สีม่วง
			{
				PlayerTextDrawColor(playerid, VehicleTD[playerid][3], -1920073729);
			}
			case 9: // สีส้ม
			{
				PlayerTextDrawColor(playerid, VehicleTD[playerid][3], -5747201);
			}
			case 10: // สีเหลือง
			{
				PlayerTextDrawColor(playerid, VehicleTD[playerid][3], -65281);
			}
		}
		for (new i; i < 14; i++)
		{
			PlayerTextDrawShow(playerid, VehicleTD[playerid][i]);
		}

		//PlayerTextDrawSetPreviewModel(playerid, WORP_CAR[playerid][0], GetVehicleModel(vehicleid));
		//PlayerTextDrawShow(playerid, WORP_CAR[playerid][0]);
	}
	else
	{
		for (new i; i < 14; i++)
		{
			PlayerTextDrawHide(playerid, VehicleTD[playerid][i]);
		}

	}
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_NO && IsPlayerInAnyVehicle(playerid))
	{
		if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SelectTextDraw(playerid, COLOR_WHITE);
		}
	}
    return 1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	// ไมล์ความเร็วรถ
	if (playertextid == VehicleTD[playerid][11]) // Engine
	{
        CancelSelectTextDraw(playerid);
	    new vehicleid = GetPlayerVehicleID(playerid);
		new Float:health;
		GetVehicleHealth(vehicleid, health);

		switch (GetEngineStatus(vehicleid))
		{
		    case false:
		    {
				if(health <= 350)
				{
					SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s พยายามสตาร์ทเครื่องยนต์ยานพาหนะ %s แต่ไม่สำเร็จ", GetPlayerNameEx(playerid), ReturnVehicleName(vehicleid));
					SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** เนื่อจากเครื่องยนต์ของยานพาหนะ ได้รับความเสียหายมากเกินไป (( %s ))", GetPlayerNameEx(playerid));
					return 1; 
				}
				
				if(GetplayerFuel[playerid] == true)
					return 1;

                PlayerTextDrawHide(playerid, VehicleTD[playerid][9]);

				PlayerTextDrawColor(playerid, VehicleTD[playerid][9], 6553855); //เขียว
                PlayerTextDrawShow(playerid, VehicleTD[playerid][9]);
			    
                SetEngineStatus(vehicleid, true);
				SetLightStatus(vehicleid, true);
                SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s สตาร์ทเครื่องยนต์ยานพาหนะ %s", GetPlayerNameEx(playerid), ReturnVehicleName(vehicleid));
			}
			case true:
			{
                PlayerTextDrawHide(playerid, VehicleTD[playerid][9]);

				PlayerTextDrawColor(playerid, VehicleTD[playerid][9], -1962934017); //แดง
                PlayerTextDrawShow(playerid, VehicleTD[playerid][9]);

			    SetEngineStatus(vehicleid, false);
				SetLightStatus(vehicleid, false);
                SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ดับเครื่องยนต์ยานพาหนะ %s", GetPlayerNameEx(playerid), ReturnVehicleName(vehicleid));
			}
		}
		CancelSelectTextDraw(playerid);
	}
	if (playertextid == VehicleTD[playerid][7]) // Lock
	{
		new
			//Msg[128],
		    id = GetNearbyVehicle(playerid);
		//new vehicleid = GetPlayerVehicleID(playerid);

	    if(IsVehicleOwner(playerid, id) || playerData[playerid][pVehicleKeys] == id || (carData[id][carFaction] >= 0 && carData[id][carFaction] == playerData[playerid][pFaction]))
		{
		    if(!carData[id][carLocked])
		    {
				carData[id][carLocked] = 1;

				GameTextForPlayer(playerid, "~r~locked", 3000, 4);
                PlayerTextDrawHide(playerid, VehicleTD[playerid][6]);
				PlayerTextDrawColor(playerid, VehicleTD[playerid][6], -1962934017); //แดง
                PlayerTextDrawShow(playerid, VehicleTD[playerid][6]);

				// format(Msg, sizeof(Msg), "** %s ได้ล็อคยานพาหนะ %s", GetPlayerNameEx(playerid), ReturnVehicleName(id));
				// SetPlayerChatBubble(playerid, Msg, COLOR_PURPLE, 10.0, 5000);
                SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ล็อคยานพาหนะ %s", GetPlayerNameEx(playerid), ReturnVehicleName(id));
			}
			else
			{
				carData[id][carLocked] = 0;

				GameTextForPlayer(playerid, "~g~Unlocked", 3000, 4);
                PlayerTextDrawHide(playerid, VehicleTD[playerid][6]);
				PlayerTextDrawColor(playerid, VehicleTD[playerid][6], 6553855); //เขียว
                PlayerTextDrawShow(playerid, VehicleTD[playerid][6]);

				// format(Msg, sizeof(Msg), "** %s ได้ปลดล็อคยานพาหนะ %s", GetPlayerNameEx(playerid), ReturnVehicleName(id));
				// SetPlayerChatBubble(playerid, Msg, COLOR_PURPLE, 10.0, 5000);
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ปลดล็อคยานพาหนะ %s", GetPlayerNameEx(playerid), ReturnVehicleName(id));
			}

			SetVehicleParams(id, VEHICLE_DOORS, carData[id][carLocked]);
	        PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);

			new query[128];
			
			mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carLocked = %d WHERE carID = %d", carData[id][carLocked], carData[id][carID]);
			mysql_tquery(g_SQL, query);
		}
		CancelSelectTextDraw(playerid);
	}
	if (playertextid == VehicleTD[playerid][10]) // >>
	{
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		Dialog_Show(playerid, Vehicle_Menu, DIALOG_STYLE_LIST, "Vehicle Menu", "{FFFFFF}- Help Command\n\
		- Light (ไฟหน้ารถ)\n\
		- Windowns (หน้าต่าง)\n\
		- Detain/Eject (ดึง/ผลัก)\n\
		", "เลือก", "ยกเลิก");
	}
    return 1;
}
Dialog:Vehicle_Menu(playerid, response, listitem, inputtext[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if(response)
	{
		switch(listitem)
		{
			case 0: //Command
			{
				CancelSelectTextDraw(playerid);
				Dialog_Show(playerid, CommandVehicles, DIALOG_STYLE_MSGBOX, "Help Command", "{FFFFFF}-", "ปิด", "");
				return 1; 
			}
			case 1: //Light
			{

				if (!IsEngineVehicle(vehicleid))
					return 1;

				if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
					return 1;

				switch (GetLightStatus(vehicleid))
				{
					case false:
					{
						SetLightStatus(vehicleid, true);
						SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้เปิดไฟหน้ารถ", GetPlayerNameEx(playerid));
					}
					case true:
					{
						SetLightStatus(vehicleid, false);
						SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ปิดไฟหน้ารถ", GetPlayerNameEx(playerid));
					}
				}
				return CancelSelectTextDraw(playerid);
			}
			case 2: // Windowns
			{
				new
					idcar = GetPlayerVehicleID(playerid),wdriver, wpassenger, wbackleft, wbackright, string[256];

				if (!IsWindowedVehicle(idcar))
					return SendClientMessage(playerid, COLOR_GREY, "คุณไม่ได้อยู่ในยานพาหนะใด ๆ ที่มีหน้าต่าง");

				GetVehicleParamsCarWindows(idcar, wdriver, wpassenger, wbackleft, wbackright);

				format(string, sizeof(string), "ฝั่งคนขับ (%s)", (wdriver) ? ("{FF0000}เลื่อนลง{FFFFFF}") : ("{1AF029}เลื่อนขึ้น{FFFFFF}"));
				format(string, sizeof(string), "%s\nฝั่งผู้โดยสาร (%s)", string, (wpassenger) ? ("{FF0000}เลื่อนลง{FFFFFF}") : ("{1AF029}เลื่อนขึ้น{FFFFFF}"));
				format(string, sizeof(string), "%s\nฝั่งเบาะหลังฝั่งซ้าย (%s)", string, (wbackleft) ? ("{FF0000}เลื่อนลง{FFFFFF}") : ("{1AF029}เลื่อนขึ้น{FFFFFF}"));
				format(string, sizeof(string), "%s\nฝั่งเบาะหลังฝั่งขวา (%s)", string, (wbackright) ? ("{FF0000}เลื่อนลง{FFFFFF}") : ("{1AF029}เลื่อนขึ้น{FFFFFF}"));

				Dialog_Show(playerid, VehicleWindows, DIALOG_STYLE_LIST, "หน้าต่างยานพาหนะ", string, "เลือก", "ออก");
				CancelSelectTextDraw(playerid);
				return 1;
			}
			case 3: //Detain
			{
				new
					string[128],
					string2[4096],
					var[15],
					count;

				foreach (new  i : Player)
				{
					if (i == playerid) continue;
					if (IsPlayerNearPlayer(playerid, i, 5.0))
					{
						format(string, sizeof(string), "(id: %d)\t%s\n", i, GetPlayerNameEx(i));
						strcat(string2, string);
						format(var, sizeof(var), "Detain%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					CancelSelectTextDraw(playerid);
					Dialog_Show(playerid, DrivingLincenseerorr, DIALOG_STYLE_LIST, "Detain","{FF6347}- ไม่พบผู้เล่นอยู่บริเวณรอบๆยานพาหนะ","ปิด","");
					return 1;
				}
				format(string, sizeof(string), " ไอดี\t    รายชื่อ\n%s", string2);
				Dialog_Show(playerid, Detain_Dialog, DIALOG_STYLE_TABLIST_HEADERS, "Detain/Eject", string, "ดึง", "ยกเลิก");
				return 1;

			}
		}
	}
	return 1;
}

Dialog:VehicleWindows(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if (response)
	{
		
		switch(listitem)
		{
		    case 0:
		    {
		        callcmd::vehwd(playerid, "driver");
			    //cmd_vehwd(playerid, "driver");
		    }
		    case 1:
		    {
		        callcmd::vehwd(playerid, "passenger");
			    //cmd_vehwd(playerid, "passenger");
		    }
		    case 2:
		    {
		        callcmd::vehwd(playerid, "backleft");
			    //cmd_vehwd(playerid, "backleft");
		    }
		    case 3:
		    {
		        callcmd::vehwd(playerid, "backright");
			    //cmd_vehwd(playerid, "backright");
		    }
		}

		callcmd::vehwd(playerid, "/");
	}
	return 1;
}

CMD:vehwd(playerid, params[])
{
    new item[16];

    new idcar = GetPlayerVehicleID(playerid);
	if (!IsWindowedVehicle(idcar)) return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้อยู่ในยานพาหนะใด ๆ ที่มีหน้าต่าง");

  	if(sscanf(params, "s[32]", item)) {
	 	SendClientMessage(playerid, COLOR_LIGHTBLUE, "การใช้งาน : {ffffff}/vehwd [รายการ]");
   		SendClientMessage(playerid, COLOR_YELLOW, "[รายการ] :{FFFFFF} driver, passenger, backleft, backright");
	}
	else
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
		new wdriver, wpassenger, wbackleft, wbackright;
		GetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, wbackright);

		if(strcmp(item, "driver", true) == 0)
		{
		    if(wdriver == VEHICLE_PARAMS_OFF)
		    {
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "หน้าต่างของรถ %s ฝั่งคนขับถูกปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], GetPlayerNameEx(playerid));
				SetVehicleParamsCarWindows(vehicleid, 1, wpassenger, wbackleft, wbackright);
			}
			else if(wdriver == VEHICLE_PARAMS_ON || wdriver == VEHICLE_PARAMS_UNSET)
			{
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "หน้าต่างของรถ %s ฝั่งคนขับถูกเปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], GetPlayerNameEx(playerid));
				SetVehicleParamsCarWindows(vehicleid, 0, wpassenger, wbackleft, wbackright);
			}
		}
		if(strcmp(item, "passenger", true) == 0)
		{
		    if(wpassenger == VEHICLE_PARAMS_OFF)
		    {
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "หน้าต่างของรถ %s ฝั่งผู้โดยสารถูกปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], GetPlayerNameEx(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, 1, wbackleft, wbackright);
			}
			else if(wpassenger == VEHICLE_PARAMS_ON || wpassenger == VEHICLE_PARAMS_UNSET)
			{
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "หน้าต่างของรถ %s ฝั่งผู้โดยสารถูกเปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], GetPlayerNameEx(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, 0, wbackleft, wbackright);
			}
		}
		if(strcmp(item, "backleft", true) == 0)
		{
      		if(wbackleft == VEHICLE_PARAMS_OFF)
		    {
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "หน้าต่างหลังซ้ายของรถ %s ถูกปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], GetPlayerNameEx(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, 1, wbackright);
			}
			else if(wbackleft == VEHICLE_PARAMS_ON || wbackleft == VEHICLE_PARAMS_UNSET)
			{
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "หน้าต่างหลังซ้ายของรถ %s ถูกเปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], GetPlayerNameEx(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, 0, wbackright);
			}
		}
		if(strcmp(item, "backright", true) == 0)
		{
		    if(wbackright == VEHICLE_PARAMS_OFF)
		    {
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "หน้าต่างหลังขวาของรถ %s ถูกปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], GetPlayerNameEx(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, 1);
			}
			else if(wbackright == VEHICLE_PARAMS_ON || wbackright == VEHICLE_PARAMS_UNSET)
			{
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "หน้าต่างหลังขวาของรถ %s ถูกเปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], GetPlayerNameEx(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, 0);
			}
		}
	}
	return 1;
}

Dialog:Detain_Dialog(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if (!response) return CancelSelectTextDraw(playerid);
	if (response)
	{
		new string[127], var[15];
		format(var, sizeof(var), "Detain%d", listitem);
		new userid = GetPVarInt(playerid, var), vehicleid = GetPlayerVehicleID(playerid);
		playerData[playerid][pAnimationID] = userid;
		/*if (userid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไม่ได้อยู่ในสถานะปกติ");*/

		if (userid == playerid)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถดำเนินการใดๆ ต่อตนเองได้");

		if (!IsPlayerNearPlayer(playerid, userid, 4.0))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไม่ได้อยู่ใกล้คุณ");

		if (GetVehicleMaxSeats(vehicleid) < 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ยานพาหนะคันนี้ไม่รองรับ");

		if (playerData[userid][pCuffed])
		{
			if (IsPlayerInVehicle(userid, vehicleid))
			{
				RemoveFromVehicle(userid);
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้เปิดประตูและผลัก %s ลงมาจากยานพาหนะ", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
			}
			else
			{
				format(string, sizeof(string), "%s\nฝั่งผู้โดยสาร (%s)", string, (GetAvailableSeat(vehicleid, 1) == 1) ? ("{FF6347}มีคนนั่งแล้ว") : ("{FFFFFF}ว่าง"));
				format(string, sizeof(string), "%s\nฝั่งเบาะหลังฝั่งซ้าย (%s)", string, (GetAvailableSeat(vehicleid, 2) == 1) ? ("{FF6347}มีคนนั่งแล้}") : ("{FFFFFF}ว่าง"));
				format(string, sizeof(string), "%s\nฝั่งเบาะหลังฝั่งขวา (%s)", string, (GetAvailableSeat(vehicleid, 3) == 1) ? ("{FF6347}มีคนนั่งแล้ว") : ("{FFFFFF}ว่าง"));

				Dialog_Show(playerid, VehicleSeat, DIALOG_STYLE_LIST, "Detain", string, "เลือก", "ออก");
				
			}
			return 1;
		}
		if (playerData[userid][pInjured] > 0)
		{
			if (IsPlayerInVehicle(userid, vehicleid))
			{
				RemoveFromVehicle(userid);
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้เปิดประตูและผลัก %s ลงมาจากยานพาหนะ", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
			}
			else
			{
				format(string, sizeof(string), "%s\nฝั่งผู้โดยสาร (%s)", string, (GetAvailableSeat(vehicleid, 1) == 1) ? ("{FF6347}มีคนนั่งแล้ว") : ("{FFFFFF}ว่าง"));
				format(string, sizeof(string), "%s\nฝั่งเบาะหลังฝั่งซ้าย (%s)", string, (GetAvailableSeat(vehicleid, 2) == 1) ? ("{FF6347}มีคนนั่งแล้}") : ("{FFFFFF}ว่าง"));
				format(string, sizeof(string), "%s\nฝั่งเบาะหลังฝั่งขวา (%s)", string, (GetAvailableSeat(vehicleid, 3) == 1) ? ("{FF6347}มีคนนั่งแล้ว") : ("{FFFFFF}ว่าง"));

				Dialog_Show(playerid, VehicleSeat, DIALOG_STYLE_LIST, "Detain", string, "เลือก", "ออก");
			
			}
			return 1;
		}
	}
	return 1;
}

Dialog:VehicleSeat(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	new userid = playerData[playerid][pAnimationID], vehicleid = GetPlayerVehicleID(playerid);
	if (!response) return CancelSelectTextDraw(playerid);
	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
				new seatid = GetAvailableSeat(vehicleid, 1);

				if (seatid == -1)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ที่นั่งฝั่งผู้โดยสารเต็มแล้ว");

				StopDragging(userid);
				PutPlayerInVehicle(userid, vehicleid, 1);
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้เปิดประตูและดึง %s ขึ้นยานพาหนะ (( ฝั่งผู้โดยสาร ))", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
				return CancelSelectTextDraw(playerid);
		    }
		    case 1:
		    {
				new seatid = GetAvailableSeat(vehicleid, 2);

				if (seatid == -1)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ที่นั่งฝั่งเบาะหลังฝั่งซ้ายเต็มแล้ว");

				StopDragging(userid);
				PutPlayerInVehicle(userid, vehicleid, 2);
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้เปิดประตูและดึง %s ขึ้นยานพาหนะ (( ฝั่งเบาะหลังฝั่งซ้าย ))", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
				return CancelSelectTextDraw(playerid);
		    }
		    case 2:
		    {
				new seatid = GetAvailableSeat(vehicleid, 3);

				if (seatid == -1)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ที่นั่งฝั่งฝั่งเบาะหลังฝั่งขวาเต็มแล้ว");

				StopDragging(userid);
				PutPlayerInVehicle(userid, vehicleid, 3);
				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้เปิดประตูและดึง %s ขึ้นยานพาหนะ (( ฝั่งเบาะหลังฝั่งขวา ))", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
				return CancelSelectTextDraw(playerid);
		    }
		}
	}
	return 1;
}















hook OnPlayerConnect(playerid)
{
	/*VehicleTD[playerid][0] = CreatePlayerTextDraw(playerid, 244.750000, 398.000000, "I");
	PlayerTextDrawFont(playerid, VehicleTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, VehicleTD[playerid][0], 22.809907, 6.249998);
	PlayerTextDrawTextSize(playerid, VehicleTD[playerid][0], 370.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, VehicleTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, VehicleTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, VehicleTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, VehicleTD[playerid][0], 180);
	PlayerTextDrawBackgroundColor(playerid, VehicleTD[playerid][0], -1);
	PlayerTextDrawBoxColor(playerid, VehicleTD[playerid][0], 0);
	PlayerTextDrawUseBox(playerid, VehicleTD[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, VehicleTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleTD[playerid][0], 0);*/

	VehicleTD[playerid][1] = CreatePlayerTextDraw(playerid, 319.750000, 412.000000, "555");
	PlayerTextDrawFont(playerid, VehicleTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, VehicleTD[playerid][1], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, VehicleTD[playerid][1], 16.500000, 100.000000);
	PlayerTextDrawSetOutline(playerid, VehicleTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, VehicleTD[playerid][1], 2);
	PlayerTextDrawAlignment(playerid, VehicleTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, VehicleTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, VehicleTD[playerid][1], 200);
	PlayerTextDrawUseBox(playerid, VehicleTD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, VehicleTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleTD[playerid][1], 0);

	VehicleTD[playerid][2] = CreatePlayerTextDraw(playerid, 269.750000, 428.000000, " IIIIIIIIIIIIIIIIII");
	PlayerTextDrawFont(playerid, VehicleTD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, VehicleTD[playerid][2], 0.509998, 1.750000);
	PlayerTextDrawTextSize(playerid, VehicleTD[playerid][2], 370.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, VehicleTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, VehicleTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, VehicleTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, VehicleTD[playerid][2], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, VehicleTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, VehicleTD[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, VehicleTD[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, VehicleTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleTD[playerid][2], 0);

	/*VehicleTD[playerid][3] = CreatePlayerTextDraw(playerid, 244.750000, 408.000000, "I");
	PlayerTextDrawFont(playerid, VehicleTD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, VehicleTD[playerid][3], 22.809907, 0.449997);
	PlayerTextDrawTextSize(playerid, VehicleTD[playerid][3], 370.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, VehicleTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, VehicleTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, VehicleTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, VehicleTD[playerid][3], 9109684);
	PlayerTextDrawBackgroundColor(playerid, VehicleTD[playerid][3], -1);
	PlayerTextDrawBoxColor(playerid, VehicleTD[playerid][3], 0);
	PlayerTextDrawUseBox(playerid, VehicleTD[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, VehicleTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleTD[playerid][3], 0);*/

	VehicleTD[playerid][4] = CreatePlayerTextDraw(playerid, 337.500000, 415.500000, "Km/h");
	PlayerTextDrawFont(playerid, VehicleTD[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, VehicleTD[playerid][4], 0.237498, 1.299998);
	PlayerTextDrawTextSize(playerid, VehicleTD[playerid][4], 16.500000, 100.000000);
	PlayerTextDrawSetOutline(playerid, VehicleTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, VehicleTD[playerid][4], 2);
	PlayerTextDrawAlignment(playerid, VehicleTD[playerid][4], 2);
	PlayerTextDrawColor(playerid, VehicleTD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, VehicleTD[playerid][4], 200);
	PlayerTextDrawUseBox(playerid, VehicleTD[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, VehicleTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleTD[playerid][4], 0);

	VehicleTD[playerid][5] = CreatePlayerTextDraw(playerid, 354.750000, 417.000000, "P");
	PlayerTextDrawFont(playerid, VehicleTD[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, VehicleTD[playerid][5], 0.258332, 1.100000);
	PlayerTextDrawTextSize(playerid, VehicleTD[playerid][5], 16.500000, 6.500000);
	PlayerTextDrawSetOutline(playerid, VehicleTD[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, VehicleTD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, VehicleTD[playerid][5], 2);
	PlayerTextDrawColor(playerid, VehicleTD[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleTD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, VehicleTD[playerid][5], 1296911741);
	PlayerTextDrawUseBox(playerid, VehicleTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, VehicleTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleTD[playerid][5], 0);

	VehicleTD[playerid][6] = CreatePlayerTextDraw(playerid, 299.000000, 415.000000, "ld_pool:ball");
	PlayerTextDrawFont(playerid, VehicleTD[playerid][6], 4);
	PlayerTextDrawLetterSize(playerid, VehicleTD[playerid][6], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleTD[playerid][6], 11.000000, 14.000000);
	PlayerTextDrawSetOutline(playerid, VehicleTD[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, VehicleTD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, VehicleTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, VehicleTD[playerid][6], -1962934017);
	PlayerTextDrawBackgroundColor(playerid, VehicleTD[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, VehicleTD[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, VehicleTD[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, VehicleTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleTD[playerid][6], 0);

	VehicleTD[playerid][7] = CreatePlayerTextDraw(playerid, 304.750000, 417.000000, "L");
	PlayerTextDrawFont(playerid, VehicleTD[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, VehicleTD[playerid][7], 0.274998, 1.100000);
	PlayerTextDrawTextSize(playerid, VehicleTD[playerid][7], 16.500000, 12.000000);
	PlayerTextDrawSetOutline(playerid, VehicleTD[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, VehicleTD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, VehicleTD[playerid][7], 2);
	PlayerTextDrawColor(playerid, VehicleTD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleTD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, VehicleTD[playerid][7], -1094795706);
	PlayerTextDrawUseBox(playerid, VehicleTD[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, VehicleTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleTD[playerid][7], 1);

	VehicleTD[playerid][8] = CreatePlayerTextDraw(playerid, 286.000000, 415.000000, "ld_pool:ball");
	PlayerTextDrawFont(playerid, VehicleTD[playerid][8], 4);
	PlayerTextDrawLetterSize(playerid, VehicleTD[playerid][8], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleTD[playerid][8], 11.000000, 14.000000);
	PlayerTextDrawSetOutline(playerid, VehicleTD[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, VehicleTD[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, VehicleTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, VehicleTD[playerid][8], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, VehicleTD[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, VehicleTD[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, VehicleTD[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, VehicleTD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleTD[playerid][8], 0);

	VehicleTD[playerid][9] = CreatePlayerTextDraw(playerid, 273.000000, 415.000000, "ld_pool:ball");
	PlayerTextDrawFont(playerid, VehicleTD[playerid][9], 4);
	PlayerTextDrawLetterSize(playerid, VehicleTD[playerid][9], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleTD[playerid][9], 11.000000, 14.000000);
	PlayerTextDrawSetOutline(playerid, VehicleTD[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, VehicleTD[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, VehicleTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, VehicleTD[playerid][9], -1962934017);
	PlayerTextDrawBackgroundColor(playerid, VehicleTD[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, VehicleTD[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, VehicleTD[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, VehicleTD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleTD[playerid][9], 0);

	VehicleTD[playerid][10] = CreatePlayerTextDraw(playerid, 364.500000, 417.000000, ">");
	PlayerTextDrawFont(playerid, VehicleTD[playerid][10], 1);
	PlayerTextDrawLetterSize(playerid, VehicleTD[playerid][10], 0.258332, 1.100000);
	PlayerTextDrawTextSize(playerid, VehicleTD[playerid][10], 11.500000, 12.000000);
	PlayerTextDrawSetOutline(playerid, VehicleTD[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, VehicleTD[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, VehicleTD[playerid][10], 2);
	PlayerTextDrawColor(playerid, VehicleTD[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleTD[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, VehicleTD[playerid][10], -1094795706);
	PlayerTextDrawUseBox(playerid, VehicleTD[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, VehicleTD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleTD[playerid][10], 1);

	VehicleTD[playerid][11] = CreatePlayerTextDraw(playerid, 278.750000, 416.500000, "E");
	PlayerTextDrawFont(playerid, VehicleTD[playerid][11], 1);
	PlayerTextDrawLetterSize(playerid, VehicleTD[playerid][11], 0.274998, 1.100000);
	PlayerTextDrawTextSize(playerid, VehicleTD[playerid][11], 16.500000, 11.500000);
	PlayerTextDrawSetOutline(playerid, VehicleTD[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, VehicleTD[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, VehicleTD[playerid][11], 2);
	PlayerTextDrawColor(playerid, VehicleTD[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleTD[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, VehicleTD[playerid][11], -1094795706);
	PlayerTextDrawUseBox(playerid, VehicleTD[playerid][11], 0);
	PlayerTextDrawSetProportional(playerid, VehicleTD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleTD[playerid][11], 1);

	VehicleTD[playerid][12] = CreatePlayerTextDraw(playerid, 291.750000, 417.000000, "F");
	PlayerTextDrawFont(playerid, VehicleTD[playerid][12], 1);
	PlayerTextDrawLetterSize(playerid, VehicleTD[playerid][12], 0.274998, 1.100000);
	PlayerTextDrawTextSize(playerid, VehicleTD[playerid][12], 16.500000, 6.500000);
	PlayerTextDrawSetOutline(playerid, VehicleTD[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, VehicleTD[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, VehicleTD[playerid][12], 2);
	PlayerTextDrawColor(playerid, VehicleTD[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleTD[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, VehicleTD[playerid][12], -1094795706);
	PlayerTextDrawUseBox(playerid, VehicleTD[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, VehicleTD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleTD[playerid][12], 0);

	VehicleTD[playerid][13] = CreatePlayerTextDraw(playerid, 269.750000, 428.000000, " IIIIIIIIIIIIIIIIII");
	PlayerTextDrawFont(playerid, VehicleTD[playerid][13], 1);
	PlayerTextDrawLetterSize(playerid, VehicleTD[playerid][13], 0.509998, 1.750000);
	PlayerTextDrawTextSize(playerid, VehicleTD[playerid][13], 370.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, VehicleTD[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, VehicleTD[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, VehicleTD[playerid][13], 1);
	PlayerTextDrawColor(playerid, VehicleTD[playerid][13], -764862721);
	PlayerTextDrawBackgroundColor(playerid, VehicleTD[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, VehicleTD[playerid][13], 50);
	PlayerTextDrawUseBox(playerid, VehicleTD[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, VehicleTD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleTD[playerid][13], 0);
}



IsVehicleSeatUsed(vehicleid, seat)
{
	foreach (new i : Player) if (IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) == seat) {
	    return 1;
	}
	return 0;
}

GetVehicleMaxSeats(vehicleid)
{
    static const g_arrMaxSeats[] = {
		4, 2, 2, 2, 4, 4, 1, 2, 2, 4, 2, 2, 2, 4, 2, 2, 4, 2, 4, 2, 4, 4, 2, 2, 2, 1, 4, 4, 4, 2,
		1, 7, 1, 2, 2, 0, 2, 7, 4, 2, 4, 1, 2, 2, 2, 4, 1, 2, 1, 0, 0, 2, 1, 1, 1, 2, 2, 2, 4, 4,
		2, 2, 2, 2, 1, 1, 4, 4, 2, 2, 4, 2, 1, 1, 2, 2, 1, 2, 2, 4, 2, 1, 4, 3, 1, 1, 1, 4, 2, 2,
		4, 2, 4, 1, 2, 2, 2, 4, 4, 2, 2, 1, 2, 2, 2, 2, 2, 4, 2, 1, 1, 2, 1, 1, 2, 2, 4, 2, 2, 1,
		1, 2, 2, 2, 2, 2, 2, 2, 2, 4, 1, 1, 1, 2, 2, 2, 2, 7, 7, 1, 4, 2, 2, 2, 2, 2, 4, 4, 2, 2,
		4, 4, 2, 1, 2, 2, 2, 2, 2, 2, 4, 4, 2, 2, 1, 2, 4, 4, 1, 0, 0, 1, 1, 2, 1, 2, 2, 1, 2, 4,
		4, 2, 4, 1, 0, 4, 2, 2, 2, 2, 0, 0, 7, 2, 2, 1, 4, 4, 4, 2, 2, 2, 2, 2, 4, 2, 0, 0, 0, 4,
		0, 0
	};
	new
	    model = GetVehicleModel(vehicleid);

	if (400 <= model <= 611)
	    return g_arrMaxSeats[model - 400];

	return 0;
}

GetAvailableSeat(vehicleid, start = 3)
{
	new seats = GetVehicleMaxSeats(vehicleid);

	for (new i = start; i < seats; i ++) if (!IsVehicleSeatUsed(vehicleid, i)) {
	    return i;
	}
	return -1;
}


RemoveFromVehicle(playerid)
{
	if (IsPlayerInAnyVehicle(playerid))
	{
		static
		    Float:fX,
	    	Float:fY,
	    	Float:fZ;

		GetPlayerPos(playerid, fX, fY, fZ);
		SetPlayerPos(playerid, fX, fY, fZ + 1.5);
	}
	return 1;
}

forward PutInsideVehicle(playerid, vehicleid);
public PutInsideVehicle(playerid, vehicleid)
{
	if (!playerData[playerid][pDrivingTest])
	    return 0;

	RemoveFromVehicle(vehicleid);
    PutPlayerInVehicle(playerid, vehicleid, 0);
    return 1;
}
