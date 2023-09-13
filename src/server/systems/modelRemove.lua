--[[
    ModelRemove
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)

local Components = import("data/components")
local Model = Components.Base.Model

-- Variables

-- Main
local function system(world)
    for _, record in world:queryChanged(Model) do
        local old, new = record.old, record.new

        if not old then
            continue
        end

        if not old.instance then
            continue
        end

        if not new then
            old.instance:Destroy()
        end
    end
end

return {
    system = system;
    priority = 90;
}