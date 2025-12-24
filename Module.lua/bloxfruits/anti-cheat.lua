--[[
    Anti-Cheat Bypass Module - Anti-Cheat Evasion Systems
    Blox Fruits Script by Zlex Hub (Modularized)
    
    WARNING: These bypasses may become outdated after game updates.
    Check for updates if the script stops working.
]]

local AntiCheat = {}

local Utils = nil

function AntiCheat.Init(utils)
    Utils = utils
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer

AntiCheat.Skillaimbot = false
AntiCheat.AimBotSkillPosition = Vector3.new(0, 0, 0)
AntiCheat.MetatableHooked = false
AntiCheat.RemoteObfuscated = false
AntiCheat.OldNamecall = nil
AntiCheat.DeathRespawnHooked = false
AntiCheat.BypassTP = true

AntiCheat.Remote = nil
AntiCheat.IdRemote = nil

function AntiCheat.HookDeathRespawn()
    if AntiCheat.DeathRespawnHooked then return end
    
    local success = pcall(function()
        if not hookfunction then return end
        
        local Effect = ReplicatedStorage:FindFirstChild("Effect")
        if not Effect then return end
        
        local Container = Effect:FindFirstChild("Container")
        if not Container then return end
        
        local Death = Container:FindFirstChild("Death")
        local Respawn = Container:FindFirstChild("Respawn")
        
        if Death then
            pcall(function()
                hookfunction(require(Death), function()
                end)
            end)
        end
        
        if Respawn then
            pcall(function()
                hookfunction(require(Respawn), function()
                end)
            end)
        end
        
        AntiCheat.DeathRespawnHooked = true
    end)
    
    if success and AntiCheat.DeathRespawnHooked then
        print("[AntiCheat] Death/Respawn effects hooked")
    end
end

function AntiCheat.BypassTeleport(cframe, bypassEnabled)
    if bypassEnabled == nil then bypassEnabled = AntiCheat.BypassTP end
    
    local char = Player.Character
    if not char then return false end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    
    local success = pcall(function()
        if bypassEnabled then
            local distance = (root.Position - cframe.Position).Magnitude
            
            if distance > 1500 then
                local existingVelocity = root:FindFirstChild("BypassVelocity")
                if existingVelocity then existingVelocity:Destroy() end
                
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Name = "BypassVelocity"
                bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.Parent = root
                
                root.CFrame = cframe
                
                task.delay(0.5, function()
                    if bodyVelocity and bodyVelocity.Parent then
                        bodyVelocity:Destroy()
                    end
                end)
            else
                root.CFrame = cframe
            end
        else
            root.CFrame = cframe
        end
    end)
    
    return success
end

function AntiCheat.SetupMetatableHook()
    if AntiCheat.MetatableHooked then return end
    
    local success = pcall(function()
        if not getrawmetatable then return end
        if not setreadonly then return end
        if not newcclosure then return end
        if not getnamecallmethod then return end
        
        local gg = getrawmetatable(game)
        AntiCheat.OldNamecall = gg.__namecall
        
        setreadonly(gg, false)
        
        gg.__namecall = newcclosure(function(...)
            local method = getnamecallmethod()
            local args = {...}
            
            if tostring(method) == "FireServer" then
                if tostring(args[1]) == "RemoteEvent" then
                    if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                        if AntiCheat.Skillaimbot then
                            args[2] = AntiCheat.AimBotSkillPosition
                            return AntiCheat.OldNamecall(unpack(args))
                        end
                    end
                end
            end
            
            return AntiCheat.OldNamecall(...)
        end)
        
        AntiCheat.MetatableHooked = true
    end)
    
    if not success then
        warn("[AntiCheat] Metatable hook failed - executor may not support required functions")
    end
end

function AntiCheat.SetupRemoteObfuscation()
    if AntiCheat.RemoteObfuscated then return end
    
    local success = pcall(function()
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
                        AntiCheat.Remote = child
                        AntiCheat.IdRemote = child:GetAttribute("Id")
                    end
                end
                
                folder.ChildAdded:Connect(function(child)
                    if child:IsA("RemoteEvent") and child:GetAttribute("Id") then
                        AntiCheat.Remote = child
                        AntiCheat.IdRemote = child:GetAttribute("Id")
                    end
                end)
            end
        end
        
        AntiCheat.RemoteObfuscated = true
    end)
    
    if not success then
        warn("[AntiCheat] Remote obfuscation setup failed")
    end
end

function AntiCheat.ObfuscateRemoteCall(remoteName, basePart, parts)
    if not AntiCheat.Remote or not AntiCheat.IdRemote then return end
    
    local success = pcall(function()
        local Net = ReplicatedStorage:FindFirstChild("Modules") and 
                    ReplicatedStorage.Modules:FindFirstChild("Net")
        
        if not Net then return end
        
        local seed = Net:FindFirstChild("seed")
        if not seed then return end
        
        local obfuscatedName = string.gsub(remoteName, ".", function(c)
            return string.char(
                bit32.bxor(string.byte(c), math.floor(Workspace:GetServerTimeNow() / 10 % 10) + 1)
            )
        end)
        
        local seedValue = seed:InvokeServer()
        local obfuscatedId = bit32.bxor(AntiCheat.IdRemote + 909090, seedValue * 2)
        
        if cloneref then
            cloneref(AntiCheat.Remote):FireServer(obfuscatedName, obfuscatedId, basePart, parts)
        else
            AntiCheat.Remote:FireServer(obfuscatedName, obfuscatedId, basePart, parts)
        end
    end)
    
    return success
end

function AntiCheat.BypassedRegisterHit(basePart, parts)
    local success = pcall(function()
        local Net = ReplicatedStorage:FindFirstChild("Modules") and 
                    ReplicatedStorage.Modules:FindFirstChild("Net")
        
        if not Net then return end
        
        local RegisterAttack = Net:FindFirstChild("RE/RegisterAttack")
        local RegisterHit = Net:FindFirstChild("RE/RegisterHit")
        
        if RegisterAttack then
            RegisterAttack:FireServer()
        end
        
        if RegisterHit and basePart then
            local userId = tostring(Player.UserId):sub(2, 4)
            local coroutineId = tostring(coroutine.running()):sub(11, 15)
            local uniqueId = userId .. coroutineId
            
            RegisterHit:FireServer(basePart, parts, {}, uniqueId)
        end
        
        AntiCheat.ObfuscateRemoteCall("RE/RegisterHit", basePart, parts)
    end)
    
    return success
end

function AntiCheat.EnhancedFastAttack()
    local char = Player.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local parts = {}
    local Enemies = Workspace:FindFirstChild("Enemies")
    local Characters = Workspace:FindFirstChild("Characters")
    
    local folders = {Enemies, Characters}
    for _, folder in ipairs(folders) do
        if folder then
            for _, enemy in ipairs(folder:GetChildren()) do
                local hrp = enemy:FindFirstChild("HumanoidRootPart")
                local hum = enemy:FindFirstChild("Humanoid")
                
                if enemy ~= char and hrp and hum and hum.Health > 0 then
                    local distance = (hrp.Position - root.Position).Magnitude
                    if distance <= 60 then
                        for _, part in ipairs(enemy:GetChildren()) do
                            if part:IsA("BasePart") then
                                parts[#parts + 1] = {enemy, part}
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
            local head = parts[1][1]:FindFirstChild("Head")
            if head then
                AntiCheat.BypassedRegisterHit(head, parts)
            end
        end
    end
end

function AntiCheat.SetSkillAimbot(enabled, position)
    AntiCheat.Skillaimbot = enabled
    if position then
        AntiCheat.AimBotSkillPosition = position
    end
end

function AntiCheat.DisableAntiTeleport()
    pcall(function()
        local antiTeleport = Player:FindFirstChild("AntiTeleport")
        if antiTeleport then
            antiTeleport:Destroy()
        end
        
        local char = Player.Character
        if char then
            local scripts = char:GetDescendants()
            for _, script in pairs(scripts) do
                if script:IsA("LocalScript") and string.find(script.Name:lower(), "anti") then
                    script.Disabled = true
                end
            end
        end
    end)
end

function AntiCheat.DisableSpeedCheck()
    pcall(function()
        local humanoid = Player.Character and Player.Character:FindFirstChild("Humanoid")
        if humanoid then
            local maxSpeed = humanoid.WalkSpeed
            humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                if humanoid.WalkSpeed < maxSpeed then
                    humanoid.WalkSpeed = maxSpeed
                end
            end)
        end
    end)
end

function AntiCheat.AntiKick()
    pcall(function()
        if hookfunction and not AntiCheat.KickHooked then
            local oldKick = hookfunction(Player.Kick, function()
                return nil
            end)
            AntiCheat.KickHooked = true
        end
    end)
end

function AntiCheat.Start()
    AntiCheat.HookDeathRespawn()
    AntiCheat.SetupMetatableHook()
    AntiCheat.SetupRemoteObfuscation()
    AntiCheat.DisableAntiTeleport()
    AntiCheat.AntiKick()
    
    spawn(function()
        while true do
            if _G.FastAttack then
                pcall(AntiCheat.EnhancedFastAttack)
            end
            task.wait(0.05)
        end
    end)
    
    spawn(function()
        while true do
            pcall(AntiCheat.DisableSpeedCheck)
            task.wait(1)
        end
    end)
    
    print("[AntiCheat] Bypass systems initialized")
    print("[AntiCheat] Death/Respawn hook: " .. (AntiCheat.DeathRespawnHooked and "Active" or "N/A"))
    print("[AntiCheat] Metatable hook: " .. (AntiCheat.MetatableHooked and "Active" or "N/A"))
    print("[AntiCheat] Remote obfuscation: " .. (AntiCheat.RemoteObfuscated and "Active" or "N/A"))
end

_G.FastAttack = true

return AntiCheat
