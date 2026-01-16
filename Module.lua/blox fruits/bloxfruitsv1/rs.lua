local TweenService: TweenService = game:GetService("TweenService");
local VirtualInputManager: VirtualInputManager = game:GetService("VirtualInputManager")
local CollectionService: CollectionService = game:GetService("CollectionService")
local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService: TeleportService = game:GetService("TeleportService")
local RunService: RunService = game:GetService("RunService")
local Players: Players = game:GetService("Players")
local PlaceId: PlaceId = game:GetService("PlaceId");
local Player = Players.LocalPlayer;

local ChestModels = workspace:WaitForChild("ChestModels");
local WorldOrigin = workspace:WaitForChild("_WorldOrigin");
local Characters = workspace:WaitForChild("Characters");
local SeaBeasts = workspace:WaitForChild("SeaBeasts");
local Enemies = workspace:WaitForChild("Enemies");
local Map = workspace:WaitForChild("Map");

local Main_Module = loadstring(game:HttpGet("https://raw.githubusercontent.com/zzxzsss/moulders/refs/heads/main/Module.lua/blox%20fruits/bloxfruitsv1/ts"))()

-- QuestData is loaded by bridge and stored in _G.QuestData
local QuestData = _G.QuestData or loadstring(game:HttpGet("https://raw.githubusercontent.com/zzxzsss/moulders/refs/heads/main/Module.lua/blox%20fruits/bloxfruitsv1/quest%20data"))()

local QuestModules = {} do

    QuestModules.GetListed = function()
        local sea = Main_Module.GameData.Sea
        if sea == 1 then
            Monster_Listed = QuestData.Sea1Monsters
            Boss_Listed = QuestData.Sea1Bosses
            Material_Listed = QuestData.Sea1Materials
        elseif sea == 2 then
            Monster_Listed = QuestData.Sea2Monsters
            Boss_Listed = QuestData.Sea2Bosses
            Material_Listed = QuestData.Sea2Materials
        elseif sea == 3 then
            Monster_Listed = QuestData.Sea3Monsters
            Boss_Listed = QuestData.Sea3Bosses
            Material_Listed = QuestData.Sea3Materials
        end
    end

    QuestModules.GetListed()

    QuestModules.QuestLevel = function()
        local Lv = Player.Data.Level.Value
        local sea = Main_Module.GameData.Sea
        local quests = QuestData.Quests[sea]
        if not quests then return end
        
        local found = false
        for _, quest in ipairs(quests) do
            local monsterName = quest.Task .. " [Lv. " .. quest.MinLv .. "]"
            local isSelected = (Selected_Monster == monsterName) or (Selected_Monster_Mastery == monsterName)
            
            if isSelected or (not found and Lv >= quest.MinLv and Lv < quest.MaxLv) then
                TaskQuest = quest.Task
                NameMonster = quest.Monster
                NameQuest = quest.Quest
                QuestLv = quest.Lv
                CFrameQuest = CFrame.new(quest.QuestPos[1], quest.QuestPos[2], quest.QuestPos[3])
                CFrameMonster = CFrame.new(quest.MonsterPos[1], quest.MonsterPos[2], quest.MonsterPos[3])
                found = true
                if isSelected then break end
            end
        end
        
        if not found then
            local lastQuest = quests[#quests]
            if lastQuest and Lv >= lastQuest.MinLv then
                TaskQuest = lastQuest.Task
                NameMonster = lastQuest.Monster
                NameQuest = lastQuest.Quest
                QuestLv = lastQuest.Lv
                CFrameQuest = CFrame.new(lastQuest.QuestPos[1], lastQuest.QuestPos[2], lastQuest.QuestPos[3])
                CFrameMonster = CFrame.new(lastQuest.MonsterPos[1], lastQuest.MonsterPos[2], lastQuest.MonsterPos[3])
            end
        end
    end

    QuestModules.QuestBoss = function()
        local sea = Main_Module.GameData.Sea
        local bosses = QuestData.Bosses[sea]
        if not bosses then return end
        
        local targetBoss = Selected_Boss or Selected_Monster_Mastery
        if not targetBoss then return end
        
        for _, boss in ipairs(bosses) do
            if boss.Name == targetBoss then
                NameBoss = boss.Name
                NameQuest = boss.Quest
                QuestLv = boss.Lv
                
                if boss.UseRep then
                    local repBoss = ReplicatedStorage:FindFirstChild(boss.Name)
                    if repBoss then
                        if repBoss:FindFirstChild("HumanoidRootPart") then
                            CFrameBoss = repBoss.HumanoidRootPart.CFrame
                        elseif repBoss:IsA("CFrameValue") then
                            CFrameBoss = repBoss.Value
                        else
                            CFrameBoss = repBoss.CFrame
                        end
                    end
                elseif boss.BossPos then
                    CFrameBoss = CFrame.new(boss.BossPos[1], boss.BossPos[2], boss.BossPos[3])
                end
                
                if boss.QuestPos then
                    CFrameQuest = CFrame.new(boss.QuestPos[1], boss.QuestPos[2], boss.QuestPos[3])
                end
                
                break
            end
        end
    end

    QuestModules.QuestMaterial = function()

        if Main_Module.GameData.Sea == 1 then
            
            if (Selected_Material or Selected_Monster_Mastery) == 'Angel Wings' then
                NameMonster = {"Royal Squad"}
                CFrameMaterial = CFrame.new(-7654.2514648438, 5637.1079101563, -1407.7550048828)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Leather' then
                NameMonster = {"Pirate"}
                CFrameMaterial = CFrame.new(-1201.0881347656, 40.628940582275, 3857.5966796875)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Magma Ore' then
                NameMonster = {"Military Soldier"}
                CFrameMaterial = CFrame.new(-5369.0004882813, 61.24352645874, 8556.4921875)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Scrap Metal' then
                NameMonster = {"Pirate"}
                CFrameMaterial = CFrame.new(-1201.0881347656, 40.628940582275, 3857.5966796875)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Yeti Fur' then
                NameMonster = {"Yeti"}
                CFrameMaterial = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Fish Tail' then
                NameMonster = {"Fishman Warrior"}
                CFrameMaterial = CFrame.new(60844.10546875, 98.462875366211, 1298.3985595703)

                if (CFrameMaterial.Position - Player.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                end

            end

        elseif Main_Module.GameData.Sea == 2 then

            if (Selected_Material or Selected_Monster_Mastery) == 'Leather' then
                NameMonster = {"Marine Captain"}
                CFrameMaterial = CFrame.new(-2335.2026367188, 79.786659240723, -3245.8674316406)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Magma Ore' then
                NameMonster = {"Magma Ninja"}
                CFrameMaterial = CFrame.new(-5461.8388671875, 130.36347961426, -5836.4702148438)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Scrap Metal' then
                NameMonster = {"Lab Subordinate"}
                CFrameMaterial = CFrame.new(-5720.5576171875, 63.309471130371, -4784.6103515625)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Mystic Droplet' then
                NameMonster = {"Sea Soldier"}
                CFrameMaterial = CFrame.new(-3262.9301757813, 298.69036865234, -10552.529296875)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Radioactive' then
                NameMonster = {"Factory Staff"}
                CFrameMaterial = CFrame.new(533.22045898438, 128.46876525879, 355.62615966797)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Vampire Fang' then
                NameMonster = {"Vampire"}
                CFrameMaterial = CFrame.new(-5806.1098632813, 16.722528457642, -1164.4384765625)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Meteorite' then
                NameMonster = {"Fajita"}
                CFrameMaterial = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Dark Fragment' then
                NameMonster = {"Darkbeard"}
                CFrameMaterial = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Ectoplasm' then
                NameMonster = {"Ship Steward", "Ship Engineer", "Ship Deckhand", "Ship Officer"}
                CFrameMaterial = CFrame.new(921.12365722656, 125.9839553833, 33088.328125)
                if (CFrameMaterial.Position - Player.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                end
            end

        elseif Main_Module.GameData.Sea == 3 then

            if (Selected_Material or Selected_Monster_Mastery) == 'Leather' then
                NameMonster = {"Forest Pirate"}
                CFrameMaterial = CFrame.new(-12267.103515625, 459.75262451172, -10277.200195313)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Scrap Metal' then
                NameMonster = {"Forest Pirate"}
                CFrameMaterial = CFrame.new(-12267.103515625, 459.75262451172, -10277.200195313)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Fish Tail' then
                NameMonster = {"Fishman Raider"}
                CFrameMaterial = CFrame.new(-10789.401367188, 427.18637084961, -9131.4423828125)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Gunpowder' then
                NameMonster = {"Pistol Billionaire"}
                CFrameMaterial = CFrame.new(-236.53652954102, 217.46676635742, 6006.0883789063)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Mini Tusk' then
                NameMonster = {"Mythological Pirate"}
                CFrameMaterial = CFrame.new(-13508.616210938, 582.46228027344, -6985.3037109375)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Conjured Cocoa' then
                NameMonster = {"Cocoa Warrior"}
                CFrameMaterial = CFrame.new(167.978516, 26.2254658, -12238.874)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Demonic Wisp' then
                NameMonster = {"Demonic Soul"}
                CFrameMaterial = CFrame.new(-9712.03125, 204.69589233398, 6193.322265625)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Dragon Scale' then
                NameMonster = {"Dragon Crew Warrior"}
                CFrameMaterial = CFrame.new(6831.1171875, 441.76708984375, 446.58615112305)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Mirror Fractal' then
                NameMonster = {"Dough King"}
                CFrameMaterial = CFrame.new(-2103, 70, -12165)

            elseif (Selected_Material or Selected_Monster_Mastery) == 'Bones' then
                NameMonster = {"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"}
                CFrameMaterial = CFrame.new(-9508.5673828125, 142.1398468017578, 5737.3603515625)

            end
        end
    end

    QuestModules.QuestElite = function()
        if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") then
            NameElite = "Diablo"
            CFrameElite = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame

        elseif game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") then
            NameElite = "Deandre"
            CFrameElite = game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame

        elseif game:GetService("ReplicatedStorage"):FindFirstChild("Urban") then
            NameElite = "Urban"
            CFrameElite = game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame

        end
    end

    QuestModules.HeartFarm = function()
        if Main_Module.GameData.Sea == 1 then
            MonsterTable = {"Galley Captain", "Galley Pirate"}
            MonsterPosition = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
            MaxLevelMonster = 650

        elseif Main_Module.GameData.Sea == 2 then
            MonsterTable = {"Sea Soldier", "Water Fighter"}
            MonsterPosition = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
            MaxLevelMonster = 1450

        elseif Main_Module.GameData.Sea == 3 then
            MonsterTable = {"Skull Slayer", "Serpent Hunter", "Isle Champion", "Sun-kissed Warrior"}
            MonsterPosition = CFrame.new(-16541.0215, 54.770813, 1051.46118)
            MaxLevelMonster = 2575

        end

    end

    QuestModules.ObservationFarm = function()
        if Main_Module.GameData.Sea == 1 then
            ObservationMonsterName = "Galley Captain"
            ObservationPos = CFrame.new(5533.29785, 88.1079102, 4852.3916)

        elseif Main_Module.GameData.Sea == 2 then
            ObservationMonsterName = "Water Fighter"
            ObservationPos = CFrame.new(-3262.9301757813, 298.69036865234, -10552.529296875)

        elseif Main_Module.GameData.Sea == 3 then
            ObservationMonsterName = "Skull Slayer"
            ObservationPos = CFrame.new(-16654.7754, 105.286232, 1579.67444)

        end
    end

end

--// Auto Farm Quest
spawn(function()
    while task.wait() do
        if Level_Quest_Func then
            -- Check if level 2600+ needs submarine travel to underwater area
            if QuestModules.NeedsSubmarineTravel() then
                QuestModules.TravelToSubmergedIsland()
                task.wait(1)
            end
            
            Selected_Monster = nil
            Selected_Monster_Mastery = nil
            QuestModules.QuestLevel()

            if not string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, TaskQuest) then
                Main_Module.InvokeRemote("AbandonQuest")
            end
            wait(.1)
            if Player.PlayerGui.Main.Quest.Visible == false then
                Main_Module.Tween(CFrameQuest)
                if (CFrameQuest.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                    wait(.1)
                    Main_Module.InvokeRemote("StartQuest", NameQuest, QuestLv)
                end
            elseif Player.PlayerGui.Main.Quest.Visible == true then
                if Enemies:FindFirstChild(NameMonster) then

                    for i,v in Enemies:GetChildren() do
                        if v.Name == NameMonster then
                            if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                                repeat task.wait()
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
            
                                    Main_Module.SetWeapon(Selected_Weapon)
                                    Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    Main_Module:BringEnemies(v, true)
                                until not Level_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end

                else
                    Main_Module.WaitMobs(CFrameMonster)
                end
            end
        end
    end
end)

--// Auto Farm No Quest
spawn(function()
    while task.wait() do
        if Level_No_Quest_Func then
            -- Check if level 2600+ needs submarine travel to underwater area
            if QuestModules.NeedsSubmarineTravel() then
                QuestModules.TravelToSubmergedIsland()
                task.wait(1)
            end
            
            Selected_Monster = nil
            Selected_Monster_Mastery = nil
            QuestModules.QuestLevel()
            if Enemies:FindFirstChild(NameMonster) then

                for i,v in Enemies:GetChildren() do
                    if v.Name == NameMonster then
                        if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                            repeat task.wait()
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
        
                                Main_Module.SetWeapon(Selected_Weapon)
                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                Main_Module:BringEnemies(v, true)
                            until not Level_No_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                        end
                    end
                end
                
            else
                Main_Module.WaitMobs(CFrameMonster)
            end
        end
    end
end)

--// Auto Farm Hearts
spawn(function()
    while task.wait() do
        if Hearts_Farm_Func then
            QuestModules.HeartFarm()

            local Level = Player.Data.Level.Value

            if Level <= MaxLevelMonster then
                Selected_Monster = nil
                Selected_Monster_Mastery = nil
                QuestModules.QuestLevel()

                if not string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, TaskQuest) then
                    Main_Module.InvokeRemote("AbandonQuest")
                end
                wait(.1)

                if Player.PlayerGui.Main.Quest.Visible == false then
                    Main_Module.Tween(CFrameQuest)
                    if (CFrameQuest.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                        wait(.1)
                        Main_Module.InvokeRemote("StartQuest", NameQuest, QuestLv)
                    end
                elseif Player.PlayerGui.Main.Quest.Visible == true then
                    if Enemies:FindFirstChild(NameMonster) then
    
                        for i,v in Enemies:GetChildren() do
                            if v.Name == NameMonster then
                                if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                                    repeat task.wait()
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                
                                        Main_Module.SetWeapon(Selected_Weapon)
                                        Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        Main_Module:BringEnemies(v, true)
                                    until not Hearts_Farm_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name) or Level.Value >= MaxLevelMonster
                                end
                            end
                        end
    
                    else
                        Main_Module.WaitMobs(CFrameMonster)
                    end
                end

            elseif Level >= MaxLevelMonster then

                if Enemies:FindFirstChild(MonsterTable[1]) or Enemies:FindFirstChild(MonsterTable[2]) or Enemies:FindFirstChild(MonsterTable[3]) or Enemies:FindFirstChild(MonsterTable[4]) then

                    for i,v in Enemies:GetChildren() do
                        if table.find(MonsterTable, v.Name) then
                            if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                                repeat task.wait()
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
            
                                    Main_Module.SetWeapon(Selected_Weapon)
                                    Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    Main_Module:BringEnemies(v, true)
                                until not Hearts_Farm_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end
                end
            end
        end
    end
end)

--// Auto Farm Nearest
spawn(function()
    while task.wait() do
        if Nearest_Farm_Func then

            for z,x in pairs(Enemies:GetChildren()) do
                if x:FindFirstChild("Humanoid") and x:FindFirstChild("HumanoidRootPart") and x.Humanoid.Health > 0 then
                    if x.Name then
                        repeat task.wait()
                            Main_Module.SetWeapon(Selected_Weapon)
                            Main_Module.Tween(x.HumanoidRootPart.CFrame * Farm_Mode)
                            x.HumanoidRootPart.CanCollide = false
                            x.HumanoidRootPart.Size = Vector3.new(60,60,60)
                            x.HumanoidRootPart.Transparency = 1
                            x.Humanoid:ChangeState(11)
                            x.Humanoid:ChangeState(14)
                            Main_Module:BringEnemies(x, true)
                        until not Nearest_Farm_Func or not x.Parent or x.Humanoid.Health <= 0 or not Enemies:FindFirstChild(x.Name)
                    end
                end
            end
        end
    end
end)

--// Auto Farm Select Monster Quest
spawn(function()
    while task.wait() do
        if Select_Monster_Quest_Func then
            Selected_Monster_Mastery = nil
            QuestModules.QuestLevel()

            if not string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, TaskQuest) then
                Main_Module.InvokeRemote("AbandonQuest")
            end
            wait(.1)
            if Player.PlayerGui.Main.Quest.Visible == false then
                Main_Module.Tween(CFrameQuest)
                if (CFrameQuest.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                    wait(.1)
                    Main_Module.InvokeRemote("StartQuest", NameQuest, QuestLv)
                end
            elseif Player.PlayerGui.Main.Quest.Visible == true then
                if Enemies:FindFirstChild(NameMonster) then

                    for i,v in Enemies:GetChildren() do
                        if v.Name == NameMonster then
                            if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                                repeat task.wait()
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
            
                                    Main_Module.SetWeapon(Selected_Weapon)
                                    Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    Main_Module:BringEnemies(v, true)
                                until not Select_Monster_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end

                else
                    Main_Module.WaitMobs(CFrameMonster)
                end
            end
        end
    end
end)

--// Auto Farm Select Monster No Quest
spawn(function()
    while task.wait() do
        if Select_Monster_No_Quest_Func then
            Selected_Monster_Mastery = nil
            QuestModules.QuestLevel()
            if Enemies:FindFirstChild(NameMonster) then

                for i,v in Enemies:GetChildren() do
                    if v.Name == NameMonster then
                        if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                            repeat task.wait()
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
        
                                Main_Module.SetWeapon(Selected_Weapon)
                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                Main_Module:BringEnemies(v, true)
                            until not Select_Monster_No_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                        end
                    end
                end

            else
                Main_Module.WaitMobs(CFrameMonster)
            end
        end
    end
end)

--// Auto Farm Material
spawn(function()
    while task.wait() do
        if Select_Materials_Func then
            Selected_Monster_Mastery = nil
            QuestModules.QuestMaterial()

            if Enemies:FindFirstChild(NameMonster[1]) or Enemies:FindFirstChild(NameMonster[2]) or Enemies:FindFirstChild(NameMonster[3]) or Enemies:FindFirstChild(NameMonster[4]) then

                for i,v in Enemies:GetChildren() do
                    if table.find(NameMonster, v.Name) then
                        if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                            repeat task.wait()
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
        
                                Main_Module.SetWeapon(Selected_Weapon)
                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                Main_Module:BringEnemies(v, true)
                            until not Select_Materials_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                        end
                    end
                end

            else
                Main_Module.Tween(CFrameMaterial)
            end
        end
    end
end)

--// Auto Farm Mastery
spawn(function()
    while task.wait() do
        if Mastery_Farming_Func then
            if Selected_Type_Mastery == "Blox Fruits" then
                if Selected_Mode_Mastery == "Quest" then
                    Selected_Monster = nil
                    Selected_Monster_Mastery = nil
                    QuestModules.QuestLevel()

                    if not string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, TaskQuest) then
                        Main_Module.InvokeRemote("AbandonQuest")
                    end
                    wait(.1)
                    if Player.PlayerGui.Main.Quest.Visible == false then
                        Main_Module.Tween(CFrameQuest)
                        if (CFrameQuest.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                            wait(.1)
                            Main_Module.InvokeRemote("StartQuest", NameQuest, QuestLv)
                        end
                    elseif Player.PlayerGui.Main.Quest.Visible == true then
                        if Enemies:FindFirstChild(NameMonster) then

                            for i,v in Enemies:GetChildren() do
                                if v.Name == NameMonster then
                                    if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                                        repeat task.wait()
                                        
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            v.Humanoid:ChangeState(11)
                                            v.Humanoid:ChangeState(14)
                                            Main_Module:BringEnemies(v, true)

                                            if v.Humanoid.Health <= v.Humanoid.MaxHealth * tonumber(Mastery_Farm_Monster_Health_Set) / 100 then

                                                local Equipped = Player.Character:FindFirstChildOfClass("Tool")
                                                __UseSkill = true
                                                Target_Locked = v.HumanoidRootPart
                                                Equipped.MousePos.Value = Target_Locked.Position

                                                Main_Module.SetWeapon("Blox Fruit")
                                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                Main_Module.UseSkillsMastery()

                                            else
                                                __UseSkill = false
                                                Main_Module.SetWeapon(Selected_Weapon)
                                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)

                                            end

                                        until not Mastery_Farming_Func or Selected_Type_Mastery ~= "Blox Fruits" or Selected_Mode_Mastery ~= "Quest" or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                                    end
                                end
                            end

                        else
                            Main_Module.WaitMobs(CFrameMonster)
                        end
                    end

                elseif Selected_Mode_Mastery == "Nearest" then
                    for z,x in pairs(Enemies:GetChildren()) do
                        if x:FindFirstChild("Humanoid") and x:FindFirstChild("HumanoidRootPart") and x.Humanoid.Health > 0 then
                            if x.Name then
                                repeat task.wait()
                                    if x.Humanoid.Health <= x.Humanoid.MaxHealth * tonumber(Mastery_Farm_Monster_Health_Set) / 100 then
                                        local Equipped = Player.Character:FindFirstChildOfClass("Tool")

                                        __UseSkill = true
                                        Target_Locked = x.HumanoidRootPart
                                        Main_Module.SetWeapon("Blox Fruit")
                                        Main_Module.Tween(x.HumanoidRootPart.CFrame * Farm_Mode)
                                        x.HumanoidRootPart.CanCollide = false
                                        x.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        x.HumanoidRootPart.Transparency = 1
                                        Main_Module:BringEnemies(x, true)
                                        Equipped.MousePos.Value = Target_Locked.Position
                                        Main_Module.UseSkillsMastery()

                                    else
                                        __UseSkill = false
                                        Main_Module.SetWeapon(Selected_Weapon)
                                        Main_Module.Tween(x.HumanoidRootPart.CFrame * Farm_Mode)
                                        x.HumanoidRootPart.CanCollide = false
                                        x.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        x.HumanoidRootPart.Transparency = 1
                                        Main_Module:BringEnemies(x, true)
                                    end
                                    
                                until not Mastery_Farming_Func or Selected_Type_Mastery ~= "Blox Fruits" or Selected_Mode_Mastery ~= "Nearest" or not x.Parent or x.Humanoid.Health <= 0 or not Enemies:FindFirstChild(x.Name)
                            end
                        end
                    end

                elseif Selected_Mode_Mastery == "Select Monsters" then
                    Selected_Monster = nil
                    QuestModules.QuestLevel()
                    if Enemies:FindFirstChild(NameMonster) then

                        for i,v in Enemies:GetChildren() do
                            if v.Name == NameMonster then
                                if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                                    repeat task.wait()
                                    
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                                        Main_Module:BringEnemies(v, true)

                                        if v.Humanoid.Health <= v.Humanoid.MaxHealth * tonumber(Mastery_Farm_Monster_Health_Set) / 100 then

                                            local Equipped = Player.Character:FindFirstChildOfClass("Tool")
                                            __UseSkill = true
                                            Target_Locked = v.HumanoidRootPart
                                            Equipped.MousePos.Value = Target_Locked.Position

                                            Main_Module.SetWeapon("Blox Fruit")
                                            Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            Main_Module.UseSkillsMastery()

                                        else
                                            __UseSkill = false
                                            Main_Module.SetWeapon(Selected_Weapon)
                                            Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)

                                        end

                                    until not Mastery_Farming_Func or Selected_Type_Mastery ~= "Blox Fruits" or Selected_Mode_Mastery ~= "Select Monsters" or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                                end
                            end
                        end

                    else
                        Main_Module.WaitMobs(CFrameMonster)
                    end

                elseif Selected_Mode_Mastery == "Select Boss" then
                    Selected_Boss = nil
                    QuestModules.QuestBoss()

                    if Enemies:FindFirstChild(Selected_Monster_Mastery) then

                        for i,v in Enemies:GetChildren() do
                            if v.Name == NameBoss then
                                if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                                    repeat task.wait()
                                    
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)

                                        if v.Humanoid.Health <= v.Humanoid.MaxHealth * tonumber(Mastery_Farm_Monster_Health_Set) / 100 then

                                            local Equipped = Player.Character:FindFirstChildOfClass("Tool")
                                            __UseSkill = true
                                            Target_Locked = v.HumanoidRootPart
                                            Equipped.MousePos.Value = Target_Locked.Position

                                            Main_Module.SetWeapon("Blox Fruit")
                                            Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            Main_Module.UseSkillsMastery()

                                        else
                                            __UseSkill = false
                                            Main_Module.SetWeapon(Selected_Weapon)
                                            Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)

                                        end

                                    until not Mastery_Farming_Func or Selected_Type_Mastery ~= "Blox Fruits" or Selected_Mode_Mastery ~= "Select Boss" or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                                end
                            end
                        end

                    else
                        Main_Module.WaitMobs(CFrameBoss)
                    end

                elseif Selected_Mode_Mastery == "Material" then
                    Selected_Material = nil
                    QuestModules.QuestMaterial()
                    Main_Module.Tween(CFrameMaterial)

                    for i,v in Enemies:GetChildren() do
                        if table.find(NameMonster, v.Name) then
                            if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                                repeat task.wait()
                                
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
                                    Main_Module:BringEnemies(v, true)

                                    if v.Humanoid.Health <= v.Humanoid.MaxHealth * tonumber(Mastery_Farm_Monster_Health_Set) / 100 then

                                        local Equipped = Player.Character:FindFirstChildOfClass("Tool")
                                        __UseSkill = true
                                        Target_Locked = v.HumanoidRootPart
                                        Equipped.MousePos.Value = Target_Locked.Position

                                        Main_Module.SetWeapon("Blox Fruit")
                                        Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        Main_Module.UseSkillsMastery()

                                    else
                                        __UseSkill = false
                                        Main_Module.SetWeapon(Selected_Weapon)
                                        Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)

                                    end

                                until not Mastery_Farming_Func or Selected_Type_Mastery ~= "Blox Fruits" or Selected_Mode_Mastery ~= "Material" or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end

                end

            elseif Selected_Type_Mastery == "Gun" then
                if Selected_Mode_Mastery == "Quest" then
                    Selected_Monster = nil
                    Selected_Monster_Mastery = nil
                    QuestModules.QuestLevel()

                    if not string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, TaskQuest) then
                        Main_Module.InvokeRemote("AbandonQuest")
                    end
                    wait(.1)
                    if Player.PlayerGui.Main.Quest.Visible == false then
                        Main_Module.Tween(CFrameQuest)
                        if (CFrameQuest.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                            wait(.1)
                            Main_Module.InvokeRemote("StartQuest", NameQuest, QuestLv)
                        end
                    elseif Player.PlayerGui.Main.Quest.Visible == true then
                        if Enemies:FindFirstChild(NameMonster) then

                            for i,v in Enemies:GetChildren() do
                                if v.Name == NameMonster then
                                    if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                                        repeat task.wait()
                                        
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            v.Humanoid:ChangeState(11)
                                            v.Humanoid:ChangeState(14)
                                            Main_Module:BringEnemies(v, true)
    
                                            if v.Humanoid.Health <= v.Humanoid.MaxHealth * tonumber(Mastery_Farm_Monster_Health_Set) / 100 then
    
                                                local Equipped = Player.Character:FindFirstChildOfClass("Tool")
                                                __UseSkill = true
                                                Target_Locked = v.HumanoidRootPart
                                                Equipped.MousePos.Value = Target_Locked.Position
    
                                                Main_Module.SetWeapon("Gun")
                                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                Main_Module.UseSkillsMastery()
    
                                            else
                                                __UseSkill = false
                                                Main_Module.SetWeapon(Selected_Weapon)
                                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
    
                                            end
    
                                        until not Mastery_Farming_Func or Selected_Type_Mastery ~= "Gun" or Selected_Mode_Mastery ~= "Quest" or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                                    end
                                end
                            end

                        else
                            Main_Module.WaitMobs(CFrameMonster)
                        end
                    end

                elseif Selected_Mode_Mastery == "Nearest" then
                    for z,x in pairs(Enemies:GetChildren()) do
                        if x:FindFirstChild("Humanoid") and x:FindFirstChild("HumanoidRootPart") and x.Humanoid.Health > 0 then
                            if x.Name then
                                repeat task.wait()
                                    if x.Humanoid.Health <= x.Humanoid.MaxHealth * tonumber(Mastery_Farm_Monster_Health_Set) / 100 then
                                        local Equipped = Player.Character:FindFirstChildOfClass("Tool")

                                        __UseSkill = true
                                        Target_Locked = x.HumanoidRootPart
                                        Main_Module.SetWeapon("Gun")
                                        Main_Module.Tween(x.HumanoidRootPart.CFrame * Farm_Mode)
                                        x.HumanoidRootPart.CanCollide = false
                                        x.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        x.HumanoidRootPart.Transparency = 1
                                        Main_Module:BringEnemies(x, true)
                                        Equipped.MousePos.Value = Target_Locked.Position
                                        Main_Module.UseSkillsMastery()

                                    else
                                        __UseSkill = false
                                        Main_Module.SetWeapon(Selected_Weapon)
                                        Main_Module.Tween(x.HumanoidRootPart.CFrame * Farm_Mode)
                                        x.HumanoidRootPart.CanCollide = false
                                        x.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        x.HumanoidRootPart.Transparency = 1
                                        Main_Module:BringEnemies(x, true)
                                    end
                                    
                                until not Mastery_Farming_Func or Selected_Type_Mastery ~= "Gun" or Selected_Mode_Mastery ~= "Nearest" or not x.Parent or x.Humanoid.Health <= 0 or not Enemies:FindFirstChild(x.Name)
                            end
                        end
                    end

                elseif Selected_Mode_Mastery == "Select Monsters" then
                    Selected_Monster = nil
                    QuestModules.QuestLevel()
                    if Enemies:FindFirstChild(NameMonster) then

                        for i,v in Enemies:GetChildren() do
                            if v.Name == NameMonster then
                                if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                                    repeat task.wait()
                                    
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                                        Main_Module:BringEnemies(v, true)

                                        if v.Humanoid.Health <= v.Humanoid.MaxHealth * tonumber(Mastery_Farm_Monster_Health_Set) / 100 then

                                            local Equipped = Player.Character:FindFirstChildOfClass("Tool")
                                            __UseSkill = true
                                            Target_Locked = v.HumanoidRootPart
                                            Equipped.MousePos.Value = Target_Locked.Position

                                            Main_Module.SetWeapon("Gun")
                                            Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            Main_Module.UseSkillsMastery()

                                        else
                                            __UseSkill = false
                                            Main_Module.SetWeapon(Selected_Weapon)
                                            Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)

                                        end

                                    until not Mastery_Farming_Func or Selected_Type_Mastery ~= "Gun" or Selected_Mode_Mastery ~= "Select Monsters" or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                                end
                            end
                        end

                    else
                        Main_Module.WaitMobs(CFrameMonster)
                    end

                elseif Selected_Mode_Mastery == "Select Boss" then
                    Selected_Boss = nil
                    QuestModules.QuestBoss()

                    if Enemies:FindFirstChild(Selected_Monster_Mastery) then

                        for i,v in Enemies:GetChildren() do
                            if v.Name == NameBoss then
                                if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                                    repeat task.wait()
                                    
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)

                                        if v.Humanoid.Health <= v.Humanoid.MaxHealth * tonumber(Mastery_Farm_Monster_Health_Set) / 100 then

                                            local Equipped = Player.Character:FindFirstChildOfClass("Tool")
                                            __UseSkill = true
                                            Target_Locked = v.HumanoidRootPart
                                            Equipped.MousePos.Value = Target_Locked.Position

                                            Main_Module.SetWeapon("Gun")
                                            Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            Main_Module.UseSkillsMastery()

                                        else
                                            __UseSkill = false
                                            Main_Module.SetWeapon(Selected_Weapon)
                                            Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)

                                        end

                                    until not Mastery_Farming_Func or Selected_Type_Mastery ~= "Gun" or Selected_Mode_Mastery ~= "Select Boss" or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                                end
                            end
                        end

                    else
                        Main_Module.WaitMobs(CFrameBoss)
                    end

                elseif Selected_Mode_Mastery == "Material" then
                    Selected_Material = nil
                    QuestModules.QuestMaterial()
                    Main_Module.Tween(CFrameMaterial)

                    for i,v in Enemies:GetChildren() do
                        if table.find(NameMonster, v.Name) then
                            if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                                repeat task.wait()
                                
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
                                    Main_Module:BringEnemies(v, true)

                                    if v.Humanoid.Health <= v.Humanoid.MaxHealth * tonumber(Mastery_Farm_Monster_Health_Set) / 100 then

                                        local Equipped = Player.Character:FindFirstChildOfClass("Tool")
                                        __UseSkill = true
                                        Target_Locked = v.HumanoidRootPart
                                        Equipped.MousePos.Value = Target_Locked.Position

                                        Main_Module.SetWeapon("Gun")
                                        Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        Main_Module.UseSkillsMastery()

                                    else
                                        __UseSkill = false
                                        Main_Module.SetWeapon(Selected_Weapon)
                                        Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)

                                    end

                                until not Mastery_Farming_Func or Selected_Type_Mastery ~= "Gun" or Selected_Mode_Mastery ~= "Material" or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end

                end
            end
        end
    end
end)

--// Auto Farm Boss Quest
spawn(function()
    while task.wait() do
        if Select_Boss_Quest_Func then
            Selected_Monster_Mastery = nil
            QuestModules.QuestBoss()

            if not string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameBoss) then
                Main_Module.InvokeRemote("AbandonQuest")
            end
            wait(.1)
            if Player.PlayerGui.Main.Quest.Visible == false then
                Main_Module.Tween(CFrameQuest)
                if (CFrameQuest.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                    wait(.1)
                    Main_Module.InvokeRemote("StartQuest", NameQuest, QuestLv)
                end
            elseif Player.PlayerGui.Main.Quest.Visible == true then
                if Enemies:FindFirstChild(Selected_Boss) then

                    for i,v in Enemies:GetChildren() do
                        if v.Name == NameBoss then
                            if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                                repeat task.wait()
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
                                    Main_Module.SetWeapon(Selected_Weapon)
                                    Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)

                                until not Select_Boss_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end

                else
                    Main_Module.WaitMobs(CFrameBoss)
                end
            end
        end
    end
end)

--// Auto Farm Boss No Quest
spawn(function()
    while task.wait() do
        if Select_Boss_No_Quest_Func then
            Selected_Monster_Mastery = nil
            QuestModules.QuestBoss()

            if Enemies:FindFirstChild(Selected_Boss) then

                for i,v in Enemies:GetChildren() do
                    if v.Name == NameBoss then
                        if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                            repeat task.wait()
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
                                Main_Module.SetWeapon(Selected_Weapon)
                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)

                            until not Select_Boss_No_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                        end
                    end
                end

            else
                Main_Module.WaitMobs(CFrameBoss)
            end
        end
    end
end)

--// Auto Farm Elite Hunter
spawn(function()
    while task.wait() do
        if Elite_Hunter_Quest_Func then
            local Elite_Boss_List = {"Deandre", "Diablo", "Urban"}
            QuestModules.QuestElite()

            if Player.PlayerGui.Main.Quest.Visible == false then
                Main_Module.InvokeRemote("EliteHunter")

            elseif Player.PlayerGui.Main.Quest.Visible == true then
                if Enemies:FindFirstChild(Elite_Boss_List[1]) or Enemies:FindFirstChild(Elite_Boss_List[2]) or Enemies:FindFirstChild(Elite_Boss_List[3]) then

                    for i,v in Enemies:GetChildren() do
                        if table.find(NameElite, v.Name) then
                            if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                                repeat task.wait()

                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
                                    Main_Module.SetWeapon(Selected_Weapon)
                                    Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
    
                                until not Elite_Hunter_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end

                else

                    if string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameElite) then
                        Main_Module.Tween(CFrameElite)
                    end
                end
            end
        end
    end
end)

--// Auto Farm Cake Prince
local function CheckCakePrinceifSpawned()
    local CheckCakePrinceSpawner = Main_Module.InvokeRemote("CakePrinceSpawner")

    if string.len(CheckCakePrinceSpawner) == 88 or string.len(CheckCakePrinceSpawner) == 87 or string.len(CheckCakePrinceSpawner) == 86 then
        return false

    else
        return true
    end
end

spawn(function()
    while task.wait() do
        if Cake_Prince_Quest_Func then
            local Cake_Monster = {"Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker"}
            local Cake_Boss = {"Cake Prince"}
            local Cake_Monster_Pos = CFrame.new(-2077, 252, -12373)
            local Cake_Boss_Pos = CFrame.new(-2151.82153, 149.315704, -12404.9053)

            if CheckCakePrinceifSpawned() == false then

                if Enemies:FindFirstChild(Cake_Monster[1]) or Enemies:FindFirstChild(Cake_Monster[2]) or Enemies:FindFirstChild(Cake_Monster[3]) or Enemies:FindFirstChild(Cake_Monster[4]) then
                    
                    for Index_0, Value_0 in Enemies:GetChildren() do
                        if table.find(Cake_Monster, Value_0.Name) then
                            if Value_0:FindFirstChild('Humanoid') and Value_0:FindFirstChild('HumanoidRootPart') and Value_0:FindFirstChild('Humanoid').Health > 0 then
                                repeat task.wait()
                                    Value_0.HumanoidRootPart.CanCollide = false
                                    Value_0.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    Value_0.HumanoidRootPart.Transparency = 1
                                    Value_0.Humanoid:ChangeState(11)
                                    Value_0.Humanoid:ChangeState(14)
            
                                    Main_Module.SetWeapon(Selected_Weapon)
                                    Main_Module.Tween(Value_0.HumanoidRootPart.CFrame * Farm_Mode)
                                    Main_Module:BringEnemies(Value_0, true)
                                until not Cake_Prince_Quest_Func or not Value_0.Parent or Value_0.Humanoid.Health <= 0 or not Enemies:FindFirstChild(Value_0.Name)
                            end
                        end
                    end
    
                else
                    Main_Module.Tween(Cake_Monster_Pos)
                end

            elseif CheckCakePrinceifSpawned() == true then
                if Enemies:FindFirstChild("Cake Prince") then

                    for Index_1, Value_1 in Enemies:GetChildren() do
                        if table.find(Cake_Boss, Value_1.Name) then
                            if Value_1:FindFirstChild('Humanoid') and Value_1:FindFirstChild('HumanoidRootPart') and Value_1:FindFirstChild('Humanoid').Health > 0 then
                                repeat task.wait()
                                    Value_1.HumanoidRootPart.CanCollide = false
                                    Value_1.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    Value_1.HumanoidRootPart.Transparency = 1
                                    Value_1.Humanoid:ChangeState(11)
                                    Value_1.Humanoid:ChangeState(14)
            
                                    Main_Module.SetWeapon(Selected_Weapon)
                                    Main_Module.Tween(Value_1.HumanoidRootPart.CFrame * Farm_Mode)

                                until not Cake_Prince_Quest_Func or not Value_1.Parent or Value_1.Humanoid.Health <= 0 or not Enemies:FindFirstChild(Value_1.Name)
                            end
                        end
                    end

                else
                    if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 then
                        Main_Module.Tween(Cake_Boss_Pos)
                        
                        if (CFrame.new(-1990.672607421875, 4532.99951171875, -14973.6748046875).Position - Player.Character.HumanoidRootPart.Position).Magnitude >= 1000 then
                            Player.Character.HumanoidRootPart.CFrame = Cake_Boss_Pos
                        end
                    end
                end
            end
            
        end
    end
end)

--// Auto Farm Dough King
spawn(function()
    while task.wait() do
        if Dough_King_Quest_Func then
            local Cake_Monster = {"Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker"}
            local Cake_Boss = {"Dough King"}
            local Cake_Monster_Pos = CFrame.new(-2077, 252, -12373)
            local Cake_Boss_Pos = CFrame.new(-2151.82153, 149.315704, -12404.9053)

            if CheckCakePrinceifSpawned() == false then

                if Enemies:FindFirstChild(Cake_Monster[1]) or Enemies:FindFirstChild(Cake_Monster[2]) or Enemies:FindFirstChild(Cake_Monster[3]) or Enemies:FindFirstChild(Cake_Monster[4]) then
                    
                    for Index_0, Value_0 in Enemies:GetChildren() do
                        if table.find(Cake_Monster, Value_0.Name) then
                            if Value_0:FindFirstChild('Humanoid') and Value_0:FindFirstChild('HumanoidRootPart') and Value_0:FindFirstChild('Humanoid').Health > 0 then
                                repeat task.wait()
                                    Value_0.HumanoidRootPart.CanCollide = false
                                    Value_0.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    Value_0.HumanoidRootPart.Transparency = 1
                                    Value_0.Humanoid:ChangeState(11)
                                    Value_0.Humanoid:ChangeState(14)
            
                                    Main_Module.SetWeapon(Selected_Weapon)
                                    Main_Module.Tween(Value_0.HumanoidRootPart.CFrame * Farm_Mode)
                                    Main_Module:BringEnemies(Value_0, true)
                                until not Dough_King_Quest_Func or not Value_0.Parent or Value_0.Humanoid.Health <= 0 or not Enemies:FindFirstChild(Value_0.Name)
                            end
                        end
                    end
    
                else
                    Main_Module.Tween(Cake_Monster_Pos)
                end

            elseif CheckCakePrinceifSpawned() == true then
                Main_Module.InvokeRemote("DoughKingSpawner", true)
                wait(0.3)
                if Enemies:FindFirstChild("Dough King") then

                    for Index_1, Value_1 in Enemies:GetChildren() do
                        if table.find(Cake_Boss, Value_1.Name) then
                            if Value_1:FindFirstChild('Humanoid') and Value_1:FindFirstChild('HumanoidRootPart') and Value_1:FindFirstChild('Humanoid').Health > 0 then
                                repeat task.wait()
                                    Value_1.HumanoidRootPart.CanCollide = false
                                    Value_1.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    Value_1.HumanoidRootPart.Transparency = 1
                                    Value_1.Humanoid:ChangeState(11)
                                    Value_1.Humanoid:ChangeState(14)
            
                                    Main_Module.SetWeapon(Selected_Weapon)
                                    Main_Module.Tween(Value_1.HumanoidRootPart.CFrame * Farm_Mode)

                                until not Dough_King_Quest_Func or not Value_1.Parent or Value_1.Humanoid.Health <= 0 or not Enemies:FindFirstChild(Value_1.Name)
                            end
                        end
                    end

                else
                    if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 then
                        Main_Module.Tween(Cake_Boss_Pos)
                        
                        if (CFrame.new(-1990.672607421875, 4532.99951171875, -14973.6748046875).Position - Player.Character.HumanoidRootPart.Position).Magnitude >= 1000 then
                            Player.Character.HumanoidRootPart.CFrame = Cake_Boss_Pos
                        end
                    end
                end
            end

        end
    end
end)

--// Auto Farm Factory
spawn(function()
    while task.wait() do
        if Factory_Farming_Func then
            if Enemies:FindFirstChild("Core") then
                for i,v in pairs(Enemies:GetChildren()) do
                    if v.Name == "Core" then
                        if v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 then
                            repeat task.wait()
                                Main_Module.SetWeapon(Selected_Weapon)
                                Main_Module.Tween(CFrame.new(448.46756, 199.356781, -441.389252))
                            until not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild("Core") or not Factory_Farming_Func
                        end
                    end
                end
            else
                Main_Module.Tween(CFrame.new(448.46756, 199.356781, -441.389252))
            end
        end
    end
end)

--// Auto Farm Pirate
spawn(function()
    while task.wait() do
        if Pirate_Raid_Farming_Func then
            local PiratePos = CFrame.new(-5539.3115234375, 313.800537109375, -2972.372314453125)

            if (PiratePos.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 500 then
                for i, v in Enemies:GetChildren() do
                    if v.Name and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid').Health > 0 then
                        repeat task.wait()
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                            v.HumanoidRootPart.Transparency = 1
                            v.Humanoid:ChangeState(11)
                            v.Humanoid:ChangeState(14)

                            Main_Module.SetWeapon(Selected_Weapon)
                            Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)

                        until not Pirate_Raid_Farming_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                    end
                end
            else
                Main_Module.Tween(PiratePos)
            end
        end
    end
end)

--// Auto Farm Chest
local function GetChest()
    local ChestTable = {}
    local ChestList = Main_Module.ChestList
    for i_Chest, v_Chest in workspace.ChestModels:GetChildren() do
        if table.find(ChestList, v_Chest.Name) then
            table.insert(ChestTable, v_Chest.RootPart.CFrame)
        end
    end
    return ChestTable
end
spawn(function()
    while task.wait() do
        if Farming_Chest_Func then
            local ChestList = Main_Module.ChestList
            local newIslandChest = Main_Module.getListNewChest()
            local isTargetChest = GetChest()
            
            if workspace.ChestModels:FindFirstChild(ChestList[1]) or workspace.ChestModels:FindFirstChild(ChestList[2]) or workspace.ChestModels:FindFirstChild(ChestList[3]) or workspace.ChestModels:FindFirstChild(ChestList[4]) or workspace.ChestModels:FindFirstChild(ChestList[5]) or workspace.ChestModels:FindFirstChild(ChestList[6]) then
                for i=1, #isTargetChest do
                    local isChest = isTargetChest[i]
                    repeat task.wait()
                        Main_Module.Tween(isChest)
                    until not Farming_Chest_Func or (isChest.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 1
                end
            else
                local ChestTarget = newIslandChest[math.random(#newIslandChest)]
                repeat task.wait()
                    Main_Module.Tween(ChestTarget)
                until not Farming_Chest_Func or (ChestTarget.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 10 
            end
        end
    end
end)

--// Auto Farm Observation
spawn(function()
    while task.wait() do
        if Farming_Observation_Func then
            QuestModules.ObservationFarm()

            if not Player.Character:FindFirstChild("Highlight") then
                VirtualInputManager:SendKeyEvent(true, "E", false, game)
                wait(.1)
                VirtualInputManager:SendKeyEvent(false, "E", false, game)
            end
            wait(.1)

            if Enemies:FindFirstChild(ObservationMonsterName) then
                if Player.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                    repeat task.wait()
                        Main_Module.Tween(Enemies:FindFirstChild(ObservationMonsterName).HumanoidRootPart.CFrame * CFrame.new(2,0,0))
                    until not Farming_Observation_Func or not Player.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                else
                    Main_Module.Tween(Enemies:FindFirstChild(ObservationMonsterName).HumanoidRootPart.CFrame * CFrame.new(0,100,0))
                end
            else
                Main_Module.Tween(ObservationPos)
            end
        end
    end
end)

--// Observation V2
spawn(function()
    while task.wait(0.5) do
        if Get_Observation_V2_Func then
            pcall(function()
                local Fruit_Table = {'Banana', 'Apple', 'Pineapple'}
                local Character = Player.Character
                if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
                
                local Backpack = Player.Backpack
                local CitizenNPC = CFrame.new(-12444.78515625, 332.40396118164, -7673.1806640625)
                local KillaNPC = CFrame.new(-10920.125, 624.20275878906, -10266.995117188)
                local FruitSpawnPos = CFrame.new(-10553.5625, 332.4039001465, -8745.001953125)
                
                local function hasFruit(name)
                    return (Backpack and Backpack:FindFirstChild(name)) or (Character and Character:FindFirstChild(name))
                end
                
                local function hasAllFruits()
                    return hasFruit(Fruit_Table[1]) and hasFruit(Fruit_Table[2]) and hasFruit(Fruit_Table[3])
                end
                
                local function hasFruitBowl()
                    return (Backpack and Backpack:FindFirstChild("Fruit Bowl")) or (Character and Character:FindFirstChild("Fruit Bowl"))
                end
                
                local questProgress = Main_Module.InvokeRemote("CitizenQuestProgress", "Citizen")
                
                if questProgress == 0 then
                    local dist = (CitizenNPC.Position - Character.HumanoidRootPart.Position).Magnitude
                    if dist <= 10 then
                        Main_Module.InvokeRemote("CitizenQuestProgress", "Citizen")
                        wait(0.5)
                    else
                        Main_Module.Tween(CitizenNPC)
                    end
                    
                elseif questProgress == 1 or questProgress == 2 then
                    if hasAllFruits() then
                        local dist = (CitizenNPC.Position - Character.HumanoidRootPart.Position).Magnitude
                        if dist <= 10 then
                            Main_Module.InvokeRemote("CitizenQuestProgress", "Citizen")
                            wait(0.5)
                        else
                            Main_Module.Tween(CitizenNPC)
                        end
                    else
                        local foundFruit = false
                        for i, v in pairs(workspace:GetChildren()) do
                            if table.find(Fruit_Table, v.Name) and not hasFruit(v.Name) then
                                if v:FindFirstChild("Handle") then
                                    v.Handle.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10)
                                    wait(0.1)
                                    firetouchinterest(Character.HumanoidRootPart, v.Handle, 0)
                                    wait(0.1)
                                    foundFruit = true
                                end
                            end
                        end
                        if not foundFruit then
                            Main_Module.Tween(FruitSpawnPos)
                        end
                    end
                    
                elseif questProgress == 3 then
                    if hasFruitBowl() then
                        local dist = (KillaNPC.Position - Character.HumanoidRootPart.Position).Magnitude
                        if dist <= 10 then
                            Main_Module.InvokeRemote("KenTalk2", "Start")
                            wait(1)
                            Main_Module.InvokeRemote("KenTalk2", "Buy")
                            Main_Module:SetNotify("Observation V2", "Observation V2 Unlocked!", 5)
                            Get_Observation_V2_Func = false
                        else
                            Main_Module.Tween(KillaNPC)
                        end
                    else
                        local dist = (CitizenNPC.Position - Character.HumanoidRootPart.Position).Magnitude
                        if dist <= 10 then
                            Main_Module.InvokeRemote("CitizenQuestProgress", "Citizen")
                            wait(0.5)
                        else
                            Main_Module.Tween(CitizenNPC)
                        end
                    end
                    
                elseif questProgress == -1 or questProgress == nil then
                    Main_Module:SetNotify("Observation V2", "Already have Observation V2!", 3)
                    Get_Observation_V2_Func = false
                end
            end)
        end
    end
end)

--// Helper function to get weapon from backpack or character
local function GetBP(weaponName)
    if Player.Backpack:FindFirstChild(weaponName) then
        return Player.Backpack:FindFirstChild(weaponName)
    elseif Player.Character and Player.Character:FindFirstChild(weaponName) then
        return Player.Character:FindFirstChild(weaponName)
    end
    return nil
end

--// Helper function to get material count
local function GetMaterial(materialName)
    local count = 0
    pcall(function()
        local materials = Main_Module.InvokeRemote("getInventory")
        if materials and materials[materialName] then
            count = materials[materialName]
        end
    end)
    return count
end

--// Death Step
spawn(function()
    while task.wait() do
        if Death_Step_Quest_Func then
            pcall(function()
                if not GetBP("Death Step") then
                    if not GetBP("Black Leg") then
                        Main_Module.InvokeRemote("BuyBlackLeg")
                    end
                    
                    local blackLeg = GetBP("Black Leg")
                    if blackLeg and blackLeg.Level.Value >= 400 then
                        Main_Module.InvokeRemote("BuyDeathStep")
                        
                        if GetBP("Library Key") then
                            repeat task.wait()
                                Main_Module.EquipTool("Library Key")
                                Main_Module.Tween(CFrame.new(6371.2001953125, 296.63433837891, -6841.1811523438))
                            until not Death_Step_Quest_Func or (CFrame.new(6371.2001953125, 296.63433837891, -6841.1811523438).Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 5
                            Main_Module.InvokeRemote("BuyDeathStep")
                        elseif Map.IceCastle.Hall.LibraryDoor.PhoeyuDoor.Transparency == 0 then
                            if Enemies:FindFirstChild("Awakened Ice Admiral") then
                                for i,v in pairs(Enemies:GetChildren()) do
                                    if v.Name == "Awakened Ice Admiral" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            v.Humanoid:ChangeState(11)
                                            v.Humanoid:ChangeState(14)
                                            Main_Module.SetWeapon(Selected_Weapon)
                                            Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            Main_Module:BringEnemies(v, true)
                                        until not Death_Step_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or GetBP("Library Key") or GetBP("Death Step")
                                    end
                                end
                            else
                                Main_Module.Tween(CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813))
                            end
                        else
                            Main_Module.InvokeRemote("BuyDeathStep")
                        end
                    elseif blackLeg and blackLeg.Level.Value < 400 then
                        Level_Quest_Func = true
                    end
                end
            end)
        end
    end
end)

--// Sharkman Karate
spawn(function()
    while task.wait() do
        if Sharkman_Karate_Quest_Func then
            pcall(function()
                if GetBP("Sharkman Karate") then
                    Sharkman_Karate_Quest_Func = false
                    Main_Module:SetNotify("Sharkman Karate", "Already obtained!", 3)
                    return
                end

                Main_Module.InvokeRemote("BuyFishmanKarate")
                
                local fishmanKarate = Player.Character:FindFirstChild("Fishman Karate") or Player.Backpack:FindFirstChild("Fishman Karate")
                
                if fishmanKarate and fishmanKarate.Level.Value >= 400 then
                    local SharkmanNPC = CFrame.new(-2604.6958, 239.432526, -10315.1982)
                    local TideKeeperSpawn = CFrame.new(-3711, 77, -11469)
                    
                    if GetBP("Water Key") then
                        Main_Module.EquipTool("Water Key")
                        if (SharkmanNPC.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                            Main_Module.InvokeRemote("SharkmanTemple", "Water Key")
                            wait(.1)
                            Main_Module.InvokeRemote("BuySharkmanKarate")
                        else
                            Main_Module.Tween(SharkmanNPC)
                        end
                    else
                        if Enemies:FindFirstChild("Tide Keeper") then
                            for i,v in pairs(Enemies:GetChildren()) do
                                if v.Name == "Tide Keeper" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                                        Main_Module.SetWeapon(Selected_Weapon)
                                        Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        Main_Module:BringEnemies(v, true)
                                    until not Sharkman_Karate_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or GetBP("Water Key")
                                end
                            end
                        else
                            Main_Module.Tween(TideKeeperSpawn)
                        end
                    end
                elseif fishmanKarate then
                    Level_Quest_Func = true
                else
                    Main_Module:SetNotify("Sharkman Karate", "Buy Water Kung Fu first - requires 750,000 Beli", 5)
                    wait(4)
                end
            end)
        end
    end
end)

--// Electric Claw
spawn(function()
    while task.wait() do
        if Electric_Claw_Quest_Func then
            pcall(function()
                if GetBP("Electric Claw") then
                    Electric_Claw_Quest_Func = false
                    Main_Module:SetNotify("Electric Claw", "Already obtained!", 3)
                    return
                end

                Main_Module.InvokeRemote("BuyElectro")
                
                local electro = Player.Character:FindFirstChild("Electro") or Player.Backpack:FindFirstChild("Electro")
                
                if electro and electro.Level.Value >= 400 then
                    local PreviousNPC = CFrame.new(-10371.4717, 330.764496, -10131.4199)
                    local FinishNPC = CFrame.new(-12548.5967, 337.198151, -7492.63623)
                    
                    local electricClawProgress = Main_Module.InvokeRemote("BuyElectricClaw", "Check")
                    
                    if electricClawProgress == nil or electricClawProgress == false then
                        if (PreviousNPC.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                            Main_Module.InvokeRemote("BuyElectricClaw", true)
                            wait(.5)
                            Main_Module.InvokeRemote("BuyElectricClaw", "Start")
                        else
                            Main_Module.Tween(PreviousNPC)
                        end
                    elseif electricClawProgress == "Started" or electricClawProgress == true then
                        if (FinishNPC.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                            Main_Module.InvokeRemote("BuyElectricClaw")
                        else
                            Main_Module.Tween(FinishNPC)
                        end
                    end
                elseif electro then
                    Level_Quest_Func = true
                else
                    Main_Module:SetNotify("Electric Claw", "Buy Electro first from Mink race area", 5)
                    wait(4)
                end
            end)
        end
    end
end)

--// Dragon Talon
spawn(function()
    while task.wait() do
        if Dragon_Talon_Quest_Func then
            pcall(function()
                if GetBP("Dragon Talon") then
                    Dragon_Talon_Quest_Func = false
                    Main_Module:SetNotify("Dragon Talon", "Already obtained!", 3)
                    return
                end

                Main_Module.InvokeRemote("BlackbeardReward", "DragonClaw", "1")
                Main_Module.InvokeRemote("BlackbeardReward", "DragonClaw", "2")
                
                local dragonClaw = Player.Character:FindFirstChild("Dragon Claw") or Player.Backpack:FindFirstChild("Dragon Claw")
                
                if dragonClaw and dragonClaw.Level.Value >= 400 then
                    local DragonTalonNPC = CFrame.new(5661.89844, 1210.87708, 863.175537)
                    local MagmaAdmiralSpawn = CFrame.new(-5230.7573242188, 34.912307739258, 8466.9248046875)
                    
                    if GetBP("Fire Essence") then
                        if (DragonTalonNPC.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                            Main_Module.InvokeRemote("BuyDragonTalon", true)
                            wait(.1)
                            Main_Module.InvokeRemote("BuyDragonTalon")
                        else
                            Main_Module.Tween(DragonTalonNPC)
                        end
                    else
                        if Enemies:FindFirstChild("Magma Admiral") then
                            for i,v in pairs(Enemies:GetChildren()) do
                                if v.Name == "Magma Admiral" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                                        Main_Module.SetWeapon(Selected_Weapon)
                                        Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        Main_Module:BringEnemies(v, true)
                                    until not Dragon_Talon_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or GetBP("Fire Essence")
                                end
                            end
                        else
                            Main_Module.Tween(MagmaAdmiralSpawn)
                        end
                    end
                elseif dragonClaw then
                    Level_Quest_Func = true
                else
                    Main_Module:SetNotify("Dragon Talon", "Buy Dragon Claw first from Blackbeard ship", 5)
                    wait(4)
                end
            end)
        end
    end
end)

--// Godhuman
spawn(function()
    while task.wait() do
        if Godhuman_Quest_Func then
            pcall(function()
                if GetBP("Godhuman") then
                    Godhuman_Quest_Func = false
                    Main_Module:SetNotify("Godhuman", "Already obtained!", 3)
                    return
                end

                local GodhumanNPC = CFrame.new(-459.02398681641, 331.66931152344, -429.85247802734)
                local requirements = {
                    level = Player.Data.Level.Value >= 1500,
                    dragonScale = GetMaterial("DragonScale", 10),
                    fishTail = GetMaterial("FishTail", 20),
                    mysticDroplet = GetMaterial("MysticDroplet", 10),
                    magmaOre = GetMaterial("MagmaOre", 20),
                }
                
                local superhuman = Player.Character:FindFirstChild("Superhuman") or Player.Backpack:FindFirstChild("Superhuman")
                local deathStep = Player.Character:FindFirstChild("Death Step") or Player.Backpack:FindFirstChild("Death Step")
                local sharkman = Player.Character:FindFirstChild("Sharkman Karate") or Player.Backpack:FindFirstChild("Sharkman Karate")
                local electricClaw = Player.Character:FindFirstChild("Electric Claw") or Player.Backpack:FindFirstChild("Electric Claw")
                local dragonTalon = Player.Character:FindFirstChild("Dragon Talon") or Player.Backpack:FindFirstChild("Dragon Talon")
                
                local allMastery400 = superhuman and superhuman.Level.Value >= 400
                    and deathStep and deathStep.Level.Value >= 400
                    and sharkman and sharkman.Level.Value >= 400
                    and electricClaw and electricClaw.Level.Value >= 400
                    and dragonTalon and dragonTalon.Level.Value >= 400
                
                if allMastery400 and requirements.level and requirements.dragonScale and requirements.fishTail and requirements.mysticDroplet and requirements.magmaOre then
                    if (GodhumanNPC.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                        Main_Module.InvokeRemote("BuyGodhuman")
                    else
                        Main_Module.Tween(GodhumanNPC)
                    end
                else
                    local missing = {}
                    if not requirements.level then table.insert(missing, "Level 1500+") end
                    if not allMastery400 then table.insert(missing, "All 5 fighting styles at Mastery 400+") end
                    if not requirements.dragonScale then table.insert(missing, "10 Dragon Scale") end
                    if not requirements.fishTail then table.insert(missing, "20 Fish Tail") end
                    if not requirements.mysticDroplet then table.insert(missing, "10 Mystic Droplet") end
                    if not requirements.magmaOre then table.insert(missing, "20 Magma Ore") end
                    
                    Main_Module:SetNotify("Godhuman Missing", table.concat(missing, "\n"), 8)
                    wait(6)
                end
            end)
        end
    end
end)

--// Sanguine Art
spawn(function()
    while task.wait() do
        if Sangui_art_Quest_Func then
            pcall(function()
                if GetBP("Sanguine Art") then
                    Sangui_art_Quest_Func = false
                    Main_Module:SetNotify("Sanguine Art", "Already obtained!", 3)
                    return
                end

                local SanguineNPC = CFrame.new(-6508.5581054688, 337.46493530273, -314.37997436523)
                local requirements = {
                    leviathanHeart = GetMaterial("LeviathanHeart", 1),
                    demonicWisps = GetMaterial("DemonicWisp", 20),
                    vampireFangs = GetMaterial("VampireFang", 20),
                    darkFragment = GetMaterial("DarkFragment", 2),
                }
                
                if requirements.leviathanHeart and requirements.demonicWisps and requirements.vampireFangs and requirements.darkFragment then
                    if (SanguineNPC.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                        Main_Module.InvokeRemote("BuySanguineArt")
                    else
                        Main_Module.Tween(SanguineNPC)
                    end
                else
                    local missing = {}
                    if not requirements.leviathanHeart then table.insert(missing, "1 Leviathan Heart (from Leviathan)") end
                    if not requirements.demonicWisps then table.insert(missing, "20 Demonic Wisps (from Demonic Soul)") end
                    if not requirements.vampireFangs then table.insert(missing, "20 Vampire Fangs (from Vampire)") end
                    if not requirements.darkFragment then table.insert(missing, "2 Dark Fragments (from Dark Beard)") end
                    
                    Main_Module:SetNotify("Sanguine Art Missing", table.concat(missing, "\n"), 8)
                    wait(6)
                end
            end)
        end
    end
end)

--// Saber V1
spawn(function()
    while task.wait() do
        if Saber_V1_Quest_Func then
            if Player.Data.Level.Value >= 200 then
                if Map.Jungle.Final.Part.Transparency == 0 then
                    if Map.Jungle.QuestPlates.Door.Transparency == 0 then

                        if (CFrame.new(-1612.55884, 36.9774132, 148.719543).Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 100 then
                            Main_Module.Tween(Player.Character.HumanoidRootPart.CFrame)
                            wait(1)
                            Player.Character.HumanoidRootPart.CFrame = Map.Jungle.QuestPlates.Plate1.Button.CFrame
                            wait(1.5)
                            Player.Character.HumanoidRootPart.CFrame = Map.Jungle.QuestPlates.Plate2.Button.CFrame
                            wait(1.5)
                            Player.Character.HumanoidRootPart.CFrame = Map.Jungle.QuestPlates.Plate3.Button.CFrame
                            wait(1.5)
                            Player.Character.HumanoidRootPart.CFrame = Map.Jungle.QuestPlates.Plate4.Button.CFrame
                            wait(1.5)
                            Player.Character.HumanoidRootPart.CFrame = Map.Jungle.QuestPlates.Plate5.Button.CFrame
                            wait(1.5)
                        else
                            Main_Module.Tween(CFrame.new(-1612.55884, 36.9774132, 148.719543))
                        end
                    else
                        if Map.Desert.Burn.Part.Transparency == 0 then
                            if Player.Backpack:FindFirstChild("Torch") or Player.Character:FindFirstChild("Torch") then
                                Main_Module.EquipTool("Torch")
                                Main_Module.Tween(CFrame.new(1114.61475, 5.04679728, 4350.22803))
                            else
                                Main_Module.Tween(CFrame.new(-1610.00757, 11.5049858, 164.001587))
                            end
                        else
                            if Main_Module.InvokeRemote("ProQuestProgress", "SickMan") ~= 0 then
                                Main_Module.InvokeRemote("ProQuestProgress", "GetCup")
                                wait(1)
                                Main_Module.EquipTool("Cup")
                                wait(1)
                                Main_Module.InvokeRemote("ProQuestProgress", "FillCup", Player.Character.Cup)
                                wait(1)
                                Main_Module.InvokeRemote("ProQuestProgress", "SickMan")
                            else
                                if Main_Module.InvokeRemote("ProQuestProgress", "RichSon") == nil then
                                    Main_Module.InvokeRemote("ProQuestProgress", "RichSon")

                                elseif Main_Module.InvokeRemote("ProQuestProgress", "RichSon") == 0 then
                                    if Enemies:FindFirstChild("Mob Leader") then
                                        for i,v in pairs(Enemies:GetChildren()) do
                                            if v.Name == "Mob Leader" then
                                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                                
                                                    repeat task.wait()
                                                        v.HumanoidRootPart.CanCollide = false
                                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                                        v.HumanoidRootPart.Transparency = 1
                                                        v.Humanoid:ChangeState(11)
                                                        v.Humanoid:ChangeState(14)
                                                        
                                                        Main_Module.SetWeapon(Selected_Weapon)
                                                        Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                    until not Saber_V1_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name) or Main_Module.InvokeRemote("ProQuestProgress", "RichSon") == 1
                                                end
                                            end
                                        end
                                    else
                                        Main_Module.Tween(CFrame.new(-2815.05396, 36.3834953, 5377.89258))
                                    end

                                elseif Main_Module.InvokeRemote("ProQuestProgress", "RichSon") == 1 then
                                    Main_Module.InvokeRemote("ProQuestProgress", "RichSon")
                                    wait(1)
                                    Main_Module.EquipTool("Relic")
                                    wait(1)
                                    Main_Module.Tween(CFrame.new(-1404.91504, 29.9773273, 3.80598116))
                                    wait(1)
                                    Main_Module.InvokeRemote("OpenLibrary")
                                end
                            end
                        end
                    end
                else
                    if Enemies:FindFirstChild("Saber Expert") then
                        for i,v in pairs(Enemies:GetChildren()) do
                            if v.Name == "Saber Expert" then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                
                                    repeat task.wait()
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                                        
                                        Main_Module.SetWeapon(Selected_Weapon)
                                        Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    until not Saber_V1_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name) or Player.Backpack:FindFirstChild("Saber") or Player.Character:FindFirstChild("Saber")
                                    if v.Humanoid.Health <= 0 then
                                        Main_Module.InvokeRemote("ProQuestProgress", "PlaceRelic")
                                    end
                                end
                            end
                        end
                    else
                        Main_Module.Tween(CFrame.new(-1430.15576, 62.2188568, -7.36060524))
                    end
                end
            else
                Main_Module:SetNotify("Saber Required", "- You need to reach Lv.200.", 5)
                wait(4)
            end
        end
    end
end)

--// Legendary Sword
spawn(function()
    while task.wait() do
        if Legendary_Sword_Dealer_Func then
            Main_Module.InvokeRemote("LegendarySworldDealer", "1")
            Main_Module.InvokeRemote("LegendarySworldDealer", "2")
            Main_Module.InvokeRemote("LegendarySworldDealer", "3")
        end
    end
end)

--// Rengoku
spawn(function()
    while task.wait() do
        if Rengoku_Quest_Func then
            if Player.Backpack:FindFirstChild("Hidden Key") or Player.Character:FindFirstChild("Hidden Key") then
                Main_Module.EquipTool("Hidden Key")
                wait(1)
                Main_Module.Tween(CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875))
                wait(1)
                Main_Module.InvokeRemote("OpenLibrary")
            else
                if Enemies:FindFirstChild("Snow Lurker") or Enemies:FindFirstChild("Arctic Warrior") or Enemies:FindFirstChild("Awakened Ice Admiral") then
                    for i,v in pairs(Enemies:GetChildren()) do
                        if v.Name == "Snow Lurker" or v.Name == "Arctic Warrior" or v.Name == "Awakened Ice Admiral" then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            
                                repeat task.wait()
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
            
                                    Main_Module.SetWeapon(Selected_Weapon)
                                    Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    Main_Module:BringEnemies(v, true)
                                until not Rengoku_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name) or Player.Backpack:FindFirstChild("Hidden Key") or Player.Character:FindFirstChild("Hidden Key")
                            end
                        end
                    end
                else
                    Main_Module.Tween(CFrame.new(5439.716796875, 84.420944213867, -6715.1635742188))
                end
            end
        end
    end
end)

--// Buddy Sword
spawn(function()
    while task.wait() do
        if Buddy_Sword_Quest_Func then
            local Cake_Monster = {"Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker"}
            local Cake_Boss = {"Cake Prince"}
            local Cake_Monster_Pos = CFrame.new(-2077, 252, -12373)
            local Cake_Boss_Pos = CFrame.new(-2151.82153, 149.315704, -12404.9053)

            if CheckCakePrinceifSpawned() == false then

                if Enemies:FindFirstChild(Cake_Monster[1]) or Enemies:FindFirstChild(Cake_Monster[2]) or Enemies:FindFirstChild(Cake_Monster[3]) or Enemies:FindFirstChild(Cake_Monster[4]) then
                    
                    for Index_0, Value_0 in Enemies:GetChildren() do
                        if table.find(Cake_Monster, Value_0.Name) then
                            if Value_0:FindFirstChild('Humanoid') and Value_0:FindFirstChild('HumanoidRootPart') and Value_0:FindFirstChild('Humanoid').Health > 0 then
                                repeat task.wait()
                                    Value_0.HumanoidRootPart.CanCollide = false
                                    Value_0.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    Value_0.HumanoidRootPart.Transparency = 1
                                    Value_0.Humanoid:ChangeState(11)
                                    Value_0.Humanoid:ChangeState(14)
            
                                    Main_Module.SetWeapon(Selected_Weapon)
                                    Main_Module.Tween(Value_0.HumanoidRootPart.CFrame * Farm_Mode)
                                    Main_Module:BringEnemies(Value_0, true)
                                until not Buddy_Sword_Quest_Func or not Value_0.Parent or Value_0.Humanoid.Health <= 0 or not Enemies:FindFirstChild(Value_0.Name)
                            end
                        end
                    end
    
                else
                    Main_Module.Tween(Cake_Monster_Pos)
                end

            elseif CheckCakePrinceifSpawned() == true then
                if Enemies:FindFirstChild("Cake Prince") then

                    for Index_1, Value_1 in Enemies:GetChildren() do
                        if table.find(Cake_Boss, Value_1.Name) then
                            if Value_1:FindFirstChild('Humanoid') and Value_1:FindFirstChild('HumanoidRootPart') and Value_1:FindFirstChild('Humanoid').Health > 0 then
                                repeat task.wait()
                                    Value_1.HumanoidRootPart.CanCollide = false
                                    Value_1.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    Value_1.HumanoidRootPart.Transparency = 1
                                    Value_1.Humanoid:ChangeState(11)
                                    Value_1.Humanoid:ChangeState(14)
            
                                    Main_Module.SetWeapon(Selected_Weapon)
                                    Main_Module.Tween(Value_1.HumanoidRootPart.CFrame * Farm_Mode)

                                until not Buddy_Sword_Quest_Func or not Value_1.Parent or Value_1.Humanoid.Health <= 0 or not Enemies:FindFirstChild(Value_1.Name)
                            end
                        end
                    end

                else
                    if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 then
                        Main_Module.Tween(Cake_Boss_Pos)
                        
                        if (CFrame.new(-1990.672607421875, 4532.99951171875, -14973.6748046875).Position - Player.Character.HumanoidRootPart.Position).Magnitude >= 1000 then
                            Player.Character.HumanoidRootPart.CFrame = Cake_Boss_Pos
                        end
                    end
                end
            end
        end
    end
end)

--// Pole (1st Form)
spawn(function()
    while task.wait() do
        if Pole_1stForm_Quest_Func then
            if Enemies:FindFirstChild("Thunder God") then
                for i,v in pairs(Enemies:GetChildren()) do
                    if v.Name == "Thunder God" then
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        
                            repeat task.wait()
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
        
                                Main_Module.SetWeapon(Selected_Weapon)
                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                            until not Pole_1stForm_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                        end
                    end
                end
            else
                Main_Module.Tween(CFrame.new(-7751, 5607, -2315))
            end
        end
    end
end)

--// Cavander
spawn(function()
    while task.wait() do
        if Cavander_Quest_Func then
            if Enemies:FindFirstChild("Beautiful Pirate") then
                for i,v in pairs(Enemies:GetChildren()) do
                    if v.Name == "Beautiful Pirate" then
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        
                            repeat task.wait()
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
        
                                Main_Module.SetWeapon(Selected_Weapon)
                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                            until not Cavander_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                        end
                    end
                end
            else
                Main_Module.Tween(CFrame.new(5370, 22, -89))
            end
        end
    end
end)

--// Yama
spawn(function()
    while task.wait() do
        if Yama_Quest_Func then
            if Main_Module.InvokeRemote("EliteHunter", "Progress") >= 30 then
                if Enemies:FindFirstChild("Ghost") then
                    for i,v in pairs(Enemies:GetChildren()) do
                        if v.Name == "Ghost" then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            
                                repeat task.wait()
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
            
                                    Main_Module.SetWeapon(Selected_Weapon)
                                    Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    Main_Module:BringEnemies(v, true)
                                until not Yama_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name) or Player.Backpack:FindFirstChild("Yama") or Player.Character:FindFirstChild("Yama")
                            end
                        end
                    end
                else
                    Main_Module.Tween(CFrame.new(5253.25635, 18.5894566, 455.359833))
                    wait(0.1)
                    repeat task.wait()
                        fireclickdetector(Map.Waterfall.SealedKatana.Hitbox.ClickDetector)
                    until Player.Backpack:FindFirstChild("Yama") or Player.Character:FindFirstChild("Yama") or not Yama_Quest_Func
                end
            else
                Main_Module:SetNotify("Yama Quest", "- You need to defeat "..tostring(Main_Module.InvokeRemote("EliteHunter", "Progress")).."/30 Elite Progress", 5)
                wait(4)
            end
        end
    end
end)

--// Tushita
spawn(function()
    while task.wait() do
        if Tushita_Quest_Func then
            if not Player.Backpack:FindFirstChild("God's Chalice") and not Player.Character:FindFirstChild("God's Chalice") then
                if ReplicatedStorage:FindFirstChild("Deandre") or ReplicatedStorage:FindFirstChild("Urban") or ReplicatedStorage:FindFirstChild("Diablo") then
                    if Player.PlayerGui.Main.Quest.Visible == false then
                        Main_Module.InvokeRemote("EliteHunter")
                    elseif Player.PlayerGui.Main.Quest.Visible == true then
                        if string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Diablo") or string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Deandre") or string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Urban") then
                            if Enemies:FindFirstChild("Diablo") or Enemies:FindFirstChild("Deandre") or Enemies:FindFirstChild("Urban") then
                                for i,v in pairs(Enemies:GetChildren()) do
                                    if v.Name == "Diablo" or v.Name == "Deandre" or v.Name == "Urban" then
                                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        
                                            repeat task.wait()
                                                v.HumanoidRootPart.CanCollide = false
                                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                                v.HumanoidRootPart.Transparency = 1
                                                v.Humanoid:ChangeState(11)
                                                v.Humanoid:ChangeState(14)
                        
                                                Main_Module.SetWeapon(Selected_Weapon)
                                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            until not Tushita_Quest_Func or v.Humanoid.Health <= 0 or not v.Parent or not Enemies:FindFirstChild(v.Name) or Player.PlayerGui.Main.Quest.Visible == false or Player.Backpack:FindFirstChild("God's Chalice") or Player.Character:FindFirstChild("God's Chalice")
                                        end
                                    end
                                end
                            else
                                if ReplicatedStorage:FindFirstChild("Diablo") then
                                    Main_Module.Tween(ReplicatedStorage:FindFirstChild("Diablo").HumanoidRootPart.CFrame)
                                elseif ReplicatedStorage:FindFirstChild("Deandre") then
                                    Main_Module.Tween(ReplicatedStorage:FindFirstChild("Deandre").HumanoidRootPart.CFrame)
                                elseif ReplicatedStorage:FindFirstChild("Urban") then
                                    Main_Module.Tween(ReplicatedStorage:FindFirstChild("Urban").HumanoidRootPart.CFrame)
                                end
                            end
                        end
                    end
                else
                    Main_Module.Tween(CFrame.new(-12554.9443, 337.194092, -7501.44727))
                end
            elseif Player.Backpack:FindFirstChild("God's Chalice") or Player.Character:FindFirstChild("God's Chalice") then
                Main_Module.InvokeRemote("activateColor", "Winter Sky")
                wait(0.5)
                Main_Module.Tween(CFrame.new(-5420.16602, 1084.9657, -2666.8208))
                wait(0.5)
                Main_Module.InvokeRemote("activateColor", "Pure Red")
                wait(0.5)
                Main_Module.Tween(CFrame.new(-5414.41357, 309.865753, -2212.45776))
                wait(0.5)
                Main_Module.InvokeRemote("activateColor", "Snow White")
                wait(0.5)
                Main_Module.Tween(CFrame.new(-4971.47559, 331.565765, -3720.02954))
                wait(0.5)
                Main_Module.EquipTool("God's Chalice")
                wait(0.5)
                Main_Module.Tween(CFrame.new(-5560.27295, 313.915466, -2663.89795))
                wait(0.5)
                Main_Module.Tween(CFrame.new(-5561.37451, 313.342529, -2663.4948))
                wait(1)
                Main_Module.Tween(CFrame.new(5154.17676, 141.786423, 911.046326))
                wait(0.2)
                Main_Module.Tween(CFrame.new(5148.03613, 162.352493, 910.548218))
                wait(1)
                Main_Module.EquipTool("Holy Torch")
                wait(1)
                wait(0.4)
                Main_Module.Tween(CFrame.new(-10752.7695, 412.229523, -9366.36328))
                wait(0.4)
                Main_Module.Tween(CFrame.new(-11673.4111, 331.749023, -9474.34668))
                wait(0.4)
                Main_Module.Tween(CFrame.new(-12133.3389, 519.47522, -10653.1904))
                wait(0.4)
                Main_Module.Tween(CFrame.new(-13336.5, 485.280396, -6983.35254))
                wait(0.4)
                Main_Module.Tween(CFrame.new(-13487.4131, 334.84845, -7926.34863))
                wait(1)

                if Enemies:FindFirstChild("Longma") then
                    for i,v in pairs(Enemies:GetChildren()) do
                        if v.Name == "Longma" then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            
                                repeat task.wait()
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
            
                                    Main_Module.SetWeapon(Selected_Weapon)
                                    Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                until not Tushita_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end
                else
                    Main_Module.Tween(CFrame.new(-10218, 333, -9444))
                end

                if Enemies:FindFirstChild("rip_indra True Form") then
                    
                    for i,v in pairs(Enemies:GetChildren()) do
                        if v.Name == "rip_indra True Form" then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            
                                repeat task.wait()
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
            
                                    Main_Module.SetWeapon(Selected_Weapon)
                                    Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                until not Tushita_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end
                else
                    Main_Module.Tween(CFrame.new(-5333, 424, -2673))
                end
            end
        end
    end
end)

--// Dark Dagger
spawn(function()
    while task.wait() do
        if Dark_Dragger_Quest_Func then
            if Enemies:FindFirstChild("rip_indra True Form") then
                for i,v in pairs(Enemies:GetChildren()) do
                    if v.Name == "rip_indra True Form" then
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        
                            repeat task.wait()
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
        
                                Main_Module.SetWeapon(Selected_Weapon)
                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                            until not Dark_Dragger_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                        end
                    end
                end
            else
                Main_Module.Tween(CFrame.new(-5333, 424, -2673))
            end
        end
    end
end)

--// Koko
spawn(function()
    while task.wait() do
        if Koko_Quest_Func then
            if Enemies:FindFirstChild("Order") then
                for i,v in pairs(Enemies:GetChildren()) do
                    if v.Name == "Order" then
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        
                            repeat task.wait()
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
        
                                Main_Module.SetWeapon(Selected_Weapon)
                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                            until not Koko_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                        end
                    end
                end
            else
                Main_Module.Tween(CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875))
            end
        end
    end
end)

--// Spikey Trident
spawn(function()
    while task.wait() do
        if Spikey_Trident_Quest_Func then
            if Enemies:FindFirstChild("Cake Prince") or Enemies:FindFirstChild("Dough King") then

                for Index_1, Value_1 in Enemies:GetChildren() do
                    if Value_1.Name == "Cake Prince" or Value_1.Name == "Dough King" then
                        if Value_1:FindFirstChild('Humanoid') and Value_1:FindFirstChild('HumanoidRootPart') and Value_1:FindFirstChild('Humanoid').Health > 0 then
                            repeat task.wait()
                                Value_1.HumanoidRootPart.CanCollide = false
                                Value_1.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                Value_1.HumanoidRootPart.Transparency = 1
                                Value_1.Humanoid:ChangeState(11)
                                Value_1.Humanoid:ChangeState(14)
        
                                Main_Module.SetWeapon(Selected_Weapon)
                                Main_Module.Tween(Value_1.HumanoidRootPart.CFrame * Farm_Mode)

                            until not Spikey_Trident_Quest_Func or not Value_1.Parent or Value_1.Humanoid.Health <= 0 or not Enemies:FindFirstChild(Value_1.Name)
                        end
                    end
                end

            else
                Main_Module.Tween(CFrame.new(-2103, 70, -12165))
                    
                if (CFrame.new(-1990.672607421875, 4532.99951171875, -14973.6748046875).Position - Player.Character.HumanoidRootPart.Position).Magnitude >= 1000 then
                    Player.Character.HumanoidRootPart.CFrame = CFrame.new(-2103, 70, -12165)
                end
            end
        end
    end
end)

--// Hallow Scythe
spawn(function()
    while task.wait() do
        if Hallow_Scythe_Quest_Func then
            
            if Enemies:FindFirstChild("Soul Reaper") then
                for i,v in pairs(Enemies:GetChildren()) do
                    if v.Name == "Soul Reaper" then
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        
                            repeat task.wait()
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
        
                                Main_Module.SetWeapon(Selected_Weapon)
                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                            until not Hallow_Scythe_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                        end
                    end
                end
            else
                Main_Module.Tween(CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813))
            end
        end
    end
end)

--// Citizen
spawn(function()
    while task.wait() do
        if Citizen_Quest_Func then
            local Check_Quest = false

            if Player.Backpack:FindFirstChild("Musketeer Hat") or Player.Character:FindFirstChild("Musketeer Hat") then
                Check_Quest = true
            end

            if Check_Quest then
                Main_Module:SetNotify("Citizen Quest", "- Musketeer Hat Successfully.", 5)
                wait(4)
            end

            if Main_Module.InvokeRemote("CitizenQuestProgress", "Citizen") == 3 then
                Main_Module:SetNotify("Citizen Quest", "- Citizen Quest has completed.", 5)
                wait(4)
            end

            if Player.Data.Level.Value >= 1800 then
                if Main_Module.InvokeRemote("CitizenQuestProgress").KilledBandits == false and Main_Module.InvokeRemote("CitizenQuestProgress").KilledBoss == false then

                    if Player.PlayerGui.Main.Quest.Visible == false then
                        Main_Module.Tween(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
                        wait(0.3)
                        if (CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125) - Player.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                            wait(1)
                            Main_Module.InvokeRemote("StartQuest", "CitizenQuest", 1)
                        end

                    elseif Player.PlayerGui.Main.Quest.Visible == true then
                        if Enemies:FindFirstChild("Forest Pirate") then
                            for i,v in pairs(Enemies:GetChildren()) do
                                if v.Name == "Forest Pirate" then
                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    
                                        repeat task.wait()
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            v.Humanoid:ChangeState(11)
                                            v.Humanoid:ChangeState(14)
                    
                                            Main_Module.SetWeapon(Selected_Weapon)
                                            Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            Main_Module:BringEnemies(v, true)
                                        until not Citizen_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name) or Main_Module.InvokeRemote("CitizenQuestProgress").KilledBandits == true
                                    end
                                end
                            end
                        else
                            Main_Module.Tween(CFrame.new(-13459.065429688, 412.68927001953, -7783.1860351563))
                        end
                    end

                elseif Main_Module.InvokeRemote("CitizenQuestProgress").KilledBandits == true and Main_Module.InvokeRemote("CitizenQuestProgress").KilledBoss == false then

                    if Player.PlayerGui.Main.Quest.Visible == false then
                        Main_Module.Tween(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
                        wait(0.3)
                        if (CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125) - Player.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                            wait(1)
                            Main_Module.InvokeRemote("CitizenQuestProgress", "Citizen")
                        end

                    elseif Player.PlayerGui.Main.Quest.Visible == true then
                        if Enemies:FindFirstChild("Captain Elephant") then
                            for i,v in pairs(Enemies:GetChildren()) do
                                if v.Name == "Captain Elephant" then
                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    
                                        repeat task.wait()
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            v.Humanoid:ChangeState(11)
                                            v.Humanoid:ChangeState(14)
                    
                                            Main_Module.SetWeapon(Selected_Weapon)
                                            Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        until not Citizen_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name) or Main_Module.InvokeRemote("CitizenQuestProgress").KilledBoss == true
                                    end
                                end
                            end
                        else
                            Main_Module.Tween(CFrame.new(-13459.065429688, 412.68927001953, -7783.1860351563))
                        end
                    end

                elseif Main_Module.InvokeRemote("CitizenQuestProgress", "Citizen") == 2 then
                    Main_Module.Tween(CFrame.new(-12512.138671875, 340.39279174805, -9872.8203125))

                end
            else
                Main_Module:SetNotify("Citizen Quest", "- You need to reach Lv 1800.", 5)
                wait(4)
            end
        end
    end
end)

--// Bartilo
spawn(function()
    while task.wait() do
        if Bartilo_Quest_Func then
            local BartiloNpc = CFrame.new(-455.806122, 73.3869019, 301.771637)

            if Player.Data.Level.Value >= 850 then
                if Main_Module.InvokeRemote("BartiloQuestProgress", "Bartilo") == 0 then
                    local MonsterName = {"Swan Pirate"}
                    local MonsterPos = CFrame.new(1057.92761, 137.614319, 1242.08069)

                    if Player.PlayerGui.Main.Quest.Visible == false then
                        Main_Module.Tween(BartiloNpc)
                        if (BartiloNpc.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                            wait(.1)
                            Main_Module.InvokeRemote("StartQuest", "BartiloQuest", 1)
                        end

                    elseif Player.PlayerGui.Main.Quest.Visible == true then
                        if Enemies:FindFirstChild("Swan Pirate") then

                            for i,v in pairs(Enemies:GetChildren()) do
                                if v.Name == "Forest Pirate" then
                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    
                                        repeat task.wait()
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            v.Humanoid:ChangeState(11)
                                            v.Humanoid:ChangeState(14)
                    
                                            Main_Module.SetWeapon(Selected_Weapon)
                                            Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            Main_Module:BringEnemies(v, true)
                                        until not Bartilo_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name) or Main_Module.InvokeRemote("CitizenQuestProgress").KilledBandits == true
                                    end
                                end
                            end

                        else
                            Main_Module.WaitMobs(MonsterPos)
                        end

                    end

                elseif Main_Module.InvokeRemote("BartiloQuestProgress", "Bartilo") == 1 then
                    local MonsterName = {"Jeremy"}
                    local MonsterPos = CFrame.new(1931.5931396484, 402.67391967773, 956.52215576172)

                    Main_Module.InvokeRemote("BartiloQuestProgress", "Bartilo")
                    wait(0.1)

                    if Enemies:FindFirstChild(Jeremy) then

                        OtherModules.AttackMonster(MonsterName, Function)

                    else
                        Main_Module.Tween(MonsterPos)
                    end

                elseif Main_Module.InvokeRemote("BartiloQuestProgress", "Bartilo") == 2 then
                    local PlayerPos = Player.Character.HumanoidRootPart.CFrame
                    local Puzzle_1 = CFrame.new(-1836.1412353515625, 10.458294868469238, 1692.491943359375)

                    if (Player.Character.HumanoidRootPart.Position - Puzzle_1.Position).Magnitude > 1000 then
                        Main_Module.Tween(Puzzle_1)
                    else
                        wait(1)
                        PlayerPos = CFrame.new(-1850.49329, 13.1789551, 1750.89685)
                        wait(1)
                        PlayerPos = CFrame.new(-1858.87305, 19.3777466, 1712.01807)
                        wait(1)
                        PlayerPos = CFrame.new(-1803.94324, 16.5789185, 1750.89685)
                        wait(1)
                        PlayerPos = CFrame.new(-1858.55835, 16.8604317, 1724.79541)
                        wait(1)
                        PlayerPos = CFrame.new(-1869.54224, 15.987854, 1681.00659)
                        wait(1)
                        PlayerPos = CFrame.new(-1800.0979, 16.4978027, 1684.52368)
                        wait(1)
                        PlayerPos = CFrame.new(-1819.26343, 14.795166, 1717.90625)
                        wait(1)
                        PlayerPos = CFrame.new(-1813.51843, 14.8604736, 1724.79541)
                    end

                end
            else
                Main_Module:SetNotify("Citizen Quest", "- You need to reach Lv 850.", 5)
                wait(4)
            end
        end
    end
end)

--// Don Swan
spawn(function()
    while task.wait() do
        if Down_Swan_Quest_Func then
            if Enemies:FindFirstChild("Don Swan") then

                for i,v in pairs(Enemies:GetChildren()) do
                    if v.Name == "Don Swan" then
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        
                            repeat task.wait()
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
        
                                Main_Module.SetWeapon(Selected_Weapon)
                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                            until not Down_Swan_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                        end
                    end
                end

            else
                Main_Module.Tween(CFrame.new(2191.1674804688, 15.177842140198, 694.69873046875))
            end
        end
    end
end)

--// Rip Indra True Form
spawn(function()
    while task.wait() do
        if rip_indra_True_Form_Quest_Func then
            if Enemies:FindFirstChild("rip_indra True Form") then

                for i,v in pairs(Enemies:GetChildren()) do
                    if v.Name == "rip_indra True Form" then
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        
                            repeat task.wait()
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
        
                                Main_Module.SetWeapon(Selected_Weapon)
                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                            until not rip_indra_True_Form_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                        end
                    end
                end

            else
                Main_Module.Tween(CFrame.new(-5524.53271, 313.800537, -2918.07422))
            end
        end
    end
end)

--// Rainbow Haki
spawn(function()
    while task.wait() do
        if Rainbow_Haki_Quest_Func then
            local HornedManNpc = CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875)

            if Player.PlayerGui.Main.Quest.Visible == false then
                --[[if (CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875) - Player.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                    wait(1)
                    Main_Module.InvokeRemote("HornedMan", "Bet")
                end]]
                Main_Module.InvokeRemote("HornedMan", "Bet")
            elseif Player.PlayerGui.Main.Quest.Visible == true then
                if string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") then
                    if Enemies:FindFirstChild("Stone") then

                        for i,v in pairs(Enemies:GetChildren()) do
                            if v.Name == "Stone" then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                
                                    repeat task.wait()
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                
                                        Main_Module.SetWeapon(Selected_Weapon)
                                        Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    until not Rainbow_Haki_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name) or not string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone")
                                end
                            end
                        end

                    else
                        Main_Module.Tween(CFrame.new(-1049, 40, 6791))
                    end

                elseif string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Hydra Leader") then
                    if Enemies:FindFirstChild("Hydra Leader") then

                        for i,v in pairs(Enemies:GetChildren()) do
                            if v.Name == "Hydra Leader" then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                
                                    repeat task.wait()
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                
                                        Main_Module.SetWeapon(Selected_Weapon)
                                        Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    until not Rainbow_Haki_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name) or not string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Hydra Leader")
                                end
                            end
                        end

                    else
                        Main_Module.Tween(CFrame.new(5836, 1019, -83))
                    end

                elseif string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
                    if Enemies:FindFirstChild("Kilo Admiral") then

                        for i,v in pairs(Enemies:GetChildren()) do
                            if v.Name == "Kilo Admiral" then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                
                                    repeat task.wait()
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                
                                        Main_Module.SetWeapon(Selected_Weapon)
                                        Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    until not Rainbow_Haki_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name) or not string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral")
                                end
                            end
                        end

                    else
                        Main_Module.Tween(CFrame.new(2904, 509, -7349))
                    end

                elseif string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
                    if Enemies:FindFirstChild("Captain Elephant") then

                        for i,v in pairs(Enemies:GetChildren()) do
                            if v.Name == "Captain Elephant" then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                
                                    repeat task.wait()
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                
                                        Main_Module.SetWeapon(Selected_Weapon)
                                        Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    until not Rainbow_Haki_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name) or not string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant")
                                end
                            end
                        end

                    else
                        Main_Module.Tween(CFrame.new(-13393, 319, -8423))
                    end

                elseif string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
                    if Enemies:FindFirstChild("Beautiful Pirate") then

                        for i,v in pairs(Enemies:GetChildren()) do
                            if v.Name == "Beautiful Pirate" then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                
                                    repeat task.wait()
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                
                                        Main_Module.SetWeapon(Selected_Weapon)
                                        Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    until not Rainbow_Haki_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name) or not string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate")
                                end
                            end
                        end

                    else
                        Main_Module.Tween(CFrame.new(5370, 22, -89))
                    end
                end
            end
        end
    end
end)

--// Pray and Try Luck Gravestone
spawn(function()
    while task.wait() do
        if Pray_and_Tryluck_Quest_Func then
            if (CFrame.new(-8652.99707, 143.450119, 6170.50879) - Player.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                wait(1)
                Main_Module.InvokeRemote("gravestoneEvent", 1)
                Main_Module.InvokeRemote("gravestoneEvent", 2)
            end
        end
    end
end)

--// Advance Dungeon Bird-Bird: Phoenix
spawn(function()
    while task.wait() do
        if Advanced_Dungeon_Phoenix_Quest_Func then
            if Player.Character:FindFirstChild("Bird-Bird: Phoenix") or Player.Backpack:FindFirstChild("Bird-Bird: Phoenix") then
                if Player.Backpack:FindFirstChild(Player.Data.DevilFruit.Value) then
                    if Player.Backpack:FindFirstChild(Player.Data.DevilFruit.Value).Level.Value >= 400 then
                        Main_Module.Tween(CFrame.new(-2812.76708984375, 254.803466796875, -12595.560546875))
                        
                        if (CFrame.new(-2812.76708984375, 254.803466796875, -12595.560546875).Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                            wait(1)
                            Main_Module.InvokeRemote("SickScientist", "Check")
                            Main_Module.InvokeRemote("SickScientist", "Heal")
                        end
                    end
                end
            end
        end
    end
end)

--// Color Haki
spawn(function()
    while task.wait() do
        if Color_Haki_Quest_Func then
            Main_Module.InvokeRemote("ColorsDealer", "1")
            Main_Module.InvokeRemote("ColorsDealer", "2")
            Main_Module.InvokeRemote("ColorsDealer", "3")
        end
    end
end)

--// Venom Bow
spawn(function()
    while task.wait() do
        if Venom_Bow_Quest_Func then
            if Enemies:FindFirstChild("Hydra Leader") then

                for i,v in pairs(Enemies:GetChildren()) do
                    if v.Name == "Hydra Leader" then
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        
                            repeat task.wait()
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
        
                                Main_Module.SetWeapon(Selected_Weapon)
                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                            until not Venom_Bow_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name) or Player.Backpack:FindFirstChild("Venom Bow") or Player.Character:FindFirstChild("Venom Bow")
                        end
                    end
                end

            else
                Main_Module.Tween(CFrame.new(5836, 1019, -83))
            end
        end
    end
end)

--// Dojo Quest
spawn(function()
    while task.wait() do
        if Dojo_Quest_Func then
            Main_Module.Tween(CFrame.new(5855.19629, 1208.32178, 872.713501))

            if (CFrame.new(5855.19629, 1208.32178, 872.713501).Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                local ohTable1 = {
                    ["NPC"] = "Dojo Trainer",
                    ["Command"] = "ClaimQuest"
                }
                Main_Module.InvokeModules("RF/InteractDragonQuest", ohTable1)

                wait(1)

                local ohTable2 = {
                    ["NPC"] = "Dojo Trainer",
                    ["Command"] = "RequestQuest"
                }
                Main_Module.InvokeModules("RF/InteractDragonQuest", ohTable2)
            end
        end
    end
end)

--// Hydra Mobs
spawn(function()
    while task.wait() do
        if Hydra_Mob_Quest_Func then
            if Enemies:FindFirstChild('Hydra Enforcer') or Enemies:FindFirstChild('Venomous Assailant') then
                for i,v in pairs(Enemies:GetChildren()) do
                    if v.Name == 'Hydra Enforcer' or v.Name == 'Venomous Assailant' then
                        if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                            repeat task.wait()
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
        
                                Main_Module.SetWeapon(Selected_Weapon)
                                Main_Module.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                Main_Module:BringEnemies(v, true)
                            until not Hydra_Mob_Quest_Func or not v.Parent or v.Humanoid.Health <= 0 or not Enemies:FindFirstChild(v.Name)
                        end
                    end
                end
            else
                Main_Module.Tween(CFrame.new(5394.36475, 1082.71057, 561.993958))
            end
            for i,v in pairs(workspace:GetChildren()) do
                if v.Name == 'EmberTemplate' then
                    v.Part.CFrame = Player.Character.HumanoidRootPart.CFrame
                end
            end
        end
    end
end)

--// Destroy Tree
spawn(function()
    while task.wait() do
        if Destroy_Tree_Quest_Func then
            Main_Module.Tween(CFrame.new(5287.38867, 1005.39508, 389.256714) * CFrame.new(0,50,0))
            Main_Module.EquipTool("Blox Fruit")

            for i,v in pairs(workspace:GetChildren()) do
                if v.Name == 'EmberTemplate' then
                    v.Part.CFrame = Player.Character.HumanoidRootPart.CFrame
                end
            end
        end
    end
end)

--// Upgrade Dragon Talon
spawn(function()
    while task.wait() do
        if Upgrade_Dragon_Talon_Quest_Func then
            Main_Module.Tween(CFrame.new(5661.89014, 1211.31909, 864.836731))

            if (CFrame.new(5661.89014, 1211.31909, 864.836731).Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                local ohTable1 = {
                    ["NPC"] = "Uzoth",
                    ["Command"] = "Upgrade"
                }
                
                Main_Module.InvokeModules("RF/InteractDragonQuest", ohTable1)
            end
        end
    end
end)


-- ================================
-- RACE EVOLUTION V2 & V3
-- ================================

QuestModules.GetPlayerRace = function()
    if Player and Player:FindFirstChild("Data") then
        local raceData = Player.Data:FindFirstChild("Race")
        if raceData then return raceData.Value end
    end
    return "Human"
end

QuestModules.CheckAlchemistQuest = function()
    return ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1")
end

QuestModules.StartAlchemistQuest = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "2")
end

QuestModules.CompleteAlchemistQuest = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "3")
end

QuestModules.CheckWenlocktoadQuest = function()
    return ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
end

QuestModules.StartWenlocktoadQuest = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
end

QuestModules.FlowerLocations = {
    Flower1 = CFrame.new(-2313, 51, -10085),
    Flower2 = CFrame.new(61708, 49, -1320),
    Flower3Swan = CFrame.new(980, 121, 1287),
    AlchemistNPC = CFrame.new(-11245.5, 332.5, -8656.5)
}

QuestModules.AutoRaceV2 = function()
    local Character = Player.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return false end
    
    local success, questStatus = pcall(function()
        return QuestModules.CheckAlchemistQuest()
    end)
    
    if not success then return false end
    
    local raceData = Player:FindFirstChild("Data") and Player.Data:FindFirstChild("Race")
    local hasRaceV2 = raceData and raceData:FindFirstChild("V2") and raceData.V2.Value == true
    
    if hasRaceV2 or questStatus == -2 or questStatus == true then 
        Main_Module:SetNotify("Race V2", "Already completed!", 3)
        return true 
    end
    
    if questStatus == nil or questStatus == 0 or questStatus == false then 
        local AlchemistPos = QuestModules.FlowerLocations.AlchemistNPC
        if (AlchemistPos.Position - Character.HumanoidRootPart.Position).Magnitude <= 10 then
            QuestModules.StartAlchemistQuest()
            wait(0.5)
        else
            Main_Module.Tween(AlchemistPos)
        end
        return false 
    end
    
    if questStatus == 1 then
        local Backpack = Player:FindFirstChild("Backpack")
        local Character = Player.Character
        
        local hasFlower1 = (Backpack and Backpack:FindFirstChild("Flower 1")) or (Character and Character:FindFirstChild("Flower 1"))
        local hasFlower2 = (Backpack and Backpack:FindFirstChild("Flower 2")) or (Character and Character:FindFirstChild("Flower 2"))
        local hasFlower3 = (Backpack and Backpack:FindFirstChild("Flower 3")) or (Character and Character:FindFirstChild("Flower 3"))
        
        if not hasFlower1 then
            local flowerPos = workspace:FindFirstChild("Flower1") and workspace.Flower1.CFrame or QuestModules.FlowerLocations.Flower1
            if (flowerPos.Position - Character.HumanoidRootPart.Position).Magnitude <= 10 then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name == "Flower1" and obj:IsA("BasePart") then
                        firetouchinterest(Character.HumanoidRootPart, obj, 0)
                        wait(0.1)
                        firetouchinterest(Character.HumanoidRootPart, obj, 1)
                    end
                end
            else
                Main_Module.Tween(flowerPos)
            end
        elseif not hasFlower2 then
            local flowerPos = workspace:FindFirstChild("Flower2") and workspace.Flower2.CFrame or QuestModules.FlowerLocations.Flower2
            if (flowerPos.Position - Character.HumanoidRootPart.Position).Magnitude <= 10 then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name == "Flower2" and obj:IsA("BasePart") then
                        firetouchinterest(Character.HumanoidRootPart, obj, 0)
                        wait(0.1)
                        firetouchinterest(Character.HumanoidRootPart, obj, 1)
                    end
                end
            else
                Main_Module.Tween(flowerPos)
            end
        elseif not hasFlower3 then
            local foundEnemy = false
            for _, Enemy in pairs(Enemies:GetChildren()) do
                if Enemy.Name == "Swan Pirate" then
                    local EnemyHRP = Enemy:FindFirstChild("HumanoidRootPart")
                    local Humanoid = Enemy:FindFirstChild("Humanoid")
                    if EnemyHRP and Humanoid and Humanoid.Health > 0 then
                        EnemyHRP.CanCollide = false
                        EnemyHRP.Size = Vector3.new(60,60,60)
                        EnemyHRP.Transparency = 1
                        Humanoid:ChangeState(11)
                        Humanoid:ChangeState(14)
                        Main_Module.SetWeapon(Selected_Weapon)
                        Main_Module.Tween(EnemyHRP.CFrame * Farm_Mode)
                        Main_Module:BringEnemies(Enemy, true)
                        foundEnemy = true
                        break
                    end
                end
            end
            if not foundEnemy then
                Main_Module.Tween(QuestModules.FlowerLocations.Flower3Swan)
            end
        else
            local AlchemistPos = QuestModules.FlowerLocations.AlchemistNPC
            Main_Module.Tween(AlchemistPos)
        end
        return false
    end
    
    if questStatus == 2 then 
        local AlchemistPos = QuestModules.FlowerLocations.AlchemistNPC
        if (AlchemistPos.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 10 then
            QuestModules.CompleteAlchemistQuest()
            Main_Module:SetNotify("Race V2", "Quest completed! Race V2 unlocked!", 5)
        else
            Main_Module.Tween(AlchemistPos)
        end
    end
    return false
end

QuestModules.V3Locations = {
    WenlocktoadNPC = CFrame.new(-10579.5, 332.5, -9322.5),
    MinkChestArea = CFrame.new(-12500, 50, -7500),
    SkypieaCloudArea = CFrame.new(-4900, 750, -2900),
    HumanBossArea = CFrame.new(-2850, 50, 5350),
    FishmanSeaArea = CFrame.new(-3000, 10, -10000),
    GhoulGraveyardArea = CFrame.new(-5500, 100, -800),
    CyborgFactoryArea = CFrame.new(383, 75, -530)
}

QuestModules.V3KilledBosses = {
    Orbitus = false,
    Jeremy = false,
    Diamond = false
}

QuestModules.AutoRaceV3 = function()
    local Character = Player.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return false end
    
    local questStatus = nil
    pcall(function()
        questStatus = ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
    end)
    
    if questStatus == -2 then
        Main_Module:SetNotify("Race V3", "Already completed!", 3)
        return true
    end
    
    if questStatus == 0 then 
        local WenlocktoadPos = QuestModules.V3Locations.WenlocktoadNPC
        if (WenlocktoadPos.Position - Character.HumanoidRootPart.Position).Magnitude <= 10 then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
            wait(0.5)
        else
            Main_Module.Tween(WenlocktoadPos)
        end
        return false 
    end
    
    if questStatus == 2 then
        local WenlocktoadPos = QuestModules.V3Locations.WenlocktoadNPC
        if (WenlocktoadPos.Position - Character.HumanoidRootPart.Position).Magnitude <= 10 then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "3")
            Main_Module:SetNotify("Race V3", "Quest completed! Race V3 unlocked!", 5)
            QuestModules.V3KilledBosses = {Orbitus = false, Jeremy = false, Diamond = false}
        else
            Main_Module.Tween(WenlocktoadPos)
        end
        return false
    end
    
    if questStatus == 1 then
        local raceData = Player:FindFirstChild("Data") and Player.Data:FindFirstChild("Race")
        local race = raceData and raceData.Value or "Human"
        
        if race == "Mink" then
            Farming_Chest_Func = true
            Main_Module.Tween(QuestModules.V3Locations.MinkChestArea)
            
        elseif race == "Skypiea" then
            local foundPlayer = false
            for _, otherPlayer in pairs(Players:GetPlayers()) do
                if otherPlayer.Name ~= Player.Name then
                    local otherData = otherPlayer:FindFirstChild("Data")
                    if otherData and otherData:FindFirstChild("Race") and tostring(otherData.Race.Value) == "Skypiea" then
                        local otherChar = otherPlayer.Character
                        if otherChar and otherChar:FindFirstChild("HumanoidRootPart") and otherChar:FindFirstChild("Humanoid") then
                            if otherChar.Humanoid.Health > 0 then
                                Main_Module.Tween(otherChar.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0) * CFrame.Angles(math.rad(-45), 0, 0))
                                foundPlayer = true
                                break
                            end
                        end
                    end
                end
            end
            if not foundPlayer then
                Main_Module.Tween(QuestModules.V3Locations.SkypieaCloudArea)
                Main_Module:SetNotify("Race V3 - Skypiea", "Need another Skypiea player nearby", 5)
            end
            
        elseif race == "Human" then
            local targetBosses = {"Orbitus", "Jeremy", "Diamond"}
            local foundEnemy = false
            
            for _, bossName in ipairs(targetBosses) do
                if not QuestModules.V3KilledBosses[bossName] then
                    local boss = Enemies:FindFirstChild(bossName) or workspace:FindFirstChild(bossName)
                    if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                        local bossHRP = boss:FindFirstChild("HumanoidRootPart")
                        if bossHRP then
                            bossHRP.CanCollide = false
                            bossHRP.Size = Vector3.new(60, 60, 60)
                            bossHRP.Transparency = 1
                            boss.Humanoid:ChangeState(11)
                            boss.Humanoid:ChangeState(14)
                            Main_Module.SetWeapon(Selected_Weapon)
                            Main_Module.Tween(bossHRP.CFrame * CFrame.new(0, 30, 0))
                            Main_Module:BringEnemies(boss, true)
                            foundEnemy = true
                            break
                        end
                    else
                        if not Enemies:FindFirstChild(bossName) and not workspace:FindFirstChild(bossName) then
                            QuestModules.V3KilledBosses[bossName] = true
                        end
                    end
                end
            end
            
            if not foundEnemy then
                local allKilled = true
                for _, killed in pairs(QuestModules.V3KilledBosses) do
                    if not killed then allKilled = false break end
                end
                
                if not allKilled then
                    Main_Module:SetNotify("Race V3 - Human", "Bosses not found, server hop recommended", 5)
                else
                    local WenlocktoadPos = QuestModules.V3Locations.WenlocktoadNPC
                    Main_Module.Tween(WenlocktoadPos)
                end
            end
            
        elseif race == "Fishman" then
            Main_Module.Tween(QuestModules.V3Locations.FishmanSeaArea)
            Main_Module:SetNotify("Race V3 - Fishman", "Kill Sea Beast to complete", 5)
            
        elseif race == "Ghoul" then
            local targetEnemies = {"Reborn Skeleton", "Living Zombie", "Demonic Soul"}
            local foundEnemy = false
            
            for _, Enemy in pairs(Enemies:GetChildren()) do
                if table.find(targetEnemies, Enemy.Name) then
                    local EnemyHRP = Enemy:FindFirstChild("HumanoidRootPart")
                    local Humanoid = Enemy:FindFirstChild("Humanoid")
                    if EnemyHRP and Humanoid and Humanoid.Health > 0 then
                        EnemyHRP.CanCollide = false
                        EnemyHRP.Size = Vector3.new(60,60,60)
                        EnemyHRP.Transparency = 1
                        Humanoid:ChangeState(11)
                        Humanoid:ChangeState(14)
                        Main_Module.SetWeapon(Selected_Weapon)
                        Main_Module.Tween(EnemyHRP.CFrame * Farm_Mode)
                        Main_Module:BringEnemies(Enemy, true)
                        foundEnemy = true
                        break
                    end
                end
            end
            if not foundEnemy then
                Main_Module.Tween(QuestModules.V3Locations.GhoulGraveyardArea)
            end
            
        elseif race == "Cyborg" then
            Main_Module.Tween(QuestModules.V3Locations.CyborgFactoryArea)
        end
        return false
    end
    
    return false
end

QuestModules.RaceTrialPositions = {
    Human = CFrame.new(29221.822265625, 14890.9755859375, -205.99114990234375),
    Skypiea = CFrame.new(28960.158203125, 14919.6240234375, 235.03948974609375),
    Fishman = CFrame.new(28231.17578125, 14890.9755859375, -211.64173889160156),
    Cyborg = CFrame.new(28502.681640625, 14895.9755859375, -423.7279357910156),
    Ghoul = CFrame.new(28674.244140625, 14890.6767578125, 445.4310607910156),
    Mink = CFrame.new(29012.341796875, 14890.9755859375, -380.1492614746094)
}

QuestModules.RaceV4Trial = function()
    pcall(function()
        local race = Player.Data.Race.Value
        
        Main_Module.InvokeRemote("requestEntrance", Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
        wait(0.5)
        
        local trialPos = QuestModules.RaceTrialPositions[race]
        if trialPos then
            Main_Module.Tween(trialPos)
        end
        wait(0.5)
        
        if race == "Mink" then 
            ReplicatedStorage.Remotes.CommF_:InvokeServer("ZoroTrial", "Start")
        elseif race == "Fishman" then 
            ReplicatedStorage.Remotes.CommF_:InvokeServer("FishmanTrial", "Start")
        elseif race == "Ghoul" then 
            ReplicatedStorage.Remotes.CommF_:InvokeServer("GhoulTrial", "Start")
        elseif race == "Cyborg" then 
            ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrial", "Start")
        elseif race == "Skypiea" then 
            ReplicatedStorage.Remotes.CommF_:InvokeServer("SkyTrial", "Start")
        elseif race == "Human" then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("HumanTrial", "Start")
        end
    end)
end

QuestModules.RaceV4Training = function()
    pcall(function()
        VirtualInputManager:SendKeyEvent(true, "Y", false, game)
        wait(0.1)
        VirtualInputManager:SendKeyEvent(false, "Y", false, game)
        ReplicatedStorage.Remotes.CommE:FireServer("ActivateAbility")
    end)
end

QuestModules.LookMoonActivate = function()
    local Lighting = game:GetService("Lighting")
    local moonDir = Lighting:GetMoonDirection()
    local Character = Player.Character
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.Position + moonDir)
        Character.HumanoidRootPart.CFrame = CFrame.new(Character.HumanoidRootPart.Position, Character.HumanoidRootPart.Position + moonDir)
        ReplicatedStorage.Remotes.CommE:FireServer("ActivateAbility")
    end
end

-- ================================
-- UNDERWATER / SUBMERGED AREA (Level 2600+)
-- ================================

QuestModules.SubmarineDockPosition = CFrame.new(-16269.7041, 25.2288494, 1373.65955)
QuestModules.IsSubmergedTraveling = false
QuestModules.IsInSubmergedArea = false

QuestModules.CheckIfInSubmerged = function()
    local Character = Player.Character
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        local pos = Character.HumanoidRootPart.Position
        if pos.Y < -1500 then
            return true
        end
        if pos.X > 9000 and pos.X < 12000 and pos.Z > 8500 and pos.Z < 11000 then
            return true
        end
    end
    return false
end

QuestModules.TravelToSubmergedIsland = function()
    if QuestModules.IsSubmergedTraveling then return false end
    
    local Character = Player.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return false end
    
    local hrp = Character.HumanoidRootPart
    
    if QuestModules.CheckIfInSubmerged() then
        QuestModules.IsInSubmergedArea = true
        return true
    end
    
    QuestModules.IsSubmergedTraveling = true
    
    local attempts = 0
    repeat
        task.wait(0.5)
        Main_Module.Tween(QuestModules.SubmarineDockPosition)
        attempts = attempts + 1
    until (hrp.Position - QuestModules.SubmarineDockPosition.Position).Magnitude <= 10 or attempts > 30
    
    if (hrp.Position - QuestModules.SubmarineDockPosition.Position).Magnitude <= 10 then
        task.wait(1)
        pcall(function()
            local submarineRemote = ReplicatedStorage.Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak")
            if submarineRemote then
                submarineRemote:InvokeServer("TravelToSubmergedIsland")
            end
        end)
        
        local startTime = tick()
        repeat
            task.wait(0.5)
            if QuestModules.CheckIfInSubmerged() then
                QuestModules.IsInSubmergedArea = true
                break
            end
            local movedAway = (hrp.Position - QuestModules.SubmarineDockPosition.Position).Magnitude > 100
            if movedAway then break end
        until tick() - startTime > 15
        
        task.wait(2)
    end
    
    QuestModules.IsSubmergedTraveling = false
    return QuestModules.CheckIfInSubmerged()
end

QuestModules.NeedsSubmarineTravel = function()
    local Lv = Player.Data and Player.Data.Level and Player.Data.Level.Value or 0
    if Lv >= 2600 and not QuestModules.CheckIfInSubmerged() then
        return true
    end
    return false
end

return QuestModules
