--[[
    initToolRegisterServer
    Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local PowerKitServer = import("utils/powerKitServer")
-- Variables

-- Main
local function run(context)
	local function toolAdded(tool: Tool)
		if not tool:IsA("Tool") then
			return
		end
		local config = tool:FindFirstChild("config") :: ModuleScript?

		if not config then
			return
		end
		PowerKitServer.new(context, tool)
	end

	local function playerAdded(player: Player)
		local function characterAdded(_: Model)
			local Backpack = player:WaitForChild("Backpack") :: Backpack

			Backpack:ClearAllChildren()

				local allTools = ServerStorage.Assets.powerTools:GetChildren()

				for _, tool in pairs(allTools) do
					local clonedTool = tool:Clone()
					clonedTool.Parent = Backpack
				end

			Backpack.ChildAdded:Connect(toolAdded)
			for _, v in Backpack:GetChildren() do
				task.spawn(toolAdded, v)
			end
		end

		player.CharacterAdded:Connect(characterAdded)
		if player.Character then
			characterAdded(player.Character)
		end
	end

	Players.PlayerAdded:Connect(playerAdded)
	for _, v in Players:GetPlayers() do
		task.spawn(playerAdded, v)
	end
end

return {
	run = run;
	priority = 10;
}