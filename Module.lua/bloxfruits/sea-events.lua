--[[
    Sea Events Module - Sea Events, Boats, Sharks, Sea Beasts
    Blox Fruits Script by Zlex Hub (Modularized)
]]

local SeaEvents = {}

local Utils = nil

function SeaEvents.Init(utils)
    Utils = utils
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

SeaEvents.BoatList = {"Guardian", "Beast Hunter", "PirateGrandBrigade", "MarineGrandBrigade", "PirateBrigade", "MarineBrigade", "PirateSloop", "MarineSloop"}
SeaEvents.ZoneList = {"Zone 1", "Zone 2", "Zone 3", "Zone 4", "Zone 5", "Zone 6", "Infinite"}

SeaEvents.ZoneCFrames = {
    ["Zone 1"] = CFrame.new(-21998.375, 30, -682.309),
    ["Zone 2"] = CFrame.new(-26779.5, 30, -822.858),
    ["Zone 3"] = CFrame.new(-31171.957, 30, -2256.938),
    ["Zone 4"] = CFrame.new(-34054.688, 30.2, -2560.12),
    ["Zone 5"] = CFrame.new(-38887.555, 30, -2162.99),
    ["Zone 6"] = CFrame.new(-44541.762, 30, -1244.858),
    ["Infinite"] = CFrame.new(-148073.359, 9, 7721.051)
}

SeaEvents.BuyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
SeaEvents.Skillaimbot = false
SeaEvents.AimBotSkillPosition = Vector3.new(0, 0, 0)
SeaEvents._G_SeaSkill = false

function SeaEvents.AddEsp(name, parent)
    local BillboardGui = Instance.new("BillboardGui")
    local TextLabel = Instance.new("TextLabel")
    
    BillboardGui.Parent = parent
    BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    BillboardGui.Active = true
    BillboardGui.Name = name
    BillboardGui.AlwaysOnTop = true
    BillboardGui.LightInfluence = 1
    BillboardGui.Size = UDim2.new(0, 200, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
    
    TextLabel.Parent = BillboardGui
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 15
    TextLabel.Text = ""
end

function SeaEvents.CheckBoat()
    local boats = Workspace:FindFirstChild("Boats")
    if not boats then return nil end
    
    for _, boat in pairs(boats:GetChildren()) do
        if boat.Name == _G.Settings.SeaEvent["Selected Boat"] then
            for _, child in pairs(boat:GetChildren()) do
                if child.Name == "MyBoatEsp" then
                    return boat
                end
            end
        end
    end
    return nil
end

function SeaEvents.CheckEnemiesBoat()
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then return false end
    
    return enemies:FindFirstChild("FishBoat") or 
           enemies:FindFirstChild("PirateBrigade") or 
           enemies:FindFirstChild("PirateGrandBrigade")
end

function SeaEvents.CheckShark()
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then return false end
    
    local hrp = Utils.GetHumanoidRootPart()
    if not hrp then return false end
    
    for _, enemy in pairs(enemies:GetChildren()) do
        if enemy.Name == "Shark" then
            local humanoid = enemy:FindFirstChild("Humanoid")
            local enemyHRP = enemy:FindFirstChild("HumanoidRootPart")
            if humanoid and enemyHRP and humanoid.Health > 0 then
                if (enemyHRP.Position - hrp.Position).Magnitude <= 200 then
                    return true
                end
            end
        end
    end
    return false
end

function SeaEvents.CheckPiranha()
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then return false end
    
    local hrp = Utils.GetHumanoidRootPart()
    if not hrp then return false end
    
    for _, enemy in pairs(enemies:GetChildren()) do
        if enemy.Name == "Piranha" then
            local humanoid = enemy:FindFirstChild("Humanoid")
            local enemyHRP = enemy:FindFirstChild("HumanoidRootPart")
            if humanoid and enemyHRP and humanoid.Health > 0 then
                if (enemyHRP.Position - hrp.Position).Magnitude <= 200 then
                    return true
                end
            end
        end
    end
    return false
end

function SeaEvents.CheckSeaBeast()
    local seaBeasts = Workspace:FindFirstChild("SeaBeasts")
    if not seaBeasts then return false end
    
    for _, beast in pairs(seaBeasts:GetChildren()) do
        local humanoid = beast:FindFirstChild("Humanoid")
        local hrp = beast:FindFirstChild("HumanoidRootPart")
        if humanoid and hrp and humanoid.Health > 0 then
            return true
        end
    end
    return false
end

function SeaEvents.DodgeSeabeasts()
    local seaBeasts = Workspace:FindFirstChild("SeaBeasts")
    if not seaBeasts then return false end
    
    for _, beast in pairs(seaBeasts:GetChildren()) do
        if beast:FindFirstChild("Attacking") and beast.Attacking.Value then
            return true
        end
    end
    return false
end

function SeaEvents.BuyBoat()
    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and 
                  ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    if CommF then
        pcall(function()
            CommF:InvokeServer("BuyBoat", _G.Settings.SeaEvent["Selected Boat"])
        end)
    end
end

function SeaEvents.ExitBoat()
    VirtualInputManager:SendKeyEvent(true, 32, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, 32, false, game)
end

function SeaEvents.GetZoneCFrame()
    local zone = _G.Settings.SeaEvent["Selected Zone"]
    return SeaEvents.ZoneCFrames[zone] or SeaEvents.ZoneCFrames["Zone 1"]
end

function SeaEvents.ShouldExitBoat()
    return (SeaEvents.CheckShark() and _G.Settings.SeaEvent["Auto Farm Shark"]) or
           (Workspace.Enemies:FindFirstChild("Terrorshark") and _G.Settings.SeaEvent["Auto Farm Terrorshark"]) or
           (SeaEvents.CheckPiranha() and _G.Settings.SeaEvent["Auto Farm Piranha"]) or
           (Workspace.Enemies:FindFirstChild("Fish Crew Member") and _G.Settings.SeaEvent["Auto Farm Fish Crew Member"]) or
           (Workspace.Enemies:FindFirstChild("FishBoat") and _G.Settings.SeaEvent["Auto Farm Ghost Ship"]) or
           (Workspace.Enemies:FindFirstChild("PirateBrigade") and _G.Settings.SeaEvent["Auto Farm Pirate Brigade"]) or
           (Workspace.Enemies:FindFirstChild("PirateGrandBrigade") and _G.Settings.SeaEvent["Auto Farm Pirate Grand Brigade"]) or
           (SeaEvents.CheckSeaBeast() and _G.Settings.SeaEvent["Auto Farm Seabeasts"])
end

function SeaEvents.FarmSeaEnemy(enemyName)
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then return end
    
    for _, enemy in pairs(enemies:GetChildren()) do
        if enemy.Name == enemyName then
            local humanoid = enemy:FindFirstChild("Humanoid")
            local hrp = enemy:FindFirstChild("HumanoidRootPart")
            
            if humanoid and hrp and humanoid.Health > 0 then
                Utils.AutoHaki()
                Utils.EquipWeapon(_G.Settings.Main["Selected Weapon"])
                Utils.TweenPlayer(hrp.CFrame * CFrame.new(0, 15, 0))
                Utils.Attack()
                return true
            end
        end
    end
    return false
end

function SeaEvents.FarmBoatEnemy(boatName)
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then return end
    
    local boat = enemies:FindFirstChild(boatName)
    if boat and boat:FindFirstChild("Engine") then
        local engineCFrame = boat.Engine.CFrame
        
        SeaEvents._G_SeaSkill = true
        SeaEvents.Skillaimbot = true
        SeaEvents.AimBotSkillPosition = engineCFrame.Position
        
        Utils.AutoHaki()
        Utils.TweenPlayer(engineCFrame)
    end
end

function SeaEvents.FarmSeaBeast()
    local seaBeasts = Workspace:FindFirstChild("SeaBeasts")
    if not seaBeasts then return end
    
    for _, beast in pairs(seaBeasts:GetChildren()) do
        local humanoid = beast:FindFirstChild("Humanoid")
        local hrp = beast:FindFirstChild("HumanoidRootPart")
        
        if humanoid and hrp and humanoid.Health > 0 then
            local targetCFrame = hrp.CFrame * CFrame.new(0, 400, 0)
            
            SeaEvents._G_SeaSkill = true
            SeaEvents.Skillaimbot = true
            SeaEvents.AimBotSkillPosition = hrp.Position
            
            Utils.AutoHaki()
            
            if SeaEvents.DodgeSeabeasts() then
                Utils.TweenPlayer(hrp.CFrame * CFrame.new(math.random(-200, 300), 400, math.random(-200, 300)))
            else
                Utils.TweenPlayer(targetCFrame)
            end
            
            return
        end
    end
end

function SeaEvents.MainLoop()
    if not _G.Settings.SeaEvent["Sail Boat"] then return end
    if not Utils.IsAlive() then return end
    
    local boat = SeaEvents.CheckBoat()
    
    if not boat then
        local dist = Utils.DistanceTo(SeaEvents.BuyBoatCFrame.Position)
        if dist > 2000 then
            Utils.BTP(SeaEvents.BuyBoatCFrame)
        elseif dist > 10 then
            Utils.TweenPlayer(SeaEvents.BuyBoatCFrame)
        else
            SeaEvents.BuyBoat()
            
            local boats = Workspace:FindFirstChild("Boats")
            if boats then
                for _, b in pairs(boats:GetChildren()) do
                    if b.Name == _G.Settings.SeaEvent["Selected Boat"] then
                        local seat = b:FindFirstChild("VehicleSeat")
                        if seat and Utils.DistanceTo(seat.Position) <= 100 then
                            SeaEvents.AddEsp("MyBoatEsp", b)
                        end
                    end
                end
            end
        end
    else
        local humanoid = Utils.GetHumanoid()
        if not humanoid then return end
        
        if humanoid.Sit == false then
            if SeaEvents.ShouldExitBoat() then
                if _G.Settings.SeaEvent["Auto Farm Shark"] and SeaEvents.CheckShark() then
                    SeaEvents.FarmSeaEnemy("Shark")
                elseif _G.Settings.SeaEvent["Auto Farm Piranha"] and SeaEvents.CheckPiranha() then
                    SeaEvents.FarmSeaEnemy("Piranha")
                elseif _G.Settings.SeaEvent["Auto Farm Fish Crew Member"] and Workspace.Enemies:FindFirstChild("Fish Crew Member") then
                    SeaEvents.FarmSeaEnemy("Fish Crew Member")
                elseif _G.Settings.SeaEvent["Auto Farm Ghost Ship"] and Workspace.Enemies:FindFirstChild("FishBoat") then
                    SeaEvents.FarmBoatEnemy("FishBoat")
                elseif _G.Settings.SeaEvent["Auto Farm Pirate Brigade"] and Workspace.Enemies:FindFirstChild("PirateBrigade") then
                    SeaEvents.FarmBoatEnemy("PirateBrigade")
                elseif _G.Settings.SeaEvent["Auto Farm Pirate Grand Brigade"] and Workspace.Enemies:FindFirstChild("PirateGrandBrigade") then
                    SeaEvents.FarmBoatEnemy("PirateGrandBrigade")
                elseif _G.Settings.SeaEvent["Auto Farm Seabeasts"] and SeaEvents.CheckSeaBeast() then
                    SeaEvents.FarmSeaBeast()
                end
            else
                local vehicleSeat = boat:FindFirstChild("VehicleSeat")
                if vehicleSeat then
                    Utils.TweenPlayer(vehicleSeat.CFrame * CFrame.new(0, 1, 0))
                end
            end
        else
            if SeaEvents.ShouldExitBoat() then
                SeaEvents.ExitBoat()
            else
                Utils.TweenBoat(SeaEvents.GetZoneCFrame())
            end
        end
    end
end

function SeaEvents.UseSeaSkills()
    if not SeaEvents._G_SeaSkill then return end
    
    if _G.Settings.SettingSea["Use Devil Fruit Skill"] then
        Utils.EquipWeapon("Blox Fruit")
        if _G.Settings.SettingSea["Devil Fruit Z Skill"] then Utils.PressKey("Z") end
        if _G.Settings.SettingSea["Devil Fruit X Skill"] then Utils.PressKey("X") end
        if _G.Settings.SettingSea["Devil Fruit C Skill"] then Utils.PressKey("C") end
        if _G.Settings.SettingSea["Devil Fruit V Skill"] then Utils.PressKey("V") end
        if _G.Settings.SettingSea["Devil Fruit F Skill"] then Utils.PressKey("F") end
    end
    
    if _G.Settings.SettingSea["Use Melee Skill"] then
        Utils.EquipWeapon("Melee")
        if _G.Settings.SettingSea["Melee Z Skill"] then Utils.PressKey("Z") end
        if _G.Settings.SettingSea["Melee X Skill"] then Utils.PressKey("X") end
        if _G.Settings.SettingSea["Melee C Skill"] then Utils.PressKey("C") end
        if _G.Settings.SettingSea["Melee V Skill"] then Utils.PressKey("V") end
    end
    
    if _G.Settings.SettingSea["Use Sword Skill"] then
        Utils.EquipWeapon("Sword")
        Utils.PressKey("Z")
        Utils.PressKey("X")
    end
    
    if _G.Settings.SettingSea["Use Gun Skill"] then
        Utils.EquipWeapon("Gun")
        Utils.PressKey("Z")
        task.wait(0.1)
        Utils.PressKey("X")
    end
end

function SeaEvents.Start()
    spawn(function()
        while true do
            if _G.Settings.SeaEvent["Sail Boat"] then
                pcall(SeaEvents.MainLoop)
            end
            task.wait(0.2)
        end
    end)
    
    spawn(function()
        while true do
            if SeaEvents._G_SeaSkill then
                pcall(SeaEvents.UseSeaSkills)
            end
            task.wait(0.1)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.SeaStack["Auto Attack Seabeasts"] and (Utils.World2 or Utils.World3) then
                if SeaEvents.CheckSeaBeast() then
                    pcall(SeaEvents.FarmSeaBeast)
                end
            end
            task.wait(0.2)
        end
    end)
end

return SeaEvents
