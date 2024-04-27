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
	    SendClientMessage(playerid, COLOR_YELLOW, "�����ҹ : /createskin [�ʹժش] [�Ҥ�] [�ٻẺ] [�ӹǹ]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[�ٻẺ]:{FFFFFF} 1: ������ | 2: �๷");
	    return 1;
	}
	if (model < 0 || model > 311)
		return ErrorMsg(playerid, "- �ʹժش�յ���� 0 - 311 ��ҹ��");

	if (price < 1 || price > 50000000)
		return ErrorMsg(playerid, "- �Ҥҵ�ͧ����ӡ��� $1");

	if (type < 1 || type > 2)
		return ErrorMsg(playerid, "- �ٻẺ�ͧö��ͧ����ӡ��� 1 �������Թ 2 ��ҹ��");

	if (total < 1)
		return ErrorMsg(playerid, "- �ٻẺ�ͧö��ͧ����ӡ��� 1 ");

	id = SKINHOP_Create(model, price, type, total);

	if (id == -1)
	    return ErrorMsg(playerid, "- ��Ҵ�����آͧ�ش���������� �������ö����������ա");

	SendAdminMessage(COLOR_YELLOW, "[Admin-Message] %s {FFFFFF}Create{FFA84D} SkinShop(Type:%d):{FFFFFF} (�Ҥ�: %s | �ʹ�: %d �ӹǹ: %d ���)", GetPlayerNameEx(playerid), type, FormatMoney(price), model, total);
	return 1;
}

CMD:removeskin(playerid, params[])
{
	static
	    id = 0;

    if (playerData[playerid][pAdmin] < 5)
	    return 1;

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, COLOR_LIGHTBLUE, "�����ҹ : {ffffff}/removeskin [�ʹ�]");

	if ((id < 0 || id >= MAX_SKINSHOP) || !skinshopData[id][SkinshopExists])
	    return ErrorMsg(playerid, "- ������ʹ� Skinshop �������㹰ҹ������");

	SKINSHOP_Delete(id);
	SendClientMessageEx(playerid, COLOR_LIGHTRED, "��ҹ��ªش: {ffffff}�س��ź Skinshop �ʹ� %d �͡�����", id);
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
			format(string, sizeof(string), "%d\t�ʹ�: %d(�ӹǹ: %d)\t%s\n", i+1, skinshopData[i][SkinshopModel], skinshopData[i][SkinshopTotal], FormatMoney(skinshopData[i][SkinshopPrice]));
			strcat(string2, string);
			format(var, sizeof(var), "SKINSHOPID%d", count);
			SetPVarInt(playerid, var, i);
			count++;
		}
	}
	if (!count)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "- �������ö���Թ����� ���ͧ�ҡ��ѧ�Թ������㹸�áԨ������");
		return 1;
	}
	format(string, sizeof(string), "�ӴѺ\t��¡���Թ���(�ӹǹ)\t�Ҥ�\n%s", string2);
	Dialog_Show(playerid, DIALOG_SKINSHOP, DIALOG_STYLE_TABLIST_HEADERS, "��ҹ�������ͼ��", string, "����", "�Դ");
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
			SendClientMessageEx(playerid, COLOR_LIGHTRED, "- �س�������ö������ ���ͧ�ҡ�Թ�ͧ�س�����§�� (( %s/%s ))", FormatMoney(GetPlayerMoneyEx(playerid)), FormatMoney(skinshopData[skinshopid][SkinshopPrice]));
			return 1;
		}
		SetPlayerSkin(playerid, skinshopData[skinshopid][SkinshopModel]);
		GivePlayerMoneyEx(playerid, -skinshopData[skinshopid][SkinshopPrice]);
		SendClientMessageEx(playerid, COLOR_GREEN, "[Skin Shop] �س����ͪش '%d' ��Ҥ� %s", skinshopData[skinshopid][SkinshopModel], FormatMoney(skinshopData[skinshopid][SkinshopPrice]));

		skinshopData[skinshopid][SkinshopTotal] --;
		if(skinshopData[skinshopid][SkinshopTotal] == 0)
			return SKINSHOP_Delete(skinshopid);
	}
	return 1;
}

