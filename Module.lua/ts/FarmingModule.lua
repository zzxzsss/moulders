
local FarmingModule = {}

--// Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

--// Local Player
local LocalPlayer = Players.LocalPlayer

--// World Check
FarmingModule.First_Sea = false
FarmingModule.Second_Sea = false
FarmingModule.Third_Sea = false
local placeId = game.PlaceId
if placeId == 2753915549 then
    FarmingModule.First_Sea = true
elseif placeId == 4442272183 then
    FarmingModule.Second_Sea = true
elseif placeId == 7449423635 then
    FarmingModule.Third_Sea = true
end

First_Sea = FarmingModule.First_Sea
Second_Sea = FarmingModule.Second_Sea
Third_Sea = FarmingModule.Third_Sea

--// Global Variables for Farming
_G.SelectMonster = nil
_G.SelectBoss = nil
_G.SelectMaterial = nil
_G.Team = "Pirate"

SelectWeapon = "Combat"
SelectWeaponFarm = "Melee"
DisFarm = 25
Farm_Mode = CFrame.new(0, 25, 0)
bringfrec = 250
FastAttackDelay = 0.125
ByPassTP = false

--// Farm State Variables
LevelFarmQuest = false
LevelFarmNoQuest = false
SelectMonster_Quest_Farm = false
SelectMonster_NoQuest_Farm = false
Nearest_Farm = false
Farm_Bone = false
Farm_Ectoplasm = false
DevilMastery_Farm = false
Auto_Farm_Material = false
AutoBossFarm = false

--// Farm Names and CFrames (updated by loops)
Level_Farm_Name = ""
Level_Farm_CFrame = CFrame.new(0, 0, 0)
SelectMonster_Farm_Name = ""
SelectMonster_Farm_CFrame = CFrame.new(0, 0, 0)
Nearest_Farm_Name = ""
Nearest_Farm_CFrame = CFrame.new(0, 0, 0)
Bone_Farm_Name = ""
Bone_Farm_CFrame = CFrame.new(0, 0, 0)
Ecto_Farm_Name = ""
Ecto_Farm_CFrame = CFrame.new(0, 0, 0)
Mastery_Farm_Name = ""
Mastery_Farm_CFrame = CFrame.new(0, 0, 0)
Dojo_Farm_Name = ""
Dojo_Farm_CFrame = CFrame.new(0, 0, 0)

--// Quest Variables
Ms = ""
NameQuest = ""
QuestLv = 1
NameMon = ""
CFrameQ = CFrame.new(0, 0, 0)
CFrameMon = CFrame.new(0, 0, 0)

--// Boss Variables
BossMon = ""
NameBoss = ""
NameQuestBoss = ""
QuestLvBoss = 1
CFrameQBoss = CFrame.new(0, 0, 0)
CFrameBoss = CFrame.new(0, 0, 0)
RewardBoss = ""

--// Material Variables
MMon = ""
MPos = CFrame.new(0, 0, 0)
SP = "Default"



function FarmingModule.Tween(cf)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local tween = TweenService:Create(hrp, TweenInfo.new((hrp.Position - cf.Position).Magnitude / 300, Enum.EasingStyle.Linear), {CFrame = cf})
    tween:Play()
    return tween
end
Tween = FarmingModule.Tween

function FarmingModule.BTP(cf)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = cf
    end
end
BTP = FarmingModule.BTP

function FarmingModule.TP2(cf)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = cf
    end
end
TP2 = FarmingModule.TP2

function FarmingModule.CancelTween(toggle)
    if not toggle then
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Anchored = false
        end
    end
end
CancelTween = FarmingModule.CancelTween

function FarmingModule.EquipTool(toolName)
    pcall(function()
        if LocalPlayer.Backpack:FindFirstChild(toolName) then
            LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack[toolName])
        end
    end)
end
EquipTool = FarmingModule.EquipTool

function FarmingModule.AutoClick()
    pcall(function()
        if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool") then
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
        end
    end)
end
AutoClick = FarmingModule.AutoClick

--////////////////////////////////////////////////////////////////////////////////////////////////////
--// BRING MONSTER FUNCTION
--////////////////////////////////////////////////////////////////////////////////////////////////////

function FarmingModule.BringMonster(TargetName, TargetCFrame)
    local sethiddenproperty = sethiddenproperty or (function(...) return ... end)
    for i,v in pairs(Workspace.Enemies:GetChildren()) do
        if v.Name == TargetName then
            if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                if (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < tonumber(bringfrec) then
                    v.HumanoidRootPart.CFrame = TargetCFrame
                    v.HumanoidRootPart.CanCollide = false
                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                    v.HumanoidRootPart.Transparency = 1
                    v.Humanoid:ChangeState(11)
                    v.Humanoid:ChangeState(14)
                    if v.Humanoid:FindFirstChild("Animator") then
                        v.Humanoid.Animator:Destroy()
                    end
                end
            end
        end
    end
    pcall(sethiddenproperty, LocalPlayer, "SimulationRadius", math.huge)
end
BringMonster = FarmingModule.BringMonster

--////////////////////////////////////////////////////////////////////////////////////////////////////
--// ATTACK FUNCTIONS
--////////////////////////////////////////////////////////////////////////////////////////////////////

function FarmingModule.attackEnemies(enemyTarget)
    local plr = LocalPlayer
    local RegisterAttack = ReplicatedStorage.Modules.Net["RE/RegisterAttack"]
    local RegisterHit = ReplicatedStorage.Modules.Net["RE/RegisterHit"]
    local ShootGunEvent = ReplicatedStorage.Modules.Net["RE/ShootGunEvent"]
    local toolEquiped = plr.Character:FindFirstChildOfClass("Tool")

    if enemyTarget and (enemyTarget.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 55 then
        if toolEquiped and (toolEquiped.ToolTip == "Melee" or toolEquiped.ToolTip == "Sword") then
            RegisterAttack:FireServer(FastAttackDelay)
            RegisterHit:FireServer(enemyTarget, {})
        end
        if toolEquiped and toolEquiped.ToolTip == "Gun" then
            ShootGunEvent:FireServer(enemyTarget.Position, {[1] = enemyTarget})
        end
    end
end
attackEnemies = FarmingModule.attackEnemies

function FarmingModule.FastAttacked()
    local plr = LocalPlayer
    for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
        if Enemy:FindFirstChild("HumanoidRootPart") then
            FarmingModule.attackEnemies(Enemy.HumanoidRootPart)
        end
    end
    for _, PlayerName in pairs(Workspace.Characters:GetChildren()) do
        if PlayerName.Name ~= plr.Name and PlayerName:FindFirstChild("HumanoidRootPart") then
            FarmingModule.attackEnemies(PlayerName.HumanoidRootPart)
        end
    end
end
FastAttacked = FarmingModule.FastAttacked


function FarmingModule.CheckLevel()
    local Lv = LocalPlayer.Data.Level.Value
    if First_Sea then
        if Lv == 1 or Lv <= 9 or _G.SelectMonster == "Bandit [Lv. 5]" then
            Ms = "Bandit"
            NameQuest = "BanditQuest1"
            QuestLv = 1
            NameMon = "Bandit"
            CFrameQ = CFrame.new(1060.57251, 16.3419991, 1548.89673, -0.990634084, -4.04094017e-08, 0.136568248, -4.13322884e-08, 1, -7.05197863e-09, -0.136568248, -2.6207766e-08, -0.990634084)
            CFrameMon = CFrame.new(1091.16675, 16.0878201, 1567.37036, 0.94266808, -1.11095003e-08, -0.333759695, 2.60594946e-08, 1, 4.93652143e-08, 0.333759695, -5.52437016e-08, 0.94266808)
        elseif Lv >= 10 and Lv <= 14 or _G.SelectMonster == "Monkey [Lv. 14]" then
            Ms = "Monkey"
            NameMon = "Monkey"
            NameQuest = "JungleQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(-1601.62329, 37.1596222, 153.724106, -0.518245935, 8.63044091e-08, -0.855267704, 3.7882848e-08, 1, 7.75821051e-08, 0.855267704, 7.78795215e-09, -0.518245935)
            CFrameMon = CFrame.new(-1451.53101, 50.8518639, 71.3878403, 0.829072416, 3.09085052e-08, 0.559144258, 5.16766961e-09, 1, -6.28859159e-08, -0.559144258, 5.50236839e-08, 0.829072416)
        elseif Lv >= 15 and Lv <= 29 or _G.SelectMonster == "Gorilla [Lv. 20]" then
            Ms = "Gorilla"
            NameMon = "Gorilla"
            NameQuest = "JungleQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(-1601.62329, 37.1596222, 153.724106, -0.518245935, 8.63044091e-08, -0.855267704, 3.7882848e-08, 1, 7.75821051e-08, 0.855267704, 7.78795215e-09, -0.518245935)
            CFrameMon = CFrame.new(-1195.61353, 9.64259815, 121.126862)
        elseif Lv >= 30 and Lv <= 59 or _G.SelectMonster == "Pirate [Lv. 35]" then
            Ms = "Pirate"
            NameMon = "Pirate"
            NameQuest = "BuggyQuest1"
            QuestLv = 1
            CFrameQ = CFrame.new(-1139.76233, 4.75204754, 3827.62158, 0.456335127, -9.97920074e-08, 0.889800787, -1.27879045e-07, 1, 1.78119001e-07, -0.889800787, -1.95008874e-07, 0.456335127)
            CFrameMon = CFrame.new(-1214.28162, 5.64244127, 3888.5293)
        elseif Lv >= 60 and Lv <= 74 or _G.SelectMonster == "Brute [Lv. 70]" then
            Ms = "Brute"
            NameMon = "Brute"
            NameQuest = "BuggyQuest1"
            QuestLv = 2
            CFrameQ = CFrame.new(-1139.76233, 4.75204754, 3827.62158, 0.456335127, -9.97920074e-08, 0.889800787, -1.27879045e-07, 1, 1.78119001e-07, -0.889800787, -1.95008874e-07, 0.456335127)
            CFrameMon = CFrame.new(-1429.39941, 37.2312965, 3823.39136)
        elseif Lv >= 75 and Lv <= 89 or _G.SelectMonster == "Desert Bandit [Lv. 60]" then
            Ms = "Desert Bandit"
            NameMon = "Desert Bandit"
            NameQuest = "DesertQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(895.966614, 6.43846416, 4392.24268)
            CFrameMon = CFrame.new(985.8703, 17.3531494, 4333.7417)
        elseif Lv >= 90 and Lv <= 99 or _G.SelectMonster == "Desert Officer [Lv. 70]" then
            Ms = "Desert Officer"
            NameMon = "Desert Officer"
            NameQuest = "DesertQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(895.966614, 6.43846416, 4392.24268)
            CFrameMon = CFrame.new(1609.72925, 6.43842316, 4215.2876)
        elseif Lv >= 100 and Lv <= 119 or _G.SelectMonster == "Snow Bandit [Lv. 90]" then
            Ms = "Snow Bandit"
            NameMon = "Snow Bandit"
            NameQuest = "SnowQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(1386.06006, 87.3079224, -1298.08618)
            CFrameMon = CFrame.new(1396.5625, 95.1817856, -1173.58948)
        elseif Lv >= 120 and Lv <= 149 or _G.SelectMonster == "Snowman [Lv. 100]" then
            Ms = "Snowman"
            NameMon = "Snowman"
            NameQuest = "SnowQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(1386.06006, 87.3079224, -1298.08618)
            CFrameMon = CFrame.new(1318.01526, 115.605377, -1438.69397)
        elseif Lv >= 150 and Lv <= 174 or _G.SelectMonster == "Chief Petty Officer [Lv. 120]" then
            Ms = "Chief Petty Officer"
            NameMon = "Chief Petty Officer"
            NameQuest = "MarineQuest2"
            QuestLv = 1
            CFrameQ = CFrame.new(-5035.18457, 28.7030659, 4325.02539)
            CFrameMon = CFrame.new(-5163.20068, 22.0912762, 4284.37256)
        elseif Lv >= 175 and Lv <= 189 or _G.SelectMonster == "Sky Bandit [Lv. 150]" then
            Ms = "Sky Bandit"
            NameMon = "Sky Bandit"
            NameQuest = "SkyQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(-4840.94727, 716.488953, -2619.68408)
            CFrameMon = CFrame.new(-4954.60352, 735.989014, -2584.47119)
        elseif Lv >= 190 and Lv <= 209 or _G.SelectMonster == "Dark Master [Lv. 175]" then
            Ms = "Dark Master"
            NameMon = "Dark Master"
            NameQuest = "SkyQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(-4840.94727, 716.488953, -2619.68408)
            CFrameMon = CFrame.new(-5062.25439, 403.988861, -2768.59619)
        elseif Lv >= 210 and Lv <= 249 or _G.SelectMonster == "Prisoner [Lv. 190]" then
            Ms = "Prisoner"
            NameMon = "Prisoner"
            NameQuest = "PrisonerQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(5308.60596, 1.42498493, 475.322571)
            CFrameMon = CFrame.new(5354.01904, 0.574997902, 523.193359)
        elseif Lv >= 250 and Lv <= 274 or _G.SelectMonster == "Dangerous Prisoner [Lv. 210]" then
            Ms = "Dangerous Prisoner"
            NameMon = "Dangerous Prisoner"
            NameQuest = "PrisonerQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(5308.60596, 1.42498493, 475.322571)
            CFrameMon = CFrame.new(5593.56543, 1.42441463, 561.161072)
        elseif Lv >= 275 and Lv <= 299 or _G.SelectMonster == "Toga Warrior [Lv. 250]" then
            Ms = "Toga Warrior"
            NameMon = "Toga Warrior"
            NameQuest = "ColosseumQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(-1576.28809, 7.38515663, -2983.63989)
            CFrameMon = CFrame.new(-1479.48499, 8.87562275, -2920.37427)
        elseif Lv >= 300 and Lv <= 329 or _G.SelectMonster == "Gladiator [Lv. 275]" then
            Ms = "Gladiator"
            NameMon = "Gladiator"
            NameQuest = "ColosseumQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(-1576.28809, 7.38515663, -2983.63989)
            CFrameMon = CFrame.new(-1676.81433, 7.68530369, -3220.25854)
        elseif Lv >= 330 and Lv <= 374 or _G.SelectMonster == "Military Soldier [Lv. 300]" then
            Ms = "Military Soldier"
            NameMon = "Military Soldier"
            NameQuest = "MagmaQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(-5316.22168, 12.2994928, 8517.98535)
            CFrameMon = CFrame.new(-5399.54932, 14.1377048, 8360.25977)
        elseif Lv >= 375 and Lv <= 399 or _G.SelectMonster == "Military Spy [Lv. 330]" then
            Ms = "Military Spy"
            NameMon = "Military Spy"
            NameQuest = "MagmaQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(-5316.22168, 12.2994928, 8517.98535)
            CFrameMon = CFrame.new(-5622.0122, 12.2984657, 8561.59277)
        elseif Lv >= 400 and Lv <= 449 or _G.SelectMonster == "Fishman Warrior [Lv. 375]" then
            Ms = "Fishman Warrior"
            NameMon = "Fishman Warrior"
            NameQuest = "FishmanQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(61120.3359, 18.4828777, 1569.65894)
            CFrameMon = CFrame.new(61088.4961, 8.55996323, 1475.39233)
        elseif Lv >= 450 and Lv <= 474 or _G.SelectMonster == "Fishman Commando [Lv. 400]" then
            Ms = "Fishman Commando"
            NameMon = "Fishman Commando"
            NameQuest = "FishmanQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(61120.3359, 18.4828777, 1569.65894)
            CFrameMon = CFrame.new(61335.3164, 20.5628033, 1422.50281)
        elseif Lv >= 475 and Lv <= 524 or _G.SelectMonster == "God's Guard [Lv. 450]" then
            Ms = "God's Guard"
            NameMon = "God's Guard"
            NameQuest = "SkyExp1Quest"
            QuestLv = 1
            CFrameQ = CFrame.new(-4721.32129, 842.857666, -1950.12659)
            CFrameMon = CFrame.new(-4630.27783, 851.989075, -1911.66199)
        elseif Lv >= 525 and Lv <= 549 or _G.SelectMonster == "Shanda [Lv. 500]" then
            Ms = "Shanda"
            NameMon = "Shanda"
            NameQuest = "SkyExp1Quest"
            QuestLv = 2
            CFrameQ = CFrame.new(-4721.32129, 842.857666, -1950.12659)
            CFrameMon = CFrame.new(-7872.09375, 5544.14453, -380.065735)
        elseif Lv >= 550 and Lv <= 624 or _G.SelectMonster == "Royal Squad [Lv. 525]" then
            Ms = "Royal Squad"
            NameMon = "Royal Squad"
            NameQuest = "SkyExp2Quest"
            QuestLv = 1
            CFrameQ = CFrame.new(-7903.34277, 5635.67432, -1411.41418)
            CFrameMon = CFrame.new(-7697.84717, 5624.99707, -1377.40857)
        elseif Lv >= 625 and Lv <= 699 or _G.SelectMonster == "Royal Soldier [Lv. 550]" then
            Ms = "Royal Soldier"
            NameMon = "Royal Soldier"
            NameQuest = "SkyExp2Quest"
            QuestLv = 2
            CFrameQ = CFrame.new(-7903.34277, 5635.67432, -1411.41418)
            CFrameMon = CFrame.new(-7859.79199, 5669.41504, -1831.60632)
        elseif Lv >= 700 and Lv <= 749 or _G.SelectMonster == "Galley Pirate [Lv. 625]" then
            Ms = "Galley Pirate"
            NameMon = "Galley Pirate"
            NameQuest = "FountainQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(5258.58789, 38.5157318, 4050.10864)
            CFrameMon = CFrame.new(5309.7793, 0.574884415, 4127.44336)
        elseif Lv >= 750 then
            Ms = "Galley Captain"
            NameMon = "Galley Captain"
            NameQuest = "FountainQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(5258.58789, 38.5157318, 4050.10864)
            CFrameMon = CFrame.new(5649.35059, 91.0897293, 3972.7356)
        end
    elseif Second_Sea then
        if Lv >= 700 and Lv <= 724 or _G.SelectMonster == "Raider [Lv. 700]" then
            Ms = "Raider"
            NameMon = "Raider"
            NameQuest = "Area1Quest"
            QuestLv = 1
            CFrameQ = CFrame.new(-426.388489, 72.9998474, 1836.32324)
            CFrameMon = CFrame.new(-416.667297, 72.5987625, 1647.87659)
        elseif Lv >= 725 and Lv <= 774 or _G.SelectMonster == "Mercenary [Lv. 725]" then
            Ms = "Mercenary"
            NameMon = "Mercenary"
            NameQuest = "Area1Quest"
            QuestLv = 2
            CFrameQ = CFrame.new(-426.388489, 72.9998474, 1836.32324)
            CFrameMon = CFrame.new(-456.706818, 72.5987778, 1551.38794)
        elseif Lv >= 775 and Lv <= 799 or _G.SelectMonster == "Swan Pirate [Lv. 775]" then
            Ms = "Swan Pirate"
            NameMon = "Swan Pirate"
            NameQuest = "Area2Quest"
            QuestLv = 1
            CFrameQ = CFrame.new(638.43811, 73.0635071, 918.282898)
            CFrameMon = CFrame.new(558.653809, 72.5988388, 1063.03589)
        elseif Lv >= 800 and Lv <= 874 or _G.SelectMonster == "Factory Staff [Lv. 800]" then
            Ms = "Factory Staff"
            NameMon = "Factory Staff"
            NameQuest = "Area2Quest"
            QuestLv = 2
            CFrameQ = CFrame.new(638.43811, 73.0635071, 918.282898)
            CFrameMon = CFrame.new(23.7014446, 86.4892883, 1217.24597)
        elseif Lv >= 875 and Lv <= 899 or _G.SelectMonster == "Marine Lieutenant [Lv. 875]" then
            Ms = "Marine Lieutenant"
            NameMon = "Marine Lieutenant"
            NameQuest = "MarineQuest3"
            QuestLv = 1
            CFrameQ = CFrame.new(-2440.50757, 73.0515518, -3216.2605)
            CFrameMon = CFrame.new(-2538.04907, 72.8958054, -3279.37012)
        elseif Lv >= 900 and Lv <= 949 or _G.SelectMonster == "Marine Captain [Lv. 900]" then
            Ms = "Marine Captain"
            NameMon = "Marine Captain"
            NameQuest = "MarineQuest3"
            QuestLv = 2
            CFrameQ = CFrame.new(-2440.50757, 73.0515518, -3216.2605)
            CFrameMon = CFrame.new(-2224.83838, 72.5987549, -3500.47925)
        elseif Lv >= 950 and Lv <= 999 or _G.SelectMonster == "Zombie [Lv. 950]" then
            Ms = "Zombie"
            NameMon = "Zombie"
            NameQuest = "ZombieQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(-5765.71045, 51.9903755, -797.095703)
            CFrameMon = CFrame.new(-5786.78613, 51.8849144, -691.929382)
        elseif Lv >= 1000 and Lv <= 1049 or _G.SelectMonster == "Vampire [Lv. 1000]" then
            Ms = "Vampire"
            NameMon = "Vampire"
            NameQuest = "ZombieQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(-5765.71045, 51.9903755, -797.095703)
            CFrameMon = CFrame.new(-6031.97705, 51.8849144, -838.974976)
        elseif Lv >= 1050 and Lv <= 1099 or _G.SelectMonster == "Snow Trooper [Lv. 1050]" then
            Ms = "Snow Trooper"
            NameMon = "Snow Trooper"
            NameQuest = "SnowMountainQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(609.858887, 400.502686, -5765.52539)
            CFrameMon = CFrame.new(531.099365, 399.598785, -5625.58936)
        elseif Lv >= 1100 and Lv <= 1124 or _G.SelectMonster == "Winter Warrior [Lv. 1100]" then
            Ms = "Winter Warrior"
            NameMon = "Winter Warrior"
            NameQuest = "SnowMountainQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(609.858887, 400.502686, -5765.52539)
            CFrameMon = CFrame.new(1259.41284, 494.597748, -5840.50195)
        elseif Lv >= 1125 and Lv <= 1174 or _G.SelectMonster == "Lab Subordinate [Lv. 1125]" then
            Ms = "Lab Subordinate"
            NameMon = "Lab Subordinate"
            NameQuest = "IceSideQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(-6064.89893, 15.4495068, -4902.97461)
            CFrameMon = CFrame.new(-6071.06836, 14.5494556, -4790.36719)
        elseif Lv >= 1175 and Lv <= 1199 or _G.SelectMonster == "Horned Warrior [Lv. 1175]" then
            Ms = "Horned Warrior"
            NameMon = "Horned Warrior"
            NameQuest = "IceSideQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(-6064.89893, 15.4495068, -4902.97461)
            CFrameMon = CFrame.new(-5429.53076, 54.0970497, -4763.12988)
        elseif Lv >= 1200 and Lv <= 1249 or _G.SelectMonster == "Magma Ninja [Lv. 1200]" then
            Ms = "Magma Ninja"
            NameMon = "Magma Ninja"
            NameQuest = "FireSideQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(-5765.66162, 15.4495068, -5325.76416)
            CFrameMon = CFrame.new(-5591.59521, 14.5494556, -5351.45459)
        elseif Lv >= 1250 and Lv <= 1299 or _G.SelectMonster == "Lava Pirate [Lv. 1250]" then
            Ms = "Lava Pirate"
            NameMon = "Lava Pirate"
            NameQuest = "FireSideQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(-5765.66162, 15.4495068, -5325.76416)
            CFrameMon = CFrame.new(-5226.08691, 66.4426346, -5508.75049)
        elseif Lv >= 1300 and Lv <= 1324 or _G.SelectMonster == "Ship Deckhand [Lv. 1300]" then
            Ms = "Ship Deckhand"
            NameMon = "Ship Deckhand"
            NameQuest = "ShipQuest1"
            QuestLv = 1
            CFrameQ = CFrame.new(1037.80322, 125.092171, 32884.4297)
            CFrameMon = CFrame.new(945.989563, 175.048889, 33194.1328)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Lv >= 1325 and Lv <= 1349 or _G.SelectMonster == "Ship Engineer [Lv. 1325]" then
            Ms = "Ship Engineer"
            NameMon = "Ship Engineer"
            NameQuest = "ShipQuest1"
            QuestLv = 2
            CFrameQ = CFrame.new(1037.80322, 125.092171, 32884.4297)
            CFrameMon = CFrame.new(908.046814, 180.050781, 33372.4961)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Lv >= 1350 and Lv <= 1374 or _G.SelectMonster == "Ship Steward [Lv. 1350]" then
            Ms = "Ship Steward"
            NameMon = "Ship Steward"
            NameQuest = "ShipQuest2"
            QuestLv = 1
            CFrameQ = CFrame.new(968.80957, 125.092171, 33244.125)
            CFrameMon = CFrame.new(953.96936, 223.247269, 33411.9336)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Lv >= 1375 and Lv <= 1424 or _G.SelectMonster == "Ship Officer [Lv. 1375]" then
            Ms = "Ship Officer"
            NameMon = "Ship Officer"
            NameQuest = "ShipQuest2"
            QuestLv = 2
            CFrameQ = CFrame.new(968.80957, 125.092171, 33244.125)
            CFrameMon = CFrame.new(961.610596, 278.148224, 33463.5898)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Lv >= 1425 and Lv <= 1449 or _G.SelectMonster == "Arctic Warrior [Lv. 1425]" then
            Ms = "Arctic Warrior"
            NameMon = "Arctic Warrior"
            NameQuest = "FrostQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(5668.3584, 27.4498138, -6484.40332)
            CFrameMon = CFrame.new(5689.36816, 26.6000004, -6282.82031)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
            end
        elseif Lv >= 1450 and Lv <= 1474 or _G.SelectMonster == "Snow Lurker [Lv. 1450]" then
            Ms = "Snow Lurker"
            NameMon = "Snow Lurker"
            NameQuest = "FrostQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(5668.3584, 27.4498138, -6484.40332)
            CFrameMon = CFrame.new(5873.42383, 26.5999584, -6006.04688)
        elseif Lv >= 1475 and Lv <= 1499 or _G.SelectMonster == "Sea Soldier [Lv. 1475]" then
            Ms = "Sea Soldier"
            NameMon = "Sea Soldier"
            NameQuest = "ForgottenQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(-3053.84766, 235.449829, -10148.4189)
            CFrameMon = CFrame.new(-3157.77979, 236.998734, -10125.6982)
        elseif Lv >= 1500 then
            Ms = "Water Fighter"
            NameMon = "Water Fighter"
            NameQuest = "ForgottenQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(-3053.84766, 235.449829, -10148.4189)
            CFrameMon = CFrame.new(-3396.1897, 280.298981, -10325.3027)
        end
    elseif Third_Sea then
        if Lv >= 1500 and Lv <= 1524 or _G.SelectMonster == "Pirate Millionaire [Lv. 1500]" then
            Ms = "Pirate Millionaire"
            NameMon = "Pirate Millionaire"
            NameQuest = "PiratePortQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(-290.33725, 72.9933548, 5581.28516)
            CFrameMon = CFrame.new(-254.757309, 72.5987778, 5459.68359)
        elseif Lv >= 1525 and Lv <= 1574 or _G.SelectMonster == "Pistol Billionaire [Lv. 1525]" then
            Ms = "Pistol Billionaire"
            NameMon = "Pistol Billionaire"
            NameQuest = "PiratePortQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(-290.33725, 72.9933548, 5581.28516)
            CFrameMon = CFrame.new(-456.157684, 72.5987778, 5307.51318)
        elseif Lv >= 1575 and Lv <= 1599 or _G.SelectMonster == "Dragon Crew Warrior [Lv. 1575]" then
            Ms = "Dragon Crew Warrior"
            NameMon = "Dragon Crew Warrior"
            NameQuest = "AmazonQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(5833.11377, 51.6093826, -1214.61035)
            CFrameMon = CFrame.new(5703.46924, 58.9839478, -1172.17688)
        elseif Lv >= 1600 and Lv <= 1624 or _G.SelectMonster == "Dragon Crew Archer [Lv. 1600]" then
            Ms = "Dragon Crew Archer"
            NameMon = "Dragon Crew Archer"
            NameQuest = "AmazonQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(5833.11377, 51.6093826, -1214.61035)
            CFrameMon = CFrame.new(5545.83008, 117.598671, -1243.00842)
        elseif Lv >= 1625 and Lv <= 1649 or _G.SelectMonster == "Female Islander [Lv. 1625]" then
            Ms = "Female Islander"
            NameMon = "Female Islander"
            NameQuest = "AmazonQuest2"
            QuestLv = 1
            CFrameQ = CFrame.new(5446.16504, 601.549316, -57.3505669)
            CFrameMon = CFrame.new(5455.27832, 600.598755, 91.1866302)
        elseif Lv >= 1650 and Lv <= 1699 or _G.SelectMonster == "Giant Islander [Lv. 1650]" then
            Ms = "Giant Islander"
            NameMon = "Giant Islander"
            NameQuest = "AmazonQuest2"
            QuestLv = 2
            CFrameQ = CFrame.new(5446.16504, 601.549316, -57.3505669)
            CFrameMon = CFrame.new(5387.14795, 600.598755, 328.477539)
        elseif Lv >= 1700 and Lv <= 1724 or _G.SelectMonster == "Marine Commodore [Lv. 1700]" then
            Ms = "Marine Commodore"
            NameMon = "Marine Commodore"
            NameQuest = "MarineTreeIsland"
            QuestLv = 1
            CFrameQ = CFrame.new(2179.7688, 28.3158646, -6739.96924)
            CFrameMon = CFrame.new(2093.50244, 27.598835, -6692.29883)
        elseif Lv >= 1725 and Lv <= 1774 or _G.SelectMonster == "Marine Rear Admiral [Lv. 1750]" then
            Ms = "Marine Rear Admiral"
            NameMon = "Marine Rear Admiral"
            NameQuest = "MarineTreeIsland"
            QuestLv = 2
            CFrameQ = CFrame.new(2179.7688, 28.3158646, -6739.96924)
            CFrameMon = CFrame.new(2242.09912, 27.598835, -6905.59033)
        elseif Lv >= 1775 and Lv <= 1799 or _G.SelectMonster == "Forest Pirate [Lv. 1775]" then
            Ms = "Forest Pirate"
            NameMon = "Forest Pirate"
            NameQuest = "MansionQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(-13232.1416, 332.40387, -7626.34424)
            CFrameMon = CFrame.new(-13475.3389, 333.798767, -7749.09863)
        elseif Lv >= 1800 and Lv <= 1824 or _G.SelectMonster == "Mythological Pirate [Lv. 1800]" then
            Ms = "Mythological Pirate"
            NameMon = "Mythological Pirate"
            NameQuest = "MansionQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(-13232.1416, 332.40387, -7626.34424)
            CFrameMon = CFrame.new(-13085.8916, 332.398773, -7386.99756)
        elseif Lv >= 1825 and Lv <= 1849 or _G.SelectMonster == "Jungle Pirate [Lv. 1825]" then
            Ms = "Jungle Pirate"
            NameMon = "Jungle Pirate"
            NameQuest = "TikiQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(-10962.9268, 330.886597, -8813.75293)
            CFrameMon = CFrame.new(-10848.9668, 332.29245, -8842.82422)
        elseif Lv >= 1850 and Lv <= 1899 or _G.SelectMonster == "Musketeer Pirate [Lv. 1850]" then
            Ms = "Musketeer Pirate"
            NameMon = "Musketeer Pirate"
            NameQuest = "TikiQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(-10962.9268, 330.886597, -8813.75293)
            CFrameMon = CFrame.new(-10817.1348, 331.598755, -9163.33008)
        elseif Lv >= 1900 and Lv <= 1924 or _G.SelectMonster == "Reborn Skeleton [Lv. 1900]" then
            Ms = "Reborn Skeleton"
            NameMon = "Reborn Skeleton"
            NameQuest = "HauntedQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(-9516.47168, 143.132584, 5765.44189)
            CFrameMon = CFrame.new(-9500.8877, 141.198746, 5587.86914)
        elseif Lv >= 1925 and Lv <= 1974 or _G.SelectMonster == "Living Zombie [Lv. 1950]" then
            Ms = "Living Zombie"
            NameMon = "Living Zombie"
            NameQuest = "HauntedQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(-9516.47168, 143.132584, 5765.44189)
            CFrameMon = CFrame.new(-9364.21973, 141.198761, 5576.59082)
        elseif Lv >= 1975 and Lv <= 1999 or _G.SelectMonster == "Demonic Soul [Lv. 1975]" then
            Ms = "Demonic Soul"
            NameMon = "Demonic Soul"
            NameQuest = "HauntedQuest2"
            QuestLv = 1
            CFrameQ = CFrame.new(-9778.89746, 143.132584, 6237.90479)
            CFrameMon = CFrame.new(-9719.13965, 141.198761, 6163.80566)
        elseif Lv >= 2000 and Lv <= 2024 or _G.SelectMonster == "Posessed Mummy [Lv. 2000]" then
            Ms = "Posessed Mummy"
            NameMon = "Posessed Mummy"
            NameQuest = "HauntedQuest2"
            QuestLv = 2
            CFrameQ = CFrame.new(-9778.89746, 143.132584, 6237.90479)
            CFrameMon = CFrame.new(-9612.76953, 141.198746, 6144.49707)
        elseif Lv >= 2025 and Lv <= 2074 or _G.SelectMonster == "Peanut Scout [Lv. 2025]" then
            Ms = "Peanut Scout"
            NameMon = "Peanut Scout"
            NameQuest = "NutsVilageQuest1"
            QuestLv = 1
            CFrameQ = CFrame.new(-2103.70874, 48.4489746, -10182.9736)
            CFrameMon = CFrame.new(-2085.02588, 48.5987663, -10048.1045)
        elseif Lv >= 2075 and Lv <= 2099 or _G.SelectMonster == "Peanut President [Lv. 2050]" then
            Ms = "Peanut President"
            NameMon = "Peanut President"
            NameQuest = "NutsVilageQuest1"
            QuestLv = 2
            CFrameQ = CFrame.new(-2103.70874, 48.4489746, -10182.9736)
            CFrameMon = CFrame.new(-2191.66602, 48.5987778, -9831.59863)
        elseif Lv >= 2100 and Lv <= 2124 or _G.SelectMonster == "Ice Cream Chef [Lv. 2100]" then
            Ms = "Ice Cream Chef"
            NameMon = "Ice Cream Chef"
            NameQuest = "IceCreamIslandQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(-875.36084, 60.011898, -10771.7246)
            CFrameMon = CFrame.new(-850.161316, 58.3987656, -10926.0352)
        elseif Lv >= 2125 and Lv <= 2149 or _G.SelectMonster == "Ice Cream Commander [Lv. 2125]" then
            Ms = "Ice Cream Commander"
            NameMon = "Ice Cream Commander"
            NameQuest = "IceCreamIslandQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(-875.36084, 60.011898, -10771.7246)
            CFrameMon = CFrame.new(-1098.04419, 71.1987686, -11135.0293)
        elseif Lv >= 2150 and Lv <= 2199 or _G.SelectMonster == "Chocolate Bar Battler [Lv. 2150]" then
            Ms = "Chocolate Bar Battler"
            NameMon = "Chocolate Bar Battler"
            NameQuest = "ChocolateQuest"
            QuestLv = 1
            CFrameQ = CFrame.new(78.4247742, 24.4500103, -12501.457)
            CFrameMon = CFrame.new(123.07164, 23.5987854, -12408.0156)
        elseif Lv >= 2200 and Lv <= 2224 or _G.SelectMonster == "Sweet Thief [Lv. 2175]" then
            Ms = "Sweet Thief"
            NameMon = "Sweet Thief"
            NameQuest = "ChocolateQuest"
            QuestLv = 2
            CFrameQ = CFrame.new(78.4247742, 24.4500103, -12501.457)
            CFrameMon = CFrame.new(-186.020416, 23.5987778, -12611.6953)
        elseif Lv >= 2225 and Lv <= 2249 or _G.SelectMonster == "Candy Rebel [Lv. 2225]" then
            Ms = "Candy Rebel"
            NameMon = "Candy Rebel"
            NameQuest = "CandyQuest1"
            QuestLv = 1
            CFrameQ = CFrame.new(-1659.30261, 47.9499931, -14442.2305)
            CFrameMon = CFrame.new(-1552.2854, 47.5987778, -14500.0596)
        elseif Lv >= 2250 and Lv <= 2274 or _G.SelectMonster == "Candy Pirate [Lv. 2250]" then
            Ms = "Candy Pirate"
            NameMon = "Candy Pirate"
            NameQuest = "CandyQuest1"
            QuestLv = 2
            CFrameQ = CFrame.new(-1659.30261, 47.9499931, -14442.2305)
            CFrameMon = CFrame.new(-1398.27124, 47.5987778, -14570.627)
        elseif Lv >= 2275 and Lv <= 2299 or _G.SelectMonster == "Cookie Crafter [Lv. 2275]" then
            Ms = "Cookie Crafter"
            NameMon = "Cookie Crafter"
            NameQuest = "CakeQuest1"
            QuestLv = 1
            CFrameQ = CFrame.new(-2203.17407, 66.9500046, -12346.1357)
            CFrameMon = CFrame.new(-2143.14771, 66.5987778, -12187.6582)
        elseif Lv >= 2300 and Lv <= 2324 or _G.SelectMonster == "Cake Guard [Lv. 2300]" then
            Ms = "Cake Guard"
            NameMon = "Cake Guard"
            NameQuest = "CakeQuest1"
            QuestLv = 2
            CFrameQ = CFrame.new(-2203.17407, 66.9500046, -12346.1357)
            CFrameMon = CFrame.new(-2192.38599, 66.5988312, -12037.3975)
        elseif Lv >= 2325 and Lv <= 2349 or _G.SelectMonster == "Baking Staff [Lv. 2325]" then
            Ms = "Baking Staff"
            NameMon = "Baking Staff"
            NameQuest = "CakeQuest2"
            QuestLv = 1
            CFrameQ = CFrame.new(-1941.94836, 67.0110855, -11797.1475)
            CFrameMon = CFrame.new(-1902.24023, 66.5988312, -11638.3926)
        elseif Lv >= 2350 and Lv <= 2374 or _G.SelectMonster == "Head Baker [Lv. 2350]" then
            Ms = "Head Baker"
            NameMon = "Head Baker"
            NameQuest = "CakeQuest2"
            QuestLv = 2
            CFrameQ = CFrame.new(-1941.94836, 67.0110855, -11797.1475)
            CFrameMon = CFrame.new(-1991.0979, 66.5987854, -11459.3105)
        elseif Lv >= 2375 and Lv <= 2399 or _G.SelectMonster == "Cocoa Warrior [Lv. 2375]" then
            Ms = "Cocoa Warrior"
            NameMon = "Cocoa Warrior"
            NameQuest = "CocoaQuest1"
            QuestLv = 1
            CFrameQ = CFrame.new(-1023.49915, 180.050003, -11575.834)
            CFrameMon = CFrame.new(-1159.16809, 179.598755, -11609.0791)
        elseif Lv >= 2400 and Lv <= 2449 or _G.SelectMonster == "Chocolate Soldier [Lv. 2400]" then
            Ms = "Chocolate Soldier"
            NameMon = "Chocolate Soldier"
            NameQuest = "CocoaQuest1"
            QuestLv = 2
            CFrameQ = CFrame.new(-1023.49915, 180.050003, -11575.834)
            CFrameMon = CFrame.new(-1402.95764, 179.598755, -11735.9912)
        elseif Lv >= 2450 and Lv <= 2499 or _G.SelectMonster == "Order Enforcer [Lv. 2450]" then
            Ms = "Order Enforcer"
            NameMon = "Order Enforcer"
            NameQuest = "OrderQuest1"
            QuestLv = 1
            CFrameQ = CFrame.new(-5481.87842, 313.800018, -2917.6394)
            CFrameMon = CFrame.new(-5604.72217, 313.398804, -2821.59717)
        elseif Lv >= 2500 and Lv <= 2524 or _G.SelectMonster == "Chief Warden [Lv. 2500]" then
            Ms = "Chief Warden"
            NameMon = "Chief Warden"
            NameQuest = "OrderQuest1"
            QuestLv = 2
            CFrameQ = CFrame.new(-5481.87842, 313.800018, -2917.6394)
            CFrameMon = CFrame.new(-5716.57861, 313.398804, -2656.76709)
        elseif Lv >= 2525 and Lv <= 2549 or _G.SelectMonster == "Elemental Master [Lv. 2525]" then
            Ms = "Elemental Master"
            NameMon = "Elemental Master"
            NameQuest = "DarknessQuest1"
            QuestLv = 1
            CFrameQ = CFrame.new(-5343.71631, 313.755493, -2668.60693)
            CFrameMon = CFrame.new(-5281.03809, 313.398804, -2545.51685)
        elseif Lv >= 2550 and Lv <= 2574 or _G.SelectMonster == "Divine Apprentice [Lv. 2550]" then
            Ms = "Divine Apprentice"
            NameMon = "Divine Apprentice"
            NameQuest = "DarknessQuest1"
            QuestLv = 2
            CFrameQ = CFrame.new(-5343.71631, 313.755493, -2668.60693)
            CFrameMon = CFrame.new(-5147.91553, 313.398804, -2455.98511)
        elseif Lv >= 2575 and Lv <= 2599 or _G.SelectMonster == "Dragon Warrior [Lv. 2575]" then
            Ms = "Dragon Warrior"
            NameMon = "Dragon Warrior"
            NameQuest = "DragonIslandQuest1"
            QuestLv = 1
            CFrameQ = CFrame.new(4741.76514, 7.54999924, 1406.97754)
            CFrameMon = CFrame.new(4597.61328, 6.59876442, 1348.72168)
        elseif Lv >= 2600 and Lv <= 2624 or _G.SelectMonster == "Dragon Attacker [Lv. 2600]" then
            Ms = "Dragon Attacker"
            NameMon = "Dragon Attacker"
            NameQuest = "DragonIslandQuest1"
            QuestLv = 2
            CFrameQ = CFrame.new(4741.76514, 7.54999924, 1406.97754)
            CFrameMon = CFrame.new(4438.48633, 6.59876442, 1192.25659)
        elseif Lv >= 2625 and Lv <= 2674 or _G.SelectMonster == "Dragon Blaster [Lv. 2625]" then
            Ms = "Dragon Blaster"
            NameMon = "Dragon Blaster"
            NameQuest = "DragonIslandQuest2"
            QuestLv = 1
            CFrameQ = CFrame.new(4389.56689, 7.54999924, 1009.38147)
            CFrameMon = CFrame.new(4256.13574, 6.59876442, 875.48938)
        elseif Lv >= 2675 or _G.SelectMonster == "Fierce Dragon [Lv. 2650]" then
            Ms = "Fierce Dragon"
            NameMon = "Fierce Dragon"
            NameQuest = "DragonIslandQuest2"
            QuestLv = 2
            CFrameQ = CFrame.new(4389.56689, 7.54999924, 1009.38147)
            CFrameMon = CFrame.new(3978.97925, 6.59876442, 651.765015)
        end
    end
end
CheckLevel = FarmingModule.CheckLevel


function FarmingModule.CheckBoss()
    local SelectBoss = _G.SelectBoss
    if First_Sea then
        if SelectBoss == "Greybeard" then
            BossMon = "Greybeard [Lv. 750] [Raid Boss]"
            NameBoss = 'Greybeard'
            CFrameBoss = CFrame.new(-4985.1411132813, 78.679740905762, 4303.7646484375)
        elseif SelectBoss == "The Gorilla King" then
            BossMon = "The Gorilla King [Lv. 25] [Boss]"
            NameBoss = 'The Gorilla King'
            NameQuestBoss = "JungleQuest"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(-1601.62329, 37.1596222, 153.724106)
            CFrameBoss = CFrame.new(-1230.7197265625, 51.893474578857, -498.40496826172)
        elseif SelectBoss == "Bobby" then
            BossMon = "Bobby [Lv. 55] [Boss]"
            NameBoss = 'Bobby'
            NameQuestBoss = "BuggyQuest1"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(-1139.76233, 4.75204754, 3827.62158)
            CFrameBoss = CFrame.new(-1137.3284912109, 4.7520532608032, 4169.330078125)
        elseif SelectBoss == "Yeti" then
            BossMon = "Yeti [Lv. 110] [Boss]"
            NameBoss = 'Yeti'
            NameQuestBoss = "SnowQuest"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(1386.06006, 87.3079224, -1298.08618)
            CFrameBoss = CFrame.new(1185.0389404297, 137.60304260254, -1553.8209228516)
        elseif SelectBoss == "Vice Admiral" then
            BossMon = "Vice Admiral [Lv. 130] [Boss]"
            NameBoss = 'Vice Admiral'
            CFrameBoss = CFrame.new(-5078.2236328125, 22.117267608643, 4275.5546875)
        elseif SelectBoss == "Saber Expert" then
            BossMon = "Saber Expert [Lv. 200] [Boss]"
            NameBoss = 'Saber Expert'
            CFrameBoss = CFrame.new(-1455.38916015625, 28.800020217896, -50.810001373291)
        elseif SelectBoss == "Magma Admiral" then
            BossMon = "Magma Admiral [Lv. 350] [Boss]"
            NameBoss = 'Magma Admiral'
            NameQuestBoss = "MagmaQuest"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(-5316.22168, 12.2994928, 8517.98535)
            CFrameBoss = CFrame.new(-5246.0913085938, 12.298462867737, 8781.1962890625)
        elseif SelectBoss == "Fishman Lord" then
            BossMon = "Fishman Lord [Lv. 425] [Boss]"
            NameBoss = 'Fishman Lord'
            NameQuestBoss = "FishmanQuest"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(61120.3359, 18.4828777, 1569.65894)
            CFrameBoss = CFrame.new(61497.57421875, 18.478958129883, 1516.0419921875)
        elseif SelectBoss == "Wysper" then
            BossMon = "Wysper [Lv. 500] [Boss]"
            NameBoss = 'Wysper'
            NameQuestBoss = "SkyExp1Quest"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(-4721.32129, 842.857666, -1950.12659)
            CFrameBoss = CFrame.new(-7684.9091796875, 5600.3901367188, -498.20349121094)
        elseif SelectBoss == "Thunder God" then
            BossMon = "Thunder God [Lv. 575] [Boss]"
            NameBoss = 'Thunder God'
            NameQuestBoss = "SkyExp2Quest"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(-7903.34277, 5635.67432, -1411.41418)
            CFrameBoss = CFrame.new(-7865.6669921875, 5656.1088867188, -1589.4140625)
        elseif SelectBoss == "Cyborg" then
            BossMon = "Cyborg [Lv. 675] [Boss]"
            NameBoss = 'Cyborg'
            NameQuestBoss = "FountainQuest"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(5258.58789, 38.5157318, 4050.10864)
            CFrameBoss = CFrame.new(6265.7377929688, 5.5759701728821, 3938.8522949219)
        end
    elseif Second_Sea then
        if SelectBoss == "Darkbeard" then
            BossMon = "Darkbeard [Lv. 1000] [Raid Boss]"
            NameBoss = 'Darkbeard'
            CFrameBoss = CFrame.new(3862.0168457031, 23.674018859863, -3935.3854980469)
        elseif SelectBoss == "Diamond" then
            BossMon = "Diamond [Lv. 750] [Boss]"
            NameBoss = 'Diamond'
            NameQuestBoss = "Area1Quest"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(-426.388489, 72.9998474, 1836.32324)
            CFrameBoss = CFrame.new(60.451282501221, 72.598579406738, 1434.6864013672)
        elseif SelectBoss == "Jeremy" then
            BossMon = "Jeremy [Lv. 850] [Boss]"
            NameBoss = 'Jeremy'
            NameQuestBoss = "Area2Quest"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(638.43811, 73.0635071, 918.282898)
            CFrameBoss = CFrame.new(263.50198364258, 181.59854125977, 578.47937011719)
        elseif SelectBoss == "Fajita" then
            BossMon = "Fajita [Lv. 925] [Boss]"
            NameBoss = 'Fajita'
            NameQuestBoss = "MarineQuest3"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(-2440.50757, 73.0515518, -3216.2605)
            CFrameBoss = CFrame.new(-2066.5129394531, 72.598754882813, -3249.1572265625)
        elseif SelectBoss == "Don Swan" then
            BossMon = "Don Swan [Lv. 1000] [Boss]"
            NameBoss = 'Don Swan'
            CFrameBoss = CFrame.new(2302.16211, 15.1777983, 663.811951)
        elseif SelectBoss == "Smoke Admiral" then
            BossMon = "Smoke Admiral [Lv. 1150] [Boss]"
            NameBoss = 'Smoke Admiral'
            NameQuestBoss = "IceSideQuest"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(-6064.89893, 15.4495068, -4902.97461)
            CFrameBoss = CFrame.new(-5981.7436523438, 70.200538635254, -4802.037109375)
        elseif SelectBoss == "Awakened Ice Admiral" then
            BossMon = "Awakened Ice Admiral [Lv. 1400] [Boss]"
            NameBoss = 'Awakened Ice Admiral'
            CFrameBoss = CFrame.new(6229.1943359375, 58.449901580811, -6586.6962890625)
        elseif SelectBoss == "Tide Keeper" then
            BossMon = "Tide Keeper [Lv. 1475] [Boss]"
            NameBoss = 'Tide Keeper'
            NameQuestBoss = "ForgottenQuest"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(-3053.84766, 235.449829, -10148.4189)
            CFrameBoss = CFrame.new(-3048.6552734375, 326.08984375, -9995.6845703125)
        elseif SelectBoss == "Order" then
            BossMon = "Order [Lv. 1250] [Raid Boss]"
            NameBoss = 'Order'
            CFrameBoss = CFrame.new(-5324.7465820313, 424.13946533203, -2767.0380859375)
        end
    elseif Third_Sea then
        if SelectBoss == "Stone" then
            BossMon = "Stone [Lv. 1550] [Boss]"
            NameBoss = 'Stone'
            NameQuestBoss = "PiratePortQuest"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(-290.33725, 72.9933548, 5581.28516)
            CFrameBoss = CFrame.new(-292.0233154297, 72.598838806152, 5264.2548828125)
        elseif SelectBoss == "Island Empress" then
            BossMon = "Island Empress [Lv. 1675] [Boss]"
            NameBoss = 'Island Empress'
            NameQuestBoss = "AmazonQuest2"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(5446.16504, 601.549316, -57.3505669)
            CFrameBoss = CFrame.new(5559.3872070313, 666.9541015625, 153.48989868164)
        elseif SelectBoss == "Kilo Admiral" then
            BossMon = "Kilo Admiral [Lv. 1750] [Boss]"
            NameBoss = 'Kilo Admiral'
            NameQuestBoss = "MarineTreeIsland"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(2179.7688, 28.3158646, -6739.96924)
            CFrameBoss = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125)
        elseif SelectBoss == "Captain Elephant" then
            BossMon = "Captain Elephant [Lv. 1875] [Boss]"
            NameBoss = 'Captain Elephant'
            NameQuestBoss = "MansionQuest"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(-13232.1416, 332.40387, -7626.34424)
            CFrameBoss = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
        elseif SelectBoss == "Beautiful Pirate" then
            BossMon = "Beautiful Pirate [Lv. 1950] [Boss]"
            NameBoss = 'Beautiful Pirate'
            NameQuestBoss = "TikiQuest"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(-10962.9268, 330.886597, -8813.75293)
            CFrameBoss = CFrame.new(5283.609375, 22.56223487854, -110.78285217285)
        elseif SelectBoss == "Longma" then
            BossMon = "Longma [Lv. 2000] [Boss]"
            NameBoss = 'Longma'
            CFrameBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
        elseif SelectBoss == "Soul Reaper" then
            BossMon = "Soul Reaper [Lv. 2100] [Raid Boss]"
            NameBoss = 'Soul Reaper'
            CFrameBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
        elseif SelectBoss == "rip_indra True Form" then
            BossMon = "rip_indra True Form [Lv. 5000] [Raid Boss]"
            NameBoss = 'rip_indra True Form'
            CFrameBoss = CFrame.new(-5415.3920898438, 505.74133300781, -2814.0166015625)
        elseif SelectBoss == "Cake Queen" then
            BossMon = "Cake Queen [Lv. 2175] [Boss]"
            NameBoss = 'Cake Queen'
            NameQuestBoss = "IceCreamIslandQuest"
            QuestLvBoss = 3
            CFrameQBoss = CFrame.new(-875.36084, 60.011898, -10771.7246)
            CFrameBoss = CFrame.new(-678.648804, 381.353943, -11114.2012)
        elseif SelectBoss == "Dough King" then
            BossMon = "Dough King [Lv. 2300] [Raid Boss]"
            NameBoss = 'Dough King'
            CFrameBoss = CFrame.new(-2836.8100585938, 66.939559936523, -12150.201171875)
        elseif SelectBoss == "Terrorshark" then
            BossMon = "Terrorshark [Lv. 2000] [Boss]"
            NameBoss = 'Terrorshark'
            CFrameBoss = CFrame.new(0, 0, 0) 
        end
    end
end
CheckBoss = FarmingModule.CheckBoss



function FarmingModule.MaterialMon()
    local SelectMaterial = _G.SelectMaterial
    if SelectMaterial == "Radioactive Material" then
        MMon = "Factory Staff"
        MPos = CFrame.new(295, 73, -56)
        SP = "Default"
    elseif SelectMaterial == "Mystic Droplet" then
        MMon = "Water Fighter"
        MPos = CFrame.new(-3385, 239, -10542)
        SP = "Default"
    elseif SelectMaterial == "Magma Ore" then
        if First_Sea then
            MMon = "Military Spy"
            MPos = CFrame.new(-5815, 84, 8820)
            SP = "Default"
        elseif Second_Sea then
            MMon = "Magma Ninja"
            MPos = CFrame.new(-5428, 78, -5959)
            SP = "Default"
        end
    elseif SelectMaterial == "Angel Wings" then
        MMon = "God's Guard"
        MPos = CFrame.new(-4698, 845, -1912)
        SP = "Default"
        if (LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-7859.09814, 5544.19043, -381.476196)).Magnitude >= 5000 then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7859.09814, 5544.19043, -381.476196))
        end
    elseif SelectMaterial == "Leather" then
        if First_Sea then
            MMon = "Brute"
            MPos = CFrame.new(-1145, 15, 4350)
        elseif Second_Sea then
            MMon = "Marine Captain"
            MPos = CFrame.new(-2010.5059814453, 73.00115966796875, -3326.620849609375)
        elseif Third_Sea then
            MMon = "Jungle Pirate"
            MPos = CFrame.new(-11975.78515625, 331.7734069824219, -10620.0302734375)
        end
        SP = "Default"
    elseif SelectMaterial == "Scrap Metal" then
        if First_Sea then
            MMon = "Brute"
            MPos = CFrame.new(-1145, 15, 4350)
        elseif Second_Sea then
            MMon = "Swan Pirate"
            MPos = CFrame.new(878, 122, 1235)
        elseif Third_Sea then
            MMon = "Jungle Pirate"
            MPos = CFrame.new(-12107, 332, -10549)
        end
        SP = "Default"
    elseif SelectMaterial == "Fish Tail" then
        if Third_Sea then
            MMon = "Fishman Raider"
            MPos = CFrame.new(-10993, 332, -8940)
        elseif First_Sea then
            MMon = "Fishman Warrior"
            MPos = CFrame.new(61123, 19, 1569)
            if (LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875)).Magnitude >= 17000 then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875))
            end
        end
        SP = "Default"
    elseif SelectMaterial == "Demonic Wisp" then
        MMon = "Demonic Soul"
        MPos = CFrame.new(-9507, 172, 6158)
        SP = "Default"
    elseif SelectMaterial == "Vampire Fang" then
        MMon = "Vampire"
        MPos = CFrame.new(-6033, 7, -1317)
        SP = "Default"
    elseif SelectMaterial == "Conjured Cocoa" then
        MMon = "Chocolate Bar Battler"
        MPos = CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625)
        SP = "Default"
    elseif SelectMaterial == "Dragon Scale" then
        MMon = "Dragon Crew Archer"
        MPos = CFrame.new(6594, 383, 139)
        SP = "Default"
    elseif SelectMaterial == "Gunpowder" then
        MMon = "Pistol Billionaire"
        MPos = CFrame.new(-469, 74, 5904)
        SP = "Default"
    elseif SelectMaterial == "Mini Tusk" then
        MMon = "Mythological Pirate"
        MPos = CFrame.new(-13545, 470, -6917)
        SP = "Default"
    end
end
MaterialMon = FarmingModule.MaterialMon


FarmingModule.tableMon = {
    "Bandit [Lv. 5]",
    "Monkey [Lv. 14]",
    "Gorilla [Lv. 20]",
    "Pirate [Lv. 35]",
    "Brute [Lv. 70]",
    "Desert Bandit [Lv. 60]",
    "Desert Officer [Lv. 70]",
    "Snow Bandit [Lv. 90]",
    "Snowman [Lv. 100]",
    "Chief Petty Officer [Lv. 120]",
    "Sky Bandit [Lv. 150]",
    "Dark Master [Lv. 175]",
    "Prisoner [Lv. 190]",
    "Dangerous Prisoner [Lv. 210]",
    "Toga Warrior [Lv. 250]",
    "Gladiator [Lv. 275]",
    "Military Soldier [Lv. 300]",
    "Military Spy [Lv. 330]",
    "Fishman Warrior [Lv. 375]",
    "Fishman Commando [Lv. 400]",
    "God's Guard [Lv. 450]",
    "Shanda [Lv. 500]",
    "Royal Squad [Lv. 525]",
    "Royal Soldier [Lv. 550]",
    "Galley Pirate [Lv. 625]",
    "Galley Captain [Lv. 650]",
    "Raider [Lv. 700]",
    "Mercenary [Lv. 725]",
    "Swan Pirate [Lv. 775]",
    "Factory Staff [Lv. 800]",
    "Marine Lieutenant [Lv. 875]",
    "Marine Captain [Lv. 900]",
    "Zombie [Lv. 950]",
    "Vampire [Lv. 1000]",
    "Snow Trooper [Lv. 1050]",
    "Winter Warrior [Lv. 1100]",
    "Lab Subordinate [Lv. 1125]",
    "Horned Warrior [Lv. 1175]",
    "Magma Ninja [Lv. 1200]",
    "Lava Pirate [Lv. 1250]",
    "Ship Deckhand [Lv. 1300]",
    "Ship Engineer [Lv. 1325]",
    "Ship Steward [Lv. 1350]",
    "Ship Officer [Lv. 1375]",
    "Arctic Warrior [Lv. 1425]",
    "Snow Lurker [Lv. 1450]",
    "Sea Soldier [Lv. 1475]",
    "Water Fighter [Lv. 1500]",
    "Pirate Millionaire [Lv. 1500]",
    "Pistol Billionaire [Lv. 1525]",
    "Dragon Crew Warrior [Lv. 1575]",
    "Dragon Crew Archer [Lv. 1600]",
    "Female Islander [Lv. 1625]",
    "Giant Islander [Lv. 1650]",
    "Marine Commodore [Lv. 1700]",
    "Marine Rear Admiral [Lv. 1750]",
    "Forest Pirate [Lv. 1775]",
    "Mythological Pirate [Lv. 1800]",
    "Jungle Pirate [Lv. 1825]",
    "Musketeer Pirate [Lv. 1850]",
    "Reborn Skeleton [Lv. 1900]",
    "Living Zombie [Lv. 1950]",
    "Demonic Soul [Lv. 1975]",
    "Posessed Mummy [Lv. 2000]",
    "Peanut Scout [Lv. 2025]",
    "Peanut President [Lv. 2050]",
    "Ice Cream Chef [Lv. 2100]",
    "Ice Cream Commander [Lv. 2125]",
    "Chocolate Bar Battler [Lv. 2150]",
    "Sweet Thief [Lv. 2175]",
    "Candy Rebel [Lv. 2225]",
    "Candy Pirate [Lv. 2250]",
    "Cookie Crafter [Lv. 2275]",
    "Cake Guard [Lv. 2300]",
    "Baking Staff [Lv. 2325]",
    "Head Baker [Lv. 2350]",
    "Cocoa Warrior [Lv. 2375]",
    "Chocolate Soldier [Lv. 2400]",
    "Order Enforcer [Lv. 2450]",
    "Chief Warden [Lv. 2500]",
    "Elemental Master [Lv. 2525]",
    "Divine Apprentice [Lv. 2550]",
    "Dragon Warrior [Lv. 2575]",
    "Dragon Attacker [Lv. 2600]",
    "Dragon Blaster [Lv. 2625]",
    "Fierce Dragon [Lv. 2650]"
}
tableMon = FarmingModule.tableMon

FarmingModule.tableBoss = {
    "Greybeard",
    "The Gorilla King",
    "Bobby",
    "Yeti",
    "Vice Admiral",
    "Saber Expert",
    "Magma Admiral",
    "Fishman Lord",
    "Wysper",
    "Thunder God",
    "Cyborg",
    "Darkbeard",
    "Diamond",
    "Jeremy",
    "Fajita",
    "Don Swan",
    "Smoke Admiral",
    "Awakened Ice Admiral",
    "Tide Keeper",
    "Order",
    "Stone",
    "Island Empress",
    "Kilo Admiral",
    "Captain Elephant",
    "Beautiful Pirate",
    "Longma",
    "Soul Reaper",
    "rip_indra True Form",
    "Cake Queen",
    "Dough King",
    "Terrorshark"
}
tableBoss = FarmingModule.tableBoss


if First_Sea then
    FarmingModule.MaterialList = {"Scrap Metal", "Leather", "Angel Wings", "Magma Ore", "Fish Tail"}
elseif Second_Sea then
    FarmingModule.MaterialList = {"Scrap Metal", "Leather", "Radioactive Material", "Mystic Droplet", "Magma Ore", "Vampire Fang"}
elseif Third_Sea then
    FarmingModule.MaterialList = {"Scrap Metal", "Leather", "Demonic Wisp", "Conjured Cocoa", "Dragon Scale", "Gunpowder", "Fish Tail", "Mini Tusk"}
else
    FarmingModule.MaterialList = {}
end
MaterialList = FarmingModule.MaterialList



function FarmingModule.StartLevelFarmQuest()
    LevelFarmQuest = true
    spawn(function()
        while LevelFarmQuest do
            task.wait()
            pcall(function()
                FarmingModule.CheckLevel()
                if not string.find(LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                    if ByPassTP then
                        BTP(CFrameQ)
                    else
                        Tween(CFrameQ)
                    end
                    if (CFrameQ.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                        wait(0.5)
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                    end
                elseif string.find(LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                    if Workspace.Enemies:FindFirstChild(Ms) then
                        for i,v in pairs(Workspace.Enemies:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                if v.Name == Ms then
                                    repeat RunService.Heartbeat:wait()
                                        EquipTool(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                        v.HumanoidRootPart.Transparency = 1
                                        Level_Farm_Name = v.Name
                                        Level_Farm_CFrame = v.HumanoidRootPart.CFrame
                                        AutoClick()
                                    until not LevelFarmQuest or not v.Parent or v.Humanoid.Health <= 0 or not Workspace.Enemies:FindFirstChild(v.Name) or LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        end
                    else
                        if ByPassTP then
                            BTP(CFrameMon)
                        else
                            Tween(CFrameMon)
                        end
                    end
                end
            end)
        end
    end)
end

function FarmingModule.StopLevelFarmQuest()
    LevelFarmQuest = false
    CancelTween(false)
end

function FarmingModule.StartLevelFarmNoQuest()
    LevelFarmNoQuest = true
    spawn(function()
        while LevelFarmNoQuest do
            task.wait()
            pcall(function()
                FarmingModule.CheckLevel()
                if Workspace.Enemies:FindFirstChild(Ms) then
                    for i,v in pairs(Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            if v.Name == Ms then
                                repeat RunService.Heartbeat:wait()
                                    EquipTool(SelectWeapon)
                                    Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.Transparency = 1
                                    Level_Farm_Name = v.Name
                                    Level_Farm_CFrame = v.HumanoidRootPart.CFrame
                                    AutoClick()
                                until not LevelFarmNoQuest or not v.Parent or v.Humanoid.Health <= 0 or not Workspace.Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end
                else
                    if ByPassTP then
                        BTP(CFrameMon)
                    else
                        Tween(CFrameMon)
                    end
                end
            end)
        end
    end)
end

function FarmingModule.StopLevelFarmNoQuest()
    LevelFarmNoQuest = false
    CancelTween(false)
end

function FarmingModule.StartSelectMonsterFarmQuest()
    SelectMonster_Quest_Farm = true
    spawn(function()
        while SelectMonster_Quest_Farm do
            task.wait()
            pcall(function()
                FarmingModule.CheckLevel(_G.SelectMonster)
                if not string.find(LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                    if ByPassTP then
                        BTP(CFrameQ)
                    else
                        Tween(CFrameQ)
                    end
                    if (CFrameQ.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                    end
                elseif string.find(LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                    if Workspace.Enemies:FindFirstChild(Ms) then
                        for i,v in pairs(Workspace.Enemies:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                if v.Name == Ms then
                                    repeat RunService.Heartbeat:wait()
                                        EquipTool(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                        v.HumanoidRootPart.Transparency = 1
                                        SelectMonster_Farm_Name = v.Name
                                        SelectMonster_Farm_CFrame = v.HumanoidRootPart.CFrame
                                        AutoClick()
                                    until not SelectMonster_Quest_Farm or not v.Parent or v.Humanoid.Health <= 0 or not Workspace.Enemies:FindFirstChild(v.Name) or LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        end
                    else
                        Tween(CFrameMon)
                    end
                end
            end)
        end
    end)
end

function FarmingModule.StopSelectMonsterFarmQuest()
    SelectMonster_Quest_Farm = false
    CancelTween(false)
end

function FarmingModule.StartNearestFarm()
    Nearest_Farm = true
    spawn(function()
        while Nearest_Farm do
            task.wait()
            pcall(function()
                local nearestEnemy = nil
                local nearestDist = math.huge
                for i,v in pairs(Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        local dist = (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        if dist < nearestDist then
                            nearestDist = dist
                            nearestEnemy = v
                        end
                    end
                end
                if nearestEnemy then
                    repeat RunService.Heartbeat:wait()
                        EquipTool(SelectWeapon)
                        Tween(nearestEnemy.HumanoidRootPart.CFrame * Farm_Mode)
                        nearestEnemy.HumanoidRootPart.CanCollide = false
                        nearestEnemy.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                        nearestEnemy.HumanoidRootPart.Transparency = 1
                        Nearest_Farm_Name = nearestEnemy.Name
                        Nearest_Farm_CFrame = nearestEnemy.HumanoidRootPart.CFrame
                        AutoClick()
                    until not Nearest_Farm or not nearestEnemy.Parent or nearestEnemy.Humanoid.Health <= 0 or not Workspace.Enemies:FindFirstChild(nearestEnemy.Name)
                end
            end)
        end
    end)
end

function FarmingModule.StopNearestFarm()
    Nearest_Farm = false
    CancelTween(false)
end

function FarmingModule.StartBossFarm()
    AutoBossFarm = true
    spawn(function()
        while AutoBossFarm do
            task.wait()
            pcall(function()
                FarmingModule.CheckBoss()
                if Workspace.Enemies:FindFirstChild(NameBoss) then
                    for i,v in pairs(Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            if v.Name == NameBoss then
                                repeat RunService.Heartbeat:wait()
                                    EquipTool(SelectWeapon)
                                    Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.Transparency = 1
                                    AutoClick()
                                until not AutoBossFarm or not v.Parent or v.Humanoid.Health <= 0 or not Workspace.Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end
                else
                    if ByPassTP then
                        BTP(CFrameBoss)
                    else
                        Tween(CFrameBoss)
                    end
                end
            end)
        end
    end)
end

function FarmingModule.StopBossFarm()
    AutoBossFarm = false
    CancelTween(false)
end

function FarmingModule.StartMaterialFarm()
    Auto_Farm_Material = true
    spawn(function()
        while Auto_Farm_Material do
            task.wait()
            pcall(function()
                FarmingModule.MaterialMon()
                if Workspace.Enemies:FindFirstChild(MMon) then
                    for i,v in pairs(Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            if v.Name == MMon then
                                repeat RunService.Heartbeat:wait()
                                    EquipTool(SelectWeapon)
                                    Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.Transparency = 1
                                    AutoClick()
                                until not Auto_Farm_Material or not v.Parent or v.Humanoid.Health <= 0 or not Workspace.Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end
                else
                    if ByPassTP then
                        BTP(MPos)
                    else
                        Tween(MPos)
                    end
                end
            end)
        end
    end)
end

function FarmingModule.StopMaterialFarm()
    Auto_Farm_Material = false
    CancelTween(false)
end

function FarmingModule.StartBoneFarm()
    Farm_Bone = true
    spawn(function()
        while Farm_Bone do
            task.wait()
            pcall(function()
                local boneframe = CFrame.new(-9508.5673828125, 142.1398468017578, 5737.3603515625)
                if ByPassTP then
                    BTP(boneframe)
                else
                    Tween(boneframe)
                end
                for i,v in pairs(Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
                            repeat RunService.Heartbeat:wait()
                                EquipTool(SelectWeapon)
                                Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
                                Bone_Farm_Name = v.Name
                                Bone_Farm_CFrame = v.HumanoidRootPart.CFrame
                                AutoClick()
                            until not Farm_Bone or not v.Parent or v.Humanoid.Health <= 0 or not Workspace.Enemies:FindFirstChild(v.Name)
                        end
                    end
                end
            end)
        end
    end)
end

function FarmingModule.StopBoneFarm()
    Farm_Bone = false
    CancelTween(false)
end

function FarmingModule.StartEctoplasmFarm()
    Farm_Ectoplasm = true
    spawn(function()
        while Farm_Ectoplasm do
            task.wait()
            pcall(function()
                local ectoframe = CFrame.new(904.4072265625, 181.05767822266, 33341.38671875)
                if (ectoframe.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                end
                if ByPassTP then
                    BTP(ectoframe)
                else
                    Tween(ectoframe)
                end
                for i,v in pairs(Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        if v.Name == "Ship Deckhand" or v.Name == "Ship Engineer" or v.Name == "Ship Steward" or v.Name == "Ship Officer" then
                            repeat RunService.Heartbeat:wait()
                                EquipTool(SelectWeapon)
                                Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
                                Ecto_Farm_Name = v.Name
                                Ecto_Farm_CFrame = v.HumanoidRootPart.CFrame
                                AutoClick()
                            until not Farm_Ectoplasm or not v.Parent or v.Humanoid.Health <= 0 or not Workspace.Enemies:FindFirstChild(v.Name)
                        end
                    end
                end
            end)
        end
    end)
end

function FarmingModule.StopEctoplasmFarm()
    Farm_Ectoplasm = false
    CancelTween(false)
end


function FarmingModule.StartBringMobs()
    getgenv().BringMobs = true
    spawn(function()
        while getgenv().BringMobs do
            task.wait()
            pcall(function()
                if getgenv().BringMobs and LevelFarmQuest then
                    BringMonster(Level_Farm_Name, Level_Farm_CFrame)
                elseif getgenv().BringMobs and LevelFarmNoQuest then
                    BringMonster(Level_Farm_Name, Level_Farm_CFrame)
                elseif getgenv().BringMobs and Farm_Bone then
                    BringMonster(Bone_Farm_Name, Bone_Farm_CFrame)
                elseif getgenv().BringMobs and Farm_Ectoplasm then
                    BringMonster(Ecto_Farm_Name, Ecto_Farm_CFrame)
                elseif getgenv().BringMobs and Nearest_Farm then
                    BringMonster(Nearest_Farm_Name, Nearest_Farm_CFrame)
                elseif getgenv().BringMobs and SelectMonster_Quest_Farm then
                    BringMonster(SelectMonster_Farm_Name, SelectMonster_Farm_CFrame)
                elseif getgenv().BringMobs and SelectMonster_NoQuest_Farm then
                    BringMonster(SelectMonster_Farm_Name, SelectMonster_Farm_CFrame)
                end
            end)
        end
    end)
end

function FarmingModule.StopBringMobs()
    getgenv().BringMobs = false
end



function FarmingModule.StartFastAttack()
    getgenv().FastAttack = true
    task.spawn(function()
        while getgenv().FastAttack do
            task.wait()
            pcall(function()
                FastAttacked()
            end)
        end
    end)
end

function FarmingModule.StopFastAttack()
    getgenv().FastAttack = false
end



function FarmingModule.StartWeaponSelection()
    spawn(function()
        while true do
            wait()
            pcall(function()
                if SelectWeaponFarm == "Melee" then
                    for i, v in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if v.ToolTip == "Melee" then
                            SelectWeapon = v.Name
                        end
                    end
                elseif SelectWeaponFarm == "Sword" then
                    for i, v in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if v.ToolTip == "Sword" then
                            SelectWeapon = v.Name
                        end
                    end
                elseif SelectWeaponFarm == "Blox Fruit" then
                    for i, v in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if v.ToolTip == "Blox Fruit" then
                            SelectWeapon = v.Name
                        end
                    end
                elseif SelectWeaponFarm == "Gun" then
                    for i, v in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if v.ToolTip == "Gun" then
                            SelectWeapon = v.Name
                        end
                    end
                end
            end)
        end
    end)
end



function FarmingModule.StartFarmModeLoop()
    spawn(function()
        while true do
            task.wait()
            pcall(function()
                Farm_Mode = CFrame.new(0, DisFarm, 0)
            end)
        end
    end)
end


function FarmingModule.Init()
    FarmingModule.StartWeaponSelection()
    FarmingModule.StartFarmModeLoop()
end

return FarmingModule
