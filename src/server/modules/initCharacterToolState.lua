--[[
    initCharacterToolState
    Author: Kamran / portodemesso
--]]

-- Services
local Players = game:GetService("Players")

-- Constants

-- Variables

-- Main
local function run()
    local function playerAdded(player: Player)
        player.CharacterAdded:Connect(function(character)
            local humanoid = character:WaitForChild("Humanoid")

            humanoid.HealthChanged:Connect(function()
                local health = humanoid.Health

                if not (health > 0) then
                    for _, directory in { player.Backpack, character } do
                        for _, v in directory:GetChildren() do
                            if v:IsA("Tool") then
                                v.ManualActivationOnly = true
                            end
                        end
                    end
                end
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