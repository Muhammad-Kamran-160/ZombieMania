--[[
    Handle Transform
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Components = import("data/components")

local Model = Components.Base.Model
local Transform = Components.Base.Transform
local Transformed = Components.Base.Transformed

-- Variables

-- Main
local function system(world)
    for id, _ in world:query(Transformed) do
        world:remove(id, Transformed)
    end

    for id, transform, model in world:query(Transform, Model) do
        local instance = model.instance
        local newCFrame = transform.cframe

        if transform.relativeTo then
            newCFrame = transform.relativeTo:ToWorldSpace(newCFrame)
        end

        if transform.part then
            instance = instance:FindFirstChild(transform.part)
        end

        if instance:IsA("Model") then
            instance:PivotTo(newCFrame)
        elseif instance:IsA("BasePart") then
            instance.CFrame = newCFrame
        end

        if not transform.silent then
            world:insert(id, Transformed())
        end
        
        world:remove(id, Transform)
    end
end

return {
    system = system;
    priority = 100;
}