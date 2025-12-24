
if not game:IsLoaded() then
    repeat task.wait() until game:IsLoaded()
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer

local LOADER_URL = "https://raw.githubusercontent.com/zzxzsss/moulders/refs/heads/main/Module.lua/bloxfruits/loader%20blox%20fruits.lua"
local SCRIPT_BASE_URL = "https://raw.githubusercontent.com/zzxzsss/moulders/main/Module.lua/bloxfruits/"

local function httpRequest(options)
    local request = syn and syn.request or http and http.request or http_request or (request ~= nil and request) or httprequest or (fluxus and fluxus.request)
    
    if request then
        return request(options)
    end
    
    local success, response = pcall(function()
        return HttpService:RequestAsync(options)
    end)
    
    if success then
        return response
    end
    
    return nil
end

local function LoadModule(moduleName)
    local success, module = pcall(function()
        return loadstring(game:HttpGet(SCRIPT_BASE_URL .. moduleName .. ".lua"))()
    end)
    if success then
        return module
    else
        warn("Failed to load module: " .. moduleName .. " - " .. tostring(module))
        return nil
    end
end

local Config = _G.ZlexModules and _G.ZlexModules["config"] or LoadModule("config")
local Utils = _G.ZlexModules and _G.ZlexModules["utils"] or LoadModule("utils")
local QuestData = _G.ZlexModules and _G.ZlexModules["quest-data"] or LoadModule("quest-data")
local AutoFarm = _G.ZlexModules and _G.ZlexModules["auto-farm"] or LoadModule("auto-farm")
local BossFarm = _G.ZlexModules and _G.ZlexModules["boss-farm"] or LoadModule("boss-farm")
local Mastery = _G.ZlexModules and _G.ZlexModules["mastery"] or LoadModule("mastery")
local Items = _G.ZlexModules and _G.ZlexModules["items"] or LoadModule("items")
local Materials = _G.ZlexModules and _G.ZlexModules["materials"] or LoadModule("materials")
local SeaEvents = _G.ZlexModules and _G.ZlexModules["sea-events"] or LoadModule("sea-events")
local Race = _G.ZlexModules and _G.ZlexModules["race"] or LoadModule("race")
local Raid = _G.ZlexModules and _G.ZlexModules["raid"] or LoadModule("raid")
local ESP = _G.ZlexModules and _G.ZlexModules["esp"] or LoadModule("esp")
local Teleport = _G.ZlexModules and _G.ZlexModules["teleport"] or LoadModule("teleport")
local Combat = _G.ZlexModules and _G.ZlexModules["combat"] or LoadModule("combat")
local Misc = _G.ZlexModules and _G.ZlexModules["misc"] or LoadModule("misc")
local FastAttackModule = _G.ZlexModules and _G.ZlexModules["fast-attack"] or LoadModule("fast-attack")
local AntiCheat = _G.ZlexModules and _G.ZlexModules["anti-cheat"] or LoadModule("anti-cheat")
local TaskManager = _G.ZlexModules and _G.ZlexModules["task-manager"] or LoadModule("task-manager")
local GetWeapons = _G.ZlexModules and _G.ZlexModules["get-weapons"] or LoadModule("get-weapons")

if not _G.ZlexModules then
    if Config then
        Config.Initialize()
        Config.LoadSettings()
    end

    if QuestData and Utils then QuestData.Init(Utils) end
    if AutoFarm and Utils and QuestData then AutoFarm.Init(Utils, QuestData) end
    if BossFarm and Utils and QuestData then BossFarm.Init(Utils, QuestData) end
    if Mastery and Utils and QuestData then Mastery.Init(Utils, QuestData) end
    if Items and Utils then Items.Init(Utils) end
    if Materials and Utils then Materials.Init(Utils) end
    if SeaEvents and Utils then SeaEvents.Init(Utils) end
    if Race and Utils then Race.Init(Utils) end
    if Raid and Utils then Raid.Init(Utils) end
    if ESP and Utils then ESP.Init(Utils) end
    if Teleport and Utils then Teleport.Init(Utils) end
    if Combat and Utils then Combat.Init(Utils) end
    if Misc and Utils then Misc.Init(Utils) end
    if FastAttackModule and Utils then FastAttackModule.Init(Utils) end
    if AntiCheat and Utils then 
        AntiCheat.Init(Utils) 
        _G.AntiCheat = AntiCheat
    end
    if TaskManager and Utils then
        TaskManager.Init(Utils)
        _G.TaskManager = TaskManager
    end
    if GetWeapons and Utils then
        GetWeapons.Init({Utils = Utils, Config = Config})
        _G.GetWeapons = GetWeapons
    end
end

if AntiCheat and not _G.AntiCheat then
    _G.AntiCheat = AntiCheat
end

if TaskManager and not _G.TaskManager then
    _G.TaskManager = TaskManager
end

if TaskManager then
    TaskManager.RegisterTask("Auto Farm", function()
        if AutoFarm and _G.Settings.Main["Auto Farm"] then
            AutoFarm.FarmLoop()
        end
    end, 6)
    
    TaskManager.RegisterTask("Mastery Farm", function()
        if Mastery and _G.Settings.Main["Mastery Farm"] then
            Mastery.FarmLoop()
        end
    end, 5)
    
    TaskManager.RegisterTask("Boss Farm", function()
        if BossFarm and _G.Settings.Main["Boss Farm"] then
            BossFarm.FarmLoop()
        end
    end, 2)
    
    TaskManager.RegisterTask("Sea Events", function()
        if SeaEvents and _G.Settings.Main["Sea Events"] then
            SeaEvents.FarmLoop()
        end
    end, 1)
    
    TaskManager.RegisterTask("Raid", function()
        if Raid and _G.Settings.Main["Auto Raid"] then
            Raid.FarmLoop()
        end
    end, 3)
    
    TaskManager.RegisterTask("Race V4", function()
        if Race and _G.Settings.Main["Race V4"] then
            Race.FarmLoop()
        end
    end, 4)
    
    TaskManager.RegisterTask("Collect Items", function()
        if Items and _G.Settings.Main["Collect Items"] then
            Items.CollectLoop()
        end
    end, 7)
    
    TaskManager.RegisterTask("Collect Materials", function()
        if Materials and _G.Settings.Main["Collect Materials"] then
            Materials.CollectLoop()
        end
    end, 8)
    
    TaskManager.RunLoop()
end

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua"))()

local Purple = Color3.fromHex("#7775F2")
local Yellow = Color3.fromHex("#ECA201")
local Green = Color3.fromHex("#10C550")
local Grey = Color3.fromHex("#83889E")
local Blue = Color3.fromHex("#257AF7")
local Red = Color3.fromHex("#EF4F1D")
local Orange = Color3.fromHex("#FF6B35")
local Cyan = Color3.fromHex("#00D9FF")

local Window = WindUI:CreateWindow({
    Title = "Zlex Hub  |  Blox Fruits",
    Folder = "ZlexHub",
    Icon = "solar:gamepad-bold",
    NewElements = true,
    HideSearchBar = false,
    
    OpenButton = {
        Title = "Open Zlex Hub",
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 3,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        Color = ColorSequence.new(
            Color3.fromHex("#30FF6A"),
            Color3.fromHex("#00D9FF")
        )
    },
    Topbar = {
        Height = 44,
        ButtonsType = "Mac",
    },
    KeySystem = {
        Title = "Zlex Hub  |  Key System",
        Note = "Enter your key to access the hub. Get key from discord.gg/zlexhub",
        KeyValidator = function(EnteredKey)
            return EnteredKey == "ZlexHub2024" or EnteredKey == "ZLEX-FREE"
        end
    }
})

Window:Tag({
    Title = "v2.0",
    Icon = "github",
    Color = Color3.fromHex("#1c1c1c"),
    Border = true,
})

local FarmSection = Window:Section({ Title = "Farming" })
local CombatSection = Window:Section({ Title = "Combat" })
local UtilitySection = Window:Section({ Title = "Utility" })
local SettingsSection = Window:Section({ Title = "Settings" })

local WeaponList = {"Melee", "Sword", "Blox Fruit", "Gun"}
local ModeList = {"Auto", "Nearest", "Selected"}
local MonsterList = QuestData and QuestData.GetMonsterList() or {}
local BossNamesList = BossFarm and BossFarm.GetBossNames() or {}
local IslandList = Teleport and Teleport.GetIslandNames() or {"Starter Island"}
local WorldList = {"First Sea", "Second Sea", "Third Sea"}
local BoatList = SeaEvents and SeaEvents.BoatList or {"Guardian", "Beast Hunter"}
local ZoneList = SeaEvents and SeaEvents.ZoneList or {"Zone 1", "Zone 2", "Zone 3"}
local TempleList = Race and Race.TempleList or {"Human Temple", "Angel Temple", "Demon Temple", "Shark Temple"}
local RaidList = Raid and Raid.RaidList or {"Flame Raid", "Ice Raid", "Quake Raid"}


do
    local MainTab = FarmSection:Tab({
        Title = "Auto Farm",
        Desc = "Main farming features",
        Icon = "solar:home-2-bold",
        IconColor = Green,
        IconShape = "Square",
    })
    
    local MainSection = MainTab:Section({ Title = "Auto Farm Settings", Box = true, BoxBorder = true, Opened = true })
    
    MainSection:Toggle({
        Title = "Auto Farm",
        Desc = "Automatically farm monsters for level",
        Value = _G.Settings.Main["Auto Farm"],
        Callback = function(state)
            _G.Settings.Main["Auto Farm"] = state
            if TaskManager then TaskManager.SetTaskActive("Auto Farm", state) end
            Utils.StopTween(state)
            getgenv().SaveSetting()
        end
    })
    
    MainSection:Space()
    
    MainSection:Toggle({
        Title = "Auto Quest",
        Desc = "Automatically accept and complete quests",
        Value = _G.Settings.Main["Auto Quest"],
        Callback = function(state)
            _G.Settings.Main["Auto Quest"] = state
            getgenv().SaveSetting()
        end
    })
    
    MainSection:Space()
    
    MainSection:Toggle({
        Title = "Bring Monster",
        Desc = "Teleport monsters to you instead of going to them",
        Value = _G.Settings.Main["Bring Monster"],
        Callback = function(state)
            _G.Settings.Main["Bring Monster"] = state
            getgenv().SaveSetting()
        end
    })
    
    MainSection:Space()
    
    MainSection:Toggle({
        Title = "Auto Collect Chest",
        Desc = "Collect nearby chests while farming",
        Value = _G.Settings.Main["Auto Collect Chest"],
        Callback = function(state)
            _G.Settings.Main["Auto Collect Chest"] = state
            getgenv().SaveSetting()
        end
    })
    
    MainTab:Space()
    
    local WeaponSection = MainTab:Section({ Title = "Weapon & Mode", Box = true, BoxBorder = true, Opened = true })
    
    WeaponSection:Dropdown({
        Title = "Select Weapon",
        Desc = "Choose weapon type for farming",
        Values = WeaponList,
        Value = _G.Settings.Main["Selected Weapon"],
        Callback = function(option)
            _G.Settings.Main["Selected Weapon"] = option
            getgenv().SaveSetting()
        end
    })
    
    WeaponSection:Space()
    
    WeaponSection:Dropdown({
        Title = "Select Mode",
        Desc = "Farm mode selection",
        Values = ModeList,
        Value = _G.Settings.Main["Selected Mode"],
        Callback = function(option)
            _G.Settings.Main["Selected Mode"] = option
            getgenv().SaveSetting()
        end
    })
    
    MainTab:Space()
    
    local MonsterSection = MainTab:Section({ Title = "Monster Selection", Box = true, BoxBorder = true, Opened = true })
    
    MonsterSection:Toggle({
        Title = "Farm Selected Monster",
        Desc = "Farm specific monster instead of quest monster",
        Value = _G.Settings.Main["Farm Selected Monster"],
        Callback = function(state)
            _G.Settings.Main["Farm Selected Monster"] = state
            getgenv().SaveSetting()
        end
    })
    
    MonsterSection:Space()
    
    MonsterSection:Dropdown({
        Title = "Select Monster",
        Desc = "Choose monster to farm",
        Values = MonsterList,
        Value = _G.Settings.Main["Selected Monster"],
        Callback = function(option)
            _G.Settings.Main["Selected Monster"] = option
            getgenv().SaveSetting()
        end
    })
    
    MainTab:Space()
    
    local SpeedSection = MainTab:Section({ Title = "Speed Settings", Box = true, BoxBorder = true, Opened = true })
    
    SpeedSection:Slider({
        Title = "Tween Speed",
        Desc = "Movement speed (higher = faster)",
        IsTooltip = true,
        Step = 10,
        Value = { Min = 50, Max = 500, Default = _G.Settings.Setting["Tween Speed"] },
        Callback = function(value)
            _G.Settings.Setting["Tween Speed"] = value
        end
    })
end


do
    local WeaponAcquisitionTab = FarmSection:Tab({
        Title = "Weapon Acquisition",
        Desc = "Auto get weapons and styles",
        Icon = "solar:box-minimalistic-bold",
        IconColor = Orange,
        IconShape = "Square",
    })
    
    local WeaponSea1Section = WeaponAcquisitionTab:Section({ Title = "Sea 1 Weapons", Box = true, BoxBorder = true, Opened = true })
    
    WeaponSea1Section:Toggle({
        Title = "Auto Saber",
        Value = GetWeapons.Settings["Auto Saber"],
        Callback = function(state)
            GetWeapons.Settings["Auto Saber"] = state
            if state then
                task.spawn(function()
                    while GetWeapons.Settings["Auto Saber"] do
                        GetWeapons.AutoSaber()
                        task.wait(1)
                    end
                end)
            end
        end
    })
    
    WeaponSea1Section:Space()
    
    WeaponSea1Section:Toggle({
        Title = "Auto Pole",
        Value = GetWeapons.Settings["Auto Pole"],
        Callback = function(state)
            GetWeapons.Settings["Auto Pole"] = state
            if state then
                task.spawn(function()
                    while GetWeapons.Settings["Auto Pole"] do
                        GetWeapons.AutoPole()
                        task.wait(1)
                    end
                end)
            end
        end
    })
    
    WeaponSea1Section:Space()
    
    WeaponSea1Section:Toggle({
        Title = "Auto Shark Saw",
        Value = GetWeapons.Settings["Auto Shark Saw"],
        Callback = function(state)
            GetWeapons.Settings["Auto Shark Saw"] = state
            if state then
                task.spawn(function()
                    while GetWeapons.Settings["Auto Shark Saw"] do
                        GetWeapons.AutoSharkSaw()
                        task.wait(1)
                    end
                end)
            end
        end
    })
    
    local WeaponSea2Section = WeaponAcquisitionTab:Section({ Title = "Sea 2 Weapons", Box = true, BoxBorder = true, Opened = false })
    
    WeaponSea2Section:Toggle({
        Title = "Auto Rengoku",
        Value = GetWeapons.Settings["Auto Rengoku"],
        Callback = function(state)
            GetWeapons.Settings["Auto Rengoku"] = state
            if state then
                task.spawn(function()
                    while GetWeapons.Settings["Auto Rengoku"] do
                        GetWeapons.AutoRengoku()
                        task.wait(1)
                    end
                end)
            end
        end
    })
    
    WeaponSea2Section:Space()
    
    WeaponSea2Section:Toggle({
        Title = "Auto Dragon Trident",
        Value = GetWeapons.Settings["Auto Dragon Trident"],
        Callback = function(state)
            GetWeapons.Settings["Auto Dragon Trident"] = state
            if state then
                task.spawn(function()
                    while GetWeapons.Settings["Auto Dragon Trident"] do
                        GetWeapons.AutoDragonTrident()
                        task.wait(1)
                    end
                end)
            end
        end
    })
    
    local WeaponSea3Section = WeaponAcquisitionTab:Section({ Title = "Sea 3 Weapons", Box = true, BoxBorder = true, Opened = false })
    
    WeaponSea3Section:Toggle({
        Title = "Auto Soul Guitar",
        Value = GetWeapons.Settings["Auto Soul Guitar"],
        Callback = function(state)
            GetWeapons.Settings["Auto Soul Guitar"] = state
            if state then
                task.spawn(function()
                    while GetWeapons.Settings["Auto Soul Guitar"] do
                        GetWeapons.AutoSoulGuitar()
                        task.wait(1)
                    end
                end)
            end
        end
    })
    
    WeaponSea3Section:Space()
    
    WeaponSea3Section:Toggle({
        Title = "Auto Yama",
        Value = GetWeapons.Settings["Auto Yama"],
        Callback = function(state)
            GetWeapons.Settings["Auto Yama"] = state
            if state then
                task.spawn(function()
                    while GetWeapons.Settings["Auto Yama"] do
                        GetWeapons.AutoYama()
                        task.wait(1)
                    end
                end)
            end
        end
    })
    
    local StyleSection = WeaponAcquisitionTab:Section({ Title = "Fighting Styles", Box = true, BoxBorder = true, Opened = false })
    
    StyleSection:Toggle({
        Title = "Auto Superhuman",
        Value = GetWeapons.Settings["Auto Super Human"],
        Callback = function(state)
            GetWeapons.Settings["Auto Super Human"] = state
            if state then
                task.spawn(function()
                    while GetWeapons.Settings["Auto Super Human"] do
                        GetWeapons.AutoSuperHuman()
                        task.wait(1)
                    end
                end)
            end
        end
    })
    
    StyleSection:Space()
    
    StyleSection:Toggle({
        Title = "Auto Death Step",
        Value = GetWeapons.Settings["Auto Death Step"],
        Callback = function(state)
            GetWeapons.Settings["Auto Death Step"] = state
            if state then
                task.spawn(function()
                    while GetWeapons.Settings["Auto Death Step"] do
                        GetWeapons.AutoDeathStep()
                        task.wait(1)
                    end
                end)
            end
        end
    })
    
    StyleSection:Space()
    
    StyleSection:Toggle({
        Title = "Auto God Human",
        Value = GetWeapons.Settings["Auto God Human"],
        Callback = function(state)
            GetWeapons.Settings["Auto God Human"] = state
            if state then
                task.spawn(function()
                    while GetWeapons.Settings["Auto God Human"] do
                        GetWeapons.AutoGodHuman()
                        task.wait(1)
                    end
                end)
            end
        end
    })
end


do
    local BossTab = FarmSection:Tab({
        Title = "Boss Farm",
        Desc = "Farm bosses for drops",
        Icon = "solar:sword-bold",
        IconColor = Red,
        IconShape = "Square",
    })
    
    local BossSection = BossTab:Section({ Title = "Boss Settings", Box = true, BoxBorder = true, Opened = true })
    
    BossSection:Toggle({
        Title = "Auto Farm Boss",
        Desc = "Automatically farm selected boss",
        Value = _G.Settings.Boss["Auto Farm Boss"],
        Callback = function(state)
            _G.Settings.Boss["Auto Farm Boss"] = state
            if TaskManager then TaskManager.SetTaskActive("Boss Farm", state) end
            Utils.StopTween(state)
            getgenv().SaveSetting()
        end
    })
    
    BossSection:Space()
    
    BossSection:Dropdown({
        Title = "Select Boss",
        Desc = "Choose boss to farm",
        Values = BossNamesList,
        Value = _G.Settings.Boss["Selected Boss"],
        Callback = function(option)
            _G.Settings.Boss["Selected Boss"] = option
            getgenv().SaveSetting()
        end
    })
    
    BossSection:Space()
    
    BossSection:Toggle({
        Title = "Attack All Bosses",
        Desc = "Attack any boss in the area",
        Value = _G.Settings.Boss["Attack All Bosses"],
        Callback = function(state)
            _G.Settings.Boss["Attack All Bosses"] = state
            getgenv().SaveSetting()
        end
    })
end


do
    local MasteryTab = FarmSection:Tab({
        Title = "Mastery",
        Desc = "Grind weapon mastery",
        Icon = "solar:book-bold",
        IconColor = Purple,
        IconShape = "Square",
    })
    
    local MasterySection = MasteryTab:Section({ Title = "Mastery Grinding", Box = true, BoxBorder = true, Opened = true })
    
    MasterySection:Toggle({
        Title = "Fruit Mastery",
        Desc = "Grind devil fruit mastery",
        Value = _G.Settings.Mastery["Fruit Mastery"],
        Callback = function(state)
            _G.Settings.Mastery["Fruit Mastery"] = state
            local anyMastery = state or _G.Settings.Mastery["Sword Mastery"] or _G.Settings.Mastery["Gun Mastery"] or _G.Settings.Mastery["Melee Mastery"]
            if TaskManager then TaskManager.SetTaskActive("Mastery Farm", anyMastery) end
            getgenv().SaveSetting()
        end
    })
    
    MasterySection:Space()
    
    MasterySection:Toggle({
        Title = "Sword Mastery",
        Desc = "Grind sword weapon mastery",
        Value = _G.Settings.Mastery["Sword Mastery"],
        Callback = function(state)
            _G.Settings.Mastery["Sword Mastery"] = state
            local anyMastery = _G.Settings.Mastery["Fruit Mastery"] or state or _G.Settings.Mastery["Gun Mastery"] or _G.Settings.Mastery["Melee Mastery"]
            if TaskManager then TaskManager.SetTaskActive("Mastery Farm", anyMastery) end
            getgenv().SaveSetting()
        end
    })
    
    MasterySection:Space()
    
    MasterySection:Toggle({
        Title = "Gun Mastery",
        Desc = "Grind gun weapon mastery",
        Value = _G.Settings.Mastery["Gun Mastery"],
        Callback = function(state)
            _G.Settings.Mastery["Gun Mastery"] = state
            local anyMastery = _G.Settings.Mastery["Fruit Mastery"] or _G.Settings.Mastery["Sword Mastery"] or state or _G.Settings.Mastery["Melee Mastery"]
            if TaskManager then TaskManager.SetTaskActive("Mastery Farm", anyMastery) end
            getgenv().SaveSetting()
        end
    })
    
    MasterySection:Space()
    
    MasterySection:Toggle({
        Title = "Melee Mastery",
        Desc = "Grind fighting style mastery",
        Value = _G.Settings.Mastery["Melee Mastery"],
        Callback = function(state)
            _G.Settings.Mastery["Melee Mastery"] = state
            local anyMastery = _G.Settings.Mastery["Fruit Mastery"] or _G.Settings.Mastery["Sword Mastery"] or _G.Settings.Mastery["Gun Mastery"] or state
            if TaskManager then TaskManager.SetTaskActive("Mastery Farm", anyMastery) end
            getgenv().SaveSetting()
        end
    })
    
    MasteryTab:Space()
    
    local MasteryOptionsSection = MasteryTab:Section({ Title = "Mastery Options", Box = true, BoxBorder = true, Opened = true })
    
    MasteryOptionsSection:Toggle({
        Title = "Auto Unequip Accessory",
        Desc = "Remove accessories while grinding",
        Value = _G.Settings.Mastery["Auto Unequip Accessory"],
        Callback = function(state)
            _G.Settings.Mastery["Auto Unequip Accessory"] = state
            getgenv().SaveSetting()
        end
    })
    
    MasteryOptionsSection:Space()
    
    MasteryOptionsSection:Slider({
        Title = "Mastery Health %",
        Desc = "Use skills when enemy HP below this",
        IsTooltip = true,
        Step = 5,
        Value = { Min = 10, Max = 100, Default = _G.Settings.Setting["Mastery Health"] },
        Callback = function(value)
            _G.Settings.Setting["Mastery Health"] = value
        end
    })
    
    MasteryTab:Space()
    
    local FruitSkillSection = MasteryTab:Section({ Title = "Fruit Mastery Skills", Box = true, BoxBorder = true, Opened = true })
    
    local FruitSkillGroup = FruitSkillSection:Group({})
    FruitSkillGroup:Toggle({ Title = "Skill Z", Value = _G.Settings.Setting["Fruit Mastery Skill Z"], Callback = function(s) _G.Settings.Setting["Fruit Mastery Skill Z"] = s end })
    FruitSkillGroup:Space()
    FruitSkillGroup:Toggle({ Title = "Skill X", Value = _G.Settings.Setting["Fruit Mastery Skill X"], Callback = function(s) _G.Settings.Setting["Fruit Mastery Skill X"] = s end })
    FruitSkillGroup:Space()
    FruitSkillGroup:Toggle({ Title = "Skill C", Value = _G.Settings.Setting["Fruit Mastery Skill C"], Callback = function(s) _G.Settings.Setting["Fruit Mastery Skill C"] = s end })
    FruitSkillGroup:Space()
    FruitSkillGroup:Toggle({ Title = "Skill V", Value = _G.Settings.Setting["Fruit Mastery Skill V"], Callback = function(s) _G.Settings.Setting["Fruit Mastery Skill V"] = s end })
    FruitSkillGroup:Space()
    FruitSkillGroup:Toggle({ Title = "Skill F", Value = _G.Settings.Setting["Fruit Mastery Skill F"], Callback = function(s) _G.Settings.Setting["Fruit Mastery Skill F"] = s end })
    
    MasteryTab:Space()
    
    local GunSkillSection = MasteryTab:Section({ Title = "Gun Mastery Skills", Box = true, BoxBorder = true, Opened = true })
    
    local GunSkillGroup = GunSkillSection:Group({})
    GunSkillGroup:Toggle({ Title = "Skill Z", Value = _G.Settings.Setting["Gun Mastery Skill Z"], Callback = function(s) _G.Settings.Setting["Gun Mastery Skill Z"] = s end })
    GunSkillGroup:Space()
    GunSkillGroup:Toggle({ Title = "Skill X", Value = _G.Settings.Setting["Gun Mastery Skill X"], Callback = function(s) _G.Settings.Setting["Gun Mastery Skill X"] = s end })
end


do
    local ItemsTab = FarmSection:Tab({
        Title = "Items",
        Desc = "Collect items and fruits",
        Icon = "solar:box-bold",
        IconColor = Yellow,
        IconShape = "Square",
    })
    
    local ItemsSection = ItemsTab:Section({ Title = "Item Collection", Box = true, BoxBorder = true, Opened = true })
    
    ItemsSection:Toggle({ Title = "Collect Devil Fruit", Desc = "Auto collect devil fruits", Value = _G.Settings.Items["Collect Devil Fruit"], Callback = function(s) _G.Settings.Items["Collect Devil Fruit"] = s; getgenv().SaveSetting() end })
    ItemsSection:Space()
    ItemsSection:Toggle({ Title = "Collect Chest", Desc = "Auto collect treasure chests", Value = _G.Settings.Items["Collect Chest"], Callback = function(s) _G.Settings.Items["Collect Chest"] = s; getgenv().SaveSetting() end })
    ItemsSection:Space()
    ItemsSection:Toggle({ Title = "Collect Flower", Desc = "Auto collect flowers", Value = _G.Settings.Items["Collect Flower"], Callback = function(s) _G.Settings.Items["Collect Flower"] = s; getgenv().SaveSetting() end })
    ItemsSection:Space()
    ItemsSection:Toggle({ Title = "Collect Gun", Desc = "Auto collect gun drops", Value = _G.Settings.Items["Collect Gun"], Callback = function(s) _G.Settings.Items["Collect Gun"] = s; getgenv().SaveSetting() end })
    ItemsSection:Space()
    ItemsSection:Toggle({ Title = "Collect Bones", Desc = "Auto collect bones", Value = _G.Settings.Items["Collect Bones"], Callback = function(s) _G.Settings.Items["Collect Bones"] = s; getgenv().SaveSetting() end })
    ItemsSection:Space()
    ItemsSection:Toggle({ Title = "Auto Store Fruit", Desc = "Store fruits to inventory", Value = _G.Settings.Items["Auto Store Fruit"], Callback = function(s) _G.Settings.Items["Auto Store Fruit"] = s; getgenv().SaveSetting() end })
end


do
    local MaterialsTab = FarmSection:Tab({
        Title = "Materials",
        Desc = "Farm crafting materials",
        Icon = "solar:star-bold",
        IconColor = Cyan,
        IconShape = "Square",
    })
    
    local MaterialsSection = MaterialsTab:Section({ Title = "Material Farming", Box = true, BoxBorder = true, Opened = true })
    
    MaterialsSection:Toggle({ Title = "Auto Farm Ectoplasm", Value = _G.Settings.Materials["Auto Farm Ectoplasm"], Callback = function(s) _G.Settings.Materials["Auto Farm Ectoplasm"] = s end })
    MaterialsSection:Space()
    MaterialsSection:Toggle({ Title = "Auto Farm Fish Tail", Value = _G.Settings.Materials["Auto Farm Fish Tail"], Callback = function(s) _G.Settings.Materials["Auto Farm Fish Tail"] = s end })
    MaterialsSection:Space()
    MaterialsSection:Toggle({ Title = "Auto Farm Magma Ore", Value = _G.Settings.Materials["Auto Farm Magma Ore"], Callback = function(s) _G.Settings.Materials["Auto Farm Magma Ore"] = s end })
    MaterialsSection:Space()
    MaterialsSection:Toggle({ Title = "Auto Farm Dragon Scale", Value = _G.Settings.Materials["Auto Farm Dragon Scale"], Callback = function(s) _G.Settings.Materials["Auto Farm Dragon Scale"] = s end })
    MaterialsSection:Space()
    MaterialsSection:Toggle({ Title = "Auto Farm Scrap Metal", Value = _G.Settings.Materials["Auto Farm Scrap Metal"], Callback = function(s) _G.Settings.Materials["Auto Farm Scrap Metal"] = s end })
    MaterialsSection:Space()
    MaterialsSection:Toggle({ Title = "Auto Farm Vampire Fang", Value = _G.Settings.Materials["Auto Farm Vampire Fang"], Callback = function(s) _G.Settings.Materials["Auto Farm Vampire Fang"] = s end })
    MaterialsSection:Space()
    MaterialsSection:Toggle({ Title = "Auto Farm Mystic Droplet", Value = _G.Settings.Materials["Auto Farm Mystic Droplet"], Callback = function(s) _G.Settings.Materials["Auto Farm Mystic Droplet"] = s end })
    MaterialsSection:Space()
    MaterialsSection:Toggle({ Title = "Auto Farm Bone", Value = _G.Settings.Materials["Auto Farm Bone"], Callback = function(s) _G.Settings.Materials["Auto Farm Bone"] = s end })
    MaterialsSection:Space()
    MaterialsSection:Toggle({ Title = "Auto Farm Leather", Value = _G.Settings.Materials["Auto Farm Leather"], Callback = function(s) _G.Settings.Materials["Auto Farm Leather"] = s end })
end


do
    local SeaEventTab = CombatSection:Tab({
        Title = "Sea Event",
        Desc = "Sea farming features",
        Icon = "solar:water-sun-bold",
        IconColor = Blue,
        IconShape = "Square",
    })
    
    local BoatSection = SeaEventTab:Section({ Title = "Boat Settings", Box = true, BoxBorder = true, Opened = true })
    
    BoatSection:Dropdown({
        Title = "Choose Boat",
        Desc = "Select boat for sailing",
        Values = BoatList,
        Value = _G.Settings.SeaEvent["Selected Boat"],
        Callback = function(option)
            _G.Settings.SeaEvent["Selected Boat"] = option
            getgenv().SaveSetting()
        end
    })
    
    BoatSection:Space()
    
    BoatSection:Dropdown({
        Title = "Choose Zone",
        Desc = "Select farming zone",
        Values = ZoneList,
        Value = _G.Settings.SeaEvent["Selected Zone"],
        Callback = function(option)
            _G.Settings.SeaEvent["Selected Zone"] = option
            getgenv().SaveSetting()
        end
    })
    
    BoatSection:Space()
    
    BoatSection:Slider({
        Title = "Boat Tween Speed",
        Desc = "Boat movement speed",
        IsTooltip = true,
        Step = 10,
        Value = { Min = 50, Max = 350, Default = _G.Settings.SeaEvent["Boat Tween Speed"] },
        Callback = function(value)
            _G.Settings.SeaEvent["Boat Tween Speed"] = value
        end
    })
    
    BoatSection:Space()
    
    BoatSection:Toggle({
        Title = "Sail Boat",
        Desc = "Auto sail and farm sea enemies",
        Value = _G.Settings.SeaEvent["Sail Boat"],
        Callback = function(state)
            _G.Settings.SeaEvent["Sail Boat"] = state
            if TaskManager then TaskManager.SetTaskActive("Sea Events", state) end
            Utils.StopTween(state)
            getgenv().SaveSetting()
        end
    })
    
    SeaEventTab:Space()
    
    local SeaEnemySection = SeaEventTab:Section({ Title = "Sea Enemies", Box = true, BoxBorder = true, Opened = true })
    
    SeaEnemySection:Toggle({ Title = "Auto Farm Shark", Value = _G.Settings.SeaEvent["Auto Farm Shark"], Callback = function(s) _G.Settings.SeaEvent["Auto Farm Shark"] = s end })
    SeaEnemySection:Space()
    SeaEnemySection:Toggle({ Title = "Auto Farm Piranha", Value = _G.Settings.SeaEvent["Auto Farm Piranha"], Callback = function(s) _G.Settings.SeaEvent["Auto Farm Piranha"] = s end })
    SeaEnemySection:Space()
    SeaEnemySection:Toggle({ Title = "Auto Farm Terrorshark", Value = _G.Settings.SeaEvent["Auto Farm Terrorshark"], Callback = function(s) _G.Settings.SeaEvent["Auto Farm Terrorshark"] = s end })
    SeaEnemySection:Space()
    SeaEnemySection:Toggle({ Title = "Auto Farm Fish Crew", Value = _G.Settings.SeaEvent["Auto Farm Fish Crew Member"], Callback = function(s) _G.Settings.SeaEvent["Auto Farm Fish Crew Member"] = s end })
    SeaEnemySection:Space()
    SeaEnemySection:Toggle({ Title = "Auto Farm Ghost Ship", Value = _G.Settings.SeaEvent["Auto Farm Ghost Ship"], Callback = function(s) _G.Settings.SeaEvent["Auto Farm Ghost Ship"] = s end })
    SeaEnemySection:Space()
    SeaEnemySection:Toggle({ Title = "Auto Farm Pirate Brigade", Value = _G.Settings.SeaEvent["Auto Farm Pirate Brigade"], Callback = function(s) _G.Settings.SeaEvent["Auto Farm Pirate Brigade"] = s end })
    SeaEnemySection:Space()
    SeaEnemySection:Toggle({ Title = "Auto Farm Sea Beasts", Value = _G.Settings.SeaEvent["Auto Farm Seabeasts"], Callback = function(s) _G.Settings.SeaEvent["Auto Farm Seabeasts"] = s end })
    
    SeaEventTab:Space()
    
    local SeaSettingsSection = SeaEventTab:Section({ Title = "Sea Settings", Box = true, BoxBorder = true, Opened = true })
    
    SeaSettingsSection:Toggle({ Title = "Lightning (Day)", Value = _G.Settings.SettingSea.Lightning, Callback = function(s) _G.Settings.SettingSea.Lightning = s end })
    SeaSettingsSection:Space()
    SeaSettingsSection:Toggle({ Title = "Increase Boat Speed", Value = _G.Settings.SettingSea["Increase Speed Boat"], Callback = function(s) _G.Settings.SettingSea["Increase Speed Boat"] = s end })
    SeaSettingsSection:Space()
    SeaSettingsSection:Toggle({ Title = "No Clip Rock", Value = _G.Settings.SettingSea["No Clip Rock"], Callback = function(s) _G.Settings.SettingSea["No Clip Rock"] = s end })
    
    SeaEventTab:Space()
    
    local SeaSkillSection = SeaEventTab:Section({ Title = "Sea Combat Skills", Box = true, BoxBorder = true, Opened = true })
    
    SeaSkillSection:Toggle({ Title = "Use Devil Fruit Skill", Value = _G.Settings.SettingSea["Use Devil Fruit Skill"], Callback = function(s) _G.Settings.SettingSea["Use Devil Fruit Skill"] = s end })
    SeaSkillSection:Space()
    SeaSkillSection:Toggle({ Title = "Use Melee Skill", Value = _G.Settings.SettingSea["Use Melee Skill"], Callback = function(s) _G.Settings.SettingSea["Use Melee Skill"] = s end })
    SeaSkillSection:Space()
    SeaSkillSection:Toggle({ Title = "Use Sword Skill", Value = _G.Settings.SettingSea["Use Sword Skill"], Callback = function(s) _G.Settings.SettingSea["Use Sword Skill"] = s end })
    SeaSkillSection:Space()
    SeaSkillSection:Toggle({ Title = "Use Gun Skill", Value = _G.Settings.SettingSea["Use Gun Skill"], Callback = function(s) _G.Settings.SettingSea["Use Gun Skill"] = s end })
end


do
    local SeaStackTab = CombatSection:Tab({
        Title = "Sea Stack",
        Desc = "Sea beast stacking",
        Icon = "solar:layers-bold",
        IconColor = Orange,
        IconShape = "Square",
    })
    
    local SeaStackSection = SeaStackTab:Section({ Title = "Sea Beast Stack", Box = true, BoxBorder = true, Opened = true })
    
    SeaStackSection:Toggle({
        Title = "Tween To Mirage Island",
        Desc = "Move to Mirage Island location",
        Value = _G.Settings.SeaStack["Tween To Mirage Island"],
        Callback = function(state)
            _G.Settings.SeaStack["Tween To Mirage Island"] = state
            Utils.StopTween(state)
            getgenv().SaveSetting()
        end
    })
    
    SeaStackSection:Space()
    
    SeaStackSection:Toggle({
        Title = "Auto Attack Sea Beasts",
        Desc = "Attack sea beasts automatically",
        Value = _G.Settings.SeaStack["Auto Attack Seabeasts"],
        Callback = function(state)
            _G.Settings.SeaStack["Auto Attack Seabeasts"] = state
            Utils.StopTween(state)
            getgenv().SaveSetting()
        end
    })
end


do
    local RaceTab = CombatSection:Tab({
        Title = "Race V4",
        Desc = "Race awakening features",
        Icon = "solar:bolt-bold",
        IconColor = Yellow,
        IconShape = "Square",
    })
    
    local RaceSection = RaceTab:Section({ Title = "Race V4 Settings", Box = true, BoxBorder = true, Opened = true })
    
    RaceSection:Toggle({
        Title = "Auto Race V4",
        Desc = "Automatically complete Race V4",
        Value = _G.Settings.Race["Auto Race V4"],
        Callback = function(state)
            _G.Settings.Race["Auto Race V4"] = state
            if TaskManager then TaskManager.SetTaskActive("Race V4", state) end
            Utils.StopTween(state)
            getgenv().SaveSetting()
        end
    })
    
    RaceSection:Space()
    
    RaceSection:Dropdown({
        Title = "Select Temple",
        Desc = "Choose temple for Race V4",
        Values = TempleList,
        Value = _G.Settings.Race["Selected Temple"],
        Callback = function(option)
            _G.Settings.Race["Selected Temple"] = option
            getgenv().SaveSetting()
        end
    })
    
    RaceSection:Space()
    
    RaceSection:Toggle({ Title = "Temple Night Only", Desc = "Only visit temple at night", Value = _G.Settings.Race["Temple Night Only"], Callback = function(s) _G.Settings.Race["Temple Night Only"] = s end })
    RaceSection:Space()
    RaceSection:Toggle({ Title = "Auto Trials", Desc = "Complete trials automatically", Value = _G.Settings.Race["Auto Trials"], Callback = function(s) _G.Settings.Race["Auto Trials"] = s end })
    RaceSection:Space()
    RaceSection:Toggle({ Title = "Tween To Highest Mirage", Desc = "Move to highest point", Value = _G.Settings.Race["Tween To Highest Mirage"], Callback = function(s) _G.Settings.Race["Tween To Highest Mirage"] = s; Utils.StopTween(s) end })
    RaceSection:Space()
    RaceSection:Toggle({ Title = "Auto Awaken Race", Desc = "Awaken race automatically", Value = _G.Settings.Race["Auto Awaken Race"], Callback = function(s) _G.Settings.Race["Auto Awaken Race"] = s end })
end


do
    local RaidTab = CombatSection:Tab({
        Title = "Raid",
        Desc = "Raid farming features",
        Icon = "solar:shield-bold",
        IconColor = Red,
        IconShape = "Square",
    })
    
    local RaidSection = RaidTab:Section({ Title = "Raid Settings", Box = true, BoxBorder = true, Opened = true })
    
    RaidSection:Toggle({
        Title = "Auto Raid",
        Desc = "Automatically complete raids",
        Value = _G.Settings.Raid["Auto Raid"],
        Callback = function(state)
            _G.Settings.Raid["Auto Raid"] = state
            if TaskManager then TaskManager.SetTaskActive("Raid", state) end
            Utils.StopTween(state)
            getgenv().SaveSetting()
        end
    })
    
    RaidSection:Space()
    
    RaidSection:Dropdown({
        Title = "Select Raid",
        Desc = "Choose raid type",
        Values = RaidList,
        Value = _G.Settings.Raid["Selected Raid"],
        Callback = function(option)
            _G.Settings.Raid["Selected Raid"] = option
            getgenv().SaveSetting()
        end
    })
    
    RaidSection:Space()
    
    RaidSection:Toggle({ Title = "Auto Buy Chip", Desc = "Buy raid chip automatically", Value = _G.Settings.Raid["Auto Buy Chip"], Callback = function(s) _G.Settings.Raid["Auto Buy Chip"] = s end })
    RaidSection:Space()
    RaidSection:Toggle({ Title = "Use Skill In Raid", Desc = "Use skills during raid", Value = _G.Settings.Raid["Use Skill In Raid"], Callback = function(s) _G.Settings.Raid["Use Skill In Raid"] = s end })
end


do
    local ESPTab = UtilitySection:Tab({
        Title = "ESP",
        Desc = "Visual ESP features",
        Icon = "solar:eye-bold",
        IconColor = Green,
        IconShape = "Square",
    })
    
    local ESPSection = ESPTab:Section({ Title = "Visual ESP", Box = true, BoxBorder = true, Opened = true })
    
    ESPSection:Toggle({ Title = "Player ESP", Desc = "Show players through walls", Value = _G.Settings.ESP["Player ESP"], Callback = function(s) _G.Settings.ESP["Player ESP"] = s end })
    ESPSection:Space()
    ESPSection:Toggle({ Title = "NPC ESP", Desc = "Show NPCs through walls", Value = _G.Settings.ESP["NPC ESP"], Callback = function(s) _G.Settings.ESP["NPC ESP"] = s end })
    ESPSection:Space()
    ESPSection:Toggle({ Title = "Devil Fruit ESP", Desc = "Show devil fruits", Value = _G.Settings.ESP["Devil Fruit ESP"], Callback = function(s) _G.Settings.ESP["Devil Fruit ESP"] = s end })
    ESPSection:Space()
    ESPSection:Toggle({ Title = "Chest ESP", Desc = "Show treasure chests", Value = _G.Settings.ESP["Chest ESP"], Callback = function(s) _G.Settings.ESP["Chest ESP"] = s end })
    ESPSection:Space()
    ESPSection:Toggle({ Title = "Flower ESP", Desc = "Show flowers", Value = _G.Settings.ESP["Flower ESP"], Callback = function(s) _G.Settings.ESP["Flower ESP"] = s end })
    ESPSection:Space()
    ESPSection:Toggle({ Title = "Boss ESP", Desc = "Show bosses", Value = _G.Settings.ESP["Boss ESP"], Callback = function(s) _G.Settings.ESP["Boss ESP"] = s end })
    ESPSection:Space()
    ESPSection:Toggle({ Title = "Sea Beast ESP", Desc = "Show sea beasts", Value = _G.Settings.ESP["Sea Beast ESP"], Callback = function(s) _G.Settings.ESP["Sea Beast ESP"] = s end })
end


do
    local TeleportTab = UtilitySection:Tab({
        Title = "Teleport",
        Desc = "Teleportation features",
        Icon = "solar:map-point-bold",
        IconColor = Purple,
        IconShape = "Square",
    })
    
    local TeleportSection = TeleportTab:Section({ Title = "Island Teleport", Box = true, BoxBorder = true, Opened = true })
    
    TeleportSection:Dropdown({
        Title = "Select Island",
        Desc = "Choose island to teleport",
        Values = IslandList,
        Value = _G.Settings.Teleport["Selected Island"],
        Callback = function(option)
            _G.Settings.Teleport["Selected Island"] = option
            getgenv().SaveSetting()
        end
    })
    
    TeleportSection:Space()
    
    TeleportSection:Button({
        Title = "Teleport To Island",
        Icon = "map-pin",
        Color = Blue,
        Justify = "Center",
        Callback = function()
            if Teleport then
                Teleport.TeleportToIsland(_G.Settings.Teleport["Selected Island"])
            end
        end
    })
    
    TeleportTab:Space()
    
    local WorldSection = TeleportTab:Section({ Title = "World Teleport", Box = true, BoxBorder = true, Opened = true })
    
    WorldSection:Dropdown({
        Title = "Select World",
        Desc = "Choose world to teleport",
        Values = WorldList,
        Value = _G.Settings.Main["Teleport World"],
        Callback = function(option)
            _G.Settings.Main["Teleport World"] = option
        end
    })
    
    WorldSection:Space()
    
    WorldSection:Button({
        Title = "Teleport To World",
        Icon = "globe",
        Color = Green,
        Justify = "Center",
        Callback = function()
            if Teleport then
                Teleport.TeleportToWorld(_G.Settings.Main["Teleport World"])
            end
        end
    })
    
    TeleportTab:Space()
    
    local ServerSection = TeleportTab:Section({ Title = "Server Options", Box = true, BoxBorder = true, Opened = true })
    
    local ServerGroup = ServerSection:Group({})
    
    ServerGroup:Button({
        Title = "Server Hop",
        Icon = "refresh-cw",
        Color = Yellow,
        Justify = "Center",
        Callback = function()
            if Teleport then
                Teleport.ServerHop()
            end
        end
    })
    
    ServerGroup:Space()
    
    ServerGroup:Button({
        Title = "Rejoin",
        Icon = "log-in",
        Color = Orange,
        Justify = "Center",
        Callback = function()
            if Teleport then
                Teleport.Rejoin()
            end
        end
    })
end


do
    local PlayerTab = UtilitySection:Tab({
        Title = "Player",
        Desc = "Local player settings",
        Icon = "solar:user-bold",
        IconColor = Cyan,
        IconShape = "Square",
    })
    
    local PlayerSection = PlayerTab:Section({ Title = "Player Settings", Box = true, BoxBorder = true, Opened = true })
    
    PlayerSection:Toggle({
        Title = "Active Race V3",
        Desc = "Auto enable Race V3 transformation",
        Value = _G.Settings.LocalPlayer["Active Race V3"],
        Callback = function(state)
            _G.Settings.LocalPlayer["Active Race V3"] = state
            getgenv().SaveSetting()
        end
    })
    
    PlayerSection:Space()
    
    PlayerSection:Toggle({
        Title = "Active Race V4",
        Desc = "Auto enable Race V4 transformation",
        Value = _G.Settings.LocalPlayer["Active Race V4"],
        Callback = function(state)
            _G.Settings.LocalPlayer["Active Race V4"] = state
            getgenv().SaveSetting()
        end
    })
    
    PlayerSection:Space()
    
    PlayerSection:Toggle({
        Title = "Walk On Water",
        Desc = "Walk on water surface",
        Value = _G.Settings.LocalPlayer["Walk On Water"],
        Callback = function(state)
            _G.Settings.LocalPlayer["Walk On Water"] = state
            getgenv().SaveSetting()
        end
    })
    
    PlayerSection:Space()
    
    PlayerSection:Toggle({
        Title = "No Clip",
        Desc = "Walk through walls and objects",
        Value = _G.Settings.LocalPlayer["No Clip"],
        Callback = function(state)
            _G.Settings.LocalPlayer["No Clip"] = state
            getgenv().SaveSetting()
        end
    })
end


do
    local FruitTab = UtilitySection:Tab({
        Title = "Fruit",
        Desc = "Devil fruit features",
        Icon = "solar:fire-bold",
        IconColor = Red,
        IconShape = "Square",
    })
    
    local FruitSection = FruitTab:Section({ Title = "Devil Fruit", Box = true, BoxBorder = true, Opened = true })
    
    FruitSection:Toggle({ Title = "Auto Random Fruit", Desc = "Buy random fruit from dealer", Value = _G.Settings.Fruit["Auto Buy Random Fruit"], Callback = function(s) _G.Settings.Fruit["Auto Buy Random Fruit"] = s end })
    FruitSection:Space()
    FruitSection:Toggle({ Title = "Auto Store Fruit", Desc = "Store fruits to inventory", Value = _G.Settings.Fruit["Auto Store Fruit"], Callback = function(s) _G.Settings.Fruit["Auto Store Fruit"] = s end })
end


do
    local DragonDojoTab = UtilitySection:Tab({
        Title = "Dragon Dojo",
        Desc = "Dragon Dojo farming",
        Icon = "solar:flame-bold",
        IconColor = Orange,
        IconShape = "Square",
    })
    
    local DragonDojoSection = DragonDojoTab:Section({ Title = "Dragon Dojo", Box = true, BoxBorder = true, Opened = true })
    
    DragonDojoSection:Toggle({
        Title = "Auto Farm Blaze Ember",
        Desc = "Farm Blaze Ember material",
        Value = _G.Settings.DragonDojo["Auto Farm Blaze Ember"],
        Callback = function(state)
            _G.Settings.DragonDojo["Auto Farm Blaze Ember"] = state
        end
    })
    
    DragonDojoSection:Space()
    
    DragonDojoSection:Toggle({
        Title = "Auto Kill Lava Golem",
        Desc = "Kill Lava Golem boss",
        Value = _G.Settings.DragonDojo["Auto Kill Lava Golem"],
        Callback = function(state)
            _G.Settings.DragonDojo["Auto Kill Lava Golem"] = state
        end
    })
    
    DragonDojoSection:Space()
    
    DragonDojoSection:Toggle({
        Title = "Auto Kill Dragon Crew",
        Desc = "Kill Dragon Crew NPCs",
        Value = _G.Settings.DragonDojo["Auto Kill Dragon Crew"],
        Callback = function(state)
            _G.Settings.DragonDojo["Auto Kill Dragon Crew"] = state
        end
    })
    
    DragonDojoSection:Space()
    
    DragonDojoSection:Button({
        Title = "Craft Volcanic Magnet",
        Icon = "hammer",
        Color = Red,
        Justify = "Center",
        Callback = function()
            pcall(function()
                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("CraftItem", "Craft", "Volcanic Magnet")
            end)
            WindUI:Notify({
                Title = "Zlex Hub",
                Content = "Crafting Volcanic Magnet...",
                Icon = "hammer",
                Duration = 3,
            })
        end
    })
end


do
    local ScriptSettingsTab = SettingsSection:Tab({
        Title = "Settings",
        Desc = "Script settings",
        Icon = "solar:settings-bold",
        IconColor = Grey,
        IconShape = "Square",
    })
    
    local GeneralSection = ScriptSettingsTab:Section({ Title = "General Settings", Box = true, BoxBorder = true, Opened = true })
    
    GeneralSection:Toggle({
        Title = "Auto Haki",
        Desc = "Automatically enable Haki",
        Value = _G.Settings.Setting["Auto Haki"],
        Callback = function(state)
            _G.Settings.Setting["Auto Haki"] = state
        end
    })
    
    GeneralSection:Toggle({
        Title = "Attack Aura",
        Desc = "Auto-attack nearby enemies rapidly",
        Value = _G.Settings.Setting["Attack Aura"],
        Callback = function(state)
            _G.Settings.Setting["Attack Aura"] = state
            if Combat then
                Combat.ToggleAttackAura(state)
            end
        end
    })
    
    GeneralSection:Space()
    
    GeneralSection:Slider({
        Title = "Farm Distance",
        Desc = "Distance to maintain from enemies",
        IsTooltip = true,
        Step = 1,
        Value = { Min = 5, Max = 50, Default = _G.Settings.Setting["Farm Distance"] },
        Callback = function(value)
            _G.Settings.Setting["Farm Distance"] = value
        end
    })
    
    ScriptSettingsTab:Space()
    
    local ConfigSection = ScriptSettingsTab:Section({ Title = "Configuration", Box = true, BoxBorder = true, Opened = true })
    
    local ConfigGroup = ConfigSection:Group({})
    
    ConfigGroup:Button({
        Title = "Save Settings",
        Icon = "save",
        Color = Green,
        Justify = "Center",
        Callback = function()
            getgenv().SaveSetting()
            WindUI:Notify({
                Title = "Zlex Hub",
                Content = "Settings saved successfully!",
                Icon = "check",
                Duration = 3,
            })
        end
    })
    
    ConfigGroup:Space()
    
    ConfigGroup:Button({
        Title = "Load Settings",
        Icon = "download",
        Color = Blue,
        Justify = "Center",
        Callback = function()
            getgenv().LoadSetting()
            WindUI:Notify({
                Title = "Zlex Hub",
                Content = "Settings loaded successfully!",
                Icon = "refresh-cw",
                Duration = 3,
            })
        end
    })
    
    ScriptSettingsTab:Space()
    
    local DestroySection = ScriptSettingsTab:Section({ Title = "Script Control", Box = true, BoxBorder = true, Opened = true })
    
    DestroySection:Button({
        Title = "Destroy UI",
        Icon = "x",
        Color = Red,
        Justify = "Center",
        Callback = function()
            Window:Destroy()
        end
    })
end


do
    local AboutTab = SettingsSection:Tab({
        Title = "About",
        Desc = "About Zlex Hub",
        Icon = "solar:info-square-bold",
        IconColor = Blue,
        IconShape = "Square",
    })
    
    local AboutSection = AboutTab:Section({ Title = "About Zlex Hub" })
    
    AboutSection:Section({
        Title = "Zlex Hub v2.0",
        TextSize = 24,
        FontWeight = Enum.FontWeight.Bold,
    })
    
    AboutSection:Space()
    
    AboutSection:Section({
        Title = [[Zlex Hub is a powerful Blox Fruits automation script featuring:
        
- Auto Farm with Quest System
- Boss Farming & Material Collection
- Mastery Grinding (Fruit, Sword, Gun, Melee)
- Sea Events & Sea Beast Farming
- Race V4 Automation
- Raid Farming
- ESP & Teleportation
- Anti-Cheat Bypasses
- TweenService Movement (Safe)]],
        TextSize = 14,
        TextTransparency = .35,
        FontWeight = Enum.FontWeight.Medium,
    })
    
    AboutTab:Space()
    
    AboutTab:Button({
        Title = "Join Discord",
        Icon = "message-circle",
        Color = Color3.fromHex("#5865F2"),
        Justify = "Center",
        Callback = function()
            setclipboard("discord.gg/zlexhub")
            WindUI:Notify({
                Title = "Zlex Hub",
                Content = "Discord invite copied to clipboard!",
                Icon = "clipboard",
                Duration = 3,
            })
        end
    })
end

if AutoFarm then AutoFarm.Start() end
if BossFarm then BossFarm.Start() end
if Mastery then Mastery.Start() end
if Items then Items.Start() end
if Materials then Materials.Start() end
if SeaEvents then SeaEvents.Start() end
if Race then Race.Start() end
if Raid then Raid.Start() end
if ESP then ESP.Start() end
if Teleport then Teleport.Start() end
if Combat then Combat.Start() end
if Misc then Misc.Start() end
if FastAttackModule then FastAttackModule.Start() end
if AntiCheat then AntiCheat.Start() end

WindUI:Notify({
    Title = "Zlex Hub",
    Content = "Script loaded successfully! All modules initialized.",
    Icon = "check-circle",
    Duration = 5,
})

print("[Zlex Hub] Script loaded successfully!")
print("[Zlex Hub] All modules initialized!")
print("[Zlex Hub] Anti-cheat bypasses active!")
print("[Zlex Hub] Using TweenService for safe movement!")
