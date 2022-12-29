#include <YSI\y_hooks>


CMD:editserver(playerid, params[])
{
    if(Account[playerid][Admin] < 1339)
        return SendClientMessage(playerid, COLOR_RED, "[!] {FFFFFF}คุณไม่ได้รับอนุญาติ");

    ShowDialogEditServer(playerid);
    return 1;
}

Server_Save2()
{
	new
	    query[2048];

	format(query, sizeof(query), "UPDATE `settings` SET `Name` = '%s', `Version` = '%s', `Password` = '%s', `Locked` = '%d' WHERE `ID` = '0'",
		SQL_ReturnEscaped(Server[Name]),
        SQL_ReturnEscaped(Server[Version]),
        SQL_ReturnEscaped(Server[Password]),
        Server[Locked],
        Server[ID]
	);
	return mysql_tquery(dbCon, query);
}

stock ShowDialogEditServer(playerid)
{
    new string[1024];

    format(string, sizeof(string), "ชื่อเซิฟเวอร์: %s\n", Server[Name]);
    format(string, sizeof(string), "%sเวอร์ชั่น: %s\n", string, Server[Version]);
    format(string, sizeof(string), "%sสถานะ: %s\n",string, Server[Locked] ? ("ล็อค") : ("ปลดล็อค"));
    format(string, sizeof(string), "%sพาสเวิร์ด: %s", string, Server[Password]);
    Dialog_Show(playerid, ChangeServer, DIALOG_STYLE_LIST, "แก้ไขเซิฟเวอร์", string, "เลือก","ยกเลิก");
    return 1;
}

Dialog:ChangeServer(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new string[1024];

    if(response)
    {
        if(listitem == 0)
        {
            format(string, sizeof(string), "ชื่อเซิฟเวอร์: %s", Server[Name]);
            Dialog_Show(playerid, ChangeServerName, DIALOG_STYLE_INPUT, "ตั้งค่าชื่อเซิฟเวอร์", string, "เปลี่ยน", "กลับ");
        }
        if(listitem == 1)
        {
            format(string, sizeof(string), "เวอร์ชั่นปัจจุบัน: %s", Server[Version]);
            Dialog_Show(playerid, ChangeServerVersion, DIALOG_STYLE_INPUT, "ตั้งค่าเวอร์ชั่น", string, "เปลี่ยน", "กลับ");
        }
        if(listitem == 2)
        {
            format(string, sizeof(string), "ปลดล็อค\nล็อค");
            Dialog_Show(playerid, ChangeServerLocked, DIALOG_STYLE_LIST, "การตั้งค่าล็อคเซิฟเวอร์", string, "เปลี่ยน", "กลับ");
        }
        if(listitem == 3)
        {
            format(string, sizeof(string), "พาสเวิร์ด: %s", Server[Password]);
            Dialog_Show(playerid, ChangeServerPassword, DIALOG_STYLE_INPUT, "ตั้งค่ารหัสผ่าน", string, "เปลี่ยน", "กลับ");
        }
    }
    return 1;
}

Dialog:ChangeServerName(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[64];

		if(isnull(inputtext) || strlen(inputtext) >= 64) {
			format(string, sizeof(string), "ความยาวของชื่อต้องมากกว่า 0 และไม่เกิน 64/n/nชื่อเซิฟเวอร์: %s", Server[Name]);
			Dialog_Show(playerid, ChangeServerName, DIALOG_STYLE_INPUT, "แก้ไขชื่อเซิฟเวอร์", string, "เปลี่ยน", "กลับ");
			return true;
		}
		format(Server[Name], 64, inputtext);
        new name[64];
        format(name, sizeof(name), "hostname %s", Server[Name]);
		SendRconCommand(name);
		Server_Save2();
        SendClientMessage(playerid, -1, "คุณได้เปลี่ยนชื่อเซิฟเวอร์เป็น '%s' เรียบร้อยแล้ว!",Server[Name]);
    }
    return ShowDialogEditServer(playerid);
}

Dialog:ChangeServerVersion(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[16];

		if(isnull(inputtext) || strlen(inputtext) >= 16) {
			format(string, sizeof(string), "ความยาวของชื่อต้องมากกว่า 0 และไม่เกิน 16/n/nเวอร์ชั่น: %s", Server[Version]);
			Dialog_Show(playerid, ChangeServerVersion, DIALOG_STYLE_INPUT, "แก้ไขเวอร์ชั่น", string, "เปลี่ยน", "กลับ");
			return true;
		}
		format(Server[Version], 16, inputtext);
        new name[16];
        format(name, sizeof(name), "%s", Server[Version]);
        SetGameModeText(name);
		Server_Save2();
        SendClientMessage(playerid, -1, "คุณได้เปลี่ยน Version เป็น '%s' เรียบร้อยแล้ว!",Server[Version]);
    }
    return ShowDialogEditServer(playerid);
}

Dialog:ChangeServerPassword(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[32];

		if(isnull(inputtext) || strlen(inputtext) >= 32) {
			format(string, sizeof(string), "ความยาวของชื่อต้องมากกว่า 0 และไม่เกิน 32/n/nเวอร์ชั่น: %s", Server[Password]);
			Dialog_Show(playerid, ChangeServerPassword, DIALOG_STYLE_INPUT, "แก้ไขเวอร์ชั่น", string, "เปลี่ยน", "กลับ");
			return true;
		}
		format(Server[Password], 32, inputtext);
        new name[32];
        format(name, sizeof(name), "password %s", Server[Password]);
        SendRconCommand(name);
		Server_Save2();
        SendClientMessage(playerid, -1, "คุณได้เปลี่ยน พาสเวิร์ด เป็น '%s' เรียบร้อยแล้ว!",Server[Password]);
    }
    return ShowDialogEditServer(playerid);
}

Dialog:ChangeServerLocked(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(listitem == 0)
        {
            Server[Locked] = 0;
            SendRconCommand("password 0");
            Server_Save2();
        }
        if(listitem == 1)
        {
            Server[Locked] = 1;
            SendRconCommand("password 0");
            new str[64];
            format(str, sizeof(str), "password %s", Server[Password]);
			SendRconCommand(str);
            Server_Save2();
        }
    }
    return ShowDialogEditServer(playerid);
}
/*
ResetPlayer(playerid)
{
	foreach (new i : Player) if (Character[i][pDraggedBy] == playerid)
	{
	    StopDragging(i);
	}
	if (Character[playerid][pDragged])
	{
	    StopDragging(playerid);
	}
	//Character[playerid][pCuffed] = 0;
    Character[playerid][pDragged] = 0;
    Character[playerid][pDraggedBy] = INVALID_PLAYER_ID;
}
new const vehicleArray[][vmInfo] =
{
	{"Car",       	405, 15000},
	{"Car",       	413, 15000},
    {"Car",       	422, 15000}

};
GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid))
	{
		GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}


GetXYBehindVehicle(vehicleid, &Float:q, &Float:w, Float:distance)
{
    new Float:a;
    GetVehiclePos(vehicleid, q, w, a);
    GetVehicleZAngle(vehicleid, a);
    q += (distance * -floatsin(-a, degrees));
    w += (distance * -floatcos(-a, degrees));
}
*/

//Addwhitelist
CMD:addpc(playerid, params[]){ //  /addpc [nameplayer]

    if (Account[playerid][Admin] < 1337)
	    return 1;

	//params รับชื่อผู้เล่นเข้ามา
	if(isnull(params))
	    return SendClientMessage(playerid, -1, "คุณจำเป็นต้องกรอกชื่อผู้เล่นที่จะให้ไวริส");

	new str[128], string[128];

	format(string, sizeof(string), "UPDATE `characters` SET `Whitelist` = %d WHERE `Name` = '%s'", 1, SQL_ReturnEscaped(params));
	mysql_tquery(dbCon, string);

	format(str, sizeof(str), "%s:{FFFFFF} Set Whitelist to %s", GetRoleplayName(playerid), params);
	SendAdminsMessage(1, COLOR_YELLOW, str);
	return 1;
}

hook OnGameModeInit()
{
    CreateDynamic3DTextLabel("[Fixbug Mobile]{FFFFFF}\n{FFFFFF}กด 'Y' เพื่อแก้บัค Death", COLOR_GREEN, -207.1014,1119.2313,20.4297, 1.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
    return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
        if(IsPlayerInRangeOfPoint(playerid, 1, -207.1014,1119.2313,20.4297)) 
		{
            if(Character[playerid][Injured] == 1)
            {
                AC_SetPlayerHealth(playerid, 100);

                ClearAnimations(playerid);
                ResetDamages(playerid);
                Character[playerid][Injured] = 0;
                Character[playerid][InjuredTime] = 0;
                Character[playerid][InjuredEx]= 0;
                Character[playerid][InjuredSpawn] = 0;
                Character[playerid][InjuredShoot] = 0;
            }
        }
        return 1;
    }
    return 1;
}