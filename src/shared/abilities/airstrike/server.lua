-- THIS FUNCTION RUNS ONCE WHEN TOOL IS ADDED TO INVENTORY

--[[
    Airstrike
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)

local Components = import("data/components")
local PlayerDamage = Components.Space.PlayerDamage

-- Variables
local Explosion = import("shared/modules/explosion")
local config = require(script.Parent.config)
local TWEEN_TIME = config.TweenTime
local BLAST_RADIUS = config.BlastRadius
local BASE_DAMAGE = config.BaseDamage

-- Main
return function(context, power: PowerServer)
    local player = power.owner
    local world = context.world

    power:setEventListener(function(target)
        if not power:doCooldown() then
            return
        end

        power:playEffectForOthers("airstrike", target)

        task.wait(
            TWEEN_TIME + 3
        )

        Explosion(target, BLAST_RADIUS)
        :andThen(function(hitData: HitData)
            for _, hit in hitData do
                local targetCharacter = hit.Character

                if targetCharacter == player.Character then
                    continue
                end

                world:spawn(
                    PlayerDamage({
                        origin = player;
                        target = targetCharacter;
                        damage = BASE_DAMAGE;
                    })
                )
            end
        end)
    end)
end