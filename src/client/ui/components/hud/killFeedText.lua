--[[
    HUD | Kill Feed Text
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")

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
        Name = "KillFeedText",
        Text = Computed(function()
            return State.KillFeedText:get()
        end),
        TextColor3 = Color3.fromRGB(255, 0, 0),
        TextScaled = false,
        TextSize = 18,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
		Position = Computed(function()
			local isMobile = userInputService.TouchEnabled

			if isMobile then
				return UDim2.fromScale(0.5, 0.8)
			else
				return UDim2.fromScale(0.55, 0.9)
			end
		end),
        Size = UDim2.fromScale(0.5, 0.1),
        Visible = props.Visible,
    
        ZIndex = 1;
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal);
    }
end