#include <YSI_Coding\y_hooks>
#include <a_samp>

CMD:anims(playerid,params[])
{
	return ShowAnimsDialog(playerid);
}

CMD:stopanims(playerid,params[])
{
	return ClearAnimations(playerid, 1);
}

#if defined _nanimation_included
	#endinput
#endif
#define _nanimation_included


#define anims_folder "Anims/"
#define anims_dialog 4156


new anims_String[1000];
new anims_lastlib[MAX_PLAYERS][50];

#define Loop(%0,%1) \
	for(new %0 = 0; %0 != %1; %0++)

static const sAnimList[][50] = { 
{"AIRPORT"},
{"ATTRACTORS"},
{"BAR"},
{"BASEBALL"},
{"BD_FIRE"},
{"BEACH"},
{"BENCHPRESS"},
{"BF_INJECTION"},
{"BIKED"},
{"BIKEH"},
{"BIKELEAP"},
{"BIKES"},
{"BIKEV"},
{"BIKE_DBZ"},
{"BMX"},
{"BOMBER"},
{"BOX"},
{"BSKTBALL"},
{"BUDDY"},
{"BUS"},
{"CAMERA"},
{"CAR"},
{"CARRY"},
{"CAR_CHAT"},
{"CASINO"},
{"CHAINSAW"},
{"CHOPPA"},
{"CLOTHES"},
{"COACH"},
{"COLT45"},
{"COP_AMBIENT"},
{"COP_DVBYZ"},
{"CRACK"},
{"CRIB"},
{"DAM_JUMP"},
{"DANCING"},
{"DEALER"},
{"DILDO"},
{"DODGE"},
{"DOZER"},
{"DRIVEBYS"},
{"FAT"},
{"FIGHT_B"},
{"FIGHT_C"},
{"FIGHT_D"},
{"FIGHT_E"},
{"FINALE"},
{"FINALE2"},
{"FLAME"},
{"FLOWERS"},
{"FOOD"},
{"FREEWEIGHTS"},
{"GANGS"},
{"GHANDS"},
{"GHETTO_DB"},
{"GOGGLES"},
{"GRAFFITI"},
{"GRAVEYARD"},
{"GRENADE"},
{"GYMNASIUM"},
{"HAIRCUTS"},
{"HEIST9"},
{"INT_HOUSE"},
{"INT_OFFICE"},
{"INT_SHOP"},
{"JST_BUISNESS"},
{"KART"},
{"KISSING"},
{"KNIFE"},
{"LAPDAN1"},
{"LAPDAN2"},
{"LAPDAN3"},
{"LOWRIDER"},
{"MD_CHASE"},
{"MD_END"},
{"MEDIC"},
{"MISC"},
{"MTB"},
{"MUSCULAR"},
{"NEVADA"},
{"ON_LOOKERS"},
{"OTB"},
{"PARACHUTE"},
{"PARK"},
{"PAULNMAC"},
{"PED"},
{"PLAYER_DVBYS"},
{"PLAYIDLES"},
{"POLICE"},
{"POOL"},
{"POOR"},
{"PYTHON"},
{"QUAD"},
{"QUAD_DBZ"},
{"RAPPING"},
{"RIFLE"},
{"RIOT"},
{"ROB_BANK"},
{"ROCKET"},
{"RUSTLER"},
{"RYDER"},
{"SCRATCHING"},
{"SHAMAL"},
{"SHOP"},
{"SHOTGUN"},
{"SILENCED"},
{"SKATE"},
{"SMOKING"},
{"SNIPER"},
{"SPRAYCAN"},
{"STRIP"},
{"SUNBATHE"},
{"SWAT"},
{"SWEET"},
{"SWIM"},
{"SWORD"},
{"TANK"},
{"TATTOOS"},
{"TEC"},
{"TRAIN"},
{"TRUCK"},
{"UZI"},
{"VAN"},
{"VENDING"},
{"VORTEX"},
{"WAYFARER"},
{"WEAPONS"},
{"WUZI"},
{"WOP"},
{"GFUNK"},
{"RUNNINGMAN"},
{"SAMP"}
};


stock ShowAnimsDialog(playerid)
{
	if(strlen(anims_lastlib[playerid]) == 0)
	{
		anims_String = "\0";//Reset the global string
		anims_lastlib[playerid] = "\0";
		Loop(i,sizeof(sAnimList))
		{
			format(anims_String,sizeof(anims_String),"%s%s\n",anims_String,sAnimList[i]);
		}
		ShowPlayerDialog(playerid, anims_dialog, DIALOG_STYLE_LIST, "Please Choose an animation Library", anims_String, "Select", "Cancel");
	}
	else
	{
		ShowAnimsLib(playerid,anims_lastlib[playerid]);
	}
	ClearAnimations(playerid, 1);
	return 1;

}

stock GetAnimsLibFromId(libid)
{
	new tmp[50];
	if(libid > sizeof(sAnimList))
	{
		printf("[N_ANIMS] Animation liabrary id %i is an invalid id",libid);
		format(tmp,sizeof(tmp),"Unknown");
	}
	else
	{
		format(tmp,sizeof(tmp),"%s",sAnimList[libid]);
	}
	return tmp;
}

stock ShowAnimsLib(playerid,lib[])
{
	new path[128];
	anims_String = "\0";//Reset the global string

	format(path, sizeof(path), "%s%s.txt", anims_folder,n_animtrim(lib));
	if(!fexist(path))
	{
		printf("[N_ANIMS] Animation liabrary %s not found. Check if %s is in your scriptfiles directory",lib,path);
		anims_lastlib[playerid] = "\0";
		return 1;
	}
	else
	{
		new line[128],File:anims_list = fopen(path, io_read), anims_title[128];
		
		while(fread(anims_list, line))
		{
			format(anims_String,sizeof(anims_String),"%s%s",anims_String,line);
		}
		fclose(anims_list);
		format(anims_title,sizeof(anims_title),"Please Choose an animation ( Animations/%s )",lib);

		ApplyAnimation(playerid,lib,"null",0.0,0,0,0,0,0);
		
		ShowPlayerDialog(playerid, anims_dialog+1, DIALOG_STYLE_LIST, anims_title, anims_String, "Select", "Cancel");

	}
	return 1;
}


hook OnPlayerDisconnect(playerid, reason)
{

	anims_lastlib[playerid] = "\0";


	#if defined NA_OnPlayerDisconnect
	    return NA_OnPlayerDisconnect(playerid, reason);
	#else
	    return 1;
	#endif
}


//I forgot where i got this, but i did not make it, full credit to the owner.
#define _strlib_included
#define _strlib_sma_string 128
#define _strlib_med_string 256
#define _strlib_big_string 512
stock n_animtrim(const sSource[])//Trim any und wanted chars from the source
{
    new
    iBegin,
    iEnd,
    iInputLength = strlen(sSource),
    sReturn[_strlib_med_string];

    strcat(sReturn, sSource, _strlib_med_string);

    for(iBegin = 0; iBegin < iInputLength; ++iBegin) {
        switch(sReturn[iBegin]) {
            case ' ', '\t', '\r', '\n':
            {
                continue;
            }
            default:
            {
                break;
            }
        }
    }

    for(iEnd = (iInputLength - 1); iEnd > iBegin; --iEnd) {
        switch(sReturn[iEnd]) {
            case ' ', '\t', '\r', '\n':
            {
                continue;
            }
            default:
            {
                break;
            }
        }
    }

    strdel(sReturn, (iEnd + 1), iInputLength);
    strdel(sReturn, 0, iBegin);

    return sReturn;
}


#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse NA_OnDialogResponse

#if defined NA_OnDialogResponse
	forward NA_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif



#if defined _ALS_OnPlayerDisconnect
	#undef OnDialogResponse
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define NA_OnPlayerDisconnect

#if defined NA_OnPlayerDisconnect

#endif









alias:animhelp("ท่าทางทั้งหมด")
CMD:animhelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_GREEN,"________________อนิเมชั่นตัวละคร________________");
	SendClientMessage(playerid, COLOR_WHITE,"[นั่ง/นอน] /sit /chairsit /groundsit /seat /sleep /lean");
	SendClientMessage(playerid, COLOR_WHITE,"[สัญญาณมือ] /gsign /salute");
	SendClientMessage(playerid, COLOR_WHITE,"[การสื่อสาร] /greet /taxiL /taxiR");
    SendClientMessage(playerid, COLOR_WHITE,"[การสื่อสาร] /fuckyou /wave /kiss /no");
    SendClientMessage(playerid, COLOR_WHITE,"[กริยาทางกายภาพ] /bat /punch /taunt /facepalm /aim /slapass");
    SendClientMessage(playerid, COLOR_WHITE,"[กริยาทางกายภาพ] /hide /crawl /crack /think /sipdrink /sipdrink2");
    SendClientMessage(playerid, COLOR_WHITE,"[อารมณ์] /cry /injured /panic");
    SendClientMessage(playerid, COLOR_GREEN,"_____________________________________________");


	new str[3500];
    strcat(str, "/fall | /fallback | /injured | /akick | /push | /lowbodypush | /handsup | /bomb | /drunk | /getarrested | /laugh | /sup\n");
    strcat(str, "/basket | /headbutt | /medics | /spray | /robman | /taichi | /lookout | /kiss | /cellin | /cellout | /crossarms | /lay\n");
	strcat(str, "/deal | /crack | /groundsit | /chat  | /dance | /fucku | /strip | /hide | /vomit | /chairsit | /reload\n");
    strcat(str, "/koface | /kostomach | /rollfall | /bat | /die | /joint | /bed | /lranim | /fixcar | /fixcarout\n");
    strcat(str, "/lifejump | /exhaust | /leftslap | /carlock | /hoodfrisked | /lightcig | /tapcig | /box | /lay2 | /chant | /fuckyou| /fuckyou2\n");
    strcat(str, "/shouting | /knife | /cop | /elbow | /kneekick | /airkick | /gkick | /punch | /gpunch | /fstance | /lowthrow | /highthrow | /aim\n");
    strcat(str, "/pee | /lean | /run | /poli | /surrender | /sit | /breathless | /seat | /rap | /cross | /jiggy | /gsign\n");
    strcat(str, "/sleep | /smoke | /pee | /chora | /relax | /crabs | /stop | /wash | /mourn | /fuck | /tosteal | /crawl\n");
    strcat(str, "/followme | /greet | /still | /hitch | /palmbitch | /cpranim | /giftgiving | /slap2 | /pump | /cheer\n");
    strcat(str, "/dj | /foodeat | /wave | /slapass | /dealer | /dealstance | /inbedright | /inbedleft\n");
	strcat(str, "/wank | /bj | /getup | /follow | /stand | /slapped | /yes | /celebrate | /win | /checkout\n");
	strcat(str, "/thankyou | /invite1 | /scratch | /nod | /cry | /carsmoke | /benddown | /facepalm | /angry\n");
	strcat(str, "/cockgun | /bar | /liftup | /putdown | /camera | /think | /handstand | /panicjump\n");
    Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "ท่าทางอื่น ๆ", str, "โอเค", "");
	return 1;
}

CMD:anim(playerid, params[])
{
	new targetid, type;
	if(sscanf(params,"ud",targetid,type)) {
		SendClientMessage(playerid, COLOR_WHITE, "การใช้: /anim [ไอดีผู้เล่น/ชื่อบางส่วน] [style]");
		SendClientMessage(playerid, COLOR_GREEN, "[1] Kiss || [2-10] Handshake");
		return 1;
	}

	if(targetid == INVALID_PLAYER_ID)
		SendClientMessage(playerid, COLOR_RED, "- {FFFFFF}ผู้เล่นนั้นตัดการเชื่อมต่อ");

	if(targetid == playerid) 
		return SendClientMessage(playerid, COLOR_RED, "- {FFFFFF}คุณไม่สามารถทักทายตัวเองได้");

	if(type > 10 || type < 1) 
		return SendClientMessage(playerid, COLOR_RED, "- {FFFFFF}จำนวนรูปแบบท่าทางร่วมมีแค่ 1-10");

	if (!IsPlayerNearPlayer(playerid, targetid, 2.5)) 
		return SendClientMessage(playerid,COLOR_RED, "- {FFFFFF}ผู้เล่นนั้นไม่ได้อยู่ใกล้คุณ");

	SetPVarInt(playerid, "SentGreet", 1);
	SetPVarInt(playerid, "GreetType", type);
	SetPVarInt(targetid, "GreetFrom", playerid);
	SetPVarInt(targetid, "GettingGreet", 1);

	SendClientMessageEx(playerid, COLOR_YELLOW, "- คุณได้ขอทักทายกับ %s เรียบร้อย กรุณารอการตอบกลับ", GetPlayerNameEx(targetid));

	Dialog_Show(targetid, DIALOG_ANIM, DIALOG_STYLE_MSGBOX, "Animetion", "(ID: %d)%s\nต้องการจะทักทายกับคุณ", "ตกลง", "ปฎิเสธ", playerid, GetPlayerNameEx(playerid));
	playerData[playerid][pAnimationID] = targetid;
	return 1;
}
Dialog:DIALOG_ANIM(playerid, response, listitem, inputtext[])
{
	new targetid = playerData[playerid][pAnimationID];
	if (response)
	{

		if(targetid == INVALID_PLAYER_ID) 
		{
			return SendClientMessage(playerid, COLOR_RED, "- {FFFFFF}ผู้เล่นนั้นตัดการเชื่อมต่อ");
		}
		if(targetid == playerid) 
			return SendClientMessage(playerid, COLOR_RED, "- {FFFFFF}คุณไม่สามารถทักทายตัวเองได้");

		if (!IsPlayerNearPlayer(playerid, targetid, 3.0))
			return SendClientMessage(playerid, COLOR_RED, "- {FFFFFF}ผู้เล่นนั้นไม่ได้อยู่ใกล้คุณ");

		if (AnimationCheck(playerid)) 
			return SendClientMessage(playerid, COLOR_RED, "- {FFFFFF}คุณไม่สามารถทักทายได้ในขณะนี้");

		if (AnimationCheck(targetid)) 
			return SendClientMessage(playerid, COLOR_RED, "- {FFFFFF}ผู้เล่นนี้ไม่สามารถทักทายคุณได้ในขณะนี้");

		new type = GetPVarInt(targetid, "GreetType");

		ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		playerData[playerid][pAnimation] = 0;

		ApplyAnimationEx(targetid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
		SetPlayerSpecialAction(targetid, SPECIAL_ACTION_NONE);
		playerData[targetid][pAnimation] = 0;

		SetPlayerFacePlayer(playerid, targetid);
		SetPlayerFacePlayer(targetid, playerid);


		if(type == 1)
		{
			ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 2.0, 0, 0, 1, 0, 0);
			ApplyAnimation(targetid, "KISSING", "Playa_Kiss_02", 2.0, 0, 0, 1, 0, 0);
		}
		else if(type == 2)
		{
			ApplyAnimation(playerid,"GANGS","prtial_hndshk_biz_01", 2.0, 0, 0, 0, 0, 0);
			ApplyAnimation(targetid,"GANGS","prtial_hndshk_biz_01", 2.0, 0, 0, 0, 0, 0);
		}
		else if(type == 3)
		{
			ApplyAnimation(playerid,"GANGS","hndshkba", 2.0, 0, 0, 0, 0, 0);
			ApplyAnimation(targetid,"GANGS","hndshkba", 2.0, 0, 0, 0, 0, 0);
		}
		else if(type == 4)
		{
			ApplyAnimation(playerid,"GANGS","hndshkca", 2.0, 0, 0, 0, 0, 0);
			ApplyAnimation(targetid,"GANGS","hndshkca", 2.0, 0, 0, 0, 0, 0);
		}
		else if(type == 5)
		{
			ApplyAnimation(playerid,"GANGS","hndshkcb", 2.0, 0, 0, 0, 0, 0);
			ApplyAnimation(targetid,"GANGS","hndshkcb", 2.0, 0, 0, 0, 0, 0);
		}
		else if(type == 6)
		{
			ApplyAnimation(playerid,"GANGS","hndshkda", 2.0, 0, 0, 0, 0, 0);
			ApplyAnimation(targetid,"GANGS","hndshkda", 2.0, 0, 0, 0, 0, 0);
		}
		else if(type == 7)
		{
			ApplyAnimation(playerid,"GANGS","hndshkea", 2.0, 0, 0, 0, 0, 0);
			ApplyAnimation(targetid,"GANGS","hndshkea", 2.0, 0, 0, 0, 0, 0);
		}
		else if(type == 8)
		{
			ApplyAnimation(playerid,"GANGS","hndshkfa", 2.0, 0, 0, 0, 0, 0);
			ApplyAnimation(targetid,"GANGS","hndshkfa", 2.0, 0, 0, 0, 0, 0);
		}
		else if(type == 9)
		{
			ApplyAnimation(playerid,"GANGS","hndshkaa", 2.0, 0, 0, 0, 0, 0);
			ApplyAnimation(targetid,"GANGS","hndshkaa", 2.0, 0, 0, 0, 0, 0);
		}
		else if(type == 10)
		{
			ApplyAnimation(playerid,"GANGS","hndshkfa_swt", 2.0, 0, 0, 0, 0, 0);
			ApplyAnimation(targetid,"GANGS","hndshkfa_swt", 2.0, 0, 0, 0, 0, 0);
		}
		DeletePVar(GetPVarInt(playerid, "GreetFrom"), "SentGreet");
		DeletePVar(GetPVarInt(playerid, "GreetFrom"), "GreetType");
		DeletePVar(playerid, "GreetFrom");
		DeletePVar(playerid, "GettingGreet");
		return 1;
	}
	else
	{
		return SendClientMessageEx(targetid, COLOR_LIGHTRED, "%s ปฎิเสธการทักทายของคุณ", GetPlayerNameEx(playerid));
	}
}

CMD:stopanim(playerid)
{
	if ((playerData[playerid][pAnimation] || GetPlayerCameraMode(playerid) == 55) && GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) {
		playerData[playerid][pAnimation] = 0;
		ClearAnimations(playerid);
		return 1;
	}

	if(playerData[playerid][pAnimation]) {
		ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		ClearAnimations(playerid);
		playerData[playerid][pAnimation] = 0;
	}
	return 1;
}
//alias:stopanim("sa");

CMD:no(playerid, params[])
{
    ApplyAnimation(playerid, "PED","endchat_02", 4.1, 0, 0, 0, 0, 0);
   	return 1;
}
//alias:no("ไม่");

CMD:punch(playerid, params[])
{
    ApplyAnimation(playerid, "RIOT", "RIOT_PUNCHES", 4.1, 0, 1, 1, 0, 0, 0);
    return 1;
}
//alias:punch("ต่อย", "ชก");

CMD:crawl(playerid, params[])
{

    ApplyAnimation(playerid, "PED", "CAR_CRAWLOUTRHS", 4.1, 0, 0, 0, 0, 0, 0);
    return 1;
}
//alias:crawl("คลาน");

CMD:sipdrink(playerid, params[])
{

    ApplyAnimation(playerid, "BAR", "DNK_STNDM_LOOP", 4.1, 0, 0, 0, 0, 0, 0);
    return 1;
}

CMD:sipdrink2(playerid, params[])
{

    ApplyAnimation(playerid, "BAR", "DNK_STNDF_LOOP", 4.1, 0, 0, 0, 0, 0, 0);
    return 1;
}

CMD:surrender(playerid,params[])
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && !AnimationCheck(playerid))
	{
		playerData[playerid][pAnimation] = 1;
	    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
  		return 1;
	}
	else return SendClientMessage(playerid, COLOR_GREY, "ไม่สามารถเล่น Animation ได้ในขณะนี้");
}
//alias:surrender("ยอม", "มอบตัว");

CMD:sit(playerid,params[])
{
    new anim;
    if(sscanf(params, "d", anim)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /sit [1-5]");

	playerData[playerid][pAnimation] = 1;

    switch(anim){
		case 1: ApplyAnimation(playerid,"BEACH","bather",4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"BEACH","Lay_Bac_Loop",4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid,"BEACH","ParkSit_W_loop",4.1, 0, 1, 1, 1, 1, 1);
		case 4: ApplyAnimation(playerid,"BEACH","SitnWait_loop_W",4.1, 0, 1, 1, 1, 1, 1);
		case 5: ApplyAnimation(playerid,"BEACH","SitnWait_loop_W",4.1, 0, 1, 1, 1, 1, 1);
		case 6: ApplyAnimation(playerid,"BEACH", "ParkSit_M_loop", 4.1, 0, 1, 1, 1, 1, 1);
		default: {
			return SendClientMessage(playerid, COLOR_GREY, "การใช้: /sit [1-5]");
		}
	}
	return 1;
}
//alias:sit("นั่ง");

CMD:sleep(playerid,params[])
{
	new anim;

	if(sscanf(params, "d", anim)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /sleep [1-2]");
	playerData[playerid][pAnimation] = 1;
	switch(anim){
		case 1: ApplyAnimation(playerid,"CRACK","crckdeth4",4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"CRACK","crckidle2",4.1, 0, 1, 1, 1, 1, 1);
		default: {
			return SendClientMessage(playerid, COLOR_GREY, "การใช้: /sleep [1-2]");
		}
	}
	return 1;
}

CMD:salute(playerid, params[])
{

    playerData[playerid][pAnimation] = 1;

    ApplyAnimation(playerid, "GHANDS", "GSIGN5LH", 4.1, false, false, false, false, 0, false);
    return 1;
}

CMD:cheer(playerid,params[])
{
	new anim;

	if(sscanf(params, "d", anim)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /cheer [1-8]");
	playerData[playerid][pAnimation] = 1;
	switch(anim){
		case 1: ApplyAnimation(playerid,"ON_LOOKERS","shout_01",4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"ON_LOOKERS","shout_02",4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid,"ON_LOOKERS","shout_in",4.1, 0, 1, 1, 1, 1, 1);
		case 4: ApplyAnimation(playerid,"RIOT","RIOT_ANGRY_B",4.1, 0, 1, 1, 1, 1, 1);
		case 5: ApplyAnimation(playerid,"RIOT","RIOT_CHANT",4.1, 0, 1, 1, 1, 1, 1);
		case 6: ApplyAnimation(playerid,"RIOT","RIOT_shout",4.1, 0, 1, 1, 1, 1, 1);
		case 7: ApplyAnimation(playerid,"STRIP","PUN_HOLLER",4.1, 0, 1, 1, 1, 1, 1);
		case 8: ApplyAnimation(playerid,"OTB","wtchrace_win",4.1, 0, 1, 1, 1, 1, 1);
		default: {
			return SendClientMessage(playerid, COLOR_GREY, "การใช้: /cheer [1-8]");
		}
	}
	return 1;
}
//alias:cheer("เชียร์");

CMD:dj(playerid,params[]){
    new anim;
    if(sscanf(params, "d", anim)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /dj [1-4]");
	playerData[playerid][pAnimation] = 1;
    switch(anim){
		case 1: ApplyAnimation(playerid,"SCRATCHING","scdldlp",4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"SCRATCHING","scdlulp",4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid,"SCRATCHING","scdrdlp",4.1, 0, 1, 1, 1, 1, 1);
		case 4: ApplyAnimation(playerid,"SCRATCHING","scdrulp",4.1, 0, 1, 1, 1, 1, 1);
		default: {
			return SendClientMessage(playerid, COLOR_GREY, "การใช้: /dj [1-4]");
		}
	}
	return 1;
}

CMD:breathless(playerid,params[]){
    new anim;
    if(sscanf(params, "d", anim)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /breathless [1-2]");
	playerData[playerid][pAnimation] = 1;
    switch(anim){
		case 1: ApplyAnimation(playerid,"PED","IDLE_tired",4.1, 1, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"FAT","IDLE_tired",4.1, 1, 1, 1, 1, 1, 1);
        default: {
			return SendClientMessage(playerid, COLOR_GREY, "การใช้: /breathless [1-2]");
		}
	}
	return 1;
}

CMD:poli(playerid,params[]){
    new anim;
    if(sscanf(params, "d", anim)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /poli [1-2]");
	playerData[playerid][pAnimation] = 1;
	switch(anim){
		case 1:ApplyAnimation(playerid,"POLICE","CopTraf_Come",4.1, 0, 1, 1, 1, 1, 1);
		case 2:ApplyAnimation(playerid,"POLICE","CopTraf_Stop",4.1, 0, 1, 1, 1, 1, 1);
		default: {
			return SendClientMessage(playerid, COLOR_GREY, "การใช้: /poli [1-2]");
		}
	}
	return 1;
}

CMD:seat(playerid,params[]){
    new anim;
    if(sscanf(params, "d", anim)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /seat [1-7]");
	if(anim < 1 || anim > 7) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /seat [1-7]");
	playerData[playerid][pAnimation] = 1;
	switch(anim){
		case 1: ApplyAnimation(playerid,"Attractors","Stepsit_in",4.1, 0, 0, 0, 1, 0, 0);
		case 2: ApplyAnimation(playerid,"CRIB","PED_Console_Loop",4.1, 0, 0, 0, 1, 0, 0);
		case 3: ApplyAnimation(playerid,"INT_HOUSE","LOU_In",4.1, 0, 0, 0, 1, 0, 0);
		case 4: ApplyAnimation(playerid,"MISC","SEAT_LR",4.1, 0, 0, 0, 1, 0, 0);
		case 5: ApplyAnimation(playerid,"MISC","Seat_talk_01",4.1, 0, 0, 0, 1, 0, 0);
		case 6: ApplyAnimation(playerid,"MISC","Seat_talk_02",4.1, 0, 0, 0, 1, 0, 0);
		case 7: ApplyAnimation(playerid,"ped","SEAT_down",4.1, 0, 0, 0, 1, 0, 0);
	}
	return 1;
}

CMD:dance(playerid,params[]){
    new dancestyle;
    if(sscanf(params, "d", dancestyle)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /dance [1-3]");
	playerData[playerid][pAnimation] = 1;
	switch(dancestyle){
		case 1: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
		case 2: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
		case 3: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
		case 4: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
	}
   	return 1;
}

CMD:cross(playerid,params[]){
    new anim;
    if(sscanf(params, "d", anim)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /cross [1-5]");
	playerData[playerid][pAnimation] = 1;
	switch(anim){
		case 1: ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid, "DEALER", "DEALER_IDLE", 4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid, "DEALER", "DEALER_IDLE_01", 4.1, 0, 1, 1, 1, 1, 1);
		case 4: ApplyAnimation(playerid,"GRAVEYARD","mrnM_loop",4.1, 0, 1, 1, 1, 1, 1);
		case 5: ApplyAnimation(playerid,"GRAVEYARD","prst_loopa",4.1, 0, 1, 1, 1, 1, 1);
		default: return SendClientMessage(playerid, COLOR_GREY, "การใช้: /cross [1-5]");
	}
	return 1;
}

CMD:jiggy(playerid,params[])
{
    new anim;
    if(sscanf(params, "d", anim)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /jiggy [1-10]");
	playerData[playerid][pAnimation] = 1;
	switch(anim){
		case 1: ApplyAnimation(playerid,"DANCING","DAN_Down_A",4.1, 1, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"DANCING","DAN_Left_A",4.1, 1, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid,"DANCING","DAN_Loop_A",4.1, 1, 1, 1, 1, 1, 1);
		case 4: ApplyAnimation(playerid,"DANCING","DAN_Right_A",4.1, 1, 1, 1, 1, 1, 1);
		case 5: ApplyAnimation(playerid,"DANCING","DAN_Up_A",4.1, 1, 1, 1, 1, 1, 1);
		case 6: ApplyAnimation(playerid,"DANCING","dnce_M_a",4.1, 1, 1, 1, 1, 1, 1);
		case 7: ApplyAnimation(playerid,"DANCING","dnce_M_b",4.1, 1, 1, 1, 1, 1, 1);
		case 8: ApplyAnimation(playerid,"DANCING","dnce_M_c",4.1, 1, 1, 1, 1, 1, 1);
		case 9: ApplyAnimation(playerid,"DANCING","dnce_M_c",4.1, 1, 1, 1, 1, 1, 1);
		case 10: ApplyAnimation(playerid,"DANCING","dnce_M_d",4.1, 1, 1, 1, 1, 1, 1);
		default: return SendClientMessage(playerid, COLOR_GREY, "การใช้: /jiggy [1-10]");
	}
	return 1;
}

CMD:rap(playerid,params[]){
    new rapstyle;
    if(sscanf(params, "d", rapstyle)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /rap [1-3]");
	playerData[playerid][pAnimation] = 1;
	switch(rapstyle){
		case 1: ApplyAnimation(playerid,"RAPPING","RAP_A_Loop",4.1, 1, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"RAPPING","RAP_B_Loop",4.1, 1, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid,"RAPPING","RAP_C_Loop",4.1, 1, 1, 1, 1, 1, 1);
		default: return SendClientMessage(playerid, COLOR_GREY, "การใช้: /rap [1-3]");
	}
   	return 1;
}

CMD:gsign(playerid,params[]){
    new gesture;
    if(sscanf(params, "d", gesture)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /gsign [1-15]");
	playerData[playerid][pAnimation] = 1;
	switch(gesture){
		case 1: ApplyAnimation(playerid,"GHANDS","gsign1",4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"GHANDS","gsign1LH",4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid,"GHANDS","gsign2",4.1, 0, 1, 1, 1, 1, 1);
		case 4: ApplyAnimation(playerid,"GHANDS","gsign2LH",4.1, 0, 1, 1, 1, 1, 1);
		case 5: ApplyAnimation(playerid,"GHANDS","gsign3",4.1, 0, 1, 1, 1, 1, 1);
		case 6: ApplyAnimation(playerid,"GHANDS","gsign3LH",4.1, 0, 1, 1, 1, 1, 1);
		case 7: ApplyAnimation(playerid,"GHANDS","gsign4",4.1, 0, 1, 1, 1, 1, 1);
		case 8: ApplyAnimation(playerid,"GHANDS","gsign4LH",4.1, 0, 1, 1, 1, 1, 1);
		case 9: ApplyAnimation(playerid,"GHANDS","gsign5",4.1, 0, 1, 1, 1, 1, 1);
		case 10: ApplyAnimation(playerid,"GHANDS","gsign5",4.1, 0, 1, 1, 1, 1, 1);
		case 11: ApplyAnimation(playerid,"GHANDS","gsign5LH",4.1, 0, 1, 1, 1, 1, 1);
		case 12: ApplyAnimation(playerid,"GANGS","Invite_No",4.1, 0, 1, 1, 1, 1, 1);
		case 13: ApplyAnimation(playerid,"GANGS","Invite_Yes",4.1, 0, 1, 1, 1, 1, 1);
		case 14: ApplyAnimation(playerid,"GANGS","prtial_gngtlkD",4.1, 0, 1, 1, 1, 1, 1);
		case 15: ApplyAnimation(playerid,"GANGS","smkcig_prtl",4.1, 0, 1, 1, 1, 1, 1);
		default: return SendClientMessage(playerid, COLOR_GREY, "การใช้: /gsign [1-15]");
	}
	return 1;
}

CMD:smoke(playerid,params[]){
    new gesture;
    if(sscanf(params, "d", gesture)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /smoke [1-2]");
	playerData[playerid][pAnimation] = 1;
	switch(gesture){
		case 1: ApplyAnimation(playerid,"SMOKING","M_smk_in",4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"SMOKING","M_smklean_loop",4.1, 0, 1, 1, 1, 1, 1);
		default: return SendClientMessage(playerid, COLOR_GREY, "การใช้: /smoke [1-2]");
	}
	return 1;
}

CMD:chora(playerid,params[]) { ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_watch",4.1, 0, 1, 1, 1, 1, 1); return 1; }
CMD:relax(playerid,params[]) { ApplyAnimation(playerid, "CRACK", "crckidle1",4.1, 0, 1, 1, 1, 1, 1); return 1; }
CMD:crabs(playerid,params[]) { ApplyAnimation(playerid,"MISC","Scratchballs_01",4.1, 0, 1, 1, 1, 1, 1); return 1; }
CMD:stop(playerid,params[]) { ApplyAnimation(playerid,"PED","endchat_01",4.1, 0, 1, 1, 1, 1, 1); return 1; }
CMD:wash(playerid,params[]) { ApplyAnimation(playerid,"BD_FIRE","wash_up",4.1, 0, 0, 0, 0, 0, 0); return 1; }
CMD:mourn(playerid,params[]) { ApplyAnimation(playerid,"GRAVEYARD","mrnF_loop",4.1, 0, 1, 1, 1, 1, 1); return 1; }
CMD:followme(playerid,params[]) { ApplyAnimation(playerid,"WUZI","Wuzi_follow",4.1, 0, 1, 1, 1, 1, 1); return 1; }
CMD:still(playerid,params[]) { ApplyAnimation(playerid,"WUZI","Wuzi_stand_loop", 4.1, 0, 1, 1, 1, 1, 1); return 1; }
CMD:hitch(playerid,params[]) { ApplyAnimation(playerid,"MISC","Hiker_Pose", 4.1, 0, 1, 1, 1, 1, 1); return 1; }
CMD:palmbitch(playerid,params[]) { ApplyAnimation(playerid,"MISC","bitchslap",4.1, 0, 1, 1, 1, 1, 1); return 1; }
CMD:cpranim(playerid,params[]) { ApplyAnimation(playerid,"MEDIC","CPR",4.1, 0, 1, 1, 1, 1, 1); return 1; }
CMD:giftgiving(playerid,params[]) { ApplyAnimation(playerid,"KISSING","gift_give",4.1, 0, 1, 1, 1, 1, 1); return 1; }
CMD:slap2(playerid,params[]) { ApplyAnimation(playerid,"SWEET","sweet_ass_slap",4.1, 0, 1, 1, 0, 0, 1); return 1; }

CMD:taxiL(playerid) {
	ApplyAnimation(playerid,"MISC","Hiker_Pose_L",4.1, 0, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}

CMD:taxiR(playerid) {
	ApplyAnimation(playerid,"MISC","Hiker_Pose",4.1, 0, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}


CMD:handstand(playerid) {
	ApplyAnimation(playerid,"DAM_JUMP","DAM_Dive_Loop",4.1, 0, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}

CMD:panicjump(playerid) {
	ApplyAnimation(playerid,"DODGE","Crush_Jump",4.1, 0, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}

CMD:drunk(playerid,params[]) {
	ApplyAnimation(playerid,"PED","WALK_DRUNK",4.1, 1, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}
CMD:pump(playerid,params[]) { ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 1, 1, 0, 1, 1); return 1; }
CMD:tosteal(playerid,params[]) { ApplyAnimation(playerid,"ped", "ARRESTgun", 4.1, 0, 1, 1, 1, 1, 1); return 1; }
CMD:laugh(playerid,params[]) { ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.1, 0, 1, 1, 1, 1, 1); return 1; }
CMD:lookout(playerid,params[])  {
	ApplyAnimation(playerid, "SHOP", "ROB_Shifty", 4.1, 0, 1, 1, 0, 0, 1);
	return 1;
}
CMD:robman(playerid,params[]) { ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.1, 0, 1, 1, 1, 1, 1); return 1; }
CMD:hide(playerid,params[]) {
	ApplyAnimation(playerid, "ped", "cower",4.1, 0, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}
CMD:vomit(playerid,params[]) { ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 4.1, 0, 1, 1, 1, 1, 1); return 1; }
CMD:crack(playerid,params[]) {
	new choice;
	if(sscanf(params, "d", choice))
	{
		SendClientMessage(playerid, COLOR_GREY, "การใช้: /crack [1-3]");
		return 1;
	}
	playerData[playerid][pAnimation] = 1;
	switch(choice) {
		case 1: ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid, "CRACK","crckidle3", 4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid, "CRACK","crckidle4", 4.1, 0, 1, 1, 1, 1, 1);
	}
	return 1;
}
CMD:fuck(playerid,params[]) { ApplyAnimation(playerid,"PED","fucku",4.1, 0, 1, 1, 1, 1, 1); return 1; }
CMD:taichi(playerid,params[]) {
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"PARK","Tai_Chi_Loop", 4.1, 1, 1, 1, 1, 1, 1);
	return 1;
}
CMD:kiss(playerid,params[]) { ApplyAnimation(playerid,"KISSING","Playa_Kiss_01",4.1, 0, 1, 1, 0, 1, 1); return 1; }

CMD:handsup(playerid, params[])//19 1:00 pm , 4/27/2012
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid, "ROB_BANK","SHP_HandsUp_Scr",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:cellin(playerid, params[])// 20 1:01 pm, 4/27/2012
{
	if(AnimationCheck(playerid)) return SendClientMessage(playerid, COLOR_GREY, "ไม่สามารถเล่น Animation ได้ในขณะนี้");
	playerData[playerid][pAnimation] = 1;
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
	return 1;
}
CMD:cellout(playerid, params[])//21 1:02 pm , 4/27/2012
{
	if(AnimationCheck(playerid)) return SendClientMessage(playerid, COLOR_GREY, "ไม่สามารถเล่น Animation ได้ในขณะนี้");
	playerData[playerid][pAnimation] = 1;
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
	return 1;
}
CMD:bomb(playerid, params[])//23 4/27/2012
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.1, 1, 1, 1, 1, 1, 1); // Place Bomb
	return 1;
}
CMD:getarrested(playerid, params[])//24 4/27/2012
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"ped", "ARRESTgun", 4.1, 0, 1, 1, 1, 1, 1); // Gun Arrest
	return 1;
}
CMD:crossarms(playerid, params[])//28
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 0, 1, 1, 1, 1, 1); // Arms crossed
	return 1;
}

CMD:lay(playerid, params[])//29
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"BEACH", "bather",4.1, 0, 1, 1, 1, 1, 1); // Lay down
	return 1;
}

CMD:foodeat(playerid, params[])//32
{
	ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 1, 1, 1); // Eat Burger
	return 1;
}

CMD:wave(playerid, params[])//33
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 4.1, 1, 1, 1, 1, 1, 1); // Wave
	return 1;
}

CMD:slapass(playerid, params[])//34
{
	ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.1, 0, 1, 1, 0, 0, 1); // Ass Slapping
 	return 1;
}

CMD:dealer(playerid, params[])//35
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.1, 0, 1, 1, 1, 1, 1); // Deal Drugs
	return 1;
}

CMD:groundsit(playerid, params[])//38
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"BEACH", "ParkSit_M_loop", 4.1, 0, 1, 1, 1, 1, 1); // Sit
	return 1;
}

CMD:chat(playerid, params[])//39
{
	new num;
	if(sscanf(params, "i", num)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /chat [1-2]");
	if(num > 2 || num < 1) { SendClientMessage(playerid, COLOR_GREY, "การใช้: /chat [1-2]"); }
	playerData[playerid][pAnimation] = 1;
	if(num == 1) { ApplyAnimation(playerid,"PED","IDLE_CHAT",4.1, 1, 1, 1, 1, 1, 1); }
	else { ApplyAnimation(playerid,"MISC","Idle_Chat_02",4.1, 1, 1, 1, 1, 1, 1); }
    return 1;
}

CMD:fucku(playerid, params[])//40
{
	ApplyAnimation(playerid,"PED","fucku",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:chairsit(playerid, params[])//42
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"PED","SEAT_idle",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:fall(playerid, params[])//43
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"PED","KO_skid_front",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:fallback(playerid, params[])//44
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid, "PED","FLOOR_hit_f", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:injured(playerid, params[])//46
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:sup(playerid, params[])//47
{
	new number;
	if(sscanf(params, "i", number)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /sup [1-3]");
	if(number < 1 || number > 3) { SendClientMessage(playerid, COLOR_GREY, "การใช้: /sup [1-3]"); }
	playerData[playerid][pAnimation] = 1;
	if(number == 1) { ApplyAnimation(playerid,"GANGS","hndshkba",4.1, 0, 1, 1, 1, 1, 1); }
	if(number == 2) { ApplyAnimation(playerid,"GANGS","hndshkda",4.1, 0, 1, 1, 1, 1, 1); }
    if(number == 3) { ApplyAnimation(playerid,"GANGS","hndshkfa_swt",4.1, 0, 1, 1, 1, 1, 1); }
   	return 1;
}

CMD:push(playerid, params[])// 49
{
	ApplyAnimation(playerid,"GANGS","shake_cara",4.1, 0, 1, 1, 0, 1, 1);
    return 1;
}

CMD:akick(playerid, params)// 50
{
	ApplyAnimation(playerid,"POLICE","Door_Kick",4.1, 0, 1, 1, 0, 1, 1);
    return 1;
}

CMD:lowbodypush(playerid, params[])// 51
{
	ApplyAnimation(playerid,"GANGS","shake_carSH",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}

CMD:spray(playerid, params[])// 52
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"SPRAYCAN","spraycan_full",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:headbutt(playerid, params[])//53
{
	ApplyAnimation(playerid,"WAYFARER","WF_Fwd",4.1, 0, 1, 1, 0, 0, 1);
	return 1;
}

CMD:medics(playerid, params[])//54
{
	ApplyAnimation(playerid,"MEDIC","CPR",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}

CMD:koface(playerid, params[])//55
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"PED","KO_shot_face",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:kostomach(playerid, params[])//56
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"PED","KO_shot_stom",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:lifejump(playerid, params[])//57
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"PED","EV_dive",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:exhaust(playerid, params[])//58
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"PED","IDLE_tired",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:leftslap(playerid, params[])//59
{
	ApplyAnimation(playerid,"PED","BIKE_elbowL",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}

CMD:rollfall(playerid, params[])//60
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"PED","BIKE_fallR",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:carlock(playerid, params[])//61
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"PED","CAR_doorlocked_LHS",4.1, 0, 1, 1, 0, 0, 1);
	return 1;
}

CMD:hoodfrisked(playerid, params[])//66
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"POLICE","crm_drgbst_01",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:lightcig(playerid, params[])//67
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"SMOKING","M_smk_in",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:tapcig(playerid, params[])//68
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"SMOKING","M_smk_tap",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:bat(playerid, params[])//69
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"BASEBALL","Bat_IDLE",4.1, 1, 1, 1, 1, 1, 1);
    return 1;
}

CMD:box(playerid, params[])//70
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"GYMNASIUM","GYMshadowbox",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:lay2(playerid, params[])//71
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"SUNBATHE","Lay_Bac_in",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:chant(playerid, params[])//72
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"RIOT","RIOT_CHANT",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}

CMD:fuckyou(playerid, params[])//73
{
	if (AnimationCheck(playerid)) return SendClientMessage(playerid, COLOR_GREY, "ไม่สามารถเล่น Animation ได้ในขณะนี้");
    playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"RIOT","RIOT_FUKU",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}

CMD:fuckyou2(playerid, params[])
{

    playerData[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "RIOT", "RIOT_FUKU", 4.0, 0, 0, 0, 0, 0, 0);
    return 1;
}

CMD:fixcar(playerid, params[])
{

    playerData[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "CAR", "FIXN_CAR_LOOP", 4.1, 0, 0, 0, 1, 0, 0);
    return 1;
}

CMD:fixcarout(playerid, params[])
{

    playerData[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "CAR", "FIXN_CAR_OUT", 4.1, 0, 0, 0, 0, 0, 0);
    return 1;
}

CMD:shouting(playerid, params[])//74
{
	ApplyAnimation(playerid,"RIOT","RIOT_shout",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}

CMD:cop(playerid,params[])//75
{
	ApplyAnimation(playerid,"SWORD","sword_block",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:elbow(playerid, params[])//76
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"FIGHT_D","FightD_3",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:kneekick(playerid, params[])//77
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"FIGHT_D","FightD_2",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:fstance(playerid, params[])//78
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"FIGHT_D","FightD_IDLE",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:gpunch(playerid, params[])//79
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"FIGHT_B","FightB_G",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:airkick(playerid, params[])//80
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"FIGHT_C","FightC_M",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:gkick(playerid, params[])//81
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"FIGHT_D","FightD_G",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:lowthrow(playerid, params[])//82
{
	ApplyAnimation(playerid,"GRENADE","WEAPON_throwu",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}

CMD:highthrow(playerid, params[])//83
{
	ApplyAnimation(playerid,"GRENADE","WEAPON_throw",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:dealstance(playerid, params[])//84
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"DEALER","DEALER_IDLE",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:pee(playerid, params[])//85
{
	if(AnimationCheck(playerid)) return SendClientMessage(playerid, COLOR_GREY, "ไม่สามารถเล่น Animation ได้ในขณะนี้");
	playerData[playerid][pAnimation] = 1;
	SetPlayerSpecialAction(playerid, 68);
    return 1;
}

CMD:knife(playerid, params[])//86
{
	new nbr;
	if(sscanf(params, "i", nbr)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /knife [1-4]");
    if(nbr < 1 || nbr > 4) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /knife [1-4]");
	playerData[playerid][pAnimation] = 1;
	switch(nbr)
	{
		case 1: { ApplyAnimation(playerid,"KNIFE","KILL_Knife_Ped_Damage",4.1, 0, 1, 1, 1, 1, 1); }
		case 2: { ApplyAnimation(playerid,"KNIFE","KILL_Knife_Ped_Die",4.1, 0, 1, 1, 1, 1, 1); }
		case 3: { ApplyAnimation(playerid,"KNIFE","KILL_Knife_Player",4.1, 0, 1, 1, 1, 1, 1); }
		case 4: { ApplyAnimation(playerid,"KNIFE","KILL_Partial",4.1, 0, 1, 1, 1, 1, 1); }
	}
	return 1;
}

CMD:basket(playerid, params[])//87
{
	new ddr;
	if (sscanf(params, "i", ddr)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /basket [1-6]");
    if(ddr < 1 || ddr > 6) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /basket [1-6]");
    playerData[playerid][pAnimation] = 1;
	switch(ddr)
	{
		case 1: { ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop",4.1, 0, 1, 1, 1, 1, 1); }
		case 2: { ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.1, 0, 1, 1, 1, 1, 1); }
		case 3: { ApplyAnimation(playerid,"BSKTBALL","BBALL_pickup",4.1, 0, 1, 1, 1, 1, 1); }
		case 4: { ApplyAnimation(playerid,"BSKTBALL","BBALL_run",4.1, 0, 1, 1, 1, 1, 1); }
		case 5: { ApplyAnimation(playerid,"BSKTBALL","BBALL_def_loop",4.1, 1, 1, 1, 1, 1, 1); }
		case 6: { ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk",4.1, 0, 1, 1, 0, 1, 1); }
	}
   	return 1;
}

CMD:reload(playerid, params[])//88
{
	new result[128];
	if(sscanf(params, "s[24]", result)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /reload [deagle/smg/ak/m4]");
    if(strcmp(result,"deagle", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"COLT45","colt45_reload",4.1, 0, 1, 1, 1, 1, 1);
    }
    else if(strcmp(result,"smg", true) == 0)
    {
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"UZI","UZI_reload",4.1, 0, 1, 1, 1, 1, 1);
    }
	else if(strcmp(result,"ak", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"UZI","UZI_reload",4.1, 0, 1, 1, 1, 1, 1);
    }
	else if(strcmp(result,"m4", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"UZI","UZI_reload",4.1, 0, 1, 1, 1, 1, 1);
    }
   	else { SendClientMessage(playerid, COLOR_GREY, "การใช้: /reload [deagle/smg/ak/m4]"); }
   	return 1;
}

CMD:aim(playerid, params[])//90
{
	new lmb;
	if(sscanf(params, "i", lmb)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /aim [1-3]");
	playerData[playerid][pAnimation] = 1;
	if(lmb == 1) { ApplyAnimation(playerid,"PED","gang_gunstand",4.1, 0, 1, 1, 1, 1, 1); }
    if(lmb == 2) { ApplyAnimation(playerid,"PED","Driveby_L",4.1, 0, 1, 1, 1, 1, 1); }
    if(lmb == 3) { ApplyAnimation(playerid,"PED","Driveby_R",4.1, 0, 1, 1, 1, 1, 1); }
    else { SendClientMessage(playerid, COLOR_GREY, "การใช้: /aim [1-3]"); }
    return 1;
}

CMD:lean(playerid, params[])//91
{
	new mj;
	if(sscanf(params, "i", mj)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /lean [1-2]");
	if(mj < 1 || mj > 2) { SendClientMessage(playerid, COLOR_GREY, "การใช้: /lean [1-2]"); }
    playerData[playerid][pAnimation] = 1;
	if(mj == 1) { ApplyAnimation(playerid,"GANGS","leanIDLE",4.1, 0, 1, 1, 1, 1, 1); }
	if(mj == 2) { ApplyAnimation(playerid,"MISC","Plyrlean_loop",4.1, 0, 1, 1, 1, 1, 1); }
   	return 1;
}

CMD:strip(playerid, params[])//93
{
	new kj;
    if(sscanf(params, "i", kj)) return SendClientMessage(playerid, COLOR_GREY, "การใช้: /strip [1-7]");
	if(kj < 1 || kj > 7) { SendClientMessage(playerid, COLOR_GREY, "การใช้: /strip [1-7]"); }
	playerData[playerid][pAnimation] = 1;
	if(kj == 1) { ApplyAnimation(playerid,"STRIP", "strip_A", 4.1, 1, 1, 1, 1, 1, 1 ); }
	if(kj == 2) { ApplyAnimation(playerid,"STRIP", "strip_B", 4.1, 1, 1, 1, 1, 1, 1 ); }
    if(kj == 3) { ApplyAnimation(playerid,"STRIP", "strip_C", 4.1, 1, 1, 1, 1, 1, 1 ); }
    if(kj == 4) { ApplyAnimation(playerid,"STRIP", "strip_D", 4.1, 1, 1, 1, 1, 1, 1 ); }
    if(kj == 5) { ApplyAnimation(playerid,"STRIP", "strip_E", 4.1, 1, 1, 1, 1, 1, 1 ); }
    if(kj == 6) { ApplyAnimation(playerid,"STRIP", "strip_F", 4.1, 1, 1, 1, 1, 1, 1 ); }
    if(kj == 7) { ApplyAnimation(playerid,"STRIP", "strip_G", 4.1, 1, 1, 1, 1, 1, 1 ); }
 	return 1;
}

CMD:inbedright(playerid, params[])//94
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"INT_HOUSE","BED_Loop_R",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:inbedleft(playerid, params[])//95
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"INT_HOUSE","BED_Loop_L",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:wank(playerid, params[])
{
	new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendClientMessage(playerid, COLOR_GREY, "การใช้: /wank [1-2]");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"PAULNMAC","wank_in",4.1, 0, 1, 1, 1, 1, 1);
	}
	if(strcmp(choice, "2", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"PAULNMAC","wank_loop",4.1, 1, 1, 1, 1, 1, 1);
	}
	return 1;
}

CMD:bj(playerid, params[])
{
	new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendClientMessage(playerid, COLOR_GREY, "การใช้: /bj [1-18]");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Car_End_P",4.1, 0, 1, 1, 1, 1, 1);
	}
	if(strcmp(choice, "2", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Car_End_W",4.1, 0, 1, 1, 1, 1, 1);
	}
	if(strcmp(choice, "3", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Car_Loop_P",4.1, 0, 1, 1, 1, 1, 1);
	}
	if(strcmp(choice, "4", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Car_Loop_W",4.1, 1, 0, 0, 1, 1, 1);

	}
	if(strcmp(choice, "5", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Car_Start_P",4.1, 1, 0, 0, 1, 1, 1);

	}
	if(strcmp(choice, "6", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Car_Start_W",4.1, 1, 0, 0, 1, 1, 1);

	}
	if(strcmp(choice, "7", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Couch_End_P",4.1, 1, 0, 0, 1, 1, 1);

	}
	if(strcmp(choice, "8", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Couch_End_P",4.1, 1, 0, 0, 1, 1, 1);

	}
	if(strcmp(choice, "9", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Couch_Loop_P",4.1, 1, 0, 0, 1, 1, 1);

	}
	if(strcmp(choice, "10", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Couch_Loop_W",4.1, 1, 0, 0, 1, 1, 1);

	}
	if(strcmp(choice, "11", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Couch_Start_P",4.1, 1, 0, 0, 1, 1, 1);

	}
	if(strcmp(choice, "12", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Couch_Start_W",4.1, 1, 0, 0, 1, 1, 1);

	}
	if(strcmp(choice, "13", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Stand_End_P",4.1, 1, 0, 0, 1, 1, 1);

	}
	if(strcmp(choice, "14", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Stand_End_W",4.1, 1, 0, 0, 1, 1, 1);

	}
	if(strcmp(choice, "15", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Stand_Loop_P",4.1, 1, 0, 0, 1, 1, 1);

	}
	if(strcmp(choice, "16", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Stand_Loop_W",4.1, 1, 0, 0, 1, 1, 1);

	}
	if(strcmp(choice, "17", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Stand_Start_P",4.1, 1, 0, 0, 1, 1, 1);

	}
	if(strcmp(choice, "18", true) == 0)
	{
		playerData[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_Stand_Start_W",4.1, 1, 0, 0, 1, 1, 1);

	}
	return 1;
}

CMD:stand(playerid, params[])
{
	playerData[playerid][pAnimation] = 1;
	ApplyAnimation(playerid,"WUZI","Wuzi_stand_loop", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:follow(playerid, params[])
{
	ApplyAnimation(playerid,"WUZI","Wuzi_follow",4.1, 0, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
    return 1;
}

CMD:getup(playerid, params[])
{
	ApplyAnimation(playerid,"PED","getup",4.1, 0, 1, 1, 0, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}
CMD:slapped(playerid, params[])
{
	ApplyAnimation(playerid,"SWEET","ho_ass_slapped",4.1, 0, 1, 1, 0, 0, 1);
	playerData[playerid][pAnimation] = 1;
    return 1;
}

CMD:win(playerid, params[])
{
	new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendClientMessage(playerid, COLOR_GREY, "การใช้: /win [1-2]");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		ApplyAnimation(playerid,"CASINO","cards_win", 4.1, 0, 1, 1, 1, 1, 1);
		playerData[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "2", true) == 0)
	{
		ApplyAnimation(playerid,"CASINO","Roulette_win", 4.1, 0, 1, 1, 1, 1, 1);
		playerData[playerid][pAnimation] = 1;
	}
	return 1;
}

CMD:celebrate(playerid, params[])
{
	new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendClientMessage(playerid, COLOR_GREY, "การใช้: /celebrate [1-2]");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		ApplyAnimation(playerid,"benchpress","gym_bp_celebrate", 4.1, 0, 1, 1, 1, 1, 1);
		playerData[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "2", true) == 0)
	{
		ApplyAnimation(playerid,"GYMNASIUM","gym_tread_celebrate", 4.1, 0, 1, 1, 1, 1, 1);
		playerData[playerid][pAnimation] = 1;
	}
	return 1;
}

CMD:yes(playerid, params[])
{
	ApplyAnimation(playerid,"CLOTHES","CLO_Buy", 4.1, 0, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}

CMD:deal(playerid, params[])
{
	new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendClientMessage(playerid, COLOR_GREY, "การใช้: /deal [1-2]");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.1, 0, 1, 1, 1, 1, 1);
		playerData[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "2", true) == 0)
	{
		ApplyAnimation(playerid,"DEALER","DRUGS_BUY", 4.1, 0, 1, 1, 1, 1, 1);
		playerData[playerid][pAnimation] = 1;
	}
	return 1;
}

CMD:thankyou(playerid, params[])
{
	ApplyAnimation(playerid,"FOOD","SHP_Thank", 4.1, 0, 1, 1, 0, 0, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}

CMD:invite1(playerid, params[])
{
	new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendClientMessage(playerid, COLOR_GREY, "การใช้: /invite1 [1-2]");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		ApplyAnimation(playerid,"GANGS","Invite_Yes",4.1, 0, 1, 1, 0, 0, 1);
		playerData[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "2", true) == 0)
	{
		ApplyAnimation(playerid,"GANGS","Invite_No",4.1, 0, 1, 1, 0, 0, 1);
		playerData[playerid][pAnimation] = 1;
	}
	return 1;
}

CMD:scratch(playerid, params[])
{
	ApplyAnimation(playerid,"MISC","Scratchballs_01", 4.1, 0, 1, 1, 0, 0, 1);
	playerData[playerid][pAnimation] = 1;
    return 1;
}
CMD:checkout(playerid, params[])
{
	ApplyAnimation(playerid, "GRAFFITI", "graffiti_Chkout", 4.1, 0, 1, 1, 0, 0, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}
CMD:nod(playerid, params[])
{
	ApplyAnimation(playerid,"COP_AMBIENT","Coplook_nod",4.1, 0, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}
CMD:think(playerid, params[])
{
	ApplyAnimation(playerid,"COP_AMBIENT","Coplook_think",4.1, 0, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}
CMD:cry(playerid, params[])
{
	new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendClientMessage(playerid, COLOR_GREY, "การใช้: /cry [1-2]");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		ApplyAnimation(playerid,"GRAVEYARD","mrnF_loop", 4.1, 0, 1, 1, 1, 1, 1);
		playerData[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "2", true) == 0)
	{
		ApplyAnimation(playerid,"GRAVEYARD","mrnM_loop", 4.1, 0, 1, 1, 1, 1, 1);
		playerData[playerid][pAnimation] = 1;
	}
	return 1;
}
CMD:bed(playerid, params[])
{
	new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendClientMessage(playerid, COLOR_GREY, "การใช้: /bed [1-2]");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		ApplyAnimation(playerid,"INT_HOUSE","BED_In_L",4.1, 0, 1, 1, 1, 1, 1);
		playerData[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "2", true) == 0)
	{
		ApplyAnimation(playerid,"INT_HOUSE","BED_In_R",4.1, 0, 1, 1, 1, 1, 1);
		playerData[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "3", true) == 0)
	{
		ApplyAnimation(playerid,"INT_HOUSE","BED_Loop_L", 4.1, 0, 1, 1, 1, 1, 1);
		playerData[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "4", true) == 0)
	{
		ApplyAnimation(playerid,"INT_HOUSE","BED_Loop_R", 4.1, 0, 1, 1, 1, 1, 1);
		playerData[playerid][pAnimation] = 1;
	}
	return 1;
}
CMD:carsmoke(playerid, params[])
{
	ApplyAnimation(playerid,"PED","Smoke_in_car", 4.1, 0, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}

CMD:angry(playerid, params[])
{
	ApplyAnimation(playerid,"RIOT","RIOT_ANGRY",4.1, 0, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}
CMD:benddown(playerid, params[])
{
	ApplyAnimation(playerid, "BAR", "Barserve_bottle", 4.1, 0, 1, 1, 0, 0, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}
CMD:facepalm(playerid, params[])
{
	ApplyAnimation(playerid, "MISC", "plyr_shkhead", 4.1, 0, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}
CMD:cockgun(playerid, params[])
{
	ApplyAnimation(playerid, "SILENCED", "Silence_reload", 4.1, 0, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}
CMD:bar(playerid, params[])
{
	new choice;
	if(sscanf(params, "d", choice))
	{
		SendClientMessage(playerid, COLOR_GREY, "การใช้: /bar [1-12]");
		return 1;
	}
	playerData[playerid][pAnimation] = 1;
	switch(choice) {
		case 1: ApplyAnimation(playerid, "BAR", "Barcustom_get", 4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid, "BAR","Barcustom_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid, "BAR","Barcustom_order", 4.1, 0, 1, 1, 0, 0, 1);
		case 4: ApplyAnimation(playerid, "BAR","BARman_idle", 4.1, 0, 1, 1, 1, 1, 1);
		case 5: ApplyAnimation(playerid, "BAR","Barserve_bottle", 4.1, 0, 1, 1, 0, 0, 1);
		case 6: ApplyAnimation(playerid, "BAR","Barserve_give", 4.1, 0, 1, 1, 0, 0, 1);
		case 7: ApplyAnimation(playerid, "BAR","Barserve_glass", 4.1, 0, 1, 1, 0, 0, 1);
		case 8: ApplyAnimation(playerid, "BAR","Barserve_in", 4.1, 0, 1, 1, 1, 1, 1);
		case 9: ApplyAnimation(playerid, "BAR","Barserve_loop", 4.1, 1, 1, 1, 1, 1, 1);
		case 10: ApplyAnimation(playerid, "BAR","Barserve_order", 4.1, 0, 1, 1, 0, 0, 1);
		case 11: ApplyAnimation(playerid, "BAR","dnk_stndF_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 12: ApplyAnimation(playerid, "BAR","dnk_stndM_loop", 4.1, 0, 1, 1, 1, 1, 1);
	}
	return 1;
}
CMD:camera(playerid, params[])
{
	new choice;
	if(sscanf(params, "d", choice))
	{
		SendClientMessage(playerid, COLOR_GREY, "การใช้: /camera [1-10]");
		return 1;
	}
	playerData[playerid][pAnimation] = 1;
	switch(choice) {
		case 1: ApplyAnimation(playerid,  "CAMERA","camcrch_cmon", 4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,  "CAMERA","camcrch_to_camstnd", 4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid,  "CAMERA","camstnd_cmon", 4.1, 0, 1, 1, 1, 1, 1);
		case 4: ApplyAnimation(playerid,  "CAMERA","camstnd_idleloop", 4.1, 1, 0, 0, 1, 1, 1);
		case 5: ApplyAnimation(playerid,  "CAMERA","camstnd_lkabt", 4.1, 0, 1, 1, 1, 1, 1);
		case 6: ApplyAnimation(playerid,  "CAMERA","piccrch_in", 4.1, 0, 1, 1, 1, 1, 1);
		case 7: ApplyAnimation(playerid,  "CAMERA","piccrch_take", 4.1, 0, 1, 1, 1, 1, 1);
		case 8: ApplyAnimation(playerid,  "CAMERA","picstnd_in", 4.1, 0, 1, 1, 1, 1, 1);
		case 9: ApplyAnimation(playerid, "CAMERA","picstnd_out", 4.1, 0, 1, 1, 1, 1, 1);
		case 10: ApplyAnimation(playerid, "CAMERA","picstnd_take", 4.1, 0, 1, 1, 1, 1, 1);
	}
	return 1;
}

CMD:panic(playerid, params[])
{
	new choice;
	if(sscanf(params, "d", choice))
	{
		SendClientMessage(playerid, COLOR_GREY, "การใช้: /panic [1-4]");
		return 1;
	}
	playerData[playerid][pAnimation] = 1;
	switch(choice) {
		case 1: ApplyAnimation(playerid,"ON_LOOKERS","panic_cower", 4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"ON_LOOKERS","panic_hide", 4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid,"ON_LOOKERS","panic_in", 4.1, 0, 1, 1, 1, 1, 1);
		case 4: ApplyAnimation(playerid,"ON_LOOKERS","panic_loop", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}
CMD:sex(playerid, params[])
{
	new choice;
	if(sscanf(params, "d", choice))
	{
		SendClientMessage(playerid, COLOR_GREY, "การใช้: /sex [1-22]");
		return 1;
	}
	playerData[playerid][pAnimation] = 1;
	switch(choice) 
	{
		case 1: ApplyAnimation(playerid,"SEX","SEX_1to2_P", 4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"SEX","SEX_1to2_W", 4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid,"SEX","SEX_1_Cum_P", 4.1, 0, 1, 1, 1, 1, 1);
		case 4: ApplyAnimation(playerid,"SEX","SEX_1_Cum_W", 4.1, 0, 1, 1, 1, 1, 1);
		case 5: ApplyAnimation(playerid,"SEX","SEX_1_Fail_P", 4.1, 0, 1, 1, 1, 1, 1);
		case 6: ApplyAnimation(playerid,"SEX","SEX_1_Fail_W", 4.1, 0, 1, 1, 1, 1, 1);
		case 7: ApplyAnimation(playerid,"SEX","SEX_1_P", 4.1, 0, 1, 1, 1, 1, 1);
		case 8: ApplyAnimation(playerid,"SEX","SEX_1_W", 4.1, 0, 1, 1, 1, 1, 1);
		case 9: ApplyAnimation(playerid,"SEX","SEX_2to3_P", 4.1, 0, 1, 1, 1, 1, 1);
		case 10: ApplyAnimation(playerid,"SEX","SEX_2to3_W", 4.1, 0, 1, 1, 1, 1, 1);
		case 11: ApplyAnimation(playerid,"SEX","SEX_2_Fail_P", 4.1, 0, 1, 1, 1, 1, 1);
		case 12: ApplyAnimation(playerid,"SEX","SEX_2_Fail_W", 4.1, 0, 1, 1, 1, 1, 1);
		case 13: ApplyAnimation(playerid,"SEX","SEX_2_P", 4.1, 0, 1, 1, 1, 1, 1);
		case 14: ApplyAnimation(playerid,"SEX","SEX_2_W", 4.1, 0, 1, 1, 1, 1, 1);
		case 15: ApplyAnimation(playerid,"SEX","SEX_3to1_P", 4.1, 0, 1, 1, 1, 1, 1);
		case 16: ApplyAnimation(playerid,"SEX","SEX_3to1_W", 4.1, 0, 1, 1, 1, 1, 1);
		case 17: ApplyAnimation(playerid,"SEX","SEX_3_Fail_P", 4.1, 0, 1, 1, 1, 1, 1);
		case 18: ApplyAnimation(playerid,"SEX","SEX_3_Fail_W", 4.1, 0, 1, 1, 1, 1, 1);
		case 19: ApplyAnimation(playerid,"SEX","SEX_3_P", 4.1, 0, 1, 1, 1, 1, 1);
		case 20: ApplyAnimation(playerid,"SEX","SEX_3_W", 4.1, 0, 1, 1, 1, 1, 1);
		case 21: ApplyAnimation(playerid,"ped","WOMAN_runsexy", 4.1, 0, 1, 1, 1, 1, 1);
		case 22: ApplyAnimation(playerid,"ped","WOMAN_walksexy", 4.1, 0, 1, 1, 1, 1, 1);
	}
	return 1;
}

CMD:liftup(playerid, params[])
{
	ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}

CMD:putdown(playerid, params[])
{
	ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}

CMD:joint(playerid, params[])
{
	ApplyAnimation(playerid,"GANGS","smkcig_prtl",4.1, 0, 1, 1, 1, 1, 1);
	playerData[playerid][pAnimation] = 1;
	return 1;
}
CMD:die(playerid, params[])
{
	new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendClientMessage(playerid, COLOR_GREY, "การใช้: /die [1-2]");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		ApplyAnimation(playerid,"KNIFE","KILL_Knife_Ped_Die",4.1, 0, 1, 1, 1, 1, 1);
		playerData[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "2", true) == 0)
	{
		ApplyAnimation(playerid, "PARACHUTE", "FALL_skyDive_DIE", 4.1, 0, 1, 1, 1, 1, 1);
		playerData[playerid][pAnimation] = 1;
	}
	return 1;
}

CMD:Lowrider(playerid, params[])
{
	if(IsInLowRider(playerid))
	{
		new choice;
		if(sscanf(params, "i", choice))
		{
			SendClientMessage(playerid, COLOR_GREY, "การใช้: /lranim");
			SendClientMessage(playerid, COLOR_GREY, "ตัวเลือกที่มี: 0-36");
			return 1;
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
		    SendClientMessage(playerid, COLOR_GREY, "  คุณต้องไม่ใช่คนขับรถ!");
		    return 1;
		}
		playerData[playerid][pAnimation] = 1;
		switch(choice)
		{
		    case 0:
		    {
				ApplyAnimation(playerid, "LOWRIDER", "F_smklean_loop", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 1:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_bdbnce", 4.0, 0, 0, 0, 1, 0, 1);
		    }
		    case 2:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_hair", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 3:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_hurry", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 4:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_idleloop", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 5:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_idle_to_l0", 4.0, 0, 0, 0, 1, 0, 1);
		    }
		    case 6:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l0_bnce", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 7:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l0_loop", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 8:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l0_to_l1", 4.0, 0, 0, 0, 1, 0, 1);
		    }
		    case 9:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l12_to_l0", 4.0, 0, 0, 0, 1, 0, 1);
		    }
		    case 10:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l1_bnce", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 11:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l1_loop", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 12:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l1_to_l2", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 13:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l2_bnce", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 14:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l2_loop", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 15:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l2_to_l3", 4.0, 0, 0, 0, 1, 0, 1);
		    }
		    case 16:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l345_to_l1", 4.0, 0, 0, 0, 1, 0, 1);
		    }
		    case 17:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l3_bnce", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 18:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l3_loop", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 19:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l3_to_l4", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 20:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l4_bnce", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 21:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l4_loop", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 22:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l4_to_l5", 4.0, 0, 0, 0, 1, 0, 1);
		    }
		    case 23:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l5_bnce", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 24:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "lrgirl_l5_loop", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 25:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 26:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "prtial_gngtlkB", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 27:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "prtial_gngtlkC", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 28:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "prtial_gngtlkD", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 29:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "prtial_gngtlkF", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 30:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "prtial_gngtlkG", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 31:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "prtial_gngtlkH", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 32:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "RAP_A_Loop", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 33:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "RAP_B_Loop", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 34:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "RAP_C_Loop", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 35:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "Sit_relaxed", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		    case 36:
		    {
		        ApplyAnimation(playerid, "LOWRIDER", "Tap_hand", 4.0, 1, 0, 0, 0, 0, 1);
		    }
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, " คุณต้องอยู่ในรถยนต์ประเภท Lowrider เพื่อใช้คำสั่งนี้!");
	}
	return 1;
}

IsInLowRider(playerid) {
	new pveh = GetPlayerVehicleID(playerid);
	switch(GetVehicleModel(pveh)) {
		case 536, 575, 567: return 1;
	}
	return 0;
}


// --> ระบบ Animation ส่วนตัว
Dialog:D_Animlist(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem)
		{
			case 0: //
			{
				ClearAnimations(playerid);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
				TogglePlayerControllable(playerid, true);
			}
			case 1: //
			{
				ApplyAnimation(playerid, "ROB_BANK","SHP_HandsUp_Scr",4.1, 0, 1, 1, 1, 1, 1);
			}
			case 2: //
			{
				ApplyAnimation(playerid, "ped", "cower",4.1, 0, 1, 1, 1, 1, 1);
			}
			case 3: //
			{
				ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.1, 0, 1, 1, 1, 1, 1);
			}
			case 4: //
			{
				SetPlayerSpecialAction(playerid, 68);
			}
			case 5: //
			{
				ApplyAnimation(playerid,"PED","KO_skid_front",4.1, 0, 1, 1, 1, 1, 1);
			}
			case 6: //
			{
				ApplyAnimation(playerid, "PED","FLOOR_hit_f", 4.1, 0, 1, 1, 1, 1, 1);
			}
			case 7: //
			{
				ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 0, 1, 1, 1, 1, 1); // Arms crossed
			}
			case 8:
			{
				ApplyAnimation(playerid,"SWEET","sweet_ass_slap",4.1, 0, 1, 1, 0, 0, 1);
			}
			case 9: //seat 7
			{
				ApplyAnimation(playerid,"ped","SEAT_down",4.1, 0, 0, 0, 1, 0, 0);
			}
			case 10: //taxiL
			{
				ApplyAnimation(playerid,"MISC","Hiker_Pose_L",4.1, 0, 1, 1, 1, 1, 1);
			}
			case 11: //taxiR
			{
				ApplyAnimation(playerid,"MISC","Hiker_Pose",4.1, 0, 1, 1, 1, 1, 1);
			}
			case 12: //smoke 1
			{
				ApplyAnimation(playerid,"SMOKING","M_smk_in",4.1, 0, 1, 1, 1, 1, 1);
			}
			case 13: //smoke 2
			{
				ApplyAnimation(playerid,"SMOKING","M_smklean_loop",4.1, 0, 1, 1, 1, 1, 1);
			}
			case 14: //angry
			{
				ApplyAnimation(playerid,"RIOT","RIOT_ANGRY",4.1, 0, 1, 1, 1, 1, 1);
			}
			case 15: //เพิ่มเติม
			{
				callcmd::anims(playerid, "\1");
			}
		}
	}
	return 1;
}