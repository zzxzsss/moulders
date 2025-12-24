--[[
    Items Module - Item Collection (Fruits, Chests, Flowers, etc.)
    Blox Fruits Script by Zlex Hub (Modularized)
]]

local Items = {}

local Utils = nil

function Items.Init(utils)
    Utils = utils
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer

Items.FruitSpawnLocations = {
    CFrame.new(-12003.7, 374.8, -7604.5),
    CFrame.new(-7893.5, 5558.1, -1384.8),
    CFrame.new(5255.7, 6.9, -6638.5),
    CFrame.new(-5763.5, 70.7, 8871.5),
    CFrame.new(939.3, 20.6, 4374.3),
    CFrame.new(1060.7, 17.7, 1548.9),
    CFrame.new(-1596.5, 36.5, 152.2)
}

function Items.CollectDevilFruit()
    if not _G.Settings.Items["Collect Devil Fruit"] then return end
    
    local fruits = Workspace:FindFirstChild("DroppedFruit") or Workspace:FindFirstChild("Fruits")
    if not fruits then return end
    
    for _, fruit in pairs(fruits:GetChildren()) do
        if fruit:IsA("Model") or fruit:IsA("BasePart") then
            local fruitPart = fruit:IsA("BasePart") and fruit or fruit:FindFirstChild("Handle") or fruit:FindFirstChildWhichIsA("BasePart")
            if fruitPart then
                local dist = Utils.DistanceTo(fruitPart.Position)
                if dist < 500 then
                    local hrp = Utils.GetHumanoidRootPart()
                    if hrp then
                        Utils.TweenPlayer(fruitPart.CFrame * CFrame.new(0, 3, 0))
                        task.wait(0.3)
                        fireproximityprompt(fruit:FindFirstChildOfClass("ProximityPrompt"))
                    end
                end
            end
        end
    end
end

function Items.CollectChest()
    if not _G.Settings.Items["Collect Chest"] then return end
    
    local chestModels = Workspace:FindFirstChild("ChestModels")
    if not chestModels then return end
    
    for _, chest in pairs(chestModels:GetChildren()) do
        local chestPart = chest:FindFirstChild("Chest") or chest:FindFirstChildWhichIsA("BasePart")
        if chestPart then
            local dist = Utils.DistanceTo(chestPart.Position)
            if dist < 200 then
                local hrp = Utils.GetHumanoidRootPart()
                if hrp then
                    local oldCFrame = hrp.CFrame
                    hrp.CFrame = chestPart.CFrame * CFrame.new(0, 5, 0)
                    task.wait(0.3)
                    
                    local prompt = chest:FindFirstChildOfClass("ProximityPrompt")
                    if prompt then
                        fireproximityprompt(prompt)
                    end
                    
                    task.wait(0.1)
                    hrp.CFrame = oldCFrame
                end
            end
        end
    end
end

function Items.CollectFlower()
    if not _G.Settings.Items["Collect Flower"] then return end
    
    local flowers = Workspace:FindFirstChild("Flowers")
    if not flowers then return end
    
    for _, flower in pairs(flowers:GetChildren()) do
        local flowerPart = flower:IsA("BasePart") and flower or flower:FindFirstChildWhichIsA("BasePart")
        if flowerPart then
            local dist = Utils.DistanceTo(flowerPart.Position)
            if dist < 200 then
                local hrp = Utils.GetHumanoidRootPart()
                if hrp then
                    hrp.CFrame = flowerPart.CFrame * CFrame.new(0, 3, 0)
                    task.wait(0.2)
                    
                    local prompt = flower:FindFirstChildOfClass("ProximityPrompt")
                    if prompt then
                        fireproximityprompt(prompt)
                    end
                end
            end
        end
    end
end

function Items.CollectGun()
    if not _G.Settings.Items["Collect Gun"] then return end
    
    local guns = Workspace:FindFirstChild("DroppedGuns") or Workspace:FindFirstChild("Guns")
    if not guns then return end
    
    for _, gun in pairs(guns:GetChildren()) do
        local gunPart = gun:IsA("BasePart") and gun or gun:FindFirstChild("Handle") or gun:FindFirstChildWhichIsA("BasePart")
        if gunPart then
            local dist = Utils.DistanceTo(gunPart.Position)
            if dist < 200 then
                local hrp = Utils.GetHumanoidRootPart()
                if hrp then
                    hrp.CFrame = gunPart.CFrame * CFrame.new(0, 3, 0)
                    task.wait(0.2)
                end
            end
        end
    end
end

function Items.CollectBones()
    if not _G.Settings.Items["Collect Bones"] then return end
    
    local bones = Workspace:FindFirstChild("Bones")
    if not bones then return end
    
    for _, bone in pairs(bones:GetChildren()) do
        local bonePart = bone:IsA("BasePart") and bone or bone:FindFirstChildWhichIsA("BasePart")
        if bonePart then
            local dist = Utils.DistanceTo(bonePart.Position)
            if dist < 200 then
                local hrp = Utils.GetHumanoidRootPart()
                if hrp then
                    hrp.CFrame = bonePart.CFrame * CFrame.new(0, 3, 0)
                    task.wait(0.2)
                end
            end
        end
    end
end

function Items.StoreFruit()
    if not _G.Settings.Items["Auto Store Fruit"] then return end
    
    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and 
                  ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    if CommF then
        pcall(function()
            local backpack = Player:FindFirstChild("Backpack")
            if backpack then
                for _, item in pairs(backpack:GetChildren()) do
                    if item:IsA("Tool") and item.ToolTip == "Blox Fruit" then
                        CommF:InvokeServer("StoreFruit", item.Name)
                    end
                end
            end
        end)
    end
end

function Items.BuyRandomFruit()
    if not _G.Settings.Items["Auto Farm Random Fruit"] then return end
    
    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and 
                  ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    if CommF then
        pcall(function()
            CommF:InvokeServer("BuyFruit", "Random Fruit")
        end)
    end
end

function Items.Start()
    spawn(function()
        while true do
            if _G.Settings.Items["Collect Devil Fruit"] then
                pcall(Items.CollectDevilFruit)
            end
            task.wait(0.5)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.Items["Collect Chest"] then
                pcall(Items.CollectChest)
            end
            task.wait(0.5)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.Items["Collect Flower"] then
                pcall(Items.CollectFlower)
            end
            task.wait(0.5)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.Items["Collect Gun"] then
                pcall(Items.CollectGun)
            end
            task.wait(0.5)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.Items["Collect Bones"] then
                pcall(Items.CollectBones)
            end
            task.wait(0.5)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.Items["Auto Store Fruit"] then
                pcall(Items.StoreFruit)
            end
            task.wait(5)
        end
    end)
    
    spawn(function()
        while true do
            if _G.Settings.Items["Auto Farm Random Fruit"] then
                pcall(Items.BuyRandomFruit)
            end
            task.wait(1)
        end
    end)
end

return Items
