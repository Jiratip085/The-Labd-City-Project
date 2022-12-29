#include <YSI\y_hooks>

enum crateData {
	crateID,
	crateExists,
	crateType,
 	Float:cratePos[4],
	crateInterior,
	crateWorld,
	crateObject,
	crateVehicle,
	Text3D:crateText3D
};
new CrateData[MAX_CRATES][crateData];

//dynamic crate
Crate_Create(playerid, type)
{
	new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;

	if (GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
	{
	    for (new i = 0; i != MAX_CRATES; i ++) if (!CrateData[i][crateExists])
	    {
         	if (Crate_Nearest(playerid, 2.5) != -1) {
			 	z = floatsub(z, 0.1);
	        }
            CrateData[i][crateExists] = true;
            CrateData[i][crateVehicle] = INVALID_VEHICLE_ID;
            CrateData[i][crateType] = type;

			CrateData[i][cratePos][0] = x;
   			CrateData[i][cratePos][1] = y;
            CrateData[i][cratePos][2] = z - 0.9;
            CrateData[i][cratePos][3] = angle;

            CrateData[i][crateInterior] = GetPlayerInterior(playerid);
            CrateData[i][crateWorld] = GetPlayerVirtualWorld(playerid);

            Crate_Refresh(i);
            return i;
		}
	}
	return -1;
}

Crate_Nearest(playerid, Float:radius = 2.5)
{
	if (Character[playerid][CarryCrate] != -1 && CrateData[Character[playerid][CarryCrate]][crateExists])
	    return Character[playerid][CarryCrate];

    for (new i = 0; i != MAX_CRATES; i ++) if (CrateData[i][crateExists] && IsPlayerInRangeOfPoint(playerid, radius, CrateData[i][cratePos][0], CrateData[i][cratePos][1], CrateData[i][cratePos][2]))
	{
		if (GetPlayerInterior(playerid) == CrateData[i][crateInterior] && GetPlayerVirtualWorld(playerid) == CrateData[i][crateWorld])
			return i;
	}
	return -1;
}

Crate_GetType(type)
{
	new
	    str[24];

	switch (type)
	{
	    case 1: str = "เนื้อสัตว์";
	    case 2: str = "เครื่องดื่ม";
	    default: str = "ไม่มี";
	}
	return str;
}

Crate_Refresh(crateid)
{
	if (crateid != -1 && CrateData[crateid][crateExists])
	{
	    new
	        string[128];

		if (IsValidDynamicObject(CrateData[crateid][crateObject]))
		    DestroyDynamicObject(CrateData[crateid][crateObject]);

		if (IsValidDynamic3DTextLabel(CrateData[crateid][crateText3D]))
		    DestroyDynamic3DTextLabel(CrateData[crateid][crateText3D]);

		CrateData[crateid][crateObject] = CreateDynamicObject(2912, CrateData[crateid][cratePos][0], CrateData[crateid][cratePos][1], CrateData[crateid][cratePos][2], 0.0, 0.0, CrateData[crateid][cratePos][3], CrateData[crateid][crateWorld], CrateData[crateid][crateInterior]);

		if (CrateData[crateid][crateType])
		{
			format(string, sizeof(string), "%s", Crate_GetType(CrateData[crateid][crateType]));
		}
  		CrateData[crateid][crateText3D] = CreateDynamic3DTextLabel(string, COLOR_WHITE, CrateData[crateid][cratePos][0], CrateData[crateid][cratePos][1], CrateData[crateid][cratePos][2] + 0.5, 10.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, CrateData[crateid][crateWorld], CrateData[crateid][crateInterior]);
	}
	return 1;
}

Crate_Delete(crateid)
{
	if (crateid != -1 && CrateData[crateid][crateExists])
	{

        if (IsValidDynamic3DTextLabel(CrateData[crateid][crateText3D]))
		    DestroyDynamic3DTextLabel(CrateData[crateid][crateText3D]);

		if (IsValidDynamicObject(CrateData[crateid][crateObject]))
		    DestroyDynamicObject(CrateData[crateid][crateObject]);

		foreach (new i : Player) if (Character[i][CarryCrate] == crateid) {
		    Character[i][CarryCrate] = -1;

		    RemovePlayerAttachedObject(i, 4);
		    SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
		}
	    CrateData[crateid][crateExists] = false;
	    CrateData[crateid][crateID] = 0;
	    CrateData[crateid][crateVehicle] = INVALID_VEHICLE_ID;
	}
	return 1;
}
