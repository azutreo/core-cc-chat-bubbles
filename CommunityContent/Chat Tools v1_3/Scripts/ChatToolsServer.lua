--[[
	Chat Tools internal script. Don't touch unless you know what you're doing!
	For config, check ChatToolsConfig, ChatToolsCommands and ChatToolsRegistry.
	For setup, check .README-ChatTools.

	Chat Tools server-side logic.
	If you're looking for a place to shove in your server-side logic that will also be
	executed outside of ChatToolsCommands this is a pretty good place to choose.
]]

local reg = require("8AABD1C384937A99:ChatToolsRegistry") -- ChatToolsRegistry
local config = require("58C494FFFB35C6C5:ChatToolsConfig") -- ChatToolsConfig
local Command = require("906BB9BC00D06B04:ChatToolsCommands")[2] -- ChatToolsCommands
local Send = require("70E8A836566FEDC4:ChatToolsRequire")[2] -- ChatToolsRequire
local data = {}
local nicked = {}

-- command call
function Execute(cmd, player)
	cmd = string.sub(cmd, 2)
	chunk = {}
	for sb in cmd:gmatch("%S+") do
		table.insert(chunk, sb)
	end
	if chunk[1] then
		chunk[1] = string.lower(chunk[1])
	else return end

	for i = 1, #chunk do
		if i > 1 then
			chunk[i] = string.gsub(chunk[i], "@me", player.name)
		end
	end

	local b = false
	for k, v in pairs(reg) do
		if k == chunk[1] then b = true break end
	end

	if b then
		Command(chunk, player)
	end
end

-- check message for commands / modify message
local function ReceiveMessage(player, par)
	if string.sub(par.message, 1, 1) == config.prefix then
		Execute(par.message, player)
	else
		local as = nicked[player.name] or player.name
		local s = ""
		local pl = config.perms[as] or config.defaultPerms
		for k, v in pairs(config.permLevels) do
			if v == pl then
				if v ~= config.defaultPerms then
					s = string.upper(k)
				end
			end
		end
		local mpl = ((s ~= "" and config.showPermLevel) and ("(" .. s .. ") ") or "")
		local mpr = ((config.shownResource) and ("[" .. player:GetResource(config.shownResource) .. "]") or "")
		par.speakerName = mpl .. (config.showResourceLeft and (mpr .. " ") or "") .. as .. (config.showResourceLeft and "" or (" " .. mpr))
	end
end
Chat.receiveMessageHook:Connect(ReceiveMessage)

-- used for ban data
function OnPlayerJoined(player)
	data[player.name] = Storage.GetPlayerData(player).ChatTools
	if not data[player.name] then
		data[player.name] = {banWhen = 0, banFor = 0}
	else
		if data[player.name].banWhen + data[player.name].banFor > os.time() then
			player:TransferToGame("e39f3e/home-world")
		end
	end
end
Game.playerJoinedEvent:Connect(OnPlayerJoined)

-- used for ban data
function OnPlayerLeft(player)
	local d = Storage.GetPlayerData(player)
	d.ChatTools = data[player.name] or {banWhen = 0, banFor = 0}
	Storage.SetPlayerData(player, d)
end
Game.playerLeftEvent:Connect(OnPlayerLeft)

-- bans a player
function BanPlayer(player, minutes)
	data[player.name].banWhen = os.time()
	data[player.name].banFor = minutes * 60
	Task.Wait()
	player:TransferToGame("e39f3e/home-world")
end
Events.Connect("BanPlayerEvent", BanPlayer)

-- nicks a player
function NickPlayer(player, nick)
	nicked[player.name] = nick
	Events.BroadcastToAllPlayers("NickPlayerEvent", player, nick)
end
Events.Connect("NickPlayerEvent", NickPlayer)
-- resets the nickname of a player
function UnnickPlayer(player)
	nicked[player.name] = nil
	Events.BroadcastToAllPlayers("UnnickPlayerEvent", player)
end
Events.Connect("UnnickPlayerEvent", UnnickPlayer)