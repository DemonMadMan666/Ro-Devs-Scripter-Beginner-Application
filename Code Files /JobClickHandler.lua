local ReplicatedStorage = game:GetService("ReplicatedStorage")
local JobEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("JobEvent")
local player = game.Players.LocalPlayer

local npcPart = workspace:WaitForChild("NPC")
local clickDetector = npcPart:WaitForChild("ClickDetector")

clickDetector.MouseClick:Connect(function()
	JobEvent:FireServer("Harvest")
end)
