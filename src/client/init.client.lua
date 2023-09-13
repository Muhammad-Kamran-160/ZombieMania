--[[
    Init Client
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local Common = ReplicatedStorage:WaitForChild("Common")

local startImport = require(Common.startImport)
startImport()

local startModules = require(Common.startModules)
local startECS = require(Common.startECS)

local Data = Common:WaitForChild("data")
local Remotes = require(Data.remotes)
local Components = require(Data.components)

local ReplicateComponents = Remotes.Client:Get("ReplicateComponents")

local SYSTEM_SORTS = {
}

-- ECS Sorting Setup
for _,dir in script.systems:GetChildren() do
    local sortData = SYSTEM_SORTS[dir.Name]
    if not sortData then
        continue
    end

    for _, object in dir:GetChildren() do
        if not object:IsA("ModuleScript") then
            continue
        end

        local module = require(object)
        local priority = module.priority or 1

        module.priority = priority * sortData
    end
end

local AllComponents = {}

-- Variables
local context = {
    data = {
    }
}

local world, loop = startECS(script.systems, context)
context.world = world

local localEntityMap = {}

-- Prepare
for _, group in Components do
	for componentName, component in group do
		AllComponents[componentName] = component
	end
end

-- Main

--[[
    Replicator Setup
--]]
ReplicateComponents:Connect(function(entities)
    for serverEntityId, componentMap in entities do
        local clientEntityId = localEntityMap[serverEntityId]

        if clientEntityId and not next(componentMap) then
            world:despawn(clientEntityId)
            localEntityMap[serverEntityId] = nil

            continue
        end

        local newComponents = {}
        local removedComponents = {}

        for name, container in componentMap do
            if container.data then
                table.insert(newComponents, AllComponents[name](container.data))
            else
                table.insert(removedComponents, AllComponents[name])
            end
        end

        if not clientEntityId then
            clientEntityId = world:spawn(unpack(newComponents))
            localEntityMap[serverEntityId] = clientEntityId
        else
            if #newComponents > 0 then
                world:insert(clientEntityId, unpack(newComponents))
            end

            if #removedComponents > 0 then
                world:remove(clientEntityId, unpack(removedComponents))
            end
        end
    end
end)

--[[
    Module Setup
--]]
startModules(script.modules, false, context)