--[[
    Raid Module - Raid Farming Logic
    Blox Fruits Script by Zlex Hub (Modularized)
]]

local Raid = {}

local Utils = nil

function Raid.Init(utils)
    Utils = utils
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer

Raid.RaidList = {
    "Flame Raid",
    "Ice Raid",
    "Quake Raid",
    "Dark Raid",
    "Light Raid",
    "Magma Raid",
    "Buddha Raid",
    "Sand Raid",
    "Rubber Raid",
    "Phoenix Raid",
    "Dough Raid",
    "Leopard Raid"
}

Raid.RaidCFrames = {
    ["Flame Raid"] = CFrame.new(-5337.4, 424.5, -2824.5),
    ["Ice Raid"] = CFrame.new(-5337.4, 424.5, -2824.5),
    ["Quake Raid"] = CFrame.new(-5337.4, 424.5, -2824.5),
    ["Dark Raid"] = CFrame.new(-5337.4, 424.5, -2824.5),
    ["Light Raid"] = CFrame.new(-5337.4, 424.5, -2824.5),
    ["Magma Raid"] = CFrame.new(-5337.4, 424.5, -2824.5),
    ["Buddha Raid"] = CFrame.new(-5337.4, 424.5, -2824.5),
    ["Sand Raid"] = CFrame.new(-5337.4, 424.5, -2824.5),
    ["Rubber Raid"] = CFrame.new(-5337.4, 424.5, -2824.5),
    ["Phoenix Raid"] = CFrame.new(-5337.4, 424.5, -2824.5),
    ["Dough Raid"] = CFrame.new(-5337.4, 424.5, -2824.5),
    ["Leopard Raid"] = CFrame.new(-5337.4, 424.5, -2824.5)
}

Raid.ChipPrices = {
    ["Flame Raid"] = 100000,
    ["Ice Raid"] = 100000,
    ["Quake Raid"] = 100000,
    ["Dark Raid"] = 100000,
    ["Light Raid"] = 100000,
    ["Magma Raid"] = 100000,
    ["Buddha Raid"] = 100000,
    ["Sand Raid"] = 100000,
    ["Rubber Raid"] = 100000,
    ["Phoenix Raid"] = 100000,
    ["Dough Raid"] = 100000,
    ["Leopard Raid"] = 100000
}

function Raid.IsInRaid()
    local playerGui = Player:FindFirstChild("PlayerGui")
    if playerGui then
        local raidUI = playerGui:FindFirstChild("RaidUI") or playerGui:FindFirstChild("Raid")
        if raidUI and raidUI.Visible then
            return true
        end
    end
    
    local raidIsland = Workspace:FindFirstChild("RaidIsland") or Workspace:FindFirstChild("_RaidIsland")
    return raidIsland ~= nil
end

function Raid.GetRaidEnemies()
    local enemies = {}
    local raidEnemies = Workspace:FindFirstChild("Enemies")
    
    if raidEnemies then
        for _, enemy in pairs(raidEnemies:GetChildren()) do
            local humanoid = enemy:FindFirstChild("Humanoid")
            local hrp = enemy:FindFirstChild("HumanoidRootPart")
            
            if humanoid and hrp and humanoid.Health > 0 then
                table.insert(enemies, enemy)
            end
        end
    end
    
    return enemies
end

function Raid.FindNearestRaidEnemy()
    local enemies = Raid.GetRaidEnemies()
    local nearest = nil
    local nearestDist = math.huge
    
    for _, enemy in ipairs(enemies) do
        local hrp = enemy:FindFirstChild("HumanoidRootPart")
        if hrp then
            local dist = Utils.DistanceTo(hrp.Position)
            if dist < nearestDist then
                nearest = enemy
                nearestDist = dist
            end
        end
    end
    
    return nearest, nearestDist
end

function Raid.FarmRaidEnemy(enemy)
    if not enemy then return end
    
    local hrp = enemy:FindFirstChild("HumanoidRootPart")
    local humanoid = enemy:FindFirstChild("Humanoid")
    
    if not hrp or not humanoid or humanoid.Health <= 0 then return end
    
    Utils.AutoHaki()
    Utils.EquipWeapon(_G.Settings.Main["Selected Weapon"])
    
    if _G.Settings.Main["Bring Monster"] then
        local playerHRP = Utils.GetHumanoidRootPart()
        if playerHRP then
            hrp.CFrame = playerHRP.CFrame * CFrame.new(0, 0, 3)
        end
    else
        Utils.TweenPlayer(hrp.CFrame * CFrame.new(0, 15, 0))
    end
    
    Utils.Attack()
    
    if _G.Settings.Raid["Use Skill In Raid"] then
        Utils.PressKey("Z")
        Utils.PressKey("X")
        Utils.PressKey("C")
        Utils.PressKey("V")
    end
end

function Raid.BuyChip(raidType)
    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and 
                  ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    if CommF then
        pcall(function()
            local fruitName = raidType:gsub(" Raid", "")
            CommF:InvokeServer("BuyRaidChip", fruitName)
        end)
    end
end

function Raid.StartRaid(raidType)
    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and 
                  ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    if CommF then
        pcall(function()
            local fruitName = raidType:gsub(" Raid", "")
            CommF:InvokeServer("StartRaid", fruitName)
        end)
    end
end

function Raid.TeleportToRaidNPC()
    local selectedRaid = _G.Settings.Raid["Selected Raid"]
    if not selectedRaid or selectedRaid == "None" then return end
    
    local cframe = Raid.RaidCFrames[selectedRaid]
    if cframe then
        local dist = Utils.DistanceTo(cframe.Position)
        if dist > 2000 then
            Utils.BTP(cframe)
        else
            Utils.TweenPlayer(cframe)
        end
    end
end

function Raid.MainLoop()
    if not _G.Settings.Raid["Auto Raid"] then return end
    if not Utils.IsAlive() then return end
    
    local selectedRaid = _G.Settings.Raid["Selected Raid"]
    if not selectedRaid or selectedRaid == "None" then return end
    
    if Raid.IsInRaid() then
        local enemy = Raid.FindNearestRaidEnemy()
        if enemy then
            Raid.FarmRaidEnemy(enemy)
        end
    else
        if _G.Settings.Raid["Auto Buy Chip"] then
            Raid.BuyChip(selectedRaid)
        end
        
        Raid.TeleportToRaidNPC()
        task.wait(0.5)
        Raid.StartRaid(selectedRaid)
    end
end

function Raid.Start()
    spawn(function()
        while true do
            if _G.Settings.Raid["Auto Raid"] then
                pcall(Raid.MainLoop)
            end
            task.wait(0.1)
        end
    end)
end

return Raid
