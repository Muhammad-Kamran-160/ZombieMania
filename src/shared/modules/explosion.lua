--[[
    Explosion
    Author: Kamran / portodemesso 
--]]

-- Services
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Promise = import("packages/promise")

-- Variables

-- Main
return function(position: Vector3, radius: number, exclude: { Model? }?, pressure: number) -- returns Promise
    local alreadyHit = {}
    local hitData = {}

    local explosion = Instance.new("Explosion")

    if pressure then
        explosion.BlastPressure = pressure
    else
        explosion.BlastPressure = 0
    end
    explosion.DestroyJointRadiusPercent = 0
    explosion.ExplosionType = Enum.ExplosionType.NoCraters
    explosion.Position = position
    explosion.Visible = false
    explosion.BlastRadius = radius

    return Promise.new(function(resolve, _)
        explosion.Hit:Connect(function(part)
            local humanoid = part.Parent:FindFirstChildWhichIsA("Humanoid")
            
            if not humanoid then
                return
            end

            if exclude then
                if table.find(exclude, humanoid.Parent) then
                    return
                end
            end

            if alreadyHit[humanoid] then
                return
            end
            alreadyHit[humanoid] = true

            table.insert(hitData, {
                Character = part.Parent;
                Humanoid = humanoid;
            })
        end)

        explosion.Parent = workspace
        Debris:AddItem(explosion, 1)

        task.delay(.1, function()
            resolve(hitData)
        end)
    end)
end
