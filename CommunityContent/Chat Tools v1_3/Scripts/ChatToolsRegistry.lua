--[[
	Command Registry for Chat Tools.
	Here you can:
		- Register commands added in ChatToolsCommands

	To register a command, use Add() with arguments:
		- name (command name as used in chat, *without the prefix*)
		- level (permission level required to use the command, e.g. permLevels.user)
		- desc (command description, displayed using the built-in help command)
]]

local config = require("58C494FFFB35C6C5:ChatToolsConfig") -- ChatToolsConfig
local cmds = {}

-- registers a command in the system
function Add(name, level, desc)
	if not name then error("name == nil?") end
	if name == "" then error("name cannot be \"\"") end
	cmds[name] = {perm = level or 1, desc = desc or ""}
end

-- REGISTER HERE \/\/\/

Add("help", config.permLevels.user, "[(command)] - Displays help for Chat Tools commands.")
Add("kick", config.permLevels.mod, "(player) - Kicks the specified player to Home World.")
Add("ban", config.permLevels.mod, "(player) (minutes) - Temporarily bans a player from your game.")
Add("kill", config.permLevels.admin, "[(player)] - Kills the specified player.")
Add("fly", config.permLevels.admin, "[(player)] - Toggles flying for a player.")
Add("tp", config.permLevels.mod, "[(player)] (playerTo) - Teleports a player to another player.")
Add("nick", config.permLevels.vip, "[(player)] (nick) - Changes a players nickname.") -- NOTE: Impersonation is against Core's Code of Conduct. This command was addded for moderation purposes.
Add("unnick", config.permLevels.vip, "[(player)] - Resets a players nickname.")
Add("respawn", config.permLevels.admin, "[(player)] - Respawns a player.")	-- may require respawn settings in hierarchy
Add("ragdoll", config.permLevels.admin, "[(player)] (enable) - Enables/disables ragdoll for a player.")
Add("fling", config.permLevels.admin, "[(player)] (power) - Flings a player in a random direction with specified power.")

-- REGISTER HERE /\/\/\

-- return value for use in external scripts
return cmds