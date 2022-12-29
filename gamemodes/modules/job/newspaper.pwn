#include <YSI\y_hooks>

new CheckEnterPointDelivery[MAX_PLAYERS];
new StartJobNewpaper[MAX_PLAYERS];

new NewsPrice = random(100) + 25;

new Float:Paper[15][3] =
{
    {-260.6826,1120.0740,20.9399},
    {-258.7125,1151.0795,20.9399},
    {-258.7508,1168.8478,20.9399},
    {-290.4754,1176.7335,20.9399},
    {-298.2440,1115.2094,20.9399},
    {-328.5864,1118.8472,20.9399},
    {-290.4368,1176.6742,20.9399},
    {-324.3161,1165.2159,20.9399},
    {-366.6683,1166.6844,19.7422},
    {-360.3275,1141.6263,20.9399},
    {-362.2670,1110.6549,20.9399},
    {-258.9486,1083.5778,20.9399},
    {-258.6240,1043.8644,20.9399},
    {-278.8817,1003.5016,20.9399},
    {-247.8237,1001.4342,20.9399}
};
hook OnGameModeInit()
{
	CreateDynamicPickup(1239, 23, -185.4342,1210.5822,19.6668);//สมัครงาน
	CreateDynamic3DTextLabel("[Newspaper Delivery]\n{FFFFFF}กด 'Y' เพื่อสมัครงาน", COLOR_YELLOW, -185.4342,1210.5822,19.6668, 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
	
    CreateDynamicPickup(2055, 23, -190.0260,1209.6532,19.7422);//เริ่มงาน
	CreateDynamic3DTextLabel("[Newspaper Delivery]\n{FFFFFF}กด 'Y' เพื่อหยิบหนังสือพิมพ์", COLOR_YELLOW, -190.0260,1209.6532,19.7422, 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

    return 1;
}
hook OnPlayerConnect(playerid)
{
 
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{ 
        new string[128];

        if(IsPlayerInRangeOfPoint(playerid, 1.0, -185.4342,1210.5822,19.6668)) //สมัครงาน
        {
            if(Character[playerid][Job] == 0)
            {
                Character[playerid][Job] = 1;
                format(string, sizeof(string), "- สมัครงาน 'Newspaper Delivery' เรียบร้อย\"/leavejob\" เพื่อออกจากงาน");
                SendClientMessage(playerid, -1, string);
                return 1;
            }
            if(Character[playerid][Job] == 1)
                return SendClientMessage(playerid, COLOR_GRAY, "- คุณได้สมัครงาน\"Newspaper Delivery\"ไว้อยู่แล้ว");

            if(Character[playerid][Job] != 0)
                return LeaveJobs(playerid);
        }
        if(IsPlayerInRangeOfPoint(playerid, 1.0, -190.0260,1209.6532,19.7422)) //เริ่มงาน
        {
            if(Character[playerid][Job] != 1)
                return SendClientMessage(playerid, COLOR_GREY, "- คุณไม่ได้ทำอาชีพ Newspaper Delivery");

            if(StartJobNewpaper[playerid] == 0)
            {
                
                SendClientMessage(playerid, COLOR_GREY, "- ใช้ Bike ในการไปส่งหนังสือพิมพ์");
                GameTextForPlayer(playerid, "~w~Newspaper Delivery~G~ Start", 3000, 1) ;
                StartJobNewpaper[playerid] = 1;
            }
            else if(StartJobNewpaper[playerid] == 1)
            {
                DisablePlayerCheckpoint(playerid);
                GameTextForPlayer(playerid, "~w~Newspaper Delivery~r~ Cancel", 3000, 1) ;
                StartJobNewpaper[playerid] = 0;
                CheckEnterPointDelivery[playerid] = 0;
            }
        }
    }   
    return 1;
}
StartPlayerCheckPointDelivery1(playerid)
{
    new rand = random(sizeof(Paper));
    
    SetPlayerCheckpoint(playerid, Paper[rand][0], Paper[rand][1], Paper[rand][2], 2.0);
    CheckEnterPointDelivery[playerid] = 1;
    return 1;
}


hook OnPlayerEnterCheckpoint(playerid)
{
    if(Character[playerid][Job] == 1)
    {
        new string[128]);
        DisablePlayerCheckpoint(playerid);
        
        if (IsPlayerInAnyVehicle(playerid))
        {
            CheckEnterPointDelivery[playerid] = 0;
            return SendClientMessage(playerid, COLOR_GREY, "- ต้องไม่อยู่บนยานพาหนะ!");
        }

        if(CheckEnterPointDelivery[playerid] == 1) 
        {
            CheckEnterPointDelivery[playerid] = 0;
            GivePlayerMoneyEx(playerid, NewsPrice);

            ApplyAnimation(playerid, "ryder", "van_throw", 4.1, 0, 0, 0, 0, 0);
            ApplyAnimation(playerid, "null", "", 4.1, 0, 0, 0, 0, 0);
            ApplyAnimation(playerid, "ryder", "van_throw", 4.1, 0, 0, 0, 0, 0);

            format(string, sizeof(string), "~g~Pay~n~~w~ %d", FormatNumber(NewsPrice));
			PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
            GameTextForPlayer(playerid, string, 3000, 1);
            return 1;
        }
		
    }
    return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(Character[playerid][Job] == 1 && GetVehicleModel(vehicleid) == 509)
    {
        if(StartJobNewpaper[playerid] == 1 && CheckEnterPointDelivery[playerid] == 0)
        {
            StartPlayerCheckPointDelivery1(playerid);
            GameTextForPlayer(playerid, "~w~Newspaper Delivery~y~ Mark", 3000, 1) ;
        }
    }
    return 1;
}
