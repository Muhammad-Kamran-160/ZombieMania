--[[
    initToolRegister
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local PowerKit = import("client/utils/powerKit")

local Client = Players.LocalPlayer

-- Variables

-- Main
local function run(context)
    local function toolAdded(tool: Tool)
        if not tool:IsA("Tool") then
            return
        end

        local config = tool:WaitForChild("config",1) :: ModuleScript?

        if not config then
            return
        end

        PowerKit.new(context, tool)
    end

    Client.CharacterAdded:Connect(function()
        local Backpack = Client:WaitForChild("Backpack")
        
        Backpack.ChildAdded:Connect(toolAdded)
        for _, v in Backpack:GetChildren() do
            task.spawn(toolAdded, v)
        end
    end)
end

return {
    run = run;
    priority = 10;
}