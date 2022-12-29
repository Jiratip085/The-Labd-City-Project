#include <YSI\y_hooks>

enum factionData {
	factionID,
	factionExists,
	factionName[32],
	factionColor,
	factionType,
	factionRanks,
	Float:factionLockerPos[3],
	factionLockerInt,
	factionLockerWorld,
	factionSkins[8],
	Text3D:factionText3D,
	factionPickup,
	Float:SpawnX,
	Float:SpawnY,
	Float:SpawnZ,
	SpawnInterior,
	SpawnVW
};

new FactionData[MAX_FACTIONS][factionData],Total_Factions_Created;
new FactionRanks[MAX_FACTIONS][15][32];

stock GetFactionByID(sqlid)
{
	for (new i = 0; i != MAX_FACTIONS; i ++) if (FactionData[i][factionExists] && FactionData[i][factionID] == sqlid)
	    return i;

	return -1;
}

SetFaction(playerid, id)
{
	if (id != -1 && FactionData[id][factionExists])
	{
		Character[playerid][Faction] = id;
		Character[playerid][FactionID] = FactionData[id][factionID];
	}
	return 1;
}

SetFactionColor(playerid)
{
	new factionid = Character[playerid][Faction];

	if (factionid != -1)
		return SetPlayerColor(playerid, RemoveAlpha(FactionData[factionid][factionColor]));

	return 0;
}

/*GetFactionColor(factionid)
{
	if (factionid == -1) {
		return 0xFFFFFF77;
	}
	else {

		return FactionData[factionid][factionColor];
	}
}

GetFactionName(factionid)
{
    new
		name[32] = "None";

 	if (factionid == -1)
	    return name;

    format(name, 32, FactionData[factionid][factionName]);
	return name;
}
*/
Faction_Update(factionid)
{
	if (factionid != -1 || FactionData[factionid][factionExists])
	{
	    foreach (new i : Player) if (Character[i][Faction] == factionid)
		{
 			if (/*GetFactionType(i) == FACTION_GANG || */(GetFactionType(i) != FACTION_GANG && BitFlag_Get(g_PlayerFlags[i], PLAYER_ONDUTY)))
			 	SetFactionColor(i);
		}
	}
	return 1;
}

Dialog:FactionSkin(playerid, response, listitem, inputtext[])
{
	new
	    string[128];

	if (Character[playerid][FactionEdit] == -1)
	    return 0;

	if (response)
	{
		switch (listitem)
		{
		    case 0:
		        Dialog_Show(playerid, FactionModel, DIALOG_STYLE_INPUT, "Add by Model ID", "โปรดป้อนไอดีสกินด้านล่าง (0-311):", "Add", "Cancel");

			case 1:
			{
			    FactionData[Character[playerid][FactionEdit]][factionSkins][Character[playerid][SelectedSlot]] = 0;

			    Faction_Save(Character[playerid][FactionEdit]);
			    format(string, sizeof(string), "คุณลบไอดีสกินในช่องที่ %d", Character[playerid][SelectedSlot] + 1);
	    		SendClientMessage(playerid, -1, string);
			}
		}
	}
	return 1;
}

Dialog:FactionModel(playerid, response, listitem, inputtext[])
{
	new
	    string[128];

	if (Character[playerid][FactionEdit] == -1)
	    return 0;

	if (response)
	{
	    new skin = strval(inputtext);

	    if (isnull(inputtext))
	        return Dialog_Show(playerid, FactionModel, DIALOG_STYLE_INPUT, "Add by Model ID", "โปรดป้อนไอดีสกินด้านล่าง (0-311):", "Add", "Cancel");

		if (skin < 0 || skin > 311)
		    return Dialog_Show(playerid, FactionModel, DIALOG_STYLE_INPUT, "Add by Model ID", "ข้อผิดพลาด: ไอดีสกินต้องไม่ต่ำกว่า 0 หรือมากกว่า 311\n\nโปรดป้อนไอดีสกินด้านล่าง (0-311):", "Add", "Cancel");

        FactionData[Character[playerid][FactionEdit]][factionSkins][Character[playerid][SelectedSlot]] = skin;
		Faction_Save(Character[playerid][FactionEdit]);

		if (skin)
		{
		    format(string, sizeof(string), "คุณตั้งค่าไอดีสกินช่องที่ %d เป็น %d", Character[playerid][SelectedSlot] + 1, skin);
    		SendClientMessage(playerid, -1, string);
		}
		else
		{
		    format(string, sizeof(string), "คุณลบไอดีสกินช่องที่ %d", Character[playerid][SelectedSlot] + 1);
    		SendClientMessage(playerid, -1, string);
		}
	}
	return 1;
}

Dialog:FactionLocker(playerid, response, listitem, inputtext[])
{
	if (Character[playerid][FactionEdit] == -1)
	    return 0;

	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
			    new
			        Float:x,
			        Float:y,
			        Float:z,
			        string[128];

				GetPlayerPos(playerid, x, y, z);

				FactionData[Character[playerid][FactionEdit]][factionLockerPos][0] = x;
				FactionData[Character[playerid][FactionEdit]][factionLockerPos][1] = y;
				FactionData[Character[playerid][FactionEdit]][factionLockerPos][2] = z;

				FactionData[Character[playerid][FactionEdit]][factionLockerInt] = GetPlayerInterior(playerid);
				FactionData[Character[playerid][FactionEdit]][factionLockerWorld] = GetPlayerVirtualWorld(playerid);

				Faction_Refresh(Character[playerid][FactionEdit]);
				Faction_Save(Character[playerid][FactionEdit]);
				format(string, sizeof(string), "คุณปรับตำแหน่งตู้เก็บของฝ่ายหรือกลุ่มไอดี: %d", Character[playerid][FactionEdit]);
				SendClientMessage(playerid, -1, string);
			}
		}
	}
	return 1;
}

Faction_Refresh(factionid)
{
    
	if (factionid != -1 && FactionData[factionid][factionExists])
	{
	    if (FactionData[factionid][factionLockerPos][0] != 0.0 && FactionData[factionid][factionLockerPos][1] != 0.0 && FactionData[factionid][factionLockerPos][2] != 0.0)
	    {
		    new
		        string[128];

			if (IsValidDynamicPickup(FactionData[factionid][factionPickup]))
			    DestroyDynamicPickup(FactionData[factionid][factionPickup]);

			if (IsValidDynamic3DTextLabel(FactionData[factionid][factionText3D]))
			    DestroyDynamic3DTextLabel(FactionData[factionid][factionText3D]);

			FactionData[factionid][factionPickup] = CreateDynamicPickup(1239, 23, FactionData[factionid][factionLockerPos][0], FactionData[factionid][factionLockerPos][1], FactionData[factionid][factionLockerPos][2], FactionData[factionid][factionLockerWorld], FactionData[factionid][factionLockerInt]);

			format(string, sizeof(string), "[Locker %s]", FactionData[factionid][factionName]);
	  		FactionData[factionid][factionText3D] = CreateDynamic3DTextLabel(string, COLOR_ORANGE, FactionData[factionid][factionLockerPos][0], FactionData[factionid][factionLockerPos][1], FactionData[factionid][factionLockerPos][2], 15.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, FactionData[factionid][factionLockerWorld], FactionData[factionid][factionLockerInt]);
		}

	}
	return 1;
}

Faction_Save(factionid)
{
	new
	    query[2048];

	format(query, sizeof(query), "UPDATE `factions` SET `factionName` = '%s', `factionColor` = '%d', `factionType` = '%d', `factionRanks` = '%d', `factionLockerX` = '%.4f', `factionLockerY` = '%.4f', `factionLockerZ` = '%.4f', `factionLockerInt` = '%d', `factionLockerWorld` = '%d', `SpawnX` = '%f', `SpawnY` = '%f', `SpawnZ` = '%f', `SpawnInterior` = '%d', `SpawnVW` = '%d'",
		SQL_ReturnEscaped(FactionData[factionid][factionName]),
		FactionData[factionid][factionColor],
		FactionData[factionid][factionType],
		FactionData[factionid][factionRanks],
		FactionData[factionid][factionLockerPos][0],
		FactionData[factionid][factionLockerPos][1],
		FactionData[factionid][factionLockerPos][2],
		FactionData[factionid][factionLockerInt],
		FactionData[factionid][factionLockerWorld],

		FactionData[factionid][SpawnX],
		FactionData[factionid][SpawnY],
		FactionData[factionid][SpawnZ],
		FactionData[factionid][SpawnInterior],
		FactionData[factionid][SpawnVW]
	);
	for (new i = 0; i < 10; i ++)
	{
	    if (i < 8)
	    {
			format(query, sizeof(query), "%s, `factionSkin%d` = '%d'", query, i + 1, FactionData[factionid][factionSkins][i], i + 1);
		}
 }
	format(query, sizeof(query), "%s WHERE `factionID` = '%d'",
		query,
		FactionData[factionid][factionID]
	);
	return mysql_tquery(dbCon, query);
}

stock Faction_SaveRanks(factionid)
{
	new
	    query[768];

	format(query, sizeof(query), "UPDATE `factions` SET `factionRank1` = '%s', `factionRank2` = '%s', `factionRank3` = '%s', `factionRank4` = '%s', `factionRank5` = '%s', `factionRank6` = '%s', `factionRank7` = '%s', `factionRank8` = '%s', `factionRank9` = '%s', `factionRank10` = '%s', `factionRank11` = '%s', `factionRank12` = '%s', `factionRank13` = '%s', `factionRank14` = '%s', `factionRank15` = '%s' WHERE `factionID` = '%d'",
	    FactionRanks[factionid][0],
	    FactionRanks[factionid][1],
	    FactionRanks[factionid][2],
	    FactionRanks[factionid][3],
	    FactionRanks[factionid][4],
	    FactionRanks[factionid][5],
	    FactionRanks[factionid][6],
	    FactionRanks[factionid][7],
	    FactionRanks[factionid][8],
	    FactionRanks[factionid][9],
	    FactionRanks[factionid][10],
	    FactionRanks[factionid][11],
	    FactionRanks[factionid][12],
	    FactionRanks[factionid][13],
	    FactionRanks[factionid][14],
	    FactionData[factionid][factionID]
	);
	return mysql_tquery(dbCon, query);
}

Faction_Delete(factionid)
{
	if (factionid != -1 && FactionData[factionid][factionExists])
	{
	    new
	        string[64];

		format(string, sizeof(string), "DELETE FROM `factions` WHERE `factionID` = '%d'", FactionData[factionid][factionID]);
		mysql_tquery(dbCon, string);

		format(string, sizeof(string), "UPDATE `characters` SET `Faction` = '-1' WHERE `Faction` = '%d'", FactionData[factionid][factionID]);
		mysql_tquery(dbCon, string);

        Total_Factions_Created --;

		foreach (new i : Player)
		{
			if (Character[i][Faction] == factionid) {
		    	Character[i][Faction] = -1;
		    	Character[i][FactionID] = -1;
		    	Character[i][FactionRank] = -1;
			}
			if (Character[i][FactionEdit] == factionid) {
			    Character[i][FactionEdit] = -1;
			}
		}
		if (IsValidDynamicPickup(FactionData[factionid][factionPickup]))
  			DestroyDynamicPickup(FactionData[factionid][factionPickup]);

		if (IsValidDynamic3DTextLabel(FactionData[factionid][factionText3D]))
  			DestroyDynamic3DTextLabel(FactionData[factionid][factionText3D]);

	    FactionData[factionid][factionExists] = false;
	    FactionData[factionid][factionType] = 0;
	    FactionData[factionid][factionID] = 0;

	}
	return 1;
}

stock GetFactionTypeName(type)
{
	new string[32] = "ไม่ทราบ";

	switch(type)
	{
		case 1: format(string, 32, "ตำรวจ");
		case 2: format(string, 32, "นักข่าว");
		case 3: format(string, 32, "หมอ/แพทย์");
		case 4: format(string, 32, "หน่วยรัฐบาล");
		case 5: format(string, 32, "แก็งค์");
	}
	return string;
}

stock GetFactionType(playerid)
{
	if (Character[playerid][Faction] == -1)
	    return 0;

	return (FactionData[Character[playerid][Faction]][factionType]);
}

Faction_ShowRanks(playerid, factionid)
{
    if (factionid != -1 && FactionData[factionid][factionExists])
	{
		new
		    string[640];

		//string[0] = 0;

		for (new i = 0; i < FactionData[factionid][factionRanks]; i ++)
		    format(string, sizeof(string), "%sRank %d: %s\n", string, i + 1, FactionRanks[factionid][i]);

		Character[playerid][FactionEdit] = factionid;
		Dialog_Show(playerid, EditRanks, DIALOG_STYLE_LIST, FactionData[factionid][factionName], string, "Change", "Cancel");
	}
	return 1;
}

Faction_Create(name[], type)
{
	for (new i = 0; i != MAX_FACTIONS; i ++) if (!FactionData[i][factionExists])
	{
	    format(FactionData[i][factionName], 32, name);

        FactionData[i][factionExists] = true;
        FactionData[i][factionColor] = 0xFFFFFF00;
        FactionData[i][factionType] = type;
        FactionData[i][factionRanks] = 5;

        FactionData[i][factionLockerPos][0] = 0.0;
        FactionData[i][factionLockerPos][1] = 0.0;
        FactionData[i][factionLockerPos][2] = 0.0;
        FactionData[i][factionLockerInt] = 0;
        FactionData[i][factionLockerWorld] = 0;

        for (new j = 0; j < 8; j ++) {
            FactionData[i][factionSkins][j] = 0;
        }
	    for (new j = 0; j < 15; j ++) {
			format(FactionRanks[i][j], 32, "Rank %d", j + 1);
	    }
	    mysql_tquery(dbCon, "INSERT INTO `factions` (`factionType`) VALUES(0)", "OnFactionCreated", "d", i);
	    return i;
	}
	return -1;
}

ResetFaction(playerid)
{
    Character[playerid][Faction] = -1;
    Character[playerid][FactionID] = -1;
    Character[playerid][FactionRank] = 0;
}


stock IsNearFactionLocker(playerid)
{
	new factionid = Character[playerid][Faction];

	if (factionid == -1)
	    return 0;

	if (IsPlayerInRangeOfPoint(playerid, 3.0, FactionData[factionid][factionLockerPos][0], FactionData[factionid][factionLockerPos][1], FactionData[factionid][factionLockerPos][2]) && GetPlayerInterior(playerid) == FactionData[factionid][factionLockerInt] && GetPlayerVirtualWorld(playerid) == FactionData[factionid][factionLockerWorld])
	    return 1;

	return 0;
}

forward Faction_Load();
public Faction_Load()
{
	new
	    rows,
		str[32];

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_FACTIONS)
	{
	    FactionData[i][factionExists] = true;
	    cache_get_value_name_int(i, "factionID", FactionData[i][factionID]);

	    cache_get_value_name(i, "factionName", FactionData[i][factionName], 32);

        cache_get_value_name_int(i, "factionColor", FactionData[i][factionColor]);
        cache_get_value_name_int(i, "factionType", FactionData[i][factionType]);
        cache_get_value_name_int(i, "factionRanks", FactionData[i][factionRanks]);
        cache_get_value_name_float(i, "factionLockerX", FactionData[i][factionLockerPos][0]);
        cache_get_value_name_float(i, "factionLockerY", FactionData[i][factionLockerPos][1]);
        cache_get_value_name_float(i, "factionLockerZ", FactionData[i][factionLockerPos][2]);
        cache_get_value_name_int(i, "factionLockerInt", FactionData[i][factionLockerInt]);
        cache_get_value_name_int(i, "factionLockerWorld", FactionData[i][factionLockerWorld]);

		//Spawning

		cache_get_value_name_float(i, "SpawnX", FactionData[i][SpawnX]);
		cache_get_value_name_float(i, "SpawnY", FactionData[i][SpawnY]);
		cache_get_value_name_float(i, "SpawnZ", FactionData[i][SpawnZ]);
		cache_get_value_name_int(i, "SpawnInterior", FactionData[i][SpawnInterior]);
		cache_get_value_name_int(i, "SpawnVW", FactionData[i][SpawnVW]);


        Total_Factions_Created++;

	    for (new j = 0; j < 8; j ++) {
	        format(str, sizeof(str), "factionSkin%d", j + 1);

            cache_get_value_name_int(i, str, FactionData[i][factionSkins][j]);
	        //FactionData[i][factionSkins][j] = cache_get_field_content_int(i, str);
		}
		for (new j = 0; j < 15; j ++) {
		    format(str, sizeof(str), "factionRank%d", j + 1);

            cache_get_value_name(i, str, FactionRanks[i][j], 32);
		    //cache_get_field_content(i, str, FactionRanks[i][j], dbCon, 32);
		}
		Faction_Refresh(i);
	}
	printf("[MYSQL]: %d Factions have been successfully loaded from the database.", Total_Factions_Created);
	return 1;
}

Faction_GetName(playerid)
{
    new
		factionid = Character[playerid][Faction],
		name[32] = "Civilian";

 	if (factionid == -1)
	    return name;

	format(name, 32, FactionData[factionid][factionName]);
	return name;
}

Faction_GetRank(playerid)
{
    new
		factionid = Character[playerid][Faction],
		rank[32] = "No Rank";

 	if (factionid == -1)
	    return rank;

	format(rank, 32, FactionRanks[factionid][Character[playerid][FactionRank] - 1]);
	return rank;
}

forward OnFactionCreated(factionid);
public OnFactionCreated(factionid)
{
	if (factionid == -1 || !FactionData[factionid][factionExists])
	    return 0;

	FactionData[factionid][factionID] = cache_insert_id();

	Faction_Save(factionid);
	Faction_SaveRanks(factionid);

	return 1;
}

stock ViewFactions(playerid)
{
	new string[2048], menu[20], count;

	format(string, sizeof(string), "%s{B4B5B7}หน้า 1{FFFFFF}\n", string);

	SetPVarInt(playerid, "page", 1);

	for (new i = 0; i != MAX_FACTIONS; i ++) if (FactionData[i][factionExists]) {
		if(count == 20)
		{
			format(string, sizeof(string), "%s{B4B5B7}หน้า 2{FFFFFF}\n", string);
			break;
		}
		format(menu, 20, "menu%d", ++count);
		SetPVarInt(playerid, menu, i);
		format(string, sizeof(string), "%s{FFFFFF}({FFBF00}%i{FFFFFF}) | %s\n", string, i, FactionData[i][factionName]);
	}
	if(!count) Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "รายชื่อกลุ่ม", "ไม่พบข้อมูลของ Faction นี้", "โอเค", "");
	else Dialog_Show(playerid, FactionsList, DIALOG_STYLE_LIST, "รายชื่อกลุ่ม", string, "แก้ไข", "ปิด");
	return 1;
}

Dialog:FactionsList(playerid, response, listitem, inputtext[])
{
	if(response) {

		new menu[20];
	//Navigate
		if(listitem != 0 && listitem != 21) {
			new str_biz[8];
			format(str_biz, 20, "menu%d", listitem);

			Character[playerid][FactionEdit] = GetPVarInt(playerid, str_biz);
			ShowPlayerEditFaction(playerid);
			return true;
		}

		new currentPage = GetPVarInt(playerid, "page");
		if(listitem==0) {
			if(currentPage>1) currentPage--;
		}
		else if(listitem == 21) currentPage++;

		new string[2048], count;
		format(string, sizeof(string), "%s{B4B5B7}หน้า %d{FFFFFF}\n", string, (currentPage==1) ? 1 : currentPage-1);

		SetPVarInt(playerid, "page", currentPage);

		new skipitem = (currentPage-1) * 20;

		for (new i = 0; i != MAX_FACTIONS; i ++) if (FactionData[i][factionExists]) {

			if(skipitem)
			{
				skipitem--;
				continue;
			}
			if(count == 20)
			{
				format(string, sizeof(string), "%s{B4B5B7}หน้า 2{FFFFFF}\n", string);
				break;
			}
			format(menu, 20, "menu%d", ++count);
			SetPVarInt(playerid, menu, i);
			format(string, sizeof(string), "%s{FFFFFF}({FFBF00}%i{FFFFFF}) | %s\n", string, i, FactionData[i][factionName]);

		}

		Dialog_Show(playerid, FactionsList, DIALOG_STYLE_LIST, "รายชื่อกลุ่ม", string, "แก้ไข", "ปิด");
	}
	return 1;
}

stock ShowPlayerEditFaction(playerid)
{
	if(Character[playerid][FactionEdit] != -1 && FactionData[Character[playerid][FactionEdit]][factionExists])
	{
		new caption[128], dialog_str[1024], id = Character[playerid][FactionEdit];
		format(caption, sizeof(caption), "แก้ไขแฟคชั่น: %s(%d)", FactionData[id][factionName], id);
        format(dialog_str, sizeof dialog_str, "ชื่อ\t%s\n", FactionData[id][factionName]);
        format(dialog_str, sizeof dialog_str, "%sสี\t{%06x}%06x\n", dialog_str, FactionData[id][factionColor] >>> 8, FactionData[id][factionColor]);
        format(dialog_str, sizeof dialog_str, "%sประเภท\t%s\n", dialog_str, GetFactionTypeName(FactionData[id][factionType]));
        format(dialog_str, sizeof dialog_str, "%sยศ\t%d/%d\n", dialog_str, FactionData[id][factionRanks], 15);
        format(dialog_str, sizeof dialog_str, "%sตั้งจุด Locker\t\n", dialog_str);
		Dialog_Show(playerid, FactionEdit, DIALOG_STYLE_TABLIST, caption, dialog_str, "เลือก", "กลับ");
	}
	return 1;
}

Dialog:FactionEdit(playerid, response, listitem, inputtext[])
{
	if(response) {

		new string[128];

		switch(listitem)
		{
			case 0: // Name
			{
				format(string, sizeof(string), "ชื่อแฟคชั่น: %s", FactionData[Character[playerid][FactionEdit]][factionName]);
				Dialog_Show(playerid, FactionEdit_Name, DIALOG_STYLE_INPUT, "ตั้งค่าชื่อ", string, "เปลี่ยน", "กลับ");
			}
			case 1: // Color
			{
				format(string, sizeof(string), "สีแฟคชั่น: {%06x}%06x\n{FFFFFF}ใช้รูปแบบ RGBA เช่น 0xFFFFFFAA\n(AA คือความสว่างหากต้องการให้โซนมีสีจาง ๆ ใช้ 50 แทน AA)", FactionData[Character[playerid][FactionEdit]][factionColor], FactionData[Character[playerid][FactionEdit]][factionColor] >>> 8);
				Dialog_Show(playerid, FactionEdit_Color, DIALOG_STYLE_INPUT, "ตั้งค่าสี", string, "เปลี่ยน", "กลับ");
			}
			case 2: // Type
			{
				format(string, sizeof(string), "แฟคชั่นประเภท: %s\n\nเลือกหมายเลข 1: ตำรวจ | 2: นักข่าว | 3: หมอ/แพทย์ | 4: รัฐบาล | 5: แก็งค์", GetFactionTypeName(FactionData[Character[playerid][FactionEdit]][factionType]));
				Dialog_Show(playerid, FactionEdit_Type, DIALOG_STYLE_INPUT, "Edit Type", string, "เปลี่ยน", "กลับ");
			}
			case 3: // แก้ไขยศ
			{
				Dialog_Show(playerid, FactionEdit_Rank, DIALOG_STYLE_LIST, "แก้ไข -> ยศ", "ยศที่ใช้งานได้\t(%d/%d)\nชื่อยศ\t", "แก้ไข", "กลับ", FactionData[Character[playerid][FactionEdit]][factionRanks], 15);
			}
			case 4: // จุดเกิด
			{
				Dialog_Show(playerid, FactionEdit_SpawnConf, DIALOG_STYLE_MSGBOX, "Edit Spawn", "คุณแน่ใจหรือที่จะปรับจุดเกิดแฟคชั่นนี้มายังตำแหน่งปัจจุบันของคุณ", "ยืนยัน", "กลับ");
			}
		}
	}
	else
	{
	    Character[playerid][FactionEdit] = -1;
	}
}

Dialog:FactionEdit_SpawnConf(playerid, response, listitem, inputtext[])
{
	if(response) {

	    if (Character[playerid][FactionEdit] == -1)
	    	return 0;

		new
	        Float:x,
	        Float:y,
	        Float:z,
	        string[128];

		GetPlayerPos(playerid, x, y, z);

		FactionData[Character[playerid][FactionEdit]][factionLockerPos][0] = x;
		FactionData[Character[playerid][FactionEdit]][factionLockerPos][1] = y;
		FactionData[Character[playerid][FactionEdit]][factionLockerPos][2] = z;

		FactionData[Character[playerid][FactionEdit]][factionLockerInt] = GetPlayerInterior(playerid);
		FactionData[Character[playerid][FactionEdit]][factionLockerWorld] = GetPlayerVirtualWorld(playerid);

		Faction_Refresh(Character[playerid][FactionEdit]);
		Faction_Save(Character[playerid][FactionEdit]);
		format(string, sizeof(string), "คุณปรับตำแหน่งตู้เก็บของฝ่ายหรือกลุ่มไอดี: %d", Character[playerid][FactionEdit]);
		SendClientMessage(playerid, -1, string);
	}
	return ShowPlayerEditFaction(playerid);
}

Dialog:FactionEdit_Name(playerid, response, listitem, inputtext[])
{
	if(response) {
		new string[64];

		if(isnull(inputtext) || strlen(inputtext) >= 32) {
			format(string, sizeof(string), "ความยาวของชื่อต้องมากกว่า 0 และไม่เกินที่ถูกกำหนดไว้/n/nFaction Name: %s", FactionData[Character[playerid][FactionEdit]][factionName]);
			Dialog_Show(playerid, FactionEdit_Name, DIALOG_STYLE_INPUT, "Edit Name", string, "เปลี่ยน", "กลับ");
			return true;
		}
		format(FactionData[Character[playerid][FactionEdit]][factionName], 32, inputtext);
		Faction_Refresh(Character[playerid][FactionEdit]);
		Faction_Save(Character[playerid][FactionEdit]);
	}
	return ShowPlayerEditFaction(playerid);
}

Dialog:FactionEdit_Color(playerid, response, listitem, inputtext[])
{
	if(response) {

		new string[128], color;
		if (sscanf(inputtext, "x", color)) {
			format(string, sizeof(string), "รูปแบบของสีไม่ถูกต้อง\n\nFaction Color: {%06x}CODE\nRGBA 0xFFFFFFAA", FactionData[Character[playerid][FactionEdit]][factionColor] >>> 8);
			Dialog_Show(playerid, FactionEdit_Color, DIALOG_STYLE_INPUT, "Edit Color", string, "เปลี่ยน", "กลับ");
			return true;
		}

	    FactionData[Character[playerid][FactionEdit]][factionColor] = color;
	    Faction_Refresh(Character[playerid][FactionEdit]);

	    Faction_Save(Character[playerid][FactionEdit]);

		SendFactionAlert(COLOR_LIGHTRED, "{%06x}[ADMIN]: %s ได้ปรับ สี ของฝ่ายหรือกลุ่มไอดี: %d", color >>> 8, ReturnName(playerid, 0), Character[playerid][FactionEdit]);

	}
	return ShowPlayerEditFaction(playerid);
}

Dialog:FactionEdit_Type(playerid, response, listitem, inputtext[])
{
	if(response) {
		new string[128], typeint = strval(inputtext);

		if(typeint < 1 && typeint > 5) {
			format(string, sizeof(string), "ประเภทที่ระบุไม่ถูกต้องอยู่ระหว่าง 1 ถึง 5/n/nFaction Type: %s\n\nเลือกหมายเลข 1: ตำรวจ | 2: หมอ | 3: รัฐบาล | 4: แก๊งค์ | 5: นายทะเบียน", GetFactionTypeName(FactionData[Character[playerid][FactionEdit]][factionType]));
			Dialog_Show(playerid, FactionEdit_Type, DIALOG_STYLE_INPUT, "Edit Type", string, "เปลี่ยน", "กลับ");
			return true;
		}
	    FactionData[Character[playerid][FactionEdit]][factionType] = typeint;

	    Faction_Refresh(Character[playerid][FactionEdit]);

	    Faction_Save(Character[playerid][FactionEdit]);

		SendFactionAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับประเภทของฝ่ายหรือกลุ่มไอดี: %d เป็น %s", ReturnName(playerid), Character[playerid][FactionEdit], GetFactionTypeName(typeint));
	}
	return ShowPlayerEditFaction(playerid);
}

Dialog:FactionEdit_Rank(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: {
				new string[256];
				format(string, sizeof(string), "Faction Max rank: %d\n\nเลือกระหว่าง 1-15", FactionData[Character[playerid][FactionEdit]][factionRanks]);
				Dialog_Show(playerid, FactionEdit_Maxrank, DIALOG_STYLE_INPUT, "Edit Max rank", string, "เปลี่ยน", "กลับ");
				return 1;
			}
			case 1: {
				Faction_ShowRanks(playerid, Character[playerid][FactionEdit]);
				SetPVarInt(playerid, "EditFromView", 1);
				return 1;
			}
		}
	}
	return ShowPlayerEditFaction(playerid);
}

/*Faction_ShowRanks(playerid, factionid)
{
    if (factionid != -1 && FactionData[factionid][factionExists])
	{
		new
		    string[640];

	//string = '\0';

		for (new i = 0; i < FactionData[factionid][factionRanks]; i ++)
		    format(string, sizeof(string), "%sRank %d: %s\n", string, i + 1, FactionRanks[factionid][i]);

		Character[playerid][FactionEdit] = factionid;
		Dialog_Show(playerid, EditRanks, DIALOG_STYLE_LIST, FactionData[factionid][factionName], string, "Change", "Cancel");
	}
	return 1;
}*/

Dialog:EditRanks(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (!FactionData[Character[playerid][FactionEdit]][factionExists])
			return 0;

		Character[playerid][SelectedSlot] = listitem;
		Dialog_Show(playerid, SetRankName, DIALOG_STYLE_INPUT, "Set Rank", "Rank: %s (%d)\n\nกรุณาป้อนชื่อยศใหม่ด้านล่างนี้:", "Submit", "Back", FactionRanks[Character[playerid][FactionEdit]][Character[playerid][SelectedSlot]], Character[playerid][SelectedSlot] + 1);
	}
	else
	{
		if(GetPVarInt(playerid, "EditFromView"))
		{
			ShowPlayerEditFaction(playerid);
			DeletePVar(playerid, "EditFromView");
		}
	}
	return 1;
}

Dialog:SetRankName(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext))
			return Dialog_Show(playerid, SetRankName, DIALOG_STYLE_INPUT, "Set Rank", "Rank: %s (%d)\n\nกรุณาป้อนชื่อยศใหม่ด้านล่างนี้:", "Submit", "Back", FactionRanks[Character[playerid][FactionEdit]][Character[playerid][SelectedSlot]], Character[playerid][SelectedSlot] + 1);

	    if (strlen(inputtext) > 32)
	        return Dialog_Show(playerid, SetRankName, DIALOG_STYLE_INPUT, "Set Rank", "ข้อผิดพลาด: ยศต้องไม่มากกว่า 32 ตัวอักษร\n\nRank: %s (%d)\n\nกรุณาป้อนชื่อยศใหม่ด้านล่างนี้:", "Submit", "Back", FactionRanks[Character[playerid][FactionEdit]][Character[playerid][SelectedSlot]], Character[playerid][SelectedSlot] + 1);

		format(FactionRanks[Character[playerid][FactionEdit]][Character[playerid][SelectedSlot]], 32, inputtext);

		new
		    query[128],
			set_rank[32],
			clean_rank[32];

        mysql_escape_string(inputtext,clean_rank);

        format(set_rank, 32, "factionRank%d", Character[playerid][SelectedSlot] + 1);
		format(query, sizeof(query), "UPDATE `factions` SET `%s` = '%s' WHERE `factionID` = '%d'",
		    set_rank,
		    clean_rank,
		    FactionData[Character[playerid][FactionEdit]][factionID]
		);
		mysql_tquery(dbCon, query);

		Faction_ShowRanks(playerid, Character[playerid][FactionEdit]);

		format(query, sizeof(query), "คุณได้ปรับชื่อยศ %d เป็น \"%s\"", Character[playerid][SelectedSlot] + 1, inputtext);
		SendClientMessage(playerid, COLOR_GRAD1, query);
	}
	else Faction_ShowRanks(playerid, Character[playerid][FactionEdit]);
	return 1;
}

Dialog:FactionEdit_Maxrank(playerid, response, listitem, inputtext[])
{
	if(response) {
		new string[128], typeint = strval(inputtext);

		if(typeint < 1 && typeint > 16) {
			format(string, sizeof(string), "ยศที่ระบุต้องอยู่ระหว่าง 1 ถึง 15/n/nFaction Max rank: %d\n\nเลือกยศระหว่าง 1-15", FactionData[Character[playerid][FactionEdit]][factionRanks]);
			Dialog_Show(playerid, FactionEdit_Maxrank, DIALOG_STYLE_INPUT, "Edit Max rank", string, "เปลี่ยน", "กลับ");
			return true;
		}
	    FactionData[Character[playerid][FactionEdit]][factionRanks] = typeint;
	    Faction_Refresh(Character[playerid][FactionEdit]);

	    Faction_Save(Character[playerid][FactionEdit]);

		SendFactionAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับยศสูงสุดของฝ่ายหรือกลุ่มไอดี: %d เป็น %d", ReturnName(playerid), Character[playerid][FactionEdit], typeint);
	}
	return ShowPlayerEditFaction(playerid);
}

//Faction
CMD:createfaction(playerid, params[])
{
	new
	    id = -1,
		type,
		name[32];

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "ds[32]", type, name))
	{
	    SystemMsg(playerid, "/createfaction [type] [name]");
	    SystemMsg(playerid, "[TYPES]:{FFFFFF} 1: Police | 2: News | 3: Medical | 4: Government | 5: Gang");
		return 1;
	}
	if (type < 1 || type > 5)
	    return SendClientMessage(playerid, -1, "ประเภทที่ระบุอยู่ในระหว่าง 1 ถึง 5");

	id = Faction_Create(name, type);

	if (id == -1)
	    return SendClientMessage(playerid, -1, "เซิฟเวอร์นี้ได้สร้างฝ่ายหรือกลุ่มเกินขีดจำกัดแล้ว");

	SendClientMessageEx(playerid, -1, "คุณประสบความสำเร็จในการสร้างฝ่ายหรือกลุ่มไอดี: %d", id);
	return 1;
}

CMD:destroyfaction(playerid, params[])
{
	new
	    id = 0;

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "d", id))
	    return SystemMsg(playerid, "/destroyfaction [faction id]");

	if ((id < 0 || id >= MAX_FACTIONS) || !FactionData[id][factionExists])
	    return SendClientMessage(playerid, -1, "คุณระบุไอดีฝ่ายหรือกลุ่มไม่ถูกต้อง");

	Faction_Delete(id);
	SendClientMessageEx(playerid, -1, "คุณประสบความสำเร็จในการทำลายฝ่ายหรือกลุ่มไอดี: %d", id);
	return 1;
}

CMD:flist(playerid, params[])
{
	for (new i = 0; i != MAX_FACTIONS; i ++) if (FactionData[i][factionExists]) {
	    SendClientMessageEx(playerid, COLOR_WHITE, "[ID: %d] {%06x}%s", i, FactionData[i][factionColor] >>> 8, FactionData[i][factionName]);
	}
	return 1;
}

CMD:viewfactions(playerid, params[])
{
	if(Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, COLOR_RED, "[!] คุณไม่ได้รับอนุญาติ");

    ViewFactions(playerid);
	return 1;
}

CMD:editfaction(playerid, params[])
{
	new
	    id,
	    type[24],
	    string[128];

	if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SystemMsg(playerid, "/editfaction [id] [name]");
	    SystemMsg(playerid, "[NAMES]:{FFFFFF} name, color, type, models, locker, ranks, maxranks");
		return 1;
	}
	if ((id < 0 || id >= MAX_FACTIONS) || !FactionData[id][factionExists])
	    return SendClientMessage(playerid, -1, "คุณระบุไอดีฝ่ายหรือกลุ่มไม่ถูกต้อง");

    if (!strcmp(type, "name", true))
	{
	    new name[32];

	    if (sscanf(string, "s[32]", name))
	        return SendClientMessage(playerid, -1, "/editfaction [id] [name] [new name]");

	    format(FactionData[id][factionName], 32, name);

	    Faction_Save(id);
		SendFactionAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับชื่อของฝ่ายหรือกลุ่มไอดี: %d เป็น \"%s\"", ReturnRealName(playerid, 0), id, name);
	}
	else if (!strcmp(type, "maxranks", true))
	{
	    new ranks;

	    if (sscanf(string, "d", ranks))
	        return SendClientMessage(playerid, -1, "/editfaction [id] [maxranks] [maximum ranks]");

		if (ranks < 1 || ranks > 16)
		    return SendClientMessage(playerid, -1, "ยศที่ระบุไม่ควรต่ำกว่า 1 หรือมากกว่า 16");

	    FactionData[id][factionRanks] = ranks;

	    Faction_Save(id);
		SendFactionAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับยศสูงสุดของฝ่ายหรือกลุ่มไอดี: %d เป็น %d", ReturnRealName(playerid, 0), id, ranks);
	}
	else if (!strcmp(type, "ranks", true))
	{
	    Faction_ShowRanks(playerid, id);
	}
	else if (!strcmp(type, "color", true))
	{
	    new color;

	    if (sscanf(string, "h", color))
	        return SendClientMessage(playerid, -1, "/editfaction [id] [color] [hex color]");

	    FactionData[id][factionColor] = color;
	    Faction_Update(id);

	    Faction_Save(id);
		SendFactionAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปร{%06x}ั{FF6347}บ สี ของฝ่ายหรือกลุ่มไอดี: %d", ReturnRealName(playerid, 0), color >>> 8, id);
	}
	else if (!strcmp(type, "type", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
		 	SendClientMessage(playerid, -1, "/editfaction [id] [type] [faction type]");
            SendClientMessage(playerid, COLOR_YELLOW, "[TYPES]:{FFFFFF} 1: Police | 2: News | 3: Medical | 4: Government | 5: Gang");
            return 1;
		}
		if (typeint < 1 || typeint > 5)
		    return SendClientMessage(playerid, -1, "ประเภทที่ระบุไม่ถูกต้อง อยู่ระหว่าง 1 ถึง 5");

		FactionData[id][factionType] = typeint;

	    Faction_Save(id);
		SendFactionAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับประเภทของฝ่ายหรือกลุ่มไอดี: %d เป็น %d", ReturnRealName(playerid, 0), id, typeint);
	}
	else if (!strcmp(type, "models", true))
	{
	    new
	        skins[8];

		for (new i = 0; i < sizeof(skins); i ++)
		    skins[i] = (FactionData[id][factionSkins][i]) ? (FactionData[id][factionSkins][i]) : (19300);

	    Character[playerid][FactionEdit] = id;
		ShowModelSelectionMenu(playerid, "Faction Skins", MODEL_SELECTION_SKINS, skins, sizeof(skins), -16.0, 0.0, -55.0);
	}
	/*else if (!strcmp(type, "accessory", true))
	{
	    new
	        skins[8];

		for (new i = 0; i < sizeof(skins); i ++)
		    skins[i] = (FactionData[id][factionAccessorys][i]) ? (FactionData[id][factionAccessorys][i]) : (19300);

	    Character[playerid][FactionEdit] = id;
		ShowModelSelectionMenu(playerid, "Faction Accessorys", MODEL_SELECTION_FACTION_ACCESSORYS, skins, sizeof(skins), -16.0, 0.0, -55.0);
	}*/
	else if (!strcmp(type, "locker", true))
	{
        Character[playerid][FactionEdit] = id;
		Dialog_Show(playerid, FactionLocker, DIALOG_STYLE_LIST, "Faction Locker", "Set Location", "Select", "Cancel");
	}
	return 1;
}
