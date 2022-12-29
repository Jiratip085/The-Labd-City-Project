
enum sver
{
	ID,
	Name[32],
	Version[16],
	Locked,
	Password[32],
	Weather
};

new Server[sver];

forward LoadSettings(id);
public LoadSettings(id)
{
	if(cache_num_rows())
    {
    	cache_get_value_name_int(0, "ID", Server[ID]);
		cache_get_value_name(0, "Name", Server[Name], 32);
		cache_get_value_name(0, "Version", Server[Version], 16);
		cache_get_value_name_int(0, "Locked", Server[Locked]);
		cache_get_value_name(0, "Password", Server[Password], 16);
		cache_get_value_name_int(0, "Weather", Server[Weather]);

		new str[128];
		if(Server[Locked] == 1)
		{
			
			format(str, sizeof(str), "password %s", Server[Password]);
			SendRconCommand(str);
		}
		else if(Server[Locked] == 0)
		{
			SendRconCommand("password ");
		}
		format(str, sizeof(str), "hostname ");
		SendRconCommand(str);

		format(str, sizeof(str), "gamemodetext %s", Server[Version]);
		SendRconCommand(str);

		printf("[MYSQL]: Server Settings Loaded.", id);
	}
	else
	{
		print("ERROR: Loading Settings");
	}
	return 1;
}

