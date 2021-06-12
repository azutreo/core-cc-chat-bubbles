--[[
	Chat Tools internal script. Don't touch unless you know what you're doing!
	For config, check ChatToolsConfig, ChatToolsCommands and ChatToolsRegistry.
	For setup, check .README-ChatTools.

	Chat Tools shared data.
]]

local config = require("58C494FFFB35C6C5:ChatToolsConfig") -- ChatToolsConfig

-- local message broadcast
function ClientSend(str)
	if not str then return end
	str = string.gsub(str, "<player>", Game.GetLocalPlayer().name)
	str = string.gsub(str, "<players>", tostring(#Game.GetPlayers()))
	str = string.gsub(str, "<game>", config.gameName)
	Chat.LocalMessage(str)
end

-- global message broadcast
function ServerSend(str)
	if not str then return end
	str = string.gsub(str, "<players>", tostring(#Game.GetPlayers()))
	str = string.gsub(str, "<game>", config.gameName)
	Chat.BroadcastMessage(str)
end

-- returns players that match the supplied nicknames
function Player(n1, n2)
	local pl = Game.GetPlayers()
	local r1, r2
	for i = 1, #pl do
		if pl[i].name == n1 then
			r1 = pl[i]
		end
		if pl[i].name == n2 then
			r2 = pl[i]
		end
	end
	return r1, r2
end

-- return value for use in external scripts
return {ClientSend, ServerSend, Player}