#include	<YSI_Coding\y_hooks>

#include 	<discord-cmd>
#include 	<discord-connector>

#define     CH_DCC_ID     "" //1227539043357691904

new DCC_Channel:SavagesCity_Discord;
new DCC_Channel:Savages_EveryOne;
new DCC_Channel:Savages_BannedChannel;
/*
new DCC_Channel:Medic_OnDuty;
new DCC_Channel:Medic_OffDuty;
*/
hook OnGameModeInit()
{
    SavagesCity_Discord = DCC_FindChannelById("1227539043357691904");
    Savages_EveryOne = DCC_FindChannelById("1227539043357691904");
    Savages_BannedChannel = DCC_FindChannelById("1227539043357691904");

    DC_SendEmbedMessage(CH_DCC_ID, "SERVER Has OPENED", "https://discord.gg/Vn29uj3gYy",  DCC_ReturnTimedata(), "-------------------------------------\nSAMP : Black Woods Semi-Roleplay", 0x66FF33, "https://cdn.discordapp.com/attachments/1225443618471284747/1225443719478513684/Samp_BlackWood_LOGO.png?ex=66212666&is=660eb166&hm=55c9f5c0d8fcc9576c76b95f5efc774ce15cd5a06b114646eacc3e73ef475cd0&");
    return 1;
    /*Medic_OnDuty = DCC_FindChannelById("904789219673780224");
    Medic_OffDuty = DCC_FindChannelById("904789273520250900");*/
}

hook OnGameModeExit()
{
    DC_SendEmbedMessage(CH_DCC_ID, "SERVER Has Closed", "https://discord.gg/Vn29uj3gYy",  DCC_ReturnTimedata(), "-------------------------------------\nSAMP : Black Woods Semi-Roleplay", 0x990000, "https://cdn.discordapp.com/attachments/1225443618471284747/1225443719478513684/Samp_BlackWood_LOGO.png?ex=66212666&is=660eb166&hm=55c9f5c0d8fcc9576c76b95f5efc774ce15cd5a06b114646eacc3e73ef475cd0&");
    return 1;
}

DCMD:help(user, channel, params[])
{
	if (channel != SavagesCity_Discord)
	    return DCC_SendChannelMessage(channel, "1");

    new str[356];

    format(str,sizeof(str),"2");
    DCC_SendChannelMessage(SavagesCity_Discord, str);

	format(str,sizeof(str),"3");
    DCC_SendChannelMessage(SavagesCity_Discord, str);

	format(str,sizeof(str),"4");
    DCC_SendChannelMessage(SavagesCity_Discord, str);

	format(str,sizeof(str),"`5");
    DCC_SendChannelMessage(SavagesCity_Discord, str);

    format(str,sizeof(str),"6");
	DCC_SendChannelMessage(SavagesCity_Discord, str);

	return 1;
}


DCMD:ban(user, channel, params[])
{
	new str_Whitelist[512], str[512];

	if (channel != SavagesCity_Discord)
	    return DCC_SendChannelMessage(channel, "`��ิด��ลาด : สำหรั����ู��ดู��ลดิส��อร��ดเท��า��ั���`");

	if (isnull(params))
		return DCC_SendChannelMessage(channel, "`��าร��������า�� : !ban [��ื��อตัวละ��ร��ู��เล����]`");

	foreach (new i : Player)
	{
	    if (!strcmp(GetPlayerNameEx(i), params, true))
	    {
			SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s �١ẹ�� IRONPIE BOT, ���˵�: Discord-Banned", GetPlayerNameEx(i));
			playerData[i][pBan] = 1;
			Ban(i);
			DelayedKick(i);
	    }
	}

	mysql_format(g_SQL, str_Whitelist, sizeof str_Whitelist, "UPDATE `players` SET `playerBan` = 1 , `playerBanReason` = 'Discord-Banned' WHERE `playerName` = '%s'", SQL_ReturnEscaped(params));
	mysql_tquery(g_SQL, str_Whitelist);

	format(str,sizeof(str),"`��������เตือ�� : %s ��ด��ถู��������ออ����า��เ��ิร����เวอร��เรีย��ร��อย��ล��ว`", params);
	DCC_SendChannelMessage(SavagesCity_Discord, str);

	format(str,sizeof(str),"`��ระ��าศ : %s ถู��������อย��า��ถาวร��า��เ��ิร����เวอร����ล��ว` @everyone", params);
	DCC_SendChannelMessage(Savages_BannedChannel, str);

	return 1;
}

DCMD:givecoin(user, channel, params[])
{
	new str_Whitelist[512], str[512];

    new playerName[32], amount;

	if (channel != SavagesCity_Discord)
	    return DCC_SendChannelMessage(channel, "`��ิด��ลาด : สำหรั����ู��ดู��ลดิส��อร��ดเท��า��ั���`");

    if(sscanf(params, "s[32]d", playerName, amount))
		return DCC_SendChannelMessage(channel, "`��าร��������า�� : !givecoin [��ื��อตัวละ��ร] [��ำ��ว��ที��ต��อ����าร]`");

	foreach (new i : Player)
	{
	    if (!strcmp(GetPlayerNameEx(i), params, true))
	    {
	        UpdateplayerData(i);
			playerData[i][pCoin] += amount;
		    SendClientMessageEx(i, -1, "{097BFA}IRONPIEBOT : {A0CBFB}�س���Ѻ 'Coin' �����ӹǹ '%s' �ҡ����๷���Ѻ���������", FormatNumber(amount));
	    }
	}

	mysql_format(g_SQL, str_Whitelist, sizeof str_Whitelist, "UPDATE `players` SET `playerCoin`=`playerCoin`+%d WHERE `playerName`='%s'", amount, SQL_ReturnEscaped(playerName));
	mysql_tquery(g_SQL, str_Whitelist);

	format(str,sizeof(str),"`��������เตือ�� : ��ุณ��ด��ทำ��ารเ��ิ��ม��อย������ห����ั�� %s เ��������ำ��ว�� %s เรีย��ร��อย��ล��ว`", playerName, FormatNumber(amount));
	DCC_SendChannelMessage(SavagesCity_Discord, str);

	format(str,sizeof(str),"`��ระ��าศ : ��ู��เล���� %s ��ด��ทำ��าร��ดเ��ท��ห����ั��เ��ิร����เวอร����ละ��ด��รั�� Coin ��ำ��ว�� %s` @everyone", playerName, FormatNumber(amount));
	DCC_SendChannelMessage(Savages_EveryOne, str);

	return 1;
}






DCC_ReturnTimedata()
{
	new sendString[90], month, day, year;
	new hour, minute, second;
	gettime(hour, minute, second);
	getdate(year, month, day);
	
	format(sendString, sizeof(sendString), "<:timer:864657839879094343>     %d/%d/%d %02d:%02d:%02d", day, month, year, hour, minute, second);
	return sendString;
}

static DC_SendEmbedMessage(const channel[], const caption[], const url[], const description[], const description_2[], color, const image_url[])
{
    //System By Phayakko_Phayakka , Scum Samp Thai (����ź������)

    new DCC_Embed:embed = DCC_CreateEmbed(caption);
    DCC_SetEmbedUrl(embed, url);//������ҡ� caption
    DCC_SetEmbedColor(embed, color);//�բͧ embed
    DCC_SetEmbedThumbnail(embed, image_url);//����ٻ�Ҿ
    DCC_AddEmbedField(embed,description, description_2, true);//��ͤ�����͸Ժ��
    DCC_SendChannelEmbedMessage(DCC_FindChannelById(channel), embed); //�觢�ͤ���
    return 0;
}
