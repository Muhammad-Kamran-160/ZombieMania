remodel=remodel
--[[
    Remodel | Fetch Assets
    Author: Kamran / portodemesso
--]]

local game = remodel.readPlaceAsset("14763002908")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local StarterPlayer = game:GetService("StarterPlayer")
local StarterPlayerScripts = StarterPlayer.StarterPlayerScripts
local StarterCharacterScripts = StarterPlayer.StarterCharacterScripts

local function path(str, isModel)
    return "temp" .. (str or "") .. (isModel and ".rbxmx" or "")
end

local success, _ = pcall(function()
    remodel.removeDir(path())
end)

if not success then
    print("Removed existing temp directory")
end

local SERVICES = {"replicatedStorage", "serverStorage", "workspace", "lighting", "starterPlayerScripts", "starterCharacterScripts", "serverScriptService"}
local WORKSPACE_FOLDERS = {"Debris", "Powers"}

local ObjectMap = {
    {
        object = Workspace:FindFirstChild("Map");
        path = "/workspace/Map";
    },
    {
        object = ReplicatedStorage.Assets;
        path = "/replicatedStorage/Assets";
    },
    {
        object = ServerStorage.Assets;
        path = "/serverStorage/Assets";
    },
    {
        object = Workspace.Terrain;
        path = "/workspace/Terrain";
    },
    {
        object = Lighting.SkyBox;
        path = "/lighting/SkyBox";
    },
    {
        object = StarterPlayerScripts.ClientInit;
        path = "/starterPlayerScripts/ClientInit";
    },
    {
        object = StarterPlayerScripts.ClientModules;
        path = "/starterPlayerScripts/ClientModules";
    },
    {
        object = StarterCharacterScripts.MoreSpeed;
        path = "/starterCharacterScripts/MoreSpeed";
    }
}

for _, v in ipairs(SERVICES) do
    remodel.createDirAll(path("/" .. v))
end

for _, v in ipairs(WORKSPACE_FOLDERS) do
    local folder = Instance.new("Folder")
    folder.Name = v

    remodel.writeModelFile(path("/workspace/" .. v, true), folder)
end

for _, v in ipairs(ObjectMap) do
    remodel.writeModelFile(path(v.path, true), v.object)
end

