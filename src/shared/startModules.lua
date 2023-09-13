--[[
    Start Modules
    Author: Kamran / portodemesso
--]]

-- Services

-- Constants

-- Variables
local DEFAULT_PRIORITY_START = 100

-- Function
local function VerifyModule(module)
    if type(module) == "function" then
        return true
    elseif type(module) == "table" then
        if module.run then
            return true
        end
    end

    return
end

local function GetModulePriority(module)
    if type(module) == "table" then
        return module.priority
    end

    return
end

local function GetModuleFunction(module)
    if type(module) == "function" then
        return module
    else
        return module.run
    end
end

-- Main
return function(path, returnFunction, ...)
    local modules = {}

    -- Populate Modules
    for index, object in path:GetChildren() do
        if object:IsA("ModuleScript") then
            local success, module = pcall(require, object)
            assert(success, string.format("An error occurred while loading %s: %s", object:GetFullName(), tostring(module)))
            assert(VerifyModule(module), string.format("error starting modules: module %s is invalid", object.Name))

            local run = GetModuleFunction(module)
            assert(run, string.format("error starting modules: module %s has no run function", object.Name))

            local priority = GetModulePriority(module)
            assert(priority == nil or type(priority) == "number", string.format("error starting modules: module %s has an invalid priority", object.Name))

            table.insert(modules, {
                run = run;
                priority = priority or (DEFAULT_PRIORITY_START + index);
            })
        end
    end

    -- Sort Modules
    table.sort(modules, function(a, b)
        return a.priority < b.priority
    end)

    -- Run Modules
    local function run(...)
        for _, module in modules do
            module.run(...)
        end
    end

    if returnFunction then
        return run
    else
        run(...)
    end

    return
end