-- THIS FUNCTION RUNS ONCE WHEN TOOL IS ADDED TO INVENTORY

--[[
    Heaven's Walk
    Author: Kamran / portodemesso
--]]

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)


-- Variables

-- Main
return function(context, power)

    local player = power.owner

    power:setEventListener(function(target)
        if not power:doCooldown() then
            return
        end
        power:playEffectForOthers("atomicCloud", target)

    end)
end