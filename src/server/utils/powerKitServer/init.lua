--[[
    PowerKit Singleton
    Author: Kamran / portodemesso
--]]

-- Services

-- Constants
local PowerKitServer = require(script.powerKitServer)

-- Variables
local PowerKitManager = {
    _cache = {};
}

-- Main
PowerKitManager.new = function(context, tool)
    for _, v in PowerKitManager._cache do
        if v.tool == tool then
            return v
        end
    end

    local self = PowerKitServer.new(context, tool)
    table.insert(PowerKitManager._cache, self)
    
    return self
end

return setmetatable(PowerKitManager._cache, {
    __index = PowerKitManager
})