--[[
    useTempData
    Author: Kamran / portodemesso
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local import = require(ReplicatedStorage.LocalPackages.import)

local Matter = import("packages/matter")

return function(discriminator)
    return Matter.useHookState(discriminator)
end