#if defined __eSelection_included
	#endinput
#endif
#define __eSelection_included

#include <a_samp>
#include <PawnPlus>

#if !defined MAX_ITEM_PER_PAGE
	#define MAX_ITEM_PER_PAGE (20)
#endif

#define MAX_MODEL_TEXT 64

#define MODEL_RESPONSE_CANCEL (0)
#define MODEL_RESPONSE_SELECT (1)

forward OnModelSelectionResponse(playerid, extraid, index, modelid, response);

//player textdraws
static PlayerText:g_MenuHeaderText[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
static PlayerText:g_MenuPageNumber[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
static PlayerText:g_MenuItems[MAX_PLAYERS][MAX_ITEM_PER_PAGE] = {{PlayerText:INVALID_TEXT_DRAW, ...}, ...};
static PlayerText:g_MenuItemText[MAX_PLAYERS][MAX_ITEM_PER_PAGE] = {{PlayerText:INVALID_TEXT_DRAW, ...}, ...};

// Ironpie - Arizona
new Text:Ironpie_Public[36];
new PlayerText:Ironpie_Arizona[MAX_PLAYERS][63];

//PawnPlus list for models
static List:g_MenuModels[MAX_PLAYERS] = {INVALID_LIST, ...};

//general model menu variables
static g_MenuItemCount[MAX_PLAYERS];
static g_MenuCurrentPage[MAX_PLAYERS] = {1, ...};
static g_MenuPageCount[MAX_PLAYERS];
static bool:g_MenuShown[MAX_PLAYERS];
static g_MenuExtraID[MAX_PLAYERS];
static g_MenuCooldownTick[MAX_PLAYERS];

//enum for model data
enum _:g_eMenuModelData
{
	g_eMenuModel,
	g_eMenuModelText[MAX_MODEL_TEXT],
	bool:g_eItemUseRotation,
	Float:g_eItemRotX,
	Float:g_eItemRotY,
	Float:g_eItemRotZ,
	Float:g_eItemZoom,
	g_eItemVehicleColor[2]
}

//pawnplus task data
enum _:E_MODEL_SELECTION_INFO
{
	E_MODEL_SELECTION_RESPONSE,
	E_MODEL_SELECTION_INDEX,
	E_MODEL_SELECTION_MODELID
}

//"P+" in ascii hex (THANKS GRABER)
const PAWN_PLUS_EXTRA_ID = 0x502B;

//pawnplus task
static Task:ModelSelectionTask[MAX_PLAYERS];

//functions
stock AddModelMenuItem(List:menulist, modelid, text[] = "", bool:usingrotation = false, Float:rotx = 0.0, Float:roty = 0.0, Float:rotz = 0.0, Float:zoom = 1.0, vehiclecolor1 = -1, vehiclecolor2 = -1)
{
	new item[g_eMenuModelData];
	item[g_eMenuModel] = modelid;
	format(item[g_eMenuModelText], MAX_MODEL_TEXT, text);
	item[g_eItemUseRotation] = usingrotation;
	item[g_eItemRotX] = rotx;
	item[g_eItemRotY] = roty;
	item[g_eItemRotZ] = rotz;
	item[g_eItemZoom] = zoom;
	item[g_eItemVehicleColor][0] = vehiclecolor1;
	item[g_eItemVehicleColor][1] = vehiclecolor2;
	list_add_arr(menulist, item);
}

stock ShowModelSelectionMenu(playerid, extraid, List:items)
{
	if(!IsPlayerConnected(playerid)) return false;
	if(g_MenuShown[playerid]) HideModelSelectionMenu(playerid);

	g_MenuModels[playerid] = items;
	g_MenuExtraID[playerid] = extraid;
	g_MenuShown[playerid] = true;
	g_MenuCooldownTick[playerid] = GetTickCount();
	g_MenuCurrentPage[playerid] = 1;
	g_MenuPageCount[playerid] = (list_size(items) / MAX_ITEM_PER_PAGE) + 1;

	ShowModelSelectionMenuTextDraws(playerid);
	return true;
}

stock Task:ShowAsyncModelSelectionMenu(playerid, const header[], List:items)
{
	if(task_valid(ModelSelectionTask[playerid])) task_delete(ModelSelectionTask[playerid]);

	ModelSelectionTask[playerid] = task_new();
	ShowModelSelectionMenu(playerid, PAWN_PLUS_EXTRA_ID, items);
	return ModelSelectionTask[playerid];
}

static stock ShowModelSelectionMenuTextDraws(playerid)
{
	DestroyModelSelectionPlayerTDs(playerid);
	CreateModelSelectionPlayerTDs(playerid);

	for(new Iter:i = list_iter(g_MenuModels[playerid]), count, model[g_eMenuModelData]; iter_inside(i); iter_move_next(i))
	{
		if(count >= MAX_ITEM_PER_PAGE) break;

		iter_get_arr(i, model);
		SetModelSelectionModelBox(playerid, count, model);
		count ++;
	}

	//page TD
	new page[8];
	format(page, sizeof(page), "1/%d", (list_size(g_MenuModels[playerid]) / MAX_ITEM_PER_PAGE) + 1);
	PlayerTextDrawSetString(playerid, g_MenuPageNumber[playerid], page);

	//header text
	/*PlayerTextDrawSetString(playerid, g_MenuHeaderText[playerid], header);
	PlayerTextDrawShow(playerid, g_MenuHeaderText[playerid]);
	PlayerTextDrawShow(playerid, g_MenuPageNumber[playerid]);*/
		
	SelectTextDraw(playerid, COLOR_ORANGE);
}

stock HideModelSelectionMenu(playerid)
{
	if(!IsPlayerConnected(playerid) || !g_MenuShown[playerid]) return false;
	
	DestroyModelSelectionPlayerTDs(playerid);

	g_MenuShown[playerid] = false;
	g_MenuItemCount[playerid] = 0;
	g_MenuExtraID[playerid] = 0;
	g_MenuCurrentPage[playerid] = 1;
	g_MenuPageCount[playerid] = 0;

	if(list_valid(g_MenuModels[playerid])) list_delete(g_MenuModels[playerid]);
	g_MenuModels[playerid] = INVALID_LIST;

	CancelSelectTextDraw(playerid);
	return true;
}

static stock SetModelSelectionMenuPage(playerid, page)
{
	if(!g_MenuShown[playerid]) return false;
	if(page < 1 || page > g_MenuPageCount[playerid]) return false;

	new start = (MAX_ITEM_PER_PAGE * (page - 1));

	for(new i = 0; i < MAX_ITEM_PER_PAGE; i ++)
	{
		PlayerTextDrawHide(playerid, g_MenuItems[playerid][i]);
		PlayerTextDrawHide(playerid, g_MenuItemText[playerid][i]);
	}

	for(new Iter:i = list_iter(g_MenuModels[playerid], start), count, model[g_eMenuModelData]; iter_inside(i); iter_move_next(i))
	{
		if(count >= MAX_ITEM_PER_PAGE) break;

		iter_get_arr(i, model);
		SetModelSelectionModelBox(playerid, count, model);
		count ++;
	}
	g_MenuCurrentPage[playerid] = page;

	new pagetext[12];
	format(pagetext, sizeof(pagetext), "%d/%d", page,  g_MenuPageCount[playerid]);
	PlayerTextDrawSetString(playerid, g_MenuPageNumber[playerid], pagetext);
	return true;
}

static stock SetModelSelectionModelBox(playerid, count, model[g_eMenuModelData])
{
	PlayerTextDrawSetPreviewModel(playerid, g_MenuItems[playerid][count], model[g_eMenuModel]);
	if(model[g_eItemUseRotation])
	{
		PlayerTextDrawSetPreviewRot(playerid, g_MenuItems[playerid][count], model[g_eItemRotX], model[g_eItemRotY], model[g_eItemRotZ], model[g_eItemZoom]);
	}
	else
	{
		PlayerTextDrawSetPreviewRot(playerid, g_MenuItems[playerid][count], 0.0, 0.0, 0.0);
	}

	if(model[g_eItemVehicleColor][0] != -1)
	{
		new secondarycolor = model[g_eItemVehicleColor][1] == -1 ? model[g_eItemVehicleColor][0] : model[g_eItemVehicleColor][1];
		PlayerTextDrawSetPreviewVehCol(playerid, g_MenuItems[playerid][count], model[g_eItemVehicleColor][0], secondarycolor);
	}

	PlayerTextDrawShow(playerid, g_MenuItems[playerid][count]);

	if(model[g_eMenuModelText][0])
	{
		PlayerTextDrawSetString(playerid, g_MenuItemText[playerid][count], model[g_eMenuModelText]);
		PlayerTextDrawShow(playerid, g_MenuItemText[playerid][count]);
	}
}

static stock CreateModelSelectionPlayerTDs(playerid)
{
	//page TD
	/*g_MenuPageNumber[playerid] = CreatePlayerTextDraw(playerid, 447.000000, 107.000000, "0/1");
	PlayerTextDrawLetterSize(playerid, g_MenuPageNumber[playerid], 00.170833, 1.650000);
	PlayerTextDrawAlignment(playerid, g_MenuPageNumber[playerid], 3);
	PlayerTextDrawColor(playerid, g_MenuPageNumber[playerid], -1);
	PlayerTextDrawSetShadow(playerid, g_MenuPageNumber[playerid], 0);
	PlayerTextDrawSetOutline(playerid, g_MenuPageNumber[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, g_MenuPageNumber[playerid], 255);
	PlayerTextDrawFont(playerid, g_MenuPageNumber[playerid], 2);
	PlayerTextDrawSetProportional(playerid, g_MenuPageNumber[playerid], 1);

	//header test
	g_MenuHeaderText[playerid] = CreatePlayerTextDraw(playerid, 314.000000, 109.000000, "Inventory (24/24)");
	PlayerTextDrawLetterSize(playerid, g_MenuHeaderText[playerid], 0.220833, 1.850000);
	PlayerTextDrawAlignment(playerid, g_MenuHeaderText[playerid], 1);
	PlayerTextDrawColor(playerid, g_MenuHeaderText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, g_MenuHeaderText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, g_MenuHeaderText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, g_MenuHeaderText[playerid], 255);
	PlayerTextDrawFont(playerid, g_MenuHeaderText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, g_MenuHeaderText[playerid], 1);*/
	
	new Float:x = 279.0, Float:y = 165.0;
	for(new i = 0, idx = 0; i < MAX_ITEM_PER_PAGE; i ++)
	{
		if(idx > 0 && (idx % 5) == 0)
		{
			x = 312.5; //
			y += 39.0;
		}
		else
		{
			x += 33.5;
		}
		idx++;

		g_MenuItems[playerid][i] = CreatePlayerTextDraw(playerid, x, y, "_");
		PlayerTextDrawBackgroundColor(playerid, g_MenuItems[playerid][i], 1296911741);
		PlayerTextDrawFont(playerid, g_MenuItems[playerid][i], 5);
		PlayerTextDrawLetterSize(playerid, g_MenuItems[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawColor(playerid, g_MenuItems[playerid][i], -1);
		PlayerTextDrawSetOutline(playerid, g_MenuItems[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, g_MenuItems[playerid][i], 1);
		PlayerTextDrawUseBox(playerid, g_MenuItems[playerid][i], 1);
		PlayerTextDrawBoxColor(playerid, g_MenuItems[playerid][i], 0);
		PlayerTextDrawTextSize(playerid, g_MenuItems[playerid][i], 30.500000, 35.000000);
		PlayerTextDrawSetSelectable(playerid, g_MenuItems[playerid][i], 1);

		g_MenuItemText[playerid][i] = CreatePlayerTextDraw(playerid, x + 25.0, y + 26.0, "_");
		PlayerTextDrawFont(playerid, g_MenuItemText[playerid][i], 2);
		PlayerTextDrawLetterSize(playerid, g_MenuItemText[playerid][i], 0.145833, 0.800000);
		PlayerTextDrawAlignment(playerid, g_MenuItemText[playerid][i], 2);
		PlayerTextDrawSetOutline(playerid, g_MenuItemText[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, g_MenuItemText[playerid][i], 1);
		PlayerTextDrawTextSize(playerid, g_MenuItemText[playerid][i], 400.000000, 17.000000);
		PlayerTextDrawSetShadow(playerid, g_MenuItemText[playerid][i], 0);
		PlayerTextDrawColor(playerid, g_MenuItemText[playerid][i], -1);
	}
}

static stock DestroyModelSelectionPlayerTDs(playerid)
{
	if(g_MenuHeaderText[playerid] != PlayerText:INVALID_TEXT_DRAW) PlayerTextDrawDestroy(playerid, g_MenuHeaderText[playerid]);
	if(g_MenuPageNumber[playerid] != PlayerText:INVALID_TEXT_DRAW) PlayerTextDrawDestroy(playerid, g_MenuPageNumber[playerid]);

	g_MenuHeaderText[playerid] = PlayerText:INVALID_TEXT_DRAW;
	g_MenuPageNumber[playerid] = PlayerText:INVALID_TEXT_DRAW;

	for(new i = 0; i < MAX_ITEM_PER_PAGE; i++)
	{
		if(g_MenuItems[playerid][i] != PlayerText:INVALID_TEXT_DRAW) PlayerTextDrawDestroy(playerid, g_MenuItems[playerid][i]);
		if(g_MenuItemText[playerid][i] != PlayerText:INVALID_TEXT_DRAW) PlayerTextDrawDestroy(playerid, g_MenuItemText[playerid][i]);

		g_MenuItems[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		g_MenuItemText[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	}
}

//callbacks
public OnGameModeInit()
{	
	#if defined MS_OnGameModeInit
		return MS_OnGameModeInit();
	#else
		return true;
	#endif
}

public OnPlayerDisconnect(playerid, reason)
{
	g_MenuHeaderText[playerid] = PlayerText:INVALID_TEXT_DRAW;
	g_MenuPageNumber[playerid] = PlayerText:INVALID_TEXT_DRAW;

	for(new i = 0; i < MAX_ITEM_PER_PAGE; i++)
	{
		g_MenuItems[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		g_MenuItemText[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	}

	#if defined MS_OnPlayerDisconnect
		return MS_OnPlayerDisconnect(playerid, reason);
	#else
		return true;
	#endif
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	#if defined MS_OnPlayerClickTextDraw
		return MS_OnPlayerClickTextDraw(playerid, Text:clickedid);
	#else
		return true;
	#endif
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(g_MenuShown[playerid] && (GetTickCount() - g_MenuCooldownTick[playerid]) > 600)
	{
		for(new i = 0; i < MAX_ITEM_PER_PAGE; i ++)
		{
			if(g_MenuItems[playerid][i] == playertextid)
			{
				new index, extraid, modelid;
				index = (i + (g_MenuCurrentPage[playerid] - 1) * MAX_ITEM_PER_PAGE);
				extraid = g_MenuExtraID[playerid];
				modelid = list_get(g_MenuModels[playerid], index);

				if(extraid != PAWN_PLUS_EXTRA_ID)
				{
					CallLocalFunction("OnModelSelectionResponse", "iiiii", playerid, extraid, index, modelid, MODEL_RESPONSE_SELECT);
					HideModelSelectionMenu(playerid);
				}
				else
				{
					new model_response[E_MODEL_SELECTION_INFO];
					model_response[E_MODEL_SELECTION_INDEX] = index;
					model_response[E_MODEL_SELECTION_MODELID] = modelid;
					model_response[E_MODEL_SELECTION_RESPONSE] = MODEL_RESPONSE_SELECT;

					HideModelSelectionMenu(playerid);

					new const Task:task = ModelSelectionTask[playerid];
					ModelSelectionTask[playerid] = Task:0;
					task_set_result_arr(task, model_response);
				}
			}
			if(playertextid == Ironpie_Arizona[playerid][8])
			{
				if(g_MenuExtraID[playerid] != PAWN_PLUS_EXTRA_ID)
				{
					CallLocalFunction("OnModelSelectionResponse", "iiiii", playerid, g_MenuExtraID[playerid], 0, 0, MODEL_RESPONSE_CANCEL);
					HideModelSelectionMenu(playerid);

					for (new x = 0; x < 36; x ++) {
						TextDrawHideForPlayer(playerid, Ironpie_Public[x]);
					}
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][0]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][1]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][2]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][3]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][4]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][5]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][6]);		
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][7]);		
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][8]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][39]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][40]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][41]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][42]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][43]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][44]);
				}
				else
				{
					new model_response[E_MODEL_SELECTION_INFO];
					model_response[E_MODEL_SELECTION_INDEX] = 0;
					model_response[E_MODEL_SELECTION_MODELID] = 0;
					model_response[E_MODEL_SELECTION_RESPONSE] = MODEL_RESPONSE_CANCEL;

					HideModelSelectionMenu(playerid);

					new const Task:task = ModelSelectionTask[playerid];
					ModelSelectionTask[playerid] = Task:0;
					task_set_result_arr(task, model_response);

					for (new x = 0; x < 36; x ++) {
						TextDrawHideForPlayer(playerid, Ironpie_Public[x]);
					}
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][0]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][1]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][2]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][3]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][4]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][5]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][6]);		
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][7]);		
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][8]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][39]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][40]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][41]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][42]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][43]);
					PlayerTextDrawHide(playerid, Ironpie_Arizona[playerid][44]);									
				}
			}
			if(playertextid == Ironpie_Arizona[playerid][39])
			{
				if(g_MenuCurrentPage[playerid] == g_MenuPageCount[playerid]) return false;

				SetModelSelectionMenuPage(playerid, 1);
				return true;			
			}
			if(playertextid == Ironpie_Arizona[playerid][40])
			{
				if(g_MenuCurrentPage[playerid] == g_MenuPageCount[playerid]) return false;

				SetModelSelectionMenuPage(playerid, 2);
				return true;			
			}
			if(playertextid == Ironpie_Arizona[playerid][41])
			{
				if(g_MenuCurrentPage[playerid] == g_MenuPageCount[playerid]) return false;

				SetModelSelectionMenuPage(playerid, 3);
				return true;						
			}
			if(playertextid == Ironpie_Arizona[playerid][42])
			{
				if(g_MenuCurrentPage[playerid] == g_MenuPageCount[playerid]) return false;

				SetModelSelectionMenuPage(playerid, 4);
				return true;		
			}
			if(playertextid == Ironpie_Arizona[playerid][43])
			{
				if(g_MenuCurrentPage[playerid] == g_MenuPageCount[playerid]) return false;

				SetModelSelectionMenuPage(playerid, 5);
				return true;			
			}	
		}
	}

	#if defined MS_OnPlayerClickPlayerTextDraw
		return MS_OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid);
	#else
		return true;
	#endif
}

//hooks
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit MS_OnGameModeInit
#if defined MS_OnGameModeInit
	forward MS_OnGameModeInit();
#endif

#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect MS_OnPlayerDisconnect
#if defined MS_OnPlayerDisconnect
	forward MS_OnPlayerDisconnect(playerid, reason);
#endif

#if defined _ALS_OnPlayerClickTextDraw
	#undef OnPlayerClickTextDraw
#else
	#define _ALS_OnPlayerClickTextDraw
#endif

#define OnPlayerClickTextDraw MS_OnPlayerClickTextDraw
#if defined MS_OnPlayerClickTextDraw
	forward MS_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif

#if defined _ALS_OnPlayerClickPlayerTD
	#undef OnPlayerClickPlayerTextDraw
#else
	#define _ALS_OnPlayerClickPlayerTD
#endif

#define OnPlayerClickPlayerTextDraw MS_OnPlayerClickPlayerTextDraw
#if defined MS_OnPlayerClickPlayerTextDraw
	forward MS_OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid);
#endif