--[[
    RemovePlayer
    Author: Kamran / portodemesso
--]]

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Components = import("data/components")
local Player = Components.Base.Player

-- Variables

-- Main
local function system(world)
    for id, player in world:query(Player) do
        if player.instance:IsDescendantOf(game) then
            continue
        end

        world:despawn(id)
    end
end

return {
    priority = 2;
    system = system;
}