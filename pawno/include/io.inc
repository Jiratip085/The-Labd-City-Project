/*
	isPlayerAndroid(playerId);
	setDeviceInfo(playerId, deviceType);
*/

#if defined _IO_included
	#endinput
#endif
#define _IO_included

#if !defined _samp_included
	#error "plz include a_samp.inc"
#endif

#if !defined PAWNRAKNET_INC_
	#error "plz include Pawn.RakNet"
#endif

#if defined RPC_CLIENT_JOIN
	#undef RPC_CLIENT_JOIN
	#define RPC_CLIENT_JOIN 25
#else
	#define RPC_CLIENT_JOIN 25
#endif

enum E_CLIENT_KEY
{
	e_clientVersion,
	e_szAuthKey[44]
}

static const stock m_szClientVersions[][E_CLIENT_KEY] = {
	{70, "15121F6F18550C00AC4B4F8A167D0379BB0ACA99043"},
	{69, "161186A32578A6E62CBD2BB46D56F7F061EDB3A15B0"},	
	{47, "1031CA8429843C9B8C178B65F3C73602578440D17F8"}
};

enum E_CLIENT_STRUCT
{
	iVersion, 					// INT32 
	byteMod, 					// UINT8 
	byteNicknameLen, 			// UINT8 
	NickName[MAX_PLAYER_NAME],	// char  
	uiClientChallengeResponse,  // UINT32
	byteAuthKeyLen, 			// UINT8 
	auth_key[64], 				// char  
	iClientVerLen, 				// UINT8 
	ClientVersion[12]			// char  

};

static playerDevice[MAX_PLAYERS char];

stock isPlayerAndroid(playerId) { return playerDevice{playerId}; }
stock setDeviceInfo(playerId, deviceType)
{
	playerDevice{playerId} = deviceType;
	return 1;
}

#if defined _inc_y_hooks || defined _INC_y_hooks
	hook OnIncomingRPC(playerid, rpcid, BitStream:bs)
#else
	public OnIncomingRPC(playerid, rpcid, BitStream:bs)
#endif
	{
		if(rpcid == RPC_CLIENT_JOIN)
		{
			new dataClient[E_CLIENT_STRUCT];
			BS_ReadValue(
				bs,
				PR_INT32, dataClient[iVersion],
				PR_UINT8, dataClient[byteMod],
				PR_UINT8, dataClient[byteNicknameLen],
				PR_STRING, dataClient[NickName], dataClient[byteNicknameLen],
				PR_UINT32, dataClient[uiClientChallengeResponse],
				PR_UINT8, dataClient[byteAuthKeyLen],
				PR_STRING, dataClient[auth_key], dataClient[byteAuthKeyLen],
				PR_UINT8, dataClient[iClientVerLen],
				PR_STRING, dataClient[ClientVersion], dataClient[iClientVerLen]
			);

			setDeviceInfo(playerid, 0);

			static iter = 0;
			for(iter = 0; iter < sizeof(m_szClientVersions); iter++)
			{
				if(!strcmp(dataClient[auth_key], m_szClientVersions[iter][e_szAuthKey]))
				{
					setDeviceInfo(playerid, m_szClientVersions[iter][e_clientVersion]);
					break;
				}
			}
		}

		#if defined INCLUDE_OnIncomingRPC
			return INCLUDE_OnIncomingRPC(playerid, rpcid, BitStream:bs);
		#else
			return 1;
		#endif
	}

#if !defined _inc_y_hooks && !defined _INC_y_hooks
	#if defined _ALS_OnIncomingRPC
		#undef OnIncomingRPC
	#else
		#define _ALS_OnIncomingRPC
	#endif

	#define OnIncomingRPC INCLUDE_OnIncomingRPC
	#if defined INCLUDE_OnIncomingRPC
		forward INCLUDE_OnIncomingRPC(playerid, rpcid, BitStream:bs);
	#endif
#endif