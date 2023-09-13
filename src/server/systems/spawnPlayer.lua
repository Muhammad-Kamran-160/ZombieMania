--[[
    SpawnPlayer
    Author: Kamran / portodemesso
--]]

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Components = import("data/components")
local Player = Components.Base.Player
local Owner = Components.Base.Owner

-- Variables

-- Main
local function system(world)
    for _, player in Players:GetPlayers() do
        if player:GetAttribute("id") then
            continue
        end

        local id = world:spawn(
            Player({
                instance = player;
            }),
            Owner({
                player = player;
            })
        )

        player:SetAttribute("id", id)
    end
end

return {
    priority = 1;
    system = system;
}