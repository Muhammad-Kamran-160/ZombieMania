--[[
    updateLastInputType
    Author: Kamran / portodemesso
--]]

local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local import = require(ReplicatedStorage.LocalPackages.import)
local State = import("ui/state")
local Matter = require(ReplicatedStorage.Packages.matter)
local useThrottle = Matter.useThrottle

local lastInputType
local acceptableTypes = {
    Enum.UserInputType.MouseButton1,
    Enum.UserInputType.MouseButton2,
    Enum.UserInputType.MouseButton3,
    Enum.UserInputType.Touch,
    Enum.UserInputType.Gamepad1
}

local function system()
    if not useThrottle(.1) then
        return
    end

    local lastType = UserInputService:GetLastInputType()
    
    
    if lastType ~= lastInputType then
        if table.find(acceptableTypes, lastType) then
            State.LastInputType:set(lastInputType)
        end
    end
    
    lastInputType = lastType
end

return {
    system = system;
}