#include 	<a_samp>


#undef	  	MAX_PLAYERS
#define	 	MAX_PLAYERS			500

#define 	YSI_NO_OPTIMISATION_MESSAGE
#define 	YSI_NO_CACHE_MESSAGE
#define 	YSI_NO_MODE_CACHE
#define 	YSI_NO_HEAP_MALLOC
#define 	YSI_NO_VERSION_CHECK

#include	<sscanf2>
#include 	<a_mysql>
#include	<streamer>
#define 	cec_auto
#include	<CEC>
#include	<Pawn.CMD>
#include 	<Pawn.RakNet>
//#include 	<io>
#include	<progress2>
#define     PlayerEngine
#define     RemovePlayerWeapon
#define     flying

// ระบบ 'กันโปร'
#if !defined gpci
    native gpci(playerid, serial[], len);
#endif
#include 	<anticheat.inc>

// Weapon-Config
//#include 	<weapon-config.inc>

#include 	<YSI_Data\y_iterate>
#include 	<YSI_Coding\y_timers>
#include	<YSI_Coding\y_hooks>
#include 	<YSI_Coding\y_timers>

#include	<GPS> // มอส
#include	<easyDialog>
#include 	<OPVD>

#include 	<samp-player-gangzones>

#define		MYSQL_HOST 				"127.0.0.1"
#define		MYSQL_USER 				"root"
#define		MYSQL_PASSWORD 			""
#define		MYSQL_DATABASE 			"bw"



#define BitFlag_On(%0,%1)             ((%0) |= (%1))
#define BitFlag_Off(%0,%1)            ((%0) &= ~(%1))
#define BitFlag_Get(%0,%1)            ((%0) & (%1))
//#define IsPlayerAndroid(%0)                 GetPVarInt(%0, "NotAndroid") == 0

//////////////////////////////////////

#define SystemMsg(%0,%1) \
	SendClientMessageEx(%0, COLOR_LIGHTRED, "[System]:{FFFFFF} "%1) 

#if !defined IsValidVehicle
    native IsValidVehicle(vehicleid);
#endif

#define		SECONDS_TO_LOGIN 		60

#define		SERVER_NAME				"SAMP : Black Woods"
#define		SERVER_VERSION		  	"Full Opened"
#define		SERVER_MODE		     	"Semi-Roleplay"
#define     SERVER_LANGUAGE     	"Thailand"
#define     SERVER_WEBSITE      	"-"

#define		COLOR_BLACK				0x000000FF
#define     COLOR_WHITE  			0xFFFFFFFF
#define     COLOR_TG                0x76C3FFFF
#define 	COLOR_GREY				0xAFAFAFFF
#define		COLOR_GREY1    			0xE6E6E6FF
#define 	COLOR_GREY2 			0xC8C8C8FF
#define 	COLOR_GREY3 			0xAAAAAAFF
#define 	COLOR_GREY4 			0x8C8C8CFF
#define 	COLOR_GREY5 			0x6E6E6EFF
#define     COLOR_RED           	0xFF0000FF
#define     COLOR_ORANGE        	0xFFA84DFF
#define     COLOR_YELLOW        	0xFFFF00FF
#define     COLOR_GREEN         	0x00FF00FF
#define 	COLOR_SERVER      		0xFFFF90FF
#define 	COLOR_FACTION     		0xBDF38BFF
#define 	COLOR_LIGHTRED    		0xFF6347FF
#define 	COLOR_LIGHTBLUE   		0x33CCFFAA
#define 	COLOR_DARKBLUE    		0x1394BFFF
#define 	DEFAULT_COLOR     		0xFFFFFFFF
#define     COLOR_ADMIN         	0xFF0080FF
#define 	COLOR_PURPLE      		0xD0AEEBFF
#define 	COLOR_DEPARTMENT  		0xF0CC00FF
#define 	COLOR_HOSPITAL    		0xFF8282FF
#define 	COLOR_RADIO       		0x8D8DFFFF
#define     COLOR_PINK              0xFF00FFFF
#define 	COLOR_CYAN        		0x33CCFFFF
#define     COLOR_VIP1      		0x00FF00FF
#define     COLOR_VIP2      		0xFFFF00FF
#define     COLOR_VIP3      		0xFF00FFFF
#define     COLOR_VIP4      		0xFF00FFFF

#define 	MAX_FACTIONS 			(50)
#define 	MAX_ARREST 				(200)
#define 	MAX_SHOPS				(200)
#define 	MAX_ENTRANCES 			(100)
#define 	MAX_BUSINESS			(100)
#define 	MAX_CARS 				(1500)
#define 	MAX_OWNABLE_CARS 		(5)
#define     MAX_INVENTORY       	(1500)
#define     MAX_TRUNK       		(1500)
#define 	MAX_CONTACTS 			(20)
#define 	MAX_ATM_MACHINES 		(50)
#define 	MAX_GARAGES 			(20)
#define     MAX_GPS                 (200)
#define 	MAX_GATES				(5000)
#define		MAX_QUEST				(10)
#define 	MAX_SPAWNED_VEHICLES    (1)


#define     BANANAOBJECT           3439
#define     BANANATEXT            "Objective: {FFFFFF}กล้วย\nกดปุ่ม {FFFF00}N {FFFFFF}เพื่อเก็บ!"
#define     BANANANAME             "กล้วย"
#define		BANANATIMER			  10

#define     THREAD_LOGIN            (0)
#define		THREAD_LIST_VEHICLES 	(1)
#define     THREAD_VERIFY_PASS 		(2)

#define 	THREAD_LIST_CAR_DESTROY (5)

#define 	FACTION_POLICE 			(1)
#define 	FACTION_NEWS 			(2)
#define 	FACTION_MEDIC 			(3)
#define 	FACTION_GOV 			(4)
#define 	FACTION_GANG 			(5)
#define 	FACTION_MEC 			(6)
#define 	FACTION_TAXI 			(7)

#define MAX_BOT_CONNECTIONS 2
//เพลงหน้าล็อคอิน

#define percent(%0,%1)  floatround((float((%0)) / 100) * (%1))
enum PlayerFlags:(<<= 1) {
	// It's important that you don't forget to put "= 1" on the first flag. If you don't, all flags will be 0.

	PLAYER_IS_LOGGED_IN = 1,   // 0b00000000000000000000000000000001
	PLAYER_HAS_KILLED,           // 0b00000000000000000000000000000010
	PLAYER_DRIVING_TEST, // 0b00000000000000000000000000000100
	PLAYER_DUTY_TAXI,           // 0b00000000000000000000000000001000
	PLAYER_MINING,           // 0b00000000000000000000000000010000
	PLAYER_CRAFTING,           // 0b00000000000000000000000000100000
	PLAYER_ONDUTY,           // 0b00000000000000000000000001000000
	PLAYER_HOUSE_LIGHTS,           // 0b00000000000000000000000010000000
	PLAYER_ENTRANCE_LIGHTS,
	PLAYER_HARVESTING,           // 0b00000000000000000000000100000000
	PLAYER_PICKUPING,
	PLAYER_COOKMEAT,
	PLAYER_PHONE_OFF,           // 0b00000000000000000000001000000000
	PLAYER_TAZER,           // 0b00000000000000000000010000000000
	PLAYER_BEANBAG,           // 0b00000000000000000000100000000000
    PLAYER_CHAINSAW,
	PLAYER_CUFFED,          // 0b00000000000000000001000000000000
	PLAYER_DRAGGED,          // 0b00000000000000000010000000000000
	PLAYER_PICKING,          // 0b00000000000000000100000000000000
	PLAYER_CAN_TELEPORT,
	PLAYER_DISABLE_OOC,
    PLAYER_DISABLE_TWITTER,
    PLAYER_DISABLE_FACEBOOK,
	PLAYER_DISABLE_NEWBIE,
	PLAYER_DISABLE_PM,
	PLAYER_DISABLE_FACTION,
	PLAYER_DISABLE_TESTER,
	PLAYER_DISABLE_BC,
	PLAYER_FPS

}
native WP_Hash(buffer[], len, const str[]);
new repairon[MAX_PLAYERS];
//new ManmyGetVehicleSpeed[MAX_PLAYERS];
//new returnspeed[MAX_PLAYERS];
//new hp[MAX_PLAYERS];

// ค่าปรับ
new fineID[MAX_PLAYERS] = -1;
new finePrice[MAX_PLAYERS] = 0;
new fineText[MAX_PLAYERS][64];

//--> ระบบเชฟข้อมูลทุกวิ
new PlayerSaveTime[MAX_PLAYERS];
// ปืนช็อตไฟฟ้า
new TazerCooldown[MAX_PLAYERS];



//---------ออนแอร์--------------//
#define MAX_SPIKESTRIPS 5
#if !defined isnull
	#define isnull(%1) \
		((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

// // // อาหาร// //
//new PlayerBar:PlayerProgressBar[MAX_PLAYERS][3];
//new PlayerBar:PlayerProgressBar[MAX_PLAYERS][6];
/////////

new Text:PIERON_TD[4];


forward GPSR_OnPlayerRouteFound(playerid, routeid, extra, Float:distance);
forward GPSR_OnPlayerReachDestination(playerid, routeid, extra);



//new Float:g_SpeedThreshold;

// PlayerText : PlayerBar
new PlayerText:DeathTD[MAX_PLAYERS];

//เซฟจูน
//new carTunesave[MAX_VEHICLES];

//new helloweenData[MAX_PLAYERS];
new Text3D:pUIDTag[MAX_PLAYERS];

//ดาบอาวุธ
new DubSS[MAX_PLAYERS];
new DubBB[MAX_PLAYERS];
new DubCC[MAX_PLAYERS];
new DubAB[MAX_PLAYERS];
new DubBA[MAX_PLAYERS];

//new SetHoodStatus[MAX_PLAYERS];

//new IsMelee[MAX_PLAYERS];

new playerUseTazer[MAX_PLAYERS] = 0;

new BeforeSleep[MAX_PLAYERS];

//new Log_Write[MAX_PLAYERS];
//new ReturnDate_Logs;

//ระบบป้าย
new COLOR_GRAD1;

new HUDToggle[MAX_PLAYERS];

//new joiner[MAX_PLAYERS];
new MySQL: g_SQL;

#define NT_DISTANCE 35.0

//new poonCD;
new bool:gPlayerWeaponData[MAX_PLAYERS][47];
new globalWeather = 2;
new bool:OOC = true;
new g_TaxVault;
//new PlayerText:Government_Online[MAX_PLAYERS][11];



// รัฐออนไลน์
//new PlayerText:PlayerTD[MAX_PLAYERS][18];
//new PlayerBar:SpeedBARx[MAX_PLAYERS][1];
new PVPZone;
new adminVehicle[MAX_VEHICLES];
new Float:vehicleFuel[MAX_VEHICLES];
new vehicleSiren[MAX_VEHICLES] = {INVALID_OBJECT_ID, ...};
new vehicleStream[MAX_VEHICLES][128];
new vehicleColors[MAX_VEHICLES][2];
new PlayerText:FINPHONE[MAX_PLAYERS][38];



new isBaseFire[MAX_PLAYERS];

new GovCD[MAX_PLAYERS] = 0;


new BottleOn[MAX_PLAYERS];
new ArmourOn[MAX_PLAYERS];

new CallVehicleGang[MAX_PLAYERS] = -1;
new vehicleCall[MAX_VEHICLES] = 0;
//ระบบวิทยู
new bool:PlayerInRadio[MAX_PLAYERS];

//new afkcoin[MAX_PLAYERS];
//ระบบคุยวอ
//new SV_GSTREAM:PoloceRadio;
//new SV_GSTREAM:MedicRadio;
//new SV_GSTREAM:GangRadio;
//new SV_LSTREAM: lstream[MAX_PLAYERS] = {SV_NULL, ... };
//new bool:PoliceRadioOn[MAX_PLAYERS];
//new bool:MedicRadioOn[MAX_PLAYERS];
//new bool:GangRadioOn[MAX_PLAYERS];


// ปูน
new isPoonStart[MAX_PLAYERS];

new inLabel[MAX_PLAYERS];


new MudFireOn[MAX_PLAYERS];
new WeaponType[MAX_PLAYERS];

new DubFah[MAX_PLAYERS];
new KnifeFire[MAX_PLAYERS];
new MudShockOn[MAX_PLAYERS];
new DubOn[MAX_PLAYERS];
new GreenOn[MAX_PLAYERS];
//new Dubfah[MAX_PLAYERS];



//new NewbieVehicle[MAX_PLAYERS];

//new PlayerText:ZeeThreeText[MAX_PLAYERS][19];

// TextDraws Career
new PlayerText:WorkTD[MAX_PLAYERS][1];



//new PlayerBar:HP[MAX_PLAYERS];
//new PlayerBar:Sindelikheid[MAX_PLAYERS];
//new PlayerBar:water[MAX_PLAYERS];
//new PlayerBar:Omteduik[MAX_PLAYERS];
//new PlayerBar:food[MAX_PLAYERS];
//new PlayerBar:Krag[MAX_PLAYERS];

//new PlayerText:tdhp[MAX_PLAYERS];
//new PlayerText:tdarmour[MAX_PLAYERS];
//new PlayerText:tdhungry[MAX_PLAYERS];
//new PlayerText:tddrink[MAX_PLAYERS];
new PlayerText:tdexp[MAX_PLAYERS];
new PlayerText:tddollar[MAX_PLAYERS];
new PlayerText:tdredmoney[MAX_PLAYERS];
new PlayerText:tdgangicon[MAX_PLAYERS];
new PlayerText:tdidname[MAX_PLAYERS];
new PlayerText:tdlogo1[MAX_PLAYERS];
new PlayerText:tdlogo2[MAX_PLAYERS];
new PlayerText:tdlogo3[MAX_PLAYERS];
new PlayerText:tdlogo4[MAX_PLAYERS];
new PlayerBar:barhp[MAX_PLAYERS];
new PlayerBar:bararmour[MAX_PLAYERS];
new PlayerBar:barhungry[MAX_PLAYERS];
new PlayerBar:bardrink[MAX_PLAYERS];
new PlayerBar:barexp[MAX_PLAYERS];
//new BloodObject[MAX_PLAYERS][3]

//new BankDoors[2];


new
    Menu:TuningMenu,
    Menu:TuningMenu1,
    Menu:Paintjobs,
    Menu:Colors,
    Menu:Colors1,
    Menu:Exhausts,
    Menu:Frontbumper,
    Menu:Rearbumper,
    Menu:Roof,
    Menu:Spoilers,
    Menu:Sideskirts,
    Menu:Bullbars,
    Menu:Wheels,
    Menu:Wheels1,
    Menu:Carstereo,
    Menu:Hydraulics,
    Menu:Nitro,
    pmodelid[MAX_PLAYERS],
    pvehicleid[MAX_PLAYERS];

new robCount;

new ProgressLimit[MAX_PLAYERS],
	ProgressCount[MAX_PLAYERS],
	Timer:ProgressTimer[MAX_PLAYERS],
	ProgressState[MAX_PLAYERS],
	ProgressObject[MAX_PLAYERS];

//gps
//new MAX_PLAYER_GZ;


/* Event */
new	Float:EventX, Float:EventY, Float:EventZ,
	EventInterior = 0,
	EventWorld = 0,
	EventOn = 0;

// PlayerText : PlayerBar
new PlayerText:PlayerDeathTD[MAX_PLAYERS];

new PlayerText:PlayerSpeedoCountTD[MAX_PLAYERS];
new PlayerText:PlayerSpeedoKMHTD[MAX_PLAYERS];
new PlayerText:PlayerSpeedoFuelCountTD[MAX_PLAYERS];
new PlayerText:PlayerSpeedoFuelLitersTD[MAX_PLAYERS];

//new PlayerText:ProgressTD[MAX_PLAYERS][16];

enum gateData
{
	gateID,
	gateExists,
	gateOpened,
	gateModel,
	Float:gateSpeed,
	Float:gateRadius,
	gateTime,
	Float:gatePos[6],
	gateInterior,
	gateWorld,
	Float:gateMove[6],
	gateLinkID,
	gateFaction,
	gatePass[32],
	gateTimer,
	gateObject
};
new GateData[MAX_GATES][gateData];

//ขโมยล้อ
//new Vehicle_Nearest;

// --> ระบบ Boombox
enum boomboxData {
	boomboxPlaced,
	Float:boomboxPos[3],
	boomboxInterior,
	boomboxWorld,
	boomboxObject,
	boomboxURL[128 char],
	Text3D:boomboxText3D
};
new BoomboxData[MAX_PLAYERS][boomboxData];


new const MonthDay[][] =
{
	"January", "February", "March", "April",
	"May", "June", "July", "August", "September", "October",
	"November","December"
};
/*
returnOrdinal(number)
{
	new
	    ordinal[4][3] = { "st", "nd", "rd", "th" }
	;

	number = number < 0 ? -number : number;

	return (((10 < (number % 100) < 14)) ? ordinal[3] : (0 < (number % 10) < 4) ? ordinal[((number % 10) - 1)] : ordinal[3]);
}*/

/* Earn Exp */
new PlayerText:PlayerExpEarnBoxTD1[MAX_PLAYERS];
new PlayerText:PlayerExpEarnBoxTD2[MAX_PLAYERS];
new PlayerText:PlayerEarnExpAmountTD[MAX_PLAYERS];

enum PLAYER_DATA
{
	pAdminID,
	pBusinessID,
	pAnimationID,
	pFactionMenuID,

	pSelectVeh,
	pBuyVeh,

	pSpeedGoon,
	pEditType,
 	pEditGate,
    pCheckpoint,
    pPoint,
    pRadioID,
	pID,
	pTargetFrisk,
	pRegisterDate[90],
	pGender,
	pAge,
	pAdmin,
	pMaster,
	pKills,
	pDeaths,
	pMoney,
	pBankMoney,
	pRedMoney,
	pLevelName[48],
	pLevel,
	pExp,
	pMinutes,
	pHours,
	pCameraFPS,
	Float: pPos_X,
	Float: pPos_Y,
	Float: pPos_Z,
	Float: pPos_A,
	pSkin,
	pSkins,
	pSkinFaction,
	pInterior,
	pWorld,
	pTutorial,
	pSpawnPoint,
    pBath,
	pSleep,
	pMaskOn,
	Float: pThirsty,
	Float: pHungry,
	Float: pHealth,
	//Float: pSleep,
	Float: pShower,

	pInjured,
	pInjuredTime,

	pHospital,

	INV,

	pFactionOffer,
	pFactionOffered,
	pFaction,
	pFactionID,
	pFactionRank,
	pFactionEdit,
	pSelectedSlot,

	pDisableFaction,
	bool: pArmorOn,
	pCuffed,
	pDragged,
	pDraggedBy,
	pDragTimer,

	pSelectTD,

	pPrisoned,
	pPrisonOut,
	pJailTime,

	pEntrance,

	pCarSeller,
	pCarOffered,
	pCarValue,

	pSpeedoTimer,

	pMaxItem,
	pItemAmount,
	pItemSelect,
	pItemOfferID,
	pInventoryPage,

	pMecOfferID,
	pMecOfferPrice,

	pMedicOfferID,
    pMedicOfferPrice,

    pRoadblock,

	pChangePass,
	pChangeName,

	pPhone,
	pPhoneOff,
	pContact,
	pEditingItem[32],
	pIncomingCalling,
	pIncomingCall,
	pCallLine,
	pEmergency,
//	pPlaceAd,

	pMarker,

	pWanted,
	pWantedTime,

	pTransfer,

	pColor1,
	pColor2,

	pPaintjob,

	pDrivingTest,
	pTestStage,
	pTestCar,
	pTestWarns,

	Float: pEventBackX,
	Float: pEventBackY,
	Float: pEventBackZ,
	pEventBackInterior,
	pEventBackWorld,
	pEventGo,

	pOOCSpam,

	pVip,

	pCarVehI,

	pExpShow,
	pExpTimer,

	pQuest,
	pQuestProgress,

	pWarn,
	pBan,
	pBanReason[128],

	pVehicleKeys,
	pPVP,
	pPVPFreeze,

	pTazer,
	pStunned,

	bool: IsLoggedIn,
	LoginAttempts,
	LoginTimer,

	pHouse,
	pWhitelist,

	pWorkOn,

	bool: pHelmetOn,

	pCoin,
	pBoombox,

	pAnimation,
	pPayMoneyID,

    pStorageSelect,
    pStorageItem,

    pStrain,
	Float:pArmour,

	pOnSpectator,

	Float:pAngles[2],
	Float:pPoolPower,
	pPoolScore,
	pPoolDirection,
	pEditPool,

	bool:pSpaceOn,

	bool:pMorganPit,
	bool:pMorganSuit,

	pOnDuty,
	pPowder,
	pPowderMax,
	pEquipmentJob,
	pJobs,
	pColor,
};
new playerData[MAX_PLAYERS][PLAYER_DATA];

//new MapIconsShown[MAX_PLAYERS];

new bool:EmeraldOn[MAX_PLAYERS];

// --> ระบบ SafeZone
#define MAX_SZ 1000 //
enum szInfo
{
     Exits,
	 Float:szPosX,
	 Float:szPosY,
	 Float:szPosZ,
	 szSize,
	 szPickupID,
	 Text3D: szTextID,
};
new SafeZoneInfo[MAX_SZ][szInfo];

/*new Float:garagePoints[][] = {
    { 2609.9038,2258.5513,10.8203 }, //
    { 539.9163,-1276.1754,17.2422 }
};*/



enum CAR_DATA
{
	carID,
	carOwnerID,
	carOwner[MAX_PLAYER_NAME],
	carModel,
	carPrice,
	carType,
	carTickets,
	carLocked,
	carPlate[32],
	Float:carHealth,
	Float:carPosX,
	Float:carPosY,
	Float:carPosZ,
	Float:carPosA,
	carColor1,
	carColor2,
	carPaintjob,
	carInterior,
	carWorld,
	carNeon,
	carNeonEnabled,
	carTrunk,
	carTrunkQuantity,
	carMods[14],
	carCash,
	carFaction,
	carObjects[2],
	carTimer,
	carWeapons[5],
	carAmmo[5],
	carTune[1],
	carDestroy
};
new carData[MAX_VEHICLES][CAR_DATA];

enum SHOP_DATA {
	shopID,
	shopExists,
	Float:shopPosX,
	Float:shopPosY,
	Float:shopPosZ,
	shopInterior,
	shopWorld,
	shopType,
	Text3D:shopText3D,
 	shopPickup
};
new shopData[MAX_SHOPS][SHOP_DATA];

enum ATM_DATA {
	atmID,
	atmExists,
	Float:atmPosX,
	Float:atmPosY,
	Float:atmPosZ,
	Float:atmPosA,
	atmInterior,
	atmWorld,
	atmObject,
	Text3D:atmText3D
};
new atmData[MAX_ATM_MACHINES][ATM_DATA];

enum CONTACT_DATA {
	contactID,
	contactExists,
	contactName[32],
	contactNumber
};
new contactData[MAX_PLAYERS][MAX_CONTACTS][CONTACT_DATA];
new ListedContacts[MAX_PLAYERS][MAX_CONTACTS];

enum INV_DATA {
	invExists,
	invID,
	invItem[32],
	invModel,
	invQuantity
};
new invData[MAX_PLAYERS][MAX_INVENTORY][INV_DATA];


new DubLNW[MAX_PLAYERS];

// กล่องยาเพิ่มเลือด
new useFirstAidKit[MAX_PLAYERS];

// อาวุธติดหลัง
/*#define ARMEDBODY_USE_HEAVY_WEAPON          (true)

static
    armedbody_pTick[MAX_PLAYERS];*/

// เพิ่มไอเทม
new PlayerText:AddItemText[MAX_PLAYERS][4];

// ของผิดกฎหมาย
enum ITEM_DRUGS_DATA{
	itemName[64]
};

new const drugsInfo[][ITEM_DRUGS_DATA] = {
	{ "กัญชา" },
	{ "โคเคน" },
	{ "ปูน" },
	{ "Poon" }
};

enum ENTRANCE_DATA {
	entranceID,
	entranceExists,
	entranceName[32],
	entrancePass,
	entranceIcon,
	entranceLocked,
	Float:entrancePosX,
	Float:entrancePosY,
	Float:entrancePosZ,
	Float:entrancePosA,
	Float:entranceIntX,
	Float:entranceIntY,
	Float:entranceIntZ,
	Float:entranceIntA,
	entranceInterior,
	entranceExterior,
	entranceExteriorVW,
	entranceType,
	entranceCustom,
	entranceWorld,
	entranceFaction,
	entrancePickup,
	entranceMapIcon,
	Text3D:entranceText3D,
	entranceExPickup,
	Text3D:entranceExText3D
};
new entranceData[MAX_ENTRANCES][ENTRANCE_DATA];

enum
{
	VEHICLE_ENGINE,
	VEHICLE_LIGHTS,
	VEHICLE_ALARM,
	VEHICLE_DOORS,
	VEHICLE_BONNET,
	VEHICLE_BOOT,
	VEHICLE_OBJECTIVE
};

enum
{
	STASH_CAPACITY_CASH
};

enum
{
	LIMIT_VEHICLES
};

// ระบบแต่งตัว
#define MAX_CLOTHES 15
#define BUYZIP 1
#define BUYSPORTS 2

#define EMBED_BLACK                     "{000000}"
#define EMBED_RED						"{FF0000}"
#define EMBED_WHITE						"{FFFFFF}"
#define EMBED_YELLOW				    "{FFFF00}"
#define EMBED_GREEN						"{33AA33}"
#define EMBED_BLUE						"{0000FF}"
#define EMBED_LIGHTBLUE				    "{8080FF}"
#define EMBED_ORANGE				    "{FF8000}"
#define EMBED_GREY						"{AFAFAF}"
#define EMBED_CYAN						"{00FFFF}"
#define EMBED_GRAD						"{CBCCCE}"
#define EMBED_GRAD1						"{b4b5b7}"
#define EMBED_PURPLE				    "{C68DFF}"
#define EMBED_PINK						"{FF8282}"
#define EMBED_LIGHTBLUE2			    "{8D8DFF}"
#define EMBED_LIGHTRED				    "{FF6347}"
#define EMBED_DIALOG				    "{A8C3E3}"
#define EMBED_LIGHTGREEN			    "{AEFFBC}"
#define EMBED_GREENMONEY			    "{33AA33}"
#define EMBED_LIMEGREEN                 "{E5FF00}"

enum e_cloths {
	cl_sid,
	cl_object,
	Float:cl_x,
	Float:cl_y,
	Float:cl_z,
	Float:cl_rx,
	Float:cl_ry,
	Float:cl_rz,
	Float:cl_scalex,
	Float:cl_scaley,
	Float:cl_scalez,
	cl_bone,
	cl_slot,
	cl_equip,
	cl_mc1,
	cl_mc2,
	cl_name[32]
};

enum e_cldata {
	e_model,
	e_price,
	e_bone,
	e_name[32],
	Float:e_x,
	Float:e_y,
	Float:e_z,
	Float:e_rx,
	Float:e_ry,
	Float:e_rz,
	Float:e_sx,
	Float:e_sy,
	Float:e_sz
};

new const cl_SportsData[][e_cldata] = { // 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0
	{953, 200, 1, "หอย", 0.000000, -0.299999, -0.038000, 49.799999, 1.599999, 0.000000, 1.000000, 1.000000, 1.000000},
	{3092, 200, 1, "ศพตำรวจ", 0.098999, -0.127000, 0.000000, 1.399999, 83.900024, 4.400000, 1.000000, 1.000000, 1.000000},
	{1371, 200, 1, "มังกร", 0.187999, 0.000000, 0.000000, -3.299999, 90.499984, 175.600006, 1.000000, 1.000000, 1.000000},
	{19833, 200, 1, "วัว", -0.106999, 0.190000, -0.001000, 85.000007, 41.900024, 96.799957, 0.935999, 0.722000, 0.772000},
	{1276, 100, 1, "กระเป๋าเรืองแสง", -0.106999, 0.190000, -0.001000, 85.000007, 41.900024, 96.799957, 0.935999, 0.722000, 0.772000},

	{11704, 100, 2, "หน้ากากดารุมะ", 0.154999, 0.045999, 0.007999, 2.399999, -6.399999, -6.899999, 1.289999, 1.018999, 1.123999},
	{19557, 200, 2, "หน้ากาก Sexy", 0.154999, 0.045999, 0.007999, 2.399999, -6.399999, -6.899999, 1.289999, 1.018999, 1.123999},
	{1276,  200, 1,  "มังกรเขียว", 0.120999, -0.209000, 0.000000, -2.100000, 86.900001, 91.400001, 1.000000, 1.000000, 1.000000},
	{8492, 200, 1, "ดอกบัว", -0.141999, -0.120000, -0.007000, 53.200004, -87.699966, 53.599979, 0.150000, 0.000000, 0.188000},
	{1238, 200, 2, "จราจร", 0.409999, 0.000000, 0.021000, 13.899998, 81.899917, 10.399999, 1.000000, 1.000000, 1.000000},

	{2102, 200, 1, "ลำโพง", -0.081999, -0.120999, -0.123999, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000},
	{1212, 200, 1, "เงิน", 0.011999, -0.033999, -0.019000, 94.399986, 0.000000, 0.000000, 2.890999, 3.981999, 2.572999},
	{2880, 200, 2, "เบอร์เกอร์", 0.155999, 0.166999, 0.044000, -173.700042, 17.500003, 27.900005, 1.004000, 1.900999, 1.245999},
	{11712, 200, 1, "ไม้กางเขน", 0.039000, -0.099000, 0.000000, -87.199996, 94.699981, -0.499999, 2.768999, 2.805000, 2.735000},
	{18920, 200, 2, "ผ้าปิดปาก", -0.095000, 0.064000, -0.011999, -95.400009, 8.800000, 82.200019, 1.000000, 1.000000, 1.000000},

	{19578, 200, 1, "กล้วย", 0.061999, -0.133000, 0.000000, 0.000000, -49.699996, 0.000000, 2.746999, 1.909999, 2.751000},
	{1254, 200, 2, "หัวกะโหลก", 0.099000, 0.029000, 0.018000, -12.200000, 83.299942, 0.900000, 1.284999, 1.000000, 1.382000},
	{19488, 200, 2, "หมวก", 0.153000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000},
	{1241, 200, 1, "ยา", 0.094999, -0.111999, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 },
	{19138, 200, 2, "แว่นตา", 0.098000, 0.033000, 0.000000, 89.300010, 85.500015, 0.000000, 0.969000, 1.150000, 1.355000 }
};

new const cl_ZipData[][e_cldata] = { // 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0
	{19066, 100, 2, "หมวกซานต้า", 0.1229, 0.0350, 0.0000, 90.7, 119.2999, -2.4, 1.0, 1.0, 1.0},
	{18970, 100, 2, "หมวกแมงดาเสือ", 0.1089, 0.0360, 0.0000, 0.0000, 93.5999, 87.7999, 1.0, 1.0, 1.0},
	{18971, 100, 2, "หมวกดิสโก้แมงดา", 0.1089, 0.0360, 0.0000, 0.0000, 93.5999, 87.7999, 1.0, 1.0, 1.0},
	{18972, 100, 2, "หมวกลาวาแมงดา", 0.1089, 0.0360, 0.0000, 0.0000, 93.5999, 87.7999, 1.0, 1.0, 1.0},
	{18973, 100, 2, "Camo Pimp Hat", 0.1089, 0.0360, 0.0000, 0.0000, 93.5999, 87.7999, 1.0, 1.0, 1.0},
	{18921, 100, 2, "หมวกเบเร่ต์", 0.1430, 0.0210, -0.0029, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18922, 100, 2, "หมวกเบเร่ต์สีแดง", 0.1430, 0.0210, -0.0029, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18923, 100, 2, "บลูเบเร่ต์", 0.1430, 0.0210, -0.0029, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18924, 100, 2, "Camo Beret", 0.1430, 0.0210, -0.0029, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19067, 100, 2, "หมวกฮูดสีแดง", 0.1239, 0.0290, -0.0009, 85.5999, 118.7000, 1.0000, 1.0, 1.0, 1.0},
	{19068, 100, 2, "หมวกม้าลาย", 0.1239, 0.0290, -0.0009, 85.5999, 118.7000, 1.0000, 1.0, 1.0, 1.0},
	{19069, 100, 2, "หมวกฮู้ดดำ", 0.1239, 0.0290, -0.0009, 85.5999, 118.7000, 1.0000, 1.0, 1.0, 1.0},
	{18926, 100, 2, "หมวกลายพราง", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18927, 100, 2, "หมวกเปลวไฟสีน้ำเงิน", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18928, 100, 2, "หมวกฮิปปี้", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18929, 100, 2, "หมวกลวงตา", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18930, 100, 2, "หมวกไฟ", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18931, 100, 2, "หมวกเพลิงทมิฬ", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18932, 100, 2, "หมวกลาวา", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18933, 100, 2, "โพก้าดอทแฮท", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18934, 100, 2, "หมวกแดง", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18935, 100, 2, "หมวกสีเหลือง", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18941, 100, 2, "หมวกดำ", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18942, 100, 2, "หมวกสีน้ำเงินเข้ม", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18943, 100, 2, "หมวกสีเขียว", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18961, 100, 2, "หมวกรถบรรทุก", 0.1370, 0.0320, 0.0030, 103.0000, 94.0000, -14.9000, 1.0, 1.0, 1.0},
	{18960, 100, 2, "ขอบขึ้น", 0.1370, 0.0320, 0.0030, 103.00000, 94.0000, -14.9000, 1.0, 1.0, 1.0},
	{18936, 100, 2, "หมวกกันน็อคสีเทา", 0.0980, 0.0369, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18937, 100, 2, "หมวกแดง", 0.0980, 0.0369, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18938, 100, 2, "หมวกกันน็อคสีม่วง", 0.0980, 0.0369, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19101, 100, 2, "หมวกทหาร(สายรัด)", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19102, 100, 2, "หมวกทหารเรือ(สายรัด)", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19103, 100, 2, "หมวกทะเลทราย(สายรัด)", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19104, 100, 2, "หมวกกันน็อค Day Camo (สายรัด)", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19105, 100, 2, "หมวกนิรภัย Night Camo (สายรัด)", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19106, 100, 2, "หมวกทหาร", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19107, 100, 2, "หมวกทหารเรือ", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19108, 100, 2, "หมวกทะเลทราย", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19109, 100, 2, "หมวกกันน็อค Day Camo", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19110, 100, 2, "หมวกนิรภัย Night Camo", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19111, 100, 2, "หมวกกันน็อคลายพรางทราย", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19112, 100, 2, "หมวกกันน็อคลายพรางสีชมพู", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18911, 100, 2, "ผ้าพันคอหัวกะโหลก", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
 	{18912, 100, 2, "ผ้าพันคอสีดำ", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
 	{18913, 100, 2, "ผ้าพันคอสีเขียว", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
 	{18914, 100, 2, "ผ้าพันคอลายพราง", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
 	{18915, 100, 2, "ผ้าพันคอขี้ขลาด", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
 	{18916, 100, 2, "ผ้าโพกหัวสามเหลี่ยม", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
 	{18917, 100, 2, "ผ้าพันคอสีน้ำเงินเข้ม", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
    {18918, 100, 2, "ผ้าพันคอขาวดำ", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},

	{18919, 100, 2, "จุดผ้าพันคอ", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
    {18920, 100, 2, "สามเหลี่ยมและจุดผ้าพันคอ", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
    {19469, 100, 1, "ผ้าพันคอ", 0.3000, 0.0550, -0.0369, -5.8999, 0.0000, 26.2000, 1.0000, 1.5519, 1.3889},
	{18944, 100, 2, "นักพายเรือลาวา", 0.1330, 0.0180, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18945, 100, 2, "นักพายเรือหมวกสีเทา", 0.1330, 0.0180, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18946, 100, 2, "หมวกลำลอง", 0.1330, 0.0180, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18947, 100, 2, "Black Hat Bowler", 0.1390, 0.0180, -0.0010, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
    {18948, 100, 2, "นักเล่นโบว์ลิ่งหมวกสีน้ำเงิน", 0.1390, 0.0180, -0.0010, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
    {18949, 100, 2, "นักโบว์ลิ่งกรีนแฮท", 0.1390, 0.0180, -0.0010, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
    {18950, 100, 2, "นักเลงหมวกแดง", 0.1390, 0.0180, -0.0010, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
    {18951, 100, 2, "นักเล่นโบว์ลิ่งหมวกเหลือง", 0.1390, 0.0180, -0.0010, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18953, 100, 2, "หมวกถักสีดำ", 0.1110, 0.0340, -0.0010, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18954, 100, 2, "ถักหมวกสีเทา", 0.1110, 0.0340, -0.0010, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18955, 100, 2, "ลาวาแคปอาย", 0.1030, 0.0440, 0.0009, -95.6000, 92.2001, -161.9002, 1.0, 1.0, 1.0},
	{18956, 100, 2, "Dark Flame Cap Eye", 0.1030, 0.0440, 0.0009, -95.6000, 92.2001, -161.9002, 1.0, 1.0, 1.0},
	{18957, 100, 2, "บลูแคปอาย", 0.1030, 0.0440, 0.0009, -95.6000, 92.2001, -161.9002, 1.0, 1.0, 1.0},
	{18958, 100, 2, "เสือชีตาห์แคปอาย", 0.1030, 0.0440, 0.0009, -95.6000, 92.2001, -161.9002, 1.0, 1.0, 1.0},
	{18959, 100, 2, "Camo Cap Eye", 0.1030, 0.0440, 0.0009, -95.6000, 92.2001, -161.9002, 1.0, 1.0, 1.0},
	{18964, 100, 2, "หมวกหัวกระโหลกดำ", 0.1210, 0.0310, 0.0000, 95.3000, 107.1999, 0.0000, 1.0, 1.0, 1.0},
	{18965, 100, 2, "หมวกหัวกะโหลก", 0.1210, 0.0310, 0.0000, 95.3000, 107.1999, 0.0000, 1.0, 1.0, 1.0},
	{18966, 100, 2, "หมวก Funky Skully", 0.1210, 0.0310, 0.0000, 95.3000, 107.1999, 0.0000, 1.0, 1.0, 1.0},
	{18967, 100, 2, "หมวกดำ", 0.1030, 0.0260, 0.0000, 95.7000, 87.3999, -0.3999, 1.0, 1.0, 1.0},
	{18968, 100, 2, "ชาวหาด", 0.1030, 0.0260, 0.0000, 95.7000, 87.3999, -0.3999, 1.0, 1.0, 1.0},
	{18969, 100, 2, "หมวกลาวา", 0.1030, 0.0260, 0.0000, 95.7000, 87.3999, -0.3999, 1.0, 1.0, 1.0},
	{19006, 100, 2, "แว่นแดง", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19007, 100, 2, "แก้วสีส้ม", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19008, 100, 2, "แว่นเขียว", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19009, 100, 2, "แว่นฟ้า", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19010, 100, 2, "แว่นสีชมพู", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19011, 100, 2, "แว่นขาวดำ", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19012, 100, 2, "แว่นดำ", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19013, 100, 2, "แว่นตาจุด", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19014, 100, 2, "แว่นเหลี่ยม", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19015, 100, 2, "แว่นตาเรืองแสง", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19016, 100, 2, "แว่นตาเอ็กซ์เรย์", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19017, 100, 2, "แว่นเหลืองล้วน", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19018, 100, 2, "แว่นสีส้มล้วน", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19019, 100, 2, "แว่นแดงธรรมดา", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19020, 100, 2, "แว่นสีน้ำเงินล้วน", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19021, 100, 2, "แว่นเขียวธรรมดา", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19022, 100, 2, "นักบินอวกาศ", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19023, 100, 2, "นักบินสีน้ำเงิน", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19024, 100, 2, "นักบินสีม่วง", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19025, 100, 2, "นักบินสีชมพู", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19026, 100, 2, "นักบินสีแดง", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19027, 100, 2, "นักบินสีส้ม", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19028, 100, 2, "นักบินสีเหลือง", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},

	{19029, 100, 2, "นักบินสีเขียว", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19030, 100, 2, "หนาทึบ", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19031, 100, 2, "สีเหลืองหนา", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19032, 100, 2, "หนาแดง", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19033, 100, 2, "แว่นดำล้วน", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
    {19024, 100, 2, "แว่นตาสี่เหลี่ยม", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
    {19025, 100, 2, "แว่นตาสีน้ำเงินเข้ม", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19349, 100, 2, "โมโนเคิล", 0.0769, 0.105, 0.0340, 120.9999, 2.6999, -96.3998, 1.0, 1.0, 1.0},
	{18891, 100, 2, "ผ้าพันคอสีน้ำเงิน", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18892, 100, 2, "ผ้าพันคอสีแดง", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18893, 100, 2, "ผ้าพันคอสีขาวและสีแดง", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18894, 100, 2, "บ็อบ มาร์เลย์ ผ้าพันคอ", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18895, 100, 2, "ผ้าพันคอหัวกะโหลก", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18896, 100, 2, "ผ้าโพกหัวขาวดำ", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18897, 100, 2, "ผ้าพันคอสีน้ำเงินและสีขาว", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18898, 100, 2, "ผ้าพันคอสีเขียวและสีขาว", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18899, 100, 2, "ผ้าพันคอสีม่วงและสีขาว", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18900, 100, 2, "ผ้าพันคอประสาทหลอน", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18901, 100, 2, "Fall Camo Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18902, 100, 2, "ผ้าพันคอสีเหลือง", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18903, 100, 2, "ผ้าพันคอสีฟ้าอ่อน", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18904, 100, 2, "ผ้าพันคอสีน้ำเงินเข้ม", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
    {18905, 100, 2, "ผ้าพันคอฟาง", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
    {18906, 100, 2, "ผ้าพันคอสีแดงและสีเหลือง", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18907, 100, 2, "ผ้าพันคอประสาทหลอน", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18908, 100, 2, "คลื่นผ้าพันคอ", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18909, 100, 2, "ผ้าพันคอสีฟ้า", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18910, 100, 2, "ผ้าพันคอลาวา", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18962, 100, 2, "หมวกคาวบอยสีดำ", 0.1630, 0.0270, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19095, 100, 2, "หมวกคาวบอยสีน้ำตาลอ่อน", 0.1630, 0.0270, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19096, 100, 2, "หมวกคาวบอยสีน้ำเงินเข้ม", 0.1630, 0.0270, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19097, 100, 2, "หมวกคาวบอยสีแดง", 0.1630, 0.0270, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
    {19098, 100, 2, "หมวกคาวบอยสีน้ำตาล", 0.1630, 0.0270, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
    {19352, 100, 2, "หมวกทรงสูง", 0.1039, 0.0210, 0.0060, 93.7000, 74.3000, 0.0000, 1.0, 1.0, 1.0}
};
new ClothingData[MAX_PLAYERS][MAX_CLOTHES][e_cloths];
new cl_buying[MAX_PLAYERS];
new cl_dataslot[MAX_PLAYERS][MAX_CLOTHES];
//new inLabel[MAX_PLAYERS];


// --> ระบบแต่งรถ

#define                 C_ADMIN             0x4169E1FF
#define                 C_AVISO             0xB22222FF

new Text:wTuning1[23];
new Text:wTuning2[9];
new Text:wTuning3[6];
new Text:wTuning4[3];
new Text:wTuning5[3];


enum e_InteriorData {
	e_InteriorName[32],
	e_InteriorID,
	Float:e_InteriorX,
	Float:e_InteriorY,
	Float:e_InteriorZ
};
new const g_arrInteriorData[][e_InteriorData] = {
	{"24/7 1", 17, -25.884498, -185.868988, 1003.546875},
    {"24/7 2", 10, 6.091179, -29.271898, 1003.549438},
    {"24/7 3", 18, -30.946699, -89.609596, 1003.546875},
    {"24/7 4", 16, -25.132598, -139.066986, 1003.546875},
    {"24/7 5", 4, -27.312299, -29.277599, 1003.557250},
    {"24/7 6", 6, -26.691598, -55.714897, 1003.546875},
    {"Airport Ticket", 14, -1827.147338, 7.207417, 1061.143554},
    {"Airport Baggage", 14, -1861.936889, 54.908092, 1061.143554},
    {"Shamal", 1, 1.808619, 32.384357, 1199.593750},
    {"Andromada", 9, 315.745086, 984.969299, 1958.919067},
    {"Ammunation 1", 1, 286.148986, -40.644397, 1001.515625},
    {"Ammunation 2", 4, 286.800994, -82.547599, 1001.515625},
    {"Ammunation 3", 6, 296.919982, -108.071998, 1001.515625},
    {"Ammunation 4", 7, 314.820983, -141.431991, 999.601562},
    {"Ammunation 5", 6, 316.524993, -167.706985, 999.593750},
    {"Ammunation Booths", 7, 302.292877, -143.139099, 1004.062500},
    {"Ammunation Range", 7, 298.507934, -141.647048, 1004.054748},
    {"Blastin Fools Hallway", 3, 1038.531372, 0.111030, 1001.284484},
    {"Budget Inn Motel Room", 12, 444.646911, 508.239044, 1001.419494},
    {"Jefferson Motel", 15, 2215.454833, -1147.475585, 1025.796875},
    {"Off Track Betting Shop", 3, 833.269775, 10.588416, 1004.179687},
    {"Sex Shop", 3, -103.559165, -24.225606, 1000.718750},
    {"Meat Factory", 1, 963.418762, 2108.292480, 1011.030273},
    {"Zero's RC shop", 6, -2240.468505, 137.060440, 1035.414062},
    {"Dillimore Gas", 0, 663.836242, -575.605407, 16.343263},
    {"Catigula's Basement", 1, 2169.461181, 1618.798339, 999.976562},
    {"FC Janitor Room", 10, 1889.953369, 1017.438293, 31.882812},
    {"Woozie's Office", 1, -2159.122802, 641.517517, 1052.381713},
    {"Binco", 15, 207.737991, -109.019996, 1005.132812},
    {"Didier Sachs", 14, 204.332992, -166.694992, 1000.523437},
    {"Prolaps", 3, 207.054992, -138.804992, 1003.507812},
    {"Suburban", 1, 203.777999, -48.492397, 1001.804687},
    {"Victim", 5, 226.293991, -7.431529, 1002.210937},
    {"Zip", 18, 161.391006, -93.159156, 1001.804687},
    {"Club", 17, 493.390991, -22.722799, 1000.679687},
    {"Bar", 11, 501.980987, -69.150199, 998.757812},
    {"Lil' Probe Inn", 18, -227.027999, 1401.229980, 27.765625},
    {"Jay's Diner", 4, 457.304748, -88.428497, 999.554687},
    {"Gant Bridge Diner", 5, 454.973937, -110.104995, 1000.077209},
    {"Secret Valley Diner", 6, 435.271331, -80.958938, 999.554687},
    {"World of Coq", 1, 452.489990, -18.179698, 1001.132812},
    {"Welcome Pump", 1, 681.557861, -455.680053, -25.609874},
    {"Burger Shot", 10, 375.962463, -65.816848, 1001.507812},
    {"Cluckin' Bell", 9, 369.579528, -4.487294, 1001.858886},
    {"Well Stacked Pizza", 5, 373.825653, -117.270904, 1001.499511},
    {"Rusty Browns Donuts", 17, 381.169189, -188.803024, 1000.632812},
    {"Denise's Room", 1, 244.411987, 305.032989, 999.148437},
    {"Katie's Room", 2, 271.884979, 306.631988, 999.148437},
    {"Helena's Room", 3, 291.282989, 310.031982, 999.148437},
    {"Michelle's Room", 4, 302.180999, 300.722991, 999.148437},
    {"Barbara's Room", 5, 322.197998, 302.497985, 999.148437},
    {"Millie's Room", 6, 346.870025, 309.259033, 999.155700},
    {"Sherman Dam", 17, -959.564392, 1848.576782, 9.000000},
    {"Planning Dept", 3, 384.808624, 173.804992, 1008.382812},
    {"Area 51", 0, 223.431976, 1872.400268, 13.734375},
    {"LS Gym", 5, 772.111999, -3.898649, 1000.728820},
    {"SF Gym", 6, 774.213989, -48.924297, 1000.585937},
    {"LV Gym", 7, 773.579956, -77.096694, 1000.655029},
    {"B-Dup's House", 3, 1527.229980, -11.574499, 1002.097106},
    {"B-Dup's Crack Pad", 2, 1523.509887, -47.821197, 1002.130981},
    {"CJ's House", 3, 2496.049804, -1695.238159, 1014.742187},
    {"Madd Doggs Mansion", 5, 1267.663208, -781.323242, 1091.906250},
    {"OG Loc's House", 3, 513.882507, -11.269994, 1001.565307},
    {"Ryders House", 2, 2454.717041, -1700.871582, 1013.515197},
    {"Sweet's House", 1, 2527.654052, -1679.388305, 1015.498596},
    {"Crack Factory", 2, 2543.462646, -1308.379882, 1026.728393},
    {"Big Spread Ranch", 3, 1212.019897, -28.663099, 1000.953125},
    {"Fanny batters", 6, 761.412963, 1440.191650, 1102.703125},
    {"Strip Club", 2, 1204.809936, -11.586799, 1000.921875},
    {"Strip Club (Private Room)", 2, 1204.809936, 13.897239, 1000.921875},
    {"Unnamed Brothel", 3, 942.171997, -16.542755, 1000.929687},
    {"Tiger Skin Brothel", 3, 964.106994, -53.205497, 1001.124572},
    {"Pleasure Domes", 3, -2640.762939, 1406.682006, 906.460937},
    {"Liberty City Outside", 1, -729.276000, 503.086944, 1371.971801},
    {"Liberty City Inside", 1, -794.806396, 497.738037, 1376.195312},
    {"Gang House", 5, 2350.339843, -1181.649902, 1027.976562},
    {"Colonel Furhberger's", 8, 2807.619873, -1171.899902, 1025.570312},
    {"Crack Den", 5, 318.564971, 1118.209960, 1083.882812},
    {"Warehouse 1", 1, 1412.639892, -1.787510, 1000.924377},
    {"Warehouse 2", 18, 1302.519897, -1.787510, 1001.028259},
    {"Sweet's Garage", 0, 2522.000000, -1673.383911, 14.866223},
    {"Lil' Probe Inn Toilet", 18, -221.059051, 1408.984008, 27.773437},
    {"Unused Safe House", 12, 2324.419921, -1145.568359, 1050.710083},
    {"RC Battlefield", 10, -975.975708, 1060.983032, 1345.671875},
    {"Barber 1", 2, 411.625976, -21.433298, 1001.804687},
    {"Barber 2", 3, 418.652984, -82.639793, 1001.804687},
    {"Barber 3", 12, 412.021972, -52.649898, 1001.898437},
    {"Tatoo Parlor 1", 16, -204.439987, -26.453998, 1002.273437},
    {"Tatoo Parlor 2", 17, -204.439987, -8.469599, 1002.273437},
    {"Tatoo Parlor 3", 3, -204.439987, -43.652496, 1002.273437},
    {"LS Police HQ", 6, 246.783996, 63.900199, 1003.640625},
    {"SF Police HQ", 10, 246.375991, 109.245994, 1003.218750},
    {"LV Police HQ", 3, 288.745971, 169.350997, 1007.171875},
    {"Driving School", 3, -2029.798339, -106.675910, 1035.171875},
    {"8-Track", 7, -1398.065307, -217.028900, 1051.115844},
    {"Bloodbowl", 15, -1398.103515, 937.631164, 1036.479125},
    {"Dirt Track", 4, -1444.645507, -664.526000, 1053.572998},
    {"Kickstart", 14, -1465.268676, 1557.868286, 1052.531250},
    {"Vice Stadium", 1, -1401.829956, 107.051300, 1032.273437},
    {"SF Garage", 0, -1790.378295, 1436.949829, 7.187500},
    {"LS Garage", 0, 1643.839843, -1514.819580, 13.566620},
    {"SF Bomb Shop", 0, -1685.636474, 1035.476196, 45.210937},
    {"Blueberry Warehouse", 0, 76.632553, -301.156829, 1.578125},
    {"LV Warehouse 1", 0, 1059.895996, 2081.685791, 10.820312},
    {"LV Warehouse 2 (hidden part)", 0, 1059.180175, 2148.938720, 10.820312},
    {"Caligula's Hidden Room", 1, 2131.507812, 1600.818481, 1008.359375},
    {"Bank", 0, 2315.952880, -1.618174, 26.742187},
    {"Bank (Behind Desk)", 0, 2319.714843, -14.838361, 26.749565},
    {"LS Atrium", 18, 1710.433715, -1669.379272, 20.225049},
    {"Sheriff", 18, -702.1630, 2607.7188, 1006.1084}

};
new g_arrVehicleNames[][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};
/*
enum VEHICLE_DATA
{
	Float:vFuel,
	Float:vSpeed
};
new vehicleData[][VEHICLE_DATA] =
{
//////น้ำมัน//////ความเร็ว//////
	{ 80.0, 159.00 },
	{ 45.0, 148.00 },
	{ 50.0, 188.00 },
	{ 150.0, 110.00 },
	{ 50.0, 134.00 },
	{ 45.0, 165.00 },
	{ 20.0, 111.00 },
	{ 120.0, 149.00 },
	{ 80.0, 101.00 },
	{ 80.0, 159.00 },
	{ 40.0, 131.00 },
	{ 80.0, 223.00 },
	{ 45.0, 170.00 },
	{ 60.0, 111.00 },
	{ 60.0, 106.00 },
	{ 65.0, 194.00 },
	{ 120.0, 155.00 },
	{ 50.0, 1.00 },
	{ 60.0, 116.00 },
	{ 40.0, 150.00 },
	{ 60.0, 146.00 },
	{ 50.0, 155.00 },
	{ 70.0, 141.00 },
	{ 60.0, 99.00 },
	{ 30.0, 136.00 },
	{ 50.0, 1.00 },
	{ 70.0, 175.00 },
	{ 120.0, 167.00 },
	{ 80.0, 158.00 },
	{ 65.0, 203.00 },
	{ 50.0, 1.00 },
	{ 180.0, 131.00 },
	{ 200.0, 95.00 },
	{ 150.0, 111.00 },
	{ 50.0, 168.00 },
	{ 50.0, 1.00 },
	{ 40.0, 150.00 },
	{ 150.0, 159.00 },
	{ 80.0, 144.00 },
	{ 60.0, 170.00 },
	{ 60.0, 137.00 },
	{ 50.0, 1.00 },
	{ 60.0, 140.00 },
	{ 150.0, 127.00 },
	{ 80.0, 111.00 },
	{ 65.0, 165.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 20.0, 116.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 80.0, 195.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 120.0, 159.00 },
	{ 50.0, 107.00 },
	{ 10.0, 96.00 },
	{ 80.0, 158.00 },
	{ 60.0, 137.00 },
	{ 50.0, 1.00 },
	{ 45.0, 167.00 },
	{ 20.0, 107.00 },
	{ 60.0, 142.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 50.0, 148.00 },
	{ 50.0, 141.00 },
	{ 40.0, 143.00 },
	{ 50.0, 1.00 },
	{ 120.0, 158.00 },
	{ 25.0, 111.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 80.0, 150.00 },
	{ 45.0, 174.00 },
	{ 50.0, 1.00 },
	{ 60.0, 188.00 },
	{ 50.0, 118.00 },
	{ 80.0, 141.00 },
	{ 45.0, 186.00 },
	{ 50.0, 1.00 },
	{ 60.0, 158.00 },
	{ 50.0, 124.00 },
	{ 50.0, 1.00 },
	{ 20.0, 100.00 },
	{ 25.0, 65.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 90.0, 140.00 },
	{ 90.0, 158.00 },
	{ 45.0, 150.00 },
	{ 45.0, 141.00 },
	{ 50.0, 1.00 },
	{ 80.0, 216.00 },
	{ 60.0, 178.00 },
	{ 60.0, 164.00 },
	{ 50.0, 1.00 },
	{ 60.0, 109.00 },
	{ 70.0, 124.00 },
	{ 60.0, 141.00 },
	{ 50.0, 1.00 },
	{ 80.0, 216.00 },
	{ 80.0, 216.00 },
	{ 40.0, 174.00 },
	{ 80.0, 140.00 },
	{ 60.0, 180.00 },
	{ 65.0, 167.00 },
	{ 90.0, 108.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 130.0, 121.00 },
	{ 150.0, 143.00 },
	{ 60.0, 158.00 },
	{ 45.0, 158.00 },
	{ 50.0, 165.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 50.0, 169.00 },
	{ 40.0, 190.00 },
	{ 60.0, 168.00 },
	{ 30.0, 131.00 },
	{ 60.0, 162.00 },
	{ 40.0, 159.00 },
	{ 45.0, 150.00 },
	{ 80.0, 178.00 },
	{ 55.0, 150.00 },
	{ 50.0, 61.00 },
	{ 30.0, 71.00 },
	{ 50.0, 111.00 },
	{ 50.0, 168.00 },
	{ 60.0, 170.00 },
	{ 60.0, 159.00 },
	{ 62.0, 174.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 20.0, 100.00 },
	{ 40.0, 150.00 },
	{ 60.0, 204.00 },
	{ 45.0, 165.00 },
	{ 60.0, 152.00 },
	{ 120.0, 149.00 },
	{ 80.0, 148.00 },
	{ 60.0, 150.00 },
	{ 55.0, 144.00 },
	{ 50.0, 1.00 },
	{ 60.0, 154.00 },
	{ 60.0, 146.00 },
	{ 55.0, 158.00 },
	{ 60.0, 122.00 },
	{ 50.0, 1.00 },
	{ 60.0, 145.00 },
	{ 45.0, 159.00 },
	{ 45.0, 111.00 },
	{ 60.0, 111.00 },
	{ 80.0, 157.00 },
	{ 60.0, 179.00 },
	{ 60.0, 170.00 },
	{ 60.0, 155.00 },
	{ 60.0, 179.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 60.0, 166.00 },
	{ 40.0, 161.00 },
	{ 50.0, 174.00 },
	{ 30.0, 147.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 10.0, 94.00 },
	{ 50.0, 61.00 },
	{ 80.0, 111.00 },
	{ 20.0, 61.00 },
	{ 45.0, 159.00 },
	{ 40.0, 159.00 },
	{ 50.0, 1.00 },
	{ 80.0, 131.00 },
	{ 80.0, 159.00 },
	{ 60.0, 154.00 },
	{ 35.0, 168.00 },
	{ 60.0, 137.00 },
	{ 15.0, 86.00 },
	{ 50.0, 1.00 },
	{ 60.0, 154.00 },
	{ 50.0, 158.00 },
	{ 50.0, 166.00 },
	{ 60.0, 109.00 },
	{ 65.0, 164.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 60.0, 177.00 },
	{ 60.0, 177.00 },
	{ 60.0, 177.00 },
	{ 90.0, 159.00 },
	{ 40.0, 152.00 },
	{ 30.0, 111.00 },
	{ 60.0, 170.00 },
	{ 60.0, 172.00 },
	{ 30.0, 148.00 },
	{ 40.0, 152.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 },
	{ 90.0, 108.00 },
	{ 50.0, 1.00 },
	{ 50.0, 1.00 }
};*/


enum VEHICLE_DATA
{
	Float:vFuel,
	Float:vSpeed
};

new vehicleData[][VEHICLE_DATA] =
{
//////น้ำมัน//////ความเร็ว//////
	{ 80.0, 159.00 }, //400
	{ 45.0, 148.00 }, //401
	{ 50.0, 188.00 }, //402
	{ 150.0, 110.00 }, //403
	{ 50.0, 134.00 }, //404
	{ 45.0, 165.00 }, //405
	{ 20.0, 111.00 }, //406
	{ 120.0, 149.00 }, //407
	{ 80.0, 101.00 }, //408
	{ 80.0, 159.00 }, //409
	{ 40.0, 131.00 }, //410
	{ 80.0, 223.00 }, //411
	{ 45.0, 170.00 }, //412
	{ 60.0, 111.00 }, //413 
	{ 60.0, 106.00 }, //414
	{ 65.0, 194.00 }, //415
	{ 120.0, 155.00 }, //416
	{ 50.0, 1.00 }, //417
	{ 60.0, 116.00 }, //418
	{ 40.0, 150.00 }, //419
	{ 60.0, 146.00 }, //420
	{ 50.0, 155.00 }, //421
	{ 70.0, 141.00 }, //422
	{ 60.0, 99.00 }, //423
	{ 30.0, 136.00 }, //424
	{ 50000.0, 1.00 }, //425
	{ 70.0, 175.00 }, //426
	{ 120.0, 167.00 }, //427
	{ 80.0, 158.00 }, //428
	{ 65.0, 203.00 }, //429
	{ 50.0, 1.00 }, //430
	{ 180.0, 131.00 }, //431
	{ 200.0, 95.00 }, //432
	{ 150.0, 111.00 }, //433
	{ 50.0, 168.00 }, //434
	{ 50.0, 1.00 }, //435
	{ 40.0, 150.00 }, //46 
	{ 150.0, 159.00 }, //437 
	{ 80.0, 144.00 }, //438
	{ 60.0, 170.00 }, //439 
	{ 60.0, 137.00 }, //440 
	{ 50.0, 1.00 }, //441
	{ 60.0, 140.00 }, //442 
	{ 150.0, 127.00 }, //443 
	{ 80.0, 111.00 }, //444
	{ 65.0, 165.00 }, //445 
	{ 50.0, 1.00 }, //446
	{ 50.0, 1.00 }, //447 
	{ 20.0, 116.00 }, //448 
	{ 50.0, 1.00 }, //449
	{ 50.0, 1.00 }, //450 
	{ 80.0, 195.00 }, //451 
	{ 50.0, 1.00 }, //452
	{ 50000.0, 1.00 }, //453 
	{ 50.0, 1.00 }, //454
	{ 120.0, 159.00 }, //455 
	{ 50.0, 107.00 }, //456
	{ 10.0, 96.00 }, //457
	{ 80.0, 158.00 }, //458 
	{ 60.0, 137.00 }, //459
	{ 50.0, 1.00 }, //460
	{ 45.0, 167.00 }, //461 
	{ 20.0, 107.00 }, //462 
	{ 60.0, 142.00 }, //463 
	{ 50.0, 1.00 }, //464
	{ 50.0, 1.00 }, //465 
	{ 50.0, 148.00 }, //466 
	{ 50.0, 141.00 }, //467 
	{ 40.0, 143.00 }, //468 
	{ 50.0, 1.00 }, //469
	{ 120.0, 158.00 }, //470 
	{ 25.0, 111.00 }, //471
	{ 50.0, 1.00 }, //472
	{ 50.0, 1.00 }, //473 
	{ 80.0, 150.00 }, //474 
	{ 45.0, 174.00 }, //475 
	{ 50000.0, 1.00 }, //476
	{ 60.0, 188.00 }, //477 
	{ 50.0, 118.00 }, //478 
	{ 80.0, 141.00 }, //479 
	{ 45.0, 186.00 }, //480 
	{ 50.0, 1.00 }, //481
	{ 60.0, 158.00 }, //482 
	{ 50.0, 124.00 }, //483 
	{ 50.0, 1.00 }, //484
	{ 20.0, 100.00 }, //485 
	{ 25.0, 65.00 }, //486 
	{ 50.0, 1.00 }, //487
	{ 50.0, 1.00 }, //488 
	{ 90.0, 140.00 }, //489 
	{ 90.0, 158.00 }, //490
	{ 45.0, 150.00 }, //491 
	{ 45.0, 141.00 }, //492 
	{ 50.0, 1.00 }, //493
	{ 80.0, 216.00 }, //494
	{ 60.0, 178.00 }, //495 
	{ 60.0, 164.00 }, //496 
	{ 50.0, 1.00 }, //497
	{ 60.0, 109.00 }, //498 
	{ 70.0, 124.00 }, //499 
	{ 60.0, 141.00 }, //500 
	{ 50.0, 1.00 }, //501
	{ 80.0, 216.00 }, //502 
	{ 80.0, 216.00 }, //503
	{ 40.0, 174.00 }, //504 
	{ 80.0, 140.00 }, //505 
	{ 60.0, 180.00 }, //506 
	{ 65.0, 167.00 }, //507 
	{ 90.0, 108.00 }, //508
	{ 50.0, 1.00 }, //509
	{ 50.0, 1.00 }, //510
	{ 50000.0, 1.00 }, //511
	{ 50.0, 1.00 }, //512
	{ 50.0, 1.00 }, //513
	{ 130.0, 121.00 }, //514
	{ 150.0, 143.00 }, //515
	{ 60.0, 158.00 }, //516
	{ 45.0, 158.00 }, //517
	{ 50.0, 165.00 }, //518
	{ 50.0, 1.00 }, //519
	{ 50000.0, 1.00 }, //520
	{ 50.0, 169.00 }, //521
	{ 40.0, 190.00 }, //522
	{ 60.0, 168.00 }, //523
	{ 30.0, 131.00 }, //524
	{ 60.0, 162.00 }, //525
	{ 40.0, 159.00 }, //526
	{ 45.0, 150.00 }, //527
	{ 80.0, 178.00 }, //528
	{ 55.0, 150.00 }, //529
	{ 50.0, 61.00 }, //530
	{ 30.0, 71.00 }, //531
	{ 50.0, 111.00 }, //532
	{ 50.0, 168.00 }, //533
	{ 60.0, 170.00 }, //534
	{ 60.0, 159.00 }, //535
	{ 62.0, 174.00 }, //536
	{ 50.0, 1.00 }, //537
	{ 50.0, 1.00 }, //538
	{ 20.0, 100.00 }, //539
	{ 40.0, 150.00 }, //540
	{ 60.0, 204.00 }, //541
	{ 45.0, 165.00 }, //542
	{ 60.0, 152.00 }, //543
	{ 120.0, 149.00 }, //544
	{ 80.0, 148.00 }, //545
	{ 60.0, 150.00 }, //546
	{ 55.0, 144.00 }, //547
	{ 50.0, 1.00 }, //548
	{ 60.0, 154.00 }, //549
	{ 60.0, 146.00 }, //550
	{ 55.0, 158.00 }, //551
	{ 60.0, 122.00 }, //552
	{ 50.0, 1.00 }, //553
	{ 60.0, 145.00 }, //554
	{ 45.0, 159.00 }, //555
	{ 45.0, 111.00 }, //556
	{ 60.0, 111.00 }, //557
	{ 80.0, 157.00 }, //558
	{ 60.0, 179.00 }, //559
	{ 60.0, 170.00 }, //560
	{ 60.0, 155.00 }, //561
	{ 60.0, 179.00 }, //562
	{ 50000.0, 1.00 }, //563
	{ 50.0, 1.00 }, //564
	{ 60.0, 166.00 }, //565
	{ 40.0, 161.00 }, //566
	{ 50.0, 174.00 }, //567
	{ 30.0, 147.00 }, //568
	{ 50.0, 1.00 }, //569
	{ 50.0, 1.00 }, //570
	{ 10.0, 94.00 }, //571
	{ 50.0, 61.00 }, //572
	{ 80.0, 111.00 }, //573
	{ 20.0, 61.00 }, //574
	{ 45.0, 159.00 }, //575
	{ 40.0, 159.00 }, //576
	{ 50.0, 1.00 }, //577
	{ 80.0, 131.00 }, //578
	{ 80.0, 159.00 }, //579
	{ 60.0, 154.00 }, //580
	{ 35.0, 168.00 }, //581
	{ 60.0, 137.00 }, //582
	{ 15.0, 86.00 }, //583
	{ 50.0, 1.00 }, //584
	{ 60.0, 154.00 }, //585
	{ 50.0, 158.00 }, //586
	{ 50.0, 166.00 }, //587
	{ 60.0, 109.00 }, //588
	{ 65.0, 164.00 }, //589
	{ 50.0, 1.00 }, //590
	{ 50.0, 1.00 }, //591
	{ 50.0, 1.00 }, //592
	{ 50.0, 1.00 }, //593
	{ 50.0, 1.00 }, //594
	{ 50.0, 1.00 }, //595
	{ 60.0, 177.00 }, //596
	{ 60.0, 177.00 }, //597
	{ 60.0, 177.00 }, //598
	{ 90.0, 159.00 }, //599
	{ 40.0, 152.00 }, //600
	{ 30.0, 111.00 }, //601
	{ 60.0, 170.00 }, //602
	{ 60.0, 172.00 }, //603
	{ 30.0, 148.00 }, //604
	{ 40.0, 152.00 }, //605
	{ 50.0, 1.00 }, //606
	{ 50.0, 1.00 }, //607
	{ 50.0, 1.00 }, //608
	{ 90.0, 108.00 }, //609
	{ 50.0, 1.00 }, //610
	{ 50.0, 1.00 } //611
};

#define ErrorMsg(%0,%1) \
	SendClientMessageEx(%0, 0xFF0000FF, "{FB5704}พบข้อผิดพลาด : {FFC9AE}"%1)
/*
MYSQL_Update_Character(playerid, option1[], option2)
{
	new query[128];
    mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET %s = %d WHERE ID = %d LIMIT 1", option1, option2, playerData[playerid][pID]);
	mysql_tquery(g_SQL, query);
	return 1;
}*/

#include "system/dynamic/gps.pwn"
#include "system/dynamic/house.pwn"

#include "system/player/Hub.pwn"
#include "system/dynamic/business.pwn"

#include "Jobs/Jobs.pwn"
#include "Jobs/Apple.pwn"
#include "Jobs/ElectricalPole.pwn"
#include "Jobs/Garbage.pwn"
#include "Jobs/Fish.pwn"

#include "system/GPS_Color.pwn"
#include "system/faction.pwn"
#include "system/player/select.pwn"
/*-----------------------New by.Hugo-----------------------*/
#include "Command/mechanic.pwn"
#include "Command/medic.pwn"
#include "Command/anim.pwn"
#include "Command/admin.pwn"
#include "Command/player.pwn"
#include "Command/police.pwn"


#include "system/dynamic/arrest.pwn"
#include "system/dynamic/ATM.pwn"
#include "system/dynamic/Garage.pwn"
#include "system/dynamic/Shop.pwn"
#include "system/dynamic/callcar.pwn"
#include "system/dynamic/skinshop.pwn"
#include "system/dynamic/vehicleshop.pwn"
#include "system/dynamic/trunk.pwn"


#include "system/player/inventory.pwn"
#include "system/player/stamina.pwn"
#include "system/player/weapon-config.pwn"
#include "system/player/zonetext.pwn"
#include "system/player/phone.pwn"
#include "system/player/party.pwn"


#include "system/ecosystem/shop.pwn"
#include "system/ecosystem/robber.pwn"
#include "system/ecosystem/login_Screen.pwn"
#include "system/ecosystem/Market.pwn"
#include "system/ecosystem/toll.pwn"
#include "system/ecosystem/casino.pwn"


#include "system/aboutVehicle.pwn"
#include "system/HubVehicle.pwn"
#include "system/gps.pwn"
#include "system/craftweapon.pwn"
#include "system/driving.pwn"

#include "Map/Garage.pwn"
#include "Map/prison.pwn"
#include "Map/ClosePaint.pwn"
#include "Map/Market.pwn"


#include "Jobs/Wood.pwn"
#include "Jobs/Mines.pwn"


#include "system/server/discord.pwn"
/*-----------------------New by.Hugo-----------------------*/

#include "Gachapong/main.pwn" // ระบบกาชาปอง
#include "Gachapong/reward.pwn" // ระบบกาชาปอง
#include "Gachapong/textdraw.pwn" // ระบบกาชาปอง

#include "system/kachapong.pwn"
#include "system/cargang.pwn"
#include "system/dy.pwn"
#include "system/dispacth.pwn"

// ระบบ 'ดาเมจ'
#include "system/warzone.pwn" // ระบบ 'วอร์โซน' (WarZone)


#include "system/dice.pwn" // ระบบไฮโล Cr.Richard

//#include "system/car_storage.pwn" // ระบบ 'เก็บของในรถ' Cr.Richard
#include "system/busk.pwn" // ระบบ 'เปิดหมวก' Cr.Richard

//#include "system/remote.pwn" // ระบบ 'รีโมทจัดการรถยนต์' (Remote)
//#include "system/holding_weapons.pwn" // ระบบ 'ถืออาวุธในมือ' (Weapon Holding)
#include "system/hospital_LS.pwn" // ระบบ 'ภายในโรงพยาบาล_LS' (Hospital_LS)

#include "system/Mechanic.pwn" // ระบบ 'ช่างซ่อมรถ'
#include "system/case_mechanic.pwn" // ระบบ 'เคสผู้ต้องการช่างซ่อมรถ' (CaseMechanic)
#include "system/case_police.pwn" // ระบบ 'เคสผู้ทำงานผิดกฎหมาย' (CasePolice)


/*#include "system/sleep.pwn" // ระบบ 'นอนเตียงพยาบาล'
#include "system/icu_gang.pwn" // ระบบ 'นอนเตียงสำหรับแก๊ง' (ICU)
#include "system/gov_online.pwn" // ระบบ 'เจ้าหน้าที่รัฐออนไลน์' (GovOnline)
//#include "textdraw/ProgressServer.pwn"*/




// - ระบบมอแกน

#include "system/morgan_tune.pwn" // แต่งรถแบบ Cr.Morgan City

#include "system/foodshop.pwn" // ระบบ 'ร้านอาหาร' Cr.Richard


//#include "system/selldrugs.pwn" // ระบบ 'NPC ขายของผิดกฎหมาย'

main()
{
}


enum GachapongEnumX2
{
	gachaID,
	ModelID,
	Name[32],
}

#include "system/flag_war.pwn"
#include "system/tuneveh.pwn"
#include "system/bborad.pwn"
#include "system/medic.pwn"
#include "system/cortainner.pwn"

// ----------------------->
new FishingZone; //zone
public OnGameModeInit()
{

	
	mysql_log(ERROR | WARNING);
	new MySQLOpt: option_id = mysql_init_options();

	mysql_set_option(option_id, AUTO_RECONNECT, true);

	g_SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE, option_id);
	if (g_SQL == MYSQL_INVALID_HANDLE || mysql_errno(g_SQL) != 0)
	{
		print("[MySQL]: Connection failed. Server is shutting down.");
		SendRconCommand("exit");
		return 1;
	}

	print("[MySQL]: Connection is successful.");

	mysql_set_charset("tis620");


    Server_Load();
	mysql_tquery(g_SQL, "SELECT * FROM `Settings` LIMIT 1", "LoadSettings");
	mysql_tquery(g_SQL, "SELECT * FROM `factions`", "Faction_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `arrestpoints`", "Arrest_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `gps`", "GPS_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `atm`", "ATM_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `shops`", "Shop_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `garages`", "Garage_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `entrances`", "Entrance_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `vehicles` WHERE carOwnerID = 0", "Vehicle_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `houses`", "House_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `carshop`", "CARSHOP_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `safezonedata`", "LoadSafeZones");
    mysql_tquery(g_SQL, "SELECT * FROM `vehiclegang`", "Load_VehicleGang");
    mysql_tquery(g_SQL, "SELECT * FROM `callcar`", "Callcar_Load", "");
    mysql_tquery(g_SQL, "SELECT * FROM `pawnveh`", "Pawnveh_Load", "");
    mysql_tquery(g_SQL, "SELECT * FROM board", "BOARD_Load", "");
    mysql_tquery(g_SQL, "SELECT * FROM cartune", "cartune_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `vehicleshop`", "VehicleShop_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `pickcar`", "Pickcar_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `objectt`", "Objectt_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `business`", "Business_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `skinshop`", "SKINSHOP_Load", "");


	Server_Save2();
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
	ShowNameTags(1);
	SetNameTagDrawDistance(7.0);

	ManualVehicleEngineAndLights();
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);

	SetTimer("GeneralListener", 1000, true);

	FishingZone = GangZoneCreate(218.00018310546875, -2658.5003356933594, 898.0001831054688, -2373.5003356933594);

	PIERON_TD[0] = TextDrawCreate(540.000000, 420.000000, "PIE");
	TextDrawFont(PIERON_TD[0], 2);
	TextDrawLetterSize(PIERON_TD[0], 0.600000, 2.000000);
	TextDrawTextSize(PIERON_TD[0], 400.000000, 17.000000);
	TextDrawSetOutline(PIERON_TD[0], 1);
	TextDrawSetShadow(PIERON_TD[0], 1);
	TextDrawAlignment(PIERON_TD[0], 1);
	TextDrawColor(PIERON_TD[0], -16776961);
	TextDrawBackgroundColor(PIERON_TD[0], 255);
	TextDrawBoxColor(PIERON_TD[0], 50);
	TextDrawUseBox(PIERON_TD[0], 0);
	TextDrawSetProportional(PIERON_TD[0], 1);
	TextDrawSetSelectable(PIERON_TD[0], 0);

	PIERON_TD[1] = TextDrawCreate(490.000000, 420.000000, "RON");
	TextDrawFont(PIERON_TD[1], 2);
	TextDrawLetterSize(PIERON_TD[1], 0.600000, 2.000000);
	TextDrawTextSize(PIERON_TD[1], 400.000000, 17.000000);
	TextDrawSetOutline(PIERON_TD[1], 1);
	TextDrawSetShadow(PIERON_TD[1], 0);
	TextDrawAlignment(PIERON_TD[1], 1);
	TextDrawColor(PIERON_TD[1], -1);
	TextDrawBackgroundColor(PIERON_TD[1], 255);
	TextDrawBoxColor(PIERON_TD[1], 50);
	TextDrawUseBox(PIERON_TD[1], 0);
	TextDrawSetProportional(PIERON_TD[1], 1);
	TextDrawSetSelectable(PIERON_TD[1], 0);

	PIERON_TD[2] = TextDrawCreate(485.000000, 420.000000, "i");
	TextDrawFont(PIERON_TD[2], 1);
	TextDrawLetterSize(PIERON_TD[2], 0.600000, 2.000000);
	TextDrawTextSize(PIERON_TD[2], 400.000000, 17.000000);
	TextDrawSetOutline(PIERON_TD[2], 1);
	TextDrawSetShadow(PIERON_TD[2], 0);
	TextDrawAlignment(PIERON_TD[2], 1);
	TextDrawColor(PIERON_TD[2], -16776961);
	TextDrawBackgroundColor(PIERON_TD[2], 255);
	TextDrawBoxColor(PIERON_TD[2], 50);
	TextDrawUseBox(PIERON_TD[2], 0);
	TextDrawSetProportional(PIERON_TD[2], 1);
	TextDrawSetSelectable(PIERON_TD[2], 0);

	PIERON_TD[3] = TextDrawCreate(578.000000, 420.000000, "CITY");
	TextDrawFont(PIERON_TD[3], 1);
	TextDrawLetterSize(PIERON_TD[3], 0.600000, 2.000000);
	TextDrawTextSize(PIERON_TD[3], 400.000000, 17.000000);
	TextDrawSetOutline(PIERON_TD[3], 1);
	TextDrawSetShadow(PIERON_TD[3], 0);
	TextDrawAlignment(PIERON_TD[3], 1);
	TextDrawColor(PIERON_TD[3], -1);
	TextDrawBackgroundColor(PIERON_TD[3], 255);
	TextDrawBoxColor(PIERON_TD[3], 50);
	TextDrawUseBox(PIERON_TD[3], 0);
	TextDrawSetProportional(PIERON_TD[3], 1);
	TextDrawSetSelectable(PIERON_TD[3], 0);


/////////////////////////////////////


	PVPZone = CreateDynamicRectangle(1862.2203, -1450.5480, 1976.4160, -1350.7289, -1, -1, -1);

	SendRconCommand("hostname "SERVER_NAME" | "SERVER_VERSION"");
	SendRconCommand("gamemodetext "SERVER_MODE"");
	SendRconCommand("language "SERVER_LANGUAGE"");
	SendRconCommand("weburl "SERVER_WEBSITE"");

    SetWeather(globalWeather);
    UpdateTime();
    ManualVehicleEngineAndLights();
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);

	//CreateVehicles();
	LimitPlayerMarkerRadius(20.0);
	StockAddMenuItem();

    SetTimerEx("RespawnAllVehicles", 120000*60, false, "d", 1);


	// รัฐออนไลน์
/*	Government_Online[0] = TextDrawCreate(343.000000, 8.000000, "HUD:radar_police");
	TextDrawFont(Government_Online[0], 4);
	TextDrawLetterSize(Government_Online[0], 0.600000, 2.000000);
	TextDrawTextSize(Government_Online[0], 10.000000, 12.000000);
	TextDrawSetOutline(Government_Online[0], 1);
	TextDrawSetShadow(Government_Online[0], 0);
	TextDrawAlignment(Government_Online[0], 1);
	TextDrawColor(Government_Online[0], -1);
	TextDrawBackgroundColor(Government_Online[0], 255);
	TextDrawBoxColor(Government_Online[0], 50);
	TextDrawUseBox(Government_Online[0], 1);
	TextDrawSetProportional(Government_Online[0], 1);
	TextDrawSetSelectable(Government_Online[0], 0);

	Government_Online[1] = TextDrawCreate(357.000000, 7.000000, "2");
	TextDrawFont(Government_Online[1], 2);
	TextDrawLetterSize(Government_Online[1], 0.237500, 1.500000);
	TextDrawTextSize(Government_Online[1], 400.000000, 17.000000);
	TextDrawSetOutline(Government_Online[1], 1);
	TextDrawSetShadow(Government_Online[1], 0);
	TextDrawAlignment(Government_Online[1], 1);
	TextDrawColor(Government_Online[1], -1);
	TextDrawBackgroundColor(Government_Online[1], 255);
	TextDrawBoxColor(Government_Online[1], 50);
	TextDrawUseBox(Government_Online[1], 0);
	TextDrawSetProportional(Government_Online[1], 1);
	TextDrawSetSelectable(Government_Online[1], 0);

	Government_Online[2] = TextDrawCreate(383.000000, 8.000000, "HUD:radar_hostpital");
	TextDrawFont(Government_Online[2], 4);
	TextDrawLetterSize(Government_Online[2], 0.600000, 2.000000);
	TextDrawTextSize(Government_Online[2], 10.000000, 12.000000);
	TextDrawSetOutline(Government_Online[2], 1);
	TextDrawSetShadow(Government_Online[2], 0);
	TextDrawAlignment(Government_Online[2], 1);
	TextDrawColor(Government_Online[2], -1);
	TextDrawBackgroundColor(Government_Online[2], 255);
	TextDrawBoxColor(Government_Online[2], 50);
	TextDrawUseBox(Government_Online[2], 1);
	TextDrawSetProportional(Government_Online[2], 1);
	TextDrawSetSelectable(Government_Online[2], 0);

	Government_Online[3] = TextDrawCreate(397.000000, 7.000000, "3");
	TextDrawFont(Government_Online[3], 2);
	TextDrawLetterSize(Government_Online[3], 0.237500, 1.500000);
	TextDrawTextSize(Government_Online[3], 400.000000, 17.000000);
	TextDrawSetOutline(Government_Online[3], 1);
	TextDrawSetShadow(Government_Online[3], 0);
	TextDrawAlignment(Government_Online[3], 1);
	TextDrawColor(Government_Online[3], -1);
	TextDrawBackgroundColor(Government_Online[3], 255);
	TextDrawBoxColor(Government_Online[3], 50);
	TextDrawUseBox(Government_Online[3], 0);
	TextDrawSetProportional(Government_Online[3], 1);
	TextDrawSetSelectable(Government_Online[3], 0);

	Government_Online[4] = TextDrawCreate(421.000000, 8.000000, "HUD:radar_modgarage");
	TextDrawFont(Government_Online[4], 4);
	TextDrawLetterSize(Government_Online[4], 0.600000, 2.000000);
	TextDrawTextSize(Government_Online[4], 10.000000, 12.000000);
	TextDrawSetOutline(Government_Online[4], 1);
	TextDrawSetShadow(Government_Online[4], 0);
	TextDrawAlignment(Government_Online[4], 1);
	TextDrawColor(Government_Online[4], -1);
	TextDrawBackgroundColor(Government_Online[4], 255);
	TextDrawBoxColor(Government_Online[4], 50);
	TextDrawUseBox(Government_Online[4], 1);
	TextDrawSetProportional(Government_Online[4], 1);
	TextDrawSetSelectable(Government_Online[4], 0);

	Government_Online[5] = TextDrawCreate(436.000000, 7.000000, "4");
	TextDrawFont(Government_Online[5], 2);
	TextDrawLetterSize(Government_Online[5], 0.237500, 1.500000);
	TextDrawTextSize(Government_Online[5], 400.000000, 17.000000);
	TextDrawSetOutline(Government_Online[5], 1);
	TextDrawSetShadow(Government_Online[5], 0);
	TextDrawAlignment(Government_Online[5], 1);
	TextDrawColor(Government_Online[5], -1);
	TextDrawBackgroundColor(Government_Online[5], 255);
	TextDrawBoxColor(Government_Online[5], 50);
	TextDrawUseBox(Government_Online[5], 0);
	TextDrawSetProportional(Government_Online[5], 1);
	TextDrawSetSelectable(Government_Online[5], 0);*/




	// --> ระบบแต่งรถ

	wTuning1[0] = TextDrawCreate(560.000000, 102.000000, "_");
	TextDrawBackgroundColor(wTuning1[0], 255);
	TextDrawFont(wTuning1[0], 1);
	TextDrawLetterSize(wTuning1[0], 0.709999, 1.599998);
	TextDrawColor(wTuning1[0], 852308735);
	TextDrawSetOutline(wTuning1[0], 0);
	TextDrawSetProportional(wTuning1[0], 1);
	TextDrawSetShadow(wTuning1[0], 1);
	TextDrawUseBox(wTuning1[0], 1);
	TextDrawBoxColor(wTuning1[0], 793726975);
	TextDrawTextSize(wTuning1[0], 72.000000, 20.000000);
	TextDrawSetSelectable(wTuning1[0], 0);

	wTuning1[1] = TextDrawCreate(560.000000, 120.000000, "_");
	TextDrawBackgroundColor(wTuning1[1], 255);
	TextDrawFont(wTuning1[1], 1);
	TextDrawLetterSize(wTuning1[1], 0.709999, 1.699998);
	TextDrawColor(wTuning1[1], -1);
	TextDrawSetOutline(wTuning1[1], 0);
	TextDrawSetProportional(wTuning1[1], 1);
	TextDrawSetShadow(wTuning1[1], 1);
	TextDrawUseBox(wTuning1[1], 1);
	TextDrawBoxColor(wTuning1[1], 150);
	TextDrawTextSize(wTuning1[1], 72.000000, 20.000000);
	TextDrawSetSelectable(wTuning1[1], 0);

	wTuning1[2] = TextDrawCreate(243.000000, 144.000000, "_");
	TextDrawBackgroundColor(wTuning1[2], 255);
	TextDrawFont(wTuning1[2], 1);
	TextDrawLetterSize(wTuning1[2], 0.709999, 21.299999);
	TextDrawColor(wTuning1[2], -1);
	TextDrawSetOutline(wTuning1[2], 0);
	TextDrawSetProportional(wTuning1[2], 1);
	TextDrawSetShadow(wTuning1[2], 1);
	TextDrawUseBox(wTuning1[2], 1);
	TextDrawBoxColor(wTuning1[2], 150);
	TextDrawTextSize(wTuning1[2], 72.000000, 19.000000);
	TextDrawSetSelectable(wTuning1[2], 0);

	wTuning1[3] = TextDrawCreate(271.000000, 105.000000, "Tuning Car");
	TextDrawBackgroundColor(wTuning1[3], 255);
	TextDrawFont(wTuning1[3], 2);
	TextDrawLetterSize(wTuning1[3], 0.300000, 1.000000);
	TextDrawColor(wTuning1[3], -1);
	TextDrawSetOutline(wTuning1[3], 0);
	TextDrawSetProportional(wTuning1[3], 1);
	TextDrawSetShadow(wTuning1[3], 0);
	TextDrawSetSelectable(wTuning1[3], 0);

	wTuning1[4] = TextDrawCreate(368.000000, 152.000000, "Welcome to Tuning Menu");
	TextDrawBackgroundColor(wTuning1[4], 255);
	TextDrawFont(wTuning1[4], 2);
	TextDrawLetterSize(wTuning1[4], 0.250000, 1.100000);
	TextDrawColor(wTuning1[4], -1);
	TextDrawSetOutline(wTuning1[4], 0);
	TextDrawSetProportional(wTuning1[4], 1);
	TextDrawSetShadow(wTuning1[4], 0);
	TextDrawSetSelectable(wTuning1[4], 0);

	wTuning1[5] = TextDrawCreate(560.000000, 144.000000, "_");
	TextDrawBackgroundColor(wTuning1[5], 255);
	TextDrawFont(wTuning1[5], 1);
	TextDrawLetterSize(wTuning1[5], 0.709999, 2.900000);
	TextDrawColor(wTuning1[5], -1);
	TextDrawSetOutline(wTuning1[5], 0);
	TextDrawSetProportional(wTuning1[5], 1);
	TextDrawSetShadow(wTuning1[5], 1);
	TextDrawUseBox(wTuning1[5], 1);
	TextDrawBoxColor(wTuning1[5], 793726975);
	TextDrawTextSize(wTuning1[5], 247.000000, 19.000000);
	TextDrawSetSelectable(wTuning1[5], 0);

	wTuning1[6] = TextDrawCreate(538.000000, 105.000000, "X");
	TextDrawBackgroundColor(wTuning1[6], 255);
	TextDrawFont(wTuning1[6], 1);
	TextDrawLetterSize(wTuning1[6], 0.500000, 1.000000);
	TextDrawColor(wTuning1[6], 255);
	TextDrawSetOutline(wTuning1[6], 0);
	TextDrawSetProportional(wTuning1[6], 1);
	TextDrawSetShadow(wTuning1[6], 0);
	TextDrawUseBox(wTuning1[6], 1);
	TextDrawBoxColor(wTuning1[6], 0);
	TextDrawTextSize(wTuning1[6], 550.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[6], 1);

	wTuning1[7] = TextDrawCreate(88.000000, 123.000000, "Wheels");
	TextDrawBackgroundColor(wTuning1[7], 255);
	TextDrawFont(wTuning1[7], 2);
	TextDrawLetterSize(wTuning1[7], 0.300000, 1.000000);
	TextDrawColor(wTuning1[7], -1);
	TextDrawSetOutline(wTuning1[7], 0);
	TextDrawSetProportional(wTuning1[7], 1);
	TextDrawSetShadow(wTuning1[7], 0);
	TextDrawUseBox(wTuning1[7], 1);
	TextDrawBoxColor(wTuning1[7], 0);
	TextDrawTextSize(wTuning1[7], 137.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[7], 0);

	wTuning1[8] = TextDrawCreate(150.000000, 123.000000, "Color");
	TextDrawBackgroundColor(wTuning1[8], 255);
	TextDrawFont(wTuning1[8], 2);
	TextDrawLetterSize(wTuning1[8], 0.300000, 1.000000);
	TextDrawColor(wTuning1[8], -1);
	TextDrawSetOutline(wTuning1[8], 0);
	TextDrawSetProportional(wTuning1[8], 1);
	TextDrawSetShadow(wTuning1[8], 0);
	TextDrawUseBox(wTuning1[8], 1);
	TextDrawBoxColor(wTuning1[8], 0);
	TextDrawTextSize(wTuning1[8], 190.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[8], 0);

	wTuning1[9] = TextDrawCreate(204.000000, 123.000000, "paintjobs");
	TextDrawBackgroundColor(wTuning1[9], 255);
	TextDrawFont(wTuning1[9], 2);
	TextDrawLetterSize(wTuning1[9], 0.300000, 1.000000);
	TextDrawColor(wTuning1[9], -1);
	TextDrawSetOutline(wTuning1[9], 0);
	TextDrawSetProportional(wTuning1[9], 1);
	TextDrawSetShadow(wTuning1[9], 0);
	TextDrawUseBox(wTuning1[9], 1);
	TextDrawBoxColor(wTuning1[9], 0);
	TextDrawTextSize(wTuning1[9], 274.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[9], 0);

	wTuning1[10] = TextDrawCreate(284.000000, 123.000000, "nitro");
	TextDrawBackgroundColor(wTuning1[10], 255);
	TextDrawFont(wTuning1[10], 2);
	TextDrawLetterSize(wTuning1[10], 0.300000, 1.000000);
	TextDrawColor(wTuning1[10], -1);
	TextDrawSetOutline(wTuning1[10], 0);
	TextDrawSetProportional(wTuning1[10], 1);
	TextDrawSetShadow(wTuning1[10], 0);
	TextDrawUseBox(wTuning1[10], 1);
	TextDrawBoxColor(wTuning1[10], 0);
	TextDrawTextSize(wTuning1[10], 320.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[10], 0);

	wTuning1[11] = TextDrawCreate(334.000000, 123.000000, "hydraulics");
	TextDrawBackgroundColor(wTuning1[11], 255);
	TextDrawFont(wTuning1[11], 2);
	TextDrawLetterSize(wTuning1[11], 0.300000, 1.000000);
	TextDrawColor(wTuning1[11], -1);
	TextDrawSetOutline(wTuning1[11], 0);
	TextDrawSetProportional(wTuning1[11], 1);
	TextDrawSetShadow(wTuning1[11], 0);
	TextDrawUseBox(wTuning1[11], 1);
	TextDrawBoxColor(wTuning1[11], 0);
	TextDrawTextSize(wTuning1[11], 411.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[11], 0);

	wTuning1[12] = TextDrawCreate(424.000000, 123.000000, "neon");
	TextDrawBackgroundColor(wTuning1[12], 255);
	TextDrawFont(wTuning1[12], 2);
	TextDrawLetterSize(wTuning1[12], 0.300000, 1.000000);
	TextDrawColor(wTuning1[12], -1);
	TextDrawSetOutline(wTuning1[12], 0);
	TextDrawSetProportional(wTuning1[12], 1);
	TextDrawSetShadow(wTuning1[12], 0);
	TextDrawUseBox(wTuning1[12], 1);
	TextDrawBoxColor(wTuning1[12], 0);
	TextDrawTextSize(wTuning1[12], 457.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[12], 0);

	wTuning1[13] = TextDrawCreate(466.000000, 123.000000, "autotuning");
	TextDrawBackgroundColor(wTuning1[13], 255);
	TextDrawFont(wTuning1[13], 2);
	TextDrawLetterSize(wTuning1[13], 0.300000, 1.000000);
	TextDrawColor(wTuning1[13], -1);
	TextDrawSetOutline(wTuning1[13], 0);
	TextDrawSetProportional(wTuning1[13], 1);
	TextDrawSetShadow(wTuning1[13], 0);
	TextDrawUseBox(wTuning1[13], 1);
	TextDrawBoxColor(wTuning1[13], 0);
	TextDrawTextSize(wTuning1[13], 542.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[13], 0);

	wTuning1[14] = TextDrawCreate(88.000000, 149.000000, "Black___________________");
	TextDrawBackgroundColor(wTuning1[14], 255);
	TextDrawFont(wTuning1[14], 2);
	TextDrawLetterSize(wTuning1[14], 0.300000, 1.000000);
	TextDrawColor(wTuning1[14], -1);
	TextDrawSetOutline(wTuning1[14], 0);
	TextDrawSetProportional(wTuning1[14], 1);
	TextDrawSetShadow(wTuning1[14], 0);
	TextDrawUseBox(wTuning1[14], 1);
	TextDrawBoxColor(wTuning1[14], 0);
	TextDrawTextSize(wTuning1[14], 190.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[14], 0);

	wTuning1[15] = TextDrawCreate(88.000000, 168.000000, "White____________________");
	TextDrawBackgroundColor(wTuning1[15], 255);
	TextDrawFont(wTuning1[15], 2);
	TextDrawLetterSize(wTuning1[15], 0.300000, 1.000000);
	TextDrawColor(wTuning1[15], -1);
	TextDrawSetOutline(wTuning1[15], 0);
	TextDrawSetProportional(wTuning1[15], 1);
	TextDrawSetShadow(wTuning1[15], 0);
	TextDrawUseBox(wTuning1[15], 1);
	TextDrawBoxColor(wTuning1[15], 0);
	TextDrawTextSize(wTuning1[15], 170.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[15], 0);

	wTuning1[16] = TextDrawCreate(88.000000, 190.000000, "Green___________________");
	TextDrawBackgroundColor(wTuning1[16], 255);
	TextDrawFont(wTuning1[16], 2);
	TextDrawLetterSize(wTuning1[16], 0.300000, 1.000000);
	TextDrawColor(wTuning1[16], -1);
	TextDrawSetOutline(wTuning1[16], 0);
	TextDrawSetProportional(wTuning1[16], 1);
	TextDrawSetShadow(wTuning1[16], 0);
	TextDrawUseBox(wTuning1[16], 1);
	TextDrawBoxColor(wTuning1[16], 0);
	TextDrawTextSize(wTuning1[16], 171.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[16], 0);

	wTuning1[17] = TextDrawCreate(88.000000, 213.000000, "Cyan_____________________");
	TextDrawBackgroundColor(wTuning1[17], 255);
	TextDrawFont(wTuning1[17], 2);
	TextDrawLetterSize(wTuning1[17], 0.300000, 1.000000);
	TextDrawColor(wTuning1[17], -1);
	TextDrawSetOutline(wTuning1[17], 0);
	TextDrawSetProportional(wTuning1[17], 1);
	TextDrawSetShadow(wTuning1[17], 0);
	TextDrawUseBox(wTuning1[17], 1);
	TextDrawBoxColor(wTuning1[17], 0);
	TextDrawTextSize(wTuning1[17], 171.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[17], 0);

	wTuning1[18] = TextDrawCreate(88.000000, 233.000000, "Blue_____________________");
	TextDrawBackgroundColor(wTuning1[18], 255);
	TextDrawFont(wTuning1[18], 2);
	TextDrawLetterSize(wTuning1[18], 0.300000, 1.000000);
	TextDrawColor(wTuning1[18], -1);
	TextDrawSetOutline(wTuning1[18], 0);
	TextDrawSetProportional(wTuning1[18], 1);
	TextDrawSetShadow(wTuning1[18], 0);
	TextDrawUseBox(wTuning1[18], 1);
	TextDrawBoxColor(wTuning1[18], 0);
	TextDrawTextSize(wTuning1[18], 170.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[18], 0);

	wTuning1[19] = TextDrawCreate(87.000000, 254.000000, "Yellow________________");
	TextDrawBackgroundColor(wTuning1[19], 255);
	TextDrawFont(wTuning1[19], 2);
	TextDrawLetterSize(wTuning1[19], 0.300000, 1.000000);
	TextDrawColor(wTuning1[19], -1);
	TextDrawSetOutline(wTuning1[19], 0);
	TextDrawSetProportional(wTuning1[19], 1);
	TextDrawSetShadow(wTuning1[19], 0);
	TextDrawUseBox(wTuning1[19], 1);
	TextDrawBoxColor(wTuning1[19], 0);
	TextDrawTextSize(wTuning1[19], 180.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[19], 0);

	wTuning1[20] = TextDrawCreate(87.000000, 275.000000, "gray_____________________");
	TextDrawBackgroundColor(wTuning1[20], 255);
	TextDrawFont(wTuning1[20], 2);
	TextDrawLetterSize(wTuning1[20], 0.300000, 1.000000);
	TextDrawColor(wTuning1[20], -1);
	TextDrawSetOutline(wTuning1[20], 0);
	TextDrawSetProportional(wTuning1[20], 1);
	TextDrawSetShadow(wTuning1[20], 0);
	TextDrawUseBox(wTuning1[20], 1);
	TextDrawBoxColor(wTuning1[20], 0);
	TextDrawTextSize(wTuning1[20], 229.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[20], 0);

	wTuning1[21] = TextDrawCreate(87.000000, 293.000000, "Pink_____________________");
	TextDrawBackgroundColor(wTuning1[21], 255);
	TextDrawFont(wTuning1[21], 2);
	TextDrawLetterSize(wTuning1[21], 0.300000, 1.000000);
	TextDrawColor(wTuning1[21], -1);
	TextDrawSetOutline(wTuning1[21], 0);
	TextDrawSetProportional(wTuning1[21], 1);
	TextDrawSetShadow(wTuning1[21], 0);
	TextDrawUseBox(wTuning1[21], 1);
	TextDrawBoxColor(wTuning1[21], 0);
	TextDrawTextSize(wTuning1[21], 170.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[21], 0);

	wTuning1[22] = TextDrawCreate(87.000000, 312.000000, "Orange________________");
	TextDrawBackgroundColor(wTuning1[22], 255);
	TextDrawFont(wTuning1[22], 2);
	TextDrawLetterSize(wTuning1[22], 0.300000, 1.000000);
	TextDrawColor(wTuning1[22], -1);
	TextDrawSetOutline(wTuning1[22], 0);
	TextDrawSetProportional(wTuning1[22], 1);
	TextDrawSetShadow(wTuning1[22], 0);
	TextDrawUseBox(wTuning1[22], 1);
	TextDrawBoxColor(wTuning1[22], 0);
	TextDrawTextSize(wTuning1[22], 170.000000, 10.000000);
	TextDrawSetSelectable(wTuning1[22], 0);

	wTuning2[0] = TextDrawCreate(88.000000, 149.000000, "shadow________________");
	TextDrawBackgroundColor(wTuning2[0], 255);
	TextDrawFont(wTuning2[0], 2);
	TextDrawLetterSize(wTuning2[0], 0.300000, 1.000000);
	TextDrawColor(wTuning2[0], -1);
	TextDrawSetOutline(wTuning2[0], 0);
	TextDrawSetProportional(wTuning2[0], 1);
	TextDrawSetShadow(wTuning2[0], 0);
	TextDrawUseBox(wTuning2[0], 1);
	TextDrawBoxColor(wTuning2[0], 0);
	TextDrawTextSize(wTuning2[0], 190.000000, 10.000000);
	TextDrawSetSelectable(wTuning2[0], 0);

	wTuning2[1] = TextDrawCreate(88.000000, 168.000000, "mega_____________________");
	TextDrawBackgroundColor(wTuning2[1], 255);
	TextDrawFont(wTuning2[1], 2);
	TextDrawLetterSize(wTuning2[1], 0.300000, 1.000000);
	TextDrawColor(wTuning2[1], -1);
	TextDrawSetOutline(wTuning2[1], 0);
	TextDrawSetProportional(wTuning2[1], 1);
	TextDrawSetShadow(wTuning2[1], 0);
	TextDrawUseBox(wTuning2[1], 1);
	TextDrawBoxColor(wTuning2[1], 0);
	TextDrawTextSize(wTuning2[1], 170.000000, 10.000000);
	TextDrawSetSelectable(wTuning2[1], 0);

	wTuning2[2] = TextDrawCreate(88.000000, 190.000000, "rimshine_____________");
	TextDrawBackgroundColor(wTuning2[2], 255);
	TextDrawFont(wTuning2[2], 2);
	TextDrawLetterSize(wTuning2[2], 0.300000, 1.000000);
	TextDrawColor(wTuning2[2], -1);
	TextDrawSetOutline(wTuning2[2], 0);
	TextDrawSetProportional(wTuning2[2], 1);
	TextDrawSetShadow(wTuning2[2], 0);
	TextDrawUseBox(wTuning2[2], 1);
	TextDrawBoxColor(wTuning2[2], 0);
	TextDrawTextSize(wTuning2[2], 171.000000, 10.000000);
	TextDrawSetSelectable(wTuning2[2], 0);

	wTuning2[3] = TextDrawCreate(88.000000, 213.000000, "Wires___________________");
	TextDrawBackgroundColor(wTuning2[3], 255);
	TextDrawFont(wTuning2[3], 2);
	TextDrawLetterSize(wTuning2[3], 0.300000, 1.000000);
	TextDrawColor(wTuning2[3], -1);
	TextDrawSetOutline(wTuning2[3], 0);
	TextDrawSetProportional(wTuning2[3], 1);
	TextDrawSetShadow(wTuning2[3], 0);
	TextDrawUseBox(wTuning2[3], 1);
	TextDrawBoxColor(wTuning2[3], 0);
	TextDrawTextSize(wTuning2[3], 171.000000, 10.000000);
	TextDrawSetSelectable(wTuning2[3], 0);

	wTuning2[4] = TextDrawCreate(88.000000, 233.000000, "classic________________");
	TextDrawBackgroundColor(wTuning2[4], 255);
	TextDrawFont(wTuning2[4], 2);
	TextDrawLetterSize(wTuning2[4], 0.300000, 1.000000);
	TextDrawColor(wTuning2[4], -1);
	TextDrawSetOutline(wTuning2[4], 0);
	TextDrawSetProportional(wTuning2[4], 1);
	TextDrawSetShadow(wTuning2[4], 0);
	TextDrawUseBox(wTuning2[4], 1);
	TextDrawBoxColor(wTuning2[4], 0);
	TextDrawTextSize(wTuning2[4], 170.000000, 10.000000);
	TextDrawSetSelectable(wTuning2[4], 0);

	wTuning2[5] = TextDrawCreate(87.000000, 254.000000, "twist____________________");
	TextDrawBackgroundColor(wTuning2[5], 255);
	TextDrawFont(wTuning2[5], 2);
	TextDrawLetterSize(wTuning2[5], 0.300000, 1.000000);
	TextDrawColor(wTuning2[5], -1);
	TextDrawSetOutline(wTuning2[5], 0);
	TextDrawSetProportional(wTuning2[5], 1);
	TextDrawSetShadow(wTuning2[5], 0);
	TextDrawUseBox(wTuning2[5], 1);
	TextDrawBoxColor(wTuning2[5], 0);
	TextDrawTextSize(wTuning2[5], 180.000000, 10.000000);
	TextDrawSetSelectable(wTuning2[5], 0);

	wTuning2[6] = TextDrawCreate(87.000000, 275.000000, "cutter_________________");
	TextDrawBackgroundColor(wTuning2[6], 255);
	TextDrawFont(wTuning2[6], 2);
	TextDrawLetterSize(wTuning2[6], 0.300000, 1.000000);
	TextDrawColor(wTuning2[6], -1);
	TextDrawSetOutline(wTuning2[6], 0);
	TextDrawSetProportional(wTuning2[6], 1);
	TextDrawSetShadow(wTuning2[6], 0);
	TextDrawUseBox(wTuning2[6], 1);
	TextDrawBoxColor(wTuning2[6], 0);
	TextDrawTextSize(wTuning2[6], 180.000000, 10.000000);
	TextDrawSetSelectable(wTuning2[6], 0);

	wTuning2[7] = TextDrawCreate(87.000000, 293.000000, "Dollar_________________");
	TextDrawBackgroundColor(wTuning2[7], 255);
	TextDrawFont(wTuning2[7], 2);
	TextDrawLetterSize(wTuning2[7], 0.300000, 1.000000);
	TextDrawColor(wTuning2[7], -1);
	TextDrawSetOutline(wTuning2[7], 0);
	TextDrawSetProportional(wTuning2[7], 1);
	TextDrawSetShadow(wTuning2[7], 0);
	TextDrawUseBox(wTuning2[7], 1);
	TextDrawBoxColor(wTuning2[7], 0);
	TextDrawTextSize(wTuning2[7], 170.000000, 10.000000);
	TextDrawSetSelectable(wTuning2[7], 0);

	wTuning2[8] = TextDrawCreate(87.000000, 312.000000, "Atomic__________________");
	TextDrawBackgroundColor(wTuning2[8], 255);
	TextDrawFont(wTuning2[8], 2);
	TextDrawLetterSize(wTuning2[8], 0.300000, 1.000000);
	TextDrawColor(wTuning2[8], -1);
	TextDrawSetOutline(wTuning2[8], 0);
	TextDrawSetProportional(wTuning2[8], 1);
	TextDrawSetShadow(wTuning2[8], 0);
	TextDrawUseBox(wTuning2[8], 1);
	TextDrawBoxColor(wTuning2[8], 0);
	TextDrawTextSize(wTuning2[8], 170.000000, 10.000000);
	TextDrawSetSelectable(wTuning2[8], 0);

	wTuning3[0] = TextDrawCreate(88.000000, 149.000000, "Blue");
	TextDrawBackgroundColor(wTuning3[0], 255);
	TextDrawFont(wTuning3[0], 2);
	TextDrawLetterSize(wTuning3[0], 0.300000, 1.000000);
	TextDrawColor(wTuning3[0], -1);
	TextDrawSetOutline(wTuning3[0], 0);
	TextDrawSetProportional(wTuning3[0], 1);
	TextDrawSetShadow(wTuning3[0], 0);
	TextDrawUseBox(wTuning3[0], 1);
	TextDrawBoxColor(wTuning3[0], 0);
	TextDrawTextSize(wTuning3[0], 190.000000, 10.000000);
	TextDrawSetSelectable(wTuning3[0], 0);

	wTuning3[1] = TextDrawCreate(88.000000, 168.000000, "Yellow");
	TextDrawBackgroundColor(wTuning3[1], 255);
	TextDrawFont(wTuning3[1], 2);
	TextDrawLetterSize(wTuning3[1], 0.300000, 1.000000);
	TextDrawColor(wTuning3[1], -1);
	TextDrawSetOutline(wTuning3[1], 0);
	TextDrawSetProportional(wTuning3[1], 1);
	TextDrawSetShadow(wTuning3[1], 0);
	TextDrawUseBox(wTuning3[1], 1);
	TextDrawBoxColor(wTuning3[1], 0);
	TextDrawTextSize(wTuning3[1], 170.000000, 10.000000);
	TextDrawSetSelectable(wTuning3[1], 0);

	wTuning3[2] = TextDrawCreate(88.000000, 190.000000, "White");
	TextDrawBackgroundColor(wTuning3[2], 255);
	TextDrawFont(wTuning3[2], 2);
	TextDrawLetterSize(wTuning3[2], 0.300000, 1.000000);
	TextDrawColor(wTuning3[2], -1);
	TextDrawSetOutline(wTuning3[2], 0);
	TextDrawSetProportional(wTuning3[2], 1);
	TextDrawSetShadow(wTuning3[2], 0);
	TextDrawUseBox(wTuning3[2], 1);
	TextDrawBoxColor(wTuning3[2], 0);
	TextDrawTextSize(wTuning3[2], 171.000000, 10.000000);
	TextDrawSetSelectable(wTuning3[2], 0);

	wTuning3[3] = TextDrawCreate(88.000000, 213.000000, "Pink");
	TextDrawBackgroundColor(wTuning3[3], 255);
	TextDrawFont(wTuning3[3], 2);
	TextDrawLetterSize(wTuning3[3], 0.300000, 1.000000);
	TextDrawColor(wTuning3[3], -1);
	TextDrawSetOutline(wTuning3[3], 0);
	TextDrawSetProportional(wTuning3[3], 1);
	TextDrawSetShadow(wTuning3[3], 0);
	TextDrawUseBox(wTuning3[3], 1);
	TextDrawBoxColor(wTuning3[3], 0);
	TextDrawTextSize(wTuning3[3], 171.000000, 10.000000);
	TextDrawSetSelectable(wTuning3[3], 0);

	wTuning3[4] = TextDrawCreate(88.000000, 233.000000, "green");
	TextDrawBackgroundColor(wTuning3[4], 255);
	TextDrawFont(wTuning3[4], 2);
	TextDrawLetterSize(wTuning3[4], 0.300000, 1.000000);
	TextDrawColor(wTuning3[4], -1);
	TextDrawSetOutline(wTuning3[4], 0);
	TextDrawSetProportional(wTuning3[4], 1);
	TextDrawSetShadow(wTuning3[4], 0);
	TextDrawUseBox(wTuning3[4], 1);
	TextDrawBoxColor(wTuning3[4], 0);
	TextDrawTextSize(wTuning3[4], 170.000000, 10.000000);
	TextDrawSetSelectable(wTuning3[4], 0);

	wTuning3[5] = TextDrawCreate(88.000000, 252.000000, "remove_neon");
	TextDrawBackgroundColor(wTuning3[5], 255);
	TextDrawFont(wTuning3[5], 2);
	TextDrawLetterSize(wTuning3[5], 0.300000, 1.000000);
	TextDrawColor(wTuning3[5], -1);
	TextDrawSetOutline(wTuning3[5], 0);
	TextDrawSetProportional(wTuning3[5], 1);
	TextDrawSetShadow(wTuning3[5], 0);
	TextDrawUseBox(wTuning3[5], 1);
	TextDrawBoxColor(wTuning3[5], 0);
	TextDrawTextSize(wTuning3[5], 170.000000, 10.000000);
	TextDrawSetSelectable(wTuning3[5], 0);

	wTuning4[0] = TextDrawCreate(88.000000, 149.000000, "PAINTJOB_1");
	TextDrawBackgroundColor(wTuning4[0], 255);
	TextDrawFont(wTuning4[0], 2);
	TextDrawLetterSize(wTuning4[0], 0.300000, 1.000000);
	TextDrawColor(wTuning4[0], -1);
	TextDrawSetOutline(wTuning4[0], 0);
	TextDrawSetProportional(wTuning4[0], 1);
	TextDrawSetShadow(wTuning4[0], 0);
	TextDrawUseBox(wTuning4[0], 1);
	TextDrawBoxColor(wTuning4[0], 0);
	TextDrawTextSize(wTuning4[0], 190.000000, 10.000000);
	TextDrawSetSelectable(wTuning4[0], 0);

	wTuning4[1] = TextDrawCreate(88.000000, 168.000000, "PaintJob_2");
	TextDrawBackgroundColor(wTuning4[1], 255);
	TextDrawFont(wTuning4[1], 2);
	TextDrawLetterSize(wTuning4[1], 0.300000, 1.000000);
	TextDrawColor(wTuning4[1], -1);
	TextDrawSetOutline(wTuning4[1], 0);
	TextDrawSetProportional(wTuning4[1], 1);
	TextDrawSetShadow(wTuning4[1], 0);
	TextDrawUseBox(wTuning4[1], 1);
	TextDrawBoxColor(wTuning4[1], 0);
	TextDrawTextSize(wTuning4[1], 170.000000, 10.000000);
	TextDrawSetSelectable(wTuning4[1], 0);

	wTuning4[2] = TextDrawCreate(88.000000, 190.000000, "PaintJob_3");
	TextDrawBackgroundColor(wTuning4[2], 255);
	TextDrawFont(wTuning4[2], 2);
	TextDrawLetterSize(wTuning4[2], 0.300000, 1.000000);
	TextDrawColor(wTuning4[2], -1);
	TextDrawSetOutline(wTuning4[2], 0);
	TextDrawSetProportional(wTuning4[2], 1);
	TextDrawSetShadow(wTuning4[2], 0);
	TextDrawUseBox(wTuning4[2], 1);
	TextDrawBoxColor(wTuning4[2], 0);
	TextDrawTextSize(wTuning4[2], 171.000000, 10.000000);
	TextDrawSetSelectable(wTuning4[2], 0);

	wTuning5[0] = TextDrawCreate(88.000000, 149.000000, "Nitro 2X");
	TextDrawBackgroundColor(wTuning5[0], 255);
	TextDrawFont(wTuning5[0], 2);
	TextDrawLetterSize(wTuning5[0], 0.300000, 1.000000);
	TextDrawColor(wTuning5[0], -1);
	TextDrawSetOutline(wTuning5[0], 0);
	TextDrawSetProportional(wTuning5[0], 1);
	TextDrawSetShadow(wTuning5[0], 0);
	TextDrawUseBox(wTuning5[0], 1);
	TextDrawBoxColor(wTuning5[0], 0);
	TextDrawTextSize(wTuning5[0], 190.000000, 10.000000);
	TextDrawSetSelectable(wTuning5[0], 0);

	wTuning5[1] = TextDrawCreate(88.000000, 169.000000, "NITRo 5x");
	TextDrawBackgroundColor(wTuning5[1], 255);
	TextDrawFont(wTuning5[1], 2);
	TextDrawLetterSize(wTuning5[1], 0.300000, 1.000000);
	TextDrawColor(wTuning5[1], -1);
	TextDrawSetOutline(wTuning5[1], 0);
	TextDrawSetProportional(wTuning5[1], 1);
	TextDrawSetShadow(wTuning5[1], 0);
	TextDrawUseBox(wTuning5[1], 1);
	TextDrawBoxColor(wTuning5[1], 0);
	TextDrawTextSize(wTuning5[1], 170.000000, 10.000000);
	TextDrawSetSelectable(wTuning5[1], 0);

	wTuning5[2] = TextDrawCreate(88.000000, 190.000000, "nitro 10x");
	TextDrawBackgroundColor(wTuning5[2], 255);
	TextDrawFont(wTuning5[2], 2);
	TextDrawLetterSize(wTuning5[2], 0.300000, 1.000000);
	TextDrawColor(wTuning5[2], -1);
	TextDrawSetOutline(wTuning5[2], 0);
	TextDrawSetProportional(wTuning5[2], 1);
	TextDrawSetShadow(wTuning5[2], 0);
	TextDrawUseBox(wTuning5[2], 1);
	TextDrawBoxColor(wTuning5[2], 0);
	TextDrawTextSize(wTuning5[2], 171.000000, 10.000000);
	TextDrawSetSelectable(wTuning5[2], 0);

	for(new i = 5; i < sizeof(wTuning1); i++) { TextDrawSetSelectable(Text:wTuning1[i], true); }
	for(new i = 0; i < sizeof(wTuning2); i++) { TextDrawSetSelectable(Text:wTuning2[i], true); }
	for(new i = 0; i < sizeof(wTuning3); i++) { TextDrawSetSelectable(Text:wTuning3[i], true); }
	for(new i = 0; i < sizeof(wTuning4); i++) { TextDrawSetSelectable(Text:wTuning4[i], true); }
	for(new i = 0; i < sizeof(wTuning5); i++) { TextDrawSetSelectable(Text:wTuning5[i], true); }



	return 1;
}



public OnPlayerEnterDynamicArea(playerid, areaid)
{
	if(areaid == PVPZone)
	{
	    playerData[playerid][pPVP] = 0;
	}
	return 1;
}
public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	if(areaid == PVPZone)
	{
        playerData[playerid][pPVP] = 0;
	}
	return 1;
}
public OnGameModeExit()
{
	mysql_close(g_SQL);
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	//มือถือ โดย เก่งตี้
    if (playertextid == FINPHONE[playerid][19])// โทร
    {
		Dialog_Show(playerid, DIALOG_DIALNUMBER, DIALOG_STYLE_INPUT, "[หมายเลขที่ต้องการโทร]", "{FFFFFF}ใส่หมายเลขที่ต้องการจะติดต่อ", "โทร", "กลับ");
	}
	if (playertextid == FINPHONE[playerid][14])// โชว์เบอร์ทีบันทึกไว้
    {
		ShowContacts(playerid);
	}

	if (playertextid == FINPHONE[playerid][9])//ปิดมือถือ
    {
   		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้กดปุ่มเพื่อปิดมือถือของเขา", GetPlayerNameEx(playerid));
		HideYourPhone(playerid);
    }
	if(playertextid == FINPHONE[playerid][26])//ส่ง ทวิต
    {
		Dialog_Show(playerid, DIALOG_TWITTER, DIALOG_STYLE_INPUT, "[กรุณาระบุข้อความ Twitter]", "{FFFFFF}กรุณาระบุข้อความที่คุณต้องการจะโพสต์ :", "ตกลง", "ยกเลิก");
    }
	if (playertextid == FINPHONE[playerid][20])//โอนเงิน
	{
	     Dialog_Show(playerid, DIALOG_TRANSFERPHONE, DIALOG_STYLE_INPUT, "[โอนเงิน]", "{FFFFFF}ยอดเงินในบัญชี: %s\nกรุณาใส่ไอดีหรือชื่อผู้รับเงิน", "โอน", "ยกเลิก", FormatMoney(playerData[playerid][pBankMoney]));
	}
	if(playertextid == FINPHONE[playerid][27])//ส่ง เฟสบุ๊ค
    {
		Dialog_Show(playerid, DIALOG_FACEBOOK, DIALOG_STYLE_INPUT, "[กรุณาระบุข้อความ Facebook]", "{FFFFFF}กรุณาระบุข้อความที่คุณต้องการจะโพสต์ :", "ตกลง", "ยกเลิก");
    }
    if(playertextid == FINPHONE[playerid][25])//ส่งดากแชท
    {
		Dialog_Show(playerid, DIALOG_DAK, DIALOG_STYLE_INPUT, "[กรุณาระบุข้อความ DARKCHAT]", "{FFFFFF}กรุณาระบุข้อความ:", "ตกลง", "ยกเลิก");
    }



	// --> หน้าเมนูช่วยเหลือกด Y
    /*if (playertextid == ZeeThreeText[playerid][4])
    {
        //OpenInventory(playerid);
        HideYMenuTextDraws(playerid);
        return 1;
    }

    if (playertextid == ZeeThreeText[playerid][11])
    {
        Dialog_Show(playerid, DIALOG_MAIN_INV, DIALOG_STYLE_LIST, "{F7F708}[ Backpack ]", "{F79C08}+ {FFFFFF}กระเป๋าแบบเก่า\n{F79C08}+ {ffffff}กระเป๋าแบบใหม่", "ตกลง", "ยกเลิก");
        //OpenInventory(playerid);
        HideYMenuTextDraws(playerid);
        return 1;
    }

    if (playertextid == ZeeThreeText[playerid][14])
    {
        callcmd::help(playerid, "\1");
        HideYMenuTextDraws(playerid);
        return 1;
    }

    if (playertextid == ZeeThreeText[playerid][10])
    {
        callcmd::stats(playerid, "\1");
        HideYMenuTextDraws(playerid);
        return 1;
    }

    if (playertextid == ZeeThreeText[playerid][13])
    {
        callcmd::gps(playerid, "\1");
        HideYMenuTextDraws(playerid);
        return 1;
    }

    if (playertextid == ZeeThreeText[playerid][12])
    {
		new string100[512];
		new string2[512];

		format(string100, sizeof(string100), "{FFFFFF}[ของโดเนท]\t{35C005}รายละเอียด\n");
		strcat(string2,string100);

		format(string100, sizeof(string100), "{FFFFFF}อาวุธโดเนท\t{16D603}คลิก\n");
		strcat(string2,string100);

		format(string100, sizeof(string100), "{FFFFFF}รถโดเนท\t{16D603}คลิก\n");
		strcat(string2,string100);

		format(string100, sizeof(string100), "{FFFFFF}กาชาปอง (สุ่มรถ)\t{16D603}100 {FFFFFF}Coin\n");
		strcat(string2,string100);

		format(string100, sizeof(string100), "{FFFFFF}วีไอพี\t{16D603}คลิก\n");
		strcat(string2,string100);

		format(string100, sizeof(string100), "{FFFFFF}ซื้อเงินเขียว $500\t{16D603}1 {FFFFFF}Coin\n");
		strcat(string2,string100);

		format(string100, sizeof(string100), "{FFFFFF}อาวุธแฟชั่น\t{16D603}คลิก\n");
		strcat(string2,string100);

		format(string100, sizeof(string100), "{FFFFFF}Boombox\t{16D603}100 {FFFFFF}Coin\n");
		strcat(string2,string100);

		format(string100, sizeof(string100), "{FFFFFF}ท่าทางจับมือ\t{16D603}10 {FFFFFF}Coin\n");
		strcat(string2,string100);

		format(string100, sizeof(string100), "{FFFFFF}บัตรเปลี่ยนรหัสผ่าน\t{FCED06}100 {FFFFFF}Coin\n");
		strcat(string2,string100);

		format(string100, sizeof(string100), "{FFFFFF}บัตรเปลี่ยนชื่อตัวละคร\t{FCED06}100 {FFFFFF}Coin\n");
		strcat(string2,string100);


		format(string100, sizeof(string100), "{FFFFFF}อาวุธโดเนท{FFFF66}new!");
		strcat(string2,string100);



		Dialog_Show(playerid,DIALOG_DONATE,DIALOG_STYLE_TABLIST_HEADERS,"{FFFFFF}[{16D603}ของโดเนท{FFFFFF}]",string2,"ตกลง","ยกเลิก");
		HideYMenuTextDraws(playerid);
		return 1;
    }*/

	return 1;
}
Dialog:DIALOG_CRAFT_CARTUNE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if (Inventory_Count(playerid, "แร่เฮมาไทต์") < 40)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณมีเฮมาไทต์ไม่เพียงพอ (40)");

		if (Inventory_Count(playerid, "แร่หินเกลือ") < 40)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณมีแร่หินเกลือไม่เพียงพอ (40)");

		if (Inventory_Count(playerid, "แร่ถ่านหิน") < 40)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณมีแร่ถ่านหินไม่เพียงพอ (40)");

		if (GetPlayerMoneyEx(playerid) < 50000)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณมีเงินเขียวไม่เพียงพอ ($50,000)");

		Inventory_Remove(playerid, "แร่เฮมาไทต์", 40);
		Inventory_Remove(playerid, "แร่หินเกลือ", 40);
		Inventory_Remove(playerid, "แร่ถ่านหิน", 40);

		GivePlayerMoneyEx(playerid,-50000);

		SendClientMessage(playerid, COLOR_WHITE, "คุณได้รับ {0AB219}กล่องจูนรถ {4DFA5D}+ 1 {FFFFFF}จากการสร้างกล่อง");
		Inventory_Add(playerid, "กล่องจูน", 1);
	}
	return 1;
}
Dialog:TuneEas(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		    	SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> เมนูจูนรถ");
	    		Dialog_Show(playerid, TuneSd1, DIALOG_STYLE_LIST, "[ วงเลี้ยว]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
		}
	}
	return 1;
}

//---------------------------------------จูนรถแบบแฟม: ------------------------------------------------------//

Dialog:TuneSd1(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		    	SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> ปรับวงล้อ 25% สำเร็จ");
		    	Dialog_Show(playerid, TuneSd2, DIALOG_STYLE_LIST, "[ ความทนทาน]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
			case 1:
			{
			    SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> ปรับวงล้อ 50% สำเร็จ");
			    Dialog_Show(playerid, TuneSd2, DIALOG_STYLE_LIST, "[ ความทนทาน]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
			case 2:
			{
			    SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> ปรับวงล้อ 75% สำเร็จ");
			    Dialog_Show(playerid, TuneSd2, DIALOG_STYLE_LIST, "[ ความทนทาน]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
			case 3:
			{
			    SendClientMessageEx(playerid, COLOR_GREEN, "[จูน] --> ปรับวงล้อ 100% สำเร็จ");
			    Dialog_Show(playerid, TuneSd2, DIALOG_STYLE_LIST, "[ ความทนทาน]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
		}
	}
	return 1;
}

Dialog:TuneSd2(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		    	SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> ความทนทาน25% สำเร็จ");
		    	Dialog_Show(playerid, TuneSd3, DIALOG_STYLE_LIST, "[ รอบต้น]", "ก.ตอบ 34\nข.ตอบ 40\nค.ตอบ 60\nง.ตอบ 80", "ตอบ", "ยกเลิก");
			}
			case 1:
			{
			    SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> ความทนทาน50% สำเร็จ");
			    Dialog_Show(playerid, TuneSd3, DIALOG_STYLE_LIST, "[รอบต้น]", "ก.ตอบ 34\nข.ตอบ 40\nค.ตอบ 60\nง.ตอบ 80", "ตอบ", "ยกเลิก");
			}
			case 2:
			{
			    SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> ความทนทาน75% สำเร็จ");
			    Dialog_Show(playerid, TuneSd3, DIALOG_STYLE_LIST, "[ รอบต้น]", "ก.ตอบ 34\nข.ตอบ 40\nค.ตอบ 60\nง.ตอบ 80", "ตอบ", "ยกเลิก");
			}
			case 3:
			{
                SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> ความทนทาน100% สำเร็จ");
                Dialog_Show(playerid, TuneSd3, DIALOG_STYLE_LIST, "[ รอบต้น]", "ก.ตอบ 34\nข.ตอบ 40\nค.ตอบ 60\nง.ตอบ 80", "ตอบ", "ยกเลิก");
			}
		}
	}
	return 1;
}

Dialog:TuneSd3(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		    	SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> ปรับรอบต้น 25% สำเร็จ");
		    	Dialog_Show(playerid, TuneSd4, DIALOG_STYLE_LIST, "[เบรก]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
			case 1:
			{
			    SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> ปรับรอบต้น 50% สำเร็จ");
			    Dialog_Show(playerid, TuneSd4, DIALOG_STYLE_LIST, "[ เบรก]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
			case 2:
			{
			    SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> ปรับรอบต้น 75% สำเร็จ");
			    Dialog_Show(playerid, TuneSd4, DIALOG_STYLE_LIST, "[ เบรก]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
			case 3:
			{
			    SendClientMessageEx(playerid, COLOR_GREEN, "[จูน] -->ปรับรอบต้น 100% สำเร็จ");
			    Dialog_Show(playerid, TuneSd4, DIALOG_STYLE_LIST, "[เบรก]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
		}
	}
	return 1;
}

Dialog:TuneSd4(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0:
		    {
		    	SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> เบรก 25% สำเร็จ");
		    	Dialog_Show(playerid, TuneSd5, DIALOG_STYLE_LIST, "[ ยึดกาะถนน]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
			case 1:
			{
			    SendClientMessageEx(playerid, COLOR_RED, "[จ] --> เบรก 50% สำเร็จ");
			    Dialog_Show(playerid, TuneSd5, DIALOG_STYLE_LIST, "[ ยึดเกาะถนน]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
			case 2:
			{
			    SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> เบรก 75% สำเร็จ");
			    Dialog_Show(playerid, TuneSd5, DIALOG_STYLE_LIST, "[ ยึดเกาะถนน]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
			case 3:
			{
			    SendClientMessageEx(playerid, COLOR_GREEN, "[จูน] --> เบรก 100% สำเร็จ");
			    Dialog_Show(playerid, TuneSd5, DIALOG_STYLE_LIST, "[ ยึดเกาะถนน]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
		}
	}
	return 1;
}

Dialog:TuneSd5(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0:
		    {
		    	SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> ยึดเกาะถนน 25% สำเร็จ");
		    	Dialog_Show(playerid, TuneSd6, DIALOG_STYLE_LIST, "[ ความเร็ว]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
			case 1:
			{
			    SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> ยึดเกาะถนน 50% สำเร็จ");
			    Dialog_Show(playerid, TuneSd6, DIALOG_STYLE_LIST, "[ ความเร็ว]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
			case 2:
			{
			    SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> ยึดเกาะถนน 75% สำเร็จ");
			    Dialog_Show(playerid, TuneSd6, DIALOG_STYLE_LIST, "[ ความเร็ว]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
			case 3:
			{
			    SendClientMessageEx(playerid, COLOR_GREEN, "[จูน] --> ยึดเกาะถนน 100% สำเร็จ");
			    Dialog_Show(playerid, TuneSd6, DIALOG_STYLE_LIST, "[ ความเร็ว]", "25%\n50%\n75%\n100%", "เลือก", "ยกเลิก");
			}
		}
	}
	return 1;
}

Dialog:TuneSd6(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0:
		    {
		    	SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> ความเร็ว 25% สำเร็จ");
		    	Dialog_Show(playerid, TuneSd7, DIALOG_STYLE_LIST, "ค่าจูน", "> เซฟค่าจูน", "save", "cose");
			}
			case 1:
			{
			    SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> ความเร็ว 50% สำเร็จ");
			    Dialog_Show(playerid, TuneSd7, DIALOG_STYLE_LIST, "ค่าจูน", "> เซฟค่าจูน", "save", "cose");
			}
			case 2:
			{
			    SendClientMessageEx(playerid, COLOR_RED, "[จูน] --> ความเร็ว 75% สำเร็จ");
			    Dialog_Show(playerid, TuneSd7, DIALOG_STYLE_LIST, "ค่าจูน", "> เซฟค่าจูน", "save", "cose");
			}
			case 3:
			{
			    SendClientMessageEx(playerid, COLOR_GREEN, "[จูน] --> ความเร็ว 100% สำเร็จ");
			    Dialog_Show(playerid, TuneSd7, DIALOG_STYLE_LIST, "ค่าจูน", "> เซฟค่าจูน", "save", "cose");
			}
		}
	}
	return 1;
}


Dialog:TuneSd7(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0:
		    {
		        new vehicleid = GetPlayerVehicleID(playerid);

		    	new speeddf = carData[vehicleid][carTune] + 3;
			    new speedmax = carData[vehicleid][carTune] + 50;
				return Dialog_Show(playerid, DIALOG_RanDomTune, DIALOG_STYLE_MSGBOX, "\
				{000000}[{ffffff}จูนรถ{000000}]", "\
				{ffff00}[!]{FFFFFF}คุณต้องการจูนรถหรือไม่(เสียกล่องจูน1กล่อง)\n\
			 	มีโอกาศได้กำลังเพิ่ม %d - %d (ถ้ามากกว่า280จะไม่สามารถจูนได้อีก)\
				", "save", "cose",speeddf, speedmax);
			}
		}
	}
	return 1;
}

Dialog:DIALOG_RanDomTune(playerid, response, listitem, inputtext[]){
    if(!IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_RED,"[!]{FFFFFF}คุณต้องอยู่บนรถ");

	if(response){

	    new vehicleid = GetPlayerVehicleID(playerid);

		if(IsVehicleOwner(playerid, vehicleid) || playerData[playerid][pVehicleKeys] == vehicleid || (carData[vehicleid][carTune] >= 0 && carData[vehicleid][carTune] == playerData[playerid][pFaction]))
		{
		    if(carData[vehicleid][carTune] > 280)
		        return SendClientMessage(playerid, COLOR_RED,"[!]{FFFFFF}กำลังรถของคุณมากกว่า 280 แล้วไม่สามารถจูนได้อีก");

			new speeddf = carData[vehicleid][carTune] + 3;
			new speedmax = carData[vehicleid][carTune] + 50;
			new speed = randomEx(speeddf, speedmax);
			new query[167];
			SendClientMessageEx(playerid, COLOR_GREEN, "[!]{ffffff} คุณได้จูนรถได้กำลังเพิ่มขึ้น%d",speed);
			SendClientMessage(playerid, COLOR_YELLOW, "[!]{FFFFFF} เมื่อจูนเสร็จกรุณาลงรถและขึ้นใหม่ด้วยนะครับ");
			carData[vehicleid][carTune] = speed;
			mysql_format(g_SQL, query, sizeof(query), "UPDATE Vehicle SET carTune = %d WHERE carid = %d", carData[vehicleid][carTune], carData[vehicleid][carID]);
			mysql_tquery(g_SQL, query);
			Inventory_Remove(playerid, "กล่องจูน", 1);
		}
		else{
		    SendClientMessage(playerid, COLOR_RED, "[!]{ffffff}รถคันนี้ไม่ใช่ของคุณ");
		}
	}
	if(!response){
	}
	return 1;
}


Dialog:GatePass(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = Gate_Nearest(playerid);

	    if (id == -1)
	        return 0;

        if (isnull(inputtext))
        	return Dialog_Show(playerid, GatePass, DIALOG_STYLE_INPUT, "Enter Password", "Please enter the password for this gate below:", "Submit", "Cancel");

		if (strcmp(inputtext, GateData[id][gatePass]) != 0)
  			return Dialog_Show(playerid, GatePass, DIALOG_STYLE_INPUT, "Enter Password", "Error: Incorrect password specified.\n\nPlease enter the password for this gate below:", "Submit", "Cancel");

		Gate_Operate(id);
	}
	return 1;
}

Gate_Nearest(playerid)
{
    for (new i = 0; i != MAX_GATES; i ++) if (GateData[i][gateExists] && IsPlayerInRangeOfPoint(playerid, GateData[i][gateRadius], GateData[i][gatePos][0], GateData[i][gatePos][1], GateData[i][gatePos][2]))
	{
		if (GetPlayerInterior(playerid) == GateData[i][gateInterior] && GetPlayerVirtualWorld(playerid) == GateData[i][gateWorld])
			return i;
	}
	return -1;
}

Dialog:DIALOG_MECMENU(playerid, response, listitem, inputtext[]){
	if(response){
	    switch(listitem){
	        case 0:{
	        	new vehicleid = GetNearbyVehicle(playerid);

				if(vehicleid != INVALID_VEHICLE_ID ){
					switch (GetEngineStatus(vehicleid)){
						case false:{
							if (repairon[playerid] == 1)
								return  SendClientMessage(playerid, COLOR_RED, "- คุณอยู่ระหว่างการซ่อมรถ");

							if(IsPlayerInAnyVehicle(playerid))
								return SendClientMessage(playerid, COLOR_RED, "- คุณต้องไม่อยู่บนรถ");
                            TogglePlayerControllable( playerid, false );
							ApplyAnimation(playerid, "BD_FIRE","wash_up", 4.1, 0, 0, 0, 0, 0, 1);
							repairon[playerid] = 1;
							StartProgress(playerid, 100, 0, vehicleid);
							SendClientMessage(playerid, COLOR_GREEN, "-  คุณได้ใช้กล่องซ่อมรถ");
						}
						case true:{
							SendClientMessage(playerid, COLOR_RED, "- รถของคุณต้องไม่สตาร์ทอยู่");
						}
					}
				}
				else{
					SendClientMessage(playerid, COLOR_RED, "- คุณต้องอยู่ใกล้รถของคุณ");
				}
	        }
		}
	}
	return 1;
}

Dialog:DIALOG_RADIO_OPEN(playerid,response,listitem,inputtext[])
{
    if(!response)return 1;
    if(response)
    {
        if(PlayerInRadio[playerid])
        {
            CallRemoteFunction("OnPlayerDisconnectRadio", "d",playerid);
            PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
            for(new i=0;i<MAX_PLAYERS;i++)if(IsPlayerConnected(i) && playerData[i][pRadioID] && playerData[i][pRadioID] == playerData[playerid][pRadioID]){
            playerData[i][pRadioID]=0;
            PlayerInRadio[i]=false;
            }
        }
        else if(!PlayerInRadio[playerid])
        {
            Dialog_Show(playerid,DIALOG_JOIN_RADIO,DIALOG_STYLE_LIST,"วิทยุสื่อสาร","{FFFFFF}เข้าร่วมห้องวิทยุสื่อสาร\n{FFFFFF}สร้างห้องการสื่อสารวิทยุ","ตกลง","ยกเลิก");
        }
    }
   	return 1;
}

Dialog:DIALOG_JOIN_RADIO(playerid,response,listitem,inputtext[])
{
    if(!response)
        return 1;
    switch(listitem)
    {
        case 0:{
        Dialog_Show(playerid,DIALOG_JOIN_RADIO_ID,DIALOG_STYLE_INPUT,"เข้าร่วมการสื่อสาร","{FFFFFF}กรุณาใส่ไอดีห้องเพื่อเข้าร่วมวิทยุสื่อสาร","เข้าร่วม","ยกเลิก");
        }
        case 1:{
        Dialog_Show(playerid,DIALOG_CREATE_READIO,DIALOG_STYLE_MSGBOX,"สร้างห้องการสื่อสาร","{FFFFFF}โปรดกด >> ยืนยัน << ในการสร้างห้องวิทยุสื่อสารไกล","ยืนยัน","ยกเลิก");
        }
    }
    return 1;
}

Dialog:DIALOG_JOIN_RADIO_ID(playerid,response,listitem,inputtext[])
{
    if(!response)
        return 1;
    if(!strlen(inputtext))
        return SendClientMessage(playerid,COLOR_RED,"กรุณาใส่ไอดีห้องสื่อสาร");
    if(PlayerInRadio[playerid] == true)
        return SendClientMessage(playerid,COLOR_RED,"กรุณาออกจากห้องสื่อสารก่อน");
    for(new i=0;i<MAX_PLAYERS;i++)if(IsPlayerConnected(i) && PlayerInRadio[i] == true && playerData[i][pRadioID] && playerData[i][pRadioID] == strval(inputtext))
    {
        new joinradio = CallRemoteFunction("OnPlayerJoinRoom", "dd",playerid,i);
        if(joinradio)
        {
            SendClientMessageEx(playerid,COLOR_GREEN,"[#]:{FFFFFF} คุณได้เข้าร่วมวิทยุสื่อสารแล้ว");
            playerData[playerid][pRadioID]= playerData[i][pRadioID];
            PlayerInRadio[playerid]=true;
        }
    }
    return 1;
}

Dialog:DIALOG_CREATE_READIO(playerid,response,listitem,inputtext[])
{
	if(!response)
	  return 1;
    playerData[playerid][pRadioID] = CallRemoteFunction("OnPlayerConnectRoom", "is",playerid,"CallPhone");
    if(playerData[playerid][pRadioID])
    {
	   new string9[256];
	   format(string9,sizeof(string9),"{FFFFFF}วิทยุสื่อสาร\n{FFFFFF}ไอดีห้อง:%d\n{FFFFFF}วิทธีใช่:ให้ผู้เล่นใส่ไอดีห้องสื่อสารเพื่อเข้าร่วมห้อง",playerData[playerid][pRadioID]);
	   Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX,"วิทยุ",string9,"ปิด","");
	   PlayerInRadio[playerid] = true;
	}
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    new wVeiculo; wVeiculo = GetPlayerVehicleID(playerid);
    if(clickedid == wTuning1[6]) // X CLOSE
    {
            for(new i = 0; i < sizeof(wTuning1); i++) { TextDrawHideForPlayer(playerid, wTuning1[i]); }
            for(new i = 0; i < sizeof(wTuning2); i++)       { TextDrawHideForPlayer(playerid, wTuning2[i]); }
            for(new i = 0; i < sizeof(wTuning3); i++) { TextDrawHideForPlayer(playerid, wTuning3[i]); }
            for(new i = 0; i < sizeof(wTuning4); i++) { TextDrawHideForPlayer(playerid, wTuning4[i]); }
            for(new i = 0; i < sizeof(wTuning5); i++)       { TextDrawHideForPlayer(playerid, wTuning5[i]); }
            CancelSelectTextDraw(playerid);
    }

    if(clickedid == wTuning1[7]) //WHEELS
    {

            for(new i = 14; i < sizeof(wTuning1); i++) { TextDrawHideForPlayer(playerid, wTuning1[i]); }
            for(new i = 0; i < sizeof(wTuning2); i++)       { TextDrawHideForPlayer(playerid, wTuning2[i]); }
            for(new i = 0; i < sizeof(wTuning3); i++) { TextDrawHideForPlayer(playerid, wTuning3[i]); }
            for(new i = 0; i < sizeof(wTuning4); i++) { TextDrawHideForPlayer(playerid, wTuning4[i]); }
            for(new i = 0; i < sizeof(wTuning5); i++)       { TextDrawHideForPlayer(playerid, wTuning5[i]); }

            for(new i = 0; i < sizeof(wTuning2); i++) { TextDrawShowForPlayer(playerid, wTuning2[i]); }
    }
    if(clickedid == wTuning1[8]) // COLOR
    {

            for(new i = 14; i < sizeof(wTuning1); i++) { TextDrawHideForPlayer(playerid, wTuning1[i]); }
            for(new i = 0; i < sizeof(wTuning2); i++)       { TextDrawHideForPlayer(playerid, wTuning2[i]); }
            for(new i = 0; i < sizeof(wTuning3); i++) { TextDrawHideForPlayer(playerid, wTuning3[i]); }
            for(new i = 0; i < sizeof(wTuning4); i++) { TextDrawHideForPlayer(playerid, wTuning4[i]); }
            for(new i = 0; i < sizeof(wTuning5); i++) { TextDrawHideForPlayer(playerid, wTuning5[i]); }

            for(new i = 11; i < sizeof(wTuning1); i++) { TextDrawShowForPlayer(playerid, wTuning1[i]); }
    }
    if(clickedid == wTuning1[9]) // PAINTJOBS
    {

            for(new i = 14; i < sizeof(wTuning1); i++) { TextDrawHideForPlayer(playerid, wTuning1[i]); }
            for(new i = 0; i < sizeof(wTuning2); i++)       { TextDrawHideForPlayer(playerid, wTuning2[i]); }
            for(new i = 0; i < sizeof(wTuning3); i++) { TextDrawHideForPlayer(playerid, wTuning3[i]); }
            for(new i = 0; i < sizeof(wTuning5); i++) { TextDrawHideForPlayer(playerid, wTuning5[i]); }

            for(new i = 0; i < sizeof(wTuning4); i++) { TextDrawShowForPlayer(playerid, wTuning4[i]); }
    }
    if(clickedid == wTuning1[10]) // NITRO
    {

            for(new i = 14; i < sizeof(wTuning1); i++) { TextDrawHideForPlayer(playerid, wTuning1[i]); }
            for(new i = 0; i < sizeof(wTuning2); i++)       { TextDrawHideForPlayer(playerid, wTuning2[i]); }
            for(new i = 0; i < sizeof(wTuning3); i++) { TextDrawHideForPlayer(playerid, wTuning3[i]); }
            for(new i = 0; i < sizeof(wTuning4); i++) { TextDrawHideForPlayer(playerid, wTuning4[i]); }

            for(new i = 0; i < sizeof(wTuning5); i++) { TextDrawShowForPlayer(playerid, wTuning5[i]); }
    }
    if(clickedid == wTuning1[11]) // HYDRAULICS
    {
            AddVehicleComponent(wVeiculo,1087);
    }
    if(clickedid == wTuning1[12]) //NEON
    {

            for(new i = 14; i < sizeof(wTuning1); i++) { TextDrawHideForPlayer(playerid, wTuning1[i]); }
            for(new i = 0; i < sizeof(wTuning2); i++)       { TextDrawHideForPlayer(playerid, wTuning2[i]); }
            for(new i = 0; i < sizeof(wTuning4); i++) { TextDrawHideForPlayer(playerid, wTuning4[i]); }
            for(new i = 0; i < sizeof(wTuning5); i++) { TextDrawHideForPlayer(playerid, wTuning5[i]); }

            for(new i = 0; i < sizeof(wTuning3); i++) { TextDrawShowForPlayer(playerid, wTuning3[i]); }
    }
    if(clickedid == wTuning1[13]) //AUTO TUNING
    {
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 483)
            {

                    AddVehicleComponent(wVeiculo,1027);
                    ChangeVehiclePaintjob(wVeiculo, 0);
                    AddVehicleComponent(wVeiculo,1010);
                    AddVehicleComponent(wVeiculo,1079);
                    AddVehicleComponent(wVeiculo,1087);
            }
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 562)
            {
                    AddVehicleComponent(wVeiculo,1046);
                    AddVehicleComponent(wVeiculo,1171);
                    AddVehicleComponent(wVeiculo,1149);
                    AddVehicleComponent(wVeiculo,1035);
                    AddVehicleComponent(wVeiculo,1147);
                    AddVehicleComponent(wVeiculo,1036);
                    AddVehicleComponent(wVeiculo,1040);
                    ChangeVehiclePaintjob(wVeiculo, 2);
                    ChangeVehicleColor(wVeiculo, 6, 6);
                    AddVehicleComponent(wVeiculo,1010);
                    AddVehicleComponent(wVeiculo,1079);
                    AddVehicleComponent(wVeiculo,1087);
            }
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
            {
                    AddVehicleComponent(wVeiculo,1028);
                    AddVehicleComponent(wVeiculo,1169);
                    AddVehicleComponent(wVeiculo,1141);
                    AddVehicleComponent(wVeiculo,1032);
                    AddVehicleComponent(wVeiculo,1138);
                    AddVehicleComponent(wVeiculo,1026);
                    AddVehicleComponent(wVeiculo,1027);
                    ChangeVehiclePaintjob(wVeiculo, 2);
                    AddVehicleComponent(wVeiculo,1010);
                    AddVehicleComponent(wVeiculo,1079);
                    AddVehicleComponent(wVeiculo,1087);
            }
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 565)
            {


                    AddVehicleComponent(wVeiculo,1046);
                    AddVehicleComponent(wVeiculo,1153);
                    AddVehicleComponent(wVeiculo,1150);
                    AddVehicleComponent(wVeiculo,1054);
                    AddVehicleComponent(wVeiculo,1049);
                    AddVehicleComponent(wVeiculo,1047);
                    AddVehicleComponent(wVeiculo,1051);
                    AddVehicleComponent(wVeiculo,1010);
                    AddVehicleComponent(wVeiculo,1079);
                    AddVehicleComponent(wVeiculo,1087);
                    ChangeVehiclePaintjob(wVeiculo, 2);
            }
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 559)
            {

                    AddVehicleComponent(wVeiculo,1065);
                    AddVehicleComponent(wVeiculo,1160);
                    AddVehicleComponent(wVeiculo,1159);
                    AddVehicleComponent(wVeiculo,1067);
                    AddVehicleComponent(wVeiculo,1162);
                    AddVehicleComponent(wVeiculo,1069);
                    AddVehicleComponent(wVeiculo,1071);
                    AddVehicleComponent(wVeiculo,1010);
                    AddVehicleComponent(wVeiculo,1079);
                    AddVehicleComponent(wVeiculo,1087);
                    ChangeVehiclePaintjob(wVeiculo, 1);
            }
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 561)
            {

                    AddVehicleComponent(wVeiculo,1064);
                    AddVehicleComponent(wVeiculo,1155);
                    AddVehicleComponent(wVeiculo,1154);
                    AddVehicleComponent(wVeiculo,1055);
                    AddVehicleComponent(wVeiculo,1158);
                    AddVehicleComponent(wVeiculo,1056);
                    AddVehicleComponent(wVeiculo,1062);
                    AddVehicleComponent(wVeiculo,1010);
                    AddVehicleComponent(wVeiculo,1079);
                    AddVehicleComponent(wVeiculo,1087);
                    ChangeVehiclePaintjob(wVeiculo, 2);
            }
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
            {
                    AddVehicleComponent(wVeiculo,1089);
                    AddVehicleComponent(wVeiculo,1166);
                    AddVehicleComponent(wVeiculo,1168);
                    AddVehicleComponent(wVeiculo,1088);
                    AddVehicleComponent(wVeiculo,1164);
                    AddVehicleComponent(wVeiculo,1090);
                    AddVehicleComponent(wVeiculo,1094);
                    AddVehicleComponent(wVeiculo,1010);
                    AddVehicleComponent(wVeiculo,1079);
                    AddVehicleComponent(wVeiculo,1087);
                    ChangeVehiclePaintjob(wVeiculo, 2);
            }
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 575)
            {
                    AddVehicleComponent(wVeiculo,1044);
                    AddVehicleComponent(wVeiculo,1174);
                    AddVehicleComponent(wVeiculo,1176);
                    AddVehicleComponent(wVeiculo,1042);
                    AddVehicleComponent(wVeiculo,1099);
                    AddVehicleComponent(wVeiculo,1010);
                    AddVehicleComponent(wVeiculo,1079);
                    AddVehicleComponent(wVeiculo,1087);
                    ChangeVehiclePaintjob(wVeiculo, 0);
            }
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 534)
            {
                    AddVehicleComponent(wVeiculo,1126);
                    AddVehicleComponent(wVeiculo,1179);
                    AddVehicleComponent(wVeiculo,1180);
                    AddVehicleComponent(wVeiculo,1122);
                    AddVehicleComponent(wVeiculo,1101);
                    AddVehicleComponent(wVeiculo,1125);
                    AddVehicleComponent(wVeiculo,1123);
                    AddVehicleComponent(wVeiculo,1100);
                    AddVehicleComponent(wVeiculo,1010);
                    AddVehicleComponent(wVeiculo,1079);
                    AddVehicleComponent(wVeiculo,1087);
                    ChangeVehiclePaintjob(wVeiculo, 2);
            }
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 536)
            {
                    AddVehicleComponent(wVeiculo,1104);
                    AddVehicleComponent(wVeiculo,1182);
                    AddVehicleComponent(wVeiculo,1184);
                    AddVehicleComponent(wVeiculo,1108);
                    AddVehicleComponent(wVeiculo,1107);
                    AddVehicleComponent(wVeiculo,1010);
                    AddVehicleComponent(wVeiculo,1079);
                    AddVehicleComponent(wVeiculo,1087);
                    ChangeVehiclePaintjob(wVeiculo, 1);
            }
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 567)
            {
                    AddVehicleComponent(wVeiculo,1129);
                    AddVehicleComponent(wVeiculo,1189);
                    AddVehicleComponent(wVeiculo,1187);
                    AddVehicleComponent(wVeiculo,1102);
                    AddVehicleComponent(wVeiculo,1133);
                    AddVehicleComponent(wVeiculo,1010);
                    AddVehicleComponent(wVeiculo,1079);
                    AddVehicleComponent(wVeiculo,1087);
                    ChangeVehiclePaintjob(wVeiculo, 2);
            }
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 420)
            {
                    AddVehicleComponent(wVeiculo,1010);
                    AddVehicleComponent(wVeiculo,1087);
                    AddVehicleComponent(wVeiculo,1079);
                    AddVehicleComponent(wVeiculo,1139);
            }
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 400)
            {
                    AddVehicleComponent(wVeiculo,1010);
                    AddVehicleComponent(wVeiculo,1087);
                    AddVehicleComponent(wVeiculo,1018);
                    AddVehicleComponent(wVeiculo,1013);
                    AddVehicleComponent(wVeiculo,1079);
                    AddVehicleComponent(wVeiculo,1086);
            }
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 401)
            {
                    AddVehicleComponent(wVeiculo,1086);
                    AddVehicleComponent(wVeiculo,1139);
                    AddVehicleComponent(wVeiculo,1079);
                    AddVehicleComponent(wVeiculo,1010);
                    AddVehicleComponent(wVeiculo,1087);
                    AddVehicleComponent(wVeiculo,1012);
                    AddVehicleComponent(wVeiculo,1013);
                    AddVehicleComponent(wVeiculo,1042);
                    AddVehicleComponent(wVeiculo,1043);
                    AddVehicleComponent(wVeiculo,1018);
                    AddVehicleComponent(wVeiculo,1006);
                    AddVehicleComponent(wVeiculo,1007);
                    AddVehicleComponent(wVeiculo,1017);
            }
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 576)
            {
                    ChangeVehiclePaintjob(wVeiculo,2);
                    AddVehicleComponent(wVeiculo,1191);
                    AddVehicleComponent(wVeiculo,1193);
                    AddVehicleComponent(wVeiculo,1010);
                    AddVehicleComponent(wVeiculo,1018);
                    AddVehicleComponent(wVeiculo,1079);
                    AddVehicleComponent(wVeiculo,1087);
                    AddVehicleComponent(wVeiculo,1134);
                    AddVehicleComponent(wVeiculo,1137);
            }
            else
            {
                    AddVehicleComponent(wVeiculo,1010);
                    AddVehicleComponent(wVeiculo,1079);
                    AddVehicleComponent(wVeiculo,1087);
            }
            return 1;
    }
    if(clickedid == wTuning2[0]){ // SHADOW
            AddVehicleComponent(wVeiculo,1073);
            return 1;
    }
    if(clickedid == wTuning2[1]){ // MEGA
            AddVehicleComponent(wVeiculo, 1074);
            return 1;
    }
    if(clickedid == wTuning2[2]){  // RINSHIME
            AddVehicleComponent(wVeiculo,1075);
            return 1;
    }
    if(clickedid == wTuning2[3]){ // WIRES
            AddVehicleComponent(wVeiculo,1076);
            return 1;
    }
    if(clickedid == wTuning2[4]){ // CLASSIC
            AddVehicleComponent(wVeiculo,1077);
            return 1;
    }
    if(clickedid == wTuning2[5]){ // TWIST
            AddVehicleComponent(wVeiculo,1078);
            return 1;
    }
    if(clickedid == wTuning2[6]){ // CUTTER
            AddVehicleComponent(wVeiculo,1079);
            return 1;
    }
    if(clickedid == wTuning2[7]){ // DOLLAR
            AddVehicleComponent(wVeiculo,1083);
            return 1;
    }
    if(clickedid == wTuning2[8]){ // ATOMIC
            AddVehicleComponent(wVeiculo,1085);
            return 1;
    }

    if(clickedid == wTuning1[14]){ // BLACK
            ChangeVehicleColor(wVeiculo, 0, 0);
            return 1;
    }
    if(clickedid == wTuning1[15]){ // WHITE
            ChangeVehicleColor(wVeiculo, 1, 1);
            return 1;
    }
    if(clickedid == wTuning1[16]){ // GREEN
            ChangeVehicleColor(wVeiculo, 128, 128);
            return 1;
    }
    if(clickedid == wTuning1[17]){ // CYAN
            ChangeVehicleColor(wVeiculo, 135, 135);
            return 1;
    }
    if(clickedid == wTuning1[18]){ // BLUE
            ChangeVehicleColor(wVeiculo, 152, 152);
            return 1;
    }
    if(clickedid == wTuning1[19]){ // YELLOW
            ChangeVehicleColor(wVeiculo, 6, 6);
            return 1;
    }
    if(clickedid == wTuning1[20]){ // GRAY
            ChangeVehicleColor(wVeiculo, 252, 252);
            return 1;
    }
    if(clickedid == wTuning1[21]){ // PINK
            ChangeVehicleColor(wVeiculo, 146, 146);
            return 1;
    }
    if(clickedid == wTuning1[22]){ // ORANGE
            ChangeVehicleColor(wVeiculo, 219, 219);
            return 1;
    }
    if(clickedid == wTuning4[0]){ // PAINTJOBS 1
            ChangeVehiclePaintjob(wVeiculo, 0);
            return 1;
    }
    if(clickedid == wTuning4[1]){ // PAINTJOBS 2
            ChangeVehiclePaintjob(wVeiculo, 2);
            return 1;
    }
    if(clickedid == wTuning4[2]){ // PAINTJOBS 2
            ChangeVehiclePaintjob(wVeiculo, 3);
            return 1;
    }
    if(clickedid == wTuning5[0]){ // NITRO 1
            AddVehicleComponent(wVeiculo,1009);
            return 1;
    }
    if(clickedid == wTuning5[1]){ // NITRO 2
            AddVehicleComponent(wVeiculo,1008);
            return 1;
    }
    if(clickedid == wTuning5[2]){ // NITRO 3
            AddVehicleComponent(wVeiculo,1010);
            return 1;
    }

    if(clickedid == wTuning3[0]){
            SetPVarInt(playerid, "neon", 1);
            SetPVarInt(playerid, "blue", CreateObject(18648,0,0,0,0,0,0));
            SetPVarInt(playerid, "blue1", CreateObject(18648,0,0,0,0,0,0));
            AttachObjectToVehicle(GetPVarInt(playerid, "blue"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            AttachObjectToVehicle(GetPVarInt(playerid, "blue1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            return 1;
    }

    if(clickedid == wTuning3[1]){
            SetPVarInt(playerid, "neon", 1);
            SetPVarInt(playerid, "yellow", CreateObject(18650,0,0,0,0,0,0));
            SetPVarInt(playerid, "yellow1", CreateObject(18650,0,0,0,0,0,0));
            AttachObjectToVehicle(GetPVarInt(playerid, "yellow"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            AttachObjectToVehicle(GetPVarInt(playerid, "yellow1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            return 1;
    }
    if(clickedid == wTuning3[2]){
            SetPVarInt(playerid, "neon", 1);
            SetPVarInt(playerid, "white", CreateObject(18652,0,0,0,0,0,0));
            SetPVarInt(playerid, "white1", CreateObject(18652,0,0,0,0,0,0));
            AttachObjectToVehicle(GetPVarInt(playerid, "white"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            AttachObjectToVehicle(GetPVarInt(playerid, "white1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            return 1;
    }
    if(clickedid == wTuning3[3]){
            SetPVarInt(playerid, "neon", 1);
            SetPVarInt(playerid, "pink", CreateObject(18651,0,0,0,0,0,0));
            SetPVarInt(playerid, "pink1", CreateObject(18651,0,0,0,0,0,0));
            AttachObjectToVehicle(GetPVarInt(playerid, "pink"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            AttachObjectToVehicle(GetPVarInt(playerid, "pink1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            return 1;
    }
    if(clickedid == wTuning3[4]){
            SetPVarInt(playerid, "neon", 1);
            SetPVarInt(playerid, "green", CreateObject(18649,0,0,0,0,0,0));
            SetPVarInt(playerid, "green1", CreateObject(18649,0,0,0,0,0,0));
            AttachObjectToVehicle(GetPVarInt(playerid, "green"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            AttachObjectToVehicle(GetPVarInt(playerid, "green1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            return 1;
    }
    if(clickedid == wTuning3[5]){
            DestroyObject(GetPVarInt(playerid, "blue"));
            DeletePVar(playerid, "neon");
            DestroyObject(GetPVarInt(playerid, "blue1"));
            DeletePVar(playerid, "neon");
            DestroyObject(GetPVarInt(playerid, "green"));
            DeletePVar(playerid, "neon");
            DestroyObject(GetPVarInt(playerid, "green1"));
            DeletePVar(playerid, "neon");
            DestroyObject(GetPVarInt(playerid, "yellow"));
            DeletePVar(playerid, "neon");
            DestroyObject(GetPVarInt(playerid, "yellow1"));
            DeletePVar(playerid, "neon");
            DestroyObject(GetPVarInt(playerid, "white"));
            DeletePVar(playerid, "neon");
            DestroyObject(GetPVarInt(playerid, "white1"));
            DeletePVar(playerid, "neon");
            DestroyObject(GetPVarInt(playerid, "pink"));
            DeletePVar(playerid, "neon");
            DestroyObject(GetPVarInt(playerid, "pink1"));
            DeletePVar(playerid, "neon");
            return 1;
    }
    if(clickedid == Text:INVALID_TEXT_DRAW)
    {
            for(new i = 0; i < sizeof(wTuning1); i++) { TextDrawHideForPlayer(playerid, wTuning1[i]); }
            for(new i = 0; i < sizeof(wTuning2); i++)       { TextDrawHideForPlayer(playerid, wTuning2[i]); }
            for(new i = 0; i < sizeof(wTuning3); i++) { TextDrawHideForPlayer(playerid, wTuning3[i]); }
            for(new i = 0; i < sizeof(wTuning4); i++) { TextDrawHideForPlayer(playerid, wTuning4[i]); }
            for(new i = 0; i < sizeof(wTuning5); i++)       { TextDrawHideForPlayer(playerid, wTuning5[i]); }
    }

	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
/*PlayerTextDrawHide(playerid, DeathTD[playerid]);*/

	// เพลงล็อคอิน
	//PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/Double 2.mp3");
    TogglePlayerSpectating(playerid, 1);

/*if (!playerData[playerid][IsLoggedIn])
	{
	    TogglePlayerSpectating(playerid, 1);
		SetTimerEx("OnAccountCheck", 400, false, "d", playerid);
	}
	else
	{*/
  	SpawnPlayer(playerid);
	SetTimerEx("OnAccountCheck", 400, false, "d", playerid);
	return 1;
}


forward UpdateTime();
public UpdateTime()
{
	static
	    time[3];

	gettime(time[0], time[1], time[2]);

	foreach (new i : Player)
	{
		SetPlayerTime(i, time[0], time[1]);
	}
	SetTimer("UpdateTime", 30000, false);
}

forward OnAccountCheck(playerid);
public OnAccountCheck(playerid)
{
	OnAccountCheckCamera(playerid);
	OnAccountCheckMySQL(playerid);
	return 1;
}
ResetEditing(playerid)
{
	playerData[playerid][pEditType] = 0;
 	playerData[playerid][pEditGate] = -1;
	return 1;
}



OnAccountCheckCamera(playerid)
{
	InterpolateCameraPos(playerid, 2057.2117,1283.9945,46.2387, 2057.2847,1677.3453,39.0880, 30000);
	InterpolateCameraLookAt(playerid, 2057.5696,1512.2155,46.4150, 2057.2847,1677.3453,39.0880, 30000);

	return 1;
}

OnAccountCheckMySQL(playerid)
{
	new query[103];
	mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `players` WHERE `playerName` = '%e' LIMIT 1", GetPlayerNameEx(playerid));
	mysql_tquery(g_SQL, query, "OnPlayerLoaded", "d", playerid);
	return 1;
}

CreatePlayerStuff(playerid)
{

	// Death message
	PlayerDeathTD[playerid] = CreatePlayerTextDraw(playerid, 216.000000, 357.000000, "Respawn available in 02 minutes 58 seconds");
	PlayerTextDrawFont(playerid, PlayerDeathTD[playerid], 2);
	PlayerTextDrawLetterSize(playerid, PlayerDeathTD[playerid], 0.212500, 1.499999);
	PlayerTextDrawTextSize(playerid, PlayerDeathTD[playerid], 446.000000, 31.000000);
	PlayerTextDrawSetOutline(playerid, PlayerDeathTD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, PlayerDeathTD[playerid], 0);
	PlayerTextDrawAlignment(playerid, PlayerDeathTD[playerid], 1);
	PlayerTextDrawColor(playerid, PlayerDeathTD[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerDeathTD[playerid], 255);
	PlayerTextDrawBoxColor(playerid, PlayerDeathTD[playerid], 50);
	PlayerTextDrawUseBox(playerid, PlayerDeathTD[playerid], 0);
	PlayerTextDrawSetProportional(playerid, PlayerDeathTD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerDeathTD[playerid], 0);


}

/*
GivePlayerExp(playerid, amount)
{
	if (GetPlayerExp(playerid) > GetPlayerRequiredExp(playerid))
		return 0;

	playerData[playerid][pExp] += amount;
	ShowPlayerExpEarn(playerid, amount);
	//PlayerLoadStats(playerid);
	
    return 1;
}

ShowPlayerExpEarn(playerid, exp, time = 3000)
{
	if (playerData[playerid][pExpShow])
	{
		PlayerTextDrawHide(playerid, PlayerExpEarnBoxTD1[playerid]);
		PlayerTextDrawHide(playerid, PlayerExpEarnBoxTD2[playerid]);
		PlayerTextDrawHide(playerid, PlayerEarnExpAmountTD[playerid]);
	    KillTimer(playerData[playerid][pExpTimer]);
	}
	new string[15];
	format(string, sizeof(string), "EXP+%d", exp);
	PlayerTextDrawSetString(playerid, PlayerEarnExpAmountTD[playerid], string);
	PlayerTextDrawShow(playerid, PlayerExpEarnBoxTD1[playerid]);
	PlayerTextDrawShow(playerid, PlayerExpEarnBoxTD2[playerid]);
	PlayerTextDrawShow(playerid, PlayerEarnExpAmountTD[playerid]);

	playerData[playerid][pExpShow] = true;
	playerData[playerid][pExpTimer] = SetTimerEx("HidePlayerExpEarn", time, false, "d", playerid);
}
*/
forward HidePlayerExpEarn(playerid);
public HidePlayerExpEarn(playerid)
{
	if (!playerData[playerid][pExpShow])
	    return 0;

	playerData[playerid][pExpShow] = false;
	PlayerTextDrawHide(playerid, PlayerExpEarnBoxTD1[playerid]);
	PlayerTextDrawHide(playerid, PlayerExpEarnBoxTD2[playerid]);
	PlayerTextDrawHide(playerid, PlayerEarnExpAmountTD[playerid]);
	return 1;
}


ShowPlayerStats(playerid, bool:enable)
{
	//new tmp2[256];
	if(enable == true)
	{
		BlacoWoods_ShowPlayerStats(playerid);
	}
	else
	{
		BlacoWoods_HidePlayerStats(playerid);
	}
}

DestroyPlayerStuff(playerid)
{
	PlayerTextDrawDestroy(playerid, PlayerSpeedoCountTD[playerid]);
	PlayerTextDrawDestroy(playerid, PlayerSpeedoKMHTD[playerid]);
	PlayerTextDrawDestroy(playerid, PlayerSpeedoFuelCountTD[playerid]);
	PlayerTextDrawDestroy(playerid, PlayerSpeedoFuelLitersTD[playerid]);
	PlayerTextDrawDestroy(playerid, tdexp[playerid]);
	PlayerTextDrawDestroy(playerid, tddollar[playerid]);
	PlayerTextDrawDestroy(playerid, tdredmoney[playerid]);
	PlayerTextDrawDestroy(playerid, tdgangicon[playerid]);
	PlayerTextDrawDestroy(playerid, tdidname[playerid]);
	PlayerTextDrawDestroy(playerid, tdlogo1[playerid]);
	PlayerTextDrawDestroy(playerid, tdlogo2[playerid]);
	PlayerTextDrawDestroy(playerid, tdlogo3[playerid]);
	PlayerTextDrawDestroy(playerid, tdlogo4[playerid]);
	DestroyPlayerProgressBar(playerid, barhp[playerid]);
	DestroyPlayerProgressBar(playerid, bararmour[playerid]);
	DestroyPlayerProgressBar(playerid, barhungry[playerid]);
	DestroyPlayerProgressBar(playerid, bardrink[playerid]);
	DestroyPlayerProgressBar(playerid, barexp[playerid]);
}

public OnPlayerConnect(playerid)
{

	new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    if (!IsRPName(name))
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[ผิดพลาด] {FFFFFF}กรุณามใช้ชื่อที่สมบทบาทชีวิตจริง เช่น {FFFF00}*Firstname_Lastname");
        SetTimerEx("KickTimePlayer", 1000, 0, "i", playerid);
    }
	SetPlayerMapIcon(playerid, 1, 1129.1594,-1489.7023,22.7690, 12, 0, MAPICON_LOCAL); //Ls_Mall
	playerData[playerid][pCheckpoint] = 0;
	// กล่องยาเพิ่มเลือด
	useFirstAidKit[playerid] = 0;

 

	
	// Boombox
	BoomboxData[playerid][boomboxPlaced] = 0;
	BoomboxData[playerid][boomboxPos][0] = 0.0;
	BoomboxData[playerid][boomboxPos][1] = 0.0;
	BoomboxData[playerid][boomboxPos][2] = 0.0;

	HUDToggle[playerid] = 1;

	isBaseFire[playerid] = 0;

	playerData[playerid][pBoombox] = INVALID_PLAYER_ID;

	// ของแต่งตัว
	cl_buying[playerid] = 0;
    for(new i=0;i!=MAX_CLOTHES; ++i) cl_dataslot[playerid][i] = -1, ClothingData[playerid][i][cl_object] = INVALID_OBJECT_ID;

    isPoonStart[playerid] = 0;
    DubLNW[playerid] = 0;
    BottleOn[playerid] = 0;
    ArmourOn[playerid] = 0;
	inLabel[playerid] = 0;
	// หมัดไฟ
    MudFireOn[playerid] = 0;
    WeaponType[playerid] = 0;
    DubFah[playerid] = 0;
    KnifeFire[playerid] = 0;
    MudShockOn[playerid] = 0;
    DubOn[playerid] = 0;
    GreenOn[playerid] = 0;
	DubSS[playerid] = 0;
	DubBB[playerid] = 0;
	DubCC[playerid] = 0;
	DubAB[playerid] = 0;
	DubBA[playerid] = 0;
    // ระบบ GPS

	ResetEditing(playerid);

	WorkTD[playerid][0] = CreatePlayerTextDraw(playerid, 319.750000, 415.000000, "Working...");
	PlayerTextDrawFont(playerid, WorkTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, WorkTD[playerid][0], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, WorkTD[playerid][0], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, WorkTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, WorkTD[playerid][0], 1);
	PlayerTextDrawAlignment(playerid, WorkTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, WorkTD[playerid][0], -764862721);
	PlayerTextDrawBackgroundColor(playerid, WorkTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, WorkTD[playerid][0], 200);
	PlayerTextDrawUseBox(playerid, WorkTD[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, WorkTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, WorkTD[playerid][0], 0);



	CreatePlayerStuff(playerid);
	ResetPlayerConnection(playerid);


	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	// ออกจากเกมแล้วแจ้งเตือนคนที่อยู่ใกล้ ::
	new szDisconnectReason[3][] =
    {
        "หลุดออกจากเซิร์ฟเวอร์",
        "ออกจากเซิร์ฟเวอร์",
        "ถูกเตะออก / ถูกแบนออก จากเซิร์ฟเวอร์"
    };
	SendNearbyMessage(playerid, 15.0, COLOR_GREY4, "[ออกจากเซิร์ฟเวอร์] %s สาเหตุ: %s", GetPlayerNameEx(playerid), szDisconnectReason[reason]);

    if(IsValidDynamic3DTextLabel(pUIDTag[playerid])) 
    {
        DestroyDynamic3DTextLabel(pUIDTag[playerid]); 
    }

	/*if (GetPlayerWantedLevelEx(playerid) > 0)
	{
	    playerData[playerid][pPrisoned] = 1;
	    playerData[playerid][pJailTime] = GetPlayerWantedLevelEx(playerid)*120;
	    playerData[playerid][pRedMoney] = 0;

		new query[256];
		mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `playerJailTime` = %d WHERE `playerID` = %d LIMIT 1", playerData[playerid][pJailTime], playerData[playerid][pID]);
		mysql_tquery(g_SQL, query);

	    UpdateplayerData(playerid);
	    SendFactionMessageEx(FACTION_POLICE, -1, "{C40E02}[HQ] > {FA9891}ผู้ต้องหา %s ได้ทำการออกจากเซิร์ฟเวอร์ (สาเหตุ:%s) ทำให้ถูกส่งเข้าคุกทันที!", GetPlayerNameEx(playerid), szDisconnectReason[reason]);
	}*/

    UpdateplayerData(playerid);

	if (BoomboxData[playerid][boomboxPlaced])
		Boombox_Destroy(playerid);

    if (playerData[playerid][pRoadblock] != -1)
    {
		DestroyDynamicObject(playerData[playerid][pRoadblock]);
		playerData[playerid][pRoadblock] = -1;
	}
    for (new i = 0; i <= 9; i++)
    {
        RemovePlayerAttachedObject(playerid, i);
    }

	if(playerData[playerid][IsLoggedIn])
	{
		for(new i = 1; i < MAX_VEHICLES; i ++)
		{
	    	if(IsValidVehicle(i) && IsVehicleOwner(playerid, i) && carData[i][carTimer] == -1)
		    {
				carData[i][carTimer] = SetTimerEx("DespawnTimer", 600000, false, "d", i);
	   		}
		}
	}
    DestroyPlayerStuff(playerid);


	if (playerData[playerid][LoginTimer])
	{
		KillTimer(playerData[playerid][LoginTimer]);
		playerData[playerid][LoginTimer] = 0;
	}
	ResetPlayerDisconnection(playerid);

	playerData[playerid][IsLoggedIn] = false;
	return 1;
}



public OnPlayerSpawn(playerid)
{
    playerData[playerid][pSpeedGoon] = 0;

    GangZoneShowForAll(FishingZone, 0x007FFFFF);

	// ปิดเพลง
	StopAudioStreamForPlayer(playerid);


	/*new string[582],
		playerName[MAX_PLAYER_NAME];
		// ไวริส - ตรวจสอบ
	if (isPlayerAndroid(playerid))
	{
	    else
	    {
	    	SendClientMessage(playerid, COLOR_GREY, "> คุณได้เข้าเล่นผ่านอุปกรณ์ {FFFFFF}Android");
		}
		//SendClientMessage(playerid, COLOR_WHITE, "- คุณได้เข้าเล่นผ่านอุปกรณ์ {FFA84D}Mobile");


		GetPlayerName(playerid, playerName, sizeof(playerName));
		format(string, sizeof(string), "ID: {FFFFFF}%d", playerid);
		pUIDTag[playerid] = CreateDynamic3DTextLabel(string, 0xFFA84DFF, 0.0, 0.0, 0.1, 5.0, playerid);
	
	}
	else
	{
	    if(playerData[playerid][pWhitelist] == 2)
	    {
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "{FF0000}[การตรวจสอบไวริส!]", "{FFFF00}ตัวละครของคุณยังไม่มีไวริส!\n> กรุณาติดต่อผู้ดูแลระบบ!", "ตกลง", "");
	        SetTimerEx("KickTimePlayer", 1000, 0, "d", playerid);
	        return 1;
	    }
	    else
	    {
	    //SendClientMessage(playerid, COLOR_WHITE, "- คุณได้เข้าเล่นผ่านอุปกรณ์ {FFA84D}PC");
		
		GetPlayerName(playerid, playerName, sizeof(playerName));
		format(string, sizeof(string), "ID: {FFFFFF}%d", playerid);
		pUIDTag[playerid] = CreateDynamic3DTextLabel(string, 0xFFA84DFF, 0.0, 0.0, 0.1, 5.0, playerid);
		
	}*/

	SetPlayerSkin(playerid, playerData[playerid][pSkin]);

	/*if (inLabel[playerid] == 1)
	{
		SetPlayerInterior(playerid, playerData[playerid][pInterior]);
		SetPlayerVirtualWorld(playerid, playerData[playerid][pWorld]);
		SetPlayerPos(playerid, playerData[playerid][pPos_X], playerData[playerid][pPos_Y], playerData[playerid][pPos_Z]);
		SetPlayerFacingAngle(playerid, playerData[playerid][pPos_A]);
		SetPlayerHealth(playerid, 100);
        inLabel[playerid] = 0;

	    return 1;
	}*/
	if (playerData[playerid][pJailTime] > 0)
	{
	    SetPlayerInPrison(playerid);
	    SetPlayerWeather(playerid, globalWeather);
	}
	else
	{
	    if (playerData[playerid][pInjured])
	    {

			if(!GetPlayerVehicleID(playerid))
			{
				SetPlayerPos(playerid, playerData[playerid][pPos_X], playerData[playerid][pPos_Y], playerData[playerid][pPos_Z]);
				SetPlayerFacingAngle(playerid, playerData[playerid][pPos_A]);
				ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);
			}
			else ApplyAnimation(playerid, "ped", "CAR_dead_LHS", 4.1, 0, 0, 0, 1, 0, 1);

			SetPlayerInterior(playerid, playerData[playerid][pInterior]);
			SetPlayerVirtualWorld(playerid, playerData[playerid][pWorld]);
			PlayerTextDrawShow(playerid, PlayerDeathTD[playerid]);

			ShowPlayerStats(playerid, true);
			PlayerTextDrawShow(playerid, ZonetextTD[playerid][0]);
			SendClientMessage(playerid, COLOR_YELLOW, "[Medical-Message]: คุณกำลังอยู่ในสถานะบาดเจ็บ, กด 'N' เพื่อขอความช่วยเหลือ");
			//SendClientMessage(playerid, COLOR_LIGHTRED, "[คำเตือน]:{FFFFFF} คุณกำลังอยู่ในสถานะบาดเจ็บ กรุณาโทรเรียก /call 911 เพื่อขอความช่วยเหลือ");
		}
		else if (playerData[playerid][pOnSpectator] == 1)
		{
			SetPlayerInterior(playerid, playerData[playerid][pInterior]);
			SetPlayerVirtualWorld(playerid, playerData[playerid][pWorld]);
			SetPlayerPos(playerid, playerData[playerid][pPos_X], playerData[playerid][pPos_Y], playerData[playerid][pPos_Z]);
			SetPlayerFacingAngle(playerid, playerData[playerid][pPos_A]);
			SetPlayerWeather(playerid, globalWeather);

			SetPlayerHealth(playerid, playerData[playerid][pHealth]);
			SetCameraBehindPlayer(playerid);

			playerData[playerid][pOnSpectator] = 0;

			return 1;
		}
	    else
	    {
	        if (playerData[playerid][pHospital] != -1)
	        {
				SendClientMessage(playerid, COLOR_LIGHTRED, "[Death]: ตัวละครของคุณนั้นถูกส่งเข้าโรงพยาบาล, คุณเสียเงินจำนวน $2,500 จากการรักษา");
				GivePlayerMoneyEx(playerid, -2500);
	            SetPlayerPos(playerid, 1172.1874,-1323.3922,15.4031);
	            SetPlayerFacingAngle(playerid, 272.5489);
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				PlayerTextDrawHide(playerid, PlayerDeathTD[playerid]);
				playerData[playerid][pHospital] = -1;

				playerData[playerid][pHungry] = 100;
				playerData[playerid][pThirsty] = 100;

				ClearAnimations(playerid);
				TogglePlayerControllable(playerid, true);
				SetPlayerWeather(playerid, globalWeather);
			}
	        else
	        {
				if (playerData[playerid][pSpawnPoint] == 0)
			    {
					SetPlayerPos(playerid, 1445.8163,-2286.9094,13.5469);
					SetPlayerFacingAngle(playerid, 92.3983);
				    SetPlayerVirtualWorld(playerid, 0);
				    SetPlayerInterior(playerid, 0);
					playerData[playerid][pSpawnPoint] = 1;
			    }
				if (playerData[playerid][pSpawnPoint] == 1)
				{
				    if (playerData[playerid][pPos_X] == 0.0 && playerData[playerid][pPos_Y] == 0.0 && playerData[playerid][pPos_Z] == 0.0)
				    {
						SetPlayerPos(playerid, 1445.8163,-2286.9094,13.5469);
						SetPlayerFacingAngle(playerid, 92.3983);
					    SetPlayerVirtualWorld(playerid, 0);
					    SetPlayerInterior(playerid, 0);
				    }
				    else
				    {
						SetPlayerInterior(playerid, playerData[playerid][pInterior]);
						SetPlayerVirtualWorld(playerid, playerData[playerid][pWorld]);
						SetPlayerPos(playerid, playerData[playerid][pPos_X], playerData[playerid][pPos_Y], playerData[playerid][pPos_Z]);
						SetPlayerFacingAngle(playerid, playerData[playerid][pPos_A]);
					}
				}
				SetPlayerWeather(playerid, globalWeather);
			}
			ShowPlayerStats(playerid, true);
			PlayerTextDrawShow(playerid, ZonetextTD[playerid][0]);
		}
	}
	if(playerData[playerid][pWhitelist] == 0)
	{
		Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "[Whitelist]", "{FF6347}ตัวละครของคุณนั้นยังไม่มีไวริส! สามารถติดค่อรับไวริสได้ที่ {8D8DFF}Diacord {FF6347}ของเซิร์ฟเวอร์\n\
		{FFFF00}Link: https://discord.gg/Vn29uj3gYy", "ปิด", "");
		SetTimerEx("KickTimePlayer", 1000, 0, "d", playerid);
		return 1;
	}
	SetCameraBehindPlayer(playerid);

	/*if(playerData[playerid][pFaction] > 0)
	{*/
	if(playerData[playerid][pOnDuty] == 0)
	{
		PlayerParty[playerid]=NO_PARTY;
		RemoveMarkers(playerid);
	}

	if(playerData[playerid][pOnDuty] == 1)
	{
		SetFactionColor(playerid);

		PlayerParty[playerid] = playerData[playerid][pFaction];
		foreach(new member : Player) {if (PlayerParty[member] == playerData[playerid][pFaction]) {ShowMarkers(member, playerid);}}
	}

	//}
	return 1;
}


/*
Float:ExpToPecentage(playerid)
{
	new Float:exp = (playerData[playerid][pExp]*100/GetPlayerRequiredExp(playerid));
	return exp;
}*/

public OnPlayerUpdate(playerid)
{
	if (GetPlayerMoney(playerid) != playerData[playerid][pMoney])
	{
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, playerData[playerid][pMoney]);
	}
	if (GetPlayerExpcraft(playerid) >= GetPlayerRequiredExpcraft(playerid))
	{
		GivePlayerLevelCraft(playerid, 1);
		SetPlayerExpCraft(playerid, 0);
	}

    IsAFK{playerid} = false;
    AFKTimer[playerid] = 3;

	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{

	if (newkeys & KEY_SECONDARY_ATTACK && !IsPlayerInAnyVehicle(playerid))
	{
		static
			id = -1;

		if ((id = Entrance_Nearest(playerid)) != -1)
	    {
	        if (entranceData[id][entranceLocked])
	            return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถเข้าได้ เนื่องจากประตูนี้ถูกล็อค");

			GameTextForPlayer(playerid, "~w~Loading Object...", 3000, 3);
			TogglePlayerControllable(playerid, 0);
			SetTimerEx("TimeUnfreezeEnterGame", 3000, 0, "d", playerid);


			if (entranceData[id][entranceFaction] == -1)
			{
			    SetPlayerPos(playerid, entranceData[id][entranceIntX], entranceData[id][entranceIntY], entranceData[id][entranceIntZ]);
				SetPlayerFacingAngle(playerid, entranceData[id][entranceIntA]);

				SetPlayerInterior(playerid, entranceData[id][entranceInterior]);
				SetPlayerVirtualWorld(playerid, entranceData[id][entranceWorld]);

				SetCameraBehindPlayer(playerid);
				playerData[playerid][pEntrance] = entranceData[id][entranceID];
			}
			else
			{
			    if (playerData[playerid][pFaction] == entranceData[id][entranceFaction])
			    {
				    SetPlayerPos(playerid, entranceData[id][entranceIntX], entranceData[id][entranceIntY], entranceData[id][entranceIntZ]);
					SetPlayerFacingAngle(playerid, entranceData[id][entranceIntA]);

					SetPlayerInterior(playerid, entranceData[id][entranceInterior]);
					SetPlayerVirtualWorld(playerid, entranceData[id][entranceWorld]);

					SetCameraBehindPlayer(playerid);
					playerData[playerid][pEntrance] = entranceData[id][entranceID];
				}
			}
			return 1;
		}
		else if ((id = Entrance_Inside(playerid)) != -1 && IsPlayerInRangeOfPoint(playerid, 2.5, entranceData[id][entranceIntX], entranceData[id][entranceIntY], entranceData[id][entranceIntZ]))
	    {
	        SetPlayerPos(playerid, entranceData[id][entrancePosX], entranceData[id][entrancePosY], entranceData[id][entrancePosZ]);
			SetPlayerFacingAngle(playerid, entranceData[id][entrancePosA] - 180.0);

			SetPlayerInterior(playerid, entranceData[id][entranceExterior]);
			SetPlayerVirtualWorld(playerid, entranceData[id][entranceExteriorVW]);

			SetCameraBehindPlayer(playerid);
			playerData[playerid][pEntrance] = Entrance_GetLink(playerid);
			return 1;
		}
	}
	if (newkeys & KEY_NO && !IsPlayerInAnyVehicle(playerid))
	{
	
        if (IsPlayerInRangeOfPoint(playerid, 2.5, 1051.1139,-938.7141,42.7662))
        {
      		if (GetFactionType(playerid) != FACTION_MEC)
			    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ใช่ช่าง!");

			Dialog_Show(playerid,DIALOG_CRAFT_CARTUNE,DIALOG_STYLE_MSGBOX,"{FFFFFF}[{16D603}การสร้างกล่องจูนรถ{FFFFFF}]", "{3CD606}สิ่งของ > กล่องจูนรถ\n\n{FFFFFF}- เหล็ก (40)\n- แร่แดง (40)\n- แร่ฟ้า (40)\n- เงินเขียว $20,000\n\n{6BF939}โอกาสสำเร็จ : 100%", "ตกลง", "ยกเลิก");
        }
        // นอนเตียง
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 359.0169,188.5589,1008.3828))
        {
            if (BeforeSleep[playerid] == 1)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณอยู่ระหว่างการนอนเตียง!");

			if (GetPlayerMoneyEx(playerid) < 500)
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องมีเงินมากกว่า $500");

            TogglePlayerControllable(playerid, 0);
		    SetPlayerPos(playerid, 359.0169,188.5589,1008.3828);
		    SetPlayerFacingAngle(playerid, 77.9887);

		    ApplyAnimation(playerid, "CRACK","crckidle2", 4.1, 1, 1, 1, 0, 0, 0);
		    BeforeSleep[playerid] = 1;

			SendClientMessage(playerid, COLOR_LIGHTRED, "(( คุณได้นอนเตียงพยาบาลแล้ว, กรุณารอสักครู่ ))");
			ApplyAnimation(playerid, "CRACK","crckidle2", 4.1, 1, 1, 1, 0, 0, 0);

			StartProgress(playerid, 150, 0, INVALID_OBJECT_ID);
        }

        if (IsPlayerInRangeOfPoint(playerid, 3.0, 358.5921,184.1946,1008.3828))
        {
            if (BeforeSleep[playerid] == 1)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณอยู่ระหว่างการนอนเตียง!");

			if (GetPlayerMoneyEx(playerid) < 500)
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องมีเงินมากกว่า $500");

		    TogglePlayerControllable(playerid, 0);
		    SetPlayerPos(playerid, 358.5921,184.1946,1008.3828);
		    SetPlayerFacingAngle(playerid, 77.3620);

		    ApplyAnimation(playerid, "CRACK","crckidle2", 4.1, 1, 1, 1, 0, 0, 0);
		    BeforeSleep[playerid] = 1;

            SendClientMessage(playerid, COLOR_LIGHTRED, "(( คุณได้นอนเตียงพยาบาลแล้ว, กรุณารอสักครู่ ))");
            ApplyAnimation(playerid, "CRACK","crckidle2", 4.1, 1, 1, 1, 0, 0, 0);

            StartProgress(playerid, 150, 0, INVALID_OBJECT_ID);
        }

        if (IsPlayerInRangeOfPoint(playerid, 3.0, 358.7317,181.4497,1008.3828))
        {
            if (BeforeSleep[playerid] == 1)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณอยู่ระหว่างการนอนเตียง!");

			if (GetPlayerMoneyEx(playerid) < 500)
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องมีเงินมากกว่า $500");

		    TogglePlayerControllable(playerid, 0);
		    SetPlayerPos(playerid, 358.7317,181.4497,1008.3828);
		    SetPlayerFacingAngle(playerid, 113.1549);

		    ApplyAnimation(playerid, "CRACK","crckidle2", 4.1, 1, 1, 1, 0, 0, 0);
		    BeforeSleep[playerid] = 1;

            SendClientMessage(playerid, COLOR_LIGHTRED, "(( คุณได้นอนเตียงพยาบาลแล้ว, กรุณารอสักครู่ ))");
            ApplyAnimation(playerid, "CRACK","crckidle2", 4.1, 1, 1, 1, 0, 0, 0);

            StartProgress(playerid, 150, 0, INVALID_OBJECT_ID);
        }

        if (IsPlayerInRangeOfPoint(playerid, 3.0, 358.8615,178.3055,1008.3828))
        {
            if (BeforeSleep[playerid] == 1)
                return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณอยู่ระหว่างการนอนเตียง!");

			if (GetPlayerMoneyEx(playerid) < 500)
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องมีเงินมากกว่า $500");

		    TogglePlayerControllable(playerid, 0);
		    SetPlayerPos(playerid, 358.8615,178.3055,1008.3828);
		    SetPlayerFacingAngle(playerid, 97.1022);

		    ApplyAnimation(playerid, "CRACK","crckidle2", 4.1, 1, 1, 1, 0, 0, 0);
		    BeforeSleep[playerid] = 1;

		    SendClientMessage(playerid, COLOR_LIGHTRED, "(( คุณได้นอนเตียงพยาบาลแล้ว, กรุณารอสักครู่ ))");
		    ApplyAnimation(playerid, "CRACK","crckidle2", 4.1, 1, 1, 1, 0, 0, 0);

		    StartProgress(playerid, 150, 0, INVALID_OBJECT_ID);
        }
			// --> โคเคน                          2327.0247,2784.8630,10
		if (IsPlayerInRangeOfPoint(playerid, 2.0, 2327.0247,2784.8630,10.5836))
		{
		    if (CopOnline() < 2)
		        return SendClientMessage(playerid, COLOR_LIGHTRED, "ต้องมี 'ตำรวจ' ออนไลน์มากกว่า '2 คน'");

			if (GetFactionType(playerid) == FACTION_POLICE && GetFactionType(playerid) == FACTION_MEDIC && GetFactionType(playerid) == FACTION_GOV)
			    return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับแก๊งเท่านั้น!");

		    if (isPoonStart[playerid] != 12)
		        return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณอยู่ระหว่างการ 'เก็บโคเคน'");

			GivePlayerWanted(playerid, 1);

			SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "เบาะแส : มีสายแจ้งมาว่ามีคนกำลังเก็บโคเคน, โปรดเฝ้าระวัง");

			isPoonStart[playerid] = 2;
			GivePlayerWanted(playerid, 2);
			SendClientMessage(playerid, COLOR_YELLOW, "* คุณได้เริ่มต้นการเก็บโคเคนผิดกฎหมายแล้ว!");
			return 1;
		}


	}

	return 1;
}


Dialog:DIALOG_TYPE_PAINTJOBS(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		SetCameraBehindPlayer(playerid);
	}
	if(response)
	{
		switch(listitem)// Checking which list item was selected
		{
			case 0:// Paintjobs
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 560 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 || // Broadway
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 535 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
			{
				new car = GetPlayerVehicleID(playerid);
				ChangeVehiclePaintjob(car,0);
				SendClientMessage(playerid,COLOR_WHITE,"คุณได้แต่งยานพาหนะของคุณเรียบร้อย");
				Dialog_Show(playerid, DIALOG_TYPE_PAINTJOBS, DIALOG_STYLE_LIST, "Paintjobs", "Paint Job 1\nPaint Job 2\nPaint Job 3\nPaint Job 4\nPaint Job 5\n \nBack", "ตกลง", "ยกเลิก");
				PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
			}
				else
			{
				SendClientMessage(playerid,COLOR_WHITE,"คำสั่งนี้สำหรับยานพาหนะที่มี 4 ล้อเท่านั้น");
				Dialog_Show(playerid, DIALOG_TYPE_PAINTJOBS, DIALOG_STYLE_LIST, "Paintjobs", "Paint Job 1\nPaint Job 2\nPaint Job 3\nPaint Job 4\nPaint Job 5\n \nBack", "ตกลง", "ยกเลิก");
			}
			}
			case 1: // Colors
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 560 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 || // Broadway
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 535 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
			{
				new car = GetPlayerVehicleID(playerid);
				ChangeVehiclePaintjob(car,1);
				SendClientMessage(playerid,COLOR_WHITE,"คุณได้แต่งยานพาหนะของคุณเรียบร้อย");
				Dialog_Show(playerid, DIALOG_TYPE_PAINTJOBS, DIALOG_STYLE_LIST, "Paintjobs", "Paint Job 1\nPaint Job 2\nPaint Job 3\nPaint Job 4\nPaint Job 5\n \nBack", "ตกลง", "ยกเลิก");
				PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
			}
				else
			{
				SendClientMessage(playerid,COLOR_WHITE,"คำสั่งนี้สำหรับยานพาหนะที่มี 4 ล้อเท่านั้น");
				Dialog_Show(playerid, DIALOG_TYPE_PAINTJOBS, DIALOG_STYLE_LIST, "Paintjobs", "Paint Job 1\nPaint Job 2\nPaint Job 3\nPaint Job 4\nPaint Job 5\n \nBack", "ตกลง", "ยกเลิก");
			}
			}
			case 2: // Exhausts
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 560 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 || // Broadway
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 535 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
			{
				new car = GetPlayerVehicleID(playerid);
				ChangeVehiclePaintjob(car,2);
				SendClientMessage(playerid,COLOR_WHITE,"คุณได้แต่งยานพาหนะของคุณเรียบร้อย");
				Dialog_Show(playerid, DIALOG_TYPE_PAINTJOBS, DIALOG_STYLE_LIST, "Paintjobs", "Paint Job 1\nPaint Job 2\nPaint Job 3\nPaint Job 4\nPaint Job 5\n \nBack", "ตกลง", "ยกเลิก");
				PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
			}
				else
			{
				SendClientMessage(playerid,COLOR_WHITE,"คำสั่งนี้สำหรับยานพาหนะที่มี 4 ล้อเท่านั้น");
				Dialog_Show(playerid, DIALOG_TYPE_PAINTJOBS, DIALOG_STYLE_LIST, "Paintjobs", "Paint Job 1\nPaint Job 2\nPaint Job 3\nPaint Job 4\nPaint Job 5\n \nBack", "ตกลง", "ยกเลิก");
			}
			}
			case 3: // Front Bumpers
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 560 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 || // Broadway
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 535 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
			{
				new car = GetPlayerVehicleID(playerid);
				ChangeVehiclePaintjob(car,3);
				SendClientMessage(playerid,COLOR_WHITE,"คุณได้แต่งยานพาหนะของคุณเรียบร้อย");
				Dialog_Show(playerid, DIALOG_TYPE_PAINTJOBS, DIALOG_STYLE_LIST, "Paintjobs", "Paint Job 1\nPaint Job 2\nPaint Job 3\nPaint Job 4\nPaint Job 5\n \nBack", "ตกลง", "ยกเลิก");
				PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
			}
				else
			{
				SendClientMessage(playerid,COLOR_WHITE,"คำสั่งนี้สำหรับยานพาหนะที่มี 4 ล้อเท่านั้น");
				Dialog_Show(playerid, DIALOG_TYPE_PAINTJOBS, DIALOG_STYLE_LIST, "Paintjobs", "Paint Job 1\nPaint Job 2\nPaint Job 3\nPaint Job 4\nPaint Job 5\n \nBack", "ตกลง", "ยกเลิก");
			}
			}
			case 4: // Rear Bumpers
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 560 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 || // Broadway
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 535 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
			GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
			{
				new car = GetPlayerVehicleID(playerid);
				ChangeVehiclePaintjob(car,4);
				SendClientMessage(playerid,COLOR_WHITE,"คุณได้แต่งยานพาหนะของคุณเรียบร้อย");
				Dialog_Show(playerid, DIALOG_TYPE_PAINTJOBS, DIALOG_STYLE_LIST, "Paintjobs", "Paint Job 1\nPaint Job 2\nPaint Job 3\nPaint Job 4\nPaint Job 5\n \nBack", "ตกลง", "ยกเลิก");
				PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
			}
				else
			{
				SendClientMessage(playerid,COLOR_WHITE,"คำสั่งนี้สำหรับยานพาหนะที่มี 4 ล้อเท่านั้น");
				Dialog_Show(playerid, DIALOG_TYPE_PAINTJOBS, DIALOG_STYLE_LIST, "Paintjobs", "Paint Job 1\nPaint Job 2\nPaint Job 3\nPaint Job 4\nPaint Job 5\n \nBack", "ตกลง", "ยกเลิก");
			}
			}
			case 5:
			{
				Dialog_Show(playerid, DIALOG_TYPE_PAINTJOBS, DIALOG_STYLE_LIST, "Paintjobs", "Paint Job 1\nPaint Job 2\nPaint Job 3\nPaint Job 4\nPaint Job 5\n \nBack", "ตกลง", "ยกเลิก");
			}
			case 6:
			{
				Dialog_Show(playerid, DIALOG_TYPE_MAIN, DIALOG_STYLE_LIST, "Car Tuning Menu", "Paint Jobs\nColors\nHoods\nVents\nLights\nExhausts\nFront Bumpers\nRear Bumpers\nRoofs\nSpoilers\nSide Skirts\nBullbars\nWheels\nCar Stereo\nHydraulics\nNitrous Oxide", "Enter", "Close");
			}
		}
	}
	return 1;
}

Dialog:DIALOG_AGPSPICK(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new var[32];
	    format(var, sizeof(var), "AGPSID%d", listitem);
	    new gpsid = GetPVarInt(playerid, var);
		SetPlayerPos(playerid, gpsData[gpsid][gpsPosX], gpsData[gpsid][gpsPosY], gpsData[gpsid][gpsPosZ]);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้วาร์ปหา GPSID: %d, ชื่อสถานที่: %s, รูปแบบ GPS: %d", gpsid, gpsData[gpsid][gpsName], gpsData[gpsid][gpsType]);
	}
	return 1;
}







public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new vehicleid = GetPlayerVehicleID(playerid);


	if (newstate == PLAYER_STATE_DRIVER)
	{
		pvehicleid[playerid] = GetPlayerVehicleID(playerid);
		pmodelid[playerid] = GetVehicleModel(pvehicleid[playerid]);


		/*if (playerData[playerid][pAdmin] == 0)
		{
		    if (carData[vehicleid][carFaction] >= 0 && playerData[playerid][pFaction] != carData[vehicleid][carFaction])
		    {
		        SendClientMessage(playerid, COLOR_RED, "- คุณไม่มีกุญแจ");
		        RemovePlayerFromVehicle(playerid);
		        return 1;
		    }
		}*/


	    if(IsVehicleOwner(playerid, vehicleid) && carData[vehicleid][carTickets] > 0)
	    {
	        SendClientMessageEx(playerid, COLOR_SERVER, "รถคันนี้โดนใบสั่งจำนวน %s ในการจ่ายใบสั่งสามารถใช้ /paytickets ได้เลย", FormatMoney(carData[vehicleid][carTickets]));
	    }
		if (IsABike(vehicleid))
		{
		    SetEngineStatus(vehicleid, true);
		}
		else
		{

			KillTimer(playerData[playerid][pSpeedoTimer]);
			switch(GetEngineStatus(vehicleid))
			{
				case false: SendClientMessage(playerid, COLOR_YELLOW, "[Vehicle]: กดปุ่ม 'N' เพื่อจัดการยานพาหนะ");
			}
			HidePlayerProgressBar(playerid, PlayerStamina[playerid][0]);
			ShowPlayerSpeedo(playerid, true);
			playerData[playerid][pSpeedoTimer] = SetTimerEx("SpeedoTimer", 250, true, "dd", playerid, vehicleid);
		}
	}
	else
	{
		ShowPlayerSpeedo(playerid, false);
		pvehicleid[playerid] = 0;
	    pmodelid[playerid] = 0;
	}
	return 1;
}


public OnPlayerEnterCheckpoint(playerid)
{

	/*if(IsPlayerInAnyVehicle(playerid))
	{
		DisablePlayerCheckpoint(playerid);
		PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
	}*/
	return 1;
}

//-----------------------------------------------------

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
    return 1;
}



public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
	if(playerData[playerid][IsLoggedIn] == false)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณจะต้อง Login เข้าสู่ระบบก่อน");

    if (result == -1)
    {
        SendClientMessageEx(playerid, COLOR_GREY, "Unknown Command Text...");
        return 0;
    }

    return 1;
}

ResetPlayerConnection(playerid)
{
	for (new i = 0; i != MAX_INVENTORY; i ++)
	{
	    invData[playerid][i][invExists] = false;
	    invData[playerid][i][invQuantity] = 0;
	}
	for (new i = 0; i != MAX_CONTACTS; i ++)
	{
	    contactData[playerid][i][contactExists] = false;
	    contactData[playerid][i][contactID] = 0;
	    contactData[playerid][i][contactNumber] = 0;
	    ListedContacts[playerid][i] = -1;
	}
	playerData[playerid][pRegisterDate][0] = EOS;
	playerData[playerid][pGender] = 0;
	playerData[playerid][pAge] = 0;
	playerData[playerid][pAdmin] = 0;
	playerData[playerid][pKills] = 0;
	playerData[playerid][pDeaths] = 0;
	playerData[playerid][pMoney] = 0;
	playerData[playerid][pBankMoney] = 0;
	playerData[playerid][pRedMoney] = 0;
	playerData[playerid][pLevel] = 0;
	playerData[playerid][pExp] = 0;
	playerData[playerid][pMinutes] = 0;
	playerData[playerid][pHours] = 0;
	playerData[playerid][pPos_X] = 0.000;
	playerData[playerid][pPos_Y] = 0.000;
	playerData[playerid][pPos_Z] = 0.000;
	playerData[playerid][pPos_A] = 0.000;
	playerData[playerid][pSkin] = 0;
	playerData[playerid][pSkins] = 0;
	playerData[playerid][pSkinFaction] = 0;
	playerData[playerid][pInterior] = 0;
	playerData[playerid][pWorld] = 0;
	playerData[playerid][pTutorial] = 0;
	playerData[playerid][pSpawnPoint] = 0;

	playerData[playerid][pThirsty] = 0;
	playerData[playerid][pHungry] = 0;
	playerData[playerid][pSleep] = 0;
	playerData[playerid][pBath] = 0;

	PlayerSaveTime[playerid] = 0;

	playerData[playerid][pPayMoneyID] = INVALID_PLAYER_ID;

	playerData[playerid][pHealth] = 0.0;
	playerData[playerid][pInjured] = 0;
	playerData[playerid][pInjuredTime] = 0;

	playerData[playerid][pHospital] = -1;

	playerData[playerid][IsLoggedIn] = false;
	playerData[playerid][LoginAttempts] = 0;
	playerData[playerid][LoginTimer] = 0;
	playerData[playerid][INV] = 0;

	playerData[playerid][pFactionOffer] = INVALID_PLAYER_ID;
	playerData[playerid][pFactionOffered] = -1;
	playerData[playerid][pFaction] = -1;
	playerData[playerid][pFactionID] = -1;
	playerData[playerid][pFactionRank] = 0;
	playerData[playerid][pFactionEdit] = -1;
	playerData[playerid][pSelectedSlot] = -1;

	playerData[playerid][pDisableFaction] = 0;
	playerData[playerid][pArmorOn] = false;
	playerData[playerid][pCuffed] = 0;

	playerData[playerid][pSelectTD] = 0;

	playerData[playerid][pPrisoned] = 0;
	playerData[playerid][pPrisonOut] = 0;
	playerData[playerid][pJailTime] = 0;

	playerData[playerid][pEntrance] = -1;

	playerData[playerid][pCarSeller] = INVALID_PLAYER_ID;
	playerData[playerid][pCarOffered] = -1;
	playerData[playerid][pCarValue] = 0;

	playerData[playerid][pMaxItem] = 8;
	playerData[playerid][pItemAmount] = 20;
	playerData[playerid][pItemSelect] = 0;
	playerData[playerid][pInventoryPage] = 0;
	playerData[playerid][pItemOfferID] = INVALID_PLAYER_ID;

	playerData[playerid][pMecOfferID] = INVALID_PLAYER_ID;
	playerData[playerid][pMecOfferPrice] = 0;

	playerData[playerid][pMedicOfferID] = INVALID_PLAYER_ID;
	playerData[playerid][pMedicOfferPrice] = 0;

	playerData[playerid][pRoadblock] = -1;

	playerData[playerid][pPhone] = 0;
	playerData[playerid][pPhoneOff] = 0;

	playerData[playerid][pIncomingCalling] = 0;
	playerData[playerid][pIncomingCall] = 0;
	playerData[playerid][pCallLine] = INVALID_PLAYER_ID;

	playerData[playerid][pEmergency] = 0;
//	playerData[playerid][pPlaceAd] = 0;

	playerData[playerid][pMarker] = 0;

	playerData[playerid][pWanted] = 0;
	playerData[playerid][pWantedTime] = 0;

	playerData[playerid][pTransfer] = INVALID_PLAYER_ID;

	playerData[playerid][pColor1] = -1;
	playerData[playerid][pColor2] = -1;

	playerData[playerid][pPaintjob] = -1;

	playerData[playerid][pDrivingTest] = 0;
	playerData[playerid][pTestStage] = 0;
	playerData[playerid][pTestWarns] = 0;

	playerData[playerid][pEventBackX] = 0.000;
	playerData[playerid][pEventBackY] = 0.000;
	playerData[playerid][pEventBackZ] = 0.000;

	playerData[playerid][pEventBackInterior] = 0;
	playerData[playerid][pEventBackWorld] = 0;
	playerData[playerid][pEventGo] = 0;

	playerData[playerid][pOOCSpam] = 0;

	playerData[playerid][pVip] = 0;

	playerData[playerid][pQuest] = 0;
	playerData[playerid][pQuestProgress] = 0;

	playerData[playerid][pWarn] = 0;
	playerData[playerid][pBan] = 0;
	playerData[playerid][pBanReason][0] = EOS;

	playerData[playerid][pVehicleKeys] = INVALID_VEHICLE_ID;

	playerData[playerid][pTazer] = 0;
	playerData[playerid][pStunned] = 0;

	playerData[playerid][pPVP] = 0;
	playerData[playerid][pPVPFreeze] = 0;
	playerData[playerid][pHelmetOn] = false;

	playerData[playerid][pWorkOn] = INVALID_STREAMER_ID;

	playerData[playerid][pStorageSelect] = 0;
	playerData[playerid][pStorageItem] = 0;

	playerData[playerid][pStrain] = 0;
	playerData[playerid][pArmour] = 0.0;

	
	playerData[playerid][pSpaceOn] = false;

	playerData[playerid][pMorganPit] = false;
	playerData[playerid][pMorganSuit] = false;

	// ค่าปรับ
	fineID[playerid] = -1;
	finePrice[playerid] = 0;
	format(fineText[playerid], 64, "(null)");

	// ปืนช็อตไฟฟ้า
	TazerCooldown[playerid] = 0;
	playerData[playerid][pOnSpectator] = 0;

	EmeraldOn[playerid] = false;

	playerData[playerid][pAdminID] = INVALID_PLAYER_ID;
	playerData[playerid][pBusinessID] = INVALID_PLAYER_ID;
	playerData[playerid][pAnimationID] = INVALID_PLAYER_ID;
	playerData[playerid][pFactionMenuID] = INVALID_PLAYER_ID;


/* ---------------------------------------- New Hugo ---------------------------------------- */
	playerData[playerid][pOnDuty] = 0;
	playerData[playerid][pPowder] = 0;
	playerData[playerid][pPowderMax] = 0;
	playerData[playerid][pEquipmentJob] = 0;
	playerData[playerid][pJobs] = 0;
	playerData[playerid][pColor] = 0;
}

ResetPlayerDeath(playerid)
{
	if (playerData[playerid][pDrivingTest])
	    DestroyVehicle(playerData[playerid][pTestCar]);

    playerData[playerid][pDrivingTest] = 0;
}

ResetPlayerDisconnection(playerid)
{
	if (playerData[playerid][pDragged])
	    KillTimer(playerData[playerid][pDragTimer]);

	if (playerData[playerid][pDrivingTest])
	    DestroyVehicle(playerData[playerid][pTestCar]);

	if (playerData[playerid][pExpShow])
	    KillTimer(playerData[playerid][pExpTimer]);

	if (playerData[playerid][pWorkOn] != INVALID_STREAMER_ID)
	    playerData[playerid][pWorkOn] = INVALID_STREAMER_ID;

	foreach (new i : Player)
	{
		if (playerData[i][pFactionOffer] == playerid)
		{
		    playerData[i][pFactionOffer] = INVALID_PLAYER_ID;
		    playerData[i][pFactionOffered] = -1;
		}
		if (playerData[i][pDraggedBy] == playerid)
		{
		    KillTimer(playerData[i][pDragTimer]);

		    playerData[i][pDragged] = 0;
            playerData[i][pDraggedBy] = INVALID_PLAYER_ID;
		}
		if (playerData[i][pCarSeller] == playerid)
		{
		    playerData[i][pCarSeller] = INVALID_PLAYER_ID;
		    playerData[i][pCarOffered] = -1;
		}
		if (playerData[i][pMecOfferID] == playerid)
		{
		    playerData[i][pMecOfferID] = INVALID_PLAYER_ID;
		    playerData[i][pMecOfferPrice] = 0;
		}
		if (playerData[i][pMedicOfferID] == playerid)
		{
			playerData[playerid][pMedicOfferID] = INVALID_PLAYER_ID;
			playerData[playerid][pMedicOfferPrice] = 0;
		}
	}
}


/*
ResetPlayerWantedLevelEx(playerid)
{
	SetPlayerWantedLevel(playerid, 0);
	playerData[playerid][pWanted] = 0;
	playerData[playerid][pWantedTime] = 0;
	return 1;
}*/

GivePlayerWanted(playerid, level)
{
	SetPlayerWantedLevel(playerid, GetPlayerWantedLevelEx(playerid)+level);
	playerData[playerid][pWanted] += level;
	return 1;
}

GetPlayerWantedLevelEx(playerid)
{
	return (playerData[playerid][pWanted]);
}


public OnPlayerText(playerid, text[])
{
	if ((!playerData[playerid][IsLoggedIn]) || playerData[playerid][pHospital] != -1)
	    return 0;

	new
		targetid = playerData[playerid][pCallLine];

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

    if (!IsPlayerOnPhone(playerid))
	{
		if(playerData[playerid][pInjured] > 0)
		{
			SendNearbyMessage(playerid, 10.0, COLOR_LIGHTRED, "%s (บาดเจ็บ)พูดว่า: %s", GetPlayerNameEx(playerid), text);
			return 0; 
		}
		
		SendNearbyMessage(playerid, 10.0, COLOR_WHITE, "%s พูดว่า: %s", GetPlayerNameEx(playerid), text);
	}
	else SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "(โทรศัพท์) %s พูดว่า: %s", GetPlayerNameEx(playerid), text);

	if (!IsPlayerInAnyVehicle(playerid) && !playerData[playerid][pInjured] && !IsPlayerOnPhone(playerid))
	{
	    SetPlayerChatBubble(playerid, text, COLOR_GREY, 5.0, 10000);
		ApplyAnimation(playerid, "GANGS", "prtial_gngtlkA", 4.1, 0, 1, 1, 0, strlen(text) * 100, 1);
		SetTimerEx("StopChatting", strlen(text) * 100, false, "d", playerid);
	}
	/*switch (playerData[playerid][pEmergency])
	{
		case 1:
		{
			if (!strcmp(text, "ตำรวจ", true))
			{
			    playerData[playerid][pEmergency] = 2;
			    SendClientMessage(playerid, COLOR_LIGHTBLUE, "[พนักงาน]:{FFFFFF} สายถูกโอนไปที่สถานีตำรวจ		 โปรดระบุเหตุฉุกเฉินของคุณ");
			}
			else if (!strcmp(text, "หมอ", true))
			{
			    playerData[playerid][pEmergency] = 3;
			    SendClientMessage(playerid, COLOR_HOSPITAL, "[พนักงาน]:{FFFFFF} สายถูกโอนไปที่โรงพยาบาล โปรดระบุเหตุฉุกเฉินของคุณ");
			}
			else SendClientMessage(playerid, COLOR_LIGHTBLUE, "[พนักงาน]:{FFFFFF} ขออภัย, เราไม่เข้าใจที่คุณสื่อสาร \"ตำรวจ\" หรือ \"หมอ\"?");
		}
		case 2:
		{
			SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "911 CALL: %s พิกัด (%.4f, %.4f, %.4f)", GetPlayerNameEx(playerid), x, y, z);
    		SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "เหตุฉุกเฉิน: %s", text);

		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "[พนักงาน]:{FFFFFF} เราได้แจ้งทุกหน่วยในพื้นที่แล้ว ขอบคุณในการแจ้ง");
		    callcmd::hangup(playerid, "\1");

		    SetFactionMarkerEx(playerid, FACTION_POLICE, x, y, z);
		}
		case 3:
		{
		    SendFactionMessageEx(FACTION_MEDIC, COLOR_HOSPITAL, "911 CALL: %s พิกัด (%.4f, %.4f, %.4f)", GetPlayerNameEx(playerid), x, y, z);
   			SendFactionMessageEx(FACTION_MEDIC, COLOR_HOSPITAL, "เหตุฉุกเฉิน: %s", text);

		    SendClientMessage(playerid, COLOR_HOSPITAL, "[พนักงาน]:{FFFFFF} เราได้แจ้งทุกหน่วยในพื้นที่แล้ว ขอบคุณในการแจ้ง");
		    callcmd::hangup(playerid, "\1");

		    SetFactionMarkerEx(playerid, FACTION_MEDIC, x, y, z);
		}
	}*/
	if (targetid != INVALID_PLAYER_ID && !playerData[playerid][pIncomingCall])
	{
		SendClientMessageEx(targetid, COLOR_YELLOW, "(โทรศัพท์) %s พูดว่า: %s", GetPlayerNameEx(playerid), text);
	}
	return 0;
}


forward StopChatting(playerid);
public StopChatting(playerid)
{
    //ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
}
forward OnLoginTimeout(playerid);
public OnLoginTimeout(playerid)
{
	playerData[playerid][LoginTimer] = 0;
	SendClientMessage(playerid, COLOR_RED, "- เวลาล็อคอินของคุณหมดลงแล้ว 60 วินาที ระบบจึงเตะคุณออกจากเกม");
	SendClientMessage(playerid, COLOR_RED, "- ใช้คำสั่ง (/q) เพื่อออกจากหน้าต่างเกม");
	DelayedKick(playerid);
	return 1;
}

forward OnPlayerRegister(playerid);
public OnPlayerRegister(playerid)
{
	playerData[playerid][pID] = cache_insert_id();
	ShowDialog_Login(playerid);
	playerData[playerid][LoginTimer] = SetTimerEx("OnLoginTimeout", SECONDS_TO_LOGIN * 1000, false, "d", playerid);
	return 1;
}

forward _KickPlayerDelayed(playerid);
public _KickPlayerDelayed(playerid)
{
	Kick(playerid);
	return 1;
}

AssignplayerData(playerid)
{
	cache_get_value_name_int(0, "playerID", playerData[playerid][pID]);

    cache_get_value_name(0, "playerRegDate", playerData[playerid][pRegisterDate], 90);
	cache_get_value_name_int(0, "playerGender", playerData[playerid][pGender]);
	cache_get_value_name_int(0, "playerAge", playerData[playerid][pAge]);

	cache_get_value_name_int(0, "playerAdmin", playerData[playerid][pAdmin]);

	cache_get_value_name_int(0, "playerKills", playerData[playerid][pKills]);
	cache_get_value_name_int(0, "playerDeaths", playerData[playerid][pDeaths]);
	cache_get_value_name_int(0, "playerMoney", playerData[playerid][pMoney]);
	cache_get_value_name_int(0, "playerBank", playerData[playerid][pBankMoney]);
	cache_get_value_name_int(0, "playerRedMoney", playerData[playerid][pRedMoney]);
	cache_get_value_name_int(0, "playerLevel", playerData[playerid][pLevel]);
	cache_get_value_name_int(0, "playerExp", playerData[playerid][pExp]);
	cache_get_value_name_int(0, "playerMinutes", playerData[playerid][pMinutes]);
	cache_get_value_name_int(0, "playerHours", playerData[playerid][pHours]);

	cache_get_value_name_float(0, "playerPosX", playerData[playerid][pPos_X]);
	cache_get_value_name_float(0, "playerPosY", playerData[playerid][pPos_Y]);
	cache_get_value_name_float(0, "playerPosZ", playerData[playerid][pPos_Z]);
	cache_get_value_name_float(0, "playerPosA", playerData[playerid][pPos_A]);
	cache_get_value_name_int(0, "playerSkin", playerData[playerid][pSkin]);
	cache_get_value_name_int(0, "playerSkins", playerData[playerid][pSkins]);
	cache_get_value_name_int(0, "playerSkinFaction", playerData[playerid][pSkinFaction]);
	cache_get_value_name_int(0, "playerInterior", playerData[playerid][pInterior]);
	cache_get_value_name_int(0, "playerTutorial", playerData[playerid][pTutorial]);
	cache_get_value_name_int(0, "playerWorld", playerData[playerid][pWorld]);
	cache_get_value_name_int(0, "playerSpawn", playerData[playerid][pSpawnPoint]);

	cache_get_value_name_float(0, "playerThirsty", playerData[playerid][pThirsty]);
	cache_get_value_name_float(0, "playerHungry", playerData[playerid][pHungry]);

	cache_get_value_name_float(0, "playerHealth", playerData[playerid][pHealth]);
	cache_get_value_name_int(0, "playerInjured", playerData[playerid][pInjured]);
	cache_get_value_name_int(0, "playerInjuredTime", playerData[playerid][pInjuredTime]);

    cache_get_value_name_int(0, "playerFaction", playerData[playerid][pFactionID]);
    cache_get_value_name_int(0, "playerFactionRank", playerData[playerid][pFactionRank]);

    cache_get_value_name_int(0, "playerPrisoned", playerData[playerid][pPrisoned]);
    cache_get_value_name_int(0, "playerPrisonOut", playerData[playerid][pPrisonOut]);
    cache_get_value_name_int(0, "playerJailTime", playerData[playerid][pJailTime]);

    cache_get_value_name_int(0, "playerEntrance", playerData[playerid][pEntrance]);

    cache_get_value_name_int(0, "playerMaxItem", playerData[playerid][pMaxItem]);
    cache_get_value_name_int(0, "playerItemAmount", playerData[playerid][pItemAmount]);
    cache_get_value_name_int(0, "playerPhone", playerData[playerid][pPhone]);

    cache_get_value_name_int(0, "playerVIP", playerData[playerid][pVip]);

	cache_get_value_name_int(0, "playerQuest", playerData[playerid][pQuest]);
	cache_get_value_name_int(0, "playerQuestProgress", playerData[playerid][pQuestProgress]);

	cache_get_value_name_int(0, "playerWarn", playerData[playerid][pWarn]);
	cache_get_value_name_int(0, "playerBan", playerData[playerid][pBan]);
	cache_get_value_name(0, "playerBanReason", playerData[playerid][pBanReason], 128);

	cache_get_value_name_int(0, "playerWhitelist", playerData[playerid][pWhitelist]);
	cache_get_value_name_int(0, "playerCoin", playerData[playerid][pCoin]);
	cache_get_value_name_int(0, "playerColor", playerData[playerid][pColor]);

	cache_get_value_name_int(0, "playerSleep", playerData[playerid][pSleep]);
	cache_get_value_name_int(0, "playerBath", playerData[playerid][pBath]);


	cache_get_value_name_int(0, "Animation", playerData[playerid][pAnimation]);

	cache_get_value_name_int(0, "playerStrain", playerData[playerid][pStrain]);
	cache_get_value_name_int(0, "playerOnDuty", playerData[playerid][pOnDuty]);
	cache_get_value_name_int(0, "playerPowder", playerData[playerid][pPowder]);
	cache_get_value_name_int(0, "playerPowderMax", playerData[playerid][pPowderMax]);

	if (playerData[playerid][pFactionID] != -1) {
	    playerData[playerid][pFaction] = GetFactionByID(playerData[playerid][pFactionID]);

	    if (playerData[playerid][pFaction] == -1) {
	        ResetFaction(playerid);
		}
	}

	if(!playerData[playerid][pSkin])
	{
		switch(playerData[playerid][pGender])
		{
			case 1: playerData[playerid][pSkin] = 289;
			case 2: playerData[playerid][pSkin] = 191;
		}
	}

	for(new i = 1; i < MAX_VEHICLES; i ++)
	{
		if(IsValidVehicle(i) && IsVehicleOwner(playerid, i) && carData[i][carTimer] >= 0)
		{
			KillTimer(carData[i][carTimer]);
			carData[i][carTimer] = -1;
		}
	}


    new query[256];
    mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `inventory` WHERE `invOwner` = '%d'", playerData[playerid][pID]);
	mysql_tquery(g_SQL, query, "Inventory_Load", "d", playerid);

    mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `contacts` WHERE `ID` = '%d'", playerData[playerid][pID]);
	mysql_tquery(g_SQL, query, "Contact_Load", "d", playerid);

	PlayerSaveTime[playerid] = 1;
	return 1;
}

forward KickTimePlayer(playerid);
public KickTimePlayer(playerid){
	Kick(playerid);
	return 1;
}



DelayedKick(playerid, time = 500)
{
	Dialog_Show(playerid, DIALOG_EXIT, DIALOG_STYLE_MSGBOX, "Exit", "คุณได้ออกจากระบบเรียบร้อย \n{FFA84D}*(/q) เพื่อออกจากเกม", "ปิด", "");
	SetTimerEx("_KickPlayerDelayed", time, false, "d", playerid);
	return 1;
}

UpdateplayerData(playerid)
{
	if (playerData[playerid][IsLoggedIn] == false) return 0;

/*	if (reason == 1)
	{
		GetPlayerPos(playerid, playerData[playerid][pPos_X], playerData[playerid][pPos_Y], playerData[playerid][pPos_Z]);
		GetPlayerFacingAngle(playerid, playerData[playerid][pPos_A]);
	}*/
	/*if (!playerData[playerid][pDrivingTest])
	{
	    playerData[playerid][pInterior] = GetPlayerInterior(playerid);
	    playerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);

	    GetPlayerPos(playerid, playerData[playerid][pPos_X], playerData[playerid][pPos_Y], playerData[playerid][pPos_Z]);
	    GetPlayerFacingAngle(playerid, playerData[playerid][pPos_A]);

	    GetPlayerHealth(playerid, playerData[playerid][pHealth]);
	}*/
	if (playerData[playerid][pInjured] == 0)
	    GetPlayerHealth(playerid, playerData[playerid][pHealth]);

	if (IsPlayerSpawnedEx(playerid))
	{
	    playerData[playerid][pInterior] = GetPlayerInterior(playerid);
	    playerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);

	    GetPlayerPos(playerid, playerData[playerid][pPos_X], playerData[playerid][pPos_Y], playerData[playerid][pPos_Z]);
	    GetPlayerFacingAngle(playerid, playerData[playerid][pPos_A]);

	    GetPlayerHealth(playerid, playerData[playerid][pHealth]);
	}
	playerData[playerid][pSkin] = GetPlayerSkin(playerid);

	new query[10008];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `playerAdmin` = %d, `playerMoney`= %d, `playerBank` = %d, \
	`playerRedMoney` = %d, `playerLevel` = %d, `playerExp` = %d, `playerMinutes` = %d, `playerHours` = %d, `playerPosX` = %f, \
	`playerPosY` = %f, `playerPosZ` = %f, `playerPosA` = %f, `playerSkin` = %d, `playerSkins` = %d, `playerSkinFaction` = %d, `playerInterior` = %d, `playerWorld` = %d, \
	`playerThirsty` = %.3f, `playerHungry` = %.3f, `playerHealth` = %.4f, `playerInjured` = %d, `playerInjuredTime` = %d, \
	`playerFaction` = %d, `playerFactionRank` = %d, `playerPrisoned` = %d, `playerPrisonOut` = %d, `playerJailTime` = %d, \
	`playerEntrance` = %d, `playerMaxItem` = %d, `playerItemAmount` = %d, `playerPhone` = %d, `playerVIP` = %d, \
	`playerQuest` = %d, `playerQuestProgress` = %d, `playerWarn` = %d, `playerWhitelist` = %d, `playerCoin` = %d, `playerColor` = %d, `playerSleep` = %d, \
	`playerBath` = %d, `Animation` = %d, `playerStrain` = %d, `playerOnDuty` = %d, `playerPowder` = %d, `playerPowderMax` = %d WHERE `playerID` = %d",
	playerData[playerid][pAdmin],
	playerData[playerid][pMoney],
	playerData[playerid][pBankMoney],
	playerData[playerid][pRedMoney],
	playerData[playerid][pLevel],
	playerData[playerid][pExp],
	playerData[playerid][pMinutes],
	playerData[playerid][pHours],
	playerData[playerid][pPos_X],
	playerData[playerid][pPos_Y],
	playerData[playerid][pPos_Z],
	playerData[playerid][pPos_A],
	playerData[playerid][pSkin],
	playerData[playerid][pSkins],
	playerData[playerid][pSkinFaction],
	playerData[playerid][pInterior],
	playerData[playerid][pWorld],
	playerData[playerid][pThirsty],
	playerData[playerid][pHungry],
	playerData[playerid][pHealth],
	playerData[playerid][pInjured],
	playerData[playerid][pInjuredTime],
	playerData[playerid][pFactionID],
	playerData[playerid][pFactionRank],
	playerData[playerid][pPrisoned],
	playerData[playerid][pPrisonOut],
	playerData[playerid][pJailTime],
	playerData[playerid][pEntrance],
	playerData[playerid][pMaxItem],
	playerData[playerid][pItemAmount],
	playerData[playerid][pPhone],
	playerData[playerid][pVip],
	playerData[playerid][pQuest],
	playerData[playerid][pQuestProgress],
	playerData[playerid][pWarn],
	playerData[playerid][pWhitelist],
	playerData[playerid][pCoin],
	playerData[playerid][pColor],
	playerData[playerid][pSleep],
	playerData[playerid][pBath],
	playerData[playerid][pAnimation],
	playerData[playerid][pStrain],
	playerData[playerid][pOnDuty],
	playerData[playerid][pPowder],
	playerData[playerid][pPowderMax],
	playerData[playerid][pID]);
	mysql_tquery(g_SQL, query);
	return 1;
}



/*UpdatePlayerKills(killerid, deadid)
{
    if (killerid == INVALID_PLAYER_ID) return 0;
    if (playerData[killerid][IsLoggedIn] == false) return 0;
	if (playerData[deadid][pInjured] == 1) return 0;

	playerData[killerid][pKills]++;

	new query[90];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `playerKills` = %d WHERE `playerID` = %d LIMIT 1", playerData[killerid][pKills], playerData[killerid][pID]);
	mysql_tquery(g_SQL, query);
	return 1;
}*/

GetPlayerNameEx(playerid)
{
    new string[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, string, sizeof(string));
    return string;
}

ReturnDate() //น่าสนใจ
{
	new sendString[90], MonthStr[6], month, day, year;
	new hour, minute, second;
	gettime(hour, minute, second);
	getdate(year, month, day);
	switch(month)
	{
	    case 1:  MonthStr = "ม.ค";
	    case 2:  MonthStr = "ก.พ";
	    case 3:  MonthStr = "มี.ค";
	    case 4:  MonthStr = "เม.ย";
	    case 5:  MonthStr = "พ.ค";
	    case 6:  MonthStr = "มิ.ย";
	    case 7:  MonthStr = "ก.ค";
	    case 8:  MonthStr = "ส.ค";
	    case 9:  MonthStr = "ก.ย";
	    case 10: MonthStr = "ต.ค";
	    case 11: MonthStr = "พ.ย";
	    case 12: MonthStr = "ธ.ค";
	}
	format(sendString, sizeof(sendString), "%02d-%02d-%04d %02d:%02d:%02d", day, month, year, hour, minute, second);
	return sendString;
}



ClearPlayerChat(playerid, lines)
{
	for(new i = 0; i <= lines; i++)
	{
	    SendClientMessage(playerid, COLOR_WHITE, "");
	}
	return 1;
}

SendClientMessageEx(playerid, color, const text[], {Float, _}:...)
{
	static
	    args,
	    str[144];

	/*
     *  Custom function that uses #emit to format variables into a string.
     *  This code is very fragile; touching any code here will cause crashing!
	*/
	if ((args = numargs()) == 3)
	{
	    SendClientMessage(playerid, color, text);
	}
	else
	{
		while (--args >= 3)
		{
			#emit LCTRL 5
			#emit LOAD.alt args
			#emit SHL.C.alt 2
			#emit ADD.C 12
			#emit ADD
			#emit LOAD.I
			#emit PUSH.pri
		}
		#emit PUSH.S text
		#emit PUSH.C 144
		#emit PUSH.C str
		#emit PUSH.S 8
		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		SendClientMessage(playerid, color, str);

		#emit RETN
	}
	return 1;
}

SendClientMessageToAllEx(color, const text[], {Float, _}:...)
{
	static
	    args,
	    str[144];

	/*
     *  Custom function that uses #emit to format variables into a string.
     *  This code is very fragile; touching any code here will cause crashing!
	*/
	if ((args = numargs()) == 2)
	{
	    SendClientMessageToAll(color, text);
	}
	else
	{
		while (--args >= 2)
		{
			#emit LCTRL 5
			#emit LOAD.alt args
			#emit SHL.C.alt 2
			#emit ADD.C 12
			#emit ADD
			#emit LOAD.I
			#emit PUSH.pri
		}
		#emit PUSH.S text
		#emit PUSH.C 144
		#emit PUSH.C str
		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri
		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		SendClientMessageToAll(color, str);

		#emit RETN
	}
	return 1;
}



GivePlayerRedMoney(playerid, amount)
{
	playerData[playerid][pRedMoney] += amount;
	PlayerLoadRedMoney(playerid);
	return 1;
}

GetPlayerRedMoney(playerid)
{
	return (playerData[playerid][pRedMoney]);
}

SetPlayerRedMoney(playerid, amount)
{
	playerData[playerid][pRedMoney] = amount;
	PlayerLoadRedMoney(playerid);
	return 1;
}

PlayerLoadRedMoney(playerid)
{
	new redmoney[12];
    format(redmoney, sizeof(redmoney), "%s", FormatNumber(GetPlayerRedMoney(playerid)));
    PlayerTextDrawSetString(playerid, tdredmoney[playerid], redmoney);
    return 1;
}

SetPlayerHour(playerid, amount)
{
	playerData[playerid][pHours] = amount;
	//PlayerLoadStats(playerid);
	return 1;
}

// Anti Money Hack

GivePlayerMoneyEx(playerid, amount) //ได้รับเงิน
{
	PlayerPlaySound(playerid, 31000, 0.0, 0.0, 0.0);
	playerData[playerid][pMoney] += amount;
	GivePlayerMoney(playerid, amount);
	return 1;
}
GivePlayerWelletEx(playerid, amount)
{
	PlayerPlaySound(playerid, 31000, 0.0, 0.0, 0.0);
	playerData[playerid][pCoin] += amount;
	return 1;
}

GetPlayerMoneyEx(playerid)
{
	return (playerData[playerid][pMoney]);
}

SetPlayerMoneyEx(playerid, amount)
{
	ResetPlayerMoney(playerid);
	playerData[playerid][pMoney] = amount;
	GivePlayerMoney(playerid, amount);
	return 1;
}

GivePlayerWeaponEx(playerid, weaponid, ammo)
{
    if(!weaponid) return 0;

    gPlayerWeaponData[playerid][weaponid] = true;
    return GivePlayerWeapon(playerid, weaponid, ammo);
}

ResetPlayerWeaponsEx(playerid)
{
    for(new weaponid; weaponid < 46; weaponid++)
    gPlayerWeaponData[playerid][weaponid] = false;
    return ResetPlayerWeapons(playerid);
}

/*RemovePlayerWeapon(playerid, weaponid)
{
    new plyWeapons[12], plyAmmo[12];

    for(new slot; slot != 12; slot ++)
    {
        new weap, ammo;

        GetPlayerWeaponData(playerid, slot, weap, ammo);
        if(weap != weaponid)
        {
            GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
        }
    }

    ResetPlayerWeaponsEx(playerid);

    for(new slot; slot != 12; slot ++)
    {
        GivePlayerWeaponEx(playerid, plyWeapons[slot], plyAmmo[slot]);
    }
}*/

FormatMoney(number, const prefix[] = "$")
{
	static
		value[32],
		length;

	format(value, sizeof(value), "%d", (number < 0) ? (-number) : (number));

	if ((length = strlen(value)) > 3)
	{
		for (new i = length, l = 0; --i >= 0; l ++)
		{
		    if ((l > 0) && (l % 3 == 0)) strins(value, ",", i + 1);
		}
	}
	if (prefix[0] != 0)
	    strins(value, prefix, 0);

	if (number < 0)
		strins(value, "-", 0);

	return value;
}

FormatNumber(number)
{
	static
		value[32],
		length;

	format(value, sizeof(value), "%d", (number < 0) ? (-number) : (number));

	if ((length = strlen(value)) > 3)
	{
		for (new i = length, l = 0; --i >= 0; l ++)
		{
		    if ((l > 0) && (l % 3 == 0)) strins(value, ",", i + 1);
		}
	}
	if (number < 0)
		strins(value, "-", 0);

	return value;
}

FormatNumberPhone(number)
{
	static
		value[32],
		length;

	format(value, sizeof(value), "%d", (number < 0) ? (-number) : (number));

	if ((length = strlen(value)) > 3)
	{
		for (new i = length, l = 0; --i >= 0; l ++)
		{
		    if ((l > 0) && (l % 3 == 0)) strins(value, "-", i + 1);
		}
	}
	if (number < 0)
		strins(value, "-", 0);

	return value;
}





/*
ShowDialog_Tutorial(playerid)
{
	new string[256];
	static const aGender[3][10] = {"แก้ไข", "ชาย", "หญิง"};
	format(string, sizeof(string), "\
		ลำดับไอดี:\t{00FF00}%d\n\
		วันที่ลงทะเบียน:\t{00FF00}%s\n\
		ชื่อ:\t{00FF00}%s\n\
		เพศ:\t{00FF00}%s\n\
		วันเดือนปีเกิด:\t{00FF00}%s\n\
		{FFFF00}>> เสร็จสิ้น",
	playerData[playerid][pID], playerData[playerid][pRegisterDate], GetPlayerNameEx(playerid), aGender[playerData[playerid][pGender]], playerData[playerid][pBirthday]);
	Dialog_Show(playerid, DIALOG_TUTORIAL, DIALOG_STYLE_TABLIST, "[ข้อมูลตัวละคร]", string, "เลือก", "ออกเกม");
	return 1;
}
*/


GetNearestVehicle(playerid)
{
	static
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	for (new i = 1; i != MAX_VEHICLES; i ++) if (IsValidVehicle(i) && GetVehiclePos(i, fX, fY, fZ))
	{
	    if (IsPlayerInRangeOfPoint(playerid, 5.0, fX, fY, fZ)) return i;
	}
	return INVALID_VEHICLE_ID;
}

ReturnVehicleName(vehicleid)
{
	new
		model = GetVehicleModel(vehicleid),
		name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}

IsWindowsVehicle(vehicleid)
{
    static const vehicleWindows[] = {
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0,
		1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0,
		0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1,
		0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,
		1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
		1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1,
		0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
	};

	new
	    model = GetVehicleModel(vehicleid);

	if(400 <= model <= 611)
	{
	    return vehicleWindows[model - 400];
	}

	return 0;
}

IsEngineVehicle(vehicleid)
{
	static const g_aEngineStatus[] = {
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
	};
    new modelid = GetVehicleModel(vehicleid);

    if (modelid < 400 || modelid > 611)
        return 0;

    return (g_aEngineStatus[modelid - 400]);
}

GetEngineStatus(vehicleid)
{
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (engine != 1)
		return 0;

	return 1;
}

SetEngineStatus(vehicleid, status)
{
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, status, lights, alarm, doors, bonnet, boot, objective);
}

SetVehicleParams(vehicleid, param, status)
{
	new
	    params[7];

	GetVehicleParamsEx(vehicleid, params[0], params[1], params[2], params[3], params[4], params[5], params[6]);

	params[param] = status;

	return SetVehicleParamsEx(vehicleid, params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
}

/*SetFactionMarker(playerid, type, color)
{
    foreach (new i : Player) if (GetFactionType(i) == type)
	{
    	SetPlayerMarkerForPlayer(i, playerid, color);
	}
	playerData[playerid][pMarker] = 1;
	SetTimerEx("ExpireMarker", 300000, false, "d", playerid);
	return 1;
}

SetFactionMarkerEx(playerid, type, Float:x, Float:y, Float:z)
{
    foreach (new i : Player) if (GetFactionType(i) == type)
	{
    	SetPlayerCheckpoint(i, x, y, z, 5.0);
	}
	playerData[playerid][pMarker] = 1;
	SetTimerEx("ExpireMarker", 300000, false, "d", playerid);
	return 1;
}
*/
forward ExpireMarker(playerid);
public ExpireMarker(playerid)
{
	if (!playerData[playerid][pMarker])
	    return 0;

	playerData[playerid][pMarker] = 0;
	DisablePlayerCheckpoint(playerid);
	return 1;
}
/*
forward ExpireMarker(playerid);
public ExpireMarker(playerid)
{
	if (!playerData[playerid][pMarker])
	    return 0;

    if (GetFactionType(playerid) == FACTION_GANG || (GetFactionType(playerid) != FACTION_GANG && playerData[playerid][pOnDuty]))
		SetFactionColor(playerid);

	else SetPlayerColor(playerid, DEFAULT_COLOR);
	return 1;
}*/



Faction_GetName(playerid)
{
    new
		factionid = playerData[playerid][pFaction],
		name[32] = "None";

 	if (factionid == -1)
	    return name;

	format(name, 32, factionData[factionid][factionName]);
	return name;
}

Faction_GetRank(playerid)
{
    new
		factionid = playerData[playerid][pFaction],
		rank[32] = "None";

 	if (factionid == -1)
	    return rank;

	format(rank, 32, FactionRanks[factionid][playerData[playerid][pFactionRank] - 1]);
	return rank;
}




forward Inventory_Load(playerid);
public Inventory_Load(playerid)
{
	static
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows && i < MAX_INVENTORY; i ++)
	{
	    invData[playerid][i][invExists] = true;
	    cache_get_value_name_int(i, "invID", invData[playerid][i][invID]);
        cache_get_value_name_int(i, "invQuantity", invData[playerid][i][invQuantity]);

		cache_get_value_name(i, "invItem", invData[playerid][i][invItem], 32);
	}

	return 1;
}

forward Vehicle_Load();
public Vehicle_Load()
{
    static
	    rows,
		count;

	cache_get_row_count(rows);

	new modelid, Float:pos_x, Float:pos_y, Float:pos_z, Float:pos_a, color1, color2, vehicleid;

	for(new i = 0; i < rows; i ++)
	{
		cache_get_value_name_int(i, "carModel", modelid);
		cache_get_value_name_float(i, "carPosX", pos_x);
		cache_get_value_name_float(i, "carPosY", pos_y);
		cache_get_value_name_float(i, "carPosZ", pos_z);
		cache_get_value_name_float(i, "carPosA", pos_a);
		cache_get_value_name_int(i, "carColor1", color1);
		cache_get_value_name_int(i, "carColor2", color2);
		vehicleid = CreateVehicle(modelid, pos_x, pos_y, pos_z, pos_a, color1, color2, -1);
		count++;

		if(vehicleid != INVALID_VEHICLE_ID)
		{
			cache_get_value_name_int(i, "carID", carData[vehicleid][carID]);
			cache_get_value_name_int(i, "carFaction", carData[vehicleid][carFaction]);
			cache_get_value_name_float(i, "carHealth", carData[vehicleid][carHealth]);

			if(carData[vehicleid][carFaction] >= 0)
			{
				cache_get_value_name_int(i, "carPrice", carData[vehicleid][carPrice]);
				cache_get_value_name_int(i, "carType", carData[vehicleid][carType]);
				cache_get_value_name_int(i, "carLocked", carData[vehicleid][carLocked]);
				cache_get_value_name_int(i, "carPaintjob", carData[vehicleid][carPaintjob]);
				cache_get_value_name_int(i, "carInterior", carData[vehicleid][carInterior]);
				cache_get_value_name_int(i, "carWorld", carData[vehicleid][carWorld]);
				cache_get_value_name_int(i, "carMod1", carData[vehicleid][carMods][0]);
				cache_get_value_name_int(i, "carMod2", carData[vehicleid][carMods][1]);
				cache_get_value_name_int(i, "carMod3", carData[vehicleid][carMods][2]);
				cache_get_value_name_int(i, "carMod4", carData[vehicleid][carMods][3]);
				cache_get_value_name_int(i, "carMod5", carData[vehicleid][carMods][4]);
				cache_get_value_name_int(i, "carMod6", carData[vehicleid][carMods][5]);
				cache_get_value_name_int(i, "carMod7", carData[vehicleid][carMods][6]);
				cache_get_value_name_int(i, "carMod8", carData[vehicleid][carMods][7]);
				cache_get_value_name_int(i, "carMod9", carData[vehicleid][carMods][8]);
				cache_get_value_name_int(i, "carMod10", carData[vehicleid][carMods][9]);
				cache_get_value_name_int(i, "carMod11", carData[vehicleid][carMods][10]);
				cache_get_value_name_int(i, "carMod12", carData[vehicleid][carMods][11]);
				cache_get_value_name_int(i, "carMod13", carData[vehicleid][carMods][12]);
				cache_get_value_name_int(i, "carMod14", carData[vehicleid][carMods][13]);
				cache_get_value_name_int(i, "carTune", carData[vehicleid][carTune]);
				ReloadVehicle(vehicleid);
			}

			carData[vehicleid][carModel] = modelid;
			carData[vehicleid][carPosX] = pos_x;
			carData[vehicleid][carPosY] = pos_y;
			carData[vehicleid][carPosZ] = pos_z;
			carData[vehicleid][carPosA] = pos_a;
			carData[vehicleid][carColor1] = color1;
			carData[vehicleid][carColor2] = color2;
			carData[vehicleid][carObjects][0] = INVALID_OBJECT_ID;
			carData[vehicleid][carObjects][1] = INVALID_OBJECT_ID;
			carData[vehicleid][carTimer] = -1;
			vehicleFuel[vehicleid] = vehicleData[modelid - 400][vFuel];

			if (carData[vehicleid][carHealth] < 350)
				SetVehicleHealth(vehicleid, 350);
			else
			    SetVehicleHealth(vehicleid, carData[vehicleid][carHealth]);
		}
	}
	printf("[SERVER]: %d Vehicles were loaded from \"%s\" database...", count, MYSQL_DATABASE);
	return 1;
}

/*Float:ManmyGetVehicleSpeed(vehicleid)
{
    new Float:vx, Float:vy, Float:vz;
    GetVehicleVelocity(vehicleid, vx, vy, vz);
	new Float:vel = floatmul(floatsqroot(floatadd(floatadd(floatpower(vx, 2), floatpower(vy, 2)),  floatpower(vz, 2))), 181.5);
	return vel;
}*/

forward OnCheatDetected(playerid, ip_address[], type, code);
/*public OnCheatDetected(playerid, ip_address[], type, code)
{
    new vehicleid = GetPlayerVehicleID(playerid);
    new Float:returnspeed = ManmyGetVehicleSpeed(vehicleid);
	new speeds = floatround(returnspeed);

    if (playerData[playerid][pAdmin] == 0)
	{
		new string[128], hacking[64], Float:extrafloat;
		switch(code)
		{
			case 0: format(hacking, sizeof(hacking), "โปรตัวลอย");//AirBreak (onfoot)
			case 1: format(hacking, sizeof(hacking), "โปรรถลอย");//AirBreak (in vehicle)
			case 2: format(hacking, sizeof(hacking), "โปรวาป");//teleport hack (onfoot)
			case 3: format(hacking, sizeof(hacking), "โปรรถวาป");//teleport hack (in vehicle)
			case 4: format(hacking, sizeof(hacking), "โปรวาปรถ");//teleport hack (into vehicles)
			case 5: {
				format(hacking, sizeof(hacking), "โปรวาปรถ(ดึงรถ)");//teleport hack (vehicle to player)
				SendClientMessageToAllEx(COLOR_LIGHTRED, "{FF0000}[{FFFF00}AGGUARD{FF0000}] {FFFF00}%s ถูกเตะออกจากเซิฟเวอร์ |>{00FFFF}  %s", GetPlayerNameEx(playerid), hacking);
				SendClientMessageEx(playerid, COLOR_WHITE, "วันที่โดนเตะ: %s", ReturnDate());
				SendClientMessageEx(playerid, COLOR_WHITE, "[!] กรุณาลบโปรแกรมช่วยเล่นออก ก่อนจะโดนแบนถาวร!");
				DelayedKick(playerid);
			}
			case 6: format(hacking, sizeof(hacking), "โปรวาป (pickups)");//teleport hack (pickups)
			case 7: format(hacking, sizeof(hacking), "โปรบิน");//FlyHack (onfoot)
			case 8: format(hacking, sizeof(hacking), "โปรรถบิน");//FlyHack (in vehicle)
			case 9: {
				format(hacking, sizeof(hacking), "โปรความเร็วผู้เล่น");//SpeedHack (onfoot)
				SendClientMessageToAllEx(COLOR_LIGHTRED, "{FF0000}[{FFFF00}AGGUARD{FF0000}] {FFFF00}%s ถูกเตะออกจากเซิฟเวอร์ |>{00FFFF}  %s", GetPlayerNameEx(playerid), hacking);
				SendClientMessageEx(playerid, COLOR_WHITE, "วันที่โดนเตะ: %s", ReturnDate());
				SendClientMessageEx(playerid, COLOR_WHITE, "[!] กรุณาลบโปรแกรมช่วยเล่นออก ก่อนจะโดนแบนถาวร!");
				DelayedKick(playerid);
			}
			case 10: {
				format(hacking, sizeof(hacking), "โปรความเร็วรถ ความเร็ว %d (Default 257)", speeds);//SpeedHack (in vehicle)
			}
			case 11: {
				format(hacking, sizeof(hacking), "โปรซ่อมรถ");//Health hack (in vehicle)

				new as1, as2, as3, as4;
				//AntiCheatGetVehicleHealth(vehicleid, extrafloat);
				SetVehicleHealth(vehicleid, extrafloat);
				//SetVehicleDamage(vehicleid);

				//AntiCheatGetVehicleDamage(vehicleid, as1, as2, as3, as4);
				UpdateVehicleDamageStatus(vehicleid, as1, as2, as3, as4);
			}
			case 12: {
				format(hacking, sizeof(hacking), "โปรเพิ่มเลือด");//Health hack (onfoot)

				//AntiCheatGetHealth(playerid, extrafloat);
				SetPlayerHealth(playerid, extrafloat);
			}
			case 13: {
				format(hacking, sizeof(hacking), "โปรเพิ่มเกราะ");//Armour hack

				//AntiCheatGetArmour(playerid, extrafloat);
				SetPlayerArmour(playerid, extrafloat);
			}
			case 14: format(hacking, sizeof(hacking), "โปรเสกเงิน");//Money hack
			case 15: {

				if (GetFactionType(playerid) == FACTION_POLICE)
					return 1;

				format(hacking, sizeof(hacking), "โปรเสกอาวุธ");//Weapon hack
				//SendClientMessageToAllEx(COLOR_LIGHTRED, "{FF0000}[{FFFF00}AGGUARD{FF0000}] {FFFF00}%s ถูกเตะออกจากเซิฟเวอร์ |>{00FFFF}  %s", GetPlayerNameEx(playerid), hacking);
				//SendClientMessageEx(playerid, COLOR_WHITE, "วันที่โดนเตะ: %s", ReturnDate());
				//SendClientMessageEx(playerid, COLOR_WHITE, "[!] กรุณาลบโปรแกรมช่วยเล่นออก ก่อนจะโดนแบนถาวร!");
				//DelayedKick(playerid);
			}
			case 16: format(hacking, sizeof(hacking), "Ammo hack (แฮคกระสุน)");
			case 17: format(hacking, sizeof(hacking), "Ammo hack (ล็อคกระสุน)");
			case 18: format(hacking, sizeof(hacking), "Special actions hack");
			case 19: format(hacking, sizeof(hacking), "GodMode from bullets (ล็อคเลือด)");
			case 20: format(hacking, sizeof(hacking), "GodMode from bullets (ล็อคเลือดรถ)");
			case 21: format(hacking, sizeof(hacking), "Invisible hack");
			case 22: format(hacking, sizeof(hacking), "lagcomp-spoof");
			case 23: format(hacking, sizeof(hacking), "Tuning hack");
			case 24: format(hacking, sizeof(hacking), "Parkour mod");
			case 25: format(hacking, sizeof(hacking), "Quick turn");
			case 26: format(hacking, sizeof(hacking), "Rapid fire");
			case 27: format(hacking, sizeof(hacking), "FakeSpawn");
			case 28: format(hacking, sizeof(hacking), "FakeKill");
			case 29: format(hacking, sizeof(hacking), "Pro Aim");
			//case 30: format(hacking, sizeof(hacking), "CJ run");
			case 31: {
				format(hacking, sizeof(hacking), "CarShot");
				SendClientMessageToAllEx(COLOR_LIGHTRED, "{FF0000}[{FFFF00}AGGUARD{FF0000}] {FFFF00}%s ถูกเตะออกจากเซิฟเวอร์ |>{00FFFF}  %s", GetPlayerNameEx(playerid), hacking);
				SendClientMessageEx(playerid, COLOR_WHITE, "วันที่โดนเตะ: %s", ReturnDate());
				SendClientMessageEx(playerid, COLOR_WHITE, "[!] กรุณาลบโปรแกรมช่วยเล่นออก ก่อนจะโดนแบถาวร!");
				DelayedKick(playerid);
			}
			case 32: format(hacking, sizeof(hacking), "CarJack");
			case 33: format(hacking, sizeof(hacking), "UnFreeze");
			case 34: format(hacking, sizeof(hacking), "AFK Ghost");
			case 35: format(hacking, sizeof(hacking), "Full Aiming");
			case 36: format(hacking, sizeof(hacking), "Fake NPC");
			case 37: format(hacking, sizeof(hacking), "Reconnect");
			case 38: format(hacking, sizeof(hacking), "High ping");
			case 39: format(hacking, sizeof(hacking), "Dialog hack");
			case 40: {
				format(hacking, sizeof(hacking), "เข้าข่ายไอพีวงเดียวกัน");
				//SendClientMessageToAllEx(COLOR_LIGHTRED, "{FF0000}[{FFFF00}AGGUARD{FF0000}] {FFFF00}%s ถูกเตะออกจากเซิฟเวอร์ |>{00FFFF}  ไอพีวงเดียวกัน", GetPlayerNameEx(playerid));
				//SendClientMessageEx(playerid, COLOR_WHITE, "วันที่โดนเตะ: %s", ReturnDate());
				//SendClientMessageEx(playerid, COLOR_WHITE, "[!] อย่าเล่น 2 เครื่องพร้อมกันสิ!");
				//DelayedKick(playerid);
			}
			case 41: format(hacking, sizeof(hacking), "Protection against an invalid version");
			case 42: format(hacking, sizeof(hacking), "Rcon hack");
			case 43: format(hacking, sizeof(hacking), "Tuning crasher");
			case 44: format(hacking, sizeof(hacking), "Invalid seat crasher");
			case 45: format(hacking, sizeof(hacking), "Dialog crasher");
			case 46: format(hacking, sizeof(hacking), "Attached object crasher");
			case 47: format(hacking, sizeof(hacking), "Weapon Crasher");
			case 48: format(hacking, sizeof(hacking), "Flood protection connects to one slot");
			case 49: format(hacking, sizeof(hacking), "flood callback functions");
			case 50: format(hacking, sizeof(hacking), "flood change seat");
			case 51: format(hacking, sizeof(hacking), "Ddos");
			case 52: format(hacking, sizeof(hacking), "NOP's");
		}

		format(string, 256, "[AGGUARD] : [%d]%s มีความเป็นไปได้ที่จะ %s", playerid, GetPlayerNameEx(playerid), hacking);
		SendAdminMessage(COLOR_ADMIN, string);
	}
	return 1;
}*/

forward ATM_Load();
public ATM_Load()
{
    static
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_ATM_MACHINES)
	{
	    atmData[i][atmExists] = true;
	    cache_get_value_name_int(i, "atmID", atmData[i][atmID]);
	    cache_get_value_name_float(i, "atmX", atmData[i][atmPosX]);
        cache_get_value_name_float(i, "atmY", atmData[i][atmPosY]);
        cache_get_value_name_float(i, "atmZ", atmData[i][atmPosZ]);
        cache_get_value_name_float(i, "atmA", atmData[i][atmPosA]);
        cache_get_value_name_int(i, "atmInterior", atmData[i][atmInterior]);
		cache_get_value_name_int(i, "atmWorld", atmData[i][atmWorld]);

		ATM_Refresh(i);
	}
	printf("[SERVER]: %d ATM were loaded from \"%s\" database...", rows, MYSQL_DATABASE);
	return 1;
}

forward Shop_Load();
public Shop_Load()
{
	static
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_SHOPS)
	{
	    shopData[i][shopExists] = true;

	    cache_get_value_name_int(i, "shopID", shopData[i][shopID]);
	    cache_get_value_name_float(i, "shopX", shopData[i][shopPosX]);
	    cache_get_value_name_float(i, "shopY", shopData[i][shopPosY]);
	    cache_get_value_name_float(i, "shopZ", shopData[i][shopPosZ]);
	    cache_get_value_name_int(i, "shopInterior", shopData[i][shopInterior]);
	    cache_get_value_name_int(i, "shopWorld", shopData[i][shopWorld]);
		cache_get_value_name_int(i, "shopType", shopData[i][shopType]);

	    Shop_Refresh(i);
	}
	printf("[SERVER]: %d Shops were loaded from \"%s\" database...", rows, MYSQL_DATABASE);
	return 1;
}


forward OnFactionCreated(factionid);
public OnFactionCreated(factionid)
{
	if (factionid == -1 || !factionData[factionid][factionExists])
	    return 0;

	factionData[factionid][factionID] = cache_insert_id();

	Faction_Save(factionid);
	Faction_SaveRanks(factionid);

	return 1;
}



forward OnATMCreated(atmid);
public OnATMCreated(atmid)
{
    if (atmid == -1 || !atmData[atmid][atmExists])
		return 0;

	atmData[atmid][atmID] = cache_insert_id();
 	ATM_Save(atmid);

	return 1;
}

forward OnShopCreated(shopid);
public OnShopCreated(shopid)
{
	if (shopid == -1 || !shopData[shopid][shopExists])
	    return 0;

	shopData[shopid][shopID] = cache_insert_id();
	Shop_Save(shopid);

	return 1;
}



forward OnInventoryAdd(playerid, itemid);
public OnInventoryAdd(playerid, itemid)
{
	invData[playerid][itemid][invID] = cache_insert_id();
	return 1;
}

forward OnContactAdd(playerid, id);
public OnContactAdd(playerid, id)
{
	contactData[playerid][id][contactID] = cache_insert_id();
	return 1;
}

ResetFaction(playerid)
{
    new query[90];
    playerData[playerid][pFaction] = -1;
    playerData[playerid][pFactionID] = -1;
    playerData[playerid][pFactionRank] = 0;
    if (playerData[playerid][pSpawnPoint] == 1) playerData[playerid][pSpawnPoint] = 0;
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `playerSpawn` = %d WHERE `playerID` = %d LIMIT 1",
	playerData[playerid][pSpawnPoint],
	playerData[playerid][pID]);
	mysql_tquery(g_SQL, query);
}

ResetPlayer(playerid)
{
	foreach (new i : Player) if (playerData[i][pDraggedBy] == playerid)
	{
	    StopDragging(i);
	}
	if (playerData[playerid][pDragged])
	{
	    StopDragging(playerid);
	}
	playerData[playerid][pCuffed] = 0;
    playerData[playerid][pDragged] = 0;
    playerData[playerid][pDraggedBy] = INVALID_PLAYER_ID;
}

forward DragUpdate(playerid, targetid);
public DragUpdate(playerid, targetid)
{
	if (playerData[targetid][pDragged] && playerData[targetid][pDraggedBy] == playerid)
	{
	    static
	        Float:fX,
	        Float:fY,
	        Float:fZ,
			Float:fAngle;

		GetPlayerPos(playerid, fX, fY, fZ);
		GetPlayerFacingAngle(playerid, fAngle);

		fX -= 2.5 * floatsin(-fAngle, degrees);
		fY -= 2.5 * floatcos(-fAngle, degrees);

		SetPlayerPos(targetid, fX, fY, fZ);
		SetPlayerInterior(targetid, GetPlayerInterior(playerid));
		SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
	}
	return 1;
}

StopDragging(playerid)
{
	if (playerData[playerid][pDragged])
	{
	    playerData[playerid][pDragged] = 0;
		playerData[playerid][pDraggedBy] = INVALID_PLAYER_ID;
		KillTimer(playerData[playerid][pDragTimer]);
	}
	return 1;
}

SendPlayerToPlayer(playerid, targetid)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(targetid, x, y, z);

	if (IsPlayerInAnyVehicle(playerid))
	{
	    SetVehiclePos(GetPlayerVehicleID(playerid), x, y + 2, z);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(targetid));
	}
	else
		SetPlayerPos(playerid, x + 1, y, z);

	SetPlayerInterior(playerid, GetPlayerInterior(targetid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));

	playerData[playerid][pEntrance] = playerData[targetid][pEntrance];
}

/*Tax_Percent(price)
{
	return floatround((float(price) / 100) * 95);
}*/

Tax_AddMoney(amount)
{
	g_TaxVault = g_TaxVault + amount;

	Server_Save();

	return 0;
}

/*Tax_AddPercent(price)
{
	new money = (price - Tax_Percent(price));

	g_TaxVault = g_TaxVault + money;

	Server_Save();
	return 1;
}*/

Server_Save()
{
	new
	    File:file = fopen("server.ini", io_write),
	    str[128];

	format(str, sizeof(str), "TaxMoney = %d\n", g_TaxVault);
	return (fwrite(file, str), fclose(file));
}

Server_Load()
{
	new File:file = fopen("server.ini", io_read);

	if (file)
	{
		g_TaxVault = file_parse_int(file, "TaxMoney");

		fclose(file);
	}
	return 1;
}

file_parse_int(File:handle, const field[])
{
	new
	    str[16];

	return (file_parse(handle, field, str), strval(str));
}

file_parse(File:handle, const field[], dest[], size = sizeof(dest))
{
	if (!handle)
	    return 0;

	new
	    str[128],
		pos = strlen(field);

	fseek(handle, 0, seek_start);

	while (fread(handle, str)) if (strfind(str, field, true) == 0 && (str[pos] == '=' || str[pos] == ' '))
	{
	    strmid(dest, str, (str[pos] == '=') ? (pos + 1) : (pos + 3), strlen(str), size);

		if ((pos = strfind(dest, "\r")) != -1)
			dest[pos] = '\0';
   		else if ((pos = strfind(dest, "\n")) != -1)
     		dest[pos] = '\0';

		return 1;
	}
	return 0;
}

randomEx(min, max)
{
    return random(max + 1 - min) + min;
}

IsPlayerInCityHall(playerid)
{
	new
		id = -1;

	if ((id = Entrance_Inside(playerid)) != -1 && entranceData[id][entranceType] == 4)
	    return 1;

	return 0;
}

IsPlayerInBank(playerid)
{
	new
		id = -1;

	if ((id = Entrance_Inside(playerid)) != -1 && entranceData[id][entranceType] == 2)
	    return 1;

	return 0;
}



IsPlayerSpawnedEx(playerid)
{
	if (playerid < 0 || playerid >= MAX_PLAYERS)
	    return 0;

	return (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING && GetPlayerState(playerid) != PLAYER_STATE_NONE && GetPlayerState(playerid) != PLAYER_STATE_WASTED);
}






IsABike(vehicleid)
{
	switch (GetVehicleModel(vehicleid))
	{
		case 481, 509, 510: return 1;
	}
	return 0;
}
stock Gate_Operate(gateid)
{
	if (gateid != -1 && GateData[gateid][gateExists])
	{
	    new id = -1;

		if (!GateData[gateid][gateOpened])
		{
		    GateData[gateid][gateOpened] = true;
		    MoveDynamicObject(GateData[gateid][gateObject], GateData[gateid][gateMove][0], GateData[gateid][gateMove][1], GateData[gateid][gateMove][2], GateData[gateid][gateSpeed], GateData[gateid][gateMove][3], GateData[gateid][gateMove][4], GateData[gateid][gateMove][5]);

            if (GateData[gateid][gateTime] > 0) {
				GateData[gateid][gateTimer] = SetTimerEx("CloseGate", GateData[gateid][gateTime], false, "ddfffffff", gateid, GateData[gateid][gateLinkID], GateData[gateid][gatePos][0], GateData[gateid][gatePos][1], GateData[gateid][gatePos][2], GateData[gateid][gateSpeed], GateData[gateid][gatePos][3], GateData[gateid][gatePos][4], GateData[gateid][gatePos][5]);
			}
			if (GateData[gateid][gateLinkID] != -1 && (id = GetGateByID(GateData[gateid][gateLinkID])) != -1)
			{
			    GateData[id][gateOpened] = true;
			    MoveDynamicObject(GateData[id][gateObject], GateData[id][gateMove][0], GateData[id][gateMove][1], GateData[id][gateMove][2], GateData[id][gateSpeed], GateData[id][gateMove][3], GateData[id][gateMove][4], GateData[id][gateMove][5]);
			}
		}
		else if (GateData[gateid][gateOpened])
		{
		    GateData[gateid][gateOpened] = false;
		    MoveDynamicObject(GateData[gateid][gateObject], GateData[gateid][gatePos][0], GateData[gateid][gatePos][1], GateData[gateid][gatePos][2], GateData[gateid][gateSpeed], GateData[gateid][gatePos][3], GateData[gateid][gatePos][4], GateData[gateid][gatePos][5]);

            if (GateData[gateid][gateTime] > 0) {
				KillTimer(GateData[gateid][gateTimer]);
		    }
			if (GateData[gateid][gateLinkID] != -1 && (id = GetGateByID(GateData[gateid][gateLinkID])) != -1)
			{
			    GateData[id][gateOpened] = false;
			    MoveDynamicObject(GateData[id][gateObject], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2], GateData[id][gateSpeed], GateData[id][gatePos][3], GateData[id][gatePos][4], GateData[id][gatePos][5]);
			}
		}
	}
	return 1;
}

// ระบบ Gate
stock IsValidObjectModel(modelid)
{
	if (modelid < 0 || modelid > 20000)
	    return 0;

    switch (modelid)
	{
		case 18632..18645, 18646..18658, 18659..18667, 18668..19299, 19301..19515, 18631, 331, 333..339, 318..321, 325, 326, 341..344, 346..353, 355..370, 372, 19817, 12943, 12978:
			return 1;
	}
    new const g_arrModelData[] =
	{
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -128,
        -515899393, -134217729, -1, -1, 33554431, -1, -1, -1, -14337, -1, -33,
      	127, 0, 0, 0, 0, 0, -8388608, -1, -1, -1, -16385, -1, -1, -1, -1, -1,
       -1, -1, -33, -1, -771751937, -1, -9, -1, -1, -1, -1, -1, -1, -1, -1, -1,
       -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
       -1, -1, -1, -1, -1, -1, -1, -1, 33554431, -25, -1, -1, -1, -1, -1, -1,
       -1073676289, -2147483648, 34079999, 2113536, -4825600, -5, -1, -3145729,
       -1, -16777217, -63, -1, -1, -1, -1, -201326593, -1, -1, -1, -1, -1,
       -257, -1, 1073741823, -133122, -1, -1, -65, -1, -1, -1, -1, -1, -1,
       -2146435073, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1073741823, -64, -1,
       -1, -1, -1, -2635777, 134086663, 0, -64, -1, -1, -1, -1, -1, -1, -1,
       -536870927, -131069, -1, -1, -1, -1, -1, -1, -1, -1, -16384, -1,
       -33554433, -1, -1, -1, -1, -1, -1610612737, 524285, -128, -1,
       2080309247, -1, -1, -1114113, -1, -1, -1, 66977343, -524288, -1, -1, -1,
       -1, -2031617, -1, 114687, -256, -1, -4097, -1, -4097, -1, -1,
       1010827263, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -32768, -1, -1, -1, -1, -1,
       2147483647, -33554434, -1, -1, -49153, -1148191169, 2147483647,
       -100781080, -262145, -57, 134217727, -8388608, -1, -1, -1, -1, -1, -1,
       -1, -1, -1, -1, -1, -1, -1, -1, -1048577, -1, -449, -1017, -1, -1, -1,
       -1, -1, -1, -1, -1, -1, -1, -1, -1835009, -2049, -1, -1, -1, -1, -1, -1,
       -8193, -1, -536870913, -1, -1, -1, -1, -1, -87041, -1, -1, -1, -1, -1,
       -1, -209860, -1023, -8388609, -2096897, -1, -1048577, -1, -1, -1, -1,
       -1, -1, -897, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1610612737,
       -3073, -28673, -1, -1, -1, -1537, -1, -1, -13, -1, -1, -1, -1, -1985,
       -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1056964609, -1, -1, -1,
       -1, -1, -1, -1, -2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
       -236716037, -1, -1, -1, -1, -1, -1, -1, -536870913, 3, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
       -1, -1, -1, -1, -1, -2097153, -2109441, -1, 201326591, -4194304, -1, -1,
       -241, -1, -1, -1, -1, -1, -1, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, -32768, -1, -1, -1, -2, -671096835, -1, -8388609, -66323585, -13,
       -1793, -32257, -247809, -1, -1, -513, 16252911, 0, 0, 0, -131072,
       33554383, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
       -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 8356095, 0, 0, 0, 0, 0,
       0, -256, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
       -268435449, -1, -1, -2049, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
       92274627, -65536, -2097153, -268435457, 591191935, 1, 0, -16777216, -1,
       -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 127
	};
 	return ((modelid >= 0) && ((modelid / 32) < sizeof(g_arrModelData)) && (g_arrModelData[modelid / 32] & (1 << (modelid % 32))));
}

/*new const BANANA_Data[][BANANA_DATA] =
{
	{ INVALID_STREAMER_ID, BANANAOBJECT, 1897.1653,436.3560,0.0902, Text3D: INVALID_3DTEXT_ID, BANANATEXT, 0 },
	{ INVALID_STREAMER_ID, BANANAOBJECT, 1894.6204,436.0612,-0.0778, Text3D: INVALID_3DTEXT_ID, BANANATEXT, 0 },
	{ INVALID_STREAMER_ID, BANANAOBJECT, 1890.8984,436.4697,-0.1177, Text3D: INVALID_3DTEXT_ID, BANANATEXT, 0 },
	{ INVALID_STREAMER_ID, BANANAOBJECT, 1886.2371,437.3989,-0.0997, Text3D: INVALID_3DTEXT_ID, BANANATEXT, 0 },
	{ INVALID_STREAMER_ID, BANANAOBJECT, 1877.4199,438.3397,0.3976, Text3D: INVALID_3DTEXT_ID, BANANATEXT, 0 }
};*/


stock Gate_Save(gateid)
{
	static
	    query[1024];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE `gates` SET `gateModel` = '%d', `gateSpeed` = '%.4f', `gateRadius` = '%.4f', `gateTime` = '%d', `gateX` = '%.4f', `gateY` = '%.4f', `gateZ` = '%.4f', `gateRX` = '%.4f', `gateRY` = '%.4f', `gateRZ` = '%.4f', `gateInterior` = '%d', `gateWorld` = '%d', `gateMoveX` = '%.4f', `gateMoveY` = '%.4f', `gateMoveZ` = '%.4f', `gateMoveRX` = '%.4f', `gateMoveRY` = '%.4f', `gateMoveRZ` = '%.4f', `gateLinkID` = '%d', `gateFaction` = '%d', `gatePass` = '%s' WHERE `gateID` = '%d'",
	    GateData[gateid][gateModel],
	    GateData[gateid][gateSpeed],
	    GateData[gateid][gateRadius],
	    GateData[gateid][gateTime],
	    GateData[gateid][gatePos][0],
	    GateData[gateid][gatePos][1],
	    GateData[gateid][gatePos][2],
	    GateData[gateid][gatePos][3],
	    GateData[gateid][gatePos][4],
	    GateData[gateid][gatePos][5],
	    GateData[gateid][gateInterior],
	    GateData[gateid][gateWorld],
	    GateData[gateid][gateMove][0],
	    GateData[gateid][gateMove][1],
	    GateData[gateid][gateMove][2],
	    GateData[gateid][gateMove][3],
	    GateData[gateid][gateMove][4],
	    GateData[gateid][gateMove][5],
	    GateData[gateid][gateLinkID],
	    GateData[gateid][gateFaction],
	    SQL_ReturnEscaped(GateData[gateid][gatePass]),
	    GateData[gateid][gateID]
	);
	return mysql_tquery(g_SQL, query);
}
stock Gate_Create(playerid)
{
	new
	    Float:x,
	    Float:y,
	    Float:z,
	    id,
	    Float:angle;


	if (GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
	{
		for (new i = 0; i < MAX_GATES; i ++) if (!GateData[i][gateExists])
		{
		    GateData[i][gateExists] = true;
			GateData[i][gateModel] = 980;
			GateData[i][gateSpeed] = 3.0;
			GateData[i][gateRadius] = 5.0;
			GateData[i][gateOpened] = 0;
			GateData[i][gateTime] = 0;

			GateData[i][gatePos][0] = x + (3.0 * floatsin(-angle, degrees));
			GateData[i][gatePos][1] = y + (3.0 * floatcos(-angle, degrees));
			GateData[i][gatePos][2] = z;
			GateData[i][gatePos][3] = 0.0;
			GateData[i][gatePos][4] = 0.0;
			GateData[i][gatePos][5] = angle;

			GateData[i][gateMove][0] = x + (3.0 * floatsin(-angle, degrees));
			GateData[i][gateMove][1] = y + (3.0 * floatcos(-angle, degrees));
			GateData[i][gateMove][2] = z - 10.0;
			GateData[i][gateMove][3] = -1000.0;
			GateData[i][gateMove][4] = -1000.0;
			GateData[i][gateMove][5] = -1000.0;

            GateData[i][gateInterior] = GetPlayerInterior(playerid);
            GateData[i][gateWorld] = GetPlayerVirtualWorld(playerid);

            GateData[i][gateLinkID] = -1;
            GateData[i][gateFaction] = -1;

            GateData[i][gatePass][0] = '\0';
            GateData[i][gateObject] = CreateDynamicObject(GateData[i][gateModel], GateData[i][gatePos][0], GateData[i][gatePos][1], GateData[i][gatePos][2], GateData[i][gatePos][3], GateData[i][gatePos][4], GateData[i][gatePos][5], GateData[i][gateWorld], GateData[i][gateInterior]);
			Gate_Save(id);

			mysql_tquery(g_SQL, "INSERT INTO `gates` (`gateModel`) VALUES(980)", "OnGateCreated", "d", i);
			return i;
		}
	}
	return -1;
}
stock Gate_Delete(gateid)
{
	if (gateid != -1 && GateData[gateid][gateExists])
	{
		new
		    query[64];

		format(query, sizeof(query), "DELETE FROM `gates` WHERE `gateID` = '%d'", GateData[gateid][gateID]);
		mysql_tquery(g_SQL, query);

		if (IsValidDynamicObject(GateData[gateid][gateObject]))
		    DestroyDynamicObject(GateData[gateid][gateObject]);

		for (new i = 0; i != MAX_GATES; i ++) if (GateData[i][gateExists] && GateData[i][gateLinkID] == GateData[gateid][gateID]) {
		    GateData[i][gateLinkID] = -1;
		    Gate_Save(i);
		}
		if (GateData[gateid][gateOpened] && GateData[gateid][gateTime] > 0) {
		    KillTimer(GateData[gateid][gateTimer]);
		}
	    GateData[gateid][gateExists] = false;
	    GateData[gateid][gateID] = 0;
	    GateData[gateid][gateOpened] = 0;
	}
	return 1;
}
stock HideYourPhone(playerid){
	PlayerTextDrawHide(playerid, FINPHONE[playerid][0]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][1]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][2]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][3]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][4]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][5]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][6]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][7]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][8]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][9]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][10]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][11]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][12]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][13]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][14]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][15]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][16]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][17]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][18]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][19]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][20]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][21]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][22]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][23]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][24]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][25]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][26]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][27]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][28]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][29]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][30]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][31]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][32]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][33]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][34]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][35]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][36]);
	PlayerTextDrawHide(playerid, FINPHONE[playerid][37]);
	CancelSelectTextDraw(playerid);

}
stock SetPlayerPosExten(playerid, Float:x, Float:y, Float:z, time = 2000)
{
	SetPlayerPos(playerid, x, y, z + 0.5);
	TogglePlayerControllable(playerid, 0);

	SetTimerEx("SetPlayerToUnfreeze", time, false, "dfff", playerid, x, y, z);
	return 1;
}

forward SetPlayerToUnfreeze(playerid, Float:x, Float:y, Float:z);
public SetPlayerToUnfreeze(playerid, Float:x, Float:y, Float:z)
{
	if (!IsPlayerInRangeOfPoint(playerid, 15.0, x, y, z))
	    return 0;

	SetPlayerPos(playerid, x, y, z);
	TogglePlayerControllable(playerid, 1);
	return 1;
}

IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetPlayerPos(targetid, fX, fY, fZ);

	return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}



SendNearbyMessage(playerid, Float:radius, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 16)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 16); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit CONST.alt 4
		#emit SUB
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (IsPlayerNearPlayer(i, playerid, radius))
			{
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (IsPlayerNearPlayer(i, playerid, radius))
		{
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

SendAdminMessage(color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (playerData[i][pAdmin] >= 1)
			{
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (playerData[i][pAdmin] >= 1)
		{
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

SendFactionMessageEx(type, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) if (playerData[i][pFaction] != -1 && GetFactionType(i) == type && !playerData[i][pDisableFaction])
		{
		    SendClientMessage(i, color, string);
		}
		return 1;
	}
	foreach (new i : Player) if (playerData[i][pFaction] != -1 && GetFactionType(i) == type && !playerData[i][pDisableFaction])
	{
 		SendClientMessage(i, color, str);
	}
	return 1;
}

SendFactionMessage(factionid, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) if (playerData[i][pFaction] == factionid && !playerData[i][pDisableFaction])
		{
		    SendClientMessage(i, color, string);
		}
		return 1;
	}
	foreach (new i : Player) if (playerData[i][pFaction] == factionid && !playerData[i][pDisableFaction])
	{
 		SendClientMessage(i, color, str);
	}
	return 1;
}

IsNearFactionLocker(playerid)
{
	new factionid = playerData[playerid][pFaction];

	if (factionid == -1)
	    return 0;

	if (IsPlayerInRangeOfPoint(playerid, 3.0, factionData[factionid][factionLockerPosX], factionData[factionid][factionLockerPosY], factionData[factionid][factionLockerPosZ]) && GetPlayerInterior(playerid) == factionData[factionid][factionLockerInt] && GetPlayerVirtualWorld(playerid) == factionData[factionid][factionLockerWorld])
	    return 1;

	return 0;
}

GetFactionByID(sqlid)
{
	for (new i = 0; i != MAX_FACTIONS; i ++) if (factionData[i][factionExists] && factionData[i][factionID] == sqlid)
	    return i;

	return -1;
}

SetFaction(playerid, id)
{
	new query[256];
	playerData[playerid][pFaction] = id;
	playerData[playerid][pFactionID] = factionData[id][factionID];

	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `playerFaction` = %d WHERE `playerID` = %d",playerData[playerid][pFactionID],playerData[playerid][pID]);
	mysql_tquery(g_SQL, query);
}

RemoveAlpha(color)
{
    return (color & ~0xFF);
}

SetFactionColor(playerid)
{
	new factionid = playerData[playerid][pFaction];

	if (factionid != -1)
		return SetPlayerColor(playerid, RemoveAlpha(factionData[factionid][factionColor]));

	return 0;
}

Faction_Update(factionid)
{
	if (factionid != -1 || factionData[factionid][factionExists])
	{
	    foreach (new i : Player) if (playerData[i][pFaction] == factionid)
		{
 			if (GetFactionType(i) == FACTION_GANG || (GetFactionType(i) != FACTION_GANG && playerData[i][pOnDuty]))
			 	SetFactionColor(i);
		}
	}
	return 1;
}

Faction_Save(factionid)
{
	static
	    query[2048];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE `factions` SET `factionName` = '%e', `factionColor` = '%d', `factionType` = '%d', `factionRanks` = '%d', `factionTreasury` = '%d', `factionRedTreasury` = '%d', \
	`factionLockerX` = '%.4f', `factionLockerY` = '%.4f', `factionLockerZ` = '%.4f', `factionLockerInt` = '%d', `factionLockerWorld` = '%d', `SpawnX` = '%f', `SpawnY` = '%f', `SpawnZ` = '%f', `SpawnInterior` = '%d', `SpawnVW` = '%d', `factionEntrance` = '%d'", 
		factionData[factionid][factionName],
		factionData[factionid][factionColor],
		factionData[factionid][factionType],
		factionData[factionid][factionRanks],
		factionData[factionid][factionTreasury],
		factionData[factionid][factionRedTreasury],
		
		factionData[factionid][factionLockerPosX],
		factionData[factionid][factionLockerPosY],
		factionData[factionid][factionLockerPosZ],
		factionData[factionid][factionLockerInt],
		factionData[factionid][factionLockerWorld],

		factionData[factionid][SpawnX],
		factionData[factionid][SpawnY],
		factionData[factionid][SpawnZ],
		factionData[factionid][SpawnInterior],
		factionData[factionid][SpawnVW],
		factionData[factionid][factionEntrance]
	);
	for (new i = 0; i < 10; i ++)
	{
	    if (i < 8)
			mysql_format(g_SQL, query, sizeof(query), "%s, `factionSkin%d` = '%d', `factionWeapon%d` = '%d', `factionAmmo%d` = '%d'", query, i + 1, factionData[factionid][factionSkins][i], i + 1, factionData[factionid][factionWeapons][i], i + 1, factionData[factionid][factionAmmo][i]);

		else
			mysql_format(g_SQL, query, sizeof(query), "%s, `factionWeapon%d` = '%d', `factionAmmo%d` = '%d'", query, i + 1, factionData[factionid][factionWeapons][i], i + 1, factionData[factionid][factionAmmo][i]);
	}
	mysql_format(g_SQL, query, sizeof(query), "%s WHERE `factionID` = '%d'",
		query,
		factionData[factionid][factionID]
	);
	return mysql_tquery(g_SQL, query);
}
Faction_SaveRanks(factionid)
{
	static
	    query[768];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE `factions` SET `factionRank1` = '%e', `factionRank2` = '%e', `factionRank3` = '%e', `factionRank4` = '%e', `factionRank5` = '%e', `factionRank6` = '%e', `factionRank7` = '%e', `factionRank8` = '%e', `factionRank9` = '%e', `factionRank10` = '%e', `factionRank11` = '%e', `factionRank12` = '%e', `factionRank13` = '%e', `factionRank14` = '%e', `factionRank15` = '%e' WHERE `factionID` = '%d'",
	    FactionRanks[factionid][0],
	    FactionRanks[factionid][1],
	    FactionRanks[factionid][2],
	    FactionRanks[factionid][3],
	    FactionRanks[factionid][4],
	    FactionRanks[factionid][5],
	    FactionRanks[factionid][6],
	    FactionRanks[factionid][7],
	    FactionRanks[factionid][8],
	    FactionRanks[factionid][9],
	    FactionRanks[factionid][10],
	    FactionRanks[factionid][11],
	    FactionRanks[factionid][12],
	    FactionRanks[factionid][13],
	    FactionRanks[factionid][14],
	    factionData[factionid][factionID]
	);
	return mysql_tquery(g_SQL, query);
}

Faction_Delete(factionid)
{
	if (factionid != -1 && factionData[factionid][factionExists])
	{
	    new
	        string[512];

		mysql_format(g_SQL, string, sizeof(string), "DELETE FROM `factions` WHERE `factionID` = '%d'", factionData[factionid][factionID]);
		mysql_tquery(g_SQL, string);

		mysql_format(g_SQL, string, sizeof(string), "UPDATE `players` SET `playerFaction` = '-1' WHERE `playerFaction` = '%d'", factionData[factionid][factionID]);
		mysql_tquery(g_SQL, string);

		for (new i = 0; i != 100; i ++)
		{
		    if (VehicleGang[i][Exist])
		    {
		        if (factionid == VehicleGang[i][bLeader])
		        {
					DestroyDynamicPickup(VehicleGang[i][bPickup]);
					DestroyDynamic3DTextLabel(VehicleGang[i][bMessage]);

					new query[64];

					VehicleGang[i][bPosX] = 0.0;
					VehicleGang[i][bPosY] = 0.0;
					VehicleGang[i][bPosZ] = 0.0;
					VehicleGang[i][bLeader] = -1;

					mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehiclegang WHERE ID = %d", i);
					mysql_tquery(g_SQL, query, "", "");

					VehicleGang[i][Exist] = false;
		        }
		    }
		}

		foreach (new i : Player)
		{
			if (playerData[i][pFaction] == factionid)
			{
		    	playerData[i][pFaction] = -1;
		    	playerData[i][pFactionID] = -1;
		    	playerData[i][pFactionRank] = -1;
			}
			if (playerData[i][pFactionEdit] == factionid)
			{
			    playerData[i][pFactionEdit] = -1;
			}
		}
		if (IsValidDynamicPickup(factionData[factionid][factionPickup]))
  			DestroyDynamicPickup(factionData[factionid][factionPickup]);

		if (IsValidDynamic3DTextLabel(factionData[factionid][factionText3D]))
  			DestroyDynamic3DTextLabel(factionData[factionid][factionText3D]);

	    factionData[factionid][factionExists] = false;
	    factionData[factionid][factionType] = 0;
	    factionData[factionid][factionID] = 0;
	}
	return 1;
}

GetFactionType(playerid)
{
	if (playerData[playerid][pFaction] == -1)
	    return 0;

	return (factionData[playerData[playerid][pFaction]][factionType]);
}

stock IsACop(playerid) //แก้บัค /ca /cs
{
	if(IsPlayerConnected(playerid))
	{
	    new id = -1;

	    if((id = playerData[playerid][pFaction]) != -1 && factionData[id][factionType] == FACTION_POLICE)
		{
		    return 1;
		}
	}
	return 0;
}

Faction_ShowRanks(playerid, factionid)
{
    if (factionid != -1 && factionData[factionid][factionExists])
	{
		static
		    string[640];

		string[0] = 0;

		for (new i = 0; i < factionData[factionid][factionRanks]; i ++)
		    format(string, sizeof(string), "%sระดับ %d: ตำแหน่ง %s\n", string, i + 1, FactionRanks[factionid][i]);

		playerData[playerid][pFactionEdit] = factionid;
		Dialog_Show(playerid, DIALOG_EDITRANKS, DIALOG_STYLE_LIST, factionData[factionid][factionName], string, "เปลี่ยน", "ออก");
	}
	return 1;
}

Faction_Create(const name[], type)
{
	for (new i = 0; i != MAX_FACTIONS; i ++) if (!factionData[i][factionExists])
	{
	    format(factionData[i][factionName], 32, name);

        factionData[i][factionExists] = true;
        factionData[i][factionColor] = COLOR_WHITE;
        factionData[i][factionType] = type;
        factionData[i][factionRanks] = 5;

        factionData[i][factionLockerPosX] = 0.0;
        factionData[i][factionLockerPosY] = 0.0;
        factionData[i][factionLockerPosZ] = 0.0;
        factionData[i][factionLockerInt] = 0;
        factionData[i][factionLockerWorld] = 0;

        for (new j = 0; j < 8; j ++)
		{
            factionData[i][factionSkins][j] = 0;
        }
        for (new j = 0; j < 10; j ++)
		{
            factionData[i][factionWeapons][j] = 0;
            factionData[i][factionAmmo][j] = 0;
	    }
	    for (new j = 0; j < 15; j ++)
		{
			format(FactionRanks[i][j], 32, "Rank %d", j + 1);
	    }
	    mysql_tquery(g_SQL, "INSERT INTO `factions` (`factionType`) VALUES(0)", "OnFactionCreated", "d", i);
	    return i;
	}
	return -1;
}

IsNumeric(const str[])
{
	for (new i = 0, l = strlen(str); i != l; i ++)
	{
	    if (i == 0 && str[0] == '-')
			continue;

	    else if (str[i] < '0' || str[i] > '9')
			return 0;
	}
	return 1;
}

GetVehicleModelByName(const name[])
{
	if (IsNumeric(name) && (strval(name) >= 400 && strval(name) <= 611))
	    return strval(name);

	for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
	{
	    if (strfind(g_arrVehicleNames[i], name, true) != -1)
	    {
	        return i + 400;
		}
	}
	return 0;
}

GetVehicleDriver(vehicleid)
{
	foreach (new i : Player)
	{
		if (GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == vehicleid) return i;
	}
	return INVALID_PLAYER_ID;
}

GetVehicleDriverGarageDx(vehicleid)
{
	foreach (new i : Player)
	{
		if (GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == vehicleid && CallVehicleGang[i] == vehicleid) return i;
	}
	return INVALID_PLAYER_ID;
}


public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CARRY || playerData[playerid][pInjured] == 1)
	{
	    ClearAnimations(playerid);
	    return 1;
	}

	if (!ispassenger && vehicleid != -1 && carData[vehicleid][carFaction] != -1 && playerData[playerid][pFaction] != carData[vehicleid][carFaction]) {
	    ClearAnimations(playerid);
		SendClientMessage(playerid, COLOR_LIGHTRED, "- คุณไม่สามารถขับยานพาหนะคันนี้ได้");
		return 1;
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    if (IsPlayerNPC(playerid))
	    return 1;


	if (playerData[playerid][pDrivingTest])
	{
 		SetPlayerPos(playerid, playerData[playerid][pPos_X], playerData[playerid][pPos_Y], playerData[playerid][pPos_Z]);
 		SetPlayerFacingAngle(playerid, playerData[playerid][pPos_A]);

  		SetPlayerInterior(playerid, playerData[playerid][pInterior]);
  		SetPlayerVirtualWorld(playerid, playerData[playerid][pWorld]);

		DisablePlayerCheckpoint(playerid);
  		SetCameraBehindPlayer(playerid);
		PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
		DestroyVehicle(playerData[playerid][pTestCar]);
  		playerData[playerid][pDrivingTest] = false;
		SendClientMessage(playerid, COLOR_LIGHTRED, "[Driving School]: การสอบใบขับขี่ถูก เนื่องจากคุณลงจากยานพาหนะ");
	}
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	if(carData[vehicleid][carOwnerID] > 0 || carData[vehicleid][carFaction] >= 0)
	{
		new query[128];
	    carData[vehicleid][carColor1] = color1;
	    carData[vehicleid][carColor2] = color2;

	    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carColor1 = %d, carColor2 = %d WHERE carID = %d", color1, color2, carData[vehicleid][carID]);
	    mysql_tquery(g_SQL, query);
	}

	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	if(carData[vehicleid][carOwnerID] > 0 || carData[vehicleid][carFaction] >= 0)
	{
		new query[128];
	    carData[vehicleid][carPaintjob] = paintjobid;

	    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carPaintjob = %d WHERE carID = %d", paintjobid, carData[vehicleid][carID]);
	    mysql_tquery(g_SQL, query);
	}

	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	if(!GetPlayerInterior(playerid) && playerData[playerid][pAdmin] < 2)
	{
	    SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s ถูกแบนโดยแอดมิน SERVER_ANTICHEAT, สาเหตุ: Illegal modding", GetPlayerNameEx(playerid));
	    playerData[playerid][pBan] = 1;
		format(playerData[playerid][pBanReason], 32, "Illegal modding");
		DelayedKick(playerid);
	    return 0;
	}

	if(carData[vehicleid][carOwnerID] > 0 || carData[vehicleid][carFaction] >= 0)
	{
	    new slotid = GetVehicleComponentType(componentid);
		new query[128];

	    carData[vehicleid][carMods][slotid] = componentid;

	    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carMod%d = %d WHERE carID = %d", slotid + 1, componentid, carData[vehicleid][carID]);
	    mysql_tquery(g_SQL, query);
	}

	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	if(adminVehicle[vehicleid])
	{
	    DestroyVehicle(vehicleid);
	    adminVehicle[vehicleid] = false;
	}
	if(IsValidDynamicObject(vehicleSiren[vehicleid]))
	{
	    DestroyDynamicObject(vehicleSiren[vehicleid]);
	    vehicleSiren[vehicleid] = INVALID_OBJECT_ID;
	}
	new modelid = GetVehicleModel(vehicleid);
	if((carData[vehicleid][carID] > 0 && carData[vehicleid][carOwnerID] > 0) || (carData[vehicleid][carFaction] >= 0))
	{
	    ReloadVehicle(vehicleid);

	    if(carData[vehicleid][carFaction] >= 0)
	    {
		vehicleFuel[vehicleid] = vehicleData[modelid - 400][vFuel];
		}
	}
	else
	{
     	if(carData[vehicleid][carID] > 0 && carData[vehicleid][carHealth] > 300.0)
     	{
			if (carData[vehicleid][carHealth] < 350)
				SetVehicleHealth(vehicleid, 350);
			else
			    SetVehicleHealth(vehicleid, carData[vehicleid][carHealth]);
     	}

		vehicleFuel[vehicleid] = vehicleData[modelid - 400][vFuel];
	}

	vehicleStream[vehicleid][0] = 0;

	return 1;
}

GetSpawnedVehicles(playerid)
{
	new count;

    for(new i = 1; i < MAX_VEHICLES; i ++)
	{
	    if(IsValidVehicle(i) && IsVehicleOwner(playerid, i))
	    {
	        count++;
		}
	}

	return count;
}

GetNearbyVehicle(playerid)
{
	new Float:x, Float:y, Float:z;

	for(new i = 1; i < MAX_VEHICLES; i ++)
	{
	    if(IsValidVehicle(i) && IsVehicleStreamedIn(i, playerid))
	    {
	        GetVehiclePos(i, x, y, z);

	        if(IsPlayerInRangeOfPoint(playerid, 3.5, x, y, z))
	        {
	            return i;
			}
		}
	}

	return INVALID_VEHICLE_ID;
}


IsVehicleOccupied(vehicleid)
{
	foreach(new i : Player)
	{
	    if(IsPlayerInVehicle(i, vehicleid) && GetPlayerState(i) == PLAYER_STATE_DRIVER)
	    {
	        return 1;
		}
	}

	return 0;
}

IsVehicleOwner(playerid, vehicleid)
{
	return (carData[vehicleid][carOwnerID] == playerData[playerid][pID]) && (carData[vehicleid][carOwnerID] != 0);
}

SetVehicleNeon(vehicleid, modelid)
{
	if(18647 <= modelid <= 18652)
	{
	    if(carData[vehicleid][carNeonEnabled])
	    {
	        DestroyDynamicObject(carData[vehicleid][carObjects][0]);
			DestroyDynamicObject(carData[vehicleid][carObjects][1]);
	    }

		new query[128];

	    carData[vehicleid][carNeon] = modelid;
	    carData[vehicleid][carNeonEnabled] = (modelid > 0);

		mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carNeon = %d, carNeonEnabled = 1 WHERE carID = %d", carData[vehicleid][carNeon], carData[vehicleid][carID]);
		mysql_tquery(g_SQL, query);

		ReloadVehicleNeon(vehicleid);
	}
}

ReloadVehicleNeon(vehicleid)
{
	if(carData[vehicleid][carID] > 0)
	{
	    DestroyDynamicObject(carData[vehicleid][carObjects][0]);
	    DestroyDynamicObject(carData[vehicleid][carObjects][1]);

	    if(carData[vehicleid][carNeon] && carData[vehicleid][carNeonEnabled])
	    {
	        new
				Float:x,
				Float:y,
				Float:z;

			GetVehicleModelInfo(carData[vehicleid][carModel], VEHICLE_MODEL_INFO_SIZE, x, y, z);

			carData[vehicleid][carObjects][0] = CreateDynamicObject(carData[vehicleid][carNeon], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
			carData[vehicleid][carObjects][1] = CreateDynamicObject(carData[vehicleid][carNeon], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

			AttachDynamicObjectToVehicle(carData[vehicleid][carObjects][0], vehicleid, -x / 2.8, 0.0, -0.6, 0.0, 0.0, 0.0);
			AttachDynamicObjectToVehicle(carData[vehicleid][carObjects][1], vehicleid, x / 2.8, 0.0, -0.6, 0.0, 0.0, 0.0);
		}
	}
}

ResyncVehicle(vehicleid)
{
	new
		worldid = GetVehicleVirtualWorld(vehicleid);
	SetVehicleVirtualWorld(vehicleid, cellmax);
	SetVehicleVirtualWorld(vehicleid, worldid);
}



SaveVehicleModifications(vehicleid)
{
	for(new i = 0; i < 14; i ++)
	{
	    carData[vehicleid][carMods][i] = GetVehicleComponentInSlot(vehicleid, i);

		new query[128];

	    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carMod%d = %d WHERE carID = %d", i + 1, carData[vehicleid][carMods][i], carData[vehicleid][carID]);
	    mysql_tquery(g_SQL, query);
	}
}

ReloadVehicle(vehicleid)
{
    if(carData[vehicleid][carPaintjob] >= 0)
    {
        ChangeVehiclePaintjob(vehicleid, carData[vehicleid][carPaintjob]);
    }
    if(carData[vehicleid][carNeon] && carData[vehicleid][carNeonEnabled])
	{
		ReloadVehicleNeon(vehicleid);
    }

	for(new i = 0; i < 14; i ++)
	{
	    if(carData[vehicleid][carMods][i] >= 1000)
	    {
	        AddVehicleComponent(vehicleid, carData[vehicleid][carMods][i]);
		}
	}

	if(strcmp(carData[vehicleid][carPlate], "None") != 0)
	{
	    SetVehicleNumberPlate(vehicleid, carData[vehicleid][carPlate]);
	    ResyncVehicle(vehicleid);
	}

    LinkVehicleToInterior(vehicleid, carData[vehicleid][carInterior]);
    SetVehicleVirtualWorld(vehicleid, carData[vehicleid][carWorld]);
	if (carData[vehicleid][carHealth] < 350)
		SetVehicleHealth(vehicleid, 350);
	else
	    SetVehicleHealth(vehicleid, carData[vehicleid][carHealth]);
    SetVehicleParams(vehicleid, VEHICLE_DOORS, carData[vehicleid][carLocked]);
}

DespawnVehicle(vehicleid, bool:save = true)
{
	if(carData[vehicleid][carID] > 0)
	{
	    if(carData[vehicleid][carNeonEnabled])
	    {
	        DestroyDynamicObject(carData[vehicleid][carObjects][0]);
	        DestroyDynamicObject(carData[vehicleid][carObjects][1]);
	    }
		if(save)
		{
		    new
				Float:health,
				query[128];

		    GetVehicleHealth(vehicleid, health);
		    SaveVehicleModifications(vehicleid);

		    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carFuel = %.2f, carHealth = '%f' WHERE carID = %d", vehicleFuel[vehicleid], health, carData[vehicleid][carID]);
	    	mysql_tquery(g_SQL, query);
	    }
		DestroyVehicle(vehicleid);
		ResetVehicle(vehicleid);
	}
}

ResetVehicle(vehicleid)
{
	strcpy(carData[vehicleid][carPlate], "None", 32);

	if(carData[vehicleid][carTimer] >= 0)
	{
	    KillTimer(carData[vehicleid][carTimer]);
	}

    carData[vehicleid][carID] = 0;
	carData[vehicleid][carOwnerID] = 0;
	carData[vehicleid][carOwner] = 0;
	carData[vehicleid][carModel] = 0;
	carData[vehicleid][carPrice] = 0;
	carData[vehicleid][carType] = 0;
	carData[vehicleid][carTickets] = 0;
	carData[vehicleid][carLocked] = 0;
	carData[vehicleid][carHealth] = 1000.0;
	carData[vehicleid][carPosX] = 0.0;
	carData[vehicleid][carPosY] = 0.0;
	carData[vehicleid][carPosZ] = 0.0;
	carData[vehicleid][carPosA] = 0.0;
	carData[vehicleid][carColor1] = 0;
	carData[vehicleid][carColor2] = 0;
	carData[vehicleid][carPaintjob] = -1;
	carData[vehicleid][carInterior] = 0;
	carData[vehicleid][carWorld] = 0;
	carData[vehicleid][carCash] = 0;
    carData[vehicleid][carFaction] = -1;
	carData[vehicleid][carObjects][0] = INVALID_OBJECT_ID;
	carData[vehicleid][carObjects][1] = INVALID_OBJECT_ID;
	carData[vehicleid][carTimer] = -1;
	carData[vehicleid][carTune] = 0;
	carData[vehicleid][carDestroy] = 0;

	for(new i = 0; i < 14; i ++)
	{
		if (i < 5)
		{
			carData[vehicleid][carWeapons][i] = 0;
			carData[vehicleid][carAmmo][i] = 0;
		}
	    carData[vehicleid][carMods][i] = 0;
	}
//	Car_RemoveAllItems(vehicleid);
}



forward DespawnTimer(vehicleid);
public DespawnTimer(vehicleid)
{
	if(carData[vehicleid][carOwnerID] > 0)
	{
	    DespawnVehicle(vehicleid);
	}
	else
	{
	    // ANOTHER TEN MINUTES!
	    carData[vehicleid][carTimer] = SetTimerEx("DespawnTimer", 600000, false, "i", vehicleid);
	}
}



forward OnPlayerSpawnVehicle(playerid, parked);
public OnPlayerSpawnVehicle(playerid, parked)
{
	static
	    rows;
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	cache_get_row_count(rows);

	if(!rows)
	{
	    SendClientMessage(playerid, COLOR_LIGHTRED, "- ตรวจพบข้อผิดพลากบางอย่าง กรุณาติดต่อแอดมิน...");
	}
	else
	{
	    /*for(new i = 0; i < MAX_VEHICLES; i ++)
	    {
			new vid;
			cache_get_value_name_int(0, "carID", vid);
	        if(IsValidVehicle(i) && carData[i][carID] == vid)
	        {
         	   return SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถเบิกได้ เนื่องจากรถคันนี้ถูกเรียกออกมาใช้งานอยู่ในปัจจุบัน ");
	    	}
	    }*/

        if (playerData[playerid][pVip] == 0)
		{
		    if(GetSpawnedVehicles(playerid) >= MAX_SPAWNED_VEHICLES)
		    {
		        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "- ไม่สามารถเบิกได้ เนื่องจากคุณได้เรียกรถออกมาครบจำนวนแล้ว (( %d คัน )) ", MAX_SPAWNED_VEHICLES);
		    }
		}

        else if (playerData[playerid][pVip] == 1)
		{
		    if(GetSpawnedVehicles(playerid) >= 3)
		    {
		        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "- ไม่สามารถเบิกได้ เนื่องจากคุณได้เรียกรถออกมาครบจำนวนแล้ว (( %d คัน )) ", MAX_SPAWNED_VEHICLES);
		    }
		}

        else if (playerData[playerid][pVip] == 2)
		{
		    if(GetSpawnedVehicles(playerid) >= 5)
		    {
		        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "- ไม่สามารถเบิกได้ เนื่องจากคุณได้เรียกรถออกมาครบจำนวนแล้ว (( %d คัน )) ", MAX_SPAWNED_VEHICLES);
		    }
		}

        else if (playerData[playerid][pVip] == 3)
		{
		    if(GetSpawnedVehicles(playerid) >= 7)
		    {
		        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "- ไม่สามารถเบิกได้ เนื่องจากคุณได้เรียกรถออกมาครบจำนวนแล้ว (( %d คัน )) ", MAX_SPAWNED_VEHICLES);
		    }
		}

	    new modelid, Float:x, Float:y, Float:z, Float:a, color1, color2, vehicleid, carfix, destroy;

		cache_get_value_name_int(0, "carModel", modelid);
		/*cache_get_value_name_float(0, "carPosX", x);
		cache_get_value_name_float(0, "carPosY", y);
		cache_get_value_name_float(0, "carPosZ", z);
		cache_get_value_name_float(0, "carPosA", a);*/
		cache_get_value_name_int(0, "carColor1", color1);
		cache_get_value_name_int(0, "carColor2", color2);

		cache_get_value_name_int(0, "carFix", carfix);
		cache_get_value_name_int(0, "carDestroy", destroy);

		if (destroy == 1)
		{
			SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Spawn Vehicle] ไม่สามารถเบิกได้ เนื่องจากยานพาหนะของคุณเสียหายอย่างหนัก!");
			SendClientMessageEx(playerid, COLOR_LIGHTRED, "(( คุณจำเป็นต้องกู้ซากยานพาหนะดังกล่าวนั้นก่อน เพื่อเรียกออกมาใช้งานอีกครั้ง ))");
			return 1;
		}


		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
//  เรียกรถส่วนตัว
		vehicleid = CreateVehicle(modelid, x, y+2.0, z, a, color1, color2, -1);
		PutPlayerInVehicle(playerid, vehicleid, 0);



		if(vehicleid != INVALID_VEHICLE_ID)
		{
		    ResetVehicle(vehicleid);

		    cache_get_value_name(0, "carOwner", carData[vehicleid][carOwner], MAX_PLAYER_NAME);
		    cache_get_value_name(0, "carPlate", carData[vehicleid][carPlate], 32);

		    cache_get_value_name_int(0, "carID", carData[vehicleid][carID]);
		    cache_get_value_name_int(0, "carOwnerID", carData[vehicleid][carOwnerID]);
		    cache_get_value_name_int(0, "carPrice", carData[vehicleid][carPrice]);
		    cache_get_value_name_int(0, "carType", carData[vehicleid][carType]);
		    cache_get_value_name_int(0, "carTickets", carData[vehicleid][carTickets]);
		    cache_get_value_name_int(0, "carLocked", carData[vehicleid][carLocked]);
		    cache_get_value_name_float(0, "carHealth", carData[vehicleid][carHealth]);
		    cache_get_value_name_int(0, "carPaintjob", carData[vehicleid][carPaintjob]);
		    cache_get_value_name_int(0, "carInterior", carData[vehicleid][carInterior]);
	        cache_get_value_name_int(0, "carWorld", carData[vehicleid][carWorld]);
	        cache_get_value_name_int(0, "carNeon", carData[vehicleid][carNeon]);
	        cache_get_value_name_int(0, "carNeonEnabled", carData[vehicleid][carNeonEnabled]);
	        cache_get_value_name_int(0, "carTrunk", carData[vehicleid][carTrunk]);
	        cache_get_value_name_int(0, "carTrunkQuantity", carData[vehicleid][carTrunkQuantity]);
	        cache_get_value_name_int(0, "carMod1", carData[vehicleid][carMods][0]);
	        cache_get_value_name_int(0, "carMod2", carData[vehicleid][carMods][1]);
	        cache_get_value_name_int(0, "carMod3", carData[vehicleid][carMods][2]);
	        cache_get_value_name_int(0, "carMod4", carData[vehicleid][carMods][3]);
	        cache_get_value_name_int(0, "carMod5", carData[vehicleid][carMods][4]);
	        cache_get_value_name_int(0, "carMod6", carData[vehicleid][carMods][5]);
	        cache_get_value_name_int(0, "carMod7", carData[vehicleid][carMods][6]);
	        cache_get_value_name_int(0, "carMod8", carData[vehicleid][carMods][7]);
	        cache_get_value_name_int(0, "carMod9", carData[vehicleid][carMods][8]);
	        cache_get_value_name_int(0, "carMod10", carData[vehicleid][carMods][9]);
	        cache_get_value_name_int(0, "carMod11", carData[vehicleid][carMods][10]);
	        cache_get_value_name_int(0, "carMod12", carData[vehicleid][carMods][11]);
	        cache_get_value_name_int(0, "carMod13", carData[vehicleid][carMods][12]);
	        cache_get_value_name_int(0, "carMod14", carData[vehicleid][carMods][13]);

	        cache_get_value_name_int(0, "carCash", carData[vehicleid][carCash]);
	        cache_get_value_name_int(0, "carTune", carData[vehicleid][carTune]);
			cache_get_value_name_int(0, "carDestroy",carData[vehicleid][carDestroy]);

/*	        cache_get_value_name_int(0, "carWeapon1", carData[vehicleid][carWeapons][0]);
	        cache_get_value_name_int(0, "carWeapon2", carData[vehicleid][carWeapons][1]);
	        cache_get_value_name_int(0, "carWeapon3", carData[vehicleid][carWeapons][2]);
	        cache_get_value_name_int(0, "carWeapon4", carData[vehicleid][carWeapons][3]);
	        cache_get_value_name_int(0, "carWeapon5", carData[vehicleid][carWeapons][4]);

	        cache_get_value_name_int(0, "carAmmo1", carData[vehicleid][carAmmo][0]);
	        cache_get_value_name_int(0, "carAmmo2", carData[vehicleid][carAmmo][1]);
	        cache_get_value_name_int(0, "carAmmo3", carData[vehicleid][carAmmo][2]);
	        cache_get_value_name_int(0, "carAmmo4", carData[vehicleid][carAmmo][3]);
	        cache_get_value_name_int(0, "carAmmo5", carData[vehicleid][carAmmo][4]);*/

	        carData[vehicleid][carFaction] = -1;
	        carData[vehicleid][carModel] = modelid;
		    carData[vehicleid][carPosX] = x;
		    carData[vehicleid][carPosY] = y;
		    carData[vehicleid][carPosZ] = z;
		    carData[vehicleid][carPosA] = a;
		    carData[vehicleid][carColor1] = color1;
		    carData[vehicleid][carColor2] = color2;
		    carData[vehicleid][carObjects][0] = INVALID_OBJECT_ID;
		    carData[vehicleid][carObjects][1] = INVALID_OBJECT_ID;
		    carData[vehicleid][carTimer] = -1;

			cache_get_value_name_float(0, "carFuel", vehicleFuel[vehicleid]);
			adminVehicle[vehicleid] = false;

			ReloadVehicle(vehicleid);




			new query[254];
			mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `trunk` WHERE `trunkOwner` = '%d'", carData[vehicleid][carOwnerID]);
			mysql_tquery(g_SQL, query, "Trunk_Load", "d", vehicleid);
		    if(!parked)
			{
			    /*SendClientMessageEx(playerid, COLOR_PINK, "[!] คุณได้เรียกรถรุ่น %s ออกมาแล้ว /จุดจอดรถ ในการค้นหาตำแหน่งปัจจุบัน", ReturnVehicleName(vehicleid));
			    SendClientMessageEx(playerid, COLOR_PINK, "[!] สามารถ /carinfo เพื่อดูคำสั่งรถได้");*/
			}
	    }
	}

	return 1;
}




ATM_Delete(atmid)
{
	if (atmid != -1 && atmData[atmid][atmExists])
	{
	    new
	        string[64];

		mysql_format(g_SQL, string, sizeof(string), "DELETE FROM `atm` WHERE `atmID` = '%d'", atmData[atmid][atmID]);
		mysql_tquery(g_SQL, string);

        if (IsValidDynamicObject(atmData[atmid][atmObject]))
	        DestroyDynamicObject(atmData[atmid][atmObject]);

	    if (IsValidDynamic3DTextLabel(atmData[atmid][atmText3D]))
	        DestroyDynamic3DTextLabel(atmData[atmid][atmText3D]);

	    atmData[atmid][atmExists] = false;
	    atmData[atmid][atmID] = 0;
	}
	return 1;
}

ATM_Nearest(playerid)
{
    for (new i = 0; i != MAX_ATM_MACHINES; i ++) if (atmData[i][atmExists] && IsPlayerInRangeOfPoint(playerid, 2.5, atmData[i][atmPosX], atmData[i][atmPosY], atmData[i][atmPosZ]))
	{
		if (GetPlayerInterior(playerid) == atmData[i][atmInterior] && GetPlayerVirtualWorld(playerid) == atmData[i][atmWorld])
			return i;
	}
	return -1;
}

ATM_Create(playerid)
{
    new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;

	if (GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
	{
		for (new i = 0; i < MAX_ATM_MACHINES; i ++) if (!atmData[i][atmExists])
		{
		    atmData[i][atmExists] = true;

		    x += 1.0 * floatsin(-angle, degrees);
			y += 1.0 * floatcos(-angle, degrees);

            atmData[i][atmPosX] = x;
            atmData[i][atmPosY] = y;
            atmData[i][atmPosZ] = z;
            atmData[i][atmPosA] = angle;

            atmData[i][atmInterior] = GetPlayerInterior(playerid);
            atmData[i][atmWorld] = GetPlayerVirtualWorld(playerid);

			ATM_Refresh(i);
			mysql_tquery(g_SQL, "INSERT INTO `atm` (`atmInterior`) VALUES(0)", "OnATMCreated", "d", i);

			return i;
		}
	}
	return -1;
}

ATM_Refresh(atmid)
{
	if (atmid != -1 && atmData[atmid][atmExists])
	{
	    if (IsValidDynamicObject(atmData[atmid][atmObject]))
	        DestroyDynamicObject(atmData[atmid][atmObject]);

	    if (IsValidDynamic3DTextLabel(atmData[atmid][atmText3D]))
	        DestroyDynamic3DTextLabel(atmData[atmid][atmText3D]);

		atmData[atmid][atmObject] = CreateDynamicObject(2942, atmData[atmid][atmPosX], atmData[atmid][atmPosY], atmData[atmid][atmPosZ] - 0.4, 0.0, 0.0, atmData[atmid][atmPosA], atmData[atmid][atmWorld], atmData[atmid][atmInterior]);
        atmData[atmid][atmText3D] = CreateDynamic3DTextLabel("ตู้ ATM: {FFFFFF}/atm\nในการใช้งาน", COLOR_GREEN, atmData[atmid][atmPosX], atmData[atmid][atmPosY], atmData[atmid][atmPosZ], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, atmData[atmid][atmWorld], atmData[atmid][atmInterior]);

		return 1;
	}
	return 0;
}

ATM_Save(atmid)
{
	new
	    query[200];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE `atm` SET `atmX` = '%.4f', `atmY` = '%.4f', `atmZ` = '%.4f', `atmA` = '%.4f', `atmInterior` = '%d', `atmWorld` = '%d' WHERE `atmID` = '%d'",
	    atmData[atmid][atmPosX],
	    atmData[atmid][atmPosY],
	    atmData[atmid][atmPosZ],
	    atmData[atmid][atmPosA],
	    atmData[atmid][atmInterior],
	    atmData[atmid][atmWorld],
	    atmData[atmid][atmID]
	);
	return mysql_tquery(g_SQL, query);
}


forward Entrance_Load();
public Entrance_Load()
{
    static
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_ENTRANCES)
	{
	    entranceData[i][entranceExists] = true;
    	cache_get_value_name_int(i, "entranceID", entranceData[i][entranceID]);

		cache_get_value_name(i, "entranceName", entranceData[i][entranceName], 32);
		cache_get_value_name_int(i, "entrancePass", entranceData[i][entrancePass]);

	    cache_get_value_name_int(i, "entranceIcon", entranceData[i][entranceIcon]);
	    cache_get_value_name_int(i, "entranceLocked", entranceData[i][entranceLocked]);
	    cache_get_value_name_float(i, "entrancePosX", entranceData[i][entrancePosX]);
	    cache_get_value_name_float(i, "entrancePosY", entranceData[i][entrancePosY]);
	    cache_get_value_name_float(i, "entrancePosZ", entranceData[i][entrancePosZ]);
	    cache_get_value_name_float(i, "entrancePosA", entranceData[i][entrancePosA]);
	    cache_get_value_name_float(i, "entranceIntX", entranceData[i][entranceIntX]);
	    cache_get_value_name_float(i, "entranceIntY", entranceData[i][entranceIntY]);
	    cache_get_value_name_float(i, "entranceIntZ", entranceData[i][entranceIntZ]);
	    cache_get_value_name_float(i, "entranceIntA", entranceData[i][entranceIntA]);
	    cache_get_value_name_int(i, "entranceInterior", entranceData[i][entranceInterior]);
	    cache_get_value_name_int(i, "entranceExterior", entranceData[i][entranceExterior]);
	    cache_get_value_name_int(i, "entranceExteriorVW", entranceData[i][entranceExteriorVW]);
	    cache_get_value_name_int(i, "entranceType", entranceData[i][entranceType]);
	    cache_get_value_name_int(i, "entranceWorld", entranceData[i][entranceWorld]);
	    cache_get_value_name_int(i, "entranceFaction", entranceData[i][entranceFaction]);

	    Entrance_Refresh(i);
	}
	printf("[SERVER]: %d Entrance were loaded from \"%s\" database...", rows, MYSQL_DATABASE);
	return 1;
}

Entrance_Delete(entranceid)
{
	if (entranceid != -1 && entranceData[entranceid][entranceExists])
	{
	    new
	        string[64];

		format(string, sizeof(string), "DELETE FROM `entrances` WHERE `entranceID` = '%d'", entranceData[entranceid][entranceID]);
		mysql_tquery(g_SQL, string);

        if (IsValidDynamic3DTextLabel(entranceData[entranceid][entranceText3D]))
		    DestroyDynamic3DTextLabel(entranceData[entranceid][entranceText3D]);

		if (IsValidDynamicPickup(entranceData[entranceid][entrancePickup]))
		    DestroyDynamicPickup(entranceData[entranceid][entrancePickup]);

		if (IsValidDynamicMapIcon(entranceData[entranceid][entranceMapIcon]))
		    DestroyDynamicMapIcon(entranceData[entranceid][entranceMapIcon]);

		if (IsValidDynamicPickup(entranceData[entranceid][entranceExPickup]))
		    DestroyDynamicPickup(entranceData[entranceid][entranceExPickup]);

        if (IsValidDynamic3DTextLabel(entranceData[entranceid][entranceExText3D]))
        	DestroyDynamic3DTextLabel(entranceData[entranceid][entranceExText3D]);

	    entranceData[entranceid][entranceExists] = false;
	    entranceData[entranceid][entranceID] = 0;
	}
	return 1;
}

Entrance_Save(entranceid)
{
	static
	    query[1024];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE `entrances` SET `entranceName` = '%e', `entrancePass` = '%d', `entranceIcon` = '%d', `entranceLocked` = '%d', `entrancePosX` = '%.4f', `entrancePosY` = '%.4f', `entrancePosZ` = '%.4f', `entrancePosA` = '%.4f', `entranceIntX` = '%.4f', `entranceIntY` = '%.4f', `entranceIntZ` = '%.4f', `entranceIntA` = '%.4f', `entranceInterior` = '%d', `entranceExterior` = '%d', `entranceExteriorVW` = '%d', `entranceType` = '%d'",
	    entranceData[entranceid][entranceName],
	    entranceData[entranceid][entrancePass],
	    entranceData[entranceid][entranceIcon],
	    entranceData[entranceid][entranceLocked],
	    entranceData[entranceid][entrancePosX],
	    entranceData[entranceid][entrancePosY],
	    entranceData[entranceid][entrancePosZ],
	    entranceData[entranceid][entrancePosA],
	    entranceData[entranceid][entranceIntX],
	    entranceData[entranceid][entranceIntY],
	    entranceData[entranceid][entranceIntZ],
	    entranceData[entranceid][entranceIntA],
	    entranceData[entranceid][entranceInterior],
	    entranceData[entranceid][entranceExterior],
	    entranceData[entranceid][entranceExteriorVW],
	    entranceData[entranceid][entranceType]
	);
	mysql_format(g_SQL, query, sizeof(query), "%s, `entranceWorld` = '%d', `entranceFaction` = '%d' WHERE `entranceID` = '%d'",
	    query,
	    entranceData[entranceid][entranceWorld],
	    entranceData[entranceid][entranceFaction],
	    entranceData[entranceid][entranceID]
	);
	return mysql_tquery(g_SQL, query);
}

Entrance_Inside(playerid)
{
	if (playerData[playerid][pEntrance] != -1)
	{
	    for (new i = 0; i != MAX_ENTRANCES; i ++) if (entranceData[i][entranceExists] && entranceData[i][entranceID] == playerData[playerid][pEntrance] && GetPlayerInterior(playerid) == entranceData[i][entranceInterior] && GetPlayerVirtualWorld(playerid) == entranceData[i][entranceWorld])
	        return i;
	}
	return -1;
}

Entrance_GetLink(playerid)
{
	if (GetPlayerVirtualWorld(playerid) > 0)
	{
	    for (new i = 0; i != MAX_ENTRANCES; i ++) if (entranceData[i][entranceExists] && entranceData[i][entranceID] == GetPlayerVirtualWorld(playerid) - 7000)
			return entranceData[i][entranceID];
	}
	return -1;
}

Entrance_Nearest(playerid)
{
    for (new i = 0; i != MAX_ENTRANCES; i ++) if (entranceData[i][entranceExists] && IsPlayerInRangeOfPoint(playerid, 2.5, entranceData[i][entrancePosX], entranceData[i][entrancePosY], entranceData[i][entrancePosZ]))
	{
		if (GetPlayerInterior(playerid) == entranceData[i][entranceExterior] && GetPlayerVirtualWorld(playerid) == entranceData[i][entranceExteriorVW])
			return i;
	}
	return -1;
}

Entrance_Refresh(entranceid)
{
	new string[128];
	if (entranceid != -1 && entranceData[entranceid][entranceExists])
	{
		if (IsValidDynamic3DTextLabel(entranceData[entranceid][entranceText3D]))
		    DestroyDynamic3DTextLabel(entranceData[entranceid][entranceText3D]);

		if (IsValidDynamicPickup(entranceData[entranceid][entrancePickup]))
		    DestroyDynamicPickup(entranceData[entranceid][entrancePickup]);

		if (IsValidDynamicMapIcon(entranceData[entranceid][entranceMapIcon]))
		    DestroyDynamicMapIcon(entranceData[entranceid][entranceMapIcon]);

        if (IsValidDynamicPickup(entranceData[entranceid][entranceExPickup]))
        	DestroyDynamicPickup(entranceData[entranceid][entranceExPickup]);

        if (IsValidDynamic3DTextLabel(entranceData[entranceid][entranceExText3D]))
        	DestroyDynamic3DTextLabel(entranceData[entranceid][entranceExText3D]);

		if (entranceData[entranceid][entranceIcon] != 0)
			entranceData[entranceid][entranceMapIcon] = CreateDynamicMapIcon(entranceData[entranceid][entrancePosX], entranceData[entranceid][entrancePosY], entranceData[entranceid][entrancePosZ], entranceData[entranceid][entranceIcon], 0, entranceData[entranceid][entranceExteriorVW], entranceData[entranceid][entranceExterior]);
		
		if(entranceData[entranceid][entranceLocked] == 0)
		{
			format(string, sizeof(string), "[id:%d | Entrance] {FFFFFF}:{00FF00} Opened\n{FFFFFF}%s\n{AFAFAF}'กด F เพื่อดำเนินการ'", entranceid, entranceData[entranceid][entranceName]);
			entranceData[entranceid][entranceText3D] = CreateDynamic3DTextLabel(string, COLOR_ORANGE, entranceData[entranceid][entrancePosX], entranceData[entranceid][entrancePosY], entranceData[entranceid][entrancePosZ]+0.3, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, entranceData[entranceid][entranceExteriorVW], entranceData[entranceid][entranceExterior]);
			entranceData[entranceid][entrancePickup] = CreateDynamicPickup(19198, 23, entranceData[entranceid][entrancePosX], entranceData[entranceid][entrancePosY], entranceData[entranceid][entrancePosZ]+0.5, entranceData[entranceid][entranceExteriorVW], entranceData[entranceid][entranceExterior]);

			/*format(string, sizeof(string), "[(id:%d)Exit] {FFFFFF}:{00FF00} Opened\n{FFFFFF}%s", entranceid, entranceData[entranceid][entranceName]);
			entranceData[entranceid][entranceExText3D] = CreateDynamic3DTextLabel(string, COLOR_ORANGE, entranceData[entranceid][entranceIntX], entranceData[entranceid][entranceIntY], entranceData[entranceid][entranceIntZ]+0.3, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, entranceData[entranceid][entranceWorld], entranceData[entranceid][entranceInterior]);*/
			entranceData[entranceid][entranceExPickup] = CreateDynamicPickup(19198, 23, entranceData[entranceid][entranceIntX], entranceData[entranceid][entranceIntY], entranceData[entranceid][entranceIntZ]+0.5, entranceData[entranceid][entranceWorld], entranceData[entranceid][entranceInterior]);	
			return 1;
		}
		if(entranceData[entranceid][entranceLocked] == 1)
		{
			format(string, sizeof(string), "[id:%d | Entrance] {FFFFFF}:{FF0000} Closed\n{FFFFFF}%s\n{AFAFAF}'กด F เพื่อดำเนินการ'", entranceid, entranceData[entranceid][entranceName]);
			entranceData[entranceid][entranceText3D] = CreateDynamic3DTextLabel(string, COLOR_ORANGE, entranceData[entranceid][entrancePosX], entranceData[entranceid][entrancePosY], entranceData[entranceid][entrancePosZ]+0.3, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, entranceData[entranceid][entranceExteriorVW], entranceData[entranceid][entranceExterior]);
			entranceData[entranceid][entrancePickup] = CreateDynamicPickup(19198, 23, entranceData[entranceid][entrancePosX], entranceData[entranceid][entrancePosY], entranceData[entranceid][entrancePosZ]+0.5, entranceData[entranceid][entranceExteriorVW], entranceData[entranceid][entranceExterior]);

			/*format(string, sizeof(string), "[(id:%d)Exit] {FFFFFF}:{FF0000} Closed\n{FFFFFF}%s", entranceid, entranceData[entranceid][entranceName]);
			entranceData[entranceid][entranceExText3D] = CreateDynamic3DTextLabel(string, COLOR_ORANGE, entranceData[entranceid][entranceIntX], entranceData[entranceid][entranceIntY], entranceData[entranceid][entranceIntZ]+0.3, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, entranceData[entranceid][entranceWorld], entranceData[entranceid][entranceInterior]);*/
			entranceData[entranceid][entranceExPickup] = CreateDynamicPickup(19198, 23, entranceData[entranceid][entranceIntX], entranceData[entranceid][entranceIntY], entranceData[entranceid][entranceIntZ]+0.5, entranceData[entranceid][entranceWorld], entranceData[entranceid][entranceInterior]);	
			return 1;
		}
	}
	return 1;
}

Entrance_Create(playerid, const name[])
{
	static
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;

    if (GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
	{
		for (new i = 0; i != MAX_ENTRANCES; i ++)
		{
	    	if (!entranceData[i][entranceExists])
		    {
    	        entranceData[i][entranceExists] = true;
        	    entranceData[i][entranceIcon] = 0;
        	    entranceData[i][entranceType] = 0;
        	    entranceData[i][entranceLocked] = 0;

				format(entranceData[i][entranceName], 32, name);
				entranceData[i][entrancePass] = 0;

    	        entranceData[i][entrancePosX] = x;
    	        entranceData[i][entrancePosY] = y;
    	        entranceData[i][entrancePosZ] = z;
    	        entranceData[i][entrancePosA] = angle;

                entranceData[i][entranceIntX] = x;
                entranceData[i][entranceIntY] = y;
                entranceData[i][entranceIntZ] = z + 10000;
                entranceData[i][entranceIntA] = 0.0000;

				entranceData[i][entranceInterior] = 0;
				entranceData[i][entranceExterior] = GetPlayerInterior(playerid);
				entranceData[i][entranceExteriorVW] = GetPlayerVirtualWorld(playerid);
				entranceData[i][entranceFaction] = -1;

				Entrance_Refresh(i);
				mysql_tquery(g_SQL, "INSERT INTO `entrances` (`entranceType`) VALUES(0)", "OnEntranceCreated", "d", i);
				return i;
			}
		}
	}
	return -1;
}

forward OnEntranceCreated(entranceid);
public OnEntranceCreated(entranceid)
{
	if (entranceid == -1 || !entranceData[entranceid][entranceExists])
	    return 0;

	entranceData[entranceid][entranceID] = cache_insert_id();
	entranceData[entranceid][entranceWorld] = entranceData[entranceid][entranceID] + 7000;

	Entrance_Save(entranceid);

	return 1;
}


Dialog:DIALOG_SPAWNCAR(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM vehicles WHERE carOwnerID = %d LIMIT %d, 1", playerData[playerid][pID], listitem);
		mysql_tquery(g_SQL, query, "OnPlayerSpawnVehicle", "ii", playerid, false);
	


	}
	return 1;
}
Dialog:DIALOG_DESPAWNCAR(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new count;

		for(new i = 1; i < MAX_VEHICLES; i ++)
		{
			if((carData[i][carID] > 0 && IsVehicleOwner(playerid, i)) && (count++ == listitem))
   			{
				if(IsVehicleOccupied(i) && GetVehicleDriver(i) != playerid)
				{
					return SendClientMessage(playerid, COLOR_LIGHTRED, "- ยานพาหนะของคุณยังคงถูกใช้บานอยู่");
				}
				SendClientMessageEx(playerid, COLOR_YELLOW, "[Spawn Vehicle]: คุณได้จัดเก็บยานพาหนะ '%s' เรียบร้อย", ReturnVehicleName(i));
				KillTimer(playerData[playerid][pSpeedoTimer]);
				DespawnVehicle(i);
				return 1;
			}
		}
	}
	return 1;
}

Dialog:DIALOG_FINDCAR(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new count;

		for(new i = 1; i < MAX_VEHICLES; i ++)
		{
			if((carData[i][carID] > 0 && IsVehicleOwner(playerid, i)) && (count++ == listitem))
			{
				new
					Float:x,
					Float:y,
					Float:z;

				GetVehiclePos(i, x, y, z);
				SetPlayerCheckpoint(playerid, x, y, z, 3.0);
				SendClientMessageEx(playerid, COLOR_YELLOW, "** ระบบ GPS ได้สร้างจุดแดงบน Minimap ให้คุณติดตามแล้ว", ReturnVehicleName(i));

				return 1;
			}
		}
	}
	return 1;
}

Dialog:DIALOG_VEHICLELOOKUP1(playerid, response, listitem, inputtext[])
{
	if((response) && GetFactionType(playerid) == FACTION_POLICE)
	{
		new vehicleid, string[512];

		if(sscanf(inputtext, "d", vehicleid))
		{
			return Dialog_Show(playerid, DIALOG_VEHICLELOOKUP1, DIALOG_STYLE_INPUT, "[เครื่องติดตามยานพาหนะ]", "ใส่ไอดียานพาหนะที่ต้องการจะติดตาม\n(( ดูไอดีได้โดยการพิมพ์ /dl ))", "ตกลง", "ยกเลิก");
		}
		if(!IsValidVehicle(vehicleid) || !carData[vehicleid][carOwnerID])
		{
			SendClientMessage(playerid, COLOR_RED, "- ต้องเป็นรถส่วนตัวเท่านั้น");
			return Dialog_Show(playerid, DIALOG_VEHICLELOOKUP1, DIALOG_STYLE_INPUT, "[เครื่องติดตามยานพาหนะ]", "ใส่ไอดียานพาหนะที่ต้องการจะติดตาม\n(( ดูไอดีได้โดยการพิมพ์ /dl ))", "ตกลง", "ยกเลิก");
		}

		playerData[playerid][pSelectedSlot] = vehicleid;

		format(string, sizeof(string), "ชื่อรุ่น: %s\nเจ้าของ: %s\nใบสั่ง: %s", ReturnVehicleName(vehicleid), carData[vehicleid][carOwner], FormatMoney(carData[vehicleid][carTickets]));
		Dialog_Show(playerid, DIALOG_VEHICLELOOKUP2, DIALOG_STYLE_MSGBOX, "[เครื่องติดตามยานพาหนะ]", string, "ติดตาม", "ปิด");
	}
	return 1;
}
Dialog:DIALOG_VEHICLELOOKUP2(playerid, response, listitem, inputtext[])
{
	if((response) && GetFactionType(playerid) == FACTION_POLICE)
	{
		new vehicleid = playerData[playerid][pSelectedSlot];
		new
			Float:x,
			Float:y,
			Float:z;

		SendClientMessage(playerid, COLOR_WHITE, "** ระบบนำทางได้ติดตั้งไว้บนแผนที่แล้ว ตามจุดสีแดงไป");

		GetVehiclePos(vehicleid, x, y, z);
		SetPlayerCheckpoint(playerid, x, y, z, 3.0);
	}
	return 1;
}

Dialog:DIALOG_BANKACCOUNT(playerid, response, listitem, inputtext[])
{
	if (!IsPlayerInBank(playerid) && ATM_Nearest(playerid) == -1)
	    return 0;

	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
				Dialog_Show(playerid, DIALOG_WITHDRAW, DIALOG_STYLE_INPUT, "[ถอนเงิน]", "{FFFFFF}ยอดเงินในบัญชี: %s\nกรุณาใส่จำนวนเงินที่คุณต้องการจะถอน", "ถอน", "กลับ", FormatMoney(playerData[playerid][pBankMoney]));
			}
	        case 1:
	        {
				Dialog_Show(playerid, DIALOG_DEPOSIT, DIALOG_STYLE_INPUT, "[ฝากเงิน]", "{FFFFFF}ยอดเงินในบัญชี: %s\nกรุณาใส่จำนวนเงินที่คุณต้องการจะฝาก", "ฝาก", "กลับ", FormatMoney(playerData[playerid][pBankMoney]));
			}
			case 2:
			{
			    Dialog_Show(playerid, DIALOG_TRANSFER, DIALOG_STYLE_INPUT, "[โอนเงิน]", "{FFFFFF}ยอดเงินในบัญชี: %s\nกรุณาใส่ไอดีหรือชื่อผู้รับเงิน", "โอน", "กลับ", FormatMoney(playerData[playerid][pBankMoney]));
			}
	    }
	}
	else
	{
	    Dialog_Show(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, "[บัญชีธนาคาร]", "ยอดเงินปัจจุบัน: %s", "เลือก", "ปิด", FormatMoney(playerData[playerid][pBankMoney]));
	}
	return 1;
}

Dialog:DIALOG_TRANSFER(playerid, response, listitem, inputtext[])
{
	if (!IsPlayerInBank(playerid) && ATM_Nearest(playerid) == -1)
	    return 0;

	if (response)
	{
	    static
	        userid;

		if (playerData[playerid][pHours] < 15)
		    return SendClientMessage(playerid, COLOR_RED, "- คุณจำเป็นต้องมีชั่วโมงการเล่นมากกว่า 15 ขึ้นไป");

		if (sscanf(inputtext, "u", userid))
		    return Dialog_Show(playerid, DIALOG_TRANSFER, DIALOG_STYLE_INPUT, "[โอนเงิน]", "{FFFFFF}ยอดเงินในบัญชี: %s\nกรุณาใส่ไอดีหรือชื่อผู้รับเงิน", "โอน", "กลับ", FormatMoney(playerData[playerid][pBankMoney]));

		if (userid == INVALID_PLAYER_ID)
		    return Dialog_Show(playerid, DIALOG_TRANSFER, DIALOG_STYLE_INPUT, "[โอนเงิน]", "{FFFFFF}ยอดเงินในบัญชี: %s\nกรุณาใส่ไอดีหรือชื่อผู้รับเงิน\n\n{FF0000}*** ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม", "โอน", "กลับ", FormatMoney(playerData[playerid][pBankMoney]));

		if (userid == playerid)
		    return Dialog_Show(playerid, DIALOG_TRANSFER, DIALOG_STYLE_INPUT, "[โอนเงิน]", "{FFFFFF}ยอดเงินในบัญชี: %s\nกรุณาใส่ไอดีหรือชื่อผู้รับเงิน\n\n{FF0000}*** โอนเงินเข้าบัญชีตัวเองไม่ได้", "โอน", "กลับ", FormatMoney(playerData[playerid][pBankMoney]));

		playerData[playerid][pTransfer] = userid;
		Dialog_Show(playerid, DIALOG_TRANSFERCASH, DIALOG_STYLE_INPUT, "[โอนเงิน]", "{FFFFFF}ยอดเงินในบัญชี: %s\nกรุณาใส่จำนวนเงินที่คุณต้องการจะโอนให้กับ %s", "โอน", "กลับ", FormatMoney(playerData[playerid][pBankMoney]), GetPlayerNameEx(userid));
	}
    else {
	    Dialog_Show(playerid, DIALOG_BANKACCOUNT, DIALOG_STYLE_LIST, "[บัญชีธนาคาร]", "ถอนเงิน\nฝากเงิน\nโอนเงิน", "เลือก", "กลับ");
	}
	return 1;
}

Dialog:DIALOG_TRANSFERCASH(playerid, response, listitem, inputtext[])
{
	if (!IsPlayerInBank(playerid) && ATM_Nearest(playerid) == -1)
	    return 0;

	if (response)
	{
	    new amount = strval(inputtext);

	    if (isnull(inputtext))
	        return Dialog_Show(playerid, DIALOG_TRANSFERCASH, DIALOG_STYLE_INPUT, "[โอนเงิน]", "{FFFFFF}ยอดเงินในบัญชี: %s\nกรุณาใส่จำนวนเงินที่คุณต้องการจะโอนให้กับ %s", "โอน", "กลับ", FormatMoney(playerData[playerid][pBankMoney]), GetPlayerNameEx(playerData[playerid][pTransfer]));

		if (amount < 1 || amount > playerData[playerid][pBankMoney])
			return Dialog_Show(playerid, DIALOG_TRANSFERCASH, DIALOG_STYLE_INPUT, "[โอนเงิน]", "{FFFFFF}ยอดเงินในบัญชี: %s\nกรุณาใส่จำนวนเงินที่คุณต้องการจะโอนให้กับ %s\n\n{FF0000}*** เงินในบัญชีของคุณไม่พอที่จะโอน", "โอน", "กลับ", FormatMoney(playerData[playerid][pBankMoney]), GetPlayerNameEx(playerData[playerid][pTransfer]));

		playerData[playerid][pBankMoney] -= amount;
		playerData[playerData[playerid][pTransfer]][pBankMoney] += amount;

	    SendClientMessageEx(playerid, COLOR_YELLOW, "[ธนาคาร] {FFFFFF}คุณได้โอนเงินจำนวน %s ให้กับ %s สำเร็จ", FormatMoney(amount), GetPlayerNameEx(playerData[playerid][pTransfer]));
	    SendClientMessageEx(playerData[playerid][pTransfer], COLOR_YELLOW, "[ธนาคาร] {FFFFFF}ผู้เล่น %s ได้โอนเงินให้คุณจำนวน %s สำเร็จ", GetPlayerNameEx(playerid), FormatMoney(amount));

        Dialog_Show(playerid, DIALOG_BANKACCOUNT, DIALOG_STYLE_LIST, "[บัญชีธนาคาร]", "ถอนเงิน\nฝากเงิน\nโอนเงิน", "เลือก", "กลับ");
	}
	else {
	    Dialog_Show(playerid, DIALOG_BANKACCOUNT, DIALOG_STYLE_LIST, "[บัญชีธนาคาร]", "ถอนเงิน\nฝากเงิน\nโอนเงิน", "เลือก", "กลับ");
	}
	return 1;
}

Dialog:DIALOG_WITHDRAW(playerid, response, listitem, inputtext[])
{
	if (!IsPlayerInBank(playerid) && ATM_Nearest(playerid) == -1)
	    return 0;

	if (response)
	{
	    new amount = strval(inputtext);

	    if (isnull(inputtext))
	        return Dialog_Show(playerid, DIALOG_WITHDRAW, DIALOG_STYLE_INPUT, "[ถอนเงิน]", "{FFFFFF}ยอดเงินในบัญชี: %s\nกรุณาใส่จำนวนเงินที่คุณต้องการจะถอน", "ถอน", "กลับ", FormatMoney(playerData[playerid][pBankMoney]));

		if (amount < 1 || amount > playerData[playerid][pBankMoney])
			return Dialog_Show(playerid, DIALOG_WITHDRAW, DIALOG_STYLE_INPUT, "[ถอนเงิน]", "{FFFFFF}ยอดเงินในบัญชี: %s\nกรุณาใส่จำนวนเงินที่คุณต้องการจะถอน\n\n{FF0000}*** ยอดเงินที่คุณต้องการจะถอนไม่เพียงพอ", "ถอน", "กลับ", FormatMoney(playerData[playerid][pBankMoney]));

		playerData[playerid][pBankMoney] -= amount;
	    GivePlayerMoneyEx(playerid, amount);

	    SendClientMessageEx(playerid, COLOR_YELLOW, "[ธนาคาร] {FFFFFF}คุณได้ถอนเงินจำนวน %s ออกจากบัญชีสำเร็จ", FormatMoney(amount));
        Dialog_Show(playerid, DIALOG_WITHDRAW, DIALOG_STYLE_INPUT, "[ถอนเงิน]", "{FFFFFF}ยอดเงินในบัญชี: %s\nกรุณาใส่จำนวนเงินที่คุณต้องการจะถอน", "ถอน", "กลับ", FormatMoney(playerData[playerid][pBankMoney]));
	}
	else {
	    Dialog_Show(playerid, DIALOG_BANKACCOUNT, DIALOG_STYLE_LIST, "[บัญชีธนาคาร]", "ถอนเงิน\nฝากเงิน\nโอนเงิน", "เลือก", "กลับ");
	}
	return 1;
}

Dialog:DIALOG_DEPOSIT(playerid, response, listitem, inputtext[])
{
	if (!IsPlayerInBank(playerid) && ATM_Nearest(playerid) == -1)
	    return 0;

	if (response)
	{
	    new amount = strval(inputtext);

	    if (isnull(inputtext))
	        return Dialog_Show(playerid, DIALOG_DEPOSIT, DIALOG_STYLE_INPUT, "[ฝากเงิน]", "{FFFFFF}ยอดเงินในบัญชี: %s\nกรุณาใส่จำนวนเงินที่คุณต้องการจะฝาก", "ฝาก", "กลับ", FormatMoney(playerData[playerid][pBankMoney]));

		if (amount < 1 || amount > GetPlayerMoneyEx(playerid))
			return Dialog_Show(playerid, DIALOG_DEPOSIT, DIALOG_STYLE_INPUT, "[ฝากเงิน]", "{FFFFFF}ยอดเงินในบัญชี: %s\nกรุณาใส่จำนวนเงินที่คุณต้องการจะฝาก\n\n{FF0000}*** ยอดเงินที่คุณต้องการจะฝากไม่เพียงพอ", "ฝาก", "กลับ", FormatMoney(playerData[playerid][pBankMoney]));

		playerData[playerid][pBankMoney] += amount;
	    GivePlayerMoneyEx(playerid, -amount);

	    SendClientMessageEx(playerid, COLOR_YELLOW, "[ธนาคาร] {FFFFFF}คุณได้ฝากเงินจำนวน %s เข้าธนาคารสำเร็จ", FormatMoney(amount));
        Dialog_Show(playerid, DIALOG_DEPOSIT, DIALOG_STYLE_INPUT, "[ฝากเงิน]", "{FFFFFF}ยอดเงินในบัญชี: %s\nกรุณาใส่จำนวนเงินที่คุณต้องการจะฝาก", "ฝาก", "กลับ", FormatMoney(playerData[playerid][pBankMoney]));
	}
	else {
	    Dialog_Show(playerid, DIALOG_BANKACCOUNT, DIALOG_STYLE_LIST, "[บัญชีธนาคาร]", "ถอนเงิน\nฝากเงิน\nโอนเงิน", "เลือก", "กลับ");
	}
	return 1;
}

Dialog:DIALOG_BANK(playerid, response, listitem, inputtext[])
{
	if (!IsPlayerInBank(playerid) && ATM_Nearest(playerid) == -1)
	    return 0;

	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
				Dialog_Show(playerid, DIALOG_BANKACCOUNT, DIALOG_STYLE_LIST, "[บัญชีธนาคาร]", "ถอนเงิน\nฝากเงิน\nโอนเงิน", "เลือก", "กลับ");
			}
		}
	}
	return 1;
}

Dialog:DIALOG_ENTERNUMBER(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    static
	        name[32],
			string[128];

		strunpack(name, playerData[playerid][pEditingItem]);

	    if (isnull(inputtext) || !IsNumeric(inputtext))
	        return Dialog_Show(playerid, DIALOG_ENTERNUMBER, DIALOG_STYLE_INPUT, "[Add Contact]", "{FFFFFF}ชื่อ: {FFA84D}%s{FFFFFF}\nโปรดระบุ 'เบอร์มือถือ' ที่คุณต้องการจะบันทึกลงเบอร์ติดต่อ", "ตกลง", "กลับ", name);

		for (new i = 0; i != MAX_CONTACTS; i ++)
		{
			if (!contactData[playerid][i][contactExists])
			{
            	contactData[playerid][i][contactExists] = true;
            	contactData[playerid][i][contactNumber] = strval(inputtext);

				format(contactData[playerid][i][contactName], 32, name);

				mysql_format(g_SQL, string, sizeof(string), "INSERT INTO `contacts` (`ID`, `contactName`, `contactNumber`) VALUES ('%d', '%e', '%d')", playerData[playerid][pID], name, contactData[playerid][i][contactNumber]);
				mysql_tquery(g_SQL, string, "OnContactAdd", "dd", playerid, i);

				SendClientMessageEx(playerid, COLOR_YELLOW, "[Phone]: คุณได้เพิ่ม \"{FFA84D}%s{FFFFFF}\" ลงในรายชื่อผู้ติดต่อ", name);
                return 1;
			}
	    }
	    SendClientMessage(playerid, COLOR_LIGHTRED, "- รายชื่อผู้ติดต่อของคุณเต็มแล้ว");
	}
	else {
		ShowContacts(playerid);
	}
	return 1;
}

Dialog:DIALOG_NEWCONTACTS(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext))
			return Dialog_Show(playerid, DIALOG_NEWCONTACTS, DIALOG_STYLE_INPUT, "[Add Contact]", "{FFFFFF}โปรดระบุ {FFA84D}'ชื่อ'{FFFFFF} ที่คุณต้องการจะบันทึกลงเบอร์ติดต่อ", "ตกลง", "กลับ");

	    if (strlen(inputtext) > 32)
	        return Dialog_Show(playerid, DIALOG_NEWCONTACTS, DIALOG_STYLE_INPUT, "[Add Contact]", "{FFFFFF}โปรดระบุ {FFA84D}'ชื่อ'{FFFFFF} ที่คุณต้องการจะบันทึกลงเบอร์ติดต่อ\n{FF6347}*จำนวนตัวอักษรจะต้องไม่เกิน 32 ตัว", "ตกลง", "กลับ");

		strpack(playerData[playerid][pEditingItem], inputtext, 32);

	    Dialog_Show(playerid, DIALOG_ENTERNUMBER, DIALOG_STYLE_INPUT, "[Add Contact]", "{FFFFFF}ชื่อ: {FFA84D}%s{FFFFFF}\nโปรดระบุ 'เบอร์มือถือ' ที่คุณต้องการจะบันทึกลงเบอร์ติดต่อ", "ตกลง", "กลับ", inputtext);
	}
	else {
		ShowContacts(playerid);
	}
	return 1;
}




Dialog:DIALOG_DIALNUMBER(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new
	        string[16];

	    if (isnull(inputtext) || !IsNumeric(inputtext))
	        return Dialog_Show(playerid, DIALOG_DIALNUMBER, DIALOG_STYLE_INPUT, "[หมายเลขที่ต้องการโทร]", "{FFFFFF}ใส่หมายเลขที่ต้องการจะติดต่อ", "โทร", "กลับ");

        format(string, 16, "%d", strval(inputtext));
		
	}
	else {
		
	}
	return 1;
}

Dialog:DIALOG_SENDTEXT(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new number = strval(inputtext);

	    if (isnull(inputtext) || !IsNumeric(inputtext))
	        return Dialog_Show(playerid, DIALOG_SENDTEXT, DIALOG_STYLE_INPUT, "[ส่งข้อความ]", "{FFFFFF}ใส่หมายเลขที่ต้องการจะส่งข้อความ", "โทร", "กลับ");

        if (GetNumberOwner(number) == INVALID_PLAYER_ID)
            return Dialog_Show(playerid, DIALOG_SENDTEXT, DIALOG_STYLE_INPUT, "[ส่งข้อความ]", "{FFFFFF}ใส่หมายเลขที่ต้องการจะส่งข้อความ\n{FF0000}*** เบอร์นี้ไม่ได้ออนไลน์อยู่", "โทร", "กลับ");

		playerData[playerid][pContact] = GetNumberOwner(number);
		Dialog_Show(playerid, DIALOG_TEXTMESSAGE, DIALOG_STYLE_INPUT, "[ส่งข้อความ]", "{FFFFFF}ใส่ข้อความที่คุณต้องการจะส่งหา %s", "ส่ง", "กลับ", GetPlayerNameEx(playerData[playerid][pContact]));
	}
	else {
		
	}
	return 1;
}

Dialog:DIALOG_TEXTMESSAGE(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		if (isnull(inputtext))
			return Dialog_Show(playerid, DIALOG_TEXTMESSAGE, DIALOG_STYLE_INPUT, "[ส่งข้อความ]", "{FFFFFF}ใส่ข้อความที่คุณต้องการจะส่งหา %s", "ส่ง", "กลับ", GetPlayerNameEx(playerData[playerid][pContact]));

		new targetid = playerData[playerid][pContact];

		if (!IsPlayerConnected(targetid) || !playerData[targetid][pPhone])
		    return SendClientMessage(playerid, COLOR_RED, "- หมายเลขที่ระบุไม่ถูกต้อง/ออฟไลน์");

		GivePlayerMoneyEx(playerid, -1);
		GameTextForPlayer(playerid, "You've been ~r~charged~w~ $1 to send a text.", 5000, 1);

		SendClientMessageEx(targetid, COLOR_YELLOW, "[ข้อความ]: %s - %s (%d)", inputtext, GetPlayerNameEx(playerid), playerData[playerid][pPhone]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "[ข้อความ]: %s - %s (%d)", inputtext, GetPlayerNameEx(playerid), playerData[playerid][pPhone]);

        PlayerPlaySoundEx(targetid, 21001);
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้หยิบมือถือขึ้นมาและกดส่งข้อความ", GetPlayerNameEx(playerid));
	}
	else {
        Dialog_Show(playerid, DIALOG_SENDTEXT, DIALOG_STYLE_INPUT, "[ส่งข้อความ]", "{FFFFFF}ใส่หมายเลขที่ต้องการจะส่งข้อความ", "โทร", "กลับ");
	}
	return 1;
}

Dialog:DIALOG_TELEPORT(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    SetPlayerInterior(playerid, g_arrInteriorData[listitem][e_InteriorID]);
	    SetPlayerPos(playerid, g_arrInteriorData[listitem][e_InteriorX], g_arrInteriorData[listitem][e_InteriorY], g_arrInteriorData[listitem][e_InteriorZ]);
	}
	return 1;
}

Dialog:DIALOG_ENTRANCEPASS(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new id = (Entrance_Inside(playerid) == -1) ? (Entrance_Nearest(playerid)) : (Entrance_Inside(playerid));
		new password;

		if (id == -1)
		    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ได้อยู่ใกล้กับประตูใด ๆ");

		if (sscanf(inputtext, "d", password))
			return Dialog_Show(playerid, DIALOG_ENTRANCEPASS, DIALOG_STYLE_INPUT, "[รหัสผ่านประตู]", "รหัสผ่านต้องเป็นตัวเลขเท่านั้น!\nใส่รหัสผ่านให้ประตูเพื่อความปลอดภัย:", "ยืนยัน", "ออก");

		if (entranceData[id][entrancePass] != password)
            return SendClientMessage(playerid, COLOR_RED, "- รหัสผ่านไม่ถูกต้อง");

	    if (!entranceData[id][entranceLocked])
		{
			entranceData[id][entranceLocked] = true;
			Entrance_Save(id);

			GameTextForPlayer(playerid, "You have ~r~locked~w~ the entrance!", 5000, 1);
			PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
		}
		else
		{
			entranceData[id][entranceLocked] = false;
			Entrance_Save(id);

			GameTextForPlayer(playerid, "You have ~g~unlocked~w~ the entrance!", 5000, 1);
			PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
		}
	}
	return 1;
}

forward OnQueryFinished(playerid, threadid);
public OnQueryFinished(playerid, threadid)
{
	if (!IsPlayerConnected(playerid))
	    return 0;

	static
		rows;

	cache_get_row_count(rows);

	switch (threadid)
	{
    	case THREAD_LOGIN:
   		{
    	    if (!rows)
    	    {
				playerData[playerid][LoginAttempts]++;
				if (playerData[playerid][LoginAttempts] >= 3)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "[ตัดการเชื่อมต่อ] เนื่องจาก: คุณใส่รหัสผิดเกิน 3 ครั้ง!");
					DelayedKick(playerid);
				}
				else
				{
					ShowDialog_Login(playerid);
				}
			}
			else
			{
				AssignplayerData(playerid);


				if (playerData[playerid][pBan] == 1)
				{
					SendClientMessage(playerid, COLOR_RED, "ไอดีนี้ไม่สามารถเข้าเล่นในเซิร์ฟเวอร์นี้ได้เพราะถูกแบน!");
					SendClientMessageEx(playerid, COLOR_WHITE, "ชื่อตัวละคร: %s", GetPlayerNameEx(playerid));
					SendClientMessageEx(playerid, COLOR_WHITE, "สาเหตุการโดนแบน: %s", playerData[playerid][pBanReason]);
					DelayedKick(playerid);
					return 1;
			
				}
				if(playerData[playerid][pTutorial] == 0)
				{
					SetPlayerLoginScreen(playerid);
				}
				else
				{
					SetPlayerColor(playerid, DEFAULT_COLOR);
					Spawnplayer(playerid);
				}				
			}
		}
		case THREAD_LIST_VEHICLES:
		{
		    if(!rows)
		    {
		        return 1;
		    }
		    else
		    {
		        new string[1024],
					modelid,
					Float:fuel;

		        string = "รายการยานพาหนะ\tสถานะ";

		        for(new i = 0; i < rows; i ++)
		        {
					cache_get_value_name_int(i, "carModel", modelid);
					cache_get_value_name_float(i, "carFuel", fuel);
		            format(string, sizeof(string), "%s\n%s\t(%.2f) ลิตร", string, g_arrVehicleNames[modelid - 400], fuel);
				}

				Dialog_Show(playerid, DIALOG_SPAWNCAR, DIALOG_STYLE_TABLIST_HEADERS, "Spawn Vehicles", string, "เรียก", "ปิด");
		    }
		}
		case THREAD_LIST_CAR_DESTROY:
		{
		    if(!rows)
		    {
				return 1;
		        //ErrorMsg(playerid, "ไม่พบรถในการาจของคุณที่ต้องการพาวรถ!");
		    }
		    else
		    {
		        new string[1024],
					modelid;

		        string = "รายการ\tสถานะ";

		        for(new i = 0; i < rows; i ++)
		        {
					cache_get_value_name_int(i, "carModel", modelid);
		            format(string, sizeof(string), "%s\n{FFFFFF}%s\t{FF0000}(เสียหาย)", string, g_arrVehicleNames[modelid - 400]);
				}
				Dialog_Show(playerid, DIALOG_CAR_DESTROY, DIALOG_STYLE_TABLIST_HEADERS, "กู้ซากยานพาหนะ", string, "ตกลง", "ยกเลิก");
		    }
		}
	}
	return 1;
}

SQL_AttemptLogin(playerid, const password[])
{
	new
		query[300],
		buffer[129];

	WP_Hash(buffer, sizeof(buffer), password);

	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` WHERE `playerName` = '%e' AND `playerPassword` = '%e'", GetPlayerNameEx(playerid), buffer);
	mysql_tquery(g_SQL, query, "OnQueryFinished", "dd", playerid, THREAD_LOGIN);
}


/*
Dialog:DIALOG_TUTORIAL(playerid, response, listitem, inputtext[])
{
    if (!response)
	{
	    Dialog_Show(playerid, DIALOG_TUTORIALCONFIRM3, DIALOG_STYLE_MSGBOX, "[ยืนยันการออกเกม]", "{FFFFFF}คุณยืนยันที่จะออกจากเกมใช่ไหม?\n{00FF00}** หมายเหตุ: หากคุณยังให้ข้อมูลไม่ครบคุณสามารถกลับมาแก้ไขได้ใหม่ในการเข้าเล่นครั้งต่อไป!", "ยืนยัน", "กลับ");
	}
    else
	{
		switch(listitem)
		{
			case 0:
			{
				ShowDialog_Tutorial(playerid);
			}
			case 1:
			{
				ShowDialog_Tutorial(playerid);
			}
			case 2:
			{
				ShowDialog_Tutorial(playerid);
			}
			case 3: Dialog_Show(playerid, DIALOG_TUTORIALGENDER, DIALOG_STYLE_LIST, "[ข้อมูลตัวละคร]", "ชาย\nหญิง", "แก้ไข", "กลับ");
			case 4: Dialog_Show(playerid, DIALOG_TUTORIALBIRTHDAY, DIALOG_STYLE_INPUT, "[ข้อมูลตัวละคร]", "{FFFFFF}ใส่วันเดือนปีเกิด {FF0000}ตัวอย่าง: 1/1/1991", "แก้ไข", "กลับ");
			case 5:
			{
				static const aGender[3][10] = {"แก้ไข", "ชาย", "หญิง"};
				new string[400];
				if(playerData[playerid][pGender] == 0)
				{
					Dialog_Show(playerid, DIALOG_TUTORIALCONFIRM2, DIALOG_STYLE_MSGBOX, "[ข้อมูลตัวละคร]", "{FFFFFF}เกิดข้อผิดพลาดจากระบบ...\n{FF0000}** คุณยังไม่ได้แก้ไขเพศตัวละคร!", "กลับ", "");
					return 1;
				}
				if(!strcmp(playerData[playerid][pBirthday], "แก้ไข", true))
				{
					Dialog_Show(playerid, DIALOG_TUTORIALCONFIRM2, DIALOG_STYLE_MSGBOX, "[ข้อมูลตัวละคร]", "{FFFFFF}เกิดข้อผิดพลาดจากระบบ...\n{FF0000}** คุณยังไม่ได้แก้ไขวันเดือนปีเกิดตัวละคร!", "กลับ", "");
					return 1;
				}
				format(string, sizeof(string), "\
					{FFFFFF}คุณต้องการที่จะยืนยันจริง ๆ ใช่ไหม?\n\
					{FF0000}*** คุณไม่สามารถกลับไปแก้ไขข้อมูลเหล่านี้ได้อีก หากคุณกดยืนยัน!\n\n\
					{FFFFFF}ลำดับไอดี:\t{00FF00}%d\n\
					{FFFFFF}วันที่ลงทะเบียน:\t{00FF00}%s\n\
					{FFFFFF}ชื่อ:\t\t\t{00FF00}%s\n\
					{FFFFFF}เพศ:\t\t\t{00FF00}%s\n\
					{FFFFFF}วันเดือนปีเกิด:\t{00FF00}%s",
				playerData[playerid][pID], playerData[playerid][pRegisterDate], GetPlayerNameEx(playerid), aGender[playerData[playerid][pGender]], playerData[playerid][pBirthday]);
				Dialog_Show(playerid, DIALOG_TUTORIALCONFIRM, DIALOG_STYLE_MSGBOX, "[ข้อมูลตัวละคร]", string, "ยืนยัน", "กลับ");
			}
		}
	}
	return 1;
}

Dialog:DIALOG_TUTORIALGENDER(playerid, response, listitem, inputtext[])
{
    if (!response)
    {
		ShowDialog_Tutorial(playerid);
    }
	else
	{
		switch(listitem)
		{
			case 0:
			{
				playerData[playerid][pGender] = 1;
				ShowDialog_Tutorial(playerid);
			}
			case 1:
			{
				playerData[playerid][pGender] = 2;
				ShowDialog_Tutorial(playerid);
			}
		}
	}
	return 1;
}

Dialog:DIALOG_TUTORIALBIRTHDAY(playerid, response, listitem, inputtext[])
{
    if (!response)
    {
		ShowDialog_Tutorial(playerid);
    }
	else
	{
		new
			iDay,
			iMonth,
			iYear;

		static const
			arrMonthDays[] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

		if (sscanf(inputtext, "p</>ddd", iDay, iMonth, iYear))
		{
			Dialog_Show(playerid, DIALOG_TUTORIALBIRTHDAY, DIALOG_STYLE_INPUT, "[ข้อมูลตัวละคร]", "{FFFFFF}ใส่วันเดือนปีเกิด {FF0000}ตัวอย่าง: 1/1/1991", "แก้ไข", "กลับ");
		}
		else if (iYear < 1900 || iYear > 2019)
		{
			Dialog_Show(playerid, DIALOG_TUTORIALBIRTHDAY, DIALOG_STYLE_INPUT, "[ข้อมูลตัวละคร]", "{FFFFFF}ใส่วันเดือนปีเกิด {FF0000}ตัวอย่างปี: 1900-2020", "แก้ไข", "กลับ");
		}
		else if (iMonth < 1 || iMonth > 12)
		{
			Dialog_Show(playerid, DIALOG_TUTORIALBIRTHDAY, DIALOG_STYLE_INPUT, "[ข้อมูลตัวละคร]", "{FFFFFF}ใส่วันเดือนปีเกิด {FF0000}ตัวอย่างเดือน: 1-12", "แก้ไข", "กลับ");
		}
		else if (iDay < 1 || iDay > arrMonthDays[iMonth - 1])
		{
			Dialog_Show(playerid, DIALOG_TUTORIALBIRTHDAY, DIALOG_STYLE_INPUT, "[ข้อมูลตัวละคร]", "{FFFFFF}ใส่วันเดือนปีเกิด {FF0000}ตัวอย่างวัน: 1-31", "แก้ไข", "กลับ");
		}
		else {
			format(playerData[playerid][pBirthday], 24, inputtext);
			ShowDialog_Tutorial(playerid);
		}
	}
	return 1;
}


Dialog:DIALOG_TUTORIALCONFIRM2(playerid, response, listitem, inputtext[])
{
	ShowDialog_Tutorial(playerid);
	return 1;
}

Dialog:DIALOG_TUTORIALCONFIRM3(playerid, response, listitem, inputtext[])
{
    if (!response)
    {
		ShowDialog_Tutorial(playerid);
    }
	else
	{
		SendClientMessage(playerid, COLOR_RED, "- คุณออกเกมสำเร็จ...");
		SendClientMessage(playerid, COLOR_RED, "- ใช้คำสั่ง (/q) เพื่อออกจากหน้าต่างเกม");
		DelayedKick(playerid);
	}
	return 1;
}
*/
Dialog:DIALOG_EDITRANKS(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (!factionData[playerData[playerid][pFactionEdit]][factionExists])
			return 0;

		playerData[playerid][pSelectedSlot] = listitem;
		Dialog_Show(playerid, DIALOG_SETRANKNAME, DIALOG_STYLE_INPUT, "[แก้ไขชื่อยศ]", "ยศ : %s (%d)\nใส่ชื่อยศลงด้านล่างเพื่อแก้ไข", "แก้ไข", "กลับ", FactionRanks[playerData[playerid][pFactionEdit]][playerData[playerid][pSelectedSlot]], playerData[playerid][pSelectedSlot] + 1);
	}
	return 1;
}

Dialog:DIALOG_SETRANKNAME(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext))
			return Dialog_Show(playerid, DIALOG_SETRANKNAME, DIALOG_STYLE_INPUT, "[แก้ไขชื่อยศ]", "ยศ : %s (%d)\nใส่ชื่อยศลงด้านล่างเพื่อแก้ไข", "แก้ไข", "กลับ", FactionRanks[playerData[playerid][pFactionEdit]][playerData[playerid][pSelectedSlot]], playerData[playerid][pSelectedSlot] + 1);

	    if (strlen(inputtext) > 32)
	        return Dialog_Show(playerid, DIALOG_SETRANKNAME, DIALOG_STYLE_INPUT, "[แก้ไขชื่อยศ]", "ชื่อยศต้องไม่เกิน 32 ตัวอักษร\nยศ : %s (%d)\nใส่ชื่อยศลงด้านล่างเพื่อแก้ไข", "แก้ไข", "กลับ", FactionRanks[playerData[playerid][pFactionEdit]][playerData[playerid][pSelectedSlot]], playerData[playerid][pSelectedSlot] + 1);

		format(FactionRanks[playerData[playerid][pFactionEdit]][playerData[playerid][pSelectedSlot]], 32, inputtext);
		Faction_SaveRanks(playerData[playerid][pFactionEdit]);

		Faction_ShowRanks(playerid, playerData[playerid][pFactionEdit]);
		SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้ตั้งชื่อให้กับยศ %d ชื่อยศ \"%s\"", playerData[playerid][pSelectedSlot] + 1, inputtext);
	}
	else Faction_ShowRanks(playerid, playerData[playerid][pFactionEdit]);
	return 1;
}


Dialog:DIALOG_FACTIONLOCKER(playerid, response, listitem, inputtext[])
{
	if (playerData[playerid][pFactionEdit] == -1)
	    return 0;

	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
			    static
			        Float:x,
			        Float:y,
			        Float:z;

				GetPlayerPos(playerid, x, y, z);

				factionData[playerData[playerid][pFactionEdit]][factionLockerPosX] = x;
				factionData[playerData[playerid][pFactionEdit]][factionLockerPosY] = y;
				factionData[playerData[playerid][pFactionEdit]][factionLockerPosZ] = z;

				factionData[playerData[playerid][pFactionEdit]][factionLockerInt] = GetPlayerInterior(playerid);
				factionData[playerData[playerid][pFactionEdit]][factionLockerWorld] = GetPlayerVirtualWorld(playerid);

				Faction_Refresh(playerData[playerid][pFactionEdit]);
				Faction_Save(playerData[playerid][pFactionEdit]);
				SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้ปรับตำแหน่งตู้เซฟให้กลุ่ม %d", playerData[playerid][pFactionEdit]);
			}
		}
	}
	return 1;
}

stock SQL_ReturnEscaped(const string[])
{
	new
	    entry[256];

	mysql_escape_string(string, entry);
	return entry;
}

/*
alias:ModVeg("แต่งรถ")
CMD:ModVeg(playerid)
{
	if (playerData[playerid][pAdmin] < 1)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาติ");

    if (GetFactionType(playerid) != FACTION_MEC)
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ใช่ช่าง!");

	if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่มียศในการแต่ง");

	return 1;
}*/


//SendClientMessage(playerid, COLOR, "ข้อความ");
// string = ข้อความ




/*
// --> ระบบค้นหาตัวผู้ร้าย
CMD:chm(playerid, params[])
{
	static
	    userid;

	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV)
	    return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับรัฐบาลเท่านั้น!");

    if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/chm [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถค้นหาตัวเองได้");

	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(userid, X,Y,Z);

	targetonname[playerid] = userid;
	SetPlayerCheckpoint(playerid, X,Y,Z, 5);

	targeton[playerid] = 1;
	SendClientMessage(playerid, COLOR_GREY, "คุณได้ใช้เครื่อง GPS ค้นหาผู้เล่นนี้ /offchm เพื่อหยุดค้นหา !");

	return 1;
}
alias:chm("cgps")

CMD:roadblock(playerid, params[])
{
	if (GetFactionType(playerid) != FACTION_POLICE)
	    return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับตำรวจเท่านั้น!");

	if (playerData[playerid][pRoadblock] != -1)
		return SendClientMessage(playerid, COLOR_RED, "- คุณต้องเก็บด่านเก่าออกก่อน ถึงสร้างใหม่ได้ /rrb ในการเก็บ");

	new Float:X, Float:Y, Float:Z, Float:A;
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, A);
	playerData[playerid][pRoadblock] = CreateDynamicObject(981, X, Y, Z, 0.0, 0.0, A+180);
	SetPlayerPos(playerid, X, Y, Z+4);
	GameTextForPlayer(playerid, "~w~Roadblock ~r~Placed", 5000, 5);
	SendClientMessage(playerid, COLOR_SERVER, "คุณได้ทำการตั้งด่านสำเร็จ");
	SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "HQ: เจ้าหน้าที่ %s ได้ตั้งด่านอยู่ที่พิกัด (%.4f, %.4f, %.4f)", GetPlayerNameEx(playerid), X, Y, Z);
	return 1;
}
alias:roadblock("rb")

CMD:roadunblock(playerid, params[])
{
	if (GetFactionType(playerid) != FACTION_POLICE)
	    return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับตำรวจเท่านั้น!");

	if (playerData[playerid][pRoadblock] == -1)
		return SendClientMessage(playerid, COLOR_RED, "- ยังไม่มีการตั้งด่านเกิดขึ้น");

	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	DestroyDynamicObject(playerData[playerid][pRoadblock]);
	playerData[playerid][pRoadblock] = -1;
	SendClientMessage(playerid, COLOR_SERVER, "คุณได้ทำการเก็บด่านสำเร็จ");
	SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "HQ: เจ้าหน้าที่ %s ได้ทำการเก็บด่านที่พิกัด (%.4f, %.4f, %.4f)", GetPlayerNameEx(playerid), X, Y, Z);
	return 1;
}
alias:roadunblock("rrb")

CMD:roadunblockall(playerid, params[])
{
	if (GetFactionType(playerid) != FACTION_POLICE)
	    return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับตำรวจเท่านั้น!");

	if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่มีอำนาจในการเก็บด่านทั้งหมด");

	foreach(new i : Player)
	{
	    if (playerData[i][pRoadblock] != -1)
	    {
			DestroyDynamicObject(playerData[i][pRoadblock]);
			playerData[i][pRoadblock] = -1;
		}
	}
	SendClientMessage(playerid, COLOR_SERVER, "คุณได้ทำการเก็บด่านทั้งหมดสำเร็จ");
	SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "HQ: เจ้าหน้าที่ %s ได้ทำการเก็บด่านทั้งหมด", GetPlayerNameEx(playerid));
	return 1;
}
alias:roadunblockall("rrball")
*/

// --> ระบบค้นตัวผู้ต้องหา
CMD:frisk(playerid, params[])
{
    new
	    userid;

	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/frisk [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถค้นหาของผิดกฎหมายของตัวเองได้");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ต้องไม่อยู่ในยานพาหนะ");

    if (!playerData[userid][pCuffed])
        return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้ถูกใส่กุญแจมืออยู่");

    /*if (!Inventory_HasItem(userid, "กัญชา, โคเคน"))
	{
		SendClientMessageEx(playerid, COLOR_GREY, "- ไม่พบของผิดกฎหมายใด ๆ ภายในตัวของ %s", GetPlayerNameEx(userid));
	    return 1;
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "- พบของผิดกฎหมายภายในตัว %s", GetPlayerNameEx(userid));
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "กัญชา : {FFFFFF}%d",Inventory_Count(userid, "กัญชา"));
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "โคเคน : {FFFFFF}%d",Inventory_Count(userid, "โคเคน"));
        SendClientMessage(playerid, -1, "หากคุณต้องการยึดของผิดกฎหมาย พิมพ์คำสั่ง /takecannabis");
	    return 1;
 	}*/

    FriskInventory3(playerid, userid);

	SendClientMessageEx(userid, COLOR_LIGHTBLUE, "* คุณถูกค้นตัวโดย %s", GetPlayerNameEx(playerid));
	SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* คุณได้ทำการค้นตัว %s", GetPlayerNameEx(userid));

    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้ค้นตัว %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	return 1;
}
alias:frisk("7")

// --> ระบบยึดของผิดกฎหมาย
CMD:takecannabis(playerid, params[])
{
    new
	    userid;

	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/takecannabis [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถยึดของผิดกฎหมายของตัวเองได้");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ต้องไม่อยู่ในยานพาหนะ");

    if (!playerData[userid][pCuffed])
        return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้ถูกใส่กุญแจมืออยู่");

    if (!Inventory_HasItem(userid, "โคเคน"))
		return SendClientMessageEx(playerid, COLOR_GREY, "ผู้เล่นนี้ไม่ของผิดกฎหมายภายในตัว");

    if (!Inventory_HasItem(userid, "กัญชา"))
		return SendClientMessageEx(playerid, COLOR_GREY, "ผู้เล่นนี้ไม่ของผิดกฎหมายภายในตัว");

	new weedammo = Inventory_Count(userid, "กัญชา");
	new cocainammo = Inventory_Count(userid, "โคเคน");

	Inventory_Add(playerid, "โคเคน", cocainammo);
	Inventory_Remove(userid, "โคเคน", cocainammo);

	Inventory_Add(playerid, "กัญชา", weedammo);
	Inventory_Remove(userid, "กัญชา", weedammo);

	Inventory_Add(playerid, "poon", weedammo);
	Inventory_Remove(userid, "poon", weedammo);

	SendClientMessageEx(playerid, COLOR_LIGHTRED, "คุณได้ยึดของผิดกฎหมาย %s ที่อยู่ในตัวทั้งหมดจำนวน : %d", GetPlayerNameEx(userid), Inventory_Count(userid, "กัญชา"));
	SendClientMessageEx(userid, COLOR_LIGHTRED, "คุณได้ยึดของผิดกฎหมาย %s ที่อยู่ในตัวทั้งหมดจำนวน : %d", GetPlayerNameEx(playerid), Inventory_Count(userid, "กัญชา"));
    return 1;
}
alias:takecannabis("8")


alias:accept("ยอมรับ")
CMD:accept(playerid, params[])
{
	if (isnull(params))
 	{
	 	SendClientMessage(playerid, COLOR_WHITE, "/ยอมรับ [ชื่อรายการ]");
		SendClientMessage(playerid, COLOR_YELLOW, "[ชื่อรายการ]:{FFFFFF} เข้าแก็ง, ซื้อรถ");
		return 1;
	}
	if (!strcmp(params, "เข้าแก็ง", true) && playerData[playerid][pFactionOffer] != INVALID_PLAYER_ID)
	{
	    new
	        targetid = playerData[playerid][pFactionOffer],
	        factionid = playerData[playerid][pFactionOffered];

		if (!factionData[factionid][factionExists] || playerData[targetid][pFactionRank] < factionData[playerData[targetid][pFaction]][factionRanks] - 1)
	   	 	return SendClientMessage(playerid, COLOR_RED, "- ข้อเสนอถูกยกเลิก");

		SetFaction(playerid, factionid);
		playerData[playerid][pFactionRank] = 1;

		SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ยอมรับข้อเสนอจากคุณ {33CCFF}%s {FFFFFF}ที่เสนอให้เข้าร่วมกลุ่ม \"%s\" ยินดีด้วย!", GetPlayerNameEx(targetid), Faction_GetName(targetid));
		SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "%s {FFFFFF}ได้ยืนยันข้อเสนอในการเข้าร่วมกลุ่ม \"%s\"", GetPlayerNameEx(playerid), Faction_GetName(targetid));

        playerData[playerid][pFactionOffer] = INVALID_PLAYER_ID;
        playerData[playerid][pFactionOffered] = -1;
	}
	else if(!strcmp(params, "ซื้อรถ", true))
	{
		new
		    offeredby = playerData[playerid][pCarSeller],
		    vehicleid = playerData[playerid][pCarOffered],
		    price = playerData[playerid][pCarValue];

	    if(offeredby == INVALID_PLAYER_ID)
	    {
	        return SendClientMessage(playerid, COLOR_RED, "- ไม่มีใครเสนอขายรถให้คุณ");
	    }
	    if(!IsPlayerNearPlayer(playerid, offeredby, 5.0))
		{
	        return SendClientMessage(playerid, COLOR_RED, "- คุณจำเป็นต้องอยู่ในระยะใกล้กัน");
	    }
	    if(!IsVehicleOwner(offeredby, vehicleid))
	    {
	        return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นคนนั้นไม่ได้เป็นเจ้าของรถคันนี้อีกต่อไปแล้ว");
	    }
	    if(GetPlayerMoneyEx(playerid) < price)
	    {
	        return SendClientMessage(playerid, COLOR_RED, "- คุณมีเงินไม่เพียงพอ");
	    }

	    GetPlayerName(playerid, carData[vehicleid][carOwner], MAX_PLAYER_NAME);
	    carData[vehicleid][carOwnerID] = playerData[playerid][pID];
		new query[128];
	    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carOwnerID = %d, carOwner = '%s' WHERE carID = %d", carData[vehicleid][carOwnerID], carData[vehicleid][carOwner], carData[vehicleid][carID]);
	    mysql_tquery(g_SQL, query);

	    GivePlayerMoneyEx(offeredby, price);
	    GivePlayerMoneyEx(playerid, -price);

	    SendClientMessageEx(playerid, COLOR_SERVER, "** คุณได้ตอบรับข้อเสนอ %s ในการซื้อรถรุ่น %s ราคา %s", GetPlayerNameEx(offeredby), ReturnVehicleName(vehicleid), FormatMoney(price));
	    SendClientMessageEx(offeredby, COLOR_SERVER, "** %s ได้ตอบรับข้อเสนอของคุณในการขายรถรุ่น %s ราคา %s", GetPlayerNameEx(playerid), ReturnVehicleName(vehicleid), FormatMoney(price));

	    playerData[playerid][pCarSeller] = INVALID_PLAYER_ID;
	}
	return 1;
}
/*

CMD:fightstyle0(playerid, params[])
{
	SetPlayerFightingStyle (playerid, FIGHT_STYLE_GRABKICK);
	SendClientMessage(playerid, 0xFFFFFFAA, "คุณได้เปลี่ยนท่าต่อสู้เป็นธรรมดา !");
    return 1;
}
CMD:fightstyle1(playerid, params[])
{
	SetPlayerFightingStyle (playerid, FIGHT_STYLE_BOXING);
	SendClientMessage(playerid, 0xFFFFFFAA, "คุณได้เปลี่ยนท่าต่อสู้เป็นมวย !");
	return 1;
}
CMD:fightstyle2(playerid, params[])
{
	SetPlayerFightingStyle (playerid, FIGHT_STYLE_KUNGFU);
	SendClientMessage(playerid, 0xFFFFFFAA, "คุณได้เปลี่ยนท่าต่อสู้เป็นกังฟู!");
	return 1;
}
*/

/*alias:car("เรียกรถ")
CMD:car(playerid, const params[])
{
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `vehicles` WHERE `carOwnerID` = %d", playerData[playerid][pID]);
	mysql_tquery(g_SQL, query, "OnQueryFinished", "dd", playerid, THREAD_LIST_VEHICLES);
	return 1;
}*/


alias:givekeys("ให้กุญแจรถ")
CMD:givekeys(playerid, params[])
{
	new targetid, vehicleid = GetPlayerVehicleID(playerid);

	if(!vehicleid || !IsVehicleOwner(playerid, vehicleid))
	{
	    return SendClientMessage(playerid, COLOR_RED, "- คุณต้องอยู่ในรถส่วนตัวของคุณ");
	}
	if(sscanf(params, "u", targetid))
	{
	    return SendClientMessage(playerid, COLOR_WHITE, "/ให้กุญแจรถ [ไอดี/ชื่อ]");
	}
	if(!IsPlayerConnected(targetid) || !IsPlayerNearPlayer(playerid, targetid, 5.0))
	{
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");
	}
	if(targetid == playerid)
	{
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถส่งให้ตัวเองได้");
	}
	if(playerData[targetid][pVehicleKeys] == vehicleid)
	{
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้มีกุญแจรถอยู่แล้ว");
	}

	playerData[targetid][pVehicleKeys] = vehicleid;

	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s ได้ให้กุญแจรถ %s แก่ %s", GetPlayerNameEx(playerid), ReturnVehicleName(vehicleid), GetPlayerNameEx(targetid));
	SendClientMessageEx(targetid, COLOR_SERVER, "%s ได้ให้กุญแจรถรุ่น %s กับคุณ", ReturnVehicleName(vehicleid), GetPlayerNameEx(playerid));
	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้ให้กุญแจรถรุ่น %s แก่ %s", ReturnVehicleName(vehicleid), GetPlayerNameEx(targetid));
	return 1;
}

alias:takekeys("เก็บกุญแจรถ")
CMD:takekeys(playerid, params[])
{
	new targetid, vehicleid = GetPlayerVehicleID(playerid);

	if(!vehicleid || !IsVehicleOwner(playerid, vehicleid))
	{
	    return SendClientMessage(playerid, COLOR_RED, "- คุณต้องอยู่ในรถส่วนตัวของคุณ");
	}
	if(sscanf(params, "u", targetid))
	{
	    return SendClientMessage(playerid, COLOR_WHITE, "/เก็บกุญแจรถ [ไอดี/ชื่อ]");
	}
	if(!IsPlayerConnected(targetid) || !IsPlayerNearPlayer(playerid, targetid, 5.0))
	{
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");
	}
	if(targetid == playerid)
	{
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถเอากุญแจกับตัวเองได้");
	}
	if(playerData[targetid][pVehicleKeys] != vehicleid)
	{
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่มีกุญแจของคุณ");
	}

	playerData[targetid][pVehicleKeys] = INVALID_VEHICLE_ID;

	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s ได้เอากุญแจรถรุ่น %s จาก %s", GetPlayerNameEx(playerid), ReturnVehicleName(vehicleid), GetPlayerNameEx(targetid));
	SendClientMessageEx(targetid, COLOR_SERVER, "%s ได้เอากุญแจรถรุ่น %s ของเขาคืน", ReturnVehicleName(vehicleid), GetPlayerNameEx(playerid));
	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้เอากุญแจรถรุ่น %s คืนจาก %s", ReturnVehicleName(vehicleid), GetPlayerNameEx(targetid));
	return 1;
}

/*alias:decar("เก็บรถ")
CMD:decar(playerid, params[])
{
 	new string[MAX_SPAWNED_VEHICLES * 64], count;

 	string = "#\tชื่อรุ่น";

 	for(new i = 1; i < MAX_VEHICLES; i ++)
 	{
 	    if(IsValidVehicle(i) && carData[i][carID] > 0 && IsVehicleOwner(playerid, i))
 	    {
 	        format(string, sizeof(string), "%s\n%d\t%s", string, count + 1, ReturnVehicleName(i));
 	        count++;
		}
	}

	if(!count)
	{
	    SendClientMessage(playerid, COLOR_RED, "- ไม่มีรถของคุณจอดอยู่ในเซิร์ฟเวอร์ตอนนี้");
	}
	else
	{
	    Dialog_Show(playerid, DIALOG_DESPAWNCAR, DIALOG_STYLE_TABLIST_HEADERS, "[เลือกรถของคุณที่ต้องการจะเก็บ]", string, "ตกลง", "ปิด");
	}

	return 1;
}*/



/*CMD:colorcar(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid), color1, color2;

	if(sscanf(params, "ii", color1, color2))
	{
	    return SendClientMessage(playerid, COLOR_GREY3, "[Usage]: /colorcar [color1] [color2]");
	}
	if(playerData[playerid][pSpraycans] <= 0)
	{
	    return SendClientMessage(playerid, COLOR_GREY, "You have no spraycans left.");
	}
	if(!vehicleid)
	{
	    return SendClientMessage(playerid, COLOR_GREY, "You are not sitting inside any vehicle.");
	}
	if(carData[vehicleid][vOwnerID] > 0 && !IsVehicleOwner(playerid, vehicleid))
	{
	    return SendClientMessage(playerid, COLOR_GREY, "This vehicle doesn't belong to you, therefore you can't respray it.");
	}
	if(!(0 <= color1 <= 255) || !(0 <= color2 <= 255))
	{
	    return SendClientMessage(playerid, COLOR_GREY, "The color specified must range between 0 and 255.");
	}

    if(carData[vehicleid][vOwnerID] > 0 || carData[vehicleid][vGang] >= 0)
	{
	    carData[vehicleid][vColor1] = color1;
	    carData[vehicleid][vColor2] = color2;

	    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET color1 = %d, color2 = %d WHERE id = %d", color1, color2, carData[vehicleid][vID]);
	    mysql_tquery(g_SQL, query);
	}

	playerData[playerid][pSpraycans]--;

	mysql_format(g_SQL, query, sizeof(query), "UPDATE users SET spraycans = %d WHERE uid = %d", playerData[playerid][pSpraycans], playerData[playerid][pID]);
	mysql_tquery(g_SQL, query);

	ChangeVehicleColor(vehicleid, color1, color2);
	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s uses their spraycan to spray their vehicle a different color.", GetPlayerNameEx(playerid));

	PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
	SendClientMessageEx(playerid, COLOR_WHITE, "** Vehicle resprayed. You have %d spraycans left.", playerData[playerid][pSpraycans]);
	return 1;
}*/

/*CMD:paintcar(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid), paintjobid;

	if(sscanf(params, "i", paintjobid))
	{
	    return SendClientMessage(playerid, COLOR_GREY3, "[Usage]: /paintcar [paintjobid (-1 = none)]");
	}
	if(playerData[playerid][pSpraycans] <= 0)
	{
	    return SendClientMessage(playerid, COLOR_GREY, "You have no spraycans left.");
	}
	if(!vehicleid)
	{
	    return SendClientMessage(playerid, COLOR_GREY, "You are not sitting inside any vehicle.");
	}
	if(carData[vehicleid][vOwnerID] > 0 && !IsVehicleOwner(playerid, vehicleid))
	{
	    return SendClientMessage(playerid, COLOR_GREY, "This vehicle doesn't belong to you, therefore you can't respray it.");
	}
	if(!(-1 <= paintjobid <= 5))
	{
	    return SendClientMessage(playerid, COLOR_GREY, "The paintjob specified must range between -1 and 5.");
	}

    if(carData[vehicleid][vOwnerID] > 0 || carData[vehicleid][vGang] >= 0)
	{
	    carData[vehicleid][vPaintjob] = paintjobid;

	    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET paintjob = %d WHERE id = %d", paintjobid, carData[vehicleid][vID]);
	    mysql_tquery(g_SQL, query);
	}

    playerData[playerid][pSpraycans]--;

	mysql_format(g_SQL, query, sizeof(query), "UPDATE users SET spraycans = %d WHERE uid = %d", playerData[playerid][pSpraycans], playerData[playerid][pID]);
	mysql_tquery(g_SQL, query);

	ChangeVehiclePaintjob(vehicleid, paintjobid);
	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s uses their spraycan to paint their vehicle a different color.", GetPlayerNameEx(playerid));

	PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
	SendClientMessageEx(playerid, COLOR_WHITE, "** Vehicle painted. You have %d spraycans left.", playerData[playerid][pSpraycans]);
	return 1;
}*/

alias:sellcar("ขายรถ")
CMD:sellcar(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid), targetid, amount;

	if(!vehicleid || !IsVehicleOwner(playerid, vehicleid))
	{
	    return SendClientMessage(playerid, COLOR_RED, "- คุณต้องอยู่ในรถส่วนตัวของคุณ");
	}
	if(sscanf(params, "ui", targetid, amount))
	{
	    return SendClientMessage(playerid, COLOR_WHITE, "/ขายรถ [ไอดี/ชื่อ] [ราคา]");
	}
	if(!IsPlayerConnected(targetid) || !IsPlayerNearPlayer(playerid, targetid, 5.0))
	{
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");
	}
	if(targetid == playerid)
	{
	    return SendClientMessage(playerid, COLOR_RED, "- ขายให้ตัวเองไม่ได้");
	}
	if(amount < 1)
	{
	    return SendClientMessage(playerid, COLOR_RED, "- ราคาต้องไม่ต่ำกว่า $1");
	}

	playerData[targetid][pCarSeller] = playerid;
	playerData[targetid][pCarOffered] = vehicleid;
	playerData[targetid][pCarValue] = amount;

	SendClientMessageEx(targetid, COLOR_SERVER, "** %s ได้เสนอขายรถรุ่น %s ในราคา %s (/ยอมรับ vehicle ในการยินยอมคำสั่งซื้อ)", ReturnVehicleName(vehicleid), GetPlayerNameEx(playerid), FormatMoney(amount));
	SendClientMessageEx(playerid, COLOR_SERVER, "** คุณได้เสนอขายรถรุ่น %s ให้ %s ในราคา %s", ReturnVehicleName(vehicleid), GetPlayerNameEx(targetid), FormatMoney(amount));
	return 1;
}



alias:vticket("ใบสั่ง")
CMD:vticket(playerid, params[])
{
 	new amount, vehicleid;

    if(GetFactionType(playerid) != FACTION_POLICE)
    {
        return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ใช่เจ้าหน้าที่ตำรวจ");
	}
	if(sscanf(params, "d", amount))
	{
	    return SendClientMessage(playerid, COLOR_WHITE, "/ใบสั่ง [ราคา]");
	}
	if((vehicleid = GetNearbyVehicle(playerid)) == INVALID_VEHICLE_ID)
	{
	    return SendClientMessage(playerid, COLOR_RED, "- คุณต้องอยู่ภายในระยะของรถ");
	}
	if(!carData[vehicleid][carOwnerID])
	{
	    return SendClientMessage(playerid, COLOR_RED, "- รถคันนี้ไม่มีเจ้าของ");
	}
	if(!(1000 <= amount <= 5000))
	{
	    return SendClientMessage(playerid, COLOR_RED, "- ราคาต้องไม่ต่ำกว่า $1,000 และไม่เกิน $5,000");
	}
	if(carData[vehicleid][carTickets] >= 50000)
	{
	    return SendClientMessage(playerid, COLOR_RED, "- รถคันนี้โดนใบสั่งมากกว่า $50,000 แล้ว ไม่สามารถเพิ่มอีกได้");
	}

	carData[vehicleid][carTickets] += amount;
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carTickets = %d WHERE carID = %d", carData[vehicleid][carTickets], carData[vehicleid][carID]);
	mysql_tquery(g_SQL, query);

	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s ได้ให้ใบสั่งรถ %s ราคา %s", GetPlayerNameEx(playerid), ReturnVehicleName(vehicleid), FormatMoney(amount));
	return 1;
}


alias:paytickets("จ่ายค่าปรับ")
CMD:paytickets(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid), amount;
	new query[128];
	if(!vehicleid)
	{
	    return SendClientMessage(playerid, COLOR_RED, "- คุณต้องอยู่ในรถ");
	}
	if(!IsVehicleOwner(playerid, vehicleid) && playerData[playerid][pVehicleKeys] != vehicleid)
	{
	    return SendClientMessage(playerid, COLOR_RED, "- คุณต้องอยู่ในรถส่วนตัวของคุณ");
	}
	if(sscanf(params, "d", amount))
	{
	    return SendClientMessageEx(playerid, COLOR_WHITE, "/จ่ายค่าปรับ [ราคา] (ตอนนี้ยังค้างอยู่ %s)", FormatMoney(carData[vehicleid][carTickets]));
	}
	if(amount < 1 || amount > GetPlayerMoneyEx(playerid))
	{
		return SendClientMessage(playerid, COLOR_RED, "- คุณมีเงินไม่เพียงพอ");
	}
	if(amount > carData[vehicleid][carTickets])
	{
	    return SendClientMessage(playerid, COLOR_RED, "- ราคาใบสั่งไม่ถูกต้อง (ไม่แพงกว่าราคาที่ใส่)");
	}

    carData[vehicleid][carTickets] -= amount;
	GivePlayerMoneyEx(playerid, -amount);

	mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicles SET carTickets = %d WHERE carID = %d", carData[vehicleid][carTickets], carData[vehicleid][carID]);
	mysql_tquery(g_SQL, query);

	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้จ่ายค่าใบสั่งจำนวน %s ปัจจุบันเหลือ %s ที่ต้องจ่าย", FormatMoney(amount), FormatMoney(carData[vehicleid][carTickets]));
	return 1;
}





/*
CMD:bank(playerid, params[])
{
	if (!IsPlayerInBank(playerid))
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ได้อยู่ที่ธนาคาร");

    CreatePlayerATM(playerid);
	//Dialog_Show(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, "[บัญชีธนาคาร]", "ยอดเงินปัจจุบัน: %s", "เลือก", "ปิด", FormatMoney(playerData[playerid][pBankMoney]));
	return 1;
}*/
/*
task RepeatingTimer[1000](playerid)
{
	if (robCount > 0)
	    robCount--;

	// รัฐออนไลน์
	new str_Gov;
	new PlayerTDXX[playerid][18];

 	format(str_Gov, sizeof(str_Gov), "%d", CopOnline());
	TextDrawSetString(PlayerTDXX[playerid][17], str_Gov);

 	format(str_Gov, sizeof(str_Gov), "%d", MedicOnline());
	TextDrawSetString(PlayerTDXX[playerid][11], str_Gov);

 	format(str_Gov, sizeof(str_Gov), "%d", MechanicOnline());
	TextDrawSetString(PlayerTDXX[playerid][15], str_Gov);
}
*/
CMD:robbank(playerid, params[])
{
	if (!IsPlayerInBank(playerid))
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ได้อยู่ที่ธนาคาร");

	if (robCount > 0)
	    return SendClientMessageEx(playerid, COLOR_RED, "- รอเวลาอีก %s วินาที ถึงปล้นได้อีกครั้ง", FormatNumber(robCount));

	new price = randomEx(1000, 3000);
	robCount = 1800;
	GivePlayerMoneyEx(playerid, price);
	GivePlayerWanted(playerid, 3);
	SendClientMessageToAllEx(COLOR_LIGHTRED, "[ปล้นธนาคาร] %s ได้ทำการปล้นธนาคารและได้รับเงินไปจำนวน %s", GetPlayerNameEx(playerid), FormatMoney(price));
	return 1;
}



/*GetFactionColor(factionid)
{
	new color[8] = "FFFFFF";

	if (factionid == -1)
		return color;

	format(color, sizeof(color), "%06x", factionData[factionid][factionColor] >>> 8);

	return color;
}*/



CMD:toggle(playerid, params[])
{
    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (isnull(params))
 	{
	    SendClientMessage(playerid, COLOR_WHITE, "/toggle [ชื่อรายการ]");
		SendClientMessage(playerid, COLOR_YELLOW, "[ชื่อรายการ]:{FFFFFF} ooc");
		return 1;
	}
	if (!strcmp(params, "ooc", true))
	{
	    if (OOC)
	    {
			SendClientMessageToAllEx(COLOR_LIGHTRED, "แอดมิน %s ได้ปิดระบบพูดคุยผ่าน OOC ชั่วคราว", GetPlayerNameEx(playerid));
			OOC = false;
		}
		else
		{
		    SendClientMessageToAllEx(COLOR_LIGHTRED, "แอดมิน %s ได้เปิดระบบพูดคุยผ่าน OOC แล้ว", GetPlayerNameEx(playerid));
		    OOC = true;
		}
	}
	else SendClientMessage(playerid, COLOR_YELLOW, "[ชื่อรายการ]:{FFFFFF} ooc");
    return 1;
}



CMD:online(playerid, params[])
{
	new factionid = playerData[playerid][pFaction];

 	if (factionid == -1)
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ใช่หนึ่งในสมาชิกของกลุ่มใด ๆ");

	SendClientMessage(playerid, COLOR_SERVER, "สมาชิกที่ออนไลน์:");

	foreach (new i : Player) if (playerData[i][pFaction] == factionid)
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "[ID: %d] {33CCFF}%s {FFFFFF}- %s (%d)", i, GetPlayerNameEx(i), Faction_GetRank(i), playerData[i][pFactionRank]);
	}
	return 1;
}

GetFactionOnline(type)
{
	new count;
	foreach (new i : Player) if (GetFactionType(i) == type)
	{
		count++;
	}
	return count;
}

CMD:faction(playerid, params[])
{
	new type,
		count,
		name[24];
	if (sscanf(params, "d", type))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "/faction [ไอดีกลุ่ม]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[ไอดีกลุ่ม]:{FFFFFF} 1. ตำรวจ 2. นักข่าว 3. แพทย์ 4. นายก");
		return 1;
	}
	if (type < 1 || type > 4)
	{
	    SendClientMessage(playerid, COLOR_RED, "- ไอดีต้องไม่ต่ำกว่า 1 และไม่เกิน 4 เท่านั้น");
	    return 1;
	}
	switch(type)
	{
	    case 1: name = "ตำรวจ";
	    case 2: name = "นักข่าว";
	    case 3: name = "แพทย์";
	    case 4: name = "นายก";
	}
	foreach (new i : Player) if (GetFactionType(i) == type)
	{
	    count++;
		SendClientMessageEx(playerid, COLOR_WHITE, "(%s) ออนไลน์ %d", name, count);
	}
	if (!count)
	{
		SendClientMessageEx(playerid, COLOR_RED, "- กลุ่ม %s ไม่มีคนออนไลน์เลย", name);
		return 1;
	}
	return 1;
}
/*
CMD:ooc(playerid, params[])
{

	if (!OOC)
	    return SendClientMessage(playerid, COLOR_RED, "- OOC ถูกปิดใช้งาน");

	if (playerData[playerid][pOOCSpam] > 0)
	    return SendClientMessageEx(playerid, COLOR_RED, "- ป้องกันการ Spam ข้อความ คุณเหลือเวลาอีก %d วินาที ในการใช้คำสั่งใหม่อีกครั้ง", playerData[playerid][pOOCSpam]);

	if (playerData[playerid][pFaction] == -1)
	{
	    if (playerData[playerid][pVip] > 0)
	    {
		    switch(playerData[playerid][pVip])
		    {
				case 1: SendClientMessageToAllEx(COLOR_VIP1, "#VIP {FFFFFF}[ประชาชน] {FFA84D}(ID:%d){FFFFFF} %s: %s", playerid, GetPlayerNameEx(playerid), params);
				case 2: SendClientMessageToAllEx(COLOR_VIP2, "#{00FFFF}PR{FFFFFF}EMI{00FFFF}UM {FFFFFF}[ประชาชน] {FFA84D}(ID:%d){FFFFFF} %s: %s", playerid, GetPlayerNameEx(playerid), params);
				case 3: SendClientMessageToAllEx(COLOR_VIP3, "#{FF0000}SU{FFFFFF}PER{FF0000}ME {FFFFFF}[ประชาชน] {FFA84D}(ID:%d){FFFFFF} %s: %s", playerid, GetPlayerNameEx(playerid), params);
				case 4: SendClientMessageToAllEx(COLOR_VIP4, "#{FF0000}You{FFFFFF}Tube {FFFFFF}[ประชาชน] {FFA84D}(ID:%d){FFFFFF} %s: %s", playerid, GetPlayerNameEx(playerid), params);
			}
			playerData[playerid][pOOCSpam] = 10;
		}
		else
		{
			SendClientMessageToAllEx(COLOR_WHITE, "[ประชาชน] {FFA84D}(ID:%d){FFFFFF} %s: %s", playerid, GetPlayerNameEx(playerid), params);
			playerData[playerid][pOOCSpam] = 10;
		}
	}
	else
	{
	    if (playerData[playerid][pVip] > 0)
	    {
		    switch(playerData[playerid][pVip])
		    {
				case 1: SendClientMessageToAllEx(COLOR_VIP1, "#VIP {%06x}[%s] {FFA84D}(ID:%d){FFFFFF} %s: %s", factionData[playerData[playerid][pFaction]][factionColor] >>> 8, Faction_GetName(playerid), playerid, GetPlayerNameEx(playerid), params);
				case 2: SendClientMessageToAllEx(COLOR_VIP2, "#{00FFFF}PR{FFFFFF}EMI{00FFFF}UM {%06x}[%s] {FFA84D}(ID:%d){FFFFFF} %s: %s", factionData[playerData[playerid][pFaction]][factionColor] >>> 8, Faction_GetName(playerid), playerid, GetPlayerNameEx(playerid), params);
				case 3: SendClientMessageToAllEx(COLOR_VIP3, "#{FF0000}SU{FFFFFF}PER{FF0000}ME {%06x}[%s] {FFA84D}(ID:%d){FFFFFF} %s: %s", factionData[playerData[playerid][pFaction]][factionColor] >>> 8, Faction_GetName(playerid), playerid, GetPlayerNameEx(playerid), params);
				case 4: SendClientMessageToAllEx(COLOR_VIP4, "#{FF0000}You{FFFFFF}Tube {%06x}[%s] {FFA84D}(ID:%d){FFFFFF} %s: %s", factionData[playerData[playerid][pFaction]][factionColor] >>> 8, Faction_GetName(playerid), playerid, GetPlayerNameEx(playerid), params);
			}
			playerData[playerid][pOOCSpam] = 10;
		}
		else
		{
			SendClientMessageToAllEx(COLOR_WHITE, "{%06x}[%s] {FFA84D}(ID:%d){FFFFFF} %s: %s", factionData[playerData[playerid][pFaction]][factionColor] >>> 8, Faction_GetName(playerid), playerid, GetPlayerNameEx(playerid), params);
			playerData[playerid][pOOCSpam] = 10;
		}

	}
	playerData[playerid][pOOCSpam] = 10;
	return 1;
}
alias:ooc("o")
*/

/*
CMD:fspawn(playerid, params[])
{
	new faction = playerData[playerid][pFaction];

	if (playerData[playerid][pFaction] == -1)
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ใช่หัวหน้ากลุ่ม");

	if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1 && playerData[playerid][pAdmin] > 5)
	    return SendClientMessageEx(playerid, COLOR_RED, "- คุณต้องมียศอย่างน้อยระดับ %d", factionData[playerData[playerid][pFaction]][factionRanks] - 1);

	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	factionData[faction][SpawnX] = X;
	factionData[faction][SpawnY] = Y;
	factionData[faction][SpawnZ] = Z;
	factionData[faction][SpawnInterior] = GetPlayerInterior(playerid);
	factionData[faction][SpawnVW] = GetPlayerVirtualWorld(playerid);
	factionData[faction][factionEntrance] = playerData[playerid][pEntrance];
	Faction_Save(faction);
	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้บันทึกจุดเกิดของกลุ่ม %d สำเร็จ", playerData[playerid][pFaction]);
	return 1;
}

CMD:spawnpoint(playerid, params[])
{
	new point;
	new faction = playerData[playerid][pFaction];
	if(sscanf(params, "i", point)) return SendClientMessage(playerid, COLOR_WHITE, "/spawnpoint [0-2] (0 = สาธารณะ, 1 = กลุ่ม, 2 = ล่าสุดก่อนออกเกม)");

	if(point < 0 || point > 2)
	    return SendClientMessage(playerid, COLOR_RED, "- จุดเกิดมีแค่ 0-2 เท่านั้น!");

	switch(point)
	{
	    case 0:
	    {
		    SendClientMessage(playerid, COLOR_SERVER, "คุณได้เปลี่ยนจุดเกิดเป็นที่ ''สาธารณะ'' สำเร็จ");
			playerData[playerid][pSpawnPoint] = 0;
		}
	    case 1:
	    {
		    if(playerData[playerid][pFactionID] == -1)
		    {
		        SendClientMessage(playerid, COLOR_RED, "- คุณไม่ใช่หนึ่งในสมาชิกของกลุ่มใด ๆ");
		        return 1;
			}
			if(factionData[faction][SpawnX] == 0 && factionData[faction][SpawnY] == 0 && factionData[faction][SpawnZ] == 0)
		    {
		        SendClientMessage(playerid, COLOR_RED, "- กลุ่มของคุณไม่มีจุดเกิด");
		        return 1;
			}
			SendClientMessage(playerid, COLOR_SERVER, "คุณได้เปลี่ยนจุดเกิดเป็นที่ ''กลุ่ม'' สำเร็จ");
			playerData[playerid][pSpawnPoint] = 1;
		}
		case 2:
		{
		    SendClientMessage(playerid, COLOR_SERVER, "คุณได้เปลี่ยนจุดเกิดเป็นที่ ''ล่าสุดก่อนออกเกม'' สำเร็จ");
			playerData[playerid][pSpawnPoint] = 2;
		}
	}
	new query[90];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `playerSpawn` = %d WHERE `playerID` = %d LIMIT 1",
	playerData[playerid][pSpawnPoint],
	playerData[playerid][pID]);
	mysql_tquery(g_SQL, query);
	return 1;
}
*/
CMD:tog(playerid, params[])
{
	if (isnull(params))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "/tog [ชื่อรายการ]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[ชื่อรายการ]:{FFFFFF} faction");
	    return 1;
	}
	else if (!strcmp(params, "faction", true))
	{
	    if (playerData[playerid][pFaction] == -1)
	        return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ได้เป็นสมาชิกของกลุ่มใด ๆ");

	    if (!playerData[playerid][pDisableFaction])
	    {
	        playerData[playerid][pDisableFaction] = 1;
			SendClientMessage(playerid, COLOR_SERVER, "คุณได้ปิดระบบสื่อสารกลุ่มของคุณ (/tog faction อีกครั้งในการเปิดใหม่)");
		}
		else
		{
  			playerData[playerid][pDisableFaction] = 0;
     		SendClientMessage(playerid, COLOR_SERVER, "คุณได้เปิดระบบสื่อสารกลุ่มของคุณ");
		}
	}
	return 1;
}

CMD:editfaction(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendClientMessage(playerid, COLOR_WHITE, "/editfaction [ไอดีกลุ่ม] [ชื่อรายการ]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[ชื่อรายการ]:{FFFFFF} name, color, type, models, locker, ranks, maxranks");
		return 1;
	}
	if ((id < 0 || id >= MAX_FACTIONS) || !factionData[id][factionExists])
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่มีไอดีกลุ่มนี้อยู่ในฐานข้อมูล");

    if (!strcmp(type, "name", true))
	{
	    new name[32];

	    if (sscanf(string, "s[32]", name))
	        return SendClientMessage(playerid, COLOR_WHITE, "/editfaction [ไอดีกลุ่ม] [ชื่อรายการ] [ชื่อใหม่]");

	    format(factionData[id][factionName], 32, name);

	    Faction_Save(id);
		SendAdminMessage(COLOR_ADMIN, "[ADMIN]: %s ได้เปลี่ยนชื่อของกลุ่มไอดี %d เป็นชื่อ \"%s\"", GetPlayerNameEx(playerid), id, name);
	}
	else if (!strcmp(type, "maxranks", true))
	{
	    new ranks;

	    if (sscanf(string, "d", ranks))
	        return SendClientMessage(playerid, COLOR_WHITE, "/editfaction [ไอดีกลุ่ม] [ชื่อรายการ] [ความจุของยศ 1-15]");

		if (ranks < 1 || ranks > 15)
		    return SendClientMessage(playerid, COLOR_RED, "- ความจุของยศต้องไม่ต่ำกว่า 1 และไม่เกิน 15 เท่านั้น");

	    factionData[id][factionRanks] = ranks;

	    Faction_Save(id);
		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับความจุของยศกลุ่มไอดี %d เป็น %d", GetPlayerNameEx(playerid), id, ranks);
	}
	else if (!strcmp(type, "ranks", true))
	{
	    Faction_ShowRanks(playerid, id);
	}
	else if (!strcmp(type, "color", true))
	{
	    new color;

	    if (sscanf(string, "h", color))
	        return SendClientMessage(playerid, COLOR_WHITE, "/editfaction [ไอดีกลุ่ม] [ชื่อรายการ] [สีรูปแบบ hex]");

	    factionData[id][factionColor] = color;
	    Faction_Update(id);

	    Faction_Save(id);
		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับสีเป็น {%06x}|||||{FF0080} ของกลุ่มไอดี %d", GetPlayerNameEx(playerid), color >>> 8, id);
	}
	else if (!strcmp(type, "type", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
		 	SendClientMessage(playerid, COLOR_WHITE, "/editfaction [ไอดีกลุ่ม] [ชื่อรายการ] [รูปแบบกลุ่ม]");
            SendClientMessage(playerid, COLOR_YELLOW, "[รูปแบบกลุ่ม]:{FFFFFF} 1: Police | 2: News | 3: Medical | 4: Government | 5: Gang | 6: Mechanic");
            return 1;
		}
		if (typeint < 1 || typeint > 6)
		    return SendClientMessage(playerid, COLOR_RED, "- รูปแบบกลุ่มมีแค่ 1-5 เท่านั้น");

	    factionData[id][factionType] = typeint;

	    Faction_Save(id);
		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับรูปแบบกลุ่มให้กลุ่มไอดี %d เป็นรูปแบบที่ %d", GetPlayerNameEx(playerid), id, typeint);
	}
	else if (!strcmp(type, "models", true))
	{
		playerData[playerid][pFactionEdit] = id;
	    Dialog_Show(playerid, DIALOG_FACTIONSKIN, DIALOG_STYLE_LIST, "[ตู้เก็บเสื้อผ้า]", "แก้ไขสกิน", "ตกลง", "ออก");
	}
	else if (!strcmp(type, "locker", true))
	{
        playerData[playerid][pFactionEdit] = id;
		Dialog_Show(playerid, DIALOG_FACTIONLOCKER, DIALOG_STYLE_LIST, "[ตู้เซฟ]", "ปรับตำแหน่งตู้เซฟ", "ยืนยัน", "ออก");
	}
	return 1;
}

CMD:createfaction(playerid, params[])
{
	static
	    id = -1,
		type,
		name[32];

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (sscanf(params, "ds[32]", type, name))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "/createfaction [รูปแบบกลุ่ม] [ชื่อกลุ่ม]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[รูปแบบกลุ่ม]:{FFFFFF} 1: Police | 2: News | 3: Medical | 4: Government | 5: Gang | 6: Mechanic");
		return 1;
	}
	if (type < 1 || type > 6)
	    return SendClientMessage(playerid, COLOR_RED, "- รูปแบบกลุ่มมีแค่ 1-6 เท่านั้น");

	id = Faction_Create(name, type);

	if (id == -1)
	    return SendClientMessage(playerid, COLOR_RED, "- ความจุของกลุ่มในฐานข้อมูลเต็มแล้ว ไม่สามารถสร้างได้อีก (ติดต่อผู้พัฒนา)");

	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้สร้างกลุ่มรูปแบบที่ %d ชื่อกลุ่ม %s ไอดีกลุ่ม %d", type, name, id);
	return 1;
}

CMD:deletefaction(playerid, params[])
{
	static
	    id = 0;

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, COLOR_WHITE, "/deletefaction [ไอดีกลุ่ม]");

	if ((id < 0 || id >= MAX_FACTIONS) || !factionData[id][factionExists])
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่มีไอดีกลุ่มนี้อยู่ในฐานข้อมูล");

	Faction_Delete(id);
	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้ลบกลุ่มไอดี %d ออกสำเร็จ", id);
	return 1;
}

CMD:createentrance(playerid, params[])
{
    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (isnull(params) || strlen(params) > 32)
	    return SendClientMessage(playerid, COLOR_WHITE, "/createentrance [ชื่อประตู]");

	new id = Entrance_Create(playerid, params);

	if (id == -1)
	    return SendClientMessage(playerid, COLOR_RED, "- ความจุของประตูในฐานข้อมูลเต็มแล้ว ไม่สามารถสร้างได้อีก (ติดต่อผู้พัฒนา)");

    SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้สร้างประตูไอดี %d ชื่อ %s", id, params);
	return 1;
}

CMD:editentrance(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendClientMessage(playerid, COLOR_WHITE, "/editentrance [ไอดี] [ชื่อรายการ]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[ชื่อรายการ]:{FFFFFF} location, interior, password, name, locked, mapicon, type, virtual, faction");
		return 1;
	}
	if ((id < 0 || id >= MAX_ENTRANCES) || !entranceData[id][entranceExists])
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่มีไอดีประตูนี้อยู่ในฐานข้อมูล");

	if (!strcmp(type, "location", true))
	{
	    GetPlayerPos(playerid, entranceData[id][entrancePosX], entranceData[id][entrancePosY], entranceData[id][entrancePosZ]);
		GetPlayerFacingAngle(playerid, entranceData[id][entrancePosA]);

		entranceData[id][entranceExterior] = GetPlayerInterior(playerid);
		entranceData[id][entranceExteriorVW] = GetPlayerVirtualWorld(playerid);

		Entrance_Refresh(id);
		Entrance_Save(id);

		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ย้ายตำแหน่งประตูไอดี %d", GetPlayerNameEx(playerid), id);
	}
	else if (!strcmp(type, "interior", true))
	{
	    GetPlayerPos(playerid, entranceData[id][entranceIntX], entranceData[id][entranceIntY], entranceData[id][entranceIntZ]);
		GetPlayerFacingAngle(playerid, entranceData[id][entranceIntA]);

		entranceData[id][entranceInterior] = GetPlayerInterior(playerid);

        foreach (new i : Player)
		{
			if (playerData[i][pEntrance] == entranceData[id][entranceID])
			{
				SetPlayerPos(i, entranceData[id][entranceIntX], entranceData[id][entranceIntY], entranceData[id][entranceIntZ]);
				SetPlayerFacingAngle(i, entranceData[id][entranceIntA]);

				SetPlayerInterior(i, entranceData[id][entranceInterior]);
				SetCameraBehindPlayer(i);
			}
		}
		Entrance_Refresh(id);
		Entrance_Save(id);
		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับด้านในประตูไอดี %d", GetPlayerNameEx(playerid), id);
	}
	else if (!strcmp(type, "virtual", true))
	{
	    new worldid;

	    if (sscanf(string, "d", worldid))
	        return SendClientMessage(playerid, COLOR_WHITE, "/editentrance [ไอดี] [ชื่อรายการ] [ชาแนลโลก]");

	    entranceData[id][entranceWorld] = worldid;

		foreach (new i : Player) if (Entrance_Inside(i) == id)
		{
			SetPlayerVirtualWorld(i, worldid);
		}
		Entrance_Save(id);
		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับชาแนลโลกให้ประตูไอดี %d เป็นชาแนลโลก %d", GetPlayerNameEx(playerid), id, worldid);
	}
	else if (!strcmp(type, "mapicon", true))
	{
	    new icon;

	    if (sscanf(string, "d", icon))
	        return SendClientMessage(playerid, COLOR_WHITE, "/editentrance [ไอดี] [ชื่อรายการ] [ตัวเลข map icon]");

		if (icon < 0 || icon > 63)
		    return SendClientMessage(playerid, COLOR_RED, "- ไอดีต้องไม่ต่ำกว่า 0 และไม่เกิน 63 เท่านั้น อ่านเพิ่มเติม > \"wiki.sa-mp.com/wiki/MapIcons\".");

	    entranceData[id][entranceIcon] = icon;

	    Entrance_Refresh(id);
	    Entrance_Save(id);

		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับไอดี Map icon ให้ประตูไอดี %d เป็น Map icon %d", GetPlayerNameEx(playerid), id, icon);
	}
	else if (!strcmp(type, "password", true))
	{
	    new password;

	    if (sscanf(string, "d", password))
	        return SendClientMessage(playerid, COLOR_WHITE, "/editentrance [ไอดี] [ชื่อรายการ] [รหัสผ่าน] (ใช้ ''0'' ในการปิดใช้งานรหัสผ่าน)");

		if (password == 0)
		{
			entranceData[id][entrancePass] = 0;
		}
		else {
			if(password < 1000 || password > 9999)
			    return SendClientMessage(playerid, COLOR_RED, "- รหัสผ่านต้องไม่ต่ำกว่า 4 หลัก");

		    entranceData[id][entrancePass] = password;
		}
	    Entrance_Save(id);
		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ตั้งรหัสผ่านให้ประตูไอดี %d โดยใช้รหัสผ่าน \"%d\"", GetPlayerNameEx(playerid), id, password);
	}
	else if (!strcmp(type, "locked", true))
	{
	    new locked;

	    if (sscanf(string, "d", locked))
	        return SendClientMessage(playerid, COLOR_WHITE, "/editentrance [ไอดี] [ชื่อรายการ] [0/1]");

		if (locked < 0 || locked > 1)
		    return SendClientMessage(playerid, COLOR_RED, "- 0. ปลดล็อค | 1. ล็อค");

	    entranceData[id][entranceLocked] = locked;
	    Entrance_Save(id);
		Entrance_Refresh(id);

	    if (locked)
		{
			SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ล็อคประตูไอดี %d", GetPlayerNameEx(playerid), id);
		} else {
		    SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปลดล็อคประตูไอดี %d", GetPlayerNameEx(playerid), id);
		}
	}
	else if (!strcmp(type, "name", true))
	{
	    new name[32];

	    if (sscanf(string, "s[32]", name))
	        return SendClientMessage(playerid, COLOR_WHITE, "/editentrance [ไอดี] [ชื่อรายการ] [ชื่อที่ต้องการเปลี่ยน]");

	    format(entranceData[id][entranceName], 32, name);

	    Entrance_Refresh(id);
	    Entrance_Save(id);

		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้เปลี่ยนชื่อประตูไอดี %d เป็นชื่อ \"%s\"", GetPlayerNameEx(playerid), id, name);
	}
	else if (!strcmp(type, "type", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
	    {
	        SendClientMessage(playerid, COLOR_WHITE, "/editentrance [ไอดี] [ชื่อรายการ] [รูปแบบที่ต้องการ]");
			SendClientMessage(playerid, COLOR_YELLOW, "[รูปแบบที่ต้องการ]:{FFFFFF} 0: None | 1: DMV | 2: Bank | 3: Warehouse | 4: City Hall | 5: Shooting Range");
			return 1;
		}
		if (typeint < 0 || typeint > 5)
			return SendClientMessage(playerid, COLOR_RED, "- รูปแบบต้องไม่ต่ำกว่า 0 และไม่เกิน 4 เท่านั้น");

        entranceData[id][entranceType] = typeint;

        switch (typeint)
		{
            case 1: {
            	entranceData[id][entranceIntX] = -2029.5531;
           		entranceData[id][entranceIntY] = -118.8003;
            	entranceData[id][entranceIntZ] = 1035.1719;
            	entranceData[id][entranceIntA] = 0.0000;
				entranceData[id][entranceInterior] = 3;
            }
			case 2: {
            	entranceData[id][entranceIntX] = 1456.1918;
           		entranceData[id][entranceIntY] = -987.9417;
            	entranceData[id][entranceIntZ] = 996.1050;
            	entranceData[id][entranceIntA] = 90.0000;
				entranceData[id][entranceInterior] = 6;
            }
            case 3: {
                entranceData[id][entranceIntX] = 1291.8246;
           		entranceData[id][entranceIntY] = 5.8714;
            	entranceData[id][entranceIntZ] = 1001.0078;
            	entranceData[id][entranceIntA] = 180.0000;
				entranceData[id][entranceInterior] = 18;
			}
			case 4: {
			    entranceData[id][entranceIntX] = 390.1687;
           		entranceData[id][entranceIntY] = 173.8072;
            	entranceData[id][entranceIntZ] = 1008.3828;
            	entranceData[id][entranceIntA] = 90.0000;
				entranceData[id][entranceInterior] = 3;
			}
			case 5: {
			    entranceData[id][entranceIntX] = 304.0165;
           		entranceData[id][entranceIntY] = -141.9894;
            	entranceData[id][entranceIntZ] = 1004.0625;
            	entranceData[id][entranceIntA] = 90.0000;
				entranceData[id][entranceInterior] = 7;
			}
		}
		foreach (new i : Player)
		{
			if (playerData[i][pEntrance] == entranceData[id][entranceID])
			{
				SetPlayerPos(i, entranceData[id][entranceIntX], entranceData[id][entranceIntY], entranceData[id][entranceIntZ]);
				SetPlayerFacingAngle(i, entranceData[id][entranceIntA]);

				SetPlayerInterior(i, entranceData[id][entranceInterior]);
				SetCameraBehindPlayer(i);
			}
		}
	    Entrance_Save(id);
		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับรูปแบบประตูไอดี %d เป็นรูปแบบ %d", GetPlayerNameEx(playerid), id, typeint);
	}
	else if (!strcmp(type, "faction", true))
	{
	    new factionid;

	    if (sscanf(string, "d", factionid))
	        return SendClientMessage(playerid, COLOR_WHITE, "/editentrance [ไอดี] [ชื่อรายการ] [ไอดีกลุ่ม]");

		if ((factionid < 0 || factionid >= MAX_FACTIONS) || !factionData[factionid][factionExists])
		    return SendClientMessage(playerid, COLOR_RED, "- ไม่มีไอดีกลุ่มนี้อยู่ในฐานข้อมูล");

	    entranceData[id][entranceFaction] = factionid;

	    Entrance_Refresh(id);
	    Entrance_Save(id);

		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้เปลี่ยนประตู %d เป็นของกลุ่ม \"%s\"", GetPlayerNameEx(playerid), id, factionData[factionid][factionName]);
	}
	return 1;
}

CMD:removeentrance(playerid, params[])
{
	static
	    id = 0;

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, COLOR_WHITE, "/removeentrance [ไอดีประตู]");

	if ((id < 0 || id >= MAX_ENTRANCES) || !entranceData[id][entranceExists])
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่มีไอดีประตูนี้อยู่ในฐานข้อมูล");

	Entrance_Delete(id);
	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้ลบประตูไอดี %d", id);
	return 1;
}




CMD:createatm(playerid, params[])
{
	static
	    id = -1;

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	id = ATM_Create(playerid);

	if (id == -1)
	    return SendClientMessage(playerid, COLOR_RED, "- ความจุของ ATM ในฐานข้อมูลเต็มแล้ว ไม่สามารถสร้างได้อีก (ติดต่อผู้พัฒนา)");

	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้สร้าง ตู้ ATM  ขึ้นมาใหม่ ไอดี: %d", id);
	return 1;
}

CMD:deleteatm(playerid, params[])
{
	static
	    id = 0;

    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, COLOR_WHITE, "/deleteatm [ไอดี]");

	if ((id < 0 || id >= MAX_ATM_MACHINES) || !atmData[id][atmExists])
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่มีไอดี ATM นี้อยู่ในฐานข้อมูล");

	ATM_Delete(id);
	SendClientMessageEx(playerid, COLOR_SERVER, "คุณได้ลบ ตู้ ATM ไอดี %d ออกสำเร็จ", id);
	return 1;
}





alias:twithdraw("เบิกเงิน")
CMD:twithdraw(playerid, params[])
{
	static
	    amount;

	if (GetFactionType(playerid) != FACTION_GOV)
	    return SendClientMessage(playerid, COLOR_RED, "- ช่องทางนี้สำหรับเจ้าหน้าที่เท่านั้น!");

	if (sscanf(params, "d", amount))
		return SendClientMessageEx(playerid, COLOR_WHITE, "/เบิกเงิน [จำนวน] (%s เงินปัจจุบัน)", FormatMoney(g_TaxVault));

	if (!IsPlayerInCityHall(playerid))
	    return SendClientMessage(playerid, COLOR_RED, "- คุณไม่ได้อยู่ที่ทำการรัฐบาล");

	if (amount < 1 || amount > g_TaxVault)
	    return SendClientMessage(playerid, COLOR_RED, "- เงินกองคลังมีไม่เพียงพอ");

    if (playerData[playerid][pFactionRank] < factionData[playerData[playerid][pFaction]][factionRanks] - 1)
	    return SendClientMessageEx(playerid, COLOR_RED, "- คุณไม่มีความสามารถในการเบิกเงินกองคลัง ระดับที่ต้องการคือ: %d", factionData[playerData[playerid][pFaction]][factionRanks] - 1);

	Tax_AddMoney(-amount);

	GivePlayerMoneyEx(playerid, amount);
	SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้เบิกเงินกองคลังจำนวน %s ปัจจุบันเหลืออยู่ %s", FormatMoney(amount), FormatMoney(g_TaxVault));
	return 1;
}



Dialog:DIALOG_BUY(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
				new itemname[24];
				itemname = "พิซซ่า";
				new price = 150;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "- คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				new count = Inventory_Count(playerid, itemname)+1;

				if (count > 20)
                    return SendClientMessageEx(playerid, COLOR_RED, "- ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 1);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "- ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }
		    case 1:
		    {
				new itemname[24];
				itemname = "น้ำเปล่า";
				new price = 50;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "- คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				new count = Inventory_Count(playerid, itemname)+1;

				if (count > 20)
                    return SendClientMessageEx(playerid, COLOR_RED, "- ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 1);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "- ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }
		    case 2:
		    {
				new itemname[24];
				itemname = "เลื่อยตัดไม้";
				new price = 1000;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "- คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				if (Inventory_HasItem(playerid, itemname))
                    return SendClientMessageEx(playerid, COLOR_RED, "- ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 1);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "- ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }
		    case 3:
		    {
				new itemname[24];
				itemname = "เบ็ดตกปลา";
				new price = 500;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "- คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				if (Inventory_HasItem(playerid, itemname))
                    return SendClientMessageEx(playerid, COLOR_RED, "- ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 1);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "- ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }
		    case 4:
		    {
				new itemname[24];
				itemname = "เหยื่อ";
				new price = 100;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "- คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				new count = Inventory_Count(playerid, itemname)+1;

				if (count > 20)
                    return SendClientMessageEx(playerid, COLOR_RED, "- ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 5);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "- ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }
		    case 5:
		    {
				new itemname[24];
				itemname = "สบู่";
				new price = 100;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "- คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				new count = Inventory_Count(playerid, itemname)+1;

				if (count > 20)
                    return SendClientMessageEx(playerid, COLOR_RED, "- ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 1);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "- ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }
		    /*case 6:
		    {
				new itemname[24];
				itemname = "บัตรไปเกาะลอยฟ้า";
				new price = 100000;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "- คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				new count = Inventory_Count(playerid, itemname)+1;

				if (count > 20)
                    return SendClientMessageEx(playerid, COLOR_RED, "- ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 1);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "- ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }
		    case 7:
		    {
				new itemname[24];
				itemname = "กระเป๋าซากศพ";
				new price = 10000;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "- คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				new count = Inventory_Count(playerid, itemname)+1;

				if (count > 20)
                    return SendClientMessageEx(playerid, COLOR_RED, "- ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 1);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "- ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }*/
		    case 6:
		    {
				new itemname[24];
				itemname = "ข้าวกล่อง";
				new price = 100;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "- คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				new count = Inventory_Count(playerid, itemname)+1;

				if (count > 20)
                    return SendClientMessageEx(playerid, COLOR_RED, "- ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 1);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "- ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }			
 		}
	}
	return 1;
}

Dialog:DIALOG_BUYFASHION(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
				new itemname[24];
				itemname = "หมวกกันน็อคสีแดง";
				new price = 1500;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "- คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				if (Inventory_HasItem(playerid, itemname))
                    return SendClientMessageEx(playerid, COLOR_RED, "- ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 1);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "- ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }
		    case 1:
		    {
				new itemname[24];
				itemname = "หมวกกันน็อคสีม่วง";
				new price = 1800;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "- คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				if (Inventory_HasItem(playerid, itemname))
                    return SendClientMessageEx(playerid, COLOR_RED, "- ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 1);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "- ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }
		    case 2:
		    {
				new itemname[24];
				itemname = "หมวกกันน็อคสีน้ำเงิน";
				new price = 2000;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "- คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				if (Inventory_HasItem(playerid, itemname))
                    return SendClientMessageEx(playerid, COLOR_RED, "- ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 1);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "- ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }
		}
	}
	return 1;
}





IsAnIP(str[])
{
	if (!str[0] || str[0] == '\1')
		return 0;

	for (new i = 0, l = strlen(str); i != l; i ++)
	{
	    if ((str[i] < '0' || str[i] > '9') && str[i] != '.')
	        return 0;

	    if (0 < ((i == 0) ? (strval(str)) : (strval(str[i + 1]))) > 255)
	        return 0;
	}
	return 1;
}




CMD:report(playerid, params[])
{
	if (isnull(params))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "/report [สาเหตุ]");
	    SendClientMessage(playerid, COLOR_LIGHTRED, "[คำเตือน]:{FFFFFF} ใช้คำสั่งนี่เฉพาะเหตุฉุกเฉินเท่านั้น");
	    return 1;
	}

	foreach (new i : Player)
	{
		if (playerData[i][pAdmin])
		{
			SendClientMessageEx(i, COLOR_YELLOW, "[REPORT]: %s (ID: %d) สาเหตุ: %s", GetPlayerNameEx(playerid), playerid, params);
		}
	}
	SendClientMessage(playerid, COLOR_GREEN, "คุณได้ส่งข้อความถึงกลุ่มแอดมินสำเร็จ กรุณาอย่าส่งซ้ำและรอคำตอบ!");
	return 1;
}





CMD:gogo(playerid, params[])
{
	if(EventOn == 0) return SendClientMessage(playerid, COLOR_RED, "- กิจกรรมได้จบลงแล้ว ขอบคุณที่ร่วมสนุก");

    if (IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED, "- กรุณาลงจากยานพาหนะก่อนเข้าร่วมกิจกรรม!");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    playerData[playerid][pEventBackX] = x;
    playerData[playerid][pEventBackY] = y;
    playerData[playerid][pEventBackZ] = z;
    playerData[playerid][pEventBackInterior] = GetPlayerInterior(playerid);
    playerData[playerid][pEventBackWorld] = GetPlayerVirtualWorld(playerid);
    playerData[playerid][pEventGo] = 1;

	SetPlayerPos(playerid, EventX, EventY, EventZ+3);
	SetPlayerInterior(playerid, EventInterior);
	SetPlayerVirtualWorld(playerid, EventWorld);
	return 1;
}


CMD:dynamichelp(playerid, params[])
{
	if(playerData[playerid][pAdmin] >= 6)
	{
	    SendClientMessage(playerid, COLOR_GREEN, "|======[LEVEL: 6 DYNAMIC]======|");
	    SendClientMessage(playerid, COLOR_WHITE, "/createfaction (สร้างกลุ่ม) /deletefaction (ลบกลุ่ม) /editfaction (แก้ไขกลุ่ม)");
	    SendClientMessage(playerid, COLOR_WHITE, "/veh (เสกรถ) /dveh (ลบรถเสก) /rveh (ลบรถออกจากฐานข้อมูล) /editveh (แก้ไขรถ)");
	    SendClientMessage(playerid, COLOR_WHITE, "/createarrest (สร้างพื้นที่จับกุม) /deletearrest (ลบพื้นที่จับกุม)");
	    SendClientMessage(playerid, COLOR_WHITE, "/createentrance (สร้างประตู) /deleteentrance (ลบประตู) /editentrance (แก้ไขประตู)");
	    SendClientMessage(playerid, COLOR_WHITE, "/createshop (สร้างร้านค้า) /deleteshop (ลบร้านค้า)");
	    SendClientMessage(playerid, COLOR_WHITE, "/createatm (สร้าง ATM) /deleteatm (ลบ ATM) /creategarage (สร้างอู่) /deletegarage (ลบอู่)");
	    SendClientMessage(playerid, COLOR_WHITE, "/creategps (สร้าง GPS) /deletegps (ลบ GPS) /editgps (แก้ไข GPS) /agps (ดูไอดี/วาร์ป GPS)");
        SendClientMessage(playerid, COLOR_WHITE, "/createsafe (สร้าง Safe) /deletesafe (ลบ Safe) /editsafe (แก้ไข Safe)");
	}
    return 1;
}

GetElapsedTime(time, &hours, &minutes, &seconds)
{
	hours = 0;
	minutes = 0;
	seconds = 0;

	if (time >= 3600)
	{
		hours = (time / 3600);
		time -= (hours * 3600);
	}
	while (time >= 60)
	{
	    minutes++;
	    time -= 60;
	}
	return (seconds = time);
}

Float:GetVehicleSpeed(vehicleid)
{
    new Float:vx, Float:vy, Float:vz;
    GetVehicleVelocity(vehicleid, vx, vy, vz);
	new Float:vel = floatmul(floatsqroot(floatadd(floatadd(floatpower(vx, 2), floatpower(vy, 2)),  floatpower(vz, 2))), 181.5);
	return vel;
}

forward SpeedoTimer(playerid, vehicleid);
public SpeedoTimer(playerid, vehicleid)
{
	if(vehicleid != GetPlayerVehicleID(playerid))
	{
		KillTimer(playerData[playerid][pSpeedoTimer]);
		return 0;
	}

	new Float:returnspeed = GetVehicleSpeed(vehicleid);
	new speed = floatround(returnspeed);
	new str[64];
 	format(str, sizeof(str), "%d", speed); // speed
	PlayerTextDrawSetString(playerid, VehicleTD[playerid][1], str);
	
	/*new Float:carhealth;
	GetVehicleHealth(vehicleid, carhealth);*/
	

	new modelid = GetVehicleModel(vehicleid);
	new Float:speedtest = GetVehicleSpeed(vehicleid);
	new Float:maxspeed = vehicleData[modelid - 400][vSpeed];
	new Float:value = floatmul(floatdiv(speedtest, maxspeed), 0.01);



	new Float:vehiclehealth; //กันรถระเบิด
	GetVehicleHealth(vehicleid, vehiclehealth);
	if (vehicleid && vehiclehealth <= 255) { SetVehicleHealth(vehicleid, 257); }
	
	if (IsPlayerInArea(playerid, 1074.166748046875, -1560.1565856933594, 1183.166748046875, -1417.1565856933594) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		/*SetPlayerPos(playerid, 2107.1089,1397.9868,10.8079);
		SetPlayerFacingAngle(playerid, 179.7388);*/
		SetVehiclePos(GetPlayerVehicleID(playerid), 1143.3147,-1362.6720,13.7188);
		SetVehicleZAngle(vehicleid, 180.8801);

		SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
		LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));

		PutPlayerInVehicle(playerid, vehicleid, 0);
		SetEngineStatus(vehicleid, false);
		SetLightStatus(vehicleid, false);
	}

	if(speed >= 211)
	{
		format(str, sizeof(str), "~r~ IIIIIIIIIIIIIIIIII"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str);
	}
	if(speed <= 210)
	{
		format(str, sizeof(str), "~r~ IIIIIIIIIIIIIIIII"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str);
	}
	if(speed <= 200)
	{
		format(str, sizeof(str), " IIIIIIIIIIIIIIII"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str); // ส้ม

	}
	if(speed <= 190)
	{
		format(str, sizeof(str), " IIIIIIIIIIIIIII"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str);
	}
	if(speed <= 180)
	{
		format(str, sizeof(str), " IIIIIIIIIIIIII"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str);
	}
	if(speed <= 170)
	{
		format(str, sizeof(str), " IIIIIIIIIIIII"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str);


	}
	if(speed <= 160)
	{
		format(str, sizeof(str), "~y~ IIIIIIIIIIII"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str); // เหลือง
	}
	if(speed <= 150)
	{
		format(str, sizeof(str), "~y~ IIIIIIIIIII"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str);
	}
	if(speed <= 140)
	{
		format(str, sizeof(str), "~y~ IIIIIIIIII"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str);
	}
	if(speed <= 130)
	{
		format(str, sizeof(str), "~y~ IIIIIIIII"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str);
	}
	if(speed <= 120)
	{
		format(str, sizeof(str), "~g~~h~ IIIIIIII"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str); // เขียว
	}
	if(speed <= 110)
	{
		format(str, sizeof(str), "~g~~h~ IIIIIII"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str);

	}
	if(speed <= 100)
	{
		format(str, sizeof(str), "~g~~h~ IIIIII"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str);
	}
	if(speed <= 80)
	{
		format(str, sizeof(str), "~g~~h~ IIIII"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str);
	}
	if(speed <= 60)
	{
		format(str, sizeof(str), "~w~ IIII"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str); // ขาว
	}
	if(speed <= 40)
	{
		format(str, sizeof(str), "~w~ III"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str);
	}
	if(speed <= 20)
	{
		format(str, sizeof(str), "~w~ II"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str);
	}
	if(speed <= 9)
	{
		format(str, sizeof(str), "~w~ I"); // speed ProgressBar
		PlayerTextDrawSetString(playerid, VehicleTD[playerid][13], str);
	}

	if(vehicleFuel[vehicleid] >= 35)
	{
		PlayerTextDrawColor(playerid, VehicleTD[playerid][8], 6553855);
	}
	if(vehicleFuel[vehicleid] <= 34)
	{
		PlayerTextDrawColor(playerid, VehicleTD[playerid][8], -65281);
	}
	if(vehicleFuel[vehicleid] <= 15)
	{
		PlayerTextDrawColor(playerid, VehicleTD[playerid][8], -1962934017);
	}

	if (!IsAPlane(vehicleid) && !IsAHelicopter(vehicleid) && !IsABoat(vehicleid))
	{
		if (IsEngineVehicle(vehicleid) && GetEngineStatus(vehicleid))
		{
			if(vehicleFuel[vehicleid] > 0)
			{
				vehicleFuel[vehicleid] -= value;
			}
			else
			{
			    SetEngineStatus(vehicleid, false);
			    vehicleFuel[vehicleid] = 0;
			}
		}
	}
	
	switch (GetEngineStatus(vehicleid))
	{
	    /*case false: PlayerTextDrawSetString(playerid, WORP_CAR[playerid][10], "~w~Engine");
	    case true: PlayerTextDrawSetString(playerid, WORP_CAR[playerid][10], "~g~Engine");*/
		//new Float:fuel = vehicleData[modelid - 400][vFuel] - vehicleFuel[vehicleid];

	    case false: 
		{
			//PlayerTextDrawColor(playerid, VehicleTD[playerid][14], 255);
			PlayerTextDrawColor(playerid, VehicleTD[playerid][9], -1962934017); //แดง
			format(str, sizeof(str), "P"); // Gear
			PlayerTextDrawSetString(playerid, VehicleTD[playerid][5], str);
		}
	    case true: 
		{
			PlayerTextDrawColor(playerid, VehicleTD[playerid][9], 6553855); //เขียว
			format(str, sizeof(str), "~r~N"); // Gear
			PlayerTextDrawSetString(playerid, VehicleTD[playerid][5], str);

			if(speed > 0)
			{
				format(str, sizeof(str), "1"); // Gear 1
				PlayerTextDrawSetString(playerid, VehicleTD[playerid][5], str);
			}
			if(speed >= 100)
			{
				format(str, sizeof(str), "2"); // Gear 2
				PlayerTextDrawSetString(playerid, VehicleTD[playerid][5], str);
			}
			if(speed >= 160)
			{
				format(str, sizeof(str), "3"); // Gear 3
				PlayerTextDrawSetString(playerid, VehicleTD[playerid][5], str);
			}
			if(speed >= 200)
			{
				format(str, sizeof(str), "~r~4"); // Gear 4
				PlayerTextDrawSetString(playerid, VehicleTD[playerid][5], str);
			}
		}
	}
	
	switch (carData[vehicleid][carLocked])
	{
	    case 0: PlayerTextDrawColor(playerid, VehicleTD[playerid][6], 6553855);
	    case 1: PlayerTextDrawColor(playerid, VehicleTD[playerid][6], -1962934017);
	}

	/*if (vehicleFuel[vehicleid] < 20)
	{
		PlayerTextDrawHide(playerid, VehicleTD[playerid][8]);
		PlayerTextDrawShow(playerid, VehicleTD[playerid][8]);

		PlayerTextDrawColor(playerid, VehicleTD[playerid][8], -1962934017);
	}
	if (vehicleFuel[vehicleid] >= 20)
	{
		PlayerTextDrawHide(playerid, VehicleTD[playerid][8]);
		PlayerTextDrawShow(playerid, VehicleTD[playerid][8]);

		PlayerTextDrawColor(playerid, VehicleTD[playerid][8], 1296911871);
	}
	if (vehicleFuel[vehicleid] >= 40)
	{
		PlayerTextDrawHide(playerid, VehicleTD[playerid][8]);
		PlayerTextDrawShow(playerid, VehicleTD[playerid][8]);

		PlayerTextDrawColor(playerid, VehicleTD[playerid][8], 6553855);
	}*/
	
	/*
	switch (GetLightStatus(vehicleid))
	{
	    case false: PlayerTextDrawSetString(playerid, WORP_CAR[playerid][12], "~w~Lights");
	    case true: PlayerTextDrawSetString(playerid, WORP_CAR[playerid][12], "~g~Lights");
	}
	switch (GetTrunkStatus(vehicleid))
	{
	    case false: PlayerTextDrawSetString(playerid, WORP_CAR[playerid][14], "~w~Trunk");
	    case true: PlayerTextDrawSetString(playerid, WORP_CAR[playerid][14], "~g~Trunk");
	}

	switch (GetHoodStatus(vehicleid))
	{
	    case false: PlayerTextDrawSetString(playerid, WORP_CAR[playerid][11], "~w~Hood");
	    case true: PlayerTextDrawSetString(playerid, WORP_CAR[playerid][11], "~g~Hood");
	}*/
	

	return 1;
}
stock IsPlayerInArea(playerid, Float:minx, Float:miny, Float:maxx, Float:maxy)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	if(X >= minx && X <= maxx && Y >= miny && Y <= maxy)
		return 1;
	return 0;
}


ptask PlayerTimerSecond[1000](playerid)
{
	if (!playerData[playerid][IsLoggedIn]) return 0;

	if (playerData[playerid][pInjured] > 0)
	{
		new Msg[128];
		format(Msg, sizeof(Msg), "(( ผู้เล่นนี้บาดเจ็บ /Damages เพื่อตรวจสอบ ))");
	    SetPlayerChatBubble(playerid, Msg, COLOR_LIGHTRED, 5.0, 3000);
	}
	foreach (new i : Player)
    {

		if(PlayerSaveTime[playerid] == 1)
		{
			UpdateplayerData(playerid);
		}

		new idz = -1;
		if ((idz = Boombox_Nearest(i)) != INVALID_PLAYER_ID && playerData[i][pBoombox] != idz && strlen(BoomboxData[idz][boomboxURL]) && !IsPlayerInAnyVehicle(i))
		{
		    new str[128];
		    strunpack(str, BoomboxData[idz][boomboxURL]);
		    playerData[i][pBoombox] = idz;

		    //StopAudioStreamForPlayer(i);
		    PlayAudioStreamForPlayer(i, str, BoomboxData[idz][boomboxPos][0], BoomboxData[idz][boomboxPos][1], BoomboxData[idz][boomboxPos][2], 30.0, 1);
		}
		else if (playerData[i][pBoombox] != INVALID_PLAYER_ID && !IsPlayerInRangeOfPoint(i, 30.0, BoomboxData[playerData[i][pBoombox]][boomboxPos][0], BoomboxData[playerData[i][pBoombox]][boomboxPos][1], BoomboxData[playerData[i][pBoombox]][boomboxPos][2]))
		{
		    playerData[i][pBoombox] = INVALID_PLAYER_ID;
		    StopAudioStreamForPlayer(i);
		}
	}

	// ชื่อแก๊งบนหัว
	/*if (playerData[playerid][pFaction] != -1)
	{
		new Msg[128];
		format(Msg, sizeof(Msg), "{%06x}[%s]", factionData[playerData[playerid][pFaction]][factionColor] >>> 8, Faction_GetName(playerid));
	    SetPlayerChatBubble(playerid, Msg, COLOR_WHITE, 50.0, 10000);
	}*/
	new vehicleid = GetPlayerVehicleID(playerid);
	if (GetVehicleSpeed(vehicleid) >= 290.0)
	{
		SendAdminMessage(COLOR_RED, "(( [AGGUARDSPEED] (%d)%s:ขับรถเร็วมากเกินไป ถึง 290 !! ))", playerid, GetPlayerNameEx(playerid));
		SendClientMessageToAllEx(COLOR_LIGHTRED, "{FF0000}[{FFFF00}AGGUARD{FF0000}] {FFFF00}%s ถูกเตะออกจากเซิฟเวอร์ |>{00FFFF}  โปรรถบิน ", GetPlayerNameEx(playerid));
        return DelayedKick(playerid);
	}


	if (playerData[playerid][pInjuredTime] > 0)
	{
	    if (playerData[playerid][pInjuredTime] > 0)
	    {
		    static
		        hours,
		        minutes,
		        seconds,
				str[128];

			playerData[playerid][pInjuredTime]--;

		    GetElapsedTime(playerData[playerid][pInjuredTime], hours, minutes, seconds);

			format(str, sizeof(str), "~r~RESPAWN ~w~AVAILABLE IN ~r~%02d MINUTES %02d SECONDS", minutes, seconds);
			PlayerTextDrawSetString(playerid, PlayerDeathTD[playerid], str);

			if(!GetPlayerVehicleID(playerid))
			{
				ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);
			}
			else ApplyAnimation(playerid, "ped", "CAR_dead_LHS", 4.1, 0, 0, 0, 1, 0, 1);


			//ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 1, 0, 0, 1, 0, 1);
		}
		if (!playerData[playerid][pInjuredTime])
		{
		    playerData[playerid][pHealth] = 100.0;
		    playerData[playerid][pInjured] = 0;
		    playerData[playerid][pInjuredTime] = 0;
		    playerData[playerid][pHospital] = 1;
		    SpawnPlayer(playerid);
		}
	}


	if (playerData[playerid][pStunned] > 0)
	{
        playerData[playerid][pStunned]--;
       	ApplyAnimation(playerid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);
        if (!playerData[playerid][pStunned])
        {
            TogglePlayerControllable(playerid, true);
		}
	}
	if (playerData[playerid][pJailTime] > 0)
	{
	    static
	        hours,
	        minutes,
	        seconds,
			str[128];

	    playerData[playerid][pJailTime]--;

		GetElapsedTime(playerData[playerid][pJailTime], hours, minutes, seconds);

		format(str, sizeof(str), "~g~Prison Time:~w~ %02d:%02d:%02d", hours, minutes, seconds);
		GameTextForPlayer(playerid, str, 2000, 6);

	    if (!playerData[playerid][pJailTime])
	    {
	        //new id = playerData[playerid][pPrisonOut];
	        SetPlayerPos(playerid, 2340.2932,2457.0764,14.9688);
	        SetPlayerFacingAngle(playerid, 180.7818);
	        SetPlayerInterior(playerid, 0);
	        SetPlayerVirtualWorld(playerid, 0);

	        ShowPlayerStats(playerid, true);

			SendClientMessage(playerid, COLOR_YELLOW, "[Prison]: คุณถูกปล่อยตัวออกจากเรือนจำเรียบร้อย");
		}
	}
	if (GetPlayerWantedLevelEx(playerid) > 0)
	{
	    playerData[playerid][pWantedTime]++;
	    if(playerData[playerid][pWantedTime] > 120)
	    {
	        playerData[playerid][pWantedTime] = 0;
	        GivePlayerWanted(playerid, -1);
	    }
	}
	if (PlayerParty[playerid] == NO_PARTY)
	{
	    ClearCrime(playerid);
	}
	//new vehicleid = GetPlayerVehicleID(playerid);
	new Float:vehiclehealth;
	GetVehicleHealth(vehicleid, vehiclehealth);
	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
		switch (GetEngineStatus(vehicleid))
		{
			case true:
			{
  				if (vehiclehealth < 350)
				{
				    SetVehicleHealth(vehicleid, 350);
			        SetEngineStatus(vehicleid, false);
				}
			}
		}
	}
	if (playerData[playerid][pDrivingTest] && IsPlayerInVehicle(playerid, playerData[playerid][pTestCar]))
	{
	    if (!IsPlayerInRangeOfPoint(playerid, 200.0, g_arrDrivingCheckpoints[playerData[playerid][pTestStage]][0], g_arrDrivingCheckpoints[playerData[playerid][pTestStage]][1], g_arrDrivingCheckpoints[playerData[playerid][pTestStage]][2]))
		{
			PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
	        CancelDrivingTest(playerid);
			SendClientMessage(playerid, COLOR_LIGHTRED, "[Driving School]: การสอบใบขับขี่ถูกยกเลิก เนื่องจากคุณขับออกนอกจากพื้นที่สอบใบขับขี่");
		}
		static
			Float:health;
		GetVehicleHealth(GetPlayerVehicleID(playerid), health);
		if (health < 990.0)
		{
			CancelDrivingTest(playerid);
			SendClientMessage(playerid, COLOR_LIGHTRED, "[Driving School]: คุณสอบไม่ผ่าน เนื่องจากยานพาหนะได้รับความเสียหายมากจนเกินไป");
			PlayerPlaySound(playerid, 1009, 0.0, 0.0, 0.0);
		}
		else if (GetVehicleSpeed(vehicleid) >= 80.0)
		{
			if (++playerData[playerid][pTestWarns] < 3)
			{
				PlayerPlaySound(playerid, 1009, 0.0, 0.0, 0.0);
				SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Driving School]: คุณขับเร็วมากเกินไป เตือนครั้งที่ (%d/3)", playerData[playerid][pTestWarns]);
				SendClientMessage(playerid, COLOR_LIGHTRED, "[Driving School]: ความเร็วต้องไม่เกิน 80 KM/H");
    		}
       		else
			{
				CancelDrivingTest(playerid);
				PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
    			SendClientMessage(playerid, COLOR_LIGHTRED, "[Driving School]: การสอบใบขับขี่ถูกยกเลิก เนื่องจากคุณขับเร็วมากเกินไป");
		    }
		}
	}
	if (playerData[playerid][pOOCSpam] > 0) playerData[playerid][pOOCSpam]--;
	if (playerData[playerid][pHungry] > 100) playerData[playerid][pHungry] = 100;
	if (playerData[playerid][pStrain] > 100) playerData[playerid][pStrain] = 100;
	if (playerData[playerid][pThirsty] > 100) playerData[playerid][pThirsty] = 100;
	if (playerData[playerid][pSleep] > 100) playerData[playerid][pSleep] = 100;
	if (playerData[playerid][pBath] > 100) playerData[playerid][pBath] = 100;

	if (playerData[playerid][pHungry] < 0) playerData[playerid][pHungry] = 0;
	if (playerData[playerid][pThirsty] < 0) playerData[playerid][pThirsty] = 0;
	if (playerData[playerid][pStrain] < 0) playerData[playerid][pStrain] = 0;
	if (playerData[playerid][pSleep] < 0) playerData[playerid][pSleep] = 0;
	if (playerData[playerid][pBath] < 0) playerData[playerid][pBath] = 0;

	if (playerData[playerid][pPVPFreeze] > 0)
	{
		playerData[playerid][pPVPFreeze]--;
		if (playerData[playerid][pPVPFreeze] <= 0)
		{
		    TogglePlayerControllable(playerid, true);
			playerData[playerid][pPVPFreeze] = 0;
		}
	}
	if (playerData[playerid][pPVPFreeze] < 0)
	{
	    TogglePlayerControllable(playerid, true);
		playerData[playerid][pPVPFreeze] = 0;
	}
    return 1;
}
ptask playerStrainTimer[60000*8](playerid)
{
    if(playerData[playerid][pStrain] < 100) playerData[playerid][pStrain] += 1;
    if(playerData[playerid][pBath] > 0) playerData[playerid][pBath] -= 2;
    if(playerData[playerid][pSleep] > 0) playerData[playerid][pSleep] -= 2;
}

ptask PlayerTimerHungerHp[60*1000](playerid)
{
	if ((!playerData[playerid][IsLoggedIn]) || playerData[playerid][pHospital] != -1)
	    return 0;

	if (playerData[playerid][pTutorial] == 0)
	    return 1;

	if(playerData[playerid][pThirsty] < 10 && playerData[playerid][pHungry] < 10)
	{
	    new Float:hp;
	    GetPlayerHealth(playerid, hp);
	    SetPlayerHealth(playerid, hp-5.0);
		//SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s จับไปที่หน้าท้องของตัวเอง เนื่องจากกำลังหิว", GetPlayerNameEx(playerid));
		return 1;
	}
	else if(playerData[playerid][pThirsty] < 10)
	{
	    new Float:hp;
		//ApplyAnimation(playerid, "CARRY","LIFTUP105", 4.1, 0, 0, 0, 0, 0, 1);
	    GetPlayerHealth(playerid, hp);
	    SetPlayerHealth(playerid, hp-2.0);
	    //SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s จับไปที่หน้าท้องของตัวเอง เนื่องจากกำลังกระหาย", GetPlayerNameEx(playerid));
	}
	else if(playerData[playerid][pHungry] < 10)
	{
	    new Float:hp;
		//ApplyAnimation(playerid, "CARRY","LIFTUP105", 4.1, 0, 0, 0, 0, 0, 1);
	    GetPlayerHealth(playerid, hp);
	    SetPlayerHealth(playerid, hp-2.0);
	    //SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s จับไปที่หน้าท้องของตัวเอง เนื่องจากกำลังหิว", GetPlayerNameEx(playerid));
	}
	return 1;
}
ptask PlayerTimerHunger[10*1000](playerid)
{
	if(!playerData[playerid][IsLoggedIn]) return 0;

	if(playerData[playerid][pJailTime]) return 0;

	if(playerData[playerid][pInjured]) return 0;

	if(playerData[playerid][pThirsty] > 0) playerData[playerid][pThirsty] -= floatdiv(float(10), floatmul(9, 36));
	if(playerData[playerid][pHungry] > 0) playerData[playerid][pHungry] -= floatdiv(float(10), floatmul(12, 36));

	/*if(playerData[playerid][pStrain] >= 100)
	{
	    new Float:hp;
	    GetPlayerHealth(playerid, hp);
	    SetPlayerHealth(playerid, hp-1.0);
	    SendClientMessage(playerid, -1, "{C42D04}[ คำเตือน ] {F96C46}: ตัวละครของคุณกำลัง 'เกิดสภาวะเครียดหนัก'!");
        SetPlayerDrunkLevel(playerid, 10000);
        StrainCooldown[playerid] = 10;
	}*/
	/*if(playerData[playerid][pSleep] < 5)
	{
	    new Float:hp;
	    GetPlayerHealth(playerid, hp);
	    SetPlayerHealth(playerid, hp-0.1);
	    SendClientMessage(playerid, -1, "{C42D04}[ คำเตือน ] {F96C46}: ตัวละครของคุณกำลัง 'เกิดอาการง่วงอย่างหนัก'!");
	}*/
/*	if(playerData[playerid][pBath] < 5)
	{
	    new Float:hp;
	    GetPlayerHealth(playerid, hp);
	    SetPlayerHealth(playerid, hp-0.1);
	    SendClientMessage(playerid, -1, "{C42D04}[ คำเตือน ] {F96C46}: ตัวละครของคุณกำลัง 'มีกลิ่นตัวเหม็นออกมาจากร่างกาย'!");
	}*/
    return 1;
}

forward OnProgressUpdate(playerid, progress, objectid);
forward OnProgressFinish(playerid, objectid);

StartProgress(playerid, duration, startvalue = 0, objectid)
{
	if(ProgressState[playerid] == 1)
		return 0;

	stop ProgressTimer[playerid];
	ProgressTimer[playerid] = repeat ProgressUpdate(playerid, objectid);

	ProgressLimit[playerid] = duration;
	ProgressCount[playerid] = startvalue;
	ProgressState[playerid] = 1;
	ProgressObject[playerid] = objectid;

	new str[64];
	format(str, sizeof(str), "Working");
	PlayerTextDrawSetString(playerid, WorkTD[playerid][0], str);
	PlayerTextDrawShow(playerid, WorkTD[playerid][0]);
	SetTimerEx("WorkLoad", 250, false, "d", 2, playerid);
	return 1;
}

StopProgress(playerid)
{
	if(ProgressState[playerid] == 0)
		return 0;

	stop ProgressTimer[playerid];
	ProgressLimit[playerid] = 0;
	ProgressCount[playerid] = 0;
	ProgressState[playerid] = 0;
	ProgressObject[playerid] = INVALID_STREAMER_ID;

	PlayerTextDrawHide(playerid, WorkTD[playerid][0]);
	ClearAnimations(playerid);
	return 1;
}

timer ProgressUpdate[100](playerid, objectid)
{
	if(ProgressCount[playerid] >= ProgressLimit[playerid])
	{
		StopProgress(playerid);
		CallLocalFunction("OnProgressFinish", "dd", playerid, objectid);
		return;
	}

	CallLocalFunction("OnProgressUpdate", "ddd", playerid, ProgressCount[playerid], objectid);
	ProgressCount[playerid]++;
	return;
}
forward WorkLoad(number, playerid);
public WorkLoad(number, playerid)
{
	new str[128];
	if(ProgressCount[playerid] >= ProgressLimit[playerid])
		return 1;
	switch(number)
	{
	    case 1:
	    {
			format(str, sizeof(str), "Working");
			PlayerTextDrawSetString(playerid, WorkTD[playerid][0], str);
			SetTimerEx("WorkLoad", 250, false, "d", 2);
	    }
	    case 2:
	    {
			format(str, sizeof(str), "Working.");
			PlayerTextDrawSetString(playerid, WorkTD[playerid][0], str);
			SetTimerEx("WorkLoad", 250, false, "d", 3);
	    }
	    case 3:
	    {
			format(str, sizeof(str), "Working..");
			PlayerTextDrawSetString(playerid, WorkTD[playerid][0], str);
			SetTimerEx("WorkLoad", 250, false, "d", 4);
	    }
	    case 4:
	    {
			format(str, sizeof(str), "Working...");
			PlayerTextDrawSetString(playerid, WorkTD[playerid][0], str);
			SetTimerEx("WorkLoad", 250, false, "d", 1);
	    }
	}
    return 1;
}

/*ptask PlayerProgressSecond[500](playerid)
{
	if (ProgressState[playerid] == 1)
	{
		if (ProgressCount[playerid] >= 5)
		{
			PlayerTextDrawHide(playerid, ProgressTD[playerid][5]);
			PlayerTextDrawColor(playerid, ProgressTD[playerid][5], COLOR_WHITE);
			PlayerTextDrawShow(playerid, ProgressTD[playerid][5]);
		}
		if (ProgressCount[playerid] >= 10)
		{
			PlayerTextDrawHide(playerid, ProgressTD[playerid][6]);
			PlayerTextDrawColor(playerid, ProgressTD[playerid][6], COLOR_WHITE);
			PlayerTextDrawShow(playerid, ProgressTD[playerid][6]);
		}
		if (ProgressCount[playerid] >= 20)
		{
			PlayerTextDrawHide(playerid, ProgressTD[playerid][7]);
			PlayerTextDrawColor(playerid, ProgressTD[playerid][7], COLOR_WHITE);
			PlayerTextDrawShow(playerid, ProgressTD[playerid][7]);
		}
		if (ProgressCount[playerid] >= 30)
		{
			PlayerTextDrawHide(playerid, ProgressTD[playerid][8]);
			PlayerTextDrawColor(playerid, ProgressTD[playerid][8], COLOR_WHITE);
			PlayerTextDrawShow(playerid, ProgressTD[playerid][8]);
		}
		if (ProgressCount[playerid] >= 40)
		{
			PlayerTextDrawHide(playerid, ProgressTD[playerid][9]);
			PlayerTextDrawColor(playerid, ProgressTD[playerid][9], COLOR_WHITE);
			PlayerTextDrawShow(playerid, ProgressTD[playerid][9]);
		}
		if (ProgressCount[playerid] >= 50)
		{
			PlayerTextDrawHide(playerid, ProgressTD[playerid][10]);
			PlayerTextDrawColor(playerid, ProgressTD[playerid][10], COLOR_WHITE);
			PlayerTextDrawShow(playerid, ProgressTD[playerid][10]);
		}
		if (ProgressCount[playerid] >= 60)
		{
			PlayerTextDrawHide(playerid, ProgressTD[playerid][11]);
			PlayerTextDrawColor(playerid, ProgressTD[playerid][11], COLOR_WHITE);
			PlayerTextDrawShow(playerid, ProgressTD[playerid][11]);
		}
		if (ProgressCount[playerid] >= 70)
		{
			PlayerTextDrawHide(playerid, ProgressTD[playerid][15]);
			PlayerTextDrawColor(playerid, ProgressTD[playerid][15], COLOR_WHITE);
			PlayerTextDrawShow(playerid, ProgressTD[playerid][15]);
		}
		if (ProgressCount[playerid] >= 80)
		{
			PlayerTextDrawHide(playerid, ProgressTD[playerid][12]);
			PlayerTextDrawColor(playerid, ProgressTD[playerid][12], COLOR_WHITE);
			PlayerTextDrawShow(playerid, ProgressTD[playerid][12]);
		}
		if (ProgressCount[playerid] >= 90)
		{
			PlayerTextDrawHide(playerid, ProgressTD[playerid][13]);
			PlayerTextDrawColor(playerid, ProgressTD[playerid][13], COLOR_WHITE);
			PlayerTextDrawShow(playerid, ProgressTD[playerid][13]);
		}
		if (ProgressCount[playerid] >= 99)
		{
			PlayerTextDrawHide(playerid, ProgressTD[playerid][14]);
			PlayerTextDrawColor(playerid, ProgressTD[playerid][14], COLOR_WHITE);
			PlayerTextDrawShow(playerid, ProgressTD[playerid][14]);
		}
	}
	return 1;
}*/


bool:CheckItemDrugs(const item[])
{
	for (new i = 0; i < sizeof(drugsInfo); i ++)
	{
		if (!strcmp(item, drugsInfo[i][itemName], true))
		{
			return true;
		}
	}
	return false;
}

forward OnPlayerClickItem(playerid, itemid,  name[]);
public OnPlayerClickItem(playerid, itemid,  name[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
    playerData[playerid][pItemSelect] = itemid;
	switch (playerData[playerid][pStorageSelect])
	{
		case 0:
		{
			if (!strcmp(name, "iFruit", true))
			{
				SetPlayerChatBubble(playerid, "** หยิบมือถือออกมา", COLOR_PURPLE, 5.0, 5000);
				return ShowPlayerPhone(playerid);
			}
			if (!strcmp(name, "MedicCase", true))
			{
				Dialog_Show(playerid, DIALOG_INVENTORYMENU1, DIALOG_STYLE_LIST, name, "ใช้\nทิ้ง", "เลือก", "กลับ");
			}
			if (!strcmp(name, "Watch", true))
			{
				Dialog_Show(playerid, DIALOG_INVENTORYMENU1, DIALOG_STYLE_LIST, name, "ใช้\nทิ้ง", "เลือก", "กลับ");
			}
			else if (!strcmp(name, "DrivingLicense", true))
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
					if (IsPlayerNearPlayer(playerid, i, 2.5))
					{
						format(string, sizeof(string), "(id: %d)\t%s\n", i, GetPlayerNameEx(i));
						strcat(string2, string);
						format(var, sizeof(var), "DrivingLincense%d", count);
						SetPVarInt(playerid, var, i);
						count++;
						playerData[playerid][pItemOfferID] = i;
					}
				}
				if (!count)
				{
					
					Dialog_Show(playerid, DrivingLincenseerorr, DIALOG_STYLE_LIST, "Driving Lincense","{FF6347}- ไม่พบผู้เล่นอยู่บริเวณรอบๆ ตัวของคุณ","ปิด","");
					return 1;
				}
				format(string, sizeof(string), " ไอดี\t    รายชื่อ\n%s", string2);
				Dialog_Show(playerid, DrivingLincense, DIALOG_STYLE_TABLIST_HEADERS, "Driving Lincense", string, "เลือก", "ยกเลิก");
				return 1;
			}
			else if (!strcmp(name, "Radio", true))
			{
		        Dialog_Show(playerid, DIALOG_INVENTORYMENU1, DIALOG_STYLE_LIST, name, "ใช้\nทิ้ง", "เลือก", "กลับ");
			}
			else if (!strcmp(name, "Camera", true))
			{
		        Dialog_Show(playerid, DIALOG_INVENTORYMENU1, DIALOG_STYLE_LIST, name, "ใช้\nทิ้ง", "เลือก", "กลับ");
			}
			else if (!strcmp(name, "PepperSpray", true))
			{
		        Dialog_Show(playerid, DIALOG_INVENTORYMENU1, DIALOG_STYLE_LIST, name, "ใช้\nทิ้ง", "เลือก", "กลับ");
			}
			else
			{
				Dialog_Show(playerid, DIALOG_INVENTORYMENU, DIALOG_STYLE_LIST, name, "ใช้\nให้\nทิ้ง", "เลือก", "กลับ");
			}
		}
		case 2:
		{
			if (!strcmp(name, "iFruit", true))
			{
				SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: ไม่สามารถจัดเก็บ '%s' ไว้ภายในยานพาหนะได้", name); 
				OpenInventoryTrunk(playerid);
				return 1;
			}
				
			if (!strcmp(name, "MedicCase", true))
			{
				SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: ไม่สามารถจัดเก็บ '%s' ไว้ภายในยานพาหนะได้", name); 
				OpenInventoryTrunk(playerid);
				return 1;
			}
			if (!strcmp(name, "Watch", true))
			{
				SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: ไม่สามารถจัดเก็บ '%s' ไว้ภายในยานพาหนะได้", name); 
				OpenInventoryTrunk(playerid);
				return 1;
			}
			if (!strcmp(name, "DrivingLicense", true))
			{
				SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Inventory]: ไม่สามารถจัดเก็บ '%s' ไว้ภายในยานพาหนะได้", name); 
				OpenInventoryTrunk(playerid);
				return 1;
			}
			new
				string[128],
				id = GetNearestVehicle(playerid);

			if(IsVehicleOwner(playerid, id) || playerData[playerid][pVehicleKeys] == id)
			{
				if(Trunk_Items(id) >= carData[id][carTrunk] && !Trunk_HasItem(id, invData[playerid][itemid][invItem]))
				{
					OpenInventoryTrunk(playerid);
					SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Trunk]: ช่องเก็บของยานพาหนะ ของคุณนั้นเต็มแล้ว! ( %d/%d )", Trunk_Items(id), carData[id][carTrunk]);
					return 1; 
				}

				if (invData[playerid][itemid][invQuantity] == 1)
				{
					if(Trunk_Count(id, invData[playerid][itemid][invItem]) >= carData[id][carTrunkQuantity])
					{
						OpenInventoryTrunk(playerid);
						SendClientMessageEx(playerid, COLOR_LIGHTRED, "[Trunk]: ไม่สามารถจัดเก็บ '%s' ได้อีก เนื่องจากช่องเก็บของบนยานพาหนะนั้นเต็มแล้ว", invData[playerid][itemid][invItem]);
						return 1; 
					}
					Trunk_Add(id, invData[playerid][itemid][invItem], 1);
					Inventory_RemoveEx(playerid, itemid, 1);
					SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s จัดเก็บ '%s' ใส่ไว้ภายในยานพาหนะ %s (( จำนวน: 1 ))", GetPlayerNameEx(playerid), invData[playerid][itemid][invItem], ReturnVehicleName(id));
					OpenInventoryTrunk(playerid);
				//	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้จัดเก็บ \"%s\" ใส่กระโปรงหลังรถ", GetPlayerNameEx(playerid), invData[playerid][itemid][invItem]);
					//OpenInventoryTrunk(playerid, id);
				
				}
				else 
				{
					format(string, sizeof(string), "%s", ReturnVehicleName(id));
					Dialog_Show(playerid, CarDeposit, DIALOG_STYLE_INPUT, string, "{FFA84D}%s {FFFFFF}| {FFA84D}จำนวน: %d{FFFFFF}\nโปรดระบุจำนวนที่ต้องการจะเก็บใส่ยานพาหนะ", "ตกลง", "ย้อนกลับ", invData[playerid][itemid][invItem], invData[playerid][itemid][invQuantity]);
				}
			}
   		}
	}
 	return 1;
}


Dialog:CarDeposit(playerid, response, listitem, inputtext[])
{
	new itemid = playerData[playerid][pItemSelect];

	new amount = strval(inputtext),
		string[128],
		id = GetNearestVehicle(playerid), 
		count = Inventory_Count(playerid, invData[playerid][itemid][invItem]);

	format(string, sizeof(string), "%s", ReturnVehicleName(id));
	if (!response)
	{
		playerData[playerid][INV] = 1;
		ShowPlayerInventory(playerid, true);
		playerData[playerid][pStorageSelect] = 2;
		return 1;
	}
	if (response)
	{
		if(sscanf(inputtext, "d", amount))
		    return Dialog_Show(playerid, CarDeposit, DIALOG_STYLE_INPUT, string, "{FFA84D}%s {FFFFFF}| {FFA84D}จำนวน: %d{FFFFFF}\nโปรดระบุจำนวนที่ต้องการจะเก็บใส่ยานพาหนะ", "ตกลง", "ย้อนกลับ", invData[playerid][itemid][invItem], invData[playerid][itemid][invQuantity]);

		if(amount < 1)
			return Dialog_Show(playerid, CarDeposit, DIALOG_STYLE_INPUT, string, "{FFA84D}%s {FFFFFF}| {FFA84D}จำนวน: %d{FFFFFF}\nโปรดระบุจำนวนที่ต้องการจะเก็บใส่ยานพาหนะ", "ตกลง", "ย้อนกลับ", invData[playerid][itemid][invItem], invData[playerid][itemid][invQuantity]);

		if(amount > count)
			return Dialog_Show(playerid, CarDeposit, DIALOG_STYLE_INPUT, string, "{FFA84D}%s {FFFFFF}| {FFA84D}จำนวน: %d{FFFFFF}\nโปรดระบุจำนวนที่ต้องการจะเก็บใส่ยานพาหนะ\n{FF6347}*จัดเก็บ '%s' ไม่สำเร็จ เนื่องจากคุณมีจำนวนไม่เพียงพอ", "ตกลง", "ย้อนกลับ", invData[playerid][itemid][invItem], invData[playerid][itemid][invQuantity], invData[playerid][itemid][invItem]);

		if(amount> carData[id][carTrunkQuantity]-Trunk_Count(id, invData[playerid][itemid][invItem]))
			return Dialog_Show(playerid, CarDeposit, DIALOG_STYLE_INPUT, string, "{FFA84D}%s {FFFFFF}| {FFA84D}จำนวน: %d{FFFFFF}\nโปรดระบุจำนวนที่ต้องการจะเก็บใส่ยานพาหนะ\n\
			{FF6347}*จัดเก็บ '%s' ไม่สำเร็จ เนื่องจากช่องเก็บบนยานพาหนะไม่เพียงพอ", "ตกลง", "ย้อนกลับ", 
			invData[playerid][itemid][invItem], invData[playerid][itemid][invQuantity], invData[playerid][itemid][invItem]);
		
		/*if(amount > Trunk_Count(id, trunkData[id][itemid][trunkItem])-count)
			return Dialog_Show(playerid, CarDeposit, DIALOG_STYLE_INPUT, string, "{FFA84D}%s {FFFFFF}| {FFA84D}จำนวน: %d{FFFFFF}\nโปรดระบุจำนวนที่ต้องการจะเก็บใส่ยานพาหนะ\n\
			{FF6347}*ไม่สามารถจัดเก็บ '%s' ได้อีกเนื่องจากช่องเก็บของบนยานพาหนะนั้นเต็มแล้ว", "ตกลง", "ย้อนกลับ", invData[playerid][itemid][invItem], invData[playerid][itemid][invQuantity], invData[playerid][itemid][invItem]);
*/
		/*
			*/
		/*if(amount >= carData[id][carTrunkQuantity])
		{
			OpenInventoryTrunk(playerid);
			return SendClientMessage(playerid, COLOR_LIGHTRED, "[Trunk]: ไม่สามารถจัดเก็บ '%s' ได้อีก เนื่องจากช่องเก็บของบนยานพาหนะนั้นเต็มแล้ว", invData[playerid][itemid][invItem]);
		}*/

		Trunk_Add(id, invData[playerid][itemid][invItem], amount);
		Inventory_RemoveEx(playerid, itemid, amount);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s จัดเก็บ '%s' ใส่ไว้ภายในยานพาหนะ %s (( จำนวน: %d ))", GetPlayerNameEx(playerid), invData[playerid][itemid][invItem], ReturnVehicleName(id), amount);
		OpenInventoryTrunk(playerid);
		return 1;
	}
	return 1;
}


Dialog:DrivingLincense(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new var[15];
		format(var, sizeof(var), "DrivingLincense%d", listitem);
		new userid = playerData[playerid][pItemOfferID];
		playerData[playerid][pPayMoneyID] = userid;	
		ShowDrivingLincese(playerid);
		return 1;
		
	}
	return 1;
}
ShowDrivingLincese(playerid)
{
	new string[128], 
	userid = playerData[playerid][pPayMoneyID];

	SetTimerEx("DrivingLincenseTimer", 10000, 0, "id", userid);
	
	format(string, sizeof(string), "Name: %s~n~Age: %d~n~Driving License: ~g~Yes~n~~w~%s", GetPlayerNameEx(userid), playerData[userid][pAge], playerData[userid][pRegisterDate]); 
	PlayerTextDrawSetString(playerid, DrivingLicenseTD[playerid][3], string);
	ShowPlayerDrivingLincese(userid);	
	format(string, sizeof(string), "Name: %s~n~Age: %d~n~Driving License: ~g~Yes~n~~w~%s", GetPlayerNameEx(userid), playerData[userid][pAge], playerData[userid][pRegisterDate]); 
	PlayerTextDrawSetString(playerid, DrivingLicenseTD[playerid][3], string);

	ApplyAnimation(playerid,"GANGS","DEALER_DEAL", 2.0,  0, 0, 0, 0, 0, 1);

	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s ได้แสดง 'Driving License' ให้ %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));

	return 1;
}

forward DrivingLincenseTimer(userid, type);
public DrivingLincenseTimer(userid, type)
{
	HidePlayerDrivingLincese(userid);
}


forward Contact_Load(playerid);
public Contact_Load(playerid)
{
	static
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows && i < MAX_CONTACTS; i ++)
	{
		cache_get_value_name(i, "contactName", contactData[playerid][i][contactName], 32);

		contactData[playerid][i][contactExists] = true;
	    cache_get_value_name_int(i, "contactID", contactData[playerid][i][contactID]);
	    cache_get_value_name_int(i, "contactNumber", contactData[playerid][i][contactNumber]);
	}
	return 1;
}

GetNumberOwner(number)
{
	foreach (new i : Player) if (playerData[i][pPhone] == number && Inventory_HasItem(i, "iFruit"))
	{
		return i;
	}
	return INVALID_PLAYER_ID;
}

ShowContacts(playerid)
{
	new
	    string[32 * MAX_CONTACTS],
		count = 0;

	string = "รายชื่อ\tเบอร์มือถือ\n{FF6347}แจ้งเหตุด่วน-ฉุกเฉิน\t{FFA84D}#911\n";

	for (new i = 0; i != MAX_CONTACTS; i ++) if (contactData[playerid][i][contactExists])
	{
	    format(string, sizeof(string), "%s- %s \t{FFA84D}#%s\n", string, contactData[playerid][i][contactName], FormatNumberPhone(contactData[playerid][i][contactNumber]));
		ListedContacts[playerid][count++] = i;
	}
	Dialog_Show(playerid, DIALOG_CONTACTS, DIALOG_STYLE_TABLIST_HEADERS, "[List Contact]", string, "เลือก", "กลับ");
	return 1;
}
Dialog:DIALOG_CONTACTS(playerid, response, listitem, inputtext[])
{
	new string[128];
	if (response)
	{
	    if (!listitem)
		{
			playerData[playerid][pEmergency] = 1;

			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][2], "> Police");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][2], 1296911871);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][2]);

			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][0], "Medic");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][0], 1296911816);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][0]);

			PlayerTextDrawSetString(playerid, Phone_MenuTD[playerid][1], "Mechanic");
			PlayerTextDrawBoxColor(playerid, Phone_MenuTD[playerid][1], 1296911816);
			PlayerTextDrawShow(playerid, Phone_MenuTD[playerid][1]);
			return 1;
		}
	    else {
		    playerData[playerid][pContact] = ListedContacts[playerid][listitem - 1];

			format(string, 16, "%s", contactData[playerid][playerData[playerid][pContact]][contactName]);
	        Dialog_Show(playerid, DIALOG_CONINFO, DIALOG_STYLE_LIST, string, "\
			- Call (โทร)\n\
			- SMS (ส่งข้อความ)\n\
			- Give Location (แชร์โลเคชั่น)\n\
			{FF0000}Romove Contact (ลบรายชื่อติดต่อ)", "เลือก", "กลับ");
	    }
		return 1;
	}
	for (new i = 0; i != MAX_CONTACTS; i ++)
	{
	    ListedContacts[playerid][i] = -1;
	}
	return 1;
}

Dialog:DIALOG_CONINFO(playerid, response, listitem, inputtext[])
{
	PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	if (response)
	{
	    new
			id = playerData[playerid][pContact],
			string[72],
			targetid;

		switch (listitem)
		{
		    case 0: //โทร
		    {
		        //format(string, 16, "%d", contactData[playerid][id][contactNumber]);
				if ((targetid = GetNumberOwner(contactData[playerid][id][contactNumber])) != INVALID_PLAYER_ID)
				{
					
					if (targetid == playerid)
						return SendClientMessage(playerid, COLOR_LIGHTRED, "[Phone]: ไม่สามารถโทรหาตัวเองได้");

					if (playerData[targetid][pPhoneOff])
						return SendClientMessage(playerid, COLOR_LIGHTRED, "[Phone]: เบอร์ปลายทางปิดเครื่องมือถือในขณะนี้");

					if (playerData[targetid][pCuffed])
						return SendClientMessage(playerid, COLOR_LIGHTRED, "[Phone]: หมายเลขที่ท่านเรียกไม่สามารถติดต่อได้ในขณะนี้");

					playerData[targetid][pIncomingCall] = 1;
					playerData[playerid][pIncomingCall] = 1;

					playerData[targetid][pIncomingCalling] = 1;
					playerData[playerid][pIncomingCalling] = 1;

					playerData[targetid][pCallLine] = playerid;
					playerData[playerid][pCallLine] = targetid;

					PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
					PlayerPlaySoundEx(targetid, 23000);
					SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);

					SendClientMessage(playerid, COLOR_YELLOW, "[Phone]: กด 'N' เพื่อจัดการมือถือ");
					format(string, sizeof(string), "Calling...~n~(%s)", FormatNumberPhone(contactData[targetid][id][contactNumber]));
					PlayerTextDrawSetString(playerid, PhoneTD[playerid][12], string);
					PlayerTextDrawShow(playerid, PhoneTD[playerid][12]);
					PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][0]);
					PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][1]);
					PlayerTextDrawHide(playerid, Phone_MenuTD[playerid][2]);	

					PlayerTextDrawSetString(playerid, PhoneTD[playerid][14], "Answer");
					PlayerTextDrawShow(playerid, PhoneTD[playerid][14]);
					PlayerTextDrawSetString(playerid, PhoneTD[playerid][15], "Hangup");
					PlayerTextDrawShow(playerid, PhoneTD[playerid][15]);
					CancelSelectTextDraw(playerid);



					ShowPlayerPhone(targetid);
					PlayerTextDrawSetString(targetid, PhoneTD[playerid][14], "Answer");
					PlayerTextDrawShow(targetid, PhoneTD[playerid][14]);
					PlayerTextDrawSetString(targetid, PhoneTD[playerid][15], "Hangup");
					PlayerTextDrawShow(targetid, PhoneTD[playerid][15]);

					SendClientMessage(targetid, COLOR_YELLOW, "[Phone]: กด 'N' เพื่อจัดการมือถือ");
					format(string, sizeof(string), "Calling...~n~(%s)", FormatNumberPhone(contactData[playerid][id][contactNumber]));
					PlayerTextDrawSetString(targetid, PhoneTD[playerid][12], string);
					PlayerTextDrawShow(targetid, PhoneTD[playerid][12]);
					PlayerTextDrawHide(targetid, Phone_MenuTD[playerid][0]);
					PlayerTextDrawHide(targetid, Phone_MenuTD[playerid][1]);
					PlayerTextDrawHide(targetid, Phone_MenuTD[playerid][2]);
					PlayerTextDrawHide(targetid, PhoneTD[playerid][13]);
					CancelSelectTextDraw(targetid);
					ClearAnimations(targetid);
					//SelectTextDraw(targetid, 0x58ACFAFF);
				}
				else return ShowContacts(playerid);
		    }
			case 1: //ส่งข้อความ
			{
				if ((targetid = GetNumberOwner(contactData[playerid][id][contactNumber])) != INVALID_PLAYER_ID)
				{
					if (targetid == playerid)
						return SendClientMessage(playerid, COLOR_LIGHTRED, "[Phone]: ไม่สามารถส่งข้อความถึงตัวเองได้");

					if (playerData[targetid][pCuffed])
						return SendClientMessage(playerid, COLOR_LIGHTRED, "[Phone]: หมายเลขที่ท่านต้องการส่งข้อความถึง ไม่สามารถติดต่อได้ในขณะนี้");
					
					Dialog_Show(playerid, PH_Sms_Type, DIALOG_STYLE_INPUT, "ส่งข้อความ (SMS)", "{FFFFFF}โปรดระบุข้อความที่คุณต้องการจะส่งถึง '%s'", "ส่ง", "ปิด", contactData[playerid][id][contactName]);
				}
				else return ShowContacts(playerid);

				playerData[playerid][pCallLine] = targetid;
				playerData[playerid][pIncomingCall] = contactData[playerid][id][contactNumber];
				return 1;
			}
			case 2: //ส่งโล
			{

				if (targetid == INVALID_PLAYER_ID)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "[Phone]: หมายเลขที่ท่านต้องการแชร์โลเคชั่นถึง ไม่สามารถติดต่อได้ในขณะนี้");

				if (!IsPlayerSpawnedEx(targetid))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "[Phone]: หมายเลขที่ท่านต้องการแชร์โลเคชั่นถึง ไม่สามารถติดต่อได้ในขณะนี้");

				new Float:X, Float:Y, Float:Z;

				GetPlayerPos(playerid, X,Y,Z);
				SetPlayerCheckpoint(targetid, X,Y,Z, 2.0);

				SendClientMessageEx(targetid, playerid, "[Phone]: คุณได้แชร์โลเคชั่นของคุณให้กับ '%s - #%s' เรียบร้อย", contactData[playerid][id][contactName], FormatNumberPhone(contactData[playerid][id][contactNumber]));
				SendClientMessageEx(targetid, COLOR_YELLOW, "[Phone]: %s - #%s ได้แชร์โลเคชั่นให้กับคุณ", GetPlayerNameEx(playerid), FormatNumberPhone(playerData[playerid][pPhone]));
				return 1;
			}
		    case 3: //ลบผู้ติดต่อ
		    {
		        mysql_format(g_SQL, string, sizeof(string), "DELETE FROM `contacts` WHERE `ID` = '%d' AND `contactID` = '%d'", playerData[playerid][pID], contactData[playerid][id][contactID]);
		        mysql_tquery(g_SQL, string);

		        SendClientMessageEx(playerid, COLOR_YELLOW, "[Phone]: คุณได้ลบ \"%s\" ออกจากรายชื่อผู้ติดต่อ", contactData[playerid][id][contactName]);

		        contactData[playerid][id][contactExists] = false;
		        contactData[playerid][id][contactNumber] = 0;
		        contactData[playerid][id][contactID] = 0;

		        ShowContacts(playerid);
		    }
		}
	}
	else return ShowContacts(playerid);
	return 1;
}
CancelCall(playerid)
{
    if (playerData[playerid][pCallLine] != INVALID_PLAYER_ID)
	{
 		playerData[playerData[playerid][pCallLine]][pCallLine] = INVALID_PLAYER_ID;
   		playerData[playerData[playerid][pCallLine]][pIncomingCall] = 0;
   		playerData[playerData[playerid][pCallLine]][pIncomingCalling] = 0;

		playerData[playerid][pCallLine] = INVALID_PLAYER_ID;
		playerData[playerid][pIncomingCall] = 0;
		playerData[playerid][pIncomingCalling] = 0;
	}
	return 1;
}

PlayerPlaySoundEx(playerid, sound)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(playerid, x, y, z);

	foreach (new i : Player) if (IsPlayerInRangeOfPoint(i, 20.0, x, y, z))
	{
	    PlayerPlaySound(i, sound, x, y, z);
	}
	return 1;
}

IsPlayerOnPhone(playerid)
{
	if (playerData[playerid][pEmergency] > 0 || playerData[playerid][pCallLine] != INVALID_PLAYER_ID)
	    return 1;

	return 0;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if (playerData[playerid][pAdmin] >= 4)
	{
    	SetPlayerPosFindZ(playerid, fX, fY, fZ+5);
	}
	return 1;
}





public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ){
	if(response){
		if(GetPVarInt(playerid, "GetObjectID")){
			DeletePVar(playerid, "GetObjectID");
			SetPlayerAttachedObject(playerid, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ);
			printf("SetPlayerAttachedObject(%d,%d,%d,%d,%f,%f,%f,%f,%f,%f,%f,%f,%f);", playerid, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ);

			SendClientMessageEx(playerid, COLOR_GREEN, "%d Attached object ถูกบันทึกแล้ว",modelid);
		}
	}
	return 1;
}



GetPlayerSQLID(playerid)
{
	return (playerData[playerid][pID]);
}


stock SendAdminAlert(color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (playerData[i][pAdmin] >= 1) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (playerData[i][pAdmin] >= 1) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

forward ModCar(playerid);
public ModCar(playerid)
{
	switch(pmodelid[playerid])
	{
        case 562,565,559,561,560,575,534,567,536,535,576,411,579,602,496,518,527,589,597,419,
		533,526,474,545,517,410,600,436,580,439,549,491,445,604,507,585,587,466,492,546,551,516,
		426, 547, 405, 409, 550, 566, 540, 421,	529,431,438,437,420,525,552,416,433,427,490,528,
		407,544,470,598,596,599,601,428,499,609,524,578,486,406,573,455,588,403,514,423,
		414,443,515,456,422,482,530,418,572,413,440,543,583,478,554,402,542,603,475,568,504,457,
        483,508,429,541,415,480,434,506,451,555,477,400,404,489,479,442,458,467,558:
		{
		    ShowMenuForPlayer(TuningMenu, playerid);
		    TogglePlayerControllable(playerid,0);
 			return SendClientMessage(playerid, COLOR_WHITE, "[Server]: เลือกรายการแล้วกดปุ่ม Spacebar");
		}
		default: return SendClientMessage(playerid,COLOR_RED,"[Server]: คุณไม่สามารถแต่งรถคันนี้ได้");
	}
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:Current = GetPlayerMenu(playerid);
	if(Current == TuningMenu)
	{
	    switch(row)
		{
	        case 0:	ShowMenuForPlayer(Paintjobs, playerid);
	        case 1:	ShowMenuForPlayer(Colors, playerid);
	        case 2: ShowMenuForPlayer(Exhausts, playerid);
	        case 3:ShowMenuForPlayer(Frontbumper, playerid);
	        case 4:ShowMenuForPlayer(Rearbumper, playerid);
	        case 5:ShowMenuForPlayer(Roof, playerid);
	        case 6:ShowMenuForPlayer(Spoilers, playerid);
	        case 7:ShowMenuForPlayer(Sideskirts, playerid);
			case 8:ShowMenuForPlayer(Bullbars, playerid);
	        case 9:ShowMenuForPlayer(Wheels, playerid);
	        case 10:ShowMenuForPlayer(Carstereo, playerid);
	        case 11:ShowMenuForPlayer(TuningMenu1, playerid);
		}
	}
	if(Current == Paintjobs)
	{
		switch(row)
		{
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560 ||
				pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 || // Broadway
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 535 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 558)
		        {
					new car = GetPlayerVehicleID(playerid);
					ChangeVehiclePaintjob(car,0);
					SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เพ้นท์สีรถเรียบร้อยแล้ว");
					ShowMenuForPlayer(Paintjobs, playerid);
				}
				else
				{
				   SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] รถรุ่นนี้ไม่สามารถเพ้นท์ได้");
			       ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 1:
			    if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560 ||
				pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 || // Broadway
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 535 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 558)
			    {
	                new car = GetPlayerVehicleID(playerid);
					ChangeVehiclePaintjob(car,1);
					SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เพ้นท์สีรถเรียบร้อยแล้ว");
					ShowMenuForPlayer(Paintjobs, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] รถรุ่นนี้ไม่สามารถเพ้นท์ได้");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
	      		if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560 ||
				pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 || // Broadway
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 535 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 558)
			    {
	                new car = GetPlayerVehicleID(playerid);
					ChangeVehiclePaintjob(car,2);
					SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เพ้นท์สีรถเรียบร้อยแล้ว");
					ShowMenuForPlayer(Paintjobs, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] รถรุ่นนี้ไม่สามารถเพ้นท์ได้");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:
			    if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560 ||
				pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 || // Broadway
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 535 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 558)
			    {
	                new car = GetPlayerVehicleID(playerid);
					ChangeVehiclePaintjob(car,3);
					SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เพ้นท์สีรถเรียบร้อยแล้ว");
					ShowMenuForPlayer(Paintjobs, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] รถรุ่นนี้ไม่สามารถเพ้นท์ได้");
				    ShowMenuForPlayer(TuningMenu, playerid);
			}

			case 4:
		    if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560 ||
				pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 || // Broadway
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 535 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 558)
			    {
	                new car = GetPlayerVehicleID(playerid);
					ChangeVehiclePaintjob(car,4);
					SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เพ้นท์สีรถเรียบร้อยแล้ว");
					ShowMenuForPlayer(Paintjobs, playerid);
				}
				else
				{
	            	SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] รถรุ่นนี้ไม่สามารถเพ้นท์ได้");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
				case 5:
			{
		    	ShowMenuForPlayer(TuningMenu, playerid);
			}

		}
		}

	if(Current == Colors) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            ChangeVehicleColor(car,0,0);
		            //GivePlayerMoney(playerid,-150);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เปลี่ยนสีรถแล้ว");
		            ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 1:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,1,1);
			    //    GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เปลี่ยนสีรถแล้ว");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,3,3);
			      //  GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เปลี่ยนสีรถแล้ว");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
	      		 	SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,79,79);
			     //   GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เปลี่ยนสีรถแล้ว");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 4:
				if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,86,86);
			     //   GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เปลี่ยนสีรถแล้ว");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 5:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,6,6);
			      //  GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เปลี่ยนสีรถแล้ว");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	            case 6:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,126,126);
			  //      GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เปลี่ยนสีรถแล้ว");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 7:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,66,66);
			    //    GivePlayerMoney(playerid,-150);
	          		SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เปลี่ยนสีรถแล้ว");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 8:ShowMenuForPlayer(Colors1, playerid);
	 }
	 }

	if(Current == Colors1) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            ChangeVehicleColor(car,24,24);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เปลี่ยนสีรถแล้ว");
		            ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	         case 1:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,123,123);
	          		SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เปลี่ยนสีรถแล้ว");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,53,53);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เปลี่ยนสีรถแล้ว");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,93,93);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เปลี่ยนสีรถแล้ว");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 4:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,83,83);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เปลี่ยนสีรถแล้ว");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 5:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,60,60);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เปลี่ยนสีรถแล้ว");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	            case 6:
	      		if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,126,126);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เปลี่ยนสีรถแล้ว");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 7:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,110,110);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้เปลี่ยนสีรถแล้ว");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 8:ShowMenuForPlayer(TuningMenu, playerid);
	 }
	 }


	if(Current == Exhausts) {
		switch(row){
		    case 0:

		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562)
		            {
		            	AddVehicleComponentEx(car,1034);
		            	SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Exhaust component on Elegy");
		            	ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 565)
					{
					    AddVehicleComponentEx(car,1046);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Exhaust component on Flash");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 559)
					{
					    AddVehicleComponentEx(car,1065);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Exhaust component on Jetser");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 561)
					{
					    AddVehicleComponentEx(car,1064);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Exhaust component on Stratum");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 560)
					{
					    AddVehicleComponentEx(car,1028);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Exhaust component on Sultan");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 558)
					{
					    AddVehicleComponentEx(car,1089);
				 	    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Exhaust component on Uranus");
					    ShowMenuForPlayer(Exhausts, playerid);
	    			}
					}
	  			 	else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}



	//-------------------X-Flow Exausts-Wheel Arch Cars----------------------------------------------------------
			case 1:
			    if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562)
			        {
			            AddVehicleComponentEx(car,1037);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Exhaust component on Elegy");
			            ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 565)
					{
					    AddVehicleComponentEx(car,1045);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Exhaust component on Flash");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 559)
					{
					    AddVehicleComponentEx(car,1066);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow exaust component on Jester");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 561)
					{
					    AddVehicleComponentEx(car,1059);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Exhaust component on Stratum");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 560)
					{
					    AddVehicleComponentEx(car,1029);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Exhaust component on Sultan");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 558)
					{
					    AddVehicleComponentEx(car,1092);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Exhaust component on Uranus");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------Locos Low Chromer Exausts----------------------------------------------------------
			case 2:
			    if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 535)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponentEx(car,1044);
		             	SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer Exhaust component on Brodway");
			            ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponentEx(car,1126);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer Exhaust component on Remington");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponentEx(car,1129);
	                    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer Exhaust component on Savanna");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponentEx(car,1104);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer Exhaust component on Blade");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponentEx(car,1113);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer Exhaust component on Slamvan");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponentEx(car,1136);
					   	SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer Exhaust component on Tornado");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------Locos Low Salmin Exausts----------------------------------------------------------
			case 3:
			    if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 535)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponentEx(car,1043);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin Exhaust component on Brodway");
			            ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponentEx(car,1127);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin Exhaust component on Remingon");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponentEx(car,1132);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin Exhaust component on Savanna");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponentEx(car,1105);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin Exhaust component on Blade");
					    ShowMenuForPlayer(Exhausts, playerid);
					}

					else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponentEx(car,1114);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin Exhaust component on Slamvan");
					    ShowMenuForPlayer(Exhausts, playerid);
					}

					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponentEx(car,1135);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin Exhaust component on Tornado");
					    ShowMenuForPlayer(Exhausts, playerid);
					}

					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

			case 4:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}

	if(Current == Frontbumper) {
		switch(row){


	//-------------------Alien Front Bumper-Wheel Arch Cars----------------------------------------------------------
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
				{
		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562) // Elegy
		            {
		            	AddVehicleComponentEx(car,1171);
	              		SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien front bumper component on Elegy");
		            	ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponentEx(car,1153);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien front bumper component on Flash");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jester
					{
					    AddVehicleComponentEx(car,1160);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien front bumper component on Jester");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponentEx(car,1155);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien front bumper component on Stratum");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponentEx(car,1169);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien front bumper component on Sultan");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 558) // Uranus
					{
					    AddVehicleComponentEx(car,1166);
				 	    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien front bumper component on Uraus");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}


	//-------------------X-Flow Front Bumper-Wheel Arch Cars----------------------------------------------------------
			case 1:

				if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {

			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562) // Elegy
			        {
			            AddVehicleComponentEx(car,1172);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow front bumper component on Elegy");
			            ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponentEx(car,1152);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch  X-Flow front bumper component on Flash");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jetser
					{
					    AddVehicleComponentEx(car,1173);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch  X-Flow front bumper component on Jester");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponentEx(car,1157);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch  X-Flow front bumper component on Stratum");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponentEx(car,1170);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch  X-Flow front bumper component on Sultan");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 558)  // Uranus
					{
					    AddVehicleComponentEx(car,1165);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch  X-Flow front bumper component on Uranus");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------Locos Low Chromer Front Bumper----------------------------------------------------------
			case 2:

	      		if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 535)
				{
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponentEx(car,1174);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer front bumper component on Brodway");
			            ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponentEx(car,1179);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer front bumper component on Remington");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponentEx(car,1189);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer front bumper component on Savanna");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponentEx(car,1182);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer front bumper component on Blade");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponentEx(car,1115);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer front bumper component on Slamvan");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponentEx(car,1191);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer front bumper component on Tornado");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}



	//-------------------Locos Low Salmin Front Bumper----------------------------------------------------------
			case 3:

			    if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
	            pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 576)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponentEx(car,1175);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin front bumper component on Brodway");
			            ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponentEx(car,1185);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin front bumper component on Remington");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponentEx(car,1188);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin front bumper component on Savanna");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponentEx(car,1181);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin front bumper component on Blade");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}

				    else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponentEx(car,1116);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin front bumper component on Slamvan");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponentEx(car,1190);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin front bumper component on Tornado");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}

					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

			case 4:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}


	if(Current == Rearbumper) {
		switch(row){


	//-------------------Alien Rear Bumper-Wheel Arch Cars----------------------------------------------------------
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {

		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562) // Elegy
		            {
		            	AddVehicleComponentEx(car,1149);
	              		SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien rear bumper component on Elegy");
		            	ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponentEx(car,1150);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien rear bumper component on Flash");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jester
					{
					    AddVehicleComponentEx(car,1159);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien rear bumper component on Jester");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponentEx(car,1154);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien rear bumper component on Stratum");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponentEx(car,1141);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien rear bumper component on Sultan");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 558) // Uranus
					{
					    AddVehicleComponentEx(car,1168);
				 	    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien rear bumper component on Uranus");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------X-Flow Rear Bumper-Wheel Arch Cars----------------------------------------------------------
			case 1:

				if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {


			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562) // Elegy
			        {
			            AddVehicleComponentEx(car,1148);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch  X-Flow rear bumper component on Elegy");
			            ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponentEx(car,1151);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch  X-Flow rear bumper component on Flash");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jetser
					{
					    AddVehicleComponentEx(car,1161);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch  X-Flow rear bumper component on Jester");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponentEx(car,1156);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch  X-Flow rear bumper component on Stratum");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponentEx(car,1140);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch  X-Flow rear bumper component on Sultan");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 558)  // Uranus
					{
					    AddVehicleComponentEx(car,1167);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch  X-Flow rear bumper component on Uranus");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Chromer rear Bumper----------------------------------------------------------
			case 2:
			    if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 535)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponentEx(car,1176);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer rear bumper component on Brodway");
			            ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponentEx(car,1180);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer rear bumper component on Remington");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponentEx(car,1187);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer rear bumper component on Savanna");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponentEx(car,1184);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer rear bumper component on Blade");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponentEx(car,1109);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer rear bumper component on Slamvan");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponentEx(car,1192);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chromer rear bumper component on Tornado");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Salmin Rear Bumper----------------------------------------------------------
			case 3:
			    if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 535)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponentEx(car,1177);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin rear bumper component on Brodway");
			            ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponentEx(car,1178);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin rear bumper component on Remington");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponentEx(car,1186);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin rear bumper component on Savanna");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponentEx(car,1183);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin rear bumper component on Blade");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}

					else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponentEx(car,1110);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin rear bumper component on Slamvan");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}

					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponentEx(car,1193);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Slamin rear bumper component on Tornado");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}

					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

			case 4:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}



	if(Current == Roof) {
		switch(row){


	//-------------------Alien Roof Vent-Wheel Arch Cars----------------------------------------------------------
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {

		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562) // Elegy
		            {
		            	AddVehicleComponentEx(car,1035);
	              		SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien roof vent component on Elegy");
		            	ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponentEx(car,1054);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien roof vent component on Flash");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jester
					{
					    AddVehicleComponentEx(car,1067);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien roof vent component on Jester");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponentEx(car,1055);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien roof vent component on Stratum");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponentEx(car,1032);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien roof vent component on Sultan");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 558) // Uranus
					{
					    AddVehicleComponentEx(car,1088);
				 	    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien roof vent component on Uranus");
					    ShowMenuForPlayer(Roof, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------X-Flow Roof Vent-Wheel Arch Cars----------------------------------------------------------
			case 1:

				if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {


			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562) // Elegy
			        {
			            AddVehicleComponentEx(car,1035);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow roof vent component on Elegy");
			            ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponentEx(car,1053);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow roof vent component on Flash");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jetser
					{
					    AddVehicleComponentEx(car,1068);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow roof vent component on Jester");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponentEx(car,1061);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow roof vent component on Stratum");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponentEx(car,1033);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow roof vent component on Sultan");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 558)  // Uranus
					{
					    AddVehicleComponentEx(car,1091);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow roof vent component on Uranus");
					    ShowMenuForPlayer(Roof, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Hardtop Roof ----------------------------------------------------------
			case 2:
			    if(pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 567) // Savanna
			        {
			            AddVehicleComponentEx(car,1130);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Hardtop Roof component on Brodway");
			            ShowMenuForPlayer(Roof, playerid);
					}
	   				else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponentEx(car,1128);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Hardtop Roof component on Blade");
					    ShowMenuForPlayer(Roof, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types Savanna and Blade");
					ShowMenuForPlayer(Roof, playerid);
					}
	//-------------------Locos Low Softtop Roof ----------------------------------------------------------
			case 3:
			    if(pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 567) // Savanna
			        {
			            AddVehicleComponentEx(car,1131);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Softtop Roof component on Brodway");
			            ShowMenuForPlayer(Roof, playerid);
					}
	   				else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponentEx(car,1103);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Softtop Roof component on Blade");
					    ShowMenuForPlayer(Roof, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types Savanna and Blade");
					ShowMenuForPlayer(Roof, playerid);
					}

			case 4:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}


	if(Current == Spoilers) {
		switch(row){


	//-------------------Alien Spoilers-Wheel Arch Cars----------------------------------------------------------
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {

		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562) // Elegy
		            {
		            	AddVehicleComponentEx(car,1147);
	              		SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Spoilers component on Elegy");
		            	ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponentEx(car,1049);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Spoilers component on Flash");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jester
					{
					    AddVehicleComponentEx(car,1162);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Spoilers component on Jester");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponentEx(car,1158);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Spoilers component on Stratum");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponentEx(car,1138);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Spoilers component on Sultan");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 558) // Uranus
					{
					    AddVehicleComponentEx(car,1164);
				 	    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Spoilers component on Uranus");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}


	//-------------------X-Flow Spoilers-Wheel Arch Cars----------------------------------------------------------
			case 1:

				if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {


			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562) // Elegy
			        {
			            AddVehicleComponentEx(car,1146);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Spoilers component on Elegy");
			            ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponentEx(car,1150);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Spoilers component on Flash");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jetser
					{
					    AddVehicleComponentEx(car,1158);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Spoilers component on Jester");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponentEx(car,1060);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Spoilers component on Stratum");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponentEx(car,1139);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Spoilers component on Sultan");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 558)  // Uranus
					{
					    AddVehicleComponentEx(car,1163);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Spoilers component on Uranus");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to X-Flow Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	        	case 2:
				{
	            ShowMenuForPlayer(TuningMenu, playerid);
	            }
		}
		}


	if(Current == Sideskirts) {
		switch(row){


	//-------------------Alien Sideskirts Wheel Arch Cars----------------------------------------------------------
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {

		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562) // Elegy
		            {
		            	AddVehicleComponentEx(car,1036);
		            	AddVehicleComponentEx(car,1040);
	              		SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Side Skirts component on Elegy");
		            	ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponentEx(car,1047);
					    AddVehicleComponentEx(car,1051);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Sideskirts vent component on Flash");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jester
					{
					    AddVehicleComponentEx(car,1069);
					    AddVehicleComponentEx(car,1071);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Side Skirts component on Jester");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponentEx(car,1056);
					    AddVehicleComponentEx(car,1062);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Side Skirts component on Stratum");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponentEx(car,1026);
					    AddVehicleComponentEx(car,1027);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Side Skirts bumper component on Sultan");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 558) // Uranus
					{
					    AddVehicleComponentEx(car,1090);
					    AddVehicleComponentEx(car,1094);
				 	    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch Alien Side Skirts component on Uranus");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------X-Flow Sideskirts-Wheel Arch Cars----------------------------------------------------------
			case 1:

				if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {


			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562) // Elegy
			        {
			            AddVehicleComponentEx(car,1039);
			            AddVehicleComponentEx(car,1041);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Side Skirts component on Elegy");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponentEx(car,1048);
					    AddVehicleComponentEx(car,1052);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Side Skirts component on Flash");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jetser
					{
					    AddVehicleComponentEx(car,1070);
					    AddVehicleComponentEx(car,1072);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Side Skirts component on Jester");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponentEx(car,1057);
					    AddVehicleComponentEx(car,1063);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Side Skirts component on Stratum");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponentEx(car,1031);
					    AddVehicleComponentEx(car,1030);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Side Skirts component on Sultan");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 558)  // Uranus
					{
					    AddVehicleComponentEx(car,1093);
					    AddVehicleComponentEx(car,1095);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wheel Arch X-Flow Side Skirts component on Uranus");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------Locos Low Chrome Strip Side Skirts----------------------------------------------------------
			case 2:
			    if(pmodelid[playerid] == 575 ||
	               pmodelid[playerid] == 536 ||
	               pmodelid[playerid] == 576 ||
		 	       pmodelid[playerid] == 567)
	               {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
	       		        AddVehicleComponentEx(car,1042);
	       		        AddVehicleComponentEx(car,1099);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chrome Strip Side Skirts component on Brodway");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
	   				else if(pmodelid[playerid] == 567) // Savanna
					{
					    AddVehicleComponentEx(car,1102);
					    AddVehicleComponentEx(car,1133);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chrome Strip Side Skirts component on Savanna");
	    		        ShowMenuForPlayer(Sideskirts, playerid);
	                }
	                else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponentEx(car,1134);
					    AddVehicleComponentEx(car,1137);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chrome Strip Side Skirts component on Tornado");
	    		        ShowMenuForPlayer(Sideskirts, playerid);
	                }
	                else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponentEx(car,1108);
					    AddVehicleComponentEx(car,1107);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chrome Strip Side Skirts component on Blade");
	                    ShowMenuForPlayer(Sideskirts, playerid);
	                }
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types Brodway, Savanna Tornado and Blade");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Chrome Flames Side Skirts----------------------------------------------------------
			case 3:
			    if(pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 534)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 534) // Remington
			        {
			            AddVehicleComponentEx(car,1122);
			            AddVehicleComponentEx(car,1101);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chrome Flames Side Skirts component on Remington");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car type Remington ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Chrome Arches Side Skirts----------------------------------------------------------

			case 4:
			    if(pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 534)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 534) // Remington
			        {
			            AddVehicleComponentEx(car,1106);
			            AddVehicleComponentEx(car,1124);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chrome Arches Side Skirts component on Remington");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car type Remington ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}




	//-------------------Locos Low Chrome Trim Side Skirts----------------------------------------------------------
			case 5:
			    if(pmodelid[playerid] == 535)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 535) // Slamvan
			        {
			            AddVehicleComponentEx(car,1118);
			            AddVehicleComponentEx(car,1120);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chrome Trim Side Skirts component on Slamvan");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car type Slamvan ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------Locos Low Chrome Wheelcovers Side Skirts----------------------------------------------------------
	  case 6:
			    if(pmodelid[playerid] == 535)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 535) // Slamvan
			        {
			            AddVehicleComponentEx(car,1119);
			            AddVehicleComponentEx(car,1121);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chrome Wheelcovers component on Slamvan");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car type Slamvan ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

			   case 7:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}

	//-------------------Locos Low Chrome Grill ----------------------------------------------------------

	if(Current == Bullbars) {
		switch(row){

	        case 0:
			    if(pmodelid[playerid] == 534)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 534) // Remington
			        {
			            AddVehicleComponentEx(car,1100);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chrome Grill component on Remington");
			            ShowMenuForPlayer(Bullbars, playerid);
			        }
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car type Remington ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Chrome Bars ----------------------------------------------------------
			case 1:
			    if(pmodelid[playerid] == 534)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 534) // Remington
			        {
			            AddVehicleComponentEx(car,1123);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chrome Bars component on Remington");
			            ShowMenuForPlayer(Bullbars, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car type Remington ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Chrome Lights ----------------------------------------------------------


			case 2:
			    if(pmodelid[playerid] == 534)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 534) // Remington
			        {
			            AddVehicleComponentEx(car,1125);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chrome Lights component on Remington");
			            ShowMenuForPlayer(Bullbars, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car type Remington ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}




	//-------------------Locos Low Chrome Bullbar ----------------------------------------------------------


	    case 3:
		    if(pmodelid[playerid] == 535)
		    {
		        new car = GetPlayerVehicleID(playerid);
		        if(pmodelid[playerid] == 535) // Slamvan
		        {
		            AddVehicleComponentEx(car,1117);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Locos Low Chrome Lights component on Slamvan");
		            ShowMenuForPlayer(Bullbars, playerid);
				}
				}
				else
				{
					SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car type Slamvan ");
					ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 4:ShowMenuForPlayer(TuningMenu, playerid);
		}
	}



	if(Current == Wheels) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponentEx(car,1025);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Offroad Wheels ");
		            ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 1:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponentEx(car,1074);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Mega Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
	                AddVehicleComponentEx(car,1076);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Wires Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponentEx(car,1078);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Twist Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
	      		 	SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(Wheels, playerid);
				}
			case 4:
				if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponentEx(car,1081);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Grove Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 5:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
	                AddVehicleComponentEx(car,1082);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Import Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	   		case 6:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponentEx(car,1085);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Atomic Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 7:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponentEx(car,1096);
	          		SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Ahab Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 8:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponentEx(car,1097);
	          		SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Virtual Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	 		case 9:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponentEx(car,1098);
	          		SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Access Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	        case 10:
				{

				    ShowMenuForPlayer(Wheels1, playerid);
				}

			case 11:
				{

				    ShowMenuForPlayer(TuningMenu, playerid);
				}

	 	}
	 }

	if(Current == Wheels1) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponentEx(car,1084);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Trance Wheels ");
		            ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 1:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponentEx(car,1073);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Shadow Wheels");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
	                AddVehicleComponentEx(car,1075);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Rimshine Wheels");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
	      	 		SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponentEx(car,1077);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Classic Wheels");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(Wheels, playerid);
				}
			case 4:
				if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponentEx(car,1079);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Cutter Wheels");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 5:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
	                AddVehicleComponentEx(car,1080);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Switch Wheels");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	   		case 6:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponentEx(car,1083);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Dollar Wheels");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	        case 7:
				{

				    ShowMenuForPlayer(TuningMenu, playerid);
				}
		 }
	 }


	if(Current == Carstereo) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponentEx(car,1086);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Stereo Bass bost system ");
		            ShowMenuForPlayer(Carstereo, playerid);
				}
				else
				{
	                SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
			    }
			case 1:

			    {
			        ShowMenuForPlayer(TuningMenu, playerid);
				}
		 }
	 }

	if(Current == Hydraulics) {
		switch(row){
		    case 0:
	            if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponentEx(car,1087);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง Hydraulics ในรถ ");
		            ShowMenuForPlayer(Hydraulics, playerid);
				}
				else
				{
	                SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
			    }

			case 1:

			    {
			        ShowMenuForPlayer(TuningMenu, playerid);
				}
		 }
	 }

	if(Current == Nitro) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponentEx(car,1008);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง 2x Nitro ในรถ ");
		            ShowMenuForPlayer(Nitro, playerid);
				}
				else
				{
	                SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
			    }
			case 1:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponentEx(car,1009);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง 5x Nitro ในรถ ");
			        ShowMenuForPlayer(Nitro, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
	                AddVehicleComponentEx(car,1010);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] คุณได้ติดตั้ง 10x Nitro ในรถ ");
			        ShowMenuForPlayer(Nitro, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"เงินไม่พอ!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:

			    {
			        ShowMenuForPlayer(TuningMenu, playerid);
				}
	 	}
	}


	//--------------------------Main Menu page 2 ----------------------------------------------------------------------------
	if(Current == TuningMenu1) {
	    switch(row){
	        case 0:
				if(IsPlayerConnected(playerid))
				{
					ShowMenuForPlayer(Hydraulics, playerid);
				}
	        case 1:
				if(IsPlayerConnected(playerid))
				{
					ShowMenuForPlayer(Nitro, playerid);
				}
	       case 2:
				{
				 	SendClientMessage(playerid,COLOR_WHITE,"[INFO] กรุณาไปซ่อมรถที่ร้านซ่อมรถค่ะ !");
					ShowMenuForPlayer(TuningMenu1, playerid);

				}

	       case 3:
				if(IsPlayerConnected(playerid))
				{
					ShowMenuForPlayer(TuningMenu, playerid);
				}


		}
	}
	return 1;
}


stock IsComponentidCompatible(modelid, componentid)
{
    if(componentid == 1025 || componentid == 1073 || componentid == 1074 || componentid == 1075 || componentid == 1076 ||
         componentid == 1077 || componentid == 1078 || componentid == 1079 || componentid == 1080 || componentid == 1081 ||
         componentid == 1082 || componentid == 1083 || componentid == 1084 || componentid == 1085 || componentid == 1096 ||
         componentid == 1097 || componentid == 1098 || componentid == 1087 || componentid == 1086)
         return true;

    switch (modelid)
    {
        case 400: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 401: return (componentid == 1005 || componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 114 || componentid == 1020 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 402: return (componentid == 1009 || componentid == 1009 || componentid == 1010);
        case 404: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007);
        case 405: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1014 || componentid == 1023 || componentid == 1000);
        case 409: return (componentid == 1009);
        case 410: return (componentid == 1019 || componentid == 1021 || componentid == 1020 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 411: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 412: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 415: return (componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 418: return (componentid == 1020 || componentid == 1021 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1016);
        case 419: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 420: return (componentid == 1005 || componentid == 1004 || componentid == 1021 || componentid == 1019 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1003);
        case 421: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1023 || componentid == 1016 || componentid == 1000);
        case 422: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1017 || componentid == 1007);
        case 426: return (componentid == 1005 || componentid == 1004 || componentid == 1021 || componentid == 1019 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003);
        case 429: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 436: return (componentid == 1020 || componentid == 1021 || componentid == 1022 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 438: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 439: return (componentid == 1003 || componentid == 1023 || componentid == 1001 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1017 || componentid == 1007 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1013);
        case 442: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 445: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 451: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 458: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 466: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 467: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 474: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 475: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 477: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1017 || componentid == 1007);
        case 478: return (componentid == 1005 || componentid == 1004 || componentid == 1012 || componentid == 1020 || componentid == 1021 || componentid == 1022 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 479: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 480: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 489: return (componentid == 1005 || componentid == 1004 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1016 || componentid == 1000);
        case 491: return (componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 492: return (componentid == 1005 || componentid == 1004 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1016 || componentid == 1000);
        case 496: return (componentid == 1006 || componentid == 1017 || componentid == 1007 || componentid == 1011 || componentid == 1019 || componentid == 1023 || componentid == 1001 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1003 || componentid == 1002 || componentid == 1142 || componentid == 1143 || componentid == 1020);
        case 500: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 506: return (componentid == 1009);
        case 507: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 516: return (componentid == 1004 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1015 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007);
        case 517: return (componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1023 || componentid == 1016 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 518: return (componentid == 1005 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 526: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 527: return (componentid == 1021 || componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1014 || componentid == 1015 || componentid == 1017 || componentid == 1007);
        case 529: return (componentid == 1012 || componentid == 1011 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 533: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 534: return (componentid == 1126 || componentid == 1127 || componentid == 1179 || componentid == 1185 || componentid == 1100 || componentid == 1123 || componentid == 1125 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1180 || componentid == 1178 || componentid == 1101 || componentid == 1122 || componentid == 1124 || componentid == 1106);
        case 535: return (componentid == 1109 || componentid == 1110 || componentid == 1113 || componentid == 1114 || componentid == 1115 || componentid == 1116 || componentid == 1117 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1120 || componentid == 1118 || componentid == 1121 || componentid == 1119);
        case 536: return (componentid == 1104 || componentid == 1105 || componentid == 1182 || componentid == 1181 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1184 || componentid == 1183 || componentid == 1128 || componentid == 1103 || componentid == 1107 || componentid == 1108);
        case 540: return (componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007);
        case 541: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 542: return (componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1015);
        case 545: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 546: return (componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007);
        case 547: return (componentid == 1142 || componentid == 1143 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1016 || componentid == 1003 || componentid == 1000);
        case 549: return (componentid == 1012 || componentid == 1011 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 550: return (componentid == 1005 || componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003);
        case 551: return (componentid == 1005 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1023 || componentid == 1016 || componentid == 1003);
        case 555: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 558: return (componentid == 1092 || componentid == 1089 || componentid == 1166 || componentid == 1165 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1168 || componentid == 1167 || componentid == 1088 || componentid == 1091 || componentid == 1164 || componentid == 1163 || componentid == 1094 || componentid == 1090 || componentid == 1095 || componentid == 1093);
        case 559: return (componentid == 1065 || componentid == 1066 || componentid == 1160 || componentid == 1173 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1159 || componentid == 1161 || componentid == 1162 || componentid == 1158 || componentid == 1067 || componentid == 1068 || componentid == 1071 || componentid == 1069 || componentid == 1072 || componentid == 1070 || componentid == 1009);
        case 560: return (componentid == 1028 || componentid == 1029 || componentid == 1169 || componentid == 1170 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1141 || componentid == 1140 || componentid == 1032 || componentid == 1033 || componentid == 1138 || componentid == 1139 || componentid == 1027 || componentid == 1026 || componentid == 1030 || componentid == 1031);
        case 561: return (componentid == 1064 || componentid == 1059 || componentid == 1155 || componentid == 1157 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1154 || componentid == 1156 || componentid == 1055 || componentid == 1061 || componentid == 1058 || componentid == 1060 || componentid == 1062 || componentid == 1056 || componentid == 1063 || componentid == 1057);
        case 562: return (componentid == 1034 || componentid == 1037 || componentid == 1171 || componentid == 1172 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1149 || componentid == 1148 || componentid == 1038 || componentid == 1035 || componentid == 1147 || componentid == 1146 || componentid == 1040 || componentid == 1036 || componentid == 1041 || componentid == 1039);
        case 565: return (componentid == 1046 || componentid == 1045 || componentid == 1153 || componentid == 1152 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1150 || componentid == 1151 || componentid == 1054 || componentid == 1053 || componentid == 1049 || componentid == 1050 || componentid == 1051 || componentid == 1047 || componentid == 1052 || componentid == 1048);
        case 566: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 567: return (componentid == 1129 || componentid == 1132 || componentid == 1189 || componentid == 1188 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1187 || componentid == 1186 || componentid == 1130 || componentid == 1131 || componentid == 1102 || componentid == 1133);
        case 575: return (componentid == 1044 || componentid == 1043 || componentid == 1174 || componentid == 1175 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1176 || componentid == 1177 || componentid == 1099 || componentid == 1042);
        case 576: return (componentid == 1136 || componentid == 1135 || componentid == 1191 || componentid == 1190 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1192 || componentid == 1193 || componentid == 1137 || componentid == 1134);
        case 579: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 580: return (componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007);
        case 585: return (componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 587: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 589: return (componentid == 1005 || componentid == 1004 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1024 || componentid == 1013 || componentid == 1006 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007);
        case 600: return (componentid == 1005 || componentid == 1004 || componentid == 1020 || componentid == 1022 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1017 || componentid == 1007);
        case 602: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 603: return (componentid == 1144 || componentid == 1145 || componentid == 1142 || componentid == 1143 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007);
    }
    return false;
}

public OnPlayerExitedMenu(playerid)
{
    new Menu:Current = GetPlayerMenu(playerid);
	HideMenuForPlayer(Current, playerid);
	TogglePlayerControllable(playerid, true);

	return 1;
}


AddVehicleComponentEx(vehicleid, componentid) {
	if(vehicleid > 0 && vehicleid != INVALID_VEHICLE_ID) {
	    new temp_model = GetVehicleModel(vehicleid);
	    if(IsComponentidCompatible(temp_model, componentid)) {
	        AddVehicleComponent(vehicleid, componentid);
	    }
	}
	return 1;
}

stock StockAddMenuItem()
{
	//==========================================================================
    TuningMenu = CreateMenu("TuningMenu",1,20,120,150,40);
    AddMenuItem(TuningMenu,0,"Paint Jobs");
    AddMenuItem(TuningMenu,0,"Colors");
    AddMenuItem(TuningMenu,0,"Exhausts");
    AddMenuItem(TuningMenu,0,"Front Bumper");
    AddMenuItem(TuningMenu,0,"Rear Bumper");
    AddMenuItem(TuningMenu,0,"Roof");
    AddMenuItem(TuningMenu,0,"Spoilers");
    AddMenuItem(TuningMenu,0,"Side Skirts");
    AddMenuItem(TuningMenu,0,"Bullbars");
    AddMenuItem(TuningMenu,0,"Wheels");
    AddMenuItem(TuningMenu,0,"Car Stereo");
    AddMenuItem(TuningMenu,0,"Next Page");
    Paintjobs = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Paintjobs,0,"PaintJobs");
	AddMenuItem(Paintjobs,0,"Paintjob 1");
	AddMenuItem(Paintjobs,0,"Paintjob 2");
	AddMenuItem(Paintjobs,0,"Paintjob 3");
	AddMenuItem(Paintjobs,0,"Paintjob 4");
	AddMenuItem(Paintjobs,0,"Paintjob 5");
	AddMenuItem(Paintjobs,0,"Main Menu");
	Colors = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Colors,0,"Colors");
	AddMenuItem(Colors,0,"Black");
	AddMenuItem(Colors,0,"White");
	AddMenuItem(Colors,0,"Red");
	AddMenuItem(Colors,0,"Blue");
	AddMenuItem(Colors,0,"Green");
	AddMenuItem(Colors,0,"Yellow");
	AddMenuItem(Colors,0,"Pink");
	AddMenuItem(Colors,0,"Brown");
	AddMenuItem(Colors,0,"Next Page");
	Colors1 = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Colors1,0,"Colors");
    AddMenuItem(Colors1,0,"Grey");
	AddMenuItem(Colors1,0,"Gold");
	AddMenuItem(Colors1,0,"Dark Blue");
	AddMenuItem(Colors1,0,"Light Blue");
	AddMenuItem(Colors1,0,"Green");
	AddMenuItem(Colors1,0,"Light Grey");
	AddMenuItem(Colors1,0,"Dark Red");
	AddMenuItem(Colors1,0,"Dark Brown");
	AddMenuItem(Colors1,0,"Main Menu");
	Exhausts = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Exhausts,0,"Exhausts");
	AddMenuItem(Exhausts,0,"Wheel Arch Alien Exhaust");
	AddMenuItem(Exhausts,0,"Wheel Arch X-Flow Exhaust");
	AddMenuItem(Exhausts,0,"Locos Low Chromer Exhaust");
	AddMenuItem(Exhausts,0,"Locos Low Slamin Exhaust");
	AddMenuItem(Exhausts,0,"Main Menu");
	Frontbumper = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Frontbumper,0,"Frontbumpers");
	AddMenuItem(Frontbumper,0,"Wheel Arch Alien bumper");
	AddMenuItem(Frontbumper,0,"Wheel Arch X-Flow bumper");
	AddMenuItem(Frontbumper,0,"Locos Low Chromer bumper");
	AddMenuItem(Frontbumper,0,"Locos Low Slamin bumper");
	AddMenuItem(Frontbumper,0,"Main Menu");
	Rearbumper = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Rearbumper,0,"Rearbumpers");
	AddMenuItem(Rearbumper,0,"Wheel Arch Alien bumper");
	AddMenuItem(Rearbumper,0,"Wheel Arch X-Flow bumper");
	AddMenuItem(Rearbumper,0,"Locos Low Chromer bumper");
	AddMenuItem(Rearbumper,0,"Locos Low Slamin bumper");
	AddMenuItem(Rearbumper,0,"Main Menu");
	Roof = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Roof,0,"Roof");
	AddMenuItem(Roof,0,"Wheel Arch Alien Roof Vent");
	AddMenuItem(Roof,0,"Wheel Arch X-Flow Roof Vent");
	AddMenuItem(Roof,0,"Locos Low Hardtop Roof");
	AddMenuItem(Roof,0,"Locos Low Softtop Roof");
	AddMenuItem(Roof,0,"Main Menu");
	Spoilers = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Spoilers,0,"Spoliers");
	AddMenuItem(Spoilers,0,"Alien Spoiler");
	AddMenuItem(Spoilers,0,"X-Flow Spoiler");
	AddMenuItem(Spoilers,0,"Main Menu");
	Sideskirts = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Sideskirts,0,"SideSkirts");
	AddMenuItem(Sideskirts,0,"Wheel Arch Alien Side Skirts");
	AddMenuItem(Sideskirts,0,"Wheel Arch X-Flow Side Skirts");
    AddMenuItem(Sideskirts,0,"Locos Low Chrome Strip");
    AddMenuItem(Sideskirts,0,"Locos Low Chrome Flames");
    AddMenuItem(Sideskirts,0,"Locos Low Chrome Arches");
    AddMenuItem(Sideskirts,0,"Locos Low Chrome Trim");
    AddMenuItem(Sideskirts,0,"Locos Low Wheelcovers");
	AddMenuItem(Sideskirts,0,"Main Menu");
	Bullbars = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Bullbars,0,"Bullbars");
	AddMenuItem(Bullbars,0,"Locos Low Chrome Grill");
	AddMenuItem(Bullbars,0,"Locos Low Chrome Bars");
	AddMenuItem(Bullbars,0,"Locos Low Chrome Lights");
	AddMenuItem(Bullbars,0,"Locos Low Chrome Bullbar");
	AddMenuItem(Bullbars,0,"Main Menu");
	Wheels = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Wheels,0,"Wheels");
	AddMenuItem(Wheels,0,"Offroad");
	AddMenuItem(Wheels,0,"Mega");
	AddMenuItem(Wheels,0,"Wires");
	AddMenuItem(Wheels,0,"Twist");
	AddMenuItem(Wheels,0,"Grove");
	AddMenuItem(Wheels,0,"Import");
	AddMenuItem(Wheels,0,"Atomic");
	AddMenuItem(Wheels,0,"Ahab");
	AddMenuItem(Wheels,0,"Virtual");
	AddMenuItem(Wheels,0,"Access");
	AddMenuItem(Wheels,0,"Next Page");
	AddMenuItem(Wheels,0,"Main Menu");
	Wheels1 = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Wheels1,0,"Wheels");
	AddMenuItem(Wheels1,0,"Trance");
	AddMenuItem(Wheels1,0,"Shadow");
	AddMenuItem(Wheels1,0,"Rimshine");
	AddMenuItem(Wheels1,0,"Classic");
	AddMenuItem(Wheels1,0,"Cutter");
	AddMenuItem(Wheels1,0,"Switch");
	AddMenuItem(Wheels1,0,"Dollar");
	AddMenuItem(Wheels1,0,"Main Menu");
	Carstereo = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Carstereo,0,"Stereo");
	AddMenuItem(Carstereo,0,"Bass Boost");
	AddMenuItem(Carstereo,0,"Main Menu");
 	TuningMenu1= CreateMenu("TuningMenu",1,20,120,150,40);
    AddMenuItem(TuningMenu1,0,"Hydraulics");
    AddMenuItem(TuningMenu1,0,"Nitro");
    AddMenuItem(TuningMenu1,0,"Repair Car");
    AddMenuItem(TuningMenu1,0,"Main Menu");
	Hydraulics = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Hydraulics,0,"Hydraulics");
	AddMenuItem(Hydraulics,0,"Hydraulics");
	AddMenuItem(Hydraulics,0,"Main Menu");
	Nitro = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Nitro,0,"Nitro");
	AddMenuItem(Nitro,0,"2x Nitrous");
	AddMenuItem(Nitro,0,"5x Nitrous");
	AddMenuItem(Nitro,0,"10x Nitrous");
	AddMenuItem(Nitro,0,"Main Menu");
}

/*public OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart) {

	if(IsPlayerNPC(playerid)) return 1;

	new Float:vH; GetVehicleHealth(vehicleid, vH);
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	new Float:speed_x,Float:speed_y,Float:speed_z,Float:parames30_10,parames30_10_int;
	GetVehicleVelocity(vehicleid,speed_x,speed_y,speed_z);
	parames30_10 = floatsqroot(((speed_x*speed_x)+(speed_y*speed_y))+(speed_z*speed_z))*199.4166672;
	parames30_10_int = floatround(parames30_10,floatround_round);

	//if(Damage > 40.0)
	if(parames30_10_int > 60)
	{
		foreach (new i : Player)
		{
			if(GetPlayerVehicleID(i) == vehicleid)
			{
			    new Float:x, Float:y, Float:z, Float:DamageVeh = randomEx(5,10);

			    GetPlayerPos(i, x, y, z);
			    SetPlayerPos(i,x-8,y,z+3);
				RemovePlayerFromVehicle(i);
                ApplyAnimation(i,"PED","fall_front", 4.0, 0, 1, 1, 0, 0, 1);
				SetTimerEx("WakeUp", 500, false, "d", i);

				new Float:pdHealth;
				GetPlayerHealth(i, pdHealth);
				SetPlayerHealth(i, pdHealth-DamageVeh);
				SetPlayerDrunkLevel(i, 2000);
			}
		}
	}
    return 1;
}

forward WakeUp(playerid);
public WakeUp(playerid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	ApplyAnimation(playerid,"PED","getup_front", 4.0, 0, 1, 1, 0, 0, 1);

	BloodObject[playerid][0] = CreateObject(19836, x, y, z-0.9, 0.0, 0.0, 0.0);
	BloodObject[playerid][1] = CreateObject(19836, x-0.3, y, z-0.9, 0.0, 0.0, 0.0);
	BloodObject[playerid][2] = CreateObject(19836, x, y-0.3, z-0.9, 0.0, 0.0, 0.0);

    SetTimerEx("UnBlood", 3000, false, "d", playerid);

	return 1;
}

forward UnBlood(playerid);
public UnBlood(playerid)
{
	DestroyObject(BloodObject[playerid][0]);
	DestroyObject(BloodObject[playerid][1]);
	DestroyObject(BloodObject[playerid][2]);

	return 1;
}*/

// --> ระบบแต่งรถ



/*stock ShowYMenuTextDraws(playerid)
{
    new str[128];

	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][0]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][1]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][2]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][3]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][4]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][5]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][6]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][7]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][8]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][9]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][10]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][11]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][12]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][13]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][14]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][15]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][16]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][17]);
	PlayerTextDrawShow(playerid, ZeeThreeText[playerid][18]);

   	format(str, sizeof(str), "ID:%d", playerid);
    PlayerTextDrawSetString(playerid, ZeeThreeText[playerid][18], str);

   	format(str, sizeof(str), "%s", GetPlayerNameEx(playerid));
    PlayerTextDrawSetString(playerid, ZeeThreeText[playerid][16], str);

    PlayerTextDrawSetPreviewModel(playerid, ZeeThreeText[playerid][17], GetPlayerSkin(playerid));
    PlayerTextDrawShow(playerid, ZeeThreeText[playerid][17]);

	SelectTextDraw(playerid, 0xFF0000FF);
	return 1;
}

stock HideYMenuTextDraws(playerid)
{
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][0]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][1]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][2]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][3]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][4]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][5]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][6]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][7]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][8]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][9]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][10]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][11]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][12]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][13]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][14]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][15]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][16]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][17]);
	PlayerTextDrawHide(playerid, ZeeThreeText[playerid][18]);

	CancelSelectTextDraw(playerid);
	return 1;
}*/


// จำนวนรัฐบาลออนไลน์
stock CopOnline()
{
	new cop;
	foreach(new x: Player) {
		if(IsPlayerConnected(x) && GetFactionType(x) == FACTION_POLICE)
		{
			cop++;
		}
	}
	return cop;
}

stock MedicOnline()
{
	new cop;
	foreach(new x: Player) {
		if(IsPlayerConnected(x) && GetFactionType(x) == FACTION_MEDIC)
		{
			cop++;
		}
	}
	return cop;
}

stock MechanicOnline()
{
	new cop;
	foreach(new x: Player) {
		if(IsPlayerConnected(x) && GetFactionType(x) == FACTION_MEC)
		{
			cop++;
		}
	}
	return cop;
}


ReturnVehicleModelName(model)
{
	new
	    name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}



// Safezone
CMD:editsafe(playerid, params[])
{
    new string[256];

	if (playerData[playerid][pAdmin] < 6)
		return SendClientMessage(playerid,COLOR_LIGHTRED,"คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	new choice[32], id, amount;
	if(sscanf(params, "s[32]dd", choice, id, amount))
	{
		SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : {FFFFFF}/editsafe [1-2] [ไอดีเซฟโซน] [ขนาด]");
		SendClientMessage(playerid, COLOR_WHITE, "1:เปลี่ยนจุด | 2:เปลี่ยนขนาด");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		GetPlayerPos(playerid, SafeZoneInfo[id][szPosX], SafeZoneInfo[id][szPosY], SafeZoneInfo[id][szPosZ]);
		SendClientMessage( playerid, -1, "คุณได้เปลี่ยนจุดsafezone!" );
		DestroyPickup(SafeZoneInfo[id][szPickupID]);
		SaveSafeZones(id);

		DestroyPickup(SafeZoneInfo[id][szPickupID]);
		DestroyDynamic3DTextLabel(SafeZoneInfo[id][szTextID]);
		format(string, sizeof(string), "{FFFFFF}[{FD2A15}Safezone ไอดี : %d{FFFFFF}]\n{FDD615}Area : {FFFFFF}%d\n{FFFFFF}อาวุธหรือทำดาเมจกันภายในบริเวณนี้",id,SafeZoneInfo[id][szSize]);
		SafeZoneInfo[id][szTextID] = CreateDynamic3DTextLabel( string, -1, SafeZoneInfo[id][szPosX], SafeZoneInfo[id][szPosY], SafeZoneInfo[id][szPosZ]+0.5,10.0, .testlos = 1, .streamdistance = 10.0);
		SafeZoneInfo[id][szPickupID] = CreatePickup(1314, 23, SafeZoneInfo[id][szPosX], SafeZoneInfo[id][szPosY], SafeZoneInfo[id][szPosZ]);
	}
	else if(strcmp(choice, "2", true) == 0)
	{
		SafeZoneInfo[id][szSize] = amount;
		SendClientMessage( playerid, COLOR_YELLOW, "> คุณได้ทำการแก้ไขขนาด 'Safezone' สำเร็จ" );
		SaveSafeZones(id);

		DestroyDynamic3DTextLabel(SafeZoneInfo[id][szTextID]);
		format(string, sizeof(string), "{FFFFFF}[{FD2A15}Safezone ไอดี : %d{FFFFFF}]\n{FDD615}Area : {FFFFFF}%d\n{FFFFFF}ห้ามใช้อาวุธหรือทำดาเมจกันภายในบริเวณนี้",id,SafeZoneInfo[id][szSize]);
		SafeZoneInfo[id][szTextID] = CreateDynamic3DTextLabel( string, -1, SafeZoneInfo[id][szPosX], SafeZoneInfo[id][szPosY], SafeZoneInfo[id][szPosZ]+0.5,10.0, .testlos = 1, .streamdistance = 10.0);
	}

	SaveSafeZones(id);
	return 1;
}


CMD:deletesafe(playerid, params[])
{
    new string[256];

	if (playerData[playerid][pAdmin] < 6)
		return SendClientMessage(playerid,COLOR_LIGHTRED,"คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	new id;
	if(sscanf(params,"d",id))
		return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : {FFFFFF}/deletesafe [ไอดี]");

	if(!IsValidDynamicPickup(SafeZoneInfo[id][szPickupID]))
		return SendClientMessage(playerid, COLOR_LIGHTRED,"> ไอดีไม่ถูกต้อง");

	SafeZoneInfo[id][szPosX] = 0;
	SafeZoneInfo[id][szPosY] = 0;
	SafeZoneInfo[id][szPosZ] = 0;

	DestroyDynamicPickup(SafeZoneInfo[id][szPickupID]);
	DestroyDynamic3DTextLabel(SafeZoneInfo[id][szTextID]);
	SaveSafeZones(id);

	format(string, sizeof(string), "> คุณได้ทำการลบ 'Safezone' ไอดี '%d' ออกจากฐานข้อมูล", id);
	SendClientMessage(playerid, COLOR_LIGHTRED, string);

	return 1;
}


CMD:createsafe(playerid, params[])
{
	new string[256];

	if (playerData[playerid][pAdmin] < 6)
		return SendClientMessage(playerid,COLOR_LIGHTRED,"คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(playerid, X,Y,Z);

	for(new i = 1; i < MAX_SZ; i++)
	{
		if(!SafeZoneInfo[i][Exits])
		{
			SafeZoneInfo[i][Exits] = true;
			SafeZoneInfo[i][szPosX] 	= X;
			SafeZoneInfo[i][szPosY] 	= Y;
			SafeZoneInfo[i][szPosZ] 	= Z;
			SafeZoneInfo[i][szSize] 	= 5;

			format(string, sizeof(string), "> คุณได้ทำการสร้าง 'Safezone' ไอดี '%d' เรียบร้อยแล้ว",i);
			SendClientMessage(playerid,COLOR_YELLOW,string);

			format(string, sizeof(string), "{FFFFFF}[{FD2A15}Safezone ไอดี : %d{FFFFFF}]\n{FDD615}Area : {FFFFFF}%d\n{FFFFFF}ห้ามใช้อาวุธหรือทำดาเมจกันภายในบริเวณนี้",i,SafeZoneInfo[i][szSize]);
			SafeZoneInfo[i][szPickupID] = CreateDynamicPickup(1314, 23, SafeZoneInfo[i][szPosX], SafeZoneInfo[i][szPosY], SafeZoneInfo[i][szPosZ]);
			SafeZoneInfo[i][szTextID] = CreateDynamic3DTextLabel(string, -1, SafeZoneInfo[i][szPosX], SafeZoneInfo[i][szPosY], SafeZoneInfo[i][szPosZ]+0.5,30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1,  -1, 30.0);

			new query[512];

			mysql_format(g_SQL,query,sizeof(query),"INSERT INTO  safezonedata SET `ID`=%d,szPosX=%f,szPosY='%f',szPosZ='%f',szSize='%d'",i,X,Y,Z,SafeZoneInfo[i][szSize]);
			mysql_tquery(g_SQL,query);
			return 1;
		}
	}
	return 1;
}

CMD:gotosz(playerid, params[])
{
	if (playerData[playerid][pAdmin] < 6)
		return SendClientMessage(playerid,COLOR_LIGHTRED,"คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	new housenum;

	if(sscanf(params, "d", housenum))
		return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : {FFFFFF}/gotosz [ไอดี]");

	SetPlayerPos(playerid,SafeZoneInfo[housenum][szPosX],SafeZoneInfo[housenum][szPosY],SafeZoneInfo[housenum][szPosZ]);
	SetPlayerInterior(playerid, 0);
	return 1;
}

forward SaveSafeZones(id);
public SaveSafeZones(id)
{
	new query[1048];
	mysql_format(g_SQL, query, sizeof(query), "UPDATE safezonedata SET szPosX='%d',szPosY='%f',szPosZ='%f',szSize='%f' WHERE ID=%d",
	SafeZoneInfo[id][szPosX],SafeZoneInfo[id][szPosY],SafeZoneInfo[id][szPosZ],SafeZoneInfo[id][szSize],id);
	mysql_tquery(g_SQL, query, "", "");
}

forward LoadSafeZones();
public LoadSafeZones()
{
    new rows = cache_num_rows();
	new id,loaded;
	new string[128];
 	if(rows)
  	{
		while(loaded < rows)
		{
		    cache_get_value_name_int(loaded,"ID",id);
		    cache_get_value_name_float(loaded,"szPosX",SafeZoneInfo[id][szPosX]);
		    cache_get_value_name_float(loaded,"szPosY",SafeZoneInfo[id][szPosY]);
		    cache_get_value_name_float(loaded,"szPosZ",SafeZoneInfo[id][szPosZ]);
		    cache_get_value_name_int(loaded,"szSize",SafeZoneInfo[id][szSize]);

   			format(string, sizeof(string), "{FFFFFF}[{FD2A15}Safezone ไอดี : %d{FFFFFF}]\n{FDD615}Area : {FFFFFF}%d\n{FFFFFF}ห้ามใช้อาวุธหรือทำดาเมจกันภายในบริเวณนี้",id,SafeZoneInfo[id][szSize]);
   			SafeZoneInfo[id][szPickupID] = CreateDynamicPickup(1314, 23, SafeZoneInfo[id][szPosX], SafeZoneInfo[id][szPosY], SafeZoneInfo[id][szPosZ]);
   			SafeZoneInfo[id][szTextID] = CreateDynamic3DTextLabel(string, -1, SafeZoneInfo[id][szPosX], SafeZoneInfo[id][szPosY], SafeZoneInfo[id][szPosZ]+0.5,30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1,  -1, 30.0);
			if(!SafeZoneInfo[id][Exits])
		    {
		        SafeZoneInfo[id][Exits] = true;
		    }
		    loaded ++;
		}

	}
	printf("LoadSafeZones %d", loaded);
}


public OnProgressFinish(playerid, objectid)
{
	if(repairon[playerid] == 1)
		PlayerRepaironUnfreeze(playerid,objectid);

	if(useFirstAidKit[playerid] == 1)
		PlayerHealHealth(playerid);

	return Y_HOOKS_CONTINUE_RETURN_0;
}

public OnProgressUpdate(playerid, progress, objectid)
{
	if(repairon[playerid] == 1)
	{
		ApplyAnimation(playerid, "BD_FIRE","wash_up", 4.1, 1, 0, 0, 1, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}
	if(useFirstAidKit[playerid] == 1)
	{
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 0, 0, 1, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}
    return Y_HOOKS_CONTINUE_RETURN_0;
}

/*public OnProgressFinish(playerid, objectid)
{
	if(isPoonStart[playerid] == 1)
		PlayerPoonUnfreeze(playerid);

	return Y_HOOKS_CONTINUE_RETURN_0;
}

public OnProgressUpdate(playerid, progress, objectid)
{
	if(isPoonStart[playerid] == 1)
	{
		ApplyAnimation(playerid, "BD_FIRE","wash_up", 4.1, 1, 0, 0, 1, 0, 1);
		return Y_HOOKS_BREAK_RETURN_1;
	}

    return Y_HOOKS_CONTINUE_RETURN_0;
}*/

/*PlayerHospitalUnfreeze(playerid)
{
	BeforeSleep[playerid] = 0;
	ClearAnimations(playerid);

	TogglePlayerControllable(playerid, true);

	SetPlayerHealth(playerid, 100);
	SendClientMessage(playerid, COLOR_YELLOW, "(( การนอนเตียงพยาบาลของคุณสำเร็จแล้ว, เลือดของคุณเต็มแล้ว ))");

	GivePlayerMoneyEx(playerid, -1000);
	SendClientMessage(playerid, COLOR_GREY, "ค่านอนเตียงพยาบาล {FFFFFF}$1,000");

	return 1;
}*/


// จกปูน
/*PlayerPoonUnfreeze(playerid)
{
	isPoonStart[playerid] = 0;
	ClearAnimations(playerid);

	new id = Inventory_Add(playerid, "ปูน", 1);

	if (id == -1)
	{
	    SendClientMessageEx(playerid, COLOR_RED, "- ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);
		return 1;
	}

	SendClientMessage(playerid, COLOR_WHITE, "คุณได้รับ {00FF00}ปูน + 1{FFFFFF} ชิ้น");

	GivePlayerWanted(playerid, 2);
	SendClientMessage(playerid, COLOR_LIGHTRED, "[คดีความ] {FFFFFF}คุณติดดาวเพราะคุณมีปูน");

	// ระบบแจ้งเตือนตำรวจ
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);

	foreach (new i : Player)
	{
		if(GetFactionType(i) == FACTION_POLICE)
		{
			SetPlayerCheckpoint(i, X,Y,Z, 15.0);

			SendClientMessage(i, COLOR_LIGHTBLUE, "[แจ้งเตือน] : มีพลเมืองดีรายงานว่า 'มีคนกำลังทำงานผิดกฎหมาย'");
			SendClientMessage(i, COLOR_LIGHTBLUE, "[แจ้งเตือน] : ตำแหน่ง Checkpoint ถูกแสดงขึ้นบนแผนที่แล้ว");
		}
	}
	return 1;
}*/

stock IsAPlane(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 460, 464, 476, 511, 512, 513, 519, 520, 553, 577, 592, 593: return 1;
	}
	return 0;
}

stock IsAHelicopter(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 417, 425, 447, 465, 469, 487, 488, 497, 501, 548, 563: return 1;
	}
	return 0;
}

stock IsABoat(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 430, 446, 452, 453, 454, 473, 484, 493, 595: return 1;
	}
	return 0;
}
 
 








Dialog:DIALOG_SELLPOON(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch(listitem)
	    {
	        case 0:
	        {
			    new ammo = Inventory_Count(playerid, "ปูน");
			    new price = ammo*100;

			    if (ammo <= 0)
			        return SendClientMessage(playerid, COLOR_RED, "- คุณไม่มีปูนอยู่ในตัวเลย");

		        playerData[playerid][pRedMoney] += price;
		        SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้รับเงินแดงจำนวน {00FF00}%s {FFFFFF}จากการขายปูน {00FF00}%d {FFFFFF}ชิ้น", FormatMoney(price), ammo);
				Inventory_Remove(playerid, "ปูน", ammo);
		    }
		}
	}
	return 1;
}

// --> ระบบ Boombox
stock Boombox_Place(playerid)
{
	new
	    Float:angle;

	GetPlayerFacingAngle(playerid, angle);

	strpack(BoomboxData[playerid][boomboxURL], "", 128 char);
	GetPlayerPos(playerid, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2]);

	BoomboxData[playerid][boomboxPlaced] = true;
	BoomboxData[playerid][boomboxInterior] = GetPlayerInterior(playerid);
	BoomboxData[playerid][boomboxWorld] = GetPlayerVirtualWorld(playerid);

    BoomboxData[playerid][boomboxObject] = CreateDynamicObject(2226, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2] - 0.9, 0.0, 0.0, angle, BoomboxData[playerid][boomboxWorld], BoomboxData[playerid][boomboxInterior]);
    BoomboxData[playerid][boomboxText3D] = CreateDynamic3DTextLabel("{FCCC09}(Boombox)\n{FFFFFF}พิมพ์ /boombox เพื่อตั้งค่าลำโพง", COLOR_DARKBLUE, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2] - 0.7, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BoomboxData[playerid][boomboxWorld], BoomboxData[playerid][boomboxInterior]);

	return 1;
}

stock Boombox_Nearest(playerid)
{
	foreach (new i : Player) if (BoomboxData[i][boomboxPlaced] && GetPlayerInterior(playerid) == BoomboxData[i][boomboxInterior] && GetPlayerVirtualWorld(playerid) == BoomboxData[i][boomboxWorld] && IsPlayerInRangeOfPoint(playerid, 30.0, BoomboxData[i][boomboxPos][0], BoomboxData[i][boomboxPos][1], BoomboxData[i][boomboxPos][2])) {
     	return i;
	}
	return INVALID_PLAYER_ID;
}

stock Boombox_SetURL(playerid, url[])
{
	if (BoomboxData[playerid][boomboxPlaced])
	{
	    strpack(BoomboxData[playerid][boomboxURL], url, 128 char);

	    foreach (new i : Player) if (playerData[i][pBoombox] == playerid) {
	        StopAudioStreamForPlayer(i);
	        PlayAudioStreamForPlayer(i, url, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2], 30.0, 1);
		}
	}
	return 1;
}

stock Boombox_Destroy(playerid)
{
	if (BoomboxData[playerid][boomboxPlaced])
	{
		if (IsValidDynamicObject(BoomboxData[playerid][boomboxObject]))
		    DestroyDynamicObject(BoomboxData[playerid][boomboxObject]);

		if (IsValidDynamic3DTextLabel(BoomboxData[playerid][boomboxText3D]))
		    DestroyDynamic3DTextLabel(BoomboxData[playerid][boomboxText3D]);

		foreach (new i : Player) if (playerData[i][pBoombox] == playerid) {
		    StopAudioStreamForPlayer(i);
		}
        BoomboxData[playerid][boomboxPlaced] = false;
        BoomboxData[playerid][boomboxInterior] = 0;
        BoomboxData[playerid][boomboxWorld] = 0;
	}
	return 1;
}

CMD:boombox(playerid, params[])
{
	new
	    type[24],
	    string[512];

	if (!Inventory_HasItem(playerid, "Boombox"))
	    return SendClientMessage(playerid, COLOR_GREY, "คุณไม่มีลำโพง Boombox อยู่ในตัว");

	if (sscanf(params, "s[24]S()[128]", type, string))
	{
	    SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : {FFFFFF}/boombox (รายการ)");
	    SendClientMessage(playerid, COLOR_YELLOW, "(รายการ) :{FFFFFF} วาง, เก็บ, เปลี่ยนเพลง");
	    return 1;
	}
	if (!strcmp(type, "วาง", true))
	{
	    if (BoomboxData[playerid][boomboxPlaced])
	        return SendClientMessage(playerid, COLOR_GREY, "คุณได้วาง Boombox แล้ว");

		if (Boombox_Nearest(playerid) != INVALID_PLAYER_ID)
		    return SendClientMessage(playerid, COLOR_GREY, "คุณอยู่ในขอบเขตของ Boombox อื่น");

		if (IsPlayerInAnyVehicle(playerid))
		    return SendClientMessage(playerid, COLOR_GREY, "คุณต้องออกจากยานพาหนะก่อน");

		Boombox_Place(playerid);

		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s วางลำโพง Boombox ลง", GetPlayerNameEx(playerid));
		SendClientMessage(playerid, COLOR_YELLOW, "คุณได้วางลำโพง Boombox ของคุณแล้ว");
	}
	else if (!strcmp(type, "เก็บ", true))
	{
	    if (!BoomboxData[playerid][boomboxPlaced])
	        return SendClientMessage(playerid, COLOR_GREY, "คุณยังไม่ได้ใช้ Boombox");

		if (!IsPlayerInRangeOfPoint(playerid, 3.0, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2]))
		    return SendClientMessage(playerid, COLOR_GREY, "คุณไม่ได้อยู่ในขอบเขต Boombox ของคุณ");

		Boombox_Destroy(playerid);
		SendClientMessage(playerid, -1, "คุณได้เก็บลำโพง Boombox ของคุณแล้ว");
	}
	else if (!strcmp(type, "เปลี่ยนเพลง", true))
	{
	    if (sscanf(string, "s[128]", string))
	        return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : {FFFFFF}/boombox [url] [song url]");

        if (!BoomboxData[playerid][boomboxPlaced])
	        return SendClientMessage(playerid, COLOR_GREY, "คุณยังไม่ได้ใช้ Boombox");

		if (!IsPlayerInRangeOfPoint(playerid, 3.0, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2]))
		    return SendClientMessage(playerid, COLOR_GREY, "คุณไม่ได้อยู่ในขอบเขต Boombox ของคุณ");

		Dialog_Show(playerid, DIALOG_URL, DIALOG_STYLE_INPUT, "{B2FC09}(เปลี่ยนลิ้งเพลง)", "{FFFFFF}กรุณาระบุ URL ของลิ้งเพลงที่คุณต้องการจะฟัง :", "ตกลง", "ยกเลิก");
		return 1;
	}
	return 1;
}

Dialog:DIALOG_URL(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    Boombox_SetURL(playerid, inputtext);
		SendClientMessage(playerid, -1, "{B2FC09}คุณได้เปลี่ยน URL เพลงของลำโพง Boombox ของคุณแล้ว");
	}
	return 1;
}

alias:getjiggy("เต้น")
CMD:getjiggy(playerid, params[]) {

    if(GetPlayerState(playerid) != 1)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณสามารถดำเนินการนี้ได้ในขณะอยู่บนพื้นเท่านั้น");

    new animid;
   	if(sscanf(params,"d",animid)) return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : {FFFFFF}/เต้น [1-9]");
	switch(animid) {

		case 1: ApplyAnimation(playerid, "DANCING", "DAN_Down_A", 4.0, 1,  0, 1, 1, 1, 1);
        case 2: ApplyAnimation(playerid, "DANCING", "DAN_Left_A", 4.0, 1,  0, 1, 1, 1, 1);
       	case 3: ApplyAnimation(playerid, "DANCING", "DAN_Loop_A", 4.0, 1,  0, 1, 1, 1, 1);
        case 4: ApplyAnimation(playerid, "DANCING", "DAN_Right_A", 4.0, 1,  0, 1, 1, 1, 1);
		case 5: ApplyAnimation(playerid, "DANCING", "DAN_Up_A", 4.0, 1,  0, 1, 1, 1, 1);
        case 6: ApplyAnimation(playerid, "DANCING", "dnce_M_a", 4.0, 1,  0, 1, 1, 1, 1);
       	case 7: ApplyAnimation(playerid, "DANCING", "dnce_M_b", 4.0, 1,  0, 1, 1, 1, 1);
        case 8: ApplyAnimation(playerid, "DANCING", "dnce_M_c", 4.0, 1,  0, 1, 1, 1, 1);
        case 9: ApplyAnimation(playerid, "DANCING", "dnce_M_d", 4.0, 1,  0, 1, 1, 1, 1);
        default: SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : {FFFFFF}/เต้น [1-9]");
   	}
   	return 1;
}


CMD:greet(playerid, params[])
{
	new targetid, type;

	if (playerData[playerid][pAnimation] == 0)
		return SendClientMessage(playerid, COLOR_GREY, "คุณต้องโดเนทท่าทางพิเศษก่อน");

	if(sscanf(params,"ud",targetid,type)) {
		SendClientMessage(playerid, COLOR_GREY, "การใช้: /greet [ไอดีผู้เล่น/ชื่อบางส่วน] [style]");
		SendClientMessage(playerid, COLOR_YELLOW, "[1] Kiss [2] Handshake [3] Handshake [4] Handshake [5] Handshake");
		SendClientMessage(playerid, COLOR_YELLOW, "[6] Handshake [7] Handshake [8] Handshake [9] Handshake [10] Handshake");
		return 1;
	}

	if(targetid == INVALID_PLAYER_ID)
		SendClientMessage(playerid, COLOR_GREY, "   ผู้เล่นนั้นตัดการเชื่อมต่อ");

	if(targetid == playerid)
  		return SendClientMessage(playerid, COLOR_GREY, "คุณไม่สามารถทักทายตัวเองได้");

	if(type > 10 || type < 1)
		return SendClientMessage(playerid, COLOR_WHITE, "มีแค่ 1-10!");

	if (!IsPlayerNearPlayer(playerid, targetid, 2.0))
		return SendClientMessage(playerid, COLOR_GREY, "   ผู้เล่นนั้นไม่ได้อยู่ใกล้คุณ");

	SetPVarInt(playerid, "SentGreet", 1);
	SetPVarInt(playerid, "GreetType", type);
	SetPVarInt(targetid, "GreetFrom", playerid);
	SetPVarInt(targetid, "GettingGreet", 1);

	SendClientMessageEx(playerid, COLOR_WHITE, "* คุณต้องการทักทาย %s", GetPlayerNameEx(targetid));
	SendClientMessageEx(targetid, COLOR_WHITE, "(ID: %d)%s อยากจะเริ่มทักทายกับคุณ(/acceptshake playerID)", playerid,GetPlayerNameEx(playerid));
	return 1;
}

CMD:acceptshake(playerid, params[])
{
	new targetid;
	if(sscanf(params,"d",targetid)) return SendClientMessage(playerid, COLOR_GREY, "{FF6142}USAGE:"EMBED_WHITE" /acceptshake [ไอดีผู้เล่น/ชื่อบางส่วน]");
	if(GetPVarInt(playerid, "GettingGreet") == 0) return SendClientMessage(playerid, COLOR_GREY, "ไม่มีใครต้องการทักทายคุณ");
	if(GetPVarInt(playerid, "GreetFrom") != targetid) return SendClientMessage(playerid, COLOR_GREY, "คุณไม่ได้ถูกร้องขอการทักทายจากผู้เล่นนี้");

	if(targetid == INVALID_PLAYER_ID) {
		return SendClientMessage(playerid, COLOR_GREY, "   ผู้เล่นนั้นตัดการเชื่อมต่อ");
	}

	if(targetid == playerid) return SendClientMessage(playerid, COLOR_GREY, "คุณไม่สามารถทักทายตัวเองได้");


	if (!IsPlayerNearPlayer(playerid, targetid, 1.0)) return SendClientMessage(playerid, COLOR_GREY, "   ผู้เล่นนั้นไม่ได้อยู่ใกล้คุณ");

    if (AnimationCheck(playerid)) return SendClientMessage(playerid, COLOR_GREY, "   คุณไม่สามารถทักทายได้ในขณะนี้");
    if (AnimationCheck(targetid)) return SendClientMessage(playerid, COLOR_GREY, "   ผู้เล่นนี้ไม่สามารถทักทายคุณได้ในขณะนี้");

	new type = GetPVarInt(targetid, "GreetType");

	ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0,  0, 1, 1, 1, 1, 1);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

	ApplyAnimationEx(targetid, "CARRY", "crry_prtial", 4.0,  0, 1, 1, 1, 1, 1);
	SetPlayerSpecialAction(targetid, SPECIAL_ACTION_NONE);

	SetPlayerFacePlayer(playerid, targetid);
	SetPlayerFacePlayer(targetid, playerid);

	if(type == 1)
	{
		ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 2.0,  0, 1, 1, 1, 1, 1);
		ApplyAnimation(targetid, "KISSING", "Playa_Kiss_02", 2.0,  0, 1, 1, 1, 1, 1);
	}
	else if(type == 2)
	{
		ApplyAnimation(playerid,"GANGS","hndshkfa_swt", 2.0,  0, 1, 1, 1, 1, 1);
		ApplyAnimation(targetid,"GANGS","hndshkfa_swt", 2.0,  0, 1, 1, 1, 1, 1);
	}
	else if(type == 3)
	{
		ApplyAnimation(playerid,"GANGS","hndshkba", 2.0,  0, 1, 1, 1, 1, 1);
		ApplyAnimation(targetid,"GANGS","hndshkba", 2.0,  0, 1, 1, 1, 1, 1);
	}
	else if(type == 4)
	{
		ApplyAnimation(playerid,"GANGS","hndshkca", 2.0,  0, 1, 1, 1, 1, 1);
		ApplyAnimation(targetid,"GANGS","hndshkca", 2.0,  0, 1, 1, 1, 1, 1);
	}
	else if(type == 5)
	{
		ApplyAnimation(playerid,"GANGS","hndshkcb", 2.0,  0, 1, 1, 1, 1, 1);
		ApplyAnimation(targetid,"GANGS","hndshkcb", 2.0,  0, 1, 1, 1, 1, 1);
	}
	else if(type == 6)
	{
		ApplyAnimation(playerid,"GANGS","hndshkda", 2.0,  0, 1, 1, 1, 1, 1);
		ApplyAnimation(targetid,"GANGS","hndshkda", 2.0,  0, 1, 1, 1, 1, 1);
	}
	else if(type == 7)
	{
		ApplyAnimation(playerid,"GANGS","hndshkea", 2.0,  0, 1, 1, 1, 1, 1);
		ApplyAnimation(targetid,"GANGS","hndshkea", 2.0,  0, 1, 1, 1, 1, 1);
	}
	else if(type == 8)
	{
		ApplyAnimation(playerid,"GANGS","hndshkfa", 2.0,  0, 1, 1, 1, 1, 1);
		ApplyAnimation(targetid,"GANGS","hndshkfa", 2.0,  0, 1, 1, 1, 1, 1);
	}
	else if(type == 9)
	{
		ApplyAnimation(playerid,"GANGS","hndshkaa", 2.0,  0, 1, 1, 1, 1, 1);
		ApplyAnimation(targetid,"GANGS","hndshkaa", 2.0,  0, 1, 1, 1, 1, 1);
	}
	else if(type == 10)
	{
		ApplyAnimation(playerid,"GANGS","prtial_hndshk_biz_01", 2.0,  0, 1, 1, 1, 1, 1);
		ApplyAnimation(targetid,"GANGS","prtial_hndshk_biz_01", 2.0,  0, 1, 1, 1, 1, 1);
	}
	DeletePVar(GetPVarInt(playerid, "GreetFrom"), "SentGreet");
	DeletePVar(GetPVarInt(playerid, "GreetFrom"), "GreetType");
	DeletePVar(playerid, "GreetFrom");
	DeletePVar(playerid, "GettingGreet");
	return 1;
}

SetPlayerFacePlayer(playerid, giveplayerid) {
    new
        Float: pX,
        Float: pY,
        Float: pZ,
        Float: gX,
        Float: gY,
        Float: gZ
    ;
    if(GetPlayerPos(playerid, pX, pY, pZ) && GetPlayerPos(giveplayerid, gX, gY, gZ)) {
        SetPlayerFacingAngle(playerid, (pX = -atan2((gX - pX), (gY - pY))));
        return SetPlayerFacingAngle(giveplayerid, (pX + 180.0));
    }
    return false;
}

AnimationCheck(playerid)
{
	return (playerData[playerid][pInjured] || playerData[playerid][pCuffed]);
}

ApplyAnimationEx(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync = 1)
{
	if(playerData[playerid][pInjured])
	    return 0;

	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);
	return 1;
}



CMD:toghud(playerid, params[])
{
	if (HUDToggle[playerid] == 0)
	{
	    HUDToggle[playerid] = 1;
	    ShowPlayerStats(playerid, true);
	    SendClientMessage(playerid, COLOR_GREEN, "+ {FFFFFF}คุณได้เปิดการใช้งาน 'HUD'");
	}
	else
	{
  		HUDToggle[playerid] = 0;
  		ShowPlayerStats(playerid, false);
  		SendClientMessage(playerid, COLOR_RED, "+ {FFFFFF}คุณได้ปิดการใช้งาน 'HUD'");
	}
	return 1;
}



stock CountIP(ip[]) // Counts how many connections from one IP.
{
    new b = 0;
    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && !strcmp(GetIP(i),ip)) b++;
    return b;
}

stock BanAllBots(playerid) // Bans the player.
{
    new PlayerName[25];
    GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
    printf("%s was Banned due to MANY Connections.", PlayerName);
    Ban(playerid);
    return 1;
}

// ระบบท่าเต้น  By EnterDev
CMD:dancing(playerid, params[])
{
	new animid;
	if(sscanf(params,"d",animid))
	return SendClientMessage(playerid, COLOR_GREY, "/dancing [1-9]");
	switch(animid) {

   		case 1: ApplyAnimation(playerid, "DANCING", "DAN_Down_A", 4.0, 1, 0, 0, 0, 0);
	   	case 2: ApplyAnimation(playerid, "DANCING", "DAN_Left_A", 4.0, 1, 0, 0, 0, 0);
 		case 3: ApplyAnimation(playerid, "DANCING", "DAN_Loop_A", 4.0, 1, 0, 0, 0, 0);
 		case 4: ApplyAnimation(playerid, "DANCING", "DAN_Right_A", 4.0, 1, 0, 0, 0, 0);
	  	case 5: ApplyAnimation(playerid, "DANCING", "DAN_Up_A", 4.0, 1, 0, 0, 0, 0);
		case 6: ApplyAnimation(playerid, "DANCING", "dnce_M_a", 4.0, 1, 0, 0, 0, 0);
  		case 7: ApplyAnimation(playerid, "DANCING", "dnce_M_b", 4.0, 1, 0, 0, 0, 0);
		case 8: ApplyAnimation(playerid, "DANCING", "dnce_M_c", 4.0, 1, 0, 0, 0, 0);
  		case 9: ApplyAnimation(playerid, "DANCING", "dnce_M_d", 4.0, 1, 0, 0, 0, 0);
	 	default: SendClientMessage(playerid, COLOR_GREY, "/dancing [1-9]");
   	}
   	return 1;
}

CMD:savepos(playerid){
	new Float:x, Float:y, Float:z, Float:a;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);

    printf("[%s]%f, %f, %f, %f", GetPlayerNameEx(playerid), x, y, z, a);
    SendClientMessageEx(playerid, COLOR_GREEN, "[ !] {ffffff}[X:%f][Y:%f][Z:%f][A:%f]",x,y,z,a);
	return 1;
}

forward SmokeWeed214(playerid);
public SmokeWeed214(playerid)
{
    SetPlayerAttachedObject(playerid, 4, 18687, 2, 0.012896, 0.179381, -1.588311, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 ); //
	SetTimerEx("SmokeWeed144", 2000, false, "d", playerid);
}

forward SmokeWeed144(playerid);
public SmokeWeed144(playerid)
{
	new Float:hp; GetPlayerHealth(playerid, hp);

    RemovePlayerAttachedObject(playerid, 4);
	ClearAnimations(playerid);
	TogglePlayerControllable(playerid, 1);

	SetPlayerHealth(playerid, 100.0);
	SendClientMessage(playerid, COLOR_YELLOW, "คุณได้รับเลือด 100.0 HP จากการสูบบุหรี่ไฟฟาแล้ว!");
}
/*alias:deadfrisk("บักโอ")
CMD:deadfrisk(playerid, params[])
{
    new
	    userid;

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "การใช้งาน : {FFFFFF}/จกของ [ไอดี/ชื่อ]");

	if (!playerData[userid][pInjured])
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้บาดเจ็บหนัก");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถค้นศพตัวเองได้");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ");

	if (CopOnline() < 1)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "ต้องมี 'ตำรวจ' ออนไลน์มากกว่า '1 คน'");

	FriskDEADInventory(playerid, userid);

	SendClientMessageEx(userid, COLOR_LIGHTBLUE, "* คุณถูกค้นตัวโดย %s", GetPlayerNameEx(playerid));
	SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* คุณได้ทำการค้นตัว %s", GetPlayerNameEx(userid));

    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้ค้นตัว %s ที่กำลังบาดเจ็บสาหัส", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));


	playerData[playerid][pTargetFrisk] = userid;

	new string100[1024];
	new string2[1024];

	format(string100, sizeof(string100), "{FC6E52}ไอเทม\t{FFFFFF}[จำนวน]\n");
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FC6E52}เงินเขียว\t{FFFFFF}%s\n", FormatMoney(GetPlayerMoneyEx(userid)));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FC6E52}เงินแดง\t{FFFFFF}%s\n", FormatMoney(playerData[userid][pRedMoney]));
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FC6E52}ไอเทมภายในตัว\t{FFFFFF}Click\n");
	strcat(string2,string100);

	Dialog_Show(playerid,DIALOG_PONSOP,DIALOG_STYLE_TABLIST_HEADERS,"{F64A28}ปล้นศพ",string2,"ตกลง","ยกเลิก");

	SendClientMessageEx(userid, COLOR_LIGHTBLUE, "* คุณถูกค้นตัวโดย %s", GetPlayerNameEx(playerid));
	SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* คุณได้ทำการค้นตัว %s", GetPlayerNameEx(userid));

    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้ค้นตัว %s ที่กำลังบาดเจ็บสาหัส", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));

	return 1;
}
// ปล้นศพ
Dialog:DIALOG_PONSOP(playerid, response, listitem, inputtext[])
{
	new userid = playerData[playerid][pTargetFrisk];
	if(!response)
	{
		return 1;
	}
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				Dialog_Show(playerid,DIALOG_ROB_MONEY,DIALOG_STYLE_INPUT,"{1BF649}ปล้นเงินเขียว","กรุณาระบุจำนวนเงินที่คุณต้องการจะนำออกมา :","ตกลง","ยกเลิก");
			}
			case 1:
			{
			    Dialog_Show(playerid,DIALOG_ROB_REDMONEY,DIALOG_STYLE_INPUT,"{F6461B}ปล้นเงินแดง","กรุณาระบุจำนวนเงินที่คุณต้องการจะนำออกมา :","ตกลง","ยกเลิก");
			}
			case 2:
			{
			    FriskDEADInventory(playerid, userid);
			}
		}
	}
	return 1;
}

forward GetItemFromInventory(playerid, itemid, name[]);
public GetItemFromInventory(playerid, itemid, name[])
{
	if (playerData[playerid][pTargetFrisk] == -1)
	    return 1;

	else if (!strcmp(name, "ดอกไม้", true)) {
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณไม่สามารถเอาอาวุธออกจากตัวผู้เล่นได้");
	}
	else if (!strcmp(name, "ดิลโด้", true)) {
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณไม่สามารถเอาอาวุธออกจากตัวผู้เล่นได้");
	}
	else if (!strcmp(name, "ไม้สนุ๊ก", true)) {
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณไม่สามารถเอาอาวุธออกจากตัวผู้เล่นได้");
	}
	else if (!strcmp(name, "ไม้กอล์ฟ", true)) {
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณไม่สามารถเอาอาวุธออกจากตัวผู้เล่นได้");
	}
	else if (!strcmp(name, "ไม้เบสบอล", true)) {
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณไม่สามารถเอาอาวุธออกจากตัวผู้เล่นได้");
	}
	else if (!strcmp(name, "พลั่ว", true)) {
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณไม่สามารถเอาอาวุธออกจากตัวผู้เล่นได้");
	}
	else if (!strcmp(name, "สนับมือ", true)) {
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณไม่สามารถเอาอาวุธออกจากตัวผู้เล่นได้");
	}
	else if (!strcmp(name, "มีดสั้น", true)) {
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณไม่สามารถเอาอาวุธออกจากตัวผู้เล่นได้");
	}
	else if (!strcmp(name, "คาตานะ", true)) {
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณไม่สามารถเอาอาวุธออกจากตัวผู้เล่นได้");
	}
	else if (!strcmp(name, "MP5", true)) {
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณไม่สามารถเอาอาวุธออกจากตัวผู้เล่นได้");
	}
	else if (!strcmp(name, "ปืนยิงล้ม", true)) {
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณไม่สามารถเอาอาวุธออกจากตัวผู้เล่นได้");
	}
	else if (!strcmp(name, "กระสุนปืน", true)) {
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณไม่สามารถเอาอาวุธออกจากตัวผู้เล่นได้");
	}

	Dialog_Show(playerid, DIALOG_INV_AMOUNT, DIALOG_STYLE_LIST, name, "ยึด", "เลือก", "ปิด");
	playerData[playerid][pItemSelect] = itemid;
 	return 1;
}

Dialog:DIALOG_INV_AMOUNT(playerid, response, listitem, inputtext[])
{
	return Dialog_Show(playerid, DIALOG_INV_TAKE, DIALOG_STYLE_INPUT, "{ffffff}ระบุจำนวนไอเท็ม:", "กรุณาระบุจำนวนที่คุณต้องการจะยึดออกมา :", "ตกลง", "ออก");
}

Dialog:DIALOG_INV_TAKE(playerid, response, listitem, inputtext[])
{
	new amount = strval(inputtext);

	if (playerData[playerid][pTargetFrisk] == -1)
	    return 1;

	new userid = playerData[playerid][pTargetFrisk];
	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
	            new stringz[32];
				new itemid = playerData[playerid][pItemSelect];
				strunpack(stringz, invData[playerid][playerData[playerid][pItemSelect]][invItem]);

				SendClientMessageEx(playerid, COLOR_ORANGE, "* คุณได้จกของ '%s' ออกมาจากตัว '%s' จำนวน '%d'", invData[userid][itemid][invItem], GetPlayerNameEx(userid), amount);
				SendClientMessageEx(userid, COLOR_ORANGE, "* คุณถูกจกของ '%s' ออกมาโดย '%s' จำนวน '%d'", invData[userid][itemid][invItem], GetPlayerNameEx(userid), amount);

		        Inventory_Add(playerid, invData[userid][itemid][invItem], amount);
		        Inventory_Remove(userid, invData[userid][itemid][invItem], amount);

                playerData[playerid][pTargetFrisk] = -1;

				SendClientMessageToAllEx(COLOR_LIGHTRED, "[จกของ]: {F7E60D}%s ได้ทำการจกไอเท็ม %s ออกจากตัว %s จำนวน %d เรียบร้อยแล้ว ))", GetPlayerNameEx(playerid), invData[userid][itemid][invItem], GetPlayerNameEx(userid), amount);

				return 1;
			}
		}


		new stringz[32];
		new itemid = playerData[playerid][pItemSelect];
		strunpack(stringz, invData[playerid][playerData[playerid][pItemSelect]][invItem]);

		if (amount <= 0)
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องระบุจำนวนมากกว่า '0'!");

		if (amount > invData[userid][itemid][invQuantity])
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "จำนวนของผู้เล่นนั้นไม่เพียงพอ!");

		SendClientMessageEx(playerid, COLOR_ORANGE, "* คุณได้จกของ '%s' ออกมาจากตัว '%s' จำนวน '%d'", invData[userid][itemid][invItem], GetPlayerNameEx(userid), amount);
		SendClientMessageEx(userid, COLOR_ORANGE, "* คุณถูกจกของ '%s' ออกมาโดย '%s' จำนวน '%d'", invData[userid][itemid][invItem], GetPlayerNameEx(userid), amount);

		Inventory_Add(playerid, invData[userid][itemid][invItem], amount);
		Inventory_Remove(userid, invData[userid][itemid][invItem], amount);

		playerData[playerid][pTargetFrisk] = -1;

		SendClientMessageToAllEx(COLOR_LIGHTRED, "[จกของ]: {F7E60D}%s ได้ทำการจกไอเท็ม %s ออกจากตัว %s จำนวน %d เรียบร้อยแล้ว ))", GetPlayerNameEx(playerid), invData[userid][itemid][invItem], GetPlayerNameEx(userid), amount);

		return 1;
	}
	return 1;
}

forward FriskDEADInventory(playerid, userid);
public FriskDEADInventory(playerid, userid)
{
    if (playerData[userid][IsLoggedIn] == false)
	    return 0;

	new
		string[4096],
		string2[4096],
		count,
		var[32];

    for (new i = 0; i < playerData[userid][pMaxItem]; i ++)
	{
 		if (invData[userid][i][invExists]) {
   			format(string, sizeof(string), "%s\t{D0AEEB}({FFFFFF}%d{D0AEEB})\n", invData[userid][i][invItem], invData[userid][i][invQuantity]);
   			strcat(string2, string);
   			format(var, sizeof(var), "itemlistzax%d", count);
   			SetPVarInt(playerid, var, i);
   			count++;
		}
	}
	if (!count) {
		SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นนั้นไม่มีไอเท็มอยู่ในตัวเลย");
		return 1;
	}
	playerData[playerid][pTargetFrisk] = userid;
	format(string, sizeof(string), "ชื่อ\tความจุ (%d/%d)\n%s", Inventory_Items(userid), playerData[userid][pMaxItem], string2);
	return Dialog_Show(playerid, DIALOG_INVENTORY2345, DIALOG_STYLE_TABLIST_HEADERS, "[กระเป๋า]", string, "เลือก", "ปิด");
}

Dialog:DIALOG_INVENTORY2345(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new userid = playerData[playerid][pTargetFrisk];
		new var[32];
		format(var, sizeof(var), "itemlistzax%d", listitem);
		new item = GetPVarInt(playerid, var);

        GetItemFromInventory(playerid, item, invData[userid][item][invItem]);
	}
	return 1;
}

Dialog:DIALOG_ROB_MONEY(playerid, response, listitem, inputtext[])
{
	new userid = playerData[playerid][pTargetFrisk], amount = strval(inputtext);
	if(!response)
	{
		return 1;
	}
	if(response)
	{
	    if (amount <= 0)
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องระบุจำนวนมากกว่า '0'");

	    if (amount > GetPlayerMoneyEx(userid))
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "ผู้เล่นนั้นมีเงินเขียวไม่เพียงพอ");

		GivePlayerMoneyEx(playerid, amount);
		GivePlayerMoneyEx(userid, -amount);

		SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ปล้นเงินเขียวจำนวน {06C803}%s {FFFFFF}จากผู้เล่น {06C803}%s {FFFFFF}เรียบร้อยแล้ว", FormatMoney(amount), GetPlayerNameEx(userid));
		SendClientMessageEx(userid, COLOR_WHITE, "คุณถูกปล้นเงินเขียวจำนวน {06C803}%s {FFFFFF}จากผู้เล่น {06C803}%s {FFFFFF}", FormatMoney(amount), GetPlayerNameEx(playerid));

		SendClientMessageToAllEx(COLOR_LIGHTRED, "[จกของ]: {F7E60D}%s ได้ทำการปล้นเงินเขียวจำนวน %s ออกจากตัว %s เรียบร้อยแล้ว ))", GetPlayerNameEx(playerid), FormatMoney(amount), GetPlayerNameEx(userid));

        playerData[playerid][pTargetFrisk] = -1;
	}
	return 1;
}

Dialog:DIALOG_ROB_REDMONEY(playerid, response, listitem, inputtext[])
{
	new userid = playerData[playerid][pTargetFrisk], amount = strval(inputtext);
	if(!response)
	{
		return 1;
	}
	if(response)
	{
	    if (amount <= 0)
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องระบุจำนวนมากกว่า '0'");

	    if (amount > playerData[userid][pRedMoney])
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "ผู้เล่นนั้นมีเงินแดงไม่เพียงพอ");

		playerData[playerid][pRedMoney] += amount;
		playerData[userid][pRedMoney] -= amount;

		SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ปล้นเงินแดงจำนวน {FC4F29}%s {FFFFFF}จากผู้เล่น {FC4F29}%s {FFFFFF}เรียบร้อยแล้ว", FormatMoney(amount), GetPlayerNameEx(userid));
		SendClientMessageEx(userid, COLOR_WHITE, "คุณถูกปล้นเงินแดงจำนวน {FC4F29}%s {FFFFFF}จากผู้เล่น {FC4F29}%s {FFFFFF}", FormatMoney(amount), GetPlayerNameEx(playerid));

		SendClientMessageToAllEx(COLOR_LIGHTRED, "[จกของ]: {F7E60D}%s ได้ทำการปล้นเงินแดงจำนวน %s ออกจากตัว %s เรียบร้อยแล้ว ))", GetPlayerNameEx(playerid), FormatMoney(amount), GetPlayerNameEx(userid));

        playerData[playerid][pTargetFrisk] = -1;

	}
	return 1;
}*/

CMD:checkitem(playerid, params[])
{
	static
	    userid;

	if (playerData[playerid][pAdmin] < 2)
	    return 1;

	if (sscanf(params, "u", userid))
     	return SendClientMessage(playerid, COLOR_WHITE, "/checkitem [ไอดี/ชื่อ]");

    if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

	toggleInventory(playerid, userid);
	return 1;
}

forward toggleInventory(playerid, targetid);
public toggleInventory(playerid, targetid)
{
    if (playerData[playerid][IsLoggedIn] == false)
	    return 0;

	new
		string[4096],
		string2[4096],
		count,
		var[32];

    for (new i = 0; i < playerData[targetid][pMaxItem]; i ++)
	{
 		if (invData[targetid][i][invExists])
		 {
   			format(string, sizeof(string), "%s\t{D0AEEB}({FFFFFF}%d{D0AEEB})\n", invData[targetid][i][invItem], invData[targetid][i][invQuantity]);
   			strcat(string2, string);
   			format(var, sizeof(var), "itemlist%d", count);
   			SetPVarInt(targetid, var, i);
   			count++;
		}
	}
	if (!count)
	{
		SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นนั้นไม่มีของภายในตัว");
		return 1;
	}
	//playerData[playerid][pItemSelect] = 0;
	format(string, sizeof(string), "ชื่อ\tความจุ (%d/%d)\n%s", Inventory_Items(targetid), playerData[targetid][pMaxItem], string2);
	return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "[กระเป๋า]", string, "เลือก", "ปิด");
}

// ส่งน้ำมัน
/*CMD:startoil(playerid, params[]) {

	if(!IsVehicleMobileOil(GetPlayerVehicleID(playerid)))
		return SendClientMessage(playerid, COLOR_GREY, "คุณต้องอยู่ในรถบรรทุกน้ำมันเพื่อที่จะเริ่มงาน");

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        return SendClientMessage(playerid, COLOR_LIGHTRED, " คุณต้องเป็นคนขับรถ!");

	if(IsVehicleMobileOil(GetPlayerVehicleID(playerid)) )
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, -998.6666,-694.4783,32.0078))
		{
			if(playerData[playerid][pCheckpoint] == 0)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				for(new i=0; i < sizeof(GasVehiclePos);i++)
				{
					VObjectGas[vehicleid][i] = CreateDynamicObject(930,0,0,0,0,0,0);
					IsVehicleGas[vehicleid][i] = 930;
					AttachDynamicObjectToVehicle(VObjectGas[vehicleid][i], vehicleid, GasVehiclePos[i][0], GasVehiclePos[i][1], GasVehiclePos[i][2], GasVehiclePos[i][3], GasVehiclePos[i][4], GasVehiclePos[i][5]);
				}
				playerData[playerid][pCheckpoint] = 2;
				playerData[playerid][pTransportOil] = randomEx(1,2);
				playerData[playerid][pOilDelivered] = 0;

				switch (playerData[playerid][pTransportOil])
				{
					case 0: SetPlayerCheckpoint(playerid, 62.4386,1222.0441,18.8467, 3.0);
					case 1: SetPlayerCheckpoint(playerid, 658.7787,-569.6309,16.3359, 3.0);
					case 2: SetPlayerCheckpoint(playerid, 1005.1900,-904.5085,42.1978, 3.0);
				}
				SendClientMessage(playerid, COLOR_RED, "กรุณามุ่งหน้าไปยังตำแหน่งที่ปรากฏเพื่อส่งน้ำมัน");
			}
			else {
				SendClientMessage(playerid, COLOR_RED, "ได้มีการกำหนดจุดเช็คพอยท์แล้ว, ไปส่งให้เสร็จก่อน");
			}
		}
		else {
			SendClientMessage(playerid, COLOR_GREY, "คุณอยู่ห่างจากจุดรับงานมากเกินไป");
		}
	}
	return 1;
}

IsVehicleMobileOil(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
		case 605, 600, 543, 422, 478, 554: return true;
	}
	return false;
}*/

CMD:creategate(playerid, params[])
{
	static
	    id = -1;

    if (playerData[playerid][pAdmin] < 5)
	    return SendAdminAlert(COLOR_LIGHTRED, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้.");

	id = Gate_Create(playerid);

	if (id == -1)
	    return SendAdminAlert(COLOR_LIGHTRED, "The server has reached the limit for gates.");

	SendAdminAlert(COLOR_LIGHTRED, "You have successfully created gate ID: %d.", id);
	return 1;
}

CMD:destroygate(playerid, params[])
{
	static
	    id = 0;

    if (playerData[playerid][pAdmin] < 5)
	    return SendAdminAlert(COLOR_LIGHTRED, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้.");

	if (sscanf(params, "d", id))
	    return SendAdminAlert(COLOR_LIGHTRED, "/destroygate [gate id]");

	if ((id < 0 || id >= MAX_GATES) || !GateData[id][gateExists])
	    return SendAdminAlert(COLOR_LIGHTRED, "You have specified an invalid gate ID.");

	Gate_Delete(id);
	SendAdminAlert(COLOR_LIGHTRED, "You have successfully destroyed gate ID: %d.", id);
	return 1;
}

CMD:editgate(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (playerData[playerid][pAdmin] < 5)
	    return SendClientMessage(playerid, COLOR_GREY, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้.");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendClientMessage(playerid, COLOR_GREY, "/editgate [id] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, speed, radius, time, model, pos, move, pass, linkid, faction");
		return 1;
	}
	if ((id < 0 || id >= MAX_GATES) || !GateData[id][gateExists])
	    return SendClientMessage(playerid, COLOR_GREY, "You have specified an invalid gate ID.");

    if (!strcmp(type, "location", true))
	{
		static
		    Float:x,
		    Float:y,
		    Float:z,
		    Float:angle;

		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);

		x += 3.0 * floatsin(-angle, degrees);
		y += 3.0 * floatcos(-angle, degrees);

		GateData[id][gatePos][0] = x;
		GateData[id][gatePos][1] = y;
		GateData[id][gatePos][2] = z;
		GateData[id][gatePos][3] = 0.0;
		GateData[id][gatePos][4] = 0.0;
		GateData[id][gatePos][5] = angle;

		SetDynamicObjectPos(GateData[id][gateObject], x, y, z);
		SetDynamicObjectRot(GateData[id][gateObject], 0.0, 0.0, angle);

		GateData[id][gateOpened] = false;

		Gate_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s has adjusted the position of gate ID: %d.", GetPlayerNameEx(playerid), id);
		return 1;
	}
	else if (!strcmp(type, "speed", true))
	{
	    static
	        Float:speed;

		if (sscanf(string, "f", speed))
		    return SendClientMessage(playerid, COLOR_GREY, "/editgate [id] [speed] [move speed]");

		if (speed < 0.0 || speed > 20.0)
		    return SendClientMessage(playerid, COLOR_GREY, "The specified speed can't be below 0 or above 20.");

        GateData[id][gateSpeed] = speed;

		Gate_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s has adjusted the speed of gate ID: %d to %.2f.", GetPlayerNameEx(playerid), id, speed);
		return 1;
	}
	else if (!strcmp(type, "radius", true))
	{
	    static
	        Float:radius;

		if (sscanf(string, "f", radius))
		    return SendClientMessage(playerid, COLOR_GREY, "/editgate [id] [radius] [open radius]");

		if (radius < 0.0 || radius > 20.0)
		    return SendClientMessage(playerid, COLOR_GREY, "The specified radius can't be below 0 or above 20.");

        GateData[id][gateRadius] = radius;

		Gate_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s has adjusted the radius of gate ID: %d to %.2f.", GetPlayerNameEx(playerid), id, radius);
		return 1;
	}
	else if (!strcmp(type, "time", true))
	{
	    static
	        time;

		if (sscanf(string, "d", time))
		    return SendClientMessage(playerid, COLOR_GREY, "/editgate [id] [time] [close time] (0 to disable)");

		if (time < 0 || time > 60000)
		    return SendClientMessage(playerid, COLOR_GREY, "The specified time can't be 0 or above 60,000 ms.");

        GateData[id][gateTime] = time;

		Gate_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s has adjusted the close time of gate ID: %d to %d.", GetPlayerNameEx(playerid), id, time);
		return 1;
	}
	else if (!strcmp(type, "model", true))
	{
	    static
	        model;

		if (sscanf(string, "d", model))
		    return SendClientMessage(playerid, COLOR_GREY, "/editgate [id] [model] [gate model]");

		if (!IsValidObjectModel(model))
		    return SendClientMessage(playerid, COLOR_GREY, "Invalid object model.");

        GateData[id][gateModel] = model;

		DestroyDynamicObject(GateData[id][gateObject]);
		GateData[id][gateObject] = CreateDynamicObject(GateData[id][gateModel], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2], GateData[id][gatePos][3], GateData[id][gatePos][4], GateData[id][gatePos][5], GateData[id][gateWorld], GateData[id][gateInterior]);

		Gate_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s has adjusted the model of gate ID: %d to %d.", GetPlayerNameEx(playerid), id, model);
		return 1;
	}
    else if (!strcmp(type, "pos", true))
	{
	    ResetEditing(playerid);
	   	EditDynamicObject(playerid, GateData[id][gateObject]);

		playerData[playerid][pEditGate] = id;
		playerData[playerid][pEditType] = 1;

		SendAdminAlert(COLOR_LIGHTRED,  "You are now adjusting the position of gate ID: %d.", id);
		return 1;
	}
	else if (!strcmp(type, "move", true))
	{
	    ResetEditing(playerid);
	   	EditDynamicObject(playerid, GateData[id][gateObject]);

		playerData[playerid][pEditGate] = id;
		playerData[playerid][pEditType] = 2;

		SendAdminAlert(COLOR_LIGHTRED,  "You are now adjusting the position of gate ID: %d.", id);
		return 1;
	}
	else if (!strcmp(type, "linkid", true))
	{
	    static
	        linkid = -1;

		if (sscanf(string, "d", linkid))
		    return SendClientMessage(playerid, COLOR_GREY, "/editgate [id] [linkid] [gate link] (-1 for none)");

        if ((linkid < -1 || linkid >= MAX_GATES) || (linkid != -1 && !GateData[linkid][gateExists]))
	    	return SendClientMessage(playerid, COLOR_GREY, "You have specified an invalid gate ID.");

        GateData[id][gateLinkID] = (linkid == -1) ? (-1) : (GateData[linkid][gateID]);
		Gate_Save(id);

		if (id == -1)
			SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s has adjusted the faction of gate ID: %d to no gate.", GetPlayerNameEx(playerid), id);

		else
		    SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s has adjusted the faction of gate ID: %d to ID: %d.", GetPlayerNameEx(playerid), id, linkid);

		return 1;
	}
	else if (!strcmp(type, "faction", true))
	{
	    static
	        factionid = -1;

		if (sscanf(string, "d", factionid))
		    return SendClientMessage(playerid, COLOR_GREY, "/editgate [id] [faction] [gate faction] (-1 for none)");

        if ((factionid < -1 || factionid >= MAX_FACTIONS) || (factionid != -1 && !factionData[factionid][factionExists]))
	    	return SendClientMessage(playerid, COLOR_GREY, "You have specified an invalid faction ID.");

        GateData[id][gateFaction] = (factionid == -1) ? (-1) : (factionData[factionid][factionID]);
		Gate_Save(id);

		if (factionid == -1)
			SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s has adjusted the faction of gate ID: %d to no faction.", GetPlayerNameEx(playerid), id);

		else
		    SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s has adjusted the faction of gate ID: %d to \"%s\".", GetPlayerNameEx(playerid), id, factionData[factionid][factionName]);

		return 1;
	}
	else if (!strcmp(type, "pass", true))
	{
	    static
	        pass[32];

		if (sscanf(string, "s[32]", pass))
		    return SendClientMessage(playerid, COLOR_GREY, "/editgate [id] [pass] [gate password] (Use 'none' to disable)");

		if (!strcmp(params, "none", true))
			GateData[id][gatePass][0] = 0;

		else format(GateData[id][gatePass], 32, pass);

		Gate_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s has adjusted the password of gate ID: %d to %s.", GetPlayerNameEx(playerid), id, pass);
		return 1;
	}
	return 1;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if (response == EDIT_RESPONSE_FINAL)
	{

		 if (playerData[playerid][pEditGate] != -1 && GateData[playerData[playerid][pEditGate]][gateExists])
	    {
	        switch (playerData[playerid][pEditType])
	        {
	            case 1:
	            {
	                new id = playerData[playerid][pEditGate];

	                GateData[playerData[playerid][pEditGate]][gatePos][0] = x;
	                GateData[playerData[playerid][pEditGate]][gatePos][1] = y;
	                GateData[playerData[playerid][pEditGate]][gatePos][2] = z;
	                GateData[playerData[playerid][pEditGate]][gatePos][3] = rx;
	                GateData[playerData[playerid][pEditGate]][gatePos][4] = ry;
	                GateData[playerData[playerid][pEditGate]][gatePos][5] = rz;

	                DestroyDynamicObject(GateData[id][gateObject]);
					GateData[id][gateObject] = CreateDynamicObject(GateData[id][gateModel], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2], GateData[id][gatePos][3], GateData[id][gatePos][4], GateData[id][gatePos][5], GateData[id][gateWorld], GateData[id][gateInterior]);

					Gate_Save(id);
                    SendAdminAlert(COLOR_LIGHTRED,  "You have edited the position of gate ID: %d.", id);
				}
				case 2:
	            {
	                new id = playerData[playerid][pEditGate];

	                GateData[playerData[playerid][pEditGate]][gateMove][0] = x;
	                GateData[playerData[playerid][pEditGate]][gateMove][1] = y;
	                GateData[playerData[playerid][pEditGate]][gateMove][2] = z;
	                GateData[playerData[playerid][pEditGate]][gateMove][3] = rx;
	                GateData[playerData[playerid][pEditGate]][gateMove][4] = ry;
	                GateData[playerData[playerid][pEditGate]][gateMove][5] = rz;

	                DestroyDynamicObject(GateData[id][gateObject]);
					GateData[id][gateObject] = CreateDynamicObject(GateData[id][gateModel], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2], GateData[id][gatePos][3], GateData[id][gatePos][4], GateData[id][gatePos][5], GateData[id][gateWorld], GateData[id][gateInterior]);

					Gate_Save(id);
                    SendAdminAlert(COLOR_LIGHTRED,  "You have edited the moving position of gate ID: %d.", id);
				}
			}
		}
	}
	if (response == EDIT_RESPONSE_FINAL || response == EDIT_RESPONSE_CANCEL)
	{

	    playerData[playerid][pEditType] = 0;
	    playerData[playerid][pEditGate] = -1;
	}
	return 1;
}
CMD:open(playerid, params[])
{
	new id = Gate_Nearest(playerid);

	if (id != -1)
	{
		if (strlen(GateData[id][gatePass]))
		{
		    Dialog_Show(playerid, GatePass, DIALOG_STYLE_INPUT, "Enter Password", "Please enter the password for this gate below:", "Submit", "Cancel");
		}
		else
		{
		    if (GateData[id][gateFaction] != -1 && playerData[playerid][pFaction] != GetFactionByID(GateData[id][gateFaction]))
				return SendClientMessage(playerid,  0xFFFFFFAA,"คุณไม่สามารถเปิดประตูนี้ได้");

			Gate_Operate(id);

			switch (GateData[id][gateOpened])
			{
			    case 0:
				    //ShowPlayerFooter(playerid, "You have ~r~closed~w~ the gate!");
				    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ปิดประตู", GetPlayerNameEx(playerid));

                case 1:
        			//ShowPlayerFooter(playerid, "You have ~g~opened~w~ the gate!");
        			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s เปิดประตู", GetPlayerNameEx(playerid));
			}
		}
	}
	return 1;

}

stock GetGateByID(sqlid)
{
	for (new i = 0; i != MAX_GATES; i ++) if (GateData[i][gateExists] && GateData[i][gateID] == sqlid)
	    return i;

	return -1;
}

forward Gate_Load();
public Gate_Load()
{
    static
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_GATES)
	{
	    GateData[i][gateExists] = true;
	    GateData[i][gateOpened] = false;


	    cache_get_value_name_int(i, "gateID",GateData[i][gateID]);
	    cache_get_value_name_int(i, "gateModel",GateData[i][gateModel]);
	    cache_get_value_name_float(i, "gateSpeed",GateData[i][gateSpeed]);
	    cache_get_value_name_float(i, "gateRadius",GateData[i][gateRadius]);
	    cache_get_value_name_int(i, "gateTime",GateData[i][gateTime]);
	    cache_get_value_name_int(i, "gateInterior",GateData[i][gateInterior]);
	    cache_get_value_name_int(i, "gateWorld",GateData[i][gateWorld]);

	    cache_get_value_name_float(i, "gateX",GateData[i][gatePos][0]);
	    cache_get_value_name_float(i, "gateY",GateData[i][gatePos][1]);
	    cache_get_value_name_float(i, "gateZ",GateData[i][gatePos][2]);
	    cache_get_value_name_float(i, "gateRX",GateData[i][gatePos][3]);
	    cache_get_value_name_float(i, "gateRY",GateData[i][gatePos][4]);
	    cache_get_value_name_float(i, "gateRZ",GateData[i][gatePos][5]);

        cache_get_value_name_float(i, "gateMoveX",GateData[i][gateMove][0]);
	    cache_get_value_name_float(i, "gateMoveY",GateData[i][gateMove][1]);
	    cache_get_value_name_float(i, "gateMoveZ",GateData[i][gateMove][2]);
	    cache_get_value_name_float(i, "gateMoveRX",GateData[i][gateMove][3]);
	    cache_get_value_name_float(i, "gateMoveRY",GateData[i][gateMove][4]);
	    cache_get_value_name_float(i, "gateMoveRZ",GateData[i][gateMove][5]);

        cache_get_value_name_int(i, "gateLinkID",GateData[i][gateLinkID]);
	    cache_get_value_name_int(i, "gateFaction",GateData[i][gateFaction]);

		cache_get_value_name_int(i, "gatePass", GateData[i][gatePass]);
	    //cache_get_field_content(i, "gatePass", GateData[i][gatePass], g_iHandle, 32);
		printf("[SERVER]: %d Gates were loaded from \"%s\" database...", rows, MYSQL_DATABASE);
	    GateData[i][gateObject] = CreateDynamicObject(GateData[i][gateModel], GateData[i][gatePos][0], GateData[i][gatePos][1], GateData[i][gatePos][2], GateData[i][gatePos][3], GateData[i][gatePos][4], GateData[i][gatePos][5], GateData[i][gateWorld], GateData[i][gateInterior]);
	}
	printf("[SERVER]: %d Gates were loaded from \"%s\" database...", rows, MYSQL_DATABASE);
	return 1;
}

forward OnGateCreated(gateid);
public OnGateCreated(gateid)
{
	if (gateid == -1 || !GateData[gateid][gateExists])
	    return 0;

	GateData[gateid][gateID] = cache_insert_id();
	Gate_Save(gateid);

	return 1;
}


/*alias:autotune("จูนรถ")
CMD:autotune(playerid, params[])
{
    if (playerData[playerid][pAdmin] < 5)
	    return 1;

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นต้องอยู่ในสถานะคนขับ");

	if (!IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_RED, "- คุณต้องอยู่บนรถ");

	new string100[4096];
	new string2[4096];

	format(string100, sizeof(string100), "{FFFFFF}ระดับ\tClick\n");
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFFFFF}จูนรถ Lv.1\t{07FB07}Click\n");
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFFFFF}จูนรถ Lv.2\t{07FB07}Click\n");
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFFFFF}จูนรถ Lv.3\t{07FB07}Click\n");
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFFFFF}จูนรถ Lv.4\t{07FB07}Click\n");
	strcat(string2,string100);

	format(string100, sizeof(string100), "{FFFFFF}จูนรถ Lv.5\t{07FB07}Click\n");
	strcat(string2,string100);

	Dialog_Show(playerid, DIALOG_SPEED_CAR, DIALOG_STYLE_TABLIST_HEADERS, "{07FB07}[{45F745}การจูนรถยนต์{07FB07}]", string2, "ตกลง", "ยกเลิก");
    playerData[playerid][pSpeedGoon] = 1;
	return 1;
}

Dialog:DIALOG_SPEED_CAR(playerid, response, listitem, inputtext[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	new carid = carData[vehicleid][carID], query[256];

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นต้องอยู่ในสถานะคนขับ");

	if (!IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_RED, "- คุณต้องอยู่บนรถ");

	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		        PlayerEngine[playerid] = (53 / 5.0) / 1000.0;
   				carData[carid][carTune] = (53 / 5.0) / 1000.0;
   				carData[carid][carLevel] = 1;

				format(query, sizeof(query), "UPDATE vehicles SET carTune = %f, carLevel = 1 WHERE carID = %d", PlayerEngine[playerid], carid);
				mysql_tquery(g_SQL, query);

		        //PlayerEngine[playerid] = (90 / 5.0) / 1000.0;
		        SendClientMessage(playerid, COLOR_GREEN, "คุณได้ทำการจูนรถ Lv.1 ความเร็วเพิ่มขึ้น + 10 ))");
		    }
		    case 1:
		    {
		        PlayerEngine[playerid] = (56 / 5.0) / 1000.0;
   				carData[carid][carTune] = (56 / 5.0) / 1000.0;
   				carData[carid][carLevel] = 2;

				format(query, sizeof(query), "UPDATE vehicles SET carTune = %f, carLevel = 2 WHERE carID = %d", PlayerEngine[playerid], carid);
				mysql_tquery(g_SQL, query);

		        //PlayerEngine[playerid] = (90 / 5.0) / 1000.0;
		        SendClientMessage(playerid, COLOR_GREEN, "คุณได้ทำการจูนรถ Lv.2 ความเร็วเพิ่มขึ้น + 20 ))");
		    }
		    case 2:
		    {
		        PlayerEngine[playerid] = (59 / 5.0) / 1000.0;
   				carData[carid][carTune] = (59 / 5.0) / 1000.0;
   				carData[carid][carLevel] = 3;

				format(query, sizeof(query), "UPDATE vehicles SET carTune = %f, carLevel = 3 WHERE carID = %d", PlayerEngine[playerid], carid);
				mysql_tquery(g_SQL, query);

		        //PlayerEngine[playerid] = (90 / 5.0) / 1000.0;
		        SendClientMessage(playerid, COLOR_GREEN, "คุณได้ทำการจูนรถ Lv.3 ความเร็วเพิ่มขึ้น + 30 ))");
		    }
		    case 3:
		    {
		        PlayerEngine[playerid] = (66 / 5.0) / 1000.0;
   				carData[carid][carTune] = (66 / 5.0) / 1000.0;
   				carData[carid][carLevel] = 4;

				format(query, sizeof(query), "UPDATE vehicles SET carTune = %f, carLevel = 4 WHERE carID = %d", PlayerEngine[playerid], carid);
				mysql_tquery(g_SQL, query);

		        //PlayerEngine[playerid] = (90 / 5.0) / 1000.0;
		        SendClientMessage(playerid, COLOR_GREEN, "คุณได้ทำการจูนรถ Lv.4 ความเร็วเพิ่มขึ้น + 40 ))");
		    }
		    case 4:
		    {
		        PlayerEngine[playerid] = (90 / 5.0) / 1000.0;
   				carData[carid][carTune] = (90 / 5.0) / 1000.0;
   				carData[carid][carLevel] = 5;

				format(query, sizeof(query), "UPDATE vehicles SET carTune = %f, carLevel = 5 WHERE carID = %d", PlayerEngine[playerid], carid);
				mysql_tquery(g_SQL, query);

		        SendClientMessage(playerid, COLOR_GREEN, "คุณได้ทำการจูนรถ Lv.5 ความเร็วเพิ่มขึ้น + 50 ))");
		    }
		}
	}
	return 1;
}*/
//////////////////


/*CMD:CMD:setadmin(playerid, params[])
{
	if(playerData[playerid][pAdmin] >= 6)
	{
		new userid, level;

		if(sscanf(params, "ud", userid, level))
		   return SendClientMessage(playerid, COLOR_WHITE, "/setadmin [ไอดี/ชื่อ] [เลเวล]");

		if(userid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

		playerData[userid][pAdmin] = level;
		SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับเลเวลนายกให้กับ %s(%d) เป็นนายกเลเวล %d", GetPlayerNameEx(playerid), GetPlayerNameEx(userid), userid, level);
	}
 	return 1;
}*/

/*CMD:setadmin(playerid, params[])
{
    if(playerData[playerid][pAdmin] == 6)
    {
    	new userid, level;
        if(sscanf(params, "ud", userid, level))
			return SendClientMessage(playerid, COLOR_WHITE, "/setadmin [ไอดี/ชื่อ] [เลเวล]");

        if(userid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

        playerData[userid][pAdmin] = level;

        SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับเลเวลนายกให้กับ %s(%d) เป็นแอดมินเลเวล %d", GetPlayerNameEx(playerid), GetPlayerNameEx(userid), userid, level);
	}
    return 1;
}*/


/*ReturnWeaponName(weaponid)
{
    new
		name[32];

	GetWeaponName(weaponid, name, sizeof(name));

	if (!weaponid)
	    name = "None";

	else if (weaponid == 30)
	    name = "AK-47";

	else if (weaponid == 18)
	    name = "Molotov Cocktail";

	else if (weaponid == 44)
	    name = "Nightvision";

	else if (weaponid == 45)
	    name = "Infrared";

	else if (weaponid == 34)
	    name = "Sniper";

	return name;
}*/

stock Inventory_RemoveEx(playerid, itemid, quantity = 1)
{
	new
		string[128];

	if (itemid != -1)
	{
	    strunpack(string, invData[playerid][itemid][invItem]);

	    if (invData[playerid][itemid][invQuantity] > 0)
	    {
	        invData[playerid][itemid][invQuantity] -= quantity;
		}
		if (quantity == -1 || invData[playerid][itemid][invQuantity] < 1)
		{
		    invData[playerid][itemid][invExists] = false;
		    invData[playerid][itemid][invQuantity] = 0;

		    mysql_format(g_SQL, string, sizeof(string), "DELETE FROM `inventory` WHERE `invOwner` = '%d' AND `invID` = '%d'", playerData[playerid][pID], invData[playerid][itemid][invID]);
	        mysql_tquery(g_SQL, string);
		}
		else if (quantity != -1 && invData[playerid][itemid][invQuantity] > 0)
		{
			mysql_format(g_SQL, string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` - %d WHERE `invOwner` = '%d' AND `invID` = '%d'", quantity, playerData[playerid][pID], invData[playerid][itemid][invID]);
            mysql_tquery(g_SQL, string);
		}
		return 1;
	}
	return 0;
}

stock Inventory_GetItemSlot(playerid, const item[])
{
	for (new i = 0; i < MAX_INVENTORY; i ++)
	{
	    if (!invData[playerid][i][invExists])
	        continue;

		if (!strcmp(invData[playerid][i][invItem], item)) return i;
	}
	return -1;
}

forward FriskInventory3(playerid, userid);
public FriskInventory3(playerid, userid)
{
    if (playerData[userid][IsLoggedIn] == false)
	    return 0;

	new
		string[4096],
		string2[4096],
		count,
		var[32];

    for (new i = 0; i < playerData[userid][pMaxItem]; i ++)
	{
 		if (invData[userid][i][invExists])
		{
		    if (CheckItemDrugs(invData[userid][i][invItem]))
		    {
	   			format(string, sizeof(string), "%s\t{D0AEEB}({FFFFFF}%d{D0AEEB})\n", invData[userid][i][invItem], invData[userid][i][invQuantity]);
	   			strcat(string2, string);
	   			format(var, sizeof(var), "itemlistza%d", count);
	   			SetPVarInt(playerid, var, i);
	   			count++;
			}
		}
	}
	if (!count) {
		SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นนั้นไม่มีของผิดกฎหมายอยู่ในตัวเลย!");
		return 1;
	}
	playerData[playerid][pTargetFrisk] = userid;
	format(string, sizeof(string), "ชื่อ\tความจุ (%d/%d)\n%s", Inventory_Items(userid), playerData[userid][pMaxItem], string2);
	return Dialog_Show(playerid, DIALOG_INVENTORY234, DIALOG_STYLE_TABLIST_HEADERS, "[ยึดของผิดกฎหมาย]", string, "เลือก", "ปิด");
}

Dialog:DIALOG_INVENTORY234(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new userid = playerData[playerid][pTargetFrisk];
		new var[32];
		format(var, sizeof(var), "itemlistza%d", listitem);
		new item = GetPVarInt(playerid, var);

        FriskItemInventory(playerid, item, invData[userid][item][invItem]);
	}
	return 1;
}

forward FriskItemInventory(playerid, itemid, name[]);
public FriskItemInventory(playerid, itemid, name[])
{
	if (playerData[playerid][pTargetFrisk] == -1)
	    return 1;

	playerData[playerid][pItemSelect] = itemid;
	return Dialog_Show(playerid, DIALOG_INVENTORYMENU_12, DIALOG_STYLE_LIST, name, "ยึดของผิดกฎหมาย", "ตกลง", "ปิด");
}

Dialog:DIALOG_INVENTORYMENU_12(playerid, response, listitem, inputtext[])
{
	if (playerData[playerid][pTargetFrisk] == -1)
	    return 1;

	new userid = playerData[playerid][pTargetFrisk];
	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
	            new stringz[32];
				new itemid = playerData[playerid][pItemSelect];
				strunpack(stringz, invData[playerid][playerData[playerid][pItemSelect]][invItem]);

				Inventory_Add(playerid, invData[userid][itemid][invItem], invData[userid][itemid][invQuantity]);
				Inventory_Remove(userid, invData[userid][itemid][invItem], invData[userid][itemid][invQuantity]);

				SendClientMessageEx(playerid, COLOR_YELLOW, "คุณได้ทำการยึด %s ออกมาจากกระเป๋าของ %s จำนวน %d", invData[userid][itemid][invItem], GetPlayerNameEx(userid), invData[userid][itemid][invQuantity]);
				SendClientMessageEx(userid, COLOR_LIGHTRED, "คุณถูกยึด %s โดยเจ้าหน้าที่ %s จำนวน %d จากกระเป๋าเก็บของ", invData[userid][itemid][invItem], GetPlayerNameEx(userid), invData[userid][itemid][invQuantity]);

                playerData[playerid][pTargetFrisk] = -1;
				return 1;
			}
		}
	}
	return 1;
}

Dialog:DIALOG_BUYAL(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
				new itemname[24];
				itemname = "เหล้าขาว";
				new price = 100;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "[ ! ] {FFFFFF}คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				new count = Inventory_Count(playerid, itemname)+1;

				if (count > 20)
                    return SendClientMessageEx(playerid, COLOR_RED, "[ ! ] {FFFFFF}ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 1);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "[ ! ] {FFFFFF}ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }
		    case 1:
		    {
				new itemname[24];
				itemname = "ไวน์องุ่น";
				new price = 200;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "[ ! ] {FFFFFF}คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				new count = Inventory_Count(playerid, itemname)+1;

				if (count > 20)
                    return SendClientMessageEx(playerid, COLOR_RED, "[ ! ] {FFFFFF}ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 1);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "[ ! ] {FFFFFF}ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }
		    case 2:
		    {
				new itemname[24];
				itemname = "Regency";
				new price = 500;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "[ ! ] {FFFFFF}คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				new count = Inventory_Count(playerid, itemname)+1;

				if (count > 20)
                    return SendClientMessageEx(playerid, COLOR_RED, "[ ! ] {FFFFFF}ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 1);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "[ ! ] {FFFFFF}ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }
		    case 3:
		    {
				new itemname[24];
				itemname = "เบียร์ช้าง";
				new price = 80;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "[ ! ] {FFFFFF}คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				new count = Inventory_Count(playerid, itemname)+1;

				if (count > 20)
                    return SendClientMessageEx(playerid, COLOR_RED, "[ ! ] {FFFFFF}ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 1);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "[ ! ] {FFFFFF}ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }
		    case 4:
		    {
				new itemname[24];
				itemname = "เบียร์ลีโอ";
				new price = 150;

				if (GetPlayerMoneyEx(playerid) < price)
				    return SendClientMessageEx(playerid, COLOR_RED, "[ ! ] {FFFFFF}คุณมีเงินไม่เพียงพอในการซื้อ {00FF00}%s{FFFFFF} (%s/%s)", itemname, FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

				new count = Inventory_Count(playerid, itemname)+1;

				if (count > 20)
                    return SendClientMessageEx(playerid, COLOR_RED, "[ ! ] {FFFFFF}ช่องเก็บ {00FF00}%s{FFFFFF} ของคุณไม่เพียงพอ", itemname);

				new id = Inventory_Add(playerid, itemname, 1);

				if (id == -1)
				    return SendClientMessageEx(playerid, COLOR_RED, "[ ! ] {FFFFFF}ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);

				GivePlayerMoneyEx(playerid, -price);

				SendClientMessageEx(playerid, COLOR_GREEN, "[ร้านค้า] {FFFFFF}คุณได้ซื้อ {00FF00}%s{FFFFFF} สำเร็จ ในราคา {00FF00}%s", itemname, FormatMoney(price));
		    }
		}
	}
	return 1;
}



alias:Onair("ออนแอร์")//foreach (new i : Player)
CMD:Onair(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
        if(playerData[playerid][pAdmin] >= 1)
       	{
   			Dialog_Show(playerid, DIALOG_CUSTOM_BOOMBOX, DIALOG_STYLE_INPUT,"Boombox ระบุ URL","โปรดระบบลิ้งค์เพลงที่คุณต้องการให้ผู้เล่นได้ยินทั้งเซิฟเวอร์","ตกลง","ยกเลิก");
   		}
   		else
   		{
            SendClientMessage(playerid, 0xF699A4AA, "คุณไม่ใช่แอดมิน");
        }
   	}
    return 1;
}
Dialog:DIALOG_CUSTOM_BOOMBOX(playerid, response, listitem, inputtext[])
{
	if(response == 1)
	{
		if(isnull(inputtext))
		{
			SendClientMessage(playerid, COLOR_WHITE, "คุณต้องระบุ URL");
			return 1;
		}
		if(strlen(inputtext))
		{
			foreach (new i : Player)
			{
				StopAudioStreamForPlayer(i);
				PlayAudioStreamForPlayer(i, inputtext);
			}
			SendClientMessageToAllEx(0x5BE093AA, "DJ %s :ออนไลน์แล้วในขณะนี้ขอเพลงได้เลย ><ใครไม่ฟัง /ปิดเพลง  ใครอยากขอเพลง  /ขอเพลง" , GetPlayerNameEx(playerid));
		}
	}
	return 1;
}
/*
alias:cMusic("ขอเพลง")//
CMD:cMusic(playerid, params[])
{
	if (isnull(params))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "/ขอเพลง [ชื่อเพลง]");
	   // SendClientMessage(playerid, COLOR_LIGHTRED, "[คำเตือน]:{FFFFFF} ใช้คำสั่งนี่เฉพาะเหตุฉุกเฉินเท่านั้น");
	    return 1;
	}

	foreach (new i : Player)
	{
		if (playerData[i][pAdmin])
		{
			SendClientMessageEx(i, COLOR_YELLOW, "[ขอเพลง]: %s (ID: %d)  ชื่อเพลง: %s", GetPlayerNameEx(playerid), playerid, params);
		}
	}
	SendClientMessage(playerid, COLOR_GREEN, "คุณได้ส่งข้อความถึง DJ สำเร็จ กรุณาอย่าส่งซ้ำ !");
	return 1;
}
alias:offmusic("ปิดเพลง")
CMD:offmusic(playerid, params[])
{
	StopAudioStreamForPlayer(playerid);
	return 1;
}*/

forward TimeUnfreezeEnterGame(playerid);
public TimeUnfreezeEnterGame(playerid)
{
	TogglePlayerControllable(playerid, 1);
	//SendClientMessage(playerid, COLOR_YELLOW, "[ระบบ]: LoadObject และ Map เรียบร้อยแล้ว");
	return 1;
}

forward TimeUnfreeze(playerid);
public TimeUnfreeze(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}
/*
alias:givecar("เสกรถ")
CMD:givecar(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);

    if(playerData[playerid][pAdmin] >= 6)
    {
    	new userid, carid, query[1640];
        if(sscanf(params, "udf", userid, carid))
			return SendClientMessage(playerid, COLOR_WHITE, "/เสกรถ [ไอดี/ชื่อ] [ไอดีรถ]");

        if(userid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_RED, "[ ! ] {FFFFFF}ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vehicles (carOwnerID, carOwner, carModel, carFuel, carPosX, carPosY, carPosZ, carPosA) VALUES(%d, '%s', %d, %.1f, '557.8670', '-1283.9822', '17.0007', '0.0000')", playerData[userid][pID], GetPlayerNameEx(userid), carid, vehicleData[carData[vehicleid][carModel] - 400][vFuel]);
		mysql_tquery(g_SQL, query);

        SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ให้รถ %s กับ %s ", GetPlayerNameEx(playerid), g_arrVehicleNames[carid - 400], GetPlayerNameEx(userid));
	}
    return 1;
}*/



PlayerRepaironUnfreeze(playerid,vehicleid) {
    ClearAnimations(playerid);
    repairon[playerid] = 0;
    TogglePlayerControllable( playerid, true );
    RepairVehicle(vehicleid);
    SetVehicleHealth(vehicleid,999);
    SendClientMessage(playerid, COLOR_GREEN, "-  ซ่อมเสร็จแล้ว (กล่องซ่อม -1)");
	return 1;
}





alias:healf("กล่องชุบ")
CMD:healf(playerid, params[])
{
	static
	    userid;

	if (Inventory_Count(playerid, "กล่องชุบ") == 0)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "* คุณไม่มีกล่องชุบเพื่อน");

    if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/กล่องชุบ [ไอดี/ชื่อ]");

	if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_RED, "- เพื่อนของคุณไม่อยู่ในเกมส์");

	if (!playerData[userid][pInjured])
	    return SendClientMessage(playerid, COLOR_RED, "- เพื่อนของคุณยังไม่ตายเลยไอห่า *");

	if (userid == playerid)
	    return SendClientMessage(playerid, COLOR_RED, "- ไม่สามารถชุบตัวเองได้");


	SetPlayerHealth(userid, 100);
	SetPlayerWeather(userid, globalWeather);
    playerData[userid][pInjured] = 0;
    playerData[userid][pInjuredTime] = 0;
    ApplyAnimation(playerid, "MEDIC", "CPR", 4.0, 1, 0, 0, 0, 0, 1);
    PlayerTextDrawHide(userid, PlayerDeathTD[userid]);
    PlayerTextDrawHide(userid, DeathTD[userid]);
    ShowPlayerStats(userid, true);

    Inventory_Remove(playerid, "กล่องชุบ", 1);
    SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ใช้กล่องชุบ ชุบผู้เล่น {33CCFF}%s{FFFFFF}", GetPlayerNameEx(userid));
    SendClientMessageEx(userid, COLOR_LIGHTBLUE, "%s {FFFFFF}ได้ชุบชีวิตคุณ", GetPlayerNameEx(playerid));
    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้ใช้กล่องชุบ รักษา %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	return 1;
}

/*CMD:changepass(playerid, params[])
{
	if (playerData[playerid][pChangePass] == 0)
	    return SendClientMessage(playerid, COLOR_GREY, "คุณไม่มีบัตรเปลี่ยนรหัสผ่าน");

	Dialog_Show(playerid, DIALOG_CHANGE_PASS, DIALOG_STYLE_PASSWORD, "{02ADF7}(การเปลี่ยนรหัสผ่าน)", "{FFFFFF}โปรดป้อนรหัสผ่านเก่าของตัวละครของคุณ :", "ตกลง", "ยกเลิก");
	return 1;
}

Dialog:DIALOG_CHANGE_PASS(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext))
			return Dialog_Show(playerid, DIALOG_CHANGE_PASS, DIALOG_STYLE_PASSWORD, "{02ADF7}(การเปลี่ยนรหัสผ่าน)", "{FFFFFF}โปรดป้อนรหัสผ่านเก่าของตัวละครของคุณ :", "ตกลง", "ยกเลิก");

		new
		    buffer[129],
			query[256];

		WP_Hash(buffer, sizeof(buffer), inputtext);
		inputtext[0] = '\0';

		format(query, sizeof(query), "SELECT `playerPassword` FROM `players` WHERE `playerName` = '%s' AND `playerPassword` = '%s'", GetPlayerNameEx(playerid), buffer);
		mysql_tquery(g_SQL, query, "OnQueryFinished", "dd", playerid, THREAD_VERIFY_PASS);
	}
	return 1;
}

Dialog:DIALOG_NEWPASS(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext))
			return Dialog_Show(playerid, DIALOG_NEWPASS, DIALOG_STYLE_PASSWORD, "{02ADF7}(การเปลี่ยนรหัสผ่าน)", "โปรดระบุรหัสผ่านใหม่ที่คุณต้องการจะใช้ :", "ตกลง", "ยกเลิก");

  		new
		    buffer[129],
		    query[256];

		WP_Hash(buffer, sizeof(buffer), inputtext);
		inputtext[0] = '\0';

		format(query, sizeof(query), "UPDATE `players` SET `playerPassword` = '%s' WHERE `playerName` = '%s'", buffer, GetPlayerNameEx(playerid));
		mysql_tquery(g_SQL, query);

		SendClientMessage(playerid, -1, "{02F7B4}การเปลี่ยนรหัสผ่านสำเร็จแล้ว");
		playerData[playerid][pChangePass] --;
	}
	return 1;
}

// --> เปลี่ยนชื่อตัวละคร

stock ChangeName(playerid, name[])
{
	new
		query[160];

	SetPlayerName(playerid, name);

	format(query, sizeof(query), "UPDATE `players` SET `playerName` = '%s' WHERE `playerID` = '%d'", name, playerData[playerid][pID]);
	mysql_tquery(g_SQL, query);

	return 1;
}

CMD:changename(playerid, params[])
{
	if (playerData[playerid][pChangeName] == 0)
	    return SendClientMessage(playerid, COLOR_GREY, "คุณไม่มีบัตรเปลี่ยนชื่อ");

	if (isnull(params) || strlen(params) > 24)
	    return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : {FFFFFF}/changename [new name]");

	new
	    rows;

	cache_get_row_count(rows);

	if (rows)
	    return SendClientMessageEx(playerid, COLOR_GREY, "ชื่อที่ระบุ \"%s\" ถูกใช้งานแล้ว", params);

	foreach (new i : Player) if (!strcmp(GetPlayerNameEx(i), params, true)) {
	    return SendClientMessageEx(playerid, COLOR_GREY, "ชื่อที่ระบุ \"%s\" กำลังถูกใช้งานอยู่", params);
	}

	ChangeName(playerid, params);
	SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* คุณได้ทำการเปลี่ยนชื่อเป็น %s เรียบร้อยแล้ว", params);
	playerData[playerid][pChangeName] --;

	return 1;
}*/

alias:unbanip("ปลดแบนไอพี")
CMD:unbanip(playerid, params[]){

	if (playerData[playerid][pAdmin] < 6)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาติให้ใช้คำสั่งนี้");

	if (!IsAnIP(params))
		return ErrorMsg(playerid, "ที่อยู่ IP ที่คุณป้อนไม่ถูกต้องตามรูปแบบ");

	new string[128];

	format(string, sizeof(string), "คุณได้ปลดแบนไอพี %s เรียบร้อยแล้ว", params);
	SendClientMessage(playerid, -1, string);

	new str[64];
	format(str, sizeof(str), "unbanip %s", params);
    SendRconCommand(str);
    SendRconCommand("reloadbans");
	return 1;
}

CMD:settune(playerid, params[])
{
    if(playerData[playerid][pAdmin] > 6)
    {
    	new userid;
        if(sscanf(params, "ud", userid))
			return SendClientMessage(playerid, COLOR_WHITE, "/setadmin [ไอดี/ชื่อ] [เลเวล]");

        if(userid == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_RED, "- ผู้เล่นไอดีนี้ไม่ได้อยู่ในเกม");

        playerData[userid][pMaster] = 1;

        SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้givetuneให้กับ %s(%d)", GetPlayerNameEx(playerid), GetPlayerNameEx(userid), userid);
	}
    return 1;
}





Dialog:DIALOG_CALLCAR(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
  		{
			case 0:
			{
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `vehicles` WHERE `carOwnerID` = %d", playerData[playerid][pID]);
				mysql_tquery(g_SQL, query, "OnQueryFinished", "dd", playerid, THREAD_LIST_VEHICLES);	
			}
			case 1:
			{
				new string[MAX_SPAWNED_VEHICLES * 64], count;

				string = "#\tชื่อรุ่น";

				for(new i = 1; i < MAX_VEHICLES; i ++)
				{
					if(IsValidVehicle(i) && carData[i][carID] > 0 && IsVehicleOwner(playerid, i))
					{
						format(string, sizeof(string), "%s\n%d\t%s", string, count + 1, ReturnVehicleName(i));
						count++;
					}
				}

				if(!count)
				{
					SendClientMessage(playerid, COLOR_RED, "- ไม่มีรถของคุณจอดอยู่ในเซิร์ฟเวอร์ตอนนี้");
				}
				else
				{
					Dialog_Show(playerid, DIALOG_DESPAWNCAR, DIALOG_STYLE_TABLIST_HEADERS, "[เลือกรถของคุณที่ต้องการจะเก็บ]", string, "ตกลง", "ปิด");
				}
			}
		}
	}
	return 1;
}



public OnVehicleDeath(vehicleid, killerid)
{
	new query[128]/*, vehowner = GetConnectedVehicleOwnerID(vehicleid)*/;

	if (carData[vehicleid][carOwnerID] > 0)
	{
	    new components = randomEx(0,14);
	    if(carData[vehicleid][carMods][components] >= 1000)
		{
		    RemoveVehicleComponent(vehicleid, carData[vehicleid][carMods][components]);
		}

		mysql_format(g_SQL, query, sizeof(query), "UPDATE `vehicles` SET `carDestroy`= 1 WHERE `carID` = %d", carData[vehicleid][carID]);
		mysql_tquery(g_SQL, query);

		/*if (vehowner > -1)
		{
			SendClientMessage(vehowner, COLOR_LIGHTRED, "{F35A2D}แจ้งเตือน :: {FEC7B7}รถของคุณเสียหายหนัก! กรุณาทำการพาวรถก่อน!");
		}
		else
		{
			SendClientMessage(killerid, COLOR_LIGHTRED, "{F35A2D}แจ้งเตือน :: {FEC7B7}คุณได้ทำให้รถเสียหายอย่างหนัก, กรุณาทำการพาวรถ!");
		}*/
		DespawnVehicle(vehicleid);
		KillTimer(playerData[killerid][pSpeedoTimer]);

	}
	else
	{
	    SetVehicleToRespawn(vehicleid);
	}
	return 1;
}

// การพาวรถ
Dialog:DIALOG_CAR_DESTROY(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM vehicles WHERE carOwnerID = %d AND carDestroy = 1 LIMIT %d, 1", playerData[playerid][pID], listitem);
		mysql_tquery(g_SQL, query, "PawnCar_Garage", "ii", playerid, false);
	}
	return 1;
}

forward PawnCar_Garage(playerid, parked);
public PawnCar_Garage(playerid, parked)
{
	static
	    rows;

	cache_get_row_count(rows);

	if(!rows)
	{
	    ErrorMsg(playerid, "- พบข้อผิดพลาด! กรุณาติดต่อ Development");
	}
	else
	{
		new vid, carmodel;
		
	    for(new i = 0; i < MAX_VEHICLES; i ++)
	    {
			cache_get_value_name_int(0, "carID", vid);
			cache_get_value_name_int(0, "carModel", carmodel);
	        if(IsValidVehicle(i) && carData[i][carID] == vid)
	        {
	            return ErrorMsg(playerid, "- รถคันนี้ถูกเรียกออกมาใช้งานอยู่ในปัจจุบัน!");
	    	}
	    }

		new tmp2[127],
			price = 5000;

		if (GetPlayerMoneyEx(playerid) < price)
		    return ErrorMsg(playerid, "- คุณมีเงินไม่เพียงพอต่อการกู้ซากยานพาหนะ (( %s/%s ))", FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(price));

		new query[128];

		mysql_format(g_SQL, query, sizeof(query), "UPDATE `vehicles` SET `carDestroy`= 0, `carHealth`= 1000.0 WHERE `carID` = %d", vid);
		mysql_tquery(g_SQL, query);

		SendClientMessageEx(playerid, COLOR_GREEN, "[กู้ซากยานพาหนะ] คุณได้ทำการกู้ซากยานพาหนะ %s สำเร็จเรียบร้อย", ReturnVehicleModelName(carmodel));
		GivePlayerMoneyEx(playerid, -price);

		format(tmp2, sizeof(tmp2), "~r~-%s", FormatMoney(price));
		GameTextForPlayer(playerid, tmp2, 3000, 1);
	}

	return 1;
}



/*
IsPlayerOnline(SQLID)
{
	new playerOnline = -1;
    foreach (new i : Player)
    {
        if (playerData[i][IsLoggedIn])
        {
            if (playerData[i][pID] == SQLID)
            {
				playerOnline = i;
            }
        }
    }
    return playerOnline;
}
*/
PlayerHealHealth(playerid)
{
	useFirstAidKit[playerid] = 0;
	ClearAnimations(playerid);

	new Float:hp;
	GetPlayerHealth(playerid, hp);
	SetPlayerHealth(playerid, hp + 25.0);
	Inventory_Remove(playerid, "กล่องยาเพิ่มเลือด", 1);
	SendClientMessage(playerid, COLOR_LIGHTRED, "[!] คุณได้รับเลือดเพิ่ม 25.0 สำหรับการใช้งานกล่องยาเพิ่มเลือด!");
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้ใช้งานกล่องยาเพิ่มเลือด", GetPlayerNameEx(playerid));
	RemovePlayerAttachedObject(playerid, 9);
	ApplyAnimation(playerid, "GANGS", "prtial_gngtlkA", 4.1, 0, 1, 1, 1, 3 * 100, 1);
}


stock U_CheckPlayerNearObject(playerid, objectid, Float:range) 
{
    new Float:X, Float:Y, Float:Z; 
    GetObjectPos(objectid, X, Y, Z);
    return (IsPlayerInRangeOfPoint(playerid, range, X, Y, Z));
}

stock U_DestroyObjectNearPlayer(playerid,obj,Float:a) 
{
    if(U_CheckPlayerNearObject(playerid, obj, a))
    	DestroyObject(obj);
}

stock Log_Write(const path[], const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    File:file,
	    string[256]
	;
	if ((start = strfind(path, "/")) != -1) {
	    strmid(string, path, 0, start + 1);

	    if (!fexist(string))
	        return printf("** Warning: Directory \"%s\" doesn't exist.", string);
	}
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	file = fopen(path, io_append);

	if (!file)
	    return 0;

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 1024
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		fwrite(file, string);
		fwrite(file, "\r\n");
		fclose(file);

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}
	fwrite(file, str);
	fwrite(file, "\r\n");
	fclose(file);

	return 1;
}
forward GeneralListener();
public GeneralListener()
{
    foreach (new i : Player)
	{
	    if(AFKTimer[i] > 0)
		{
		    AFKTimer[i]--;
		    if(AFKTimer[i] <= 0)
		    {
		        AFKTimer[i] = 0;
                IsAFK{i} = true;
		    }
		}
		if(LegDelay[i] > 0) LegDelay[i]--;
	}
	return 1;
}
