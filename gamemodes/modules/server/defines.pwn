//==============================================================================
//          -- > Error Message Defines
//==============================================================================
#define ERROR_LOGGEDIN															"�س�ѧ�������ͤ�Թ!"
#define ERROR_ADMIN 															"�س������ʹ�Թ"
#define ERROR_SPAM_TIME															"����觹���������ö��������ҹ��"
#define ERROR_LOCATION															"����觹���������ö��������˹觹��"
#define ERROR_MONEY																"�Թ�����§��"
#define ERROR_ADMINLEVEL														"�������ö���Թ��áѺ�������к��дѺ�٧���ҹ����"
#define ERROR_INVALIDPLAYER														"�кؼ��������١��ͧ"
#define ERROR_VEHICLE															"�س��ͧ������ҹ��˹����ʹ��Թ��ä���觹��"
#define ERROR_FACTION 															"�س������Է�����Ҷ֧����觹��"
#define ERROR_VALUE																"�������ö����㹢�й��"
#define ERROR_OPTION															"������͡���١��ͧ"
#define ERROR_DIALOG															"Dialog �١�Դ"
#define ERROR_RANK																"�س�յ��˹������§��"
#define ERROR_MUTED																"�س�١��"
#define ERROR_OWNED																"�س����Ңͧ��¡�û������������"
#define ERROR_OWNER																"��¡�ù������Ңͧ����"
#define ERROR_NOTOWNED															"�س���������Ңͧ"
#define ERROR_JOB																"�س����էҹ����ͧ��"
#define ERROR_CONNECTED															"�����蹷��س��ͧ���������������"

#define STATE_PENDING_HIT       1
#define STATE_WAIT_HIT          0
#define ISSUE_HIT_DELAY         300
#define MAX_DAMAGES 10

#define Time2GoAFK 			20 		//Time to set the player in AFK mode
#define KICK_FOR_MUCH_AFK 	true 	//If you want a limit of afk time, set to 'true', else set it to 'false'
#define MAX_TIME_AFK 		30 	//Seconds of the limit of AFK time

//job
#define FREE_SLOT 8
#define FREE_SLOT2 9
#define C_WOOD 1


//JOB
#define JOB_TRUCKER 1
#define JOB_MECHANIC 2
#define JOB_NEWS 3
//#define JOB_FRUIT 4
//#define JOB_COWMILK 5

//==============================================================================
//          -- > Server Limits
//==============================================================================
#define MAX_PLANTS (1000)
#define MAX_FIELDS (100)
#define MAX_SLOTRAD (10)
#define MAX_RADIO (1000)
#define MAX_GAS_PUMPS (100)
#define MAX_OWNABLE_BUSINESSES (100)
#define MAX_BUSINESSES (500)
#define MAX_DYNAMIC_CARS (1500)
#define MAX_VEH                                                    			200
#define MAX_FACTIONS                                                            20
#define MAX_BIZ                                                                 100
#define MAX_ICONS                                                               50
#define MAX_OBJECTZ                                                             5000
#define MAX_JOBS                                                                5
#define MAX_OWNABLE_CARS (5)
#define MAX_ENTRANCES (100)
#define MAX_DYNAMIC_JOBS (25)
#define MAX_DYNAMIC_PRODUCTS (25)
#define MAX_DYNAMIC_FOODS (25)
#define MAX_CRATES (200)
#define MAX_HOUSES (500)
#define MAX_HOUSE_FURNITURE (50)
#define MAX_FURNITURE (2000)
#define MAX_HOUSE_STORAGE (10)
#define MAX_OWNABLE_HOUSES (3)
#define MAX_INVENTORYFURNITURE (120)
#define MAX_DROPPED_ITEMS (5000)
#define MAX_LISTED_ITEMS (10)
#define MODEL_SELECTION_INVENTORY (5)
#define THREAD_LOAD_INVENTORY (8)
#define     MAX_GPS                 (500)
#define 	MAX_ROADBLOCKS 			(85)

//==============================================================================
//==============================================================================
#define Range_VShort                                                            4.0
#define Range_Short                                                             15.0
#define Range_Normal                                                            20.0
#define Range_Long                                                              40.0
#define Range_VLong                                                             100.0   


#define SPLITLENGTH 118

#define LOG_PATH "/Server Logs/%s.txt"



#define SECONDS(%0)             (%0*1000)
#define MINUTES(%0)             (%0*SECONDS(60))
#define HOURS(%0)               (%0*MINUTES(60))

#define ALTCMD:%1->%2; \
    CMD:%1(playerid, params[]) \
    return cmd_%2(playerid, params);

#define ALTCMD2:%1->%2; \
    CMD:%1(playerid) \
    return cmd_%2(playerid);

// PRESSED(keys)
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))


//==============================================================================
#define TAXI_JOB														  		 1
#define MECHANIC_JOB													  		 2

#define PNC_JAIL																 1
#define PNC_CHARGE																 2
#define PNC_FINES																 3
#define PNC_WARRANT																 4
#define PNC_WLOG																 5

#define MAX_WOOD 25
#define MAX_APPLE 14

#define MAX_CONTACTS (20)

#define FACTION_POLICE (1)
#define FACTION_NEWS (2)
#define FACTION_MEDIC (3)
#define FACTION_GOV (4)
#define FACTION_GANG (5)

#define MODEL_SELECTION_FACTION_SKIN (11)
#define COLOR_FACTION     (0xBDF38BFF)

#define THREAD_LOAD_CONTACTS (10)

#define MODEL_SELECTION_SKINS (9)
#define MODEL_SELECTION_ADD_SKIN (10)
#define MODEL_SELECTION_FURNITURE (7)
#define MODEL_SELECTION_CLOTHES (3)

#define BitFlag_On(%0,%1)             ((%0) |= (%1))
#define BitFlag_Off(%0,%1)            ((%0) &= ~(%1)) // Turn off a flag.
#define BitFlag_Get(%0,%1)            ((%0) & (%1))   // Returns zero (false) if the flag isn't set.

#define SendAdminAction(%0,%1) \
	SendClientMessageEx(%0, COLOR_WHITE, "{FFFFFF} "%1)
	
	
#define COLOR_LIGHTRED    (0xFF6347FF)
#define COLOR_RADIO		  (0x8D8DFFFF)
#define COLOR_TREE        (0x50B228FF)

#define SystemMsg(%0,%1) \
	SendClientMessageEx(%0, COLOR_ORANGE, "[System]:{FFFFFF} "%1) // COLOR_YELLOW

#define ErrorMsg(%0,%1) \
	SendClientMessageEx(%0, COLOR_RED, "[!]{FFFFFF} "%1) // COLOR_YELLOW


//==============================================================================
//          -- > Colors
//==============================================================================
//COLOR
#define EMBED_RED "{FF0000}"
#define EMBED_LIGHTRED "{FF6347}"
#define EMBED_WHITE "{FFFFFF}"
#define EMBED_YELLOW "{FFFF00}"
#define EMBED_GREEN "{6BE300}"
#define EMBED_BLUE "{0000FF}"
#define EMBED_LIGHTBLUE "{33CCFF}"
#define EMBED_ORANGE "{FF8000}"
#define EMBED_GREY "{0DDA00}"
#define EMBED_CYAN "{00FFFF}"
#define EMBED_GRAD1 "{B4B5B7}"
#define EMBED_PURPLE "{C68DFF}"
#define EMBED_PINK "{FF8282}"
#define EMBED_TOMATO "{ff6347}"
#define EMBED_LIGHTBLUE2 "{8D8DFF}"
#define EMBED_LIGHTGREEN "{AEFFBC}"
#define EMBED_LIGHTYELLOW "{FDFF00}"


#define COLOR_DEPARTMENT  (0xFFD7004A)
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_HOSPITAL    (0xFF8282FF)
#define DEFAULT_COLOR     (0xFFFFFFFF)
#define COLOR_CLIENT      (0xAAC4E5FF)
#define COLOR_RADIOEX     (0xFFEC8BFF)
#define COL_WHITE                                                               "{FFFFFF}"
#define COLOR_HOTORANGE 						                                 0xF97804FF
#define COL_RED                                                                 "{F81414}"
#define COL_GREEN                                                               "{00FF22}"
#define COL_BLUE                                                                "{00C0FF}"
#define COL_LBLUE                                                               "{D3DCE3}"
#define COL_ORANGE                                                              "{FFAF00}"
#define COL_CYAN                                                                "{00FFEE}"
#define COL_BLACK                                                               "{0E0101}"
#define COL_GRAY                                                                "{C3C3C3}"
#define COL_DGREEN                                                              "{336633}"


#define COLOR_BLUE                                                              0x0000FFFF
#define COLOR_LGREEN                                                            0x00FF00FF
#define COLOR_YELLOW                                                            0xFFFF00FF
#define COLOR_BLACK                                                             0x000000FF
#define COLOR_GRAY                                                              0xC0C0C0FF
#define COLOR_WHITE                                                             0xFFFFFFFF
#define COLOR_GREY                                                              0xAFAFAFAA
#define COLOR_LBLUE                                                             0x3C3176AA
#define COLOR_MBLUE                                                             0x2E37FEAA
#define COLOR_DGREEN                                                            0x007200AA
#define COLOR_RP                                                                0xC2A2DAAA


#define COLOR_AQUA                                                               0x00FFFFFF
#define COLOR_AQUAMARINE                                                         0x7FFFD4FF
#define COLOR_AZURE                                                              0xF0FFFFFF
#define COLOR_BEIGE                                                              0xF5F5DCFF
#define COLOR_BISQUE                                                             0xFFE4C4FF
#define COLOR_BLACK                                                              0x000000FF
#define COLOR_BLANCHEDALMOND                                                     0xFFEBCDFF
#define COLOR_BLUE                                                               0x0000FFFF
#define COLOR_BLUEVIOLET                                                         0x8A2BE2FF
#define COLOR_BROWN                                                              0xA52A2AFF
#define COLOR_BURLYWOOD                                                          0xDEB887FF
#define COLOR_BUTTONFACE                                                         0xF0F0F0FF
#define COLOR_BUTTONHIGHLIGHT                                                    0xFFFFFFFF
#define COLOR_BUTTONSHADOW                                                       0xA0A0A0FF
#define COLOR_CADETBLUE                                                          0x5F9EA0FF
#define COLOR_CHARTREUSE                                                         0x7FFF00FF
#define COLOR_CHOCOLATE                                                          0xD2691EFF
#define COLOR_CORAL                                                              0xFF7F50FF
#define COLOR_CORNFLOWERBLUE                                                     0x6495EDFF
#define COLOR_CORNSILK                                                           0xFFF8DCFF
#define COLOR_CRIMSON                                                            0xDC143CFF
#define COLOR_CYAN                                                               0x00FFFFFF
#define COLOR_DARKBLUE                                                           0x00008BFF
#define COLOR_DARKCYAN                                                           0x008B8BFF
#define COLOR_DARKGOLDENROD                                                      0xB8860BFF
#define COLOR_DARKGRAY                                                           0xA9A9A9FF
#define COLOR_DARKGREEN                                                          0x006400FF
#define COLOR_DARKKHAKI                                                          0xBDB76BFF
#define COLOR_DARKMAGENTA                                                        0x8B008BFF
#define COLOR_DARKOLIVEGREEN                                                     0x556B2FFF
#define COLOR_DARKORANGE                                                         0xFF8C00FF
#define COLOR_DARKORCHID                                                         0x9932CCFF
#define COLOR_DARKRED                                                            0x8B0000FF
#define COLOR_DARKSALMON                                                         0xE9967AFF
#define COLOR_DARKSEAGREEN                                                       0x8FBC8BFF
#define COLOR_DARKSLATEBLUE                                                      0x483D8BFF
#define COLOR_DARKSLATEGRAY                                                      0x2F4F4FFF
#define COLOR_DARKTURQUOISE                                                      0x00CED1FF
#define COLOR_DARKVIOLET                                                         0x9400D3FF
#define COLOR_DEEPPINK                                                           0xFF1493FF
#define COLOR_DEEPSKYBLUE                                                        0x00BFFFFF
#define COLOR_DESKTOP                                                            0x000000FF
#define COLOR_DIMGRAY                                                            0x696969FF
#define COLOR_DODGERBLUE                                                         0x1E90FFFF
#define COLOR_FIREBRICK                                                          0xB22222FF
#define COLOR_FLORALWHITE                                                        0xFFFAF0FF
#define COLOR_FORESTGREEN                                                        0x228B22FF
#define COLOR_FUCHSIA                                                            0xFF00FFFF
#define COLOR_GAINSBORO                                                          0xDCDCDCFF
#define COLOR_GHOSTWHITE                                                         0xF8F8FFFF
#define COLOR_GOLD                                                               0xFFD700FF
#define COLOR_GOLDENROD                                                          0xDAA520FF
#define COLOR_GRAYTEXT                                                           0x808080FF
#define COLOR_GREEN                                                              0x008000FF
#define COLOR_GREENYELLOW                                                        0xADFF2FFF
#define COLOR_HIGHLIGHT                                                          0x3399FFFF
#define COLOR_HIGHLIGHTTEXT                                                      0xFFFFFFFF
#define COLOR_HONEYDEW                                                           0xF0FFF0FF
#define COLOR_HOTPINK                                                            0xFF69B4FF
#define COLOR_HOTTRACK                                                           0x0066CCFF
#define COLOR_INDIANRED                                                          0xCD5C5CFF
#define COLOR_INDIGO                                                             0x4B0082FF
#define COLOR_INFO                                                               0xFFFFE1FF
#define COLOR_INFOTEXT                                                           0x000000FF
#define COLOR_IVORY                                                              0xFFFFF0FF
#define COLOR_KHAKI                                                              0xF0E68CFF
#define COLOR_LAVENDER                                                           0xE6E6FAFF
#define COLOR_LAVENDERBLUSH                                                      0xFFF0F5FF
#define COLOR_LAWNGREEN                                                          0x7CFC00FF
#define COLOR_LEMONCHIFFON                                                       0xFFFACDFF
#define COLOR_LIGHTBLUE                                                          0xADD8E6FF
#define COLOR_LIGHTCORAL                                                         0xF08080FF
#define COLOR_LIGHTCYAN                                                          0xE0FFFFFF
#define COLOR_LIGHTGOLDENRODYELLOW                                               0xFAFAD2FF
#define COLOR_LIGHTGRAY                                                          0xD3D3D3FF
#define COLOR_LIGHTGREEN                                                         0x90EE90FF
#define COLOR_LIGHTPINK                                                          0xFFB6C1FF
#define COLOR_LIGHTSALMON                                                        0xFFA07AFF
#define COLOR_LIGHTSEAGREEN                                                      0x20B2AAFF
#define COLOR_LIGHTSKYBLUE                                                       0x87CEFAFF
#define COLOR_LIGHTSLATEGRAY                                                     0x778899FF
#define COLOR_LIGHTSTEELBLUE                                                     0xB0C4DEFF
#define COLOR_LIGHTYELLOW                                                        0xFFFFE0FF
#define COLOR_LIME                                                               0x00FF00FF
#define COLOR_LIMEGREEN                                                          0x32CD32FF
#define COLOR_LINEN                                                              0xFAF0E6FF
#define COLOR_MAGENTA                                                            0xFF00FFFF
#define COLOR_MAROON                                                             0x800000FF
#define COLOR_MEDIUMAQUAMARINE                                                   0x66CDAAFF
#define COLOR_MEDIUMBLUE                                                         0x0000CDFF
#define COLOR_MEDIUMORCHID                                                       0xBA55D3FF
#define COLOR_MEDIUMPURPLE                                                       0x9370DBFF
#define COLOR_MEDIUMSEAGREEN                                                     0x3CB371FF
#define COLOR_MEDIUMSLATEBLUE                                                    0x7B68EEFF
#define COLOR_MEDIUMSPRINGGREEN                                                  0x00FA9AFF
#define COLOR_MEDIUMTURQUOISE                                                    0x48D1CCFF
#define COLOR_MEDIUMVIOLETRED                                                    0xC71585FF
#define COLOR_MIDNIGHTBLUE                                                       0x191970FF
#define COLOR_MINTCREAM                                                          0xF5FFFAFF
#define COLOR_MISTYROSE                                                          0xFFE4E1FF
#define COLOR_MOCCASIN                                                           0xFFE4B5FF
#define COLOR_NAVAJOWHITE                                                        0xFFDEADFF
#define COLOR_NAVY                                                               0x000080FF
#define COLOR_OLDLACE                                                            0xFDF5E6FF
#define COLOR_OLIVE                                                              0x808000FF
#define COLOR_OLIVEDRAB                                                          0x6B8E23FF
#define COLOR_ORANGE                                                             0xFFA500FF
#define COLOR_ORANGERED                                                          0xFF4500FF
#define COLOR_ORCHID                                                             0xDA70D6FF
#define COLOR_PALEGOLDENROD                                                      0xEEE8AAFF
#define COLOR_PALEGREEN                                                          0x98FB98FF
#define COLOR_PALETURQUOISE                                                      0xAFEEEEFF
#define COLOR_PALEVIOLETRED                                                      0xDB7093FF
#define COLOR_PAPAYAWHIP                                                         0xFFEFD5FF
#define COLOR_PEACHPUFF                                                          0xFFDAB9FF
#define COLOR_PERU                                                               0xCD853FFF
#define COLOR_PINK                                                               0xFFC0CBFF
#define COLOR_PLUM                                                               0xDDA0DDFF
#define COLOR_POWDERBLUE                                                         0xB0E0E6FF
#define COLOR_PURPLE                                                             0x800080FF
#define COLOR_RED                                                                0xFF0000FF
#define COLOR_ROSYBROWN                                                          0xBC8F8FFF
#define COLOR_ROYALBLUE                                                          0x4169E1FF
#define COLOR_SADDLEBROWN                                                        0x8B4513FF
#define COLOR_SALMON                                                             0xFA8072FF
#define COLOR_SANDYBROWN                                                         0xF4A460FF
#define COLOR_SEAGREEN                                                           0x2E8B57FF
#define COLOR_SEASHELL                                                           0xFFF5EEFF
#define COLOR_SIENNA                                                             0xA0522DFF
#define COLOR_SILVER                                                             0xC0C0C0FF
#define COLOR_SKYBLUE                                                            0x87CEEBFF
#define COLOR_SLATEBLUE                                                          0x6A5ACDFF
#define COLOR_SLATEGRAY                                                          0x708090FF
#define COLOR_SNOW                                                               0xFFFAFAFF
#define COLOR_SPRINGGREEN                                                        0x00FF7FFF
#define COLOR_STEELBLUE                                                          0x4682B4FF
#define COLOR_TAN                                                                0xD2B48CFF
#define COLOR_TEAL                                                               0x008080FF
#define COLOR_THISTLE                                                            0xD8BFD8FF
#define COLOR_TOMATO                                                             0xFF6347FF
#define COLOR_TRANSPARENT                                                        0xFFFFFF00
#define COLOR_TURQUOISE                                                          0x40E0D0FF
#define COLOR_VIOLET                                                             0xEE82EEFF
#define COLOR_WHEAT                                                              0xF5DEB3FF
#define COLOR_WHITE                                                              0xFFFFFFFF
#define COLOR_WINDOWTEXT                                                         0x000000FF
#define COLOR_YELLOW                                                             0xFFFF00FF
#define COLOR_YELLOWGREEN                                                        0x9ACD32FF
#define STEALTH_ORANGE                                                           0xFF880000
#define STEALTH_OLIVE                                                            0x66660000
#define STEALTH_GREEN                                                            0x33DD1100
#define STEALTH_PINK                                                             0xFF22EE00
#define STEALTH_BLUE                                                             0x0077BB00
