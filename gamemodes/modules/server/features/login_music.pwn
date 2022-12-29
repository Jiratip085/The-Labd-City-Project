#include <YSI\y_hooks>
new MusicLinks[][] =
{
    "http://k007.kiwi6.com/hotlink/xho9spq77x/Lil_Nas_X_-_Old_Town_Road_Official_Video_ft._Billy_Ray_Cyrus.mp3"
};

hook OnPlayerConnect(playerid)
{
    new rand = random(sizeof(MusicLinks));
    PlayAudioStreamForPlayer(playerid, MusicLinks[rand][0]);
    CreateSpacer(playerid, 128);
}
