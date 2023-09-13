--[[
    initCharacterReloading
    Author: Kamran / portodemesso
--]]

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)
local Remotes = import("data/remotes")
local SetState = Remotes.Server:Get("SetState")

-- Variables


-- Main
local function removeDuplicates(namesTable)
    local uniqueNames = {}
    local resultTable = {}

    for _, name in ipairs(namesTable) do
        if not uniqueNames[name] then
            table.insert(resultTable, name)
            uniqueNames[name] = true
        end
    end

    return resultTable
end

local function run()
	local function playerAdded(player: Player)
		player.CharacterAdded:Connect(function(character)
			local humanoid = character:WaitForChild("Humanoid")
			player:SetAttribute("KillFeed", false)

			player:GetAttributeChangedSignal("KillFeed"):Connect(function()
				if player:GetAttribute("KillFeed") == true then
					task.delay(2, function()
						player:SetAttribute("KillFeed", false)
						SetState:SendToPlayer(player, "KillFeedTextVisible", false)
					end)
				end
			end)

			humanoid.Died:Connect(function()
				
				local plr = game.Players:GetPlayerFromCharacter(humanoid.Parent)
				local tools = {}

				for _, tool in pairs(plr:FindFirstChild("Backpack"):GetChildren()) do
					table.insert(tools, tool.Name) 
				end

				local filteredTable = removeDuplicates(tools)

				plr:SetAttribute("Tools", HttpService:JSONEncode(filteredTable))

				task.delay(6, function()
					if player.Character ~= character then
						return
					end
					player:LoadCharacter()
				end)
			end)
		end)
	end

	Players.PlayerAdded:Connect(playerAdded)
	for _, v in Players:GetPlayers() do
		task.spawn(playerAdded, v)
	end 
end

return {
	run = run;
	priority = 5;
}