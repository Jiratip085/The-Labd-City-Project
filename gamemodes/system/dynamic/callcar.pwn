#include	<YSI_Coding\y_hooks>

#define 	MAX_CALLCAR 			(50)
enum CALLCAR_DATA {
	callcarID,
	callcarExists,
	Float:callcarPosX,
	Float:callcarPosY,
	Float:callcarPosZ,
	Text3D:callcarText3D,
	callcarPickup
};
new callcarData[MAX_CALLCAR][CALLCAR_DATA];




forward Callcar_Load();
public Callcar_Load()
{
	static
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_CALLCAR)
	{
	    callcarData[i][callcarExists] = true;

	    cache_get_value_name_int(i, "callcarID", callcarData[i][callcarID]);
	    cache_get_value_name_float(i, "callcarX", callcarData[i][callcarPosX]);
	    cache_get_value_name_float(i, "callcarY", callcarData[i][callcarPosY]);
	    cache_get_value_name_float(i, "callcarZ", callcarData[i][callcarPosZ]);

	    Callcar_Refresh(i);
	}
	printf("[SERVER]: %i Callcar were loaded from \"%s\" database...", rows, MYSQL_DATABASE);
	return 1;
}

forward OnCallcarCreated(callcarid);
public OnCallcarCreated(callcarid)
{
	if (callcarid == -1 || !callcarData[callcarid][callcarExists])
	    return 0;

	callcarData[callcarid][callcarID] = cache_insert_id();
	Callcar_Save(callcarid);

	return 1;
}
CMD:callcar(playerid, params[])
{
	static
		id = -1;

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if ((id = Callcar_Nearest(playerid)) != -1)
		return SendClientMessageEx(playerid, COLOR_YELLOW, "- คุณอยู่ใกล้ callcar id: %d", id);

	return 1;
}
Callcar_Nearest(playerid)
{
    for (new i = 0; i != MAX_CALLCAR; i ++) if (callcarData[i][callcarExists] && IsPlayerInRangeOfPoint(playerid, 4.0, callcarData[i][callcarPosX], callcarData[i][callcarPosY], callcarData[i][callcarPosZ]))
	{
		return i;
	}
	return -1;
}

Callcar_Delete(pumpid)
{
	if (pumpid != -1 && callcarData[pumpid][callcarExists])
	{
	    static
	        string[64];

        if (IsValidDynamicPickup(callcarData[pumpid][callcarPickup]))
		    DestroyDynamicPickup(callcarData[pumpid][callcarPickup]);

		if (IsValidDynamic3DTextLabel(callcarData[pumpid][callcarText3D]))
		    DestroyDynamic3DTextLabel(callcarData[pumpid][callcarText3D]);

		mysql_format(g_SQL, string, sizeof(string), "DELETE FROM `callcar` WHERE `callcarID` = '%d'", callcarData[pumpid][callcarID]);
		mysql_tquery(g_SQL, string);

		callcarData[pumpid][callcarExists] = false;
		callcarData[pumpid][callcarID] = 0;
	}
	return 1;
}

Callcar_Create(Float:x, Float:y, Float:z)
{
	for (new i = 0; i < MAX_CALLCAR; i ++) if (!callcarData[i][callcarExists])
	{
	    callcarData[i][callcarExists] = true;
	    callcarData[i][callcarPosX] = x;
	    callcarData[i][callcarPosY] = y;
	    callcarData[i][callcarPosZ] = z;

	    mysql_tquery(g_SQL, "INSERT INTO `callcar` (`callcarID`) VALUES(0)", "OnCallcarCreated", "d", i);
		Callcar_Refresh(i);
		return i;
	}
	return -1;
}

Callcar_Save(pumpid)
{
	static
	    query[220];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE `callcar` SET `callcarX` = '%.4f', `callcarY` = '%.4f', `callcarZ` = '%.4f' WHERE `callcarID` = '%d'",
	    callcarData[pumpid][callcarPosX],
	    callcarData[pumpid][callcarPosY],
	    callcarData[pumpid][callcarPosZ],
	    callcarData[pumpid][callcarID]
	);
	return mysql_tquery(g_SQL, query);
}

Callcar_Refresh(pumpid)
{
	if (pumpid != -1 && callcarData[pumpid][callcarExists])
	{
		if (IsValidDynamicPickup(callcarData[pumpid][callcarPickup]))
		    DestroyDynamicPickup(callcarData[pumpid][callcarPickup]);

		if (IsValidDynamic3DTextLabel(callcarData[pumpid][callcarText3D]))
		    DestroyDynamic3DTextLabel(callcarData[pumpid][callcarText3D]);

		callcarData[pumpid][callcarPickup] = CreateDynamicPickup(19130, 23, callcarData[pumpid][callcarPosX], callcarData[pumpid][callcarPosY], callcarData[pumpid][callcarPosZ]);
  		callcarData[pumpid][callcarText3D] = CreateDynamic3DTextLabel("[Spawn Vehicle]\n{AAAAAA}กด 'Y' เพื่อใช้งาน", COLOR_ORANGE, callcarData[pumpid][callcarPosX], callcarData[pumpid][callcarPosY], callcarData[pumpid][callcarPosZ], 7.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0);
	}
	return 1;
}

// --> การาจเรียกรถ
CMD:createcallcar(playerid, params[])
{
	static
	    id = -1,
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

    if (playerData[playerid][pAdmin] < 5)
	    return 1;

	if (GetPlayerInterior(playerid) != 0)
	    return 1;

	id = Callcar_Create(x, y, z);

	if (id == -1)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ความจุของการาจเรียกรถในฐานข้อมูลเต็มแล้ว ไม่สามารถสร้างได้อีก (ติดต่อผู้พัฒนา)");

	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้สร้างการาจเรีกยรถขึ้นมาใหม่ ไอดี: %d", id);
	return 1;
}

CMD:removecallcar(playerid, params[])
{
	static
	    id = 0;

    if (playerData[playerid][pAdmin] < 5)
	    return 1;

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, COLOR_WHITE, "การใช้งาน : /removecallcar [ไอดี]");

	if ((id < 0 || id >= MAX_CALLCAR) || !callcarData[id][callcarExists])
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไม่มีไอดีการาจเรียกรถนี้อยู่ในฐานข้อมูล");

	Callcar_Delete(id);
	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้ลบปั้มการาจเรียกรถไอดี %d ออกสำเร็จ", id);
	return 1;
}


new bool:EditVehicleHood[MAX_PLAYERS];
new bool:EditVehicleTrunk[MAX_PLAYERS];
hook OnPlayerKeyStateChange(playerid, newkeys, listitem, oldkeys)
{
	new Msg[128];
	new
		id = GetNearbyVehicle(playerid);

    if (newkeys & KEY_NO && !IsPlayerInAnyVehicle(playerid))
    {
		new FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper;
		GetVehiclePanelsDamageStatus(id, FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper);

        if(IsPlayerNearHood(playerid, id)) //hood
		{
			if(EditVehicleHood[playerid] == true)
				return 1;

			if(carData[id][carLocked])
				return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถเปิดฝากระโปรงพาหนะได้ เนื่องจากยานพาหนะถูกล็อค!");

			EditVehicleHood[playerid] = true;
			TogglePlayerControllable(playerid, 0);
			StartProgress(playerid, 15, 0, 0);
			ApplyAnimation(playerid, "INT_HOUSE","wash_up", 4.1, 0, 0, 0, 0, 0, 1);
			//SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้เปิดฝากระโปรงหลังรถ (Trunk)", GetPlayerNameEx(playerid));
			return 1;
		}
        if(IsPlayerNearBoot(playerid, id)) //trunk
		{
			if(EditVehicleTrunk[playerid] == true)
				return 1;

			if(carData[id][carLocked])
				return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถเปิดท้ายยานพาหนะได้ เนื่องจากยานพาหนะถูกล็อค!");

			EditVehicleTrunk[playerid] = true;
			TogglePlayerControllable(playerid, 0);
			StartProgress(playerid, 15, 0, 0);
			ApplyAnimation(playerid, "INT_HOUSE","wash_up", 4.1, 0, 0, 0, 0, 0, 1);
			//SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้เปิดฝากระโปรงหลังรถ (Trunk)", GetPlayerNameEx(playerid));
			return 1;
		}
		if(IsVehicleOwner(playerid, id) || playerData[playerid][pVehicleKeys] == id || (carData[id][carFaction] >= 0 && carData[id][carFaction] == playerData[playerid][pFaction]))
		{
			
			if(!carData[id][carLocked])
			{
				carData[id][carLocked] = 1;
				GameTextForPlayer(playerid, "~r~locked", 3000, 4);
				format(Msg, sizeof(Msg), "** %s ได้ล็อคยานพาหนะ", GetPlayerNameEx(playerid));
				SetPlayerChatBubble(playerid, Msg, COLOR_PURPLE, 10.0, 5000);
				// SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ล็อคยานพาหนะ %s", GetPlayerNameEx(playerid), ReturnVehicleName(id));
			}
			else
			{
				carData[id][carLocked] = 0;
				GameTextForPlayer(playerid, "~g~Unlocked", 3000, 4);
				format(Msg, sizeof(Msg), "** %s ได้ปลดล็อครถ", GetPlayerNameEx(playerid));
				SetPlayerChatBubble(playerid, Msg, COLOR_PURPLE, 10.0, 5000);
				// SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s ได้ปลดล็อครถ %s", GetPlayerNameEx(playerid), ReturnVehicleName(id));
			}

			SetVehicleParams(id, VEHICLE_DOORS, carData[id][carLocked]);
			PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
			new query[128];
			mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carLocked = %d WHERE carID = %d", carData[id][carLocked], carData[id][carID]);
			mysql_tquery(g_SQL, query);
			return 1;
		}
	}

	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
		// เรียกรถ
		if (Callcar_Nearest(playerid) != -1)
		{
			new query[128];
			PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
			mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `vehicles` WHERE `carOwnerID` = %d", playerData[playerid][pID]);
			mysql_tquery(g_SQL, query, "OnQueryFinished", "dd", playerid, THREAD_LIST_VEHICLES);
			return 1;

			//return Dialog_Show(playerid, DIALOG_CALLCAR, DIALOG_STYLE_LIST, "{FAFE07}[ Garage ]", "{E71706}[!] {ffffff}เรียกรถ\n{E71706}[!] {ffffff}เก็บรถ", "ตกลง", "ออก");
		}

	}
	if (newkeys & KEY_YES && IsPlayerInAnyVehicle(playerid))
	{
		// เก็บรถ
		if (Callcar_Nearest(playerid) != -1)
		{
			new count;

			for(new i = 1; i < MAX_VEHICLES; i ++)
			{
				if((carData[i][carID] > 0 && IsVehicleOwner(playerid, i)) && (count++ == listitem))
				{
					/*if(IsVehicleOccupied(i) && GetVehicleDriver(i) != playerid)
					{
						return SendClientMessage(playerid, COLOR_RED, "{FFFFFF}รถคันนี้ยังถูกใช้งานอยู่");
					}*/
					KillTimer(playerData[playerid][pSpeedoTimer]);
					DespawnVehicle(i);
					PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
				}
			}

		}
	}
	return 1;
}


hook OnProgressUpdate(playerid, progress, objectid)
{
    if(EditVehicleHood[playerid] == true){
        ApplyAnimation(playerid, "INT_HOUSE","wash_up", 4.1, 1, 0, 1, 0, 0, 1);
        return Y_HOOKS_BREAK_RETURN_1;
    }

    if(EditVehicleTrunk[playerid] == true){
        ApplyAnimation(playerid,"INT_HOUSE", "wash_up",4.1, 1, 0, 1, 0, 0);
        return Y_HOOKS_BREAK_RETURN_1;
    }

	return Y_HOOKS_CONTINUE_RETURN_0;
}
hook OnProgressFinish(playerid)
{
	if(EditVehicleHood[playerid] == true)
		OpenHood(playerid);

	if(EditVehicleTrunk[playerid] == true)
		OpenTrunk(playerid);

	return Y_HOOKS_CONTINUE_RETURN_0;
}
OpenHood(playerid)
{
	new
		id = GetNearbyVehicle(playerid), Msg[128],
		FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper;
	GetVehiclePanelsDamageStatus(id, FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper);

	TogglePlayerControllable(playerid, 1);
	if(IsPlayerNearHood(playerid, id)) //hood
	{
		if (!GetHoodStatus(id))
		{
			SetHoodStatus(id, true);
			GameTextForPlayer(playerid, "~g~Hood Opened", 3000, 4);
			format(Msg, sizeof(Msg), "** %s ได้เปิดฝากระโปรงหลังรถ", GetPlayerNameEx(playerid));
			SetPlayerChatBubble(playerid, Msg, COLOR_PURPLE, 10.0, 5000);
			ApplyAnimation(playerid, "RYDER","RYD_Beckon_02", 4.1, 0, 0, 0, 0, 0, 1);
		}
		else
		{
			SetHoodStatus(id, false);
			GameTextForPlayer(playerid, "~r~Hood Closed", 3000, 4);
			format(Msg, sizeof(Msg), "** %s ได้ปิดฝากระโปรงหน้ารถ", GetPlayerNameEx(playerid));
			SetPlayerChatBubble(playerid, Msg, COLOR_PURPLE, 10.0, 5000);
			ApplyAnimation(playerid, "RYDER","RYD_Beckon_03", 4.1, 0, 0, 0, 0, 0, 1);
		}
		EditVehicleHood[playerid] = false;
		PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
	}
	return 1;
}
OpenTrunk(playerid)
{
	new
		id = GetNearbyVehicle(playerid), Msg[128],
		FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper;
	GetVehiclePanelsDamageStatus(id, FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper);

	TogglePlayerControllable(playerid, 1);
	if(IsPlayerNearBoot(playerid, id)) //hood
	{
		if (!GetTrunkStatus(id))
		{
			SetTrunkStatus(id, true);
			GameTextForPlayer(playerid, "~g~Trunk Opened", 3000, 4);
			format(Msg, sizeof(Msg), "** %s ได้เปิดฝากระโปรงหลังรถ", GetPlayerNameEx(playerid));
			SetPlayerChatBubble(playerid, Msg, COLOR_PURPLE, 10.0, 5000);
			ApplyAnimation(playerid, "RYDER","RYD_Beckon_02", 4.1, 0, 0, 0, 0, 0, 1);
			//SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้เปิดฝากระโปรงหลังรถ (Trunk)", GetPlayerNameEx(playerid));
		}
		else
		{
			SetTrunkStatus(id, false);
			GameTextForPlayer(playerid, "~r~Trunk Closed", 3000, 4);
			format(Msg, sizeof(Msg), "** %s ได้ปิดฝากระโปรงหลังรถ", GetPlayerNameEx(playerid));
			SetPlayerChatBubble(playerid, Msg, COLOR_PURPLE, 10.0, 5000);
			ApplyAnimation(playerid, "RYDER","RYD_Beckon_03", 4.1, 0, 0, 0, 0, 0, 1);
			//SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ปิดฝากระโปรงหลังรถ (Trunk)", GetPlayerNameEx(playerid));
		}
		EditVehicleTrunk[playerid] = false;
		PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
	}
	return 1;
}