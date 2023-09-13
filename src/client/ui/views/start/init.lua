require(game.ReplicatedStorage.Common.startImport)()

--[[
    Start | View
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local LocalPackages = ReplicatedStorage:WaitForChild("LocalPackages")
local import = require(LocalPackages.import)

local Fusion = import("localPackages/fusion")

-- Variables
local function component(path)
    return import(string.format("ui/components/start/%s", path))
end

local New = Fusion.New
local Children = Fusion.Children

local Header = component "header";
local Button = component "button";

-- Main
return function(props)
    return New "Folder" {
        Parent = props.Parent;

        [Children] = {
            Header {};
            Button {
                Activated = props.Activated;
            }
        };
    }
end