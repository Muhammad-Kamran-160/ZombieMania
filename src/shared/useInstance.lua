--[[
    useInstance
    Author: Kamran / portodemesso
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Matter = require(ReplicatedStorage.Packages.matter)

local function cleanup(storage)
    storage.instance:Destroy()
end

return function(instanceType: string, properties: { string: any }, discriminator: number?)
    local storage = Matter.useHookState(discriminator, cleanup)

    if not storage.instance then
        local instance = Instance.new(instanceType)

        for propName, propValue in properties do
            instance[propName] = propValue
        end

        storage.instance = instance
    end

    return storage.instance :: Instance
end