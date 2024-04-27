/*

	ระบบ 'Container' เปิดกล่องสุ่ม Gachapong
	Create : Richard

*/

#include 	<YSI_Coding\y_hooks>

new GachaActor;

#define AIR_DISTANCE 100.0
enum Air
{
    timer,
    Float:posGacha[4],
    container[4],
    bool:active,
    ttimer
};
new AirFreight[MAX_PLAYERS][Air];

new AirOn;
new Text3D:AirText;
new AirTime;
new AirType;
new AirOwner;
//new Air_Stats;

new isAirOpen[MAX_PLAYERS];
new Float:AirX, Float:AirY, Float:AirZ;

new carRandom_Gacha[96][1] = {
	{ 400 },
	{ 401 },
	{ 402 },
	{ 404 },
	{ 405 },
	{ 409 },
	{ 410 },
	{ 411 },
	{ 412 },
	{ 413 },
	{ 415 },
	{ 418 },
	{ 419 },
	{ 421 },
	{ 422 },
	{ 424 },
	{ 426 },
	{ 429 },
	{ 434 },
	{ 436 },
	{ 439 },
	{ 440 },
	{ 442 },
	{ 445 },
	{ 451 },
	{ 458 },
	{ 459 },
	{ 461 },
	{ 463 },
	{ 466 },
	{ 467 },
	{ 468 },
	{ 471 },
	{ 474 },
	{ 475 },
	{ 477 },
	{ 479 },
	{ 480 },
	{ 482 },
	{ 489 },
	{ 490 },
	{ 491 },
	{ 492 },
	{ 494 },
	{ 496 },
	{ 500 },
	{ 502 },
	{ 503 },
	{ 504 },
	{ 505 },
	{ 506 },
	{ 507 },
	{ 516 },
	{ 517 },
	{ 518 },
	{ 521 },
	{ 522 },
	{ 526 },
	{ 527 },
	{ 529 },
	{ 533 },
	{ 534 },
	{ 535 },
	{ 536 },
	{ 540 },
	{ 541 },
	{ 542 },
	{ 543 },
	{ 545 },
	{ 546 },
	{ 547 },
	{ 549 },
	{ 550 },
	{ 551 },
	{ 554 },
	{ 555 },
	{ 558 },
	{ 559 },
	{ 560 },
	{ 561 },
	{ 562 },
	{ 565 },
	{ 566 },
	{ 567 },
	{ 568 },
	{ 575 },
	{ 576 },
	{ 579 },
	{ 580 },
	{ 581 },
	{ 585 },
	{ 587 },
	{ 589 },
	{ 602 },
	{ 603 },
	{ 605 }
};

stock GetElapsedTimeEventEvent(time, &hours, &minutes, &seconds)
{
	hours = 0;
	minutes = 0;
	seconds = 0;

	if (time >= 3600)
	{
		hours = (time / 3500);
		time -= (hours * 3500);
	}
	while (time >= 60)
	{
	    minutes++;
	    time -= 60;
	}
	return (seconds = time);
}

hook OnGameModeInit()
{
	// ลานจอด
    CreateObject(3934, 1728.74219, -2433.55029, 12.54046,   0.00000, 0.00000, -87.77998);


    AirOn = 0;
    AirTime = 0;
    AirType = 0;
    AirOwner = -1;
    //Air_Stats = 0;

	if(IsValidDynamic3DTextLabel(AirText))
 		DestroyDynamic3DTextLabel(AirText);

    AirX = 0.0;
    AirY = 0.0;
    AirZ = 0.0;
}

hook OnPlayerDisconnect(playerid)
{
	if (AirOn == 1)
	{
	    if (AirOwner == playerid)
	    {
	    	DeleteContainer(AirOwner);
		}
	}
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if (AirOn == 1)
	{
	    if (AirOwner == playerid)
	    {
	    	DeleteContainer(AirOwner);
		}
	}
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	// กด 'N'
	if (newkeys & KEY_NO && !IsPlayerInAnyVehicle(playerid))
	{
	    // ร้านสุ่มไอเท็ม
	    if (IsPlayerInRangeOfPoint(playerid, 2.0, 1726.6639,-2443.1282,13.5547))
	    {
	        if (AirOn == 1)
	            return SendClientMessage(playerid, COLOR_LIGHTRED, "มีคนกำลังเรียก 'Container'");

			new string100[512];
			new string2[512];

			format(string100, sizeof(string100), "{ffffff}สุ่มด้วย {02C01C}เงินเขียว\t{02C01C}${ffffff}1,000,000\n");
			strcat(string2,string100);

			format(string100, sizeof(string100), "{ffffff}สุ่มด้วย {F9EB15}Coin\t{F3F332}150 {ffffff}Coin\n");
			strcat(string2,string100);

			Dialog_Show(playerid,DIALOG_GACHA,DIALOG_STYLE_TABLIST,"{FBF009}[ ร้านสุ่มรถ ]",string2,"ตกลง","ยกเลิก");
	    }

	    // เปิดกล่อง Container
	    if (IsPlayerInRangeOfPoint(playerid, 5.0, AirX, AirY, AirZ))
	    {
	        if (AirOn == 0)
	            return SendClientMessage(playerid, COLOR_LIGHTRED, "ยังไม่มีคนเรียก 'Container' ใด ๆ");

	        if (AirOwner != playerid)
	            return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ใช่เจ้าของ 'Container'");

	        if (isAirOpen[playerid] == 1)
	            return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณอยู่ระหว่างการเปิด 'Container'");

			isAirOpen[playerid] = 1;
			StartProgress(playerid, 200, 0, INVALID_OBJECT_ID);
	    }
	}
	return 1;
}

Dialog:DIALOG_GACHA(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
  		{
			case 0:
			{
			    if (GetPlayerMoneyEx(playerid) < 100000)
			        return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณมีเงินไม่เพียงพอ ($1,000,000)");

			    StartContainer(playerid, 1);
				GivePlayerMoneyEx(playerid, -100000);
                ApplyActorAnimation(GachaActor, "PED", "PHONE_IN", 4.1, 0, 0, 0, 0, 0);
                SendClientMessage(playerid, COLOR_YELLOW, "คุณได้ทำการเรียกคอนเทนเนอร์สุ่มรถโดย 'เงินเขียว' แล้ว");
                SendClientMessage(playerid, COLOR_WHITE, "(( กรุณารอที่จุดรับคอนเทนเนอร์เพื่อรับของจากกล่อง {979795}'เงินเขียว' {ffffff}))");
			}
			case 1:
			{
			    if (playerData[playerid][pCoin] < 150)
			        return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณมี 'Coin' ไม่เพียงพอ (150 Coin)");

			    StartContainer(playerid, 2);
			    playerData[playerid][pCoin] -= 150;
                ApplyActorAnimation(GachaActor, "PED", "PHONE_IN", 4.1, 0, 0, 0, 0, 0);
                SendClientMessage(playerid, COLOR_YELLOW, "คุณได้ทำการเรียกคอนเทนเนอร์สุ่มรถโดย 'Coin' แล้ว");
                SendClientMessage(playerid, COLOR_WHITE, "(( กรุณารอที่จุดรับคอนเทนเนอร์เพื่อรับของจากกล่อง {EC4921}'Coin' {ffffff}))");
			}
		}
	}
	return 1;
}

forward DeleteContainer(playerid);
public DeleteContainer(playerid)
{
    DestroyObject(AirFreight[playerid][container][0]);
    DestroyObject(AirFreight[playerid][container][1]);
    DestroyObject(AirFreight[playerid][container][2]);
    DestroyObject(AirFreight[playerid][container][3]);

    AirFreight[playerid][posGacha][0] = 0.0;
    AirFreight[playerid][posGacha][1] = 0.0;
    AirFreight[playerid][posGacha][2] = 0.0;
    AirFreight[playerid][posGacha][3] = 0.0;

    AirFreight[playerid][active] = false;
    KillTimer(AirFreight[playerid][ttimer]);

    AirOn = 0;
    AirTime = 0;
    AirType = 0;
    AirOwner = -1;
    //Air_Stats = 0;

	if(IsValidDynamic3DTextLabel(AirText))
 		DestroyDynamic3DTextLabel(AirText);

    AirX = 0.0;
    AirY = 0.0;
    AirZ = 0.0;

    isAirOpen[playerid] = 0;
}

hook OnObjectMoved(objectid)
{
	foreach (new playerid : Player)
	{
	   	if (objectid == AirFreight[playerid][container][1])
		{
			new Float:x,Float:y,Float:z;

			x = AirFreight[playerid][posGacha][0];
			y = AirFreight[playerid][posGacha][1];
			z = AirFreight[playerid][posGacha][2];

			KillTimer(AirFreight[playerid][ttimer]);

			AirFreight[playerid][container][2] = CreateObject(playerid, 18671, x, y, z-2, 0, 0, 0);
			AirFreight[playerid][container][3] = CreateObject(playerid, 18728, x, y, z-2, 0, 0, 0);

			CreateExplosion(x, y, z, 8, AIR_DISTANCE);

			AirX = x;
			AirY = y;
			AirZ = z;

			AirTime = 300;

			new string[128];

		    new
		        hours,
		        minutes,
		        seconds;

			GetElapsedTimeEventEvent(AirTime, hours, minutes, seconds);

		    format(string, sizeof(string), "{21BBEC}[เจ้าของ]\n{F3B932}Legendary\n{ECE321}%s\n{FFFFFF}%02d:%02d\n{F85B39}(กดปุ่ม 'N' เพื่อเปิดกล่อง)", GetPlayerNameEx(playerid), minutes, seconds);
		    AirText = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, x, y, z, 30.0);
	    }
	}
    return true;
}

StartContainer(playerid, type)
{
	new Float:x, Float:y, Float:z, Float:a;

	if (!AirFreight[playerid][active])
	{
        AirFreight[playerid][posGacha][0] = 1728.80066;
        AirFreight[playerid][posGacha][1] = -2433.55786;
        AirFreight[playerid][posGacha][2] = 13.96705;
        AirFreight[playerid][posGacha][3] = -88.86001;

        AirFreight[playerid][active]=true;
        DestroyObject(AirFreight[playerid][container][0]);

        AirFreight[playerid][timer]=gettime()+60;

        x = AirFreight[playerid][posGacha][0];
        y = AirFreight[playerid][posGacha][1];
        z = AirFreight[playerid][posGacha][2];
        a = AirFreight[playerid][posGacha][3];

        DestroyObject(AirFreight[playerid][container][1]);
        AirFreight[playerid][container][1] = CreateObject(2935, x, y, z + 100, 0, 0, a);
        DestroyObject(AirFreight[playerid][container][0]);

        /*switch(random(10))
		{
            case 0..6:
			{
                MovePlayerObject(playerid, AirFreight[playerid][container][1], x, y, z, 12);
            }
            case 7..9:
			{
                DestroyPlayerObject(playerid, AirFreight[playerid][container][0]);
                DestroyPlayerObject(playerid, AirFreight[playerid][container][1]);
                DestroyPlayerObject(playerid, AirFreight[playerid][container][2]);

                AirFreight[playerid][posGacha][0] = 0.0;
                AirFreight[playerid][posGacha][1] = 0.0;
                AirFreight[playerid][posGacha][2] = 0.0;
                AirFreight[playerid][posGacha][3] = 0.0;

                AirFreight[playerid][active] = false;
                KillTimer(AirFreight[playerid][ttimer]);
            }
        }*/

        MoveObject(AirFreight[playerid][container][1], x, y, z, 12);

        AirType = type;
        AirOwner = playerid;
        //Air_Stats = 0;
        AirOn = 1;
    }
    return true;
}

task ContainerTime[1000]()
{
    new string[256];

    foreach (new playerid : Player)
    {
	    if (AirOn == 1)
		{
		    AirTime --;

			new
				hours,
				minutes,
				seconds;

			GetElapsedTimeEventEvent(AirTime, hours, minutes, seconds);

			if (AirTime == 0)
			{
				DeleteContainer(playerid);
			}
			else if (AirType == 1)
			{
				format(string, sizeof(string), "{21BBEC}[เจ้าของ]\n{979795}สุ่มด้วยเงินเขียว\n{ECE321}%s\n{FFFFFF}%02d:%02d\n{F85B39}(กดปุ่ม 'N' เพื่อเปิดกล่อง)", GetPlayerNameEx(AirOwner), minutes, seconds);
				UpdateDynamic3DTextLabelText(AirText, 0xFFFFFFFF, string);
			}
			else if (AirType == 2)
			{
				format(string, sizeof(string), "{21BBEC}[เจ้าของ]\n{EC4921}สุ่มด้วย Coin\n{ECE321}%s\n{FFFFFF}%02d:%02d\n{F85B39}(กดปุ่ม 'N' เพื่อเปิดกล่อง)", GetPlayerNameEx(AirOwner), minutes, seconds);
				UpdateDynamic3DTextLabelText(AirText, 0xFFFFFFFF, string);
			}
		}
	}
	return 1;
}

hook OnProgressFinish(playerid, objectid)
{
	if (isAirOpen[playerid] == 1)
		AirOpenBox(playerid);

	return Y_HOOKS_CONTINUE_RETURN_0;
}

hook OnProgressUpdate(playerid, progress, objectid)
{
	if (isAirOpen[playerid] == 1)
	{
		ApplyAnimation(playerid, "BD_FIRE","wash_up", 4.1, 1, 0, 0, 1, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}
    return Y_HOOKS_CONTINUE_RETURN_0;
}

AirOpenBox(playerid)
{
    isAirOpen[playerid] = 0;
    ClearAnimations(playerid);
    TogglePlayerControllable(playerid, true);

	new rand = random(sizeof(carRandom_Gacha));

	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carPrice, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %d, %.1f, '562.3970', '-1283.8485', '17.0007', '0.0000')", playerData[playerid][pID], GetPlayerNameEx(playerid), carRandom_Gacha[rand][0], 0, 100.0);
	mysql_tquery(g_SQL, query);

	Dialog_Show(playerid,ShowOnly,DIALOG_STYLE_MSGBOX,"{FBF009}[ เปิดกล่องสุ่มรถ ]","{ffffff}+ คุณได้รับรถรุ่น {FBF009}'%s' {ffffff}จากการเปิดกล่องสุ่มรถ","ออก","", g_arrVehicleNames[carRandom_Gacha[rand][0] - 400]);
    DeleteContainer(playerid);
}

CMD:warpcon(playerid)
{
	if (playerData[playerid][pAdmin] < 1)
	    return 1;

	SetPlayerPos(playerid, 1728.8044,-2448.0576,13.5547);
	SetPlayerFacingAngle(playerid, 2.2405);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);

	SendClientMessage(playerid, COLOR_YELLOW, "คุณได้วาร์ปมาที่คอนเทนเนอร์สุ่มรถแล้ว");
	return 1;
}
