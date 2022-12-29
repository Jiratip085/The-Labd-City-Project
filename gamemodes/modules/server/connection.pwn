//==============================================================================
//          -- > Database Information
//==============================================================================

#define MYSQL_HOST "127.0.0.1"
#define MYSQL_USER "root"
#define MYSQL_PASS ""
#define MYSQL_DB   "worps"



new MySQL:dbCon;
forward MySQLConnect(sqlhost[], sqluser[], sqlpass[], sqldb[]);
forward MySQLDisconnect();
forward MySQLCheckConnection();
forward MySQLUpdateSingleInt(sqlplayerid, sqlvalname[], sqlupdateint);
forward MySQLCheckAccount(sqlplayersname[]);
//forward MySQLCheckAccountLocked(sqlplayerid);


public MySQLConnect(sqlhost[], sqluser[], sqlpass[], sqldb[])
{
    dbCon = mysql_connect(sqlhost, sqluser, sqlpass, sqldb);

    if (mysql_errno(dbCon) != 0) {
	    printf("[SQL] Connection to \"%s\" failed! Please check the connection settings...\a", sqlhost);
	}
	else {
		printf("[SQL] Connection to \"%s\" passed!", sqlhost);
	}
}

public MySQLDisconnect() // by Luk0r
{
	mysql_close(dbCon);
	return 1;
}

public MySQLCheckConnection() // by Luk0r
{
	if(mysql_errno() != 0)
	{
		print("MYSQL: Connection seems dead, retrying...");
		MySQLDisconnect();
		MySQLConnect(MYSQL_HOST,MYSQL_USER,MYSQL_PASS,MYSQL_DB);
		if(mysql_errno(dbCon) == 0)
		{
			print("MYSQL: Reconnection successful. We can continue as normal.");
			return 1;
		}
		else
		{
			print("MYSQL: Could not reconnect to server, terminating server...");
			SendRconCommand("exit");
			return 0;
		}
	}
	return 1;
}

public MySQLUpdateSingleInt(sqlplayerid, sqlvalname[], sqlupdateint) // by Luk0r
{
	new query[128];
	format(query, sizeof(query), "UPDATE accounts SET %s=%d WHERE SQLID=%d", sqlvalname, sqlupdateint, sqlplayerid);
	mysql_query(dbCon,query);
	return 1;
}

public MySQLCheckAccount(sqlplayersname[]) // by Luk0r
{
	new query[128];
	new escstr[MAX_PLAYER_NAME];
	mysql_escape_string(sqlplayersname,escstr);
	format(query, sizeof(query), "SELECT SQLID FROM accounts WHERE LOWER(Username) = LOWER('%s') LIMIT 1", escstr);
	mysql_query(dbCon, query);

	if(!cache_num_rows())
	{
		return 0;
	}
	else
	{
	    new int_dest;
	    cache_get_value_index_int(0, 0, int_dest);
		return int_dest;
	}
}

/*public MySQLCheckAccountLocked(sqlplayerid)
{
	new query[64];

	format(query, sizeof(query), "SELECT Locked FROM characters WHERE id = %d LIMIT 1", sqlplayerid);
	mysql_query(dbCon, query);

	new int_dest;
	cache_get_value_index_int(0, 0, int_dest);

	return int_dest;
}*/
