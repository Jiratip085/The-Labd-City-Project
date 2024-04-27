/*

	+ ระบบแต่งรถ Copy Morgan City
	Cr.เทพเจ้าแห่งการ Copy

*/

#include	<YSI_Coding\y_hooks>

new CashAll_Tune[MAX_PLAYERS], TunePlayer[MAX_PLAYERS], TuneType[MAX_PLAYERS];

#define NUMBER_TYPE_PAINTJOB 	36
enum ENUM_PAINTJOB_MORGAN {
	Morgan_vehID,
	Morgan_pNumber,
	Morgan_pPrice,
	Morgan_pName[ 12 ]
};

enum tpi {
	tID,
	tType,
	bool:tPaintjob,
	PJColor[ 2 ]
};
new TPInfo[ MAX_PLAYERS ][ tpi ];

new
	Morgan_pjInfo[ NUMBER_TYPE_PAINTJOB ][ ENUM_PAINTJOB_MORGAN ] = {
	{ 483, 0, 10000, "Paintjob 1" },
	{ 534, 0, 10000, "Paintjob 1" },
	{ 534, 1, 10000, "Paintjob 2" },
	{ 534, 2, 10000, "Paintjob 3" },
	{ 535, 0, 10000, "Paintjob 1" },
	{ 535, 1, 10000, "Paintjob 2" },
	{ 535, 2, 10000, "Paintjob 3" },
	{ 536, 0, 10000, "Paintjob 1" },
	{ 536, 1, 10000, "Paintjob 2" },
	{ 536, 2, 10000, "Paintjob 3" },
	{ 558, 0, 10000, "Paintjob 1" },
	{ 558, 1, 10000, "Paintjob 2" },
	{ 558, 2, 10000, "Paintjob 3" },
	{ 559, 0, 10000, "Paintjob 1" },
	{ 559, 1, 10000, "Paintjob 2" },
	{ 559, 2, 10000, "Paintjob 3" },
	{ 560, 0, 10000, "Paintjob 1" },
	{ 560, 1, 10000, "Paintjob 2" },
	{ 560, 2, 10000, "Paintjob 3" },
	{ 561, 0, 10000, "Paintjob 1" },
	{ 561, 1, 10000, "Paintjob 2" },
	{ 561, 2, 10000, "Paintjob 3" },
	{ 562, 0, 10000, "Paintjob 1" },
	{ 562, 1, 10000, "Paintjob 2" },
	{ 562, 2, 10000, "Paintjob 3" },
	{ 565, 0, 10000, "Paintjob 1" },
	{ 565, 1, 10000, "Paintjob 2" },
	{ 565, 2, 10000, "Paintjob 3" },
	{ 567, 0, 10000, "Paintjob 1" },
	{ 567, 1, 10000, "Paintjob 2" },
	{ 567, 2, 10000, "Paintjob 3" },
	{ 575, 0, 10000, "Paintjob 1" },
	{ 575, 1, 10000, "Paintjob 2" },
	{ 576, 0, 10000, "Paintjob 1" },
	{ 576, 1, 10000, "Paintjob 2" },
	{ 576, 2, 10000, "Paintjob 3" }
};

enum ENUM_COMPONENTS_INFO {
	cID,
	cName[ 40 ],
	cPrice,
	cType
};
#define MAX_COMPONENTS_MORGAN	194
new
	Morgan_cInfo[ MAX_COMPONENTS_MORGAN ][ ENUM_COMPONENTS_INFO ] = {
	{ 1000, "Pro Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1001, "Win Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1002, "Drag Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1003, "Alpha Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1004, "Champ Scoop Hood", 500, CARMODTYPE_HOOD },
	{ 1005, "Fury Scoop Hood", 500, CARMODTYPE_HOOD },
	{ 1006, "Roof Scoop Roof", 17000, CARMODTYPE_ROOF },
	{ 1007, "Right Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1008, "5x Nitrous", 10000, CARMODTYPE_NITRO },
	{ 1009, "2x Nitrous", 10000, CARMODTYPE_NITRO },
	{ 1010, "10x Nitrous", 10000, CARMODTYPE_NITRO },
	{ 1011, "Race Scoop Hood", 500, CARMODTYPE_HOOD },
	{ 1012, "Worx Scoop Hood", 500, CARMODTYPE_HOOD },
	{ 1013, "Round Fog Lamp", 500, CARMODTYPE_LAMPS },
	{ 1014, "Champ Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1015, "Race Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1016, "Worx Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1017, "Left Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1018, "Upswept Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1019, "Twin Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1020, "Large Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1021, "Medium Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1022, "Small Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1023, "Fury Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1024, "Square Fog Lamp", 500, CARMODTYPE_LAMPS },
	{ 1025, "Offroad Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1026, "Right Alien Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1027, "Left Alien Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1028, "Alien Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1029, "X-Flow Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1030, "Left X-Flow Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1031, "Right X-Flow Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1032, "Alien Roof Vent", 17000, CARMODTYPE_ROOF },
	{ 1033, "X-Flow Roof Vent", 17000, CARMODTYPE_ROOF },
	{ 1034, "Alien Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1035, "X-Flow Roof Vent", 17000, CARMODTYPE_ROOF },
	{ 1036, "Right Alien Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1037, "X-Flow Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1038, "Alien Roof Vent", 17000, CARMODTYPE_ROOF },
	{ 1039, "Left X-Flow Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1040, "Left Alien Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1041, "Right X-Flow Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1042, "Right Chrome Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1043, "Slamin Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1044, "Chrome Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1045, "X-Flow Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1046, "Alien Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1047, "Right Alien Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1048, "Right X-Flow Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1049, "Alien Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1050, "X-Flow Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1051, "Left Alien Sideskirt", 12000, CARMODTYPE_SPOILER },
	{ 1052, "Left X-Flow Sideskirt", 12000, CARMODTYPE_SPOILER },
	{ 1053, "X-Flow Roof", 17000, CARMODTYPE_ROOF },
	{ 1054, "Alien Roof", 17000, CARMODTYPE_ROOF },
	{ 1055, "Alien Roof", 17000, CARMODTYPE_ROOF },
	{ 1056, "Right Alien Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1057, "Right X-Flow Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1058, "Alien Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1059, "X-Flow Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1060, "X-Flow Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1061, "X-Flow Roof", 17000, CARMODTYPE_ROOF },
	{ 1062, "Left Alien Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1063, "Left X-Flow Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1064, "Alien Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1065, "Alien Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1066, "X-Flow Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1067, "Alien Roof", 17000, CARMODTYPE_ROOF },
	{ 1068, "X-Flow Roof", 17000, CARMODTYPE_ROOF },
	{ 1069, "Right Alien Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1070, "Right X-Flow Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1071, "Left Alien Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1072, "Left X-Flow Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1073, "Shadow Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1074, "Mega Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1075, "Rimshine Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1076, "Wires Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1077, "Classic Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1078, "Twist Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1079, "Cutter Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1080, "Switch Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1081, "Grove Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1082, "Import Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1083, "Dollar Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1084, "Trance Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1085, "Atomic Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1086, "Stereo Wheels", 5000, CARMODTYPE_STEREO },
	{ 1087, "Hydraulics", 20000, CARMODTYPE_HYDRAULICS },
	{ 1088, "Alien Roof", 17000, CARMODTYPE_ROOF },
	{ 1089, "X-Flow Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1090, "Right Alien Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1091, "X-Flow Roof", 17000, CARMODTYPE_ROOF },
	{ 1092, "Alien Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1093, "Right X-Flow Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1094, "Left Alien Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1095, "Right X-Flow Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1096, "Ahab Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1097, "Virtual Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1098, "Access Wheels", 12000, CARMODTYPE_WHEELS },
	{ 1099, "Left Chrome Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 150000, "Chrome Grill", 50000, -1 }, // Bullbar
	{ 1101, "Left `Chrome Flames` Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1102, "Left `Chrome Strip` Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1103, "Covertible Roof", 17000, CARMODTYPE_ROOF },
	{ 1104, "Chrome Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1105, "Slamin Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1106, "Right `Chrome Arches`", 15000, CARMODTYPE_SIDESKIRT },
	{ 1107, "Left `Chrome Strip` Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1108, "Right `Chrome Strip` Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1109, "Chrome", 50000, -1 }, // Bullbar
	{ 1110, "Slamin", 50000, -1 }, // Bullbar
	{ 1111, "Little Sign?", 50000, -1 }, // sig
	{ 1112, "Little Sign?", 50000, -1 }, // sig
	{ 1113, "Chrome Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1114, "Slamin Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1115, "Chrome", 50000, -1 }, // Bullbar
	{ 1116, "Slamin", 50000, -1 }, // Bullbar
	{ 1117, "Chrome Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1118, "Right `Chrome Trim` Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1119, "Right `Wheelcovers` Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1120, "Left `Chrome Trim` Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1121, "Left `Wheelcovers` Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1122, "Right `Chrome Flames` Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1123, "Bullbar Chrome Bars", 50000, -1 }, // Bullbar
	{ 1124, "Left `Chrome Arches` Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1125, "Bullbar Chrome Lights", 50000, -1 }, // Bullbar
	{ 1126, "Chrome Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1127, "Slamin Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1128, "Vinyl Hardtop", 17000, CARMODTYPE_ROOF },
	{ 1129, "Chrome Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1130, "Hardtop Roof", 17000, CARMODTYPE_ROOF },
	{ 1131, "Softtop Roof", 17000, CARMODTYPE_ROOF },
	{ 1132, "Slamin Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1133, "Right `Chrome Strip` Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1134, "Right `Chrome Strip` Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1135, "Slamin Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1136, "Chrome Exhaust", 11000, CARMODTYPE_EXHAUST },
	{ 1137, "Left `Chrome Strip` Sideskirt", 15000, CARMODTYPE_SIDESKIRT },
	{ 1138, "Alien Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1139, "X-Flow Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1140, "X-Flow Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1141, "Alien Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1142, "Left Oval Vents", 500, CARMODTYPE_VENT_LEFT },
	{ 1143, "Right Oval Vents", 500, CARMODTYPE_VENT_RIGHT },
	{ 1144, "Left Square Vents", 500, CARMODTYPE_VENT_LEFT },
	{ 1145, "Right Square Vents", 500, CARMODTYPE_VENT_RIGHT },
	{ 1146, "X-Flow Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1147, "Alien Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1148, "X-Flow Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1149, "Alien Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1150, "Alien Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1151, "X-Flow Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1152, "X-Flow Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1153, "Alien Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1154, "Alien Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1155, "Alien Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1156, "X-Flow Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1157, "X-Flow Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1158, "X-Flow Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1159, "Alien Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1160, "Alien Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1161, "X-Flow Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1162, "Alien Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1163, "X-Flow Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1164, "Alien Spoiler", 12000, CARMODTYPE_SPOILER },
	{ 1165, "X-Flow Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1166, "Alien Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1167, "X-Flow Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1168, "Alien Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1169, "Alien Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1170, "X-Flow Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1171, "Alien Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1172, "X-Flow Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1173, "X-Flow Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1174, "Chrome Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1175, "Slamin Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1176, "Chrome Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1177, "Slamin Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1178, "Slamin Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1179, "Chrome Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1180, "Chrome Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1181, "Slamin Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1182, "Chrome Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1183, "Slamin Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1184, "Chrome Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1185, "Slamin Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1186, "Slamin Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1187, "Chrome Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1188, "Slamin Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1189, "Chrome Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1190, "Slamin Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1191, "Chrome Front Bumper", 10000, CARMODTYPE_FRONT_BUMPER },
	{ 1192, "Chrome Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER },
	{ 1193, "Slamin Rear Bumper", 10000, CARMODTYPE_REAR_BUMPER }
};

hook OnPlayerConnect(playerid)
{
    CashAll_Tune[playerid] = 0;
    TunePlayer[playerid] = -1;
	
}

alias:morgan("แต่งรถช่าง")
CMD:morgan(playerid, params[])
{
	if (GetFactionType(playerid) != FACTION_MEC)
	    return ErrorMsg(playerid, "สำหรับช่างซ่อมรถเท่านั้น!");

	return Dialog_Show(playerid, DIALOG_MORGAN_CARTUNE, DIALOG_STYLE_TABLIST, "ลิสต์", "\
	{ffffff}กันชนหน้า\t{28EE05}$10,000\n\
	{ffffff}กันชนท้าย\t{28EE05}$10,000\n\
	{ffffff}Spoiler\t{28EE05}$12,000\n\
 	{ffffff}สเกิร์ตข้าง\t{28EE05}$15,000\n\
 	{ffffff}หลังคา\t{28EE05}$17,000\n\
 	{ffffff}ท่อไอเสีย\t{28EE05}$11,000\n\
 	{ffffff}ไฮดรอลิค\t{28EE05}$20,000\n\
	{ffffff}ไนตรัส\t{28EE05}$10,000\n\
	{ffffff}ล้อรถ\t{28EE05}$12,000\n\
	{ffffff}ลายรถ\t{28EE05}$10,000\n\
 	{28EE05}แต่งและเรียกเก็บเงิน\n\
 	{FC8507}ยกเลิกการแต่ง", "เลือก", "ออก");
}

Dialog:DIALOG_MORGAN_CARTUNE(playerid, response, listitem, inputtext[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if (response)
	{
		TuneType[playerid] = listitem;	
	    switch (listitem)
	    {
	        case 0:
	        {
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
				{
				    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_FRONT_BUMPER )
				    {
				        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
				        {
							format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
							strcat(string2, string);

							format(var, sizeof(var), "MORGANTUNE%d", count);
							SetPVarInt(playerid, var, i);

							count++;
						}
					}
				}

				if (!count)
				    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

				Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

				TPInfo[ playerid ][ tType ] = CARMODTYPE_FRONT_BUMPER;
				TPInfo[ playerid ][ tPaintjob ] = false;
				TuneType[playerid] = listitem;
			}
	        case 1:
	        {
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
				{
				    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_REAR_BUMPER )
				    {
				        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
				        {
							format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
							strcat(string2, string);

							format(var, sizeof(var), "MORGANTUNE%d", count);
							SetPVarInt(playerid, var, i);

							count++;
						}
					}
				}

				if (!count)
				    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

				Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

				TPInfo[ playerid ][ tType ] = CARMODTYPE_REAR_BUMPER;
				TPInfo[ playerid ][ tPaintjob ] = false;
				TuneType[playerid] = listitem;
			}
	        case 2:
	        {
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
				{
				    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_SPOILER )
				    {
				        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
				        {
							format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
							strcat(string2, string);

							format(var, sizeof(var), "MORGANTUNE%d", count);
							SetPVarInt(playerid, var, i);

							count++;
						}
					}
				}

				if (!count)
				    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

				Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

				TPInfo[ playerid ][ tType ] = CARMODTYPE_SPOILER;
				TPInfo[ playerid ][ tPaintjob ] = false;
				TuneType[playerid] = listitem;
			}
	        case 3:
	        {
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
				{
				    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_SIDESKIRT )
				    {
				        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
				        {
							format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
							strcat(string2, string);

							format(var, sizeof(var), "MORGANTUNE%d", count);
							SetPVarInt(playerid, var, i);

							count++;
						}
					}
				}

				if (!count)
				    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

				Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

				TPInfo[ playerid ][ tType ] = CARMODTYPE_SIDESKIRT;
				TPInfo[ playerid ][ tPaintjob ] = false;
				TuneType[playerid] = listitem;
			}
	        case 4:
	        {
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
				{
				    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_ROOF )
				    {
				        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
				        {
							format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
							strcat(string2, string);

							format(var, sizeof(var), "MORGANTUNE%d", count);
							SetPVarInt(playerid, var, i);

							count++;
						}
					}
				}

				if (!count)
				    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

				Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

				TPInfo[ playerid ][ tType ] = CARMODTYPE_ROOF;
				TPInfo[ playerid ][ tPaintjob ] = false;
				TuneType[playerid] = listitem;
			}
	        case 5:
	        {
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
				{
				    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_EXHAUST )
				    {
				        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
				        {
							format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
							strcat(string2, string);

							format(var, sizeof(var), "MORGANTUNE%d", count);
							SetPVarInt(playerid, var, i);

							count++;
						}
					}
				}

				if (!count)
				    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

				Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

				TPInfo[ playerid ][ tType ] = CARMODTYPE_EXHAUST;
				TPInfo[ playerid ][ tPaintjob ] = false;
				TuneType[playerid] = listitem;
			}
	        case 6:
	        {
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
				{
				    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_HYDRAULICS )
				    {
				        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
				        {
							format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
							strcat(string2, string);

							format(var, sizeof(var), "MORGANTUNE%d", count);
							SetPVarInt(playerid, var, i);

							count++;
						}
					}
				}

				if (!count)
				    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

				Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

				TPInfo[ playerid ][ tType ] = CARMODTYPE_HYDRAULICS;
				TPInfo[ playerid ][ tPaintjob ] = false;
				TuneType[playerid] = listitem;
			}
			case 8:
			{
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
				{
				    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_NITRO )
				    {
				        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
				        {
							format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
							strcat(string2, string);

							format(var, sizeof(var), "MORGANTUNE%d", count);
							SetPVarInt(playerid, var, i);

							count++;
						}
					}
				}

				if (!count)
				    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

				Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

				TPInfo[ playerid ][ tType ] = CARMODTYPE_NITRO;
				TPInfo[ playerid ][ tPaintjob ] = false;
				TuneType[playerid] = listitem;
			}
			case 9:
			{
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
				{
				    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_WHEELS )
				    {
				        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
				        {
							format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
							strcat(string2, string);

							format(var, sizeof(var), "MORGANTUNE%d", count);
							SetPVarInt(playerid, var, i);

							count++;
						}
					}
				}

				if (!count)
				    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

				Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

				TPInfo[ playerid ][ tType ] = CARMODTYPE_WHEELS;
				TPInfo[ playerid ][ tPaintjob ] = false;
				TuneType[playerid] = listitem;
			}
			case 10: // ลายรถ
			{
				new
				    count,
				    var[32],
					string[512],
					string2[512];

				for( new i = 0; i < NUMBER_TYPE_PAINTJOB; i++ ) 
				{
			        if( Morgan_pjInfo[ i ][ Morgan_vehID ] == GetVehicleModel( vehicleid ) ) 
					{
						format(string, sizeof(string), "%s\n", Morgan_pjInfo[ i ][ Morgan_pName ]);
						strcat(string2, string);

						format(var, sizeof(var), "MORGANTUNE%d", count);
						SetPVarInt(playerid, var, i);

						count++;					
					}
			    }


				if (!count)
				    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

				Dialog_Show(playerid, DIALOG_PAINTJOB_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

				TPInfo[ playerid ][ tPaintjob ] = true;
				TuneType[playerid] = listitem;
			}
			case 11:
			{
			    new owner = GetConnectedVehicleOwnerID(vehicleid);
			    
				if (owner == -1)
				    return ErrorMsg(playerid, "เจ้าของยานพาหนะไม่ออนไลน์ หรือ ยานพาหนะไม่มีเจ้าของ!");
			
			    Dialog_Show(playerid, DIALOG_PRICE_CONFIRM, DIALOG_STYLE_MSGBOX, "Mod", "{06E6F8}คุณต้องการเสนอราคาแต่งรถนี้ให้กับ {FAEF05}%s {06E6F8}เป็นจำนวนเงิน {06F811}%s {06E6F8}ต้องการแต่งรถและจ่ายหรือไม่?", "ตกลง", "กลับ", GetPlayerNameEx(owner), FormatMoney(CashAll_Tune[playerid]));
			}
			/*case 12:
			{
			    for(new i = 0; i < 14; i ++)
			    {
			        if(carData[vehicleid][carMods][i] >= 1000)
			        {
			            RemoveVehicleComponent(vehicleid, carData[vehicleid][carMods][i]);
			        }
			    }
			    SendClientMessage(playerid, COLOR_LIGHTRED, "คุณได้ทำการลบของแต่งรถทั้งหมดออกจากยานพาหนะของคุณแล้ว!");
			    CashAll_Tune[playerid] = 0;
			}*/
		}
	}
	return 1;
}

Dialog:DIALOG_CARTUNE_MORGAN(playerid, response, listitem, inputtext[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if (response)
	{
		new var[32];
		format(var, sizeof(var), "MORGANTUNE%d", listitem);
		new tuneid = GetPVarInt(playerid, var);
		
		CashAll_Tune[playerid] += Morgan_cInfo[ tuneid ][ cPrice ];

		AddVehicleComponent(vehicleid, Morgan_cInfo[ tuneid ][ cID ]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "คุณได้ทำการเพิ่มของแต่ง %s กับยานพาหนะ %s เรียบร้อยแล้ว", Morgan_cInfo[ tuneid ][ cName ], ReturnVehicleModelName(GetVehicleModel(vehicleid)));

		return ShowPlayerTuneDialog(playerid, TuneType[playerid] + 1);	
	}
	return 1;
}

Dialog:DIALOG_PAINTJOB_MORGAN(playerid, response, listitem, inputtext[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if (response)
	{
		new var[32];
		format(var, sizeof(var), "MORGANTUNE%d", listitem);
		new tuneid = GetPVarInt(playerid, var);
		
		CashAll_Tune[playerid] += Morgan_pjInfo[ tuneid ][ Morgan_pPrice ];

		ChangeVehiclePaintjob(vehicleid, Morgan_pjInfo[ tuneid ][ Morgan_pNumber ]);
		ChangeVehicleColor( vehicleid, 1, 1 );
		SendClientMessageEx(playerid, COLOR_YELLOW, "คุณได้ทำการเพิ่มของลายรถ %s กับยานพาหนะ %s เรียบร้อยแล้ว", Morgan_pjInfo[ tuneid ][ Morgan_pName ], ReturnVehicleModelName(GetVehicleModel(vehicleid)));

		return ShowPlayerTuneDialog(playerid, TuneType[playerid] + 1);	
	}
	return 1;
}

Dialog:DIALOG_PRICE_CONFIRM(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new vehicleid = GetPlayerVehicleID(playerid), owner = GetConnectedVehicleOwnerID(vehicleid);

		if (owner == -1)
			return ErrorMsg(playerid, "เจ้าของยานพาหนะไม่ออนไลน์ หรือ ยานพาหนะไม่มีเจ้าของ!");

        CashAll_Tune[owner] = CashAll_Tune[playerid];
        TunePlayer[owner] = playerid;
		Dialog_Show(owner, DIALOG_PRICE_CONFIRM2, DIALOG_STYLE_MSGBOX, "Mod", "{06E6F8}ช่างซ่อมรถ {FAEF05}%s {06E6F8}ได้ทำการเสนอราคาแต่งรถเป็นจำนวนเงิน {06F811}%s {06E6F8}คุณต้องการแต่งรถและจ่ายหรือไม่?", "ตกลง", "ออก", GetPlayerNameEx(playerid), FormatMoney(CashAll_Tune[playerid]));
	}
	return 1;
}

Dialog:DIALOG_PRICE_CONFIRM2(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new mechanicid = TunePlayer[playerid];
	
	    if (GetPlayerMoneyEx(playerid) < CashAll_Tune[playerid])
	    {
	    	Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "คุณมีเงินไม่เพียงพอสำหรับค่าแต่งรถ!", "ตกลง", "");
	    	Dialog_Show(mechanicid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ผู้เล่นนั้นมีเงินไม่เพียงพอสำหรับค่าแต่งรถ!", "ตกลง", "");
			return 1;
		}
		
		GivePlayerMoneyEx(playerid, - CashAll_Tune[playerid]);
		GivePlayerMoneyEx(mechanicid, CashAll_Tune[playerid]);
		
		SendClientMessageEx(playerid, COLOR_YELLOW, "คุณได้จ่ายค่าแต่งรถทั้งหมด %s เรียบร้อยแล้ว!", FormatMoney(CashAll_Tune[playerid]));
		SendClientMessageEx(mechanicid, COLOR_YELLOW, "ช่างซ่อมรถได้จ่ายเงินทั้งหมด %s ให้กับคุณแล้ว!", FormatMoney(CashAll_Tune[playerid]));

		CashAll_Tune[playerid] = 0;
		CashAll_Tune[mechanicid] = 0;

        TunePlayer[playerid] = -1;
        TunePlayer[mechanicid] = -1;
	}
	return 1;
}

stock IsComponentidCompatible_Morgan( modelid, componentid ) {
    if( componentid == 1025 || componentid == 1073 || componentid == 1074 || componentid == 1075 || componentid == 1076 ||
		componentid == 1077 || componentid == 1078 || componentid == 1079 || componentid == 1080 || componentid == 1081 ||
        componentid == 1082 || componentid == 1083 || componentid == 1084 || componentid == 1085 || componentid == 1096 ||
        componentid == 1097 || componentid == 1098 || componentid == 1087 || componentid == 1086 ) {
        return componentid;
	}

    switch( modelid ) {
        case 400: if( componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 ) return componentid;
        case 401: if( componentid == 1005 || componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 114 || componentid == 1020 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 402: if( componentid == 1009 || componentid == 1009 || componentid == 1010 ) return componentid;
        case 404: if( componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007) return componentid;
        case 405: if( componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1014 || componentid == 1023 || componentid == 1000) return componentid;
        case 409: if( componentid == 1009 ) return componentid;
        case 410: if( componentid == 1019 || componentid == 1021 || componentid == 1020 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 411: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 412: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 415: if( componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 418: if( componentid == 1020 || componentid == 1021 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1016) return componentid;
        case 419: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 420: if( componentid == 1005 || componentid == 1004 || componentid == 1021 || componentid == 1019 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1003) return componentid;
        case 421: if( componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1023 || componentid == 1016 || componentid == 1000) return componentid;
        case 422: if( componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1017 || componentid == 1007) return componentid;
        case 426: if( componentid == 1005 || componentid == 1004 || componentid == 1021 || componentid == 1019 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003) return componentid;
        case 429: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 436: if( componentid == 1020 || componentid == 1021 || componentid == 1022 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 438: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 439: if( componentid == 1003 || componentid == 1023 || componentid == 1001 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1017 || componentid == 1007 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1013) return componentid;
        case 442: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 445: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 451: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 458: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 466: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 467: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 474: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 475: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 477: if( componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1017 || componentid == 1007) return componentid;
        case 478: if( componentid == 1005 || componentid == 1004 || componentid == 1012 || componentid == 1020 || componentid == 1021 || componentid == 1022 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 479: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 480: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 489: if( componentid == 1005 || componentid == 1004 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1016 || componentid == 1000) return componentid;
        case 491: if( componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 492: if( componentid == 1005 || componentid == 1004 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1016 || componentid == 1000) return componentid;
        case 496: if( componentid == 1006 || componentid == 1017 || componentid == 1007 || componentid == 1011 || componentid == 1019 || componentid == 1023 || componentid == 1001 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1003 || componentid == 1002 || componentid == 1142 || componentid == 1143 || componentid == 1020) return componentid;
        case 500: if( componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 506: if( componentid == 1009) return componentid;
        case 507: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 516: if( componentid == 1004 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1015 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007) return componentid;
        case 517: if( componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1023 || componentid == 1016 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 518: if( componentid == 1005 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 526: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 527: if( componentid == 1021 || componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1014 || componentid == 1015 || componentid == 1017 || componentid == 1007) return componentid;
        case 529: if( componentid == 1012 || componentid == 1011 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 533: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 534: if( componentid == 1126 || componentid == 1127 || componentid == 1179 || componentid == 1185 || componentid == 1100 || componentid == 1123 || componentid == 1125 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1180 || componentid == 1178 || componentid == 1101 || componentid == 1122 || componentid == 1124 || componentid == 1106) return componentid;
        case 535: if( componentid == 1109 || componentid == 1110 || componentid == 1113 || componentid == 1114 || componentid == 1115 || componentid == 1116 || componentid == 1117 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1120 || componentid == 1118 || componentid == 1121 || componentid == 1119) return componentid;
        case 536: if( componentid == 1104 || componentid == 1105 || componentid == 1182 || componentid == 1181 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1184 || componentid == 1183 || componentid == 1128 || componentid == 1103 || componentid == 1107 || componentid == 1108) return componentid;
        case 540: if( componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007) return componentid;
        case 541: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 542: if( componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1015) return componentid;
        case 545: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 546: if( componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007) return componentid;
        case 547: if( componentid == 1142 || componentid == 1143 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1016 || componentid == 1003 || componentid == 1000) return componentid;
        case 549: if( componentid == 1012 || componentid == 1011 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 550: if( componentid == 1005 || componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003) return componentid;
        case 551: if( componentid == 1005 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1023 || componentid == 1016 || componentid == 1003) return componentid;
        case 555: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 558: if( componentid == 1092 || componentid == 1089 || componentid == 1166 || componentid == 1165 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1168 || componentid == 1167 || componentid == 1088 || componentid == 1091 || componentid == 1164 || componentid == 1163 || componentid == 1094 || componentid == 1090 || componentid == 1095 || componentid == 1093) return componentid;
        case 559: if( componentid == 1065 || componentid == 1066 || componentid == 1160 || componentid == 1173 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1159 || componentid == 1161 || componentid == 1162 || componentid == 1158 || componentid == 1067 || componentid == 1068 || componentid == 1071 || componentid == 1069 || componentid == 1072 || componentid == 1070 || componentid == 1009) return componentid;
        case 560: if( componentid == 1028 || componentid == 1029 || componentid == 1169 || componentid == 1170 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1141 || componentid == 1140 || componentid == 1032 || componentid == 1033 || componentid == 1138 || componentid == 1139 || componentid == 1027 || componentid == 1026 || componentid == 1030 || componentid == 1031) return componentid;
        case 561: if( componentid == 1064 || componentid == 1059 || componentid == 1155 || componentid == 1157 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1154 || componentid == 1156 || componentid == 1055 || componentid == 1061 || componentid == 1058 || componentid == 1060 || componentid == 1062 || componentid == 1056 || componentid == 1063 || componentid == 1057) return componentid;
        case 562: if( componentid == 1034 || componentid == 1037 || componentid == 1171 || componentid == 1172 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1149 || componentid == 1148 || componentid == 1038 || componentid == 1035 || componentid == 1147 || componentid == 1146 || componentid == 1040 || componentid == 1036 || componentid == 1041 || componentid == 1039) return componentid;
        case 565: if( componentid == 1046 || componentid == 1045 || componentid == 1153 || componentid == 1152 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1150 || componentid == 1151 || componentid == 1054 || componentid == 1053 || componentid == 1049 || componentid == 1050 || componentid == 1051 || componentid == 1047 || componentid == 1052 || componentid == 1048) return componentid;
        case 566: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 567: if( componentid == 1129 || componentid == 1132 || componentid == 1189 || componentid == 1188 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1187 || componentid == 1186 || componentid == 1130 || componentid == 1131 || componentid == 1102 || componentid == 1133) return componentid;
        case 575: if( componentid == 1044 || componentid == 1043 || componentid == 1174 || componentid == 1175 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1176 || componentid == 1177 || componentid == 1099 || componentid == 1042) return componentid;
        case 576: if( componentid == 1136 || componentid == 1135 || componentid == 1191 || componentid == 1190 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1192 || componentid == 1193 || componentid == 1137 || componentid == 1134) return componentid;
        case 579: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 580: if( componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007) return componentid;
        case 585: if( componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 587: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 589: if( componentid == 1005 || componentid == 1004 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1024 || componentid == 1013 || componentid == 1006 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007) return componentid;
        case 600: if( componentid == 1005 || componentid == 1004 || componentid == 1020 || componentid == 1022 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1017 || componentid == 1007) return componentid;
        case 602: if( componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 603: if( componentid == 1144 || componentid == 1145 || componentid == 1142 || componentid == 1143 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007) return componentid;
    }
    return false;
}

forward GetConnectedVehicleOwnerID(vehicleid);
public GetConnectedVehicleOwnerID(vehicleid)
{
	new vehowner = -1;
    foreach (new i : Player)
    {
        if (playerData[i][IsLoggedIn])
        {
            if (playerData[i][pID] == carData[vehicleid][carOwnerID])
            {
				vehowner = i;
            }
        }
    }
    return vehowner;
}

ShowPlayerTuneDialog(playerid, type)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	switch (type)
	{
	    case 0:
	    {
			new
			    count,
			    var[32],
				string[512],
				string2[512];

			for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
			{
			    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_FRONT_BUMPER )
			    {
			        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
			        {
						format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
						strcat(string2, string);

						format(var, sizeof(var), "MORGANTUNE%d", count);
						SetPVarInt(playerid, var, i);

						count++;
					}
				}
			}

			if (!count)
			    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

			Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

			TPInfo[ playerid ][ tType ] = CARMODTYPE_FRONT_BUMPER;
			TPInfo[ playerid ][ tPaintjob ] = false;
			
		}
	    case 1:
	    {
			new
			    count,
			    var[32],
				string[512],
				string2[512];

			for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
			{
			    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_REAR_BUMPER )
			    {
			        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
			        {
						format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
						strcat(string2, string);

						format(var, sizeof(var), "MORGANTUNE%d", count);
						SetPVarInt(playerid, var, i);

						count++;
					}
				}
			}

			if (!count)
			    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

			Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

			TPInfo[ playerid ][ tType ] = CARMODTYPE_REAR_BUMPER;
			TPInfo[ playerid ][ tPaintjob ] = false;
			
		}
	    case 2:
	    {
			new
			    count,
			    var[32],
				string[512],
				string2[512];

			for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
			{
			    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_SPOILER )
			    {
			        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
			        {
						format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
						strcat(string2, string);

						format(var, sizeof(var), "MORGANTUNE%d", count);
						SetPVarInt(playerid, var, i);

						count++;
					}
				}
			}

			if (!count)
			    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

			Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

			TPInfo[ playerid ][ tType ] = CARMODTYPE_SPOILER;
			TPInfo[ playerid ][ tPaintjob ] = false;
			
		}
	    case 3:
	    {
			new
			    count,
			    var[32],
				string[512],
				string2[512];

			for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
			{
			    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_SIDESKIRT )
			    {
			        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
			        {
						format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
						strcat(string2, string);

						format(var, sizeof(var), "MORGANTUNE%d", count);
						SetPVarInt(playerid, var, i);

						count++;
					}
				}
			}

			if (!count)
			    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

			Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

			TPInfo[ playerid ][ tType ] = CARMODTYPE_SIDESKIRT;
			TPInfo[ playerid ][ tPaintjob ] = false;
			
		}
	    case 4:
	    {
			new
			    count,
			    var[32],
				string[512],
				string2[512];

			for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
			{
			    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_ROOF )
			    {
			        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
			        {
						format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
						strcat(string2, string);

						format(var, sizeof(var), "MORGANTUNE%d", count);
						SetPVarInt(playerid, var, i);

						count++;
					}
				}
			}

			if (!count)
			    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

			Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

			TPInfo[ playerid ][ tType ] = CARMODTYPE_ROOF;
			TPInfo[ playerid ][ tPaintjob ] = false;
			
		}
	    case 5:
	    {
			new
			    count,
			    var[32],
				string[512],
				string2[512];

			for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
			{
			    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_EXHAUST )
			    {
			        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
			        {
						format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
						strcat(string2, string);

						format(var, sizeof(var), "MORGANTUNE%d", count);
						SetPVarInt(playerid, var, i);

						count++;
					}
				}
			}

			if (!count)
			    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

			Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

			TPInfo[ playerid ][ tType ] = CARMODTYPE_EXHAUST;
			TPInfo[ playerid ][ tPaintjob ] = false;
			
		}
	    case 6:
	    {
			new
			    count,
			    var[32],
				string[512],
				string2[512];

			for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
			{
			    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_HYDRAULICS )
			    {
			        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
			        {
						format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
						strcat(string2, string);

						format(var, sizeof(var), "MORGANTUNE%d", count);
						SetPVarInt(playerid, var, i);

						count++;
					}
				}
			}

			if (!count)
			    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

			Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

			TPInfo[ playerid ][ tType ] = CARMODTYPE_HYDRAULICS;
			TPInfo[ playerid ][ tPaintjob ] = false;
			
		}
		case 8:
		{
			new
			    count,
			    var[32],
				string[512],
				string2[512];

			for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
			{
			    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_NITRO )
			    {
			        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
			        {
						format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
						strcat(string2, string);

						format(var, sizeof(var), "MORGANTUNE%d", count);
						SetPVarInt(playerid, var, i);

						count++;
					}
				}
			}

			if (!count)
			    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

			Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

			TPInfo[ playerid ][ tType ] = CARMODTYPE_NITRO;
			TPInfo[ playerid ][ tPaintjob ] = false;
			
		}
		case 9:
		{
			new
			    count,
			    var[32],
				string[512],
				string2[512];

			for( new i = 0; i < MAX_COMPONENTS_MORGAN; i++ )
			{
			    if( Morgan_cInfo[ i ][ cType ] == CARMODTYPE_WHEELS )
			    {
			        if( Morgan_cInfo[ i ][ cID ] == IsComponentidCompatible_Morgan( GetVehicleModel( vehicleid ), Morgan_cInfo[ i ][ cID ] ) )
			        {
						format(string, sizeof(string), "%s\n", Morgan_cInfo[ i ][ cName ]);
						strcat(string2, string);

						format(var, sizeof(var), "MORGANTUNE%d", count);
						SetPVarInt(playerid, var, i);

						count++;
					}
				}
			}

			if (!count)
			    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

			Dialog_Show(playerid, DIALOG_CARTUNE_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

			TPInfo[ playerid ][ tType ] = CARMODTYPE_WHEELS;
			TPInfo[ playerid ][ tPaintjob ] = false;
			
		}
		case 10: // ลายรถ
		{
			new
			    count,
			    var[32],
				string[512],
				string2[512];

			for( new i = 0; i < NUMBER_TYPE_PAINTJOB; i++ ) 
			{
		        if( Morgan_pjInfo[ i ][ Morgan_vehID ] == GetVehicleModel( vehicleid ) ) 
				{
					format(string, sizeof(string), "%s\n", Morgan_pjInfo[ i ][ Morgan_pName ]);
					strcat(string2, string);

					format(var, sizeof(var), "MORGANTUNE%d", count);
					SetPVarInt(playerid, var, i);

					count++;					
				}
		    }


			if (!count)
			    return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{F93804}Aleart", "ยานพาหนะของคุณไม่ได้รองรับของแต่งใด ๆ!", "ตกลง", "");

			Dialog_Show(playerid, DIALOG_PAINTJOB_MORGAN, DIALOG_STYLE_LIST, "ลิสต์", string2, "เลือก", "ปิด");

			TPInfo[ playerid ][ tPaintjob ] = true;
		}
	}
	return 1;
}
