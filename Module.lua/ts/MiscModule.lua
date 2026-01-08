

local MiscModule = {}

--// Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

--// Local Player
local LocalPlayer = Players.LocalPlayer

--// World Check
local First_Sea = false
local Second_Sea = false
local Third_Sea = false
local placeId = game.PlaceId
if placeId == 2753915549 then
    First_Sea = true
elseif placeId == 4442272183 then
    Second_Sea = true
elseif placeId == 7449423635 then
    Third_Sea = true
end

MiscModule.First_Sea = First_Sea
MiscModule.Second_Sea = Second_Sea
MiscModule.Third_Sea = Third_Sea

--// PVP State Variables
MiscModule.TweenToPlayer = false
MiscModule.AimbotSkillPlayer = false
MiscModule.Spectate = false
MiscModule.FastAttackPlayer = false
MiscModule.TpBehindPlayer = false

--// ESP State Variables
MiscModule.ESP_Player = false
MiscModule.ESP_Enemy = false
MiscModule.ESP_NPC = false
MiscModule.ESP_Fruit = false
MiscModule.ESP_Flower = false
MiscModule.ESP_Chest = false
MiscModule.ESP_Island = false
MiscModule.ESP_SeaBeast = false

--// Settings State Variables
MiscModule.InfiniteJump = false
MiscModule.NoClip = false
MiscModule.AntiAfk = false
MiscModule.FullBright = false
MiscModule.FlyEnabled = false
MiscModule.AutoRejoin = false

--// PVP Variables
SelectedPlayer = ""
SelectWeaponPvp = "Melee"
DisPvp = 10
Pvp_Mode = CFrame.new(0, 10, 0)
Player_Name = ""
Player_Position = Vector3.new(0, 0, 0)

--// Teleport Variables
BypassTeleport = false
SelectedIsland = ""
SelectedNPC = ""

function MiscModule.Tween(cf)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local tween = TweenService:Create(hrp, TweenInfo.new((hrp.Position - cf.Position).Magnitude / 300, Enum.EasingStyle.Linear), {CFrame = cf})
    tween:Play()
    return tween
end

function MiscModule.BTP(cf)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = cf
    end
end

function MiscModule.TP2(cf)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = cf
    end
end

function MiscModule.CancelTween(toggle)
    if not toggle then
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Anchored = false
        end
    end
end

function MiscModule.EquipTool(toolName)
    pcall(function()
        if LocalPlayer.Backpack:FindFirstChild(toolName) then
            LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack[toolName])
        end
    end)
end

function MiscModule.AutoClick()
    pcall(function()
        if LocalPlayer.Character:FindFirstChildOfClass("Tool") then
            LocalPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
        end
    end)
end


if First_Sea then
    MiscModule.IslandCheck = {
        "Start Island",
        "Marine Start",
        "Middle Town",
        "Jungle",
        "Pirate Village",
        "Desert",
        "Frozen Village",
        "Marine Ford",
        "Colosseum 1",
        "Sky island 1",
        "Sky island 2",
        "Sky island 3",
        "Sky island 4",
        "Prison",
        "Magma Village",
        "UndeyWater City",
        "Fountain City",
        "House Cyborgs",
        "Shanks Room",
        "Mob Island",
        "Sea Beast"
    }
elseif Second_Sea then
    MiscModule.IslandCheck = {
        "Dock",
        "Kingdom of Rose",
        "Mansion 1",
        "Flamingo Room",
        "Green Zone",
        "Cafe",
        "Factory",
        "Colosseum 2",
        "Grave Island",
        "Snow Mountain",
        "Cold Island",
        "Hot Island",
        "Cursed Ship",
        "Ice Castle",
        "Forgotten Island",
        "Usoapp Island",
        "Minisky Island",
        "Sea Beast"
    }
elseif Third_Sea then
    MiscModule.IslandCheck = {
        "Port Town",
        "Hydra Island",
        "Great Tree",
        "Castle on the Sea",
        "Floating Turtle",
        "Mansion 2",
        "Secret Temple",
        "Friendly Arena",
        "Beautiful Pirate Domain",
        "Teler Park",
        "Peanut Island",
        "Chocolate Island",
        "Ice Cream Island",
        "Haunted Castle",
        "Cake Loaf",
        "Candy Cane",
        "Tiki Outpost",
        "Raid Lab",
        "Mini Sky",
        "Sea Beast"
    }
else
    MiscModule.IslandCheck = {}
end


MiscModule.IslandPositions = {
    -- First Sea
    ["Start Island"] = CFrame.new(1071.2832, 16.3085976, 1426.86792, 0.889920831, 0, -0.456102133, 0, 1, 0, 0.456102133, 0, 0.889920831),
    ["Marine Start"] = CFrame.new(-2573.3374, 6.88881969, 2046.99817, 0.917263865, 0, 0.398291767, 0, 1, 0, -0.398291767, 0, 0.917263865),
    ["Middle Town"] = CFrame.new(-655.824158, 7.88708115, 1436.67908, -0.99869591, 0, 0.0510543622, 0, 1, 0, -0.0510543622, 0, -0.99869591),
    ["Jungle"] = CFrame.new(-1249.77222, 11.8870859, 341.356476, 0.972074091, 0, -0.234624594, 0, 1, 0, 0.234624594, 0, 0.972074091),
    ["Pirate Village"] = CFrame.new(-1122.34998, 4.78708982, 3855.91992, -0.720952749, 0, -0.692977965, 0, 1, 0, 0.692977965, 0, -0.720952749),
    ["Desert"] = CFrame.new(1094.14587, 6.47350502, 4192.88721, 0.783928573, 0, 0.620860636, 0, 1, 0, -0.620860636, 0, 0.783928573),
    ["Frozen Village"] = CFrame.new(1198.00928, 27.0074959, -1211.73376, 0.972074091, 0, -0.234624594, 0, 1, 0, 0.234624594, 0, 0.972074091),
    ["Marine Ford"] = CFrame.new(-4505.375, 20.687294, 4260.55908, -0.0217350088, 0, -0.999763787, 0, 1, 0, 0.999763787, 0, -0.0217350088),
    ["Colosseum 1"] = CFrame.new(-1428.35474, 7.38933945, -3014.37305, 0.601507425, 0, -0.798867643, 0, 1, 0, 0.798867643, 0, 0.601507425),
    ["Sky island 1"] = CFrame.new(-4970.21875, 717.707275, -2622.35449, 0.916586101, 0, 0.399847835, 0, 1, 0, -0.399847835, 0, 0.916586101),
    ["Sky island 2"] = CFrame.new(-4813.0249, 903.708557, -1912.69055, -0.992320657, 0, 0.123706974, 0, 1, 0, -0.123706974, 0, -0.992320657),
    ["Sky island 3"] = CFrame.new(-7952.31006, 5545.52832, -320.704956, -0.671970785, 0, 0.740569949, 0, 1, 0, -0.740569949, 0, -0.671970785),
    ["Sky island 4"] = CFrame.new(-7793.43896, 5607.22168, -2016.58362, -0.738143265, 0, 0.674632728, 0, 1, 0, -0.674632728, 0, -0.738143265),
    ["Prison"] = CFrame.new(4854.16455, 5.68742752, 740.194641, 0.925100684, 0, -0.379749805, 0, 1, 0, 0.379749805, 0, 0.925100684),
    ["Magma Village"] = CFrame.new(-5231.75879, 8.61593437, 8467.87695, 0.818073869, 0, 0.575107396, 0, 1, 0, -0.575107396, 0, 0.818073869),
    ["UndeyWater City"] = CFrame.new(61163.8516, 11.7796879, 1819.78418, 0.91310811, 0, 0.407695919, 0, 1, 0, -0.407695919, 0, 0.91310811),
    ["Fountain City"] = CFrame.new(5132.7124, 4.53632832, 4037.8562, 0.803456545, 0, -0.595371008, 0, 1, 0, 0.595371008, 0, 0.803456545),
    ["House Cyborgs"] = CFrame.new(6262.72559, 71.3003616, 3998.23047, -0.0700459853, 0, -0.997543752, 0, 1, 0, 0.997543752, 0, -0.0700459853),
    ["Shanks Room"] = CFrame.new(-1442.16553, 29.8788261, -28.3547478, 0.0479700826, 0, 0.998849034, 0, 1, 0, -0.998849034, 0, 0.0479700826),
    ["Mob Island"] = CFrame.new(-2850.20068, 7.39224768, 5354.99268, -0.999969244, 0, 0.00783950742, 0, 1, 0, -0.00783950742, 0, -0.999969244),
    -- Second Sea
    ["Dock"] = CFrame.new(82.9490662, 18.0710983, 2834.98779, -0.869077802, 0, -0.494680524, 0, 1, 0, 0.494680524, 0, -0.869077802),
    ["Kingdom of Rose"] = CFrame.new(-394.983521, 118.503128, 1245.8446, -0.923844218, 0, 0.38275671, 0, 1, 0, -0.38275671, 0, -0.923844218),
    ["Mansion 1"] = CFrame.new(-390.096313, 331.886475, 673.464966, 0.795434237, 0, 0.606038809, 0, 1, 0, -0.606038809, 0, 0.795434237),
    ["Flamingo Room"] = CFrame.new(2302.19019, 15.1778421, 663.811035, -0.950176418, 0, 0.311741412, 0, 1, 0, -0.311741412, 0, -0.950176418),
    ["Green Zone"] = CFrame.new(-2372.14697, 72.9919434, -3166.51416, 0.992469549, 0, 0.122503012, 0, 1, 0, -0.122503012, 0, 0.992469549),
    ["Cafe"] = CFrame.new(-385.250916, 73.0458984, 297.388397, -0.917251229, 0, 0.398320943, 0, 1, 0, -0.398320943, 0, -0.917251229),
    ["Factory"] = CFrame.new(430.42569, 210.019623, -432.504791, -0.977149308, 0, 0.212530047, 0, 1, 0, -0.212530047, 0, -0.977149308),
    ["Colosseum 2"] = CFrame.new(-1836.58191, 44.5890656, 1360.30652, 0.982203901, 0, 0.187813774, 0, 1, 0, -0.187813774, 0, 0.982203901),
    ["Grave Island"] = CFrame.new(-5411.47607, 48.8234024, -721.272522, 0.891395748, 0, 0.453261077, 0, 1, 0, -0.453261077, 0, 0.891395748),
    ["Snow Mountain"] = CFrame.new(511.825226, 401.765198, -5380.396, -0.996102452, 0, -0.0882040858, 0, 1, 0, 0.0882040858, 0, -0.996102452),
    ["Cold Island"] = CFrame.new(-6026.96484, 14.7461271, -5071.96338, -0.980430067, 0, 0.196833357, 0, 1, 0, -0.196833357, 0, -0.980430067),
    ["Hot Island"] = CFrame.new(-5478.39209, 15.9775667, -5246.9126, -0.924753785, 0, -0.380549848, 0, 1, 0, 0.380549848, 0, -0.924753785),
    ["Cursed Ship"] = CFrame.new(902.059143, 124.752518, 33071.8125, -0.0466609411, 0, 0.998910964, 0, 1, 0, -0.998910964, 0, -0.0466609411),
    ["Ice Castle"] = CFrame.new(5400.40381, 28.21698, -6236.99219, 0.0658750087, 0, 0.997827053, 0, 1, 0, -0.997827053, 0, 0.0658750087),
    ["Forgotten Island"] = CFrame.new(-3043.31543, 238.881271, -10191.5791, 0.706654668, 0, 0.707558692, 0, 1, 0, -0.707558692, 0, 0.706654668),
    ["Usoapp Island"] = CFrame.new(4748.78857, 8.35370827, 2849.57959, 0.828287303, 0, -0.560301542, 0, 1, 0, 0.560301542, 0, 0.828287303),
    ["Minisky Island"] = CFrame.new(-260.358917, 49325.7031, -35259.3008, -0.984672785, 0, 0.174409628, 0, 1, 0, -0.174409628, 0, -0.984672785),
    -- Third Sea
    ["Port Town"] = CFrame.new(-610.309692, 57.8323097, 6436.33594, -0.808349311, 0, -0.588668644, 0, 1, 0, 0.588668644, 0, -0.808349311),
    ["Hydra Island"] = CFrame.new(5229.99561, 603.916565, 345.154022, 0.998720765, 0, -0.050562907, 0, 1, 0, 0.050562907, 0, 0.998720765),
    ["Great Tree"] = CFrame.new(2174.94873, 28.7312393, -6728.83154, 0.938935697, 0, 0.344044328, 0, 1, 0, -0.344044328, 0, 0.938935697),
    ["Castle on the Sea"] = CFrame.new(-5477.62842, 313.794739, -2808.4585, 0.953856766, 0, 0.300293237, 0, 1, 0, -0.300293237, 0, 0.953856766),
    ["Floating Turtle"] = CFrame.new(-10919.2998, 331.788452, -8637.57227, -0.931179523, 0, -0.364545315, 0, 1, 0, 0.364545315, 0, -0.931179523),
    ["Mansion 2"] = CFrame.new(-12553.8125, 332.403961, -7621.91748, -0.978371859, 0, 0.206859157, 0, 1, 0, -0.206859157, 0, -0.978371859),
    ["Secret Temple"] = CFrame.new(5217.35693, 6.56511116, 1100.88159, 0.862958908, 0, -0.505253851, 0, 1, 0, 0.505253851, 0, 0.862958908),
    ["Friendly Arena"] = CFrame.new(5220.28955, 72.8193436, -1450.86304, 0.988012195, 0, -0.15442808, 0, 1, 0, 0.15442808, 0, 0.988012195),
    ["Beautiful Pirate Domain"] = CFrame.new(5310.8095703125, 21.594484329224, 129.39053344727, 0.999894083, 0, 0.0145579427, 0, 1, 0, -0.0145579427, 0, 0.999894083),
    ["Teler Park"] = CFrame.new(-9512.3623046875, 142.13258361816, 5548.845703125),
    ["Peanut Island"] = CFrame.new(-2142, 48, -10031, 0.996189952, 0, 0.0872153938, 0, 1, 0, -0.0872153938, 0, 0.996189952),
    ["Chocolate Island"] = CFrame.new(156.896484, 30.5935211, -12662.7031, 0.997934341, 0, -0.0642486736, 0, 1, 0, 0.0642486736, 0, 0.997934341),
    ["Ice Cream Island"] = CFrame.new(-949, 59, -10907, 0.99827838, 0, -0.0586544089, 0, 1, 0, 0.0586544089, 0, 0.99827838),
    ["Haunted Castle"] = CFrame.new(-9530.61035, -132.860657, 5763.13477, 0.927573681, 0, 0.373602688, 0, 1, 0, -0.373602688, 0, 0.927573681),
    ["Cake Loaf"] = CFrame.new(-2099.33154, 66.9970703, -12128.585, 0.999954641, 0, 0.00953165628, 0, 1, 0, -0.00953165628, 0, 0.999954641),
    ["Candy Cane"] = CFrame.new(-1530.97144, 13.728817, -14770.0889, 0.960570335, 0, -0.278036207, 0, 1, 0, 0.278036207, 0, 0.960570335),
    ["Tiki Outpost"] = CFrame.new(-16548.8164, 55.6059914, -172.8125, -0.0488498583, 0, 0.998806179, 0, 1, 0, -0.998806179, 0, -0.0488498583),
    ["Raid Lab"] = CFrame.new(-5057.146484375, 314.54132080078, -2934.7995605469),
    ["Mini Sky"] = CFrame.new(-263.66668701172, 49325.49609375, -35260, -0.984672785, 0, 0.174409628, 0, 1, 0, -0.174409628, 0, -0.984672785)
}


function MiscModule.TeleportToIsland(islandName, bypassTP)
    local cf = MiscModule.IslandPositions[islandName]
    if not cf then return false end
    
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    if bypassTP then
        hrp.CFrame = cf
    else
        MiscModule.Tween(cf)
    end
    return true
end

function MiscModule.StartTeleportLoop(islandName)
    _G.AutoTeleportIsland = true
    spawn(function()
        while _G.AutoTeleportIsland do
            task.wait()
            pcall(function()
                local cf = MiscModule.IslandPositions[islandName]
                if cf then
                    if BypassTeleport then
                        MiscModule.BTP(cf)
                    else
                        MiscModule.Tween(cf)
                    end
                end
            end)
        end
    end)
end

function MiscModule.StopTeleportLoop()
    _G.AutoTeleportIsland = false
    MiscModule.CancelTween(false)
end



function MiscModule.GetNPCList()
    local list = {}
    pcall(function()
        for i,v in pairs(Workspace.NPCs:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") then
                table.insert(list, v.Name)
            end
        end
    end)
    return list
end

function MiscModule.TeleportToNPC(npcName, bypassTP)
    pcall(function()
        for i,v in pairs(Workspace.NPCs:GetChildren()) do
            if v.Name == npcName and v:FindFirstChild("HumanoidRootPart") then
                if bypassTP then
                    MiscModule.BTP(v.HumanoidRootPart.CFrame)
                else
                    MiscModule.Tween(v.HumanoidRootPart.CFrame)
                end
                return true
            end
        end
    end)
    return false
end



MiscModule.MiscTeleports = {
    ["Random Surprise"] = CFrame.new(-5453.97559, 320.076599, -2849.55762, -0.970949054, 0, 0.239263847, 0, 1, 0, -0.239263847, 0, -0.970949054),
    ["Lucky Chest"] = CFrame.new(16628.3359, 50.2916679, 188.795563, -0.998712897, 0, 0.050719205, 0, 1, 0, -0.050719205, 0, -0.998712897),
    ["Blacksmith"] = CFrame.new(-248.51889, 21.5987682, 1309.39917, 0.913113534, 0, 0.407683104, 0, 1, 0, -0.407683104, 0, 0.913113534),
    ["Awaking Expert"] = CFrame.new(-12886.3545, 7377.76807, -9540.01172, -0.999914408, 0, -0.0130926166, 0, 1, 0, 0.0130926166, 0, -0.999914408),
    ["Race V4 Temple"] = CFrame.new(28636.919921875, 14890.6767578125, -106.53353881836, 0.999909043, 0, 0.0134932967, 0, 1, 0, -0.0134932967, 0, 0.999909043),
    ["Diamond Dealer"] = CFrame.new(-7850.0234375, 5527.87060546875, -469.17794799805),
    ["Blox Fruit Dealer"] = CFrame.new(-25.5296783, 16.5503788, 1321.14209, 0.856419146, 0, -0.516316414, 0, 1, 0, 0.516316414, 0, 0.856419146),
    ["Blox Fruit Gacha"] = CFrame.new(-37.3893433, 7.4499917, -1929.84033, -0.889195502, 0, 0.457516134, 0, 1, 0, -0.457516134, 0, -0.889195502),
    ["Sword Dealer"] = CFrame.new(159.49324, 16.3050098, 1553.53857),
    ["Fragment Trader"] = CFrame.new(-5474.41895, 313.800507, -2746.45313, 0.958618641, 0, -0.284722656, 0, 1, 0, 0.284722656, 0, 0.958618641),
    ["Flag Dealer"] = CFrame.new(-5449.38135, 313.800507, -2695.0332, -0.0261270385, 0, 0.999658585, 0, 1, 0, -0.999658585, 0, -0.0261270385),
    ["Luxury Ship Dealer"] = CFrame.new(-16211.6514, 6.19994354, 1731.36487),
    ["Mirage Island Check"] = CFrame.new(-16227.8242, 6.19999695, 1838.89453, -0.866025388, 0, -0.500000238, 0, 1, 0, 0.500000238, 0, -0.866025388)
}



MiscModule.RaidTypes = {
    "Ship Raid",
    "Flame",
    "Ice",
    "Quake",
    "Dark",
    "Light",
    "Magma",
    "Rumble",
    "Buddha",
    "Spider",
    "Sand",
    "Phoenix",
    "Sound",
    "Blizzard",
    "Gravity",
    "Control",
    "Mammoth",
    "Dough",
    "Shadow",
    "Spirit",
    "Portal",
    "Leopard",
    "Kitsune",
    "T-Rex",
    "Yeti"
}



MiscModule.FightingStyles = {
    "Combat",
    "Black Leg",
    "Electro",
    "Fishman Karate",
    "Dragon Claw",
    "Superhuman",
    "Death Step",
    "Sharkman Karate",
    "Electric Claw",
    "Dragon Talon",
    "Godhuman",
    "Sanguine Art"
}


MiscModule.ShopWeapons = {
    "Cutlass",
    "Katana",
    "Pipe",
    "Dual Katana",
    "Iron Mace",
    "Triple Katana"
}

MiscModule.ShopFruits = {
    "Bomb", "Spike", "Chop", "Spring", "Kilo", "Smoke", "Spin",
    "Flame", "Falcon", "Ice", "Sand", "Dark", "Diamond", "Light",
    "Rubber", "Barrier", "Magma", "Quake", "Buddha", "Love",
    "Spider", "Sound", "Phoenix", "Portal", "Rumble", "Pain",
    "Blizzard", "Gravity", "Mammoth", "T-Rex", "Dough", "Venom",
    "Shadow", "Control", "Spirit", "Dragon", "Leopard", "Kitsune", "Yeti"
}

MiscModule.ShopGuns = {
    "Slingshot",
    "Musket",
    "Flintlock",
    "Refined Slingshot",
    "Refined Musket",
    "Refined Flintlock"
}

MiscModule.ShopAccessories = {
    "Pilot Helmet",
    "Marine Cap",
    "Pirate Hat",
    "Usoap's Hat",
    "Swordsman Hat",
    "Black Cape",
    "Blue Cape",
    "Red Cape"
}


function MiscModule.BuyWeapon(weaponName)
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", weaponName)
    end)
end

function MiscModule.BuyFruit(fruitName)
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("PurchaseFruit", fruitName, true)
    end)
end

function MiscModule.BuyGun(gunName)
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", gunName)
    end)
end

function MiscModule.BuyAccessory(accessoryName)
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", accessoryName)
    end)
end



function MiscModule.CreateESP(parent, name, color, text)
    if parent:FindFirstChild(name) then return parent:FindFirstChild(name) end
    
    local BillboardGui = Instance.new("BillboardGui")
    local TextLabel = Instance.new("TextLabel")
    
    BillboardGui.Parent = parent
    BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    BillboardGui.Active = true
    BillboardGui.Name = name
    BillboardGui.AlwaysOnTop = true
    BillboardGui.LightInfluence = 1.000
    BillboardGui.Size = UDim2.new(0, 200, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
    
    TextLabel.Parent = BillboardGui
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Size = UDim2.new(0, 200, 0, 50)
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.TextColor3 = color or Color3.fromRGB(0, 255, 100)
    TextLabel.FontSize = "Size14"
    TextLabel.TextStrokeTransparency = 0.5
    TextLabel.Text = text or ""
    
    return BillboardGui
end

function MiscModule.DestroyESP(parent, name)
    if parent and parent:FindFirstChild(name) then
        parent:FindFirstChild(name):Destroy()
    end
end

function MiscModule.UpdateESPText(parent, name, text, distance)
    if parent and parent:FindFirstChild(name) then
        local gui = parent:FindFirstChild(name)
        if gui:FindFirstChildOfClass("TextLabel") then
            gui:FindFirstChildOfClass("TextLabel").Text = text .. "\n[" .. tostring(math.floor(distance)) .. "m]"
        end
    end
end



function MiscModule.StartPlayerESP()
    MiscModule.ESP_Player = true
    spawn(function()
        while MiscModule.ESP_Player do
            task.wait(0.5)
            pcall(function()
                for i,v in pairs(Workspace.Characters:GetChildren()) do
                    if v.Name ~= LocalPlayer.Name and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                        local distance = (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        local color = Color3.fromRGB(255, 0, 0)
                        if v.Humanoid.Health <= 0 then
                            MiscModule.DestroyESP(v.HumanoidRootPart, "PlayerESP")
                        else
                            MiscModule.CreateESP(v.HumanoidRootPart, "PlayerESP", color, v.Name .. "\n[" .. tostring(math.floor(distance)) .. "m]")
                            MiscModule.UpdateESPText(v.HumanoidRootPart, "PlayerESP", v.Name, distance)
                        end
                    end
                end
            end)
        end
        -- Clean up ESP when disabled
        for i,v in pairs(Workspace.Characters:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") then
                MiscModule.DestroyESP(v.HumanoidRootPart, "PlayerESP")
            end
        end
    end)
end

function MiscModule.StopPlayerESP()
    MiscModule.ESP_Player = false
end

function MiscModule.StartEnemyESP()
    MiscModule.ESP_Enemy = true
    spawn(function()
        while MiscModule.ESP_Enemy do
            task.wait(0.5)
            pcall(function()
                for i,v in pairs(Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                        local distance = (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        local color = Color3.fromRGB(255, 165, 0)
                        if v.Humanoid.Health <= 0 then
                            MiscModule.DestroyESP(v.HumanoidRootPart, "EnemyESP")
                        else
                            local hp = math.floor(v.Humanoid.Health)
                            local maxHp = math.floor(v.Humanoid.MaxHealth)
                            MiscModule.CreateESP(v.HumanoidRootPart, "EnemyESP", color, v.Name .. "\n[HP: " .. tostring(hp) .. "/" .. tostring(maxHp) .. "]\n[" .. tostring(math.floor(distance)) .. "m]")
                        end
                    end
                end
            end)
        end
        for i,v in pairs(Workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") then
                MiscModule.DestroyESP(v.HumanoidRootPart, "EnemyESP")
            end
        end
    end)
end

function MiscModule.StopEnemyESP()
    MiscModule.ESP_Enemy = false
end


function MiscModule.StartFruitESP()
    MiscModule.ESP_Fruit = true
    spawn(function()
        while MiscModule.ESP_Fruit do
            task.wait(1)
            pcall(function()
                for i,v in pairs(Workspace:GetChildren()) do
                    if v:FindFirstChild("FruitModel") or v:FindFirstChild("Handle") and string.find(v.Name, "Fruit") then
                        local handle = v:FindFirstChild("Handle") or v:FindFirstChild("FruitModel")
                        if handle then
                            local distance = (handle.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            local color = Color3.fromRGB(128, 0, 128)
                            MiscModule.CreateESP(handle, "FruitESP", color, v.Name .. "\n[" .. tostring(math.floor(distance)) .. "m]")
                        end
                    end
                end
            end)
        end
        for i,v in pairs(Workspace:GetChildren()) do
            local handle = v:FindFirstChild("Handle") or v:FindFirstChild("FruitModel")
            if handle then
                MiscModule.DestroyESP(handle, "FruitESP")
            end
        end
    end)
end

function MiscModule.StopFruitESP()
    MiscModule.ESP_Fruit = false
end


function MiscModule.StartChestESP()
    MiscModule.ESP_Chest = true
    spawn(function()
        while MiscModule.ESP_Chest do
            task.wait(1)
            pcall(function()
                for i,v in pairs(Workspace:GetChildren()) do
                    if string.find(v.Name, "Chest") then
                        local chestPart = v:FindFirstChild("Lid") or v:FindFirstChildOfClass("Part") or v
                        if chestPart then
                            local distance = (chestPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            local color = Color3.fromRGB(255, 215, 0)
                            MiscModule.CreateESP(chestPart, "ChestESP", color, v.Name .. "\n[" .. tostring(math.floor(distance)) .. "m]")
                        end
                    end
                end
            end)
        end
        for i,v in pairs(Workspace:GetChildren()) do
            if string.find(v.Name, "Chest") then
                local chestPart = v:FindFirstChild("Lid") or v:FindFirstChildOfClass("Part") or v
                if chestPart then
                    MiscModule.DestroyESP(chestPart, "ChestESP")
                end
            end
        end
    end)
end

function MiscModule.StopChestESP()
    MiscModule.ESP_Chest = false
end



function MiscModule.StartFlowerESP()
    MiscModule.ESP_Flower = true
    spawn(function()
        while MiscModule.ESP_Flower do
            task.wait(1)
            pcall(function()
                for i,v in pairs(Workspace:GetChildren()) do
                    if string.find(v.Name, "Flower") then
                        if v:IsA("Part") or v:IsA("Model") then
                            local flowerPart = v:IsA("Model") and v:FindFirstChildOfClass("Part") or v
                            if flowerPart then
                                local distance = (flowerPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                                local color = Color3.fromRGB(255, 105, 180)
                                MiscModule.CreateESP(flowerPart, "FlowerESP", color, v.Name .. "\n[" .. tostring(math.floor(distance)) .. "m]")
                            end
                        end
                    end
                end
            end)
        end
        for i,v in pairs(Workspace:GetChildren()) do
            if string.find(v.Name, "Flower") then
                local flowerPart = v:IsA("Model") and v:FindFirstChildOfClass("Part") or v
                if flowerPart then
                    MiscModule.DestroyESP(flowerPart, "FlowerESP")
                end
            end
        end
    end)
end

function MiscModule.StopFlowerESP()
    MiscModule.ESP_Flower = false
end



function MiscModule.StartIslandESP()
    MiscModule.ESP_Island = true
    spawn(function()
        while MiscModule.ESP_Island do
            task.wait(2)
            pcall(function()
                if Workspace._WorldOrigin and Workspace._WorldOrigin.Locations then
                    for i,v in pairs(Workspace._WorldOrigin.Locations:GetChildren()) do
                        if v:IsA("Part") or v:IsA("Model") then
                            local islandPart = v:IsA("Model") and v:FindFirstChildOfClass("Part") or v
                            if islandPart then
                                local distance = (islandPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                                local color = Color3.fromRGB(0, 255, 255)
                                MiscModule.CreateESP(islandPart, "IslandESP", color, v.Name .. "\n[" .. tostring(math.floor(distance)) .. "m]")
                            end
                        end
                    end
                end
            end)
        end
        if Workspace._WorldOrigin and Workspace._WorldOrigin.Locations then
            for i,v in pairs(Workspace._WorldOrigin.Locations:GetChildren()) do
                local islandPart = v:IsA("Model") and v:FindFirstChildOfClass("Part") or v
                if islandPart then
                    MiscModule.DestroyESP(islandPart, "IslandESP")
                end
            end
        end
    end)
end

function MiscModule.StopIslandESP()
    MiscModule.ESP_Island = false
end



function MiscModule.StartSeaBeastESP()
    MiscModule.ESP_SeaBeast = true
    spawn(function()
        while MiscModule.ESP_SeaBeast do
            task.wait(1)
            pcall(function()
                for i,v in pairs(Workspace.SeaBeasts:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                        local distance = (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        local color = Color3.fromRGB(0, 100, 255)
                        if v.Humanoid.Health <= 0 then
                            MiscModule.DestroyESP(v.HumanoidRootPart, "SeaBeastESP")
                        else
                            local hp = math.floor(v.Humanoid.Health)
                            local maxHp = math.floor(v.Humanoid.MaxHealth)
                            MiscModule.CreateESP(v.HumanoidRootPart, "SeaBeastESP", color, "Sea Beast\n[HP: " .. tostring(hp) .. "/" .. tostring(maxHp) .. "]\n[" .. tostring(math.floor(distance)) .. "m]")
                        end
                    end
                end
            end)
        end
        for i,v in pairs(Workspace.SeaBeasts:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") then
                MiscModule.DestroyESP(v.HumanoidRootPart, "SeaBeastESP")
            end
        end
    end)
end

function MiscModule.StopSeaBeastESP()
    MiscModule.ESP_SeaBeast = false
end


function MiscModule.GetPlayerList()
    local list = {}
    for i,v in pairs(Workspace.Characters:GetChildren()) do
        if v.Name ~= LocalPlayer.Name then
            table.insert(list, v.Name)
        end
    end
    return list
end

function MiscModule.RefreshPlayerList()
    return MiscModule.GetPlayerList()
end

function MiscModule.StartCombatPlayer()
    MiscModule.TweenToPlayer = true
    spawn(function()
        while MiscModule.TweenToPlayer do
            task.wait()
            pcall(function()
                for i,v in pairs(Workspace.Characters:GetChildren()) do
                    if v.Name == SelectedPlayer then
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            repeat RunService.Heartbeat:wait()
                                MiscModule.EquipTool(SelectWeaponPvp)
                                MiscModule.Tween(v.HumanoidRootPart.CFrame * Pvp_Mode)
                                Player_Name = v.Name
                                Player_Position = v.HumanoidRootPart.Position
                            until not MiscModule.TweenToPlayer or v.Humanoid.Health <= 0 or not Workspace.Characters:FindFirstChild(v.Name)
                        end
                    end
                end
            end)
        end
    end)
end

function MiscModule.StopCombatPlayer()
    MiscModule.TweenToPlayer = false
    MiscModule.CancelTween(false)
end

function MiscModule.StartSpectate()
    MiscModule.Spectate = true
    spawn(function()
        local plr1 = LocalPlayer.Character.Humanoid
        local plr2 = Workspace.Characters:FindFirstChild(SelectedPlayer)
        repeat task.wait()
            if plr2 and plr2:FindFirstChild("Humanoid") then
                Workspace.Camera.CameraSubject = plr2.Humanoid
            end
        until MiscModule.Spectate == false
        Workspace.Camera.CameraSubject = plr1
    end)
end

function MiscModule.StopSpectate()
    MiscModule.Spectate = false
end

function MiscModule.StartAimbotSkill()
    MiscModule.AimbotSkillPlayer = true
    spawn(function()
        while MiscModule.AimbotSkillPlayer do
            task.wait()
            pcall(function()
                for i,v in pairs(Workspace.Characters:GetChildren()) do
                    if v.Name == SelectedPlayer then
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            Player_Position = v.HumanoidRootPart.Position
                        end
                    end
                end
            end)
        end
    end)
end

function MiscModule.StopAimbotSkill()
    MiscModule.AimbotSkillPlayer = false
end

function MiscModule.StartTpBehindPlayer()
    MiscModule.TpBehindPlayer = true
    spawn(function()
        while MiscModule.TpBehindPlayer do
            task.wait()
            pcall(function()
                for i,v in pairs(Workspace.Characters:GetChildren()) do
                    if v.Name == SelectedPlayer then
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                        end
                    end
                end
            end)
        end
    end)
end

function MiscModule.StopTpBehindPlayer()
    MiscModule.TpBehindPlayer = false
end


function MiscModule.StartInfiniteJump()
    MiscModule.InfiniteJump = true
    spawn(function()
        UserInputService.JumpRequest:Connect(function()
            if MiscModule.InfiniteJump then
                pcall(function()
                    LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                end)
            end
        end)
    end)
end

function MiscModule.StopInfiniteJump()
    MiscModule.InfiniteJump = false
end

function MiscModule.StartNoClip()
    MiscModule.NoClip = true
    spawn(function()
        RunService.Stepped:Connect(function()
            if MiscModule.NoClip and LocalPlayer.Character then
                for i,v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end)
end

function MiscModule.StopNoClip()
    MiscModule.NoClip = false
end

function MiscModule.StartAntiAfk()
    MiscModule.AntiAfk = true
    local VirtualUser = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        if MiscModule.AntiAfk then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end)
end

function MiscModule.StopAntiAfk()
    MiscModule.AntiAfk = false
end

function MiscModule.StartFullBright()
    MiscModule.FullBright = true
    pcall(function()
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end)
end

function MiscModule.StopFullBright()
    MiscModule.FullBright = false
    pcall(function()
        Lighting.Brightness = 1
        Lighting.FogEnd = 10000
        Lighting.GlobalShadows = true
    end)
end

function MiscModule.StartAutoRejoin()
    MiscModule.AutoRejoin = true
    spawn(function()
        LocalPlayer.OnTeleport:Connect(function(State)
            if MiscModule.AutoRejoin and State == Enum.TeleportState.Failed then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
            end
        end)
    end)
end

function MiscModule.StopAutoRejoin()
    MiscModule.AutoRejoin = false
end



MiscModule.StatTypes = {
    "Melee",
    "Defense",
    "Sword",
    "Gun",
    "Blox Fruit"
}

function MiscModule.AddStat(statName, amount)
    pcall(function()
        for i = 1, amount or 1 do
            ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", statName)
        end
    end)
end

function MiscModule.AutoAllocateStats(statName)
    _G.AutoStats = true
    _G.AutoStatType = statName
    spawn(function()
        while _G.AutoStats do
            task.wait()
            pcall(function()
                local points = LocalPlayer.Data.Points.Value
                if points > 0 then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", _G.AutoStatType)
                end
            end)
        end
    end)
end

function MiscModule.StopAutoAllocateStats()
    _G.AutoStats = false
end

function MiscModule.ServerHop()
    pcall(function()
        local PlaceId = game.PlaceId
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/"
        
        local servers = {}
        local req = request or syn.request or http_request
        
        local function fetchServers()
            local res = req({
                Url = Api .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100",
                Method = "GET"
            })
            return Http:JSONDecode(res.Body)
        end
        
        local allServers = fetchServers()
        if allServers and allServers.data then
            for _, server in pairs(allServers.data) do
                if server.id ~= game.JobId and server.playing < server.maxPlayers then
                    TPS:TeleportToPlaceInstance(PlaceId, server.id)
                    break
                end
            end
        end
    end)
end

function MiscModule.Rejoin()
    pcall(function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end)
end

function MiscModule.GetPlayerData()
    local data = {}
    pcall(function()
        data.Level = LocalPlayer.Data.Level.Value
        data.Beli = LocalPlayer.Data.Beli.Value
        data.Fragments = LocalPlayer.Data.Fragments.Value
        data.Race = LocalPlayer.Data.Race.Value
        data.Points = LocalPlayer.Data.Points.Value
    end)
    return data
end

function MiscModule.GetInventory()
    local inv = {}
    pcall(function()
        inv = ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")
    end)
    return inv
end

function MiscModule.RedeemCode(code)
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("RedeemCode", code)
    end)
end

function MiscModule.ChangeTeam(team)
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("TeamChange", team)
    end)
end

function MiscModule.ResetStats()
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BlacksmithBuy", "ResetStats")
    end)
end

function MiscModule.CollectAllFlowers()
    spawn(function()
        for i,v in pairs(Workspace:GetChildren()) do
            if string.find(v.Name, "Flower") then
                if v:IsA("Part") or v:IsA("Model") then
                    local flowerPart = v:IsA("Model") and v:FindFirstChildOfClass("Part") or v
                    if flowerPart then
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, flowerPart, 0)
                        wait(0.1)
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, flowerPart, 1)
                    end
                end
            end
        end
    end)
end

function MiscModule.CollectAllChests()
    spawn(function()
        for i,v in pairs(Workspace:GetChildren()) do
            if string.find(v.Name, "Chest") then
                local chestPart = v:FindFirstChildOfClass("Part")
                if chestPart then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = chestPart.CFrame
                    wait(0.5)
                end
            end
        end
    end)
end



function MiscModule.StartFly(speed)
    MiscModule.FlyEnabled = true
    local flySpeed = speed or 100
    local BodyGyro = Instance.new("BodyGyro")
    local BodyVelocity = Instance.new("BodyVelocity")
    
    spawn(function()
        pcall(function()
            local hrp = LocalPlayer.Character.HumanoidRootPart
            
            BodyGyro.Name = "FlyGyro"
            BodyGyro.Parent = hrp
            BodyGyro.P = 9e4
            BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            BodyGyro.cframe = hrp.CFrame
            
            BodyVelocity.Name = "FlyVelocity"
            BodyVelocity.Parent = hrp
            BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
            BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
            
            while MiscModule.FlyEnabled do
                RunService.Heartbeat:wait()
                pcall(function()
                    local Camera = Workspace.CurrentCamera
                    BodyGyro.cframe = Camera.CFrame
                    
                    local moveDirection = Vector3.new(0, 0, 0)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        moveDirection = moveDirection + Camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        moveDirection = moveDirection - Camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        moveDirection = moveDirection - Camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        moveDirection = moveDirection + Camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        moveDirection = moveDirection + Vector3.new(0, 1, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                        moveDirection = moveDirection - Vector3.new(0, 1, 0)
                    end
                    
                    if moveDirection.Magnitude > 0 then
                        BodyVelocity.velocity = moveDirection.Unit * flySpeed
                    else
                        BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
                    end
                end)
            end
        end)
    end)
end

function MiscModule.StopFly()
    MiscModule.FlyEnabled = false
    pcall(function()
        local hrp = LocalPlayer.Character.HumanoidRootPart
        if hrp:FindFirstChild("FlyGyro") then
            hrp.FlyGyro:Destroy()
        end
        if hrp:FindFirstChild("FlyVelocity") then
            hrp.FlyVelocity:Destroy()
        end
    end)
end



MiscModule.WeaponTypes = {
    "Melee",
    "Sword",
    "Gun",
    "Blox Fruit"
}

function MiscModule.GetWeaponsByType(weaponType)
    local weapons = {}
    pcall(function()
        for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
            if v.ToolTip == weaponType then
                table.insert(weapons, v.Name)
            end
        end
    end)
    return weapons
end



function MiscModule.Init()
   
    MiscModule.StartAntiAfk()
end

return MiscModule
