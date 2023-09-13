--[[
    UsePathfinding
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Matter = import("packages/matter")
local Janitor = import("packages/janitor")
local Promise = import("packages/promise")

-- Variables
local useHookState = Matter.useHookState

-- Main
local function cleanup(storage)
    storage.janitor:Destroy()
end

return function(position: Vector3, path, discriminator: number?)
    local storage = useHookState(discriminator, cleanup)

    storage.goal = position

    if not storage.janitor then
        local janitor = Janitor.new()
        
        janitor:AddPromise(
            Promise.new(function(_, _, onCancel)
                local pathfinding = true

                onCancel(function()
                    pathfinding = false
                end)

                while pathfinding do
                    task.wait()
                    path:Run(storage.goal)
                end
            end)
        )

        storage.janitor = janitor
    end
end
