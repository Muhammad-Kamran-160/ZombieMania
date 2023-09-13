--[[
    State
    Author: Kamran / portodemesso

    This module serves purpose to share state with other systems on the client.
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Fusion = import("localPackages/fusion")

-- Variables
local Value = Fusion.Value

-- Main
return {
    StartVisible = Value(true);
    LevelUpTag = Value("");
    KillFeedText = Value("");
    RankText = Value("");
    XPText = Value("");
    XPBar = Value(0);
    LevelUpTextVisible = Value(false);
    KillFeedTextVisible = Value(false);

    HudVisible = Value(false);
    DialogVisible = Value(false);

    LastInputType = Value(); -- Enum.UserInputType
}