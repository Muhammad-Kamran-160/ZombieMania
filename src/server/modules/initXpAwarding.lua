--[[
    initXpAwarding
    Author: Kamran / portodemesso
--]]

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local Data = require(script.Parent.Parent.data)



local function run(context)
    

	local function update(context)
		for _, v in Players:GetPlayers() do
            Data:getProfile(v):andThen(function(profiles)
                local data = profiles.Main.Data
                local xpAmount = 65
                data.Xp += xpAmount
                v:SetAttribute("XP", data.Xp)
            end)
        end
    end

    while true do
		update(context)
        task.wait(60)
    end
end

return {
    run = coroutine.wrap(run);
    priority = 18;
}