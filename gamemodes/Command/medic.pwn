#include	<YSI_Coding\y_hooks>

new CheckMedic[MAX_PLAYERS] = 0;
new IdCheckMedic[MAX_PLAYERS] = 0;
new playerNearSelectMedic[MAX_PLAYERS][20];
new CallMedic[MAX_PLAYERS];
new MedicType[MAX_PLAYERS];

/*
new playerNearSelectCpr[MAX_PLAYERS][20];
new InjuredID[MAX_PLAYERS];
new InjuredCallMedic[MAX_PLAYERS] = 0;
new InjuredCallMedicEx[MAX_PLAYERS] = 0;*/



hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new targetplayer = GetPlayerTargetPlayer(playerid);
	
	if (newkeys & KEY_HANDBRAKE && targetplayer != INVALID_PLAYER_ID && newkeys & KEY_NO && IsPlayerNearPlayer(playerid, targetplayer, 3.0))
	{
		if (GetFactionType(playerid) == FACTION_MEDIC) //เป็นหมอ
		{

			Dialog_Show(playerid, MEDIC_MENU, DIALOG_STYLE_LIST, "เมนูเจ้าหน้าที่ 'แพทย์'", "{FFFFFF}ชื่อ: %s\n\
			- Heal (ชุป/รักษา)\n\
			- Drag (ลาก/ปล่อยลาก)\
			", "เลือก", "ยกเลิก", GetPlayerNameEx(targetplayer));
		}
		playerData[playerid][pFactionMenuID] = targetplayer;
	}
    if (newkeys & KEY_NO && !IsPlayerInAnyVehicle(playerid))
	{
		if(playerData[playerid][pInjured] == 1)
		{
			if(CallMedic[playerid] >= 1)
				return SendClientMessage(playerid, COLOR_LIGHTRED, "[Medical-Message]: คุณได้เรียกหมอเรียบร้อยแล้ว กรุณารอการตอบกลับ");

			SendClientMessage(playerid, COLOR_YELLOW, "[Medical-Message]: คุณได้ขอความช่วยเหลือเรียบร้อย กรุณารอการตอบกลับ");
			CallMedic[playerid] = 1;
			SendFactionMessageEx(FACTION_MEDIC, COLOR_RADIO, "(( [HQ] Medical-Message: มีเหตุแจ้งแจ้งเตือนเข้ามา, สามารถ /mdc เพื่อตอบรับ ))");
		}
	}
	return 1;
}
Dialog:MEDIC_MENU(playerid, response, listitem, inputtext[])
{
	new targetplayer = playerData[playerid][pFactionMenuID];
	if (response)
	{
		PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
		switch(listitem)
		{
			case 1: // ชุบ ฮีล
			{

				if (targetplayer == INVALID_PLAYER_ID)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไม่ได้อยู่ในสถานะปกติ");

				if (targetplayer == playerid)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถดำเนินการใดๆ ต่อตนเองได้");

				if (GetPlayerState(targetplayer) != PLAYER_STATE_ONFOOT)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นต้องไม่อยู่บนยานพาหนะ");

				if (!IsPlayerNearPlayer(playerid, targetplayer, 5.0))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไม่ได้อยู่ใกล้คุณ");

				if (!Inventory_HasItem(playerid, "MedicCase"))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณไม่มี 'MedicCase' สำหรับการ ชุป/รักษา");

                Dialog_Show(playerid, MEDIC_HEAL, DIALOG_STYLE_INPUT, "Heal (ชุป/รักษา)", "โปรดระบุจำนวนเงินที่คุณต้องการจะใส่ในบิล :", "ตกลง", "ยกเลิก");
                return 1;
			}
			case 2: // drag
			{
				if (targetplayer == INVALID_PLAYER_ID)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไม่ได้อยู่ในสถานะปกติ");

				if (targetplayer == playerid)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถดำเนินการใดๆ ต่อตนเองได้");

				if (GetPlayerState(targetplayer) != PLAYER_STATE_ONFOOT)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นต้องไม่อยู่บนยานพาหนะ");

				if (!IsPlayerNearPlayer(playerid, targetplayer, 5.0))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไม่ได้อยู่ใกล้คุณ");

				if (playerData[targetplayer][pDragged])
				{
					playerData[targetplayer][pDragged] = 0;
					playerData[targetplayer][pDraggedBy] = INVALID_PLAYER_ID;

					KillTimer(playerData[targetplayer][pDragTimer]);
					SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้ปล่อยตัว %s", GetPlayerNameEx(playerid), GetPlayerNameEx(targetplayer));
				}
				else
				{
					playerData[targetplayer][pDragged] = 1;
					playerData[targetplayer][pDraggedBy] = playerid;

					playerData[targetplayer][pDragTimer] = SetTimerEx("DragUpdate", 200, true, "dd", playerid, targetplayer);
					SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้คว้าตัว %s", GetPlayerNameEx(playerid), GetPlayerNameEx(targetplayer));
				}
			}
        }
    }
    return 1;
}
Dialog:MEDIC_HEAL(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
		
		new tmp2[128], amount = strval(inputtext), targetplayer = playerData[playerid][pFactionMenuID];
        new factionid = playerData[playerid][pFaction];

		if (isnull(inputtext))
			return Dialog_Show(playerid, MEDIC_HEAL, DIALOG_STYLE_INPUT, "Heal (ฮีล)", "โปรดระบุจำนวนเงินที่คุณต้องการจะใส่ในบิล :", "ตกลง", "ยกเลิก");

		if (amount <= 0 || amount > 5000)
		    return Dialog_Show(playerid, MEDIC_HEAL, DIALOG_STYLE_INPUT, "Heal (ฮีล)", "โปรดระบุจำนวนเงินที่คุณต้องการจะใส่ในบิล :\n\
            {FF6347}*จำนวนจะต้องไม่ต่ำกว่าหรือเท่ากับ 0 และไม่มากกว่า 5,000", "ตกลง", "ยกเลิก");

		format(tmp2, sizeof(tmp2), "~r~-%s", FormatMoney(amount));
		GameTextForPlayer(targetplayer, tmp2, 2000, 4);

        factionData[factionid][factionTreasury] += amount;
        GivePlayerMoneyEx(targetplayer, -amount);
        Faction_SaveTreasury(factionid);

		SetTimerEx("HealUpdate", 7000, false, "dd", playerid);
		ApplyAnimation(playerid, "MEDIC", "CPR", 4.1, 1, 1, 1, 0, 0, 1);
		ApplyAnimation(targetplayer, "SWAT", "gnstwall_injurd", 4.1, 1, 1, 1, 1, 0, 1);

		Inventory_Remove(playerid, "MedicCase", 1);

        SendFactionMessage(factionid, COLOR_RADIO, "(( (%d) %s %s: ทำการรับษา(Heal) ให้กับ %s ในราคา '%s' ))", playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid), GetPlayerNameEx(targetplayer), FormatMoney(amount));
        SetPlayerChatBubble(playerid, "** เริ่มทำการรักษาทางการแพทย์", COLOR_PURPLE, 5.0, 5000);
		
		//SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s  %s ในราคา '%s'", GetPlayerNameEx(playerid), GetPlayerNameEx(targetplayer), FormatMoney(amount));
	}
	return 1;
}

forward HealUpdate(playerid);
public HealUpdate(playerid)
{
	new targetplayer = playerData[playerid][pFactionMenuID];
	CallMedic[targetplayer] = 0;
	SetPlayerHealth(targetplayer, 100);
	SetPlayerWeather(targetplayer, globalWeather);
	PlayerTextDrawHide(targetplayer, PlayerDeathTD[targetplayer]);
	ShowPlayerStats(targetplayer, true);
	playerData[targetplayer][pInjured] = 0;
	playerData[targetplayer][pInjuredTime] = 0;

	ClearAnimations(targetplayer);
	ClearAnimations(playerid);
	return 1;
}




/* ------------------------------------------------ Case --------------------------------------------------- */


hook OnPlayerConnect(playerid)
{
    CheckMedic[playerid] = 0;
    IdCheckMedic[playerid] = 0;
    CallMedic[playerid] = 0;
    MedicType[playerid] = 0;
}

CMD:mdc(playerid, params[])
{
	new
		str[1024],
		count;
	if (GetFactionType(playerid) == FACTION_MEC)
	{
		foreach (new i : Player)
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(i, x,y,z);

			if (CallMec[i] == 1)
			{
				format(str, sizeof(str), "%s (id: %d)%s\t{FFA84D}%.1fm\n", str, i, GetPlayerNameEx(i), GetPlayerDistanceFromPoint(playerid, x, y, z));
				playerNearSelectMec[playerid][count] = i;
				count++;
				if(count == 20) break;
			}
		}
		if(!count) Dialog_Show(playerid, Dialog_ErorrMec, DIALOG_STYLE_TABLIST, "Mechanic MDC's","{FFFFFF}- ไม่พบการแจ้งเตือนใดๆ ที่ต้องการความช่วยเหลือ","ปิด","");
		else Dialog_Show(playerid, Dialog_NearMec, DIALOG_STYLE_TABLIST, "Mechanic MDC's", str, "เลือก", "ปิด");
	}
	if (GetFactionType(playerid) == FACTION_MEDIC)
	{
		foreach (new i : Player)
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(i, x,y,z);

			if (CallMedic[i] == 1)
			{
				format(str, sizeof(str), "%s (id: %d)%s\t{FFA84D}%.1fm\n", str, i, GetPlayerNameEx(i), GetPlayerDistanceFromPoint(playerid, x, y, z));
				playerNearSelectMedic[playerid][count] = i;
				count++;
				if(count == 20) break;
			}
		}
		if(!count) Dialog_Show(playerid, Dialog_ErorrMedic, DIALOG_STYLE_TABLIST, "Medical MDC's","{FFFFFF}- ไม่พบการแจ้งเตือนใดๆ ที่ต้องการความช่วยเหลือ","ปิด","");
		else Dialog_Show(playerid, Dialog_NearMedic, DIALOG_STYLE_TABLIST, "Medical MDC's", str, "เลือก", "ปิด");
	}
	return 1;
}
new bool:GPSOnMedic[MAX_PLAYERS];
Dialog:Dialog_NearMedic(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    if(listitem != -1 && listitem != 21)
    {/*
        if (playerNearSelectMedic[playerid][listitem] == playerid)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Medical-Message]: ไม่สามารถดำเนินการได้ เนื่องจากคุณไม่สามารถค้นหาตัวเองได้");
*/
        new Float:x,Float:y,Float:z;
        GetPlayerPos(playerNearSelectMedic[playerid][listitem], x,y,z);
        SetPlayerCheckpoint(playerid, x,y,z, 1.5);

        IdCheckMedic[playerid] = playerNearSelectMedic[playerid][listitem];
        CheckMedic[playerid] = 1;

        CallMedic[playerNearSelectMedic[playerid][listitem]] = 0;
        MedicType[playerNearSelectMedic[playerid][listitem]] = 0;
		GPSOnMedic[playerid] = true;
        SendClientMessageEx(playerNearSelectMedic[playerid][listitem], COLOR_YELLOW, "[Medical-Message]: (%d)%s ตอบรับเคสของคุณเรียบร้อย (ระยะทาง: %.1f m)", playerid, GetPlayerNameEx(playerid), GetPlayerDistanceFromPoint(playerid, x, y, z));
		SendFactionMessage(FACTION_MEDIC, COLOR_RADIO, "(( (%d) %s %s: ได้ตอบรับความช่วยเหลือของ %s ))", playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid), GetPlayerNameEx(playerNearSelectMedic[playerid][listitem]));
		return true;
    }
    return 1;
}
hook OnPlayerEnterCheckpoint(playerid)
{
	if (GPSOnMedic[playerid] == true)
	{
	    GPSOnMedic[playerid] = false;
		ClearGPS(playerid);
		DisablePlayerCheckpoint(playerid);
		PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
	}
	return 1;
}
Dialog:MedicCase_Dialog(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new var[15];
		format(var, sizeof(var), "MedicCase%d", listitem);
		new targetplayer = GetPVarInt(playerid, var);

		if (GetFactionType(playerid) == FACTION_MEDIC) //เป็นหมอ
		{
			Dialog_Show(playerid, MEDIC_MENU, DIALOG_STYLE_LIST, "เมนูเจ้าหน้าที่ 'แพทย์'", "{FFFFFF}ชื่อ: %s\n\
			- Heal (ชุป/รักษา)\n\
			- Drag (ลาก/ปล่อยลาก)\
			", "เลือก", "ยกเลิก", GetPlayerNameEx(targetplayer));
		}
		playerData[playerid][pFactionMenuID] = targetplayer;
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);	
	}
}
/*
MEDIC_Name(playerid)
{
	new MedicName[64];
	switch(MedicType[playerid])
	{
	    case 1: MedicName = "{F95A04}บาดเจ็บสาหัส";
	    case 2: MedicName = "{F95A04}กำลังอุ้มเอ๋อ";
	}
	return MedicName;
}
*/

/*
// Cpr Box
Dialog:Dialog_NearCpr_Police(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    if(listitem != -1 && listitem != 21)
    {
        if (playerNearSelectCpr[playerid][listitem] == playerid)
            return ErrorMsg(playerid, "ไม่สามารถปั้มหัวใจตัวเองได้!");

        if(!Inventory_HasItem(playerid, "Cpr PoliceBox"))
            return ErrorMsg(playerid, "คุณไม่มีกล่องชุบ กรุณาไปรับที่ล็อคเกอร์ตำรวจ");

        InjuredID[playerid] = playerNearSelectCpr[playerid][listitem];
        InjuredID[playerNearSelectCpr[playerid][listitem]] = playerid;
        new string[128];
        format(string, sizeof(string), "{00ff00}%s {ffffff}ต้องการที่จะ {00ffff}ปั้มหัวใจ{ffffff} ให้กับคุณ", GetPlayerNameEx(playerid));
        Dialog_Show(playerNearSelectCpr[playerid][listitem], CprMenu_Police, DIALOG_STYLE_MSGBOX, "Cpr", string, "ตกลง", "ยกเลิก");
        return true;
    }
    return 1;
}

Dialog:CprMenu_Police(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		SendClientMessageEx(InjuredID[playerid], COLOR_RED, "ผู้บาดเจ็บ %s ได้ปฏิเสธการรักษาของคุณ", GetPlayerNameEx(playerid));
		InjuredID[InjuredID[playerid]] = 999;
		InjuredID[playerid] = 999;
		return 1;
	}

	if(response)
	{
        SendClientMessageEx(playerid, COLOR_RED, "[!] {ffffff}%s กำลังรักษาให้คุณ", GetPlayerNameEx(InjuredID[playerid]));
        SendClientMessageEx(InjuredID[playerid], COLOR_RED, "[!] {ffffff}คุณกำลังรักษาให้กับ %s ", GetPlayerNameEx(playerid));
        Inventory_Remove(InjuredID[playerid], "Cpr PoliceBox", 1);
		SetPlayerHealth(playerid,50);
		playerData[playerid][pInjured] = 0;
		playerData[playerid][pInjuredTime] = 0;
		ApplyAnimation(InjuredID[playerid], "MEDIC", "CPR", 4.1, 0, 0, 0, 0, 0, 1);
		ClearAnimations(playerid);
        TogglePlayerControllable(playerid, 1);
        PlayerTextDrawHide(playerid, PlayerDeathTD[playerid]);
		SetPlayerColor(playerid, 0xFFFFFFFF);
		InjuredID[InjuredID[playerid]] = 999;
		InjuredID[playerid] = 999;
        InjuredCallMedic[playerid] = 0;
        InjuredCallMedicEx[playerid] = 0;
	}
	return 1;
}

// Heal Box

Dialog:Dialog_NearHeal_Police(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    if(listitem != -1 && listitem != 21)
    {
        if (playerNearSelectCpr[playerid][listitem] == playerid)
            return ErrorMsg(playerid, "ไม่สามารถปั้มหัวใจตัวเองได้!");

        if(!Inventory_HasItem(playerid, "Heal PoliceBox"))
            return ErrorMsg(playerid, "คุณไม่มีกล่องชุบ กรุณาไปรับที่ล็อคเกอร์ตำรวจ");

        InjuredID[playerid] = playerNearSelectCpr[playerid][listitem];
        InjuredID[playerNearSelectCpr[playerid][listitem]] = playerid;
        new string[128];
        format(string, sizeof(string), "{00ff00}%s {ffffff}ต้องการที่จะ {00ffff}ชุบชีวิต{ffffff} ให้กับคุณ", GetPlayerNameEx(playerid));
        Dialog_Show(playerNearSelectCpr[playerid][listitem], HealMenu_Police, DIALOG_STYLE_MSGBOX, "Cpr", string, "ตกลง", "ยกเลิก");
        return true;
    }
    return 1;
}

Dialog:HealMenu_Police(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		SendClientMessageEx(InjuredID[playerid], COLOR_RED, "ผู้บาดเจ็บ %s ได้ปฏิเสธการรักษาของคุณ", GetPlayerNameEx(playerid));
		InjuredID[InjuredID[playerid]] = 999;
		InjuredID[playerid] = 999;
		return 1;
	}

	if(response)
	{
        SendClientMessageEx(playerid, COLOR_RED, "[!] {ffffff}%s กำลังรักษาให้คุณ", GetPlayerNameEx(InjuredID[playerid]));
        SendClientMessageEx(InjuredID[playerid], COLOR_RED, "[!] {ffffff}คุณกำลังรักษาให้กับ %s ", GetPlayerNameEx(playerid));
        Inventory_Remove(InjuredID[playerid], "Heal PoliceBox", 1);
		SetPlayerHealth(playerid,100);
		playerData[playerid][pInjured] = 0;
		playerData[playerid][pInjuredTime] = 0;
		ApplyAnimation(InjuredID[playerid], "MEDIC", "CPR", 4.1, 0, 0, 0, 0, 0, 1);
		ClearAnimations(playerid);
        TogglePlayerControllable(playerid, 1);
        PlayerTextDrawHide(playerid, PlayerDeathTD[playerid]);
		SetPlayerColor(playerid, 0xFFFFFFFF);
		InjuredID[InjuredID[playerid]] = 999;
		InjuredID[playerid] = 999;
        InjuredCallMedic[playerid] = 0;
        InjuredCallMedicEx[playerid] = 0;
	}
	return 1;
}

*/
