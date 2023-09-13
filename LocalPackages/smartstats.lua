--[[
    SmartStats
    Author: Kamran / portodemesso
--]]

-- Services

-- Constants

-- Variables

-- Main
local SmartStats = {}
SmartStats.__index = SmartStats

SmartStats.new = function(player: Player): SmartStat
    local self = setmetatable({}, SmartStats)

    self._player = player
    self._leaderstatsObject = self:_getObject()
    self._leaderstatsData = {}
    self._customCallbacks = {}

    self.metatable = self:_getMetatable()

    table.freeze(self)

    return self
end

SmartStats._getObject = function(self): Folder
    local player: Player = self._player
    local existingLeaderstats: Instance? = player:FindFirstChild("leaderstats")

    if existingLeaderstats and existingLeaderstats:IsA("Folder") then
        return existingLeaderstats
    end

    local leaderstats: Folder = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    return leaderstats
end

SmartStats._getMetatable = function(self)
    local statData = self._leaderstatsData
    local metatable = {}

    setmetatable(metatable, {
        __index = function(_, key)
            local valueData = statData[key]

            if valueData then
                return valueData.value
            end

            return
        end,

        __newindex = function(_, key, value)
            local valueData = statData[key]
            local parsedValue = tostring(value)

            if value == nil then
                if valueData then
                    valueData.object:Destroy()
                    statData[key] = nil
                end

                return
            end

            local customCallback = self._customCallbacks[key]
            if self._customCallbacks[key] then
                parsedValue = customCallback(value)
            end

            if not valueData then
                local object = Instance.new("StringValue")
                object.Name = key
                object.Value = parsedValue
                object.Parent = self._leaderstatsObject
 

                valueData = {
                    object = object;
                    value = value;
                    valueType = type(value);
                }

                statData[key] = valueData
            else
                valueData.object.Value = parsedValue
                valueData.value = value
            end
        end
    })

    return metatable
end

SmartStats.setCustomCallback = function(self, key, callback)
    self._customCallbacks[key] = callback
end

-- Types
export type LeaderstatsData = {
    [string]: string | number | boolean
}

export type LeaderstatsObject = {
    [number]: {
        object: StringValue,
        value: string
    }
}

export type SmartStat = {
    _player: Player,
    _leaderstatsObject: LeaderstatsObject,
    _leaderstatsData: LeaderstatsData,

    _getObject: (SmartStat) -> (LeaderstatsObject),
    _getMetatable: (SmartStat) -> ({}),

    metatable: {}
}

return SmartStats