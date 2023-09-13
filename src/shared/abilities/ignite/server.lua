-- THIS FUNCTION RUNS ONCE WHEN TOOL IS ADDED TO INVENTORY

--[[
    Ignite
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Components = import("data/components")

local PlayerDamage = Components.Space.PlayerDamage

-- Variables

-- Main
return function(context, power)
    local player = power.owner
    local world = context.world

    power:setEventListener(function(action, humanoid)
        if action == "hit" then
            if not power:doCooldown() then
                return
            end
            local distance = player:DistanceFromCharacter(humanoid.Parent.PrimaryPart.Position)
    
            if distance > 10 then
                return
            end
    
            world:spawn(
                PlayerDamage({
                    origin = player;
                    target = humanoid.Parent;
                    damage = power.config.BaseDamage;
                })
            )
        end
    end)
end