--[[
    Utils Module - Core Utility Functions
    Blox Fruits Script by Zlex Hub (Modularized)
]]

local Utils = {}

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

Utils.CurrentTween = nil
Utils.Pos = CFrame.new(0, 15, 0)

function Utils.GetCharacter()
    return Player.Character or Player.CharacterAdded:Wait()
end

function Utils.GetHumanoidRootPart()
    local char = Utils.GetCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

function Utils.GetHumanoid()
    local char = Utils.GetCharacter()
    return char and char:FindFirstChild("Humanoid")
end

function Utils.IsAlive()
    local humanoid = Utils.GetHumanoid()
    return humanoid and humanoid.Health > 0
end

function Utils.TweenPlayer(targetCFrame, speed)
    speed = speed or _G.Settings.Setting["Tween Speed"] or 200
    local hrp = Utils.GetHumanoidRootPart()
    if not hrp then return nil end
    
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local tweenTime = distance / speed
    
    if Utils.CurrentTween then
        Utils.CurrentTween:Cancel()
    end
    
    local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    Utils.CurrentTween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
    Utils.CurrentTween:Play()
    
    return Utils.CurrentTween
end

function Utils.BTP(targetCFrame)
    local hrp = Utils.GetHumanoidRootPart()
    if hrp then
        hrp.CFrame = targetCFrame
    end
end

function Utils.SafeTeleport(targetCFrame, speed)
    speed = speed or _G.Settings.Setting["Tween Speed"] or 500
    local hrp = Utils.GetHumanoidRootPart()
    if not hrp then return false end
    
    local humanoid = Utils.GetHumanoid()
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    
    if distance < 50 then
        hrp.CFrame = targetCFrame
        return true
    end
    
    local maxStepDistance = 400
    local steps = math.ceil(distance / maxStepDistance)
    
    if steps <= 1 then
        local tweenTime = distance / speed
        local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
        
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        end
        
        if Utils.CurrentTween then
            Utils.CurrentTween:Cancel()
        end
        
        Utils.CurrentTween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
        Utils.CurrentTween:Play()
        Utils.CurrentTween.Completed:Wait()
        
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
        return true
    end
    
    local startPos = hrp.Position
    local endPos = targetCFrame.Position
    local direction = (endPos - startPos).Unit
    local stepSize = distance / steps
    
    if humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    end
    
    for i = 1, steps do
        if not hrp or not hrp.Parent then break end
        
        local stepTarget
        if i == steps then
            stepTarget = targetCFrame
        else
            local stepPos = startPos + (direction * stepSize * i)
            stepTarget = CFrame.new(stepPos) * (targetCFrame - targetCFrame.Position)
        end
        
        local stepTweenTime = stepSize / speed
        local tweenInfo = TweenInfo.new(stepTweenTime, Enum.EasingStyle.Linear)
        
        if Utils.CurrentTween then
            Utils.CurrentTween:Cancel()
        end
        
        Utils.CurrentTween = TweenService:Create(hrp, tweenInfo, {CFrame = stepTarget})
        Utils.CurrentTween:Play()
        Utils.CurrentTween.Completed:Wait()
        
        task.wait(0.02)
    end
    
    if humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
    
    return true
end

function Utils.StopTween(condition)
    if not condition and Utils.CurrentTween then
        Utils.CurrentTween:Cancel()
        Utils.CurrentTween = nil
    end
end

function Utils.EquipWeapon(weaponType)
    local char = Utils.GetCharacter()
    if not char then return end
    
    local backpack = Player:FindFirstChild("Backpack")
    if not backpack then return end
    
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.ToolTip == weaponType then
            local humanoid = Utils.GetHumanoid()
            if humanoid then
                humanoid:EquipTool(tool)
            end
            return true
        end
    end
    return false
end

function Utils.GetEquippedWeapon()
    local char = Utils.GetCharacter()
    if char then
        return char:FindFirstChildOfClass("Tool")
    end
    return nil
end

function Utils.AutoHaki()
    if not _G.Settings.Setting["Auto Haki"] then return end
    
    local char = Utils.GetCharacter()
    if not char then return end
    
    if not char:FindFirstChild("HasBuso") then
        local CommF = ReplicatedStorage:FindFirstChild("Remotes") and 
                      ReplicatedStorage.Remotes:FindFirstChild("CommF_")
        if CommF then
            pcall(function()
                CommF:InvokeServer("Buso")
            end)
        end
    end
end

function Utils.Click()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:Button1Down(Vector2.new(1280, 672))
    end)
end

function Utils.Attack()
    Utils.Click()
end

function Utils.PressKey(key)
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    task.wait()
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

function Utils.DistanceTo(position)
    local hrp = Utils.GetHumanoidRootPart()
    if hrp then
        return (hrp.Position - position).Magnitude
    end
    return math.huge
end

function Utils.GetWorld()
    local placeId = game.PlaceId
    if placeId == 2753915549 then
        return 1
    elseif placeId == 4442272183 then
        return 2
    elseif placeId == 7449423635 then
        return 3
    end
    return 1
end

Utils.World1 = Utils.GetWorld() == 1
Utils.World2 = Utils.GetWorld() == 2
Utils.World3 = Utils.GetWorld() == 3

function Utils.GetPlayerLevel()
    local data = Player:FindFirstChild("Data")
    if data then
        local level = data:FindFirstChild("Level")
        if level then
            return level.Value
        end
    end
    return 0
end

function Utils.GetPlayerStats()
    local data = Player:FindFirstChild("Data")
    if not data then return nil end
    
    return {
        Level = data:FindFirstChild("Level") and data.Level.Value or 0,
        Beli = data:FindFirstChild("Beli") and data.Beli.Value or 0,
        Fragments = data:FindFirstChild("Fragments") and data.Fragments.Value or 0,
        Race = data:FindFirstChild("Race") and data.Race.Value or "Unknown"
    }
end

function Utils.TweenBoat(targetCFrame)
    local speed = _G.Settings.SeaEvent["Boat Tween Speed"] or 200
    local boats = game:GetService("Workspace"):FindFirstChild("Boats")
    if not boats then return nil end
    
    for _, boat in pairs(boats:GetChildren()) do
        if boat.Name == _G.Settings.SeaEvent["Selected Boat"] then
            local vehicleSeat = boat:FindFirstChild("VehicleSeat")
            if vehicleSeat then
                local distance = (vehicleSeat.Position - targetCFrame.Position).Magnitude
                local tweenTime = distance / speed
                local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
                local tween = TweenService:Create(vehicleSeat, tweenInfo, {CFrame = targetCFrame})
                tween:Play()
                return tween
            end
        end
    end
    return nil
end

function Utils.GetMonsterByName(name)
    local enemies = game:GetService("Workspace"):FindFirstChild("Enemies")
    if not enemies then return nil end
    
    for _, enemy in pairs(enemies:GetChildren()) do
        if enemy.Name == name then
            local humanoid = enemy:FindFirstChild("Humanoid")
            local hrp = enemy:FindFirstChild("HumanoidRootPart")
            if humanoid and hrp and humanoid.Health > 0 then
                return enemy
            end
        end
    end
    return nil
end

function Utils.GetNearestMonster(targetName, maxDistance)
    maxDistance = maxDistance or math.huge
    local enemies = game:GetService("Workspace"):FindFirstChild("Enemies")
    if not enemies then return nil end
    
    local nearest = nil
    local nearestDist = maxDistance
    
    for _, enemy in pairs(enemies:GetChildren()) do
        if not targetName or enemy.Name == targetName then
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
    end
    return nearest, nearestDist
end

function Utils.ServerHop()
    local TeleportService = game:GetService("TeleportService")
    local HttpService = game:GetService("HttpService")
    
    pcall(function()
        local servers = HttpService:JSONDecode(
            game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
        )
        
        for _, server in pairs(servers.data) do
            if server.id ~= game.JobId and server.playing < server.maxPlayers then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id)
                break
            end
        end
    end)
end

function Utils.Rejoin()
    local TeleportService = game:GetService("TeleportService")
    TeleportService:Teleport(game.PlaceId, Player)
end

function Utils.InvokeServer(...)
    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and 
                  ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    if CommF then
        return CommF:InvokeServer(...)
    end
    return nil
end

function Utils.FireServer(...)
    local CommE = ReplicatedStorage:FindFirstChild("Remotes") and 
                  ReplicatedStorage.Remotes:FindFirstChild("CommE")
    if CommE then
        CommE:FireServer(...)
    end
end

function Utils.AntiAFK()
    local VirtualUser = game:GetService("VirtualUser")
    Player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

function Utils.NoClip()
    if _G.Settings.LocalPlayer["No Clip"] then
        local char = Utils.GetCharacter()
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end

RunService.Stepped:Connect(function()
    if _G.Settings and _G.Settings.LocalPlayer and _G.Settings.LocalPlayer["No Clip"] then
        Utils.NoClip()
    end
end)

return Utils
