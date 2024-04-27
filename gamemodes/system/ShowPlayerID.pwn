
///ไว้แถวๆ พวก new หรือบนหัวสคริป
new Text3D:cNametag[MAX_PLAYERS];
#define NT_DISTANCE 35.0

//ไว้ใน onplayerconnet
new string[1024];
format(string, sizeof(string), "{FFFFFF}[ID:%d]", playerid);
cNametag[playerid] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, 0.0, 0.0, 0.3, NT_DISTANCE, .attachedplayer = playerid, .testlos = 1);

//ไว้ในonplayerdisconnet
	if(IsValidDynamic3DTextLabel(cNametag[playerid]))
 		DestroyDynamic3DTextLabel(cNametag[playerid]);

//ไว้ไหนก็ได้มั้ง (ถ้าจำไม่ผิด)
ptask PlayerUpdateInfo[250](playerid)
{
	new string[1024];

	if (IsPlayerSpawnedEx(playerid))
	{
		format(string, sizeof(string), "แก๊ง:{F9BE04}[%s]ชื่อ:{FFFFFF}[%s]ไอดีตัวละคร:{F91304}[%d]", Faction_GetName(playerid), GetPlayerNameEx(playerid), playerid);
		UpdateDynamic3DTextLabelText(cNametag[playerid], 0xFFFFFFFF, string);
	}
	return 1;
}
         