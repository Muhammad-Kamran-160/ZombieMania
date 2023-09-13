--[[
    InitStartScreen
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)

local Client = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Remotes = import("data/remotes")
local State = import("ui/state")
local ui = import("ui/ui")
local startAssets = import("sharedAssets/start")

local IntroFinished = Remotes.Client:Get("IntroFinished")

-- Variables
local START_CFRAME = CFrame.new(-226.40509, 56.8163223, 263.24646, 0.608274579, 0.013613116, -0.793609977, -0, 0.999852896, 0.0171508864, 0.793726683, -0.0104324482, 0.608185112);

local function View(name)
    return import(string.format("ui/views/%s", name))
end

-- Main
local function run()
    local hasClicked = false

    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

    View "start" {
        Parent = ui.root;

        Activated = function()
            if hasClicked then
                return
            end
            hasClicked = true
            
            IntroFinished:SendToServer()
            State.StartVisible:set(false)

            Client.CharacterAdded:Wait()
            State.HudVisible:set(true)
            Camera.CameraType = Enum.CameraType.Custom
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)

            task.wait(1)

        end
    }

    Camera.CameraType = Enum.CameraType.Scriptable
    Camera.CFrame = START_CFRAME

    State.StartVisible:set(true)
end

return {
    run = run;
    priority = 3;
}