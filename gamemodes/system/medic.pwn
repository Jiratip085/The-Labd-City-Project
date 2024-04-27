#include <YSI_Coding\y_hooks>

#define     MAX_INJURED             (10)
enum INJURED_DATA {
	injuredID,
	injuredExists,
	injuredTarget
}
new injuredData[MAX_INJURED][INJURED_DATA];

new CPRPrice[MAX_PLAYERS] = 0;
new HEALPrice[MAX_PLAYERS] = 0;

new Siren[MAX_VEHICLES],
	SirenObject[MAX_VEHICLES];


CMD:medic(playerid, params[])
{
    if (GetFactionType(playerid) != FACTION_MEDIC)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

    Dialog_Show(playerid, DIALOG_MEDIC, DIALOG_STYLE_TABLIST_HEADERS, "เมนูสำหรับหน่วยงานแพทย์", "รายการ\tจำนวน\n{F6CE07}รายชื่อผู้ขอความช่วยเหลือ\n{F61D07}[+]{FFFFFF} ปฐมพยาบาล (CPR)\t$%d\n{F61D07}[+]{FFFFFF} ปั๊มหัวใจ (Heal)\t$%d", "เลือก", "ออก", CPRPrice[playerid], HEALPrice[playerid]);
	return 1;
}

/*Injured_Add(playerid)
{
	for(new i = 0; i != MAX_INJURED; ++ i)
	{
	    if (!injuredData[i][injuredExists])
	    {
		    injuredData[i][injuredID] = i;
		    injuredData[i][injuredExists] = true;
	        injuredData[i][injuredTarget] = playerid;

			foreach (new x : Player)
			{
				if (GetFactionType(x) == FACTION_MEDIC) {
					SendClientMessage(x, -1, "{F92747}(การร้องขอความช่วยเหลือ) | {FFFFFF}มีผู้เล่นต้องการความช่วยเหลือ /medic เพื่อตรวจสอบ {F92747}))");
				}
			}
			return i;
		}
	}
	return -1;
}*/

Injured_Remove(hitmanid)
{
	if (hitmanid != -1 && injuredData[hitmanid][injuredExists])
	{
	    injuredData[hitmanid][injuredExists] = false;

		injuredData[hitmanid][injuredID] = -1;
		injuredData[hitmanid][injuredTarget] = -1;
	}
	return 1;
}

/*Injured_Clear(playerid)
{
    for (new i = 0; i != MAX_INJURED; i ++)
	{
	    if (injuredData[i][injuredExists] && injuredData[i][injuredTarget] == playerid)
	    {
	        Injured_Remove(i);
		}
	}
	return 1;
}

Injured_GetCount(playerid)
{
	new count;

    for (new i = 0; i != MAX_INJURED; i ++)
	{
	    if (injuredData[i][injuredExists] && injuredData[i][injuredTarget] == playerid)
	    {
	        count++;
		}
	}
	return count;
}*/


Dialog:DIALOG_MEDIC_LIST(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new var[32];
	    format(var, sizeof(var), "GPSID%d", listitem);
	    new gpsid = GetPVarInt(playerid, var);

		new hitmanname = injuredData[gpsid][injuredTarget], Float:x, Float:y, Float:z;
		GetPlayerPos(injuredData[gpsid][injuredTarget], x, y, z);

		SetPlayerCheckpoint(playerid, x, y, z, 3.0);

		SendClientMessageEx(playerid, COLOR_LIGHTRED, "* ตำแหน่งของ %s ถูกแสดงขึ้นบนแผนที่แล้ว", GetPlayerNameEx(hitmanname));
		SendClientMessageEx(playerid, -1, "ระยะทางในการเดินทาง > %.0f km", GetPlayerDistanceFromPoint(playerid, x, y, z));

		SendClientMessageEx(injuredData[gpsid][injuredTarget], COLOR_RED, "หมอ %s รับทราบถึงการบาดเจ็บของคุณแล้ว และกำลังเดินทางมาหาคุณ!", GetPlayerNameEx(playerid));
        Injured_Remove(gpsid);
	}
	return 1;
}

Dialog:DIALOG_MEDIC(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
  		{
			case 0:
			{
				new
					string[1024],
					string2[1024],
	    			var[32], count;

				for (new i = 0; i != MAX_INJURED; i ++)
				{
				    if (!injuredData[i][injuredExists])
						continue;

					new hitmanname = injuredData[i][injuredTarget], Float:x, Float:y, Float:z;
					GetPlayerPos(injuredData[i][injuredTarget], x, y, z);

					format(string, sizeof(string), "{FFFFFF}%s\t{FFFFFF}%.0f km\n", GetPlayerNameEx(hitmanname), GetPlayerDistanceFromPoint(playerid, x, y, z));
			        strcat(string2, string);

					format(var, sizeof(var), "GPSID%d", count);
					SetPVarInt(playerid, var, i);
					count++;
				}

				format(string, sizeof(string), "ชื่อ\tระยะทาง\n%s", string2);
				Dialog_Show(playerid, DIALOG_MEDIC_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Medic", string, "เลือก", "กลับ");
			}
			case 1:
			{
				Dialog_Show(playerid, DIALOG_MEDIC_CPR, DIALOG_STYLE_INPUT, "Medic", "กรุณาระบุราคาที่คุณต้องการสำหรับการปฐมพยาบาล (CPR)\nปัจจุบันราคาการปฐมพยาบาลของคุณคือ : $%d", "เลือก", "กลับ", CPRPrice[playerid]);
			}
			case 2:
			{
				Dialog_Show(playerid, DIALOG_MEDIC_HEAL, DIALOG_STYLE_INPUT, "Medic", "กรุณาระบุราคาที่คุณต้องการสำหรับการปั๊มหัวใจ (Hea;)\nปัจจุบันราคาการปั๊มหัวใจของคุณคือ : $%d", "เลือก", "กลับ", HEALPrice[playerid]);
			}
		}
	}
	return 1;
}

Dialog:DIALOG_MEDIC_CPR(playerid, response, listitem, inputtext[])
{
	new cash= strval(inputtext);
	if(response)
	{
	    if (cash <= 0)
	        return SendClientMessage(playerid, COLOR_GREY, "* คุณต้องระบุจำนวนมากกว่า 0");

        CPRPrice[playerid] = cash;
        SendClientMessageEx(playerid, COLOR_YELLOW, "+ คุณได้ตั้งค่าการปฐมพยาบาล (CPR) เป็นจำนวนเงิน '$%d'", cash);
        return 1;
	}
	return 1;
}

Dialog:DIALOG_MEDIC_HEAL(playerid, response, listitem, inputtext[])
{
	new cash= strval(inputtext);
	if(response)
	{
	    if (cash <= 0)
	        return SendClientMessage(playerid, COLOR_GREY, "* คุณต้องระบุจำนวนมากกว่า 0");

        HEALPrice[playerid] = cash;
        SendClientMessageEx(playerid, COLOR_YELLOW, "+ คุณได้ตั้งค่าการปั๊มหัวใจ (Heal) เป็นจำนวนเงิน '$%d'", cash);
        return 1;
	}
	return 1;
}

///////////////// police /////////////////////
CMD:siren(playerid, params[])
{
	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

    new string[128], type;
    new VID = GetPlayerVehicleID(playerid);

    if(sscanf(params, "d", type))
    {
        SendClientMessage(playerid, COLOR_WHITE, "การใช้ : /siren [ชนิด]");
        SendClientMessage(playerid, COLOR_GREY, "ชนิด : 1 = ภายใน, 2 = หลังคา, 3 = ปิด");
        return 1;
    }
    switch(type)
    {
        case 1:
        {
            if(Siren[VID] == 1)
            {
                SendClientMessage(playerid, COLOR_GREY, "รถคันนี้แล้วมีไซเรนแล้ว!");
                return 1;
            }
			Siren[VID] = 1;
			SirenObject[VID] = CreateDynamicObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
			AttachDynamicObjectToVehicle(SirenObject[VID], VID, 0.0, 0.75, 0.275, 0.0, 0.1, 0.0);
			format(string, sizeof(string), "** %s ติดไซเรนไว้ที่ภายในด้านหน้ารถ", GetPlayerNameEx(playerid));
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, string);
			return 1;
        }
        case 2:
        {
            if(Siren[VID] == 1)
            {
                SendClientMessage(playerid, COLOR_GREY, "รถคันนี้แล้วมีไซเรนแล้ว!");
                return 1;
            }
            Siren[VID] = 1;
            SirenObject[VID] = CreateDynamicObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
            AttachDynamicObjectToVehicle(SirenObject[VID], VID, -0.43, 0.0, 0.785, 0.0, 0.1, 0.0);
            format(string, sizeof(string), "** %s ติดไซเรนไว้บนหลังคารถ", GetPlayerNameEx(playerid));
            SendNearbyMessage(playerid, 30.0,  COLOR_PURPLE, string);
            return 1;
        }
        case 3:
        {
            if(Siren[VID] == 0)
            {
                SendClientMessage(playerid, COLOR_GREY, "รถคันนี้ไม่มีไซเรน!");
                return 1;
            }
            Siren[VID] = 0;
            DestroyDynamicObject(SirenObject[VID]);
            format(string, sizeof(string), "** %s ถอดไซเรนออกจากรถ", GetPlayerNameEx(playerid));
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, string);
            return 1;
        }
        default:
        {
            SendClientMessage(playerid, COLOR_WHITE, "ประเภทสิทธิการใช้งานไม่ถูกต้อง! /siren [ชนิด]");
            SendClientMessage(playerid, COLOR_GREY, "ชนิด : 1 = หลังคา , 2 = ในรถ , 3 = ปิด");
        }
    }
    return 1;
}
