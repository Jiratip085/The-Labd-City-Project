#include <YSI_Coding\y_hooks>


new GasFlint[3];
new bool:GasFlints[3];

hook OnPlayerUpdate(playerid)
{
    if(IsPlayerInRangeOfPoint(playerid, 1.5, -91.0058,-1202.9404,2.7023)) // Gas Flint หน้า
    {
        switch (GasFlints[0] && GasFlints[1])
        {
            case false:
            {
                GasFlints[0] = true;
                GasFlints[1] = true;
                MoveObject(GasFlint[0], -93.2690, -1202.2790, 1.6629, 3);  
                MoveObject(GasFlint[1], -88.7391, -1203.3689, 1.6629, 3);  
                SetTimerEx("GasFlintsDoor", 2000, 0, "id");
                
            }
        }
        return 1;
    }
    return 1;
}
forward GasFlintsDoor(type);
public GasFlintsDoor()
{
    GasFlints[0] = false;
    GasFlints[1] = false;
    MoveObject(GasFlint[0], -92.48898, -1202.47900, 1.66290, 3);  
    MoveObject(GasFlint[1], -89.57909, -1203.16895, 1.66290, 3);  
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_SECONDARY_ATTACK)
	{
        if (IsPlayerInRangeOfPoint(playerid, 1.0, -83.3485,-1214.5416,2.7030)) // Gas Flint หลัง
        {
            switch (GasFlints[2])
            {
                case false:
                {
                    GasFlints[2] = true;
                    MoveObject(GasFlint[2], -85.1765, -1214.3482, 1.6991, 3);  
                    
                }
                case true:
                {
                    GasFlints[2] = false;
                    MoveObject(GasFlint[2], -84.33649, -1214.56824, 1.69910, 3);  
                }
            }
            return 1;
        }

    }
    return 1;
}

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 17066, -86.8750, -1207.2422, 1.6875, 0.25);
}
hook OnGameModeInit()
{
    GasFlint[0] = CreateObject(1495, -92.48898, -1202.47900, 1.66290,   0.00000, 0.00000, -13.76000);
    GasFlint[1] = CreateObject(1495, -89.57909, -1203.16895, 1.66290,   0.00000, 0.00000, -193.98000);

    GasFlint[2] = CreateObject(1495, -84.33649, -1214.56824, 1.69910,   0.00000, 0.00000, -13.84000);

    CreateObject(12843, -90.51670, -1207.95764, 1.70810,   0.00000, 0.00000, -193.79994);
    CreateObject(12844, -87.62000, -1208.65674, 3.67300,   0.00000, 0.00000, -193.71989);
    CreateObject(12845, -87.91400, -1209.00427, 3.78090,   0.00000, 0.00000, -194.03990);
    CreateObject(1514, -90.77312, -1209.38049, 2.77378,   0.00000, 0.00000, -193.98001);
    CreateObject(1514, -89.10544, -1209.79529, 2.77380,   0.00000, 0.00000, -193.98000);
    CreateObject(1688, -84.25945, -1212.03589, 7.02503,   0.00000, 0.00000, -12.66000);
    
}
