
#include	<YSI_Coding\y_hooks>
#include 	<YSI_Coding\y_timers>

// TOLL SYSTEM

// Main configuration
#define TollCost (100) 					// How much it costs to pass the tolls
//#define TollPayCops (0) 				// Amount of percent that goes to the LSPD and SASD (Ex: 20 = 20% to LSPD, 20% to SASD, total 40% to cops)

#define TollDelayCivilian (6) 			// The timespace in seconds between each /opentoll command for the same player
#define TollDelayCop (2) 				// The timespace in seconds between each /toll command for all cops (To avoid spam)
#define TollOpenDistance (8.0) 			// The distance in units the player can be from the icon to open the toll

#define TollTimer (30)				 	// The amount of seconds that tolls are locked normally
#define TollTimerEmergency (60) 		// The amount of seconds that all tolls are locked after /toll emergency

// Other defines
#define MAX_TOLLS (3) // Amount of tolls
#define INVALID_TOLL_ID (-1)
#define RichmanToll (0)
#define FlintToll (1)
#define LVToll (2)

enum E_TOLLDATA
{
	E_tAllowReq, // One timer for each toll
	E_tLocked,  // 0 = Richhman, 1 = Flint, 2 = LV, 3 = Airport
	E_tTimer // 0 = Richhman, 1 = Flint, 2 = LV, 3 = Airport
}
new aTolls[MAX_TOLLS][E_TOLLDATA];

new /*L_a_RequestAllowedCop,*/ // The same timer for all /toll changes

	L_a_TollID[MAX_PLAYERS],
	L_a_TollTime[MAX_PLAYERS],
	L_a_TollEnter[MAX_PLAYERS],

	L_a_Pickup[MAX_TOLLS*2],  // 0 & 1 = Richhman, 2 & 3 = Flint, 4 & 5 = LV, 6 = Airport
	L_a_TollObject[MAX_TOLLS*2]; // 0 & 1 = Richhman, 2 & 3 = Flint, 4 & 5 = LV, 6 = Airport


//new Spray_Pickup[4];

hook OnPlayerConnect(playerid)
{
	if(L_a_TollID[playerid] != INVALID_TOLL_ID)
	{
	    Toll_CloseTollID(playerid, L_a_TollID[playerid]);
	}
}

hook OnGameModeInit()
{
	for(new i; i < MAX_PLAYERS; i++)
	    L_a_TollID[i] = INVALID_TOLL_ID;

	/* Richman */
	CreateDynamicObject( 8168, 612.73895263672, -1191.4602050781, 20.294105529785, 0.000000, 5, 318.31237792969, -1 );
	CreateDynamicObject( 8168, 620.47265625, -1188.49609375, 20.044105529785, 0.000000, 352.99621582031, 138.94409179688, -1 );
	CreateDynamicObject( 966, 613.97229003906, -1197.7174072266, 17.475030899048, 0.000000, 0.000000, 23.81982421875, -1 );
	CreateDynamicObject( 997, 614.33209228516, -1194.3870849609, 17.709369659424, 0.000000, 0.000000, 266.70568847656, -1 );
	CreateDynamicObject( 973, 602.98425292969, -1202.1643066406, 18.000516891479, 0.000000, 0.000000, 19.849853515625, -1 );
	// Richman 1 Object [1] Pickup [0] Door 1
	L_a_TollObject[1] = CreateDynamicObject( 968, 613.8935546875, -1197.7329101563, 18.109180450439, 0.000000, -90.000000, 23.81982421875, -1 );
	CreateDynamicObject( 966, 619.42913818359, -1181.6597900391, 18.725030899048, 0.000000, 0.000000, 214.37744140625, -1 );
	CreateDynamicObject( 973, 629.68823242188, -1176.0551757813, 19.500516891479, 0.000000, 0.000000, 21.831787109375, -1 );
	CreateDynamicObject( 997, 619.26574707031, -1181.6518554688, 18.709369659424, 0.000000, 0.000000, 268.68908691406, -1 );

	// Richman 2 Object [0] Pickup [1] Door 2
	L_a_TollObject[0] = CreateDynamicObject( 968, 619.44201660156, -1181.6903076172, 19.525806427002, 0.000000, -90.000000, 214.37744140625, -1 );
	/* End of Richman */

	/* Flint */
	CreateDynamicObject( 8168, 61.256042480469, -1533.3946533203, 6.1042537689209, 0.000000, 0.000000, 9.9252624511719, -1 );
	CreateDynamicObject( 8168, 40.966598510742, -1529.5725097656, 6.1042537689209, 0.000000, 0.000000, 188.5712890625, -1 );

	// Flint 1 Object [2] Pickup [2] Door 1
	L_a_TollObject[2] = CreateDynamicObject( 968, 35.838928222656, -1525.9034423828, 5.0012145042419, 0.000000, -90.000000, 270.67565917969, -1 );

	CreateDynamicObject( 966, 35.889751434326, -1526.0096435547, 4.2410612106323, 0.000000, 0.000000, 270.67565917969, -1 );
	CreateDynamicObject( 966, 67.093727111816, -1536.8275146484, 3.9910612106323, 0.000000, 0.000000, 87.337799072266, -1 );

    // Flint 2 Object [3] Pickup [3] Door 2
	L_a_TollObject[3] = CreateDynamicObject( 968, 67.116600036621, -1536.8218994141, 4.7504549026489, 0.000000, -90.000000, 87.337799072266, -1 );
	CreateDynamicObject( 973, 52.9794921875, -1531.9252929688, 5.090488910675, 0.000000, 0.000000, 352.06005859375, -1 );
	CreateDynamicObject( 973, 49.042072296143, -1531.5065917969, 5.1758694648743, 0.000000, 0.000000, 352.05688476563, -1 );
	CreateDynamicObject( 997, 68.289916992188, -1546.6020507813, 4.0626411437988, 0.000000, 0.000000, 119.09942626953, -1 );
	CreateDynamicObject( 997, 34.5198097229, -1516.1402587891, 4.0626411437988, 0.000000, 0.000000, 292.50622558594, -1 );
	CreateDynamicObject( 997, 35.903915405273, -1525.8717041016, 4.0626411437988, 0.000000, 0.000000, 342.13012695313, -1 );
	CreateDynamicObject( 997, 63.914081573486, -1535.7126464844, 4.0626411437988, 0.000000, 0.000000, 342.130859375, -1 );
	/* End of Flint */

	/* LV */
	CreateDynamicObject( 8168, 1789.83203125, 703.189453125, 15.846367835999, 0.000000, 3, 99.24951171875, -1 );
	CreateDynamicObject( 8168, 1784.8334960938, 703.94799804688, 16.070636749268, 0.000000, 357, 278.61096191406, -1 );
	CreateDynamicObject( 966, 1781.4122314453, 697.32531738281, 14.636913299561, 0.000000, 0.000000, 348.09008789063, -1 );
	CreateDynamicObject( 996, 1767.3087158203, 700.50506591797, 15.281567573547, 0.000000, 0.000000, 346.10510253906, -1 );
	CreateDynamicObject( 997, 1781.6832275391, 697.34796142578, 14.698781013489, 0.000000, 3, 77.41455078125, -1 );
	CreateDynamicObject( 997, 1792.7745361328, 706.38543701172, 13.948781013489, 0.000000, 2.999267578125, 81.379638671875, -1 );
	CreateDynamicObject( 966, 1793.4289550781, 709.87982177734, 13.636913299561, 0.000000, 0.000000, 169.43664550781, -1 );
	CreateDynamicObject( 996, 1800.8060302734, 708.38299560547, 14.281567573547, 0.000000, 0.000000, 346.10229492188, -1 );

	// LV 1 Object [4] Pickup [4] Door 1
	L_a_TollObject[4] = CreateDynamicObject( 968, 1781.4133300781, 697.31750488281, 15.420023918152, 0.000000, -90.000000, 348.10229492188, -1 );
    // LV 2 Object [5] Pickup [5] Door 2
	L_a_TollObject[5] = CreateDynamicObject( 968, 1793.6700439453, 709.84631347656, 14.405718803406, 0.000000, -90.000000, 169.43664550781, -1 );
	/* End of LV */

	/*L_a_Pickup[1] = CreateDynamicPickup(1239, 14, 607.9684, -1194.2866, 19.0043, 0); // Richman 1
	L_a_Pickup[0] = CreateDynamicPickup(1239, 14, 623.9500, -1183.9774, 19.2260, 0); //  Richman 2
	L_a_Pickup[2] = CreateDynamicPickup(1239, 14, 39.7039, -1522.9891, 5.1995, 0); // Flint 1
	L_a_Pickup[3] = CreateDynamicPickup(1239, 14, 62.7378, -1539.9891, 5.0639, 0); // Flint 2
	L_a_Pickup[4] = CreateDynamicPickup(1239, 14, 1778.9886, 702.6728, 15.2574, 0); // LV 1
	L_a_Pickup[5] = CreateDynamicPickup(1239, 14, 1795.9447, 704.2550, 15.0006, 0); // LV 2*/

	L_a_Pickup[1] = CreateDynamicPickup(1239, 23, 607.9684, -1194.2866, 19.0043, 0); // Richman 1
	CreateDynamic3DTextLabel("[Expressway]\n{AAAAAA}กด 'H' หรือ 'บีบแตร' เพื่อใช้งาน", COLOR_YELLOW, 607.9684, -1194.2866, 19.0043, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

	L_a_Pickup[0] = CreateDynamicPickup(1239, 23, 623.9500, -1183.9774, 19.2260, 0); //  Richman 2
	CreateDynamic3DTextLabel("[Expressway]\n{AAAAAA}กด 'H' หรือ 'บีบแตร' เพื่อใช้งาน", COLOR_YELLOW, 623.9500, -1183.9774, 19.2260, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

	L_a_Pickup[2] = CreateDynamicPickup(1239, 23, 39.7039, -1522.9891, 5.1995, 0); // Flint 1
	CreateDynamic3DTextLabel("[Expressway]\n{AAAAAA}กด 'H' หรือ 'บีบแตร' เพื่อใช้งาน", COLOR_YELLOW, 39.7039, -1522.9891, 5.1995, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

	L_a_Pickup[3] = CreateDynamicPickup(1239, 23, 62.7378, -1539.9891, 5.0639, 0); // Flint 2
	CreateDynamic3DTextLabel("[Expressway]\n{AAAAAA}กด 'H' หรือ 'บีบแตร' เพื่อใช้งาน", COLOR_YELLOW, 62.7378, -1539.9891, 5.0639, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

	L_a_Pickup[4] = CreateDynamicPickup(1239, 23, 1778.9886, 702.6728, 15.2574, 0); // LV 1
	CreateDynamic3DTextLabel("[Expressway]\n{AAAAAA}กด 'H' หรือ 'บีบแตร' เพื่อใช้งาน", COLOR_YELLOW, 1778.9886, 702.6728, 15.2574, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

	L_a_Pickup[5] = CreateDynamicPickup(1239, 23, 1795.9447, 704.2550, 15.0006, 0); // LV 2
	CreateDynamic3DTextLabel("[Expressway]\n{AAAAAA}กด 'H' หรือ 'บีบแตร' เพื่อใช้งาน", COLOR_YELLOW, 1795.9447, 704.2550, 15.0006, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
}

ptask PlayerToll_Timer[200](playerid)
{
	if(L_a_TollID[playerid] != INVALID_TOLL_ID)
	{
	    if(gettime() > L_a_TollTime[playerid])
	    {
	        Toll_CloseTollID(playerid, L_a_TollID[playerid]);
		}

		else
		{
		    switch(L_a_TollID[playerid])
		    {
		        case RichmanToll:
		        {
				    if(IsPlayerInRangeOfPoint(playerid, 1.0, 619.2152, -1174.6862, 20.5124) || IsPlayerInRangeOfPoint(playerid, 1.0, 612.2329, -1202.9524, 18.1094))
				    {
		                Toll_CloseTollID(playerid, L_a_TollID[playerid]);
					}
				}

				case FlintToll:
				{
				    if(IsPlayerInRangeOfPoint(playerid, 1.0, 29.2651,-1521.5536,4.8644) || IsPlayerInRangeOfPoint(playerid, 1.0, 73.2545, -1541.4111, 5.2093))
				    {
		                Toll_CloseTollID(playerid, L_a_TollID[playerid]);
					}
				}

				case LVToll:
				{
				    if(IsPlayerInRangeOfPoint(playerid, 1.0, 1797.5039, 714.3255, 14.4545) || IsPlayerInRangeOfPoint(playerid, 1.0, 1775.9889, 691.7012, 15.9699))
				    {
		                Toll_CloseTollID(playerid, L_a_TollID[playerid]);
					}
				}
			}
		}
	}
	return 1;
}

hook OP_PickUpDynamicPickup(playerid, pickupid)
{
    if(pickupid == L_a_Pickup[0] || pickupid == L_a_Pickup[1] || pickupid == L_a_Pickup[2] || pickupid == L_a_Pickup[3] || pickupid == L_a_Pickup[4] || pickupid == L_a_Pickup[5])
	{
		if(playerData[playerid][pOnDuty])
		{
		    SendClientMessage(playerid, COLOR_WHITE, "คนเฝ้าด่าน พูดว่า: สวัสดีเจ้าหน้าที่ คุณต้องการจะผ่านใช่ไหม?");
			SendClientMessage(playerid, COLOR_LIGHTRED, "คำแนะนำ : {ffffff}ใช้ \"/opentoll\" เพื่อเปิดด่าน");
			return 1;
		}
		/*new szCostString[56];
		format(szCostString, sizeof(szCostString), "คนเฝ้าด่าน พูดว่า: สวัสดี ค่าผ่านทาง %d ดอลล่า", TollCost);
		SendClientMessage(playerid, COLOR_WHITE, szCostString);
		SendClientMessage(playerid, COLOR_LIGHTRED, "คำแนะนำ : {ffffff}ใช้ \"/opentoll\" เพื่อจ่ายค่าผ่านทาง");*/
		
		Dialog_Show(playerid, DIALOG_OPENTOLL, DIALOG_STYLE_MSGBOX, "[ ด่านกั้นข้ามเมือง ]", "ค่าผ่านทาง : $50\nคุณต้องการจะจ่ายค่าผ่านทางเพื่อเดินทางต่อหรือไม่?", "จ่าย", "ออก");
	}
	return 1;
}

Dialog:DIALOG_OPENTOLL(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	 	new L_i_TollID, doorid;

		if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 623.9500, -1183.9774, 19.2260)) // Richman 2
		{
			L_i_TollID = RichmanToll;
	  		doorid = 2;
		}
		if(IsPlayerInRangeOfPoint(playerid, 10.0, 607.9684, -1194.2866, 19.0043)) // Richman 1
		{
		    L_i_TollID = RichmanToll;
	        doorid = 1;
		}

		if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 39.7039, -1522.9891, 5.1995)) // Flint tolls
		{
			L_i_TollID = FlintToll;
			doorid = 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 10.0, 62.7378, -1539.9891, 5.0639))
		{
		    L_i_TollID = FlintToll;
	        doorid = 2;
		}

		if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 1795.9447, 704.2550, 15.0006)) // LV tolls
		{
			L_i_TollID = LVToll;
			doorid = 2;
		}
		if(IsPlayerInRangeOfPoint(playerid, 10.0, 1778.9886, 702.6728, 15.2574))
		{
		    L_i_TollID = LVToll;
	        doorid = 1;
		}

		if(!doorid)
		    return 1;

	 	if(!Toll_TimePassedCivil(L_i_TollID, playerid))
	  	    return 1;

	    if(!playerData[playerid][pOnDuty])
		{
		    if(aTolls[L_i_TollID][E_tLocked] && aTolls[L_i_TollID][E_tTimer] > gettime()) // If it's locked
		    {
		        SendClientMessageEx(playerid, COLOR_LIGHTRED, "- ไม่สามารถจ่ายค่าผ่านทาง เพื่อเปิดด่านได้ในขณะนี้");
				return 1;
			}
			else if(aTolls[L_i_TollID][E_tLocked]) // If it's time to be unlocked
			{
			    aTolls[L_i_TollID][E_tLocked] = 0;
				new szTollsUnlocked[100];
				switch(L_i_TollID)
				{
					case RichmanToll:
					{
					    format(szTollsUnlocked, 100, "** HQ Announcement: โทลล์เวย์ The Richman ได้รับการปลดล็อคโดยอัตโนมัติจากการจับเวลา **");
				    }
				    case FlintToll:
				    {
				    	format(szTollsUnlocked, 100, "** HQ Announcement: โทลล์เวย์ The Flint ได้รับการปลดล็อคโดยอัตโนมัติจากการจับเวลา **");
				    }
				    case LVToll:
				    {
				    	format(szTollsUnlocked, 100, "** HQ Announcement: โทลล์เวย์ The Las Venturas ได้รับการปลดล็อคโดยอัตโนมัติจากการจับเวลา **");
				    }
				}
				SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, szTollsUnlocked);
			}

			if(playerData[playerid][pMoney] >= TollCost)
		    {
				new tmp2[127];
				format(tmp2, sizeof(tmp2), "~y~Expressway~n~~r~-%s", FormatMoney(TollCost));
				GameTextForPlayer(playerid, tmp2, 3000, 1);

				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s หยิบเงินออกมาและ จ่ายค่าผ่านทางเป็นจำนวนเงิน '%s'", GetPlayerNameEx(playerid), FormatMoney(TollCost));
				GivePlayerMoneyEx(playerid, -TollCost);
			}
			else return ErrorMsg(playerid, "คุณมีเงินไม่เพียงพอที่จะจ่ายให้คนเฝ้าด่าน");
		}
		Toll_OpenToll(L_i_TollID, doorid, playerid);
	}
	return 1;
}

Toll_CloseTollID(playerid, TollID)
{
	if(TollID == RichmanToll)
	{
		if(L_a_TollEnter[playerid] == 1)
		{
            SetDynamicObjectRot(L_a_TollObject[1], 0.000000, -90.000000, 23.81982421875);
            L_a_Pickup[1] = CreateDynamicPickup(1239, 14, 623.9500, -1183.9774, 19.2260, -1); //  Richman 1
		}
		else if(L_a_TollEnter[playerid] == 2)
		{
		    SetDynamicObjectRot(L_a_TollObject[0], 0.000000, -90.000000, 214.37744140625);
			L_a_Pickup[0] = CreateDynamicPickup(1239, 14, 607.9684, -1194.2866, 19.0043, -1); // Richman 2
		}
	}

	else if(TollID == FlintToll)
	{
		if(L_a_TollEnter[playerid] == 1)
		{
		    SetDynamicObjectRot(L_a_TollObject[2], 0.000000, -90.000000, 270.67565917969);
		    L_a_Pickup[2] = CreateDynamicPickup(1239, 14, 39.7039, -1522.9891, 5.1995, -1); // Flint 1
		}
		else if(L_a_TollEnter[playerid] == 2)
		{
		    SetDynamicObjectRot(L_a_TollObject[3], 0.000000, -90.000000, 87.337799072266);
		    L_a_Pickup[3] = CreateDynamicPickup(1239, 14, 62.7378, -1539.9891, 5.0639, -1); // Flint 2
		}
	}

	else if(TollID == LVToll)
	{
		if(L_a_TollEnter[playerid] == 1)
		{
		    SetDynamicObjectRot(L_a_TollObject[4], 0.000000, -90.000000, 348.10229492188);
		    L_a_Pickup[4] = CreateDynamicPickup(1239, 14, 1778.9886, 702.6728, 15.2574, -1); // LV 2
		}
		else if(L_a_TollEnter[playerid] == 2)
		{
		    SetDynamicObjectRot(L_a_TollObject[5], 0.000000, -90.000000, 169.43664550781);
		    L_a_Pickup[5] = CreateDynamicPickup(1239, 14, 1795.9447, 704.2550, 15.0006, -1); // LV 1
		}
	}
	L_a_TollEnter[playerid] = 0;
	L_a_TollID[playerid] = INVALID_TOLL_ID;
}




Toll_OpenToll(TollID, doorid, playerid)
{
	if(TollID == RichmanToll)
	{
	    if(doorid == 1)// Richman 1 Object [0] Pickup [0] Door 1
	    {
			L_a_TollID[playerid] = RichmanToll;
			L_a_TollTime[playerid] = (gettime() + 6);
			L_a_TollEnter[playerid] = doorid;

	        SetDynamicObjectRot(L_a_TollObject[1], 0.000000, 0.000000, 23.81982421875);

	        DestroyDynamicPickup(L_a_Pickup[1]); //  Richman 1

		    L_a_Pickup[1] = 0;
	    }
	    else
	    {
			L_a_TollID[playerid] = RichmanToll;
			L_a_TollTime[playerid] = (gettime() + 6);
			L_a_TollEnter[playerid] = doorid;

		    SetDynamicObjectRot(L_a_TollObject[0], 0.000000, 0.000000, 214.37744140625);

	        DestroyDynamicPickup(L_a_Pickup[0]); //  Richman 2

		    L_a_Pickup[0] = 0;
	    }
	}

	else if(TollID == FlintToll)
	{
	    if(doorid == 1) // Flint 1 Object [2] Pickup [2] Door 1
	    {
			L_a_TollID[playerid] = FlintToll;
			L_a_TollTime[playerid] = (gettime() + 6);
			L_a_TollEnter[playerid] = doorid;

	        SetDynamicObjectRot(L_a_TollObject[2], 0.000000, 0.000000, 270.67565917969);

	        DestroyDynamicPickup(L_a_Pickup[2]); // Flint 1

		    L_a_Pickup[2] = 0;
	    }
	    else
	    {
			L_a_TollID[playerid] = FlintToll;
			L_a_TollTime[playerid] = (gettime() + 6);
			L_a_TollEnter[playerid] = doorid;

		    SetDynamicObjectRot(L_a_TollObject[3], 0.000000, 0.000000, 87.337799072266);

	        DestroyDynamicPickup(L_a_Pickup[3]); // Flint 2

		    L_a_Pickup[3] = 0;
	    }
	}

	else if(TollID == LVToll)
	{
	    if(doorid == 1) // LV 1 Object [4] Pickup [4] Door 1
	    {
			L_a_TollID[playerid] = LVToll;
			L_a_TollTime[playerid] = (gettime() + 6);
			L_a_TollEnter[playerid] = doorid;

			SetDynamicObjectRot(L_a_TollObject[4], 0.000000, 0.000000, 348.10229492188);

	        DestroyDynamicPickup(L_a_Pickup[4]); // LV 2

		    L_a_Pickup[4] = 0;
	    }
	    else
	    {
			L_a_TollID[playerid] = LVToll;
			L_a_TollTime[playerid] = (gettime() + 6);
			L_a_TollEnter[playerid] = doorid;

	        SetDynamicObjectRot(L_a_TollObject[5], 0.000000, 0.000000, 169.43664550781);

	        DestroyDynamicPickup(L_a_Pickup[5]); // LV 1

		    L_a_Pickup[5] = 0;
	    }
	}
}

Toll_TimePassedCivil(TollID, playerid) // People have to wait <TollDelayCivilian> seconds between every /opentoll on the same toll
{
	new L_i_tick = gettime();
	if(!L_a_Pickup[TollID*2])
	    return 0;

	if(aTolls[TollID][E_tAllowReq] > L_i_tick && aTolls[TollID][E_tAllowReq] != 0)
	{
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "- คุณไม่สามารถจ่ายค่าผ่านทางได้ในขณะนี้ คุณจำเป็นจะต้องรออีก '%d' วินาที", TollDelayCivilian);
		return 1;
	}
	aTolls[TollID][E_tAllowReq] = (L_i_tick + TollDelayCivilian);
	return 1;
}



hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_CROUCH && IsPlayerInAnyVehicle(playerid))
	{
		new L_i_TollID, doorid;

		if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 623.9500, -1183.9774, 19.2260)) // Richman 2
		{
			L_i_TollID = RichmanToll;
			doorid = 2;
		}
		if(IsPlayerInRangeOfPoint(playerid, 10.0, 607.9684, -1194.2866, 19.0043)) // Richman 1
		{
			L_i_TollID = RichmanToll;
			doorid = 1;
		}

		if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 39.7039, -1522.9891, 5.1995)) // Flint tolls
		{
			L_i_TollID = FlintToll;
			doorid = 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 10.0, 62.7378, -1539.9891, 5.0639))
		{
			L_i_TollID = FlintToll;
			doorid = 2;
		}

		if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 1795.9447, 704.2550, 15.0006)) // LV tolls
		{
			L_i_TollID = LVToll;
			doorid = 2;
		}
		if(IsPlayerInRangeOfPoint(playerid, 10.0, 1778.9886, 702.6728, 15.2574))
		{
			L_i_TollID = LVToll;
			doorid = 1;
		}

		if(!doorid)
			return 1;

		if(!Toll_TimePassedCivil(L_i_TollID, playerid))
			return 1;

		if (!Inventory_HasItem(playerid, "DrivingLicense"))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Expressway]: คุณจำเป็นต้องใช้ใบขับขี่ ในการประกอบการจ่ายค่าผ่านทาง");


		if(!playerData[playerid][pOnDuty])
		{
			if(aTolls[L_i_TollID][E_tLocked] && aTolls[L_i_TollID][E_tTimer] > gettime()) // If it's locked
			{
				SendClientMessageEx(playerid, COLOR_LIGHTRED, "- ด่านนั้นไม่สามารถเปิดได้ในขณะนี้ กรุณากลับมาในภายหลัง...");
				return 1;
			}
			else if(aTolls[L_i_TollID][E_tLocked]) // If it's time to be unlocked
			{
				aTolls[L_i_TollID][E_tLocked] = 0;
				new szTollsUnlocked[100];
				switch(L_i_TollID)
				{
					case RichmanToll:
					{
						format(szTollsUnlocked, 100, "** HQ Announcement: โทลล์เวย์ The Richman ได้รับการปลดล็อคโดยอัตโนมัติจากการจับเวลา **");
					}
					case FlintToll:
					{
						format(szTollsUnlocked, 100, "** HQ Announcement: โทลล์เวย์ The Flint ได้รับการปลดล็อคโดยอัตโนมัติจากการจับเวลา **");
					}
					case LVToll:
					{
						format(szTollsUnlocked, 100, "** HQ Announcement: โทลล์เวย์ The Las Venturas ได้รับการปลดล็อคโดยอัตโนมัติจากการจับเวลา **");
					}
				}
				SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, szTollsUnlocked);
			}

			if(playerData[playerid][pMoney] >= TollCost)
			{
				new tmp2[127];
				format(tmp2, sizeof(tmp2), "~y~Expressway~n~~r~-%s", FormatMoney(TollCost));
				GameTextForPlayer(playerid, tmp2, 3000, 1);

				SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s หยิบเงินออกมาและ จ่ายค่าผ่านทางเป็นจำนวนเงิน '%s'", GetPlayerNameEx(playerid), FormatMoney(TollCost));
				GivePlayerMoneyEx(playerid, -TollCost);
			}
			else return ErrorMsg(playerid, "คุณมีเงินไม่เพียงพอที่จะจ่ายให้คนเฝ้าด่าน");
		}
		Toll_OpenToll(L_i_TollID, doorid, playerid);
	}
	return 1;
}
/*

Toll_CloseToll(TollID)
{
	if(TollID == RichmanToll)
	{
        SetDynamicObjectRot(L_a_TollObject[1], 0.000000, -90.000000, 23.81982421875);
	    SetDynamicObjectRot(L_a_TollObject[0], 0.000000, -90.000000, 214.37744140625);


		L_a_Pickup[1] = CreateDynamicPickup(1239, 14, 623.9500, -1183.9774, 19.2260, -1); //  Richman 1
		L_a_Pickup[0] = CreateDynamicPickup(1239, 14, 607.9684, -1194.2866, 19.0043, -1); // Richman 2
	}

	else if(TollID == FlintToll)
	{
	    SetDynamicObjectRot(L_a_TollObject[2], 0.000000, -90.000000, 270.67565917969);
	    SetDynamicObjectRot(L_a_TollObject[3], 0.000000, -90.000000, 87.337799072266);


		L_a_Pickup[2] = CreateDynamicPickup(1239, 14, 39.7039, -1522.9891, 5.1995, -1); // Flint 1
		L_a_Pickup[3] = CreateDynamicPickup(1239, 14, 62.7378, -1539.9891, 5.0639, -1); // Flint 2
	}

	else if(TollID == LVToll)
	{
	    SetDynamicObjectRot(L_a_TollObject[4], 0.000000, -90.000000, 348.10229492188);
	    SetDynamicObjectRot(L_a_TollObject[5], 0.000000, -90.000000, 169.43664550781);


		L_a_Pickup[5] = CreateDynamicPickup(1239, 14, 1795.9447, 704.2550, 15.0006, -1); // LV 2
		L_a_Pickup[4] = CreateDynamicPickup(1239, 14, 1778.9886, 702.6728, 15.2574, -1); // LV 1
	}
	return 1;
}

Toll_TimePassedCops(playerid) // Cops have to wait for <TollDelayCop> seconds between every /toll (Global)
{
	new L_i_tick = gettime();
	if(L_a_RequestAllowedCop > L_i_tick && L_a_RequestAllowedCop != 0)
	{
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "- คุณไม่สามารถจ่ายค่าผ่านทางได้ในขณะนี้ คุณจะเป็นจะต้องรออีก '%d' วินาที", TollDelayCop);
		return 0;
	}
	L_a_RequestAllowedCop = (L_i_tick + TollDelayCop);
	return 1;
}

CMD:toll(playerid, params[]) {


	new
	    L_sz_Input[24];

	if (GetFactionType(playerid) != FACTION_POLICE)
		return 1;

	if(!Toll_TimePassedCops(playerid))
	    return 1;

	if (sscanf(params, "s[24]", L_sz_Input))
 	{
	 	SendClientMessage(playerid, COLOR_LIGHTRED, "การใช้งาน : {ffffff}/toll [รายการ]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[รายการ] :{FFFFFF} emergency/release, flint, richman, lv");
		return 1;
	}

	if(!Toll_TimePassedCops(playerid))
	    return 1;

	if (!strcmp(L_sz_Input, "emergency", true))
	{
	    aTolls[FlintToll][E_tLocked] = 1;
	    aTolls[RichmanToll][E_tLocked] = 1;
	    aTolls[LVToll][E_tLocked] = 1;

	    Toll_CloseToll(FlintToll);
	    Toll_CloseToll(RichmanToll);
	    Toll_CloseToll(LVToll);

	    new L_i_Time = (gettime() + TollTimerEmergency);
	    aTolls[FlintToll][E_tTimer] = L_i_Time;
	    aTolls[RichmanToll][E_tTimer] = L_i_Time;
	    aTolls[LVToll][E_tTimer] = L_i_Time;

	    SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "** HQ Announcement: บูธค่าผ่านทางทั้งหมดถูกล็อคโดย %s %s (%s)! **", Faction_GetRank(playerid), GetPlayerNameEx(playerid), GetInitials(Faction_GetName(playerid)));
	}
	else if (!strcmp(L_sz_Input, "release", true))
	{
	    aTolls[FlintToll][E_tLocked] = 0;
	    aTolls[RichmanToll][E_tLocked] = 0;
	    aTolls[LVToll][E_tLocked] = 0;

	    SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "** HQ Announcement: บูธค่าผ่านทางทั้งหมดถูกปลดล็อคโดย %s %s (%s)! **", Faction_GetRank(playerid), GetPlayerNameEx(playerid), GetInitials(Faction_GetName(playerid)));
	}

	else if (!strcmp(L_sz_Input, "flint", true))
	{
	    if(aTolls[FlintToll][E_tLocked] == 0)
	    {
	        aTolls[FlintToll][E_tLocked] = 1;
	        aTolls[FlintToll][E_tTimer] = (gettime() + TollTimer);
	        Toll_CloseToll(FlintToll);
		    SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "** HQ Announcement: บูธค่าผ่านทางที่ Flint County ถูกล็อคโดย %s %s (%s) **", Faction_GetRank(playerid), GetPlayerNameEx(playerid), GetInitials(Faction_GetName(playerid)));
		}
		else
		{
		    aTolls[FlintToll][E_tLocked] = 0;
		    SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "** HQ Announcement: บูธค่าผ่านทางที่ Flint County ถูกปลดล็อคโดย %s %s (%s) **", Faction_GetRank(playerid), GetPlayerNameEx(playerid), GetInitials(Faction_GetName(playerid)));
		}
	}

	else if (!strcmp(L_sz_Input, "richman", true))
	{
	    if(aTolls[RichmanToll][E_tLocked] == 0)
	    {
	        aTolls[RichmanToll][E_tLocked] = 1;
	        aTolls[RichmanToll][E_tTimer] = (gettime() + TollTimer);
	        Toll_CloseToll(RichmanToll);
		    SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "** HQ Announcement: บูธค่าผ่านทางที่ Richman ถูกล็อคโดย %s %s (%s). **", Faction_GetRank(playerid), GetPlayerNameEx(playerid), GetInitials(Faction_GetName(playerid)));
	    }
	    else
	    {
	        aTolls[RichmanToll][E_tLocked] = 0;
		    SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "** HQ Announcement: บูธค่าผ่านทางที่ Richman ถูกปลดล็อคโดย %s %s (%s). **", Faction_GetRank(playerid), GetPlayerNameEx(playerid), GetInitials(Faction_GetName(playerid)));
	    }
	}

	else if (!strcmp(L_sz_Input, "lv", true))
	{
	    if(aTolls[LVToll][E_tLocked] == 0)
	    {
	        aTolls[LVToll][E_tLocked] = 1;
	        aTolls[LVToll][E_tTimer] = (gettime() + TollTimer);
	        Toll_CloseToll(LVToll);
		    SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "** HQ Announcement: บูธค่าผ่านทางที่ Las Venturas ถูกล็อคโดย %s %s (%s). **", Faction_GetRank(playerid), GetPlayerNameEx(playerid), GetInitials(Faction_GetName(playerid)));
	    }
	    else
	    {
	        aTolls[LVToll][E_tLocked] = 0;
		    SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "** HQ Announcement: บูธค่าผ่านทางที่ Las Venturas ถูกปลดล็อคโดย %s %s (%s). **", Faction_GetRank(playerid), GetPlayerNameEx(playerid), GetInitials(Faction_GetName(playerid)));
	    }
	}
	return 1;
}
*/
stock GetInitials(const string[])
{
	new
	    ret[32],
		index = 0;

	for (new i = 0, l = strlen(string); i != l; i ++)
	{
	    if (('A' <= string[i] <= 'Z') && (i == 0 || string[i - 1] == ' '))
			ret[index++] = string[i];
	}
	return ret;
}
