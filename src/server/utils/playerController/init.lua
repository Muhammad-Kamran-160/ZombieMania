--[[
    PlayerController
    Author: Kamran / portodemesso

    This module is the PlayerController singleton. Controller instances
    are cached for faster load times.
--]]

-- Services

-- Constants

-- Variables
local Controller = require(script.controller)

-- Main
local PlayerController = {
    _cache = {};
}

PlayerController.get = function(player)
    local controller = PlayerController._cache[player]

    if not controller then
        controller = Controller.new(player)
        PlayerController._cache[player] = controller
    end

    return controller
end

return PlayerController