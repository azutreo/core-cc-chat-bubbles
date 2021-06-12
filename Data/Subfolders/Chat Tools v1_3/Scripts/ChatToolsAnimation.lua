--[[
	Chat Tools internal script. Don't touch unless you know what you're doing!
	For config, check ChatToolsConfig, ChatToolsCommands and ChatToolsRegistry.
	For setup, check .README-ChatTools.

	Chat Tools client-side animation.
]]

Task.Wait(4)
local speed = 0.05
function Tick()
	speed = speed * 1.3
	script.parent.y = script.parent.y + speed
	if script.parent.y >= 100 then
		script.parent:Destroy()
	end
end