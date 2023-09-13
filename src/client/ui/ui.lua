--[[
    UI
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Client = Players.LocalPlayer
local Fusion = import("localPackages/fusion")

-- Variables
local New = Fusion.New

-- Main
local UI = {}

UI.root = New "ScreenGui" {
    Parent = Client.PlayerGui;
    ResetOnSpawn = false;
}

UI.transition = New "ScreenGui" {
    Parent = Client.PlayerGui;
    ResetOnSpawn = false;
    IgnoreGuiInset = true;
}

UI.hover = New "Sound" { -- Fancy Hover
    Parent = UI.root;
    SoundId = "rbxassetid://6333717580";
    Volume = 1;
}

UI.hover2 = New "Sound" { -- Generic Pop Hover
    Parent = UI.root;
    SoundId = "rbxassetid://10066931761";
    Volume = 1;
}

UI.click = New "Sound" { -- Level Up Click
    Parent = UI.root;
    SoundId = "rbxassetid://4612373756";
    Volume = 1;
}

UI.click2 = New "Sound" { -- Generic Click
    Parent = UI.root;
    SoundId = "rbxassetid://6042054037";
    Volume = 2;
}

UI.click3 = New "Sound" { -- Level Up Click (longer)
    Parent = UI.root;
    SoundId = "rbxassetid://4612383790";
    Volume = 1;
}

return UI