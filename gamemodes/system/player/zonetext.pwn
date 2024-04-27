#include 	<YSI_Coding\y_hooks>
#include <map-zones>

new PlayerText:ZonetextTD[MAX_PLAYERS][1];

ptask BlackWoods_Zonetext[200](playerid)
{
    new string[128];
    new MapZone:zone = GetPlayerMapZone(playerid);
    new name[MAX_MAP_ZONE_NAME];


    GetMapZoneName(zone, name);
    /*format(tmp2, sizeof(tmp2), "%s", name);
    GameTextForPlayer(playerid, tmp2, 3000, 4);*/
    new
        hours,
        minutes,
        seconds;
    gettime(hours, minutes, seconds);


    if(Inventory_HasItem(playerid, "Watch")){
        format(string, sizeof(string), "~h~(id: %d) %s, ~y~~h~%02d:%02d:%02d", playerid, name ,hours, minutes, seconds); 
	    PlayerTextDrawSetString(playerid, ZonetextTD[playerid][0], string);
        return 1;
    }
 	format(string, sizeof(string), "~h~(id: %d) %s", playerid, name); 
	PlayerTextDrawSetString(playerid, ZonetextTD[playerid][0], string);
    return 1;
}

CMD:whereami(playerid) 
{
    new string[128];
    new MapZone:zone = GetPlayerMapZone(playerid);

    if (zone == INVALID_MAP_ZONE_ID) {
        return SendClientMessage(playerid, 0xFFFFFFFF, "probably in the ocean, mate");
    }

    new name[MAX_MAP_ZONE_NAME], soundid;
    GetMapZoneName(zone, name);
    GetMapZoneSoundID(zone, soundid);


    format(string, sizeof(string), "you are in %s", name);
    SendClientMessage(playerid, 0xFFFFFFFF, string);
    PlayerPlaySound(playerid, soundid, 0.0, 0.0, 0.0);
    return 1;
}
hook OnPlayerConnect(playerid)
{
	ZonetextTD[playerid][0] = CreatePlayerTextDraw(playerid, 2.000000, 432.000000, "los santos international");
	PlayerTextDrawFont(playerid, ZonetextTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, ZonetextTD[playerid][0], 0.266665, 1.500000);
	PlayerTextDrawTextSize(playerid, ZonetextTD[playerid][0], 400.000000, 129.000000);
	PlayerTextDrawSetOutline(playerid, ZonetextTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, ZonetextTD[playerid][0], 1);
	PlayerTextDrawAlignment(playerid, ZonetextTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, ZonetextTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, ZonetextTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, ZonetextTD[playerid][0], 30);
	PlayerTextDrawUseBox(playerid, ZonetextTD[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, ZonetextTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, ZonetextTD[playerid][0], 0);
	return 1;
}
hook OnPlayerDisconnect(playerid, reason)
{
    PlayerTextDrawShow(playerid, ZonetextTD[playerid][0]);
    return 1;
}
/* -------------------------------------------------- Zonetext -------------------------------------------------- */
stock GetLocation(Float:fX, Float:fY, Float:fZ)
{
    enum e_ZoneData
    {
        e_ZoneName[32 char],
        Float:e_ZoneArea[6]
    };
    new const g_arrZoneData[][e_ZoneData] =
    {
        // ...
    };
    new
        name[32] = "San Andreas";

    for (new i = 0; i != sizeof(g_arrZoneData); i ++)
    {
        if (
            (fX >= g_arrZoneData[i][e_ZoneArea][0] && fX <= g_arrZoneData[i][e_ZoneArea][3]) &&
            (fY >= g_arrZoneData[i][e_ZoneArea][1] && fY <= g_arrZoneData[i][e_ZoneArea][4]) &&
            (fZ >= g_arrZoneData[i][e_ZoneArea][2] && fZ <= g_arrZoneData[i][e_ZoneArea][5]))
        {
            strunpack(name, g_arrZoneData[i][e_ZoneName]);

            break;
        }
    }
    return name;
}

stock GetPlayerLocation(playerid)
{
    new
        Float:fX,
        Float:fY,
        Float:fZ,
        string[32],
        id = -1;

    if ((id = House_Inside(playerid)) != -1)
    {
        fX = HouseData[id][housePos][0];
        fY = HouseData[id][housePos][1];
        fZ = HouseData[id][housePos][2];
    }
    // ...
    else GetPlayerPos(playerid, fX, fY, fZ);

    format(string, 32, GetLocation(fX, fY, fZ));
    return string;
}
stock GetPointZone(Float:x, Float:y, Float:z, zone[] = "San Andreas", len = sizeof(zone))
{
    for (new i, j = sizeof(Zones); i < j; i++)
    {
        if (x >= Zones[i][zArea][0] && x <= Zones[i][zArea][3] && y >= Zones[i][zArea][1] && y <= Zones[i][zArea][4] && z >= Zones[i][zArea][2] && z <= Zones[i][zArea][5])
        {
            strunpack(zone, Zones[i][zName], len);
            return 1;
        }
    }
    return 1;
}

stock GetPlayerZone(playerid, zone[], len = sizeof(zone))
{
    new Float:pos[3];
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

    for (new i, j = sizeof(Zones); i < j; i++)
    {
        if (x >= Zones[i][zArea][0] && x <= Zones[i][zArea][3] && y >= Zones[i][zArea][1] && y <= Zones[i][zArea][4] && z >= Zones[i][zArea][2] && z <= Zones[i][zArea][5])
        {
            strunpack(zone, Zones[i][zName], len);
            return 1;
        }
    }
    return 1;
}
