#include	<YSI_Coding\y_hooks>
#include 	<YSI_Coding\y_timers>

enum {
    E_TYPE_GENERAL
};

/*----------------------------------*/
enum eRewardGachapong_Array {
    eRGA_Type,
    eRGA_KeyItem[10],
    eRGA_QtyItem[10]
};
new const RewardGachapong_Array[][eRewardGachapong_Array] = {
    { E_TYPE_GENERAL, { 3930, 2060, 1212, 541, 2060, 3930, 1212, 541, 3930  }, {1, 1, 1, 1, 1, 1, 1, 1, 1 } }
};
/*----------------------------------*/

new
    PlayerText: Interface_Gc_Ui[MAX_PLAYERS][17];

new
    gachapong_opened[MAX_PLAYERS],
    gachapong_status[MAX_PLAYERS],
    gachapong_point[MAX_PLAYERS],
    gachapong_maxpoint[MAX_PLAYERS],
    gachapong_timer[MAX_PLAYERS],
    Timer: gachapong_ptimer[MAX_PLAYERS];

new
    random_item[MAX_PLAYERS][17],
    random_qtyitem[MAX_PLAYERS][17],
    random_getitem[MAX_PLAYERS],
    random_getqtyitem[MAX_PLAYERS],
	random_type[MAX_PLAYERS];

timer Gachapong_WunLoop[gachapong_timer[playerid]](playerid) {
    if(!gachapong_maxpoint[playerid]) {
        stop gachapong_ptimer[playerid];
        Brian_ClearGachapongData(playerid);
        return 0;
    }

    if(gachapong_point[playerid] <= gachapong_maxpoint[playerid]) {
        for(new index = 2; index < 12; index ++) {
            if(index == 2) {
                random_getitem[playerid] = random_item[playerid][index];
                random_getqtyitem[playerid] = random_qtyitem[playerid][index];
            }

            random_item[playerid][index] = random_item[playerid][index + 1];
            random_qtyitem[playerid][index] = random_qtyitem[playerid][index + 1];

            if(index >= 10) {
                random_item[playerid][index] = random_getitem[playerid];
                random_qtyitem[playerid][index] = random_getqtyitem[playerid];                
            }

            if(index == 4 || index < 11) {
                PlayerTextDrawSetPreviewModel(playerid, Interface_Gc_Ui[playerid][index], random_item[playerid][index]);
                PlayerTextDrawShow(playerid, Interface_Gc_Ui[playerid][index]); 
            }              
        }    

        gachapong_point[playerid] += 10;

        if(gachapong_point[playerid] <= 190) gachapong_timer[playerid] = 100;
        else gachapong_timer[playerid] = 500;

        gachapong_ptimer[playerid] = defer Gachapong_WunLoop(playerid);
    }

    else if(gachapong_point[playerid] >= gachapong_maxpoint[playerid]) {
        stop gachapong_ptimer[playerid];

        for(new index = 2; index < 12; index ++) {
            if(index == 6) {
                random_getitem[playerid] = random_item[playerid][index];
                random_getqtyitem[playerid] = random_qtyitem[playerid][index];
            }
        }

        Brian_GachapongGiveItem(playerid,random_getitem[playerid]);

        gachapong_status[playerid] =
        gachapong_point[playerid] =
        gachapong_timer[playerid] = 
        gachapong_maxpoint[playerid] = 0;
    }

    return 1;
}

hook OnPlayerConnect(playerid) {
    Brian_ClearGachapongData(playerid);
    random_type[playerid] = 0;
    return 1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid) {
    if(gachapong_opened[playerid]) {
        if(clickedid == Text:INVALID_TEXT_DRAW) {
            if(gachapong_status[playerid]) return 1;

            Brian_UseInterface_Gc(playerid,false);
            return Y_HOOKS_BREAK_RETURN_1;
        }
    }
	return 1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid) {
    if(gachapong_opened[playerid]) {
        if(playertextid == Interface_Gc_Ui[playerid][12])
		{
            if(gachapong_status[playerid])
				return 1;

			switch (random_type[playerid])
			{
			    case 0: ErrorMsg(playerid, "เกิดข้อผิดพลาด, กรุณาติดต่อผู้ดูแลระบบ");
			    case 1: Brian_GachapongStart(playerid,E_TYPE_GENERAL);
			}
            return Y_HOOKS_BREAK_RETURN_1;      
        }
        else if(playertextid == Interface_Gc_Ui[playerid][3]) {
            if(gachapong_status[playerid]) return 1;

            Brian_UseInterface_Gc(playerid,false);
            CancelSelectTextDraw(playerid);
            return Y_HOOKS_BREAK_RETURN_1;            
        }
    }
    return 1;
}

Brian_ClearGachapongData(playerid) {
    random_item[playerid][0] = 
    random_item[playerid][1] = 
    random_qtyitem[playerid][0] =  
    random_qtyitem[playerid][1] =
    random_getitem[playerid] =
    random_getqtyitem[playerid] = 

    gachapong_opened[playerid] =
    gachapong_status[playerid] =
    gachapong_point[playerid] =
    gachapong_timer[playerid] = 
    gachapong_maxpoint[playerid] = 0;
    return 1;
}

Brian_GachapongStart(playerid,Type)
{
    if(!gachapong_opened[playerid])
		return 1;

	if (Type == E_TYPE_GENERAL) //
	{
	    gachapong_point[playerid] = 0;
	    gachapong_maxpoint[playerid] = 0;
	    gachapong_status[playerid] = 1;

	    new Logic, Gc_Id, percent = random(100);

	    Inventory_Remove(playerid, "กาชาปอง", 1);

		switch (percent)
		{
		    case 0..98:
		    {
		        new carbox = random(7);
		        switch (carbox)
		        {
		            case 0: Logic = 330;
		            case 1: Logic = 340;
		            case 2: Logic = 350;
		            case 3: Logic = 360;
		            case 4: Logic = 370;
		            case 5: Logic = 380;
		            case 6: Logic = 390;
		        }
		    }
		    case 99..100:
		    {
		        new carbox = random(2);
		        switch (carbox)
		        {
		            case 0: Logic = 310;
		            case 1: Logic = 320;
		        }
		    }
		}
   
	    gachapong_maxpoint[playerid] = Logic;
	    /*---------------------------------*/

	    for(new row = 0; row != sizeof(RewardGachapong_Array); row ++) {
	        if(RewardGachapong_Array[row][eRGA_Type] == Type) {
	            Gc_Id = row;
	            break;
	        }
	    }

	    for(new index = 2; index < 12; index ++) {
	        random_item[playerid][index] = RewardGachapong_Array[Gc_Id][eRGA_KeyItem][index - 2];
	        random_qtyitem[playerid][index] = RewardGachapong_Array[Gc_Id][eRGA_QtyItem][index - 2];

	        if(index == 4 || index < 12) {
	            PlayerTextDrawSetPreviewModel(playerid, Interface_Gc_Ui[playerid][index], random_item[playerid][index]);
	            PlayerTextDrawShow(playerid, Interface_Gc_Ui[playerid][index]);
	        }
	    }

	    gachapong_timer[playerid] = 100;
	    gachapong_ptimer[playerid] = defer Gachapong_WunLoop(playerid);
	}
	return 1;
}
