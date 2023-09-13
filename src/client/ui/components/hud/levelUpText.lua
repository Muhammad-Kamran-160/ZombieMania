--[[
    HUD | Level Up Text
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Fusion = import("localPackages/fusion")
local State = import("ui/state")

-- Variables
local New = Fusion.New
local Computed = Fusion.Computed
local Children = Fusion.Children

-- Main
return function(props)

    return New "TextLabel" {
        Name = "LevelUpText",
        Text = Computed(function()
            return State.LevelUpTag:get()
        end),
        TextColor3 = Color3.fromRGB(0, 255, 55),
        TextScaled = true,
        TextSize = 14,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.4, 0.9),
        Size = UDim2.fromScale(0.2, 0.1),
        Visible = props.Visible,
    
        ZIndex = 1;
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal);
    }
end