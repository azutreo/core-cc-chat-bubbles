local RootGroup = script:GetCustomProperty("RootGroup"):WaitForObject()

local UserInterface = script:GetCustomProperty("UserInterface"):WaitForObject()

local ChatBubbleTemplate = script:GetCustomProperty("ChatBubbleTemplate")
local PlayerInterfaceTemplate = script:GetCustomProperty("PlayerInterfaceTemplate")
local PlayerHeadTemplate = script:GetCustomProperty("PlayerHeadTemplate")

local MAX_WIDTH = RootGroup:GetCustomProperty("MaxWidth")
local MAX_HEIGHT = RootGroup:GetCustomProperty("MaxHeight")
local FONT_SIZE = RootGroup:GetCustomProperty("FontSize")
local OFFSET = RootGroup:GetCustomProperty("Offset")
local SPACE_BETWEEN_BUBBLES = RootGroup:GetCustomProperty("SpaceBetweenBubbles")
local TIME_DISPLAY = RootGroup:GetCustomProperty("DisplayTime")

local playerPanels = {}

local function SortPlayerBubbles(player)
	local playerPanel = playerPanels[player]

	local previousBubble

	local children = playerPanel.panel:GetChildren()

	for index = #children, 1, -1 do
		local bubble = children[index]

		if previousBubble then
			bubble.y = previousBubble.y - previousBubble.height - SPACE_BETWEEN_BUBBLES
		else
			bubble.y = -FONT_SIZE - 2
		end

		previousBubble = bubble
	end
end

local function CreateChatBubble(speaker, message)
	local chatBubble = World.SpawnAsset(ChatBubbleTemplate, {
		parent = playerPanels[speaker].panel
	})

	chatBubble.y = -10000

	local text, backgroundLeft, backgroundRight =
		chatBubble:GetCustomProperty("Text"):WaitForObject(),
		chatBubble:GetCustomProperty("LeftBackground"):WaitForObject(),
		chatBubble:GetCustomProperty("RightBackground"):WaitForObject()

	text.fontSize = FONT_SIZE
	text.text = message

	local textSize = text:ComputeApproximateSize()
	while not textSize or textSize.x > MAX_WIDTH do
		textSize = text:ComputeApproximateSize()
		Task.Wait()
	end

	chatBubble.width = textSize.x + (FONT_SIZE * 1.5)
	chatBubble.height = textSize.y + FONT_SIZE

	backgroundLeft.width = chatBubble.height
	backgroundRight.width = chatBubble.height

	chatBubble.visibility = Visibility.INHERIT
	chatBubble.y = 0

	table.insert(playerPanels[speaker].bubbles, {
		bubble = chatBubble,
		time = time()
	})

	SortPlayerBubbles(speaker)
end

local function OnMessage(speaker, parameters)
	local message = parameters.message

	Task.Spawn(function()
		CreateChatBubble(speaker, message)
	end)
end

local function OnPlayerJoined(player)
	local equipment = World.SpawnAsset(PlayerHeadTemplate)
	equipment:Equip(player)

	local panel = World.SpawnAsset(PlayerInterfaceTemplate, {
		parent = UserInterface
	})

	panel.name = player.name
	panel.width = MAX_WIDTH
	panel.height = MAX_HEIGHT

	playerPanels[player] = {
		panel = panel,
		bubbles = {}
	}
end

local function OnPlayerLeft(player)
	if not playerPanels[player] then
		return
	end

	playerPanels[player].panel:Destroy()
	playerPanels[player] = nil
end

local function UpdatePlayerPanelPosition(player)
	local playerEquipment = player:GetEquipment()

	local headEquipment
	for _, equipment in pairs(playerEquipment) do
		if equipment.name == "ChatBubbles_Head" then
			headEquipment = equipment
			break
		end
	end

	if not headEquipment then
		return
	end

	local cube = headEquipment:GetCustomProperty("Cube"):WaitForObject()

	local screenPosition = UI.GetScreenPosition(cube:GetWorldPosition() + Vector3.New(0, 0, OFFSET))

	local playerPanel = playerPanels[player].panel
	playerPanel.x = screenPosition.x
	playerPanel.y = screenPosition.y
end

local function DeleteOldBubbles(player, changed)
	local playerBubbles = playerPanels[player].bubbles

	for index, bubble in ipairs(playerBubbles) do
		if (time() - bubble.time) >= TIME_DISPLAY then
			bubble.bubble:Destroy()
			table.remove(playerBubbles, index)

			return DeleteOldBubbles(player, true)
		end
	end

	if changed then
		SortPlayerBubbles(player)
	end
end

function Tick()
	for _, player in ipairs(Game.GetPlayers()) do
		UpdatePlayerPanelPosition(player)
		DeleteOldBubbles(player)
	end
end

Chat.receiveMessageHook:Connect(OnMessage)

Game.playerJoinedEvent:Connect(OnPlayerJoined)
Game.playerLeftEvent:Connect(OnPlayerLeft)