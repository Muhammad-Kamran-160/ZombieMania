--[[
    HUD | Level Title
    Author: Sanktuar
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local import = require(ReplicatedStorage.LocalPackages.import)

-- Constants
local Fusion = import("localPackages/fusion")
local State = import("ui/state")

local New = Fusion.New
local Computed = Fusion.Computed
local Children = Fusion.Children

-- Variables

-- Main
return New "TextLabel" {
    Name = "Level",
    Text = Computed(function()
        return State.RankText:get()
    end),
    TextColor3 = Color3.fromRGB(0, 0, 0),
    TextScaled = true,
    TextSize = 14,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.fromScale(0, 0),
    Size = UDim2.fromScale(1, 0.4),

    ZIndex = 1;
    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal);

    [Children] = {
        New "TextLabel" {
            Name = "Top",
            Text = Computed(function()
                return State.RankText:get()
            end),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            TextSize = 14,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.fromScale(-0.01, -0.01),
            Size = UDim2.fromScale(1, 1),
        
            ZIndex = 1;
            FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal);
        }
    }
}