--[[
    Auto Farm Module - Farming Logic for All Worlds
    Blox Fruits Script by Zlex Hub (Modularized)
]]

local AutoFarm = {}

local Utils = nil
local QuestData = nil

function AutoFarm.Init(utils, questData)
    Utils = utils
    QuestData = questData
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

AutoFarm.MonFarm = ""
AutoFarm.MonLevel = 0
AutoFarm.QuestCFrame = nil
AutoFarm.MonCFrame = nil
AutoFarm.QuestName = ""
AutoFarm.StartedQuest = false

function AutoFarm.GetCurrentQuest()
    if _G.Settings.Main["Farm Selected Monster"] and _G.Settings.Main["Selected Monster"] ~= "" then
        return QuestData.GetQuestByMonster(_G.Settings.Main["Selected Monster"])
    else
        return QuestData.CheckQuest()
    end
end

function AutoFarm.UpdateQuestInfo()
    local quest = AutoFarm.GetCurrentQuest()
    if quest then
        AutoFarm.MonFarm = quest.Monster
        AutoFarm.MonLevel = quest.Level
        AutoFarm.QuestCFrame = quest.CFrame
        AutoFarm.QuestName = quest.QuestId
    end
end

function AutoFarm.GetNPCPosition(npcName)
    local npcs = game:GetService("Workspace"):FindFirstChild("NPCs")
    if npcs then
        for _, npc in pairs(npcs:GetDescendants()) do
            if npc.Name == npcName and npc:IsA("Model") then
                local hrp = npc:FindFirstChild("HumanoidRootPart")
                if hrp then
                    return hrp.CFrame
                end
            end
        end
    end
    return nil
end

function AutoFarm.GetMonsterSpawn()
    local worldOrigin = game:GetService("Workspace"):FindFirstChild("_WorldOrigin")
    if worldOrigin then
        local enemySpawns = worldOrigin:FindFirstChild("EnemySpawns")
        if enemySpawns then
            for _, spawn in pairs(enemySpawns:GetChildren()) do
                if spawn.Name == AutoFarm.MonFarm then
                    return spawn.CFrame
                end
            end
        end
    end
    return nil
end

function AutoFarm.HasActiveQuest()
    local playerGui = Player:FindFirstChild("PlayerGui")
    if not playerGui then return false end
    
    local main = playerGui:FindFirstChild("Main")
    if not main then return false end
    
    local quest = main:FindFirstChild("Quest")
    return quest and quest.Visible
end

function AutoFarm.GetQuestProgress()
    local playerGui = Player:FindFirstChild("PlayerGui")
    if not playerGui then return 0, 0 end
    
    local main = playerGui:FindFirstChild("Main")
    if not main then return 0, 0 end
    
    local quest = main:FindFirstChild("Quest")
    if quest and quest.Visible then
        local container = quest:FindFirstChild("Container")
        if container then
            local progressLabel = container:FindFirstChild("ProgressLabel")
            if progressLabel then
                local text = progressLabel.Text
                local current, total = text:match("(%d+)/(%d+)")
                return tonumber(current) or 0, tonumber(total) or 0
            end
        end
    end
    return 0, 0
end

function AutoFarm.IsQuestComplete()
    local current, total = AutoFarm.GetQuestProgress()
    return current >= total and total > 0
end

function AutoFarm.AcceptQuest()
    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and 
                  ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    if CommF then
        pcall(function()
            CommF:InvokeServer("StartQuest", AutoFarm.QuestName, AutoFarm.MonLevel)
        end)
        AutoFarm.StartedQuest = true
    end
end

function AutoFarm.AbandonQuest()
    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and 
                  ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    if CommF then
        pcall(function()
            CommF:InvokeServer("AbandonQuest")
        end)
    end
end

function AutoFarm.FindMonster()
    local enemies = game:GetService("Workspace"):FindFirstChild("Enemies")
    if not enemies then return nil end
    
    local nearest = nil
    local nearestDist = math.huge
    local hrp = Utils.GetHumanoidRootPart()
    if not hrp then return nil end
    
    for _, enemy in pairs(enemies:GetChildren()) do
        if enemy.Name == AutoFarm.MonFarm then
            local enemyHumanoid = enemy:FindFirstChild("Humanoid")
            local enemyHRP = enemy:FindFirstChild("HumanoidRootPart")
            
            if enemyHumanoid and enemyHRP and enemyHumanoid.Health > 0 then
                local dist = (hrp.Position - enemyHRP.Position).Magnitude
                if dist < nearestDist then
                    nearest = enemy
                    nearestDist = dist
                end
            end
        end
    end
    
    return nearest
end

function AutoFarm.FarmMonster(monster)
    if not monster then return end
    
    local enemyHRP = monster:FindFirstChild("HumanoidRootPart")
    local enemyHumanoid = monster:FindFirstChild("Humanoid")
    
    if not enemyHRP or not enemyHumanoid then return end
    if enemyHumanoid.Health <= 0 then return end
    
    Utils.AutoHaki()
    Utils.EquipWeapon(_G.Settings.Main["Selected Weapon"])
    
    if _G.Settings.Main["Bring Monster"] then
        local targetCFrame = Utils.GetHumanoidRootPart().CFrame * CFrame.new(0, 0, 3)
        enemyHRP.CFrame = targetCFrame
        Utils.Attack()
    else
        local farmPos = Utils.Pos or CFrame.new(0, 15, 0)
        Utils.TweenPlayer(enemyHRP.CFrame * farmPos)
        Utils.Attack()
    end
end

function AutoFarm.MainLoop()
    if not _G.Settings.Main["Auto Farm"] then return end
    
    AutoFarm.UpdateQuestInfo()
    
    if not Utils.IsAlive() then
        task.wait(1)
        return
    end
    
    if _G.Settings.Main["Auto Quest"] then
        if not AutoFarm.HasActiveQuest() then
            if AutoFarm.QuestCFrame then
                local dist = Utils.DistanceTo(AutoFarm.QuestCFrame.Position)
                if dist > 50 then
                    if dist > 2000 then
                        Utils.BTP(AutoFarm.QuestCFrame)
                    else
                        Utils.TweenPlayer(AutoFarm.QuestCFrame)
                    end
                else
                    AutoFarm.AcceptQuest()
                end
            end
        else
            local monster = AutoFarm.FindMonster()
            if monster then
                AutoFarm.FarmMonster(monster)
            else
                local spawnCFrame = AutoFarm.GetMonsterSpawn()
                if spawnCFrame then
                    Utils.TweenPlayer(spawnCFrame * CFrame.new(0, 15, 0))
                end
            end
        end
    else
        local monster = AutoFarm.FindMonster()
        if monster then
            AutoFarm.FarmMonster(monster)
        else
            local spawnCFrame = AutoFarm.GetMonsterSpawn()
            if spawnCFrame then
                Utils.TweenPlayer(spawnCFrame * CFrame.new(0, 15, 0))
            end
        end
    end
end

function AutoFarm.CollectNearbyChests()
    if not _G.Settings.Main["Auto Collect Chest"] then return end
    
    local chestModels = game:GetService("Workspace"):FindFirstChild("ChestModels")
    if not chestModels then return end
    
    local range = _G.Settings.Main["Collect Chest Range"] or 150
    
    for _, chest in pairs(chestModels:GetChildren()) do
        local dist = Utils.DistanceTo(chest.Position or (chest:FindFirstChild("Chest") and chest.Chest.Position) or Vector3.new(0,0,0))
        if dist <= range then
            if chest:FindFirstChild("Chest") then
                local hrp = Utils.GetHumanoidRootPart()
                if hrp then
                    local oldCFrame = hrp.CFrame
                    hrp.CFrame = chest.Chest.CFrame * CFrame.new(0, 5, 0)
                    task.wait(0.2)
                    hrp.CFrame = oldCFrame
                end
            end
        end
    end
end

function AutoFarm.Start()
    spawn(function()
        while true do
            if _G.Settings.Main["Auto Farm"] then
                pcall(AutoFarm.MainLoop)
            end
            task.wait(0.1)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.Main["Auto Farm"] and _G.Settings.Main["Auto Collect Chest"] then
                pcall(AutoFarm.CollectNearbyChests)
            end
            task.wait(1)
        end
    end)
end

return AutoFarm
