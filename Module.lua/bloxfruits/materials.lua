--[[
    Materials Module - Material Farming (Ectoplasm, Fish Tail, etc.)
    Blox Fruits Script by Zlex Hub (Modularized)
]]

local Materials = {}

local Utils = nil

function Materials.Init(utils)
    Utils = utils
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer

Materials.MaterialMonsters = {
    {Material = "Ectoplasm", Monster = "Zombie", World = 2, CFrame = CFrame.new(-5570.4, 48.5, -784.4)},
    {Material = "Ectoplasm", Monster = "Vampire", World = 2, CFrame = CFrame.new(-5875.5, 36.3, -839.1)},
    {Material = "Fish Tail", Monster = "Fishman Warrior", World = 1, CFrame = CFrame.new(61075.4, 18.4, 1560.3)},
    {Material = "Fish Tail", Monster = "Fishman Commando", World = 1, CFrame = CFrame.new(61324.0, 51.8, 1097.9)},
    {Material = "Magma Ore", Monster = "Military Soldier", World = 1, CFrame = CFrame.new(-5333.1, 12.6, 8523.1)},
    {Material = "Magma Ore", Monster = "Military Spy", World = 1, CFrame = CFrame.new(-5757.3, 70.7, 8871.5)},
    {Material = "Dragon Scale", Monster = "Lava Demon", World = 3, CFrame = CFrame.new(-9842.5, 340.5, 6253.7)},
    {Material = "Dragon Scale", Monster = "Lava Monk", World = 3, CFrame = CFrame.new(-9649.4, 340.5, 6510.9)},
    {Material = "Scrap Metal", Monster = "Factory Staff", World = 2, CFrame = CFrame.new(646.4, 39.7, -151.6)},
    {Material = "Vampire Fang", Monster = "Vampire", World = 2, CFrame = CFrame.new(-5875.5, 36.3, -839.1)},
    {Material = "Mystic Droplet", Monster = "Water Fighter", World = 2, CFrame = CFrame.new(-3545.6, 237.0, -10104.9)},
    {Material = "Bone", Monster = "Reborn Skeleton", World = 3, CFrame = CFrame.new(-10969.5, 331.8, -8578.5)},
    {Material = "Leather", Monster = "Captain Elephant", World = 3, CFrame = CFrame.new(5343.2, 601.6, -106.8)},
    {Material = "Wings", Monster = "Sky Bandit", World = 1, CFrame = CFrame.new(-4855.7, 717.8, -2660.2)},
    {Material = "Core", Monster = "Magma Ninja", World = 2, CFrame = CFrame.new(-5439.8, 21.3, 8439.7)}
}

function Materials.GetMaterialData(materialName)
    for _, mat in ipairs(Materials.MaterialMonsters) do
        if mat.Material == materialName then
            return mat
        end
    end
    return nil
end

function Materials.FindMonster(monsterName)
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then return nil end
    
    for _, enemy in pairs(enemies:GetChildren()) do
        if enemy.Name == monsterName then
            local humanoid = enemy:FindFirstChild("Humanoid")
            local hrp = enemy:FindFirstChild("HumanoidRootPart")
            if humanoid and hrp and humanoid.Health > 0 then
                return enemy
            end
        end
    end
    return nil
end

function Materials.FarmMaterial(materialName)
    local matData = Materials.GetMaterialData(materialName)
    if not matData then return end
    
    local currentWorld = Utils.GetWorld()
    if matData.World ~= currentWorld then return end
    
    local monster = Materials.FindMonster(matData.Monster)
    
    if monster then
        local hrp = monster:FindFirstChild("HumanoidRootPart")
        local humanoid = monster:FindFirstChild("Humanoid")
        
        if hrp and humanoid and humanoid.Health > 0 then
            Utils.AutoHaki()
            Utils.EquipWeapon(_G.Settings.Main["Selected Weapon"])
            
            if _G.Settings.Main["Bring Monster"] then
                local playerHRP = Utils.GetHumanoidRootPart()
                if playerHRP then
                    hrp.CFrame = playerHRP.CFrame * CFrame.new(0, 0, 3)
                end
            else
                Utils.TweenPlayer(hrp.CFrame * CFrame.new(0, 15, 0))
            end
            
            Utils.Attack()
        end
    else
        local dist = Utils.DistanceTo(matData.CFrame.Position)
        if dist > 2000 then
            Utils.BTP(matData.CFrame)
        else
            Utils.TweenPlayer(matData.CFrame)
        end
    end
end

function Materials.EctoplasmLoop()
    if not _G.Settings.Materials["Auto Farm Ectoplasm"] then return end
    if not Utils.IsAlive() then return end
    Materials.FarmMaterial("Ectoplasm")
end

function Materials.FishTailLoop()
    if not _G.Settings.Materials["Auto Farm Fish Tail"] then return end
    if not Utils.IsAlive() then return end
    Materials.FarmMaterial("Fish Tail")
end

function Materials.MagmaOreLoop()
    if not _G.Settings.Materials["Auto Farm Magma Ore"] then return end
    if not Utils.IsAlive() then return end
    Materials.FarmMaterial("Magma Ore")
end

function Materials.DragonScaleLoop()
    if not _G.Settings.Materials["Auto Farm Dragon Scale"] then return end
    if not Utils.IsAlive() then return end
    Materials.FarmMaterial("Dragon Scale")
end

function Materials.ScrapMetalLoop()
    if not _G.Settings.Materials["Auto Farm Scrap Metal"] then return end
    if not Utils.IsAlive() then return end
    Materials.FarmMaterial("Scrap Metal")
end

function Materials.VampireFangLoop()
    if not _G.Settings.Materials["Auto Farm Vampire Fang"] then return end
    if not Utils.IsAlive() then return end
    Materials.FarmMaterial("Vampire Fang")
end

function Materials.MysticDropletLoop()
    if not _G.Settings.Materials["Auto Farm Mystic Droplet"] then return end
    if not Utils.IsAlive() then return end
    Materials.FarmMaterial("Mystic Droplet")
end

function Materials.BoneLoop()
    if not _G.Settings.Materials["Auto Farm Bone"] then return end
    if not Utils.IsAlive() then return end
    Materials.FarmMaterial("Bone")
end

function Materials.LeatherLoop()
    if not _G.Settings.Materials["Auto Farm Leather"] then return end
    if not Utils.IsAlive() then return end
    Materials.FarmMaterial("Leather")
end

function Materials.WingsLoop()
    if not _G.Settings.Materials["Auto Farm Wings"] then return end
    if not Utils.IsAlive() then return end
    Materials.FarmMaterial("Wings")
end

function Materials.CoreLoop()
    if not _G.Settings.Materials["Auto Farm Core"] then return end
    if not Utils.IsAlive() then return end
    Materials.FarmMaterial("Core")
end

function Materials.Start()
    local materialLoops = {
        {Setting = "Auto Farm Ectoplasm", Func = Materials.EctoplasmLoop},
        {Setting = "Auto Farm Fish Tail", Func = Materials.FishTailLoop},
        {Setting = "Auto Farm Magma Ore", Func = Materials.MagmaOreLoop},
        {Setting = "Auto Farm Dragon Scale", Func = Materials.DragonScaleLoop},
        {Setting = "Auto Farm Scrap Metal", Func = Materials.ScrapMetalLoop},
        {Setting = "Auto Farm Vampire Fang", Func = Materials.VampireFangLoop},
        {Setting = "Auto Farm Mystic Droplet", Func = Materials.MysticDropletLoop},
        {Setting = "Auto Farm Bone", Func = Materials.BoneLoop},
        {Setting = "Auto Farm Leather", Func = Materials.LeatherLoop},
        {Setting = "Auto Farm Wings", Func = Materials.WingsLoop},
        {Setting = "Auto Farm Core", Func = Materials.CoreLoop}
    }
    
    for _, loop in ipairs(materialLoops) do
        spawn(function()
            while true do
                if _G.Settings.Materials[loop.Setting] then
                    pcall(loop.Func)
                end
                task.wait(0.1)
            end
        end)
    end
end

return Materials
