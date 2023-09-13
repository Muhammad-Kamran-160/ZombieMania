--[[
    DespawnCharacter
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Components = import("data/components")
local Character = Components.Base.Character

-- Variables

-- Main
local function system(world)
    for _, record in world:queryChanged(Character) do
        if record.old and not record.new then
            record.old.instance:Destroy()
        end
    end
end

return {
    priority = 10;
    system = system;
}