--[[
    HandleMoveTo
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local SimplePath = import("localPackages/simplePath")

local Matter = import("packages/matter")
local useThrottle = Matter.useThrottle

local Components = import("data/components")
local Player = Components.Base.Player
local Character = Components.Base.Character
local MoveTo = Components.Space.MoveTo
local DisableControls = Components.Space.DisableControls

local usePathfinding = import("shared/usePathfinding")

-- Variables

-- Main
local function system(world, context)
    for id, record in world:queryChanged(MoveTo) do
        local old, new = record.old, record.new

        if world:contains(id) then
            if world:get(id, Player) then
                continue
            end
            if old and not new then
                old.path:Stop()
            end
        end
    end

    for id, character, moveTo in world:query(Character, MoveTo):without(Player, DisableControls) do
        local characterModel: Model = character.instance
        local target = moveTo.target

        if not target then
            continue
        end

        local targetPosition = typeof(target) == "Vector3" and target or target.Position

        if moveTo.minDistance then
            local characterPosition = characterModel:GetPivot().Position

            if (targetPosition - characterPosition).Magnitude <= moveTo.minDistance then
                continue
            end
        end

        --[[
            Pathfinding Mode
        --]]
        if moveTo.usePathfinding then
            if not moveTo.path then
                local new = moveTo:patch({
                    path = SimplePath.new(characterModel);
                })

                moveTo = new
                world:insert(id, new)
            end

            usePathfinding(moveTo.target, moveTo.path, id)
        else
            if useThrottle(.5, id) then
                local humanoid = characterModel:FindFirstChildWhichIsA("Humanoid")
                humanoid:MoveTo(targetPosition)
            end
        end
    end
end

return {
    system = system;
    priority = 9;
}