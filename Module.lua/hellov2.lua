local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer

local TARGET_FRUIT = _G.ZLEX_TARGET_FRUIT or nil

local function cancelSeaTeleport()
    pcall(function()
        for i = 1, 10 do
            local teleportGui = Player:FindFirstChild("PlayerGui") and Player.PlayerGui:FindFirstChild("Teleporting")
            if teleportGui then
                teleportGui:Destroy()
            end
            
            local loadingGui = Player.PlayerGui:FindFirstChild("Loading")
            if loadingGui then
                loadingGui:Destroy()
            end
            
            task.wait(0.5)
        end
    end)
    
    pcall(function()
        local oldTeleport = TeleportService.TeleportToPlaceInstance
        TeleportService.TeleportToPlaceInstance = function(self, placeId, instanceId, player)
            if player == Player and not _G.ZLEX_ALLOW_TELEPORT then
                return
            end
            return oldTeleport(self, placeId, instanceId, player)
        end
    end)
    
    pcall(function()
        local connection
        connection = Player.OnTeleport:Connect(function(state)
            if state == Enum.TeleportState.Started and not _G.ZLEX_ALLOW_TELEPORT then
                connection:Disconnect()
                return
            end
        end)
        
        task.delay(30, function()
            if connection then
                connection:Disconnect()
            end
        end)
    end)
end

local function bringFruit(fruitName)
    local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local found = false
    
    for _, v in pairs(workspace:GetChildren()) do
        if (v:IsA("Model") or v:IsA("Tool")) and v.Name:find("Fruit") then
            if not fruitName or v.Name:lower():find(fruitName:lower()) then
                local handle = v:FindFirstChild("Handle")
                local rootPart = v:FindFirstChild("RootPart")
                if handle then
                    pcall(function()
                        handle.CFrame = hrp.CFrame
                        if rootPart then rootPart.CFrame = hrp.CFrame end
                    end)
                    found = true
                end
            end
        end
    end
    
    local map = workspace:FindFirstChild("Map")
    if map then
        for _, v in pairs(map:GetDescendants()) do
            if (v:IsA("Model") or v:IsA("Tool")) and v.Name:find("Fruit") then
                if not fruitName or v.Name:lower():find(fruitName:lower()) then
                    local handle = v:FindFirstChild("Handle")
                    local rootPart = v:FindFirstChild("RootPart")
                    if handle then
                        pcall(function()
                            handle.CFrame = hrp.CFrame
                            if rootPart then rootPart.CFrame = hrp.CFrame end
                        end)
                        found = true
                    end
                end
            end
        end
    end
    
    return found
end

cancelSeaTeleport()

spawn(function()
    for i = 1, 60 do
        local found = bringFruit(TARGET_FRUIT)
        if found then
            print("[Zlex Hub] Found and brought fruit: " .. (TARGET_FRUIT or "Any"))
        end
        bringFruit(nil)
        task.wait(0.5)
    end
end)

print("[Zlex Hub] Fruit Collector loaded! Target: " .. (TARGET_FRUIT or "All Fruits"))
