
local BASE_URL = "https://raw.githubusercontent.com/zzxzsss/moulders/main/Module.lua/bloxfruits/"
local HttpService = game:GetService("HttpService")

if not game:IsLoaded() then
    repeat task.wait() until game:IsLoaded()
end

if setfpscap then
    setfpscap(1000000)
end

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

local function LoadScript(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not success then
        warn("[Loader] Failed: " .. tostring(result))
        return nil
    end
    return result
end

local Modules = {}
local moduleList = {
    "config",
    "utils", 
    "quest-data",
    "auto-farm",
    "boss-farm",
    "mastery",
    "items",
    "materials",
    "sea-events",
    "race",
    "raid",
    "esp",
    "teleport",
    "combat",
    "misc",
    "fast-attack",
    "anti-cheat",
    "task-manager",
    "get-weapons"
}

print("[Zlex Hub] Loading modules...")

for _, name in ipairs(moduleList) do
    Modules[name] = LoadScript(BASE_URL .. name .. ".lua")
    if Modules[name] then
        print("[Loader] Loaded: " .. name)
    end
end

_G.ZlexModules = Modules

if Modules["config"] then
    Modules["config"].Initialize()
    Modules["config"].LoadSettings()
end

local Utils = Modules["utils"]
if Utils then
    if Modules["quest-data"] then Modules["quest-data"].Init(Utils) end
    if Modules["auto-farm"] then Modules["auto-farm"].Init(Utils, Modules["quest-data"]) end
    if Modules["boss-farm"] then Modules["boss-farm"].Init(Utils, Modules["quest-data"]) end
    if Modules["mastery"] then Modules["mastery"].Init(Utils, Modules["quest-data"]) end
    if Modules["items"] then Modules["items"].Init(Utils) end
    if Modules["materials"] then Modules["materials"].Init(Utils) end
    if Modules["sea-events"] then Modules["sea-events"].Init(Utils) end
    if Modules["race"] then Modules["race"].Init(Utils) end
    if Modules["raid"] then Modules["raid"].Init(Utils) end
    if Modules["esp"] then Modules["esp"].Init(Utils) end
    if Modules["teleport"] then Modules["teleport"].Init(Utils) end
    if Modules["combat"] then Modules["combat"].Init(Utils) end
    if Modules["misc"] then Modules["misc"].Init(Utils) end
    if Modules["fast-attack"] then Modules["fast-attack"].Init(Utils) end
    if Modules["anti-cheat"] then 
        Modules["anti-cheat"].Init(Utils) 
        _G.AntiCheat = Modules["anti-cheat"]
    end
    if Modules["task-manager"] then 
        Modules["task-manager"].Init(Utils) 
        _G.TaskManager = Modules["task-manager"]
    end
    if Modules["get-weapons"] then 
        Modules["get-weapons"].Init({Utils = Utils, Config = Modules["config"]}) 
        _G.GetWeapons = Modules["get-weapons"]
    end
end

print("[Zlex Hub] Starting modules...")

for _, name in ipairs(moduleList) do
    if Modules[name] and Modules[name].Start then
        pcall(Modules[name].Start)
    end
end

print("[Zlex Hub] Loading UI...")
LoadScript(BASE_URL .. "main.lua")

print("[Zlex Hub] Script loaded successfully!")
