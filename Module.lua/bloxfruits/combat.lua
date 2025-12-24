--[[
    Combat Module - Combat System, Skills, Skill Aimbot
    Blox Fruits Script by Zlex Hub (Modularized)
]]

local Combat = {}

local Utils = nil

function Combat.Init(utils)
    Utils = utils
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

Combat.Skillaimbot = false
Combat.AimBotSkillPosition = Vector3.new(0, 0, 0)
Combat.SkillCooldowns = {}

function Combat.Attack()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
    task.wait()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
end

function Combat.UseSkill(key)
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    task.wait()
    VirtualInputManager:SendKeyEvent(false, key, false, game)
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
    
    if _G.Settings.Setting["Fruit Mastery Skill Z"] then Combat.UseSkill("Z") end
    if _G.Settings.Setting["Fruit Mastery Skill X"] then Combat.UseSkill("X") end
    if _G.Settings.Setting["Fruit Mastery Skill C"] then Combat.UseSkill("C") end
    if _G.Settings.Setting["Fruit Mastery Skill V"] then Combat.UseSkill("V") end
    if _G.Settings.Setting["Fruit Mastery Skill F"] then Combat.UseSkill("F") end
end

function Combat.UseSwordSkills()
    Utils.EquipWeapon("Sword")
    task.wait(0.1)
    Combat.UseSkill("Z")
    Combat.UseSkill("X")
end

function Combat.UseMeleeSkills()
    Utils.EquipWeapon("Melee")
    task.wait(0.1)
    Combat.UseSkill("Z")
    Combat.UseSkill("X")
    Combat.UseSkill("C")
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
    Utils.AutoHaki()
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
        end
    else
        Utils.TweenPlayer(hrp.CFrame * CFrame.new(0, 15, 0))
    end
    
    Combat.Attack()
end

function Combat.AutoAttackLoop()
    local enemy = Combat.GetNearestEnemy()
    if enemy then
        Combat.AttackEnemy(enemy)
    end
end

function Combat.SkillAimbotMetatable()
    local gg = getrawmetatable(game)
    local old = gg.__namecall
    
    setreadonly(gg, false)
    
    gg.__namecall = newcclosure(function(...)
        local method = getnamecallmethod()
        local args = {...}
        
        if tostring(method) == "FireServer" then
            if tostring(args[1]) == "RemoteEvent" then
                if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                    if Combat.Skillaimbot then
                        args[2] = Combat.AimBotSkillPosition
                        return old(unpack(args))
                    end
                end
            end
        end
        
        return old(...)
    end)
end

function Combat.SetupSkillAimbot()
    pcall(Combat.SkillAimbotMetatable)
end

function Combat.Start()
    Combat.SetupSkillAimbot()
end

return Combat
