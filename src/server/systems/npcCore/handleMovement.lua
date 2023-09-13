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
local MoveTo = Components.Space.MoveTo

-- Variables
local TRACKING_MODES = {"once", "constant"}

-- Main
local function system(world, _)
    for id, _, _, tracking, moveTo in world:query(NPC, Character, Tracking, MoveTo) do
        if not moveTo.useTracking then
            continue
        end

        local target = tracking.target
        if not target then
            continue
        end

        local targetRootPart = target:FindFirstChild("HumanoidRootPart") :: BasePart?
        if not targetRootPart then
            continue
        end

        if moveTo.target == targetRootPart then
            continue
        end

        world:insert(
            id,
            moveTo:patch({
                target = targetRootPart;
            })
        )
    end
end

return {
    system = system;
    priority = 4;
}