#include <YSI_Coding\y_hooks>
/*
hook OnGameModeInit()
{
	CreateDynamicObject(14668,1241.97753906,316.33203125,-12.74218750,0.00000000,0.00000000,155.50048828); //object(711_c) (1)
	CreateDynamicObject(16500,1250.81274414,320.83963013,-10.74797821,0.00000000,0.00000000,155.54028320); //object(cn2_savgardr1_) (1)
	CreateDynamicObject(16500,1239.35351562,326.01269531,-10.74797821,0.00000000,0.00000000,335.35217285); //object(cn2_savgardr1_) (2)
	CreateDynamicObject(2948,1247.15527344,325.59375000,-12.74218750,0.00000000,0.00000000,244.99511719); //object(cr_door_02) (1)
	CreateDynamicObject(2948,1245.40307617,326.37210083,-12.74218750,0.00000000,0.00000000,66.34619141); //object(cr_door_02) (5)
	CreateDynamicObject(2948,1247.12719727,325.60192871,-12.74218750,0.00000000,0.00000000,66.09619141); //object(cr_door_02) (7)
	CreateDynamicObject(2948,1245.40234375,326.37207031,-12.74218750,0.00000000,0.00000000,245.70690918); //object(cr_door_02) (9)
	CreateDynamicObject(16500,1252.00988770,322.11306763,-10.74797821,0.00000000,0.00000000,65.97290039); //object(cn2_savgardr1_) (4)
	CreateDynamicObject(16500,1239.74902344,327.75781250,-10.74797821,0.00000000,0.00000000,65.97290039); //object(cn2_savgardr1_) (5)
	CreateDynamicObject(16500,1235.33691406,329.73535156,-10.74797821,0.00000000,0.00000000,65.97290039); //object(cn2_savgardr1_) (6)
	CreateDynamicObject(16500,1240.55053711,322.84387207,-10.74797821,0.00000000,0.00000000,65.97290039); //object(cn2_savgardr1_) (10)
	CreateDynamicObject(16500,1247.58593750,319.62402344,-10.74797821,0.00000000,0.00000000,65.97290039); //object(cn2_savgardr1_) (11)
	CreateDynamicObject(16500,1256.47546387,320.10949707,-10.74797821,0.00000000,0.00000000,65.97290039); //object(cn2_savgardr1_) (4)
	CreateDynamicObject(16500,1248.91369629,316.69903564,-10.77296638,0.00000000,0.00000000,334.99853516); //object(cn2_savgardr1_) (1)
	CreateDynamicObject(1523,1247.88476562,314.44531250,-12.74218750,0.00000000,0.00000000,244.41835022); //object(gen_doorext10) (1)
	CreateDynamicObject(16500,1246.14550781,310.84179688,-10.77296638,0.00000000,0.00000000,334.98962402); //object(cn2_savgardr1_) (1)
	CreateDynamicObject(16500,1252.14880371,317.80108643,-10.77296638,0.00000000,0.00000000,245.26428223); //object(cn2_savgardr1_) (1)
	CreateDynamicObject(1523,1254.36462402,316.69268799,-12.74218750,0.00000000,0.00000000,336.14318848); //object(gen_doorext10) (3)
	CreateDynamicObject(1649,1248.17285156,314.98782349,-8.57648373,0.00000000,0.00000000,244.40539551); //object(wglasssmash) (6)
	CreateDynamicObject(1649,1248.17285156,314.98730469,-8.60148335,0.00000000,0.00000000,64.36163330); //object(wglasssmash) (6)
	CreateDynamicObject(1649,1246.27282715,311.03753662,-8.55148411,0.00000000,0.00000000,64.36163330); //object(wglasssmash) (6)
	CreateDynamicObject(1649,1246.30090332,311.09234619,-8.55148411,0.00000000,0.00000000,244.40185547); //object(wglasssmash) (6)
	CreateDynamicObject(1649,1254.16479492,316.79168701,-8.57644939,0.00000000,0.00000000,335.97521973); //object(wglasssmash) (5)
	CreateDynamicObject(1649,1254.16406250,316.79101562,-8.57644939,0.00000000,0.00000000,155.72509766); //object(wglasssmash) (7)
	CreateDynamicObject(16500,1247.32373047,307.67590332,-10.77296638,0.00000000,0.00000000,245.75933838); //object(cn2_savgardr1_) (1)
	CreateDynamicObject(16500,1251.80969238,305.65090942,-10.77296638,0.00000000,0.00000000,245.75939941); //object(cn2_savgardr1_) (1)
	CreateDynamicObject(16500,1243.76367188,311.42089844,-10.77296638,0.00000000,0.00000000,245.75866699); //object(cn2_savgardr1_) (1)
	CreateDynamicObject(1523,1241.49548340,312.37069702,-12.74218750,0.00000000,0.00000000,244.42028809); //object(gen_doorext10) (1)
	CreateDynamicObject(1523,1240.27075195,309.60211182,-12.74218750,0.00000000,0.00000000,65.72796631); //object(gen_doorext10) (1)
	CreateDynamicObject(16500,1247.50244141,307.82385254,-10.77296638,0.00000000,0.00000000,65.71850586); //object(cn2_savgardr1_) (1)
	CreateDynamicObject(16500,1252.05346680,305.75854492,-10.77296638,0.00000000,0.00000000,65.71472168); //object(cn2_savgardr1_) (1)
	CreateDynamicObject(1649,1240.60668945,310.42483521,-8.60148335,0.00000000,0.00000000,64.60791016); //object(wglasssmash) (6)
	CreateDynamicObject(1649,1240.60644531,310.42480469,-8.60148335,0.00000000,0.00000000,244.06481934); //object(wglasssmash) (6)
	CreateDynamicObject(16500,1239.35998535,326.08981323,-10.74797821,0.00000000,0.00000000,155.89245605); //object(cn2_savgardr1_) (2)
	CreateDynamicObject(16500,1239.72460938,327.66137695,-10.74797821,0.00000000,0.00000000,245.43292236); //object(cn2_savgardr1_) (5)
	CreateDynamicObject(16500,1235.31457520,329.69033813,-10.74797821,0.00000000,0.00000000,245.43292236); //object(cn2_savgardr1_) (6)
	CreateDynamicObject(1533,1234.31518555,309.46380615,-12.74218750,0.00000000,0.00000000,155.50512695); //object(gen_doorext12) (1)
	CreateDynamicObject(1533,1232.99584961,310.07183838,-12.74218750,0.00000000,0.00000000,155.50048828); //object(gen_doorext12) (2)
	CreateDynamicObject(16500,1238.01562500,310.55383301,-10.77296638,0.00000000,0.00000000,245.75866699); //object(cn2_savgardr1_) (1)
	CreateDynamicObject(16500,1234.83642578,309.34338379,-10.77296638,0.00000000,0.00000000,335.48840332); //object(cn2_savgardr1_) (1)
	CreateDynamicObject(1649,1238.71875000,306.44982910,-8.60148335,0.00000000,0.00000000,64.60510254); //object(wglasssmash) (6)
	CreateDynamicObject(1649,1238.67871094,306.48254395,-8.60148335,0.00000000,0.00000000,244.06127930); //object(wglasssmash) (6)
	CreateDynamicObject(16500,1238.48388672,305.86618042,-12.24794388,0.00000000,0.00000000,335.48400879); //object(cn2_savgardr1_) (1)
	CreateDynamicObject(1523,1239.58984375,308.04516602,-12.74218750,0.00000000,0.00000000,65.72570801); //object(gen_doorext10) (1)
	CreateDynamicObject(16500,1231.15173340,310.99179077,-10.77296638,0.00000000,0.00000000,156.02392578); //object(cn2_savgardr1_) (1)
	CreateDynamicObject(16500,1233.19140625,315.54788208,-10.77296638,0.00000000,0.00000000,156.02233887); //object(cn2_savgardr1_) (1)
	CreateDynamicObject(1523,1234.16479492,317.82318115,-12.74218750,0.00000000,0.00000000,64.95855713); //object(gen_doorext10) (1)
	CreateDynamicObject(1523,1235.37109375,320.58068848,-12.74218750,0.00000000,0.00000000,245.49682617); //object(gen_doorext10) (1)
	CreateDynamicObject(16500,1236.36914062,322.84472656,-10.77296638,0.00000000,0.00000000,156.02233887); //object(cn2_savgardr1_) (1)
	CreateDynamicObject(16500,1238.22131348,327.00827026 ,-10.77296638,0.00000000,0.00000000,156.02233887); //object(cn2_savgardr1_) (1)
	CreateDynamicObject(1649,1234.76708984,319.18820190,-8.59538078,0.00000000,0.00000000,65.00463867); //object(wglasssmash) (13)
	CreateDynamicObject(1649,1236.58801270,323.16397095,-8.54538155,0.00000000,0.00000000,65.98559570); //object(wglasssmash) (14)
	CreateDynamicObject(1649,1232.92041016,315.24493408,-8.54538155,0.00000000,0.00000000,65.00463867); //object(wglasssmash) (15)
	CreateDynamicObject(1649,1234.76660156,319.18750000,-8.59538078,0.00000000,0.00000000,244.96058655); //object(wglasssmash) (16)
	CreateDynamicObject(1649,1232.97607422,315.24398804,-8.54538155,0.00000000,0.00000000,246.19165039); //object(wglasssmash) (17)
	CreateDynamicObject(1649,1236.59753418,323.12588501,-8.59538078,0.00000000,0.00000000,245.20666504); //object(wglasssmash) (18)
	CreateDynamicObject(3395,1232.95812988,325.62490845,-12.74218750,0.00000000,0.00000000,156.00500488); //object(a51_sdsk_3_) (1)
	CreateDynamicObject(3383,1229.17004395,312.88650513,-12.74218750,0.00000000,0.00000000,335.68017578); //object(a51_labtable1_) (1)
	CreateDynamicObject(3383,1235.95825195,327.98693848,-12.74218750,0.00000000,0.00000000,155.96655273); //object(a51_labtable1_) (2)
	CreateDynamicObject(1997,1236.24475098,309.35018921,-12.74218750,0.00000000,0.00000000,65.77496338); //object(hos_trolley) (1)
	CreateDynamicObject(1997,1236.72546387,310.39508057,-12.74218750,0.00000000,0.00000000,65.76965332); //object(hos_trolley) (2)
	CreateDynamicObject(3383,1229.52941895,317.27880859,-12.74218750,0.00000000,0.00000000,245.69653320); //object(a51_labtable1_) (3)
	CreateDynamicObject(2008,1241.20190430,324.26699829,-12.74218750,0.00000000,0.00000000,336.69519043); //object(officedesk1) (1)
	CreateDynamicObject(1738,1240.81738281,326.84960938,-12.08755684,0.00000000,0.00000000,335.69274902); //object(cj_radiator_old) (1)
	CreateDynamicObject(2146,1234.80371094,324.82031250,-12.25663662,0.00000000,0.00000000,336.17614746); //object(cj_trolly1) (1)
	CreateDynamicObject(1997,1232.04016113,316.25039673,-12.74218750,0.00000000,0.00000000,175.09460449); //object(hos_trolley) (4)
	CreateDynamicObject(1997,1248.82653809,304.07025146,-12.74218750,0.00000000,0.00000000,155.49963379); //object(hos_trolley) (5)
	CreateDynamicObject(1997,1246.90649414,304.92480469,-12.74218750,0.00000000,0.00000000,155.49499512); //object(hos_trolley) (6)
	CreateDynamicObject(1997,1244.87304688,305.83728027,-12.74218750,0.00000000,0.00000000,155.49499512); //object(hos_trolley) (7)
	CreateDynamicObject(1997,1244.81933594,309.47732544,-12.74218750,0.00000000,0.00000000,335.24963379); //object(hos_trolley) (8)
	CreateDynamicObject(2162,1253.01159668,310.06793213,-11.24219131,0.00000000,0.00000000,244.41833496); //object(med_office_unit_1) (1)
	CreateDynamicObject(2008,1251.26916504,309.88665771,-12.74218750,0.00000000,0.00000000,66.50244141); //object(officedesk1) (2)
	CreateDynamicObject(1726,1248.90039062,319.74414062,-12.74218750,0.00000000,0.00000000,156.54968262); //object(mrk_seating2) (1)
	CreateDynamicObject(2596,1249.45507812,323.78613281,-10.29656029,0.00000000,0.00000000,338.39538574); //object(cj_sex_tv) (1)
	CreateDynamicObject(1715,1241.55798340,322.76785278,-12.74218750,0.00000000,0.00000000,156.70996094); //object(kb_swivelchair2) (1)
	CreateDynamicObject(1720,1250.06713867,310.47796631,-12.74218750,0.00000000,0.00000000,65.82000732); //object(rest_chair) (4)
	CreateDynamicObject(2007,1239.17919922,324.16729736,-12.74218750,0.00000000,0.00000000,65.43457031); //object(filing_cab_nu01) (1)
	CreateDynamicObject(2167,1251.28076172,321.43664551,-12.74218750,0.00000000,0.00000000,64.69995117); //object(med_office_unit_7) (1)
	CreateDynamicObject(2167,1250.51171875,319.78027344,-12.74218750,0.00000000,0.00000000,64.69299316); //object(med_office_unit_7) (2)
	CreateDynamicObject(2690,1239.27392578,327.61547852,-11.28874779,0.00000000,0.00000000,0.00000000); //object(cj_fire_ext) (1)
	CreateDynamicObject(1808,1246.33703613,320.47070312,-12.74218750,0.00000000,0.00000000,155.67529297); //object(cj_watercooler2) (1)
	CreateDynamicObject(1714,1252.76184082,310.21145630,-12.74218750,0.00000000,0.00000000,246.90087891); //object(kb_swivelchair1) (1)
	CreateDynamicObject(1720,1250.44445801,311.32257080,-12.74218750,0.00000000,0.00000000,65.81909180); //object(rest_chair) (4)
	CreateDynamicObject(2146,1251.83618164,317.28320312,-12.25663662,0.00000000,0.00000000,245.00634766); //object(cj_trolly1) (1)
	CreateDynamicObject(2167,1245.82531738,309.92208862,-12.74218750,0.00000000,0.00000000,64.69299316); //object(med_office_unit_7) (2)
	CreateDynamicObject(2007,1251.34545898,307.54479980,-12.74218750,0.00000000,0.00000000,246.36035156); //object(filing_cab_nu01) (2)
	CreateDynamicObject(2000,1250.98632812,306.63806152,-12.74218750,0.00000000,0.00000000,246.11035156); //object(filing_cab_nu) (1)
	CreateDynamicObject(1727,1236.46252441,321.43969727,-12.74218750,0.00000000,0.00000000,65.72991943); //object(mrk_seating2b) (1)
	CreateDynamicObject(1726,1246.81396484,319.24847412,-12.74218750,0.00000000,0.00000000,335.78393555); //object(mrk_seating2) (1)
	CreateDynamicObject(1726,1243.85375977,312.12213135,-12.74218750,0.00000000,0.00000000,156.32092285); //object(mrk_seating2) (1)
	CreateDynamicObject(2855,1246.18347168,317.07830811,-12.66718102,0.00000000,0.00000000,0.00000000); //object(gb_bedmags05) (1)
	CreateDynamicObject(2855,1246.80883789,316.68179321,-12.21718025,0.00000000,0.00000000,322.97521973); //object(gb_bedmags05) (3)
	CreateDynamicObject(2855,1248.94165039,321.79312134,-12.21718025,0.00000000,0.00000000,359.75000000); //object(gb_bedmags05) (4)
	CreateDynamicObject(1738,1246.50134277,312.30136108,-12.08755684,0.00000000,0.00000000,244.38343811); //object(cj_radiator_old) (1)
	CreateDynamicObject(1738,1253.85607910,312.57608032,-12.08755684,0.00000000,0.00000000,244.37988281); //object(cj_radiator_old) (1)
	CreateDynamicObject(2596,1247.68322754,315.02133179,-10.29656029,0.00000000,0.00000000,230.45617676); //object(cj_sex_tv) (1)
	CreateDynamicObject(2596,1242.10974121,321.77346802,-10.29656029,0.00000000,0.00000000,359.31457520); //object(cj_sex_tv) (1)
	CreateDynamicObject(2315,1247.90136719,322.11004639,-12.74218750,0.00000000,0.00000000,335.71020508); //object(cj_tv_table4) (1)
	CreateDynamicObject(2315,1246.10485840,317.15661621,-12.74218750,0.00000000,0.00000000,335.70922852); //object(cj_tv_table4) (2)
	CreateDynamicObject(2380,1254.35302734,320.86846924,-11.49442196,0.00000000,0.00000000,335.16516113); //object(cj_suits) (1)
	CreateDynamicObject(2816,1246.20117188,317.14129639,-12.24655533,0.00000000,0.00000000,0.00000000); //object(gb_bedmags01) (1)
	CreateDynamicObject(2852,1247.99145508,322.01168823,-12.24655533,0.00000000,0.00000000,0.00000000); //object(gb_bedmags02) (2)

	// นอนเตียง (LS)
	CreateDynamicPickup(1240, 23, 1249.2341,303.0181,-11.7422);
	CreateDynamic3DTextLabel("{FFFFFF}[{FBEC03}นอนเตียง{FFFFFF}]\n{FFFFFF}กด 'N' เพื่อนอนเตียง\n{FBA103}ค่านอนเตียง : {FBEC03}$700", COLOR_GREEN, 1249.2341,303.0181,-11.7422, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

	CreateDynamicPickup(1240, 23, 1247.4054,303.8461,-11.7422);
	CreateDynamic3DTextLabel("{FFFFFF}[{FBEC03}นอนเตียง{FFFFFF}]\n{FFFFFF}กด 'N' เพื่อนอนเตียง\n{FBA103}ค่านอนเตียง : {FBEC03}$700", COLOR_GREEN, 1247.4054,303.8461,-11.7422, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

	CreateDynamicPickup(1240, 23, 1245.2954,304.8123,-11.7422);
	CreateDynamic3DTextLabel("{FFFFFF}[{FBEC03}นอนเตียง{FFFFFF}]\n{FFFFFF}กด 'N' เพื่อนอนเตียง\n{FBA103}ค่านอนเตียง : {FBEC03}$700", COLOR_GREEN, 1245.2954,304.8123,-11.7422, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);

	CreateDynamicPickup(1240, 23, 1244.4445,310.6126,-11.7422);
	CreateDynamic3DTextLabel("{FFFFFF}[{FBEC03}นอนเตียง{FFFFFF}]\n{FFFFFF}กด 'N' เพื่อนอนเตียง\n{FBA103}ค่านอนเตียง : {FBEC03}$700", COLOR_GREEN, 1244.4445,310.6126,-11.7422, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_NO && !IsPlayerInAnyVehicle(playerid))
	{
		// นอนเตียง
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 1249.2341,303.0181,-11.7422))
        {
            new Float:hp;
            GetPlayerHealth(playerid, hp);

            if (hp > 70.0)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "เลือดของคุณต้องน้อยกว่า 70.0 ถึงจะนอนเตียงได้");

            if (BeforeSleep[playerid] == 1)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณอยู่ระหว่างการนอนเตียง!");

			if (GetPlayerMoneyEx(playerid) < 700)
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องมีเงินมากกว่า $700");

            TogglePlayerControllable(playerid, 0);
		    SetPlayerPos(playerid, 1248.8228,304.1441,-11.0043);
		    SetPlayerFacingAngle(playerid, 335.7025);

		    ApplyAnimation(playerid,"BEACH","SitnWait_loop_W",4.1, 0, 1, 1, 1, 1, 1);
		    BeforeSleep[playerid] = 1;

			SendClientMessage(playerid, COLOR_LIGHTRED, "(( คุณได้นอนเตียงพยาบาลแล้ว, กรุณารอสักครู่ ))");
			ApplyAnimation(playerid,"BEACH","SitnWait_loop_W",4.1, 0, 1, 1, 1, 1, 1);

			StartProgress(playerid, 150, 0, INVALID_OBJECT_ID);
        }

        else if (IsPlayerInRangeOfPoint(playerid, 1.0, 1247.4054,303.8461,-11.7422))
        {
            new Float:hp;
            GetPlayerHealth(playerid, hp);

            if (hp > 70.0)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "เลือดของคุณต้องน้อยกว่า 70.0 ถึงจะนอนเตียงได้");

            if (BeforeSleep[playerid] == 1)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณอยู่ระหว่างการนอนเตียง!");

			if (GetPlayerMoneyEx(playerid) < 700)
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องมีเงินมากกว่า $700");

		    TogglePlayerControllable(playerid, 0);
		    SetPlayerPos(playerid, 1246.9203,304.9343,-11.0043);
		    SetPlayerFacingAngle(playerid, 338.6073);

		    ApplyAnimation(playerid,"BEACH","SitnWait_loop_W",4.1, 0, 1, 1, 1, 1, 1);
		    BeforeSleep[playerid] = 1;

            SendClientMessage(playerid, COLOR_LIGHTRED, "(( คุณได้นอนเตียงพยาบาลแล้ว, กรุณารอสักครู่ ))");
            ApplyAnimation(playerid,"BEACH","SitnWait_loop_W",4.1, 0, 1, 1, 1, 1, 1);

            StartProgress(playerid, 150, 0, INVALID_OBJECT_ID);
        }

        else if (IsPlayerInRangeOfPoint(playerid, 1.0, 1245.2954,304.8123,-11.7422))
        {
            new Float:hp;
            GetPlayerHealth(playerid, hp);

            if (hp > 70.0)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "เลือดของคุณต้องน้อยกว่า 70.0 ถึงจะนอนเตียงได้");

            if (BeforeSleep[playerid] == 1)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณอยู่ระหว่างการนอนเตียง!");

			if (GetPlayerMoneyEx(playerid) < 700)
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องมีเงินมากกว่า $700");

		    TogglePlayerControllable(playerid, 0);
		    SetPlayerPos(playerid, 1244.8375,305.8386,-11.0043);
		    SetPlayerFacingAngle(playerid, 333.5522);

		    ApplyAnimation(playerid,"BEACH","SitnWait_loop_W",4.1, 0, 1, 1, 1, 1, 1);
		    BeforeSleep[playerid] = 1;

            SendClientMessage(playerid, COLOR_LIGHTRED, "(( คุณได้นอนเตียงพยาบาลแล้ว, กรุณารอสักครู่ ))");
            ApplyAnimation(playerid,"BEACH","SitnWait_loop_W",4.1, 0, 1, 1, 1, 1, 1);

            StartProgress(playerid, 150, 0, INVALID_OBJECT_ID);
        }

        else if (IsPlayerInRangeOfPoint(playerid, 1.0, 1244.4445,310.6126,-11.7422))
        {
            new Float:hp;
            GetPlayerHealth(playerid, hp);

            if (hp > 70.0)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "เลือดของคุณต้องน้อยกว่า 70.0 ถึงจะนอนเตียงได้");

            if (BeforeSleep[playerid] == 1)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณอยู่ระหว่างการนอนเตียง!");

			if (GetPlayerMoneyEx(playerid) < 700)
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องมีเงินมากกว่า $700");

		    TogglePlayerControllable(playerid, 0);
		    SetPlayerPos(playerid, 1244.8400,309.5306,-11.0043);
		    SetPlayerFacingAngle(playerid, 156.9165);

		    ApplyAnimation(playerid,"BEACH","SitnWait_loop_W",4.1, 0, 1, 1, 1, 1, 1);
		    BeforeSleep[playerid] = 1;

		    SendClientMessage(playerid, COLOR_LIGHTRED, "(( คุณได้นอนเตียงพยาบาลแล้ว, กรุณารอสักครู่ ))");
      		ApplyAnimation(playerid,"BEACH","SitnWait_loop_W",4.1, 0, 1, 1, 1, 1, 1);

		    StartProgress(playerid, 150, 0, INVALID_OBJECT_ID);
        }
	}
	return 1;
}

CMD:hospital_ls(playerid, params[])
{
	if (playerData[playerid][pAdmin] < 1)
	    return ErrorMsg(playerid, "สำหรับผู้ดูแลระบบเท่านั้น!");

	SetPlayerPosExten(playerid, 1242.2330,316.9933,-11.7422);
	SetPlayerFacingAngle(playerid, 334.5364);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SendClientMessage(playerid, COLOR_YELLOW, "คุณได้ทำการวาร์ปมาที่ภายในของโรงพยาบาล Los Santos แล้ว");

	return 1;
}
*/