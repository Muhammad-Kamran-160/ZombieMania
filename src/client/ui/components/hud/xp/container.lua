--[[
    HUD | XP Container
    Author: Sanktuar
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local import = require(ReplicatedStorage.LocalPackages.import)

-- Constants
local Fusion = import("localPackages/fusion")

local New = Fusion.New
local Children = Fusion.Children

-- Variables

-- Main
return function(props)
    return New "Frame" {
        Name = "LevelBox",
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 1,
        Size = UDim2.fromScale(1, 0.06),

        [Children] = {
            props[Children],
        }
    }
end