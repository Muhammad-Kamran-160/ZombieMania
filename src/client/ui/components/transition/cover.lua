--[[
    Transition | Cover
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local import = require(ReplicatedStorage.LocalPackages.import)

-- Constants
local Fusion = import("localPackages/fusion")

-- Variables
local State = import("ui/state")

local New = Fusion.New
local Computed = Fusion.Computed
local Tween = Fusion.Tween

-- Main
return function(props)
    return New "Frame" {
        Size = UDim2.fromScale(1, 1);
        BackgroundColor3 = Color3.new();
        BackgroundTransparency = Tween(Computed(function()
            return State.Transition:get() and 0 or 1
        end))
    }
end
