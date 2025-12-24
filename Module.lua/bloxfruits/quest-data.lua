--[[
    Quest Data Module - CheckQuest Function with All Quest Data
    Blox Fruits Script by Zlex Hub (Modularized)
    
    FIXED: Added LevelQuest (1 or 2) for each quest
    FIXED: Using correct CFrameQuest (NPC position) from original script
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
    {MinLevel = 1, MaxLevel = 9, Monster = "Bandit", QuestId = "BanditQuest1", LevelQuest = 1, 
     CFrame = CFrame.new(1059.37195, 15.4495068, 1550.4231)},
    {MinLevel = 10, MaxLevel = 14, Monster = "Monkey", QuestId = "JungleQuest", LevelQuest = 1, 
     CFrame = CFrame.new(-1598.08911, 35.5501175, 153.377838)},
    {MinLevel = 15, MaxLevel = 29, Monster = "Gorilla", QuestId = "JungleQuest", LevelQuest = 2, 
     CFrame = CFrame.new(-1598.08911, 35.5501175, 153.377838)},
    {MinLevel = 30, MaxLevel = 39, Monster = "Pirate", QuestId = "BuggyQuest1", LevelQuest = 1, 
     CFrame = CFrame.new(-1141.07483, 4.10001802, 3831.5498)},
    {MinLevel = 40, MaxLevel = 59, Monster = "Brute", QuestId = "BuggyQuest1", LevelQuest = 2, 
     CFrame = CFrame.new(-1141.07483, 4.10001802, 3831.5498)},
    {MinLevel = 60, MaxLevel = 74, Monster = "Desert Bandit", QuestId = "DesertQuest", LevelQuest = 1, 
     CFrame = CFrame.new(894.488647, 5.14000702, 4392.43359)},
    {MinLevel = 75, MaxLevel = 89, Monster = "Desert Officer", QuestId = "DesertQuest", LevelQuest = 2, 
     CFrame = CFrame.new(894.488647, 5.14000702, 4392.43359)},
    {MinLevel = 90, MaxLevel = 99, Monster = "Snow Bandit", QuestId = "SnowQuest", LevelQuest = 1, 
     CFrame = CFrame.new(1389.74451, 88.1519318, -1298.90796)},
    {MinLevel = 100, MaxLevel = 119, Monster = "Snowman", QuestId = "SnowQuest", LevelQuest = 2, 
     CFrame = CFrame.new(1389.74451, 88.1519318, -1298.90796)},
    {MinLevel = 120, MaxLevel = 149, Monster = "Chief Petty Officer", QuestId = "MarineQuest2", LevelQuest = 1, 
     CFrame = CFrame.new(-5035.42822, 28.5500393, -3245.51636)},
    {MinLevel = 150, MaxLevel = 174, Monster = "Sky Bandit", QuestId = "SkyQuest", LevelQuest = 1, 
     CFrame = CFrame.new(-4838.70166, 716.528931, -2621.19385)},
    {MinLevel = 175, MaxLevel = 189, Monster = "Dark Master", QuestId = "SkyQuest", LevelQuest = 2, 
     CFrame = CFrame.new(-4838.70166, 716.528931, -2621.19385)},
    {MinLevel = 190, MaxLevel = 209, Monster = "Prisoner", QuestId = "PrisonerQuest", LevelQuest = 1, 
     CFrame = CFrame.new(5308.93164, 0.350007534, 474.747253)},
    {MinLevel = 210, MaxLevel = 249, Monster = "Dangerous Prisoner", QuestId = "PrisonerQuest", LevelQuest = 2, 
     CFrame = CFrame.new(5308.93164, 0.350007534, 474.747253)},
    {MinLevel = 250, MaxLevel = 274, Monster = "Toga Warrior", QuestId = "ColosseumQuest", LevelQuest = 1, 
     CFrame = CFrame.new(-1578.67981, 7.35000992, -2982.47656)},
    {MinLevel = 275, MaxLevel = 299, Monster = "Gladiator", QuestId = "ColosseumQuest", LevelQuest = 2, 
     CFrame = CFrame.new(-1578.67981, 7.35000992, -2982.47656)},
    {MinLevel = 300, MaxLevel = 329, Monster = "Military Soldier", QuestId = "MagmaQuest", LevelQuest = 1, 
     CFrame = CFrame.new(-5765.66309, 48.6174316, 8775.21387)},
    {MinLevel = 330, MaxLevel = 374, Monster = "Military Spy", QuestId = "MagmaQuest", LevelQuest = 2, 
     CFrame = CFrame.new(-5765.66309, 48.6174316, 8775.21387)},
    {MinLevel = 375, MaxLevel = 399, Monster = "Fishman Warrior", QuestId = "FishmanQuest", LevelQuest = 1, 
     CFrame = CFrame.new(61124.0586, 17.350008, 1568.03479)},
    {MinLevel = 400, MaxLevel = 449, Monster = "Fishman Commando", QuestId = "FishmanQuest", LevelQuest = 2, 
     CFrame = CFrame.new(61124.0586, 17.350008, 1568.03479)},
    {MinLevel = 450, MaxLevel = 474, Monster = "God's Guards", QuestId = "SkyExp1Quest", LevelQuest = 1, 
     CFrame = CFrame.new(-4721.32959, 845.349976, -1951.39111)},
    {MinLevel = 475, MaxLevel = 524, Monster = "Shanda", QuestId = "SkyExp1Quest", LevelQuest = 2, 
     CFrame = CFrame.new(-4721.32959, 845.349976, -1951.39111)},
    {MinLevel = 525, MaxLevel = 549, Monster = "Royal Squad", QuestId = "SkyExp2Quest", LevelQuest = 1, 
     CFrame = CFrame.new(-7906.10352, 5543.35059, -1410.54248)},
    {MinLevel = 550, MaxLevel = 624, Monster = "Royal Soldier", QuestId = "SkyExp2Quest", LevelQuest = 2, 
     CFrame = CFrame.new(-7906.10352, 5543.35059, -1410.54248)},
    {MinLevel = 625, MaxLevel = 649, Monster = "Galley Pirate", QuestId = "FountainQuest", LevelQuest = 1, 
     CFrame = CFrame.new(5259.81982, 37.3500175, 4050.0293)},
    {MinLevel = 650, MaxLevel = 699, Monster = "Galley Captain", QuestId = "FountainQuest", LevelQuest = 2, 
     CFrame = CFrame.new(5259.81982, 37.3500175, 4050.0293)}
}

QuestData.World2Quests = {
    {MinLevel = 700, MaxLevel = 724, Monster = "Raider", QuestId = "Area1Quest", LevelQuest = 1, 
     CFrame = CFrame.new(-429.543518, 71.7699966, 1836.18188)},
    {MinLevel = 725, MaxLevel = 774, Monster = "Mercenary", QuestId = "Area1Quest", LevelQuest = 2, 
     CFrame = CFrame.new(-429.543518, 71.7699966, 1836.18188)},
    {MinLevel = 775, MaxLevel = 799, Monster = "Swan Pirate", QuestId = "Area2Quest", LevelQuest = 1, 
     CFrame = CFrame.new(638.43811, 71.769989, 918.282898)},
    {MinLevel = 800, MaxLevel = 874, Monster = "Factory Staff", QuestId = "Area2Quest", LevelQuest = 2, 
     CFrame = CFrame.new(632.698608, 73.1055908, 918.666321)},
    {MinLevel = 875, MaxLevel = 899, Monster = "Marine Lieutenant", QuestId = "MarineQuest3", LevelQuest = 1, 
     CFrame = CFrame.new(-2440.79639, 71.7140732, -3216.06812)},
    {MinLevel = 900, MaxLevel = 949, Monster = "Marine Captain", QuestId = "MarineQuest3", LevelQuest = 2, 
     CFrame = CFrame.new(-2440.79639, 71.7140732, -3216.06812)},
    {MinLevel = 950, MaxLevel = 974, Monster = "Zombie", QuestId = "ZombieQuest", LevelQuest = 1, 
     CFrame = CFrame.new(-5497.06152, 47.5923004, -795.237061)},
    {MinLevel = 975, MaxLevel = 999, Monster = "Vampire", QuestId = "ZombieQuest", LevelQuest = 2, 
     CFrame = CFrame.new(-5497.06152, 47.5923004, -795.237061)},
    {MinLevel = 1000, MaxLevel = 1049, Monster = "Snow Trooper", QuestId = "SnowMountainQuest", LevelQuest = 1, 
     CFrame = CFrame.new(609.858826, 400.119904, -5372.25928)},
    {MinLevel = 1050, MaxLevel = 1099, Monster = "Winter Warrior", QuestId = "SnowMountainQuest", LevelQuest = 2, 
     CFrame = CFrame.new(609.858826, 400.119904, -5372.25928)},
    {MinLevel = 1100, MaxLevel = 1124, Monster = "Lab Subordinate", QuestId = "IceSideQuest", LevelQuest = 1, 
     CFrame = CFrame.new(-6060.0, 15.0, -4900.0)},
    {MinLevel = 1125, MaxLevel = 1174, Monster = "Horned Warrior", QuestId = "IceSideQuest", LevelQuest = 2, 
     CFrame = CFrame.new(-6060.0, 15.0, -4900.0)},
    {MinLevel = 1175, MaxLevel = 1199, Monster = "Magma Ninja", QuestId = "FireSideQuest", LevelQuest = 1, 
     CFrame = CFrame.new(-5430.0, 21.0, 8440.0)},
    {MinLevel = 1200, MaxLevel = 1249, Monster = "Lava Pirate", QuestId = "FireSideQuest", LevelQuest = 2, 
     CFrame = CFrame.new(-5430.0, 21.0, 8440.0)},
    {MinLevel = 1250, MaxLevel = 1274, Monster = "Ship Deckhand", QuestId = "ShipQuest1", LevelQuest = 1, 
     CFrame = CFrame.new(1037.7, 125.1, 32882.1)},
    {MinLevel = 1275, MaxLevel = 1299, Monster = "Ship Engineer", QuestId = "ShipQuest1", LevelQuest = 2, 
     CFrame = CFrame.new(1037.7, 125.1, 32882.1)},
    {MinLevel = 1300, MaxLevel = 1324, Monster = "Ship Steward", QuestId = "ShipQuest2", LevelQuest = 1, 
     CFrame = CFrame.new(952.4, 202.0, 32835.0)},
    {MinLevel = 1325, MaxLevel = 1374, Monster = "Ship Officer", QuestId = "ShipQuest2", LevelQuest = 2, 
     CFrame = CFrame.new(952.4, 202.0, 32835.0)},
    {MinLevel = 1375, MaxLevel = 1424, Monster = "Arctic Warrior", QuestId = "FrostQuest", LevelQuest = 1, 
     CFrame = CFrame.new(5667.6, 29.5, -6485.7)},
    {MinLevel = 1425, MaxLevel = 1499, Monster = "Snow Lurker", QuestId = "FrostQuest", LevelQuest = 2, 
     CFrame = CFrame.new(5667.6, 29.5, -6485.7)}
}

QuestData.World3Quests = {
    {MinLevel = 1500, MaxLevel = 1524, Monster = "Pirate Millionaire", QuestId = "PortQuest", LevelQuest = 1, 
     CFrame = CFrame.new(-290.0, 7.0, 5579.0)},
    {MinLevel = 1525, MaxLevel = 1549, Monster = "Dragon Crew Warrior", QuestId = "PortQuest", LevelQuest = 2, 
     CFrame = CFrame.new(-290.0, 7.0, 5579.0)},
    {MinLevel = 1550, MaxLevel = 1574, Monster = "Dragon Crew Archer", QuestId = "PortQuest", LevelQuest = 3, 
     CFrame = CFrame.new(-290.0, 7.0, 5579.0)},
    {MinLevel = 1575, MaxLevel = 1599, Monster = "Female Islander", QuestId = "AmazonQuest", LevelQuest = 1, 
     CFrame = CFrame.new(5836.0, 51.0, -331.0)},
    {MinLevel = 1600, MaxLevel = 1624, Monster = "Amazon", QuestId = "AmazonQuest", LevelQuest = 2, 
     CFrame = CFrame.new(5836.0, 51.0, -331.0)},
    {MinLevel = 1625, MaxLevel = 1649, Monster = "Kilo Admiral", QuestId = "AmazonQuest", LevelQuest = 3, 
     CFrame = CFrame.new(5836.0, 51.0, -331.0)},
    {MinLevel = 1650, MaxLevel = 1699, Monster = "Marine Commodore", QuestId = "MarineTreeIsland", LevelQuest = 1, 
     CFrame = CFrame.new(2180.0, 28.0, -6740.0)},
    {MinLevel = 1700, MaxLevel = 1749, Monster = "Marine Rear Admiral", QuestId = "MarineTreeIsland", LevelQuest = 2, 
     CFrame = CFrame.new(2180.0, 28.0, -6740.0)},
    {MinLevel = 1750, MaxLevel = 1799, Monster = "Fishman Raider", QuestId = "FishmanIslandQuest", LevelQuest = 1, 
     CFrame = CFrame.new(61109.0, 18.4, 1589.0)},
    {MinLevel = 1800, MaxLevel = 1849, Monster = "Fishman Captain", QuestId = "FishmanIslandQuest", LevelQuest = 2, 
     CFrame = CFrame.new(61109.0, 18.4, 1589.0)},
    {MinLevel = 1850, MaxLevel = 1899, Monster = "Forest Pirate", QuestId = "ForestQuest", LevelQuest = 1, 
     CFrame = CFrame.new(-13234.0, 331.0, -7625.0)},
    {MinLevel = 1900, MaxLevel = 1974, Monster = "Reborn Skeleton", QuestId = "ForestQuest", LevelQuest = 2, 
     CFrame = CFrame.new(-13234.0, 331.0, -7625.0)},
    {MinLevel = 1975, MaxLevel = 2024, Monster = "Living Zombie", QuestId = "GraveyardQuest", LevelQuest = 1, 
     CFrame = CFrame.new(-11015.0, 331.0, -8400.0)},
    {MinLevel = 2025, MaxLevel = 2074, Monster = "Demonic Soul", QuestId = "GraveyardQuest", LevelQuest = 2, 
     CFrame = CFrame.new(-11015.0, 331.0, -8400.0)},
    {MinLevel = 2075, MaxLevel = 2099, Monster = "Posessed Mummy", QuestId = "HauntedQuest", LevelQuest = 1, 
     CFrame = CFrame.new(-9476.2, 144.2, -8888.4)},
    {MinLevel = 2100, MaxLevel = 2124, Monster = "Peanut Scout", QuestId = "NutQuest", LevelQuest = 1, 
     CFrame = CFrame.new(-2127.6, 35.0, -10103.8)},
    {MinLevel = 2125, MaxLevel = 2149, Monster = "Peanut President", QuestId = "NutQuest", LevelQuest = 2, 
     CFrame = CFrame.new(-2127.6, 35.0, -10103.8)},
    {MinLevel = 2150, MaxLevel = 2199, Monster = "Ice Cream Chef", QuestId = "IceCreamQuest", LevelQuest = 1, 
     CFrame = CFrame.new(-793.3, 80.8, -10978.9)},
    {MinLevel = 2200, MaxLevel = 2249, Monster = "Ice Cream Commander", QuestId = "IceCreamQuest", LevelQuest = 2, 
     CFrame = CFrame.new(-793.3, 80.8, -10978.9)},
    {MinLevel = 2250, MaxLevel = 2299, Monster = "Cookie Crafter", QuestId = "CakeQuest", LevelQuest = 1, 
     CFrame = CFrame.new(-2037.3, 35.5, -12188.1)},
    {MinLevel = 2300, MaxLevel = 2349, Monster = "Cake Guard", QuestId = "CakeQuest", LevelQuest = 2, 
     CFrame = CFrame.new(-2037.3, 35.5, -12188.1)},
    {MinLevel = 2350, MaxLevel = 2399, Monster = "Baking Staff", QuestId = "CakeQuest", LevelQuest = 3, 
     CFrame = CFrame.new(-2037.3, 35.5, -12188.1)},
    {MinLevel = 2400, MaxLevel = 2449, Monster = "Head Baker", QuestId = "CakeQuest", LevelQuest = 4, 
     CFrame = CFrame.new(-2037.3, 35.5, -12188.1)},
    {MinLevel = 2450, MaxLevel = 2499, Monster = "Cocoa Warrior", QuestId = "ChocolateQuest", LevelQuest = 1, 
     CFrame = CFrame.new(236.7, 48.6, -12481.1)},
    {MinLevel = 2500, MaxLevel = 2549, Monster = "Chocolate Bar Battler", QuestId = "ChocolateQuest", LevelQuest = 2, 
     CFrame = CFrame.new(236.7, 48.6, -12481.1)},
    {MinLevel = 2550, MaxLevel = 2599, Monster = "Sweet Thief", QuestId = "CandyQuest", LevelQuest = 1, 
     CFrame = CFrame.new(-871.8, 42.4, -12770.7)},
    {MinLevel = 2600, MaxLevel = 2649, Monster = "Candy Rebel", QuestId = "CandyQuest", LevelQuest = 2, 
     CFrame = CFrame.new(-871.8, 42.4, -12770.7)},
    {MinLevel = 2650, MaxLevel = 2699, Monster = "Captain Elephant", QuestId = "TikiQuest", LevelQuest = 1, 
     CFrame = CFrame.new(5343.2, 601.6, -106.8)},
    {MinLevel = 2700, MaxLevel = 2749, Monster = "Elite Pirate", QuestId = "TikiQuest", LevelQuest = 2, 
     CFrame = CFrame.new(5343.2, 601.6, -106.8)},
    {MinLevel = 2750, MaxLevel = 2800, Monster = "Jungle Pirate", QuestId = "TikiQuest", LevelQuest = 3, 
     CFrame = CFrame.new(5343.2, 601.6, -106.8)}
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
    
    for _, quest in ipairs(quests) do
        if level >= quest.MinLevel and level <= quest.MaxLevel then
            return quest
        end
    end
    
    if #quests > 0 then
        return quests[#quests]
    end
    
    return nil
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

return QuestData
