--[[
    Zombie Functionality
   Author: Kamran / portodemesso
--]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local import = require(ReplicatedStorage.LocalPackages.import)

local NPCs = import("data/npcs")
local ZombieData = NPCs.zombie

local Matter = import("packages/matter")
local useThrottle = Matter.useThrottle

local Components = import("data/components")
local NPC = Components.NPC.NPC
local Zombie = Components.NPC.Zombie
local Tracking = Components.NPC.Tracking
local Character = Components.Base.Character
local PlayerDamage = Components.Space.PlayerDamage

local ZombieAnimation = Instance.new("Animation")
ZombieAnimation.AnimationId = "rbxassetid://12426288738"

-- Variables
local Random = Random.new(os.clock())

-- Main
local function system(world, context)
	-- Load animations
	for id, record in world:queryChanged(Character) do
		local old, new = record.old, record.new

		if old or not new then
			continue
		end

		local zombie = world:get(id, Zombie)
		if not zombie then
			continue
		end

		world:insert(
			id,
			zombie:patch({
				spawnTime = os.clock();
			})
		)

		local humanoid = new.instance:FindFirstChildWhichIsA("Humanoid") :: Humanoid?
		if not humanoid then
			continue
		end

		humanoid.WalkSpeed = 12

		new.animations.main:Play()

		humanoid.Parent.PrimaryPart.Idle:Play()
	end

	for id, character, zombie in world:query(Character, Zombie) do
		local maxLifetime = zombie.maxLifetime
		if not maxLifetime then
			continue
		end

		local lifetime = os.clock() - zombie.spawnTime

		if lifetime > maxLifetime then
			character.instance.PrimaryPart.Hurt:Play()
			if world:contains(id) then
				world:despawn(id)
			else
				character.instance:Destroy()
			end
		end
	end

	for id, character, zombie in world:query(Character, Zombie) do
		local characterInstance = character.instance
		if characterInstance then
			local humanoid = characterInstance:FindFirstChildWhichIsA("Humanoid")
			if humanoid then
				for _, value in Matter.useEvent(humanoid, "Died") do
					world:despawn(id)
				end
			end	
		end
	end

	-- Deal damage to target
	for id, character, tracking, zombie in world:query(Character, Tracking, Zombie) do

		local target = tracking.target

		if not zombie.dealMeleeDamage then
			continue
		end

		if not Matter.useThrottle(.5, id) then
			continue
		end

		if target then
			local targetPosition = target:GetPivot().Position
			local characterPosition = character.instance:GetPivot().Position

			if (targetPosition - characterPosition).Magnitude <= 2.5 then
				character.instance.PrimaryPart.Grunt:Play()
				world:spawn(
					PlayerDamage {
						origin = character.instance;
						target = target;
						damage = 5;
					}
				) 
			end
		end
	end

	--Deal Custom Damage



	for id, character, zombie in world:query(Character, Zombie) do
		if not zombie.target then
			continue
		end
		local targetPosition = zombie.target
		local characterPosition = character.instance:GetPivot().Position
		local originCharater = character.instance
		local humanoidRootPart = originCharater.PrimaryPart

		for _, child in pairs(originCharater:GetChildren()) do
			if child:IsA("BasePart") or child:IsA("MeshPart") then
				for _, part in Matter.useEvent(child, "Touched") do
					if not part.Parent then
						continue
					end

					local humanoid = part.Parent:FindFirstChildWhichIsA("Humanoid")

					if humanoid then
						local targetCharacter = humanoid.Parent
						if part == targetCharacter.PrimaryPart then
							if zombie.owner then
								if humanoid.Parent ~= zombie.owner then
									world:spawn(
										PlayerDamage {
											origin = humanoidRootPart.Parent;
											target = targetCharacter;
											damage = zombie.customDamage;
										}
									) 
								end
							end
							if world:contains(id) then
								character.instance.PrimaryPart.Hurt:Play()
								world:despawn(id)
							end
						end
					end
				end
			end
		end

		if (targetPosition - characterPosition).Magnitude <= 2.6 then
			if world:contains(id) then
				character.instance.PrimaryPart.Hurt:Play()
				world:despawn(id)
			end
		end
	end
end

return {
	system = system;
	priority = 5;
}