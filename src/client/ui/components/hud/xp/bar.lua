--[[
    HUD | XP Container
    Author: Sanktuar
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local import = require(ReplicatedStorage.LocalPackages.import)

-- Constants
local Fusion = import("localPackages/fusion")
local State = import("ui/state")

local UI = import("ui/ui")

local New = Fusion.New
local Computed = Fusion.Computed
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

-- Variables

-- Main
return New "Frame" {
	Name = "LevelBar",
	AnchorPoint = Vector2.new(0, 1),
	BackgroundColor3 = Color3.fromRGB(30, 30, 30),
	BorderSizePixel = 0,
	BackgroundTransparency = 0.1,
	Position = UDim2.fromScale(0, 0.8),
	Size = UDim2.fromScale(1, 0.3),
	SizeConstraint = Enum.SizeConstraint.RelativeXY,

	[Children] = {
		New "UICorner" {
			Name = "UICorner",
			CornerRadius = UDim.new(0.5, 0),
		},

		New "UIStroke" {
			Name = "UIStroke",
			Color = Color3.fromRGB(212, 255, 0),
			Thickness = 2.5,
			LineJoinMode = Enum.LineJoinMode.Round,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
		},

		New "Frame" {
			Name = "LevelBarProgress",
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(212, 255, 0),
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.01, 0.5),
			Size = Computed(function()
				local barSize = State.XPBar:get()
				if barSize > 1 then
					barSize = 1
				end
                return  UDim2.fromScale(barSize, 0.65)
            end),
			[Children] = {

				New "UICorner" {
					Name = "UICorner",
					CornerRadius = UDim.new(0.5, 0),
				},
			}
		},

		New "TextLabel" {
			Name = "LevelXP",
			Text = Computed(function()
                return State.XPText:get()
            end),
			TextColor3 = Color3.fromRGB(255, 234, 0),
			TextScaled = true,
			TextSize = 14,
			TextWrapped = true,
			AnchorPoint = Vector2.new(0.5, 1),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.5, 1.4),
			Size = UDim2.fromScale(0.9, 1),

			[Children] = {

				New "UIStroke" {
					Name = "UIStroke",
					Color = Color3.fromRGB(0, 0, 0),
					Thickness = 2.5,
					LineJoinMode = Enum.LineJoinMode.Round,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
				},  
			}
		},
	}
}