#define FILTERSCRIPT

#include <a_samp>
#include <YSI\y_timers>
#include <djson>
#undef MAX_PLAYERS

forward OnUpdateJSON();

#define FILE_JSON	"positions.json"
#define UPDATE_TIME	60000
#define MAX_PLAYERS	500

new Timer:gTimer,Name[MAX_PLAYERS][MAX_PLAYER_NAME];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("SA:MP Live Map");
	print("--------------------------------------\n");

	//gTimer = SetTimer("OnUpdateJSON", UPDATE_TIME, true);
    gTimer = repeat OnUpdateJSON[UPDATE_TIME]();

	djson_GameModeInit();
	return 1;
}

public OnFilterScriptExit()
{
	djson_GameModeExit();
	// KillTimer(gTimer);
    stop gTimer;
	return 1;
}

public OnPlayerConnect(playerid)
{
	GetPlayerName(playerid, Name[playerid], MAX_PLAYER_NAME);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	Name[playerid][0] = EOS;
	return 1;
}

//public OnUpdateJSON()
timer OnUpdateJSON[60000]()
{
	new Float:pos[3],string[16];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i))
		{
			format(string,sizeof(string),"%d/online",i);
			djSetInt(FILE_JSON,string,0);
		}
		else
		{
			GetPlayerPos(i, pos[0],pos[1],pos[2]);

			format(string,sizeof(string),"%d/x",i);
			djSetFloat(FILE_JSON,string,pos[0]);

			format(string,sizeof(string),"%d/y",i);
			djSetFloat(FILE_JSON,string,pos[1]);

			format(string,sizeof(string),"%d/name",i);
			djSet(FILE_JSON,string,Name[i]);

			format(string,sizeof(string),"%d/ping",i);
			djSetInt(FILE_JSON,string,GetPlayerPing(i));

			format(string,sizeof(string),"%d/online",i);
			djSetInt(FILE_JSON,string,1);
		}
	}
}
