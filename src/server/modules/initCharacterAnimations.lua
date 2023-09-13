--[[
    initCharacterAnimations
    Author: Kamran / portodemesso
--]]

-- Services
local Players = game:GetService("Players")

-- Constants

-- Variables

-- Main
local function run()
    if true then
        return -- DISABLED
    end
    
    local function playerAdded(player: Player)
        player.CharacterAdded:Connect(function(character)
            local humanoid = character:WaitForChild("Humanoid")
            local animator = humanoid:WaitForChild("Animator")

            for _, playingTrack in pairs(animator:GetPlayingAnimationTracks()) do
                playingTrack:Stop(0)
            end

            local animateScript = character:WaitForChild("Animate")
            animateScript.run.RunAnim.AnimationId = "rbxassetid://11839509475"
            animateScript.walk.WalkAnim.AnimationId = "rbxassetid://11839507382"
            animateScript.jump.JumpAnim.AnimationId = "rbxassetid://11839503186"
            animateScript.fall.FallAnim.AnimationId = "rbxassetid://11839505100"
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