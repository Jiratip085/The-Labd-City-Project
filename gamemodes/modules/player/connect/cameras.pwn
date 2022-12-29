
#include <YSI\y_hooks>

new plane[MAX_PLAYERS];
new planeworld = 2000;

forward Login_Camera(playerid);
public Login_Camera(playerid)
{
	TogglePlayerSpectating(playerid, 1);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 1000);
	Camera_1(playerid);
	return 1;
}

CameraOnNewCharacter(playerid)
{
	TogglePlayerControllable(playerid, 0);
	MoveDynamicObject(plane[playerid], 387.51291, 2503.57251, 21.29870, 20.0);
	SendClientMessage(playerid, COLOR_GREEN, "Air hostess พูดว่า: ขณะนี้เครื่องบินกำลังจะลงจอดที่สนามบินใกล้เมือง Fort Carson กรุณาเตรียมสัมภาระให้พร้อม");
	InterpolateCameraPos(playerid, 54.4642, 2529.9653, 128.5643,  415.5514,2520.6848,16.4844, 20000, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, 417.8465, 2522.3130, 16.4844, 386.7877, 2507.1416,21.6357, 20000, CAMERA_MOVE);
	SetPlayerPos(playerid, 203.1984,2503.6367,16.4844);
	SetTimerEx("MsgFinal", 21000, false, "d", playerid);
	SetTimerEx("UnCameraOnNewCharacter", 25000, false, "d", playerid);
	return 1;
}

forward MsgFinal(playerid);
public MsgFinal(playerid)
{
	PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
	SendClientMessage(playerid, COLOR_GREEN, "Air hostess พูดว่า: อีกสักครู่เราจะนำท่านไปยังเมือง Fort Carson.....");
	return 1;
}

forward UnCameraOnNewCharacter(playerid);
public UnCameraOnNewCharacter(playerid)
{
	DestroyDynamicObject(plane[playerid]);
	TogglePlayerControllable(playerid, 1);
	StopAudioStreamForPlayer(playerid);
	SetPlayerScore(playerid, Character[playerid][Level]);
	SetPlayerPosEx(playerid, NoobSpawns[0][0], NoobSpawns[0][1], NoobSpawns[0][2], 0, 0);
	SetPlayerFacingAngle(playerid, 180.8614);
	SetPlayerVirtualWorld(playerid, 0);
	LoggedIn[playerid] = true;
	Character[playerid][ClothesSelection] = 0;
	Character[playerid][Spawn] = 1;
	Character[playerid][Skin] = GetPlayerSkin(playerid);
	SendClientMessage(playerid, -1, "[HINT]: คุณได้เดินทางมายังเมือง Fort Carson แล้ว");
	SendClientMessage(playerid, -1, "[- สิ่งที่มีติดตัว -]");
	SendClientMessage(playerid, -1, "- เงินติดตัว: {16B903}$1,000");
	SendClientMessage(playerid, -1, "- เงินในบัญชีธนาคาร: {16B903}$3,000");
	Character[playerid][ConfirmChar] = 0;
	SetCameraBehindPlayer(playerid);
	Character_Save(playerid);
	return 1;
}


forward Camera_1(playerid);
public Camera_1(playerid)
{
	if(!LoggedIn[playerid])
	{
		InterpolateCameraPos(playerid, -195.276611, 1086.453613, 274.309112, -191.671737, 1088.624755, 102.591979, SECONDS(60), 1);
		InterpolateCameraLookAt(playerid, -195.273529, 1086.802246, 270.324340, -191.661849, 1089.016845, 98.611251, SECONDS(60), 1);
		SetTimer("Camera_2", SECONDS(60), 0);	
	}
	return 1;
}

forward Camera_2(playerid);
public Camera_2(playerid)
{
	if(!LoggedIn[playerid])
	{
		InterpolateCameraPos(playerid, -191.671737, 1088.624755, 102.591979, -162.491271, 1235.904174, 32.566741, SECONDS(60), 1);
		InterpolateCameraLookAt(playerid, -191.661849, 1089.016845, 98.611251, -164.412902, 1232.416015, 32.192291, SECONDS(60), 1);
		SetTimer("Camera_3", SECONDS(60), 0);
	}
	return 1;
}

forward Camera_3(playerid);
public Camera_3(playerid)
{
	if(!LoggedIn[playerid])
	{
		InterpolateCameraPos(playerid, -162.491271, 1235.904174, 32.566741, 190.346618, 1189.209960, 25.307855, SECONDS(60), 1);
		InterpolateCameraLookAt(playerid, -164.412902, 1232.416015, 32.192291, 187.398620, 1191.885620, 25.695003, SECONDS(60), 1);
		SetTimer("Camera_1", SECONDS(60), 0);
	}
	return 1;
}

/*		SetPlayerCameraLookAt(playerid, -193.2323, 1098.5872, 19.5938);
	    InterpolateCameraPos(playerid, -463.8441, 1098.2235, 23.3950, 176.2551, 1093.3696, 38.7697, 100000, CAMERA_MOVE);*/