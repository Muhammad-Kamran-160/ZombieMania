--[[
    Init CoreGuiEnabled Listener
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

-- References
local import = require(ReplicatedStorage.LocalPackages.import)

local Remotes = import("data/remotes")
local SetCoreGuiEnabled = Remotes.Client:Get("SetCoreGuiEnabled")

-- Variables

-- Main
local function run(_)
    SetCoreGuiEnabled:Connect(function(coreGuiType, state)
        StarterGui:SetCoreGuiEnabled(
            coreGuiType,
            state
        )
    end)
end

return {
    run = run;
    priority = 1;
}