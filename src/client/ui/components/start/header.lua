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
local Computed = Fusion.Computed
local Children = Fusion.Children

-- Main
return function(props)
	return New "TextLabel" {
		Name = "Header",
		FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json"),
		Text = "Zombie Mania",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextScaled = true,
		TextSize = 14,
		TextStrokeTransparency = 0,
		TextWrapped = true,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.141, 0.115),
		Size = UDim2.fromScale(0.717, 0.351),

        Visible = Computed(function()
            return State.StartVisible:get()
        end);

		[Children] = {
			New "UIGradient" {
				Name = "UIGradient",
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(106, 0, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(243, 255, 0)),
				}),
			},
		}
	}
end
