--[[
    Init SetState Listener
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- References
local import = require(ReplicatedStorage.LocalPackages.import)

local Remotes = import("data/remotes")
local SetState = Remotes.Client:Get("SetState")

local State = import("ui/state")

-- Variables

-- Main
local function run(_)
    SetState:Connect(function(state, value)
        local stateObj = assert(State[state], `State {state} does not exist`)
        stateObj:set(value)
    end)
end

return {
    run = run;
    priority = 1;
}