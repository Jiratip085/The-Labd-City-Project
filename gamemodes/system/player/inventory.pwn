#include	<YSI_Coding\y_hooks>
#include 	<YSI_Coding\y_timers>
#include	<eSelection>

#define MAX_LISTED_ITEMS (10)
#define MAX_DROPPED_ITEMS (5000)

#define MODEL_SELECTION_INVENTORY (0)


new PlayerText:INVTD[MAX_PLAYERS][292];

enum droppedItems {
	droppedID,
	droppedItem[32],
	droppedPlayer[24],
	droppedModel,
	droppedQuantity,
	Float:droppedPos[3],
	droppedInt,
	droppedWorld,
	droppedAmount,
	droppedObject,
	Text3D:droppedText3D
};
new DroppedItems[MAX_DROPPED_ITEMS][droppedItems];
new NearestItems[MAX_PLAYERS][MAX_LISTED_ITEMS];

enum ITEM_NAME_DATA {
	itemName[32],
	itemModel
};
new const itemData[][ITEM_NAME_DATA] = {
	//����ͼ�Ҽ����
	{ "Skin:7", 2384 },
	{ "Skin:14", 2384 },
	{ "Skin:20", 2384 },
	{ "Skin:22", 2384 },
	{ "Skin:23", 2384 },
	{ "Skin:24", 2384 },
	{ "Skin:25", 2384 },
	{ "Skin:30", 2384 },
	{ "Skin:34", 2384 },
	{ "Skin:44", 2384 },
	{ "Skin:46", 2384 },
	{ "Skin:47", 2384 },
	{ "Skin:48", 2384 },
	{ "Skin:60", 2384 },
	{ "Skin:67", 2384 },
	{ "Skin:72", 2384 },
	{ "Skin:79", 2384 }, //Godji
	{ "Skin:98", 2384 }, //Shiba
	{ "Skin:185", 2384 },
	{ "Skin:188", 2384 },
	{ "Skin:206", 2384 },
	{ "Skin:202", 2384 },
	{ "Skin:217", 2384 }, //Staff
	{ "Skin:223", 2384 }, //������ Beta Test
	{ "Skin:235", 2384 },
	{ "Skin:236", 2384 },
	{ "Skin:240", 2384 }, //Ekque
	{ "Skin:250", 2384 },
	{ "Skin:258", 2384 },
	{ "Skin:259", 2384 },
	{ "Skin:290", 2384 },
	{ "Skin:297", 2384 },
	{ "Skin:303", 2384 },
	{ "Skin:304", 2384 },
	{ "Skin:305", 2384 },

	//����ͼ�Ҽ��˭ԧ
	{ "Skin:9", 2384 },
	{ "Skin:13", 2384 },
	{ "Skin:38", 2384 },
	{ "Skin:93", 2384 },
	{ "Skin:129", 2384 },
	{ "Skin:130", 2384 },
	{ "Skin:131", 2384 },
	{ "Skin:148", 2384 },
	{ "Skin:193", 2384 }, //������ Beta Test
	{ "Skin:226", 2384 },
	{ "Skin:233", 2384 },
	{ "Skin:298", 2384 },
	{ "Skin:192", 2384 },
	{ "Skin:151", 2384 },
	{ "Skin:157", 2384 },
	{ "Skin:193", 2384 },

	
	{ "Knife", 335 },
	{ "Crate", 19639 },
	{ "FishingRod", 18632 },
	{ "FishingBait", 2589 },

	{ "ApplePack", 19575 },
	{ "BetaTestBox", 2972 },
	{ "Fish", 19630 },
	{ "Shell", 2782 },
	{ "Turtle", 1609 },
	{ "Starfish", 902  },
	{ "Jellyfish", 1603 },

	{ "Shark", 1608  },
	{ "Dolphin", 1607   },
	{ "Burger", 2663 },
	{ "Water", 2647 },
	{ "Ore", 3929 },
	{ "Iron", 2936 },
	{ "Gold", 19941 },
	{ "Diamon", 1614 },
	{ "Hammer", 19631 },
	{ "Log", 19793 },
	{ "WoodPacks", 1463 },
	{ "GunPowder", 2057 },
	{ "MedicCase", 11738 },
	{ "DrivingLicense", 1581 },
	{ "Radio", 19942 },
	{ "Camera", 367 },
	{ "PepperSpray", 365 },
	{ "Rope", 968 },
	{ "iFruit", 18868 },
	{ "Watch", 19039 },
	{ "Crowbar", 18634 },
	{ "Metal", 19845 },
	{ "ToolBox", 19921 },
	{ "AdminGun", 348 },
	{ "AdminAk", 355 },
    { "Chainsaw", 341 }
};


hook OnGameModeInit()
{

}

hook OnPlayerConnect(playerid) 
{
	INVTD[playerid][0] = CreatePlayerTextDraw(playerid, 240.500000, 140.000000, "_");
	PlayerTextDrawFont(playerid, INVTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][0], 0.600000, 25.500015);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][0], 298.500000, 130.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][0], 135);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][0], 0);

	INVTD[playerid][1] = CreatePlayerTextDraw(playerid, 395.000000, 140.000000, "_");
	PlayerTextDrawFont(playerid, INVTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][1], 0.600000, 25.500015);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][1], 2998.000000, 166.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][1], 135);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][1], 0);

	INVTD[playerid][2] = CreatePlayerTextDraw(playerid, 395.000000, 352.000000, "_");
	PlayerTextDrawFont(playerid, INVTD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][2], 0.600000, -0.199983);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][2], 290.500000, 165.699996);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][2], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][2], 9109704);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][2], 0);

	INVTD[playerid][3] = CreatePlayerTextDraw(playerid, 395.000000, 160.000000, "_");
	PlayerTextDrawFont(playerid, INVTD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][3], 0.600000, -0.199983);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][3], 298.500000, 166.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][3], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][3], 9109704);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][3], 0);

	INVTD[playerid][4] = CreatePlayerTextDraw(playerid, 240.500000, 291.000000, "_");
	PlayerTextDrawFont(playerid, INVTD[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][4], 0.600000, -0.199983);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][4], 298.500000, 130.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][4], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][4], 9109704);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][4], 0);

	INVTD[playerid][5] = CreatePlayerTextDraw(playerid, 240.500000, 160.000000, "_");
	PlayerTextDrawFont(playerid, INVTD[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][5], 0.600000, -0.199983);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][5], 298.500000, 130.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][5], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][5], 9109704);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][5], 0);

	INVTD[playerid][6] = CreatePlayerTextDraw(playerid, 241.000000, 140.000000, "Hugo_Wingin");
	PlayerTextDrawFont(playerid, INVTD[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][6], 0.287499, 1.750000);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][6], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][6], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][6], -1962934072);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][6], 0);

	INVTD[playerid][7] = CreatePlayerTextDraw(playerid, 377.000000, 140.000000, "INVENTORY");
	PlayerTextDrawFont(playerid, INVTD[playerid][7], 2);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][7], 0.295832, 1.750000);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][7], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][7], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][7], -1962934072);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][7], 0);

	INVTD[playerid][8] = CreatePlayerTextDraw(playerid, 207.500000, 298.000000, "MENU");
	PlayerTextDrawFont(playerid, INVTD[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][8], 0.312498, 1.750000);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][8], 16.500000, 58.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][8], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][8], 9109704);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][8], 1);

	INVTD[playerid][9] = CreatePlayerTextDraw(playerid, 273.000000, 298.000000, "Anims");
	PlayerTextDrawFont(playerid, INVTD[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][9], 0.349999, 1.750000);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][9], 18.500000, 58.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][9], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][9], 9109704);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][9], 1);

	INVTD[playerid][10] = CreatePlayerTextDraw(playerid, 207.500000, 324.000000, "GPS");
	PlayerTextDrawFont(playerid, INVTD[playerid][10], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][10], 0.333332, 1.750000);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][10], 16.500000, 58.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][10], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][10], 9109704);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][10], 1);

	INVTD[playerid][11] = CreatePlayerTextDraw(playerid, 207.500000, 350.000000, "Donate");
	PlayerTextDrawFont(playerid, INVTD[playerid][11], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][11], 0.312498, 1.750000);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][11], 16.500000, 58.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][11], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][11], 9109704);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][11], 1);

	INVTD[playerid][12] = CreatePlayerTextDraw(playerid, 273.000000, 324.000000, "Jobs");
	PlayerTextDrawFont(playerid, INVTD[playerid][12], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][12], 0.349999, 1.750000);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][12], 18.500000, 58.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][12], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][12], 9109704);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][12], 1);

	INVTD[playerid][13] = CreatePlayerTextDraw(playerid, 273.000000, 350.000000, "Stats");
	PlayerTextDrawFont(playerid, INVTD[playerid][13], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][13], 0.349999, 1.750000);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][13], 18.500000, 58.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][13], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][13], 9109704);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][13], 1);

	INVTD[playerid][14] = CreatePlayerTextDraw(playerid, 177.000000, 165.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, INVTD[playerid][14], 5);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][14], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][14], 81.500000, 118.500000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][14], 1);
	PlayerTextDrawColor(playerid, INVTD[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][14], 1296911691);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][14], 1296911871);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][14], 0);
	PlayerTextDrawSetPreviewModel(playerid, INVTD[playerid][14], 280);
	PlayerTextDrawSetPreviewRot(playerid, INVTD[playerid][14], -10.000000, 0.000000, -4.000000, 0.899999);
	PlayerTextDrawSetPreviewVehCol(playerid, INVTD[playerid][14], 1, 1);

	INVTD[playerid][15] = CreatePlayerTextDraw(playerid, 269.000000, 169.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, INVTD[playerid][15], 5);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][15], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][15], 28.500000, 32.500000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, INVTD[playerid][15], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][15], 1296911741);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][15], 255);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][15], 1);
	PlayerTextDrawSetPreviewModel(playerid, INVTD[playerid][15], 18631);
	PlayerTextDrawSetPreviewRot(playerid, INVTD[playerid][15], 0.000000, 0.000000, 1.000000, 0.899999);
	PlayerTextDrawSetPreviewVehCol(playerid, INVTD[playerid][15], 1, 1);

	INVTD[playerid][16] = CreatePlayerTextDraw(playerid, 269.000000, 245.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, INVTD[playerid][16], 5);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][16], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][16], 28.500000, 32.500000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, INVTD[playerid][16], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][16], 1296911741);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][16], 255);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][16], 1);
	PlayerTextDrawSetPreviewModel(playerid, INVTD[playerid][16], 2694);
	PlayerTextDrawSetPreviewRot(playerid, INVTD[playerid][16], -30.000000, 0.000000, 50.000000, 0.779999);
	PlayerTextDrawSetPreviewVehCol(playerid, INVTD[playerid][16], 1, 1);

	INVTD[playerid][17] = CreatePlayerTextDraw(playerid, 269.000000, 207.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, INVTD[playerid][17], 5);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][17], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][17], 28.500000, 32.500000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, INVTD[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][17], 1296911741);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][17], 255);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][17], 0);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][17], 1);
	PlayerTextDrawSetPreviewModel(playerid, INVTD[playerid][17], 1275);
	PlayerTextDrawSetPreviewRot(playerid, INVTD[playerid][17], 0.000000, 0.000000, 1.000000, 0.899999);
	PlayerTextDrawSetPreviewVehCol(playerid, INVTD[playerid][17], 1, 1);

	INVTD[playerid][18] = CreatePlayerTextDraw(playerid, 472.000000, 139.000000, "X");
	PlayerTextDrawFont(playerid, INVTD[playerid][18], 2);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][18], 0.304165, 1.750000);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][18], 13.500000, 9.500000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][18], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][18], -16776961);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][18], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][18], -1962934072);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][18], 0);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][18], 1);

	INVTD[playerid][19] = CreatePlayerTextDraw(playerid, 459.000000, 139.000000, "C");
	PlayerTextDrawFont(playerid, INVTD[playerid][19], 2);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][19], 0.304165, 1.750000);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][19], 13.500000, 9.500000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][19], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][19], 1097458175);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][19], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][19], 200);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][19], 0);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][19], 1);

	INVTD[playerid][20] = CreatePlayerTextDraw(playerid, 320.000000, 355.000000, "1,000,000");
	PlayerTextDrawFont(playerid, INVTD[playerid][20], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][20], 0.354166, 1.449998);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][20], 460.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][20], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][20], 1);
	PlayerTextDrawColor(playerid, INVTD[playerid][20], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][20], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][20], -1962934222);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][20], 0);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][20], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][20], 0);

	INVTD[playerid][21] = CreatePlayerTextDraw(playerid, 316.000000, 353.000000, "$");
	PlayerTextDrawFont(playerid, INVTD[playerid][21], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][21], 0.304165, 1.649999);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][21], 13.500000, 9.500000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][21], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][21], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][21], 9109759);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][21], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][21], -1962934072);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][21], 0);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][21], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][21], 1);

	INVTD[playerid][22] = CreatePlayerTextDraw(playerid, 464.000000, 356.000000, "ld_beat:right");
	PlayerTextDrawFont(playerid, INVTD[playerid][22], 4);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][22], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][22], 13.000000, 13.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][22], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][22], 1);
	PlayerTextDrawColor(playerid, INVTD[playerid][22], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][22], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][22], 50);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][22], 1);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][22], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][22], 1);

	INVTD[playerid][23] = CreatePlayerTextDraw(playerid, 456.000000, 357.000000, "0");
	PlayerTextDrawFont(playerid, INVTD[playerid][23], 3);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][23], 0.300000, 1.149999);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][23], -20.000000, 10.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][23], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][23], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][23], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][23], 9109759);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][23], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][23], 1296911741);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][23], 1);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][23], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][23], 1);

	INVTD[playerid][24] = CreatePlayerTextDraw(playerid, 236.000000, 266.000000, "HP: 100");
	PlayerTextDrawFont(playerid, INVTD[playerid][24], 2);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][24], 0.133332, 0.999998);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][24], 460.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][24], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][24], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][24], 1);
	PlayerTextDrawColor(playerid, INVTD[playerid][24], -1962934017);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][24], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][24], -1962934222);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][24], 0);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][24], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][24], 0);

	INVTD[playerid][25] = CreatePlayerTextDraw(playerid, 236.000000, 274.000000, "AR: 100");
	PlayerTextDrawFont(playerid, INVTD[playerid][25], 2);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][25], 0.133332, 0.999998);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][25], 460.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][25], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][25], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][25], 1);
	PlayerTextDrawColor(playerid, INVTD[playerid][25], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][25], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][25], -1962934222);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][25], 0);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][25], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][25], 0);

	INVTD[playerid][26] = CreatePlayerTextDraw(playerid, 435.100006, 356.000000, "ld_beat:left");
	PlayerTextDrawFont(playerid, INVTD[playerid][26], 4);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][26], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][26], 13.000000, 13.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][26], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][26], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][26], 1);
	PlayerTextDrawColor(playerid, INVTD[playerid][26], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][26], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][26], 50);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][26], 1);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][26], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][26], 1);

	INVTD[playerid][27] = CreatePlayerTextDraw(playerid, 383.000000, 353.000000, "$");
	PlayerTextDrawFont(playerid, INVTD[playerid][27], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][27], 0.304165, 1.649999);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][27], 13.500000, 9.500000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][27], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][27], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][27], 2);
	PlayerTextDrawColor(playerid, INVTD[playerid][27], -16776961);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][27], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][27], 200);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][27], 0);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][27], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][27], 1);

	INVTD[playerid][28] = CreatePlayerTextDraw(playerid, 387.000000, 355.000000, "10,000,000");
	PlayerTextDrawFont(playerid, INVTD[playerid][28], 1);
	PlayerTextDrawLetterSize(playerid, INVTD[playerid][28], 0.354166, 1.449998);
	PlayerTextDrawTextSize(playerid, INVTD[playerid][28], 460.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, INVTD[playerid][28], 1);
	PlayerTextDrawSetShadow(playerid, INVTD[playerid][28], 0);
	PlayerTextDrawAlignment(playerid, INVTD[playerid][28], 1);
	PlayerTextDrawColor(playerid, INVTD[playerid][28], -1);
	PlayerTextDrawBackgroundColor(playerid, INVTD[playerid][28], 255);
	PlayerTextDrawBoxColor(playerid, INVTD[playerid][28], 50);
	PlayerTextDrawUseBox(playerid, INVTD[playerid][28], 0);
	PlayerTextDrawSetProportional(playerid, INVTD[playerid][28], 1);
	PlayerTextDrawSetSelectable(playerid, INVTD[playerid][28], 0);
	return 1;
}

ShowPlayerInventory(playerid, bool:enable)
{
    new List:inv = list_new(), var[32], count = 0;
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);


	if(enable == true)
	{
		ShowPlayerINV(playerid, true);		
		playerData[playerid][pStorageSelect] = 0;
		if(playerData[playerid][pInventoryPage] == 0)
		{
			for (new i = 0; i < playerData[playerid][pMaxItem]; i ++)
			{
				if (invData[playerid][i][invExists])
				{
					new id_item = Inventory_GetItemIDFromItemName(invData[playerid][i][invItem]), amount[12];

					format(amount, sizeof(amount), "%d/%d", invData[playerid][i][invQuantity], playerData[playerid][pItemAmount]);
					
					AddModelMenuItem(inv, itemData[id_item][itemModel], amount, false, 0.0, 0.0, 0.0, 0.5);
					format(var, sizeof(var), "itemlist%d", count);
					SetPVarInt(playerid, var, i);
					count++;
				}
			}
		}
		if(playerData[playerid][pInventoryPage] == 1)
		{
			for (new i = 20; i < playerData[playerid][pMaxItem]; i ++)
			{
				if (invData[playerid][i][invExists])
				{
					new id_item = Inventory_GetItemIDFromItemName(invData[playerid][i][invItem]), amount[12];

					format(amount, sizeof(amount), "%d/%d", invData[playerid][i][invQuantity], playerData[playerid][pItemAmount]);
					
					AddModelMenuItem(inv, itemData[id_item][itemModel], amount, false, 0.0, 0.0, 0.0, 0.5);
					format(var, sizeof(var), "itemlist%d", count);
					SetPVarInt(playerid, var, i);
					count++;
				}
			}
		}
		if(playerData[playerid][pInventoryPage] == 2)
		{
			for (new i = 40; i < playerData[playerid][pMaxItem]; i ++)
			{
				if (invData[playerid][i][invExists])
				{
					new id_item = Inventory_GetItemIDFromItemName(invData[playerid][i][invItem]), amount[12];

					format(amount, sizeof(amount), "%d/%d", invData[playerid][i][invQuantity], playerData[playerid][pItemAmount]);
					
					AddModelMenuItem(inv, itemData[id_item][itemModel], amount, false, 0.0, 0.0, 0.0, 0.5);
					format(var, sizeof(var), "itemlist%d", count);
					SetPVarInt(playerid, var, i);
					count++;
				}
			}
		}
		if(playerData[playerid][pInventoryPage] == 3)
		{
			for (new i = 60; i < playerData[playerid][pMaxItem]; i ++)
			{
				if (invData[playerid][i][invExists])
				{
					new id_item = Inventory_GetItemIDFromItemName(invData[playerid][i][invItem]), amount[12];

					format(amount, sizeof(amount), "%d/%d", invData[playerid][i][invQuantity], playerData[playerid][pItemAmount]);
					
					AddModelMenuItem(inv, itemData[id_item][itemModel], amount, false, 0.0, 0.0, 0.0, 0.5);
					format(var, sizeof(var), "itemlist%d", count);
					SetPVarInt(playerid, var, i);
					count++;
				}
			}
		}
		
		ShowModelSelectionMenu(playerid, MODEL_SELECTION_INVENTORY, inv);

		new str[128], Float:hp, Float:armour;
		GetPlayerHealth(playerid, hp);
		GetPlayerArmour(playerid, armour);

		PlayerTextDrawSetPreviewModel(playerid, INVTD[playerid][14], GetPlayerSkin(playerid));
		PlayerTextDrawShow(playerid, INVTD[playerid][14]);

		format(str, sizeof(str), "HP: %.0f", hp);
		PlayerTextDrawSetString(playerid, INVTD[playerid][24], str);

		format(str, sizeof(str), "AR: %.0f", armour);
		PlayerTextDrawSetString(playerid, INVTD[playerid][25], str);

		format(str, sizeof(str), "%s", GetPlayerNameEx(playerid));
		PlayerTextDrawSetString(playerid, INVTD[playerid][6], str);
		
		format(str, sizeof(str), "%s", FormatNumber(GetPlayerMoney(playerid)));
		PlayerTextDrawSetString(playerid, INVTD[playerid][20], str);
		
		format(str, sizeof(str), "%s", FormatNumber(GetPlayerRedMoney(playerid)));
		PlayerTextDrawSetString(playerid, INVTD[playerid][28], str);

		format(str, sizeof(str), "%d", playerData[playerid][pInventoryPage]);
		PlayerTextDrawSetString(playerid, INVTD[playerid][23], str);

		if(playerData[playerid][pGender] == 1)
		{
			if(playerData[playerid][pSkins] != 289)
				PlayerTextDrawSetPreviewModel(playerid, INVTD[playerid][17], 2384);

			if(playerData[playerid][pSkins] == 289)
				PlayerTextDrawSetPreviewModel(playerid, INVTD[playerid][17], 1275);

			return PlayerTextDrawShow(playerid, INVTD[playerid][17]);
		}

		if(playerData[playerid][pGender] == 2)
		{
			if(playerData[playerid][pSkins] != 191)
				PlayerTextDrawSetPreviewModel(playerid, INVTD[playerid][17], 2384);

			if(playerData[playerid][pSkins] == 191)
				PlayerTextDrawSetPreviewModel(playerid, INVTD[playerid][17], 1275);

			return PlayerTextDrawShow(playerid, INVTD[playerid][17]);
		}


	}
	else 
	{
		ShowPlayerINV(playerid, false);		
		playerData[playerid][INV] = 0;
	}
	return 1;
}

stock Inventory_GetItemIDFromItemName(const item[])
{
	new itemid;
    for (new i = 0; i < sizeof(itemData); i ++) if (!strcmp(itemData[i][itemName], item, true))
	{
        itemid = i;
        break;
    }
    return itemid;
}

public OnModelSelectionResponse(playerid, extraid, index, modelid, response)
{
    if(extraid == MODEL_SELECTION_INVENTORY)
    {
        if(response == MODEL_RESPONSE_SELECT)
        {
			new var[32];
			format(var, sizeof(var), "itemlist%d", index);
			new item = GetPVarInt(playerid, var);

			for (new i = 0; i < 36; i ++) {
				TextDrawHideForPlayer(playerid, Ironpie_Public[i]);
			}
			ShowPlayerINV(playerid, false);		
	        OnPlayerClickItem(playerid, item, invData[playerid][item][invItem]);
        }
    }
    return 1;
}

ShowPlayerINV(playerid, bool:enable)
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if(!playerData[playerid][IsLoggedIn]) 
		return 0;

	if(enable == true)
	{
		/*PlayerTextDrawShow(playerid, INVTD[playerid][0]);
		PlayerTextDrawShow(playerid, INVTD[playerid][1]);
		PlayerTextDrawShow(playerid, INVTD[playerid][2]);
		PlayerTextDrawShow(playerid, INVTD[playerid][3]);
		PlayerTextDrawShow(playerid, INVTD[playerid][4]);
		PlayerTextDrawShow(playerid, INVTD[playerid][5]);
		PlayerTextDrawShow(playerid, INVTD[playerid][6]);
		PlayerTextDrawShow(playerid, INVTD[playerid][7]);
		PlayerTextDrawShow(playerid, INVTD[playerid][8]);
		PlayerTextDrawShow(playerid, INVTD[playerid][9]);
		PlayerTextDrawShow(playerid, INVTD[playerid][10]);
		PlayerTextDrawShow(playerid, INVTD[playerid][11]);
		PlayerTextDrawShow(playerid, INVTD[playerid][12]);
		PlayerTextDrawShow(playerid, INVTD[playerid][13]);
		PlayerTextDrawShow(playerid, INVTD[playerid][14]);
		PlayerTextDrawShow(playerid, INVTD[playerid][15]);
		PlayerTextDrawShow(playerid, INVTD[playerid][16]);
		PlayerTextDrawShow(playerid, INVTD[playerid][17]);
		PlayerTextDrawShow(playerid, INVTD[playerid][18]);
		PlayerTextDrawShow(playerid, INVTD[playerid][19]);
		PlayerTextDrawShow(playerid, INVTD[playerid][20]);
		PlayerTextDrawShow(playerid, INVTD[playerid][21]);
		PlayerTextDrawShow(playerid, INVTD[playerid][22]);
		PlayerTextDrawShow(playerid, INVTD[playerid][23]);
		PlayerTextDrawShow(playerid, INVTD[playerid][24]);
		PlayerTextDrawShow(playerid, INVTD[playerid][25]);*/




		switch(playerData[playerid][pColor]) 
		{
			case 0: // Green
			{
				PlayerTextDrawColor(playerid, INVTD[playerid][23], 9109759);

				PlayerTextDrawBoxColor(playerid, INVTD[playerid][2], 9109704);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][3], 9109704);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][4], 9109704);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][5], 9109704);

				PlayerTextDrawBoxColor(playerid, INVTD[playerid][8], 9109704);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][9], 9109704);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][10], 9109704);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][11], 9109704);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][12], 9109704);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][13], 9109704);
			}
			case 1: // ��
			{
				PlayerTextDrawColor(playerid, INVTD[playerid][23], 1852731135);

				PlayerTextDrawBoxColor(playerid, INVTD[playerid][2], 1852731135);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][3], 1852731135);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][4], 1852731135);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][5], 1852731135);

				PlayerTextDrawBoxColor(playerid, INVTD[playerid][8], 1852731135);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][9], 1852731135);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][10], 1852731135);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][11], 1852731135);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][12], 1852731135);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][13], 1852731135);
			}
			case 2: // ��ᴧ
			{
				PlayerTextDrawColor(playerid, INVTD[playerid][23], -16776961);
				
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][2], -16776961);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][3], -16776961);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][4], -16776961);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][5], -16776961);

				PlayerTextDrawBoxColor(playerid, INVTD[playerid][8], -16776961);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][9], -16776961);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][10], -16776961);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][11], -16776961);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][12], -16776961);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][13], -16776961);
			}
			case 3: // ��ᴧ��͹
			{
				PlayerTextDrawColor(playerid, INVTD[playerid][23], -10270721);
				
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][2], -10270721);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][3], -10270721);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][4], -10270721);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][5], -10270721);

				PlayerTextDrawBoxColor(playerid, INVTD[playerid][8], -10270721);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][9], -10270721);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][10], -10270721);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][11], -10270721);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][12], -10270721);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][13], -10270721);
			}
			case 4: // �տ����͹
			{
				PlayerTextDrawColor(playerid, INVTD[playerid][23], 1992556543);
				
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][2], 1992556543);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][3], 1992556543);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][4], 1992556543);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][5], 1992556543);

				PlayerTextDrawBoxColor(playerid, INVTD[playerid][8], 1992556543);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][9], 1992556543);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][10], 1992556543);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][11], 1992556543);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][12], 1992556543);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][13], 1992556543);
			}
			case 5: // �տ�����
			{
				PlayerTextDrawColor(playerid, INVTD[playerid][23], 328515583);
				
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][2], 328515583);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][3], 328515583);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][4], 328515583);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][5], 328515583);

				PlayerTextDrawBoxColor(playerid, INVTD[playerid][8], 328515583);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][9], 328515583);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][10], 328515583);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][11], 328515583);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][12], 328515583);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][13], 328515583);
			}
			case 6: // �ժ�����͹
			{
				PlayerTextDrawColor(playerid, INVTD[playerid][23], -8224001);
				
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][2],  -8224001);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][3],  -8224001);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][4],  -8224001);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][5],  -8224001);

				PlayerTextDrawBoxColor(playerid, INVTD[playerid][8], -8224001);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][9], -8224001);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][10], -8224001);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][11], -8224001);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][12], -8224001);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][13], -8224001);
			}
			case 7: // �ժ������
			{
				PlayerTextDrawColor(playerid, INVTD[playerid][23], -16711681);
				
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][2], -16711681);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][3], -16711681);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][4], -16711681);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][5], -16711681);

				PlayerTextDrawBoxColor(playerid, INVTD[playerid][8], -16711681);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][9], -16711681);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][10], -16711681);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][11], -16711681);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][12], -16711681);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][13], -16711681);
			}
			case 8: // ����ǧ
			{
				PlayerTextDrawColor(playerid, INVTD[playerid][23], -1920073729);
				
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][2], -1920073729);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][3], -1920073729);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][4], -1920073729);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][5], -1920073729);

				PlayerTextDrawBoxColor(playerid, INVTD[playerid][8], -1920073729);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][9], -1920073729);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][10], -1920073729);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][11], -1920073729);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][12], -1920073729);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][13], -1920073729);
			}
			case 9: // �����
			{
				PlayerTextDrawColor(playerid, INVTD[playerid][23], -5747201);
				
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][2], -5747201);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][3], -5747201);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][4], -5747201);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][5], -5747201);

				PlayerTextDrawBoxColor(playerid, INVTD[playerid][8], -5747201);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][9], -5747201);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][10], -5747201);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][11], -5747201);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][12], -5747201);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][13], -5747201);
			}
			case 10: // ������ͧ
			{
				PlayerTextDrawColor(playerid, INVTD[playerid][23], -65281);
				
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][2], -65281);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][3], -65281);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][4], -65281);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][5], -65281);

				PlayerTextDrawBoxColor(playerid, INVTD[playerid][8], -65281);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][9], -65281);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][10], -65281);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][11], -65281);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][12], -65281);
				PlayerTextDrawBoxColor(playerid, INVTD[playerid][13], -65281);
			}
		}
		if(playerData[playerid][pColor] < 0 || playerData[playerid][pColor] > 10)
		{
			PlayerTextDrawColor(playerid, INVTD[playerid][23], playerData[playerid][pColor] >>> 8);
			
			PlayerTextDrawBoxColor(playerid, INVTD[playerid][2], playerData[playerid][pColor] >>> 8);
			PlayerTextDrawBoxColor(playerid, INVTD[playerid][3], playerData[playerid][pColor] >>> 8);
			PlayerTextDrawBoxColor(playerid, INVTD[playerid][4], playerData[playerid][pColor] >>> 8);
			PlayerTextDrawBoxColor(playerid, INVTD[playerid][5], playerData[playerid][pColor] >>> 8);

			PlayerTextDrawBoxColor(playerid, INVTD[playerid][8], playerData[playerid][pColor] >>> 8);
			PlayerTextDrawBoxColor(playerid, INVTD[playerid][9], playerData[playerid][pColor] >>> 8);
			PlayerTextDrawBoxColor(playerid, INVTD[playerid][10], playerData[playerid][pColor] >>> 8);
			PlayerTextDrawBoxColor(playerid, INVTD[playerid][11], playerData[playerid][pColor] >>> 8);
			PlayerTextDrawBoxColor(playerid, INVTD[playerid][12], playerData[playerid][pColor] >>> 8);
			PlayerTextDrawBoxColor(playerid, INVTD[playerid][13], playerData[playerid][pColor] >>> 8);
		}
		for(new i = 0; i != 29; ++i)
		{
			PlayerTextDrawShow(playerid, INVTD[playerid][i]);
		}
		SelectTextDraw(playerid, 0xFFFFFFFF);
	}
	else 
	{
		for(new i = 0; i != 29; ++i)
		{
			PlayerTextDrawHide(playerid, INVTD[playerid][i]);
		}

		playerData[playerid][INV] = 0;
		HideModelSelectionMenu(playerid);
		CancelSelectTextDraw(playerid);
	}
	return 1;
}
Dialog:DIALOG_INV_SKIN(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0: // 
			{		
				PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
				SendClientMessage(playerid, COLOR_LIGHTRED, "- ���Ѿഷ...");
			}
			case 1: // 
			{	
				PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
				SendClientMessage(playerid, COLOR_LIGHTRED, "- ���Ѿഷ...");
			}
		}
	}
	else{
		ShowPlayerInventory(playerid, true);
	}
	return 1;
}


Dialog:SKIN_TYPE_SELECT(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0: //������
			{
				SetPlayerSkin(playerid, playerData[playerid][pSkins]);
				SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
				ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
				PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
				return 1;
			}
		}
	}
	return 1;
}

Dialog:DIALOG_INV_COLOR(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		switch(listitem)
		{
			case 0: playerData[playerid][pColor] = 0;
			case 1: playerData[playerid][pColor] = 1;
			case 2: playerData[playerid][pColor] = 2;
			case 3: playerData[playerid][pColor] = 3;
			case 4: playerData[playerid][pColor] = 4;
			case 5: playerData[playerid][pColor] = 5;
			case 6: playerData[playerid][pColor] = 6;
			case 7: playerData[playerid][pColor] = 7;
			case 8: playerData[playerid][pColor] = 8;
			case 9: playerData[playerid][pColor] = 9;
			case 10: playerData[playerid][pColor] = 10;
			case 11: Dialog_Show(playerid, DIALOG_CODE_COLOR, DIALOG_STYLE_INPUT, "[Edit COlor]", "�ô�к����շ��س��ͧ��� [���ٻẺ hex]", "���͡", "¡��ԡ");
		}
	}
	return 1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(playertextid == INVTD[playerid][18]) // x
	{
		ShowPlayerINV(playerid, false);
		return 1;
	}

	if(playertextid == INVTD[playerid][15]) // Weapon
	{
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);

		return 1;
	}
	if(playertextid == INVTD[playerid][16]) // object
	{
		Dialog_Show(playerid, DIALOG_INV_SKIN, DIALOG_STYLE_LIST, "[Edit Character]", "{FFFFFF}- ��ǡ/˹�ҡҡ (Head)\n\
		- ����͡��/���� (Body)\n\
		", "���͡", "¡��ԡ");

		ShowPlayerINV(playerid, false);
		return 1;
	}
	if(playertextid == INVTD[playerid][17]) // skin
	{
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);

		new string[128];
		format(string, sizeof(string), "Skin:%d", playerData[playerid][pSkins]);

		if(playerData[playerid][pSkins] == 289 || playerData[playerid][pSkins] == 191)
			return 1;
			
		new id = Inventory_Add(playerid, string, 1);

		if (id == -1)
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

		if(playerData[playerid][pGender] == 1) 
		{
			playerData[playerid][pSkins] = 289;
			SetPlayerSkin(playerid, 289);
		}
		if(playerData[playerid][pGender] == 2) 
		{
			playerData[playerid][pSkins] = 191;
			SetPlayerSkin(playerid, 191);
		}
		PlayerTextDrawSetPreviewModel(playerid, INVTD[playerid][17], 1275);
		ShowPlayerINV(playerid, false);
		SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
		ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		return 1;

	}

	if(playertextid == INVTD[playerid][19]) // C
	{
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		Dialog_Show(playerid, DIALOG_INV_COLOR, DIALOG_STYLE_LIST, "{FFFFFF}[Inventory Color]", "\
		{00FF00}- ������\n\
		{6E6E6E}- ����\n\
		{FF0000}- ��ᴧ\n\
		{FF6347}- ��ᴧ��͹\n\
		{76C3FF}- �տ����͹\n\
		{1394BF}- �տ�����\n\
		{FF8282}- �ժ�����͹\n\
		{FF00FF}- �ժ������\n\
		{8D8DFF}- ����ǧ\n\
		{FFA84D}- �����\n\
		{FFFF00}- ������ͧ\n\
		{FFFFFF}�к�����:"\
		, "���͡", "¡��ԡ");
		ShowPlayerINV(playerid, false);
		return 1;
	}
	if(playertextid == INVTD[playerid][22]) // ->
	{
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		new str[12], List:inv = list_new(), var[32], count = 0;
		if(playerData[playerid][pInventoryPage] == 3)
			return 1;

		/*if(playerData[playerid][pMaxItem] <= 20)
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory Page]: �س���繵�ͧ�Ѿ�����ء����� ������ҹ");*/

		/*if(Inventory_Items(playerid) <= 20)
			return 1;*/

		playerData[playerid][pInventoryPage] ++;
		if(playerData[playerid][pInventoryPage] == 1)
		{
			format(str, sizeof(str), "%d", playerData[playerid][pInventoryPage]);
			PlayerTextDrawSetString(playerid, INVTD[playerid][23], str);
			for (new i = 20; i < playerData[playerid][pMaxItem]; i ++)
			{
				if (invData[playerid][i][invExists])
				{
					new id_item = Inventory_GetItemIDFromItemName(invData[playerid][i][invItem]), amount[12];
					format(amount, sizeof(amount), "%d/%d", invData[playerid][i][invQuantity], playerData[playerid][pItemAmount]);
					AddModelMenuItem(inv, itemData[id_item][itemModel], amount, false, 0.0, 0.0, 0.0, 0.5);
					format(var, sizeof(var), "itemlist%d", count);
					SetPVarInt(playerid, var, i);
					count++;
				}
			}
		}
		if(playerData[playerid][pInventoryPage] == 2)
		{
			format(str, sizeof(str), "%d", playerData[playerid][pInventoryPage]);
			PlayerTextDrawSetString(playerid, INVTD[playerid][23], str);
			for (new i = 40; i < playerData[playerid][pMaxItem]; i ++)
			{
				if (invData[playerid][i][invExists])
				{
					new id_item = Inventory_GetItemIDFromItemName(invData[playerid][i][invItem]), amount[12];
					format(amount, sizeof(amount), "%d/%d", invData[playerid][i][invQuantity], playerData[playerid][pItemAmount]);
					AddModelMenuItem(inv, itemData[id_item][itemModel], amount, false, 0.0, 0.0, 0.0, 0.5);
					format(var, sizeof(var), "itemlist%d", count);
					SetPVarInt(playerid, var, i);
					count++;
				}
			}
		}
		if(playerData[playerid][pInventoryPage] == 3)
		{
			format(str, sizeof(str), "%d", playerData[playerid][pInventoryPage]);
			PlayerTextDrawSetString(playerid, INVTD[playerid][23], str);
			for (new i = 60; i < playerData[playerid][pMaxItem]; i ++)
			{
				if (invData[playerid][i][invExists])
				{
					new id_item = Inventory_GetItemIDFromItemName(invData[playerid][i][invItem]), amount[12];
					format(amount, sizeof(amount), "%d/%d", invData[playerid][i][invQuantity], playerData[playerid][pItemAmount]);
					AddModelMenuItem(inv, itemData[id_item][itemModel], amount, false, 0.0, 0.0, 0.0, 0.5);
					format(var, sizeof(var), "itemlist%d", count);
					SetPVarInt(playerid, var, i);
					count++;
				}
			}
		}
		ShowModelSelectionMenu(playerid, MODEL_SELECTION_INVENTORY, inv);
		//ShowPlayerINV(playerid, false);
		return 1;
	}
	if(playertextid == INVTD[playerid][26]) // <-
	{	
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		new str[12], List:inv = list_new(), var[32], count = 0;
		if(playerData[playerid][pInventoryPage] <= 0)
			return 1;

		playerData[playerid][pInventoryPage] --;

		if(playerData[playerid][pInventoryPage] == 0)
		{
			format(str, sizeof(str), "%d", playerData[playerid][pInventoryPage]);
			PlayerTextDrawSetString(playerid, INVTD[playerid][23], str);
			for (new i = 0; i < playerData[playerid][pMaxItem]; i ++)
			{
				if (invData[playerid][i][invExists])
				{
					new id_item = Inventory_GetItemIDFromItemName(invData[playerid][i][invItem]), amount[12];
					format(amount, sizeof(amount), "%d/%d", invData[playerid][i][invQuantity], playerData[playerid][pItemAmount]);
					AddModelMenuItem(inv, itemData[id_item][itemModel], amount, false, 0.0, 0.0, 0.0, 0.5);
					format(var, sizeof(var), "itemlist%d", count);
					SetPVarInt(playerid, var, i);
					count++;
				}
			}
		}
		if(playerData[playerid][pInventoryPage] == 1)
		{
			format(str, sizeof(str), "%d", playerData[playerid][pInventoryPage]);
			PlayerTextDrawSetString(playerid, INVTD[playerid][23], str);
			for (new i = 20; i < playerData[playerid][pMaxItem]; i ++)
			{
				if (invData[playerid][i][invExists])
				{
					new id_item = Inventory_GetItemIDFromItemName(invData[playerid][i][invItem]), amount[12];
					format(amount, sizeof(amount), "%d/%d", invData[playerid][i][invQuantity], playerData[playerid][pItemAmount]);
					AddModelMenuItem(inv, itemData[id_item][itemModel], amount, false, 0.0, 0.0, 0.0, 0.5);
					format(var, sizeof(var), "itemlist%d", count);
					SetPVarInt(playerid, var, i);
					count++;
				}
			}
		}
		if(playerData[playerid][pInventoryPage] == 2)
		{
			format(str, sizeof(str), "%d", playerData[playerid][pInventoryPage]);
			PlayerTextDrawSetString(playerid, INVTD[playerid][23], str);
			for (new i = 40; i < playerData[playerid][pMaxItem]; i ++)
			{
				if (invData[playerid][i][invExists])
				{
					new id_item = Inventory_GetItemIDFromItemName(invData[playerid][i][invItem]), amount[12];
					format(amount, sizeof(amount), "%d/%d", invData[playerid][i][invQuantity], playerData[playerid][pItemAmount]);
					AddModelMenuItem(inv, itemData[id_item][itemModel], amount, false, 0.0, 0.0, 0.0, 0.5);
					format(var, sizeof(var), "itemlist%d", count);
					SetPVarInt(playerid, var, i);
					count++;
				}
			}
		}
		if(playerData[playerid][pInventoryPage] == 3)
		{
			format(str, sizeof(str), "%d", playerData[playerid][pInventoryPage]);
			PlayerTextDrawSetString(playerid, INVTD[playerid][23], str);
			for (new i = 60; i < playerData[playerid][pMaxItem]; i ++)
			{
				if (invData[playerid][i][invExists])
				{
					new id_item = Inventory_GetItemIDFromItemName(invData[playerid][i][invItem]), amount[12];
					format(amount, sizeof(amount), "%d/%d", invData[playerid][i][invQuantity], playerData[playerid][pItemAmount]);
					AddModelMenuItem(inv, itemData[id_item][itemModel], amount, false, 0.0, 0.0, 0.0, 0.5);
					format(var, sizeof(var), "itemlist%d", count);
					SetPVarInt(playerid, var, i);
					count++;
				}
			}
		}
		ShowModelSelectionMenu(playerid, MODEL_SELECTION_INVENTORY, inv);
	}
	if(playertextid == INVTD[playerid][8]) // MENU
	{
		SendClientMessageEx(playerid, COLOR_ORANGE, "SAMP {FFFFFF}: {00FF00}Black Woods{FFFFFF}: ����ö��ҹ���������� {8D8DFF}Discord {FFFFFF}�ͧ��������� � ��ͧ {FFA84D}'#Tutorial'");
		SendClientMessageEx(playerid, COLOR_WHITE, "Link: {8D8DFF}https://discord.gg/Vn29uj3gYy");

		Dialog_Show(playerid, INV_MENU, DIALOG_STYLE_TABLIST_HEADERS, "Menu", "��¡�õ�ҧ�{FFFFFF}\n\
		\
		", "���͡", "¡��ԡ");

		ShowPlayerINV(playerid, false);
		return 1;
	}
	if(playertextid == INVTD[playerid][9]) // Anim
	{
		Dialog_Show(playerid, D_Animlist, DIALOG_STYLE_TABLIST, "Animations", "{FFFFFF}¡��ԡ��ҷҧ\n>> ¡���\n>> �����͡�����\n>> �Ҵ��\n>> ������\n\
		>> �͹˧��˹��\n>> �͹����˹��\n>> �ʹ͡\n>> ���ٴ\n>> ���������\n>> ⺡ö(����)\n>> ⺡ö(���)\n>> �ٴ������\n>> �ԧ��ᾧ\n>> ��ҷ��\n- �������...\
		", "���͡", "�͡");
		ShowPlayerINV(playerid, false);
		return 1;
	}
	if(playertextid == INVTD[playerid][10]) // GPS
	{
		callcmd::gps(playerid, "\1");
		ShowPlayerINV(playerid, false);
		return 1;
	}
	if(playertextid == INVTD[playerid][11]) // Donate
	{
		Dialog_Show(playerid, Donate, DIALOG_STYLE_TABLIST, "Donate", "{FFFFFF}> ������ (Inventory)\n\
		> ��Ѥ���Ҫԡ (Menber)\n\
		> Ὺ�� (Fashion)\n\
		> �Ҫ� (Gacha)\n\
		", "���͡", "�͡");
		ShowPlayerINV(playerid, false);
		return 1;
	}
	if(playertextid == INVTD[playerid][12]) // Jobs
	{
		
		new
			count,
			var[32],
			string[4096],
			string2[4096];
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		
		for (new i = 0; i != MAX_GPS; i ++) if (gpsData[i][gpsExists])
		{
			if(gpsData[i][gpsType] == 5)
			{
				format(string, sizeof(string), "%s\t{FFA84D}(%.0f ����)\n", gpsData[i][gpsName], GetPlayerDistanceFromPoint(playerid, gpsData[i][gpsPosX], gpsData[i][gpsPosY], gpsData[i][gpsPosZ]));
				strcat(string2, string);
				format(var, sizeof(var), "GPSID%d", count);
				SetPVarInt(playerid, var, i);
				count++;
			}
		}
		if (!count)
		{
			SendClientMessage(playerid, COLOR_LIGHTRED, "- ��辺�� Jobs ���س���ѧ����");
			ShowPlayerINV(playerid, false);
			return 1;
		}
		format(string, sizeof(string), "��ª��ͧҹ\t���зҧ\n%s", string2);
		Dialog_Show(playerid, DIALOG_GPSPICK, DIALOG_STYLE_TABLIST_HEADERS, "��ª��ͧҹ", string, "���͡", "�Դ");

		ShowPlayerINV(playerid, false);
		return 1;
	}
	if(playertextid == INVTD[playerid][13]) // Stats
	{
		PlayerStats(playerid);
		ShowPlayerINV(playerid, false);
		return 1;
	}

	if(playertextid == INVTD[playerid][27]) // $ᴧ
	{
		new
			string[128],
			string2[4096],
			var[15],
			count;
		ShowPlayerINV(playerid, false);

		if (GetPlayerRedMoney(playerid) <= 0)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ���㹵�Ǣͧ�س������Թ�Դ������");

		if (playerData[playerid][pHours] < 10)
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �س���繵�ͧ����ҡ���� 10 ��������͹�Ź�");

		foreach (new  i : Player)
		{
			if (i == playerid) continue;
			if (IsPlayerNearPlayer(playerid, i, 2.0))
			{
				format(string, sizeof(string), "(id: %d)\t%s\n", i, GetPlayerNameEx(i));
				strcat(string2, string);
				format(var, sizeof(var), "PayIllegal%d", count);
				SetPVarInt(playerid, var, i);
				count++;
			}
		}
		if (!count)
		{
			
			Dialog_Show(playerid, Paymoneyerorr, DIALOG_STYLE_LIST, "GiveMoney(Illegal)", "{FFFFFF}- ��辺�������������ǳ�ͺ� ��Ǣͧ�س","�Դ","");
			return 1;
		}
		format(string, sizeof(string), " �ʹ�\t    ��ª���\n%s", string2);
		Dialog_Show(playerid, Pay_RedMoney, DIALOG_STYLE_TABLIST_HEADERS, "GiveMoney(Illegal)", string, "���͡", "¡��ԡ");
		return 1;
	}
	if(playertextid == INVTD[playerid][21]) // $ ����
	{
		new
			string[128],
			string2[4096],
			var[15],
			count;
		ShowPlayerINV(playerid, false);

		if (GetPlayerMoneyEx(playerid) <= 0)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ���㹵�Ǣͧ�س������Թ");

		if (playerData[playerid][pHours] < 5)
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �س���繵�ͧ����ҡ���� 5 ��������͹�Ź�");

		foreach (new  i : Player)
		{
			if (i == playerid) continue;
			if (IsPlayerNearPlayer(playerid, i, 2.0))
			{
				format(string, sizeof(string), "(id: %d)\t%s\n", i, GetPlayerNameEx(i));
				strcat(string2, string);
				format(var, sizeof(var), "Pay%d", count);
				SetPVarInt(playerid, var, i);
				count++;
			}
		}
		if (!count)
		{
			
			Dialog_Show(playerid,Paymoneyerorr,DIALOG_STYLE_LIST,"Give Money","{FFFFFF}- ��辺�������������ǳ�ͺ� ��Ǣͧ�س","�Դ","");
			return 1;
		}
		format(string, sizeof(string), " �ʹ�\t    ��ª���\n%s", string2);
		Dialog_Show(playerid, Pay_Money, DIALOG_STYLE_TABLIST_HEADERS, "GiveMoney(Cash)", string, "���͡", "¡��ԡ");
		return 1;
	}
	return 1;
}

Dialog:DIALOG_CODE_COLOR(playerid, response, listitem, inputtext[])
{
	new color;
	if (response)
	{
		if (sscanf(inputtext, "h", color))
			return Dialog_Show(playerid, DIALOG_CODE_COLOR, DIALOG_STYLE_INPUT, "[Edit COlor]", "�ô�к����շ��س��ͧ��� [���ٻẺ hex]", "���͡", "¡��ԡ");
		
		playerData[playerid][pColor] = color;
		SendClientMessageEx(playerid, COLOR_YELLOW," [Inventory]: �س������¹�ա����Ңͧ�س���� {%06x}|||||{FFFF00} ���º����", color >>> 8);
	}
	return 1;
}
Dialog:Pay_RedMoney(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new var[15];
		format(var, sizeof(var), "PayIllegal%d", listitem);
		new userid = GetPVarInt(playerid, var);
		Dialog_Show(playerid, Player_Pay_RedMoney, DIALOG_STYLE_INPUT, "GiveMoney(Illegal)", "�س���Թ�Դ����������: %s\n(ID: %d) %s\n�ô�кبӹǹ�Թ����ͧ������", "��ŧ", "¡��ԡ", FormatMoney(GetPlayerRedMoney(playerid)), userid, GetPlayerNameEx(userid));
		playerData[playerid][pPayMoneyID] = userid;	
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);	
	}
}
Dialog:Pay_Money(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new var[15];
		format(var, sizeof(var), "Pay%d", listitem);
		new userid = GetPVarInt(playerid, var);
		Dialog_Show(playerid, Player_Pay_Money, DIALOG_STYLE_INPUT, "GiveMoney(Cash)", "�س���Թ����: %s\n(ID: %d) %s\n�ô�кبӹǹ�Թ����ͧ������", "��ŧ", "¡��ԡ", FormatMoney(GetPlayerMoneyEx(playerid)), userid, GetPlayerNameEx(userid));
		playerData[playerid][pPayMoneyID] = userid;	
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);	
	}
}
Dialog:Donate(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0: Dialog_Show(playerid, Donate_Inv, DIALOG_STYLE_LIST, "������ (Inventory)", "{FFFFFF}\
			- �ӹǹ�����آͧ������\n\
			- �ӹǹ�����آͧ����", "���͡", "¡��ԡ");
		}
	}
	return 1;
}
Dialog:Donate_Inv(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0: 
			{
			Dialog_Show(playerid, Donate_Inv_MaxItem, DIALOG_STYLE_TABLIST_HEADERS, "������ (Inventory)", "��¡��\t�Ҥ�{FFFFFF}\n\
			{FFA84D}- Level 1 (40 ��ͧ)\t{FFFF00}50 {f58320}Wallet\n\
			{FFA84D}- Level 2 (60 ��ͧ)\t{FFFF00}50 {f58320}Wallet\n\
			{FFA84D}- Level 3 (80 ��ͧ)\t{FFFF00}50 {f58320}Wallet\
			", "���͡", "¡��ԡ");
			}
			case 1:
			{
				Dialog_Show(playerid, Donate_Inv_Quantity, DIALOG_STYLE_TABLIST_HEADERS, "������ (Inventory)", "��¡��\t�Ҥ�{FFFFFF}\n\
				{FFA84D}- Level 1 (50 ���)\t{FFFF00}50 {f58320}Wallet\n\
				{FFA84D}- Level 2 (100 ���)\t{FFFF00}50 {f58320}Wallet\n\
				{FFA84D}- Level 3 (150 ���)\t{FFFF00}50 {f58320}Wallet\
				", "���͡", "¡��ԡ");
			}
		}
	}
	return 1;
}
Dialog:Donate_Inv_Quantity(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0: 
			{
				if(playerData[playerid][pCoin] < 50)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: �س�ըӹǹ Wallet �����§�� (%d/50)", playerData[playerid][pCoin]);

				if(playerData[playerid][pItemAmount] > 50)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: �س���Ѿ�ô�ӹǹ�����آͧ���� 'Level 1' ���º��������");

				playerData[playerid][pItemAmount] = 50;
				GivePlayerWelletEx(playerid, -50);
				SendClientMessage(playerid, COLOR_GREEN, "[Inventory]: �س���Ѿ�ô�ӹǹ�����آͧ���� 'Level 1' ���º��������");
			}
			case 1: 
			{
				if(playerData[playerid][pCoin] < 50)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: �س�ըӹǹ Wallet �����§�� (%d/50)", playerData[playerid][pCoin]);

				if(playerData[playerid][pItemAmount] < 50)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: �س���繵�ͧ�Ѿ�ô�ӹǹ�����آͧ���� 'Level 1' ��͹");

				if(playerData[playerid][pItemAmount] > 100)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: �س���Ѿ�ô�ӹǹ�����آͧ���� 'Level 2' ���º��������");

				playerData[playerid][pItemAmount] = 100;
				GivePlayerWelletEx(playerid, -50);
				SendClientMessageEx(playerid, COLOR_GREEN, "[Inventory]: �س���Ѿ�ô�ӹǹ�����آͧ���� 'Level 2' ���º��������");
			}
			case 2: 
			{
				if(playerData[playerid][pCoin] < 50)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: �س�ըӹǹ Wallet �����§�� (%d/50)", playerData[playerid][pCoin]);

				if(playerData[playerid][pMaxItem] < 100)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: �س���繵�ͧ�Ѿ�ô�ӹǹ�����آͧ���� 'Level 2' ��͹");

				if(playerData[playerid][pMaxItem] >= 150)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: �س���Ѿ�ô�ӹǹ�����آͧ��������ӹǹ����");


				playerData[playerid][pItemAmount] = 100;
				GivePlayerWelletEx(playerid, -50);
				SendClientMessageEx(playerid, COLOR_GREEN, "[Inventory]: �س���Ѿ�ô�ӹǹ�����آͧ���� 'Level 3' ���º��������");
			}
		}
	}
	return 1;
}
Dialog:Donate_Inv_MaxItem(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0: 
			{
				if(playerData[playerid][pCoin] < 50)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: �س�ըӹǹ Wallet �����§�� (%d/50)", playerData[playerid][pCoin]);

				if(playerData[playerid][pMaxItem] > 20)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: �س���Ѿ�ô�ӹǹ�����آͧ������ 'Level 1' ���º��������");

				playerData[playerid][pMaxItem] = 40;
				GivePlayerWelletEx(playerid, -50);
				SendClientMessageEx(playerid, COLOR_GREEN, "[Inventory]: �س���Ѿ�ô�ӹǹ�����آͧ������ 'Level 1' ���º��������");
			}
			case 1: 
			{
				if(playerData[playerid][pCoin] < 50)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: �س�ըӹǹ Wallet �����§�� (%d/50)", playerData[playerid][pCoin]);

				if(playerData[playerid][pMaxItem] < 40)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: �س���繵�ͧ�Ѿ�ô�ӹǹ�����آͧ������ 'Level 1' ��͹");

				if(playerData[playerid][pMaxItem] > 60)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: �س���Ѿ�ô�ӹǹ�����آͧ������ 'Level 2' ���º��������");


				playerData[playerid][pMaxItem] = 60;
				GivePlayerWelletEx(playerid, -50);
				SendClientMessageEx(playerid, COLOR_GREEN, "[Inventory]: �س���Ѿ�ô�ӹǹ�����آͧ������ 'Level 2' ���º��������");
			}
			case 2: 
			{
				if(playerData[playerid][pCoin] < 50)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: �س�ըӹǹ Wallet �����§�� (%d/50)", playerData[playerid][pCoin]);

				if(playerData[playerid][pMaxItem] < 60)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: �س���繵�ͧ�Ѿ�ô�ӹǹ�����آͧ������ 'Level 2' ��͹");

				if(playerData[playerid][pMaxItem] >= 80)
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: �س���Ѿ�ô�ӹǹ�����آͧ����������ӹǹ����");


				playerData[playerid][pMaxItem] = 80;
				GivePlayerWelletEx(playerid, -50);
				SendClientMessageEx(playerid, COLOR_GREEN, "[Inventory]: �س���Ѿ�ô�ӹǹ�����آͧ������ 'Level 3' ���º��������");
			}
		}
	}
	return 1;
}
Dialog:Player_Pay_Money(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext),
	userid = playerData[playerid][pPayMoneyID];

	if (response)
	{

		if (amount < 0)
			return Dialog_Show(playerid, Player_Pay_Money, DIALOG_STYLE_INPUT, "GiveMoney(Cash)", "�س���Թ����: %s\n(ID: %d) %s\n�ô�кبӹǹ�Թ����ͧ������", "��ŧ", "¡��ԡ", FormatMoney(GetPlayerMoneyEx(playerid)), userid, GetPlayerNameEx(userid));

		if (amount > GetPlayerMoneyEx(playerid))
			return Dialog_Show(playerid, Player_Pay_Money, DIALOG_STYLE_INPUT, "GiveMoney(Cash)", "�س���Թ����: %s\n(ID: %d) %s\n�ô�кبӹǹ�Թ����ͧ������ {FF6347}*�ӹǹ�Թ���㹵�Ǣͧ�س����������§��", "��ŧ", "¡��ԡ", FormatMoney(GetPlayerMoneyEx(playerid)), userid, GetPlayerNameEx(userid));

		if (!IsPlayerNearPlayer(playerid, userid, 5.0))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ������������������Ѻ�س");

		if (playerData[userid][pHours] < 5)
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �����蹷��س��ͧ��������繵�ͧ�ժ�������͹�Ź��ҡ���� 5 �������");

		GivePlayerMoneyEx(playerid, -amount);
		GivePlayerMoneyEx(userid, amount);
		PlayerPlaySound(playerid, 31000, 0.0, 0.0, 0.0);
		PlayerPlaySound(userid, 31000, 0.0, 0.0, 0.0);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ����Ժ�Թ�ӹǹ '%s' �ҡ���������������Ѻ %s", GetPlayerNameEx(playerid), FormatMoney(amount), GetPlayerNameEx(userid));
	}
	return 1;
}
Dialog:Player_Pay_RedMoney(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext),
	userid = playerData[playerid][pPayMoneyID];

	if (response)
	{

		if (amount < 0)
			return Dialog_Show(playerid, Player_Pay_RedMoney, DIALOG_STYLE_INPUT, "GiveMoney(Illegal)", "�س���Թ�Դ����������: %s\n(ID: %d) %s\n�ô�кبӹǹ�Թ����ͧ������", "��ŧ", "¡��ԡ", FormatMoney(GetPlayerRedMoney(playerid)), userid, GetPlayerNameEx(userid));

		if (amount > GetPlayerMoneyEx(playerid))
			return Dialog_Show(playerid, Player_Pay_RedMoney, DIALOG_STYLE_INPUT, "GiveMoney(Illegal)", "�س���Թ�Դ����������: %s\n(ID: %d) %s\n�ô�кبӹǹ�Թ����ͧ������ {FF6347}*�ӹǹ�Թ���㹵�Ǣͧ�س����������§��", "��ŧ", "¡��ԡ", FormatMoney(GetPlayerRedMoney(playerid)), userid, GetPlayerNameEx(userid));

		if (!IsPlayerNearPlayer(playerid, userid, 5.0))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ������������������Ѻ�س");

		if (playerData[userid][pHours] < 10)
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "- �����蹷��س��ͧ��������繵�ͧ�ժ�������͹�Ź��ҡ���� 10 �������");

		GivePlayerRedMoney(playerid, -amount);
		GivePlayerRedMoney(userid, amount);
		PlayerPlaySound(playerid, 31000, 0.0, 0.0, 0.0);
		PlayerPlaySound(userid, 31000, 0.0, 0.0, 0.0);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ����Ժ�Թ�Դ�����¨ӹǹ '%s' �ҡ���������������Ѻ %s", GetPlayerNameEx(playerid), FormatMoney(amount), GetPlayerNameEx(userid));
	}
	return 1;
}


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_CTRL_BACK && GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
		new
			id = GetNearbyVehicle(playerid),
			FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper;

		GetVehiclePanelsDamageStatus(id, FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper);

		if(playerData[playerid][INV] == 0)
		{
			if (playerData[playerid][pJailTime] > 0 || playerData[playerid][pCuffed] > 0)
				return 1;

			if (playerData[playerid][pInjured] || playerData[playerid][pJailTime] > 0)
				return 1;

			if (ProgressState[playerid] == 1 || playerData[playerid][pIncomingCalling] == 1)
				return 1;
				
			if (StartFishing[playerid] == true || StartApple[playerid] == true || StartCrate[playerid] == true) //�ҹ
				return 1;


			if(IsPlayerNearBoot(playerid, id) && GetFactionType(playerid) == FACTION_POLICE) //�ԡ���ظ��ѧö
			{		
				new string[32];
				if (GetTrunkStatus(id) && IsAPoliceVehicle(id))
				{
					format(string, sizeof(string), "%s", ReturnVehicleName(id));
					Dialog_Show(playerid, DIALOG_TrunkPolice, DIALOG_STYLE_LIST, string, "{FFFFFF}- Desert Eagle (50)\n- M4 (100)", "���͡", "�Դ");
					PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
				}
				return 1;
			}

			SetPlayerChatBubble(playerid, "** �Դ��������ҹ", COLOR_PURPLE, 5.0, 5000);
			playerData[playerid][INV] = 1;
			ShowPlayerInventory(playerid, true);
			return 1;
		}
		if(playerData[playerid][INV] == 1)
		{
			ShowPlayerInventory(playerid, false);
			return 1;
		}
	}
	if (newkeys & KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
		new
			id = Item_Nearest(playerid);

		if (id != -1)
			return PickupItem(playerid, id);


	}
	return 1;
}

PickupItem(playerid, itemid)
{
	new count = Inventory_Count(playerid, DroppedItems[itemid][droppedItem]);
	if (itemid != -1 && DroppedItems[itemid][droppedModel])
	{

		if(DroppedItems[itemid][droppedAmount] > playerData[playerid][pItemAmount]-count)
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", DroppedItems[itemid][droppedItem]);

		if (count >= playerData[playerid][pItemAmount])
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �������ö�� '%s' ���ա���ͧ�ҡ �ӹǹ㹡����Ңͧ�س����������!", DroppedItems[itemid][droppedItem]);

	    new id = Inventory_Add(playerid, DroppedItems[itemid][droppedItem], DroppedItems[itemid][droppedAmount]);

	    if (id == -1)
	       	return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory] �����آͧ�����Ңͧ�س���������� (( %d/%d ))", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

		new
			count1 = 0,
			string[128];

		if (id != -1)
		{
			string = "";

			for (new i = 0; i < MAX_DROPPED_ITEMS; i ++) if (count1 < MAX_LISTED_ITEMS && DroppedItems[i][droppedModel] && IsPlayerInRangeOfPoint(playerid, 1.5, DroppedItems[i][droppedPos][0], DroppedItems[i][droppedPos][1], DroppedItems[i][droppedPos][2]) && GetPlayerInterior(playerid) == DroppedItems[i][droppedInt] && GetPlayerVirtualWorld(playerid) == DroppedItems[i][droppedWorld]) {
				NearestItems[playerid][count1++] = i;

				strcat(string, DroppedItems[i][droppedItem]);
				strcat(string, "\n");
			}

			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ���� '%s' ����Ҩҡ��� (( �ӹǹ: %d ))", GetPlayerNameEx(playerid), DroppedItems[itemid][droppedItem], DroppedItems[itemid][droppedAmount]);
			//Log_Write("logs/droppick.txt", "[%s] %s ���� \"%s\".", ReturnDate(), GetPlayerNameEx(playerid), DroppedItems[id][droppedItem]);
			Item_Delete(itemid);
			ApplyAnimation(playerid, "MISC", "PICKUP_box", 3.0, 0, 0, 0, 0, 0);
		}
	}
	return 1;
}



PlayerStats(playerid)
{
    static const aGender[3][10] = {"���", "���", "˭ԧ"};

	new businessid, pDialog[2080];

	format(pDialog, sizeof(pDialog), "{FFFFFF}���͵���Ф� :{FFA84D} %s (%s) {FFFFFF}| {ec1d24}True{f58320}Wallet{FFFFFF}: {FFA84D}%s\n\
	{FFFFFF}��Ѥ���Ҫԡ(��/��/��) : {FFA84D}%s\n\
	{00FF00}�ӹǹ�Թ : (Cash: %s), (Bank: %s) {FFFFFF}| {FF6347}�Թ�Դ������: %s\n\
	{FFFFFF}������Ͷ��: {FFFF00}%s\n\
	{FFFFFF}Faction: {33CCFF}%s {FFFFFF}| Rank: {33CCFF}(%d)%s\n\
	{FFFFFF}Business: %s\n\
	�����ӹҭ㹡�ä�ҿ���ظ: {FFA84D}%d {FFFFFF}| {FFA84D}%s \n\
	{FFFFFF}�����آͧ������: {FFA84D}%d {FFFFFF} ��ͧ | �����آͧ����: {FFA84D}%d {FFFFFF}���\n\
	{FFFFFF}\n\
	\n\
	\t\t{AFAFAF}���ҷ����� : %d ������� %d �ҷ�.", GetPlayerNameEx(playerid), aGender[playerData[playerid][pGender]], FormatNumber(playerData[playerid][pCoin]), playerData[playerid][pRegisterDate], 
	FormatMoney(playerData[playerid][pMoney]), FormatMoney(playerData[playerid][pBankMoney]), FormatMoney(GetPlayerRedMoney(playerid)),
	FormatNumberPhone(playerData[playerid][pPhone]), 
	Faction_GetName(playerid), playerData[playerid][pFactionRank], Faction_GetRank(playerid),
	businessData[businessid][businessName],
	GetPlayerLevelCraft(playerid), LevelCraftRank_GetName(playerid),
	playerData[playerid][pMaxItem], playerData[playerid][pItemAmount],
	playerData[playerid][pHours], playerData[playerid][pMinutes]);
	Dialog_Show(playerid, DialogStats, DIALOG_STYLE_MSGBOX, "\tStats", pDialog, "�Դ", "");
	return 1;
}






CMD:itemlist(playerid, params[])
{
    if (playerData[playerid][pAdmin] < 5)
	    return 1;

	static
	    string[1024];

	if (!strlen(string))
	{
		for (new i = 0; i < sizeof(itemData); i ++)
		{
			format(string, sizeof(string), "%s%s\n", string, itemData[i][itemName]);
		}
	}
	return Dialog_Show(playerid, DIALOG_SHOW, DIALOG_STYLE_LIST, "[��ª��������������]", string, "�Դ", "");
}

CMD:giveitem(playerid,params[])
{
    if (playerData[playerid][pAdmin] < 5)
	    return 1;

	new userid, item[32], amount;
	if(sscanf(params, "us[32]d", userid, item, amount)) return SendClientMessage(playerid, COLOR_WHITE, "/giveitem [�ʹ�/����] [���������] [�ӹǹ]");

	new count = Inventory_Count(userid, item)+amount;

	if (count > playerData[userid][pItemAmount])
        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "- �����آͧ {00FF00}%s{FFFFFF} �ͧ�����蹹��������� (%d/%d)", item, Inventory_Count(userid, item), playerData[userid][pItemAmount]);

	for (new i = 0; i < sizeof(itemData); i ++) if (!strcmp(itemData[i][itemName], item, true))
	{
		new id = Inventory_Add(userid, itemData[i][itemName], amount);

		if (id == -1)
		    return SendClientMessageEx(playerid, COLOR_LIGHTRED, "- �����آͧ�����������§�� (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);


	    SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Give{FFA84D} Item(%s):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), item, amount, GetPlayerNameEx(userid));
		SendClientMessageEx(userid, COLOR_YELLOW, "[Admin-Message] %s GiveItem(%s): (%d)%s", GetPlayerNameEx(playerid), item, amount, GetPlayerNameEx(userid));
		return 1;
	}
	SendClientMessageEx(playerid, COLOR_LIGHTRED, "- ���������� %s ������к� (����� /itemlist 㹡������ª��������)", item);
	return 1;
}

CMD:setitem(playerid,params[])
{
    if (playerData[playerid][pAdmin] < 5)
	    return 1;

	new userid, item[32], amount;
	if(sscanf(params, "us[32]d", userid, item, amount)) return SendClientMessage(playerid, COLOR_WHITE, "/setitem [�ʹ�/����] [���������] [�ӹǹ]");

	for (new i = 0; i < sizeof(itemData); i ++) if (!strcmp(itemData[i][itemName], item, true))
	{
	    if (!strcmp(item, "��Ͷ��", true))
		{
	        playerData[userid][pPhone] = random(900000) + 100000;
	    }
	    Inventory_Set(userid, itemData[i][itemName], amount);
	    SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Set{FFA84D} Item(%s):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), item, amount, GetPlayerNameEx(userid));
		SendClientMessageEx(userid, COLOR_YELLOW, "[Admin-Message] %s SetItem(%s): (%d)%s", GetPlayerNameEx(playerid), item, amount, GetPlayerNameEx(userid));
		return 1;
	}
	SendClientMessageEx(playerid, COLOR_LIGHTRED, "- ���������� %s ������к� (����� /itemlist 㹡������ª��������)", item);
	return 1;
}

CMD:deleteitem(playerid,params[])
{
    if (playerData[playerid][pAdmin] < 5)
	    return 1;

	new userid, item[32], amount;
	if(sscanf(params, "us[32]d", userid, item, amount)) return SendClientMessage(playerid, COLOR_WHITE, "/deleteitem [�ʹ�/����] [���������] [�ӹǹ]");

	for (new i = 0; i < sizeof(itemData); i ++) if (!strcmp(itemData[i][itemName], item, true))
	{
	    Inventory_Remove(userid, item, amount);

        SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Remove{FFA84D} Item(%s):{FFFFFF} (%d)%s", GetPlayerNameEx(playerid), item, amount, GetPlayerNameEx(userid));
		SendClientMessageEx(userid, COLOR_YELLOW, "[Admin-Message] %s RomoveItem(%s): (%d)%s", GetPlayerNameEx(playerid), item, amount, GetPlayerNameEx(userid));
		return 1;
	}
	SendClientMessageEx(playerid, COLOR_LIGHTRED, "- ���������� %s ������к�", item);
	return 1;
}

CMD:clearitem(playerid,params[])
{
    if (playerData[playerid][pAdmin] < 5)
	    return 1;

	new userid;
	if(sscanf(params, "u", userid)) return SendClientMessage(playerid, COLOR_WHITE, "/clearitem [�ʹ�/����]");

	Inventory_Clear(userid);

	SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Clear{FFA84D} Item:{FFFFFF} %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	SendClientMessageEx(userid, COLOR_YELLOW, "[Admin-Message] %s ClearItem: %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	return 1;
}
/*
// �к��ʴ�������� / �͡�ҡ������
ShowInventoryAdd(playerid, const itemName_Richard[], quantity) 
{
	new amount[32];

	for (new i = 0; i < 4; i++)
		PlayerTextDrawShow(playerid, AddItemText[playerid][i]);

	new id_item = Inventory_GetItemIDFromItemName(itemName_Richard);

	format(amount, sizeof(amount), "%d", quantity);
	PlayerTextDrawSetString(playerid, AddItemText[playerid][3], amount);

	PlayerTextDrawSetPreviewModel(playerid, AddItemText[playerid][0], itemData[id_item][itemModel]);
	PlayerTextDrawShow(playerid, AddItemText[playerid][0]);

	PlayerTextDrawBoxColor(playerid, AddItemText[playerid][1], COLOR_GREEN);
	PlayerTextDrawShow(playerid, AddItemText[playerid][1]);

	defer HideAddInventory(playerid);
}

ShowInventoryRemove(playerid, const itemName_Richard[], quantity) 
{
	new amount[32];

	for (new i = 0; i < 4; i++)
		PlayerTextDrawShow(playerid, AddItemText[playerid][i]);

	new id_item = Inventory_GetItemIDFromItemName(itemName_Richard);

	format(amount, sizeof(amount), "%d", quantity);
	PlayerTextDrawSetString(playerid, AddItemText[playerid][3], amount);

	PlayerTextDrawSetPreviewModel(playerid, AddItemText[playerid][0], itemData[id_item][itemModel]);
	PlayerTextDrawShow(playerid, AddItemText[playerid][0]);

	PlayerTextDrawBoxColor(playerid, AddItemText[playerid][1], COLOR_RED);
	PlayerTextDrawShow(playerid, AddItemText[playerid][1]);

	defer HideAddInventory(playerid);
}*/

timer HideAddInventory[3000](playerid)
{
	for (new i = 0; i < 4; i++)
		PlayerTextDrawHide(playerid, AddItemText[playerid][i]);
}

Inventory_Clear(playerid)
{
	static
	    string[64];

	for (new i = 0; i < MAX_INVENTORY; i ++)
	{
	    if (invData[playerid][i][invExists])
	    {
	        invData[playerid][i][invExists] = 0;
	        invData[playerid][i][invQuantity] = 0;
		}
	}
	mysql_format(g_SQL, string, sizeof(string), "DELETE FROM `inventory` WHERE `invOwner` = '%d'", playerData[playerid][pID]);
	return mysql_tquery(g_SQL, string);
}

Inventory_Set(playerid, const item[], amount)
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid == -1 && amount > 0)
	{
		Inventory_Add(playerid, item, amount);
	}
	else if (amount > 0 && itemid != -1)
	{
	    Inventory_SetQuantity(playerid, item, amount);
	}
	else if (amount < 1 && itemid != -1)
	{
	    Inventory_Remove(playerid, item, -1);
	}
	return 1;
}

Inventory_GetItemID(playerid, const item[])
{
	for (new i = 0; i < MAX_INVENTORY; i ++)
	{
	    if (!invData[playerid][i][invExists])
	        continue;

		if (!strcmp(invData[playerid][i][invItem], item)) return i;
	}
	return -1;
}

Inventory_GetFreeID(playerid)
{
	if (Inventory_Items(playerid) >= playerData[playerid][pMaxItem])
		return -1;

	for (new i = 0; i < MAX_INVENTORY; i ++)
	{
	    if (!invData[playerid][i][invExists])
	        return i;
	}
	return -1;
}

Inventory_Items(playerid)
{
    new count;

    for (new i = 0; i != MAX_INVENTORY; i ++) if (invData[playerid][i][invExists])
	{
        count++;
	}
	return count;
}

Inventory_Count(playerid, const item[])
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid != -1)
	    return invData[playerid][itemid][invQuantity];

	return 0;
}

Inventory_HasItem(playerid, const item[])
{
	return (Inventory_GetItemID(playerid, item) != -1);
}

Inventory_SetQuantity(playerid, const item[], quantity)
{
	new
	    itemid = Inventory_GetItemID(playerid, item),
	    string[128];

	if (itemid != -1)
	{
		mysql_format(g_SQL, string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = %d WHERE `invOwner` = '%d' AND `invID` = '%d'", quantity, playerData[playerid][pID], invData[playerid][itemid][invID]);
	    mysql_tquery(g_SQL, string);

	    invData[playerid][itemid][invQuantity] = quantity;
	}
	return 1;
}

Inventory_Add(playerid, const item[], quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128];

	if (itemid == -1)
	{
	    itemid = Inventory_GetFreeID(playerid);

	    if (itemid != -1)
	    {
	        invData[playerid][itemid][invExists] = true;
	        invData[playerid][itemid][invQuantity] = quantity;

	        format(invData[playerid][itemid][invItem], 32, item);

			mysql_format(g_SQL, string, sizeof(string), "INSERT INTO `inventory` (`invOwner`, `invItem`, `invQuantity`) VALUES ('%d', '%e', '%d')", playerData[playerid][pID], item, quantity);
			mysql_tquery(g_SQL, string, "OnInventoryAdd", "dd", playerid, itemid);

			//ShowInventoryAdd(playerid, item, quantity); 

	        return itemid;
		}
		return -1;
	}
	else
	{
	    mysql_format(g_SQL, string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` + %d WHERE `invOwner` = '%d' AND `invID` = '%d'", quantity, playerData[playerid][pID], invData[playerid][itemid][invID]);
	    mysql_tquery(g_SQL, string);

	    invData[playerid][itemid][invQuantity] += quantity;

		//ShowInventoryAdd(playerid, item, quantity); 
	}
	return itemid;
}

Inventory_Remove(playerid, const item[], quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128];

	if (itemid != -1)
	{
	    if (invData[playerid][itemid][invQuantity] > 0)
	    {
	        invData[playerid][itemid][invQuantity] -= quantity;
		}
		if (quantity == -1 || invData[playerid][itemid][invQuantity] < 1)
		{
		    invData[playerid][itemid][invExists] = false;
		    invData[playerid][itemid][invQuantity] = 0;

			//ShowInventoryRemove(playerid, item, quantity);

		    mysql_format(g_SQL, string, sizeof(string), "DELETE FROM `inventory` WHERE `invOwner` = '%d' AND `invID` = '%d'", playerData[playerid][pID], invData[playerid][itemid][invID]);
	        mysql_tquery(g_SQL, string);
		}
		else if (quantity != -1 && invData[playerid][itemid][invQuantity] > 0)
		{
			mysql_format(g_SQL, string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` - %d WHERE `invOwner` = '%d' AND `invID` = '%d'", quantity, playerData[playerid][pID], invData[playerid][itemid][invID]);
            mysql_tquery(g_SQL, string);

			//ShowInventoryRemove(playerid, item, quantity);
		}
		return 1;
	}
	return 0;
}

Dialog:DIALOG_INVENTORYMENU1(playerid, response, listitem, inputtext[])
{
	if (!response) return ShowPlayerInventory(playerid, true);
	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		        OnPlayerUseItem(playerid, invData[playerid][playerData[playerid][pItemSelect]][invItem]);
		    }
		    case 1:
			{
		        new string[128],
				itemid = playerData[playerid][pItemSelect],
				itemquantity = invData[playerid][playerData[playerid][pItemSelect]][invQuantity];
		        format(string, sizeof(string), "{FFFFFF}�ô���ӹǹ���س��ͧ��èз�� {FFA84D}'%s'{FFFFFF} ��觤س������ {00FF00}'%s'", invData[playerid][itemid][invItem], FormatNumber(itemquantity));
				Dialog_Show(playerid, DIALOG_INVENTORYDROP, DIALOG_STYLE_INPUT, invData[playerid][playerData[playerid][pItemSelect]][invItem], string, "���", "¡��ԡ");
			
			}
		}
	}
	return 1;
}

Dialog:DIALOG_INVENTORYMENU(playerid, response, listitem, inputtext[])
{
	if (!response) return ShowPlayerInventory(playerid, true);
	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		        OnPlayerUseItem(playerid, invData[playerid][playerData[playerid][pItemSelect]][invItem]);
		    }
		    case 1:
			{
				new
					string[128],
					string2[4096],
					var[15],
					count;
				foreach (new  i : Player)
				{
					if (i == playerid) continue;
					if (IsPlayerNearPlayer(playerid, i, 2.0))
					{
						format(string, sizeof(string), "(id: %d)\t%s\n", i, GetPlayerNameEx(i));
						strcat(string2, string);
						format(var, sizeof(var), "PID%d", count);
						SetPVarInt(playerid, var, i);
						count++;
					}
				}
				if (!count)
				{
					Dialog_Show(playerid,Paymoneyerorr,DIALOG_STYLE_LIST,"[Inventory]","��辺�����������ͺ� ����ǳ���س","�Դ","");
					return 1;
				}
				format(string, sizeof(string), " �ʹ�\t    ��ª���\n%s", string2);
				Dialog_Show(playerid, DIALOG_INVENTORYGIVEID, DIALOG_STYLE_TABLIST_HEADERS, "Inventory", string, "���͡", "�Դ");
		    }//invData[playerid][playerData[playerid][pItemSelect]][invItem]
		    case 2:
			{
		        new string[128],
				itemid = playerData[playerid][pItemSelect],
				itemquantity = invData[playerid][playerData[playerid][pItemSelect]][invQuantity];
		        format(string, sizeof(string), "{FFFFFF}�ô���ӹǹ���س��ͧ��èз�� {FFA84D}'%s'{FFFFFF} ��觤س������ {00FF00}'%s'", invData[playerid][itemid][invItem], FormatNumber(itemquantity));
				Dialog_Show(playerid, DIALOG_INVENTORYDROP, DIALOG_STYLE_INPUT, invData[playerid][playerData[playerid][pItemSelect]][invItem], string, "���", "¡��ԡ");
			
			}
		}
	}
	return 1;
}

Dialog:DIALOG_INVENTORYGIVEID(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new string[256], var[15];
	    new itemid = playerData[playerid][pItemSelect];
		format(var, sizeof(var), "PID%d", listitem);
		new userid = GetPVarInt(playerid, var);
		playerData[playerid][pItemOfferID] = userid;
        format(string, sizeof(string), "�ô�кبӹǹ {FFA84D}'%s'{FFFFFF} ���س��ͧ������Ѻ %s", invData[playerid][itemid][invItem], GetPlayerNameEx(userid));
		Dialog_Show(playerid, DIALOG_INVENTORYGIVE, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "��ŧ", "�Դ");
	}
	return 1;
}

Dialog:DIALOG_INVENTORYGIVE(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new amount, string[256],
	    itemid = playerData[playerid][pItemSelect],
		itemquantity = invData[playerid][itemid][invQuantity],
		userid = playerData[playerid][pItemOfferID],
		count = Inventory_Count(userid, invData[playerid][itemid][invItem])+amount;
		if (sscanf(inputtext, "d", amount))
		{
	        format(string, sizeof(string), "{FFFFFF}���ӹǹ���س��ͧ��è���� {FFA84D}'%s'{FFFFFF} �Ѻ {33CCFF}%s", invData[playerid][itemid][invItem], GetPlayerNameEx(userid));
			Dialog_Show(playerid, DIALOG_INVENTORYGIVE, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "��ŧ", "�Դ");
	    	return 1;
		}
		if (amount < 1)
		{
	        format(string, sizeof(string), "{FFFFFF}���ӹǹ���س��ͧ��è���� {FFA84D}'%s'{FFFFFF} �Ѻ {33CCFF}%s\n{FF0000}*** �ӹǹ��ͧ����ӡ��� 1", invData[playerid][itemid][invItem], GetPlayerNameEx(userid));
			Dialog_Show(playerid, DIALOG_INVENTORYGIVE, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "��ŧ", "�Դ");
	    	return 1;
		}
		if (invData[playerid][itemid][invQuantity] < amount)
		{
	        format(string, sizeof(string), "{FFFFFF}���ӹǹ���س��ͧ��è���� {FFA84D}'%s'{FFFFFF} �Ѻ {33CCFF}%s\n{FF0000}*** %s �ͧ�س�������§�ͷ������ {FFFFFF}(%d/%d)", invData[playerid][itemid][invItem], GetPlayerNameEx(userid), invData[playerid][itemid][invItem], amount, itemquantity);
			Dialog_Show(playerid, DIALOG_INVENTORYGIVE, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "���͡", "�Դ");
		    return 1;
		}
		if (!IsPlayerNearPlayer(playerid, userid, 4.0))
		{
	        format(string, sizeof(string), "{FFFFFF}���ӹǹ���س��ͧ��è���� {FFA84D}'%s'{FFFFFF} �Ѻ {33CCFF}%s\n{FF0000}*** �������ʹչ��������������س", invData[playerid][itemid][invItem], GetPlayerNameEx(userid));
			Dialog_Show(playerid, DIALOG_INVENTORYGIVE, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "���͡", "�Դ");
		    return 1;
		}
		if (count > playerData[userid][pItemAmount])
		{
	        format(string, sizeof(string), "{FFFFFF}���ӹǹ���س��ͧ��è���� {FFA84D}'%s'{FFFFFF} �Ѻ {33CCFF}%s\n{FF0000}*** %s �ͧ�������ʹչ���������觢ͧ������� (%d/%d)", invData[playerid][itemid][invItem], GetPlayerNameEx(userid), invData[playerid][itemid][invItem], amount, count);
			Dialog_Show(playerid, DIALOG_INVENTORYGIVE, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "���͡", "�Դ");
		    return 1;
		}
//		Inventory_Add(playerData[playerid][pItemOfferID], invData[playerid][itemid][invItem], amount);
		new id = Inventory_Add(playerData[playerid][pItemOfferID], invData[playerid][itemid][invItem], amount);

		if (id == -1)
		{
	        format(string, sizeof(string), "{FFFFFF}���ӹǹ���س��ͧ��è���� {FFA84D}'%s'{FFFFFF} �Ѻ {33CCFF}%s\n{FF0000}*** �������ʹչ������ء������������ (%d/%d)", invData[playerid][itemid][invItem], GetPlayerNameEx(userid), Inventory_Items(userid), playerData[userid][pMaxItem]);
			Dialog_Show(playerid, DIALOG_INVENTORYGIVE, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "���͡", "�Դ");
			return 1;
		}

		// ��Ѥ���� & ��Ѥ���������ظ
	    for (new i = 0; i <= 9; i++)
	    {
	        RemovePlayerAttachedObject(playerid, i);
	    }


		Inventory_Remove(playerid, invData[playerid][itemid][invItem], amount);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ����� %s �Ѻ %s �ӹǹ'%d'", GetPlayerNameEx(playerid), invData[playerid][itemid][invItem], GetPlayerNameEx(userid), amount);
        playerData[playerid][pItemOfferID] = INVALID_PLAYER_ID;
	}
	return 1;
}

Dialog:DIALOG_INVENTORYDROP(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new amount, string[256],
	    itemid = playerData[playerid][pItemSelect],
		itemquantity = invData[playerid][itemid][invQuantity];

		new 
			id_item = Inventory_GetItemIDFromItemName(invData[playerid][itemid][invItem]),
			Float:x,
			Float:y,
			Float:z,
			Float:angle;


		if (sscanf(inputtext, "d", amount))
		{
	        format(string, sizeof(string), "{FFFFFF}�ô���ӹǹ���س��ͧ��èз�� {FFA84D}'%s'{FFFFFF} ��觤س������ {00FF00}'%s'", invData[playerid][itemid][invItem], FormatNumber(itemquantity));
			Dialog_Show(playerid, DIALOG_INVENTORYDROP, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "���", "¡��ԡ");
	    	return 1;
		}
		if (amount < 1)
		{
	        format(string, sizeof(string), "{FFFFFF}�ô���ӹǹ���س��ͧ��èз�� {FFA84D}'%s'{FFFFFF} ��觤س������ {00FF00}'%s'\n{FF6347}*�ӹǹ�ͧ���س��ͧ��èз�駵�ͧ����ӡ��� 1", invData[playerid][itemid][invItem], FormatNumber(itemquantity));
			Dialog_Show(playerid, DIALOG_INVENTORYDROP, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "���", "¡��ԡ");
	    	return 1;
		}
		if (invData[playerid][itemid][invQuantity] < amount)
		{
	        format(string, sizeof(string), "{FFFFFF}�ô���ӹǹ���س��ͧ��èз�� {FFA84D}'%s'{FFFFFF} ��觤س������ {00FF00}'%s'\n{FF6347}*�ӹǹ�ͧ���س��ͧ��èз�駹���������§�� (( %d/%d))", invData[playerid][itemid][invItem], FormatNumber(itemquantity), amount, itemquantity);
			Dialog_Show(playerid, DIALOG_INVENTORYDROP, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "���", "¡��ԡ");
		    return 1;
		}
		GetPlayerPos(playerid, x, y, z); 
		GetPlayerFacingAngle(playerid, angle);     
		Inventory_Remove(playerid, invData[playerid][itemid][invItem], amount);

		strunpack(string, invData[playerid][itemid][invItem]);
		DropItem(string, playerid, itemData[id_item][itemModel], 1, x, y, z - 0.9, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), amount);

		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ���� '%s' ŧ����� (( �ӹǹ: %s ))", GetPlayerNameEx(playerid), invData[playerid][itemid][invItem], FormatNumber(amount));
		ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

DropItem(item[], playerid, model, quantity, Float:x, Float:y, Float:z, interior, world, amount)
{
	new
	    query[300],
		string[127];

	for (new i = 0; i != MAX_DROPPED_ITEMS; i ++) if (!DroppedItems[i][droppedModel])
	{
	    format(DroppedItems[i][droppedItem], 32, item);
	    format(DroppedItems[i][droppedPlayer], 24, GetPlayerNameEx(playerid));

		DroppedItems[i][droppedModel] = model;
		DroppedItems[i][droppedQuantity] = quantity;
		DroppedItems[i][droppedPos][0] = x;
		DroppedItems[i][droppedPos][1] = y;
		DroppedItems[i][droppedPos][2] = z;

		DroppedItems[i][droppedInt] = interior;
		DroppedItems[i][droppedWorld] = world;
		DroppedItems[i][droppedAmount] = amount;

		format(string, sizeof(string), "{FFA84D}%s {00FF00}(�ӹǹ: %d)\n{AAAAAA}�� 'Y' ������", item, amount);
 		DroppedItems[i][droppedText3D] = CreateDynamic3DTextLabel(string, COLOR_WHITE, x, y, z, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, world, interior);
		DroppedItems[i][droppedObject] = CreateDynamicObject(model, x, y, z, 0.0, 0.0, 0.0, world, interior);

		if (strcmp(item, "Demo Soda") != 0)
		{
	 		format(query, sizeof(query), "INSERT INTO `dropped` (`itemName`, `itemPlayer`, `itemModel`, `itemQuantity`, `itemX`, `itemY`, `itemZ`, `itemInt`, `itemWorld`) VALUES('%s', '%s', '%d', '%d', '%.4f', '%.4f', '%.4f', '%d', '%d')", item, GetPlayerNameEx(playerid), model, quantity, x, y, z, interior, world);
			mysql_tquery(g_SQL, query, "OnDroppedItem", "d", i);
		}
		return i;
	}
	return -1;
}

forward OnDroppedItem(itemid);
public OnDroppedItem(itemid)
{
	if (itemid == -1 || !DroppedItems[itemid][droppedModel])
	    return 0;

	DroppedItems[itemid][droppedID] = cache_insert_id();
	return 1;
}

Dialog:DIALOG_INVENTORY(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new var[32];
		format(var, sizeof(var), "itemlist%d", listitem);
		new item = GetPVarInt(playerid, var);

        OnPlayerClickItem(playerid, item, invData[playerid][item][invItem]);
	}
	return 1;
}

Dialog:Rope_Dialog(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new var[15];
		format(var, sizeof(var), "Rope%d", listitem);
		new userid = GetPVarInt(playerid, var);

		if (userid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ����������������ʶҹл���");

		if (userid == playerid)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö���Թ����� ��͵��ͧ��");

		if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- �����蹵�ͧ������躹�ҹ��˹�");

		if (!IsPlayerNearPlayer(playerid, userid, 5.0))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- ������������������س");

		if (playerData[userid][pInjuredTime] <= 0)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- �����蹹������������ʶҹкҴ��");

		if (playerData[userid][pDragged])
			return SendClientMessage(playerid, COLOR_LIGHTRED, "- �����蹹�鹶١�ҡ����");

		/*if (playerData[userid][pDragged])
		{
			playerData[userid][pDragged] = 0;
			playerData[userid][pDraggedBy] = INVALID_PLAYER_ID;
			Inventory_Remove(playerid, "Rope");
			KillTimer(playerData[userid][pDragTimer]);
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s �����µ�� %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
		}*/
		if (!playerData[userid][pDragged])
		{
			playerData[userid][pDragged] = 1;
			playerData[userid][pDraggedBy] = playerid;

			playerData[userid][pDragTimer] = SetTimerEx("DragUpdate", 200, true, "dd", playerid, userid);
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ����ҵ�� %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
			SendClientMessage(playerid, COLOR_YELLOW, "(( �ҡ�س��ͧ��û���� ����ö '/undrag' ���� '/�����' ���ͻŴ�ҡ))");
		}
	}
	return 1;
}






Item_Delete(itemid)
{
    static
	    query[64];

    if (itemid != -1 && DroppedItems[itemid][droppedModel])
	{
        DroppedItems[itemid][droppedModel] = 0;
		DroppedItems[itemid][droppedQuantity] = 0;
	    DroppedItems[itemid][droppedPos][0] = 0.0;
	    DroppedItems[itemid][droppedPos][1] = 0.0;
	    DroppedItems[itemid][droppedPos][2] = 0.0;
	    DroppedItems[itemid][droppedInt] = 0;
	    DroppedItems[itemid][droppedWorld] = 0;
	    DroppedItems[itemid][droppedAmount] = 0;

	    DestroyDynamicObject(DroppedItems[itemid][droppedObject]);
	    DestroyDynamic3DTextLabel(DroppedItems[itemid][droppedText3D]);

	    format(query, sizeof(query), "DELETE FROM `dropped` WHERE `ID` = '%d'", DroppedItems[itemid][droppedID]);
	    mysql_tquery(g_SQL, query);
	}
	return 1;
}

Item_Nearest(playerid)
{
    for (new i = 0; i != MAX_DROPPED_ITEMS; i ++) if (DroppedItems[i][droppedModel] && IsPlayerInRangeOfPoint(playerid, 1.5, DroppedItems[i][droppedPos][0], DroppedItems[i][droppedPos][1], DroppedItems[i][droppedPos][2]))
	{
	    if (GetPlayerInterior(playerid) == DroppedItems[i][droppedInt] && GetPlayerVirtualWorld(playerid) == DroppedItems[i][droppedWorld])
	        return i;
	}
	return -1;
}



forward OnPlayerUseItem(playerid, const name[]);
public OnPlayerUseItem(playerid, const name[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	for (new i=0;i!=sizeof(cl_SportsData);++i)
	{
	    if (!strcmp(name, cl_SportsData[i][e_name], true))
	    {
			new model, bone, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:sx, Float:sy, Float:sz;

			model = cl_SportsData[i][e_model];
			bone = cl_SportsData[i][e_bone];
			x = cl_SportsData[i][e_x];
			y = cl_SportsData[i][e_y];
			z = cl_SportsData[i][e_z];
			rx = cl_SportsData[i][e_rx];
			ry = cl_SportsData[i][e_ry];
			rz = cl_SportsData[i][e_rz];
			sx = cl_SportsData[i][e_sx];
			sy = cl_SportsData[i][e_sy];
			sz = cl_SportsData[i][e_sz];

			SetPlayerAttachedObject(playerid, 3, model, bone, x, y, z, rx, ry, rz, sx, sy, sz);
			SendClientMessageEx(playerid, COLOR_YELLOW, "+ �س�������� %s ���º�������� (/�ʹ�ش) ������Ҫش�͡", name);
		}
	}
	// �к��觵��
	for (new i=0;i!=sizeof(cl_ZipData);++i)
	{
	    if (!strcmp(name, cl_ZipData[i][e_name], true))
	    {
			new model, bone, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:sx, Float:sy, Float:sz;

			model = cl_ZipData[i][e_model];
			bone = cl_ZipData[i][e_bone];
			x = cl_ZipData[i][e_x];
			y = cl_ZipData[i][e_y];
			z = cl_ZipData[i][e_z];
			rx = cl_ZipData[i][e_rx];
			ry = cl_ZipData[i][e_ry];
			rz = cl_ZipData[i][e_rz];
			sx = cl_ZipData[i][e_sx];
			sy = cl_ZipData[i][e_sy];
			sz = cl_ZipData[i][e_sz];

			SetPlayerAttachedObject(playerid, 10, model, bone, x, y, z, rx, ry, rz, sx, sy, sz);
			SendClientMessageEx(playerid, COLOR_YELLOW, "+ �س�������� %s ���º�������� (/�ʹ�ش) ������Ҫش�͡", name);
		}
	}
    if (!strcmp(name, "���ͧ�ٹ", true))
	{
	   	if(!IsPlayerInAnyVehicle(playerid))
		    return SendClientMessage(playerid, COLOR_LIGHTRED,"- �س��ͧ���躹ö");

		Dialog_Show(playerid, TuneEas, DIALOG_STYLE_LIST, "���٨ٹö", "> ���٨ٹö", "save", "cose");
	}
	else if (!strcmp(name, "���ͧ���������ʹ", true))
	{
		new Float:hp;
		GetPlayerHealth(playerid, hp);

		if (hp + 25.0 > 100)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "-  ���ʹ�ͧ�س���ҡ������!");

		if (useFirstAidKit[playerid] == 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "-  �س���������ҧ�����ҹ���ͧ���������ʹ!");

		useFirstAidKit[playerid] = 1;
		StartProgress(playerid, 50, 0, INVALID_OBJECT_ID);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "-  �س������ͧ���������ʹ����!");
		SetPlayerAttachedObject(playerid, 9, 11738, 6, 0.273999, 0.019999, 0.000000, 23.299997, -87.400009, 6.599999, 1.000000, 1.000000, 1.000000);
	}
	else if (!strcmp(name, "����ع", true)) 
	{
	    new weaponid = GetPlayerWeapon(playerid);

		Inventory_Remove(playerid, "����ع", 1);
		GivePlayerWeaponEx(playerid, weaponid, 1);
		SendClientMessage(playerid, COLOR_YELLOW, "* > �س���������ع���ظ�ͧ�س�ӹǹ '1 �Ѵ'");
	}
	else if (!strcmp(name, "Camera", true))
	{
	    GivePlayerWeaponEx(playerid, 43, 100);
		ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ժ 'Camera' �͡�Ҩҡ��������ж�����", GetPlayerNameEx(playerid));
	}
	else if (!strcmp(name, "AdminGun", true))
	{
		Inventory_Remove(playerid, name);
	    GivePlayerWeaponEx(playerid, 24, 150);
		ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ժ 'Desert Eagle' �͡�Ҩҡ��������ж�����", GetPlayerNameEx(playerid));
	}
	else if (!strcmp(name, "AdminAk", true))
	{
		Inventory_Remove(playerid, name);
	    GivePlayerWeaponEx(playerid, 30, 200);
		ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ժ 'Ak-47' �͡�Ҩҡ��������ж�����", GetPlayerNameEx(playerid));
	}
	else if (!strcmp(name, "PepperSpray", true))
	{
		Inventory_Remove(playerid, name);
	    GivePlayerWeaponEx(playerid, 41, 100);
		ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ժ 'PepperSpray' �͡�Ҩҡ��������ж�����", GetPlayerNameEx(playerid));
	}
	else if (!strcmp(name, "Radio", true))
	{
		SendClientMessage(playerid, COLOR_YELLOW, "�͡�͹�Ф�Ѻ �����ѹ");
		/*
		Inventory_Remove(playerid, name);
	    GivePlayerWeaponEx(playerid, 41, 100);
		ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ժ 'PepperSpray' �͡�Ҩҡ��������ж�����", GetPlayerNameEx(playerid));*/
	}
	else if (!strcmp(name, "Rope", true))
	{
		new
			string[128],
			string2[4096],
			var[15],
			count;
		ShowPlayerINV(playerid, false);
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);

		foreach (new  i : Player)
		{
			if (i == playerid) continue;
			if (IsPlayerNearPlayer(playerid, i, 2.0))
			{
				format(string, sizeof(string), "(id: %d)\t%s\n", i, GetPlayerNameEx(i));
				strcat(string2, string);
				format(var, sizeof(var), "Rope%d", count);
				SetPVarInt(playerid, var, i);
				count++;
			}
		}
		if (!count)
		{
			
			Dialog_Show(playerid, DrivingLincenseerorr, DIALOG_STYLE_LIST, "Rope","{FF6347}- ��辺�������������ǳ�ͺ� ��Ǣͧ�س","�Դ","");
			return 1;
		}
		format(string, sizeof(string), " �ʹ�\t    ��ª���\n%s", string2);
		Dialog_Show(playerid, Rope_Dialog, DIALOG_STYLE_TABLIST_HEADERS, "Rope", string, "���͡", "¡��ԡ");
		return 1;
		/*
		Inventory_Remove(playerid, name);
	    GivePlayerWeaponEx(playerid, 41, 100);
		ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ժ 'PepperSpray' �͡�Ҩҡ��������ж�����", GetPlayerNameEx(playerid));*/
	}
	else if (!strcmp(name, "Watch", true))
	{
		new
			hours,
			minutes,
			seconds;
		gettime(hours, minutes, seconds);
		ApplyAnimation(playerid, "COP_AMBIENT","Coplook_watch", 4.1, 0, 0, 0, 0, 0, 1);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ժ���ԡҢ���Ҵ�", GetPlayerNameEx(playerid));
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** ��й������ %d ���ԡ� %d �ҷ� (( %s ))", hours, minutes, GetPlayerNameEx(playerid));
		
		/*Inventory_Remove(playerid, name);
	    GivePlayerWeaponEx(playerid, 41, 100);
		ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ժ 'PepperSpray' �͡�Ҩҡ��������ж�����", GetPlayerNameEx(playerid));*/
	
	}
	else if (!strcmp(name, "Burger", true))
	{
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ժ 'Burger' ������Ѻ��зҹ", GetPlayerNameEx(playerid));

		SetTimerEx("RemoveObjectBurger", 5000, 0, "id", playerid);
		SetPlayerAttachedObject(playerid,7,2880,6,-0.001000,-0.006000,-0.030999,14.199995,0.300005,5.000000,1.000000,1.000000,1.000000);
		ApplyAnimation(playerid, "Food","Eat_pizza", 4.1, 1, 0, 0, 0, 0, 1);
		Inventory_Remove(playerid, name);
		PlayerPlaySoundEx(playerid, 32200);
	}

	else if (!strcmp(name, "Water", true))
	{
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ժ 'Water' ����Ҵ���", GetPlayerNameEx(playerid));

		SetTimerEx("RemoveObjectBeer", 1000, 0, "id", playerid);
		SetPlayerAttachedObject(playerid,7,2647,5,0.093999,0.044999,-0.035999,-14.799992,-173.599975,0.000000,0.623000,0.625999,0.514000);
		ApplyAnimation(playerid, "VENDING","VEND_Drink_P", 4.1, 1, 0, 0, 0, 0, 1);
		Inventory_Remove(playerid, name);
		PlayerPlaySoundEx(playerid, 32200);
	}
	else if (!strcmp(name, "Hammer", true))
	{
		if(playerData[playerid][pEquipmentJob] == 0)
		{
			playerData[playerid][pEquipmentJob] = 1;
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ժ 'Hammer' �͡�Ҩҡ��������ж�����", GetPlayerNameEx(playerid));
			SetPlayerAttachedObject(playerid,9,19631,6,0.123999,-0.008000,0.284999,-84.800041,-95.100036,0.000000,1.000000,1.000000,1.000000);
			ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		}
		else if(playerData[playerid][pEquipmentJob] == 1)
		{
			playerData[playerid][pEquipmentJob] = 0;
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s �� 'Hammer' ŧ������", GetPlayerNameEx(playerid));
			RemovePlayerAttachedObject(playerid, 9);
			ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		}
	}
	else if (!strcmp(name, "Chainsaw", true))
	{
		if(playerData[playerid][pEquipmentJob] == 0)
		{
			playerData[playerid][pEquipmentJob] = 2;
			SetPlayerAttachedObject(playerid,9,341,6,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ժ 'Chainsaw' �͡�Ҩҡ��������ж�����", GetPlayerNameEx(playerid));
			ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		}
		else if(playerData[playerid][pEquipmentJob] == 2)
		{
			playerData[playerid][pEquipmentJob] = 0;
			gPlayerWeaponData[playerid][9] = false;
			RemovePlayerAttachedObject(playerid, 9);
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s �� 'Chainsaw' ŧ������", GetPlayerNameEx(playerid));
			ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		}
	}
    if (!strcmp(name, "FishingRod", true))
	{
		if(playerData[playerid][pEquipmentJob] == 0)
		{
			playerData[playerid][pEquipmentJob] = 3;
			SetPlayerAttachedObject(playerid,8,18632,6,0.109999,0.045999,0.000000,-162.100128,1.200001,0.799999,1.000000,1.000000,1.000000);
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ժ 'FishingRod' �͡�Ҩҡ��������ж�����", GetPlayerNameEx(playerid));
			SendClientMessageEx(playerid, COLOR_YELLOW, "[Fishing]: ����ҹ������(FishingBait), ��������������");
			ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		}
		else if(playerData[playerid][pEquipmentJob] == 3)
		{
			playerData[playerid][pEquipmentJob] = 0;
			RemovePlayerAttachedObject(playerid, 8);
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s �� 'FishingRod' ŧ������", GetPlayerNameEx(playerid));
			ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		}
	}		
    if (!strcmp(name, "Crate", true))
	{
		if(playerData[playerid][pEquipmentJob] == 0)
		{
			playerData[playerid][pEquipmentJob] = 4;
			SetPlayerAttachedObject(playerid,9,19639,6,0.065999,0.009999,-0.130999,-106.599990,-5.100001,-13.599996,1.000000,1.000000,1.000000);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ժ 'Crate' �͡�Ҩҡ��������ж�����", GetPlayerNameEx(playerid));
			ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		}
		else if(playerData[playerid][pEquipmentJob] == 4)
		{
			playerData[playerid][pEquipmentJob] = 0;
			RemovePlayerAttachedObject(playerid, 8);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s �� 'Crate' ŧ������", GetPlayerNameEx(playerid));
			ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		}
	}		
    if (!strcmp(name, "Knife", true))
	{
		if(playerData[playerid][pEquipmentJob] == 0)
		{
			playerData[playerid][pEquipmentJob] = 5;
			SetPlayerAttachedObject(playerid, 9, 335,6,0.065999,0.009999,-0.130999,-106.599990,-5.100001,-13.599996,1.000000,1.000000,1.000000);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ��Ժ 'Knife' �͡�Ҩҡ��������ж�����", GetPlayerNameEx(playerid));
			ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		}
		else if(playerData[playerid][pEquipmentJob] == 4)
		{
			playerData[playerid][pEquipmentJob] = 0;
			RemovePlayerAttachedObject(playerid, 8);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s �� 'Knife' ŧ������", GetPlayerNameEx(playerid));
			ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
		}
	}		
    if (!strcmp(name, "FishingBait", true))
	{
	   	if (!IsPlayerInArea(playerid, 218.00018310546875, -2658.5003356933594, 898.0001831054688, -2373.5003356933594))
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Fishing]: �س����������ࢵ��鹷�赡���");
	
		if(playerData[playerid][pEquipmentJob] != 3)
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Fishing]: �������ö������������ ���ͧ�ҡ�س��������紵�����������");

		if(StartFishJobs[playerid] == false)
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Fishing]: �س�ѧ�����������ҹ�����");

		StartFishing[playerid] = true;
		Inventory_Remove(playerid, name);
		StartFishingJob(playerid);
		ApplyAnimation(playerid, "SAMP", "FishingIdle", 4.1, 0, 1, 1, 1, 1, 1);
		ShowFishingTD(playerid);
		SendClientMessageEx(playerid, COLOR_YELLOW, "[Fishing]: �س������������, �� 'Y' �����ǧ�������¹��������");
		PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	}		

  	else if (!strcmp(name, "ToolBox", true))
	{
	    new vehicleid = GetNearbyVehicle(playerid);

		if(vehicleid != INVALID_VEHICLE_ID )
		{

			if (GetFactionType(playerid) == FACTION_POLICE)
				return SendClientMessage(playerid, COLOR_LIGHTRED, "[Mechanic]: �ػ�ó�������ö������˹��§ҹ��ҧ��ҹ��");

			switch (GetEngineStatus(vehicleid))
			{
				case false:
				{
					if (repairon[playerid] == 1)
						return  SendClientMessage(playerid, COLOR_LIGHTRED, "[Mechanic]: �س���������ҧ��ë���ö");

					if(IsPlayerInAnyVehicle(playerid))
						return SendClientMessage(playerid, COLOR_LIGHTRED, "[Mechanic]: �س��ͧ������躹�ҹ��˹�");

					if (!GetHoodStatus(vehicleid))
						return SendClientMessage(playerid, COLOR_LIGHTRED, "[Mechanic]: �ô�Դ�ҡ���ç˹�� �ͧ�ҹ��˹�");


					//RepairVehicle(vehicleid);
					Inventory_Remove(playerid, "ToolBox", 1);
					StartProgress(playerid, 100, 0, INVALID_OBJECT_ID);
					//SetPlayerAttachedObject(playerid,9,18718,6,0.187999,0.084999,-0.882000,0.000000,0.000000,0.000000,0.811999,0.762000,0.824999);
					SetPlayerAttachedObject(playerid,9,19627,6,0.075000,0.038999,0.044000,96.899993,-102.100021,11.300000,1.000000,1.000000,1.000000);
					ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
					TogglePlayerControllable( playerid, false );
					repairon[playerid] = 1;
				}
				case true:
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "[Mechanic]: �ҹ��˹й�鹵Դ����ͧ¹������ �ô�Ѻ����ͧ¹��");
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTRED, "[Mechanic]: �������ö�� 'ToolBox' �����ͧ�ҡ��辺�ҹ��˹� �ͺ��Ǣͧ�س");
		}
	}
/* ----------------------------------------------------------����ͼ�Ҽ����---------------------------------------------------------- */
    
    else if (!strcmp(name, "Skin:7", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 7);
        playerData[playerid][pSkins] = 7;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:14", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 14);
        playerData[playerid][pSkins] = 14;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:20", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 20);
        playerData[playerid][pSkins] = 20;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:22", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 22);
        playerData[playerid][pSkins] = 22;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:23", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 23);
        playerData[playerid][pSkins] = 23;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:24", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 24);
        playerData[playerid][pSkins] = 24;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:25", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 25);
        playerData[playerid][pSkins] = 25;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:30", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 30);
        playerData[playerid][pSkins] = 30;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:34", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 34);
        playerData[playerid][pSkins] = 34;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:44", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 44);
        playerData[playerid][pSkins] = 44;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:46", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 46);
        playerData[playerid][pSkins] = 46;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:47", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 47);
        playerData[playerid][pSkins] = 47;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:48", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 48);
        playerData[playerid][pSkins] = 48;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:60", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 60);
        playerData[playerid][pSkins] = 60;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:67", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 67);
        playerData[playerid][pSkins] = 67;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:72", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 72);
        playerData[playerid][pSkins] = 72;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:79", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 79);
        playerData[playerid][pSkins] = 79;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:98", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 98);
        playerData[playerid][pSkins] = 98;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:185", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 185);
        playerData[playerid][pSkins] = 185;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:188", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 188);
        playerData[playerid][pSkins] = 188;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:206", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 206);
        playerData[playerid][pSkins] = 206;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:202", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 202);
        playerData[playerid][pSkins] = 202;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:217", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 217);
        playerData[playerid][pSkins] = 217;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:223", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 223);
        playerData[playerid][pSkins] = 223;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:235", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 235);
        playerData[playerid][pSkins] = 235;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:236", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 236);
        playerData[playerid][pSkins] = 236;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:240", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 240);
        playerData[playerid][pSkins] = 240;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:250", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 250);
        playerData[playerid][pSkins] = 250;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:259", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 259);
        playerData[playerid][pSkins] = 259;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:258", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 258);
        playerData[playerid][pSkins] = 258;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:290", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                        
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 290);
        playerData[playerid][pSkins] = 290;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:297", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 297);
        playerData[playerid][pSkins] = 297;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:303", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 303);
        playerData[playerid][pSkins] = 303;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:304", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 304);
        playerData[playerid][pSkins] = 304;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:305", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                
		if(playerData[playerid][pGender] == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 305);
        playerData[playerid][pSkins] = 305;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
/* ----------------------------------------------------------����ͼ�Ҽ����---------------------------------------------------------- */
/* ----------------------------------------------------------����ͼ�Ҽ��˭ԧ---------------------------------------------------------- */
    
	else if (!strcmp(name, "Skin:9", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                
		if(playerData[playerid][pGender] == 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 9);
        playerData[playerid][pSkins] = 9;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:13", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                
		if(playerData[playerid][pGender] == 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 13);
        playerData[playerid][pSkins] = 13;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:38", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                
		if(playerData[playerid][pGender] == 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 38);
        playerData[playerid][pSkins] = 38;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:93", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
        
		SetPlayerSkin(playerid, 93);
        playerData[playerid][pSkins] = 93;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:129", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
        
		SetPlayerSkin(playerid, 129);
        playerData[playerid][pSkins] = 129;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:130", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
        
		SetPlayerSkin(playerid, 130);
        playerData[playerid][pSkins] = 130;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:131", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                
		if(playerData[playerid][pGender] == 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 131);
        playerData[playerid][pSkins] = 131;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:148", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
        
		SetPlayerSkin(playerid, 148);
        playerData[playerid][pSkins] = 148;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:193", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
        
		SetPlayerSkin(playerid, 193);
        playerData[playerid][pSkins] = 193;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:226", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                
		if(playerData[playerid][pGender] == 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 226);
        playerData[playerid][pSkins] = 226;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:233", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                
		if(playerData[playerid][pGender] == 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 233);
        playerData[playerid][pSkins] = 233;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:298", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                
		if(playerData[playerid][pGender] == 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 298);
        playerData[playerid][pSkins] = 298;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:192", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                
		if(playerData[playerid][pGender] == 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 192);
        playerData[playerid][pSkins] = 192;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:151", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                
		if(playerData[playerid][pGender] == 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 151);
        playerData[playerid][pSkins] = 151;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:157", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
                
		if(playerData[playerid][pGender] == 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 157);
        playerData[playerid][pSkins] = 157;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    else if (!strcmp(name, "Skin:193", true))
	{
        if(playerData[playerid][pGender] == 1 && playerData[playerid][pSkins] != 289 || playerData[playerid][pGender] == 2 && playerData[playerid][pSkins] != 191)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�ժش����������������� ��سҶʹ�ش�Ѩ�غѹ�ͧ�س�͡��͹");
        
		if(playerData[playerid][pGender] == 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Edit Skins]: �س�������ö����ش����� ���ͧ�ҡ�Ȣͧ�س���ç�Ѻ�ش");

		SetPlayerSkin(playerid, 193);
        playerData[playerid][pSkins] = 193;

        SetPlayerChatBubble(playerid, "** ����¹����ͼ�ҷ��������", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "CARRY","LIFTUP05", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
/* ----------------------------------------------------------����ͼ�Ҽ��˭ԧ---------------------------------------------------------- */
    else if (!strcmp(name, "BetaTestBox", true))
	{
		new vehicleid = GetPlayerVehicleID(playerid), query[1640];

		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %.1f, '557.8670', '-1283.9822', '17.0007', '0.0000')", playerData[playerid][pID], GetPlayerNameEx(playerid), 509, vehicleData[carData[vehicleid][carModel] - 400][vFuel]);
		mysql_tquery(g_SQL, query);

		Inventory_Add(playerid, "Burger", 25);
		Inventory_Add(playerid, "Water", 25);
		Inventory_Add(playerid, "Skin:223", 1);

		SendClientMessage(playerid, COLOR_YELLOW, "[BetaTest Box]: �س���Ѻ�ͧ����Ѻ������ Beta Test ���º����");
        SetPlayerChatBubble(playerid, "** �Դ��ҹ BetaTestBox", COLOR_PURPLE, 5.0, 5000);
        ApplyAnimation(playerid, "BOMBER","BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        Inventory_Remove(playerid, name);
	}
    
	return 1;
}

hook OnProgressFinish(playerid, objectid)
{
	if(repairon[playerid] == 1)
		Player_Repair(playerid);

	return Y_HOOKS_CONTINUE_RETURN_0;
}

hook OnProgressUpdate(playerid, progress, objectid)
{
	if(repairon[playerid] == 1)
	{
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}

	return Y_HOOKS_CONTINUE_RETURN_0;
}

Player_Repair(playerid)
{
    new vehicleid = GetNearestVehicle(playerid);

    repairon[playerid] = 0;
    TogglePlayerControllable(playerid, 1);
    ClearAnimations(playerid);
    Inventory_Remove(playerid,"Repair Kit", 1);
    RemovePlayerAttachedObject(playerid, 9);
    //RemovePlayerAttachedObject(playerid, 8);
	RepairVehicle(vehicleid);
    /*new
        query[128];

    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carHealth = 1000.0 WHERE carID = %d", carData[vehicleid][carID]);
    mysql_tquery(g_SQL, query);*/
	SetHoodStatus(vehicleid, true);
}
