#include <a_samp>
#include <streamer>

new plane;

public OnFilterScriptInit()
{
	print("\n===================================");
	print("|      Plane      |");
	print("=====================================\n");
	plane = CreateDynamicObject(1683, -33.26580, 2506.87354, 150.47870,   0.00000, 0.00000, 0.00000);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{   //23 วินาที
	if (strcmp("/plane", cmdtext, true, 10) == 0)
	{
	    MoveDynamicObject(plane, 387.51291, 2503.57251, 21.29870, 20.0);
		SendClientMessage(playerid, -1, "Plane Moved");
		TogglePlayerSpectating(playerid, 1);
		InterpolateCameraPos(playerid, 54.4642, 2529.9653, 128.5643,  415.5514,2520.6848,16.4844, 20000, CAMERA_MOVE);
		InterpolateCameraLookAt(playerid, 417.8465, 2522.3130, 16.4844, 386.7877, 2507.1416,21.6357, 20000, CAMERA_MOVE);
		SetPlayerPos(playerid, 203.1984,2503.6367,16.4844);
		//TogglePlayerControllable(playerid, 0);
		return 1;
	}
	
	if(strcmp("/set", cmdtext, true, 10) == 0)
	{
	    TogglePlayerSpectating(playerid, 0);
	    TogglePlayerControllable(playerid, 1);
	    SetCameraBehindPlayer(playerid);
	    return 1;
	}
	return 0;
}


