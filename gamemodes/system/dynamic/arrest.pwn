#include	<YSI_Coding\y_hooks>



//#define PRISON_WORLD (10000)
new const Float:g_arrPrisonSpawns[][] = {
	{1219.1440,-1344.5446,796.7456,92.7812},
	{1219.3196,-1341.3223,796.7456,91.7366},
	{1219.0269,-1338.0975,796.7456,90.1466},
	{1218.9220,-1335.0146,796.7456,89.6011},
	{1219.1185,-1331.9126,796.7456,89.4734},
	{1218.8970,-1328.5990,796.7456,94.8813},
	{1202.3773,-1327.6882,796.7505,268.0284},
	{1202.6104,-1330.7313,796.7505,273.5640},
	{1202.1729,-1333.9873,796.7505,269.4673},
	{1202.1198,-1337.2217,796.7505,267.4596},
	{1201.9558,-1340.3127,796.7505,269.4208},
	{1202.0254,-1343.6251,800.2859,272.9485},
	{1201.9592,-1340.3364,800.2859,267.9351},
	{1202.0083,-1337.2323,800.2859,270.4417},
	{1202.1290,-1334.0354,800.2859,272.2173},
	{1202.1309,-1330.7930,800.2859,273.0529},
	{1202.1122,-1327.6104,800.2859,268.9796},
	{1219.1072,-1328.5779,800.2859,90.6914},
	{1218.8241,-1331.7990,800.2859,88.6025},
	{1218.9987,-1334.9480,800.2859,91.7359},
	{1219.2068,-1338.1929,800.2859,92.0493},
	{1218.9407,-1341.3184,800.2859,87.7671},
	{1219.1615,-1344.5607,800.2859,87.4538}
};




hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) 
{
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
		new
			count,
			var[32],
			string[4096],
			string2[4096];

		
		if (Arrest_Nearest(playerid) != -1)
		{

            if (!playerData[playerid][pOnDuty])
                return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถใช้เมนูเจ้าหน้าที่ได้ เนื่องจากคุณยังไม่ได้ On Duty");

			foreach (new  i : Player)
			{
				if (i == playerid) continue;
				if (IsPlayerNearPlayer(playerid, i, 5.0))
				{
					format(string, sizeof(string), "(%d)%s\n", i, GetPlayerNameEx(i));
					strcat(string2, string);
					format(var, sizeof(var), "Arrest%d", count);
					SetPVarInt(playerid, var, i);
					count++;
				}
			}
			PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);	
			if (!count)
			{
				
				Dialog_Show(playerid,ArrestErorr,DIALOG_STYLE_LIST,"ส่งเข้าเรือนจำ","{FFFFFF}- ไม่พบผู้เล่นอยู่บริเวณรอบๆ ตัวของคุณ","ปิด","");
				return 1;
			}
			format(string, sizeof(string), " รายชื่อผู้เล่น\n%s", string2);
			Dialog_Show(playerid, Arrest_Player, DIALOG_STYLE_TABLIST_HEADERS, "ส่งเข้าเรือนจำ", string, "เลือก", "ยกเลิก");
			return 1;
		}
	}	
	return 1;
}

Dialog:Arrest_Player(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new var[15];
		format(var, sizeof(var), "Arrest%d", listitem);
		new userid = GetPVarInt(playerid, var);
		playerData[playerid][pPayMoneyID] = userid;	

		Dialog_Show(playerid, Arrest_Player_SC, DIALOG_STYLE_INPUT, "ส่งเข้าเรือนจำ", "ชื่อ: (%d)%s\nโปรดระบุจำนวนเวลาที่ต้องการจะส่งเข้าเรือนจำ (วินาที):", "ส่ง", "ยกเลิก", userid, GetPlayerNameEx(userid));
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);	
	}
}
Dialog:Arrest_Player_SC(playerid, response, listitem, inputtext[])
{
 
	new amount = strval(inputtext),
		id = Arrest_Nearest(playerid),
		userid = playerData[playerid][pPayMoneyID],
		factionid = playerData[playerid][pFaction];
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	
	if (response)
	{
			
		if (!IsPlayerNearPlayer(playerid, userid, 5.0))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");

		if (amount < 5)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- เวลาต้องไม่ต่ำกว่า 1 วินาที");

		playerData[userid][pPrisoned] = 1;
		playerData[userid][pJailTime] = amount;
		ClearCrime(userid);
		playerData[userid][pPrisonOut] = id;

		StopDragging(userid);
		SetPlayerInPrison(userid);

		ResetPlayerWeaponsEx(userid);
		ResetPlayer(userid);

		playerData[userid][pCuffed] = 0;

		SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);
	
		SendFactionMessage(factionid, COLOR_RADIO, "(( %s ถูกส่งเข้าเรือนจำเป็นเวลา %s วินาที โดยเจ้าหน้าที่ (%d)%s %s ))", 
		GetPlayerNameEx(userid), FormatNumber(amount), playerData[playerid][pFactionRank], Faction_GetRank(playerid), GetPlayerNameEx(playerid));
	
	}
	return 1;
}




SetPlayerInPrison(playerid) //น่าสนใจ
{
	new idx = random(sizeof(g_arrPrisonSpawns));

	SetPlayerPosExten(playerid, g_arrPrisonSpawns[idx][0], g_arrPrisonSpawns[idx][1], g_arrPrisonSpawns[idx][2] + 0.3);
	SetPlayerFacingAngle(playerid, g_arrPrisonSpawns[idx][3]);

	SetPlayerInterior(playerid, 5);
	//SetPlayerVirtualWorld(playerid, PRISON_WORLD);

    //ShowPlayerStats(playerid, false);

    TogglePlayerSpectating(playerid, false);

	SetCameraBehindPlayer(playerid);
}




















































































































enum ARREST_DATA {
	arrestID,
	arrestExists,
	Float:arrestPosX,
	Float:arrestPosY,
	Float:arrestPosZ,
	arrestInterior,
	arrestWorld,
	Text3D:arrestText3D,
	arrestPickup
};
new arrestData[MAX_ARREST][ARREST_DATA];


CMD:createarrest(playerid, params[])
{
	static
	    id = -1,
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	id = Arrest_Create(x, y, z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));

	if (id == -1)
	    return SendClientMessage(playerid, COLOR_RED, "- ความจุของพื้นที่จับกุมในฐานข้อมูลเต็มแล้ว ไม่สามารถสร้างได้อีก (ติดต่อผู้พัฒนา)");

	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้สร้างพื้นที่จับกุมขึ้นมาใหม่ ไอดี: %d", id);
	return 1;
}

CMD:removearrest(playerid, params[])
{
	static
	    id = 0;

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, COLOR_WHITE, "/removearrest [ไอดี]");

	if ((id < 0 || id >= MAX_ARREST) || !arrestData[id][arrestExists])
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไม่มีไอดีพื้นที่จับกุมนี้อยู่ในฐานข้อมูล");

	Arrest_Delete(id);
	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้ลบพื้นที่จับกุมไอดี %d ออกสำเร็จ", id);
	return 1;
}

Arrest_Delete(arrestid)
{
	if (arrestid != -1 && arrestData[arrestid][arrestExists])
	{
	    static
	        string[64];

        if (IsValidDynamicPickup(arrestData[arrestid][arrestPickup]))
		    DestroyDynamicPickup(arrestData[arrestid][arrestPickup]);

		if (IsValidDynamic3DTextLabel(arrestData[arrestid][arrestText3D]))
		    DestroyDynamic3DTextLabel(arrestData[arrestid][arrestText3D]);

		format(string, sizeof(string), "DELETE FROM `arrestpoints` WHERE `arrestID` = '%d'", arrestData[arrestid][arrestID]);
		mysql_tquery(g_SQL, string);

		arrestData[arrestid][arrestExists] = false;
		arrestData[arrestid][arrestID] = 0;
	}
	return 1;
}

Arrest_Create(Float:x, Float:y, Float:z, interior, world)
{
	for (new i = 0; i < MAX_ARREST; i ++) if (!arrestData[i][arrestExists])
	{
	    arrestData[i][arrestExists] = true;
	    arrestData[i][arrestPosX] = x;
	    arrestData[i][arrestPosY] = y;
	    arrestData[i][arrestPosZ] = z;
	    arrestData[i][arrestInterior] = interior;
	    arrestData[i][arrestWorld] = world;

	    mysql_tquery(g_SQL, "INSERT INTO `arrestpoints` (`arrestInterior`) VALUES(0)", "OnArrestCreated", "d", i);
		Arrest_Refresh(i);
		return i;
	}
	return -1;
}

Arrest_Save(arrestid)
{
	static
	    query[220];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE `arrestpoints` SET `arrestX` = '%.4f', `arrestY` = '%.4f', `arrestZ` = '%.4f', `arrestInterior` = '%d', `arrestWorld` = '%d' WHERE `arrestID` = '%d'",
	    arrestData[arrestid][arrestPosX],
	    arrestData[arrestid][arrestPosY],
	    arrestData[arrestid][arrestPosZ],
	    arrestData[arrestid][arrestInterior],
	    arrestData[arrestid][arrestWorld],
	    arrestData[arrestid][arrestID]
	);
	return mysql_tquery(g_SQL, query);
}

Arrest_Refresh(arrestid)
{
	if (arrestid != -1 && arrestData[arrestid][arrestExists])
	{
		if (IsValidDynamicPickup(arrestData[arrestid][arrestPickup]))
		    DestroyDynamicPickup(arrestData[arrestid][arrestPickup]);

		if (IsValidDynamic3DTextLabel(arrestData[arrestid][arrestText3D]))
		    DestroyDynamic3DTextLabel(arrestData[arrestid][arrestText3D]);

		arrestData[arrestid][arrestPickup] = CreateDynamicPickup(1239, 23, arrestData[arrestid][arrestPosX], arrestData[arrestid][arrestPosY], arrestData[arrestid][arrestPosZ], arrestData[arrestid][arrestWorld], arrestData[arrestid][arrestInterior]);
  		arrestData[arrestid][arrestText3D] = CreateDynamic3DTextLabel("[Arrest : จุดส่งตัว]\n'กด Y เพื่อใช้งาน'" , COLOR_ORANGE, arrestData[arrestid][arrestPosX], arrestData[arrestid][arrestPosY], arrestData[arrestid][arrestPosZ], 5.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, arrestData[arrestid][arrestWorld], arrestData[arrestid][arrestInterior]);
	}
	return 1;
}

Arrest_Nearest(playerid)
{
    for (new i = 0; i != MAX_ARREST; i ++) if (arrestData[i][arrestExists] && IsPlayerInRangeOfPoint(playerid, 4.0, arrestData[i][arrestPosX], arrestData[i][arrestPosY], arrestData[i][arrestPosZ]))
	{
		if (GetPlayerInterior(playerid) == arrestData[i][arrestInterior] && GetPlayerVirtualWorld(playerid) == arrestData[i][arrestWorld])
			return i;
	}
	return -1;
}
forward OnArrestCreated(arrestid);
public OnArrestCreated(arrestid)
{
	if (arrestid == -1 || !arrestData[arrestid][arrestExists])
	    return 0;

	arrestData[arrestid][arrestID] = cache_insert_id();
	Arrest_Save(arrestid);

	return 1;
}

forward Arrest_Load();
public Arrest_Load()
{
	static
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_ARREST)
	{
	    arrestData[i][arrestExists] = true;

	    cache_get_value_name_int(i, "arrestID", arrestData[i][arrestID]);
	    cache_get_value_name_float(i, "arrestX", arrestData[i][arrestPosX]);
	    cache_get_value_name_float(i, "arrestY", arrestData[i][arrestPosY]);
	    cache_get_value_name_float(i, "arrestZ", arrestData[i][arrestPosZ]);
	    cache_get_value_name_int(i, "arrestInterior", arrestData[i][arrestInterior]);
	    cache_get_value_name_int(i, "arrestWorld", arrestData[i][arrestWorld]);

	    Arrest_Refresh(i);
	}
	printf("[SERVER]: %d Arrest were loaded from \"%s\" database...", rows, MYSQL_DATABASE);
	return 1;
}
