--[[
    introFinished
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)

-- Variables
local EVENT_NAME = "IntroFinished"

-- Main
return function(context, player, _)
    local controller = context.getController(player)

    if not controller:setFlag(EVENT_NAME) then
        player:LoadCharacter()
    end
end