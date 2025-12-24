--[[
    Get Weapons Module - Weapon & Fighting Style Acquisition
    Blox Fruits Script by Zlex Hub
    
    WEAPONS (requires specific bosses/quests):
    - Saber (Sea 1) - Puzzle quest + Saber Expert
    - Pole (Sea 1) - Thunder God
    - Shark Saw (Sea 1) - The Saw
    - Warden Sword (Sea 1) - Chief Warden
    - Trident (Sea 1) - Fishman Lord
    - Greybeard's Blade (Sea 1) - Greybeard
    - Rengoku (Sea 2) - Awakened Ice Admiral + Hidden Key
    - Dragon Trident (Sea 2) - Tide Keeper
    - Gravity Cane (Sea 2) - Smoke Admiral
    - Soul Guitar (Sea 3) - Complex puzzle quest
    - Yama (Sea 3) - 30 Elite Hunter kills
    - Tushita (Sea 3) - Holy Torch + Longma
    - CDK (Sea 3) - CDK Quest + Boss
    - Hallow Scythe (Sea 3) - Halloween event
    - Dark Dagger (Sea 3) - rip_indra
    - Twin Hooks (Sea 3) - Captain Elephant
    - Canvander (Sea 3) - Beautiful Pirate
    - Buddy Sword (Sea 3) - Cake Queen
    
    FIGHTING STYLES:
    - Super Human - 4 fighting styles at 300 mastery
    - Death Step - Black Leg 450 mastery
    - Fishman Karate - Buy with Beli
    - Electric Claw - Quest route
    - Dragon Talon - Fragments + mastery
    - God Human - 3 advanced styles at 400 mastery
]]

local GetWeapons = {}
local Settings = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local Player = Players.LocalPlayer
local CommF_ = ReplicatedStorage.Remotes.CommF_

local Utils
local Config

local World1 = game.PlaceId == 2753915549
local World2 = game.PlaceId == 4442272183
local World3 = game.PlaceId == 7449423635

function GetWeapons.Init(modules)
    Utils = modules.Utils
    Config = modules.Config
    
    Settings = {
        ["Auto Saber"] = false,
        ["Auto Pole"] = false,
        ["Auto Shark Saw"] = false,
        ["Auto Warden Sword"] = false,
        ["Auto Trident"] = false,
        ["Auto Greybeard"] = false,
        ["Auto Rengoku"] = false,
        ["Auto Dragon Trident"] = false,
        ["Auto Gravity Cane"] = false,
        ["Auto Soul Guitar"] = false,
        ["Auto Yama"] = false,
        ["Auto Tushita"] = false,
        ["Auto CDK"] = false,
        ["Auto Hallow Scythe"] = false,
        ["Auto Dark Dagger"] = false,
        ["Auto Twin Hooks"] = false,
        ["Auto Canvander"] = false,
        ["Auto Buddy Sword"] = false,
        ["Auto Super Human"] = false,
        ["Auto Death Step"] = false,
        ["Auto Fishman Karate"] = false,
        ["Auto Electric Claw"] = false,
        ["Auto Dragon Talon"] = false,
        ["Auto God Human"] = false,
    }
    
    GetWeapons.Settings = Settings
    return GetWeapons
end

local function HasWeapon(weaponName)
    local backpack = Player.Backpack
    local character = Player.Character
    return (backpack and backpack:FindFirstChild(weaponName)) or 
           (character and character:FindFirstChild(weaponName))
end

local function GetWeaponMastery(weaponName)
    local weapon = Player.Backpack:FindFirstChild(weaponName) or 
                   (Player.Character and Player.Character:FindFirstChild(weaponName))
    if weapon and weapon:FindFirstChild("Level") then
        return weapon.Level.Value
    end
    return 0
end

local function GetBeli()
    if Player.Data and Player.Data.Beli then
        return Player.Data.Beli.Value
    end
    return 0
end

local function GetFragments()
    if Player.Data and Player.Data.Fragments then
        return Player.Data.Fragments.Value
    end
    return 0
end

local function GetLevel()
    if Player.Data and Player.Data.Level then
        return Player.Data.Level.Value
    end
    return 0
end

local function FindEnemy(enemyName)
    for _, v in pairs(Workspace.Enemies:GetChildren()) do
        if v.Name == enemyName and v:FindFirstChild("Humanoid") and 
           v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            return v
        end
    end
    return nil
end

local function FindEnemyInStorage(enemyName)
    return ReplicatedStorage:FindFirstChild(enemyName)
end

local function Attack()
    VirtualUser:CaptureController()
    VirtualUser:Button1Down(Vector2.new(1280, 672), workspace.CurrentCamera.CFrame)
end

local function AutoHaki()
    if _G.Settings and _G.Settings.Setting["Auto Haki"] then
        local char = Player.Character
        if char then
            for _, v in pairs(char:GetChildren()) do
                if v:IsA("Tool") and v:FindFirstChild("RemoteFunctionShoot") then
                    v.RemoteFunctionShoot:InvokeServer("ActivateBuso")
                end
            end
        end
    end
end

local function EquipWeapon(weaponName)
    local weapon = Player.Backpack:FindFirstChild(weaponName)
    if weapon then
        Player.Character.Humanoid:EquipTool(weapon)
    end
end

local function UnEquipWeapon(weaponName)
    local char = Player.Character
    if char then
        local weapon = char:FindFirstChild(weaponName)
        if weapon then
            weapon.Parent = Player.Backpack
        end
    end
end

local function KillBoss(bossName, settingKey)
    local enemy = FindEnemy(bossName)
    if enemy then
        repeat
            task.wait()
            AutoHaki()
            if _G.Settings and _G.Settings.Main["Selected Weapon"] then
                EquipWeapon(_G.Settings.Main["Selected Weapon"])
            end
            enemy.HumanoidRootPart.CanCollide = false
            enemy.Humanoid.WalkSpeed = 0
            enemy.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
            Utils.TweenPlayer(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0), nil, true)
            Attack()
        until not Settings[settingKey] or not enemy.Parent or enemy.Humanoid.Health <= 0
        return true
    end
    return false
end

local function TweenToBoss(bossName, spawnPos)
    local enemyStorage = FindEnemyInStorage(bossName)
    if enemyStorage and enemyStorage:FindFirstChild("HumanoidRootPart") then
        Utils.TweenPlayer(enemyStorage.HumanoidRootPart.CFrame * CFrame.new(5, 20, 5))
    elseif spawnPos then
        Utils.TweenPlayer(spawnPos)
    end
end

function GetWeapons.AutoSaber()
    if not World1 or GetLevel() < 200 then return end
    
    pcall(function()
        local jungle = Workspace.Map.Jungle
        local desert = Workspace.Map.Desert
        
        if jungle.Final.Part.Transparency == 0 then
            if jungle.QuestPlates.Door.Transparency == 0 then
                local platePos = CFrame.new(-1612.55884, 36.9774132, 148.719543)
                local hrp = Utils.GetHumanoidRootPart()
                if hrp and (platePos.Position - hrp.Position).Magnitude <= 100 then
                    Utils.TweenPlayer(hrp.CFrame)
                    task.wait(1)
                    hrp.CFrame = jungle.QuestPlates.Plate1.Button.CFrame
                    task.wait(1)
                    hrp.CFrame = jungle.QuestPlates.Plate2.Button.CFrame
                    task.wait(1)
                    hrp.CFrame = jungle.QuestPlates.Plate3.Button.CFrame
                    task.wait(1)
                    hrp.CFrame = jungle.QuestPlates.Plate4.Button.CFrame
                    task.wait(1)
                    hrp.CFrame = jungle.QuestPlates.Plate5.Button.CFrame
                else
                    Utils.TweenPlayer(platePos)
                end
            elseif desert.Burn.Part.Transparency == 0 then
                if HasWeapon("Torch") then
                    EquipWeapon("Torch")
                    Utils.TweenPlayer(CFrame.new(1114.61475, 5.04679728, 4350.22803))
                else
                    Utils.TweenPlayer(CFrame.new(-1610.00757, 11.5049858, 164.001587))
                end
            elseif CommF_:InvokeServer("ProQuestProgress", "SickMan") ~= 0 then
                CommF_:InvokeServer("ProQuestProgress", "GetCup")
                task.wait(0.5)
                EquipWeapon("Cup")
                task.wait(0.5)
                local cup = Player.Character and Player.Character:FindFirstChild("Cup")
                if cup then
                    CommF_:InvokeServer("ProQuestProgress", "FillCup", cup)
                end
                task.wait(0.1)
                CommF_:InvokeServer("ProQuestProgress", "SickMan")
            elseif CommF_:InvokeServer("ProQuestProgress", "RichSon") == nil then
                CommF_:InvokeServer("ProQuestProgress", "RichSon")
            elseif CommF_:InvokeServer("ProQuestProgress", "RichSon") == 0 then
                if FindEnemy("Mob Leader") or FindEnemyInStorage("Mob Leader") then
                    KillBoss("Mob Leader", "Auto Saber")
                else
                    Utils.TweenPlayer(CFrame.new(-2967.59521, -4.91089821, 5328.70703))
                end
            elseif CommF_:InvokeServer("ProQuestProgress", "RichSon") == 1 then
                CommF_:InvokeServer("ProQuestProgress", "RichSon")
                task.wait(0.5)
                EquipWeapon("Relic")
                task.wait(0.5)
                Utils.TweenPlayer(CFrame.new(-1404.91504, 29.9773273, 3.80598116))
            end
        elseif FindEnemy("Saber Expert") or FindEnemyInStorage("Saber Expert") then
            local killed = KillBoss("Saber Expert", "Auto Saber")
            if killed then
                CommF_:InvokeServer("ProQuestProgress", "PlaceRelic")
            end
        end
    end)
end

function GetWeapons.AutoPole()
    if not World1 then return end
    
    pcall(function()
        if FindEnemy("Thunder God") then
            KillBoss("Thunder God", "Auto Pole")
        else
            TweenToBoss("Thunder God", CFrame.new(-281.526, 18.226, 3610.915))
        end
    end)
end

function GetWeapons.AutoSharkSaw()
    if not World1 then return end
    
    local sawSpawn = CFrame.new(-690.33081, 15.09425, 1582.238)
    pcall(function()
        if FindEnemy("The Saw") then
            KillBoss("The Saw", "Auto Shark Saw")
        else
            TweenToBoss("The Saw", sawSpawn)
        end
    end)
end

function GetWeapons.AutoWardenSword()
    if not World1 then return end
    
    pcall(function()
        if FindEnemy("Chief Warden") then
            KillBoss("Chief Warden", "Auto Warden Sword")
        else
            TweenToBoss("Chief Warden", CFrame.new(5257.18, 27.7, 737.47))
        end
    end)
end

function GetWeapons.AutoTrident()
    if not World1 then return end
    
    pcall(function()
        if FindEnemy("Fishman Lord") then
            KillBoss("Fishman Lord", "Auto Trident")
        else
            TweenToBoss("Fishman Lord", CFrame.new(61074.09, 17.86, 1557.52))
        end
    end)
end

function GetWeapons.AutoGreybeard()
    if not World1 then return end
    
    local greybeardSpawn = CFrame.new(-5023.38, 28.65, 4332.38)
    pcall(function()
        if FindEnemy("Greybeard") then
            KillBoss("Greybeard", "Auto Greybeard")
        else
            TweenToBoss("Greybeard", greybeardSpawn)
        end
    end)
end

function GetWeapons.AutoRengoku()
    if not World2 then return end
    
    local iceSpawn = CFrame.new(5439.716, 84.42, -6715.16)
    local keyDoor = CFrame.new(6571.12, 299.23, -6967.84)
    
    pcall(function()
        if HasWeapon("Hidden Key") then
            EquipWeapon("Hidden Key")
            Utils.TweenPlayer(keyDoor)
        elseif FindEnemy("Awakened Ice Admiral") or FindEnemy("Snow Lurker") or FindEnemy("Arctic Warrior") then
            for _, v in pairs(Workspace.Enemies:GetChildren()) do
                if (v.Name == "Awakened Ice Admiral" or v.Name == "Snow Lurker" or v.Name == "Arctic Warrior") 
                   and v.Humanoid.Health > 0 then
                    repeat
                        RunService.Heartbeat:Wait()
                        AutoHaki()
                        if _G.Settings and _G.Settings.Main["Selected Weapon"] then
                            EquipWeapon(_G.Settings.Main["Selected Weapon"])
                        end
                        v.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
                        Utils.TweenPlayer(v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0), nil, true)
                        Attack()
                    until HasWeapon("Hidden Key") or not Settings["Auto Rengoku"] or 
                          not v.Parent or v.Humanoid.Health <= 0
                end
            end
        else
            Utils.TweenPlayer(iceSpawn)
        end
    end)
end

function GetWeapons.AutoDragonTrident()
    if not World2 then return end
    
    pcall(function()
        if FindEnemy("Tide Keeper") then
            KillBoss("Tide Keeper", "Auto Dragon Trident")
        else
            TweenToBoss("Tide Keeper", CFrame.new(-2993.29, 293.02, -10159.84))
        end
    end)
end

function GetWeapons.AutoGravityCane()
    if not World2 then return end
    
    pcall(function()
        if FindEnemy("Smoke Admiral") then
            KillBoss("Smoke Admiral", "Auto Gravity Cane")
        else
            TweenToBoss("Smoke Admiral", CFrame.new(-455.35, 72.89, 299.11))
        end
    end)
end

function GetWeapons.AutoSoulGuitar()
    if not World3 then return end
    
    pcall(function()
        local result = CommF_:InvokeServer("soulGuitarBuy", true)
        if result == "[You already own this item.]" then
            return
        end
        
        if Player.Data.Fragments.Value < 5000 then
            return
        end
        
        local hasEctoplasm = CommF_:InvokeServer("getInventoryCount", "Ectoplasm") >= 250
        local hasBones = CommF_:InvokeServer("getInventoryCount", "Bones") >= 500
        local hasDarkFrag = CommF_:InvokeServer("getInventoryCount", "Dark Fragment") >= 1
        
        if hasDarkFrag and hasEctoplasm and hasBones then
            CommF_:InvokeServer("soulGuitarBuy", true)
            CommF_:InvokeServer("soulGuitarBuy")
        end
    end)
end

function GetWeapons.AutoYama()
    if not World3 then return end
    
    pcall(function()
        local progress = CommF_:InvokeServer("EliteHunter", "Progress")
        if progress and progress >= 30 then
            local sealedKatana = Workspace.Map.Waterfall:FindFirstChild("SealedKatana")
            if sealedKatana and sealedKatana.Handle:FindFirstChild("ClickDetector") then
                fireclickdetector(sealedKatana.Handle.ClickDetector)
            end
        end
    end)
end

function GetWeapons.AutoTushita()
    if not World3 then return end
    
    pcall(function()
        if FindEnemy("Longma") then
            KillBoss("Longma", "Auto Tushita")
        else
            TweenToBoss("Longma", CFrame.new(-10907.88, 334.08, -9477.93))
        end
    end)
end

function GetWeapons.AutoHolyTorch()
    if not World3 then return end
    
    local torchLocations = {
        CFrame.new(-10752, 417, -9366),
        CFrame.new(-11672, 334, -9474),
        CFrame.new(-12132, 521, -10655),
        CFrame.new(-13336, 486, -6985),
        CFrame.new(-13489, 332, -7925),
    }
    
    pcall(function()
        CommF_:InvokeServer("requestEntrance", Vector3.new(5657.886, 1013.079, -335.499))
        task.wait(1)
        Utils.TweenPlayer(CFrame.new(5711.87, 45.82, 254.17))
        task.wait(15)
        EquipWeapon("Holy Torch")
        
        for _, pos in ipairs(torchLocations) do
            if not Settings["Auto Holy Torch"] then break end
            repeat
                Utils.TweenPlayer(pos)
                task.wait()
            until not Settings["Auto Holy Torch"] or 
                  (Utils.GetHumanoidRootPart().Position - pos.Position).Magnitude <= 10
            task.wait(1)
        end
    end)
end

function GetWeapons.AutoCDK()
    if not World3 then return end
    
    local bossPos = CFrame.new(-12318.193, 601.951, -6538.662)
    
    pcall(function()
        CommF_:InvokeServer("CDKQuest", "Progress", "Good")
        CommF_:InvokeServer("CDKQuest", "Progress", "Evil")
        CommF_:InvokeServer("CDKQuest", "StartTrial", "Boss")
        
        local cdkBoss = FindEnemy("Cursed Captain")
        if cdkBoss then
            if HasWeapon("Yama") then
                EquipWeapon("Yama")
            elseif HasWeapon("Tushita") then
                EquipWeapon("Tushita")
            end
            KillBoss("Cursed Captain", "Auto CDK")
        else
            Utils.TweenPlayer(bossPos)
        end
    end)
end

function GetWeapons.AutoDarkDagger()
    if not World3 then return end
    
    local waitPos = CFrame.new(-5344.822, 423.985, -2725.093)
    
    pcall(function()
        local ripIndra = FindEnemy("rip_indra True Form") or FindEnemy("rip_indra")
        if ripIndra then
            repeat
                RunService.Heartbeat:Wait()
                AutoHaki()
                if _G.Settings and _G.Settings.Main["Selected Weapon"] then
                    EquipWeapon(_G.Settings.Main["Selected Weapon"])
                end
                ripIndra.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
                Utils.TweenPlayer(ripIndra.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0), nil, true)
                Attack()
            until not Settings["Auto Dark Dagger"] or ripIndra.Humanoid.Health <= 0
        else
            Utils.TweenPlayer(waitPos)
        end
    end)
end

function GetWeapons.AutoTwinHooks()
    if not World3 then return end
    
    pcall(function()
        if FindEnemy("Captain Elephant") then
            KillBoss("Captain Elephant", "Auto Twin Hooks")
        else
            TweenToBoss("Captain Elephant", CFrame.new(-13234.37, 332.43, -7662.10))
        end
    end)
end

function GetWeapons.AutoCanvander()
    if not World3 then return end
    
    pcall(function()
        if FindEnemy("Beautiful Pirate") then
            KillBoss("Beautiful Pirate", "Auto Canvander")
        else
            TweenToBoss("Beautiful Pirate", CFrame.new(-438.16, 72.90, -11606.56))
        end
    end)
end

function GetWeapons.AutoBuddySword()
    if not World3 then return end
    
    pcall(function()
        if FindEnemy("Cake Queen") then
            KillBoss("Cake Queen", "Auto Buddy Sword")
        else
            TweenToBoss("Cake Queen", CFrame.new(-2103.97, 26.14, -12275.91))
        end
    end)
end

function GetWeapons.AutoSuperHuman()
    pcall(function()
        if HasWeapon("Superhuman") then
            return
        end
        
        local beli = GetBeli()
        local fragments = GetFragments()
        
        if HasWeapon("Combat") and beli >= 150000 then
            UnEquipWeapon("Combat")
            task.wait(0.1)
            CommF_:InvokeServer("BuyBlackLeg")
        end
        
        local blackLegMastery = GetWeaponMastery("Black Leg")
        local electroMastery = GetWeaponMastery("Electro")
        local fishmanMastery = GetWeaponMastery("Fishman Karate")
        local dragonClawMastery = GetWeaponMastery("Dragon Claw")
        
        if blackLegMastery < 300 then
            _G.Settings.Main["Selected Weapon"] = "Black Leg"
        elseif electroMastery < 300 then
            if HasWeapon("Electro") then
                _G.Settings.Main["Selected Weapon"] = "Electro"
            elseif beli >= 300000 then
                UnEquipWeapon("Black Leg")
                task.wait(0.1)
                CommF_:InvokeServer("BuyElectro")
            end
        elseif fishmanMastery < 300 then
            if HasWeapon("Fishman Karate") then
                _G.Settings.Main["Selected Weapon"] = "Fishman Karate"
            elseif beli >= 750000 then
                UnEquipWeapon("Electro")
                task.wait(0.1)
                CommF_:InvokeServer("BuyFishmanKarate")
            end
        elseif dragonClawMastery < 300 then
            if HasWeapon("Dragon Claw") then
                _G.Settings.Main["Selected Weapon"] = "Dragon Claw"
            elseif fragments >= 1500 then
                UnEquipWeapon("Fishman Karate")
                task.wait(0.1)
                CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
                CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
            end
        elseif beli >= 3000000 then
            UnEquipWeapon("Dragon Claw")
            task.wait(0.1)
            CommF_:InvokeServer("BuySuperhuman")
        end
    end)
end

function GetWeapons.AutoDeathStep()
    pcall(function()
        if HasWeapon("Death Step") then
            return
        end
        
        if HasWeapon("Black Leg") then
            local mastery = GetWeaponMastery("Black Leg")
            if mastery >= 450 then
                CommF_:InvokeServer("BuyDeathStep")
            else
                _G.Settings.Main["Selected Weapon"] = "Black Leg"
            end
        else
            CommF_:InvokeServer("BuyBlackLeg")
        end
    end)
end

function GetWeapons.AutoFishmanKarate()
    pcall(function()
        if HasWeapon("Fishman Karate") then
            return
        end
        
        if GetBeli() >= 750000 then
            CommF_:InvokeServer("BuyFishmanKarate")
        end
    end)
end

function GetWeapons.AutoElectricClaw()
    if not World2 then return end
    
    local electricClawLocations = {
        CFrame.new(-12652.00, 332.54, -7511.26),
        CFrame.new(-12550.53, 336.22, -7510.42),
        CFrame.new(-10371.47, 330.76, -10131.41),
    }
    
    pcall(function()
        if HasWeapon("Electric Claw") then
            return
        end
        
        if not HasWeapon("Electro") then
            if GetBeli() >= 300000 then
                CommF_:InvokeServer("BuyElectro")
            end
            return
        end
        
        local mastery = GetWeaponMastery("Electro")
        if mastery < 400 then
            _G.Settings.Main["Selected Weapon"] = "Electro"
            return
        end
        
        for _, pos in ipairs(electricClawLocations) do
            if not Settings["Auto Electric Claw"] then break end
            repeat
                Utils.TweenPlayer(pos)
                task.wait()
            until not Settings["Auto Electric Claw"] or 
                  (Utils.GetHumanoidRootPart().Position - pos.Position).Magnitude <= 10
            task.wait(2)
        end
        
        CommF_:InvokeServer("BuyElectricClaw")
    end)
end

function GetWeapons.AutoDragonTalon()
    if not World2 then return end
    
    pcall(function()
        if HasWeapon("Dragon Talon") then
            return
        end
        
        if not HasWeapon("Dragon Claw") then
            if GetFragments() >= 1500 then
                CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
                CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
            end
            return
        end
        
        local mastery = GetWeaponMastery("Dragon Claw")
        if mastery < 400 then
            _G.Settings.Main["Selected Weapon"] = "Dragon Claw"
            return
        end
        
        Utils.TweenPlayer(CFrame.new(-440.83, 333.87, -1833.64))
        task.wait(1)
        CommF_:InvokeServer("BuyDragonTalon")
    end)
end

function GetWeapons.AutoGodHuman()
    if not World3 then return end
    
    pcall(function()
        if HasWeapon("Godhuman") then
            return
        end
        
        local deathStepMastery = GetWeaponMastery("Death Step")
        local electricClawMastery = GetWeaponMastery("Electric Claw")
        local dragonTalonMastery = GetWeaponMastery("Dragon Talon")
        
        if not HasWeapon("Death Step") then
            GetWeapons.AutoDeathStep()
            return
        end
        
        if not HasWeapon("Electric Claw") then
            return
        end
        
        if not HasWeapon("Dragon Talon") then
            return
        end
        
        if deathStepMastery < 400 then
            _G.Settings.Main["Selected Weapon"] = "Death Step"
        elseif electricClawMastery < 400 then
            _G.Settings.Main["Selected Weapon"] = "Electric Claw"
        elseif dragonTalonMastery < 400 then
            _G.Settings.Main["Selected Weapon"] = "Dragon Talon"
        else
            CommF_:InvokeServer("BuyGodhuman")
        end
    end)
end

function GetWeapons.Start()
    spawn(function()
        while task.wait(0.2) do
            pcall(function()
                if Settings["Auto Saber"] then GetWeapons.AutoSaber() end
                if Settings["Auto Pole"] then GetWeapons.AutoPole() end
                if Settings["Auto Shark Saw"] then GetWeapons.AutoSharkSaw() end
                if Settings["Auto Warden Sword"] then GetWeapons.AutoWardenSword() end
                if Settings["Auto Trident"] then GetWeapons.AutoTrident() end
                if Settings["Auto Greybeard"] then GetWeapons.AutoGreybeard() end
                if Settings["Auto Rengoku"] then GetWeapons.AutoRengoku() end
                if Settings["Auto Dragon Trident"] then GetWeapons.AutoDragonTrident() end
                if Settings["Auto Gravity Cane"] then GetWeapons.AutoGravityCane() end
                if Settings["Auto Soul Guitar"] then GetWeapons.AutoSoulGuitar() end
                if Settings["Auto Yama"] then GetWeapons.AutoYama() end
                if Settings["Auto Tushita"] then GetWeapons.AutoTushita() end
                if Settings["Auto CDK"] then GetWeapons.AutoCDK() end
                if Settings["Auto Dark Dagger"] then GetWeapons.AutoDarkDagger() end
                if Settings["Auto Twin Hooks"] then GetWeapons.AutoTwinHooks() end
                if Settings["Auto Canvander"] then GetWeapons.AutoCanvander() end
                if Settings["Auto Buddy Sword"] then GetWeapons.AutoBuddySword() end
                if Settings["Auto Super Human"] then GetWeapons.AutoSuperHuman() end
                if Settings["Auto Death Step"] then GetWeapons.AutoDeathStep() end
                if Settings["Auto Fishman Karate"] then GetWeapons.AutoFishmanKarate() end
                if Settings["Auto Electric Claw"] then GetWeapons.AutoElectricClaw() end
                if Settings["Auto Dragon Talon"] then GetWeapons.AutoDragonTalon() end
                if Settings["Auto God Human"] then GetWeapons.AutoGodHuman() end
            end)
        end
    end)
end

function GetWeapons.Stop()
    for key, _ in pairs(Settings) do
        Settings[key] = false
    end
end

function GetWeapons.Toggle(settingName, value)
    if Settings[settingName] ~= nil then
        Settings[settingName] = value
    end
end

function GetWeapons.GetAllSettings()
    return Settings
end

return GetWeapons
