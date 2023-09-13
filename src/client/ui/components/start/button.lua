--[[
    Start | Header
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
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local Computed = Fusion.Computed

-- Main
return function(props)
	return New "TextButton" {
		Name = "PlayButton",
		FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json"),
		Text = "Play",
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextScaled = true,
		TextSize = 14,
		TextWrapped = true,
		BackgroundColor3 = Color3.fromRGB(0, 255, 0),
		BackgroundTransparency = 0.5,
		BorderSizePixel = 3,
		Position = UDim2.fromScale(0.352, 0.706),
		Size = UDim2.new(0.294, 1, 0.137, 0),
        AutoButtonColor = true,

        Visible = Computed(function()
            return State.StartVisible:get()
        end);

        [OnEvent "Activated"] = props.Activated;

		[Children] = {
			New "UIStroke" {
				Name = "UIStroke",
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Thickness = 2,
			},

			New "UICorner" {
				Name = "UICorner",
			},
		}
	}
end
