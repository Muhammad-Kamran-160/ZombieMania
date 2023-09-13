--[[
    startImport
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterPlayer = game:GetService("StarterPlayer")

-- Constants
local LocalPackages = ReplicatedStorage:WaitForChild("LocalPackages")
local import = require(LocalPackages.import)

-- Variables
local function getContext()
    local isClient = RunService:IsClient()
    local isServer = RunService:IsServer()

    if isClient and isServer then
        return "studio"
    else
        if isClient then
            return "client"
        elseif isServer then
            return "studio"
        end

        return
    end
end

-- Main
local function runServer()

end

local function runClient()
    local root = StarterPlayer.StarterPlayerScripts.Client

    import.setAliases({
        shared = ReplicatedStorage.Common;
        packages = ReplicatedStorage.Packages;
        localPackages = ReplicatedStorage.LocalPackages;
        data = ReplicatedStorage.Common.data;
        sharedAssets = ReplicatedStorage.Assets;

        client = root;
        ui = root.ui;
        functions = root.functions;
        utils = root.utils;
    })
end

return function()
    local context = getContext()

    if context == "studio" or context == "client" then
        runClient()
    elseif context == "server" then
        runServer()
    end

    return
end
