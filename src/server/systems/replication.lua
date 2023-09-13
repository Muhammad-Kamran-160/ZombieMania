--[[
    Component Replication System
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)

local Matter = import("packages/matter")
local Components = import("data/components")
local Remotes = import("data/remotes")

local ServerId = Components.Base.ServerId

local ReplicateComponents = Remotes.Server:Get("ReplicateComponents")

-- Variables
local REPLICATED_COMPONENTS = {
    "Model";
    "ServerId";
    "Owner";
    "Player";
    "Character";
    "MoveTo";
}

-- Prepare
local replicatedComponents = {}
for _, name in REPLICATED_COMPONENTS do
    for _, group in Components do
        if group[name] then
            replicatedComponents[group[name]] = true
        end
    end
end

-- Main
local function replication(world, _, _)
    local buffer = {}

    for component in replicatedComponents do
        for id, _ in world:query(component):without(ServerId) do
            world:insert(id, ServerId({
                id = id;
            }))
        end
    end

    for component in replicatedComponents do
        for id, record in world:queryChanged(component) do
            local key = tostring(id)
            local name = tostring(component)

            if not buffer[key] then
                buffer[key] = {}
            end

            if world:contains(id) then
                buffer[key][name] = {
                    data = record.new;
                }
            end
        end
    end

    if next(buffer) then
        ReplicateComponents:SendToAllPlayers(buffer)
    end

    ---

    for _, player in Matter.useEvent(Players, "PlayerAdded") do
        local payload = {}

        for entityId, entityData in world do
            local entityPayload = {}

            for component, componentData in entityData do
                if replicatedComponents[component] then
                    entityPayload[tostring(component)] = { data = componentData }
                end
            end

            payload[tostring(entityId)] = entityPayload
        end

        ReplicateComponents:SendToPlayer(player, payload)
    end
end

return {
    system = replication;
    priority = math.huge;
}
