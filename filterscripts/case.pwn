// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>
#include <streamer>
#include <zcmd>
#include <sscanf2>
#include <foreach>

#define highpos 700
#define BULLET %
#define INFERNUS %
#define LEVELUP2 a
#define LEVELUP1 a
#define RM800 e
#define RM500 e
#define Point20 ่
#define Point10 ่
#define CASH650 &
#define CASH320 &


new ReceivedItem[MAX_PLAYERS],SpinInterval[MAX_PLAYERS],
PlayerCaseOBJ[210][MAX_PLAYERS],Float:PlayerCaseX[MAX_PLAYERS],
PlayerProb[MAX_PLAYERS],CaseDrop[][]=
{
 	" ",
	"กล่องลึกลับ",
	"กล่องลึกลับ",
	"เลเวล +2",
	"เลเวล +1",
	"เงินแดง $800",
	"เงินแดง $500",
	"20 Point",
	"10 Point",
	"เงินเขียว $800",
	"เงินเขียว $500"
};


public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Case Opening CS:GO");
	print("--------------------------------------\n");
 	return 1;
}


public OnPlayerSpawn(playerid)
{
    SpinInterval[playerid] = 0;
	PlayerCaseX[playerid] = 0;
	return 1;
}

CMD:opencase(playerid,params[])
{
	if(IsValidObject(PlayerCaseOBJ[209][playerid])&&PlayerCaseX[playerid] != 0) return SendClientMessage(playerid,-1,"You already do this!");
	TogglePlayerControllable(playerid,0);
	OpenCrate(playerid);
	return 1;
}

forward ExitCase(playerid);
public ExitCase(playerid)
{
	for(new i=0;i<210;i++)	if(IsValidObject(PlayerCaseOBJ[i][playerid])) DestroyObject(PlayerCaseOBJ[i][playerid]);
    SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid,1);
	SetPlayerVirtualWorld(playerid,0);
	PlayerCaseX[playerid] = 0;
	return 1;
}

public OnObjectMoved(objectid)
{
	for(new playerid=0;playerid<MAX_PLAYERS;playerid++)
	{
		if(IsValidObject(PlayerCaseOBJ[209][playerid]) && objectid==PlayerCaseOBJ[209][playerid])
  		{
			new Float:X,Float:Y,Float:Z,strings[100],colortext[40],raretext[40],reward=ReceivedItem[playerid];
			GetObjectPos(PlayerCaseOBJ[209][playerid],X,Y,Z);
			if(X==(PlayerCaseX[playerid]+1.1192+5*playerid))
   			{
				if(SpinInterval[playerid]==5)
				{
				    switch(reward)
				    {
				        case 1,2: colortext="{FFFF00}",raretext=" Legendary";
				        case 3,4: colortext="{FF0000}",raretext=" Ultra Rare";
				        case 5,6: colortext="{FF00FF}",raretext=" Rare";
				        case 7,8: colortext="{0080FF}",raretext=" UnCommon";
				        case 9,10: colortext="{C0C0C0}",raretext=" Common";
				    }
				    SetTimerEx("ExitCase",2500,false,"u",playerid);//. (Probability Fair: %d) ,PlayerProb[playerid]
				    format(strings,sizeof strings,"*%s คุณได้รับไอเท็มระดับ %s",colortext,raretext);SendClientMessage(playerid,-1,strings);
				    format(strings,sizeof strings,"* คุณได้รับ %s",CaseDrop[reward]);
					SendClientMessage(playerid,-1,strings);
				    if(reward==1||reward==2)			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 1.0);
				    else if(reward==3||reward==4)		PlayerPlaySound(playerid, 1137, 0.0, 0.0, 1.0);
				    else if(reward==5||reward==6)		PlayerPlaySound(playerid, 1138, 0.0, 0.0, 1.0);
				    else 			 					PlayerPlaySound(playerid, 1139, 0.0, 0.0, 1.0);
					switch(reward)
					{
						case 1: //Infernus
						{
							//give vehicle 411
						}
						case 2: //Bullet
						{
							//give vehicle 541
						}
						case 3: //2x Level UP
						{
							//PlayerInfo[playerid][pLevel] +=2, Update(playerid,pLevelx);
						}
						case 4: //1x Level UP
						{
							//PlayerInfo[playerid][pLevel] ++, Update(playerid,pLevelx);
						}
						case 5: //10RP Points
						{
							//PlayerInfo[playerid][pRP] +=10, Update(playerid,pRPx);
						}
						case 6: //40RP Points
						{
							//PlayerInfo[playerid][pRP] +=40, Update(playerid,pRPx);
						}
						case 7: //Hidden Colors
						{
							//PlayerInfo[playerid][pHidden] +=2, Update(playerid,pHiddenx);
						}
						case 8: //10 PP
						{
							//PlayerInfo[playerid][pPremiumPoints] +=10, Update(playerid,pPremiumPointsx);
						}
						case 9: //$650.000
						{
							//GiveMoney(playerid, 800, "Get Case");
						}
						case 10://$320.000
						{
							//GiveMoney(playerid, 500, "Get Case");
						}
					}
			       	return 1;
				}
			    else if(SpinInterval[playerid]<6)	MoveObject(PlayerCaseOBJ[209][playerid],X, Y+1.51200,	Z,0.6);
			    else if(SpinInterval[playerid]<8)	MoveObject(PlayerCaseOBJ[209][playerid],X, Y+1.51200,	Z,1);
			    else if(SpinInterval[playerid]<13)	MoveObject(PlayerCaseOBJ[209][playerid],X, Y+1.51200,	Z,2);
			    else if(SpinInterval[playerid]<24)	MoveObject(PlayerCaseOBJ[209][playerid],X, Y+1.51200,	Z,4);
				else if(SpinInterval[playerid]<60)	MoveObject(PlayerCaseOBJ[209][playerid],X, Y+1.51200, 	Z,9);
				else								MoveObject(PlayerCaseOBJ[209][playerid],X, Y+1.51200, 	Z,12);
				SpinInterval[playerid]--;
		 		PlayerPlaySound(playerid, 1135, 0.0, 0.0, 0.0);
	 		}
		}
	}
	return 1;
}

forward OpenCrate(playerid);
public OpenCrate(playerid)
{
	new Float:X,Float:Y,Float:Z,Float:begin=51*1.51200;
	GetPlayerPos(playerid,X,Y,Z);
	PlayerCaseX[playerid] = X;
	PlayerCaseOBJ[200][playerid] = CreateObject(19448, X+1.16767+5*playerid, Y+-0.08158, Z+highpos-8.56462,   0.00000, 0.00000, 0.00000); 	SetObjectMaterial(PlayerCaseOBJ[200][playerid], 0, 1676, "wshxrefpump", "black64", 0xFFFFFFFF);
	PlayerCaseOBJ[201][playerid] = CreateObject(19447, X+0.00000+5*playerid, Y+0.00000, Z+highpos-5.43388,   0.00000, 0.00000, 0.00000); 	SetObjectMaterial(PlayerCaseOBJ[201][playerid], 0, 1675, "wshxrefhse", "duskyblue_128", 0xFFFFFFFF);
	PlayerCaseOBJ[202][playerid] = CreateObject(19447, X+0.00000+5*playerid, Y+0.00000, Z+highpos-10.19381,   0.00000, 0.00000, 0.00000);	SetObjectMaterial(PlayerCaseOBJ[202][playerid], 0, 1675, "wshxrefhse", "duskyblue_128", 0xFFFFFFFF);
	PlayerCaseOBJ[203][playerid] = CreateObject(19447, X+0.00090+5*playerid, Y+7.15430, Z+highpos-8.41380,   0.00000, 0.00000, 0.00000);	SetObjectMaterial(PlayerCaseOBJ[203][playerid], 0, 1675, "wshxrefhse", "duskyblue_128", 0xFFFFFFFF);
	PlayerCaseOBJ[204][playerid] = CreateObject(19447, X+0.00350+5*playerid, Y+-7.12040, Z+highpos-8.41380,   0.00000, 0.00000, 0.00000);	SetObjectMaterial(PlayerCaseOBJ[204][playerid], 0, 1675, "wshxrefhse", "duskyblue_128", 0xFFFFFFFF);
	PlayerCaseOBJ[205][playerid] = CreateObject(19087, X+0.6140+5*playerid, Y+0.00000, Z+highpos-7.13523,   0.00000, 0.00000, 0.00000);		SetObjectMaterial(PlayerCaseOBJ[205][playerid], 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	PlayerCaseOBJ[206][playerid] = CreateObject(19131, X+-0.11290+5*playerid, Y+2.01870, Z+highpos-9.22520,   0.00000, 10.00000, 0.00000);	SetObjectMaterialText(PlayerCaseOBJ[206][playerid],"i", 0, OBJECT_MATERIAL_SIZE_128x128,"Comic", 100, 1, 0xFF000000, 0xC0C0C0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
    PlayerCaseOBJ[207][playerid] = CreateObject(19353, X+-0.0730+5*playerid, Y+0.5698, Z+highpos-9.2395,  0.00000,  10.00000, 0.00000);		SetObjectMaterialText(PlayerCaseOBJ[207][playerid],"{000000}กำลังเปิดกล่อง...", 0,OBJECT_MATERIAL_SIZE_512x512,"Arial",31,1,0x00000000,0x000000,OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	PlayerCaseOBJ[208][playerid] = CreateObject(18762, X+ 0.36960+5*playerid, Y+0.00000, Z+highpos-9.15070,   10.00000, 90.00000, 90.00000);SetObjectMaterial(PlayerCaseOBJ[208][playerid] ,0, 8839, "vgsecarshow", "lightblue2_32", 0xFFFFFFFF);
	PlayerCaseOBJ[209][playerid] = CreateObject(19304, X+1.1192+5*playerid, Y+-71.026, Z+highpos-7.81800,   0.00000, 0.00000, 90.00000);
	SetPlayerCameraPos(playerid,X+-5.9000+5*playerid, Y+0.0000, Z+highpos-7.9852);
	SetPlayerCameraLookAt(playerid, X+0.6000+5*playerid, Y+0.0000, Z+highpos-7.9852);

	for(new i=0;i<100;i++)
	{
  		PlayerCaseOBJ[i][playerid]=CreateObject(2258, 0,0,0,0,0,0);
  		PlayerCaseOBJ[i+100][playerid]=CreateObject(2258, 0,0,0,0,0,0);
    	AttachObjectToObject(PlayerCaseOBJ[i][playerid],PlayerCaseOBJ[209][playerid],(0.00000-begin)+(i*1.51200),0.50400, 0,   0.00000, 0.00000, 180.00000, 1);
    	AttachObjectToObject(PlayerCaseOBJ[i+100][playerid],PlayerCaseOBJ[209][playerid],(0.00000-begin)+(i*1.51200),0.51400, -0.3,   0.00000, 0.00000, 180.00000, 1);
	}
	SpinInterval[playerid]=100;
	MoveObject(PlayerCaseOBJ[209][playerid],X+1.1192+5*playerid, Y+-71.026+1.51200, Z+highpos-7.81800,21);
	for(new i=0;i<100;i++)
	{
 	    new classitem = random(100);
 	    PlayerProb[playerid] = classitem;
	    switch (classitem)
		{
			case  0..1:
			{
			    switch(random(2))
			    {
			        case 0:
					{
               			if(i==2)
						ReceivedItem[playerid]=1;
						SetObjectMaterialText(PlayerCaseOBJ[i][playerid] , #INFERNUS ,0,  OBJECT_MATERIAL_SIZE_128x128,"Webdings", 58, 0, 0xFF000000, 0xFFFF00, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
						SetObjectMaterialText(PlayerCaseOBJ[i+100][playerid],"กล่องลึกลับ"  ,0 ,  OBJECT_MATERIAL_SIZE_128x128,"Arial", 20, 1, 0xFF000000, 0x00000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			        }
					default:
					{
               			if(i==2)
					    ReceivedItem[playerid]=2;
						SetObjectMaterialText(PlayerCaseOBJ[i][playerid] , #BULLET  ,0,  OBJECT_MATERIAL_SIZE_128x128,"Webdings", 58, 0, 0xFF000000, 0xFFFF00, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
						SetObjectMaterialText(PlayerCaseOBJ[i+100][playerid],"กล่องลึกลับ"  ,0 ,  OBJECT_MATERIAL_SIZE_128x128,"Arial", 20, 1, 0xFF000000, 0x00000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
					}
   				} 
     		}
    		case 2..13:
			{
				switch(random(2))
			    {
			        case 0:
					{
               			if(i==2)ReceivedItem[playerid]=3;
						SetObjectMaterialText(PlayerCaseOBJ[i][playerid] , #LEVELUP2  ,0,   OBJECT_MATERIAL_SIZE_128x128,"Webdings", 58, 0, 0xFF000000,0xFF0000 , OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
						SetObjectMaterialText(PlayerCaseOBJ[i+100][playerid],CaseDrop[3] ,0 ,   OBJECT_MATERIAL_SIZE_128x128,"Arial", 20, 1, 0xFF000000, 0x00000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			        }
					default:
					{
               			if(i==2)ReceivedItem[playerid]=4;
						SetObjectMaterialText(PlayerCaseOBJ[i][playerid] , #LEVELUP1  ,0,   OBJECT_MATERIAL_SIZE_128x128,"Webdings", 58, 0, 0xFF000000, 0xFF0000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
						SetObjectMaterialText(PlayerCaseOBJ[i+100][playerid],CaseDrop[4] ,0 ,   OBJECT_MATERIAL_SIZE_128x128,"Arial", 20, 1, 0xFF000000, 0x00000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
					}
   				}
      		}
			case 14..30:
			{
				switch(random(2))
			    {
			        case 0:
					{
               			if(i==2)ReceivedItem[playerid]=5;
					 	SetObjectMaterialText(PlayerCaseOBJ[i][playerid], #RM800 ,0,   OBJECT_MATERIAL_SIZE_128x128,"Webdings", 58, 0, 0xFF000000, 0xFF00FF, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
					 	SetObjectMaterialText(PlayerCaseOBJ[i+100][playerid],CaseDrop[5]  ,0,   OBJECT_MATERIAL_SIZE_128x128,"Arial", 20, 1, 0xFF000000, 0x00000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			        }
					default:
					{
               			if(i==2)ReceivedItem[playerid]=6;
					 	SetObjectMaterialText(PlayerCaseOBJ[i][playerid] ,#RM500 ,0,   OBJECT_MATERIAL_SIZE_128x128,"Webdings", 58, 0, 0xFF000000, 0xFF00FF, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
					 	SetObjectMaterialText(PlayerCaseOBJ[i+100][playerid],CaseDrop[6]  ,0,   OBJECT_MATERIAL_SIZE_128x128,"Arial", 20, 1, 0xFF000000, 0x00000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
					}
   				}
   			}
			case 31..50:
			{
				switch(random(2))
			    {
			        case 0:
					{
               			if(i==2)ReceivedItem[playerid]=7;
						SetObjectMaterialText(PlayerCaseOBJ[i][playerid], #Point20 ,0, OBJECT_MATERIAL_SIZE_128x128,"Webdings", 58, 0, 0xFF000000,0x1580EA , OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
						SetObjectMaterialText(PlayerCaseOBJ[i+100][playerid],CaseDrop[7] ,0, OBJECT_MATERIAL_SIZE_128x128,"Arial", 20, 1, 0xFF000000,0x00000000 , OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
					}
					default:
					{
               			if(i==2)ReceivedItem[playerid]=8;
						SetObjectMaterialText(PlayerCaseOBJ[i][playerid], #Point10 ,0, OBJECT_MATERIAL_SIZE_128x128,"Webdings", 58, 0, 0xFF000000,0x1580EA , OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
						SetObjectMaterialText(PlayerCaseOBJ[i+100][playerid],CaseDrop[8]  ,0, OBJECT_MATERIAL_SIZE_128x128,"Arial", 20, 1, 0xFF000000,0x00000000 , OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
					}
   				}
   			}
			case 51..99:
			{
				switch(random(2))
			    {
			        case 0:
					{
               			if(i==2)ReceivedItem[playerid]=9;
						SetObjectMaterialText(PlayerCaseOBJ[i][playerid],#CASH650,0 ,  OBJECT_MATERIAL_SIZE_128x128,"Webdings", 58, 0, 0xFF000000, 0x808080, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
						SetObjectMaterialText(PlayerCaseOBJ[i+100][playerid], CaseDrop[9] ,0,  OBJECT_MATERIAL_SIZE_128x128,"Arial", 20, 1, 0xFF000000, 0x00000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
					}
					default:
					{
               			if(i==2)ReceivedItem[playerid]=10;
						SetObjectMaterialText(PlayerCaseOBJ[i][playerid],#CASH320 ,0 ,  OBJECT_MATERIAL_SIZE_128x128,"Webdings", 58, 0, 0xFF000000, 0x808080, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
						SetObjectMaterialText(PlayerCaseOBJ[i+100][playerid], CaseDrop[10] ,0,  OBJECT_MATERIAL_SIZE_128x128,"Arial", 20, 1, 0xFF000000, 0x00000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
					}
   				}
   			}
		}
  	}
	return 1;
}

