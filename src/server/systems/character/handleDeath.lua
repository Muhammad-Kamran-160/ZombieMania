--[[
    handleDeath
    Author: Kamran / portodemesso
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local import = require(ReplicatedStorage.LocalPackages.import)
local Components = import("data/components")
local Character = Components.Base.Character
local Player = Components.Base.Player
local Dead = Components.Space.Dead
local Revived = Components.Space.Revived

local Remotes = import("data/remotes")
local ResetCharacter = Remotes.Server:Get("ResetCharacter")
local FullResetCharacter = Remotes.Server:Get("FullResetCharacter")

local Matter = require(ReplicatedStorage.Packages.matter)

local connections = {}

local function cleanup(old)
    if not old then
        return
    end

    local humanoid = old.humanoid :: Humanoid

    if connections[humanoid] then
        connections[humanoid]:Disconnect()
        connections[humanoid] = nil
    end
end

local function useNetEvent(event)
    return Matter.useEvent(event, event)
end

local function system(world)
    for id, record in world:queryChanged(Character) do
        local old, new = record.old, record.new

        if old and not new then
            cleanup(old)
        elseif new and (not old or (old and old.humanoid ~= new.humanoid)) then
            cleanup(old)
            --Todo: Let's add revive conditions if I have time
        end
    end

    for id, record in world:queryChanged(Dead) do
        if not world:contains(id) then
            continue
        end

        local old, new = record.old, record.new
        local player, character = world:get(id, Player, Character)

        for _, directory in { player.instance.Backpack, character.instance } do
            for _, v in directory:GetChildren() do
                if v:IsA("Tool") then
                    v.ManualActivationOnly = (new and not old) and true or false
                end
            end
        end

        if new then
            if world:get(id, Revived) or player.instance:GetAttribute("NoRevive") then
                connections[character.humanoid]:Disconnect()
                connections[character.humanoid] = nil
            end
        end
    end

    for _, player in useNetEvent(ResetCharacter) do
        local character = player.Character

        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local playerId = player:GetAttribute("id")

            if playerId and humanoid then
                humanoid.Health = 0
            end
        end
    end

    for _, player in useNetEvent(FullResetCharacter) do
        local character = player.Character

        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local playerId = player:GetAttribute("id")

            if playerId and humanoid then
                connections[humanoid]:Disconnect()
            end
        end
    end
end

return {
    system = system;
    priority = 13;
}