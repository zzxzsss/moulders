-- updated
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
AntiCheat.OldNamecall = nil
AntiCheat.BypassTP = true
AntiCheat.LastTeleportTime = 0
AntiCheat.TeleportCooldown = 0.1

AntiCheat.CommE = nil
AntiCheat.CommF = nil

function AntiCheat.FindRemotes()
    pcall(function()
        local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if Remotes then
            AntiCheat.CommE = Remotes:FindFirstChild("CommE")
            AntiCheat.CommF = Remotes:FindFirstChild("CommF")
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
        root.CFrame = targetCFrame
        return true
    elseif distance < 500 then
        local tweenInfo = TweenInfo.new(distance / 800, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(root, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        tween.Completed:Wait()
        return true
    else
        return AntiCheat.TweenTeleport(targetCFrame, 800)
    end
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
            
            if method == "FireServer" or method == "InvokeServer" then
                local remoteName = tostring(self):lower()
                
                if remoteName:find("antiteleport") or 
                   remoteName:find("teleportdetect") or
                   remoteName:find("antiexploit") or
                   remoteName:find("securitycheck") then
                    if method == "InvokeServer" then
                        return true
                    end
                    return nil
                end
            end
            
            if method == "FireServer" then
                if AntiCheat.Skillaimbot and args[2] then
                    if type(args[2]) == "userdata" or type(args[2]) == "vector" then
                        args[2] = AntiCheat.AimBotSkillPosition
                        return AntiCheat.OldNamecall(unpack(args))
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

function AntiCheat.DisableAntiTeleport()
    pcall(function()
        local antiTeleport = Player:FindFirstChild("AntiTeleport")
        if antiTeleport then
            antiTeleport:Destroy()
        end
    end)
end

function AntiCheat.ProtectVelocity()
    pcall(function()
        local char = Player.Character
        if not char then return end
        
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local maxVelocity = 200
        
        local connection
        connection = RunService.Heartbeat:Connect(function()
            if not root or not root.Parent then
                connection:Disconnect()
                return
            end
            
            local velocity = root.AssemblyLinearVelocity
            local speed = velocity.Magnitude
            
            if speed > maxVelocity and not _G.Flying then
                local clampedVelocity = velocity.Unit * maxVelocity
                root.AssemblyLinearVelocity = clampedVelocity
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

function AntiCheat.SetSkillAimbot(enabled, position)
    AntiCheat.Skillaimbot = enabled
    if position then
        AntiCheat.AimBotSkillPosition = position
    end
end

function AntiCheat.Start()
    AntiCheat.FindRemotes()
    AntiCheat.SetupMetatableHook()
    AntiCheat.DisableAntiTeleport()
    AntiCheat.ProtectVelocity()
    AntiCheat.AntiKick()
    
    Player.CharacterAdded:Connect(function(char)
        task.wait(1)
        AntiCheat.DisableAntiTeleport()
        AntiCheat.ProtectVelocity()
    end)
    
    spawn(function()
        while true do
            pcall(AntiCheat.DisableSpeedCheck)
            task.wait(10)
        end
    end)
    
    print("[AntiCheat] Safe bypass systems initialized")
    print("[AntiCheat] Metatable hook: " .. (AntiCheat.MetatableHooked and "Active" or "N/A"))
    print("[AntiCheat] Velocity protection: Active")
    print("[AntiCheat] Tweened teleports: Active")
    print("[AntiCheat] Quest/Combat: NOT BLOCKED (safe mode)")
end

return AntiCheat
