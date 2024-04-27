#include	<YSI_Coding\y_hooks>
/*
new NPCBus;

hook OnGameModeInit()
{
	ConnectNPC("Busdriver","Bus");

	//Vehicles
    NPCBus = CreateVehicle(431, 0.0, 0.0, 5.0, 0.0, 0, 0, 5000);

    //Objects
    CreateObject(1257, 2243.8464355469, -1725.9122314453, 13.826066970825, 0, 0, 90);
    CreateObject(1257, 1188.8359375, -1354.6279296875, 13.848303794861, 0, 0, 179.99450683594);
    CreateObject(1257, 1948.3315429688, -1454.3532714844, 13.826066970825, 0, 0, 90);
    CreateObject(1257, 1860.3641357422, -1160.7390136719, 24.132461547852, 0, 0, 180);
    CreateObject(1257, 1571.0646972656, -2188.0112304688, 13.826066970825, 0, 0, 90);
    CreateObject(1257, 393.74227905273, -1766.5667724609, 5.8194541931152, 0, 0, 90);
    CreateObject(1257, 850.67614746094, -1333.9708251953, 13.915329933167, 0, 0, 270);
    CreateObject(1257, 2295.6674804688, -2288.6452636719, 13.826066970825, 0, 0, 315);
    CreateObject(1257, 1705.5905761719, -1805.8479003906, 13.826066970825, 0, 0, 90);
    CreateObject(1257, 2636.3247070313, -1693.1252441406, 11.185441970825, 0, 0, 180);
    CreateObject(1257, 2868.9033203125, -1416.4068603516, 11.331715583801, 0, 0, 180);
    CreateObject(1257, 1567.0969238281, -1725.4758300781, 13.826066970825, 0, 0, 90);
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid))
    {
        new npcname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, npcname, sizeof(npcname));
        if(!strcmp(npcname, "Busdriver", true))
        {
        	PutPlayerInVehicle(playerid, NPCBus, 0);
        	SetPlayerSkin(playerid, 255);
        	ResetPlayerWeapons(playerid);
        }
        return 1;
    }
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if (vehicleid == NPCBus)
	{
        if(IsPlayerNPC(playerid))
            return 1;
	
	    if (GetPlayerMoneyEx(playerid) < 500)
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "> คุณมีเงินไม่เพียงพอ");
	        
		GivePlayerMoneyEx(playerid, -500);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "> คุณได้เสียเงินจำนวน $500 สำหรับค่าโดยสาร");
	}
	return 1;
}

alias:routue("ทางเดินรถ")
CMD:routue(playerid, params[])
{
	if(IsAtBusStop(playerid))
	{
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "เส้นทางรถเมย์ : {FFFFFF}East Beach - Stadium - Ganton - Idlewood - Glen Park - All Saints - Market Station - Santa Maria Beach - Crane.");
	}
	return 1;
}

CMD:gotobus(playerid, params[])
{
	if (playerData[playerid][pAdmin] < 1)
	    return 1;

	PutPlayerInVehicle(playerid, NPCBus, 2);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "> คุณได้วาร์ปขึ้นรถ 'รถบัส' เรียบร้อยแล้ว");
	return 1;
}

forward IsAtBusStop(playerid);
public IsAtBusStop(playerid)
{
    if(IsPlayerConnected(playerid))
	{
    	if(IsPlayerInRangeOfPoint(playerid,3.0,2868.9622,-1416.5736,11.0518) || IsPlayerInRangeOfPoint(playerid,3.0,1860.4075,-1159.9828,23.8553) || IsPlayerInRangeOfPoint(playerid,3.0,1189.1868,-1354.8392,13.5687)
    	   || IsPlayerInRangeOfPoint(playerid,3.0,850.7612,-1333.9199,13.6376) || IsPlayerInRangeOfPoint(playerid,3.0,2243.9165,-1726.0015,13.5469) || IsPlayerInRangeOfPoint(playerid,3.0,2636.3699,-1692.7764,10.9063)
    	   || IsPlayerInRangeOfPoint(playerid,3.0,1948.7146,-1454.3983,13.5469) || IsPlayerInRangeOfPoint(playerid,3.0,393.6521,-1766.6113,5.5408) || IsPlayerInRangeOfPoint(playerid,3.0,1567.2344,-1725.5209,13.5469)
    	   || IsPlayerInRangeOfPoint(playerid,3.0,1705.7418,-1806.0801,13.5469) || IsPlayerInRangeOfPoint(playerid,3.0,1570.9974,-2188.0564,13.5469) || IsPlayerInRangeOfPoint(playerid,3.0,2295.2600,-2288.5183,13.5469))
		{
        	return 1;
		}
	}
	return 0;
}
*/