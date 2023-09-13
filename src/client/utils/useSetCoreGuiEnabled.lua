--[[
    UseSetCoreGuiEnabled
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Matter = import("packages/matter")

-- Variables
local useHookState = Matter.useHookState

-- Main
local function cleanup(storage)
    StarterGui:SetCoreGuiEnabled(storage.coreGuiType, storage.initialState)
end

return function(coreGuiType: Enum.CoreGuiType, state: boolean, discriminator: number?)
    local storage = useHookState(discriminator, cleanup)

    if storage.initialState == nil then
        storage.coreGuiType = coreGuiType
        storage.initialState = StarterGui:GetCoreGuiEnabled(coreGuiType)

        StarterGui:SetCoreGuiEnabled(coreGuiType, state)
    end
end
