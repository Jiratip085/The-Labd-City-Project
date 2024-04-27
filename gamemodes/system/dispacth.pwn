#include	<YSI_Coding\y_hooks>

new FlagJoin[MAX_PLAYERS] = 0;

new PoliceCP[MAX_PLAYERS] = 0;
new MedicCP[MAX_PLAYERS] = 0;
new MechanicCP[MAX_PLAYERS] = 0;

hook OnPlayerConnect(playerid)
{
	FlagJoin[playerid] = 0;
    PoliceCP[playerid] = 0;
    MedicCP[playerid] = 0;
    MechanicCP[playerid] = 0;
	return 1;
}

