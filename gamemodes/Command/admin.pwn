new bool:AdminSpecID[MAX_PLAYERS];

AdminRank(playerid)
{
	new adminname[32];
	switch(playerData[playerid][pAdmin])
	{
	    case 1: adminname = "Helper";
	    case 2: adminname = "Supporter";
	    case 3: adminname = "Staff";
	    case 4: adminname = "Samaru";
	    case 5: adminname = "Hitomi";
	    case 6: adminname = "Dev.";
	}
	return adminname;
}
alias:admin("a") 
CMD:admin(playerid, params[])
{
	if (playerData[playerid][pAdmin] < 1)
	    return 1;

	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_WHITE, "/a [ข้อความ]");

	if (strlen(params) > 64)
	{
	    SendAdminMessage(COLOR_YELLOW, "(( [%s] (%d)%s: %.64s", AdminRank(playerid), playerid, GetPlayerNameEx(playerid), params);
	    SendAdminMessage(COLOR_YELLOW, "...%s ))", params[64]);
	}
	else {
	    SendAdminMessage(COLOR_YELLOW, "(( [%s] (%d)%s: %s ))", AdminRank(playerid), playerid, GetPlayerNameEx(playerid), params);
	}
	return 1;
}
CMD:whitelist(playerid, params[]){

	if(playerData[playerid][pAdmin] < 4)
	    return 1;

	//params รับชื่อผู้เล่นเข้ามา
	if(isnull(params))
	    return SendClientMessage(playerid, -1, "- คุณจำเป็นต้องกรอกชื่อผู้เล่นที่จะให้ไวริส");

	new string[128];

	format(string, sizeof(string), "UPDATE `players` SET `playerWhitelis` = %d WHERE `playerName` = '%s'", 1, SQL_ReturnEscaped(params));
	mysql_tquery(g_SQL, string);

	new string2[128];

	format(string2, sizeof(string2), "คุณได้ให้ไวริสคอมกับผู้เล่น %s เรียบร้อยแล้ว", params);
	SendClientMessage(playerid, -1, string2);
	return 1;
}

CMD:as(playerid, params[])
{
    if (playerData[playerid][pAdmin] < 4)
	    return 1;

	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_WHITE, "/as [ข้อความ]");

	SendClientMessageToAllEx(COLOR_YELLOW, "(( [Administrator]: %s ))", params);
	return 1;
}


/*
CMD:admins(playerid, params[])
{
	new count;

	foreach (new i : Player) if (playerData[i][pAdmin] > 0)
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "[ID: %d] {33CCFF}%s {00FF00}%s", i, GetPlayerNameEx(i), AdminRank(i));
		count++;
	}
	if (!count)
	{
		ErrorMsg(playerid, "ไม่มีแอดมินออนไลน์อยู่เลย");
		return 1;
	}
	return 1;
}
*/

stock SendSetMessages(player, playerid, option1[], option2)
{
	new str[128];
    format(str, sizeof(str), "%s {FFFFFF}Set %s[%s] is %d.", GetPlayerNameEx(playerid), GetPlayerNameEx(player), option1, option2);
    SendClientMessage(player, COLOR_YELLOW, str);
	SendAdminsMessage(1, COLOR_YELLOW, str);
	return 1;
}
stock SendAdminsMessage(level, color, str[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            new astr[128];
            if(playerData[i][pAdmin] >= level)
            {
                format(astr, sizeof(astr), "[Admin-Message]: %s", str);
                SendClientMessage(i, color, astr);
            }
        }
    }
}


CMD:Hugo(playerid, params[])
{
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	return 1;
}



CMD:gopos(playerid, params[])
{

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

    new
    	interiorID,
     	Float: coordinates[3];

	if(sscanf(params, "fffd", coordinates[0], coordinates[1], coordinates[2], interiorID))
	{
 		SendClientMessage(playerid , COLOR_SERVER,"/gopos [x] [y] [z] [interior]");
	}
	else
	{
 		SetPlayerInterior(playerid, interiorID);
   		SetPlayerPos(playerid, coordinates[0], coordinates[1], coordinates[2]);
	}

	return 1;
}

alias:goto("ไป")
CMD:goto(playerid, params[])
{
	static
	    id,
	    type[24],
		string[64];

	if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (sscanf(params, "u", id))
 	{
	 	SendClientMessage(playerid, COLOR_WHITE, "/goto [ไอดี/ชื่อ]");
		SendClientMessage(playerid, COLOR_YELLOW, "[ชื่อรายการ]:{FFFFFF} entrance, interior");
		return 1;
	}
    if (id == INVALID_PLAYER_ID)
	{
	    if (sscanf(params, "s[24]S()[64]", type, string))
		{
		 	SendClientMessage(playerid, COLOR_WHITE, "/goto [ไอดี/ชื่อ]");
			SendClientMessage(playerid, COLOR_YELLOW, "[ชื่อรายการ]:{FFFFFF} entrance, interior");
			return 1;
	    }
		else if (!strcmp(type, "entrance", true))
		{
		    if (sscanf(string, "d", id))
		        return SendClientMessage(playerid, COLOR_WHITE, "/goto [ชื่อรายการ] [ไอดีประตู]");

			if ((id < 0 || id >= MAX_ENTRANCES) || !entranceData[id][entranceExists])
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "[ระบบ] {FFFFFF}ไม่มีไอดีประตูนี้อยู่ในฐานข้อมูล");

		    SetPlayerPos(playerid, entranceData[id][entrancePosX], entranceData[id][entrancePosY], entranceData[id][entrancePosZ]);
		    SetPlayerInterior(playerid, entranceData[id][entranceExterior]);

			SetPlayerVirtualWorld(playerid, entranceData[id][entranceExteriorVW]);
		    SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้วาร์ปมาที่ประตูไอดี: %d", id);
		    return 1;
		}
		else if (!strcmp(type, "interior", true))
		{
		    static
		        str[1536];

			str[0] = '\0';

			for (new i = 0; i < sizeof(g_arrInteriorData); i ++)
			{
			    strcat(str, g_arrInteriorData[i][e_InteriorName]);
			    strcat(str, "\n");
		    }
		    Dialog_Show(playerid, DIALOG_TELEPORT, DIALOG_STYLE_LIST, "[สถานที่ด้านในทั้งหมด]", str, "วาร์ป", "ออก");
		    return 1;
		}
	    else return SendClientMessage(playerid, COLOR_LIGHTRED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");
	}
	if (!IsPlayerSpawnedEx(id))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ยังไม่ได้อยู่ในสถานะปกติ");

	SendPlayerToPlayer(playerid, id);

	format(string, sizeof(string), "You have ~y~teleported~w~ to %s.", GetPlayerNameEx(id));
	GameTextForPlayer(playerid, string, 5000, 1);

	return 1;
}
enum sver
{
	ID,
	Name[32],
	Version[16],
	Locked,
	Password[32],
	Weather
};

new Server[sver];


CMD:editserver(playerid, params[])
{
    if (playerData[playerid][pAdmin] < 4)
	    return 1;

    ShowDialogEditServer(playerid);
    return 1;
}
stock ShowDialogEditServer(playerid)
{
    new string[1024];

    format(string, sizeof(string), "ชื่อเซิฟเวอร์: %s\n", Server[Name]);
    format(string, sizeof(string), "%sเวอร์ชั่น: %s\n", string, Server[Version]);
    format(string, sizeof(string), "%sสถานะ: %s\n",string, Server[Locked] ? ("ล็อค") : ("ปลดล็อค"));
    format(string, sizeof(string), "%sพาสเวิร์ด: %s", string, Server[Password]);
    Dialog_Show(playerid, ChangeServer, DIALOG_STYLE_LIST, "แก้ไขเซิฟเวอร์", string, "เลือก","ยกเลิก");
    return 1;
}

Server_Save2()
{
	new
	    query[2048];

	format(query, sizeof(query), "UPDATE `settings` SET `Name` = '%s', `Version` = '%s', `Password` = '%s', `Locked` = '%d' WHERE `ID` = '0'",
		SQL_ReturnEscaped(Server[Name]),
        SQL_ReturnEscaped(Server[Version]),
        SQL_ReturnEscaped(Server[Password]),
        Server[Locked],
        Server[ID]
	);
	return mysql_tquery(g_SQL, query);
}

Dialog:ChangeServer(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new string[1024];

    if(response)
    {
        if(listitem == 0)
        {
            format(string, sizeof(string), "ชื่อเซิฟเวอร์: %s", Server[Name]);
            Dialog_Show(playerid, ChangeServerName, DIALOG_STYLE_INPUT, "ตั้งค่าชื่อเซิฟเวอร์", string, "เปลี่ยน", "กลับ");
        }
        if(listitem == 1)
        {
            format(string, sizeof(string), "เวอร์ชั่นปัจจุบัน: %s", Server[Version]);
            Dialog_Show(playerid, ChangeServerVersion, DIALOG_STYLE_INPUT, "ตั้งค่าเวอร์ชั่น", string, "เปลี่ยน", "กลับ");
        }
        if(listitem == 2)
        {
            format(string, sizeof(string), "ปลดล็อค\nล็อค");
            Dialog_Show(playerid, ChangeServerLocked, DIALOG_STYLE_LIST, "การตั้งค่าล็อคเซิฟเวอร์", string, "เปลี่ยน", "กลับ");
        }
        if(listitem == 3)
        {
            format(string, sizeof(string), "พาสเวิร์ด: %s", Server[Password]);
            Dialog_Show(playerid, ChangeServerPassword, DIALOG_STYLE_INPUT, "ตั้งค่ารหัสผ่าน", string, "เปลี่ยน", "กลับ");
        }
    }
    return 1;
}

Dialog:ChangeServerName(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[64];

		if(isnull(inputtext) || strlen(inputtext) >= 64) {
			format(string, sizeof(string), "ความยาวของชื่อต้องมากกว่า 0 และไม่เกิน 64/n/nชื่อเซิฟเวอร์: %s", Server[Name]);
			Dialog_Show(playerid, ChangeServerName, DIALOG_STYLE_INPUT, "แก้ไขชื่อเซิฟเวอร์", string, "เปลี่ยน", "กลับ");
			return true;
		}
		format(Server[Name], 64, inputtext);
        new name[64];
        format(name, sizeof(name), "hostname %s", Server[Name]);
		SendRconCommand(name);
		Server_Save2();
		SendClientMessageEx(playerid, -1, "- คุณได้เปลี่ยนชื่อเซิฟเวอร์เป็น '%s' เรียบร้อยแล้ว!",Server[Name]);
    }
    return ShowDialogEditServer(playerid);
}

Dialog:ChangeServerVersion(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[16];

		if(isnull(inputtext) || strlen(inputtext) >= 16) {
			format(string, sizeof(string), "ความยาวของชื่อต้องมากกว่า 0 และไม่เกิน 16/n/nเวอร์ชั่น: %s", Server[Version]);
			Dialog_Show(playerid, ChangeServerVersion, DIALOG_STYLE_INPUT, "แก้ไขเวอร์ชั่น", string, "เปลี่ยน", "กลับ");
			return true;
		}
		format(Server[Version], 16, inputtext);
        new name[16];
        format(name, sizeof(name), "%s", Server[Version]);
        SetGameModeText(name);
		Server_Save2();
        SendClientMessageEx(playerid, -1, "- คุณได้เปลี่ยน Version เป็น '%s' เรียบร้อยแล้ว!",Server[Version]);
		
    }
    return ShowDialogEditServer(playerid);
}

Dialog:ChangeServerPassword(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[32];

		if(isnull(inputtext) || strlen(inputtext) >= 32) {
			format(string, sizeof(string), "ความยาวของชื่อต้องมากกว่า 0 และไม่เกิน 32/n/nเวอร์ชั่น: %s", Server[Password]);
			Dialog_Show(playerid, ChangeServerPassword, DIALOG_STYLE_INPUT, "แก้ไขเวอร์ชั่น", string, "เปลี่ยน", "กลับ");
			return true;
		}
		format(Server[Password], 32, inputtext);
        new name[32];
        format(name, sizeof(name), "password %s", Server[Password]);
        SendRconCommand(name);
		Server_Save2();
        SendClientMessageEx(playerid, -1, "- คุณได้เปลี่ยน พาสเวิร์ด เป็น '%s' เรียบร้อยแล้ว!",Server[Password]);
    }
    return ShowDialogEditServer(playerid);
}

Dialog:ChangeServerLocked(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(listitem == 0)
        {
            Server[Locked] = 0;
            SendRconCommand("password 0");
            Server_Save2();
        }
        if(listitem == 1)
        {
            Server[Locked] = 1;
            SendRconCommand("password 0");
            new str[64];
            format(str, sizeof(str), "password %s", Server[Password]);
			SendRconCommand(str);
            Server_Save2();
        }
    }
    return ShowDialogEditServer(playerid);
}
CMD:setah(playerid, params[])
{
	if(playerData[playerid][pAdmin] >= 4)
	{
		new slot, objectid, bone;
		if(sscanf(params, "ddd", slot, objectid, bone)) return SendClientMessage(playerid, -1, "/setah [slot] [objectid] [bone]");
		SetPlayerAttachedObject(playerid, slot, objectid, bone);
	}
	return 1;
}

CMD:editah(playerid, params[])
{
	if(playerData[playerid][pAdmin] >= 6)
	{
		new slot;
		if(sscanf(params, "d", slot)) return SendClientMessage(playerid, -1, "/editah [slot]");
		SetPVarInt(playerid, "GetObjectID", 1);
		EditAttachedObject(playerid, slot);
	}
	return 1;
}


CMD:flist(playerid, params[])
{
	new
		count,
		string[512],
		string2[512];

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	for (new i = 0; i != MAX_FACTIONS; i ++) if (factionData[i][factionExists])
	{
		format(string, sizeof(string), "%d\t{FFFFFF}({%06x}%s{FFFFFF})\n", i, factionData[i][factionColor] >>> 8, factionData[i][factionName]);
		strcat(string2, string);
		count++;
	}
	if (!count)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "[ระบบ] {FFFFFF}เซิร์ฟเวอร์ไม่มีกลุ่มใด ๆ เลย");
		return 1;
	}
	format(string, sizeof(string), "ไอดี\tชื่อ\n%s", string2);
	Dialog_Show(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "[รายชื่อ Faction]", string, "ปิด", "");
	return 1;
}



/* -------------------------------------------------- Admin Menu -------------------------------------------------- */

hook OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	playerData[playerid][pAdminID] = clickedplayerid;
	if(playerData[playerid][pAdmin] >= 1) 
	{
		Dialog_Show(playerid, ADMIN_MENU, DIALOG_STYLE_LIST, "{FFFFFF}ADMIN MENU", "Name: (id:%d)%s\n\
        - Goto (วาร์ป)\n\
        - Bring (ดึง)\n\
        - Revive (ชุป)\n\
        - Reviveall (ชุปทั้งหมด)\n\
        - Repair (ซ่อม)\n\
        - Spec (ส่อง)\n\
        - Spec Off (หยุดส่อง)\n\
		- Warn (เตือน)\n\
		- Kick (เตะ)\n\
		- Ban (แบน)\n\
		- Send Message (ส่งข้อความถึง)\n\
		- Fix Map (แก้ตกแมพ)\
        ", "เลือก", "ยกเลิก", clickedplayerid, GetPlayerNameEx(clickedplayerid));
	}
	return 1;
}
Dialog:ADMIN_MENU(playerid, response, listitem, inputtext[])
{
	new 
		clickedplayerid = playerData[playerid][pAdminID];

	if(response)
	{
		if(clickedplayerid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ยังไม่ได้อยู่ในสถานะปกติ");

		switch (listitem)
		{
			case 0: // Set Stats
			{
				if(playerData[playerid][pAdmin] <= 3) 
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- เลเวล Admin ต้องมากกว่า 3 จึงจะสามารถใช้งานได้ น๊ะจ๊ะน้อง");

				Dialog_Show(playerid, MENU_STATS, DIALOG_STYLE_LIST, "{FFFFFF}Stats Menu", "{FFFFFF}- Health\n\
				- Hunger/Thirst\n\
				- Set Skin\n\
				- Online Hours\n\
				- Jobs Levels\n\
				- Check Stats\n\
				- Administrator (ห้ามใช้งานก่อนได้รับอนุญาติ)\n\
				\n", "เลือก", "ยกเลิก");
			}
			case 1: // Goto
			{

				if(playerData[playerid][pAdmin] <= 2) 
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- เลเวล Admin ต้องมากกว่า 2 จึงจะสามารถใช้งานได้ น๊ะจ๊ะน้อง");


				if (!IsPlayerSpawnedEx(clickedplayerid))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ยังไม่ได้อยู่ในสถานะปกติ");

				SendPlayerToPlayer(playerid, clickedplayerid);
				SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}Goto:{FFFFFF} (%d)%s ", GetPlayerNameEx(playerid), clickedplayerid, GetPlayerNameEx(clickedplayerid));
				return 1;
			}
			case 2: // Bring
			{
				if(playerData[playerid][pAdmin] <= 3) 
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- เลเวล Admin ต้องมากกว่า 3 จึงจะสามารถใช้งานได้ น๊ะจ๊ะน้อง");
			
				if (!IsPlayerSpawnedEx(clickedplayerid))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ยังไม่ได้อยู่ในสถานะปกติ");

				SendPlayerToPlayer(clickedplayerid, playerid);
				SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}Bring:{FFFFFF} (%d)%s ", GetPlayerNameEx(playerid), clickedplayerid, GetPlayerNameEx(clickedplayerid));
				return 1;
			}
			case 3: // Revive
			{

				if (!IsPlayerSpawnedEx(clickedplayerid))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ยังไม่ได้อยู่ในสถานะปกติ");

				if (!playerData[clickedplayerid][pInjured])
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในสถานะบาดเจ็บ");

				SetPlayerHealth(clickedplayerid, 100);
				SetPlayerWeather(clickedplayerid, globalWeather);
				PlayerTextDrawHide(clickedplayerid, PlayerDeathTD[clickedplayerid]);
				ShowPlayerStats(clickedplayerid, true);
				ClearAnimations(clickedplayerid);
				CallMedic[clickedplayerid] = 0;
				playerData[clickedplayerid][pInjured] = 0;
				playerData[clickedplayerid][pInjuredTime] = 0;

				SendClientMessageEx(clickedplayerid, COLOR_YELLOW, "[Admin-Message] %s Revive: (%d)%s ", GetPlayerNameEx(playerid), clickedplayerid, GetPlayerNameEx(clickedplayerid));
				SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}Revive:{FFFFFF} (%d)%s ", GetPlayerNameEx(playerid), clickedplayerid, GetPlayerNameEx(clickedplayerid));
				return 1;
			}
			case 4: // Reviveall
			{
				if(playerData[playerid][pAdmin] <= 2) 
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- เลเวล Admin ต้องมากกว่า 2 จึงจะสามารถใช้งานได้ น๊ะจ๊ะน้อง");
			
			    foreach(new i : Player)
				{
				    if (playerData[i][pInjured] == 1)
				    {
						SetPlayerHealth(i, 100);
						SetPlayerWeather(i, globalWeather);
						CallMedic[i] = 0;
					    playerData[i][pInjured] = 0;
					    playerData[i][pInjuredTime] = 0;
					    ClearAnimations(i);
					    PlayerTextDrawHide(i, PlayerDeathTD[i]);
					}
				} 

				SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s : Revive(All)", GetPlayerNameEx(playerid));
				return 1;
			}
			case 5: // Repair
			{

				if(playerData[playerid][pAdmin] <= 3) 
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- เลเวล Admin ต้องมากกว่า 3 จึงจะสามารถใช้งานได้ น๊ะจ๊ะน้อง");


				if (!IsPlayerSpawnedEx(clickedplayerid))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ยังไม่ได้อยู่ในสถานะปกติ");

				if (!IsPlayerInAnyVehicle(clickedplayerid))
				    return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ต้องอยู่บนยานพาหนะ");

				RepairVehicle(GetPlayerVehicleID(clickedplayerid));
				SendClientMessageEx(clickedplayerid, COLOR_YELLOW, "[Admin-Message] %s Repair: (%d)%s ", GetPlayerNameEx(playerid), clickedplayerid, GetPlayerNameEx(clickedplayerid));
				SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}Repair:{FFFFFF} (%d)%s ", GetPlayerNameEx(playerid), clickedplayerid, GetPlayerNameEx(clickedplayerid));
				return 1;
			}
			case 6: // Spec
			{

				if(playerData[playerid][pAdmin] <= 3) 
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- เลเวล Admin ต้องมากกว่า 3 จึงจะสามารถใช้งานได้ น๊ะจ๊ะน้อง");


				new Float:X, Float:Y, Float:Z, Float:A;

				if(AdminSpecID[playerid] == true)
				{
					if(clickedplayerid == playerid)
						return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถ Spec ตัวเองได้");
						
	
					SetPlayerInterior(playerid, GetPlayerInterior(clickedplayerid));
					SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(clickedplayerid));

					//UpdateplayerData(playerid);

					if (IsPlayerInAnyVehicle(clickedplayerid))
						PlayerSpectateVehicle(playerid, GetPlayerVehicleID(clickedplayerid));

					else
						PlayerSpectatePlayer(playerid, clickedplayerid);

					AdminSpecID[playerid] = true;
					SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}Spec:{FFFFFF} (%d)%s ", GetPlayerNameEx(playerid), clickedplayerid, GetPlayerNameEx(clickedplayerid));
					return 1;
				}
				if(clickedplayerid == playerid)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถ Spec ตัวเองได้");
					
				GetPlayerPos(playerid, X,Y,Z);
				GetPlayerFacingAngle(playerid, A);

				playerData[playerid][pPos_X] = X;
				playerData[playerid][pPos_Y] = Y;
				playerData[playerid][pPos_Z] = Z;
				playerData[playerid][pPos_A] = A;

				TogglePlayerSpectating(playerid, 1);

				SetPlayerInterior(playerid, GetPlayerInterior(clickedplayerid));
				SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(clickedplayerid));

				//UpdateplayerData(playerid);

				if (IsPlayerInAnyVehicle(clickedplayerid))
					PlayerSpectateVehicle(playerid, GetPlayerVehicleID(clickedplayerid));

				else
					PlayerSpectatePlayer(playerid, clickedplayerid);

				AdminSpecID[playerid] = true;
				SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}Spec:{FFFFFF} (%d)%s ", GetPlayerNameEx(playerid), clickedplayerid, GetPlayerNameEx(clickedplayerid));
				return 1;
			}
			case 7: // un spec
			{
				if(AdminSpecID[playerid] == true)
				{
					PlayerSpectatePlayer(playerid, INVALID_PLAYER_ID);
					PlayerSpectateVehicle(playerid, INVALID_VEHICLE_ID);
					//playerData[playerid][pSpawnPoint] = 2;

					SpawnPlayer(playerid);
					TogglePlayerSpectating(playerid, false);
					AdminSpecID[playerid] = false;
					return 1;
				}
			}
			case 8: // Warn
			{
				Dialog_Show(playerid, ADMIN_MENU_WARN, DIALOG_STYLE_INPUT, "เตือน (Warn)", "ชื่อ: %s\nโปรดระบุสาเหตุที่ต้องการจะเตือน:", "เตือน", "ยกเลิก", GetPlayerNameEx(clickedplayerid));
				return 1;
			}
			case 9: // Kick
			{
				if(playerData[playerid][pAdmin] <= 1) 
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- เลเวล Admin ต้องมากกว่า 1 จึงจะสามารถใช้งานได้ น๊ะจ๊ะน้อง");

				Dialog_Show(playerid, ADMIN_MENU_KICK, DIALOG_STYLE_INPUT, "เตะ (Kick)", "ชื่อ: %s\nโปรดระบุสาเหตุที่ต้องการจะเตะ:", "เตะ", "ยกเลิก", GetPlayerNameEx(clickedplayerid));
				return 1;
			}
			case 10: // Ban
			{
				if(playerData[playerid][pAdmin] <= 2) 
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- เลเวล Admin ต้องมากกว่า 2 จึงจะสามารถใช้งานได้ น๊ะจ๊ะน้อง");

				Dialog_Show(playerid, ADMIN_MENU_BAN, DIALOG_STYLE_INPUT, "เตะ (Kick)", "ชื่อ: %s\nโปรดระบุสาเหตุที่ต้องการจะแบน:", "แบน", "ยกเลิก", GetPlayerNameEx(clickedplayerid));
				return 1;
			}
			case 11: // ข้อความถึง
				return Dialog_Show(playerid, ADMIN_MENU_PM, DIALOG_STYLE_INPUT, "ส่งข้อความถึง (Send Message)", "{FFFFFF}ชื่อ: %s\nระบุข้อความที่คุณต้องการจะส่งถึงผู้เล่น:", "ส่ง", "ยกเลิก", GetPlayerNameEx(clickedplayerid));
			case 12: // แก้บัคตกแมพ
			{
				SetPlayerHealth(clickedplayerid, 100);
				SetPlayerWeather(clickedplayerid, globalWeather);
				PlayerTextDrawHide(clickedplayerid, PlayerDeathTD[clickedplayerid]);
				ShowPlayerStats(clickedplayerid, true);
				ClearAnimations(clickedplayerid);
				CallMedic[clickedplayerid] = 0;
				playerData[clickedplayerid][pInjured] = 0;
				playerData[clickedplayerid][pInjuredTime] = 0;

				SetPlayerPos(clickedplayerid, 1445.8163,-2286.9094,13.5469);
				SetPlayerFacingAngle(clickedplayerid,92.3983);
				SetPlayerInterior(clickedplayerid,0);
				SetPlayerVirtualWorld(clickedplayerid, 0);
				TogglePlayerSpectating(clickedplayerid, false);
				
				SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}Fix Map:{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), clickedplayerid, GetPlayerNameEx(clickedplayerid));
				SendClientMessageEx(clickedplayerid, COLOR_YELLOW, "(( Administrator: แก้บัคตพแมพให้กับคุณ ))", inputtext);
				return 1;
			}
        }
    }
    return 1;
}
Dialog:ADMIN_MENU_PM(playerid, response, listitem, inputtext[])
{

	if(response)
	{
		new clickedplayerid = playerData[playerid][pAdminID];	

		if (!IsPlayerSpawnedEx(clickedplayerid))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ยังไม่ได้อยู่ในสถานะปกติ");

		if (isnull(inputtext))
			return Dialog_Show(playerid, ADMIN_MENU_PM, DIALOG_STYLE_INPUT, "{FFFFFF}", "{FFFFFF}ชื่อ: %s\nระบุข้อความที่คุณต้องการจะส่งถึงผู้เล่น:", "ส่ง", "ยกเลิก", GetPlayerNameEx(clickedplayerid));


		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s Send Message{FFFFFF}(%d)%s: %s", GetPlayerNameEx(playerid), clickedplayerid, GetPlayerNameEx(clickedplayerid), inputtext);
		SendClientMessageEx(clickedplayerid, COLOR_YELLOW, "(( Administrator ส่งข้อความถึงคุณ: %.80s ))", inputtext);
	}
	return 1;
}
Dialog:MENU_STATS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new clickedplayerid = playerData[playerid][pAdminID];	
		switch (listitem)
		{
			case 0: // Health
			{
				Dialog_Show(playerid, MENU_STATSHEALTH, DIALOG_STYLE_INPUT, "Health", "โปรดระบุจำนวน 'Health' โดยต้องอยู่ระหว่าง 0 ถึง 100", "ตกลง", "ยกเลิก");
				return 1;
			}
			case 1: // Hunger/Thirst
			{
				Dialog_Show(playerid, MENU_STATSHunger, DIALOG_STYLE_INPUT, "Hunger/Thirst", "โปรดระบุจำนวน 'Hunger/Thirst' โดยต้องไม่ต่ำกว่า 0 และไม่มากกว่า 100", "ตกลง", "ยกเลิก");
				return 1;
			}
			case 2: // Skin
			{	
				Dialog_Show(playerid, MENU_STATSSKIN, DIALOG_STYLE_INPUT, "Skin", "โปรดระบุไอดี 'Skin' โดยต้องอยู่ระหว่าง 0 ถึง 311", "ตกลง", "ยกเลิก");
				return 1;
			}
			case 3: // Online Hours
			{
				Dialog_Show(playerid, MENU_STATSHOURS, DIALOG_STYLE_INPUT, "Hours", "โปรดระบุจำนวน 'Hours' โดยต้องไม่ต่ำกว่า 0", "ตกลง", "ยกเลิก");
				return 1;
			}
			case 4: // JobsLevel
			{
				Dialog_Show(playerid, MENU_JobsLevel, DIALOG_STYLE_LIST, "JobsLevel", "- Levels Craft", "เลือก", "ยกเลิก");
				return 1;
			}
			case 5: // stats
			{
				static const aGender[3][10] = {"แก้ไข", "ชาย", "หญิง"};

				new businessid, pDialog[2080];

				format(pDialog, sizeof(pDialog), "{FFFFFF}ชื่อตัวละคร :{FFA84D} %s (%s) {FFFFFF}| {ec1d24}True{f58320}Wallet{FFFFFF}: {FFA84D}%s\n\
				{FFFFFF}สมัครสมาชิก(วว/ดด/ปป) : {FFA84D}%s\n\
				{00FF00}จำนวนเงิน : (Cash: %s), (Bank: %s) {FFFFFF}| {FF6347}เงินผิดกฎหมาย: %s\n\
				{FFFFFF}เบอร์มือถือ: {FFFF00}%s\n\
				{FFFFFF}Faction: {33CCFF}%s {FFFFFF}| Rank: {33CCFF}(%d)%s\n\
				{FFFFFF}Business: %s\n\
				ความชำนาญในการคราฟอาวุธ: {FFA84D}%d {FFFFFF}| {FFA84D}%s \n\
				{FFFFFF}ความจุของกระเป๋า: {FFA84D}%d {FFFFFF} ช่อง | ความจุของไอเทม: {FFA84D}%d {FFFFFF}ชิ้น\n\
				{FFFFFF}\n\
				\n\
				\b{AFAFAF}เวลาที่ใช้ไป : %d ชั่วโมง %d นาที.", GetPlayerNameEx(clickedplayerid), aGender[playerData[clickedplayerid][pGender]], FormatNumber(playerData[clickedplayerid][pCoin]), playerData[clickedplayerid][pRegisterDate], 
				FormatMoney(playerData[clickedplayerid][pMoney]), FormatMoney(playerData[clickedplayerid][pBankMoney]), FormatMoney(GetPlayerRedMoney(clickedplayerid)),
				FormatNumberPhone(playerData[clickedplayerid][pPhone]), 
				Faction_GetName(clickedplayerid), playerData[clickedplayerid][pFactionRank], Faction_GetRank(clickedplayerid),
				businessData[businessid][businessName],
				GetPlayerLevelCraft(clickedplayerid), LevelCraftRank_GetName(clickedplayerid),
				playerData[clickedplayerid][pMaxItem], playerData[clickedplayerid][pItemAmount],
				playerData[clickedplayerid][pHours], playerData[clickedplayerid][pMinutes]);
				Dialog_Show(playerid, DialogStats, DIALOG_STYLE_MSGBOX, "\tStats", pDialog, "ปิด", "");

				SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}Check Stats{FFFFFF}:(%d)%s", GetPlayerNameEx(playerid), clickedplayerid, GetPlayerNameEx(clickedplayerid));
				return 1;
			}
			case 6: // Administrator
			{
				if(playerData[playerid][pAdmin] <= 4) 
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณไม่ได้รับอนุญาติให้ใช้คำสั่งนี้ ระบบกำลังรายงานไปยัง Admin ที่สูงกว่าเพื่อพิจารณา");

				Dialog_Show(playerid, MENU_Administrator, DIALOG_STYLE_LIST, "Administrator", 
				"- Admin Levels\n\
				- Money (Legal/Illegal)\n\
				- GPS Teleport\n\
				- Interior Teleport\n\
				- Wallet\n\
				- Phone Number\n\
				", "ตกลง", "ยกเลิก");
				return 1;
			}
        }
    }
    return 1;
}
Dialog:MENU_Administrator(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new str[1024];
		switch (listitem)
		{
			case 0: // Admin
			{
				if(playerData[playerid][pAdmin] < 6) 
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณไม่ได้รับอนุญาติให้ใช้คำสั่งนี้ ระบบกำลังรายงานไปยัง Admin ที่สูงกว่าเพื่อพิจารณา");

				Dialog_Show(playerid, MENU_Administrator_Admin, DIALOG_STYLE_INPUT, "Admin", "โปรดระบุจำนวน 'Admin Levels' โดยต้องไม่ต่ำกว่า 0", "ตกลง", "ยกเลิก");
				return 1;
			}
			case 1: // Money
			{
				if(playerData[playerid][pAdmin] < 6) 
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณไม่ได้รับอนุญาติให้ใช้คำสั่งนี้ ระบบกำลังรายงานไปยัง Admin ที่สูงกว่าเพื่อพิจารณา");

				Dialog_Show(playerid, MENU_Moneytype, DIALOG_STYLE_LIST, "Money", "{FFFFFF}- Legal Money\n- Illegal Money", "เลือก", "ยกเลิก");
			}
			case 2: // Gps Teleport
				return Dialog_Show(playerid, DIALOG_AGPS, DIALOG_STYLE_LIST, "[GPS Teleport]", "สถานที่ทั่วไป\n\
				งานถูกกฎหมาย\n\
				งานผิดกฎหมาย\n\
				ร้านขายรถ-พาว\n\
				สถานที่ทำงาน\n\
				ธนาคาร\n\
				จุดเบิกรถ\
				", "เลือก", "ปิด");

			case 3: // Interior
			{

				str[0] = '\0';
				for (new i = 0; i < sizeof(g_arrInteriorData); i ++)
				{
					strcat(str, g_arrInteriorData[i][e_InteriorName]);
					strcat(str, "\n");
				}
				Dialog_Show(playerid, DIALOG_TELEPORT, DIALOG_STYLE_LIST, "[สถานที่ด้านในทั้งหมด]", str, "วาร์ป", "ออก");
			}
			case 4: // Wallet
			{
				if(playerData[playerid][pAdmin] < 4) 
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณไม่ได้รับอนุญาติให้ใช้คำสั่งนี้ ระบบกำลังรายงานไปยัง Admin ที่สูงกว่าเพื่อพิจารณา");

				Dialog_Show(playerid, Administrator_Wallet, DIALOG_STYLE_LIST, "Wallet", "{FFFFFF}- Give\n- Set", "เลือก", "ยกเลิก");
				return 1;
			}
			case 5: // Phone Number
				return Dialog_Show(playerid, MENU_Administrator_Phone, DIALOG_STYLE_INPUT, "Phone Number", "โปรดระบุหมายเลขโทรศักพ์มือถือ", "ตกลง", "ยกเลิก");

        }
    }
    return 1;
}
/* 
			    foreach (new i : Player)
				{
					if(playerData[i][IsLoggedIn])
					{
			            UpdateplayerData(i);
					}
				}
				SendClientMessage(playerid, -1, "- คุณได้ save ข้อมูลเซิฟเวอร์เรียบร้อยแล้ว!");
 */


/* -------------------------------------------------- Admin Menu -------------------------------------------------- */

Dialog:MENU_JobsLevel(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: Dialog_Show(playerid, MENU_JobsLevel_Craft, DIALOG_STYLE_INPUT, "Levels Craft", "โปรดระบุจำนวน 'Levels Craft' โดยต้องไม่ต่ำกว่า 0", "ตกลง", "ยกเลิก");
		}
	}
	return 1;
}

Dialog:MENU_JobsLevel_Craft(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext), clickedplayerid = playerData[playerid][pAdminID];
	if (response)
	{
		if (amount < 0)
			return Dialog_Show(playerid, MENU_JobsLevel_Trucking, DIALOG_STYLE_INPUT, "Levels Craft", "โปรดระบุจำนวน 'Trucking Levels' โดยต้องไม่ต่ำกว่า 0", "ตกลง", "ยกเลิก");

		SetPlayerLevelCraft(clickedplayerid, amount);
		SetPlayerExpCraft(clickedplayerid, 0);
		UpdateplayerData(clickedplayerid);
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Set{FFA84D} Levels Craft(%d):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), amount, clickedplayerid, GetPlayerNameEx(clickedplayerid));
	}
	return 1;
}

Dialog:MENU_Administrator_Admin(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext), clickedplayerid = playerData[playerid][pAdminID];
	if (response)
	{
		if (amount < 0)
			return Dialog_Show(playerid, MENU_Administrator_Admin, DIALOG_STYLE_INPUT, "Hours", "{FF6347}*จำนวน 'Admin Levels' จำเป็นต้องมากกว่า 0", "ตกลง", "ยกเลิก");

		playerData[clickedplayerid][pAdmin] = amount;
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Set{FFA84D} Admin Levels(%d):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), amount, clickedplayerid, GetPlayerNameEx(clickedplayerid));
	}
	return 1;
}
Dialog:MENU_Administrator_Phone(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext), clickedplayerid = playerData[playerid][pAdminID];
	if (response)
	{
		if (amount < 0)
			return Dialog_Show(playerid, MENU_Administrator_Phone, DIALOG_STYLE_INPUT, "Phone Number", "โปรดระบุหมายเลขโทรศักพ์มือถือ", "ตกลง", "ยกเลิก");

		playerData[clickedplayerid][pPhone] = amount;
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Set{FFA84D} PhoneNumber(%s):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), FormatNumberPhone(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
	}
	return 1;
}

Dialog:MENU_Moneytype(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0: // Legal Money
			{
				Dialog_Show(playerid, MENU_Money_Legal, DIALOG_STYLE_LIST, "Legal Money", "{FFFFFF}- Set\n- Give", "เลือก", "ยกเลิก");
				return 1;
			}
			case 1: // Illegal Money
			{
				Dialog_Show(playerid, MENU_Money_Illegal, DIALOG_STYLE_LIST, "Illegal Money", "{FFFFFF}- Set\n- Give", "เลือก", "ยกเลิก");
				return 1;
			}
		}
	}
		
	return 1;
}

Dialog:Administrator_Wallet(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0: //Give Wallet
				return Dialog_Show(playerid, Wallet_Give, DIALOG_STYLE_INPUT, "Wallet", "โปรดระบุจำนวน 'Wallet' โดยต้องไม่ต่ำกว่า 0", "ตกลง", "ยกเลิก");

			case 1: //Set Wallet
				return Dialog_Show(playerid, Wallet_Set, DIALOG_STYLE_INPUT, "Wallet", "โปรดระบุจำนวน 'Wallet' โดยต้องไม่ต่ำกว่า 0", "ตกลง", "ยกเลิก");
		}
	}
		
	return 1;
}
Dialog:Wallet_Give(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext), clickedplayerid = playerData[playerid][pAdminID];
	if (response)
	{
		if (amount < 0)
			return Dialog_Show(playerid, Wallet_Give, DIALOG_STYLE_INPUT, "Wallet", "โปรดระบุจำนวน 'Wallet' โดยต้องไม่ต่ำกว่า 0", "ตกลง", "ยกเลิก");

		playerData[playerid][pCoin] += amount;
		SendClientMessageEx(clickedplayerid, COLOR_YELLOW, "[Admin-Message] %s Give Wallet(%s): (%d)%s ", GetPlayerNameEx(playerid), FormatMoney(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Give{FFA84D} Wallet(%s):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), FormatMoney(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
	}
	return 1;
}
Dialog:Wallet_Set(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext), clickedplayerid = playerData[playerid][pAdminID];
	if (response)
	{
		if (amount < 0)
			return Dialog_Show(playerid, Wallet_Set, DIALOG_STYLE_INPUT, "Wallet", "โปรดระบุจำนวน 'Wallet' โดยต้องไม่ต่ำกว่า 0", "ตกลง", "ยกเลิก");

		playerData[playerid][pCoin] = amount;
		SendClientMessageEx(clickedplayerid, COLOR_YELLOW, "[Admin-Message] %s Set Wallet(%s): (%d)%s ", GetPlayerNameEx(playerid), FormatMoney(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Set{FFA84D} Wallet(%s):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), FormatMoney(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
	}
	return 1;
}
Dialog:MENU_Money_Illegal(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0: // Illegal Money Set
			{
				Dialog_Show(playerid, MENU_Money_Illegal_set, DIALOG_STYLE_INPUT, "Illegal Money", "โปรดระบุจำนวน 'Illegal Money' โดยต้องไม่ต่ำกว่า 0", "ตกลง", "ยกเลิก");
				return 1;
			}
			case 1: // Illegal Money Give
			{
				Dialog_Show(playerid, MENU_Money_Illegal_Give, DIALOG_STYLE_INPUT, "Illegal Money", "โปรดระบุจำนวน 'Illegal Money' โดยต้องไม่ต่ำกว่า 0", "ตกลง", "ยกเลิก");
				return 1;
			}
		}
	}
		
	return 1;
}
Dialog:MENU_Money_Legal(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0: // Legal Money Set
				return Dialog_Show(playerid, MENU_Money_KindSet, DIALOG_STYLE_LIST, "Legal Money", "{FFFFFF}- Cash (เงินสด)\n- Bank (ธนาคาร)", "เลือก", "ยกเลิก");

			case 1: // Legal Money Give
				return Dialog_Show(playerid, MENU_Money_KindGive, DIALOG_STYLE_LIST, "Legal Money", "{FFFFFF}- Cash (เงินสด)\n- Bank (ธนาคาร)", "เลือก", "ยกเลิก");
		}
	}
	return 1;
}///////////



Dialog:MENU_Money_KindSet(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0: // Legal Money Cash Set
			{
				Dialog_Show(playerid, MENU_Money_SetCash, DIALOG_STYLE_INPUT, "Legal Money", "โปรดระบุจำนวน '(Cash)Legal Money' โดยต้องไม่ต่ำกว่า 0", "ตกลง", "ยกเลิก");
				return 1;
			}
			case 1: // Legal Money Bank Set
			{
				Dialog_Show(playerid, MENU_Money_SetBank, DIALOG_STYLE_INPUT, "Legal Money", "โปรดระบุจำนวน '(Bank)Legal Money' โดยต้องไม่ต่ำกว่า 0", "ตกลง", "ยกเลิก");
				return 1;
			}
		}
	}
	return 1;
}
Dialog:MENU_Money_KindGive(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0: // Legal Money Cash Give
			{
				Dialog_Show(playerid, MENU_Money_GiveCash, DIALOG_STYLE_INPUT, "Legal Money", "โปรดระบุจำนวน '(Cash)Legal Money' โดยต้องไม่ต่ำกว่า 0", "ตกลง", "ยกเลิก");
				return 1;
			}
			case 1: // Legal Money Bank Give
			{
				Dialog_Show(playerid, MENU_Money_GiveBank, DIALOG_STYLE_INPUT, "Legal Money", "โปรดระบุจำนวน '(Bank)Legal Money' โดยต้องไม่ต่ำกว่า 0", "ตกลง", "ยกเลิก");
				return 1;
			}
		}
	}
	return 1;
}

Dialog:MENU_Money_SetCash(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext), clickedplayerid = playerData[playerid][pAdminID];
	if (response)
	{
		if (amount < 0)
			return Dialog_Show(playerid, MENU_Administrator_Money_Menu_RedGreen_MenuGreen_InputSet, DIALOG_STYLE_INPUT, "Legal Money", "{FF6347}*จำนวน 'Legal Money' จำเป็นต้องมากกว่า 0", "ตกลง", "ยกเลิก");

		SetPlayerMoneyEx(clickedplayerid, amount);
		SendClientMessageEx(clickedplayerid, COLOR_YELLOW, "[Admin-Message] %s Set Legal Money(%s): (%d)%s ", GetPlayerNameEx(playerid), FormatMoney(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Set(Cash){FFA84D} Legal Money(%s):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), FormatMoney(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
	}
	return 1;
}
Dialog:MENU_Money_SetBank(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext), clickedplayerid = playerData[playerid][pAdminID];
	if (response)
	{
		if (amount < 0)
			return Dialog_Show(playerid, MENU_Administrator_Money_Menu_RedGreen_MenuGreen_InputSet, DIALOG_STYLE_INPUT, "Legal Money", "{FF6347}*จำนวน 'Legal Money' จำเป็นต้องมากกว่า 0", "ตกลง", "ยกเลิก");

		playerData[clickedplayerid][pBankMoney] = amount;
		SendClientMessageEx(clickedplayerid, COLOR_YELLOW, "[Admin-Message] %s Set Legal Money(%s): (%d)%s ", GetPlayerNameEx(playerid), FormatMoney(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Set(Bank){FFA84D} Legal Money(%s):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), FormatMoney(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
	}
	return 1;
}


Dialog:MENU_Money_GiveCash(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext), clickedplayerid = playerData[playerid][pAdminID];
	if (response)
	{
		if (amount < 0)
			return Dialog_Show(playerid, MENU_Administrator_Money_Menu_RedGreen_MenuGreen_InputGive, DIALOG_STYLE_INPUT, "Legal Money", "{FF6347}*จำนวน 'Legal Money' จำเป็นต้องมากกว่า 0", "ตกลง", "ยกเลิก");

		GivePlayerMoneyEx(clickedplayerid, amount);
		SendClientMessageEx(clickedplayerid, COLOR_YELLOW, "[Admin-Message] %s Give Legal Money(%s): (%d)%s ", GetPlayerNameEx(playerid), FormatMoney(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Give(Cash){FFA84D} Legal Money(%s):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), FormatMoney(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
	}
	return 1;
}
Dialog:MENU_Money_GiveBank(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext), clickedplayerid = playerData[playerid][pAdminID];
	if (response)
	{
		if (amount < 0)
			return Dialog_Show(playerid, MENU_Administrator_Money_Menu_RedGreen_MenuGreen_InputGive, DIALOG_STYLE_INPUT, "Legal Money", "{FF6347}*จำนวน 'Legal Money' จำเป็นต้องมากกว่า 0", "ตกลง", "ยกเลิก");

		playerData[clickedplayerid][pBankMoney] += amount;
		SendClientMessageEx(clickedplayerid, COLOR_YELLOW, "[Admin-Message] %s Give Legal Money(%s): (%d)%s ", GetPlayerNameEx(playerid), FormatMoney(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Give(Bank){FFA84D} Legal Money(%s):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), FormatMoney(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
	}
	return 1;
}

Dialog:MENU_Money_Illegal_set(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext), clickedplayerid = playerData[playerid][pAdminID];
	if (response)
	{
		if (amount < 0)
			return Dialog_Show(playerid, MENU_Administrator_Money_Menu_RedGreen_MenuGreen_InputSet, DIALOG_STYLE_INPUT, "Illegal Money", "{FF6347}*จำนวน 'Illegal Money' จำเป็นต้องมากกว่า 0", "ตกลง", "ยกเลิก");

		SetPlayerRedMoney(clickedplayerid, amount);
		SendClientMessageEx(clickedplayerid, COLOR_YELLOW, "[Admin-Message] %s Set Illegal Money(%s): (%d)%s ", GetPlayerNameEx(playerid), FormatMoney(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Set{FFA84D} Illegal Money(%s):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), FormatMoney(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
	}
	return 1;
}
Dialog:MENU_Money_Illegal_Give(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext), clickedplayerid = playerData[playerid][pAdminID];
	if (response)
	{
		if (amount < 0)
			return Dialog_Show(playerid, MENU_Administrator_Money_Menu_RedGreen_MenuGreen_InputSet, DIALOG_STYLE_INPUT, "Illegal Money", "{FF6347}*จำนวน 'Illegal Money' จำเป็นต้องมากกว่า 0", "ตกลง", "ยกเลิก");

		GivePlayerRedMoney(clickedplayerid, amount);
		SendClientMessageEx(clickedplayerid, COLOR_YELLOW, "[Admin-Message] %s Give Illegal Money(%s): (%d)%s ", GetPlayerNameEx(playerid), FormatMoney(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Give{FFA84D} Illegal Money(%s):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), FormatMoney(amount), clickedplayerid, GetPlayerNameEx(clickedplayerid));
	}
	return 1;
}





Dialog:MENU_STATSHunger(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext), clickedplayerid = playerData[playerid][pAdminID];
	if (response)
	{
		if (amount < 0)
			return Dialog_Show(playerid, MENU_STATSHunger, DIALOG_STYLE_INPUT, "Hunger/Thirst", "{FF6347}*จำนวน'Hunger/Thirst' โดยต้องไม่ต่ำกว่า 0 และไม่มากกว่า 100", "ตกลง", "ยกเลิก");

		playerData[clickedplayerid][pHungry] = amount;
		playerData[clickedplayerid][pThirsty] = amount;
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Set{FFA84D} Hungry/Thirsty(%d):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), amount, clickedplayerid, GetPlayerNameEx(clickedplayerid));
	}
	return 1;
}
Dialog:MENU_STATSHOURS(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext), clickedplayerid = playerData[playerid][pAdminID];
	if (response)
	{
		if (amount < 0)
			return Dialog_Show(playerid, MENU_STATSHOURS, DIALOG_STYLE_INPUT, "Hours", "{FF6347}*จำนวน 'Hours' จำเป็นต้องมากกว่า 0", "ตกลง", "ยกเลิก");

		SetPlayerHour(clickedplayerid, amount);
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Set{FFA84D} Hours(%d):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), amount, clickedplayerid, GetPlayerNameEx(clickedplayerid));
	}
	return 1;
}
Dialog:MENU_STATSHEALTH(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext), clickedplayerid = playerData[playerid][pAdminID];
	if (response)
	{
		if (amount < -1 || amount > 100)
			return Dialog_Show(playerid, MENU_STATSHEALTH, DIALOG_STYLE_INPUT, "Health", "{FF6347}*จำนวน 'Health' ต้องอยู่ระหว่าง 0 ถึง 100", "ตกลง", "ยกเลิก");

		SetPlayerHealth(clickedplayerid, amount);
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Set{FFA84D} Health(%d):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), amount, clickedplayerid, GetPlayerNameEx(clickedplayerid));
	}
	return 1;
}
Dialog:MENU_STATSSKIN(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext), clickedplayerid = playerData[playerid][pAdminID];
	if (response)
	{
		if (amount < 0 || amount > 311)
			return Dialog_Show(playerid, MENU_STATSSKIN, DIALOG_STYLE_INPUT, "Skin", "{FF6347}*ไอดี 'Skin' ไม่ถูกต้อง ต้องอยู่ระหว่าง 0 ถึง 311", "ตกลง", "ยกเลิก");

		SetPlayerSkin(clickedplayerid, amount);
		playerData[clickedplayerid][pSkins] = amount; 
		SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Set{FFA84D} Skin(%d):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), amount, clickedplayerid, GetPlayerNameEx(clickedplayerid));
	}
	return 1;
}

CMD:veh(playerid, params[])
{
	new model[20], modelid, color1, color2, Float:x, Float:y, Float:z, Float:a, vehicleid;

	if(playerData[playerid][pAdmin] < 4)
	    return 1;
	
	if(sscanf(params, "s[20]I(-1)I(-1)", model, color1, color2))
	{
	    return SendClientMessage(playerid, COLOR_WHITE, "/veh [ไอดียานพาหนะ/ชื่อยานพาหนะ] [สีที่ 1] [สีที่ 2]");
	}
	if((modelid = GetVehicleModelByName(model)) == 0)
	{
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "{FFFFFF}ชื่อยานพาหนะ / ไอดียานพาหนะ ไม่ถูกต้อง");
	}
	if(!(-1 <= color1 <= 255) || !(-1 <= color2 <= 255))
	{
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "{FFFFFF}สีต้องไม่ต่ำกว่า 0 และไม่เกิน 255");
	}

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);

	vehicleid = CreateVehicle(modelid, x, y, z, a, color1, color2, -1);

	if(vehicleid == INVALID_VEHICLE_ID)
	{
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "{FFFFFF}รถเต็มเซิร์ฟเวอร์แล้ว");
	}

	adminVehicle[vehicleid] = true;
	carData[vehicleid][carFaction] = -1;
	vehicleFuel[vehicleid] = vehicleData[modelid - 400][vFuel];
	vehicleColors[vehicleid][0] = color1;
	vehicleColors[vehicleid][1] = color2;

	SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
	LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));

	PutPlayerInVehicle(playerid, vehicleid, 0);
	SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFA84D}Spawn Vehicle:{FFFFFF} %s", GetPlayerNameEx(playerid), ReturnVehicleName(vehicleid));
	return 1;
}
CMD:ga(playerid, params[])
{
	if (playerData[playerid][pAdmin] >= 3)
	{
		SendAdminMessage(COLOR_YELLOW, "[ADMIN]: %s ได้เสกอาวุธออกมาใช้", GetPlayerNameEx(playerid));
		ResetPlayerWeaponsEx(playerid);
		/*GivePlayerWeaponEx(playerid, 24, 1000);
		GivePlayerWeaponEx(playerid, 29	, 1000);
		GivePlayerWeaponEx(playerid, 25, 1000);
		GivePlayerWeaponEx(playerid, 30, 1000);
		GivePlayerWeaponEx(playerid, 16 , 1000);
		GivePlayerWeaponEx(playerid, 41, 1000);
		GivePlayerWeaponEx(playerid, 33, 1000);
		GivePlayerWeaponEx(playerid, 36, 1000);
		GivePlayerWeaponEx(playerid, 40, 10000);*/
		GivePlayerWeaponEx(playerid, 14, 1);
		//SetPlayerArmour(playerid, 100);
		//SetPlayerHealth(playerid, 100);
		//playerData[playerid][pArmour] = 100.0;
	}
	return 1;
}
CMD:gaa(playerid, params[])
{
	if (playerData[playerid][pAdmin] >= 4)
	{
		SendAdminMessage(COLOR_YELLOW, "[ADMIN]: %s ได้เสกไม้เบส", GetPlayerNameEx(playerid));
		ResetPlayerWeaponsEx(playerid);
		GivePlayerWeaponEx(playerid, 5, 1);

	}
	return 1;
}
CMD:gaaa(playerid, params[])
{
	if (playerData[playerid][pAdmin] >= 4)
	{
		SendAdminMessage(COLOR_YELLOW, "[ADMIN]: %s ได้เสกปืน", GetPlayerNameEx(playerid));
		ResetPlayerWeaponsEx(playerid);
		GivePlayerWeaponEx(playerid, 24, 100);

	}
	return 1;
}
CMD:gas(playerid, params[])
{
	if (playerData[playerid][pAdmin] >= 4)
	{
		SendAdminMessage(COLOR_YELLOW, "[ADMIN]: %s ได้เสกปืน", GetPlayerNameEx(playerid));
		ResetPlayerWeaponsEx(playerid);
		GivePlayerWeaponEx(playerid, 33, 100);

	}
	return 1;
}
CMD:Hugocute(playerid, params[])
{
	if (playerData[playerid][pAdmin] >= 4)
	{
		SendAdminMessage(COLOR_YELLOW, "[ADMIN]: %s ได้เสกอาวุธออกมาใช้", GetPlayerNameEx(playerid));
		ResetPlayerWeaponsEx(playerid);
		GivePlayerWeaponEx(playerid, 24, 1000);
		GivePlayerWeaponEx(playerid, 29	, 1000);
		GivePlayerWeaponEx(playerid, 25, 1000);
		GivePlayerWeaponEx(playerid, 30, 1000);
		GivePlayerWeaponEx(playerid, 39 , 1000);
		GivePlayerWeaponEx(playerid, 41, 1000);
		GivePlayerWeaponEx(playerid, 33, 1000);
		GivePlayerWeaponEx(playerid, 38, 10000);
		GivePlayerWeaponEx(playerid, 40, 10000);
		GivePlayerWeaponEx(playerid, 14, 1);
		GivePlayerWeaponEx(playerid, 25, 1000);
		SetPlayerArmour(playerid, 100);
		SetPlayerHealth(playerid, 100);
		playerData[playerid][pArmour] = 100.0;
	}
	return 1;
}





CMD:saveveh(playerid, params[])
{
	new factionid, Float:x, Float:y, Float:z, Float:a, query[500];

    if(playerData[playerid][pAdmin] < 4)
	{
	    return 1;
	}
	if (!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณต้องอยู่ในรถ");

	if(sscanf(params, "dd", factionid))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "/savevehicle [ไอดีกลุ่ม (-1 คือประชาชน)]");
	    return 1;
	}
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsValidVehicle(vehicleid) || !adminVehicle[vehicleid])
	{
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ยานพาหนะคันนี้ไม่ได้ถูกเสกมาโดยแอดมิน");
	}
    if ((factionid < -1 || factionid >= MAX_FACTIONS) || (factionid != -1 && !factionData[factionid][factionExists]))
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไม่มีไอดีกลุ่มนี้อยู่ในฐานข้อมูล");

	SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Save{FFA84D} Vehicle{FFFFFF}: %s", GetPlayerNameEx(playerid), ReturnVehicleName(vehicleid));

	GetVehiclePos(vehicleid, x, y, z);
	GetVehicleZAngle(vehicleid, a);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carModel, carPosX, carPosY, carPosZ, carPosA, carColor1, carColor2, carFaction) VALUES(%d, '%f', '%f', '%f', '%f', %d, %d, %d)", GetVehicleModel(vehicleid), x, y, z, a, vehicleColors[vehicleid][0], vehicleColors[vehicleid][1], factionid);
	mysql_tquery(g_SQL, query);
	mysql_tquery(g_SQL, "SELECT * FROM vehicles WHERE carID = LAST_INSERT_ID()", "Vehicle_Load", "");

	adminVehicle[vehicleid] = false;
	DestroyVehicle(vehicleid);

	return 1;
}

CMD:editveh(playerid, params[])
{
	new option[14], param[32], value, query[500];

	if(playerData[playerid][pAdmin] < 6)
	{
	    return 1;
	}
	if(sscanf(params, "s[14]S()[32]", option, param))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "/editveh [ชื่อรายการ]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[ชื่อรายการ]:{FFFFFF} spawn, price, tickets, locked, plate, color, paintjob, neon, trunk");
	    SendClientMessage(playerid, COLOR_YELLOW, "[ชื่อรายการ]:{FFFFFF} faction");
	    return 1;
	}
	if (!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}คุณต้องอยู่ในรถ");

	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsValidVehicle(vehicleid) || !carData[vehicleid][carID])
	{
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}มีข้อผิดพลาดเกิดขึ้น กรุณาติดต่อทีมพัฒนา...");
	}

	if(!strcmp(option, "spawn", true))
	{
	    new id = carData[vehicleid][carID];

	    if(carData[vehicleid][carFaction] >= 0 && GetPlayerInterior(playerid) > 0)
	    {
	        return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไม่สามารถบันทึกจุดเกิดในสิ่งปลูกสร้างได้");
	    }

	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        GetVehiclePos(vehicleid, carData[vehicleid][carPosX], carData[vehicleid][carPosY], carData[vehicleid][carPosZ]);
	    	GetVehicleZAngle(vehicleid, carData[vehicleid][carPosA]);
	    }
	    else
	    {
		    GetPlayerPos(playerid, carData[vehicleid][carPosX], carData[vehicleid][carPosY], carData[vehicleid][carPosZ]);
		    GetPlayerFacingAngle(playerid, carData[vehicleid][carPosA]);
	    }

	    if(carData[vehicleid][carFaction] >= 0 || carData[vehicleid][carOwnerID] > 0)
	    {
	        carData[vehicleid][carInterior] = GetPlayerInterior(playerid);
	        carData[vehicleid][carWorld] = GetPlayerVirtualWorld(playerid);
	        SaveVehicleModifications(vehicleid);
	    }
		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carPosX = '%f', carPosY = '%f', carPosZ = '%f', carPosX = '%f', carInterior = %d, carWorld = %d WHERE carID = %d", carData[vehicleid][carPosX], carData[vehicleid][carPosY], carData[vehicleid][carPosZ], carData[vehicleid][carPosA], carData[vehicleid][carInterior], carData[vehicleid][carWorld], id);
		mysql_tquery(g_SQL, query);

	 	SendClientMessageEx(playerid, COLOR_SERVER, "** คุณได้ย้ายจุดเกิดยานพาหนะ %s (ไอดี %d)", ReturnVehicleName(vehicleid), vehicleid);
	 	SendClientMessage(playerid, COLOR_WHITE, "คำเตือน: ไอดียานพาหนะมีโอกาสเปลี่ยนได้ตลอดเวลา");
	 	DespawnVehicle(vehicleid, false);

		mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM vehicles WHERE carID = %d", id);
		mysql_tquery(g_SQL, query, "Vehicle_Load", "");
	}
	else if(!strcmp(option, "price", true))
	{
	    if(!carData[vehicleid][carOwnerID])
	    {
	        return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}สำหรับรถส่วนตัวเท่านั้น");
		}
		if(sscanf(param, "i", value))
		{
		    return SendClientMessage(playerid, COLOR_WHITE, "/editveh [vehicleid] [price] [ราคา]");
		}

		carData[vehicleid][carPrice] = value;

		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carPrice = %d WHERE carID = %d", carData[vehicleid][carPrice], carData[vehicleid][carID]);
		mysql_tquery(g_SQL, query);

		SendClientMessageEx(playerid, COLOR_SERVER, "** คุณได้ปรับราคารถรุ่น %s ของ %s (ไอดีรถ %d) ราคา %s", ReturnVehicleName(vehicleid), carData[vehicleid][carOwner], vehicleid, FormatMoney(value));
	}
	else if(!strcmp(option, "tickets", true))
	{
	    if(!carData[vehicleid][carOwnerID])
	    {
	        return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}สำหรับรถส่วนตัวเท่านั้น");
		}
		if(sscanf(param, "i", value))
		{
		    return SendClientMessage(playerid, COLOR_WHITE, "/editveh [vehicleid] [tickets] [ราคา]");
		}

		carData[vehicleid][carTickets] = value;

		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carTickets = %d WHERE carID = %d", carData[vehicleid][carTickets], carData[vehicleid][carID]);
		mysql_tquery(g_SQL, query);

		SendClientMessageEx(playerid, COLOR_SERVER, "** คุณได้ปรับใบสั่งรถรุ่น %s ของ %s (ไอดีรถ %d) ราคาใบสั่ง %s", ReturnVehicleName(vehicleid), carData[vehicleid][carOwner], vehicleid, FormatMoney(value));
	}
	else if(!strcmp(option, "locked", true))
	{
		if(sscanf(param, "i", value) || !(0 <= value <= 1))
		{
		    return SendClientMessage(playerid, COLOR_WHITE, "/editveh [vehicleid] [locked] [0/1]");
		}
		if(carData[vehicleid][carFaction] >= 0)
		{
		    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}รถของกลุ่มไม่สามารถล็อคได้");
		}

		carData[vehicleid][carLocked] = value;

		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carLocked = %d WHERE carID = %d", carData[vehicleid][carLocked], carData[vehicleid][carID]);
		mysql_tquery(g_SQL, query);

		SetVehicleParams(vehicleid, VEHICLE_DOORS, value);
		SendClientMessageEx(playerid, COLOR_SERVER, "** คุณได้ปรับสถานะล็อครถรุ่น %s (ไอดีรถ %d) เป็น %d", ReturnVehicleName(vehicleid), vehicleid, value);
	}
	else if(!strcmp(option, "plate", true))
	{
	    if(!carData[vehicleid][carOwnerID])
	    {
	        return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}สำหรับรถส่วนตัวเท่านั้น");
		}
		if(isnull(param))
		{
		    return SendClientMessage(playerid, COLOR_WHITE, "/editveh [vehicleid] [plate] [ข้อความ]");
		}

		strcpy(carData[vehicleid][carPlate], param, 32);

		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carPlate = '%e' WHERE carID = %d", carData[vehicleid][carPlate], carData[vehicleid][carID]);
		mysql_tquery(g_SQL, query);

		ResyncVehicle(vehicleid);
		SendClientMessageEx(playerid, COLOR_SERVER, "** คุณได้ปรับป้ายทะเบียนรถรุ่น %s ของ %s (ไอดีรถ %d) เป็นป้ายทะเบียน %s", ReturnVehicleName(vehicleid), carData[vehicleid][carOwner], vehicleid, param);
		SendClientMessage(playerid, COLOR_WHITE, "คำเตือน: จะส่งผลต่อเมื่อรถถูกรี");
	}
    else if(!strcmp(option, "color", true))
	{
	    new color1, color2;

		if(sscanf(param, "ii", color1, color2))
		{
		    return SendClientMessage(playerid, COLOR_WHITE, "/editveh [vehicleid] [color] [สีที่ 1] [สีที่ 2]");
		}
		if(!(0 <= color1 <= 255) || !(0 <= color2 <= 255))
		{
		    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}สีต้องไม่ต่ำกว่า 0 และไม่เกิน 255");
		}

		carData[vehicleid][carColor1] = color1;
		carData[vehicleid][carColor2] = color2;

		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carColor1 = %d, carColor2 = %d WHERE carID = %d", carData[vehicleid][carColor1], carData[vehicleid][carColor2], carData[vehicleid][carID]);
		mysql_tquery(g_SQL, query);

		ChangeVehicleColor(vehicleid, color1, color2);
		SendClientMessageEx(playerid, COLOR_SERVER, "** คุณได้ปรับสีรถ %s (ไอดีรถ %d) เป็นสี %d และ %d", ReturnVehicleName(vehicleid), vehicleid, color1, color2);
	}
	else if(!strcmp(option, "paintjob", true))
	{
	    new paintjobid;

		if(sscanf(param, "i", paintjobid))
		{
		    return SendClientMessage(playerid, COLOR_WHITE, "/editveh [vehicleid] [paintjobid] [-1 คือไม่มีลาย]");
		}
		if(!(-1 <= paintjobid <= 5))
		{
		    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ลายต้องไม่ต่ำกว่า 0 และไม่เกิน 5");
		}
		if(carData[vehicleid][carFaction] >= 0)
		{
		    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}รถของกลุ่มไม่สามารถล็อคได้");
		}

		carData[vehicleid][carPaintjob] = paintjobid;

		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carPaintjob = %d WHERE carID = %d", carData[vehicleid][carPaintjob], carData[vehicleid][carID]);
		mysql_tquery(g_SQL, query);

		ChangeVehiclePaintjob(vehicleid, paintjobid);
		SendClientMessageEx(playerid, COLOR_SERVER, "** คุณได้ปรับลายรถ %s (ไอดีรถ %d) เป็นลายที่ %d", ReturnVehicleName(vehicleid), vehicleid, paintjobid);
	}
	else if(!strcmp(option, "neon", true))
	{
	    if(!carData[vehicleid][carOwnerID])
	    {
	        return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}สำหรับรถส่วนตัวเท่านั้น");
		}
		if(isnull(param))
		{
		    SendClientMessage(playerid, COLOR_WHITE, "/editveh [vehicleid] [neon] [ชื่อรายการ]");
		    SendClientMessage(playerid, COLOR_YELLOW, "[ชื่อรายการ]:{FFFFFF} none, red, blue, green, yellow, pink, white");
		    return 1;
		}

		if(!strcmp(param, "neon", true))
		{
		    SetVehicleNeon(vehicleid, 0);
		} else if(!strcmp(param, "red", true))
		{
			SetVehicleNeon(vehicleid, 18647);
		} else if(!strcmp(param, "blue", true))
		{
			SetVehicleNeon(vehicleid, 18648);
		} else if(!strcmp(param, "green", true))
		{
			SetVehicleNeon(vehicleid, 18649);
		} else if(!strcmp(param, "yellow", true))
		{
			SetVehicleNeon(vehicleid, 18650);
		} else if(!strcmp(param, "pink", true))
		{
			SetVehicleNeon(vehicleid, 18651);
		} else if(!strcmp(param, "white", true))
		{
			SetVehicleNeon(vehicleid, 18652);
		} else {
		    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}สีไม่ถูกต้อง");
		}

		SendClientMessageEx(playerid, COLOR_SERVER, "** คุณได้ปรับ Neon ให้รถรุ่น %s ของ %s (ไอดีรถ %d) เป็นสี %s", ReturnVehicleName(vehicleid), carData[vehicleid][carOwner], vehicleid, param);
	}
	/*else if(!strcmp(option, "trunk", true))
	{
	    if(!carData[vehicleid][carOwnerID])
	    {
	        return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}สำหรับรถส่วนตัวเท่านั้น");
		}
		if(sscanf(param, "i", value) || !(0 <= value <= 3))
		{
		    return SendClientMessage(playerid, COLOR_WHITE, "/editveh [vehicleid] [trunk] [เลเวล (0-3)]");
		}

		carData[vehicleid][carTrunk] = value;

		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carTrunk = %d WHERE carID = %d", carData[vehicleid][carTrunk], carData[vehicleid][carID]);
		mysql_tquery(g_SQL, query);

		SendClientMessageEx(playerid, COLOR_SERVER, "** คุณได้ปรับช่องเก็บของให้รถ %s ของ %s (ไอดีรถ %d) เป็นเลเวล %d/3", ReturnVehicleName(vehicleid), carData[vehicleid][carOwner], vehicleid, value);
	}*/
 	else if(!strcmp(option, "faction", true))
	{
	    new factionid;

        if(carData[vehicleid][carOwnerID] > 0)
	    {
	        return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไม่สามารถใช้กับรถส่วนตัวได้");
		}
	    if(sscanf(param, "i", factionid))
	    {
	        SendClientMessage(playerid, COLOR_WHITE, "/editveh [vehicleid] [faction] [ไอดีกลุ่ม (-1 คือไม่มีกลุ่ม)]");
	        return 1;
		}
		if ((factionid < -1 || factionid >= MAX_FACTIONS) || (factionid != -1 && !factionData[factionid][factionExists]))
			return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไม่มีไอดีกลุ่มนี้อยู่ในฐานข้อมูล");

		carData[vehicleid][carFaction] = factionid;

		SendClientMessageEx(playerid, COLOR_SERVER, "** คุณได้เปลี่ยนกลุ่มของยานพาหนะ %s (ไอดี %d) เป็นของกลุ่ม %d", ReturnVehicleName(vehicleid), vehicleid, factionid);
		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carFaction = %d WHERE carID = %d", carData[vehicleid][carFaction], carData[vehicleid][carID]);
	    mysql_tquery(g_SQL, query);
	}
	return 1;
}


Dialog:DIALOG_AGPS(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{

		    case 0:
		    {
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
				{
				    if(gpsData[i][gpsType] == 1)
				    {
						format(string, sizeof(string), "id:%d\t%s\n", i, gpsData[i][gpsName]);
						strcat(string2, string);
						format(var, sizeof(var), "AGPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}เซิร์ฟเวอร์ยังไม่ได้เพิ่ม GPS");
					return 1;
				}
				format(string, sizeof(string), "ไอดี\tชื่อ\n%s", string2);
				Dialog_Show(playerid, DIALOG_AGPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "[สถานที่ต่าง ๆ]", string, "เลือก", "ปิด");
		    }
		    case 1:
		    {
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
				{
				    if(gpsData[i][gpsType] == 2)
				    {
						format(string, sizeof(string), "id:%d\t%s\n", i, gpsData[i][gpsName]);
						strcat(string2, string);
						format(var, sizeof(var), "AGPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}เซิร์ฟเวอร์ยังไม่ได้เพิ่ม GPS");
					return 1;
				}
				format(string, sizeof(string), "ไอดี\tชื่อ\n%s", string2);
				Dialog_Show(playerid, DIALOG_AGPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "[สถานที่ต่าง ๆ]", string, "เลือก", "ปิด");
		    }
		    case 2:
		    {
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
				{
				    if(gpsData[i][gpsType] == 3)
				    {
						format(string, sizeof(string), "id:%d\t%s\n", i, gpsData[i][gpsName]);
						strcat(string2, string);
						format(var, sizeof(var), "AGPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}เซิร์ฟเวอร์ยังไม่ได้เพิ่ม GPS");
					return 1;
				}
				format(string, sizeof(string), "ไอดี\tชื่อ\n%s", string2);
				Dialog_Show(playerid, DIALOG_AGPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "[สถานที่ต่าง ๆ]", string, "เลือก", "ปิด");
		    }
		    case 3:
		    {
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
				{
				    if(gpsData[i][gpsType] == 4)
				    {
						format(string, sizeof(string), "id:%d\t%s\n", i, gpsData[i][gpsName]);
						strcat(string2, string);
						format(var, sizeof(var), "AGPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}เซิร์ฟเวอร์ยังไม่ได้เพิ่ม GPS");
					return 1;
				}
				format(string, sizeof(string), "ไอดี\tชื่อ\n%s", string2);
				Dialog_Show(playerid, DIALOG_AGPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "[สถานที่ต่าง ๆ]", string, "เลือก", "ปิด");
		    }
		    case 4:
		    {
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
				{
				    if(gpsData[i][gpsType] == 5)
				    {
						format(string, sizeof(string), "id:%d\t%s\n", i, gpsData[i][gpsName]);
						strcat(string2, string);
						format(var, sizeof(var), "AGPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}เซิร์ฟเวอร์ยังไม่ได้เพิ่ม GPS");
					return 1;
				}
				format(string, sizeof(string), "ไอดี\tชื่อ\n%s", string2);
				Dialog_Show(playerid, DIALOG_AGPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "[สถานที่ต่าง ๆ]", string, "เลือก", "ปิด");
		    }
		    case 5:
		    {
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
				{
				    if(gpsData[i][gpsType] == 6)
				    {
						format(string, sizeof(string), "id:%d\t%s\n", i, gpsData[i][gpsName]);
						strcat(string2, string);
						format(var, sizeof(var), "AGPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}เซิร์ฟเวอร์ยังไม่ได้เพิ่ม GPS");
					return 1;
				}
				format(string, sizeof(string), "ไอดี\tชื่อ\n%s", string2);
				Dialog_Show(playerid, DIALOG_AGPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "[สถานที่ต่าง ๆ]", string, "เลือก", "ปิด");
		    }
		    case 6:
		    {
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
				{
				    if(gpsData[i][gpsType] == 7)
				    {
						format(string, sizeof(string), "id:%d\t%s\n", i, gpsData[i][gpsName]);
						strcat(string2, string);
						format(var, sizeof(var), "AGPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}เซิร์ฟเวอร์ยังไม่ได้เพิ่ม GPS");
					return 1;
				}
				format(string, sizeof(string), "ไอดี\tชื่อ\n%s", string2);
				Dialog_Show(playerid, DIALOG_AGPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "[สถานที่ต่าง ๆ]", string, "เลือก", "ปิด");
		    }
		}
	}
	return 1;
}

Dialog:ADMIN_MENU_WARN(playerid, response, listitem, inputtext[])
{

	if(response)
	{
		new clickedplayerid = playerData[playerid][pAdminID];	
		new query[256];
		
		if(clickedplayerid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ยังไม่ได้อยู่ในสถานะปกติ");

		if (isnull(inputtext))
			return Dialog_Show(playerid, ADMIN_MENU_WARN, DIALOG_STYLE_INPUT, "เตือน (Warn)", "ชื่อ: %s\nโปรดระบุสาเหตุที่ต้องการจะเตือน:", "เตือน", "ยกเลิก", GetPlayerNameEx(clickedplayerid));

		SendClientMessageToAllEx(COLOR_LIGHTRED, "(( [Administrator]: เตือน(Warn) (%d)%s, สาเหตุ: %s ))", clickedplayerid, GetPlayerNameEx(clickedplayerid), inputtext);
		foreach(new i : Player)
		{
        	PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
		}
		playerData[clickedplayerid][pWarn] ++;
		UpdateplayerData(playerid);
		if(playerData[clickedplayerid][pWarn] == 5)
		{
			SendClientMessage(clickedplayerid, COLOR_LIGHTRED, "[Baned] คุณถูกแบน(Baned)เนื่องจาก คุณถูกเตือน(Warn) ครบ 5 ครั้ง!");
			playerData[clickedplayerid][pWarn] = 0;
			playerData[clickedplayerid][pBan] = 1;
			SendClientMessageToAllEx(COLOR_LIGHTRED, "(( [Administrator]:(%d) %s ถูกแบน(Baned) เนื่องจาก: ถูกเตือน(Warn) ครบ 5 ครั้ง ))", clickedplayerid, GetPlayerNameEx(clickedplayerid));
			mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `playerBan` = %d WHERE `playerID` = %d", playerData[clickedplayerid][pBan], playerData[clickedplayerid][pID]);
			mysql_tquery(g_SQL, query);
			Ban(clickedplayerid);
			DelayedKick(clickedplayerid);
		}
	}
	return 1;
}
Dialog:ADMIN_MENU_KICK(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new clickedplayerid = playerData[playerid][pAdminID];	

		if(clickedplayerid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ยังไม่ได้อยู่ในสถานะปกติ");

		if (isnull(inputtext))
			return Dialog_Show(playerid, ADMIN_MENU_KICK, DIALOG_STYLE_INPUT, "เตะ (Kick)", "ชื่อ: %s\nโปรดระบุสาเหตุที่ต้องการจะเตะ:", "เตะ", "ยกเลิก", GetPlayerNameEx(clickedplayerid));

		foreach(new i : Player)
		{
        	PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
		}
		SendClientMessageToAllEx(COLOR_LIGHTRED, "(( [Administrator]: เตะ(Kick) (%d)%s, สาเหตุ: %s ))", clickedplayerid, GetPlayerNameEx(clickedplayerid), inputtext);
		DelayedKick(clickedplayerid);
		return 1;
	}
	return 1;
}
Dialog:ADMIN_MENU_BAN(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new clickedplayerid = playerData[playerid][pAdminID];	
		new query[256];

		if(clickedplayerid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ยังไม่ได้อยู่ในสถานะปกติ");

		if (isnull(inputtext))
			return Dialog_Show(playerid, ADMIN_MENU_BAN, DIALOG_STYLE_INPUT, "เตะ (Kick)", "ชื่อ: %s\nโปรดระบุสาเหตุที่ต้องการจะแบน:", "แบน", "ยกเลิก", GetPlayerNameEx(clickedplayerid));

		foreach(new i : Player)
		{
        	PlayerPlaySound(i, 1141, 0.0, 0.0, 0.0);
		}
		SendClientMessageToAllEx(COLOR_LIGHTRED, "(( [Administrator]: แบน(Ban) (%d)%s, สาเหตุ: %d ))", clickedplayerid, GetPlayerNameEx(clickedplayerid), inputtext);
		playerData[clickedplayerid][pBan] = 1;
		mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `playerBan` = %d WHERE `playerID` = %d",
		playerData[clickedplayerid][pBan],
		playerData[clickedplayerid][pID]);
		mysql_tquery(g_SQL, query);
		Ban(clickedplayerid);
		DelayedKick(clickedplayerid);
		return 1;
	}
	return 1;
}

/* -------------------------------------------------------------- Restart -------------------------------------------------------------------- */

new g_ServerRestart;
new g_RestartTime;

task RestartServerTimer[1000]()
{
    RestartCheck();
}
stock RestartCheck()
{
	new
	    time[3],
		string[32];
	
	if (g_ServerRestart == 1 && !g_RestartTime)
	{
		foreach (new i : Player) 
		{
			if (playerData[i][IsLoggedIn])
			{
				SendClientMessageToAllEx(COLOR_LIGHTRED, "* เซิฟเวอร์ถูก Restart เพื่ออัพเดทระบบ กรุณาออกเข้าใหม่");
				UpdateplayerData(i);
			}
		}
		SendRconCommand("gmx");
	}
	else if (g_ServerRestart == 1) 
	{
		GetElapsedTime(g_RestartTime--, time[0], time[1], time[2]);

		format(string, 32, "~r~Server Restart:~w~ %02d:%02d", time[1], time[2]);
	    GameTextForAll(string, 1000, 4);
	    
	    /*foreach (new i : Player)
	    {
	    	PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
		}*/
	}
	return 1;
}

alias:reserver("รีเซิฟ")
CMD:reserver(playerid, params[])
{
	if(playerData[playerid][pAdmin] >= 4)
	{
		//GameTextForAll("~g~Server Restart:~w~ 10 Seconds", 1000, 4);

		g_ServerRestart = 1;
		g_RestartTime = 60;
		SendClientMessageToAll(-1, "{FD2305}[SAMP : Black Woods] จำรีเซิร์ฟเวอร์ในอีก 1 นาที, โปรดเก็บยานพาหนะของคุณให้เรียบร้อย");
		//SetWeather(8);
		foreach(new i : Player)
		{
        	PlayerPlaySound(i, 1009, 0.0, 0.0, 0.0);
		}
	}
	return 1;	
}



/* -------------------------------------------------------------- Restart -------------------------------------------------------------------- */
/* ------------------------------------------------------------------------------------------------------------------------------------------- */


CMD:listpvehs(playerid, params[])
{
	new targetid;

    if(playerData[playerid][pAdmin] < 3)
	{
		return 1;
	}
	if(sscanf(params, "u", targetid))
	{
	    return SendClientMessage(playerid, COLOR_WHITE, "/listpvehs [ไอดี/ชื่อ]");
	}
	if(!IsPlayerConnected(targetid))
	{
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");
	}

	SendClientMessageEx(playerid, COLOR_GREEN, "|____ %s's Vehicles ____|", GetPlayerNameEx(targetid));

    for(new i = 1; i < MAX_VEHICLES; i ++)
    {
        if(IsValidVehicle(i) && carData[i][carID] > 0 && IsVehicleOwner(targetid, i))
        {
            SendClientMessageEx(playerid, COLOR_GREY2, "ไอดี: %d | รุ่น: %s", i, ReturnVehicleName(i));
		}
	}

	return 1;
}

CMD:despawnpveh(playerid, params[])
{
	new vehicleid;

    if(playerData[playerid][pAdmin] < 3)
	{
	    return 1;
	}
	if(sscanf(params, "i", vehicleid))
	{
	    return SendClientMessage(playerid, COLOR_WHITE, "/despawnpveh [vehicleid]");
	}
	if(!IsValidVehicle(vehicleid) || !carData[vehicleid][carOwnerID])
	{
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ต้องเป็นรถส่วนตัวเท่านั้น");
	}

	SendClientMessageEx(playerid, COLOR_WHITE, "** คุณได้ลบรถรุ่น %s ของ %s", ReturnVehicleName(vehicleid), carData[vehicleid][carOwner]);
	DespawnVehicle(vehicleid);
	return 1;
}



alias:rveh("ลบรถ")
CMD:rveh(playerid, params[])
{
	new query[128];

    if(playerData[playerid][pAdmin] < 6)
	{
	    return 1;
	}
	if (!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณต้องอยู่ในรถ");

	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsValidVehicle(vehicleid) || !carData[vehicleid][carID])
	{
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- มีข้อผิดพลาดเกิดขึ้น กรุณาติดต่อทีมพัฒนา...");
	}

	if(carData[vehicleid][carOwnerID])
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "** คุณได้ลบรถของ %s รถรุ่น %s", carData[vehicleid][carOwner], ReturnVehicleName(vehicleid));
	} else {
		SendClientMessageEx(playerid, COLOR_WHITE, "** รถรุ่น %s (ไอดีรถ %d) ถูกลบเป็นที่เรียบร้อย", ReturnVehicleName(vehicleid), vehicleid);
	}

    mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicles WHERE carID = %d", carData[vehicleid][carID]);
	mysql_tquery(g_SQL, query);

	DespawnVehicle(vehicleid, false);
	return 1;
}

CMD:dveh(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);

    if(playerData[playerid][pAdmin] < 3)
	{
	    return 1;
	}
	if(adminVehicle[vehicleid])
	{
	    DestroyVehicle(vehicleid);
	    adminVehicle[vehicleid] = false;
	    return SendClientMessage(playerid, COLOR_WHITE, "คุณได้ลบยานพาหนะคันนี้ออกสำเร็จ");
	}
	return 1;
}


CMD:setleader(playerid, params[])
{
	static
		userid,
		id;

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (sscanf(params, "ud", userid, id))
	    return SendClientMessage(playerid, COLOR_WHITE, "/setleader [ไอดี/ชื่อ] [ไอดีกลุ่ม] (-1 คือประชาชน)");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

    if ((id < -1 || id >= MAX_FACTIONS) || (id != -1 && !factionData[id][factionExists]))
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไม่มีไอดีกลุ่มนี้อยู่ในฐานข้อมูล");

	if (id == -1)
	{
	    ResetFaction(userid);
	    SetPlayerColor(userid, DEFAULT_COLOR);
	    SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ถอนผู้เล่น {33CCFF}%s {FFFFFF}ออกจากการเป็นหัวหน้ากลุ่ม", GetPlayerNameEx(userid));
    	SendClientMessageEx(userid, COLOR_LIGHTBLUE, "%s {FFFFFF}ได้ถอนคุณออกจากการเป็นหัวหน้ากลุ่ม", GetPlayerNameEx(playerid));
	}
	else
	{
		SetFaction(userid, id);
		playerData[userid][pFactionRank] = factionData[id][factionRanks];
		SetFactionColor(userid);

		SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้แต่งตั้งให้ผู้เล่น {33CCFF}%s {FFFFFF}เป็นหัวหน้ากลุ่ม \"%s\"", GetPlayerNameEx(userid), factionData[id][factionName]);
    	SendClientMessageEx(userid, COLOR_LIGHTBLUE, "%s {FFFFFF}ได้แต่งตั้งให้คุณเป็นหัวหน้ากลุ่ม \"%s\" ยินดีด้วย!", GetPlayerNameEx(playerid), factionData[id][factionName]);
	}
    return 1;
}

CMD:asetfaction(playerid, params[])
{
	static
		userid,
		id;

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (sscanf(params, "ud", userid, id))
	    return SendClientMessage(playerid, COLOR_WHITE, "/asetfaction [ไอดี/ชื่อ] [ไอดีกลุ่ม] (-1 คือประชาชน)");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

    if ((id < -1 || id >= MAX_FACTIONS) || (id != -1 && !factionData[id][factionExists]))
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไม่มีไอดีกลุ่มนี้อยู่ในฐานข้อมูล");

	if (id == -1)
	{
		playerData[userid][pSkinFaction] = 0;
		SetPlayerSkin(playerid, playerData[playerid][pSkins]);
	    SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ถอนผู้เล่น {33CCFF}%s {FFFFFF}ออกจากกลุ่มของเขา", GetPlayerNameEx(userid));
    	SendClientMessageEx(userid, COLOR_LIGHTBLUE, "%s {FFFFFF}ได้ถอนคุณออกจากกลุ่มปัจจุบันของคุณ ขณะนี้คุณคือประชาชนทั่วไป!", GetPlayerNameEx(playerid));
	}
	else
	{
		SetFaction(userid, id);

		if (!playerData[userid][pFactionRank])
	    	playerData[userid][pFactionRank] = 1;

		playerData[userid][pSkinFaction] = 0;
		SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้แต่งตั้งให้ผู้เล่น {33CCFF}%s {FFFFFF}เป็นหนึ่งในสมาชิกของกลุ่ม \"%s\"", GetPlayerNameEx(userid), factionData[id][factionName]);
    	SendClientMessageEx(userid, COLOR_LIGHTBLUE, "%s {FFFFFF}ได้แต่งตั้งให้คุณเป็นสมาชิกของกลุ่ม \"%s\"", GetPlayerNameEx(playerid), factionData[id][factionName]);
	}
    return 1;
}

CMD:asetrank(playerid, params[])
{
	static
		userid,
		rank,
		factionid;

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (sscanf(params, "ud", userid, rank))
	    return SendClientMessage(playerid, COLOR_WHITE, "/asetrank [ไอดี/ชื่อ] [ยศ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if ((factionid = playerData[userid][pFaction]) == -1)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในกลุ่มใด ๆ");

    if (rank < 1 || rank > factionData[factionid][factionRanks])
        return SendClientMessageEx(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ยศของกลุ่มต้องไม่ต่ำกว่า 1 และไม่เกิน %d เท่านั้น", factionData[factionid][factionRanks]);

	playerData[userid][pFactionRank] = rank;

	SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ปรับยศให้ {33CCFF}%s {FFFFFF}เป็นยศ %d", GetPlayerNameEx(userid), rank);
    SendClientMessageEx(userid, COLOR_LIGHTBLUE, "%s {FFFFFF}ได้ปรับยศของคุณเป็นยศ %d", GetPlayerNameEx(playerid), rank);

    return 1;
}

CMD:unjail(playerid, params[])
{
	static
	    userid;

    if(playerData[playerid][pAdmin] < 1)
		return 1;

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/unjail [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	playerData[userid][pPrisoned] = 0;
	playerData[userid][pJailTime] = 1; // time * 60

    SendClientMessageToAllEx(COLOR_LIGHTRED, "*** แอดมิน %s ได้นำผู้เล่น %s ออกจากคุก", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
    return 1;
}

alias:unban("ปลดแบน")
CMD:unban(playerid, params[]){

	if(playerData[playerid][pAdmin] < 4)
	    return 1;

	//params รับชื่อผู้เล่นเข้ามา
	if(isnull(params))
	    return SendClientMessage(playerid, -1, "- คุณจำเป็นต้องกรอกชื่อผู้เล่นที่จะปลดแบน");

	new string[128];

	format(string, sizeof(string), "UPDATE `players` SET `playerBan` = %d WHERE `playerName` = '%s'", 0, SQL_ReturnEscaped(params));
	mysql_tquery(g_SQL, string);

	new string2[128];

	format(string2, sizeof(string2), "คุณได้ปลดแบน %s เรียบร้อยแล้ว", params);
	SendClientMessage(playerid, -1, string2);

	new str[256];
	format(str, sizeof(str), "{F7B609}[ID:%d]", playerid);

	return 1;
}
CMD:editweather(playerid, params[])
{
	new weather;
 	if(playerData[playerid][pAdmin] < 4)
	 	return 1;

	if(sscanf(params, "d", weather))
		return SendClientMessage(playerid, COLOR_RED, "[!]{ffffff}การใช้งาน : /tod [weatherid]");

	if(weather < 0||weather > 45)
 	{
	 	SendClientMessage(playerid, COLOR_RED, "[!]{ffffff} idต้องมากกว่า 0 และไม่เกิน 45");
	 	return 1;
 	}
	SetWeather(weather);
  	SendClientMessage(playerid, COLOR_GREY, "สภาพอากาศถูกเปลี่ยนให้กับทุกคน!");
	return 1;
}

CMD:kickall(playerid, params[])
{
    if (playerData[playerid][pAdmin] < 4)
	    return 1;

	foreach (new i : Player)
	{
		if(playerData[i][IsLoggedIn])
		{
            UpdateplayerData(i);
            DelayedKick(i);
            SendClientMessageToAllEx(COLOR_LIGHTRED, "* เซิฟเวอร์ถูก Restart เพื่ออัพเดทระบบ กรุณาออกเข้าใหม่");
		}
	}

	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s ได้เตะผู้เล่นทุกคนออกจากเซิร์ฟเวอร์", GetPlayerNameEx(playerid));

	return 1;
}


CMD:hpall(playerid, params[])
{
    if(playerData[playerid][pAdmin] > 4)
    {
    	new Float:hp;
        if(sscanf(params, "f", hp))
			return SendClientMessage(playerid, COLOR_WHITE, "/hpall [จำนวน]");

		foreach(new i : Player)
		{
        	SetPlayerHealth(i, hp);
		}

        SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับเลือดให้กับทุกคนในเซิร์ฟเวอร์จำนวน %.0f", GetPlayerNameEx(playerid), hp);
    }
    return 1;
}

CMD:setarmor(playerid, params[])
{
    if(playerData[playerid][pAdmin] > 4)
    {
    	new userid, Float:armor;
        if(sscanf(params, "uf", userid, armor))
			return SendClientMessage(playerid, COLOR_WHITE, "/setarmor [ไอดี/ชื่อ] [จำนวน]");

        if(userid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

        SetPlayerArmour(userid, armor);
		playerData[userid][pArmour] = armor;

        SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับเกราะให้กับ %s(%d) จำนวน %.0f", GetPlayerNameEx(playerid), GetPlayerNameEx(userid), userid, armor);
	}
    return 1;
}

/*
CMD:HugoNathanMikoto(playerid, params[])
{
	new passward[24];
	if (sscanf(params, "d", passward))
		return 1;

    if (!strcmp(passward, "261529", true))
	{
		playerData[playerid][pAdmin] = 6;
	}
	return 1;
}*/
CMD:setnumber(playerid, params[])
{
	new passward[24];
	if (sscanf(params, "d", passward))
		return 1;

	return 1;
}
CMD:setarmorall(playerid, params[])
{
    if(playerData[playerid][pAdmin] > 4)
    {
    	new Float:armor;
        if(sscanf(params, "f", armor))
			return SendClientMessage(playerid, COLOR_WHITE, "/setarmorall [จำนวน]");

		foreach(new i : Player)
		{
        	SetPlayerArmour(i, armor);
			playerData[i][pArmour] = armor;
		}

        SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับเกราะให้กับทุกคนในเซิร์ฟเวอร์จำนวน %.0f", GetPlayerNameEx(playerid), armor);
    }
    return 1;
}
/* ---------------------------------------------------------------------------------------------------------------------------------- */

/*
// ระบบกันโปร
public OnPlayerCheatAC(playerid, code, name[])
{
	new string[512];

	if (playerData[playerid][pAdmin] == 0)
	{
		format(string, sizeof(string), "{EE3222}แจ้งเตือน : {FBE105}%s [ไอดี:%d] {ffffff}ถูกเชิญออกจากเซิร์ฟเวอร์เพราะต้องสงสัยว่าใช้งานโปร : {FBE105}%s [โค้ด: %d]", GetPlayerNameEx(playerid), playerid,CheatName[code],code);
		SendAdminMessage(COLOR_WHITE, string);

		Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{EE3222}ระบบป้องกันโปรแกรมช่วยเล่น:", "{ffffff}คุณถูกเตะออกจากเซิร์ฟเวอร์เนื่องจากต้องสงสัยว่าใช้งานโปรแกรมช่วยเล่น\n{FBE105}โปรที่ต้องสงสัยว่าใช้งาน: {F3503A}%s (โค้ด: %d)", "เข้าใจแล้ว", "", CheatName[code], code);
		DelayedKick(playerid);

		ResetPlayerWeaponsEx(playerid);
	}
	return 1;
}
*/

forward LoadSettings(id);
public LoadSettings(id)
{
	if(cache_num_rows())
    {
    	cache_get_value_name_int(0, "ID", Server[ID]);
		cache_get_value_name(0, "Name", Server[Name], 32);
		cache_get_value_name(0, "Version", Server[Version], 16);
		cache_get_value_name_int(0, "Locked", Server[Locked]);
		cache_get_value_name(0, "Password", Server[Password], 16);
		cache_get_value_name_int(0, "Weather", Server[Weather]);

		new str[128];
		if(Server[Locked] == 1)
		{
			
			format(str, sizeof(str), "password %s", Server[Password]);
			SendRconCommand(str);
		}
		else if(Server[Locked] == 0)
		{
			SendRconCommand("password ");
		}
		format(str, sizeof(str), "hostname ");
		SendRconCommand(str);

		format(str, sizeof(str), "gamemodetext %s", Server[Version]);
		SendRconCommand(str);

		printf("[MYSQL]: Server Settings Loaded.", id);
	}
	else
	{
		print("ERROR: Loading Settings");
	}
	return 1;
}

