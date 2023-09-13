--[[
    initLeaderstats
    Author: Kamran / portodemesso
--]]

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local Data = require(script.Parent.Parent.data)

-- Variables

-- Main
local function run(context)
    Players.PlayerAdded:Connect(function(player)
        local controller = context.getController(player)

        Data:getProfile(player):andThen(function(profiles)
            local data = profiles.Main.Data
            controller.leaderstats.Rebirths = data.Rebirths
            player:SetAttribute("XP", data.Xp)
            controller.leaderstats.Level = data.Level
        end)
    end)
end

return {
    run = run;
    priority = 5;
}