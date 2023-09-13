--[[
    LoadCharacter
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
    for id, npc in world:query(NPC):without(Character) do
        local CharacterTemplate = import(npc.config.character)
        
        local character = CharacterTemplate:Clone()
        character.Parent = workspace
        character:SetAttribute("id", id)

        local humanoid = character:FindFirstChildWhichIsA("Humanoid") :: Humanoid

        if npc.spawnPoint then
            character:PivotTo(npc.spawnPoint)
        end

        if npc.sounds then
            for soundName, soundId in npc.sounds do
                local sound = Instance.new("Sound")
                sound.SoundId = soundId
                sound.Name = soundName
                sound.Parent = character.PrimaryPart
            end
        end

        local loadedAnimations = {}

        if npc.config.animations then
            for animationName, animationId in npc.config.animations do
                local animation = Instance.new("Animation")
                animation.AnimationId = animationId

                local animationTrack = humanoid:LoadAnimation(animation)
                loadedAnimations[animationName] = animationTrack
            end
        end

        world:insert(
            id,
            Character({
                instance = character;
                animations = loadedAnimations;
            })
        )
    end
end

return {
    system = system;
    priority = 2;
}