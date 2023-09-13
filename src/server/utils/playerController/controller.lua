--[[
    Player Controller Class
    Author: Kamran / portodemesso
--]]

-- Services
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")  

-- Constants
local Packages = ReplicatedStorage.Packages
local Common = ReplicatedStorage.Common
local LocalPackages = ReplicatedStorage:WaitForChild("LocalPackages")

local Janitor = require(Packages.janitor)
local Signal = require(Packages.signal)
local Promise = require(Packages.promise)
local SmartStats = require(LocalPackages.smartstats)

local Modules = Common:WaitForChild("modules")

-- Variables
local formatNumber = require(Modules.formatNumber)

-- Main
local Controller = {}
Controller.__index = Controller

Controller.new = function(player)
    local self = setmetatable({}, Controller)
    
    self.metadata = {};
    self.smartStats = SmartStats.new(player)
    self.leaderstats = self.smartStats.metatable
    self.janitor = Janitor.new()

    self.signals = {}

    self._object = player
    self._leaderstats = {};
    self._flags = {};

    self:_init()

    return self
end

Controller._init = function(self)
    --[[
        Signal Setup
    --]]
    local signals = {}

    for _,v in self.signals do
        signals[v] = Signal.new()
    end

    self.signals = signals

    --[[
        Leaderstats Callback Setup
    --]]
end

Controller.getFlag = function(self, key)
    return self._flags[key]
end

Controller.setFlag = function(self, key, value)
    local existingValue = self._flags[key]

    self._flags[key] = value or true

    return existingValue
end

return Controller