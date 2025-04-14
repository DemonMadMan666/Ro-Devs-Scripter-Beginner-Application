local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local JobFunction = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("JobFunction")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "JobChangeGui"

-- Create button
local changeButton = Instance.new("TextButton", gui)
changeButton.Size = UDim2.new(0, 120, 0, 40)
changeButton.Position = UDim2.new(0, 50, 0, 200)
changeButton.Text = "Change Job"
changeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
changeButton.TextColor3 = Color3.new(1, 1, 1)
changeButton.TextSize = 10
changeButton.AutoButtonColor = true

-- Job list UI builder
local function showJobSelector()
	local screen = Instance.new("ScreenGui", player.PlayerGui)
	screen.Name = "JobSelectorUI"

	local frame = Instance.new("Frame", screen)
	frame.Size = UDim2.new(0, 300, 0, 150)
	frame.Position = UDim2.new(0.5, -150, 0.5, -75)
	frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	local label = Instance.new("TextLabel", frame)
	label.Text = "Select Your New Job"
	label.Size = UDim2.new(1, 0, 0, 40)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1, 1, 1)

	local jobs = {"Farmer", "Miner"}

	for i, jobName in ipairs(jobs) do
		local button = Instance.new("TextButton", frame)
		button.Size = UDim2.new(0.8, 0, 0, 30)
		button.Position = UDim2.new(0.1, 0, 0, 40 + (i - 1) * 40)
		button.Text = jobName
		button.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
		button.TextColor3 = Color3.new(1, 1, 1)

		button.MouseButton1Click:Connect(function()
			local result = JobFunction:InvokeServer("SetJob", jobName)
			print("Changed to Job:", result.Job)
			screen:Destroy()
		end)
	end
end

-- Hook up the button
changeButton.MouseButton1Click:Connect(function()
	showJobSelector()
end)
