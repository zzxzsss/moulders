--[[
    ESP Module - ESP for Players, Enemies, Items
    Blox Fruits Script by Zlex Hub (Modularized)
]]

local ESP = {}

local Utils = nil

function ESP.Init(utils)
    Utils = utils
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

ESP.ESPFolder = nil
ESP.ESPConnections = {}

function ESP.CreateESPFolder()
    if not ESP.ESPFolder then
        ESP.ESPFolder = Instance.new("Folder")
        ESP.ESPFolder.Name = "ESP_Folder"
        ESP.ESPFolder.Parent = game:GetService("CoreGui")
    end
    return ESP.ESPFolder
end

function ESP.CreateESP(target, name, color)
    if not target then return nil end
    
    local existingESP = target:FindFirstChild("ESP_Billboard")
    if existingESP then
        return existingESP
    end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Adornee = target
    billboard.Parent = ESP.CreateESPFolder()
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "ESPText"
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 14
    textLabel.TextStrokeTransparency = 0.5
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.Text = name or "Unknown"
    textLabel.Parent = billboard
    
    return billboard
end

function ESP.RemoveESP(target)
    if target then
        local esp = target:FindFirstChild("ESP_Billboard")
        if esp then
            esp:Destroy()
        end
    end
end

function ESP.UpdateDistance(billboard, target)
    if billboard and target then
        local textLabel = billboard:FindFirstChild("ESPText")
        if textLabel then
            local hrp = Utils.GetHumanoidRootPart()
            if hrp then
                local dist = (hrp.Position - target.Position).Magnitude
                local baseName = textLabel.Text:match("^(.-)%s*%[") or textLabel.Text
                textLabel.Text = baseName .. " [" .. math.floor(dist) .. "m]"
            end
        end
    end
end

function ESP.PlayerESP()
    if not _G.Settings.ESP["Player ESP"] then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Player and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                ESP.CreateESP(hrp, player.Name, Color3.fromRGB(0, 255, 0))
            end
        end
    end
end

function ESP.NPCEsp()
    if not _G.Settings.ESP["NPC ESP"] then return end
    
    local enemies = Workspace:FindFirstChild("Enemies")
    if enemies then
        for _, enemy in pairs(enemies:GetChildren()) do
            local hrp = enemy:FindFirstChild("HumanoidRootPart")
            local humanoid = enemy:FindFirstChild("Humanoid")
            if hrp and humanoid and humanoid.Health > 0 then
                ESP.CreateESP(hrp, enemy.Name, Color3.fromRGB(255, 0, 0))
            end
        end
    end
end

function ESP.BossESP()
    if not _G.Settings.ESP["Boss ESP"] then return end
    
    local enemies = Workspace:FindFirstChild("Enemies")
    if enemies then
        for _, enemy in pairs(enemies:GetChildren()) do
            local humanoid = enemy:FindFirstChild("Humanoid")
            local hrp = enemy:FindFirstChild("HumanoidRootPart")
            
            if humanoid and hrp and humanoid.Health > 0 then
                if humanoid.MaxHealth > 50000 then
                    ESP.CreateESP(hrp, "[BOSS] " .. enemy.Name, Color3.fromRGB(255, 165, 0))
                end
            end
        end
    end
end

function ESP.DevilFruitESP()
    if not _G.Settings.ESP["Devil Fruit ESP"] then return end
    
    local fruits = Workspace:FindFirstChild("DroppedFruit") or Workspace:FindFirstChild("Fruits")
    if fruits then
        for _, fruit in pairs(fruits:GetChildren()) do
            local part = fruit:IsA("BasePart") and fruit or fruit:FindFirstChild("Handle") or fruit:FindFirstChildWhichIsA("BasePart")
            if part then
                ESP.CreateESP(part, "[FRUIT] " .. fruit.Name, Color3.fromRGB(128, 0, 128))
            end
        end
    end
end

function ESP.ChestESP()
    if not _G.Settings.ESP["Chest ESP"] then return end
    
    local chestModels = Workspace:FindFirstChild("ChestModels")
    if chestModels then
        for _, chest in pairs(chestModels:GetChildren()) do
            local part = chest:FindFirstChild("Chest") or chest:FindFirstChildWhichIsA("BasePart")
            if part then
                ESP.CreateESP(part, "[CHEST]", Color3.fromRGB(255, 215, 0))
            end
        end
    end
end

function ESP.FlowerESP()
    if not _G.Settings.ESP["Flower ESP"] then return end
    
    local flowers = Workspace:FindFirstChild("Flowers")
    if flowers then
        for _, flower in pairs(flowers:GetChildren()) do
            local part = flower:IsA("BasePart") and flower or flower:FindFirstChildWhichIsA("BasePart")
            if part then
                ESP.CreateESP(part, "[FLOWER] " .. flower.Name, Color3.fromRGB(255, 105, 180))
            end
        end
    end
end

function ESP.SeaBeastESP()
    if not _G.Settings.ESP["Sea Beast ESP"] then return end
    
    local seaBeasts = Workspace:FindFirstChild("SeaBeasts")
    if seaBeasts then
        for _, beast in pairs(seaBeasts:GetChildren()) do
            local hrp = beast:FindFirstChild("HumanoidRootPart")
            local humanoid = beast:FindFirstChild("Humanoid")
            if hrp and humanoid and humanoid.Health > 0 then
                ESP.CreateESP(hrp, "[SEA BEAST]", Color3.fromRGB(0, 191, 255))
            end
        end
    end
end

function ESP.ClearAllESP()
    if ESP.ESPFolder then
        ESP.ESPFolder:ClearAllChildren()
    end
    
    for _, connection in pairs(ESP.ESPConnections) do
        connection:Disconnect()
    end
    ESP.ESPConnections = {}
end

function ESP.RefreshESP()
    ESP.ClearAllESP()
    
    ESP.PlayerESP()
    ESP.NPCEsp()
    ESP.BossESP()
    ESP.DevilFruitESP()
    ESP.ChestESP()
    ESP.FlowerESP()
    ESP.SeaBeastESP()
end

function ESP.Start()
    ESP.CreateESPFolder()
    
    spawn(function()
        while true do
            local anyESPEnabled = _G.Settings.ESP["Player ESP"] or
                                  _G.Settings.ESP["NPC ESP"] or
                                  _G.Settings.ESP["Boss ESP"] or
                                  _G.Settings.ESP["Devil Fruit ESP"] or
                                  _G.Settings.ESP["Chest ESP"] or
                                  _G.Settings.ESP["Flower ESP"] or
                                  _G.Settings.ESP["Sea Beast ESP"]
            
            if anyESPEnabled then
                pcall(ESP.RefreshESP)
            else
                ESP.ClearAllESP()
            end
            
            task.wait(1)
        end
    end)
end

return ESP
