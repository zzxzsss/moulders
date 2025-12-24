--[[
    Quest Data Module - CheckQuest Function with All Quest Data
    Blox Fruits Script by Zlex Hub (Modularized)
]]

local QuestData = {}

local Utils = nil

function QuestData.Init(utils)
    Utils = utils
end

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

function QuestData.GetPlayerLevel()
    local data = Player:FindFirstChild("Data")
    if data then
        local level = data:FindFirstChild("Level")
        if level then
            return level.Value
        end
    end
    return 0
end

QuestData.World1Quests = {
    {Level = 1, Monster = "Bandit", QuestId = "BanditQuest1", CFrame = CFrame.new(1060.7, 17.7, 1548.9)},
    {Level = 10, Monster = "Monkey", QuestId = "JungleQuest", CFrame = CFrame.new(-1596.5, 36.5, 152.2)},
    {Level = 15, Monster = "Gorilla", QuestId = "JungleQuest", CFrame = CFrame.new(-1129.3, 10.9, -524.2)},
    {Level = 20, Monster = "Pirate", QuestId = "BuggyQuest1", CFrame = CFrame.new(-1139.5, 4.7, 3826.1)},
    {Level = 30, Monster = "Brute", QuestId = "BuggyQuest1", CFrame = CFrame.new(-1350.1, 30.5, 4405.2)},
    {Level = 40, Monster = "Desert Bandit", QuestId = "DesertQuest", CFrame = CFrame.new(939.3, 20.6, 4374.3)},
    {Level = 60, Monster = "Desert Officer", QuestId = "DesertQuest", CFrame = CFrame.new(1580.5, 9.1, 4276.7)},
    {Level = 75, Monster = "Snow Bandit", QuestId = "SnowQuest", CFrame = CFrame.new(1342.5, 87.4, -1296.8)},
    {Level = 90, Monster = "Snowman", QuestId = "SnowQuest", CFrame = CFrame.new(1203.7, 111.8, -1550.7)},
    {Level = 100, Monster = "Chief Petty Officer", QuestId = "MarineQuest2", CFrame = CFrame.new(-4838.6, 21.4, 4345.2)},
    {Level = 120, Monster = "Sky Bandit", QuestId = "SkyQuest", CFrame = CFrame.new(-4855.7, 717.8, -2660.2)},
    {Level = 150, Monster = "Dark Master", QuestId = "SkyQuest", CFrame = CFrame.new(-5005.5, 312.0, -4829.4)},
    {Level = 175, Monster = "Prisoner", QuestId = "PrisonQuest", CFrame = CFrame.new(5305.5, 0.9, 476.1)},
    {Level = 190, Monster = "Dangerous Prisoner", QuestId = "PrisonQuest", CFrame = CFrame.new(5689.9, 0.9, -505.5)},
    {Level = 200, Monster = "Toga Warrior", QuestId = "ColosseumQuest", CFrame = CFrame.new(-1460.8, 7.3, -2835.9)},
    {Level = 225, Monster = "Gladiator", QuestId = "ColosseumQuest", CFrame = CFrame.new(-1491.8, 7.3, -2978.2)},
    {Level = 250, Monster = "Military Soldier", QuestId = "MagmaQuest", CFrame = CFrame.new(-5333.1, 12.6, 8523.1)},
    {Level = 275, Monster = "Military Spy", QuestId = "MagmaQuest", CFrame = CFrame.new(-5757.3, 70.7, 8871.5)},
    {Level = 300, Monster = "Fishman Warrior", QuestId = "FishmanQuest", CFrame = CFrame.new(61075.4, 18.4, 1560.3)},
    {Level = 325, Monster = "Fishman Commando", QuestId = "FishmanQuest", CFrame = CFrame.new(61324.0, 51.8, 1097.9)},
    {Level = 350, Monster = "God's Guards", QuestId = "SkyIslandQuest", CFrame = CFrame.new(-4973.4, 839.8, -2761.9)},
    {Level = 375, Monster = "Shanda", QuestId = "SkyIslandQuest", CFrame = CFrame.new(-7830.6, 5560.4, -381.7)},
    {Level = 400, Monster = "Royal Squad", QuestId = "FountainQuest", CFrame = CFrame.new(-7908.9, 5569.4, -1405.9)},
    {Level = 425, Monster = "Royal Soldier", QuestId = "FountainQuest", CFrame = CFrame.new(-7644.2, 5539.1, -1912.3)},
    {Level = 450, Monster = "Galley Pirate", QuestId = "GalleyQuest", CFrame = CFrame.new(-301.7, 7.8, 5583.5)},
    {Level = 475, Monster = "Galley Captain", QuestId = "GalleyQuest", CFrame = CFrame.new(298.7, 7.8, 5678.2)}
}

QuestData.World2Quests = {
    {Level = 700, Monster = "Raider", QuestId = "AreaQuest2", CFrame = CFrame.new(-430.1, 72.9, 1835.4)},
    {Level = 725, Monster = "Mercenary", QuestId = "AreaQuest2", CFrame = CFrame.new(681.5, 73.1, 1557.7)},
    {Level = 750, Monster = "Swan Pirate", QuestId = "SwanQuest", CFrame = CFrame.new(773.8, 122.3, 1424.9)},
    {Level = 775, Monster = "Factory Staff", QuestId = "AreaQuest2", CFrame = CFrame.new(646.4, 39.7, -151.6)},
    {Level = 800, Monster = "Marine Lieutenant", QuestId = "MarineQuest3", CFrame = CFrame.new(-2440.5, 72.6, -3213.6)},
    {Level = 825, Monster = "Marine Captain", QuestId = "MarineQuest3", CFrame = CFrame.new(-2208.7, 72.6, -3415.7)},
    {Level = 850, Monster = "Zombie", QuestId = "ZombieQuest", CFrame = CFrame.new(-5570.4, 48.5, -784.4)},
    {Level = 875, Monster = "Vampire", QuestId = "ZombieQuest", CFrame = CFrame.new(-5875.5, 36.3, -839.1)},
    {Level = 900, Monster = "Snow Trooper", QuestId = "IceSideQuest", CFrame = CFrame.new(5623.7, 403.4, -6344.5)},
    {Level = 925, Monster = "Winter Warrior", QuestId = "IceSideQuest", CFrame = CFrame.new(5901.9, 28.7, -5207.9)},
    {Level = 950, Monster = "Lab Subordinate", QuestId = "IceSideQuest", CFrame = CFrame.new(-6105.9, 15.4, -4898.7)},
    {Level = 975, Monster = "Horned Warrior", QuestId = "IceSideQuest", CFrame = CFrame.new(-6579.9, 69.7, -4835.5)},
    {Level = 1000, Monster = "Magma Ninja", QuestId = "FireSideQuest", CFrame = CFrame.new(-5439.8, 21.3, 8439.7)},
    {Level = 1050, Monster = "Lava Pirate", QuestId = "FireSideQuest", CFrame = CFrame.new(-5309.9, 11.6, 8864.4)},
    {Level = 1100, Monster = "Ship Deckhand", QuestId = "ShipQuest1", CFrame = CFrame.new(1037.7, 125.1, 32882.1)},
    {Level = 1125, Monster = "Ship Engineer", QuestId = "ShipQuest1", CFrame = CFrame.new(917.3, 160.0, 32837.9)},
    {Level = 1150, Monster = "Ship Steward", QuestId = "ShipQuest1", CFrame = CFrame.new(952.4, 202.0, 32835.0)},
    {Level = 1175, Monster = "Ship Officer", QuestId = "ShipQuest1", CFrame = CFrame.new(980.4, 238.0, 32886.7)},
    {Level = 1200, Monster = "Arctic Warrior", QuestId = "FrostQuest", CFrame = CFrame.new(5667.6, 29.5, -6485.7)},
    {Level = 1250, Monster = "Snow Lurker", QuestId = "FrostQuest", CFrame = CFrame.new(5259.8, 5.4, -6627.5)},
    {Level = 1300, Monster = "Sea Soldier", QuestId = "ForgottenQuest", CFrame = CFrame.new(-3053.9, 237.4, -10149.2)},
    {Level = 1350, Monster = "Water Fighter", QuestId = "ForgottenQuest", CFrame = CFrame.new(-3545.6, 237.0, -10104.9)},
    {Level = 1400, Monster = "Fishman Raider", QuestId = "FishmanQuest2", CFrame = CFrame.new(61109.0, 18.4, 1589.0)},
    {Level = 1450, Monster = "Fishman Captain", QuestId = "FishmanQuest2", CFrame = CFrame.new(61389.1, 51.8, 1135.7)}
}

QuestData.World3Quests = {
    {Level = 1500, Monster = "Forest Pirate", QuestId = "PortQuest", CFrame = CFrame.new(-12083.4, 332.4, -7586.5)},
    {Level = 1525, Monster = "Reborn Skeleton", QuestId = "GraveyardQuest", CFrame = CFrame.new(-10969.5, 331.8, -8578.5)},
    {Level = 1550, Monster = "Living Zombie", QuestId = "GraveyardQuest", CFrame = CFrame.new(-11019.6, 325.6, -8871.7)},
    {Level = 1575, Monster = "Demonic Soul", QuestId = "HauntedQuest", CFrame = CFrame.new(-9476.2, 144.2, -8888.4)},
    {Level = 1600, Monster = "Posessed Mummy", QuestId = "HauntedQuest", CFrame = CFrame.new(-9563.5, 150.9, -9328.6)},
    {Level = 1625, Monster = "Peanut Scout", QuestId = "NutQuest", CFrame = CFrame.new(-2127.6, 35.0, -10103.8)},
    {Level = 1650, Monster = "Peanut President", QuestId = "NutQuest", CFrame = CFrame.new(-1862.4, 37.9, -9914.9)},
    {Level = 1700, Monster = "Ice Cream Chef", QuestId = "IceCreamQuest", CFrame = CFrame.new(-793.3, 80.8, -10978.9)},
    {Level = 1725, Monster = "Ice Cream Commander", QuestId = "IceCreamQuest", CFrame = CFrame.new(-893.9, 136.7, -11060.9)},
    {Level = 1750, Monster = "Cookie Crafter", QuestId = "CakeQuest", CFrame = CFrame.new(-2037.3, 35.5, -12188.1)},
    {Level = 1775, Monster = "Cake Guard", QuestId = "CakeQuest", CFrame = CFrame.new(-2140.6, 49.9, -11931.9)},
    {Level = 1800, Monster = "Baking Staff", QuestId = "CakeQuest", CFrame = CFrame.new(-2071.5, 65.6, -11604.7)},
    {Level = 1825, Monster = "Head Baker", QuestId = "CakeQuest", CFrame = CFrame.new(-2089.7, 104.9, -11408.2)},
    {Level = 1850, Monster = "Cocoa Warrior", QuestId = "ChocolateQuest", CFrame = CFrame.new(236.7, 48.6, -12481.1)},
    {Level = 1875, Monster = "Chocolate Bar Battler", QuestId = "ChocolateQuest", CFrame = CFrame.new(457.7, 97.7, -12290.9)},
    {Level = 1900, Monster = "Sweet Thief", QuestId = "CandyQuest", CFrame = CFrame.new(-871.8, 42.4, -12770.7)},
    {Level = 1950, Monster = "Candy Rebel", QuestId = "CandyQuest", CFrame = CFrame.new(-1151.9, 24.9, -12991.4)},
    {Level = 2000, Monster = "Captain Elephant", QuestId = "TikiQuest", CFrame = CFrame.new(5343.2, 601.6, -106.8)},
    {Level = 2050, Monster = "Elite Pirate", QuestId = "TikiQuest", CFrame = CFrame.new(5594.4, 610.8, 196.9)},
    {Level = 2100, Monster = "Jungle Pirate", QuestId = "TikiQuest", CFrame = CFrame.new(5717.4, 637.2, -530.2)},
    {Level = 2200, Monster = "Musketeer Pirate", QuestId = "MushroomQuest", CFrame = CFrame.new(-13372.7, 513.8, -7610.6)},
    {Level = 2275, Monster = "Archer Pirate", QuestId = "MushroomQuest", CFrame = CFrame.new(-13645.6, 497.5, -8191.9)},
    {Level = 2350, Monster = "Mythological Pirate", QuestId = "MushroomQuest", CFrame = CFrame.new(-13597.3, 534.4, -8742.9)},
    {Level = 2400, Monster = "Kittguin", QuestId = "PolarisQuest", CFrame = CFrame.new(-14458.9, 499.1, -10174.3)},
    {Level = 2450, Monster = "Kittguin Crew", QuestId = "PolarisQuest", CFrame = CFrame.new(-14728.6, 499.1, -10399.9)},
    {Level = 2500, Monster = "Captain Kittguin", QuestId = "PolarisQuest", CFrame = CFrame.new(-14946.4, 499.1, -10733.9)},
    {Level = 2550, Monster = "Lava Demon", QuestId = "DragonDojoQuest", CFrame = CFrame.new(-9842.5, 340.5, 6253.7)},
    {Level = 2600, Monster = "Lava Monk", QuestId = "DragonDojoQuest", CFrame = CFrame.new(-9649.4, 340.5, 6510.9)},
    {Level = 2650, Monster = "Lava Enforcer", QuestId = "DragonDojoQuest", CFrame = CFrame.new(-9470.2, 340.5, 6775.7)}
}

function QuestData.CheckQuest()
    local level = QuestData.GetPlayerLevel()
    local world = 1
    
    local placeId = game.PlaceId
    if placeId == 2753915549 then
        world = 1
    elseif placeId == 4442272183 then
        world = 2
    elseif placeId == 7449423635 then
        world = 3
    end
    
    local quests = {}
    if world == 1 then
        quests = QuestData.World1Quests
    elseif world == 2 then
        quests = QuestData.World2Quests
    elseif world == 3 then
        quests = QuestData.World3Quests
    end
    
    local selectedQuest = nil
    for i = #quests, 1, -1 do
        if level >= quests[i].Level then
            selectedQuest = quests[i]
            break
        end
    end
    
    if not selectedQuest and #quests > 0 then
        selectedQuest = quests[1]
    end
    
    return selectedQuest
end

function QuestData.GetQuestByMonster(monsterName)
    local allQuests = {}
    for _, q in ipairs(QuestData.World1Quests) do table.insert(allQuests, q) end
    for _, q in ipairs(QuestData.World2Quests) do table.insert(allQuests, q) end
    for _, q in ipairs(QuestData.World3Quests) do table.insert(allQuests, q) end
    
    for _, quest in ipairs(allQuests) do
        if quest.Monster == monsterName then
            return quest
        end
    end
    return nil
end

function QuestData.GetMonsterList()
    local monsters = {}
    local world = 1
    
    local placeId = game.PlaceId
    if placeId == 2753915549 then
        world = 1
    elseif placeId == 4442272183 then
        world = 2
    elseif placeId == 7449423635 then
        world = 3
    end
    
    local quests = {}
    if world == 1 then
        quests = QuestData.World1Quests
    elseif world == 2 then
        quests = QuestData.World2Quests
    elseif world == 3 then
        quests = QuestData.World3Quests
    end
    
    for _, quest in ipairs(quests) do
        table.insert(monsters, quest.Monster)
    end
    
    return monsters
end

function QuestData.HasQuest()
    local playerGui = Player:FindFirstChild("PlayerGui")
    if not playerGui then return false end
    
    local main = playerGui:FindFirstChild("Main")
    if not main then return false end
    
    local quest = main:FindFirstChild("Quest")
    if quest and quest.Visible then
        return true
    end
    
    return false
end

function QuestData.GetActiveQuest()
    local playerGui = Player:FindFirstChild("PlayerGui")
    if not playerGui then return nil end
    
    local main = playerGui:FindFirstChild("Main")
    if not main then return nil end
    
    local quest = main:FindFirstChild("Quest")
    if quest and quest.Visible then
        local title = quest:FindFirstChild("Title")
        local container = quest:FindFirstChild("Container")
        if title and container then
            return {
                Title = title.Text,
                Progress = container:FindFirstChild("ProgressLabel") and container.ProgressLabel.Text or ""
            }
        end
    end
    
    return nil
end

function QuestData.AcceptQuest(questId, level)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and 
                  ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    if CommF then
        pcall(function()
            CommF:InvokeServer("StartQuest", questId, level or 1)
        end)
    end
end

function QuestData.AbandonQuest()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and 
                  ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    if CommF then
        pcall(function()
            CommF:InvokeServer("AbandonQuest")
        end)
    end
end

return QuestData
