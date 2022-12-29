/*
	Gamemode By: Justinz,Cario
*/
//==============================================================================
//          -- > Includes
//==============================================================================
#include <a_samp>
#include <a_actor>
#include <zcmd>
#include <a_mysql>
#include <sscanf2>
#include <foreach>
#include <streamer>
#include <mapandreas>
#include <easyDialog>
#include <eSelection>
#include <progress2>
#include <lookup>
#include <YSI\y_hooks>
#define CE_AUTO // แก้บัคข้อความสี
#include <CEFix> // Credits to Aktah
#include "/modules/server/defines.pwn"

//==============================================================================
//          -- > Enums
//==============================================================================

new pole1, pole2, pole3, pole4, pole5, pole6, pole7;

new CheckBanned[MAX_PLAYERS];

new UseUserControl[MAX_PLAYERS];

enum rInfo{

	rID,
	rChannel,
	rSlot,
	rOwner,
	rPassword[16]

}
new RadioInfo[MAX_RADIO][rInfo];

enum rbInfo
{
    sCreated,
    Float:sX,
    Float:sY,
    Float:sZ,
    sObject,
};
new Roadblocks[MAX_ROADBLOCKS][rbInfo];

enum acc
{
	SQLID,
	Name[32],
	Status,
	Admin,
	RegisterIP[16],
	LatestIP[16],
	AdminDuty
};

enum pinfo
{
	ID,
 	Username[32],
	Level,
	Cash,
	Admin,
	AdminDuty,
	Skin,
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	Float:Angle,
	VWorld,
	Interior,
	Age,
	Gender,
	Kicks,
	Muted,
	Float:Health,
	Float:Armour,
	Bank,
	Dealership,
	RegisterIP[16],
	LatestIP[16],
	NewID,
	ExemptIP,
    IsSpec,
    ClothesSelection,
    LastOnline,
    DeleteingObject,
    InHospital,
    MovableObject,
    Spawn,
    PNC,
    FactionOffer,
	FactionOffered,
	Faction,
	FactionID,
	FactionRank,
	FactionEdit,
	SelectedSlot,
	Report,
	ReportMessage[64],
	Spectating,
	DriversLicense,
	Refill,
	RefillPrice,
	Freeze,
	FreezeTimer,
	ShowFooter,
	FooterTimer,
	Business,
	Shipment,
	DeliverShipment,
	GasPump,
	GasStation,
	EditPump,
	Task,
	StoreTask,
	BankTask,
	TestTask,
	Phone,
	PortableRadio,
	FurnitureType,
	EditingItem[32 char],
	ProductModify,
	ClothesType,
	Entrance,
	Job,
	LoadType,
	LoadingPD,
	CarryCrate,
	CarryPD,
	MecOffer,
	MecType,
	MecCar,
	MecStep,
	MecTow,
	MecPrice,
	MecProd,
	MecCol1,
	MecCol2,
	Boombox,
	Jetpack,
	House,
	EditFurniture,
	InventoryItem,
	Capacity,
	StorageSelect,
	Exp,
	Savings,
	Paycheck,
	Minutes,
	Playerhours,
	PauseCheck,
	PauseTime,
	HouseID,
	SelectChar1,
	SelectChar2,
	SelectChar3,
	ConfirmChar,
	SetConfirmInjured,
	Injured,
	InjuredEx,
	InjuredSpawn,
	InjuredShoot,
	InjuredTime,
	Float:HealthLock,
	Float:HealthCheck,
	Float:ArmorLock,
	Float:ArmorCheck,
	Stunned,
	FirstAid,
	AidTimer,
	BoomboxEx,
	Channel,
	ChannelSlot,
	Contact,
	CallLine,
	IncomingCall,
	Emergency,
	Marker,
	Birthday,

	Float:Playerdepos[4],
	PlayerdeInt,
	PlayerdeWorld,
	CowMilkB,
	pDragged,
	pDraggedBy,
	pDragTimer,
	pSelectedSlot,

	//new Hugo
	AdminID,

    MaxItem,
	ItemAmount,
	ItemSelect,
	ItemOfferID,
	
	Whitelist,
	Thirsty,
	Hungry

};


enum contactData {
	contactID,
	contactExists,
	contactName[32],
	contactNumber
};

new ContactData[MAX_PLAYERS][MAX_CONTACTS][contactData];
new ListedContacts[MAX_PLAYERS][MAX_CONTACTS];


enum coreVehicles {
	vehRespawn,
	vehTemporary,
	vehLoads,
	vehLoadType,
	vehCrate,
	vehTrash,
	vehSirenOn,
	vehSirenObject,
	vehRadio,
	vehComponent,
	vehURL[128 char],
	Float:vehLoadHealth,
 	Float:vehLoadPos[3],
 	vehPDLoads1, //เนื้อสัตว
 	vehPDLoads2 //เครื่องดื่ม
};
new CoreVehicles[MAX_VEH][coreVehicles];

enum object
{
	SQLID,
	ObjectID,
	Name[32],
	Model,
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	Float:AngX,
	Float:AngY,
	Float:AngZ,
	World,
	Interior,
	Movable,
	Float:NewX,
	Float:NewY,
	Float:NewZ,
	Float:aNewX,
	Float:aNewY,
	Float:aNewZ
};

static const stock g_arrVehicleNames[][] = {
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


enum vmInfo{
	vmModel,
	vmEmerVeh,
	vmNews,
	vmName[24],
	vmPrice,
	vmType,
	vmInsurancePrice,
	Float:vmDonatorVeh,
	vmFuelInterval,

}
new VehicleModelInfo[300][vmInfo];



new bool:ParkCheckpoint[MAX_PLAYERS];

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
	PLAYER_DISABLE_NEWBIE,
	PLAYER_DISABLE_PM,
	PLAYER_DISABLE_FACTION,
	PLAYER_DISABLE_TESTER,
	PLAYER_DISABLE_BC,
	PLAYER_FPS

};

enum GPS_DATA {
	gpsID,
	gpsExists,
	gpsName[32],
	Float:gpsPosX,
	Float:gpsPosY,
	Float:gpsPosZ,
	gpsType
};
new gpsData[MAX_GPS][GPS_DATA];

new
	// Create an array with the same tag as the enum
	PlayerFlags:g_PlayerFlags[MAX_PLAYERS]
;


new Text:textdrawVariables[1];

enum systemE
{
	reportSystem,
}
new systemVariables[systemE];

new bool:IsAFK[ MAX_PLAYERS char ];
new AFKTimer[MAX_PLAYERS];

new Text:gServerTextdraws[5];

new IssueTimer[MAX_PLAYERS];
new DamageStatus[MAX_PLAYERS];

new bool:IsDamageShow[MAX_PLAYERS char];
new Text3D:DamageLabel[MAX_PLAYERS];

new BankPayCheck;

new PlayerText:Characters[MAX_PLAYERS][33];

new g_TaxVault;

native WP_Hash(buffer[], len, const str[]);

native IsValidVehicle(vehicleid);

enum e_InteriorData {
	e_InteriorName[32],
	e_InteriorID,
	Float:e_InteriorX,
	Float:e_InteriorY,
	Float:e_InteriorZ
};

new PlayerCheckpointBiz[MAX_PLAYERS];
new PlayerCheckpointHouse[MAX_PLAYERS];
new PlayerCheckpointEntrance[MAX_PLAYERS];

new levelcost = 1500; //level cost
new levelexp = 4; //levelexp

enum e_ZoneData
{
	e_ZoneName[32 char],
	Float:e_ZoneArea[6]
};


new const g_arrZoneData[][e_ZoneData] =
{
	{!"The Big Ear", 	              {-410.00, 1403.30, -3.00, -137.90, 1681.20, 200.00}},
	{!"Aldea Malvada",                {-1372.10, 2498.50, 0.00, -1277.50, 2615.30, 200.00}},
	{!"Angel Pine",                   {-2324.90, -2584.20, -6.10, -1964.20, -2212.10, 200.00}},
	{!"Arco del Oeste",               {-901.10, 2221.80, 0.00, -592.00, 2571.90, 200.00}},
	{!"Avispa Country Club",          {-2646.40, -355.40, 0.00, -2270.00, -222.50, 200.00}},
	{!"Avispa Country Club",          {-2831.80, -430.20, -6.10, -2646.40, -222.50, 200.00}},
	{!"Avispa Country Club",          {-2361.50, -417.10, 0.00, -2270.00, -355.40, 200.00}},
	{!"Avispa Country Club",          {-2667.80, -302.10, -28.80, -2646.40, -262.30, 71.10}},
	{!"Avispa Country Club",          {-2470.00, -355.40, 0.00, -2270.00, -318.40, 46.10}},
	{!"Avispa Country Club",          {-2550.00, -355.40, 0.00, -2470.00, -318.40, 39.70}},
	{!"Back o Beyond",                {-1166.90, -2641.10, 0.00, -321.70, -1856.00, 200.00}},
	{!"Battery Point",                {-2741.00, 1268.40, -4.50, -2533.00, 1490.40, 200.00}},
	{!"Bayside",                      {-2741.00, 2175.10, 0.00, -2353.10, 2722.70, 200.00}},
	{!"Bayside Marina",               {-2353.10, 2275.70, 0.00, -2153.10, 2475.70, 200.00}},
	{!"Beacon Hill",                  {-399.60, -1075.50, -1.40, -319.00, -977.50, 198.50}},
	{!"Blackfield",                   {964.30, 1203.20, -89.00, 1197.30, 1403.20, 110.90}},
	{!"Blackfield",                   {964.30, 1403.20, -89.00, 1197.30, 1726.20, 110.90}},
	{!"Blackfield Chapel",            {1375.60, 596.30, -89.00, 1558.00, 823.20, 110.90}},
	{!"Blackfield Chapel",            {1325.60, 596.30, -89.00, 1375.60, 795.00, 110.90}},
	{!"Blackfield Intersection",      {1197.30, 1044.60, -89.00, 1277.00, 1163.30, 110.90}},
	{!"Blackfield Intersection",      {1166.50, 795.00, -89.00, 1375.60, 1044.60, 110.90}},
	{!"Blackfield Intersection",      {1277.00, 1044.60, -89.00, 1315.30, 1087.60, 110.90}},
	{!"Blackfield Intersection",      {1375.60, 823.20, -89.00, 1457.30, 919.40, 110.90}},
	{!"Blueberry",                    {104.50, -220.10, 2.30, 349.60, 152.20, 200.00}},
	{!"Blueberry",                    {19.60, -404.10, 3.80, 349.60, -220.10, 200.00}},
	{!"Blueberry Acres",              {-319.60, -220.10, 0.00, 104.50, 293.30, 200.00}},
	{!"Caligula's Palace",            {2087.30, 1543.20, -89.00, 2437.30, 1703.20, 110.90}},
	{!"Caligula's Palace",            {2137.40, 1703.20, -89.00, 2437.30, 1783.20, 110.90}},
	{!"Calton Heights",               {-2274.10, 744.10, -6.10, -1982.30, 1358.90, 200.00}},
	{!"Chinatown",                    {-2274.10, 578.30, -7.60, -2078.60, 744.10, 200.00}},
	{!"City Hall",                    {-2867.80, 277.40, -9.10, -2593.40, 458.40, 200.00}},
	{!"Come-A-Lot",                   {2087.30, 943.20, -89.00, 2623.10, 1203.20, 110.90}},
	{!"Commerce",                     {1323.90, -1842.20, -89.00, 1701.90, -1722.20, 110.90}},
	{!"Commerce",                     {1323.90, -1722.20, -89.00, 1440.90, -1577.50, 110.90}},
	{!"Commerce",                     {1370.80, -1577.50, -89.00, 1463.90, -1384.90, 110.90}},
	{!"Commerce",                     {1463.90, -1577.50, -89.00, 1667.90, -1430.80, 110.90}},
	{!"Commerce",                     {1583.50, -1722.20, -89.00, 1758.90, -1577.50, 110.90}},
	{!"Commerce",                     {1667.90, -1577.50, -89.00, 1812.60, -1430.80, 110.90}},
	{!"Conference Center",            {1046.10, -1804.20, -89.00, 1323.90, -1722.20, 110.90}},
	{!"Conference Center",            {1073.20, -1842.20, -89.00, 1323.90, -1804.20, 110.90}},
	{!"Cranberry Station",            {-2007.80, 56.30, 0.00, -1922.00, 224.70, 100.00}},
	{!"Creek",                        {2749.90, 1937.20, -89.00, 2921.60, 2669.70, 110.90}},
	{!"Dillimore",                    {580.70, -674.80, -9.50, 861.00, -404.70, 200.00}},
	{!"Doherty",                      {-2270.00, -324.10, -0.00, -1794.90, -222.50, 200.00}},
	{!"Doherty",                      {-2173.00, -222.50, -0.00, -1794.90, 265.20, 200.00}},
	{!"Downtown",                     {-1982.30, 744.10, -6.10, -1871.70, 1274.20, 200.00}},
	{!"Downtown",                     {-1871.70, 1176.40, -4.50, -1620.30, 1274.20, 200.00}},
	{!"Downtown",                     {-1700.00, 744.20, -6.10, -1580.00, 1176.50, 200.00}},
	{!"Downtown",                     {-1580.00, 744.20, -6.10, -1499.80, 1025.90, 200.00}},
	{!"Downtown",                     {-2078.60, 578.30, -7.60, -1499.80, 744.20, 200.00}},
	{!"Downtown",                     {-1993.20, 265.20, -9.10, -1794.90, 578.30, 200.00}},
	{!"Downtown Los Santos",          {1463.90, -1430.80, -89.00, 1724.70, -1290.80, 110.90}},
	{!"Downtown Los Santos",          {1724.70, -1430.80, -89.00, 1812.60, -1250.90, 110.90}},
	{!"Downtown Los Santos",          {1463.90, -1290.80, -89.00, 1724.70, -1150.80, 110.90}},
	{!"Downtown Los Santos",          {1370.80, -1384.90, -89.00, 1463.90, -1170.80, 110.90}},
	{!"Downtown Los Santos",          {1724.70, -1250.90, -89.00, 1812.60, -1150.80, 110.90}},
	{!"Downtown Los Santos",          {1370.80, -1170.80, -89.00, 1463.90, -1130.80, 110.90}},
	{!"Downtown Los Santos",          {1378.30, -1130.80, -89.00, 1463.90, -1026.30, 110.90}},
	{!"Downtown Los Santos",          {1391.00, -1026.30, -89.00, 1463.90, -926.90, 110.90}},
	{!"Downtown Los Santos",          {1507.50, -1385.20, 110.90, 1582.50, -1325.30, 335.90}},
	{!"East Beach",                   {2632.80, -1852.80, -89.00, 2959.30, -1668.10, 110.90}},
	{!"East Beach",                   {2632.80, -1668.10, -89.00, 2747.70, -1393.40, 110.90}},
	{!"East Beach",                   {2747.70, -1668.10, -89.00, 2959.30, -1498.60, 110.90}},
	{!"East Beach",                   {2747.70, -1498.60, -89.00, 2959.30, -1120.00, 110.90}},
	{!"East Los Santos",              {2421.00, -1628.50, -89.00, 2632.80, -1454.30, 110.90}},
	{!"East Los Santos",              {2222.50, -1628.50, -89.00, 2421.00, -1494.00, 110.90}},
	{!"East Los Santos",              {2266.20, -1494.00, -89.00, 2381.60, -1372.00, 110.90}},
	{!"East Los Santos",              {2381.60, -1494.00, -89.00, 2421.00, -1454.30, 110.90}},
	{!"East Los Santos",              {2281.40, -1372.00, -89.00, 2381.60, -1135.00, 110.90}},
	{!"East Los Santos",              {2381.60, -1454.30, -89.00, 2462.10, -1135.00, 110.90}},
	{!"East Los Santos",              {2462.10, -1454.30, -89.00, 2581.70, -1135.00, 110.90}},
	{!"Easter Basin",                 {-1794.90, 249.90, -9.10, -1242.90, 578.30, 200.00}},
	{!"Easter Basin",                 {-1794.90, -50.00, -0.00, -1499.80, 249.90, 200.00}},
	{!"Easter Bay Airport",           {-1499.80, -50.00, -0.00, -1242.90, 249.90, 200.00}},
	{!"Easter Bay Airport",           {-1794.90, -730.10, -3.00, -1213.90, -50.00, 200.00}},
	{!"Easter Bay Airport",           {-1213.90, -730.10, 0.00, -1132.80, -50.00, 200.00}},
	{!"Easter Bay Airport",           {-1242.90, -50.00, 0.00, -1213.90, 578.30, 200.00}},
	{!"Easter Bay Airport",           {-1213.90, -50.00, -4.50, -947.90, 578.30, 200.00}},
	{!"Easter Bay Airport",           {-1315.40, -405.30, 15.40, -1264.40, -209.50, 25.40}},
	{!"Easter Bay Airport",           {-1354.30, -287.30, 15.40, -1315.40, -209.50, 25.40}},
	{!"Easter Bay Airport",           {-1490.30, -209.50, 15.40, -1264.40, -148.30, 25.40}},
	{!"Easter Bay Chemicals",         {-1132.80, -768.00, 0.00, -956.40, -578.10, 200.00}},
	{!"Easter Bay Chemicals",         {-1132.80, -787.30, 0.00, -956.40, -768.00, 200.00}},
	{!"El Castillo del Diablo",       {-464.50, 2217.60, 0.00, -208.50, 2580.30, 200.00}},
	{!"El Castillo del Diablo",       {-208.50, 2123.00, -7.60, 114.00, 2337.10, 200.00}},
	{!"El Castillo del Diablo",       {-208.50, 2337.10, 0.00, 8.40, 2487.10, 200.00}},
	{!"El Corona",                    {1812.60, -2179.20, -89.00, 1970.60, -1852.80, 110.90}},
	{!"El Corona",                    {1692.60, -2179.20, -89.00, 1812.60, -1842.20, 110.90}},
	{!"El Quebrados",                 {-1645.20, 2498.50, 0.00, -1372.10, 2777.80, 200.00}},
	{!"Esplanade East",               {-1620.30, 1176.50, -4.50, -1580.00, 1274.20, 200.00}},
	{!"Esplanade East",               {-1580.00, 1025.90, -6.10, -1499.80, 1274.20, 200.00}},
	{!"Esplanade East",               {-1499.80, 578.30, -79.60, -1339.80, 1274.20, 20.30}},
	{!"Esplanade North",              {-2533.00, 1358.90, -4.50, -1996.60, 1501.20, 200.00}},
	{!"Esplanade North",              {-1996.60, 1358.90, -4.50, -1524.20, 1592.50, 200.00}},
	{!"Esplanade North",              {-1982.30, 1274.20, -4.50, -1524.20, 1358.90, 200.00}},
	{!"Fallen Tree",                  {-792.20, -698.50, -5.30, -452.40, -380.00, 200.00}},
	{!"Fallow Bridge",                {434.30, 366.50, 0.00, 603.00, 555.60, 200.00}},
	{!"Fern Ridge",                   {508.10, -139.20, 0.00, 1306.60, 119.50, 200.00}},
	{!"Financial",                    {-1871.70, 744.10, -6.10, -1701.30, 1176.40, 300.00}},
	{!"Fisher's Lagoon",              {1916.90, -233.30, -100.00, 2131.70, 13.80, 200.00}},
	{!"Flint Intersection",           {-187.70, -1596.70, -89.00, 17.00, -1276.60, 110.90}},
	{!"Flint Range",                  {-594.10, -1648.50, 0.00, -187.70, -1276.60, 200.00}},
	{!"Fort Carson",                  {-376.20, 826.30, -3.00, 123.70, 1220.40, 200.00}},
	{!"Foster Valley",                {-2270.00, -430.20, -0.00, -2178.60, -324.10, 200.00}},
	{!"Foster Valley",                {-2178.60, -599.80, -0.00, -1794.90, -324.10, 200.00}},
	{!"Foster Valley",                {-2178.60, -1115.50, 0.00, -1794.90, -599.80, 200.00}},
	{!"Foster Valley",                {-2178.60, -1250.90, 0.00, -1794.90, -1115.50, 200.00}},
	{!"Frederick Bridge",             {2759.20, 296.50, 0.00, 2774.20, 594.70, 200.00}},
	{!"Gant Bridge",                  {-2741.40, 1659.60, -6.10, -2616.40, 2175.10, 200.00}},
	{!"Gant Bridge",                  {-2741.00, 1490.40, -6.10, -2616.40, 1659.60, 200.00}},
	{!"Ganton",                       {2222.50, -1852.80, -89.00, 2632.80, -1722.30, 110.90}},
	{!"Ganton",                       {2222.50, -1722.30, -89.00, 2632.80, -1628.50, 110.90}},
	{!"Garcia",                       {-2411.20, -222.50, -0.00, -2173.00, 265.20, 200.00}},
	{!"Garcia",                       {-2395.10, -222.50, -5.30, -2354.00, -204.70, 200.00}},
	{!"Garver Bridge",                {-1339.80, 828.10, -89.00, -1213.90, 1057.00, 110.90}},
	{!"Garver Bridge",                {-1213.90, 950.00, -89.00, -1087.90, 1178.90, 110.90}},
	{!"Garver Bridge",                {-1499.80, 696.40, -179.60, -1339.80, 925.30, 20.30}},
	{!"Glen Park",                    {1812.60, -1449.60, -89.00, 1996.90, -1350.70, 110.90}},
	{!"Glen Park",                    {1812.60, -1100.80, -89.00, 1994.30, -973.30, 110.90}},
	{!"Glen Park",                    {1812.60, -1350.70, -89.00, 2056.80, -1100.80, 110.90}},
	{!"Green Palms",                  {176.50, 1305.40, -3.00, 338.60, 1520.70, 200.00}},
	{!"Greenglass College",           {964.30, 1044.60, -89.00, 1197.30, 1203.20, 110.90}},
	{!"Greenglass College",           {964.30, 930.80, -89.00, 1166.50, 1044.60, 110.90}},
	{!"Hampton Barns",                {603.00, 264.30, 0.00, 761.90, 366.50, 200.00}},
	{!"Hankypanky Point",             {2576.90, 62.10, 0.00, 2759.20, 385.50, 200.00}},
	{!"Harry Gold Parkway",           {1777.30, 863.20, -89.00, 1817.30, 2342.80, 110.90}},
	{!"Hashbury",                     {-2593.40, -222.50, -0.00, -2411.20, 54.70, 200.00}},
	{!"Hilltop Farm",                 {967.30, -450.30, -3.00, 1176.70, -217.90, 200.00}},
	{!"Hunter Quarry",                {337.20, 710.80, -115.20, 860.50, 1031.70, 203.70}},
	{!"Idlewood",                     {1812.60, -1852.80, -89.00, 1971.60, -1742.30, 110.90}},
	{!"Idlewood",                     {1812.60, -1742.30, -89.00, 1951.60, -1602.30, 110.90}},
	{!"Idlewood",                     {1951.60, -1742.30, -89.00, 2124.60, -1602.30, 110.90}},
	{!"Idlewood",                     {1812.60, -1602.30, -89.00, 2124.60, -1449.60, 110.90}},
	{!"Idlewood",                     {2124.60, -1742.30, -89.00, 2222.50, -1494.00, 110.90}},
	{!"Idlewood",                     {1971.60, -1852.80, -89.00, 2222.50, -1742.30, 110.90}},
	{!"Jefferson",                    {1996.90, -1449.60, -89.00, 2056.80, -1350.70, 110.90}},
	{!"Jefferson",                    {2124.60, -1494.00, -89.00, 2266.20, -1449.60, 110.90}},
	{!"Jefferson",                    {2056.80, -1372.00, -89.00, 2281.40, -1210.70, 110.90}},
	{!"Jefferson",                    {2056.80, -1210.70, -89.00, 2185.30, -1126.30, 110.90}},
	{!"Jefferson",                    {2185.30, -1210.70, -89.00, 2281.40, -1154.50, 110.90}},
	{!"Jefferson",                    {2056.80, -1449.60, -89.00, 2266.20, -1372.00, 110.90}},
	{!"Julius Thruway East",          {2623.10, 943.20, -89.00, 2749.90, 1055.90, 110.90}},
	{!"Julius Thruway East",          {2685.10, 1055.90, -89.00, 2749.90, 2626.50, 110.90}},
	{!"Julius Thruway East",          {2536.40, 2442.50, -89.00, 2685.10, 2542.50, 110.90}},
	{!"Julius Thruway East",          {2625.10, 2202.70, -89.00, 2685.10, 2442.50, 110.90}},
	{!"Julius Thruway North",         {2498.20, 2542.50, -89.00, 2685.10, 2626.50, 110.90}},
	{!"Julius Thruway North",         {2237.40, 2542.50, -89.00, 2498.20, 2663.10, 110.90}},
	{!"Julius Thruway North",         {2121.40, 2508.20, -89.00, 2237.40, 2663.10, 110.90}},
	{!"Julius Thruway North",         {1938.80, 2508.20, -89.00, 2121.40, 2624.20, 110.90}},
	{!"Julius Thruway North",         {1534.50, 2433.20, -89.00, 1848.40, 2583.20, 110.90}},
	{!"Julius Thruway North",         {1848.40, 2478.40, -89.00, 1938.80, 2553.40, 110.90}},
	{!"Julius Thruway North",         {1704.50, 2342.80, -89.00, 1848.40, 2433.20, 110.90}},
	{!"Julius Thruway North",         {1377.30, 2433.20, -89.00, 1534.50, 2507.20, 110.90}},
	{!"Julius Thruway South",         {1457.30, 823.20, -89.00, 2377.30, 863.20, 110.90}},
	{!"Julius Thruway South",         {2377.30, 788.80, -89.00, 2537.30, 897.90, 110.90}},
	{!"Julius Thruway West",          {1197.30, 1163.30, -89.00, 1236.60, 2243.20, 110.90}},
	{!"Julius Thruway West",          {1236.60, 2142.80, -89.00, 1297.40, 2243.20, 110.90}},
	{!"Juniper Hill",                 {-2533.00, 578.30, -7.60, -2274.10, 968.30, 200.00}},
	{!"Juniper Hollow",               {-2533.00, 968.30, -6.10, -2274.10, 1358.90, 200.00}},
	{!"K.A.C.C. Military Fuels",      {2498.20, 2626.50, -89.00, 2749.90, 2861.50, 110.90}},
	{!"Kincaid Bridge",               {-1339.80, 599.20, -89.00, -1213.90, 828.10, 110.90}},
	{!"Kincaid Bridge",               {-1213.90, 721.10, -89.00, -1087.90, 950.00, 110.90}},
	{!"Kincaid Bridge",               {-1087.90, 855.30, -89.00, -961.90, 986.20, 110.90}},
	{!"King's",                       {-2329.30, 458.40, -7.60, -1993.20, 578.30, 200.00}},
	{!"King's",                       {-2411.20, 265.20, -9.10, -1993.20, 373.50, 200.00}},
	{!"King's",                       {-2253.50, 373.50, -9.10, -1993.20, 458.40, 200.00}},
	{!"LVA Freight Depot",            {1457.30, 863.20, -89.00, 1777.40, 1143.20, 110.90}},
	{!"LVA Freight Depot",            {1375.60, 919.40, -89.00, 1457.30, 1203.20, 110.90}},
	{!"LVA Freight Depot",            {1277.00, 1087.60, -89.00, 1375.60, 1203.20, 110.90}},
	{!"LVA Freight Depot",            {1315.30, 1044.60, -89.00, 1375.60, 1087.60, 110.90}},
	{!"LVA Freight Depot",            {1236.60, 1163.40, -89.00, 1277.00, 1203.20, 110.90}},
	{!"Las Barrancas",                {-926.10, 1398.70, -3.00, -719.20, 1634.60, 200.00}},
	{!"Las Brujas",                   {-365.10, 2123.00, -3.00, -208.50, 2217.60, 200.00}},
	{!"Las Colinas",                  {1994.30, -1100.80, -89.00, 2056.80, -920.80, 110.90}},
	{!"Las Colinas",                  {2056.80, -1126.30, -89.00, 2126.80, -920.80, 110.90}},
	{!"Las Colinas",                  {2185.30, -1154.50, -89.00, 2281.40, -934.40, 110.90}},
	{!"Las Colinas",                  {2126.80, -1126.30, -89.00, 2185.30, -934.40, 110.90}},
	{!"Las Colinas",                  {2747.70, -1120.00, -89.00, 2959.30, -945.00, 110.90}},
	{!"Las Colinas",                  {2632.70, -1135.00, -89.00, 2747.70, -945.00, 110.90}},
	{!"Las Colinas",                  {2281.40, -1135.00, -89.00, 2632.70, -945.00, 110.90}},
	{!"Las Payasadas",                {-354.30, 2580.30, 2.00, -133.60, 2816.80, 200.00}},
	{!"Las Venturas Airport",         {1236.60, 1203.20, -89.00, 1457.30, 1883.10, 110.90}},
	{!"Las Venturas Airport",         {1457.30, 1203.20, -89.00, 1777.30, 1883.10, 110.90}},
	{!"Las Venturas Airport",         {1457.30, 1143.20, -89.00, 1777.40, 1203.20, 110.90}},
	{!"Las Venturas Airport",         {1515.80, 1586.40, -12.50, 1729.90, 1714.50, 87.50}},
	{!"Last Dime Motel",              {1823.00, 596.30, -89.00, 1997.20, 823.20, 110.90}},
	{!"Leafy Hollow",                 {-1166.90, -1856.00, 0.00, -815.60, -1602.00, 200.00}},
	{!"Liberty City",                 {-1000.00, 400.00, 1300.00, -700.00, 600.00, 1400.00}},
	{!"Lil' Probe Inn",               {-90.20, 1286.80, -3.00, 153.80, 1554.10, 200.00}},
	{!"Linden Side",                  {2749.90, 943.20, -89.00, 2923.30, 1198.90, 110.90}},
	{!"Linden Station",               {2749.90, 1198.90, -89.00, 2923.30, 1548.90, 110.90}},
	{!"Linden Station",               {2811.20, 1229.50, -39.50, 2861.20, 1407.50, 60.40}},
	{!"Little Mexico",                {1701.90, -1842.20, -89.00, 1812.60, -1722.20, 110.90}},
	{!"Little Mexico",                {1758.90, -1722.20, -89.00, 1812.60, -1577.50, 110.90}},
	{!"Los Flores",                   {2581.70, -1454.30, -89.00, 2632.80, -1393.40, 110.90}},
	{!"Los Flores",                   {2581.70, -1393.40, -89.00, 2747.70, -1135.00, 110.90}},
	{!"Los Santos International",     {1249.60, -2394.30, -89.00, 1852.00, -2179.20, 110.90}},
	{!"Los Santos International",     {1852.00, -2394.30, -89.00, 2089.00, -2179.20, 110.90}},
	{!"Los Santos International",     {1382.70, -2730.80, -89.00, 2201.80, -2394.30, 110.90}},
	{!"Los Santos International",     {1974.60, -2394.30, -39.00, 2089.00, -2256.50, 60.90}},
	{!"Los Santos International",     {1400.90, -2669.20, -39.00, 2189.80, -2597.20, 60.90}},
	{!"Los Santos International",     {2051.60, -2597.20, -39.00, 2152.40, -2394.30, 60.90}},
	{!"Marina",                       {647.70, -1804.20, -89.00, 851.40, -1577.50, 110.90}},
	{!"Marina",                       {647.70, -1577.50, -89.00, 807.90, -1416.20, 110.90}},
	{!"Marina",                       {807.90, -1577.50, -89.00, 926.90, -1416.20, 110.90}},
	{!"Market",                       {787.40, -1416.20, -89.00, 1072.60, -1310.20, 110.90}},
	{!"Market",                       {952.60, -1310.20, -89.00, 1072.60, -1130.80, 110.90}},
	{!"Market",                       {1072.60, -1416.20, -89.00, 1370.80, -1130.80, 110.90}},
	{!"Market",                       {926.90, -1577.50, -89.00, 1370.80, -1416.20, 110.90}},
	{!"Market Station",               {787.40, -1410.90, -34.10, 866.00, -1310.20, 65.80}},
	{!"Martin Bridge",                {-222.10, 293.30, 0.00, -122.10, 476.40, 200.00}},
	{!"Missionary Hill",              {-2994.40, -811.20, 0.00, -2178.60, -430.20, 200.00}},
	{!"Montgomery",                   {1119.50, 119.50, -3.00, 1451.40, 493.30, 200.00}},
	{!"Montgomery",                   {1451.40, 347.40, -6.10, 1582.40, 420.80, 200.00}},
	{!"Montgomery Intersection",      {1546.60, 208.10, 0.00, 1745.80, 347.40, 200.00}},
	{!"Montgomery Intersection",      {1582.40, 347.40, 0.00, 1664.60, 401.70, 200.00}},
	{!"Mulholland",                   {1414.00, -768.00, -89.00, 1667.60, -452.40, 110.90}},
	{!"Mulholland",                   {1281.10, -452.40, -89.00, 1641.10, -290.90, 110.90}},
	{!"Mulholland",                   {1269.10, -768.00, -89.00, 1414.00, -452.40, 110.90}},
	{!"Mulholland",                   {1357.00, -926.90, -89.00, 1463.90, -768.00, 110.90}},
	{!"Mulholland",                   {1318.10, -910.10, -89.00, 1357.00, -768.00, 110.90}},
	{!"Mulholland",                   {1169.10, -910.10, -89.00, 1318.10, -768.00, 110.90}},
	{!"Mulholland",                   {768.60, -954.60, -89.00, 952.60, -860.60, 110.90}},
	{!"Mulholland",                   {687.80, -860.60, -89.00, 911.80, -768.00, 110.90}},
	{!"Mulholland",                   {737.50, -768.00, -89.00, 1142.20, -674.80, 110.90}},
	{!"Mulholland",                   {1096.40, -910.10, -89.00, 1169.10, -768.00, 110.90}},
	{!"Mulholland",                   {952.60, -937.10, -89.00, 1096.40, -860.60, 110.90}},
	{!"Mulholland",                   {911.80, -860.60, -89.00, 1096.40, -768.00, 110.90}},
	{!"Mulholland",                   {861.00, -674.80, -89.00, 1156.50, -600.80, 110.90}},
	{!"Mulholland Intersection",      {1463.90, -1150.80, -89.00, 1812.60, -768.00, 110.90}},
	{!"North Rock",                   {2285.30, -768.00, 0.00, 2770.50, -269.70, 200.00}},
	{!"Ocean Docks",                  {2373.70, -2697.00, -89.00, 2809.20, -2330.40, 110.90}},
	{!"Ocean Docks",                  {2201.80, -2418.30, -89.00, 2324.00, -2095.00, 110.90}},
	{!"Ocean Docks",                  {2324.00, -2302.30, -89.00, 2703.50, -2145.10, 110.90}},
	{!"Ocean Docks",                  {2089.00, -2394.30, -89.00, 2201.80, -2235.80, 110.90}},
	{!"Ocean Docks",                  {2201.80, -2730.80, -89.00, 2324.00, -2418.30, 110.90}},
	{!"Ocean Docks",                  {2703.50, -2302.30, -89.00, 2959.30, -2126.90, 110.90}},
	{!"Ocean Docks",                  {2324.00, -2145.10, -89.00, 2703.50, -2059.20, 110.90}},
	{!"Ocean Flats",                  {-2994.40, 277.40, -9.10, -2867.80, 458.40, 200.00}},
	{!"Ocean Flats",                  {-2994.40, -222.50, -0.00, -2593.40, 277.40, 200.00}},
	{!"Ocean Flats",                  {-2994.40, -430.20, -0.00, -2831.80, -222.50, 200.00}},
	{!"Octane Springs",               {338.60, 1228.50, 0.00, 664.30, 1655.00, 200.00}},
	{!"Old Venturas Strip",           {2162.30, 2012.10, -89.00, 2685.10, 2202.70, 110.90}},
	{!"Palisades",                    {-2994.40, 458.40, -6.10, -2741.00, 1339.60, 200.00}},
	{!"Palomino Creek",               {2160.20, -149.00, 0.00, 2576.90, 228.30, 200.00}},
	{!"Paradiso",                     {-2741.00, 793.40, -6.10, -2533.00, 1268.40, 200.00}},
	{!"Pershing Square",              {1440.90, -1722.20, -89.00, 1583.50, -1577.50, 110.90}},
	{!"Pilgrim",                      {2437.30, 1383.20, -89.00, 2624.40, 1783.20, 110.90}},
	{!"Pilgrim",                      {2624.40, 1383.20, -89.00, 2685.10, 1783.20, 110.90}},
	{!"Pilson Intersection",          {1098.30, 2243.20, -89.00, 1377.30, 2507.20, 110.90}},
	{!"Pirates in Men's Pants",       {1817.30, 1469.20, -89.00, 2027.40, 1703.20, 110.90}},
	{!"Playa del Seville",            {2703.50, -2126.90, -89.00, 2959.30, -1852.80, 110.90}},
	{!"Prickle Pine",                 {1534.50, 2583.20, -89.00, 1848.40, 2863.20, 110.90}},
	{!"Prickle Pine",                 {1117.40, 2507.20, -89.00, 1534.50, 2723.20, 110.90}},
	{!"Prickle Pine",                 {1848.40, 2553.40, -89.00, 1938.80, 2863.20, 110.90}},
	{!"Prickle Pine",                 {1938.80, 2624.20, -89.00, 2121.40, 2861.50, 110.90}},
	{!"Queens",                       {-2533.00, 458.40, 0.00, -2329.30, 578.30, 200.00}},
	{!"Queens",                       {-2593.40, 54.70, 0.00, -2411.20, 458.40, 200.00}},
	{!"Queens",                       {-2411.20, 373.50, 0.00, -2253.50, 458.40, 200.00}},
	{!"Randolph Industrial Estate",   {1558.00, 596.30, -89.00, 1823.00, 823.20, 110.90}},
	{!"Redsands East",                {1817.30, 2011.80, -89.00, 2106.70, 2202.70, 110.90}},
	{!"Redsands East",                {1817.30, 2202.70, -89.00, 2011.90, 2342.80, 110.90}},
	{!"Redsands East",                {1848.40, 2342.80, -89.00, 2011.90, 2478.40, 110.90}},
	{!"Redsands West",                {1236.60, 1883.10, -89.00, 1777.30, 2142.80, 110.90}},
	{!"Redsands West",                {1297.40, 2142.80, -89.00, 1777.30, 2243.20, 110.90}},
	{!"Redsands West",                {1377.30, 2243.20, -89.00, 1704.50, 2433.20, 110.90}},
	{!"Redsands West",                {1704.50, 2243.20, -89.00, 1777.30, 2342.80, 110.90}},
	{!"Regular Tom",                  {-405.70, 1712.80, -3.00, -276.70, 1892.70, 200.00}},
	{!"Richman",                      {647.50, -1118.20, -89.00, 787.40, -954.60, 110.90}},
	{!"Richman",                      {647.50, -954.60, -89.00, 768.60, -860.60, 110.90}},
	{!"Richman",                      {225.10, -1369.60, -89.00, 334.50, -1292.00, 110.90}},
	{!"Richman",                      {225.10, -1292.00, -89.00, 466.20, -1235.00, 110.90}},
	{!"Richman",                      {72.60, -1404.90, -89.00, 225.10, -1235.00, 110.90}},
	{!"Richman",                      {72.60, -1235.00, -89.00, 321.30, -1008.10, 110.90}},
	{!"Richman",                      {321.30, -1235.00, -89.00, 647.50, -1044.00, 110.90}},
	{!"Richman",                      {321.30, -1044.00, -89.00, 647.50, -860.60, 110.90}},
	{!"Richman",                      {321.30, -860.60, -89.00, 687.80, -768.00, 110.90}},
	{!"Richman",                      {321.30, -768.00, -89.00, 700.70, -674.80, 110.90}},
	{!"Robada Intersection",          {-1119.00, 1178.90, -89.00, -862.00, 1351.40, 110.90}},
	{!"Roca Escalante",               {2237.40, 2202.70, -89.00, 2536.40, 2542.50, 110.90}},
	{!"Roca Escalante",               {2536.40, 2202.70, -89.00, 2625.10, 2442.50, 110.90}},
	{!"Rockshore East",               {2537.30, 676.50, -89.00, 2902.30, 943.20, 110.90}},
	{!"Rockshore West",               {1997.20, 596.30, -89.00, 2377.30, 823.20, 110.90}},
	{!"Rockshore West",               {2377.30, 596.30, -89.00, 2537.30, 788.80, 110.90}},
	{!"Rodeo",                        {72.60, -1684.60, -89.00, 225.10, -1544.10, 110.90}},
	{!"Rodeo",                        {72.60, -1544.10, -89.00, 225.10, -1404.90, 110.90}},
	{!"Rodeo",                        {225.10, -1684.60, -89.00, 312.80, -1501.90, 110.90}},
	{!"Rodeo",                        {225.10, -1501.90, -89.00, 334.50, -1369.60, 110.90}},
	{!"Rodeo",                        {334.50, -1501.90, -89.00, 422.60, -1406.00, 110.90}},
	{!"Rodeo",                        {312.80, -1684.60, -89.00, 422.60, -1501.90, 110.90}},
	{!"Rodeo",                        {422.60, -1684.60, -89.00, 558.00, -1570.20, 110.90}},
	{!"Rodeo",                        {558.00, -1684.60, -89.00, 647.50, -1384.90, 110.90}},
	{!"Rodeo",                        {466.20, -1570.20, -89.00, 558.00, -1385.00, 110.90}},
	{!"Rodeo",                        {422.60, -1570.20, -89.00, 466.20, -1406.00, 110.90}},
	{!"Rodeo",                        {466.20, -1385.00, -89.00, 647.50, -1235.00, 110.90}},
	{!"Rodeo",                        {334.50, -1406.00, -89.00, 466.20, -1292.00, 110.90}},
	{!"Royal Casino",                 {2087.30, 1383.20, -89.00, 2437.30, 1543.20, 110.90}},
	{!"San Andreas Sound",            {2450.30, 385.50, -100.00, 2759.20, 562.30, 200.00}},
	{!"Santa Flora",                  {-2741.00, 458.40, -7.60, -2533.00, 793.40, 200.00}},
	{!"Santa Maria Beach",            {342.60, -2173.20, -89.00, 647.70, -1684.60, 110.90}},
	{!"Santa Maria Beach",            {72.60, -2173.20, -89.00, 342.60, -1684.60, 110.90}},
	{!"Shady Cabin",                  {-1632.80, -2263.40, -3.00, -1601.30, -2231.70, 200.00}},
	{!"Shady Creeks",                 {-1820.60, -2643.60, -8.00, -1226.70, -1771.60, 200.00}},
	{!"Shady Creeks",                 {-2030.10, -2174.80, -6.10, -1820.60, -1771.60, 200.00}},
	{!"Sobell Rail Yards",            {2749.90, 1548.90, -89.00, 2923.30, 1937.20, 110.90}},
	{!"Spinybed",                     {2121.40, 2663.10, -89.00, 2498.20, 2861.50, 110.90}},
	{!"Starfish Casino",              {2437.30, 1783.20, -89.00, 2685.10, 2012.10, 110.90}},
	{!"Starfish Casino",              {2437.30, 1858.10, -39.00, 2495.00, 1970.80, 60.90}},
	{!"Starfish Casino",              {2162.30, 1883.20, -89.00, 2437.30, 2012.10, 110.90}},
	{!"Temple",                       {1252.30, -1130.80, -89.00, 1378.30, -1026.30, 110.90}},
	{!"Temple",                       {1252.30, -1026.30, -89.00, 1391.00, -926.90, 110.90}},
	{!"Temple",                       {1252.30, -926.90, -89.00, 1357.00, -910.10, 110.90}},
	{!"Temple",                       {952.60, -1130.80, -89.00, 1096.40, -937.10, 110.90}},
	{!"Temple",                       {1096.40, -1130.80, -89.00, 1252.30, -1026.30, 110.90}},
	{!"Temple",                       {1096.40, -1026.30, -89.00, 1252.30, -910.10, 110.90}},
	{!"The Camel's Toe",              {2087.30, 1203.20, -89.00, 2640.40, 1383.20, 110.90}},
	{!"The Clown's Pocket",           {2162.30, 1783.20, -89.00, 2437.30, 1883.20, 110.90}},
	{!"The Emerald Isle",             {2011.90, 2202.70, -89.00, 2237.40, 2508.20, 110.90}},
	{!"The Farm",                     {-1209.60, -1317.10, 114.90, -908.10, -787.30, 251.90}},
	{!"The Four Dragons Casino",      {1817.30, 863.20, -89.00, 2027.30, 1083.20, 110.90}},
	{!"The High Roller",              {1817.30, 1283.20, -89.00, 2027.30, 1469.20, 110.90}},
	{!"The Mako Span",                {1664.60, 401.70, 0.00, 1785.10, 567.20, 200.00}},
	{!"The Panopticon",               {-947.90, -304.30, -1.10, -319.60, 327.00, 200.00}},
	{!"The Pink Swan",                {1817.30, 1083.20, -89.00, 2027.30, 1283.20, 110.90}},
	{!"The Sherman Dam",              {-968.70, 1929.40, -3.00, -481.10, 2155.20, 200.00}},
	{!"The Strip",                    {2027.40, 863.20, -89.00, 2087.30, 1703.20, 110.90}},
	{!"The Strip",                    {2106.70, 1863.20, -89.00, 2162.30, 2202.70, 110.90}},
	{!"The Strip",                    {2027.40, 1783.20, -89.00, 2162.30, 1863.20, 110.90}},
	{!"The Strip",                    {2027.40, 1703.20, -89.00, 2137.40, 1783.20, 110.90}},
	{!"The Visage",                   {1817.30, 1863.20, -89.00, 2106.70, 2011.80, 110.90}},
	{!"The Visage",                   {1817.30, 1703.20, -89.00, 2027.40, 1863.20, 110.90}},
	{!"Unity Station",                {1692.60, -1971.80, -20.40, 1812.60, -1932.80, 79.50}},
	{!"Valle Ocultado",               {-936.60, 2611.40, 2.00, -715.90, 2847.90, 200.00}},
	{!"Verdant Bluffs",               {930.20, -2488.40, -89.00, 1249.60, -2006.70, 110.90}},
	{!"Verdant Bluffs",               {1073.20, -2006.70, -89.00, 1249.60, -1842.20, 110.90}},
	{!"Verdant Bluffs",               {1249.60, -2179.20, -89.00, 1692.60, -1842.20, 110.90}},
	{!"Verdant Meadows",              {37.00, 2337.10, -3.00, 435.90, 2677.90, 200.00}},
	{!"Verona Beach",                 {647.70, -2173.20, -89.00, 930.20, -1804.20, 110.90}},
	{!"Verona Beach",                 {930.20, -2006.70, -89.00, 1073.20, -1804.20, 110.90}},
	{!"Verona Beach",                 {851.40, -1804.20, -89.00, 1046.10, -1577.50, 110.90}},
	{!"Verona Beach",                 {1161.50, -1722.20, -89.00, 1323.90, -1577.50, 110.90}},
	{!"Verona Beach",                 {1046.10, -1722.20, -89.00, 1161.50, -1577.50, 110.90}},
	{!"Vinewood",                     {787.40, -1310.20, -89.00, 952.60, -1130.80, 110.90}},
	{!"Vinewood",                     {787.40, -1130.80, -89.00, 952.60, -954.60, 110.90}},
	{!"Vinewood",                     {647.50, -1227.20, -89.00, 787.40, -1118.20, 110.90}},
	{!"Vinewood",                     {647.70, -1416.20, -89.00, 787.40, -1227.20, 110.90}},
	{!"Whitewood Estates",            {883.30, 1726.20, -89.00, 1098.30, 2507.20, 110.90}},
	{!"Whitewood Estates",            {1098.30, 1726.20, -89.00, 1197.30, 2243.20, 110.90}},
	{!"Willowfield",                  {1970.60, -2179.20, -89.00, 2089.00, -1852.80, 110.90}},
	{!"Willowfield",                  {2089.00, -2235.80, -89.00, 2201.80, -1989.90, 110.90}},
	{!"Willowfield",                  {2089.00, -1989.90, -89.00, 2324.00, -1852.80, 110.90}},
	{!"Willowfield",                  {2201.80, -2095.00, -89.00, 2324.00, -1989.90, 110.90}},
	{!"Willowfield",                  {2541.70, -1941.40, -89.00, 2703.50, -1852.80, 110.90}},
	{!"Willowfield",                  {2324.00, -2059.20, -89.00, 2541.70, -1852.80, 110.90}},
	{!"Willowfield",                  {2541.70, -2059.20, -89.00, 2703.50, -1941.40, 110.90}},
	{!"Yellow Bell Station",          {1377.40, 2600.40, -21.90, 1492.40, 2687.30, 78.00}},
	{!"Los Santos",                   {44.60, -2892.90, -242.90, 2997.00, -768.00, 900.00}},
	{!"Las Venturas",                 {869.40, 596.30, -242.90, 2997.00, 2993.80, 900.00}},
	{!"Bone County",                  {-480.50, 596.30, -242.90, 869.40, 2993.80, 900.00}},
	{!"Tierra Robada",                {-2997.40, 1659.60, -242.90, -480.50, 2993.80, 900.00}},
	{!"Tierra Robada",                {-1213.90, 596.30, -242.90, -480.50, 1659.60, 900.00}},
	{!"San Fierro",                   {-2997.40, -1115.50, -242.90, -1213.90, 1659.60, 900.00}},
	{!"Red County",                   {-1213.90, -768.00, -242.90, 2997.00, 596.30, 900.00}},
	{!"Flint County",                 {-1213.90, -2892.90, -242.90, 44.60, -768.00, 900.00}},
	{!"Whetstone",                    {-2997.40, -2892.90, -242.90, -1213.90, -1115.50, 900.00}}
};

enum damagedata {
	dExists,
	dSec,
	dShotType,
	dWeaponid,
	dDamage,
	dArmour
};

new DamageData[MAX_PLAYERS][MAX_DAMAGES][damagedata];

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

new PlayerText:Footer[MAX_PLAYERS];

new PlayerText:Speedo[MAX_PLAYERS];

new Float:vpos[MAX_VEHICLES][4];

new vehicle_alarm_time[MAX_VEHICLES];

new fuel_interval[MAX_VEHICLES];

new Float:crash_vhp[MAX_VEHICLES];
new seatbelt[MAX_PLAYERS char];

new Float:player_vehicle_speed[MAX_PLAYERS];

//==========================================================================
//	Server/Player Variables												  //
//==========================================================================

new g_ServerRestart;
new g_RestartTime;
new Text:RestartTextdraws[1];

new vehiclecallsign[MAX_VEH];
new Text3D:vehicle3Dtext[MAX_VEH];
new startup_delay_sender[MAX_VEH];
new startup_delay[MAX_VEH];

new PlayerEnterTime[MAX_PLAYERS] = INVALID_VEHICLE_ID;

new Character[MAX_PLAYERS][pinfo];
new Account[MAX_PLAYERS][acc];

new OOCStatus = 0;

new bool: LoggedIn[MAX_PLAYERS];

new dmv_vehicles[4];

new ActorDonut;
new Gardener;
new CowMilking;

new EmergencyLights[MAX_VEH];
new EmergencyState[MAX_VEH];

new Objects[MAX_OBJECTZ][object], Total_Objects_Created;


//==========================================================================
//	Server Clock 														  //
//==========================================================================
//new Text:Clock;
new ClockHours;
new ClockMinutes;
new ClockSeconds;
//==========================================================================


//==========================================================================
//	UI  																  //
//==========================================================================
new Text:BlackScreen[MAX_PLAYERS];
new Text:BlackOutText[MAX_PLAYERS];

new InformationBoxTimer[MAX_PLAYERS];
new Text:InfoBox[MAX_PLAYERS];

//new MySQL: g_SQL;

new Text:SpeedBox[MAX_PLAYERS];

new flying[MAX_PLAYERS];
forward IronMan(playerid);
forward DestroyMe(objectid);
forward Float:SetPlayerToFacePos(playerid, Float:X, Float:Y);

//==========================================================================


//==========================================================================
//	Optimisations														  //
//==========================================================================
new bool:PickedUpPickup[MAX_PLAYERS];
new LastPickup[MAX_PLAYERS];
new LastCommandTime[MAX_PLAYERS];
//==========================================================================

//==========================================================================
//	Dealership  														  //
//==========================================================================
//==========================================================================


//==========================================================================
//	AFK Check   														  //
//==========================================================================
new InactivtyCheck[MAX_PLAYERS];
new Float:InactivtyCheck_X[MAX_PLAYERS];
new Float:InactivtyCheck_Y[MAX_PLAYERS];
new Float:InactivtyCheck_Z[MAX_PLAYERS];
//==========================================================================

new Float:NoobSpawns[][4] =
{
	{-207.1014,1119.2313,20.4297,272.9626}
};

//==============================================================================
//          -- > Gamemode Includes
//==============================================================================	

#include "/modules/server/map.pwn"
#include "/modules/server/npc.pwn"
#include "/modules/server/connection.pwn"
#include "/modules/server/load_settings.pwn"
#include "/modules/server/features/login_music.pwn"

#include "modules/player/connect/cameras.pwn"
#include "modules/player/connect/banning.pwn"
#include "modules/player/animations.pwn"


#include "/modules/dynamic/cratedynamic.pwn"
#include "/modules/dynamic/fooddynamic.pwn"
#include "/modules/dynamic/cardynamic.pwn"
#include "/modules/dynamic/jobdynamic.pwn"
#include "/modules/dynamic/productdynamic.pwn"
#include "/modules/dynamic/housedynamic.pwn"
#include "/modules/dynamic/inventorydynamic.pwn"
#include "/modules/dynamic/bizdynamic.pwn"
#include "/modules/dynamic/pumpdynamic.pwn"
#include "/modules/dynamic/entrancedynamic.pwn"
#include "/modules/dynamic/factiondynamic.pwn"

#include "/modules/dynamic/plantdynamic.pwn"
#include "/modules/dynamic/plantplayerdynamic.pwn"


#include "modules/cmd/player/cmdplayer.pwn"
#include "modules/cmd/player/cmdpolice.pwn"
#include "modules/cmd/admin/cmdadmin.pwn"
#include "modules/cmd/admin/cmdserver.pwn"

#include "modules/job/trucker.pwn"
#include "modules/job/mechanic.pwn"
#include "modules/job/newspaper.pwn"

#include "/modules/player/textdrawplayer.pwn"

#include "/modules/player/gps.pwn"

#include "/modules/police/taser.pwn"
#include "/modules/police/repair.pwn"

#include "/modules/server/dialog.pwn"
#include "/modules/server/stock.pwn"

//#include "modules/player/object_dynamic.pwn"
//#include "/modules/server/bot.pwn"
//==============================================================================


//new LastQuestion;
//==========================================================================

new VehicleNames[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
    "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
    "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
    "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
    "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
    "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
    "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
    "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
    "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale",
    "Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
    "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
    "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper",
    "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
    "Blista Compact", "Police Maverick", "Boxville", "Benson", "Mesa", "RC Goblin",
    "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
    "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
    "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
    "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
    "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
    "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
    "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
    "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
    "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
    "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
    "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
    "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Cruiser",
    "SFPD Cruiser", "LVPD Cruiser", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
    "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
    "Tiller", "Utility Trailer"
};


//==============================================================================
main()
{
	print("------------------------------------------------------------------------------");
	print("|        The Land Cityy - Started!		|");
	print("------------------------------------------------------------------------------");
	print("\n----------------------------------");
	print(" Discord Console by Inferno");
	print("----------------------------------\n");
	//==========================================================================
    //      -- > Loads
    //==========================================================================
    mysql_set_charset("tis620");
}

forward LoadDataServer();
public LoadDataServer()
{
	mysql_tquery(dbCon, "SELECT * FROM `Settings` LIMIT 1", "LoadSettings");

	mysql_tquery(dbCon, "SELECT * FROM `Objects`", "LoadObjects");

	mysql_tquery(dbCon, "SELECT * FROM `factions`", "Faction_Load", "");

	mysql_tquery(dbCon, "SELECT * FROM `cars` WHERE truncated = 0", "Car_Load", "");

    mysql_tquery(dbCon, "SELECT * FROM `businesses`", "Business_Load", "");

    mysql_tquery(dbCon, "SELECT * FROM `entrances`", "Entrance_Load", "");

    mysql_tquery(dbCon, "SELECT * FROM `jobs`", "Job_Load", "");
    
    mysql_tquery(dbCon, "SELECT * FROM `products`", "Product_Load", "");

    mysql_tquery(dbCon, "SELECT * FROM `foods`", "Food_Load", "");

    mysql_tquery(dbCon, "SELECT * FROM `houses`", "House_Load", "");

	mysql_tquery(dbCon, "SELECT * FROM `fields`", "Field_Load", "");
    
	mysql_tquery(dbCon, "SELECT * FROM `plants`", "Plant_Load", "");
	
	mysql_tquery(dbCon, "SELECT * FROM `gps`", "GPS_Load", "");
	return 1;
}

public OnGameModeExit()
{
	foreach (new i : Player) {
		Character_Save(i);
	}

	mysql_close(dbCon);
	return 1;
}

public OnGameModeInit()
{
    new MySQLOpt: option_id = mysql_init_options();
    
	SetTimer("AutoSave", 1000, 1);

    MySQLConnect(MYSQL_HOST,MYSQL_USER,MYSQL_PASS,MYSQL_DB);
    SetGameModeText("NOT CONNECTED");
    ManualVehicleEngineAndLights();
    ShowPlayerMarkers(0);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	SetNameTagDrawDistance(30.0);
	ShowNameTags(true);

	//g_Discord_Chat = DCC_FindChannelById("714603061754069113"); // Discord channel ID
    dbCon = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB, option_id);
	if (dbCon == MYSQL_INVALID_HANDLE || mysql_errno(dbCon) != 0)
	{
		print("[MySQL]: Connection failed. Server is shutting down.");
		SendRconCommand("exit");
		return 1;
	}
	MapAndreas_Init(MAP_ANDREAS_MODE_FULL);
	
	mysql_set_charset("tis620");
	LoadDataServer();
	LoadObjectServer();

	ActorDonut = CreateActor(205, 377.5351, -65.8476, 1001.5078, 180.2888);
	ApplyActorAnimation(ActorDonut, "PED", "null", 4.0, 0, 0, 0, 1, 0);
	ApplyActorAnimation(ActorDonut, "DEALER", "Dealer_idle", 4.1, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(ActorDonut, 6004);
	SetPlayerInterior(ActorDonut, 10);
	
	Gardener = CreateActor(158, -1109.6960,-1669.1909,76.3672,345.6677);
	ApplyActorAnimation(Gardener, "PED", "null", 4.0, 0, 0, 0, 1, 0);

	CowMilking = CreateActor(159, -62.5617,30.9234,3.1094,162.7480);
	ApplyActorAnimation(CowMilking, "PED", "null", 4.0, 0, 0, 0, 1, 0);

    //==========================================================================
    //SetTimer("UpdateTime", 60000, 1);
    SetTimer("UpdateTime", 1000, 1);
    SetTimer("VehicleListener", 1000, true);
    SetTimer("RefuelCheck", 500, true);
    SetTimer("GeneralListener", 1000, true);
    SetTimer("CrashListener",300,true);
    SetTimer("Payday", 60000, true);
	SetTimer("SetWaterPlant", 300000, true);
    //SetTimer("OnPlayerNearBusiness", 3000, true);
    SetTimer("HourTime", 600 * 1000, true);
    
    SetTimer("HourTime2", 600000, true);

    
    gettime(ClockHours, ClockMinutes);
    printf("%d:%02d:%02d", ClockHours, ClockMinutes, ClockSeconds);
    SetWorldTime(ClockHours);
    //CreateClock();

    //SendRconCommand("loadfs Mapping");
  //  AddPlayerClass(1, -318.6522, 1049.3909, 20.3403, 358.4333, 0, 0, 0, 0, 0, 0);
    
    BankPayCheck = CreateDynamicPickup(1274, 23, 363.2884, 173.7371, 1008.3828, 7004, 3);
    //==========================================================================
    
    gServerTextdraws[4] = TextDrawCreate(1.000000,-1.000000,"_");
	TextDrawUseBox(gServerTextdraws[4],1);
	TextDrawBoxColor(gServerTextdraws[4],0xff000066);
	TextDrawTextSize(gServerTextdraws[4],641.000000,0.000000);
	TextDrawAlignment(gServerTextdraws[4],0);
	TextDrawBackgroundColor(gServerTextdraws[4],0x000000ff);
	TextDrawFont(gServerTextdraws[4],3);
	TextDrawLetterSize(gServerTextdraws[4],4.599999,50.399879);
	TextDrawColor(gServerTextdraws[4],0xff000066);
	TextDrawSetOutline(gServerTextdraws[4],1);
	TextDrawSetProportional(gServerTextdraws[4],1);
	TextDrawSetShadow(gServerTextdraws[4],1);
    
    textdrawVariables[0] = TextDrawCreate(149.000000, 420.000000, "Press ~r~~k~~SNEAK_ABOUT~~w~ to quit the spectator tool."); // Moved it down a little, it was actually fairly obtrusive.
	TextDrawBackgroundColor(textdrawVariables[0], 255);
	TextDrawFont(textdrawVariables[0], 2);
	TextDrawLetterSize(textdrawVariables[0], 0.390000, 1.200000);
	TextDrawColor(textdrawVariables[0], -1);
	TextDrawSetOutline(textdrawVariables[0], 0);
	TextDrawSetProportional(textdrawVariables[0], 1);
	TextDrawSetShadow(textdrawVariables[0], 1);
    
    RestartTextdraws[0] = TextDrawCreate(230.333206, 78.000167, "~r~Restart Server In:~y~ 00:00");
	TextDrawBackgroundColor(RestartTextdraws[0], 255);
	TextDrawFont(RestartTextdraws[0], 1);
	TextDrawLetterSize(RestartTextdraws[0], 0.400000, 1.600000);
	TextDrawColor(RestartTextdraws[0], -1);
	TextDrawSetOutline(RestartTextdraws[0], 1);
	TextDrawSetProportional(RestartTextdraws[0], 1);
	TextDrawSetSelectable(RestartTextdraws[0], 0);
    
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		InfoBox[i] = TextDrawCreate(323.000030, 363.377899, "Testing");
		TextDrawLetterSize(InfoBox[i], 0.309000, 1.417481);
		TextDrawTextSize(InfoBox[i], -114.333312, 300.325866);
		TextDrawAlignment(InfoBox[i], 2);
		TextDrawColor(InfoBox[i], -1);
		TextDrawUseBox(InfoBox[i], true);
		TextDrawBoxColor(InfoBox[i], 51);
		TextDrawSetShadow(InfoBox[i], 0);
		TextDrawSetOutline(InfoBox[i], -1);
		TextDrawBackgroundColor(InfoBox[i], 255);
		TextDrawFont(InfoBox[i], 1);
		TextDrawSetProportional(InfoBox[i], 1);

//,323.000030, 370,
		SpeedBox[i] = TextDrawCreate(550, 370, "MPH:");
		TextDrawLetterSize(SpeedBox[i], 0.309000, 1.417481);
		TextDrawTextSize(SpeedBox[i], -114.333312, 100);
		TextDrawAlignment(SpeedBox[i], 2);
		TextDrawColor(SpeedBox[i], -1);
		TextDrawUseBox(SpeedBox[i], false);
		TextDrawBoxColor(SpeedBox[i], 51);
		TextDrawSetShadow(SpeedBox[i], 0);
		TextDrawSetOutline(SpeedBox[i], -1);
		TextDrawBackgroundColor(SpeedBox[i], 255);
		TextDrawFont(SpeedBox[i], 2);
		TextDrawSetProportional(SpeedBox[i], 1);

		/*AnimText[i] = TextDrawCreate(610.0, 400.0,
		"~w~Press~w~ Right Click  ~w~to stop the animation");
		TextDrawUseBox(AnimText[i], 0);
		TextDrawFont(AnimText[i], 2);
		TextDrawSetShadow(AnimText[i],0); 
	    TextDrawSetOutline(AnimText[i],1);
	    TextDrawBackgroundColor(AnimText[i],0x000000FF);
	    TextDrawColor(AnimText[i],0xFFFFFFFF);
	    TextDrawAlignment(AnimText[i],3);*/


		BlackScreen[i] = TextDrawCreate(644.000000, 0.000000, "                                                                                                                                ");
		TextDrawBackgroundColor(BlackScreen[i], 255);
		TextDrawFont(BlackScreen[i], 1);
		TextDrawLetterSize(BlackScreen[i], 0.500000, 1.000000);
		TextDrawColor(BlackScreen[i], -1);
		TextDrawSetOutline(BlackScreen[i], 0);
		TextDrawSetProportional(BlackScreen[i], 1);
		TextDrawSetShadow(BlackScreen[i], 1);
		TextDrawUseBox(BlackScreen[i], 1);
		TextDrawBoxColor(BlackScreen[i], 255);
		TextDrawTextSize(BlackScreen[i], -11.000000, 0.000000);
		//192

		BlackOutText[i] = TextDrawCreate(10.000000, 192.000000, "You have been knocked unconscious!");
		TextDrawBackgroundColor(BlackOutText[i], -1);
		TextDrawFont(BlackOutText[i], 2);
		TextDrawLetterSize(BlackOutText[i], 0.760000, 2.000000);
		TextDrawColor(BlackOutText[i], -16776961);
		TextDrawSetOutline(BlackOutText[i], 0);
		TextDrawSetProportional(BlackOutText[i], 1);
		TextDrawSetShadow(BlackOutText[i], 0);

	}

    CreateDynamicPickup(1248, 23, -1952.8511,298.1530,35.4688);
	CreateDynamic3DTextLabel("SHOP:{FFFFFF} Vehicle Shop San Fierro", COLOR_GREEN, -1952.8511,298.1530,35.4688, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);


	//เรือสินค้า
	CreateDynamicObject(9585, 43.40180, 476.81149, 1.10640,   0.00000, 0.00000, -178.00000);
    CreateDynamicObject(9586, 45.59220, 476.87561, 11.37340,   0.00000, 0.00000, -178.00000);
    CreateDynamicObject(7621, 39.26190, 477.25491, 16.63870,   0.00000, 0.00000, -178.00000);
    CreateDynamicObject(7621, -10.49915, 475.62653, 16.63870,   0.00000, 0.00000, -178.00000);
    CreateDynamicObject(8077, 74.45608, 478.95288, 14.62000,   0.00000, 0.00000, 1.00000);
    CreateDynamicObject(10793, 118.47280, 479.40671, 29.13340,   0.00000, 0.00000, -178.00000);
	CreateDynamicObject(2939, 26.59140, 516.12903, 1.43270,   0.00000, 0.00000, 181.00000);
    CreateDynamicObject(2939, 26.67030, 510.50061, 3.87270,   -0.12000, 0.00000, 181.00000);
    CreateDynamicObject(2939, 26.76130, 504.97540, 6.25270,   -0.12000, 0.00000, 181.00000);
    CreateDynamicObject(2939, 26.86570, 499.36511, 8.67270,   -0.12000, 0.00000, 181.00000);

	//PoliceStation
	CreateDynamicObject(19447, -222.58168, 970.95068, 20.21640,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19447, -229.23126, 970.94073, 20.21640,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19447, -233.98798, 985.19720, 20.39640,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(19447, -234.00270, 975.68732, 20.21640,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(19447, -234.00470, 1003.86627, 20.39640,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(19447, -234.01132, 994.82825, 20.39640,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(19447, -229.25409, 1008.51569, 20.39640,   0.00000, 0.00000, -91.00000);
	CreateDynamicObject(19447, -219.66933, 1008.42761, 20.39640,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19447, -210.03830, 1008.43359, 20.39640,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19447, -213.41844, 970.95044, 20.21640,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19447, -213.41953, 970.97034, 19.67640,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19447, -229.23129, 970.94067, 20.01640,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19447, -222.58170, 970.95068, 20.01640,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19447, -208.19746, 970.94708, 20.21640,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19447, -208.19749, 970.94708, 19.21640,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19313, -205.22173, 1001.38690, 18.72630,   0.00000, 0.00000, -89.00000);
	CreateDynamicObject(19313, -204.58467, 987.43408, 18.72630,   0.00000, 0.00000, -86.00000);

	//Hospital
	CreateObject(19449,-207.3999939,-1739.6999512,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(17038,-205.8994141,-1747.6992188,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-204.3994141,-1747.6992188,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-202.8999939,-1747.6999512,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-201.3994141,-1747.6992188,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(19460,-207.3990021,-1739.6999512,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19449,-202.6000061,-1734.8000488,676.5000000,0.0000000,0.0000000,90.0000000);
    CreateObject(19460,-206.1999969,-1734.8010254,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(1569,-206.0000000,-1734.9000244,674.7999878,0.0000000,0.0000000,0.0000000);
    CreateObject(1569,-203.0000000,-1734.9000244,674.7999878,0.0000000,0.0000000,180.0000000);
    CreateObject(19387,-196.6992188,-1744.5000000,676.5000000,0.0000000,0.0000000,90.0000000);
    CreateObject(19357,-201.3994141,-1736.5000000,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(19368,-201.4003906,-1736.5000000,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(2885,-211.7998047,-1734.7998047,678.4000244,270.0000000,180.0000000,180.0000000);
    CreateObject(17038,-199.8994141,-1747.6992188,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-198.3999939,-1747.6999512,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-196.8994141,-1747.6992188,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(19449,-196.6000061,-1738.0159912,676.5000000,0.0000000,0.0000000,90.0000000);
    CreateObject(19460,-196.6719971,-1738.0169678,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19449,-195.3994141,-1742.8994141,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(17038,-195.3994141,-1747.6992188,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(19460,-195.4010010,-1742.9000244,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19449,-201.1000061,-1739.6999512,674.0999756,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-201.1005859,-1739.6992188,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19357,-199.8837891,-1744.5000000,676.5000000,0.0000000,0.0000000,90.0000000);
    CreateObject(19460,-191.1503906,-1744.4990234,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19460,-191.1503906,-1744.5009766,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-199.0749969,-1744.4990234,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-199.0749969,-1744.5009766,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-199.8849945,-1744.4980469,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19460,-201.0989990,-1739.5999756,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19357,-201.3994141,-1746.0996094,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(19387,-201.3994141,-1749.2998047,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(19357,-201.3999939,-1752.5000000,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(19387,-201.3999939,-1755.6999512,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(19357,-201.3999939,-1758.9000244,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(17038,-205.8994141,-1768.3994141,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-204.3999939,-1768.4000244,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-202.8999939,-1768.4000244,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-201.3999939,-1768.4000244,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-199.8994141,-1768.3994141,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-198.3994141,-1768.3994141,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-196.8999939,-1768.4000244,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-195.3994141,-1768.3994141,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(19368,-201.4019928,-1746.0999756,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19368,-201.4010010,-1746.9250488,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19387,-201.3994141,-1762.0996094,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(19449,-206.1999969,-1763.6999512,676.5000000,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-201.4010010,-1751.6369629,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19368,-201.4019928,-1753.3249512,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19368,-201.4010010,-1758.0369873,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19368,-201.4019928,-1759.7249756,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19368,-201.4010010,-1764.4370117,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-206.3000031,-1763.6989746,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19387,-207.3994141,-1746.0996094,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(19387,-207.3994141,-1758.8994141,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(19357,-207.3999939,-1762.0999756,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(19449,-195.3994141,-1752.5000000,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(19449,-195.3994141,-1762.0996094,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(19449,-196.5996094,-1758.7998047,676.5000000,0.0000000,0.0000000,90.0000000);
    CreateObject(19460,-206.0000000,-1733.2998047,672.5999756,270.0000000,179.9945068,0.0000000);
    CreateObject(19460,-203.0000000,-1733.3000488,672.5999756,270.0000000,179.9945068,0.0000000);
    CreateObject(19441,-203.7140045,-1733.3010254,677.3980244,0.0000000,270.0000000,90.0000000);
    CreateObject(19441,-205.2870026,-1733.3010254,677.3970244,0.0000000,270.0000000,90.0000000);
    CreateObject(2885,-200.8994141,-1734.7998047,678.4000244,270.0000000,0.0000000,0.0000000);
    CreateObject(2885,-200.8994141,-1741.5000000,678.4000244,270.0000000,0.0000000,0.0000000);
    CreateObject(2885,-211.7998047,-1741.5000000,678.4000244,270.0000000,179.9945068,179.9945068);
    CreateObject(2885,-211.7998047,-1748.1992188,678.4000244,270.0000000,0.0000000,0.0000000);
    CreateObject(2885,-200.8999939,-1748.1999512,678.4000244,270.0000000,0.0000000,0.0000000);
    CreateObject(2885,-200.8994141,-1754.8994141,678.4000244,270.0000000,0.0000000,0.0000000);
    CreateObject(2885,-200.8994141,-1761.5996094,678.4000244,270.0000000,0.0000000,0.0000000);
    CreateObject(2885,-211.7998047,-1761.5996094,678.4000244,270.0000000,0.0000000,0.0000000);
    CreateObject(17038,-207.3994141,-1747.6992188,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-208.8994141,-1747.6992188,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-210.3999939,-1747.6999512,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-211.8999939,-1747.6999512,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-213.3994141,-1747.6992188,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-213.3994141,-1768.3994141,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-211.8999939,-1768.4000244,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-210.3994141,-1768.3994141,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-208.8994141,-1768.3994141,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(17038,-207.3999939,-1768.4000244,668.2999878,0.0000000,270.0000000,0.0000000);
    CreateObject(19449,-214.6000061,-1758.9000244,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(19449,-214.5996094,-1749.2998047,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(19449,-214.6000061,-1739.6999512,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(19449,-212.1992188,-1734.7998047,676.5000000,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-199.8000031,-1744.5010986,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-201.3979950,-1746.0999756,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19368,-201.3990021,-1746.9250488,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19368,-201.3990021,-1751.6369629,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19368,-201.3970032,-1753.3242188,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19368,-201.3990021,-1758.0369873,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19368,-201.3979950,-1759.7249756,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-195.4010010,-1752.5000000,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-195.4003906,-1762.0996094,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-196.6494141,-1758.7988281,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19460,-196.6494141,-1758.8007812,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19460,-207.3979950,-1740.5140381,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19368,-207.3990021,-1761.2370605,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19368,-207.3979950,-1764.4000244,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-214.5989990,-1758.8000488,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-214.5980072,-1749.1999512,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-214.5989990,-1739.5999756,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-215.8000031,-1734.8011475,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19460,-207.4010010,-1739.6999512,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-207.4013672,-1740.5136719,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19368,-207.4011993,-1761.2370605,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19368,-207.4010010,-1764.3994141,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(3034,-204.3994141,-1763.5996094,676.7000122,0.0000000,0.0000000,179.9945068);
    CreateObject(1523,-201.3699951,-1756.4499512,674.7399902,0.0000000,0.0000000,90.0000000);
    CreateObject(1523,-201.3691406,-1750.0498047,674.7399902,0.0000000,0.0000000,90.0000000);
    CreateObject(1523,-201.3699951,-1762.8499756,674.7399902,0.0000000,0.0000000,90.0000000);
    CreateObject(2686,-201.5130005,-1744.9000244,676.4000244,0.0000000,0.0000000,270.0000000);
    CreateObject(2685,-201.5130005,-1745.4000244,676.4000244,0.0000000,0.0000000,270.0000000);
    CreateObject(2688,-207.2998047,-1747.5996094,676.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(16101,-201.5000000,-1748.5000000,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-201.5000000,-1750.0000000,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-201.5000000,-1754.9000244,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-201.5000000,-1756.4000244,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-201.5000000,-1761.3000488,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-201.5000000,-1762.8000488,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-201.3291016,-1748.5000000,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-201.3300018,-1750.0000000,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-201.3300018,-1754.9000244,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-201.3300018,-1756.4000244,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-201.3300018,-1761.3000488,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-201.3300018,-1762.8000488,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(14487,-211.8000031,-1751.5000000,678.0999756,0.0000000,0.0000000,0.0000000);
    CreateObject(14487,-211.7998047,-1729.5996094,678.0999756,0.0000000,0.0000000,0.0000000);
    CreateObject(14487,-218.5996094,-1729.5996094,678.0999756,0.0000000,0.0000000,0.0000000);
    CreateObject(14487,-218.6000061,-1754.3000488,678.0999756,0.0000000,0.0000000,0.0000000);
    CreateObject(14487,-190.8994141,-1753.5996094,678.0999756,0.0000000,0.0000000,0.0000000);
    CreateObject(14487,-190.8999939,-1735.1999512,678.0999756,0.0000000,0.0000000,0.0000000);
    CreateObject(14487,-190.8994141,-1731.6992188,678.0999756,0.0000000,0.0000000,0.0000000);
    CreateObject(1523,-207.3691406,-1746.8496094,674.7399902,0.0000000,0.0000000,90.0000000);
    CreateObject(1523,-207.3699951,-1759.6500244,674.7399902,0.0000000,0.0000000,90.0000000);
    CreateObject(16101,-207.3291016,-1745.2998047,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-207.3300018,-1746.8199463,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-207.3300018,-1758.0999756,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-207.3300018,-1759.6199951,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-207.5000000,-1759.5999756,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-207.5000000,-1758.0999756,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-207.5000000,-1746.8000488,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-207.5000000,-1745.2998047,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(1999,-200.5000000,-1740.3994141,674.7999878,0.0000000,0.0000000,90.0000000);
    CreateObject(2009,-199.5000000,-1743.7998047,674.7999878,0.0000000,0.0000000,90.0000000);
    CreateObject(1671,-199.5000000,-1739.3000488,675.2000122,0.0000000,0.0000000,270.0000000);
    CreateObject(1671,-199.2998047,-1743.0000000,675.2000122,0.0000000,0.0000000,270.0000000);
    CreateObject(19387,-213.0000000,-1742.6992188,676.5000000,0.0000000,0.0000000,90.0000000);
    CreateObject(19357,-209.7998047,-1742.6992188,673.9010010,0.0000000,0.0000000,90.0000000);
    CreateObject(19357,-209.0000000,-1742.7001953,673.9000244,0.0000000,0.0000000,90.0000000);
    CreateObject(19449,-212.1999969,-1742.6989746,679.0000000,0.0000000,0.0000000,90.0000000);
    CreateObject(19466,-208.5000000,-1742.6999512,676.4000244,0.0000000,0.0000000,90.0000000);
    CreateObject(19466,-210.7402344,-1742.6992188,676.4000244,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-209.0000000,-1742.6989746,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-210.6640015,-1742.6979980,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-215.3739929,-1742.6989746,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-215.3750000,-1742.7001953,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-209.0000000,-1742.7011719,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-210.6640015,-1742.7021484,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(1523,-213.7890625,-1742.7294922,674.7399902,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-212.2998047,-1742.7998047,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-213.8000031,-1742.8000488,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-213.8000031,-1742.5999756,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-212.3000031,-1742.5999756,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-207.5000000,-1742.6992188,666.9000244,0.0000000,0.0000000,0.0000000);
    CreateObject(3657,-213.8999939,-1745.6999512,675.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(3394,-213.7998047,-1739.0000000,674.7999878,0.0000000,0.0000000,179.9945068);
    CreateObject(3396,-208.1992188,-1737.0000000,674.7999878,0.0000000,0.0000000,0.0000000);
    CreateObject(3397,-208.1992188,-1740.8994141,674.7999878,0.0000000,0.0000000,0.0000000);
    CreateObject(14487,-218.6000061,-1731.8000488,678.0999756,0.0000000,0.0000000,0.0000000);
    CreateObject(2007,-213.6992188,-1735.3994141,674.7999878,0.0000000,0.0000000,0.0000000);
    CreateObject(2007,-212.6992188,-1735.3994141,674.7999878,0.0000000,0.0000000,0.0000000);
    CreateObject(2132,-211.0996094,-1735.3994141,674.7999878,0.0000000,0.0000000,0.0000000);
    CreateObject(14532,-211.3994141,-1737.0996094,675.7800293,0.0000000,0.0000000,194.7491455);
    CreateObject(2146,-211.0996094,-1738.7998047,675.2700195,0.0000000,0.0000000,0.0000000);
    CreateObject(3657,-206.8999939,-1754.5999756,675.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(2811,-201.8994141,-1735.3994141,674.7999878,0.0000000,0.0000000,139.9932861);
    CreateObject(2811,-201.8999939,-1763.1999512,674.7999878,0.0000000,0.0000000,219.9957275);
    CreateObject(2811,-206.8999939,-1763.1999512,674.7999878,0.0000000,0.0000000,149.9957275);
    CreateObject(3657,-206.8999939,-1739.5999756,675.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(2811,-206.8994141,-1735.3994141,674.7999878,0.0000000,0.0000000,221.9897461);
    CreateObject(2688,-201.5000000,-1760.5000000,676.4000244,0.0000000,0.0000000,270.0000000);
    CreateObject(19460,-201.5000000,-1739.6999512,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19460,-207.3000031,-1739.6999512,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19460,-207.3000031,-1749.3000488,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19460,-207.3000031,-1758.9000244,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19460,-201.5000000,-1749.3000488,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19460,-201.5000000,-1758.9000244,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19460,-204.8000031,-1734.9000244,679.9000244,0.0000000,179.9945068,90.0000000);
    CreateObject(19460,-206.3999939,-1763.5999756,679.9000244,0.0000000,179.9945068,90.0000000);
    CreateObject(19460,-214.5000000,-1758.9000244,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19460,-214.5000000,-1749.3000488,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19460,-214.5000000,-1739.6999512,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19460,-207.5000000,-1758.9000244,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19460,-207.5000000,-1749.3000488,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19460,-207.5000000,-1739.6999512,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19460,-214.3999939,-1734.9000244,679.9000244,0.0000000,179.9945068,90.0000000);
    CreateObject(19460,-212.1999969,-1742.8000488,679.9000244,0.0000000,179.9945068,90.0000000);
    CreateObject(19460,-212.1999969,-1742.5999756,679.9000244,0.0000000,179.9945068,90.0000000);
    CreateObject(19460,-196.6000061,-1744.4000244,679.9000244,0.0000000,179.9945068,90.0000000);
    CreateObject(19460,-196.6000061,-1738.0999756,679.9000244,0.0000000,179.9945068,90.0000000);
    CreateObject(19460,-196.6000061,-1744.5999756,679.9000244,0.0000000,179.9945068,90.0000000);
    CreateObject(19460,-196.6000061,-1758.6999512,679.9000244,0.0000000,179.9945068,90.0000000);
    CreateObject(19460,-196.6000061,-1758.9000244,679.9000244,0.0000000,179.9945068,90.0000000);
    CreateObject(19460,-195.5000000,-1758.9000244,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19460,-195.5000000,-1749.3000488,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19460,-195.5000000,-1739.6999512,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19357,-209.0000000,-1748.8010254,673.9010010,0.0000000,0.0000000,90.0000000);
    CreateObject(19449,-207.3999939,-1752.5000000,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-207.4010010,-1751.5999756,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-207.3990021,-1751.5999756,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-207.4019928,-1753.3000488,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-207.3979950,-1753.3000488,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(3657,-206.8999939,-1750.4000244,675.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19387,-213.0000000,-1748.8000488,676.5000000,0.0000000,0.0000000,90.0000000);
    CreateObject(19449,-212.1999969,-1748.8010254,679.0000000,0.0000000,0.0000000,90.0000000);
    CreateObject(19357,-209.8000031,-1748.8000488,673.9000244,0.0000000,0.0000000,90.0000000);
    CreateObject(19466,-208.6000061,-1748.8000488,676.4000244,0.0000000,0.0000000,90.0000000);
    CreateObject(19466,-210.8404999,-1748.8000488,676.4000244,0.0000000,0.0000000,90.0000000);
    CreateObject(19449,-212.1999969,-1756.1999512,676.5000000,0.0000000,0.0000000,90.0000000);
    CreateObject(1523,-213.7890015,-1748.8299561,674.7399902,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-212.1999969,-1748.6999512,679.9000244,0.0000000,179.9945068,90.0000000);
    CreateObject(19460,-212.1999969,-1748.9000244,679.9000244,0.0000000,179.9945068,90.0000000);
    CreateObject(19460,-212.1999969,-1756.0999756,679.9000244,0.0000000,179.9945068,90.0000000);
    CreateObject(19460,-212.3000031,-1756.1989746,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-209.0000000,-1748.7990000,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-210.6629944,-1748.7980000,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-210.6621094,-1748.8027344,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-209.0000000,-1748.8017578,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-215.3750000,-1748.7989502,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19368,-215.3750000,-1748.8007812,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(3397,-208.1999969,-1750.8000488,674.7999878,0.0000000,0.0000000,0.0000000);
    CreateObject(3396,-208.1999969,-1754.4000244,674.7999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-212.1999969,-1756.3000488,679.9000244,0.0000000,179.9945068,90.0000000);
    CreateObject(2132,-209.8999939,-1755.5999756,674.7999878,0.0000000,0.0000000,180.0000000);
    CreateObject(2007,-212.3000031,-1755.5999756,674.7999878,0.0000000,0.0000000,180.0000000);
    CreateObject(2007,-213.3000031,-1755.5999756,674.7999878,0.0000000,0.0000000,179.9945068);
    CreateObject(3394,-213.8000031,-1752.1999512,674.7999878,0.0000000,0.0000000,179.9945068);
    CreateObject(2146,-211.1000061,-1751.9000244,675.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(14532,-210.6999969,-1753.5000000,675.7999878,0.0000000,0.0000000,14.0000000);
    CreateObject(19460,-212.2998047,-1756.2001953,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(3657,-201.8994141,-1746.5000000,675.2999878,0.0000000,0.0000000,270.0000000);
    CreateObject(2811,-214.0000000,-1743.4000244,674.7999878,0.0000000,0.0000000,251.9897461);
    CreateObject(2811,-214.0000000,-1748.0999756,674.7999878,0.0000000,0.0000000,295.9879761);
    CreateObject(16101,-207.5000000,-1748.8000488,666.9000244,0.0000000,0.0000000,0.0000000);
    CreateObject(3394,-213.8000031,-1761.5000000,674.7999878,0.0000000,0.0000000,179.9945068);
    CreateObject(2007,-214.0000000,-1758.5999756,674.7999878,0.0000000,0.0000000,90.0000000);
    CreateObject(2007,-214.0000000,-1757.5999756,674.7999878,0.0000000,0.0000000,90.0000000);
    CreateObject(2132,-210.1000061,-1763.0999756,674.7999878,0.0000000,0.0000000,179.9945068);
    CreateObject(3396,-208.1999969,-1761.6999512,674.7999878,0.0000000,0.0000000,0.0000000);
    CreateObject(3397,-210.8000031,-1756.6999512,674.7999878,0.0000000,0.0000000,90.0000000);
    CreateObject(2146,-211.1999969,-1759.9000244,675.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(11237,-230.0000000,-1760.4000244,698.9000244,0.0000000,180.0000000,180.0000000);
    CreateObject(3053,-211.1999969,-1760.4000244,678.4000244,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-211.1999969,-1760.4000244,688.0999756,0.0000000,180.0000000,0.0000000);
    CreateObject(2596,-214.3000031,-1760.0999756,676.7000122,0.0000000,0.0000000,90.0000000);
    CreateObject(2885,-211.8000031,-1754.9000244,678.4000244,270.0000000,0.0000000,0.0000000);
    CreateObject(2596,-214.3000031,-1760.8000488,676.7000122,0.0000000,0.0000000,90.0000000);
    CreateObject(2596,-214.3000031,-1760.8000488,677.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(2596,-214.3000031,-1760.0999756,677.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(16101,-222.6000061,-1760.4000244,677.9000244,0.0000000,90.0000000,0.0000000);
    CreateObject(16101,-214.5000000,-1760.4000244,666.19387220,0.0000000,0.0000000,0.0000000);
    CreateObject(3808,-207.2500000,-1757.8000488,676.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(3808,-212.0000000,-1742.8499756,676.2999878,0.0000000,0.0000000,270.0000000);
    CreateObject(3808,-212.0000000,-1748.6600342,676.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19460,-201.3000031,-1749.5000000,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19460,-201.3000031,-1759.0999756,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(2009,-199.5000000,-1747.8000488,674.7999878,0.0000000,0.0000000,90.0000000);
    CreateObject(1999,-200.5000000,-1746.0999756,674.8010254,0.0000000,0.0000000,90.0000000);
    CreateObject(1671,-199.3999939,-1746.9000244,675.2000122,0.0000000,0.0000000,264.0000000);
    CreateObject(1671,-199.3999939,-1745.0999756,675.2000122,0.0000000,0.0000000,278.0000000);
    CreateObject(2009,-196.8000031,-1753.8000488,674.8010254,0.0000000,0.0000000,90.0000000);
    CreateObject(1999,-197.8000031,-1752.0999756,674.7999878,0.0000000,0.0000000,90.0000000);
    CreateObject(1999,-198.6999969,-1752.8000488,674.7999878,0.0000000,0.0000000,270.0000000);
    CreateObject(2009,-199.6999969,-1751.0999756,674.8010254,0.0000000,0.0000000,270.0000000);
    CreateObject(1671,-197.6000061,-1753.0000000,675.2000122,0.0000000,0.0000000,282.0000000);
    CreateObject(1671,-196.8000031,-1751.3000488,675.2000122,0.0000000,0.0000000,260.0000000);
    CreateObject(1671,-199.8000031,-1752.0999756,675.2000122,0.0000000,0.0000000,84.0000000);
    CreateObject(1671,-199.8000031,-1753.8000488,675.2000122,0.0000000,0.0000000,104.0000000);
    CreateObject(2009,-196.0000000,-1757.1999512,674.7999878,0.0000000,0.0000000,180.0000000);
    CreateObject(1999,-197.6999969,-1758.1999512,674.8010254,0.0000000,0.0000000,180.0000000);
    CreateObject(1671,-196.8999939,-1757.3000488,675.2000122,0.0000000,0.0000000,0.0000000);
    CreateObject(1671,-198.6999969,-1758.0000000,675.2000122,0.0000000,0.0000000,0.0000000);
    CreateObject(2202,-196.0000000,-1746.1999512,674.7800293,0.0000000,0.0000000,270.0000000);
    CreateObject(2811,-195.8999939,-1745.0999756,674.7999878,0.0000000,0.0000000,115.9932861);
    CreateObject(2007,-196.0000000,-1748.3000488,674.7999878,0.0000000,0.0000000,270.0000000);
    CreateObject(2007,-196.0000000,-1749.3000488,674.7999878,0.0000000,0.0000000,270.0000000);
    CreateObject(2811,-200.8999939,-1758.3000488,674.7999878,0.0000000,0.0000000,141.9881592);
    CreateObject(2611,-198.1999969,-1758.6700439,676.7999878,0.0000000,0.0000000,180.0000000);
    CreateObject(2611,-201.2700043,-1746.4000244,676.5999756,0.0000000,0.0000000,89.9945068);
    CreateObject(19449,-215.8000031,-1763.6999512,676.5000000,0.0000000,0.0000000,90.0000000);
    CreateObject(19449,-201.3999939,-1768.5000000,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(19449,-195.3999939,-1771.6999512,676.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(2885,-200.8999939,-1768.3000488,678.4000244,270.0000000,0.0000000,0.0000000);
    CreateObject(19460,-201.3990021,-1767.5799561,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-195.4010010,-1771.6999512,673.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(19460,-195.5000000,-1768.5000000,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19460,-201.3000031,-1768.6999512,679.9000244,0.0000000,179.9945068,0.0000000);
    CreateObject(19449,-196.6000061,-1772.4000244,676.5000000,0.0000000,0.0000000,90.0000000);
    CreateObject(19460,-196.6000061,-1772.3990479,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(19460,-196.6000061,-1772.3000488,679.9000244,0.0000000,179.9945068,90.0000000);
    CreateObject(14487,-190.8999939,-1778.1999512,678.0999756,0.0000000,0.0000000,0.0000000);
    CreateObject(1789,-211.8000031,-1753.0999756,675.2999878,0.0000000,0.0000000,290.0000000);
    CreateObject(1789,-211.8994141,-1759.1992188,675.2999878,0.0000000,0.0000000,270.0000000);
    CreateObject(1789,-210.1999969,-1737.6999512,675.2999878,0.0000000,0.0000000,99.9951172);
    CreateObject(1800,-199.0000000,-1759.5000000,674.7000122,0.0000000,0.0000000,270.0000000);
    CreateObject(1800,-199.0000000,-1771.5000000,674.7000122,0.0000000,0.0000000,270.0000000);
    CreateObject(1800,-199.0000000,-1767.5999756,674.7000122,0.0000000,0.0000000,270.0000000);
    CreateObject(1800,-199.0000000,-1763.6999512,674.7000122,0.0000000,0.0000000,270.0000000);
    CreateObject(1800,-200.6999969,-1766.9000244,674.7000122,0.0000000,0.0000000,0.0000000);
    CreateObject(1800,-200.6999969,-1773.3000488,674.7000122,0.0000000,0.0000000,0.0000000);
    CreateObject(1789,-196.1999969,-1770.6999512,675.2999878,0.0000000,0.0000000,180.0000000);
    CreateObject(1789,-196.1999969,-1766.6999512,675.2999878,0.0000000,0.0000000,179.9945068);
    CreateObject(1789,-196.1999969,-1762.9000244,675.2999878,0.0000000,0.0000000,179.9945068);
    CreateObject(1789,-196.3000031,-1760.6999512,675.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(1789,-200.5000000,-1766.1999512,675.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(1789,-200.5000000,-1769.4000244,675.2999878,0.0000000,0.0000000,180.0000000);
    CreateObject(19460,-216.0000000,-1763.5999756,679.9000244,0.0000000,179.9945068,90.0000000);
    CreateObject(1999,-197.5000000,-1740.4000244,674.7999878,0.0000000,0.0000000,90.0000000);
    CreateObject(1671,-196.5000000,-1739.3000488,675.2000122,0.0000000,0.0000000,270.0000000);
    CreateObject(19460,-215.8999939,-1763.6989746,673.2999878,0.0000000,0.0000000,90.0000000);
    CreateObject(16101,-212.3000031,-1748.6999512,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-213.8000031,-1748.6999512,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-213.8000031,-1748.9000244,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(16101,-212.3000031,-1748.9000244,666.2999878,0.0000000,0.0000000,0.0000000);
    CreateObject(2852,-206.8000031,-1742.8000488,675.2800293,0.0000000,0.0000000,0.0000000);
    CreateObject(2315,-206.8000031,-1742.4000244,674.7999878,0.0000000,0.0000000,270.0000000);
    CreateObject(2855,-206.6999969,-1743.6999512,675.2999878,0.0000000,0.0000000,0.0000000);



    pole1 = CreateObject(11435,-204.3999939,-1745.0999756,679.4000244,0.0000000,0.0000000,270.0000000);
    pole2 = CreateObject(11435,-204.3999939,-1752.0000000,679.4000244,0.0000000,0.0000000,270.0000000);
    pole3 = CreateObject(11435,-204.3999939,-1758.8000488,679.4000244,0.0000000,0.0000000,270.0000000);
    pole4 = CreateObject(11435,-198.6000061,-1764.0000000,679.4000244,0.0000000,0.0000000,270.0000000);
    pole5 = CreateObject(11435,-198.6000061,-1769.1999512,679.4000244,0.0000000,0.0000000,270.0000000);
    pole6 = CreateObject(11435,-198.6000061,-1756.3000488,679.4000244,0.0000000,0.0000000,270.0000000);
    pole7 = CreateObject(11435,-198.6000061,-1749.9000244,679.4000244,0.0000000,0.0000000,270.0000000);
//      Objects converted: 336

    SetObjectMaterial(pole1, 1, 14532, "drivingbit", "blak_1");
    SetObjectMaterial(pole2, 1, 14532, "drivingbit", "blak_1");
    SetObjectMaterial(pole3, 1, 14532, "drivingbit", "blak_1");
    SetObjectMaterial(pole4, 1, 14532, "drivingbit", "blak_1");
    SetObjectMaterial(pole5, 1, 14532, "drivingbit", "blak_1");
    SetObjectMaterial(pole6, 1, 14532, "drivingbit", "blak_1");
    SetObjectMaterial(pole7, 1, 14532, "drivingbit", "blak_1");
	return 1;
}

forward SetWaterPlant();
public SetWaterPlant(){
	
	for(new i=0;i<MAX_PLANTS;i++){
		if (PlantData[i][plantExists])
		{
			if(PlantData[i][plantWater] < 50){
				if(PlantData[i][plantType] == 1){ //ฟักทอง
					PlantData[i][plantWater] -= 5;
				}
				if(PlantData[i][plantType] == 2){ //ส้ม
					PlantData[i][plantWater] -= 10;
				}
			}
			else{
				if(PlantData[i][plantType] == 1){ //ฟักทอง
					PlantData[i][plantWater] -= 5;
					PlantData[i][plantValue]++;
				}
				if(PlantData[i][plantType] == 2){ //ส้ม
					PlantData[i][plantWater] -= 10;
					PlantData[i][plantValue]++;
				}
			}

			if(PlantData[i][plantValue] >= 100){
				PlantData[i][plantValue] = 100;
				PlantData[i][plantWater] = 100;
			}
		}
		Plant_Refresh(i);
		Plant_Save(i);
	}
	return 1;
}

public OnLookupComplete(playerid)
{
	if(IsProxyUser(playerid))
	{
		new str[128];
		format(str, sizeof(str), "%s's connection has been rejected. (VPN/Proxy)", GetName(playerid));
		KickPlayer(playerid);
		SendAdminsMessage(1, COLOR_INDIANRED, str);
	}
}


public OnPlayerConnect(playerid)
{
    new str[196];
    Account_Reset(playerid);
    Character_Reset(playerid);
	NameCheck(playerid);

	flying[playerid] = 0;


	//taser police
	TaserShoot[playerid] = 0;
	TaserTimeAG[playerid] = 0;
	TaserTime[playerid] = 0;
	IsPlayerTaser[playerid] = 0;
	taser[playerid] = false;
	GiveTaserAgainTimer[playerid] = 0;
	GiveTaserAgainTimerEx[playerid] = 0;
	lastWeapon[playerid] = 0;
	PoliceLastWeapon[playerid] = 0;
	PoliceLastAmmo[playerid] = 0;

	UseUserControl[playerid] = 0;

	LoadHudShowPlayerTextDraw(playerid);

    RemoveBuildingForPlayer(playerid, 1302, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 1209, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 955, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 956, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 1775, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 1776, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 1977, 0.0, 0.0, 0.0, 6000.0);

	//ลบสวนแอปเปิ้ล
    RemoveBuildingForPlayer(playerid, 703, -1087.3125, -1674.9219, 75.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 691, -1068.5859, -1662.5781, 75.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 3374, -1088.3906, -1663.7344, 76.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 3374, -1094.5469, -1663.5234, 76.8359, 0.25);

    GetPlayerIp(playerid, Account[playerid][LatestIP], 16);

    format(str, 128, "%s ได้เข้าสู่เซิฟเวอร์", GetName(playerid));
    SendAdminsMessage(1, COLOR_GRAY, str);

	TogglePlayerSpectating(playerid, 1);
	SetPlayerColor(playerid, COLOR_WHITE);
	
	LoadPlayerTextdraw(playerid);

	CheckBanned[playerid] = 0;


	SetTimerEx("PlayerConnected", 100, false, "d", playerid);
}


new LoginAttempts[MAX_PLAYERS] = 0;



forward PlayerConnected(playerid);
public PlayerConnected(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new str[128], query[400];
		format(str, sizeof(str), "%s [%s]", Server[Name], Server[Version]);
		SendClientMessage(playerid, COLOR_ORANGE, str);
		format(str, 128, "ยินดีต้อนรับเข้าสู่เซิฟเวอร์, %s.", GetName(playerid));
	    SendClientMessage(playerid, COLOR_WHITE, str);
		
		Login_Camera(playerid);

	    //InfoBoxForPlayer(playerid, "== ~y~[World of Roleplay]~w~ ==~n~Welcome to World of Roleplay!");

	    LoggedIn[playerid] = false;
	    LoginAttempts[playerid] = 0;

		mysql_format(dbCon, query, sizeof(query), "SELECT NULL FROM `Accounts` WHERE Username = '%s' LIMIT 1", GetName(playerid));
		mysql_tquery(dbCon, query, "Handle_Account", "i", playerid);
	}

	return 1;
}


Login_Dialog(playerid)
{
    new str[128];
	new head[128];
	format(head, sizeof(head), "%s | เข้าสู่ระบบ", Server[Name]);
    format(str, sizeof(str), "{FFFFFF}Hello, %s!\n\nยินดีต้อนรับ %s.\nกรุณาเข้าสู่ระบบด้วยรหัสผ่านที่มีอยู่ของคุณด้านล่าง.", GetName(playerid), Server[Name]);
    Dialog_Show(playerid, LOGIN, DIALOG_STYLE_PASSWORD, head, str, "เข้าสู่ระบบ", "ยกเลิก" , Server[Name]);
    return 1;
}

Register_Dialog(playerid)
{
    new str[256];
	new head[256];
	format(head, sizeof(head), "%s | สมัครสมาชิก", Server[Name]);
    format(str, sizeof(str), "{FFFFFF}Hello, %s!\n\nยินดีต้อนรับ %s.\nคุณยังไม่มีบัญชีผู้ใช้งาน!\n\nกรอกรหัสข้างล่างเพื่อทำการลงทะเบียน:", GetName(playerid), Server[Name]);
    Dialog_Show(playerid, REGISTER, DIALOG_STYLE_PASSWORD, head, str,"สมัครสมาชิก","ยกเลิก" , Server[Name]);
    return 1;
}

forward CrashListener();
public CrashListener()
{
    foreach (new i : Player)
	{

		if(IsPlayerConnected(i) && !IsPlayerNPC(i)) PlayerUpdateListener(i);
		if(IsPlayerConnectedEx(i))
		{

		    if(IsPlayerInAnyVehicle(i))
		    {

		        new
					veh,
					Float:hp,
					id = -1;

                veh = GetPlayerVehicleID(i);
	         	GetVehicleHealth(veh,hp);

				if(hp < crash_vhp[veh] && !CoreVehicles[veh][vehRespawn])
				{
				    new Float:difference;
		    		difference = (crash_vhp[veh] - hp);

				    if(difference > 100)
					{
				        new Float:speed_x, Float:speed_y, Float:speed_z;
						GetVehicleVelocity(GetPlayerVehicleID(i),speed_x,speed_y,speed_z);
						new Float:final_speed = floatsqroot(((speed_x*speed_x)+(speed_y*speed_y))+(speed_z*speed_z))*99.4166672; // 250.666667 = kmph  // 199,4166672 = mph
						new speed = floatround(final_speed,floatround_round);

				        if(speed < player_vehicle_speed[i])
				        {
				            new Float:sdifference;
				            sdifference = (player_vehicle_speed[i] - speed);
				            if(sdifference > 20)
				            {

								new drunk_gain = 4000;
								if(seatbelt{i}) { drunk_gain = 3000; }
				                SetPlayerDrunkLevel(i,(GetPlayerDrunkLevel(i) + drunk_gain));
				                if(difference > 100)
				                {
					                new Float:phploss;
					                phploss = floatround((difference / 4));
					                if(seatbelt{i}) { phploss = floatround(phploss / 2); if(phploss < 0) { phploss = 0; } }
					                new Float:php;
					                GetPlayerHealth(i,php);
				                	SetPlayerHealth(i,(php - phploss));

									if((id = Car_GetID(veh)) != -1)
									{
									    if(floatround(phploss/2) > 0 && floatround(phploss/2) <= 500)
									    {
									        CarData[id][carEngineL] -= floatround(phploss/2);
										}

										if(CarData[id][carEngineL] < 0)
										CarData[id][carEngineL] = 0;

										if(CarData[id][carEngineL] < 20)
										{
										    SetEngineStatus(veh, false);
										    //ShowPlayerFooter(i, "Your vehicle ~r~break~w~!");
										}
									}

								}
				                //TextDrawShowForPlayer(i,gServerTextdraws[4]);
				                //SetTimerEx("HideCrash",250,0,"i",i);

				            }

				        }

				    }

				}

		    }
		}
	}

	for(new b = 0; b < MAX_VEHICLES; b ++) { new Float:hp; GetVehicleHealth(b,hp); crash_vhp[b] = hp; }
}

ResetWeapon(playerid, weaponid)
{
    SetPlayerAmmo(playerid, weaponid, 0);
	ResetPlayerWeapons(playerid);

	/*if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_ONDUTY))
 	{
	 	if (Character[playerid][Weapon0] != weaponid)
	 	{
	  		GivePlayerWeapon(playerid, Character[playerid][Weapon0], 1);
		}
		if (Character[playerid][Weapon1] != weaponid)
	 	{
	  		GivePlayerWeapon(playerid, Character[playerid][Weapon1], Character[playerid][Ammo1]);
		}
		if (Character[playerid][Weapon2] != weaponid)
	 	{
	  		GivePlayerWeapon(playerid, Character[playerid][Weapon2], Character[playerid][Ammo2]);
		}
		if (Character[playerid][Weapon0] == weaponid)
		{
			Character[playerid][Weapon0] = 0;
		}
		if (Character[playerid][Weapon1] == weaponid)
		{
			Character[playerid][Weapon1] = 0;
			Character[playerid][Ammo1] = 0;
		}
		if (Character[playerid][Weapon2] == weaponid)
		{
			Character[playerid][Weapon2] = 0;
			Character[playerid][Ammo2] = 0;
		}
	}*/
	return 1;
}


forward Handle_Account(playerid);
public Handle_Account(playerid)
{
    if(cache_num_rows())
    {
		if(CheckBanned[playerid] == 0)
        	Login_Dialog(playerid);
		else
			return 1;
    }
    else
    {
        Register_Dialog(playerid);
    }
    return 1;
}

Dialog:LOGIN(playerid, response, listitem, inputtext[])
{
	if(!response){ SendClientMessage(playerid, COLOR_RED, "คุณออกจากเซิฟเวอร์."); KickPlayer(playerid);}
    if(response)
    {
        new query[256], escapepass[129];
        WP_Hash(escapepass, sizeof(escapepass), inputtext);

		mysql_format(dbCon, query, sizeof(query), "SELECT SQLID, Status, Admin FROM Accounts WHERE Username = '%s' AND Password = '%s' LIMIT 1", GetName(playerid), escapepass);
    	mysql_tquery(dbCon, query, "Login", "i", playerid);

	}
    return 1;
}


forward Login(playerid);
public Login(playerid)
{
    if(cache_num_rows())
    {
        cache_get_value_name_int(0, "SQLID", Account[playerid][SQLID]);
        cache_get_value_name_int(0, "Status", Account[playerid][Status]);
        cache_get_value_name_int(0, "Admin", Account[playerid][Admin]);
        format(Account[playerid][Name], 32, "%s", GetName(playerid));

        printf("%s: Logged in.", Account[playerid][Name]);

        //Log_IP(playerid, ACCOUNT_LOGIN);

        Characters_Fetch(playerid);
    }
    else // Login
    {
        if(LoginAttempts[playerid] < 2)
        {
            Login_Dialog(playerid);
            //Log_IP(playerid, FAILED_ACCOUNT_LOGIN);

            SendClientMessage(playerid, COLOR_ORANGERED, "รหัสของคุณผิดพลาด!.");
            LoginAttempts[playerid] ++;
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, "คุณใส่รหัสผิดพลาดเยอะเกินไป");
            KickPlayer(playerid);
        }
    }
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source) 
{

	return 1;
}

forward Characters_Fetch(playerid);
public Characters_Fetch(playerid)
{
    new query[128];
    mysql_format(dbCon, query, sizeof(query), "SELECT ID, Name, Level, Skin FROM Characters WHERE A_ID = %d LIMIT 3", Account[playerid][SQLID]);
    mysql_tquery(dbCon, query, "Characters_Menu", "i", playerid);
    return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(playertextid == HUDSHOW[playerid][4])
	{
		UseUserControl[playerid] = 0;
		CancelSelectTextDraw(playerid);
		HideUserControl(playerid);
	}

	if(playertextid == HUDSHOW[playerid][16])
	{
		UseUserControl[playerid] = 0;
		CancelSelectTextDraw(playerid);
		HideUserControl(playerid);

		cmd_logout(playerid, "\1");
	}

	if(playertextid == HUDSHOW[playerid][6])
	{
		UseUserControl[playerid] = 0;
		CancelSelectTextDraw(playerid);
		HideUserControl(playerid);

		ShowStatsForPlayer(playerid, playerid);
	}

	if(playertextid == HUDSHOW[playerid][8])
	{
		UseUserControl[playerid] = 0;
		CancelSelectTextDraw(playerid);
		HideUserControl(playerid);

		OpenInventory(playerid);
	}

	if(playertextid == HUDSHOW[playerid][10])
	{
		UseUserControl[playerid] = 0;
		CancelSelectTextDraw(playerid);
		HideUserControl(playerid);

		cmd_help(playerid, "\1");
	}

    if(playertextid == Characters[playerid][8])
    {

		//SendClientMessageEx(playerid, -1, "%d", Character[playerid][SelectChar]);
        Character_Fetch(playerid, Character[playerid][SelectChar1]);
        //printf("%d",Character[playerid][SelectChar1]);
        
        PlayerTextDrawHide(playerid, Characters[playerid][0]);
        PlayerTextDrawHide(playerid, Characters[playerid][1]);
  		PlayerTextDrawHide(playerid, Characters[playerid][2]);
	    PlayerTextDrawHide(playerid, Characters[playerid][3]);
	    PlayerTextDrawHide(playerid, Characters[playerid][4]);
	    PlayerTextDrawHide(playerid, Characters[playerid][5]);
	    PlayerTextDrawHide(playerid, Characters[playerid][6]);
	    PlayerTextDrawHide(playerid, Characters[playerid][7]);
  		PlayerTextDrawHide(playerid, Characters[playerid][8]);
	    PlayerTextDrawHide(playerid, Characters[playerid][27]);
	    
	    PlayerTextDrawHide(playerid, Characters[playerid][9]);
    	PlayerTextDrawHide(playerid, Characters[playerid][18]);

	    PlayerTextDrawHide(playerid, Characters[playerid][30]);
	    PlayerTextDrawHide(playerid, Characters[playerid][31]);
	    PlayerTextDrawHide(playerid, Characters[playerid][32]);
	    
	    PlayerTextDrawHide(playerid, Characters[playerid][10]);
	    PlayerTextDrawHide(playerid, Characters[playerid][11]);
	    PlayerTextDrawHide(playerid, Characters[playerid][12]);
	    PlayerTextDrawHide(playerid, Characters[playerid][13]);
	    PlayerTextDrawHide(playerid, Characters[playerid][14]);
	    PlayerTextDrawHide(playerid, Characters[playerid][15]);
	    PlayerTextDrawHide(playerid, Characters[playerid][16]);
  		PlayerTextDrawHide(playerid, Characters[playerid][17]);
	    PlayerTextDrawHide(playerid, Characters[playerid][28]);
	    
	    PlayerTextDrawHide(playerid, Characters[playerid][19]);
	    PlayerTextDrawHide(playerid, Characters[playerid][20]);
	    PlayerTextDrawHide(playerid, Characters[playerid][21]);
	    PlayerTextDrawHide(playerid, Characters[playerid][22]);
	    PlayerTextDrawHide(playerid, Characters[playerid][23]);
	    PlayerTextDrawHide(playerid, Characters[playerid][24]);
	    PlayerTextDrawHide(playerid, Characters[playerid][25]);
	    PlayerTextDrawHide(playerid, Characters[playerid][26]);
	    PlayerTextDrawHide(playerid, Characters[playerid][29]);
	    CancelSelectTextDraw(playerid);
        
    }
    
    if(playertextid == Characters[playerid][17])
    {

		//SendClientMessageEx(playerid, -1, "%d", Character[playerid][SelectChar]);
        Character_Fetch(playerid, Character[playerid][SelectChar2]);
        //printf("%d",Character[playerid][SelectChar2]);

        PlayerTextDrawHide(playerid, Characters[playerid][0]);
        PlayerTextDrawHide(playerid, Characters[playerid][1]);
  		PlayerTextDrawHide(playerid, Characters[playerid][2]);
	    PlayerTextDrawHide(playerid, Characters[playerid][3]);
	    PlayerTextDrawHide(playerid, Characters[playerid][4]);
	    PlayerTextDrawHide(playerid, Characters[playerid][5]);
	    PlayerTextDrawHide(playerid, Characters[playerid][6]);
	    PlayerTextDrawHide(playerid, Characters[playerid][7]);
  		PlayerTextDrawHide(playerid, Characters[playerid][8]);
	    PlayerTextDrawHide(playerid, Characters[playerid][27]);

	    PlayerTextDrawHide(playerid, Characters[playerid][9]);
    	PlayerTextDrawHide(playerid, Characters[playerid][18]);

	    PlayerTextDrawHide(playerid, Characters[playerid][30]);
	    PlayerTextDrawHide(playerid, Characters[playerid][31]);
	    PlayerTextDrawHide(playerid, Characters[playerid][32]);

	    PlayerTextDrawHide(playerid, Characters[playerid][10]);
	    PlayerTextDrawHide(playerid, Characters[playerid][11]);
	    PlayerTextDrawHide(playerid, Characters[playerid][12]);
	    PlayerTextDrawHide(playerid, Characters[playerid][13]);
	    PlayerTextDrawHide(playerid, Characters[playerid][14]);
	    PlayerTextDrawHide(playerid, Characters[playerid][15]);
	    PlayerTextDrawHide(playerid, Characters[playerid][16]);
  		PlayerTextDrawHide(playerid, Characters[playerid][17]);
	    PlayerTextDrawHide(playerid, Characters[playerid][28]);

	    PlayerTextDrawHide(playerid, Characters[playerid][19]);
	    PlayerTextDrawHide(playerid, Characters[playerid][20]);
	    PlayerTextDrawHide(playerid, Characters[playerid][21]);
	    PlayerTextDrawHide(playerid, Characters[playerid][22]);
	    PlayerTextDrawHide(playerid, Characters[playerid][23]);
	    PlayerTextDrawHide(playerid, Characters[playerid][24]);
	    PlayerTextDrawHide(playerid, Characters[playerid][25]);
	    PlayerTextDrawHide(playerid, Characters[playerid][26]);
	    PlayerTextDrawHide(playerid, Characters[playerid][29]);
	    CancelSelectTextDraw(playerid);

    }
    
    if(playertextid == Characters[playerid][26])
    {

		//SendClientMessageEx(playerid, -1, "%d", Character[playerid][SelectChar]);
        Character_Fetch(playerid, Character[playerid][SelectChar3]);
        //printf("%d",Character[playerid][SelectChar3]);

        PlayerTextDrawHide(playerid, Characters[playerid][0]);
        PlayerTextDrawHide(playerid, Characters[playerid][1]);
  		PlayerTextDrawHide(playerid, Characters[playerid][2]);
	    PlayerTextDrawHide(playerid, Characters[playerid][3]);
	    PlayerTextDrawHide(playerid, Characters[playerid][4]);
	    PlayerTextDrawHide(playerid, Characters[playerid][5]);
	    PlayerTextDrawHide(playerid, Characters[playerid][6]);
	    PlayerTextDrawHide(playerid, Characters[playerid][7]);
  		PlayerTextDrawHide(playerid, Characters[playerid][8]);
	    PlayerTextDrawHide(playerid, Characters[playerid][27]);

	    PlayerTextDrawHide(playerid, Characters[playerid][9]);
    	PlayerTextDrawHide(playerid, Characters[playerid][18]);

	    PlayerTextDrawHide(playerid, Characters[playerid][30]);
	    PlayerTextDrawHide(playerid, Characters[playerid][31]);
	    PlayerTextDrawHide(playerid, Characters[playerid][32]);

	    PlayerTextDrawHide(playerid, Characters[playerid][10]);
	    PlayerTextDrawHide(playerid, Characters[playerid][11]);
	    PlayerTextDrawHide(playerid, Characters[playerid][12]);
	    PlayerTextDrawHide(playerid, Characters[playerid][13]);
	    PlayerTextDrawHide(playerid, Characters[playerid][14]);
	    PlayerTextDrawHide(playerid, Characters[playerid][15]);
	    PlayerTextDrawHide(playerid, Characters[playerid][16]);
  		PlayerTextDrawHide(playerid, Characters[playerid][17]);
	    PlayerTextDrawHide(playerid, Characters[playerid][28]);

	    PlayerTextDrawHide(playerid, Characters[playerid][19]);
	    PlayerTextDrawHide(playerid, Characters[playerid][20]);
	    PlayerTextDrawHide(playerid, Characters[playerid][21]);
	    PlayerTextDrawHide(playerid, Characters[playerid][22]);
	    PlayerTextDrawHide(playerid, Characters[playerid][23]);
	    PlayerTextDrawHide(playerid, Characters[playerid][24]);
	    PlayerTextDrawHide(playerid, Characters[playerid][25]);
	    PlayerTextDrawHide(playerid, Characters[playerid][26]);
	    PlayerTextDrawHide(playerid, Characters[playerid][29]);
	    CancelSelectTextDraw(playerid);

    }
    
    if(playertextid == Characters[playerid][30])
    {
        new str[64], dialog[512];
    
        if(cache_num_rows() < 3)
	    {
	        format(str, sizeof(str), "||\t||\t||\n");
  			strcat(dialog, str, sizeof(dialog));
  			
	        format(str, sizeof(str), " \tสร้างตัวละครใหม่\t\n");
	        strcat(dialog, str, sizeof(dialog));
	    }

	    format(str, sizeof(str), "%s's Characters", GetName(playerid));
	    Dialog_Show(playerid, Character_Select, DIALOG_STYLE_TABLIST_HEADERS, str, dialog, "Select","Leave");
	    
	    PlayerTextDrawHide(playerid, Characters[playerid][0]);
	    PlayerTextDrawHide(playerid, Characters[playerid][9]);
	    PlayerTextDrawHide(playerid, Characters[playerid][18]);

	    PlayerTextDrawHide(playerid, Characters[playerid][30]);
	    PlayerTextDrawHide(playerid, Characters[playerid][31]);
	    PlayerTextDrawHide(playerid, Characters[playerid][32]);
	    CancelSelectTextDraw(playerid);
	}
	
	if(playertextid == Characters[playerid][31])
    {
        new str[64], dialog[512];

        if(cache_num_rows() < 3)
	    {
	        format(str, sizeof(str), "||\t||\t||\n");
  			strcat(dialog, str, sizeof(dialog));
	    
	        format(str, sizeof(str), " \tสร้างตัวละครใหม่\t\n");
	        strcat(dialog, str, sizeof(dialog));
	    }

	    format(str, sizeof(str), "%s's Characters", GetName(playerid));
	    Dialog_Show(playerid, Character_Select, DIALOG_STYLE_TABLIST_HEADERS, str, dialog, "Select","Leave");
	    
	    PlayerTextDrawHide(playerid, Characters[playerid][0]);
	    PlayerTextDrawHide(playerid, Characters[playerid][9]);
	    PlayerTextDrawHide(playerid, Characters[playerid][18]);

	    PlayerTextDrawHide(playerid, Characters[playerid][30]);
	    PlayerTextDrawHide(playerid, Characters[playerid][31]);
	    PlayerTextDrawHide(playerid, Characters[playerid][32]);
	    
	    PlayerTextDrawHide(playerid, Characters[playerid][1]);
	    PlayerTextDrawHide(playerid, Characters[playerid][2]);
	    PlayerTextDrawHide(playerid, Characters[playerid][3]);
	    PlayerTextDrawHide(playerid, Characters[playerid][4]);
	    PlayerTextDrawHide(playerid, Characters[playerid][5]);
	    PlayerTextDrawHide(playerid, Characters[playerid][6]);
	    PlayerTextDrawHide(playerid, Characters[playerid][7]);
  		PlayerTextDrawHide(playerid, Characters[playerid][8]);
	    PlayerTextDrawHide(playerid, Characters[playerid][27]);
	    
	    CancelSelectTextDraw(playerid);
	}
	
	if(playertextid == Characters[playerid][32])
    {
        new str[64], dialog[512];

        if(cache_num_rows() < 3)
	    {
	        format(str, sizeof(str), "||\t||\t||\n");
  			strcat(dialog, str, sizeof(dialog));
	    
	        format(str, sizeof(str), " \tสร้างตัวละครใหม่\t\n");
	        strcat(dialog, str, sizeof(dialog));
	    }

	    format(str, sizeof(str), "%s's Characters", GetName(playerid));
	    Dialog_Show(playerid, Character_Select, DIALOG_STYLE_TABLIST_HEADERS, str, dialog, "Select","Leave");
	    
	    PlayerTextDrawHide(playerid, Characters[playerid][0]);
	    PlayerTextDrawHide(playerid, Characters[playerid][9]);
	    PlayerTextDrawHide(playerid, Characters[playerid][18]);

	    PlayerTextDrawHide(playerid, Characters[playerid][30]);
	    PlayerTextDrawHide(playerid, Characters[playerid][31]);
	    PlayerTextDrawHide(playerid, Characters[playerid][32]);
	    
	    PlayerTextDrawHide(playerid, Characters[playerid][1]);
	    PlayerTextDrawHide(playerid, Characters[playerid][2]);
	    PlayerTextDrawHide(playerid, Characters[playerid][3]);
	    PlayerTextDrawHide(playerid, Characters[playerid][4]);
	    PlayerTextDrawHide(playerid, Characters[playerid][5]);
	    PlayerTextDrawHide(playerid, Characters[playerid][6]);
	    PlayerTextDrawHide(playerid, Characters[playerid][7]);
  		PlayerTextDrawHide(playerid, Characters[playerid][8]);
	    PlayerTextDrawHide(playerid, Characters[playerid][27]);
	    
	    PlayerTextDrawHide(playerid, Characters[playerid][10]);
	    PlayerTextDrawHide(playerid, Characters[playerid][11]);
	    PlayerTextDrawHide(playerid, Characters[playerid][12]);
	    PlayerTextDrawHide(playerid, Characters[playerid][13]);
	    PlayerTextDrawHide(playerid, Characters[playerid][14]);
	    PlayerTextDrawHide(playerid, Characters[playerid][15]);
	    PlayerTextDrawHide(playerid, Characters[playerid][16]);
  		PlayerTextDrawHide(playerid, Characters[playerid][17]);
	    PlayerTextDrawHide(playerid, Characters[playerid][28]);
	    
	    

	    CancelSelectTextDraw(playerid);
	}

	return 1;
}

forward Characters_Menu(playerid);
public Characters_Menu(playerid)
{
    new /*str[64], dialog[512],*/ C_ID, C_Name[24], C_LVL, C_SKIN;
    
    new string[128];

   /* format(str, sizeof(str), "CID\tชื่อตัวละคร\tเลเวล\n");
    strcat(dialog, str, sizeof(dialog));*/
    

    SelectTextDraw(playerid, COLOR_WHITE);

    if(cache_num_rows() < 3)
	{

	    PlayerTextDrawShow(playerid, Characters[playerid][30]);
	    PlayerTextDrawShow(playerid, Characters[playerid][31]);
	    PlayerTextDrawShow(playerid, Characters[playerid][32]);
	}

    for( new id = 0; id < cache_num_rows(); id++)
    {
        cache_get_value_name_int(id, "ID", C_ID);
        cache_get_value_name(id, "Name", C_Name, 24);
        cache_get_value_name_int(id, "Level", C_LVL);
        cache_get_value_name_int(id, "Skin", C_SKIN);

		if(id == 0)
		{
		    PlayerTextDrawShow(playerid, Characters[playerid][2]);
		    PlayerTextDrawShow(playerid, Characters[playerid][3]);
		    PlayerTextDrawShow(playerid, Characters[playerid][4]);
		    PlayerTextDrawShow(playerid, Characters[playerid][5]);
		    PlayerTextDrawShow(playerid, Characters[playerid][6]);
		    PlayerTextDrawShow(playerid, Characters[playerid][7]);
      		PlayerTextDrawShow(playerid, Characters[playerid][8]);
		    PlayerTextDrawShow(playerid, Characters[playerid][27]);
		    
		    PlayerTextDrawHide(playerid, Characters[playerid][30]);

		    PlayerTextDrawSetPreviewModel(playerid, Characters[playerid][1], C_SKIN);

		    PlayerTextDrawShow(playerid, Characters[playerid][1]);

	        format(string, sizeof(string), "SQLID: %d", C_ID);
			PlayerTextDrawSetString(playerid, Characters[playerid][27], string);
			
			Character[playerid][SelectChar1] = C_ID;
			
	        format(string, sizeof(string), "%s", C_Name);
			PlayerTextDrawSetString(playerid, Characters[playerid][3], string);

			format(string, sizeof(string), "%d", C_LVL);
			PlayerTextDrawSetString(playerid, Characters[playerid][7], string);
		}

		if(id == 1)
		{
		    PlayerTextDrawShow(playerid, Characters[playerid][11]);
		    PlayerTextDrawShow(playerid, Characters[playerid][12]);
		    PlayerTextDrawShow(playerid, Characters[playerid][13]);
		    PlayerTextDrawShow(playerid, Characters[playerid][14]);
		    PlayerTextDrawShow(playerid, Characters[playerid][15]);
		    PlayerTextDrawShow(playerid, Characters[playerid][16]);
      		PlayerTextDrawShow(playerid, Characters[playerid][17]);
		    PlayerTextDrawShow(playerid, Characters[playerid][28]);
		    
		    PlayerTextDrawHide(playerid, Characters[playerid][31]);

		    PlayerTextDrawSetPreviewModel(playerid, Characters[playerid][10], C_SKIN);

		    PlayerTextDrawShow(playerid, Characters[playerid][10]);

	        format(string, sizeof(string), "SQLID: %d", C_ID);
			PlayerTextDrawSetString(playerid, Characters[playerid][28], string);
			
			Character[playerid][SelectChar2] = C_ID;

	        format(string, sizeof(string), "%s", C_Name);
			PlayerTextDrawSetString(playerid, Characters[playerid][12], string);

			format(string, sizeof(string), "%d", C_LVL);
			PlayerTextDrawSetString(playerid, Characters[playerid][16], string);
		}

		if(id == 2)
		{
		    SetPlayerSkin(id, Character[id][Skin]);

		    PlayerTextDrawShow(playerid, Characters[playerid][20]);
		    PlayerTextDrawShow(playerid, Characters[playerid][21]);
		    PlayerTextDrawShow(playerid, Characters[playerid][22]);
		    PlayerTextDrawShow(playerid, Characters[playerid][23]);
		    PlayerTextDrawShow(playerid, Characters[playerid][24]);
		    PlayerTextDrawShow(playerid, Characters[playerid][25]);
		    PlayerTextDrawShow(playerid, Characters[playerid][26]);
		    PlayerTextDrawShow(playerid, Characters[playerid][29]);
		    
		    PlayerTextDrawHide(playerid, Characters[playerid][32]);

		    PlayerTextDrawSetPreviewModel(playerid, Characters[playerid][19], C_SKIN);

		    PlayerTextDrawShow(playerid, Characters[playerid][19]);

	        format(string, sizeof(string), "SQLID: %d", C_ID);
			PlayerTextDrawSetString(playerid, Characters[playerid][29], string);
			
			Character[playerid][SelectChar3] = C_ID;

	        format(string, sizeof(string), "%s", C_Name);
			PlayerTextDrawSetString(playerid, Characters[playerid][21], string);

			format(string, sizeof(string), "%d", C_LVL);
			PlayerTextDrawSetString(playerid, Characters[playerid][25], string);
		}

        /*format(str, sizeof(str), "[%d] \t%s\t%d\n", C_ID, C_Name, C_LVL);
        strcat(dialog, str, sizeof(dialog));*/
    }
    
    PlayerTextDrawShow(playerid, Characters[playerid][0]);
	PlayerTextDrawShow(playerid, Characters[playerid][9]);
	PlayerTextDrawShow(playerid, Characters[playerid][18]);

    /*if(cache_num_rows() < 3)
    {
        format(str, sizeof(str), " \tสร้างตัวละครใหม่\t\n");
        strcat(dialog, str, sizeof(dialog));
    }*/

    /*format(str, sizeof(str), "%s's Characters", GetName(playerid));
    Dialog_Show(playerid, Character_Select, DIALOG_STYLE_TABLIST_HEADERS, str, dialog, "Select","Leave");
*/
    return 1;
}

Dialog:Character_Select(playerid, response, listitem, inputtext[])
{
    if(!response){ SendClientMessage(playerid, COLOR_RED, "คุณได้ออกจากเซิฟเวอร์."); KickPlayer(playerid);}
    if(response)
    {
        new C_ID[6];
        strmid(C_ID, inputtext, strfind(inputtext, "[") + 1,  strfind(inputtext, "]"));
        Character_Fetch(playerid, strval(C_ID));
    }
    return 1;
}


forward Character_Fetch(playerid, id);
public Character_Fetch(playerid, id)
{
    new query[128];
    if(id)
    {
	    Character[playerid][ID] = id;
	    mysql_format(dbCon, query, sizeof(query), "SELECT * FROM characters WHERE ID = %d LIMIT 1", id);
	    mysql_tquery(dbCon, query, "Character_Load", "i", playerid);
    }
    else
    {
    	Character_Create(playerid);
    }
    return 1;
}

Character_Create(playerid)
{
	Dialog_Show(playerid, CREATECHARACTER, DIALOG_STYLE_INPUT, "การสร้างตัวละคร", "กรุณาใส่ชื่อตัวละครใหม่ของคุณด้านล่าง:\n\nคำเตือน: ชื่อของคุณต้องอยู่ในรูปแบบ Firstname_Lastname และไม่เกิน 20 ตัวอักษร:", "Create","Cancel");
	return 1;
}


Dialog:REGISTER(playerid, response, listitem, inputtext[])
{
	if(strlen(inputtext) < 6 || strlen(inputtext) > 24)
    {
        SendClientMessage(playerid, COLOR_ORANGERED, "รหัสผ่านต้องมีอย่างน้อย 6-24 ตัว!");
        Register_Dialog(playerid);
    }
    else if(strlen(inputtext) > 5 && strlen(inputtext) < 24)
    {
        new query[400],escapepass[129];
        
        WP_Hash(escapepass, sizeof(escapepass), inputtext);

		GetPlayerIp(playerid, Character[playerid][RegisterIP], 16);

    	mysql_format(dbCon, query, sizeof(query), "INSERT INTO accounts (Username, Password, RegisterIP, RegisterDate) VALUES('%s','%s','%s', '%s')", GetName(playerid), escapepass, Character[playerid][RegisterIP], ReturnDate());
		mysql_tquery(dbCon, query, "GetAccID", "i", playerid);
		
        //Quiz(playerid, 1);
        Characters_Fetch(playerid);
	}
    return 1;
}

forward GetAccID(playerid);
public GetAccID(playerid)
{
	Account[playerid][SQLID] = cache_insert_id();
	return 1;
}

forward GetCharacterID(playerid);
public GetCharacterID(playerid)
{
	Character[playerid][ID] = cache_insert_id();
	return 1;
}



public OnPlayerDisconnect(playerid, reason)
{
	KillTimer(InactivtyCheck[playerid]);
	StopAudioStreamForPlayer(playerid);

	Character_Save(playerid);
	LoggedIn[playerid] = false;
    new pName[24], str[128];
    GetPlayerName(playerid, pName, 24);

    switch(reason)
    {
        case 0: format(str, 128, "%s ออกจากเซิฟเวอร์. (Timeout)", pName);
        case 1: format(str, 128, "%s ออกจากเซิฟเวอร์. (Leaving)", pName);
        case 2: format(str, 128, "%s ออกจากเซิฟเวอร์. (Kicked)", pName);
    }
    SendAdminsMessage(1, COLOR_GRAY, str);

    TerminateConnection(playerid);
	return 1;
}

forward GeneralListener();
public GeneralListener()
{
	new str[128];
		//Float:health;

	RestartCheck();

	new id = -1;

    foreach (new i : Player)
	{
		format(str, sizeof(str), "%d", GetPlayerPing(i));
		PlayerTextDrawSetString(i, Ping[i][6], str);

		if(taser[i])
		{
			if(TaserShoot[i] == 1)
			{
				if(GiveTaserAgainTimerEx[i] < 5){
					TaserTimeAG[i]++;
					SetPlayerProgressBarValue(i, TASERBARAG[i], TaserTimeAG[i]);
				}
			}
		}

		if(IsPlayerTaser[i] == 1)
		{
			if(TaserTime[i] < 10)
			{
				TaserTime[i]++;
				SetPlayerProgressBarValue(i, TASERBAR[i], TaserTime[i]);
			}
		}

	    
	
	    if(AFKTimer[i] > 0)
		{
		    AFKTimer[i]--;
		    if(AFKTimer[i] <= 0)
		    {
		        AFKTimer[i] = 0;
                IsAFK{i} = true;
		    }
		}

     	if(GetTickCount() > (Character[i][PauseCheck]+2000))
			Character[i][PauseTime] ++;
	
	    if ((id = Boombox_Nearest(i)) != INVALID_PLAYER_ID && Character[i][Boombox] != id && strlen(BoomboxData[id][boomboxURL]) && !IsPlayerInAnyVehicle(i))
		{
		    strunpack(str, BoomboxData[id][boomboxURL]);
		    Character[i][Boombox] = id;

		    StopAudioStreamForPlayer(i);
		    PlayAudioStreamForPlayer(i, str, BoomboxData[id][boomboxPos][0], BoomboxData[id][boomboxPos][1], BoomboxData[id][boomboxPos][2], 30.0, 1);
		}
		else if (Character[i][Boombox] != INVALID_PLAYER_ID && !IsPlayerInRangeOfPoint(i, 30.0, BoomboxData[Character[i][Boombox]][boomboxPos][0], BoomboxData[Character[i][Boombox]][boomboxPos][1], BoomboxData[Character[i][Boombox]][boomboxPos][2]))
		{
		    Character[i][Boombox] = INVALID_PLAYER_ID;
		    StopAudioStreamForPlayer(i);
		}
	
	    /*if (++ Character[i][FoodTime] >= 300)
		{
			if (Character[i][Food] > 0)
			{
				Character[i][Food] -= 5;
	   		}
	   		else if (Character[i][Food] <= 20)
			{
	 			SetPlayerHealth(i, health - 10);
				SendClientMessage(i, COLOR_RP, "คุณรู้สึกหิวอาหาร!!");
	  		}
	  		Character[i][FoodTime] = 0;
	   	}
	    if (++ Character[i][WaterTime] >= 280)
		{
			if (Character[i][Water] >= 0)
			{
	 			Character[i][Water] -= 7;
			}
			else if (Character[i][Water] <= 20)
			{
	 			SetPlayerHealth(i, health - 5);
	   			SendClientMessage(i, COLOR_RP, "คุณรู้สึกหิวน้ำ!!");
	  		}
	  		Character[i][WaterTime] = 0;
		}*/

	    /*if (Character[i][JailTime] > 0)
		{
		    new
		        hours,
		        minutes,
		        seconds;

		    Character[i][JailTime]--;

			GetElapsedTime(Character[i][JailTime], hours, minutes, seconds);

			format(str, sizeof(str), "~g~Prison Time:~w~ %02d:%02d:%02d", hours, minutes, seconds);
			PlayerTextDrawSetString(i, Prisontime[i], str);

		    if (!Character[i][JailTime])
		    {
		        Character[i][Prisoned] = 0;

                SetPlayerPosEx(i, 1543.1656,-1675.5603,13.5559);
    			SetPlayerInterior(i, 0);

				SetPlayerVirtualWorld(i, 0);

				SendClientMessage(i, -1, "เวลาคุณหมดแล้ว! คุณถูกปล่อยออกจาก คุก/เรือนจำ");
		        PlayerTextDrawHide(i, Prisontime[i]);
			}
		}*/
  		if(GetTickCount() > (Character[i][PauseCheck]+2000))
			Character[i][PauseTime] ++;

	    if (Character[i][InjuredTime] > 0)
		{
	 		Character[i][InjuredTime]--;

			if (Character[i][InjuredTime] <= 0)
	  		{
	    		Character[i][InjuredTime] = 0;
	    	}
		}
	    if (Character[i][Injured] == 1 && GetPlayerAnimationIndex(i) != 1206 && GetPlayerState(i) == PLAYER_STATE_ONFOOT)
		{
			ApplyAnimation(i, "PED", "KO_shot_front", 4.0, 0, 0, 0, 1, 0, 1);
		}
		else if (Character[i][Stunned] > 0)
		{
            Character[i][Stunned]--;

			if (GetPlayerAnimationIndex(i) != 388)
            	ApplyAnimation(i, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);

            if (!Character[i][Stunned])
            {
                TogglePlayerControllable(i, 1);
                ShowPlayerFooter(i, "You are no longer ~r~stunned.");
			}
		}
		/*if(PlayerTakingLicense[i] && PlayerLicenseTime[i] <= 60)
		{
			PlayerLicenseTime[i]--;

			format(str, sizeof(str), "~w~%d", PlayerLicenseTime[i]);
			GameTextForPlayer(i, str, 2000, 3);

			if(PlayerLicenseTime[i] < 1)
			{
				StopDriverstest(i);
				SendClientMessage(i, COLOR_RED, "[!]{FFFFFF}คุณใช้เวลานานเกินไปทำให้คุณไม่ผ่านการทดสอบ.");
			}
		}*/
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{

	if(EnterCheckPointJob[playerid] == 1)
	{
		EnterCheckPointJob[playerid] = 0;
		PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
		DisablePlayerCheckpoint(playerid);
	}

    if(ParkCheckpoint[playerid])
	{
	    new
	    	carid = GetPlayerVehicleID(playerid);

		if (!carid)
		    return SendClientMessage(playerid, -1, "คุณต้องอยู่ในยานพาหนะ");

	    if (IsVehicleImpounded(carid))
	    	return SendClientMessage(playerid, -1, "ยานพาหนะคันนี้ถูกยึดและคุณไม่สามารถใช้มันได้");

		if ((carid = Car_GetID(carid)) != -1 && Car_IsOwner(playerid, carid))
		{
		    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		        return SendClientMessage(playerid, -1, "คุณต้องเป็นคนขับ!");

		    new
				g_arrSeatData[10] = {INVALID_PLAYER_ID, ...},
				seatid;

	        for (new i = 0; i < 14; i ++) {
				CarData[carid][carMods][i] = GetVehicleComponentInSlot(CarData[carid][carVehicle], i);
		    }
		    SaveVehicleDamage(CarData[carid][carVehicle]);
			foreach (new i : Player) if (IsPlayerInVehicle(i, CarData[carid][carVehicle])) {
			    seatid = GetPlayerVehicleSeat(i);

			    g_arrSeatData[seatid] = i;
			}
			SetVehiclePos(CarData[carid][carVehicle], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2]);
			SetVehicleZAngle(CarData[carid][carVehicle], CarData[carid][carPos][3]);

			Car_Spawn(carid);
			Car_Save(carid);

            SendClientMessage(playerid, -1, "คุณได้ประสบความสำเร็จในการจอดรถของคุณ");

			for (new i = 0; i < sizeof(g_arrSeatData); i ++) if (g_arrSeatData[i] != INVALID_PLAYER_ID) {
			    PutPlayerInVehicleEx(g_arrSeatData[i], CarData[carid][carVehicle], i);

			    g_arrSeatData[i] = INVALID_PLAYER_ID;
			}
		}
		else SendClientMessage(playerid, -1, "คุณไม่ได้อยู่ในบางอย่างที่สามารถจอดรถได้");

		PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
		DisablePlayerCheckpoint(playerid);
		ParkCheckpoint[playerid] = false;
	}
	return 1;
}

forward FixKick(playerid);
public FixKick(playerid)
{
	Kick(playerid);
	return 1;
}

ReturnDate()
{
	new
	    date[36];

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	format(date, sizeof(date), "%02d/%02d/%d, %02d:%02d:%02d", date[0], date[1], date[2], date[3], date[4], date[5]);
	return date;
}

ShowStatsForPlayer(playerid, targetid)
{
	new
	    string[128],
	    month[12],
	    sex[64],
		date[6],
		radio[32];
		//business_key[20] = "None",
	//	house_key[20] = "None";

 	new Float:hp;
	new Float:armor;

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	switch (date[1]) {
	    case 1: month = "January";
	    case 2: month = "February";
	    case 3: month = "March";
	    case 4: month = "April";
	    case 5: month = "May";
	    case 6: month = "June";
	    case 7: month = "July";
	    case 8: month = "August";
	    case 9: month = "September";
	    case 10: month = "October";
	    case 11: month = "November";
	    case 12: month = "December";
	}

	new exp = Character[targetid][Exp];
	new nxtlevel = Character[targetid][Level]+1;
	new expamount = nxtlevel*levelexp;
	new costlevel = nxtlevel*levelcost;

	if(Character[targetid][Gender] == 1)
	{
		sex = "ชาย";
	}
	if(Character[targetid][Gender] == 2)
	{
		sex = "หญิง";
	}

	if(Character[targetid][PortableRadio] == 1)
	{
	    radio = "มี";
	}
	if(Character[targetid][PortableRadio] == 0)
	{
	    radio = "None";
	}

	for(new i = 1; i < MAX_HOUSES; i++)
	{
		if(House_IsOwner(targetid, i))
			Character[playerid][HouseID] = House_IsOwner(targetid, i);
	}

	GetPlayerHealth(targetid, hp);
    GetPlayerArmour(targetid, armor);
    
    Character[playerid][Interior] = GetPlayerInterior(playerid);
	Character[playerid][VWorld] = GetPlayerVirtualWorld(playerid);

    format(string, sizeof(string), "|____________________________%s [%02d %s %d, %02d:%02d:%02d]_____________________________|", ReturnRealName(targetid), date[0], month, date[2], date[3], date[4], date[5]);
	SendClientMessage(playerid, COLOR_DARKGREEN, string);

	if(Character[targetid][FactionID] >= 1)
	{
		format(string, sizeof(string), "| ตัวละคร | เพศ: [%s] กลุ่ม:[%d][%s] ตำแหน่ง:[%s] อาชีพ:[%s] เบอร์:[%d]", sex, Character[targetid][FactionID], Faction_GetName(targetid), Faction_GetRank(targetid), Job_GetName(Character[targetid][Job]), Character[targetid][Phone]);
		SendClientMessage(playerid, COLOR_WHITE, string);
	}

	if(Character[targetid][FactionID] == -1)
	{
	    format(string, sizeof(string), "| ตัวละคร | กลุ่ม:[0][พลเรือน] ตำแหน่ง:[ไม่มีตำแหน่ง] อาชีพ:[%s] เบอร์:[%d]", Job_GetName(Character[targetid][Job]), Character[targetid][Phone]);
		SendClientMessage(playerid, COLOR_WHITE, string);
	}
	
	format(string, sizeof(string), "| สิ่งของ | วิทยุ:[%s] บัญชีธนาคาร:[มี]", radio);
	SendClientMessage(playerid, COLOR_WHITE, string);
	
	format(string, sizeof(string), "| สิ่งของ | คลื่นวิทยุ:[%d] ช่อง:[%d]", Character[targetid][Channel],Character[targetid][ChannelSlot]);
	SendClientMessage(playerid, COLOR_WHITE, string);

	format(string, sizeof(string), "| เลเวล | เลเวลผู้เล่น:[%d] ประสบการณ์:[%d/%d] ค่าอัพเลเวล:[%s] ระดับบริจาค:[None]", Character[targetid][Level], exp, expamount, FormatNumber(costlevel));
	SendClientMessage(playerid, COLOR_WHITE, string);

	format(string, sizeof(string), "| ทักษะ | เลือด:[%.2f] เกราะ:[%.2f] ชั่วโมงที่ออนไลน์:[%d]", hp, armor, Character[targetid][Playerhours]);
	SendClientMessage(playerid, COLOR_WHITE, string);

	format(string, sizeof(string), "| เงิน | เงินสด:[%s] เงินในธนาคาร:[%s] บัญชีออมทรัพย์:[%s] เงินค่าจ้าง:[%s]", FormatNumber(Character[targetid][Cash]), FormatNumber(Character[targetid][Bank]), FormatNumber(Character[targetid][Savings]), FormatNumber(Character[targetid][Paycheck]));
	SendClientMessage(playerid, COLOR_WHITE, string);

	format(string, sizeof(string), "| อื่นๆ | ที่ทำงาน:[None] อาชีพเสริม:[None]");
	SendClientMessage(playerid, COLOR_WHITE, string);

	if(Account[playerid][Admin] >= 1)
	{
	    new count;
	
	    for (new i = 0; i < MAX_HOUSES; i ++) if (House_IsOwner(targetid, i)) {
	    	SendClientMessageEx(playerid, COLOR_WHITE, "| บ้านไอดี: [%d] | ที่อยู่: [%s] | ตำแหน่งที่ตั้ง: [%s]", i, HouseData[i][houseAddress], GetLocation(HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2]));
	    	count++;
		}
		for (new i = 0; i < MAX_BUSINESSES; i ++) if (Business_IsOwner(targetid, i) && BusinessData[i][bizOwner] != 99999999) {
		    SendClientMessageEx(playerid, COLOR_WHITE, "| ธุรกิจไอดี: [%d] | ชื่อกิจการ: [%s] | ตำแหน่งที่ตั้ง: [%s]", i, BusinessData[i][bizName], GetLocation(BusinessData[i][bizPos][0], BusinessData[i][bizPos][1], BusinessData[i][bizPos][2]));
		    count++;
		}
		format(string, sizeof(string), "| สำหรับแอดมิน | ภายใน:[%d] โลก:[%d] พื้นที่:[None]", Character[targetid][Interior], Character[targetid][VWorld]);
		SendClientMessage(playerid, COLOR_WHITE, string);
	}

	format(string, sizeof(string), "|____________________________%s [%02d %s %d, %02d:%02d:%02d]_____________________________|", ReturnRealName(targetid), date[0], month, date[2], date[3], date[4], date[5]);
	SendClientMessage(playerid, COLOR_DARKGREEN, string);
	return 1;
}

forward FirstAidUpdate(playerid);
public FirstAidUpdate(playerid)
{
	new
	    Float:health;

	GetPlayerHealth(playerid, health);

    if (!IsPlayerInAnyVehicle(playerid) && GetPlayerAnimationIndex(playerid) != 1508)
    	ApplyAnimation(playerid, "SWAT", "gnstwall_injurd", 4.0, 1, 0, 0, 0, 0);

	if (health >= 95.0)
	{
	    AC_SetPlayerHealth(playerid, 100.0);
	    SendClientMessage(playerid, -1, "ชุดปฐมพยาบาลของคุณถูกใช้");

		if (!IsPlayerInAnyVehicle(playerid)) {
	        LoopAnim[playerid] = 1;
			ShowPlayerFooter(playerid, "~w~Press~w~ Right Click  ~w~to stop the animation.");
		}

		Character[playerid][FirstAid] = false;
		KillTimer(Character[playerid][AidTimer]);
	}
	else {
		AC_SetPlayerHealth(playerid, floatadd(health, 4.0));
	}
	return 1;
}

ReturnHealth(playerid)
{
	new
	    Float:amount;

	GetPlayerHealth(playerid, amount);
	return floatround(amount, floatround_round);
}

Dialog:DialNumber(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new
	        string[16];

	    if (isnull(inputtext) || !IsNumeric(inputtext))
	        return Dialog_Show(playerid, DialNumber, DIALOG_STYLE_INPUT, "Dial Number", "โปรดกรุณาป้อนหมายเลขที่คุณต้องการในการโทรด้านล่าง:", "Dial", "Back");

        format(string, 16, "%d", strval(inputtext));
		cmd_call(playerid, string);
	}
	else {
		cmd_phone(playerid, "\1");
	}
	return 1;
}

Dialog:SendText(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new number = strval(inputtext);

	    if (isnull(inputtext) || !IsNumeric(inputtext))
	        return Dialog_Show(playerid, SendText, DIALOG_STYLE_INPUT, "Send Text Message", "กรุณาป้อนหมายเลขที่คุณต้องการที่จะส่งข้อความไป:", "Dial", "Back");

        if (GetNumberOwner(number) == INVALID_PLAYER_ID)
            return Dialog_Show(playerid, SendText, DIALOG_STYLE_INPUT, "Send Text Message", "ข้อผิดพลาด: หมายเลขนั้นไม่ได้ออนไลน์ในขณะนี้\n\nกรุณาป้อนหมายเลขที่คุณต้องการที่จะส่งข้อความไป:", "Dial", "Back");

		Character[playerid][Contact] = GetNumberOwner(number);
		Dialog_Show(playerid, TextMessage, DIALOG_STYLE_INPUT, "Text Message", "กรุณาป้อนหมายเลขที่คุณต้องการที่จะส่งข้อความไป %s:", "Send", "Back", ReturnName(Character[playerid][Contact], 0));
	}
	else {
		cmd_phone(playerid, "\1");
	}
	return 1;
}

Dialog:TextMessage(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		if (isnull(inputtext))
			return Dialog_Show(playerid, TextMessage, DIALOG_STYLE_INPUT, "Text Message", "ข้อผิดพลาด: โปรดป้อนข้อความที่ต้องการส่ง\n\nกรุณาป้อนหมายเลขที่คุณต้องการที่จะส่งข้อความไป %s:", "Send", "Back", ReturnName(Character[playerid][Contact], 0));

		new targetid = Character[playerid][Contact];

		if (!IsPlayerConnected(targetid) || !Character[targetid][Phone])
		    return SystemMsg(playerid, "หมายเลขโทรศัพท์ที่ระบุออฟไลน์อยู่");

		GiveMoney(playerid, -1, "SMS");
		ShowPlayerFooter(playerid, "You've been ~r~charged~w~ $1 to send a text.");

		SendClientMessageEx(targetid, COLOR_YELLOW, "[TEXT]: %s - %s (%d)", inputtext, ReturnName(playerid, 0), Character[playerid][Phone]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "[TEXT]: %s - %s (%d)", inputtext, ReturnName(playerid, 0), Character[playerid][Phone]);

        PlayerPlaySoundEx(targetid, 21001);
		SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s หยิบโทรศัพท์ของเขาขึ้นมาและส่งข้อความ", ReturnName(playerid, 0));
	}
	else {
        Dialog_Show(playerid, SendText, DIALOG_STYLE_INPUT, "Send Text Message", "กรุณาป้อนหมายเลขที่คุณต้องการที่จะส่งข้อความไป:", "Submit", "Back");
	}
	return 1;
}

GetNumberOwner(number)
{
	foreach (new i : Player) if (Character[i][Phone] == number) {
		return i;
	}
	return INVALID_PLAYER_ID;
}

Dialog:MyPhone(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch (listitem)
		{
		    case 0:
		    {
		        if (BitFlag_Get(g_PlayerFlags[playerid],PLAYER_PHONE_OFF))
		            return SystemMsg(playerid, "คุณต้องเปิดเครื่องโทรศัพท์ของคุณ");

				Dialog_Show(playerid, DialNumber, DIALOG_STYLE_INPUT, "Dial Number", "โปรดกรุณาป้อนหมายเลขที่คุณต้องการในการโทรด้านล่าง:", "Dial", "Back");
			}
			case 1:
			{
			    if (BitFlag_Get(g_PlayerFlags[playerid],PLAYER_PHONE_OFF))
		            return SystemMsg(playerid, "คุณต้องเปิดเครื่องโทรศัพท์ของคุณ");

			    ShowContacts(playerid);
			}
		    case 2:
		    {
		        if (BitFlag_Get(g_PlayerFlags[playerid],PLAYER_PHONE_OFF))
		            return SystemMsg(playerid, "คุณต้องเปิดเครื่องโทรศัพท์ของคุณ");

		        Dialog_Show(playerid, SendText, DIALOG_STYLE_INPUT, "Send Text Message", "กรุณาป้อนหมายเลขที่คุณต้องการที่จะส่งข้อความไป:", "Dial", "Back");
			}
			case 3:
			{
			    if (!BitFlag_Get(g_PlayerFlags[playerid],PLAYER_PHONE_OFF))
			    {
           			if (Character[playerid][CallLine] != INVALID_PLAYER_ID) {
			        	CancelCall(playerid);
					}
					BitFlag_On(g_PlayerFlags[playerid],PLAYER_PHONE_OFF);
			        SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้ปิดเครื่องโทรศัพท์ของเขา", ReturnName(playerid, 0));
				}
				else
				{
				    BitFlag_Off(g_PlayerFlags[playerid],PLAYER_PHONE_OFF);
			        SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้เปิดเครื่องโทรศัพท์ของเขา", ReturnName(playerid, 0));
				}
			}
		}
	}
	return 1;
}

forward ConnectRadio(playerid, slot, channel);
public ConnectRadio(playerid, slot, channel)
{
	new string[128];

	if(channel > 0 && slot > 0)
	{
		new done = 0;
		new i = FetchChannelSlot(slot, channel);
		if(i > -1)
		{
			Character[playerid][Channel] = channel;
			Character[playerid][ChannelSlot] = slot;
			format(string, sizeof(string), "คุณได้เชื่อมต่อช่อง: %d สล็อตที่ %d",channel, slot);
 			SendClientMessage(playerid, -1, string);
			done = 1;
		}
		if(!done)
		{

			Character[playerid][Channel] = channel;
			Character[playerid][ChannelSlot] = slot;
			format(string, sizeof(string), "คุณได้เชื่อมต่อช่อง: %d",channel);
 			SendClientMessage(playerid, -1, string);
		}

	}
	else
	{

	    SendClientMessage(playerid, -1, "คุณไม่มีวิทยุ");
	    Character[playerid][Channel] = 0;

	}

}

CMD:rollwindow(playerid, params[])
{
    new item[16];

    new idcar = GetPlayerVehicleID(playerid);
	if (!IsWindowedVehicle(idcar)) return SendClientMessage(playerid, COLOR_GREY, "คุณไม่ได้อยู่ในยานพาหนะใด ๆ ที่มีหน้าต่าง");

  	if(sscanf(params, "s[32]", item)) {
		 	SendClientMessage(playerid, -1, "/rollwindow [item]");
		    SendClientMessage(playerid, COLOR_YELLOW, "[ITEMS]:{FFFFFF} (fl)driver, (fr)passenger, (rl)backleft, (rr)backright");
	}
	else
	{
		new wdriver, wpassenger, wbackleft, wbackright;
		GetVehicleParamsCarWindows(idcar, wdriver, wpassenger, wbackleft, wbackright);

		if(strcmp(item, "fl", true) == 0)
		{
		    if(wdriver == VEHICLE_PARAMS_OFF)
		    {
				SendNearbyMessage(playerid, 30.0, COLOR_RP, "หน้าต่างของรถ %s ฝั่งคนขับถูกปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], ReturnName(playerid, 0));
                ShowPlayerFooter(playerid, "You have ~r~roll up ~w~the driver's side window!");
				SetVehicleParamsCarWindows(idcar, 1, wpassenger, wbackleft, wbackright);
			}
			else if(wdriver == VEHICLE_PARAMS_ON || wdriver == VEHICLE_PARAMS_UNSET)
			{
				SendNearbyMessage(playerid, 30.0, COLOR_RP, "หน้าต่างของรถ %s ฝั่งคนขับถูกเปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], ReturnName(playerid, 0));
                ShowPlayerFooter(playerid, "You have ~g~roll down ~w~the driver's side window!");
				SetVehicleParamsCarWindows(idcar, 0, wpassenger, wbackleft, wbackright);
			}
		}
		if(strcmp(item, "fr", true) == 0)
		{
		    if(wpassenger == VEHICLE_PARAMS_OFF)
		    {
				SendNearbyMessage(playerid, 30.0, COLOR_RP, "หน้าต่างของรถ %s ฝั่งผู้โดยสารถูกปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], ReturnName(playerid, 0));
                ShowPlayerFooter(playerid, "You have ~r~roll up ~w~the passenger's side window!");
				SetVehicleParamsCarWindows(idcar, wdriver, 1, wbackleft, wbackright);
			}
			else if(wpassenger == VEHICLE_PARAMS_ON || wpassenger == VEHICLE_PARAMS_UNSET)
			{
				SendNearbyMessage(playerid, 30.0, COLOR_RP, "หน้าต่างของรถ %s ฝั่งผู้โดยสารถูกเปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], ReturnName(playerid, 0));
                ShowPlayerFooter(playerid, "You have ~g~roll down ~w~the passenger's side window!");
				SetVehicleParamsCarWindows(idcar, wdriver, 0, wbackleft, wbackright);
			}
		}
		if(strcmp(item, "rl", true) == 0)
		{
      		if(wbackleft == VEHICLE_PARAMS_OFF)
		    {
				SendNearbyMessage(playerid, 30.0, COLOR_RP, "หน้าต่างหลังซ้ายของรถ %s ถูกปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], ReturnName(playerid, 0));
                ShowPlayerFooter(playerid, "You have ~r~roll up ~w~the window seat left behind!");
				SetVehicleParamsCarWindows(idcar, wdriver, wpassenger, 1, wbackright);
			}
			else if(wbackleft == VEHICLE_PARAMS_ON || wbackleft == VEHICLE_PARAMS_UNSET)
			{
				SendNearbyMessage(playerid, 30.0, COLOR_RP, "หน้าต่างหลังซ้ายของรถ %s ถูกเปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], ReturnName(playerid, 0));
                ShowPlayerFooter(playerid, "You have ~g~roll down ~w~the window seat left behind!");
				SetVehicleParamsCarWindows(idcar, wdriver, wpassenger, 0, wbackright);
			}
		}
		if(strcmp(item, "rr", true) == 0)
		{
		    if(wbackright == VEHICLE_PARAMS_OFF)
		    {
				SendNearbyMessage(playerid, 30.0, COLOR_RP, "หน้าต่างหลังขวาของรถ %s ถูกปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], ReturnName(playerid, 0));
                ShowPlayerFooter(playerid, "You have ~r~roll up ~w~the window seat right behind!");
				SetVehicleParamsCarWindows(idcar, wdriver, wpassenger, wbackleft, 1);
			}
			else if(wbackright == VEHICLE_PARAMS_ON || wbackright == VEHICLE_PARAMS_UNSET)
			{
				SendNearbyMessage(playerid, 30.0, COLOR_RP, "หน้าต่างหลังขวาของรถ %s ถูกเปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], ReturnName(playerid, 0));
                ShowPlayerFooter(playerid, "You have ~g~roll down ~w~the window seat right behind!");
				SetVehicleParamsCarWindows(idcar, wdriver, wpassenger, wbackleft, 0);
			}
		}
		if(strcmp(item, "all", true) == 0)
		{
		    if(wdriver == VEHICLE_PARAMS_OFF || wpassenger == VEHICLE_PARAMS_OFF || wbackleft == VEHICLE_PARAMS_OFF || wbackright == VEHICLE_PARAMS_OFF)
		    {
		        SendNearbyMessage(playerid, 30.0, COLOR_RP, "หน้าต่างทั้งหมดของรถ %s ถูกปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], ReturnName(playerid, 0));
                ShowPlayerFooter(playerid, "You have ~r~roll up ~w~the window all!");
				SetVehicleParamsCarWindows(idcar, 1, wpassenger, wbackleft, wbackright);
				SetVehicleParamsCarWindows(idcar, wdriver, 1, wbackleft, wbackright);
				SetVehicleParamsCarWindows(idcar, wdriver, wpassenger, 1, wbackright);
				SetVehicleParamsCarWindows(idcar, wdriver, wpassenger, wbackleft, 1);
			}
			else if(wdriver == VEHICLE_PARAMS_ON || wdriver == VEHICLE_PARAMS_UNSET || wpassenger == VEHICLE_PARAMS_ON || wpassenger == VEHICLE_PARAMS_UNSET || wbackleft == VEHICLE_PARAMS_ON || wbackleft == VEHICLE_PARAMS_UNSET || wbackright == VEHICLE_PARAMS_ON || wbackright == VEHICLE_PARAMS_UNSET)
			{
			    SendNearbyMessage(playerid, 30.0, COLOR_RP, "หน้าต่างทั้งหมดของรถ %s ถูกเปิด (( %s ))", g_arrVehicleNames[GetVehicleModel(idcar) - 400], ReturnName(playerid, 0));
                ShowPlayerFooter(playerid, "You have ~r~roll down ~w~the window all!");
				SetVehicleParamsCarWindows(idcar, 0, wpassenger, wbackleft, wbackright);
				SetVehicleParamsCarWindows(idcar, wdriver, 0, wbackleft, wbackright);
                SetVehicleParamsCarWindows(idcar, wdriver, wpassenger, 0, wbackright);
                SetVehicleParamsCarWindows(idcar, wdriver, wpassenger, wbackleft, 0);
			}
		}
	}
	return 1;
}

GetBodyPartName(bodypart)
{
	new name[16];
	switch(bodypart)
	{
		case 3: name = "ลำตัว";
		case 4: name = "หน้าขา";
		case 5: name = "แขนซ้าย";
		case 6: name = "แขนขวา";
		case 7: name = "ขาซ้าย";
		case 8: name = "ขาขวา";
		case 9: name = "หัว";
	}
	return name;
}

GetMoney(playerid)
{
	return (Character[playerid][Cash]);
}

GiveMoney(playerid, amount, const str[], {Float,_}:...)
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

		new old = Character[playerid][Cash], query[256];

		Character[playerid][Cash] += amount;
		GivePlayerMoney(playerid, amount);

		new name[24];
		GetPlayerName(playerid, name, sizeof(name));

		if(old > Character[playerid][Cash])
		{
			format(query, sizeof(query), "INSERT INTO `money_log` (`charid`, `charName`, `reason`, `amount`, `date`) VALUES('%d', '%s', '%s', '%d', '%s')", Character[playerid][ID], name, string, amount*1, ReturnDate());
			mysql_tquery(dbCon, query);

		}
		else
		{
			format(query, sizeof(query), "INSERT INTO `money_log` (`charid`, `charName`, `reason`, `amount`, `date`) VALUES('%d', '%s', '%s', '%d', '%s')", Character[playerid][ID], name, string, amount, ReturnDate());
			mysql_tquery(dbCon, query);
		}
		return 1;
	}

	new old = Character[playerid][Cash], query[256];

	Character[playerid][Cash] += amount;
	GivePlayerMoney(playerid, amount);

	new name[24];
	GetPlayerName(playerid, name, sizeof(name));

	if(old > Character[playerid][Cash])
	{
		format(query, sizeof(query), "INSERT INTO `money_log` (`charid`, `charName`, `reason`, `amount`, `date`) VALUES('%d', '%s', '%s', '%d', '%s')", Character[playerid][ID], name, str, amount*1, ReturnDate());
		mysql_tquery(dbCon, query);

	}
	else
	{
		format(query, sizeof(query), "INSERT INTO `money_log` (`charid`, `charName`, `reason`, `amount`, `date`) VALUES('%d', '%s', '%s', '%d', '%s')", Character[playerid][ID], name, str, amount, ReturnDate());
		mysql_tquery(dbCon, query);
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
	
	Character[playerid][Business] = Character[targetid][Business];
	Character[playerid][Entrance] = Character[targetid][Entrance];
	return 1;
}

public IronMan(playerid)
{
	if(!IsPlayerConnected(playerid))
		return flying[playerid] = 0;

	if(flying[playerid])
	{
	    if(!IsPlayerInAnyVehicle(playerid))
	    {
			new
			    i,
			    keys,
				ud,
				lr,
				Float:x[2],
				Float:y[2],
				Float:z,
				Float:a;

			GetPlayerKeys(playerid, keys, ud, lr);
			GetPlayerVelocity(playerid, x[0], y[0], z);

			if(!GetPlayerWeapon(playerid))
			{
				if((keys & KEY_FIRE) == (KEY_FIRE))
				{
				    i = 0;
				    while(i < MAX_PLAYERS)
				    {
				        if(i != playerid)
				        {
						    GetPlayerPos(i, x[0], y[0], z);
						    if(IsPlayerInRangeOfPoint(playerid, 3.0, x[0], y[0], z))
					        	if(IsPlayerFacingPlayer(playerid, i, 15.0))
					        	    SetPlayerVelocity(i, floatsin(-a, degrees), floatcos(-a, degrees), 0.05);
				        }
						++i;
				    }
				}

	   		}

			if(ud == KEY_UP)
			{
				GetPlayerCameraPos(playerid, x[0], y[0], z);
				GetPlayerCameraFrontVector(playerid, x[1], y[1], z);

				a = SetPlayerToFacePos(playerid, x[0] + x[1], y[0] + y[1]);

		    	ApplyAnimation(playerid, "PARACHUTE", "FALL_SkyDive_Accel", 4.1, 0, 0, 0, 0, 0);
				SetPlayerVelocity(playerid, x[1], y[1], z);
			}
			else
				SetPlayerVelocity(playerid, 0.0, 0.0, 0.01);
		}

		SetTimerEx("IronMan", 100, 0, "d", playerid);
	}

	return 0;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
    if(playerid != INVALID_PLAYER_ID && damagedid != INVALID_PLAYER_ID)
	{
	    if(!Character[damagedid][Injured])
	    {
	      	if(DamageStatus[playerid] == STATE_PENDING_HIT)
	       	{
	         	KillTimer(IssueTimer[damagedid]);
	          	IssueTimer[damagedid] = SetTimerEx("IssueHit", ISSUE_HIT_DELAY, false, "iifi", playerid, damagedid, Float:amount, weaponid, bodypart);
	      	}
	     	else
	       	{
	         	IssueTimer[damagedid] = SetTimerEx("IssueHit", ISSUE_HIT_DELAY, false, "iifi", playerid, damagedid, Float:amount, weaponid, bodypart);
	         	DamageStatus[damagedid] = STATE_PENDING_HIT;
	      	}
	    }
	    if (GetFactionType(playerid) == FACTION_POLICE && BitFlag_Get(g_PlayerFlags[playerid], PLAYER_TAZER) && Character[damagedid][Stunned] < 1 && weaponid == 23)
        {
			if (GetPlayerState(damagedid) != PLAYER_STATE_ONFOOT)
			    return SendClientMessage(playerid, -1, "ผู้เล่นนั้นจะต้องอยู่บนพื้นถึงจะถูกทำให้สลบ");

            if (GetPlayerDistanceFromPlayer(playerid, damagedid) > 10.0)
                return SendClientMessage(playerid, -1, "คุณจะต้องอยู่ใกล้ผู้เล่นนั้นเพื่อจะทำให้สลบ");

            new
                string[64];

			format(string, sizeof(string), "You've been ~r~stunned~w~ by %s.", ReturnName(playerid, 0));

            Character[damagedid][Stunned] = 10;
            TogglePlayerControllable(damagedid, 0);

            ApplyAnimation(damagedid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);
            ShowPlayerFooter(damagedid, string);

			SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้ทำให้ %s สลบด้วย Tazer", ReturnName(playerid, 0), ReturnName(damagedid, 0));
        }
    }
	return 1;
}

forward IssueHit(playerid, damagedid, Float:amount, weaponid, bodypart);
public IssueHit(playerid, damagedid, Float:amount, weaponid, bodypart)
{
    if(DamageStatus[damagedid] == STATE_PENDING_HIT && !Character[damagedid][Injured])
	{
		OnPlayerTakeDamage(damagedid, playerid, Float: amount, weaponid, bodypart);

	}
    return 1;
}

forward HideCrash(playerid);
public HideCrash(playerid)
{

	TextDrawHideForPlayer(playerid,gServerTextdraws[4]);

}

CountPlayerDamage(playerid)
{
	new count = 0;
	for(new i = 0; i < MAX_DAMAGES; i++)
	{
	    if(DamageData[playerid][i][dExists])
			count++;
	}
	return count;
}

forward SetInjuredShoot(playerid);
public SetInjuredShoot(playerid)
{
    Character[playerid][InjuredShoot] = 1;
	return 1;
}

forward SetPlayerInjured(playerid);
public SetPlayerInjured(playerid)
{
	new countdamage, damagestring[96];


	if(IsDamageShow{playerid})
	{
		if(IsValidDynamic3DTextLabel(DamageLabel[playerid])) DestroyDynamic3DTextLabel(DamageLabel[playerid]);
	    DamageLabel[playerid] = Text3D:INVALID_3DTEXT_ID;
  	  	IsDamageShow{playerid} = false;
    }
	if((countdamage = CountPlayerDamage(playerid)) != 0)
	{
		format(damagestring, sizeof(damagestring), "(( ได้รับความบาดเจ็บ %d ครั้ง\n/damages %d สำหรับรายละเอียดเพิ่มเติม \n))", countdamage, playerid);
		DamageLabel[playerid] = CreateDynamic3DTextLabel(damagestring, COLOR_LIGHTRED, 0, 0, 0.68, 10, playerid, INVALID_VEHICLE_ID, 1);
	    IsDamageShow{playerid} = true;
	}
    Character[playerid][Injured] = 1;
    SetTimerEx("SetInjuredShoot", 5000, false, "d", playerid);
    AC_SetPlayerHealth(playerid, 100);
    Character[playerid][InjuredTime] = 5;

    SendClientMessage(playerid, COLOR_YELLOW, "คุณบาดเจ็บอยู่ในขณะนี้กรุณาใช้ /acceptdeath เพื่อยอมตาย");
    GameTextForPlayer(playerid, "you are desynced. ~n~Please avoid moving around and reconnect ~n~asap.", 3000, 6);
    ApplyAnimation(playerid, "PED", "null", 4.0, 0, 0, 0, 1, 0, 1);
	ApplyAnimation(playerid, "PED", "KO_shot_front", 4.0, 0, 0, 0, 1, 0, 1);
	//ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

ResetDamages(playerid)
{
	if(IsValidDynamic3DTextLabel(DamageLabel[playerid])) DestroyDynamic3DTextLabel(DamageLabel[playerid]);
    DamageLabel[playerid] = Text3D:INVALID_3DTEXT_ID;
    IsDamageShow{playerid} = false;

	for(new i = 0; i < MAX_DAMAGES; i++)
	{
	    DamageData[playerid][i][dExists] = false;
		DamageData[playerid][i][dSec] = 0;
		DamageData[playerid][i][dDamage] = 0;
		DamageData[playerid][i][dShotType] = 0;
		DamageData[playerid][i][dWeaponid] = 0;
		DamageData[playerid][i][dArmour] = 0;
	}
	return 1;
}

public Float:SetPlayerToFacePos(playerid, Float:X, Float:Y)
{
	new
		Float:pX,
		Float:pY,
		Float:pZ,
		Float:ang;

	if(!IsPlayerConnected(playerid)) return 0.0;

	GetPlayerPos(playerid, pX, pY, pZ);

	if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	if(X > pX) ang = (floatabs(floatabs(ang) + 180.0));
	else ang = (floatabs(ang) - 180.0);

	ang += 180.0;

	SetPlayerFacingAngle(playerid, ang);

 	return ang;
}

public DestroyMe(objectid)
{
	return DestroyDynamicObject(objectid);
}

IsPlayerInBank(playerid)
{
	new
		id = -1;

	if ((id = Entrance_Inside(playerid)) != -1 && EntranceData[id][entranceType] == 2)
	    return 1;

	return 0;
}

Dialog:Savingswithdraw(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    Character[playerid][Cash] += Character[playerid][Savings];
	    GivePlayerMoney(playerid, Character[playerid][Savings]);
        Character[playerid][Savings] = 0;
	}
	return 1;
}

Dialog:TeleportInterior(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    SetPlayerInterior(playerid, g_arrInteriorData[listitem][e_InteriorID]);
	    SetPlayerPosEx(playerid, g_arrInteriorData[listitem][e_InteriorX], g_arrInteriorData[listitem][e_InteriorY], g_arrInteriorData[listitem][e_InteriorZ],g_arrInteriorData[listitem][e_InteriorID],0);
	}
	return 1;
}

stock IsVehicleSeatUsed(vehicleid, seat)
{
	foreach (new i : Player) if (IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) == seat) {
	    return 1;
	}
	return 0;
}

stock GetVehicleMaxSeats(vehicleid)
{
    new const g_arrMaxSeats[] = {
		4, 2, 2, 2, 4, 4, 1, 2, 2, 4, 2, 2, 2, 4, 2, 2, 4, 2, 4, 2, 4, 4, 2, 2, 2, 1, 4, 4, 4, 2,
		1, 7, 1, 2, 2, 0, 2, 7, 4, 2, 4, 1, 2, 2, 2, 4, 1, 2, 1, 0, 0, 2, 1, 1, 1, 2, 2, 2, 4, 4,
		2, 2, 2, 2, 1, 1, 4, 4, 2, 2, 4, 2, 1, 1, 2, 2, 1, 2, 2, 4, 2, 1, 4, 3, 1, 1, 1, 4, 2, 2,
		4, 2, 4, 1, 2, 2, 2, 4, 4, 2, 2, 1, 2, 2, 2, 2, 2, 4, 2, 1, 1, 2, 1, 1, 2, 2, 4, 2, 2, 1,
		1, 2, 2, 2, 2, 2, 2, 2, 2, 4, 1, 1, 1, 2, 2, 2, 2, 7, 7, 1, 4, 2, 2, 2, 2, 2, 4, 4, 2, 2,
		4, 4, 2, 1, 2, 2, 2, 2, 2, 2, 4, 4, 2, 2, 1, 2, 4, 4, 1, 0, 0, 1, 1, 2, 1, 2, 2, 1, 2, 4,
		4, 2, 4, 1, 0, 4, 2, 2, 2, 2, 0, 0, 7, 2, 2, 1, 4, 4, 4, 2, 2, 2, 2, 2, 4, 2, 0, 0, 0, 4,
		0, 0
	};
	new
	    model = GetVehicleModel(vehicleid);

	if (400 <= model <= 611)
	    return g_arrMaxSeats[model - 400];

	return 0;
}

stock IsTaskCompleted(playerid)
{
	if ((Character[playerid][Task] > 0) && (Character[playerid][BankTask] > 0 && Character[playerid][StoreTask] > 0 && Character[playerid][TestTask] > 0))
	    return 1;

	return 0;
}

stock GetAvailableSeat(vehicleid, start = 1)
{
	new seats = GetVehicleMaxSeats(vehicleid);

	for (new i = start; i < seats; i ++) if (!IsVehicleSeatUsed(vehicleid, i)) {
	    return i;
	}
	return -1;
}

stock ResetVehicleDamage(vehicleid)
{

	new slot = Car_GetID(vehicleid);
	if(slot > -1 && CarData[slot][carOwner] > 0)
	{

		CarData[slot][carDamage][0] = 0;
		CarData[slot][carDamage][1] = 0;
		CarData[slot][carDamage][2] = 0;
		CarData[slot][carDamage][3] = 0;
		CarData[slot][carHealth] = CarData[slot][carHealth];
	}
}

stock IsPoliceCar(vehicleid)
{
	switch (GetVehicleModel(vehicleid))
 	{
	    case 541, 596, 597, 598, 599: return 1;
	}
	return 0;
}

stock RemovePlayerWeapon(playerid, weaponid)
{
    return SetPlayerAmmo(playerid, weaponid, 0);
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{

	return 1;
}

forward CloseInfo(playerid);
public CloseInfo(playerid)
{
	TextDrawHideForPlayer(playerid, InfoBox[playerid]);
	return 1;
}

forward SpawnInjured(playerid);
public SpawnInjured(playerid)
{
    if(Character[playerid][Injured] == 0)
 	{
		Character[playerid][InjuredSpawn] = 0;
		AC_SetPlayerHealth(playerid, 100);
		TogglePlayerControllable(playerid, false);
		SetTimerEx("UnControl", 2000, false, "d", playerid);
 	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new vehicleid = GetPlayerVehicleID(playerid);

	new carid = Car_GetID(vehicleid);

	if(newstate == PLAYER_STATE_WASTED)
	{
		if(Character[playerid][Injured] == 0)
		{
			Character[playerid][Injured] = 1;
			new Float:X,Float:Y,Float:Z,Float:A;
			GetPlayerPos(playerid, X, Y, Z);
			GetPlayerFacingAngle(playerid, A);
			Character[playerid][Playerdepos][0] = X;
			Character[playerid][Playerdepos][1] = Y;
			Character[playerid][Playerdepos][2] = Z;
			Character[playerid][Playerdepos][3] = A;
			Character[playerid][PlayerdeInt] = GetPlayerInterior(playerid);
			Character[playerid][PlayerdeWorld] = GetPlayerVirtualWorld(playerid);

		}
		else if(Character[playerid][Injured] == 1)
		{
			Character[playerid][Injured] = 0;
			Character[playerid][InjuredEx] = 0;
			Character[playerid][InjuredSpawn] = 1;
			Character[playerid][InjuredShoot] = 0;
		}
	}

    if (newstate == PLAYER_STATE_DRIVER)
	{
		if(Character[playerid][MecType])
		{
			Character[playerid][MecType] = 0;
			Character[playerid][MecStep] = 0;
			Character[playerid][MecPrice] = 0;
			Character[playerid][MecCol1] = 0;
			Character[playerid][MecCol2] = 0;
			Character[playerid][MecCar] = INVALID_VEHICLE_ID;
			Character[playerid][MecTow] = INVALID_VEHICLE_ID;
			ResetWeapon(playerid, 41);
		}
	}
	
	if (oldstate == PLAYER_STATE_DRIVER)
	{
	    if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CARRY || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED)
	        return RemoveFromVehicle(playerid);

		if(Character[playerid][MecStep] == 1)
		{
		    Character[playerid][MecStep] = 2;
		    ShowPlayerFooter(playerid, "~p~Start spraying the vehicle.");
		}
		//PlayerTextDrawHide(playerid, Character[playerid][pTextdraws][82]);


		///SyncCamera(playerid);
	}
	
    if (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
	    if (Character[playerid][Boombox] != INVALID_PLAYER_ID)
	    {
	        Character[playerid][Boombox] = INVALID_PLAYER_ID;
			StopAudioStreamForPlayer(playerid);
	    }
	}

	if (newstate == PLAYER_STATE_DRIVER)
	{
		if (IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
		    if(CoreVehicles[vehicleid][vehTemporary] == 1)
		        return 1;

		    for(new i = 0; i < sizeof dmv_vehicles; i++) if(GetPlayerVehicleID(playerid) == dmv_vehicles[i])
				return SendClientMessage(playerid, -1, "คุณอยู่ในรถทำใบขับขี่, ใช้ /licenseexam เพื่อเริ่มทดสอบ.");

		    if (!IsEngineVehicle(vehicleid))
				return SetEngineStatus(vehicleid, true);

		    if (!GetEngineStatus(vehicleid))
				return SendClientMessage(playerid, COLOR_GREEN, "เครื่องยนต์ดับอยู่ (/engine)");

			if(Car_IsOwner(playerid, carid))
			{
			    if (IsSpeedoVehicle(vehicleid))
	    		{
					PlayerTextDrawShow(playerid, Speedo[playerid]);
					return SendClientMessageEx(playerid, COLOR_WHITE, "ยินดีต้อนรับเข้าสู่ %s ของคุณ", ReturnVehicleName(vehicleid));
				}
				return 1;
			}

            PlayerTextDrawShow(playerid, Speedo[playerid]);

			if(CarData[carid][carRent] == 1)
		    {
		        if(CarRent_IsOwner(playerid, carid))
				{
		            SendClientMessage(playerid, -1, "ยินดีต้อนรับสู่รถเช่าของคุณ!");
		        }
		        else
		        {
		            if(CarData[carid][carRented] == 1)
				    	return SendClientMessage(playerid, -1, "รถคันนี้มีคนเช่าแล้ว!");

			        SendClientMessageEx(playerid, -1, "บริการเช่ายานพาหนะ: เช่า %s ในราคา $2,500 (/rentvehicle)", ReturnVehicleName(vehicleid));
			        SendClientMessage(playerid, COLOR_GREEN, "การเช่ายานพาหนะคุณจะสามารถ /lock มันได้");
				}
		    }
		}
	}
	
	if(!IsPlayerInAnyVehicle(playerid))
	{
	    PlayerTextDrawHide(playerid, Speedo[playerid]);
	}

	if (newstate == PLAYER_STATE_ONFOOT)
	{
		for(new i; i < MAX_PLAYERS; i++)
		{
		    if(IsPlayerConnected(i) && Character[i][IsSpec] == playerid)
		    {
		        PlayerSpectatePlayer(i, playerid);
		        break;
			}
		}

		StopAudioStreamForPlayer(playerid);
		
	}
	if ((newstate == PLAYER_STATE_PASSENGER || newstate == PLAYER_STATE_DRIVER) && oldstate == PLAYER_STATE_ONFOOT)
	{
		for(new i; i < MAX_PLAYERS; i++)
		{
		    if(IsPlayerConnected(i) && Character[i][IsSpec] == playerid)
		    {
		        PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));
		        break;
			}
		}
	}
	return 1;
}

stock GetAccessoryNameByModel(model)
{
	new
	    name[32];

	for (new i = 0; i < sizeof(g_aAccessoryData); i ++) if (g_aAccessoryData[i][e_AccessoryModel] == model) {
		strcat(name, g_aAccessoryData[i][e_AccessoryName]);

		break;
	}
	return name;
}


public OnModelSelectionResponse(playerid, extraid, index, modelid, response)
{
	new
	    string[128];

    if ((response) && (extraid == MODEL_SELECTION_SKINS))
	{
	    Dialog_Show(playerid, FactionSkin, DIALOG_STYLE_LIST, "Edit Skin", "เพิ่มโดยไอดีโมเดล\nล้างช่องนี้", "Select", "Cancel");
	    Character[playerid][SelectedSlot] = index;
	}
	if ((response) && (extraid == MODEL_SELECTION_ADD_SKIN))
	{
	    FactionData[Character[playerid][FactionEdit]][factionSkins][Character[playerid][SelectedSlot]] = modelid;
		Faction_Save(Character[playerid][FactionEdit]);

		format(string, sizeof(string), "คุณปรับสกินไอดีในช่อง %d เป็น %d", Character[playerid][SelectedSlot], modelid);
	    SendClientMessage(playerid, -1, string);
	}
	if ((response) && (extraid == MODEL_SELECTION_FACTION_SKIN))
	{
	    new factionid = Character[playerid][Faction];

		if (factionid == -1 || !IsNearFactionLocker(playerid))
	    	return 0;

		if (modelid == 19300)
		    return SendClientMessage(playerid, -1, "ไม่มีสกินนี้ในช่องที่เลือก");

  		SetPlayerSkin(playerid, modelid);
	}
	
	if ((response) && (extraid == MODEL_SELECTION_CLOTHES))
	{
	    new
			bizid = -1,
			price;

	    if ((bizid = Business_Inside(playerid)) == -1 || BusinessData[bizid][bizType] != 3)
	        return 0;

		if (BusinessData[bizid][bizProducts] < 1)
		    return SendClientMessage(playerid, -1,"ธุรกิจนี้สินค้าหมด");

	    price = BusinessData[bizid][bizPrices][Character[playerid][ClothesType] - 1];

	    if (GetMoney(playerid) < price)
	        return SendClientMessage(playerid, -1,"คุณมีเงินไม่พอสำหรับการซื้อ");

		GiveMoney(playerid, -price, "buy clothes from biz %d", bizid);

		BusinessData[bizid][bizProducts]--;
		BusinessData[bizid][bizVault] += Tax_Percent(price);

		Business_Save(bizid);
		Tax_AddPercent(price);

	    switch (Character[playerid][ClothesType])
	    {
			case 2:
			{
			    //SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จ่าย %s และได้รับเครื่องประดับบางอย่าง", ReturnName(playerid, 0), FormatNumber(price));
				RemovePlayerAttachedObject(playerid, 0);
				SendClientMessage(playerid, -1, "รอการอัพเดท!!");
                //Inventory_Add(playerid, GetAccessoryNameByModel(modelid), modelid, 1);

                //format(string, sizeof(string), "Your ~p~%s~w~ was added to your inventory.", GetAccessoryNameByModel(modelid));
				//ShowPlayerFooter(playerid, string);
			}
			case 3:
			{
			    //SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จ่าย %s และได้รับเครื่องประดับบางอย่าง", ReturnName(playerid, 0), FormatNumber(price));
                RemovePlayerAttachedObject(playerid, 1);

				//Inventory_Add(playerid, GetAccessoryNameByModel(modelid), modelid, 1);
                SendClientMessage(playerid, -1, "รอการอัพเดท!!");
                //format(string, sizeof(string), "Your ~p~%s~w~ was added to your inventory.", GetAccessoryNameByModel(modelid));
				//ShowPlayerFooter(playerid, string);
			}
			case 4:
			{
			    //SendNearbyMessage(playerid, 30.0, COLOR_RP, "** %s ได้จ่าย %s และได้รับเครื่องประดับบางอย่าง", ReturnName(playerid, 0), FormatNumber(price));
			    RemovePlayerAttachedObject(playerid, 2);

			    //Inventory_Add(playerid, GetAccessoryNameByModel(modelid), modelid, 1);
                SendClientMessage(playerid, -1, "รอการอัพเดท!!");
                //format(string, sizeof(string), "Your ~p~%s~w~ was added to your inventory.", GetAccessoryNameByModel(modelid));
				//ShowPlayerFooter(playerid, string);
			}
	    }
	}
	if ((response) && (extraid == MODEL_SELECTION_FURNITURE))
	{
        new
			id = Business_Inside(playerid),
			type = Character[playerid][FurnitureType],
			price;

	    if (id != -1 && BusinessData[id][bizExists] && BusinessData[id][bizType] == 7)
	    {
	        price = BusinessData[id][bizPrices][type];

	        if (GetMoney(playerid) < price)
	            return SendClientMessage(playerid, -1, "คุณมีเงินไม่พอที่จะซื้อ");

			if (BusinessData[id][bizProducts] < 1)
		    	return SendClientMessage(playerid, -1, "ธุรกิจนี้สินค้าหมด");

			new item = Inventory_Add(playerid, GetFurnitureNameByModel(modelid), modelid);

            if (item == -1)
   	        	return SendClientMessage(playerid, -1, "คุณไม่เหลือช่องว่างในช่องเก็บของแล้ว");

			GiveMoney(playerid, -price, "buy furniture from biz %d", id);
			SendClientMessageEx(playerid, -1, "คุณได้ซื้อ \"%s\" ราคา %s", GetFurnitureNameByModel(modelid), FormatNumber(price));

			BusinessData[id][bizProducts]--;
			BusinessData[id][bizVault] += Tax_Percent(price);

			Business_Save(id);
			Tax_AddPercent(price);
	    }
	}
	if ((extraid == MODEL_SELECTION_INVENTORY && response) && InvFurnitureData[playerid][index][invExists])
	{
	    new
	        name[48];

		strunpack(name, InvFurnitureData[playerid][index][invItem]);
	    Character[playerid][InventoryItem] = index;

	    switch (Character[playerid][StorageSelect])
		{
		    default:
			{
  				format(name, sizeof(name), "%s (%d)", name, InvFurnitureData[playerid][index][invQuantity]);

                Dialog_Show(playerid, Inventory, DIALOG_STYLE_LIST, name, "เปิดใช้งานเฟอร์นิเจอร์\nทิ้งเฟอร์นิเจอร์", "ตกลง", "ยกเลิก");
			}
		}

	}
	return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	if (response)
	{
	   	if(GetPVarInt(playerid, "AttachEdit") == 1)
	   	{
   			DeletePVar(playerid, "AttachEdit");
        	SetPlayerAttachedObject(playerid, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ);
			printf("SetPlayerAttachedObject(%d,%d,%d,%d,%f,%f,%f,%f,%f,%f,%f,%f,%f);", playerid, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ);
		}
		/*if (Character[playerid][pEditType] != 0)
 		{
 		    if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_ONDUTY))
 		    {
	 		    new slot = Character[playerid][pEditType]-1;

	 		    AccessoryData[playerid][slot][0] = fOffsetX;
	       		AccessoryData[playerid][slot][1] = fOffsetY;
	         	AccessoryData[playerid][slot][2] = fOffsetZ;

	          	AccessoryData[playerid][slot][3] = fRotX;
	           	AccessoryData[playerid][slot][4] = fRotY;
	           	AccessoryData[playerid][slot][5] = fRotZ;

	            AccessoryData[playerid][slot][6] = fScaleX;
	            AccessoryData[playerid][slot][7] = fScaleY;
				AccessoryData[playerid][slot][8] = fScaleZ;

			 	Character[playerid][pEditType] = 0;
			  	Character[playerid][pAccessory][slot] = modelid;

			 	SendClientMessage(playerid, -1, "คุณได้ทำการยืนยันเครื่องประดับของคุณ");

			 	SetPlayerAttachedObject(playerid, slot, Character[playerid][pAccessory][slot], AccessoryBone[playerid][slot], AccessoryData[playerid][slot][0], AccessoryData[playerid][slot][1], AccessoryData[playerid][slot][2], AccessoryData[playerid][slot][3], AccessoryData[playerid][slot][4], AccessoryData[playerid][slot][5], AccessoryData[playerid][slot][6], AccessoryData[playerid][slot][7], AccessoryData[playerid][slot][8]);
	            SQL_SaveAccessories(playerid);
            }
            else
            {
	 		    new slot = Character[playerid][pEditType]-1;

	 		    DutyAccessoryData[playerid][slot][0] = fOffsetX;
	       		DutyAccessoryData[playerid][slot][1] = fOffsetY;
	         	DutyAccessoryData[playerid][slot][2] = fOffsetZ;

	          	DutyAccessoryData[playerid][slot][3] = fRotX;
	           	DutyAccessoryData[playerid][slot][4] = fRotY;
	           	DutyAccessoryData[playerid][slot][5] = fRotZ;

	            DutyAccessoryData[playerid][slot][6] = fScaleX;
	            DutyAccessoryData[playerid][slot][7] = fScaleY;
				DutyAccessoryData[playerid][slot][8] = fScaleZ;

			 	Character[playerid][pEditType] = 0;
			  	DutyAccessory[playerid][slot] = modelid;

			 	SendClientMessage(playerid, -1, "คุณได้ทำการยืนยันเครื่องประดับของคุณ");

			 	SetPlayerAttachedObject(playerid, slot, DutyAccessory[playerid][slot], DutyAccessoryBone[playerid][slot], DutyAccessoryData[playerid][slot][0], DutyAccessoryData[playerid][slot][1], DutyAccessoryData[playerid][slot][2], DutyAccessoryData[playerid][slot][3], DutyAccessoryData[playerid][slot][4], DutyAccessoryData[playerid][slot][5], DutyAccessoryData[playerid][slot][6], DutyAccessoryData[playerid][slot][7], DutyAccessoryData[playerid][slot][8]);
            }
		}*/
	}
	return 1;
}


stock IsKeyJustDown(key, newkeys, oldkeys) {
	if((newkeys & key) && !(oldkeys & key))
		return 1;

	return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(LoopAnim[playerid])
	{
		if(PRESSED(KEY_HANDBRAKE)) 
		{
		    StopLoopingAnim(playerid);
	        //TextDrawHideForPlayer(playerid,AnimText[playerid]);
	    }
    }
    
	if(newkeys == KEY_CTRL_BACK)
	{
		if(UseUserControl[playerid] == 0)
		{
			UseUserControl[playerid] = 1;
			SelectTextDraw(playerid, 0x10C605AA);
			ShowUserControl(playerid);

			SendClientMessage(playerid, COLOR_YELLOW, "[HINT]: {FFFFFF}หากต้องการปิดให้กด {F20303}'X' {FFFFFF}หรือ กด ESC เพื่อปิดเมาส์และกด {F20303}'H' {FFFFFF}อีกครั้งเพื่อปิด");
		}
		else if(UseUserControl[playerid] == 1)
		{
			UseUserControl[playerid] = 0;
			CancelSelectTextDraw(playerid);
			HideUserControl(playerid);
		}
	}

    if(newkeys == KEY_YES)
    {
		new idplant = -1;
		if ((idplant = Plant_Nearest(playerid)) != -1)
		{
			if(PlantData[idplant][plantUse] == 1)
				return ErrorMsg(playerid, "ต้นนี้มีผู้เล่นใช้งานอยู่");

			PlantData[idplant][plantUse] = 1;
			SetPVarInt(playerid, "Plantid", idplant);
			Dialog_Show(playerid, ManagePlant, DIALOG_STYLE_LIST, "จัดการพืช", "> รายละเอียดเกี่ยวกับพืชต้นนี้\n> รดน้ำ\n> เก็บเกี่ยว\n> ถอนราก", "เลือก", "ยกเลิก");
		}

		new
			id = -1,
			string[128];

		if ((id = House_Nearest(playerid)) != -1)
		{
			if (HouseData[id][houseLocked])
				return SendClientMessage(playerid, -1, "คุณไม่สามารถเข้าบ้านที่ล็อคได้");

			SetPlayerPosEx(playerid, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2], HouseData[id][houseInterior], HouseData[id][houseID] + 5000);
			SetPlayerFacingAngle(playerid, HouseData[id][houseInt][3]);

			SetCameraBehindPlayer(playerid);
			Character[playerid][House] = HouseData[id][houseID];
			return 1;
		}

		if ((id = Entrance_Nearest(playerid)) != -1)
		{
			if (EntranceData[id][entranceLocked])
				return SendClientMessage(playerid, -1, "ทางเข้านี้ถูกล็อคในขณะนี้");

			if (Character[playerid][Task])
			{
				if (EntranceData[id][entranceType] == 2 && !Character[playerid][BankTask])
				{
					Character[playerid][BankTask] = 1;
					Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Banking", "เป็นหนึ่งใน Bank ของ San Andreas คุณสามารถจัดการกับบัญชีธนาคารคุณได้ที่นี่\nผู้เล่นแต่ละคนมีบัญชีธนาคารที่มีมาตรฐานและการฝากเงินเพื่อจะได้รับเงินพิเศษ\n\nคุณสามารถใช้ /bank ข้างในอาคารเพื่อจัดการอะไรบางอย่างเกี่ยวบัญชีของคุณ\nหากคุณอยู่ใกล้เครื่อง ATM คุณสามารถใช้ /atm เพื่อดูคำสั่งที่คุณต้องการ", "Close", "");

					if (IsTaskCompleted(playerid))
					{
						Character[playerid][Task] = 0;
					}
				}
				else if (EntranceData[id][entranceType] == 1 && !Character[playerid][TestTask])
				{
					Character[playerid][TestTask] = 1;
					Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "DMV", "DMV เป็นที่ที่ผู้เล่นพยายามที่จะทดสอบการขับขี่เพื่อจะได้รับใบอนุญาต\nคุณจะต้องหลบหลีกสิ่งกีดขวางความเสียหายหรือความเร็วในขณะที่ทดสอบ\n\nมันถูกต้องตามกฎหมายตามและใบขับขี่เป็นที่ยอมรับกันใน San Andreas\nการขับขี่โดยไม่มีใบอนุญาตมีผลกระทบหลายอย่างโดยเฉพาะกฎหมาย", "Close", "");

					if (IsTaskCompleted(playerid))
					{
						Character[playerid][Task] = 0;
					}
				}

				if (EntranceData[id][entranceType] == 2)
				{
					SendClientMessage(playerid, COLOR_GREEN, "Bank: /bank /withdraw /balance");
				}
			}
			if (EntranceData[id][entranceCustom])
				SetPlayerPosExten(playerid, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2]);

			else
				SetPlayerPosEx(playerid, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2], EntranceData[id][entranceInterior], EntranceData[id][entranceWorld]);

			SetPlayerFacingAngle(playerid, EntranceData[id][entranceInt][3]);

			SetCameraBehindPlayer(playerid);
			Character[playerid][Entrance] = EntranceData[id][entranceID];

			format(string, sizeof(string), "~w~%s", EntranceData[id][entranceName]);
			GameTextForPlayer(playerid, string, 3000, 1);
			return 1;
		}
		if ((id = Business_Nearest(playerid)) != -1)
		{
			if (BusinessData[id][bizLocked])
				return SendClientMessage(playerid, -1, "ธุรกิจถูกปิดโดยเจ้าของ");

			if (Character[playerid][Task] && !Character[playerid][StoreTask])
			{
				Character[playerid][StoreTask] = 1;
				Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Retail Store", "ธุรกิจนี้เป็น Retail Store คุณสามารถซื้อของได้หลากหลายโดยใช้คำสั่ง /buy \nมีสิ่งที่มีประโยชน์ที่คุณสามารถซื้อได้ที่นี่ ซึ่งจะถูกเพิ่มเข้าไปในช่องเก็บของของคุณ\n\nสินค้าที่มีประโยชน์ที่สุดคือ GPS System, ซึ่งจะพาขึ้นไปในที่ต่าง ๆ ได้\nคุณสามารถออกจากธุรกิจนี้ได้ตลอดเวลาโดยพิมพ์ /exit ที่ประตู", "Close", "");

				if (IsTaskCompleted(playerid))
				{
					Character[playerid][Task] = 0;
				}
			}

			if(BusinessData[id][bizInt][0] == 0.0 && BusinessData[id][bizInt][1] == 0.0 && BusinessData[id][bizType] == 8)
			{
				return Business_PurchaseMenu(playerid, id);
			}

			if(BusinessData[id][bizType] == 5)
			{
				SendClientMessage(playerid, -1, "กรุณาใช้ '/v buy' เพื่อซื้อ");
				return 1;
			}

			SetPlayerPosEx(playerid, BusinessData[id][bizInt][0], BusinessData[id][bizInt][1], BusinessData[id][bizInt][2],BusinessData[id][bizInterior], BusinessData[id][bizID] + 6000);
			SetPlayerFacingAngle(playerid, BusinessData[id][bizInt][3]);

			SetCameraBehindPlayer(playerid);
			Character[playerid][Business] = BusinessData[id][bizID];

			if (strlen(BusinessData[id][bizMessage]) && strcmp(BusinessData[id][bizMessage], "NULL", true)) {
				SendClientMessage(playerid, COLOR_YELLOW, BusinessData[id][bizMessage]);
			}

			format(string, sizeof(string), "~w~%s", BusinessData[id][bizName]);
			GameTextForPlayer(playerid, string, 3000, 1);
			return 1;
		}

		if ((id = House_Inside(playerid)) != -1 && IsPlayerInRangeOfPoint(playerid, 2.5, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2]))
		{
			SetPlayerPosEx(playerid, HouseData[id][housePos][0], HouseData[id][housePos][1], HouseData[id][housePos][2], HouseData[id][houseExterior], HouseData[id][houseExteriorVW]);
			SetPlayerFacingAngle(playerid, HouseData[id][housePos][3] - 180.0);

			SetCameraBehindPlayer(playerid);
			Character[playerid][House] = -1;
			return 1;
		}

		if ((id = Entrance_NearestInside(playerid)) != -1 && IsPlayerInRangeOfPoint(playerid, 2.5, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2]))
		{
			if (EntranceData[id][entranceCustom])
				SetPlayerPosExten(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2]);

			else
			SetPlayerPosEx(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2], EntranceData[id][entranceExterior], EntranceData[id][entranceExteriorVW]);

			SetPlayerFacingAngle(playerid, EntranceData[id][entrancePos][3] - 180.0);

			SetCameraBehindPlayer(playerid);
			Character[playerid][Entrance] = Entrance_GetLink(playerid);
			return 1;
		}
		if ((id = Business_Inside(playerid)) != -1 && IsPlayerInRangeOfPoint(playerid, 2.5, BusinessData[id][bizInt][0], BusinessData[id][bizInt][1], BusinessData[id][bizInt][2]))
		{
			SetPlayerPosEx(playerid, BusinessData[id][bizPos][0], BusinessData[id][bizPos][1], BusinessData[id][bizPos][2],BusinessData[id][bizExterior],BusinessData[id][bizExteriorVW]);
			SetPlayerFacingAngle(playerid, BusinessData[id][bizPos][3] - 180.0);

			SetCameraBehindPlayer(playerid);
			Character[playerid][Business] = -1;
			return 1;
		}
    }
    
    /*if (newkeys & KEY_NO)//H
	{
	if (factionid != -1 && FactionData[factionid][factionExists])
	{
	    if (FactionData[factionid][factionLockerPos][0] != 0.0 && FactionData[factionid][factionLockerPos][1] != 0.0 && FactionData[factionid][factionLockerPos][2] != 0.0)
	    {
		    new
		        string[128];

			if (IsValidDynamicPickup(FactionData[factionid][factionPickup]))
			    DestroyDynamicPickup(FactionData[factionid][factionPickup]);

			if (IsValidDynamic3DTextLabel(FactionData[factionid][factionText3D]))
			    DestroyDynamic3DTextLabel(FactionData[factionid][factionText3D]);

			FactionData[factionid][factionPickup] = CreateDynamicPickup(1239, 23, FactionData[factionid][factionLockerPos][0], FactionData[factionid][factionLockerPos][1], FactionData[factionid][factionLockerPos][2], FactionData[factionid][factionLockerWorld], FactionData[factionid][factionLockerInt]);

			format(string, sizeof(string), "[Locker %s]", FactionData[factionid][factionName]);
	  		FactionData[factionid][factionText3D] = CreateDynamic3DTextLabel(string, COLOR_ORANGE, FactionData[factionid][factionLockerPos][0], FactionData[factionid][factionLockerPos][1], FactionData[factionid][factionLockerPos][2], 15.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, FactionData[factionid][factionLockerWorld], FactionData[factionid][factionLockerInt]);
		}
	  }
	}*/
    
    if(newkeys == KEY_NO)
    {
		new id = -1;
		if ((id = Field_Nearest(playerid)) != -1)
		{
			if (id != -1 && Field_IsOwner(playerid, id))
			{
				SetPVarInt(playerid, "Fieldid", id);
				Dialog_Show(playerid, ManageField, DIALOG_STYLE_LIST, "จัดการที่ดิน", "เช็คที่ดิน\nขายที่ดิน", "เลือก", "ยกเลิก");
				//SendClientMessageEx(playerid, COLOR_RED, "{FFD502}สวัสดีครับผมชื่อ {FF0202}Justinz {02FFFF}ที่ดินแปลงนี้เป็นของคุณแล้วนะครับ {03D300}Good Bye!");
			}
			else{
				if(!FieldData[id][fieldOwner])
				{
					SetPVarInt(playerid, "Fieldid", id);
					new head[128];
					format(head, sizeof(head), "ซื้อที่ดินไอดี: %d", id);
					Dialog_Show(playerid, BuyField, DIALOG_STYLE_LIST, head, "เช็คระยะของที่เดิน\nซื้อที่เดินนี้", "เลือก", "ยกเลิก");
				}
				else{
					SendClientMessageEx(playerid, COLOR_RED, "[!] ที่ดินนี้เป็นของ: %s", FieldData[id][fieldOwner] ? GetIDFromName(FieldData[id][fieldOwner]) : ("ไม่มีเจ้าของ"));
				}
			}
		}
	}
    if(PRESSED(KEY_FIRE))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	    {
	
		}
	}
    
    
    if(IsKeyJustDown(KEY_WALK, newkeys, oldkeys)) 
	{
		if(Character[playerid][Spectating] != INVALID_PLAYER_ID && Account[playerid][Admin] >= 1 || GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) {

			Character[playerid][Spectating] = INVALID_PLAYER_ID;
            SetPlayerColor(playerid, COLOR_WHITE);
		    TogglePlayerSpectating(playerid, false);
		    SetPlayerPosEx(playerid, Character[playerid][PosX], Character[playerid][PosY], Character[playerid][PosZ],Character[playerid][Interior], Character[playerid][VWorld]);
            SetCameraBehindPlayer(playerid);

		    TextDrawHideForPlayer(playerid, textdrawVariables[0]);
			return 1;
		}
    }
	return 1;
}

forward EnterExitTimer(playerid);
public EnterExitTimer(playerid)
{
	return 1;
}

stock CreateSpacer(playerid, lines)
{
	for(new i = 0; i < lines; i++)
	{
	    SendClientMessage(playerid, COLOR_WHITE, "");
	}
	return 1;
}


forward MYSQL_Update_String(sqlid, table[], column[], str[]);
public MYSQL_Update_String(sqlid, table[], column[], str[])
{
	new query[280];
    mysql_format(dbCon, query, sizeof(query), "UPDATE `%s` SET `%s` = '%s' WHERE SQLID = %d LIMIT 1", table, column, str, sqlid);
	mysql_tquery(dbCon, query);
	return 1;
}

forward MYSQL_Update_Interger(sqlid, table[], column[], interger);
public MYSQL_Update_Interger(sqlid, table[], column[], interger)
{
	new query[280];
    mysql_format(dbCon, query, sizeof(query), "UPDATE `%s` SET `%s` = %d WHERE SQLID = %d LIMIT 1", table, column, interger, sqlid);
	mysql_tquery(dbCon, query);
	return 1;
}

forward MYSQL_Update_Float(sqlid, table[], column[], Float:interger);
public MYSQL_Update_Float(sqlid, table[], column[], Float:interger)
{
	new query[280];
    mysql_format(dbCon, query, sizeof(query), "UPDATE `%s` SET `%s` = %f WHERE SQLID = %d LIMIT 1", table, column, interger, sqlid);
	mysql_tquery(dbCon, query);
	return 1;
}

MYSQL_Update_Character(playerid, option1[], option2)
{
	new query[128];
    mysql_format(dbCon, query, sizeof(query), "UPDATE Characters SET %s = %d WHERE ID = %d LIMIT 1", option1, option2, Character[playerid][ID]);
	mysql_tquery(dbCon, query);
	return 1;
}

/*CMD:pvars(playerid)
{
	for(new i; pinfo:i < pinfo; i++)
	{
    	SendClientMessage(playerid, COLOR_WHITE, Character[playerid][pinfo:i]);
	}
	return 1;
}*/

Account_Reset(playerid)
{
	for(new i; acc:i < acc; i++)
	{
    	Account[playerid][acc:i] = 0;
	}
	return 1;
}

Character_Reset(playerid)
{
	for(new i; pinfo:i < pinfo; i++)
	{
    	Character[playerid][pinfo:i] = 0;
	}

    for (new i = 0; i != MAX_HOUSE_FURNITURE; i ++) {
	    ListedFurniture[playerid][i] = -1;
	}

	Character[playerid][IsSpec] = -1;

    Character[playerid][FactionOffer] = INVALID_PLAYER_ID;
	Character[playerid][FactionOffered] = -1;
	
	Character[playerid][Faction] = -1;
	Character[playerid][FactionID] = -1;
	Character[playerid][FactionRank] = 0;
	Character[playerid][FactionEdit] = -1;
	Character[playerid][SelectedSlot] = -1;
	Character[playerid][ShowFooter] = 0;
	Character[playerid][EditPump] = -1;
	Character[playerid][GasPump] = -1;
	Character[playerid][GasStation] = -1;
	Character[playerid][Business] = -1;
	Character[playerid][Entrance] = -1;
	Character[playerid][Refill] = INVALID_VEHICLE_ID;
	Character[playerid][RefillPrice] = 0;
	Character[playerid][LoadingPD] = 0;
	Character[playerid][CarryPD] = 0;
	
	Character[playerid][MecOffer] = INVALID_PLAYER_ID;
    Character[playerid][MecType] = 0;
	Character[playerid][MecStep] = 0;
	Character[playerid][MecCar] = INVALID_VEHICLE_ID;
	Character[playerid][MecTow] = INVALID_VEHICLE_ID;
	Character[playerid][MecPrice] = 0;
	Character[playerid][MecProd] = 0;
    Character[playerid][MecCol1] = 0;
	Character[playerid][MecCol2] = 0;
	
	Character[playerid][BoomboxEx] = 0;
	
	BoomboxData[playerid][boomboxPlaced] = 0;
	BoomboxData[playerid][boomboxPos][0] = 0.0;
	BoomboxData[playerid][boomboxPos][1] = 0.0;
	BoomboxData[playerid][boomboxPos][2] = 0.0;
	Character[playerid][Boombox] = INVALID_PLAYER_ID;
	
	Character[playerid][EditFurniture] = 0;
	
	Character[playerid][InventoryItem] = 0;
	Character[playerid][StorageSelect] = 0;

	Character[playerid][PauseCheck] = 0;
	
	Character[playerid][InjuredEx]=0;
	Character[playerid][InjuredSpawn]=0;
	Character[playerid][InjuredShoot]=0;
	
	Character[playerid][HealthCheck]=0;
	Character[playerid][HealthLock]=0;
	Character[playerid][ArmorCheck]=0;
	Character[playerid][ArmorLock]=0;
	
	Character[playerid][Stunned] = 0;
	
	Character[playerid][Spectating] = INVALID_PLAYER_ID;
	
	format(Character[playerid][ReportMessage], 64, "(null)");
	
	Character[playerid][Emergency] = 0;
	
	Character[playerid][IncomingCall] = 0;
	Character[playerid][CallLine] = INVALID_PLAYER_ID;

    for (new i = 0; i != MAX_CONTACTS; i ++) {
	    ContactData[playerid][i][contactExists] = false;
	    ContactData[playerid][i][contactID] = 0;
	    ContactData[playerid][i][contactNumber] = 0;
	    ListedContacts[playerid][i] = -1;
	}


 	PickedUpPickup[playerid] = false;
	LoopAnim[playerid] = 0;
	LibsPreloaded[playerid] = 0;
	return 1;
}


stock RemoveFromVehicle(playerid)
{
	if (IsPlayerInAnyVehicle(playerid))
	{
		new
		    Float:fX,
	    	Float:fY,
	    	Float:fZ;

		GetPlayerPos(playerid, fX, fY, fZ);
		SetPlayerPosEx(playerid, fX, fY, fZ + 1.5, Character[playerid][Interior], Character[playerid][VWorld]);
	}
	return 1;
}

stock GetPlayerID(const name[])
{
    new pName[MAX_PLAYER_NAME];
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(!IsPlayerConnected(i)) continue;
        GetPlayerName(i, pName, MAX_PLAYER_NAME);
        if(!strcmp(pName, name))
            return i;
    }
    return INVALID_PLAYER_ID;
}



stock NameCheck(playerid)
{
	new str[128];
    new namecheck = strfind(GetName(playerid), "_", true);
	if(namecheck >= 1)
	{
        SendClientMessage(playerid, COLOR_RED, "คุณจำเป็นต้องใช้ชื่อที่ไม่มี '_' เพื่อใช้เป็นชื่อนี้เป็น Username สำหรับการเข้าเกมส์");
		format(str, sizeof(str), "%s ถูกเตะเนื่องจากชื่อของเขาไม่ถูกต้องตามระบบ.",GetName(playerid));
		SendAdminsMessage(1, COLOR_ORANGERED, str);
		KickPlayer(playerid);
	}
	return 1;
}

//Faction

stock RemoveAlpha(color) {
    return (color & ~0xFF);
}

forward RemoveAttachedObject(playerid, slot);
public RemoveAttachedObject(playerid, slot)
{
	if (IsPlayerConnected(playerid) && IsPlayerAttachedObjectSlotUsed(playerid, slot))
	{
	    RemovePlayerAttachedObject(playerid, slot);
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

stock CopOnline()
{
	new cop;
	foreach(new x: Player) {
		if(IsPlayerConnected(x) && GetFactionType(x) == FACTION_POLICE && BitFlag_Get(g_PlayerFlags[x], PLAYER_ONDUTY)) {
        	cop++;
		}
	}
	return cop;
}

//----------//

stock GetName(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
    return name;
}

stock GetRoleplayName(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
    name[strfind(name,"_")] = ' ';
    return name;
}

stock IsAdminInVehicle(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		for (new i = 0; i < MAX_PLAYERS; ++i)
		{
			if(Account[i][Admin] > 0 && GetPlayerVehicleID(playerid) == GetPlayerVehicleID(i))
			{
				return 0;
			}
		}
		
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
	new vehicleid;
	new string[128];
	new id = -1;
	new Float:hp;

    IsAFK{playerid} = false;
    AFKTimer[playerid] = 3;

    GetPlayerHealth(playerid, hp);

	if(LoggedIn[playerid] == true)
	{
		//Police taser
		new w = GetPlayerWeapon(playerid);
		if(w != lastWeapon[playerid] && taser[playerid])
			OnPlayerChangeWeapon(playerid, w, lastWeapon[playerid]);

		lastWeapon[playerid] = w;



		//ShowPlayerUpdateHud
		if(UseUserControl[playerid] == 1)
		{
			new exp = Character[playerid][Exp];
			new nxtlevel = Character[playerid][Level]+1;
			new expamount = nxtlevel*levelexp;

			SetPlayerProgressBarValue(playerid, EXPBAR[playerid], Character[playerid][Exp]);
			SetPlayerProgressBarMaxValue(playerid, EXPBAR[playerid], expamount);

			SetPlayerProgressBarValue(playerid, ThirstyBAR[playerid], Character[playerid][Thirsty]);
			SetPlayerProgressBarValue(playerid, HungryBAR[playerid], Character[playerid][Hungry]);

			format(string, sizeof(string), "%s", ReturnName(playerid, 0));
			PlayerTextDrawSetString(playerid, HUDSHOW[playerid][2], string);

			format(string, sizeof(string), "%s", ReturnName(playerid, 0));
			PlayerTextDrawSetString(playerid, HUDSHOW[playerid][22], string);

			format(string, sizeof(string), "%d", Character[playerid][Age]);
			PlayerTextDrawSetString(playerid, HUDSHOW[playerid][24], string);

			format(string, sizeof(string), "%d", Character[playerid][Phone]);
			PlayerTextDrawSetString(playerid, HUDSHOW[playerid][26], string);

			format(string, sizeof(string), "%s", Job_GetName(Character[playerid][Job]));
			PlayerTextDrawSetString(playerid, HUDSHOW[playerid][28], string);

			format(string, sizeof(string), "Coming Soon");
			PlayerTextDrawSetString(playerid, HUDSHOW[playerid][30], string);

			format(string, sizeof(string), "%s", Faction_GetName(playerid));
			PlayerTextDrawSetString(playerid, HUDSHOW[playerid][32], string);
			
			format(string, sizeof(string), "%s", Faction_GetRank(playerid));
			PlayerTextDrawSetString(playerid, HUDSHOW[playerid][34], string);

			format(string, sizeof(string), "ID: %d", playerid);
			PlayerTextDrawSetString(playerid, HUDSHOW[playerid][36], string);

			format(string, sizeof(string), "Exp: %d/%d", exp, expamount);
			PlayerTextDrawSetString(playerid, HUDSHOW[playerid][37], string);

			format(string, sizeof(string), "Hungry: %d", Character[playerid][Hungry]);
			PlayerTextDrawSetString(playerid, HUDSHOW[playerid][38], string);

			format(string, sizeof(string), "Thirsty: %d", Character[playerid][Thirsty]);
			PlayerTextDrawSetString(playerid, HUDSHOW[playerid][39], string);

			PlayerTextDrawSetPreviewModel(playerid, HUDSHOW[playerid][19], Character[playerid][Skin]);
		}
		//===================================ค่าความหิว====================================
		if (Character[playerid][Thirsty] > 100) Character[playerid][Thirsty] = 100;
		if (Character[playerid][Thirsty] < 0) Character[playerid][Thirsty] = 0;

		if (Character[playerid][Hungry] > 100) Character[playerid][Hungry] = 100;
		if (Character[playerid][Hungry] < 0) Character[playerid][Hungry] = 0;

		if(Character[playerid][Thirsty] > 0) Character[playerid][Thirsty] -= 0.1;
		if(Character[playerid][Hungry] > 0) Character[playerid][Hungry] -= 0.1;

		if(Character[playerid][Thirsty] < 10)
		{
			Character[playerid][Health] -= 0.2;
		}
		if(Character[playerid][Hungry] < 10)
		{
			Character[playerid][Health] -= 0.2;
		}

		//=======================================================================
		Character_Save(playerid);
	}

    Character[playerid][PauseCheck] = GetTickCount();

    if (IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		vehicleid = GetPlayerVehicleID(playerid);

		new
			Float:fSpeed,
			Float:speed_x,
			Float:speed_y,
			Float:speed_z,
			Float:final_speed;

		GetVehicleVelocity(vehicleid,speed_x,speed_y,speed_z);
		final_speed = floatsqroot(((speed_x*speed_x)+(speed_y*speed_y))+(speed_z*speed_z))*199.4166672; // 250.666667 = kmph  // 199,4166672 = mph
		fSpeed = floatround(final_speed,floatround_round);
		player_vehicle_speed[playerid] = fSpeed;

		if (IsSpeedoVehicle(vehicleid))
		{
			format(string, sizeof(string), "~b~mi/h: ~g~%.0f~n~~b~Fuel: ~g~%d~n~_~n~_", fSpeed, (CoreVehicles[vehicleid][vehTemporary]) ? 100 : FuelVehicle(vehicleid));
			PlayerTextDrawSetString(playerid, Speedo[playerid], string);
		}
		else
		{
			format(string, sizeof(string), "~b~mi/h: ~g~%.0f~n~~b~Fuel: ~g~N/A~n~_~n~_", fSpeed);
			PlayerTextDrawSetString(playerid, Speedo[playerid], string);
		}
		return 1;
	}


    if ((id = CheckBusiness_Nearest(playerid)) != -1)
    {
        PlayerCheckpointBiz[playerid] = 1;
        SetPlayerCheckpoint(playerid, BusinessData[id][bizPos][0], BusinessData[id][bizPos][1], BusinessData[id][bizPos][2], 3.0);
        return 1;
	}
    else if((id = CheckBusiness_Nearest(playerid)) == -1)
    {
        if(PlayerCheckpointBiz[playerid] == 1)
        {
        	DisablePlayerCheckpoint(playerid);
        	PlayerCheckpointBiz[playerid] = 0;
		}
    }
    
    if ((id = CheckHouse_Nearest(playerid)) != -1)
    {
        PlayerCheckpointHouse[playerid] = 1;
        SetPlayerCheckpoint(playerid, HouseData[id][housePos][0], HouseData[id][housePos][1], HouseData[id][housePos][2], 3.0);
        return 1;
	}
    else if((id = CheckHouse_Nearest(playerid)) == -1)
    {
        if(PlayerCheckpointHouse[playerid] == 1)
        {
        	DisablePlayerCheckpoint(playerid);
        	PlayerCheckpointHouse[playerid] = 0;
		}
    }
    
    if ((id = CheckEntrance_Nearest(playerid)) != -1)
    {
        PlayerCheckpointEntrance[playerid] = 1;
        SetPlayerCheckpoint(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2], 3.0);
        return 1;
	}
    else if((id = CheckEntrance_Nearest(playerid)) == -1)
    {
        if(PlayerCheckpointEntrance[playerid] == 1)
        {
        	DisablePlayerCheckpoint(playerid);
        	PlayerCheckpointEntrance[playerid] = 0;
		}
    }

    GetPlayerIp(playerid, Character[playerid][LatestIP], 16);
	return 1;
}

stock Tax_Percent(price)
{
	return floatround((float(price) / 100) * 85);
}

stock Tax_AddPercent(price)
{
	new money = (price - Tax_Percent(price));

	g_TaxVault = g_TaxVault + money;

	Server_Save();
	return 1;
}

Server_Save()
{
	new
	    File:file = fopen("server.ini", io_write),
	    str[128];

	format(str, sizeof(str), "TaxMoney = %d\n", g_TaxVault);
	return (fwrite(file, str), fclose(file));
}

StopRefilling(playerid)
{
    Character[playerid][GasPump] = -1;
    Character[playerid][GasStation] = -1;
   	Character[playerid][Refill] = INVALID_VEHICLE_ID;
	Character[playerid][RefillPrice] = 0;
}

stock GetPlayerLocationEx(playerid, &Float:fX, &Float:fY, &Float:fZ)
{
	new
	    id = -1;

    /*if ((id = House_Inside(playerid)) != -1)
	{
		fX = HouseData[id][housePos][0];
		fY = HouseData[id][housePos][1];
		fZ = HouseData[id][housePos][2];
	}*/
	if ((id = Business_Inside(playerid)) != -1)
	{
		fX = BusinessData[id][bizPos][0];
		fY = BusinessData[id][bizPos][1];
		fZ = BusinessData[id][bizPos][2];
	}
	else if ((id = Entrance_Inside(playerid)) != -1)
	{
		fX = EntranceData[id][entrancePos][0];
		fY = EntranceData[id][entrancePos][1];
		fZ = EntranceData[id][entrancePos][2];
	}
	else GetPlayerPos(playerid, fX, fY, fZ);
	return 1;
}


stock GetPlayerLocation(playerid)
{
	new
	    Float:fX,
	    Float:fY,
		Float:fZ,
		string[32],
		id = -1;

/*	if ((id = House_Inside(playerid)) != -1)
	{
		fX = HouseData[id][housePos][0];
		fY = HouseData[id][housePos][1];
		fZ = HouseData[id][housePos][2];
	}*/
	if ((id = Business_Inside(playerid)) != -1)
	{
		fX = BusinessData[id][bizPos][0];
		fY = BusinessData[id][bizPos][1];
		fZ = BusinessData[id][bizPos][2];
	}
	else if ((id = Entrance_Inside(playerid)) != -1)
	{
		fX = EntranceData[id][entrancePos][0];
		fY = EntranceData[id][entrancePos][1];
		fZ = EntranceData[id][entrancePos][2];
	}
	else GetPlayerPos(playerid, fX, fY, fZ);

	format(string, 32, GetLocation(fX, fY, fZ));
	return string;
}

stock InfoBoxForPlayer(playerid, text[])
{
    //CloseInfo(playerid);
    TextDrawSetString(InfoBox[playerid], text);
	TextDrawShowForPlayer(playerid, InfoBox[playerid]);
    SetTimerEx("CloseInfo", SECONDS(7), false, "d", playerid);
	return 1;
}

stock InfoBoxForPlayer2(playerid, text[])
{
    CloseInfo(playerid);
    TextDrawSetString(InfoBox[playerid], text);
	TextDrawShowForPlayer(playerid, InfoBox[playerid]);
	return 1;
}


stock KickPlayer(playerid)
{
	SetTimerEx("FixKick", 200, false, "d", playerid);
}

Character_Save(playerid) //เซฟ
{
	if(LoggedIn[playerid] == true)
	{
		new query[2048];
		
		if(Character[playerid][ClothesSelection] == 0 || Character[playerid][InHospital] == 0)
		{
    		GetPlayerPos(playerid, Character[playerid][PosX], Character[playerid][PosY], Character[playerid][PosZ]);
            GetPlayerFacingAngle(playerid, Character[playerid][Angle]);
		}
		GetPlayerHealth(playerid, Character[playerid][Health]);
		GetPlayerArmour(playerid, Character[playerid][Armour]);
		

		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET Whitelist = %d, Level = %d, Cash = %d,Skin = %d, PosX = %f,PosY = %f,PosZ = %f,Angle = %f,VWorld = %d,Interior = %d, Kicks = %d, Muted = %d, Health = %f, Armour = %f, Bank = %d, LatestIP = '%s', Age = %d, Gender = %d, ExemptIP = %d WHERE ID = %d LIMIT 1",

			Character[playerid][Whitelist],
			Character[playerid][Level],
			Character[playerid][Cash],
			Character[playerid][Skin],
		    Character[playerid][PosX],
			Character[playerid][PosY],
			Character[playerid][PosZ],
			Character[playerid][Angle],
			GetPlayerVirtualWorld(playerid),
			GetPlayerInterior(playerid),
			Character[playerid][Kicks],
			Character[playerid][Muted],
			Character[playerid][Health],
		    Character[playerid][Armour],
			Character[playerid][Bank],
			Character[playerid][LatestIP],
			Character[playerid][Age],
			Character[playerid][Gender],
			Character[playerid][ExemptIP],
			Character[playerid][ID]);

		mysql_tquery(dbCon, query);


		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET LastOnline = '%s', Spawn = %d, Faction = %d, FactionRank = %d, Business = %d, Entrance = %d, Job = %d, House = %d, Capacity = %d WHERE ID = %d LIMIT 1",

			ReturnDate(),
			Character[playerid][Spawn],
			Character[playerid][FactionID],
			Character[playerid][FactionRank],
			Character[playerid][Business],
			Character[playerid][Entrance],
			Character[playerid][Job],
			Character[playerid][House],
			Character[playerid][Capacity],
			Character[playerid][ID]);

		mysql_tquery(dbCon, query);
		
		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET Exp = '%d', Savings = '%d', Paycheck = %d, Minutes = %d, Playerhours = %d, Injured = %d, Channel = %d, ChannelSlot = %d WHERE ID = %d LIMIT 1",

            Character[playerid][Exp],
			Character[playerid][Savings],
			Character[playerid][Paycheck],
			Character[playerid][Minutes],
			Character[playerid][Playerhours],
			Character[playerid][Injured],
			Character[playerid][Channel],
			Character[playerid][ChannelSlot],
			Character[playerid][ID]);

		mysql_tquery(dbCon, query);
		
		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET Phone = %d, ConfirmChar = %d, WHERE ID = %d LIMIT 1",

            Character[playerid][Phone],
            Character[playerid][ConfirmChar],
			Character[playerid][ID]);

		mysql_tquery(dbCon, query);

		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET Thirsty = %d, Hungry = %d, PlayerdePosX = %.2f, PlayerdePosY = %.2f, PlayerdePosZ = %.2f, PlayerdePosA = %.2f, PlayerdeInt = %d, PlayerdeWorld = %d WHERE ID = %d LIMIT 1",

			Character[playerid][Thirsty],
			Character[playerid][Hungry],
			Character[playerid][Playerdepos][0],
			Character[playerid][Playerdepos][1],
			Character[playerid][Playerdepos][2],
			Character[playerid][Playerdepos][3],
			Character[playerid][PlayerdeInt],
			Character[playerid][PlayerdeWorld],
			Character[playerid][ID]);

		mysql_tquery(dbCon, query);


		mysql_format(dbCon, query, sizeof(query), "UPDATE accounts SET Admin = %d WHERE SQLID = %d LIMIT 1",
		
			Account[playerid][Admin],
			Account[playerid][SQLID]);
			
		mysql_tquery(dbCon, query);


	}
	return true;
}

forward Character_Load(playerid);
public Character_Load(playerid)
{

    new query[2568];
    new rows;
	mysql_format(dbCon, query, sizeof(query), "SELECT * FROM `characters` WHERE `ID` = %d LIMIT 1", Character[playerid][ID]);
	mysql_query(dbCon, query);

    cache_get_row_count(rows);

    if (rows) {
	    cache_get_value_name(0, "Name", Character[playerid][Username], 32);
	    cache_get_value_name_int(0, "Whitelist", Character[playerid][Whitelist]);
	    cache_get_value_name_int(0, "Level", Character[playerid][Level]);
	    cache_get_value_name_int(0, "Cash", Character[playerid][Cash]);
	    cache_get_value_name_int(0, "Skin", Character[playerid][Skin]);
	    cache_get_value_name_float(0, "PosX", Character[playerid][PosX]);
	    cache_get_value_name_float(0, "PosY", Character[playerid][PosY]);
	    cache_get_value_name_float(0, "PosZ", Character[playerid][PosZ]);
	    cache_get_value_name_float(0, "Angle", Character[playerid][Angle]);
	    cache_get_value_name_int(0, "Interior", Character[playerid][Interior]);
	    cache_get_value_name_int(0, "VWorld", Character[playerid][VWorld]);
	    cache_get_value_name_int(0, "Age", Character[playerid][Age]);
	    cache_get_value_name_int(0, "Gender", Character[playerid][Gender]);
	    cache_get_value_name_int(0, "Kicks", Character[playerid][Kicks]);
	    cache_get_value_name_int(0, "Muted", Character[playerid][Muted]);
	    cache_get_value_name_float(0, "Health", Character[playerid][Health]);
	    cache_get_value_name_float(0, "Armour", Character[playerid][Armour]);
	    cache_get_value_name_int(0, "Bank", Character[playerid][Bank]);
	    cache_get_value_name_int(0, "ExemptIP", Character[playerid][ExemptIP]);
	    cache_get_value_name_int(0, "Spawn", Character[playerid][Spawn]);
	    cache_get_value_name_int(0, "Faction", Character[playerid][FactionID]);
	    cache_get_value_name_int(0, "FactionRank", Character[playerid][FactionRank]);
	    cache_get_value_name_int(0, "Business", Character[playerid][Business]);
	    cache_get_value_name_int(0, "Entrance", Character[playerid][Entrance]);
	    cache_get_value_name_int(0, "Job", Character[playerid][Job]);
	    cache_get_value_name_int(0, "House", Character[playerid][House]);
	    cache_get_value_name_int(0, "Capacity", Character[playerid][Capacity]);
	    cache_get_value_name_int(0, "Exp", Character[playerid][Exp]);
	    cache_get_value_name_int(0, "Savings", Character[playerid][Savings]);
	    cache_get_value_name_int(0, "Paycheck", Character[playerid][Paycheck]);
	    cache_get_value_name_int(0, "Minutes", Character[playerid][Minutes]);
	    cache_get_value_name_int(0, "Playerhours", Character[playerid][Playerhours]);
	    cache_get_value_name_int(0, "Injured", Character[playerid][Injured]);
	    cache_get_value_name_int(0, "Channel", Character[playerid][Channel]);
	    cache_get_value_name_int(0, "ChannelSlot", Character[playerid][ChannelSlot]);
	    cache_get_value_name_int(0, "Phone", Character[playerid][Phone]);
	    cache_get_value_name_int(0, "ConfirmChar", Character[playerid][ConfirmChar]);
		cache_get_value_name(0, "Birthday", Character[playerid][Birthday],32);
		cache_get_value_name_int(0, "Thirsty", Character[playerid][Thirsty]);
		cache_get_value_name_int(0, "Hungry", Character[playerid][Hungry]);
		cache_get_value_name_float(0, "PlayerdePosX", Character[playerid][Playerdepos][0]);
		cache_get_value_name_float(0, "PlayerdePosY", Character[playerid][Playerdepos][1]);
		cache_get_value_name_float(0, "PlayerdePosZ", Character[playerid][Playerdepos][2]);
		cache_get_value_name_float(0, "PlayerdePosA", Character[playerid][Playerdepos][3]);
		cache_get_value_name_int(0, "PlayerdeInt", Character[playerid][PlayerdeInt]);
		cache_get_value_name_int(0, "PlayerdeWorld", Character[playerid][PlayerdeWorld]);
	}


	Character[playerid][LastOnline] = gettime();

	StopAudioStreamForPlayer(playerid);

    GetPlayerIp(playerid, Character[playerid][LatestIP], 16);
    SetPlayerName(playerid, Character[playerid][Username]);

	new str[128];
	format(str, sizeof(str), "[คุณได้เลือกเข้าสู่ระบบตัวละคร: %s]", GetRoleplayName(playerid));
	SendClientMessage(playerid, COLOR_PALEGOLDENROD, str);

	if(Character[playerid][Whitelist] == 0)
	{
		Dialog_Show(playerid, Whitelist, DIALOG_STYLE_MSGBOX, "{00FF00}[Whitelist]","{FFFFFF}ตัวละครของคุณไม่มี Whitelist โปรดติดต่อผู้ดูแลเซิร์ฟเวอณ์ได้ที่ Discord", "ตกลง", "");
		SetTimerEx("KickPlayerDelayed", time, false, "d", playerid);
		return 1;
	}

	TogglePlayerSpectating(playerid, false);

	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	InactivtyCheck[playerid] = SetTimerEx("CheckActivity", MINUTES(15), true, "d", playerid);
	LastCommandTime[playerid] = gettime();
	InactivtyCheck_X[playerid] = pos[0];
	InactivtyCheck_Y[playerid] = pos[1];
	InactivtyCheck_Z[playerid] = pos[2];

	/*new factionid = Character[playerid][Faction];

	if(Character[playerid][Injured] == 1)
 	{
		SetSpawnInfo(playerid, NO_TEAM, Character[playerid][Skin], Character[playerid][Playerdepos][0], Character[playerid][Playerdepos][1], Character[playerid][Playerdepos][2], 0.0, 0, 0, 0, 0, 0, 0);
		SetPlayerPosEx(playerid, Character[playerid][Playerdepos][0], Character[playerid][Playerdepos][1], Character[playerid][Playerdepos][2], Character[playerid][PlayerdeInt], Character[playerid][PlayerdeWorld]);
		SetPlayerFacingAngle(playerid, Character[playerid][Playerdepos][3]);
		Character[playerid][InjuredShoot] = 0;
 	    SetPlayerInjured(playerid);
 	}
	else if(Character[playerid][Injured] == 0)
	{
		if(Character[playerid][InjuredSpawn] == 1)
		{
			Hospital(playerid);
		}
		else if(Character[playerid][InjuredSpawn] == 0)
		{
			if(Character[playerid][Spawn] == 1)
			{
				TogglePlayerSpectating(playerid, false);
				SetSpawnInfo(playerid, NO_TEAM, Character[playerid][Skin], Character[playerid][PosX], Character[playerid][PosY], Character[playerid][PosZ], 0.0, 0, 0, 0, 0, 0, 0);
				SetPlayerPosEx(playerid, Character[playerid][PosX], Character[playerid][PosY], Character[playerid][PosZ], Character[playerid][Interior], Character[playerid][VWorld]);
				SetPlayerFacingAngle(playerid, Character[playerid][Angle]);
			}
			else if(Character[playerid][Spawn] == 2)
			{
				TogglePlayerSpectating(playerid, false);
				SetSpawnInfo(playerid, NO_TEAM, Character[playerid][Skin], FactionData[factionid][factionLockerPos][0], FactionData[factionid][factionLockerPos][1], FactionData[factionid][factionLockerPos][2], 0.0, 0, 0, 0, 0, 0, 0);
				SetPlayerPosEx(playerid, FactionData[factionid][factionLockerPos][0], FactionData[factionid][factionLockerPos][1], FactionData[factionid][factionLockerPos][2],FactionData[factionid][factionLockerInt],FactionData[factionid][factionLockerWorld]);
			}
		}
	}*/

	SetSpawnInfo(playerid, NO_TEAM, Character[playerid][Skin], Character[playerid][PosX], Character[playerid][PosY], Character[playerid][PosZ], 0.0, 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
    return 1;
}



IssueBan(playerid, adminname[], reason[])
{
	new query[256], ip[18];
	GetPlayerIp(playerid, ip, 18);
	
    mysql_format(dbCon, query, sizeof(query), "INSERT INTO Bans (PlayerName, IP, C_ID, A_ID, Timestamp, BannedBy, Reason) VALUES('%s', '%s', %d, %d, '%s', '%s', '%s')", GetName(playerid), ip, Character[playerid][ID], Account[playerid][SQLID], ReturnDate(), adminname, reason);
	mysql_tquery(dbCon, query);
	KickPlayer(playerid);
	return 1;
}

Dialog:EnterNumber(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new
	        name[32],
			string[128];

		strunpack(name, Character[playerid][EditingItem]);

	    if (isnull(inputtext) || !IsNumeric(inputtext))
	        return Dialog_Show(playerid, EnterNumber, DIALOG_STYLE_INPUT, "Contact Number", "ชื่อผู้ติดต่อ: %s\n\nโปรดระบุเบอร์โทรศัพท์สำหรับผู้ติดต่อนี้:", "Submit", "Back", name);

		for (new i = 0; i != MAX_CONTACTS; i ++)
		{
			if (!ContactData[playerid][i][contactExists])
			{
            	ContactData[playerid][i][contactExists] = true;
            	ContactData[playerid][i][contactNumber] = strval(inputtext);

				format(ContactData[playerid][i][contactName], 32, name);

				format(string, sizeof(string), "INSERT INTO `contacts` (`ID`, `contactName`, `contactNumber`) VALUES('%d', '%s', '%d')", Character[playerid][ID], SQL_ReturnEscaped(name), ContactData[playerid][i][contactNumber]);
				mysql_tquery(dbCon, string, "OnContactAdd", "dd", playerid, i);

				SendClientMessageEx(playerid, -1,"คุณได้เพิ่ม \"%s\" ในรายชื่อผู้ติดต่อของคุณ", name);
                return 1;
			}
	    }
	    SystemMsg(playerid, "ไม่มีที่ว่างในรายชื่อีกแล้ว");
	}
	else {
		ShowContacts(playerid);
	}
	return 1;
}

Dialog:NewContact(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext))
			return Dialog_Show(playerid, NewContact, DIALOG_STYLE_INPUT, "New Contact", "ข้อผิดพลาด: โปรดป้อนชื่อผู้ติดต่อ\n\nโปรดป้อนชื่อผู้ติดต่อด้านล่าง:", "Submit", "Back");

	    if (strlen(inputtext) > 32)
	        return Dialog_Show(playerid, NewContact, DIALOG_STYLE_INPUT, "New Contact", "ข้อผิดพลาด: ชื่อผู้ติดต่อไม่ควรเกิน 32 ตัวอักษร\n\nโปรดป้อนชื่อผู้ติดต่อด้านล่าง:", "Submit", "Back");

		strpack(Character[playerid][EditingItem], inputtext, 32);

	    Dialog_Show(playerid, EnterNumber, DIALOG_STYLE_INPUT, "Contact Number", "ชื่อผู้ติดต่อ: %s\n\nโปรดป้อนเบอร์โทรศัพท์ของผู้ติดต่อ:", "Submit", "Back", inputtext);
	}
	else {
		ShowContacts(playerid);
	}
	return 1;
}

Dialog:ContactInfo(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new
			id = Character[playerid][Contact],
			string[72];

		switch (listitem)
		{
		    case 0:
		    {
		        format(string, 16, "%d", ContactData[playerid][id][contactNumber]);
				cmd_call(playerid, string);
		    }
		    case 1:
		    {
		        format(string, sizeof(string), "DELETE FROM `contacts` WHERE `ID` = '%d' AND `contactID` = '%d'", Character[playerid][ID], ContactData[playerid][id][contactID]);
		        mysql_tquery(dbCon, string);

		        SendClientMessageEx(playerid, -1,"คุณได้ลบ \"%s\" ออกจากรายชื่อผู้ติดต่อ", ContactData[playerid][id][contactName]);

		        ContactData[playerid][id][contactExists] = false;
		        ContactData[playerid][id][contactNumber] = 0;
		        ContactData[playerid][id][contactID] = 0;

		        ShowContacts(playerid);
		    }
		}
	}
	else {
	    ShowContacts(playerid);
	}
	return 1;
}

Dialog:Contacts(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (!listitem) {
	        Dialog_Show(playerid, NewContact, DIALOG_STYLE_INPUT, "New Contact", "โปรดป้อนชื่อผู้ติดต่อด้านล่าง:", "Submit", "Back");
	    }
	    else {
		    Character[playerid][Contact] = ListedContacts[playerid][listitem - 1];

	        Dialog_Show(playerid, ContactInfo, DIALOG_STYLE_LIST, ContactData[playerid][Character[playerid][Contact]][contactName], "Call Contact\nDelete Contact", "Select", "Back");
	    }
	}
	else {
		cmd_phone(playerid, "\1");
	}
	for (new i = 0; i != MAX_CONTACTS; i ++) {
	    ListedContacts[playerid][i] = -1;
	}
	return 1;
}

forward OnContactAdd(playerid, id);
public OnContactAdd(playerid, id)
{
	ContactData[playerid][id][contactID] = cache_insert_id();
	return 1;
}

forward OnQueryFinished(extraid, threadid);
public OnQueryFinished(extraid, threadid)
{
    if (!IsPlayerConnected(extraid))
	    return 0;

	static
	    rows;

	switch (threadid)
	{
     	case THREAD_LOAD_INVENTORY:
		{
		    static
		        name[32];

		    cache_get_row_count(rows);

			for (new i = 0; i < rows && i < MAX_INVENTORYFURNITURE; i ++) {
			    InvFurnitureData[extraid][i][invExists] = true;
		     	cache_get_value_name_int(i, "invID", InvFurnitureData[extraid][i][invID]);
		     	cache_get_value_name_int(i, "invModel", InvFurnitureData[extraid][i][invModel]);
        		cache_get_value_name_int(i, "invQuantity", InvFurnitureData[extraid][i][invQuantity]);

				cache_get_value_name(i, "invItem", name, sizeof(name));
				strpack(InvFurnitureData[extraid][i][invItem], name, 32 char);
			}
		}
		case THREAD_LOAD_CONTACTS:
		{
		    cache_get_row_count(rows);

			for (new i = 0; i < rows && i < MAX_CONTACTS; i ++) {
				cache_get_value_name(i, "contactName", ContactData[extraid][i][contactName], 32);

				ContactData[extraid][i][contactExists] = true;
				cache_get_value_name_int(i, "contactID", ContactData[extraid][i][contactID]);
				cache_get_value_name_int(i, "contactNumber", ContactData[extraid][i][contactNumber]);
			}
		}
	}
	return 1;
}

forward UnControl(playerid);
public UnControl(playerid)
{
    SetPlayerPos(playerid, Character[playerid][PosX], Character[playerid][PosY], Character[playerid][PosZ]);
	SetPlayerInterior(playerid, Character[playerid][Interior]);
	SetPlayerVirtualWorld(playerid, Character[playerid][VWorld]);
    TogglePlayerControllable(playerid, true);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	static
		query[128];

	if(Character[playerid][ConfirmChar] == 0)
	{
		SetSelectionPos(playerid);
		SetPlayerSkinEx(playerid, Character[playerid][Skin]);
		SetPlayerMoneyEx(playerid, 1000);
		Character[playerid][ConfirmChar] = 1;

		Dialog_Show(playerid, REG2, DIALOG_STYLE_MSGBOX, "ขึ้นตอนการสร้างตัวละคร", "คุณต้องการที่จะให้ตัวละครของคุณเป็นเพศอะไร?","ชาย","หญิง");
		return 1;
	}

	if(Character[playerid][ConfirmChar] == 2){
		new world = planeworld+1;
		plane[playerid] = CreateDynamicObject(1683, -33.26580, 2506.87354, 150.47870,   0.00000, 0.00000, 0.00000, world, 0);
		SetPlayerVirtualWorld(playerid, world);
		CameraOnNewCharacter(playerid);
		return 1;
	}

	ShowUserPing(playerid);

	PlayerTextDrawSetPreviewModel(playerid, HUDSHOW[playerid][19], Character[playerid][Skin]);
 	
 	SetPlayerHealth(playerid, Character[playerid][Health]);
	SetPlayerArmour(playerid, Character[playerid][Armour]);
	SetPlayerSkin(playerid, Character[playerid][Skin]);
	SetPlayerScore(playerid, Character[playerid][Level]);
	
	format(query, sizeof(query), "SELECT * FROM `invfurniture` WHERE `ID` = '%d'", Character[playerid][ID]);
	mysql_tquery(dbCon, query, "OnQueryFinished", "dd", playerid, THREAD_LOAD_INVENTORY);
	
	Character[playerid][Spectating] = INVALID_PLAYER_ID;
	
	CancelSelectTextDraw(playerid);
	
    BitFlag_On(g_PlayerFlags[playerid], PLAYER_IS_LOGGED_IN);

	if (Character[playerid][FactionID] == -1)
	{
		ResetFaction(playerid);
	}

    if (Character[playerid][FactionID] != -1)
	{
 		Character[playerid][Faction] = GetFactionByID(Character[playerid][FactionID]);
	}

    SetTimerEx("LoginCheck", 2000, false, "d", playerid);

	PickedUpPickup[playerid] = false;

	SetPlayerMoneyEx(playerid, Character[playerid][Cash]);

	SetPlayerSkin(playerid, Character[playerid][Skin]);

    TogglePlayerSpectating(playerid, false);

	//new factionid = Character[playerid][Faction];

	if(Character[playerid][Injured] == 1)
 	{
		SetSpawnInfo(playerid, NO_TEAM, Character[playerid][Skin], Character[playerid][Playerdepos][0], Character[playerid][Playerdepos][1], Character[playerid][Playerdepos][2], 0.0, 0, 0, 0, 0, 0, 0);
		SetPlayerPosEx(playerid, Character[playerid][Playerdepos][0], Character[playerid][Playerdepos][1], Character[playerid][Playerdepos][2], Character[playerid][PlayerdeInt], Character[playerid][PlayerdeWorld]);
		SetPlayerFacingAngle(playerid, Character[playerid][Playerdepos][3]);
		Character[playerid][InjuredShoot] = 0;
 	    SetPlayerInjured(playerid);
 	}
	else if(Character[playerid][Injured] == 0)
	{
		if(Character[playerid][InjuredSpawn] == 1)
		{
			Hospital(playerid);
		}
		else if(Character[playerid][InjuredSpawn] == 0)
		{
			if(Character[playerid][Spawn])
			{
				TogglePlayerSpectating(playerid, false);
				SetSpawnInfo(playerid, NO_TEAM, Character[playerid][Skin], Character[playerid][PosX], Character[playerid][PosY], Character[playerid][PosZ], 0.0, 0, 0, 0, 0, 0, 0);
				SetPlayerPosEx(playerid, Character[playerid][PosX], Character[playerid][PosY], Character[playerid][PosZ], Character[playerid][Interior], Character[playerid][VWorld]);
				SetPlayerFacingAngle(playerid, Character[playerid][Angle]);
				InteriorTimer(playerid);
			}
			/*else if(Character[playerid][Spawn] == 2)
			{
				TogglePlayerSpectating(playerid, false);
				SetSpawnInfo(playerid, NO_TEAM, Character[playerid][Skin], FactionData[factionid][factionLockerPos][0], FactionData[factionid][factionLockerPos][1], FactionData[factionid][factionLockerPos][2], 0.0, 0, 0, 0, 0, 0, 0);
				SetPlayerPosEx(playerid, FactionData[factionid][factionLockerPos][0], FactionData[factionid][factionLockerPos][1], FactionData[factionid][factionLockerPos][2],FactionData[factionid][factionLockerInt],FactionData[factionid][factionLockerWorld]);
			}*/
		}
	}
	return 1;
}
	


forward WaterPlant(playerid);
public WaterPlant(playerid){
	new idplant = GetPVarInt(playerid, "Plantid");

	ClearAnimations(playerid);
	RemoveAttachedObject(playerid, 4);
	PlantData[idplant][plantWater] += 20;
	SendClientMessage(playerid, COLOR_GREEN, "ระดับน้ำของต้นพืช +20");
	TogglePlayerControllable(playerid, 1);
	Plant_Refresh(idplant);
	Plant_Save(idplant);
	PlantData[idplant][plantUse] = 0;
	return 1;
}

forward LoginCheck(playerid);
public LoginCheck(playerid)
{
    TogglePlayerSpectating(playerid, 0);
    LoggedIn[playerid] = true;
	return 1;
}

Dialog:ChangeSpawn(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch (listitem)
		{
			case 0:
		    {
				Character[playerid][Spawn] = 1;
				SendClientMessage(playerid, COLOR_ORANGE, "[INFO]: คุณได้เปลี่ยนจุดเกิดเป็น 'จุดล่าสุด'");

			}
			case 1:
		    {
		        if(Character[playerid][FactionID] == -1)
		            return SendClientMessage(playerid, -1, "คุณไม่มี Faction");
		    
				Character[playerid][Spawn] = 2;
				SendClientMessage(playerid, COLOR_ORANGE, "[INFO]: คุณได้เปลี่ยนจุดเกิดเป็น 'จุดเกิด Faction'");

			}
			case 2:
		    {
				new string[2048], menu[20], count;

				for (new i = 0; i < MAX_HOUSES; i ++) 
				{
					if (HouseData[i][houseExists]) 
					{
						if (House_IsOwner(playerid, i)) 
						{
							format(string, sizeof(string), "%s %s (%d) | HOUSESQLID: %d\n", string, HouseData[i][houseAddress], i, HouseData[i][houseID]);
							format(menu, 20, "menu%d", ++count);
						}
					}
				}
				if(!count) Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "เลือกบ้านที่จะเกิด", "คุณไม่มีบ้านอยู่เลย", "โอเค", "");
				else Dialog_Show(playerid, SelectHouseSpawn, DIALOG_STYLE_LIST, "เลือกบ้านที่จะเกิด", string, "เลือก", "ยกเลิก");
				return 1;
			}
		}
	}
    return 1;
}

forward CheckActivity(playerid);
public CheckActivity(playerid)
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	if(InactivtyCheck_X[playerid] == pos[0] && InactivtyCheck_Y[playerid] == pos[1] && InactivtyCheck_Z[playerid] == pos[2] && gettime() - LastCommandTime[playerid] > 899)
	{
		new str[128];
		format(str, sizeof(str), "%s has been kicked for inactivty.", GetRoleplayName(playerid));
		SendPunishmentMessage(str);
		KickPlayer(playerid);
	}
	else
	{
		InactivtyCheck_X[playerid] = pos[0];
		InactivtyCheck_Y[playerid] = pos[1];
		InactivtyCheck_Z[playerid] = pos[2];
	}
	return 1;
}

stock Register(playerid)
{
    
	TogglePlayerSpectating(playerid, 0);
	
	SetSpawnInfo(playerid, NO_TEAM, Character[playerid][Skin], 1451.1232,-2286.9854,13.5469, 0, 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);

    Character[playerid][Bank] = 3000;
 	Character[playerid][Level] = 1;
	Character[playerid][PosX] = 1451.1232;
	Character[playerid][PosY] = -2286.9854;
	Character[playerid][PosZ] = 13.5469;
	Character[playerid][Skin] = 1;
	Character[playerid][Age] = 18;
	Character[playerid][Capacity] = 35;
	Character[playerid][Hungry] = 100;
	Character[playerid][Thirsty] = 100;
	Character[playerid][ConfirmChar] = 0;
	LoggedIn[playerid] = true;
	Character[playerid][Injured] = 0;
	Character[playerid][InjuredTime] = 0;
	Character[playerid][InjuredEx]= 0;
	Character[playerid][InjuredSpawn] = 0;
	Character[playerid][InjuredShoot] = 0;
	Character[playerid][ClothesSelection] = 1;
	return 1;
}

stock SetSelectionPos(playerid)
{
	SetPlayerPos(playerid, NoobSpawns[0][0],NoobSpawns[0][1],NoobSpawns[0][2]);
	SetPlayerFacingAngle(playerid, NoobSpawns[0][3]);
	
	SetPlayerInterior(playerid, 18);
	SetPlayerVirtualWorld(playerid, playerid + 1000);

	SetPlayerCameraPos(playerid,181.6707, -88.0618, 1002.0234);
	SetPlayerCameraLookAt(playerid,181.6707, -88.0618, 1002.0234);
	
	TogglePlayerControllable(playerid, 0);
	return 1;
}




#define WRONG 0
#define CORRECT 1
#define BANNED 2

//new QAnswer[MAX_PLAYERS] = 0;

/*new QuizQuestions[][][] = {

	{"1", "[QUIZ] Is it ever acceptable to ban evade?", " (A) No, doing so will result in the loss of any chance of getting unbanned. \n (B) Yes, unless you were caught hacking. \n (C) No, unless you feel that you've been wrongfully banned. \n (D) No, unless any player tells you otherwise."},
	{"2", "[QUIZ] Are certain hacks permitted on the server?", " (A) Yes, a very small proportion of hacks are indeed permitted for use. \n (B) No, under no circumstances should hacks be used/installed when playing on this server. \n (C) No, unless an individual with high authority creates an extenuating circumstance for you and gives you the go-ahead. \n (D) Indeed, all hacks can be used provided that they are used sensibly."},
	{"3", "[QUIZ] Which of the following adheres to the correct use of an expression of quantity?", " (A) 1 Grands \n (B) 1 Millions \n (C) 1 Million \n (D) 5 Millions."},
	{"2", "[QUIZ] How can the term 'METAGAMING' be defined?", " (A) Messing around OOCly. \n (B) Using information obtained OOC'ly in an IC situation.\n (C) Using information obtained IC'ly in an OOC situation.\n (D) Forcing certain actions upon a player."},
	{"4", "[QUIZ] How can the term 'POWERGAMING' be defined?", " (A) The act of acquiring a position of power within the server. \n (B) Using the OOC chat IC'ly. \n (C) Acting in a realistic manner that can be appreciated by all. \n (D) None of the above."},
	{"1", "[QUIZ] How can the term 'Money Farming' be defined?", " (A) Creating Characters for the sole purpose of gaining money. \n (B) Adopting a farm IC'ly, and selling goods produced by this farm with the intention to make profit. \n (C) Taking on the role of a homeless individual and begging others for money with adequate role-play. \n (D) Approaching other community members and offering to pay IRL cash in return for IG cash."},
	{"3", "[QUIZ] What is the correct definition of the abbreviation 'IC'?", " (A) In Chapter - A specific chapter in your character's life. \n (B) In Church - The act of role-playing within a church. \n (C) In Character - Taking the role of your character and acting realistically and appropriately whilst doing so. \n (D) Idiotic Characters - The concept of role-playing characters of the idiotic nature."},
	{"3", "[QUIZ] Select the proper form of a /me.", " (A) /me there is a bottle by my feet. \n (B) /me you would hear the vehicle screeching to a halt. \n (C) /me rotates his head as he catches a glimpse of the suited man."},
	{"2", "[QUIZ] Select the proper form of a /do.", " (A) /do paces himself to his intended destination, panting heavily upon arrival. \n (B) /do Large quantities of blood would be seen cascading down from my receding hairline. \n (C) /do Places his dominant hand on the his waist, as he swiftly lifts his shirt and withdraws the pistol from his waistline. \n (D) /do What do you think you're doing?"},
	{"2", "[QUIZ] What is the correct usage of the standard IC chat?", " (A) Hey, how long have you been role-playing on this server? \n (B) Greetings, the name's Donovan, but you may call me Don. \n (C) Woah, what is that name tag hovering over your head and where can I procure one? \n (D) What is the CMD to check which administrator are online at the moment?"},
	{"4", "[QUIZ] What is the expected way to speak to an administrator when requesting for assistance?", " (A) Uh, where the fuck is my car, you fucking knob? \n (B) I just logged in and I can't seem to see car anywhere, TP it to me this instant. \n (C) This guy in front of me has absolutely no idea how to RP, ban him now. \n (D) Hi, I was wondering if you could possibly TP to me, I appear to be experiencing a bug that requires your attention."},
	{"4", "[QUIZ] Which of the following is expected of you when playing on this server?", " (A) Act politely in the IC chat, avoid any illegal role-play whatsoever. \n (B) Role-playing with others at all times, as oppose to role-playing passively. \n (C) Logging in with a ping that never exceeds 100 or more. \n (D) Role-playing realistically and to the standards that satisfy that of SC:RP."},
	{"1", "[QUIZ] What is the threshold in relation to the things you are permitted to role-play?", " (A) Non-existent, with the exception of pedophilia and so long as the actions demonstrated are realistic. \n (B) Illegal role-play - Under no circumstances should such role-play be exercised. \n (C) Passive role-play - Role-play must always involve other parties for it to be regarded as realistic. \n (D) None of the above."},
	{"3", "[QUIZ] What is the minimum age to play on this server?", " (A) 18. \n (B) 16. \n (C) There is none, so long as the standards of English and the standards of role-play upholds what is expected on SC:RP. \n (D)  14."}, 
	{"4", "[QUIZ] Are OOC insults permitted in this community?", " (A) Yes, but only when the opposing party has warranted the particular insult. \n (B) Yes, members who partake in the community must neglect all emotions and simply ignore insults that are thrown towards them. \n (C) No, unless you are conversing with an administrator. \n (D) No, under no circumstances should words of such nature be undertook."}
};*/

stock DBNameCheck(playerid, string[])
{
	new query[400];
	mysql_format(dbCon, query, sizeof(query), "SELECT * FROM Characters WHERE Name = '%s' LIMIT 1", string);
	mysql_tquery(dbCon, query, "FreeNameCheck", "i", playerid);
	return 1;
}
forward FreeNameCheck(playerid);
public FreeNameCheck(playerid)
{
 	if(cache_num_rows())
    {
   		 SystemMsg(playerid, "ชื่อนี้มีผู้ใช้งานแล้ว!");
   		 format(Character[playerid][Username], 32, "");
		 Dialog_Show(playerid, CREATECHARACTER, DIALOG_STYLE_INPUT, "การสร้างตัวละคร", "กรุณาใส่ชื่อตัวละครใหม่ของคุณด้านล่าง:\n\nคำเตือน: ชื่อของคุณต้องอยู่ในรูปแบบ Firstname_Lastname และไม่เกิน 20 ตัวอักษร:", "Create","Cancel");

    }
    else
    {
        	SetPlayerName(playerid, Character[playerid][Username]);
	        new query[400];
   			GetPlayerIp(playerid, Character[playerid][RegisterIP], 16);
	    	mysql_format(dbCon, query, sizeof(query), "INSERT INTO characters (A_ID, Name, RegisterIP, RegisterDate) VALUES(%d, '%s','%s', '%s')", Account[playerid][SQLID], Character[playerid][Username], Character[playerid][RegisterIP], ReturnDate());
			mysql_tquery(dbCon, query, "GetCharacterID", "i", playerid);
			Register(playerid);
    }
	return 1;
}
/*stock Quiz(playerid, section)
{
	
    if(section == 1)
	{
		Dialog_Show(playerid, QUIZ1, DIALOG_STYLE_LIST, "[QUIZ] Do you know how to Roleplay?"," (A) Yes\n (B) No","Select","");
	}
    else
	{
	    new rand = random(sizeof(QuizQuestions));

	    CreateSpacer(playerid, 10);

	    format(QAnswer[playerid], 2, "%d", strval(QuizQuestions[rand][0]));

		Dialog_Show(playerid, QUIZ2, DIALOG_STYLE_LIST, QuizQuestions[rand][1], QuizQuestions[rand][2],"Select","");

		SendSplitMessage(playerid, COLOR_SLATEGRAY, QuizQuestions[rand][1]);
		SendSplitMessage(playerid, COLOR_WHITE, QuizQuestions[rand][2]);
	}
	return 1;
}

Dialog:QUIZ1(playerid, response, listitem, inputtext[])
{
	if(listitem == 0)
	{
	    Quiz_Info(playerid, CORRECT, 2);
    }
    else
    {
		Quiz_Info(playerid, BANNED, 0);
    }
    return 1;
}*/

stock NameValidator(pname[])
{
    new underline=0;
    //GetPlayerName(playerid, pname, sizeof(pname));pname[MAX_PLAYER_NAME],
    if(strfind(pname,"[",true) != (-1)) return 0;
    else if(strfind(pname,"]",true) != (-1)) return 0;
    else if(strfind(pname,"$",true) != (-1)) return 0;
    else if(strfind(pname,"(",true) != (-1)) return 0;
    else if(strfind(pname,")",true) != (-1)) return 0;
    else if(strfind(pname,"=",true) != (-1)) return 0;
    else if(strfind(pname,"@",true) != (-1)) return 0;
    else if(strfind(pname,"0",true) != (-1)) return 0;
    else if(strfind(pname,"1",true) != (-1)) return 0;
    else if(strfind(pname,"2",true) != (-1)) return 0;
    else if(strfind(pname,"3",true) != (-1)) return 0;
    else if(strfind(pname,"4",true) != (-1)) return 0;
    else if(strfind(pname,"5",true) != (-1)) return 0;
    else if(strfind(pname,"6",true) != (-1)) return 0;
    else if(strfind(pname,"7",true) != (-1)) return 0;
    else if(strfind(pname,"8",true) != (-1)) return 0;
    else if(strfind(pname,"9",true) != (-1)) return 0;
    new maxname = strlen(pname);
    for(new i=2; i<maxname; i++)
    {
       if(pname[i] == '_') underline ++;
    }
    if(underline != 1) return 0;

    else
    {
    	return 1;
    }

}

Dialog:CREATECHARACTER(playerid, response, listitem, inputtext[])
{
	if(!response) 
	{
		KickPlayer(playerid);
		return 0;
	}

    else if(response)
    {
        if(NameValidator(inputtext))
		{
			format(Character[playerid][Username], 32, "%s", inputtext);
			DBNameCheck(playerid, inputtext);
		}
		else
		{
		    SendErrorMessage(playerid, "ชื่อไม่ถูกต้อง!!.");
		    Dialog_Show(playerid, CREATECHARACTER, DIALOG_STYLE_INPUT, "การสร้างตัวละคร", "กรุณาใส่ชื่อตัวละครใหม่ของคุณด้านล่าง:\n\nคำเตือน: ชื่อของคุณต้องอยู่ในรูปแบบ Firstname_Lastname และไม่เกิน 20 ตัวอักษร:", "Create","Cancel");
		}
	}
    return 1;
}


/*Dialog:QUIZ2(playerid, response, listitem, inputtext[])
{
	if(listitem + 1 == strval(QAnswer[playerid]))
	{
		if(Character[playerid][QuizProgress] < 5)
		{
			Character[playerid][QuizProgress]++;
			Quiz_Info(playerid, CORRECT, 3);
		}
		else
		{
			CreateSpacer(playerid, 10);
			Character_Create(playerid);
		}
	}
	else
	{
		Quiz_Info(playerid, WRONG, 0);
	}
    return 1;
}

stock Quiz_Info(playerid, info, section)
{
	if(info == 0)
	{
	    InfoBoxForPlayer(playerid, "That is the ~r~INCORRECT ~w~please review your answer - reconnect to try the quiz again.");
        KickPlayer(playerid);
	}
	if(info == 1)
	{
	    InfoBoxForPlayer(playerid, "Good job, you got the answer ~g~CORRECT~w~!");
	    Quiz(playerid, section);
	}
	else if(info == 2)
	{
		IssueBan(playerid, "Auto", "Failed quiz");
        InfoBoxForPlayer(playerid, "~r~You don't know how to roleplay thus have been banned from this ~g~HEAVY~r~ roleplay server.");
	}
	return 1;
}
*/


forward LoadObjects();
public LoadObjects()
{
	if(cache_num_rows())
    {
        for(new i = 0; i<cache_num_rows(); i++)
        {
            cache_get_value_name_int(i, "SQLID", Objects[i+1][SQLID]);
            cache_get_value_name(i, "Name", Objects[i+1][Name], 126);
            cache_get_value_name_int(i, "Model", Objects[i+1][Model]);
            cache_get_value_name_float(i, "PosX", Objects[i+1][PosX]);
            cache_get_value_name_float(i, "PosY", Objects[i+1][PosY]);
            cache_get_value_name_float(i, "PosZ", Objects[i+1][PosZ]);
            cache_get_value_name_float(i, "AngX", Objects[i+1][AngX]);
            cache_get_value_name_float(i, "AngY", Objects[i+1][AngY]);
            cache_get_value_name_float(i, "AngZ", Objects[i+1][AngZ]);
            cache_get_value_name_int(i, "World", Objects[i+1][World]);
            cache_get_value_name_int(i, "Interior", Objects[i+1][Interior]);
            cache_get_value_name_int(i, "Movable", Objects[i+1][Movable]);
            cache_get_value_name_float(i, "NewX", Objects[i+1][NewX]);
            cache_get_value_name_float(i, "NewY", Objects[i+1][NewY]);
            cache_get_value_name_float(i, "NewZ", Objects[i+1][NewZ]);
            cache_get_value_name_float(i, "aNewX", Objects[i+1][aNewX]);
            cache_get_value_name_float(i, "aNewY", Objects[i+1][aNewY]);
            cache_get_value_name_float(i, "aNewZ", Objects[i+1][aNewZ]);
            

			Total_Objects_Created++;

	        if(Objects[i+1][Model] >= 1)
	        {
				Objects[i+1][ObjectID] = CreateDynamicObject(Objects[i+1][Model], Objects[i+1][PosX], Objects[i+1][PosY], Objects[i+1][PosZ], Objects[i+1][AngX], Objects[i+1][AngY], Objects[i+1][AngZ], Objects[i+1][World], Objects[i+1][Interior], -1, 200.0, 0.0);
			
			}
		}
	}
	printf("[MYSQL]: %d Objects have been successfully loaded from the database.", Total_Objects_Created);
	return 1;
}

stock IsSomethingInRangeOfPoint(Float:radi, Float:x, Float:y, Float:z, Float:obx, Float:oby, Float:obz)
{
	new Float:tempposx, Float:tempposy, Float:tempposz;

	tempposx = (obx -x);
	tempposy = (oby -y);
	tempposz = (obz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}


forward OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	new fID = -1;
	//new string[128];
	
	
	for(new i = 1; i < MAX_OBJECTZ; i++)
	{
	    if(Objects[i][ObjectID] == objectid)
		{
			fID = i;
			break;
		}
	}

 	if(fID == -1)
	{
	    if (Character[playerid][EditFurniture] != -1 && FurnitureData[Character[playerid][EditFurniture]][furnitureExists])
		{
		    if (response == EDIT_RESPONSE_FINAL)
		    {
		        new id = House_Area(playerid);

		        if (id != -1 && House_IsOwner(playerid, id))
				{
				    if((IsSomethingInRangeOfPoint(15.0, HouseData[id][housePos][0], HouseData[id][housePos][1], HouseData[id][housePos][2], x, y, z)) || (GetPlayerInterior(playerid) == HouseData[id][houseInterior] && GetPlayerVirtualWorld(playerid) > 0 && HouseData[id][houseID] == Character[playerid][House]))
				    {
				    FurnitureData[Character[playerid][EditFurniture]][furniturePos][0] = x;
				    FurnitureData[Character[playerid][EditFurniture]][furniturePos][1] = y;
				    FurnitureData[Character[playerid][EditFurniture]][furniturePos][2] = z;
	                FurnitureData[Character[playerid][EditFurniture]][furnitureRot][0] = rx;
	                FurnitureData[Character[playerid][EditFurniture]][furnitureRot][1] = ry;
	                FurnitureData[Character[playerid][EditFurniture]][furnitureRot][2] = rz;

					Furniture_Refresh(Character[playerid][EditFurniture]);
					Furniture_Save(Character[playerid][EditFurniture]);

					SendClientMessageEx(playerid, -1, "คุณได้แก้ไขตำแหน่งของไอเท็ม \"%s\"", FurnitureData[Character[playerid][EditFurniture]][furnitureName]);
					}
					else
					{
					    Furniture_Refresh(Character[playerid][EditFurniture]);
					    SendClientMessage(playerid, -1, "ตำแหน่งของไอเท็มนี้ไม่ได้อยู่ภายในอาณาเขตบ้านของคุณ");
					}
				}
			}
		}
	
	    if (Character[playerid][EditPump] != -1 && PumpData[Character[playerid][EditPump]][pumpExists])
		{
	 		if (response == EDIT_RESPONSE_FINAL)
	   		{
				PumpData[Character[playerid][EditPump]][pumpPos][0] = x;
				PumpData[Character[playerid][EditPump]][pumpPos][1] = y;
				PumpData[Character[playerid][EditPump]][pumpPos][2] = z;
				PumpData[Character[playerid][EditPump]][pumpPos][3] = rz;

				Pump_Refresh(Character[playerid][EditPump]);
				Pump_Save(Character[playerid][EditPump]);

				SendClientMessageEx(playerid, -1, "คุณได้แก้ไขตำแหน่งของปั้มไอดี: %d", Character[playerid][EditPump]);
			}
		}
		return 1;
	}

	if(Character[playerid][DeleteingObject] == 0)
	{
		if(response == EDIT_RESPONSE_FINAL)
		{
			new query[280];
			
			mysql_format(dbCon, query, sizeof(query), "UPDATE Objects SET PosX = %f, PosY = %f, PosZ = %f, AngX = %f, AngY = %f, AngZ = %f WHERE SQLID = %d LIMIT 1", x, y, z, rx, ry, rz, Objects[fID][SQLID]);
	    	mysql_tquery(dbCon, query);
			Objects[fID][PosX] = x;
			Objects[fID][PosY] = y;
			Objects[fID][PosZ] = z;
			Objects[fID][AngX] = rx;
			Objects[fID][AngY] = ry;
			Objects[fID][AngZ] = rz;
	    	return 1;
		}
	}

	if(Character[playerid][DeleteingObject] == 1)
	{
		new query[128], str[128];
		mysql_format(dbCon, query, sizeof(query), "DELETE FROM `%s`.`Objects` WHERE `Objects`.`SQLID` = %d", MYSQL_DB, Objects[fID][SQLID]);
		mysql_tquery(dbCon, query);

		Total_Objects_Created --;
		DestroyDynamicObject(Objects[fID][ObjectID]);


		format(str, sizeof(str), "%s has deleted a object(ID:%d).", GetRoleplayName(playerid), fID);
		SendAdminsMessage(1, COLOR_ORANGERED, str);

		ResetObjectVariables(fID);
		Character[playerid][DeleteingObject] = 0;
	}

    /*if(Character[playerid][MovableObject] == 1)
    {
		if(response == EDIT_RESPONSE_CANCEL)
		{
		    SetDynamicObjectPos(objectid, Objects[fID][PosX], Objects[fID][PosY], Objects[fID][PosZ]);
		    SetDynamicObjectRot(objectid, Objects[fID][AngX], Objects[fID][AngY], Objects[fID][AngZ]);
		    Character[playerid][DeleteingObject] = 0;
		    Character[playerid][MovableObject] = 0;
		}
	}*/


	if (response == EDIT_RESPONSE_FINAL || response == EDIT_RESPONSE_CANCEL)
	{
	    /*if (Character[playerid][EditFurniture] != -1)
			Furniture_Refresh(Character[playerid][EditFurniture]);*/

	    if (Character[playerid][EditPump] != -1)
			Pump_Refresh(Character[playerid][EditPump]);

		Character[playerid][EditPump] = -1;
		Character[playerid][GasStation] = -1;
		//Character[playerid][EditFurniture] = -1;
	}
	return 1;
}


stock ReloadObjects()
{

	for(new id = 0; id < MAX_OBJECTZ; id++)
    {
        if(IsValidDynamicObject(Objects[id][ObjectID]))
        {
			DestroyDynamicObject(Objects[id][ObjectID]);
			ResetObjectVariables(id);
			Total_Objects_Created --;
		}
	}
	mysql_tquery(dbCon, "SELECT * FROM `Objects`", "LoadObjects");
	return 1;
}

stock GetInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
    // Created by Y_Less

    new Float:a;

    GetPlayerPos(playerid, x, y, a);
    GetPlayerFacingAngle(playerid, a);

    if (GetPlayerVehicleID(playerid)) 
    {
        GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
    }

    x += (distance * floatsin(-a, degrees));
    y += (distance * floatcos(-a, degrees));
}

forward GetObjectID(fID);
public GetObjectID(fID)
{
	Objects[fID][SQLID] = cache_insert_id();
	printf("%d %d", Objects[fID][SQLID], fID);
	return 1;
}


stock ResetObjectVariables(fID)
{
	Objects[fID][SQLID] = 0;
	Objects[fID][ObjectID] = 0;
	Objects[fID][Name] = 0;
	Objects[fID][Model] = 0;
	Objects[fID][PosX] = 0;
	Objects[fID][PosY] = 0;
	Objects[fID][PosZ] = 0;
	Objects[fID][AngX] = 0;
	Objects[fID][AngY] = 0;
	Objects[fID][AngZ] = 0;
	Objects[fID][Movable] = 0;
	Objects[fID][NewX] = 0;
	Objects[fID][NewY] = 0;
	Objects[fID][NewZ] = 0;
	Objects[fID][aNewX] = 0;
	Objects[fID][aNewY] = 0;
	Objects[fID][aNewZ] = 0;
	return 1;
}

public OnPlayerRequestClass(playerid,classid)
{
	SpawnPlayer(playerid);
	SetPlayerSkin(playerid, Character[playerid][Skin]);
    return 1;
}

forward OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float:x, Float:y, Float:z);
public OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float:x, Float:y, Float:z)
{
	new fID = -1;
	for(new i = 1; i < MAX_OBJECTZ; i++)
	{
	    if(Objects[i][ObjectID] == objectid)
		{
			fID = i;
			break;
		}
	}

	if(fID == -1) return 1;


	if(IsValidDynamicObject(Objects[fID][ObjectID]))
    {
    	EditDynamicObject(playerid, Objects[fID][ObjectID]);
    }
	return 1;
}

stock InformationBox(playerid, text[])
{
    TextDrawSetString(InfoBox[playerid], text);
	TextDrawShowForPlayer(playerid, InfoBox[playerid]);
    InformationBoxTimer[playerid] = SetTimerEx("HideInformationBox", SECONDS(1), true, "d", playerid);
	return 1;
}

forward HideInformationBox(playerid);
public HideInformationBox(playerid)
{
	if(gettime() - LastPickup[playerid] > 4)
	{
		PickedUpPickup[playerid] = false;
		TextDrawHideForPlayer(playerid, InfoBox[playerid]);
		KillTimer(InformationBoxTimer[playerid]);
	}
	return 1;
}


public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	new i;
	
	if(pickupid == BankPayCheck)
	{
	    if(Character[playerid][Paycheck] > 0)
		{
	        GiveMoney(playerid, Character[playerid][Paycheck], "Get Paycheck %d", Character[playerid][Paycheck]);
	        SendClientMessageEx(playerid, -1, "คุณได้รับเงิน Paycheck จำนวน $%d", Character[playerid][Paycheck]);
	        Character[playerid][Paycheck] = 0;
		}
	}
	
	if(PickedUpPickup[playerid] == false)
	{
		PickedUpPickup[playerid] = true;
	    LastPickup[playerid] = gettime();
	    
	    for(i = 0; i < MAX_BUSINESSES; i++)
	    {
	        if(pickupid == BusinessData[i][bizPickup])
	        {
			    new str[128];
				if (!BusinessData[i][bizOwner])
				{
			    	format(str, sizeof(str), "~y~%s~n~~w~Price:%s", BusinessData[i][bizName],FormatNumber(BusinessData[i][bizPrice]));
			    	InformationBox(playerid, str);
				}
				else
				{
					if(BusinessData[i][bizOwner] == 99999999){
						if (BusinessData[i][bizLocked]) {
					    format(str, sizeof(str), "%s~n~Admin~n~~r~Close", BusinessData[i][bizName]);
					    InformationBox(playerid, str);
						}
						else {
							format(str, sizeof(str), "%s~n~Admin~n~~g~Open", BusinessData[i][bizName]);
							InformationBox(playerid, str);
						}
					}
					else{
						if (BusinessData[i][bizLocked]) {
							format(str, sizeof(str), "%s~n~%s~n~~r~Close", BusinessData[i][bizName], BusinessData[i][bizOwner] ? GetIDFromName(BusinessData[i][bizOwner]) : ("State"));
							InformationBox(playerid, str);
						}
						else {
							format(str, sizeof(str), "%s~n~%s~n~~g~Open", BusinessData[i][bizName], BusinessData[i][bizOwner] ? GetIDFromName(BusinessData[i][bizOwner]) : ("State"));
							InformationBox(playerid, str);
						}
					}
				}
			    return 1;
			}
		}
		
		for(i = 0; i < MAX_HOUSES; i++)
	    {
	        if(pickupid == HouseData[i][housePickup])
	        {
			    new str[128];
				if (!HouseData[i][houseOwner])
				{
			    	format(str, sizeof(str), "~y~%s~n~~w~Price: %s", HouseData[i][houseAddress],FormatNumber(HouseData[i][housePrice]));
			    	InformationBox(playerid, str);
				}
				else
				{
					if (HouseData[i][houseLocked]) {
					    format(str, sizeof(str), "%s~n~%s~n~~r~Close", HouseData[i][houseAddress], HouseData[i][houseOwner] ? GetIDFromName(HouseData[i][houseOwner]) : ("State"));
					    InformationBox(playerid, str);
					}
					else {
					    format(str, sizeof(str), "%s~n~%s~n~~g~Open", HouseData[i][houseAddress], HouseData[i][houseOwner] ? GetIDFromName(HouseData[i][houseOwner]) : ("State"));
					    InformationBox(playerid, str);
					}
				}
			}
		}
		
		for(i = 0; i < MAX_ENTRANCES; i++)
	    {
			
			if(pickupid == EntranceData[i][entrancePickup])
	        {
			    new str[128];
				if (EntranceData[i][entranceLocked]) {
    				format(str, sizeof(str), "%s~n~~r~Close", EntranceData[i][entranceName]);
				    InformationBox(playerid, str);
				}
				else {
					format(str, sizeof(str), "%s~n~~g~Open", EntranceData[i][entranceName]);
					InformationBox(playerid, str);
				}
			    return 1;
			}
		}
	}
    return 1;
}

stock IsVehicleSpawned(vehicleid)
{
	new Float:X,Float:Y,Float:Z;
	GetVehiclePos(vehicleid, X, Y, Z);
	if (X == 0.0 && Y == 0.0 && Z == 0.0) return 0;
	return 1;
}


forward SetPlayerMoneyEx(playerid, amount);
public SetPlayerMoneyEx(playerid, amount)
{
	Character[playerid][Cash] = amount;
	MYSQL_Update_Character(playerid, "Cash", Character[playerid][Cash]);

    ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, Character[playerid][Cash]);
	return 1;
}

forward GivePlayerMoneyEx(playerid, amount);
public GivePlayerMoneyEx(playerid, amount)
{
	Character[playerid][Cash] += amount;
	MYSQL_Update_Character(playerid, "Cash", Character[playerid][Cash]);

    ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, Character[playerid][Cash]);
	return 1;
}


stock IsInRangeOfPlayer(playerid, targetid, distance)
{
    new Float:TargetPos[3];
    GetPlayerPos(targetid, TargetPos[0], TargetPos[1], TargetPos[2]);
    if(IsPlayerInRangeOfPoint(playerid, distance, TargetPos[0], TargetPos[1], TargetPos[2])) return 1;
    return 0;
}


stock IsABike(vid)
{
	new modelid = GetVehicleModel(vid);
	if(modelid == 509||modelid == 510||modelid == 481) return 1;
	else return 0;
}

stock GetNearestVehicle(playerid, Float:dis)
{
    new Float:X, Float:Y, Float:Z;
    if(GetPlayerPos(playerid, X, Y, Z))
    {
        new vehicleid = INVALID_VEHICLE_ID;
        for(new v, Float:temp, Float:VX, Float:VY, Float:VZ; v != MAX_VEH; v++)
        {
            if(GetVehiclePos(v, VX, VY, VZ))
            {
                VX -= X, VY -= Y, VZ -= Z;
                temp = VX * VX + VY * VY + VZ * VZ;
                if(temp < dis) dis = temp, vehicleid = v;
            }
        }
        dis = floatpower(dis, 1.0);
        return vehicleid;
    }
    return INVALID_VEHICLE_ID;
}

stock InRangeOfPump(playerid)
{
	for(new id = 0; id < MAX_OBJECTZ; id++)
	{
    	if(IsPlayerInRangeOfPoint(playerid, 8.0, Objects[id][PosX], Objects[id][PosY], Objects[id][PosZ]) && Objects[id][Model] == 1676)
		{
			return 1;
		}
	}
    return 0;
}

stock InRangeOfMovableObject(playerid)
{
	for(new id = 1; id < MAX_OBJECTZ; id++)
	{
    	if(IsPlayerInRangeOfPoint(playerid, 4.0, Objects[id][PosX], Objects[id][PosY], Objects[id][PosZ]) && Objects[id][Movable] == 1)
		{
			return id;
		}
	}
    return 0;
}

stock FindVehicleByNameID(const vname[])
{

    if('4' <= vname[0] <= '6') return INVALID_VEHICLE_ID;

    for(new i,LEN = strlen(vname); i != sizeof(VehicleNames); i++)
        if(!strcmp(VehicleNames[i],vname,true,LEN))
            return i + 400;

    return INVALID_VEHICLE_ID;
}


stock Restricted_Vehicle(vID)
{
	if(vID == 520 || vID == 425 || vID == 577 || vID == 432 || vID == 406 || vID == 592)
	{
	    return 1;
	}
	return 0;
}

stock IsVehicleTaxi(vID)
{
	if(vID == 420 || vID == 438)
	{
	    return 1;
	}
	return 0;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	taser[playerid] = false;
	GiveTaserAgainTimer[playerid] = 0;
	lastWeapon[playerid] = 0;

    AC_SetPlayerHealth(playerid, 100);
	return 1;
}

forward Hospital(playerid);
public Hospital(playerid)
{
	TogglePlayerSpectating(playerid, false);
	TogglePlayerControllable(playerid, true);

	Character[playerid][Armour] = 0;
	Character[playerid][Health] = 100;
	Character[playerid][InHospital] = 0;

	new fee = (random(100) + 25) * Character[playerid][Level];

	SetPlayerHealth(playerid, Character[playerid][Health]);
	SetPlayerArmour(playerid, Character[playerid][Armour]);
	GivePlayerMoneyEx(playerid, -fee);
	SetPlayerPosEx(playerid, -320.2086, 1048.7581, 20.3403, 0, 0);
	SetPlayerFacingAngle(playerid, 91.4410);

	TextDrawHideForPlayer(playerid, BlackScreen[playerid]);
	TextDrawHideForPlayer(playerid, BlackOutText[playerid]);

	new str[128];
	format(str, sizeof(str), "คุณได้พักฟื้นที่โรงพยาบาลใกล้ๆและเสียค่าใช้จ่ายไป $%d.", fee);
	SendClientMessage(playerid, COLOR_PALETURQUOISE, str);
	
	Character[playerid][InjuredSpawn] = 0;
	return 1;
}

//==============================================================================
//
//      -- > PLAYER COMMANDS
//
//==============================================================================
stock Line(playerid)
{
	SendClientMessage(playerid, COLOR_IVORY, "_________________________________________________");
	return 1;
}

forward Move_Player(playerid, Float:X, Float:Y, Float:Z);
public Move_Player(playerid, Float:X, Float:Y, Float:Z)
{
	SetPlayerPos(playerid, X, Y, Z);
	return 1;
}


forward UnfreezePlayer(playerid);
public UnfreezePlayer(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}

FormatNumber(number, prefix[] = "$")
{
	new
		value[32],
		length;

	format(value, sizeof(value), "%d", (number < 0) ? (-number) : (number));

	if ((length = strlen(value)) > 3)
	{
		for (new i = length, l = 0; --i >= 0; l ++) {
		    if ((l > 0) && (l % 3 == 0)) strins(value, ",", i + 1);
		}
	}
	if (prefix[0] != 0)
	    strins(value, prefix, 0);

	if (number < 0)
		strins(value, "-", 0);

	return value;
}





//==============================================================================
//          -- > Chat Functions
//==============================================================================




stock SendSplitMessage(playerid, color, final[])
{
    #pragma unused playerid, color
    new buffer[SPLITLENGTH+5];
    new len = strlen(final);
    if(len>SPLITLENGTH)
    {
        new times = (len/SPLITLENGTH);
        for(new i = 0; i < times+1; i++)
        {
            strdel(buffer, 0, SPLITLENGTH+5);
            if(len-(i*SPLITLENGTH)>SPLITLENGTH)
            {
                strmid(buffer, final, SPLITLENGTH*i, SPLITLENGTH*(i+1));
                format(buffer, sizeof(buffer), "%s ...", buffer);
            }
            else
            {
                strmid(buffer, final, SPLITLENGTH*i, len);
            }
            SendClientMessage(playerid, color, buffer);
        }
    }
    else
    {
        //if == 1 - normal if = 2 asay
        SendClientMessage(playerid, color, final);
    }
}

stock SendLocalMessage(playerid, msg[], Float:MessageRange, Range1color, Range2color)
{
    new Float: PlayerX, Float: PlayerY, Float: PlayerZ;
    GetPlayerPos(playerid, PlayerX, PlayerY, PlayerZ);
    for(new i = 0; i < MAX_PLAYERS; i++ )
    {
        if(IsPlayerInRangeOfPoint(i, MessageRange, PlayerX, PlayerY,PlayerZ))
        {
            SendSplitMessage(i, Range1color, msg);
        }
        else if(IsPlayerInRangeOfPoint(i, MessageRange/2.0, PlayerX, PlayerY,PlayerZ))
        {
            SendSplitMessage(i, Range2color, msg);
        }
    }
    return 1;
}


stock SendPunishmentMessage(str[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            if(LoggedIn[i] == true)
            {
                new astr[128];
                format(astr, sizeof(astr), "[เซิฟเวอร์] %s", str);
                SendClientMessage(i, COLOR_ORANGE, astr);
             }
        }
    }
    return 1;
}

stock SendErrorMessage(playerid, str[])
{
    new astr[128];
    format(astr, sizeof(astr), "> [เกิดข้อผิดพลาด] %s <", str);
    SendClientMessage(playerid, COLOR_RED, astr);
    return 1;
}

stock SendInfoMessage(playerid, str[])
{
    new astr[128];
    format(astr, sizeof(astr), "[ข้อมูล] %s", str);
    SendClientMessage(playerid, COLOR_LBLUE, astr);
    return 1;
}

stock SendAdminsMessage(level, color, str[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            new astr[128];
            if(Account[i][Admin] >= level)
            {
                format(astr, sizeof(astr), "[Admin-Message] %s", str);
                SendClientMessage(i, color, astr);
            }
        }
    }
}

stock IsWindowedVehicle(vehicleid)
{
	static const g_aWindowStatus[] = {
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1,
	    1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1,
		1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1,
		1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
	};
	new modelid = GetVehicleModel(vehicleid);

    if (modelid < 400 || modelid > 611)
        return 0;

    return (g_aWindowStatus[modelid - 400]);
}

stock IsWindowsOpen(vehicleid)
{
	new wdriver, wpassenger, wbackleft, wbackright;
	GetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, wbackright);
	if(wdriver == 0 || wpassenger== 0 || wbackleft== 0 || wbackright == 0) return 1;
	if(IsABike(vehicleid)) return 1;
	return 0;
}

stock IsPlayerOnPhone(playerid)
{
	if (Character[playerid][Emergency] > 0 || Character[playerid][CallLine] != INVALID_PLAYER_ID)
	    return 1;

	return 0;
}


forward SendVehicleICMessage(playerid, vehicleid, str[]);
public SendVehicleICMessage(playerid, vehicleid, str[])
{
	foreach (new i : Player) if (GetPlayerVehicleID(i) == vehicleid)
	{
		SendClientMessageA(i,0xBBFFEEFF,str);
	}

}

forward SendClientMessageA(playerid,color,text[]);
public SendClientMessageA(playerid,color,text[])
{
	new safetxt[128];
	format(safetxt,sizeof(safetxt),"%s",text);
	if(strlen(safetxt) <= 88) { SendClientMessage(playerid,color,text); }
	else {

	    new texts[128];
	    strmid(texts,safetxt,88,256);
   		strins(safetxt, "...", 88, 1);
		strdel(safetxt, 89, strlen(safetxt));
		SendClientMessage(playerid,color,safetxt);
		SendClientMessage(playerid,color,texts);

	}
}

forward SendLocalICMessage(playerid,str[],Float:distance);
public SendLocalICMessage(playerid,str[],Float:distance)
{

	foreach (new i : Player)
	{
		if (IsPlayerNearPlayer(i, playerid, distance))
		{
 			SendClientMessageA(i,COLOR_WHITE,str);

	    }
	}

}

SetFactionMarker(playerid, type, color)
{
    foreach (new i : Player) if (GetFactionType(i) == type) {
    	SetPlayerMarkerForPlayer(i, playerid, color);
	}
	Character[playerid][Marker] = 1;
	SetTimerEx("ExpireMarker", 300000, false, "d", playerid);
	return 1;
}

forward ExpireMarker(playerid);
public ExpireMarker(playerid)
{
	if (!Character[playerid][Marker])
	    return 0;

    if (GetFactionType(playerid) != FACTION_GANG && BitFlag_Get(g_PlayerFlags[playerid], PLAYER_ONDUTY))
		SetFactionColor(playerid);

	else SetPlayerColor(playerid, DEFAULT_COLOR);
	return 1;
}

forward StopChatting(playerid);
public StopChatting(playerid)
{
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
}

forward StopChattingNPC(playerid);
public StopChattingNPC(playerid)
{
    ApplyActorAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
}

public OnPlayerText(playerid, text[])
{
    if (!BitFlag_Get(g_PlayerFlags[playerid], PLAYER_IS_LOGGED_IN))
	    return 0;

	/*new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof name);
    new msg[128]; 
    format(msg, sizeof(msg), "```%s: %s```", name, text);
    DCC_SendChannelMessage(g_Discord_Chat, msg);*/

//	new str[600];
	if(LoggedIn[playerid] == false) return SendErrorMessage(playerid, ERROR_LOGGEDIN);
	/*if(Character[playerid][Muted] != 0)
	return InfoBoxForPlayer(playerid, "~r~You have been muted - you cannot speak.");*/

	LastCommandTime[playerid] = gettime();
	Log(playerid, text);

    new
		targetid = Character[playerid][CallLine], str[128];

	//SetPlayerChatBubble(playerid, text, COLOR_WHITE, 10.0, 6000);

    if (IsPlayerInAnyVehicle(playerid) && IsWindowedVehicle(GetPlayerVehicleID(playerid)) && !IsWindowsOpen(GetPlayerVehicleID(playerid)))
    {
		format(str,sizeof(str),"[Vehicle] %s พูดว่า: %s", ReturnName(playerid, 0), text);
		SendVehicleICMessage(playerid,GetPlayerVehicleID(playerid), str);
	}
	else
	{

	    if (!IsPlayerOnPhone(playerid)) {

			format(str,sizeof(str),"%s พูดว่า: %s", ReturnName(playerid, 0), text);
		}
		else {

		format(str,sizeof(str),"[โทรศัพท์] %s พูดว่า: %s", ReturnName(playerid, 0), text);

		}

        SendLocalICMessage(playerid, str, 20.0);
        SetPlayerChatBubble(playerid, str,COLOR_WHITE, 20.0, strlen(text) * 500);

		if (!IsPlayerInAnyVehicle(playerid) && !Character[playerid][Injured] && !LoopAnim[playerid] && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
			ApplyAnimation(playerid, "GANGS", "prtial_gngtlkA", 4.1, 0, 1, 1, 1, strlen(text) * 100, 1);

			SetTimerEx("StopChatting", strlen(text) * 100, false, "d", playerid);
		}
	}
	switch (Character[playerid][Emergency])
	{
		case 1:
		{
			if (!strcmp(text, "police", true))
			{
			    Character[playerid][Emergency] = 2;
			    SendClientMessage(playerid, COLOR_LIGHTBLUE, "[OPERATOR]:{FFFFFF} สายของคุณถูกย้ายมายังกองบัญชาการตำรวจ กรุณาอธิบายเกี่ยวกับเหตุอาชญากรรม");
			}
			else if (!strcmp(text, "medics", true))
			{
			    Character[playerid][Emergency] = 3;
			    SendClientMessage(playerid, COLOR_HOSPITAL, "[OPERATOR]:{FFFFFF} สายของคุณถูกย้ายมายังกองบัญชาการทางการแพทย์กรุณาอธิบายเหตุฉุกเฉิน");
			}
			else SendClientMessage(playerid, COLOR_LIGHTBLUE, "[OPERATOR]:{FFFFFF} ขออภัยเราไม่เข้าใจ คุณต้องการ \"police\" หรือ \"medics\"?");
		}
		case 2:
		{
			SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "911 CALL: %s (%s)", ReturnName(playerid, 0), GetPlayerLocation(playerid));
    		SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "รายละเอียด: %s", text);

		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "[OPERATOR]:{FFFFFF} ทุกหน่วยงานในพื้นที่ได้รับการแจ้งเตือนแล้ว");
		    cmd_hangup(playerid, "\1");

		    SetFactionMarker(playerid, FACTION_POLICE, 0x00D700FF);
		}
		case 3:
		{
		    SendFactionMessageEx(FACTION_MEDIC, COLOR_HOSPITAL, "911 CALL: %s (%s)", ReturnName(playerid, 0), GetPlayerLocation(playerid));
   			SendFactionMessageEx(FACTION_MEDIC, COLOR_HOSPITAL, "DESCRIPTION: %s", text);

		    SendClientMessage(playerid, COLOR_HOSPITAL, "[OPERATOR]:{FFFFFF} ทุกหน่วยงานในพื้นที่ได้รับการแจ้งเตือนแล้ว");
		    cmd_hangup(playerid, "\1");

		    SetFactionMarker(playerid, FACTION_MEDIC, 0x00D700FF);
		}
	}
	if (targetid != INVALID_PLAYER_ID && !Character[playerid][IncomingCall])
	{
		SendClientMessageEx(targetid, COLOR_YELLOW, "(โทรศัพท์) %s พูดว่า: %s", ReturnName(playerid, 0), text);
	}
	
	new tmp[256];
	new idx;
	
	tmp = strtok(text, idx);
	
	if ((strcmp("สวัสดีครับ", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("สวัสดีครับ")))
	{
		new string[128];
	
		new idbiz = Business_Inside(playerid);
	    new id = Food_Nearest(playerid);

        if (id != -1)
        {

	    	SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "[พนักงานขาย] พูดว่า: สวัสดีค่ะ, รับอะไรดีคะ?");

	        format(string, sizeof(string), "Water - %s\nSoda - %s\nFrench Fries - %s\nCheeseburger - %s\nChicken Burger - %s\nPizza - %s\nSalad - %s",
				FormatNumber(BusinessData[idbiz][bizPrices][0]),
				FormatNumber(BusinessData[idbiz][bizPrices][1]),
				FormatNumber(BusinessData[idbiz][bizPrices][2]),
				FormatNumber(BusinessData[idbiz][bizPrices][3]),
				FormatNumber(BusinessData[idbiz][bizPrices][4]),
				FormatNumber(BusinessData[idbiz][bizPrices][5]),
				FormatNumber(BusinessData[idbiz][bizPrices][6])
			);
			Dialog_Show(playerid, BusinessBuy, DIALOG_STYLE_LIST, BusinessData[idbiz][bizName], string, "ชำระเงิน", "ยกเลิก");
		}
	}

	return 0;

}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

//==============================================================================
//          -- > Chat Commands
//==============================================================================


forward CalculateVehicleSpeed(vehicleid, MPH);
public CalculateVehicleSpeed(vehicleid, MPH)
{
    new Float:speed_x,Float:speed_y,Float:speed_z,Float:calculation, calculation2;
    GetVehicleVelocity(vehicleid,speed_x,speed_y,speed_z);
    if(MPH == 0)
	{
		calculation = floatsqroot(((speed_x*speed_x)+(speed_y*speed_y))+(speed_z*speed_z))*136.666667;
	}
	else
	{
		calculation = floatsqroot(((speed_x*speed_x)+(speed_y*speed_y))+(speed_z*speed_z))*100;
    	calculation2 = floatround(calculation,floatround_round);
    }

    return calculation2;
}

stock ReSetVehiclePosEx(veh)
{
    vpos[veh][0] = 0.0;
    vpos[veh][1] = 0.0;
    vpos[veh][2] = 0.0;
    vpos[veh][3] = 0.0;

}

stock LogVehicleDeath(vehicleid, killerid, carid)
{

	new name[MAX_PLAYER_NAME];
	new clean_oname[MAX_PLAYER_NAME];

	if(IsPlayerConnectedEx(killerid))
	{
	    GetPlayerName(killerid, name, sizeof(name));
		mysql_escape_string(name,clean_oname);
	}
	else
 	{
		format(clean_oname,sizeof(clean_oname),"No-one");
	}

	new query[256];
	mysql_format(dbCon, query, sizeof(query), "INSERT INTO rp_vehicle_death_logs (killer,vehicle_id,car_id) VALUES ('%s','%d','%d')",clean_oname,vehicleid, carid);
	mysql_query(dbCon, query);

}

stock ClearMods(vehicleid)
{
	new carid = Car_GetID(vehicleid);
	for (new i = 0; i < 14; i ++) {
		RemoveVehicleComponent(CarData[carid][carVehicle], CarData[carid][carMods][i]);
		CarData[carid][carMods][i] = 0;
	}
	CarData[carid][carPaintjob] = -1;
}

public OnVehicleSpawn(vehicleid)
{
	EmergencyLights[vehicleid] = 0;
	ReSetVehiclePosEx(vehicleid);
    ResetVehicle(vehicleid);
//	SetVehicleParamsEx(vehicleid, 0, 0,alarm[vehicleid],doors[vehicleid],bonnet[vehicleid],boot[vehicleid],objective[vehicleid]);

	return 1;
}

forward FetchVehiclePrice(model);
public FetchVehiclePrice(model)
{
	if(model < 400 || model > 603) { return -1; }
	for(new i = 0; i < sizeof(VehicleModelInfo); i ++)
	{
	    if(VehicleModelInfo[i][vmModel] == model) { return VehicleModelInfo[i][vmPrice]; }
	}
	return -1;

}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(weaponid == TASER_WEAPON)
	{
		if(taser[playerid])
		{
			GiveTaserAgainTimerEx[playerid] = 0;
			GiveTaserAgainTimer[playerid] = SetTimerEx("GiveTaserAgain",TASER_USE_TIME, 0, "i", playerid);
			TaserShoot[playerid] = 1;
			ShowPlayerProgressBar(playerid, TASERBARAG[playerid]);
			ApplyAnimation(playerid, "SWORD", "sword_block", 4.1, 0, 1, 0, 1, 1, 1);
			SetPlayerAttachedObject(playerid, 0, TASER_OBJECT, 6);
			SetPlayerArmedWeapon(playerid, 0);

			if(hittype == BULLET_HIT_TYPE_PLAYER)
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(hitid, x, y, z);
				IsPlayerTaser[hitid] = 1;
				TaserTime[hitid] = 0;
				TogglePlayerControllable(hitid, 0);
				ApplyAnimation(hitid, "CRACK", "crckdeth2", 4.1, 0, 1, 1, 1, TASER_EFFECT_TIME, 1);
				SetPlayerDrunkLevel(hitid, 5000);
				ShowPlayerProgressBar(playerid, TASERBAR[hitid]);
				SetTimerEx("EndTaserEffect", TASER_EFFECT_TIME, 0, "i", hitid);
			}
		}
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    ReSetVehiclePosEx(vehicleid);

	if (CoreVehicles[vehicleid][vehTemporary])
	{
	    CoreVehicles[vehicleid][vehTemporary] = false;
	    TRP_DestroyVehicle(vehicleid);
	}

	new string[128];
	new slot = Car_GetID(vehicleid);
	if(slot > -1 && CarData[slot][carOwner] > 0)
	{
		new vehowner = GetConnectedVehicleOwnerID(vehicleid);
	    if(vehowner > -1 && CarData[slot][carDonator] == 0 && !IsABoat(vehicleid) && !IsAPlane(vehicleid) && !IsAHelicopter(vehicleid))
	    {
	        LogVehicleDeath(vehicleid,killerid, CarData[slot][carID]);

	        ClearMods(vehicleid);
	        if(CarData[slot][carInsurance] > 1)
	        {
		        CarData[slot][carInsurance] --;
		        CarData[slot][carDestroyed] ++;
		        format(string, sizeof(string), "ยานพาหนะ %s ของคุณถูกทำลาย! บริษัทประกันภัยของคุณได้คุ้มครองความเสียหายนี้.. คุณมีประกันคงเหลือ %d", ReturnVehicleName(vehicleid), CarData[slot][carInsurance]);
				SendClientMessage(vehowner, -1, string);
                Car_Save(slot);
			}
			else
			{
				new price_of_car = FetchVehiclePrice(CarData[slot][carModel]);
				new price_to_keep_car = floatround((price_of_car / 2) + (price_of_car * 0.10));

				CarData[slot][carInsurance] = 0;
		        CarData[slot][carDestroyed] ++;

                format(string, sizeof(string), "ยานพาหนะ %s ของคุณถูกทำลาย! คุณไม่มีประกันใด ๆ คุณสามารถรับยานพาหนะกลับมาใช้ได้โดย /acceptcharge", ReturnVehicleName(vehicleid));
				SendClientMessage(vehowner, -1, string);
				format(string, sizeof(string), "ภายใน 90 นาทีในราคา $%d",price_to_keep_car);
				SendClientMessage(vehowner, -1, string);

				TRP_DestroyVehicle(CarData[slot][carVehicle]);
				CarData[slot][carDeathTime] = 5400;
		        CarData[slot][carVehicle] = 0;
		        Car_Save(slot);

			}

	    }
  		ResetVehicleDamage(vehicleid);
	}
	return 1;
}

stock GetVehiclePosEx(vid, &Float:px, &Float:py, &Float:pz, Float:offsetx = 0.0, Float:offsety = 0.0, Float:offsetz = 0.0)
{
    new
        Float:rx, Float:ry, Float:rz,
        Float:sx, Float:sy, Float:sz,
        Float:cy, Float:cx, Float:cz;
    GetVehiclePos(vid, px, py, pz);
    GetVehicleRot(vid, rx, ry, rz);
    sx = floatsin(rx, degrees),
    sy = floatsin(ry, degrees),
    sz = floatsin(rz, degrees),
    cx = floatcos(rx, degrees),
    cy = floatcos(ry, degrees),
    cz = floatcos(rz, degrees);
    if (offsetx)
    {
        px = px + offsetx * (cy * cz - sx * sy * sz);
        py = py + offsetx * (cz * sx * sy + cy * sz);
        pz = pz - offsetx * (cx * sy);
    }
    if (offsety)
    {
        px = px - offsety * (cx * sz);
        py = py + offsety * (cx * cz);
        pz = pz + offsety * (sx);
    }
    if (offsetz)
    {
        px = px + offsetz * (cz * sy + cy * sx * sz);
        py = py - offsetz * (cy * cz * sx + sy * sz);
        pz = pz + offsetz * (cx * cy);
    }
    return 1;
}

stock GetVehicleRot(vehicleid, &Float:rx, &Float:ry, &Float:rz)
{
    new
        Float:qw,
        Float:qx,
        Float:qy,
        Float:qz;
    GetVehicleRotationQuat(vehicleid, qw, qx, qy, qz);
    ConvertQuatToEuler(qw, -qx, -qy, -qz, rx, ry, rz);
    return 1;
}

stock ConvertQuatToEuler(Float:qw, Float:qx, Float:qy, Float:qz, &Float:rx, &Float:ry, &Float:rz)
{
    new
        Float:sqw = qw * qw,
        Float:sqx = qx * qx,
        Float:sqy = qy * qy,
        Float:sqz = qz * qz;
    rx = asin (2 * (qw * qx + qy * qz) / (sqw + sqx + sqy + sqz));
    ry = atan2(2 * (qw * qy - qx * qz), 1 - 2 * (sqy + sqx));
    rz = atan2(2 * (qw * qz - qx * qy), 1 - 2 * (sqz + sqx));
    return 1;
}

forward Refueled(playerid);
public Refueled(playerid)
{
	TogglePlayerControllable(playerid, 1);
	GameTextForPlayer(playerid, "~p~Refueling Complete!", 3000, 3);
	return 1;
}

//==============================================================================
//
//      -- > ADMIN COMMANDS
//
//==============================================================================

stock GetElapsedTime(time, &hours, &minutes, &seconds)
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

stock RestartCheck()
{
	new
	    time[3],
		string[32];

	if (g_ServerRestart == 1 && !g_RestartTime)
	{
		foreach (new i : Player) {
			Character_Save(i);
		}
		SendRconCommand("gmx");
	}
	else if (g_ServerRestart == 1) {
		GetElapsedTime(g_RestartTime--, time[0], time[1], time[2]);

		format(string, 32, "~r~Restart Server In:~y~ %02d:%02d", time[1], time[2]);
	    TextDrawSetString(RestartTextdraws[0], string);
	}
	return 1;
}

forward IsPlayerConnectedEx(playerid);
public IsPlayerConnectedEx(playerid)
{
	if(IsPlayerConnected(playerid)) { return true; }
	return false;

}

stock submitToAdmins(string[], color) {
	foreach(new x: Player) {
		if(Account[x][Admin] >= 1) {
			SendClientMessage(x, color, string);
		}
	}
	return 1;
}

stock SetDefaultSpawn(playerid)
{
    //new factionid = Character[playerid][Faction];

	if(Character[playerid][Spawn]) //จุดเกิดล่าสุด
	{
	 	SetPlayerPosEx(playerid, Character[playerid][PosX], Character[playerid][PosY], Character[playerid][PosZ], Character[playerid][Interior], Character[playerid][VWorld]);
	}
	/*if(Character[playerid][Spawn] == 2)
	{
	    SetPlayerPos(playerid, FactionData[factionid][factionLockerPos][0], FactionData[factionid][factionLockerPos][1], FactionData[factionid][factionLockerPos][2]);
		SetPlayerInterior(playerid, FactionData[factionid][factionLockerInt]);
		SetPlayerVirtualWorld(playerid, FactionData[factionid][factionLockerWorld]);
	}*/
 	return 1;
}

forward AC_SetPlayerArmour(playerid,Float:armour);
public AC_SetPlayerArmour(playerid,Float:armour)
{
	Character[playerid][Armour]=armour;
	SetPlayerArmour(playerid,armour);
    return 1;
}

forward AC_SetPlayerHealth(playerid,Float:health);
public AC_SetPlayerHealth(playerid,Float:health)
{
	Character[playerid][Health]=health;
	SetPlayerHealth(playerid,health);
    return 1;
}

AddPlayerDamage(playerid, weaponid, Float:damage, armour, bodypart)
{

	new issuccess;

	for(new i = 0; i < MAX_DAMAGES; i++)
	{
	    if(!DamageData[playerid][i][dExists])
	    {
	        DamageData[playerid][i][dExists] = true;
	        DamageData[playerid][i][dSec] = gettime();
	        DamageData[playerid][i][dDamage] = floatround(damage);
	        DamageData[playerid][i][dShotType] = bodypart;
	        DamageData[playerid][i][dArmour] = armour;
	        DamageData[playerid][i][dWeaponid] = weaponid;

            issuccess = 1;
	    	break;
	    }
	}
	if(!issuccess)
	{
	    new emptyslot;

		for(new i = 0; i < MAX_DAMAGES; i++)
		{
		    new moretime;
		    if(DamageData[playerid][i][dExists])
		    {
		        if(moretime < gettime()-DamageData[playerid][i][dSec])
		        {
		            moretime = gettime()-DamageData[playerid][i][dSec];
		            emptyslot = i;
		        }
		    }
		}


	  	DamageData[playerid][emptyslot][dExists] = true;
	 	DamageData[playerid][emptyslot][dSec] = gettime();
	  	DamageData[playerid][emptyslot][dDamage] = floatround(damage);
	  	DamageData[playerid][emptyslot][dShotType] = bodypart;
	   	DamageData[playerid][emptyslot][dArmour] = armour;
	  	DamageData[playerid][emptyslot][dWeaponid] = weaponid;

	}
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{

    new Float:health;
    new Float:armor;
    GetPlayerHealth(playerid,health);
    
	if(weaponid == TASER_WEAPON)
	{
		if(taser[issuerid])
		{
			GetPlayerHealth(playerid, health);
			SetPlayerHealth(playerid, health-2);
		}
	}
    
    if(Character[playerid][Injured] == 1)
	{
	    AC_SetPlayerHealth(playerid, 100);

	    if(Character[playerid][InjuredShoot] == 1)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, "คุณได้ตายแล้วพิมพ์ /respawnme เพื่อเกิดใหม่");
			Character[playerid][InjuredTime] = 5;
			Character[playerid][InjuredEx]= 1;
			Character[playerid][InjuredShoot] = 0;

	 		if(IsDamageShow{playerid})
	   		{
				UpdateDynamic3DTextLabelText(DamageLabel[playerid], COLOR_LIGHTRED, "(( ผู้เล่นนี้ตายแล้ว ))");
			}
		}
	}
	
	if(issuerid != INVALID_PLAYER_ID)
	{
        if(!Character[playerid][Injured])
        {

		    if(amount > 5.0 && weaponid != 0)
		    {
				GetPlayerArmour(playerid,armor);
				if(armor <= 0.0)
				{
		       		TextDrawShowForPlayer(playerid,gServerTextdraws[4]);
			        SetTimerEx("HideCrash",250,0,"i",playerid);
			        SetPlayerDrunkLevel(playerid,(GetPlayerDrunkLevel(playerid) + 2000));

			  	}

		    }

	    }

	}
	
	if(!IsPlayerNPC(playerid))
    {
        if(!Character[playerid][Injured] && !IsAFK{playerid} && 1 <= weaponid <= 46)
        {

            new Float:hp, Float:armour;
            GetPlayerHealth(playerid, hp);
            GetPlayerArmour(playerid, armour);


			if(Character[playerid][HealthCheck] && weaponid != 41 && weaponid != 42)
			{
                Character[playerid][HealthCheck] = 0;
                if(Character[playerid][HealthLock] == hp)
                {
                    //Character[playerid][pWarningCheat] += 3;
                    SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ต้องสงสัย health lock (%.2f==%.2f) ", ReturnRealName(playerid, 0), Character[playerid][HealthLock], hp);

					/*if(Character[playerid][pWarningCheat] >= 9)
					{
					    SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ถูกแบนเนื่องจาก health lock (%.2f==%.2f)", ReturnRealName(playerid, 0), Character[playerid][HealthLock], hp);
						Log_Write("logs/cheat_log.txt", "[%s] %s was banned for health lock (%.2f==%.2f).", ReturnDate(), ReturnRealName(playerid), Character[playerid][HealthLock], hp);

						Blacklist_Add(Character[playerid][pIP], Character[playerid][pUsername], "Anticheat", "Health lock");
						Kick(playerid);
						return 0;
					}*/
				}
			}
			if(Character[playerid][ArmorCheck] && weaponid != 41 && weaponid != 42)
			{
                Character[playerid][ArmorCheck] = 0;
                if(Character[playerid][ArmorLock] == armour)
                {
                    //Character[playerid][pWarningCheat] += 3;
                    SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ต้องสงสัย armor lock (%.2f==%.2f)", ReturnRealName(playerid, 0), Character[playerid][ArmorLock], armour);
                    /*if(Character[playerid][pWarningCheat] >= 9)
					{
					    SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ถูกแบนเนื่องจาก armor lock (%.2f==%.2f)", ReturnRealName(playerid, 0), Character[playerid][ArmorLock], armour);
						Log_Write("logs/cheat_log.txt", "[%s] %s was banned for health lock (%.2f==%.2f).", ReturnDate(), ReturnRealName(playerid), Character[playerid][ArmorLock], armour);

						Blacklist_Add(Character[playerid][pIP], Character[playerid][pUsername], "Anticheat", "Armor lock");
						Kick(playerid);
						return 0;
					}*/
				}
			}

            GetPlayerHealth(playerid, Character[playerid][HealthLock]);
            GetPlayerArmour(playerid, Character[playerid][ArmorLock]);


		    if(issuerid != INVALID_PLAYER_ID) // If not self-inflicted
		    {
		        if (GetFactionType(issuerid) == FACTION_POLICE && BitFlag_Get(g_PlayerFlags[issuerid], PLAYER_TAZER) && weaponid == 23) {

		            SetPlayerHealth(playerid, (hp));
                    amount = 0;
		           	return 1;
		        }
		    }

            if(hp > 0.0)
            {
                if(DamageStatus[playerid] == STATE_PENDING_HIT)
                {
                    DamageStatus[playerid] = STATE_WAIT_HIT;
                    KillTimer(IssueTimer[playerid]);
                }
				switch(weaponid)
				{
				    case 0,1:
				    {
			    		switch(bodypart) // Under case 0.
						{
							//case 3: amount+=2; // Torso.
							//case 4: amount+=2; // Groin.
							//case 5: amount+=1; // Left Arm.
							//case 6: amount+=1; // Right Arm.
							//case 7: amount+=1; // Left Leg.
							//case 8: amount+=1; // Right Leg.
							case 9: amount+=3; // Head.
						}
					}
				    case 2..8:
				    {
			    		switch(bodypart) // Under case 0.
						{
							//case 3: amount+=4; // Torso.
							//case 4: amount+=3; // Groin.
							//case 5: amount+=3; // Left Arm.
							//case 6: amount+=3; // Right Arm.
							//case 7: amount+=2; // Left Leg.
							//case 8: amount+=3; // Right Leg.
							case 9: amount+=5; // Head.
						}
					}
				    case 22:
				    {
			    		switch(bodypart) // Under case 0.
						{
							//case 3: amount+=12; // Torso.
							//case 4: amount+=9; // Groin.
							//case 5: amount+=4; // Left Arm.
							//case 6: amount+=5; // Right Arm.
							//case 7: amount+=4; // Left Leg.
							//case 8: amount+=5; // Right Leg.
							case 9: amount+=37; // Head.
						}
					}
				    /*case 23:
				    {
			    		switch(bodypart) // Under case 0.
						{
							//case 3: amount+=13.5; // Torso.
							//case 4: amount+=10; // Groin.
							//case 5: amount+=5; // Left Arm.
							//case 6: amount+=6; // Right Arm.
							//case 7: amount+=5; // Left Leg.
							//case 8: amount+=6; // Right Leg.
							case 9: amount+=40; // Head.
						}
					}*/
				    case 24:
				    {
			    		switch(bodypart)
						{
							//case 3: amount+=25; // Torso.
							//case 4: amount+=15; // Groin.
							//case 5: amount+=12.5; // Left Arm.
							//case 6: amount+=14; // Right Arm.
							//case 7: amount+=12.5; // Left Leg.
							//case 8: amount+=14; // Right Leg.
							case 9: amount+=49; // Head.
						}
					}
				    case 25:
				    {
			    		switch(bodypart)
						{
							//case 3: amount+=16; // Torso.
							//case 4: amount+=15; // Groin.
							//case 5: amount+=12; // Left Arm.
							//case 6: amount+=12; // Right Arm.
							//case 7: amount+=9.5; // Left Leg.
							//case 8: amount+=9.5; // Right Leg.
							case 9: amount+=48; // Head.
						}
					}
				    case 26:
				    {
			    		switch(bodypart)
						{
							//case 3: amount+=40; // Torso.
							//case 4: amount+=36; // Groin.
							//case 5: amount+=32; // Left Arm.
							//case 6: amount+=32; // Right Arm.
							//case 7: amount+=24; // Left Leg.
							//case 8: amount+=24; // Right Leg.
							case 9: amount+=64; // Head.
						}
					}
				    case 27:
				    {
			    		switch(bodypart)
						{
							//case 3: amount+=20; // Torso.
							//case 4: amount+=18; // Groin.
							//case 5: amount+=16; // Left Arm.
							//case 6: amount+=16; // Right Arm.
							//case 7: amount+=12; // Left Leg.
							//case 8: amount+=12; // Right Leg.
							case 9: amount+=64; // Head.
						}
					}
				    case 28:
				    {
			    		switch(bodypart)
						{
							//case 3: amount+=17.5; // Torso.
							//case 4: amount+=16; // Groin.
							//case 5: amount+=14; // Left Arm.
							//case 6: amount+=14; // Right Arm.
							///case 7: amount+=10.5; // Left Leg.
							//case 8: amount+=10.5; // Right Leg.
							case 9: amount+=30; // Head.
						}
					}
				    case 29:
				    {
			    		switch(bodypart)
						{
							//case 3: amount+=17.5; // Torso.
							//case 4: amount+=16; // Groin.
							//case 5: amount+=14; // Left Arm.
							//case 6: amount+=14; // Right Arm.
							//case 7: amount+=10.5; // Left Leg.
							//case 8: amount+=10.5; // Right Leg.
							case 9: amount+=30; // Head.
						}
					}
				    case 30:
				    {
			    		switch(bodypart)
						{
							//case 3: amount+=44; // Torso.
							//case 4: amount+=30; // Groin.
							//case 5: amount+=35; // Left Arm.
							//case 6: amount+=35; // Right Arm.
							//case 7: amount+=26; // Left Leg.
							//case 8: amount+=26; // Right Leg.
							case 9: amount+=143; // Head.
						}
					}
				    case 31: //M4A4
				    {
			    		switch(bodypart) // Under case 0.
						{
							//case 3: amount+=20; // Torso.
							//case 4: amount+=17; // Groin.
							//case 5: amount+=16; // Left Arm.
							//case 6: amount+=16; // Right Arm.
							//case 7: amount+=12; // Left Leg.
							//case 8: amount+=12; // Right Leg.
							case 9: amount+=65.5; // Head.
						}
					}
				    case 32: //tec 9
				    {
			    		switch(bodypart) // Under case 0.
						{
							//case 3: amount+=20.5; // Torso.
							//case 4: amount+=17; // Groin.
							//case 5: amount+=16.5; // Left Arm.
							//case 6: amount+=16.5; // Right Arm.
							//case 7: amount+=12; // Left Leg.
							//case 8: amount+=12; // Right Leg.
							case 9: amount+=33; // Head.
						}
					}
				    case 33: //Mosin
				    {
			    		switch(bodypart) // Under case 0.
						{
							case 3: amount+=67.5; // Torso.
							case 4: amount+=60; // Groin.
							case 5: amount+=55; // Left Arm.
							case 6: amount+=55; // Right Arm.
							case 7: amount+=52.5; // Left Leg.
							case 8: amount+=52.5; // Right Leg.
							case 9: amount+=117; // Head.
						}
					}
				    case 34: //PSG-1
				    {
			    		switch(bodypart) // Under case 0.
						{
							case 3: amount+=49; // Torso.
							case 4: amount+=45.5; // Groin.
							case 5: amount+=22.5; // Left Arm.
							case 6: amount+=22.5; // Right Arm.
							case 7: amount+=27.5; // Left Leg.
							case 8: amount+=27.5; // Right Leg.
							case 9: amount+=167; // Head.
						}
					}
				}
				if(weaponid == 23)
				{
					amount = 0.0;
				}
				else{
					if(amount > 0)
					{
						if(armour > 0.0 && (weaponid != 54))
						{
							if(armour - amount/2 <= 0.0)
							{
								amount -= armour;
								AC_SetPlayerArmour(playerid, 0.0);

								Character[playerid][Armour] = 100.0;

								if(hp - amount/3 <= 0.0)
								{
									if(amount/3 > 0.0)
									{
										SetPlayerHealth(playerid, 0.0);
										Character[playerid][Health] = 100.0;
									}
								}
								else
								{
									if(amount/3 > 0.0)
									{
										SetPlayerHealth(playerid, hp - amount/3);

										Character[playerid][HealthCheck] = 1;
									}
									AddPlayerDamage(playerid, weaponid, amount/3, 1, bodypart);
								}

							}
							else
							{
								AC_SetPlayerArmour(playerid, armour - amount/2);

								Character[playerid][ArmorCheck] = 1;

								AddPlayerDamage(playerid, weaponid, amount/2, 1, bodypart);
							}
						}
						else
						{
							if(hp - amount <= 0.0)
							{
								SetPlayerHealth(playerid, 0.0);

								Character[playerid][Health] = 100.0;
							}
							else
							{
								SetPlayerHealth(playerid, hp - amount);

								Character[playerid][HealthCheck] = 1;

								AddPlayerDamage(playerid, weaponid, amount, 0, bodypart);
							}
						}
					}
				}
            }
			if(weaponid == 24 || weaponid == 25 || weaponid == 26 || weaponid == 27 || weaponid == 33 || weaponid == 34 || weaponid == 38)
	  		{
				switch(bodypart)
				{
					case 3: ApplyAnimation(playerid,"PED","DAM_stomach_frmBK",4.1,0,1,1,0,0,1); // Torso.
					case 5: ApplyAnimation(playerid,"PED","DAM_armL_frmBK",4.1,0,1,1,0,0,1); // Left Arm.
					case 6: ApplyAnimation(playerid,"PED","DAM_armR_frmBK",4.1,0,1,1,0,0,1); // Right Arm.
					case 7: ApplyAnimation(playerid,"PED","DAM_LegL_frmBK",4.1,0,1,1,0,0,1); // Left Leg.
					case 8: ApplyAnimation(playerid,"PED","DAM_LegR_frmBK",4.1,0,1,1,0,0,1); // Right Leg.
					case 9:// Head.
					{
						if(random(5) <= 2)
						{
							ApplyAnimation(playerid,"PED","BIKE_fall_off",4.1,0,1,1,0,0,1);
						}
					}

				}
				//return 1;
			}
		}
	}
    return 1;
}


stock SendSetMessages(player, playerid, option1[], option2)
{
	new str[128];
    format(str, sizeof(str), " Admin %s ได้เซ็ต %s [%s] เป็น %d.", GetRoleplayName(playerid), GetRoleplayName(player), option1, option2);
    SendClientMessage(player, COLOR_YELLOW, str);
	SendAdminsMessage(1, COLOR_YELLOW, str);
	return 1;
}

stock GetSQLIDFromName(name[])
{
	new query[128], CID;
    mysql_format(dbCon, query, sizeof(query), "SELECT ID FROM `Characters` WHERE Name = '%s' LIMIT 1", name);
	new Cache:result = mysql_query(dbCon, query);
	CID = cache_get_field_content_int(0, "ID", dbCon);
 	cache_delete(result);
	return CID;
}


stock GetRoleplayNameFromSQLID(sqlid)
{
	new query[128], name[64];
    mysql_format(dbCon, query, sizeof(query), "SELECT Name FROM `Characters` WHERE ID = %d LIMIT 1", sqlid);
	new Cache:result = mysql_query(dbCon, query);
	cache_get_field_content(0, "Name", name, dbCon, 64);
 	cache_delete(result);
	return name;
}



stock ReplaceSpaces(str[])
{
    for(new i, len = strlen(str); i < len; i++)
    {
        if(str[i] == ' ') str[i] = '_';
    }
}


/*stock SendFactionMessage(fac, color, msg[])
{
	foreach(Player, x)
	{
		if(IsPlayerConnected(x))
		{
		    if(Character[x][Faction] == fac)
		    {
				SendClientMessage(x, color, msg);
			}
		}
	}
	return 1;
}*/


//==============================================================================
//==============================================================================
//==============================================================================
//==============================================================================
//==============================================================================

/*stock CreateClock()
{
	new Clockstr[8];
    format(Clockstr, sizeof(Clockstr), "%02d:%02d:%02d", ClockHours, ClockMinutes, ClockSeconds);
    Clock = TextDrawCreate(546.000000,22.000000,Clockstr);
    TextDrawAlignment(Clock,0);
    TextDrawBackgroundColor(Clock, COLOR_BLACK);
    TextDrawFont(Clock,3);
    TextDrawLetterSize(Clock,0.5,2.3);
    TextDrawColor(Clock, COLOR_WHITE);
    TextDrawSetOutline(Clock,1);
    TextDrawSetProportional(Clock,1);
    TextDrawSetShadow(Clock,1);

}*/

forward Payday();
public Payday()
{
	new
	    string[128];

    foreach (new i : Player)
	{
	    if(!IsPlayerConnected(i))
	        break;

	    Character[i][Minutes]++;

	    if (Character[i][Minutes] >= 60)
       	{
       	    new Float:interest = 0.01;
       	    new Float:savingsinterest = 0.05;

       	    Character[i][Minutes] = 0;
       	    Character[i][Playerhours]++;
       	    Character[i][Exp]++;
       	    Character[i][Paycheck] += 1000;

       	    if(Character[i][Savings] > 0 && Character[i][Savings] < 20000000)
			{
			    new savingsgain = floatround((Character[i][Savings] * savingsinterest));

				SendClientMessage(i, -1, "|___BANK STATEMENT___|");
				format(string, sizeof(string), "ยอดเงินในบัญชี: $%d", Character[i][Bank]);
				SendClientMessage(i, -1, string);
				SendClientMessage(i, -1, "อัตราดอกเบี้ย: 0.05");
				format(string, sizeof(string), "ดอกเบี้ยที่ได้รับ: $%d", savingsgain);
				SendClientMessage(i, -1, string);
				format(string, sizeof(string), "ภาษีที่จ่าย: $%d", 0);
				SendClientMessage(i, -1, string);
				format(string, sizeof(string), "รายได้เงินฝากออมทรัพย์: $%d อยู่ที่อัตรา: %.0f", savingsgain, savingsinterest*100);
				SendClientMessage(i, -1, string);
				Character[i][Savings] += savingsgain;
				format(string, sizeof(string), "ยอดเงินในบัญชีออมทรัพย์ใหม่: $%d", Character[i][Savings]);
				SendClientMessage(i, -1, string);
				SendClientMessage(i, -1, "|______________________|");
				format(string, sizeof(string), "ยอดเงินฝากใหม่: $%d", Character[i][Bank]);
				SendClientMessage(i, -1, string);
				SendClientMessage(i, -1, "คุณสามารถรับ Paycheck ของคุณได้ใน Los Santos Bank");

				format(string, sizeof(string), "~y~Payday~n~~w~Paycheck~n~~w~$%d", Character[i][Paycheck]);
				GameTextForPlayer(i, string, 1000, 1);


				Character_Save(i);
			}
			else if(Character[i][Savings] == 0)
			{
		    	new bankgain = floatround((Character[i][Bank] * interest));

				SendClientMessage(i, -1, "|___BANK STATEMENT___|");
				format(string, sizeof(string), "ยอดเงินในบัญชี: $%d", Character[i][Bank]);
				SendClientMessage(i, -1, string);
				SendClientMessage(i, -1, "อัตราดอกเบี้ย: 0.01");
				format(string, sizeof(string), "ดอกเบี้ยที่ได้รับ: $%d", bankgain);
				SendClientMessage(i, -1, string);
				format(string, sizeof(string), "ภาษีที่จ่าย: $%d", 0);
				SendClientMessage(i, -1, string);
				SendClientMessage(i, -1, "|______________________|");
				Character[i][Bank] += bankgain;
				format(string, sizeof(string), "ยอดเงินฝากใหม่: $%d", Character[i][Bank]);
				SendClientMessage(i, -1, string);
				SendClientMessage(i, -1, "คุณสามารถรับ Paycheck ของคุณได้ใน Los Santos Bank");

				format(string, sizeof(string), "~y~Payday~n~~w~Paycheck~n~~w~$%d", Character[i][Paycheck]);
				GameTextForPlayer(i, string, 1000, 1);


				Character_Save(i);
			}
			if(Character[i][Savings] > 0 && Character[i][Savings] >= 20000000)
			{
				SendClientMessage(i, -1, "|___BANK STATEMENT___|");
				format(string, sizeof(string), "ยอดเงินในบัญชี: $%d", Character[i][Bank]);
				SendClientMessage(i, -1, string);
				SendClientMessage(i, -1, "บัญชีเงินฝากคุณมีมากถึง $20,000,000 แล้วและก็จะไม่ได้รับดอกเบี้ย");
				SendClientMessage(i, -1, "|______________________|");
				format(string, sizeof(string), "ยอดเงินฝากใหม่: $%d", Character[i][Bank]);
				SendClientMessage(i, -1, string);
				SendClientMessage(i, -1, "คุณสามารถรับ Paycheck ของคุณได้ใน Los Santos Bank");

				format(string, sizeof(string), "~y~Payday~n~~w~Paycheck~n~~w~$%d", Character[i][Paycheck]);
				GameTextForPlayer(i, string, 1000, 1);


				Character_Save(i);
			}
		}
	}
	return 1;
}

forward UpdateTime();
public UpdateTime()
{
	new
	    time[3],
	    string[32];

	gettime(time[0], time[1], time[2]);

	if (time[0] >= 12)
		format(string, 32, "%02d:%02d PM", (time[0] == 12) ? (12) : (time[0] - 12), time[1]);

	else if (time[0] < 12)
		format(string, 32, "%02d:%02d AM", (time[0] == 0) ? (12) : (time[0]), time[1]);

    for(new i = 0; i<MAX_PLAYERS; i++)
        {
            if(IsPlayerConnected(i) && LoggedIn[i] == true)
            {
                SetPlayerTime(i, ClockHours, ClockMinutes);
                PickedUpPickup[i] = false;
            }
        }


    new Panels, Doors, Lightz, Tires;
	for(new i = 0; i<MAX_VEH; i++)
	{
 		if(IsVehicleSpawned(i))
 		{
			if(EmergencyLights[i] == 1)
 			{
				if(EmergencyState[i] == 1)
				{
					GetVehicleDamageStatus(i,Panels, Doors, Lightz, Tires);
    				UpdateVehicleDamageStatus(i, Panels, Doors, 4, Tires);
        			EmergencyState[i] = 0;
				}
				else
				{
    				GetVehicleDamageStatus(i,Panels, Doors, Lightz, Tires);
    				UpdateVehicleDamageStatus(i, Panels, Doors, 1, Tires);
    				EmergencyState[i] = 1;
				}
  			}

		}
	}
	
	//TextDrawSetString(Clock, string);

	//TextDrawSetString(gServerTextdraws[0], string);
}

/*forward UpdateTime();
public UpdateTime()
{
    new Clockstr[126];
 	ClockSeconds++;
    if(ClockSeconds == 60)
    {
        ClockMinutes++;
        ClockSeconds = 0;
        if(ClockMinutes == 60)
        {
            ClockMinutes = 0;
            ClockHours++;

			for(new playerid; playerid < MAX_PLAYERS; playerid++)
			{
				if(IsPlayerConnected(playerid) && LoggedIn[playerid] == true)
				{
					if(Character[playerid][OnlinePeriod] > 29)
					{
						GivePayday(playerid);
                        Character[playerid][OnlinePeriod] = 0;

				    }
				    else
			    	{
			    		SendClientMessage(playerid, COLOR_GRAY, "You didn't get an hourly paycheck as you haven't played long enough.");
			    	}
				}
			}

            if(ClockHours == 24)
            {
                ClockHours = 0;
            }
        }

        format(Clockstr, sizeof(Clockstr), "%02d:%02d:%02d", ClockHours, ClockMinutes, ClockSeconds);

		for(new i = 0; i<MAX_PLAYERS; i++)
        {
            if(IsPlayerConnected(i) && LoggedIn[i] == true)
            {
                SetPlayerTime(i, ClockHours, ClockMinutes);
                Character[i][TotalTimePlayed]++;
                Character[i][OnlinePeriod]++;
                PickedUpPickup[i] = false;

                if(Character[i][Jail] > 0)
            	{
            		Character[i][Jail] --;
            		MYSQL_Update_Character(i, "Jail", Character[i][Jail]);
            		new str[64];
            		format(str, sizeof(str), "Time left: %d minutes", Character[i][Jail]);
            		GameTextForPlayer(i, str, 5000, 1);
            		if(Character[i][Jail] == 0) 
        			{
        				SetPlayerPosEx(i, -229.1438, 971.7680, 19.4704, 0, 0);
        				SendClientMessage(i, COLOR_DARKVIOLET, "You have been released from prison, we hope you've learned from your mistakes!");
            		}
            	}
            }
        }
        TextDrawSetString(Clock, Clockstr);
    }

	else
	{

		format(Clockstr, sizeof(Clockstr), "%02d:%02d:%02d", ClockHours, ClockMinutes, ClockSeconds);

		for(new i = 0; i<MAX_PLAYERS; i++)
	    {
	        if(IsPlayerConnected(i) && LoggedIn[i] == true)
	        {


	        }
	    }

	    new Panels, Doors, Lightz, Tires;										
		for(new i = 0; i<MAX_VEH; i++)
	    {
	        if(IsVehicleSpawned(i))
	        {
				if(EmergencyLights[i] == 1)
           		{
       				if(EmergencyState[i] == 1)
					{
			            GetVehicleDamageStatus(i,Panels, Doors, Lightz, Tires);
			            UpdateVehicleDamageStatus(i, Panels, Doors, 4, Tires);
			            EmergencyState[i] = 0;
					}
					else 
					{
			            GetVehicleDamageStatus(i,Panels, Doors, Lightz, Tires);
			            UpdateVehicleDamageStatus(i, Panels, Doors, 1, Tires);
			            EmergencyState[i] = 1;
					}
           		}
	          
	        }
	    }
	    TextDrawSetString(Clock, Clockstr);
	}
	return 1;
}
*/

public OnPlayerCommandText(playerid, cmdtext[])
{
	/*if(!strcmp("/sav", cmdtext)){
		if(!INGAME[playerid][LOGIN]) return SendClientMessage(playerid,-1,"not login");
		manager(SQL, SAVE, playerid);
		SendClientMessage(playerid,-1,"data save");
        return 1;
    }*/
	return 0;
}

public OnPlayerCommandReceived(playerid, cmdtext[])
{

	LastCommandTime[playerid] = gettime();

	if(LoggedIn[playerid] == false)
	{
	    SendErrorMessage(playerid, ERROR_LOGGEDIN);
	    return 0;
	}
	else if(Character[playerid][ClothesSelection] == 1)
	{
	    SendErrorMessage(playerid, "You cannot perform commands at this point in time.");
	    return 0;
	}
	else if(Character[playerid][InHospital] == 1)
	{
	    SendErrorMessage(playerid, "You cannot perform commands at this point in time.");
	    return 0;
	}
    else return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
    if(!success) SendClientMessage(playerid, -1, "> {ED0000}[เกิดข้อผิดพลาด] {FFFFFF}คำสั่งที่คุณพิมพ์ไม่มีในระบบ, โปรดใช้ /help เพื่อดูคำสั่งช่วยเหลือ. <");
	else
	{
		Log(playerid, cmdtext);
	}
	return 1;
}

stock strvalEx( const string[] ) // fix for strval-bug with > 50 letters.
{
	// written by mabako in less than a minute :X
	if( strlen( string ) >= 50 ) return 0; // It will just return 0 if the string is too long
	return strval(string);
}

forward split(const strsrc[], strdest[][], delimiter);
public split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}

	return 1;
}

		

Dialog:REG2(playerid, response, listitem, inputtext[])
{
	if(!response)
    {
        Character[playerid][Gender] = 2;
        SetPlayerSkinEx(playerid, 198);
    	
    }
	if(response)
	{
        Character[playerid][Gender] = 1;
        SetPlayerSkinEx(playerid, 161);
        
	}

	//

	Dialog_Show(playerid, SPAWN_SELECT, DIALOG_STYLE_MSGBOX, "การสร้างตัวละครเสร็จสมบูรณ์", "เยี่ยมเลย, คุณได้สร้างตัวละครของคุณเรียบร้อยแล้ว งั้นเราไปสนุกกันเลยยย!","Spawn","");
    return 1;
}

forward ConfirmCharplayer(playerid);
public ConfirmCharplayer(playerid)
{
    Kick(playerid);
	return 1;
}

Dialog:SPAWN_SELECT(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        StopAudioStreamForPlayer(playerid);
        
	    SetPlayerScore(playerid, Character[playerid][Level]);
        SetCameraBehindPlayer(playerid);
       	SetPlayerPosEx(playerid, NoobSpawns[0][0], NoobSpawns[0][1], NoobSpawns[0][2], 0, 0);
	 	SetPlayerFacingAngle(playerid, NoobSpawns[0][3]);
       	
       	LoggedIn[playerid] = true;
       	Character[playerid][ClothesSelection] = 0;
		Character[playerid][Spawn] = 1;
       	Character[playerid][Skin] = GetPlayerSkin(playerid);
		InteriorTimer(playerid);

		if(Character[playerid][Whitelist] == 0)
		{
			Dialog_Show(playerid, Whitelist, DIALOG_STYLE_MSGBOX, "{00FF00}[Whitelist]","{FFFFFF}ตัวละครของคุณไม่มี Whitelist โปรดติดต่อผู้ดูแลเซิร์ฟเวอณ์ได้ที่ Discord", "ตกลง", "");
			SetTimerEx("KickPlayerDelayed", time, false, "d", playerid);
			return 1;
		}

		//TextDrawShowForPlayer(playerid, Clock);

		if(Character[playerid][ConfirmChar] == 0)
		{
	        SendClientMessage(playerid, -1, "[HINT]: คุณได้เดินทางมายังเมือง Los Santos แล้ว");
	        SendClientMessage(playerid, -1, "[- สิ่งที่มีติดตัว -]");
	        SendClientMessage(playerid, -1, "- เงินติดตัว: {16B903}$1,000");
	        SendClientMessage(playerid, -1, "- เงินในบัญชีธนาคาร: {16B903}$3,000");
	        Character[playerid][ConfirmChar] = 1;
	        Character_Save(playerid);

			if(Character[playerid][Whitelist] == 0)
			{
				Dialog_Show(playerid, Whitelist, DIALOG_STYLE_MSGBOX, "{00FF00}[Whitelist]","{FFFFFF}ตัวละครของคุณไม่มี Whitelist โปรดติดต่อผู้ดูแลเซิร์ฟเวอณ์ได้ที่ Discord", "ตกลง", "");
				SetTimerEx("KickPlayerDelayed", time, false, "d", playerid);
				return 1;
			}
		}
	}
    else
    {
		KickPlayer(playerid);
    }
    return 1;
}

Dialog:DINER(playerid, response, listitem, inputtext[])
{
	if(!response) return SendClientMessage(playerid, COLOR_PINK, "* You decided not to buy anything at the checkout. *");
    if(response)
    {
	    switch(listitem)
	    {
	        case 0://-Starters-\n\n Salad \n Garlic Bread \n\n-Main Course-\n Burger \n Chips \n Chicken Nuggets \n Hotdog \n\n-Desserts-\n Icecream \n Brownie
	        {
	            SendClientMessage(playerid, COLOR_ORANGE, "Waiter says: You may not eat the menu, sir!");
	        }
			case 1://
			{
			    SendClientMessage(playerid, COLOR_YELLOW, "Salad");

			}
			case 2://
			{
			    SendClientMessage(playerid, COLOR_YELLOW, "Garlic Bread");

			}
			case 3://
			{
			    SendClientMessage(playerid, COLOR_ORANGE, "Waiter shouts: You may not eat the menu, sir!");

			}
			case 4:
			{
                SendClientMessage(playerid, COLOR_YELLOW, "Burger");
			}
			case 5:
			{
                SendClientMessage(playerid, COLOR_YELLOW, "Chips");
			}
			case 6:
			{
                SendClientMessage(playerid, COLOR_YELLOW, "Chicken Nuggets");
			}
			case 7:
			{
                SendClientMessage(playerid, COLOR_YELLOW, "Hotdog");
			}
			case 8:
			{
                SendClientMessage(playerid, COLOR_ORANGERED, "Waiter says: You may not eat the menu, sir!");
			}
			case 9:
			{
                SendClientMessage(playerid, COLOR_YELLOW, "Icecream");
			}
			case 10:
			{
                SendClientMessage(playerid, COLOR_YELLOW, "Brownie");
			}
		}
	}
    return 1;
}


stock GetTabulators(str[])   // -> Empty Slot
{
    new x = strlen(str);  // -> 10
    x = floatround((x/8), floatround_floor); // -> 1
    new Tabs[20];
    for(new i = x; i < 5; i++) // 5 = Max tabulators  // -> 4 x "\t"
    {
          format(Tabs, 20, "%s\t", Tabs);
    }
    if(x == 0) format(Tabs, 20, "\t\t\t\t");
    return Tabs;
}

/*Dialog:VEHICLE_COLOR(playerid, response, listitem, inputtext[])
{
    if(!response)
	{
		SetPlayerVirtualWorld(playerid, 0);
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, true);
		DestroyVehicle(Character[playerid][Dealership]);
		return 1;
	}
	new query[128];
	ChangeVehicleColor(Character[playerid][Dealership],listitem,listitem);
	ChangeVehicleColor(Character[playerid][NewVehicle],listitem,listitem);
	mysql_format(dbCon, query, sizeof(query), "UPDATE PlayerVehicles SET Color1 = %d, Color2 = %d WHERE SQLID = %d LIMIT 1",listitem,listitem,Character[playerid][NewVehicle]);
	mysql_tquery(dbCon, query);throat
	Dialog_Show(playerid, VEHICLE_COLOR, DIALOG_STYLE_LIST, "Vehicle Dialog", "Black\nWhite\nBlue\nRed\nDark Green\nPink\nYellow\nSilver","Select","Finish");
	return 1;
}*/

SetPlayerSkinEx(playerid, skinid)
{
	SetPlayerSkin(playerid, skinid);
	Character[playerid][Skin] = skinid;
	return 1;
}

stock SetVehicleHoodState(vid, setstate)
{
     new veh[7];
     GetVehicleParamsEx(vid,veh[0],veh[1],veh[2],veh[3],veh[4],veh[5],veh[6]);
	 if(setstate) SetVehicleParamsEx(vid,veh[0],veh[1],veh[2],veh[3],VEHICLE_PARAMS_ON,veh[5],veh[6]);
	 else SetVehicleParamsEx(vid,veh[0],veh[1],veh[2],veh[3],VEHICLE_PARAMS_OFF,veh[5],veh[6]);
}

stock SetVehicleTrunkState(vid, setstate)
{
	 new veh[7];
     GetVehicleParamsEx(vid,veh[0],veh[1],veh[2],veh[3],veh[4],veh[5],veh[6]);
	 if(setstate) SetVehicleParamsEx(vid,veh[0],veh[1],veh[2],veh[3],veh[4],VEHICLE_PARAMS_ON,veh[6]);
	 else SetVehicleParamsEx(vid,veh[0],veh[1],veh[2],veh[3],veh[4],VEHICLE_PARAMS_OFF,veh[6]);
}

stock GetVehicleTrunkState(vid)
{
	 new veh[7];
     GetVehicleParamsEx(vid,veh[0],veh[1],veh[2],veh[3],veh[4],veh[5],veh[6]);
	 return veh[5];
}

stock TogVehicleTrunkState(vid)
{
	 new veh[7];
     GetVehicleParamsEx(vid,veh[0],veh[1],veh[2],veh[3],veh[4],veh[5],veh[6]);
     if(veh[5] == VEHICLE_PARAMS_OFF) SetVehicleParamsEx(vid,veh[0],veh[1],veh[2],veh[3],veh[4],VEHICLE_PARAMS_ON,veh[6]);
	 else SetVehicleParamsEx(vid,veh[0],veh[1],veh[2],veh[3],veh[4],VEHICLE_PARAMS_OFF,veh[6]);
}

/*stock GetNearestVehicle(playerid, Float:dis) // some stock i have found around the forums
{
    new Float:X, Float:Y, Float:Z;
    if(GetPlayerPos(playerid, X, Y, Z))
    {
        new vehicleid = INVALID_VEHICLE_ID;
        for(new v, Float:temp, Float:VX, Float:VY, Float:VZ; v != MAX_VEH; v++)
        {
            if(GetVehiclePos(v, VX, VY, VZ))
            {
                VX -= X, VY -= Y, VZ -= Z;
                temp = VX * VX + VY * VY + VZ * VZ;
                if(temp < dis) dis = temp, vehicleid = v;
            }
        }
        dis = floatpower(dis, 0.5);
        return vehicleid;
    }
    return INVALID_VEHICLE_ID;
}
*/

stock SetPlayerPosEx(playerid,Float:X,Float:Y,Float:Z, Int, vWorld)
{
    TogglePlayerControllable(playerid, 0);
	SetTimerEx("UnfreezePlayer", 1500, false, "d", playerid);
	SetPlayerPos(playerid, X, Y, Z-5);
    SetPlayerInterior(playerid, Int);
	SetPlayerVirtualWorld(playerid, vWorld);
	SetTimerEx("Move_Player", 200, false, "dfff", playerid, X, Y, Z);
	PickedUpPickup[playerid] = false;
}

stock SendFactionAlert(color, const str[], {Float,_}:...)
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
			if (Account[i][Admin] >= 1) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (Account[i][Admin] >= 1) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock SendFactionMessageEx(type, color, const str[], {Float,_}:...)
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

		foreach (new i : Player) if (Character[i][Faction] != -1 && GetFactionType(i) == type && !BitFlag_Get(g_PlayerFlags[i], PLAYER_DISABLE_FACTION)) {
		    SendClientMessage(i, color, string);
		}
		return 1;
	}
	foreach (new i : Player) if (Character[i][Faction] != -1 && GetFactionType(i) == type && !BitFlag_Get(g_PlayerFlags[i], PLAYER_DISABLE_FACTION)) {
 		SendClientMessage(i, color, str);
	}
	return 1;
}

stock SendFactionMessage(factionid, color, const str[], {Float,_}:...)
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

		foreach (new i : Player) if (Character[i][Faction] == factionid && !BitFlag_Get(g_PlayerFlags[i], PLAYER_DISABLE_FACTION)) {
		    SendClientMessage(i, color, string);
		}
		return 1;
	}
	foreach (new i : Player) if (Character[i][Faction] == factionid && !BitFlag_Get(g_PlayerFlags[i], PLAYER_DISABLE_FACTION)) {
 		SendClientMessage(i, color, str);
	}
	return 1;
}

stock SendClientMessageEx(playerid, color, const text[], {Float, _}:...)
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

ReturnRealName(playerid, underscore=1)
{
	new
	    name[MAX_PLAYER_NAME + 1];

	GetPlayerName(playerid, name, sizeof(name));

	if (!underscore) {
	    for (new i = 0, len = strlen(name); i < len; i ++) {
	        if (name[i] == '_') name[i] = ' ';
		}
	}

	return name;
}

ReturnName(playerid, underscore=1)
{
	new
	    name[MAX_PLAYER_NAME + 1];

	GetPlayerName(playerid, name, sizeof(name));

	if (!underscore) {
	    for (new i = 0, len = strlen(name); i < len; i ++) {
         if (name[i] == '_') name[i] = ' ';
		}
	}
	return name;
}

stock SendNearbyMessage(playerid, Float:radius, color, const str[], {Float,_}:...)
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
			if (IsPlayerNearPlayer(i, playerid, radius)) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (IsPlayerNearPlayer(i, playerid, radius)) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	new
		Float:fX,
		Float:fY,
		Float:fZ;

	GetPlayerPos(targetid, fX, fY, fZ);

	return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
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
			if (Account[i][Admin] >= 1) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (Account[i][Admin] >= 1) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

ReturnVehicleHealth(vehicleid)
{
	if (!IsValidVehicle(vehicleid))
	    return 0;

	new
	    Float:amount;

	GetVehicleHealth(vehicleid, amount);
	return floatround(amount, floatround_round);
}

stock TRP_DestroyVehicle(vehicleid, bool:force = false)
{
	if(!force)
	{
		if (Car_GetID(vehicleid) == -1)
		{
		    return DestroyVehicle(vehicleid);
		}
	}
	else
	{
	    return DestroyVehicle(vehicleid);
	}
	return -1;
}

stock IsEngineVehicle(vehicleid)
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

stock GetEngineStatus(vehicleid)
{
	new
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

stock SetEngineStatus(vehicleid, bool:status)
{
	new
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

ReturnVehicleModelName(model)
{
	new
	    name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}


stock ReturnVehicleName(vehicleid)
{
	new
		model = GetVehicleModel(vehicleid),
		name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}

stock GetLightStatus(vehicleid)
{
	new
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (lights != 1)
		return 0;

	return 1;
}



stock PutPlayerInVehicleEx(playerid,vehicleid,seatid)
{
	PlayerEnterTime[playerid] = vehicleid;
	PutPlayerInVehicle(playerid,vehicleid,seatid);
}


stock IsABoat(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595: return 1;
	}
	return 0;
}

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

stock ResetVehicle(vehicleid)
{
	if (1 <= vehicleid <= MAX_VEH)
	{
	    if (CoreVehicles[vehicleid][vehSirenOn] && IsValidDynamicObject(CoreVehicles[vehicleid][vehSirenObject]))
	        DestroyDynamicObject(CoreVehicles[vehicleid][vehSirenObject]);

		if(vehiclecallsign[vehicleid]) Delete3DTextLabel(vehicle3Dtext[vehicleid]);
		vehiclecallsign[vehicleid] = 0;

		if (IsValidObject(CoreVehicles[vehicleid][vehCrate]) && GetVehicleModel(vehicleid) == 530 || GetVehicleModel(vehicleid) == 578)
	    	DestroyObject(CoreVehicles[vehicleid][vehCrate]);

		CoreVehicles[vehicleid][vehTemporary] = 0;
  		CoreVehicles[vehicleid][vehLoads] = 0;
		CoreVehicles[vehicleid][vehLoadType] = 0;
		CoreVehicles[vehicleid][vehCrate] = INVALID_OBJECT_ID;
		CoreVehicles[vehicleid][vehTrash] = 0;
		CoreVehicles[vehicleid][vehComponent] = 0;
		CoreVehicles[vehicleid][vehSirenOn] = 0;
		CoreVehicles[vehicleid][vehRadio] = 0;

		startup_delay_sender[vehicleid] = -1;
		startup_delay[vehicleid] = 0;
	}
	return 1;
}

stock SetLightStatus(vehicleid, bool:status)
{
	new
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, status, alarm, doors, bonnet, boot, objective);
}

stock SetVehicleColor(vehicleid, color1, color2)
{
    new id = Car_GetID(vehicleid);

	if (id != -1)
	{
	    CarData[id][carColor1] = color1;
	    CarData[id][carColor2] = color2;
	    Car_Save(id);
	}
	return ChangeVehicleColor(vehicleid, color1, color2);
}

stock IsPlayerFacingVehicle(playerid,vehicleid)
{

	new Float:pX,Float:pY,Float:pZ,Float:X,Float:Y,Float:Z,Float:ang;

	if(!IsPlayerConnected(playerid)) return 0;

	GetVehiclePos(vehicleid, X, Y, Z);
	GetPlayerPos(playerid, pX, pY, pZ);

	if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	if(X > pX) ang = (floatabs(floatabs(ang) + 180.0));
	else ang = (floatabs(ang) - 180.0);
	new Float:russia;
	GetPlayerFacingAngle(playerid,russia);
	if(ang-russia<-130 || ang-russia>130) return 0;
	else return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    new id = Car_GetID(vehicleid);

	if (!ispassenger && id != -1 && CarData[id][carFaction] > 0 && GetFactionType(playerid) != CarData[id][carFaction]) {
	    ClearAnimations(playerid);

	    return SendClientMessage(playerid, -1, "คุณไม่มีกุญแจสำหรับยานพาหนะคันนี้");
	}

	if(!ispassenger)
	{
		if(Character[playerid][Injured] == 1)
		{
			return ClearAnimations(playerid);
		}
	}

	if(!ispassenger)
	{
		for(new i = 0; i < sizeof dmv_vehicles; i++) if(vehicleid == dmv_vehicles[i])
		{
			if(Character[playerid][DriversLicense])
			{
				SendClientMessage(playerid, -1, "คุณมีใบขับขี่อยู่แล้ว!");
				return ClearAnimations(playerid);
			}
		}
	}
	return 1;
}

forward VehicleListener();
public VehicleListener()
{
	for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) if (CarData[i][carVehicle] > -1)
	{
	 		if(IsEngineVehicle(CarData[i][carVehicle]) && GetEngineStatus(CarData[i][carVehicle]))
			{

				if(fuel_interval[i] <= 0)
				{
					CarData[i][carFuel] --;
					fuel_interval[i] = FetchFuelInterval(CarData[i][carVehicle]);

					if (CarData[i][carFuel] >= 1 && CarData[i][carFuel] <= 5)
					{
					    SendClientMessage(GetVehicleDriver(CarData[i][carVehicle]), COLOR_LIGHTRED, "[WARNING]:{FFFFFF} ยานพาหนะคันนี้เชื่อเพลิงใกล้หมดแล้ว คุณต้องไปที่ปั้มน้ำมัน!");
					}
					if(CarData[i][carBatteryL] > 0)
					{
						CarData[i][carBatteryL]--;
                        if(CarData[i][carBatteryL] <= 0)
                        {
							SetEngineStatus(CarData[i][carVehicle], false);
				    	}
					}

				}
				else if(fuel_interval[i] > 0)
				{
					fuel_interval[i] --;
				}

				if (CarData[i][carFuel] <= 0)
				{
				    CarData[i][carFuel] = 0;
				    SetEngineStatus(CarData[i][carVehicle], false);
				}
			}
			if(CarData[i][carDeathTime] == 1)
			{

		        new vehowner = -1;
			    foreach (new a : Player)
			    {

			        if(IsPlayerConnectedEx(a))
			        {

			            if(Character[a][ID] == CarData[i][carOwner])
			            {

							vehowner = a;

			            }

			        }

			    }
			    if(vehowner > -1)
			    {
					new str[256];
					format(str, sizeof(str), "คุณกู้ยานพาหนะ %s ล้มเหลวในเวลานี้ และคุณเสียมันไป!", ReturnVehicleModelName(CarData[i][carModel]));
					SendClientMessage(vehowner, -1, str);
					CarData[i][carOwner] = 0;
			        CarData[i][carInsurance] = 0;
			        CarData[i][carDestroyed] = 0;
			        CarData[i][carModel] = 0;
			        CarData[i][carPos][0] = 0.0;
			        CarData[i][carPos][1] = 0.0;
			        CarData[i][carPos][2] = 0.0;
			        CarData[i][carDeathTime] = 0;
			        Car_Save(i);
					mysql_format(dbCon, str,sizeof(str),"UPDATE `cars` SET `truncated` =  '1' WHERE `carID` = %d",CarData[i][carID]);
					mysql_query(dbCon, str);
			  	}

			}
			if(CarData[i][carDeathTime] > 1)
			{

			    CarData[i][carDeathTime] --;

			}
			if(startup_delay[CarData[i][carVehicle]] > 0 && startup_delay_sender[CarData[i][carVehicle]] != INVALID_PLAYER_ID && startup_delay_sender[CarData[i][carVehicle]] != -1)
			{
				startup_delay[CarData[i][carVehicle]] --;
				if(startup_delay[CarData[i][carVehicle]] == 0 && IsPlayerInVehicle(startup_delay_sender[CarData[i][carVehicle]],CarData[i][carVehicle]))
				{
                    SendNearbyMessage(startup_delay_sender[CarData[i][carVehicle]], 30.0, COLOR_RP, "** %s สตาร์ทเครื่องยนต์ %s", ReturnName(startup_delay_sender[CarData[i][carVehicle]], 0), ReturnVehicleModelName(CarData[i][carModel]));
					SetEngineStatus(CarData[i][carVehicle], true);
					startup_delay_sender[CarData[i][carVehicle]] = -1;

				}
				else if(startup_delay[CarData[i][carVehicle]] == 0) { startup_delay_sender[CarData[i][carVehicle]] = -1; }

			}

			if(vehicle_alarm_time[CarData[i][carVehicle]] == 1)
			{

			    StopAlarm(CarData[i][carVehicle]);
			    vehicle_alarm_time[CarData[i][carVehicle]] = 0;

			}
			if(vehicle_alarm_time[CarData[i][carVehicle]] > 1)
			{

			    vehicle_alarm_time[CarData[i][carVehicle]] --;

			}
	}
	for(new i = 0; i < MAX_VEHICLES; i ++)
	{
	    new Float:X, Float:Y, Float:Z, Float:R;
	    if(GetVehicleDistanceFromPoint(i,vpos[i][0],vpos[i][1],vpos[i][2]) > 15.0 && vpos[i][0] != 0.0 && vpos[i][1] != 0.0 && vpos[i][2] != 0.0)
	    {

	        if(!IsAnyPlayerInVehicle(i) && !IsTrailerAttachedToVehicle(i) && GetVehicleModel(i) != 610)
	        {
				if(CoreVehicles[i][vehRespawn])
				{
				    CoreVehicles[i][vehRespawn]=0;

					GetVehiclePos(i,X,Y,Z);
					GetVehicleZAngle(i,R);
					vpos[i][0] = X;
					vpos[i][1] = Y;
					vpos[i][2] = Z;
					vpos[i][3] = R;
				    continue;
				}
	            SetVehiclePosEx(i,vpos[i][0],vpos[i][1],vpos[i][2]);
	            SetVehicleZAngle(i,vpos[i][3]);
				printf("Vehicle ID: %d just travelled more than 15 meters with no one in it! Resetting its position.", i);

			}

		}
		GetVehiclePos(i,X,Y,Z);
		GetVehicleZAngle(i,R);
		vpos[i][0] = X;
		vpos[i][1] = Y;
		vpos[i][2] = Z;
		vpos[i][3] = R;



	}
}

stock FetchFuelInterval(vehicleid)
{

	new model = GetVehicleModel(vehicleid);
	for(new i = 0; i < sizeof(VehicleModelInfo); i ++)
	{

	    if(VehicleModelInfo[i][vmModel] == model)
	    {

	        return VehicleModelInfo[i][vmFuelInterval];

	    }

	}
	return 180;

}

forward RefuelCheck();
public RefuelCheck()
{
	new
	    string[128];

	foreach (new i : Player)
	{
	    if (!BitFlag_Get(g_PlayerFlags[i], PLAYER_IS_LOGGED_IN) || Character[i][Refill] == INVALID_VEHICLE_ID)
	        continue;

        if (Character[i][Refill] != INVALID_VEHICLE_ID && Character[i][GasPump] != -1)
		{
		    Character[i][RefillPrice] += 3;


			new id = Car_GetID(Character[i][Refill]);

			CarData[id][carFuel]++;

		    PumpData[Character[i][GasPump]][pumpFuel] --;

		    if (PumpData[Character[i][GasPump]][pumpExists])
			{
			    format(string, sizeof(string), "[Gas Pump: %d]\n{FFFFFF}เชื้อเพลิงเหลือ: %d ลิตร", Character[i][GasPump], PumpData[Character[i][GasPump]][pumpFuel]);
			    UpdateDynamic3DTextLabelText(PumpData[Character[i][GasPump]][pumpText3D], COLOR_DARKBLUE, string);
			}
			if (CarData[id][carFuel] >= 100 || GetEngineStatus(Character[i][Refill]) || !PumpData[Character[i][GasPump]][pumpExists] || PumpData[Character[i][GasPump]][pumpFuel] < 0)
			{
			    GiveMoney(i, -Character[i][RefillPrice], "Refill Fuel from pump %d", Character[i][GasPump]);
			    format(string, sizeof(string), "คุณเติมเชื้อเพลิงให้กับยานพาหนะของคุณในราคา $%d", Character[i][RefillPrice]);
			    SendClientMessage(i, -1, string);

			    if (PumpData[Character[i][GasPump]][pumpExists])
				{
					if (PumpData[Character[i][GasPump]][pumpFuel] < 0)
						PumpData[Character[i][GasPump]][pumpFuel] = 0;

					BusinessData[Character[i][GasStation]][bizVault] += Character[i][RefillPrice];
					Business_Save(Character[i][GasStation]);

					Pump_Save(Character[i][GasPump]);
				}
				StopRefilling(i);
			}
		}
	}
	return 1;
}

stock IsVehicleImpounded(vehicleid)
{
    new id = Car_GetID(vehicleid);

	if (id != -1 && CarData[id][carImpounded] != -1 && CarData[id][carImpoundPrice] > 0)
	    return 1;

	return 0;
}

stock RandomPlate()
{
	const len = 7, hyphenpos = 4;
	new plate[len+1];
	for (new i = 0; i < len; i++)
	{
	    if (i + 1 == hyphenpos)
	    {
	      plate[i] = '-';
	      continue;
	    }
	    if (i < hyphenpos) // letter or number?
	    { // letter
	      plate[i] = 'A' + random(26);
	    }
	    else
	    { // number
	      plate[i] = '0' + random(10);
	    }
	}
	return plate;
}

forward FetchVehiclePlate(carid);
public FetchVehiclePlate(carid)
{
	new
		name[32],
	    query[128];

	format(name, sizeof(name), RandomPlate());

    format(query, sizeof(query), "SELECT `carPlate` FROM `cars` WHERE `carPlate` = '%s'", name);
	mysql_tquery(dbCon, query, "CheckVehiclePlate", "is", carid, name);
}

forward CheckVehiclePlate(carid, plate[]);
public CheckVehiclePlate(carid, plate[])
{
	new
		rows;

	cache_get_row_count(rows);
	if(!rows)
	{
		format(CarData[carid][carPlate], 32, plate);
		SetVehicleNumberPlate(CarData[carid][carVehicle],CarData[carid][carPlate]);
		Car_Save(carid);
	}
	else SetTimerEx("FetchVehiclePlate", 0, false, "d", carid);

	return 1;
}

stock SetVehicleDamage(vehicleid)
{
	new slot;
	if((slot = Car_GetID(vehicleid)) != -1)
	{
		UpdateVehicleDamageStatus(vehicleid,CarData[slot][carDamage][0],CarData[slot][carDamage][1],CarData[slot][carDamage][2],CarData[slot][carDamage][3]);
        //SetVehicleHealth(vehicleid,CarData[slot][carHealth]);
		if(CarData[slot][carHealth] > 310)
		{
			SetVehicleHealth(vehicleid,CarData[slot][carHealth]);
		}
		else
		{
			SetVehicleHealth(vehicleid,310);
		}
	}
	return 1;
}

forward GetConnectedVehicleOwnerID(vehicleid);
public GetConnectedVehicleOwnerID(vehicleid)
{
	new vehowner = -1;
	new slot = Car_GetID(vehicleid);
	if(slot == -1) { return -1; }


    foreach (new i : Player)
    {
        if(IsPlayerConnectedEx(i))
        {

            if(Character[i][ID] == CarData[slot][carOwner])
            {

				vehowner = i;

            }

        }

    }
    return vehowner;

}

stock RespawnVehicle(vehicleid)
{
    CoreVehicles[vehicleid][vehRespawn] = 1;

	new id = Car_GetID(vehicleid);

	if (id != -1)
	    Car_Spawn(id);

	else SetVehicleToRespawn(vehicleid);

	ResetVehicle(vehicleid);
	return 1;
}

forward StopAlarm(vehicleid);
public StopAlarm(vehicleid)
{
	new
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lights, 0, doors, bonnet, boot, objective);
    vehicle_alarm_time[vehicleid] = 0;

}

forward IsAnyPlayerInVehicle(vehicleid);
public IsAnyPlayerInVehicle(vehicleid)
{
	foreach (new i : Player)
	{

	    if(IsPlayerConnectedEx(i))
	    {

	        if(IsPlayerInAnyVehicle(i))
	        {

	            new veh = GetPlayerVehicleID(i);
	            if(veh == vehicleid)
	            {

	                return 1;

	            }

	        }

	    }

	}
	return 0;
}

forward HidePlayerFooter(playerid);
public HidePlayerFooter(playerid) {

	if (!Character[playerid][ShowFooter])
	    return 0;

	Character[playerid][ShowFooter] = false;
	return PlayerTextDrawHide(playerid, Footer[playerid]);
}

public OnDynamicObjectMoved(objectid)
{
  
	return 1;
}
forward GPS_Load();
public GPS_Load()
{
	static
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_GPS)
	{
	    gpsData[i][gpsExists] = true;

	    cache_get_value_name_int(i, "gpsID", gpsData[i][gpsID]);
	    cache_get_value_name(i, "gpsName", gpsData[i][gpsName], 32);
	    cache_get_value_name_float(i, "gpsX", gpsData[i][gpsPosX]);
	    cache_get_value_name_float(i, "gpsY", gpsData[i][gpsPosY]);
	    cache_get_value_name_float(i, "gpsZ", gpsData[i][gpsPosZ]);
	    cache_get_value_name_int(i, "gpsType", gpsData[i][gpsType]);
	}
	printf("[SERVER]: %d GPS were loaded from \"%s\" database...", rows, MYSQL_DB);
	return 1;
}
forward OnGPSCreated(gpsid);
public OnGPSCreated(gpsid)
{
	if (gpsid == -1 || !gpsData[gpsid][gpsExists])
	    return 0;

	gpsData[gpsid][gpsID] = cache_insert_id();
	GPS_Save(gpsid);

	return 1;
}
GPS_Delete(gpsid)
{
	if (gpsid != -1 && gpsData[gpsid][gpsExists])
	{
	    static
	        string[64];

		format(string, sizeof(string), "DELETE FROM `gps` WHERE `gpsID` = '%d'", gpsData[gpsid][gpsID]);
		mysql_tquery(dbCon, string);

		gpsData[gpsid][gpsExists] = false;
		gpsData[gpsid][gpsID] = 0;
	}
	return 1;
}

GPS_Create(type, const gpsname[], Float:x, Float:y, Float:z)
{
	for (new i = 0; i < MAX_GPS; i ++) if (!gpsData[i][gpsExists])
	{
	    gpsData[i][gpsExists] = true;
	    format(gpsData[i][gpsName], 32, gpsname);
	    gpsData[i][gpsPosX] = x;
	    gpsData[i][gpsPosY] = y;
	    gpsData[i][gpsPosZ] = z;
	    gpsData[i][gpsType] = type;

	    mysql_tquery(dbCon, "INSERT INTO `gps` (`gpsID`) VALUES(0)", "OnGPSCreated", "d", i);
		return i;
	}
	return -1;
}

GPS_Save(gpsid)
{
	static
	    query[220];

	mysql_format(dbCon, query, sizeof(query), "UPDATE `gps` SET `gpsName` = '%e', `gpsX` = '%.4f', `gpsY` = '%.4f', `gpsZ` = '%.4f', `gpsType` = '%d' WHERE `gpsID` = '%d'",
		gpsData[gpsid][gpsName],
		gpsData[gpsid][gpsPosX],
	    gpsData[gpsid][gpsPosY],
	    gpsData[gpsid][gpsPosZ],
	    gpsData[gpsid][gpsType],
	    gpsData[gpsid][gpsID]
	);
	return mysql_tquery(dbCon, query);
}

CMD:creategps(playerid, params[])
{
	static
	    id = -1,
		Float:x,
		Float:y,
		Float:z,
		gpsname[32],
		type;

	GetPlayerPos(playerid, x, y, z);

    if (Account[playerid][Admin] < 1337)
	    return 1;

	if (sscanf(params, "ds[32]", type, gpsname))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "/creategps [รูปแบบ GPS] [ชื่อสถานที่]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[รูปแบบ GPS]:{FFFFFF} 1. อาชีพ 2. สะานที่ทั่วไป 3. จุดขายของ");
	    return 1;
	}
	if (type < 1 || type > 3)
		return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}รูปแบบของ GPS ต้องไม่ต่ำกว่า 1 และไม่เกิน 3 เท่านั้น");

	id = GPS_Create(type, gpsname, x, y, z);

	if (id == -1)
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ความจุของ GPS ในฐานข้อมูลเต็มแล้ว ไม่สามารถสร้างได้อีก (ติดต่อผู้พัฒนา)");

	SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้สร้าง GPS ขึ้นมาใหม่ รูปแบบ GPS: %d, ชื่อสถานที่: %s, ไอดี: %d", type, gpsname, id);
	return 1;
}

CMD:deletegps(playerid, params[])
{
	static
	    id = 0;

    if (Account[playerid][Admin] < 1337)
	    return 1;

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, COLOR_WHITE, "/deletegps [ไอดี]");

	if ((id < 0 || id >= MAX_GPS) || !gpsData[id][gpsExists])
	    return SendClientMessage(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไม่มีไอดี GPS นี้อยู่ในฐานข้อมูล");

	GPS_Delete(id);
	SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ลบ GPS ไอดี %d ออกสำเร็จ", id);
	return 1;
}


Dialog:DIALOG_GPSPICK(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new var[32];
	    format(var, sizeof(var), "GPSID%d", listitem);
	    new gpsid = GetPVarInt(playerid, var);
		SetPlayerCheckpoint(playerid, gpsData[gpsid][gpsPosX], gpsData[gpsid][gpsPosY], gpsData[gpsid][gpsPosZ], 3.0);
		//GPSNavigateToPoint(playerid, gpsData[gpsid][gpsPosX], gpsData[gpsid][gpsPosY], gpsData[gpsid][gpsPosZ]);
		SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้เปิด GPS และไปที่%s จุด Checkpoint อยู่บน Minimap แล้ว", gpsData[gpsid][gpsName]);
		/*if (gpsid == 0)
		{
			if (Character[playerid][pQuest] == 0)
			{
				SetPVarInt(playerid, "GPSQUEST", 1);
			}
		}
		else if (gpsid == 11)
		{
			if (Character[playerid][pQuest] == 2)
			{
				SetPVarInt(playerid, "GPSQUEST", 1);
			}
		}*/
	}
	return 1;
}

		
/*public TOL_RemovePlayerWeaponDuty(playerid)
{
    TOL_AC_ResetPlayerWeapons(playerid);

	new
	    xLoop;

	while(xLoop < 13) {
		Account[playerid][pDWeapons][xLoop] = 0;
		Account[playerid][pDAmmoMag][xLoop] = 0;
		xLoop++;
	}

	Account[playerid][pDAmmo45] = 0;
	Account[playerid][pDAmmo50] = 0;
	Account[playerid][pDAmmo20G] = 0;
	Account[playerid][pDAmmo9mm] = 0;
	Account[playerid][pDAmmo762x39] = 0;
	Account[playerid][pDAmmo556] = 0;
	Account[playerid][pDAmmo919mm] = 0;
	Account[playerid][pDAmmo22] = 0;
	Account[playerid][pDAmmo762x51] = 0;
	return 1;
}*/
/*CMD:savevehicle(playerid, params[]) {
    new query[281];
    new
	    	carid = GetPlayerVehicleID(playerid);
    if(Account[playerid][Admin] < 1337) {

		if(!IsPlayerInAnyVehicle(playerid))
			return SendClientMessage(playerid, COLOR_GREY, "คุณจะต้องอยู่บนพาหนะเพื่อที่จะเซฟมัน");

		if(GetPVarInt(playerid, "sCc") == 1)
		{
		    new
		        queryString[255],
		        Float: vPos[4], plate[32]; // x, y, z + z angle

			new vehicleid = GetPlayerVehicleID(playerid);
			if(doesVehicleExist(vehicleid))
			{
			    GetVehiclePos(vehicleid, vPos[0], vPos[1], vPos[2]);
			    GetVehicleZAngle(vehicleid, vPos[3]);

				new i;

				for(new g = 0; g < sizeof(CarData); g++)
				{
                  	if(CarData[carid][carVehicle] <= 0)
                	{
						mysql_format(dbCon, query, sizeof(query), "SELECT * FROM vehicles WHERE `vehicleSID` = %d", g);
						mysql_tquery(dbCon, query);

						new rows, fields;
						cache_get_row_count(rows, fields);

						if(rows <= 0)
						{
							i = g;
							break;
						}
					}
				}

				format(plate, sizeof(plate), "%s", RandomPlate());
				SetPVarString(playerid, "plate", plate);

			    mysql_format(dbCon, query, sizeof(query), "SELECT `vehiclePlate` FROM `vehicles` WHERE `vehiclePlate` = '%s'", plate);
			    mysql_tquery(dbCon, query, "CheckPlate", "ii", playerid, i);


			    mysql_format(dbCon, query, sizeof(query), "INSERT INTO vehicles (vehicleModelID, vehicleSID, vehiclePlate, vehiclePosX, vehiclePosY, vehiclePosZ, vehiclePosRotation) VALUES('%d', '%d', '%s', '%f', '%f', '%f', '%f')", GetVehicleModel(vehicleid), i, plate, vPos[0], vPos[1], vPos[2], vPos[3]);
	            mysql_tquery(dbCon, query, "InsertVehicle", "iii", playerid,vehicleid,i);
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "เกิดข้อผิดพลาดในการบันทึกพาหนะ");
			    DeletePVar(playerid, "sCc");
			    return 1;
			}
		}
		else {
		    SetPVarInt(playerid, "sCc", 1);
		    return SendClientMessage(playerid, COLOR_GREY, "คุณแน่ใจหรือที่จะบันทึกพาหนะ? กดคำสั่งเดิมอีกครั้งเพื่อยืนยัน");
		}
	}
	return 1;
}*/


forward DragUpdate(playerid, targetid);
public DragUpdate(playerid, targetid)
{
	if (Character[targetid][pDragged] && Character[targetid][pDraggedBy] == playerid)
	{
	    static
	        Float:fX,
	        Float:fY,
	        Float:fZ,
			Float:fAngle;

		GetPlayerPos(playerid, fX, fY, fZ);
		GetPlayerFacingAngle(playerid, fAngle);

		fX -= 3.0 * floatsin(-fAngle, degrees);
		fY -= 3.0 * floatcos(-fAngle, degrees);

		SetPlayerPos(targetid, fX, fY, fZ);
		SetPlayerInterior(targetid, GetPlayerInterior(playerid));
		SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
	}
	return 1;
}

StopDragging(playerid)
{
	if (Character[playerid][pDragged])
	{
	    Character[playerid][pDragged] = 0;
		Character[playerid][pDraggedBy] = INVALID_PLAYER_ID;
		KillTimer(Character[playerid][pDragTimer]);
	}
	return 1;
}

forward OnPlayerAttemptBuyVehicle(playerid, index);
public OnPlayerAttemptBuyVehicle(playerid, index)
{

}

CMD:crb(playerid, params[])
{
	if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, -1, "คุณต้องอยู่บนพื้นเท่านั้น");

	if (GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, -1, "คุณต้องเป็นเจ้าหน้าที่ตำรวจ");

	if(IsPlayerConnected(playerid))
    {
     	new rb;
		new Float:X, Float:Y, Float:Z, Float:A;
		GetPlayerPos(playerid, X, Y, Z);
		GetPlayerFacingAngle(playerid, A);

     	if(sscanf(params, "i", rb))
 		{
 			SendClientMessage(playerid, COLOR_WHITE, "{7DAEFF}USAGE: /crb [Roadblock ID]{7DAEFF}");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Available Roadblocks:");
			SendClientMessage(playerid, COLOR_GREY, "| 1: Small Roadblock");
			SendClientMessage(playerid, COLOR_GREY, "| 2: Medium Roadblock");
			SendClientMessage(playerid, COLOR_GREY, "| 3: Big Roadblock");
			SendClientMessage(playerid, COLOR_GREY, "| 4: Cone");
			return 1;
     	}

        if (rb == 1)
		{
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
		    GetPlayerPos(playerid, plocx, plocy, plocz);
		    GetPlayerFacingAngle(playerid,ploca);
		    CreateRoadblock(1459,plocx,plocy,plocz,ploca);

		    GameTextForPlayer(playerid,"~w~Roadblock ~b~Placed!",3000,1);
			SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "HQ: เจ้าหน้าที่ÿ %s ได้วางสิ่งกีดขวางÿ(1) ใว้ที่ตำแหน่งของเขา (%.4f, %.4f, %.4f)", ReturnName(playerid, 0), X, Y, Z);
			return 1;
		}
		else if (rb == 2)
		{
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
		    GetPlayerPos(playerid, plocx, plocy, plocz);
		    GetPlayerFacingAngle(playerid,ploca);
		    CreateRoadblock(978,plocx,plocy,plocz+0.6,ploca);

		    GameTextForPlayer(playerid,"~w~Roadblock ~b~Placed!",3000,1);
			SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "HQ:  เจ้าหน้าที่ %s ได้วางสิ่งกีดขวาง(2) ใว้ที่ตำแหน่งของเขา(%.4f, %.4f, %.4f)", ReturnName(playerid, 0), X, Y, Z);
			return 1;
		}
		else if (rb == 3)
		{
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
		    GetPlayerPos(playerid, plocx, plocy, plocz);
		    GetPlayerFacingAngle(playerid,ploca);
		    CreateRoadblock(981,plocx,plocy,plocz+0.9,ploca+180);

		    GameTextForPlayer(playerid,"~w~Roadblock ~b~Placed!",3000,1);
			SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "HQ: เจ้าหน้าที่ÿ %s ได้วางสิ่งกีดขวางÿ(3) ใว้ทร่ตำแหน่งของเขา (%.4f, %.4f, %.4f)", ReturnName(playerid, 0), X, Y, Z);
			return 1;
		}
		else if (rb == 4)
		{
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
		    GetPlayerPos(playerid, plocx, plocy, plocz);
		    GetPlayerFacingAngle(playerid,ploca);
		    CreateRoadblock(1238,plocx,plocy,plocz+0.2,ploca);

		    GameTextForPlayer(playerid,"~w~Roadblock ~b~Placed!",3000,1);
		    GameTextForPlayer(playerid,"~w~Cone ~g~Placed!",3000,1);
			SendFactionMessageEx(FACTION_POLICE, COLOR_RADIO, "HQ: เจ้าหน้าที่ÿ %s ได้วางกรวยจราจรใว้ที่ตำแหน่ง (%.4f, %.4f, %.4f)", ReturnName(playerid, 0), X, Y, Z);
			return 1;
		}
	}
	return 1;
}

CMD:rrbb(playerid, params[])
{
	if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
	    return SendClientMessage(playerid, -1, "คุณต้องอยู่บนพื้นเท่านั้น");

	if (GetFactionType(playerid) != FACTION_POLICE)
		return SendClientMessage(playerid, -1, "คุณต้องเป็นเจ้าหน้าที่ตำรวจ");

    DeleteClosestRoadblock(playerid);
	GameTextForPlayer(playerid,"~w~Roadblock ~r~Removed!",3000,1);
	return 1;
}

stock CreateRoadblock(Object,Float:x,Float:y,Float:z,Float:a)
{
    for(new i = 0; i < sizeof(Roadblocks); i++)
  	{
  	    if(Roadblocks[i][sCreated] == 0)
  	    {
            Roadblocks[i][sCreated] = 1;
            Roadblocks[i][sX] = x;
            Roadblocks[i][sY] = y;
            Roadblocks[i][sZ] = z-0.7;
            Roadblocks[i][sObject] = CreateDynamicObject(Object, x, y, z-0.9, 0, 0, a);
	        return 1;
  	    }
  	}
  	return 0;
}

stock SendToGroup(groupid, colour, string[]) {
	if(groupid > 0) {
		foreach(new i: Player) {
			if(playerVariables[i][pLogged] == 1 && playerVariables[i][pGroup] == groupid) {
				SendClientMessage(i, colour, string);
			}
		}
	}
	return 1;
}

stock DeleteClosestRoadblock(playerid)
{
    for(new i = 0; i < sizeof(Roadblocks); i++)
  	{
  	    if(IsPlayerInRangeOfPoint(playerid, 5.0, Roadblocks[i][sX], Roadblocks[i][sY], Roadblocks[i][sZ]))
        {
  	        if(Roadblocks[i][sCreated] == 1)
            {
                Roadblocks[i][sCreated] = 0;
                Roadblocks[i][sX] = 0.0;
                Roadblocks[i][sY] = 0.0;
                Roadblocks[i][sZ] = 0.0;
                DestroyDynamicObject(Roadblocks[i][sObject]);
                Roadblocks[i][sObject] =-1;
                return 1;
  	        }
  	    }
  	}
    return 0;
}
forward KickPlayerDelayed(playerid);
public KickPlayerDelayed(playerid)
{
	Kick(playerid);
	return 1;
}
forward InteriorTimer(playerid);
public InteriorTimer(playerid)
{
	TogglePlayerControllable(playerid, 0);
	GameTextForPlayer(playerid, "~w~Loading...", 3000, 4) ;
	SetTimerEx("InteriorTimer2", 3000, 0, "i", playerid);
	return 1;
}
forward InteriorTimer2(playerid);
public InteriorTimer2(playerid)
{
	TogglePlayerControllable(playerid, true);
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
