--[[
    Fast Attack Module - FastAttack System for Combat
    Blox Fruits Script by Zlex Hub (Modularized)
]]

local FastAttack = {}

local Utils = nil

function FastAttack.Init(utils)
    Utils = utils
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local Player = Players.LocalPlayer

FastAttack.Enabled = true
FastAttack.Distance = 100
FastAttack.AttackMobs = true
FastAttack.AttackPlayers = true
FastAttack.ClickDelay = 0
FastAttack.AutoClick = true

local RegisterAttack = nil
local RegisterHit = nil
local Enemies = nil
local Characters = nil

function FastAttack.SafeWaitForChild(parent, childName)
    local success, result = pcall(function()
        return parent:WaitForChild(childName, 5)
    end)
    if not success or not result then
        warn("FastAttack: Could not find " .. childName)
    end
    return result
end

function FastAttack.SetupRemotes()
    local Modules = ReplicatedStorage:FindFirstChild("Modules")
    if Modules then
        local Net = Modules:FindFirstChild("Net")
        if Net then
            RegisterAttack = Net:FindFirstChild("RE/RegisterAttack")
            RegisterHit = Net:FindFirstChild("RE/RegisterHit")
        end
    end
    
    Enemies = Workspace:FindFirstChild("Enemies")
    Characters = Workspace:FindFirstChild("Characters")
end

function FastAttack.IsAlive(character)
    if not character then return false end
    local humanoid = character:FindFirstChild("Humanoid")
    return humanoid and humanoid.Health > 0
end

function FastAttack.ProcessEnemies(othersEnemies, folder)
    if not folder then return nil end
    
    local basePart = nil
    
    for _, enemy in pairs(folder:GetChildren()) do
        local head = enemy:FindFirstChild("Head")
        if head and FastAttack.IsAlive(enemy) then
            if Player:DistanceFromCharacter(head.Position) < FastAttack.Distance then
                if enemy ~= Player.Character then
                    table.insert(othersEnemies, {enemy, head})
                    basePart = head
                end
            end
        end
    end
    
    return basePart
end

function FastAttack.Attack(basePart, othersEnemies)
    if not basePart or #othersEnemies == 0 then return end
    
    if RegisterAttack then
        pcall(function()
            RegisterAttack:FireServer(FastAttack.ClickDelay or 0)
        end)
    end
    
    if RegisterHit then
        pcall(function()
            RegisterHit:FireServer(basePart, othersEnemies)
        end)
    end
end

function FastAttack.AttackNearest()
    local othersEnemies = {}
    
    local part1 = FastAttack.ProcessEnemies(othersEnemies, Enemies)
    local part2 = FastAttack.ProcessEnemies(othersEnemies, Characters)
    
    local character = Player.Character
    if not character then return end
    
    local equippedWeapon = character:FindFirstChildOfClass("Tool")
    
    if equippedWeapon and equippedWeapon:FindFirstChild("LeftClickRemote") then
        for _, enemyData in ipairs(othersEnemies) do
            local enemy = enemyData[1]
            local enemyHRP = enemy:FindFirstChild("HumanoidRootPart")
            if enemyHRP then
                local direction = (enemyHRP.Position - character:GetPivot().Position).Unit
                pcall(function()
                    equippedWeapon.LeftClickRemote:FireServer(direction, 1)
                end)
            end
        end
    elseif #othersEnemies > 0 then
        FastAttack.Attack(part1 or part2, othersEnemies)
    end
end

function FastAttack.BladeHits()
    local character = Player.Character
    if not FastAttack.IsAlive(character) then return end
    
    local equipped = character:FindFirstChildOfClass("Tool")
    if equipped and equipped.ToolTip ~= "Gun" then
        FastAttack.AttackNearest()
    end
end

function FastAttack.AlternativeAttack()
    local char = Player.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local parts = {}
    
    local folders = {Enemies, Characters}
    for _, folder in ipairs(folders) do
        if folder then
            for _, enemy in ipairs(folder:GetChildren()) do
                local hrp = enemy:FindFirstChild("HumanoidRootPart")
                local hum = enemy:FindFirstChild("Humanoid")
                
                if enemy ~= char and hrp and hum and hum.Health > 0 then
                    if (hrp.Position - root.Position).Magnitude <= 60 then
                        for _, part in ipairs(enemy:GetChildren()) do
                            if part:IsA("BasePart") then
                                if (hrp.Position - root.Position).Magnitude <= 60 then
                                    parts[#parts + 1] = {enemy, part}
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    local tool = char:FindFirstChildOfClass("Tool")
    if #parts > 0 and tool then
        local weaponType = tool:GetAttribute("WeaponType")
        if weaponType == "Melee" or weaponType == "Sword" then
            pcall(function()
                local Net = ReplicatedStorage:FindFirstChild("Modules") and 
                            ReplicatedStorage.Modules:FindFirstChild("Net")
                if Net then
                    local regAttack = Net:FindFirstChild("RE/RegisterAttack")
                    local regHit = Net:FindFirstChild("RE/RegisterHit")
                    
                    if regAttack then
                        regAttack:FireServer()
                    end
                    
                    if regHit then
                        local head = parts[1][1]:FindFirstChild("Head")
                        if head then
                            regHit:FireServer(head, parts, {}, 
                                tostring(Player.UserId):sub(2, 4) .. 
                                tostring(coroutine.running()):sub(11, 15))
                        end
                    end
                end
                
                FastAttack.ObfuscatedRemoteAttack(parts)
            end)
        end
    end
end

function FastAttack.ObfuscatedRemoteAttack(parts)
    pcall(function()
        local remote, idremote
        local folders = {
            ReplicatedStorage:FindFirstChild("Util"),
            ReplicatedStorage:FindFirstChild("Common"),
            ReplicatedStorage:FindFirstChild("Remotes"),
            ReplicatedStorage:FindFirstChild("Assets"),
            ReplicatedStorage:FindFirstChild("FX")
        }
        
        for _, folder in pairs(folders) do
            if folder then
                for _, child in pairs(folder:GetChildren()) do
                    if child:IsA("RemoteEvent") and child:GetAttribute("Id") then
                        remote = child
                        idremote = child:GetAttribute("Id")
                        break
                    end
                end
            end
            if remote then break end
        end
        
        if not remote or not idremote or #parts == 0 then return end
        
        local Net = ReplicatedStorage:FindFirstChild("Modules") and 
                    ReplicatedStorage.Modules:FindFirstChild("Net")
        if not Net or not Net:FindFirstChild("seed") then return end
        
        local head = parts[1][1]:FindFirstChild("Head")
        if not head then return end
        
        local obfuscatedName = string.gsub("RE/RegisterHit", ".", function(c)
            return string.char(
                bit32.bxor(string.byte(c), math.floor(Workspace:GetServerTimeNow() / 10 % 10) + 1)
            )
        end)
        
        local seedValue = Net.seed:InvokeServer()
        local obfuscatedId = bit32.bxor(idremote + 909090, seedValue * 2)
        
        if cloneref then
            cloneref(remote):FireServer(obfuscatedName, obfuscatedId, head, parts)
        else
            remote:FireServer(obfuscatedName, obfuscatedId, head, parts)
        end
    end)
end

function FastAttack.MainLoop()
    if not FastAttack.Enabled then return end
    if not FastAttack.AutoClick then return end
    
    FastAttack.BladeHits()
end

function FastAttack.Start()
    FastAttack.SetupRemotes()
    
    spawn(function()
        while true do
            if _G.FastAttack and FastAttack.AutoClick then
                pcall(FastAttack.MainLoop)
            end
            task.wait(FastAttack.ClickDelay)
        end
    end)
    
    spawn(function()
        while true do
            if _G.FastAttack then
                pcall(FastAttack.AlternativeAttack)
            end
            task.wait(0.05)
        end
    end)
end

_G.FastAttack = true

return FastAttack
