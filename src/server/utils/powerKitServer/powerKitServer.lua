--[[
    Server PowerKit
   Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Janitor = import("packages/janitor")
local Remotes = import("data/remotes")

local PlayEffect = Remotes.Server:Get("PlayEffect")

-- Variables
local PowerKitServer = {}
PowerKitServer.__index = PowerKitServer

-- Main
PowerKitServer.new = function(context, tool: Tool): PowerServer?
    print("Loading tool: " .. tool:GetFullName())

    local config = tool:FindFirstChild("config")
    assert(config, "Tool has no config")

    local self = setmetatable({}, PowerKitServer)

    self.tool = tool;
    self.path = require(config);
    self.config = import(self.path .. "/config");

    self._cooldown = self.config.Cooldown - 2;
    self._lastClock = 0;

    self._soundCache = setmetatable({}, { __mode = "v" });

    self._janitor = Janitor.new();
    
    if tool.Parent then
        if tool.Parent:IsA("Backpack") then
            self.owner = tool.Parent.Parent
        elseif tool.Parent:FindFirstChild("Humanoid") then
            self.owner = Players:GetPlayerFromCharacter(tool.Parent)
        else
            error("Could not find tool owner: " .. tool:GetFullName())
        end
    end

    tool.Equipped:Connect(function()
        for _, v in self._soundCache do
            v.Parent = self.owner.Character.HumanoidRootPart
        end
    end)

    tool.Unequipped:Connect(function()
        for _, v in self._soundCache do
            v.Parent = tool
        end
    end)

    tool.Destroying:Connect(function()
        self._janitor:Destroy()
    end)

    import(self.path .. "/server")(context, self)

    return self
end

PowerKitServer.doCooldown = function(self)
    if os.clock() - self._lastClock > self._cooldown then
        self._lastClock = os.clock()
        return true
    end

    return false
end

PowerKitServer.setEventListener = function(self, onEvent)
    self._eventListener = onEvent
end

PowerKitServer.getSound = function(self, name)
    if self._soundCache[name] then
        return self._soundCache[name]
    end

    local sound: Sound = import.fromRoot(self.tool, self.config.Sounds[name])
    self._soundCache[name] = sound
    self._janitor:Add(sound)

    return sound
end

PowerKitServer.playEffectForOthers = function(self, effect, ...)
    PlayEffect:SendToAllPlayersExcept(self.owner, effect, ...)
end

PowerKitServer.playEffect = function(_, effect, ...)
    PlayEffect:SendToAllPlayers(effect, ...)
end

return PowerKitServer