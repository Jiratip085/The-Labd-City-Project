#include <a_samp>
#include <YSI\y_bit>

static stock
    Float:AC_Position[MAX_PLAYERS][3],
    pLastPosTick[MAX_PLAYERS],
	pLastDrive[MAX_PLAYERS],
    BitArray:AC_SafeTP<MAX_PLAYERS>
;

forward OnPlayerTeleport(playerid, Float:distance);

public OnPlayerSpawn(playerid)
{
    pLastDrive[playerid] = 0;
    GetPlayerPos(playerid, AC_Position[playerid][0], AC_Position[playerid][1], AC_Position[playerid][2]);
    #if defined pds_OnPlayerSpawn
        pds_OnPlayerSpawn(playerid);
    #endif
    return true;
}

#if defined _ALS_OnPlayerSpawn
    #undef OnPlayerSpawn  
#else
    #define _ALS_OnPlayerSpawn
#endif

#define OnPlayerSpawn pds_OnPlayerSpawn
    
#if defined pds_OnPlayerSpawn
    forward pds_OnPlayerSpawn(playerid);
#endif


public OnPlayerUpdate(playerid)
{   
    if( gettime( ) - pLastPosTick[ playerid ] > 1) //updates the player location every 2 seconds.
    {
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
		{
		    pLastDrive[playerid] = GetPlayerVehicleID(playerid);
		}

        //on-foot
        if( !IsPlayerInRangeOfPoint(playerid, 50.0, AC_Position[playerid][ 0 ], AC_Position[playerid][ 1 ], AC_Position[playerid][ 2 ]) && !Bit_Get(AC_SafeTP, playerid) && !IsPlayerNPC(playerid)
        && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID && !IsPlayerUsingFallAnim(playerid))
        {
			if(pLastDrive[playerid] != 0)
			{
			    //GetPlayerPos(playerid, AC_Position[playerid][ 0 ], AC_Position[playerid][ 1 ], AC_Position[playerid][ 2 ]);
		        if( !IsPlayerInRangeOfPoint(playerid, 300.0, AC_Position[playerid][ 0 ], AC_Position[playerid][ 1 ], AC_Position[playerid][ 2 ]) && !Bit_Get(AC_SafeTP, playerid) && !IsPlayerNPC(playerid)
        		&& GetVehicleSpeed( GetPlayerVehicleID(playerid) ) <= 50 && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER))
		        {
		            CallLocalFunction("OnPlayerTeleport", "if", playerid, GetPlayerDistanceFromPoint(playerid, AC_Position[playerid][ 0 ], AC_Position[playerid][ 1 ], AC_Position[playerid][ 2 ]));
		        }
			}
			else
			{
            	CallLocalFunction("OnPlayerTeleport", "if", playerid, GetPlayerDistanceFromPoint(playerid, AC_Position[playerid][ 0 ], AC_Position[playerid][ 1 ], AC_Position[playerid][ 2 ]));
			}
		}
        //on-vehicle
        else if( !IsPlayerInRangeOfPoint(playerid, 300.0, AC_Position[playerid][ 0 ], AC_Position[playerid][ 1 ], AC_Position[playerid][ 2 ]) && !Bit_Get(AC_SafeTP, playerid) && !IsPlayerNPC(playerid)
        && GetVehicleSpeed( GetPlayerVehicleID(playerid) ) <= 50 && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER))
        {
            CallLocalFunction("OnPlayerTeleport", "if", playerid, GetPlayerDistanceFromPoint(playerid, AC_Position[playerid][ 0 ], AC_Position[playerid][ 1 ], AC_Position[playerid][ 2 ]));
		}
    	/*new string[128];
		format(string, sizeof(string), "Distant: %f | Vehicle Speed %d", GetPlayerDistanceFromPoint(playerid, AC_Position[playerid][ 0 ], AC_Position[playerid][ 1 ], AC_Position[playerid][ 2 ]), GetVehicleSpeed( GetPlayerVehicleID(playerid) ));
		SendClientMessage(playerid, -1, string);*/

        /*if(GetPlayerVehicleID(playerid) > 0) GetVehiclePos(GetPlayerVehicleID(playerid), AC_Position[playerid][ 0 ], AC_Position[playerid][ 1 ], AC_Position[playerid][ 2 ]);
		else GetPlayerPos(playerid, AC_Position[playerid][ 0 ], AC_Position[playerid][ 1 ], AC_Position[playerid][ 2 ]);*/
		GetPlayerPos(playerid, AC_Position[playerid][ 0 ], AC_Position[playerid][ 1 ], AC_Position[playerid][ 2 ]);
		//SetPlayerCheckpoint(playerid, AC_Position[playerid][ 0 ], AC_Position[playerid][ 1 ], AC_Position[playerid][ 2 ], 3.0);

        Bit_Set(AC_SafeTP, playerid, false);
        pLastPosTick[ playerid ] = gettime( ) + 2;
    }
    #if defined pds_OnPlayerUpdate
        pds_OnPlayerUpdate(playerid);
    #endif
    return true;
}

#if defined _ALS_OnPlayerUpdate
    #undef OnPlayerUpdate
#else
    #define _ALS_OnPlayerUpdate
#endif

#define OnPlayerUpdate pds_OnPlayerUpdate
    
#if defined pds_OnPlayerUpdate
    forward pds_OnPlayerUpdate(playerid);
#endif

stock pds_SetPlayerPos(playerid, Float:PosX, Float:PosY, Float:PosZ)
{
    GetPlayerPos(playerid, AC_Position[playerid][0], AC_Position[playerid][1], AC_Position[playerid][2]);
    Bit_Set(AC_SafeTP, playerid, true);
    return SetPlayerPos(playerid, PosX, PosY, PosZ);
}

#if defined _ALS_SetPlayerPos
    #undef SetPlayerPos
#else
    #define _ALS_SetPlayerPos
#endif

#define SetPlayerPos pds_SetPlayerPos

stock pds_SetPlayerPosFindZ(playerid, interiorid) 
{ 
    GetPlayerPos(playerid, AC_Position[playerid][0], AC_Position[playerid][1], AC_Position[playerid][2]);
    Bit_Set(AC_SafeTP, playerid, true);
    return SetPlayerInterior(playerid, interiorid);
}

#if defined _ALS_SetPlayerPosFindZ
    #undef SetPlayerPosFindZ  
#else
    #define _ALS_SetPlayerPosFindZ
#endif

#define SetPlayerPosFindZ pds_SetPlayerPosFindZ


stock pds_PutPlayerInVehicle(playerid, vehicleid, seatid) 
{ 
    GetPlayerPos(playerid, AC_Position[playerid][0], AC_Position[playerid][1], AC_Position[playerid][2]);
    Bit_Set(AC_SafeTP, playerid, true);
    return PutPlayerInVehicle(playerid, vehicleid, seatid);
}

#if defined _ALS_PutPlayerInVehicle
    #undef PutPlayerInVehicle  
#else
    #define _ALS_PutPlayerInVehicle
#endif

#define PutPlayerInVehicle pds_PutPlayerInVehicle

stock pds_SetPlayerInterior(playerid, interiorid) 
{ 
    GetPlayerPos(playerid, AC_Position[playerid][0], AC_Position[playerid][1], AC_Position[playerid][2]);
    Bit_Set(AC_SafeTP, playerid, true);
    return SetPlayerInterior(playerid, interiorid);
}


#if defined _ALS_SetPlayerInterior
    #undef SetPlayerInterior  
#else
    #define _ALS_SetPlayerInterior
#endif

#define SetPlayerInterior pds_SetPlayerInterior

static stock GetVehicleSpeed( vehicleid ) //records in KMH.
{
    new
        Float:VehiclePos[3],
        VehicleVelocity;
        
    GetVehicleVelocity( vehicleid, VehiclePos[0], VehiclePos[1], VehiclePos[2] );
    VehicleVelocity = floatround( floatsqroot( VehiclePos[0]*VehiclePos[0] + VehiclePos[1]*VehiclePos[1] + VehiclePos[2]*VehiclePos[2] ) * 180 );
    return VehicleVelocity;
}


static stock IsPlayerUsingFallAnim( playerid )
{
    switch( GetPlayerAnimationIndex( playerid ) )
    {
        case 1130, 1132: return true;
    }
    return false;
}
