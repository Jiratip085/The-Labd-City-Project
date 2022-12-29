CMD:call(playerid, params[])
{
    if(Character[playerid][Phone] == 0)
	    return SendClientMessage(playerid, -1, "�س��������Ѿ��!");

    if (BitFlag_Get(g_PlayerFlags[playerid],PLAYER_PHONE_OFF))
		return SystemMsg(playerid, "�ô�Դ���Ѿ����Ͷ�ͧ͢��ҹ��͹");

    if (BitFlag_Get(g_PlayerFlags[playerid], PLAYER_CUFFED) || Character[playerid][Injured])
	    return SystemMsg(playerid, "�س�������ö��������㹢�й��");

	new
	    targetid,
		number;

	if (sscanf(params, "d", number))
 	   return SystemMsg(playerid, "/call [�����Ţ���Ѿ��] (1222 �������¡�硫��, 911 �����˵ش�ǹ, 223 ���ͺ��촵Դ��С��)");

	if (!number)
	    return SystemMsg(playerid, "�����Ţ����ѧ����Դ���ԡ��");

	if (number == 911)
	{
		Character[playerid][Emergency] = 1;
		PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
		//ApplyAnimationEx(playerid, "PED", "phone_in", 4.1, 0, 0, 0, 1, 0, 1);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);

		SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ��Ժ���Ѿ���͡���������", ReturnName(playerid, 0));
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "[OPERATOR]:{FFFFFF} �س��ͧ����Ѻ��ԡ���?: \"police\" ���� \"medics\"?");
	}
	else if ((targetid = GetNumberOwner(number)) != INVALID_PLAYER_ID)
	{
	    if (targetid == playerid)
	        return SystemMsg(playerid, "�س�������ö���ҵ���ͧ��!");

		if (BitFlag_Get(g_PlayerFlags[targetid], PLAYER_PHONE_OFF))
		    return SystemMsg(playerid, "���������Դ���Ѿ��ͧ��");

		Character[targetid][IncomingCall] = 1;
		Character[playerid][IncomingCall] = 1;

		Character[targetid][CallLine] = playerid;
		Character[playerid][CallLine] = targetid;

		SendClientMessageEx(playerid, COLOR_YELLOW, "[PHONE]:{FFFFFF} ���ѧ���� #%d, �ô�ͻ�������Ѻ...", number);
		SendClientMessageEx(targetid, COLOR_YELLOW, "[PHONE]:{FFFFFF} �����Ҩҡ #%d (��� \"/p\" �����Ѻ���)", Character[playerid][Phone]);

        PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
        PlayerPlaySoundEx(targetid, 23000);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);

		SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ��Ժ���Ѿ���͡���������", ReturnName(playerid, 0));
	}
	else
	{
	    SystemMsg(playerid, "�����Ţ���Ѿ����������Դ���ԡ��");
	}
	return 1;
}

CMD:p(playerid, params[])
	return cmd_answer(playerid, params);

CMD:answer(playerid, params[])
{
	if (!Character[playerid][IncomingCall])
	    return SystemMsg(playerid, "�����������¡��������Ѻ���");

	if (BitFlag_Get(g_PlayerFlags[playerid], PLAYER_CUFFED))
	    return SystemMsg(playerid, "�س�������ö�����觹����㹢�й��");

    if (BitFlag_Get(g_PlayerFlags[playerid],PLAYER_PHONE_OFF))
    	return SystemMsg(playerid, "�س��ͧ�Դ����ͧ���Ѿ���͹");

	new targetid = Character[playerid][CallLine];

	Character[playerid][IncomingCall] = 0;
	Character[targetid][IncomingCall] = 0;

	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);

	SendClientMessage(playerid, COLOR_YELLOW, "[SERVER]:{FFFFFF} �س�Ѻ������¡�������");
	SendClientMessage(targetid, COLOR_YELLOW, "[SERVER]:{FFFFFF} ��»��·ҧ���Ѻ�������");

	SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ���Ѻ��·�����¡���", ReturnName(playerid, 0));
	return 1;
}

CMD:h(playerid, params[])
	return cmd_hangup(playerid, params);


CMD:hangup(playerid, params[])
{
	new targetid = Character[playerid][CallLine];

	if (Character[playerid][Emergency])
	{
	    Character[playerid][Emergency] = 0;

        SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ���ҧ������Ѿ��ͧ��", ReturnName(playerid, 0));
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		return 1;
	}
	if (targetid == INVALID_PLAYER_ID)
	    return SystemMsg(playerid, "����������Ҥس");

	if (Character[playerid][IncomingCall])
	{
	    SendClientMessage(playerid, COLOR_YELLOW, "[PHONE]:{FFFFFF} �س�Ѵ������¡���");
	    SendClientMessage(targetid, COLOR_YELLOW, "[PHONE]:{FFFFFF} ��»��·ҧ�Ѵ��·��");
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		SetPlayerSpecialAction(targetid, SPECIAL_ACTION_STOPUSECELLPHONE);

		SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ��Ѵ������¡���", ReturnName(playerid, 0));
	}
	else
	{
        SendClientMessage(playerid, COLOR_YELLOW, "[PHONE]:{FFFFFF} �س�ҧ��¡����");
	    SendClientMessage(targetid, COLOR_YELLOW, "[PHONE]:{FFFFFF} ��»��·ҧ���ҧ�ҡ���������");

        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		SetPlayerSpecialAction(targetid, SPECIAL_ACTION_STOPUSECELLPHONE);

	    SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ���ҧ������Ѿ��ͧ��", ReturnName(playerid, 0));
	    SendNearbyMessage(targetid, 30.0, COLOR_RP, "** %s ���ҧ������Ѿ��ͧ��", ReturnName(targetid, 0));
	}
	Character[playerid][IncomingCall] = 0;
	Character[targetid][IncomingCall] = 0;

	Character[playerid][CallLine] = INVALID_PLAYER_ID;
	Character[targetid][CallLine] = INVALID_PLAYER_ID;

	return 1;
}

CMD:phone(playerid, params[])
{
	if(Character[playerid][Phone] == 0)
	    return SendClientMessage(playerid, -1, "�س��������Ѿ��!");

    if (BitFlag_Get(g_PlayerFlags[playerid], PLAYER_CUFFED) || Character[playerid][Injured])
	    return SystemMsg(playerid, "�س�������ö�����觹����");

	new
	    str[32];

	format(str, sizeof(str), "Phone (#%d)", Character[playerid][Phone]);

	if (BitFlag_Get(g_PlayerFlags[playerid],PLAYER_PHONE_OFF)) {
		Dialog_Show(playerid, MyPhone, DIALOG_STYLE_LIST, str, "���͡\n��ª��ͼ��Դ���\n�觢�ͤ���\n�Դ���Ѿ��", "���͡", "¡��ԡ");
	}
	else {
	    Dialog_Show(playerid, MyPhone, DIALOG_STYLE_LIST, str, "���͡\n��ª��ͼ��Դ���\n�觢�ͤ���\n�Դ���Ѿ��", "���͡", "¡��ԡ");
	}
	return 1;
}

CMD:r(playerid, params[])
	return cmd_radio(playerid, params);

CMD:radio(playerid, params[])
{
	if (isnull(params))
	    return SendClientMessage(playerid, -1, "/radio [Radio IC]");

	if (!Character[playerid][Channel])
	    return SendClientMessage(playerid, -1, "�س�ѧ����դ����Է����");

	new
	    string[128];

    if(Character[playerid][Channel] == 911 && Character[playerid][FactionID] != FACTION_POLICE)
	{
	    Character[playerid][Channel] = 0;
	    Character[playerid][ChannelSlot] = 0;
		SendClientMessage(playerid, -1, "����繤��蹢ͧ���˹�ҷ����Ǩ��ҹ��");
		return 1;
	}

	if (strlen(params) > 64)
	{
		format(string, sizeof(string), "**[CH: %d S: %d] %s: %.64s",Character[playerid][Channel], Character[playerid][ChannelSlot], ReturnName(playerid, 0), params);
		SendRadioMessage(playerid, string);
		format(string, sizeof(string), "...%s **",params[64]);
		SendRadioMessage(playerid, string);

	}
	else {
		format(string, sizeof(string),"**[CH: %d S: %d] %s: %s", Character[playerid][Channel], Character[playerid][ChannelSlot], ReturnName(playerid, 0), params);
		SendRadioMessage(playerid, string);


	}
	format(string, sizeof(string),"(Radio) %s: %s", ReturnName(playerid, 0), params);
	SetPlayerChatBubble(playerid, string, COLOR_RP, 20.0, 6000);
	return 1;
}

CMD:setchannel(playerid, params[])
{
	new channel,
		slot,
		string[128];

	if(Character[playerid][PortableRadio] == 0)
		return SendClientMessage(playerid, -1, "�س������Է��");

	if (sscanf(params, "dd", slot, channel))
		return SendClientMessage(playerid, -1, "/setchannel [slot] [channel]");

	if(channel < 1 || channel > 1000)
		return SendClientMessage(playerid, -1, "��ͧ��ͧ����ӡ��� 1 �����ҡ���� 1000");

	if(slot < 1 || slot > MAX_SLOTRAD)
	{
 		format(string, sizeof(string), "���͵��ͧ����ӡ��� 1 �����ҡ���� %d", MAX_SLOTRAD);
		SendClientMessage(playerid, -1, string);
	}

	if(channel == 911 && Character[playerid][FactionID] != FACTION_POLICE)
		return SendClientMessage(playerid, -1, "����繤��蹢ͧ���˹�ҷ����Ǩ��ҹ��");

	ConnectRadio(playerid, slot, channel);
	return 1;
}

//��������
CMD:bandage(playerid, params[])
{
    new
	    userid;

	if (GetFactionType(playerid) != FACTION_MEDIC)
	    return SystemMsg(playerid, "�س��ͧ����ǹ˹�觢ͧ�������͡�������ᾷ��");

	if (sscanf(params, "u", userid))
	    return SystemMsg(playerid, "/bandage [playerid/name]");

	if (userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 6.0))
	    return SystemMsg(playerid, "�����蹹�鹵Ѵ���������������������������س");

	if (userid == playerid)
	    return SystemMsg(playerid, "�س�������ö�����觹��Ѻ����ͧ��");

	if (Character[userid][FirstAid])
	    return SystemMsg(playerid, "�����蹹����������Ҿѹ������");

    if (ReturnHealth(userid) > 99)
	    return SystemMsg(playerid, "�����蹹������ͧ��ü�Ҿѹ��");

    Character[userid][FirstAid] = true;
    Character[userid][AidTimer] = SetTimerEx("FirstAidUpdate", 1000, true, "d", userid);

    SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s �Դ�ش�����Һ��������Ҿѹ�šѺ %s", ReturnName(playerid, 0), ReturnName(userid, 0));
    return 1;
}

//����觵��Ǩ


CMD:uncuff(playerid, params[])
{
    new
	    userid;

	if (GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, -1, "�س��ͧ�����˹�ҷ����Ǩ");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, -1, "/uncuff [playerid/name]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, -1, "�����蹹����Ѵ���������������");

    if (userid == playerid)
	    return SendClientMessage(playerid, -1, "�س�������ö�Ŵ�ح���͵���ͧ��");

    if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, -1, "�س��ͧ�����������蹹��");

    if (!BitFlag_Get(g_PlayerFlags[userid],PLAYER_CUFFED))
        return SendClientMessage(playerid, -1, "�����蹹�������١���ح����㹢�й��");

	new
	    string[64];

    BitFlag_Off(g_PlayerFlags[userid],PLAYER_CUFFED);
    SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);
    RemovePlayerAttachedObject(userid, 4);

	format(string, sizeof(string), "You've been ~g~uncuffed~w~ by %s.", ReturnName(playerid, 0));
    ShowPlayerFooter(userid, string);

    SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ��ح�������Ѻ�����ͧ͢ %s", ReturnName(playerid, 0), ReturnName(userid, 0));
    return 1;
}

CMD:m(playerid, params[])
	return cmd_megaphone(playerid, params);

CMD:megaphone(playerid, params[])
{
	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC)
	    return SendClientMessage(playerid, -1, "�س�������ö��������");

	if (isnull(params))
	    return SendClientMessage(playerid, -1, "/(m)egaphone [message]");

	if (strlen(params) > 64) {
	    SendNearbyMessage(playerid, 30.0, COLOR_HOTORANGE, "(����) %s �ٴ���: %.64s", ReturnName(playerid, 0), params);
	    SendNearbyMessage(playerid, 30.0, COLOR_HOTORANGE, "...%s", params[64]);
	}
	else {
	    SendNearbyMessage(playerid, 30.0, COLOR_HOTORANGE, "(����) %s �ٴ���: %s", ReturnName(playerid, 0), params);
	}
	return 1;
}

CMD:showbadge(playerid, params[])
{
	new
	    userid,
	    string[128];

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, -1, "/showbadge [playerid/name]");

	if (userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, -1, "�����蹹�鹵Ѵ���������������������������س");

    if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV && GetFactionType(playerid) != FACTION_NEWS)
        return SendClientMessage(playerid, -1, "�س��ͧ�����˹�ҷ���Ѱ");

	SendClientMessage(userid, COLOR_GREY, "-----------------------------------------------------------");

    format(string, sizeof(string), " [%s] ", Faction_GetName(playerid));
    SendClientMessageEx(userid, COLOR_LIGHTBLUE, string);
    format(string, sizeof(string), " ����: %s", ReturnName(playerid, 0));
    SendClientMessageEx(userid, COLOR_LIGHTBLUE, string);
    format(string, sizeof(string), " ���˹�: %s", Faction_GetRank(playerid));
	SendClientMessageEx(userid, COLOR_LIGHTBLUE, string);

	SendClientMessage(userid, COLOR_GREY, "-----------------------------------------------------------");
    SendNearbyMessage(playerid, 30.0, COLOR_RP, "* %s �ʴ���һ�Шӵ�ǡѺ %s", ReturnName(playerid, 0), ReturnName(userid, 0));
	return 1;
}

CMD:d(playerid, params[])
{
    new
	    string[128];

	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV)
	    return SendClientMessage(playerid, -1, "�س�е�ͧ�繼�黯Ժѵԧҹ����Ҫ��þ����͹");

	if (isnull(params))
	    return SendClientMessage(playerid, -1, "/d [department radio]");

	for (new i = 0; i != MAX_FACTIONS; i ++) if (FactionData[i][factionType] == FACTION_POLICE || FactionData[i][factionType] == FACTION_MEDIC || FactionData[i][factionType] == FACTION_GOV) {
		SendFactionMessage(i, COLOR_DEPARTMENT, "** [%s] %s %s: %s **", GetInitials(Faction_GetName(playerid)), Faction_GetRank(playerid), ReturnName(playerid, 0), params);

		format(string, sizeof(string), "*[Radio] %s %s", ReturnName(playerid, 0), params);
 		SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
	}
	Log_Write("logs/faction_chat.txt", "[%s] [/d] %s %s: %s", ReturnDate(), Faction_GetRank(playerid), ReturnRealName(playerid, 0), params);
	return 1;
}

CMD:carsign(playerid, params[])
{
    new vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);
	new string[32];
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, "�س�����������ҹ��˹�");

	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC)
		return SendClientMessage(playerid, -1, "�س�е�ͧ�����˹�ҷ����Ǩ");

	if (!IsACruiser(GetPlayerVehicleID(playerid)))
	    return SendClientMessage(playerid, -1, "�س�е�ͧ�����ö�Ҵ����ǹ�ͧ���Ǩ");

	if(sscanf(params, "s[32]",string)) return SendClientMessage(playerid, -1, "�س��ͧ��͹�ѭ�ҳ���¡�ҹ");
	if(vehiclecallsign[GetPlayerVehicleID(playerid)] == 0)
	{
		vehicle3Dtext[vehicleid] = Create3DTextLabel(string, COLOR_WHITE, 0.0, 0.0, 0.0, 50.0, 0, 1);
		Attach3DTextLabelToVehicle( vehicle3Dtext[vehicleid], vehicleid, -0.7, -1.9, -0.3);
		//Attach3DTextLabelToVehicle(vehicle3Dtext[vehicleid], vehicleid, 0.0, -2.8, 0.0);
		SendClientMessage(playerid, -1, "�ѭ�ҳ���¡�ҹ�١��͹���º��������");
		SendClientMessage(playerid, -1, "�� (/remove_carsign) ����ź");
		vehiclecallsign[vehicleid] = 1;
	}
	return 1;
}

CMD:remove_carsign(playerid, params[])
{
    new vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, "�س�����������ҹ��˹�");
	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC)
		return SendClientMessage(playerid, -1, "�س�е�ͧ�����˹�ҷ����Ǩ");

	if (!IsACruiser(GetPlayerVehicleID(playerid)))
	    return SendClientMessage(playerid, -1, "�س�е�ͧ�����ö�Ҵ����ǹ�ͧ���Ǩ");

    if(vehiclecallsign[GetPlayerVehicleID(playerid)] == 1)
	{
 		Delete3DTextLabel(vehicle3Dtext[vehicleid]);
	    vehiclecallsign[vehicleid] = 0;
	    SendClientMessage(playerid, COLOR_RED, "�ѭ�ҳ���¡�ҹ�١ź");
	    return 1;
	}
	return 1;
}

CMD:acceptdeath(playerid, params[])
{
	new
	    string[128];

    if (!Character[playerid][Injured])
	    return SendClientMessage(playerid, -1, "�س�ѧ������Ѻ�Ҵ��㹢�й��");

	if (Character[playerid][InjuredEx] == 1)
	    return SendClientMessage(playerid, -1, "�س�������!");

    if (Character[playerid][InjuredTime] > 0)
    {
		format(string, sizeof(string), "�س��ͧ���ա %d �Թҷ�����������!", Character[playerid][InjuredTime]);
		SendClientMessage(playerid, -1, string);
		return 1;
	}

	SendClientMessage(playerid, COLOR_YELLOW, "�س�������Ǿ���� /respawnme �����Դ����");
	Character[playerid][InjuredTime] += 5;
	Character[playerid][InjuredEx]= 1;

	if(IsDamageShow{playerid})
	{
		AC_SetPlayerHealth(playerid, 100);
		UpdateDynamic3DTextLabelText(DamageLabel[playerid], COLOR_LIGHTRED, "(( �����蹹�������� ))");
	}
	return 1;
}

CMD:respawnme(playerid, params[])
{
    new
	    string[128];

    if (!Character[playerid][Injured])
	    return SendClientMessage(playerid, -1, "�س�ѧ������Ѻ�Ҵ��㹢�й��");

    if (Character[playerid][InjuredEx] != 1)
	    return SendClientMessage(playerid, -1, "�س�ѧ�����㹢�й��!");

    if (Character[playerid][InjuredTime] > 0)
    {
		format(string, sizeof(string), "�س��ͧ���ա %d �Թҷ����ͨ���Դ����!", Character[playerid][InjuredTime]);
		SendClientMessage(playerid, -1, string);
		return 1;
	}
	
    AC_SetPlayerHealth(playerid, 0);
	ClearAnimations(playerid);
	ResetDamages(playerid);
	Character[playerid][Injured] = 1;
	Character[playerid][InjuredTime] = 0;
	Character[playerid][InjuredEx]= 0;
	Character[playerid][InjuredShoot] = 0;
	return 1;
}

CMD:damages(playerid, params[])
{
	new targetid, string[2014], count, stringarmor[32];

	if (sscanf(params, "u", targetid))
		return SendClientMessage(playerid,-1, "/damages [playerid/name]");

	if (targetid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, targetid, 3.0))
	{
		SendClientMessage(playerid,-1, "�����蹹�鹵Ѵ���������������������������س");
		return 1;
	}

	for(new i = 0; i < MAX_DAMAGES; i++)
	{
	    if(DamageData[targetid][i][dExists])
		{
		    if(DamageData[targetid][i][dArmour] == 1)
			{
			    stringarmor = "ⴹ";
			}
			if(DamageData[targetid][i][dArmour] == 0)
			{
			    stringarmor = "���ⴹ";
			}

			format(string, sizeof(string), "%s ����� %d �ҡ %s ⴹ%s (����: %s) %d �Թҷ�����ҹ��\n", string, DamageData[targetid][i][dDamage], ReturnWeaponName(DamageData[targetid][i][dWeaponid]), GetBodyPartName(DamageData[targetid][i][dShotType]), stringarmor, gettime()-DamageData[targetid][i][dSec]);
			count++;
		}
	}
	return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_LIST, ReturnName(targetid), (count) ? (string) : (" "), "Close", "");
}

CMD:properties(playerid, params[])
{
	new count;

	for (new i = 0; i < MAX_HOUSES; i ++) if (House_IsOwner(playerid, i)) {
    	SendClientMessageEx(playerid, COLOR_WHITE, "| ��ҹ�ʹ�: [%d] | �������: [%s] | ���˹觷����: [%s]", i, HouseData[i][houseAddress], GetLocation(HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2]));
    	count++;
	}
	for (new i = 0; i < MAX_BUSINESSES; i ++) if (Business_IsOwner(playerid, i) && BusinessData[i][bizOwner] != 99999999) {
	    SendClientMessageEx(playerid, COLOR_WHITE, "| ��áԨ�ʹ�: [%d] | ���͡Ԩ���: [%s] | ���˹觷����: [%s]", i, BusinessData[i][bizName], GetLocation(BusinessData[i][bizPos][0], BusinessData[i][bizPos][1], BusinessData[i][bizPos][2]));
	    count++;
	}
	if (!count)
	    return SystemMsg(playerid, "�س���������Ңͧ��ѧ�������Ѿ��� �");

	return 1;
}

CMD:bank(playerid, params[])
{
	new amount,
	    string[128];

    if (!IsPlayerInBank(playerid))
	    return SendClientMessage(playerid, COLOR_GREY, "�س���������㹢ͺࢵ�ͧ��Ҥ��");

    if (sscanf(params, "d", amount))
    {
		SendClientMessage(playerid, COLOR_GREY, "USAGE: /bank [amount]");
		format(string, sizeof(string), "�س�� $%d ����㹺ѭ��", Character[playerid][Bank]);
		SendClientMessage(playerid, COLOR_GREY, string);
		return 1;
	}

	if(Character[playerid][Cash] < amount)
		return SendClientMessage(playerid, -1, "�س������Թ�ͷ��нҡ");

	if(Character[playerid][Savings] > 0)
	    return SendClientMessage(playerid, -1, "�س�Դ�ѭ�������Ѿ�������������ö����");

	Character[playerid][Bank] += amount;
	Character[playerid][Cash] -= amount;
	GivePlayerMoney(playerid, -amount);

	format(string, sizeof(string), "�س��ҡ�Թ�ӹǹ %d", amount);
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:savings(playerid, params[])
{
	new amount,
	    string[128];

    if (!IsPlayerInBank(playerid))
	    return SendClientMessage(playerid, COLOR_GREY, "�س���������㹢ͺࢵ�ͧ��Ҥ��");

    if (sscanf(params, "d", amount))
    {
		SendClientMessage(playerid, COLOR_GREY, "USAGE: /savings [amount]");
		SendClientMessage(playerid, -1, "�س������������������Դ�ѭ�������Ѿ��");
		SendClientMessage(playerid, -1, "�ҡ�س�Դ�ѭ�������Ѿ��س����ѭ�ո�Ҥ�������");
		SendClientMessage(playerid, -1, "���������Ǿ�������� /savings [�ӹǹ�Թ] �����Դ��");
		return 1;
	}

	if(Character[playerid][Cash] < amount)
		return SendClientMessage(playerid, -1, "�س������Թ�ͷ��нҡ");

	if(Character[playerid][Savings] > 0)
		return SendClientMessage(playerid, -1, "�س�Դ�ѭ�������Ѿ�������");

	Character[playerid][Savings] += amount;
	Character[playerid][Cash] -= amount;
	GivePlayerMoney(playerid, -amount);

	format(string, sizeof(string), "�س��ҡ�Թ��Һѭ�������Ѿ��ͧ�س�繨ӹǹ�Թ %d", amount);
	SendClientMessage(playerid, -1, string);
	SendClientMessage(playerid, -1, "��ҵ�ͧ���¡��ԡ�ѭ�������Ѿ������ /savingswithdraw");
	return 1;
}

CMD:savingswithdraw(playerid, params[])
{
    new amount;

    if (!IsPlayerInBank(playerid))
	    return SendClientMessage(playerid, COLOR_GREY, "�س���������㹢ͺࢵ�ͧ��Ҥ��");

    if(Character[playerid][Savings] < amount)
		return SendClientMessage(playerid, -1, "�Թ㹺ѭ�������Ѿ�������§��");

    Dialog_Show(playerid, Savingswithdraw, DIALOG_STYLE_MSGBOX, "����׹�ѹ", "�س����������������ж͹�Թ�����Ѿ���͡��\n�ҡ�͹�͡�Ҥس�е�ͧ���������", "��ŧ", "¡��ԡ");
	return 1;
}

CMD:withdraw(playerid, params[])
{
    new amount,
	    string[128];

    if (!IsPlayerInBank(playerid))
	    return SendClientMessage(playerid, COLOR_GREY, "�س���������㹢ͺࢵ�ͧ��Ҥ��");

    if (sscanf(params, "d", amount))
    {
		SendClientMessage(playerid, COLOR_GREY, "USAGE: /withdraw [amount]");
		format(string, sizeof(string), "�س�� $%d ����㹺ѭ��", Character[playerid][Bank]);
		SendClientMessage(playerid, COLOR_GREY, string);
		return 1;
	}

	if(Character[playerid][Bank] < amount)
		return SendClientMessage(playerid, -1, "�Թ㹺ѭ�������§��");

	Character[playerid][Bank] -= amount;
	Character[playerid][Cash] += amount;
	GivePlayerMoney(playerid, amount);

	format(string, sizeof(string), "�س��͹�Թ�ӹǹ %d", amount);
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:balance(playerid, params[])
{
	new
	    string[128];

	if (!IsPlayerInBank(playerid))
 		return SendClientMessage(playerid, COLOR_GREY, "�س���������㹢ͺࢵ�ͧ��Ҥ��");

    format(string, sizeof(string), "�س�� $%d ����㹺ѭ��", Character[playerid][Bank]);
	SendClientMessage(playerid, COLOR_YELLOW, string);
	return 1;
}

CMD:storage(playerid, params[])
{
	new
	    houseid = -1;

	if ((houseid = House_Inside(playerid)) != -1 && (House_IsOwner(playerid, houseid) || GetFactionType(playerid) == FACTION_POLICE)) {
	    House_OpenStorage(playerid, houseid);
	}
	else SystemMsg(playerid, "�س���������㹢ͺࢵ���㹺�ҹ�ͧ�س");
	return 1;
}

CMD:buylevel(playerid, params[])
{
	new string[128];



	if(Character[playerid][Level] >= 0)
	{
		new nxtlevel = Character[playerid][Level]+1;
		new costlevel = nxtlevel*levelcost;//10k for testing purposes
		new expamount = nxtlevel*levelexp;
		if(Character[playerid][Cash] < costlevel)
		{
			format(string, sizeof(string), "   �س���Թ���� ($%d) !",costlevel);
			SendClientMessage(playerid, COLOR_GREY, string);
			return 1;
		}
		else if(Character[playerid][Exp] < expamount)
		{
			format(string, sizeof(string), "   �س��ͧ�դ�һ��ʺ��ó� %d ��Фس�� %d !",expamount,Character[playerid][Exp]);
			SendClientMessage(playerid, COLOR_GREY, string);
			return 1;
		}
		else
		{
			format(string, sizeof(string), "~r~Level up~n~~w~level %d", nxtlevel);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			Character[playerid][Cash] = Character[playerid][Cash]-costlevel;
			GivePlayerMoney(playerid, (0 - costlevel));
			Character[playerid][Level]++;

			Character[playerid][Exp] -= expamount;

			GameTextForPlayer(playerid, string, 5000, 1);
		}
	}
	return 1;
}

CMD:binfo(playerid, params[])
{
    new
		id = -1;

    if ((id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1 && Business_IsOwner(playerid, id)) {
     	SendClientMessageEx(playerid, -1,"ID: %d | Business: %s | Products: %d | Vault: %s", id, BusinessData[id][bizName], BusinessData[id][bizProducts], FormatNumber(BusinessData[id][bizVault]));
	}
	else SendClientMessage(playerid, -1,"�س���������㹢ͺࢵ�ͧ��áԨ");
	return 1;
}

CMD:bname(playerid, params[])
{
	new
		id = -1;

    if ((id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1 && Business_IsOwner(playerid, id))
	{
		if (isnull(params))
		    return SystemMsg(playerid, "/bname [new name]");

		if (strlen(params) > 32)
		    return SystemMsg(playerid, "���͸�áԨ������ҡ���� 32 ����ѡ��");

		format(BusinessData[id][bizName], 32, params);

		Business_Refresh(id);
		Business_Save(id);

		SendClientMessageEx(playerid, -1,"���͸�áԨ�١��駤����: \"%s\"", params);
	}
	else SystemMsg(playerid, "�س���������㹢ͺࢵ�ͧ��áԨ�ͧ�س");
	return 1;
}

CMD:bmessage(playerid, params[])
{
	new
		id = -1;

    if ((id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1 && Business_IsOwner(playerid, id))
	{
		if (isnull(params))
		    return SystemMsg(playerid, "/bmessage [message] - Use \"none\" to disable.");

		if (!strcmp(params, "none", true))
		{
		    BusinessData[id][bizMessage][0] = '\0';

			Business_Save(id);
			SendClientMessage(playerid, -1,"�س��ź��ͤ����ͧ��áԨ");
		}
		else
		{
			format(BusinessData[id][bizMessage], 128, params);

			Business_Save(id);
			SendClientMessageEx(playerid, -1,"��ͤ�����áԨ�١��駤����: \"%s\"", params);
		}
	}
	else SystemMsg(playerid, "�س���������㹢ͺࢵ�ͧ��áԨ�ͧ�س");
	return 1;
}

CMD:bizchlp(playerid, params[])
{
	SendClientMessage(playerid, COLOR_CLIENT, "BUSINESSES:{FFFFFF} /buy, /abandon, /lock, /vault, /products, /binfo, /bname");
	return 1;
}

CMD:househelp(playerid, params[])
{
	SendClientMessage(playerid, COLOR_WHITE, "[House Help]");
	SendClientMessage(playerid, COLOR_CLIENT, "HOUSES:{FFFFFF} /buy, /abandon, /lock, /storage");
    SendClientMessage(playerid, COLOR_GREY, "-'/myfurniture' ���ʹ� Furniture ��������");
    SendClientMessage(playerid, COLOR_GREY, "-'/furniture' ���ͷӡ�û�Ѻ����������ͷ�� Furniture");
    SendClientMessage(playerid, COLOR_GREY, "-'/fpickup' �� Furniture ����Ҩҡ���");
	return 1;
}

CMD:boombox(playerid, params[])
{
	new
	    type[24],
	    string[128];

	if(Character[playerid][BoomboxEx] == 0)
	    return SendClientMessage(playerid, -1, "�س����� Boombox");

	if (sscanf(params, "s[24]S()[128]", type, string))
	{
	    SystemMsg(playerid, "/boombox [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} place, pickup, url");
	    return 1;
	}
	if (!strcmp(type, "place", true))
	{
	    if (BoomboxData[playerid][boomboxPlaced])
	        return SystemMsg(playerid, "�س���ҧ Boombox ����");

		if (Boombox_Nearest(playerid) != INVALID_PLAYER_ID)
		    return SystemMsg(playerid, "�س����㹢ͺࢵ�ͧ Boombox ���");

		if (IsPlayerInAnyVehicle(playerid))
		    return SystemMsg(playerid, "�س��ͧ�͡�ҡ�ҹ��˹С�͹");

		new id;
  		if ((id = Entrance_Inside(playerid)) != -1 && EntranceData[id][entranceType] == 6)
  		    return SystemMsg(playerid, "�س�������ö�ҧ Boombox 㹾�鹷������");

		Boombox_Place(playerid);

		SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ��Ժ Boombox �͡����е���ѹŧ", ReturnName(playerid, 0));
		SendClientMessage(playerid, -1,"�س���ҧ Boombox �ͧ�س (�� \"/boombox\" ����Ѻ������͡)");
	}
	else if (!strcmp(type, "pickup", true))
	{
	    if (!BoomboxData[playerid][boomboxPlaced])
	        return SystemMsg(playerid, "�س�ѧ������� Boombox");

		if (!IsPlayerInRangeOfPoint(playerid, 3.0, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2]))
		    return SystemMsg(playerid, "�س���������㹢ͺࢵ Boombox �ͧ�س");

		Boombox_Destroy(playerid);
		SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ��������Ժ Boombox �ͧ�Ң��", ReturnName(playerid, 0));
	}
	else if (!strcmp(type, "url", true))
	{
	    if (sscanf(string, "s[128]", string))
	        return SystemMsg(playerid, "/boombox [url] [song url]");

        if (!BoomboxData[playerid][boomboxPlaced])
	        return SystemMsg(playerid, "�س�ѧ������� Boombox");

		if (!IsPlayerInRangeOfPoint(playerid, 3.0, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2]))
		    return SystemMsg(playerid, "�س���������㹢ͺࢵ Boombox �ͧ�س");

		Boombox_SetURL(playerid, string);
		SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ����¹����������� Boombox ��ѧʶҹ����", ReturnName(playerid, 0));
	}
	return 1;
}

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

CMD:approve(playerid, params[])
{
    if (isnull(params))
 	{
	 	SendClientMessage(playerid, -1, "/approve [name]");
		SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} mechanic, faction");
		return 1;
	}

	if (!strcmp(params, "mechanic", true) && Character[playerid][MecOffer] != INVALID_PLAYER_ID)
	{
	    new
			mecid = Character[playerid][MecOffer],
			type = Character[mecid][MecType],
			carindex = Car_GetID(Character[mecid][MecCar]);

		if(carindex != -1 && GetPlayerVehicleID(mecid) == Character[mecid][MecTow])
		{
			new
			    vehicleid = CarData[carindex][carVehicle],
				price = Character[mecid][MecPrice];

			new fixname[64];

			if (!IsPlayerNearPlayer(playerid, mecid, 10.0))
			    return SendClientMessage(playerid, -1, "�س����������������蹹��");

			if(Character[playerid][Cash] < price)
			    return SendClientMessage(playerid, -1, "�س���Թ�����§��");

			switch(type)
			{
			    case 1:
				{
					new Float:vhealth;

					GetVehicleHealth(vehicleid, vhealth);

					Character[mecid][MecProd] = floatround( floatdiv(1000-vhealth, 15) );
					format(fixname, sizeof(fixname), "��������ͧ¹��");
				}
			    case 2:
				{
				    new fixnum;

				    for(new i = 0; i < 4; i++)
				    {
						if(CarData[carindex][carDamage][i])
						    fixnum++;
					}
					Character[mecid][MecProd] = fixnum*12;

					format(fixname, sizeof(fixname), "������Ƕѧ");
				}
			    case 3: {
			        Character[mecid][MecProd] = floatround(500-CarData[carindex][carBatteryL]/20);
					format(fixname, sizeof(fixname), "����ẵ�����");
				}
			    case 4:
				{
				    Character[mecid][MecProd] = floatround(500-CarData[carindex][carEngineL]/20);
					format(fixname, sizeof(fixname), "��鹿�����ͧ¹��");
				}
			    case 5:
				{
				    Character[mecid][MecProd] = 30;
					format(fixname, sizeof(fixname), "����¹��");
				}
			}

			SendNearbyMessage(playerid, 20.0, COLOR_RP, "* %s ��͹حҵ���� %s ���� %s %s", ReturnName(playerid, 0), ReturnName(mecid, 0), fixname, ReturnVehicleName(Character[mecid][MecCar]));

			Character[mecid][MecStep] = 1;

			ShowPlayerFooter(mecid, "~p~Pull out your spraycan.");
			GivePlayerWeapon(mecid, 41, 99999);
		}
		else SendClientMessage(playerid, -1, "��ҧ¹�������������ػ�ó����躹 Tow Truck �ͧ��");
	}
	if (!strcmp(params, "faction", true) && Character[playerid][FactionOffer] != INVALID_PLAYER_ID)
	{
	    new
	        targetid = Character[playerid][FactionOffer],
	        factionid = Character[playerid][FactionOffered];

		if (!FactionData[factionid][factionExists] || Character[targetid][FactionRank] < FactionData[Character[targetid][Faction]][factionRanks] - 1)
	   	 	return SendClientMessage(playerid, -1, "����ʹͽ������͡�����������ö��ҹ��");

		SetFaction(playerid, factionid);
		Character[playerid][FactionRank] = 1;

		SendClientMessageEx(playerid, -1, "�س������Ѻ����ʹ� %s ����������� \"%s\"", ReturnName(targetid, 0), Faction_GetName(targetid));
		SendClientMessageEx(targetid, -1, "%s ������Ѻ����ʹͧ͢�س����������� \"%s\"", ReturnName(playerid, 0), Faction_GetName(targetid));

        Character[playerid][FactionOffer] = INVALID_PLAYER_ID;
        Character[playerid][FactionOffered] = -1;
	}
	return 1;
}

CMD:abandon(playerid, params[])
{
	new
	    id = -1;

    if (!IsPlayerInAnyVehicle(playerid) && (id = House_Nearest(playerid)) != -1 && House_IsOwner(playerid, id))
	{
	    if (isnull(params) || (!isnull(params) && strcmp(params, "confirm", true) != 0))
	    {
	        SendClientMessage(playerid, -1, "/abandon [confirm]");
	        SendClientMessage(playerid, COLOR_LIGHTRED, "[WARNING]:{FFFFFF} �س���ѧ�з�駺�ҹ�ͧ�س������ա�ä׹�Թ");
		}
		else if (!strcmp(params, "confirm", true))
		{
			HouseData[id][houseOwner] = 0;

			House_Refresh(id);
			House_Save(id);

			SendClientMessageEx(playerid, -1, "�س���駺�ҹ�ͧ�س: %s", HouseData[id][houseAddress]);
			Log_Write("logs/house_log.txt", "[%s] %s has abandoned house ID: %d.", ReturnDate(), ReturnRealName(playerid), id);
		}
		return 1;
	}
	else if (!IsPlayerInAnyVehicle(playerid) && (id = Business_Nearest(playerid)) != -1 && Business_IsOwner(playerid, id))
	{
	    if (isnull(params) || (!isnull(params) && strcmp(params, "confirm", true) != 0))
	    {
	        SendClientMessage(playerid, -1, "/abandon [confirm]");
	        SendClientMessage(playerid, COLOR_LIGHTRED, "[WARNING]:{FFFFFF} �س���ѧ�з�駸�áԨ�ͧ�س������ա�ä׹�Թ");
		}
		else if (!strcmp(params, "confirm", true))
		{
			BusinessData[id][bizOwner] = 0;

			Business_Refresh(id);
			Business_Save(id);

			SendClientMessageEx(playerid, -1, "�س���駸�áԨ�ͧ�س: %s.", BusinessData[id][bizName]);
			Log_Write("logs/biz_log.txt", "[%s] %s has abandoned business ID: %d.", ReturnDate(), ReturnRealName(playerid), id);
		}
		return 1;
	}
	else SendClientMessage(playerid, -1, "�س���������������á������س����ö�����");
	return 1;
}

/*CMD:enter(playerid, params[])
{
    new
    	id = -1,
    	string[128];

    if ((id = House_Nearest(playerid)) != -1)
  	{
   		if (HouseData[id][houseLocked])
     		return SendClientMessage(playerid, -1, "�س�������ö��Һ�ҹ�����ͤ��");

		SetPlayerPosEx(playerid, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2], HouseData[id][houseInterior], HouseData[id][houseID] + 5000);
		SetPlayerFacingAngle(playerid, HouseData[id][houseInt][3]);

		SetCameraBehindPlayer(playerid);
		Character[playerid][House] = HouseData[id][houseID];
		return 1;
	}

	if ((id = Entrance_Nearest(playerid)) != -1)
 	{
  		if (EntranceData[id][entranceLocked])
    		return SendClientMessage(playerid, -1, "�ҧ��ҹ��١��ͤ㹢�й��");

		if (Character[playerid][Task])
		{
			if (EntranceData[id][entranceType] == 2 && !Character[playerid][BankTask])
			{
      			Character[playerid][BankTask] = 1;
	    		Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Banking", "��˹��� Bank �ͧ San Andreas �س����ö�Ѵ��áѺ�ѭ�ո�Ҥ�äس������\n���������Ф��պѭ�ո�Ҥ�÷�����ҵðҹ��С�ýҡ�Թ���ͨ����Ѻ�Թ�����\n\n�س����ö�� /bank ��ҧ��Ҥ�����ͨѴ������úҧ���ҧ����Ǻѭ�բͧ�س\n�ҡ�س�����������ͧ ATM �س����ö�� /atm ���ʹ٤���觷��س��ͧ���", "Close", "");

				if (IsTaskCompleted(playerid))
				{
    				Character[playerid][Task] = 0;
				}
			}
			else if (EntranceData[id][entranceType] == 1 && !Character[playerid][TestTask])
			{
  				Character[playerid][TestTask] = 1;
	    		Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "DMV", "DMV �繷��������蹾��������з��ͺ��âѺ������ͨ����Ѻ�͹حҵ\n�س�е�ͧ�ź��ա��觡մ��ҧ��������������ͤ�������㹢�з�跴�ͺ\n\n�ѹ�١��ͧ��������µ�����㺢Ѻ����繷������Ѻ�ѹ� San Andreas\n��âѺ�����������͹حҵ�ռš�з��������ҧ��੾�С�����", "Close", "");

				if (IsTaskCompleted(playerid))
				{
    				Character[playerid][Task] = 0;
				}
			}

			if (EntranceData[id][entranceType] == 2)
			{
			    SendClientMessage(playerid, COLOR_GREEN, "Bank: /bank /withdraw /balance");
			}
		}
		if (EntranceData[id][entranceCustom])
			SetPlayerPosExten(playerid, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2]);

		else
		SetPlayerPosEx(playerid, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2], EntranceData[id][entranceInterior], EntranceData[id][entranceWorld]);

		SetPlayerFacingAngle(playerid, EntranceData[id][entranceInt][3]);

		SetCameraBehindPlayer(playerid);
		Character[playerid][Entrance] = EntranceData[id][entranceID];

		format(string, sizeof(string), "~w~%s", EntranceData[id][entranceName]);
		GameTextForPlayer(playerid, string, 3000, 1);
		return 1;
	}
	if ((id = Business_Nearest(playerid)) != -1)
  	{
   		if (BusinessData[id][bizLocked])
     		return SendClientMessage(playerid, -1, "��áԨ�١�Դ����Ңͧ");

		if (Character[playerid][Task] && !Character[playerid][StoreTask])
		{
  			Character[playerid][StoreTask] = 1;
   			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Retail Store", "��áԨ����� Retail Store �س����ö���ͧ͢����ҡ������������ /buy \n����觷���ջ���ª����س����ö���������� ��觨ж١��������㹪�ͧ�红ͧ�ͧ�س\n\n�Թ��ҷ���ջ���ª�����ش��� GPS System, ��觨оҢ���㹷���ҧ � ��\n�س����ö�͡�ҡ��áԨ������ʹ�����¾���� /exit ����е�", "Close", "");

			if (IsTaskCompleted(playerid))
			{
				Character[playerid][Task] = 0;
			}
		}

		if(BusinessData[id][bizInt][0] == 0.0 && BusinessData[id][bizInt][1] == 0.0 && BusinessData[id][bizType] == 8)
		{
  			return Business_PurchaseMenu(playerid, id);
		}

		if(BusinessData[id][bizType] == 5)
		{
  			SendClientMessage(playerid, -1, "��س��� '/v buy' ���ͫ���");
     		return 1;
		}

		SetPlayerPosEx(playerid, BusinessData[id][bizInt][0], BusinessData[id][bizInt][1], BusinessData[id][bizInt][2],BusinessData[id][bizInterior], BusinessData[id][bizID] + 6000);
		SetPlayerFacingAngle(playerid, BusinessData[id][bizInt][3]);

		SetCameraBehindPlayer(playerid);
		Character[playerid][Business] = BusinessData[id][bizID];

		if (strlen(BusinessData[id][bizMessage]) && strcmp(BusinessData[id][bizMessage], "NULL", true)) {
  			SendClientMessage(playerid, COLOR_YELLOW, BusinessData[id][bizMessage]);
		}

		format(string, sizeof(string), "~w~%s", BusinessData[id][bizName]);
		GameTextForPlayer(playerid, string, 3000, 1);
		return 1;
	}
	return 1;
}*/

/*CMD:exit(playerid, params[])
{
    new
    	id = -1;

    if ((id = House_Inside(playerid)) != -1 && IsPlayerInRangeOfPoint(playerid, 2.5, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2]))
 	{
		SetPlayerPosEx(playerid, HouseData[id][housePos][0], HouseData[id][housePos][1], HouseData[id][housePos][2], HouseData[id][houseExterior], HouseData[id][houseExteriorVW]);
		SetPlayerFacingAngle(playerid, HouseData[id][housePos][3] - 180.0);

		SetCameraBehindPlayer(playerid);
		Character[playerid][House] = -1;
		return 1;
	}

	if ((id = Entrance_NearestInside(playerid)) != -1 && IsPlayerInRangeOfPoint(playerid, 2.5, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2]))
	{
		if (EntranceData[id][entranceCustom])
			SetPlayerPosExten(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2]);

		else
		SetPlayerPosEx(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2], EntranceData[id][entranceExterior], EntranceData[id][entranceExteriorVW]);

		SetPlayerFacingAngle(playerid, EntranceData[id][entrancePos][3] - 180.0);

		SetCameraBehindPlayer(playerid);
		Character[playerid][Entrance] = Entrance_GetLink(playerid);
		return 1;
	}
	if ((id = Business_Inside(playerid)) != -1 && IsPlayerInRangeOfPoint(playerid, 2.5, BusinessData[id][bizInt][0], BusinessData[id][bizInt][1], BusinessData[id][bizInt][2]))
 	{
		SetPlayerPosEx(playerid, BusinessData[id][bizPos][0], BusinessData[id][bizPos][1], BusinessData[id][bizPos][2],BusinessData[id][bizExterior],BusinessData[id][bizExteriorVW]);
		SetPlayerFacingAngle(playerid, BusinessData[id][bizPos][3] - 180.0);

		SetCameraBehindPlayer(playerid);
		Character[playerid][Business] = -1;
		return 1;
	}
	return 1;
}*/

CMD:disablecp(playerid, params[])
{
	PlayerCheckpointBiz[playerid] = 0;
	PlayerCheckpointHouse[playerid] = 0;
	PlayerCheckpointEntrance[playerid] = 0;
	ParkCheckpoint[playerid] = false;
	DisablePlayerCheckpoint(playerid);
    return 1;
}

CMD:refuel(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);

	/*if (Character[playerid][Refill] != INVALID_VEHICLE_ID)
	{
	    //BusinessData[Character[playerid][GasStation]][bizVault] += Character[playerid][RefillPrice];
		//Business_Save(Character[playerid][GasStation]);

        //GiveMoney(playerid, -Character[playerid][RefillPrice], "Refill Fuel from pump %d", Character[playerid][GasStation]);


        //format(string, sizeof(string), "�س���������ѹ����Ѻö�ͧ�س��Ҥ� $%d", Character[playerid][RefillPrice]);
		//SendClientMessage(playerid, -1, string);
        StopRefilling(playerid);

        return 1;
	}*/
	if (!vehicleid)
	    return SendClientMessage(playerid, -1, "�س�����������ҹ��˹�� � !");

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendClientMessage(playerid, -1, "�س��ͧ�繤��Ѻ!");

	if (GetEngineStatus(vehicleid))
	    return SendClientMessage(playerid, -1, "�س��ͧ�Ѻ����ͧ¹���͹");

	new id = Pump_Nearest(playerid);

	if (id != -1)
	{
		if (FuelVehicle(vehicleid) > 95)
			return SendClientMessage(playerid, -1, "�ҹ��˹Фѹ��������繵�ͧ�����ѹ");

		if (IsPumpOccupied(id))
		    return SendClientMessage(playerid, -1, "��������դ���ҹ����");

		if (PumpData[id][pumpFuel] < 1)
   			return SendClientMessage(playerid, -1, "��������չ���ѹ�����§��");

		Character[playerid][GasPump] = id;
		Character[playerid][GasStation] = PumpData[id][pumpBusiness];

		Character[playerid][Refill] = vehicleid;
		SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ������������ѹ����ҹ��˹Тͧ��", ReturnName(playerid, 0));
	}
	else
	{
		SendClientMessage(playerid, -1, "�س���������㹢ͺࢵ������ҫ�������դ���");
	}
	return 1;
}

CMD:buy(playerid, params[])
{
	new
		id = -1,
		string[128];

	if ((id = House_Nearest(playerid)) != -1)
	{
		if (House_GetCount(playerid) >= MAX_OWNABLE_HOUSES)
			return SendClientMessageEx(playerid, -1, "�س�պ�ҹ %d ������ǵ͹���", MAX_OWNABLE_HOUSES);

		if (HouseData[id][houseOwner] != 0)
		    return SendClientMessage(playerid, -1, "��ҹ��觹������Ңͧ����");

		if (HouseData[id][housePrice] > GetMoney(playerid))
		    return SendClientMessage(playerid, -1, "�س���Թ�����§�ͷ��Ы���");

	    HouseData[id][houseOwner] = GetPlayerSQLID(playerid);

		House_Refresh(id);
		House_Save(id);

	    GiveMoney(playerid, -HouseData[id][housePrice], "buy house id %d", id);
	    SendClientMessageEx(playerid, -1, "�س����� \"%s\" �Ҥ� %s!", HouseData[id][houseAddress], FormatNumber(HouseData[id][housePrice]));

		ShowPlayerFooter(playerid, "You have ~g~purchased~w~ a house!");
	    Log_Write("logs/house_log.txt", "[%s] %s has purchased house ID: %d for %s.", ReturnDate(), ReturnRealName(playerid), id, FormatNumber(HouseData[id][housePrice]));
	}
 	if ((id = Business_Nearest(playerid)) != -1)
	{
	    if (Business_GetCount(playerid) >= MAX_OWNABLE_BUSINESSES)
	    {
	        format(string, sizeof(string), "�س�ո�áԨ %d ������ǵ͹���", MAX_OWNABLE_BUSINESSES);
			SendClientMessage(playerid, -1, string);
			return 1;
		}

		if (BusinessData[id][bizOwner] != 0)
		    return SendClientMessage(playerid, -1, "��áԨ��觹������Ңͧ����");

		if (BusinessData[id][bizPrice] > GetMoney(playerid))
		    return SendClientMessage(playerid, -1, "�س���Թ�����§�ͷ��Ы���");

        BusinessData[id][bizVault] = 0;
	    BusinessData[id][bizOwner] = GetPlayerSQLID(playerid);

		Business_Refresh(id);
		Business_Save(id);

     	GiveMoney(playerid, -BusinessData[id][bizPrice], "buy biz id %d", id);
	    format(string, sizeof(string), "�س����� \"%s\" �Ҥ� %s!", BusinessData[id][bizName], FormatNumber(BusinessData[id][bizPrice]));
		SendClientMessage(playerid, -1, string);

	    Log_Write("logs/biz_log.txt", "[%s] %s has purchased business ID: %d for %s.", ReturnDate(), ReturnRealName(playerid), id, FormatNumber(BusinessData[id][bizPrice]));
	}
	else if ((id = Business_Inside(playerid)) != -1)
	{
		if (BusinessData[id][bizLocked] != 0 || !BusinessData[id][bizOwner])
		    return SendClientMessage(playerid, -1, "��áԨ���Դ����!");


        Business_PurchaseMenu(playerid, id);
		/*if (BusinessData[id][bizType] == 5) {
		    Business_CarMenu(playerid, id);
		} else {
			Business_PurchaseMenu(playerid, id);
		}*/
	}
	return 1;
}

CMD:lock(playerid, params[])
{
	new
	    id = -1;

	new canlock;

    if (!IsPlayerInAnyVehicle(playerid) && (id = (House_Inside(playerid) == -1) ? (House_Nearest(playerid)) : (House_Inside(playerid))) != -1 && House_IsOwner(playerid, id))
	{
		if (!HouseData[id][houseLocked])
		{
			HouseData[id][houseLocked] = true;
			House_Save(id);

			ShowPlayerFooter(playerid, "You have ~r~locked~w~ your house!");
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);

			canlock = 1;
		}
		else
		{
			HouseData[id][houseLocked] = false;
			House_Save(id);

			ShowPlayerFooter(playerid, "You have ~g~unlocked~w~ your house!");
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);

			canlock = 1;
		}
	}

	if ( IsPlayerInAnyVehicle(playerid) ? ((id = Car_GetID(GetPlayerVehicleID(playerid))) != -1) : ((id = Car_Nearest(playerid)) != -1) )
	{
		if (Car_IsOwner(playerid, id) || (Character[playerid][Faction] != -1 && CarData[id][carFaction] == GetFactionType(playerid)) || CarRent_IsOwner(playerid, id))
		{
	 		new
			    engine,
			    lights,
			    alarm,
			    doors,
			    bonnet,
			    boot,
			    objective;

			GetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, doors, bonnet, boot, objective);

			if (!CarData[id][carLocked])
			{
				CarData[id][carLocked] = true;
				Car_Save(id);

				ShowPlayerFooter(playerid, "You have ~r~locked~w~ the vehicle!");
				PlayerPlaySoundEx(playerid, 24600);

				SetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, 1, bonnet, boot, objective);
				canlock = 1;
			}
			else
			{
				CarData[id][carLocked] = false;
				Car_Save(id);

				ShowPlayerFooter(playerid, "You have ~g~unlocked~w~ the vehicle!");
				PlayerPlaySoundEx(playerid, 24600);

				SetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, 0, bonnet, boot, objective);
				canlock = 1;
			}
		}
	}
	else if (!IsPlayerInAnyVehicle(playerid) && (id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1)
	{
		if (Business_IsOwner(playerid, id))
		{
			if (!BusinessData[id][bizLocked])
			{
				BusinessData[id][bizLocked] = true;

				Business_Refresh(id);
				Business_Save(id);

				ShowPlayerFooter(playerid, "You have ~r~locked~w~ the business!");
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
                canlock = 1;
			}
  			else
			{
				BusinessData[id][bizLocked] = false;

				Business_Refresh(id);
				Business_Save(id);

				ShowPlayerFooter(playerid, "You have ~g~unlocked~w~ the business!");
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
				canlock = 1;
			}
		}
	}

	if (!canlock) SendClientMessage(playerid, -1, "�س���������㹢ͺࢵ�ͧ���á��������ͤ��");
	return 1;
}


CMD:v(playerid, params[]) return cmd_vehicle(playerid, params);
CMD:vehicle(playerid, params[])
{
    new oneString[30], secString[90];//, string[128];

    if(sscanf(params, "s[30]S()[90]", oneString, secString))
	{
	    SendClientMessage(playerid, COLOR_RADIOEX, "___________________________________________________________");
		SendClientMessage(playerid, COLOR_RADIOEX, "USAGE: /(v)ehicle [action]");
		SendClientMessage(playerid, COLOR_RADIOEX, "[Actions] buypark, park, lights, listcars, find, lock");
		SendClientMessage(playerid, COLOR_RADIOEX, "[Actions] buy, faction, unfaction");
		SendClientMessage(playerid, COLOR_RADIOEX, "[Delete] scrap [�ҡ�س�����觹���к��зӡ���ִ�ҹ��˹Тͧ�س�ѹ���·��������Թ�׹!]");
		SendClientMessage(playerid, COLOR_RADIOEX, "[Hint] �դ��й��Ը����û�Ժѵ�����ҹ���������� Coming Soon");
		SendClientMessage(playerid, COLOR_RADIOEX, "___________________________________________________________");
		return 1;
	}

	if(!strcmp(oneString, "lights"))
	{
	    new vehicleid = GetPlayerVehicleID(playerid);

		if (!IsEngineVehicle(vehicleid))
			return SendClientMessage(playerid, -1, "�س�����������ҹ��˹�");

		if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		    return SendClientMessage(playerid, -1, "�س�������ö��Ẻ����� �س����褹�Ѻ");

		switch (GetLightStatus(vehicleid))
		{
		    case false:
		    {
		        SetLightStatus(vehicleid, true);
			}
			case true:
			{
			    SetLightStatus(vehicleid, false);
			}
		}
	}

	if(!strcmp(oneString, "lock"))
	{
	    new
	    	id = -1;

		new canlock;

	    if ( IsPlayerInAnyVehicle(playerid) ? ((id = Car_GetID(GetPlayerVehicleID(playerid))) != -1) : ((id = Car_Nearest(playerid)) != -1) )
		{
			if (Car_IsOwner(playerid, id) || (Character[playerid][Faction] != -1 && CarData[id][carFaction] == GetFactionType(playerid)) || CarRent_IsOwner(playerid, id))
			{
		 		new
				    engine,
				    lights,
				    alarm,
				    doors,
				    bonnet,
				    boot,
				    objective;

				GetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, doors, bonnet, boot, objective);

				if (!CarData[id][carLocked])
				{
					CarData[id][carLocked] = true;
					Car_Save(id);

					ShowPlayerFooter(playerid, "You have ~r~locked~w~ the vehicle!");
					PlayerPlaySoundEx(playerid, 24600);

					SetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, 1, bonnet, boot, objective);
					canlock = 1;
				}
				else
				{
					CarData[id][carLocked] = false;
					Car_Save(id);

					ShowPlayerFooter(playerid, "You have ~g~unlocked~w~ the vehicle!");
					PlayerPlaySoundEx(playerid, 24600);

					SetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, 0, bonnet, boot, objective);
					canlock = 1;
				}
			}
		}
		if (!canlock) SendClientMessage(playerid, -1, "�س���������㹢ͺࢵ�ͧ���á��������ͤ��");
	}

	if(!strcmp(oneString, "listcars"))
	{
	    new
	    Float:fX,
	    Float:fY,
	    Float:fZ,
		count = 1;

		SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");

		for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) if (Car_IsOwner(playerid, i)) {
  			GetVehiclePos(CarData[i][carVehicle], fX, fY, fZ);

			if(CarData[i][carDeathTime] == 0 && CarData[i][carImpounded] == -1)
			{
				if(CarData[i][carGPS])
				{
   					SendClientMessageEx(playerid, COLOR_WHITE, "�ح��ҹ��˹�: [%d] Slot #%d: Vehicle:[%s] Insurances:[%d] Mileage:[%d] Lock:[%d] Destroyed:[%d] Immobiliser:[%d] Location:[%s] (/findcar)",CarData[i][carVehicle],count,ReturnVehicleModelName(CarData[i][carModel]),CarData[i][carInsurance],CarData[i][carMileage],CarData[i][carLock],CarData[i][carDestroyed],CarData[i][carImmob], GetLocation(fX, fY, fZ));
			    	SendClientMessageEx(playerid, COLOR_WHITE, "Plate:[%s]", CarData[i][carPlate]);
				}
				else
				{
   					SendClientMessageEx(playerid, COLOR_WHITE, "�ح��ҹ��˹�: [%d] Slot #%d: Vehicle:[%s] Insurances:[%d] Mileage:[%d] Lock:[%d] Destroyed:[%d] Immobiliser:[%d] Location:[No GPS]",CarData[i][carVehicle],count,ReturnVehicleModelName(CarData[i][carModel]),CarData[i][carInsurance],CarData[i][carMileage],CarData[i][carLock],CarData[i][carDestroyed],CarData[i][carImmob]);
   					SendClientMessageEx(playerid, COLOR_WHITE, "Plate:[%s]", CarData[i][carPlate]);
				}
			}
			else if(CarData[i][carDeathTime] && CarData[i][carImpounded] == -1)
			{
  				new redeemstr[64];
	    		if(CarData[i][carDeathTime] > 60) { format(redeemstr,sizeof(redeemstr),"%d �ҷ�",(CarData[i][carDeathTime] / 60)); } else { format(redeemstr,sizeof(redeemstr),"���¡���˹�觹ҷ�!"); }
      			SendClientMessageEx(playerid, COLOR_WHITE, "�ح��ҹ��˹�: [%d] Slot #%d: Vehicle:[%s] Insurances:[%d] Mileage:[%d] Lock:[%d] Destroyed:[%d] Immobiliser:[%d] ���ҡ��׹:[%s] (/acceptcharge)",CarData[i][carVehicle],count, ReturnVehicleModelName(CarData[i][carModel]), CarData[i][carInsurance],CarData[i][carMileage],CarData[i][carLock],CarData[i][carDestroyed],CarData[i][carImmob], redeemstr);
        		SendClientMessageEx(playerid, COLOR_WHITE, "Plate:[%s]", CarData[i][carPlate]);
			}
			else if(CarData[i][carImpounded] != -1)
			{
  				SendClientMessageEx(playerid, COLOR_WHITE, "[�١�ִ] �ح��ҹ��˹�: [%d] Slot #%d: Vehicle:[%s] Insurances:[%d] Mileage:[%d] Lock:[%d] Destroyed:[%d] Immobiliser:[%d]",CarData[i][carVehicle],count, ReturnVehicleModelName(CarData[i][carModel]), CarData[i][carInsurance], CarData[i][carMileage], CarData[i][carLock], CarData[i][carDestroyed], CarData[i][carImmob]);
     			SendClientMessageEx(playerid, COLOR_WHITE, "Plate:[%s]", CarData[i][carPlate]);
			}
			count++;
		}
		if (count < 2)
 			SendClientMessage(playerid, COLOR_WHITE, "�س���������Ңͧ�ҹ��˹�� �");

		SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
	}

	/*else if(!strcmp(oneString, "buy"))
	{
	    new
     		id = -1;

	    if ((id = Business_Nearest(playerid)) != -1)
  		{
		    if(BusinessData[id][bizType] == 5)
			{
	  			VDealerBiz[playerid] = id;
	  			ShowPlayerDealership(playerid, 1);
	     		return 1;
			}
	 	}
	 	SendClientMessage(playerid, -1, "�س�������������ҹ����ҹ��˹�!");
	}*/
	else if(!strcmp(oneString, "park"))
	{
	    new
   			carid = GetPlayerVehicleID(playerid);

		if (!carid)
 			return SendClientMessage(playerid, -1, "�س��ͧ������ҹ��˹�");

		if (IsVehicleImpounded(carid))
			return SendClientMessage(playerid, -1, "�ҹ��˹Фѹ���١�ִ��Фس�������ö���ѹ��");

		if ((carid = Car_GetID(carid)) != -1 && Car_IsOwner(playerid, carid))
		{
			if(!IsPlayerInRangeOfPoint(playerid, 5.0, CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2]))
			{
			    SendClientMessage(playerid, COLOR_RED, "[!]{FFFFFF} �س���������ش�ʹö�ͧ�س");
			    SendClientMessage(playerid, COLOR_GREEN, "[!]{FFFFFF} 价��ش Checkpoint ������ѧ�ش�ʹö�ͧ�س");

 				SetPlayerCheckpoint(playerid, CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2], 5.0);
                ParkCheckpoint[playerid] = true;
			}
		}
	}
	else if(!strcmp(oneString, "buypark"))
	{
	    new
	    	carid = GetPlayerVehicleID(playerid);

		if (!carid)
		    return SendClientMessage(playerid, -1, "�س��ͧ������ҹ��˹�");

	    if (IsVehicleImpounded(carid))
	    	return SendClientMessage(playerid, -1, "�ҹ��˹Фѹ���١�ִ��Фس�������ö���ѹ��");

		if (GetMoney(playerid) < 5000)
		    return SendClientMessage(playerid, -1, "�س���Թ�����§�� $5,000");

		if ((carid = Car_GetID(carid)) != -1 && Car_IsOwner(playerid, carid))
		{
		    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		        return SendClientMessage(playerid, -1, "�س��ͧ�繤��Ѻ!");

		    new
				g_arrSeatData[10] = {INVALID_PLAYER_ID, ...},
				seatid;

	        for (new i = 0; i < 14; i ++) {
				CarData[carid][carMods][i] = GetVehicleComponentInSlot(CarData[carid][carVehicle], i);
		    }
		    SaveVehicleDamage(CarData[carid][carVehicle]);
			foreach (new i : Player) if (IsPlayerInVehicle(i, CarData[carid][carVehicle])) {
			    seatid = GetPlayerVehicleSeat(i);

			    g_arrSeatData[seatid] = i;
			}
			GetVehiclePos(CarData[carid][carVehicle], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2]);
			GetVehicleZAngle(CarData[carid][carVehicle], CarData[carid][carPos][3]);

			Car_Spawn(carid);
			Car_Save(carid);

            Character[playerid][Cash] -= 5000;
			GivePlayerMoney(playerid, -5000);
            SendClientMessage(playerid, -1, "�س����ʺ���������㹡�èʹö�ͧ�س $5,000");

			for (new i = 0; i < sizeof(g_arrSeatData); i ++) if (g_arrSeatData[i] != INVALID_PLAYER_ID) {
			    PutPlayerInVehicleEx(g_arrSeatData[i], CarData[carid][carVehicle], i);

			    g_arrSeatData[i] = INVALID_PLAYER_ID;
			}
		}
		else SendClientMessage(playerid, -1, "�س���������㹺ҧ���ҧ�������ö�ʹö��");
	}
	else if(!strcmp(oneString, "faction"))
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendClientMessage(playerid, -1, "�س��ͧ�繤��Ѻö!");

		if(Character[playerid][Faction] == -1)
			return SendClientMessage(playerid, -1, "�س����� Faction!");

		if(Character[playerid][FactionRank] != 1)
			return SendClientMessage(playerid, COLOR_RED, "���˹觢ͧ�س�������ö��Ẻ�����!");

  		new
	    	carid = GetPlayerVehicleID(playerid);

        if ((carid = Car_GetID(carid)) != -1 && Car_IsOwner(playerid, carid))
		{
		    if(CarData[carid][carFaction] >= 1)
			return SendClientMessage(playerid, -1, "�ҹ��˹Фѹ����� Faction ����!");

			CarData[carid][carFaction] = Character[playerid][FactionID];
			SendClientMessageEx(playerid, -1, "�س���ʺ���������㹡�÷�ö��� Faction : %s.", Faction_GetName(playerid));

			Car_Save(carid);
		}
		else SendClientMessage(playerid, -1, "�س���������Ңͧö!");
	}
	else if(!strcmp(oneString, "unfaction"))
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendClientMessage(playerid, -1, "�س��ͧ�繤��Ѻö!");

		new
 			carid = GetPlayerVehicleID(playerid);

		if ((carid = Car_GetID(carid)) != -1 && Car_IsOwner(playerid, carid))
		{
			SendClientMessage(playerid, -1, "�س�����ö�ѹ����͡�ҡ Faction ���º��������!");
			CarData[carid][carFaction] = 0;

			Car_Save(carid);
		}
	}
	return 1;
}

CMD:hood(playerid, params[])
{
 	new carid = Car_Nearest(playerid);

	for (new i = 1; i != MAX_VEHICLES; i ++) if (IsValidVehicle(i) && IsPlayerNearHood(playerid, i))
	{
 		if (IsVehicleImpounded(CarData[carid][carVehicle]))
   			return SendClientMessage(playerid, -1, "�ҹ��˹й��١�ִ��Фس�������ö���ѹ��");

		if (CarData[carid][carLocked])
  			return SendClientMessage(playerid, -1, "�ҹ��˹й��١��ͤ");

		if (!IsDoorVehicle(i))
  			return SendClientMessage(playerid, -1, "ö�ѹ�������սҡ���ç˹��ö");

		new FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper;
  		GetVehiclePanelsDamageStatus(i, FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper);

		if (WindShield >= 1)
  			return SendClientMessage(playerid, -1, "ö�ѹ������ç˹��ö�ѧ����");


		if (!GetHoodStatus(i))
		{
  			SetHoodStatus(i, true);

			SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ���Դ�ҡ���ç˹��ö", ReturnName(playerid, 0));
   			ShowPlayerFooter(playerid, "You have ~g~opened~w~ the hood!");
		}
		else
		{
			SetHoodStatus(i, false);

			SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ��Դ�ҡ���ç˹��ö", ReturnName(playerid, 0));
   			ShowPlayerFooter(playerid, "You have ~g~closed~w~ the hood!");
		}
  		return 1;
	}
	SendClientMessage(playerid, -1, "�س���������㹢ͺࢵ�ͧ�ҹ��˹�� �");
	return 1;
}

CMD:trunk(playerid, params[])
{
    new carid = Car_Nearest(playerid);

	for (new i = 1; i != MAX_VEHICLES; i ++) if (IsValidVehicle(i) && IsPlayerNearBoot(playerid, i))
	{
	    if (IsVehicleImpounded(CarData[carid][carVehicle]))
	        return SendClientMessage(playerid, -1, "�ҹ��˹й��١�ִ��Фس�������ö���ѹ��");

		if (CarData[carid][carLocked])
		    return SendClientMessage(playerid, -1, "�ҹ��˹й��١��ͤ");

	    if (!IsDoorVehicle(i))
     		return SendClientMessage(playerid, -1, "ö�ѹ�������սҡ���ç��ѧö");

		new FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper;
	    GetVehiclePanelsDamageStatus(i, FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper);

	    if (!GetTrunkStatus(i))
		{
	        SetTrunkStatus(i, true);

	        SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ���Դ�ҡ���ç��ѧö", ReturnName(playerid, 0));
	        ShowPlayerFooter(playerid, "You have ~g~opened~w~ the hood!");
		}
		else
		{
			SetTrunkStatus(i, false);

	        SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ��Դ�ҡ���ç��ѧö", ReturnName(playerid, 0));
	        ShowPlayerFooter(playerid, "You have ~g~closed~w~ the hood!");
		}
	    return 1;
	}
	SendClientMessage(playerid, -1, "�س���������㹢ͺࢵ�ͧ�ҹ��˹�� �");
	return 1;
}

CMD:rentvehicle(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);

    new carid = Car_GetID(vehicleid);

	if(GetMoney(playerid) < 2500)
	    return SendClientMessage(playerid, COLOR_RED, "[!] {FFFFFF}�س���Թ����");

    if(IsPlayerInAnyVehicle(playerid) && CarData[carid][carRent] == 1)
	{
		SendClientMessage(playerid, COLOR_GREEN, "�س������ҹ��˹� (/unrentvehicle ������ԡ���)");
		SendClientMessage(playerid, -1, "HINT: �س����ö��ͤ�ҹ��˹з����Ҵ��� /lock");
		SendClientMessage(playerid, -1, "/rentengine ����ʵ���");

		CarData[carid][carRented] = 1;
		CarData[carid][carRentOwner] = Character[playerid][ID];
		GiveMoney(playerid, -2500, "Rentcar");
	}
	return 1;
}

CMD:unrentvehicle(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);

    new carid = Car_GetID(vehicleid);

    if(IsPlayerInAnyVehicle(playerid) && CarData[carid][carRented] == 1)
	{
		SendClientMessage(playerid, COLOR_GREEN, "�س��¡��ԡ���ö���º��������!");

		CarData[carid][carRented] = 0;
		CarData[carid][carRentOwner] = 0;
		RespawnVehicle(vehicleid);
	}
	return 1;
}

CMD:rentengine(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);

	new carid = Car_GetID(vehicleid);

    if (!IsEngineVehicle(vehicleid))
		return SendClientMessage(playerid, -1, "�س�����������ҹ��˹�");

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendClientMessage(playerid, -1, "�س�������ö��Ẻ����� �س����褹�Ѻ");

	if (FuelVehicle(vehicleid) < 1 && !CoreVehicles[vehicleid][vehTemporary])
  		return SendClientMessage(playerid, -1, "�ѧ����ѹ������ԧ���");

	if (ReturnVehicleHealth(vehicleid) <= 300)
	    return SendClientMessage(playerid, -1, "�ҹ��˹Фѹ�����������Թ���ҷ���ʵ�������ͧ¹��");

    if(CoreVehicles[vehicleid][vehTemporary] == 1)
        return SendClientMessage(playerid, -1, "�������ö��Ѻ�ҹ��˹Ъ��Ǥ�����!");

    if(CarData[carid][carRent] == 1)
	{
	    if(CarData[carid][carRented] == 1)
	    {
	     	new EngineStatus = GetEngineStatus(vehicleid);

			switch (EngineStatus)
			{
				case false:
				{
					SetEngineStatus(vehicleid, true);
	 				SetLightStatus(vehicleid, true);
	 				PlayerTextDrawShow(playerid, Speedo[playerid]);
			  		SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ���������ͧ¹��ͧ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
				}
				case true:
				{
					SetEngineStatus(vehicleid, false);
	 				SetLightStatus(vehicleid, false);
	    			SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ��ش����ͧ¹��ͧ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
				}
		    }
		}
		else SendClientMessage(playerid, COLOR_RED, "[!]{FFFFFF} �س�������ö������ӧҹ����ͧ¹���騹���Ҥس����Ҿ�˹Фѹ���");
	}
	return 1;
}

CMD:engine(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);

	new carid = Car_GetID(vehicleid);

	if (!IsEngineVehicle(vehicleid))
		return SendClientMessage(playerid, -1, "�س�����������ҹ��˹�");

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
 		return SendClientMessage(playerid, -1, "�س�������ö��Ẻ����� �س����褹�Ѻ");

	if (FuelVehicle(vehicleid) < 1 && !CoreVehicles[vehicleid][vehTemporary])
  		return SendClientMessage(playerid, -1, "�ѧ����ѹ������ԧ���");

	if (ReturnVehicleHealth(vehicleid) <= 300)
	    return SendClientMessage(playerid, -1, "�ҹ��˹Фѹ�����������Թ���ҷ���ʵ�������ͧ¹��");

    if(CoreVehicles[vehicleid][vehTemporary] == 1)
        return SendClientMessage(playerid, -1, "�������ö��Ѻ�ҹ��˹Ъ��Ǥ�����!");

	if(carid != -1)
	{
	    if(CarData[carid][carRent] == 1)
	    {
			SendClientMessage(playerid, COLOR_ORANGE, "[!]{FFFFFF} �س���繵�ͧ���ö�ѹ����͹����� /rentvehicle �������ö.");
	    	SendClientMessage(playerid, COLOR_ORANGE, "[!]{FFFFFF} ����Ѻö����� /rentengine �����������ӧҹ�ͧ����ͧ¹��.");
			return 1;
		}

    	if(CarData[carid][carFaction] > 0)
		{
			if(CarData[carid][carFaction] == Character[playerid][FactionID])
			{
			    new EngineStatus = GetEngineStatus(vehicleid);

				switch (EngineStatus)
				{
					case false:
					{
						SetEngineStatus(vehicleid, true);
		  				SetLightStatus(vehicleid, true);
		  				PlayerTextDrawShow(playerid, Speedo[playerid]);
				  		SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ���������ͧ¹��ͧ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
					}
					case true:
					{
						SetEngineStatus(vehicleid, false);
						SetLightStatus(vehicleid, false);
		  				SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ��ش����ͧ¹��ͧ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
					}
				}
			}
		}

		if(CarData[carid][carOwner] > 0)
		{
			if(CarData[carid][carOwner] == Character[playerid][ID])
			{
			    new EngineStatus = GetEngineStatus(vehicleid);

				switch (EngineStatus)
				{
     				case false:
					{
						SetEngineStatus(vehicleid, true);
		  				SetLightStatus(vehicleid, true);
		  				PlayerTextDrawShow(playerid, Speedo[playerid]);
				  		SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ���������ͧ¹��ͧ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
					}
					case true:
					{
						SetEngineStatus(vehicleid, false);
						SetLightStatus(vehicleid, false);
		  				SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ��ش����ͧ¹��ͧ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
					}
				}
			}
			else
				return SendClientMessage(playerid, COLOR_RED, "[!] {FFFFFF}�س����աح�����Ѻö�ѹ���");
		}
		else
		{
		    if(CarData[carid][carFaction] == 0)
		    {
			    new EngineStatus = GetEngineStatus(vehicleid);

				switch (EngineStatus)
				{
				    case false:
					{
						SetEngineStatus(vehicleid, true);
		  				SetLightStatus(vehicleid, true);
		  				PlayerTextDrawShow(playerid, Speedo[playerid]);
				  		SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ���������ͧ¹��ͧ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
					}
					case true:
					{
						SetEngineStatus(vehicleid, false);
						SetLightStatus(vehicleid, false);
		  				SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ��ش����ͧ¹��ͧ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
					}
				}
			}
		}
	}
	return 1;
}
ALTCMD:en->engine;
CMD:pay(playerid, params[])
{
	new
		userid, amount, emote[90];

	if(sscanf(params, "uiS('None')[90]", userid, amount, emote))
		return SendClientMessage(playerid, -1, "/pay [playerid OR name] [amount] [emote (Optional)]");

	if (userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, -1, "�����蹹�鹵Ѵ���������������������������س");

	if (userid == playerid)
		return SendClientMessage(playerid, -1, "�س�������ö����Թ����ͧ��");

	if (amount < 1)
	    return SendClientMessage(playerid, -1, "�ô�кبӹǹ����ҡ���� 1 ������");

	if (amount > 5 && Character[playerid][Playerhours] < 2)
	    return SendClientMessage(playerid, -1, "�س�������ö�����ҡ���� $5 㹢�з�������������蹵�ӡ��� 2 �������");

	if (amount > GetMoney(playerid))
	    return SendClientMessage(playerid, -1, "�س��������Թ�ҡ��Ҵ���");

	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0); PlayerPlaySound(userid, 1052, 0.0, 0.0, 0.0);

	GiveMoney(playerid, -amount, "pay to %s", ReturnRealName(userid));
	GiveMoney(userid, amount, "pay from %s", ReturnRealName(playerid));

	SendClientMessageEx(playerid, COLOR_GREY, " �س������Թ�Ѻ %s, �ӹǹ %s.", ReturnName(userid, 0), FormatNumber(amount));
	SendClientMessageEx(userid, COLOR_GREY, "�س���Ѻ�Թ�ӹǹ %s �ҡ %s.", FormatNumber(amount), ReturnName(playerid, 0));

	if(!strcmp(emote, "None"))
		SendNearbyMessage(playerid, 20.0, COLOR_RP, "* %s ����Ժ�Թ�ҡ�����ҵѧ�ͧ��������������ͧ͢ %s.", ReturnName(playerid, 0), ReturnName(userid, 0));

	else SendNearbyMessage(playerid, 20.0, COLOR_RP, "* %s %s %s", ReturnName(playerid, 0), emote, ReturnName(userid, 0));

	if(Character[playerid][Playerhours] <= 3 && Character[userid][Playerhours] <= 3 || amount >= 50000)
	{
		SendAdminAlert(COLOR_YELLOW, "AdmCmd: %s ������Թ�ӹǹ %s �Ѻ %s.", ReturnName(playerid), FormatNumber(amount), ReturnName(userid, 0));
	}
	return 1;
}

//police command

CMD:pd(playerid, params[])
{
	new factionid = Character[playerid][Faction];
	//new id = FactionLocker_Nearest(playerid);

 	if (factionid == -1)
	    return SendClientMessage(playerid, -1, "�س�������Ҫԡ�ͧ Faction");

	if (!IsNearFactionLocker(playerid))
	    return SendClientMessage(playerid, -1, "�س���������㹢ͺࢵ�ͧ����红ͧ Locker");

	
 	if (FactionData[factionid][factionType] == FACTION_POLICE)
		Dialog_Show(playerid, DIALOG_LOCKER, DIALOG_STYLE_LIST, "[Locker]", "OnDuty-OffDuty\nLocker Skin\nweapon", "Select", "Cancel");

	//else Dialog_Show(playerid, DIALOG_LOCKER, DIALOG_STYLE_LIST, "[Locker]", "�������ͼ��\n��ѧ���ظ", "��ŧ", "�͡");
	return 1;
}

CMD:drag(playerid, params[])
{
	new
	    userid;

	if (GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, -1, "�س��ͧ�����˹�ҷ����Ǩ");


    if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/drag [�ʹ�/����]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, -1, "�����蹹����Ѵ���������������");

    if (userid == playerid)
	    return SendClientMessage(playerid, -1, "�س�������ö�ҡ����ͧ��");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, -1, "�����蹹�鹵�ͧ���躹��鹡�͹���س���ҡ��");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, -1, "�س��ͧ�����������蹹��");

	if (Character[userid][pDragged])
	{
	    Character[userid][pDragged] = 0;
	    Character[userid][pDraggedBy] = INVALID_PLAYER_ID;

	    KillTimer(Character[userid][pDragTimer]);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ����ش�ҡ��� %s ��� �����������������", ReturnName(playerid, 0), ReturnName(userid, 0));
	}
	else
	{
	    Character[userid][pDragged] = 1;
	    Character[userid][pDraggedBy] = playerid;

	    Character[userid][pDragTimer] = SetTimerEx("DragUpdate", 200, true, "dd", playerid, userid);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ����ҵ�� %s ������� ����ҡ�����", ReturnName(playerid, 0), ReturnName(userid, 0));
	}
	return 1;
}

CMD:detain(playerid, params[])
{
	new
		userid,
		vehicleid = GetNearestVehicle(playerid, 3);

	if (GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, -1, "�س��ͧ�����˹�ҷ����Ǩ");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/detain [�ʹ�/����]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, -1, "�����蹹����Ѵ���������������");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, -1, "�س��ͧ�����������蹹��");

    if (!BitFlag_Get(g_PlayerFlags[userid],PLAYER_CUFFED))
        return SendClientMessage(playerid, -1, "�����蹹�������١���ح����㹢�й��");

	if (vehicleid == INVALID_VEHICLE_ID)
	    return SendClientMessage(playerid, COLOR_WHITE, "�س������������ö�ѹ�˹���");

	if (GetVehicleMaxSeats(vehicleid) < 1)
  	    return SendClientMessage(playerid, COLOR_WHITE, "�س�������ö�ӵ�Ǣ��ö�ѹ�����");

	/*if (IsPlayerInVehicle(userid, vehicleid))
	{
		TogglePlayerControllable(userid, 1);

		RemoveFromVehicle(userid);
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ���Դ��е���д֧ %s ŧ�Ҩҡ�ҹ��˹�", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	}
	else*/
	{
		new seatid = GetAvailableSeat(vehicleid, 2);

		if (seatid == -1)
		    return SendClientMessage(playerid, COLOR_RED, "������������");

		TogglePlayerControllable(userid, 0);

		StopDragging(userid);
		PutPlayerInVehicle(userid, vehicleid, seatid);

		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ��١�����Ǣ��ö�� %s ", ReturnName(playerid, 0), ReturnName(userid, 0));
	}
	return 1;
}

CMD:eject(playerid, params[]) {

	new
		userid,
		playerName[2][MAX_PLAYER_NAME],
		targetID;

	if(sscanf(params, "u", targetID))
		return SendClientMessage(playerid, COLOR_GREY, "/eject [ID ����Ф�]");

	if(GetPlayerState(playerid) == 2) 
	{
		if(GetPlayerVehicleID(playerid) == GetPlayerVehicleID(targetID)) 
		{

			GetPlayerName(playerid, playerName[0], MAX_PLAYER_NAME);
			GetPlayerName(targetID, playerName[1], MAX_PLAYER_NAME);

			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ���ѡ������ %s ŧ�Ҩҡ�ҹ��˹�", ReturnName(playerid, 0), ReturnName(userid, 0));

			RemovePlayerFromVehicle(targetID);
		}
		else SendClientMessage(playerid, COLOR_GREY, "�����蹹��������������㹾�˹�");
	}
	else SendClientMessage(playerid, COLOR_GREY, "�س��ͧ�����ʶҹм��Ѻö");
	return 1;
}

CMD:mdc(playerid, params[])
{
   	/*if(!IsPlayerConnected(playerid))
	   return SendClientMessage(playerid, COLOR_GREY, "�س��ͧ�������к���͹���������觵�ҧ �");*/
	   
	if (GetFactionType(playerid) != FACTION_POLICE)
		return 1;

	if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_ONDUTY))
        return SendClientMessage(playerid, -1, "�س��ͧ ON-DUTY ��͹");

	Dialog_Show(playerid, DIALOG_LSPD_MDC, DIALOG_STYLE_LIST, "Mobile Data Computer", "{58FA58}�����ʹ�\n{58FA58}���һ��·���¹", "Select", "Cancel");

	return 1;
}

CMD:duty(playerid, params[])
{
	new factionid = Character[playerid][Faction];

 	if (factionid == -1)
	    return SendClientMessage(playerid, -1, "�س�������Ҫԡ�ͧ Faction");

	if (!IsNearFactionLocker(playerid))
	    return SendClientMessage(playerid, -1, "�س���������㹢ͺࢵ�ͧ����红ͧ�ͧ Faction");

    /*if (FactionData[factionid][factionType] == FACTION_POLICE)
    {
        if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_ONDUTY))
        {
	    	BitFlag_On(g_PlayerFlags[playerid], PLAYER_ONDUTY);
		   	SetPlayerArmour(playerid, 100.0);
		   	SetPlayerHealth(playerid, 100.0);

			SetFactionColor(playerid);

			GivePlayerWeapon(playerid, 24, 150);
			GivePlayerWeapon(playerid, 3, 1);
			GivePlayerWeapon(playerid, 41, 5000);

			if (GetFactionType(playerid) == FACTION_POLICE)
			{
				SendFactionMessage(Character[playerid][Faction], COLOR_RADIO, "** HQ: %s %s ���������Ժѵ�˹�ҷ��㹢�й��! **", Faction_GetRank(playerid), ReturnName(playerid, 0));
			}
		}
		else
		{
			BitFlag_Off(g_PlayerFlags[playerid], PLAYER_ONDUTY);
			SetPlayerArmour(playerid, 0.0);
			ResetPlayerWeapons(playerid);

			SetPlayerColor(playerid, COLOR_WHITE);
			SetPlayerSkin(playerid, Character[playerid][Skin]);

           // Resetweaponplayer(playerid);

			if (GetFactionType(playerid) == FACTION_POLICE)
			{
				SendFactionMessage(Character[playerid][Faction], COLOR_RADIO, "** HQ: %s %s ���͡�ҡ��û�Ժѵ�˹�ҷ��㹢�й��! **", Faction_GetRank(playerid), ReturnName(playerid, 0));
			}
		}
	}*/

	if (FactionData[factionid][factionType] == FACTION_MEDIC)
    {
        if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_ONDUTY))
        {
	    	BitFlag_On(g_PlayerFlags[playerid], PLAYER_ONDUTY);
		   	SetPlayerArmour(playerid, 100.0);
		   	SetPlayerHealth(playerid, 100.0);

			SetFactionColor(playerid);

			if (GetFactionType(playerid) == FACTION_MEDIC)
			{
				SendFactionMessage(Character[playerid][Faction], COLOR_RADIO, "** HQ: %s %s ���������Ժѵ�˹�ҷ��㹢�й��! **", Faction_GetRank(playerid), ReturnName(playerid, 0));
			}
		}
		else
		{
			BitFlag_Off(g_PlayerFlags[playerid], PLAYER_ONDUTY);
			SetPlayerArmour(playerid, 0.0);
			ResetPlayerWeapons(playerid);

			SetPlayerColor(playerid, COLOR_WHITE);
			SetPlayerSkin(playerid, Character[playerid][Skin]);

			if (GetFactionType(playerid) == FACTION_MEDIC)
			{
				SendFactionMessage(Character[playerid][Faction], COLOR_RADIO, "** HQ: %s %s ���͡�ҡ��û�Ժѵ�˹�ҷ��㹢�й��! **", Faction_GetRank(playerid), ReturnName(playerid, 0));
			}
		}
	}
	return 1;
}

CMD:place(playerid, params[])
{
    new weaponid, string[128];

	new vehicleid = GetPlayerVehicleID(playerid);

    if (sscanf(params, "d", weaponid))
		return SendClientMessage(playerid, -1, "USE : /place [25/29/31/27/34]");

    if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_ONDUTY))
        return SendClientMessage(playerid, -1, "�س��ͧ ON-DUTY ��͹");

    if (GetFactionType(playerid) == FACTION_POLICE)
	{
	    for (new i = 1; i != MAX_VEHICLES; i ++) if (IsPlayerNearBoot(playerid, i))
		{
		    if(!IsPoliceCar(i))
		    	return SendClientMessage(playerid, -1, "�س�����������������ö���˹�ҷ��!");

		    if (!GetTrunkStatus(i))
		        return SendClientMessage(playerid, -1, "�Դ����ç��ѧö��͹!");

            if(weaponid != GetPlayerWeapon(playerid))
				return SendClientMessage(playerid, -1, "�س��������ظ��Դ�����������!");

	        if(weaponid == 25)
			{
				RemovePlayerWeapon(playerid, 25);
				format(string, sizeof(string), "* %s ��ҡ�׹ Shotgun ����� %s", ReturnName(playerid, 0), ReturnVehicleName(i));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ��ҡ�׹ Shotgun ����� %s", ReturnName(playerid, 0), ReturnVehicleName(i));

			}
			if(weaponid == 29)
			{
				RemovePlayerWeapon(playerid, 29);
				format(string, sizeof(string), "* %s ��ҡ�׹ MP5 ����� %s", ReturnName(playerid, 0), ReturnVehicleName(i));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ��ҡ�׹ MP5 ����� %s", ReturnName(playerid, 0), ReturnVehicleName(i));

			}
			if(weaponid == 31)
			{
				RemovePlayerWeapon(playerid, 31);
				format(string, sizeof(string), "* %s ��ҡ�׹ M4 ����� %s", ReturnName(playerid, 0), ReturnVehicleName(i));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ��ҡ�׹ M4 ����� %s", ReturnName(playerid, 0), ReturnVehicleName(i));

			}
			if(weaponid == 27)
			{
				RemovePlayerWeapon(playerid, 27);
				format(string, sizeof(string), "* %s ��ҡ�׹ Combat Shotgun ����� %s", ReturnName(playerid, 0), ReturnVehicleName(i));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ��ҡ�׹ Combat Shotgun ����� %s", ReturnName(playerid, 0), ReturnVehicleName(i));

			}
			if(weaponid == 34)
			{
				RemovePlayerWeapon(playerid, 34);
				format(string, sizeof(string), "* %s ��ҡ�׹ Sniper ����� %s", ReturnName(playerid, 0), ReturnVehicleName(i));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ��ҡ�׹ Sniper ����� %s", ReturnName(playerid, 0), ReturnVehicleName(i));

			}
		}

	    if(IsPlayerInAnyVehicle(playerid))//if (IsValidVehicle(i) && IsPlayerNearBoot(playerid, i))
		{
		    if(!IsPoliceCar(vehicleid))
		    	return SendClientMessage(playerid, -1, "�س�����������������ö���˹�ҷ��!");

            if(weaponid != GetPlayerWeapon(playerid))
				return SendClientMessage(playerid, -1, "�س��������ظ��Դ�����������!");

			if(weaponid == 25)
			{
				RemovePlayerWeapon(playerid, 25);
				format(string, sizeof(string), "* %s ��ҡ�׹ Shotgun ����� %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ��ҡ�׹ Shotgun ����� %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));

			}
			if(weaponid == 29)
			{
				RemovePlayerWeapon(playerid, 29);
				format(string, sizeof(string), "* %s ��ҡ�׹ MP5 ����� %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ��ҡ�׹ MP5 ����� %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));

			}
			if(weaponid == 31)
			{
				RemovePlayerWeapon(playerid, 31);
				format(string, sizeof(string), "* %s ��ҡ�׹ M4 ����� %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ��ҡ�׹ M4 ����� %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));

			}
			if(weaponid == 27)
			{
				RemovePlayerWeapon(playerid, 27);
				format(string, sizeof(string), "* %s ��ҡ�׹ Combat Shotgun ����� %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ��ҡ�׹ Combat Shotgun ����� %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));

			}
			if(weaponid == 34)
			{
				RemovePlayerWeapon(playerid, 34);
				format(string, sizeof(string), "* %s ��ҡ�׹ Sniper ����� %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ��ҡ�׹ Sniper ����� %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));

			}
		}
	}
	return 1;
}

CMD:takegun(playerid, params[])
{
	new weaponid, string[128];

	new vehicleid = GetPlayerVehicleID(playerid);

    if (sscanf(params, "d", weaponid))
		return SendClientMessage(playerid, -1, "USE : /takegun SLOT ID [1/2/3/4/5]");

    if (GetFactionType(playerid) == FACTION_POLICE)
	{
	    if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_ONDUTY))
        	return SendClientMessage(playerid, -1, "�س��ͧ ON-DUTY ��͹");

	    for (new i = 1; i != MAX_VEHICLES; i ++) if (IsPlayerNearBoot(playerid, i))
		{
		    if(!IsPoliceCar(i))
		    	return SendClientMessage(playerid, -1, "�س�����������������ö���˹�ҷ��!");

		    if (!GetTrunkStatus(i))
		        return SendClientMessage(playerid, -1, "�Դ����ç��ѧö��͹!");

	        if(weaponid == 1)
			{
				GivePlayerWeapon(playerid, 25, 150);
				format(string, sizeof(string), "* %s ����Ժ�׹ Shotgun �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(i));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ����Ժ�׹ Shotgun �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(i));

			}
			if(weaponid == 2)
			{
				GivePlayerWeapon(playerid, 29, 250);
				format(string, sizeof(string), "* %s ����Ժ�׹ MP5 �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(i));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ����Ժ�׹ MP5 �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(i));

			}
			if(weaponid == 3)
			{
				GivePlayerWeapon(playerid, 31, 350);
				format(string, sizeof(string), "* %s ����Ժ�׹ M4 �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(i));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ����Ժ�׹ M4 �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(i));

			}
			if(weaponid == 4)
			{
				GivePlayerWeapon(playerid, 27, 150);
				format(string, sizeof(string), "* %s ����Ժ�׹ Combat Shotgun �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(i));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ����Ժ�׹ Combat Shotgun �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(i));

			}
			if(weaponid == 5)
			{
				GivePlayerWeapon(playerid, 34, 100);
				format(string, sizeof(string), "* %s ����Ժ�׹ Sniper �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(i));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ����Ժ�׹ Sniper �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(i));

			}
		}

	    if(IsPlayerInAnyVehicle(playerid))//if (IsValidVehicle(i) && IsPlayerNearBoot(playerid, i))
		{
		    if(!IsPoliceCar(vehicleid))
		    	return SendClientMessage(playerid, -1, "�س�����������������ö���˹�ҷ��!");

			if(weaponid == 1)
			{
				GivePlayerWeapon(playerid, 25, 150);
				format(string, sizeof(string), "* %s ����Ժ�׹ Shotgun �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ����Ժ�׹ Shotgun �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));

			}
			if(weaponid == 2)
			{
				GivePlayerWeapon(playerid, 29, 250);
				format(string, sizeof(string), "* %s ����Ժ�׹ MP5 �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ����Ժ�׹ MP5 �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));

			}
			if(weaponid == 3)
			{
				GivePlayerWeapon(playerid, 31, 350);
				format(string, sizeof(string), "* %s ����Ժ�׹ M4 �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ����Ժ�׹ M4 �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));

			}
			if(weaponid == 4)
			{
				GivePlayerWeapon(playerid, 27, 150);
				format(string, sizeof(string), "* %s ����Ժ�׹ Combat Shotgun �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ����Ժ�׹ Combat Shotgun �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));

			}
			if(weaponid == 5)
			{
				GivePlayerWeapon(playerid, 34, 100);
				format(string, sizeof(string), "* %s ����Ժ�׹ Sniper �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
				SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);
				SendClientMessageEx(playerid, COLOR_RP, "* %s ����Ժ�׹ Sniper �͡�ҡ %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));

			}
		}
	}
	return 1;
}

CMD:suit(playerid, params[])
{
	new
	    skins[8],
	    factionid = Character[playerid][Faction];

    if (factionid == -1)
	    return SendClientMessage(playerid, -1, "�س�������Ҫԡ�ͧ Faction");

	if (!IsNearFactionLocker(playerid))
	    return SendClientMessage(playerid, -1, "�س���������㹢ͺࢵ�ͧ����红ͧ�ͧ Faction");


 	if (BitFlag_Get(g_PlayerFlags[playerid], PLAYER_ONDUTY))
 	{
		for (new i = 0; i < sizeof(skins); i ++)
		skins[i] = (FactionData[factionid][factionSkins][i]) ? (FactionData[factionid][factionSkins][i]) : (19300);

		ShowModelSelectionMenu(playerid, "Choose Skin", MODEL_SELECTION_FACTION_SKIN, skins, sizeof(skins), -16.0, 0.0, -55.0);
	}
	else SendClientMessage(playerid, -1, "�س�ѧ����� On Duty");
	return 1;
}


CMD:stats(playerid, params[])
{
	ShowStatsForPlayer(playerid, playerid);
	return 1;
}

CMD:invite(playerid, params[])
{
	new
	    userid;

	if (Character[playerid][Faction] == -1)
	    return SendClientMessage(playerid, -1, "�س��ͧ����Ҫԡ�ͧ�������͡����");

	if (Character[playerid][FactionRank] < FactionData[Character[playerid][Faction]][factionRanks] - 1)
	    return SendClientMessageEx(playerid, -1, "�س��ͧ�������ҧ��� %d", FactionData[Character[playerid][Faction]][factionRanks] - 1);

	if (sscanf(params, "u", userid))
	    return SystemMsg(playerid, "/invite [playerid/name]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, -1, "�����蹹����Ѵ���������������");

	if (Character[userid][Faction] == Character[playerid][Faction])
	    return SendClientMessage(playerid, -1, "�����蹹������ǹ˹�觢ͧ�������͡�����س����");

    if (Character[userid][Faction] != -1)
	    return SendClientMessage(playerid, -1, "�����蹹������ǹ˹�觢ͧ�������͡���������������");

	Character[userid][FactionOffer] = playerid;
    Character[userid][FactionOffered] = Character[playerid][Faction];

    SendClientMessageEx(playerid, -1, "�س���觤���ͧ�֧ %s ���������� \"%s\"", ReturnName(userid, 0), Faction_GetName(playerid));
    SendClientMessageEx(userid, -1, "%s ���ʹ����س������� \"%s\" (�� \"/approve faction\")", ReturnName(playerid, 0), Faction_GetName(playerid));

	return 1;
}

CMD:uninvite(playerid, params[])
{
    new
	    userid;

	if (Character[playerid][Faction] == -1)
	    return SendClientMessage(playerid, -1, "�س��ͧ����Ҫԡ�ͧ�������͡����");

	if (Character[playerid][FactionRank] < FactionData[Character[playerid][Faction]][factionRanks] - 1)
	    return SendClientMessageEx(playerid, -1, "�س��ͧ�������ҧ��� %d", FactionData[Character[playerid][Faction]][factionRanks] - 1);

	if (sscanf(params, "u", userid))
	    return SystemMsg(playerid, "/uninvite [playerid/name]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, -1, "�����蹹����Ѵ���������������");

	if (Character[userid][Faction] != Character[playerid][Faction])
	    return SendClientMessage(playerid, -1, "�����蹹�����������ǹ˹�觢ͧ�������͡�������ǡѺ�س");

    SendClientMessageEx(playerid, -1, "�س��ź %s �͡�ҡ \"%s\"", ReturnName(userid, 0), Faction_GetName(playerid));
    SendClientMessageEx(userid, -1, "%s ��ź�س�͡�ҡ�������͡���� \"%s\"", ReturnName(playerid, 0), Faction_GetName(playerid));

    ResetFaction(userid);

	return 1;
}

CMD:giverank(playerid, params[])
{
    new
	    userid,
		rankid;

	if (Character[playerid][Faction] == -1)
	    return SendClientMessage(playerid, -1, "�س��ͧ����Ҫԡ�ͧ�������͡����");

	if (Character[playerid][FactionRank] < FactionData[Character[playerid][Faction]][factionRanks] - 1)
	    return SendClientMessageEx(playerid, -1, "�س��ͧ�������ҧ��� %d", FactionData[Character[playerid][Faction]][factionRanks] - 1);

	if (sscanf(params, "ud", userid, rankid))
	    return SystemMsg(playerid, "/giverank [playerid/name] [rank (1-%d)]", FactionData[Character[playerid][Faction]][factionRanks]);

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, -1, "�����蹹����Ѵ���������������");

	if (userid == playerid)
	    return SendClientMessage(playerid, -1, "�س�������ö��Ѻ�ȵ���ͧ��");

	if (Character[userid][Faction] != Character[playerid][Faction])
	    return SendClientMessage(playerid, -1, "�����蹹�����������ǹ˹�觢ͧ�������͡�������ǡѺ�س");

	if (rankid < 0 || rankid > FactionData[Character[playerid][Faction]][factionRanks])
	    return SendClientMessageEx(playerid, -1, "�ȷ���к����١��ͧ �ȵ�ͧ���������ҧ 1 �֧ %d", FactionData[Character[playerid][Faction]][factionRanks]);

	Character[userid][FactionRank] = rankid;

    SendClientMessageEx(playerid, -1, "�س������͹���˹� %s �� %s (%d)", ReturnName(userid, 0), Faction_GetRank(userid), rankid);
    SendClientMessageEx(userid, -1, "%s ������͹���˹觤س�� %s (%d)", ReturnName(playerid, 0), Faction_GetRank(userid), rankid);

	return 1;
}

CMD:members(playerid, params[])
{
	new factionid = Character[playerid][Faction];

 	if (factionid == -1)
	    return SendClientMessage(playerid, COLOR_WHITE, "�س��ͧ����Ҫԡ�ͧ�������͡����");

	SendClientMessage(playerid, COLOR_WHITE, "Online Members:");

	foreach (new i : Player) if (Character[i][Faction] == factionid) {
		SendClientMessageEx(playerid, COLOR_WHITE, "%s [ID: %d] %s", Faction_GetRank(i), i, ReturnRealName(i, 0));
	}
	return 1;
}

CMD:time(playerid, params[])
{
	new
	    string[128],
		month[12],
		date[6];

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	switch (date[1]) {
	    case 1: month = "January";
	    case 2: month = "February";
	    case 3: month = "March";
	    case 4: month = "April";
	    case 5: month = "May";
	    case 6: month = "June";
	    case 7: month = "July";
	    case 8: month = "August";
	    case 9: month = "September";
	    case 10: month = "October";
	    case 11: month = "November";
	    case 12: month = "December";
	}
//	format(string, sizeof(string), "%d/60 �ҷըж֧ PayCheck",Character[playerid][pMinutes]);
	//SendClientMessage(playerid, COLOR_YELLOW, string);
	SendNearbyMessage(playerid, 30.0, COLOR_RP, "* %s ��Ǩ�ͺ����", ReturnName(playerid, 0));
	ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_watch", 4.0, 0, 0, 0, 0, 0);
	format(string, sizeof(string), "~g~%s %02d %d~n~~b~%02d:%02d:%02d", month, date[0], date[2], date[3], date[4], date[5]);
	GameTextForPlayer(playerid, string, 6000, 1);

	return 1;
}

CMD:logout(playerid,params[])
{
	if(!LoggedIn[playerid])
		return SendClientMessage(playerid, COLOR_RED, "[!] {FFFFFF}�س�ѧ����� Login");

	new str[128];
	if(LoopAnim[playerid])
    {
        LoopAnim[playerid] = 0;
        //TextDrawHideForPlayer(playerid,AnimText[playerid]);
	}

	//GetPlayerPos(playerid, Character[playerid][PosX], Character[playerid][PosY], Character[playerid][PosZ]);
	KillTimer(InactivtyCheck[playerid]);

	format(str, sizeof(str), "%s �͡�ҡ�к�.", GetRoleplayName(playerid));
	SendLocalMessage(playerid, str, Range_Normal, COLOR_GRAY, COLOR_GRAY);
	SendAdminsMessage(1, COLOR_GRAY, str);

	Character_Save(playerid);

	LoggedIn[playerid] = false;
	SetPlayerName(playerid, Account[playerid][Name]);

	Login_Camera(playerid);
	Character_Reset(playerid);
	Characters_Fetch(playerid);

	HideUserPing(playerid);

	printf("%s: Logout.", Account[playerid][Name]);
	return 1;
}

CMD:myfurniture(playerid, params[])
{
    new id = House_Area(playerid);

    if (Furniture_GetCount(id) >= HouseData[id][houseMaxFurniture])
    	return SendClientMessageEx(playerid, -1, "�س��������������㹺�ҹ����§ %d �����ҹ��", HouseData[id][houseMaxFurniture]);

	if (id == -1)
 		return SendClientMessage(playerid, -1, "�س�е�ͧ������ҳ�ࢵ�ͧ��ҹ���ͷ����ҧ���������");

	if (!House_IsOwner(playerid, id))
 		return SendClientMessage(playerid, -1, "�س����ö�ҧ���������㹺�ҹ�ͧ�س��ҹ��");

    OpenInventory(playerid);
	return 1;
}

CMD:furniture(playerid, params[])
{
    new
	    houseid = -1;

	if ((houseid = House_Area(playerid)) != -1 && House_IsOwner(playerid, houseid))
	{
        new
			count = 0,
			string[MAX_HOUSE_FURNITURE * 32];

        for (new i = 0; i != MAX_FURNITURE; i ++) if (count < HouseData[houseid][houseMaxFurniture] && FurnitureData[i][furnitureExists] && FurnitureData[i][furnitureHouse] == houseid) {
    		ListedFurniture[playerid][count++] = i;
			if(GetPlayerInterior(playerid) == 0 && GetPlayerVirtualWorld(playerid) == 0 && FurnitureData[i][furnitureVW] == 0 && FurnitureData[i][furnitureInt] == 0)
    		{
				format(string, sizeof(string), "%s%s (%.2f ����)\n", string, FurnitureData[i][furnitureName], GetPlayerDistanceFromPoint(playerid, FurnitureData[i][furniturePos][0], FurnitureData[i][furniturePos][1], FurnitureData[i][furniturePos][2]));
			}
			else if(GetPlayerInterior(playerid) != 0 && GetPlayerVirtualWorld(playerid) != 0 && FurnitureData[i][furnitureVW] != 0 && FurnitureData[i][furnitureInt] != 0)
			{
				format(string, sizeof(string), "%s%s (%.2f ����)\n", string, FurnitureData[i][furnitureName], GetPlayerDistanceFromPoint(playerid, FurnitureData[i][furniturePos][0], FurnitureData[i][furniturePos][1], FurnitureData[i][furniturePos][2]));
			}
		}
		if (count) {
			Dialog_Show(playerid, ListedFurniture, DIALOG_STYLE_LIST, "Listed Furniture", string, "Select", "Cancel");
     	}
     	else SendClientMessage(playerid, -1, "��ҹ��ѧ����ѧ��������������١�ҧ����");
	}
	else SendClientMessage(playerid, -1, "�س���������㹢ͺࢵ���㹢ͧ��ҹ");
	return 1;
}

CMD:fpickup(playerid, params[])
{
	if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DUCK)
	{
 		new
			count = 0,
			id = Item_Nearest(playerid),
			string[128];

		if (id != -1)
  		{
    		string = "";

			for (new i = 0; i < MAX_DROPPED_ITEMS; i ++) if (count < MAX_LISTED_ITEMS && DroppedItems[i][droppedModel] && IsPlayerInRangeOfPoint(playerid, 1.5, DroppedItems[i][droppedPos][0], DroppedItems[i][droppedPos][1], DroppedItems[i][droppedPos][2]) && GetPlayerInterior(playerid) == DroppedItems[i][droppedInt] && GetPlayerVirtualWorld(playerid) == DroppedItems[i][droppedWorld]) {
   				NearestItems[playerid][count++] = i;

				strcat(string, DroppedItems[i][droppedItem]);
				strcat(string, "\n");
    		}
      		if (count == 1)
      		{
				if (PickupItem(playerid, id))
				{
  					format(string, sizeof(string), "~g~%s~w~ added to InvFurniture!", DroppedItems[id][droppedItem]);
	    			ShowPlayerFooter(playerid, string);
					SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ���� \"%s\".", ReturnName(playerid, 0), DroppedItems[id][droppedItem]);
					Log_Write("logs/droppick.txt", "[%s] %s ���� \"%s\".", ReturnDate(), ReturnName(playerid, 0), DroppedItems[id][droppedItem]);
				}
				else
					SendClientMessage(playerid, -1, "��ͧ�红ͧ Furniture �ͧ�س���");
			}
			else Dialog_Show(playerid, PickupItems, DIALOG_STYLE_LIST, "Pickup Items", string, "Pickup", "Cancel");
		}
	}
	else
	    return SendClientMessage(playerid, -1, "�س��ͧ����㹷�ҹ���ͧ� �� 'C'");
	return 1;
}

CMD:changespawn(playerid, params[])
{
	Dialog_Show(playerid, ChangeSpawn, DIALOG_STYLE_LIST, "�������¹�ش�Դ�ͧ����Ф�", "(1) �Դ�ش����ش\n(2) �ش�Դ Faction\n(3) �ش�Դ��ҹ","Select","Cancel");
	return 1;
}

CMD:help(playerid, params[])
{
	Dialog_Show(playerid, HelpMenu, DIALOG_STYLE_LIST, "���٪��������", "����ǡѺ��þٴ���\n����ǡѺ�ҹ��˹�\n����ǡѺ��ѧ��Ѿ��\n����ǡѺ�Ҫվ\n����", "���͡", "¡��ԡ");
	return 1;
}

CMD:bankhelp(playerid, params[])
{
	SendClientMessage(playerid, -1, "[Bank]: /bank, /withdraw, /savings, /savingswithdraw");
	return 1;
}

CMD:f(playerid, params[])
	return cmd_fac(playerid, params);


CMD:fac(playerid, params[])
{
    new factionid = Character[playerid][Faction];

 	if (factionid == -1)
	    return SystemMsg(playerid, "�س��ͧ����Ҫԡ�ͧ�������͡����");

	if (isnull(params))
	    return SystemMsg(playerid, "/(f)ac [message]");

    if (BitFlag_Get(g_PlayerFlags[playerid], PLAYER_DISABLE_FACTION))
	    return SystemMsg(playerid, "�س��ͧ�Դ�����ҹ᪷�ͧ�������͡������͹");

	SendFactionMessage(factionid, COLOR_FACTION, "(( (%d) %s %s: %s ))", Character[playerid][FactionRank], Faction_GetRank(playerid), ReturnName(playerid, 0), params);
	Log_Write("logs/faction_chat.txt", "[%s] %s %s: %s", ReturnDate(), Faction_GetRank(playerid), ReturnName(playerid, 0), params);
	return 1;
}

CMD:factionhelp(playerid, params[])
{
	SendClientMessageEx(playerid, COLOR_RED, "%s Commands:", Faction_GetName(playerid));

	if(GetFactionType(playerid) == FACTION_POLICE)
	{
		SendClientMessage(playerid, COLOR_ORANGE, "[ ! ]{FFFFFF} /duty, /cuff, /uncuff, /showbadge, /suit, /m(egaphone), /(dep)artment,");
		SendClientMessage(playerid, COLOR_ORANGE, "[ ! ]{FFFFFF} /carsign, /remove_carsign, /taser, /mdc");
		SendClientMessage(playerid, COLOR_RED, "[!]{FFFFFF} /factions, /f");
	}
	else if(GetFactionType(playerid) == FACTION_MEDIC)
	{
		SendClientMessage(playerid, COLOR_ORANGE, "[ ! ]{FFFFFF} /duty, /bandage, /suit, /m(egaphone), /(dep)artment,");
		SendClientMessage(playerid, COLOR_ORANGE, "[ ! ]{FFFFFF} /carsign, /remove_carsign");
		SendClientMessage(playerid, COLOR_RED, "[!]{FFFFFF} /factions, /f");
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "[!]{FFFFFF} �س����� Faction!");
	}

	if(Character[playerid][FactionRank] == 1)
	{
		SendClientMessage(playerid, COLOR_RED, "Leader:{FFFFFF} /invite, /uninvite, /giverank");
	}

	return 1;
}
ALTCMD:fhelp->factionhelp;

CMD:b(playerid, params[])
{
    new str[200];
    if(sscanf(params, "s[200]", str)) return SendClientMessage(playerid, COLOR_GRAY, "/b [message]");

    format(str, sizeof(str), "(( %s: %s ))", GetRoleplayName(playerid), str);
    SendLocalMessage(playerid, str,Range_Normal, COLOR_WHITE, COLOR_WHITE);
    SetPlayerChatBubble(playerid, str, COLOR_GRAY, Range_Normal, 7000);

    return 1;
}

CMD:ame(playerid, params[])
{
	new
	    string[128];

	if (isnull(params))
	    return SystemMsg(playerid, "/ame [action]");

	format(string, sizeof(string), "* %s %s", ReturnName(playerid, 0), params);
 	SetPlayerChatBubble(playerid, string, COLOR_RP, 30.0, 10000);

 	SendClientMessageEx(playerid, COLOR_RP, "* %s %s", ReturnName(playerid, 0), params);
	return 1;
}

CMD:me(playerid, params[])
{
	if (isnull(params))
	    return SystemMsg(playerid, "/me [action]");

	if (strlen(params) > 64) {
	    SendNearbyMessage(playerid, 30.0, COLOR_RP, "* %s %.64s", ReturnRealName(playerid, 0), params);
	    SendNearbyMessage(playerid, 30.0, COLOR_RP, "...%s", params[64]);
	}
	else {
	    SendNearbyMessage(playerid, 30.0, COLOR_RP, "* %s %s", ReturnRealName(playerid, 0), params);
	}
	return 1;
}

CMD:a(playerid, params[])
{
	if (!Account[playerid][Admin])
	    return SendClientMessage(playerid, -1, "�س�����������к�");

	if (isnull(params))
	    return SystemMsg(playerid, "/a [admin text]");

	if (strlen(params) > 64) {
	    SendAdminAlert(COLOR_YELLOW, "*Admin[%d] %s: %.64s", Account[playerid][Admin], ReturnName(playerid, 0), params);
	    SendAdminAlert(COLOR_YELLOW, "...%s", params[64]);
	}
	else {
	    SendAdminAlert(COLOR_YELLOW, "*Admin[%d] %s: %s", Account[playerid][Admin], ReturnName(playerid, 0), params);
	}
	return 1;
}

CMD:do(playerid, params[])
{
	if (isnull(params))
	    return SystemMsg(playerid, "/do [description]");

	if (strlen(params) > 64) {
	    SendNearbyMessage(playerid, 30.0, COLOR_RP, "* %.64s", params);
	    SendNearbyMessage(playerid, 30.0, COLOR_RP, "...%s (( %s ))", params[64], ReturnRealName(playerid, 0));
	}
	else {
	    SendNearbyMessage(playerid, 30.0, COLOR_RP, "* %s (( %s ))", params, ReturnRealName(playerid, 0));
	}
	return 1;
}

CMD:shout(playerid, params[])
{

	if (isnull(params))
	    return SystemMsg(playerid, "/(s)hout [shout text]");

    if (strlen(params) > 64)
	{
	    SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s ��⡹: %.64s", ReturnName(playerid, 0), params);
	    SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "...%s!", params[64]);
	}
	else {
	    SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s ��⡹: %s!", ReturnName(playerid, 0), params);
	}
	return 1;
}

ALTCMD:s->shout;

CMD:low(playerid, params[])
{


	if (isnull(params))
	    return SystemMsg(playerid, "/(l)ow [low text]");

    if (strlen(params) > 64)
	{
	    SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "%s �ٴ���: %.64s", ReturnName(playerid, 0), params);
	    SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "...%s", params[64]);
	}
	else
	{
     	SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "%s �ٴ���: %s", ReturnName(playerid, 0), params);
	}
	return 1;
}
ALTCMD:l->low;

CMD:whisper(playerid, params[])
{
    new str[200], msg[200], pID;
    if(sscanf(params, "us[200]", pID,msg)) return SendClientMessage(playerid, COLOR_GRAY, "/whisper [playerid] [message]");

    if(IsInRangeOfPlayer(playerid, pID, 5))
    {
        format(str, sizeof(str), "%s ��ЫԺ���: %s", GetRoleplayName(playerid), msg);
        SendSplitMessage(pID, COLOR_WHITE, str);
        format(str, sizeof(str), "* %s ��ЫԺ���úҧ���ҧ�Ѻ %s. *", GetRoleplayName(playerid), GetRoleplayName(pID));
        SendLocalMessage(playerid, str, Range_Short, COLOR_RP, COLOR_RP);
        SetPlayerChatBubble(playerid, str, COLOR_RP, Range_Short, 7000);
    }
    else
    {
        InfoBoxForPlayer(playerid, "�س����������������蹹��!.");
    }
    return 1;
}
ALTCMD:w->whisper;

CMD:pm(playerid, params[])
{
    new pID, pmmsg[200], str[200];
    if(sscanf(params, "us[200]", pID, pmmsg)) return SendClientMessage(playerid, COLOR_GRAY, "/pm [playerid] [message]");
    format(str, sizeof(str), "[PM from [%d] %s]: %s", playerid, GetRoleplayName(playerid), pmmsg);
    SendSplitMessage(pID, COLOR_YELLOW, str);

    format(str, sizeof(str), "[PM to [%d] %s]: %s", pID, GetRoleplayName(pID), pmmsg);
    SendSplitMessage(playerid, COLOR_YELLOW, str);
    return 1;
}

CMD:ooc(playerid, params[])
{
    new str[128];

    if(sscanf(params, "s[128]", params)) return SendClientMessage(playerid, COLOR_GRAY, "/(o)oc [message]");
    if(OOCStatus == 1)
    {
		if(Character[playerid][Muted] == 0)
		{
	    	format(str, sizeof(str), "(([OOC] %s: %s ))", GetRoleplayName(playerid), params);
	    	SendClientMessageToAll(COLOR_PALEGOLDENROD, str);
	    }
	    else SendErrorMessage(playerid, "You are muted.");

	}
	else
	{
	    SendErrorMessage(playerid, "��ͧ�ҧ���١�Դ����!");
	}
    return 1;
}
ALTCMD:o->ooc;

CMD:stopmusic(playerid, params[])
{
	StopAudioStreamForPlayer(playerid);
	return 1;
}

CMD:carry(playerid, params[])
{
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
	return 1;
}

/*CMD:admins(playerid, params[])
{
    SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");

    foreach (new i : Player) if (Account[i][Admin] >= 1 && Account[i][Admin] <= 5)
	{
        if (Account[i][AdminDuty] < 1) {
            SendClientMessage(playerid, COLOR_WHITE, "Admins Online:");
			SendClientMessageEx(playerid, COLOR_WHITE, "%s {33CC33}(Level: %d) {FF0000}(Off Duty)", ReturnRealName(i, 0), Account[i][Admin]);

		}
		else if (Account[i][AdminDuty] >= 1) {
		    SendClientMessage(playerid, COLOR_WHITE, "Admins Online:");
			SendClientMessageEx(playerid, COLOR_WHITE, "%s {33CC33}(Level: %d) {33CC33}(On Duty)", ReturnRealName(i, 0), Account[i][Admin]);

		}
	}
	SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
	return 1;
}*/

CMD:report(playerid, params[])
{
	if(systemVariables[reportSystem] == 0)
	{
		if(isnull(params))
		{
		    SendClientMessage(playerid, COLOR_GREY, "/report [��ͤ���]");
		}
		else
		{
		    if(Character[playerid][Report] >= 1)
			{
		        SendClientMessage(playerid, COLOR_WHITE, "�س����§ҹ��ѧ���������� ��س��͡�õͺ��Ѻ�ѡ����");
		    }
		    else
			{
		        if(strlen(params) >= 64)
				{
		            return SendClientMessage(playerid, COLOR_GREY, "��ͤ����������§ҹ�ͧ�س����Թ� ��س����ӡ��� 64 ����ѡ��");
		        }
		        else
				{
				    SendClientMessage(playerid, COLOR_YELLOW, "��§ҹ�ͧ�س��١�������������㹤��");

        			strcpy(Character[playerid][ReportMessage], params, 64);
				    Character[playerid][Report] = 1;

				    submitToAdmins("����§ҹ��Ǣ���������������� ����� '/reports list' ���ʹ�", 0xFF0066AA);
			    }
		    }
		}
	}
	else {
	    SendClientMessage(playerid, COLOR_WHITE, "�к��������§ҹ�١�Դ㹢�й�� �١�����ա����������ѧ");
	}

	return 1;
}

CMD:clearanimation(playerid, params[])
{
	ClearAnimations(playerid);
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_HANDSUP) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
	return 1;
}
ALTCMD:clearanim->clearanimation;

CMD:handsup(playerid, params[])
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
	return 1;
}

CMD:clearchat(playerid, params[])
{
	for(new i = 0; i < 100; i++)
	{
		SendClientMessage(playerid, COLOR_WHITE, "");
	}
	return 1;
}

CMD:buyveh(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -1952.8511,298.1530,35.4688))
	{
	    return SendClientMessage(playerid, COLOR_WHITE, "�س�������������ҹ���ö");
	}
	/*if(GetSpawnedVehicles(playerid) >= MAX_SPAWNED_VEHICLES)
    {
        return SendClientMessageEx(playerid, COLOR_GREY, "[�к�] {FFFFFF}ö�ͧ�س�ʹ�ú %d �ѹ���� ��س��纤ѹ㴤ѹ�֧", MAX_SPAWNED_VEHICLES);
    }*/

	Dialog_Show(playerid, DIALOG_PICKCAR, DIALOG_STYLE_LIST, "[ Vehicle Shop ]", "\
    - Motorcycle\n\
    - Car", "Select", "Cancel");

	return 1;
}
