#include	<YSI_Coding\y_hooks>

/*

// ตัวอย่างการเปิดใช้งานเส้น GPS นำทาง

Dialog:DIALOG_GPSPICK(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new var[32];
	    format(var, sizeof(var), "GPSID%d", listitem);
	    new gpsid = GetPVarInt(playerid, var);
		SetPlayerCheckpoint(playerid, gpsData[gpsid][gpsPosX], gpsData[gpsid][gpsPosY], gpsData[gpsid][gpsPosZ], 3.0);
		GPSNavigateToPoint(playerid, gpsData[gpsid][gpsPosX], gpsData[gpsid][gpsPosY], gpsData[gpsid][gpsPosZ]);
		SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้เปิดระบบ GPS ค้นหาสถานที่ชื่อ %s", gpsData[gpsid][gpsName]);
		if (gpsid == 0)
		{
			if (playerData[playerid][pQuest] == 0)
			{
				SetPVarInt(playerid, "GPSQUEST", 1);
			}
		}
		else if (gpsid == 11)
		{
			if (playerData[playerid][pQuest] == 2)
			{
				SetPVarInt(playerid, "GPSQUEST", 1);
			}
		}
	}
	return 1;
}
*/
new GPSOn[MAX_PLAYERS] = 0, gpsColor[MAX_PLAYERS];
Dialog:DIALOG_GPSPICK(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		if(StartElectricalPoleJob[playerid] == true || StartGarbageJobs[playerid] == true)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณไม่สามารถมาร์ค GPS ได้ในขณะที่คุณกำลังทำงาน");

	    new var[32];
	    format(var, sizeof(var), "GPSID%d", listitem);
	    new gpsid = GetPVarInt(playerid, var);
		SetPlayerCheckpoint(playerid, gpsData[gpsid][gpsPosX], gpsData[gpsid][gpsPosY], gpsData[gpsid][gpsPosZ], 3.0);
		GPSNavigateToPoint(playerid, gpsData[gpsid][gpsPosX], gpsData[gpsid][gpsPosY], gpsData[gpsid][gpsPosZ]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "[GPS] คุณได้มาร์คสถานที่ {FFFFFF}'%s'{FFFF00} ไว้ใน mini map", gpsData[gpsid][gpsName]);
		GPSOn[playerid] = 1;
		PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	}
	return 1;
}

// --> ระบบ GPS นำทาง
#define ROUTE_ZONE_SIZE			15.0

#define MAX_GPS_ROUTE_LEN		1000

#define MAX_PLAYER_GPS_ROUTES	1
#define MAX_PLAYER_GPS_ZONES 	MAX_PLAYER_GZ
#define GPS_ROUTEID_OFFSET		100000 // This is used to avoid conflicts with the routeid in GPS_WhenRouteIsCalculated
#define GPSR_UPDATE_INTERVAL	1000

#define MAX_GPS_ROUTE_ZONES		(MAX_PLAYER_GPS_ZONES / MAX_PLAYER_GPS_ROUTES)

enum (+=1)
{
	ROUTE_CALC_NONE,
	ROUTE_CALC_INIT,
	ROUTE_CALC_UPDATE
};

enum E_PLAYER_ROUTE
{
	bool:routeActivated,
	routeCalcState,
	routeExtra,
	bool:routeUpdate,
	bool:routeInitial,
	bool:routeLandVehicles,
	routeTimerID,

	routePos,
	routeLen,
	routeNumZones,

	routeNode1,
	routeNode2,

	Float:routeTargetX,
	Float:routeTargetY,
	Float:routeTargetZ,
	Float:routeTargetDistance,
	routeColor
};

new gPlayerRouteData[MAX_PLAYERS][MAX_PLAYER_GPS_ROUTES][E_PLAYER_ROUTE], gDefPlayerRouteData[E_PLAYER_ROUTE];

new gPlayerGangZones[MAX_PLAYERS][MAX_PLAYER_GPS_ROUTES][MAX_GPS_ROUTE_ZONES];

forward GPSR_UpdateRoute(playerid, routeid); // internal

new const bool:GPSR_LandVehicles[212] =
{
    true, true, true, true, true, true, true,
    true, true, true, true, true, true, true, true,
    true, true, false, true, true, true, true, true,
    true, true, false, true, true, true, true, false,
    true, true, true, true, true, true, true, true,
    true, true, true, true, true, true, true,
    false, false, true, false, true, true, false,
    false, false, true, true, true, true, true, false,
    true, true, true, false, false, true, true,
    true, false, true, true, false, false, true,
    true, false, true, true, true, true, true, true,
    true, false, true, true, false, false, true, true,
    true, true, false, true, true, true, false, true,
    true, true, false, true, true, true, true, true,
    true, true, true, true, false, false, false,
    true, true, true, true, true, false, false, true,
    true, true, true, true, true, true, true, true,
    true, true, true, true, true, true, true, false,
    false, false, true, true, true, true, true, true,
    true, true, false, true, true, true, true, false,
    true, true, true, true, true, true, true,
    true, true, false, true, true, true, true, true,
    false, false, true, true, true, true, true,
    true, false, true, true, true, true, true, true,
    true, true, true, true, true, true, false,
    true, false, false, true, false, true, true,
    true, true, true, true, true, true, true, true,
    true, true, true, true, true, true
};

forward GPSR_OnPlayerRouteFound(playerid, routeid, extra, Float:distance);
forward GPSR_OnPlayerReachDestination(playerid, routeid, extra);

hook OnPlayerConnect(playerid)
{
    gpsColor[playerid] = 15927811;
}

// --> ระบบ GPS นำทาง
ProcessRoute(playerid, routeid, const node_id_array[], amount_of_nodes, Float:distance)
{
	if(amount_of_nodes < 3)
	{
		if(gPlayerRouteData[playerid][routeid][routeCalcState] == ROUTE_CALC_INIT) DisablePlayerRoute(playerid, routeid);
		gPlayerRouteData[playerid][routeid][routeCalcState] = ROUTE_CALC_NONE;

		return 1;
	}
	ResetPlayerRoute(playerid, routeid);

	gPlayerRouteData[playerid][routeid][routeCalcState] = ROUTE_CALC_NONE;
	gPlayerRouteData[playerid][routeid][routeLen] = amount_of_nodes;

	DrawPlayerRoute(playerid, routeid, node_id_array);

	if(gPlayerRouteData[playerid][routeid][routeInitial] && funcidx("GPSR_OnPlayerRouteFound") != -1)
	{
		CallLocalFunction("GPSR_OnPlayerRouteFound", "iiif", playerid, routeid, gPlayerRouteData[playerid][routeid][routeExtra], distance);
	}

	return 1;
}


forward GPSR_OnRouteCalculated(Path:pathid, playerid, routeid);
public GPSR_OnRouteCalculated(Path:pathid, playerid, routeid)
{
	static path[MAX_GPS_ROUTE_LEN];
	new size, c, MapNode:nodeid, Float:distance;

	GetPathSize(pathid, size);

	for(new i = 0; i < size && i < sizeof(path); i ++)
	{
		GetPathNode(pathid, i, nodeid);
		path[i] = _:nodeid;

		c ++;
	}

	GetPathLength(pathid, distance);

	ProcessRoute(playerid, routeid, path, c, distance);
}

public GPSR_UpdateRoute(playerid, routeid)
{
	if(gPlayerRouteData[playerid][routeid][routeActivated])
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);

		if(VectorSize(x - gPlayerRouteData[playerid][routeid][routeTargetX], y - gPlayerRouteData[playerid][routeid][routeTargetY], 0.0) < gPlayerRouteData[playerid][routeid][routeTargetDistance])
		{
			CallLocalFunction("GPSR_OnPlayerReachDestination", "iii", playerid, routeid, gPlayerRouteData[playerid][routeid][routeExtra]);
		}
		else
		{
			FindPlayerRoute(playerid, gPlayerRouteData[playerid][routeid][routeExtra], gPlayerRouteData[playerid][routeid][routeTargetX], gPlayerRouteData[playerid][routeid][routeTargetY], gPlayerRouteData[playerid][routeid][routeTargetZ], gPlayerRouteData[playerid][routeid][routeTargetDistance], gPlayerRouteData[playerid][routeid][routeColor], true, gPlayerRouteData[playerid][routeid][routeLandVehicles], false);
		}
	}

	return 1;
}

FindPlayerRoute(playerid, extra, Float:x, Float:y, Float:z, Float:target_distance = 10.0, color, bool:update = false, bool:land_vehicles = false, bool:initial = true)
{
	if(!IsPlayerConnected(playerid)) return -1;

	new routeid = FindFreeRouteSlot(playerid, extra);

	if(routeid == -1) return -1;

	new node_start, node_end, Float:px, Float:py, Float:pz;
	
	//color = gpsColor[playerid];

	GetPlayerPos(playerid, px, py, pz);
	GetClosestMapNodeToPoint(px, py, pz, MapNode:node_start);
	GetClosestMapNodeToPoint(x, y, z, MapNode:node_end);

	if(!IsValidMapNode(MapNode:node_start) || !IsValidMapNode(MapNode:node_end)) return -1;

	if(gPlayerRouteData[playerid][routeid][routeActivated] && gPlayerRouteData[playerid][routeid][routeNode1] == node_start && gPlayerRouteData[playerid][routeid][routeNode2] == node_end)
	{
		return -1;
	}

	gPlayerRouteData[playerid][routeid][routeActivated] = true;
	gPlayerRouteData[playerid][routeid][routeCalcState] = ROUTE_CALC_INIT;

	gPlayerRouteData[playerid][routeid][routeUpdate] = update;
	gPlayerRouteData[playerid][routeid][routeInitial] = initial;
	gPlayerRouteData[playerid][routeid][routeLandVehicles] = land_vehicles;

	if(gPlayerRouteData[playerid][routeid][routeTimerID] != 0)
	{
		KillTimer(gPlayerRouteData[playerid][routeid][routeTimerID]);
		gPlayerRouteData[playerid][routeid][routeTimerID] = 0;
	}

	if(update) gPlayerRouteData[playerid][routeid][routeTimerID] = SetTimerEx("GPSR_UpdateRoute", GPSR_UPDATE_INTERVAL, 1, "ii", playerid, routeid);

	gPlayerRouteData[playerid][routeid][routeNode1] = node_start;
	gPlayerRouteData[playerid][routeid][routeNode2] = node_end;

	gPlayerRouteData[playerid][routeid][routeExtra] = extra;
	gPlayerRouteData[playerid][routeid][routeTargetX] = x;
	gPlayerRouteData[playerid][routeid][routeTargetY] = y;
	gPlayerRouteData[playerid][routeid][routeTargetZ] = z;
	gPlayerRouteData[playerid][routeid][routeTargetDistance] = target_distance;
	gPlayerRouteData[playerid][routeid][routeColor] = color;

	new bool:calc = true;

	if(gPlayerRouteData[playerid][routeid][routeLandVehicles])
	{
		new pstate = GetPlayerState(playerid);

		if((pstate != PLAYER_STATE_DRIVER && pstate != PLAYER_STATE_PASSENGER) || !GPSR_IsLandVehicle(GetPlayerVehicleID(playerid)))
		{
			ResetPlayerRoute(playerid, routeid);

			calc = false;
		}
	}

	if(calc)
	{
		FindPathThreaded(MapNode:node_start, MapNode:node_end, "GPSR_OnRouteCalculated", "ii", playerid, routeid);
	}

	return routeid;
}

FindFreeRouteSlot(playerid, extra = cellmin)
{
	if(!IsPlayerConnected(playerid)) return -1;

	if(extra != cellmin)
	{
		for(new i = 0; i < MAX_PLAYER_GPS_ROUTES; i ++) if(gPlayerRouteData[playerid][i][routeActivated] && gPlayerRouteData[playerid][i][routeExtra] == extra) return i;
	}

	for(new i = 0; i < MAX_PLAYER_GPS_ROUTES; i ++) if(!gPlayerRouteData[playerid][i][routeActivated]) return i;

	return -1;
}

ResetPlayerRoute(playerid, routeid)
{
	if(!IsPlayerConnected(playerid) || routeid < 0 || routeid >= MAX_PLAYER_GPS_ROUTES || !gPlayerRouteData[playerid][routeid][routeActivated]) return 0;

	new num = gPlayerRouteData[playerid][routeid][routeNumZones];

	for(new i = 0; i < num; i ++)
	{
		PlayerGangZoneHide(playerid, gPlayerGangZones[playerid][routeid][i]);
		PlayerGangZoneDestroy(playerid, gPlayerGangZones[playerid][routeid][i]);
	}

	gPlayerRouteData[playerid][routeid][routeNumZones] = 0;
	gPlayerRouteData[playerid][routeid][routePos] = 0;
	gPlayerRouteData[playerid][routeid][routeLen] = 0;

	return 1;
}

DisablePlayerRoute(playerid, routeid)
{
	if(!IsPlayerConnected(playerid) || routeid < 0 || routeid >= MAX_PLAYER_GPS_ROUTES || !gPlayerRouteData[playerid][routeid][routeActivated]) return 0;

	if(gPlayerRouteData[playerid][routeid][routeTimerID] != 0)
	{
		KillTimer(gPlayerRouteData[playerid][routeid][routeTimerID]);
		gPlayerRouteData[playerid][routeid][routeTimerID] = 0;
	}

	ResetPlayerRoute(playerid, routeid);

	gPlayerRouteData[playerid][routeid] = gDefPlayerRouteData;

	return 1;
}

DrawPlayerRoute(playerid, routeid, const node_id_array[])
{
	if(!IsPlayerConnected(playerid) || routeid < 0 || routeid >= MAX_PLAYER_GPS_ROUTES || !gPlayerRouteData[playerid][routeid][routeActivated] || gPlayerRouteData[playerid][routeid][routeCalcState] != ROUTE_CALC_NONE) return 0;

	new len = gPlayerRouteData[playerid][routeid][routeLen], num_zones;

	new Float:x, Float:y, Float:tx, Float:ty, Float:w, nodeid, Float:dis, gzid;

	for(new i = 0; i < len && num_zones < MAX_GPS_ROUTE_ZONES; i ++)
	{
		nodeid = node_id_array[i];

		if(!IsValidMapNode(MapNode:nodeid)) continue;

		GetMapNodePos(MapNode:nodeid, tx, ty, w);

		if(i == 0)
		{
			x = tx;
			y = ty;

			continue;
		}

		#if 1 // Interpolation between Nodes (always the same zone size)

		while(num_zones < MAX_GPS_ROUTE_ZONES && (dis = VectorSize(tx - x, ty - y, 0.0)) > ROUTE_ZONE_SIZE)
		{
			x += (tx - x) / dis * ROUTE_ZONE_SIZE;
			y += (ty - y) / dis * ROUTE_ZONE_SIZE;

			gzid = PlayerGangZoneCreate(playerid, x - ROUTE_ZONE_SIZE/2.0, y - ROUTE_ZONE_SIZE/2.0, x + ROUTE_ZONE_SIZE/2.0, y + ROUTE_ZONE_SIZE/2.0);

			if(gzid != -1)
			{
				gPlayerGangZones[playerid][routeid][num_zones] = gzid;
				PlayerGangZoneShow(playerid, gzid, gPlayerRouteData[playerid][routeid][routeColor]);

				num_zones ++;
			}
		}

		#else // No interpolation, rectangles from Node to Node (test)

		new Float:minx, Float:miny, Float:maxx, Float:maxy;

		if(tx < x)
		{
			minx = tx;
			maxx = x;
		}
		else
		{
			minx = x;
			maxx = tx;
		}

		if(ty < y)
		{
			miny = ty;
			maxy = y;
		}
		else
		{
			miny = y;
			maxy = ty;
		}

		if(maxx - minx < 7.0)
		{
			minx -= 3.5;
			maxx += 3.5;
		}

		if(maxy - miny < 7.0)
		{
			miny -= 3.5;
			maxy += 3.5;
		}

		//printf("%.1f, %.1f // %.1f, %.1f", minx, miny, maxx, maxy);

		gzid = PlayerGangZoneCreate(playerid, minx, miny, maxx, maxy);

		if(gzid != -1)
		{
			gPlayerGangZones[playerid][routeid][num_zones] = gzid;
			PlayerGangZoneShow(playerid, gzid, gPlayerRouteData[playerid][routeid][routeColor]);

			num_zones ++;
		}

		x = tx;
		y = ty;

		#endif

		gPlayerRouteData[playerid][routeid][routePos] = i;
	}

	gPlayerRouteData[playerid][routeid][routeNumZones] = num_zones;

	#if defined GPSR_DEBUG
	printf("Created %d GZ, total nodes: %d", num_zones, len);
	#endif

	return 1;
}

static GPSR_IsLandVehicle(vehicleid)
{
	new modelid = GetVehicleModel(vehicleid);

	if(modelid >= 400 && modelid <= 611) return _:GPSR_LandVehicles[modelid - 400];

	return 0;
}

GPSNavigateToPoint(playerid, Float:toX, Float:toY, Float:toZ, extraid = -1, bool:needVehicle = false) {
    new routeid = FindFreeRouteSlot(playerid, extraid);
	if(routeid == -1) {
        for(new i = 0; i < MAX_PLAYER_GPS_ROUTES; i ++)
            DisablePlayerRoute(playerid, i);
    }
    
    FindPlayerRoute(playerid, extraid, toX, toY, toZ, _, gpsColor[playerid], true, needVehicle);
}

ClearGPS(playerid) {
    for(new i = 0; i < MAX_PLAYER_GPS_ROUTES; i ++)
        DisablePlayerRoute(playerid, i);
}

public GPSR_OnPlayerReachDestination(playerid, routeid, extra) {
    if (extra == -1) {
        for(new i = 0; i < MAX_PLAYER_GPS_ROUTES; i ++)
            DisablePlayerRoute(playerid, i);
    }
    return 1;
}

hook OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if (GPSOn[playerid] == 0)
	{
	    GPSNavigateToPoint(playerid, fX, fY, fZ);
	    GPSOn[playerid] = 1;
	}
	else
	{
	    GPSOn[playerid] = 0;
	    ClearGPS(playerid);
	}
    return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if (GPSOn[playerid] == 1)
	{
	    GPSOn[playerid] = 0;
		ClearGPS(playerid);
		DisablePlayerCheckpoint(playerid);
		PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
	}
	return 1;
}

alias:setgps("ตั้งค่าจีพีเอส")
CMD:setgps(playerid, params[])
{
    return Dialog_Show(playerid, DIALOG_SETTING_GPS, DIALOG_STYLE_TABLIST, "Navigator - Settings", "{ffffff}สีเส้นนำทาง\t{%06x}||||||||||\n{96FA0F}> {ffffff}ตั้งค่าสีเส้นนำทาง", "ตกลง", "ออก", gpsColor[playerid] >>> 8);
}

Dialog:DIALOG_SETTING_GPS(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	        
	        }
	        case 1:
	        {
    			return Dialog_Show(playerid, DIALOG_HEX_COLOR, DIALOG_STYLE_INPUT, "Navigator - Hex", "{FC4D07}กรุณากรอกโค้ดสี Hex :\n{ffffff}รูปแบบโค้ดสี Hex ที่ต้องใส่ : {F79E0C}0x{โค๊ดสี 6 หลัก}FF\n{F7490C}คำเตือน : {FDC5B1}ต้องระบุโค้ดสีตามรูปแบบเท่านั้นถึงจะใช้งานได้!", "ตกลง", "ออก");
	        }
	    }
	}
	return 1;
}

Dialog:DIALOG_HEX_COLOR(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new color;

	    if (sscanf(inputtext, "h", color))
  			return Dialog_Show(playerid, DIALOG_HEX_COLOR, DIALOG_STYLE_INPUT, "Navigator - Hex", "{FC4D07}กรุณากรอกโค้ดสี Hex :\n{ffffff}รูปแบบโค้ดสี Hex ที่ต้องใส่ : {F79E0C}0x{โค๊ดสี 6 หลัก}FF\n{F7490C}คำเตือน : {FDC5B1}ต้องระบุโค้ดสีตามรูปแบบเท่านั้นถึงจะใช้งานได้!", "ตกลง", "ออก");

		gpsColor[playerid] = color;
    	return Dialog_Show(playerid, DIALOG_SETTING_GPS, DIALOG_STYLE_TABLIST, "Navigator - Settings", "{ffffff}สีเส้นนำทาง\t{%06x}||||||||||\n{96FA0F}> {ffffff}ตั้งค่าสีเส้นนำทาง", "ตกลง", "ออก", gpsColor[playerid] >>> 8);
	}
	return 1;
}
