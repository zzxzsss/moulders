--[[
    Mastery Module - Mastery Grinding for Fruit/Melee/Sword/Gun
    Blox Fruits Script by Zlex Hub (Modularized)
]]

local Mastery = {}

local Utils = nil
local QuestData = nil

function Mastery.Init(utils, questData)
    Utils = utils
    QuestData = questData
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")

local Player = Players.LocalPlayer

Mastery.UseSkill = false
Mastery.UseGunSkill = false

function Mastery.GetWeaponByType(weaponType)
    local backpack = Player:FindFirstChild("Backpack")
    if not backpack then return nil end
    
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.ToolTip == weaponType then
            return tool
        end
    end
    
    local char = Player.Character
    if char then
        local equipped = char:FindFirstChildOfClass("Tool")
        if equipped and equipped.ToolTip == weaponType then
            return equipped
        end
    end
    
    return nil
end

function Mastery.GetWeaponList(weaponType)
    local weapons = {}
    local backpack = Player:FindFirstChild("Backpack")
    
    if backpack then
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.ToolTip == weaponType then
                table.insert(weapons, tool.Name)
            end
        end
    end
    
    return weapons
end

function Mastery.EquipMasteryWeapon(weaponType, weaponName)
    local backpack = Player:FindFirstChild("Backpack")
    if not backpack then return false end
    
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local matchType = tool.ToolTip == weaponType
            local matchName = weaponName == "" or tool.Name == weaponName
            
            if matchType and matchName then
                local humanoid = Utils.GetHumanoid()
                if humanoid then
                    humanoid:EquipTool(tool)
                    return true
                end
            end
        end
    end
    return false
end

function Mastery.UnequipAccessory()
    if not _G.Settings.Mastery["Auto Unequip Accessory"] then return end
    
    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and 
                  ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    if CommF then
        pcall(function()
            for i = 1, 3 do
                CommF:InvokeServer("RemoveAccessory", i)
            end
        end)
    end
end

function Mastery.UseSkills(weaponType)
    if weaponType == "Blox Fruit" then
        if _G.Settings.Setting["Fruit Mastery Skill Z"] then
            Utils.PressKey("Z")
        end
        if _G.Settings.Setting["Fruit Mastery Skill X"] then
            Utils.PressKey("X")
        end
        if _G.Settings.Setting["Fruit Mastery Skill C"] then
            Utils.PressKey("C")
        end
        if _G.Settings.Setting["Fruit Mastery Skill V"] then
            Utils.PressKey("V")
        end
        if _G.Settings.Setting["Fruit Mastery Skill F"] then
            Utils.PressKey("F")
        end
    elseif weaponType == "Gun" then
        if _G.Settings.Setting["Gun Mastery Skill Z"] then
            Utils.PressKey("Z")
            task.wait(0.5)
        end
        if _G.Settings.Setting["Gun Mastery Skill X"] then
            Utils.PressKey("X")
            task.wait(0.5)
        end
    else
        Utils.PressKey("Z")
        Utils.PressKey("X")
        Utils.PressKey("C")
        Utils.PressKey("V")
    end
end

function Mastery.FarmMonsterForMastery(weaponType, weaponName)
    local quest = QuestData.CheckQuest()
    if not quest then return end
    
    local monster = Utils.GetNearestMonster(quest.Monster)
    if not monster then
        local dist = Utils.DistanceTo(quest.CFrame.Position)
        if dist > 50 then
            Utils.TweenPlayer(quest.CFrame)
        end
        return
    end
    
    local hrp = monster:FindFirstChild("HumanoidRootPart")
    local humanoid = monster:FindFirstChild("Humanoid")
    
    if not hrp or not humanoid or humanoid.Health <= 0 then return end
    
    Utils.AutoHaki()
    
    if weaponName and weaponName ~= "" then
        Mastery.EquipMasteryWeapon(weaponType, weaponName)
    else
        Utils.EquipWeapon(weaponType)
    end
    
    Utils.TweenPlayer(hrp.CFrame * CFrame.new(0, 15, 0))
    
    local healthPercent = humanoid.Health / humanoid.MaxHealth * 100
    if healthPercent <= _G.Settings.Setting["Mastery Health"] then
        Mastery.UseSkills(weaponType)
    end
    
    Utils.Attack()
end

function Mastery.FruitMasteryLoop()
    if not _G.Settings.Mastery["Fruit Mastery"] then return end
    
    if not Utils.IsAlive() then
        task.wait(1)
        return
    end
    
    Mastery.UnequipAccessory()
    Mastery.FarmMonsterForMastery("Blox Fruit", _G.Settings.Mastery["Selected Fruit Mastery"])
end

function Mastery.SwordMasteryLoop()
    if not _G.Settings.Mastery["Sword Mastery"] then return end
    
    if not Utils.IsAlive() then
        task.wait(1)
        return
    end
    
    Mastery.UnequipAccessory()
    Mastery.FarmMonsterForMastery("Sword", _G.Settings.Mastery["Selected Sword Mastery"])
end

function Mastery.GunMasteryLoop()
    if not _G.Settings.Mastery["Gun Mastery"] then return end
    
    if not Utils.IsAlive() then
        task.wait(1)
        return
    end
    
    Mastery.UnequipAccessory()
    Mastery.FarmMonsterForMastery("Gun", _G.Settings.Mastery["Selected Gun Mastery"])
end

function Mastery.MeleeMasteryLoop()
    if not _G.Settings.Mastery["Melee Mastery"] then return end
    
    if not Utils.IsAlive() then
        task.wait(1)
        return
    end
    
    Mastery.UnequipAccessory()
    Mastery.FarmMonsterForMastery("Melee", _G.Settings.Mastery["Selected Melee Mastery"])
end

function Mastery.Start()
    spawn(function()
        while true do
            if _G.Settings.Mastery["Fruit Mastery"] then
                pcall(Mastery.FruitMasteryLoop)
            end
            task.wait(0.1)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.Mastery["Sword Mastery"] then
                pcall(Mastery.SwordMasteryLoop)
            end
            task.wait(0.1)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.Mastery["Gun Mastery"] then
                pcall(Mastery.GunMasteryLoop)
            end
            task.wait(0.1)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.Mastery["Melee Mastery"] then
                pcall(Mastery.MeleeMasteryLoop)
            end
            task.wait(0.1)
        end
    end)
end

return Mastery
