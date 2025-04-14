local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local JobEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("JobEvent")
local JobFunction = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("JobFunction")

local JobModule = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("JobModule"))
local PlayerData = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("PlayerData"))

local playerStats = {}

Players.PlayerAdded:Connect(function(player)
	local data = PlayerData.LoadData(player)
	playerStats[player] = data

	print(player.Name .. " loaded data: Job = " .. data.Job .. ", Level = " .. data.Level .. ", XP = " .. data.XP)
end)

Players.PlayerRemoving:Connect(function(player)
	if playerStats[player] then
		PlayerData.SaveData(player, playerStats[player])
		print(player.Name .. " saved data.")
		playerStats[player] = nil
	end
end)


-- Gain XP function
JobEvent.OnServerEvent:Connect(function(player, action)
	local stats = playerStats[player]
	if not stats then return end

	local job = stats.Job
	local xpGain = 20 -- Could be more dynamic based on action

	stats.XP += xpGain
	local requiredXP = JobModule.GetXPRequired(job, stats.Level)

	if stats.XP >= requiredXP then
		stats.XP = stats.XP - requiredXP
		stats.Level += 1
		-- Max level check
		if stats.Level > JobModule.JobData[job].MaxLevel then
			stats.Level = JobModule.JobData[job].MaxLevel
			stats.XP = requiredXP
		end
	end

	JobEvent:FireClient(player, stats)
end)

-- Change job
JobFunction.OnServerInvoke = function(player, request, newJob)
	local stats = playerStats[player]
	if request == "GetData" then
		return stats
	elseif request == "SetJob" and JobModule.JobData[newJob] then
		stats.Job = newJob
		stats.Level = 1
		stats.XP = 0
		return stats
	end
end
