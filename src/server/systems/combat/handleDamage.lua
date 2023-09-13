--[[
    HandleDamage
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)

local Components = import("data/components")
local Character = Components.Base.Character
local PlayerDamage = Components.Space.PlayerDamage
local Data = require(script.Parent.Parent.Parent.data)
local Remotes = import("data/remotes")
local SetState = Remotes.Server:Get("SetState")

-- Variables

-- Main
local function system(world)
    for id, record in world:queryChanged(PlayerDamage) do
        local playerDamage = record.new

        if not playerDamage then
            return
        end

        if world:contains(id) then
            world:despawn(id)
        end

        local baseDamage = playerDamage.damage

        local origin = playerDamage.origin
        local originId: number?
        local originCharacter

        if typeof(origin) == "Instance" then
            if origin:IsA("Player") then
                originId = origin:GetAttribute("id")
                originCharacter = originId :: number
            elseif origin:IsA("Model") then
                originCharacter = origin
            end
        end

        local target = playerDamage.target
        local targetId: number?
        local targetCharacter

        if typeof(target) == "Instance" then
            if target:IsA("Player") then
                targetId = target:GetAttribute("id")
                targetCharacter = targetId :: number
            elseif target:IsA("Model") then
                targetCharacter = target
            end
        end

        if type(targetCharacter) == "number" then
            targetCharacter = world:get(targetCharacter, Character).instance :: Model
        end

        if origin and type(originCharacter) == "number" then
            originCharacter = world:get(originCharacter, Character).instance :: Model
        end

        --

        if targetCharacter == originCharacter then
            if not playerDamage.allowSelfHarm then
                return
            end
        end

        local appliedDamage = baseDamage
        local power = playerDamage.power
        local targetHumanoid = targetCharacter:FindFirstChildWhichIsA("Humanoid")

        local originPlayer = origin
        if origin:IsA("Model") then
            originPlayer = game.Players:GetPlayerFromCharacter(origin)
        end
        if targetHumanoid then
            targetHumanoid:TakeDamage(appliedDamage)
            if targetHumanoid.Health <= 0 and originPlayer then
                Data:getProfile(originPlayer):andThen(function(profiles)
                    local data = profiles.Main.Data
                    local xpAmount = 200
                    data.Xp += xpAmount
                    originPlayer:SetAttribute("XP", data.Xp)
                end)

                SetState:SendToPlayer(originPlayer, "KillFeedText", "You killed "..targetCharacter.Name.." (+200 XP)")
                SetState:SendToPlayer(originPlayer, "KillFeedTextVisible", true)
                originPlayer:SetAttribute("KillFeed", true)
            end
        end
    end
end

return {
    priority = 2;
    system = system;
}