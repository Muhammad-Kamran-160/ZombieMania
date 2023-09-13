--[[
    LoadNPC
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local NPCs = import("data/npcs")
local Matter = import("packages/matter")

local Components = import("data/components")
local NPC = Components.NPC.NPC
local Character = Components.Base.Character

-- Variables

-- Main
local function system(world, _)
    for id, record in world:queryChanged(NPC) do
        local old, npc = record.old, record.new

        if npc and not old then
            local config = NPCs[npc.type]

            if config then
                world:insert(
                    id,
                    npc:patch({
                        config = config;
                    })
                )
            else
                world:remove(id, NPC)
            end
        end
    end
end

return {
    system = system;
    priority = 1;
}