-- THIS FUNCTION RUNS ONCE WHEN TOOL IS ADDED TO INVENTORY

--[[
    Airstrike Client
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Client = Players.LocalPlayer
local Mouse = Client:GetMouse()

local Airstrike = import("shared/effects/airstrike")

-- Variables

-- Main
return function(_, power)
    local tool = power.tool

    tool.Activated:Connect(function()
        if not power:doCooldown() then
            return
        end

        if Mouse.Target then
            power:sendToServer(Mouse.Hit.Position)

            Airstrike(
                Mouse.Hit.Position
            )
        end
    end)
end