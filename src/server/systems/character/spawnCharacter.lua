--[[
    SpawnCharacter
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PhysicsService = game:GetService("PhysicsService")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Components = import("data/components")
local Matter = import("packages/matter")
local Data = require(script.Parent.Parent.Parent.data)
local Player = Components.Base.Player
local Character = Components.Base.Character
local Model = Components.Base.Model
local XP = import("functions/xp")
local Remotes = import("data/remotes")
local SetState = Remotes.Server:Get("SetState")
local XPUtils = import("shared/modules/xpUtils")

-- Variables

-- Main

local function system(world, context)
    for id, player in world:query(Player) do
        for _, character in Matter.useEvent(player.instance, "CharacterAdded") do
            task.spawn(function()

                local components = {
                    Character({
                        instance = character;
                        rootPart = character:WaitForChild("HumanoidRootPart");
                        humanoid = character:WaitForChild("Humanoid");
                    }),
                    Model({
                        instance = character;
                    })
                }

                local level = 0
                local xp = 0
                Data:getProfile(player.instance):andThen(function(profiles)
                    local data = profiles.Main.Data
                    level = data.Level
                    xp = data.Xp
                end)
                
                local rank, newColor = XPUtils(level)

                SetState:SendToPlayer(player.instance, "XPText", xp.."/1000 XP")
                SetState:SendToPlayer(player.instance, "XPBar", xp/1000)
                SetState:SendToPlayer(player.instance, "RankText", "Level ".. level.." ("..rank..")")

                XP(world, context, player.instance)

                world:insert(id, unpack(components))
                character:SetAttribute("id", id)
            end)
        end
    end
end

return {
    priority = 1;
    system = system;
}