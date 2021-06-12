--[[
	Commands implementation for Chat Tools.
	Here you can:
		- Implement your client-side and server-side commands

	NOTE: Adding your own commands requires at least some lua experience. Modify at your own risk.
]]
--[=[
	To add a command, simply copy this template:

			elseif cmd[1] == "mycommandname" then	-- your own command 
				-- instructions
			end


	And paste it in - depending on your requirements - either CLIENT() or SERVER()
	(or both if you want client and server implementations), after one of the commands.
	Inside should be the instructions you want Chat Tools to perform once the command is called.

	Both client and server command functions supply you with a table called cmd which holds:
		cmd[1] 	 - The command name used by a player (e.g. "ban").
		cmd[> 1] - Additional arguments supplied by the player (e.g. "user20194").

	You can access (read from, not write to) the config and registry tables from this file, using variables reg and config.
	You can check their structures in their respective files.
]=]

-- setup
local reg = require("9A9F0E35B51C0EAE:ChatToolsRegistry") -- ChatToolsRegistry
local config = require("A8F6566648DEAFBB:ChatToolsConfig") -- ChatToolsConfig
local SendClient, SendServer, Player
do
	local r = require("D0BB6A729CC83400:ChatToolsRequire") -- ChatToolsRequire
	SendClient = r[1]
	SendServer = r[2]
	Player = r[3]
end

-- perm check function
function Perm(cmd, player)
	return (config.perms[player.name] or config.defaultPerms) >= reg[cmd].perm
end

-- CLIENT-SIDE COMMAND EXECUTION
function CLIENT(cmd, player)
	if not Perm(cmd[1], player) then
		SendClient("Insufficient permissions.")
		return
	elseif cmd[1] == "help" then	-- help 
		if cmd[2] then
			local s
			if reg[cmd[2]] then
				s = "- " .. cmd[2] .. " " .. reg[cmd[2]].desc
			else
				SendClient("Unregistered command \"" .. config.prefix .. cmd[2] .. "\".")
			end
			SendClient(s)
		else
			SendClient("\nTip: You can replace your nickname with @me in arguments.\n")
			local s = "Available Commands:"
			SendClient(s)
			for k, v in pairs(reg) do
				if (config.perms[player.name] or config.defaultPerms) >= reg[k].perm then
					s = "\t- " .. k .. " \n" .. v.desc
					SendClient(s)
				end
			end
		end
	elseif cmd[1] == "kick" then	-- kick
		if cmd[2] then
			local pl = Player(cmd[2])
			if pl then
				SendClient("Player " .. pl.name .. " has been kicked to Home World.")
			else
				SendClient("Argument \"player\" (1) has to be a player.")
			end
		else
			SendClient("Argument \"player\" (1) is missing.")
		end
	elseif cmd[1] == "ban" then		-- ban
		if cmd[2] then
			if cmd[3] then
				local pl = Player(cmd[2])
				if pl then
					if tonumber(cmd[3]) then
						if (config.perms[pl.name] or config.defaultPerms) ~= config.permLevels.owner then
							if (config.perms[pl.name] or config.defaultPerms) > (config.perms[player.name] or config.defaultPerms) then
								if tonumber(cmd[3]) <= 86400 then
									SendClient(cmd[2] .. " has been banned from this game for " .. cmd[3] .. " minutes (" .. math.floor((cmd[3]/60*100))/100 .. " hours).")
								else
									SendClient("Argument \"minutes\" (2) is too big (max. = 86400).")
								end
							else
								SendClient("Insufficient permissions. This player has a higher permission level than you.")
							end
						else
							SendClient("You cannot ban the owner of this game.")
						end
					else
						SendClient("Argument \"minutes\" (2) isn't a number.")
					end
				else
					SendClient("Argument \"player\" (1) isn't a player or is offline.")
				end
			else
				SendClient("Argument \"minutes\" (2) is missing.")
			end
		else
			SendClient("Argument \"player\" (1) is missing.")
		end
	elseif cmd[1] == "fly" then	-- fly
		if not cmd[2] then cmd[2] = player.name end
		if cmd[2] then
			local pl = Player(cmd[2])
			if pl then
				SendClient("Flying toggled for " .. cmd[2] .. ".")
			else
				SendClient("Argument \"player\" (1) has to be a player.")
			end
		else
			SendClient("Argument \"player\" (1) is missing.")
		end
	elseif cmd[1] == "kill" then	-- kill
		if not cmd[2] then cmd[2] = player.name end
		if cmd[2] then
			local pl = Player(cmd[2])
			if pl then
				SendClient("Killed " .. pl.name .. ".")
			else
				SendClient("Argument \"player\" (1) has to be a player.")
			end
		else
			SendClient("Argument \"player\" (1) is missing.")
		end
	elseif cmd[1] == "tp" then	-- tp
		if not cmd[3] then cmd[3] = cmd[2] cmd[2] = player.name end
		if cmd[2] then
			if cmd[3] then
				local pl, plTo = Player(cmd[2], cmd[3])
				if pl then
					if plTo then
						SendClient("Teleporting " .. pl.name .. " to " .. plTo.name .. ".")
					else
						SendClient("Argument \"playerTo\" (2) has to be a player.")
					end
				else
					SendClient("Argument \"player\" (1) has to be a player.")
				end
			else
				SendClient("Argument \"playerTo\" (2) is missing.")
			end
		else
			SendClient("Argument \"player\" (1) is missing.")
		end
	elseif cmd[1] == "nick" then	-- nick -- NOTE: Impersonation is against Core's Code of Conduct. This command was addded for moderation purposes.
		if not cmd[3] then cmd[3] = cmd[2] cmd[2] = player.name end
		if cmd[2] then
			if cmd[3] then
				local pl = Player(cmd[2])
				if pl then
					SendClient("Nicked player " .. cmd[2] .. " as \"" .. cmd[3] .. "\".")
				else
					SendClient("Argument \"player\" (1) has to be a player.")
				end
			else
				SendClient("Argument \"nick\" (2) is missing.")
			end
		else
			SendClient("Argument \"player\" (1) is missing.")
		end
	elseif cmd[1] == "unnick" then	-- unnick
		if not cmd[2] then cmd[2] = player.name end
		if cmd[2] then
			local pl = Player(cmd[2])
			if pl then
				SendClient("Nickname reset for " .. cmd[2] .. ".")
			else
				SendClient("Argument \"player\" (1) has to be a player.")
			end
		else
			SendClient("Argument \"player\" (1) is missing.")
		end
	elseif cmd[1] == "respawn" then	-- respawn
		if not cmd[2] then cmd[2] = player.name end
		if cmd[2] then
			local pl = Player(cmd[2])
			if pl then
				SendClient("Respawned " .. cmd[2] .. ".")
			else
				SendClient("Argument \"player\" (1) has to be a player.")
			end
		else
			SendClient("Argument \"player\" (1) is missing.")
		end
	elseif cmd[1] == "ragdoll" then	-- ragdoll
		if not cmd[3] then cmd[3] = cmd[2] cmd[2] = player.name end
		if cmd[2] then
			if cmd[3] then
				local pl = Player(cmd[2])
				if pl then
					if cmd[3] == "true" then
						SendClient("Enabled ragdoll for " .. cmd[2] .. ".")
					elseif cmd[3] == "false" then
						SendClient("Disabled ragdoll for " .. cmd[2] .. ".")
					else
						SendClient("Argument \"enable\" (2) has to be a bool.")
					end
				else
					SendClient("Argument \"player\" (1) has to be a player.")
				end
			else
				SendClient("Argument \"enable\" (2) is missing.")
			end
		else
			SendClient("Argument \"player\" (1) is missing.")
		end
	elseif cmd[1] == "fling" then	-- fling
		if not cmd[3] then cmd[3] = cmd[2] cmd[2] = player.name end
		if cmd[2] then
			if cmd[3] then
				local pl = Player(cmd[2])
				if pl then
					if tonumber(cmd[3]) then
						SendClient("Flinged " .. cmd[2] .. ".")
					else
						SendClient("Argument \"power\" (2) has to be a number.")
					end
				else
					SendClient("Argument \"player\" (1) has to be a player.")
				end
			else
				SendClient("Argument \"power\" (2) is missing.")
			end
		else
			SendClient("Argument \"player\" (1) is missing.")
		end
	end
end

-- SERVER-SIDE COMMAND EXECUTION
function SERVER(cmd, player)
	if not Perm(cmd[1], player) then
		return
	elseif cmd[1] == "kick" then	-- kick
		if cmd[2] then
			local pl = Player(cmd[2])
			if pl then
				pl:TransferToGame("e39f3e/home-world")
			end
		end
	elseif cmd[1] == "ban" then		-- ban
		if cmd[2] then
			if cmd[3] then
				local pl = Player(cmd[2])
				if pl then
					if tonumber(cmd[3]) then
						if config.perms[pl.name] ~= config.permLevels.owner then
							if config.perms[pl.name] > config.perms[player.name] then
								if tonumber(cmd[3]) <= 86400 then
									Events.Broadcast("BanPlayerEvent", pp, cmd[3])
								end
							end
						end
					end
				end
			end
		end
	elseif cmd[1] == "fly" then	-- fly
		if not cmd[2] then cmd[2] = player.name end
		if cmd[2] then
			local pl = Player(cmd[2])
			if pl then
				if pl.isFlying then
					pl:ActivateWalking()
				else
					pl:ActivateFlying()
				end
			end
		end
	elseif cmd[1] == "kill" then	-- kill
		if not cmd[2] then cmd[2] = player.name end
		if cmd[2] then
			local pl = Player(cmd[2])
			if pl then
				pl:Die()
			end
		end
	elseif cmd[1] == "tp" then	-- tp
		if not cmd[3] then cmd[3] = cmd[2] cmd[2] = player.name end
		if cmd[2] then
			if cmd[3] then
				local pl, plTo = Player(cmd[2], cmd[3])
				if plTo then
					if bb then
						pl:SetWorldPosition(plTo:GetWorldPosition())
					end
				end
			end
		end
	elseif cmd[1] == "nick" then	-- nick
		if not cmd[3] then cmd[3] = cmd[2] cmd[2] = player.name end
		if cmd[2] then
			if cmd[3] then
				local pl = Player(cmd[2])
				if pl then
					Events.Broadcast("NickPlayerEvent", pl, cmd[3])
				end
			end
		end
	elseif cmd[1] == "unnick" then	-- unnick
		if not cmd[2] then cmd[2] = player.name end
		if cmd[2] then
			local pl = Player(cmd[2])
			if pl then
				Events.Broadcast("UnnickPlayerEvent", pl)
			end
		end
	elseif cmd[1] == "respawn" then	-- respawn
		if not cmd[2] then cmd[2] = player.name end
		if cmd[2] then
			local pl = Player(cmd[2])
			if pl then
				pl:Respawn()
			end
		end
	elseif cmd[1] == "ragdoll" then	-- ragdoll
		if not cmd[3] then cmd[3] = cmd[2] cmd[2] = player.name end
		if cmd[2] then
			if cmd[3] then
				local pl = Player(cmd[2])
				if pl then
					if cmd[3] == "true" then
						pl:EnableRagdoll()
					elseif cmd[3] == "false" then
						pl:DisableRagdoll()
					end
				end
			end
		end
	elseif cmd[1] == "fling" then	-- fling
		if not cmd[3] then cmd[3] = cmd[2] cmd[2] = player.name end
		if not cmd[3] then cmd[3] = 20 end
		if cmd[2] then
			if cmd[3] then
				local pl = Player(cmd[2])
				if pl then
					if tonumber(cmd[3]) then
						pl:AddImpulse(Vector3.New(math.random(-100, 100), math.random(-100, 100), 100)*tonumber(cmd[3])*10)
					end
				end
			end
		end
	end
end

-- return value for use in external scripts
return {CLIENT, SERVER}