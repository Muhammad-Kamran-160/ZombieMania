--[[
    InitUI
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ContentProvider = game:GetService("ContentProvider")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Client = Players.LocalPlayer
local Fusion = import("localPackages/fusion")

-- Variables
local New = Fusion.New
local Observer = Fusion.Observer

local State = import("ui/state")
local ui = import("ui/ui")
local root = ui.root

-- Functions
local function View(name)
    return import(string.format("ui/views/%s", name))
end

-- Main
local function run(context)
    -- Asset Preloading
    local success, data = pcall(function()
        local assets = {}

        ContentProvider:PreloadAsync(assets)
    end)

    if not success then
        warn("Failed to load assets:", data)
    else
        print("Preloaded all assets.")
    end


    View "hud" {
        Parent = root;
    }
end

return {
    run = run;
    priority = 2;
}