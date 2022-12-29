#include <YSI\y_hooks>

new EnterCheckPointJob[MAX_PLAYERS];

CMD:gps(playerid, const params[])
{
	Dialog_Show(playerid, GPS, DIALOG_STYLE_LIST, "[รายการ GPS]", "อาชีพ\nสถานที่ต่าง ๆ\nจุดขายของ", "เลือก", "ปิด");
	return 1;
}


CMD:cleargps(playerid, params[])
{
    EnterCheckPointJob[playerid] = 0;
    DisablePlayerCheckpoint(playerid);
    return 1;
}

/*GetClosestJob(playerid, type)
{
	new
	    Float:fDistance[2] = {99999.0, 0.0},
	    iIndex = -1
	;
	for (new i = 0; i < MAX_DYNAMIC_JOBS; i ++) if (JobData[i][jobExists] && JobData[i][jobType] == type && GetPlayerInterior(playerid) == JobData[i][jobInterior] && GetPlayerVirtualWorld(playerid) == JobData[i][jobWorld])
	{
		fDistance[1] = GetPlayerDistanceFromPoint(playerid, JobData[i][jobPos][0], JobData[i][jobPos][1], JobData[i][jobPos][2]);

		if (fDistance[1] < fDistance[0])
		{
		    fDistance[0] = fDistance[1];
		    iIndex = i;
		}
	}
	return iIndex;
}*/

/*Dialog:GPSMENU(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    if(response)
    {
        switch(listitem)
        {
            case 0:
            {
                Dialog_Show(playerid, GPSJOB, DIALOG_STYLE_LIST, "ค้นหางาน", "คนส่งของ\nช่างยนต์\nคนตัดไม้\nขนส่งผลไม้\nรีดนมวัว", "เลือก", "ยกเลิก");
            }
            case 1:
            {
                Dialog_Show(playerid, GPS, DIALOG_STYLE_LIST, "สถานที่", "Police Station\nMedical station\nMechanic Station", "เลือก", "ยกเลิก");
            }
        }
    }
    return 1;
}*/

/*Dialog:GPSJOB(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    if(response)
    {
        
		new id = GetClosestJob(playerid, listitem + 1);

		if (id != -1)
		{
		    new
				str[32];

		    format(str, 32, "%s", inputtext);

            EnterCheckPointJob[playerid] = 1;

		    SetPlayerCheckpoint(playerid, JobData[id][jobPos][0], JobData[id][jobPos][1], JobData[id][jobPos][2],3.0);
	        SendClientMessageEx(playerid, -1,"คุณได้เปิด GPS ไปยังงาน %s", str);
		}
		else
		{
			ErrorMsg(playerid, "GPS ไม่ถูกต้อง");
		}

        if(listitem == 0)
        {
            SetPlayerCheckpoint(playerid, JobData[0][jobPos][0], JobData[0][jobPos][1], JobData[0][jobPos][2], 3.0);
        }
        if(listitem == 1)
        {
            SetPlayerCheckpoint(playerid, JobData[1][jobPos][0], JobData[1][jobPos][1], JobData[1][jobPos][2], 3.0);
        }
        if(listitem == 2)
        {
            SetPlayerCheckpoint(playerid, JobData[2][jobPos][0], JobData[2][jobPos][1], JobData[2][jobPos][2], 3.0);
        }
        if(listitem == 3)
        {
            SetPlayerCheckpoint(playerid, JobData[3][jobPos][0], JobData[3][jobPos][1], JobData[3][jobPos][2], 3.0);
        }
        if(listitem == 4)
        {
            SetPlayerCheckpoint(playerid, JobData[4][jobPos][0], JobData[4][jobPos][1], JobData[4][jobPos][2], 3.0);
        }
    }
    return 1;
}*/
Dialog:GPS(playerid, response, listitem, inputtext[])
{

    //if(!response)
        //return 1;

	if (response)
	{
	
		switch(listitem)
		{
		    case 0:
		    {

				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
				{
				    if(gpsData[i][gpsType] == 1)
				    {
						format(string, sizeof(string), "%s\t{FFA84D}%.0f เมตร\n", gpsData[i][gpsName], GetPlayerDistanceFromPoint(playerid, gpsData[i][gpsPosX], gpsData[i][gpsPosY], gpsData[i][gpsPosZ]));
						strcat(string2, string);
						format(var, sizeof(var), "GPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					ErrorMsg(playerid, "GPS ไม่ถูกต้อง");
					return 1;
				}
				format(string, sizeof(string), "ชื่ออาชีพ\tระยะทาง\n%s", string2);
				Dialog_Show(playerid, DIALOG_GPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "[อาชีพ]", string, "เลือก", "ปิด");
			 }
		    case 1:
		    {
		
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
				{
				    if(gpsData[i][gpsType] == 2)
				    {
						format(string, sizeof(string), "%s\t{FFA84D}%.0f เมตร\n", gpsData[i][gpsName], GetPlayerDistanceFromPoint(playerid, gpsData[i][gpsPosX], gpsData[i][gpsPosY], gpsData[i][gpsPosZ]));
						strcat(string2, string);
						format(var, sizeof(var), "GPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					ErrorMsg(playerid, "GPS ไม่ถูกต้อง");
					return 1;
				}
				format(string, sizeof(string), "ชื่อสถานที่\tระยะทาง\n%s", string2);
				Dialog_Show(playerid, DIALOG_GPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "[สถานที่ต่าง ๆ]", string, "เลือก", "ปิด");
			 }
			 case 2:
		    {

				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
				{
				    if(gpsData[i][gpsType] == 3)
				    {
						format(string, sizeof(string), "%s\t{FFA84D}%.0f เมตร\n", gpsData[i][gpsName], GetPlayerDistanceFromPoint(playerid, gpsData[i][gpsPosX], gpsData[i][gpsPosY], gpsData[i][gpsPosZ]));
						strcat(string2, string);
						format(var, sizeof(var), "GPSID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					ErrorMsg(playerid, "GPS ไม่ถูกต้อง");
					return 1;
				}
				format(string, sizeof(string), "ชื่อจุดขายของ\tระยะทาง\n%s", string2);
				Dialog_Show(playerid, DIALOG_GPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "[จุดขายของ]", string, "เลือก", "ปิด");
			 }
		  }
		    

	}
	return 1;
}

