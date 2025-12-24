--[[
    Combat Module - Combat System, Skills, Attack Functions
    Blox Fruits Script by Zlex Hub (Modularized)
    
    FIXED: Now uses VirtualUser for attacks like original working scripts
    This properly triggers the game's combat framework
]]

local Combat = {}

local Utils = nil

function Combat.Init(utils)
    Utils = utils
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

Combat.Skillaimbot = false
Combat.AimBotSkillPosition = Vector3.new(0, 0, 0)

function Combat.Click()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:Button1Down(Vector2.new(1280, 672))
    end)
end

function Combat.Attack()
    Combat.Click()
end

function Combat.NormalAttack()
    Combat.Click()
end

function Combat.UseSkill(key)
    pcall(function()
        VirtualInputManager:SendKeyEvent(true, key, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, key, false, game)
    end)
end

function Combat.UseAllSkills()
    Combat.UseSkill("Z")
    task.wait(0.1)
    Combat.UseSkill("X")
    task.wait(0.1)
    Combat.UseSkill("C")
    task.wait(0.1)
    Combat.UseSkill("V")
    task.wait(0.1)
    Combat.UseSkill("F")
end

function Combat.UseFruitSkills()
    Utils.EquipWeapon("Blox Fruit")
    task.wait(0.1)
    
    if _G.Settings.Setting["Fruit Mastery Skill Z"] then Combat.UseSkill("Z"); task.wait(0.1) end
    if _G.Settings.Setting["Fruit Mastery Skill X"] then Combat.UseSkill("X"); task.wait(0.1) end
    if _G.Settings.Setting["Fruit Mastery Skill C"] then Combat.UseSkill("C"); task.wait(0.1) end
    if _G.Settings.Setting["Fruit Mastery Skill V"] then Combat.UseSkill("V"); task.wait(0.1) end
    if _G.Settings.Setting["Fruit Mastery Skill F"] then Combat.UseSkill("F") end
end

function Combat.UseSwordSkills()
    Utils.EquipWeapon("Sword")
    task.wait(0.1)
    Combat.UseSkill("Z")
    task.wait(0.1)
    Combat.UseSkill("X")
end

function Combat.UseMeleeSkills()
    Utils.EquipWeapon("Melee")
    task.wait(0.1)
    Combat.UseSkill("Z")
    task.wait(0.1)
    Combat.UseSkill("X")
    task.wait(0.1)
    Combat.UseSkill("C")
    task.wait(0.1)
    Combat.UseSkill("V")
end

function Combat.UseGunSkills()
    Utils.EquipWeapon("Gun")
    task.wait(0.1)
    
    if _G.Settings.Setting["Gun Mastery Skill Z"] then
        Combat.UseSkill("Z")
        task.wait(0.5)
    end
    if _G.Settings.Setting["Gun Mastery Skill X"] then
        Combat.UseSkill("X")
        task.wait(0.5)
    end
end

function Combat.AutoHaki()
    pcall(function()
        if _G.Settings.Setting["Auto Haki"] then
            if not Player.Character:FindFirstChild("HasBuso") then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
            end
        end
    end)
end

function Combat.SetSkillAimbot(enabled, position)
    Combat.Skillaimbot = enabled
    if position then
        Combat.AimBotSkillPosition = position
    end
end

function Combat.GetNearestEnemy(maxDistance)
    maxDistance = maxDistance or 500
    local enemies = game:GetService("Workspace"):FindFirstChild("Enemies")
    if not enemies then return nil end
    
    local nearest = nil
    local nearestDist = maxDistance
    
    for _, enemy in pairs(enemies:GetChildren()) do
        local humanoid = enemy:FindFirstChild("Humanoid")
        local hrp = enemy:FindFirstChild("HumanoidRootPart")
        
        if humanoid and hrp and humanoid.Health > 0 then
            local dist = Utils.DistanceTo(hrp.Position)
            if dist < nearestDist then
                nearest = enemy
                nearestDist = dist
            end
        end
    end
    
    return nearest, nearestDist
end

function Combat.AttackEnemy(enemy)
    if not enemy then return end
    
    local hrp = enemy:FindFirstChild("HumanoidRootPart")
    local humanoid = enemy:FindFirstChild("Humanoid")
    
    if not hrp or not humanoid or humanoid.Health <= 0 then return end
    
    Combat.AutoHaki()
    Utils.EquipWeapon(_G.Settings.Main["Selected Weapon"])
    
    if _G.Settings.Main["Bring Monster"] then
        local playerHRP = Utils.GetHumanoidRootPart()
        if playerHRP then
            hrp.CFrame = playerHRP.CFrame * CFrame.new(0, 0, 3)
            hrp.Size = Vector3.new(1, 1, 1)
            humanoid.WalkSpeed = 0
        end
    else
        Utils.TweenPlayer(hrp.CFrame * CFrame.new(0, _G.Settings.Setting["Farm Distance"], 0))
    end
    
    Combat.Attack()
end

function Combat.AutoAttackLoop()
    local enemy = Combat.GetNearestEnemy()
    if enemy then
        Combat.AttackEnemy(enemy)
    end
end

Combat.AttackAuraEnabled = false
Combat.AttackAuraConnection = nil

function Combat.StartAttackAura()
    if Combat.AttackAuraConnection then return end
    
    Combat.AttackAuraConnection = RunService.RenderStepped:Connect(function()
        if _G.Settings.Setting["Attack Aura"] then
            if not _G.Settings.Main["Auto Farm Fruit Mastery"] and 
               not _G.Settings.Main["Auto Farm Gun Mastery"] then
                pcall(function()
                    Combat.Attack()
                end)
            end
        end
    end)
    
    print("[Combat] Attack Aura started")
end

function Combat.StopAttackAura()
    if Combat.AttackAuraConnection then
        Combat.AttackAuraConnection:Disconnect()
        Combat.AttackAuraConnection = nil
        print("[Combat] Attack Aura stopped")
    end
end

function Combat.ToggleAttackAura(enabled)
    _G.Settings.Setting["Attack Aura"] = enabled
    if enabled then
        Combat.StartAttackAura()
    else
        Combat.StopAttackAura()
    end
end

function Combat.Start()
    if _G.Settings.Setting["Attack Aura"] then
        Combat.StartAttackAura()
    end
    print("[Combat] Combat module initialized with VirtualUser attacks")
end

return Combat
