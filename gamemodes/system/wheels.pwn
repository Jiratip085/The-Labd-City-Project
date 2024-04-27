#include <YSI_Coding\y_hooks>
#include <tdw_vehicle>
#include <tdw_vutils>

new Wheels_Take[MAX_PLAYERS];
new Wheels_Type[MAX_PLAYERS];
new Wheels_Right[MAX_PLAYERS][4];
new Wheels_Count[MAX_PLAYERS];
new Wheels_Car[MAX_PLAYERS];
new Wheels_Count_New[MAX_PLAYERS];

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (newkeys & KEY_NO && !IsPlayerInAnyVehicle(playerid))
    {
		// กดให้ใกล้เคียงกับที่คั่นหลอด
		if (complete_Poon[playerid] == 2)
		{
	        if (ProgressState_Poon[playerid] == 1)
	        {
	            switch (type_Poon[playerid])
	            {
	                case 1:
	                {
						new percent = 45;
						if (ProgressCount_Poon[playerid] >= percent && ProgressCount_Poon[playerid] < 55)
						{
							Wheels_Take[playerid] = 0;
							complete_Poon[playerid] = 2;
							StopProgress_Poon(playerid);
		                    Wheels_Count_New[playerid] ++;
		                    SendClientMessage(playerid, COLOR_WHITE, "คุณได้ทำการงัดล้อรถ {05F90C}สำเร็จ");
							SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนการงัดล้อรถ : {ffffff}%d/2", Wheels_Count_New[playerid]);

							if (Wheels_Count_New[playerid] == 2)
							{
							    SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้ประสบความสำเร็จในการงัดล้อรถแล้ว! {ffffff}(%d/2)", Wheels_Count_New[playerid]);

								Wheels_Take[playerid] = 2;
								complete_Poon[playerid] = 2;
								StartProgress_Poon(playerid, 500, 0, INVALID_OBJECT_ID);

								switch (type_Poon[playerid])
								{
								    case 1: PlayerTextDrawHide(playerid, Poon_Progress[playerid][0]); // 50%
								    case 2: PlayerTextDrawHide(playerid, Poon_Progress[playerid][1]); // 70%
								    case 3: PlayerTextDrawHide(playerid, Poon_Progress[playerid][2]); // 30%
								}
							}
							else
							{
								new vehicleid = Vehicle_Nearest[playerid];
								Wheels_Take[playerid] = 1;
								Wheels_Car[playerid] = vehicleid;

								new poon = random(3);
								switch (poon)
								{
								    case 0:
								    {
										type_Poon[playerid] = 1;
										complete_Poon[playerid] = 2;
										StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
										SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
										SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
									}
								    case 1:
								    {
										type_Poon[playerid] = 2;
										complete_Poon[playerid] = 2;
										StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
										SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
										SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
									}
								    case 2:
								    {
										type_Poon[playerid] = 3;
										complete_Poon[playerid] = 2;
										StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
										SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
										SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
									}
								}
							}
						}
						else
						{
						    Wheels_Take[playerid] = 0;
							take_Poon[playerid] = 0;
							Wheels_Count_New[playerid] = 0;
							StopProgress_Poon(playerid);
							ErrorMsg(playerid, "คุณล้มเหลวในการงัดล้อรถ, กรุณาลองใหม่อีกครั้งหลังจากครบ 15 นาที!");
							playerData[playerid][pWheelsCD] = 60*15;
						}
					}
	                case 2:
	                {
						new percent = 65;
						if (ProgressCount_Poon[playerid] >= percent && ProgressCount_Poon[playerid] < 75)
						{
						    Wheels_Take[playerid] = 0;
							take_Poon[playerid] = 0;
							complete_Poon[playerid] = 2;
							StopProgress_Poon(playerid);
		                    Wheels_Count_New[playerid] ++;
		                    SendClientMessage(playerid, COLOR_WHITE, "คุณได้ทำการการงัดล้อรถยนต์ {05F90C}สำเร็จ");
							SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);

							if (Wheels_Count_New[playerid] == 2)
							{
							    SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้ประสบความสำเร็จในการงัดล้อรถยนต์แล้ว! {ffffff}(%d/2)", Wheels_Count_New[playerid]);

                                Wheels_Take[playerid] = 2;
								take_Poon[playerid] = 0;
								complete_Poon[playerid] = 2;
								StartProgress_Poon(playerid, 500, 0, INVALID_OBJECT_ID);

								switch (type_Poon[playerid])
								{
								    case 1: PlayerTextDrawHide(playerid, Poon_Progress[playerid][0]); // 50%
								    case 2: PlayerTextDrawHide(playerid, Poon_Progress[playerid][1]); // 70%
								    case 3: PlayerTextDrawHide(playerid, Poon_Progress[playerid][2]); // 30%
								}

								new Float:x, Float:y, Float:z;
								GetPlayerPos(playerid, x, y, z);
								SendFactionMessageEx(FACTION_POLICE, COLOR_LIGHTBLUE, "แจ้งเบาะแส : มีผู้เล่นกำลังงัด 'ล้อรถยนต์' ตามพิกัดที่แสดงมา");
								SetFactionMarkerEx(playerid, FACTION_POLICE, x, y, z);
							}
							else
							{
								new vehicleid = Vehicle_Nearest(playerid);
								Wheels_Take[playerid] = 1;
								Wheels_Car[playerid] = vehicleid;

								new poon = random(3);
								switch (poon)
								{
								    case 0:
								    {
										type_Poon[playerid] = 1;
										complete_Poon[playerid] = 2;
										StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
										SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
										SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
									}
								    case 1:
								    {
										type_Poon[playerid] = 2;
										complete_Poon[playerid] = 2;
										StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
										SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
										SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
									}
								    case 2:
								    {
										type_Poon[playerid] = 3;
										complete_Poon[playerid] = 2;
										StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
										SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
										SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
									}
								}
							}
						}
						else
						{
						    Wheels_Take[playerid] = 0;
							take_Poon[playerid] = 0;
							Wheels_Count_New[playerid] = 0;
							StopProgress_Poon(playerid);
							ErrorMsg(playerid, "คุณล้มเหลวในการงัดล้อรถ, กรุณาลองใหม่อีกครั้งหลังจากครบ 15 นาที!");
							playerData[playerid][pWheelsCD] = 60*15;
						}
					}
	                case 3:
	                {
						new percent = 25;
						if (ProgressCount_Poon[playerid] >= percent && ProgressCount_Poon[playerid] < 35)
						{
						    Wheels_Take[playerid] = 0;
							take_Poon[playerid] = 0;
							complete_Poon[playerid] = 2;
							StopProgress_Poon(playerid);
		                    Wheels_Count_New[playerid] ++;
		                    SendClientMessage(playerid, COLOR_WHITE, "คุณได้ทำการการงัดล้อรถยนต์ {05F90C}สำเร็จ");
							SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);

							if (Wheels_Count_New[playerid] == 2)
							{
							    SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้ประสบความสำเร็จในการงัดล้อรถยนต์แล้ว! {ffffff}(%d/2)", Wheels_Count_New[playerid]);

                                Wheels_Take[playerid] = 2;
								take_Poon[playerid] = 0;
								complete_Poon[playerid] = 2;
								StartProgress_Poon(playerid, 500, 0, INVALID_OBJECT_ID);

								switch (type_Poon[playerid])
								{
								    case 1: PlayerTextDrawHide(playerid, Poon_Progress[playerid][0]); // 50%
								    case 2: PlayerTextDrawHide(playerid, Poon_Progress[playerid][1]); // 70%
								    case 3: PlayerTextDrawHide(playerid, Poon_Progress[playerid][2]); // 30%
								}

								new Float:x, Float:y, Float:z;
								GetPlayerPos(playerid, x, y, z);
								SendFactionMessageEx(FACTION_POLICE, COLOR_LIGHTBLUE, "แจ้งเบาะแส : มีผู้เล่นกำลังงัด 'ล้อรถยนต์' ตามพิกัดที่แสดงมา");
								SetFactionMarkerEx(playerid, FACTION_POLICE, x, y, z);
							}
							else
							{
								new vehicleid = Vehicle_Nearest(playerid);
								Wheels_Take[playerid] = 1;
								Wheels_Car[playerid] = vehicleid;

								new poon = random(3);
								switch (poon)
								{
								    case 0:
								    {
										type_Poon[playerid] = 1;
										complete_Poon[playerid] = 2;
										StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
										SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
										SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
									}
								    case 1:
								    {
										type_Poon[playerid] = 2;
										complete_Poon[playerid] = 2;
										StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
										SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
										SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
									}
								    case 2:
								    {
										type_Poon[playerid] = 3;
										complete_Poon[playerid] = 2;
										StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
										SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
										SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
									}
								}
							}
						}
						else
						{
						    Wheels_Take[playerid] = 0;
							take_Poon[playerid] = 0;
							Wheels_Count_New[playerid] = 0;
							StopProgress_Poon(playerid);
							ErrorMsg(playerid, "คุณล้มเหลวในการงัดล้อรถ, กรุณาลองใหม่อีกครั้งหลังจากครบ 15 นาที!");
							playerData[playerid][pWheelsCD] = 60*15;
						}
					}
				}
	        }
		}
    }
    return 1;
}

hook OnPlayerConnect(playerid)
{
    Wheels_Take[playerid] = 0;
    Wheels_Type[playerid] = 0;

	Wheels_Right[playerid][0] = 0;
	Wheels_Right[playerid][1] = 0;
	Wheels_Right[playerid][2] = 0;
	Wheels_Right[playerid][3] = 0;

    Wheels_Count[playerid] = 0;
    Wheels_Car[playerid] = -1;

   	Wheels_Count_New[playerid] = 0;
}

Dialog:DIALOG_TAKE_WHEELS(playerid, response, listitem, inputtext[])
{
    new vehicleid = Vehicle_Nearest(playerid);
	if(response)
	{
		switch(listitem)
  		{
			case 0:
			{
				new
	        		Float:fSize[3];

				GetVehicleWheelPos(vehicleid, FRONT_LEFT, fSize[0], fSize[1], fSize[2]);
				if (IsPlayerInRangeOfPoint(playerid, 1.0, fSize[0], fSize[1], fSize[2]))
				{
				    if (Wheels_Take[playerid] == 1)
				        return ErrorMsg(playerid, "คุณอยู่ระหว่างการงัดล้อ!");

				    if (Wheels_Right[playerid][0] == 1)
				        return ErrorMsg(playerid, "คุณได้ทำการงัดล้อข้างนี้ไปแล้ว!");

					Wheels_Take[playerid] = 1;
					Wheels_Type[playerid] = 1;
					Wheels_Car[playerid] = vehicleid;

					new poon = random(3);
					switch (poon)
					{
					    case 0:
					    {
							type_Poon[playerid] = 1;
							complete_Poon[playerid] = 2;
							StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
							SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
							SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
						}
					    case 1:
					    {
							type_Poon[playerid] = 2;
							complete_Poon[playerid] = 2;
							StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
							SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
							SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
						}
					    case 2:
					    {
							type_Poon[playerid] = 3;
							complete_Poon[playerid] = 2;
							StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
							SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
							SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
						}
					}
				}
				else return ErrorMsg(playerid, "คุณไม่ได้อยู่ใกล้กับล้อหน้า (ฝั่งซ้าย)");
			}
			case 1:
			{
				new
	        		Float:fSize[3];

				GetVehicleWheelPos(vehicleid, FRONT_RIGHT, fSize[0], fSize[1], fSize[2]);
				if (IsPlayerInRangeOfPoint(playerid, 1.0, fSize[0], fSize[1], fSize[2]))
				{
				    if (Wheels_Take[playerid] == 1)
				        return ErrorMsg(playerid, "คุณอยู่ระหว่างการงัดล้อ!");

				    if (Wheels_Right[playerid][1] == 1)
				        return ErrorMsg(playerid, "คุณได้ทำการงัดล้อข้างนี้ไปแล้ว!");

					Wheels_Take[playerid] = 1;
					Wheels_Type[playerid] = 2;
					Wheels_Car[playerid] = vehicleid;

					new poon = random(3);
					switch (poon)
					{
					    case 0:
					    {
							type_Poon[playerid] = 1;
							take_Poon[playerid] = 0;
							complete_Poon[playerid] = 2;
							StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
							SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
							SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
						}
					    case 1:
					    {
							type_Poon[playerid] = 2;
							take_Poon[playerid] = 0;
							complete_Poon[playerid] = 2;
							StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
							SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
							SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
						}
					    case 2:
					    {
							type_Poon[playerid] = 3;
							take_Poon[playerid] = 0;
							complete_Poon[playerid] = 2;
							StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
							SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
							SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
						}
					}
				}
				else return ErrorMsg(playerid, "คุณไม่ได้อยู่ใกล้กับล้อหน้า (ฝั่งขวา)");
			}
			case 2:
			{
				new
	        		Float:fSize[3];

				GetVehicleWheelPos(vehicleid, REAR_LEFT, fSize[0], fSize[1], fSize[2]);
				if (IsPlayerInRangeOfPoint(playerid, 1.0, fSize[0], fSize[1], fSize[2]))
				{
				    if (Wheels_Take[playerid] == 1)
				        return ErrorMsg(playerid, "คุณอยู่ระหว่างการงัดล้อ!");

				    if (Wheels_Right[playerid][2] == 1)
				        return ErrorMsg(playerid, "คุณได้ทำการงัดล้อข้างนี้ไปแล้ว!");

					Wheels_Take[playerid] = 1;
					Wheels_Type[playerid] = 3;
					Wheels_Car[playerid] = vehicleid;

					new poon = random(3);
					switch (poon)
					{
					    case 0:
					    {
							type_Poon[playerid] = 1;
							take_Poon[playerid] = 0;
							complete_Poon[playerid] = 2;
							StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
							SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
							SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
						}
					    case 1:
					    {
							type_Poon[playerid] = 2;
							take_Poon[playerid] = 0;
							complete_Poon[playerid] = 2;
							StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
							SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
							SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
						}
					    case 2:
					    {
							type_Poon[playerid] = 3;
							take_Poon[playerid] = 0;
							complete_Poon[playerid] = 2;
							StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
							SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
							SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
						}
					}
				}
				else return ErrorMsg(playerid, "คุณไม่ได้อยู่ใกล้กับล้อหลัง (ฝั่งซ้าย)");
			}
			case 3:
			{
				new
	        		Float:fSize[3];

				GetVehicleWheelPos(vehicleid, REAR_RIGTH, fSize[0], fSize[1], fSize[2]);
				if (IsPlayerInRangeOfPoint(playerid, 1.0, fSize[0], fSize[1], fSize[2]))
				{
				    if (Wheels_Take[playerid] == 1)
				        return ErrorMsg(playerid, "คุณอยู่ระหว่างการงัดล้อ!");

				    if (Wheels_Right[playerid][3] == 1)
				        return ErrorMsg(playerid, "คุณได้ทำการงัดล้อข้างนี้ไปแล้ว!");

					Wheels_Take[playerid] = 1;
					Wheels_Type[playerid] = 4;
					Wheels_Car[playerid] = vehicleid;

					new poon = random(3);
					switch (poon)
					{
					    case 0:
					    {
							type_Poon[playerid] = 1;
							take_Poon[playerid] = 0;
							complete_Poon[playerid] = 2;
							StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
							SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
							SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
						}
					    case 1:
					    {
							type_Poon[playerid] = 2;
							take_Poon[playerid] = 0;
							complete_Poon[playerid] = 2;
							StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
							SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
							SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
						}
					    case 2:
					    {
							type_Poon[playerid] = 3;
							take_Poon[playerid] = 0;
							complete_Poon[playerid] = 2;
							StartProgress_Poon(playerid, 100, 0, INVALID_OBJECT_ID);
							SendClientMessage(playerid, COLOR_RED, "งัดล้อรถยนต์: {FCB6AC}กดปุ่ม 'N' ให้ใกล้เคียงกับขีดคั่นระหว่างกลาง, ให้ครบ 2 ครั้ง");
							SendClientMessageEx(playerid, COLOR_LIGHTRED, "จำนวนครั้งการงัดล้อรถยนต์ : {ffffff}%d/2", Wheels_Count_New[playerid]);
						}
					}
				}
				else return ErrorMsg(playerid, "คุณไม่ได้อยู่ใกล้กับล้อหลัง (ฝั่งขวา)");
			}
		}
	}
	return 1;
}

hook OnProgressFinish_Poon(playerid, objectid)
{
	if (Wheels_Take[playerid] == 1)
		PlayerTake_Wheels(playerid);

	if (Wheels_Take[playerid] == 2)
		PlayerTakeWheels_Complete(playerid);

	return Y_HOOKS_CONTINUE_RETURN_0;
}

hook OnProgressUpdate_Poon(playerid, progress, objectid)
{
	if (Wheels_Take[playerid] == 1)
	{
		ApplyAnimation(playerid, "COP_AMBIENT", "COPBROWSE_LOOP", 4.1, 1, 0, 0, 1, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}
	if (Wheels_Take[playerid] == 2)
	{
		ApplyAnimation(playerid, "COP_AMBIENT", "COPBROWSE_LOOP", 4.1, 1, 0, 0, 1, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_0;
}

PlayerTake_Wheels(playerid)
{
    Wheels_Take[playerid] = 0;
    type_Poon[playerid] = 0;
    complete_Poon[playerid] = 0;
    ClearAnimations(playerid);
	Wheels_Count_New[playerid] = 0;
	ErrorMsg(playerid, "คุณล้มเหลวในการงัดล้อรถยนต์, กรุณาลองใหม่อีกครั้งหลังจากครบ 15 นาที!");
	playerData[playerid][pWheelsCD] = 60*15;
}

PlayerTakeWheels_Complete(playerid)
{
    new vehicleid = Vehicle_Nearest(playerid);

	switch (Wheels_Type[playerid])
	{
	    case 1: // ล้อหน้าฝั่งซ้าย
	    {
	        Inventory_Add(playerid, "FLWheels", 1);

	        Wheels_Count[playerid] ++ ;
	        Wheels_Right[playerid][0] = 1;
	        SendClientMessage(playerid, 0x474747FF, "|===================================================================|");
	        SendClientMessage(playerid, COLOR_LIGHTRED, "คำแนะนำ: {ffffff}งัดยางให้ครบ 4 ล้อ, จะทำให้คุณได้รับ 'ยาง + 4'");
	        SendClientMessage(playerid, COLOR_YELLOW, "ล้อที่คุณทำการงัด : {ffffff}ล้อหน้าฝั่งซ้าย");
	        SendClientMessage(playerid, 0x474747FF, "|===================================================================|");

			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s ได้งัดล้อหน้า (ฝั่งซ้าย) ของรถ %s", GetPlayerNameEx(playerid), ReturnVehicleName(vehicleid));
	    }
	    case 2: // ล้อหน้าฝั่งขวา
	    {
	        Inventory_Add(playerid, "FRWheels", 1);

	        Wheels_Count[playerid] ++ ;
	        Wheels_Right[playerid][1] = 1;
	        SendClientMessage(playerid, 0x474747FF, "|===================================================================|");
	        SendClientMessage(playerid, COLOR_LIGHTRED, "คำแนะนำ: {ffffff}งัดยางให้ครบ 4 ล้อ, จะทำให้คุณได้รับ 'ยาง + 4'");
	        SendClientMessage(playerid, COLOR_YELLOW, "ล้อที่คุณทำการงัด : {ffffff}ล้อหน้าฝั่งขวา");
	        SendClientMessage(playerid, 0x474747FF, "|===================================================================|");

			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s ได้งัดล้อหน้า (ฝั่งขวา) ของรถ %s", GetPlayerNameEx(playerid), ReturnVehicleName(vehicleid));
		}
		case 3: // ล้อหลังฝั่งซ้าย
		{
		    Inventory_Add(playerid, "RLWheels", 1);

	        Wheels_Count[playerid] ++ ;
	        Wheels_Right[playerid][2] = 1;
	        SendClientMessage(playerid, 0x474747FF, "|===================================================================|");
	        SendClientMessage(playerid, COLOR_LIGHTRED, "คำแนะนำ: {ffffff}งัดยางให้ครบ 4 ล้อ, จะทำให้คุณได้รับ 'ยาง + 4'");
	        SendClientMessage(playerid, COLOR_YELLOW, "ล้อที่คุณทำการงัด : {ffffff}ล้อหลังฝั่งซ้าย");
	        SendClientMessage(playerid, 0x474747FF, "|===================================================================|");

			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s ได้งัดล้อหลัง (ฝั่งซ้าย) ของรถ %s", GetPlayerNameEx(playerid), ReturnVehicleName(vehicleid));
		}
		case 4: // ล้อหลังฝั่งขวา
		{
		    Inventory_Add(playerid, "RRWheels", 1);

	        Wheels_Count[playerid] ++ ;
	        Wheels_Right[playerid][3] = 1;
	        SendClientMessage(playerid, 0x474747FF, "|===================================================================|");
	        SendClientMessage(playerid, COLOR_LIGHTRED, "คำแนะนำ: {ffffff}งัดยางให้ครบ 4 ล้อ, จะทำให้คุณได้รับ 'ยาง + 4'");
	        SendClientMessage(playerid, COLOR_YELLOW, "ล้อที่คุณทำการงัด : {ffffff}ล้อหลังฝั่งขวา");
	        SendClientMessage(playerid, 0x474747FF, "|===================================================================|");

			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s ได้งัดล้อหลัง (ฝั่งขวา) ของรถ %s", GetPlayerNameEx(playerid), ReturnVehicleName(vehicleid));
		}
	}

	new tires[4];

	GetVehicleDamageStatus(Wheels_Car[playerid], tires[0], tires[1], tires[2], tires[3]);
	UpdateVehicleDamageStatus(Wheels_Car[playerid], tires[0], tires[1], tires[2], 1111);

	Wheels_Count[playerid] = 0;
	Wheels_Right[playerid][0] = 0;
	Wheels_Right[playerid][1] = 0;
	Wheels_Right[playerid][2] = 0;
	Wheels_Right[playerid][3] = 0;

	Wheels_Car[playerid] = -1;

	Wheels_Take[playerid] = 0;
	Wheels_Type[playerid] = 0;
	ClearAnimations(playerid);
	TogglePlayerControllable(playerid, true);

	return 1;
}

CMD:wheels(playerid)
{
    if (playerData[playerid][pAdmin] < 1)
	    return ErrorMsg(playerid, "คุณไม่ได้รับอนุญาตให้ใช้งานคำสั่งนี้");

	SetPlayerPos(playerid, 966.2447,2160.7200,10.8203);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SendClientMessage(playerid, COLOR_WHITE, "{74F607}ริชาร์ด : {BEF98D}คุณได้วาร์ปมาที่คราฟชะแลงกับคลังเก็บของแล้ว");
	return 1;
}
