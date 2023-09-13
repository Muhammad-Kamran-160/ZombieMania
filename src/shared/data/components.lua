--[[
    Components
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Matter = import("packages/matter")

-- Variables
local Components = {
    Base = {
        "Owner";
        "Model";
        "Transform";
        "Transformed";
        "Pending";
        "Mine";
        "ServerId";
        "State";
        "Player";
        "Character";
        "Ignore";
    },
    Space = {
        "PlayerDamage";
        "MoveTo";
        "DisableControls";
        "Sprint";
        "Dash";
        "DoubleJump";
        "Dead";
    },
    Misc = {
        "DisableTools";
    },
    NPC = {
        "NPC";
        "Tracking";
        
        "Zombie";
    }
}
local components = {};

-- Main
for groupName, group in Components do
    components[groupName] = {}

    for _, name in group do
        components[groupName][name] = Matter.component(name);
    end
end

return components