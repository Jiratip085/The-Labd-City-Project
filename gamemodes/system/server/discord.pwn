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
	    return DCC_SendChannelMessage(channel, "`à¸ÿà¸´à¸”à¸ÿà¸¥à¸²à¸” : à¸ªà¸³à¸«à¸£à¸±à¸ÿà¸ÿà¸¹à¹ÿà¸”à¸¹à¹ÿà¸¥à¸”à¸´à¸ªà¸ÿà¸­à¸£à¹ÿà¸”à¹€à¸—à¹ÿà¸²à¸ÿà¸±à¹ÿà¸`");

	if (isnull(params))
		return DCC_SendChannelMessage(channel, "`à¸ÿà¸²à¸£à¹ÿà¸ÿà¹ÿà¸ÿà¸²à¸ÿ : !ban [à¸ÿà¸·à¹ÿà¸­à¸•à¸±à¸§à¸¥à¸°à¸ÿà¸£à¸ÿà¸¹à¹ÿà¹€à¸¥à¹ÿà¸ÿ]`");

	foreach (new i : Player)
	{
	    if (!strcmp(GetPlayerNameEx(i), params, true))
	    {
			SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s ¶Ù¡áº¹â´Â IRONPIE BOT, ÊÒàËµØ: Discord-Banned", GetPlayerNameEx(i));
			playerData[i][pBan] = 1;
			Ban(i);
			DelayedKick(i);
	    }
	}

	mysql_format(g_SQL, str_Whitelist, sizeof str_Whitelist, "UPDATE `players` SET `playerBan` = 1 , `playerBanReason` = 'Discord-Banned' WHERE `playerName` = '%s'", SQL_ReturnEscaped(params));
	mysql_tquery(g_SQL, str_Whitelist);

	format(str,sizeof(str),"`à¹ÿà¸ÿà¹ÿà¸ÿà¹€à¸•à¸·à¸­à¸ÿ : %s à¹ÿà¸”à¹ÿà¸–à¸¹à¸ÿà¹ÿà¸ÿà¸ÿà¸­à¸­à¸ÿà¸ÿà¸²à¸ÿà¹€à¸ÿà¸´à¸£à¹ÿà¸ÿà¹€à¸§à¸­à¸£à¹ÿà¹€à¸£à¸µà¸¢à¸ÿà¸£à¹ÿà¸­à¸¢à¹ÿà¸¥à¹ÿà¸§`", params);
	DCC_SendChannelMessage(SavagesCity_Discord, str);

	format(str,sizeof(str),"`à¸ÿà¸£à¸°à¸ÿà¸²à¸¨ : %s à¸–à¸¹à¸ÿà¹ÿà¸ÿà¸ÿà¸­à¸¢à¹ÿà¸²à¸ÿà¸–à¸²à¸§à¸£à¸ÿà¸²à¸ÿà¹€à¸ÿà¸´à¸£à¹ÿà¸ÿà¹€à¸§à¸­à¸£à¹ÿà¹ÿà¸¥à¹ÿà¸§` @everyone", params);
	DCC_SendChannelMessage(Savages_BannedChannel, str);

	return 1;
}

DCMD:givecoin(user, channel, params[])
{
	new str_Whitelist[512], str[512];

    new playerName[32], amount;

	if (channel != SavagesCity_Discord)
	    return DCC_SendChannelMessage(channel, "`à¸ÿà¸´à¸”à¸ÿà¸¥à¸²à¸” : à¸ªà¸³à¸«à¸£à¸±à¸ÿà¸ÿà¸¹à¹ÿà¸”à¸¹à¹ÿà¸¥à¸”à¸´à¸ªà¸ÿà¸­à¸£à¹ÿà¸”à¹€à¸—à¹ÿà¸²à¸ÿà¸±à¹ÿà¸`");

    if(sscanf(params, "s[32]d", playerName, amount))
		return DCC_SendChannelMessage(channel, "`à¸ÿà¸²à¸£à¹ÿà¸ÿà¹ÿà¸ÿà¸²à¸ÿ : !givecoin [à¸ÿà¸·à¹ÿà¸­à¸•à¸±à¸§à¸¥à¸°à¸ÿà¸£] [à¸ÿà¸³à¸ÿà¸§à¸ÿà¸—à¸µà¹ÿà¸•à¹ÿà¸­à¸ÿà¸ÿà¸²à¸£]`");

	foreach (new i : Player)
	{
	    if (!strcmp(GetPlayerNameEx(i), params, true))
	    {
	        UpdateplayerData(i);
			playerData[i][pCoin] += amount;
		    SendClientMessageEx(i, -1, "{097BFA}IRONPIEBOT : {A0CBFB}¤Ø³ä´éÃÑº 'Coin' à¾ÔèÁ¨Ó¹Ç¹ '%s' ¨Ò¡¡ÒÃâ´à¹·ãËé¡Ñºà«ÔÃì¿àÇÍÃì", FormatNumber(amount));
	    }
	}

	mysql_format(g_SQL, str_Whitelist, sizeof str_Whitelist, "UPDATE `players` SET `playerCoin`=`playerCoin`+%d WHERE `playerName`='%s'", amount, SQL_ReturnEscaped(playerName));
	mysql_tquery(g_SQL, str_Whitelist);

	format(str,sizeof(str),"`à¹ÿà¸ÿà¹ÿà¸ÿà¹€à¸•à¸·à¸­à¸ÿ : à¸ÿà¸¸à¸“à¹ÿà¸”à¹ÿà¸—à¸³à¸ÿà¸²à¸£à¹€à¸ÿà¸´à¹ÿà¸¡à¸ÿà¸­à¸¢à¸ÿà¹ÿà¹ÿà¸«à¹ÿà¸ÿà¸±à¸ÿ %s à¹€à¸ÿà¹ÿà¸ÿà¸ÿà¸³à¸ÿà¸§à¸ÿ %s à¹€à¸£à¸µà¸¢à¸ÿà¸£à¹ÿà¸­à¸¢à¹ÿà¸¥à¹ÿà¸§`", playerName, FormatNumber(amount));
	DCC_SendChannelMessage(SavagesCity_Discord, str);

	format(str,sizeof(str),"`à¸ÿà¸£à¸°à¸ÿà¸²à¸¨ : à¸ÿà¸¹à¹ÿà¹€à¸¥à¹ÿà¸ÿ %s à¹ÿà¸”à¹ÿà¸—à¸³à¸ÿà¸²à¸£à¹ÿà¸”à¹€à¸ÿà¸—à¹ÿà¸«à¹ÿà¸ÿà¸±à¸ÿà¹€à¸ÿà¸´à¸£à¹ÿà¸ÿà¹€à¸§à¸­à¸£à¹ÿà¹ÿà¸¥à¸°à¹ÿà¸”à¹ÿà¸£à¸±à¸ÿ Coin à¸ÿà¸³à¸ÿà¸§à¸ÿ %s` @everyone", playerName, FormatNumber(amount));
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
    //System By Phayakko_Phayakka , Scum Samp Thai (ËéÒÁÅºáÅÐá¡éä¢)

    new DCC_Embed:embed = DCC_CreateEmbed(caption);
    DCC_SetEmbedUrl(embed, url);//ÅÔé§àÇÅÒ¡´ caption
    DCC_SetEmbedColor(embed, color);//ÊÕ¢Í§ embed
    DCC_SetEmbedThumbnail(embed, image_url);//ÅÔé§ÃÙ»ÀÒ¾
    DCC_AddEmbedField(embed,description, description_2, true);//¢éÍ¤ÇÒÁ¤ÓÍ¸ÔºÒÂ
    DCC_SendChannelEmbedMessage(DCC_FindChannelById(channel), embed); //Êè§¢éÍ¤ÇÒÁ
    return 0;
}
