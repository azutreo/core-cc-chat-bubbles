--[[
	Chat Tools internal script. Don't touch unless you know what you're doing!
	For config, check ChatToolsConfig, ChatToolsCommands and ChatToolsRegistry.
	For setup, check .README-ChatTools.

	Chat Tools client-side logic.
]]

local reg = require("8AABD1C384937A99:ChatToolsRegistry") -- ChatToolsRegistry
local config = require("58C494FFFB35C6C5:ChatToolsConfig") -- ChatToolsConfig
local Command = require("906BB9BC00D06B04:ChatToolsCommands")[1] -- ChatToolsCommands
local Send, Player
do
	local r = require("70E8A836566FEDC4:ChatToolsRequire") -- ChatToolsRequire
	Send = r[1]
	Player = r[3]
end

local lplayer = Game.GetLocalPlayer()
local bubble = script:GetCustomProperty("BubbleTemplate")
local nameplate = script:GetCustomProperty("NameplateTemplate")
local bubbles = script.parent:FindChildByName("Bubbles")
local sizeTest = script.parent:FindDescendantByName("SizeTest")
local bubbleN = {}
local bubbleLeft = {}
local nameplates = {}
local nameplatesFolder = script.parent:FindChildByName("Nameplates")

-- tick
if config.chatBubbles or config.nameplates then
	if config.nameplates then
		function OnPlayerLeft(player)
			if nameplates[player.name] then
				nameplates[player.name]:Destroy()
				nameplates[player.name] = nil
			end
		end
		Game.playerLeftEvent:Connect(OnPlayerLeft)
		function OnNickPlayer(player, name)
			if nameplates[player.name] then
				nameplates[player.name]:FindChildByName("Text").text = name
				sizeTest.text = name
				local bg = nameplates[player.name]:FindChildByName("Background")
				local s = sizeTest:ComputeApproximateSize().x/160/7 + 0.1
				sc = bg:GetWorldScale()
				sc.y = s*0.8
				bg:SetWorldScale(sc)
			end
		end
		Events.Connect("NickPlayerEvent", OnNickPlayer)
		function OnUnnickPlayer(player)
			if nameplates[player.name] then
				nameplates[player.name]:FindChildByName("Text").text = player.name
				sizeTest.text = player.name
				local bg = nameplates[player.name]:FindChildByName("Background")
				local s = sizeTest:ComputeApproximateSize().x/160/7 + 0.1
				sc = bg:GetWorldScale()
				sc.y = s*0.8
				bg:SetWorldScale(sc)
			end
		end
		Events.Connect("UnnickPlayerEvent", OnUnnickPlayer)
	end

	function Tick(dt)
		-- nameplates
		if config.nameplates then
			local pl = Game.GetPlayers()
			for i = 1, #pl do
				if config.nameplatesShowLocal or (pl[i] ~= lplayer) then
					if nameplates[pl[i].name] == nil then
						nameplates[pl[i].name] = World.SpawnAsset(nameplate, {parent = nameplatesFolder})
						nameplates[pl[i].name].name = pl[i].name
						nameplates[pl[i].name]:FindChildByName("Text").text = pl[i].name
						sizeTest.text = pl[i].name
						local bg = nameplates[pl[i].name]:FindChildByName("Background")
						local s = sizeTest:ComputeApproximateSize().x/160/7 + 0.1
						sc = bg:GetWorldScale()
						sc.y = s*0.8
						bg:SetWorldScale(sc)
					end
					nameplates[pl[i].name]:LookAtLocalView()
					nameplates[pl[i].name]:SetWorldPosition(pl[i]:GetWorldPosition() + Vector3.UP * (125))
				end
			end
		end

		-- bubbles
		if config.chatBubbles then
			local b = bubbles:GetChildren()
			local n = #b
			for i = 1, n do
				bubbleLeft[b[i].name] = bubbleLeft[b[i].name] - dt
				if bubbleLeft[b[i].name] <= 0 then
					bubbleLeft[b[i].name] = nil
					b[i]:Destroy()
				else
					chunk = {}
					for sb in b[i].name:gmatch("%S+") do
						table.insert(chunk, sb)
					end
					if chunk[1] and chunk[2] then
						b[i]:LookAtLocalView(true)
						local p = Player(chunk[1])
						if p then
							b[i]:SetWorldPosition(p:GetWorldPosition() + Vector3.UP * (125 --[[p height]] + 50 --[[sep]] + 50*0.625*(tonumber(chunk[2]) - bubbleN[p.name])))
						else
							b[i]:Destroy()
						end
					else
						b[i]:Destroy()
					end
				end
			end
		end
	end
end

-- command call
local function Execute(cmd, player)
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
	else
		Send("Unregistered command \"" .. config.prefix .. chunk[1] .. "\".")
	end
end

-- check message for commands / modify message
local function ReceiveMessage(player, par)
	if string.sub(par.message, 1, 1) == config.prefix then
		if player == Game.GetLocalPlayer() then
			Execute(par.message, player)
		end
		par.message = ""
	else
		-- bubbles
		if config.chatBubbles then
			if config.bubblesShowLocal or (player.name ~= lplayer.name) then
				-- count
				local b = bubbles:GetChildren()
				local l = {}
				for i = 1, #b do
					chunk = {}
					for sb in b[i].name:gmatch("%S+") do
						table.insert(chunk, sb)
					end
					if chunk[1] and chunk[2] then
						if chunk[1] == player.name then
							table.insert(l, b[i])
						end
					end
				end
				-- stack clamp
				if #l >= config.bubbleStack then
					local max = bubbleN[player.name]
					for j = 1, math.max(0, #l-config.bubbleStack+1) do
						local cur, ccur
						for i = 1, #l do
							chunk = {}
							for sb in l[i].name:gmatch("%S+") do
								table.insert(chunk, sb)
							end
							if chunk[1] and chunk[2] then
								if tonumber(chunk[2]) > max then
									cur = l[i]
									ccur = i
									max = tonumber(chunk[2])
								end
							end
						end
						if cur then
							cur:Destroy()
							table.remove(l, ccur)
						end
					end
				end
				-- spawn
				bubbleN[player.name] = bubbleN[player.name] and bubbleN[player.name]-1 or 0
				local b = World.SpawnAsset(bubble, {parent = bubbles})
				b.name = player.name .. " " .. bubbleN[player.name]
				bubbleLeft[b.name] = config.bubbleTime
				local nm = string.sub(par.message, 0, 40)
				b:FindChildByName("Text").text = nm
				sizeTest.text = nm
				local bg = b:FindChildByName("Background")
				local s = sizeTest:ComputeApproximateSize().x/160/7 + 0.1
				local sc = bg:GetWorldScale()
				sc.y = s
				bg:SetWorldScale(sc)
			end
		end
	end
end
Chat.receiveMessageHook:Connect(ReceiveMessage)

-- setup
-- init message
Send("Chat Tools" .. (config.attribution and " by Chipnertkj" or "") .. " (v1.3) running...\nCommand prefix: " .. config.prefix)
-- perms info
do
	local s
	local pl = config.perms[Game.GetLocalPlayer().name] or config.defaultPerms
	for k, v in pairs(config.permLevels) do
		if v == pl then
			s = k
		end
	end
	script.parent:FindDescendantByName("Perm").text = "(" .. s .. ")"
	if pl ~= config.defaultPerms then
		Send("Permission level: " .. string.upper(s))
	end
end
-- welcome message
Send("\n" .. config.welcomeMessage)
-- config reminder
if config.reminder then
	Send("\n" .. "Configurate Chat Tools in the ChatToolsConfig script. You can disable this reminder there.")
end