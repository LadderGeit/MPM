#include <amxmodx>

#define pluginName "MOTD Private Message [MPM]"
#define pluginVersion "1.0.0"
#define pluginAuthor "LadderGoat"

#if AMXX_VERSION_NUM < 183
	#define MAX_NAME_LENGTH 32
#endif

#define MAX_MESSAGE_LENGTH 256
#define MAX_MOTD_LENGTH 1536

#pragma semicolon 1

enum _: pcvarSettings
{
	ADMINS_ONLY,
	ADMIN_PREFIX,
	ADMIN_FLAGS,
	CHAT_PREFIX,
	PLAYER_PREFIX
};

new pcvarStored[pcvarSettings];

public plugin_init() {
	register_plugin(pluginName, pluginVersion, pluginAuthor);

	register_clcmd("mpm", "send_message", _, "<player> <message> - user sends a message to another user.");

	pcvarStored[ADMINS_ONLY] = register_cvar("mpm_adminsonly", "1");
	pcvarStored[ADMIN_PREFIX] = register_cvar("mpm_adminprefix", "ADMIN");
	pcvarStored[ADMIN_FLAGS] = register_cvar("mpm_adminflags", "b");
	pcvarStored[CHAT_PREFIX] = register_cvar("mpm_chatprefix", "AMXX");
	pcvarStored[PLAYER_PREFIX] = register_cvar("mpm_playerprefix", "PLAYER");
}

public send_message(id) 
{
	new chatPrefix[MAX_NAME_LENGTH];
	get_pcvar_string(pcvarStored[CHAT_PREFIX], chatPrefix, charsmax(chatPrefix));

	if(get_pcvar_num(pcvarStored[ADMINS_ONLY]))
	{
		if(!has_user_flags(id))
		{
			client_print_color(id, print_team_default, "^4[%s] ^1You have no access to this command.", chatPrefix);
			return PLUGIN_HANDLED;
		}
	}

	new fullCommand[MAX_MESSAGE_LENGTH];
	read_args(fullCommand, charsmax(fullCommand));
	remove_quotes(fullCommand);
	trim(fullCommand);

	new messageReceiver[MAX_NAME_LENGTH];
	new privateMessage[MAX_MESSAGE_LENGTH];
	split(fullCommand, messageReceiver, charsmax(messageReceiver), privateMessage, charsmax(privateMessage), " ");

	if(!messageReceiver[0] || !privateMessage[0])
	{
		client_print_color(id, print_team_default, "^4[%s] ^1mpm <player> <your message>", chatPrefix);
		return PLUGIN_HANDLED;
	}

	new receiverIndex = find_player("bhl", messageReceiver);

	if(!receiverIndex)
	{
		client_print_color(id, print_team_default, "^4[%s] ^1There was no player found matching that criteria.", chatPrefix);
		client_print_color(id, print_team_default, "^4[%s] ^1Search criteria: ^4%s", chatPrefix, messageReceiver);
		return PLUGIN_HANDLED;
	}

	if(is_user_alive(receiverIndex))
	{
		client_print_color(id, print_team_default, "^4[%s] ^1Players who are alive cannot receive any messages.", chatPrefix);
		return PLUGIN_HANDLED;
	}

	new adminPrefix[MAX_NAME_LENGTH];
	new playerPrefix[MAX_NAME_LENGTH];
	get_pcvar_string(pcvarStored[ADMIN_PREFIX], adminPrefix, charsmax(adminPrefix));
	get_pcvar_string(pcvarStored[PLAYER_PREFIX], playerPrefix, charsmax(playerPrefix));

	new senderName[MAX_NAME_LENGTH];
	new receiverName[MAX_NAME_LENGTH];
	get_user_name(id, senderName, charsmax(senderName));
	get_user_name(receiverIndex, receiverName, charsmax(receiverName));
	
	new messageTitle[MAX_MESSAGE_LENGTH];
	formatex(messageTitle, charsmax(messageTitle), "PM FROM: [%s] %s", has_user_flags(id) ? adminPrefix : playerPrefix, senderName);

	new fullMessage[MAX_MOTD_LENGTH];
	formatex(fullMessage, charsmax(fullMessage), "<html><body style=^"background-color: #1f1f1f;^"><p style=^"color: #e0e0e0; font-family: Helvetica;^"><span style=^"color: #00ff00; font-weight: bold;^">[%s]</span> %s: %s</p></body></html>", has_user_flags(id) ? adminPrefix : playerPrefix, senderName, privateMessage);

	show_motd(receiverIndex, fullMessage, messageTitle);

	client_print_color(id, print_team_default, "^4[%s] ^1Message successfully sent to ^4%s!", chatPrefix, receiverName);

	return PLUGIN_HANDLED;
}

bool: has_user_flags(id)
{
	new requiredFlags[MAX_NAME_LENGTH];
	get_pcvar_string(pcvarStored[ADMIN_FLAGS], requiredFlags, charsmax(requiredFlags));
		
	return (get_user_flags(id) & read_flags(requiredFlags)) ? true : false;
}