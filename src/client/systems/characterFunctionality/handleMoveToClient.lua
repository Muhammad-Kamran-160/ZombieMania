--[[
    HandleMoveTo Client
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local SimplePath = import("localPackages/simplePath")
local Components = import("data/components")

local Player = Components.Base.Player
local Character = Components.Base.Character
local Mine = Components.Base.Mine
local MoveTo = Components.Space.MoveTo
local DisableControls = Components.Space.DisableControls

local usePathfinding = import("shared/usePathfinding")
local useDisableControls = import("utils/useDisableControls")
local useSetCoreGuiEnabled = import("utils/useSetCoreGuiEnabled")

-- Variables

-- Main
local function system(world)
    for id, record in world:queryChanged(MoveTo) do
        if world:contains(id) then
            if not world:get(id, Mine) then
                continue
            end
    
            local character = world:get(id, Character).instance
    
            if record.new then
                character.Humanoid:UnequipTools()
            else
                local old = record.old
                if old then
                    old.path:Stop()
                end
            end
        end
    end

    for id, character, moveTo, _ in world:query(Character, MoveTo, Mine, Player):without(DisableControls) do
        local characterModel: Model = character.instance

        if not moveTo.path then
            local new = moveTo:patch({
                path = SimplePath.new(characterModel);
            })

            moveTo = new
            world:insert(id, new)
        end

        --[[
            Pathfinding Mode
        --]]
        if moveTo.mode == "pathfinding" then
            usePathfinding(moveTo.target, moveTo.path, id)
            useDisableControls()
            useSetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
        end
    end
end

return {
    system = system;
    priority = 1;
}