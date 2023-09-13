--[[
    XP
    Author: Kamran / portodemesso
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Matter = require(ReplicatedStorage.Packages.matter)

local import = require(ReplicatedStorage.LocalPackages.import)
local Data = require(script.Parent.Parent.data)

local Remotes = import("data/remotes")
local SetState = Remotes.Server:Get("SetState")
local XPUtils = import("shared/modules/xpUtils")

local function calculateLevel(xp, level)
	-- XP required to level up based on the game's playtime
	local xpPerLevel = 1000 -- Change this value according to your game's balancing

	local offset = math.floor(xp/xpPerLevel)
	local xpRemaining = xp % xpPerLevel

	return level + offset, xpRemaining
end

local function changeWalkSpeed(character, speed)
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = speed
    end
end

return function(world, context, player: Player)
    player:GetAttributeChangedSignal("XP"):Connect(function()
        local xp = player:GetAttribute("XP")
        if xp then
			Data:getProfile(player):andThen(function(profiles)
                local data = profiles.Main.Data
                local newLevel, residualXp = calculateLevel(data.Xp, data.Level)
                
                if newLevel > data.Level then
                    local rank, newColor,newTier = XPUtils(newLevel)
                    data.Level = newLevel
                    data.Xp = residualXp
                    local controller = context.getController(player)
                    player:SetAttribute("XP", data.Xp)
                    controller.leaderstats.Level = data.Level

                    SetState:SendToPlayer(player, "XPText", data.Xp.."/1000 XP")
                    SetState:SendToPlayer(player, "XPBar", data.Xp/1000)
                    SetState:SendToPlayer(player, "RankText", "Level ".. newLevel.." ("..rank..")")
                    local levelUpTag = "LEVEL UP!"
                    if newLevel == 9001 then
                        levelUpTag = "IT’S OVER 9000!!!!"
                    end
                    SetState:SendToPlayer(player, "LevelUpTag", levelUpTag)
                    local character = player.Character
                    changeWalkSpeed(character, 32)
                    task.delay(10, function() 
                        changeWalkSpeed(character, 16)
                    end)
                    SetState:SendToPlayer(player, "LevelUpTextVisible", true)
                    task.delay(3, function() 
                        SetState:SendToPlayer(player, "LevelUpTextVisible", false)
                    end)
                else
                    SetState:SendToPlayer(player, "XPText", data.Xp.."/1000 XP")
                    SetState:SendToPlayer(player, "XPBar", data.Xp/1000)
                end  
            end)
        end 
    end)
end
