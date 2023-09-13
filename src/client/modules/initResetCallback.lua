--[[
    initResetCallback
    Author: Kamran / portodemesso
--]]

local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local import = require(ReplicatedStorage.LocalPackages.import)
local Remotes = import("data/remotes")
local ResetCharacter = Remotes.Client:Get("ResetCharacter")

local function setCore(...)
    local MAX_RETRIES = 8
    local result = {}

    for _ = 1, MAX_RETRIES do
        result = { pcall(StarterGui.SetCore, StarterGui, ...) }

        if result[1] then
            break
        end

        RunService.Stepped:Wait()
    end

    return unpack(result)
end

local function run()
    local bindable = Instance.new("BindableEvent")

    bindable.Event:Connect(function()
        ResetCharacter:SendToServer()
    end)

    setCore("ResetButtonCallback", bindable)
end

return {
    run = run;
    priority = 15;
}