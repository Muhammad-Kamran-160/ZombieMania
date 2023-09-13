--[[
    Client PowerKit
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Janitor = import("packages/janitor")
local Remotes = import("data/remotes")

local Client = Players.LocalPlayer

local PowerEvent = Remotes.Client:Get("PowerEvent")

-- Variables
local PowerKit = {}
PowerKit.__index = PowerKit

-- Main
PowerKit.new = function(context, tool: Tool): PowerClient?
    if tool:GetAttribute("registered") then
        return
    end

    local config = tool:FindFirstChild("config")
    assert(config, "Tool has no config")

    local self = setmetatable({}, PowerKit)

    self._janitor = Janitor.new();

    self.tool = tool;
    self._toolName = tool.Name;
    self.path = require(config);
    self.config = import(self.path .. "/config")

    self._cooldown = self.config.cooldown;
    self._lastClock = 0;

    self._animations = {};
    self._soundCache = setmetatable({}, { __mode = "v" });

    self._janitor:LinkToInstance(tool)

    tool.Equipped:Connect(function()
        for _, v in self._soundCache do
            v.Parent = Client.Character.HumanoidRootPart
        end
    end)

    tool.Unequipped:Connect(function()
        for _, v in self._soundCache do
            v.Parent = tool
        end
    end)

    -- Init client function
    import(self.path .. "/client")(context, self)

    tool:SetAttribute("registered", true)
    print("Initialized")

    return self
end

PowerKit.addAnimation = function(self, name, id, humanoid)
    humanoid = humanoid or Client.Character:WaitForChild("Humanoid")

    if not humanoid then
        warn("Animation " .. name .. " did not load because Humanoid is missing")
        return
    end

    local animation = Instance.new("Animation")
    animation.AnimationId = id
    local track = humanoid:LoadAnimation(animation)

    self._animations[name] = track
    self._janitor:Add(track)

    return track
end

PowerKit.getSound = function(self, name)
    if self._soundCache[name] then
        return self._soundCache[name]
    end

    local sound: Sound = import.fromRoot(self.tool, self.config.Sounds[name])
    self._soundCache[name] = sound

    return sound
end

PowerKit.doCooldown = function(self)
    local tool = self.tool
    local cooldown = self.config.Cooldown

    if os.clock() - self._lastClock > cooldown then
        self._lastClock = os.clock()

        task.spawn(function()
            local step = cooldown > 1 and .1 or .1

            for i = self.config.Cooldown, 0, -step do
                tool.Name = tostring(string.format("%.1f", i))
                task.wait(step)
            end

            tool.Name = self._toolName
        end)

        return true
    end

    return false
end

PowerKit.sendToServer = function(self, ...)
    return PowerEvent:SendToServer(self.tool, ...)
end

return PowerKit