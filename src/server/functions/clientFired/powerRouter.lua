--[[
    PowerRouter
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local PowerKitServer = import("utils/powerKitServer")

-- Variables

-- Main
return function(_, player, tool, ...)
    if tool.Parent ~= player.Character and tool.Parent ~= player.Backpack then
        return
    end

    for _, power in PowerKitServer do
        if power.tool == tool then
            if power._eventListener then
                task.spawn(power._eventListener, ...)
            else
                warn(string.format("Power %s was called, but has no event listener!", tool:GetFullName()))
            end
            
            return
        end
    end
end