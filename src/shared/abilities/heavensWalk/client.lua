-- THIS FUNCTION RUNS ONCE WHEN TOOL IS ADDED TO INVENTORY

--[[
    Heaven's Walk Client
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Client = Players.LocalPlayer

local AtomicCloud = import("shared/effects/atomicCloud")

-- Variables

-- Main
return function(_, power)
    local tool = power.tool

    local idleAnimation = power:addAnimation("idle", "rbxassetid://12273024360")

    tool.Activated:Connect(function()
        if not power:doCooldown() then
            return
        end
        power:sendToServer(Client.Character)

        idleAnimation:Play()
        AtomicCloud(
            Client.Character
        )
        
        idleAnimation:Stop()
    end)
end
