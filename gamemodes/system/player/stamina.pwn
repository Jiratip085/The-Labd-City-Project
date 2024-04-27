#include 	<YSI_Coding\y_hooks>
#include    <stamina>

#define Pressed(%0)	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

hook OnPlayerConnect(playerid)
{
    SetPlayerMaxStamina(playerid, 200);
}

hook OnPlayerSpawn(playerid)
{
	SetPlayerStamina(playerid, GetPlayerMaxStamina(playerid));
}

ptask StaminaTimer[200](playerid)
{
    if (!playerData[playerid][IsLoggedIn])
		return 0;

    if (playerData[playerid][pInjured] > 0)
		return 1;

	// พลังงาน
	
	if (GetPlayerStamina(playerid) < 0)
		SetPlayerStamina(playerid, 2);

	if (IsPlayerRunning(playerid)) GivePlayerStamina(playerid, -1);

    else if(GetPlayerStamina(playerid) < GetPlayerMaxStamina(playerid))
		GivePlayerStamina(playerid, 1);

    return 1;
}

public OnPlayerStaminaOver(playerid)
{
	SetPlayerExhausted(playerid, true);
	//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* เกิดอาการเหนื่อยอย่างมากเนื่องจากพลังงานหมด (( %s ))", GetPlayerNameEx(playerid));
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		if (Pressed(KEY_JUMP) && !IsPlayerInAnyVehicle(playerid))
		{
			if (GetPlayerStamina(playerid) > 0)
			{
				GivePlayerStamina(playerid, -10);
				playerData[playerid][pThirsty] -= 0.03;
				ShowPlayerProgressBar(playerid, PlayerStamina[playerid][0]);
			}
			else
			{
				SetPlayerExhausted(playerid, true);
				//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* เกิดอาการเหนื่อยอย่างมากเนื่องจากพลังงานหมด (( %s ))", GetPlayerNameEx(playerid));
			}
		}
		else if (newkeys == KEY_SPRINT && !IsPlayerInAnyVehicle(playerid))
		{
			if (GetPlayerStamina(playerid) > 0)
			{
				GivePlayerStamina(playerid, -1);
				playerData[playerid][pThirsty] -= 0.01;
				ShowPlayerProgressBar(playerid, PlayerStamina[playerid][0]);
			}
			else
			{
				SetPlayerExhausted(playerid, true);
				//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* เกิดอาการเหนื่อยอย่างมากเนื่องจากพลังงานหมด (( %s ))", GetPlayerNameEx(playerid));
			}
		}
	}
	return 1;
}

