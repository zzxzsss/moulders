

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
AntiCheat.HookMethodActive = false
AntiCheat.OldNamecall = nil
AntiCheat.BypassTP = true
AntiCheat.LastTeleportTime = 0
AntiCheat.TeleportCooldown = 0.1
AntiCheat.FakePosition = nil
AntiCheat.PositionSpoof = false

AntiCheat.CommE = nil
AntiCheat.CommF = nil
AntiCheat.HookedMethods = {}

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
    speed = speed or 500
    
    local startPos = root.Position
    local endPos = targetCFrame.Position
    local minHeight = 50
    
    local travelHeight = math.max(startPos.Y, endPos.Y, minHeight) + 30
    
    if humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    end
    
    local elevatedStart = CFrame.new(startPos.X, travelHeight, startPos.Z)
    local elevatedEnd = CFrame.new(endPos.X, travelHeight, endPos.Z)
    
    local function tweenTo(targetCF, onComplete)
        local currentPos = root.Position
        local dist = (currentPos - targetCF.Position).Magnitude
        if dist < 1 then
            if onComplete then onComplete() end
            return
        end
        
        local tweenTime = math.max(dist / speed, 0.1)
        local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(root, tweenInfo, {CFrame = targetCF})
        tween:Play()
        tween.Completed:Connect(function()
            if onComplete then onComplete() end
        end)
    end
    
    tweenTo(elevatedStart, function()
        local horizontalDist = (Vector3.new(startPos.X, 0, startPos.Z) - Vector3.new(endPos.X, 0, endPos.Z)).Magnitude
        local maxStepDistance = 450
        local steps = math.max(math.ceil(horizontalDist / maxStepDistance), 1)
        
        local direction = (Vector3.new(endPos.X, travelHeight, endPos.Z) - Vector3.new(startPos.X, travelHeight, startPos.Z))
        if direction.Magnitude > 0 then direction = direction.Unit end
        local stepSize = horizontalDist / steps
        
        local function doStep(stepIndex)
            if stepIndex > steps then
                tweenTo(targetCFrame, function()
                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                    if callback then callback(true) end
                end)
                return
            end
            
            local stepTarget
            if stepIndex == steps then
                stepTarget = elevatedEnd
            else
                local stepPos = Vector3.new(startPos.X, travelHeight, startPos.Z) + (direction * stepSize * stepIndex)
                stepTarget = CFrame.new(stepPos)
            end
            
            tweenTo(stepTarget, function()
                task.wait(0.02)
                doStep(stepIndex + 1)
            end)
        end
        
        doStep(1)
    end)
    
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

function AntiCheat.SetupHookMethod()
    AntiCheat.HookMethodActive = false
end

function AntiCheat.StartPositionSpoof()
    AntiCheat.PositionSpoof = true
    local char = Player.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            AntiCheat.FakePosition = root.CFrame
            AntiCheat.HookTarget = root
        end
    end
end

function AntiCheat.StopPositionSpoof()
    AntiCheat.PositionSpoof = false
end

function AntiCheat.UpdateFakePosition(cframe)
    AntiCheat.FakePosition = cframe
end

function AntiCheat.TweenWithSpoof(targetCFrame, speed, callback)
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
    
    AntiCheat.FakePosition = root.CFrame
    AntiCheat.PositionSpoof = true
    
    local result = AntiCheat.TweenTeleport(targetCFrame, speed, function(success)
        task.wait(0.5)
        AntiCheat.PositionSpoof = false
        AntiCheat.FakePosition = nil
        if callback then callback(success) end
    end)
    
    return result
end

function AntiCheat.NoClip(enabled)
    if enabled then
        if AntiCheat.NoClipConnection then return end
        
        AntiCheat.NoClipConnection = RunService.Stepped:Connect(function()
            pcall(function()
                local char = Player.Character
                if not char then return end
                
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        end)
    else
        if AntiCheat.NoClipConnection then
            AntiCheat.NoClipConnection:Disconnect()
            AntiCheat.NoClipConnection = nil
        end
    end
end

function AntiCheat.InfiniteJump(enabled)
    if enabled then
        if AntiCheat.InfJumpConnection then return end
        
        local UserInputService = game:GetService("UserInputService")
        AntiCheat.InfJumpConnection = UserInputService.JumpRequest:Connect(function()
            pcall(function()
                local humanoid = Player.Character and Player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end)
    else
        if AntiCheat.InfJumpConnection then
            AntiCheat.InfJumpConnection:Disconnect()
            AntiCheat.InfJumpConnection = nil
        end
    end
end

function AntiCheat.Start()
    AntiCheat.FindRemotes()
    AntiCheat.SetupMetatableHook()
    AntiCheat.SetupHookMethod()
    AntiCheat.DisableAntiTeleport()
    AntiCheat.ProtectVelocity()
    AntiCheat.AntiKick()
    AntiCheat.NoClip(true)
    AntiCheat.InfiniteJump(true)
    
    Player.CharacterAdded:Connect(function(char)
        task.wait(1)
        AntiCheat.SetupHookMethod()
        AntiCheat.DisableAntiTeleport()
        AntiCheat.ProtectVelocity()
        AntiCheat.NoClip(true)
    end)
    
    spawn(function()
        while true do
            pcall(AntiCheat.DisableSpeedCheck)
            task.wait(10)
        end
    end)
    
    print("[AntiCheat] Safe bypass systems initialized")
    print("[AntiCheat] Metatable hook: " .. (AntiCheat.MetatableHooked and "Active" or "N/A"))
    print("[AntiCheat] HookMethod: " .. (AntiCheat.HookMethodActive and "Active" or "N/A"))
    print("[AntiCheat] Position Spoof: Ready")
    print("[AntiCheat] NoClip: Active")
    print("[AntiCheat] Infinite Jump: Active")
    print("[AntiCheat] Velocity protection: Active")
    print("[AntiCheat] Tweened teleports: Active (Elevated)")
end

return AntiCheat
