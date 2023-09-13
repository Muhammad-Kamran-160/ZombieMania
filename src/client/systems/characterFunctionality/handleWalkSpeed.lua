--[[
    HandleWalkSpeed
    Author: Kamran / portodemesso
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Client = Players.LocalPlayer
local import = require(ReplicatedStorage.LocalPackages.import)
local Components = import("data/components")
local Character = Components.Base.Character
local Mine = Components.Base.Mine

local Sprint = Components.Space.Sprint

local BASE_WALKSPEED = 16

local characterId

local function system(world)
    if not characterId then
        for id, _, _ in world:query(Character, Mine) do
            characterId = id
        end
    end

    if not characterId then
        return
    end
    
    local character = world:get(characterId, Character)
    if not character then
        return
    end

    local characterInstance = character.instance
    characterInstance:SetAttribute("clientId", characterId)
    local humanoid = characterInstance:FindFirstChildWhichIsA("Humanoid")

    if not humanoid then
        return
    end

    for id, record in world:queryChanged(Sprint) do
        if id ~= characterId then
            return
        end

        if record.new and not record.new.originalWalkSpeed then
            world:insert(id, record.new:patch({
                originalWalkSpeed = humanoid.WalkSpeed;
            }))

            humanoid.WalkSpeed *= 1.4
        elseif record.old and not record.new then
            humanoid.WalkSpeed = record.old.originalWalkSpeed
        end
    end
end

return {
    system = system;
    priority = 2;
}