

local EventsModule = {}

--// Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Lighting = game:GetService("Lighting")

--// Local Player
local LocalPlayer = Players.LocalPlayer

--// World Check
local placeId = game.PlaceId
local First_Sea = placeId == 2753915549
local Second_Sea = placeId == 4442272183
local Third_Sea = placeId == 7449423635

EventsModule.First_Sea = First_Sea
EventsModule.Second_Sea = Second_Sea
EventsModule.Third_Sea = Third_Sea

--// Event State Variables
EventsModule.DojoClaimQuest = false
EventsModule.WhiteBeltF = false
EventsModule.YellowBeltF = false
EventsModule.OrangeBeltF = false
EventsModule.GreenBeltF = false
EventsModule.BlueBeltF = false
EventsModule.PurpleBeltF = false
EventsModule.RedBeltF = false
EventsModule.BlackBeltF = false
EventsModule.DragonTalonUpgrade = false
EventsModule.BlazeEmberFarm = false
EventsModule.TreeDestroyFarm = false
EventsModule.AutoSail = false
EventsModule.AutoSeaBeast = false
EventsModule.SeaUseSkill = false
EventsModule.AutoMirageIsland = false
EventsModule.AutoKitsuneIsland = false
EventsModule.AutoRaceV4 = false
EventsModule.AutoEliteHunter = false
EventsModule.AutoPirateCastle = false
EventsModule.AutoSuperhuman = false
EventsModule.AutoDeathStep = false
EventsModule.AutoSharkman = false
EventsModule.AutoElectricClaw = false
EventsModule.AutoDragonTalon = false
EventsModule.AutoGodhuman = false
EventsModule.AutoStartRaid = false
EventsModule.AutoFarmRaid = false
EventsModule.AutoPole = false
EventsModule.AutoCavander = false
EventsModule.RipIndra = false
EventsModule.AutoRainbowHaki = false
EventsModule.AutoColorHaki = false
EventsModule.AutoMusketeer = false
EventsModule.AutoSickScientist = false
EventsModule.AutoTrial = false

--// Sea Variables
SeaLevelSelected = 'Level 1'
BoatSelected = 'Dinghy'
TeamSelected = 'Pirates'
SeaCFrame = CFrame.new(0, 0, 0)
SelectWeaponSeaFarm = 'Melee'
DisSeaFarm = 30
SpeedBoatTween = 350
SpeedAllBoat = 150
AutoTouchW = false
_G.SeaSkillZ = true
_G.SeaSkillX = true
_G.SeaSkillC = false
_G.SeaSkillV = false
_G.SeaSkillF = false
SeaMonPosition = Vector3.new(0, 0, 0)

--// Dojo Variables
EventsModule.DojoQuestNpc = CFrame.new(5855.19629, 1208.32178, 872.713501, 0.606994748, -1.81058823e-09, -0.794705868, 5.72712722e-09, 1, 2.09605577e-09, 0.794705868, -5.82367621e-09, 0.606994748)
EventsModule.DragonNpc = CFrame.new(5865.80811, 1209.50269, 811.746582, -0.675207436, -6.76664627e-08, 0.737627923, 8.33632186e-09, 1, 9.93661047e-08, -0.737627923, 7.32418357e-08, -0.675207436)
EventsModule.UzothNPC = CFrame.new(5661.89014, 1211.31909, 864.836731, 0.811413169, -1.36805838e-08, -0.584473014, 4.75227395e-08, 1, 4.25682458e-08, 0.584473014, -6.23161966e-08, 0.811413169)
EventsModule.DragonHunterPos = CFrame.new(5394.36475, 1082.71057, 561.993958)

--// Race V4 Variables
EventsModule.RaceV4Step = 1

--// Raid Variables
RaidSelected = "Flame"


function EventsModule.Tween(cf)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local tween = TweenService:Create(hrp, TweenInfo.new((hrp.Position - cf.Position).Magnitude / 300, Enum.EasingStyle.Linear), {CFrame = cf})
    tween:Play()
    return tween
end

function EventsModule.BTP(cf)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = cf
    end
end

function EventsModule.TP2(cf)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = cf
    end
end

function EventsModule.CancelTween(toggle)
    if not toggle then
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Anchored = false
        end
    end
end

function EventsModule.EquipTool(toolName)
    pcall(function()
        if LocalPlayer.Backpack:FindFirstChild(toolName) then
            LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack[toolName])
        end
    end)
end

function EventsModule.AutoClick()
    pcall(function()
        if LocalPlayer.Character:FindFirstChildOfClass("Tool") then
            LocalPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
        end
    end)
end



function EventsModule.getAcc(BeltName)
    for i,v in pairs(ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")) do
        if type(v) == "table" then
            if v.Type == "Wear" then
                if v.Name == BeltName then
                    return true
                end
            end
        end
    end
    return false
end

function EventsModule.getMoonStatus()
    local moonId = Lighting.Sky.MoonTextureId
    if moonId == "http://www.roblox.com/asset/?id=9709149431" then
        return "100%"
    elseif moonId == "http://www.roblox.com/asset/?id=9709149052" then
        return "75%"
    elseif moonId == "http://www.roblox.com/asset/?id=9709143733" then
        return "50%"
    elseif moonId == "http://www.roblox.com/asset/?id=9709150401" then
        return "25%"
    elseif moonId == "http://www.roblox.com/asset/?id=9709149680" then
        return "15%"
    else
        return "0%"
    end
end

function EventsModule.checkIslandSpawn(islandName)
    return Workspace._WorldOrigin.Locations:FindFirstChild(islandName) ~= nil
end

function EventsModule.SeaBeastCheck()
    if Workspace.SeaBeasts:FindFirstChildOfClass("Model") then
        return true
    end
    return false
end

--// Race V4 Door Positions
EventsModule.RaceV4Doors = {
    Human = CFrame.new(29221.822265625, 14890.9755859375, -205.99114990234375),
    Skypiea = CFrame.new(28960.158203125, 14919.6240234375, 235.03948974609375),
    Fishman = CFrame.new(28231.17578125, 14890.9755859375, -211.64173889160156),
    Cyborg = CFrame.new(28502.681640625, 14895.9755859375, -423.7279357910156),
    Ghoul = CFrame.new(28674.244140625, 14890.6767578125, 445.4310607910156),
    Mink = CFrame.new(29012.341796875, 14890.9755859375, -380.1492614746094)
}

--// Elite Hunters
EventsModule.EliteHunters = {"Diablo", "Deandre", "Urban"}


EventsModule.DojoBeltData = {
    White = {
        quest = "BanditQuest1",
        questLv = 1,
        mob = "Bandit",
        mobDisplay = "Bandit",
        questCFrame = CFrame.new(1060.57251, 16.3419991, 1548.89673),
        mobCFrame = CFrame.new(1091.16675, 16.0878201, 1567.37036),
        info = "Complete 3 Quests for any NPC in First Sea"
    },
    Yellow = {
        quest = "ColosseumQuest",
        questLv = 1,
        mob = "Toga Warrior",
        mobDisplay = "Toga Warrior",
        questCFrame = CFrame.new(-1576.28809, 7.38515663, -2983.63989),
        mobCFrame = CFrame.new(-1479.48499, 8.87562275, -2920.37427),
        info = "Deal 2500 damage without taking damage"
    },
    Orange = {
        quest = "Area1Quest",
        questLv = 1,
        mob = "Raider",
        mobDisplay = "Raider",
        questCFrame = CFrame.new(-426.388489, 72.9998474, 1836.32324),
        mobCFrame = CFrame.new(-416.667297, 72.5987625, 1647.87659),
        info = "Kill 30 enemies using Dragon Breath"
    },
    Green = {
        quest = "HauntedQuest",
        questLv = 1,
        mob = "Reborn Skeleton",
        mobDisplay = "Reborn Skeleton",
        questCFrame = CFrame.new(-9516.47168, 143.132584, 5765.44189),
        mobCFrame = CFrame.new(-9500.8877, 141.198746, 5587.86914),
        info = "Defeat a Sea Beast"
    },
    Blue = {
        info = "Collect a fruit dropped by another player"
    },
    Purple = {
        info = "Kill 3 Elite Pirates"
    },
    Red = {
        info = "Defeat a Terrorshark or Rumbling Waters Sea Event"
    },
    Black = {
        info = "Complete Prehistoric Island event and collect 3 Dinosaur bones"
    }
}


function EventsModule.CheckSea()
    if SeaLevelSelected == 'Level 1' then
        SeaCFrame = CFrame.new(-11887.5742, -0.306667894, 16193.2705, -0.96911639, 1.13939585e-07, -0.246603817, 1.18964671e-07, 1, -5.47853096e-09, 0.246603817, -3.46464759e-08, -0.96911639)
    elseif SeaLevelSelected == 'Level 2' then
        SeaCFrame = CFrame.new(-11000.5625, -0.306667894, 21056.0312, -0.796931446, -6.01718924e-08, -0.604069769, -7.4490849e-08, 1, -1.33725619e-09, 0.604069769, 4.39319656e-08, -0.796931446)
    elseif SeaLevelSelected == 'Level 3' then
        SeaCFrame = CFrame.new(-9995.36719, -0.306667894, 24740.7656, -0.970631301, 1.55747459e-09, -0.240571901, 3.96488886e-09, 1, -9.52301882e-09, 0.240571901, -1.01971809e-08, -0.970631301)
    elseif SeaLevelSelected == 'Level 4' then
        SeaCFrame = CFrame.new(-8656.56934, -0.306667894, 29984.1152, -0.737478554, -7.80717357e-08, -0.675370574, -4.13984687e-08, 1, -7.03928436e-08, 0.675370574, -2.3953902e-08, -0.737478554)
    elseif SeaLevelSelected == 'Level 5' then
        SeaCFrame = CFrame.new(-8627.31934, -0.306667835, 34267.3516, -0.937176228, -4.47612693e-12, -0.34885627, -2.15563958e-08, 1, 5.78968127e-08, 0.34885627, 6.17796019e-08, -0.937176228)
    elseif SeaLevelSelected == 'Level 6' then
        SeaCFrame = CFrame.new(-2551.66382, -0.306667715, 75050.8047, -0.909505963, -3.70954254e-08, -0.415690839, 4.82135842e-09, 1, -9.97868526e-08, 0.415690839, -9.27609278e-08, -0.909505963)
    end
end

function EventsModule.RefreshBoat()
    if TeamSelected == "Pirates" then
        return {'Dinghy', 'PirateSloop', 'PirateBrigade', 'PirateGrandBrigade'}
    elseif TeamSelected == "Marines" then
        return {'Dinghy', 'MarineSloop', 'MarineBrigade', 'MarineGrandBrigade'}
    end
    return {'Dinghy'}
end


function EventsModule.TweenBoat(cf)
    local boat = Workspace.Boats:FindFirstChild(BoatSelected)
    if boat and boat:FindFirstChild("VehicleSeat") then
        local tween = TweenService:Create(boat.VehicleSeat, TweenInfo.new((boat.VehicleSeat.Position - cf.Position).Magnitude / SpeedBoatTween, Enum.EasingStyle.Linear), {CFrame = cf})
        tween:Play()
        return tween
    end
end

function EventsModule.StopBoatsTween(toggle)
    _G.StopTweenBoat = not toggle
end


function EventsModule.AutoGrabEmber()
    local player = LocalPlayer.Character
    for i,v in pairs(Workspace:GetChildren()) do 
        if v.Name == "EmberTemplate" then
            player.HumanoidRootPart.CFrame = v.PushBox.CFrame
            wait(.15)
        end
    end
    for i,v in pairs(Workspace:GetDescendants()) do
        if v:IsA("TouchTransmitter") then
            wait(.15)
            firetouchinterest(player.HumanoidRootPart, v.Parent, 0)
            wait(.15)
            firetouchinterest(player.HumanoidRootPart, v.Parent, 1)
        end
    end
end



function EventsModule.GetDojoProgress()
    local progress = ""
    if not EventsModule.getAcc("Dojo Belt (White)") then
        progress = "Get Dojo Belt (White)"
    elseif EventsModule.getAcc("Dojo Belt (White)") and not EventsModule.getAcc("Dojo Belt (Yellow)") then
        progress = "Get Dojo Belt (Yellow)"
    elseif EventsModule.getAcc("Dojo Belt (Yellow)") and not EventsModule.getAcc("Dojo Belt (Orange)") then
        progress = "Get Dojo Belt (Orange)"
    elseif EventsModule.getAcc("Dojo Belt (Orange)") and not EventsModule.getAcc("Dojo Belt (Green)") then
        progress = "Get Dojo Belt (Green)"
    elseif EventsModule.getAcc("Dojo Belt (Green)") and not EventsModule.getAcc("Dojo Belt (Blue)") then
        progress = "Get Dojo Belt (Blue)"
    elseif EventsModule.getAcc("Dojo Belt (Blue)") and not EventsModule.getAcc("Dojo Belt (Purple)") then
        progress = "Get Dojo Belt (Purple)"
    elseif EventsModule.getAcc("Dojo Belt (Purple)") and not EventsModule.getAcc("Dojo Belt (Red)") then
        progress = "Get Dojo Belt (Red)"
    elseif EventsModule.getAcc("Dojo Belt (Red)") and not EventsModule.getAcc("Dojo Belt (Black)") then
        progress = "Get Dojo Belt (Black)"
    else
        progress = "All Belts Obtained!"
    end
    return progress
end



function EventsModule.StartDojoClaimQuest()
    EventsModule.DojoClaimQuest = true
    spawn(function()
        while EventsModule.DojoClaimQuest do
            task.wait()
            pcall(function()
                EventsModule.Tween(EventsModule.DojoQuestNpc)
                if (EventsModule.DojoQuestNpc.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                    local ohTable1 = {
                        ["NPC"] = "Dojo Trainer",
                        ["Command"] = "ClaimQuest"
                    }
                    ReplicatedStorage.Modules.Net["RF/InteractDragonQuest"]:InvokeServer(ohTable1)
                    wait(1)
                    local ohTable2 = {
                        ["NPC"] = "Dojo Trainer",
                        ["Command"] = "RequestQuest"
                    }
                    ReplicatedStorage.Modules.Net["RF/InteractDragonQuest"]:InvokeServer(ohTable2)
                end
            end)
        end
    end)
end

function EventsModule.StopDojoClaimQuest()
    EventsModule.DojoClaimQuest = false
    EventsModule.CancelTween(false)
end

function EventsModule.StartWhiteBeltQuest(CheckLevel, Farm_Mode, SelectWeapon, ByPassTP)
    EventsModule.WhiteBeltF = true
    spawn(function()
        while EventsModule.WhiteBeltF do
            task.wait()
            pcall(function()
                CheckLevel()
                local quest = LocalPlayer.PlayerGui.Main.Quest
                local NameMon = _G.NameMon or "Bandit"
                local Ms = _G.Ms or "Bandit"
                local CFrameQ = _G.CFrameQ or CFrame.new(1060.57251, 16.3419991, 1548.89673)
                local CFrameMon = _G.CFrameMon or CFrame.new(1091.16675, 16.0878201, 1567.37036)
                local NameQuest = _G.NameQuest or "BanditQuest1"
                local QuestLv = _G.QuestLv or 1
                
                if not string.find(quest.Container.QuestTitle.Title.Text, NameMon) or quest.Visible == false then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                    if ByPassTP then
                        EventsModule.BTP(CFrameQ)
                    else
                        EventsModule.Tween(CFrameQ)
                    end
                    if (CFrameQ.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                        wait(1)
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                    end
                elseif string.find(quest.Container.QuestTitle.Title.Text, NameMon) or quest.Visible == true then
                    if Workspace.Enemies:FindFirstChild(Ms) then
                        for i,v in pairs(Workspace.Enemies:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                if v.Name == Ms then
                                    repeat RunService.Heartbeat:wait()
                                        EventsModule.EquipTool(SelectWeapon)
                                        EventsModule.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                        v.HumanoidRootPart.Transparency = 1
                                        _G.Dojo_Farm_Name = v.Name
                                        _G.Dojo_Farm_CFrame = v.HumanoidRootPart.CFrame
                                    until not EventsModule.WhiteBeltF or not v.Parent or v.Humanoid.Health <= 0 or not Workspace.Enemies:FindFirstChild(v.Name) or quest.Visible == false
                                end
                            end
                        end
                    else
                        EventsModule.Tween(CFrameMon)
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopWhiteBeltQuest()
    EventsModule.WhiteBeltF = false
    EventsModule.CancelTween(false)
end

function EventsModule.StartPurpleBeltQuest(Farm_Mode, SelectWeapon)
    EventsModule.PurpleBeltF = true
    spawn(function()
        while EventsModule.PurpleBeltF do
            task.wait()
            pcall(function()
                if Workspace.Enemies:FindFirstChild("Diablo") or Workspace.Enemies:FindFirstChild("Deandre") or Workspace.Enemies:FindFirstChild("Urban") then
                    for i,v in pairs(Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            if v.Name == "Diablo" or v.Name == "Deandre" or v.Name == "Urban" then
                                repeat RunService.Heartbeat:wait()
                                    EventsModule.EquipTool(SelectWeapon)
                                    EventsModule.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
                                    EventsModule.AutoClick()
                                until not EventsModule.PurpleBeltF or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    end
                else
                    if ReplicatedStorage:FindFirstChild("Diablo") then
                        EventsModule.Tween(ReplicatedStorage.Diablo.HumanoidRootPart.CFrame)
                    elseif ReplicatedStorage:FindFirstChild("Deandre") then
                        EventsModule.Tween(ReplicatedStorage.Deandre.HumanoidRootPart.CFrame)
                    elseif ReplicatedStorage:FindFirstChild("Urban") then
                        EventsModule.Tween(ReplicatedStorage.Urban.HumanoidRootPart.CFrame)
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopPurpleBeltQuest()
    EventsModule.PurpleBeltF = false
    EventsModule.CancelTween(false)
end



function EventsModule.StartDragonTalonUpgrade()
    EventsModule.DragonTalonUpgrade = true
    spawn(function()
        while EventsModule.DragonTalonUpgrade do
            task.wait()
            pcall(function()
                EventsModule.Tween(EventsModule.UzothNPC)
                if (EventsModule.UzothNPC.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                    local ohTable1 = {
                        ["NPC"] = "Uzoth",
                        ["Command"] = "Upgrade"
                    }
                    ReplicatedStorage.Modules.Net["RF/InteractDragonQuest"]:InvokeServer(ohTable1)
                end
            end)
        end
    end)
end

function EventsModule.StopDragonTalonUpgrade()
    EventsModule.DragonTalonUpgrade = false
end


function EventsModule.StartEmberFarm()
    EventsModule.BlazeEmberFarm = true
    spawn(function()
        while EventsModule.BlazeEmberFarm do
            task.wait()
            pcall(function()
                for i,v in pairs(Workspace:GetChildren()) do
                    if v.Name == 'EmberTemplate' then
                        v.Part.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopEmberFarm()
    EventsModule.BlazeEmberFarm = false
end

function EventsModule.StartTreeDestroyFarm()
    EventsModule.TreeDestroyFarm = true
    spawn(function()
        while EventsModule.TreeDestroyFarm do
            task.wait()
            pcall(function()
                for i,v in pairs(Workspace:GetChildren()) do
                    if v.Name == 'EmberTemplate' then
                        v.Part.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopTreeDestroyFarm()
    EventsModule.TreeDestroyFarm = false
end



function EventsModule.StartAutoSail()
    EventsModule.AutoSail = true
    spawn(function()
        while EventsModule.AutoSail do
            task.wait()
            pcall(function()
                EventsModule.CheckSea()
                local TikiPost = CFrame.new(-16192.5742, 11.0552588, 1741.49121, 0.927989781, 0, -0.372605681, -0, 1, 0, 0.372605681, 0, 0.927989781)
                
                if Workspace.Boats:FindFirstChild(BoatSelected) then
                    if Workspace.Boats:FindFirstChild(BoatSelected).Owner.Value.Name == tostring(LocalPlayer.Name) then
                        if LocalPlayer.Character:WaitForChild("Humanoid").Sit == false then
                            EventsModule.Tween(Workspace.Boats:FindFirstChild(BoatSelected).VehicleSeat.CFrame)
                            wait(0.5)
                            Workspace.Boats:FindFirstChild(BoatSelected).VehicleSeat:Sit(LocalPlayer.Character.Humanoid)
                        else
                            EventsModule.TweenBoat(SeaCFrame)
                        end
                    end
                else
                    EventsModule.Tween(TikiPost)
                    if (TikiPost.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                        wait(1)
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("SpawnBoat", BoatSelected)
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopAutoSail()
    EventsModule.AutoSail = false
    EventsModule.CancelTween(false)
    EventsModule.StopBoatsTween(false)
end

function EventsModule.StartSeaBeastFarm(Farm_Mode, SelectWeapon)
    EventsModule.AutoSeaBeast = true
    spawn(function()
        while EventsModule.AutoSeaBeast do
            task.wait()
            pcall(function()
                for i,v in pairs(Workspace.SeaBeasts:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        repeat RunService.Heartbeat:wait()
                            EventsModule.EquipTool(SelectWeapon)
                            local targetCFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, DisSeaFarm, 0)
                            EventsModule.Tween(targetCFrame)
                            EventsModule.AutoClick()
                        until not EventsModule.AutoSeaBeast or not v.Parent or v.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopSeaBeastFarm()
    EventsModule.AutoSeaBeast = false
    EventsModule.CancelTween(false)
end



function EventsModule.StartSeaUseSkill()
    EventsModule.SeaUseSkill = true
    spawn(function()
        while EventsModule.SeaUseSkill do
            task.wait()
            pcall(function()
                for i,v in pairs(Workspace.Enemies:GetChildren()) do
                    if v.Name == "PirateGrandBrigade" or v.Name == "PirateBrigade" then
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("Engine") then
                            repeat RunService.Heartbeat:wait()
                                if (v.VehicleSeat.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 500 then
                                    SeaMonPosition = v.Sails.Position
                                    if LocalPlayer.Character:FindFirstChild(SelectWeaponSeaFarm) then
                                        LocalPlayer.Character:FindFirstChild(SelectWeaponSeaFarm).MousePos.Value = SeaMonPosition
                                        if _G.SeaSkillZ then
                                            VirtualInputManager:SendKeyEvent(true, "Z", false, game)
                                            wait(0.1)
                                            VirtualInputManager:SendKeyEvent(false, "Z", false, game)
                                        end
                                        if _G.SeaSkillX then
                                            VirtualInputManager:SendKeyEvent(true, "X", false, game)
                                            wait(0.1)
                                            VirtualInputManager:SendKeyEvent(false, "X", false, game)
                                        end
                                        if _G.SeaSkillC then
                                            VirtualInputManager:SendKeyEvent(true, "C", false, game)
                                            wait(0.1)
                                            VirtualInputManager:SendKeyEvent(false, "C", false, game)
                                        end
                                        if _G.SeaSkillV then
                                            VirtualInputManager:SendKeyEvent(true, "V", false, game)
                                            wait(0.1)
                                            VirtualInputManager:SendKeyEvent(false, "V", false, game)
                                        end
                                        if _G.SeaSkillF then
                                            VirtualInputManager:SendKeyEvent(true, "F", false, game)
                                            wait(0.1)
                                            VirtualInputManager:SendKeyEvent(false, "F", false, game)
                                        end
                                    end
                                end
                            until not EventsModule.SeaUseSkill or not v.Parent
                        end
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopSeaUseSkill()
    EventsModule.SeaUseSkill = false
end

function EventsModule.StartAutoTouchW()
    AutoTouchW = true
    spawn(function()
        while AutoTouchW do
            task.wait()
            VirtualInputManager:SendKeyEvent(true, "W", false, game)
            wait(0.1)
            VirtualInputManager:SendKeyEvent(false, "W", false, game)
        end
    end)
end

function EventsModule.StopAutoTouchW()
    AutoTouchW = false
end



function EventsModule.CheckMirageIsland()
    return Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") ~= nil
end

function EventsModule.StartAutoMirageIsland()
    EventsModule.AutoMirageIsland = true
    spawn(function()
        while EventsModule.AutoMirageIsland do
            task.wait()
            pcall(function()
                if EventsModule.CheckMirageIsland() then
                    local miragePos = Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island").Position
                    EventsModule.Tween(CFrame.new(miragePos))
                end
            end)
        end
    end)
end

function EventsModule.StopAutoMirageIsland()
    EventsModule.AutoMirageIsland = false
    EventsModule.CancelTween(false)
end



function EventsModule.CheckKitsuneIsland()
    return Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") ~= nil
end

function EventsModule.StartAutoKitsuneIsland()
    EventsModule.AutoKitsuneIsland = true
    spawn(function()
        while EventsModule.AutoKitsuneIsland do
            task.wait()
            pcall(function()
                if EventsModule.CheckKitsuneIsland() then
                    local kitsunePos = Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").Position
                    EventsModule.Tween(CFrame.new(kitsunePos))
                    for i,v in pairs(Workspace:GetChildren()) do
                        if v.Name == "AzureEmber" or string.find(v.Name, "Ember") then
                            if v:FindFirstChild("ProximityPrompt") then
                                fireproximityprompt(v.ProximityPrompt)
                            end
                        end
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopAutoKitsuneIsland()
    EventsModule.AutoKitsuneIsland = false
    EventsModule.CancelTween(false)
end



function EventsModule.CheckPrehistoricIsland()
    return Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") ~= nil
end



function EventsModule.GetPlayerRace()
    local race = LocalPlayer:FindFirstChild("Race")
    if race then
        return race.Value
    end
    return "Human"
end

function EventsModule.StartAutoRaceV4()
    EventsModule.AutoRaceV4 = true
    spawn(function()
        while EventsModule.AutoRaceV4 do
            task.wait()
            pcall(function()
                local playerRace = EventsModule.GetPlayerRace()
                local raceData = EventsModule.RaceV4Doors[playerRace]
                if raceData then
                    EventsModule.Tween(raceData)
                end
            end)
        end
    end)
end

function EventsModule.StopAutoRaceV4()
    EventsModule.AutoRaceV4 = false
    EventsModule.RaceV4Step = 1
    EventsModule.CancelTween(false)
end

function EventsModule.StartAutoTrial()
    EventsModule.AutoTrial = true
    spawn(function()
        while EventsModule.AutoTrial do
            task.wait()
            pcall(function()
                for i,v in pairs(Workspace:GetChildren()) do
                    if v:FindFirstChild("TrialOrb") or string.find(v.Name, "Trial") then
                        if v:FindFirstChild("ProximityPrompt") then
                            fireproximityprompt(v.ProximityPrompt)
                        end
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopAutoTrial()
    EventsModule.AutoTrial = false
end


function EventsModule.GetEliteProgress()
    local progress = ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter", "Progress")
    return progress or 0
end

function EventsModule.CheckEliteBossSpawned()
    return ReplicatedStorage:FindFirstChild("Diablo") ~= nil or 
           ReplicatedStorage:FindFirstChild("Deandre") ~= nil or 
           ReplicatedStorage:FindFirstChild("Urban") ~= nil
end

function EventsModule.StartAutoEliteHunter(Farm_Mode, SelectWeapon, ByPassTP)
    EventsModule.AutoEliteHunter = true
    spawn(function()
        while EventsModule.AutoEliteHunter do
            task.wait()
            pcall(function()
                local quest = LocalPlayer.PlayerGui.Main.Quest
                if quest.Visible == true then
                    if string.find(quest.Container.QuestTitle.Title.Text, "Diablo") or 
                       string.find(quest.Container.QuestTitle.Title.Text, "Deandre") or 
                       string.find(quest.Container.QuestTitle.Title.Text, "Urban") then
                        if Workspace.Enemies:FindFirstChild("Diablo") or 
                           Workspace.Enemies:FindFirstChild("Deandre") or 
                           Workspace.Enemies:FindFirstChild("Urban") then
                            for i,v in pairs(Workspace.Enemies:GetChildren()) do
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    if v.Name == "Diablo" or v.Name == "Deandre" or v.Name == "Urban" then
                                        repeat RunService.Heartbeat:wait()
                                            EventsModule.EquipTool(SelectWeapon)
                                            EventsModule.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                            v.HumanoidRootPart.Transparency = 1
                                            v.Humanoid:ChangeState(11)
                                            v.Humanoid:ChangeState(14)
                                            EventsModule.AutoClick()
                                        until not EventsModule.AutoEliteHunter or v.Humanoid.Health <= 0 or not v.Parent
                                    end
                                end
                            end
                        else
                            if ReplicatedStorage:FindFirstChild("Diablo") then
                                if ByPassTP then
                                    EventsModule.BTP(ReplicatedStorage.Diablo.HumanoidRootPart.CFrame)
                                else
                                    EventsModule.Tween(ReplicatedStorage.Diablo.HumanoidRootPart.CFrame)
                                end
                            elseif ReplicatedStorage:FindFirstChild("Deandre") then
                                if ByPassTP then
                                    EventsModule.BTP(ReplicatedStorage.Deandre.HumanoidRootPart.CFrame)
                                else
                                    EventsModule.Tween(ReplicatedStorage.Deandre.HumanoidRootPart.CFrame)
                                end
                            elseif ReplicatedStorage:FindFirstChild("Urban") then
                                if ByPassTP then
                                    EventsModule.BTP(ReplicatedStorage.Urban.HumanoidRootPart.CFrame)
                                else
                                    EventsModule.Tween(ReplicatedStorage.Urban.HumanoidRootPart.CFrame)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopAutoEliteHunter()
    EventsModule.AutoEliteHunter = false
    EventsModule.CancelTween(false)
end



function EventsModule.StartAutoPirateCastle(Farm_Mode, SelectWeapon)
    EventsModule.AutoPirateCastle = true
    spawn(function()
        while EventsModule.AutoPirateCastle do
            task.wait()
            pcall(function()
                local CFrameCastleRaid = CFrame.new(-5496.17432, 313.768921, -2841.53027, 0.924894512, 7.37058015e-09, 0.380223751, 3.5881019e-08, 1, -1.06665446e-07, -0.380223751, 1.12297109e-07, 0.924894512)
                if (CFrame.new(-5539.3115234375, 313.800537109375, -2972.372314453125).Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
                    for i,v in pairs(Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            if (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
                                repeat RunService.Heartbeat:wait()
                                    EventsModule.EquipTool(SelectWeapon)
                                    EventsModule.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
                                    _G.PirateCastle_Name = v.Name
                                    _G.PirateCastle_CFrame = v.HumanoidRootPart.CFrame
                                    EventsModule.AutoClick()
                                until not EventsModule.AutoPirateCastle or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    end
                else
                    EventsModule.Tween(CFrameCastleRaid)
                end
            end)
        end
    end)
end

function EventsModule.StopAutoPirateCastle()
    EventsModule.AutoPirateCastle = false
    EventsModule.CancelTween(false)
end



EventsModule.FightingStyleNPCs = {
    Superhuman = CFrame.new(-1576.28809, 7.38515663, -2983.63989),
    DeathStep = CFrame.new(-2440.50757, 73.0515518, -3216.2605),
    SharkmanKarate = CFrame.new(-2604.6958, 239.432526, -10315.1982),
    ElectricClaw = CFrame.new(-10371.4717, 330.764496, -10131.4199),
    DragonTalon = CFrame.new(5661.89014, 1211.31909, 864.836731),
    Godhuman = CFrame.new(-5350.24316, 313.398804, -2612.07422)
}

function EventsModule.StartAutoSuperhuman()
    EventsModule.AutoSuperhuman = true
    spawn(function()
        while EventsModule.AutoSuperhuman do
            task.wait()
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySuperhuman")
            end)
        end
    end)
end

function EventsModule.StopAutoSuperhuman()
    EventsModule.AutoSuperhuman = false
end

function EventsModule.StartAutoDeathStep()
    EventsModule.AutoDeathStep = true
    spawn(function()
        while EventsModule.AutoDeathStep do
            task.wait()
            pcall(function()
                if LocalPlayer.Backpack:FindFirstChild("Dark Step") or LocalPlayer.Character:FindFirstChild("Dark Step") then
                    local darkStep = LocalPlayer.Backpack:FindFirstChild("Dark Step") or LocalPlayer.Character:FindFirstChild("Dark Step")
                    if darkStep and darkStep.Level.Value >= 400 then
                        EventsModule.Tween(EventsModule.FightingStyleNPCs.DeathStep)
                        if (EventsModule.FightingStyleNPCs.DeathStep.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                            wait(1)
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDeathStep")
                        end
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopAutoDeathStep()
    EventsModule.AutoDeathStep = false
end

function EventsModule.StartAutoSharkman(Farm_Mode, SelectWeapon, ByPassTP)
    EventsModule.AutoSharkman = true
    spawn(function()
        while EventsModule.AutoSharkman do
            task.wait()
            pcall(function()
                if LocalPlayer.Backpack:FindFirstChild("Fishman Karate") or LocalPlayer.Character:FindFirstChild("Fishman Karate") then
                    local fishman = LocalPlayer.Backpack:FindFirstChild("Fishman Karate") or LocalPlayer.Character:FindFirstChild("Fishman Karate")
                    if fishman and fishman.Level.Value >= 400 then
                        if LocalPlayer.Character:FindFirstChild("Library Key") or LocalPlayer.Backpack:FindFirstChild("Library Key") then
                            EventsModule.Tween(EventsModule.FightingStyleNPCs.SharkmanKarate)
                            if (EventsModule.FightingStyleNPCs.SharkmanKarate.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                                wait(1.2)
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
                                wait(0.5)
                            end
                        else
                            if Workspace.Enemies:FindFirstChild("Tide Keeper") then
                                for i,v in pairs(Workspace.Enemies:GetChildren()) do
                                    if v.Name == "Tide Keeper" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                        repeat RunService.Heartbeat:wait()
                                            EventsModule.EquipTool(SelectWeapon)
                                            EventsModule.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                            v.HumanoidRootPart.Transparency = 1
                                            v.Humanoid:ChangeState(11)
                                            v.Humanoid:ChangeState(14)
                                            EventsModule.AutoClick()
                                        until not EventsModule.AutoSharkman or not v.Parent or v.Humanoid.Health <= 0 or LocalPlayer.Character:FindFirstChild("Library Key") or LocalPlayer.Backpack:FindFirstChild("Library Key")
                                    end
                                end
                            else
                                if ReplicatedStorage:FindFirstChild("Tide Keeper") then
                                    if ByPassTP then
                                        EventsModule.BTP(ReplicatedStorage["Tide Keeper"].HumanoidRootPart.CFrame)
                                    else
                                        EventsModule.Tween(ReplicatedStorage["Tide Keeper"].HumanoidRootPart.CFrame)
                                    end
                                end
                            end
                        end
                    end
                else
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
                end
            end)
        end
    end)
end

function EventsModule.StopAutoSharkman()
    EventsModule.AutoSharkman = false
    EventsModule.CancelTween(false)
end

function EventsModule.StartAutoElectricClaw()
    EventsModule.AutoElectricClaw = true
    spawn(function()
        while EventsModule.AutoElectricClaw do
            task.wait(0.1)
            pcall(function()
                if LocalPlayer.Backpack:FindFirstChild("Electro") or LocalPlayer.Character:FindFirstChild("Electro") then
                    local electro = LocalPlayer.Backpack:FindFirstChild("Electro") or LocalPlayer.Character:FindFirstChild("Electro")
                    if electro and electro.Level.Value >= 400 then
                        EventsModule.Tween(EventsModule.FightingStyleNPCs.ElectricClaw)
                        if (EventsModule.FightingStyleNPCs.ElectricClaw.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                            wait(1)
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw")
                        end
                    end
                else
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectro")
                end
            end)
        end
    end)
end

function EventsModule.StopAutoElectricClaw()
    EventsModule.AutoElectricClaw = false
    EventsModule.CancelTween(false)
end


EventsModule.RaidList = {
    "Flame", "Ice", "Quake", "Dark", "Light", "String", "Magma", "Rumble",
    "Buddha", "Sand", "Phoenix", "Dough", "Spider", "Sound", "Venom",
    "Control", "Spirit", "Dragon", "Leopard", "Blizzard", "Gravity",
    "Mammoth", "Shadow", "Portal", "Kitsune", "T-Rex", "Yeti"
}

EventsModule.RaidChips = {
    Flame = "Flame Chip", Ice = "Ice Chip", Quake = "Quake Chip",
    Dark = "Dark Chip", Light = "Light Chip", String = "String Chip",
    Magma = "Magma Chip", Rumble = "Rumble Chip", Buddha = "Buddha Chip",
    Sand = "Sand Chip", Phoenix = "Phoenix Chip", Dough = "Dough Chip",
    Spider = "Spider Chip", Sound = "Sound Chip", Venom = "Venom Chip",
    Control = "Control Chip", Spirit = "Spirit Chip", Dragon = "Dragon Chip",
    Leopard = "Leopard Chip"
}

function EventsModule.StartAutoStartRaid()
    EventsModule.AutoStartRaid = true
    spawn(function()
        while EventsModule.AutoStartRaid do
            task.wait()
            pcall(function()
                local raidNpc = CFrame.new(-5350.24316, 313.398804, -2612.07422)
                EventsModule.Tween(raidNpc)
                if (raidNpc.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                    wait(1)
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("Raids", "StartRaid", RaidSelected)
                end
            end)
        end
    end)
end

function EventsModule.StopAutoStartRaid()
    EventsModule.AutoStartRaid = false
    EventsModule.CancelTween(false)
end

function EventsModule.StartAutoFarmRaid(Farm_Mode, SelectWeapon)
    EventsModule.AutoFarmRaid = true
    spawn(function()
        while EventsModule.AutoFarmRaid do
            task.wait()
            pcall(function()
                for i,v in pairs(Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        repeat RunService.Heartbeat:wait()
                            EventsModule.EquipTool(SelectWeapon)
                            EventsModule.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.Transparency = 1
                            v.Humanoid:ChangeState(11)
                            v.Humanoid:ChangeState(14)
                            EventsModule.AutoClick()
                        until not EventsModule.AutoFarmRaid or not v.Parent or v.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopAutoFarmRaid()
    EventsModule.AutoFarmRaid = false
    EventsModule.CancelTween(false)
end

--////////////////////////////////////////////////////////////////////////////////////////////////////
--// SWORD QUESTS (Auto Pole, Cavander, etc.)
--////////////////////////////////////////////////////////////////////////////////////////////////////

function EventsModule.StartAutoPole(Farm_Mode, SelectWeapon, ByPassTP)
    EventsModule.AutoPole = true
    spawn(function()
        while EventsModule.AutoPole do
            task.wait()
            pcall(function()
                if Workspace.Enemies:FindFirstChild("Thunder God") then
                    for i,v in pairs(Workspace.Enemies:GetChildren()) do
                        if v.Name == "Thunder God" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat RunService.Heartbeat:wait()
                                EventsModule.EquipTool(SelectWeapon)
                                EventsModule.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
                                EventsModule.AutoClick()
                            until not EventsModule.AutoPole or not v.Parent or v.Humanoid.Health <= 0
                        end
                    end
                else
                    if ReplicatedStorage:FindFirstChild("Thunder God") then
                        if ByPassTP then
                            EventsModule.BTP(ReplicatedStorage["Thunder God"].HumanoidRootPart.CFrame)
                        else
                            EventsModule.Tween(ReplicatedStorage["Thunder God"].HumanoidRootPart.CFrame)
                        end
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopAutoPole()
    EventsModule.AutoPole = false
    EventsModule.CancelTween(false)
end

function EventsModule.StartAutoCavander(Farm_Mode, SelectWeapon, ByPassTP)
    EventsModule.AutoCavander = true
    spawn(function()
        while EventsModule.AutoCavander do
            task.wait()
            pcall(function()
                if Workspace.Enemies:FindFirstChild("Beautiful Pirate") then
                    for i,v in pairs(Workspace.Enemies:GetChildren()) do
                        if v.Name == "Beautiful Pirate" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat RunService.Heartbeat:wait()
                                EventsModule.EquipTool(SelectWeapon)
                                EventsModule.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid:ChangeState(11)
                                v.Humanoid:ChangeState(14)
                                EventsModule.AutoClick()
                            until not EventsModule.AutoCavander or not v.Parent or v.Humanoid.Health <= 0
                        end
                    end
                else
                    if ReplicatedStorage:FindFirstChild("Beautiful Pirate") then
                        if ByPassTP then
                            EventsModule.BTP(ReplicatedStorage["Beautiful Pirate"].HumanoidRootPart.CFrame)
                        else
                            EventsModule.Tween(ReplicatedStorage["Beautiful Pirate"].HumanoidRootPart.CFrame)
                        end
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopAutoCavander()
    EventsModule.AutoCavander = false
    EventsModule.CancelTween(false)
end



function EventsModule.StartAutoDonSwan(Farm_Mode, SelectWeapon, ByPassTP)
    _G.SwanGlasses = true
    spawn(function()
        while _G.SwanGlasses do
            task.wait()
            pcall(function()
                if Workspace.Enemies:FindFirstChild("Don Swan") then
                    for i,v in pairs(Workspace.Enemies:GetChildren()) do
                        if v.Name == "Don Swan" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat RunService.Heartbeat:wait()
                                EventsModule.EquipTool(SelectWeapon)
                                EventsModule.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                EventsModule.AutoClick()
                            until not _G.SwanGlasses or v.Humanoid.Health <= 0 or not v.Parent
                        end
                    end
                else
                    if ByPassTP then
                        EventsModule.BTP(CFrame.new(2191.1674804688, 15.177842140198, 694.69873046875))
                    else
                        EventsModule.Tween(CFrame.new(2191.1674804688, 15.177842140198, 694.69873046875))
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopAutoDonSwan()
    _G.SwanGlasses = false
    EventsModule.CancelTween(false)
end

function EventsModule.StartAutoRipIndra(Farm_Mode, SelectWeapon)
    EventsModule.RipIndra = true
    spawn(function()
        while EventsModule.RipIndra do
            task.wait()
            pcall(function()
                if Workspace.Enemies:FindFirstChild("rip_indra True Form") then
                    for i,v in pairs(Workspace.Enemies:GetChildren()) do
                        if v.Name == "rip_indra True Form" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat RunService.Heartbeat:wait()
                                EventsModule.EquipTool(SelectWeapon)
                                EventsModule.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                EventsModule.AutoClick()
                            until v.Humanoid.Health <= 0 or not EventsModule.RipIndra or not v.Parent
                        end
                    end
                else
                    local loc11 = CFrame.new(-5524.53271, 313.800537, -2918.07422, 0.964194059, 0, 0.265197694, 0, 1, 0, -0.265197694, 0, 0.964194059)
                    EventsModule.Tween(loc11)
                end
            end)
        end
    end)
end

function EventsModule.StopAutoRipIndra()
    EventsModule.RipIndra = false
    EventsModule.CancelTween(false)
end



function EventsModule.StartAutoRainbowHaki(ByPassTP)
    EventsModule.AutoRainbowHaki = true
    spawn(function()
        while EventsModule.AutoRainbowHaki do
            task.wait()
            pcall(function()
                if LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    local loc12 = CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875)
                    if ByPassTP then
                        EventsModule.BTP(loc12)
                    else
                        EventsModule.Tween(loc12)
                    end
                    if (loc12.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                        wait(1.5)
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("HornedMan", "Bet")
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopAutoRainbowHaki()
    EventsModule.AutoRainbowHaki = false
    EventsModule.CancelTween(false)
end

function EventsModule.StartAutoColorHaki()
    EventsModule.AutoColorHaki = true
    spawn(function()
        while EventsModule.AutoColorHaki do
            task.wait()
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("ColorsDealer", "2")
            end)
        end
    end)
end

function EventsModule.StopAutoColorHaki()
    EventsModule.AutoColorHaki = false
end


function EventsModule.StartAutoMusketeer(Farm_Mode, SelectWeapon)
    EventsModule.AutoMusketeer = true
    spawn(function()
        while EventsModule.AutoMusketeer do
            task.wait()
            pcall(function()
                if LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    repeat
                        EventsModule.Tween(CFrame.new(-12444.78515625, 332.40396118164, -7673.1806640625))
                        wait(2)
                    until not EventsModule.AutoMusketeer or (LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-12444.78515625, 332.40396118164, -7673.1806640625)).Magnitude <= 10
                    wait(0.5)
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
                    wait(1)
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1)
                elseif string.find(LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Defeat 50 Forest Pirates") then
                    if Workspace.Enemies:FindFirstChild("Forest Pirate") then
                        for i,v in pairs(Workspace.Enemies:GetChildren()) do
                            if v.Name == "Forest Pirate" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                repeat RunService.Heartbeat:wait()
                                    EventsModule.EquipTool(SelectWeapon)
                                    EventsModule.Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.Transparency = 1
                                    EventsModule.AutoClick()
                                until not EventsModule.AutoMusketeer or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    else
                        EventsModule.Tween(CFrame.new(-13475.3389, 333.798767, -7749.09863))
                    end
                end
            end)
        end
    end)
end

function EventsModule.StopAutoMusketeer()
    EventsModule.AutoMusketeer = false
    EventsModule.CancelTween(false)
end


function EventsModule.DoBartiloPlates()
    pcall(function()
        local plates = {
            Workspace.Map.Dressrosa.BartiloPlates.Plate1.CFrame,
            Workspace.Map.Dressrosa.BartiloPlates.Plate2.CFrame,
            Workspace.Map.Dressrosa.BartiloPlates.Plate3.CFrame,
            Workspace.Map.Dressrosa.BartiloPlates.Plate4.CFrame,
            Workspace.Map.Dressrosa.BartiloPlates.Plate5.CFrame,
            Workspace.Map.Dressrosa.BartiloPlates.Plate6.CFrame,
            Workspace.Map.Dressrosa.BartiloPlates.Plate7.CFrame,
            Workspace.Map.Dressrosa.BartiloPlates.Plate8.CFrame
        }
        for i, plate in ipairs(plates) do
            LocalPlayer.Character.HumanoidRootPart.CFrame = plate
            wait(1)
        end
    end)
end



function EventsModule.StartAutoSickScientist()
    EventsModule.AutoSickScientist = true
    spawn(function()
        while EventsModule.AutoSickScientist do
            task.wait()
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("SickScientist", "Heal")
            end)
        end
    end)
end

function EventsModule.StopAutoSickScientist()
    EventsModule.AutoSickScientist = false
end



EventsModule.SeaLevelList = {
    'Level 1', 'Level 2', 'Level 3', 'Level 4', 'Level 5', 'Level 6'
}



function EventsModule.Init()
   
end

return EventsModule
