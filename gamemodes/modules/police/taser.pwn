
#include <YSI\y_hooks>

new GiveTaserAgainTimer[MAX_PLAYERS];
new GiveTaserAgainTimerEx[MAX_PLAYERS];
new lastWeapon[MAX_PLAYERS];
new PoliceLastWeapon[MAX_PLAYERS];
new PoliceLastAmmo[MAX_PLAYERS];
new bool:taser[MAX_PLAYERS];
new TaserTime[MAX_PLAYERS];
new TaserTimeAG[MAX_PLAYERS];
new IsPlayerTaser[MAX_PLAYERS];
new TaserShoot[MAX_PLAYERS];

#define TASER_WEAPON 		(23)
#define TASER_OBJECT        (347)
#define TASER_EFFECT_TIME	(10000)
#define TASER_USE_TIME		(5000)

forward OnPlayerChangeWeapon(playerid, newWeapon, oldWeapon);
public OnPlayerChangeWeapon(playerid, newWeapon, oldWeapon)
{
	if(IsPlayerAttachedObjectSlotUsed(playerid, 0) && taser[playerid])
		SetPlayerArmedWeapon(playerid, 0);

	return 1;
}

forward EndTaserEffect(playerid);
public EndTaserEffect(playerid)
{
    TogglePlayerControllable(playerid, 1);
	IsPlayerTaser[playerid] = 0;
	TaserTime[playerid] = 0;
	HidePlayerProgressBar(playerid, TASERBAR[playerid]);
	ClearAnimations(playerid);
	SetPlayerDrunkLevel(playerid, 0);
	return 1;
}

forward GiveTaserAgain(playerid);
public GiveTaserAgain(playerid)
{
	RemovePlayerAttachedObject(playerid, 0);
	GivePlayerWeapon(playerid, TASER_WEAPON, 1);
    GiveTaserAgainTimer[playerid] = 0;
    GiveTaserAgainTimerEx[playerid] = 0;
    TaserTimeAG[playerid] = 0;
    TaserShoot[playerid] = 0;
    HidePlayerProgressBar(playerid, TASERBARAG[playerid]);
    HidePlayerProgressBar(playerid, TASERBAR[playerid]);
    ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:taser(playerid, params[])
{
	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "[!] {FFFFFF}คุณไม่ใช่เจ้าหน้าที่ตำรวจ");

    new weapons, ammo, string[128];
    if(taser[playerid]) // Duty แล้ว , กำลังจะเก็บปืน
    {
        taser[playerid] = false;

        if(GiveTaserAgainTimer[playerid])
            KillTimer(GiveTaserAgainTimer[playerid]);

        if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
        {
            RemovePlayerAttachedObject(playerid, 0);
        }
        GetPlayerWeaponData(playerid, 2, weapons, ammo);
        GivePlayerWeapon(playerid, weapons, -ammo);

        GivePlayerWeapon(playerid, PoliceLastWeapon[playerid], PoliceLastAmmo[playerid]);
        SetPlayerArmedWeapon(playerid, 0);
        HidePlayerProgressBar(playerid, TASERBARAG[playerid]);
        ClearAnimations(playerid);

        format(string,sizeof(string), "%s ได้เก็บ Taser", ReturnName(playerid,0));
        SendNearbyMessage(playerid, 6.0, COLOR_RP, string);
    }
    else // ยังไม่ได้ duty , ยังไม่มีปืน
    {
        taser[playerid] = true;
        GetPlayerWeaponData(playerid, 2, PoliceLastWeapon[playerid], PoliceLastAmmo[playerid]);

        GetPlayerWeaponData(playerid, 2, weapons, ammo);
        GivePlayerWeapon(playerid, weapons, -ammo);

        GivePlayerWeapon(playerid, TASER_WEAPON, 1);

        format(string,sizeof(string), "%s ได้หยิบ Taser ออกมาจากซองปืน", ReturnName(playerid,0));
        SendNearbyMessage(playerid, 6.0, COLOR_RP, string);
    }
    return 1;
}