local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local JobEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("JobEvent")
local JobFunction = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("JobFunction")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- UI Setup
local screen = Instance.new("ScreenGui", PlayerGui)
screen.Name = "JobUI"

local jobLabel = Instance.new("TextLabel", screen)
jobLabel.Size = UDim2.new(0, 200, 0, 30)
jobLabel.Position = UDim2.new(0, 10, 0, 10)
jobLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
jobLabel.TextColor3 = Color3.new(1,1,1)
jobLabel.Text = "Loading Job..."

local levelLabel = Instance.new("TextLabel", screen)
levelLabel.Size = UDim2.new(0, 200, 0, 30)
levelLabel.Position = UDim2.new(0, 10, 0, 50)
levelLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
levelLabel.TextColor3 = Color3.new(1,1,1)
levelLabel.Text = "Level: ?"

local xpBar = Instance.new("Frame", screen)
xpBar.Size = UDim2.new(0, 200, 0, 20)
xpBar.Position = UDim2.new(0, 10, 0, 90)
xpBar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

local fill = Instance.new("Frame", xpBar)
fill.Size = UDim2.new(0, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

-- Update UI
local function updateUI(data)
	jobLabel.Text = "Job: " .. data.Job
	levelLabel.Text = "Level: " .. data.Level

	local jobInfo = require(ReplicatedStorage.Modules.JobModule).JobData[data.Job]
	local requiredXP = jobInfo.XPPerLevel * data.Level
	local ratio = math.clamp(data.XP / requiredXP, 0, 1)
	fill.Size = UDim2.new(ratio, 0, 1, 0)
end

-- Initial pull
local initialData
repeat
	initialData = JobFunction:InvokeServer("GetData")
	task.wait(0.2)
until initialData and initialData.Job

updateUI(initialData)

JobEvent.OnClientEvent:Connect(updateUI)
