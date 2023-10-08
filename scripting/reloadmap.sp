#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>

#define PLUGIN_NAME "(Re)Load Map"
#define PLUGIN_AUTHOR "JoinedSenses"
#define PLUGIN_DESCRIPTION "(Re)loads the map"
#define PLUGIN_VERSION "0.1.2"
#define PLUGIN_URL "https://alliedmods.net"

public Plugin myinfo = {
	name = PLUGIN_NAME,
	author = PLUGIN_AUTHOR,
	description = PLUGIN_DESCRIPTION,
	version = PLUGIN_VERSION,
	url = PLUGIN_URL
}

public void OnPluginStart() {
	CreateConVar(
		"sm_reloadmap_version",
		PLUGIN_VERSION,
		PLUGIN_DESCRIPTION,
		FCVAR_SPONLY|FCVAR_NOTIFY|FCVAR_DONTRECORD
	).SetString(PLUGIN_VERSION);

	RegAdminCmd("sm_reloadmap", cmdReloadMap, ADMFLAG_ROOT);
	RegAdminCmd("sm_changelevel", cmdChangeLevel, ADMFLAG_ROOT);

	// Test command
	RegAdminCmd("sm_doesmapexist", cmdDoesMapExist, ADMFLAG_ROOT);
}

public Action cmdReloadMap(int client, int args) {
	char mapName[80];
	GetCurrentMap(mapName, sizeof(mapName));

	PrintToChatAll("Reloading current map");

	ForceChangeLevel(mapName, "sm_reloadmap map");

	return Plugin_Handled;
}

public Action cmdChangeLevel(int client, int args) {
	char arg[80];
	GetCmdArg(1, arg, sizeof(arg));

	char name[80];
	if (
		FindMap(arg, name, sizeof(name)) == FindMap_Found
		|| StrEqual(arg, name, false)
	) {
		PrintToChatAll("Changing to map %s", arg);

		ForceChangeLevel(arg, "sm_changelevel map");
	}
	else {
		ReplyToCommand(client, "Map %s not found", arg);
	}

	return Plugin_Handled;
}

public Action cmdDoesMapExist(int client, int args) {
	char arg[80];
	GetCmdArg(1, arg, sizeof(arg));

	char name[80];

	FindMapResult r = FindMap(arg, name, sizeof(name));
	ReplyToCommand(client, "%i %s", r, name);

	return Plugin_Handled;
}