--[[
    HandleTracking
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Matter = import("packages/matter")

local Components = import("data/components")
local NPC = Components.NPC.NPC
local Tracking = Components.NPC.Tracking
local Character = Components.Base.Character

-- Variables
local TRACKING_MODES = {"once", "constant"}

-- Main
local function system(world, _)
    for id, npc, character, tracking in world:query(NPC, Character, Tracking) do
        if tracking.mode == "once" and tracking.target then
            continue
        end

        if not table.find(TRACKING_MODES, tracking.mode) then
            continue
        end

        local closest, maxDistance = nil, math.huge

        for tId, tCharacter in world:query(Character) do
            if tId == id then
                continue
            end

            local exclude = tracking.exclude
            if exclude then
                if table.find(exclude, tId) then
                    continue
                end
            end

            local distance = (
                character.instance:GetPivot().Position -
                tCharacter.instance:GetPivot().Position
            ).Magnitude

            if distance < maxDistance then
                closest, maxDistance = tCharacter.instance, distance
            end
        end

        world:insert(
            id,
            tracking:patch({
                target = closest
            })
        )
    end
end

return {
    system = system;
    priority = 3;
}