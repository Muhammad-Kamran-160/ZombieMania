--[[
    InitRemotes
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")


-- References
local import = require(ReplicatedStorage.LocalPackages.import)
local Remotes = import("data/remotes")

-- Constants
local FUNCTION_CALLBACK_PATH = "functions/clientRequested"
local FUNCTION_MAP = {
    {
        remote = "GetResources";
        callback = "/getResources";
    }
}

local EVENT_CALLBACK_PATH = "functions/clientFired";
local EVENT_MAP = {
    {
        remote = "IntroFinished";
        callback = "/introFinished";
    },
    {
        remote = "PowerEvent";
        callback = "/powerRouter";
    }
}

-- Variables

-- Main
local function run(context)
    for _, map in FUNCTION_MAP do
        local callback = import(FUNCTION_CALLBACK_PATH .. map.callback)
        
        Remotes.Server:Get(map.remote):SetCallback(function(...)
            return callback(context, ...)
        end)
    end

    for _, map in EVENT_MAP do
        local callback = import(EVENT_CALLBACK_PATH .. map.callback)
        
        Remotes.Server:Get(map.remote):Connect(function(...)
            callback(context, ...)
        end)
    end
end

return {
    run = run;
    priority = 4;
}