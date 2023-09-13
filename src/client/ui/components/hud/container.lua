--[[
    HUD | Container
    Author: Kamran / portodemesso
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
        Name = "HUD",
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.02, 0.5),
        Size = UDim2.fromScale(0.13, 1),
        Parent = props.Parent;
        Visible = props.Visible;

        [Children] = {
            props[Children],
            {
                New "UIListLayout" {
                    Name = "UIListLayout",
                    Padding = UDim.new(0.02, 0),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                },

                New "UIAspectRatioConstraint" {
                    Name = "UIAspectRatioConstraint",
                    AspectRatio = 0.231,
                },

                New "UISizeConstraint" {
                    Name = "UISizeConstraint",
                    MinSize = Vector2.new(550, 650),
                }
            }
        }
    }
end
