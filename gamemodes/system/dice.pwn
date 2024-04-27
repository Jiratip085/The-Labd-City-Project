/*
	|=======================|

	ระบบ 'ทอยลูกเต๋า' (Dice)
	Create : Richard
	for Savages City SS2
	
	|=======================|
	
*/

#include 	<YSI_Coding\y_hooks>

// ตัวแปร (Public)
new DiceTime;
new DiceStats;
new Dice1;
new Dice2;
new Dice3;
new Text3D:DiceText;
new DiceObject[3];
new Text3D:DicePointText[3];
new DiceID[3];
new DiceSeconds;

enum dice_data {
	dice_model,
	dice_amount,
	Float:dice_x,
	Float:dice_y,
	Float:dice_z,
	Float:dice_rx,
	Float:dice_ry,
	Float:dice_rz,
	Float:dice_movex,
	Float:dice_movey,
	Float:dice_movez,
    Float:dice_movespeed,
	Float:dice_moverx,
	Float:dice_movery,
	Float:dice_moverz
};

// ตัวแปร (Player)
new diceOn[MAX_PLAYERS];
new diceBet[MAX_PLAYERS][9];
new diceBetCash[MAX_PLAYERS][9];
new diceActive[MAX_PLAYERS][9];
new diceType[MAX_PLAYERS];

// ลูกเต๋า (1)
new DiceData1[][dice_data] =
{
    { 1851, 1, 2236.7080, 1677.3615, 1009.0526, -2.00000, 0.00000, 0.00000,/* MoveObject */ 2236.7080, 1677.3615, 1008.5469, 1.0, -2.00000, 0.00000, 0.00000 },
    { 1851, 2, 2236.7080, 1677.3615, 1009.0526, 2.00000, 91.00000, 0.00000,/* MoveObject */ 2236.7080, 1677.3615, 1008.5469, 1.0, 2.00000, 91.00000, 0.00000 },
    { 1851, 3, 2236.7080, 1677.3615, 1009.0526, -91.00000, -91.00000, 0.00000,/* MoveObject */ 2236.7080, 1677.3615, 1008.5469, 1.0, -91.00000, -91.00000, 0.00000 },
    { 1852, 4, 2236.7080, 1677.3615, 1009.0526, -91.00000, -4.00000, 0.00000,/* MoveObject */ 2236.7080, 1677.3615, 1008.5469, 1.0, -91.00000, -4.00000, 0.00000 },
    { 1852, 5, 2236.7080, 1677.3615, 1009.0526, -185.00000, 91.00000, 0.00000,/* MoveObject */ 2236.7080, 1677.3615, 1008.5469, 1.0, -185.00000, 91.00000, 0.00000 },
    { 1852, 6, 2236.7080, 1677.3615, 1009.0526, -185.00000, 180.00000, 0.00000,/* MoveObject */ 2236.7080, 1677.3615, 1008.5469, 1.0, -185.00000, 180.00000, 0.00000 }
};

// ลูกเต๋า (2)
new DiceData2[][dice_data] =
{
    { 1852, 1, 2235.9482, 1677.3602, 1009.0526, -360.00000, 180.00000, 45.00000,/* MoveObject */ 2235.9482, 1677.3602, 1008.5458, 1.0, -360.00000, 180.00000, 45.00000 },
    { 1852, 2, 2235.9482, 1677.3602, 1009.0526, -360.00000, 91.00000, 45.00000,/* MoveObject */ 2235.9482, 1677.3602, 1008.5458, 1.0, -360.00000, 91.00000, 45.00000 },
    { 1852, 3, 2235.9482, 1677.3602, 1009.0526, -273.00000, 84.00000, 47.00000,/* MoveObject */ 2235.9482, 1677.3602, 1008.5458, 1.0, -273.00000, 84.00000, 47.00000 },
    { 1852, 4, 2235.9482, 1677.3602, 1009.0526, -91.00000, 84.00000, 47.00000,/* MoveObject */ 2235.9482, 1677.3602, 1008.5458, 1.0, -91.00000, 84.00000, 47.00000 },
    { 1852, 5, 2235.9482, 1677.3602, 1009.0526, -180.00000, 91.00000, 47.00000,/* MoveObject */ 2235.9482, 1677.3602, 1008.5458, 1.0, -180.00000, 91.00000, 47.00000 },
	{ 1852, 6, 2235.9482, 1677.3602, 1009.0526, -178.00000, 180.00000, 47.00000,/* MoveObject */ 2235.9482, 1677.3602, 1008.5458, 1.0, -178.00000, 180.00000, 47.00000 }
};

// ลูกเต๋า (3)
new DiceData3[][dice_data] =
{
    { 1852, 1, 2235.2085, 1677.3588, 1009.0526, 0.00000, 180.00000, 0.00000,/* MoveObject */ 2235.2085, 1677.3588, 1008.5299, 1.0, 0.00000, 180.00000, 0.00000 },
    { 1852, 2, 2235.2085, 1677.3588, 1009.0526, 0.00000, 91.00000, 0.00000,/* MoveObject */ 2235.2085, 1677.3588, 1008.5299, 1.0, 0.00000, 91.00000, 0.00000 },
    { 1852, 3, 2235.2085, 1677.3588, 1009.0526, 89.00000, 91.00000, 0.00000,/* MoveObject */ 2235.2085, 1677.3588, 1008.5299, 1.0, 89.00000, 91.00000, 0.00000 },
    { 1852, 4, 2235.2085, 1677.3588, 1009.0526, -91.00000, 76.00000, 0.00000,/* MoveObject */ 2235.2085, 1677.3588, 1008.5299, 1.0, -91.00000, 76.00000, 0.00000 },
    { 1852, 5, 2235.2085, 1677.3588, 1009.0526, -180.00000, 91.00000, 0.00000,/* MoveObject */ 2235.2085, 1677.3588, 1008.5299, 1.0, -180.00000, 91.00000, 0.00000 },
    { 1852, 6, 2235.2085, 1677.3588, 1009.0526, -180.00000, 180.00000, -4.00000,/* MoveObject */ 2235.2085, 1677.3588, 1008.5299, 1.0, -180.00000, 180.00000, -4.00000 }
};

hook OnGameModeInit()
{
	// โต๊ะเดิมพัน
    CreateDynamicObject(19474, 2235.88794, 1677.33691, 1007.86975,   0.00000, 0.00000, 89.88001);
    
    // เริ่มต้นการนับถอยหลังลูกเต๋า
	DiceText = CreateDynamic3DTextLabel("{EEEE06}[ โต๊ะไฮโล ]\n{FFFFFF}00:40\n{F95825}(กดปุ่ม 'N' เพื่อวางเดิมพัน)", COLOR_YELLOW, 2235.88794, 1677.33691, 1007.86975 + 1.0, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 10.0);
    StartDice();
}

hook OnPlayerConnect(playerid)
{
    // เคลียร์ตัวแปร (Player)
    ClearPlayerDice(playerid);
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	// การวางเดิมพัน
	if (newkeys & KEY_NO && !IsPlayerInAnyVehicle(playerid))
	{
	    // การวางเดิมพัน (ลูกเต๋า)
		if (IsPlayerInRangeOfPoint(playerid, 3.0, 2235.88794, 1677.33691, 1007.86975))
		{
		    OpenDiceCasino(playerid);
		}
	}
	return 1;
}

task DiceTimer[1000]()
{
	static
	    hours,
	    minutes,
	    seconds,
	    str[128];

	if (DiceSeconds > 0)
	{
	    DiceSeconds --;

	    if (DiceSeconds == 0)
	    {
			// เริ่มต้นการนับถอยหลังลูกเต๋า
			StartDice();
		}
	}
	else if (DiceStats == 0)
	{
		DiceTime --;

		GetElapsedTime(DiceTime, hours, minutes, seconds);

		format(str, sizeof(str), "{EEEE06}[ โต๊ะไฮโล ]\n{FFFFFF}%02d:%02d\n{F95825}(กดปุ่ม 'N' เพื่อวางเดิมพัน)", minutes, seconds);
		UpdateDynamic3DTextLabelText(DiceText, COLOR_YELLOW, str);

		if (DiceTime == 0)
		{
			DiceStats = 1;
		}
	}
	else if (DiceStats == 1)
	{
	    if (Dice1 == 0)
	    {
    		new dice = random(sizeof(DiceData1));
     		DiceObject[0] = CreateObject(DiceData1[dice][dice_model], DiceData1[dice][dice_x], DiceData1[dice][dice_y], DiceData1[dice][dice_z], DiceData1[dice][dice_rx], DiceData1[dice][dice_ry], DiceData1[dice][dice_rz]);
            MoveObject(DiceObject[0], DiceData1[dice][dice_movex], DiceData1[dice][dice_movey], DiceData1[dice][dice_movez], DiceData1[dice][dice_movespeed], DiceData1[dice][dice_moverx], DiceData1[dice][dice_movery], DiceData1[dice][dice_moverz]);
            DiceID[0] = dice;
		}
	}
	return 1;
}

public OnObjectMoved(objectid)
{
	new str[64];
    if (objectid == DiceObject[0])
    {
        new dice = DiceID[0];
        Dice1 = DiceData1[dice][dice_amount];
        
        format(str, sizeof(str), "{EEEE06}%d", Dice1);
		DicePointText[0] = CreateDynamic3DTextLabel(str, COLOR_YELLOW, DiceData1[dice][dice_movex], DiceData1[dice][dice_movey], DiceData1[dice][dice_movez], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 10.0);

		new dicex = random(sizeof(DiceData2));
		DiceObject[1] = CreateObject(DiceData2[dicex][dice_model], DiceData2[dicex][dice_x], DiceData2[dicex][dice_y], DiceData2[dicex][dice_z], DiceData2[dicex][dice_rx], DiceData2[dicex][dice_ry], DiceData2[dicex][dice_rz]);
		MoveObject(DiceObject[1], DiceData2[dicex][dice_movex], DiceData2[dicex][dice_movey], DiceData2[dicex][dice_movez], DiceData2[dicex][dice_movespeed], DiceData2[dicex][dice_moverx], DiceData2[dicex][dice_movery], DiceData2[dicex][dice_moverz]);
        DiceID[1] = dicex;
	}
  	else if (objectid == DiceObject[1])
  	{
  	    new dice = DiceID[1];
        Dice2 = DiceData2[dice][dice_amount];

        format(str, sizeof(str), "{EEEE06}%d", Dice2);
		DicePointText[1] = CreateDynamic3DTextLabel(str, COLOR_YELLOW, DiceData2[dice][dice_movex], DiceData2[dice][dice_movey], DiceData2[dice][dice_movez], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 10.0);

		new dicex = random(sizeof(DiceData3));
		DiceObject[2] = CreateObject(DiceData3[dicex][dice_model], DiceData3[dicex][dice_x], DiceData3[dicex][dice_y], DiceData3[dicex][dice_z], DiceData3[dicex][dice_rx], DiceData3[dicex][dice_ry], DiceData2[dicex][dice_rz]);
		MoveObject(DiceObject[2], DiceData3[dicex][dice_movex], DiceData3[dicex][dice_movey], DiceData3[dicex][dice_movez], DiceData3[dicex][dice_movespeed], DiceData3[dicex][dice_moverx], DiceData3[dicex][dice_movery], DiceData3[dicex][dice_moverz]);
        DiceID[2] = dicex;
  	}
  	else if (objectid == DiceObject[2])
  	{
  	    new dice = DiceID[2];
        Dice3 = DiceData3[dice][dice_amount];

        format(str, sizeof(str), "{EEEE06}%d", Dice3);
		DicePointText[2] = CreateDynamic3DTextLabel(str, COLOR_YELLOW, DiceData3[dice][dice_movex], DiceData3[dice][dice_movey], DiceData3[dice][dice_movez], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 10.0);

		// ประกาศแต้มของ 'Dice'
        PointDice();
        DiceSeconds = 3;
	}
    return 1;
}

// ประกาศแต้มของ 'Dice'
PointDice()
{
	foreach (new i : Player)
	{
	    new point = Dice1 + Dice2 + Dice3;

		if (diceOn[i] == 1)
		{
			SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {F95825}%d + %d + %d = {ffffff}'%d'", Dice1, Dice2, Dice3, point);

			// การเดิมพัน '1'
			if (diceBet[i][0] == 1 && diceBetCash[i][0] > 0)
			{
			    if (Dice1 == 1 || Dice2 == 1 || Dice3 == 1)
			    {
					GivePlayerMoneyEx(i, diceBetCash[i][0] * 2);
					SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณชนะการเดิมพัน {02CF18}'1'");
					SendClientMessageEx(i, COLOR_GREEN, "[ไฮโล] {F77653}คุณได้รับเงินจำนวน %s จากการชนะเดิมพัน", FormatMoney(diceBetCash[i][0] * 2));
			    }
			    else
			    {
			        SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณแพ้การเดิมพัน {CF2102}'1'");
					SendClientMessageEx(i, COLOR_RED, "[ไฮโล] {F77653}คุณเสียเงินจำนวน %s จากการแพ้เดิมพัน", FormatMoney(diceBetCash[i][0]));
			    }
			}
			// ------------------------------------------------------------------------------------------
			// การเดิมพัน '2'
			if (diceBet[i][1] == 1 && diceBetCash[i][1] > 0)
			{
			    if (Dice1 == 2 || Dice2 == 2 || Dice3 == 2)
			    {
					GivePlayerMoneyEx(i, diceBetCash[i][1] * 2);
					SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณชนะการเดิมพัน {02CF18}'2'");
					SendClientMessageEx(i, COLOR_GREEN, "[ไฮโล] {F77653}คุณได้รับเงินจำนวน %s จากการชนะเดิมพัน", FormatMoney(diceBetCash[i][1] * 2));
			    }
			    else
			    {
			        SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณแพ้การเดิมพัน {CF2102}'2'");
					SendClientMessageEx(i, COLOR_RED, "[ไฮโล] {F77653}คุณเสียเงินจำนวน %s จากการแพ้เดิมพัน", FormatMoney(diceBetCash[i][1]));
			    }
			}
			// ------------------------------------------------------------------------------------------
			// การเดิมพัน '3'
			if (diceBet[i][2] == 1 && diceBetCash[i][2] > 0)
			{
			    if (Dice1 == 3 || Dice2 == 3 || Dice3 == 3)
			    {
					GivePlayerMoneyEx(i, diceBetCash[i][2] * 2);
					SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณชนะการเดิมพัน {02CF18}'3'");
					SendClientMessageEx(i, COLOR_GREEN, "[ไฮโล] {F77653}คุณได้รับเงินจำนวน %s จากการชนะเดิมพัน", FormatMoney(diceBetCash[i][2] * 2));
			    }
			    else
			    {
			        SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณแพ้การเดิมพัน {CF2102}'3'");
					SendClientMessageEx(i, COLOR_RED, "[ไฮโล] {F77653}คุณเสียเงินจำนวน %s จากการแพ้เดิมพัน", FormatMoney(diceBetCash[i][2]));
			    }
			}
			// ------------------------------------------------------------------------------------------
			// การเดิมพัน '4'
			if (diceBet[i][3] == 1 && diceBetCash[i][3] > 0)
			{
			    if (Dice1 == 4 || Dice2 == 4 || Dice3 == 4)
			    {
					GivePlayerMoneyEx(i, diceBetCash[i][3] * 2);
					SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณชนะการเดิมพัน {02CF18}'4'");
					SendClientMessageEx(i, COLOR_GREEN, "[ไฮโล] {F77653}คุณได้รับเงินจำนวน %s จากการชนะเดิมพัน", FormatMoney(diceBetCash[i][3] * 2));
			    }
			    else
			    {
			        SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณแพ้การเดิมพัน {CF2102}'4'");
					SendClientMessageEx(i, COLOR_RED, "[ไฮโล] {F77653}คุณเสียเงินจำนวน %s จากการแพ้เดิมพัน", FormatMoney(diceBetCash[i][3]));
			    }
			}
			// ------------------------------------------------------------------------------------------
			// การเดิมพัน '5'
			if (diceBet[i][4] == 1 && diceBetCash[i][4] > 0)
			{
			    if (Dice1 == 5 || Dice2 == 5 || Dice3 == 5)
			    {
					GivePlayerMoneyEx(i, diceBetCash[i][4] * 2);
					SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณชนะการเดิมพัน {02CF18}'5'");
					SendClientMessageEx(i, COLOR_GREEN, "[ไฮโล] {F77653}คุณได้รับเงินจำนวน %s จากการชนะเดิมพัน", FormatMoney(diceBetCash[i][4] * 2));
			    }
			    else
			    {
			        SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณแพ้การเดิมพัน {CF2102}'5'");
					SendClientMessageEx(i, COLOR_RED, "[ไฮโล] {F77653}คุณเสียเงินจำนวน %s จากการแพ้เดิมพัน", FormatMoney(diceBetCash[i][4]));
			    }
			}
			// ------------------------------------------------------------------------------------------
			// การเดิมพัน '6'
			if (diceBet[i][5] == 1 && diceBetCash[i][5] > 0)
			{
			    if (Dice1 == 6 || Dice2 == 6 || Dice3 == 6)
			    {
					GivePlayerMoneyEx(i, diceBetCash[i][5] * 2);
					SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณชนะการเดิมพัน {02CF18}'6'");
					SendClientMessageEx(i, COLOR_GREEN, "[ไฮโล] {F77653}คุณได้รับเงินจำนวน %s จากการชนะเดิมพัน", FormatMoney(diceBetCash[i][5] * 2));
			    }
			    else
			    {
			        SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณแพ้การเดิมพัน {CF2102}'6'");
					SendClientMessageEx(i, COLOR_RED, "[ไฮโล] {F77653}คุณเสียเงินจำนวน %s จากการแพ้เดิมพัน", FormatMoney(diceBetCash[i][5]));
			    }
			}
			// ------------------------------------------------------------------------------------------
			// การเดิมพัน 'ต่ำ'
			if (diceBet[i][6] == 1 && diceBetCash[i][6] > 0)
			{
			    if (point >= 3 && point <= 10)
			    {
					GivePlayerMoneyEx(i, diceBetCash[i][6] * 2);
					SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณชนะการเดิมพัน {02CF18}'ต่ำ'");
					SendClientMessageEx(i, COLOR_GREEN, "[ไฮโล] {F77653}คุณได้รับเงินจำนวน %s จากการชนะเดิมพัน", FormatMoney(diceBetCash[i][6] * 2));
			    }
			    else
			    {
			        SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณแพ้การเดิมพัน {CF2102}'ต่ำ'");
					SendClientMessageEx(i, COLOR_RED, "[ไฮโล] {F77653}คุณเสียเงินจำนวน %s จากการแพ้เดิมพัน", FormatMoney(diceBetCash[i][6]));
			    }
			}
			// ------------------------------------------------------------------------------------------
			// การเดิมพัน 'สูง'
			if (diceBet[i][7] == 1 && diceBetCash[i][7] > 0)
			{
			    if (point >= 12 && point <= 18)
			    {
					GivePlayerMoneyEx(i, diceBetCash[i][7] * 2);
					SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณชนะการเดิมพัน {02CF18}'สูง'");
					SendClientMessageEx(i, COLOR_GREEN, "[ไฮโล] {F77653}คุณได้รับเงินจำนวน %s จากการชนะเดิมพัน", FormatMoney(diceBetCash[i][7] * 2));
			    }
			    else
			    {
			        SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณแพ้การเดิมพัน {CF2102}'สูง'");
					SendClientMessageEx(i, COLOR_RED, "[ไฮโล] {F77653}คุณเสียเงินจำนวน %s จากการแพ้เดิมพัน", FormatMoney(diceBetCash[i][7]));
			    }
			}
			// ------------------------------------------------------------------------------------------
			// การเดิมพัน '11 ไฮโล'
			if (diceBet[i][8] == 1 && diceBetCash[i][8] > 0)
			{
			    if (point == 11)
			    {
					GivePlayerMoneyEx(i, diceBetCash[i][8] * 5);
					SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณชนะการเดิมพัน {02CF18}'11 ไฮโล'");
					SendClientMessageEx(i, COLOR_GREEN, "[ไฮโล] {F77653}คุณได้รับเงินจำนวน %s จากการชนะเดิมพัน", FormatMoney(diceBetCash[i][8] * 5));
			    }
			    else
			    {
			        SendClientMessageEx(i, -1, "{EEEE06}[ไฮโล] {FFFFFF}คุณแพ้การเดิมพัน {CF2102}'11 ไฮโล'");
					SendClientMessageEx(i, COLOR_RED, "[ไฮโล] {F77653}คุณเสียเงินจำนวน %s จากการแพ้เดิมพัน", FormatMoney(diceBetCash[i][8]));
			    }
			}
			// ------------------------------------------------------------------------------------------

			// เคลียร์ตัวแปร (Player)
			ClearPlayerDice(i);
		}
	}
}

// ลบลูกเต๋าทั้งหมดออก
DestroyDiceAll()
{
	DestroyObject(DiceObject[0]);
	DestroyObject(DiceObject[1]);
	DestroyObject(DiceObject[2]);

	if(IsValidDynamic3DTextLabel(DicePointText[0]))
		DestroyDynamic3DTextLabel(DicePointText[0]);

	if(IsValidDynamic3DTextLabel(DicePointText[1]))
		DestroyDynamic3DTextLabel(DicePointText[1]);

	if(IsValidDynamic3DTextLabel(DicePointText[2]))
		DestroyDynamic3DTextLabel(DicePointText[2]);
}

// เริ่มต้นการนับถอยหลังลูกเต๋า
StartDice()
{
    DestroyDiceAll();
 	DiceTime = 40;
 	DiceStats = 0;
 	Dice1 = 0;
 	Dice2 = 0;
 	Dice3 = 0;
	DiceID[0] = 0;
	DiceID[1] = 0;
	DiceID[2] = 0;
	DiceSeconds = 0;
}

// เคลียร์ตัวแปร (Player)
ClearPlayerDice(playerid)
{
    diceOn[playerid] = 0;
    diceType[playerid] = 0;
    
    for (new i = 0; i < 9; i ++)
    {
        diceBet[playerid][i] = 0;
        diceBetCash[playerid][i] = 0;
        diceActive[playerid][i] = 0;
    }
}

// หน้าต่างการวางเดิมพัน
OpenDiceCasino(playerid)
{
	new string100[512];
	new string2[512];

	format(string100, sizeof(string100), "{FFFFFF}1\t{25B2F9}x1\t{FFFFFF}%s\n", FormatMoney(diceBetCash[playerid][0]));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFFFFF}2\t{25B2F9}x1\t{FFFFFF}%s\n", FormatMoney(diceBetCash[playerid][1]));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFFFFF}3\t{25B2F9}x1\t{FFFFFF}%s\n", FormatMoney(diceBetCash[playerid][2]));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFFFFF}4\t{25B2F9}x1\t{FFFFFF}%s\n", FormatMoney(diceBetCash[playerid][3]));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFFFFF}5\t{25B2F9}x1\t{FFFFFF}%s\n", FormatMoney(diceBetCash[playerid][4]));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFFFFF}6\t{25B2F9}x1\t{FFFFFF}%s\n", FormatMoney(diceBetCash[playerid][5]));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFFFFF}ต่ำ\t{25B2F9}x1\t{FFFFFF}%s\n", FormatMoney(diceBetCash[playerid][6]));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFFFFF}สูง\t{25B2F9}x1\t{FFFFFF}%s\n", FormatMoney(diceBetCash[playerid][7]));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFFFFF}11 ไฮโล\t{F9F325}x5\t{FFFFFF}%s\n", FormatMoney(diceBetCash[playerid][8]));
	strcat(string2,string100);

	Dialog_Show(playerid,DIALOG_DICE,DIALOG_STYLE_TABLIST,"การเดิมพัน",string2,"ตกลง","ออก");
}

// เลือกเดิมพัน 'Dice'
Dialog:DIALOG_DICE(playerid, response, listitem, inputtext[])
{
	if (DiceStats == 1)
		return Dialog_Show(playerid,ShowOnly,DIALOG_STYLE_MSGBOX,"{F93825}ผิดพลาด!","{F93825}[!] {FFFFFF}หมดเวลาการวางเดิมพันแล้ว","ตกลง","");

	if (response)
	{
		switch(listitem)
  		{
			case 0:
			{
			    diceType[playerid] = listitem;
				Dialog_Show(playerid,DIALOG_DICE_CASH,DIALOG_STYLE_INPUT,"การเดิมพัน","{FFFFFF}คุณต้องการลงเดิมพัน {F9F325}1 {FFFFFF}เป็นเงินเท่าไร ?","ตกลง","ยกเลิก");
			}
			case 1:
			{
			    diceType[playerid] = listitem;
				Dialog_Show(playerid,DIALOG_DICE_CASH,DIALOG_STYLE_INPUT,"การเดิมพัน","{FFFFFF}คุณต้องการลงเดิมพัน {F9F325}2 {FFFFFF}เป็นเงินเท่าไร ?","ตกลง","ยกเลิก");
			}
			case 2:
			{
			    diceType[playerid] = listitem;
				Dialog_Show(playerid,DIALOG_DICE_CASH,DIALOG_STYLE_INPUT,"การเดิมพัน","{FFFFFF}คุณต้องการลงเดิมพัน {F9F325}3 {FFFFFF}เป็นเงินเท่าไร ?","ตกลง","ยกเลิก");
			}
			case 3:
			{
			    diceType[playerid] = listitem;
				Dialog_Show(playerid,DIALOG_DICE_CASH,DIALOG_STYLE_INPUT,"การเดิมพัน","{FFFFFF}คุณต้องการลงเดิมพัน {F9F325}4 {FFFFFF}เป็นเงินเท่าไร ?","ตกลง","ยกเลิก");
			}
			case 4:
			{
			    diceType[playerid] = listitem;
				Dialog_Show(playerid,DIALOG_DICE_CASH,DIALOG_STYLE_INPUT,"การเดิมพัน","{FFFFFF}คุณต้องการลงเดิมพัน {F9F325}5 {FFFFFF}เป็นเงินเท่าไร ?","ตกลง","ยกเลิก");
			}
			case 5:
			{
			    diceType[playerid] = listitem;
				Dialog_Show(playerid,DIALOG_DICE_CASH,DIALOG_STYLE_INPUT,"การเดิมพัน","{FFFFFF}คุณต้องการลงเดิมพัน {F9F325}6 {FFFFFF}เป็นเงินเท่าไร ?","ตกลง","ยกเลิก");
			}
			case 6:
			{
			    diceType[playerid] = listitem;
				Dialog_Show(playerid,DIALOG_DICE_CASH,DIALOG_STYLE_INPUT,"การเดิมพัน","{FFFFFF}คุณต้องการลงเดิมพัน {F9F325}ต่ำ {FFFFFF}เป็นเงินเท่าไร ?","ตกลง","ยกเลิก");
			}
			case 7:
			{
			    diceType[playerid] = listitem;
				Dialog_Show(playerid,DIALOG_DICE_CASH,DIALOG_STYLE_INPUT,"การเดิมพัน","{FFFFFF}คุณต้องการลงเดิมพัน {F9F325}สูง {FFFFFF}เป็นเงินเท่าไร ?","ตกลง","ยกเลิก");
			}
			case 8:
			{
			    diceType[playerid] = listitem;
				Dialog_Show(playerid,DIALOG_DICE_CASH,DIALOG_STYLE_INPUT,"การเดิมพัน","{FFFFFF}คุณต้องการลงเดิมพัน {F9F325}11 ไฮโล {FFFFFF}เป็นเงินเท่าไร ?","ตกลง","ยกเลิก");
			}
		}
	}
	return 1;
}

// วางเงินการเดิมพัน 'Dice'
Dialog:DIALOG_DICE_CASH(playerid, response, listitem, inputtext[])
{
	new cash = strval(inputtext);

	if (DiceStats == 1)
		return Dialog_Show(playerid,ShowOnly,DIALOG_STYLE_MSGBOX,"{F93825}ผิดพลาด!","{F93825}[!] {FFFFFF}หมดเวลาการวางเดิมพันแล้ว","ตกลง","");

	if (cash < 1 || cash > 1500)
		return Dialog_Show(playerid,ShowOnly,DIALOG_STYLE_MSGBOX,"{F93825}ผิดพลาด!","{F93825}[!] {FFFFFF}จำนวนการวางเงินเดิมพันต้องอยู่ระหว่าง $1 - $1,500","ตกลง","");

	if (GetPlayerMoneyEx(playerid) < cash)
		return Dialog_Show(playerid,ShowOnly,DIALOG_STYLE_MSGBOX,"{F93825}ผิดพลาด!","{F93825}[!] {FFFFFF}คุณมีเงินไม่เพียงพอต่อการเดิมพัน","ตกลง","");

	if (diceActive[playerid][diceType[playerid]] == 1)
		return Dialog_Show(playerid,ShowOnly,DIALOG_STYLE_MSGBOX,"{F93825}ผิดพลาด!","{F93825}[!] {FFFFFF}คุณได้การเดิมพันตัวเลขนี้ไปแล้ว!","ตกลง","");

	if (response)
	{
        GivePlayerMoneyEx(playerid, -cash);
 		PlayerDiceBet(playerid, diceType[playerid], cash);
 		OpenDiceCasino(playerid);
 		diceType[playerid] = -1;
	}
	return 1;
}

PlayerDiceBet(playerid, type, cash)
{
	diceOn[playerid] = 1;
	diceActive[playerid][type] = 1;
	diceBet[playerid][type] = 1;
	diceBetCash[playerid][type] += cash;
	SendClientMessageEx(playerid, COLOR_GREEN, "[ไฮโล] {F77653}คุณวางเดิมพันจำนวนเงิน %s", FormatMoney(cash));
}

CMD:resetdice(playerid)
{
    if (playerData[playerid][pAdmin] < 1)
	    return 1;

    foreach (new i : Player)
    {
        ClearPlayerDice(i);
    }
    StartDice();
    SendClientMessage(playerid, COLOR_LIGHTRED, "ระบบไฮโล: {F9E605}คุณได้ทำการรีเซ็ตระบบการทอย 'ลูกเต๋า' แล้ว");
    return 1;
}
