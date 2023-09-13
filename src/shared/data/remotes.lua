--[[
    Remotes
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.net)

-- Variables
local Definitions = Net.Definitions
local ServerAsyncFunction = Definitions.ServerAsyncFunction
local ClientToServerEvent = Definitions.ClientToServerEvent
local ServerToClientEvent = Definitions.ServerToClientEvent
local BidirectionalEvent = Definitions.BidirectionalEvent

local Remotes = Net.CreateDefinitions({

    --[[
        Used to replicate ECS components from the server
        to the client in a synchronized, central manner.
    --]]
    ReplicateComponents = ServerToClientEvent();

    --[[
        Used to resolve pending components for actions.
    --]]
    ResolvePendingComponents = ServerToClientEvent();

    --[[
        Fetches the callers' xp, level from the
        server so it can be used on the client.
        [This remote is promise-based]
    --]]
    GetResources = ServerAsyncFunction();

    --[[
        Plays small effects on the client
        to reduce server load and latency lag.
    --]]
    PlayEffect = ServerToClientEvent();

    --[[
        Reloads your character after finishing
        the intro
    --]]
    IntroFinished = ClientToServerEvent();

    --[[
        Acts as a router for
        all power-related events
    --]]
    PowerEvent = ClientToServerEvent();

    --[[
        Allows the client to
        fetch the remote config from
        the server
    --]]
    FetchRemoteConfig = ServerAsyncFunction();

    --[[
        Allows the server to set
        the core gui enabled state
        for the client
    --]]
    SetCoreGuiEnabled = ServerToClientEvent();

    --[[
        Replicates dash effects
    --]]
    DashEvent = ClientToServerEvent();

    --[[
        Replicates double jump effects
    --]]
    DoubleJumpEvent = ClientToServerEvent();

    --[[
        Sets the specified state on the client
    --]]
    SetState = ServerToClientEvent();

    --[[
        Sends a request to the server
        to reset the calling character
    --]]
    ResetCharacter = ClientToServerEvent();

    --[[
        Sends a request to the server
        to fully-kill the calling character
    --]]
    FullResetCharacter = ClientToServerEvent();

    --[[
        Plays level up effects on the client
    --]]
    PlayLevelUpEffect = ServerToClientEvent();

     --[[
        Plays damage tick effect on the client
    --]]
    TickEffect = ServerToClientEvent();

})

-- Main
Remotes.server = Remotes.Server
Remotes.client = Remotes.Client
Remotes.server.get = Remotes.Server.Get

return Remotes