#include <YSI\y_hooks>

#include <a_samp>
#define CMD_PREFIX "/" // change this to your need
#define BOT_CHANNEL "admin" // change this
#define BOT_NAME "WORP" //change this
#define CHANNEL_ID "714603061754069113" // change this
#define COLOR_RED 0xFF0000FF
#include <dcc>

forward kicktimer(playerid);
public kicktimer(playerid)
{
	Kick(playerid);
	return 1;
}

DC_CMD:kick(user, args)
{
    new id, giveplayer[MAX_PLAYER_NAME], string[64];
    if(sscanf(args,"u[24]",id)) return SendDC(CHANNEL_ID, "```Usage: /kick [playerid]```");
    else if(!IsPlayerConnected(id))  return SendDC(CHANNEL_ID, "**Player is not connected.**");
    GetPlayerName(id, giveplayer, MAX_PLAYER_NAME);
    SendDC(CHANNEL_ID, "```Player %s has been kicked.```", giveplayer);
    format(string, sizeof(string), "%s has been kicked from the server.", giveplayer);
    SendClientMessageToAll(COLOR_RED, string);
    SetTimerEx("kicktimer", 500, false, "i", id);
    return 1;
}
DC_CMD:asay(user, args)
{
    new str[145], message[512];
    if (sscanf(args, "s[512]", message)) return SendDC(CHANNEL_ID, "```Usage: /asay [message]```");
	format(str, sizeof str, "{d80000}Admin [%s]: %s", user, message);
	SendDC(CHANNEL_ID, "```Admin [%s]: %s```", message, user);
    SendClientMessageToAll(-1, str);
    return 1;
}
DC_CMD:cmds(author, params, channel)
{
 	SendDC(CHANNEL_ID, "**-Commands- **");
	SendDC(CHANNEL_ID, "```cmds, kick, asay, freeze, unfreeze, players```");
	return 1;
}
DC_CMD:freeze(user, args)
{
	new giveplayerid, giveplayer[MAX_PLAYER_NAME];
	if (sscanf(args, "u", giveplayerid)) return SendDC(CHANNEL_ID, "```Usage: /freeze [playerid]```");
	if (!IsPlayerConnected(giveplayerid)) return SendDC(CHANNEL_ID, "**Error: Inactive player id!**");
	TogglePlayerControllable(giveplayerid, 0);
	GetPlayerName(giveplayerid, giveplayer, MAX_PLAYER_NAME);
	SendClientMessage(giveplayerid, COLOR_RED, "You have been frozen by an admin.");
	SendDC(CHANNEL_ID, "``` Player %s has been frozen.```", giveplayer);
	return 1;
}

DC_CMD:unfreeze(user, args)
{
    new giveplayerid, giveplayer[MAX_PLAYER_NAME];
	if (sscanf(args, "u", giveplayerid)) return SendDC(CHANNEL_ID, "```Usage: /unfreeze [playerid]```");
	if (!IsPlayerConnected(giveplayerid)) return SendDC(CHANNEL_ID, "**Error: Inactive player id!**");
    TogglePlayerControllable(giveplayerid, 1);
    GetPlayerName(giveplayerid, giveplayer, MAX_PLAYER_NAME);
	SendClientMessage(giveplayerid, COLOR_RED, "You have been unfrozen by an admin.");
	SendDC(CHANNEL_ID, "``` Player %s has been unfrozen.```", giveplayer);
	return 1;
}
DC_CMD:players(user, args)
{
    new count = 0;
	new name[24];
	SendDC(CHANNEL_ID, "**__Online Players__**");
	for(new i=0; i < MAX_PLAYERS; i++) {
	if(!IsPlayerConnected(i)) continue;
	GetPlayerName(i, name, MAX_PLAYER_NAME);
	{
	   SendDC(CHANNEL_ID, "```%s(%d)```", name, i);
	   count++; }
	}
	if (count == 0) return SendDC(CHANNEL_ID, "There are no players online.");
	return 1;
}

hook OnPlayerConnect(playerid)
{
    new name[24];
    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
    SendDC(CHANNEL_ID, " ```%s has joined the server.```", name);
}

hook OnPlayerDisconnect(playerid, reason)
{
    new name[24];
    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
    SendDC(CHANNEL_ID, " ```%s has joined the server.```", name);
}