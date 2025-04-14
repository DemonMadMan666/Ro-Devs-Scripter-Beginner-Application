local JobModule = {}

JobModule.JobData = {
	["Farmer"] = {
		MaxLevel = 10,
		XPPerLevel = 100,
	},
	["Miner"] = {
		MaxLevel = 10,
		XPPerLevel = 120,
	}
}

function JobModule.GetXPRequired(jobName, level)
	local job = JobModule.JobData[jobName]
	if not job then return 0 end
	return job.XPPerLevel * level
end

return JobModule
