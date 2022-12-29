#include <YSI\y_hooks>

enum productData {
	productID,
	productExists,
	productType,
	productAmount,
	productPointPrice,
	productPointAmount,
	productPrice,
	Float:productPos[3],
	productInterior,
	productWorld,
	productPickups[3],
	Text3D:productText3D[3],
	Float:productPoint[3],
	productPointInt,
	productPointWorld
};
new ProductData[MAX_DYNAMIC_PRODUCTS][productData],Total_Products_Created;

Product_Nearest(playerid)
{
    for (new i = 0; i != MAX_DYNAMIC_PRODUCTS; i ++) if (ProductData[i][productExists] && IsPlayerInRangeOfPoint(playerid, 2.5, ProductData[i][productPos][0], ProductData[i][productPos][1], ProductData[i][productPos][2]))
	{
		if (GetPlayerInterior(playerid) == ProductData[i][productInterior] && GetPlayerVirtualWorld(playerid) == ProductData[i][productWorld])
			return i;
	}
	return -1;
}

ProductPoint_Nearest(playerid)
{
    for (new i = 0; i != MAX_DYNAMIC_PRODUCTS; i ++) if (ProductData[i][productExists] && IsPlayerInRangeOfPoint(playerid, 2.5, ProductData[i][productPoint][0], ProductData[i][productPoint][1], ProductData[i][productPoint][2]))
	{
		if (GetPlayerInterior(playerid) == ProductData[i][productPointInt] && GetPlayerVirtualWorld(playerid) == ProductData[i][productPointWorld])
			return i;
	}
	return -1;
}

Product_MaxGrams(type)
{
	new grams;

	switch (type)
	{
	    case 1: grams = 100;
		case 2: grams = 100; //
		case 3: grams = 10000; //
		default: grams = 0;
	}
	return grams;
}

forward Product_Load();
public Product_Load()
{
	new
	    rows;

	cache_get_row_count(rows);

    for (new i = 0; i < rows; i ++) if (i < MAX_DYNAMIC_PRODUCTS)
	{
	    ProductData[i][productExists] = true;

	    cache_get_value_name_int(i, "productID", ProductData[i][productID]);
	    cache_get_value_name_int(i, "productType", ProductData[i][productType]);
	    cache_get_value_name_int(i, "productAmount", ProductData[i][productAmount]);
	    cache_get_value_name_int(i, "productPrice", ProductData[i][productPrice]);
	    cache_get_value_name_int(i, "productPointAmount", ProductData[i][productPointAmount]);
	    cache_get_value_name_int(i, "productPointPrice", ProductData[i][productPointPrice]);
	    cache_get_value_name_float(i, "productPosX", ProductData[i][productPos][0]);
	    cache_get_value_name_float(i, "productPosY", ProductData[i][productPos][1]);
	    cache_get_value_name_float(i, "productPosZ", ProductData[i][productPos][2]);
	    cache_get_value_name_int(i, "productInterior", ProductData[i][productInterior]);
	    cache_get_value_name_int(i, "productWorld", ProductData[i][productWorld]);
	    cache_get_value_name_float(i, "productPointX", ProductData[i][productPoint][0]);
	    cache_get_value_name_float(i, "productPointY", ProductData[i][productPoint][1]);
	    cache_get_value_name_float(i, "productPointZ", ProductData[i][productPoint][2]);
	    cache_get_value_name_int(i, "productPointInt", ProductData[i][productPointInt]);
	    cache_get_value_name_int(i, "productPointWorld", ProductData[i][productPointWorld]);

        Total_Products_Created++;

 	    Product_Refresh(i);

	}
	printf("[MYSQL]: %d Products have been successfully loaded from the database.", Total_Products_Created);
	return 1;
}

Product_Create(playerid, type)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	if (GetPlayerPos(playerid, x, y, z))
	{
		for (new i = 0; i != MAX_DYNAMIC_PRODUCTS; i ++)
		{
	    	if (!ProductData[i][productExists])
	    	{
	        	ProductData[i][productExists] = true;
	        	ProductData[i][productType] = type;
	        	ProductData[i][productAmount] = 100;
	        	ProductData[i][productPrice] = 0;
	        	ProductData[i][productPointAmount] = 100;
	        	ProductData[i][productPointPrice] = 0;

				ProductData[i][productPos][0] = x;
	        	ProductData[i][productPos][1] = y;
	        	ProductData[i][productPos][2] = z;
	        	ProductData[i][productPoint][0] = 0.0;
	        	ProductData[i][productPoint][1] = 0.0;
	        	ProductData[i][productPoint][2] = 0.0;

	        	ProductData[i][productPointInt] = 0;
                ProductData[i][productPointWorld] = 0;

	        	ProductData[i][productInterior] = GetPlayerInterior(playerid);
	        	ProductData[i][productWorld] = GetPlayerVirtualWorld(playerid);

	        	Product_Refresh(i);
	        	mysql_tquery(dbCon, "INSERT INTO `products` (`productInterior`) VALUES(0)", "OnProductCreated", "d", i);

	        	return i;
	        }
	    }
	}
	return -1;
}

forward OnProductCreated(productid);
public OnProductCreated(productid)
{
	if (productid == -1 || !ProductData[productid][productExists])
	    return 0;

	ProductData[productid][productID] = cache_insert_id();
	Product_Save(productid);

	return 1;
}

Product_Save(productid)
{
	new
	    query[512];

	format(query, sizeof(query), "UPDATE `products` SET `productType` = '%d', `productAmount` = '%d', `productPrice` = '%d', `productPointAmount` = '%d', `productPointPrice` = '%d', `productPosX` = '%.4f', `productPosY` = '%.4f', `productPosZ` = '%.4f', `productInterior` = '%d', `productWorld` = '%d', `productPointX` = '%.4f', `productPointY` = '%.4f', `productPointZ` = '%.4f', `productPointInt` = '%d', `productPointWorld` = '%d' WHERE `productID` = '%d'",
        ProductData[productid][productType],
        ProductData[productid][productAmount],
        ProductData[productid][productPrice],
        ProductData[productid][productPointAmount],
        ProductData[productid][productPointPrice],
		ProductData[productid][productPos][0],
	    ProductData[productid][productPos][1],
	    ProductData[productid][productPos][2],
	    ProductData[productid][productInterior],
	    ProductData[productid][productWorld],
	    ProductData[productid][productPoint][0],
	    ProductData[productid][productPoint][1],
	    ProductData[productid][productPoint][2],
	    ProductData[productid][productPointInt],
	    ProductData[productid][productPointWorld],
	    ProductData[productid][productID]
	);
	return mysql_tquery(dbCon, query);
}

Product_Refresh(productid)
{
	if (productid != -1 && ProductData[productid][productExists])
	{
	    for (new i = 0; i < 3; i ++) {
			if (IsValidDynamic3DTextLabel(ProductData[productid][productText3D][i]))
		    	DestroyDynamic3DTextLabel(ProductData[productid][productText3D][i]);

			if (IsValidDynamicPickup(ProductData[productid][productPickups][i]))
		    	DestroyDynamicPickup(ProductData[productid][productPickups][i]);
		}
		new
		    string[90];

        if (ProductData[productid][productType] == 1)
		{
			format(string, sizeof(string), "[%s]\nความจุโกดัง: %d / %d\nราคา: $%d / หน่วย", Product_GetName(ProductData[productid][productType]), ProductData[productid][productAmount], Product_MaxGrams(ProductData[productid][productType]), ProductData[productid][productPrice]);
			ProductData[productid][productText3D][0] = CreateDynamic3DTextLabel(string, COLOR_WHITE, ProductData[productid][productPos][0], ProductData[productid][productPos][1], ProductData[productid][productPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, ProductData[productid][productWorld], ProductData[productid][productInterior]);
		    ProductData[productid][productPickups][0] = CreateDynamicPickup(1318, 23, ProductData[productid][productPos][0], ProductData[productid][productPos][1], ProductData[productid][productPos][2], ProductData[productid][productWorld], ProductData[productid][productInterior]);

		    format(string, sizeof(string), "[%s]\nความจุโกดัง: %d / %d\nราคา: $%d / หน่วย", Product_GetName(ProductData[productid][productType]), ProductData[productid][productPointAmount], Product_MaxGrams(ProductData[productid][productType]), ProductData[productid][productPointPrice]);
		    ProductData[productid][productText3D][1] = CreateDynamic3DTextLabel(string, COLOR_WHITE, ProductData[productid][productPoint][0], ProductData[productid][productPoint][1], ProductData[productid][productPoint][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, ProductData[productid][productPointWorld], ProductData[productid][productPointInt]);
			ProductData[productid][productPickups][1] = CreateDynamicPickup(1318, 23, ProductData[productid][productPoint][0], ProductData[productid][productPoint][1], ProductData[productid][productPoint][2], ProductData[productid][productPointWorld], ProductData[productid][productPointInt]);
		}
		if (ProductData[productid][productType] == 2)
		{
			format(string, sizeof(string), "[%s]\nความจุโกดัง: %d / %d\nราคา: $%d / หน่วย", Product_GetName(ProductData[productid][productType]), ProductData[productid][productAmount], Product_MaxGrams(ProductData[productid][productType]), ProductData[productid][productPrice]);
			ProductData[productid][productText3D][0] = CreateDynamic3DTextLabel(string, COLOR_WHITE, ProductData[productid][productPos][0], ProductData[productid][productPos][1], ProductData[productid][productPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, ProductData[productid][productWorld], ProductData[productid][productInterior]);
		    ProductData[productid][productPickups][0] = CreateDynamicPickup(1318, 23, ProductData[productid][productPos][0], ProductData[productid][productPos][1], ProductData[productid][productPos][2], ProductData[productid][productWorld], ProductData[productid][productInterior]);

            format(string, sizeof(string), "[%s]\nความจุโกดัง: %d / %d\nราคา: $%d / หน่วย", Product_GetName(ProductData[productid][productType]), ProductData[productid][productPointAmount], Product_MaxGrams(ProductData[productid][productType]), ProductData[productid][productPointPrice]);
		    ProductData[productid][productText3D][1] = CreateDynamic3DTextLabel(string, COLOR_WHITE, ProductData[productid][productPoint][0], ProductData[productid][productPoint][1], ProductData[productid][productPoint][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, ProductData[productid][productPointWorld], ProductData[productid][productPointInt]);
			ProductData[productid][productPickups][1] = CreateDynamicPickup(1318, 23, ProductData[productid][productPoint][0], ProductData[productid][productPoint][1], ProductData[productid][productPoint][2], ProductData[productid][productPointWorld], ProductData[productid][productPointInt]);
		}
		if (ProductData[productid][productType] == 3)
		{
			format(string, sizeof(string), "[%s]\nความจุโกดัง: %d / %d\nราคา: $%d / หน่วย", Product_GetName(ProductData[productid][productType]), ProductData[productid][productAmount], Product_MaxGrams(ProductData[productid][productType]), ProductData[productid][productPrice]);
			ProductData[productid][productText3D][0] = CreateDynamic3DTextLabel(string, COLOR_WHITE, ProductData[productid][productPos][0], ProductData[productid][productPos][1], ProductData[productid][productPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, ProductData[productid][productWorld], ProductData[productid][productInterior]);
		    ProductData[productid][productPickups][0] = CreateDynamicPickup(1318, 23, ProductData[productid][productPos][0], ProductData[productid][productPos][1], ProductData[productid][productPos][2], ProductData[productid][productWorld], ProductData[productid][productInterior]);

            /*format(string, sizeof(string), "[%s]\nความจุโกดัง: %d / %d\nราคา: $%d / หน่วย", Product_GetName(ProductData[productid][productType]), ProductData[productid][productPointAmount], Product_MaxGrams(ProductData[productid][productType]), ProductData[productid][productPointPrice]);
		    ProductData[productid][productText3D][1] = CreateDynamic3DTextLabel(string, COLOR_WHITE, ProductData[productid][productPoint][0], ProductData[productid][productPoint][1], ProductData[productid][productPoint][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, ProductData[productid][productPointWorld], ProductData[productid][productPointInt]);
			ProductData[productid][productPickups][1] = CreateDynamicPickup(1318, 23, ProductData[productid][productPoint][0], ProductData[productid][productPoint][1], ProductData[productid][productPoint][2], ProductData[productid][productPointWorld], ProductData[productid][productPointInt]);*/
		}
	}
	return 1;
}

Product_GetName(type)
{
	new
	    str[24];

	switch (type)
	{
	    case 1: str = "เนื้อสัตว์";
	    case 2: str = "เครื่องดื่ม";
	    case 3: str = "ส่วนประกอบรถยนต์"; // ใช้ /buycomp
	    default: str = "ไม่มี";
	}
	return str;
}

Product_Delete(productid)
{
	if (productid != -1 && ProductData[productid][productExists])
	{
	    new
	        string[64];

        Total_Products_Created--;

		format(string, sizeof(string), "DELETE FROM `products` WHERE `productID` = '%d'", ProductData[productid][productID]);
		mysql_tquery(dbCon, string);

        for (new i = 0; i < 3; i ++) {
			if (IsValidDynamic3DTextLabel(ProductData[productid][productText3D][i]))
		    	DestroyDynamic3DTextLabel(ProductData[productid][productText3D][i]);

			if (IsValidDynamicPickup(ProductData[productid][productPickups][i]))
		    	DestroyDynamicPickup(ProductData[productid][productPickups][i]);
		}
		ProductData[productid][productExists] = false;
		ProductData[productid][productType] = 0;
	    ProductData[productid][productID] = 0;
	}
	return 1;
}

//productcmds
CMD:createproduct(playerid, params[])
{
	new
		id = -1,
		type,
		string[128];

	if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "d", type))
	    return SendClientMessage(playerid, -1, "/createproduct [type]");

    /*if (type < 1 || type > MAX_DYNAMIC_PRODUCTS)
    {
        format(string, sizeof(string), "ประเภทที่ระบุไม่ถูกต้องต้องอยู่ในระหว่าง 1 ถึง %d", 25);
		SendClientMessage(playerid, -1, string);
		return 1;
	}*/

	if (type < 1 || type > 3)
    {
        format(string, sizeof(string), "ประเภทที่ระบุไม่ถูกต้องต้องอยู่ในระหว่าง 1 ถึง %d", 3);
		SendClientMessage(playerid, -1, string);
		return 1;
	}

	id = Product_Create(playerid, type);

	if (id == -1)
	    return SendClientMessage(playerid, -1, "เซิฟเวอร์นี้ได้สร้างคลังสินค้าเกินขีดจำกัดแล้ว");

    format(string, sizeof(string), "คุณประสบความสำเร็จสร้างคลังสินค้าไอดี: %d", id);
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:editproduct(playerid, params[])
{
	new
	    id,
	    type[24],
	    string[128];

	if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendClientMessage(playerid, -1, "/editproduct [id] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, type, amount, price, point, pointamount, pointprice");
		return 1;
	}
	if ((id < 0 || id >= MAX_DYNAMIC_PRODUCTS) || !ProductData[id][productExists])
	    return SendClientMessage(playerid, -1, "คุณระบุไอดีคลังสินค้าไม่ถูกต้อง");

	if (!strcmp(type, "location", true))
	{
	    new
	        Float:x,
	        Float:y,
	        Float:z;

	    GetPlayerPos(playerid, x, y, z);

		ProductData[id][productPos][0] = x;
		ProductData[id][productPos][1] = y;
		ProductData[id][productPos][2] = z;

		ProductData[id][productInterior] = GetPlayerInterior(playerid);
		ProductData[id][productWorld] = GetPlayerVirtualWorld(playerid);

		Product_Refresh(id);
		Product_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับตำแหน่งของคลังสินค้าไอดี: %d", ReturnRealName(playerid, 0), id);
	}
	else if (!strcmp(type, "type", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
	        return SendClientMessage(playerid, -1, "/editproduct [id] [type] [new type]");

        if (typeint < 1 || typeint > 19)
	    	return SendClientMessage(playerid, -1, "ประเภทที่ระบุต้องอยู่ระหว่าง 1 ถึง 19");

	    ProductData[id][productType] = typeint;

	    Product_Refresh(id);
	    Product_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับประเภทของคลังสินค้าไอดี: %d เป็น %d", ReturnRealName(playerid, 0), id, ProductData[id][productType]);
	}
	else if (!strcmp(type, "point", true))
	{
	    new
	        Float:x,
	        Float:y,
	        Float:z;

	    GetPlayerPos(playerid, x, y, z);

		ProductData[id][productPoint][0] = x;
		ProductData[id][productPoint][1] = y;
		ProductData[id][productPoint][2] = z;
        ProductData[id][productPointInt] = GetPlayerInterior(playerid);
        ProductData[id][productPointWorld] = GetPlayerVirtualWorld(playerid);

		Product_Refresh(id);
		Product_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับตำแหน่งของงานไอดี: %d", ReturnRealName(playerid, 0), id);
	}
	else if (!strcmp(type, "pointamount", true))
	{
	    new amountint;

	    if (sscanf(string, "d", amountint))
	        return SendClientMessage(playerid, -1, "/editproduct [id] [amount] [amount pointamount]");

        if (amountint < 0 || amountint > 100)
	    	return SendClientMessage(playerid, -1, "ประเภทที่ระบุต้องอยู่ระหว่าง 0 ถึง 100");

	    ProductData[id][productPointAmount] = amountint;

	    Product_Refresh(id);
	    Product_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับจำนวนสินค้าในคลังสินค้า[Point] ไอดี: %d เป็น %d", ReturnRealName(playerid, 0), id, ProductData[id][productAmount]);
	}
	else if (!strcmp(type, "pointprice", true))
	{
	    new pricetint;

	    if (sscanf(string, "d", pricetint))
	        return SendClientMessage(playerid, -1, "/editproduct [id] [price] [price pointprice]");

        if (pricetint < 1)
	    	return SendClientMessage(playerid, -1, "ประเภทที่ระบุต้องอยู่ระหว่าง 1 ขึ้นไป");

	    ProductData[id][productPointPrice] = pricetint;

	    Product_Refresh(id);
	    Product_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับราคาสินค้าในคลังสินค้า[Point] ไอดี: %d เป็น %d", ReturnRealName(playerid, 0), id, ProductData[id][productPrice]);
	}
	else if (!strcmp(type, "amount", true))
	{
	    new amountint;

	    if (sscanf(string, "d", amountint))
	        return SendClientMessage(playerid, -1, "/editproduct [id] [amount] [amount product]");

        if (amountint < 0 || amountint > 10000)
	    	return SendClientMessage(playerid, -1, "ประเภทที่ระบุต้องอยู่ระหว่าง 0 ถึง 10000");

	    ProductData[id][productAmount] = amountint;

	    Product_Refresh(id);
	    Product_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับจำนวนสินค้าในคลังสินค้าไอดี: %d เป็น %d", ReturnRealName(playerid, 0), id, ProductData[id][productAmount]);
	}
	else if (!strcmp(type, "price", true))
	{
	    new pricetint;

	    if (sscanf(string, "d", pricetint))
	        return SendClientMessage(playerid, -1, "/editproduct [id] [price] [price ammount]");

        if (pricetint < 1)
	    	return SendClientMessage(playerid, -1, "ประเภทที่ระบุต้องอยู่ระหว่าง 1 ขึ้นไป");

	    ProductData[id][productPrice] = pricetint;

	    Product_Refresh(id);
	    Product_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s ได้ปรับราคาสินค้าในคลังสินค้าไอดี: %d เป็น %d", ReturnRealName(playerid, 0), id, ProductData[id][productPrice]);
	}
	return 1;
}

CMD:destroyproduct(playerid, params[])
{
	new
	    id = 0,
	    string[128];

    if (Account[playerid][Admin] < 1338)
	    return SendClientMessage(playerid, -1, "คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");

	if (sscanf(params, "d", id))
	    return SendClientMessage(playerid, -1, "/destroyproduct [product id]");

	if ((id < 0 || id >= MAX_DYNAMIC_PRODUCTS) || !ProductData[id][productExists])
	    return SendClientMessage(playerid, -1, "คุณระบุไอดีคลังสินค้าผิดพลาด");

	Product_Delete(id);
	format(string, sizeof(string), "คุณประสบความสำเร็จในการทำลายคลังสินค้าไอดี: %d", id);
	SendClientMessage(playerid, -1, string);
	return 1;
}
