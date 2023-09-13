--[[
    UseDisableControls
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Matter = import("packages/matter")

local Client = Players.LocalPlayer
local PlayerModule = require(Client.PlayerScripts:WaitForChild("PlayerModule") :: ModuleScript)
local Controls = PlayerModule:GetControls()

-- Variables
local useHookState = Matter.useHookState

-- Main
local function cleanup()
    Controls:Enable()
end

return function(discriminator: number?)
    local storage = useHookState(discriminator, cleanup)

    if not storage.init then
        Controls:Disable()
    end

    storage.init = true
end
