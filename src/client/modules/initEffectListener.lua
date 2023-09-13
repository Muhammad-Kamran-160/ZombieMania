--[[
    Init Effects Listener
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- References
local import = require(ReplicatedStorage.LocalPackages.import)

local Remotes = import("data/remotes")
local PlayEffect = Remotes.Client:Get("PlayEffect")

-- Variables
local BASE_PATH = "shared/effects"

local Effects = {
    atomicCloud = "/atomicCloud";
    airStrike = "/airStrike";
}

-- Main
local function run(_)
    PlayEffect:Connect(function(effectName, ...)
        local effectPath = assert(Effects[effectName], "Effect " .. effectName .. " does not exist")
        local effect = import(BASE_PATH .. effectPath)
        if effect then
            effect(...)
        end
    end)
end

return {
    run = run;
    priority = 1;
}