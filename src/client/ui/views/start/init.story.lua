--[[
    Init Story
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local LocalPackages = ReplicatedStorage:WaitForChild("LocalPackages")
local Fusion = require(LocalPackages:WaitForChild("fusion"))

-- Variables
local New = Fusion.New
local Children = Fusion.Children

local View = require(script.Parent)

-- Main
return function(target)
    local view = View {
        Parent = target;
    }

    return function()
        view:Destroy();
    end
end