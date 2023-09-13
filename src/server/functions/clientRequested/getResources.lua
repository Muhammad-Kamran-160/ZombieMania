--[[
    GetResources Server
--]]

-- Services

-- Constants

-- Variables

-- Main
return function(context, player)
    local controller = context.getController(player)
    return {
        level = controller.leaderstats.Level or 0;
    }
end
