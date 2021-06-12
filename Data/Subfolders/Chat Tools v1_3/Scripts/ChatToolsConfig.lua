--[[
	Configuration script for Chat Tools.
	Here you can:
		- Configurate Chat Tools
		- Disable or enable Chat Tools features
		- Configurate command permissions
		- Change or disable built-in messages

	Legend:
		[local] - Client-side messages. Can use client tags (<player> etc.)
		[global] - Server-side messages, broadcasted to all clients. Can use server tags.

	Tags:
		client:
			<player> - Local players name.
			<players> - Player count.
			<game> - Game name.
		server:
			<players> - Player count.
			<game> - Game name.
	
	Tips:
		- You can use the data from this script in your own scripts, just require() it and save the result.
		- You can add your own messages below the welcome message and access them in ChatToolsCommands afterwards.
		- You can use tags in your messages (example: <this is a tag>) that Chat Tools will replace with corresponding strings.
		- You can add your own tags if you're capable enough. The functions that handle tags are located in ChatToolsRequire,
		  you should be able to figure out how that works.
		- You can set a message to nil to disable it completely.
		- You can add your own permission levels in permLevels, just dont remove any that are already in here, otherwise
		  something might break and then you'll have to fix it.

	NOTES:
		- CHAT TOOLS USES STORAGE TO SAVE BAN DATA. It will autonomously load data from storage, overwrite (storage).ChatTools
		  and then instantly upload it whenever a player leaves.
]]

config = {}

-----------------------------------------------
---------- PERMISSIONS:
config.permLevels = {user = 1, vip = 2, mod = 3, admin = 4, owner = 5}
config.defaultPerms = config.permLevels.user
config.perms = {
	Chipnertkj = config.permLevels.vip,	-- Couldn't resist :)
										-- At least it's a good way to show how perms should be assigned to players.
}
-----------------------------------------------

-----------------------------------------------
---------- CONFIG:
-- Show config reminder on start (you totally don't need this, just disable it)
config.reminder = true

----- Commands:
-- Command prefix used to call commands in chat
config.prefix = "/"
-- Used as the <game> tag. You can use CorePlatform.GetGameInfo(id).name to directly request a game name from Core
config.gameName = "PLACEHOLDER GAME NAME"

----- Chat:
-- Show perm levels of players next to their name in chat
config.showPermLevel = true
-- Display a player resource next to player names (nil to disable, resource name to enable)
config.shownResource = nil
-- Display the resource value to the left of the nickname (false == right)
config.showResourceLeft = true
-- Subtly display my name when Chat Tools starts up. Thanks!
config.attribution = true

----- Chat Bubbles:
-- Display chat bubbles above players
config.chatBubbles = true
-- The time it takes for a bubble to disappear (seconds)
config.bubbleTime = 7
-- The amount of bubbles that can be stacked on top of the player at the same time
config.bubbleStack = 4
-- Display bubbles above local player
config.bubblesShowLocal = false

----- Nameplates:
-- Display nicknames above players
config.nameplates = true
-- Display nameplate above local player
config.nameplatesShowLocal = false
-----------------------------------------------

-----------------------------------------------
---------- MESSAGES:
-- [local] Sent on startup.
config.welcomeMessage = "Welcome <player> to <game>!\n"
-----------------------------------------------

-- return value for use in external scripts
return config