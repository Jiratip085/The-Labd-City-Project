#include <YSI\y_hooks>

hook OnPlayerConnect(playerid)
{
	IP_Lookup(playerid);
	Account_Lookup(playerid);
}


IP_Lookup(playerid)
{
	new query[128], ip[18];
	GetPlayerIp(playerid, ip, sizeof(ip));
	mysql_format(dbCon, query, sizeof(query), "SELECT * FROM Bans WHERE IP = '%s' LIMIT 1", ip);//OR MasterAccount = %d- , MasterAccount[playerid][SQLID]
	mysql_tquery(dbCon, query, "Lookup_Result", "d", playerid);
	return 1;
}

Account_Lookup(playerid)
{
	new query[128];
	mysql_format(dbCon, query, sizeof(query), "SELECT * FROM Bans WHERE A_ID = %d LIMIT 1", Account[playerid][SQLID]);//OR MasterAccount = %d- , MasterAccount[playerid][SQLID]
	mysql_tquery(dbCon, query, "Lookup_Result", "d", Account[playerid][SQLID]);
	return 1;
}

forward Lookup_Result(playerid);
public Lookup_Result(playerid)
{
    if(cache_num_rows())
    {
		new Reason[128];
		new NameBy[128];
		new NamePlayer[128];
		cache_get_value_name(0, "Reason", Reason, 128);
		cache_get_value_name(0, "BannedBy", NameBy, 128);
		cache_get_value_name(0, "PlayerName", NamePlayer, 128);

		CheckBanned[playerid] = 1;
        SendClientMessage(playerid, COLOR_WHITE, "บัญชีของคุณถูกแบนจากเซิฟเวอร์");
		new string[1024];
		format(string, sizeof(string), "{E40101}บัญชี: %s\n{E40101}ตัวละคร: %s\n{E40101}สาเหตุ: %s\n{E40101}ถูกแบนโดย: %s\nกรุณาติดต่อแอดมินเพื่อขอปลด", ReturnName(playerid), NamePlayer, Reason, NameBy);
        Dialog_Show(playerid, Show_Only, DIALOG_STYLE_MSGBOX, "แจ้งเตือน", string, "ตกลง", "");
		SetTimerEx("KickPlayerBan", 2000, 0, "d", playerid);
	    return 0;
	}
	return 1;
}

forward KickPlayerBan(playerid);
public KickPlayerBan(playerid)
{
	KickPlayer(playerid);
	return 1;
}

/*
IssueBan(playerid, adminname[], reason[])
{
	new query[256], ip[18];
	GetPlayerIp(playerid, ip, 18);
	
    mysql_format(dbCon, query, sizeof(query), "INSERT INTO Bans (CharacterName, IP, SQLID, Account, Timestamp, BannedBy, Reason) VALUES('%s', '%s', %d, %d, %d, '%s', '%e')", GetDatabaseName(playerid), ip, PlayerInfo[playerid][SQLID], MasterAccount[playerid][SQLID], gettime(), adminname, reason);
	mysql_tquery(dbCon, query);
	KickPlayer(playerid);
	return 1;
}
*/