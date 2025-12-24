--[[
    Boss Farm Module - Boss Farming Logic
    Blox Fruits Script by Zlex Hub (Modularized)
]]

local BossFarm = {}

local Utils = nil
local QuestData = nil

function BossFarm.Init(utils, questData)
    Utils = utils
    QuestData = questData
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer

BossFarm.BossList = {
    {Name = "Gorilla King", Level = 25, World = 1, CFrame = CFrame.new(-1129.3, 10.9, -524.2), QuestId = "JungleQuest"},
    {Name = "Bobby", Level = 55, World = 1, CFrame = CFrame.new(-1350.1, 30.5, 4405.2), QuestId = "BuggyQuest1"},
    {Name = "Saber Expert", Level = 200, World = 1, CFrame = CFrame.new(-1579.5, 35.7, -52.7), QuestId = "SwordQuest"},
    {Name = "The Saw", Level = 100, World = 1, CFrame = CFrame.new(-5305.5, 22.5, 3893.6), QuestId = "MarineQuest2"},
    {Name = "Greybeard", Level = 750, World = 1, CFrame = CFrame.new(-4943.5, 82.5, 4381.6), QuestId = "MarineQuest2"},
    {Name = "Yeti", Level = 110, World = 1, CFrame = CFrame.new(1203.7, 150.5, -1422.8), QuestId = "SnowQuest"},
    {Name = "Vice Admiral", Level = 130, World = 1, CFrame = CFrame.new(-5045.5, 30.5, 4322.6), QuestId = "MarineQuest2"},
    {Name = "Warden", Level = 200, World = 1, CFrame = CFrame.new(4851.3, 4.5, 738.8), QuestId = "PrisonQuest"},
    {Name = "Chief Warden", Level = 220, World = 1, CFrame = CFrame.new(5305.5, 0.9, 476.1), QuestId = "PrisonQuest"},
    {Name = "Swan", Level = 775, World = 2, CFrame = CFrame.new(-456.6, 75.8, 299.5), QuestId = "SwanQuest"},
    {Name = "Don Swan", Level = 1000, World = 2, CFrame = CFrame.new(881.3, 126.5, 1424.9), QuestId = "DonSwan"},
    {Name = "Jeremy", Level = 850, World = 2, CFrame = CFrame.new(-5570.4, 48.5, -784.4), QuestId = "ZombieQuest"},
    {Name = "Cursed Captain", Level = 1325, World = 2, CFrame = CFrame.new(916.7, 191.5, 33243.5), QuestId = "ShipQuest1"},
    {Name = "Awakened Ice Admiral", Level = 1400, World = 2, CFrame = CFrame.new(5721.5, 91.5, -6586.6), QuestId = "FrostQuest"},
    {Name = "Tide Keeper", Level = 1475, World = 2, CFrame = CFrame.new(-3053.9, 518.5, -10004.2), QuestId = "ForgottenQuest"},
    {Name = "Stone", Level = 1550, World = 3, CFrame = CFrame.new(-11019.6, 325.6, -8871.7), QuestId = "GraveyardQuest"},
    {Name = "Island Empress", Level = 1675, World = 3, CFrame = CFrame.new(-1862.4, 37.9, -9914.9), QuestId = "NutQuest"},
    {Name = "Cake Queen", Level = 1825, World = 3, CFrame = CFrame.new(-2089.7, 104.9, -11408.2), QuestId = "CakeQuest"},
    {Name = "Dough King", Level = 2200, World = 3, CFrame = CFrame.new(385.1, 44.9, -12307.6), QuestId = "ChocolateQuest"},
    {Name = "Captain Elephant", Level = 2000, World = 3, CFrame = CFrame.new(5343.2, 601.6, -106.8), QuestId = "TikiQuest"},
    {Name = "Beautiful Pirate", Level = 1950, World = 3, CFrame = CFrame.new(-1151.9, 24.9, -12991.4), QuestId = "CandyQuest"},
    {Name = "Kitsune Island Boss", Level = 2350, World = 3, CFrame = CFrame.new(-13597.3, 534.4, -8742.9), QuestId = "MushroomQuest"},
    {Name = "Lava Golem", Level = 2600, World = 3, CFrame = CFrame.new(-9649.4, 340.5, 6510.9), QuestId = "DragonDojoQuest"}
}

function BossFarm.GetBossNames()
    local names = {}
    local world = Utils.GetWorld()
    for _, boss in ipairs(BossFarm.BossList) do
        if boss.World == world then
            table.insert(names, boss.Name)
        end
    end
    return names
end

function BossFarm.GetBossData(bossName)
    for _, boss in ipairs(BossFarm.BossList) do
        if boss.Name == bossName then
            return boss
        end
    end
    return nil
end

function BossFarm.FindBoss(bossName)
    local enemies = game:GetService("Workspace"):FindFirstChild("Enemies")
    if not enemies then return nil end
    
    for _, enemy in pairs(enemies:GetChildren()) do
        if enemy.Name == bossName or string.find(enemy.Name, bossName) then
            local humanoid = enemy:FindFirstChild("Humanoid")
            local hrp = enemy:FindFirstChild("HumanoidRootPart")
            if humanoid and hrp and humanoid.Health > 0 then
                return enemy
            end
        end
    end
    return nil
end

function BossFarm.FarmBoss(boss)
    if not boss then return end
    
    local hrp = boss:FindFirstChild("HumanoidRootPart")
    local humanoid = boss:FindFirstChild("Humanoid")
    
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
end

function BossFarm.TeleportToBossSpawn()
    local selectedBoss = _G.Settings.Boss["Selected Boss"]
    if not selectedBoss or selectedBoss == "None" then return end
    
    local bossData = BossFarm.GetBossData(selectedBoss)
    if bossData then
        local dist = Utils.DistanceTo(bossData.CFrame.Position)
        if dist > 2000 then
            Utils.BTP(bossData.CFrame)
        else
            Utils.TweenPlayer(bossData.CFrame)
        end
    end
end

function BossFarm.MainLoop()
    if not _G.Settings.Boss["Auto Farm Boss"] then return end
    
    local selectedBoss = _G.Settings.Boss["Selected Boss"]
    if not selectedBoss or selectedBoss == "None" then return end
    
    if not Utils.IsAlive() then
        task.wait(1)
        return
    end
    
    if _G.Settings.Boss["Attack All Bosses"] then
        local enemies = game:GetService("Workspace"):FindFirstChild("Enemies")
        if enemies then
            for _, boss in ipairs(BossFarm.BossList) do
                if boss.World == Utils.GetWorld() then
                    local foundBoss = BossFarm.FindBoss(boss.Name)
                    if foundBoss then
                        BossFarm.FarmBoss(foundBoss)
                        return
                    end
                end
            end
        end
    else
        local boss = BossFarm.FindBoss(selectedBoss)
        if boss then
            BossFarm.FarmBoss(boss)
        else
            BossFarm.TeleportToBossSpawn()
        end
    end
end

function BossFarm.Start()
    spawn(function()
        while true do
            if _G.Settings.Boss["Auto Farm Boss"] then
                pcall(BossFarm.MainLoop)
            end
            task.wait(0.1)
        end
    end)
end

return BossFarm
