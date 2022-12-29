// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>


#define CMD_PREFIX "!"
#define BOT_CHANNEL ""
#define BOT_NAME ""
#define CHANNEL_ID ""


#include <DiscordC>

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Demo Script.");
	print("--------------------------------------\n");
	return 1;
}

public OnDCCommandPerformed(args[], success)
{
	if(!success) return SendDC(CHANNEL_ID, "```js\nInvalid command..!\n```");
	return 1;
}

DC_CMD:m(user, args)
{
 	new msg[50];
	if(sscanf(args, "s[50]", msg)) return SendDC(CHANNEL_ID, ""CMD_PREFIX"m [Msg]");
	SendDC(CHANNEL_ID, "%s: %s", user, msg);
	return 1;
}
DC_CMD:test(user, args)
{
	SendDC(CHANNEL_ID, "Works!");
	return 1;
}

