#include	<YSI_Coding\y_hooks>


CMD:rejobs(playerid, params[])
{
	if(playerData[playerid][pAdmin] >= 6)
	{
        RespawnMines();
        RespawnWoods();
        RespawnApple();
	}
 	return 1;
}
task ReJobsTimer[10000*60]()
{
	RespawnMines();
	RespawnWoods();
	RespawnApple();
	return 1;
}