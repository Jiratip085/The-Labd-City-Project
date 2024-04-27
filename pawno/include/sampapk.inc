//sampapk

#if !defined SAMPVOICE_INC_
	#define SAMPVOICE_INC_

	#define SAMPVOICE_INCLUDE_VERSION	100

	#if !defined __cplusplus

	public _sampvoice_version = SAMPVOICE_INCLUDE_VERSION;
	#pragma unused _sampvoice_version

	// natives
	native Voice_MutePlayer(playerid);
	native Voice_UnMutePlayer(playerid);

	native VoiceStream:Voice_CreateStream();
	native Voice_DeleteStream(&VoiceStream:vs);

	native Voice_AddPlayerToStream(VoiceStream:vs, playerid);
	native Voice_RemovePlayerFromStream(VoiceStream:vs, playerid);

	#endif // !defined __cplusplus
#endif // SAMPVOICE_INC_