#include <YSI_Coding\y_hooks>
/*
new CheckChmMec[MAX_PLAYERS] = 0;
new IdCheckChmMec[MAX_PLAYERS] = 0;
new playerNearSelectRepair[MAX_PLAYERS][20];
new CallMechanic[MAX_PLAYERS];
new PlayerGetCarID[MAX_PLAYERS];
new On_Repair[MAX_PLAYERS] = 0;
new On_Refill[MAX_PLAYERS] = 0;


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_YES && IsPlayerInAnyVehicle(playerid))
	{
        new id = Garage_Nearest(playerid);

        if (id == -1)
            return 1;

        if(GetFactionType(playerid) == FACTION_MEC)
            return Dialog_Show(playerid, DAILOG_MENU_MECHANIC, DIALOG_STYLE_LIST, "{979797}[ ช่างซ่อมรถ | เมนูช่วยเหลือ ]", "\
            - รายชื่อผู้เรียกใช้งาน\n\
            - ซ่อมรถ\n\
            - เติมน้ำมัน\n\
			- แต่งรถ\n\
			- แต่งไฟใต้ท้องรถ", "ตกลง", "ยกเลิก");
    }
    return 1;
}

CMD:repairx(playerid)
{
    new id = -1;

    if(GetFactionType(playerid) != FACTION_MEC)
        return ErrorMsg(playerid, "คุณไม่ใช่ช่างยนต์");

    if(Inventory_Count(playerid, "Repair Kit") == 0)
        return ErrorMsg(playerid, "คุณไม่มีกล่องซ่อมรถ");

    if ((id = GetNearestVehicle(playerid)) == INVALID_VEHICLE_ID)
        return ErrorMsg(playerid, "คุณไม่ได้อยู่ใกล้รถคันไหนเลย");

    if(IsPlayerInAnyVehicle(playerid))
        return ErrorMsg(playerid, "คุณต้องไม่อยู่บนยานพาหนะ");

    if ((id = GetNearestVehicle(playerid)) != -1){

        if(!Owner_Vehicle(id))
            return ErrorMsg(playerid, "คันที่คุณจะซ่อมต้องเป็นรถที่มีเจ้าของ");

        new EngineStatus = GetEngineStatus(id);

        if (EngineStatus == 1)
            return ErrorMsg(playerid, "จำเป็นต้องดับเครื่องยนต์ก่อน");

        if (!GetHoodStatus(id))
            return ErrorMsg(playerid, "จำเป็นต้องเปิดฝากระโปรงหน้ารถ");

        id = Car_XGetID(id);
        PlayerGetCarID[playerid] = id;
    }

    if (On_Repair[playerid] == 1)
        return ErrorMsg(playerid, "คุณกำลังซ่อมอีกคันอยู่ !");

	if (!GetHoodStatus(id))
		return ErrorMsg(playerid, "จำเป็นต้องเปิดฝากระโปรงหน้ารถ");

    TogglePlayerControllable(playerid, 0);
    On_Repair[playerid] = 1;
    StartProgress(playerid, 200, 0, INVALID_OBJECT_ID);
    SetPlayerAttachedObject(playerid,7,18718,6,0.187999,0.084999,-0.882000,0.000000,0.000000,0.000000,0.811999,0.762000,0.824999);
    SetPlayerAttachedObject(playerid,8,18634,6,0.075000,0.038999,0.044000,96.899993,-102.100021,11.300000,1.000000,1.000000,1.000000);
    ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
    SendClientMessage(playerid, COLOR_YELLOW, "- คุณได้เริ่มซ่อมยานพาหนะแล้ว !");
    return 1;
}

CMD:svmc(playerid)
{
	if(GetFactionType(playerid) == FACTION_MEC)
	{
		return Dialog_Show(playerid, DAILOG_MENU_MECHANIC, DIALOG_STYLE_LIST, "{979797}[ ช่างซ่อมรถ | เมนูช่วยเหลือ ]", "\
			- รายชื่อผู้เรียกใช้งาน\n\
			- ซ่อมรถ\n\
			- เติมน้ำมัน\n\
			- แต่งรถ\n\
			- แต่งไฟใต้ท้องรถ\n\
			- ยกเลิกเคส", "ตกลง", "ปิด");
	}
	else return ErrorMsg(playerid, "สำหรับช่างซ่อมรถเท่านั้น!");
}

Dialog:DAILOG_MENU_MECHANIC(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(listitem == 0)
        {
            new
                str[1024],
                count
            ;
            foreach (new i : Player)
            {
                //if(i == playerid) continue;
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x,y,z);
                if (CallMechanic[i] == 1)
                {
                    format(str, sizeof(str), "%s (ไอดี:%d) %s\t%.1fm\n", str, i, GetPlayerNameEx(i), GetPlayerDistanceFromPoint(playerid, x, y, z));
                    playerNearSelectRepair[playerid][count] = i;
                    count++;

                    if(count == 20) break;
                }
            }
            if(!count) SendClientMessage(playerid, COLOR_RED, "ไม่พบผู้เรียกใช้งาน !");
            else Dialog_Show(playerid, Dialog_NearRepair, DIALOG_STYLE_TABLIST, "[ NearPlayer ]", str, "ตกลง", "ปิด");
        }
        if(listitem == 1)
        {
            callcmd::repairx(playerid);
        }
        if(listitem == 2)
        {
            callcmd::refillx(playerid);
        }
        if(listitem == 3)
        {
			if (playerData[playerid][pFactionRank] < 4)
			    return ErrorMsg(playerid, "สำหรับยศ 4 ขึ้นไปเท่านั้น!");

            //callcmd::tune(playerid, "\1");
        }
        if(listitem == 4)
        {
			if (playerData[playerid][pFactionRank] < 4)
			    return ErrorMsg(playerid, "สำหรับยศ 4 ขึ้นไปเท่านั้น!");

			Dialog_Show(playerid, DIALOG_NEON, DIALOG_STYLE_LIST, "{0FEB69}[ แต่งไฟใต้ท้องรถ ]", "{02B40A}+ {FFFFFF}สีแดง\n{02B40A}+ {FFFFFF}สีน้ำเงิน\n{02B40A}+ {FFFFFF}สีเขียว\n{02B40A}+ {FFFFFF}สีเหลือง\n{02B40A}+ {FFFFFF}สีชมพู\n{02B40A}+ {FFFFFF}สีขาว\n{02B40A}+ {FFFFFF}ถอด", "ยืนยัน", "ปิด");
        }
        if(listitem == 5)
        {
            new
                str[1024],
                count
            ;
            foreach (new i : Player)
            {
                //if(i == playerid) continue;
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x,y,z);
                if (CallMechanic[i] == 1)
                {
                    format(str, sizeof(str), "%s (ไอดี:%d) %s\t%.1fm\n", str, i, GetPlayerNameEx(i), GetPlayerDistanceFromPoint(playerid, x, y, z));
                    playerNearSelectRepair[playerid][count] = i;
                    count++;

                    if(count == 20) break;
                }
            }
            if(!count) SendClientMessage(playerid, COLOR_RED, "ไม่พบผู้เรียกใช้งาน !");
            else Dialog_Show(playerid, Dialog_CANCEL, DIALOG_STYLE_TABLIST, "[ ยกเลิกเคส ]", str, "ตกลง", "ปิด");
        }
    }
    return 1;
}

Dialog:Dialog_NearRepair(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    if(listitem != -1 && listitem != 21)
    {
        if (playerNearSelectRepair[playerid][listitem] == playerid)
            return ErrorMsg(playerid, "คุณไม่สามารถค้นหาตัวเองได้!");

        new Float:x,Float:y,Float:z;
        GetPlayerPos(playerNearSelectRepair[playerid][listitem], x,y,z);
        SetPlayerCheckpoint(playerid, x,y,z, 1.5);

        IdCheckChmMec[playerid] = playerNearSelectRepair[playerid][listitem];
        CheckChmMec[playerid] = 1;

        CallMechanic[playerNearSelectRepair[playerid][listitem]] = 0;

        SendClientMessageEx(playerNearSelectRepair[playerid][listitem], COLOR_YELLOW, "[!] ช่างยนต์ %s ได้ตอบรับคำช่วยเหลือจากคุณแล้ว !", GetPlayerNameEx(playerid));
        SendFactionMessageEx(FACTION_MEC, COLOR_YELLOW, "[!] {ffffff}%s ได้ตอบรับคำช่วยเหลือจาก %s", GetPlayerNameEx(playerid), GetPlayerNameEx(playerNearSelectRepair[playerid][listitem]));
        return true;
    }
    return 1;
}

Dialog:Dialog_CANCEL(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    if(listitem != -1 && listitem != 21)
    {
        if (playerNearSelectRepair[playerid][listitem] == playerid)
            return ErrorMsg(playerid, "คุณไม่สามารถยกเลิกตัวเองได้!");

        CallMechanic[playerNearSelectRepair[playerid][listitem]] = 0;

        SendClientMessageEx(playerNearSelectRepair[playerid][listitem], COLOR_LIGHTRED, "[!] ช่างยนต์ %s ได้ยกเลิกคำขอช่วยเหลือจากคุณ !", GetPlayerNameEx(playerid));
        SendFactionMessageEx(FACTION_MEC, COLOR_LIGHTRED, "[!] {ffffff}%s ได้ยกเลิกคำช่วยเหลือจาก %s", GetPlayerNameEx(playerid), GetPlayerNameEx(playerNearSelectRepair[playerid][listitem]));
        return true;
    }
    return 1;
}

CMD:refillx(playerid)
{
    new id = -1;

    if(GetFactionType(playerid) != FACTION_MEC)
        return ErrorMsg(playerid, "คุณไม่ใช่ช่างยนต์");

    if ((id = GetNearestVehicle(playerid)) == INVALID_VEHICLE_ID)
        return ErrorMsg(playerid, "คุณไม่ได้อยู่ใกล้รถคันไหนเลย");

    if(IsPlayerInAnyVehicle(playerid))
        return ErrorMsg(playerid, "คุณต้องไม่อยู่บนยานพาหนะ");

    if ((id = GetNearestVehicle(playerid)) != -1){

        if(!Owner_Vehicle(id))
            return ErrorMsg(playerid, "คันที่คุณจะเติมน้ำมันต้องมีเจ้าของ");

        new EngineStatus = GetEngineStatus(id);

        if(EngineStatus == 1)
            return ErrorMsg(playerid, "จำเป็นต้องดับเครื่องยนต์ก่อน");

        if(vehicleFuel[id] > 80.0)
            return ErrorMsg(playerid, "รถคันนี้มีน้ำมันมากพอแล้ว ไม่สามารถเติมได้อีก !");

        id = Car_XGetID(id);
        PlayerGetCarID[playerid] = id;
    }

    if(On_Refill[playerid] == 1)
        return ErrorMsg(playerid, "คุณกำลังเติมน้ำมันอยู่ !");

    TogglePlayerControllable(playerid, 0);
    On_Refill[playerid] = 1;
    StartProgress(playerid, 200, 0, INVALID_OBJECT_ID);
    ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
    SendClientMessage(playerid, COLOR_YELLOW, "- คุณได้เริ่มเติมน้ำมันแล้ว !");
    return 1;
}

Player_Refill(playerid)
{
	new vehicleid = GetNearestVehicle(playerid);

    On_Refill[playerid] = 0;
    TogglePlayerControllable(playerid, 1);
    ClearAnimations(playerid);
    SendClientMessage(playerid, COLOR_YELLOW, ">> คุณได้เติมน้ำมันเต็มถังแล้ว !!");
    new
        query[128];

    vehicleFuel[vehicleid] = 100.0;

    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carFuel = 100.0 WHERE carID = %d", carData[vehicleid][carID]);
    mysql_tquery(g_SQL, query);
}


Player_Repair(playerid)
{
    new vehicleid = GetNearestVehicle(playerid);

    On_Repair[playerid] = 0;
    TogglePlayerControllable(playerid, 1);
    ClearAnimations(playerid);
    Inventory_Remove(playerid,"Repair Kit", 1);
    RemovePlayerAttachedObject(playerid, 8);
    RemovePlayerAttachedObject(playerid, 7);
    SendClientMessage(playerid, -1, "- คุณได้เสีย 'Repair Kit' -1, จากการซ่อมยานพาหนะ ");
    SendClientMessage(playerid, COLOR_YELLOW, ">> คุณได้ซ่อมรถคันนี้เรียบร้อยแล้ว");
	//SetHoodStatus(vehicleid, true);

    new
        query[128];

    RepairVehicle(vehicleid);
    RepairVehicle(vehicleid);

    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carHealth = 1000.0 WHERE carID = %d", carData[vehicleid][carID]);
    mysql_tquery(g_SQL, query);
}

PlayerGov_Repair(playerid)
{
    new vehicleid = GetNearestVehicle(playerid);

    On_Repair[playerid] = 0;
    TogglePlayerControllable(playerid, 1);
    ClearAnimations(playerid);
    Inventory_Remove(playerid,"Repair KitGov", 1);
    RemovePlayerAttachedObject(playerid, 8);
    RemovePlayerAttachedObject(playerid, 7);
    SendClientMessage(playerid, -1, "- คุณได้เสีย 'กล่องซ่อมรถรัฐบาล' -1, จากการซ่อมยานพาหนะ ");
    SendClientMessage(playerid, COLOR_YELLOW, ">> คุณได้ซ่อมรถคันนี้เรียบร้อยแล้ว");
 //   SetHoodStatus(vehicleid, false);

    new
        query[128];

    RepairVehicle(vehicleid);
    RepairVehicle(vehicleid);

    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carHealth = 1000.0 WHERE carID = %d", carData[vehicleid][carID]);
    mysql_tquery(g_SQL, query);
}

Player_RefuelCan(playerid)
{
    new vehicleid = GetNearestVehicle(playerid);

    On_Repair[playerid] = 0;
    TogglePlayerControllable(playerid, 1);
    ClearAnimations(playerid);
    Inventory_Remove(playerid,"Fuel Can", 1);

    SendClientMessage(playerid, -1, "- คุณได้เสีย 'ถังน้ำมัน' -1, จากการเติมน้ำมัน");
    SendClientMessage(playerid, COLOR_YELLOW, ">> คุณได้เติมน้ำมันรถคันนี้เรียบร้อยแล้ว");

	vehicleFuel[vehicleid] = 100.0;
}

hook OnProgressFinish(playerid, objectid)
{
	if(On_Repair[playerid] == 1)
		Player_Repair(playerid);

	if(On_Repair[playerid] == 2)
		PlayerGov_Repair(playerid);

	if(On_Repair[playerid] == 3)
		Player_RefuelCan(playerid);

	if(On_Refill[playerid] == 1)
		Player_Refill(playerid);

	return Y_HOOKS_CONTINUE_RETURN_0;
}

hook OnProgressUpdate(playerid, progress, objectid)
{
	if(On_Repair[playerid] == 1)
	{
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}

	if(On_Repair[playerid] == 2)
	{
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}

	if(On_Repair[playerid] == 3)
	{
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}

	if(On_Refill[playerid] == 1)
	{
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}

	return Y_HOOKS_CONTINUE_RETURN_0;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if(CheckChmMec[playerid])
	{
		CheckChmMec[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
	}
	return 1;
}

Owner_Vehicle(vehicleid)
{
    foreach (new i : Player)
    {
        if(playerData[i][IsLoggedIn])
        {
            if(IsVehicleOwner(i, vehicleid))
            {
				return 1;
			}
		}
	}
	return 1;
}

Car_XGetID(vehicleid)
{
	if(IsValidVehicle(vehicleid) && Owner_Vehicle(vehicleid)) {
	    return vehicleid;
	}
	return -1;
}*/
