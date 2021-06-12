--[[

	For problems, bugs etc. ping me on discord.
		@chipnertkj#5685

	-----------------------------------------------
	Setup:

	Just put the Chat Tools template somewhere in your hierarchy (root preferably).

	\/ \/ \/ \/
	FIRST CHECK IF IT WORKS IF NOT JUST FOLLOW THIS
	/\ /\ /\ /\

	While I could avoid making you go through this setup process, it would make me unable to use require() inside of an already "required" script,
	basically meaning that I'd have to copy-paste half of the code, like, 13 times. Unacceptable. Do you realize how much harder to edit a codebase
	like this becomes when whenever you want to change a value that's used between scripts you have to edit it in 14 different places?

	Anyway, here it is:
		1. Open ChatToolsCommands, ChatToolsRegistry, ChatToolsServer, ChatToolsConfig, ChatToolsClient and ChatToolsRequire
		2. In each of these scripts REPLACE the MUIDs inside of require() calls (they look like this: require("8AABD1C384937A99:ChatToolsRegistry"))
		   with the MUIDs of ChatTools scripts in your Project Content scripts. I marked with comments which MUID goes where.
		   To get MUIDs from scripts just right click on them and press "Copy MUID".
		   It's similar to how you would spawn assets with World.SpawnAsset().

	-----------------------------------------------
	After you're done with that, you can configurate the chat system in ChatToolsConfig, ChatToolsCommands and ChatToolsRegistry.
]]