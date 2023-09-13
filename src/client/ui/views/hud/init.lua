require(game.ReplicatedStorage.Common.startImport)()

--[[
    HUD | View
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local LocalPackages = ReplicatedStorage:WaitForChild("LocalPackages")
local import = require(LocalPackages.import)

local Fusion = import("localPackages/fusion")
local FormatNumber = import("shared/modules/formatNumber")
local State = import("ui/state")

-- Variables
local function component(path)
    return import(string.format("ui/components/hud/%s", path))
end

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

local Container = component "container"

local XpContainer = component "xp/container"
local XpBar = component "xp/bar"
local XpTitle = component "xp/title"
local LevelUpText = component "levelUpText"
local KillFeedText = component "killFeedText"

-- Main
return function(props)
    return New "Frame" {
        Name = "HUD";
        BackgroundTransparency = 1;
        Size = UDim2.fromScale(1, 1);
        Parent = props.Parent;
        Visible = Computed(function()
            return State.HudVisible:get()
        end);

        [Children] = {
            LevelUpText{
                Visible = Computed(function()
                    return State.LevelUpTextVisible:get()
                end)
            };
            KillFeedText{
                Visible = Computed(function()
                    return State.KillFeedTextVisible:get()
                end)
            };

            Container { 
                [Children] = {
                    -- XP
                    XpContainer {
                        [Children] = {
                            XpBar;
                            XpTitle;
                        }
                    };
                }
            };
        }
    }
end