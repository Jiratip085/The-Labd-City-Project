#include <YSI\y_hooks>

#define DEFAULT_RESPAWN_TIME        600 /* ten minutes */
#if !defined IGNORE_VEHICLE_DELETION
        new
            bool:gDialogCreated[ MAX_VEHICLES ] = { false, ... };
#endif

enum vehicleGang
{
	Exist,
	Float:bPosX,
	Float:bPosY,
	Float:bPosZ,
	bLeader,
	bPickup,
	Text3D:bMessage,
	bSlot[10],
	bColor1[10],
	bColor2[10],
}
new VehicleGang[100][vehicleGang];

new FactionGang[MAX_PLAYERS] = -1;

VehicleGang_Nearest(playerid)
{
    for (new i = 0; i != 100; i ++) if (VehicleGang[i][Exist] && IsPlayerInRangeOfPoint(playerid, 10.0, VehicleGang[i][bPosX], VehicleGang[i][bPosY], VehicleGang[i][bPosZ]))
	{
		return i;
	}
	return -1;
}

VehicleGang_Refresh(type)
{
	new message[512];

	DestroyDynamicPickup(VehicleGang[type][bPickup]);
	DestroyDynamic3DTextLabel(VehicleGang[type][bMessage]);

	VehicleGang[type][bPickup] = CreateDynamicPickup(19134, 1, VehicleGang[type][bPosX],VehicleGang[type][bPosY],VehicleGang[type][bPosZ]);

	new idgang = VehicleGang[type][bLeader];

	format(message, sizeof(message), "{FFFFFF}[{ED1AAA}เบิกรถแก๊ง{FFFFFF}]\nแก๊ง : {C30E89}%s\n{FFFFFF}พิมพ์ /เบิกรถแก๊ง เพื่อเบิกรถ", factionData[idgang][factionName]);
	VehicleGang[type][bMessage] = CreateDynamic3DTextLabel(message, COLOR_YELLOW, VehicleGang[type][bPosX],VehicleGang[type][bPosY],VehicleGang[type][bPosZ], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);

	return 1;
}

// คำสั่ง
CMD:vganghelp(playerid, params[])
{
	if (playerData[playerid][pAdmin] < 1)
	    return 1;

	return SendClientMessage(playerid, COLOR_GREY, "[DYNAMIC เบิกรถแก๊ง] : /checkvgang, /editvgang, /createvgang, /removevgang, /setveh_gang");
}

CMD:checkvgang(playerid, params[])
{
	if (playerData[playerid][pAdmin] < 1)
	    return 1;

	new
	    id = -1;

    if ((id = VehicleGang_Nearest(playerid)) != -1)
	    SendClientMessageEx(playerid, COLOR_YELLOW, "คุณกำลังยืนอยู่ใกล้จุดเบิกรถแก๊งไอดี: %d", id);

	return 1;
}

CMD:editvgang(playerid, params[])
{
	if (playerData[playerid][pAdmin] < 1)
	    return 1;

	new type, id, string[256];

 	if (sscanf(params, "dd", type, id))
		return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /editvgang [ไอดีจุดเบิกรถแก๊ง] [ไอดีแก๊งใหม่]");

	if (id < 0 || id > 100)
		return SendClientMessage(playerid, COLOR_GREY, "แก๊งควรอยู่ระหว่าง 0-100");

	VehicleGang[type][bLeader] = id;
    VehicleGang_Refresh(type);

    new idgang = VehicleGang[type][bLeader];

	format(string, sizeof(string), "** คุณได้แก้ไขเจ้าของจุดเบิกรถแก๊งไอดี : %d เป็นของแก๊ง %s เรียบร้อยแล้ว", type, factionData[idgang][factionName]);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);

	return 1;
}

alias:getvehicle_gang("เบิกรถแก๊ง")
CMD:getvehicle_gang(playerid, params[])
{
	new id = playerData[playerid][pFaction];

	for(new i = 0; i < 100; i++)
	{
		if (IsPlayerInRangeOfPoint(playerid, 2, VehicleGang[i][bPosX], VehicleGang[i][bPosY], VehicleGang[i][bPosZ]))
		{
			if(id == VehicleGang[i][bLeader])
			{
			    // --> ตั้งค่ารถ

				new Message1[512];
				new Message2[512];
				new Message3[512];
				new Message4[512];
				new Message5[512];
				new Message6[512];
				new Message7[512];
				new Message8[512];
				new Message9[512];
				new Message10[512];

				if (VehicleGang[i][bSlot][0] == 0) format(Message1, sizeof(Message1), "{FFFFFF}[{F75943}รอการตั้งค่า{FFFFFF}]");
				else format(Message1, sizeof(Message1), "{FFFFFF}[{4EF743}%s{FFFFFF}]", ReturnVehicleModelName(VehicleGang[i][bSlot][0]));

				if (VehicleGang[i][bSlot][1] == 0) format(Message2, sizeof(Message2), "{FFFFFF}[{F75943}รอการตั้งค่า{FFFFFF}]");
				else format(Message2, sizeof(Message2), "{FFFFFF}[{4EF743}%s{FFFFFF}]", ReturnVehicleModelName(VehicleGang[i][bSlot][1]));

				if (VehicleGang[i][bSlot][2] == 0) format(Message3, sizeof(Message3), "{FFFFFF}[{F75943}รอการตั้งค่า{FFFFFF}]");
				else format(Message3, sizeof(Message3), "{FFFFFF}[{4EF743}%s{FFFFFF}]", ReturnVehicleModelName(VehicleGang[i][bSlot][2]));

				if (VehicleGang[i][bSlot][3] == 0) format(Message4, sizeof(Message4), "{FFFFFF}[{F75943}รอการตั้งค่า{FFFFFF}]");
				else format(Message4, sizeof(Message4), "{FFFFFF}[{4EF743}%s{FFFFFF}]", ReturnVehicleModelName(VehicleGang[i][bSlot][3]));

				if (VehicleGang[i][bSlot][4] == 0) format(Message5, sizeof(Message5), "{FFFFFF}[{F75943}รอการตั้งค่า{FFFFFF}]");
				else format(Message5, sizeof(Message5), "{FFFFFF}[{4EF743}%s{FFFFFF}]", ReturnVehicleModelName(VehicleGang[i][bSlot][4]));

				if (VehicleGang[i][bSlot][5] == 0) format(Message6, sizeof(Message6), "{FFFFFF}[{F75943}รอการตั้งค่า{FFFFFF}]");
				else format(Message6, sizeof(Message6), "{FFFFFF}[{4EF743}%s{FFFFFF}]", ReturnVehicleModelName(VehicleGang[i][bSlot][5]));

				if (VehicleGang[i][bSlot][6] == 0) format(Message7, sizeof(Message7), "{FFFFFF}[{F75943}รอการตั้งค่า{FFFFFF}]");
				else format(Message7, sizeof(Message7), "{FFFFFF}[{4EF743}%s{FFFFFF}]", ReturnVehicleModelName(VehicleGang[i][bSlot][6]));

				if (VehicleGang[i][bSlot][7] == 0) format(Message8, sizeof(Message8), "{FFFFFF}[{F75943}รอการตั้งค่า{FFFFFF}]");
				else format(Message8, sizeof(Message8), "{FFFFFF}[{4EF743}%s{FFFFFF}]", ReturnVehicleModelName(VehicleGang[i][bSlot][7]));

				if (VehicleGang[i][bSlot][8] == 0) format(Message9, sizeof(Message9), "{FFFFFF}[{F75943}รอการตั้งค่า{FFFFFF}]");
				else format(Message9, sizeof(Message9), "{FFFFFF}[{4EF743}%s{FFFFFF}]", ReturnVehicleModelName(VehicleGang[i][bSlot][8]));

				if (VehicleGang[i][bSlot][9] == 0) format(Message10, sizeof(Message10), "{FFFFFF}[{F75943}รอการตั้งค่า{FFFFFF}]");
				else format(Message10, sizeof(Message10), "{FFFFFF}[{4EF743}%s{FFFFFF}]", ReturnVehicleModelName(VehicleGang[i][bSlot][9]));

				// --> เรียกรถ

				new carstr[1024];
				new szDialog[1024];

                FactionGang[playerid] = i;

				format(carstr, sizeof(carstr), "{4EF743}Slot\t{FFFFFF}ยานพาหนะ\n");
				strcat(szDialog,carstr);

				format(carstr, sizeof(carstr), "{11AC07}Slot 1\t%s\n{11AC07}Slot 2\t%s\n{11AC07}Slot 3\t%s\n{11AC07}Slot 4\t%s\n{11AC07}Slot 5\t%s\n{11AC07}Slot 6\t%s\n{11AC07}Slot 7\t%s\n{11AC07}Slot 8\t%s\n{11AC07}Slot 9\t%s\n{11AC07}Slot 10\t%s", Message1, Message2, Message3, Message4, Message5, Message6, Message7, Message8, Message9, Message10);
			    strcat(szDialog, carstr);

				Dialog_Show(playerid, CallCarGang, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}[{11AC07}เบิกรถแก๊ง Faction{FFFFFF}]", szDialog, "ตกลง", "ยกเลิก");
				return 1;
			}
		}
	}
	return 1;
}

CMD:setveh_gang(playerid, params[])
{
	if (playerData[playerid][pAdmin] < 1)
	    return 1;

	new type, id, vehicleid, color1, color2;

 	if (sscanf(params, "ddd", type, id))
		return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /setveh_gang [ไอดีจุดเบิกรถแก๊ง] [ช่อง Slot *1-10]");

	if (id < 0 || id > 100)
		return SendClientMessage(playerid, COLOR_GREY, "แก๊งควรอยู่ระหว่าง 0-100");

	switch (id)
	{
		case 1:
		{
		 	if (sscanf(params, "ddddd", type, id, vehicleid, color1, color2))
				return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /setveh_gang [ไอดีจุดเบิกรถแก๊ง] [ช่อง Slot *1-10] [ไอดีรุ่นยานพาหนะ] [สี1] [สี2]");

            VehicleGang[type][bSlot][0] = vehicleid;
            VehicleGang[type][bColor1][0] = color1;
            VehicleGang[type][bColor2][0] = color2;

            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* คุณได้ตั้งค่า Slot ที่ 1 เป็นรุ่นยานพาหนะไอดี : %d", vehicleid);
            Save_VehicleGang(type);

			return 1;
		}
		case 2:
		{
		 	if (sscanf(params, "ddddd", type, id, vehicleid, color1, color2))
				return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /setveh_gang [ไอดีจุดเบิกรถแก๊ง] [ช่อง Slot *1-10] [ไอดีรุ่นยานพาหนะ] [สี1] [สี2]");

            VehicleGang[type][bSlot][1] = vehicleid;
            VehicleGang[type][bColor1][1] = color1;
            VehicleGang[type][bColor2][1] = color2;

            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* คุณได้ตั้งค่า Slot ที่ 2 เป็นรุ่นยานพาหนะไอดี : %d", vehicleid);
            Save_VehicleGang(type);

			return 1;
		}
		case 3:
		{
		 	if (sscanf(params, "ddddd", type, id, vehicleid, color1, color2))
				return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /setveh_gang [ไอดีจุดเบิกรถแก๊ง] [ช่อง Slot *1-10] [ไอดีรุ่นยานพาหนะ] [สี1] [สี2]");

            VehicleGang[type][bSlot][2] = vehicleid;
            VehicleGang[type][bColor1][2] = color1;
            VehicleGang[type][bColor2][2] = color2;

            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* คุณได้ตั้งค่า Slot ที่ 3 เป็นรุ่นยานพาหนะไอดี : %d", vehicleid);
            Save_VehicleGang(type);

			return 1;
		}
		case 4:
		{
		 	if (sscanf(params, "ddddd", type, id, vehicleid, color1, color2))
				return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /setveh_gang [ไอดีจุดเบิกรถแก๊ง] [ช่อง Slot *1-10] [ไอดีรุ่นยานพาหนะ] [สี1] [สี2]");

            VehicleGang[type][bSlot][3] = vehicleid;
            VehicleGang[type][bColor1][3] = color1;
            VehicleGang[type][bColor2][3] = color2;

            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* คุณได้ตั้งค่า Slot ที่ 4 เป็นรุ่นยานพาหนะไอดี : %d", vehicleid);
            Save_VehicleGang(type);

			return 1;
		}
		case 5:
		{
		 	if (sscanf(params, "ddddd", type, id, vehicleid, color1, color2))
				return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /setveh_gang [ไอดีจุดเบิกรถแก๊ง] [ช่อง Slot *1-10] [ไอดีรุ่นยานพาหนะ] [สี1] [สี2]");

            VehicleGang[type][bSlot][4] = vehicleid;
            VehicleGang[type][bColor1][4] = color1;
            VehicleGang[type][bColor2][4] = color2;

            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* คุณได้ตั้งค่า Slot ที่ 5 เป็นรุ่นยานพาหนะไอดี : %d", vehicleid);
            Save_VehicleGang(type);

			return 1;
		}
		case 6:
		{
		 	if (sscanf(params, "ddddd", type, id, vehicleid, color1, color2))
				return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /setveh_gang [ไอดีจุดเบิกรถแก๊ง] [ช่อง Slot *1-10] [ไอดีรุ่นยานพาหนะ] [สี1] [สี2]");

            VehicleGang[type][bSlot][5] = vehicleid;
            VehicleGang[type][bColor1][5] = color1;
            VehicleGang[type][bColor2][5] = color2;

            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* คุณได้ตั้งค่า Slot ที่ 6 เป็นรุ่นยานพาหนะไอดี : %d", vehicleid);
            Save_VehicleGang(type);

			return 1;
		}
		case 7:
		{
		 	if (sscanf(params, "ddddd", type, id, vehicleid, color1, color2))
				return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /setveh_gang [ไอดีจุดเบิกรถแก๊ง] [ช่อง Slot *1-10] [ไอดีรุ่นยานพาหนะ] [สี1] [สี2]");

            VehicleGang[type][bSlot][6] = vehicleid;
            VehicleGang[type][bColor1][6] = color1;
            VehicleGang[type][bColor2][6] = color2;

            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* คุณได้ตั้งค่า Slot ที่ 7 เป็นรุ่นยานพาหนะไอดี : %d", vehicleid);
            Save_VehicleGang(type);

			return 1;
		}
		case 8:
		{
		 	if (sscanf(params, "ddddd", type, id, vehicleid, color1, color2))
				return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /setveh_gang [ไอดีจุดเบิกรถแก๊ง] [ช่อง Slot *1-10] [ไอดีรุ่นยานพาหนะ] [สี1] [สี2]");

            VehicleGang[type][bSlot][7] = vehicleid;
            VehicleGang[type][bColor1][7] = color1;
            VehicleGang[type][bColor2][7] = color2;

            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* คุณได้ตั้งค่า Slot ที่ 8 เป็นรุ่นยานพาหนะไอดี : %d", vehicleid);
            Save_VehicleGang(type);

			return 1;
		}
		case 9:
		{
		 	if (sscanf(params, "ddddd", type, id, vehicleid, color1, color2))
				return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /setveh_gang [ไอดีจุดเบิกรถแก๊ง] [ช่อง Slot *1-10] [ไอดีรุ่นยานพาหนะ] [สี1] [สี2]");

            VehicleGang[type][bSlot][8] = vehicleid;
            VehicleGang[type][bColor1][8] = color1;
            VehicleGang[type][bColor2][8] = color2;

            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* คุณได้ตั้งค่า Slot ที่ 9 เป็นรุ่นยานพาหนะไอดี : %d", vehicleid);
            Save_VehicleGang(type);

			return 1;
		}
		case 10:
		{
		 	if (sscanf(params, "ddddd", type, id, vehicleid, color1, color2))
				return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /setveh_gang [ไอดีจุดเบิกรถแก๊ง] [ช่อง Slot *1-10] [ไอดีรุ่นยานพาหนะ] [สี1] [สี2]");

            VehicleGang[type][bSlot][9] = vehicleid;
            VehicleGang[type][bColor1][9] = color1;
            VehicleGang[type][bColor2][9] = color2;
            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* คุณได้ตั้งค่า Slot ที่ 10 เป็นรุ่นยานพาหนะไอดี : %d", vehicleid);
            Save_VehicleGang(type);

			return 1;
		}

	}
	return 1;
}

CMD:createvgang(playerid, params[])
{
	new e1, string[256];

	if (playerData[playerid][pAdmin] < 1)
	    return 1;

 	if (sscanf(params, "d", e1))
		return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /createvgang [ไอดีกลุ่ม]");

	if (e1 < 0 || e1 > 100)
		return SendClientMessage(playerid, COLOR_GREY, "แก๊งควรอยู่ระหว่าง 0-100");

	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(playerid, X,Y,Z);

   	for(new i = 0; i < 100; i++)
	{
		if(!VehicleGang[i][Exist])
		{
			VehicleGang[i][Exist] = true;
			VehicleGang[i][bPosX] = X;
			VehicleGang[i][bPosY] = Y;
			VehicleGang[i][bPosZ] = Z;
			VehicleGang[i][bLeader] = e1;

			VehicleGang[i][bPickup] = CreateDynamicPickup(1098, 1, X,Y,Z);

            new idgang = VehicleGang[i][bLeader];

			/*new idgang = VehicleGang[i][bLeader];

			format(message, sizeof(message), "{FFFFFF}[{F60CA1}คลังอาวุธแก๊ง{FFFFFF}]\nเจ้าของคลังอาวุธ : กลุ่ม {EDDD1A}%s\n{FFFFFF}กด {EDDD1A}N {FFFFFF}เพื่อหยิบอาวุธ", factionData[idgang][factionName]);
			WeaponGang[i][bMessage] = CreateDynamic3DTextLabel(message, COLOR_YELLOW, WeaponGang[i][bPosX],WeaponGang[i][bPosY],WeaponGang[i][bPosZ], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
			*/

    		VehicleGang_Refresh(i);

			format(string, sizeof(string), "** คุณได้สร้างจุดเบิกรถแก๊งของ : %s เรียบร้อยแล้ว", factionData[idgang][factionName]);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);

			new query[512];

			mysql_format(g_SQL, query, sizeof(query), "INSERT INTO  vehiclegang SET ID=%d, bPosX='%f',bPosY='%f',bPosZ='%f',Leader='%d'",i,X,Y,Z, idgang);
			mysql_tquery(g_SQL, query);

			return 1;
		}
	}

	return 1;
}

CreatePlayerVehicle2( playerid, modelid, color1, color2 )
{
        new
            vehicle,
                Float:x,
                Float:y,
                Float:z,
                Float:angle;

		if ( CallVehicleGang[playerid] != -1 )
		{
		    DestroyVehicle(CallVehicleGang[playerid]);
		    CallVehicleGang[playerid] = -1;
		}

        if ( GetPlayerState( playerid ) == PLAYER_STATE_DRIVER )
        {
            vehicle = GetPlayerVehicleID( playerid );
            GetVehiclePos( vehicle, x, y, z );
            GetVehicleZAngle( vehicle, angle );
            DestroyVehicle( vehicle );
        }
        else
        {
                GetPlayerPos( playerid, x, y, z );
                GetPlayerFacingAngle( playerid, angle );
        }
        vehicle = CreateVehicle( modelid, x, y, ( z + 1 ), angle, color1, color2, DEFAULT_RESPAWN_TIME );
        vehicleFuel[vehicle] = 100.0;
        CallVehicleGang[playerid] = vehicle;
        LinkVehicleToInterior( vehicle, GetPlayerInterior( playerid ) );

		vehicleCall[vehicle] = 1;

        #if !defined IGNORE_VIRTUAL_WORLDS
                SetVehicleVirtualWorld( vehicle, GetPlayerVirtualWorld( playerid ) );
        #endif
        #if !defined IGNORE_WARP_INTO_VEHICLE
                PutPlayerInVehicle( playerid, vehicle, 0 );
        #endif
        #if !defined IGNORE_VEHICLE_DELETION
                gDialogCreated[ vehicle ] = true;
        #endif
        return 1;
}

CMD:removevgang(playerid, params[])
{
	new type, string[256];

	if (playerData[playerid][pAdmin] < 1)
	    return 1;

 	if (sscanf(params, "d", type))
		return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /removevgang [ไอดีจุดเบิกรถแก๊ง]");

	if (type < 0 || type > 100)
		return SendClientMessage(playerid, COLOR_GREY, "แก๊งควรอยู่ระหว่าง 0-100");

	if (!VehicleGang[type][Exist])
	    return SendClientMessage(playerid, COLOR_GREY, "ไอดีจุดเบิกรถแก๊งที่คุณจะลบ ! ยังไม่ถูกสร้างขึ้นเลย !");

	DestroyDynamicPickup(VehicleGang[type][bPickup]);
	DestroyDynamic3DTextLabel(VehicleGang[type][bMessage]);

	new query[64];

	VehicleGang[type][bPosX] = 0.0;
	VehicleGang[type][bPosY] = 0.0;
	VehicleGang[type][bPosZ] = 0.0;
	VehicleGang[type][bLeader] = -1;

	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehiclegang WHERE ID = %d", type);
	mysql_tquery(g_SQL, query, "", "");

	VehicleGang[type][Exist] = false;

	format(string, sizeof(string), "** คุณได้ลบจุดเบิกรถแก๊งไอดี : %d ออกจากระบบฐานข้อมูลแล้ว",type);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);

	return 1;
}

forward Save_VehicleGang(id);
public Save_VehicleGang(id)
{
	new query[2048];
   	format(query,sizeof(query),"UPDATE `vehiclegang` SET");
   	format(query,sizeof(query),"%s bPosX ='%f',",query,VehicleGang[id][bPosX]);
   	format(query,sizeof(query),"%s bPosY ='%f',",query,VehicleGang[id][bPosY]);
   	format(query,sizeof(query),"%s bPosZ ='%f',",query,VehicleGang[id][bPosZ]);
   	format(query,sizeof(query),"%s Leader ='%d',",query,VehicleGang[id][bLeader]);

   	format(query,sizeof(query),"%s Slot1 ='%d',",query,VehicleGang[id][bSlot][0]);
   	format(query,sizeof(query),"%s Slot2 ='%d',",query,VehicleGang[id][bSlot][1]);
   	format(query,sizeof(query),"%s Slot3 ='%d',",query,VehicleGang[id][bSlot][2]);
   	format(query,sizeof(query),"%s Slot4 ='%d',",query,VehicleGang[id][bSlot][3]);
   	format(query,sizeof(query),"%s Slot5 ='%d',",query,VehicleGang[id][bSlot][4]);
   	format(query,sizeof(query),"%s Slot6 ='%d',",query,VehicleGang[id][bSlot][5]);
   	format(query,sizeof(query),"%s Slot7 ='%d',",query,VehicleGang[id][bSlot][6]);
   	format(query,sizeof(query),"%s Slot8 ='%d',",query,VehicleGang[id][bSlot][7]);
   	format(query,sizeof(query),"%s Slot9 ='%d',",query,VehicleGang[id][bSlot][8]);
   	format(query,sizeof(query),"%s Slot10 ='%d',",query,VehicleGang[id][bSlot][9]);

   	format(query,sizeof(query),"%s Color11 ='%d',",query,VehicleGang[id][bColor1][0]);
   	format(query,sizeof(query),"%s Color12 ='%d',",query,VehicleGang[id][bColor1][1]);
   	format(query,sizeof(query),"%s Color13 ='%d',",query,VehicleGang[id][bColor1][2]);
   	format(query,sizeof(query),"%s Color14 ='%d',",query,VehicleGang[id][bColor1][3]);
   	format(query,sizeof(query),"%s Color15 ='%d',",query,VehicleGang[id][bColor1][4]);
   	format(query,sizeof(query),"%s Color16 ='%d',",query,VehicleGang[id][bColor1][5]);
   	format(query,sizeof(query),"%s Color17 ='%d',",query,VehicleGang[id][bColor1][6]);
   	format(query,sizeof(query),"%s Color18 ='%d',",query,VehicleGang[id][bColor1][7]);
   	format(query,sizeof(query),"%s Color19 ='%d',",query,VehicleGang[id][bColor1][8]);
   	format(query,sizeof(query),"%s Color110 ='%d',",query,VehicleGang[id][bColor1][9]);

   	format(query,sizeof(query),"%s Color21 ='%d',",query,VehicleGang[id][bColor2][0]);
   	format(query,sizeof(query),"%s Color22 ='%d',",query,VehicleGang[id][bColor2][1]);
   	format(query,sizeof(query),"%s Color23 ='%d',",query,VehicleGang[id][bColor2][2]);
   	format(query,sizeof(query),"%s Color24 ='%d',",query,VehicleGang[id][bColor2][3]);
   	format(query,sizeof(query),"%s Color25 ='%d',",query,VehicleGang[id][bColor2][4]);
   	format(query,sizeof(query),"%s Color26 ='%d',",query,VehicleGang[id][bColor2][5]);
   	format(query,sizeof(query),"%s Color27 ='%d',",query,VehicleGang[id][bColor2][6]);
   	format(query,sizeof(query),"%s Color28 ='%d',",query,VehicleGang[id][bColor2][7]);
   	format(query,sizeof(query),"%s Color29 ='%d',",query,VehicleGang[id][bColor2][8]);
   	format(query,sizeof(query),"%s Color210 ='%d'",query,VehicleGang[id][bColor2][9]);

	format(query,sizeof(query),"%s WHERE `ID` ='%d'",query,id);
	mysql_tquery(g_SQL,query,"","");
}

/*ReturnVehicleModelName(model)
{
	new
	    name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}*/

forward Load_VehicleGang();
public Load_VehicleGang()
{
    new rows = cache_num_rows();
	new id, loaded;
 	if(rows)
  	{
		while(loaded < rows)
		{
		    cache_get_value_name_int(loaded,"ID", id);
		    cache_get_value_name_float(loaded,"bPosX",VehicleGang[id][bPosX]);
		    cache_get_value_name_float(loaded,"bPosY",VehicleGang[id][bPosY]);
		    cache_get_value_name_float(loaded,"bPosZ",VehicleGang[id][bPosZ]);
		    cache_get_value_name_int(loaded,"Leader",VehicleGang[id][bLeader]);

		    cache_get_value_name_int(loaded,"Slot1",VehicleGang[id][bSlot][0]);
		    cache_get_value_name_int(loaded,"Slot2",VehicleGang[id][bSlot][1]);
		    cache_get_value_name_int(loaded,"Slot3",VehicleGang[id][bSlot][2]);
		    cache_get_value_name_int(loaded,"Slot4",VehicleGang[id][bSlot][3]);
		    cache_get_value_name_int(loaded,"Slot5",VehicleGang[id][bSlot][4]);
		    cache_get_value_name_int(loaded,"Slot6",VehicleGang[id][bSlot][5]);
		    cache_get_value_name_int(loaded,"Slot7",VehicleGang[id][bSlot][6]);
		    cache_get_value_name_int(loaded,"Slot8",VehicleGang[id][bSlot][7]);
		    cache_get_value_name_int(loaded,"Slot9",VehicleGang[id][bSlot][8]);
		    cache_get_value_name_int(loaded,"Slot10",VehicleGang[id][bSlot][9]);

		    cache_get_value_name_int(loaded,"Color11",VehicleGang[id][bColor1][0]);
		    cache_get_value_name_int(loaded,"Color12",VehicleGang[id][bColor1][1]);
		    cache_get_value_name_int(loaded,"Color13",VehicleGang[id][bColor1][2]);
		    cache_get_value_name_int(loaded,"Color14",VehicleGang[id][bColor1][3]);
		    cache_get_value_name_int(loaded,"Color15",VehicleGang[id][bColor1][4]);
		    cache_get_value_name_int(loaded,"Color16",VehicleGang[id][bColor1][5]);
		    cache_get_value_name_int(loaded,"Color17",VehicleGang[id][bColor1][6]);
		    cache_get_value_name_int(loaded,"Color18",VehicleGang[id][bColor1][7]);
		    cache_get_value_name_int(loaded,"Color19",VehicleGang[id][bColor1][8]);
		    cache_get_value_name_int(loaded,"Color110",VehicleGang[id][bColor1][9]);

		    cache_get_value_name_int(loaded,"Color21",VehicleGang[id][bColor2][0]);
		    cache_get_value_name_int(loaded,"Color22",VehicleGang[id][bColor2][1]);
		    cache_get_value_name_int(loaded,"Color23",VehicleGang[id][bColor2][2]);
		    cache_get_value_name_int(loaded,"Color24",VehicleGang[id][bColor2][3]);
		    cache_get_value_name_int(loaded,"Color25",VehicleGang[id][bColor2][4]);
		    cache_get_value_name_int(loaded,"Color26",VehicleGang[id][bColor2][5]);
		    cache_get_value_name_int(loaded,"Color27",VehicleGang[id][bColor2][6]);
		    cache_get_value_name_int(loaded,"Color28",VehicleGang[id][bColor2][7]);
		    cache_get_value_name_int(loaded,"Color29",VehicleGang[id][bColor2][8]);
		    cache_get_value_name_int(loaded,"Color210",VehicleGang[id][bColor2][9]);

			VehicleGang[id][bPickup] = CreateDynamicPickup(1098, 1, VehicleGang[id][bPosX],VehicleGang[id][bPosY],VehicleGang[id][bPosZ]);

			/*new e1 = WeaponGang[id][bLeader];

			format(message, sizeof(message), "{FFFFFF}[{F60CA1}คลังอาวุธแก๊ง{FFFFFF}]\nเจ้าของคลังอาวุธ : กลุ่ม {EDDD1A}%s\n{FFFFFF}กด {EDDD1A}N {FFFFFF}เพื่อหยิบอาวุธ", factionData[e1][factionName]);
			WeaponGang[id][bMessage] = CreateDynamic3DTextLabel(message, COLOR_YELLOW, WeaponGang[id][bPosX],WeaponGang[id][bPosY],WeaponGang[id][bPosZ], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
			*/

    		VehicleGang_Refresh(id);

		    if(!VehicleGang[id][Exist])
		    {
		        VehicleGang[id][Exist] = true;
		    }
		    loaded ++;
		}

	}
	printf("Load_Vehicle_Gang %d", loaded);
}

// --> เรียกรถแก๊ง
Dialog:CallCarGang(playerid, response, listitem, inputtext[])
{
	new id = FactionGang[playerid];

	if (response)
	{
		switch(listitem)
		{
			case 0:
			{
				if (VehicleGang[id][bSlot][0] == 0)
				    return SendClientMessage(playerid, COLOR_LIGHTRED, "กรุณาติดต่อผู้ดูแลระบบ, เพื่อตั้งค่ารถแก๊ง");

				new Float:x, Float:y, Float:z, Float:a; // defines variables which we will use
				GetPlayerPos(playerid, x, y, z);
				GetPlayerFacingAngle(playerid, a);

				CreatePlayerVehicle2(playerid, VehicleGang[id][bSlot][0], VehicleGang[id][bColor1][0], VehicleGang[id][bColor2][0]);
				playerData[playerid][pCarVehI] = 1;
				FactionGang[playerid] = -1;

				SendClientMessage(playerid, COLOR_LIGHTBLUE, "* คุณได้เรียกรถออกมาจากจุดเบิกรถแก๊งของคุณแล้ว !");
				return 1;
			}
			case 1:
			{
				if (VehicleGang[id][bSlot][1] == 0)
				    return SendClientMessage(playerid, COLOR_LIGHTRED, "กรุณาติดต่อผู้ดูแลระบบ, เพื่อตั้งค่ารถแก๊ง");

				new Float:x, Float:y, Float:z, Float:a; // defines variables which we will use
				GetPlayerPos(playerid, x, y, z);
				GetPlayerFacingAngle(playerid, a);

				CreatePlayerVehicle2(playerid, VehicleGang[id][bSlot][1], VehicleGang[id][bColor1][1], VehicleGang[id][bColor2][1]);
				playerData[playerid][pCarVehI] = 1;
				FactionGang[playerid] = -1;

				SendClientMessage(playerid, COLOR_LIGHTBLUE, "* คุณได้เรียกรถออกมาจากจุดเบิกรถแก๊งของคุณแล้ว !");
				return 1;
			}
			case 2:
			{
				if (VehicleGang[id][bSlot][2] == 0)
				    return SendClientMessage(playerid, COLOR_LIGHTRED, "กรุณาติดต่อผู้ดูแลระบบ, เพื่อตั้งค่ารถแก๊ง");

				new Float:x, Float:y, Float:z, Float:a; // defines variables which we will use
				GetPlayerPos(playerid, x, y, z);
				GetPlayerFacingAngle(playerid, a);

				CreatePlayerVehicle2(playerid, VehicleGang[id][bSlot][2], VehicleGang[id][bColor1][2], VehicleGang[id][bColor2][2]);
				playerData[playerid][pCarVehI] = 1;
				FactionGang[playerid] = -1;

				SendClientMessage(playerid, COLOR_LIGHTBLUE, "* คุณได้เรียกรถออกมาจากจุดเบิกรถแก๊งของคุณแล้ว !");
				return 1;
			}
			case 3:
			{
				if (VehicleGang[id][bSlot][3] == 0)
				    return SendClientMessage(playerid, COLOR_LIGHTRED, "กรุณาติดต่อผู้ดูแลระบบ, เพื่อตั้งค่ารถแก๊ง");

				new Float:x, Float:y, Float:z, Float:a; // defines variables which we will use
				GetPlayerPos(playerid, x, y, z);
				GetPlayerFacingAngle(playerid, a);

				CreatePlayerVehicle2(playerid, VehicleGang[id][bSlot][3], VehicleGang[id][bColor1][3], VehicleGang[id][bColor2][3]);
				playerData[playerid][pCarVehI] = 1;
				FactionGang[playerid] = -1;

				SendClientMessage(playerid, COLOR_LIGHTBLUE, "* คุณได้เรียกรถออกมาจากจุดเบิกรถแก๊งของคุณแล้ว !");
				return 1;
			}
			case 4:
			{
				if (VehicleGang[id][bSlot][4] == 0)
				    return SendClientMessage(playerid, COLOR_LIGHTRED, "กรุณาติดต่อผู้ดูแลระบบ, เพื่อตั้งค่ารถแก๊ง");

				new Float:x, Float:y, Float:z, Float:a; // defines variables which we will use
				GetPlayerPos(playerid, x, y, z);
				GetPlayerFacingAngle(playerid, a);

				CreatePlayerVehicle2(playerid, VehicleGang[id][bSlot][4], VehicleGang[id][bColor1][4], VehicleGang[id][bColor2][4]);
				playerData[playerid][pCarVehI] = 1;
				FactionGang[playerid] = -1;

				SendClientMessage(playerid, COLOR_LIGHTBLUE, "* คุณได้เรียกรถออกมาจากจุดเบิกรถแก๊งของคุณแล้ว !");
				return 1;
			}
			case 5:
			{
				if (VehicleGang[id][bSlot][5] == 0)
				    return SendClientMessage(playerid, COLOR_LIGHTRED, "กรุณาติดต่อผู้ดูแลระบบ, เพื่อตั้งค่ารถแก๊ง");

				new Float:x, Float:y, Float:z, Float:a; // defines variables which we will use
				GetPlayerPos(playerid, x, y, z);
				GetPlayerFacingAngle(playerid, a);

				CreatePlayerVehicle2(playerid, VehicleGang[id][bSlot][5], VehicleGang[id][bColor1][5], VehicleGang[id][bColor2][5]);
				playerData[playerid][pCarVehI] = 1;
				FactionGang[playerid] = -1;

				SendClientMessage(playerid, COLOR_LIGHTBLUE, "* คุณได้เรียกรถออกมาจากจุดเบิกรถแก๊งของคุณแล้ว !");
				return 1;
			}
			case 6:
			{
				if (VehicleGang[id][bSlot][6] == 0)
				    return SendClientMessage(playerid, COLOR_LIGHTRED, "กรุณาติดต่อผู้ดูแลระบบ, เพื่อตั้งค่ารถแก๊ง");

				new Float:x, Float:y, Float:z, Float:a; // defines variables which we will use
				GetPlayerPos(playerid, x, y, z);
				GetPlayerFacingAngle(playerid, a);

				CreatePlayerVehicle2(playerid, VehicleGang[id][bSlot][6], VehicleGang[id][bColor1][6], VehicleGang[id][bColor2][6]);
				playerData[playerid][pCarVehI] = 1;
				FactionGang[playerid] = -1;

				SendClientMessage(playerid, COLOR_LIGHTBLUE, "* คุณได้เรียกรถออกมาจากจุดเบิกรถแก๊งของคุณแล้ว !");
				return 1;
			}
			case 7:
			{
				if (VehicleGang[id][bSlot][7] == 0)
				    return SendClientMessage(playerid, COLOR_LIGHTRED, "กรุณาติดต่อผู้ดูแลระบบ, เพื่อตั้งค่ารถแก๊ง");

				new Float:x, Float:y, Float:z, Float:a; // defines variables which we will use
				GetPlayerPos(playerid, x, y, z);
				GetPlayerFacingAngle(playerid, a);

				CreatePlayerVehicle2(playerid, VehicleGang[id][bSlot][7], VehicleGang[id][bColor1][7], VehicleGang[id][bColor2][7]);
				playerData[playerid][pCarVehI] = 1;
				FactionGang[playerid] = -1;

				SendClientMessage(playerid, COLOR_LIGHTBLUE, "* คุณได้เรียกรถออกมาจากจุดเบิกรถแก๊งของคุณแล้ว !");
				return 1;
			}
			case 8:
			{
				if (VehicleGang[id][bSlot][8] == 0)
				    return SendClientMessage(playerid, COLOR_LIGHTRED, "กรุณาติดต่อผู้ดูแลระบบ, เพื่อตั้งค่ารถแก๊ง");

				new Float:x, Float:y, Float:z, Float:a; // defines variables which we will use
				GetPlayerPos(playerid, x, y, z);
				GetPlayerFacingAngle(playerid, a);

				CreatePlayerVehicle2(playerid, VehicleGang[id][bSlot][8], VehicleGang[id][bColor1][8], VehicleGang[id][bColor2][8]);
				playerData[playerid][pCarVehI] = 1;
				FactionGang[playerid] = -1;

				SendClientMessage(playerid, COLOR_LIGHTBLUE, "* คุณได้เรียกรถออกมาจากจุดเบิกรถแก๊งของคุณแล้ว !");
				return 1;
			}
			case 9:
			{
				if (VehicleGang[id][bSlot][9] == 0)
				    return SendClientMessage(playerid, COLOR_LIGHTRED, "กรุณาติดต่อผู้ดูแลระบบ, เพื่อตั้งค่ารถแก๊ง");

				new Float:x, Float:y, Float:z, Float:a; // defines variables which we will use
				GetPlayerPos(playerid, x, y, z);
				GetPlayerFacingAngle(playerid, a);

				CreatePlayerVehicle2(playerid, VehicleGang[id][bSlot][9], VehicleGang[id][bColor1][9], VehicleGang[id][bColor2][9]);
				playerData[playerid][pCarVehI] = 1;
				FactionGang[playerid] = -1;

				SendClientMessage(playerid, COLOR_LIGHTBLUE, "* คุณได้เรียกรถออกมาจากจุดเบิกรถแก๊งของคุณแล้ว !");
				return 1;
			}
		}
	}
	return 1;
}
