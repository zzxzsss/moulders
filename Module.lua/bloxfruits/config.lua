
local Config = {}

Config.DefaultSettings = {
    Main = {
        ["Auto Farm"] = false,
        ["Selected Weapon"] = "Melee",
        ["Selected Mode"] = "Auto",
        ["Bring Monster"] = false,
        ["Auto Quest"] = true,
        ["Auto Collect Chest"] = false,
        ["Collect Chest Range"] = 150,
        ["Teleport World"] = "First Sea",
        ["Tween Speed"] = 200,
        ["Farm Selected Monster"] = false,
        ["Selected Monster"] = "",
        ["Low Accuracy Mode"] = false
    },
    Boss = {
        ["Auto Farm Boss"] = false,
        ["Selected Boss"] = "None",
        ["Bypass Boss Quest Teleport"] = false,
        ["Attack All Bosses"] = false
    },
    Mastery = {
        ["Fruit Mastery"] = false,
        ["Sword Mastery"] = false,
        ["Gun Mastery"] = false,
        ["Melee Mastery"] = false,
        ["Auto Unequip Accessory"] = false,
        ["Selected Fruit Mastery"] = "",
        ["Selected Sword Mastery"] = "",
        ["Selected Gun Mastery"] = "",
        ["Selected Melee Mastery"] = ""
    },
    Items = {
        ["Auto Farm Random Fruit"] = false,
        ["Auto Store Fruit"] = false,
        ["Random Fruit Hopserver"] = false,
        ["Collect Devil Fruit"] = false,
        ["Collect Gun"] = false,
        ["Collect Flower"] = false,
        ["Collect Chest"] = false,
        ["Collect Bones"] = false
    },
    Materials = {
        ["Auto Farm Ectoplasm"] = false,
        ["Auto Farm Fish Tail"] = false,
        ["Auto Farm Magma Ore"] = false,
        ["Auto Farm Dragon Scale"] = false,
        ["Auto Farm Scrap Metal"] = false,
        ["Auto Farm Vampire Fang"] = false,
        ["Auto Farm Mystic Droplet"] = false,
        ["Auto Farm Bone"] = false,
        ["Auto Farm Leather"] = false,
        ["Auto Farm Wings"] = false,
        ["Auto Farm Core"] = false
    },
    SeaEvent = {
        ["Sail Boat"] = false,
        ["Selected Boat"] = "Guardian",
        ["Selected Zone"] = "Zone 1",
        ["Boat Tween Speed"] = 200,
        ["Auto Farm Shark"] = false,
        ["Auto Farm Piranha"] = false,
        ["Auto Farm Terrorshark"] = false,
        ["Auto Farm Fish Crew Member"] = false,
        ["Auto Farm Ghost Ship"] = false,
        ["Auto Farm Pirate Brigade"] = false,
        ["Auto Farm Pirate Grand Brigade"] = false,
        ["Auto Farm Seabeasts"] = false
    },
    Race = {
        ["Auto Race V4"] = false,
        ["Selected Temple"] = "None",
        ["Temple Night Only"] = true,
        ["Auto Trials"] = false,
        ["Tween To Highest Mirage"] = false,
        ["Tween To Mirage Island"] = false,
        ["Auto Awaken Race"] = false,
        ["Awaken Race Hopserver"] = false
    },
    Raid = {
        ["Auto Raid"] = false,
        ["Selected Raid"] = "None",
        ["Auto Buy Chip"] = false,
        ["Use Skill In Raid"] = false
    },
    ESP = {
        ["Player ESP"] = false,
        ["NPC ESP"] = false,
        ["Devil Fruit ESP"] = false,
        ["Chest ESP"] = false,
        ["Flower ESP"] = false,
        ["Boss ESP"] = false,
        ["Sea Beast ESP"] = false
    },
    Teleport = {
        ["Selected Island"] = "Starter Island",
        ["Custom Teleport"] = false
    },
    LocalPlayer = {
        ["Active Race V3"] = false,
        ["Active Race V4"] = false,
        ["Walk On Water"] = false,
        ["No Clip"] = false,
        ["Infinite Jump"] = false,
        ["Anti AFK"] = true,
        ["Auto Rejoin"] = false
    },
    Fruit = {
        ["Auto Buy Random Fruit"] = false,
        ["Auto Store Fruit"] = false,
        ["Snipe Fruit"] = false,
        ["Selected Snipe Fruit"] = ""
    },
    Setting = {
        ["Auto Haki"] = true,
        ["Attack Aura"] = false,
        ["Fruit Mastery Skill Z"] = true,
        ["Fruit Mastery Skill X"] = true,
        ["Fruit Mastery Skill C"] = true,
        ["Fruit Mastery Skill V"] = false,
        ["Fruit Mastery Skill F"] = false,
        ["Gun Mastery Skill Z"] = true,
        ["Gun Mastery Skill X"] = true,
        ["Mastery Health"] = 50,
        ["Tween Speed"] = 200,
        ["Farm Distance"] = 10
    },
    SettingSea = {
        ["Lightning"] = false,
        ["Increase Speed Boat"] = false,
        ["No Clip Rock"] = false,
        ["Use Devil Fruit Skill"] = true,
        ["Use Melee Skill"] = true,
        ["Use Sword Skill"] = true,
        ["Use Gun Skill"] = true,
        ["Devil Fruit Z Skill"] = true,
        ["Devil Fruit X Skill"] = true,
        ["Devil Fruit C Skill"] = true,
        ["Devil Fruit V Skill"] = false,
        ["Devil Fruit F Skill"] = false,
        ["Melee Z Skill"] = true,
        ["Melee X Skill"] = true,
        ["Melee C Skill"] = true,
        ["Melee V Skill"] = true
    },
    SeaStack = {
        ["Tween To Mirage Island"] = false,
        ["Auto Attack Seabeasts"] = false
    },
    DragonDojo = {
        ["Auto Farm Blaze Ember"] = false,
        ["Auto Kill Lava Golem"] = false,
        ["Auto Kill Dragon Crew"] = false
    }
}

function Config.DeepCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = Config.DeepCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

function Config.Initialize()
    if not _G.Settings then
        _G.Settings = Config.DeepCopy(Config.DefaultSettings)
    end
    
    for category, settings in pairs(Config.DefaultSettings) do
        if not _G.Settings[category] then
            _G.Settings[category] = {}
        end
        for key, value in pairs(settings) do
            if _G.Settings[category][key] == nil then
                _G.Settings[category][key] = value
            end
        end
    end
end

function Config.SaveSettings()
    local success, err = pcall(function()
        if writefile then
            local HttpService = game:GetService("HttpService")
            local data = HttpService:JSONEncode(_G.Settings)
            writefile("ZlexSettings.json", data)
        end
    end)
    if not success then
        warn("Failed to save settings: " .. tostring(err))
    end
end

function Config.LoadSettings()
    local success, err = pcall(function()
        if readfile and isfile then
            if isfile("ZlexSettings.json") then
                local HttpService = game:GetService("HttpService")
                local data = readfile("ZlexSettings.json")
                local savedSettings = HttpService:JSONDecode(data)
                
                for category, settings in pairs(savedSettings) do
                    if _G.Settings[category] then
                        for key, value in pairs(settings) do
                            _G.Settings[category][key] = value
                        end
                    end
                end
            end
        end
    end)
    if not success then
        warn("Failed to load settings: " .. tostring(err))
    end
end

getgenv().SaveSetting = Config.SaveSettings
getgenv().LoadSetting = Config.LoadSettings

return Config
