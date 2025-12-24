--[[
    Race Module - Race V4 Mechanics, Temples, Trials
    Blox Fruits Script by Zlex Hub (Modularized)
]]

local Race = {}

local Utils = nil

function Race.Init(utils)
    Utils = utils
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer

Race.TempleList = {"Human Temple", "Angel Temple", "Demon Temple", "Shark Temple", "Ghoul Temple"}

Race.TempleCFrames = {
    ["Human Temple"] = CFrame.new(-12621.5, 397.8, -7585.5),
    ["Angel Temple"] = CFrame.new(-7893.5, 5558.1, -1384.8),
    ["Demon Temple"] = CFrame.new(-12003.7, 374.8, -7604.5),
    ["Shark Temple"] = CFrame.new(5255.7, 6.9, -6638.5),
    ["Ghoul Temple"] = CFrame.new(-5570.4, 48.5, -784.4)
}

Race.TrialCFrames = {
    ["Human"] = {
        Trial1 = CFrame.new(-12621.5, 397.8, -7585.5),
        Trial2 = CFrame.new(-12650.2, 397.8, -7600.3),
        Trial3 = CFrame.new(-12680.5, 397.8, -7615.7)
    },
    ["Angel"] = {
        Trial1 = CFrame.new(-7893.5, 5558.1, -1384.8),
        Trial2 = CFrame.new(-7920.3, 5558.1, -1400.5),
        Trial3 = CFrame.new(-7950.7, 5558.1, -1415.9)
    },
    ["Demon"] = {
        Trial1 = CFrame.new(-12003.7, 374.8, -7604.5),
        Trial2 = CFrame.new(-12030.4, 374.8, -7620.2),
        Trial3 = CFrame.new(-12060.8, 374.8, -7635.6)
    },
    ["Shark"] = {
        Trial1 = CFrame.new(5255.7, 6.9, -6638.5),
        Trial2 = CFrame.new(5280.4, 6.9, -6655.2),
        Trial3 = CFrame.new(5310.8, 6.9, -6670.6)
    }
}

function Race.GetPlayerRace()
    local data = Player:FindFirstChild("Data")
    if data then
        local race = data:FindFirstChild("Race")
        if race then
            return race.Value
        end
    end
    return "Unknown"
end

function Race.GetRaceVersion()
    local data = Player:FindFirstChild("Data")
    if data then
        local raceVersion = data:FindFirstChild("RaceVersion") or data:FindFirstChild("Race_Version")
        if raceVersion then
            return raceVersion.Value
        end
    end
    return 0
end

function Race.IsNightTime()
    local clockTime = Lighting.ClockTime
    return clockTime >= 18 or clockTime < 6
end

function Race.IsMirageIslandSpawned()
    local map = Workspace:FindFirstChild("Map")
    return map and map:FindFirstChild("MysticIsland")
end

function Race.GetHighestPoint()
    local map = Workspace:FindFirstChild("Map")
    if not map then return nil end
    
    local mysticIsland = map:FindFirstChild("MysticIsland")
    if not mysticIsland then return nil end
    
    for _, part in pairs(mysticIsland:GetDescendants()) do
        if part:IsA("MeshPart") and part.MeshId == "rbxassetid://6745037796" then
            return part
        end
    end
    return nil
end

function Race.TeleportToTemple(templeName)
    local cframe = Race.TempleCFrames[templeName]
    if cframe then
        local dist = Utils.DistanceTo(cframe.Position)
        if dist > 2000 then
            Utils.BTP(cframe)
        else
            Utils.TweenPlayer(cframe)
        end
    end
end

function Race.TeleportToMirageIsland()
    if Race.IsMirageIslandSpawned() then
        local highestPoint = Race.GetHighestPoint()
        if highestPoint then
            Utils.TweenPlayer(highestPoint.CFrame * CFrame.new(0, 211.88, 0))
        end
    end
end

function Race.StartTrial(trialNumber)
    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and 
                  ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    if CommF then
        pcall(function()
            CommF:InvokeServer("StartTrial", trialNumber)
        end)
    end
end

function Race.ActivateRaceV3()
    local CommE = ReplicatedStorage:FindFirstChild("Remotes") and 
                  ReplicatedStorage.Remotes:FindFirstChild("CommE")
    if CommE then
        pcall(function()
            CommE:FireServer("ActivateAbility")
        end)
    end
end

function Race.ActivateRaceV4()
    local char = Player.Character
    if not char then return end
    
    local raceEnergy = char:FindFirstChild("RaceEnergy")
    local raceTransformed = char:FindFirstChild("RaceTransformed")
    
    if raceEnergy and raceTransformed then
        if raceEnergy.Value == 1 and raceTransformed.Value == false then
            Utils.PressKey("Y")
        end
    end
end

function Race.AwakenRace()
    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and 
                  ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    if CommF then
        pcall(function()
            CommF:InvokeServer("AwakenRace")
        end)
    end
end

function Race.RaceV4Loop()
    if not _G.Settings.Race["Auto Race V4"] then return end
    if not Utils.IsAlive() then return end
    
    local selectedTemple = _G.Settings.Race["Selected Temple"]
    if not selectedTemple or selectedTemple == "None" then return end
    
    if _G.Settings.Race["Temple Night Only"] and not Race.IsNightTime() then
        return
    end
    
    Race.TeleportToTemple(selectedTemple)
end

function Race.TrialsLoop()
    if not _G.Settings.Race["Auto Trials"] then return end
    if not Utils.IsAlive() then return end
    
    local playerRace = Race.GetPlayerRace()
    local trials = Race.TrialCFrames[playerRace]
    
    if trials then
        for i = 1, 3 do
            local trialKey = "Trial" .. i
            if trials[trialKey] then
                local dist = Utils.DistanceTo(trials[trialKey].Position)
                if dist > 50 then
                    Utils.TweenPlayer(trials[trialKey])
                else
                    Race.StartTrial(i)
                end
            end
        end
    end
end

function Race.MirageIslandLoop()
    if not _G.Settings.Race["Tween To Mirage Island"] then return end
    if not Utils.IsAlive() then return end
    
    if Race.IsMirageIslandSpawned() then
        Race.TeleportToMirageIsland()
    end
end

function Race.HighestMirageLoop()
    if not _G.Settings.Race["Tween To Highest Mirage"] then return end
    if not Utils.IsAlive() then return end
    
    if Race.IsMirageIslandSpawned() then
        local highestPoint = Race.GetHighestPoint()
        if highestPoint then
            Utils.TweenPlayer(highestPoint.CFrame * CFrame.new(0, 211.88, 0))
        end
    end
end

function Race.AwakenRaceLoop()
    if not _G.Settings.Race["Auto Awaken Race"] then return end
    if not Utils.IsAlive() then return end
    
    Race.AwakenRace()
    
    if _G.Settings.Race["Awaken Race Hopserver"] then
        task.wait(5)
        Utils.ServerHop()
    end
end

function Race.Start()
    spawn(function()
        while true do
            if _G.Settings.Race["Auto Race V4"] then
                pcall(Race.RaceV4Loop)
            end
            task.wait(0.5)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.Race["Auto Trials"] then
                pcall(Race.TrialsLoop)
            end
            task.wait(0.5)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.Race["Tween To Mirage Island"] then
                pcall(Race.MirageIslandLoop)
            end
            task.wait(0.2)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.Race["Tween To Highest Mirage"] then
                pcall(Race.HighestMirageLoop)
            end
            task.wait(0.2)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.Race["Auto Awaken Race"] then
                pcall(Race.AwakenRaceLoop)
            end
            task.wait(1)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.LocalPlayer["Active Race V3"] then
                pcall(Race.ActivateRaceV3)
            end
            task.wait(1)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.LocalPlayer["Active Race V4"] then
                pcall(Race.ActivateRaceV4)
            end
            task.wait(0.2)
        end
    end)
end

return Race
