--[[
    Fast Attack Module - FastAttack System for Combat
    Blox Fruits Script by Zlex Hub (Modularized)
    
    FIXED: Now loads external FastAttack script like original working scripts
    The external script properly handles CombatFramework integration
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
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")

local Player = Players.LocalPlayer

FastAttack.Enabled = true
FastAttack.ExternalLoaded = false

function FastAttack.Click()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:Button1Down(Vector2.new(1280, 672))
    end)
end

function FastAttack.LoadExternalFastAttack()
    if FastAttack.ExternalLoaded then return true end
    
    local success = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AnhTuanDzai-Hub/FastAttackLoL/refs/heads/main/FastAttack.lua"))()
    end)
    
    if success then
        FastAttack.ExternalLoaded = true
        print("[FastAttack] External FastAttack script loaded successfully")
        return true
    else
        warn("[FastAttack] Failed to load external FastAttack, using fallback")
        return false
    end
end

function FastAttack.FallbackAttack()
    FastAttack.Click()
end

function FastAttack.AttackNearest()
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then return end
    
    local character = Player.Character
    if not character then return end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    for _, enemy in pairs(enemies:GetChildren()) do
        local enemyHRP = enemy:FindFirstChild("HumanoidRootPart")
        local enemyHum = enemy:FindFirstChild("Humanoid")
        
        if enemyHRP and enemyHum and enemyHum.Health > 0 then
            if (enemyHRP.Position - hrp.Position).Magnitude <= 60 then
                FastAttack.Click()
                return
            end
        end
    end
end

function FastAttack.Start()
    FastAttack.LoadExternalFastAttack()
    
    spawn(function()
        while true do
            if _G.FastAttack then
                pcall(FastAttack.AttackNearest)
            end
            task.wait(0.08)
        end
    end)
    
    print("[FastAttack] FastAttack module started")
end

_G.FastAttack = false

return FastAttack
