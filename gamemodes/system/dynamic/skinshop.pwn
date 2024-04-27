#include <YSI_Coding\y_hooks>

#define     MAX_SKINSHOP             (100)
enum SKINSHOP_DATA {
	SkinshopID,
	SkinshopExists,
	SkinshopModel,
	SkinshopPrice,
	SkinshopTotal,
	SkinshopType
};
new skinshopData[MAX_SKINSHOP][SKINSHOP_DATA];

CMD:createskin(playerid, params[])
{
	static
	    id = -1,
		model,
		price,
		total,
		type;

    if (playerData[playerid][pAdmin] < 3)
	    return 1;

	if (sscanf(params, "dddd", model, price, type, total))
	{
	    SendClientMessage(playerid, COLOR_YELLOW, "การใช้งาน : /createskin [ไอดีชุด] [ราคา] [รูปแบบ] [จำนวน]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[รูปแบบ]:{FFFFFF} 1: ธรรมดา | 2: โดเนท");
	    return 1;
	}
	if (model < 0 || model > 311)
		return ErrorMsg(playerid, "- ไอดีชุดมีตั้งแต่ 0 - 311 เท่านั้น");

	if (price < 1 || price > 50000000)
		return ErrorMsg(playerid, "- ราคาต้องไม่ต่ำกว่า $1");

	if (type < 1 || type > 2)
		return ErrorMsg(playerid, "- รูปแบบของรถต้องไม่ต่ำกว่า 1 และไม่เกิน 2 เท่านั้น");

	if (total < 1)
		return ErrorMsg(playerid, "- รูปแบบของรถต้องไม่ต่ำกว่า 1 ");

	id = SKINHOP_Create(model, price, type, total);

	if (id == -1)
	    return ErrorMsg(playerid, "- ขนาดความจุของชุดนั้นเต็มแล้ว ไม่สามารถใส่เพิ่มได้อีก");

	SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Create{FFA84D} SkinShop(Type:%d):{FFFFFF} (ราคา: %s | ไอดี: %d จำนวน: %d ตัว)", GetPlayerNameEx(playerid), type, FormatMoney(price), model, total);
	return 1;
}

CMD:removeskin(playerid, params[])
{
	static
	    id = 0;

    if (playerData[playerid][pAdmin] < 5)
	    return 1;

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, COLOR_LIGHTBLUE, "การใช้งาน : {ffffff}/removeskin [ไอดี]");

	if ((id < 0 || id >= MAX_SKINSHOP) || !skinshopData[id][SkinshopExists])
	    return ErrorMsg(playerid, "- ไม่มีไอดี Skinshop นี้อยู่ในฐานข้อมูล");

	SKINSHOP_Delete(id);
	SendClientMessageEx(playerid, COLOR_LIGHTRED, "ร้านขายชุด: {ffffff}คุณได้ลบ Skinshop ไอดี %d ออกสำเร็จ", id);
	return 1;
}

SKINHOP_Create(model, price, type, total)
{
	for (new i = 0; i < MAX_SKINSHOP; i ++) if (!skinshopData[i][SkinshopExists])
	{
	    skinshopData[i][SkinshopExists] = true;
	    skinshopData[i][SkinshopModel] = model;
	    skinshopData[i][SkinshopPrice] = price;
	    skinshopData[i][SkinshopType] = type;
	    skinshopData[i][SkinshopTotal] = total;

	    mysql_tquery(g_SQL, "INSERT INTO `skinshop` (`skinshopID`) VALUES(0)", "OnSkinshopCreated", "d", i);
		return i;
	}
	return -1;
}
forward OnSkinshopCreated(skinshopid);
public OnSkinshopCreated(skinshopid)
{
	if (skinshopid == -1 || !skinshopData[skinshopid][SkinshopExists])
	    return 0;

	skinshopData[skinshopid][SkinshopID] = cache_insert_id();
	SkinSHOP_Save(skinshopid);

	return 1;
}
SkinSHOP_Save(skinshopid)
{
	static
	    query[220];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE `skinshop` SET `SkinshopModel` = '%d', `SkinshopPrice` = '%d', `SkinshopType` = '%d', `SkinshopTotal` = '%d' WHERE `SkinshopID` = '%d'",
		skinshopData[skinshopid][SkinshopModel],
	    skinshopData[skinshopid][SkinshopPrice],
	    skinshopData[skinshopid][SkinshopType],
	    skinshopData[skinshopid][SkinshopTotal],
	    skinshopData[skinshopid][SkinshopID]
	);
	return mysql_tquery(g_SQL, query);
}
SKINSHOP_Delete(skinshopid)
{
	if (skinshopid != -1 && skinshopData[skinshopid][SkinshopExists])
	{
	    static
	        string[64];

		format(string, sizeof(string), "DELETE FROM `skinshop` WHERE `SkinshopID` = '%d'", skinshopData[skinshopid][SkinshopID]);
		mysql_tquery(g_SQL, string);

		skinshopData[skinshopid][SkinshopExists] = false;
		skinshopData[skinshopid][SkinshopID] = 0;
	}
	return 1;
}
forward SKINSHOP_Load();
public SKINSHOP_Load()
{
	static
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_SKINSHOP)
	{
	    skinshopData[i][SkinshopExists] = true;

	    cache_get_value_name_int(i, "SkinshopID", skinshopData[i][SkinshopID]);
	    cache_get_value_name_int(i, "SkinshopModel", skinshopData[i][SkinshopModel]);
	    cache_get_value_name_int(i, "SkinshopPrice", skinshopData[i][SkinshopPrice]);
	    cache_get_value_name_int(i, "SkinshopType", skinshopData[i][SkinshopType]);
	    cache_get_value_name_int(i, "SkinshopTotal", skinshopData[i][SkinshopTotal]);
	}
	printf("[SERVER]: %i Skinshop were loaded from \"%s\" database...", rows, MYSQL_DATABASE);
	return 1;
}





SkinShopForPlayer(playerid)
{
	new
		count,
		var[32],
		string[512],
		string2[512];

	for (new i = 0; i != MAX_SKINSHOP; i ++) if (skinshopData[i][SkinshopExists])
	{
		if(skinshopData[i][SkinshopType] == 1)
		{
			format(string, sizeof(string), "%d\tไอดี: %d(จำนวน: %d)\t%s\n", i+1, skinshopData[i][SkinshopModel], skinshopData[i][SkinshopTotal], FormatMoney(skinshopData[i][SkinshopPrice]));
			strcat(string2, string);
			format(var, sizeof(var), "SKINSHOPID%d", count);
			SetPVarInt(playerid, var, i);
			count++;
		}
	}
	if (!count)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "- ไม่สามารถดำเนินการได้ เนื่องจากคลังสินค้าภายในธุรกิจนี้หมด");
		return 1;
	}
	format(string, sizeof(string), "ลำดับ\tรายการสินค้า(จำนวน)\tราคา\n%s", string2);
	Dialog_Show(playerid, DIALOG_SKINSHOP, DIALOG_STYLE_TABLIST_HEADERS, "ร้านขายเสื้อผ้า", string, "ซื้อ", "ปิด");
	return 1;
}


Dialog:DIALOG_SKINSHOP(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new var[32];
	    format(var, sizeof(var), "SKINSHOPID%d", listitem);
	    new skinshopid = GetPVarInt(playerid, var);

		if (GetPlayerMoneyEx(playerid) < skinshopData[skinshopid][SkinshopPrice])
		{
			SendClientMessageEx(playerid, COLOR_LIGHTRED, "- คุณไม่สามารถซื้อได้ เนื่องจากเงินของคุณไม่เพียงพอ (( %s/%s ))", FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(skinshopData[skinshopid][SkinshopPrice]));
			return 1;
		}
		SetPlayerSkin(playerid, skinshopData[skinshopid][SkinshopModel]);
		GivePlayerMoneyEx(playerid, -skinshopData[skinshopid][SkinshopPrice]);
		SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop] คุณได้ซื้อชุด '%d' ในราคา %s", skinshopData[skinshopid][SkinshopModel], FormatMoney(skinshopData[skinshopid][SkinshopPrice]));

		skinshopData[skinshopid][SkinshopTotal] --;
		if(skinshopData[skinshopid][SkinshopTotal] == 0)
			return SKINSHOP_Delete(skinshopid);
	}
	return 1;
}

