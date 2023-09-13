--[[
    Heaven's Walk Effect
    Author: Sanktuar
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Cloud = import("sharedAssets/props/Cloud")

-- Variables
local HEIGHT = import("shared/abilities/heavensWalk/config").Height

-- Main
return function(character: Model, action: string)

    local HumanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local characterAttachment = Instance.new("Attachment")
        characterAttachment.Name = "characterAttachment"
        characterAttachment.Parent = HumanoidRootPart
        characterAttachment.Position = characterAttachment.Position - Vector3.new(0,4.7,-1)
        characterAttachment.Orientation = Vector3.new(0,0,-90)
    
        local cloud = Cloud:Clone()
    
        local mountAttachment = cloud.PrimaryPart.PlayerAttachment
        cloud:PivotTo( mountAttachment.WorldCFrame * characterAttachment.CFrame:ToObjectSpace(mountAttachment.CFrame) )
    
        local rigidConstraint: RigidConstraint = Instance.new( "RigidConstraint" )
        rigidConstraint.Attachment0 = mountAttachment
        rigidConstraint.Attachment1 = characterAttachment
        rigidConstraint.Parent = cloud.PrimaryPart
        
        local linearVelocity = Instance.new("LinearVelocity")
        linearVelocity.Attachment0 = characterAttachment
        linearVelocity.Name = "linearVelocity"
        linearVelocity.MaxForce = HEIGHT
        linearVelocity.VelocityConstraintMode = 0
        linearVelocity.LineDirection = Vector3.yAxis
        linearVelocity.Parent = HumanoidRootPart
        
        cloud.Parent = character
        linearVelocity.LineVelocity = 10
        character:WaitForChild("Humanoid").WalkSpeed = 32
        task.wait(2)
        linearVelocity.LineVelocity = 0

        task.wait(10)

		if cloud then
            cloud:Destroy()
            cloud = nil
        end
		if characterAttachment then
            characterAttachment:Destroy()
            characterAttachment = nil
        end
		if linearVelocity then
            linearVelocity:Destroy()
            linearVelocity = nil
		end
		
		character:WaitForChild("Humanoid").WalkSpeed = 16
end