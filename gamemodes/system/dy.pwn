#include 	<YSI_Coding\y_hooks>

#define bug_id -1
#define MAX_OBJECTX2 2000

new EditNpc[MAX_PLAYERS];

new Loop = 0;
new DialogAdmin = 10;

enum ob_info
{
	Exits,
 	ObjectModel,
	Float:ObjectPos[3],
	Float:ObjectRot[3],
	ObjectWolrd,
	ObjectC,
	Textrueindex,
	TextrueModel,
	Textrue_Name1[64],
	Textrue_Name2[64],
	Textrue_Color,
}
new ObjectInfo[MAX_OBJECTX2][ob_info];

CMD:objectcmds(playerid, params[])
{
	if(playerData[playerid][pAdmin] <= 4) 
		return 1;

	SendClientMessage(playerid, 0xffffffff, "|___________ Dynamics Object ___________|");
	SendClientMessage(playerid, 0xffffffff, "/cobject(สร้าง) /dobject(ลบ) /editobject(ปรับแต่ง)");
	ShowMenuSettingObjectDynamic(playerid);
	return 1;
}
CMD:editObject(playerid, params[])
{
	if(playerData[playerid][pAdmin] <= 4) 
		return 1;

	SendClientMessage(playerid, 0xffffffff, "|___________ Dynamics Object ___________|");
	SendClientMessage(playerid, 0xffffffff, "/cobject(สร้าง) /dobject(ลบ) /editobject(ปรับแต่ง)");
	ShowMenuSettingObjectDynamic(playerid);
	return 1;
}

CMD:cobject(playerid, params[])
{
	if(playerData[playerid][pAdmin] <= 4) 
		return 1;

    new car, string[128];

	if (sscanf(params, "d", car))
	    return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /cobject [Model]");

	new Float:x,Float:y,Float:z;
	
	GetPlayerVirtualWorld(playerid);
	GetPlayerPos(playerid, x,y,z);
	
	for(new i = 1; i < MAX_OBJECTX2; i++)
	{
		if(!ObjectInfo[i][Exits])
		{
		    ObjectInfo[i][Exits] = true;
		    ObjectInfo[i][ObjectModel] = car;
	    	ObjectInfo[i][ObjectPos][0] = x;
	    	ObjectInfo[i][ObjectPos][1] = y;
	    	ObjectInfo[i][ObjectPos][2] = z;
	    	ObjectInfo[i][ObjectRot][0] = 0.0;
	    	ObjectInfo[i][ObjectRot][1] = 0.0;
	    	ObjectInfo[i][ObjectRot][2] = 0.0;
	    	EditNpc[playerid] = i;
	    	ObjectInfo[i][ObjectWolrd] = GetPlayerVirtualWorld(playerid);
			ObjectInfo[i][ObjectC] = CreateObject(car,x,y+2,z,0.0,0.0,0.0,ObjectInfo[i][ObjectWolrd]);
			EditObject(playerid,ObjectInfo[i][ObjectC]);
			format(string, sizeof(string), "Object {ffff00}(%d) {ffffff}ถูกสร้างแล้วกรุณาปรับแต่งเป้าหมายที่ต้องการ", i);
			SendClientMessage(playerid, COLOR_GREY, string);
			new query[512];
			mysql_format(g_SQL, query, sizeof(query), "INSERT INTO  objectt SET ID=%d,ObjectModel='%d', ObjectPosX='%f', ObjectPosY='%f', ObjectPosZ='%f',ObjectPosRX='%f',ObjectPosRY='%f',ObjectPosRZ='%f',ObjectWolrd='%d'",i,car,x,y+2,z,0.0,0.0,0.0,ObjectInfo[i][ObjectWolrd]);
			mysql_tquery(g_SQL, query, "", "");
			return 1;
		}
	}

	return 1;
}

CMD:dobject(playerid, params[])
{
    new car;
	if(playerData[playerid][pAdmin] <= 4) 
		return 1;

	if (sscanf(params, "d", car))
	    return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /dobject [ไอดี]");

	if(!ObjectInfo[car][Exits])
	{
 		SendClientMessage(playerid, 0xffffffff, "ไม่พบไอดีนี้ในฐานข้อมูล");
   		return 1;
	}
			
	ObjectInfo[car][ObjectModel] = 0;
	ObjectInfo[car][ObjectPos][0] = 0.0;
	ObjectInfo[car][ObjectPos][1] = 0.0;
	ObjectInfo[car][ObjectPos][2] = 0.0;
	ObjectInfo[car][ObjectRot][0] = 0.0;
	ObjectInfo[car][ObjectRot][1] = 0.0;
	ObjectInfo[car][ObjectRot][2] = 0.0;

	new query[64], string[128];

	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM objectt WHERE ID=%d", car);
	mysql_tquery(g_SQL, query, "", "");

	ObjectInfo[car][Exits] = false;
	DestroyObject(ObjectInfo[car][ObjectC]);

	format(string, sizeof(string), "Object ไอดี{ffff00}(%d) {ffffff}ถูกลบแ้ลว", car);
	SendClientMessage(playerid, COLOR_GREY, string);

	return 1;
}
/*
CMD:editobject(playerid, params[])
{
	new car, string[128];

	if (sscanf(params, "d", car))
	    return SendClientMessage(playerid, COLOR_GREY, "การใช้งาน : /editobject [ไอดี]");

	if(!ObjectInfo[car][Exits])
	{
		SendClientMessage(playerid, 0xffffffff, "ไม่พบไอดีนี้ในฐานข้อมูล");
		return 1;
	}
	
	EditNpc[playerid] = car;
	EditObject(playerid,ObjectInfo[EditNpc[playerid]][ObjectC]);
	format(string, sizeof(string), "Object {ffff00}(%d) {ffffff}กำลังถูกปรับแต่งกด SPACBAR เพื่อปรับมุมกล้อง", car);
	SendClientMessage(playerid, COLOR_GREY, string);

	return 1;
}*/

CMD:checkid(playerid, params[])
{
    new string[128];
	if(playerData[playerid][pAdmin] <= 4) 
		return 1;
		
	for(new i = 1; i < MAX_OBJECTX2; i++)
	{
		if(PlayerToPoint(1.0,playerid,ObjectInfo[i][ObjectPos][0],ObjectInfo[i][ObjectPos][1],ObjectInfo[i][ObjectPos][2]))
		{
			format(string, sizeof(string), "Dynamics Object : ไอดี (%d)", i);
			SendClientMessage(playerid, COLOR_GREY, string);
			return 1;
		}
	}

	return 1;
}

hook OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	switch(response)
	{
	    case EDIT_RESPONSE_CANCEL:
	    {
	        new id = EditNpc[playerid];
	        SetObjectPos(objectid, ObjectInfo[id][ObjectPos][0],ObjectInfo[id][ObjectPos][1],ObjectInfo[id][ObjectPos][2]);
	        SetObjectRot(objectid, ObjectInfo[id][ObjectRot][0],ObjectInfo[id][ObjectRot][1],ObjectInfo[id][ObjectRot][2]);
            SendClientMessage(playerid, 0xffff00ff, "Dynamics Object {ffffff}: การปรับแต่งถูกยกเลิก");
		}
		case EDIT_RESPONSE_FINAL:
		{
		    new id = EditNpc[playerid];
		    ObjectInfo[id][ObjectPos][0] = fX;
	    	ObjectInfo[id][ObjectPos][1] = fY;
	    	ObjectInfo[id][ObjectPos][2] = fZ;
	    	ObjectInfo[id][ObjectRot][0] = fRotX;
	    	ObjectInfo[id][ObjectRot][1] = fRotY;
	    	ObjectInfo[id][ObjectRot][2] = fRotZ;
		    Save_Object(id);
            SetObjectPos(objectid, ObjectInfo[id][ObjectPos][0],ObjectInfo[id][ObjectPos][1],ObjectInfo[id][ObjectPos][2]);
	        SetObjectRot(objectid, ObjectInfo[id][ObjectRot][0],ObjectInfo[id][ObjectRot][1],ObjectInfo[id][ObjectRot][2]);
            SendClientMessage(playerid, 0x00ff00ff, "Dynamics Object {ffffff}: คุณปรับแต่งเรียบร้อย");
		}
	}

	return 1;
}

forward ShowMenuObjectDynamic(playerid);
public ShowMenuObjectDynamic(playerid)
{
    new string100[512];
	new string2[512];
	EditNpc[playerid] = bug_id;
	if(DialogAdmin < 11)
	{
		format(string100, 256, "แก้ไข Object\n");
		strcat(string2, string100, sizeof(string2));

	 	for(new i = Loop+1 ; i < DialogAdmin; i++ )
		{
			format(string100, 256, "%d | Model %d\n",i,ObjectInfo[i][ObjectModel]);
			strcat(string2, string100, sizeof(string2));
		}
	}
	else
	{
	    for(new i = Loop ; i < DialogAdmin; i++ )
		{
			format(string100, 256, "%d | Model %d\n",i,ObjectInfo[i][ObjectModel]);
			strcat(string2, string100, sizeof(string2));
		}
	}
	
	format(string100, 256, "หน้าต่อไป\n");
	strcat(string2, string100, sizeof(string2));
	format(string100, 256, "กลับ <<\n");
	strcat(string2, string100, sizeof(string2));
	Dialog_Show(playerid, DIALOG_OBJECT_ONE, DIALOG_STYLE_LIST, "จัดการ Object", string2, "ตกลง","ยกเลิก");
	return 1;
}

Dialog:DIALOG_OBJECT_ONE(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
	    return 1;
	}
	if(strfind(inputtext,"แก้ไข Object",true)!= -1)
	{
		ShowMenuObjectDynamic(playerid);
		return 1;
	}
	if(strfind(inputtext,"หน้าต่อไป",true)!= -1)
	{
		DialogAdmin += 10;
		Loop += 10;
		ShowMenuObjectDynamic(playerid);
		return 1;
	}
	if(strfind(inputtext,"กลับ",true)!= -1)
	{
	    if(DialogAdmin > 10)
	    {
			DialogAdmin -= 10;
			Loop -= 10;
			ShowMenuObjectDynamic(playerid);
			return 1;
		}
		else
		{
		    DialogAdmin = 10;
			Loop = 0;
			ShowMenuObjectDynamic(playerid);
			return 1;
		}
	}
	EditNpc[playerid] = listitem+Loop;
	ShowMenuSettingObjectDynamic(playerid);
	return 1;
}

forward ShowMenuSettingObjectDynamic(playerid);
public ShowMenuSettingObjectDynamic(playerid)
{
    new string100[512];
	new string2[512];
	format(string100, 256, "เปลี่ยน ModelObject\n");
	strcat(string2, string100, sizeof(string2));
	format(string100, 256, "ปรับแต่ง Object\n");
	strcat(string2, string100, sizeof(string2));
	format(string100, 256, "ลบ Object\n");
	strcat(string2, string100, sizeof(string2));
	format(string100, 256, "Create Duplicate\n");
	strcat(string2, string100, sizeof(string2));
	Dialog_Show(playerid, DIALOG_OBJECT_TWO, DIALOG_STYLE_LIST, "จัดการ Object", string2, "Okay","Cancle");
	return 1;
}

Dialog:DIALOG_OBJECT_THREE(playerid, response, listitem, inputtext[])
{
	new string[128];
	if(!response)
	{
	    return 1;
	}
	new id = EditNpc[playerid];
	if(ObjectInfo[EditNpc[playerid]][ObjectModel] == 0)
	{
		SendClientMessage(playerid, COLOR_GREY,"ยังไม่ถูกสร้างขึ้น !! กรุณาสร้างก่อนครับก่อนปรับแต่ง !!");
		return 1;
	}
	ObjectInfo[id][ObjectModel] = strval(inputtext);
	Save_Object(id);
	DestroyObject(ObjectInfo[EditNpc[playerid]][ObjectC]);
	ObjectInfo[id][ObjectC] = CreateObject(ObjectInfo[id][ObjectModel],ObjectInfo[id][ObjectPos][0],ObjectInfo[id][ObjectPos][1],ObjectInfo[EditNpc[playerid]][ObjectPos][2],ObjectInfo[id][ObjectRot][0],ObjectInfo[id][ObjectRot][1],ObjectInfo[id][ObjectRot][2],ObjectInfo[id][ObjectWolrd]);
	format(string, sizeof(string), "Object {ffff00}(%d) {ffffff}ถูกเปลี่ยน Model เป็น {ff0000}(%d)", EditNpc[playerid],strval(inputtext));
	SendClientMessage(playerid, COLOR_GREY, string);
	return 1;
}

Dialog:DIALOG_OBJECT_TWO(playerid, response, listitem, inputtext[])
{
    new string[128];
	if(!response)
	{
	    return 1;
	}
	switch(listitem)
	{
	    case 0:
	    {
	        if(!ObjectInfo[EditNpc[playerid]][Exits])
		 	{
			 	SendClientMessage(playerid, COLOR_GREY,"ยังไม่ถูกสร้างขึ้น !! กรุณาสร้างก่อนครับก่อนปรับแต่ง !!");
		  		return 1;
		 	}
		 	new string100[256];
	        new string2[256];
	        format(string100, sizeof(string100), "แก้ไข Object : \n\n\n\n\n ใส่หมายเลข Model object ที่ต้องการ");
			strcat(string2,string100);
			Dialog_Show(playerid,DIALOG_OBJECT_THREE,DIALOG_STYLE_INPUT,"Object Edit (model)",string2,"OK","Exit");
	        return 1;
	    }
	    case 1:
	    {
	        if(!ObjectInfo[EditNpc[playerid]][Exits])
		 	{
		 	    SendClientMessage(playerid, COLOR_GREY,"ยังไม่ถูกสร้างขึ้น !! กรุณาสร้างก่อนครับก่อนปรับแต่ง !!");
		  		return 1;
		 	}
		 	EditObject(playerid,ObjectInfo[EditNpc[playerid]][ObjectC]);
	        format(string, sizeof(string), "Object {ffff00}(%d) {ffffff}กำลังถูกปรับแต่งกด SPACBAR เพื่อปรับมุมกล้อง", EditNpc[playerid]);
			SendClientMessage(playerid, COLOR_GREY, string);
	    }
	    case 2:
	    {
	        if(!ObjectInfo[EditNpc[playerid]][Exits])
		 	{
		 	    SendClientMessage(playerid, COLOR_GREY,"ยังไม่ถูกสร้างขึ้น !! กรุณาสร้างก่อนครับก่อนปรับแต่ง !!");
		  		return 1;
		 	}
		 	ObjectInfo[EditNpc[playerid]][ObjectModel] = 0;
	    	ObjectInfo[EditNpc[playerid]][ObjectPos][0] = 0.0;
	    	ObjectInfo[EditNpc[playerid]][ObjectPos][1] = 0.0;
	    	ObjectInfo[EditNpc[playerid]][ObjectPos][2] = 0.0;
	    	ObjectInfo[EditNpc[playerid]][ObjectRot][0] = 0.0;
	    	ObjectInfo[EditNpc[playerid]][ObjectRot][1] = 0.0;
	    	ObjectInfo[EditNpc[playerid]][ObjectRot][2] = 0.0;
	    	new query[64];
			mysql_format(g_SQL, query, sizeof(query), "DELETE FROM objectt WHERE ID=%d", EditNpc[playerid]);
			mysql_tquery(g_SQL, query, "", "");
	        ObjectInfo[EditNpc[playerid]][Exits] = false;
			DestroyObject(ObjectInfo[EditNpc[playerid]][ObjectC]);
			format(string, sizeof(string), "Object {ffff00}(%d) {ffffff}ถูกลบแล้ว", EditNpc[playerid]);
			SendClientMessage(playerid, COLOR_GREY, string);
	    }
	    case 3:
	    {
	        for(new i = 1; i < MAX_OBJECTX2; i++)
			{
			    //new id = EditNpc[playerid];
				if(!ObjectInfo[i][Exits])
				{
				    ObjectInfo[i][Exits] = true;
			        new model;
		         	new Float:modelpox;
		         	new Float:modelpoy;
		         	new Float:modelpoz;
		         	new Float:modelporx;
		         	new Float:modelpory;
		         	new Float:modelporz;
		         	//new id = EditNpc[playerid];
		         	new modelword;
	         		model = ObjectInfo[EditNpc[playerid]][ObjectModel];
			        modelpox = ObjectInfo[EditNpc[playerid]][ObjectPos][0];
			    	modelpoy = ObjectInfo[EditNpc[playerid]][ObjectPos][1];
			    	modelpoz = ObjectInfo[EditNpc[playerid]][ObjectPos][2];
			    	modelporx = ObjectInfo[EditNpc[playerid]][ObjectRot][0];
			    	modelpory = ObjectInfo[EditNpc[playerid]][ObjectRot][1];
			    	modelporz = ObjectInfo[EditNpc[playerid]][ObjectRot][2];
			    	modelword = ObjectInfo[EditNpc[playerid]][ObjectWolrd];
			    	ObjectInfo[i][ObjectModel] = model;
			        ObjectInfo[i][ObjectPos][0] = modelpox;
			    	ObjectInfo[i][ObjectPos][1] = modelpoy;
			    	ObjectInfo[i][ObjectPos][2] = modelpoz;
			    	ObjectInfo[i][ObjectRot][0] = modelporx;
			    	ObjectInfo[i][ObjectRot][1] = modelpory;
			    	ObjectInfo[i][ObjectRot][2] = modelporz;
			    	ObjectInfo[i][ObjectWolrd] = modelword;
			        ObjectInfo[i][ObjectC] = CreateObject(model,modelpox,modelpoy,modelpoz,modelporx,modelpory,modelporz,0);
					//=============================================================
			        format(string, sizeof(string), "Object {ffff00}(%d) {ffffff}ถูกสร้างแล้วกรุณาปรับแต่งเป้าหมายที่ต้องการ", i);
					SendClientMessage(playerid, COLOR_GREY, string);
	    			new query[512];
					mysql_format(g_SQL, query, sizeof(query), "INSERT INTO  objectt SET ID=%d,ObjectModel='%d', ObjectPosX='%f', ObjectPosY='%f', ObjectPosZ='%f',ObjectPosRX='%f',ObjectPosRY='%f',ObjectPosRZ='%f',ObjectWolrd='%d'",i,model,modelpox,modelpoy,modelpoz,modelporx,modelpory,modelporz,modelword);
					mysql_tquery(g_SQL, query, "", "");
					format(string, sizeof(string), "Duplicate Object {ffff00}(ไอดี%d) {ffffff} คุณสร้าง model %d (ไอดี%d) ",EditNpc[playerid], i);
					SendClientMessage(playerid, COLOR_GREY, string);
					EditNpc[playerid] = i;
	    			return 1;
				}
			}
	    }
	}
	return 1;
}

forward Load_Object();
public Load_Object()
{
    new rows = cache_num_rows();
	new id,loaded;
 	if(rows)
  	{
		while(loaded < rows)
		{
		    cache_get_value_name_int(loaded,"ID",id);
		    cache_get_value_name_int(loaded,"ObjectModel",ObjectInfo[id][ObjectModel]);
		    cache_get_value_name_float(loaded,"ObjectPosX",ObjectInfo[id][ObjectPos][0]);
		    cache_get_value_name_float(loaded,"ObjectPosY",ObjectInfo[id][ObjectPos][1]);
		    cache_get_value_name_float(loaded,"ObjectPosZ",ObjectInfo[id][ObjectPos][2]);
		    cache_get_value_name_float(loaded,"ObjectPosRX",ObjectInfo[id][ObjectRot][0]);
		    cache_get_value_name_float(loaded,"ObjectPosRY",ObjectInfo[id][ObjectRot][1]);
		    cache_get_value_name_float(loaded,"ObjectPosRZ",ObjectInfo[id][ObjectRot][2]);
		    cache_get_value_name_int(loaded,"ObjectWolrd",ObjectInfo[id][ObjectWolrd]);

		    ObjectInfo[id][ObjectC] = CreateObject(ObjectInfo[id][ObjectModel],ObjectInfo[id][ObjectPos][0],ObjectInfo[id][ObjectPos][1],ObjectInfo[id][ObjectPos][2],ObjectInfo[id][ObjectRot][0],ObjectInfo[id][ObjectRot][1],ObjectInfo[id][ObjectRot][2],ObjectInfo[id][ObjectWolrd]);
			if(!ObjectInfo[id][Exits])
		    {
		        ObjectInfo[id][Exits] = true;
		    }
		    loaded ++;
		}

	}
	printf("Load_Model %d", loaded);
}

stock Save_Object(id)
{
    new query[1048];
	mysql_format(g_SQL, query, sizeof(query), "UPDATE objectt SET ObjectModel='%d',ObjectPosX='%f',ObjectPosY='%f',ObjectPosZ='%f',ObjectPosRX='%f',ObjectPosRY='%f',ObjectPosRZ='%f',ObjectWolrd='%d' WHERE ID=%d",
	ObjectInfo[id][ObjectModel],ObjectInfo[id][ObjectPos][0],ObjectInfo[id][ObjectPos][1],ObjectInfo[id][ObjectPos][2],ObjectInfo[id][ObjectRot][0],ObjectInfo[id][ObjectRot][1],ObjectInfo[id][ObjectRot][2],ObjectInfo[id][ObjectWolrd],id);
	mysql_tquery(g_SQL, query, "", "");
}

forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}
