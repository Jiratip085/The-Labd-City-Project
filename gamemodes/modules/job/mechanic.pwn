#include <YSI\y_hooks>

//Mechanic
CMD:buycomp(playerid, params[], productid)
{
	new
	    id = Product_Nearest(playerid),
	    string[128],
	    yesstring[16];

	if (id == -1)
	    	return SendClientMessage(playerid, COLOR_GREY, "�س���������ش buycomp!");

    if(ProductData[id][productType] == 3)
	{
		new amount;

		if (Character[playerid][Job] != 2)
		    return SendClientMessage(playerid, -1, "�ҹ�ͧ�س����������觹��");

		new vehicleid = GetPlayerVehicleID(playerid);

		if (GetVehicleModel(vehicleid) != 525)
			return SendClientMessage(playerid, -1, "�س��������躹 Towtruck");

		if (sscanf(params, "dS()[16]", amount, string))
		{
			SendClientMessage(playerid, -1, "/buycomp [amount]");
			SendClientMessage(playerid, -1, "�س�١�ӡѴ����� 1-2,000");
			SendClientMessage(playerid, -1, "!! 㹪����ǹ�����ѧ���ռ�Ե�ѳ�� 25 ��� !!");
			return 1;
		}

		if(amount < 1 || amount > 2000)
		    return SendClientMessage(playerid, -1, "�ӹǹ���١��ͧ");

        if(ProductData[id][productAmount] <= 0)
	        return SendClientMessage(playerid, -1, "�Թ��Ҫ�Դ�����������������ö������");

        if (sscanf(string, "s[16]", yesstring))
	    {
	        format(string, sizeof(string), "�Ҥ� : %s", FormatNumber(amount*ProductData[id][productPrice]));
  			SendClientMessage(playerid, COLOR_WHITE, string);

			format(string, sizeof(string), "/buycomp %d yes", amount);
  			SendClientMessage(playerid, COLOR_WHITE, string);
  			return 1;
		}


		if(Character[playerid][Cash] <  amount*ProductData[id][productPrice])
  			return SendClientMessage(playerid, -1, "�س���Թ���ͷ��Ы���");

        ProductData[id][productAmount] -= amount;
        Product_Refresh(id);

		GiveMoney(playerid, -amount*ProductData[id][productPrice], "buy comp");
		CoreVehicles[vehicleid][vehComponent] += amount*25;


        format(string, sizeof(string), "�س���ͪ����ǹ %d �����Ҥ� %s", amount, FormatNumber(amount*ProductData[id][productPrice]));
  		SendClientMessage(playerid, COLOR_WHITE, string);
	}
	else SendClientMessage(playerid, -1, "�س��ͧ�����觹��Ѻ�ش buycomp ��ҹ��!");
	return 1;
}

CMD:checkcomponents(playerid, params[])
{
	new
		vehicleid = GetPlayerVehicleID(playerid),
		string[128];

	if (GetVehicleModel(vehicleid) != 525)
		return SendClientMessage(playerid, -1, "�س��������躹 Towtruck");

	if (CoreVehicles[vehicleid][vehComponent] < 1)
	    return SendClientMessage(playerid, -1, "����ռ�Ե�ѳ��������ҹ��˹й��");


    format(string, sizeof(string), "�ҹ��˹й���ռ�Ե�ѳ������ %d", CoreVehicles[vehicleid][vehComponent]);
	SendClientMessage(playerid, COLOR_WHITE, string);
	return 1;
}

CMD:service(playerid, params[])
{
	new
		userid, type, yesstring[16], string[128], carid, pcarid, price;

    if (Character[playerid][Job] != 2)
	    return SendClientMessage(playerid, -1, "�ҹ�ͧ�س����������觹��");

    new vehicleid = GetPlayerVehicleID(playerid);

	if (GetVehicleModel(vehicleid) != 525)
		return SendClientMessage(playerid, -1, "�س��������躹 Towtruck");

	if (CoreVehicles[vehicleid][vehComponent] < 1)
	    return SendClientMessage(playerid, -1, "����ռ�Ե�ѳ��������ҹ��˹й��");

	if (sscanf(params, "uddS()[16]", userid, price, type, string))
	{
		SendClientMessage(playerid, -1, "/service [playerid/name] [price] [Type]");
		SendClientMessage(playerid, COLOR_GRAD1, "Type 1:{FFFFFF} ��ԡ���������ʹö");
		SendClientMessage(playerid, COLOR_GRAD1, "Type 2:{FFFFFF} ������Ƕѧ (( ����������·���ͧ��� ))");
		SendClientMessage(playerid, COLOR_GRAD1, "Type 3:{FFFFFF} ����ẵ�����");
		SendClientMessage(playerid, COLOR_GRAD1, "Type 4:{FFFFFF} ��鹿�����ͧ¹��");
		return 1;
	}

	if(price < 0)
	    return SendClientMessage(playerid, -1, "�Ҥҷ���к����١��ͧ !");

	if(userid == playerid)
		return SendClientMessage(playerid, -1, "�س�������ö�ʹͺ�ԡ�����Ѻ����ͧ��!");

	if(!IsPlayerConnectedEx(userid))
	    return SendClientMessage(playerid, -1, "�����蹹��������������͡Ѻ�Կ�����");

	if (!IsPlayerNearPlayer(playerid, userid, 10.0))
	   return SendClientMessage(playerid, -1, "�����蹹�鹵Ѵ���������������������������س");

	if (!IsPlayerInAnyVehicle(userid))
        return SendClientMessage(playerid, -1, "�����蹹����������躹ö");

	pcarid = Car_GetID(GetPlayerVehicleID(userid));

	carid = Car_GetID(GetPlayerVehicleID(playerid));

	if(pcarid == -1)
	    return SendClientMessage(playerid, -1, " �����蹹����������躹ö");

	if(type >= 1 && type <= 4)
	{
		new fixname[64];
		switch(type)
		{
		    case 1: format(fixname, sizeof(fixname), "��������ͧ¹��");
		    case 2: format(fixname, sizeof(fixname), "������Ƕѧ");
		    case 3: format(fixname, sizeof(fixname), "����ẵ�����");
		    case 4: format(fixname, sizeof(fixname), "��鹿�����ͧ¹��");
		}

	    if (sscanf(string, "s[16]", yesstring))
	        return SendClientMessage(playerid, -1, "��س��׹�ѹ��ԡ�âͧ�س�� 'yes' ��ͷ���");

		Character[userid][MecOffer] = playerid;
		Character[playerid][MecType]= type;
		Character[playerid][MecCar] = CarData[pcarid][carVehicle];
		Character[playerid][MecTow] = CarData[carid][carVehicle];
		Character[playerid][MecStep] = 0;
		Character[playerid][MecPrice] = price;


		SendNearbyMessage(playerid, 20.0, COLOR_RP, "* %s ���ʹͷ���%s %s �ͧ %s", ReturnName(playerid, 0), fixname, ReturnVehicleName(CarData[pcarid][carVehicle]), ReturnName(userid, 0));
		format(string, sizeof(string), "* %s ��ͧ���%s %s �ͧ�س��Ҥ� %s (�� \"/approve mechanic\" ��������Ѻ)" , ReturnName(playerid, 0), fixname, ReturnVehicleName(CarData[pcarid][carVehicle]), FormatNumber(price));
		SendClientMessage(userid, COLOR_WHITE, string);

	}
	else return SendClientMessage(playerid, -1, "��ԡ�÷������ 1-4 ��ҹ��");
	return 1;
}
