--[[
    Teleport Module - Teleportation Functions and Locations
    Blox Fruits Script by Zlex Hub (Modularized)
]]

local Teleport = {}

local Utils = nil

function Teleport.Init(utils)
    Utils = utils
end

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer

Teleport.PlaceIds = {
    ["First Sea"] = 2753915549,
    ["Second Sea"] = 4442272183,
    ["Third Sea"] = 7449423635
}

Teleport.World1Islands = {
    {Name = "Starter Island", CFrame = CFrame.new(1060.7, 17.7, 1548.9)},
    {Name = "Jungle Island", CFrame = CFrame.new(-1596.5, 36.5, 152.2)},
    {Name = "Pirate Village", CFrame = CFrame.new(-1139.5, 4.7, 3826.1)},
    {Name = "Desert Island", CFrame = CFrame.new(939.3, 20.6, 4374.3)},
    {Name = "Frozen Village", CFrame = CFrame.new(1342.5, 87.4, -1296.8)},
    {Name = "Marine Fortress", CFrame = CFrame.new(-4838.6, 21.4, 4345.2)},
    {Name = "Skylands", CFrame = CFrame.new(-4855.7, 717.8, -2660.2)},
    {Name = "Prison", CFrame = CFrame.new(5305.5, 0.9, 476.1)},
    {Name = "Colosseum", CFrame = CFrame.new(-1460.8, 7.3, -2835.9)},
    {Name = "Magma Village", CFrame = CFrame.new(-5333.1, 12.6, 8523.1)},
    {Name = "Underwater City", CFrame = CFrame.new(61075.4, 18.4, 1560.3)},
    {Name = "Fountain City", CFrame = CFrame.new(-7908.9, 5569.4, -1405.9)},
    {Name = "Galley", CFrame = CFrame.new(-301.7, 7.8, 5583.5)}
}

Teleport.World2Islands = {
    {Name = "Kingdom of Rose", CFrame = CFrame.new(-430.1, 72.9, 1835.4)},
    {Name = "Usoap's Island", CFrame = CFrame.new(-13440.1, 332.8, -7656.6)},
    {Name = "Green Zone", CFrame = CFrame.new(-2440.5, 72.6, -3213.6)},
    {Name = "Graveyard", CFrame = CFrame.new(-5570.4, 48.5, -784.4)},
    {Name = "Snow Mountain", CFrame = CFrame.new(5623.7, 403.4, -6344.5)},
    {Name = "Hot and Cold", CFrame = CFrame.new(-6105.9, 15.4, -4898.7)},
    {Name = "Cursed Ship", CFrame = CFrame.new(916.7, 191.5, 33243.5)},
    {Name = "Ice Castle", CFrame = CFrame.new(5721.5, 91.5, -6586.6)},
    {Name = "Forgotten Island", CFrame = CFrame.new(-3053.9, 237.4, -10149.2)}
}

Teleport.World3Islands = {
    {Name = "Port Town", CFrame = CFrame.new(-12083.4, 332.4, -7586.5)},
    {Name = "Haunted Castle", CFrame = CFrame.new(-9476.2, 144.2, -8888.4)},
    {Name = "Peanut Island", CFrame = CFrame.new(-2127.6, 35.0, -10103.8)},
    {Name = "Ice Cream Island", CFrame = CFrame.new(-793.3, 80.8, -10978.9)},
    {Name = "Cake Island", CFrame = CFrame.new(-2037.3, 35.5, -12188.1)},
    {Name = "Chocolate Land", CFrame = CFrame.new(236.7, 48.6, -12481.1)},
    {Name = "Candy Island", CFrame = CFrame.new(-871.8, 42.4, -12770.7)},
    {Name = "Tiki Outpost", CFrame = CFrame.new(5343.2, 601.6, -106.8)},
    {Name = "Mushroom Kingdom", CFrame = CFrame.new(-13372.7, 513.8, -7610.6)},
    {Name = "Kittguin Island", CFrame = CFrame.new(-14458.9, 499.1, -10174.3)},
    {Name = "Dragon Dojo", CFrame = CFrame.new(-9842.5, 340.5, 6253.7)}
}

function Teleport.GetIslandList()
    local world = Utils.GetWorld()
    if world == 1 then
        return Teleport.World1Islands
    elseif world == 2 then
        return Teleport.World2Islands
    elseif world == 3 then
        return Teleport.World3Islands
    end
    return Teleport.World1Islands
end

function Teleport.GetIslandNames()
    local islands = Teleport.GetIslandList()
    local names = {}
    for _, island in ipairs(islands) do
        table.insert(names, island.Name)
    end
    return names
end

function Teleport.GetIslandCFrame(islandName)
    local islands = Teleport.GetIslandList()
    for _, island in ipairs(islands) do
        if island.Name == islandName then
            return island.CFrame
        end
    end
    return nil
end

function Teleport.TeleportToIsland(islandName)
    local cframe = Teleport.GetIslandCFrame(islandName)
    if cframe then
        Utils.TweenPlayer(cframe)
    end
end

function Teleport.TeleportToWorld(worldName)
    local placeId = Teleport.PlaceIds[worldName]
    if placeId then
        TeleportService:Teleport(placeId, Player)
    end
end

function Teleport.TeleportToPosition(position)
    if typeof(position) == "Vector3" then
        Utils.TweenPlayer(CFrame.new(position))
    elseif typeof(position) == "CFrame" then
        Utils.TweenPlayer(position)
    end
end

function Teleport.TeleportToPlayer(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character then
        local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            Utils.TweenPlayer(hrp.CFrame * CFrame.new(0, 5, 0))
        end
    end
end

function Teleport.ServerHop()
    pcall(function()
        local servers = HttpService:JSONDecode(
            game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
        )
        
        for _, server in pairs(servers.data) do
            if server.id ~= game.JobId and server.playing < server.maxPlayers then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id)
                break
            end
        end
    end)
end

function Teleport.Rejoin()
    TeleportService:Teleport(game.PlaceId, Player)
end

function Teleport.VIPServerHop(vipLink)
    if vipLink and vipLink ~= "" then
        TeleportService:TeleportToPrivateServer(game.PlaceId, vipLink, Player)
    end
end

function Teleport.CustomTeleportLoop()
    if not _G.Settings.Teleport["Custom Teleport"] then return end
    
    local selectedIsland = _G.Settings.Teleport["Selected Island"]
    if selectedIsland then
        Teleport.TeleportToIsland(selectedIsland)
    end
end

function Teleport.Start()
    spawn(function()
        while true do
            if _G.Settings.Teleport["Custom Teleport"] then
                pcall(Teleport.CustomTeleportLoop)
            end
            task.wait(1)
        end
    end)
end

return Teleport
