--[[
    Airstrike Effect
    Author: Sanktuar
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Airstrike = import("sharedAssets/props/Airstrike")
local AirstrikeTarget = import("sharedAssets/props/AirstrikeTarget")

-- Variables
local config = import("shared/abilities/airstrike/config")
local TWEEN_TIME = config.TweenTime

-- Main
local function toggleParticles(model, toggle)
    local allDescendants = model:GetDescendants()

    for _, descendant in pairs(allDescendants) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = toggle
        end
    end
end

return function(target: Vector3)

    local airstrikeTarget = AirstrikeTarget:Clone()
    airstrikeTarget.Parent = workspace.Debris
    airstrikeTarget.CFrame = CFrame.new(target)
    airstrikeTarget.Activate:Play()

    local initialPosition = Vector3.new(target.X, target.Y + 150, target.Z)
    local airstrike = Airstrike:Clone()
    airstrike.Parent = workspace.Debris
    airstrike.CFrame = CFrame.new(initialPosition)

    airstrike.Hit:Play()


    local tween = TweenService:Create(
        airstrike,
        TweenInfo.new(TWEEN_TIME, Enum.EasingStyle.Linear),
        {
            Position = target;
        }
    )

    tween.Completed:Connect(function()
        task.wait(.05)
        
        toggleParticles(airstrike, true)

        task.wait(1)

        toggleParticles(airstrike, false)
        
        task.wait(.5)

        airstrike:Destroy()
    end)

    task.wait(3)
    toggleParticles(airstrikeTarget, false)

    airstrikeTarget:Destroy()
    
    tween:Play()
end
