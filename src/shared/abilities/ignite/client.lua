--THIS FUNCTION RUNS ONCE WHEN TOOL IS ADDED TO INVENTORY

--[[
    Ignite Client
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Hitbox = import("localPackages/hitbox")
local Client = Players.LocalPlayer

-- Variables

-- Main
return function(_, power)
    local tool = power.tool
    
    local animationToggle = false

    local rightSwingAnimation = power:addAnimation("rightSwing", "rbxassetid://12191523038")
    local leftSwingAnimation = power:addAnimation("leftSwing", "rbxassetid://12191517532")
    local idleAnimation = power:addAnimation("idle", "rbxassetid://12191502810")

    local hitbox = nil

    tool.Activated:Connect(function()
        if not power:doCooldown()  then
            return
        end
        if not hitbox then
            hitbox = Hitbox.new(Client.Character)
            hitbox:SetOwner(Client.Character)
            hitbox.OnHit:Connect(function(hit, humanoid)
                power:sendToServer("hit",humanoid)
            end)
        end
        power:sendToServer("swing")
        
        hitbox:HitStart()

        if animationToggle then
            rightSwingAnimation:Play()
        else
            leftSwingAnimation:Play()
        end

        task.wait(1.5)
        if hitbox  then
	   hitbox:HitStop()
        end

        animationToggle = not animationToggle

    end)

    tool.Unequipped:Connect(function()
	idleAnimation:Stop()
        if hitbox then
	   hitbox:Destroy()
	   hitbox = nil
        end
    end)
    tool.Equipped:Connect(function()
        power:sendToServer("equip")
        idleAnimation:Play()
    end)
end
