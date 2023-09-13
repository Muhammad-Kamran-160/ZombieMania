--[[
    useMemo
    Author: Kamran / portodemesso
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local import = require(ReplicatedStorage.LocalPackages.import)

local Matter = import("packages/matter")

local useHookState = Matter.useHookState

type MemoDestructor = (any?) -> ()

type MemoStorage = {
    args: { any? };
    value: any?;
    initialized: boolean?;
    destructor: (a: any) -> any?;
}

type MemoFunction = () -> (any?, MemoDestructor)

local function useMemo(func: MemoFunction, ...: any?): ...any?
    local args = {...}

    local storage: MemoStorage = useHookState(nil, function(curStorage: MemoStorage)
        if (curStorage.initialized and curStorage.destructor) and curStorage.value ~= nil then
            curStorage.destructor(curStorage.value)
        end
    end)

    if not storage.args then
        storage.args = {}
        storage.initialized = false
    end

    if storage.args then
        if (#storage.args ~= #args) or (not storage.initialized and #storage.args == 0 and #args == 0) then
            if storage.destructor and storage.value ~= nil then
                storage.destructor(storage.value)
            end

            storage.args = args
            storage.value, storage.destructor = func(unpack(args))
            storage.initialized = true

            return storage.value
        end
    end

    for k, v in args do
        if v ~= storage.args[k] then
            if storage.destructor and storage.value ~= nil then
                storage.destructor(storage.value)
            end

            storage.args = args
            storage.value, storage.destructor = func(unpack(args))
            storage.initialized = true

            return storage.value
        end
    end

    return storage.value
end

return useMemo