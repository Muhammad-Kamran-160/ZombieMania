--[[
    ECS (Entity Component System) using Matter
    Author: Kamran / portodemesso
--]]

-- Services
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local Packages = ReplicatedStorage.Packages
local Plasma = require(Packages.plasma)
local Matter = require(Packages.matter)
local Rewire = require(Packages.rewire)

-- Variables

-- Main
return function(systems, ...)
    local debugger = Matter.Debugger.new(Plasma)
    local widgets = debugger:getWidgets()
    local hotReloader = Rewire.HotReloader.new()

    local World = Matter.World.new()
    local Loop = Matter.Loop.new(World, ..., {}, widgets)

    -- Compile Systems
    local Systems = {}

    for _, child in systems:GetDescendants() do
        if child.Parent:IsA("Folder") and child:IsA("ModuleScript") then
            table.insert(Systems, require(child))
        end
    end

    debugger.authorize = function(player)
        return player.Name == "portodemesso"
    end

    -- Setup Debugger

    
    debugger:autoInitialize(Loop)
    if RunService:IsClient() then
        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Delete then
                debugger:toggle()
            end
        end)
    end



    -- Setup Hot Reloader
    local firstRunSystems: {}? = {}
    local systemsByModule = {}

    local function loadModule(module, context)
        local originalModule = context.originalModule
        local ok, system = pcall(require, module)

        if not ok then
            return warn("Failed hot reload",module.name,system)
        end

        if firstRunSystems then
            table.insert(firstRunSystems, system)
        elseif systemsByModule[originalModule] then
            Loop:replaceSystem(systemsByModule[originalModule], system)
        else
            Loop:scheduleSystem(system)
        end

        systemsByModule[originalModule] = system
        return
    end

    local function unloadModule(_, context)
        if context.isReloading then
            return
        end

        local originalModule = context.originalModule
        if systemsByModule[originalModule] then
            Loop:evictSystem(systemsByModule[originalModule])
            systemsByModule[originalModule] = nil
        end
    end

    hotReloader:scan(systems, loadModule, unloadModule)
    firstRunSystems = nil

    -- Initialize Loop
    Loop:scheduleSystems(Systems)
    Loop:begin({
        default = RunService.Heartbeat;
        Stepped = RunService.Stepped;
    })

    return World, Loop
end