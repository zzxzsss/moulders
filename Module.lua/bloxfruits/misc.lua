--[[
    Misc Module - Miscellaneous Features (Local Player, Settings, etc.)
    Blox Fruits Script by Zlex Hub (Modularized)
]]

local Misc = {}

local Utils = nil

function Misc.Init(utils)
    Utils = utils
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

Misc.HighlightFolder = nil

function Misc.AntiAFK()
    Player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

function Misc.WalkOnWater()
    if not _G.Settings.LocalPlayer["Walk On Water"] then return end
    
    local map = Workspace:FindFirstChild("Map")
    if map then
        local waterBase = map:FindFirstChild("WaterBase-Plane")
        if waterBase then
            waterBase.Size = Vector3.new(1000, 112, 1000)
        end
    end
end

function Misc.ResetWalkOnWater()
    local map = Workspace:FindFirstChild("Map")
    if map then
        local waterBase = map:FindFirstChild("WaterBase-Plane")
        if waterBase then
            waterBase.Size = Vector3.new(1000, 80, 1000)
        end
    end
end

function Misc.NoClip()
    if not _G.Settings.LocalPlayer["No Clip"] then return end
    
    local char = Player.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

function Misc.InfiniteJump()
    if not _G.Settings.LocalPlayer["Infinite Jump"] then return end
    
    UserInputService.JumpRequest:Connect(function()
        local humanoid = Utils.GetHumanoid()
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

function Misc.SetLighting(enabled)
    if enabled then
        Lighting.ClockTime = 12
    end
end

function Misc.IncreaseBoatSpeed()
    if not _G.Settings.SettingSea["Increase Speed Boat"] then return end
    
    local boats = Workspace:FindFirstChild("Boats")
    if boats then
        for _, boat in pairs(boats:GetDescendants()) do
            if boat:IsA("VehicleSeat") then
                boat.MaxSpeed = 350
            end
        end
    end
end

function Misc.ResetBoatSpeed()
    local boats = Workspace:FindFirstChild("Boats")
    if boats then
        for _, boat in pairs(boats:GetDescendants()) do
            if boat:IsA("VehicleSeat") then
                boat.MaxSpeed = 150
            end
        end
    end
end

function Misc.NoClipRock()
    if not _G.Settings.SettingSea["No Clip Rock"] then return end
    
    local boats = Workspace:FindFirstChild("Boats")
    if boats then
        for _, boat in pairs(boats:GetChildren()) do
            for _, part in pairs(boat:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end

function Misc.HighlightSelf()
    if not Misc.HighlightFolder then
        Misc.HighlightFolder = Instance.new("Folder")
        Misc.HighlightFolder.Name = "Highlight_Folder"
        Misc.HighlightFolder.Parent = game:GetService("CoreGui")
    end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = Player.Name
    highlight.FillColor = Color3.fromRGB(255, 255, 255)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillTransparency = 0.7
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.Parent = Misc.HighlightFolder
    
    if Player.Character then
        highlight.Adornee = Player.Character
    end
    
    Player.CharacterAdded:Connect(function(char)
        highlight.Adornee = char
    end)
end

function Misc.OptimizeRendering()
    UserInputService.WindowFocused:Connect(function()
        RunService:Set3dRenderingEnabled(true)
    end)
    
    UserInputService.WindowFocusReleased:Connect(function()
        RunService:Set3dRenderingEnabled(false)
    end)
end

function Misc.DragonDojoLoop()
    if not _G.Settings.DragonDojo["Auto Farm Blaze Ember"] then return end
    
    local emberTemplate = Workspace:FindFirstChild("EmberTemplate")
    if emberTemplate and emberTemplate:FindFirstChild("Part") then
        local hrp = Utils.GetHumanoidRootPart()
        if hrp then
            hrp.CFrame = emberTemplate.Part.CFrame * CFrame.new(0, 5, 0)
        end
    end
end

function Misc.KillLavaGolem()
    if not _G.Settings.DragonDojo["Auto Kill Lava Golem"] then return end
    
    local enemies = Workspace:FindFirstChild("Enemies")
    if enemies then
        for _, enemy in pairs(enemies:GetChildren()) do
            if enemy.Name == "Lava Golem" then
                local humanoid = enemy:FindFirstChild("Humanoid")
                local hrp = enemy:FindFirstChild("HumanoidRootPart")
                
                if humanoid and hrp and humanoid.Health > 0 then
                    Utils.AutoHaki()
                    Utils.EquipWeapon(_G.Settings.Main["Selected Weapon"])
                    Utils.TweenPlayer(hrp.CFrame * CFrame.new(0, 15, 0))
                    Utils.Attack()
                    return
                end
            end
        end
    end
end

function Misc.KillDragonCrew()
    if not _G.Settings.DragonDojo["Auto Kill Dragon Crew"] then return end
    
    local enemies = Workspace:FindFirstChild("Enemies")
    if enemies then
        for _, enemy in pairs(enemies:GetChildren()) do
            if string.find(enemy.Name, "Lava") or string.find(enemy.Name, "Dragon") then
                local humanoid = enemy:FindFirstChild("Humanoid")
                local hrp = enemy:FindFirstChild("HumanoidRootPart")
                
                if humanoid and hrp and humanoid.Health > 0 then
                    Utils.AutoHaki()
                    Utils.EquipWeapon(_G.Settings.Main["Selected Weapon"])
                    Utils.TweenPlayer(hrp.CFrame * CFrame.new(0, 15, 0))
                    Utils.Attack()
                    return
                end
            end
        end
    end
end

function Misc.Start()
    Misc.AntiAFK()
    Misc.HighlightSelf()
    Misc.OptimizeRendering()
    
    RunService.Stepped:Connect(function()
        if _G.Settings.LocalPlayer["No Clip"] then
            pcall(Misc.NoClip)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.LocalPlayer["Walk On Water"] then
                pcall(Misc.WalkOnWater)
            else
                pcall(Misc.ResetWalkOnWater)
            end
            task.wait(0.2)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.SettingSea["Lightning"] then
                pcall(function() Misc.SetLighting(true) end)
            end
            task.wait(0.1)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.SettingSea["Increase Speed Boat"] then
                pcall(Misc.IncreaseBoatSpeed)
            else
                pcall(Misc.ResetBoatSpeed)
            end
            task.wait(0.2)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.SettingSea["No Clip Rock"] then
                pcall(Misc.NoClipRock)
            end
            task.wait(0.2)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.DragonDojo["Auto Farm Blaze Ember"] then
                pcall(Misc.DragonDojoLoop)
            end
            task.wait(0.2)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.DragonDojo["Auto Kill Lava Golem"] then
                pcall(Misc.KillLavaGolem)
            end
            task.wait(0.1)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.DragonDojo["Auto Kill Dragon Crew"] then
                pcall(Misc.KillDragonCrew)
            end
            task.wait(0.1)
        end
    end)
end

return Misc
