--[[
    initZombieSpawning
    Author: Kamran / portodemesso
--]]

local import = require(game.ReplicatedStorage.LocalPackages.import)

local Components = import("data/components")
local NPC = Components.NPC.NPC
local MoveTo = Components.Space.MoveTo
local Zombie = Components.NPC.Zombie
local Tracking = Components.NPC.Tracking

local function run(context)
    
    local excludedIds = {} -- excluded players should be none for now
    local world = context.world

	local function update()
		table.insert(excludedIds, world:spawn(
                NPC {
                    type = "zombie";
                    spawnPoint = CFrame.new(0,8,0);
                    sounds = {
                        ["Idle"] = "rbxassetid://12637719187";
                        ["Hurt"] = "rbxassetid://12637718796"; 
                        ["Grunt"] = "rbxassetid://12637718959";
                    };
                },
                Tracking {
                    mode = "constant"; 
                    exclude = excludedIds;
                },
                MoveTo {
                    useTracking = true; 
                    usePathfinding = true;
                    minDistance = 2; 
                },
                Zombie {
                    dealMeleeDamage = true;
                    maxLifetime = 60;
                }
                ))
    end

    while true do
		update(context)
        task.wait(15)
    end
end

return {
    run = coroutine.wrap(run);
    priority = 2;
}