#include <YSI\y_hooks>

hook OnGameModeInit()
{
    //gate fortcarson
	CreateObject(971, -100.14598, 1111.59326, 20.94598,   0.00000, 0.00000, 0.00000);
}

hook OnPlayerConnect(playerid)
{

	RemoveBuildingForPlayer(playerid, 5340, 2644.8594, -2039.2344, 14.0391, 0.25);
    RemoveBuildingForPlayer(playerid, 5422, 2071.4766, -1831.4219, 14.5625, 0.25);
    RemoveBuildingForPlayer(playerid, 5856, 1024.9844, -1029.3516, 33.1953, 0.25);
    RemoveBuildingForPlayer(playerid, 5779, 1041.3516, -1025.9297, 32.6719, 0.25);
    RemoveBuildingForPlayer(playerid, 10575, -2716.3516, 217.4766, 5.3828, 0.25);
    RemoveBuildingForPlayer(playerid, 9093, 2386.6563, 1043.6016, 11.5938, 0.25);
    RemoveBuildingForPlayer(playerid, 6400, 488.2813, -1734.6953, 12.3906, 0.25);
    RemoveBuildingForPlayer(playerid, 11313, -1935.8594, 239.5313, 35.3516, 0.25);
    RemoveBuildingForPlayer(playerid, 11319, -1904.5313, 277.8984, 42.9531, 0.25);
    RemoveBuildingForPlayer(playerid, 9625, -2425.7266, 1027.9922, 52.2813, 0.25);
    RemoveBuildingForPlayer(playerid, 7891, 1968.7422, 2162.4922, 12.0938, 0.25);
    RemoveBuildingForPlayer(playerid, 3294, -1420.5469, 2591.1563, 57.7422, 0.25);
    RemoveBuildingForPlayer(playerid, 3294, -100.0000, 1111.4141, 21.6406, 0.25);

}

forward OnCarRepair(playerid,vehicleid);
public OnCarRepair(playerid,vehicleid)
{
    SetCameraBehindPlayer(playerid);
    SetVehiclePos(vehicleid, -100.1018,1107.8108,19.4016);
    SetVehicleZAngle(vehicleid, 0.5442);
    return 1;
}

CMD:enter(playerid, params[])
{
	if(!LoggedIn[playerid])
		return SendClientMessage(playerid, COLOR_RED, "�س�ѧ������������к�");

	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "[!] {FFFFFF}�س��������˹�ҷ����Ǩ");

	if(IsPlayerInAnyVehicle(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, -100.1018, 1107.8108, 19.4016))
		{
			new vid;
			vid = GetPlayerVehicleID(playerid);
			if(CarData[vid][carExists]) // function �����
			{
				SetTimerEx("OnCarRepair", 3500, false, "ui",playerid, vid);
				SetVehiclePos(vid, -99.8759, 1117.0695, 19.4013);
				SetVehicleZAngle(vid, 0.8282);
				SetPlayerCameraPos(playerid, -100.3225, 1106.1613, 22.1023);
				SetPlayerCameraLookAt(playerid, -99.8759,1117.0695,19.4013);
			}
			else {
				//printf("ID vehicle: %d SQL : %d VEH : %d",vid, CarData[vid][C_ID], CarData[vid][C_VEH]);
				return SendClientMessage(playerid, -1, "ö�ѹ�����辺��к� �ô�Դ����ʹ�Թ /report");
			}
				
		}
		else 
			return SendClientMessage(playerid, -1, "�س������������ʶҹ�����");
	}
	else
		return SendClientMessage(playerid, -1, "�س��������躹�ҹ��ҹ�");

	return 1;
}


