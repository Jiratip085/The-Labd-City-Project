#include	<YSI_Coding\y_hooks>

new bool:WarZone = true;
new takeZone[MAX_PLAYERS];
new takeOwnerZone[MAX_PLAYERS];
new takeZoneID[MAX_PLAYERS];

#define MAX_GZONE2 (200)
enum gzoneinfo2
{
	gZoneSID,
	gZoneColor,
	Float:gZoneCroods[4],
	gZoneOwner,
	gZoneCooldown,
	gZoneTake,
	gZoneExist,
}
new GangZoneInfo2[MAX_GZONE2][gzoneinfo2];
new GangZoneWar2[MAX_GZONE2];

hook OnGameModeInit()
{
	WarZone = false;
}

hook OnPlayerDisconnect(playerid, reason)
{
 	if (takeZone[playerid] == 1)
 	{
 	    new newzone = takeZoneID[playerid];
 	    
 	    GangZoneInfo2[newzone][gZoneTake] = 0;
 	    GangZoneStopFlashForAll(GangZoneWar2[newzone]);

		takeOwnerZone[playerid] = -1;

 	    StopProgress(playerid);
 	    takeZone[playerid] = 0;

		SendClientMessage(playerid, -1, "{FE2F0A}แจ้งเตือน :: {FBAFA2}เนื่องจากคุณเสียชีวิตระหว่างการยึดโซน, ทำให้การยึดล้มเหลว!");
 	}
}

hook OnPlayerConnect(playerid)
{
    takeZone[playerid] = 0;
    takeOwnerZone[playerid] = -1;
    takeZoneID[playerid] = -1;
}

Zone_Save(gpsid)
{
	static
	    query[4096];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE `gangzones2` SET `gZoneCroods0` = '%f', `gZoneCroods1` = '%f', `gZoneCroods2` = '%f', `gZoneCroods3` = '%f', `gZoneColor` = '%d', `gZoneOwner` = '%d', `gZoneCooldown` = '%d' WHERE `zoneindex` = '%d'",
	    GangZoneInfo2[gpsid][gZoneCroods][0],
	    GangZoneInfo2[gpsid][gZoneCroods][1],
	    GangZoneInfo2[gpsid][gZoneCroods][2],
	    GangZoneInfo2[gpsid][gZoneCroods][3],
	    GangZoneInfo2[gpsid][gZoneColor],
	    GangZoneInfo2[gpsid][gZoneOwner],
	    GangZoneInfo2[gpsid][gZoneCooldown],
	    GangZoneInfo2[gpsid][gZoneSID]
	);
	return mysql_tquery(g_SQL, query);
}


forward Zone_Load2();
public Zone_Load2()
{
	new
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_GZONE2)
	{
	    cache_get_value_name_int(i, "zoneindex", GangZoneInfo2[i][gZoneSID]);

	    cache_get_value_name_float(i, "gZoneCroods0", GangZoneInfo2[i][gZoneCroods][0]);
	    cache_get_value_name_float(i, "gZoneCroods1", GangZoneInfo2[i][gZoneCroods][1]);
	    cache_get_value_name_float(i, "gZoneCroods2", GangZoneInfo2[i][gZoneCroods][2]);
	    cache_get_value_name_float(i, "gZoneCroods3", GangZoneInfo2[i][gZoneCroods][3]);

	    cache_get_value_name_int(i, "gZoneColor", GangZoneInfo2[i][gZoneColor]);
	    cache_get_value_name_int(i, "gZoneOwner", GangZoneInfo2[i][gZoneOwner]);
	    cache_get_value_name_int(i, "gZoneCooldown", GangZoneInfo2[i][gZoneCooldown]);

		GangZoneInfo2[i][gZoneExist] = 1;

	    GangZoneWar2[i] = GangZoneCreate(GangZoneInfo2[i][gZoneCroods][0],GangZoneInfo2[i][gZoneCroods][1],GangZoneInfo2[i][gZoneCroods][2],GangZoneInfo2[i][gZoneCroods][3]);
	}
	return 1;
}

Zone_Create(Float:minx, Float:miny, Float:maxx, Float:maxy, color)
{
	for (new i = 0; i < MAX_GZONE2; i ++) if (!GangZoneInfo2[i][gZoneExist])
	{
	    GangZoneInfo2[i][gZoneExist] = 1;

		GangZoneInfo2[i][gZoneCroods][0] = minx;
		GangZoneInfo2[i][gZoneCroods][1] = miny;
		GangZoneInfo2[i][gZoneCroods][2] = maxx;
		GangZoneInfo2[i][gZoneCroods][3] = maxy;

		GangZoneInfo2[i][gZoneColor] = color;
		GangZoneInfo2[i][gZoneOwner] = -1;
		GangZoneInfo2[i][gZoneCooldown] = 0;
		GangZoneInfo2[i][gZoneTake] = 0;

	    GangZoneWar2[i] = GangZoneCreate(GangZoneInfo2[i][gZoneCroods][0],GangZoneInfo2[i][gZoneCroods][1],GangZoneInfo2[i][gZoneCroods][2],GangZoneInfo2[i][gZoneCroods][3]);

	    mysql_tquery(g_SQL, "INSERT INTO `gangzones2` (`zoneindex`) VALUES(0)", "OnZoneCreated", "d", i);
		return i;
	}
	return -1;
}

forward OnZoneCreated(zoneid);
public OnZoneCreated(zoneid)
{
	if (zoneid == -1 || !GangZoneInfo2[zoneid][gZoneExist])
	    return 0;

	GangZoneInfo2[zoneid][gZoneSID] = cache_insert_id();
	Zone_Save(zoneid);

	return 1;
}

CMD:createzone(playerid, params[])
{
	new
		id = 0, Float:minx, Float:miny, Float:maxx, Float:maxy,color;

	if (playerData[playerid][pAdmin] < 3)
		return ErrorMsg(playerid, "คุณไม่ได้รับอนุญาตให้ใช้งานคำสั่งนี้");

	if (sscanf(params, "ffffh", minx, miny, maxx, maxy, color))
		return SendClientMessage(playerid, COLOR_LIGHTBLUE, "การใช้งาน : {FFFFFF}/สร้างโซน [minx] [miny] [maxx] [maxy] [color]");

	id = Zone_Create(minx, miny, maxx, maxy, color);

	if (id == -1)
	    return ErrorMsg(playerid, "ความจุของ Zone ในฐานข้อมูลเต็มแล้ว ไม่สามารถสร้างได้อีก (ติดต่อผู้พัฒนา)");

	SendClientMessageEx(playerid, -1, "{F43E09}แจ้งเตือน :: {FBBCAA}คุณได้ทำการสร้างโซนไอดี {ffffff}%d {FBBCAA}เรียบร้อยแล้ว", id);
	return 1;
}

CMD:deletezone(playerid, params[])
{
	new id;

	if (playerData[playerid][pAdmin] < 3)
		return ErrorMsg(playerid, "คุณไม่ได้รับอนุญาตให้ใช้งานคำสั่งนี้");

	if (sscanf(params, "d", id))
		return SendClientMessage(playerid, COLOR_LIGHTBLUE, "การใช้งาน : {FFFFFF}/ลบโซน [ไอดี]");

	GangZoneInfo2[id][gZoneExist] = 0;
	GangZoneDestroy(GangZoneWar2[id]);

	new query[256];

	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM gangzones2 WHERE zoneindex = %d", id);
	mysql_tquery(g_SQL, query);

	SendClientMessageEx(playerid, -1, "{F43E09}แจ้งเตือน :: {FBBCAA}คุณได้ทำการลบโซนไอดี {ffffff}%d {FBBCAA}เรียบร้อยแล้ว", id);
	return 1;
}

stock IsPlayerInGZone(playerid, zoneid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    return (x > GangZoneInfo2[zoneid][gZoneCroods][0] && x < GangZoneInfo2[zoneid][gZoneCroods][2] && y > GangZoneInfo2[zoneid][gZoneCroods][1] && y < GangZoneInfo2[zoneid][gZoneCroods][3]);
}

stock GetPlayerGZone(playerid)
{
    for(new i=0; i != MAX_GZONE2; i++)
    {
        if(IsPlayerInGZone(playerid, i))
        {
            return i;
        }
    }
    return -1;
}
CMD:warzone(playerid, params[])
{
	if (playerData[playerid][pAdmin] >= 4)
	{
		WarZone = true;
	}
	return 1;
}
alias:takezone("ยึดโซน")
CMD:takezone(playerid, params[])
{
	if (!WarZone)
		return ErrorMsg(playerid, "ระบบวอร์โซนถูกปิดการใช้งานอยู่!");

	// --> ระบบ GangZone
	new newzone = GetPlayerGZone(playerid);
	if(newzone != -1)
	{
		if (GangZoneInfo2[newzone][gZoneCooldown] > 0)
		    return ErrorMsg(playerid, "คุณต้องรอ %d วินาทีถึงจะยึดโซนนี้ได้", GangZoneInfo2[newzone][gZoneCooldown]);

		if (takeZone[playerid] == 1)
			return ErrorMsg(playerid, "คุณอยู่ระหว่างการยึดโซน");

		if (GangZoneInfo2[newzone][gZoneTake] == 1)
			return ErrorMsg(playerid, "มีคนกำลังยึดโซน!");

		if (GetFactionType(playerid) != FACTION_GANG)
		    return ErrorMsg(playerid, "สำหรับแก๊งเท่านั้น!");

		takeZone[playerid] = 1;
		TogglePlayerControllable(playerid, false);
		StartProgress(playerid, 300, 0, INVALID_OBJECT_ID);
		GangZoneInfo2[newzone][gZoneTake] = 1;
		SendClientMessage(playerid, -1, "{06DCF9}แจ้งเตือน :: {BEF4FB}คุณได้เริ่มต้นการยึดพื้นที่โซนบริเวณนี้แล้ว!");
		
		new ownerzone = GetFactionByID(GangZoneInfo2[newzone][gZoneOwner]);
		takeOwnerZone[playerid] = ownerzone;
		takeZoneID[playerid] = newzone;

		GangZoneFlashForAll(GangZoneWar2[newzone], factionData[playerData[playerid][pFaction]][factionColor]);
	}
	else return ErrorMsg(playerid, "คุณไม่ได้อยู่ภายในโซนใด ๆ");
	return 1;
}

PlayerTakeZoneUnfreeze(playerid)
{
    new newzone = GetPlayerGZone(playerid), factionid = playerData[playerid][pFaction];

	takeZone[playerid] = 0;
	ClearAnimations(playerid);
	TogglePlayerControllable(playerid, true);
	GangZoneInfo2[newzone][gZoneTake] = 0;

    GangZoneInfo2[newzone][gZoneCooldown] = 30;
    GangZoneInfo2[newzone][gZoneOwner] = factionData[factionid][factionID];
    GangZoneInfo2[newzone][gZoneColor] = factionData[factionid][factionColor];

    Zone_Save(newzone);
    
    factionData[factionid][factionWarZone] ++;
    Faction_Save(factionid);

	SendClientMessageToAllEx(-1, "{59595B}|=====================================================================|");
	SendClientMessageToAllEx(-1, "{F93D0F}ประกาศ :: {FDB8A7}ผู้เล่น {ffffff}%s {FDB8A7}จากกลุ่ม {%06x}%s", GetPlayerNameEx(playerid), factionData[factionid][factionColor] >>> 8, factionData[factionid][factionName]);
	SendClientMessageToAllEx(-1, "{F93D0F}ประกาศ :: {FDB8A7}ได้ทำการยึดพื้นที่โซนของ {%06x}%s {FDB8A7}สำเร็จแล้ว!", factionData[takeOwnerZone[playerid]][factionColor] >>> 8, factionData[takeOwnerZone[playerid]][factionName]);
	SendClientMessageToAllEx(-1, "{F7A40A}สถิติการยึดพื้นที่ : {FBF395}เป็นการยึดพื้นที่ครั้งที่ {ffffff}%s", FormatNumber(factionData[factionid][factionWarZone]));
	SendClientMessageToAllEx(-1, "{09D4F0}นักข่าว :: {B4EFF7}พื้นที่โซนนั้นได้ถูกเปลี่ยนเจ้าของเรียบร้อยแล้ว!");
	SendClientMessageToAllEx(-1, "{59595B}|=====================================================================|");
	
	GangZoneStopFlashForAll(newzone);
	takeOwnerZone[playerid] = -1;
	takeZoneID[playerid] = -1;

	return 1;
}

hook OnProgressFinish(playerid, objectid)
{
	if (takeZone[playerid] == 1)
		PlayerTakeZoneUnfreeze(playerid);

    return Y_HOOKS_CONTINUE_RETURN_0;
}

hook OnProgressUpdate(playerid, progress, objectid)
{
	if (takeZone[playerid] == 1)
	{
		ApplyAnimation(playerid, "BD_FIRE","wash_up", 4.1, 1, 0, 0, 1, 0, 1);
	}
	return Y_HOOKS_BREAK_RETURN_1;
}

ptask PlayerZoneTimer[1000](playerid)
{
	if (!playerData[playerid][IsLoggedIn])
		return 0;

	for(new i=0; i != MAX_GZONE2; i++)
	{
		if (GangZoneInfo2[i][gZoneExist] == 1 && GangZoneInfo2[i][gZoneTake] == 0)
			GangZoneShowForPlayer(playerid, GangZoneWar2[i], GangZoneInfo2[i][gZoneColor]);
	}
	return 1;
}

task ZoneTimer[1000]()
{
    for(new i=0; i != MAX_GZONE2; i++)
    {
        if (GangZoneInfo2[i][gZoneExist] == 1 && GangZoneInfo2[i][gZoneTake] == 0)
        {
		    if (GangZoneInfo2[i][gZoneCooldown] > 0)
			{
				GangZoneInfo2[i][gZoneCooldown] --;

				if (GangZoneInfo2[i][gZoneCooldown] == 0)
				{
					SendClientMessageToAllEx(-1, "{F93D0F}ประกาศ :: {FDB8A7}หมดเวลาคูลดาวน์พื้นที่โซนไอดี {ffffff}%d {FDB8A7}เรียบร้อยแล้ว", i);
				}
			}
		    if (GangZoneInfo2[i][gZoneCooldown] < 0) GangZoneInfo2[i][gZoneCooldown] = 0;

			Zone_Save(i);
		}
	}
}
