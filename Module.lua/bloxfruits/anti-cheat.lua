local AntiCheat = {}

local Utils = nil

function AntiCheat.Init(utils)
    Utils = utils
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

AntiCheat.Skillaimbot = false
AntiCheat.AimBotSkillPosition = Vector3.new(0, 0, 0)
AntiCheat.MetatableHooked = false
AntiCheat.RemoteObfuscated = false
AntiCheat.OldNamecall = nil
AntiCheat.DeathRespawnHooked = false
AntiCheat.BypassTP = true
AntiCheat.WatchdogsDisabled = false
AntiCheat.ExecutorProbesBlocked = false
AntiCheat.CommEHooked = false
AntiCheat.LastTeleportTime = 0
AntiCheat.TeleportCooldown = 0.1

AntiCheat.Remote = nil
AntiCheat.IdRemote = nil
AntiCheat.CommE = nil
AntiCheat.CommF = nil
AntiCheat.NetSeed = nil
AntiCheat.LastHitTime = 0
AntiCheat.HitCooldown = 0.05

function AntiCheat.FindRemotes()
    pcall(function()
        local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if Remotes then
            AntiCheat.CommE = Remotes:FindFirstChild("CommE")
            AntiCheat.CommF = Remotes:FindFirstChild("CommF")
        end
        
        local Net = ReplicatedStorage:FindFirstChild("Modules") and 
                    ReplicatedStorage.Modules:FindFirstChild("Net")
        if Net then
            AntiCheat.NetSeed = Net:FindFirstChild("seed")
        end
    end)
end

function AntiCheat.GetNetSeed()
    if not AntiCheat.NetSeed then return 0 end
    local success, seed = pcall(function()
        return AntiCheat.NetSeed:InvokeServer()
    end)
    return success and seed or 0
end

function AntiCheat.SendTeleportHandshake(destination)
    pcall(function()
        if AntiCheat.CommE then
            AntiCheat.CommE:FireServer("TeleportDetect", false, true)
        end
    end)
end

function AntiCheat.SendMagnetHandshake(target)
    pcall(function()
        if AntiCheat.CommE then
            AntiCheat.CommE:FireServer("Magnet", target, true)
        end
    end)
end

function AntiCheat.TweenTeleport(targetCFrame, speed, callback)
    local char = Player.Character
    if not char then 
        if callback then callback(false) end
        return false 
    end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then 
        if callback then callback(false) end
        return false 
    end
    
    local humanoid = char:FindFirstChild("Humanoid")
    
    local startPos = root.Position
    local endPos = targetCFrame.Position
    local distance = (endPos - startPos).Magnitude
    
    local maxStepDistance = 450
    local steps = math.ceil(distance / maxStepDistance)
    
    if steps <= 1 then
        local tweenInfo = TweenInfo.new(
            distance / (speed or 500),
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out
        )
        
        AntiCheat.SendTeleportHandshake(targetCFrame)
        
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        end
        
        local tween = TweenService:Create(root, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        tween.Completed:Connect(function()
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
            if callback then callback(true) end
        end)
        return true
    end
    
    local direction = (endPos - startPos).Unit
    local stepSize = distance / steps
    
    local function doStep(stepIndex)
        if stepIndex > steps then
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
            if callback then callback(true) end
            return
        end
        
        local stepTarget
        if stepIndex == steps then
            stepTarget = targetCFrame
        else
            local stepPos = startPos + (direction * stepSize * stepIndex)
            stepTarget = CFrame.new(stepPos) * (targetCFrame - targetCFrame.Position)
        end
        
        AntiCheat.SendTeleportHandshake(stepTarget)
        
        local stepDist = stepSize
        local tweenTime = stepDist / (speed or 500)
        
        local tweenInfo = TweenInfo.new(
            tweenTime,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out
        )
        
        if humanoid and stepIndex == 1 then
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        end
        
        local tween = TweenService:Create(root, tweenInfo, {CFrame = stepTarget})
        tween:Play()
        tween.Completed:Connect(function()
            task.wait(0.02)
            doStep(stepIndex + 1)
        end)
    end
    
    doStep(1)
    return true
end

function AntiCheat.SafeTeleport(targetCFrame, instant)
    local char = Player.Character
    if not char then return false end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    
    local now = tick()
    if now - AntiCheat.LastTeleportTime < AntiCheat.TeleportCooldown then
        task.wait(AntiCheat.TeleportCooldown)
    end
    AntiCheat.LastTeleportTime = tick()
    
    local distance = (root.Position - targetCFrame.Position).Magnitude
    
    if instant or distance < 100 then
        AntiCheat.SendTeleportHandshake(targetCFrame)
        root.CFrame = targetCFrame
        return true
    elseif distance < 500 then
        AntiCheat.SendTeleportHandshake(targetCFrame)
        local tweenInfo = TweenInfo.new(distance / 800, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(root, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        tween.Completed:Wait()
        return true
    else
        return AntiCheat.TweenTeleport(targetCFrame, 800)
    end
end

function AntiCheat.HookDeathRespawn()
    if AntiCheat.DeathRespawnHooked then return end
    
    local success = pcall(function()
        if not hookfunction then return end
        
        local Effect = ReplicatedStorage:FindFirstChild("Effect")
        if Effect then
            local Container = Effect:FindFirstChild("Container")
            if Container then
                local Death = Container:FindFirstChild("Death")
                local Respawn = Container:FindFirstChild("Respawn")
                
                if Death then
                    pcall(function()
                        hookfunction(require(Death), function() end)
                    end)
                end
                
                if Respawn then
                    pcall(function()
                        hookfunction(require(Respawn), function() end)
                    end)
                end
            end
        end
        
        local ClientRemotes = ReplicatedStorage:FindFirstChild("ClientRemotes")
        if ClientRemotes then
            local Respawned = ClientRemotes:FindFirstChild("Respawned")
            if Respawned and Respawned:IsA("RemoteEvent") then
                local conn
                conn = Respawned.OnClientEvent:Connect(function()
                end)
            end
        end
        
        AntiCheat.DeathRespawnHooked = true
    end)
    
    if success and AntiCheat.DeathRespawnHooked then
        print("[AntiCheat] Death/Respawn effects hooked")
    end
end

function AntiCheat.DisableWatchdogs()
    if AntiCheat.WatchdogsDisabled then return end
    
    pcall(function()
        local PlayerScripts = Player:FindFirstChild("PlayerScripts")
        if PlayerScripts then
            for _, script in pairs(PlayerScripts:GetDescendants()) do
                if script:IsA("LocalScript") or script:IsA("ModuleScript") then
                    local name = script.Name:lower()
                    if name:find("anticheat") or name:find("anti_cheat") or 
                       name:find("watchdog") or name:find("connections") or
                       name:find("antiexploit") or name:find("anti_exploit") or
                       name:find("security") or name:find("detector") then
                        if script:IsA("LocalScript") then
                            script.Disabled = true
                        end
                    end
                end
            end
        end
        
        local PlayerGui = Player:FindFirstChild("PlayerGui")
        if PlayerGui then
            for _, gui in pairs(PlayerGui:GetDescendants()) do
                if gui:IsA("LocalScript") then
                    local name = gui.Name:lower()
                    if name:find("anti") or name:find("security") or name:find("detect") then
                        gui.Disabled = true
                    end
                end
            end
        end
        
        local char = Player.Character
        if char then
            for _, script in pairs(char:GetDescendants()) do
                if script:IsA("LocalScript") then
                    local name = script.Name:lower()
                    if name:find("anti") then
                        script.Disabled = true
                    end
                end
            end
        end
        
        AntiCheat.WatchdogsDisabled = true
    end)
    
    if AntiCheat.WatchdogsDisabled then
        print("[AntiCheat] Watchdogs disabled")
    end
end

function AntiCheat.BlockExecutorProbes()
    if AntiCheat.ExecutorProbesBlocked then return end
    
    pcall(function()
        if getgenv then
            local oldGetgenv = getgenv
            getgenv = function()
                local env = oldGetgenv()
                local proxy = setmetatable({}, {
                    __index = function(_, k)
                        if k == "syn" or k == "fluxus" or k == "krnl" or 
                           k == "sentinel" or k == "scriptware" or k == "exploit" then
                            return nil
                        end
                        return env[k]
                    end,
                    __newindex = function(_, k, v)
                        env[k] = v
                    end
                })
                return proxy
            end
        end
        
        AntiCheat.ExecutorProbesBlocked = true
    end)
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
            local self = args[1]
            
            if method == "FireServer" then
                local remoteName = tostring(self)
                
                if remoteName:find("TeleportDetect") or remoteName:find("AntiTeleport") then
                    return nil
                end
                
                if AntiCheat.Skillaimbot and args[2] then
                    if type(args[2]) == "userdata" or type(args[2]) == "vector" then
                        args[2] = AntiCheat.AimBotSkillPosition
                        return AntiCheat.OldNamecall(unpack(args))
                    end
                end
            end
            
            if method == "InvokeServer" then
                local remoteName = tostring(self)
                if remoteName:find("AntiCheat") or remoteName:find("Security") then
                    return true
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

function AntiCheat.RegisterHitSafe(basePart, parts)
    local now = tick()
    if now - AntiCheat.LastHitTime < AntiCheat.HitCooldown then
        return false
    end
    AntiCheat.LastHitTime = now
    
    local success = pcall(function()
        local Net = ReplicatedStorage:FindFirstChild("Modules") and 
                    ReplicatedStorage.Modules:FindFirstChild("Net")
        
        if not Net then return end
        
        local RegisterHit = Net:FindFirstChild("RE/RegisterHit")
        local RegisterAttack = Net:FindFirstChild("RE/RegisterAttack")
        
        if RegisterAttack then
            RegisterAttack:FireServer()
        end
        
        if RegisterHit and basePart then
            local seed = AntiCheat.GetNetSeed()
            
            local userId = tostring(Player.UserId)
            local timeComponent = math.floor(Workspace:GetServerTimeNow() * 100) % 10000
            local uniqueId = bit32.bxor(tonumber(userId:sub(-4)) or 0, timeComponent, seed)
            
            RegisterHit:FireServer(basePart, parts, {}, tostring(uniqueId))
        end
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
                AntiCheat.SendMagnetHandshake(parts[1][1])
                AntiCheat.RegisterHitSafe(head, parts)
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

function AntiCheat.ProtectVelocity()
    pcall(function()
        local char = Player.Character
        if not char then return end
        
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local maxVelocity = 150
        
        RunService.Heartbeat:Connect(function()
            if root and root.Parent then
                local velocity = root.AssemblyLinearVelocity
                local speed = velocity.Magnitude
                
                if speed > maxVelocity and not _G.Flying then
                    local clampedVelocity = velocity.Unit * maxVelocity
                    root.AssemblyLinearVelocity = clampedVelocity
                end
            end
        end)
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
    AntiCheat.FindRemotes()
    AntiCheat.HookDeathRespawn()
    AntiCheat.DisableWatchdogs()
    AntiCheat.BlockExecutorProbes()
    AntiCheat.SetupMetatableHook()
    AntiCheat.SetupRemoteObfuscation()
    AntiCheat.DisableAntiTeleport()
    AntiCheat.ProtectVelocity()
    AntiCheat.AntiKick()
    
    Player.CharacterAdded:Connect(function(char)
        task.wait(1)
        AntiCheat.DisableWatchdogs()
        AntiCheat.DisableAntiTeleport()
        AntiCheat.ProtectVelocity()
    end)
    
    spawn(function()
        while true do
            if _G.FastAttack then
                pcall(AntiCheat.EnhancedFastAttack)
            end
            task.wait(0.08)
        end
    end)
    
    spawn(function()
        while true do
            pcall(AntiCheat.DisableSpeedCheck)
            pcall(AntiCheat.DisableWatchdogs)
            task.wait(5)
        end
    end)
    
    print("[AntiCheat] Comprehensive bypass systems initialized")
    print("[AntiCheat] Death/Respawn hook: " .. (AntiCheat.DeathRespawnHooked and "Active" or "N/A"))
    print("[AntiCheat] Watchdogs disabled: " .. (AntiCheat.WatchdogsDisabled and "Active" or "N/A"))
    print("[AntiCheat] Metatable hook: " .. (AntiCheat.MetatableHooked and "Active" or "N/A"))
    print("[AntiCheat] Remote obfuscation: " .. (AntiCheat.RemoteObfuscated and "Active" or "N/A"))
    print("[AntiCheat] Velocity protection: Active")
    print("[AntiCheat] Tweened teleports: Active")
end

_G.FastAttack = false

return AntiCheat
