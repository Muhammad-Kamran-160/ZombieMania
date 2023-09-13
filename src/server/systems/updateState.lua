--[[
    UpdateState
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Components = import("data/components")
local State = Components.Base.State

-- Variables

-- Main
local function system(world, _)
    for id, record in world:queryChanged(State) do
        local state = record.new
        local oldState = record.old

        if (not state) or (oldState and (state.state == oldState.state)) then
            continue
        end

        world:insert(id,
            state:patch {
                lastUpdated = os.clock();
            }
        )
    end
end

return {
    priority = 1;
    system = system;
}