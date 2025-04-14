local DataStoreService = game:GetService("DataStoreService")
local JobStore = DataStoreService:GetDataStore("JobSystemData")

local PlayerData = {}

function PlayerData.LoadData(player)
	local data = {
		Job = "Farmer",
		XP = 0,
		Level = 1
	}

	local success, result = pcall(function()
		return JobStore:GetAsync(player.UserId)
	end)

	if success and result then
		for k, v in pairs(result) do
			data[k] = v
		end
	end

	return data
end

function PlayerData.SaveData(player, data)
	pcall(function()
		JobStore:SetAsync(player.UserId, data)
	end)
end

return PlayerData
