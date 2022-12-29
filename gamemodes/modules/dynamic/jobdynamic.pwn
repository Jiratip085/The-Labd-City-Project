#include <YSI\y_hooks>

enum jobData {
	jobID,
	jobExists,
	jobName[32],
	jobType,
	Float:jobPos[3],
	Float:jobPoint[3],
	Float:jobDeliver[3],
	jobInterior,
	jobWorld,
	jobPointInt,
	jobPointWorld,
	jobPickups[3],
	Text3D:jobText3D[3]
};
new JobData[MAX_DYNAMIC_JOBS][jobData],Total_Jobs_Created;

//Job
Job_GetName(type)
{
	new
	    str[24];

	switch (type)
	{
	    case 1: str = "Newspaper Delivery";
	    case 2: str = "Mechanic";
	    case 3: str = "Lumberjack";
	    case 4: str = "Fruit Transport";
		case 5: str = "Cow milking";
	    default: str = "Unemployed";
	}
	return str;
}

forward Job_Load();
public Job_Load()
{
	new
	    rows;

	cache_get_row_count(rows);

    for (new i = 0; i < rows; i ++) if (i < MAX_DYNAMIC_JOBS)
	{
	    JobData[i][jobExists] = true;

	    cache_get_value_name_int(i, "jobID", JobData[i][jobID]);
	    cache_get_value_name(i, "jobName", JobData[i][jobName], 32);
	    cache_get_value_name_int(i, "jobType", JobData[i][jobType]);
	    cache_get_value_name_float(i, "jobPosX", JobData[i][jobPos][0]);
	    cache_get_value_name_float(i, "jobPosY", JobData[i][jobPos][1]);
	    cache_get_value_name_float(i, "jobPosZ", JobData[i][jobPos][2]);
	    cache_get_value_name_int(i, "jobInterior", JobData[i][jobInterior]);
	    cache_get_value_name_int(i, "jobWorld", JobData[i][jobWorld]);
	    cache_get_value_name_float(i, "jobPointX", JobData[i][jobPoint][0]);
	    cache_get_value_name_float(i, "jobPointY", JobData[i][jobPoint][1]);
	    cache_get_value_name_float(i, "jobPointZ", JobData[i][jobPoint][2]);
	    cache_get_value_name_float(i, "jobDeliverX", JobData[i][jobDeliver][0]);
	    cache_get_value_name_float(i, "jobDeliverY", JobData[i][jobDeliver][1]);
	    cache_get_value_name_float(i, "jobDeliverZ", JobData[i][jobDeliver][2]);
	    cache_get_value_name_int(i, "jobPointInt", JobData[i][jobPointInt]);
	    cache_get_value_name_int(i, "jobPointWorld", JobData[i][jobPointWorld]);

        Total_Jobs_Created++;

 	    Job_Refresh(i);

	}
	printf("[MYSQL]: %d Jobs have been successfully loaded from the database.", Total_Jobs_Created);
	return 1;
}
/*
Job_NearestPoint(playerid, Float:radius = 4.0)
{
    for (new i = 0; i != MAX_DYNAMIC_JOBS; i ++) if (JobData[i][jobExists] && IsPlayerInRangeOfPoint(playerid, radius, JobData[i][jobPoint][0], JobData[i][jobPoint][1], JobData[i][jobPoint][2])) {
		return i;
	}
	return -1;
}

Job_NearestDelivery(playerid, Float:radius = 4.0)
{
    for (new i = 0; i != MAX_DYNAMIC_JOBS; i ++) if (JobData[i][jobExists] && IsPlayerInRangeOfPoint(playerid, radius, JobData[i][jobDeliver][0], JobData[i][jobDeliver][1], JobData[i][jobDeliver][2])) {
		return i;
	}
	return -1;
}*/

Job_Nearest(playerid)
{
    for (new i = 0; i != MAX_DYNAMIC_JOBS; i ++) if (JobData[i][jobExists] && IsPlayerInRangeOfPoint(playerid, 2.5, JobData[i][jobPos][0], JobData[i][jobPos][1], JobData[i][jobPos][2]))
	{
		if (GetPlayerInterior(playerid) == JobData[i][jobInterior] && GetPlayerVirtualWorld(playerid) == JobData[i][jobWorld])
			return i;
	}
	return -1;
}

Job_Refresh(jobid)
{
	if (jobid != -1 && JobData[jobid][jobExists])
	{
	    for (new i = 0; i < 3; i ++) {
			if (IsValidDynamic3DTextLabel(JobData[jobid][jobText3D][i]))
		    	DestroyDynamic3DTextLabel(JobData[jobid][jobText3D][i]);

			if (IsValidDynamicPickup(JobData[jobid][jobPickups][i]))
		    	DestroyDynamicPickup(JobData[jobid][jobPickups][i]);
		}
		new
		    string[90],
		    string1[90];

		format(string, sizeof(string), "[%s(%s)]\n�� /getjob ������Ѥçҹ���!", Job_GetName(JobData[jobid][jobType]), JobData[jobid][jobName]);

		if (JobData[jobid][jobType] == 1)
		{
		    format(string1, sizeof(string1), "[%s]\n����� /startnewspaper ����������ҹ", Job_GetName(JobData[jobid][jobType]));
		    JobData[jobid][jobText3D][1] = CreateDynamic3DTextLabel(string1, COLOR_WHITE, JobData[jobid][jobPoint][0], JobData[jobid][jobPoint][1], JobData[jobid][jobPoint][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, JobData[jobid][jobPointWorld], JobData[jobid][jobPointInt]);
			JobData[jobid][jobPickups][1] = CreateDynamicPickup(1239, 23, JobData[jobid][jobPoint][0], JobData[jobid][jobPoint][1], JobData[jobid][jobPoint][2], JobData[jobid][jobPointWorld], JobData[jobid][jobPointInt]);
		}
		if (JobData[jobid][jobType] == 2)
		{
		    /*format(string1, sizeof(string1), "[%s]\n�͡���Ѿഷ", Job_GetName(JobData[jobid][jobType]));
		    JobData[jobid][jobText3D][1] = CreateDynamic3DTextLabel(string1, COLOR_WHITE, JobData[jobid][jobPoint][0], JobData[jobid][jobPoint][1], JobData[jobid][jobPoint][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, JobData[jobid][jobPointWorld], JobData[jobid][jobPointInt]);
			JobData[jobid][jobPickups][1] = CreateDynamicPickup(1239, 23, JobData[jobid][jobPoint][0], JobData[jobid][jobPoint][1], JobData[jobid][jobPoint][2], JobData[jobid][jobPointWorld], JobData[jobid][jobPointInt]);*/
		}
		if (JobData[jobid][jobType] == 3)
		{
		   /* format(string1, sizeof(string1), "[%s(%s)]\n����� /startlumberjack ����������ҹ", Job_GetName(JobData[jobid][jobType]), JobData[jobid][jobName]);
		    JobData[jobid][jobText3D][1] = CreateDynamic3DTextLabel(string1, COLOR_WHITE, JobData[jobid][jobPoint][0], JobData[jobid][jobPoint][1], JobData[jobid][jobPoint][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, JobData[jobid][jobPointWorld], JobData[jobid][jobPointInt]);
			JobData[jobid][jobPickups][1] = CreateDynamicPickup(1239, 23, JobData[jobid][jobPoint][0], JobData[jobid][jobPoint][1], JobData[jobid][jobPoint][2], JobData[jobid][jobPointWorld], JobData[jobid][jobPointInt]);

			format(string1, sizeof(string1), "[%s(%s)]\n�ش�����\n����� '/sellwood' ���͢�����", Job_GetName(JobData[jobid][jobType]), JobData[jobid][jobName]);
			JobData[jobid][jobText3D][2] = CreateDynamic3DTextLabel(string1, COLOR_WHITE, JobData[jobid][jobDeliver][0], JobData[jobid][jobDeliver][1], JobData[jobid][jobDeliver][2], 15.0);
			JobData[jobid][jobPickups][2] = CreateDynamicPickup(1239, 23, JobData[jobid][jobDeliver][0], JobData[jobid][jobDeliver][1], JobData[jobid][jobDeliver][2]);
		*/}
		if (JobData[jobid][jobType] == 4)
		{
		    /*format(string1, sizeof(string1), "[%s(%s)]\n����� /startharvest ����������ҹ", Job_GetName(JobData[jobid][jobType]), JobData[jobid][jobName]);
		    JobData[jobid][jobText3D][1] = CreateDynamic3DTextLabel(string1, COLOR_WHITE, JobData[jobid][jobPoint][0], JobData[jobid][jobPoint][1], JobData[jobid][jobPoint][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, JobData[jobid][jobPointWorld], JobData[jobid][jobPointInt]);
			JobData[jobid][jobPickups][1] = CreateDynamicPickup(1239, 23, JobData[jobid][jobPoint][0], JobData[jobid][jobPoint][1], JobData[jobid][jobPoint][2], JobData[jobid][jobPointWorld], JobData[jobid][jobPointInt]);

			format(string1, sizeof(string1), "[%s(%s)]\n�ش��¼����\n����� '/sellfruit' ���͢�¼����", Job_GetName(JobData[jobid][jobType]), JobData[jobid][jobName]);
			JobData[jobid][jobText3D][2] = CreateDynamic3DTextLabel(string1, COLOR_WHITE, JobData[jobid][jobDeliver][0], JobData[jobid][jobDeliver][1], JobData[jobid][jobDeliver][2], 15.0);
			JobData[jobid][jobPickups][2] = CreateDynamicPickup(1239, 23, JobData[jobid][jobDeliver][0], JobData[jobid][jobDeliver][1], JobData[jobid][jobDeliver][2]);
		*/}
		if (JobData[jobid][jobType] == 5)
		{
		    /*format(string1, sizeof(string1), "[%s(%s)]\n����� /startjob ����������ҹ", Job_GetName(JobData[jobid][jobType]), JobData[jobid][jobName]);
		    JobData[jobid][jobText3D][1] = CreateDynamic3DTextLabel(string1, COLOR_WHITE, JobData[jobid][jobPoint][0], JobData[jobid][jobPoint][1], JobData[jobid][jobPoint][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, JobData[jobid][jobPointWorld], JobData[jobid][jobPointInt]);
			JobData[jobid][jobPickups][1] = CreateDynamicPickup(1239, 23, JobData[jobid][jobPoint][0], JobData[jobid][jobPoint][1], JobData[jobid][jobPoint][2], JobData[jobid][jobPointWorld], JobData[jobid][jobPointInt]);

			format(string1, sizeof(string1), "[%s(%s)]\n�ش�觹����\n�� 'N' ������", Job_GetName(JobData[jobid][jobType]), JobData[jobid][jobName]);
			JobData[jobid][jobText3D][2] = CreateDynamic3DTextLabel(string1, COLOR_WHITE, JobData[jobid][jobDeliver][0], JobData[jobid][jobDeliver][1], JobData[jobid][jobDeliver][2], 15.0);
			JobData[jobid][jobPickups][2] = CreateDynamicPickup(1239, 23, JobData[jobid][jobDeliver][0], JobData[jobid][jobDeliver][1], JobData[jobid][jobDeliver][2]);
		*/}
		JobData[jobid][jobText3D][0] = CreateDynamic3DTextLabel(string, COLOR_WHITE, JobData[jobid][jobPos][0], JobData[jobid][jobPos][1], JobData[jobid][jobPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, JobData[jobid][jobWorld], JobData[jobid][jobInterior]);
	    JobData[jobid][jobPickups][0] = CreateDynamicPickup(1239, 23, JobData[jobid][jobPos][0], JobData[jobid][jobPos][1], JobData[jobid][jobPos][2], JobData[jobid][jobWorld], JobData[jobid][jobInterior]);
	}
	return 1;
}

Job_Delete(jobid)
{
	if (jobid != -1 && JobData[jobid][jobExists])
	{
	    new
	        string[64];

        Total_Jobs_Created--;

		format(string, sizeof(string), "DELETE FROM `jobs` WHERE `jobID` = '%d'", JobData[jobid][jobID]);
		mysql_tquery(dbCon, string);

        for (new i = 0; i < 3; i ++) {
			if (IsValidDynamic3DTextLabel(JobData[jobid][jobText3D][i]))
		    	DestroyDynamic3DTextLabel(JobData[jobid][jobText3D][i]);

			if (IsValidDynamicPickup(JobData[jobid][jobPickups][i]))
		    	DestroyDynamicPickup(JobData[jobid][jobPickups][i]);
		}
		JobData[jobid][jobExists] = false;
		JobData[jobid][jobType] = 0;
	    JobData[jobid][jobID] = 0;
	}
	return 1;
}

Job_Save(jobid)
{
	new
	    query[512];

	format(query, sizeof(query), "UPDATE `jobs` SET `jobName` = '%s', `jobType` = '%d', `jobPosX` = '%.4f', `jobPosY` = '%.4f', `jobPosZ` = '%.4f', `jobInterior` = '%d', `jobWorld` = '%d', `jobPointX` = '%.4f', `jobPointY` = '%.4f', `jobPointZ` = '%.4f', `jobDeliverX` = '%.4f', `jobDeliverY` = '%.4f', `jobDeliverZ` = '%.4f', `jobPointInt` = '%d', `jobPointWorld` = '%d' WHERE `jobID` = '%d'",
		JobData[jobid][jobName],
		JobData[jobid][jobType],
		JobData[jobid][jobPos][0],
	    JobData[jobid][jobPos][1],
	    JobData[jobid][jobPos][2],
	    JobData[jobid][jobInterior],
	    JobData[jobid][jobWorld],
	    JobData[jobid][jobPoint][0],
	    JobData[jobid][jobPoint][1],
	    JobData[jobid][jobPoint][2],
	    JobData[jobid][jobDeliver][0],
	    JobData[jobid][jobDeliver][1],
	    JobData[jobid][jobDeliver][2],
	    JobData[jobid][jobPointInt],
	    JobData[jobid][jobPointWorld],
	    JobData[jobid][jobID]
	);
	return mysql_tquery(dbCon, query);
}

Job_Create(playerid, type)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	if (GetPlayerPos(playerid, x, y, z))
	{
		for (new i = 0; i != MAX_DYNAMIC_JOBS; i ++)
		{
	    	if (!JobData[i][jobExists])
	    	{
	        	JobData[i][jobExists] = true;
	        	JobData[i][jobType] = type;

				//�������ͧҹ
				if(JobData[i][jobType] == 1)
				{
				    format(JobData[i][jobName], 32, "����˹ѧ��;����");
				}
				if(JobData[i][jobType] == 2)
				{
				    format(JobData[i][jobName], 32, "��ҧ¹��");
				}
				if(JobData[i][jobType] == 3)
				{
				    format(JobData[i][jobName], 32, "���Ѵ���");
				}
				if(JobData[i][jobType] == 4)
				{
				    format(JobData[i][jobName], 32, "���觼����");
				}
				if(JobData[i][jobType] == 5)
				{
				    format(JobData[i][jobName], 32, "�մ�����");
				}

				JobData[i][jobPos][0] = x;
	        	JobData[i][jobPos][1] = y;
	        	JobData[i][jobPos][2] = z;
	        	JobData[i][jobPoint][0] = 0.0;
	        	JobData[i][jobPoint][1] = 0.0;
	        	JobData[i][jobPoint][2] = 0.0;
	        	JobData[i][jobDeliver][0] = 0.0;
	        	JobData[i][jobDeliver][1] = 0.0;
	        	JobData[i][jobDeliver][2] = 0.0;

	        	JobData[i][jobInterior] = GetPlayerInterior(playerid);
	        	JobData[i][jobWorld] = GetPlayerVirtualWorld(playerid);

                JobData[i][jobPointInt] = 0;
                JobData[i][jobPointWorld] = 0;

	        	Job_Refresh(i);
	        	mysql_tquery(dbCon, "INSERT INTO `jobs` (`jobInterior`) VALUES(0)", "OnJobCreated", "d", i);

	        	return i;
	        }
	    }
	}
	return -1;
}

forward OnJobCreated(jobid);
public OnJobCreated(jobid)
{
	if (jobid == -1 || !JobData[jobid][jobExists])
	    return 0;

	JobData[jobid][jobID] = cache_insert_id();
	Job_Save(jobid);

	return 1;
}

CMD:jobrefresh(playerid, params[])
{
	if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "�س������Ѻ͹حҵ��������觹��");

	for(new i=0; i< MAX_DYNAMIC_JOBS;i++){
		Job_Refresh(i);
	}
	return 1;
}

CMD:createjob(playerid, params[])
{
	new
		id = -1,
		type,
		string[128];

	if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "�س������Ѻ͹حҵ��������觹��");

	if (sscanf(params, "ds[32]", type))
	    return SendClientMessage(playerid, -1, "/createjob [type]");

    if (type < 1 || type > MAX_DYNAMIC_JOBS)
    {
        format(string, sizeof(string), "����������к����١��ͧ��ͧ����������ҧ 1 �֧ %d", 19);
		SendClientMessage(playerid, -1, string);
		return 1;
	}

	id = Job_Create(playerid, type);

	if (id == -1)
	    return SendClientMessage(playerid, -1, "�Կ������������ҧ�Ҫվ�Թ�մ�ӡѴ����");

    format(string, sizeof(string), "�س���ʺ������������ҧ�ҹ�ʹ�: %d", id);
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:destroyjob(playerid, params[])
{
	new
	    id = 0,
	    string[128];

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "�س������Ѻ͹حҵ��������觹��");

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, -1, "/destroyjob [job id]");

	if ((id < 0 || id >= MAX_DYNAMIC_JOBS) || !JobData[id][jobExists])
	    return SendClientMessage(playerid, -1, "�س�к��ʹէҹ�Դ��Ҵ");

	Job_Delete(id);
	format(string, sizeof(string), "�س���ʺ���������㹡�÷���§ҹ�ʹ�: %d", id);
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:editjob(playerid, params[])
{
	new
	    id,
	    type[24],
	    string[128];

	if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "�س������Ѻ͹حҵ��������觹��");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendClientMessage(playerid, -1, "/editjob [id] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, point, deliver, type");
		return 1;
	}
	if ((id < 0 || id >= MAX_DYNAMIC_JOBS) || !JobData[id][jobExists])
	    return SendClientMessage(playerid, -1, "�س�к��ʹէҹ���١��ͧ");

	if (!strcmp(type, "location", true))
	{
	    new
	        Float:x,
	        Float:y,
	        Float:z;

	    GetPlayerPos(playerid, x, y, z);

		JobData[id][jobPos][0] = x;
		JobData[id][jobPos][1] = y;
		JobData[id][jobPos][2] = z;

		JobData[id][jobInterior] = GetPlayerInterior(playerid);
		JobData[id][jobWorld] = GetPlayerVirtualWorld(playerid);

		Job_Refresh(id);
		Job_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ���Ѻ���˹觢ͧ Product �ʹ�: %d", ReturnRealName(playerid, 0), id);
	}
	else if (!strcmp(type, "type", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
	        return SendClientMessage(playerid, -1, "/editjob [id] [type] [new type]");

        if (typeint < 1 || typeint > 19)
	    	return SendClientMessage(playerid, -1, "����������кص�ͧ���������ҧ 1 �֧ 19");

	    JobData[id][jobType] = typeint;

	    Job_Refresh(id);
	    Job_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ���Ѻ�������ͧ�ҹ�ʹ�: %d �� %d", ReturnRealName(playerid, 0), id, JobData[id][jobType]);
	}
	else if (!strcmp(type, "point", true))
	{
	    new
	        Float:x,
	        Float:y,
	        Float:z;

	    GetPlayerPos(playerid, x, y, z);

		JobData[id][jobPoint][0] = x;
		JobData[id][jobPoint][1] = y;
		JobData[id][jobPoint][2] = z;
        JobData[id][jobPointInt] = GetPlayerInterior(playerid);
        JobData[id][jobPointWorld] = GetPlayerVirtualWorld(playerid);

		Job_Refresh(id);
		Job_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ���Ѻ���˹觢ͧ�ҹ�ʹ�: %d", ReturnRealName(playerid, 0), id);
	}
	else if (!strcmp(type, "deliver", true))
	{
	    if (GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
	        return SendClientMessage(playerid, -1, "�س�������ö�ҧ�ش�Ѵ�������Ҥ����");

	    new
	        Float:x,
	        Float:y,
	        Float:z;

	    GetPlayerPos(playerid, x, y, z);

		JobData[id][jobDeliver][0] = x;
		JobData[id][jobDeliver][1] = y;
		JobData[id][jobDeliver][2] = z;

		Job_Refresh(id);
		Job_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ���Ѻ�ش�Ѵ�觢ͧ�ҹ�ʹ�: %d", ReturnRealName(playerid, 0), id);
	}
	return 1;
}
/*

CMD:jobhelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_GREY, "- Jobhelp -");

	if (Character[playerid][Job] == 1)
	{
    	SendClientMessage(playerid, COLOR_LIGHTRED, "[���觢ͧ]:{FFFFFF} /cargo");
	}
	if(Character[playerid][Job] == 2)
	{
	    SendClientMessage(playerid, COLOR_LIGHTRED, "[��ҧ¹��]:{FFFFFF} /buycomp, /checkcomponents, /service, /colorlist, /paintcar");
	}
	if(Character[playerid][Job] == 3)
	{
	    SendClientMessage(playerid, COLOR_LIGHTRED, "[���Ѵ���]:{FFFFFF} /startlumberjack, /stoplumberjack, /loadwood, /unloadwood, /sellwood");
	}
	if(Character[playerid][Job] == 4)
	{
	    SendClientMessage(playerid, COLOR_LIGHTRED, "[���觼����]:{FFFFFF} /startharvest, /stopharvest, /loadfruit, /unloadfruit, /sellfruit");
	}
	if(Character[playerid][Job] == 5)
	{
	    SendClientMessage(playerid, COLOR_LIGHTRED, "[�մ�����]:{FFFFFF} /startjob, ���� 'N'");
	}
	return 1;
}

*/

//jobcmds
CMD:getjob(playerid, params[])
{
	new
	    id = -1,
		string[128];

	if ((id = Job_Nearest(playerid)) != -1)
	{

	    if (Character[playerid][Job] > 0)
	        return SendClientMessage(playerid, -1, "�س�էҹ��������");

	    if (Character[playerid][Job] == JobData[id][jobType])
	        return SendClientMessage(playerid, -1, "�س�ӧҹ�����������");

	    Character[playerid][Job] = JobData[id][jobType];

        format(string, sizeof(string), "- ��Ѥçҹ %s ���º����\"/leavejob\" �����͡�ҡ�ҹ", Job_GetName(JobData[id][jobType]));
		SendClientMessage(playerid, -1, string);

		if(JobData[id][jobType] == 4)
		{
		    SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "����ǹ �ٴ���: �Թ�յ�͹�Ѻ����Ҫվ '���觼����' �����⪤��");
		    ApplyActorAnimation(Gardener, "GANGS", "prtial_gngtlkA", 4.1, 0, 1, 1, 1, 3000);
			SetTimerEx("StopChattingNPC", 3000, false, "d", Gardener);
		}

		return 1;
	}
    SendClientMessage(playerid, -1, "�س���������㹢ͺࢵ Pickup �ͧ�ҹ");
	return 1;
}

CMD:leavejob(playerid, params[])
{
	if (Character[playerid][Job] != 0)
	{
	    Character[playerid][Job] = 0;
	    SendClientMessage(playerid, -1, "�س���͡�ҹ���º��������!");
	}
	else SendClientMessage(playerid, -1, "�س����էҹ�����͡");
	return 1;
}
//ALTCMD:�͡�ҹ->quitjob;
LeaveJobs(playerid)
{
	Dialog_Show(playerid, Leave_Jobs, DIALOG_STYLE_MSGBOX, "{FFFFFF}Leave Job", "{FFFFFF}�Ҫվ: %s\n�س�էҹ�������Ǥس��ͧ����͡�ҡ�Ҫվ�Ѩ�غѹ�ͧ�س�����?", "�׹�ѹ", "¡��ԡ", Job_GetName(Character[playerid][Job]));
	return 1;
}
Dialog:Leave_Jobs(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		Dialog_Show(playerid, LeaveJob, DIALOG_STYLE_MSGBOX, "{FFFFFF}Leave Job", "{FFFFFF}�س���͡�ҡ�ҹ: %s �������º����", "��ŧ", "¡��ԡ", Job_GetName(Character[playerid][Job]));
		Character[playerid][Job] = 0;
	}
	return 1;
}