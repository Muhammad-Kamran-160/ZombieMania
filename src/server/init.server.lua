--[[
    Init Server
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- Constants
local Packages = ReplicatedStorage.Packages
local LocalPackages = ReplicatedStorage.LocalPackages
local Common = ReplicatedStorage.Common

local Import = require(LocalPackages.import)
local startModules = require(Common.startModules)
local startECS = require(Common.startECS)

local playerController = require(script.utils.playerController)
local dataHandler = require(script.data)

-- Variables
local aliases = {
    shared = ReplicatedStorage.Common;
    data = Common.data;
    server = script;

    packages = Packages;
    functions = script.functions;
    utils = script.utils;

    sharedAssets = ReplicatedStorage.Assets;
    serverAssets = ServerStorage.Assets;

    localPackages = ReplicatedStorage.LocalPackages;
}
Import.setAliases(aliases)

local context = {}
local World, Loop = startECS(script.systems, context)

-- Main
context.world = World
context.data = dataHandler
context.getController = playerController.get

-- Must be required after we initialize import aliases

dataHandler:setup()
startModules(script.modules, false, context)